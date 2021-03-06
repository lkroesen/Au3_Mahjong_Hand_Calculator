; In this .au3 we'll perform han calculations

; When pressing "Done" or F5 this part of the program will calculate the hand name & the points associated
; Thanks to "Checker" in HotKeys.au3 all Set arrays will have a unique value for all sets/pairs
; using these unique numbers we can check for requirements and calculate the value.

; "Main" of HanCalc, this method gets called to initiate the calculation.
Global $han
Global $rWind
Global $sWind
Global $FullHandName = ""
Global $nYaku = 0
Global $exMessage = ""

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

; Yakuman Declarations
Global $bKokushi = False
Global $bDaisangen = False
Global $bShousuushii = False
Global $bDaiSuushii = False
Global $bChuurenPoutou = False
Global $bSuuAnkou = False
Global $bRyuuiisou = False
Global $bSuuKantsu = False
Global $bTsuuIisou = False
Global $bChinroutou = False

; Classifications
Global $boolYakuman = False
Global $boolDoubleYakuman = False

; Extra
Global $boolPair = false

Func Calculate()
   YakuSitMain()
   ; Get wind directions off of GUI
   getWinds()


   $FullHandName = ""
   $FullHandName &= $YakuSitName
   $han = 0
   $fu = 0
   $nYaku = 0

   $boolYakuman = False
   $boolDoubleYakuman = False

   DoraMain()
   $han += $doraHan
   $nYaku += $nYakuSit

   If $YakuSitHan == "mangan" Then
	  ; No Calculations, the hand is a mangan.
	  $han = "Mangan"
	  FuMain()
	  $exMessage = $FullHandName
	  $FullHandName &= " [Han: " & $han & " Fu: " & $fu & "]"
	  $FullHandName &= "   Amount of Yaku: " & $nYaku
	  GUICtrlSetData($fullNameOfHand, $FullHandName)
	  Return
   EndIf

   #Region Yakuman Detections
   If $YakuSitHan == "yakuman" Then
	  $boolYakuman = True
   EndIf

   Daisangen()
   Shousuushii()
   DaiSuushii()
   NineGates()
   SuuKantsu()
   SuuAnkou()
   Ryuuiisou()
   Tsuu_iisou()
   Chinroutou()
   Kokushi_Musou()
   #EndRegion

   ; Exception for Nine gates
   if $NineGates == True Then
	  If $bChuurenPoutou == True Then
		 $FullHandName &= "Nine Gates "
	  Else
		 GUICtrlSetData($fullNameOfHand, "Not Nine Gates")
		 return
	  EndIf

	  FuMain()
	  if $boolDoubleYakuman == True Then
		 DoubleYakumanScr()
	  Else
		 YakumanScr()
	  EndIf
	  $exMessage = $FullHandName
	  $FullHandName &= "(" & $handworth & ")"
	  GUICtrlSetData($fullNameOfHand, $FullHandName)
	  $boolYakuman = True
	  Return
   EndIf


   if $boolYakuman == True Then
	  If $bDaisangen == True Then
		$FullHandName &= "Daisangen / Big Three Dragons "
	  EndIf

	  If $bShousuushii == True Then
		 $FullHandName &= "Shousuushii / Little Four Winds "
	  EndIf

	  If $bDaiSuushii == True Then
		 $FullHandName &= "Dai Suushii / Big Four Winds "
	  EndIf

	  if $bSuuAnkou == true Then
		 $FullHandName &= "Suu ankou / Four Concealed Triplets "
	  EndIf

	  if $bRyuuiisou == true Then
		 $FullHandName &= "Ryuuiisou / All Green "
	  EndIf

	  if $bSuuKantsu == true Then
		 $FullhandName &= "Suu kantsu / Four kongs "
	  EndIf

	  if $bTsuuIisou == true Then
		 $FullhandName &= "Tsuu iisou / All Honours "
	  EndIf

	  if $bChinroutou = true Then
		 $FullHandName &= "Chinroutou / All Terminals "
	  EndIf

	  If $bKokushi = True Then
		 $FullHandName &= "Kokushi musou / 13 Orphans "
	  EndIf

	  FuMain()
	  if $boolDoubleYakuman == True Then
		 DoubleYakumanScr()
	  Else
		 YakumanScr()
	  EndIf
	  $exMessage = $FullHandName
	  $FullHandName &= "(" & $handworth & ")"
	  GUICtrlSetData($fullNameOfHand, $FullHandName)
	  Return
   Else
   $han += $YakuSitHan
   #Region Normal Yaku
	  #Region Seven Pairs
	  ; Honroutou possible (if it is then it's called: Honroochiitoi)
	  ; Tsuu iisou possible (Yakuman) TODO ADD DETECT
	  ; Allowed Situations:
	  ; Houtei's also allowed
	  ; Riichi & Double Riichi
	  ; Ippatsu (one-shot)
	  ; Tsumo
	  If $SevenPairsEnabled == 1 Then
		 $han += 2
		 $nYaku += 1

		 Honroutou()
		 Itsu()

		 ; Check for Kuitan / All Simples
		 If NoTerminals() == 1 AND NoHonours() == 1 Then
			$FullHandName &= "Kuitan "
			$han += 1
			$nYaku += 1
		 EndIf

		 ; Check for Honroutou
		 if $HonroutouTrue == 1 Then
			$FullHandName &= "Honroochiitoi "
			$han += 2
			$nYaku += 1
		 EndIf

		 ; Check for Honitsu
		 If $bHonitsu = True Then
			if Concealed() == -1 Then
			   $han+=2
			Else
			   $han+=3
			EndIf

			if $bChinitsu == True Then
			   ; do nuffin
			Else
			   $FullHandName &= "Honitsu "
			   $nYaku+=1
			EndIf
		 EndIf

		 ;  Check for Chinitsu
		 if $bChinitsu == True Then
			$FullHandName &= "Chinitsu "
			$han += 3
			$nYaku+=1
		 EndIf
		 FuSevenPairs()
		 PointCalculation()
		 $FullHandName &= "Chiitoitsu "
		 $exMessage = $FullHandName
		 $FullHandName &= " [Han: " & $han & " Fu: " & $fu & "]"
		 $FullHandName &= "   Yaku: " & $nYaku
		 $FullHandName &= " (" & $handworth & ")"
		 GUICtrlSetData($fullNameOfHand, $FullHandName)
		 return
	  EndIf
	  #EndRegion Seven Pairs

	  ; 13 Orphans Exception

	  ; Check if atleast Tiles 1,2,3 5,6,7 9,10,11 13,14,15 & 17,18 are not empty.
	  NotFilledMin()

	  #Region Yaku
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
	  Sanshokudoukou()
	  Shou_Sangen()
	  Honitsu()
	  Junchan()
	  Ryanpeikou()
	  Chinitsu()
	  #EndRegion Yaku

	  #Region Yaku-Ifs
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
		 if $bRyanpeikou == True Then
			$nYaku += 0
		 Else
		 $nYaku += 1
		 $FullHandName &= "Iipeikou "
		 EndIf
		 $han += 1
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

	  ; Check for Sanshokudoukou
	  If $bSanshokudoukou == True Then
		 $han+=2
		 $FullHandName &= "Sanshoku Doukou "
		 $nYaku+=1
	  EndIf

	  ; Check for Shou Sangen
	  If $bShouSangen == True Then
		 $han+=2
		 $FullHandName &= "Shou Sangen "
		 $nYaku+=1
	  EndIf

	  ; Check for Honitsu
	  If $bHonitsu = True Then
		 if Concealed() == -1 Then
			$han+=2
		 Else
			$han+=3
		 EndIf

		 if $bChinitsu == True Then
			; do nuffin
		 Else
			$FullHandName &= "Honitsu "
			$nYaku+=1
		 EndIf
	  EndIf

	  ; Check for Junchan Tayao
	  If $bJunchan == True Then
		 if Concealed() == -1 Then
			$han+=2
		 Else
			$han+=3
		 EndIf
		 $FullHandName &= "Junchan "
		 $nYaku+=1
	  EndIf

	  ; Check for Ryanpeikou
	  If $bRyanpeikou == True Then
		 $FullHandName &= "Ryanpeikou "
		 $han += 2
		 $nYaku+=1
	  EndIf

	  ;  Check for Chinitsu
	  if $bChinitsu == True Then
		 $FullHandName &= "Chinitsu "
		 $han += 3
		 $nYaku+=1
	  EndIf
	  #EndRegion Yaku-Ifs
   ; Calculate Fu after doing Han.
   FuMain()
   PointCalculation()
   $FullHandName &= "Dora " & $nDora & " "
   $exMessage = $FullHandName
   $FullHandName &= " [Han: " & $han & " Fu: " & $fu & "]"
   $FullHandName &= "   Yaku: " & $nYaku
   $FullHandName &= " (" & $handworth & ")"
   GUICtrlSetData($fullNameOfHand, $FullHandName)
   #EndRegion Normal Yaku
EndIf
EndFunc

#Region Yakuman Func
; 13 Orphans
Func Kokushi_Musou()
   $bKokushi = False

   If SearchHandFor($cMAN1) == 1 Then
	  If SearchHandFor($cMAN9) == 1 Then
		 if SearchHandFor($cSOU1) == 1 Then
			if SearchHandFor($cSOU9) == 1 Then
			   if SearchHandFor($cPIN1) == 1 Then
				  if SearchHandFor($cPIN9) == 1 Then
					 if SearchHandFor($cTON) == 1 Then
						if SearchHandFor($cNAN) == 1 Then
						   if SearchHandFor($cSHAA) == 1 Then
							  if SearchHandFor($cPEI) == 1 Then
								 if SearchHandFor($cCHUN) == 1 Then
									if SearchHandFor($cHAKU) == 1 Then
									   if SearchHandFor($cHATSU) == 1 Then
										  If FinalKukoshiCheck() == true Then
											 YakumanTrue()
											 $bKokushi = True
											 If $waitType == 13 Then
												YakuManTrue()
											 EndIf
											 Return
										  EndIf
									   EndIf
									EndIf
								 EndIf
							  EndIf
						   EndIf
						EndIf
					 EndIf
				  EndIf
			   EndIf
			EndIf
		 EndIf
	  EndIf
   EndIf

   ; If Kokushi is not true, check that the hand conssists of 7 pairs.
   If $SevenPairsEnabled == 1 Then
	  For $i = 0 to 6 Step 1
		 if $set[$i] < 0 Then
			msgbox(0, "Illegal Hand!", "No Yaku found, this means that this hand is illegal!")
			return
		 EndIf
	  Next
   EndIf
EndFunc

; FinalKukoshiCheck()
Func FinalKukoshiCheck()
   If $hand[14] == ($cMAN1)  or $hand[14] == ($cMAN9)  or $hand[14] == ($cSOU1)  or $hand[14] == ($cSOU9)  or $hand[14] == ($cPIN1)  or $hand[14] == ($cPIN9)  or $hand[14] == ($cTON)  or $hand[14] == ($cNAN)  or $hand[14] == ($cSHAA)  or $hand[14] == ($cPEI)  or $hand[14] == ($cCHUN)  or $hand[14] == ($cHAKU)  or $hand[14] == ($cHATSU)  Then
	  return True
   EndIf

   return False
EndFunc

; Chinroutou / All Terminals
Func Chinroutou()
   $bChinroutou = False

   For $i = 1 to 18 Step 1
	  if $hand[$i] == $cMAN1 or $hand[$i] == $cMAN9 or $hand[$i] == $cSOU1 or $hand[$i] == $cSOU9 or $hand[$i] == $cPIN1 or $hand[$i] == $cPIN9 or $hand[$i] == "empty" Then
		 if $i == 18 Then
			$bTsuuIisou = true
			YakumanTrue()
		 EndIf
	  Else
		 ExitLoop
	  EndIf
   Next

EndFunc

; Tsuu iisou / All Honours
Func Tsuu_iisou()
   $bTsuuIisou = False

   For $i = 1 to 18 Step 1
	  if $hand[$i] == $cTON or $hand[$i] == $cNAN or $hand[$i] == $cSHAA or $hand[$i] == $cPEI or $hand[$i] == $cCHUN or $hand[$i] == $cHATSU or $hand[$i] == $cHAKU or $hand[$i] == "empty" Then
		 if $i == 18 Then
			$bTsuuIisou = true
			YakumanTrue()
		 EndIf
	  Else
		 ExitLoop
	  EndIf
   Next

EndFunc

; Suu kantsu / 4 kongs
Func SuuKantsu()
   $bSuuKantsu = false

   if $boolDoubleYakuman == True Then
	  Return
   EndIf

   For $i = 0 to 3 Step 1
	  if $set[$i] >= 80 and $set[$i] <= 199 Then
		 ; Do nothing
	  Else
		 Return
	  EndIf
   Next

   YakumanTrue()
   $bSuuKantsu = True
EndFunc

; Ryuuiisou / All Green
Func Ryuuiisou()
   $bRyuuiisou = False

   For $i = 1 to 18 Step 1
	  if $hand[$i] == $cSOU2 or $hand[$i] == $cSOU3 or $hand[$i] == $cSOU4 or $hand[$i] == $cSOU6 or $hand[$i] == $cSOU8 or $hand[$i] == $cHATSU or $hand[$i] == "empty" Then
		 ;msgbox(0, "Green", TileTranslator($hand[$i]))
	  Else
		 return
	  EndIf
   Next

   $bRyuuiisou = true
   YakumanTrue()

EndFunc

; 4 Concealed Trips
Func SuuAnkou()
   $bSuuAnkou = False

   if Concealed() == -1 Then
	  Return
   EndIf

   For $i = 0 to 3 Step 1
	  if $set[$i] >= 40 and $set[$i] <= 199 Then
	  ; Do nothing
	  Else
		 Return
	  EndIf
   Next

   $bSuuAnkou = true
   YakumanTrue()

   If $boolPair == True Then
	  YakumanTrue()
   EndIf


EndFunc

; Chuuren Poutou
Func NineGates()
   $bChuurenPoutou = False

   if Concealed() == -1 Then
	  Return
   EndIf

   if $hand[1] == 0 Then
	  if $hand[2] == 0 and $hand[3] == 0 Then
		 if $hand[4] == 1 Then
			if $hand[5] == 2 Then
			   if $hand[6] == 3 Then
				  if $hand[7] == 4 or $hand[7] == 5 Then
					 if $hand[8] == 6 Then
						if $hand[9] == 7 Then
						   if $hand[10] == 8 Then
							  if $hand[11] == 9 and $hand[12] == 9 and $hand[13] == 9 Then
								 if $hand[14] >= 0 and $hand[14] <= 9 Then
									$bChuurenPoutou = true
									YakumanTrue()
									if $waitType == 9 Then
									   YakumanTrue()
									EndIf
								 EndIf
							  EndIf
						   EndIf
						EndIf
					 EndIf
				  EndIf
			   EndIf
			EndIf
		 EndIf
	  EndIf
   elseif $hand[1] == 10 Then
	  if $hand[2] == 10 and $hand[3] == 10 Then
		 if $hand[4] == 11 Then
			if $hand[5] == 12 Then
			   if $hand[6] == 13 Then
				  if $hand[7] == 14 or $hand[7] == 15 Then
					 if $hand[8] == 16 Then
						if $hand[9] == 17 Then
						   if $hand[10] == 18 Then
							  if $hand[11] == 19 and $hand[12] == 19 and $hand[13] == 19 Then
								 if $hand[14] >= 10 and $hand[14] <= 19 Then
									$bChuurenPoutou = true
									YakumanTrue()
									if $waitType == 9 Then
									   YakumanTrue()
									EndIf
								 EndIf
							  EndIf
						   EndIf
						EndIf
					 EndIf
				  EndIf
			   EndIf
			EndIf
		 EndIf
	  EndIf
   elseif $hand[1] == 20 Then
	  if $hand[2] == 20 and $hand[3] == 20 Then
		 if $hand[4] == 21 Then
			if $hand[5] == 22 Then
			   if $hand[6] == 23 Then
				  if $hand[7] == 24 or $hand[7] == 25 Then
					 if $hand[8] == 26 Then
						if $hand[9] == 27 Then
						   if $hand[10] == 28 Then
							  if $hand[11] == 29 and $hand[12] == 29 and $hand[13] == 29 Then
								 if $hand[14] >= 20 and $hand[14] <= 29 Then
									$bChuurenPoutou = true
									YakumanTrue()
									if $waitType == 9 Then
									   YakumanTrue()
									EndIf
								 EndIf
							  EndIf
						   EndIf
						EndIf
					 EndIf
				  EndIf
			   EndIf
			EndIf
		 EndIf
	  EndIf
   EndIf
EndFunc

; Big Four Winds / Dai Suushii
Func DaiSuushii()
   $bDaiSuushii = False

   if AmountOfWindKtsu() == 4 Then
	  $bDaiSuushii = True
	  YakumanTrue()
	  YakumanTrue()
   EndIf

EndFunc

; Little Four Winds / Shousuushii
Func Shousuushii()
   $bShousuushii = False

   ; check for the pair needed, then when AmountOfWindKtsu is 3, Yakuman.
   if PairOf($cTON) == 1 OR PairOf($cNAN) == 1 OR PairOf($cSHAA) == 1 OR PairOf($cPEI) == 1 Then
	  if AmountOfWindKtsu() == 3 Then
		 $bShousuushii = true
		 YakumanTrue()
	  EndIf
   EndIf
EndFunc

; Return the amount of Pon/Kan of winds found
Func AmountOfWindKtsu()
   $nWinds = 0

   if PonOf($cTON) == 1 or KanOf($cTON) == 1 Then
	  $nWinds += 1
   EndIf

   If PonOf($cNAN) == 1 or KanOf($cNAN) == 1 Then
	  $nWinds += 1
   EndIf

   If PonOf($cSHAA) == 1 or KanOf($cSHAA) == 1 Then
	  $nWinds += 1
   EndIf

   If PonOf($cPEI) == 1 or KanOf($cPEI) == 1 Then
	  $nWinds += 1
   EndIf

   return $nWinds

EndFunc

; Big Three Dragons, hand has Pon or Kan of all Dragons
Func Daisangen()
   $bDaisangen = False

   if PonOf($cCHUN) == 1 OR KanOf($cCHUN) == 1 Then
	  if PonOf($cHAKU) == 1 or KanOf($cHAKU) == 1 Then
		 if PonOf($cHATSU) == 1 or KanOf($cHATSU) == 1 Then
			$bDaisangen = true
			YakumanTrue()
			Return
		 EndIf
	  EndIf
   EndIf
EndFunc

Func YakumanTrue()
   if $boolYakuman == True Then
	  $boolDoubleYakuman = True
   Else
	  $boolYakuman = True
   EndIf
EndFunc
#EndRegion Yakuman Func

#Region Normal Yaku Func
; Honitsu/Chinitsu for 7 Pairs
Func Itsu()
   $bHonitsu = False
   $bChinitsu = False

   $suit = -1
   ; Find any suit tile
   for $i=1 to 13 Step 2
	  If $hand[$i] >= 0 AND $hand[$i] <= 9 Then
		 if $suit == -1 OR $suit == 1 Then
			; No man was found prior, or a man was found prior, everything is ok!
			$suit = 1
		 Else
			; A tile other than man has been found as the $suit is no longer -1 or is equal to 1
			 $bHonitsu = False
			 return
		 EndIf
	  elseif $hand[$i] >= 10 AND $hand[$i] <= 19 Then
		 if $suit == -1 OR $suit == 2 Then
			; No man Sou found prior, or a Sou was found prior, everything is ok!
			$suit = 2
		 Else
			; A tile other than Sou has been found as the $suit is no longer -1 or is equal to 2
			 $bHonitsu = False
			 return
		 EndIf
	  elseif $hand[$i] >= 20 AND $hand[$i] <= 29 Then
		 if $suit == -1 OR $suit == 3 Then
			; No Pin found prior, or a Pin was found prior, everything is ok!
			$suit = 3
		 Else
			; A tile other than Sou has been found as the $suit is no longer -1 or is equal to 3
			 $bHonitsu = False
			 return
		 EndIf
	  EndIf
   Next
   ;msgbox(0, "Honitsu Passes", $suit)
   $bHonitsu = True

   if NoHonours() == 1 Then
	  $bChinitsu = True
   EndIf

EndFunc

; Chinitsu is a Honitsu without honours
Func Chinitsu()
   $bChinitsu = False

   if $bHonitsu == True AND NoHonours() == 1 Then
	  $bChinitsu = True
   EndIf

EndFunc

; Ryanpeikou
; The hand contains two different Iipeikouís. Must be concealed.
Func Ryanpeikou()
   $bRyanpeikou = False

   If $IipeikouTrue == 0 Then
	  Return; No need to check since this is 2 iipeikou
   EndIf

   ; If there aren't any sequences no point in checking.
   if NoChi() == 1 Then
	  $bRyanpeikou = False
	  return
   EndIf

   ; If it's not concealed then no points.
   if Concealed() == -1 Then
	  $bRyanpeikou = False
	  return
   EndIf

   ; Possible scenarios:
   ; 0/1  2/3
   ; 0/2  1/3
   ; 0/3  1/2
   if $set[0] == $set[1] AND $set[2] == $set[3] Then
	  $bRyanpeikou = True
   ElseIf $set[0] == $set[2] AND $set[1] == $set[3] Then
	  $bRyanpeikou = True
   ElseIf $set[0] == $set[3] AND $set[2] == $set[1] Then
	  $bRyanpeikou = True
   Else
	  $bRyanpeikou = False
   EndIf
EndFunc

; Junchan Tayao
Func Junchan()
   $bJunchan = False

   ; A junchan is basically a Chantaiyao without honours
   If $ChantaiyaoTrue == 1 AND NoHonours() == 1 Then
	  $bJunchan = True
   EndIf

EndFunc

; Honitsu / Dirty Flush
; The hand contains tiles from a single suit plus honours (Hence dirty)
Func Honitsu()
   $bHonitsu = False

   If AFilledHand() == -1 Then
	  Return
   EndIf

   $suit = -1
   ; Find any suit tile
   for $i=1 to 17 Step 4
	  If $hand[$i] >= 0 AND $hand[$i] <= 9 Then
		 if $suit == -1 OR $suit == 1 Then
			; No man was found prior, or a man was found prior, everything is ok!
			$suit = 1
		 Else
			; A tile other than man has been found as the $suit is no longer -1 or is equal to 1
			 $bHonitsu = False
			 return
		 EndIf
	  elseif $hand[$i] >= 10 AND $hand[$i] <= 19 Then
		 if $suit == -1 OR $suit == 2 Then
			; No man Sou found prior, or a Sou was found prior, everything is ok!
			$suit = 2
		 Else
			; A tile other than Sou has been found as the $suit is no longer -1 or is equal to 2
			 $bHonitsu = False
			 return
		 EndIf
	  elseif $hand[$i] >= 20 AND $hand[$i] <= 29 Then
		 if $suit == -1 OR $suit == 3 Then
			; No Pin found prior, or a Pin was found prior, everything is ok!
			$suit = 3
		 Else
			; A tile other than Sou has been found as the $suit is no longer -1 or is equal to 3
			 $bHonitsu = False
			 return
		 EndIf
	  EndIf
   Next
   ;msgbox(0, "Honitsu Passes", $suit)
   $bHonitsu = True
EndFunc

; Shou Sangen / Little Three Dragons
; Requirement: Any 2 pon of dragon tiles any pair of dragon tiles
Func Shou_Sangen()
   $bShouSangen = False

   if PonOf($cCHUN) == 1 OR KanOf($cCHUN) == 1 Then
	  ;msgbox(0, "chun", "chun passed")
	  if PonOf($cHAKU) == 1 or PonOf($cHATSU) == 1 or KanOf($cHAKU) == 1 or KanOf($cHATSU) == 1 Then
		 ;msgbox(0, "haku/hatsu", "haku/hatsu passed")
		 if PairOf($cHAKU) == 1 or PairOf($cHATSU) == 1 Then
			;msgbox(0, "pair", "pair passed")
			$bShouSangen = true
		 EndIf
	  EndIf
   elseif PonOf($cHAKU) == 1 OR KanOf($cHAKU) == 1 Then
	  if PonOf($cCHUN) == 1 or PonOf($cHATSU) == 1 OR KanOf($cCHUN) == 1 or KanOf($cHATSU) == 1 Then
		 if PairOf($cCHUN) == 1 or PairOf($cHATSU) == 1 Then
			$bShouSangen = true
		 EndIf
	  EndIf
   elseif PonOf($cHATSU) == 1 OR KanOf($cHATSU) == 1 Then
	  if PonOf($cHAKU) == 1 or PonOf($cCHUN) == 1 OR KanOf($cHAKU) == 1 or KanOf($cCHUN) == 1 Then
		 if PairOf($cHAKU) == 1 or PairOf($cCHUN) == 1 Then
			$bShouSangen = true
		 EndIf
	  EndIf
   EndIf
EndFunc

; Sanshoku doukou / Three colour triplets
; Three triplets consisting of the same numbers in all three suits.
Func Sanshokudoukou()
   $bSanshokudoukou = False

   For $i = 0 to 3 Step 1
	  if $set[$i] >= 40 AND $set[$i] <= 49 Then ; Pon of Man
		 For $f = 0 to 3 Step 1
			if $set[$i]+10 == $set[$f] Then ; Found the Sou
			   For $g = 0 to 3 Step 1
				  if $set[$i]+20 == $set[$g] Then ; found the Pin
					 $bSanshokudoukou = True
					 return
				  EndIf
			   Next
			EndIf
		 Next
	  EndIf
   Next

   $bSanshokudoukou = False

EndFunc

; Find the Chi,Pon or Kan that is Man, can only be 2 at max, if there's more it's not a Sanshokudoukou
; if any set+20 is equal to 30 or higher it's not Man.
; Chi man 1-2-3 = 11 + 20 = 31
; Pon Man 1 = 40 + 0 = 40
; Kan Man 1 = 80 + 0 = 80
; If true, then there's 2 sets with a different suit, find the next in the next if
; Only if Man is $set[0], so, find the Man set, there can be at max 2.
Func ManSuit($inputSet, $loopcount)
   If $inputSet >= 11 AND $inputSet <= 17 Then
	  return true; Find out if $inputSet is a Man Chi , If not return false
   elseif $inputSet >= 40 AND $inputSet <= 49 Then
	  return true; Find out if $inputset is a Man Pon , If not return false
   elseif $inputSet >= 80 AND $inputSet <= 89 Then
	  return true; Find out if $inputSet is a Man Kan , If not return false
   Else
	  msgBox(0, "InputSet", "Nope at " & $loopcount)
	  return false
   EndIf
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

   if AFilledHand() == -1 Then
	  return
   EndIf

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
	  If ChiOf($i+1) == 1 AND ChiOf($i+4) == 1 AND ChiOf($i+7) == 1 Then
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

#EndRegion Normal Yaku Func

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

; Check for Pair of <TileNum> returns1 if found
Func PairOf($cT)
   ; Pair value is 200 + TileNum
   $ponID = 200 + $cT

   for $i = 0 to 6 Step 1
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
	  If $RandWind == True Then
		 $rWind = rndm()
	  Else
		 MsgBox( 0, "Select a Round Wind!", "Please, select a Round Wind or press F4 to disable this")
		 return false
	  EndIf
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
	  If $RandWind == True Then
		 $sWind = rndm()
	  Else
		 MsgBox( 0, "Select a Seat Wind!", "Please, select a Seat Wind or press F4 to disable this")
		 return false
	  EndIf
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
