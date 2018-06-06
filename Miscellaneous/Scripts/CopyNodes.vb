'Orignal idea taken from this blog post : https://jaredzagelbaum.wordpress.com/category/reporting-services/
'Authored by Jared Zagelbaum 11/2014 jaredzagelbaum.wordpress.com
'Authored by Hendrik Groenewald 07/2015 h c g r o e n e w a l d [at] g m a i l . c o m
'Concept extended to be any node replacement, and in addition also copy all children nodes, and all children nodes of target node that are not replaced by template / source node
' PLEASE NOTE : de is given to the default XML namespace [ prefix ] therefore any default nodes need to have //de: as prefix in the XPATH search
'========================================================================================================================================================================
Sub CopyNodes(ByRef TargetDocument As System.Xml.XmlDocument, _
ByRef TargetNode As System.Xml.XmlNode, _
ByRef SourceNode As System.Xml.XmlNode, _
ByVal TargetNameSpaceUri As String, _
ByVal NodeLevel As Integer _
)

'Console.Writeline("")
'Console.Writeline("================================================================================")
'Console.Writeline("Inside CopyNodes procedure ")
'Console.Writeline("TargetDocument : " + TargetDocument.Name)
'Console.Writeline("TargetNode : " + TargetNode.Name)
'Console.Writeline("SourceNode : " + SourceNode.Name)
'Console.Writeline("SourceNodeType : " + SourceNode.NodeType.ToString())
'Console.Writeline("TargetNameSpaceUri : " + TargetNameSpaceUri)
'Console.Writeline("NodeLevel : " + NodeLevel.ToString())
'Console.Writeline("================================================================================")

If NodeLevel 1 Then 'Not the Target Root Node

Dim TargetChildNode As System.Xml.XmlNode = TargetDocument.CreateNode( SourceNode.NodeType, SourceNode.Name , TargetNameSpaceUri )

For Each attr As System.Xml.XmlAttribute in SourceNode.Attributes
Dim newAttr As XmlAttribute = TargetDocument.CreateAttribute(attr.Name)
newAttr.Value = attr.Value
TargetChildNode.Attributes.Append(newAttr)
Next	'For Each attr As System.Xml.XmlAttribute in SourceNode.Attributes

'Console.Writeline(SourceNode.Name.ToString() + " has children : " + SourceNode.HasChildNodes.ToString() )
If SourceNode.FirstChild.NodeType.ToString() = "Text" Or SourceNode.FirstChild.NodeType.ToString() = "CDATA" Then
TargetChildNode.InnerText = SourceNode.InnerText
End if

'Console.Writeline("Append Child Node to TargetNode : " + TargetNode.Name)
TargetNode.AppendChild(TargetChildNode)

For Each childNode As System.Xml.XmlNode in SourceNode.ChildNodes
If childNode IsNot Nothing And _
( childNode.NodeType.ToString() = "Element") _
Then
CopyNodes(TargetDocument, TargetChildNode, childNode, TargetNameSpaceUri, NodeLevel + 1 )
End If
Next

Else

If Not SourceNode.HasChildNodes Then
TargetNode.InnerText = SourceNode.InnerText
End if

For Each attr As System.Xml.XmlAttribute in SourceNode.Attributes
Dim newAttr As XmlAttribute = TargetDocument.CreateAttribute(attr.Name)
newAttr.Value = attr.Value
TargetNode.Attributes.Append(newAttr)
Next	'For Each attr As System.Xml.XmlAttribute in SourceNode.Attributes

For Each childNode As System.Xml.XmlNode in SourceNode.ChildNodes
If childNode IsNot Nothing And _
( childNode.NodeType.ToString() = "Element") _
Then
CopyNodes(TargetDocument, TargetNode, childNode, TargetNameSpaceUri, NodeLevel + 1 )
End If
Next

End If

End Sub

'========================================================================================================================================================================

Sub CopyRemainingChildNodes (	ByRef TargetDocument As System.Xml.XmlDocument, _
ByRef TargetNode As System.Xml.XmlNode, _
ByRef SourceNode As System.Xml.XmlNode, _
ByVal TargetNameSpaceUri As String, _
ByVal NodeLevel As Integer _
)

Dim NodeExistsInTarget As Boolean = False

For Each SourceChildNode As System.Xml.XmlNode in SourceNode.ChildNodes

NodeExistsInTarget = false

For Each TargetChildNode As System.Xml.XmlNode in TargetNode.ChildNodes
If TargetChildNode.Name = SourceChildNode.Name Then
NodeExistsInTarget = true
End if
Next

If Not NodeExistsInTarget Then
'Console.Writeline("Node found in Source that is not in Target : " + )
CopyNodes(TargetDocument, TargetNode, SourceChildNode, TargetNameSpaceUri, NodeLevel)
End If

Next

End Sub

'========================================================================================================================================================================

Sub Main()

