// Shop
// Translation status: COMPLETE

import Scripts.Classes.*;

class Shop extends DialogBase {

	public var bAccessible:Boolean;		// can the place be visited
	public var bInitialVisit:Boolean;	// first visit, can be turned away
	public var TotalVisit:Number;		// total times visited
	public var LastVisit:Number;		// last date visited
	public var LastVisitTime:Number;	// time last visited

	private var mcNextButton:MovieClip;
	private var mcPreviousButton:MovieClip;
	
	public var strNodeName:String;		// temporary value
	public var strShopKeeper:String;
	
	public var PurchaseQuantity:Number;
	
	private var Items:Object;		// reference
	private var Potions:Object;	// reference
	private var XMLData:Object;		// reference
	
	private var parentCity:Object;
	public var strArea:String;
	
	public function Shop(mc:MovieClip, cg:Object, nn:String, cc:Object)
	{ 
		super(mc, cg);
		
		bAccessible = true;
		PurchaseQuantity = 1;
		bInitialVisit = true;
		mcNextButton = null;
		mcPreviousButton = null;
		strNodeName = nn != undefined ? nn : "";
		strShopKeeper = "";
		strArea = "";
		parentCity = null;
		XMLData = coreGame.XMLData;
		Reset();
		
		if (cc == undefined) return;
		cc.arShops.push(this);
		parentCity = cc;
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();
		Items = coreGame.Items;
		Potions = coreGame.Potions;
		
		xNode = XMLData.GetNodeC(strNodeName);
	}
	
	public function Reset()
	{
		super.InitialiseModule();
		Items = coreGame.Items;
		bInitialVisit = true;
		TotalVisit = 0;
		LastVisit = 0;
		LastVisitTime = 0;		
	}
	
	// Main access
	
	public function FindShop() { VisitShop(); }
	
	public function VisitShop()
	{
		//trace("Shop.VisitShop");
		coreGame.ShowPlanningNext();
		coreGame.currentDialog = this;
		coreGame.currentShop = this;
		nCurrentPage = 1;
		TotalVisit++;
		LastVisit = coreGame.GameDate.
		LastVisitTime = coreGame.GameTimeMins;
		
		coreGame.PersonIndex = -50;
		SetSlave(SMData.GetSlaveByIndex(coreGame.PersonIndex));
		
		coreGame.mcMain.MainWindowButton._visible = false;
		coreGame.TakeAWalkMenu._visible = false;

		if (bInitialVisit) DoInitialVisit();
		else DoLaterVisit();
		
		if (mcNextButton != null) {
			mcNextButton.enabled = true;
			mcPreviousButton.enabled = true;
	
			var thisInstance:Shop = this;
			mcNextButton.onPress = function() { thisInstance.PressPurchaseNext(); }
			mcNextButton.Next.onPress = mcNextButton.onPress;
			mcPreviousButton.onPress = function() { thisInstance.PressPurchasePrevious(); }
			mcPreviousButton.Next.onPress = mcPreviousButton.onPress;
		}
		
		if (!IsEventAllowable()) {
			trace("shop event");
			return;
		}

		ShowShopContents();
		
		PlaySound("DoorBell");

		
		// mandatory for all implementations of Shop class to implement VisitShop
		//public function VisitShop()
		//{
		// super.VisitShop();
		//}
	}
	
	public function ShowShopContents()
	{
		super.ShowDialogContents();
		coreGame.currentShop = this;
		
		PurchaseQuantity = 1;
		coreGame.OtherSlaveShown = coreGame.PersonIndex != -50;
		
		coreGame.dspMain.SelectTab(5);
		coreGame.dspMain.ShowGameTabs();
						
		coreGame.ShowLeaveButton();
		
		if (mcNextButton != null) SetNextPreviousButtons();
	}
	
	public function LeaveShop(nonext:Boolean)
	{
		super.LeaveDialog();
		coreGame.currentShop = null;
		coreGame.OtherSlaveShown = false;
		ShowSupervisor();
		if (nonext == true) return;
		if (coreGame.Plannings.IsStarted()) coreGame.DoPlanningNext();
		else coreGame.dspMain.ShowMainButtons();
	}
	
	public function LeaveDialog() { LeaveShop(); }
	
	
	// Load/Save
	
