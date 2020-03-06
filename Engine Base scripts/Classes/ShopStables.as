// Stables
// Translation status: COMPLETE

import Scripts.Classes.*;

class ShopStables extends Shop {
		
	// constructor
	public function ShopStables(cg:Object, cc:Object)
	{ 
		super(cg.StablesMenu, cg, "Shopping/Shops/Stables", cc);
	}
	
		// Visit the shop
	public function VisitShop()
	{
		super.VisitShop();
		
		if (!SMData.SMAdvantages.CheckBitFlag(11)) {
			if ((!SMData.BitFlagSM.CheckBitFlag(16)) && (!sd.IsPonygirl())) {
				mcBase._visible = false;
				HideEquipmentButton();
				SetText(Language.GetHtml("StablesRefusedAccess1", "Shopping") + "\r\r");
				PersonSpeak(45, Language.GetHtml("StablesRefusedAccess2", "Shopping"));
				AddText("\r\r" + Language.GetHtml("StablesRefusedAccess3", "Shopping"));
				return;
			}
		}
		
		coreGame.SlaveGirl.DoStables();
		XMLData.XMLEvent("ShoppingStables", false);
		SMData.BitFlagSM.SetBitFlag(16);
	
		var ti:ShopStables = this;
		mcBase.BtnCart.onPress = function() { ti.PurchasePonyCart(false); }
		mcBase.BtnCart.onRollOver = function() { ti.PurchasePonyCart(true);	}
		mcBase.BtnCart.onRollOut = coreGame.HideHints;
		mcBase.BtnVibratorPanties.onPress = function() { ti.PurchaseVibratorPanties(false);	}
		mcBase.BtnVibratorPanties.onRollOver = function() {	ti.PurchaseVibratorPanties(true); }
		mcBase.BtnVibratorPanties.onRollOut = mcBase.BtnCart.onRollOut;
		mcBase.BtnPonyBoots.onPress = function() { ti.PurchasePonyBoots(false);	}
		mcBase.BtnPonyBoots.onRollOver = function() { ti.PurchasePonyBoots(true); }
		mcBase.BtnPonyBoots.onRollOut = coreGame.HideHints;
		mcBase.BtnBitGag.onRollOut = coreGame.HideHints;
		mcBase.BtnBitGag.onPress = function() { ti.PurchaseBitGag(false); }
		mcBase.BtnBitGag.onRollOver = function() { ti.PurchaseBitGag(true); }
		mcBase.BtnPonyTail.onRollOut = coreGame.HideHints;
		mcBase.BtnPonyTail.onPress = function() { ti.PurchasePonyTail(false); }
		mcBase.BtnPonyTail.onRollOver = function() { ti.PurchasePonyTail(true); }
		mcBase.BtnHarness.onRollOut = coreGame.HideHints;
		mcBase.BtnHarness.onPress = function() { ti.PurchaseHarnessStables(false); }
		mcBase.BtnHarness.onRollOver = function() { ti.PurchaseHarnessStables(true); }
		mcBase.BtnNippleChain.onRollOut = coreGame.HideHints;
		mcBase.BtnNippleChain.onPress = function() { ti.PurchaseNippleChain(false);	}
		mcBase.BtnNippleChain.onRollOver = function() {	ti.PurchaseNippleChain(true); }
			
		mcBase.CartLabel.htmlText = Language.GetHtml("PonyCart", "Equipment", false, 0, "C");
		mcBase.VPLabel.htmlText = Language.GetHtml("VibratorPanties", "Equipment", false, 0, "V");
		mcBase.PonyBootsLabel.htmlText = Language.GetHtml("PonyBoots", "Equipment", false, 0, "P");
		mcBase.NippleChainLabel.htmlText = Language.GetHtml("NippleChain", "Equipment", false, 0, "N");
		mcBase.BitGagLabel.htmlText = Language.GetHtml("BitGag", "Equipment", false, 0, "B");
		mcBase.PonyTailLabel.htmlText = Language.GetHtml("PonyTail", "Equipment", false, 0, "T");
		mcBase.HarnessLabel.htmlText = Language.GetHtml("BasicHarness", "Equipment", false, 0, "H");
		
		mcBase.TitleText.htmlText = Language.GetHtml("StablesTitle", "Shopping", true);
		mcBase.ItemsText.htmlText = Language.GetHtml("StablesHeader", "Shopping");

	}
		
