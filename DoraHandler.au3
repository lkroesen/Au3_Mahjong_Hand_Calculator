; Dora
Global $doraHan = 0
Global $nDora = 0

Global $actualDora[14]

Func DoraMain()
   $doraHan = 0
   $nDora = 0

   for $i = 1 to 13 Step 1
	  $actualDora[$i] = -$i
   Next

   For $i = 1 to 13 Step 1
	  if $doraValue[$i] == "empty" Then
		 ExitLoop
	  EndIf
	  DoraPlusOne($doraValue[$i], $i)
   Next

   for $i = 1 to 18 Step 1
	  for $f = 1 to 13 Step 1
		 If $hand[$i] == $actualDora[$f] Then
			$nDora += 1
			$doraHan += 1
		 EndIf
	  Next
   Next
EndFunc

Func DoraPlusOne($cT, $nr)

   if $cT >= $cMAN1 and $cT <= $cMAN4 Then
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cMAN5 Then
	  $actualDora[$nr] = $cMAN6; 5 Man, but 5 man red dora is number 5, so we can't + 1 it

   elseif $cT >= $cMAN5r AND $cT <= $cMAN8 Then
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cMAN9 Then
	  $actualDora[$nr] = $cMAN1; 9 Man, so Dora is 1 Man: 0

   elseif $cT >= $cSOU1 and $cT <= $cSOU4 Then; Sou, repeat the same Man stuff
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cSOU5 Then
	  $actualDora[$nr] = $cSOU6; 5 Sou, but 5 sou red dora is number 5, so we can't + 1 it

   elseif $cT >= $cSOU5r AND $cT <= $cSOU8 Then
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cSOU9 Then
	  $actualDora[$nr] = $cSOU1; 9 Sou, so Dora is 1 Sou: 0

   elseif $cT >= $cPIN1 and $cT <= $cPIN4 Then; Pin
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cPIN5 Then
	  $actualDora[$nr] = $cPIN6; 5 Man, but 5 man red dora is number 5, so we can't + 1 it

   elseif $cT >= $cPIN5r AND $cT <= $cPIN8 Then
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cPIN9 Then
	  $actualDora[$nr] = $cPIN1; 9 Pin, so Dora is 1 Pin: 0

   elseif $cT >= $cTON AND $cT <= $cSHAA Then ; 30-East, 31-South, 32-West, 33-North
	  $actualDora[$nr] = $cT + 1

   elseif $cT == $cPEI Then
	  $actualDora[$nr] = $cTON

   elseif $cT == $cCHUN Then
	  $actualDora[$nr] = $cHAKU

   elseif $cT == $cHAKU Then
	  $actualDora[$nr] = $cHATSU

   elseif $cT == $cHATSU Then
	  $actualDora[$nr] = $cCHUN

   EndIf
EndFunc