	public function Load(lo:Object)
	{
		super.Load(lo);
		
		if (lo.InitialVisit == undefined) return;		// bad save/upgrading
		bAccessible = lo.bAccessible;
		if (bAccessible == undefined) bAccessible = true;
		bInitialVisit = lo.InitialVisit;
		LastVisit = lo.LastVisit;
		LastVisitTime = lo.LastVisitTime;
		TotalVisit = lo.TotalVisit;
		if (lo.strArea == undefined) strArea = "";
		else strArea = lo.strArea + "";
	}
	
	public function Save(so:Object)
	{
		super.Save(so);
		
		so.bAccessible = bAccessible;
		so.strNodeName = strNodeName + "";
		so.InitialVisit = bInitialVisit;
		so.LastVisit = LastVisit;
		so.TotalVisit = TotalVisit;
		so.strArea = strArea + "";
	}
	
	
	// Accessibility
	
	public function IsAccessible() : Boolean { return bAccessible; }
	public function SetAccessible(seta:Boolean) { bAccessible = seta == undefined ? true : seta; }

		
	// Visiting
	
	public function DoInitialVisit()
	{
		coreGame.EventTotal = TotalVisit;
		bInitialVisit = false;
		XMLData.XMLGeneral("InitialVisit", false, xNode);
	}
	
	public function DoLaterVisit()
	{
		coreGame.genNumber = LastVisit;
		XMLData.XMLGeneral("LaterVisits", false, xNode);
		BlankLine();
	}

	// Buttons
	
	public function SetNextPreviousButtons(caption:String)
	{
		if (mcNextButton == null) return;
		if (caption == undefined) caption = Language.GetHtml("NextButtonLabel", xNode);
		mcPreviousButton._visible = true;
		mcNextButton._visible = true;
		
		if (nCurrentPage == nTotPages && nCurrentPage != 1) {
			mcNextButton.Area.text = caption + " 1";
			mcPreviousButton.Area.text = caption + " " + (nCurrentPage - 1);
		} else if (nCurrentPage == nTotPages && nCurrentPage == 1) {
			mcPreviousButton._visible = false;
			mcNextButton._visible = false;
		} else if (nCurrentPage == 1) {
			mcNextButton.Area.text = caption + " 2";
			mcPreviousButton.Area.text = caption + " " + nTotPages;
		} else {
			mcNextButton.Area.text = caption + " " + (nCurrentPage + 1);
			mcPreviousButton.Area.text = caption + " " + (nCurrentPage - 1);
		}
		if (nTotPages == 2) mcPreviousButton._visible = false;

	}
	
	public function PressPurchaseNext()
	{
		SetGeneralText("");
		coreGame.HideYesNoButtons();
		coreGame.HideImages();
		coreGame.Quitter._x = 824;
	
		if (nCurrentPage == nTotPages && nCurrentPage != 1) nCurrentPage = 1;
		else if (nTotPages != 1) nCurrentPage++;
		
		ShowShopContents();
		
		PlaySound("Sounds/Footsteps.mp3");
	}
	
	public function PressPurchasePrevious()
	{
		SetGeneralText("");
		coreGame.HideYesNoButtons();
		coreGame.HideImages();
		coreGame.Quitter._x = 824;

		if (nTotPages > 1 && nCurrentPage == 1) nCurrentPage = nTotPages;
		else if (nCurrentPage > 1) nCurrentPage--;
		
		ShowShopContents();
		
		PlaySound("Footsteps");
	}
	
	public function DoYesNoItem(item:Number)
	{
		coreGame.YesNoFlag = 0;
		coreGame.ShowYesNoButtons();
		coreGame.ObjectChoice = item;
	}

	
	// Items for sale
	public function GetItemsPerPage() : Number { return 1; }
	
	public function GetTotalItemsSold() : Number
	{ 
		var iCnt:Number = 0;
		if (xNode == null) return 0;
		for (var iNode:XMLNode = XMLData.GetNodeC(xNode, "Items"); iNode != null; iNode = iNode.nextSibling) {
			if (iNode.nodeType != 1) continue;
			if (iNode.nodeName.toLowerCase() == "item" || iNode.nodeName.toLowerCase() == "potion") iCnt++;
		}
		return iCnt;
	}

	public function GetTotalPages() : Number { return Math.ceil(GetTotalItemsSold() / GetItemsPerPage()); }
	