	public function ShowShopContents()
	{
		super.ShowShopContents();
		
		Backgrounds.ShowStables();
		ShowSupervisor();

		ShowEquipmentButton();
		
		mcBase.NippleChainBought._visible = (sd.NippleChainOK == 1);
		mcBase.NippleChainNA._visible = (sd.PiercingsType == 0);
		mcBase.PonyBootsBought._visible = (sd.PonyBootsOK == 1);
		mcBase.PonyCartBought._visible = (sd.PonyCartOK == 1);
		mcBase.VibratorPantiesBought._visible = sd.VibratorPantiesOK == 1;
		mcBase.HarnessBought._visible = sd.HarnessOK != 0;
		mcBase.BitGagBought._visible = sd.BitGagOK != 0;
		mcBase.PonyTailBought._visible = sd.PonyTailOK != 0;
	}


	function PurchaseBitGag(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == true && !IsHints()) return;
		if (sd.BitGagOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnBitGag", "Shopping"));
		} else {
			PersonSpeak(45, Language.GetHtml("BitGagDescription", "Equipment") + "\r\r" + PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("BitGagPricePM", "Equipment") : XMLData.GetXMLValue("BitGagPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(34, hint);
		}
	}
	
	function PurchasePonyTail(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == true && !IsHints()) return;
		if (sd.PonyTailOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnPonyTail", "Shopping"));
		} else {
			PersonSpeak(45, Language.GetHtml("PonyTailDescription", "Equipment") + "\r\r" + PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("PonyTailPricePM", "Equipment") : XMLData.GetXMLValue("PonyTailPrice", "Equipment")) + coreGame.GP);
			if (sd.HasTail) AddLangText("PonyTailTail", "Equipment");
			PurchaseItem(35, hint);
		}
	}
	
	function PurchaseHarnessStables(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == true && !IsHints()) return;
		if (sd.HarnessOK != 0) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnHarness", "Shopping"));
		} else {
			if (sd.HarnessOK == 2) {
				if (!hint) Beep();
				coreGame.HideYesNoButtons();
				ServantSpeak(Language.GetHtml("AlreadyOwnSuperiorHarness", "Equipment"));
			} else {
				PersonSpeak(45 , Language.GetHtml("BasicHarnessDescription", "Equipment") + ".\r" + PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("BasicHarnessPricePM", "Equipment") : XMLData.GetXMLValue("BasicHarnessPrice", "Equipment")) + coreGame.GP);
				PurchaseItem(36, hint);
			}
		}
	}
	
	function PurchasePonyCart(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (sd.PonyCartOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnCart", "Shopping"));
		} else {
			PersonSpeak(45 , Language.GetHtml("PonyCartDescription", "Equipment") + "\r" + PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("PonyCartPricePM", "Equipment") : XMLData.GetXMLValue("PonyCartPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(31, hint);
		}
	}
	
	function PurchasePonyBoots(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == true && !IsHints()) return;
		if (sd.PonyBootsOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("PonyBootsOwned", "Shopping"));
		} else {
			PersonSpeak(45, Language.GetHtml("PonyBootsDescription", "Equipment") + "\r" + PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("PonyBootsPricePM", "Equipment") : XMLData.GetXMLValue("PonyBootsPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(32, hint);
		}
	}
	
	function PurchaseVibratorPanties(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (sd.VibratorPantiesOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnedVibratorPanties", "Shopping"));
		} else {
			PersonSpeak(45, Language.GetHtml(sd.IsFemale() ? "VibratorPantiesDescriptionFemale" : "VibratorPantiesDescriptionMale", "Equipment") + "\r\r" + PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("VibratorPantiesPricePM", "Equipment") : XMLData.GetXMLValue("VibratorPantiesPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(33, hint);
		}
	}
	
	function PurchaseNippleChain(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == true && !IsHints()) return;
		if (sd.PiercingsType == 0) {
			Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("NoNipplePiercings", "Shopping"));
		} else if (sd.NippleChainOK == 1) {
			Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnedNippleChain", "Shopping"));
		} else {
			PersonSpeak(15, Language.GetHtml("NippleChainDescription", "Equipment") + "\r"+PurchasePrice(SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("NippleChainPricePM", "Equipment") : XMLData.GetXMLValue("NippleChainPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(23, hint);
		}
	}
	
	function BuyFromShop(itemno:Number)
	{
		if (itemno == 23)
    	{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("NippleChainPricePM", "Equipment") : XMLData.GetXMLValue("NippleChainPrice", "Equipment"))) {
				sd.NippleChainOK = 1;
				Items.ShowItem(17, true, 2);
				DoEvent(9703);
				AddLangText("NippleChainPurchased", "Shopping");
			}
			return;
		}
		if (itemno == 31)
		{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("PonyCartPricePM", "Equipment") : XMLData.GetXMLValue("PonyCartPrice", "Equipment"))) {
				AddLangText("PonyCartPurchased", "Shopping");
				coreGame.PonyCartOK = 1;
				HideBackgrounds();
				Items.ShowItem(0, 1, 3, 4);
				DoEvent(9703);
			}
			return;
		} 
		if (itemno == 32)
		{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("PonyBootsPricePM", "Equipment") : XMLData.GetXMLValue("PonyBootsPrice", "Equipment"))) {
				AddLangText("PonyBootsPurchased", "Shopping");
				sd.PonyBootsOK = 1;
				Items.ShowItem(0, 1, 1, 5);
				DoEvent(9703);
			}
			return;
		} 
		if (itemno == 33)
		{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("VibratorPantiesPricePM", "Equipment") : XMLData.GetXMLValue("VibratorPantiesPrice", "Equipment"))) {
				AddLangText("VibratorPantiesPurchased", "Shopping");
				sd.VibratorPantiesOK = 1;
				Items.WearItem(6);
				Items.ShowItem(6, 1, 0);
				DoEvent(9703);
			}
			return;
		}
		if (itemno == 34)
		{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("BitGagPricePM", "Equipment") : XMLData.GetXMLValue("BitGagPrice", "Equipment"))) {
				AddLangText("BitGagPurchased", "Shopping");
				sd.BitGagOK = 1;
				Items.ShowItem(14, 1, 0);
				DoEvent(9703);
			}
		} else if (itemno == 35)
		{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("PonyTailPricePM", "Equipment") : XMLData.GetXMLValue("PonyTailPrice", "Equipment"))) {
				AddLangText("PonyTailPurchased", "Shopping");
				sd.PonyTailOK = 1;
				Items.ShowItem(1, 1, 0);
				DoEvent(9703);
			}
			return;
		} 
		if (itemno == 36)
		{
			if (BuyItem(45, SMData.SMAdvantages.CheckBitFlag(11) ? XMLData.GetXMLValue("BasicHarnessPricePM", "Equipment") : XMLData.GetXMLValue("BasicHarnessPrice", "Equipment"))) {
				AddLangText("BasicHarnessPurchased", "Shopping");
				sd.HarnessOK = 1;
				Items.ShowItem(11, 1, 0);
				DoEvent(9703);
			}
			return;
		}
	}
	
		
	public function DoInitialVisit()
	{
		bInitialVisit = false;
		SetText(Language.GetHtml("StablesFirstVisit1", "Shopping") + "\r\r");
		PersonSpeak(45, Language.GetHtml("StablesFirstVisit2", "Shopping"), true);
		AddText("\r\r" + Language.GetHtml("StablesFirstVisit3", "Shopping") + "\r\r");
		PersonSpeak(45, Language.GetHtml("StablesFirstVisit4", "Shopping"), true);
	}

	private function DoLaterVisit()
	{
		PersonSpeak(45, Language.GetHtml("StablesLaterVisits", "Shopping"));
	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 66: 
				PurchaseBitGag(false); return true;
			case 67: 
				PurchasePonyCart(false); return true;
			case 72:
				PurchaseHarnessStables(false); return true;
			case 78:
				PurchaseNippleChain(false); return true;
			case 80:
				PurchasePonyBoots(false); return true;
			case 84:
				PurchasePonyTail(false); return true;
			case 86:
				PurchaseVibratorPanties(false); return true;
			case 89:
				PurchasePonyCart(false); return true;
		}
		return false;
	}
}