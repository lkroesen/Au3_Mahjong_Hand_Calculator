#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <HandChecker.au3>
#include <HotKeys.au3>
#include <ValueCalc.au3>

; Use arrays for GUI elements might be useful later on.
Global $piTile[19] ; 0 unused
Global $radioTile[19] ; 0 unused
Global $man[10] ; 0 is RED DORA
Global $sou[10] ; 0 is RED DORA
Global $pin[10] ; 0 is RED DORA
Global $dora[14] ; 0 unused

#Region ### START Koda GUI section ### Form=\MAIN FORM BACKUP.kxf
$Form1 = GUICreate("Mahjong Hand Calculator", 867, 762, 456, 111)
$groupHand = GUICtrlCreateGroup("Hand", 8, 0, 849, 281)

; HAND TILES ;
$piTile[1] = GUICtrlCreatePic("Tiles\empty.bmp", 24, 24, 49, 73)
$piTile[2] = GUICtrlCreatePic("Tiles\empty.bmp", 88, 24, 49, 73)
$piTile[3] = GUICtrlCreatePic("Tiles\empty.bmp", 152, 24, 49, 73)
$piTile[4] = GUICtrlCreatePic("Tiles\empty.bmp", 216, 24, 49, 73)
$piTile[5] = GUICtrlCreatePic("Tiles\empty.bmp", 24, 136, 49, 73)
$piTile[6] = GUICtrlCreatePic("Tiles\empty.bmp", 88, 136, 49, 73)
$piTile[7] = GUICtrlCreatePic("Tiles\empty.bmp", 152, 136, 49, 73)
$piTile[8] = GUICtrlCreatePic("Tiles\empty.bmp", 216, 136, 49, 73)
$piTile[9] = GUICtrlCreatePic("Tiles\empty.bmp", 304, 24, 49, 73)
$piTile[10] = GUICtrlCreatePic("Tiles\empty.bmp", 368, 24, 49, 73)
$piTIle[11] = GUICtrlCreatePic("Tiles\empty.bmp", 432, 24, 49, 73)
$piTIle[12] = GUICtrlCreatePic("Tiles\empty.bmp", 496, 24, 49, 73)
$piTile[13] = GUICtrlCreatePic("Tiles\empty.bmp", 304, 136, 49, 73)
$piTile[14] = GUICtrlCreatePic("Tiles\empty.bmp", 368, 136, 49, 73)
$piTile[15] = GUICtrlCreatePic("Tiles\empty.bmp", 432, 136, 49, 73)
$piTile[16] = GUICtrlCreatePic("Tiles\empty.bmp", 496, 136, 49, 73)
$piTile[17] = GUICtrlCreatePic("Tiles\empty.bmp", 584, 24, 49, 73)
$piTile[18] = GUICtrlCreatePic("Tiles\empty.bmp", 584, 136, 49, 73)

; RADIO FOR HAND TILES ;
$radioTile[1] = GUICtrlCreateRadio("Tile 1", 24, 104, 49, 17)
$radioTile[2] = GUICtrlCreateRadio("Tile 2", 88, 104, 49, 17)
$radioTile[3] = GUICtrlCreateRadio("Tile 3", 152, 104, 49, 17)
$radioTile[4] = GUICtrlCreateRadio("Tile 4", 216, 104, 49, 17)
$radioTile[5] = GUICtrlCreateRadio("Tile 5", 24, 216, 49, 17)
$radioTile[6] = GUICtrlCreateRadio("Tile 6", 88, 216, 49, 17)
$radioTile[7] = GUICtrlCreateRadio("Tile 7", 152, 216, 49, 17)
$radioTile[8] = GUICtrlCreateRadio("Tile 8", 216, 216, 49, 17)
$radioTile[9] = GUICtrlCreateRadio("Tile 9", 304, 104, 49, 17)
$radioTile[10] = GUICtrlCreateRadio("Tile 10", 368, 104, 49, 17)
$radioTile[11] = GUICtrlCreateRadio("Tile 11", 432, 104, 49, 17)
$radioTile[12] = GUICtrlCreateRadio("Tile 12", 496, 104, 49, 17)
$radioTile[13] = GUICtrlCreateRadio("Tile 13", 304, 216, 49, 17)
$radioTile[14] = GUICtrlCreateRadio("Tile 14", 368, 216, 49, 17)
$radioTile[15] = GUICtrlCreateRadio("Tile 15", 432, 216, 49, 17)
$radioTile[16] = GUICtrlCreateRadio("Tile 16", 496, 216, 49, 17)
$radioTile[17] = GUICtrlCreateRadio("Tile 17", 584, 104, 49, 17)
$radioTile[18] = GUICtrlCreateRadio("Tile 18", 584, 216, 49, 17)

