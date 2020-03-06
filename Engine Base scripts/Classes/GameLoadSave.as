// GameLoadSave - Load/Save
//
// Translation status: COMPLETE

import mx.controls.Alert;
import Scripts.Classes.*;

class GameLoadSave extends DialogBase {
		
	// use BaseModukke loading to tell if load/save screen
	public var nLoadSaveSet:Number;
	public var nQuickSlot:Number;
	
	private var bLoadingGame:Boolean;		// true if the game is loading
	private var bStartingGame:Boolean;		// true if the game is starting (ie the first slave)
	private var strLoadName:String;

	private var setTabs:TabGroup;
	
	// Constructor
	public function GameLoadSave(cg:Object)
	{ 
		super(cg.LoadSaveGames, cg);
		
		nLoadSaveSet = 0;
		nQuickSlot = 1;
		bLoadingGame = false;
		bStartingGame = false;
		strLoadName = "";
		
		var ti:GameLoadSave = this;
		
		InitSlot(mcBase.Game1Details);
		InitSlot(mcBase.Game2Details);
		InitSlot(mcBase.Game3Details);
		InitSlot(mcBase.Game4Details);
		InitSlot(mcBase.Game5Details);
		InitSlot(mcBase.Game6Details);
		InitSlot(mcBase.Game7Details);
		InitSlot(mcBase.Game8Details);
		InitSlot(mcBase.Game9Details);
		InitSlot(mcBase.Game10Details);
		InitSlot(mcBase.Game11Details);
		InitSlot(mcBase.Game12Details);
				
		mcBase.HelpButton.tabChildren = true;
		mcBase.HelpButton.Btn.onPress = function() {
			ti.coreGame.Information.ShowInformation(ti.Language.GetHtml("TurorialLoadSaveTitle", "Hints"), ti.Language.GetHtml("TurorialLoadSave", "Hints"));
		}
		mcBase.StorageButton.tabChildren = true;
		mcBase.StorageButton.Btn.onPress = function() {
			System.showSettings(1);
		}		

		mcBase.LeaveButton.tabChildren = true;
		mcBase.LeaveButton.Btn.onPress = function() {
			ti.LeaveDialog();
			ti.Beep();
		}
		
		setTabs = new TabGroup(coreGame, 0x66ccff, 0xe3e3e3, this, "UpdateLoadSaveSet");
		setTabs.AddTab(mcBase.SaveTab1, "<b>1-12</b>");
		setTabs.AddTab(mcBase.SaveTab2, "<b>13-24</b>");
		setTabs.AddTab(mcBase.SaveTab3, "<b>25-36</b>");
		setTabs.AddTab(mcBase.SaveTab4, "<b>37-48</b>");
		setTabs.AddTab(mcBase.SaveTab5, "<b>49-60</b>");
		setTabs.AddTab(mcBase.SaveTab6, "<b>61-72</b>");
		setTabs.AddTab(mcBase.SaveTab7, "<b>73-84</b>");
		setTabs.AddTab(mcBase.SaveTab8, "<b>85-96</b>");
		
		mcBase.AutoSaveButton.onPress = function() { ti.LoadGameString("auto"); }
	}
	
	// is the load in progress?
	public function IsLoading() { return bLoadingGame; }
	public function SetLoadingComplete() { bLoadingGame = false; strLoadName = ""; }
	
	public function SetLoadName(s:String) { strLoadName = s + ""; }
	public function GetLoadName() { return strLoadName; }

	// is a new game in progress?
	public function StartGame() { bStartingGame = true; }
	public function IsStartingGame() { return bStartingGame; }
	public function SetStartingGameComplete() { bStartingGame = false; SetLoadingComplete(); }
	
	// is the game playing, not loading or initialising
	public function IsGameInProgress() { return (!IsLoading()) && (!IsStartingGame()); }
	
	
	//
	// Load/Save Screen
	//
	public function ViewLoadScreen()
	{
		loading = true;
		ViewDialog();
	}
	public function ViewSaveScreen()
	{
		loading = false;
		ViewDialog();
	}
	
	public function ShowDialogContents()
	{
		Beep();
		if (coreGame.Language.IsLoaded()) ShowDialogContents2();
		else {
			Timers.AddTimer(
				setInterval(this, "ShowDialogContents2", 20, coreGame.Timers.GetNextTimerIdx(), true)
			)
		}
	}
	
	public function ShowDialogContents2(timer:Number)
	{
		if (coreGame.Language.IsLoaded() == false) return;
		Timers.RemoveTimer(timer);

		mcBase.LeaveButton.LText.htmlText = Language.GetHtml("Leave", "Buttons");
		mcBase.HelpButton.LText.htmlText = Language.GetHtml("Help", "Buttons");
		mcBase.StorageButton.LText.htmlText = Language.GetHtml("Storage", "Buttons");
		mcBase.AutoSaveLabel.htmlText = Language.GetHtml("LoadAutoSave", "Buttons");
		
		mcBase.ErrorMessage.text = "";
		if (loading) mcBase.LoadSaveLabel.htmlText = Language.GetHtml("LoadGame", "Buttons", true);
		else mcBase.LoadSaveLabel.htmlText = Language.GetHtml("SaveGame", "Buttons", true);
		mcBase.AutoSaveButton._visible = loading;
		mcBase.AutoSaveLabel._visible = loading;
		
		setTabs.SelectTab(nLoadSaveSet);
		
		StopHints();
		coreGame.DisableButtons();
		
		Enable();
		mcBase._x = 0;
		mcBase._visible = true;
	}

