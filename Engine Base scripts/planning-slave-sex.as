import Scripts.Classes.*;
// Sex
// Planning

function NewPlanningActionSex(type:Number, hint:Boolean) : Boolean
{	
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(type);
	var asscan:Boolean = AssistantData.IsAbleToDoAct(act);
	SMData.GetSlaveTotals(type);
	var totfnoa:Number = totfemales;
	var totf:Number = totfnoa;
	if (asscan && AssistantData.IsWoman()) totf += (Math.floor(ServantGender / 4) + 1);
	var totmnoa:Number = totmales;
	var totm:Number = totmnoa;
	if (asscan && !AssistantData.IsFemale()) totm += (Math.floor(ServantGender / 4) + 1);
	var totdgnoa:Number = totdickgirls;
	var totdg:Number = totdgnoa;
	if (asscan && AssistantData.IsDickgirl()) totdg += (Math.floor(ServantGender / 4) + 1);
	
	// Set default participants
	delete Participants;
	Participants = new Array();
	var len:Number = act.Participants.length;
	for (i = 0; i < len; i++) Participants.push(act.Participants[i]);

	if (type > 15 && type != 99) return NewPlanningActionSex2(type, act, asscan, hint, totf, totm, totdg, totfnoa, totmnoa, totdgnoa);

	var totmall:Number = SMData.IsAbleToDoAct(act) && SMData.Gender == 1 ? totm + 1 : totm;
	var totfall:Number = SMData.IsAbleToDoAct(act) && SMData.Gender == 2 ? totf + 1 : totf;
	var totdgall:Number = SMData.IsAbleToDoAct(act) && SMData.Gender == 3 ? totdg + 1 : totdg;

	switch (type) {
			
		// Touch
		case 2:
			if (SMData.IsDominatrix()) {
				ServantActAssess(type, DifficultyTouch, Language.GetHtml("HurtDescription", Language.actNode), false);
				Participants.push(-100);
			} else {
				if (IsDickgirl()) ServantSpeakStart(Language.GetHtml(GetTotalSlavesOwned() > 0 ? "TouchDescriptionSlavesDG" : "TouchDescriptionNoSlavesDG", Language.actNode));
				else ServantSpeakStart(Language.GetHtml(GetTotalSlavesOwned() > 0 ? "TouchDescriptionSlaves" : "TouchDescriptionNoSlaves", Language.actNode));
				ServantActAssess(type, DifficultyTouch, "", false);
				if (hint || Participants.length != 0) return false;
				
				AddQuestion(9020, Language.GetHtml("YouWill2", "Participants"));
				if (asscan) AddQuestion(9019, ServantName);
				if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
				if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
				if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
				AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
				AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
				ShowQuestions(Language.GetHtml("TouchQuestion", Language.actNode));
			}
			return false;
			
		// Lick
		case 3:
		    if (HasCock) ServantSpeakStart(Language.GetHtml("GiveBlowjobDescription", Language.actNode));
			else ServantSpeakStart(Language.GetHtml("LickDescription", Language.actNode));

			ServantActAssess(type, DifficultyLick, "", false);
			if (hint || Participants.length != 0) return false;
				
			AddQuestion(9020, Language.GetHtml("YouWill2", "Participants"));
			if (asscan) AddQuestion(9019, ServantName);
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));

			if (HasCock) ShowQuestions(Language.GetHtml("GiveBlowjobQuestion", Language.actNode));
			else ShowQuestions(Language.GetHtml("LickQuestion", Language.actNode));

			return false;
			
		// Fuck
		case 4:
			ServantSpeakStart("");
			if (SlaveFemale) {
				ServantActAssess(type, DifficultyFuck, Language.GetHtml("FuckDescription", Language.actNode), false);
				if (hint || Participants.length != 0) return false;
				
				if (SMData.Gender == 2) AddQuestion(9020, Language.GetHtml("FuckYouStrapOn", "Participants"));
				else AddQuestion(9020, Language.GetHtml("FuckYou", "Participants"));
				if (asscan) {
					if (ServantWoman) AddQuestion(9019, Language.GetHtml("FuckAssistantStrapOn", "Participants"));
					else AddQuestion(9019, Language.GetHtml("FuckAssistant", "Participants"));
				}
				if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FuckFemaleStrapOn", "Participants"));
				if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
				if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
				AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
				AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
				
				ShowQuestions(Language.GetHtml("FuckQuestion", Language.actNode));
			} else {
				ServantActAssess(type, DifficultyFuck, Language.GetHtml("FuckDescriptionMale", Language.actNode), false);
				if (hint || Participants.length != 0) return false;
				
				if (SMData.Gender != 1) AddQuestion(9020, Language.GetHtml("Yourself", "Participants"));
				if (asscan) {
					if (ServantWoman) AddQuestion(9019, ServantName);
				}
				if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
				if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
				AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
				AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
				
				ShowQuestions(Language.GetHtml("FuckQuestionMale", Language.actNode));

			}
			return false;
			
		// Blowjob/Lick You
		case 5:
			if (LesbianTraining && !IsMale() && SMData.IsDominatrix() && SMData.Gender != 2) SetTextLang("BlowjobLesbianMaster", Language.actNode);
	
			ServantSpeakStart(Language.GetHtml("BlowjobDescription", Language.actNode));
			ServantActAssess(type, DifficultyBlowjob, "", false);
			if (hint || Participants.length != 0) return false;
			
			if (SMData.Gender == 2) AddQuestion(9020, Language.GetHtml("LickYourPussy", Language.actNode));
			else AddQuestion(9020, Language.GetHtml("GiveYouBlowjob", Language.actNode));
			if (asscan) {
				if (ServantWoman) AddQuestion(9019, Language.GetHtml("LickAssistantPussy", Language.actNode));
				else AddQuestion(9019, Language.GetHtml("GiveAssistantBlowjob", Language.actNode));
			}
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("LickSlavePussy", Language.actNode));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("GiveSlaveBlowjob", Language.actNode));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("GiveSlaveBlowjobDG", Language.actNode));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			
			ShowQuestions(Language.GetHtml("BlowjobQuestion", Language.actNode));
			return false;
			
		// Mistress Cock blowjob
		case 99:
			if (LesbianTraining && !IsMale() && SMData.IsDominatrix() && SMData.Gender != 2) SetTextLang("BlowjobLesbianMaster", Language.actNode);
			ServantSpeakStart(Language.GetHtml("BlowjobDescriptionMC", Language.actNode));
			ServantActAssess(type, DifficultyBlowjob, "", false);
			return false;
			
		// Tits Fuck
		case 6:
			ServantSpeakStart("");
			if (LesbianTraining && !IsMale()) {
				if (totfall > 0 || (DickgirlLesbians && totdgall > 0)) {
					Language.AddLangText("TitsFuckLesbianAll", Language.actNode);
					if (DickgirlLesbians && totdgall > 0) Language.AddLangText("TitsFuckDickgirlOption", Language.actNode);
					if ((totm + totdg) > 0 || SMData.Gender != 2) BlankLine();
				}
				if (totm > 0 || SMData.Gender == 1) Language.AddLangText("TitsFuckMaleOption", Language.actNode);
			} else {
				if (totm > 0 || SMData.Gender == 1 || totdg > 0 || SMData.Gender == 3) {
					if (totdg > 0 || SMData.Gender == 3) Language.AddLangText("TitsFuckDickgirlAll", Language.actNode);
					else Language.AddLangText("TitsFuckMale", Language.actNode);
					if (totfall > 0 || (DickgirlLesbians && totdgall > 0)) BlankLine();
				}
				if (totfall > 0 || (DickgirlLesbians && totdgall > 0)) Language.AddLangText("TitsFuckLesbianOption", Language.actNode);
			}
			ServantActAssess(type, DifficultyTitsFuck, "", false);
			if (hint || Participants.length != 0) return false;
			
			if (SMData.Gender == 2) AddQuestion(9020, Language.GetHtml("TitsFuckYouLesbian", Language.actNode));
			else AddQuestion(9020, Language.GetHtml("TitsFuckYou", Language.actNode));
			if (asscan) {
				if (ServantWoman) AddQuestion(9019, Language.GetHtml("TitsFuckAssistantLesbian", Language.actNode));
				else AddQuestion(9019, Language.GetHtml("TitsFuckAssistant", Language.actNode));
			}
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("TitsFuckSlaveLesbian", Language.actNode));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("TitsFuckSlave", Language.actNode));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("TitsFuckSlaveDG", Language.actNode));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			
			ShowQuestions(Language.GetHtml("TitsFuckQuestion", Language.actNode));
			return false;
			
		// Anal
		case 7:
			ServantSpeakStart("");
			ServantActAssess(type, DifficultyFuck, Language.GetHtml("AssFuckDescription", Language.actNode), false);
			if (hint || Participants.length != 0) return false;
			
			if (SMData.Gender == 2) AddQuestion(9020, Language.GetHtml("FuckYouStrapOn", "Participants"));
			else AddQuestion(9020, Language.GetHtml("FuckYou", "Participants"));
			if (asscan) {
				if (ServantGender == 2 || ServantGender == 5) AddQuestion(9019, Language.GetHtml("FuckAssistantStrapOn", "Participants"));
				else AddQuestion(9019, Language.GetHtml("FuckAssistant", "Participants"));
			}
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FuckFemaleStrapOn", "Participants"));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("AnalQuestion", Language.actNode));
			return false;
			
		// Masturbate
		case 8:
			ServantSpeak(Language.GetHtml("MasturbateDescription" + (IsDickgirl() ? "Dickgirl" : SlaveFemale ? "Female" : "Male"), Language.actNode));
			return false;
			
		// Dildo
		case 9:
			if (!hint && ImprovedDildoOK == 0 && DildoOK == 0) {
				ServantSpeak(Language.GetHtml("NoDildo", "Planning"));
				Bloop();
				return true;
			}
			ServantActAssess(type, DifficultyDildo, Language.GetHtml("DildoDescription", Language.actNode));
			return false;
			
		// Anal Plug
		case 10:
			if (!hint) {
				if (PlugOK == 0) {
					ServantSpeak(Language.GetHtml("NoPlug", "Planning"));
					Bloop();
					return true;
				}
				if (CatTailWorn == 1) {
					ServantSpeak(Language.GetHtml("WearingCatTail", "Planning"));
					Bloop();
					return true;
				}
				if (PonyTailWorn == 1) {
					ServantSpeak(Language.GetHtml("WearingPonyTail", "Planning"));
					Bloop();
					return true;
				} else if (PlugInserted != 0 || DonePlug == 1) {
					ServantSpeak(Language.GetHtml("PlugTwice", "Planning"));
					Bloop();
					return true;
				}
			}
			ServantActAssess(type, DifficultyPlug, Language.GetHtml("AnalPlugDescription", Language.actNode));
			return false;
			
		// Lesbian
		case 11:
			if (SlaveFemale) {
				if (SMData.IsDickgirlAmazon()) {
					Language.AddLangText("NoLesbianDA", "Planning");
					Bloop();
					return true;
				} 
				if ((DickgirlLesbians && (totfall + totdgall) == 0) || (!DickgirlLesbians && totfall == 0)) {
					BlankLine();
					Language.ServantSpeakLang("NoFemales", "Planning");
					Bloop();
					return true;
				}
				if (LesbianTraining) ServantActAssess(type, DifficultyLesbian, Language.GetHtml("LesbianLesbianDescription", Language.actNode));
				else ServantActAssess(type, DifficultyLesbian, Language.GetHtml("LesbianDescription", Language.actNode));
				if (hint || Participants.length != 0) return false;
				
				if (SMData.Gender == 2 || (DickgirlLesbians && SMData.Gender == 3)) AddQuestion(9020, Language.GetHtml("YouWill", "Participants"));
				if (ServantWoman && asscan) AddQuestion(9019, Language.GetHtml("AssistantAWill", "Participants"));
				if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
				if (DickgirlLesbians && totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
				AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
				AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
				ShowQuestions(Language.GetHtml("LesbianQuestion", Language.actNode));
			} else {
				if ((totmall + totdgall) == 0) {
					BlankLine();
					if (DickgirlOn == 1) ServantSpeak(Language.GetHtml("NoMales", "Planning"));
					else ServantSpeak(Language.GetHtml("NoMales", "Planning"));
					Bloop();
					return true;
				}
				ServantActAssess(type, DifficultyLesbian, Language.GetHtml("LesbianMaleDescription", Language.actNode));
				if (hint || Participants.length != 0) return false;
				
				if (SMData.Gender == 1 || (DickgirlLesbians && SMData.Gender == 3)) AddQuestion(9000, Language.GetHtml("FuckYou", "Participants"));
				if (asscan) {
					if (!ServantFemale) AddQuestion(9001, ServantName);
				}
				if (totmnoa > 0) AddQuestion(9002, Language.GetHtml("MaleSlave", "Participants"));
				if (totdgnoa > 0) AddQuestion(9003, Language.GetHtml("HermaphroditeSlave", "Participants"));
				AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
				AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
				
				ShowQuestions(Language.GetHtml("FuckQuestionMale", Language.actNode));
			}
			return false;
			
		// Bondage
		case 12:
			if (hint == false && SMData.RopesOK == 0 && SMData.SilkenRopesOK == 0) {
				ServantSpeak(Language.GetHtml("NoBondageGear", "Planning"));
				Bloop();
				return true;
			}
    		ServantActAssess(type, DifficultyBondage, Language.GetHtml("BondageDescription", Language.actNode));
			return false;
			
		// Naked
		case 13:
    		if (!hint && DoneNaked != 0) {
				ServantSpeak(Language.GetHtml("NakedTwice", "Planning"));
				Bloop();
				return true;
			}
			ServantActAssess(type, DifficultyNaked, Language.GetHtml("NakedDescription", Language.actNode));
			return false;
			
		// Master
		case 14:
		    if (DoneMaster == 0) {
				if (IshinaiEffecting == 1 || DoreiEffecting == 1) {
					ServantSpeak(Language.GetHtml("CannotOnDrugs", "Planning"));
					if (!hint) Bloop();
					return true;
				}
				if (!hint && Plannings.IsActPlanned(14)) {
					ServantSpeak(Language.GetHtml("MasterAlreadyAsked", Language.actNode));
					if (!hint) Bloop();
					return true;
				}
				ServantSpeak(Language.GetHtml("MasterDescription", Language.actNode));
			} else {
				ServantSpeak(Language.GetHtml("MasterAlreadyIs", Language.actNode));
				if (!hint) Bloop();
				return true;
			}
			return false;
			
		// Gang Bang
		case 15:
			ServantActAssess(type, DifficultyFuck, Language.GetHtml(DickgirlOn == 1 ? "GangBangDescriptionDG" : "GangBangDescription", Language.actNode), false);
			if (hint || Participants.length != 0) return false;
			
			if ((totmall + totdgall + totfall) < 3) {
				BlankLine();
				ServantSpeak(Language.GetHtml("GangBangNotEnough", "Planning"));
				Bloop();
				return true;
			}
			if (LesbianTraining) {
				if (totfall > 2) AddQuestion(9022, Language.GetHtml("FemalesStrapOns", "Participants"));
				if (totfall > 0 && (DickgirlLesbians && totdgall > 0)) AddQuestion(9023, Language.GetHtml("FeminineSlaves", "Participants"));
				if (totmall > 2) AddQuestion(9021, Language.GetHtml("MalesOnly", "Participants"));
			} else {
				if (totmall > 2) AddQuestion(9021, Language.GetHtml("MalesOnly", "Participants"));
				if (totfall > 0 && (DickgirlLesbians && totdgall > 0)) AddQuestion(9023, Language.GetHtml("FeminineSlaves", "Participants"));				
				if (totfall > 2) AddQuestion(9022, Language.GetHtml("FemalesStrapOns", "Participants"));
			}
			if (totdgall > 2) AddQuestion(9023, Language.GetHtml("HermaphroditesOnly", "Participants"));
			if (totmall > 0 && totfall > 0) AddQuestion(9004, Language.GetHtml("AMixture", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("GangBangQuestion", Language.actNode));
			return false;
	}
	return false;
}

