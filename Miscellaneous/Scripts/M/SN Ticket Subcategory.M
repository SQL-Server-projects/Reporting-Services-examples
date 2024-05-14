let
    Source = Json.Document(Web.Contents(servicenow_url & "/api/now/table/sc_req_item?sysparm_display_value=true&sysparm_query=sys_class_nameINsc_req_item,incident&assignment_group=" & assignment_group & "&numberISNOTEMPTY&&sysparm_exclude_reference_link=true&sysparm_fields=number%2Cu_request_subcategory")),
    #"Converted to Table" = Record.ToTable(Source),
    #"Expanded List to Column" = Table.ExpandListColumn(#"Converted to Table", "Value"),
    #"Expand Record to Column" = Table.ExpandRecordColumn(#"Expanded List to Column", "Value", {"number", "u_request_subcategory"}, {"number", "u_request_subcategory"}),
    #"Renamed Columns" = Table.RenameColumns(#"Expand Record to Column",{{"u_request_subcategory", "Subcategory"}, {"number", "Ticket Number"}})
in
    #"Renamed Columns"