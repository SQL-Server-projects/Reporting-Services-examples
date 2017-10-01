Private Alt As Boolean

Public Function CandyStripe(Optional ByVal NewRow As Boolean = False, Optional ByVal OddColor as String = "Beige", Optional ByVal EvenColor as String = "White") As String
'------------------------------------------------------------------------------------------------
' Purpose:  To candy stripe the detail rows of a report
' Example:  BackgroundColor = Code.CandyStripe()
' Note:     The first column needs a parameter of "True" passed in example: Code.CandyStripe(True)
'------------------------------------------------------------------------------------------------
	If NewRow Then 
		Alt = Not Alt
	End If
	
	If Alt Then
		Return OddColor
	Else
		Return EvenColor
	End If

End Function