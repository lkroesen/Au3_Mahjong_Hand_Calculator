; Index all tiles by a unique number
; c <TileName> <Number>
Global Enum $cMAN1, $cMAN2, $cMAN3, $cMAN4, $cMAN5, $cMAN5r, $cMAN6, $cMAN7, $cMAN8, $cMAN9, $cSOU1, $cSOU2, $cSOU3, $cSOU4, $cSOU5, $cSOU5r, $cSOU6, $cSOU7, $cSOU8, $cSOU9, $cPIN1, $cPIN2, $cPIN3, $cPIN4, $cPIN5, $cPIN5r, $cPIN6, $cPIN7, $cPIN8, $cPIN9, $cTON, $cNAN, $cSHAA, $cPEI, $cCHUN, $cHAKU, $cHATSU
; Return 1 if it's a Man Chi
; Return 2 if it's a Sou Chi
; Return 3 if it's a Pin Chi
; n1 for a 123
; n2 for a 234
; n3 for a 345
; n4 for a 456
; n5 for a 567
; n6 for a 678
; n7 for a 789
Func Chi($tile1,$tile2,$tile3,$tile4)

   ; [1-3] Check for 1-2-3, 2-3-4, 3-4-5
   for $i = 0 to 3 Step 1
	  if $tile1 == $i+0 OR $tile1 == $i+10 OR $tile1 == $i+20 Then
		 if $tile2 == $i+1 OR $tile2 == $i+11 OR $tile2 == $i+21 Then
			if $tile3 == $i+2 OR $tile3 == $i+12 OR $tile3 == $i+22 Then
			   return suitCheck($tile1,$tile2,$tile3) + $i + 1
			EndIf
		 EndIf
	  EndIf
   Next
   ; [3] 3 - 4 - RED 5
	  if $tile1 == 2 OR $tile1 == 12 OR $tile1 == 22 Then
		if $tile2 == 3 OR $tile2 == 13 OR $tile2 == 23 Then
		   if $tile3 == 5 OR $tile3 == 15 OR $tile3 == 25 Then
			  return suitCheck($tile1,$tile2,$tile3) + 3
		   EndIf
		EndIf
	 EndIf

   ; [4] 4 - Red5 / 5 - 6
   if $tile1 == 3 or $tile1 == 13 OR $tile1 == 23 Then
	  if $tile2 == 4 OR $tile2 == 5 OR $tile2 == 14 OR $tile2 == 15 OR $tile2 == 25 OR $tile2 == 24 Then
		 if $tile3 == 6 OR $tile3 == 16 OR $tile3 == 26 Then
			return suitCheck($tile1,$tile2,$tile3) + 4
		 EndIf
	  EndIf
   EndIf

   ; [5] Red5/5 - 6 - 7
   if $tile1 == 4 OR $tile1 == 5 OR $tile1 == 14 OR $tile1 == 15 OR $tile1 == 25 OR $tile1 == 24 Then
	  if $tile2 == 6 OR $tile2 == 16 OR $tile2 == 26 Then
		 if $tile3 == 7 OR $tile3 == 17 OR $tile3 == 27 Then
			return suitCheck($tile1,$tile2,$tile3) + 5
		 EndIf
	  EndIf
   EndIf

   for $i = 6 to 9 Step 1
	   if $tile1 == $i+0 OR $tile1 == $i+10 OR $tile1 == $i+20 Then
		 if $tile2 == $i+1 OR $tile2 == $i+11 OR $tile2 == $i+21 Then
			if $tile3 == $i+2 OR $tile3 == $i+12 OR $tile3 == $i+22 Then
			   return suitCheck($tile1,$tile2,$tile3) + $i
			EndIf
		 EndIf
	  EndIf
   Next
EndFunc

; Returns 40 + that tile's number if it's a valid pon, otherwise performs a Chi check.
; so 40 to 76 are Pons
Func Pon($tile1,$tile2,$tile3,$tile4)
   if $tile1 == $tile2 Then
	  if $tile2 == $tile3 Then
		 if $tile4 == "empty" Then
			return 40+$tile1
		 EndIf
	  EndIf
   EndIf

   return Chi($tile1,$tile2,$tile3,$tile4)
EndFunc

; Returns 80 + that tile's number if it's a valid Kan
; Returns 0 if it isn't a Kan,Pon or Chi (So, it's probably a Double then)
Func Kan($tile1,$tile2,$tile3,$tile4)

   if $tile1 == $tile2 Then
	  if $tile3 == $tile4 Then
		 if $tile1 == $tile4 Then
		 return 80+$tile1
	  EndIf
   EndIf
EndIf
   return Pon($tile1,$tile2,$tile3,$tile4)
EndFunc

; Checks for 3/4 tile sets
Func CheckHand($c1,$c2,$c3,$c4)
   if $c1 == "empty" Then
	  GUICtrlSetData($debug, "F5 pressed, but this hand doesn't have a tile")
	  return
   EndIf

   return Kan($c1, $c2, $c3, $c4)
EndFunc

; Pairs are returned with 200 + their value, -1 if it's not a pair
Func CheckPairs($p1,$p2)
   if $p1 == "empty" Then
	  return -1
   EndIf
   if $p1 == $p2 Then
	  return 200+$p1
   Else
	  return -1
   EndIf
EndFunc

; Detects the suit out of the 3 inputed tiles
Func SuitCheck($tile1,$tile2,$tile3)

   ; 0 to 9 are man tiles
   if $tile1 <= 9 And $tile1 >= 0 Then
	  if $tile2 <= 9 And $tile2 >= 0 Then
		 if $tile3 <= 9 And $tile3 >= 0 Then
			return 10
		 EndIf
	  EndIf
   EndIf
   ; 10 to 19 are sou tiles
   if $tile1 <= 19 And $tile1 >= 10 Then
	  if $tile2 <= 19 And $tile2 >= 10 Then
		 if $tile3 <= 19 And $tile3 >= 10 Then
			return 20
		 EndIf
	  EndIf
   EndIf
   ; 20 to 29 are pin tiles
   if $tile1 <= 29 And $tile1 >= 20 Then
	  if $tile2 <= 29 And $tile2 >= 20 Then
		 if $tile3 <= 29 And $tile3 >= 20 Then
			return 30
		 EndIf
	  EndIf
   EndIf
   return 0
EndFunc

; Translates chi values
Func ChiTranslator($chi)
   $string = ""
   if $chi <= 17 And $chi >= 10 Then
	  $string &= "Man "
   elseif $chi <= 27 And $chi >= 20 Then
	  $string &= "Sou "
   elseif $chi <= 37 And $chi >= 30 Then
	  $string &= "Pin "
   EndIf

   for $i = 1 to 3 Step 1
	  if $chi-(10*$i) == 1 Then
		 $string &= "1-2-3"
	  elseif $chi-(10*$i) == 2 Then
		 $string &= "2-3-4"
	  elseif $chi-(10*$i) == 3 Then
		 $string &= "3-4-5"
	  elseif $chi-(10*$i) == 4 Then
		 $string &= "4-5-6"
	  elseif $chi-(10*$i) == 5 Then
		 $string &= "5-6-7"
	  elseif $chi-(10*$i) == 6 Then
		 $string &= "6-7-8"
	  elseif $chi-(10*$i) == 7 Then
		 $string &= "7-8-9"

	  EndIf
   Next
return $string
EndFunc