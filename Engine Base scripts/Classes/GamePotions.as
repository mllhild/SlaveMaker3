// GamePotions - take/make potions screen
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class GamePotions extends DialogBase {
		
	private var checkboxListenerContra:Object;
	
	// Constructor
	public function GamePotions(cg:Object)
	{ 
		super(cg.PotionsMenu, cg);
		
		checkboxListenerContra = null;
		mcBase.Contraceptives.setStyle("fontWeight", "bold");
		mcBase.Contraceptives.setStyle("symbolBackgroundColor", "0xe0ffff"); 
		mcBase.Contraceptives.setStyle("symbolBackgroundDisabledColor", "0xe0ffff"); 
	}

	
	// Dialog to use/make potions
	
	public function ViewDialog()
	{
		coreGame.PersonIndex = -50;
				
		mcBase.Contraceptives.label = Language.GetHtml("UsingContraceptives", "Morning");
		mcBase.DrinkerBtn.LText.htmlText = Language.GetHtml("Drinker", "Buttons", true, -1);
		
		var ti:GamePotions = this;
		
		if (checkboxListenerContra == null) {
			checkboxListenerContra = new Object();
			checkboxListenerContra.click = function(cbObj:Object) {
				if (cbObj.target.selected) ti.sd.UseContraceptives(true);
				else ti.sd.UseContraceptives(false);
			};
			mcBase.Contraceptives.addEventListener("click", checkboxListenerContra);
		}

		mcBase.DrinkerBtn.Btn.onPress = function() {
			ti.coreGame.HideLeaveButton();
			function SlaveFilter(idx:Number) {
				if (idx < 0) return true;
				var sgirl:Slave = ti.SMData.SlavesArray[idx];
				if (sgirl.SlaveType == -20) return false;
				return true;
			}
			function SlavePicked() { ti.ShowDialogContents(); }
			ti.coreGame.PickASlave(ti.Language.GetHtml("WhoWillDrink", "Potions"), true, SlaveFilter, SlavePicked);
			coreGame.HideAllPeople();
		}
		
		super.ViewDialog();
	}
	
	// override to set the tabs viaible for this dialog
	public function SetGameTabs()
	{
		var dspMain:Object = coreGame.dspMain;
		dspMain.HideGameTabs();
		if (coreGame.PersonIndex == -100) dspMain.ShowGameTab(3);
		else dspMain.ShowGameTab(1);
	}
	
	public function ShowDialogContents(notext:Boolean)
	{
		super.ShowDialogContents(notext);
		
		coreGame.MorningEveningMenu._visible = false;
		HideEquipmentButton();
		HideSMEquipmentButton();
		coreGame.HideDresses();
		
		ReloadPotions();

		Backgrounds.ShowPotions(3);
		
		coreGame.ShowLeaveButton();
		
		if (coreGame.PersonIndex != -100) {
			if (coreGame.PersonIndex == -99) SetSlave(coreGame.AssistantData);
			else if (coreGame.PersonIndex == -50) SetSlave(_root);
			else SetSlave(SMData.SlavesArray[coreGame.PersonIndex]);
			
			coreGame.dspMain.SetSlaveForGameTabs(sd);
			coreGame.GetSlaveInformation(coreGame.PersonIndex);
			
			coreGame.ShowSlave(sd, 0, 9);
			coreGame.dspMain.SelectGameTab(1);
			mcBase.Contraceptives._visible = sd.SlaveGender != 1 && sd.SlaveGender != 0 && sd.SlaveGender != 4 && sd.SlaveType != -1 && sd.SlaveType != -20;
			mcBase.Contraceptives.selected = !sd.BitFlag1.CheckBitFlag(14);
	
		} else {
			SetSlave(SMData);
			
			coreGame.dspMain.SetSlaveForGameTabs(SMData);
			
			SMData.ShowSlaveMaker(1, 0, 9);
			coreGame.dspMain.SelectGameTab(3);
			mcBase.Contraceptives._visible = SMData.Gender != 1 && SMData.Gender != 0 && SMData.Gender != 4;
			mcBase.Contraceptives.selected = !SMData.BitFlagSM.CheckBitFlag(14);
		}
		
		if (notext != true) SetText(Language.GetHtml("SelectPersonToDrink", "Potions") + "\r\r");
	}
	
	private function ReloadPotions()
	{
		var tot:Number = 0;
		coreGame.ClearGeneralArray();
		for (var i:Number = 0; i < SMData.GetLastPotionOwned(); i++) {
			AddPotion(i);
			tot += SMData.GetPotionOwned(i);
		}
		mcBase.Potions.invalidate();
		
		if (tot > 0) mcBase.LText1.htmlText = Language.GetHtml("PotionsTitle", "Potions", true);
		else mcBase.LText1.htmlText = Language.GetHtml("NoPotionsTitle", "Potions", true);
	}
	
	// Exit the view back to the main menu
	public function LeaveDialog()
	{
		super.LeaveDialog();
		coreGame.ClearGeneralArray();
		coreGame.dspMain.SelectGameTab(1);
	}
	
	public function AddPotion(potion:Number)
	{
		if (SMData.GetPotionOwned(potion) < 1 && sd.PotionsUsed[potion] != -1) return;
		
		var image:MovieClip = mcBase.Potions.attachMovie("Potion Details", "Potion" + coreGame.arGeneralArray.length, mcBase.Potions.getNextHighestDepth());
		var pn:Number = coreGame.arGeneralArray.push(image);
		pn--;
		var tot:Number = SMData.GetPotionOwned(potion);
		image.PotionLabel.autoSize = true;
		image.PotionLabel.styleSheet = coreGame.styles;
		image.PotionLabel.htmlText = "<b>" + GetPotionName(potion) + "</b>\n" + (tot > 1 ? Language.GetHtml("Doses", "Potions") : Language.GetHtml("Dose", "Potions")) + ": " + SMData.GetPotionOwned(potion);
		image._x = (pn > 4) ? 233 : 3;
		if (pn < 5) image._y = pn * 48;
		else image._y = (pn - 5) * 48;
		
		image.enabled = true;
		image.tabEnabled = true;
		var ti:GamePotions = this;
		if (SMData.GetPotionOwned(potion) > 0) {
			image.DrinkBtn.onRollOver = function() { ti.ShowHint(ti.Language.GetHtml("DrinkDose", "Potions") + "\r\r"); }
			image.DrinkBtn.onRollOut = HideHints;
			image.DrinkBtn.onPress = function() {
				ti.TakeAPotion(this._parent.potion);
			}
			image.DrinkBtn.Label.htmlText = Language.GetHtml("Drink", "Buttons");
			image.DrinkBtn.Shortcut.htmlText = "<font color='#0000FF'>" + (pn + 1) + "<font color='#000000'>";
		} else image.DrinkBtn._visible = false;
		if (coreGame.AssistantData.PotionsUsed[potion] == -1 || sd.PotionsUsed[potion] == -1) {
			image.MakeBtn.onRollOver = function() { ti.ShowHint(ti.Language.GetHtml("MakePotion", "Potions") + "\r\r"); }
			image.MakeBtn.onRollOut = HideHints;
			image.MakeBtn.onPress = function() {
				ti.MakeAPotion(this._parent.potion);
			}
			image.MakeBtn.Label.htmlText = Language.GetHtml("Make", "Buttons");
			image.MakeBtn.Shortcut.htmlText = "<font color='#0000FF'>" + String.fromCharCode(pn + 56) + "<font color='#000000'>";
		} else image.MakeBtn._visible = false;
		image._visible = true;
		image.potion = potion;
	}
	
	public function TakeAPotion(potion:Number)
	{		
		DrinkPotion(potion, 0);
		if (IsEventAllowable()) ReloadPotions();
	}
	
	public function MakeAPotion(potion:Number)
	{
		StopHints();
	
		var price:Number;
		switch (potion) {
			case 2: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(60, 2); break;
			case 3: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(550, 3); break
			case 4: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(125, 4); break;
			case 10: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(150, 10); break;
		}
		price = int(price / 2);
			
		SetText(strReplaceValue(Language.GetHtml("MakePotionCost", "Potions"), price));
		if ((coreGame.VarGold + SMData.SMGold) >= price) {
			AddText(Language.GetHtml("MadePotion", "Potions"));
			Money(price * - 1);
			SMData.ChangePotionOwned(potion, 1);
		} else AddText("\r\r" + Language.GetHtml("NotEnoughGold", "Potions"));
		ShowDialogContents(true);
	}
	
	// Miscellaneous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		var tot:Number = 10 - coreGame.arGeneralArray.length;
		if ((keya < (59 - tot)) && keya > 48) {
			TakeAPotion(coreGame.arGeneralArray[keya - 49].potion);
			return true;
		}
		//else if ((keya < (75 - tot)) && keya > 64) AnalyseAPotion(arGeneralArray[keya - 65].potion);
		return false;
	}

	
	// General Potion functions
	
	public function DrinkPotion(potion:Number, price:Number, say:String)
	{
		//trace("DrinkPotion: " + potion + " " + price + " " + coreGame.PersonIndex + " " + sd + " " + sd.SlaveName);
		StopHints();
		ResetEventPicked();
		PlaySound("Gurgle");
		if (price == undefined) {
			price = 0;
			switch (potion) {
				case 2: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(60, 2); break;
				case 3: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(550, 3); break
				case 4: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(125, 4); break;
				case 10: price = coreGame.currentCity.GetShopInstanceString("Shop").PotionPrice(150, 10); break;
			}
		}
		coreGame.Pay = price;
		coreGame.genString = say;
			
		if (coreGame.PersonIndex == -100) {
			// Slave Maker drinks the potion
			if (SMData.GetPotionOwned(potion) > 0) SMData.ChangePotionOwned(potion, -1);
			
			coreGame.EventTotal = SMData.PotionsUsed[potion];
			XMLDrinkPotion(potion, price, say);	
			BlankLine();
			return;
		}
		
		SetText("");
		if (coreGame.PersonIndex == -99) SetSlave(coreGame.AssistantData);
		else if (coreGame.PersonIndex == -50) SetSlave(_root);
		var slave:Boolean = coreGame.PersonIndex == -50;
		if (!slave) coreGame.UpdateSlaveCommon(sd);
		
		var pname:String = GetPotionName(potion);
		if (say == undefined) say = "";
		
		//trace("DrinkPotion2: " + potion + " " + price + " " + coreGame.PersonIndex + " " + sd + " " + sd.SlaveName);

		switch (potion) {
			case 0:
				// Dickgirl
				sd.ChangeCumslut(2);
				coreGame.Icons.ShowDickgirlIconNow();
				break;
			case 1: 
				// uninhibitory potion
				// 1.2+ = variant
				sd.NumAphrodisiac++;
				sd.MinLibido++;
				sd.UsedAphrodisiac = 1;
				if (sd.PotionsUsed[1] > 2) coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, -20, 0, 0, 0, -30, -50, 0);
				else {
					if (sd.MaxObedience < (coreGame.MaxStat * 0.8)) sd.MaxObedience = sd.MaxObedience + 5 + sd.PotionsUsed[1];
					else sd.MaxObedience = sd.MaxObedience + 1 + sd.PotionsUsed[1];
					coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0);
				}
				break;
				
			// 2 aphrodisiac - in xml
			// 3 soothing potion - in xml
			// 4 Energy drink - in xml
			
			case 5: 
				// /dorei
				sd.DoreiEffecting = 1;
				sd.DrugDuration = 7;
				sd.OldMorality = sd.VarMorality;
				coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, -10, 0);
				sd.AddictionLevel = sd.AddictionLevel + 50;
				sd.DrugAddicted = 0;
				sd.NumAphrodisiac++;
				sd.UsedAphrodisiac = 1;
				break;
			case 6: 
				// Zodai
				if (sd.ZodaiEffecting == 0) {
					sd.ZodaiEffecting = 1;
					sd.DrugDuration = 1;
				}
				coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -10, 0);
				sd.AddictionLevel += 10;
				sd.DrugAddicted = 0;
				sd.NumAphrodisiac++;
				sd.UsedAphrodisiac = 1;
				break;
			case 7: 
				// Gaman
				sd.GamanEffecting = 1;
				sd.DrugDuration = 3;
				coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -10, 0);
				sd.AddictionLevel += 10;
				sd.DrugAddicted = 0;
				break;
			case 8: 
				// Biyaku
				sd.BiyakuEffecting = 1;
				sd.DrugDuration = 3;
				coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 20, 0, 0, 0, -10, 0);
				sd.AddictionLevel += 20;
				sd.DrugAddicted = 0;
				sd.NumAphrodisiac++;
				sd.UsedAphrodisiac = 1;
				break;
			case 9:
				// Ishinai
				sd.IshinaiEffecting = 1;
				sd.DrugDuration = 3;
				sd.OldObedience = sd.VarObedience;
				sd.OldMorality = sd.VarMorality;
				sd.OldIntelligence = sd.VarIntelligence;
				sd.OldVarTemperament = sd.VarTemperament;
				sd.AddictionLevel += 50;
				coreGame.PointsByIndex(coreGame.PersonIndex, 0, 0, 0, -100, -100, 0, 0, 0, 0, 0, 0, -100, 100, 100, 100, 0, 0, 0, -10, 0);
				sd.DrugAddicted = 0;
				sd.NumAphrodisiac++;
				sd.UsedAphrodisiac = 1;
				break;
				
			// 10 Lust Draft - in xml
			// 11 Odd Pill - in xmol
			// 12 Nymph's Tears - in xml
			// 13 Rinno's Orgasm Drug - in xmol
			
		}
	
		if (sd.PotionsUsed[potion] != -1) sd.PotionsUsed[potion]++;
		if (SMData.GetPotionOwned(potion) > 0) {
			if (sd.SlaveGender > 3) SMData.ChangePotionOwned(potion, -2);
			else SMData.ChangePotionOwned(potion, -1);
		}
		coreGame.EventTotal = sd.PotionsUsed[potion];
		
		Language.SaveText();
		var bChanged:Boolean = false;
		if (slave) {
			coreGame.UpdateSlave();
			if (coreGame.CurrentAssistant.DrinkPotionAsAssistant(potion, price, pname, say) == true) return;
			if (coreGame.SlaveGirl.DrinkPotion(potion, price, pname, say) == true) return;
			bChanged = Language.IsTextChanged();
		} else coreGame.UpdateSlaveCommon(sd);
		
		if (!XMLDrinkPotion(potion, price, say)) {
			if (say != "") {
				AddText("#person " + say);
				BlankLine();
			}
		} else {
			if (bChanged) Language.RestoreText();
			BlankLine();
		}
	}

	
	public function GetPotionName(potion:Number) : String { 
		return Language.XMLData.GetXMLStringParsed("Name", coreGame.Items.FindItemNodeCById(potion, Language.XMLData.GetNodeC("Potions"), "PotionDetail"));
	}
	public function GetPotionDescription(potion:Number) : String { 
		return Language.XMLData.GetXMLStringParsed("Description", coreGame.Items.FindItemNodeCById(potion, Language.XMLData.GetNodeC("Potions"), "PotionDetail"));
	}
	public function GetPotionPrice(potion:Number) : Number { 
		return Language.XMLData.GetXMLValue("BasePrice", coreGame.Items.FindItemNodeCById(potion, Language.XMLData.GetNodeC("Potions"), "PotionDetail"));
	}
	
	public function GetPotionNumber(potion:String) : Number
	{
		if (potion == undefined) return -1;
		potion = potion.toLowerCase().split(" ").join("").split("'").join("");
		
		var curr:Number = 14;
		var nm:String;
		var id:Number;
			
		for (var iNode:XMLNode = Language.XMLData.GetNodeC("Potions/PotionDetails"); iNode != null; iNode = iNode.nextSibling) {
			if (iNode.nodeType != 1) continue;
			nm = iNode.nodeName.toLowerCase();
			id = Number(iNode.attributes.id);
			if (isNaN(id)) id = ++curr;
			if (nm == "potiondetail") {
				nm = Language.XMLData.GetXMLStringParsed("Name", iNode.firstChild);
				if (nm.toLowerCase().split(" ").join("").split("'").join("") == potion) return id;
			}
		}
		return -1;
	}
	
	public function XMLDrinkPotion(potion:Number, price:Number, say:String) : Boolean
	{
		//trace("XMLDrinkPotion:" + potion);
		var pm:String = "Slave";
		if (coreGame.PersonIndex == -100) pm = "SlaveMaker";
		var XMLData:Object = Language.XMLData;
		coreGame.GetSlaveInformation(coreGame.PersonIndex);
		
		var pNode:XMLNode = coreGame.Items.FindItemNodeCById(potion, XMLData.GetNodeC("Potions"), "PotionDetail");

		if (!XMLData.XMLEventByNode(XMLData.GetNode(pNode, "Drink/Common"))) {
			if (!XMLData.XMLEventByNode(XMLData.GetNode(pNode, "Drink/" + pm))) {
				var nb:String = XMLData.GetXMLStringParsed("Drink/UseDrinkPotion", pNode);
				if (!XMLData.XMLEvent("DrinkPotion/" + nb + "/Common")) {
					if (!XMLData.XMLEvent("DrinkPotion/" + nb + "/" + pm)) return false;
				}
			}
		}
		return true;
	}

	
	// XML
	
	public function ParsePotions(aNode:XMLNode, str:String)
	{
		var potion:String = aNode.attributes.potion.toLowerCase();
		var pot:Number = GetPotionNumber(potion);
		if (pot == -1) continue;
			
		if (str == "drinkpotion") {
			DrinkPotion(pot, undefined, aNode.firstChild.nodeValue);
			return;
		}
		if (str == "addpotion") {
			var num:Number = 1;
			if (aNode.firstChild.nodeValue != undefined) num = Language.XMLData.GetExpression(aNode.firstChild.nodeValue);
			SMData.ChangePotionOwned(pot, num);
			return;
		}	
		if (str == "buypotion") {
			var num:Number = 1;
			if (aNode.firstChild.nodeValue != undefined) num = Language.XMLData.GetExpression(aNode.firstChild.nodeValue);
			coreGame.Tailor.PurchaseQuantity = num;
			var cost:Number = coreGame.Tailor.PotionPrice(GetPotionPrice(pot), pot);
			Money(cost * -1);
			SMData.ChangePotionOwned(pot, num);
		}
	}
	
}