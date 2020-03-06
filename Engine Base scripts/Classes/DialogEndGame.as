// DialogEndGame - end game screens
//
// Translation status: NOT COMPLETE

import Scripts.Classes.*;

class DialogEndGame extends DialogBase {
	
	public var EndGameMenu:DialogEndGameMenu;
	public var UseSkillPoints:DialogUseSkillPoints;
		
	// Constructor
	public function DialogEndGame(cg:Object)
	{ 
		super(cg.mcEndGame, cg);
		
		coreGame.NextEnding.tabChildren = true;
		EndGameMenu = null;
		UseSkillPoints = null;
		
		var ti:DialogEndGame = this;
		coreGame.NextEnding.Btn.onPress = coreGame.DoEndingNext;
		
		mcBase.LoadButton.Btn.onPress = function() {
			ti.coreGame.LoadSave.ViewLoadScreen();
		}
		mcBase.LoadButton.Btn.tabChilden = true;
		mcBase.SaveButton.Btn.onPress = function() {
			ti.coreGame.LoadSave.ViewSaveScreen();
		}
		mcBase.SaveButton.Btn.tabChilden = true;
	}

	public function ViewBasic()
	{
		coreGame.ClipTrainingComplete._visible = false;
		mcBase.ChainClip._visible = true;
		mcBase._visible = true;
	}
		
	public function ViewDialog()
	{
		super.ViewDialog();
		
		mcBase.Score.LSexuality.htmlText = Language.GetHtml("Sexuality", Language.statNode);	
		mcBase.Score.LEnding.htmlText = Language.GetHtml("Ending", "EndGame", true);
		mcBase.Score.LScore.htmlText = Language.GetHtml("Score", "EndGame", true);
		mcBase.Score.LSpecialTrainings.htmlText = Language.GetHtml("SpecialTrainings", "EndGame");
		mcBase.Score.LContestsWon.htmlText = Language.GetHtml("ContestsWon", "EndGame", true);
		mcBase.Score.LRemainingGold.htmlText = Language.GetHtml("RemainingGold", "EndGame", true);
		mcBase.Score.LPersonalGoldSpent.htmlText = Language.GetHtml("PersonalGoldSpent", "EndGame", true);
		mcBase.Score.LPersonalLeft.htmlText = Language.GetHtml("PersonalGoldLeft", "EndGame", true);
		mcBase.Score.DateText.htmlText = Language.GetHtml("Date", "Others", false, 0, "", " :");
		
		Language.CopyTF(coreGame.NextEnding.LText, coreGame.NextEvent.LText);
		
		mcBase.Score._visible = false;
		mcBase.ChainClip._visible = false;
		mcBase.LoadButton._visible = false;
		mcBase.SaveButton._visible = false;
		
		coreGame.HideAllPeople();
		mcBase.TextBackground._visible = false;
		Show();
		coreGame.dspMain.HideGameTabs();
		SetText("");
		Language.ShowLargerText(true);
		coreGame.ClipTrainingComplete._x = 0;
		coreGame.ClipTrainingComplete._y = 0;
		coreGame.ClipTrainingComplete._height = 600;
		coreGame.ClipTrainingComplete._width = 505;
		coreGame.DoEvent(9999);
		coreGame.NextEvent._visible = false;
		ShowEndingNext();
	}
	
	public function ShowDialogContents() { }
	
	
	// Events
	
	public function DoEventNext() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// Freelancer endings
			case 25:
				coreGame.EndingStart();
				coreGame.NumFin = 1006;
				ShowEndingNext();
				coreGame.DoEndingNext()
				return true;
			
			//
			case 26:
				coreGame.EndingStart();
				coreGame.EndingStartSelect();
				coreGame.NumFin = 1005;
				coreGame.EndingStartEnd();
				SetText("");
				coreGame.NumFin = 1005;
				ShowEndingNext();
				coreGame.DoEndingNext()
				return true;
				
			case 27:
				HolidayRelax();
				return true;
				
			case 28:
				HolidayTrain();
				return true;	
				
			case 29:
				AfterHolday();
				return true;
	
			// game over
			case 9800:
				coreGame.GameOverText.htmlText = Language.GetHtml("GameOver", "EndGame", true);
				coreGame.GameOverText._visible = true;
				coreGame.StopPlanning(false);
				coreGame.HideSupervisor();
				coreGame.ShowAssistant(4);
				Backgrounds.ShowOverlay(0);
				coreGame.DoEvent(9801);
				return true;
				
