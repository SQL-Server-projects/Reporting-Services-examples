Public Function HeatMapColor(ByVal percent As Double) As String
'------------------------------------------------------------------------------------------------
' Purpose:  To assign specific colors for a heatmap report
' Example:  BackgroundColor =Code.HeatMapColor(25)
'------------------------------------------------------------------------------------------------

    Select Case percent
        Case Is = 0
            HeatMapColor = "Gainsboro"
        Case 0 To 24
            HeatMapColor = "LightBlue"
        Case 25 To 49
            HeatMapColor = "Khaki"
        Case 50 To 74
            HeatMapColor = "Tan"
        Case 75 To 100
            HeatMapColor = "LightCoral"
    End Select

End Function