Dim ScriptLoggingLocation as String = "E:\SSRS_Updates\ReportEditing_Update_Logo.log"
Dim ScriptLoggingReportsWithoutImages As String = "E:\SSRS_Updates\ReportsWithoutImages.log"

Dim SourceItemName As String = "Capfin_Report_Template"	'Source Report Name
Dim SourceNodeDefinition As String = "//de:Image[@Name=""LogoName""]" 'XPATH for SourceNode

Dim DestinationItemsDefinition As String = ""
Dim DestinationNodeDefinition As String = "//de:Image[@Name=""Image1?" or @Name=""Image2?"]"

Dim docDestination As New System.Xml.XmlDocument
Dim docSource As New System.Xml.XmlDocument
Dim nsmanagerdocSource As New XmlNamespaceManager(docSource.NameTable)

Dim sourceNode As System.Xml.XmlNode
'Dim destinationNode As System.Xml.XmlNode
Dim reportDefinition As Byte() = Nothing

'ReportItems
Dim items As CatalogItem() = rs.ListChildren("/", True)

'Find Source Document and Node
For Each item As CatalogItem In items
If item.TypeName = "Report" And item.Name = SourceItemName Then
Console.Writeline("Found template")

reportDefinition = rs.GetItemDefinition(item.Path)
Dim stream As New MemoryStream(reportDefinition)
docSource.Load(stream)

'Add all Report NameSpaces to SourceNameSpaceManager

Dim SourceNameSpace_Prefix as String = String.Empty
For Each attr As System.Xml.XmlAttribute in docSource.DocumentElement.Attributes
if attr.Name.Contains("xmlns") Then
'Console.Writeline(attr.LocalName)
'Console.Writeline(attr.Name)
'Console.Writeline(attr.Prefix)
'Console.Writeline(attr.InnerText)
'Console.Writeline("==============")
'Console.Writeline("")

If attr.LocalName = "xmlns" Then
'SourceNameSpace_Prefix = String.Empty
SourceNameSpace_Prefix = "de"
Else
SourceNameSpace_Prefix = attr.LocalName
End If

nsmanagerdocSource.AddNamespace(SourceNameSpace_Prefix,attr.InnerText)
End If
Next

Console.Writeline("Source Node Search Criteria : " + SourceNodeDefinition)

'Load SourceNode into XmlNode
sourceNode = docSource.SelectSingleNode(SourceNodeDefinition, nsmanagerdocSource)

Exit For
End If	'If item.TypeName = "Report" And item.Name = SourceItemName Then
Next	'For Each item As CatalogItem In items

If sourceNode IsNot Nothing Then

Console.Writeline("SourceNode Found and loaded")

'Loop through all Reports in Calalog
Console.Writeline("Loop through all Destination Items / Reports")

For Each item As CatalogItem In items
If item.TypeName = "Report" _
And item.Name SourceItemName _
Then

Console.Writeline(item.Path)

reportDefinition = rs.GetItemDefinition(item.Path)

Dim stream As New MemoryStream(reportDefinition)
Dim outstream As New MemoryStream()

docDestination.Load(stream)

Dim nsmanagerdocDestination As New XmlNamespaceManager(docDestination.NameTable)

Dim DestinationNameSpace_Prefix as String = String.Empty
Dim DestinationDefaultNameSpaceUri as String = ""

For Each attr As System.Xml.XmlAttribute in docDestination.DocumentElement.Attributes
if attr.Name.Contains("xmlns") Then

If attr.LocalName = "xmlns" Then

'Console.Writeline(attr.LocalName)
'Console.Writeline(attr.Name)
'Console.Writeline(attr.Prefix)
'Console.Writeline(attr.InnerText)
'Console.Writeline("==============")
'Console.Writeline("")

'DestinationNameSpace_Prefix = String.Empty
DestinationNameSpace_Prefix = "de"
DestinationDefaultNameSpaceUri = attr.InnerText
Else
DestinationNameSpace_Prefix = attr.LocalName
End If

'Console.Writeline("Adding Namespace to manager " + DestinationNameSpace_Prefix )
nsmanagerdocDestination.AddNamespace(DestinationNameSpace_Prefix,attr.InnerText)

'Console.Writeline("Namespace Added : " + DestinationNameSpace_Prefix )
'Console.Writeline("")

End If	'if attr.Name.Contains("xmlns") Then
Next	'For Each attr As System.Xml.XmlAttribute in docDestination.DocumentElement.Attributes

'Create ReplacementNodeTemplate
Dim ReplacementNodeTemplate As System.Xml.XmlNode = docDestination.CreateNode( sourceNode.NodeType, sourceNode.Name , DestinationDefaultNameSpaceUri )

CopyNodes(docDestination, ReplacementNodeTemplate, sourceNode, DestinationDefaultNameSpaceUri, 1)

'Locate all Matching Destination Nodes
For Each DestinationNode as XmlNode in docDestination.SelectNodes(DestinationNodeDefinition, nsmanagerdocDestination)