; COMBO BOXES WINDS ;
$groupSituations = GUICtrlCreateGroup("Yaku(man) Situations", 648, 0, 209, 281)
$comboRoundWind = GUICtrlCreateCombo("Round Wind", 680, 24, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Ton                           East|Nan                         South|Shaa                        West|Pei                           North|")
$comboSeatWind = GUICtrlCreateCombo("Seat Wind", 680, 56, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Ton                           East|Nan                         South|Shaa                        West|Pei                           North|")

; CHECKBOXES YAKU(MAN) SITUATIONS ;
$checkboxTsumo = GUICtrlCreateCheckbox("Menzen Tsumo", 664, 88, 89, 17)
$checkboxRiichi = GUICtrlCreateCheckbox("Riichi", 776, 88, 49, 17)
$checkboxDoubleRiichi = GUICtrlCreateCheckbox("Double Riichi", 664, 112, 89, 17)
$checkboxIppatsu = GUICtrlCreateCheckbox("Ippatsu", 776, 112, 57, 17)
$checkboxHaiteiRaoyue = GUICtrlCreateCheckbox("Haitei Raoyue", 664, 136, 97, 17)
$checkboxHouteiRaoyui = GUICtrlCreateCheckbox("Houtei Raoyui", 664, 160, 97, 17)
$checkboxRinshan = GUICtrlCreateCheckbox("Rinshan kaihou", 664, 184, 97, 17)
$checkboxChankan = GUICtrlCreateCheckbox("Chankan", 776, 136, 65, 17)
$checkboxNagashiMangan = GUICtrlCreateCheckbox("Nagashi Mangan", 664, 208, 97, 17)
$checkboxTenhou = GUICtrlCreateCheckbox("Tenhou", 776, 160, 57, 17)
$checkboxChiihou = GUICtrlCreateCheckbox("Chiihou", 776, 184, 57, 17)
$checkboxRenhou = GUICtrlCreateCheckbox("Renhou", 776, 208, 73, 17)

; POINTS ;
$inputPoints = GUICtrlCreateInput("non-Dealer price / Dealer price", 664, 240, 177, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))

; DONE BUTTON ;
$bDone = GUICtrlCreateButton("Done", 584, 240, 51, 25)
$groupTiles = GUICtrlCreateGroup("Base Tiles", 8, 328, 849, 289)

; MAN DECLARATIONS ;
$man[1] = GUICtrlCreatePic("Tiles\man1.bmp", 24, 352, 49, 73)
$man[2] = GUICtrlCreatePic("Tiles\man2.bmp", 88, 352, 49, 73)
$man[3] = GUICtrlCreatePic("Tiles\man3.bmp", 152, 352, 49, 73)
$man[4] = GUICtrlCreatePic("Tiles\man4.bmp", 216, 352, 49, 73)
$man[5] = GUICtrlCreatePic("Tiles\man5.bmp", 280, 352, 49, 73)
$man[6] = GUICtrlCreatePic("Tiles\man6.bmp", 344, 352, 49, 73)
$man[7] = GUICtrlCreatePic("Tiles\man7.bmp", 408, 352, 49, 73)
$man[8] = GUICtrlCreatePic("Tiles\man8.bmp", 472, 352, 49, 73)
$man[9] = GUICtrlCreatePic("Tiles\man9.bmp", 536, 352, 49, 73)

; SOU DECLARATIONS ;
$sou[1] = GUICtrlCreatePic("Tiles\sou1.bmp", 24, 440, 49, 73)
$sou[2] = GUICtrlCreatePic("Tiles\sou2.bmp", 88, 440, 49, 73)
$sou[3] = GUICtrlCreatePic("Tiles\sou3.bmp", 152, 440, 49, 73)
$sou[4] = GUICtrlCreatePic("Tiles\sou4.bmp", 216, 440, 49, 73)
$sou[5] = GUICtrlCreatePic("Tiles\sou5.bmp", 280, 440, 49, 73)
$sou[6] = GUICtrlCreatePic("Tiles\sou6.bmp", 344, 440, 49, 73)
$sou[7] = GUICtrlCreatePic("Tiles\sou7.bmp", 408, 440, 49, 73)
$sou[8] = GUICtrlCreatePic("Tiles\sou8.bmp", 472, 440, 49, 73)
$sou[9] = GUICtrlCreatePic("Tiles\sou9.bmp", 536, 440, 49, 73)

; PIN DECLARATIONS ;
$pin[1] = GUICtrlCreatePic("Tiles\pin1.bmp", 24, 528, 49, 73)
$pin[2] = GUICtrlCreatePic("Tiles\pin2.bmp", 88, 528, 49, 73)
$pin[3] = GUICtrlCreatePic("Tiles\pin3.bmp", 152, 528, 49, 73)
$pin[4] = GUICtrlCreatePic("Tiles\pin4.bmp", 216, 528, 49, 73)
$pin[5] = GUICtrlCreatePic("Tiles\pin5.bmp", 280, 528, 49, 73)
$pin[6] = GUICtrlCreatePic("Tiles\pin6.bmp", 344, 528, 49, 73)
$pin[7] = GUICtrlCreatePic("Tiles\pin7.bmp", 408, 528, 49, 73)
$pin[8] = GUICtrlCreatePic("Tiles\pin8.bmp", 472, 528, 49, 73)
$pin[9] = GUICtrlCreatePic("Tiles\pin9.bmp", 536, 528, 49, 73)

$groupCharactersDora = GUICtrlCreateGroup("Characters / Red Dora", 600, 328, 257, 289)

; SPECIAL CHARACTERS RED DORA DECLARATIONS;
$ton = GUICtrlCreatePic("Tiles\ton.bmp", 608, 352, 49, 73)
$nan = GUICtrlCreatePic("Tiles\nan.bmp", 672, 352, 49, 73)
$shaa = GUICtrlCreatePic("Tiles\shaa.bmp", 736, 352, 49, 73)
$pei = GUICtrlCreatePic("Tiles\pei.bmp", 800, 352, 49, 73)
$chun = GUICtrlCreatePic("Tiles\chun.bmp", 632, 440, 49, 73)
$haku = GUICtrlCreatePic("Tiles\haku.bmp", 704, 440, 49, 73)
$hatsu = GUICtrlCreatePic("Tiles\hatsu.bmp", 776, 440, 49, 73)

; RED FIVE DORA
$man[0] = GUICtrlCreatePic("Tiles\man5r.bmp", 632, 528, 49, 73)
$sou[0] = GUICtrlCreatePic("Tiles\sou5r.bmp", 704, 528, 49, 73)
$pin[0] = GUICtrlCreatePic("Tiles\pin5r.bmp", 776, 528, 49, 73)

; BUTTONS OPEN OR CLOSED ;
$bOpenSet1 = GUICtrlCreateButton("1-4 Open", 24, 240, 65, 25)
$bOpenSet2 = GUICtrlCreateButton("5-8 Open", 200, 240, 65, 25)
$bOpenSet3 = GUICtrlCreateButton("9-12 Open", 304, 240, 65, 25)
$bOpenSet4 = GUICtrlCreateButton("13-16 Open", 480, 240, 65, 25)

$fullNameOfHand = GUICtrlCreateInput("Full name of Hand", 8, 296, 753, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$bExport = GUICtrlCreateButton("Export Hand", 772, 293, 73, 25)
$groupDoraIndicators = GUICtrlCreateGroup("Dora Indicators", 8, 624, 849, 105)

; DORA DECLARATIONS ;
$dora[1] = GUICtrlCreatePic("Tiles\empty.bmp", 24, 648, 49, 73)
$dora[2] = GUICtrlCreatePic("Tiles\empty.bmp", 88, 648, 49, 73)
$dora[3] = GUICtrlCreatePic("Tiles\empty.bmp", 152, 648, 49, 73)
$dora[4] = GUICtrlCreatePic("Tiles\empty.bmp", 216, 648, 49, 73)
$dora[5] = GUICtrlCreatePic("Tiles\empty.bmp", 280, 648, 49, 73)
$dora[6] = GUICtrlCreatePic("Tiles\empty.bmp", 344, 648, 49, 73)
$dora[7] = GUICtrlCreatePic("Tiles\empty.bmp", 408, 648, 49, 73)
$dora[8] = GUICtrlCreatePic("Tiles\empty.bmp", 472, 648, 49, 73)
$dora[9]= GUICtrlCreatePic("Tiles\empty.bmp", 536, 648, 49, 73)
$dora[10] = GUICtrlCreatePic("Tiles\empty.bmp", 600, 648, 49, 73)
$dora[11] = GUICtrlCreatePic("Tiles\empty.bmp", 664, 648, 49, 73)
$dora[12] = GUICtrlCreatePic("Tiles\empty.bmp", 728, 648, 49, 73)
$dora[13] = GUICtrlCreatePic("Tiles\empty.bmp", 792, 648, 49, 73)

; DEBUG ;
$debug = GUICtrlCreateInput("Clarification messages right here!", 8, 736, 849, 21)

; END OF GUI ;
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; Create an array to index which tile is on what spot of the hand
Global $hand[19]
for $i = 1 to 18 Step 1
   $hand[$i] = "empty"
Next

Global $doraValue[14]
for $i = 1 to 13 Step 1
   $doraValue[$i] = "empty"
Next

Global $setsThatAreOpen[5]
for $i = 1 to 4 Step 1
   $setsThatAreOpen[$i] = 0
Next

Global $changeOrigin


While 1
	$nMsg = GUIGetMsg()
	  CheckChangeAbleImage($nMsg)
	  CheckBaseTile($nMsg)
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		 Case $bDone
			if $hand[17] == "empty" AND $hand[18] == "empty" Then
			   $SevenPairsEnabled = 1
			   GUICtrlSetData($debug, "Done has been clicked, Seven Pairs detected and enabled!")
			Else
			   $SevenPairsEnabled = 0
			   GUICtrlSetData($debug, "Done has been clicked")
			EndIf
			Checker()
		 Case $bOpenSet1
			if $setsThatAreOpen[1] == 0 Then
			   $setsThatAreOpen[1] = 1
			   GuiCtrlSetData($debug, "Set 1: Open")
			Else
			   $setsThatAreOpen[1] = 0
			   GuiCtrlSetData($debug, "Set 1: Closed")
			EndIf
		 Case $bOpenSet2
			if $setsThatAreOpen[2] == 0 Then
			   $setsThatAreOpen[2] = 1
			   GuiCtrlSetData($debug, "Set 2: Open")
			Else
			   $setsThatAreOpen[2] = 0
			   GuiCtrlSetData($debug, "Set 2: Closed")
			EndIf
		 Case $bOpenSet3
			if $setsThatAreOpen[3] == 0 Then
			   $setsThatAreOpen[3] = 1
			   GuiCtrlSetData($debug, "Set 3: Open")
			Else
			   $setsThatAreOpen[3] = 0
			   GuiCtrlSetData($debug, "Set 3: Closed")
			EndIf
		 Case $bOpenSet4
			if $setsThatAreOpen[4] == 0 Then
			   $setsThatAreOpen[4] = 1
			   GuiCtrlSetData($debug, "Set 4: Open")
			Else
			   $setsThatAreOpen[4] = 0
			   GuiCtrlSetData($debug, "Set 4: Closed")
			EndIf
	EndSwitch
 WEnd

; Check for one to change into ;
Func CheckChangeAbleImage ($msg)

for $i = 1 to 18 Step 1
   if $msg == $piTile[$i] Then
	  GUICtrlSetData($debug, "Click on a tile to change Tile " & $i & " into.")
	  $changeOrigin = $piTile[$i]
	  GUICtrlSetState($radioTile[$i], $GUI_CHECKED)
   EndIf
Next

for $i = 1 to 13 Step 1
   if $msg == $dora[$i] Then
	  GUICtrlSetData($debug, "Click on a tile to change Dora " & $i & " into.")
	  $changeOrigin = $dora[$i]
   EndIf
Next

EndFunc

; Check for all base tiles (Tiles that are clickable to change into ;
Func CheckBaseTile ($msg)
for $i = 1 to 9 Step 1
   if $msg == $man[$i] Then
	  GUICtrlSetData($debug, "Clicked on Man " & $i)
	  RecreateHandTile($changeOrigin, $man[$i])

   elseif $msg == $sou[$i] Then
	  GUICtrlSetData($debug, "Clicked on Sou " & $i)
	  RecreateHandTile($changeOrigin, $sou[$i])

   elseif $msg == $pin[$i] Then
	  GUICtrlSetData($debug, "Clicked on Pin " & $i)
	  RecreateHandTile($changeOrigin, $pin[$i])
   EndIf
   Next
   if $msg == $ton Then
	  GUICtrlSetData($debug, "Clicked on Ton (East)")
	  RecreateHandTile($changeOrigin, "ton")

   elseif $msg == $nan Then
	  GUICtrlSetData($debug, "Clicked on Nan (South)")
	  RecreateHandTile($changeOrigin, "nan")

   elseif $msg == $shaa Then
	  GUICtrlSetData($debug, "Clicked on Shaa (West)")
	  RecreateHandTile($changeOrigin, "shaa")

   elseif $msg == $pei Then
	  GUICtrlSetData($debug, "Clicked on Pei (North)")
	  RecreateHandTile($changeOrigin, "pei")

   elseif $msg == $chun Then
	  GUICtrlSetData($debug, "Clicked on Chun")
	  RecreateHandTile($changeOrigin, "chun")

   elseif $msg == $haku Then
	  GUICtrlSetData($debug, "Clicked on Haku")
	  RecreateHandTile($changeOrigin, "haku")

   elseif $msg == $hatsu Then
	  GUICtrlSetData($debug, "Clicked on Hatsu")
	  RecreateHandTile($changeOrigin, "hatsu")

   elseif $msg == $man[0] Then
	  GUICtrlSetData($debug, "Clicked on Red Man 5 Dora")
	  RecreateHandTile($changeOrigin, "m5r")

   elseif $msg == $sou[0] Then
	  GUICtrlSetData($debug, "Clicked on Red Sou 5 Dora")
	  RecreateHandTile($changeOrigin, "s5r")

   elseif $msg == $pin[0] Then
	  GUICtrlSetData($debug, "Clicked on Red Pin 5 Dora")
	  RecreateHandTile($changeOrigin, "p5r")
   EndIf
EndFunc

; Hardcoded check to see which picture to delete and then to recreate it again with the new picture
; Additionally also adds the enum of what it's changed into.
; TODO keep track of what has been set!
Func RecreateHandTile ($tilenum, $changeinto)

if $tilenum == $piTile[1] Then
   GUICtrlDelete($piTile[1])
   $piTile[1] = GUICtrlCreatePic(ChangeInto($changeinto), 24, 24, 49, 73)
   $hand[1] = assigner($changeinto)

elseif $tilenum == $piTile[2] Then
   GUICtrlDelete($piTile[2])
   $piTile[2] = GUICtrlCreatePic(ChangeInto($changeinto), 88, 24, 49, 73)
   $hand[2] = assigner($changeinto)

elseif $tilenum == $piTile[3] Then
   GUICtrlDelete($piTile[3])
   $piTile[3] = GUICtrlCreatePic(ChangeInto($changeinto), 152, 24, 49, 73)
   $hand[3] = assigner($changeinto)

elseif $tilenum == $piTile[4] Then
   GUICtrlDelete($piTile[4])
   $piTile[4] = GUICtrlCreatePic(ChangeInto($changeinto), 216, 24, 49, 73)
   $hand[4] = assigner($changeinto)

elseif $tilenum == $piTile[5] Then
   GUICtrlDelete($piTile[5])
   $piTile[5] = GUICtrlCreatePic(ChangeInto($changeinto), 24, 136, 49, 73)
   $hand[5] = assigner($changeinto)

elseif $tilenum == $piTile[6] Then
   GUICtrlDelete($piTile[6])
   $piTile[6] = GUICtrlCreatePic(ChangeInto($changeinto), 88, 136, 49, 73)
   $hand[6] = assigner($changeinto)

elseif $tilenum == $piTile[7] Then
   GUICtrlDelete($piTile[7])
   $piTile[7] = GUICtrlCreatePic(ChangeInto($changeinto), 152, 136, 49, 73)
   $hand[7] = assigner($changeinto)

elseif $tilenum == $piTile[8] Then
   GUICtrlDelete($piTile[8])
   $piTile[8] = GUICtrlCreatePic(ChangeInto($changeinto), 216, 136, 49, 73)
   $hand[8] = assigner($changeinto)

elseif $tilenum == $piTile[9] Then
   GUICtrlDelete($piTile[9])
   $piTile[9] = GUICtrlCreatePic(ChangeInto($changeinto), 304, 24, 49, 73)
   $hand[9] = assigner($changeinto)

elseif $tilenum == $piTile[10] Then
   GUICtrlDelete($piTile[10])
   $piTile[10] = GUICtrlCreatePic(ChangeInto($changeinto), 368, 24, 49, 73)
   $hand[10] = assigner($changeinto)

elseif $tilenum == $piTile[11] Then
   GUICtrlDelete($piTile[11])
   $piTIle[11] = GUICtrlCreatePic(ChangeInto($changeinto), 432, 24, 49, 73)
   $hand[11] = assigner($changeinto)

elseif $tilenum == $piTile[12] Then
   GUICtrlDelete($piTile[12])
   $piTIle[12] = GUICtrlCreatePic(ChangeInto($changeinto), 496, 24, 49, 73)
   $hand[12] = assigner($changeinto)

elseif $tilenum == $piTile[13] Then
   GUICtrlDelete($piTile[13])
   $piTile[13] = GUICtrlCreatePic(ChangeInto($changeinto), 304, 136, 49, 73)
   $hand[13] = assigner($changeinto)

elseif $tilenum == $piTile[14] Then
   GUICtrlDelete($piTile[14])
   $piTile[14] = GUICtrlCreatePic(ChangeInto($changeinto), 368, 136, 49, 73)
   $hand[14] = assigner($changeinto)

elseif $tilenum == $piTile[15]  Then
   GUICtrlDelete($piTile[15])
   $piTile[15] = GUICtrlCreatePic(ChangeInto($changeinto), 432, 136, 49, 73)
   $hand[15] = assigner($changeinto)

elseif $tilenum == $piTile[16] Then
   GUICtrlDelete($piTile[16])
   $piTile[16] = GUICtrlCreatePic(ChangeInto($changeinto), 496, 136, 49, 73)
   $hand[16] = assigner($changeinto)

elseif $tilenum == $piTile[17] Then
   GUICtrlDelete($piTile[17])
   $piTile[17] = GUICtrlCreatePic(ChangeInto($changeinto), 584, 24, 49, 73)
   $hand[17] = assigner($changeinto)

elseif $tilenum == $piTile[18] Then
   GUICtrlDelete($piTile[18])
   $piTile[18] = GUICtrlCreatePic(ChangeInto($changeinto), 584, 136, 49, 73)
   $hand[18] = assigner($changeinto)

elseif $tilenum == $dora[1] Then
   GuiCtrlDelete($dora[1])
   $dora[1] = GUICtrlCreatePic(ChangeInto($changeinto), 24, 648, 49, 73)
   $doraValue[1] = assigner($changeinto)

elseif $tilenum == $dora[2] Then
   GuiCtrlDelete($dora[2])
   $dora[2] = GUICtrlCreatePic(ChangeInto($changeinto), 88, 648, 49, 73)
   $doraValue[2] = assigner($changeinto)

elseif $tilenum == $dora[3] Then
   GuiCtrlDelete($dora[3])
   $dora[3] = GUICtrlCreatePic(ChangeInto($changeinto), 152, 648, 49, 73)
   $doraValue[3] = assigner($changeinto)

elseif $tilenum == $dora[4] Then
   GuiCtrlDelete($dora[4])
   $dora[4] = GUICtrlCreatePic(ChangeInto($changeinto), 216, 648, 49, 73)
   $doraValue[4] = assigner($changeinto)

elseif $tilenum == $dora[5] Then
   GuiCtrlDelete($dora[5])
   $dora[5] = GUICtrlCreatePic(ChangeInto($changeinto), 280, 648, 49, 73)
   $doraValue[5] = assigner($changeinto)

elseif $tilenum == $dora[6] Then
   GuiCtrlDelete($dora[6])
   $dora[6] = GUICtrlCreatePic(ChangeInto($changeinto), 344, 648, 49, 73)
   $doraValue[6] = assigner($changeinto)

elseif $tilenum == $dora[7] Then
   GuiCtrlDelete($dora[7])
   $dora[7] = GUICtrlCreatePic(ChangeInto($changeinto), 408, 648, 49, 73)
   $doraValue[7] = assigner($changeinto)

elseif $tilenum == $dora[8] Then
   GuiCtrlDelete($dora[8])
   $dora[8] = GUICtrlCreatePic(ChangeInto($changeinto), 472, 648, 49, 73)
   $doraValue[8] = assigner($changeinto)

elseif $tilenum == $dora[9]	Then
   GuiCtrlDelete($dora[9])
   $dora[9] = GUICtrlCreatePic(ChangeInto($changeinto), 536, 648, 49, 73)
   $doraValue[9] = assigner($changeinto)

elseif $tilenum == $dora[10] Then
   GuiCtrlDelete($dora[10])
   $dora[10] = GUICtrlCreatePic(ChangeInto($changeinto), 600, 648, 49, 73)
   $doraValue[10] = assigner($changeinto)

elseif $tilenum == $dora[11] Then
   GuiCtrlDelete($dora[11])
   $dora[11] = GUICtrlCreatePic(ChangeInto($changeinto), 664, 648, 49, 73)
   $doraValue[11] = assigner($changeinto)

elseif $tilenum == $dora[12] Then
   GuiCtrlDelete($dora[12])
   $dora[12] = GUICtrlCreatePic(ChangeInto($changeinto), 728, 648, 49, 73)
   $doraValue[12] = assigner($changeinto)
elseif $tilenum == $dora[13] Then
   GuiCtrlDelete($dora[13])
   $dora[13] = GUICtrlCreatePic(ChangeInto($changeinto), 792, 648, 49, 73)
   $doraValue[13] = assigner($changeinto)
EndIf
selectNext()
EndFunc

; Assigns numbers to the Hand & Dora arrays, makes it easy to keep track of what is in the hand and dora
Func assigner($changeinto)

   if $changeinto == "empty" Then
	  return "empty"
   EndIf

   if $changeinto == $man[1] Then
	  return $cMAN1
   elseif $changeinto == $man[2] Then
	  return $cMAN2
   elseif $changeinto == $man[3] Then
	  return $cMAN3
   elseif $changeinto == $man[4] Then
	  return $cMAN4
   elseif $changeinto == $man[5] Then
	  return $cMAN5
   elseif $changeinto == "m5r" Then
	  return $cMAN5r
   elseif $changeinto == $man[6] Then
	  return $cMAN6
   elseif $changeinto == $man[7] Then
	  return $cMAN7
   elseif $changeinto == $man[8] Then
	  return $cMAN8
   elseif $changeinto == $man[9] Then
	  return $cMAN9

   elseif $changeinto == $sou[1] Then
	  return $cSOU1
   elseif $changeinto == $sou[2] Then
	  return $cSOU2
   elseif $changeinto == $sou[3] Then
	  return $cSOU3
   elseif $changeinto == $sou[4] Then
	  return $cSOU4
   elseif $changeinto == $sou[5] Then
	  return $cSOU5
   elseif $changeinto == "s5r" Then
	  return $cSOU5r
   elseif $changeinto == $sou[6] Then
	  return $cSOU6
   elseif $changeinto == $sou[7] Then
	  return $cSOU7
   elseif $changeinto == $sou[8] Then
	  return $cSOU8
   elseif $changeinto == $sou[9] Then
	  return $cSOU9

   elseif $changeinto == $pin[1] Then
	  return $cPIN1
   elseif $changeinto == $pin[2] Then
	  return $cPIN2
   elseif $changeinto == $pin[3] Then
	  return $cPIN3
   elseif $changeinto == $pin[4] Then
	  return $cPIN4
   elseif $changeinto == $pin[5] Then
	  return $cPIN5
   elseif $changeinto == "p5r" Then
	  return $cPIN5r
   elseif $changeinto == $pin[6] Then
	  return $cPIN6
   elseif $changeinto == $pin[7] Then
	  return $cPIN7
   elseif $changeinto == $pin[8] Then
	  return $cPIN8
   elseif $changeinto == $pin[9] Then
	  return $cPIN9

   elseif $changeinto == "ton" Then
	  return $cTON
   elseif $changeinto == "nan" Then
	  return $cNAN
   elseif $changeinto == "shaa" Then
	  return $cSHAA
   elseif $changeinto == "pei" Then
	  return $cPEI
   elseif $changeinto == "chun" Then
	  return $cCHUN
   elseif $changeinto == "haku" Then
	  return $cHAKU
   elseif $changeinto == "hatsu" Then
	  return $cHATSU

   EndIf


EndFunc

; Func that actually sends back the string to change into
Func ChangeInto($changeinto)

   if $changeinto == "empty" Then
	  GUICtrlSetData($debug, "Reverting to blank")
	  return "Tiles\empty.bmp"
   EndIf

   for $i = 1 to 9 Step 1
	  if $changeinto == $man[$i] Then
		 GUICtrlSetData($debug, "Changed into Man " & $i & "!")
		 return "Tiles\man" & $i & ".bmp"

	  elseif $changeinto == $sou[$i] Then
		 GUICtrlSetData($debug, "Changed into Sou " & $i & "!")
		 return "Tiles\sou" & $i & ".bmp"

	  elseif $changeinto == $pin[$i] Then
		 GUICtrlSetData($debug, "Changed into Pin " & $i & "!")
		 return "Tiles\pin" & $i & ".bmp"
	  EndIf
   Next
	  if $changeinto == "ton" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "nan" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "shaa" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "pei" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "chun" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "haku" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "hatsu" Then
		 GUICtrlSetData($debug, "Changed into " & $changeinto & "!")
		 return "Tiles\" &  $changeinto & ".bmp"

	  elseif $changeinto == "m5r" Then
		 GUICtrlSetData($debug, "Changed into Red Man 5 Dora!")
		 return "Tiles\man5r.bmp"

	  elseif $changeinto == "s5r" Then
		 GUICtrlSetData($debug, "Changed into Red Sou 5 Dora!")
		 return "Tiles\sou5r.bmp"

	  elseif $changeinto == "p5r" Then
		 GUICtrlSetData($debug, "Changed into Red Pin 5 Dora!")
		 return "Tiles\pin5r.bmp"

	  EndIf
   return "Tiles\empty.bmp"
EndFunc

; Translates the numbers associated with the tiles
Func TileTranslator($number)
   if $number == "empty" Then
	  return $number
   elseif $number == $cMAN1 Then
	  return "Man 1"
   elseif $number ==  $cMAN2 Then
	  return "Man 2"
   elseif $number ==  $cMAN3 Then
	  return "Man 3"
   elseif $number ==  $cMAN4 Then
	  return "Man 4"
   elseif $number ==  $cMAN5 Then
	  return "Man 5"
   elseif $number ==  $cMAN5r Then
	  return "Red Man 5 Dora"
   elseif $number ==  $cMAN6 Then
	  return "Man 6"
   elseif $number ==  $cMAN7 Then
	  return "Man 7"
   elseif $number ==  $cMAN8 Then
	  return "Man 8"
   elseif $number ==  $cMAN9 Then
	  return "Man 9"
   elseif $number ==  $cSOU1 Then
	  return "Sou 1"
   elseif $number ==  $cSOU2 Then
	  return "Sou 2"
   elseif $number ==  $cSOU3 Then
	  return "Sou 3"
   elseif $number ==  $cSOU4 Then
	  return "Sou 4"
   elseif $number ==  $cSOU5 Then
	  return "Sou 5"
   elseif $number ==  $cSOU5r Then
	  return "Red Sou 5 Dora"
   elseif $number ==  $cSOU6 Then
	  return "Sou 6"
   elseif $number ==  $cSOU7 Then
	  return "Sou 7"
   elseif $number ==  $cSOU8 Then
	  return "Sou 8"
   elseif $number ==  $cSOU9 Then
	  return "Sou 9"
   elseif $number ==  $cPIN1 Then
	  return "Pin 1"
   elseif $number ==  $cPIN2 Then
	  return "Pin 2"
   elseif $number ==  $cPIN3 Then
	  return "Pin 3"
   elseif $number ==  $cPIN4 Then
	  return "Pin 4"
   elseif $number ==  $cPIN5 Then
	  return "Pin 5"
   elseif $number ==  $cPIN5r Then
	  return "Red Pin 5 Dora"
   elseif $number ==  $cPIN6 Then
	  return "Pin 6"
   elseif $number ==  $cPIN7 Then
	  return "Pin 7"
   elseif $number ==  $cPIN8 Then
	  return "Pin 8"
   elseif $number ==  $cPIN9 Then
	  return "Pin 9"
   elseif $number ==  $cTON Then
	  return "Ton (East)"
   elseif $number ==  $cNAN Then
	  return "Nan (South)"
   elseif $number ==  $cSHAA Then
	  return "Shaa (West)"
   elseif $number ==  $cPEI Then
	  return "Pei (North)"
   elseif $number ==  $cCHUN Then
	  return "Chun"
   elseif $number ==  $cHAKU Then
	  return "Haku"
   elseif $number ==  $cHATSU Then
	  return "Hatsu"

   EndIF
EndFunc

