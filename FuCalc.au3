;Calculate the amount of Fu
Global $fu
Global $WinOnRon = False ; if false, won on Tsumo
Global $waitType = 0 ; 1 = Edge, 2 = Closed, 3 = Single, 4 = Open

Func FuMain()
   $fu = 0

   WinFu()
   WaitFu()
   SetFu()
   PairFu()

   ; Exception Rule, If you have 0 fu and win on a Ron with an Opened hand your hand is worth 30 fu.
   If Concealed == -1 AND $WinOnRon == True AND $fu == 0 Then
	  $fu = 30
   EndIf

   ;msgbox(0,"Fu Calc", "Fu: " & $fu)
EndFunc

Func PairFu()
   ; 2 fu for certain pairs
   ; Dragons, Seat Wind, Round Wind
   ; $set[4] is always the pair set
   If $set[4] >= 200+$cCHUN AND $set[4] <= 200+$cHATSU Then
	  $fu += 2; Dragons
   ElseIf $set[4] == 200 + $rWind OR $set[4] == 200 + $sWind Then
	  $fu += 2; Round or Seat Wind
   EndIf
EndFunc

Func SetFu()
   ; Concealed Koutsu on Tsumo counts as closed,
   ; 	-1 no Kan or Pon
   ;	0, Un-Ided Pon
   ;	1, Un-Ided Kan
   ;	2, Pon of 2-8
   ;	3, Pon of Terminals/Honours
   ;	4, Kan of 2-8
   ;	5, Kan of Terminals/Honours
   Local $Ktsu[4] = [-1,-1,-1,-1]

   For $i = 0 to 3 Step 1
	  If $set[$i] >= 40 AND $set[$i] <= 79 Then
		 $Ktsu[$i] = 0
	  ElseIf $set[$i] >= 80 AND $set[$i] <= 199 Then
		 $Ktsu[$i] = 1
	  EndIf
   Next

   For $i = 0 to 3 Step 1
	  If $Ktsu[$i] == 0 Then
		 if $set[$i] >= 41 AND $set[$i] <= 48 AND $set[$i] >= 51 AND $set[$i] <= 58 AND $set[$i] >= 61 AND $set[$i] <= 68 Then
			$Ktsu[$i] = 2; Check 41 (Pon of 2man) to 48 (Pon of 8man) etc
		 Else
			$Ktsu[$i] = 3; else it's an honour or terminal
		 EndIf
	  elseif $Ktsu[$i] == 1 Then
		 if $set[$i] >= 81 AND $set[$i] <= 88 AND $set[$i] >= 91 AND $set[$i] <= 98 AND $set[$i] >= 101 AND $set[$i] <= 108 Then
			$Ktsu[$i] = 4; Check for Kans
		 Else
			$Ktsu[$i] = 5; terminals or honours
		 EndIf
	  EndIf
   Next

   ; $setsThatAreOpen[5]
   For $i = 0 to 3 Step 1
	 if $Ktsu[$i] == 2 Then
		 if $setsThatAreOpen[$i+1] == 0 Then
			$fu += 4
		 else
			$fu += 2
		 EndIf
	 ElseIf $Ktsu[$i] == 3 Then
		 if $setsThatAreOpen[$i+1] == 0 Then
			$fu += 8
		 else
			$fu += 4
		 EndIf
	 ElseIf $Ktsu[$i] == 4 Then
		 if $setsThatAreOpen[$i+1] == 0 Then
			$fu += 16
		 else
			$fu += 8
		 EndIf
	 ElseIf $Ktsu[$i] == 5 Then
		 if $setsThatAreOpen[$i+1] == 0 Then
			$fu += 32
		 else
			$fu += 16
		 EndIf
	 EndIf

   Next
EndFunc

Func WaitFu()
   ; 2 fu for Edge, Closed and Single
   If $waitType >= 1 and $waitType <= 3 Then
	  $fu += 2
   EndIf
EndFunc

Func WinFu()
   If Concealed() == 1 and $WinOnRon == True Then
	  $fu += 30
   EndIf

   If $WinOnRon == False Then
	  $fu += 20
   EndIf

   ; Win with an open hand (on ron)
   If Concealed() == -1 and $WinOnRon == True Then
	  $fu += 20
   EndIf

   ; Tsumo, if not on a pinfu
   If $pinfuTrue == 0 AND $WinOnRon == False Then
	  $fu += 2
   EndIf
EndFunc

Func FuSevenPairs()
   return 25 ; Seven pairs = 25 fu
EndFunc
