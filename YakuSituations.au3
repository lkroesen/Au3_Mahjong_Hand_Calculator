; Yaku Situations
Global $YakuSitHan = 0
Global $nYakuSit = 0
Global $YakuSitName = ""

; Main
Func YakuSitMain()
   $YakuSitHan = 0
   $nYakuSit = 0
   $YakuSitName = ""

   If GuiCtrlRead($checkboxNagashiMangan) == $GUI_CHECKED Then
	  $YakuSitHan = "mangan"
	  $nYakuSit += 1
	  $YakuSitName &= "Nagashi Mangan "
	  return
   EndIf

   If GuiCtrlRead($checkboxTenhou) == $GUI_CHECKED Then
	  $YakuSitHan = "yakuman"
	  $nYakuSit += 1
	  $YakuSitName &= "Blessing of Heaven "
	  return
   EndIf

   If GuiCtrlRead($checkboxChiihou) == $GUI_CHECKED Then
	  $YakuSitHan = "yakuman"
	  $nYakuSit += 1
	  $YakuSitName &= "Blessing of Earth "
	  return
   EndIf

   If GuiCtrlRead($checkboxRenhou) == $GUI_CHECKED Then
	  $YakuSitHan = "yakuman"
	  $nYakuSit += 1
	  $YakuSitName &= "Blessing of Man "
	  return
   EndIf

   If GuiCtrlRead($checkboxTsumo) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "Menzen Tsumo "
   EndIf

   If GuiCtrlRead($checkboxRiichi) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "Riichi "
   EndIf

   If GuiCtrlRead($checkboxDoubleRiichi) == $GUI_CHECKED Then
	  $YakuSitHan += 2
	  $nYakuSit += 1
	  $YakuSitName &= "Double Riichi "
   EndIf

   If GuiCtrlRead($checkboxIppatsu) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "One-shot "
   EndIf

   If GuiCtrlRead($checkboxHaiteiRaoyue) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "Haitei Raoyue "
   EndIf

   If GuiCtrlRead($checkboxHouteiRaoyui) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "Houtei Raoyui "
   EndIf

   If GuiCtrlRead($checkboxRinshan) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "Rinshan Kaihou "
   EndIf

   If GuiCtrlRead($checkboxChankan) == $GUI_CHECKED Then
	  $YakuSitHan += 1
	  $nYakuSit += 1
	  $YakuSitName &= "Chankan "
   EndIf

EndFunc