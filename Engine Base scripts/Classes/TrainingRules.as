// Rules
// Translation status: COMPLETE

import Scripts.Classes.*;

class TrainingRules extends DialogBase {
	
	// the rules settings
	public var RulesTalk:Number;
	public var RulesFuck:Number;
	public var RulesGoOut:Number;
	public var RulesTouchHerself:Number;
	public var RulesWriteLetters:Number;
	public var RulesPocketMoney:Number;
	public var RulesPray:Number;
	public var RulesMilkHerself:Number;
	public var RulesArmed:Number;

	// Fuctions
	
	// Constructor
	public function TrainingRules(cg:Object) { 
		super(cg.RulesMenu, cg);

		mcBase.Choices.setStyle("borderStyle", "none");
		mcBase.Choices.tabChildren = true;
		mcBase.Choices.tabEnabled = false;
		mcBase.Choices.addEventListener("scroll", Language.spListener);
		
		var ti:TrainingRules = this;
		cg.MorningEveningMenu.RulesButton.tabChildren = true;
		cg.MorningEveningMenu.RulesButton.Btn.onPress = function() { ti.ViewDialog(); }
		cg.MorningEveningMenu.RulesButton.Btn.onRollOut = function() { ti.HideHints(); }
		cg.MorningEveningMenu.RulesButton.Btn.onRollOver = function() {
			ti.ShowHint(ti.Language.GetHtml("HintRules", ti.Language.hintNode));
		}
	}
	
	public function Reset()
	{
		RulesTalk = 0;
		RulesFuck = 0;
		RulesGoOut = 0;
		RulesTouchHerself = 0;
		RulesWriteLetters = 0;
		RulesPocketMoney = 0;
		RulesPray = 0;
		RulesMilkHerself = 0;
		RulesArmed = -1;
		Save(coreGame);
	}
	
	// Load/Save
	public function Load(lo:Object)
	{
		RulesTalk = lo.RulesTalk;
		if (RulesTalk == undefined) RulesTalk = 0;
		RulesPray = lo.RulesPray;
		if (RulesPray == undefined) RulesPray = 0;
		RulesGoOut = lo.RulesGoOut;
		if (RulesGoOut == undefined) RulesGoOut = 0;
		RulesFuck = lo.RulesFuck;
		if (RulesFuck == undefined) RulesFuck = 0;
		RulesWriteLetters = lo.RulesWriteLetters;
		if (RulesWriteLetters == undefined) RulesWriteLetters = 0;
		RulesTouchHerself = lo.RulesTouchHerself;
		if (RulesTouchHerself == undefined) RulesTouchHerself = 0;
		RulesPocketMoney = lo.RulesPocketMoney;
		if (RulesPocketMoney == undefined) RulesPocketMoney = 0;
		RulesMilkHerself = lo.RulesMilkHerself;
		if (RulesMilkHerself == undefined) RulesMilkHerself = 0;
		RulesArmed = lo.RulesArmed;
		if (RulesArmed == undefined) RulesArmed = 0;
	}
	public function Save(so:Object)
	{
		so.RulesTalk = RulesTalk;
		so.RulesPray = RulesPray;
		so.RulesGoOut = RulesGoOut;
		so.RulesFuck = RulesFuck;
		so.RulesWriteLetters = RulesWriteLetters;
		so.RulesTouchHerself = RulesTouchHerself;
		so.RulesPocketMoney = RulesPocketMoney;
		so.RulesMilkHerself = RulesMilkHerself;
		so.RulesArmed = RulesArmed;
	}
	
	// Main user interface
	
	// show the menu
	public function ViewDialog()
	{
		super.ViewDialog();
		
		Load(coreGame);		// TODO:to be removed
		
		coreGame.ShowLeaveButton();
		coreGame.MorningEveningMenu._visible = false;
		HideEquipmentButton();
		HideSMEquipmentButton();
		
		coreGame.ShowAssistant();
		Language.ServantSpeak(Language.GetHtml("Intro", "Rules"));
		Language.BlankLine();
		
		coreGame.ClearGeneralArray();
		AddRule(0);
		AddRule(1);
		AddRule(2);
		AddRule(3);
		AddRule(4);
		AddRule(5);
		AddRule(6);
		if (coreGame.Lactation > 0) AddRule(7);
		if (RulesArmed != -1) AddRule(8);
		
		mcBase.LText1.htmlText = Language.GetHtml("Title", "Rules", true);
		mcBase.LText2.htmlText = Language.GetHtml("TitleHint", "Rules", true);
	
		Beep();
	}
	
