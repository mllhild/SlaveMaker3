// Armoury Shop
// Translation status: COMPLETE

import Scripts.Classes.*;

class ShopArmoury extends Shop {

	private var bWeaponPage:Boolean;		// true if showing weapons
	
	// constructor
	public function ShopArmoury(mc:MovieClip, cg:Object, cc:Object)
	{ 
		super(mc, cg, "Shopping/Shops/Armoury", cc);
		
		bWeaponPage = true;
		InitialiseModule();
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();
		mcNextButton = mcBase.NextButton;
		mcPreviousButton = mcBase.PreviousButton;
	}
	
	// Visit the shop
	public function VisitShop()
	{
		strShopKeeper = coreGame.People.GetPersonsName(21);
		
		super.VisitShop();
		
		coreGame.PersonIndex = -100;
		coreGame.SlaveGirl.DoArmourer();
		XMLData.XMLEvent("ShoppingArmoury", false);
		
		var ti:ShopArmoury = this;
		mcBase.WeaponArmourBtn.Btn.onPress = function() { ti.SwapType(); }
		mcBase.WeaponArmourBtn._visible = true;
		mcBase.WeaponArmourBtn.Btn.onRollOut = HideHints;
		mcBase.WeaponArmourBtn.Btn.onRollOver = function()
		{
			if (ti.IsHints()) ti.ShowHint(ti.Language.GetHtml("ShowArmourWeaponHint", ti.xNode));
		}
	
		CopyTF(mcBase.SMEquipmentButton.Label, coreGame.SMEquipmentButton.LText);
		mcBase.SMEquipmentButton._visible = true;
		mcBase.SMEquipmentButton.tabChildren = true;
		mcBase.SMEquipmentButton.Btn.onPress = function() {
			ti.coreGame.SelectSMEquipment.ViewDialog();
		}
		mcBase.SMEquipmentButton.Btn.onRollOut = coreGame.HideHints;
		mcBase.SMEquipmentButton.Btn.onRollOver = function()
		{
			if (ti.IsHints()) ti.ShowHint(ti.Language.GetHtml("YourGearHint", "Equipment"));
		}		
	}
	
	public function SwapType()
	{
		nCurrentPage = 1;
		bWeaponPage = !bWeaponPage;
		coreGame.HideImages();
		ShowShopContents();
	}
		
	public function ShowShopContents()
	{
		super.ShowShopContents();
		
		HideEquipmentButton();
		
		ShowPerson(21, 0, 1);
		Backgrounds.ShowAlcove();
		
		if (bWeaponPage) ShowWeaponContents();
		else ShowArmourContents();
	}
	
	private function ShowWeaponContents()
	{
		mcBase.WeaponArmourBtn.Label.htmlText = Language.GetHtml("ShowArmour", xNode);

		var maxthis:Number = SMData.GetTotalWeapons();
		
		mcBase.tabChildren = true;
		mcBase.Item1._visible = false;
		mcBase.Item2._visible = false;
		mcBase.Item3._visible = false;
		mcBase.Item4._visible = false;
		mcBase.Item5._visible = false;
		
		var wNode:XMLNode;
		var pos:Number = 0;
		var stpos:Number = 0;
		for (var i:Number = 0; i < maxthis; i++) {
			wNode = SMData.FindWeaponNodeCByNumber(i);
			var price:Number = SMData.GetWeaponPrice(i);
			if (price == 0) continue;
			price = PurchasePrice(price);
			stpos++;
			if (stpos < (((nCurrentPage - 1) * 5) + 1)) continue;
			if (stpos > (nCurrentPage * 5)) break;
			
			var img:String = XMLData.GetXMLStringParsed("Image", wNode);
			var nm:String = XMLData.GetXMLStringParsed("Name", wNode);

			var mcItem:MovieClip;
			switch(pos) {
				case 0: mcItem = mcBase.Item1; break;
				case 1: mcItem = mcBase.Item2; break;
				case 2: mcItem = mcBase.Item3; break;
				case 3: mcItem = mcBase.Item4; break;
				case 4: mcItem = mcBase.Item5; break;
			}
			mcItem._visible = true;
			mcItem.ItemImage.enabled = true;
			mcItem.tabChildren = true;
			
			var ti:ShopArmoury = this;
			mcItem.ShowRepos = function(mc:MovieClip) { ti.ShowWAReposition(mc); }
			SMData.LoadWeaponImage(wNode, 0, -99, 1, mcItem.ItemImage, 50 * pos, mcItem.ShowRepos);
				
			mcItem.Price.tabChildren = true;
			if (SMData.IsWeaponOwned(i)) {
				mcItem.Price.LText.htmlText = "<b>" + Language.GetHtml("Owned", "Shopping") + "</b>";
				coreGame.SetMovieColour(mcItem.ItemImage, -50, -50, -50);
			} else {
				mcItem.Price.LText.htmlText = price + coreGame.GP;
				coreGame.SetMovieColour(mcItem.ItemImage, 0, 0, 0);
			}
			mcItem.ItemLabel.htmlText = nm;
			mcItem.Shortcut.htmlText = String.fromCharCode(pos + 65);  
			
			mcItem.sNode = wNode;;
			mcItem.itemno = i;
	
			mcItem.ItemImage.onPress = function() { 
				if (!ti.SMData.IsWeaponOwned(this._parent.itemno)) ti.AskToPurchaseItem(this._parent.itemno, false);
			}
			mcItem.ItemImage.onRollOver = function() {
				if (!ti.SMData.IsWeaponOwned(this._parent.itemno)) {
					ti.coreGame.SetMovieColour(this, 50, 50, 50);
					if (ti.coreGame.YesEvent._visible == false && ti.IsHints()) ti.AskToPurchaseItem(this._parent.itemno, true);
				}
			}
			mcItem.ItemImage.onRollOut = function() { 
				if (!ti.SMData.IsWeaponOwned(this._parent.itemno)) {
					ti.HideHints(true);
					ti.coreGame.SetMovieColour(this, 0, 0, 0);
				};
			}

			pos++;
		}		
	}
	
