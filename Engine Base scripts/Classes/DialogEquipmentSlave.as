// DialogEquipmentSlave - Equipment Menu
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogEquipmentSlave extends DialogBase {
	
	private var Items:GameItems;		// reference
	
	// Constructor
	public function DialogEquipmentSlave(cg:Object)
	{ 
		super(cg.EquipmentMenu, cg);
		
		var ti:DialogEquipmentSlave = this;
		coreGame.EquipmentButton.tabChildren = true;
		coreGame.EquipmentButton.Btn.onPress = function() { ti.ViewDialog(); }
		coreGame.EquipmentButton.Btn.onRollOut = coreGame.HideHints;
		coreGame.EquipmentButton.Btn.onRollOver = function() {
			if (ti.IsHints() && !ti.coreGame.YesEvent._visible) ti.ShowHint(ti.Language.GetHtml("HintEquipmentButton", ti.coreGame.hintNode));
		}
	}
	
	public function ShowEquipmentButton(xpos:Number)
	{
		if (xpos == undefined) coreGame.EquipmentButton._x = 492;
		else coreGame.EquipmentButton._x = xpos;
		coreGame.EquipmentButton._visible = true;
	}
	public function HideEquipmentButton()
	{
		coreGame.EquipmentButton._x = 492;
		coreGame.EquipmentButton._visible = false;
	}
	
	public function StartNewSlave()
	{
		trace("StartNewSlave");
		Items = coreGame.Items;
		
		// Cresses
		SetEquipmentButtonState(0, false, false, Language.GetHtml("PlainDress", "Equipment"), "0");
		SetEquipmentButtonState(-1, false, false, "\r", "1");
		SetEquipmentButtonState(-2, false, false, "\r", "2");
		SetEquipmentButtonState(-3, false, false, "\r", "3");
		SetEquipmentButtonState(-4, false, false, "\r", "4");
		SetEquipmentButtonState(-5, false, false, "\r", "5");
		SetEquipmentButtonState(-6, false, false, "\r", "6");
		SetEquipmentButtonState(-10, false, false, Language.GetHtml("Naked", Language.actNode), "K");
	
		// gear
		SetEquipmentButtonState(2, false, false, Language.GetHtml("Halo", "Equipment"), "H");
		SetEquipmentButtonState(4, false, false, Language.GetHtml("AngelsTear", "Equipment"), "T");
		SetEquipmentButtonState(3, false, false, Language.GetHtml("DemonicPendant", "Equipment"), "P");
		SetEquipmentButtonState(5, false, false, Language.GetHtml("DemonicBra", "Equipment"), "B");
		SetEquipmentButtonState(6, false, false, Language.GetHtml("VibratorPanties", "Equipment"), "V");
		SetEquipmentButtonState(7, false, false, Language.GetHtml("Leash", "Equipment"), "L");
		SetEquipmentButtonState(8, false, false, Language.GetHtml("NymphsTiara", "Equipment"), "N");
		SetEquipmentButtonState(9, false, false, Language.GetHtml("SpikedBracelet", "Equipment"), "S");
		SetEquipmentButtonState(10, false, false, Language.GetHtml("HandcuffBracelet", "Equipment"), "U");
		SetEquipmentButtonState(12, false, false, Language.GetHtml("DragonRing", "Equipment"), "D");
		SetEquipmentButtonState(13, false, false, Language.GetHtml("Apron", "Equipment"), "A");
		SetEquipmentButtonState(15, false, false, Language.GetHtml("StrapOn", "Equipment"), "O");
		SetEquipmentButtonState(17, false, false, Language.GetHtml("NippleChain", "Equipment"), "C");
		SetEquipmentButtonState(18, false, false, Language.GetHtml("NippleRings", "Equipment"), "E");
		
		// Cat
		SetEquipmentButtonState(23, false, false, Language.GetHtml("CatEars", "Equipment"), "Q");
		SetEquipmentButtonState(24, false, false, Language.GetHtml("CatTail", "Equipment"), "I");
		
		// Pony
		SetEquipmentButtonState(11, false, false, Language.GetHtml("Harness", "Equipment"), "R");
		SetEquipmentButtonState(1, false, false, Language.GetHtml("PonyTail", "Equipment"), "y");
		SetEquipmentButtonState(14, false, false, Language.GetHtml("BitGag", "Equipment"), "G");
		
		// Faerie
		SetEquipmentButtonState(16, false, false, Language.GetHtml("FaeriesRing", "Equipment"), "F");

		// Custom
		for (var i:Number = 50; i < 80; i++) SetEquipmentButtonState(i, false, false, "");		
	}
		
	//nCurrentPage	- current tab
	//nTotPages 	- total tabs
	public function ViewDialog()
	{
		coreGame.PersonIndex = -50;
		Items = coreGame.Items;
		SetSlave(coreGame.slaveData);
		mcBase.LText.htmlText = Language.GetHtml("Equipment", "Buttons", true);
				
		// total tabs
		nTotPages = 0;
		SetTabDetails(Language.GetHtml("Common", "Equipment"));
		if (Items.IsCustomItems()) SetTabDetails(Language.GetHtml("Other", "Equipment"));
		coreGame.modulesList.SetEquipmentTabs();

		for (var i:Number = nTotPages + 1; i < 9; i++) mcBase["TabButton" + i]._visible = false;

		super.ViewDialog();
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
		
		ShowCurrentTab();
		
		ShowOtherEquipment();
		
		coreGame.ShowDress();
		coreGame.dspMain.SelectGameTab(5);
	}


	public function SetTabDetails(strLabel:String) : Number
	{
		nTotPages++;
		var mc:MovieClip = mcBase["TabButton" + nTotPages];
		mc._visible = true;
		mc.BlackText.htmlText = "<font size='+1'>" + strLabel + "</font>";
		mc.WhiteText.htmlText = "<font size='+1'>" + strLabel + "</font>";
		mc.tab = nTotPages;
		var ti:DialogEquipmentSlave = this;
		mc.onRollOver = function() { ti.coreGame.SetMovieColour(mc, 200, 200, 200); }
		mc.onRollOut = function()
		{ 
			var mc:MovieClip = ti.mcBase["TabButton" + ti.nCurrentPage];
			for (var i:Number = 1; i < 9; i++) ti.coreGame.SetMovieColour(ti.mcBase["TabButton" + i], 0, 0, 0);
			ti.coreGame.SetMovieColour(mc, 50, 50, 50);
		}
		mc.onPress = function() {
			ti.nCurrentPage = mc.tab;
			ti.ShowCurrentTab();
		}
		return nTotPages;
	}
	
	public function ShowCurrentTab()
	{
		var mc:MovieClip = mcBase["TabButton" + nCurrentPage];
		for (var i:Number = 1; i < 9; i++) coreGame.SetMovieColour(mcBase["TabButton" + i], 0, 0, 0);
		coreGame.SetMovieColour(mc, 50, 50, 50);
		
		// reset buttons
		for (var i:Number = 1; i < 22; i++) {
			mcBase["Item" + i]._visible = false;
			mcBase["Item" + i].itemno = undefined;
		}

		// Common to all tabs
		// dresses
		for (var i:Number = 0; i < 7; i++) SetEquipmentButtonState(-1 * i, coreGame.DressWorn == i, slaveData.GetDressRO(i).IsDressOwned(), slaveData.GetDressRO(i).strName);
		SetEquipmentButtonState(-10, coreGame.DressWorn < 0, SMData.IsNakedDressAvailable());

		var iCurr:Number = 1;
		switch(nCurrentPage) {
			case 1: ShowCommonTab(); return;
		}
		if (Items.IsCustomItems()) {
			iCurr++;
			if (nCurrentPage == iCurr) {
				ShowOtherTab();
				return;
			}
		}
		coreGame.modulesList.ShowEquipmentTab(nCurrentPage);

	}
	
	public function ShowCommonTab()
	{
		// Common tab
		// items
		AddEquipmentButton(1, 4, coreGame.AngelsTearWorn == 1, coreGame.AngelsTearOK == 1);
		AddEquipmentButton(2, 12, coreGame.DragonRingWorn == 1, coreGame.DragonRingOK == 1);
		AddEquipmentButton(3, 13, coreGame.ApronWorn == 1, coreGame.ApronOK == 1); 
		AddEquipmentButton(4, 3, coreGame.DemonicPendantWorn == 1, coreGame.DemonicPendantOK == 1);
		AddEquipmentButton(5, 7, coreGame.LeashWorn == 1, coreGame.LeashOK == 1);
		AddEquipmentButton(6, 6, coreGame.VibratorPantiesWorn == 1, coreGame.VibratorPantiesOK == 1); 
		AddEquipmentButton(7, 2, coreGame.HaloWorn == 1, coreGame.HaloOK == 1);
		AddEquipmentButton(8, 10, coreGame.HandcuffBraceletWorn == 1, coreGame.HandcuffBraceletOK == 1);
		AddEquipmentButton(9, 5, coreGame.DemonicBraWorn == 1, coreGame.DemonicBraOK == 1);
		AddEquipmentButton(10, 8, coreGame.NymphsTiaraWorn == 1, coreGame.NymphsTiaraOK == 1);
		AddEquipmentButton(11, 9, coreGame.SpikedBraceletWorn == 1, coreGame.SpikedBraceletOK == 1);
		AddEquipmentButton(12, 15, coreGame.StrapOnWorn == 1, coreGame.StrapOnOK == 1);
		AddEquipmentButton(13, 18, coreGame.NippleRingsWorn == 1, coreGame.NippleRingsOK == 1);
		AddEquipmentButton(14, 17, coreGame.NippleChainWorn == 1, coreGame.NippleChainOK == 1);
		
		if (SMData.SMFaith == 2) {
			AddEquipmentButton(15, 4, false, false, Language.GetHtml("TorunsChalice", "Equipment"), "T");
			AddEquipmentButton(16, 2, false, false, Language.GetHtml("OroborusCandle", "Equipment"), "H");
		} else if (SMData.SMFaith == 1) {
			AddEquipmentButton(15, 2, false, false, Language.GetHtml("Halo", "Equipment"), "H");
			AddEquipmentButton(16, 4, false, false, Language.GetHtml("AngelsTear", "Equipment"), "T");
		} else {
			AddEquipmentButton(15, 2, false, false, Language.GetHtml("Halo", "Equipment"), "H");
			AddEquipmentButton(16, 4, false, false, Language.GetHtml("AngelsTear", "Equipment"), "T");
		}
		
		// Faerie
		AddEquipmentButton(17, 16, coreGame.FaeriesRingWorn == 1, coreGame.FaeriesRingOK == 1, Language.GetHtml("FaeriesRing", "Equipment"), "F");
		
		// to allow modification of common page
		coreGame.modulesList.ShowEquipmentTab(nCurrentPage);

	}	
	
	public function ShowOtherTab()
	{
		// custom items
		for (var i:Number = 50; i < 80; i++) AddEquipmentButton(i - 49, i, coreGame.slaveData.ItemsWorn.CheckBitFlag(i), coreGame.slaveData.ItemsOwned.CheckBitFlag(i));
	}
	
	public function SetEquipmentButtonState(item:Number, worn:Boolean, available:Boolean, actlabel:String, shortcut:String, gi:GameItemState)
	{
		if (item != undefined) gi = Items.GetItemState(item);
		gi.SetItemState(actlabel, available, shortcut);
		var mc:MovieClip = gi.mc;
		if (item >= 50 && item < 80) {
			if (available == true) {
				Items.SetCustomItems(true);
				coreGame.slaveData.ItemsOwned.SetBitFlag(item);
			} else coreGame.slaveData.ItemsOwned.ClearBitFlag(item);
			coreGame.slaveData.ItemsWorn.ChangeBitFlag(item, worn == undefined ? false : worn);
		}
		if (mc == null) {
			mc = GetEquipmentMovieClip(item);
			if (mc == null) return;
			mc.itemno = item;
		}
		
		if (actlabel != undefined) {
			var ti:DialogEquipmentSlave = this;
			mc.DressName.htmlText = gi.strLabel;
			if (mc.DressName.bottomScroll > 1) mc.DressName._y = 2;
			else mc.DressName._y = 8;
			mc.ItemOn.onPress = function() { ti.EquipmentButtonRemove(this._parent.itemno); }
			mc.ItemOff.onPress = function() { ti.EquipmentButtonWear(this._parent.itemno); }
			mc.ItemOn.onRollOver = function() { ti.EquipmentButtonRollOver(this._parent.itemno); }
			mc.ItemOff.onRollOver = mc.ItemOn.onRollOver;
			mc.ItemOn.onRollOut = function() {
				ti.coreGame.ClearAutoLoadedMovies();
				ti.Items.HideItems();
				ti.ShowSupervisor();
				ti.HideHints();
			}
			mc.ItemOff.onRollOut = mc.ItemOn.onRollOut;
		}
		mc._visible = gi.bShown;
		if (worn != undefined) {
			mc.ItemOn._visible = worn;
			mc.ItemOff._visible = !worn;
		}
		mc.ShortcutLabel.htmlText = "<font color='#0000FF'>" + gi.shortcut + "<font color='#000000'>";
		if (coreGame.config.bColoursOn) coreGame.ApplyColourBtn(mc, 0, 0.57);
	}
	
	public function AddEquipmentButton(btn:Number, item:Number, worn:Boolean, available:Boolean, actlabel:String, shortcut:String, gi:GameItemState)
	{
		var mc:MovieClip = mcBase["Item" + btn];
		mc.itemno = item;
		var gi:GameItemState = Items.GetItemState(item);
		gi.mc = mc;
		if (shortcut == undefined || shortcut == "" && gi.shortcut != "") shortcut = gi.shortcut;
		SetEquipmentButtonState(undefined, worn, available, actlabel != undefined ? actlabel : gi.strLabel, shortcut, gi)
	}

	public function SetEquipmentLabel(item:Number, actlabel:String) { SetEquipmentButtonState(item, undefined, undefined, actlabel); }
	public function ShowCustomEquipmentButton(item:Number, showmc:Boolean) { SetEquipmentButtonState(item, undefined, showmc); }
	
	public function ShowOtherEquipment()
	{
		coreGame.ShowLargerText();
		AddText("<b>" + Language.GetHtml("OtherItems", "Equipment") + "</b>\r\r");
		if (coreGame.DildoOK == 1 && coreGame.ImprovedDildoOK == 0) AddText("  " + Language.GetHtml("PlainDildo", "Equipment") + "\r\r");
		if (coreGame.ImprovedDildoOK == 1) AddText("  " + Language.GetHtml("ImprovedDildo", "Equipment") + "\r\r");
		if (coreGame.PlugOK == 1) AddText("  " + Language.GetHtml("AnalPlug", "Equipment") + "\r\r");
		if (coreGame.PiercingsType > 0) {
			if (coreGame.PiercingsType > 1) AddText("  " + Language.GetHtml("FullPiercing", "Equipment") + "\r\r");
			else {
				if (coreGame.HasCock) AddText("  " + Language.GetHtml("NippleCockPiercing", "Equipment") + "\r\r");
				else AddText("  " + Language.GetHtml("NippleClitPiercing", "Equipment") + "\r\r");
			}
		}
		if (coreGame.VanityCaseOK == 1) AddText("  " + Language.GetHtml("VanityCase", "Equipment") + "\r\r");
		
		// uniforms
		for (var i:Number = 7; i < 13; i++) {
			var obj:Object = coreGame.slaveData.GetUniformDetails(i);
			if (obj.owned == 1) AddText("  " + obj.dname + "\r\r");
			delete obj;
		}
		
		DoCounted(coreGame.TotalTeddyBear, Language.GetHtml("TeddyBear", "Equipment"));
		DoCounted(coreGame.TotalGames, Language.GetHtml("Game", "Equipment"));
		DoCounted(coreGame.TotalDoll, Language.GetHtml("Doll", "Equipment"));
		DoCounted(coreGame.TotalJewelry, Language.GetHtml("JewelryItem", "Equipment"));
		if (coreGame.PonyBootsOK == 1) AddText("  " + Language.GetHtml("PonyBoots", "Equipment") + "\r\r");
		if (coreGame.PonyCartOK == 1) AddText("  " + Language.GetHtml("PonyCart", "Equipment") + "\r\r");
		if (coreGame.TrophyOK == 1) AddText("  " + Language.GetHtml("GrandTrophy", "Equipment") + "\r\r");
		if (coreGame.SmallTrophyOK == 1) AddText("  " + Language.GetHtml("ChampionTrophy", "Equipment") + "\r\r");
		
		coreGame.modulesList.ShowOtherEquipment();
	
		coreGame.dspMain.SelectGameTab(coreGame.StatTab);
	}
	
	public function GetEquipmentMovieClip(item:Number) : MovieClip
	{
		switch(item) {
			case -10: return mcBase.NakedDress;
			case -6: return mcBase.Robe6On;
			case -5: return mcBase.Robe5On;
			case -4: return mcBase.Robe4On;
			case -3: return mcBase.Robe3On;
			case -2: return mcBase.Robe2On;
			case -1: return mcBase.Robe1On;
			case 0: return mcBase.RobePlainOn;
		}
		for (var i:Number = 1; i < 22; i++) {
			if (mcBase["Item" + i].itemno == item) return mcBase["Item" + i];
		}
		return null;
	}
	
	public function EquipmentButtonRemove(itemno:Number)
	{
		if (itemno < 1) {
			if (coreGame.Catgirl) {
				if (coreGame.IsDressCatEars() || coreGame.IsDressCatTail()) {
					var refuse:Boolean = false;
					if (coreGame.IsDressCatEars() && coreGame.CatEarsOK == 0) refuse = true;
					if (coreGame.IsDressCatTail() && coreGame.CatTailOK == 0) refuse = true;
					if (refuse && coreGame.BitFlag1.CheckBitFlag(15)) {
						SlaveSpeak(Language.GetHtml("RefuseToRemoveCatgirlItem", "SlaveTrainings/Catgirl"));
						Bloop();
						return;
					} else if (refuse) {
						ServantSpeak(Language.GetHtml("RemoveCatGirlItem", "SlaveTrainings/Catgirl"));
						ShowOtherEquipment();
						DoYesNoEvent(2052);
						coreGame.ShowDress();
						return;
					}
					if (coreGame.CatEarsOK == 1) {
						coreGame.CatEarsWorn = 1;
						SetText(Language.GetHtml("WearCatEars", "SlaveTrainings/Catgirl"));
					}
					if (coreGame.CatTailOK == 1) {
						coreGame.CatTailWorn = 1;
						if (coreGame.PlugInserted == 1) coreGame.UnEquipItem(1);
						coreGame.PlugInserted = 1;
						AddText(Language.GetHtml("WearCatTail", "SlaveTrainings/Catgirl"));
					}
				}
			}
			coreGame.TakeDressOff();
		} else Items.RemoveItem(itemno);
		ShowCurrentTab();
	}
	
	public function EquipmentButtonWear(itemno:Number)
	{
		if (itemno < 1) {
			if (itemno != -10 && !coreGame.Catgirl) {
				if (coreGame.IsDressCatEars(Math.abs(itemno)) || coreGame.IsDressCatTail(Math.abs(itemno))) {
					if (coreGame.sCatTrainer < coreGame.CatgirlInterest) {
						Language.XMLData.XMLGeneral("SlaveTrainings/Catgirl/RefuseCatgirl", false);
						coreGame.SlaveGirl.ShowRefuseCatgirl(Math.abs(itemno));
						coreGame.genNumber = Math.abs(itemno);
						ShowOtherEquipment();
						Bloop();
						return;
					}
					if (coreGame.IsPonygirl()) {
						coreGame.SetLangText("NoPuppygirlCatgirls", "SlaveTrainings/Puppygirl");
						return;
					}
					var cears:Boolean = (coreGame.CatEarsWorn == 1) || coreGame.IsDressCatEars(Math.abs(itemno));
					var ctail:Boolean = (coreGame.CatTailWorn == 1) || coreGame.IsDressCatTail(Math.abs(itemno));
					if (cears && ctail) {
						coreGame.Catgirls.StartTraining(itemno);
						if (coreGame.NumEvent == 9706) coreGame.PutDressOn(Math.abs(itemno));
						return;
					}
				}
			} else {
				if (coreGame.IsDressCatEars() || coreGame.IsDressCatTail()) {
					var refuse:Boolean = false;
					if (coreGame.IsDressCatEars() && coreGame.CatEarsOK == 0) refuse = true;
					if (coreGame.IsDressCatTail() && coreGame.CatTailOK == 0) refuse = true;
					if (refuse && coreGame.BitFlag1.CheckBitFlag(15)) {
						SlaveSpeak(Language.GetHtml("RefuseToRemoveCatgirlItem", "SlaveTrainings/Catgirl"));
						Bloop();
						return;
					} else if (refuse) {
						ServantSpeak(Language.GetHtml("RemoveCatGirlItem", "SlaveTrainings/Catgirl"));
						ShowOtherEquipment();
						DoYesNoEvent(2053);
						if (itemno == -10) coreGame.ObjectChoice = -10;
						else coreGame.ObjectChoice = Math.abs(itemno);
						coreGame.ShowDress();
						return;
					}
					if (coreGame.CatEarsOK == 1) {
						coreGame.CatEarsWorn = 1;
						SetText(Language.GetHtml("WearCatEars", "SlaveTrainings/Catgirl"));
					}
					if (coreGame.CatTailOK == 1) {
						coreGame.CatTailWorn = 1;
						if (coreGame.PlugInserted == 1) coreGame.UnEquipItem(1);
						coreGame.PlugInserted = 1;
						AddText(Language.GetHtml("WearCatTail", "SlaveTrainings/Catgirl"));
					}
				}
			}
			if (itemno == -10) coreGame.PutDressOn(-10);
			else coreGame.PutDressOn(Math.abs(itemno));
		} else Items.WearItem(itemno);
		ShowCurrentTab();
	}
	
	public function EquipmentButtonRollOver(item:Number)
	{
		if (IsHints()) {
			if (item < 1) {
				switch(item) {
					case -1: 
					case -2: 
					case -3: 
					case -4:
					case -5:
					case -6: 
						SetText(slaveData.GetDress(item).strName + "\r\r" + slaveData.GetDress(item).strDescription);
						break;
					case -10: 
						SetText(Language.GetHtml("Naked", Language.actNode) + "\r\r"); 
						break;
					case 0: 
						SetText(slaveData.GetDress(0).strDescription); 
						break;
				}
				if (item != -10) AddText("\r" + slaveData.DescribeDress(item * -1));
				ShowOtherEquipment();
			} else Items.ShowItemDescription(item);
		}
		if (item > 0) {
			if (item == 3 || item == 6) Items.ShowItem(item, false, 1, -1);
			else {
				if (item == 4) Items.ShowItem(item, false, 0);
				else if (item == 23) Items.ShowItem(item, false, 8, 1);
				else if (item == 24) Items.ShowItem(item, false, 8, 3);
				else Items.ShowItem(item, false, 1);
			}
			coreGame.HideSupervisor();
		}
	}

	
	public function ChangeDress(item:Number)
	{
		if (item == -10) {
			if (coreGame.DressWorn == item) EquipmentButtonWear(0);
			else EquipmentButtonWear(item);
		} else if (Items.IsItemAvailable(item)) {
			if (coreGame.DressWorn == Math.abs(item)) EquipmentButtonRemove(item);
			else EquipmentButtonWear(item);
		}
		ShowCurrentTab();
	}

	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (key == 37) {
			nCurrentPage++;
			if (nCurrentPage > nTotPages) nCurrentPage = 1;
			ShowCurrentTab();
			return true;
		} else if (key == 39) {
			nCurrentPage--;
			if (nCurrentPage < 1) nCurrentPage = nTotPages;
			ShowCurrentTab();
			return true;			
		}
		
		switch(keya) {
			case 48: ChangeDress(0); return;
			case 49: ChangeDress(-1); return;
			case 50: ChangeDress(-2); return;
			case 51: ChangeDress(-3); return;
			case 52: ChangeDress(-4); return;
			case 53: ChangeDress(-5); return;
			case 54: ChangeDress(-6); return;
			case 75: ChangeDress(-10); return;
			case 65: Items.ChangeItem(13); break;
			case 66: Items.ChangeItem(5); break;
			case 67: Items.ChangeItem(17); break;
			case 68: Items.ChangeItem(12); break;
			case 69: Items.ChangeItem(18); break;
			case 70: Items.ChangeItem(16); break;
			case 71: Items.ChangeItem(14); break;
			case 72: Items.ChangeItem(2); break;
			case 73: Items.ChangeItem(24); break;
			case 76: Items.ChangeItem(7); break;
			case 78: Items.ChangeItem(8); break;
			case 79: Items.ChangeItem(15); break;
			case 80: Items.ChangeItem(3); break;
			case 81: Items.ChangeItem(23); break;
			case 82: Items.ChangeItem(11); break;
			case 83: Items.ChangeItem(9); break;
			case 84: Items.ChangeItem(4); break;
			case 85: Items.ChangeItem(10); break;
			case 86: Items.ChangeItem(6); break;
			case 89: Items.ChangeItem(1); break;
		}
		ShowCurrentTab();
		return false;
	}
	
	// Theme
	public function ApplyTheme(cvo:ColourScheme)
	{
		coreGame.SetMovieColourARGB(coreGame.EquipmentButton, cvo.nActButtons, true);
	}
	
}