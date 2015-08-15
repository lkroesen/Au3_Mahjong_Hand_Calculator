; In this .au3 we'll actually perform hand calculations

; When pressing "Done" or F5 this part of the program will calculate the hand name & the points associated
; Thanks to "Checker" in HotKeys.au3 all Set arrays will have a unique value for all sets/pairs
; using these unique numbers we can check for requirements and calculate the value.

; "Main" of ValueCalc, this method gets called to initiate the calculation.
Global $han
Global $fu
Global $rWind
Global $sWind
Global $FullHandName = ""
Global $nYaku = 0

; Yaku Declarations
Global $pinfuTrue = 0
Global $tanyaoTrue = 0
Global $IipeikouTrue = 0
Global $YakuhaiTrue = 0
Global $SanshokuDoujinTrue = 0
Global $IkkitsuukanTrue = 0
Global $ChantaiyaoTrue = 0
Global $HonroutouTrue = 0
Global $bToitoi = False
Global $bSanankou = False
Global $bSankantsu = False
Global $bSanshokudoukou = False
Global $bShouSangen = False
Global $bHonitsu = False
Global $bJunchan = False
Global $bRyanpeikou = False
Global $bChinitsu = False

Func Calculate()
   ; Get wind directions off of GUI
   If getWinds() == false Then
	  GUICtrlSetData($debug, "Calculation aborted due to Winds not initialized")
	  Return
   EndIf

   $FullHandName = ""
   $han = 0
   $fu = 0
   $nYaku = 0

   ; Seven Pairs Exception
   ; Honroutou possible (if it is then it's called: Honroochiitoi) TODO ADD DETECT
   ; Tsuu iisou possible (Yakuman)
   If $SevenPairsEnabled == 1 Then
	  $han += 2
	  $nYaku += 1
	  ; TODO additional calculations
	  $FullHandName &= " Chiitoitsu "
	  $FullHandName &= " [Han: " & $han & " Fu: " & $fu & "]"
	  $FullHandName &= "   Amount of Yaku: " & $nYaku
	  GUICtrlSetData($fullNameOfHand, $FullHandName)
	  return
   EndIf

   ; 13 Orphans Exception

   ; Check if atleast Tiles 1,2,3 5,6,7 9,10,11 13,14,15 & 17,18 are not empty.
   NotFilledMin()

   ; Check for Yaku
   Pinfu()
   Tanyao()
   Iipeikou()
   Yakuhai()
   Sanshoku_Doujin()
   Ikkitsuukan()
   Chantaiyao()
   Honroutou()
   ToiToi()
   Sanankou()
   Sankantsu()
   ; End yaku

   ; Check for Pinfu / No Point
   If $pinfuTrue == 1 Then
	  $FullHandName &= "Pinfu "
	  $han += 1
	  $nYaku += 1
   EndIf
   ; Check for Tanyao / All Simples
   If $tanyaoTrue == 1 Then
	  ; Check if it's a Tanyao (Closed Hand Tanyao) or a Kuitan (Open Hand Tanyao)
	  if Concealed() == -1 Then
		 $FullHandName &= "Kuitan "
	  Else
		 $FullHandName &= "Tanyao "
	  EndIf

	  $han += 1
	  $nYaku += 1
   EndIf
   ; Check for Iipeikou / Double Sequence
   If $IipeikouTrue == 1 Then
	  $FullHandName &= "Iipeikou "
	  $han += 1
	  $nYaku += 1
   EndIf
   ; Check for Yakuhai / Fanpai
   If $YakuhaiTrue == 1 Then
	  $FullHandName &= "Yakuhai "
	  $nYaku += 1
   EndIf
   ; Check for Sanshoku
   If $SanshokuDoujinTrue == 1 Then

	  if Concealed() == -1 Then
		 $han+=1
	  Else
		 $han+=2
	  EndIf

	  $FullHandName &= "San Shoku "
	  $nYaku += 1
   EndIf
   ; Check for Ikkitsuukan
   If $IkkitsuukanTrue == 1 Then
	  if Concealed() == -1 Then
		 $han+=1
	  Else
		 $han+=2
	  EndIf

	  $FullHandName &= "Ikkitsuukan "
	  $nYaku+=1
   EndIf
   ; Check for Chantaiyao
   If $ChantaiyaoTrue == 1 Then
	  if Concealed() == -1 Then
		 $han+=1
	  Else
		 $han+=2
	  EndIf

	  $FullHandName &= "Chantaiyao "
	  $nYaku+=1
   EndIf
   ; Check for Honroutou
   If $HonroutouTrue == 1 Then
	  $han+=2
	  $FullHandName &= "Honroutou "
	  $nYaku+=1
   EndIf

   ; Check for ToiToi
   If $bToiToi == True Then
	  $han+=2
	  $FullHandName &= "Toi Toi "
	  $nYaku+=1
   EndIf

   ; Check for Sanankou
   If $bSanankou == True Then
	  $han+=2
	  $FullHandName &= "Sanankou "
	  $nYaku+=1
   EndIf

   ; Check for Sankantsu
   If $bSankantsu == True Then
	  $han+=2
	  $FullHandName &= "Sankantsu "
	  $nYaku+=1
   EndIf

   $FullHandName &= " [Han: " & $han & " Fu: " & $fu & "]"
   $FullHandName &= "   Amount of Yaku: " & $nYaku
   GUICtrlSetData($fullNameOfHand, $FullHandName)
EndFunc

; Sankantsu 3x pon/kan
Func Sankantsu()
   $bSankantsu = False

   $nKan = 0

   for $i = 0 to 3 Step 1
	  if $set[$i] >= 80 and $set[$i] <= 199 Then
		 $nKan += 1
	  EndIf
   Next

   if $nKan >= 3 Then
	  $bSankantsu = True
   EndIf

EndFunc

; Sanankou / Three Concealed Trips
Func Sanankou()
   $bSanankou = False

   ; Find sets that have pon/kan
   Local $s[4] = [False, False, False, False]

   for $i = 0 to 3 Step 1
	  if $set[$i] >= 40 and $set[$i] <= 199 Then
		 $s[$i] = True
	  else
		 $s[$i] = False
	  EndIf
   Next

   $requirement = 0
   for $i = 0 to 3 Step 1
	  if $s[$i] == True and $setsThatAreOpen[$i+1] == 0 Then
		 $requirement += 1
	  EndIf
   Next

   If $requirement >= 3 Then
	  $bSanankou = True
	  return
   EndIf

   $bSanankou = False
EndFunc

; Toi Toi 3x pon/kan
Func ToiToi()
   $bToiToi = False

   if NoChi() == -1 Then
	  $bToiToi = False
	  return
   EndIf

   for $i = 0 to 3 Step 1
	  if $set[$i] >= 40 and $set[$i] <= 199 Then
		 $bToiToi = True
	  else
		 $bToiToi = False
	  EndIf
   Next
EndFunc

; Honroutou / All terminals and/or honours
Func Honroutou()
   $HonroutouTrue = 0

   ; Search through hand for non-terminals and honours
   for $i = 1 to 18 Step 1
	  if $hand[$i] = "empty" OR $hand[$i] == $cMAN1 OR $hand[$i] == $cMAN9 OR $hand[$i] == $cSOU1 OR $hand[$i] == $cSOU9 OR $hand[$i] == $cPIN1 OR $hand[$i] == $cPIN9 OR $hand[$i] == $cTON OR $hand[$i] == $cNAN OR $hand[$i] == $cSHAA OR $hand[$i] == $cPEI OR $hand[$i] == $cCHUN OR $hand[$i] == $cHAKU OR $hand[$i] == $cHATSU Then
		 $HonroutouTrue = 1
	  Else
		 $HonroutouTrue = 0
		 return
	  EndIf
   Next
EndFunc

; Chantaiyao / Terminal or honor in each Set
; Must be concealed: no
; Han: 2 / 1 if not concealed.
; Every set must have at least one terminal or honour tile,
; and the pair must be of a terminal or honour tile.
; Must contain at least one sequence (123 or 789).
Func Chantaiyao()
   $ChantaiyaoTrue = 0

   if NoChi() == 1 Then
	  $ChantaiyaoTrue = 0
	  return
   EndIf

   $SetsPasses = 0
   $Pairpasses = 0

   ; Check for stuff that has honours or terminals in them, cMAN1,CMAN9,cSOU1,cSOU9,cPIN1,cPIN9,cTON,cSHAA,cPEI,cNAN,cHAKU,cHATSU,cCHUN
   ; Chi:  n1 1-2-3, n7 7-8-9
   For $f = 10 to 30 Step 10
	  ;msgbox(0, "ChiOf()", ChiOf($f+1) & ChiOf($f+7))
	  If ChiOf($f+1) == 1 OR ChiOf($f+7) == 1 Then
	  ;msgbox(0, "For if chiof passed", $f)
		 for $i = 0 to 3 Step 1
			if $set[$i] == 11 OR $set[$i] == 17 OR $set[$i] == 21 OR $set[$i] == 27 OR $set[$i] == 31 OR $set[$i] == 37 OR $set[$i] == 40+$cMAN1 OR $set[$i] == 40+$cMAN9 OR $set[$i] == 40+$cSOU1 OR $set[$i] == 40+$cSOU9 OR $set[$i] == 40 + $cPIN1 OR $set[$i] == 40 + $cPIN9 OR $set[$i] == 80+$cMAN1 OR $set[$i] == 80+$cMAN9 OR $set[$i] == 80+$cSOU1 OR $set[$i] == 80+$cSOU9 OR $set[$i] == 80 + $cPIN1 OR $set[$i] == 80 + $cPIN9 OR $set[$i] == 40+$cTON OR $set[$i] == 40+$cNAN OR $set[$i] == 40+$cSHAA OR $set[$i] == 40+$cPEI OR $set[$i] == 40 + $cCHUN OR $set[$i] == 40 + $cHATSU OR $set[$i] == 40 + $cHAKU OR $set[$i] == 80+$cTON OR $set[$i] == 80+$cNAN OR $set[$i] == 80+$cSHAA OR $set[$i] == 80+$cPEI OR $set[$i] == 80 + $cCHUN OR $set[$i] == 80 + $cHATSU OR $set[$i] == 80 + $cHAKU Then
			   $SetsPasses = 1
			   ;msgbox(0, "Set "& $i+1 &" passes", $f)
			Else
			   $SetsPasses = 0
			   ;msgbox(0, "FAILED", "Pair" & $i+1)
			   $ChantaiyaoTrue = 0
			   return
			EndIf
		 Next
		 if $set[4] == 200+$cMAN1 OR $set[4] == 200+$cMAN9 OR $set[4] == 200+$cSOU1 OR $set[4] == 200+$cSOU9 OR $set[4] == 200 + $cPIN1 OR $set[4] == 200 + $cPIN9 OR $set[4] == 200+$cTON OR $set[4] == 200+$cNAN OR $set[4] == 200+$cSHAA OR $set[4] == 200+$cPEI OR $set[4] == 200 + $cCHUN OR $set[4] == 200 + $cHATSU OR $set[4] == 200 + $cHAKU Then
			   $Pairpasses = 1
			   ;msgbox(0, "Pair1 passes", "Pair1")
		 EndIf
	  EndIf
   Next

   if $SetsPasses == 1 And $Pairpasses == 1 Then
	  $ChantaiyaoTrue = 1
	  return
   EndIf

   $ChantaiyaoTrue = 0

EndFunc

; Ikkitsuukan / Straight
; 1-2-3 4-5-6 7-8-9 of the same suit
Func Ikkitsuukan()
   $IkkitsuukanTrue = 0

   ; Impossible for a straight
   if NoChi() == 1 Then
	  $IkkitsuukanTrue = 0
	  Return
   EndIf

   ; Ikkitsukan
   For $i = 10 to 30 Step 10
   If ChiOf($i+1) == 1 AND ChiOf($i+4) == 1 AND ChiOf($i+7) Then
	  $IkkitsuukanTrue = 1
	  return
   EndIf
   Next
   $IkkitsuukanTrue = 0
EndFunc

; The same sequence in three suits.
Func Sanshoku_Doujin()
   $SanshokuDoujinTrue = 0

   ; If there's no Chi then there's no Sanshoku
   If NoChi() == 1 Then
	  $SanshokuDoujinTrue = 0
	  return
   EndIf

   ; if we find a Chi, search for the other two aswell. (+10 & +20)
   For $i = 0 to 3 Step 1
	  if $set[$i] == 11 Then
		 If ChiOf(21) == 1 AND ChiOf(31) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  elseif $set[$i] == 12 Then
		 If ChiOf(22) == 1 AND ChiOf(32) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  elseif $set[$i] == 13 Then
		 If ChiOf(23) == 1 AND ChiOf(33) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  elseif $set[$i] == 14 Then
		 If ChiOf(24) == 1 AND ChiOf(34) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  elseif $set[$i] == 15 Then
		 If ChiOf(25) == 1 AND ChiOf(35) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  elseif $set[$i] == 16 Then
		 If ChiOf(26) == 1 AND ChiOf(36) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  elseif $set[$i] == 17 Then
		 If ChiOf(27) == 1 AND ChiOf(37) == 1 Then
			$SanshokuDoujinTrue = 1
			Return
		 EndIf
	  EndIf
   Next

   $SanshokuDoujinTrue = 0

EndFunc

; Yakuhai / Fanpai
; Dragon(s), Seat Wind or Round Wind, all worth 1 Han per set.
Func Yakuhai()
   $YakuhaiTrue = 0

   ; Check for Pon or Kan of RoundWind
   If KanOf($rWind) == 1 OR PonOf($rWind) == 1 Then
	  $YakuhaiTrue = 1
	  $han += 1
   EndIf

   ; Check for Pon or Kan of SeatWind
   If KanOf($sWind) == 1 OR PonOf($sWind) == 1 Then
	  $YakuhaiTrue = 1
	  $han += 1
   EndIf

   ; Check for Pon or Kan of Haku
   if KanOf($cHAKU) == 1 OR PonOf($cHAKU) == 1 Then
	  $YakuhaiTrue = 1
	  $han += 1
   EndIf

   ; Check for Pon or Kan of Chun
   if KanOf($cCHUN) == 1 OR PonOf($cCHUN) == 1 Then
	  $YakuhaiTrue = 1
	  $han += 1
   EndIf

   ; Check for Pon or Kan of Hatsu
   if KanOf($cHATSU) == 1 OR PonOf($cHATSU) == 1 Then
	  $YakuhaiTrue = 1
	  $han += 1
   EndIf

   ; If any if triggered YakuhaiTrue then Return to avoid YakuhaiTrue = 0
   if $YakuhaiTrue = 1 Then
	  Return
   EndIf

   $YakuhaiTrue = 0
EndFunc

; iipeikou / double sequence
; Concealed: yes
; 2 Chi that have the same value
Func Iipeikou()
   $IipeikouTrue = 0

   ; If there aren't any sequences no point in checking.
   if NoChi() == 1 Then
	  $IipeikouTrue = 0
	  return
   EndIf

   ; If it's not concealed then no points.
   if Concealed() == -1 Then
	  $IipeikouTrue = 0
	  return
   EndIf

   ; Check sets 0,1,2,3 (main sets) for Chi values that are the same.

   ; Set 0 vs 1,2,3, if any of these statements are true, then Iipeikou
   If $set[0] == $set[1] OR $set[0] == $set[2] OR $set[0] == $set[3] Then
	  $IipeikouTrue = 1
	  return
   EndIf

   ; Set 1 vs 2,3
   If $set[1] == $set[2] OR $set[1] == $set[3] Then
	  $IipeikouTrue = 1
	  return
   EndIf

   ; Set 2 vs 3
   If $set[2] == $set[3] Then
	  $IipeikouTrue = 1
	  return
   EndIf

   ; If the above are not true, then no Iipeikou
   $IipeikouTrue = 0
EndFunc

; Tanyao / All Simples
; A hand with no terminal and honour tiles, that is every tile in the hand is a suit tile between 2 and 8.
Func Tanyao()
   $tanyaoTrue = 0

   ; No Terminals
   If NoTerminals() == -1 Then
	  $tanyaoTrue = 0
	  return
   EndIf

   ; No Honours
   If NoHonours() == -1 Then
	  $tanyaoTrue = 0
	  return
   EndIf

   if AFilledHand() == -1 Then
	  $tanyaoTrue = 0
	  return
   EndIf

   $tanyaoTrue = 1
EndFunc

;   NO POINT / PINFU ;
;   A hand with no three or four of a kinds (all sequences and a pair).
;   The pair must value 0 points.
;   The waiting must an open wait (on 2 different tiles).
; 	Must be concealed
Func Pinfu()
   $pinfuTrue = 0

   ; Open Wait Requirement
   if $OpenWaitEnabled == 0 Then
	  $pinfuTrue = 0
	  return
   EndIf

   ; Concealed Requirement
   if Concealed() == -1 Then
	  $pinfuTrue = 0
	  return
   EndIf

   ; No Kan Allowed
   if NoKan() == -1 Then
	  $pinfuTrue = 0
	  return
   EndIf

   ; No Pon Allowed
   if NoPon() == -1 Then
	  $pinfuTrue = 0
	  return
   EndIf

   ; Pair must value 0 points ;

   ; No Round Wind
   if NoRoundWind() == -1 Then
	  $pinfuTrue = 0
	  return
   EndIf

   ; No Seat Wind
   if NoSeatWind() == -1 Then
	  $pinfuTrue = 0
	  return
   EndIf

   ; No Dragons
   if NoDragons() == -1 Then
	  $pinfuTrue = 0
	  return
   EndIf

   if AFilledHand() == -1 Then
	  $tanyaoTrue = 0
	  return
   EndIf

   $pinfuTrue = 1
EndFunc

; Check if hand is conealed, 1 if concealed, -1 if Opened
Func Concealed()
   For $i = 1 to 4 Step 1
	  if $setsThatAreOpen[$i] == 1 Then
		 return -1
	  EndIf
   Next
   return 1
EndFunc

; Check for Kan of <TileNum> return 1 if found
Func KanOf($cT)
   ; Kan value is 80 + TileNum
   $kanID = 80 + $cT

   for $i = 0 to 3 Step 1
	  If $set[$i] == $kanID Then
		 return 1
	  EndIf
   Next
   return -1
EndFunc

; Check for Pon of <TileNum> returns1 if found
Func PonOf($cT)
   ; Pon value is 40 + TileNum
   $ponID = 40 + $cT

   for $i = 0 to 3 Step 1
	  If $set[$i] == $ponID Then
		 return 1
	  EndIf
   Next
   return -1
EndFunc

; Find if a hand has a specific Chi returns 1 if found
Func ChiOf($chiID)

   for $i = 0 to 3 Step 1
	  If $set[$i] == $chiID Then
		 return 1
	  EndIf
   Next
   return -1
EndFunc

; Check for Kan, if no Kan returns 1
Func NoKan()
	  for $i = 0 to 3 Step 1
		 If $set[$i] >= 80 AND $set[$i] <= 199 Then
			;MsgBox(0, "KAN DETECTED", "Kan of " & TileTranslator($set[$i]-80))
			return -1
		 EndIf
	  Next
		 return 1
EndFunc

; Check for Pon, if no Pon returns 1
Func NoPon()
      for $i = 0 to 3 Step 1
		 if $set[$i] >= 40 and $set[$i] <= 76 Then
			;MsgBox(0, "PON DETECTED", "Pon of " & TileTranslator($set[$i]-40))
			return -1
		 EndIf
	  Next
		 return 1
EndFunc

; Check for Chi, if no Chi returns 1
Func NoChi()
      for $i = 0 to 3 Step 1
		 If $set[$i] >= 10 and $set[$i] <= 37 Then
		 ;MsgBox(0, "CHI DETECTED", "Chi with value: " & ChiTranslator($set[$i]))
		 return -1
	  EndIf
   Next
	  return 1
EndFunc

; Get Winds from GUI
Func getWinds()
   $rWindTemp = GUICtrlRead($comboRoundWind)
   $sWindTemp = GUICtrlRead($comboSeatWind)
   if $rWindTemp == "Ton                           East" Then
	  $rWind = $cTON
   ElseIf $rWindTemp == "Nan                         South" Then
	  $rWind = $cNAN
   ElseIf $rWindTemp == "Shaa                        West" Then
	  $rWind = $cSHAA
   ElseIf $rWindTemp == "Pei                           North" Then
	  $rWind = $cPEI
   Else
	  MsgBox( 0, "Select a Round Wind!", "Please, select a Round Wind")
	  return false
   EndIf

   if $sWindTemp == "Ton                           East" Then
	  $sWind = $cTON
   ElseIf $sWindTemp == "Nan                         South" Then
	  $sWind = $cNAN
   ElseIf $sWindTemp == "Shaa                        West" Then
	  $sWind = $cSHAA
   ElseIf $sWindTemp == "Pei                           North" Then
	  $sWind = $cPEI
   Else
	  MsgBox( 0, "Select a Seat Wind!", "Please, select a Seat Wind")
	  return false
   EndIf
   return true
   ;GUICtrlSetData($debug, "Round wind: " & TileTranslator($rWind) & " Seat Wind: " & TileTranslator($sWind))
EndFunc

; Goes through the hand looking for the tile, if it's found it'll return 1 otherwise -1
Func SearchHandFor($tile)
   for $i = 1 to 18 Step 1
	  If $hand[$i] == $tile Then
		 return 1
	  EndIf
   Next
   return -1
EndFunc

; Search Hand For dragon Tiles
; -1 if Dragon Tile found, 1 if no Dragon tiles
Func NoDragons()
   ; No Haku
   if SearchHandFor($cHAKU) == 1 Then
	  return -1
   EndIf

   ; No Chun
   if SearchHandFor($cCHUN) == 1 Then
	  return -1
   EndIf

   ; No Hatsu
   if SearchHandFor($cHATSU) == 1 Then
	  return -1
   EndIf

   ; No Honour Tile
   return 1

EndFunc

; If roundwind is found -1 else 1
Func NoRoundWind()

   if SearchHandFor($rWind) == 1 Then
	  return -1
   EndIf
   return 1

EndFunc

; if Seatwind is found -1
Func NoSeatWind()
   if SearchHandFor($sWind) == 1 Then
	  return -1
   EndIf
   return 1

EndFunc

; No Winds, if wind is found -1
Func NoWinds()

   if SearchHandFor($cTON) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cNAN) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cSHAA) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cPEI) == 1 Then
	  return -1
   EndIf

   return 1
