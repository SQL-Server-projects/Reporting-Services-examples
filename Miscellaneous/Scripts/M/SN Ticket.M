//set the parameter "servicenow_url" e.g https://your_company.service-now.com/
// * NOTE: all M files with the prefix SN are required to run this query 

let
    // Rest API connection will time out if the return recordset it to large. Edit the column list here and in the "Expand Record to Column" step.
    // To build this script go to your instance /nav_to.do?uri=%2F$restapi.do
    Source = Json.Document(Web.Contents(servicenow_url & "/api/now/table/task?sysparm_limit=1000000&sysparm_display_value=true&sysparm_query=sys_class_nameINsc_req_item,incident&assignment_group=" & assignment_group & "&sys_created_on>=2020-07-01&numberISNOTEMPTY&sysparm_exclude_reference_link=true&sysparm_fields=sys_id%2Cactive%2Capproval_set%2Cclosed_at%2Cdue_date%2Cnumber%2Copened_at%2Cshort_description%2Csla_due%2Csys_class_name%2Csys_created_on%2Csys_updated_on%2Cu_service_area%2Curgency%2Cassignment_group%2Cu_requestor%2Cassigned_to%2Cstate%2Cu_affected_user%2Cdescription%2Cu_request_subcategory")),
    //Source = Json.Document(Web.Contents(servicenow_url & "/api/now/table/task?sysparm_limit=1000000&sysparm_display_value=true&sysparm_query=sys_class_nameINsc_req_item,incident&assignment_groupINSalesForce,SalesForce Development&numberISNOTEMPTY&sysparm_exclude_reference_link=true&sysparm_fields=sys_id,active,approval_set,closed_at,due_date,number,opened_at,short_description,sla_due,sys_class_name,sys_created_on,sys_updated_on,u_service_area,urgency,assignment_group,u_requestor,assigned_to,state,u_affected_user,u_request_subcategory")),
    #"Converted to Table" = Record.ToTable(Source),
    #"Expanded List to Column" = Table.ExpandListColumn(#"Converted to Table", "Value"),
    #"Expand Record to Column" = Table.ExpandRecordColumn(#"Expanded List to Column", "Value", {"sys_id", "active", "approval_set", "closed_at", "due_date", "number", "opened_at", "short_description", "description", "sla_due", "sys_class_name", "sys_created_on", "sys_updated_on", "u_service_area", "urgency", "assignment_group","u_requestor", "assigned_to", "state", "u_affected_user", "u_request_subcategory"}, {"sys_id", "active", "approval_set", "closed_at", "due_date", "number", "opened_at", "short_description", "description", "sla_due", "sys_class_name", "sys_created_on", "sys_updated_on", "u_service_area", "urgency", "assignment_group", "u_requestor","assigned_to", "state", "u_affected_user", "u_request_subcategory"}),
    #"Replaced UNKNOWN" = Table.ReplaceValue(#"Expand Record to Column","UNKNOWN","",Replacer.ReplaceText,{"sla_due"}),
    #"Changed Type DateTime" = Table.TransformColumnTypes(#"Replaced UNKNOWN",{{"closed_at", type datetime}, {"due_date", type datetime}, {"opened_at", type datetime}, {"sys_created_on", type datetime}, {"sys_updated_on", type datetime}, {"sla_due", type datetime}, {"approval_set", type datetime}}),
    #"Changed Type Date" = Table.TransformColumnTypes(#"Changed Type DateTime",{{"sys_created_on", type date}}),
    #"Replaced Value Active" = Table.ReplaceValue(#"Changed Type Date",each [active],each if [active] = "false" or [state] = "Cancelled" or [state] = "Closed" or [state] = "Completed" or [state] = "Resolved" or [state] = "Resolved Pending Confirmation" then "Closed" else "Open",Replacer.ReplaceValue,{"active"}),
    #"Replaced Value Closed Date" = Table.ReplaceValue(#"Replaced Value Active",each [closed_at], each if [closed_at] = null and [active] = "Closed" then [sys_updated_on] else if [closed_at] <> null and Date.AddDays([closed_at], closed_date_offset) > [sys_created_on] then Date.AddDays([closed_at], -3) else [closed_at], Replacer.ReplaceValue,{"closed_at"}),
    #"Changed Type Date for Created Date" = Table.TransformColumnTypes(#"Replaced Value Closed Date" ,{{"closed_at", type date}}),
    #"Duplicated Column sys_class_name" = Table.DuplicateColumn(#"Changed Type Date for Created Date", "sys_class_name", "sys_class_name_org"),
    #"Replaced Value sys_class_name Requested Item" = Table.ReplaceValue(#"Duplicated Column sys_class_name","Requested Item","sc_req_item",Replacer.ReplaceText,{"sys_class_name_org"}),
    #"Replaced Value sys_class_name Incident" = Table.ReplaceValue(#"Replaced Value sys_class_name Requested Item","Incident","incident",Replacer.ReplaceText,{"sys_class_name_org"}),
    #"Create Hyperlink" = Table.AddColumn(#"Replaced Value sys_class_name Incident", "ticket_url", each servicenow_url & "nav_to.do?uri=" & [sys_class_name_org] & ".do?sysparm_query=number=" & [number]),
    #"Replaced Missing Assigned" = Table.ReplaceValue(#"Create Hyperlink","","<Blank>",Replacer.ReplaceValue,{"assigned_to"}),
    #"Replaced Missing Urgency" = Table.ReplaceValue(#"Replaced Missing Assigned","","<Blank>",Replacer.ReplaceValue,{"urgency"}),
    #"Replaced Urgency Number to Text" = Table.ReplaceValue(#"Replaced Missing Urgency","(4)","Planned",Replacer.ReplaceText,{"urgency"}),
    #"Renamed Columns" = Table.RenameColumns(#"Replaced Urgency Number to Text",{{"closed_at", "Closed Date"}, {"due_date", "Due Date"}, {"opened_at", "Opened Date"}, {"short_description", "Ticket Description"}, {"number", "Ticket Number"}, {"sla_due", "SLA Date"}, {"approval_set", "Approval Date"}, {"sys_class_name", "Ticket Type"}, {"ticket_url", "URL"}, {"u_service_area", "Service Area"}, {"urgency", "Urgency"}, {"sys_created_on", "Created Date"}, {"sys_updated_on", "Updated Date"}, {"assignment_group", "Assignment Group"}, {"assigned_to", "Assigned To"}, {"u_requestor", "Requested By"}, {"state", "Status"}, {"active", "Status Group"}, {"u_affected_user", "Affected User"}}),
    #"Added Website" = Table.AddColumn(#"Renamed Columns", "servicenow_url", each servicenow_url),
    #"Changed Type Date for Updated Date" = Table.TransformColumnTypes(#"Added Website",{{"Updated Date", type date}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Changed Type Date for Updated Date","Requested Item","Request",Replacer.ReplaceText,{"Ticket Type"}),
    #"Removed Columns" = Table.RemoveColumns(#"Replaced Value1",{"u_request_subcategory"}),
    #"Merged Queries" = Table.NestedJoin(#"Removed Columns", {"Ticket Number"}, #"SN Ticket Subcategory", {"Ticket Number"}, "Ticket Subcategory", JoinKind.LeftOuter),
    #"Expanded Ticket Subcategory" = Table.ExpandTableColumn(#"Merged Queries", "Ticket Subcategory", {"Subcategory"}, {"Ticket Subcategory.Subcategory"}),
    #"Replaced Value" = Table.ReplaceValue(#"Expanded Ticket Subcategory",null,"Other",Replacer.ReplaceValue,{"Ticket Subcategory.Subcategory"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Replaced Value",{{"Ticket Subcategory.Subcategory", "Subcategory"}}),
    #"Merged Queries1" = Table.NestedJoin(#"Renamed Columns1", {"sys_id"}, #"SN Ticket Id", {"sys_id"}, "Ticket Ids", JoinKind.LeftOuter),
    #"Expanded Ticket Ids" = Table.ExpandTableColumn(#"Merged Queries1", "Ticket Ids", {"u_affected_user", "u_requestor"}, {"Ticket Ids.u_affected_user", "Ticket Ids.u_requestor"}),
    #"Merged Queries2" = Table.NestedJoin(#"Expanded Ticket Ids", {"Ticket Ids.u_affected_user"}, #"SN Ticket User", {"sys_id"}, "User Service Now", JoinKind.LeftOuter),
    #"Expanded User Service Now" = Table.ExpandTableColumn(#"Merged Queries2", "User Service Now", {"user_name"}, {"User Service Now.user_name"}),
    #"Renamed Columns2" = Table.RenameColumns(#"Expanded User Service Now",{{"User Service Now.user_name", "Affected Email"}}),
    #"Merged Queries3" = Table.NestedJoin(#"Renamed Columns2", {"Ticket Ids.u_requestor"}, #"SN Ticket User", {"sys_id"}, "User Service Now", JoinKind.LeftOuter),
    #"Expanded User Service Now1" = Table.ExpandTableColumn(#"Merged Queries3", "User Service Now", {"user_name"}, {"User Service Now.user_name"}),
    #"Renamed Columns3" = Table.RenameColumns(#"Expanded User Service Now1",{{"User Service Now.user_name", "Requestor Email"}}),
    #"Removed Columns1" = Table.RemoveColumns(#"Renamed Columns3",{"Ticket Ids.u_affected_user", "Ticket Ids.u_requestor"}),
    #"Renamed Columns4" = Table.RenameColumns(#"Removed Columns1",{{"description", "Ticket Description"}, {"Ticket Description", "Ticket Subject"}}),
    #"Replaced Value2" = Table.ReplaceValue(#"Renamed Columns4","Please provide any other details relevant to this request = ","",Replacer.ReplaceText,{"Ticket Description"}),
    #"Renamed Columns5" = Table.RenameColumns(#"Replaced Value2",{{"Ticket Subject", "Ticket Title"}})
in
    #"Renamed Columns5"