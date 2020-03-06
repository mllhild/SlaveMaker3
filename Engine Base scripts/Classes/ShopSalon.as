// Salon
// Translation status: INCOMPLETE

// Prices
// VanityCase 150 - now 75
// Makeup/Hair/Skin 100 - now 50

import Scripts.Classes.*;

class ShopSalon extends Shop {
		
	// constructor
	public function ShopSalon(mc:MovieClip, cg:Object, cc:Object)
	{ 
		super(mc, cg, "Shopping/Shops/Salon", cc);
	}
	
		// Visit the shop
	public function VisitShop()
	{
		strShopKeeper = coreGame.People.GetPersonsName(15);
		
		super.VisitShop();	
		
		XMLData.XMLEvent("ShoppingSalon", false);
		coreGame.SlaveGirl.DoSalon();
		coreGame.BitFlag1.SetBitFlag(29);
		coreGame.Sounds.PlaySound("DoorBell");
		
		EnableChooseCustomer(mcBase.CustomerBtn);
		
		var ti:ShopSalon = this;
		mcBase.BtnVanityCase.onPress = function() { ti.PurchaseVanityCase(false); }
		mcBase.BtnVanityCase.onRollOver = function() { ti.PurchaseVanityCase(true); }
		mcBase.BtnVanityCase.onRollOut = coreGame.HideHints;
		mcBase.BtnPiercings.onPress = function() { ti.PurchasePiercings(false);	}
		mcBase.BtnPiercings.onRollOver = function() { ti.PurchasePiercings(true); }
		mcBase.BtnPiercings.onRollOut = coreGame.HideHints;
		mcBase.BtnSkinCare.onPress = function() { ti.PurchaseSkinCare(false); }
		mcBase.BtnSkinCare.onRollOver = function() { ti.PurchaseSkinCare(true);	}
		mcBase.BtnSkinCare.onRollOut = coreGame.HideHints;
		mcBase.BtnMakeUp.onPress = function() {	ti.PurchaseMakeUp(false); }
		mcBase.BtnMakeUp.onRollOver = function() { ti.PurchaseMakeUp(true); }
		mcBase.BtnMakeUp.onRollOut = coreGame.HideHints;
		mcBase.BtnHairStyling.onPress = function() { ti.PurchaseHairStyling(false);	}
		mcBase.BtnHairStyling.onRollOver = function() {	ti.PurchaseHairStyling(true); }
		mcBase.BtnHairStyling.onRollOut = coreGame.HideHints;
		mcBase.BtnNippleRings.onPress = function() { ti.PurchaseNippleRings(false); }
		mcBase.BtnNippleRings.onRollOver = function() { ti.PurchaseNippleRings(true); }
		mcBase.BtnNippleRings.onRollOut = coreGame.HideHints;
		
		mcBase.CustomerBtn.LText.htmlText = Language.GetHtml("Customer", "Buttons");
		
		mcBase.NippleRingsLabel.htmlText = Language.GetHtml("NippleRings", "Equipment", false, 0, "R");
		mcBase.VanityLabel.htmlText = Language.GetHtml("VanityCase", "Equipment", false, 0, "C");
		
		mcBase.TitleText.htmlText = Language.GetHtml("Title", xNode);
		mcBase.LText1.htmlText = Language.GetHtml("SalonItems", xNode);
		mcBase.LText2.htmlText = Language.GetHtml("SalonServices", xNode);
		mcBase.SkinCareLabel.htmlText = Language.GetHtml("SalonSkinCare", xNode, false, 0, "S");
		mcBase.HairStylingLabel.htmlText = Language.GetHtml("SalonHairStyling", xNode, false, 0, "H");
		mcBase.MakeUpLabel.htmlText = Language.GetHtml("SalonMakeUp", xNode, false, 0, "M");
		mcBase.LText2.htmlText = Language.GetHtml("SalonServices", xNode);
	
	}
	
