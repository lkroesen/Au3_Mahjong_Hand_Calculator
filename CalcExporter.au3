#include <File.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Date.au3>

Func ExportMain()
   MhjWrite()
EndFunc

; File Overview:
; [User]
; Name
; Date

; >TILE DATA<
; [a,b,c,d,O/C] Hand Set 0   an e means empty  O = open, C = Closed
; [a,b,c,d,O/C] Hand Set 1
; [a,b,c,d,O/C] Hand Set 2
; [a,b,c,d,O/C] Hand Set 3
; [a,a] Hand Pair 0

; > HAND DATA <
; type = [N/S/G/K] Normal / Seven Pairs / 9 Gates / Kokushi Musou
; name = [FULL HAND NAME]
; Values = [non dealer / dealer] / ALL
; value = [Total Value]
; Han = [Han]
; Fu = [Fu]
; Wait = [Wait Type] Edge / Closed / Single / Open / Pair / Nine / Thirteen
; Riichi = [YES/NO] Riichi
; Ron = [Yes/NO] Ron -

; > TABLE DATA <
; rWind = [Round Wind]
; sWind = [Seat Wind]
; Dora = [Dora Tiles,]
; Dealer = [YES/NO]  Dealer
Func MhjWrite()

   ; User
   IniWrite("Hand.mhj", "User", "Name", InputBox("Username", "Please, input a username:"))
   IniWrite("Hand.mhj", "User", "Date", _Now())

   ;Tile Data
   For $i = 1 to 18 Step 1
	  IniWrite("Hand.mhj", "Tile Data", "Tile " & $i, $hand[$i])
   Next
   ; TODO, Concealed, Set data

   ; Hand Data
   if $NineGates == True Then
	  IniWrite("Hand.mhj", "Hand Data", "Type", "G")
   ElseIf $bKokushi == True Then
	  IniWrite("Hand.mhj", "Hand Data", "Type", "K")
   ElseIf $SevenPairsEnabled == 1 Then
	  IniWrite("Hand.mhj", "Hand Data", "Type", "S")
   Else
	  IniWrite("Hand.mhj", "Hand Data", "Type", "N")
   EndIf

   IniWrite("Hand.mhj", "Hand Data", "Hand Name", $exMessage)
   IniWrite("Hand.mhj", "Hand Data", "Values", GUICtrlRead($inputPoints))
   IniWrite("Hand.mhj", "Hand Data", "Total Value", $handworth)
   IniWrite("Hand.mhj", "Hand Data", "Han", $han)
   IniWrite("Hand.mhj", "Hand Data", "Fu", $fu)


   if $waitType == 1 Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "edge")
   elseif $waitType == 2 Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "closed")
   elseif $waitType == 3 and $boolPair == True Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "pair")
   elseif $waitType == 3 Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "single")
   elseif $waitType == 4 Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "open")
   elseif $waitType == 9 Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "nine")
   elseif $waitType == 13 Then
	  IniWrite("Hand.mhj", "Hand Data", "Wait", "thirteen")
   EndIf

   If GuiCtrlRead($checkboxRiichi) == $GUI_CHECKED Then
	  IniWrite("Hand.mhj", "Hand Data", "Riichi", "YES")
   ElseIf GuiCtrlRead($checkboxDoubleRiichi) == $GUI_CHECKED Then
	  IniWrite("Hand.mhj", "Hand Data", "Riichi", "YES")
   Else
	  IniWrite("Hand.mhj", "Hand Data", "Riichi", "NO")
   EndIf

   IniWrite("Hand.mhj", "Hand Data", "Ron Win", $WinOnRon)

   ; Table Data
   IniWrite("Hand.mhj", "Table Data", "Round Wind", $rWind)
   IniWrite("Hand.mhj", "Table Data", "Seat Wind", $sWind)
   IniWrite("Hand.mhj", "Table Data", "Dealer", $scrDealer)

   ; Dora Data
   IniWrite("Hand.mhj", "Dora Data", "nDora", $nDora)

   For $i = 1 to 13 Step 1
	  IniWrite("Hand.mhj", "Dora Data", "Dora " & $i, $doraValue[$i])
   Next


EndFunc

; Returns the set in format [T1,T2,T3,T4,1/0] 1 = open, 0 = closed
Func SetToString($n)
   $str = ""

   if $n == 0 Then
	  $str &= $hand[1] & "," & $hand[2] & "," & $hand[3] & "," & $hand[4] & "," & $setsThatAreOpen[$n+1]
   elseif $n == 1 Then
	  $str &= $hand[5] & "," & $hand[6] & "," & $hand[7] & "," & $hand[8] & "," & $setsThatAreOpen[$n+1]
   elseif $n == 2 Then
	  $str &= $hand[9] & "," & $hand[10] & "," & $hand[11] & "," & $hand[12] & "," & $setsThatAreOpen[$n+1]
   elseif $n == 3 Then
	  $str &= $hand[13] & "," & $hand[14] & "," & $hand[15] & "," & $hand[16] & "," & $setsThatAreOpen[$n+1]
   else
	  $str &= $hand[17] & "," & $hand[18] & ",0"
   EndIf

   return $str

EndFunc