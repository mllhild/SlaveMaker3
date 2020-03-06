// Salesman
// Translation status: COMPLETE

import Scripts.Classes.*;

class ShopItemSalesman extends Shop {
		
	// constructor
	public function ShopItemSalesman(mc:MovieClip, cg:Object, cc:Object)
	{ 
		super(mc, cg, "Shopping/Shops/ItemSalesman", cc);
	}
	
		// Visit the shop
	public function VisitShop()
	{
		super.VisitShop();
		
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			mcBase._visible = false;
			SetEvent(4112);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
	
		coreGame.Action = 2508;
	
		var ti:ShopItemSalesman = this;
		mcBase.HaloButton.ActButton.onPress = function() { ti.PurchaseHalo(); }
		mcBase.HaloButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.HaloButton.ActButton.onRollOver = function() { ti.PurchaseHalo(true); }
		
		mcBase.HarnessButton.ActButton.onPress = function() { ti.PurchaseHarness(); }
		mcBase.HarnessButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.HarnessButton.ActButton.onRollOver = function() { ti.PurchaseHarness(true); }
		
		mcBase.SpikedButton.ActButton.onPress = function() { ti.PurchaseSpikedBracelet(); }
		mcBase.SpikedButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.SpikedButton.ActButton.onRollOver = function() { ti.PurchaseSpikedBracelet(true); }
		
		mcBase.HandcuffButton.ActButton.onPress = function() { ti.PurchaseHandcuffBracelet(); }
		mcBase.HandcuffButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.HandcuffButton.ActButton.onRollOver = function() { ti.PurchaseHandcuffBracelet(true); }
		
		mcBase.LeashButton.ActButton.onPress = function() { ti.PurchaseLeash(); }
		mcBase.LeashButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.LeashButton.ActButton.onRollOver = function() { ti.PurchaseLeash(true); }
		
		mcBase.TiaraButton.ActButton.onPress = function() { ti.PurchaseNymphsTiara(); }
		mcBase.TiaraButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.TiaraButton.ActButton.onRollOver = function() { ti.PurchaseNymphsTiara(true); }
		
		mcBase.OroborusButton.ActButton.onPress = function() { ti.PurchaseOroborusCandle(); }
		mcBase.OroborusButton.ActButton.onRollOut = function() { ti.ItemSalesManRollOut(); }
		mcBase.OroborusButton.ActButton.onRollOver = function() { ti.PurchaseOroborusCandle(true); }

		
		SetButtonDetails(mcBase.LeashButton, false, true, Language.GetHtml("Leash", "Equipment"), undefined, "L");
		SetButtonDetails(mcBase.OroborusButton, false, true, Language.GetHtml("OroborusCandle", "Equipment"), undefined, "O");
		SetButtonDetails(mcBase.TiaraButton, false, true, Language.GetHtml("NymphsTiara", "Equipment"), undefined, "N");
		SetButtonDetails(mcBase.HandcuffButton, false, true, Language.GetHtml("HandcuffBracelet", "Equipment"), undefined, "U");
		SetButtonDetails(mcBase.SpikedButton, false, true, Language.GetHtml("SpikedBracelet", "Equipment"), undefined, "S");
		SetButtonDetails(mcBase.HarnessButton, false, true, Language.GetHtml("SuperiorHarness", "Equipment"), undefined, "R");
		SetButtonDetails(mcBase.HaloButton, false, true, Language.GetHtml("Halo", "Equipment"), undefined, "H");
	}
		
	public function ShowShopContents()
	{
		trace("ShowShopContents");
		super.ShowShopContents();
		
		coreGame.HideDresses();
		AutoLoadImageAndShowMovie("Images/Events/Event - Travelling Merchant 1.jpg", 1, 2);
		ShowPerson(40, 1.1, 3);
		ShowSupervisor();
		//ShowEquipmentButton();
		
		mcBase.HarnessButton._visible = (SMData.PonygirlAware == 1);
		mcBase.HarnessTick._visible = (SMData.PonygirlAware == 1) && (sd.HarnessOK == 2);
		mcBase.HaloTick._visible = (SMData.SMFaith != 2) && (sd.HaloOK == 1);
		mcBase.OroborusTick._visible = (SMData.SMFaith == 2 && (sd.HaloOK == 1));
		mcBase.LeashTick._visible = sd.LeashOK == 1;
		mcBase.SpikedBraceletTick._visible = sd.SpikedBraceletOK == 1;
		mcBase.HandcuffBraceletTick._visible = sd.HandcuffBraceletOK == 1;
		mcBase.NymphsTiaraTick._visible = sd.NymphsTiaraOK == 1;
	}
	