	public function LeaveDialog()
	{
		super.LeaveDialog();
		mcBase._x = 1200;
		coreGame.EnableButtons();
	}

	private function LoadSlot(mcslot:MovieClip, slot:Number)
	{
		mcslot.tabChildren = true;
		var oslot:Number = slot;
		slot = (nLoadSaveSet * 12) + slot;
		if (loading) mcslot.GameButton._width = 780;
		else mcslot.GameButton._width = 180;
		mcslot.slot = slot;
		var ti:GameLoadSave = this;
		if (mcslot.LComment.htmlText == "") {
			mcslot.LComment.htmlText = Language.GetHtml("Comment", "LoadSave", false, -1, "", ":");
			mcslot.LGameDate.htmlText = Language.GetHtml("GameDate", "LoadSave", false, -1, "", ":");
			mcslot.LSlaveMaker.htmlText = Language.GetHtml("SlaveMaker", "LoadSave", false, -1, "", ":");
			mcslot.LSlave.htmlText = Language.GetHtml("Slave", "LoadSave", false, -1, "", ":");
			mcslot.LSavedDate.htmlText = Language.GetHtml("SavedDate", "LoadSave", false, -1, "", ":");
			mcslot.LDeleteGame.htmlText = Language.GetHtml("DeleteGame", "Buttons");
			mcslot.LQuickSlot.htmlText = Language.GetHtml("QuickSlot", "Buttons");
			mcslot.LCity.htmlText = Language.GetHtml("City", "City", false, -1, "", ":");
			mcslot.LoadSave.Label.styleSheet = coreGame.styles;
			
			mcslot.QuickSlot.onPress = function() {
				ti.SetQuickSlot(this._parent.slot);
			}
		}
		mcslot.CommentText.type = loading ? "dynamic" : "input";
		mcslot.LoadSave.Label.htmlText = (loading ? Language.GetHtml("Load", "Buttons") : Language.GetHtml("Save", "Buttons")) + " " + slot;
		
		if (nQuickSlot == slot) SetMovieColour(mcslot.QuickButtonGraphic, 200, 200, 254, 0, 0, 0, 0);
		else SetMovieColour(mcslot.QuickButtonGraphic, 153, 153, 204, 0, 0, 0, 0);
		
		if (oslot < 10) mcslot.LoadSave.Shortcut.text = oslot;
		else mcslot.LoadSave.Shortcut.htmlText = String.fromCharCode(oslot + 55);
		var cookie:SharedObject = GetSaveData("sm"+slot);
		if (cookie.data.SlaveFilename == undefined) {
			mcslot.SlaveMakerText.htmlText = Language.GetHtml("Unused", "LoadSave");
			mcslot.GameDateText.htmlText = "";
			mcslot.SavedDateText.htmlText = "";
			mcslot.SlaveGirlText.htmlText = "";
			mcslot.CommentText.text = "";
			mcslot.CityText.text = "";
			mcslot.SMGenderIcon.gotoAndStop(1);
			mcslot.SMGenderIcon._visible = false;
			mcslot.SlaveGenderIcon.gotoAndStop(1);
			mcslot.SlaveGenderIcon._visible = false;
			
			SetMovieColour(mcslot.BG, 227, 227, 227);
			
			mcslot.GameButton.onPress = function() {
				if (!ti.loading) ti.SaveGame(this._parent.slot, this._parent.CommentText.text);
			}
			if (loading) return;
			
			mcslot.GameButton.onRollOver = function() { ti.SetMovieColour(this._parent, 40, 40, 40); }
			mcslot.GameButton.onRollOut = function() { ti.SetMovieColour(this._parent, 0, 0, 0); };
			
			return;
		}
		
		var nm:String
		var dt:Number = cookie.data.GameDate;
		if (dt == undefined) dt = cookie.data.vDate;
		var byr:Number = cookie.data.nBaseYear;
		var smgnd:Number = cookie.data.vGender;
		{
			var cookiesm:SharedObject = GetSaveData("sm"+slot+"slavemaker");
			nm = cookiesm.data.SlaveMakerName;
			if (nm == undefined) nm = cookiesm.data.vSlaveMakerName;
			if (dt == undefined) dt = cookiesm.data.vDate;
			smgnd = cookiesm.data.Gender;
			if (smgnd == undefined) smgnd = cookiesm.data.vGender;
		}
		var bAfter:Boolean = cookie.data.bAfterTraining;
		if (bAfter == undefined) {
			bAfter = true;
			var cookieslaves:SharedObject = GetSaveData("sm"+slot+"slaves");
			var len:Number = cookieslaves.data.SlavesArray.length;
			var sobj:Object;
			for (var isl:Number = 0; isl < len; isl++) {
				sobj = cookieslaves.data.SlavesArray[isl];
				if (sobj.SlaveType == -10) {
					bAfter = false;
					break;
				}
			}
		}
		mcslot.SlaveMakerText.htmlText = "<b>" + nm + "</b>";
		mcslot.SlaveGirlText.htmlText = "<b>" + cookie.data.SlaveName + "</b>";
		if (bAfter) mcslot.SlaveGirlText.htmlText += " (" + Language.GetHtml("After", "LoadSave") + ")";
		mcslot.GameDateText.htmlText = "<b>" + coreGame.DecodeDate(dt, byr) + "</b>";
		var sDate:Date = cookie.data.vSavedDate;
		mcslot.SavedDateText.htmlText = "<b>" + cookie.data.vSavedDate + "</b>";
		mcslot.SlaveGenderIcon._visible = true;
		var sgnd:Number = cookie.data.SlaveGender;
		if (sgnd > 3) sgnd -= 3;
		if (cookie.data.DickgirlXF > 0) sgnd = 3;
		mcslot.SlaveGenderIcon.gotoAndStop(sgnd);
		mcslot.SMGenderIcon._visible = true;
		mcslot.SMGenderIcon.gotoAndStop(smgnd);
		mcslot.CommentText.text = cookie.data.Comment == undefined ? "" : String(cookie.data.Comment);
		var strCity:String = "";
		{
			var cookiecity:SharedObject = GetSaveData("sm"+slot+"cities");
			var i:Number = cookiecity.data.Cities.length;
			if (i == undefined) strCity = "Mardukane";
			else {
				while (--i >= 0) {
					var cityo:Object = cookiecity.data.Cities[i];
					if (cityo.bCurrent) {
						var nm:String = cityo.CityName;
						if (nm == undefined) nm = "Mardukane";
						strCity = nm;
						break;
					}
				}
			}
		}
		mcslot.CityText.htmlText = "<b>" +strCity + "</b>";
		mcslot.GameDelete.onPress = function() {
			ti.DeleteGame(this._parent.slot);
		}
		mcslot.GameButton.onPress = function() {
			if (ti.loading) ti.LoadGame(this._parent.slot);
			else ti.SaveGame(this._parent.slot, this._parent.CommentText.text);
		}
		mcslot.GameButton.onRollOver = function() { ti.SetMovieColour(this._parent, 40, 40, 40); }
		mcslot.GameButton.onRollOut = function() { ti.SetMovieColour(this._parent, 0, 0, 0); };
		
		if ((slot % 2) == 0) SetMovieColour(mcslot.BG, 143, 224, 215);
		else SetMovieColour(mcslot.BG, 171, 239, 231);
	}
		
