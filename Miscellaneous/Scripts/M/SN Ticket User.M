let
    Source = Json.Document(Web.Contents(servicenow_url & "/api/now/table/sys_user")),
    #"Converted to Table" = Record.ToTable(Source),
    #"Expanded List to Column" = Table.ExpandListColumn(#"Converted to Table", "Value"),
    #"Expand Record to Column" = Table.ExpandRecordColumn(#"Expanded List to Column", "Value", {"sys_created_on", "sys_id", "user_name"}),
    #"Lowercased Text" = Table.TransformColumns(#"Expand Record to Column",{{"user_name", Text.Lower, type text}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Lowercased Text",{{"sys_created_on", type datetime}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Name"})
in
    #"Removed Columns"