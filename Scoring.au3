; Actual Score Calculation
Global $roundedFu = 0

Global $handworth = 0
Global $dealerPrice = 0
Global $nondealerPrice = 0
Global $scrDealer = false

Func FuRounding()
   $roundedFu = 0

   if $fu >= 110 Then
	  $roundedFu = 110
   Else
	  for $i = 1  to 11
		 if $fu >= (10*$i) AND $fu <= (10*$i) + 4 Then ; Round down to base
			$roundedFu = (10*$i)
			ExitLoop
		 elseif $fu >= (10*$i) + 5 AND $fu <= (10*$i) + 9 Then; Round up to next base
			$roundedFu = (10*($i+1))
		 EndIf
	  Next
   EndIf
EndFunc

Func PointCalculation()
   FuRounding()
   if $han >= 5 Then
	  if $han == 5 Then
		 Mangan()
	  elseif $han == 6 or $han == 7 Then
		 Haneman()
	  elseif $han >= 8 AND $han <= 10 Then
		 Baiman()
	  elseif $han == 11 or $han == 12 Then
		 Sanbaiman()
	  Else
		 YakumanScr()
	  EndIf
   ElseIf $han >= 4 AND $roundedFu >= 40 Then
	  Mangan()
   ElseIf $han >= 3 AND $roundedFu >= 70 Then
	  Mangan()
   Else
	  NormalScoring()
   EndIf
EndFunc

Func NormalScoring()
   $handworth = 0
   $dealerPrice = 0
   $nondealerPrice = 0
   $nTotal = $roundedFu * (2^(2+$han))

   If $scrDealer == true Then
	  $handworth = RoundUp(4* $nTotal * 1.5)
	  $dealerPrice = RoundUp($nTotal * 2)
	  GUICtrlSetData($inputPoints, $dealerPrice & " ALL")
   Else
	  $nondealerPrice = RoundUp($nTotal)
	  $dealerPrice = RoundUp($nTotal * 2)
	  $handworth = RoundUp(4 * $nTotal)
	  GUICtrlSetData($inputPoints, $nondealerPrice & " / " & $dealerPrice)
   EndIf
EndFunc

; 2x Yakuman
Func DoubleYakumanScr()
   if $scrDealer == true Then
	  $handworth = "Dealer Double Yakuman"
	  GUICtrlSetData($inputPoints, "32,000 ALL")
   Else
	  $handworth = "Double Yakuman"
	  GUICtrlSetData($inputPoints, "16,000/32,000")
   EndIf
EndFunc

; Han 13+
Func YakumanScr()
   if $scrDealer == true Then
	  $handworth = "Dealer Yakuman)"
	  GUICtrlSetData($inputPoints, "16,000 ALL")
   Else
	  $handworth = "Yakuman"
	  GUICtrlSetData($inputPoints, "8,000/16,000")
   EndIf
EndFunc

; Han 11 - 12
Func Sanbaiman()
   if $scrDealer == true Then
	  $handworth = "Dealer Sanbaiman"
	  GUICtrlSetData($inputPoints, "12,000 ALL")
   Else
	  $handworth = "Sanbaiman"
	  GUICtrlSetData($inputPoints, "6,000/12,000")
   EndIf
EndFunc

; Han 8-10
Func Baiman()
   if $scrDealer == true Then
	  $handworth = "Dealer Baiman"
	  GUICtrlSetData($inputPoints, "8,000 ALL")
   Else
	  $handworth = "Baiman"
	  GUICtrlSetData($inputPoints, "4,000/8,000")
   EndIf
EndFunc

; Haneman, 6-7 Han
Func Haneman()
   if $scrDealer == true Then
	  $handworth = "Dealer Haneman"
	  GUICtrlSetData($inputPoints, "6,000 ALL")
   Else
	  $handworth = "Haneman"
	  GUICtrlSetData($inputPoints, "3,000/6,000")
   EndIf
EndFunc

; Mangan, 5 Han
Func Mangan()
   if $scrDealer == true Then
	  $handworth = "Dealer Mangan"
	  GUICtrlSetData($inputPoints, "4,000 ALL")
   Else
	  $handworth = "Mangan"
	  GUICtrlSetData($inputPoints, "2,000/4,000")
   EndIf
EndFunc

Func RoundUp($n)
   for $i = 1 to 1000 Step 1
	  if $n >= (100*$i) and $n <= (100*$i) + 99 Then
		 return (100*($i+1))
	  EndIf
   Next
EndFunc