	private function InitSlot(slot:MovieClip)
	{		
		slot.SMGenderIcon.gotoAndStop(1);
		slot.SlaveGenderIcon.gotoAndStop(1);
	}
	
	
	public function DeleteGame(num:Number)
	{
		temp = num;
		Beep();
		
		//var errorMsg:Alert = mx.controls.Alert.show("Delete the game?", "Delete Game", Alert.YES | Alert.NO, null, DeleteAlertClickHandler, "", Alert.NO);
		var cookiec:SharedObject = GetSaveData("sm"+temp);
		//if (cookiec.data.SlaveFilename == undefined) cookiec = SharedObject.getLocal("sm"+temp);
		cookiec.clear();
		UpdateLoadSaveSet();
	}
	
	public function SetQuickSlot(num:Number)
	{
		nQuickSlot = num;
		UpdateLoadSaveSet();
	}
		
	// LoadSave Set
	
	public function UpdateLoadSaveSet(pset:Number)
	{
		if (pset != undefined) {
			if (pset > 7) pset = 0;
			else if (pset < 0) pset = 7;
			nLoadSaveSet = pset;
		}
			
		LoadSlot(mcBase.Game1Details, 1);
		LoadSlot(mcBase.Game2Details, 2);
		LoadSlot(mcBase.Game3Details, 3);
		LoadSlot(mcBase.Game4Details, 4);
		LoadSlot(mcBase.Game5Details, 5);
		LoadSlot(mcBase.Game6Details, 6);
		LoadSlot(mcBase.Game7Details, 7);
		LoadSlot(mcBase.Game8Details, 8);
		LoadSlot(mcBase.Game9Details, 9);
		LoadSlot(mcBase.Game10Details, 10);
		LoadSlot(mcBase.Game11Details, 11);
		LoadSlot(mcBase.Game12Details, 12);
		
		coreGame.Options.SaveOnlyGlobalData();
	}
		
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (!loading) {
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game1Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game2Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game3Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game4Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game5Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game6Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game7Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game8Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game9Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game10Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game11Details.CommentText") return false;
			if (Selection.getFocus() == "_level0.LoadSaveGames.Game12Details.CommentText") return false;
		}
		if (keya > 48 && keya < 59) {
			var save:Number = (nLoadSaveSet * 12) + keya - 48;
			if (loading) LoadGame(save);
			else SaveGame(save);
			return true;
		} else if (keya > 64 && keya < 68) {
			var save:Number = (nLoadSaveSet * 12) + keya - 55;
			if (loading) LoadGame(save);
			else SaveGame(save);
			return true;
		}
		return false;
	}

	// Save Game

	function SaveGame(nGameNo:Number, comment:String)
	{
		SaveGameString("sm" + nGameNo, comment);
	}
	
	function SaveGameString(strGameNo:String, comment:String)
	{
		SetLoadName(strGameNo);
		
		clearInterval(coreGame.intervalId);
		if (comment == undefined) comment = "";
		Beep();
		if (mcBase._visible) LeaveDialog();
		var oldcomment:String = "";
	
		{
			var cookiec:SharedObject = GetSaveData(GetLoadName());
			delete oldcomment;
			oldcomment = new String(cookiec.data.Comment);
			if (cookiec.data.Comment == undefined) oldcomment = "";
			cookiec.clear();
			cookiec = null;
		}
		var sfailed:Boolean = false;
		var cookie:SharedObject = GetSaveData(GetLoadName());	
		cookie.clear();
		
		// General save information
		cookie.data.vSavedDate = Date(Date.UTC()).valueOf();
		cookie.data.Comment = comment;
		if (comment == "") cookie.data.Comment = oldcomment;
		
		// slave details
		cookie.data.SlaveName = coreGame.SlaveName + "";
		cookie.data.SlaveGender = coreGame.SlaveGender;
		cookie.data.SlaveFilename = coreGame.SlaveFilename + "";
		cookie.data.bAfterTraining = SMData.GetSlaveBeingTrained() == null;
		
		coreGame.slaveData.CopyCommonDetails(_root);
			
		cookie.data.BadGirl = coreGame.BadGirl;
		cookie.data.PlugInserted = coreGame.PlugInserted;
		cookie.data.WinContest = coreGame.WinContest;
		cookie.data.Behaving = coreGame.Behaving;
		
		cookie.data.vNumDaysWithoutFuck = coreGame.NumDaysWithoutFuck;
		cookie.data.vNumBlowjobSinceFucked = coreGame.NumBlowjobSinceFucked;
		cookie.data.vNumTitsFuckSinceFucked = coreGame.NumTitsFuckSinceFucked;
		cookie.data.vNumLickSinceFucked = coreGame.NumLickSinceFucked;
		cookie.data.vNumTouchSinceFucked = coreGame.NumTouchSinceFucked;
		cookie.data.vNumAnalSinceFucked = coreGame.NumAnalSinceFucked;
		cookie.data.vNumMasturbateSinceFucked = coreGame.NumMasturbateSinceFucked;
		
		cookie.data.vDoneNaked = coreGame.DoneNaked;
		cookie.data.vDonePlug = coreGame.DonePlug;
		cookie.data.vLastActionRefused = coreGame.LastActionRefused;
		cookie.data.vLastActionDone = coreGame.LastActionDone;
		cookie.data.vLendPerson = coreGame.LendPerson;
	
		// date/time 
		cookie.data.GameTimeMins = coreGame.GameTimeMins;
		cookie.data.MoonPhaseDate = coreGame.MoonPhaseDate;
		cookie.data.GameDate = coreGame.GameDate;
		cookie.data.nBaseYear = coreGame.currentCity.nBaseYear;
		cookie.data.Nocturnal = coreGame.IsNocturnal();	
		cookie.data.vTrainingTime = coreGame.TrainingTime;
		
		// planning and actions
		cookie.data.vSuperviseYourself = coreGame.SuperviseYourself;
		cookie.data.vPlanningSet = coreGame.PlanningSet;
		cookie.data.vChkSameListDay = coreGame.PlanningSelections.ChkSameListDay.selected;
		cookie.data.vChkSameListNight = coreGame.PlanningSelections.ChkSameListNight.selected;
		cookie.data.dateLastChangedAssistant = coreGame.dateLastChangedAssistant;
		
		cookie.data.vShowCustomJob1 = coreGame.ShowCustomJob1;
		cookie.data.vShowCustomJob2 = coreGame.ShowCustomJob2;
		cookie.data.vShowCustomJob3 = coreGame.ShowCustomJob3;
		cookie.data.vShowCustomSchool1 = coreGame.ShowCustomSchool1;
		cookie.data.vShowCustomSchool2 = coreGame.ShowCustomSchool2;
		cookie.data.vShowCustomSchool3 = coreGame.ShowCustomSchool3;
		cookie.data.vShowCustomChore1 = coreGame.ShowCustomChore1;
		cookie.data.vShowCustomChore2 = coreGame.ShowCustomChore2;
		cookie.data.vShowCustomChore3 = coreGame.ShowCustomChore3;
		cookie.data.vShowCustomSex1 = coreGame.ShowCustomSex1;
		cookie.data.vShowCustomSex2 = coreGame.ShowCustomSex2;
		cookie.data.vShowCustomSex3 = coreGame.ShowCustomSex3;
		cookie.data.vShowCustomSex4 = coreGame.ShowCustomSex4;
			
		cookie.data.vLectures = coreGame.Lectures;
		cookie.data.vAnySex = coreGame.AnySex;
		cookie.data.vAnyNonSex = coreGame.AnyNonSex;
		cookie.data.vLastAny = coreGame.LastAny;	
		
		SavePlannings(cookie);
		
		delete cookie.data.ActInfoBase;
		cookie.data.ActInfoBase = new Object();
		coreGame.slaveData.ActInfoBase.Save(cookie.data.ActInfoBase);
		
		//Servant		
		cookie.data.vServantName = coreGame.ServantName + "";
		cookie.data.vServantFilename = coreGame.ServantFilename + "";
		
		// people
		cookie.data.vNumMerchant = coreGame.NumMerchant;	
		
		cookie.data.People = new Object();
		coreGame.modulesList.People.SaveGame(cookie.data.People);
		
		// Other
		cookie.data.vTotalScrolls =  coreGame.TotalScrolls;
		cookie.data.vTotalScripture = coreGame.TotalScripture;
		cookie.data.vTotalKamasutra = coreGame.TotalKamasutra;
		
		cookie.data.Rules = new Object();
		coreGame.Rules.Save(cookie.data.Rules);
		
		cookie.data.vLastVisitDickgirl = coreGame.LastVisitDickgirl;
		cookie.data.vAntidoteDays = coreGame.AntidoteDays;
		
		cookie.data.vVarGold = coreGame.VarGold;
	
		// game specific options
		cookie.data.vDickgirlFrequency = coreGame.DickgirlFrequency;
		cookie.data.vTentacleHaunt = coreGame.TentacleHaunt;
		cookie.data.vTentacleFrequency = coreGame.TentacleFrequency;

		cookie.data.vTentaclesOn = coreGame.TentaclesOn;
		cookie.data.vDickgirlOn = coreGame.DickgirlOn;
		cookie.data.vAllDickgirlXFOn = coreGame.AllDickgirlXFOn ? 1 : 0;
		cookie.data.vRapeOn = coreGame.RapeOn ? 1 : 0;
		cookie.data.vBDSMOn = coreGame.BDSMOn ? 1 : 0;
		
		cookie.data.vDifficulty = coreGame.Difficulty;
		cookie.data.vCombatDifficulty = coreGame.CombatDifficulty;
		
		cookie.data.vSandboxMode = coreGame.SandboxMode;
	
	
		trace("saving cities");
		{
			var cookiecity:SharedObject = GetSaveData(GetLoadName() + "cities");
			coreGame.citiesList.Save(cookiecity.data);
		}
		
		trace("saving: slavemaker");
		{
			var cookiesm:SharedObject = GetSaveData(GetLoadName() + "slavemaker");
			cookiesm.clear();
			sfailed = SMData.Save(cookiesm.data, GetLoadName());
			if (cookiesm.flush() == "pending") sfailed = true;
		}
		
		{
			var cookiecustom:SharedObject = GetSaveData(GetLoadName() + "custom");
			coreGame.modulesList.SaveGame(cookiecustom.data);
			
			if (cookiecustom.flush() == "pending") sfailed = true;
			cookiecustom = null;
		}
	
		var ret:Object = cookie.flush();
		if (ret == "pending" || sfailed) coreGame.intervalId = setInterval(this, "SaveGameString", 2000, comment);
		else if (GetLoadName() != "auto") {
			if (ret == true) SetText(strReplace(Language.GetHtml("Saved", "LoadSave"), "#value", GetLoadName()));
			else SetText(strReplace(Language.GetHtml("SaveFailed", "LoadSave"), "#value", GetLoadName()));
			BlankLine();
		}
		SetLoadName("");
	}
		

	public function SavePlannings(cookie:SharedObject)
	{
		delete cookie.data.Plannings;
		cookie.data.Plannings = new Object();
		coreGame.Plannings.Save(cookie.data.Plannings);
		delete cookie.data.SavedDayPlannings1;
		cookie.data.SavedDayPlannings1 = new Object();
		coreGame.SavedDayPlannings1.Save(cookie.data.SavedDayPlannings1);
		delete cookie.data.SavedDayPlannings2;
		cookie.data.SavedDayPlannings2 = new Object();
		coreGame.SavedDayPlannings2.Save(cookie.data.SavedDayPlannings2);
		delete cookie.data.SavedDayPlannings3;
		cookie.data.SavedDayPlannings3 = new Object();
		coreGame.SavedDayPlannings3.Save(cookie.data.SavedDayPlannings3);
		delete cookie.data.SavedNightPlannings1;
		cookie.data.SavedNightPlannings1 = new Object();
		coreGame.SavedNightPlannings1.Save(cookie.data.SavedNightPlannings1);
		delete cookie.data.SavedNightPlannings2;
		cookie.data.SavedNightPlannings2 = new Object();
		coreGame.SavedNightPlannings2.Save(cookie.data.SavedNightPlannings2);
		delete cookie.data.SavedNightPlannings3;
		cookie.data.SavedNightPlannings3 = new Object();
		coreGame.SavedNightPlannings3.Save(cookie.data.SavedNightPlannings3);
	}

	
	//
	// Load Game
	//
	public function LoadGame(nGameNo:Number)
	{
		LoadGameString("sm" + nGameNo);
	}
	
	public function LoadGameString(strGame:String)
	{
		bLoadingGame = true;
		bStartingGame = false;
		SetLoadName(strGame);
		
		trace("LoadGameString: " + GetLoadName());
	
		var cookie:SharedObject = GetSaveData(GetLoadName());
		if (cookie.data.SlaveName == undefined) {
			if (mcBase._visible) mcBase.ErrorMessage.text = "Load Failed - Save Game does not exist";
			else SetText("Load Failed\rSave Game does not exist");
			return;
		}
		coreGame.DisableButtons();
		delete coreGame.oldfileAssistant;
		coreGame.oldfileAssistant = new String(coreGame.ServantFilename);
		var oldfile:String = new String(coreGame.SlaveFilename);
		coreGame.ClearGeneralArray();
		coreGame.ClearGeneralArray2();
		coreGame.ResetSlave();
		coreGame.ResetSlaveMaker();
		coreGame.ResetGame();
		coreGame.TitleScreen.Introduction = 0;
		coreGame.EndGame.Reset();
		SMData = coreGame.SMData;
		Backgrounds.LoadModule("");
		
		var mc:MovieClip;
		for (var mcs:String in coreGame.arLoadedMovieArray) {
			mc = MovieClip(coreGame.arLoadedMovieArray[mcs]);
			if (mc != _root) {
				mc.stop();
				mc._visible = false;
			}
		}
	
		coreGame.Sounds.StopAllSounds(true);
		coreGame.modulesList.HideImages();
	
			
		coreGame.SlaveGirl.Destroy();
		if (coreGame.SlaveFilename != "" && oldfile != coreGame.SlaveFilename) coreGame.ResetActImages();
	
		CleanSaveGame(cookie.data);
		
		coreGame.GameTimeMins = cookie.data.GameTimeMins;
		coreGame.UpdateTime();
		coreGame.SuperviseYourself = cookie.data.vSuperviseYourself;
		coreGame.PlanningSet = cookie.data.vPlanningSet;
		coreGame.PlanningSelections.ChkSameListDay.selected = cookie.data.vChkSameListDay;
		coreGame.PlanningSelections.ChkSameListNight.selected = cookie.data.vChkSameListNight;
		coreGame.dateLastChangedAssistant = cookie.data.dateLastChangedAssistant;
		
		coreGame.People.Load(cookie.data.People);
		
		coreGame.ServantName = cookie.data.vServantName;
		coreGame.ServantFilename = cookie.data.vServantFilename;
		
		coreGame.Rules.Load(cookie.data.Rules);
		coreGame.Rules.Save(coreGame);			// to be deleted
		
		coreGame.NumMerchant = cookie.data.vNumMerchant;
	
		coreGame.Lectures = cookie.data.vLectures;
		
		coreGame.ShowCustomJob1 = cookie.data.vShowCustomJob1;
		coreGame.ShowCustomJob2 = cookie.data.vShowCustomJob2;
		coreGame.ShowCustomJob3 = cookie.data.vShowCustomJob3;
		coreGame.ShowCustomSchool1 = cookie.data.vShowCustomSchool1;
		coreGame.ShowCustomSchool2 = cookie.data.vShowCustomSchool2;
		coreGame.ShowCustomSchool3 = cookie.data.vShowCustomSchool3;
		coreGame.ShowCustomChore1 = cookie.data.vShowCustomChore1;
		coreGame.ShowCustomChore2 = cookie.data.vShowCustomChore2;
		coreGame.ShowCustomChore3 = cookie.data.vShowCustomChore3;
		coreGame.ShowCustomSex1 = cookie.data.vShowCustomSex1;
		coreGame.ShowCustomSex2 = cookie.data.vShowCustomSex2;
		coreGame.ShowCustomSex3 = cookie.data.vShowCustomSex3;
		coreGame.ShowCustomSex4 = cookie.data.vShowCustomSex4;
	
		coreGame.LastAny = cookie.data.vLastAny;
		coreGame.AnySex = cookie.data.vAnySex;
		coreGame.AnyNonSex = cookie.data.vAnyNonSex;
			
		coreGame.TotalScrolls = cookie.data.vTotalScrolls;
		coreGame.TotalScripture = cookie.data.vTotalScripture;
		coreGame.TotalKamasutra = cookie.data.vTotalKamasutra;
		
		coreGame.LastVisitDickgirl = cookie.data.vLastVisitDickgirl;
		coreGame.AntidoteDays = cookie.data.vAntidoteDays;
		
		coreGame.TentacleHaunt = cookie.data.vTentacleHaunt;
		coreGame.TentaclesOn = cookie.data.vTentaclesOn;
		coreGame.TentacleFrequency = cookie.data.vTentacleFrequency;
		
		coreGame.DickgirlOn = cookie.data.vDickgirlOn;
		coreGame.AllDickgirlXFOn = (cookie.data.vAllDickgirlXFOn == 1);
		coreGame.DickgirlFrequency = cookie.data.vDickgirlFrequency;
	
		coreGame.RapeOn = (cookie.data.vRapeOn != 0);
		coreGame.BDSMOn = (cookie.data.vBDSMOn != 0);
	
		coreGame.Difficulty = cookie.data.vDifficulty;
		coreGame.CombatDifficulty = cookie.data.vCombatDifficulty;
		coreGame.SandboxMode = cookie.data.vSandboxMode;
		
		coreGame.VarGold = cookie.data.vVarGold;
		
		coreGame.MoonPhaseDate = cookie.data.MoonPhaseDate;
		coreGame.GameDate = cookie.data.GameDate;
	
		trace("loading cities");
		{
			var cookiecity:SharedObject = GetSaveData(GetLoadName()+"cities");
			
			coreGame.Home = null;
			coreGame.citiesList.Load(cookiecity.data, cookie.data);
		}
		Timers.AddTimer(
			setInterval(this, "LoadGameString2", 20, cookie, oldfile, coreGame.Timers.GetNextTimerIdx(), true)
		)
	}
		
	public function LoadGameString2(cookie:SharedObject, oldfile:String, idx:Number)
	{
		if (coreGame.citiesList.IsLoading()) return;
		Timers.RemoveTimer(idx);
		
		trace("loading: slavemaker");
		{
			// Load slave maker details
			var cookiesm:SharedObject = GetSaveData(GetLoadName()+"slavemaker");
			SMData.Load(cookiesm.data, GetLoadName());
			if (cookiesm.data.Home != undefined) coreGame.currentCity.Home.Load(cookiesm.data.Home);
		}
		coreGame.SMAvatar.ResetList(SMData);
		
		if (cookie.data.Nocturnal != undefined) coreGame.SetNocturnal(cookie.data.Nocturnal);
		else if (SMData.SMAdvantages.CheckBitFlag(13)) coreGame.SetNocturnal(true);
		
		// Slave
		// set current slave reference variables
		coreGame.SlaveFilename = cookie.data.SlaveFilename;
		trace("loading: " + coreGame.SlaveFilename);
	
		if (SMData.GetSlaveBeingTrained() != null) {
			trace("slave being trained");
			coreGame.slaveData = SMData.GetSlaveBeingTrained();
			coreGame.SlaveData = coreGame.slaveData;		// obsolete
			coreGame.BitFlag1 = coreGame.slaveData.BitFlag1;
			coreGame.BitFlag2 = coreGame.slaveData.BitFlag2;
			coreGame.DemonFlags = coreGame.slaveData.DemonFlags;
			if (coreGame.slaveData.ItemsOwned == null) coreGame.slaveData.ItemsOwned = new BitFlags();
			if (coreGame.slaveData.ItemsWorn == null) coreGame.slaveData.ItemsWorn = new BitFlags();
	
			if (coreGame.slaveData.Owner == null) coreGame.slaveData.Owner = new PersonOwner(coreGame, slaveData);
			coreGame.Owner = coreGame.slaveData.Owner;
			//if (cookie.data.SoldSlave != undefined) coreGame.Owner.ChangeOwner(cookie.data.SoldSlave);
				
			if (cookie.data.SpeechSuffix != undefined) {
				coreGame.slaveData.CopyCommonDetails(cookie.data, _root);
				coreGame.slaveData.CopyCommonDetails(_root);
			} else coreGame.slaveData.CopyCommonDetails(slaveData, _root);
			
			coreGame.slaveData.ActInfoBase.Load(cookie.data.ActInfoBase);
			coreGame.slaveData.ActInfoBase.ActFolder = ImageFolder;
			coreGame.slaveData.ActInfoCurrent = slaveData.ActInfoBase;
			coreGame.SetActButtonDetailsStartup();
	
			coreGame.NumDaysWithoutFuck = cookie.data.vNumDaysWithoutFuck;
			coreGame.NumBlowjobSinceFucked = cookie.data.vNumBlowjobSinceFucked;
			coreGame.NumTitsFuckSinceFucked = cookie.data.vNumTitsFuckSinceFucked;
			coreGame.NumLickSinceFucked = cookie.data.vNumLickSinceFucked;
			coreGame.NumTouchSinceFucked = cookie.data.vNumTouchSinceFucked;
			coreGame.NumAnalSinceFucked = cookie.data.vNumAnalSinceFucked;
			coreGame.NumMasturbateSinceFucked = cookie.data.vNumMasturbateSinceFucked;
			
			coreGame.PlugInserted = cookie.data.PlugInserted;
			coreGame.WinContest = cookie.data.WinContest;
			coreGame.Behaving = cookie.data.Behaving;
			coreGame.LastActionDone = cookie.data.vLastActionDone;
			coreGame.LastActionRefused = cookie.data.vLastActionRefused;
			coreGame.DoneNaked = cookie.data.vDoneNaked;
			coreGame.DonePlug = cookie.data.vDonePlug;
			coreGame.BadGirl = cookie.data.BadGirl;
			coreGame.LendPerson = cookie.data.vLendPerson;
			
			coreGame.TrainingTime = cookie.data.vTrainingTime;
			
			coreGame.DaysUnavailable = coreGame.slaveData.DaysUnavailable;
			coreGame.Plannings.Reset(coreGame.slaveData);
			coreGame.Plannings.LoadActions(cookie.data.Plannings, true);
	
		} else coreGame.slaveData = null;
						
		coreGame.SavedDayPlannings1.LoadFrom(cookie.data.SavedDayPlannings1);
		coreGame.SavedDayPlannings2.LoadFrom(cookie.data.SavedDayPlannings2);
		coreGame.SavedDayPlannings3.LoadFrom(cookie.data.SavedDayPlannings3);
		coreGame.SavedNightPlannings1.LoadFrom(cookie.data.SavedNightPlannings1);
		coreGame.SavedNightPlannings2.LoadFrom(cookie.data.SavedNightPlannings2);
		coreGame.SavedNightPlannings3.LoadFrom(cookie.data.SavedNightPlannings3);
		
		// time adjustments
		if (coreGame.IsSexPlanningTime()) coreGame.oldplantab = 4;
		else coreGame.oldplantab = 0;
		
		if (SMData.GetSlaveBeingTrained() == null) {
			
			trace("Loading between slaves");
			SetText("");
			coreGame.HideAllImages();
			coreGame.NumFin = 9100;
			// create/show end game menu
			coreGame.EndGame.ShowMenu();
			
		} else {
		
			coreGame.UpdateSlaveMaker();
			SetGeneralText(strReplace(Language.GetHtml("Loaded", "LoadSave"), "#value", GetLoadName()) + "\r\r");
			coreGame.IntroPage++;
			if (oldfile == coreGame.SlaveFilename || coreGame.SlaveFilename == "") {
				trace("re-loading slave name: " + coreGame.SlaveFilename);
				Language.ChangeLanguage();
				coreGame.ResumeGame();
			} else {
				trace("loading slave name: " + coreGame.SlaveFilename);
				if (!Backgrounds.IsLoaded()) Backgrounds.ShowArena();
				coreGame.ShowMovie(coreGame.OnTopOverlay, 12, 0);
				Language.ChangeLanguage();
				Backgrounds.ShowIntroBackgroundWhite(true);
				coreGame.CurrentAssistant.DestroyAsAssistant();
				coreGame.CurrentAssistant = null;
				coreGame.modulesList.CurrentAssistant = null;
				coreGame.SlaveMovie.unloadMovie();
				coreGame.mcLoader.removeListener(coreGame.mclListener);
				coreGame.mclListener.onLoadInit = coreGame.ResumeGame;
				coreGame.mcLoader.addListener(coreGame.mclListener);
				if (coreGame.SlaveFilename.indexOf(".xml") != -1) coreGame.ResumeGame();
				else coreGame.mcLoader.loadClip(coreGame.SlaveFilename, coreGame.SlaveMovie);
			}
		}
		delete oldfile;

	}
	
	
	//
	// Utility functions
	//
	public function CleanSaveGame(so:Object)
	{
		for (var mv:String in so) {
			if (typeof(so[mv]) == "number") {
				if (isNaN(so[mv])) so[mv] = 0;
			} else if (typeof(so[mv]) == "string") {
				if (so[mv] == undefined) so[mv] = "";
			}
		}	
	}

	public function UpgradeSlaveMakerSave(so:Object, sm:Object)
	{		
		if (sm.Appearance == undefined) sm.Appearance = so.vAppearance;
		if (sm.ArmourOwned == undefined) sm.ArmourOwned = so.vArmourOwned;
		if (sm.WeaponOwned == undefined) sm.WeaponOwned = so.vWeaponOwned;
		if (sm.SMFeeldoOK == undefined) sm.SMFeeldoOK = false;
		if (sm.TotalBooks == undefined) {
			sm.TotalBooks = so.vTotalBooks;
			sm.TotalPoetry = so.vTotalPoetry;
			if (sm.TotalBooks == undefined) {
				sm.TotalBooks = 0;
				sm.TotalPoetry = 0;
			}
		}
		if (sm.NumDealer == undefined) sm.NumDealer = 0;
		if (sm.PuppygirlsTrained == undefined) sm.PuppygirlsTrained = 0;
		if (sm.GenderIdentity == undefined) sm.GenderIdentity = sm.Gender;
	
		if (so.vSlaveMakerName == undefined) return;
		
		// 3.2.06 to 3.3 upgrade
		sm.SlaveMakerName = so.vSlaveMakerName;
		sm.Gender = so.vGender;
		sm.OldGender = so.vOldGender;
		
		sm.ArmourType = so.vArmourType;
		sm.WeaponType = so.vWeaponType;
		sm.SilkenRopesOK = so.SilkenRopesOK;
		sm.Talent = so.vTalent;
		sm.SpecialEventProgress = so.vTalentProgress;
		sm.SMHomeTown = so.vSMHomeTown;
		sm.SMSpecialEvent = so.vSMSpecialEvent;
		sm.Corruption = so.vCorruption;
		sm.SMMinCorruption = so.vSMMinCorruption;
		sm.SMLust = so.vSMLust;
		sm.SMMinLust = so.vSMMinLust;
		sm.SMConstitution = so.vSMConstitution;
		sm.SMAttack = so.vSMAttack;
		sm.SMDefence = so.vSMDefence;
		sm.SMConversation = so.vSMConversation;
		sm.SMReputation = so.vSMReputation;
		sm.SMDominance = so.vSMDominance;
		sm.SMCharisma = so.vSMCharisma;
		sm.SMRefinement = so.vSMRefinement;
		sm.SMNymphomania = so.vSMNymphomania;
		sm.SMTiredness = so.vSMTiredness;
		if (sm.SexualEnergy == undefined) sm.SexualEnergy = 0;
	
		sm.SMTotalTentaclePregnancy = so.vSMTotalTentaclePregnancy;
		
		sm.ArousalDefence = so.vArousalDefence;
		sm.TheologyTraining = so.vTheologyTraining;
		sm.SMFaith = so.vSMFaith;
		sm.GirlsTrained = so.vGirlsTrained;
		sm.PonygirlsTrained = so.vPonygirlsTrained;
		sm.LesbiansTrained = so.vLesbiansTrained;
		sm.CatgirlsTrained = so.vCatgirlsTrained;
		sm.DickgirlsTrained = so.vDickgirlsTrained;
		sm.SlutsTrained = so.vSlutsTrained;
		sm.CumslutsTrained = so.vCumslutsTrained;
		if (sm.CumslutsTrained == undefined) sm.CumslutsTrained = 0;
		sm.SuccubusesTrained = so.SuccubusesTrained;
		if (sm.SuccubusesTrained == undefined) sm.SuccubusesTrained = 0;
			
		sm.TotalSMBar = so.vTotalSMBar;
		sm.TotalSMSleazyBar = so.vTotalSMSleazyBar;
		sm.TotalSMMartial = so.vTotalSMMartial;
		sm.TotalSMPray = so.vTotalSMPray;
		sm.TotalSMJob = so.vTotalSMJob;
		sm.TotalSMNun = so.vTotalSMNun;
		sm.TotalSMCustom = so.vTotalSMCustom;
		sm.TotalSMSpecial = so.vTotalSMSpecial;
		sm.TotalSMTalkSlaves = so.vTotalSMTalkSlaves;
		
		sm.GuildMember = so.vGuildMember;
		
		sm.PonygirlAware = so.vPonygirlAware;
		
		sm.SMGold = so.vSMGold;
		sm.SMGoldSpent = so.vSMGoldSpent;
		sm.SMDebt = so.vSMDebt;
	}

	private function UseCurrentDialog() : Boolean { return false; }
	private function GetSaveData(so:String) : SharedObject { return coreGame.GetSaveData(so); }
	
}