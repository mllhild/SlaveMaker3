// DialogEquipmentSlaveMaker - SM Equipment Menu
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogEquipmentSlaveMaker extends DialogBase {
	
	private var weaponsShown:Number;
	private var cbobj:Object;
	
	// Constructor
	public function DialogEquipmentSlaveMaker(cg:Object)
	{ 
		super(cg.SMEquipmentMenu, cg);
		
		mcBase.Items.setStyle("borderStyle", "none");
		
		var ti:DialogEquipmentSlaveMaker = this;
		coreGame.SMEquipmentButton.tabChildren = true;
		coreGame.SMEquipmentButton.Btn.onPress = function() { ti.ViewDialog(); }
		coreGame.SMEquipmentButton.Btn.onRollOut = coreGame.HideHints;
		coreGame.SMEquipmentButton.Btn.onRollOver = function() {
			if (ti.IsHints() && !ti.coreGame.YesEvent._visible) ti.ShowHint(ti.Language.GetHtml("YourGearHint", "Equipment"));
		}
		mcBase.WeaponsBtn.Btn.tabChildren = true;
		mcBase.ArmourBtn.Btn.tabChildren = true;
		mcBase.ClothingBtn.Btn.tabChildren = true;
		mcBase.WeaponsBtn.Btn.onPress = function() { ti.WeaponPress(); }
		mcBase.ArmourBtn.Btn.onPress = function() { ti.ArmourPress(); }
		mcBase.ClothingBtn.Btn.onPress = function() { ti.ClothingPress(); }
		
		cbobj = new Object();
		cbobj.LoaderA = function(mc:MovieClip) {
			ti.ShowCurrentPositionA(mc);
		}
		cbobj.LoaderW = function(mc:MovieClip) {
			ti.ShowCurrentPositionW(mc);
		}	
	}
	
	public function ShowSMEquipmentButton()	{ coreGame.SMEquipmentButton._visible = true; }
	public function HideSMEquipmentButton() { coreGame.SMEquipmentButton._visible = false; }
		
	public function ViewDialog()
	{
		coreGame.PersonIndex = -100;
		SetSlave(coreGame.slaveData);
		mcBase.LText.htmlText = Language.GetHtml("YourEquipment", "Equipment", true);
		mcBase.WeaponsBtn.Label.htmlText = Language.GetHtml("Weapons", "Equipment", true);
		mcBase.ArmourBtn.Label.htmlText = Language.GetHtml("Armour", "Equipment", true);
		mcBase.ClothingBtn.Label.htmlText = Language.GetHtml("Clothing", "Equipment", true);
		
		weaponsShown = -1;
		
		super.ViewDialog();
		mcBase.Items.visible = false;
		mcBase.Items.invalidate();

	}
	
	public function ShowDialogContents()
	{
		super.ShowDialogContents();
				
		Beep();
		coreGame.HideDresses();
		coreGame.HideMenus();
		coreGame.HidePeople();
		HideEquipmentButton();
		HideSMEquipmentButton();

		coreGame.ShowLeaveButton();
		
		SetText("");
		
		coreGame.SlavePurchasePrevious._visible = false;
		coreGame.SlavePurchaseNext._visible = false;

		ShowCurrentItems();
		Backgrounds.ShowSlaveMakerRoom();

		coreGame.HidePeopleAll();
		SMData.ShowSlaveMaker();
	}
	
	public function LeaveDialog()
	{
		super.LeaveDialog();
		coreGame.HideImages();
		coreGame.ClearGeneralArray2();
	}

	private function AddSMItem(sitem:Number, itemno:Number) : Number
	{
		var depth:Number = mcBase.Items.content.getNextHighestDepth();
		var image:MovieClip = mcBase.Items.content.attachMovie("Item Selection", "SMItem" + itemno, depth);
		coreGame.arGeneralArray2.push(image);
		image._width = 200;
		image._height = 230;
		image._x = 0;
		image._y = sitem * 220;
		var itemmc:MovieClip;
		if (itemno == -1) {
			image.ItemLabel.htmlText = "<b>" + Language.GetHtml("Naked", Language.actNode) + "</b>";
			itemmc = SMData.ShowSlaveMaker(-13, 1, 1, 1, undefined, image.ItemImage);
			if (itemmc == undefined) itemmc = coreGame.AutoAttachAndShowMovie("Naked Slave Maker", 5, 1, SMData.Gender == 1 ? 2 : 1, image.ItemImage);
			if (SMData.DressWorn < 0) SetMovieColour(image, 0, 0, 150);
		} else if (itemno == 0) {
			if (weaponsShown == 1) image.ItemLabel.htmlText = "<b>" + SMData.GetWeaponName(itemno) + "</b>";
			else if (weaponsShown == 2) image.ItemLabel.htmlText = "<b>" + Language.GetHtml("NoArmour", "Equipment") + "</b>";
			else if (weaponsShown == 3) {
				image.ItemLabel.htmlText = "<b>" + SMData.GetDressName(itemno) + "</b>";
				itemmc = SMData.ShowSlaveMaker(-20000, 5, 9, 0, "", image.ItemImage);
				if (SMData.DressWorn == itemno) SetMovieColour(image, 0, 0, 150);
			}
		} else {
			if (weaponsShown == 1) image.ItemLabel.htmlText = "<b>" + SMData.GetWeaponName(itemno) + "</b>";
			else if (weaponsShown == 2) image.ItemLabel.htmlText = "<b>" + SMData.GetArmourName(itemno) + "</b>";
			else if (weaponsShown == 3) {
				image.ItemLabel.htmlText = "<b>" + SMData.GetDressName(itemno) + "</b>";
				itemmc = SMData.ShowSlaveMaker(-20000 - itemno, 5, 9, 0, "", image.ItemImage);
				if (SMData.DressWorn == itemno) SetMovieColour(image, 0, 0, 150);
			}
		}
		if (weaponsShown == 1) {
			itemmc = SMData.LoadWeaponImage(itemno, 5, 9, 1, image.ItemImage);
			if (SMData.WeaponType == itemno) SetMovieColour(image, 0, 0, 150);
		} else if (weaponsShown == 2) {
			itemmc = SMData.LoadArmourImage(itemno, 5, 9, 1, image.ItemImage);
			if (SMData.ArmourType == itemno) SetMovieColour(image, 0, 0, 150);
		}
	
		var ti:DialogEquipmentSlaveMaker = this;
		image._visible = true;
		image.ItemButton.onRollOut = function() { HideHints(true); }
		image.ItemButton.onRollOver = function() {
			ti.SMItemHintRollOver(this);
		}
		image.ItemButton.onPress = function() {
			ti.SMEquipItem(this);
		}
		image.ItemNo = itemno;
		sitem++;
		return sitem;
	}
	
	public function SMItemHintRollOver(mc:MovieClip, item:Number, weap:Number)
	{
		if (weap == undefined) weap = weaponsShown;
		if (item == undefined) item = mc._parent.ItemNo
		if (item == 0 && weap == 1) coreGame.SetHintText("<b>" + Language.GetHtml("NoWeapon", "Equipment") + "</b>\r\r");
		else if (item == 0 && weap == 2) coreGame.SetHintText("<b>" + Language.GetHtml("NoArmour", "Equipment") + "</b>\r\r");
		else if (item < 0 && weap == 3) coreGame.SetHintText("<b>" + Language.GetHtml("Naked", Language.actNode) + "</b>\r\r");
		else if (weap == 1) {
			// Weapon hint
			var iNode:XMLNode = SMData.FindWeaponNodeCByNumber(item);
			coreGame.SetHintText("<b>" + SMData.GetWeaponName(item) + "</b>\r" + coreGame.SlaveMakerStatisticsGroup.Attack.StatLabel.text + " +" + Language.XMLData.GetXMLStringParsed("DamageBonus", iNode) + "\r" + Language.GetHtml("Speed", "Statistics") + ": " + Language.XMLData.GetXMLStringParsed("SpeedBonus", iNode));
		} else if (weap == 2) {
			var iNode:XMLNode = SMData.FindArmourNodeCByNumber(item);
			coreGame.SetHintText("<b>" + SMData.GetArmourName(item) + "</b>\r" + coreGame.SlaveMakerStatisticsGroup.Defence.StatLabel.text + " +" + Language.XMLData.GetXMLStringParsed("Protection", iNode) + "\r" + Language.GetHtml("Speed", "Statistics") + ": " + Language.XMLData.GetXMLStringParsed("SpeedBonus", iNode));
		} else if (weap == 3) {
			var ds:Dress = SMData.GetDressRO(item);
			if (ds != null) coreGame.SetHintText("<b>" + ds.strName + "</b>\r" + ds.strDescription + "\r" + SMData.DescribeDress(item));
			else return;
		}
		ShowHint();
	}
	
	public function SMEquipItem(mc:MovieClip)
	{
		if (weaponsShown == 1) {
			SMData.WeaponType = mc._parent.ItemNo;
			coreGame.WeaponType = SMData.WeaponType;
		} else if (weaponsShown == 2) {
			SMData.ArmourType = mc._parent.ItemNo;
			coreGame.ArmourType = SMData.ArmourType;
		} else if (weaponsShown == 3) {
			if (SMData.DressWorn > -1) {
				// remove the previous dress, undo any stat effects
				var nm:String = coreGame.SMAvatar.avatarImages.GetBaseImageName(SMData.DressWorn + 20000);
				var dNode:XMLNode = Language.XMLData.GetNodeC(coreGame.SMAvatar.GetXML(), "Images/" + nm);
				if (dNode != null) SMData.ParseSMPoints(Language.XMLData.GetNodeC(dNode, "StatEffects"), true);
			}
			SMData.DressWorn = mc._parent.ItemNo;
			if (SMData.DressWorn > -1) {
				// wear the dress, apply any stat effects
				var nm:String = coreGame.SMAvatar.avatarImages.GetBaseImageName(SMData.DressWorn + 20000);
				var dNode:XMLNode = Language.XMLData.GetNodeC(coreGame.SMAvatar.GetXML(), "Images/" + nm);
				if (dNode != null) SMData.ParseSMPoints(Language.XMLData.GetNodeC(dNode, "StatEffects"), false);
			}
			
		}
		coreGame.ClearGeneralArray2();
		mcBase.Items.visible = false;
		mcBase.Items.invalidate();
		ShowCurrentItems();
		weaponsShown = -1;
		SMData.ShowSlaveMaker();
	}
	
	private function WeaponPress()
	{
		coreGame.ClearGeneralArray2();
		
		if (weaponsShown == 1) {
			mcBase.Items.visible = false;
			mcBase.Items.invalidate();
			weaponsShown = -1;
			return;
		}
		
		weaponsShown = 1;
		var sitem:Number = 0;
		var tw:Number = SMData.GetTotalWeapons();
		for (var i:Number = 0; i < tw; i++) {
			if (SMData.IsWeaponOwned(i)) sitem = AddSMItem(sitem, i);
		}
		mcBase.Items.visible = true;
		mcBase.Items.invalidate();
	}
	
	private function ArmourPress()
	{
		coreGame.ClearGeneralArray2();
		
		if (weaponsShown == 2) {
			mcBase.Items.visible = false;
			mcBase.Items.invalidate();
			weaponsShown = -1;
			return;
		}
		
		weaponsShown = 2;
		var sitem:Number = 0;
		var ta:Number = SMData.GetTotalArmours();
		for (var i:Number = 0; i < ta; i++) {
			if (SMData.IsArmourOwned(i)) sitem = AddSMItem(sitem, i);
		}
		mcBase.Items.visible = true;
		mcBase.Items.invalidate();
	}
	
	private function ClothingPress()
	{
		coreGame.ClearGeneralArray2();
		
		if (weaponsShown == 3) {
			mcBase.Items.visible = false;
			mcBase.Items.invalidate();
			weaponsShown = -1;
			return;
		}
		
		weaponsShown = 3;
		var sitem:Number = 0;
		if (SMData.SMAdvantages.CheckBitFlag(27)) sitem = AddSMItem(sitem, -1);
		for (var i:Number = 0; i < 7; i++) {
			if (SMData.IsDressOwned(i)) sitem = AddSMItem(sitem, i);
		}
		mcBase.Items.visible = true;
		mcBase.Items.invalidate();
	}
	
	public function ShowCurrentItems()
	{
		coreGame.HideImages();
		var mc:MovieClip;
		
		var ti:DialogEquipmentSlaveMaker = this;
		if (SMData.ArmourType != 0) {
			mc = SMData.LoadArmourImage(SMData.ArmourType, 0, -99, SMData.Gender == 1 ? 2 : 1, mcBase, 0, cbobj.LoaderA);
			mc.onRollOver = function() {
				ti.ShowArmourHint(this);
			}
		}
		if (SMData.WeaponType != 0) {		
			mc = SMData.LoadWeaponImage(SMData.WeaponType, 0, -99, 1, mcBase, 0, cbobj.LoaderW);
			mc.onRollOver = function() {
				ti.ShowWeaponHint(this);
			}
		}
		mc.onRollOut = function() { HideHints(true); SetMovieColour(this, 0, 0, 0); };
		ShowOtherSMEquipment();
	}
	
	public function ShowCurrentPositionA(mc:MovieClip)
	{
		var mratio:Number = mc._width / mc._height;
		mc._x = 110;
		mc._y = 90;
		mc._width = mratio * 420;
		mc._height = 420;
		mc._visible = true;
		mc.enabled = true;
	}
	
	public function ShowCurrentPositionW(mc:MovieClip)
	{
		var mratio:Number = mc._width / mc._height;
		switch (SMData.WeaponType) {
			case 1:
				mc._rotation = 30;
				mc._x = 300;
				mc._y = 240;
				mc._width = 150;
				mc._height = 200;
				mc._visible = true;
				mc.enabled = true;
				return;
			case 2:
				mc._x = 280;
				mc._y = 310;
				mc._width = 70;
				break;
			case 3:
				mc._x = 210;
				mc._y = 350;
				mc._width = 150;
				break;
			case 4:
				mc._x = 250;
				mc._y = 370;
				mc._width = 150;
				break;
			case 5:
				mc._x = 300;
				mc._y = 210;
				mc._width = 150;
				break;
			case 6:
				mc._x = 260;
				mc._y = 400;
				mc._width = 100;
				break;
			case 7:
				mc._x = 260;
				mc._y = 400;
				mc._width = 125;
				break;
		}
		if (SMData.WeaponType > 7) {
			mc._x = 260;
			mc._y = 300;
			mc._width = 300 * mratio;
		}
	
		mc._height = mc._width / mratio;
		mc._visible = true;
		mc.enabled = true;
	}
	
	public function ShowWeaponHint(mc:MovieClip)
	{
		if (SMData.WeaponType != 0) {
			SetMovieColour(mc, 50, 50, 50);
			SMItemHintRollOver(mc, SMData.WeaponType, 1);
			ShowHintAdd("\r\r" + Language.GetHtml("YourGearCurrentWeapon", "Equipment"));
		}
	}
	
	public function ShowArmourHint(mc:MovieClip)
	{
		if (SMData.ArmourType != 0) {
			SetMovieColour(mc, 50, 50, 50);
			SMItemHintRollOver(mc, SMData.ArmourType, 2);
			ShowHintAdd("\r\r" + Language.GetHtml("YourGearCurrentArmour", "Equipment"));
		}
	}
	
	public function ShowOtherSMEquipment()
	{
		coreGame.ShowLargerText();
		AddText("<b>" + Language.GetHtml("Clothing", "Equipment") + "</b>\r\r");
		for (var i:Number = 0; i < 7; i++) {
			if (SMData.IsDressOwned(i)) {
				AddText("  " + SMData.GetDressName(i));
				if (SMData.DressWorn == i) AddText(" - Worn");
				AddText("\r\r");
			}
		}
		AddText("<b>" + Language.GetHtml("SlaveMakerItems", "Equipment") + "</b>\r\r");
		DoCounted(SMData.TotalBooks, Language.GetHtml("Book", "Equipment"));
		DoCounted(SMData.TotalPoetry, Language.GetHtml("PoetryBook", "Equipment"));
		if (SMData.OtherBooks.CheckBitFlag(0)) AddText("  " + Language.GetHtml("LadiesGuide", "Equipment") + "\r\r");
		if (SMData.OtherBooks.CheckBitFlag(1)) AddText("  " + Language.GetHtml("HistoricalTales", "Equipment") + "\r\r");
		if (SMData.OtherBooks.CheckBitFlag(2)) AddText("  " + Language.GetHtml("MasculineLove1", "Equipment") + "\r\r");
		if (SMData.OtherBooks.CheckBitFlag(3)) AddText("  " + Language.GetHtml("MasculineLove2", "Equipment") + "\r\r");
		if (coreGame.BDSMOn && (SMData.RopesOK == 1)) AddText("  " + Language.GetHtml("BasicRopes", "Equipment") + "\r\r");
		if (SMData.SilkenRopesOK == 1) AddText("  " + Language.GetHtml("SilkenRopes", "Equipment") + "\r\r");
		if (SMData.SMVanityCaseOK == 1) AddText("  " + Language.GetHtml("VanityCase", "Equipment") + "\r\r");
		if (SMData.SMNippleRingsOK == 1) AddText("  " + Language.GetHtml("NippleRings", "Equipment") + "\r\r");
		if (SMData.SMFeeldoOK == 1) AddText("  " + Language.GetHtml("Feeldo", "Equipment") + "\r\r");
		
		var owned:Boolean = false;
		for (i = 1; i < 32; i++) {
			if (SMData.IsArmourOwned(i)) {
				AddText("  " + SMData.GetArmourName(i));
				if (SMData.ArmourType == i) AddText(" - " + Language.GetHtml("Equipped", "Equipment"));
				owned = true;
				AddText("\r");
			}
		}
		if (owned) AddText("\r");
		owned = false;
		for (i = 1; i < 32; i++) {
			if (SMData.IsWeaponOwned(i)) {
				AddText("  " + SMData.GetWeaponName(i));
				if (SMData.WeaponType == i) AddText(" - " + Language.GetHtml("Equipped", "Equipment"));
				owned = true;
				AddText("\r");
			}
		}
		if (owned) AddText("\r");
	
		if (SMData.GetTotalSlavesOwned() > 0) {
			AddText(" <i>" + Language.GetHtml("YourSlaves", "Equipment") + "</i>\r\r");
			var len:Number = SMData.SlavesArray.length;
			var sd:Slave;
			for (i = 0; i < len; i++) {
				sd = SMData.SlavesArray[i];
				if (sd.SlaveType == 1 && sd.CanAssist == true) AddText("  <b>" +  sd.SlaveName + "</b>\r");
				else if (sd.SlaveType == 0) AddText("  " +  sd.SlaveName + "\r");
			}
			AddText("\r");
		}
		
		var tot:Number = SMData.GetTotalChildren(SMData.SMSpecialEvent == 2);
		if ((tot + SMData.TotalSMChildren) + SMData.SMTotalTentaclePregnancy > 0) {
			AddText("<b>" + Language.GetHtml("ChildrenEquipment", "Equipment") + "</b>\r");
			if (tot > 0) AddText("  " + Language.GetHtml("ChildrenBySlaves", "Equipment") + " " + tot + "\r");
			if (SMData.TotalSMChildren > 0) AddText("  " + Language.GetHtml("ChildrenGivenBirth", "Equipment") + " " + SMData.TotalSMChildren + "\r");
			if (SMData.SMTotalTentaclePregnancy > 0) AddText("  " + Language.GetHtml("TentaclesGivenBirth", "Equipment") + " " + SMData.SMTotalTentaclePregnancy + "\r");
		}
		coreGame.modulesList.ShowOtherSMEquipment();
	}

	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 65: ArmourPress(); return true;
			case 67: ClothingPress(); return true;
			case 87: WeaponPress(); return true;
		}
		return false;
	}
	
	// Theme
	public function ApplyTheme(cvo:ColourScheme)
	{
		coreGame.SetMovieColourARGB(coreGame.SMEquipmentButton, cvo.nActButtons, true);
		mcBase.Items.setStyle("scrollTrackColor", cvo.nActButtons);
	}
	
}