	private function ChangeRule(rule:Number, mc:MovieClip)
	{
		var ruleval:Number;
		switch (rule) {
			case 0: ruleval = RulesTalk; break;
			case 1: ruleval = RulesPray; break;
			case 2: ruleval = RulesGoOut; break;
			case 3: ruleval = RulesFuck; break;
			case 4: ruleval = RulesTouchHerself; break;
			case 5: ruleval = RulesWriteLetters; break;
			case 6: ruleval = RulesPocketMoney; break;
			case 7: ruleval = RulesMilkHerself; break;
			case 8: ruleval = RulesArmed; break;
		}
		if (ruleval == -1) return;
		if (ruleval == 1) ClearRule(rule, mc);
		else SetRule(rule, mc);
	}
	
	public function ChangeRuleTo(rule:Number, val:Number, loadr:Boolean) : Number
	{
		if (loadr == true) Load(coreGame);
		
		switch (rule) {
			case 0:
				RulesTalk = val;
				break;
			case 1:
				RulesPray = val;
				break;
			case 2:
				RulesGoOut = val;
				break;
			case 3:
				RulesFuck = val;
				break;
			case 4:
				RulesTouchHerself = val;
				break;
			case 5:
				RulesWriteLetters = val;
				break;
			case 6:
				RulesPocketMoney = val;
				break;
			case 7:
				RulesMilkHerself = val;
				break;
			case 8:
				RulesArmed = val;
		}
		Save(coreGame);
		return val;
	}

	
	public function SetRule(rule:Number, mc:MovieClip)
	{
		if (coreGame.SlaveGirl.SetRule(rule) == false) {
			Bloop();
			return;
		}
		coreGame.genNumber = rule;
		if (Language.XMLData.XMLEvent("SetRule")) {
			Bloop();
			return;
		}
		if (rule == 0 && coreGame.BitGagWorn == 1) {
			ServantSpeak(Language.GetHtml("NotBitGag", "Rules"));
			BlankLine();
			Bloop();
			return;
		}
		ChangeRuleTo(rule, 1);
		Beep();
		UpdateRule(rule, mc);
	}
	
	public function ClearRule(rule:Number, mc:MovieClip) 
	{
		if (coreGame.SlaveGirl.ClearRule(rule) == false) {
			if (IsEventAllowable()) Bloop();
			return;
		}
		coreGame.genNumber = rule;
		if (Language.XMLData.XMLEvent("ClearRule")) {
			if (IsEventAllowable()) Bloop();
			return;
		}
		ChangeRuleTo(rule, 0);
		Beep();
		UpdateRule(rule, mc);
	}
	
	
	public function IsRuleOn(rule:Number) : Boolean
	{
		switch (rule) {
			case 0:	return RulesTalk == 1;
			case 1: return RulesPray == 1;
			case 2: return RulesGoOut == 1;
			case 3:	return RulesFuck == 1;
			case 4:	return RulesTouchHerself == 1;
			case 5:	return RulesWriteLetters == 1;
			case 6:	return RulesPocketMoney == 1;
			case 7:	return RulesMilkHerself == 1;
			case 8: return RulesArmed == 1;
		}
		return false;
	}
			
	private function AddRule(rule:Number)
	{	
		var image:MovieClip = mcBase.Choices.content.attachMovie("Rule", "Rule" + rule, mcBase.Choices.content.getNextHighestDepth());
		var tn:Number = coreGame.arGeneralArray.push(image);
		
		image._x = 0;
		image._y = (tn - 1) * 43;
		image.enabled = true;
		image.tabEnabled = true;
		image.tabChildren = true;
	
		UpdateRule(rule, image);
		image.rule = rule;
		var ti:TrainingRules = this;
		image.Btn.onPress = function() {
			ti.ChangeRule(this._parent.rule, this._parent);
		}
		image.Btn.onRollOver = function() {
			if (ti.IsHints()) ti.SetMovieColour(this._parent, 50, 50, 50);
		}
		image.Btn.onRollOut = function() { 
			ti.SetMovieColour(this._parent, 0, 0, 0);
		}
		image._visible = true;
	}
	
