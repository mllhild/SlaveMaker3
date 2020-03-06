// DisplayGameWindow - Main game window
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplayGameWindow extends DisplayBase {
	
	// Tabs
	private var gameTabs:TabGroup;
	private var subTabs:TabGroup;
	private var superviseTabs:TabGroup;
	public var SystemMenu:DialogSystem;
	
	public var mcCalendar:MovieClip;
	private var mcStatImage:MovieClip;
	
	// Slave
	private var dspSlaveStats:DisplaySlaveStatistics;
	private var dspSlaveVitals:DisplaySlaveVitals;
	private var dspSlaveSkills:DisplaySlaveSkills;

	// Slave Maker
	private var dspSlaveMakerStats:DisplaySlaveMakerStatistics;
	private var dspSlaveMakerVitals:DisplaySlaveMakerVitals;
	private var dspSlaveMakerSkills:DisplaySlaveMakerSkills;
	
	// Icons
	public var Icons:DisplayIcons;
	
	// Constructor
	public function DisplayGameWindow(cg:Object, bDummy:Boolean)
	{ 
		super(cg.mcMain, cg);
		
		dspSlaveStats = null;
		mcStatImage = mcBase.mcStatImage;
		mcStatImage.gotoAndStop(1);
		
		if (bDummy == true) return;
		
		SystemMenu = new DialogSystem(coreGame);
		
		Icons = new DisplayIcons(coreGame);
		coreGame.Icons = Icons;
		
		mcBase.LTime.styleSheet = Language.styles;
		mcBase.LDate.styleSheet = Language.styles;
		
		// Cheat

		var ti:DisplayGameWindow = this;
		mcBase.Cheat.tabEnabled = false;
		mcBase.Cheat.onPress = function() {
			if (Key.isDown(Key.CONTROL) && Key.isDown(Key.SHIFT)) {
				ti.gameTabs.ShowTab(1);
				ti.coreGame.SlaveDebugging = true;
			} else {
				if (!ti.coreGame.SandboxMode) ti.coreGame.BitFlag1.SetBitFlag(9);
				ti.coreGame.VarObedience += 5;
				ti.coreGame.Money(500, true);
				ti.coreGame.SMMoney(500, true);
			}
			ti.coreGame.UpdateSlave();
		}
				
		// Main Window shortcut
		
		mcBase.MainWindowButton.onPress = function() {
			if (ti.coreGame.Quitter._visible) ti.coreGame.DoLeaveButton();
			else if (ti.coreGame.NextGeneral._visible) ti.coreGame.DoPlanningNext();
			else if (ti.coreGame.NextEvent._visible) ti.coreGame.DoEventNex();
			else if (ti.coreGame.Contests.IsContestStarted()) ti.coreGame.Contests.DoContestsNext();
		}
		
		// Hint
		
		mcBase.GoldHint.tabEnabled = false;
		mcBase.GoldHint.onRollOver = function() {
			if (ti.SMData.GuildMember) ti.ShowHint(ti.Language.GetHtml("HintGoldGuildMember", ti.Language.hintNode));
			else ti.ShowHint(ti.Language.GetHtml("HintGold", ti.Language.hintNode));
		}
		mcBase.GoldHint.onRollOut = function() { ti.HideHints(true); }
		
		// View Diary
		mcBase.DiaryButton.onRollOver = function() { this._alpha = 90; };
		mcBase.DiaryButton.onRollOut = function() { this._alpha = 100; };
		mcBase.DiaryButton.onPress = function() {
			if (ti.coreGame.mcDiaryMenu.isenabled == true) ti.ViewDiary();
		}
		
		// Load/Save
		mcBase.mcLoad.onRollOver = function() { this._alpha = 60; ti.ShowHint(ti.Language.GetHtml("LoadGame", "Buttons")); };
		mcBase.mcLoad.onRollOut = function() { this._alpha = 100; ti.HideHints(); };
		mcBase.mcLoad.onPress = function() {
			ti.coreGame.LoadSave.LoadGame(ti.coreGame.LoadSave.nQuickSlot);
		}
		mcBase.mcSave.onRollOver = function() { this._alpha = 60; ti.ShowHint(ti.Language.GetHtml("SaveGame", "Buttons")); };
		mcBase.mcSave.onRollOut = function() { this._alpha = 100; ti.HideHints(); };
		mcBase.mcSave.onPress = function() {
			ti.coreGame.LoadSave.SaveGame(ti.coreGame.LoadSave.nQuickSlot);
		}
		
		// UI Images
		mcCalendar = LoadUIImage("CalendarImage", mcBase.DiaryButton);
		LoadUIImage("LoadImage", mcBase.mcLoad);
		LoadUIImage("SaveImage", mcBase.mcSave);
		LoadUIImage("BirthdayImage", mcBase.mcIcons.Birthday);

		// Primary Tabs
		gameTabs = new TabGroup(coreGame, 0, 0, this, "UpdateGameTabs");
		// System 0
		var cNode:XMLNode = coreGame.config.GetNode("GameTabs/SystemTab");
		gameTabs.AddTab(mcBase.SystemTab, "System", undefined, GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		mcBase.SystemTab.LText.filters = [];
		// Debug 1
		cNode = coreGame.config.GetNode("GameTabs/DebugTab");
		var tb:TabBase = gameTabs.AddTab(mcBase.DebugTab, "Debug", undefined, GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		gameTabs.HideTab(tb);
		// Slave 2
		cNode = coreGame.config.GetNode("GameTabs/SlaveTab");
		gameTabs.AddTab(mcBase.SlaveTab, "Slave", coreGame.XMLData.GetXMLString("Icon", cNode.firstChild), GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		// SlaveMaker 3
		cNode = coreGame.config.GetNode("GameTabs/SlaveMakerTab");
		gameTabs.AddTab(mcBase.SlaveMakerTab, "Slave Maker", coreGame.XMLData.GetXMLString("Icon", cNode.firstChild), GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		// Home Tab 4
		cNode = coreGame.config.GetNode("GameTabs/HomeTab");
		tb = gameTabs.AddTab(mcBase.HomeTab, "Home", coreGame.XMLData.GetXMLString("Icon", cNode.firstChild), GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		tb.InitialiseTab(undefined, undefined, this, "SelectPlanningTab");

		// Book Tab 5
		cNode = coreGame.config.GetNode("GameTabs/BookTab");
		gameTabs.AddTab(mcBase.TextTab, "Text", coreGame.XMLData.GetXMLString("Icon", cNode.firstChild), GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		
		// Secondary Tabs to subselect a tab
		subTabs = new TabGroup(coreGame, 0, 0, this, "UpdateSubTabs");
		cNode = coreGame.config.GetNode("GameTabs/StatsTab");
		subTabs.AddTab(mcBase.SubTab1, "Stats", undefined, GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		cNode = coreGame.config.GetNode("GameTabs/VitalsTab");
		subTabs.AddTab(mcBase.SubTab2, "Vitals", undefined, GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		cNode = coreGame.config.GetNode("GameTabs/SkillsTab");
		subTabs.AddTab(mcBase.SubTab3, "Skills", undefined, GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height));
		
		// Supervision Tabs
		superviseTabs = new TabGroup(coreGame, 0, 0, this, "ChangeSupervision", "SupervisionHints");
		cNode = coreGame.config.GetNode("GameTabs/SuperviseSlaveMakerTab");
		superviseTabs.AddTab(coreGame.PlanningSelections.mcPersonal, "Slave Maker", coreGame.XMLData.GetXMLString("Icon", cNode.firstChild, "Whip Icon"), GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height), 15, 1, 0, 30, 0);
		coreGame.PlanningSelections.mcPersonal.mcTab._width = 60;
		cNode = coreGame.config.GetNode("GameTabs/SuperviseAssistantTab");
		superviseTabs.AddTab(coreGame.PlanningSelections.mcAssistant, "Assistant", coreGame.XMLData.GetXMLString("Icon", cNode.firstChild, "Assistant Icon"), GetAVal(cNode.attributes.xpos), GetAVal(cNode.attributes.ypos), GetAVal(cNode.attributes.width), GetAVal(cNode.attributes.height), 15, 1, 0, 30, 0);
		coreGame.PlanningSelections.mcAssistant.mcTab._width = 60;
		
		// Slave Panels
		dspSlaveStats = new DisplaySlaveStatistics(coreGame);
		dspSlaveVitals = new DisplaySlaveVitals(coreGame);
		dspSlaveSkills = new DisplaySlaveSkills(coreGame);
		
		// Slave Maker Panels
		dspSlaveMakerStats = new DisplaySlaveMakerStatistics(coreGame);
		dspSlaveMakerVitals = new DisplaySlaveMakerVitals(coreGame);
		dspSlaveMakerSkills = new DisplaySlaveMakerSkills(coreGame);
	}
	
	private function LoadUIImage(s:String, mcIn:MovieClip) : MovieClip
	{
		var cNode:XMLNode = coreGame.config.GetNode(s);
		var str = coreGame.config.GetString(s);
		var xpos = GetAVal(cNode.attributes.xpos, 0);
		var ypos = GetAVal(cNode.attributes.ypos, 0);
		var wid = GetAVal(cNode.attributes.width, 32);
		var hei = GetAVal(cNode.attributes.height, 0);
		var mc:MovieClip = undefined;
		var clr = GetAVal(cNode.attributes.colour, GetAVal(cNode.attributes.color));
		if (str.indexOf("/") > -1) mc = coreGame.LoadImageAndPositionMovie(undefined, "Themes/" + coreGame.config.strTheme + "/" + str, xpos, ypos, 0, wid, hei, mcIn);
		else if (str != "") mc = coreGame.AttachAndPositionMovie(undefined, str, xpos, ypos, 0, wid, hei, mcIn);
		return mc;
	}
	
	
	public function SetSlaveForGameTabs(sd:Object)
	{
		coreGame.OtherSlaveShown = (sd != _root && sd != coreGame.slaveData);
		
		dspSlaveStats.SetSlave(sd);
		dspSlaveVitals.SetSlave(sd);
		dspSlaveSkills.SetSlave(sd);
		if (sd == SMData) {
			UpdateSlaveMaker();
			return;
		}
		coreGame.SetActButtonDetails(sd);
		coreGame.slaveData.HideSlaveSkillArray(!coreGame.OtherSlaveShown);
		dspSlaveSkills.SetSexSkills(sd);
		UpdateSexuality(sd.Sexuality);
		SMData.ClearOtherSlaveSkills();
		if (coreGame.OtherSlaveShown) {
			coreGame.UpdateSlave(sd);
			dspSlaveSkills.SetSlaveSkills(sd);
			dspSlaveSkills.UpdateSexSkills(sd);
		} else {
			coreGame.UpdateSlaveGenderText();
			coreGame.UpdateSlave();
		}
		UpdateSlaveVitals(sd);
		Icons.SetLoveIcon(sd);
		coreGame.modulesList.trainLesbians.SetSlave(sd);
		coreGame.modulesList.trainLesbians.InitialiseTraining(sd);
		coreGame.PersonOtherName = sd.SlaveName;
		coreGame.PersonOtherGender = sd.SlaveGender;
		coreGame.PersonOtherIndex = sd == _root ? -50 : sd.SlaveIndex;
		coreGame.GetPersonOtherGenderText(sd.GenderIdentity);
	}
	
	public function GetSlaveForGameTabs() : Object { return dspSlaveStats.sd; } 
	
	public function GetStatClipString(stat:String) : MovieClip { return dspSlaveStats.GetStatClipString(stat); }
	
	private function GetAVal(val:String, def) { return val == undefined ? def : Number(val); }

	public function SelectSingleGameTab(tab:Number)
	{
		HideGameTabs();
		SelectGameTabShow(tab);
	}
	public function SelectGameTab(tab:Number)
	{
		if (!IsShown()) return;
		ShowGameTabs();
		SelectGameTabShow(tab);	
	}
	public function SelectGameTabShow(tab:Number)
	{
		if (tab == 0) gameTabs.SelectTab(0);
		else if (tab == 7) gameTabs.SelectTab(1);
		else if (tab == 1) {
			gameTabs.GetTab(2).idxChild = 0;
			gameTabs.SelectTab(2);		
		} else if (tab == 2) {
			gameTabs.GetTab(2).idxChild = 1;
			gameTabs.SelectTab(2);
		} else if (tab == 3) {
			gameTabs.GetTab(3).idxChild = 0;
			gameTabs.SelectTab(3);		
		} else if (tab == 4) {
			gameTabs.GetTab(3).idxChild = 1;
			gameTabs.SelectTab(3);
		} else if (tab == 6) gameTabs.SelectTab(4);
		else if (tab == 5) gameTabs.SelectTab(5);
		else if (tab == undefined) UpdateGameTabs();
	}	
	public function HideGameTab(tab:Number)
	{
		if (tab == 0) gameTabs.HideTab(0);
		else if (tab == 7) gameTabs.HideTab(1);
		else if (tab == 1) gameTabs.HideTab(2);
		else if (tab == 2) gameTabs.HideTab(2);
		else if (tab == 3) gameTabs.HideTab(3);		
		else if (tab == 4) gameTabs.HideTab(3);
		else if (tab == 6) gameTabs.HideTab(4);
		else if (tab == 5) gameTabs.HideTab(5);
	}
	public function HideGameTabs()
	{
		gameTabs.HideAllTabs();
		HideGameTabsContents();
	}
	public function HideGameTabsContents()
	{
		subTabs.HideAllTabs();
		SystemMenu.Hide();
		HideDebugging();
		dspSlaveSkills.Hide();
		dspSlaveVitals.Hide();
		dspSlaveStats.Hide();
		dspSlaveMakerSkills.Hide();
		dspSlaveMakerVitals.Hide();
		dspSlaveMakerStats.Hide();				
		coreGame.PlanningSelections._visible = false;
		coreGame.LargerTextField._visible = false;
	}	
	public function HideGameTabsOnly()
	{
		gameTabs.Push();
		gameTabs.HideAllTabs();
		subTabs.HideAllTabs();
	}
	public function HideGameSubTabs() { subTabs.HideAllTabs(); }
	
	public function PushGameTabs()
	{
		gameTabs.Push();
	}
	public function PopGameTabs()
	{
		gameTabs.Pop();
	}		
	public function ShowGameTab(tab:Number)
	{
		if (tab == 0) gameTabs.HideTab(0);
		else if (tab == 7) gameTabs.ShowTab(1);
		else if (tab == 1) gameTabs.ShowTab(2);
		else if (tab == 2) gameTabs.ShowTab(2);
		else if (tab == 3) gameTabs.ShowTab(3);		
		else if (tab == 4) gameTabs.ShowTab(3);
		else if (tab == 6) gameTabs.ShowTab(4);
		else if (tab == 5) gameTabs.ShowTab(5);
	}
	public function ShowGameTabs()
	{
		var htabs:Boolean = (coreGame.PlanningPage._visible && coreGame.plantab == -1) || coreGame.EndGame.IsShown() || (coreGame.ParticipantsChanger._visible);
		if (htabs) {
			HideGameTabs();
			return;
		}
		gameTabs.ShowAllTabs();
		if (GetGameTab() == 2 || GetGameTab() == 3) subTabs.ShowAllTabs();
		if (!coreGame.SlaveDebugging) gameTabs.HideTab(1);

		if (coreGame.currentDialog != null) coreGame.currentDialog.SetGameTabs();
			
		if (coreGame.Plannings.IsStarted() || coreGame.IsEventHappening()) gameTabs.HideTab(0);
		if (coreGame.OtherSlaveShown || coreGame.IsEventHappening()) gameTabs.HideTab(4);
	
		if (coreGame.OtherSlaveShown || coreGame.currentShop != null) {
			gameTabs.HideTab(0);
			gameTabs.HideTab(5);			
		}
	}	
	
	public function ShowStatisticsTab(tab:Number) { SelectGameTab(tab); }
	
	private function HideDebugging() { coreGame.DebuggingMenu._visible = false; }
	
	public function GetGameTab() : Number { return gameTabs.GetCurrentTabIdx(); }
	public function IsGameTabShown(tab) { return IsShown() && gameTabs.IsShownTab(tab); }
	public function GetGameSubTab() : Number { return subTabs.GetCurrentTabIdx(); }
	public function GetCountGameTabsShown() : Number 
	{
		var tot:Number = 0;
		for (var i:Number = 1; i < 6; i++) {
			if (gameTabs.IsShownTab(i)) tot++;
		}
		return tot;
	}
	
	public function SelectPlanningTab(num:Number, oldnum:Number)
	{
		SystemMenu.Hide();
		HideDebugging();
		dspSlaveSkills.Hide();
		dspSlaveVitals.Hide();
		dspSlaveStats.Hide();
		dspSlaveMakerSkills.Hide();
		dspSlaveMakerVitals.Hide();
		dspSlaveMakerStats.Hide();				
		coreGame.PlanningSelections._visible = false;
		Language.LargerTextField._visible = false;
		
		if (!coreGame.Plannings.IsStarted()) {
			coreGame.DoPlanningButton();
			return;
		}
		if (coreGame.ParticipantsChanger._visible) {
			coreGame.DoLeaveButton();
			coreGame.ClearGeneralArray2();
		}
		subTabs.HideAllTabs();
		coreGame.StatTab = 6;
		if (coreGame.VisitMenu._visible && (coreGame.LendPerson == -1000 || coreGame.LendPerson == -1)) coreGame.LendPerson = 0;
		coreGame.PlanningSelections._visible = true;
		gameTabs.SelectTabUI(4);	
		
		Language.LargerTextField._visible = false;
		coreGame.PlanningSelections._visible = true;
		if (coreGame.plantab != -1) coreGame.Plannings.RedrawPlanningList();
		else coreGame.PlanningOrders.RedrawPlanningList();
	}
	
	public function UpdateGameTabs(num:Number, oldnum:Number)
	{
		if (num == undefined) num = GetGameTab();
		if (oldnum == undefined) oldnum = GetGameTab();
		HideHints();
		if (coreGame.ParticipantsChanger._visible) {
			coreGame.ParticipantsChanger._visible = false;
			coreGame.ClearGeneralArray2();
			coreGame.HideImages();
			coreGame.HideDresses();
			coreGame.HideAssistant();
			coreGame.SMAppearance._visible = false;
			coreGame.ShowSupervisor();
			ShowMainButtons();
			coreGame.ShowDress();
		}	
		
		SystemMenu.Hide();
		HideDebugging();
		dspSlaveSkills.Hide();
		dspSlaveVitals.Hide();
		dspSlaveStats.Hide();
		dspSlaveMakerSkills.Hide();
		dspSlaveMakerVitals.Hide();
		dspSlaveMakerStats.Hide();				
		coreGame.PlanningSelections._visible = false;
		coreGame.LargerTextField._visible = false;
		
		switch(num) {
			case 0: 
				// System Menu
				subTabs.HideAllTabs();
				mcStatImage._visible = false;
				coreGame.StatTab = 0;
				SystemMenu.ViewDialog();
				break;
				
			case 1:
				// Debug tab
				coreGame.StatTab = 7;
				mcStatImage._visible = false;
				coreGame.ShowDebugging();				
				break;
				
			case 2:
				// Slave
				subTabs.ShowAllTabs();				
				var sdata:Object = dspSlaveStats.sd;
				coreGame.PersonOtherName = sdata.SlaveName;
				coreGame.PersonOtherGender = sdata.SlaveGender;
				if (sdata == _root) coreGame.PersonOtherIndex = -50;
				else coreGame.PersonOtherIndex = sdata.SlaveIndex;
				coreGame.GetPersonOtherGenderText(sdata.GenderIdentity);
				
				if (coreGame.OtherSlaveShown || coreGame.currentShop != null) coreGame.UpdateSlaveCommon(sdata);

				var tb:TabBase = gameTabs.GetCurrentTab();
				if (tb != null) UpdateSubTabs(tb.idxChild == -1 ? 0 : tb.idxChild, 0)
				
				// Image
				UpdateSlaveStatImage(sdata);
				UpdateSubTabs();
				break;
				
			case 3:
				// Slave Maker
				subTabs.ShowAllTabs();
				var tb:TabBase = gameTabs.GetCurrentTab();
				if (tb != null) UpdateSubTabs(tb.idxChild == -1 ? 0 : tb.idxChild, 0)				
				
				if (coreGame.Options.StatImagesOn) {
			 
					if (SMData.SMSpecialEvent == 5 || SMData.SMSpecialEvent == 7) {
						mcStatImage.gotoAndStop(3);
						if (SMData.Corruption > 50) mcStatImage._alpha = 50;
						else mcStatImage._alpha = SMData.Corruption;
						mcStatImage._visible = true;
					} else if (SMData.SMSpecialEvent == 2 || SMData.SMSpecialEvent == 3) {
						mcStatImage._alpha = 30;
						mcStatImage.gotoAndStop(4);
						mcStatImage._visible = true;
					} else if (SMData.SMSpecialEvent == 4) {
						mcStatImage._alpha = 30;
						mcStatImage.gotoAndStop(5);
						mcStatImage._visible = true;
					} else if (SMData.SMAdvantages.CheckBitFlag(12) || SMData.SMHomeTown == 7) {
						mcStatImage._alpha = 30;
						if (SMData.Gender == 1) mcStatImage.gotoAndStop(12);
						else if (SMData.SMHomeTown == 7) mcStatImage.gotoAndStop(7);
						else mcStatImage.gotoAndStop(6);
						mcStatImage.Dickgirl._visible = SMData.Gender == 3;
						mcStatImage._visible = true;
					} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
						mcStatImage._alpha = 30;
						mcStatImage.gotoAndStop(8);
						mcStatImage._visible = true;
					} else if (SMData.SMAdvantages.CheckBitFlag(14)) {
						mcStatImage._alpha = 30;
						mcStatImage.gotoAndStop(9);
						mcStatImage._visible = true;
					} else if (SMData.SMHomeTown == 5) {
						mcStatImage._alpha = 30;
						mcStatImage.gotoAndStop(10);
						mcStatImage._visible = true;
					} else if (SMData.SMHomeTown == 6) {
						mcStatImage._alpha = 30;
						mcStatImage.gotoAndStop(11);
						mcStatImage._visible = true;
					} else mcStatImage._visible = false;
				}
				UpdateSubTabs();
				break;
				
			case 4:
				// Plannings
				subTabs.HideAllTabs();
				coreGame.StatTab = 6;
				mcStatImage._visible = false;
				if (coreGame.VisitMenu._visible && (coreGame.LendPerson == -1000 || coreGame.LendPerson == -1)) coreGame.LendPerson = 0;
				coreGame.PlanningSelections._visible = true;
				gameTabs.SelectTabUI(4);
				break;
				
			case 5:
				// Text
				subTabs.HideAllTabs();
				mcStatImage._visible = false;
				if (coreGame.ParticipantsChanger._visible) {
					coreGame.DoLeaveButton();
					coreGame.ClearGeneralArray2();
				}
				coreGame.StatTab = 5;
				Language.SetLargerText();
				Language.LargerTextField._visible = true;
				break;
		}
	}
	
	public function UpdateSubTabs(num:Number, oldnum:Number)
	{
		HideHints();
		var tb:TabBase = gameTabs.GetCurrentTab();
		if (tb == null) return;
		if (num == undefined) num = subTabs.GetCurrentTabIdx();
		tb.idxChild = num;
		
		var idxGame = tb.idx;
		switch(idxGame) {
			case 2:
				// Slave
				switch(num) {
					case 0:
						coreGame.StatTab = 1;
						dspSlaveSkills.Hide();
						dspSlaveVitals.Hide();
						dspSlaveStats.Show();
						break;
					case 1:
						coreGame.StatTab = 2;
						dspSlaveSkills.Hide();
						dspSlaveStats.Hide();						
						dspSlaveVitals.Show();
						break;
					case 2:
						dspSlaveStats.Hide();
						dspSlaveVitals.Hide();					
						dspSlaveSkills.Show();
						break;
				}		
				break;
				
			case 3:
				// Slave Maker
				UpdateSlaveMaker();
				switch(num) {
					case 0:
						coreGame.StatTab = 3;
						dspSlaveMakerSkills.Hide();
						dspSlaveMakerVitals.Hide();											
						dspSlaveMakerStats.Show();
						break;
					case 1:
						coreGame.StatTab = 4;
						dspSlaveMakerStats.Hide();					
						dspSlaveMakerSkills.Hide();						
						dspSlaveMakerVitals.Show();
						break;
					case 2:	
						dspSlaveMakerVitals.Hide();											
						dspSlaveMakerStats.Hide();					
						dspSlaveMakerSkills.Show();
						break;
				}
				break;
		}
	}
	
	public function UpdateSlaveStatImage(sdata:Object)
	{
		if (GetGameTab() != 2) return;

		// Image
		if (coreGame.Options.StatImagesOn) {
			mcStatImage._alpha = 30;
			if (sdata.IsPonygirl()) {
				if (sdata.BitFlag1.CheckBitFlag(95)) mcStatImage.gotoAndStop(14);
				else mcStatImage.gotoAndStop(2);
			} else if (sdata.IsCatgirl()) {
				if (sdata.BitFlag1.CheckBitFlag(95)) mcStatImage.gotoAndStop(16);
				else mcStatImage.gotoAndStop(1);
			} else if (sdata.IsPuppygirl()) mcStatImage.gotoAndStop(15);
			else if (sdata.BitFlag1.CheckBitFlag(95)) mcStatImage.gotoAndStop(13);
			mcStatImage._visible = (sdata.IsPuppygirl() || sdata.IsPonygirl() || sdata.IsCatgirl() || sdata.BitFlag1.CheckBitFlag(95));
		} else mcStatImage._visible = false;
	}
	
	public function Show()
	{
		StopHints();
		coreGame.VisitFortuneTeller._visible = false;
		Backgrounds.HideIntroBackground();
		coreGame.config.mcBGLayout._visible = true;
		coreGame.config.mcBGLayout._x = -1.5;
		coreGame.config.mcBGLayout._y = -1;
		mcBase.MainBackground.BGLayout._visible = true;
		mcBase.MainBackground._visible = true;
		mcCalendar._visible = true;
		mcBase._visible = true;
		
		mcBase.StatisticsBGTop._visible = true;
		coreGame.StatisticsBG._visible = true;
		Language.ShowGeneralText();
		Icons.Show();
		
		coreGame.GirlsStory._visible = false;
		coreGame.GirlsStoryTop._visible = false;
		coreGame.PersonHint._visible = true;
		coreGame.Cheat._visible = true;
		coreGame.GoldHint._visible = true;
		mcBase.MainWindowButton._visible = false;

		if (!Language.IsLargerTextShown()) Language.HideLargerText();
		if (coreGame.EndGame.IsShown()) {
			coreGame.mcEndGame.SaveButton._visible = false;
			coreGame.mcEndGame.LoadButton._visible = false;
			coreGame.mcEndGameMenu._visible = false;
			coreGame.SlaveMarketOverlay._visible = false;
			coreGame.EndGame.HideScore();
		}
		var bShn:Boolean = subTabs.IsShownTab(0);
		gameTabs.HideTab(1);
		if (bShn) {
			gameTabs.SelectTab(2);
			subTabs.SelectTab(0);
		} else subTabs.HideAllTabs();
	}
	
	public function Hide()
	{
		coreGame.SlavePurchase._visible = false;
		coreGame.SlaveMarketOverlay._visible = false;
		coreGame.Quitter._visible = false;
		coreGame.SlavePurchasePrevious._visible = false;
		coreGame.SlavePurchaseNext._visible = false;
		mcStatImage._visible = false;
		mcBase.MainWindowButton._visible = false;
		coreGame.ClipFortuneTelling._visible = false;
		coreGame.TakeAWalkMenu._visible = false;
		mcBase._visible = false;
		coreGame.StatisticsBG._visible = false;
		mcBase.StatisticsBGTop._visible = false;
		HideDebugging();
		
		if (dspSlaveStats != null) {
			coreGame.HideImages();
			dspSlaveStats.Hide();
			dspSlaveVitals.Hide();
			dspSlaveSkills.Hide();
			dspSlaveMakerStats.Hide();
			dspSlaveMakerVitals.Hide();
			dspSlaveMakerSkills.Hide();
		} else {
			coreGame.StatisticsGroup._visible = false;
			coreGame.SlaveVitalsGroup._visible = false;
			coreGame.SlaveSkillsGroup._visible = false;
			coreGame.SlaveMakerStatisticsGroup._visible = false;
			coreGame.SlaveMakerVitalsGroup._visible = false;
			coreGame.SlaveMakerSkillsGroup._visible = false;
			coreGame.mcIcons._visible = false;
		}
		
		coreGame.PersonHint._visible = false;
		coreGame.HideAllPeople();
		Icons.Hide();
		Language.HideGeneralText();
		Language.HideLargerText();
		
		Backgrounds.ShowIntroBackground();
	}
	
	public function ShowMainButtons(bKeepImages:Boolean)
	{
		if (coreGame.Plannings.IsStarted()) {
			coreGame.HideEquipmentButton();
			coreGame.HideSMEquipmentButton();
			coreGame.ShowPlanningNext();
			return;
		}
		if (coreGame.LendPerson != 0) {
			coreGame.DoThePlanning._visible = true;
		} else {
			if (IsDayTime()) coreGame.MorningButton._visible = true;
			else coreGame.EveningButton._visible = true;
			coreGame.PlanningButton._visible = true;
		}
		coreGame.IntroBackground._visible = false;
		EnableDiary();
		mcBase.StatisticsBGTop._visible = true;
		coreGame.Quitter._visible = false;
		coreGame.NextEvent._visible = false;
		coreGame.HidePlanningNext();
		
		if (bKeepImages != true) {
			coreGame.HideImages();
			coreGame.Sounds.StopAndFadeSounds();
			Backgrounds.HideBackgrounds();
			coreGame.Items.HideItems();		
			coreGame.HidePeople();
			coreGame.ShowDress();
		}
		ShowGameTabs();
		gameTabs.ShowTab(4);
		gameTabs.ShowTab(0);		
		PushGameTabs();
		mcBase.mcSave._visible = true;
		
		if (coreGame.MorningEveningMenu._visible) {
			if (coreGame.Home.HouseType == 5) Backgrounds.ShowDiningRoom(1);
			else Backgrounds.ShowDiningRoom(3);
			coreGame.ShowEquipmentButton();
			coreGame.ShowSMEquipmentButton();
		} else {
			coreGame.HideEquipmentButton();
			coreGame.HideSMEquipmentButton();
		}
	}
	
	public function HideMainButtons()
	{
		coreGame.DoThePlanning._visible = false;
		coreGame.MorningButton._visible = false;
		coreGame.EveningButton._visible = false;
		coreGame.PlanningButton._visible = false;
		mcBase.mcSave._visible = false;
		DisableDiary();
		SystemMenu.Hide();
	}
	
	public function ShowTabBackground(show:Boolean)
	{
		mcBase.StatisticsBGTop._visible = show == undefined ? true : show;
	}
	
	// Diary
	
	public function ViewDiary()
	{
		coreGame.currentDialog = new DialogTrainingLog(coreGame);
		coreGame.currentDialog.ViewDialog();
	}
	
	public function EnableDiary()
	{
		coreGame.mcDiaryMenu.isenabled = true;
		if (SMData.clrScheme.nCalendarIcon != 0) SetMovieColourARGB(mcCalendar, SMData.clrScheme.nCalendarIcon);
	}
	public function DisableDiary()
	{
		coreGame.mcDiaryMenu.isenabled = false;
		if (SMData.clrScheme.nCalendarIcon != 0) SetMovieColourARGB(mcCalendar, 0xE0E0E0);
	}	
	
	// Update contents of text fields
	
	public function UpdateTime()
	{
		mcBase.TimeText.text = coreGame.DecodeTimeMins(coreGame.GameTimeMins);
		mcBase.DateText.text = coreGame.DecodeDate(coreGame.GameDate);
	}
	
	public function UpdateMoney()
	{
		mcBase.GoldText.text = Math.ceil(coreGame.VarGold);
		mcBase.DebtText.text = Math.ceil(SMData.SMDebt);
	}
	
	public function UpdateOtherSlaveDetailsCommon(sd:Object)
	{
		if (sd == undefined) sd = _root;
		var sdo:Slave = SMData.GetSlaveObject(sd);
		coreGame.StatisticsGroup.sdata = sd;
		
		dspSlaveStats.UpdateOtherSlaveDetailsCommon(sd);
		dspSlaveVitals.UpdateOtherSlaveDetailsCommon(sd);
		
		Icons.UpdateIcons(sd);
		UpdateSlaveStatImage(sd);
		
		if (sd.PonyTailWorn == 1) coreGame.PlugType = "pony tail";
		else if (sd.CatTailWorn == 1) coreGame.PlugType = "cat tail";
		else if (sdo.ItemsWorn.CheckBitFlag(30)) coreGame.PlugType = "puppy tail";
		else coreGame.PlugType = "anal plug";
				
		if (sd.Path3 > sd.Path2 && sd.Path3 > sd.Path1) sd.MaxPath = 3;
		else if (sd.Path2 > sd.Path1 && sd.Path2 > sd.Path3) sd.MaxPath = 2;
		else if (sd.Path1 > sd.Path2 && sd.Path1 > sd.Path3) sd.MaxPath = 1;
		else sd.MaxPath = 0;
				
		if (sd != _root) return;

		if (coreGame.SoldSlave != undefined && coreGame.SoldSlave != coreGame.Owner.GetOwner()) coreGame.Owner.ChangeOwner(coreGame.SoldSlave);
	}

	
	public function UpdateSlaveVitals(sd:Object)
	{
		dspSlaveVitals.Update(sd);
	}
	
	public function UpdateSlaveMaker()
	{		
		SMData.LimitAllStats();
		SMData.CopySlaveMakerDetails(undefined, _root);
		coreGame.SMLibido = SMData.SMLust;
		
		dspSlaveMakerStats.Update();
		dspSlaveMakerVitals.Update();
		dspSlaveMakerSkills.Update();
	}
	
	public function HideStatChangeIcons() 
	{
		dspSlaveStats.HideStatChangeIcons();
		dspSlaveSkills.HideStatChangeIcons();		
		dspSlaveMakerStats.HideStatChangeIcons();
		dspSlaveMakerSkills.HideStatChangeIcons();
	}
	
	public function UpdateSlaveGender(sd:Object)
	{
		if (sd == undefined) sd = _root;
		
		var dg:Boolean = sd.IsDickgirl();
		var hc:Boolean = dg || sd.SlaveGender == 1 || sd.SlaveGender == 4;
		coreGame.HasCock = hc;
		
		Icons.ShowDickgirlIcon(sd);
		
		dspSlaveVitals.UpdateSlaveGender(dg, hc);
	}
	
	public function UpdateSlaveMakerGender()
	{
		dspSlaveMakerVitals.UpdateSlaveMakerGender();
	}
	
	// Sexuality
	public function UpdateSexuality(sex:Number)
	{
		dspSlaveVitals.UpdateSexuality(sex);
		Icons.UpdateIcons(dspSlaveStats.sd);
	}
	
	// Skills 
	
	public function SetSMSkills(sd:Object) { dspSlaveMakerSkills.SetSMSkills(sd);	}
	public function SetSexSkills(sd:Object) { dspSlaveSkills.SetSexSkills(sd); }
	public function UpdateSexSkills(sd:Object) { dspSlaveSkills.UpdateSexSkills(sd); }
	public function SetSlaveSkills(sd:Object) { dspSlaveSkills.SetSlaveSkills(sd); }
	public function UpdateBasicSlaveSkills(sd:Object) { dspSlaveSkills.UpdateBasicSlaveSkills(sd); }
	public function ShowSexSkillChangeIcon(skill:Number) { dspSlaveSkills.ShowSexSkillChangeIcon(skill); }

	// Statistics
	
	public function ShowSlaveMakerStatHint(stat:Number) { dspSlaveMakerStats.ShowStatHint(stat); }

	
	// Supervision
	public function ChangeSupervision(num:Number, oldnum:Number)
	{
		Beep();
		if (IsHints()) {
			if (num != 0) Language.SetLangText("SetAssistantSupervision", "Planning");
			else Language.SetLangText("SetPersonalSupervision", "Planning");
		}
		if (SMData.DaysUnavailable != 0 && num == 0) {
			Language.SetLangText("SMCannotSupervise", "Planning");
			return;
		} else if (coreGame.AssistantData.DaysUnavailable > 0) {
			Language.SetLangText("AssistantCannotSupervise", "Planning");
			return;
		} else if (coreGame.AssistantData.DaysUnavailable < 0) {
			Language.SetLangText("AssistantCannotSupervise2", "Planning");
			return;
		}
		UpdateSupervision(num == 0, false);
	}
	public function UpdateSupervision(superv:Boolean, ct:Boolean)
	{
		if (superv != undefined) coreGame.SuperviseYourself = superv; 
		trace("coreGame.SuperviseYourself = " + coreGame.SuperviseYourself);
		if (coreGame.ServantName == "" || coreGame.AssistantData.DaysUnavailable < 0) {
			superviseTabs.HideAllTabs();
			coreGame.SuperviseYourself = true;
			coreGame.PlanningSelections.LWhoSupervises._visible = false;
		} else {
			coreGame.PlanningSelections.LWhoSupervises._visible = true;
			if (ct != false) {
				superviseTabs.ShowAllTabs();
				if (coreGame.SuperviseYourself) superviseTabs.SelectTab(0);
				else superviseTabs.SelectTab(1);
			}
		}
		coreGame.PlanningSelections.LWhoSupervises.htmlText = Language.GetHtml("WhoSupervises", "Planning") + "\r\r";
	}
	
	public function SupervisionHints(num:Number)
	{
		if (num != 0) ShowHintLang("SetAssistantSupervision", "Planning");
		else ShowHintLang("SetPersonalSupervision", "Planning");
	}
	
	// Update theme of fields
	
	public function UpdateText(str:String, aNode:XMLNode)
	{	
		if (str == "Other") {
			mcBase.LGold.styleSheet = coreGame.styles;
			mcBase.LTime.styleSheet = coreGame.styles;
			mcBase.LDate.styleSheet = coreGame.styles;
			mcBase.LGold.htmlText = Language.GetHtml("Gold", aNode, true, -2);
			mcBase.LTime.htmlText = Language.GetHtml("Time", aNode, false, -1, "", " :");
			mcBase.LDate.htmlText = Language.GetHtml("Date", aNode, false, -1, "", " :");			
			return;
		}
		if (str == "Buttons") {	
			gameTabs.UpdateTabLabel(0, Language.GetHtml("System", aNode));
			gameTabs.UpdateTabLabel(1, Language.GetHtml("Debugging", aNode));			
			gameTabs.UpdateTabLabel(5, Language.GetHtml("Text", aNode));
			gameTabs.UpdateTabLabel(4, Language.GetHtml("Home", aNode));
			subTabs.UpdateTabLabel(0, Language.GetHtml("Stats", aNode));
			subTabs.UpdateTabLabel(1, Language.GetHtml("Vitals", aNode));
			subTabs.UpdateTabLabel(2, Language.GetHtml("Skills", aNode));			
			return;
		}
		if (str == "LoadSave") {	
			gameTabs.UpdateTabLabel(2, Language.GetHtml("Slave", aNode));
			gameTabs.UpdateTabLabel(3, Language.GetHtml("SlaveMaker", aNode));
			superviseTabs.UpdateTabLabel(0, Language.GetHtml("SlaveMaker", aNode));
			return;
		}		
		if (str == "Statistics") {
			dspSlaveStats.UpdateText(str, aNode);
			dspSlaveVitals.UpdateText(str, aNode);
			dspSlaveSkills.UpdateText(str, aNode);
			dspSlaveMakerStats.UpdateText(str, aNode);
			dspSlaveMakerVitals.UpdateText(str, aNode);
			dspSlaveMakerSkills.UpdateText(str, aNode);
		}
	}
	
	public function ApplyTheme(cvo:ColourScheme)
	{	
		dspSlaveStats.ApplyTheme(cvo);
		dspSlaveVitals.ApplyTheme(cvo);
		dspSlaveSkills.ApplyTheme(cvo);
		dspSlaveMakerStats.ApplyTheme(cvo);
		dspSlaveMakerVitals.ApplyTheme(cvo);
		dspSlaveMakerSkills.ApplyTheme(cvo);
		Icons.ApplyTheme(cvo);
		
		// Background colour
		SetMovieColourARGB(mcBase.MainBackground, cvo.nMainBackground);
		SetMovieColourARGB(coreGame.SlaveMarketOverlay, cvo.nMainBackground);
		
		// Text Background
		SetMovieColourARGB(mcBase.GeneralBackground, cvo.nGeneralTextBackground);		
		
		// Text Colour (Buttons)
		mcBase.SystemTab.LText.textColor = cvo.nTextColourTabSelected;
		mcBase.DebugTab.LText.textColor = cvo.nTextColourTabSelected;
		mcBase.SlaveTab.LText.textColor = cvo.nTextColourTabSelected;
		mcBase.SlaveMakerTab.LText.textColor = cvo.nTextColourTabSelected;
		mcBase.HomeTab.LText.textColor = cvo.nTextColourTabSelected;
		mcBase.TextTab.LText.textColor = cvo.nTextColourTabSelected;
		
		// Text Colour (General)
		mcBase.LGold.textColor = cvo.nTextColourGold;
		mcBase.GoldText.textColor = cvo.nTextColourGold;
		mcBase.LTime.textColor = cvo.nTextColourGold;
		mcBase.TimeText.textColor = cvo.nTextColourGold;
		mcBase.LDate.textColor = cvo.nTextColourDate;
		mcBase.DateText.textColor = cvo.nTextColourDate;
		
		// Icons
		if (cvo.nCalendarIcon != 0) SetMovieColourARGB(mcCalendar, cvo.nCalendarIcon);
		
		if (cvo.nIconBarIconColour != 0xffffff) {
			SetMovieColourARGB(mcBase.mcLoad, cvo.nIconBarIconColour);
			SetMovieColourARGB(mcBase.mcSave, cvo.nIconBarIconColour);
		}
		
		// Tabs
		// Tab Background
		var cv:Number =  cvo.nTabBackground;
		var red:Number = (cv >> 16) & 255;
		var green:Number = (cv >> 8) & 255;
		var blue:Number = cv & 255;
		
		SetMovieColourARGB(mcBase.StatisticsBGTop, cv);
		SetMovieColourARGB(coreGame.StatisticsBG, cv);
		gameTabs.UpdateTabColours(cv, cvo.nTabNotSelected, cvo.nTextColourTabSelected, cvo.nTextColourTabNotSelected);
		subTabs.UpdateTabColours(cvo.nSecondaryTabSelected, cvo.nSecondaryTabNotSelected, cvo.nTextColourTabSelected, cvo.nTextColourTabNotSelected);
		superviseTabs.UpdateTabColours(cvo.nSecondaryTabSelected, cvo.nSecondaryTabNotSelected, cvo.nTextColourTabSelected, cvo.nTextColourTabNotSelected);
		
		// Buttons
		SetMovieColour(coreGame.NextEvent, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.Quitter.Btn, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.NextEnding, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.NextGeneral, red, green, blue, 0, 1, 1, 1, 1, true);
				
		//		System
		var cNode:XMLNode = coreGame.config.GetNode("GameTabs/SystemTab/Icon");
		if (cNode != null) SetMovieColourARGB(mcBase.SystemTab.mcIcon, ColourScheme.GetColourValue(cNode));
		//		Debug
		cNode = coreGame.config.GetNode("GameTabs/DebugTab/Icon");
		if (cNode != null) SetMovieColourARGB(mcBase.DebugTab.mcIcon, ColourScheme.GetColourValue(cNode));
		// 		Slave
		cNode = coreGame.config.GetNode("GameTabs/SlaveTab/Icon");
		if (cNode != null) SetMovieColourARGB(mcBase.SlaveTab.mcIcon, ColourScheme.GetColourValue(cNode));
		//		SlaveMaker
		cNode = coreGame.config.GetNode("GameTabs/SlaveMakerTab/Icon");
		if (cNode != null) SetMovieColourARGB(mcBase.SlaveMakerTab.mcIcon, ColourScheme.GetColourValue(cNode));
		//		Home Tab
		cNode = coreGame.config.GetNode("GameTabs/HomeTab/Icon");
		if (cNode != null) SetMovieColourARGB(mcBase.HomeTab.mcIcon, ColourScheme.GetColourValue(cNode));
		//		Book Tab
		cNode = coreGame.config.GetNode("GameTabs/BookTab/Icon");
		if (cNode != null) SetMovieColourARGB(mcBase.TextTab.mcIcon, ColourScheme.GetColourValue(cNode));		

		Language.ApplyTheme(cvo);
		coreGame.MorningEvening.ApplyTheme(cvo);
		coreGame.SelectSMEquipment.ApplyTheme(cvo);
		coreGame.SelectEquipment.ApplyTheme(cvo);
		
		cv =  cvo.nActButtons;
		red = (cv >> 16) & 255;
		green = (cv >> 8) & 255;
		blue = cv & 255;
			
		SetMovieColour(coreGame.DiscussOrdinary, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.DiscussCongratulate, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.DiscussScold, red, green, blue, 0, 1, 1, 1, 1, true);
		
		SetMovieColour(coreGame.HouseEvents.mcBase.ExplorationTitle.MapView, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.SalonMenu.CustomerBtn, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.TailorMenu.CustomerBtn, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.PotionsMenu.DrinkerBtn, red, green, blue, 0, 1, 1, 1, 1, true);
		
		SetMovieColour(coreGame.PlanningSelections.ClearButton, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.PlanningSelections.SupervisionBtn, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.PlanningSelections.Set1, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.PlanningSelections.Set2, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.PlanningSelections.Set3, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.PlanningSelections.ParticipantsBtn, red, green, blue, 0, 1, 1, 1, 1, true);
					
		SetMovieColour(coreGame.ParticipantsChanger.ClearButton, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(coreGame.ParticipantsChanger.DefaultBtn, red, green, blue, 0, 1, 1, 1, 1, true);
		coreGame.ParticipantsChanger.Parties.setStyle("scrollTrackColor", (red * 65536) + (green * 256) + blue);
		coreGame.ParticipantsChanger.Slaves.setStyle("scrollTrackColor", (red * 65536) + (green * 256) + blue);	

	}
	
	// enable/disable
	public function Disable()
	{
		super.Disable();
		
		dspSlaveStats.Disable();
		dspSlaveVitals.Disable();
		dspSlaveSkills.Disable();
		dspSlaveMakerStats.Disable();
		dspSlaveMakerVitals.Disable();
		dspSlaveMakerSkills.Disable();
		
		mcBase.Cheat.enabled = false;
		mcBase.GoldHint.enabled = false;
		mcBase.DiaryButton.enabled = false;
		
		mcBase.MainWindowButton.enabled = false;
		
		SystemMenu.Disable();
	}
	
	public function Enable()
	{
		super.Enable();
		
		dspSlaveStats.Enable();
		dspSlaveVitals.Enable();
		dspSlaveSkills.Enable();
		dspSlaveMakerStats.Enable();
		dspSlaveMakerVitals.Enable();
		dspSlaveMakerSkills.Enable();

		mcBase.DiaryButton.enabled = true;
		mcBase.Cheat.enabled = true;
		mcBase.GoldHint.enabled = true;
		mcBase.MainWindowButton.enabled = true;
		
		SystemMenu.Enable();
	}
	
	public function Reset()
	{
		InitialiseModule();
		
		dspSlaveStats.InitialiseModule();
		dspSlaveVitals.InitialiseModule();
		dspSlaveSkills.InitialiseModule();
		dspSlaveMakerStats.InitialiseModule();
		dspSlaveMakerVitals.InitialiseModule();
		dspSlaveMakerSkills.InitialiseModule();
		
		UpdateTime();
		UpdateMoney();
	}
	
	// Shortcut keys
	// - keya is ascii version of keystroke
	// - key is the case insensitive version
	//   eg var keya:Number = key > 96 ? key - 32 : key;
	// - bControl is true if the Shift key is held down
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (coreGame.mcDiaryMenu.isenabled == true) {
			if (keya == 84) {
				ViewDiary();
				return true;
			}
		}
		if (SystemMenu.IsShown()) {
			if (SystemMenu.Shortcuts(keya, key, bControl)) return;
		}
		if (keya == 34 || keya == 33) {		// Page Up/Down
			if (keya == 34) coreGame.StatTab++;
			else coreGame.StatTab--;
			if (gameTabs.IsShownTab(1))  {
				if (coreGame.StatTab > 7) coreGame.StatTab = 0;
				else if (coreGame.StatTab < 0) coreGame.StatTab = 7;
			} else {
				if (coreGame.StatTab > 6) coreGame.StatTab = 0;
				else if (coreGame.StatTab < 0) coreGame.StatTab = 6;
			}
	
			SelectGameTab(coreGame.StatTab);
			return true;
		}
		return false;
	}

	
}