	public function ShowShopContents()
	{
		coreGame.HideYesNoButtons();
		coreGame.HideQuestions();
		coreGame.HideDresses();
		
		if (!XMLData.XMLGeneral("ShowShop", false, xNode)) ShowPerson("SalonOwner", "Shop");
		
		mcBase._visible = true;
		coreGame.dspMain.ShowTabBackground(true);
		
		if (coreGame.PersonIndex != -100) {
			sd = SMData.GetSlaveByIndex(coreGame.PersonIndex);
			coreGame.OtherSlaveShown = coreGame.PersonIndex != -50;
			coreGame.PersonGender = sd.SlaveGender;
			if (coreGame.OtherSlaveShown) coreGame.UpdateSlaveCommon(sd);
			else coreGame.UpdateSlave();
			if (!coreGame.LargerTextField._visible) coreGame.dspMain.SelectGameTab(1);
	
		} else {
			sd = SMData;
			if (!coreGame.LargerTextField._visible) coreGame.YourStats1.Btn.onPress();
		}
		ShowPurchaser(0);
		coreGame.GetPersonGenderText();
		coreGame.EquipmentButton._visible = coreGame.PersonIndex == -50;
		if (!coreGame.LargerTextField._visible) coreGame.dspMain.SelectGameTab(1);
		
		mcBase.NippleRingsNA._visible = ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType == 0) || (coreGame.PersonIndex != -100 && sd.PiercingsType == 0));
		mcBase.VanityCaseBought._visible = ((coreGame.PersonIndex == -100 && SMData.SMVanityCaseOK == 1) || (coreGame.PersonIndex != -100 && sd.VanityCaseOK == 1));
		mcBase.PiercingsBought._visible = ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType > 1) || (coreGame.PersonIndex != -100 && sd.PiercingsType > 1));
		mcBase.NippleRingsBought._visible = ((coreGame.PersonIndex == -100 && SMData.SMNippleRingsOK == 1) || (coreGame.PersonIndex != -100 && sd.NippleRingsOK == 1));
	
		mcBase.PiercingsLabel.htmlText = "<font color='#0000FF'>P</font>iercings";
		if ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType > 0) || (coreGame.PersonIndex != -100 && sd.PiercingsType > 0)) mcBase.PiercingsLabel.htmlText = "<font color='#0000FF'>P</font>iercings+";
	
		coreGame.ShowLeaveButton();
	}
	
	public function PurchaseNippleRings(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType == 0) || (coreGame.PersonIndex != -100 && sd.PiercingsType == 0)) {
			Beep();
			coreGame.HideYesNoButtons();
			if (coreGame.PersonIndex == -100) ServantSpeak("You have not had your nipples pierced.");
			else ServantSpeak("You have not had #personhisher nipples pierced.");
		} else if ((coreGame.PersonIndex == -100 && SMData.SMNippleRingsOK == 1) || (coreGame.PersonIndex != -100 && sd.NippleRingsOK == 1)) {
			Beep();
			coreGame.HideYesNoButtons();
			if (coreGame.PersonIndex == -100) ServantSpeak("You already have a set of nipple rings.");
			else ServantSpeak("#person already has a set of nipple rings.");
		} else {
			PersonSpeak(15, Language.GetHtml("NippleRingsDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("NippleRingsPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(22, hint);
		}
	}
	
	public function PurchaseMakeUp(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		PersonSpeakStart(15, "#person will have #personhisher make-up done by a professional.\r\rCharisma + " + Math.floor(5 * coreGame.dmod) + ", " + PurchasePrice(50) + "GP\rOf course #personheshe will have to return periodically to have it redone.");
		if (coreGame.PersonIndex != -100) {
			if (sd.DurationMakeupCare > 0) AddText("I do not think #person really needs #personhisher make-up done now, #personheshe only had one recently but my beautician will see #personhimher again.");
			if (sd.VanityCaseOK == 0) AddText("\r\rYou have not bought a vanity case for #person, so #personheshe cannot maintain #personhisher make-up properly and will need to return more often.");
		}
		PersonSpeakEnd();
		PurchaseItem(9, hint);
	}
	
	public function PurchaseVanityCase(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if ((coreGame.PersonIndex == -100 && SMData.SMVanityCaseOK == 1) || (coreGame.PersonIndex != -100 && sd.VanityCaseOK == 1)) {
			Beep();
			coreGame.HideYesNoButtons();
			if (coreGame.PersonIndex == -100) ServantSpeak("You have already bought a vanity case.");
			else ServantSpeak("You have already bought a vanity case for #person.");
		} else {
			PersonSpeak(15 , Language.GetHtml("VanityCaseDescription", "Equipment") + "\r\r" + Language.GetHtml("Charisma", coreGame.statNode) + " + " + Math.floor(5 * coreGame.dmod) + "\r" + PurchasePrice(75) + coreGame.GP);
			PurchaseItem(27, hint);
		}
	}
	
	public function PurchasePiercings(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType > 1) || (coreGame.PersonIndex != -100 && sd.PiercingsType > 1)) {
			Beep();
			coreGame.HideYesNoButtons();
			if (coreGame.PersonIndex == -100) ServantSpeak("You are fully pierced.");
			else ServantSpeak("#person is already fully pierced.");
		} else {
			if ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType == 0) || (coreGame.PersonIndex != -100 && sd.PiercingsType == 0)) {
				if (coreGame.HasCock) PersonSpeakStart(15, "Piercings of #personhisher nipples and cock-head.");
				else PersonSpeakStart(15, "Piercings of #personhisher nipples and clitoris.");
			} else {
				if (coreGame.HasCock) PersonSpeakStart(15, "Testicular and belly-button piercings.");
				else PersonSpeakStart(15, "Vaginal and belly-button piercings.");
			}
			PersonSpeakEnd("\r\r" + Language.GetHtml("Charisma", coreGame.statNode) + " + 2, " + Language.GetHtml("Lust", coreGame.statNode) + " + 1\r" + PurchasePrice(70) + coreGame.GP);
			PurchaseItem(28, hint);
		}
	}
	
	public function PurchaseHairStyling(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		PersonSpeakStart(15, "Professional hairstyling.\r\r" + Language.GetHtml("Charisma", coreGame.statNode) + " + " + Math.floor(5 * coreGame.dmod) + ", " + PurchasePrice(50) + "GP\rOf course #personheshe will have to return periodically for a trim and other touch ups. ");
		if (coreGame.PersonIndex != -100) {
			if (sd.DurationHairCare > 0) AddText("#person does not really need a trim now, #personheshe only had one recently but my stylist will adjust #personhisher hair. ");
			if (sd.VanityCaseOK == 0) AddText("\r\r#person has not bought a vanity case so #personheshe cannot maintain #personhisher hair properly and will need to return more often. ");
		}
		PersonSpeakEnd();
		PurchaseItem(29, hint);
	}
	
	public function PurchaseSkinCare(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		PersonSpeakStart(15, "Facial and skin-care in a boutique.\r\r" + Language.GetHtml("Charisma", coreGame.statNode) + " + " + Math.floor(5 * coreGame.dmod) + ", " + PurchasePrice(50) + "GP\rOf course #personheshe will have to return periodically for more treatments.");
		if (coreGame.PersonIndex != -100) {
			if (sd.DurationFacialCare > 0) AddText("#person does not really need another treatment now, #personheshe only had one recently but my expert will treat #personhisher again.");
			if (sd.VanityCaseOK == 0) AddText("\r\r#person has not bought a vanity case so #personheshe cannot maintain #personhisher skin properly and will need to return more often. ");
		}
		PersonSpeakEnd();
		PurchaseItem(30, hint);
	}
	
	function BuyFromShop(itemno:Number)
	{
		if (itemno == 9)
		{
			if (BuyItem(15, 50)) {
				AddText("A beautician working for Skuld applies #personhisher make-up and gives instructions for #personhimher to reapply and maintain.");
				if (coreGame.PersonIndex != -100) {
					sd.DurationMakeupCare = 4;
					sd.TotalMakeupCare++;
				}
				coreGame.PointsByIndex(coreGame.PersonIndex, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				coreGame.DoEventNext(9702);
				return;
			}
		} else if (itemno == 22)
		{
			if (BuyItem(15, XMLData.GetXMLValue("NippleRingsPrice", "Equipment"))) {
				if (coreGame.PersonIndex == -100) {
					SMData.SMNippleRingsOK = 1;
					SMData.CopySlaveMakerDetails(SMData, _root);
				} else {
					if (coreGame.PersonIndex != -50) sd.NippleRingsWorn = 1;
					sd.NippleRingsOK = 1;
				}
				Items.ShowItem(18, 1, 2);
				DoEvent(9702);
				if (coreGame.PersonIndex == -100) AddText(NameCase("You now have a set of rings to wear in your nipple piercings."));
				else AddText(NameCase("#person now has a set of rings to wear in #personhisher nipple piercings."));
				return;
			} 
		} else if (itemno == 23)
		{
			if (BuyItem(15, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("NippleChainPricePM", "Equipment") : XMLData.GetXMLValue("NippleChainPrice", "Equipment"))) {
				sd.NippleChainOK = 1;
				Items.ShowItem(17, 1, 2);
				DoEvent(9703);
				AddText("#person now has a chain that connects #personhisher nipple piercings.\r\r");
			}
		} else if (itemno == 27)
		{
			if (BuyItem(15, 75)) {
				if (coreGame.PersonIndex == -100) {
					ServantSpeak("You may now help your slaves practice their makeup.");
					SMData.SMVanityCaseOK = 1;
					SMData.CopySlaveMakerDetails(SMData, _root);
				} else {
					ServantSpeak("You may now have #personhimher practice #personhisher makeup.");
					sd.VanityCaseOK = 1;
				}
				coreGame.PointsByIndex(coreGame.PersonIndex, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
				Items.ShowItem(0, 1, 0, 3);
				DoEvent(9702);
				return;
			}
		} else if (itemno == 28)
		{
			if (BuyItem(15, 70)) {
				if ((coreGame.PersonIndex == -100 && SMData.SMPiercingsType == 0) || (coreGame.PersonIndex != -100 && sd.PiercingsType == 0)) {
					if (coreGame.PersonIndex == -100) ServantSpeak("You can now wear nipple rings.");
					else ServantSpeak("#person can now wear nipple rings.");
					coreGame.PointsByIndex(coreGame.PersonIndex, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0);
					if (coreGame.PersonIndex == -100) {
						SMData.SMPiercingsType = 1;
						SMData.CopySlaveMakerDetails(SMData, _root);
					} else sd.PiercingsType = 1;
				} else {
					coreGame.PointsByIndex(coreGame.PersonIndex, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0);
					if (coreGame.PersonIndex == -100) {
						SMData.SMPiercingsType = 2;
						SMData.CopySlaveMakerDetails(SMData, _root);
						ServantSpeak(NameCase("You are thoroughly pierced."));
					} else {
						ServantSpeak("#person is thoroughly pierced.");
						sd.PiercingsType = 2;
					}
				}
				coreGame.DoEventNext(9702);
				return;
			}
		} else if (itemno == 29)
		{
			if (BuyItem(15, 50)) {
				if (coreGame.PersonIndex == -100) AddText("A stylist working for Skuld styles your hair.");
				else AddText("A stylist working for Skuld styles #person's hair.");
				if (coreGame.PersonIndex != -100) {
					sd.TotalHairCare++;
					sd.DurationHairCare = 6;
				}
				coreGame.PointsByIndex(coreGame.PersonIndex, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				coreGame.DoEventNext(9702);
				return;
			}
		} else if (itemno == 30)
		{
			if (BuyItem(15, 50)) {
				if (coreGame.PersonIndex == -100) AddText("An expert of skin care working for Skuld cleanses and treats your skin.");
				else AddText("An expert of skin care working for Skuld cleanses and treats #person's skin.");
				if (coreGame.PersonIndex != -100) {
					sd.TotalSkinCare++;
					sd.DurationFacialCare = 6;
				}
				coreGame.PointsByIndex(coreGame.PersonIndex, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				coreGame.DoEventNext(9702);
				return;
			}
		}
	}

	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 67: 
				PurchaseVanityCase(false); return true;
			case 72:
				PurchaseHairStyling(false); return true;
			case 77:
				PurchaseMakeUp(false); return true;
			case 80:
				PurchasePiercings(false); return true;
			case 82:
				PurchaseNippleRings(false); return true;
			case 83:
				PurchaseSkinCare(false); return true;
			case 85:
				mcBase.CustomerBtn.onPress(); return true;
		}
		return false;
	}
}