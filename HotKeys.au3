HotKeySet("{F1}", "nullifyOriginChange")
HotKeySet("+d", "selectNext")
HotKeySet("+a", "selectPrev")
HotKeySet("{F9}", "status")
HotKeySet("{F5}", "Checker")
HotKeySet("{F7}", "SevenPairs")
HotKeySet("{DEL}","Deleter")
HotKeySet("{F4}", "OpenWaitEnabled")

; HOTKEYS ;
; 7 due to 7 pairs.
Global $set[7]
Global $SevenPairsEnabled = 0
Global $OpenWaitEnabled = 0

; Enabler or Disabled of Seven Pairs
Func SevenPairs()

   if $SevenPairsEnabled == 0 Then
	  $SevenPairsEnabled = 1
	  GUICtrlSetData($debug, "Enabled Seven Pairs: " & $SevenPairsEnabled)
   Else
	  $SevenPairsEnabled = 0
	  GUICtrlSetData($debug, "Disabled Seven Pairs: " & $SevenPairsEnabled)
   EndIf

EndFunc

; Used for pinfu, pinfu required an Open Wait
Func OpenWaitEnabled()

   if $OpenWaitEnabled == 0 Then
	  $OpenWaitEnabled = 1
	  GUICtrlSetData($debug, "Enabled Open Wait: " & $OpenWaitEnabled)
   Else
	  $OpenWaitEnabled = 0
	  GUICtrlSetData($debug, "Disabled Open Wait: " & $OpenWaitEnabled)
   EndIf

EndFunc

; Collects data on hand tiles & dora tiles, mainly a debug to see if everything is registered properly.
Func status()
   $string = ""
   for $i = 1 To 18 Step 1
	  $string &= "Hand Tile " & $i & ": " & TileTranslator($hand[$i]) & "   "
   Next
   for $i = 1 to 13 Step 1
	  $string &= "Dora Tile " & $i & ": " & TileTranslator($doraValue[$i]) & "   "
   Next
   GUICtrlSetData($debug, $string)
EndFunc

; Deletes the currently selected tile back to empty
Func Deleter()
   RecreateHandTile($changeOrigin, "empty")
EndFunc

; Creates a debug message with the current hand overview
Func Checker()
   ; Check for 7 pairs First
   $debugString = ""
   If $SevenPairsEnabled == 1 Then
		 $set[0] = CheckPairs($hand[1],$hand[2])
		 $debugString &= "Pair 1:  Pair of " & TileTranslator($set[0]-200) & "    "

		 $set[1] = CheckPairs($hand[3],$hand[4])
		 $debugString &= "Pair 2:  Pair of " & TileTranslator($set[1]-200) & "    "

		 $set[2] = CheckPairs($hand[5],$hand[6])
		 $debugString &= "Pair 3:  Pair of " & TileTranslator($set[2]-200) & "    "

		 $set[3] = CheckPairs($hand[7],$hand[8])
		 $debugString &= "Pair 4:  Pair of " & TileTranslator($set[3]-200) & "    "

		 $set[4] = CheckPairs($hand[9],$hand[10])
		 $debugString &= "Pair 5:  Pair of " & TileTranslator($set[4]-200) & "    "

		 $set[5] = CheckPairs($hand[11],$hand[12])
		 $debugString &= "Pair 6:  Pair of " & TileTranslator($set[5]-200) & "    "

		 $set[6] = CheckPairs($hand[13],$hand[14])
		 $debugString &= "Pair 7:  Pair of " & TileTranslator($set[6]-200) & "    "

   Else
   ; Normal 4 x 3 chi/pon & double
	  $set[0] = CheckHand($hand[1],$hand[2],$hand[3],$hand[4])
	  $set[1] = CheckHand($hand[5],$hand[6],$hand[7],$hand[8])
	  $set[2] = CheckHand($hand[9],$hand[10],$hand[11],$hand[12])
	  $set[3] = CheckHand($hand[13],$hand[14],$hand[15],$hand[16])
	  ; The double
	  $set[4] = CheckPairs($hand[17], $hand[18])

	  for $i = 0 to 3 Step 1
		 $debugString &= " [Set " & $i+1 & "]: "
		 if $set[$i] >= 80 Then
			$debugString &= "Kan of " & TileTranslator($set[$i]-80)
		 elseif $set[$i] >= 40 and $set[$i] <= 76 Then
			$debugString &= "Pon of " & TileTranslator($set[$i]-40)
		 elseif $set[$i] >= 10 and $set[$i] <= 37 Then
			$debugString &= "Chi with value: " & ChiTranslator($set[$i])
		 else
			$debugString &= "I do not know what this set is. error value: " & $set
		 EndIf
	  Next
	  $debugString &= "    [Pair 1]: Pair of " & TileTranslator($set[4]-200)
   EndIf
   GUICtrlSetData($debug, $debugString)
   Calculate()
