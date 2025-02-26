#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <GuiListBox.au3>
#include <Array.au3>

Global $fIni = @ScriptDir & "\Keywords.ini"

If NOT FileExists($fIni) Then
	$fLoc = FileOpenDialog("Keywords.ini not found", @ScriptDir, "(*.ini)", "Keywords.ini")
	If StringRight($fLoc, 12) = "Keywords.ini" Then
		$fIni = $fLoc

	Else
		MsgBox(0, "Error", "Please download the Keywords.ini file and" & @CRLF & "place it in the same directory as this script.")
		Exit
	EndIf
EndIf

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("YuEGP Prompt Generator", 780, 463)
$Label1 = GUICtrlCreateLabel("Genre", 16, 8, 33, 17)
$Label2 = GUICtrlCreateLabel("Instrument", 172, 8, 53, 17)
$Label3 = GUICtrlCreateLabel("Mood", 324, 8, 31, 17)
$Label4 = GUICtrlCreateLabel("Gender", 476, 8, 39, 17)
$Label5 = GUICtrlCreateLabel("Timbre", 630, 8, 36, 17)
$List1 = GUICtrlCreateList("", 16, 28, 137, 370, BitOR($LBS_SORT,$LBS_MULTIPLESEL,$LBS_STANDARD,$WS_VSCROLL,$WS_BORDER))
$List2 = GUICtrlCreateList("", 168, 28, 137, 370, BitOR($LBS_SORT,$LBS_MULTIPLESEL,$LBS_STANDARD,$WS_VSCROLL,$WS_BORDER))
$List3 = GUICtrlCreateList("", 320, 28, 137, 370, BitOR($LBS_SORT,$LBS_MULTIPLESEL,$LBS_STANDARD,$WS_VSCROLL,$WS_BORDER))
$List4 = GUICtrlCreateList("", 472, 28, 137, 370, BitOR($LBS_SORT,$LBS_MULTIPLESEL,$LBS_STANDARD,$WS_VSCROLL,$WS_BORDER))
$List5 = GUICtrlCreateList("", 624, 28, 137, 370, BitOR($LBS_SORT,$LBS_MULTIPLESEL,$LBS_STANDARD,$WS_VSCROLL,$WS_BORDER))
$Button1 = GUICtrlCreateButton("Go!", 696, 409, 57, 39, $WS_GROUP)
$Edit1 = GUICtrlCreateEdit("", 16, 408, 665, 41, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN,$ES_MULTILINE))
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

_FillBoxes($List1, "Genres")
_FillBoxes($List2, "Instrument")
_FillBoxes($List3, "Mood")
_FillBoxes($List4, "Gender")
_FillBoxes($List5, "Timbre")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			_ReadBoxes()
	EndSwitch
WEnd

Func _FillBoxes($hBox, $sData)
	$sRead = IniRead($fIni, $sData, "key", "")
	GUICtrlSetData($hBox, $sRead)
EndFunc

Func _ReadBoxes()
	Local $aText, $sEditBox
	GUICtrlSetData($Edit1, "")
	For $i = 1 To 5
		$aText = _GUICtrlListBox_GetSelItemsText(Eval("List" & $i))
		If $aText[0] > 0 Then
			$sEditBox = GUICtrlRead($Edit1)
			For $j = 1 To $aText[0]
				$sEditBox &= $aText[$j] & " "
			Next
			GUICtrlSetData($Edit1, $sEditBox)
		EndIf
	Next
	ClipPut(GUICtrlRead($Edit1))
	$mPos = MouseGetPos()
	ToolTip("Prompt has been copied to clipboard", $mPos[0], $mPos[1], "Prompt Created", 1)
	Sleep(3000)
	ToolTip("")
EndFunc