	private function ShowWAReposition(mc:MovieClip)
	{
		var mratio:Number = mc._width / mc._height;
		var wr:Number = mc._width / 90;
		mc._visible = true;
		mc._xscale = 100;
		mc._yscale = 100;
		mc._width = 90;
		mc._height = mc._height / wr;
		if (mc._height > 223) {
			wr = mc._height / 223;
			mc._height = 223;
			mc._width = mc._width / wr;
		}
		if (mc._width < 90) mc._x = mc._x + ((90 - mc._width) / 2);
		mc._y = 223 - mc._height;
	}
	
	private function ShowArmourContents()
	{
		mcBase.WeaponArmourBtn.Label.htmlText = Language.GetHtml("ShowWeapons", xNode);
		
		var maxthis:Number = SMData.GetTotalArmours();
		trace("ShowArmourContents: " + maxthis);
		
		mcBase.tabChildren = true;
		mcBase.Item1._visible = false;
		mcBase.Item2._visible = false;
		mcBase.Item3._visible = false;
		mcBase.Item4._visible = false;
		mcBase.Item5._visible = false;
		
		var wNode:XMLNode;
		var pos:Number = 0;
		var stpos:Number = 0;
		for (var i:Number = 0; i < maxthis; i++) {
			wNode = SMData.FindArmourNodeCByNumber(i);
			var price:Number = SMData.GetArmourPrice(i);
			if (price == 0) continue;
			price = PurchasePrice(price);
						
			var nm:String = XMLData.GetXMLStringParsed("Name", wNode);
			
			stpos++;
			if (stpos < ((nCurrentPage - 1) * 5)) continue;
			if (stpos > (nCurrentPage * 5)) break;

			var mcItem:MovieClip;
			switch(pos) {
				case 0: mcItem = mcBase.Item1; break;
				case 1: mcItem = mcBase.Item2; break;
				case 2: mcItem = mcBase.Item3; break;
				case 3: mcItem = mcBase.Item4; break;
				case 4: mcItem = mcBase.Item5; break;
			}
			mcItem._visible = true;
			mcItem.ItemImage.enabled = true;
			mcItem.tabChildren = true;
			
			var ti:ShopArmoury = this;
			mcItem.ShowRepos = function(mc:MovieClip) { ti.ShowWAReposition(mc); }
			SMData.LoadArmourImage(wNode, 0, -99, 1, mcItem.ItemImage, 50 * pos, mcItem.ShowRepos);
				
			mcItem.Price.tabChildren = true;
			if (SMData.IsArmourOwned(i)) {
				mcItem.Price.LText.htmlText = "<b>" + Language.GetHtml("Owned", "Shopping") + "</b>";
				coreGame.SetMovieColour(mcItem.ItemImage, -50, -50, -50);
			} else {
				mcItem.Price.LText.htmlText = price + coreGame.GP;
				coreGame.SetMovieColour(mcItem.ItemImage, 0, 0, 0);
			}
			mcItem.ItemLabel.htmlText = nm;
			
			mcItem.sNode = wNode;;
			mcItem.itemno = i;
	
			mcItem.ItemImage.onPress = function() { 
				if (!ti.SMData.IsArmourOwned(this._parent.itemno)) ti.AskToPurchaseItem(this._parent.itemno, false);
			}
			mcItem.ItemImage.onRollOver = function() {
				if (!ti.SMData.IsArmourOwned(this._parent.itemno)) {
					ti.coreGame.SetMovieColour(this, 50, 50, 50);
					if (ti.coreGame.YesEvent._visible == false && ti.IsHints()) ti.AskToPurchaseItem(this._parent.itemno, true);
				}
			}
			mcItem.ItemImage.onRollOut = function() { 
				ti.HideHints(true); 
				if (!ti.SMData.IsArmourOwned(this._parent.itemno)) ti.coreGame.SetMovieColour(this, 0, 0, 0); 
			};

			pos++;
		}
	}
	