EndFunc

; Deselects with F1
Func nullifyOriginChange()
   $changeOrigin = null
   GUICtrlSetData($debug, "Change tile disabled")
EndFunc

; Selects the next Tile for a quick change when pressing shift+D
Func selectNext()

if $changeOrigin == null Then
   GUICtrlSetData($debug, "Click on a tile to change Tile 1 into.")
   $changeOrigin = $piTile[1]
   GUICtrlSetState($radioTile[1], $GUI_CHECKED)
   return
EndIf

for $i = 1 to 18 Step 1
   if $changeOrigin == $piTile[18] Then
	  GUICtrlSetData($debug, "Click on a tile to change Dora 1 into.")
	  $changeOrigin = $dora[1]
	  return
   elseif $changeOrigin == $piTile[$i] Then
	  GUICtrlSetData($debug, "Click on a tile to change Tile " & $i+1 & " into.")
	  $changeOrigin = $piTile[$i+1]
	  GUICtrlSetState($radioTile[$i+1], $GUI_CHECKED)
	  return
   EndIf
Next

for $i = 1 to 13 Step 1
   if $changeOrigin == $dora[13] Then
	  GUICtrlSetData($debug, "Click on a tile to change Hand Tile 1 into.")
	  $changeOrigin = $piTile[1]
	  GUICtrlSetState($radioTile[1], $GUI_CHECKED)
	  return
   elseif $changeOrigin == $dora[$i] Then
	  GUICtrlSetData($debug, "Click on a tile to change Dora " & $i+1 & " into.")
	  $changeOrigin = $dora[$i+1]
	  return
   EndIf
Next

EndFunc

; Selects the previous Tile for a quick change when pressing shift+A
Func selectPrev()


if $changeOrigin == null Then
   GUICtrlSetData($debug, "Click on a tile to change Dora 13 into.")
   $changeOrigin = $dora[13]
   return
EndIf

for $i = 1 to 18 Step 1
   if $changeOrigin == $piTile[1] Then
	  GUICtrlSetData($debug, "Click on a tile to change Dora 13 into.")
	  $changeOrigin = $dora[13]
	  return
   elseif $changeOrigin == $piTile[$i] Then
	  GUICtrlSetData($debug, "Click on a tile to change Tile " & $i-1 & " into.")
	  $changeOrigin = $piTile[$i-1]
	  GUICtrlSetState($radioTile[$i-1], $GUI_CHECKED)
	  return
   EndIf
Next

for $i = 1 to 13 Step 1
   if $changeOrigin == $dora[1] Then
	  GUICtrlSetData($debug, "Click on a tile to change Hand Tile 18 into.")
	  $changeOrigin = $piTile[18]
	  GUICtrlSetState($radioTile[18], $GUI_CHECKED)
	  return
   elseif $changeOrigin == $dora[$i] Then
	  GUICtrlSetData($debug, "Click on a tile to change Dora " & $i-1 & " into.")
	  $changeOrigin = $dora[$i-1]
	  return
   EndIf
Next


EndFunc