			// Game over - restart slave maker
			case 9801:
				coreGame.GameOverText._visible = false;
				coreGame.RetireSlaveMaker();
				return true;
				
			// Trial Bad End
			case 9810:
				Language.XMLData.XMLGeneral("BadEnds/TrialBadEnd");
				return true;
				
			// BE Bad End pt 1
			case 9820:
				BadEndingBE();
				return true;
				
			// BE Bad End pt 2
			case 9821:
				coreGame.TrainingComplete(false, 9003);
				return true;
		
			// training complete (not full)
			case 9898:
				coreGame.TrainingComplete(false, coreGame.NumFin);
				coreGame.modulesList.AfterEventNext();
				return true;
				
			// training complete (full)
			case 9899:
				coreGame.TrainingComplete(true, coreGame.NumFin);
				coreGame.modulesList.AfterEventNext();
				return true;
		}
		return false;
	}
	
	public function DoEventYes() : Boolean
	{
		switch (coreGame.NumEvent) {
			// 11 - Training Complete
			case 11:
				coreGame.TrainingComplete(false);
				return true;
				
			// Buy her back
			case 20:
				coreGame.NumFin = 1002;
				ShowEndingNext();
				coreGame.DoEndingNext()
				return true;
		}
		
		if (EndGameMenu != null) return EndGameMenu.DoEventYes();
		return false;
	}
	
	public function DoEventNo() : Boolean
	{
		switch (coreGame.NumEvent) {

			// Do not buy her back
			case 20:
				coreGame.NumFin = 1003;
				ShowEndingNext();
				coreGame.DoEndingNext()
				return true;
		}
		
		if (EndGameMenu != null) return EndGameMenu.DoEventNo();
		return false;
	}	
	
	public function AskCompleteTraining()
	{
		Language.SetLangText("Complete", "Other");
		AddText("\r");
		DoYesNoEvent(11);
	}
	
	
	// Endings
	
	public function HideEndings() 
	{
		HideBackgrounds();
		coreGame.HideImages();
		coreGame.HideSlaveActions();
		coreGame.Generic.HideEndings();
		coreGame.SlaveGirl.HideEndings();
		coreGame.CurrentAssistant.HideEndingsAsAssistant();
		coreGame.modulesList.HideEndings();
	}
	
	public function SetEnding(fin:Number, endstr:String)
	{
		trace("SetEnding: " + fin + " " + endstr);
		if (fin > 0) coreGame.NumFin = fin;
		if (endstr != undefined) SetEndingText(endstr);
		ShowEndingNext();
	}
	
	public function SetEndingText(str:String) {	mcBase.Score.EndingText.text = str; }
	public function GetEndingText() : String {	return mcBase.Score.EndingText.text; }
	
	
	// Show a hint for game endings
	public function ShowEndingsHint()
	{
		AddText("The guild member gives you a tip,\r\r");
		PersonSpeakStart("Guild Member", "", true);
	
		var numc:Number = coreGame.modulesList.NumCustomEndings();
		var nums:Number = coreGame.SlaveGirl.NumCustomEndings();
		if (nums == undefined || nums == 0) nums = Language.XMLData.GetXMLValue("NumCustomEndings", "EndGame");
		
		if (coreGame.Milkable) nums += 15;
		else nums += 14;
	
		temp = Math.floor(Math.random()*(nums + numc));
		if (!coreGame.Milkable) temp++;
		
		if (temp == 0) Language.AddLangText("Hint", "EndGame/Slave/EndingCowgirl");
		else if (temp == 1) Language.AddLangText("Hint", "EndGame/Slave/EndingDrugAddict");
		else if (temp == 2) Language.AddLangText("Hint", "EndGame/Slave/EndingRebel");
		else if (temp == 3) Language.AddLangText("Hint", "EndGame/Slave/EndingNormalMinus");
		else if (temp == 4) Language.AddLangText("Hint", "EndGame/Slave/EndingRich");
		else if (temp == 5)	Language.AddLangText("Hint", "EndGame/Slave/EndingWedding");
		else if (temp == 6) Language.AddLangText("Hint", "EndGame/Slave/EndingBoughtBack");
		else if (temp == 7) Language.AddLangText("Hint", "EndGame/Slave/EndingNormalPlus");
		else if (temp == 8) Language.AddLangText("Hint", "EndGame/Slave/EndingProstitute");
		else if (temp == 9) Language.AddLangText("Hint", "EndGame/Slave/EndingMaid");
		else if (temp == 10) Language.AddLangText("Hint", "EndGame/Slave/EndingSexManiac");
		else if (temp == 11) Language.AddLangText("Hint", "EndGame/Slave/EndingNormal");
		else if (temp == 12) Language.AddLangText("Hint", "EndGame/Slave/EndingSexManiac");
		else if (temp == 13) Language.AddLangText("Hint", "EndGame/Slave/EndingLove");
		else if (temp == 14) Language.AddLangText("Hint", "EndGame/Slave/EndingDickgirl");
	
		else if (temp < (nums + 15)) {
			var str:String = Language.GetHtml("CustomEnding" + temp, "EndGame");
			if (str == "") coreGame.SlaveGirl.ShowEndings(temp - 14);
		} else {
			var str:String = Language.GetHtml("AssistantEnding" + (temp - 15), "EndGame");
			if (str == "") coreGame.modulesList.ShowEndings(temp - 15 - nums);
		}
		PersonSpeakEnd();
		BlankLine();
	}
	
	public function FinishEndings()
	{
		trace("FinishEndings");
		HideEndings();
		coreGame.HideDresses();
		ShowScore();
		
		// Update Slave Maker
		SMData.EndGameEffects();
		
		// Update Slave
		// remove future events
		Diary.ClearFutureEntries();
		delete coreGame.slaveData.PotionsUsed;
		coreGame.slaveData.PotionsUsed = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		for (var i:Number = 0; i < 15; i++) coreGame.slaveData.PotionsUsed[i] = coreGame.PotionsUsed[i];
		if (coreGame.slaveData.IsPermanentDickgirl()) coreGame.slaveData.SlaveGender = 3;
		coreGame.slaveData.ClearSlaveSkillArray();
		
		// Update Other slaves
		if (coreGame.SandboxMode) {
			var ed:SlaveModule = coreGame.modulesList.GetEventData("Azana");
			ed.SetVariable(1, 0);
		}
		SMData.BuildOwnedSlaves();
				
		Language.ShowGeneralText(true);
		Language.ShowLargerText(true);
		
		// Holiday text
		Language.XMLData.XMLGeneral("EndGame/HolidayTime");
		
		// reset slave and assistant
		coreGame.ResetSlave(true);
		coreGame.ResetAssistant();		
	}


	
	// Bad Endings
	
	// Overuse of orgasm drug
	public function BadEndingBE()
	{
		coreGame.HideAllPeople();
		coreGame.ShowPerson(33, 0, 0, coreGame.DickgirlOn == 1 ? (coreGame.DickgirlTesticles ? 8 : 11) : 9);
		coreGame.Generic.ShowBadEndingDemonPlaything();
		ShowMovie(coreGame.OnTopOverlay, 1, 0);
		coreGame.StartFadeImage(30, coreGame.OnTopOverlay, "", 1000);
	
		SetText("Time passes but #slave can only think of #slavehisher breasts and the hair-trigger orgasms they cause. One evening after weird dreams #slave dimly awakens, arms tied above #slavehisher head. #slave's breasts are steadily shrinking back to normal! The fuzzyness lifts as #slavehisher breasts are no longer the center of #slavehisher existance.\r\r");
		AddText("With a great surprise #slave can feel a large, hard cock pounding #slavehisher pussy, fucking fast and deep. She is aware of being in a strange room, a red light filling it and odd moving shadows, flickering shapes and it is hot! The man fucking her is very silent but fucks with speed and force, his cock very warm. #slave can feel sweat trickling from #slavehisher skin and another heat as her arousal grows quickly. She tries to turn her head to look at the man and for some reason she cannot. A hand cups one of her breasts and pinches her nipple and her arousal explodes and she ");
		if (coreGame.IsDickgirl()) AddText("climaxes, cum spraying from her cock");
		else AddText("orgasms");
		AddText(". The man continues fucking hard, ignoring #slave's orgasm. A woman speaks, she is the person holding #slave's breast,\r\r");
		PersonSpeak("Woman", "That was a good cum! You are now clearer and normal now. Welcome to your new home. Welcome to Hell!\r\rYou overdosed on our gift to mankind, there is no cure in the world of man, the only cure is to live in Hell. You are our slave, our slave for pleasure and maybe more.", true);
		AddText("\r\r#slave is frightened at the woman's words, but the man fucking her lets out a soft noise and plunges his cock in as deep as he can and his cock pulses and throbs, as he cums. #slave feels his hot cum pumping with inhuman force into her womb. He shakes silently in his orgasm as he cums and cums and cums. After some time he staggers backward pulling his cock out and #slave feels a flood of cum pour from her pussy.\r\r#slave is surprised at the force of his orgasm, realising now that he is a demon. As she thinks on this hands grip her waist and another very large cock easily slides into her cum filled pussy. The demon's cock is uncomfortably hot and incredibly hard and fills #slave's pussy as she has never been filled before. With no other sound or touch the demon starts pounding his cock in #slave's pussy, pounding hard and very quickly.\r\rThe woman caresses one of #slave's breasts and her other hand moves to #slave's ");
		if (coreGame.IsDickgirl()) AddText("cock and rubs and strokes it.");
		else AddText("pussy and rubs her clit.");
		AddText(" The demoness continues talking,\r\r");
		PersonSpeak("Demoness", "You will have such a wonderful life, cocks to fill you all day and cum to fill your stomach and feed you. We have many, many demons who want to slake their lusts and that is what you will do!\r\rWho know's? You many be one of those rare people who we can breed with. Imagine bearing our wonderful demon spawn!\r\rEventually you may love it so much here you will join our ranks as a demoness. Then again being a cock-slave is so wonderful.", true);
		AddText("\r\rThe demon continues fucking hard and fast, making soft growling noises. #slave moans with the fucking and the demonesses touch and she ");
		if (coreGame.IsDickgirl()) AddText("cums");
		else AddText("orgasms");
		AddText(" again as she understands her captivity. The demoness softly laughs,\r\r");
		PersonSpeak("Demoness", "Don't you love their cocks, so big, so hard and they fuck for much, much longer than men. As you have felt they cum stronger and harder.", true);
		if (coreGame.DickgirlOn == 1) {
			AddText("\r\rAs she speaks she walks around in front of #slave. She is beautiful with blue hair and a pure red skin. Her breasts are large and pierced but #slave's eye is drawn to her groin. She has a large, erect cock, dripping with her excitement. Quickly the demoness forces her cock into #slave's mouth, the hot flesh tasting strange, salty, but also bitter, but not unpleasantly so. The demoness fucks #slave's mouth with skill so #slave is able to breath and lick. The demoness moans with pleasure, and she continues speaking,\r\r");
			PersonSpeak("Demoness", "It has been a while since your last meal, I bet you are hungry. Mmmmmm. Your mouth is delightful! Ohh It is time, almost time, that I feed you the only thing you will eat or drink ever, ugggghhh, ever ohhhhh, again. Ahhhhhhhh", true);
			AddText("\r\rThe demoness screams and she cums, spraying large jets of hot cum into #slave's mouth. With difficulty #slave swallows the hot, thick cum and then swallows more and more. The demoness gasps and pulls back and sprays globs and globs of cum over #slave's face and hair. The demoness screams and shouts with her extreme pleasure until she eventually stops cumming. Just as she does the demon fucking #slave cums, massive, hot spurts of cum filling #slave's pussy and womb. He pulls out as well and sprays his cum over #slave's back and ass. He staggers away and the woman speaks with some effort,\r\r");
			PersonSpeak("Demoness", "Ohhhh Very good feeding. Huhh I only let you only 'eat' half of my 'meal'. I do not want you to get fat and I plan to feed you many times.", true);
			AddText("\r\rA hot cock rudely pushes into #slave's ass and the demoness rubs her cock, preparing to supply another 'course' of #slave's meal.....");
		} else {
			AddText("\r\rAs she speaks she walks around in front of #slave. She is beautiful with blue hair and a pure red skin. Her breasts are large and pierced. She is carrying a small bucket, mostly filled with what is clealy cum and she speaks,\r\r");
			PersonSpeak("Demoness", "It has been a while since your last meal, I bet you are hungry. It is time that I feed you the only thing you will eat or drink ever again.", true);
			AddText("She raises the bucket to #slave's lips and pours the cum into her mouth. As #slave swallows, with the demon fucking her pussy, she realises her fate.....");
		}
		coreGame.DoEvent(9821);
	}
	
	// Holidays
	
	private function HolidayRelax()
	{
		var sdata:Slave;
		var j:Number = SMData.nUsable;
		while (--j >= 0) {
			sdata = SMData.arUsableSlaves[j];
			if (sdata.SlaveType == -20) continue;
			sdata.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 5, 0, 0, 0, 0);
		}
		Language.ShowLargerText(true);
		Language.ShowGeneralText(true);
		mcBase.TextBackground._visible = true;
		SetText("You relax and holiday for a time with your slaves");
		AfterHolday();
	}
	
	private function HolidayTrain()
	{
		SMMoney(-500);
		var sdata:Slave;
		var j:Number = SMData.nUsable;
		while (--j >= 0) {
			sdata = SMData.arUsableSlaves[j];
			if (sdata.SlaveType == -20) continue;
			switch(slrandom(6)) {
				case 1: sdata.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0); break;
				case 2: sdata.Points(5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0); break;
				case 3: sdata.Points(0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0); break;
				case 4: sdata.Points(0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0); break;
				case 5: sdata.Points(0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0); break;
				case 5: sdata.Points(0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -100, 0, 0, 0, 0, 0); break;
			}
		}
		Language.ShowLargerText(true);
		Language.ShowGeneralText(true);
		mcBase.TextBackground._visible = true;
		SetText("You spend time training your slaves");
		AfterHolday();
	}
	
	public function AfterHolday()
	{
		// Time passes, update Slave Maker and others
		coreGame.ChangeDate(8, true);
	
		HideEndings();
		coreGame.HideImages();
		coreGame.HideDresses();
		Language.SaveText();
		coreGame.ResetSlave();
			
		// show end game menu
		ShowMenu();
		ShowScore();

		Language.ShowGeneralText(true);
		SetText("");
		Language.ShowLargerText(true);
		Language.RestoreText(true);
		BlankLine();
		Language.XMLData.XMLGeneral("EndGame/EndGameMenu");
	}
	
	
	// End Game Menu

	
	public function ShowMenu()
	{
		EndGameMenu = new DialogEndGameMenu(coreGame);
		EndGameMenu.ViewDialog();
	}
	public function ShowMenuContents()
	{
		EndGameMenu.ShowDialogContents();
	}
	public function IsEndGameMenuShown() : Boolean { return EndGameMenu != null; }
	
	// Use Skill Points
	
	public function ShowSkillPoints()
	{
		UseSkillPoints = new DialogUseSkillPoints(coreGame);
		UseSkillPoints.ViewDialog();
	}

	// Next button
	
	public function ShowEndingNext()
	{
		coreGame.HideButtons();
		coreGame.NextEnding._visible = true;
	}
	public function HideEndingNext()
	{
		coreGame.NextEnding._visible = false;
	}
	
	
	// Score
	
	public function UpdateScore(sonly:Boolean)
	{
		mcBase.Score.ScoreText.text = coreGame.Score;
		if (sonly == true) return;
		mcBase.Score.SpentText.text = int(SMData.SMGoldSpent);
		mcBase.Score.LeftText.text = SMData.GuildMember ? SMData.SMGold : coreGame.VarGold;
		mcBase.Score.LeftText._visible = SMData.GuildMember;		
		mcBase.Score.GoldText.text = coreGame.VarGold;
		mcBase.Score.DateText.text = "Date: " + coreGame.DecodeDate(coreGame.GameDate);
		mcBase.Score.LPersonalLeft._visible = SMData.GuildMember;
		mcBase.Score.WonText.text = coreGame.WinXXX + coreGame.WinBeauty + coreGame.WinCourt + coreGame.WinHousework + coreGame.WinDance + coreGame.WinGeneralKnowledge + coreGame.WinPonygirl + coreGame.WinHouseworkAdvanced + coreGame.WinCustom;
		mcBase.Score.SexualityText.text = coreGame.SlaveVitalsGroup.SexualityText.text;
		mcBase.Score.SpecialTraningsText.text = coreGame.modulesList.GetSpecialTrainingList();
	}
	public function ShowScore() { mcBase.Score._visible = true; mcBase.ChainClip._visible = true; mcBase.TextBackground._visible = true; }
	public function HideScore() { mcBase.Score._visible = false; mcBase.TextBackground._visible = false; }
	public function IsSpecialTrainingsDone() : Boolean { return mcBase.Score.SpecialTraningsText.text != ""; }
	
	
	// Miscellaneous
	
	public function Reset()
	{
		delete EndGameMenu;
		EndGameMenu = null;
	}
	
	public function Show()
	{
		coreGame.HideAllImages();
		HideBackgrounds();
		HideEndingNext();
		Backgrounds.ShowIntroBackground();
		mcBase._visible = true;
	}
	public function Hide()
	{ 
		HideEndingNext();
		mcBase._visible = false;
		if (EndGameMenu != null) EndGameMenu.Hide();
	}	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 13:
				coreGame.DoEndingNext();
				return true;
		}
		return false;
	}
	
}