// DialogSystem - System Menu
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogSystem extends DialogBase {
		
	// Constructor
	public function DialogSystem(cg:Object)
	{ 
		super(cg.mcMain.mcSystemMenu, cg);

		mcBase._x -= 1000;
		
		var ti:DialogSystem = this;
		coreGame.SystemButton.tabChildren = true;
		coreGame.SystemButton.Btn.onPress = function()
		{ 
			if (ti.IsShown()) ti.LeaveDialog();
			else ti.ViewDialog();
		}
		mcBase.BtnOptions.tabChildren = true;
		mcBase.BtnOptions.Btn.onPress = function() { ti.coreGame.Options.ViewDialog(); }

		mcBase.BtnLoad.tabChildren = true;
		mcBase.BtnLoad.Btn.onPress = function() { ti.coreGame.LoadSave.ViewLoadScreen(); }

		mcBase.BtnSave.tabChildren = true;
		mcBase.BtnSave.Btn.onPress = function() { ti.coreGame.LoadSave.ViewSaveScreen(); }

		mcBase.BtnComplete.tabChildren = true;
		mcBase.BtnComplete.Btn.onPress = function() { ti.coreGame.EndGame.AskCompleteTraining(); }

		mcBase.BtnRetire.tabChildren = true;
		mcBase.BtnRetire.Btn.onPress = coreGame.RetireSlaveMaker;
	}

	public function ViewDialog()
	{
		mcBase.BtnLoad.Label.htmlText = Language.GetHtml("Load", "Buttons", false, -1, "L");
		mcBase.BtnSave.Label.htmlText = Language.GetHtml("Save", "Buttons", false, -1, "S");
		mcBase.BtnComplete.Label.htmlText = Language.GetHtml("Complete", "Buttons", false, -1, "C");
		mcBase.BtnRetire.Label.htmlText = Language.GetHtml("Retire", "Buttons", false, -1, "R");
		mcBase.BtnOptions.Label.htmlText = Language.GetHtml("Title", "Options", false, -1, "O");
		mcBase.LAssistantVersion.htmlText = Language.GetHtml("Version", "Other", true) + ":";
		mcBase.LSlaveVersion.htmlText = Language.GetHtml("Version", "Other", true) + ":";
		mcBase.LAssistantInformation.htmlText = Language.GetHtml("InfoCredits", "Other");
		mcBase.LSlaveInformation.htmlText = Language.GetHtml("InfoCredits", "Other");
		mcBase.LGameInformation.htmlText = Language.GetHtml("GameInformation", "Other", true) + ":";
		mcBase.LSlaveInformation.htmlText = Language.GetHtml("SlaveInformation", "Other", true) + ":";
		mcBase.LAssistantInformation.htmlText = Language.GetHtml("AssistantInformation", "Other", true) + ":";

		mcBase.Version.text = coreGame.IntroTitle.Version.text;
		
		if (coreGame.ParticipantsChanger._visible) {
			coreGame.DoLeaveButton();
			coreGame.ClearGeneralArray();
		}
		
		InitialiseModule(null);		// force reset of SMData, Backgrounds etc objects, do not change visibilty state of movieclips
		ShowDialogContents();
	}
	
	public function ShowDialogContents()
	{
		StopHints();

		Beep();
		mcBase._visible = true;

		coreGame.LargerTextField._visible = false;
		coreGame.MorningEveningMenu._visible = false;
		HideEquipmentButton();
		HideSMEquipmentButton();
		
		var bLimitSaves = (coreGame.Options.bLimitSavesOn && (((coreGame.GameDate % 8) != 0) || IsDayTime()));
		if (bLimitSaves || coreGame.Plannings.IsStarted() || coreGame.NextEnding._visible || coreGame.Contests.IsContestStarted() || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.VisitMenu._visible || coreGame.HouseEvents.IsExploring()) mcBase.BtnSave._visible = false;
		else mcBase.BtnSave._visible = true;
		mcBase.BtnComplete._visible = !coreGame.Plannings.IsStarted();
		mcBase.BtnRetire._visible = !coreGame.Plannings.IsStarted();

	}

	public function LeaveDialog()
	{
		mcBase._visible = false;

		if (coreGame.PlanningSelections._visible) coreGame.dspMain.SelectGameTab(6);
		else coreGame.dspMain.SelectGameTab(1);
	}

	public function SetAssistantDetails(version:String, details:String) 
	{
		mcBase.AssistantVersion.text = version == "" ? Language.GetHtml("NotDefined") : version;
		if (details == "") mcBase.AssistantInformation.text = Language.GetHtml("Name") + " " + coreGame.ServantName + "\r" + Language.GetHtml("File") + " " + coreGame.ServantFilename;
		else mcBase.AssistantInformation.text = details;
	}
	
	public function SetSlaveDetails(version:String, details:String) 
	{
		mcBase.SlaveVersion.text = version == "" ? Language.GetHtml("NotDefined") : version;
		if (details == "") mcBase.SlaveInformation.text = Language.GetHtml("Name") + " " + coreGame.SlaveName + "\r" + Language.GetHtml("File") + " " + coreGame.SlaveFilename;
		else mcBase.SlaveInformation.text = details;
	}

	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
		{
		switch (keya) {
			case 67:
				if (mcBase.BtnComplete._visible) {
					coreGame.AskCompleteTraining();
					return true;
				}
			case 76:
				coreGame.LoadSave.ViewLoadScreen();
				return true;
			case 79:
				coreGame.DoOptions();
				return true;
			case 82:
				if (mcBase.BtnRetire._visible) {
					coreGame.RetireSlaveMaker(1);
					return true;
				}
			case 83:
				if (mcBase.BtnSave._visible) {
					coreGame.LoadSave.ViewSaveScreen();
					return true;
				}
		}
		return false;
	}
}