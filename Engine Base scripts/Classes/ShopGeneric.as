// Generic Shop
// Translation status: COMPLETE

import Scripts.Classes.*;

class ShopGeneric extends Shop {
		
	// constructor
	public function ShopGeneric(cg:Object, nn:String, cc:Object, shopkeeper:String)
	{ 
		super(cg.mcGenericShop, cg, nn, cc);
		
		strShopKeeper = shopkeeper;
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
		trace("ShopGeneric.VisitShop");
					
		var ti:ShopGeneric = this;

		for (var i:Number = 1; i <= GetItemsPerPage(); i++) {

			mcBase["Item" + i]._visible = false;
			mcBase["Item" + i].ActButton.onPress = function() {
				ti.AskToPurchaseItem(this._parent.curract, false);
			}
			mcBase["Item" + i].ActButton.onRollOver = function() {
				ti.AskToPurchaseItem(this._parent.curract, true);
			}		
		}
		mcBase.TitleText.htmlText = Language.GetHtml("Title", xNode, true);
		
		super.VisitShop();
	}
		
	public function ShowShopContents()
	{
		super.ShowShopContents();
		
		ShowEquipmentButton(12);
		coreGame.HideImages();
		Backgrounds.ShowAlcove(2);
		ShowPerson(strShopKeeper, 0, 1);
		
		var iTotal:Number = GetTotalItemsSold();
		var iPos:Number = (GetCurrentPage() - 1) * GetItemsPerPage();
		var ti:ShopGeneric = this;
		
		// reset buttons
		for (var i:Number = 1; i <= GetItemsPerPage(); i++) mcBase["Item" + i]._visible = false;
		
		// now show the current set
		for (var i:Number = 1; i <= GetItemsPerPage(); i++) {
			if (iPos > iTotal) break;
			var iNode:XMLNode = Items.FindItemNodeCByIndex(iPos, xNode, "Item/Potion");
			if (iNode == null) {
				iPos++;
				continue;
			}
			
			// show this item
			var potion:Boolean = iNode.parentNode.nodeName.toLowerCase() == "potion";
			var nm:String = XMLData.GetXMLStringParsed("Name", iNode);
			var id:Number = Number(iNode.parentNode.attributes.id);
			if (potion) {
				if (isNaN(id)) id = Potions.GetPotionNumber(iNode.parentNode.attributes.name);
				if (isNaN(id) && nm != "") id = Potions.GetPotionNumber(nm);
				if (!isNaN(id)) nm = Potions.GetPotionName(id);
			}
			if (!isNaN(id)) {
				var btn:MovieClip = mcBase["Item" + i];
				btn._visible = true;
				var sdo:Slave = SMData.GetSlaveObject(sd);
				SetButtonDetails(btn, sdo.ItemsOwned.CheckBitFlag(id), true, nm, id, "" + (i + 1));
				
				btn.ShowRepos = function(mc:MovieClip) { ti.ShowItemReposition(mc); }
				Items.LoadItemImage(iNode, 0, -99, 1, btn.ItemImage, 0, btn.ShowRepos, xNode);
			}
			iPos++;

		}
	}
	
	private function ShowItemReposition(mc:MovieClip)
	{
		var mratio:Number = mc._width / mc._height;
		var wr:Number = mc._width / 90;
		mc._visible = true;
		mc._xscale = 100;
		mc._yscale = 100;
		mc._width = 120;
		mc._height = mc._height / wr;
		if (mc._height > 70) {
			wr = mc._height / 70;
			mc._height = 70;
			mc._width = mc._width / wr;
		}
		if (mc._width < 120) mc._x = mc._x + ((120 - mc._width) / 2);
		mc._y = 70 - mc._height;
	}

	
	// The Items
	public function GetItemsPerPage() : Number { return 8; }
	
	public function GetItemName(item:Number) : String
	{
		var iNode:XMLNode = Items.FindItemNodeCById(item, xNode, "Item/Potion");
		if (iNode == null) return "";
		return XMLData.GetXMLStringParsed("Name", iNode);
	}
	
	public function ShowItem(item:Number, place:Number, align:Number, gframe:Number) : Boolean
	{
		var iNode:XMLNode = Items.FindItemNodeCById(item, xNode, "Item/Potion");
		if (iNode.parentNode.nodeName.toLowerCase() == "potion") iNode = Items.FindItemNodeCById(item, XMLData.GetNodeC("Potions"), "PotionDetail");

		var str:String = XMLData.GetXMLStringParsed("Image", iNode);
		if (str == "") return false;
		AutoLoadImageAndShowMovie(str, place, align);
		return true;
	}
	
	public function ShowItemDescription(item:Number) : Boolean
	{ 
		var iNode:XMLNode = Items.FindItemNodeCById(item, xNode, "Item/Potion");
		if (iNode.parentNode.nodeName.toLowerCase() == "potion") iNode = Items.FindItemNodeCById(item, XMLData.GetNodeC("Potions"), "PotionDetail");
		
		var str:String = XMLData.GetXMLStringParsed("Description", iNode);
		if (str != "") {
			SetGeneralText(str);
			return true;
		}
		return false;
	}
	