function NewPlanningActionSex2(type:Number, act:ActInfo, asscan:Boolean, hint:Boolean, totf:Number, totm:Number, totdg:Number, totfnoa:Number, totmnoa:Number, totdgnoa:Number) : Boolean
{
	var totmall:Number = SMData.IsAbleToDoAct(act) && SMData.Gender == 1 ? totm + 1 : totm;
	var totfall:Number = SMData.IsAbleToDoAct(act) && SMData.Gender == 2 ? totf + 1 : totf;
	var totdgall:Number = SMData.IsAbleToDoAct(act) && SMData.Gender == 3 ? totdg + 1 : totdg;

	switch (type) {

		// Lend
		case 16:
			if (!hint && LendPerson != 0) {
				ServantSpeak(Language.GetHtml("AlreadyLent", "Planning"));
				Bloop();
				return true;
			}
			ServantActAssess(type, DifficultyLendHer, Language.GetHtml("LendDescription", Language.actNode));
			if (hint) return false;
			BlankLine();
			AddText(Language.GetHtml("LendQuestion", Language.actNode));
			currentCity.ShowLendMenu();
			return false;
			
		// Ponygirl
		case 17:
			if (!hint && IshinaiEffecting == 1 || DoreiEffecting == 1) {
				ServantSpeak(Language.GetHtml("CannotOnDrugs", "Planning"));
				Bloop();
				return true;
			}
			if (!hint && DoneMaster == 0) {
				ServantSpeak(Language.GetHtml("PonygirlNoMaster", Language.actNode));
				Bloop();
				return true;
			}
			if (!hint && IsPonygirl()) {
				ServantSpeak(Language.GetHtml("PonygirlAlready", Language.actNode));
				Bloop();
				return true;
			}
			if (!hint && Plannings.IsActPlanned(17)) {
				ServantSpeak(Language.GetHtml("PonygirlAlreadyAsked", Language.actNode));
				Bloop();
				return true;
			}
			ServantSpeak(Language.GetHtml("PonygirlDescription", Language.actNode));
			return false;

		// Spank
		case 18:
			if (SMData.IsDominatrix()) {
				if (SMData.GetWeaponClass().toLowerCase() == "whip") XMLData.XMLGeneral("Planning/Acts/SpankingDescriptionWhip");
				else XMLData.XMLGeneral("Planning/Acts/SpankingDescriptionDom");
			} else XMLData.XMLGeneral("Planning/Acts/SpankingDescrption");
			return false;
			
		// Threesome
		case 19:
			ServantSpeakStart(Language.GetHtml("ThreesomeDescription", Language.actNode));
			ServantActAssess(type, DifficultyThreesome, "", false);
			if (hint || Participants.length != 0) return false;
			
			if ((totmall + totdgall + totfall) < 2) {
				BlankLine();
				SetText(Language.GetHtml("ThreesomeNotEnough", Language.actNode));
				Bloop();
				return true;
			}
			
			if (totf > 0) {
				if (totfnoa > 0) AddQuestion(9018.2, Language.GetHtml("ThreesomeYouFemale", Language.actNode));
				if (AssistantData.IsWoman() && asscan) {
					AddQuestion(9018.2, Language.GetHtml("ThreesomeYouAssistant", Language.actNode));
					if (totfnoa > 0) AddQuestion(9019.2, Language.GetHtml("ThreesomeAssistantFemale", Language.actNode));
				}
				if (totfnoa > 1) AddQuestion(9022, Language.GetHtml("ThreesomeFemales", Language.actNode));
			}
			if (totm > 0) {
				if (totmnoa > 0) AddQuestion(9018.1, Language.GetHtml("ThreesomeYouMale", Language.actNode));
				if (AssistantData.IsMale() && asscan) {
					AddQuestion(9018.1, Language.GetHtml("ThreesomeYouAssistant", Language.actNode));
					if (totmnoa > 0) AddQuestion(9019.1, Language.GetHtml("ThreesomeAssistantMale", Language.actNode));
				}
				if (totmnoa > 1) AddQuestion(9021,Language.GetHtml("ThreesomeMales", Language.actNode));
			}
			if (totdg > 0) {
				if (totdgnoa > 0) AddQuestion(9018.3, Language.GetHtml("ThreesomeYouDickgirl", Language.actNode));
				if (AssistantData.IsDickgirl() && asscan) {
					AddQuestion(9018.3, Language.GetHtml("ThreesomeYouAssistant", Language.actNode));
					if (totdgnoa > 0) AddQuestion(9019.3, Language.GetHtml("ThreesomeAssistantDickgirl", Language.actNode));
				}
				if (totdgnoa > 1) AddQuestion(9023, Language.GetHtml("ThreesomeDickgirls", Language.actNode));
			}
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("ThreesomeQuestion", Language.actNode));
			return false;
			
		// 69
		case 20:
			ServantSpeakStart(Language.GetHtml("SixtyNineDescription", Language.actNode));
			ServantActAssess(type, DifficultyBlowjob + 3, "", false);
			if (hint || Participants.length != 0) return false;

			AddQuestion(9020, Language.GetHtml("YouWill", "Participants"));
			if (asscan) AddQuestion(9019, ServantA);
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("SixtyNineQuestion", Language.actNode));
			return false;
			
		// Orgy
		case 21:
			ServantActAssess(type, DifficultyGangBang - 10, Language.GetHtml("OrgyDescription", Language.actNode));
			if (hint || Participants.length != 0) return false;
			
			if ((totmall + totdgall + totfall) < 3) {
				BlankLine();
				ServantSpeak(Language.GetHtml("OrgyNotEnough", Language.actNode));
				Bloop();
				return true;
			}
			
			if ((totmall + totdgall) > 0 && totfall > 0) AddQuestion(9026, Language.GetHtml("AMixture", "Participants"));
			if (totmall > 2) AddQuestion(9021, Language.GetHtml("MalesOnly", "Participants"));
			if (totfall > 2) AddQuestion(9022, Language.GetHtml("FemalesOnly", "Participants"));
			if (totdgall > 2) AddQuestion(9023, Language.GetHtml("HermaphroditesOnly", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("OrgyQuestion", Language.actNode));
			return false;
						
		// Kiss
		case 23:
			ServantSpeakStart(Language.GetHtml("KissDescription" + (GetTotalSlavesOwned() > 0 ? "Slaves" : "NoSlaves"), Language.actNode));
			ServantActAssess(type, DifficultyBlowjob + 3, "", false);
			if (hint || Participants.length != 0) return false;
			
			AddQuestion(9020, Language.GetHtml("YouWillKiss", Language.actNode));
			if (asscan) {
				if (ServantFemale) AddQuestion(9019, ServantA);
				else AddQuestion(9019, ServantA);
			}
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));

			ShowQuestions(Language.GetHtml("KissQuestion", Language.actNode));
			return false;
			
		// Strip Tease
		case 24:
			if (!hint && Naked) {
				ServantSpeak(Language.GetHtml("NakedStripTease", "Planning"));
				Bloop();
				return true;
			}
			ServantActAssess(type, DifficultyExhib, Language.GetHtml("StripTeaseDescription", Language.actNode));
			return false;
			
		// Cum Bath
		case 25:
			if (!hint && LesbianTraining && !IsMale()) {
				if (SMAdvantages.CheckBitFlag(8) || SMAdvantages.CheckBitFlag(22) || SMData.sSlutTrainer == 2) {
					if (!BitFlag1.CheckAndSetBitFlag(56)) Language.SetLangText("CumBathSlutTrainerLesbian", Language.actNode);
				} else {
					ServantSpeak(Language.GetHtml("NorForLesbians", "Participants"));
					Bloop();
					return true;
				}
			}
			if (SMData.IsDickgirlAmazon()) {
				if (AssistantData.IsDickgirl()) ServantSpeakStart(Language.GetText("CumBathDescriptionAmazonAss", Language.actNode));
				else ServantSpeakStart(Language.GetText("CumBathDescriptionAmazon", Language.actNode));
				if (hint) return false;
				if (totdgall < 3) {
					BlankLine();
					ServantSpeak(Language.GetHtml("NoHermaphrodites", "Planning"));
					Bloop();
					return true;
				}
			} else {
				var str:String = "";
				if (SMData.Gender != 2) {
					if (AssistantData.IsDickgirl()) str = "We";
					else str = "You";
				}
				if (totdgnoa > 0) {
					if (totmnoa > 0) ServantSpeakStart(Language.GetText("CumBathMaleDickgirlSlaves" + str, Language.actNode));
					else ServantSpeakStart(Language.GetText("CumBathDickgirlSlaves" + str, Language.actNode));
				} else ServantSpeakStart(Language.GetText("CumBathMaleSlaves" + str, Language.actNode));
			}
			ServantActAssess(type, DifficultyGangBang-5, "", false);
			if (hint) return false;
			if ((totmall + totdgall) < 3) {
				BlankLine();
				if (DickgirlOn == 1) ServantSpeak(Language.GetHtml("NoMalesOrHermaphrodites", "Planning"));
				else ServantSpeak(Language.GetHtml("NoMales", "Planning"));
				Bloop();
				return true;
			}
			return false;
			
		// Footjob
		case 30:
			ServantSpeakStart(Language.GetHtml("FootjobDescription", Language.actNode));
			ServantActAssess(type, DifficultyBlowjob - 3, "", false);
			if (hint || Participants.length != 0) return false;
			
			if (SMData.Gender == 2) AddQuestion(9020, Language.GetHtml("RubYourPussy", Language.actNode));
			else AddQuestion(9020, Language.GetHtml("RubYourCock", Language.actNode));
			if (asscan) {
				if (ServantWoman) AddQuestion(9019, Language.GetHtml("RubAssistantPussy", Language.actNode));
				else AddQuestion(9019, Language.GetHtml("RubAssistantCock", Language.actNode));
			}
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("RubFemalePussy", Language.actNode));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("RubMaleCock", Language.actNode));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("RubDickgirlCock", Language.actNode));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			
			ShowQuestions(Language.GetHtml("FootjobQuestion", Language.actNode));
			return false;

		// Handjob
		case 31:
			ServantSpeakStart(Language.GetHtml("HandjobDescription", Language.actNode));
			ServantActAssess(type, DifficultyBlowjob - 5, "", false);
			if (hint || Participants.length != 0) return false;
			
			if (SMData.Gender == 2) AddQuestion(9020, Language.GetHtml("RubYourPussy", Language.actNode));
			else AddQuestion(9020, Language.GetHtml("StrokeYourCock", Language.actNode));
			if (asscan) {
				if (ServantWoman) AddQuestion(9019, Language.GetHtml("RubAssistantPussy", Language.actNode));
				else AddQuestion(9019, Language.GetHtml("StrokeAssistantCock", Language.actNode));
			}
			if (totfnoa > 0) AddQuestion(9012, Language.GetHtml("RubFemalePussy", Language.actNode));
			if (totmnoa > 0) AddQuestion(9011, Language.GetHtml("StrokeMaleCock", Language.actNode));
			if (totdgnoa > 0) AddQuestion(9013, Language.GetHtml("StrokeDickgirlCock", Language.actNode));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			
			ShowQuestions(Language.GetHtml("HandjobQuestion", Language.actNode));
			return false;

		// custom
		default:
			if (DaysUnavailable != 0) {
				XMLData.XMLGeneral("Planning/SlaveUnwellNight", true);
				Bloop();
				return;
			}		
			var act:ActInfo = slaveData.ActInfoBase.GetActAbs(type);
			ServantSpeak(act.Description);
			if (hint || Participants.length != 0 || act.MinParticipants == 0) return false;
			
			if (act.MinParticipants == 1) {
				// one on one act
				if (SMData.IsAbleToDoAct(act)) AddQuestion(9020, Language.GetHtml("YouWill2", "Participants"));
				if (asscan && act.IsAbleToDoAct(ServantGender) && AssistantData.DaysUnavailable == 0) AddQuestion(9019, ServantName);
				if (totfnoa > 0 && act.IsAbleToDoAct(2)) AddQuestion(9012, Language.GetHtml("FemaleSlave", "Participants"));
				if (totmnoa > 0 && act.IsAbleToDoAct(1)) AddQuestion(9011, Language.GetHtml("MaleSlave", "Participants"));
				if (totdgnoa > 0 && act.IsAbleToDoAct(3)) AddQuestion(9013, Language.GetHtml("HermaphroditeSlave", "Participants"));
				AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
				AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
				ShowQuestions(Language.GetHtml("CustomQuestion", Language.actNode));
				return false;
			} 
			// multiple partners
			if ((totmall + totfall + totdgall) < act.MinParticipants) {
				BlankLine();
				ServantSpeak(Language.GetHtml("GangBangNotEnough", "Planning"));
				Bloop();
				return true;
			}
			
			if (totmall >= act.MinParticipants) AddQuestion(9021, Language.GetHtml("MalesOnly", "Participants"));
			if (totfall >= act.MinParticipants) AddQuestion(9022, Language.GetHtml("FemalesOnly", "Participants"));
			if (totdgall >= act.MinParticipants) AddQuestion(9023, Language.GetHtml("HermaphroditesOnly", "Participants"));
			if ((totmall > 0 && (totfall > 0 || totdgall > 0)) || (totfall > 0 && (totmall > 0 || totdgall > 0))) AddQuestion(9026, Language.GetHtml("AMixture", "Participants"));
			AddQuestion(9098, Language.GetHtml("PickParticipants", "Participants", true));
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("CustomQuestion", Language.actNode));
			return false;
			
	}
	return false;
}
