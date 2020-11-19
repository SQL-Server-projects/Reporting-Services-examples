Public Function GetParameterandValues(ByVal ServerName As String, ByVal ReportServerDBName As String, ByVal ReportName As String, ByVal ReportParameters As Parameters) As String

    Try

        Dim ConnStr As String
        Dim SQL As String

        Dim Param As Parameter
        Dim ParameterOutput As String
        Dim ParameterName As String
        Dim ParameterValue As String
        Dim ParameterLabel As String

        Dim SQLConn As System.Data.SqlClient.SqlConnection
        Dim SQLCmd As System.Data.SqlClient.SqlCommand
        Dim SQLRdr As System.Data.SqlClient.SqlDataReader

        ParameterOutput = ""
        ParameterName = ""
        ParameterValue = ""
        ParameterLabel = ""

        ConnStr = "Data Source=" + ServerName + ";Initial Catalog=" + ReportServerDBName + ";Integrated Security=SSPI;"

        SQLConn = New System.Data.SqlClient.SqlConnection()
        SQLCmd = New System.Data.SqlClient.SqlCommand()

        SQLConn.ConnectionString = ConnStr
        SQLConn.Open()

        SQL = "SELECT  Name = Paravalue.value('Name[1]', 'VARCHAR(250)') FROM (SELECT C.Name,CONVERT(XML,C.Parameter) AS ParameterXML FROM  ReportServer.dbo.Catalog C  WHERE  C.Content is not null  AND  C.Type  = 2  AND  C.Name  = '" + ReportName + "') a  CROSS APPLY ParameterXML.nodes('//Parameters/Parameter') p ( Paravalue )"
        SQLCmd.Connection = SQLConn
        SQLCmd.CommandType = System.Data.CommandType.Text
        SQLCmd.CommandText = SQL

        SQLRdr = SQLCmd.ExecuteReader()

        While SQLRdr.Read()

            ParameterName = SQLRdr("Name")
            Param = ReportParameters(ParameterName)

            ParameterOutput = ParameterOutput + System.Environment.NewLine + ParameterName + Space(30 - Len(ParameterName)) + ": "


            If Param.IsMultivalue = False Then
                ParameterValue = Param.Value
                ParameterLabel = Param.Label
                If ParameterLabel Is Nothing Then
                    ParameterOutput = ParameterOutput + ParameterValue
                Else
                    ParameterOutput = ParameterOutput + ParameterLabel
                End If
            Else
                For Mloop As Integer = 0 To Param.Count - 1
                    ParameterOutput = ParameterOutput + Param.Label(Mloop).ToString() + "-" + Param.Value(Mloop).ToString()
                    If Not (Mloop = Param.Count - 1) Then
                        ParameterOutput = ParameterOutput + ","
                    End If
                Next
            End If

        End While

        Return (ParameterOutput)
    Catch ex As Exception
        Return (ex.Message)
    End Try

End Function