	private function UpdateRule(rule:Number, mc:MovieClip)
	{		
		if (mc == undefined) mc = GetRuleMC(rule);
		
		switch (rule) {
			case 0:
				mc.Tick._visible = RulesTalk == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("Talk", "Rules", false, 0, "T");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesTalk * 2));
				if (RulesTalk == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("TalkOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("TalkOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("TalkOn", "Rules", true) + "</font>\r" + Language.GetHtml("TalkOff", "Rules", false);
				break;
	
			case 1:
				mc.Tick._visible = RulesPray == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("Pray", "Rules", false, 0, "P");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesPray * 2));
				if (RulesPray == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("PrayOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("PrayOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("PrayOn", "Rules", true) + "</font>\r" + Language.GetHtml("PrayOff", "Rules", false);
				break;
	
			case 2:
				mc.Tick._visible = RulesGoOut == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("GoOut", "Rules", false, 0, "G");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesGoOut * 2));
				if (RulesGoOut == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("GoOutOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("GoOutOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("GoOutOn", "Rules", true) + "</font>\r" + Language.GetHtml("GoOutOff", "Rules", false);
				break;
	
			case 3:
				mc.Tick._visible = RulesFuck == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("FuckWithAnyone", "Rules", false, 0, "F");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesFuck * 2));
				if (RulesFuck == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("FuckWithAnyoneOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("FuckWithAnyoneOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" +Language.GetHtml("FuckWithAnyoneOn", "Rules", true) + "</font>\r" + Language.GetHtml("FuckWithAnyoneOff", "Rules", false);
				break;
	
			case 4:
				mc.Tick._visible = RulesTouchHerself == 1;
				if (coreGame.SlaveGender == 1) mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("TouchMale", "Rules", false, 0, "o");
				else if (coreGame.SlaveGender > 3) mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("TouchTwins", "Rules", false, 0, "o");
				else mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("TouchFemale", "Rules", false, 0, "o");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesTouchHerself * 2));
				if (RulesTouchHerself == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("TouchOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("TouchOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("TouchOn", "Rules", true) + "</font>\r" + Language.GetHtml("TouchOff", "Rules", false);
				break;
	
			case 5:
				mc.Tick._visible = RulesWriteLetters == 1;
				if (coreGame.SlaveGender == 1) mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("WriteMale", "Rules", false, 0, "W");
				else if (coreGame.SlaveGender > 3) mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("WriteTwins", "Rules", false, 0, "W");
				else mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("WriteFemale", "Rules", false, 0, "W");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesWriteLetters * 2));
				if (RulesWriteLetters == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("WriteOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("WriteOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("WriteOn", "Rules", true) + "</font>\r" + Language.GetHtml("WriteOff", "Rules", false);
				break;
	
			case 6:
				mc.Tick._visible = RulesPocketMoney == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("HavePocketMoney", "Rules", false, 0, "H");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesPocketMoney * 2));
				if (RulesPocketMoney == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("HavePocketMoneyOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("HavePocketMoneyOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("HavePocketMoneyOn", "Rules", true) + "</font>\r" + Language.GetHtml("HavePocketMoneyOff", "Rules", false);
				break;
				
			case 7:
				mc.Tick._visible = RulesMilkHerself == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("MilkHerself", "Rules", false, 0, "M");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesMilkHerself * 2));
				if (RulesMilkHerself == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("MilkHerselfOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("MilkHerselfOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("MilkHerselfOn", "Rules", true) + "</font>\r" + Language.GetHtml("MilkHerselfOff", "Rules", false);
				break;
				
			case 8:
				mc.Tick._visible = RulesArmed == 1;
				mc.RuleGroup.RuleLabel.htmlText = Language.GetHtml("Armed", "Rules", false, 0, "A");
				mc.RuleGroup.RuleButton.gotoAndStop(3 - (RulesArmed * 2));
				if (RulesArmed == 1) mc.RuleGroup.RuleDescription.htmlText = Language.GetHtml("ArmedOn", "Rules", true) + "\r<font color='#999999'>" + Language.GetHtml("ArmedOff", "Rules", false) + "</font>";
				else mc.RuleGroup.RuleDescription.htmlText = "<font color='#999999'>" + Language.GetHtml("ArmedOn", "Rules", true) + "</font>\r" + Language.GetHtml("ArmedOff", "Rules", false);
				break;
	
		}
		mc.Cross._visible = !mc.Tick._visible;
		mcBase.Choices.invalidate();
	}
	
	private function GetRuleMC(rule:Number) : MovieClip
	{
		for (var i:Number = 0; i < coreGame.arGeneralArray.length; i++) {
			var mc:MovieClip = coreGame.arGeneralArray[i];
			if (mc.rule == rule) return mc;
		}
	
	}
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean)
	{
		switch(keya) {
			case 65: 
				ChangeRule(3, GetRuleMC(8)); return;
			case 70: 
				ChangeRule(3, GetRuleMC(3)); return;
			case 71: 
				ChangeRule(2, GetRuleMC(2)); return;
			case 72: 
				ChangeRule(6, GetRuleMC(6)); return;
			case 79: 
				ChangeRule(4, GetRuleMC(4)); return;
			case 80: 
				ChangeRule(1, GetRuleMC(1)); return;
			case 84: 
				ChangeRule(0, GetRuleMC(0)); return;
			case 87: 
				ChangeRule(5, GetRuleMC(5)); return;
			case 77: 
				if (coreGame.arGeneralArray.length > 7) ChangeRule(7, GetRuleMC(7)); return;
		}
	}
	
}