	public function GetItemsPerPage() : Number { return 5; }

	public function GetTotalPages() : Number
	{
		if (bWeaponPage) return Math.ceil(SMData.GetTotalWeapons(true) / 5);
		else return Math.ceil(SMData.GetTotalArmours(true) / 5);
	}

	public function SetNextPreviousButtons()
	{
		var aname:String = bWeaponPage ? Language.GetHtml("Weapons", "Equipment") : Language.GetHtml("Armour", "Equipment");
		super.SetNextPreviousButtons(aname);
	}
	
	function AskToPurchaseItem(itemno:Number, hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		
		var aNode:XMLNode;
		var price:Number;
		if (bWeaponPage) {
			aNode = SMData.FindWeaponNodeCByNumber(itemno);
			price = PurchasePrice(SMData.GetWeaponPrice(itemno));
		} else {
			aNode = SMData.FindArmourNodeCByNumber(itemno);
			price = PurchasePrice(SMData.GetArmourPrice(itemno));
		}
		
		PersonSpeak(21, Language.GetHtml("Description", aNode) + "\r"+ PurchasePrice(price) + coreGame.GP);
		PurchaseItem(itemno, hint);
	}
	
	public function BuyFromShop(itemno:Number)
	{
		mcBase._visible = false;
		coreGame.SlavePurchasePrevious._visible = false;
		coreGame.SlavePurchaseNext._visible = false;
	
		if (bWeaponPage) {
			// purchase a weapon
			coreGame.Quitter._visible = true;
			if (SMData.IsWeaponOwned(itemno)) {
				mcBase._visible = true;
				ServantSpeak(strReplace(Language.GetHtml("AlreadyOwnAGeneral", "Shopping"), "#value", SMData.GetWeaponName(itemno)));
			} else if (BuyItem(21, PurchasePrice(SMData.GetWeaponPrice(itemno)), true)) {
				coreGame.WeaponType = itemno;
				SMData.SetWeaponOwned(itemno);
				var iNode:XMLNode = SMData.FindWeaponNodeCByNumber(itemno);
				AddText(Language.GetHtml("PurchaseNote", iNode) + "\r\r");
				SMData.LoadWeaponImage(iNode, 1, 1);
				coreGame.DoEvent(9705);
			} else mcBase._visible = true;
			return;
		}
	
		// purchase armour	
		coreGame.Quitter._visible = true;
		if (SMData.IsArmourOwned(itemno)) {
			ServantSpeak(strReplace(Language.GetHtml("AlreadyOwnSomeGeneral", "Shopping"), "#value", SMData.GetArmourName(itemno)));
			mcBase._visible = true;
		} else if (BuyItem(21, PurchasePrice(SMData.GetArmourPrice(itemno)), true)) {
			coreGame.ArmourType = itemno;
			SMData.SetArmourOwned(itemno);
			var iNode:XMLNode = SMData.FindArmourNodeCByNumber(itemno);
			AddText(Language.GetHtml("PurchaseNote", iNode) + "\r\r");
			Backgrounds.ShowArmoury(2);
			SMData.LoadArmourImage(iNode, 1, 1, SMData.Gender == 1 ? 2 : 1);
			DoEvent(9705);
		}  else mcBase._visible = true;

	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (super.Shortcuts(keya, key)) return true;
		
		var itemno:Number = -1;
		switch(keya) {
			case 65: itemno = mcBase.Item1.itemno; break;
			case 66: itemno = mcBase.Item2.itemno; break;
			case 67: itemno = mcBase.Item3.itemno; break;
			case 68: itemno = mcBase.Item4.itemno; break;
			case 69: itemno = mcBase.Item5.itemno; break;
		}
		if (itemno != -1) {
			AskToPurchaseItem(itemno, false);
			return true;
		}
		return false;
	}
}