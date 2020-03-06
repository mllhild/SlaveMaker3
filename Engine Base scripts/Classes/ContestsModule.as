// Contests
// Linked to Contests.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class ContestsModule extends SlaveModule
{
	public var NumContest:Number;
	public var Placing:Number;
	public var RivalAScore:Number;
	public var RivalBScore:Number;
	public var RivalCScore:Number;
	public var RivalDScore:Number;
	public var RivalEScore:Number;
	
	public var ContestsMenu:MovieClip;
	
	private var cact:ActInfo;
	
	private var bContestStarted;
	
	
	public function ContestsModule(mc:MovieClip, cgm:Object) { super(mc, undefined, cgm); }
	
	// Features/Capabilities of this module, override as needed
	//   inplement load/save features AND an external xml file
	public function CanLoadSave() : Boolean { return false; }

	
	public function StartContests() { bContestStarted = true; LoadModule("Engine/Contests.swf", this, "StartContests2"); }
	
	public function IsContestStarted() : Boolean { return bContestStarted; }
	
	public function StartContests2()
	{
		InitialiseModule();
		coreGame.Hints.HideHints();
		
		var ti:ContestsModule = this;
		
		ContestsMenu.Custom1.Btn.onPress = function() {	ti.ContestCustom(this._parent.act);	}
		ContestsMenu.Custom2.Btn.onPress = ContestsMenu.Custom1.Btn.onPress;
		ContestsMenu.Custom3.Btn.onPress = ContestsMenu.Custom1.Btn.onPress;
		ContestsMenu.Custom4.Btn.onPress = ContestsMenu.Custom1.Btn.onPress;
		ContestsMenu.Custom5.Btn.onPress = ContestsMenu.Custom1.Btn.onPress;
		ContestsMenu.Custom6.Btn.onPress = ContestsMenu.Custom1.Btn.onPress;
		ContestsMenu.Custom7.Btn.onPress = ContestsMenu.Custom1.Btn.onPress;
		
		ContestsMenu.Custom1.Btn.onRollOut = function() { ti.ContestRollout(); }
		ContestsMenu.Custom2.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Custom3.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Custom4.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Custom5.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Custom6.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Custom7.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;

		ContestsMenu.Custom1.Btn.onRollOver = function() { ti.coreGame.Hints.ShowHint(this._parent.act.Description); }
		ContestsMenu.Custom2.Btn.onRollOver = ContestsMenu.Custom1.Btn.onRollOver;
		ContestsMenu.Custom3.Btn.onRollOver = ContestsMenu.Custom1.Btn.onRollOver;
		ContestsMenu.Custom4.Btn.onRollOver = ContestsMenu.Custom1.Btn.onRollOver;
		ContestsMenu.Custom5.Btn.onRollOver = ContestsMenu.Custom1.Btn.onRollOver;
		ContestsMenu.Custom6.Btn.onRollOver = ContestsMenu.Custom1.Btn.onRollOver;
		ContestsMenu.Custom7.Btn.onRollOver = ContestsMenu.Custom1.Btn.onRollOver;

		ContestsMenu.XXX.Btn.onPress = function() {
			ti.ContestXXX();
		}
		ContestsMenu.XXX.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.XXX.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(31, 0, 1);
				ti.ShowHintLang("XXX/Hint", "Contests");
			}
		}
		ContestsMenu.Beauty.Btn.onPress = function() {
			ti.ContestBeauty();
		}
		ContestsMenu.Beauty.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Beauty.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(26, 0, 1, 1);
				ti.ShowHintLang("Beauty/Hint", "Contests");
			}
		}
		ContestsMenu.Court.Btn.onPress = function() {
			ti.ContestCourt();
		}
		ContestsMenu.Court.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Court.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(51, 0, 1, 1);
				ti.ShowHintLang("LadyOfTheCourt/Hint", "Contests");
			}
		}
		ContestsMenu.Ponygirl.Btn.onPress = function() {
			ti.ContestPonygirl();
		}
		ContestsMenu.Ponygirl.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Ponygirl.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(11, 0, 1, 1);
				ti.ShowHintLang("PonygirlRace/Hint", "Contests");
			}
		}
		ContestsMenu.Housework.Btn.onPress = function() {
			ti.ContestHousework();
		}
		ContestsMenu.Housework.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Housework.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(47, 0, 6);
				ti.ShowHintLang("HouseWork/Hint", "Contests");
			}
		}
		ContestsMenu.HouseworkAdvanced.Btn.onPress = function() {
			ti.ContestHouseworkAdvanced();
		}
		ContestsMenu.HouseworkAdvanced.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.HouseworkAdvanced.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(47, 0, 6);
				ti.ShowHintLang("AdvancedHousework/Hint", "Contests");
			}
		}
		ContestsMenu.Dance.Btn.onPress = function() {
			ti.ContestDance();
		}
		ContestsMenu.Dance.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Dance.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(14, 0, 1, 1);
				ti.ShowHintLang("Dance/Hint", "Contests");
			}
		}
		ContestsMenu.GeneralKnowledge.Btn.onPress = function() {
			ti.ContestGeneralKnowledge();
		}
		ContestsMenu.GeneralKnowledge.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.GeneralKnowledge.Btn.onRollOver = function()
		{
			if (ti.coreGame.Hints.IsHints()) {
				ti.ShowPerson(29, 0, 6, 1);
				ti.ShowHintLang("GeneralKnowledge/Hint", "Contests");
			}
		}
		ContestsMenu.Dont.Btn.onPress = function()
		{
			ti.HideImages();
			ti.bContestStarted = false;
			ti.cact = null;
			ti.coreGame.dspMain.ShowMainButtons();
			ti.SetText("");
		}
		ContestsMenu.Dont.Btn.onRollOut = ContestsMenu.Custom1.Btn.onRollOut;
		ContestsMenu.Dont.Btn.onRollOver = function() { ti.ShowHintLang("NoCompetitionToday", "Contests"); }
		
		ContestsMenu.Dance._visible = true;
		ContestsMenu.Court._visible = true;
		ContestsMenu.Beauty._visible = true;
		ContestsMenu.Ponygirl._visible = true;
		ContestsMenu.GeneralKnowledge._visible = true;
		ContestsMenu.Housework._visible = true;
		ContestsMenu.XXX._visible = true;
		ContestsMenu.HouseworkAdvanced._visible = true;
		ContestsMenu.Dont._visible = true;
		ContestsMenu.Custom1._visible = false;
		ContestsMenu.Custom2._visible = false;
		ContestsMenu.Custom3._visible = false;
		ContestsMenu.Custom4._visible = false;
		ContestsMenu.Custom5._visible = false;
		ContestsMenu.Custom6._visible = false;
		ContestsMenu.Custom7._visible = false;
		
		coreGame.SetButtonDetails(ContestsMenu.Dance, false, true, Language.GetHtml("Dance/Name", "Contests"), undefined, "D");
		coreGame.SetButtonDetails(ContestsMenu.Court, false, true, Language.GetHtml("LadyOfTheCourt/Name", "Contests"), undefined, "C");
		coreGame.SetButtonDetails(ContestsMenu.Beauty, false, true, Language.GetHtml("Beauty/Name", "Contests"), undefined, "B");
		coreGame.SetButtonDetails(ContestsMenu.Ponygirl, false, true, Language.GetHtml("PonygirlRace/Name", "Contests"), undefined, "P");
		coreGame.SetButtonDetails(ContestsMenu.GeneralKnowledge, false, true, Language.GetHtml("GeneralKnowledge/Name", "Contests"), undefined, "G");
		coreGame.SetButtonDetails(ContestsMenu.Housework, false, true, Language.GetHtml("Housework/Name", "Contests"), undefined, "H");
		coreGame.SetButtonDetails(ContestsMenu.XXX, false, true, Language.GetHtml("XXX/Name", "Contests"), undefined, "X");
		coreGame.SetButtonDetails(ContestsMenu.HouseworkAdvanced, false, true, Language.GetHtml("AdvancedHousework/Name", "Contests"), undefined, "V");
		coreGame.SetButtonDetails(ContestsMenu.Dont, false, true, Language.GetHtml("DoNotCompete", "Contests"), undefined, "N");
			
		ContestsMenu.Ponygirl._visible = SMData.PonygirlAware == 1;
		ContestsMenu.HouseworkAdvanced._visible = slaveData.BitFlag1.CheckBitFlag(36);
	
		var len:Number = coreGame.slaveData.ActInfoBase.GetActCounts();
		var act:ActInfo;
		var iBtn:Number = 0;
		var mcAct:MovieClip;
		for (var i:Number = 0; i < len; i++) {
			act = coreGame.slaveData.ActInfoBase.GetActByIndex(i);
			if (act.Type != 11) continue;
			if (act.strNodeName == "" || act.Name == "") continue;
			iBtn++;
			if (iBtn > 7) break;
			mcAct = ContestsMenu["Custom" + iBtn];
			var short:String = "";
			if (iBtn == 1) short = "U";
			else if (iBtn == 2) short = "Z";
			else if (iBtn == 3) short = "W";
			coreGame.SetButtonDetails(mcAct, false, true, act.Name, undefined, short);
			mcAct._visible = act.bShown;
			mcAct.act = act;
		}

		SMData.ChangeSlaveMakerGender();		// force recolouring of buttons

		mcBase,_visible = true;
		ContestsMenu._visible = true;
		
		// initial text
		if (coreGame.Elapsed < 9) ServantSpeak(Language.GetHtml("FirstContest", "Contests"));
		else ServantSpeak(Language.GetHtml("LaterContests", "Contests"));
		BlankLine();
	
		coreGame.keyListenerMenu.onKeyUp = function() {
			ti.ContestsMenuKeyListener();
		}
		Key.addListener(coreGame.keyListenerMenu);
	}
	
	public function ContestsMenuKeyListener()
	{
		var key:Number = Key.getAscii();
		if (key > 96) key = key - 32;
		switch(key) {
			case 66: ContestBeauty(); break;
			case 67: ContestCourt(); break;
			case 68: ContestDance(); break;
			case 71: ContestGeneralKnowledge(); break;
			case 72: ContestHousework(); break;
			case 78: ContestsMenu.Dont.Btn.onPress(); break;
			case 80: 
				if (SMData.PonygirlAware == 1) ContestPonygirl();
				break;
			case 85:
			case 87:
			case 89:
				{
					var len:Number = coreGame.slaveData.ActInfoBase.GetActCounts();
					var act:ActInfo;
					var iBtn:Number = 0;
					var iAct:Number = (key - 83) / 2;
	
					for (var i:Number = 0; i < len; i++) {
						act = coreGame.slaveData.ActInfoBase.GetActByIndex(i);
						if (act.Type != 11) continue;
						if (act.strNodeName == "" || act.Name == "") continue;
						iBtn++;
						if (!act.bShown) continue;
						if (iAct != iBtn) continue;
						ContestCustom(act);
						break;
					}
				}
				break;
			case 86:
				if (slaveData.BitFlag1.CheckBitFlag(36)) ContestHouseworkAdvanced();
				break;
			case 88: ContestXXX(); break;
		}
	}
	
	public function ContestRollout()
	{
		if (coreGame.Hints.IsHints()) {
			coreGame.HidePeople();
			coreGame.Hints.HideHints();
		}
	}
	
	public function ContestsIntro()
	{
		SetText("");
		coreGame.Information.HideInformation();
		Beep();
		coreGame.genNumber = NumContest;
		coreGame.Hints.HideHints();
		if (coreGame.Elapsed <= 8) AddText(Language.GetHtml("FirstSeeTrophies", "Contests") + "\r\r"); 
		ContestsMenu._visible = false;
		Key.removeListener(coreGame.keyListenerMenu);
		coreGame.keyListenerMenu.onKeyUp = null;
		coreGame.DoEvent(0);
		
		// Base score
		coreGame.Score = Math.floor(slaveData.VarReputation / 10);
		coreGame.modulesList.ContestBonus(NumContest);
		if (slaveData.BitFlag1.CheckBitFlag(19)) coreGame.Score += 10000;
	
	};
	
	private function CalculatePlacing()
	{
		// get placing
		var rivalarr:Array = new Array(0, 0, 0, 0, 0);
		rivalarr[0] = RivalAScore;
		rivalarr[1] = RivalBScore;
		rivalarr[2] = RivalCScore;
		rivalarr[3] = RivalDScore;
		rivalarr[4] = RivalEScore;
		rivalarr.sort(Array.NUMERIC);

		if (coreGame.Score < rivalarr[0]) Placing = 6;
		else if (coreGame.Score < rivalarr[1]) Placing = 5;
		else if (coreGame.Score < rivalarr[2]) Placing = 4;
		else if (coreGame.Score < rivalarr[3]) Placing = 3;
		else if (coreGame.Score < rivalarr[4]) Placing = 2;
		else Placing = 1;
		
		delete rivalarr;
	}
	
	private function CommonStart()
	{
		coreGame.modulesList.StartContest(NumContest, cact);
		AddText("\r\r");
		
		CalculatePlacing();
		
		SMMoney(SMData.GuildMember ? -20 : -100);
		
		coreGame.DoEvent(0);
	}


	// Custom contests

	public function AddCustomContest(slabel:String, hint:String, nname:String) : Number
	{
		var bHide:Boolean = false;
		var actno:Number;
		if (nname != undefined && coreGame.slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = coreGame.slaveData.ActInfoBase.GetActByName(nname).Act;
		else {
			bHide = true;
			actno = coreGame.slaveData.ActInfoBase.GetFreeAct(11);
		}
		var act:ActInfo = coreGame.slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 2);
		if (bHide) act.HideAct();
		act.Type = 11;
		if (nname != undefined && act.strNodeName == "") {
			act.strNodeName = nname;
			act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
		}
		return actno;
	}
	
	public function ShowCustomContest(cshow:Boolean, cobj:Object)
	{
		if (cobj == undefined) cobj = 1;
		if (cshow == undefined) cshow = true;
		if (!isNaN(cobj)) coreGame.slaveData.ActInfoBase.GetActRO("SlaveContest" + Number(cobj)).ShowAct(cshow);
		else coreGame.slaveData.ActInfoBase.GetActRO(String(cobj)).ShowAct(cshow);
	}
	
	public function HideCustomContest(cobj:Object) { ShowCustomContest(false, cobj); }
	
	public function ContestCustom(act:ActInfo)
	{
		var len:Number = coreGame.slaveData.ActInfoBase.GetActCounts();
		var acti:ActInfo;
		NumContest = 0;

		for (var i:Number = 0; i < len; i++) {
			acti = coreGame.slaveData.ActInfoBase.GetActByIndex(i);
			if (acti.Type != 11) continue;
			if (acti.strNodeName == "" || acti.Name == "") continue;
			if (acti != act) continue;
			if (NumContest == 0) NumContest = 90;
			else if (NumContest == 90) NumContest = 500;
			else NumContest += 100;
			break;
		}
		if (NumContest == 0) NumContest = 90;
				
		ContestsIntro();
			
		RivalAScore = 243 + (coreGame.Difficulty * 5);
		RivalBScore = 310 + (coreGame.Difficulty * 5);
		RivalCScore = 194 + (coreGame.Difficulty * 5);
		RivalDScore = 141 + (coreGame.Difficulty * 5);
		RivalEScore = 115 + (coreGame.Difficulty * 5);
		
		coreGame.TotalContestCustom++;
		
		cact = act;
		act.TotalDone++;
		coreGame.EventTotal = act.TotalDone;
		CommonStart();
	}
	
	
	// XXX Contest
	
	public function ContestXXX()
	{
		var diff:Number = coreGame.DifficultyXXXContest;
		if (diff == undefined) diff = 35;
		if (Math.ceil(coreGame.VarObedience) < diff) coreGame.Refused(10002, "", "",0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		else {
			NumContest = 40;
			ContestsIntro();
			
			RivalAScore = 243 + ((coreGame.TotalContestXXX + coreGame.Difficulty) * 5);
			RivalBScore = 310 + ((coreGame.TotalContestXXX + coreGame.Difficulty) * 5);
			RivalCScore = 194 + ((coreGame.TotalContestXXX + coreGame.Difficulty) * 5);
			RivalDScore = 141 + ((coreGame.TotalContestXXX + coreGame.Difficulty) * 5);
			RivalEScore = 115 + ((coreGame.TotalContestXXX + coreGame.Difficulty) * 5);
			if (coreGame.LesbianTraining) coreGame.Score = coreGame.Score + Math.floor(slaveData.VarBlowJob + slaveData.VarFuck);
			else coreGame.Score = coreGame.Score + slaveData.VarBlowJobRounded + slaveData.VarFuckRounded;
			coreGame.Score = coreGame.Score + slaveData.VarCharismaRounded + slaveData.VarNymphomaniaRounded + slaveData.VarConstitutionRounded;
			if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
			
			coreGame.TotalContestXXX++;
			coreGame.EventTotal = coreGame.TotalContestXXX;
			
			cact = new ActInfo(null, coreGame, "XXX");
			CommonStart();
		}
	}
		
	public function ContestBeauty()
	{
		NumContest = 30;
		ContestsIntro();
		
		RivalAScore = 180 + ((coreGame.TotalContestBeauty + coreGame.Difficulty) * 5);
		RivalBScore = 103 + ((coreGame.TotalContestBeauty + coreGame.Difficulty) * 5);
		RivalCScore = 77 + ((coreGame.TotalContestBeauty + coreGame.Difficulty) * 5);
		RivalDScore = 150 + ((coreGame.TotalContestBeauty + coreGame.Difficulty) * 5);
		RivalEScore = 65 + ((coreGame.TotalContestBeauty + coreGame.Difficulty) * 5);
		coreGame.Score += slaveData.VarCharismaRounded + slaveData.VarRefinementRounded + Math.floor(slaveData.VarLibidoRounded / 2);
		if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
		
		coreGame.TotalContestBeauty++;
		coreGame.EventTotal = coreGame.TotalContestBeauty;
		
		cact = new ActInfo(null, coreGame, "Beauty");
		CommonStart();
	}
		
	public function ContestCourt()
	{
		NumContest = 10;
		ContestsIntro();
		
		RivalAScore = 110 + ((coreGame.TotalContestCourt + coreGame.Difficulty) * 5);
		RivalBScore = 70 + ((coreGame.TotalContestCourt + coreGame.Difficulty) * 5);
		RivalCScore = 154 + ((coreGame.TotalContestCourt + coreGame.Difficulty) * 5);
		RivalDScore = 250 + ((coreGame.TotalContestCourt + coreGame.Difficulty) * 5);
		RivalEScore = 105 + ((coreGame.TotalContestCourt + coreGame.Difficulty) * 5);
		coreGame.Score = coreGame.Score + slaveData.VarSensibilityRounded + slaveData.VarRefinementRounded + slaveData.VarIntelligenceRounded + slaveData.VarConversationRounded;
		if (coreGame.IsDressCourtly()) coreGame.Score = coreGame.Score + 4;
		if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
		
		coreGame.TotalContestCourt++;
		coreGame.EventTotal = coreGame.TotalContestCourt;
		
		cact = new ActInfo(null, coreGame, "LadyOfTheCourt");
		CommonStart();
	}
	
	public function ContestPonygirl()
	{
		if (!coreGame.IsPonygirl()) {
			SlaveSpeak(coreGame.SlavePronoun + " am not that sort of slave. " + coreGame.SlavePronoun + " am not a pony!");
			BlankLine();
			Bloop();
		} else {
			if (coreGame.BitGagWorn == 0 || coreGame.HarnessWorn == 0 || (coreGame.PonyTailWorn == 0 && !slaveData.HasTail)) PersonSpeak("Mistress of the Race", "I am sorry your slave is not fully outfitted.");
			else if (coreGame.PonyCartOK == 0) PersonSpeak("Mistress of the Race", "You do not have a cart for your ponygirl to pull. You cannot enter the race without one.");
			else { 
				NumContest = 50;
				ContestsIntro();
				
				coreGame.TotalContestPonygirl++;
				coreGame.Score = coreGame.Score + slaveData.VarObedienceRounded + slaveData.VarConstitutionRounded - (slaveData.VarFatigue / 4);
				if (coreGame.LeashWorn == 1) coreGame.Score = coreGame.Score + 5;
				if (coreGame.NippleChainWorn == 1) coreGame.Score = coreGame.Score + 5;
				if (coreGame.NippleRingsWorn == 1) coreGame.Score = coreGame.Score + 2;
				if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
				
				coreGame.EventTotal = coreGame.TotalContestPonygirl;
				cact = new ActInfo(null, coreGame, "PonygirlRace");
				CommonStart();
				
				if (coreGame.Score < (100 + (coreGame.Difficulty * 5))) Placing = 5;
				else if (coreGame.Score < (140 + (coreGame.Difficulty * 5))) Placing = 4;
				else if (coreGame.Score < (160 + (coreGame.Difficulty * 5))) Placing = 3;
				else if (coreGame.Score < (195 + (coreGame.Difficulty * 5))) Placing = 2;
				else Placing = 1;
			}
		}
	}
	
	public function ContestHousework()
	{
		NumContest = 20;
		ContestsIntro();
		
		RivalAScore = 60 + ((coreGame.TotalContestHousework + coreGame.Difficulty) * 5);
		RivalBScore = 120 + ((coreGame.TotalContestHousework + coreGame.Difficulty) * 5);
		RivalCScore = 100 + ((coreGame.TotalContestHousework + coreGame.Difficulty) * 5);
		RivalDScore = 40 + ((coreGame.TotalContestHousework + coreGame.Difficulty) * 5);
		RivalEScore = 150 + ((coreGame.TotalContestHousework + coreGame.Difficulty) * 5);
		coreGame.Score = coreGame.Score + slaveData.VarCookingRounded + slaveData.VarCleaningRounded;
		if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
	
		coreGame.TotalContestHousework++;
		coreGame.EventTotal = coreGame.TotalContestHousework;
		
		cact = new ActInfo(null, coreGame, "Housework");
		CommonStart();
	}
	
	public function ContestHouseworkAdvanced()
	{
		NumContest = 100;
		Language.XMLData.XMLGeneral("Contests/AdvancedHousework/StartContest");
		if (coreGame.ApronWorn == 0) {
			BlankLine();
			PersonSpeak(47, "I am sorry, you may not enter this contest you must wear an apron!", true);
			Bloop();
		} else if (coreGame.DressWorn >= 0) {
			HideImages();
			BlankLine();
			PersonSpeak(47, "I am sorry, you may not enter this contest you must <i>only</i> wear an apron!", true);
			BlankLine();
			AddText("Will #slave remove all clothing except for #slavehisher apron?\r");
			DoYesNoEvent(14);
			Bloop();
		} else {
			ContestsIntro();
			if (coreGame.SlaveGirl.ShowNakedApron() != true) coreGame.Generic.ShowNakedApron();
			RivalAScore = 100 + ((coreGame.TotalContestHouseworkAdvanced + coreGame.Difficulty) * 5);
			RivalBScore = 270 + ((coreGame.TotalContestHouseworkAdvanced + coreGame.Difficulty) * 5);
			RivalCScore = 210 + ((coreGame.TotalContestHouseworkAdvanced + coreGame.Difficulty) * 5);
			RivalDScore = 150 + ((coreGame.TotalContestHouseworkAdvanced + coreGame.Difficulty) * 5);
			RivalEScore = 350 + ((coreGame.TotalContestHouseworkAdvanced + coreGame.Difficulty) * 5);
			coreGame.Score += slaveData.VarCookingRounded + slaveData.VarCleaningRounded + slaveData.VarCharismaRounded  + slaveData.VarNymphomaniaRounded;
			if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
		
			coreGame.TotalContestHouseworkAdvanced++;
			coreGame.EventTotal = coreGame.TotalContestHouseworkAdvanced;
			
			cact = new ActInfo(null, coreGame, "AdvancedHousework");
			CommonStart();
		}
	}
	
	public function ContestDance()
	{
		NumContest = 60;
		ContestsIntro();
		
		RivalAScore = 340 + ((coreGame.TotalContestDance + coreGame.Difficulty) * 5);
		RivalBScore = 280 + ((coreGame.TotalContestDance + coreGame.Difficulty) * 5);
		RivalCScore = 200 + ((coreGame.TotalContestDance + coreGame.Difficulty) * 5);
		RivalDScore = 170 + ((coreGame.TotalContestDance + coreGame.Difficulty) * 5);
		RivalEScore = 150 + ((coreGame.TotalContestDance + coreGame.Difficulty) * 5);
		
		coreGame.Score = coreGame.Score + slaveData.VarConstitutionRounded + slaveData.VarRefinementRounded;
		coreGame.Score = coreGame.Score + Math.floor(coreGame.slDancing * 30);
		if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
		
		coreGame.TotalContestDance++;
		coreGame.EventTotal = coreGame.TotalContestDance;
		
		cact = new ActInfo(null, coreGame, "Dance");
		CommonStart();
	}
	
	public function ContestGeneralKnowledge()
	{
		NumContest = 70;
		ContestsIntro();
		
		RivalAScore = 150 + ((coreGame.TotalContestGeneralKnowledge + coreGame.Difficulty) * 5);
		RivalBScore = 120 + ((coreGame.TotalContestGeneralKnowledge + coreGame.Difficulty) * 5);
		RivalCScore = 100 + ((coreGame.TotalContestGeneralKnowledge + coreGame.Difficulty) * 5);
		RivalDScore = 80 + ((coreGame.TotalContestGeneralKnowledge + coreGame.Difficulty) * 5);
		RivalEScore = 60 + ((coreGame.TotalContestGeneralKnowledge + coreGame.Difficulty) * 5);
		
		coreGame.Score += slaveData.VarIntelligenceRounded + slaveData.VarMoralityRounded;
		if (SMData.SMAdvantages.CheckBitFlag(26)) coreGame.Score += 10;
		
		coreGame.TotalContestGeneralKnowledge++;
		coreGame.EventTotal = coreGame.TotalContestGeneralKnowledge;
		
		cact = new ActInfo(null, coreGame, "GeneralKnowledge");
		CommonStart();
	}
		
	public function DoCounted(count:Number, desc:String)
	{
		AddText("\r\r  " + count + " " + desc);
		if (count > 1 || count == 0) AddText("s");
	}
	
	public function Trophies()
	{
		coreGame.SwapDress();
		NumContest = 2000;
		if (coreGame.TrophyOK == 0) {
			var totalwon = 0;
			if (coreGame.WinXXX > 0) totalwon++;
			if (coreGame.WinBeauty > 0) totalwon++;
			if (coreGame.WinCourt > 0) totalwon++;
			if (coreGame.WinHousework > 0) totalwon++;
			if (coreGame.WinHouseworkAdvanced > 0) totalwon++;
			if (coreGame.WinDance > 0) totalwon++;
			if (coreGame.WinGeneralKnowledge > 0) totalwon++;
			if (totalwon == 4) {
				coreGame.TrophyOK = 1;
				coreGame.ObjectTrophy._visible = true;
				AddText("There is an additional award ceremony, as it is announced that " + "#slave is a Grand Champion, winning all four standard contests!! #slaveis presented with a Grand Trophy and an additional reward of money.\r\r");
				slaveData.VarJoy = slaveData.VarJoy + 5;
				Money(375);
				SMMoney(125);
				Diary.AddEntry("#slave was declared the Grand Champion");
			} else {
				SetText("So far #slaveheshe has won a total of " + totalwon + " separate standard contests.");
				if (coreGame.WinPonygirl > 0) AddText("\r#slave has also won a Ponygirl Race.");
				AddText("\r\r#slave has won:");
				DoCounted(coreGame.WinBeauty, "Beauty contest");
				DoCounted(coreGame.WinHousework, "Housework contest");
				if (slaveData.BitFlag1.CheckBitFlag(36)) DoCounted(coreGame.WinHouseworkAdvanced, "Advanced Housework contest");
				DoCounted(coreGame.WinCourt, "Court contest");
				DoCounted(coreGame.WinXXX, "XXX contest");
				DoCounted(coreGame.WinDance, "Dance contest");
				DoCounted(coreGame.WinGeneralKnowledge, "General Knowledge contest");
				if (coreGame.PonygirlsOn) DoCounted(coreGame.WinPonygirl, "Ponygirl race");
				if (coreGame.WinCustom > 0) DoCounted(coreGame.WinCustom, "Other contest");
				BlankLine();
			}
		}
		if (coreGame.SmallTrophyOK == 0) {
			if (coreGame.WinXXX > 3 || coreGame.WinBeauty > 3 || coreGame.WinCourt > 3 || coreGame.WinHousework > 3 || coreGame.WinPongirl > 3 || coreGame.WinDance > 3 || coreGame.WinGeneralKnowledge > 3) {
				coreGame.SmallTrophyOK = 1;
				coreGame.ObjectTrophy._visible = true;
				AddText("\r\rThere is an additional award ceremony, as it is announced that " + "#slave is a Champion, winning a contest four times!! #slaveis presented with a Champion Trophy and a small additional reward of money.\r\r");
				slaveData.VarJoy = slaveData.VarJoy + 2;
				Money(150);
				SMMoney(50);
				Diary.AddEntry("#slave was declared a Champion");
			}
		}
	}
	
	public function DoContestsNext()
	{
		coreGame.Hints.HideHints();
		Beep();
		SetText("");
		Backgrounds.ResetBackgrounds();
		
		// values 0, 1, 2 etc
		coreGame.EventTotal = NumContest - (int(NumContest / 10) * 10);
		
		if (coreGame.modulesList.DoContestsNext(NumContest, cact.Act) == true) {
			if (NumContest < 1000) NumContest++;
			else coreGame.WinContest = Placing;
			AddText("\r\r");
			ShowContestsNext();
			return;
		}
		if (cact != null && NumContest < 1000) {
			HideImages();
			coreGame.HideImages();
			ShowContestsNext();
			var bDone:Boolean = Language.XMLData.XMLGeneral(cact.strNodeName + "/ContestNext");
			if (!bDone) bDone = Language.XMLData.XMLGeneral("Contests/" + cact.strNodeName+ "/ContestNext");
			if (bDone) {
				BlankLine();
				if (NumContest < 1000) NumContest++;
				else coreGame.WinContest = Placing;
				return;
			}
		}
		
		if (NumContest > 9 && NumContest < 20) DoContestCourt();
		else if (NumContest > 19 && NumContest < 30) DoContestHousework();
		else if (NumContest > 29 && NumContest < 40) DoContestBeauty();
		else if (NumContest > 39 && NumContest < 50) DoContestXXX();
		else if (NumContest > 49 && NumContest < 60) DoContestPonygirl();
		else if (NumContest > 59 && NumContest < 70) DoContestDance();
		else if (NumContest > 69 && NumContest < 80) DoContestGeneralKnowledge();
		// 90-99 is reserved for custom contests
		else if (NumContest > 99 && NumContest < 110) DoContestHouseworkAdvanced();
		else if (NumContest == 1000) Trophies();
	
		if (NumContest == 2000) {
			bContestStarted = false;
			cact = null;
			HideImages();
			coreGame.UpdateSlave();
			coreGame.dspMain.ShowMainButtons();
			coreGame.SetTime(11);
			coreGame.LoadSave.SaveGameString("auto");
			Language.XMLData.XMLGeneral("Contests/ContestsOver");
			BlankLine();
			//AddText(Language.GetHtml("ContestsOver", "Contests") + "\r\r");
		}
		if (NumContest < 1000) {
			NumContest++;
			AddText("\r\r");
		}
	}
	
	public function DoContestCourt()
	{
		Backgrounds.ShowPalace();
		
		if (NumContest == 10)
		{
			temp = slrandom(3);
			mcBase.ClipRivalACourt.gotoAndStop(temp);
			mcBase.ClipRivalACourt._visible = true;
			switch(temp) {
				case 1: 
					AddText("This woman was elegant and pretty.\r\rShe was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 2:
					AddText("This sultry young woman was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 3:
					AddText("This exotic beauty was poised and refined.\r\rShe was awarded : " +  RivalAScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 11)
		{
			mcBase.ClipRivalACourt._visible = false;
			temp = slrandom(3);
			mcBase.ClipRivalBCourt.gotoAndStop(temp);
			mcBase.ClipRivalBCourt._visible = true;
			switch(temp) {
				case 1: 
					AddText("This girl was a bit odd but still elegant.\r\rShe was scored : " +  RivalBScore + "pts\r\r");
					break;
				case 2:
					AddText("This noble young woman was very well behaved, but showed a lot of cleavage. The judges did not object.\r\rShe was scored : " +  RivalBScore + "pts\r\r");
					break;
				case 3:
					AddText("This cat-slave was very happy and refined.\r\rShe was awarded : " +  RivalBScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 12)
		{
			mcBase.ClipRivalBCourt._visible = false;
			temp = slrandom(2);
			mcBase.ClipRivalCCourt.gotoAndStop(temp);
			mcBase.ClipRivalCCourt._visible = true;
			switch(temp) {
				case 1: 
					AddText("Miss.N was surprisingly elegant despite her habit of being blunt and truthful.\r\rShe was scored : " +  RivalCScore + "pts\r\r");
					break;
				case 2:
					AddText("This noble young woman was quiet and elegant and showed some cleavage.\r\rShe was scored : " +  RivalCScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 13)
		{
			mcBase.ClipRivalCCourt._visible = false;
			temp = slrandom(2);
			mcBase.ClipRivalDCourt.gotoAndStop(temp);
			mcBase.ClipRivalDCourt._visible = true;
			switch(temp) {
				case 1: 
					AddText("Lady Okyanu was elegant and flirtatious, and very friendly and familiar with the judges.\r\rShe was scored : " +  RivalDScore + "pts\r\r");
					break;
				case 2:
					AddText("This elegant young woman was poised and simply dressed.\r\rShe was scored : " +  RivalDScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 14)
		{
			mcBase.ClipRivalDCourt._visible = false;
			temp = slrandom(2);
			mcBase.ClipRivalECourt.gotoAndStop(temp);
			mcBase.ClipRivalECourt._visible = true;
			switch(temp) {
				case 1: 
					if (!coreGame.Maid.IsMet()) AddText("This young woman is charming and gorgeous.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
					else AddText("Sumi, the maid, is charming and gorgeous.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
					break;
				case 2:
					AddText("This attractive young noble woman was very elegant and a delight to talk with. She scored : " +  RivalEScore + "pts\r\r");
					break;
			}
	
		}
		else if (NumContest == 15)
		{
			NumContest = 1000;
			mcBase.ClipRivalECourt._visible = false;
			
			var nscore:Number = coreGame.SlaveGirl.ShowContestCourt(coreGame.Score);
			if (nscore == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10006);
				if (!coreGame.UseGeneric) nscore = coreGame.Score;
			}
			if (nscore != undefined) coreGame.Score = nscore;
			else {
				coreGame.SlaveGirl.ShowSchoolRefinement();
				if (coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(1008);
			}			

			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) AddText("The contest was fixed so " + "#slave came ");
			else AddText("#slave obtained : " + coreGame.Score + "pts and came ");
			slaveData.BitFlag1.ClearBitFlag(19);
	
			if (Placing == 6) {
				Diary.AddEntry("#slave came last place in the Lady of the Court contest.");
				AddText("last place.\r\r");
			} else if (Placing == 5) {
				Diary.AddEntry("#slavecame fifth place in the Lady of the Court contest.");
				AddText("5th place.\r\r");
			} else if (Placing == 4) {
				Diary.AddEntry("#slave came fourth place in the Lady of the Court contest.");
				AddText("4th place.\r\r");
			} else if (Placing == 3)
			{
				AddText("3rd place.\r\rYou win 500GP");
				Money(330);
				SMMoney(170);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the Lady of the Court contest.", false, 3);
			}
			else if (Placing == 2)
			{
				AddText("2nd place.\r\rYou win 700GP");
				Money(525);
				SMMoney(175);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the Lady of the Court contest.", false, 2);
			}
			else
			{
				AddText("1st place!\r\rYou win 1500GP");
				Money(1125);
				SMMoney(375);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				slaveData.VarRefinement = slaveData.VarRefinement + 10;
				coreGame.WinCourt = coreGame.WinCourt + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave won the Lady of the Court Contest!", false, 1);
			}
		}
	}
	
	public function DoContestHousework()
	{
		if (NumContest == 20)
		{
			if (IsDickgirlEvent()) temp = 3;
			else temp = slrandom(2);
			ShowMovie(mcBase.ClipRivalAHousework, 1.1, 1, temp);
			mcBase.ClipRivalAHousework._visible = true;
			switch(temp) {
				case 1: 
					AddText("This girl is a skilled maid but often flashed her panties. A judge commented about her 'advanced' potential'.\r\rThe girl was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 2:
					AddText("This girl is happy and skilled at housework.\r\rShe was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 3:
					Backgrounds.ShowKitchen();
					AddText("This girl is quite skilled at cleaning, but often a shape can be seen bulging under her skirt.\r\rShe was scored : " +  RivalAScore + "pts\r\r");
					break;
			}
		} else 	if (NumContest == 21)
		{
			mcBase.ClipRivalAHousework._visible = false;
			if (IsDickgirlEvent()) temp = 3;
			else temp = slrandom(2);
			switch(temp) {
				case 1: 
					Backgrounds.ShowKitchen();
					ShowMovie(mcBase.ClipRivalBHousework, 1.1, 1, temp);
					AddText("These girls are twin sisters and work as a well coordinated team. The judges are impressed.\r\rThey are given a score of : " +  RivalBScore + "pts\r\r");
					break;
				case 2:
					ShowMovie(mcBase.ClipRivalBHousework, 1.1, 1, temp);
					AddText("This woman has little interest in housework, but still worked well, all for her Master.\r\rShe was scored : " +  RivalBScore + "pts\r\r");
					break;
				case 3:
					if (coreGame.DickgirlTesticles) temp++;
					ShowMovie(mcBase.ClipRivalBHousework, 1.1, 1, temp);
					if (temp == 4) AddText("This girl is very capable at housework, and very clearly a hermaphrodite, finding it difficult to conceal her cock and balls. The judges compliment her and suggest she has 'advanced' potential.\r\rShe is scored : " +  RivalBScore + "pts\r\r");
					else AddText("This girl is very capable at housework, and very clearly a hermaphrodite, finding it difficult to conceal her cock. The judges compliment her and suggest she has 'advanced' potential.\r\rShe is scored : " +  RivalBScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 22)
		{
			mcBase.ClipRivalBHousework._visible = false;
			temp = slrandom(2);
			if (temp == 1) {
				ShowMovie(mcBase.ClipRivalCHousework, 1, 0, temp);
				AddText("This young woman was very charming and skilled.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
			} else {
				ShowMovie(mcBase.ClipRivalCHousework, 1.1, 1, temp);
				AddText("This cat-slave was very popular with the judges.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
			}
		}
		else if (NumContest == 23)
		{
			mcBase.ClipRivalCHousework._visible = false;
			if (IsDickgirlEvent()) temp = 3;
			else temp = slrandom(2);
			switch(temp) {
				case 1:
					ShowMovie(mcBase.ClipRivalDHousework, 1.1, 1, temp);
					AddText("This girl was charming but often needed to consult cooking books. Still she was an excellent cook.\r\rShe was scored : " +  RivalDScore + "pts\r\r");
					break;
				case 2:
					ShowMovie(mcBase.ClipRivalDHousework, 1, 0, temp);
					AddText("This maid was rather distracted but cleaned very well. The judges were rather impressed when she cleaned the windows with her breasts, more so when she clearly orgasmed at the end. A judge privately speaks to her and you hear the word 'Advanced'.\r\rThe girl gets the score : " +  RivalAScore + "pts\r\r");
					break;
				case 3:
					ShowMovie(mcBase.ClipRivalDHousework, 1.1, 1, temp);
					AddText("This girl was quite skilled, but part of the way through her cleaning she stops and takes out her cock and quickly masturbates, cumming powerfully on the floor. She skillfully cleans up after herself.\r\rThe judges comment that it is good she feels passionately for her housework and encourage her to do so as much as she likes, as long as she cleans up after.\r\rShe is scored : " +  RivalDScore + "pts\r\r");
					break;
			}
	
		}
		else if (NumContest == 24)
		{
			Backgrounds.ShowKitchen();
			mcBase.ClipRivalDHousework._visible = false;
			ShowPerson(5, 1, 1, 1);
			if (!coreGame.Maid.IsMet()) AddText("This young woman is charming and superb at housework. She was complimented by the judges.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
			else AddText("Sumi, the maid, is charming and superb at housework. She was complimented by the judges.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
		}
		else if (NumContest == 25)  // D A C B E
		{
			NumContest = 1000;
			Backgrounds.ShowKitchen();
			ShowPerson(5, 0, 1, 1);
			
			coreGame.UseGeneric = false;
			var nscore:Number = coreGame.SlaveGirl.ShowContestHousework(coreGame.Score);
			if (nscore == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10004);
				if (!coreGame.UseGeneric) nscore = coreGame.Score;
			}
			if (nscore != undefined) coreGame.Score = nscore;
			else {
				coreGame.SlaveGirl.ShowChoreCooking();
				if (coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(1001);
			}	
			if (coreGame.UseGeneric) coreGame.Generic.ShowContestHousework(coreGame.Score);
			
			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) AddText("The contest was fixed so " + "#slave came ");
			else AddText("#slave obtained : " + coreGame.Score + "pts, and came ");
			slaveData.BitFlag1.ClearBitFlag(19);
			coreGame.DoEvent(0);
	
			if (Placing == 6){
				AddText("last place.\r\r");
				Diary.AddEntry("#slave came last place in the Housework contest.");
				return;
			} else if (Placing == 5) {
				Diary.AddEntry("#slave came fifth place in the Housework contest.");
				AddText("5th place.\r\r");
				return;
			} else if (Placing == 4) {
				Diary.AddEntry("#slave came fourth place in the Housework contest.");
				AddText("4th place.\r\r");
				return;
			} else if (Placing == 3)
			{
				slaveData.VarCooking = slaveData.VarCooking + 1;
				slaveData.VarCleaning = slaveData.VarCleaning + 1;
				AddText("3rd place.\r\rYou win 100GP");
				Money(75);
				SMMoney(25);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the Housework contest.", false, 3);
			}
			else if (Placing == 2)
			{
				slaveData.VarCooking = slaveData.VarCooking + 1;
				slaveData.VarCleaning = slaveData.VarCleaning + 1;
				AddText("2nd place.\r\rYou win 500GP");
				Money(375);
				SMMoney(125);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the Housework contest.", false, 2);
			}
			else
			{
				AddText("1st place.\r\rYou win 700GP");
				Money(525);
				SMMoney(175);
				slaveData.VarCooking = slaveData.VarCooking + 10;
				slaveData.VarCleaning = slaveData.VarCleaning + 10;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				slaveData.VarJoy = slaveData.VarJoy + 10;
				coreGame.WinHousework =  coreGame.WinHousework + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave won the Housework contest.", false, 1);
			}
			if (!slaveData.BitFlag1.CheckBitFlag(36)) {
				slaveData.BitFlag1.SetBitFlag(36);
				AddText("\r\rAfter the contest a judge speaks to you,\r\r");
				PersonSpeak("Judge", "Your slave is quite skilled and shows some potential. There is another contest " + coreGame.SlaveHeShe + " may wish to try. It is an Advanced version of this Housework contest. In it " +coreGame.SlaveHeSheIs + " judged on presentation and attitude as well and skill at housework.\r\rCompetitors are <i>only</i> required to wear an apron. I look forward to seeing your slave in the next contest.", true);
			}
		}
	}
	
	public function DoContestHouseworkAdvanced()
	{
		if (NumContest == 100)
		{
			coreGame.HideImages();
			HideImages();
			coreGame.HideSlaveActions();
			coreGame.DoEvent(0);
			if (IsDickgirlEvent() && slrandom(2) == 1) temp = 4;
			else temp = slrandom(3);
			switch(temp) {
				case 1: 
					ShowMovie(mcBase.ClipRivalAHouseworkAdvanced, 1, 0, temp);
					AddText("This girl is a bit ditzy and gas simple cooking skills. Her other qualities, large and round, make up for \r\rShe was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 2:
					ShowMovie(mcBase.ClipRivalAHouseworkAdvanced, 1, 0, temp);
					AddText("This girl is happy and skilled at housework. Her apron was pretty and clung well to her.\r\rShe was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 3:
					Backgrounds.ShowKitchen();
					ShowMovie(mcBase.ClipRivalAHouseworkAdvanced, 1.1, 1, temp);
					AddText("This girl demonstrated excellent assets and was quite happy to show them to the judges.\r\rShe was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 4:
					if (coreGame.DickgirlTesticles) temp = 5;
					ShowMovie(mcBase.ClipRivalAHouseworkAdvanced, 1, 2, temp);
					if (temp == 5) AddText("This girl is a skilled cook and clearly excited by the contest. The judges complain about her lack of an apron. She explains that just before the start of the contest she had cum...spilt something on it.\r\rShe shows the judges her apron and proceeds to wash it. While washing she comments that her Mistress normally required her to lick up any spills...\r\rThe judges are appreciative and score her : " +  RivalAScore + "pts\r\r");
					else AddText("This girl is a skilled cook and clearly excited by the contest. The judges are impressed how one of her hands never leaves her cock, stroking hard but she does not quite cum. The judges inquire, and she complains it is her Mistresses orders, she must stay hard and ready to cum, wherever or whenever her Mistress orders, but usually in her Mistresses mouth.\r\rThe judges are appreciative of her obedience and score her : " +  RivalAScore + "pts\r\r");
					break;
			}
		} else 	if (NumContest == 101)
		{
			mcBase.ClipRivalAHouseworkAdvanced._visible = false;
			if (IsDickgirlEvent() && slrandom(2) == 1) temp = 4;
			else temp = slrandom(3);
			switch(temp) {
				case 1: 
					ShowMovie(mcBase.ClipRivalBHouseworkAdvanced, 1, 0, temp);
					AddText("This girl <i>acts</i> embarrassed to be naked while doing housework, but it is clear she enjoys it. The judges like the pretense.\r\rShe is scored : " +  RivalBScore + "pts\r\r");
					break;
				case 2:
					ShowMovie(mcBase.ClipRivalBHouseworkAdvanced, 1, 0, temp);
					AddText("The judges are impressed with this girl's apron, how it is designed to be worn naked. The girl is a fine cook and shows her talents well.\r\rShe was scored : " +  RivalBScore + "pts\r\r");
					break;
				case 3:
					Backgrounds.ShowKitchen();
					ShowMovie(mcBase.ClipRivalBHouseworkAdvanced, 1.1, 1, temp);
					AddText("This girl is so happy and seems very pleased to be serving. The judges compliment her attitude.\r\rShe is scored : " +  RivalBScore + "pts\r\r");
					break;
				case 4:
					Backgrounds.ShowKitchen();
					if (coreGame.DickgirlTesticles) temp = 5;
					ShowMovie(mcBase.ClipRivalBHouseworkAdvanced, 1.1, 1, temp);
					AddText("The judges ask why she is wearing a uniform and she apologises, explaining while touching her cock,\r\r");
					PersonSpeak("Slave", "My Master has ordered me to wear it. The last time I was naked many people complimented me and particularly my cock.", true);
					AddText("\rShe is now quickly stroking her cock\r");
					PersonSpeak("Slave", "Of course that meant I had to fuck them, or let them fuck me. To show my cock at its best. My master found me fucking a woman with cocks in my pussy and mouth. I had cum so many, many uhhhhh times!", true);
					AddText("\r\rShe cums powerfully and the judges excuse her from competing, but give her a score  : " +  RivalBScore + "pts\r\rThey then compliment her cock...");
					break;
			}
		}
		else if (NumContest == 102)
		{
			mcBase.ClipRivalBHouseworkAdvanced._visible = false;
			if (IsDickgirlEvent() && slrandom(2) == 1) temp = slrandom(2) + 4;
			else temp = slrandom(4);
	
			switch (temp) {
				case 1:
					ShowMovie(mcBase.ClipRivalCHouseworkAdvanced, 1, 0, temp);
					AddText("This young woman was a very skilled cook and has a nice body.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
					break;
				case 2:
					ShowMovie(mcBase.ClipRivalCHouseworkAdvanced, 1, 0, temp);
					AddText("This girl was competent at housework but has a lovely body.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
					break;
				case 3:
					Backgrounds.ShowKitchen();
					ShowMovie(mcBase.ClipRivalCHouseworkAdvanced, 1.1, 1, temp);
					AddText("This girl is very skilled and flaunts her body in a very seductive way.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
					break;
				case 4:
					Backgrounds.ShowKitchen();
					ShowMovie(mcBase.ClipRivalCHouseworkAdvanced, 1.1, 1, temp);
					AddText("This girl is quite skilled and flirts with the judges.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
					break;
				case 5:
					if (coreGame.DickgirlTesticles) temp = 6;
					ShowMovie(mcBase.ClipRivalCHouseworkAdvanced, 1.1, 1, temp);
					AddText("After cooking this girl removes her apron showing her large erect cock. She quickly masturbates and cums powerfully over the plates of food. She smiles explaining it is her Mistresses favourite topping.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
					break;
				case 6:
					if (coreGame.DickgirlTesticles) temp = 7;
					ShowMovie(mcBase.ClipRivalCHouseworkAdvanced, 1, 0, temp);
					AddText("This cat-slave was very popular with the judges, acting very cat-like.\r\rShe obtained : " +  RivalCScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 103)
		{
			mcBase.ClipRivalCHouseworkAdvanced._visible = false;
			if (IsDickgirlEvent()) temp = 4;
			else temp = slrandom(3);
			switch(temp) {
				case 1:
					Backgrounds.ShowBeach();
					ShowMovie(mcBase.ClipRivalDHouseworkAdvanced, 1.1, 1, temp);
					AddText("Lady Okyanu flirts well with the judges and make an excellent flat pastry. She does seem a little awkward in the apron, clearly preferring an elegant dress, or nothing.\r\rStill she was an excellent cook and was scored : " +  RivalDScore + "pts\r\r");
					break;
				case 2:
					ShowMovie(mcBase.ClipRivalDHouseworkAdvanced, 1, 0, temp);
					AddText("This shows her assets well but her cooking is a bit basic. He figure makes up for her lack of cooking skill.\r\rThe girl gets the score : " +  RivalDScore + "pts\r\r");
					break;
				case 3:
					ShowMovie(mcBase.ClipRivalDHouseworkAdvanced, 1, 0, temp);
					AddText("This girl is very cute in her apron, but somewhat messy.\r\rThe judges appreciate her spilling cream on herself, especially when she invites them to lick it off.\r\rShe is licked and scored : " +  RivalDScore + "pts\r\r");
					break;
				case 4:
					if (!coreGame.DickgirlTesticles) {
						AddText("This maid had an unusual way to add milk to some tea. asked a judge to assist by massaging her breasts while she masturbated her cock. She came over her breasts, but the milk spurted from her breasts into the tea.\r\rShe is scored : " +  RivalDScore + "pts\r\r");
					} else {
						temp = 5;
						Backgrounds.ShowOverlay(0);
						AddText("This cat-slave was quite skilled, but part of the way through she stops and takes out her cock and quickly masturbates, cumming powerfully on the floor. She laughs and leans down and licks it all up.\r\rThe judges comment that it is good she feels passionately for her housework and encourage her to do so as much as she likes, as long as she cleans up after.\r\rShe is scored : " +  RivalDScore + "pts\r\r");
					}
					ShowMovie(mcBase.ClipRivalDHouseworkAdvanced, 1.1, 1, temp);
					break;
			}
	
		}
		else if (NumContest == 104)
		{
			Backgrounds.ShowKitchen();
			mcBase.ClipRivalDHouseworkAdvanced._visible = false;
			ShowPerson(5, 1, 1, 3);
			if (!coreGame.Maid.IsMet()) AddText("This young woman is charming and superb at housework. She is clearly known to the judges and has been given a handicap.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
			else AddText("Sumi, the maid, is charming and superb at housework. She is clearly known to the judges and has been given a handicap.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
		}
		else if (NumContest == 105)  // D A C B E
		{
			NumContest = 1000;
			Backgrounds.ShowKitchen();
			HidePerson(5);
			ShowPerson(47, 0, 6);
			
			coreGame.UseGeneric = false;
			var nscore:Number = coreGame.SlaveGirl.ShowContestAdvancedHousework(coreGame.Score);
			if (nscore == undefined && coreGame.UseImages) coreGame.ShowActImage(10005);
			if (nscore != undefined) coreGame.Score = nscore;
			else {
				if (coreGame.SlaveGirl.ShowNakedApron() != true) coreGame.Generic.ShowNakedApron();
			}
			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) AddText("The contest was fixed so " + "#slave came ");
			else AddText("#slave obtained : " + coreGame.Score + "pts, and came ");
			slaveData.BitFlag1.ClearBitFlag(19);
			coreGame.DoEvent(0);
	
			if (Placing == 6){
				AddText("last place.\r\r");
				Diary.AddEntry("#slave came last place in the Housework contest.");
				return;
			} else if (Placing == 5) {
				Diary.AddEntry("#slave came fifth place in the Housework contest.");
				AddText("5th place.\r\r");
				return;
			} else if (Placing == 4) {
				Diary.AddEntry("#slave came fourth place in the Housework contest.");
				AddText("4th place.\r\r");
				return;
			} else if (Placing == 3)
			{
				slaveData.VarCooking = slaveData.VarCooking + 1;
				slaveData.VarCleaning = slaveData.VarCleaning + 1;
				AddText("3rd place.\r\rYou win 160GP");
				Money(120);
				SMMoney(40);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the Advanced Housework contest.", false, 3);
			}
			else if (Placing == 2)
			{
				slaveData.VarCooking = slaveData.VarCooking + 1;
				slaveData.VarCleaning = slaveData.VarCleaning + 1;
				AddText("2nd place.\r\rYou win 800GP");
				Money(600);
				SMMoney(200);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the Advanced Housework contest.", false, 2);
			}
			else
			{
				AddText("1st place.\r\rYou win 1200GP");
				Money(900);
				SMMoney(300);
				slaveData.VarCooking = slaveData.VarCooking + 10;
				slaveData.VarCleaning = slaveData.VarCleaning + 10;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				slaveData.VarJoy = slaveData.VarJoy + 10;
				coreGame.WinHouseworkAdvanced =  coreGame.WinHouseworkAdvanced + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave won the Advanced Housework contest.", false, 1);
			}
		}
	}
	
	public function DoContestBeauty()
	{
		if (NumContest == 30)
		{
			temp = slrandom(2) + 1;
			mcBase.ClipRivalABeauty.gotoAndStop(temp);
			mcBase.ClipRivalABeauty._visible = true;
			switch(temp) {
				case 2:
					AddText("This attractive young woman was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 3:
					Backgrounds.ShowPalace();
					AddText("This exotic young girl flirted with the judges.\r\rShe was awarded : " +  RivalAScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 31)
		{
			temp = slrandom(2);
			mcBase.ClipRivalABeauty._visible = false;
			mcBase.ClipRivalBBeauty.gotoAndStop(temp);
			mcBase.ClipRivalBBeauty._visible = true;
			switch (temp) {
				case 1: 
					AddText("This girl was rather eccentric.\r\rShe obtained : " +  RivalBScore + "pts\r\r");
					break;
				case 2:
					AddText("This beautiful girl was awarded : " +  RivalBScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 32)
		{
			mcBase.ClipRivalBBeauty._visible = false;
			temp = slrandom(2);
			mcBase.ClipRivalCBeauty.gotoAndStop(temp);
			mcBase.ClipRivalCBeauty._visible = true;
			switch (temp) {
				case 1: 
					Backgrounds.ShowOverlay(0);
					AddText("This woman was elegant and was scored : " +  RivalCScore + "pts\r\r");
					break;
				case 2:
					Backgrounds.ShowBeach(5);
					AddText("This young lady was charming and obtained : " +  RivalCScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 33)
		{
			mcBase.ClipRivalCBeauty._visible = false;
			temp = slrandom(2);
			mcBase.ClipRivalDBeauty.gotoAndStop(temp);
			mcBase.ClipRivalDBeauty._visible = true;
			switch (temp) {
				case 1: 
					Backgrounds.ShowSky(1);
					AddText("This girl was pretty and enthusiastic.\r\rShe was scored : " +  RivalDScore + "pts\r\r");
					break;
				case 2:
					Backgrounds.ShowOverlay(0);
					AddText("This woman was beautiful and seductive.\r\rShe obtained : " +  RivalDScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 34)
		{
			mcBase.ClipRivalDBeauty._visible = false;
			temp = slrandom(2);
			mcBase.ClipRivalEBeauty.gotoAndStop(temp);
			mcBase.ClipRivalEBeauty._visible = true;
			switch(temp) {
				case 1: 
					if (!coreGame.Maid.IsMet()) AddText("This young woman is charming and gorgeous.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
					else AddText("Sumi, the maid, is charming and gorgeous.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
					break;
				case 2:
					AddText("This attractive young woman was very elegant and reserved.\r\rShe scored : " +  RivalEScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 35)
		{
			Backgrounds.ShowPalace();
			NumContest = 1000;
			mcBase.ClipRivalEBeauty._visible = false;
			
			var nscore:Number = coreGame.SlaveGirl.ShowContestBeauty(coreGame.Score);
			if (nscore == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10003);
				if (!coreGame.UseGeneric) nscore = coreGame.Score;
			}
			if (nscore != undefined) coreGame.Score = nscore;
			else {
				coreGame.SlaveGirl.ShowChoreMakeUp();
				if (coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(1005);
			}	

			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) AddText("The contest was fixed so " + "#slave came ");
			else AddText("#slave obtained : " + coreGame.Score + "pts, and came ");
			slaveData.BitFlag1.ClearBitFlag(19);
	
			if (Placing == 6) {
				 Diary.AddEntry("#slave came last place in the Beauty contest.");
				AddText("last place.\r\r");
			} else if (Placing == 5) {
				Diary.AddEntry("#slave came fifth place in the Beauty contest.");
				AddText("5th place.\r\r");
			} else if (Placing == 4) {
				Diary.AddEntry("#slave came fourth place in the Beauty contest.");
				AddText("4th place.\r\r");
			} else if (Placing == 3) 
			{
				AddText("3rd place.\r\rYou win 100GP");
				slaveData.VarCharisma = slaveData.VarCharisma + 1;
				Money(75);
				SMMoney(25);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the Beauty contest.", false, 3);
			}
			else if (Placing == 2)
			{
				AddText("2nd place.\r\rYou win 500GP");
				slaveData.VarCharisma = slaveData.VarCharisma + 1;
				Money(375);
				SMMoney(125);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the Beauty contest.", false, 2);
			}
			else
			{
				AddText("1st place.\r\rYou win 1000GP");
				Money(750);
				SMMoney(250);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarCharisma = slaveData.VarCharisma + 10;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				coreGame.WinBeauty = coreGame.WinBeauty + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave placed first the Beauty contest.", false, 1);
			}
		}
	}
	
	public function DoContestXXX()
	{
		Backgrounds.ShowBedRoom();
		
		if (NumContest == 40)
		{
			if (IsDickgirlEvent()) temp = 4;
			else temp = slrandom(3);
			mcBase.ClipRivalAXXX.gotoAndStop(temp);
			mcBase.ClipRivalAXXX._visible = true;
			AddText("This girl obtained : " +  RivalAScore + "pts\r\r");
		}
		else if (NumContest == 41)
		{
			mcBase.ClipRivalAXXX._visible = false;
			if (IsDickgirlEvent()) temp = 4;
			else temp = slrandom(3);
			mcBase.ClipRivalBXXX.gotoAndStop(temp);
			mcBase.ClipRivalBXXX._visible = true;
			AddText("This girl obtained : " +  RivalBScore + "pts\r\r");
		}
		else if (NumContest == 42)
		{
			mcBase.ClipRivalBXXX._visible = false;
			temp = slrandom(3);
			mcBase.ClipRivalCXXX.gotoAndStop(temp);
			mcBase.ClipRivalCXXX._visible = true;
			AddText("This girl obtained : " +  RivalCScore + "pts\r\r");
		}
		else if (NumContest == 43)
		{
			mcBase.ClipRivalCXXX._visible = false;
			if (IsDickgirlEvent()) temp = 4;
			else temp = slrandom(3);
			mcBase.ClipRivalDXXX.gotoAndStop(temp);
			mcBase.ClipRivalDXXX._visible = true;
			AddText("This girl obtained : " +  RivalDScore + "pts\r\r");
		}
		else if (NumContest == 44)
		{
			mcBase.ClipRivalDXXX._visible = false;
			if (IsDickgirlEvent()) temp = 4;
			else temp = slrandom(3);
			mcBase.ClipRivalEXXX.gotoAndStop(temp);
			mcBase.ClipRivalEXXX._visible = true;
			AddText("This girl obtained : " +  RivalEScore + "pts\r\r");
		}
		else if (NumContest == 45)
		{
			NumContest = 1000;
			mcBase.ClipRivalEXXX._visible = false;
			
			var nscore:Number = coreGame.SlaveGirl.ShowContestXXX(coreGame.Score);
			if (nscore == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10002);
				if (!coreGame.UseGeneric) nscore = coreGame.Score;
			}
			if (nscore != undefined) coreGame.Score = nscore;
			else {
				coreGame.SlaveGirl.ShowSexActFuck();
				if (coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(4);
			}				
			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) AddText("The contest was fixed so " + "#slave came ");
			else AddText("#slave obtained : " + coreGame.Score + "pts, came often, and in ");
			slaveData.BitFlag1.ClearBitFlag(19);
	
			if (Placing == 6) {
				 Diary.AddEntry("#slavecame last place in the XXX contest.");
				AddText("last place.\r\r");
			} else if (Placing == 5) {
				Diary.AddEntry("#slavecame last fifth in the XXX contest.");
				AddText("5th place.\r\r");
			} else if (Placing == 4) {
				Diary.AddEntry("#slavecame fourth place in the XXX contest.");
				AddText("4th place.\r\r");
			} else if (Placing == 3)
			{
				AddText("3rd place.\r\rYou win 200GP");
				slaveData.VarBlowJob = slaveData.VarBlowJob + 1;
				slaveData.VarFuck = slaveData.VarFuck + 1;
				Money(150);
				SMMoney(50);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the XXX contest.", false, 3);
			}
			else if (Placing == 2)
			{
				AddText("2nd place.\r\rYou win 550GP");
				slaveData.VarBlowJob = slaveData.VarBlowJob + 1;
				slaveData.VarFuck = slaveData.VarFuck + 1;
				Money(410);
				SMMoney(140);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the XXX contest.", false, 2);
			}
			else
			{
				AddText("1st place.\r\rYou win 1250GP");
				Money(930);
				SMMoney(320);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				if (coreGame.LesbianTraining) {
					slaveData.VarBlowJob = slaveData.VarBlowJob + 4;
					slaveData.VarFuck = slaveData.VarFuck + 4;
				} else { 
					slaveData.VarBlowJob = slaveData.VarBlowJob + 10;
					slaveData.VarFuck = slaveData.VarFuck + 10;
				}
				slaveData.VarReputation = slaveData.VarReputation + 10;
				coreGame.WinXXX = coreGame.WinXXX + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave placed first the XXX contest!", false, 1);
			}
		}
	}
	
	public function DoContestPonygirl()
	{
		Backgrounds.ShowTownCenter();
		
		if (NumContest == 50) {
			
			AutoLoadImageAndShowMovie("Images/Contests/Ponygirl/Single/Rival A1.jpg", 1.1, 1);
			if (Placing == 5) AddText("This girl came 4th\r\r");
			else AddText("This girl came 5th\r\r");
		}
		else if (NumContest == 51)
		{
			AutoLoadImageAndShowMovie("Images/Contests/Ponygirl/Single/Rival B1.jpg", 1.1, 1);
			if (Placing < 4) AddText("This girl came 4th\r\r");
			else AddText("This girl came 3rd\r\r");
		}
		else if (NumContest == 52)
		{
			AutoLoadImageAndShowMovie("Images/Contests/Ponygirl/Single/Rival C1.jpg", 1.1, 1);
			if (Placing < 3) AddText("This girl came 3rd\r\r");
			else AddText("This girl came 2nd\r\r");
		}
		else if (NumContest == 53)
		{
			AutoLoadImageAndShowMovie("Images/Contests/Ponygirl/Single/Rival D1.jpg", 1.1, 1);
			if (Placing == 1) AddText("This girl came 2nd\r\r");
			else AddText("This girl won the race\r\r");
		} else if (NumContest == 54) {
			NumContest = 1000;
			
			var nscore:Number = coreGame.SlaveGirl.ShowContestPonygirl(coreGame.Score);
			if (nscore == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10009);
				if (!coreGame.UseGeneric) nscore = coreGame.Score;
			}
			if (nscore != undefined) coreGame.Score = nscore;
			if (coreGame.UseGeneric) coreGame.Generic.ShowSexActPonygirl();
	
			if (Placing == 5) {
				 Diary.AddEntry("#slave came last place in the Ponygirl race.");
				AddText("#slavecame last.\r\r");
			} else if (Placing == 4) {
				Diary.AddEntry("#slave came fourth place in the Ponygirl race.");
				AddText("#slavecame 4th place.\r\r");
			} else if (Placing == 3) {
				AddText("#slave came 3rd place.\r\rYou win 600GP");
				Money(450);
				SMMoney(150);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				slaveData.VarConstitution = slaveData.VarConstitution + 1;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave ran third place in the Ponygirl race.", false, 3);
			}
			else if (Placing == 2)
			{
				AddText("#slave came 2nd place.\r\rYou win 800GP");
				Money(600);
				SMMoney(200);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				slaveData.VarConstitution = slaveData.VarConstitution + 1;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave ran second place in the Ponygirl race.", false, 2);
			}
			else
			{
				AddText("#slave won the race!\r\rYou win 1800GP");
				Money(1350);
				SMMoney(450);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				slaveData.VarConstitution = slaveData.VarConstitution + 10;
				coreGame.WinPonygirl = coreGame.WinPonygirl + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave won the Ponygirl race!", false, 1);
			}
		}
	}
	
	public function DoContestDance()
	{
		if (NumContest == 60)
		{
			temp = slrandom(3);
			mcBase.ContestsDanceRivalA.gotoAndStop(temp);
			mcBase.ContestsDanceRivalA._visible = true;
			switch(temp) {
				case 1: 
					AddText("This woman did a sensual but primitive style of dance.\r\rShe obtained : " +  RivalAScore + "pts\r\r");
					break;
				case 2:
					AddText("This attractive young woman was scored : " +  RivalAScore + "pts\r\r");
					break;
				case 3:
					AddText("This pretty young girl danced well.\r\rShe was awarded : " +  RivalAScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 61)
		{
			mcBase.ContestsDanceRivalA._visible = false;
			temp = slrandom(3);
			mcBase.ContestsDanceRivalB.gotoAndStop(temp);
			mcBase.ContestsDanceRivalB._visible = true;
			switch(temp) {
				case 1: 
					AddText("This girl did an athletic dance.\r\rShe obtained : " +  RivalBScore + "pts\r\r");
					break;
				case 2:
					AddText("This attractive young woman did a sensual dance.\r\rShe was scored : " +  RivalBScore + "pts\r\r");
					break;
				case 3:
					AddText("This pretty young girl danced in a very flexible way.\r\rShe was awarded : " +  RivalBScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 62)
		{
			mcBase.ContestsDanceRivalB._visible = false;
			temp = slrandom(3);
			mcBase.ContestsDanceRivalC.gotoAndStop(temp);
			mcBase.ContestsDanceRivalC._visible = true;
			switch(temp) {
				case 1: 
					Backgrounds.ShowOther(1);
					AddText("This girl was very energetic, but had some problems with her dress. The judges did not mind at all.\r\rShe was scored : " +  RivalCScore + "pts\r\r");
					break;
				case 2:
					Backgrounds.ShowSakura(1);
					AddText("This attractive woman did a highly sensual dance.\r\rShe was scored : " +  RivalCScore + "pts\r\r");
					break;
				case 3:
					AddText("This pretty young girl danced in an amazing swirling way.\r\rShe was scored : " +  RivalCScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 63)
		{
			mcBase.ContestsDanceRivalC._visible = false;
			temp = slrandom(3);
			mcBase.ContestsDanceRivalD.gotoAndStop(temp);
			mcBase.ContestsDanceRivalD._visible = true;
			switch(temp) {
				case 1: 
					AddText("This girl was stunning with her amazing leaps and her swirling hair. The judges applauded her.\r\rShe was scored : " +  RivalDScore + "pts\r\r");
					break;
				case 2:
					AddText("This elegant girl did a refined dance, seemingly unencumbered by her kimono.\r\rShe obtained : " +  RivalDScore + "pts\r\r");
					break;
				case 3:
					Backgrounds.ShowOther(1);
					AddText("This young woman danced in a seductive and energetic way.\r\rShe was scored : " +  RivalDScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 64)
		{
			mcBase.ContestsDanceRivalD._visible = false;
			temp = slrandom(2);
			mcBase.ContestsDanceRivalE.gotoAndStop(temp);
			mcBase.ContestsDanceRivalE._visible = true;
			switch(temp) {
				case 1: 
					AddText("This girl was stunning and her costume impressed the judges. The judges applauded her.\r\rThey gave her a score of : " +  RivalEScore + "pts\r\r");
					break;
				case 2:
					Backgrounds.ShowOther(1);
					AddText("This girl did a wonderful and sensual dance.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
					break;
			}
		}
		else if (NumContest == 65)
		{
			Backgrounds.ShowOther(1);
			NumContest = 1000;
			mcBase.ContestsDanceRivalE._visible = false;
			
			var total2:Number = coreGame.SlaveGirl.ShowContestDance(coreGame.Score);
			if (total2 == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10007);
				if (!coreGame.UseGeneric) total2 = coreGame.Score;
			}
			if (total2 != undefined) coreGame.Score = total2;
			else {
				coreGame.SlaveGirl.ShowSchoolDance(false);
				if (coreGame.UseGeneric) coreGame.Generic.ShowSchoolDance(false);
			}
			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) AddText("The contest was fixed so " + "#slave came ");
			else AddText("#slave obtained : " + coreGame.Score + "pts, came in ");
			slaveData.BitFlag1.ClearBitFlag(19);
	
			if (Placing == 6) {
				Diary.AddEntry("#slave placed last in the Dance contest.");
				AddText("last place.\r\r");
			} else if (Placing == 5) {
				Diary.AddEntry("#slave placed fifth in the Dance contest.");
				AddText("5th place.\r\r");
			} else if (Placing == 4) {
				Diary.AddEntry("#slave placed fourth in the Dance contest.");
				AddText("4th place.\r\r");
			} else if (Placing == 3)
			{
				AddText("3rd place.\r\rYou win 200GP");
				slaveData.VarConstitution = slaveData.VarConstitution + 1;
				slaveData.VarRefinement = slaveData.VarRefinement + 1;
				slaveData.slDancing = slaveData.slDancing + 0.1;
				Money(150);
				SMMoney(50);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the Dance contest.", false, 3);
			}
			else if (Placing == 2)
			{
				AddText("2nd place.\r\rYou win 600GP");
				slaveData.VarConstitution = slaveData.VarConstitution + 1;
				slaveData.VarRefinement = slaveData.VarRefinement + 1;
				slaveData.slDancing = slaveData.slDancing + 0.1;
				Money(450);
				SMMoney(150);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the Dance contest.", false, 2);
			}
			else
			{
				AddText("1st place.\r\rYou win 1200GP");
				Money(900);
				SMMoney(300);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarConstitution = slaveData.VarConstitution + 5;
				slaveData.VarRefinement = slaveData.VarRefinement + 5;
				slaveData.slDancing = slaveData.slDancing + 0.5;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				coreGame.WinDance = coreGame.WinDance + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave won the Dance contest!", false, 1);
			}
		}
	}
	
	public function DoContestGeneralKnowledge()
	{
		Backgrounds.ShowLibrary();
		
		if (NumContest == 70)
		{
			temp = slrandom(3);
			ShowMovie(mcBase.ContestsGeneralKnowledgeRivalA, 1.1, 1, temp);
			AddText("This girl obtained : " +  RivalAScore + "pts\r\r");
		}
		else if (NumContest == 71)
		{
			mcBase.ContestsGeneralKnowledgeRivalA._visible = false;
			temp = slrandom(3);
			if (temp == 3) {
				ShowMovie(mcBase.ContestsGeneralKnowledgeRivalB, 1, 3, temp);
				Backgrounds.HideBackgrounds();
			} else ShowMovie(mcBase.ContestsGeneralKnowledgeRivalB, 1.1, 1, temp);
			AddText("This girl obtained : " +  RivalBScore + "pts\r\r");
		}
		else if (NumContest == 72)
		{
			if (temp == 1) Backgrounds.ShowSchool();
			mcBase.ContestsGeneralKnowledgeRivalB._visible = false;
			temp = slrandom(2);
			ShowMovie(mcBase.ContestsGeneralKnowledgeRivalC, 1.1, 1, temp);
			if (temp == 1) AddText("This woman displayed a fine general knowledge and her panties. The judges were impressed by both.\r\rThey scored both : " +  RivalCScore + "pts\r\r");
			else AddText("This woman lectured the judges and showed a detailed knowledge of lingerie. The judges admired both.\r\rThey scored them : " +  RivalCScore + "pts\r\r");
		}
		else if (NumContest == 73)
		{
			Backgrounds.ShowSchool();
			mcBase.ContestsGeneralKnowledgeRivalC._visible = false;
			temp = slrandom(2);
			ShowMovie(mcBase.ContestsGeneralKnowledgeRivalD, 1.1, 1, temp);
	
			if (temp == 1) AddText("This woman was very knowledgeable, often using flirtatious innuendo. The judges were pleased.\r\rThey scored her : " +  RivalDScore + "pts\r\r");
			else AddText("This woman showed a basic general knowledge, but her grasp of all things sexual was unparalleled. She offered at times to demonstrate the answers to some sexual questions. The judges happily accepted the demonstrations.\r\rThey scored her and her demonstrations : " +  RivalDScore + "pts\r\r");
	
		}
		else if (NumContest == 74)
		{
			Backgrounds.HideBackgrounds();
			mcBase.ContestsGeneralKnowledgeRivalD._visible = false;
			temp = slrandom(2);
			ShowMovie(mcBase.ContestsGeneralKnowledgeRivalE, 1, 3, temp);
			if (temp == 1) AddText("This girl arrived naked and when the judges asked she explained that this contest is about her knowledge and not her appearance. The judges happily allow this and are impressed by her knowledge and body.\r\rThey score her : " +  RivalEScore + "pts\r\r");
			else AddText("This girl was brilliant and perceptive.\r\rShe obtained : " +  RivalEScore + "pts\r\r");
		}
		else if (NumContest == 75)
		{
			NumContest = 1000;
			mcBase.ContestsGeneralKnowledgeRivalE._visible = false;
			
			var total2:Number = coreGame.SlaveGirl.ShowContestGeneralKnowledge(coreGame.Score);
			if (total2 == undefined && coreGame.UseImages) {
				coreGame.ShowActImage(10008);
				if (!coreGame.UseGeneric) total2 = coreGame.Score;
			}
			if (total2 != undefined) coreGame.Score = total2;
			else {
				coreGame.SlaveGirl.ShowSchoolSciences();
				if (coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(1006);
			}
			CalculatePlacing();
			
			if (slaveData.BitFlag1.CheckBitFlag(19)) SetText("The contest was fixed so " + "#slave came ");
			else SetText("#slave obtained : " + coreGame.Score + "pts, and came in ");
			slaveData.BitFlag1.ClearBitFlag(19);
	
			if (Placing == 6) {
				Diary.AddEntry("#slave placed last in the General Knowledge contest.");
				AddText("last place.\r\r");
			} else if (Placing == 5) {
				Diary.AddEntry("#slave placed fifth in the General Knowledge contest.");
				AddText("5th place.\r\r");
			} else if (Placing == 4) {
				Diary.AddEntry("#slave placed fourth in the General Knowledge contest.");
				AddText("4th place.\r\r");
			} else if (Placing == 3)
			{
				AddText("3rd place.\r\rYou win 200GP");
				slaveData.VarIntelligence = slaveData.VarIntelligence + 1;
				slaveData.VarMorality = slaveData.VarMorality + 1;
				Money(150);
				SMMoney(50);
				slaveData.VarJoy = slaveData.VarJoy + 5;
				coreGame.WinContest = 3;
				Diary.AddEntry("#slave placed third in the General Knowledge contest.", false, 3);
			}
			else if (Placing == 2)
			{
				AddText("2nd place.\r\rYou win 600GP");
				slaveData.VarIntelligence = slaveData.VarIntelligence + 1;
				slaveData.VarMorality = slaveData.VarMorality + 1;
				Money(450);
				SMMoney(150);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarReputation = slaveData.VarReputation + 5;
				coreGame.WinContest = 2;
				Diary.AddEntry("#slave placed second in the General Knowledge contest.", false, 2);
			}
			else
			{
				AddText("1st place.\r\rYou win 1400GP");
				Money(1050);
				SMMoney(350);
				slaveData.VarJoy = slaveData.VarJoy + 10;
				slaveData.VarIntelligence = slaveData.VarIntelligence + 10;
				slaveData.VarMorality = slaveData.VarMorality + 10;
				slaveData.VarReputation = slaveData.VarReputation + 10;
				coreGame.WinGeneralKnowledge = coreGame.WinGeneralKnowledge + 1;
				coreGame.WinContest = 1;
				Diary.AddEntry("#slave won the General Knowledge contest!", false, 1);
			}
		}
	}
	
	// XML
	
	public function ParseContests(aNode:XMLNode, str:String)
	{
		if (str == "showcustomcontest") {
			ShowCustomContest(aNode.firstChild.nodeValue.toLowerCase() != "false", aNode.attributes.num);
			return;
		}
		if (str == "setcontest" || str == "showcontestsnext") {
			NumContest = Language.XMLData.GetExpression(aNode.attributes.num);
			ShowContestsNext();
		}
	}
	
	public function ApplyContests(eNode:XMLNode)
	{
		var clabel:String = undefined;
		var bshow:Boolean = undefined;
		var cname:String;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": cname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": clabel = eNode.attributes[attr]; break;
				case "show": bshow = coreGame.XMLData.ParseConditionalString(eNode.attributes[attr], true, false);
			}
		}
		if (cname == undefined) {
			cname = coreGame.XMLData.GetXMLString("Name", eNode.firstChild);
			if (cname == "") return;
		}
		if (clabel == undefined) clabel = coreGame.XMLData.GetXMLString("Hint", eNode.firstChild);
		
		var bNewAct:Boolean = !coreGame.slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		SMTRACE("Adding contest " + eNode.nodeName + " " + cname + " " + clabel + " show: " + bshow + " " + bNewAct);
		var actno:Number = AddCustomContest(cname, clabel, eNode.nodeName);
		var act:ActInfo = coreGame.slaveData.ActInfoBase.GetActRO(eNode.nodeName);
		act.xNode = eNode.firstChild;
		if (bNewAct && bshow != undefined) act.ShowAct(bshow);
	}
	
	
	// Events
	
	public function DoEventNext() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// back to contests
			case 14:
				coreGame.HideImages();
				coreGame.HideSlaveActions();
				Backgrounds.ShowFestival();
				StartContests(true);
				return true;
				
			// back to contests
			case 15:
				coreGame.HideImages();
				coreGame.HideSlaveActions();
				Backgrounds.ShowFestival();
				DoContestsNext();
				return true;
		}
		return false;
	}
	
	public function DoEventYes() : Boolean
	{
		switch (coreGame.NumEvent) {
			// Housework Advanced
			case 14:
				if (coreGame.TestObedience(coreGame.DifficultyNaked, 13)) {
					coreGame.SwapDress(-1);
					ContestHouseworkAdvanced();
				} else {
					Language.SetLangText("AdvancedHousework/RefuseHouseWorkAdvanced", "Contests");
					coreGame.Refused(13, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -8, -2, 0, 0, -1, -8, 0);
					DoEvent(14);
				}
				return true;
		}
		return false;
	}
	
	public function DoEventNo() : Boolean
	{
		switch (coreGame.NumEvent) {

			// Housework Advanced
			case 14:
				coreGame.DoEventNext(14);
				return true;
		}
		return false;
	}	

	
	
	// Miscellaneous
	
	public function NextContestsKeyListener() {
		if (Key.getCode() == Key.ENTER) DoContestsNext();
	};
	
	public function HideImages()
	{
		if (IsContestStarted()) {
			mcBase.ClipRivalACourt._visible = false;
			mcBase.ClipRivalBCourt._visible = false;
			mcBase.ClipRivalCCourt._visible = false;
			mcBase.ClipRivalDCourt._visible = false;
			mcBase.ClipRivalECourt._visible = false;
			mcBase.ClipRivalAHousework._visible = false;
			mcBase.ClipRivalBHousework._visible = false;
			mcBase.ClipRivalCHousework._visible = false;
			mcBase.ClipRivalDHousework._visible = false;
			mcBase.ClipRivalEHousework._visible = false;
			mcBase.ClipRivalAHouseworkAdvanced._visible = false;
			mcBase.ClipRivalBHouseworkAdvanced._visible = false;
			mcBase.ClipRivalCHouseworkAdvanced._visible = false;
			mcBase.ClipRivalDHouseworkAdvanced._visible = false;
			mcBase.ClipRivalEHouseworkAdvanced._visible = false;
			mcBase.ClipRivalABeauty._visible = false;
			mcBase.ClipRivalBBeauty._visible = false;
			mcBase.ClipRivalCBeauty._visible = false;
			mcBase.ClipRivalDBeauty._visible = false;
			mcBase.ClipRivalEBeauty._visible = false;
			mcBase.ClipRivalAXXX._visible = false;
			mcBase.ClipRivalBXXX._visible = false;
			mcBase.ClipRivalCXXX._visible = false;
			mcBase.ClipRivalDXXX._visible = false;
			mcBase.ClipRivalEXXX._visible = false;
			mcBase.ClipContestsPonygirl._visible = false;
			mcBase.ContestsDanceRivalA._visible = false;
			mcBase.ContestsDanceRivalB._visible = false;
			mcBase.ContestsDanceRivalC._visible = false;
			mcBase.ContestsDanceRivalD._visible = false;
			mcBase.ContestsDanceRivalE._visible = false;
			mcBase.ContestsGeneralKnowledgeRivalA._visible = false;
			mcBase.ContestsGeneralKnowledgeRivalB._visible = false;
			mcBase.ContestsGeneralKnowledgeRivalC._visible = false;
			mcBase.ContestsGeneralKnowledgeRivalD._visible = false;
			mcBase.ContestsGeneralKnowledgeRivalE._visible = false;
			if (ContestsMenu._visible) {
				ContestsMenu._visible = false;
				Key.removeListener(coreGame.keyListenerMenu);
				coreGame.keyListenerMenu.onKeyUp = null;
			}
		}
	}
	
	public function ShowContestsNext()
	{
		coreGame.HideButtons();
		coreGame.DoEvent(0);
	}
	public function HideContestsNext()
	{
		coreGame.HideEventNext();
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();
		var ti:ContestsModule = this;
		
		ContestsMenu = mcBase.ContestsMenu;		
	}
	
	// References
	public function ShowHintLang(node:String, base, xpos:Number, wid:Number) { coreGame.Hints.ShowHintLang(node, base, xpos, wid); }

}