Dim DestinationNodeValue_Text As String = ""

For NodeCounter As Integer = 0 To (DestinationNode.ChildNodes.Count-1)
if DestinationNode.ChildNodes(NodeCounter).Name = "Value" Then
DestinationNodeValue_Text = DestinationNode.ChildNodes(NodeCounter).InnerText
Exit For
End If
Next

'If DestinationNodeValue IsNot Nothing Then
'	Dim DestinationNodeValue_Text = DestinationNodeValue.InnerText

If DestinationNodeValue_Text = "capfin_logo" _
or DestinationNodeValue_Text = "CapfinLogo" _
or DestinationNodeValue_Text = "CapfinLogo_New" _
or DestinationNodeValue_Text = "CapfinLogo2" _
or DestinationNodeValue_Text = "SmartLogo" _
Then

'ScriptLoggingLocation
Console.Writeline(item.Path + " : Matching Node Found : " + DestinationNode.Attributes("Name").Value.ToString())
File.AppendAllText(ScriptLoggingLocation, DateTime.Now.ToString() + " : " + item.Path + " : Matching Node Found : " + DestinationNode.Attributes("Name").Value.ToString() + Environment.NewLine)

'Identify ParentNode – Replace DestinationNode with ReplacementNode
Dim DestinationParentNode As System.Xml.XmlNode = DestinationNode.ParentNode

Dim ReplacementNode As System.Xml.XmlNode = ReplacementNodeTemplate

'Copy Target Children Nodes, which are not part of Source Node
CopyRemainingChildNodes(docDestination, ReplacementNode, DestinationNode, DestinationDefaultNameSpaceUri, 2)

'Console.Writeline(DestinationParentNode.Name)
Console.Writeline(item.Path + " : Replace DestinationNode with ReplacementNode : " + DestinationNode.Attributes("Name").Value.ToString() )
DestinationParentNode.ReplaceChild( ReplacementNode ,DestinationNode)

'If The SourceNode is an Image with External Source, replacing an embedded image within report, remove embedded image, check if last Embedded image,if so remove ParentNode as well
If ReplacementNode.Name = "Image" And ReplacementNode.ChildNodes(0).InnerText = "External" And DestinationNode.ChildNodes(0).InnerText = "Embedded" Then

Dim ImageEmbeddedSourceName as String = ""

For NodeCounter As Integer = 0 To (DestinationNode.ChildNodes.Count-1)
if DestinationNode.ChildNodes(NodeCounter).Name = "Value" Then
ImageEmbeddedSourceName = DestinationNode.ChildNodes(NodeCounter).InnerText
Exit For
End If
Next

Console.Writeline(DestinationNode.Attributes("Name").Value.ToString() + " : ImageEmbeddedSourceName : " + ImageEmbeddedSourceName)

Dim EmbeddedImageNode_Criteria AS String = "//de:EmbeddedImage[@Name=""" + ImageEmbeddedSourceName + """]"

Dim EmbeddedImageNode As System.Xml.XmlNode = docDestination.SelectSingleNode(EmbeddedImageNode_Criteria, nsmanagerdocDestination)

If EmbeddedImageNode IsNot Nothing Then

If EmbeddedImageNode.ParentNode.ChildNodes.Count > 1 Then

Console.Writeline(item.Path + " : Only Removed Embedded Image : " + ImageEmbeddedSourceName)
'File.AppendAllText(ScriptLoggingLocation, item.Path + " : Only Removed Embedded Image : " + ImageEmbeddedSourceName + Environment.NewLine)

EmbeddedImageNode.ParentNode.RemoveChild(EmbeddedImageNode)
Else
Console.Writeline(item.Path + " : Removed Embedded Image + Parent Node : " + ImageEmbeddedSourceName)
'File.AppendAllText(ScriptLoggingLocation, item.Path + " : Removed Embedded Image + Parent Node : " + ImageEmbeddedSourceName + Environment.NewLine)

Dim EmbeddedImageNodeParentNode As System.Xml.XmlNode = EmbeddedImageNode.ParentNode

EmbeddedImageNode.ParentNode.RemoveChild(EmbeddedImageNode)
EmbeddedImageNodeParentNode.ParentNode.RemoveChild(EmbeddedImageNodeParentNode)

End If

End If

End if

End if
'End if
Next	'For Each DestinationNode as XmlNode in docDestination.SelectNodes(DestinationNodeDefinition, nsmanagerdocDestination)

docDestination.Save(outstream)
reportDefinition = outstream.ToArray()
rs.SetItemDefinition(item.Path, reportDefinition, Nothing)

stream.Dispose()
outstream.Dispose()

End If	'If item.TypeName = "Report" And Item.Name SourceItemName Then
Next	'For Each item As CatalogItem In items

Else
Console.Writeline("SourceNode is Nothing")
End if	'If sourceNode IsNot Nothing Then

End Sub