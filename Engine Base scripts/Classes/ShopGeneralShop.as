// Rinno's Shop
/*
For a Magazine maybe something like "MxM: Man Love Manual"
*/
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class ShopGeneralShop extends Shop {
	
	private var nPriceNecklace:Number;		// price of the current piece of jewelry
	public var nNecklaceIndex;				// the type of kewlry
	public var nPriceDoll;					// current price of the doll
	
	// constructor
	public function ShopGeneralShop(mc:MovieClip, cg:Object, nn:String, cc:Object)
	{ 
		super(mc, cg, nn == undefined ? "Shopping/Shops/GeneralShop" : nn, cc);
		//trace("ShopGeneralShop: " + mc + " " + mcBase);
	
		Reset();
		
		mcBase.Quantity.restrict = "0-9";
	}
	
	public function Reset()
	{
		super.Reset();
		
		nCurrentPage = 1;
		nNecklaceIndex = 0;
		nPriceDoll = 300;
		
		coreGame.NecklaceIndex = nNecklaceIndex; // todo remove
		coreGame.PriceDoll = nPriceDoll;		// todo remove
	}
	
	public function Load(lo:Object)
	{
		super.Load(lo);

		nNecklaceIndex = lo.NecklaceIndex;
		nPriceDoll = lo.PriceDoll;
		
		coreGame.NecklaceIndex = nNecklaceIndex;	// todo remove
		coreGame.PriceDoll = nPriceDoll;			// todo remove
		
		if (nPriceDoll == undefined) {
			nPriceDoll = lo.vPriceDoll;
			if (nPriceDoll == undefined) nPriceDoll = 300;
		}
		if (nNecklaceIndex == undefined) {
			nNecklaceIndex = lo.vNecklaceIndex;
			if (nNecklaceIndex == undefined) nNecklaceIndex = 0;
		}
	}
	
	public function Save(so:Object)
	{
		super.Save(so);
		
		so.NecklaceIndex = nNecklaceIndex;
		so.PriceDoll = nPriceDoll;
	}
	
	// Visit the shop
	public function VisitShop()
	{
		trace("ShopGeneralShop.VisitShop: " + mcBase);
		super.VisitShop();
		
		coreGame.SlaveGirl.DoShop();
		XMLData.XMLEvent("ShoppingShop", false);
		coreGame.BitFlag1.SetBitFlag(28);
		
		var ti:ShopGeneralShop = this;
		
		mcBase.LText1.htmlText = Language.GetHtml("ShopTitle", "Shopping", true);
		
		mcBase.LText2.htmlText = Language.GetHtml("ShopCategoriesTitle", "Shopping", true);
		mcBase.LText3.htmlText = Language.GetHtml("ShopQuantity", "Shopping", true);
		mcBase.Category1.LText.htmlText = Language.GetHtml("ShopCategoryPotions", "Shopping", true);
		mcBase.Category2.LText.htmlText = Language.GetHtml("ShopCategoryBooks", "Shopping", true);
		mcBase.Category3.LText.htmlText = Language.GetHtml("ShopCategoryErotica", "Shopping", true);
		mcBase.Category4.LText.htmlText = Language.GetHtml("ShopCategoryAccessories", "Shopping", true);
		
		mcBase.Category1.Btn.onPress = function() { ti.UpdatePurchasePage(1); ti.SetGeneralText(""); }
		mcBase.Category2.Btn.onPress = function() { ti.UpdatePurchasePage(2); ti.SetGeneralText(""); }
		mcBase.Category3.Btn.onPress = function() { ti.UpdatePurchasePage(3); ti.SetGeneralText(""); }
		mcBase.Category4.Btn.onPress = function() { ti.UpdatePurchasePage(4); ti.SetGeneralText(""); }
		mcBase.BtnMinus.onPress = function()
		{
			ti.PurchaseQuantity--;
			if (ti.PurchaseQuantity < 1) ti.SetShopQuantity(1, true);
			ti.mcBase.Quantity.text = ti.PurchaseQuantity;
		}
		mcBase.BtnPlus.onPress = function()
		{
			ti.PurchaseQuantity++;
			ti.mcBase.Quantity.text = ti.PurchaseQuantity;
		}
		mcBase.Quantity.onChanged = function()
		{
			if (!ti.mcBase.BtnPlus._visible)ti. mcBase.Quantity.text = ti.PurchaseQuantity;
			else {
				Timers.AddTimer(
					setInterval(ti, "ChangeQuantityDelayed", 200, Timers.GetNextTimerIdx())
				);
			}
		}
		for (var i:Number = 1; i < 11; i++) {
			mcBase["BtnItem" + i].ActButton.onPress = function() {
				ti.AskToPurchaseItem(this._parent.curract, false);
			}
			mcBase["BtnItem" + i].ActButton.onRollOver = function() {
				ti.AskToPurchaseItem(this._parent.curract, true);
			}		
		}
		mcBase.Quantity.text = PurchaseQuantity;
	}
		
	public function ShowShopContents()
	{
		super.ShowShopContents();
		
		if (!XMLData.XMLGeneral("ShowShop", false, xNode)) ShowPerson("Merchant", "Shop");
		
		ShowSupervisor();
		ShowEquipmentButton();
		
		UpdatePurchasePage();
	}
	
	
	public function UpdatePurchasePage(scat:Number)
	{
		if (scat != undefined) nCurrentPage = scat;
		
		mcBase.Category1._alpha = 50;
		mcBase.Category2._alpha = 50;
		mcBase.Category3._alpha = 50;
		mcBase.Category4._alpha = 50;
		mcBase.BtnItem1._visible = true;
		mcBase.BtnItem2._visible = true;
		mcBase.BtnItem3._visible = false;
		mcBase.BtnItem4._visible = false;
		mcBase.BtnItem5._visible = false;
		mcBase.BtnItem6._visible = false;
		mcBase.BtnItem7._visible = false;
		mcBase.BtnItem8._visible = false;
		mcBase.BtnItem9._visible = false;
		mcBase.BtnItem10._visible = false;
		SetShopQuantity(PurchaseQuantity, true);
		EnableShopQuantity(true);
		coreGame.HideYesNoButtons();
		
		switch(nCurrentPage) {
			// Potions
			case 1: 
				SetShopQuantity(undefined, true);
				EnableShopQuantity(true);
				SetButtonDetails(mcBase.BtnItem1, false, true, Potions.GetPotionName(4), 4, "E");
				SetButtonDetails(mcBase.BtnItem2, false, true, Potions.GetPotionName(1), 1, "U");
				SetButtonDetails(mcBase.BtnItem3, false, true, Potions.GetPotionName(2), 2, "A");
				SetButtonDetails(mcBase.BtnItem4, false, true, Potions.GetPotionName(10), 21, "D");
				SetButtonDetails(mcBase.BtnItem5, false, true, Potions.GetPotionName(3), 3, "S");
				mcBase.Category1._alpha = 100;
				mcBase.BtnItem3._visible = true;
				mcBase.BtnItem4._visible = true;
				mcBase.BtnItem5._visible = true;
				break;
				
			// Books
			case 2: 
				SetShopQuantity(undefined, true);
				EnableShopQuantity(true);
				mcBase.Category2._alpha = 100;
				SetButtonDetails(mcBase.BtnItem1, false, true, Language.GetHtml("Book", "Equipment"), 7, "B");
				SetButtonDetails(mcBase.BtnItem2, false, true, Language.GetHtml("PoetryBook", "Equipment"), 6, "P");
				mcBase.BtnItem3._visible = !SMData.OtherBooks.CheckBitFlag(0);
				SetButtonDetails(mcBase.BtnItem3, false, true, Language.GetHtml("LadiesGuide", "Equipment"), 41, "L");
				mcBase.BtnItem4._visible = !SMData.OtherBooks.CheckBitFlag(1);
				SetButtonDetails(mcBase.BtnItem4, false, true, Language.GetHtml("HistoricalTales", "Equipment"), 42, "H");
				if (SMData.sGayTrainer == 0) {
					mcBase.BtnItem5._visible = !SMData.OtherBooks.CheckBitFlag(2);
					SetButtonDetails(mcBase.BtnItem5, false, true, Language.GetHtml("MasculineShort1", "Equipment"), 43, "M");
				} else if (SMData.sGayTrainer > 1 && SMData.sGayTrainer < 2 && SMData.OtherBooks.CheckBitFlag(2) && !SMData.OtherBooks.CheckBitFlag(3)) {
					mcBase.BtnItem5._visible = !SMData.OtherBooks.CheckBitFlag(3);
					SetButtonDetails(mcBase.BtnItem5, false, true, Language.GetHtml("MasculineShort2", "Equipment"), 43, "M");
				}
				break;
				
			// Erotica
			case 3: 
				SetShopQuantity(undefined, false);
				EnableShopQuantity(false);
				SetButtonDetails(mcBase.BtnItem1, false, true, Language.GetHtml("Dildo", "Equipment"), 24, "I");
				SetButtonDetails(mcBase.BtnItem2, false, true, Language.GetHtml("AnalPlug", "Equipment"), 25, "N");
				SetButtonDetails(mcBase.BtnItem3, false, true, Language.GetHtml("BondageGear", "Equipment"), 26, "G");
				mcBase.Category3._alpha = 100;
				mcBase.BtnItem3._visible = coreGame.BDSMOn && (SMData.RopesOK == 0);
				mcBase.BtnItem2._visible = (coreGame.PlugOK == 0);
				if (coreGame.DildoOK == 0 && coreGame.ImprovedDildoOK == 0) mcBase.BtnItem1._visible = true;
				else mcBase.BtnItem1._visible = false;
				break;
				
			// Jewelry
			case 4: 
				SetShopQuantity(undefined, true);
				EnableShopQuantity(true);
				SetDollButton();
				SetJeweleryButton();
				mcBase.Category4._alpha = 100;
				break;
	
		}
	}
		
	public function ChangeQuantityDelayed(timer:Number)
	{
		Timers.RemoveTimer(timer);
		PurchaseQuantity = Number(mcBase.Quantity.text);
		if (isNaN(PurchaseQuantity) || PurchaseQuantity < 1) SetShopQuantity(1, true);
		mcBase.Quantity.text = PurchaseQuantity;
	}
	
	
	public function SetShopQuantity(no:Number, bShow:Boolean)
	{
		if (no != undefined) PurchaseQuantity = no;
		mcBase.Quantity._visible = bShow;
		mcBase.LText3._visible = bShow;
		mcBase.BtnMinus._visible = bShow;
		mcBase.BtnPlus._visible = bShow;
		mcBase.Quantity.text = PurchaseQuantity;
	}
	
	public function EnableShopQuantity(bEnable:Boolean)
	{
		mcBase.Quantity.enabled = bEnable;
		mcBase.BtnMinus.enabled = bEnable;
		mcBase.BtnPlus.enabled = bEnable;
		mcBase.BtnMinus._visible = bEnable;
		mcBase.BtnPlus._visible = bEnable;
	}
	
	public function SetJeweleryButton()
	{
		if (nCurrentPage != 4) return;
		switch (nNecklaceIndex) {
			case 0: 
				nPriceNecklace = 300;
				break;
			case 1: 
				nPriceNecklace = 180;
				break;
			case 2: 
				nPriceNecklace = 240;
				break;
			case 3:
				nPriceNecklace = 180;
				break;			
			case 4: 
				nPriceNecklace = 360;
				break;
			case 5: 
				nPriceNecklace = 120;
				break;
			case 6: 
				nPriceNecklace = 240;
				break;
			case 7: 
				nPriceNecklace = 180;
				break;
			case 8: 
				nPriceNecklace = 120;
				break;
		}
		coreGame.PriceNecklace = nPriceNecklace;		// TODO remove
		SetButtonDetails(mcBase.BtnItem1, false, true, Language.GetHtml("Jewelry" + (nNecklaceIndex + 1), "Equipment"), 5, "J");
	}
	
	public function GetJeweleryName() : String
	{
		return Language.GetHtml("Jewelry" + (nNecklaceIndex + 1), "Equipment");
	}
	
	public function SetDollButton()
	{
		var i:Number;
		if (nCurrentPage != 4) return;
		switch (nPriceDoll) {
			case 300: 
				i = 1;
				break;
			case 240: 
				i = 2;
				break;
			case 180: 
				i = 3;
				break;
			case 120: 
				i = 4;
				break;
		}
		SetButtonDetails(mcBase.BtnItem2, false, true, Language.GetHtml("Toy" + i, "Equipment"), 8, "T");
	}
	
	
	public function PurchaseBook(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		if (SMData.GuildMember) PersonSpeak(1, Language.GetHtml("BookDescription", "Equipment") + "\r\r" + Language.GetHtml("Intelligence", coreGame.statNode) + " + " + Math.floor(6 * coreGame.dmod) + "\r"+PurchasePrice(500) + coreGame.GP + "\r\r" + Language.GetHtml("PersonItemNote", "Shopping"));
		else PersonSpeak(1, Language.GetHtml("BookDescription", "Equipment") + "\r\r" + Language.GetHtml("Intelligence", coreGame.statNode) + " + " + Math.floor(6 * coreGame.dmod) + "\r"+PurchasePrice(500) + coreGame.GP);
		PurchaseItem(7, hint);
	}
	
	public function PurchasePoetryBook(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		if (SMData.GuildMember) PersonSpeak(1, Language.GetHtml("PoetryBookDescription", "Equipment") + "\r\r" + Language.GetHtml("Sensibility", coreGame.statNode) + " + " + Math.floor(6 * coreGame.dmod) + "\r"+PurchasePrice(XMLData.GetXMLValue("PoetryPrice", "Equipment")) + coreGame.GP + "\r\r" + Language.GetHtml("PersonItemNote", "Shopping"));
		else PersonSpeak(1, Language.GetHtml("PoetryBookDescription", "Equipment") + "\r\r" + Language.GetHtml("Sensibility", coreGame.statNode) + " + " + Math.floor(6 * coreGame.dmod) + "\r"+PurchasePrice(800) + coreGame.GP);
		PurchaseItem(6, hint);
	}
	
	public function PurchaseLadiesGuide(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(1, false);
		if (!hint) EnableShopQuantity(false);
		if (SMData.GuildMember) PersonSpeak(1, Language.GetHtml("LadiesGuideDescription", "Equipment") + "\r\r" + Language.GetHtml("Refinement", coreGame.statNode) + " + " + Math.floor(5 * coreGame.dmod) + "\r" + Language.GetHtml("Fucking", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Blowjobs", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Lust", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod)  + "\r"+PurchasePrice(800) + coreGame.GP + "\r\r" + Language.GetHtml("PersonItemNote", "Shopping"));
		else PersonSpeak(1, Language.GetHtml("LadiesGuideDescription", "Equipment") + "\r\r" + Language.GetHtml("Refinement", coreGame.statNode) + " + " + Math.floor(5 * coreGame.dmod) + "\r" + Language.GetHtml("Fucking", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Blowjobs", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Lust", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod)  + "\r"+PurchasePrice(800) + coreGame.GP);
		PurchaseItem(41, hint);
	}
	
	public function PurchaseHistoricalTales(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(1, false);
		if (!hint) EnableShopQuantity(false);
		if (SMData.GuildMember) PersonSpeak(1, Language.GetHtml("HistoricalTalesDescription", "Equipment") + "\r\r" + Language.GetHtml("Intelligence", coreGame.statNode) + " + " + Math.floor(3 * coreGame.dmod) + "\r" + Language.GetHtml("Morality", coreGame.statNode) + " + " + Math.floor(3 * coreGame.dmod) + "\r" + Language.GetHtml("Nymphomania", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Lust", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod)  + "\r"+PurchasePrice(550) + coreGame.GP + "\r\r" + Language.GetHtml("PersonItemNote", "Shopping"));
		else PersonSpeak(1, Language.GetHtml("HistoricalTalesDescription", "Equipment") + "\r\r" + Language.GetHtml("Intelligence", coreGame.statNode) + " + " + Math.floor(3 * coreGame.dmod) + "\r" + Language.GetHtml("Morality", coreGame.statNode) + " + " + Math.floor(3 * coreGame.dmod) + "\r" + Language.GetHtml("Nymphomania", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Lust", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod)  + "\r"+PurchasePrice(550) + coreGame.GP);
		PurchaseItem(42, hint);
	}
	
	public function PurchaseMasculineLove(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(1, false);
		if (!hint) EnableShopQuantity(false);
		var bn:String = "MasculineLove" + (SMData.OtherBooks.CheckBitFlag(2) ? "2" : "1");
		PersonSpeak(1, Language.GetHtml(bn + "Description", "Equipment") + "\r\r" + Language.GetHtml("Lust", coreGame.statNode) + " + " + Math.floor(5 * coreGame.dmod) + "\r" + Language.GetHtml("Fucking", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod) + ", " + Language.GetHtml("Blowjobs", coreGame.statNode) + " + " + Math.floor(2 * coreGame.dmod)  + "\r"+PurchasePrice(100) + coreGame.GP + "\r\r" + Language.GetHtml("PersonItemNote", "Shopping"));
		PurchaseItem(43, hint);
	}
	
	public function PurchaseEnergyDrink(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		var price:Number = PotionPrice(undefined, 4);
		PersonSpeak(1, Potions.GetPotionDescription(4) + "\r\r" + Language.GetHtml("Tiredness", coreGame.statNode) + " - " + Math.floor(20 * coreGame.dmod) + "\r" + price + coreGame.GP);
		if (coreGame.AssistantData.PotionsUsed[4] == -1) XMLData.XMLGeneral("Potions/AssistantCanMake");
		if (coreGame.PotionsUsed[4] == -1) XMLData.XMLGeneral("Potions/SlaveCanMake");
		else PurchaseItem(4, hint);
	}
	
	public function PurchaseLustDraft(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		var price:Number = PotionPrice(undefined, 10);
		PersonSpeak(1, Potions.GetPotionDescription(10) + "\r\r" + Language.GetHtml("Lust", coreGame.statNode) + " + 7\r" + price + coreGame.GP);
		if (coreGame.AssistantData.PotionsUsed[10] == -1) XMLData.XMLGeneral("Potions/AssistantCanMake");
		if (coreGame.PotionsUsed[10] == -1) XMLData.XMLGeneral("Potions/SlaveCanMake");
		else PurchaseItem(21, hint);
	}
	
	public function PurchaseSoothingDraft(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		var price:Number = PotionPrice(undefined, 3);
		PersonSpeak(1, Potions.GetPotionDescription(3) + "\r\r" + Language.GetHtml("Nymphomania", coreGame.statNode) + " - 10\r" + Language.GetHtml("Tiredness", coreGame.statNode) + " -10\r" + Language.GetHtml("Lust", coreGame.statNode) + " -5\r" + price + coreGame.GP);
		if (coreGame.AssistantData.PotionsUsed[3] == -1) XMLData.XMLGeneral("Potions/AssistantCanMake");
		if (coreGame.PotionsUsed[3] == -1) XMLData.XMLGeneral("Potions/SlaveCanMake");
		else PurchaseItem(3, hint);
	}
	
	public function PurchaseAphrodisiac(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		var price:Number = PotionPrice(undefined, 2);
		PersonSpeak(1, Potions.GetPotionDescription(2) + "\r\r" + Language.GetHtml("Lust", coreGame.statNode) + " + 3\r"+price+ coreGame.GP);
		if (coreGame.AssistantData.PotionsUsed[2] == -1) XMLData.XMLGeneral("Potions/AssistantCanMake");
		if (coreGame.PotionsUsed[2] == -1) XMLData.XMLGeneral("Potions/SlaveCanMake");
		else PurchaseItem(2, hint);
	}
	
	public function PurchaseUninhibitory(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(1, false);
		if (!hint) EnableShopQuantity(false);
		PersonSpeak(1, Potions.GetPotionDescription(1) + "\r\r" + Language.GetHtml("Obedience", coreGame.statNode) + " + 5\r"+PotionPrice(250, 1)+ coreGame.GP);
		PurchaseItem(1, hint);
	}
	
	public function PurchaseDildo(hint:Boolean)
	{ 
		if (!IsEventAllowable()) return;
		if (coreGame.DildoOK == 1 || coreGame.ImprovedDildoOK == 1) {
			coreGame.Beep();
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnedDildo", "Equipment"));
		} else {
			SetShopQuantity(1, false);
			PersonSpeak(1, Language.GetHtml("DildoDescription", "Equipment") + "\r"+PurchasePrice(XMLData.GetXMLValue("DildoPrice", "Equipment")) + coreGame.GP);
			PurchaseItem(24, hint);
		}
	}
	
	public function PurchasePlug(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(1, false);
		PersonSpeak(1, Language.GetHtml("AnalPlugDescription", "Equipment") + "\r\r"+PurchasePrice(XMLData.GetXMLValue("AnalPlugPrice", "Equipment")) + coreGame.GP);
		PurchaseItem(25, hint);
	}
	
	public function PurchaseBondageGear(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(1, false);
		PersonSpeak(1, Language.GetHtml("BondageGearDescription", "Equipment") + "\r\r"+PurchasePrice(XMLData.GetXMLValue("BondageGearPrice", "Equipment")) + coreGame.GP);
		PurchaseItem(26, hint);
	}
	
	public function PurchaseDoll(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		PersonSpeak(1, mcBase.BtnItem2.ActLabel.text+".\r\r" + Language.GetHtml("Joy", coreGame.statNode) + " + " + Math.floor(coreGame.dmod * nPriceDoll / 30) + "\r"+PurchasePrice(nPriceDoll) + coreGame.GP);
		PurchaseItem(8, hint);
	}
	
	public function PurchaseJewelry(hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SetShopQuantity(PurchaseQuantity, true);
		if (!hint) EnableShopQuantity(false);
		PersonSpeak(1, GetJeweleryName() + ".\r\r" + Language.GetHtml("Refinement", coreGame.statNode) + " + " + Math.floor(nPriceNecklace / 60 * coreGame.dmod) + "\r"+PurchasePrice(nPriceNecklace) + coreGame.GP);
		PurchaseItem(5, hint);
	}
	
	public function AskToPurchaseItem(itemno:Number, hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == undefined) hint = false;
		
		switch(itemno) {
			case 1: PurchaseUninhibitory(hint); break;
			case 2: PurchaseAphrodisiac(hint); break;
			case 3: PurchaseSoothingDraft(hint); break;
			case 4: PurchaseEnergyDrink(hint); break;
			case 5: PurchaseJewelry(hint); break;
			case 6: PurchasePoetryBook(hint); break;
			case 7: PurchaseBook(hint); break;
			case 8: PurchaseDoll(hint); break;
			case 21: PurchaseLustDraft(hint); break;
			case 24: PurchaseDildo(hint); break;
			case 25: PurchasePlug(hint); break;
			case 26: PurchaseBondageGear(hint); break;
			case 41: PurchaseLadiesGuide(hint); break;
			case 42: PurchaseHistoricalTales(hint); break;
			case 43: PurchaseMasculineLove(hint); break;
		}
	}
		
	public function GetTotalPages() : Number { return 4; }
	
	public function DoEventNext() : Boolean
	{
		switch (coreGame.NumEvent) {
			// variant potion
			case 22:
			case 22.1:
			case 22.2:
			case 22.3:
				switch(coreGame.NumEvent) {
					case 22: coreGame.ObjectChoice = 1.2; break;
					case 22.1: coreGame.ObjectChoice = 1.3; break;
					case 22.2: coreGame.ObjectChoice = 1.4; break;
					case 22.3: coreGame.ObjectChoice = 1.5; break;
				}
				super.DoEventYes();
				return true;
				
			case 9700:
				coreGame.HideYesNoButtons();
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				coreGame.HidePeople();
				Items.HideItems();
				coreGame.NextEvent._visible = false;
				ShowShopContents();
				return true;

		}
		return false;
	}

	public function DoEventYes() : Boolean
	{
		switch (coreGame.NumEvent) {
			// variant potion
			case 22:
			case 22.1:
			case 22.2:
			case 22.3:
				switch(coreGame.NumEvent) {
					case 22: coreGame.ObjectChoice = 1.2; break;
					case 22.1: coreGame.ObjectChoice = 1.3; break;
					case 22.2: coreGame.ObjectChoice = 1.4; break;
					case 22.3: coreGame.ObjectChoice = 1.5; break;
				}
				break;
		}
		return super.DoEventYes();
	};
	
	public function DoEventNo() : Boolean
	{ 
		switch (coreGame.NumEvent) {
			// variant potion
			case 22:
				coreGame.ObjectChoice = 1.1;
				return super.DoEventYes();
		}
		return super.DoEventNo();
	};

	
	public function BuyFromShop(itemno:Number)
	{
		mcBase._visible = false;
		trace("BuyFromShop: " + itemno);
	
		if (itemno < 2) return BuyUninhibitoryDrug(itemno);
		
		if (itemno == 2)
		{
			if (BuyPotion(1, 2)) {
				Items.ShowItem(0, true, 0, 10);
				DoEvent(9700);
			} else ShowShopContents();
			return;
		}
		if (itemno == 3)
		{
			if (BuyPotion(1, 3)) {
				Items.ShowItem(0, true, 0, 10);
				DoEvent(9700);
			} else ShowShopContents();
			return;
		}
		if (itemno == 4)
		{
			if (BuyPotion(1, 4)) {
				Items.ShowItem(0, true, 0, 8);
				DoEvent(9700);
			} else ShowShopContents();
			return;
		}
		if (itemno == 5)
		{
			if (BuyItem(1, nPriceNecklace)) {
				AddText(coreGame.SlaveHeSheUC + NonPlural(" add") + " the " + GetJeweleryName().toLowerCase() + " to #slavehisher jewellery box.\r\r");
				var cj:Number = coreGame.TotalJewelry;
				coreGame.TotalJewelry += PurchaseQuantity;
				while (cj < coreGame.TotalJewelry) {
					if (cj == 5) SlaveSpeak(coreGame.SlavePronoun + " have a good variety of jewellery and can match them to the situation well. More would be nice but would not really help in social situations.");
					if (cj > 5) {
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0);
						coreGame.PointsMod(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					} else {
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
						coreGame.PointsMod(0, 0, nPriceNecklace / 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					}
					cj++;
				}
				nNecklaceIndex = Math.floor(Math.random()*9);
				coreGame.NecklaceIndex = nNecklaceIndex;	// todo remove
				SetJeweleryButton();
				DoEvent(9700);
			} else ShowShopContents();
			return;
		}
		if (itemno == 6)
		{
			if (BuyItem(1, XMLData.GetXMLValue("PoetryPrice", "Equipment"), true)) {
				Items.ShowItem(0, true, 0, 2);
				DoEvent(9700);
				XMLData.XMLGeneral("Equipment/PoetryPurchased");
				SMData.TotalPoetry += PurchaseQuantity;
				coreGame.TotalPoetry = SMData.TotalPoetry;
			} else ShowShopContents();
			return;
		}
		if (itemno == 7)
		{
			if (BuyItem(1, 500, true)) {
				Items.ShowItem(0, true, 0, 2);
				DoEvent(9700);
				SMData.TotalBooks += PurchaseQuantity;
				coreGame.TotalBooks = SMData.TotalBooks;				
				XMLData.XMLGeneral("Equipment/BookPurchased");
			} else ShowShopContents();
			return;
		}
		if (itemno == 8)
		{
			trace("..Doll: " + nPriceDoll);
			if (BuyItem(1, nPriceDoll)) {
				trace("..Doll: qty " + PurchaseQuantity);
				SlaveSpeakStart("Thank you for the " + mcBase.BtnItem2.ActLabel.text.toLowerCase() + ".");
				var cd:Number;
				var td:Number;
				var ct:Number;
				if (nPriceDoll == 300) {
					cd = coreGame.TotalDoll;
					coreGame.TotalDoll += PurchaseQuantity;
					td = coreGame.TotalDoll;
					ct = coreGame.TotalTeddyBear + coreGame.TotalGames;
				} else if (nPriceDoll == 240) {
					cd = coreGame.TotalTeddyBear;
					coreGame.TotalTeddyBear += PurchaseQuantity;
					td = coreGame.TotalTeddyBear;
					ct = coreGame.TotalDoll + coreGame.TotalGames;
				} else {
					cd = coreGame.TotalGames;
					coreGame.TotalGames += PurchaseQuantity;
					td = coreGame.TotalGames;
					ct = coreGame.TotalTeddyBear + coreGame.TotalDoll;
				}
				if ((coreGame.TotalDoll + coreGame.TotalTeddyBear + coreGame.TotalGames) > 3) SlaveSpeakEnd("\r\r" + coreGame.SlavePronoun + " do have enough playthings. It is nice to have a variety but please do not waste your money.");
				else SlaveSpeakEnd();
	
				while (cd < td) { 
					if ((ct + cd) > 4) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0.5, 0);
					else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, nPriceDoll / 30, 1, 0);
					cd++;
				}
				
				temp = Math.floor(Math.random()*4);
				if (coreGame.TotalTeddyBear == 0) temp = 1;
				switch (temp) {
					case 0: 
						nPriceDoll = 300;
						break;
					case 1: 
						nPriceDoll = 240;
						break;
					case 2: 
						nPriceDoll = 180;
						break;
					case 3: 
						nPriceDoll = 120;
						break;
				}
				coreGame.PriceDoll = nPriceDoll;		// todo remove
				SetDollButton();
				DoEvent(9700);
			} else ShowShopContents();
			return;
		} 
		if (itemno == 21) {
			if (BuyPotion(1, 10)) {
				Items.ShowItem(0, true, 0, 7);
				DoEvent(9700);
			} else ShowShopContents();
			return;
		}
		if (itemno == 24)
		{
			if (BuyItem(1, XMLData.GetXMLValue("DildoPrice", "Equipment"))) {
				coreGame.DildoOK = 1; 
				Items.ShowItem(0, true, 0, 1);
				DoEvent(9700);
				XMLData.XMLGeneral("Equipment/DildoPurchased");
			} else ShowShopContents();
			return;
		}
		if (itemno == 25)
		{
			if (BuyItem(1, XMLData.GetXMLValue("AnalPlugPrice", "Equipment"))) {
				coreGame.PlugOK = 1;
				ServantSpeak("You may now try to order #slavehimher to wear the anal " + Plural("plug") + " for the day.");
				Items.ShowItem(0, 1, 1, 6);
				DoEvent(9700);
			} else ShowShopContents();
			return;
		} 
		if (itemno == 26)
		{
			if (BuyItem(1, XMLData.GetXMLValue("BondageGearPrice", "Equipment"))) {
				coreGame.RopesOK = 1;
				SMData.RopesOK = 1;
				XMLData.XMLGeneral("Equipment/BondageGearPurchased");
			} 
			ShowShopContents();
			return;
		}
		if (itemno == 41)
		{
			if (BuyItem(1, 800, true)) {
				SMData.OtherBooks.SetBitFlag(0);
				Items.ShowItem(0, true, 0, 2);
				DoEvent(9700);
				XMLData.XMLGeneral("Equipment/LadiesGuidePurchased");
			} else ShowShopContents();
			return;
		}
		if (itemno == 42)
		{
			if (BuyItem(1, undefined, true)) {
				SMData.OtherBooks.SetBitFlag(1);
				Items.ShowItem(0, true, 0, 2);
				DoEvent(9700);
				XMLData.XMLGeneral("Equipment/HistoricalTalesPurchased");
			} else ShowShopContents();
			return;
		}
		if (itemno == 43)
		{
			if (BuyItem(1, 100, true)) {
				if (!SMData.OtherBooks.CheckBitFlag(2)) SMData.OtherBooks.SetBitFlag(2);
				else SMData.OtherBooks.SetBitFlag(3);
				Items.ShowItem(0, true, 0, 2);
				DoEvent(9700);
				XMLData.XMLGeneral("Equipment/MasculineLove1Purchased");
			} else ShowShopContents();
			return;
		}
	}
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (key == 38) {
			nCurrentPage--;
			if (nCurrentPage < 1) nCurrentPage = 4;
			UpdatePurchasePage();
			return true;
		} else if (key == 40) {
			nCurrentPage++;
			if (nCurrentPage > 4) nCurrentPage = 1;
			UpdatePurchasePage();
			return true;
		}
		
		switch(keya) {
			case 65: PurchaseAphrodisiac(false); return true;
			case 66: PurchaseBook(false); return true;
			case 68: PurchaseLustDraft(false); return true;
			case 69: PurchaseEnergyDrink(false); return true;
			case 71: 
				if (coreGame.BDSMOn && SMData.RopesOK == 0) PurchaseBondageGear(false);
				return true;
			case 72:
				if (!SMData.OtherBooks.CheckBitFlag(1)) PurchaseHistoricalTales(false);
				return true;
			case 73: 
				if (coreGame.DildoOK == 0 && coreGame.ImprovedDildoOK == 0) PurchaseDildo(false);
				return true;
			case 74: PurchaseJewelry(false); return true;
			case 76: 
				if (!SMData.OtherBooks.CheckBitFlag(0)) PurchaseLadiesGuide(false);
				return true;
			case 77: 
				if (coreGame.sGayTrainer == 0) {
					if (!SMData.OtherBooks.CheckBitFlag(2)) PurchaseMasculineLove(false);
				} else if (coreGame.sGayTrainer > 1 && coreGame.sGayTrainer < 2 && SMData.OtherBooks.CheckBitFlag(2)) {
					if (!SMData.OtherBooks.CheckBitFlag(3)) PurchaseMasculineLove(false);
				}
				return true;				
			case 78: 
				if (coreGame.PlugOK == 0) PurchasePlug(false); 
				return true;
			case 80: PurchasePoetryBook(false); return true;
			case 83: PurchaseSoothingDraft(false); return true;
			case 84: PurchaseDoll(false); return true;
			case 85: PurchaseUninhibitory(false); return true;
			case 43:
			case 61: 
				if (mcBase.BtnPlus._visible) mcBase.BtnPlus.onPress();
				return true;
			case 45:
				if (mcBase.BtnMinus._visible) mcBase.BtnMinus.onPress();
				return true;
		}
		return false;
	}
	
	public function BuyUninhibitoryDrug(itemno:Number)
	{
		coreGame.GetSlaveInformation(-50);
		if (coreGame.ObjectChoice == 1) {
			if (BuyPotion(1, 1)) {
				if (coreGame.PotionsUsed[1] >= 2) {
					if (coreGame.BitFlag1.CheckBitFlag(47)) {
						PersonSpeak(1, "Due to what happened that last time #slave tried the variant, just try the normal version, but it is unlikely to work."); 
						BlankLine();
					} else {
						SetText("As he is about to hand you the potion, he pauses,\r\r");
						PersonSpeak(1, "As #slave is a bit accustomed to this potion now, there is a slightly different version #slaveheshe can try. It has the same effects as the usual but can have another effect, but this depends greatly on the taker so it is a bit unpredictable. There is an additional cost of 100GP and I will take a promisory note if you cannot afford it now.", true);
						AddText("\r\rDo you want to use the variant?\r");
						DoYesNoEvent(22);
						return;
					}
				}
				coreGame.ObjectChoice = 1.1;
			} else return;
		}
		if (coreGame.ObjectChoice > 1 && coreGame.ObjectChoice < 2) {
			if (coreGame.PotionsUsed[1] > 2) {
				AddText(Language.GetHtml("UninhibitoryPotionOverdose", "Potions"));
				BlankLine();
				if (coreGame.ObjectChoice > 1.1) {
					coreGame.BitFlag1.SetBitFlag(47);
					coreGame.AppendActText = true;
					mcBase._visible = false;
					HideEquipmentButton();
					coreGame.HidePeople();
					coreGame.UseGeneric = false;
					if (coreGame.SlaveGirl.ShowGigaBE() != true) {
						if (!coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(10012);
						else coreGame.UseGeneric = true;
						if (coreGame.UseGeneric) coreGame.Generic.ShowGigaBE();
					}
					if (coreGame.AppendActText) {
						if (coreGame.SlaveFemale) {
							SetText("#slave screams as #slavehisher breasts expand and rip #slavehisher clothing. They grow, and grow to enormous sizes, 3 or even 4 times larger than normal. Milk spurts from #slavehisher nipples for a few moments and then #slaveheshe screams again, this time in orgasm.\r\r#slave tries to move #slavehisher gigantic breasts and #slaveheshe groans in arousal and moments later cums again. Some time passes and #slavehisher breasts stay the same size and remain extremely sensitive.");
							if (coreGame.BadEndsOn) {
								AddText("\r\rRinno quickly does a test using a small alchemical reagent and sighs, and looks at #super,\r\r");
								PersonSpeak(1, "This was your choice, to use this potion, even the standard one has odd effects when used too often. I have no clue to what has happened here. She will need to be examined by an expert. But, remember this potion has a dubious origin. I doubt there is a cure, I am sorry.", true);
								AddText("\r\r#slave and #super return home and some time passes as #slave is checked and examined. Her breasts do shrink a little, but only slightly, and they remain impossibly sensitive.\r\rYou arrange a meeting with her owner, who is very, very disappointed, to the extent they cancel your contract and take #slave back into their possession.\r\rTime passes but you never hear anything more about #slave, and eventually decide it is best to start training a new slave.");
								AddText("\r\rDuring this time, unknown to you #slave's owner makes an arrangement with the people who make the Uninhibitory Potion and they take possession of #slave....");
								DoEvent(9820);
							} else {
								coreGame.ChangeBustSize(1.1);
								AddText("\r\rRinno quickly does a test using a small alchemical reagent and sighs, and looks at #super,\r\r");
								PersonSpeak(1, "This was your choice, to use this potion, even the standard one has odd effects when used too often. I think it is alright, she will recover from this", true);
								AddText("\r\rSome time passes and #slave's breasts steadily decrease in size until they stop at a size a bit larger than before. #slave's extreme sensitivity slowly returns to normal.");
								DoEvent(9700);
							}
						} else {
							// Male version
							coreGame.ChangeClitCockSize(1.1);
							SetText("#slave screams as #slavehisher cock grows and rips though #slavehisher clothing. It grows to an enoumouse size, 5 or even 10 times larger than normal. #slave screams as huge spurt of cum erupt from #slavehisher cock.\r\r#slave tries to move #slavehisher gigantic cock and #slaveheshe groans in arousal and moments later cums again. Some time passes and #slavehisher cock stays the same size and remains extremely sensitive.");
							AddText("\r\rRinno quickly does a test using a small alchemical reagent and sighs, and looks at #super,\r\r");
							PersonSpeak(1, "This was your choice, to use this potion, even the standard one has odd effects when used too often. I think it is alright, #slaveheshe will recover from this", true);
							AddText("\r\rSome time passes and #slave's cock steadily decreases in size until it stops at a size a bit larger than before. #slave's extreme sensitivity slowly returns to normal.");
							DoEvent(9700);
						}
					}
					return;
				} else {
					Items.ShowItem(0, true, 0, 9);
					DoEvent(9700);
				}
			} else {
		
				if (coreGame.ObjectChoice > 1.1) Money(-100);
				if (!Potions.DrinkPotion(1, PurchasePrice(Potions.GetPotionPrice(1)), "reluctantly drinks the brew.")) AddText(" " + coreGame.SlaveHeSheUC + " comments that it tastes nice and felt a hot flush. After #slaveheshe seems much more focused on #slavehisher training.");
				if (coreGame.NumEvent != 0) return;
				
				if (coreGame.ObjectChoice > 1.1) {
					AddText("\r\r#slave flushes brightly and ");
					if (coreGame.ObjectChoice > 1.2) temp = Math.round(10 * (coreGame.ObjectChoice - 1.2));
					else {
						if (!coreGame.SlaveFemale) temp = slrandom(2) + 1;
						else temp = slrandom(3);
						if (SMData.SMSpecialEvent == 7 || SMData.SMSpecialEvent == 8) temp = 3;
					}
					if (coreGame.BitFlag1.CheckBitFlag(46) && temp == 3) temp = 2;
					coreGame.ObjectChoice = 1.2 + (temp / 10);
					switch(temp) {
						case 1:
							AddText("feels a tightness in her chest. Her breasts swell a little and feel much more sensitive.");
							coreGame.ChangeBustSize(1.05);
							Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 3, 0, 0, 1, 0, 0);
							break;
						case 2:
							AddText("feels a rush of heat in #slavehisher groin and #slaveheshe ");
							if (!coreGame.Naked) AddText("and removes #slavehisher lower clothing. #slave ");
							AddText("sees #slavehisher ");
							if (coreGame.HasCock) AddText("cock");
							else AddText("clit");
							AddText(" swells and grows. Immediately #slave feels very, very aroused, but then faints.\r\rAfter a while #slave recovers but the growth appears permanent!");
							coreGame.ChangeClitCockSize(1.2);
							coreGame.MinLibido++;
							Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 5, 0, 0, 0, 0, 0);
							break;
						case 3:
							AddText("there is a flash of heat flooding the room. There are errie lights like flickering flames.\r\rSuddenly the light return to normal and #slave now has a tail, a cute but clearly demonic tail. #slave does not appear to notice until #super tug on it. #slave moans a little, but it is clear the tail is part of #slavehisher flesh, not just some sort of plug!!\r\r#slaveis not otherwise affected but #slaveheshe is very clearly aroused.");
							AddText("\r\r#slave wonders if there is also a way to get wings? Maybe a person could be found?\r");
							coreGame.BitFlag1.SetBitFlag(46);
							coreGame.MinLibido += 5;
							Diary.AddEntry("#slave has a demon tail!");
							Points(0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 10, 0, 10, 0, 0, 0, 0, 0);
							break;
					}
				}
				Items.ShowItem(0, true, 0, 9);
				DoEvent(9700);
				
			}
		}
		coreGame.UpdateSlave();
		coreGame.SlaveGirl.AfterTailorYes(coreGame.ObjectChoice < 0);
		coreGame.CurrentAssistant.AfterTailorYesAsAssistant(coreGame.ObjectChoice < 0);
	}

}