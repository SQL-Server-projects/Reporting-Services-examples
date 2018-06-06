Public Sub Main()
    '--------------------------------------------------------------------------------------------------------------------
    ' Purpose:   Script to backup reports from a folder on ReportServer
    '            Save file as .rss extension and run using rs.exe from command line.
    ' Reference: http://bhushan.extreme-advice.com/back-up-of-ssrs-reports-using-rs-utility/
    '			 https://docs.microsoft.com/en-us/sql/reporting-services/tools/rs-exe-utility-ssrs?view=sql-server-2017
    ' Example:   rs -s http://localhost/reportserver -i D:\Scripts\Backup_Reports.rss -e Mgmt2010 -v backupFolder="D:\Scripts\BackupReports" -v parentFolder="/YourReportFolder"
    '            rs -s http://localhost/reportserver -i D:\Scripts\Backup_Reports.rss -e Mgmt2010 -v backupFolder="D:\Scripts\BackupReports" -v parentFolder=""
    '--------------------------------------------------------------------------------------------------------------------
    Try
        rs.Credentials = System.Net.CredentialCache.DefaultCredentials
        Dim items As CatalogItem() = Nothing

        If String.IsNullOrEmpty(parentFolder) Then
            items = rs.ListChildren("/", True)
        Else
            items = rs.ListChildren(parentFolder, False)
        End If

        Console.WriteLine()
        Console.WriteLine("...Reports Back Up Started...")

       For Each item As CatalogItem In items
			If item.TypeName = "Report"
				Console.WriteLine(item.Path)
				Dim reportPath As String = item.Path
				parentFolder = Path.GetDirectoryName(item.Path) ' comment out this line to save the reports in one folder
				Dim reportDefinition As Byte() = rs.GetItemDefinition(item.Path)
				Dim rdlReport As New System.Xml.XmlDocument
				Dim Stream As New MemoryStream(reportDefinition)
				Dim backupPath As String = Path.Combine(backupFolder, Date.Now().ToString("yyyy.MM.dd") + "\" + parentFolder)

				If (Not System.IO.Directory.Exists(backupPath)) Then
					System.IO.Directory.CreateDirectory(backupPath)
				End If

				rdlReport.Load(Stream)
				rdlReport.Save(Path.Combine(backupPath, item.Name + ".rdl"))
				Console.WriteLine(item.Name + ".rdl")
			End If
        Next

        Console.WriteLine("...Reports Back Up Completed...")
        Console.WriteLine()

    Catch e As Exception
        Console.WriteLine(e.Message)

    End Try

End Sub
