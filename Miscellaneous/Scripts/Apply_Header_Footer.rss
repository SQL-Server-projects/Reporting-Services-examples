Public Sub Main()
    '--------------------------------------------------------------------------------------------------------------------
    ' Purpose:   Script to apply custom header and footer from a template report to all reports on ReportServer
    ' Notes:     uses Mgmt2010 endpoint / executable against stand alone or SharePoint integrated instance
    '            Save file as .rss extension and run using rs.exe from command line.
    ' Reference: https://jaredzagelbaum.wordpress.com/2014/11/14/update-all-ssrs-reportheaders/
    '			 https://docs.microsoft.com/en-us/sql/reporting-services/tools/rs-exe-utility-ssrs?view=sql-server-2017
    ' Example:   rs -s http://localhost/reportserver -i D:\Scripts\Apply_Header_Footer.rss -e Mgmt2010 -v parentFolder="YourReportFolder"
    '--------------------------------------------------------------------------------------------------------------------
    Dim reportDefinition As Byte() = Nothing
    Dim templateDoc As New System.Xml.XmlDocument
    Dim reportDoc As New System.Xml.XmlDocument
    Dim nsmanager As New XmlNamespaceManager(templateDoc.NameTable)
    Dim templatePath As String = "/_Custom/Template"
    Dim templateHeader As System.Xml.XmlElement = Nothing
    Dim templateFooter As System.Xml.XmlElement = Nothing
    Dim reportHeader As System.Xml.XmlElement = Nothing
    Dim reportFooter As System.Xml.XmlElement = Nothing
    Dim reportPage As System.Xml.XmlElement = Nothing
    nsmanager.AddNamespace("rd", "http://schemas.microsoft.com/sqlserver/reporting/2016/01/reportdefinition")
    Dim items As CatalogItem() = rs.ListChildren("/", True)

    parentFolder = "/" + parentFolder

    Try
        For Each item As CatalogItem In items
            If item.TypeName = "Report" And item.Path = templatePath Then
                reportDefinition = rs.GetItemDefinition(item.Path)
                Dim stream1 As New MemoryStream(reportDefinition)
                templateDoc.Load(stream1)
                stream1.Dispose()
                Exit For
            End If
        Next

        templateHeader = templateDoc.SelectSingleNode("/rd:Report/rd:ReportSections/rd:ReportSection/rd:Page/rd:PageHeader", nsmanager)
        templateFooter = templateDoc.SelectSingleNode("/rd:Report/rd:ReportSections/rd:ReportSection/rd:Page/rd:PageFooter", nsmanager)

        For Each item As CatalogItem In items
            If item.TypeName = "Report" And (item.Path.StartsWith(parentFolder)) And Not (item.Name.StartsWith("SubRep")) Then
                reportDefinition = rs.GetItemDefinition(item.Path)
                Dim stream2 As New MemoryStream(reportDefinition)
                Dim outstream2 As New MemoryStream()
                reportDoc.Load(stream2)
                Console.WriteLine("Report: " + item.Name)
                Console.WriteLine("Report Path: " + item.Path)
                reportHeader = reportDoc.SelectSingleNode("/rd:Report/rd:ReportSections/rd:ReportSection/rd:Page/rd:PageHeader", nsmanager)
                reportFooter = reportDoc.SelectSingleNode("/rd:Report/rd:ReportSections/rd:ReportSection/rd:Page/rd:PageFooter", nsmanager)
                reportPage = reportDoc.SelectSingleNode("/rd:Report/rd:ReportSections/rd:ReportSection/rd:Page", nsmanager)
                Try
                    reportHeader.InnerXml = templateHeader.InnerXml
                    Console.WriteLine("Update Header: " + item.Path)
                Catch ex As NullReferenceException
                    Console.WriteLine("Add Header: " + item.Path)

                    '----------TESTING----------
            		'Dim elem As XmlElement = reportDoc.CreateElement("PageHeader")
					'Dim root As XmlNode = reportDoc.DocumentElement
					'root.AppendChild(elem)
					'reportDoc.Save(outstream2)
					'reportHeader = reportDoc.SelectSingleNode("/rd:Report/rd:ReportSections/rd:ReportSection/rd:Page/rd:PageHeader", nsmanager)
					'reportHeader.InnerXml = templateHeader.InnerXml
					
					'Dim newHeader As XmlNode = reportDoc.ImportNode(templateHeader.InnerXml, True)
					'reportPage.DocumentElement.AppendChild(newHeader)
					'reportDoc.Save(outstream2)
					
					'Dim newHeader As XmlNode = reportDoc.ImportNode(templateHeader.InnerXml, True)
					'reportPage.InsertAfter(templateHeader, reportPage.LastChild) 
					
					'Dim root As XmlNode = reportDoc.DocumentElement
					'root.AppendChild(templateHeader)
					'Dim elem As System.XML.XmlElement = reportDoc.CreateElement("rd:PageHeader")
					'reportDoc.DocumentElement.AppendChild(elem)
					'reportDoc.Save(Console.Out)
					'----------------------------------------------------------------------------------
					'Dim elem As System.XML.XmlElement = reportDoc.CreateElement("rd:PageHeader")
					'Dim docNodes As System.XML.XmlNodeList = reportDoc.LastChild.ChildNodes()

					'For Each node As System.XML.XmlNode In docNodes
					'	If node.Name = "rd:Page" Then
					'		node.AppendChild(elem)
					'	End If
					'Next
					'reportDoc.Save(Console.Out)
                    '----------END TESTING----------
            
                End Try
                Try
                    reportFooter.InnerXml = templateFooter.InnerXml
                    Console.WriteLine("Update Footer: " + item.Path)
                Catch ex As NullReferenceException
                    Console.WriteLine("Add Footer: " + item.Path)
                End Try
                reportDoc.Save(outstream2)
                reportDefinition = outstream2.ToArray()
                rs.SetItemDefinition(item.Path, reportDefinition, Nothing)
                stream2.Dispose()
                outstream2.Dispose()
            End If
        Next

    Catch ex As Exception
        Console.WriteLine(ex.ToString())

    End Try

End Sub
