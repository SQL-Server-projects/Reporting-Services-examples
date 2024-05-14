let
    Source = Json.Document(Web.Contents(servicenow_url & "/api/now/table/task?sysparm_query=sys_class_nameINsc_req_item,incident&assignment_group=" & assignment_group & "&numberISNOTEMPTY&sysparm_exclude_reference_link=true&sysparm_fields=sys_id%2Cactive%2Capproval_set%2Cclosed_at%2Cdue_date%2Cnumber%2Copened_at%2Cshort_description%2Csla_due%2Csys_class_name%2Csys_created_on%2Csys_updated_on%2Cu_service_area%2Curgency%2Cdescription%2Cassignment_group%2Cu_requestor%2Cassigned_to%2Cstate%2Cu_affected_user%2Cu_request_subcategory")),
    #"Converted to Table" = Record.ToTable(Source),
    #"Expanded List to Column" = Table.ExpandListColumn(#"Converted to Table", "Value"),
    #"Expand Record to Column" = Table.ExpandRecordColumn(#"Expanded List to Column", "Value", {"source", "sys_id", "u_affected_user", "u_requestor"})
in
    #"Expand Record to Column"