//set the parameter "source_control_org_url" e.g https://dev.azure.com/YourOrganziation/YourProject

let
    Source = VSTS.Contents(source_control_org_url & "/_apis/tfvc/changesets?api-version=6.0"),
    #"Imported JSON" = Table.FromRecords(Json.Document(Source,65001)[value]),
    checkedInBy = Table.ExpandRecordColumn(#"Imported JSON", "checkedInBy", {"displayName", "uniqueName"}, { "Checked In Name", "Checked In Email"}),
    #"Added Custom" = Table.AddColumn(checkedInBy, "Created DateTime", each DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(DateTime.AddZone(DateTime.From([createdDate]),12), -12))),
    #"Removed Columns" = Table.RemoveColumns(#"Added Custom",{"author", "createdDate"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"comment", "Comment"}, {"changesetId", "Id"}}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Renamed Columns", "url", "url - Copy"),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Duplicated Column", "url - Copy", Splitter.SplitTextByDelimiter("/", QuoteStyle.Csv), {"url - Copy.1", "url - Copy.2", "url - Copy.3", "url - Copy.4", "url - Copy.5", "url - Copy.6", "url - Copy.7", "url - Copy.8", "url - Copy.9"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"url - Copy.1", type text}, {"url - Copy.2", type text}, {"url - Copy.3", type text}, {"url - Copy.4", type text}, {"url - Copy.5", type text}, {"url - Copy.6", type text}, {"url - Copy.7", type text}, {"url - Copy.8", type text}, {"url - Copy.9", Int64.Type}}),
    #"Removed Columns1" = Table.RemoveColumns(#"Changed Type",{"url - Copy.1", "url - Copy.2", "url - Copy.3", "url - Copy.6", "url - Copy.7", "url - Copy.8", "url - Copy.9"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns1",{{"url - Copy.4", "Organization"}, {"url - Copy.5", "Project"}}),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Renamed Columns1", "Created DateTime", "Created DateTime - Copy"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Duplicated Column1",{{"Created DateTime - Copy", type date}}),
    #"Renamed Columns2" = Table.RenameColumns(#"Changed Type1",{{"Created DateTime - Copy", "Created Date"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns2",{"Id", "url", "Checked In Name", "Checked In Email", "Comment", "Created Date", "Created DateTime", "Organization", "Project"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Reordered Columns",{{"Created DateTime", type datetime}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type2","/_apis/tfvc/changesets/","/_versionControl/changeset/",Replacer.ReplaceText,{"url"})
in
    #"Replaced Value"