	public function ShowOtherEquipment()
	{
		var iTotal:Number = GetTotalItemsSold();
		var iNode:XMLNode;
		var sdo:Slave = SMData.GetSlaveObject(sd);
		
		for (var i:Number = 1; i <= iTotal; i++) {
			iNode = Items.FindItemNodeCByIndex(i - 1, xNode, "Item/Potion");
			if (iNode == null) continue;
			
			var id:Number = Number(iNode.parentNode.attributes.id);
			var sm:Boolean = iNode.parentNode.attributes.slavemaker.toLowerCase() == "true";
			if (sm || isNaN(id)) continue;
			if (iNode.parentNode.nodeName.toLowerCase() == "item") {
				if (sdo.IsItemAvailable(id)) AddText("  " + XMLData.GetXMLStringParsed("Name", iNode) + "\r\r");
			}
		}
	}
	
	public function ShowOtherSMEquipment()
	{
		var iTotal:Number = GetTotalItemsSold();
		var iNode:XMLNode;
		
		for (var i:Number = 1; i <= iTotal; i++) {
			iNode = Items.FindItemNodeCByIndex(i - 1, xNode, "Item/Potion");
			if (iNode == null) continue;
			
			var id:Number = Number(iNode.parentNode.attributes.id);
			var sm:Boolean = iNode.parentNode.attributes.slavemaker.toLowerCase() == "true";
			if (isNaN(id) || !sm) continue;
			if (iNode.parentNode.nodeName.toLowerCase() == "item") {
				if (SMData.IsItemAvailable(id)) AddText("  " + XMLData.GetXMLStringParsed("Name", iNode) + "\r\r");
			}
		}
	}	
	
	
	// Purchasing 
	
	function AskToPurchaseItem(itemno:Number, hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		
		var aNode:XMLNode = Items.FindItemNodeCById(itemno, xNode, "Item/Potion");
		if (aNode.parentNode.nodeName.toLowerCase() == "potion") aNode = Items.FindItemNodeCById(itemno, XMLData.GetNodeC("Potions"), "PotionDetail");
		
		PersonSpeak(strShopKeeper, Language.GetHtml("Description", aNode) + "\r"+ PurchasePrice(XMLData.GetXMLValue("Price", aNode)) + coreGame.GP);
		PurchaseItem(itemno, hint);
	}
	
	function BuyFromShop(itemno:Number)
	{
		mcBase._visible = false;
		coreGame.SlavePurchasePrevious._visible = false;
		coreGame.SlavePurchaseNext._visible = false;

		var aNode:XMLNode = Items.FindItemNodeCById(itemno, xNode, "Item/Potion");
		var potion:Boolean = aNode.parentNode.nodeName.toLowerCase() == "potion";		
		if (potion) {
			var price:Number = XMLData.GetXMLValue("Price", aNode);
			aNode = Items.FindItemNodeCById(itemno, XMLData.GetNodeC("Potions"), "PotionDetail");
			if (price == 0) price = XMLData.GetXMLValue("Price", aNode);
			if (BuyPotion(strShopKeeper, itemno, price)) {
				DoEvent(9700);
				SetGeneralText(Language.GetHtmlDef("PurchaseComment", aNode, Language.GetHtml("PurchaseComment", xNode)) + "\r\r");
			}
		} else {
			var price:Number = PurchasePrice(XMLData.GetXMLValue("Price", aNode));
			
			if (BuyItem(strShopKeeper, price)) {
				Items.ShowItem(itemno, true, 2);
				var sdo:Object = SMData.GetSlaveObject(sd);
				if (coreGame.PersonIndex == -50) coreGame.Items.SetItemOwned(itemno);
				else sdo.SetItemOwned(itemno);
				var effNode:XMLNode = XMLData.GetNode(aNode, "Effect");
				if (effNode != null) {
					if (effNode.attributes.onpurchase.toLowerCase() != "true") XMLData.XMLEventByNode(effNode, false, undefined, true); 
				}
				DoEvent(9700);
				SetGeneralText(Language.GetHtmlDef("PurchaseComment", aNode, Language.GetHtml("PurchaseComment", xNode)) + "\r\r");
			}
		}
	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (super.Shortcuts(keya, key)) return true;
		
		var itemno:Number = -1;
		switch(keya) {
			case 65: itemno = mcBase.Item1.curract; return true;
			case 66: itemno = mcBase.Item2.curract; return true;
			case 67: itemno = mcBase.Item3.curract; return true;
			case 68: itemno = mcBase.Item4.curract; return true;
			case 69: itemno = mcBase.Item5.curract; return true;
			case 70: itemno = mcBase.Item6.curract; return true;
			case 71: itemno = mcBase.Item7.curract; return true;
			case 72: itemno = mcBase.Item8.curract; return true;
		}
		if (itemno != -1) {
			AskToPurchaseItem(itemno, false);
			return true;
		}

		return false;
	}
}