	public function PurchaseHalo(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(2.1, false);
		ShowPerson(40, 1.1, 3);
		if (SMData.SMFaith == 2) {
			coreGame.HideYesNoButtons();
			SetText(Language.GetHtml("NotOldFaithItem", "Faith"));
		} else if (sd.HaloOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			SetText(Language.GetHtml("HaloDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("HaloPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(12, hint);
		}
	}
	
	public function PurchaseOroborusCandle(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(2.2, false);
		ShowPerson(40, 1.1, 3);
		if (SMData.SMFaith != 2) {
			coreGame.HideYesNoButtons();
			SetText(Language.GetHtml("NotNewGodsItem", "Faith"));
		} else if (sd.HaloOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			SetText(Language.GetHtml("OroborusCandleDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("HaloPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(12, hint);
		}
	}
	
	public function PurchaseHarness(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(11, false);
		ShowPerson(40, 1.1, 3);
		if (sd.HarnessOK == 2) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			SetText(Language.GetHtml("SuperiorHarnessDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("SuperiorHarnessPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(20, hint);
		}
	}
	
	public function PurchaseNymphsTiara(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(8, false);
		ShowPerson(40, 1.1, 3);
		if (sd.NymphsTiaraOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			SetText(Language.GetHtml("NymphsTiaraDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("NymphsTiaraPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(13, hint);
		}
	}
	
	public function PurchaseLeash(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(7, 0, undefined, -1);
		ShowPerson(40, 1.1, 3);
		if (sd.LeashOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			if (SMData.PonygirlAware == 1) SetText(coreGame.LeashPonyDescription);
			else SetText(coreGame.LeashDescription);
			AddText("\r"+PurchasePrice(XMLData.GetXMLValue("LeashPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(10, hint);
		}
	}
	
	public function PurchaseSpikedBracelet(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(9, false);
		ShowPerson(40, 1.1, 3);
		if (sd.SpikedBraceletOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			SetText(Language.GetHtml("SpikedBraceletDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("SpikedBraceletPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(14, hint);
		}
	}
	
	public function PurchaseHandcuffBracelet(hint:Boolean)
	{
		if (coreGame.YesEvent._visible) return;
		Items.HideItems();
		Items.ShowItem(10, false);
		ShowPerson(40, 1.1, 3);
		if (sd.HandcuffBraceletOK == 1) {
			if (!hint) Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnItem", "Shopping"));
		} else {
			SetText(Language.GetHtml("HandcuffBraceletDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("HandcuffBraceletPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(11, hint);
		}
	}
	
	public function ItemSalesManRollOut()
	{
		if (IsHints() && coreGame.YesEvent._visible == false) {
			Items.HideItems();
			ShowSupervisor();
		}
	}
	
	public function BuyFromShop(itemno:Number)
	{
		mcBase._visible = false;
		if (itemno == 10)
		{
			if (BuyItem(40, XMLData.GetXMLValue("LeashPrice", "Equipment"))) {
				sd.LeashOK = 1;
				if (!coreGame.Plannings.IsStarted()) return LeaveShop();
			}
			ShowShopContents();
			return;
		}
		if (itemno == 11)
		{
			if (BuyItem(40, XMLData.GetXMLValue("HandcuffBraceletPrice", "Equipment"))) {
				sd.HandcuffBraceletOK = 1;
				if (!coreGame.Plannings.IsStarted()) return LeaveShop();
			}
			ShowShopContents();
			return;
		}
		if (itemno == 12)
		{
			if (BuyItem(40, XMLData.GetXMLValue("HaloPrice", "Equipment"))) {
				sd.HaloOK = 1;
				if (!coreGame.Plannings.IsStarted()) return LeaveShop();
			}
			ShowShopContents();
			return;
		}
		if (itemno == 13)
		{
			if (BuyItem(40, XMLData.GetXMLValue("NymphsTiaraPrice", "Equipment"))) {
				sd.NymphsTiaraOK = 1;
				if (!coreGame.Plannings.IsStarted()) return LeaveShop();
			}
			ShowShopContents();
			return;
		}
		if (itemno == 14)
		{
			if (BuyItem(40, XMLData.GetXMLValue("SpikedBraceletPrice", "Equipment"))) {
				sd.SpikedBraceletOK = 1;
				if (!coreGame.Plannings.IsStarted()) return LeaveShop();
			}
			ShowShopContents();
			return;
		}
		if (itemno == 20)
		{
			if (BuyItem(40, XMLData.GetXMLValue("SuperiorHarnessPrice", "Equipment"))) {
				sd.HarnessOK = 2;
				if (!coreGame.Plannings.IsStarted()) return LeaveShop();
			}
			ShowShopContents();
			return;
		}

	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 72:
				PurchaseHalo(); return true;
			case 76:
				PurchaseLeash(); return true;
			case 78:
				PurchaseNymphsTiara(); return true;
			case 79:
				PurchaseOroborusCandle(); return true;
			case 82:
				PurchaseHarness(); return true;
			case 83:
				PurchaseSpikedBracelet(); return true;
			case 85:
				PurchaseHandcuffBracelet(); return true;
		}
		return false;
	}
}