// DialogMorningEvening - game title screen
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogMorningEvening extends DialogBase
{		
	//private var MorningEveningButton:ButtonBase;
	
	
	// Constructor
	public function DialogMorningEvening(cg:Object)
	{ 
		super(cg.MorningEveningMenu, cg);
		
		//MorningEveningButton = new ButtonBase(cg.mcMorningEveningBtn, cg, "", this, "PressButton");
		
		var ti:DialogMorningEvening = this;
		coreGame.MorningButton.Btn.onPress = function() { ti.PressButton(); }
		coreGame.EveningButton.tabChildren = true;
		coreGame.EveningButton.Btn.onPress = coreGame.MorningButton.Btn.onPress;
		
	}
	
	
	// Button
	public function PressButton(show:Boolean)
	{
		if (show == true || mcBase._visible == false) ViewDialog();
		else LeaveDialog();
	}
	
	/*
	public function ShowButton()
	{
		MorningEveningButton.InitialiseButton(false, true, coreGame.Day ? Language.GetHtml("Morning", "Buttons", false, -1, "M") : Language.GetHtml("Evening", "Buttons", false, -1, "E"));
		MorningEveningButton.Show();
	}
	public function HideButton()
	{
		MorningEveningButton.Hide();
	}
	*/

	// View
	
	public function ViewDialog()
	{
		// enter morning screen
		super.ViewDialog();
		StopHints();
		SetText("");
		coreGame.SlaveDiscussion._visible = false;
		Beep();
	
		coreGame.InitialisePlanningCommon();
		if (IsDayTime()) { 
			mcBase.MorningEveningText.htmlText = "<b>" + Language.GetHtml("Morning", "Buttons") + " -</b>";
			mcBase.Description.htmlText = "<b>" + Language.GetHtml("MorningDescription", "Morning") + "</b>";
			if (coreGame.Options.TutorialOn && SMData.BitFlagSM.CheckAndSetBitFlag(36)) coreGame.Information.ShowTutorialLang("Morning");
		} else {
			mcBase.MorningEveningText.htmlText = "<b>" + Language.GetHtml("Evening", "Buttons") + " -</b>";
			mcBase.Description.htmlText = "<b>" + Language.GetHtml("EveningDescription", "Morning") + "</b>";
			if (coreGame.Options.TutorialOn && SMData.BitFlagSM.CheckAndSetBitFlag(37)) coreGame.Information.ShowTutorialLang("Evening");
		}
		coreGame.LoadSave.Hide();
		
		var ti:DialogMorningEvening = this;
		mcBase.TalkButton.onPress = function() { ti.coreGame.DoTalkSlaves(); }
		mcBase.TalkButton.onRollOut = function() { ti.HideHints(); }
		mcBase.TalkButton.onRollOver = function()
		{
			ti.ShowHint(ti.Language.GetHtml("SlavesDiscussDescription", ti.Language.actNode));
		}
	}
	
	public function ShowDialogContents() 
	{	
		trace("ShowDialogContents: " + Language + " " + coreGame + " " + coreGame.Language);
		mcBase.LDone.htmlText = Language.GetHtml("WhatCanBeDone", "Morning");
		mcBase.LWorn.htmlText = Language.GetHtml("WhatWillBeWorn", "Morning");
		mcBase.LYourSlaves.htmlText = Language.GetHtml("YourSlaves", "Morning");
		mcBase.LPersonal.htmlText = Language.GetHtml("Personal", "Morning");
		mcBase.LDiscuss.htmlText = Language.GetHtml("SlavesDiscuss", "Buttons");

		coreGame.SetButtonDetails(mcBase.HomeButton, false, true, Language.GetHtml("HomeInfo", "Buttons"), 0, "H", 0, 0, 0, 0, "HomeInformation", "RollOverHomeButton", "HideHints", this);
		coreGame.SetButtonDetails(mcBase.TakePotion, false, true, Language.GetHtml("TakePotions", "Buttons"), 0, "k", 0, 0, 0, 0, "TakePotions", "RollOverTakePotionsButton", "HideHints", this);

		var act:ActInfo = SetActDetails(10, coreGame.PlugInserted > 0, (coreGame.PlugOK == 1) || (coreGame.PonyTailOK == 1), Language.GetHtml("AnalPlug", Language.actNode), "", "A", 0, 0, -1, -1, undefined, "PlugRollOver", "HideHints", this);
		act.SetButtonFromAct(mcBase.PlugButton);
		mcBase.PlugButton._visible = act.IsShown();

		act = SetActDetails(13, coreGame.Naked, coreGame.DaysUnavailable == 0, Language.GetHtml("Naked", Language.actNode), "", "N", 0, 0, -1, -1, undefined, "NakedRollOver", "HideHints", this);
		act.SetButtonFromAct(mcBase.NakedButton);
		mcBase.NakedButton._visible = act.IsShown();
		
		act = SetActDetails(16, coreGame.LendPerson != 0, coreGame.DaysUnavailable == 0, Language.GetHtml("Lend", Language.actNode), "", "L", 0, 0, -1, -1, undefined, "LendRollOver", "HideHints", this);
		act.SetButtonFromAct(mcBase.LendButton);
		mcBase.LendButton._visible = act.IsShown();

		if (SMData.SMAdvantages.CheckBitFlag(13)) {
			act = SetActDetails(2515, false, true, "<font color='#FF0000'>" + Language.GetHtml("Feeding", Language.actNode) + "</font>", "", "F", 0, 1, -1, -1, undefined, "SMSpecialRollOver", "HideHints", this);
			act.SetButtonFromAct(mcBase.SpecialButton);
		}
		coreGame.ShowAct(2515, SMData.SMAdvantages.CheckBitFlag(13));
		mcBase.SpecialButton._visible = SMData.SMAdvantages.CheckBitFlag(13);
		
		mcBase._visible = true;
		coreGame.dspMain.ShowMainButtons();
		
		coreGame.ShowAssistantSoon();
	}
	
	public function LeaveDialog()
	{
		super.LeaveDialog();
		
		coreGame.Hints.StopHints();
		SetText("");
		coreGame.SlaveDiscussion._visible = false;
		Beep();
	
		// leave morning screen
		coreGame.HideImages();
		coreGame.Sounds.StopAndFadeSounds();
		Backgrounds.HideBackgrounds();
		coreGame.HideEquipmentButton();
		coreGame.HideSMEquipmentButton();
		coreGame.ShowDress();
		coreGame.ShowAssistant();
	}
	
	public function PlugRollOver()
	{
		trace("PlugRollOver: " + Language + " " + coreGame + " " + coreGame.Language);
    	ShowHint(Language.GetHtml("AnalPlugDescription", Language.actNode));
	}
	public function LendRollOver()
	{
		trace("LendRollOver");
    	ShowHint(Language.GetHtml("LendDescription", Language.actNode));
	}
	public function NakedRollOver()
	{
    	ShowHint(Language.GetHtml("NakedDescription", Language.actNode));
	}
	function SMSpecialRollOver()
	{
		if (SMData.SMAdvantages.CheckBitFlag(13)) ShowHint(Language.GetHtml("FeedingDescription", Language.actNode) + "\r");
	}
	
	
	// Home information
	
	public function HomeInformation()
	{
		coreGame.currentDialog = new DialogHouseInformation(coreGame);
		coreGame.currentDialog.ViewDialog();
	}

	public function RollOverHomeButton()
	{
		ShowHint(Language.GetHtml("HintHomeInfo", Language.hintNode) + "\r");
	}
	
	public function RollOverTakePotionsButton()
	{
		ShowHint(Language.GetHtml("PotionsHint", "Potions"));
	}
	
	
	// Take Potions
	public function TakePotions()
	{
		coreGame.Potions.ViewDialog();
	}


	// Shortcuts
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		trace("MorningEvening.Shortcuts 1");
		if (coreGame.SlaveDiscussion._visible) {
			switch(keya) {
			case 65:
				if (coreGame.SlaveDiscussion.BtnAssistant._visible) coreGame.SlaveAssistant();
				return true;
				
			case 68:
				coreGame.SlaveTalk();
				return true;
				
			case 70:
				if (coreGame.SlaveDiscussion.BtnTrain._visible) coreGame.SlaveFullyTrain();
				return true;
				
			case 73:
				if (coreGame.SlaveDiscussion.BtnSex._visible) coreGame.SlaveSexFuck();
				return true;
				
			case 77:
				if (coreGame.SlaveDiscussion.BtnSexOther._visible) coreGame.SlaveSexOther();
				return true;			
				
			case 79:
				if (coreGame.SlaveDiscussion.BtnOrder._visible) coreGame.SlaveOrder();
				return true;
				
			case 89:
				if (coreGame.SlaveDiscussion.BtnMarry._visible) coreGame.SlaveMarry();
				return true;			
			}
			return false;
		}
		
		trace("MorningEvening.Shortcuts 2");
		if (coreGame.DoThePlanning._visible && (keya == 91 || keya == 93 || (bControl && keya == 68))) {
			coreGame.StartPlanning();
			return true;
		}
	
		trace("MorningEvening.Shortcuts 3");
		switch(keya) {
			case 65:
				coreGame.NewPlanningAction(10);
				return true;
			case 72:
				HomeInformation();
				return true;
			case 70:
				if (SMData.SMAdvantages.CheckBitFlag(13)) coreGame.NewPlanningAction(2515);
				return true;
			case 75:
				coreGame.Potions.ViewDialog();
				return true;
			case 76:
				coreGame.NewPlanningAction(16);
				return true;
			case 78:
				coreGame.NewPlanningAction(13);
				return true;
			case 82:
				coreGame.Rules.ViewDialog();
				return true;
			case 86:
				coreGame.DoTalkSlaves();
				return true;
		}
		return false;
	}
	
	// Theme
	public function ApplyTheme(cvo:ColourScheme)
	{
		var cv:Number =  cvo.nActButtons;
		var red:Number = (cv >> 16) & 255;
		var green:Number = (cv >> 8) & 255;
		var blue:Number = cv & 255;
		var perc:Number = 1; //0.85;
			
		SetMovieColour(mcBase.RulesButton.Btn, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(mcBase.TalkButton, red, green, blue, 0, 1, 1, 1, 1, true);
		SetMovieColour(mcBase.Discussion.TalkButton, red, green, blue, 0, 1, 1, 1, 1, true);
	}
	
	private function UseCurrentDialog() : Boolean { return false; }

}
