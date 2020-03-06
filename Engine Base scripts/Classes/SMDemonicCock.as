// SMEvents - Slave Maker custom events
//
// Mainly Demonic Cock backgroupnd current'y
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class SMDemonicCock extends SMInhumanAncestry
{		
	public function SMDemonicCock(mc:MovieClip, cgm:Object) { super(mc, null, cgm); }

	
	// Cock of Demonic Origin
	
	public function SMPreEvent() : Boolean
	{
		if ((coreGame.bNocturnal && coreGame.GameTimeMins == 1080) || (!coreGame.bNocturnal && coreGame.GameTimeMins == 360)) {	// 6am/6pm
			if ((coreGame.currentCity.Home.hWards == 0 && SMData.SMSpecialEvent == 5) || SMData.SMSpecialEvent == 7) {
				DemonicCockEarlyMorningEvent();
				return true;
			}
			return super.SMPreEvent();
		}
		return false;
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
						
		// Ass fuck
		case 5016:
		case 5016.1:
			if (coreGame.NumEvent == 5016) coreGame.tempstr = "";
			coreGame.HideEndings();
			PerformActNow(-50, "Anal", false);
			SetText(coreGame.tempstr + "You enter #slave's room and you see " + coreGame.SlaveHeSheIs + " deeply asleep, and know that #slaveheshe will not awaken. You roll " + coreGame.SlaveName2 +  " over and raise " + coreGame.SlaveHisHerSingle + " hips while removing " + coreGame.SlaveHisHerSingle + " clothing.\r\rWith no foreplay or thought you thrust your cock crudely and urgently into " + coreGame.SlaveHisHerSingle + " ass. You fuck quickly, the whispers almost moaning with you. You feel your cock almost ready to burst as you fuck faster and faster.\r\rYou scream as you cum, pumping huge gouts of cum into " + coreGame.SlaveName2 + "'s bowels. You are flung backward, or were you pulled? Cum spurts from " + coreGame.SlaveName2 + "'s ass, splattering over you. Your cock is still erupting cum and you feel it impossibly curve and thrust into your own pussy, and you feel your cum spurting into your womb.\r\rGasping you collapse as your climax stops, and after a while stagger back to your room.");
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, -1);
			Points(0, 0, -0.5, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 2, 0, 0, 0);
			coreGame.UpdateSexActLevels(7);
			DoEvent(251);
			return true;
			
		// No Ass fuck
		case 5017:
			coreGame.HideEndings();
			SetText("With difficulty you shake off the desire, and get out of bed. Your cock slowly softens and you hear an angry whisper.");
			SMData.SMPoints(0, 0, 0, 0, 0, 0, -3, 0, 3);
			DoEvent(251);
			return true;			
		}
		return super.DoEventNextAsAssistant();
	}

	
	public function DemonicCockEarlyMorningEvent()
	{
		if (SMData.SMSpecialEvent == 5) {
			// Demonic Cock
			SMData.ShowSlaveMaker(0);
			Backgrounds.ShowBedRoom();
			PlaySound("Whispers");
			if (SMData.SpecialEventProgress == 0) {
				SetLastMovieColour(-150, -150, -150);
				coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Succubus.jpg|Images/Appearances/Default Images/Ending - Succubus.jpg", 1, 1);
				SetLastMovieColour(-150, -150, -150);
				SetText("You awaken from a night of troubled dreams of the time in the cave when that woman gave you, or is it cursed you, with your cock. You dreamed of how she mounted you and made you fuck her over and over, your climaxes painfully intense.\r\rYou dream of the last time you fucked her, or was it she fucked you? You fucked her ass and came very powerfully, passing out from the intensity. Your dream is full of whispers of how you must do this to pay for the gift of her cock. Also whispers of how you will be reunited, body and soul...\r\rYou wake, cum leaking from your pussy and more cum soaking your sheets.\r\r");
				SMData.SpecialEventProgress++;
				SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, -1);
				DoEvent(251);
				return;
			} else if (SMData.Corruption > 49 && SMData.SpecialEventProgress == 1) {
				SetLastMovieColour(-150, -150, -150);
				coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Succubus.jpg|Images/Appearances/Default Images/Ending - Succubus.jpg", 1, 1);
				SetLastMovieColour(-100, -100, -100);
				SetText("You awaken from a night of troubled dreams and you see a dim figure of a demonic woman. It is not the woman from the cave, she did not have a cock. You are certain the woman you see has your cock! She talks in a low whisper 'we will be one', and you are shocked, realising it was you who was whispering. The figure fades and you see your own reflection in the mirror.\r\r");
				SMData.SpecialEventProgress++;
				SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, -1);
				DoEvent(251);
				return;
			} else if (SMData.Corruption > 74 && SMData.SpecialEventProgress == 2 && SMData.SMDominance < 40) {
				SetLastMovieColour(-150, -150, -150);
				coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Succubus.jpg|Images/Appearances/Default Images/Ending - Succubus.jpg", 1, 1);
				SetLastMovieColour(-80, -80, -80);
				SetText("You awaken from a night of troubled dreams and you see a figure of a demonic woman. It is not the woman from the cave, she did not have a cock, and you realise it is yourself! You can feel the woman from the cave nearby, promising to unite with you, to merge and possess you and to share her power, as she has shared her cock.\r\rAll you have to do is obey and embrace the darkness. The vision fades and you see your own, normal, plain reflection.\r\r");
				SMData.SpecialEventProgress++;
				SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, -1);
				DoEvent(251);
				return;
			}
			if (coreGame.TotalAnalToday == 0) {
				SetLastMovieColour(-150, -150, -150);
				coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Succubus.jpg|Images/Appearances/Default Images/Ending - Succubus.jpg", 1, 1);
				SetLastMovieColour(-150, -150, -150);
				SMData.SMPoints(0, 0, 0, 0, 0, 0, 4, 0, -4);
				SetText("You awaken from a series of nightmares, full of angry voices demanding something. Your cock is intensely erect and you find you keep thinking about #slave's " + Plural("ass") + ".\r\r");
				if (SMData.SMDominance > 74) {
					AddText("You shake off the desire easily, and get out of bed. Your cock softens and you think you hear an angry whisper.");
					DoEvent(251);
				} else if (SMData.SMDominance > 20) {
					AddText("You feel an almost uncontrollable desire to fuck #slave's ass");
					AskHerQuestions(5016, 5017, 0, 0, "You will fuck " + coreGame.SlaveHimHer, "You will restrain yourself", "", "", "What do you do?");
				} else {
					AddText("You remember you failed to fuck #slave's ass last night and you must to pay for your cock. The whispers are insistent and you obey.\r\r");
					coreGame.DoEventNext(5016.1);
				}
				
			} else {
				coreGame.UseGeneric = false;
				var awake:Boolean = coreGame.SlaveGirl.ShowMorningMouthfull();
				if (awake == undefined) awake = coreGame.Generic.ShowMorningMouthful();
				if (awake == undefined || coreGame.UseGeneric) awake = coreGame.Generic.ShowMorningMouthfull();
				SetText("You are drawn into #slave's bedroom and look on #slavehisher sleeping body. Your cock stirs and becomes painfully erect. You hear odd whispering and your thoughts become dazed.\r\rYou take out your cock and masturbate, quickly cumming, making sure all of it floods into " + SlaveName1 + "'s mouth. ");
				if (awake) AddText(SlaveName1 + " seems to wake but is dazed and swallows and lies back and falls asleep again.");
				else AddText(SlaveName1 + " stirs but does not awaken and seems to swallow.");
				if (coreGame.SlaveGender > 3)  AddText(" You look at " + SlaveName2 + " and your cock stirs again, and you quickly cum again into " + SlaveName2 + "'s mouth too.");
				AddText("\r\rThe whispers seem to tell you your cum will help #slavehimher in some way to better serve you.");
				if ((coreGame.GameDate - coreGame.LastAny) > 1) {
					coreGame.LastAny = coreGame.GameDate;
					AskHerQuestions(5010, 5011, 5012, 5013, "Once, #slaveheshe will obey sexually", NameCase(coreGame.SlaveHisHer) + " arousal will grow", "Once, #slaveheshe will obey non-sexually", coreGame.SlaveHeSheUC + " will meekly obey", "The whispers seem to say...");
				} else AskHerQuestions(5014, 5011, 5015, 5013, NameCase(coreGame.SlaveHisHer) + " desire will grow", NameCase(coreGame.SlaveHisHer) + " arousal will grow", coreGame.SlaveHeSheUC + " will have visions of sex", coreGame.SlaveHeSheUC + " will meekly obey", "The whispers seem to say...");
				SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, -1);
			}
		} else {
			// Succubus
			SMData.ShowSlaveMaker(0);
			Backgrounds.ShowBedRoom();
			var awake:Boolean = coreGame.SlaveGirl.ShowMorningMouthfull();
			if (awake == undefined) awake = coreGame.Generic.ShowMorningMouthfull();
			SetText("You gracefully slip into #slave's bedroom and look on #slavehisher sleeping body. Your cock stirs at the sight of #slavehisher body.\r\rYou take out your cock and masturbate, quickly cumming, making sure all of it floods into " + coreGame.SlaveName1 + "'s mouth. ");
			if (awake) AddText(SlaveName1 + " seems to wake but is dazed and swallows and lies back and falls asleep again.");
			else AddText(SlaveName1 + " stirs but does not awaken and seems to swallow.");
			if (coreGame.SlaveGender > 3)  AddText(" You look at " + coreGame.SlaveName2 + " and your cock stirs again, and you quickly cum again into " + coreGame.SlaveName2 + "'s mouth too.");
			AddText("\r\rYou know your cum will help #slavehimher to better serve you.");
			if ((coreGame.GameDate - coreGame.LastAny) > 1) {
				coreGame.LastAny = coreGame.GameDate;
				AskHerQuestions(5010, 5011, 5012, 5013, "Once, #slaveheshe will obey sexually", NameCase(coreGame.SlaveHisHer) + " arousal will grow", "Once, #slaveheshe will obey non-sexually", coreGame.SlaveHeSheUC + " will meekly obey", "What does your cum do?");
			} else AskHerQuestions(5014, 5011, 5015, 5013, NameCase(coreGame.SlaveHisHer) + " desire will grow", NameCase(coreGame.SlaveHisHer) + " arousal will grow", coreGame.SlaveHeSheUC + " will have visions of sex", coreGame.SlaveHeSheUC + " will meekly obey", "What does your cum do?");
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, 1);
		}
	}
	
	public function EndingFinishAsAssistant(total:Number) : Boolean 
	{
		if (SMData.Corruption > 89 && SMData.SMDominance < 11 && SMData.SMSpecialEvent == 5) {
			// Succubus
			Backgrounds.ShowBedRoom();
			coreGame.HideEndings();
			coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Succubus.jpg|Images/Appearances/Default Images/Ending - Succubus.jpg", 1, 1);
			coreGame.NumFin += 96;
			Language.XMLData.XMLGeneral("EndGame/SlaveMaker/EndingSuccubus/ReviewScene");
			coreGame.ShowEndingNext();
			return true;
		} 
		if (SMData.Corruption < 11 && SMData.SMDominance > 79 && SMData.SMSpecialEvent == 5) {
			// Repelled Succubus
			Backgrounds.ShowBedRoom();
			coreGame.HideEndings();
			coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Succubus.jpg|Images/Appearances/Default Images/Ending - Succubus.jpg", 1, 1);
			coreGame.StartFadeImage(100, coreGame.lastmc);
			coreGame.NumFin += 96;
			Language.XMLData.XMLGeneral("EndGame/SlaveMaker/EndingRepelledSuccubus/ReviewScene");
			coreGame.ShowEndingNext();
			return true;
		}
		return super.EndingFinishAsAssistant(total);
	}
}