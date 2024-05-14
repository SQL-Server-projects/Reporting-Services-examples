//Active Directory list of users, set the parameter "domain_name"

let
    Source = ActiveDirectory.Domains(domain_name),
    domain_name = Source{[Domain=domain_name]}[#"Object Categories"],
    user1 = domain_name{[Category="user"]}[Objects],
    #"Removed Other Columns" = Table.SelectColumns(user1,{"organizationalPerson", "displayName"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Removed Other Columns",{"displayName", "organizationalPerson"}),
    #"Expanded organizationalPerson1" = Table.ExpandRecordColumn(#"Reordered Columns", "organizationalPerson", {"mail", "thumbnailPhoto", "title", "department"}, { "User Email", "thumbnailPhoto", "title", "department"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded organizationalPerson1",{{"thumbnailPhoto", type text}}),
    #"Added Prefix" = Table.TransformColumns(#"Changed Type", {{"thumbnailPhoto", each "data:image/jpeg;base64," & _, type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Added Prefix", each ([thumbnailPhoto] <> null)),
    #"Removed Duplicates" = Table.Distinct(#"Filtered Rows", {"User Email"}),
    #"Filtered Rows1" = Table.SelectRows(#"Removed Duplicates", each ([User Email] <> null and [User Email] <> "-")),
    #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows1",{{"displayName", "User_Full_Name"}, {"User Email", "User_Email"}, {"thumbnailPhoto", "User_Photo"}, {"department", "Department"}, {"title", "Title"}})
in
    #"Renamed Columns"