	public function GetItemName(item:Number) : String { return ""; }
	
	public function ShowItem(item:Number, place:Number, align:Number, gframe:Number) : Boolean { return false; }

	public function ShowItemDescription(item:Number) : Boolean { return false; }

	public function ShowOtherEquipment() { }
	
	public function ShowOtherSMEquipment() { }


	// Purchasing
	
	public function AskToPurchaseItem(itemno:Number, hint:Boolean) { }
	
	public function DoEventYes() : Boolean
	{
		if (coreGame.ObjectChoice == 0) return false;
		SetSlave(coreGame.sdata);
		var slave:Boolean = coreGame.PersonIndex == -50;
		if (slave) SetSlave(_root);
		else coreGame.UpdateSlaveCommon(sd);
		coreGame.GetPersonGenderText(coreGame.PersonIndex != -100 ? sd.GenderIdentity : SMData.GenderIdentity);
		
		if (isNaN(PurchaseQuantity)) PurchaseQuantity = 1;
	
		SetText("");
		Items.HideItems();
		coreGame.HideImages(coreGame.ObjectChoice > 4999 && coreGame.ObjectChoice < 6000);
		coreGame.HideStatChangeIcons();
		coreGame.genNumber = coreGame.ObjectChoice;
		
		if (coreGame.SlaveGirl.DoTailorYes(coreGame.ObjectChoice < 0) == true) return;
		if (coreGame.CurrentAssistant.DoTailorYesAsAssistant(coreGame.ObjectChoice < 0) == true) return;
		if (XMLData.XMLEvent("BuyFromShop", true)) return;
		
		BuyFromShop(coreGame.ObjectChoice); 
	
		coreGame.UpdateSlave();
		coreGame.SlaveGirl.AfterTailorYes(coreGame.ObjectChoice < 0);
		coreGame.CurrentAssistant.AfterTailorYesAsAssistant(coreGame.ObjectChoice < 0);
		XMLData.XMLEvent("AfterBuyFromShop", true);
		return true;
	}
	
	public function BuyFromShop(itemno:Number) { }
	
	public function ShowPurchaser(place:Number, defimg:String)
	{
		if (place == undefined) place = 0;
		if (coreGame.PersonIndex == -100) coreGame.SMAvatar.AutoShowSlaveMaker(place == 0 ? 1 : 0, place, 1, 0, defimg);
		else if (coreGame.PersonIndex == -50 && place != 0) coreGame.ShowDress();
		else coreGame.ShowSlave(sd, place, 9);
	}
	
	public function PurchasePrice(price:Number) : Number
	{
		if (isNaN(price) || price == 0) return 0;
		var slave:Boolean = coreGame.PersonIndex == -50;
		if (slave) sd = _root;
		if (isNaN(PurchaseQuantity)) PurchaseQuantity = 1;
		
		var factor:Number = 25;
		if (price <= 100) factor = 10;
		var newprice:Number = price;
		if (newprice > 0) {
			newprice += (coreGame.Difficulty * factor);
			var efftrader:Number = SMData.sTrader;
			if (coreGame.AssistantData.sTrader > efftrader) efftrader = coreGame.AssistantData.sTrader;
			if (efftrader > 0) newprice = Math.floor(newprice * (1 - (efftrader * 0.05)));
		} else newprice -= (coreGame.Difficulty * factor);
		if (coreGame.PersonIndex != -100 && sd.SlaveGender > 3) newprice *= 2;
		var pp:Number = Math.floor(newprice) * PurchaseQuantity;
		return pp;
	}
		
	public function BuyItem(person:Object, cost:Number, smgold:Boolean) : Boolean
	{
		if (SMData.GuildMember && smgold == true) {
			if (SMData.SMGold >= PurchasePrice(cost)) {
				SMMoney(PurchasePrice(cost) * -1);
				coreGame.ObjectChoice = 0;
				return true;
			}
		} else {
			if ((coreGame.VarGold + SMData.SMGold) >= PurchasePrice(cost)) {
				Money(PurchasePrice(cost) * -1);
				coreGame.ObjectChoice = 0;
				return true;
			}
		}
			
		PersonSpeak(person, Language.GetHtml("NotEnoughMoney", "Shopping"));
		Bloop();
		return false;
	}
	
