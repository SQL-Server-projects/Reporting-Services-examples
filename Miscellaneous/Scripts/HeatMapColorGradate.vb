Public Function HeatMapColorGradate( _
  ByVal Value As Double _
, ByVal MaxPositive As Double _
, ByVal Neutral As Double _
, ByVal ColStr As String) As String
'------------------------------------------------------------------------------------------------
' Purpose:  To use a color gradations on a heatmap report
' Example:  BackgroundColor =Code.HeatMapColorGradate(25, 100, -10, Variables!ColorEventCountGradate.Value)
'           BackgroundColor =Code.HeatMapColorGradate(dayValue, maxValue, 0, "#2322EE")
' Note:     Use a negative number as the "Neutral" number to avoid too light of a color
'------------------------------------------------------------------------------------------------
Const Shd As Double = 255
Dim ColVar1         As Integer = Convert.ToInt32(Left(Right(ColStr, 6), 2), 16)
Dim ColVar2         As Integer = Convert.ToInt32(Left(Right(ColStr, 4), 2), 16)
Dim ColVar3         As Integer = Convert.ToInt32(Right(ColStr, 2), 16) 'Find Largest Range 'Split the #RGB color to R, G, and B components
Dim decPosRange     As Double = Math.Abs(MaxPositive - Neutral) 'Find appropriate color shade
Dim iColor1         As Integer = ColVar1 + CInt(Math.Round((MaxPositive - Value) * ((Shd - ColVar1) / decPosRange)))
Dim iColor2         As Integer = ColVar2 + CInt(Math.Round((MaxPositive - Value) * ((Shd - ColVar2) / decPosRange)))
Dim iColor3         As Integer = ColVar3 + CInt(Math.Round((MaxPositive - Value) * ((Shd - ColVar3) / decPosRange))) 'Return the new color
Dim heatMapColor    As String = "#" & iColor1.ToString("X2") & iColor2.ToString("X2") & iColor3.ToString("X2") 'Reduce a shade for each of the R,G,B components

    Return heatMapColor 

End Function