EndFunc

; No Honours, No Winds & No Dragons
; -1 if Honours found
Func NoHonours()

   if NoDragons() == -1 Then
	  return -1
   EndIf

   if NoWinds() == -1 Then
	  return -1
   EndIf

   return 1

EndFunc

; No Terminals, 1 or 9 tiles, if Terminals are found returns -1
Func NoTerminals()

   if SearchHandFor($cMAN1) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cSOU1) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cPIN1) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cMAN9) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cSOU9) == 1 Then
	  return -1
   EndIf

   if SearchHandFor($cPIN9) == 1 Then
	  return -1
   EndIf

   return 1

EndFunc

; Check if atleast Tiles 1,2,3 5,6,7 9,10,11 13,14,15 & 17,18 are not empty.
Func NotFilledMin()

   For $i = 1 to 3 Step 1
	  if $hand[$i] == "empty" Then
		 MsgBox(0, "Not Filled", "Please fill up the blank spots, or enable 13 orphans / 7 pairs")
		 Return
	  EndIf
   Next

   For $i = 5 to 7 Step 1
	  if $hand[$i] == "empty" Then
		 MsgBox(0, "Not Filled", "Please fill up the blank spots, or enable 13 orphans / 7 pairs")
		 Return
	  EndIf
   Next

   For $i = 9 to 11 Step 1
	  if $hand[$i] == "empty" Then
		 MsgBox(0, "Not Filled", "Please fill up the blank spots, or enable 13 orphans / 7 pairs")
		 Return
	  EndIf
   Next

   For $i = 13 to 15 Step 1
	  if $hand[$i] == "empty" Then
		 MsgBox(0, "Not Filled", "Please fill up the blank spots, or enable 13 orphans / 7 pairs")
		 Return
	  EndIf
   Next

   For $i = 17 to 18 Step 1
	  if $hand[$i] == "empty" Then
		 MsgBox(0, "Not Filled", "Please fill up the blank spots, or enable 13 orphans / 7 pairs")
		 Return
	  EndIf
   Next

EndFunc

; -1 if Hand contains empty at spots that HAVE to be filled
Func AFilledHand()

   For $i = 1 to 3 Step 1
	  if $hand[$i] == "empty" Then
		 Return -1
	  EndIf
   Next

   For $i = 5 to 7 Step 1
	  if $hand[$i] == "empty" Then
		 Return -1
	  EndIf
   Next

   For $i = 9 to 11 Step 1
	  if $hand[$i] == "empty" Then
		 Return -1
	  EndIf
   Next

   For $i = 13 to 15 Step 1
	  if $hand[$i] == "empty" Then
		 Return -1
	  EndIf
   Next

   For $i = 17 to 18 Step 1
	  if $hand[$i] == "empty" Then
		 Return -1
	  EndIf
   Next

   Return 1
EndFunc