	public function PurchaseItem(item:Number, hint:Boolean)
	{
		coreGame.HideLargerText();
		coreGame.HideQuestions();
		if (hint == undefined) hint = false;
		if (coreGame.SlaveGirl.PurchaseItem(item, hint) == true) return;
		if (coreGame.CurrentAssistant.PurchaseItemAsAssistant(item, hint) == true) return;
		if (hint == true || coreGame.YesEvent._visible) return;
		Beep();
		BlankLine();
		if (item > 4999) AddGeneralText(Language.GetHtml("DoYouSlave", "Shopping"));
		else AddGeneralText(Language.GetHtml("DoYouItem", "Shopping"));
		DoYesNoItem(item);
	}
	
	public function BuyPotion(person:Object, potion:Number, cost:Number, smgold:Boolean) : Boolean
	{
		coreGame.PurchaseQuantity = PurchaseQuantity;
		cost = PotionPrice(cost, potion);
		var ncost:Number = coreGame.SlaveGirl.BuyPotion(person, potion, cost, smgold);
		if (ncost == undefined) ncost = cost;
		if (ncost == -1) return false;
		ncost = coreGame.CurrentAssistant.BuyPotion(person, potion, cost, smgold);
		if (ncost == undefined) ncost = cost;
		if (ncost == -1) return false;
		
		if (SMData.GuildMember && smgold == true) {
			if (SMData.SMGold >= ncost) {
				SMMoney(ncost * -1);
				BoughtPotion(potion);
				return true;
			}
		} else {
			if ((coreGame.VarGold + SMData.SMGold) >= ncost) {
				Money(ncost * -1);
				BoughtPotion(potion);
				return true;
			}
		}
			
		PersonSpeak(person, Language.GetHtml("NotEnoughMoney", "Shopping"));
		Bloop();
		return false;
	}
	
	private function BoughtPotion(potion:Number)
	{
		if (int(potion) == 1) return;
		SetText(strReplace(Language.GetHtml(PurchaseQuantity > 1 ? "BoughtPotions" : "BoughtPotion", "Potions"), "#value", Potions.GetPotionName(potion)));
		SMData.ChangePotionOwned(potion, PurchaseQuantity * (sd.SlaveGender > 3 ? 2 : 1));
	}
	
	public function PotionPrice(price:Number, idx:Number) : Number
	{
		if (price == undefined || price == 0) {
			if (idx == undefined) return 0;
			price = Potions.GetPotionPrice(idx);
		}
		var effalchemy:Number = SMData.sAlchemy;
		if (coreGame.AssistantData.sAlchemy > effalchemy) effalchemy = coreGame.AssistantData.sAlchemy;
		if (effalchemy > 0) price = Math.floor(price * (1 - (effalchemy * 0.2)));
	
		return PurchasePrice(price);
	}
	
	
	// Pick customer
	
	public function CustomerPicked()
	{
		SetText("");
		SetSlave(SMData.GetSlaveByIndex(coreGame.PersonIndex));
		ShowShopContents();
	}
	
	public function EnableChooseCustomer(mc:MovieClip)
	{
		mc._visible = true;
		mc.tabChildren = true;

		var ti:Shop = this;
		
		mc.Btn.onPress = function() {
			ti.mcBase._visible = false;
			ti.coreGame.Quitter._visible = false;
			ti.HideEquipmentButton();
			function PickCallback() { ti.CustomerPicked();	}
			function SlaveFilter(idx:Number) {
				if (idx < 0) return true;
				var sgirl:Slave = ti.SMData.SlavesArray[idx];
				if (sgirl.SlaveType == -20 || sgirl.SlaveType == -1) return false;
				return true;
			}
			ti.coreGame.PickASlave(ti.Language.GetHtml("WhoWillBeServed", "Shopping"), true, SlaveFilter, PickCallback);
		}
	}
	
	
	public function IsThisShop(str:String) : Boolean
	{
		str = str.split(" ").join("").toLowerCase();
		var ar:Array = str.split("/");
		str = ar[ar.length - 1];
		ar = strNodeName.split(" ").join("").toLowerCase().split("/");
		return (ar[ar.length - 1] == str);
	}


	// Miscelleanous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (key == 37 && nCurrentPage > 1) {
			PressPurchasePrevious();
			return true;
		} else if (key == 39 && nCurrentPage < nTotPages) {
			PressPurchaseNext();
			return true;
		}
		return false;
	}

}