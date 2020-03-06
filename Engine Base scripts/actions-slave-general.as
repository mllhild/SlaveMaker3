import Scripts.Classes.*;
// Actions


// Chores
//=======


// Cooking
//	1001	- normal training
//	1001.1 	- trained by a tutor
//	1002.2	- trained by Haro (minor slave)
//	1002.3	- trained by Sana (minor slave)
//	1001.4 	- clean as she can (but she is at max cleaning)
function DoChoreCooking() {
	
	FirstTimeToday = FirstTimeTodayCooking;
	Backgrounds.ShowKitchen();
	SlaveGirl.ShowChoreCooking();
	if (SelectActImage()) Generic.ShowChoreCooking();

	TotalCooking++;
	
	if (Action == 1001.1 || Action == 1001.2 || Action == 1001.3) DoChoreCookingTutored();
	else if (AppendActText) XMLData.DoXMLAct("Cooking");
	
	Points(0, 0, -1, 0, 0, 0, 2 + Home.hKitchen, 0, 0, 0, 0, 0, -1, 0, 0, 0, 4 - Home.hKitchen, 0, 0, 0);
	Home.ActualCooking += 2;
	
	Sounds.PlaySound("Frying");
	FirstTimeTodayCooking = false;
}

function DoChoreCookingTutored()
{
	UpdateFactors()
	var cookinc:Number = 2 + Home.hKitchen;
	cookinc = cookinc * CookingFactor;
	ChangeMaxStats(0, 0, 0, 0, 0, 0, cookinc);
	
	var cf:Number = currFrame;
	if (Action == 1001.1) People.ShowPerson(5, 0, 1, 1);
	else if (action == 1001.2) ShowSlave("Haro", 0, 1);
	else ShowSlave("Sana", 0, 1);
	currFrame = cf;
	
	if (AppendActText) {
		if (Action == 1001.1) {
			PersonSpeak("Tutor", "You are a fine cook. Looks like there are a few pointers I can give you.");
			AddText("\r\rThe tutor teaches #slave some new recipes and techniques.");
			if (Naked) {
				AddText("\r\r");
				if (ApronWorn == 1) PersonSpeak("Tutor", "I see you are wearing ONLY an apron!", true);
				else PersonSpeak("Tutor", "You really should wear an apron, naked cooking is not really recommended", true);
			}
		} else if (Action == 1001.2) {
			PersonSpeak("Haro", "You are a fine cook. Looks like there are a few pointers I can give you.");
			AddText("\r\rHaro teaches #slave some new recipes and techniques.");
			if (Naked) {
				AddText("\r\r");
				if (ApronWorn == 1) {
					PersonSpeak("Haro", "I see you are wearing ONLY an apron, a good idea!", true);
					AddText("Haro removes all her clothes, except her apron. Her cock is quite erect...");
				} else PersonSpeak("Haro", "You really should wear an apron, naked cooking just invites someone to step behind you and put her cock...", true);
			}
		} else {
			PersonSpeak("Sana", "Oh dear, you are a fine cook. Looks like there are a few pointers I can give you.");
			AddText("\r\rSana teaches #slave some new recipes and techniques.");
			if (Naked) {
				AddText("\r\r");
				if (ApronWorn == 1) PersonSpeak("Sana", "Oh dear, I see you are wearing ONLY an apron, it is very embarrassing!", true);
				else PersonSpeak("Sana", "You really should wear an apron, being naked is a bit disgraceful for your owner.", true);
			}
		}
		XMLData.DoXMLAct("CookingTutored");
	}
}


// Cleaning
//	1002		- normal training
//	1002.1 	- trained by a tutor
//	1002.2	- trained by Haro (minor slave)
//	1002.3	- trained by Sana (minor slave)
//	1002.4	- clean as she can (but she is at max cleaning)
function DoChoreCleaning() {

	FirstTimeToday = FirstTimeToday;
	
	SlaveGirl.ShowChoreCleaning();
	if (SelectActImage()) Generic.ShowChoreCleaning();
	
	TotalCleaning++;
	
	if (Action == 1002.1 || Action == 1002.2 || Action == 1002.3) DoChoreCleaningTutored();
	else DoChoreCleaningSolo();
	
	Points(-1, 0, 0, -1, 0, 0, 0, 2 + Home.hKitchen, 0, 0, 0, 0, -1, 0, 0, 0, 4 - Home.hKitchen, 0, 0, 0);
	Home.ActualHouseWork += 2;
	
	if (StandardPlugText) {
		temp = Math.floor(Math.random()*2);
		if (temp == 1) {
			AddText("\r\r#slave found cleaning difficult due to the  #plugtype limiting #slavehisher actions.");
			if (TotalAnal < 10) AddText(" #slave once complained about the #plugtype, saying how distracting it is.");
			else AddText(" " + SlaveHeSheUC + NonPlural(" comment") + " how the #plugtype helped #slavehisher by making the cleaning less dull.");
		}
	}
	FirstTimeTodayCleaning = false;
}

function DoChoreCleaningTutored()
{
	UpdateFactors();
	var cleaninc:Number = Home.hKitchen + 2;
	cleaninc = cleaninc * CleaningFactor;
	ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, cleaninc);
	
	var cf:Number = currFrame;
	if (Action == 1001.1) People.ShowPerson(5, 0, 1, 1);
	else if (action == 1001.2) ShowSlave("Haro", 0, 1);
	else ShowSlave("Sana", 0, 1);
	currFrame = cf;

	if (AppendActText) {
		if (Action == 1001.1) {
			PersonSpeak("Tutor", "You are excellent at housework. Looks like there are a few pointers I can give you.", true);
			AddText("\r\rThe tutor teaches #slave some time saving techniques and recommends some cleaning products.");
			if (Naked) {
				BlankLine();
				if (ApronWorn == 1) PersonSpeak("Tutor", "I see you are wearing ONLY an apron!", true);
				else PersonSpeak("Tutor", "You really should wear an apron, naked housework is a little <i>dirty</i>.", true);
			}
		} else if (Action = 1001.2) {
			PersonSpeak("Haro", "You are excellent at housework. Looks like there are a few pointers I can give you.", true);
			AddText("\r\rHaro teaches #slave some time saving techniques and recommends some cleaning products.");
			if (Naked) {
				BlankLine();
				if (ApronWorn == 1) {
					PersonSpeak("Haro", "I see you are wearing ONLY an apron, a good idea!", true);
					AddText("Haro removes all her clothes, except her apron. Her cock is quite erect...");
				} else PersonSpeak("Haro", "You really should wear an apron, naked housework just invites someone to step behind you a put her cock...", true);
			}
		} else {
			PersonSpeak("Sana", "Oh dear, you are excellent at housework. Looks like there are a few pointers I can give you.", true);
			AddText("\r\rSana teaches #slave some time saving techniques and recommends some cleaning products.");
			if (Naked) {
				BlankLine();
				if (ApronWorn == 1) PersonSpeak("Sana", "Oh dear, I see you are wearing ONLY an apron, it is very embarrassing!", true);
				else PersonSpeak("Sana", "Oh dear, you really should wear an apron, naked housework is embarrassing and dirty!", true);
			}
		}
		XMLData.DoXMLAct("CleaningTutored");
	}
}

function DoChoreCleaningSolo()
{
	if (!AppendActText) return;
	
	if (Supervise) {
		AddText("You watch as " + SlaveVerb("clean") + " the house well and sweeps the yard.");
		if (SlaveFemale && Aroused) {
			temp = Math.floor(Math.random()*4);
			if (temp == 1) AddText("\r\rOnce #slaveheshe dusted a table using #slavehisher breasts...");
			if (temp == 2) {
				if (SlaveGender > 3) AddText("\r\rWhen they thought you were not watching, they quickly rubbed each others pussies while dusting.");
				else AddText("\r\rWhen #slaveheshe thought you were not watching, she rubbed her pussy against the corner of a cupboard while dusting.");
			}
		}
	} else {
		ServantSpeakStart(SlaveHeSheUC + " cleaned the house well and even swept the yard.");
		if (SlaveFemale && Aroused) {
			temp = Math.floor(Math.random()*4);
			if (temp == 1) AddText("\r\r#Slaveheshe did dust a table using #slavehisher breasts.");
			if (temp == 2) {
				if (SlaveGender > 3) AddText("\r\r#Slaveheshe did rub each others pussies when partially hidden behind a cupboard while dusting.");
				else AddText("\r\r#Slaveheshe did rub #slavehisher pussy against the corner of a cupboard while dusting.");
			}
		}
	}
	if (Naked) {
		BlankLine();
		if (ApronWorn == 1) AddText("As you see " + SlaveHeSheIs + " wearing ONLY an apron!");
		else AddText(SlaveHeSheUC + " really should wear an apron, naked housework is a little <i>strange</i>.");
	}
	if (!Supervise) ServantSpeakEnd();
	XMLData.DoXMLAct("Cleaning");
}


// Discuss
function DoChoreDiscuss() {
	
	FirstTimeToday = FirstTimeTodayDiscuss;
	SMAvatar.ShowSlaveMaker();
	SlaveGirl.ShowChoreDiscuss();
	TotalDiscuss++;
	if (!IsEventAllowable()) return;

	if (IshinaiEffecting == 1) Language.ServantSpeakLang("SlaveOnDrugs");
    else if (DoreiEffecting == 1) Language.ServantSpeakLang("SlaveOnDrugsAndIncoherent");
    else {
		
		if (FirstTimeTodayDiscuss) {
			HidePlanningNext();
			XMLData.DoXMLAct("Discuss");
			if (IsEventAllowable()) {
				DiscussOrdinary._visible = true;
				DiscussCongratulate._visible = true;
				DiscussScold._visible = true;
			}
		} else DoLaterDiscussion();
	}
}

// Chore - Discuss - Ordinary
function DoOrdinaryDiscussion()
{	
	Beep();
	ShowPlanningNext();
	SetText("");
	ResetQuestions(Language.GetHtml("DiscussQuestion", Language.actNode));
	DiscussOrdinary._visible = false;
	DiscussCongratulate._visible = false;
	DiscussScold._visible = false;
		
	if (SlaveGirl.DoOrdinaryDiscussion() != true) {
		VarLovePoints++;
		if (!XMLData.DoXMLAct("DiscussOrdinary")) {
			SlaveSpeakStart("");
			if (VarLovePoints > 50) AddText("Darling, ");
			if (VarObedienceRounded > 70)
			{
				if (DrugAddicted == 1)
				{
					AddText("Please, #slavepronoun need drugs...");
				}
				else if (VarLibidoRounded > 90)
				{
					AddText("#slavepronoun beg you, please, #slavepronoun need to be fucked");
				}
				else if (VarJoyRounded > 70)
				{
					AddText("In fact, #slavepronoun am happy that #slavepronoun became a slave.");
				}
				else if (VarJoyRounded > 50)
				{
					AddText("#slavepronoun wouldn't have thought that being a slave would be good.");
				}
				else if (VarJoyRounded > 15)
				{
					AddText("Please, give me your orders.");
				}
				else
				{
					AddText("#slavepronoun feel better when #slavepronoun talk with you.");
				} 
			}
			else if (VarObedienceRounded > 50)
			{
				if (DrugAddicted == 1)
				{
					AddText("Please, #slavepronoun need my drugs...");
				}
				else if (VarLibidoRounded > 80)
				{
					AddText("please, #slavepronoun need to be fucked");
				}
				else if (VarJoyRounded > 70)
				{
					AddText("#slavepronoun wanted to thank you for training me.");
				}
				else if (VarJoyRounded > 50)
				{
					AddText("At the moment, #slavepronoun feel like enjoying this life.");
				}
				else if (VarJoyRounded > 15)
				{
					AddText("A slave life is not that bad after all.");
				}
				else
				{
					AddText("#slavepronoun feel a bit sad.");
				}
			}
			else if (VarObedienceRounded > 15)
			{
				if (DrugAddicted == 1)
				{
					AddText("#slavepronoun need my drug... Quick...");
				}
				else if (VarLibidoRounded > 80)
				{
					AddText("#slavepronoun can't take it anymore! #slavepronoun want to fuck!");
				}
				else if (VarJoyRounded > 70)
				{
					AddText("#slavepronoun am wondering, maybe being a slave is not that bad if the slave agrees.");
				}
				else if (VarJoyRounded > 50)
				{
					AddText("#slavepronoun don't feel too bad here but #slavepronoun miss my family.");
				}
				else if (VarJoyRounded > 15)
				{
					AddText("You really like to train slaves?");
				}
				else if (Loyalty > 0)
				{
					AddText("You don't want to make me slave, #slavepronoun hope.");
				}
				else
				{
					AddText("#slave will do my best.");
				}
			}
			else if (DrugAddicted == 1)
			{
				AddText("You bastard, give me my drugs!");
			}
			else if (VarLibidoRounded > 80)
			{
				if (Loyalty > 0)
				{
					AddText("Okay, you win, #slavepronoun will do what you want but please fuck me!!");
				}
				else
				{
					AddText("Please, #slave will do what you want but please fuck me!");
				} 
			}
			else if (VarJoyRounded > 70)
			{
				AddText("In fact, it's fun being here. You're not really authoritarian but you're fun.");
			}
			else if (VarJoyRounded > 50)
			{
				AddText("#slavepronoun would have thought someone more authoritarian would train slaves.");
			}
			else if (VarJoyRounded > 15)
			{
				if (Loyalty > 0)
				{
					AddText("You still think #slavepronoun will obey you?");
				}
				else
				{
					AddText("#slave wonders if #slaveheshe really should have sold #slavehimherself.");
				} 
			}
			else if (Loyalty > 0)
			{
				AddText("You monster! You'll never make me a slave!");
			}
			else
			{
				AddText("Sometimes, #slavepronoun think you don't like me.");
			} 
			SlaveSpeakEnd();
		}
	}
	SeePregnant();
	FirstTimeTodayDiscuss = false;
}


// Chore - Discuss - Congratulate
function DoCongratulate()
{
	Beep();
	ShowPlanningNext();
	ResetQuestions("How do you congratulate #slave?");
	DiscussOrdinary._visible = false;
	DiscussCongratulate._visible = false;
	DiscussScold._visible = false;
	
	if (SlaveGirl.DoCongratulate() == true) return;

	if (WinContest > 0 && WinContest < 4) {
		SetText("You discuss the competition this morning.\r\r\"");
		if (WinContest == 1) AddText("Congratulations on your victory in the contest. You showed your excellence as a slave.\"\r\r");
		else AddText("Congratulations on your ranking in the contest, we just need to try harder so you can win next time.\"\r\r");
		VarJoy = VarJoy + 1;
		AddText("You then discuss #slavehisher sexual training\r\r\"");
	} else SetText("You discuss #slavehisher training, and especially #slavehisher sexual training\r\r\"");
	
	var LastDone:Number = Math.floor(Math.abs(PreviousActionDone));
	var tempstr:String = GetSexActShortDescription(LastDone);
	if (LastDone == 2) DifficultyTouch = DifficultyTouch - 2;
	else if (LastDone == 3)	DifficultyLick = DifficultyLick - 2;
	else if (LastDone == 4)	DifficultyFuck = DifficultyFuck - 2;
	else if (LastDone == 5)	DifficultyBlowjob = DifficultyBlowjob - 2;
	else if (LastDone == 6)	DifficultyTitsFuck = DifficultyTitsFuck - 2;
	else if (LastDone == 7)	DifficultyAnal = DifficultyAnal - 2;
	else if (LastDone == 8)	DifficultyMasturbate = DifficultyMasturbate - 2;
	else if (LastDone == 9)	DifficultyDildo = DifficultyDildo - 2;
	else if (LastDone == 10) DifficultyPlug = DifficultyPlug - 2;
	else if (LastDone == 11) DifficultyLesbian = DifficultyLesbian - 2;
	else if (LastDone == 12) DifficultyBondage = DifficultyBondage - 2;
	else if (LastDone == 13) DifficultyNaked = DifficultyNaked - 2;
	else if (LastDone == 15) DifficultyGangBang = DifficultyGangBang - 2;
	else if (LastDone == 16) DifficultyLendHer = DifficultyLendHer - 2;
	else if (LastDone == 17) DifficultyPonygirl = DifficultyPonygirl - 2;
	else if (LastDone == 18) DifficultySpank = DifficultySpank - 2;
	else if (LastDone == 19) DifficultyThreesome = DifficultyThreesome - 2;
	else if (LastDone == 20) DifficultyBlowjob = DifficultyBlowjob - 2;
	else if (LastDone == 21) DifficultyGangBang = DifficultyGangBang - 2;
	else if (LastDone == 24) DifficultyExhib = DifficultyExhib - 1;
	else if (LastDone == 25) DifficultyGangBang = DifficultyGangBang - 1;
	if (tempstr != "" && tempstr != undefined) AddText("Last night you agreed to " + tempstr + ", you are getting better and better, so thank you.\"");
	else {
		if (LastActionRefused != 0) AddText("You are doing very well as a slave, but you must try to agree to do what I ask of you. I am proud to train you.\"");
		else AddText("You are doing very well as a slave, I am proud to train you.\"");
	}
	XMLData.DoXMLAct("DiscussCongratulate");
	
	SeePregnant();
	FirstTimeTodayDiscuss = false;
}


// Chores - Discuss - Scold
function DoScold()
{
	Beep();
	ShowPlanningNext();
	ResetQuestions("How do you scold #slave?");
	DoneScold = true;
	DiscussOrdinary._visible = false;
	DiscussCongratulate._visible = false;
	DiscussScold._visible = false;
	
	if (SlaveGirl.DoScold() == true) return;
	
	var LastDone:Number = Math.floor(Math.abs(LastActionRefused));
	var tempstr:String = GetSexActShortDescription(LastDone);
	if (tempstr == undefined) tempstr = "";
	if (LastDone == 2) DifficultyTouch = DifficultyTouch - 2;
	else if (LastDone == 3)	DifficultyLick = DifficultyLick - 2;
	else if (LastDone == 4)	DifficultyFuck = DifficultyFuck - 2;
	else if (LastDone == 5)	DifficultyBlowjob = DifficultyBlowjob - 2;
	else if (LastDone == 6)	DifficultyTitsFuck = DifficultyTitsFuck - 2;
	else if (LastDone == 7)	DifficultyAnal = DifficultyAnal - 2;
	else if (LastDone == 8)	DifficultyMasturbate = DifficultyMasturbate - 2;
	else if (LastDone == 9)	DifficultyDildo = DifficultyDildo - 2;
	else if (LastDone == 10) DifficultyPlug = DifficultyPlug - 2;
	else if (LastDone == 11) DifficultyLesbian = DifficultyLesbian - 2;
	else if (LastDone == 12) DifficultyBondage = DifficultyBondage - 2;
	else if (LastDone == 13) DifficultyNaked = DifficultyNaked - 2;
	else if (LastDone == 15) DifficultyGangBang = DifficultyGangBang - 2;
	else if (LastDone == 16) DifficultyLendHer = DifficultyLendHer - 2;
	else if (LastDone == 17) DifficultyPonygirl = DifficultyPonygirl - 2;
	else if (LastDone == 18) DifficultySpank = DifficultySpank - 2;
	else if (LastDone == 19) DifficultyThreesome = DifficultyThreesome - 2;
	else if (LastDone == 20) DifficultyBlowjob = DifficultyBlowjob - 2;
	else if (LastDone == 21) DifficultyGangBang = DifficultyGangBang - 2;
	else if (LastDone == 24) DifficultyExhib = DifficultyExhib - 1;
	else if (LastDone == 25) DifficultyGangBang = DifficultyGangBang - 1;
  
	if (GameDate > TrainingStart && tempstr != "") SetText("You discuss #slavehisher failures of the previous night.\r\r\"");
	else SetText("You seriously discuss #slavehisher training.\r\r\"");
	if (tempstr != "") AddText("You refused to " + tempstr + ", that was very naughty. You have to learn to enjoy it.\"\r\r");
	else AddText("#slave, you need to try harder and obey me and #assistant\"\r\r");
	VarJoy = VarJoy - 1;
	if (OldLover == 1 || EventBoyfriend == 1)
	{
		VarMorality = VarMorality + 1;
		ServantSpeak(SlaveHeSheUC + " promised #slaveheshe won't see #slavehisher lover again. " + ServantPronoun + " hope #slaveheshe will do it.", true);
	}
	XMLData.DoXMLAct("DiscussScold");
	
	SeePregnant();
	FirstTimeTodayDiscuss = false;
	FirstTimeToday = FirstTimeTodayDiscuss;
	LastActionRefused = 0;
}


// Chores - Discuss - Later
function DoLaterDiscussion()
{
	ResetQuestions();
	if (Slavegirl.DoLaterDiscussion() == true) return;
	XMLData.DoXMLAct("DiscussOrdinaryLater");
}

DiscussOrdinary.Btn.tabChildren = true;
DiscussOrdinary.Btn.onPress = DoOrdinaryDiscussion;
DiscussCongratulate.Btn.tabChildren = true;
DiscussCongratulate.Btn.onPress = DoCongratulate;
DiscussScold.Btn.tabChildren = true;
DiscussScold.Btn.onPress = DoScold;



// Expose
function DoChoreExpose() {
	if (TestObedience(DifficultyExhib, 100)) {

		if (Naked) {
			ServantSpeak(Language.GetHtml("ExposeNaked", "Planning"));
			Bloop();
			return;
		}
		FirstTimeToday = FirstTimeTodayExpose;
		Backgrounds.ShowTownCenter();
		
		SlaveGirl.ShowChoreExpose();
		if (SelectActImage()) Generic.ShowChoreExpose();
		
		TotalExpose++;
		
		Points(1, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2, 1, 3, 0, 0, 0, 0, 0);
		if (TotalExpose == 1) DifficultyExhib = DifficultyExhib - 5;
		if (AppendActText) {
			if (Supervise) {
				if (SlaveFemale) {
					if (SlaveGender > 3) SetText("You walk to a public park and they expose their breasts and pussies to people.");
					else SetText("You walk to a public park and she exposes her breasts and pussy to people.");
				} else {
					if (SlaveGender > 3) SetText("You walk to a public park and they expose their cocks to people.");
					else SetText("You walk to a public park and he exposes his cock to people.");
				}
			} else ServantSpeakStart(SlaveHeSheUC + " happily " + NonPlural("expose") + " #slavehimherself.");
			XMLData.DoXMLAct("Expose");
		}
		if (StandardDGText) {
			if (SlaveGender > 3) {
				if (SlaveGirl.IsDickgirl() || (DickgirlXF > 0)) AddText(" Their cocks were amazingly erect the whole time!");
				if (DickgirlChanged) AddText(" They did not notice that they had cocks again and showed their erect cocks regularly, unconsciously stroking them sometimes.");
			} else {
				if (SlaveGirl.IsDickgirl() || (DickgirlXF > 0)) AddText(" Her cock was amazingly erect the whole time!");
				if (DickgirlChanged) AddText(" She does not notice that she has a cock again and shows her erect cock regularly, unconsciously stroking it sometimes.");
			}
		}
		if (AppendActText && StandardPlugText) {
			if (SlaveGender > 3) AddText(" The #plugtypes were rather obvious to anyone #slaveheshe showed #slavehisher asses to!");
			else AddText(" The #plugtype was rather obvious to anyone #slaveheshe showed #slavehisher ass to!");
		}
		if (!Supervise) ServantSpeakEnd();
		FirstTimeTodayExpose = false;
		
	} else {
		Refused(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, 0, 0, 0, -1, 0, 0);
	}
}


// Make Up
function DoChoreMakeUp() {
	
	if (VanityCaseOK == 0) {
		ServantSpeak(Language.GetText("MakeUpNoVanityCase" + (IsPonygirl() ? "Pony" : ""), actNode));
		BlankLine();
		ShowDress();
		Bloop();
		return;
	}
	
	FirstTimeToday = FirstTimeTodayMakeUp;
	Backgrounds.ShowBedRoom();
	UseGeneric = false;
	var donearoused:Boolean = SlaveGirl.ShowChoreMakeUp();
	if (SelectActImage()) Generic.ShowChoreMakeUp();

	TotalMakeUp++;
	
	genNumber = donearoused ? 1 : 0;
	if (IsPonygirl()) DoChoreMakeUpPony(donearoused);
	else  DoChoreMakeUpNormal(donearoused);
	
	if (!Supervise) ServantSpeakEnd();
	FirstTimeTodayMakeup = false;
}

function DoChoreMakeUpPony(donearoused:Boolean)
{
	ChangePonyTraining(3);
	if (donearoused == 0) {
		Points(2, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0);
	} else {
		Points(2, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.5, 0);
	}
	XMLData.DoXMLAct("MakeupPony");
}

function DoChoreMakeUpNormal(donearoused:Boolean)
{
	if (donearoused == 0) Points(2, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else Points(2, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);

	XMLData.DoXMLAct("Makeup");
}


// Exercise/Ride
function DoChoreExercise() {
	if (IsPonygirl()) UseGeneric = true;
	FirstTimeToday = FirstTimeTodayExercise;
	Backgrounds.ShowTownCenter();
	
	SlaveGirl.ShowChoreWalk();
	SlaveGirl.ShowChoreExercise();
	if (SelectActImage()) Generic.ShowChoreExercise();
	
	TotalExercise++;
	
	if (IsPonygirl()) ChangePonyTraining(4);
	if (DickgirlChanged) {
		if (StandardDGText) {
			if (IsPonygirl()) {
				SMAvatar.ShowSlaveMaker();
				AddText("In the middle of the way through the ride #slaveheshe got very aroused and tore #slavehisher clothing off. A cock had grown from #slavehisher groin, initially flaccid. As she looked at me it quickly grew erect. She apologised and we quickly came back. In her room she quickly masturbated to a huge orgasm, spewing cum everywhere.");
			} else {
				ServantSpeakStart("Part of the way through the exercise she got very aroused and tore her clothing off. A cock had grown from her groin, initially flaccid. As she looked at me it quickly grew erect. She apologised and we quickly came back. In her room she quickly masturbated to a huge orgasm, spewing cum everywhere.", true);
				if (!SlaveGirl.IsDickgirl()) AddText(" The cock quickly vanished.");
				ServantSpeakEnd();
			}
		}
	} else {
		if (AppendActText) {
			if (IsPonygirl()) {
				Sounds.PlaySound("ClipClop");
				SMAvatar.ShowSlaveMaker();
				if (PonyCartOK) SetText("You harness #slave to #slavehisher cart and have #slavehimher pull you around the city.");
				else SetText("You 'mount' yourself on #slave and have #slavehimher carry you around on #slavehisher back, spanking #slavehimher occasionally to encourage #slavehimher.");
				if (PonyBootsOK) AddText(" #slave's feet make delightful clip, clop noises as #slavehisher boots hit the ground.");
				XMLData.DoXMLAct("ExercisePony");
			} else {
				if (Supervise) AddText("You make #slavehimher exercise, walking, running outside and then training back at home.");
				else ServantSpeakStart(ServantPronoun + " made #slavehimher exercise, walking, running outside and then training back at home.", true);
				if (Aroused && Math.floor(Math.random()*2) == 1) {
					AddText(" While outside #slaveheshe did look lustfully at some ");
					if (SlaveFemale) {
						AddText("handsome men ");
						if (LesbianTraining) AddText("and pretty women ");
					} else if (IsMale()) {
						if (LesbianTraining) AddText("handsome men ");
					}
					AddText("though.");
				}
				if (!Supervise) ServantSpeakEnd();
				XMLData.DoXMLAct("Exercise");
			}
		}
		if (!IsPonygirl() && StandardPlugText && Math.floor(Math.random()*2) == 1) AddText("\r\rDue to #slavehisher anal plug #slaveheshe did not travel as far as usual.");
	}
	if (Supervise) SMData.SMPoints(0, 0, 0, 0.25, 0, 0, 0, 0, 0, 0, 0, 0, 0.5);
	else AssistantData.Points(0, 0, 0, 0, 0, 0.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0);

	Points(0, 1, 0, 0, 0, 1, 0, 0, -2, 0, 0, 0, -1, 0, 0, 0, 2, 1, 0, 0);
	FatigueBonus += StatRate * 1;
	FirstTimeTodayExercise = false;
}


// Read a Book
function DoChoreReadBook()
{
	Backgrounds.ShowBedRoom();
	// Note 19.3 purely SlaveGirl handled
	if (SlaveGirl.ShowChoreReadABook() != true) {
		UseGeneric = !UseImages;
		if (SelectActImage()) Generic.ShowChoreReadABook();
	}
	if (Action == 1019.1) {
		// science
		UpdateFactors();
		if ((MaxIntelligence < 100) && ((VarIntelligence + ((Math.floor(6 * dmod) / 2) * IntelligenceFactor)) > MaxIntelligence)) ChangeMaxStats(0, 0, 0, 3 * IntelligenceFactor);
		PointsByIndex(PersonIndex, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		Points(0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0);
	} else if (Action == 1019.2) {
		// poetry
		if (!Supervise) AssistantData.Points(0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);		
		Points(0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0);
	} else if (Action == 1019.4) {
		if (SMData.SMFaith == 2) {
			Points(0, 0, 0, 20, -5, 0, 0, 0, 0, 0, 0, 0, 0, -10, 0, 0, 0, 0, 0, 0);
		} else {
			Points(0, 0, 0, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, -10, 0, 0, 0, 0, 0, 0);
		}
		if (TotalScripture > 0) TotalScripture--;
		
	} else if (Action == 1019.5) {
		// Kamasutra
		if (MaxFuck < AssistantMaxFuck) ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10);
		if (LesbianTraining) {
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 10, 0, 0, 0, 0, 0);
		} else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 10, 0, 0, 0, 0, 0);
		if (Supervise) SMData.SMPoints(0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 3, 0);
		else AssistantData.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 0, 0, 0, 0, 0);
	} else if (Action == 1019.6) {
		// Ladies Guide
		Points(0, 0, 5, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0);
		if (Supervise) SMData.SMPoints(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0);
		else AssistantData.Points(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
	} else if (Action == 1019.7) {
		// Historical Tales
		Points(0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0);
		if (Supervise) SMData.SMPoints(0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0);
		else AssistantData.Points(0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0);
	} else if (Action == 1019.8 || Action == 1019.9) {
		// Masculine Love
		Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0);
		if (Supervise) SMData.SMPoints(0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0);
		else AssistantData.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0);
	} 
	if (AppendActText) XMLData.DoXMLAct("Read");
}


// Jobs
//=====

// Job - Acolyte
function DoJobAcolyte() {
	
	if (Naked) Language.PersonSpeakLang(24, "MustBeClothed", "Planning");
	else if (IsDressDemonic()) Language.PersonSpeakLang(24, "NoDemons", "Planning");
	else {
		DoJobAcolyte1();
		return;
	}
	Bloop();
	Backgrounds.ShowTemple();
	temp = Math.floor(Math.random()*2) + 2;
	People.ShowPerson(24, 1, temp == 2 ? 1 : 6, temp);
	
	BlankLine();
	Language.AddLangText("AcolyteRefuseWork", "Planning/Acts");
	if (!Supervise) return;
	
	// refused to work as an acolyte
	ResetQuestions(Language.GetHtml("AcolyteRefuseQuestion", "Planning/Acts"));
	AddQuestion(9903, Language.GetHtml("Leave", "Buttons"));
	AddQuestion("AcolyteRefusedBribe", Language.GetHtml("AcolyteRefuseBribe", "Planning/Acts"), _root);
	if (SMData.sNoble > 0) AddQuestion("AcolyteRefusedPosition", Language.GetHtml("AcolyteRefuseInsist", "Planning/Acts"), _root);
	if (SMAdvantages.CheckBitFlag(28)) AddQuestion("AcolyteRefusedMesmerise", Language.GetHtml("AcolyteRefuseMesmerise", "Planning/Acts"), modulesList.eventsSM);
	ShowQuestions();
}

function AcolyteRefusedBribe()
{
	SetText("You offer the nun a donation of 50GP to allow #slave to still work as an acolyte. ");
	if (PercentChance(10 + (SMData.SMConversation / 4))) {
		Money(-50);
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0);
		XMLData.DoXMLAct("AcolyteRefuseBribeAccepted");
		DoEvent("DoJobAcolyte1", _root);
	} else {
		SMData.SMPoints(0, 0, 0, 0, 5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0);
		XMLData.DoXMLAct("AcolyteRefuseBribeDenied");
		ShowPlanningNext();
	}
}

function AcolyteRefusedPosition()
{
	if (PercentChance((SMData.sNoble * 20) + ((SMData.SMConversation + SMData.SMReputation) / 8))) {
		XMLData.DoXMLAct("AcolyteRefusePositionAccepted");
		Money(-50);
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0);
		DoEvent("DoJobAcolyte1", _root);
	} else {
		SMData.SMPoints(0, 0, 0, 0, 5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0);
		XMLData.DoXMLAct("AcolyteRefusePositionDenied");
		ShowPlanningNext();
	}
}
	
function DoJobAcolyte1()
{
	ShowPlanningNext();
	FirstTimeToday = FirstTimeTodayAcolyte;
	Backgrounds.ShowTemple();
	StandardPlugText = (PlugInserted == 1 && Math.floor(Math.random()*4) == 1);
	PayRate = SlaveGirl.ShowJobAcolyte(doplug);
	if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
	if (UseImages) ShowActImage();
	if (IsDressHoly()) PayRate *= 1.1;
	if (IsDressMiko()) PayRate *= 1.05;
	Pay = EarnMoney((5*Math.floor(VarMoralityRounded/5)+Math.floor(VarIntelligenceRounded/5)) * PayRate);
	TotalAcolyte++;

	var cf:Number = currFrame;
	People.ShowPerson(24, 0, temp == 2 ? 0 : 6, temp);
	currFrame = cf;
	if (IsDressHoly()) Points(0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, -2, 0, -1, 0, 2, 0, 0, 0);
	else Points(0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, -2, 0, -1, 0, 2, 0, 0, 0);
	
	if (!Language.IsTextShown()) {
		if (FirstTimeTodayAcolyte && MoonPhaseDate == 1 || MoonPhaseDate == 2) {
			Sounds.PlaySound("Spank");
			DoYesNoEvent(40);			
			XMLData.XMLEvent("ExorcismQuery");
			return;
		}
		DoJobAcolytePart2(1);
	} else DoJobAcolytePart2(0);
}

function DoJobAcolytePart2(std:Number) {

	genNumber = std;
	XMLData.DoXMLAct("Acolyte");
		
	if (NumEvent != 40) {
		if (!BitFlag1.CheckBitFlag(41) && TentaclesOn == 1 && (MoonPhaseDate == 15 || (Elapsed > 8 && Math.floor(Math.random()*5) == 0))) {
			BitFlag1.SetBitFlag(41);
			Tentacles.AcolyteTentacleRaid();
		} else modulesList.AfterJob("Acolyte");
	}
	FirstTimeTodayAcolyte = false;
}


// Job - Bar
function DoJobBar() 
{
	FirstTimeToday = FirstTimeTodayBar;
	Backgrounds.ShowBar();
	Pay = EarnMoney((5*Math.floor(VarConversationRounded/5)+Math.floor(VarIntelligenceRounded/5)));		// base pay
	PayRate = SlaveGirl.ShowJobBar();
	if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
	if (UseImages) ShowActImage();
	Pay = EarnMoney((5*Math.floor(VarConversationRounded/5)+Math.floor(VarIntelligenceRounded/5)) * PayRate);
	TotalBar++;

	if (AppendActText) XMLData.DoXMLAct("Bar");

	Points(0, 0, -1, -1, 0, 0, 1, 1, 2, 0, 0, 1, 0, 0, 0, 0, 4, 0, 0, 0);
	
	modulesList.AfterJob("Bar");
	FirstTimeTodayBar = false;
}


// Job - Brothel
function DoJobBrothel() {
	
	Backgrounds.ShowBedRoom(16);
	if (TestObedience(DifficultyBrothel, 103)) {
		FirstTimeToday = FirstTimeTodayBrothel;
		UseGeneric = false;
		PayRate = SlaveGirl.ShowJobBrothel();
		ChangeCumslut(1);
		if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
		if (SelectActImage()) Generic.ShowJobBrothel();
		
		var tempvar:Number = -2;
		if (VarNymphomaniaRounded>94) tempvar = 1;
		if (PayRate > 1) tempvar = 1;
		if (PlugInserted == 1) PayRate = 1.05 * PayRate;
		if (LingerieOK == 1 || IsDressLingerie()) PayRate *= 1.05;
		if (LesbianTraining) PayRate = PayRate * 0.75;
		if (Day) PayRate = PayRate * 0.75;
		if (Home.HouseType == 8) PayRate = PayRate * 1.1;
		Pay = EarnMoney((10*Math.floor((VarCharismaRounded+VarConstitutionRounded)/10)+Math.floor(VarBlowJobRounded/30)+Math.floor(VarFuckRounded/5)+Math.floor(VarIntelligenceRounded/5)) * PayRate);

		if (TotalBrothel == 1) DifficultyBrothel = DifficultyBrothel-5;
		TotalBrothel++;
		
		if (AppendActText) XMLData.DoXMLAct("Brothel");
		Points(0, tempvar, -2, -1, -3, 2, 0, 0, 0, 0, 1, 2, 3, 2, 0, 0, 8, tempvar, tempvar, 0);
		People.ShowPerson(27, 0, 1);
		modulesList.AfterJob("Brothel");
		FirstTimeTodayBrothel = false;
	} else {
		Refused(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -10, 0, 0, 0, -3, -20, 0);
	}
}


// Job - Cock Milking
function DoJobCockMilking()
{
	FirstTimeToday = FirstTimeTodayCockMilking;
	People.ShowPerson(16, 1, -3, 1);
	PayRate = SlaveGirl.ShowJobCockMilking();
	if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
	if (SelectActImage()) Generic.ShowJobCockMilking();
	
	TotalCockMilk++;
	SMData.TotalSMJob++;
	
	//SMData.SMPoints(0, 0, 0, 1, 0, -10, 0, 0, -1, 0, 0, 2, 3);
	//Pay2 = int(0.1 * (SMConstitution + SMLust));
	//Pay = PayRate * int(0.3 * (VarConstitutionRounded + VarLibidoRounded));
	//Pay = EarnMoney(Pay);
	//Pay2 = SMEarnMoney(Pay2);
	XMLData.DoXMLAct("CockMilking");
	
	modulesList.AfterJob("CockMilking");
	FirstTimeTodayCockMilking = true;
}


// Job - Library
function DoJobLibrary() {
	FirstTimeToday = FirstTimeTodayLibrary;
	Backgrounds.ShowLibrary();
	
	if (TotalLibrary == 0) XMLData.DoXMLAct("LibraryIntroduction");
	
	PayRate = SlaveGirl.ShowJobLibrary();
	if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
	SelectActImage();
	
	if (Naked) PayRate *= 0.75;
	Pay = EarnMoney((4*Math.floor(VarConstitutionRounded/5)+Math.floor(VarIntelligenceRounded/5)) * PayRate);
	TotalLibrary++;
	EventTotal = TotalLibrary;
	
	XMLData.DoXMLAct("Library");

	if (Naked && FirstTimeTodayLibrary) {
		if (Aroused) Points(0, -1, 0, 2, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0);
		else Points(0, -1, 0, 2, 0, 1, 0, 1, 0, 0, 0, 0, -1, 0, -2, 0, 2, 0, 0, 0);
	} else {
		if (Aroused) Points(0, -1, 0, 2, 0, 1, 0, 1, -1, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0);
		else Points(0, -1, 0, 2, 0, 1, 0, 1, -1, 0, 0, 0, -1, 0, -2, 0, 2, 0, 0, 0);
	}

	if (AppendActText) {
		if (Naked) {
			var Librarian:Person = People.GetPersonsObject("Librarian");
			Librarian.ShowThem(0, 0, 1);
			Backgrounds.ShowLibrary(Math.floor(Math.random()*2) + 5);
			if (FirstTimeTodayLibrary) {
				var estr:String = Librarian.GetNextEvent();
				AddText("#personlibrarian looks dispassionately at #slave's naked body and leads #slavehimher into a private room. She hands #slave a book and tells #slavehimher,\r\r");
				PersonSpeak("#personlibrarian", "This work has recently returned from repairs. Please read it to me so I can check if it is accurate and complete. Please read it with care and consideration, the reactions of the reader are also important.", true);
				AddText("\r\r" + SlaveName + NonPlural(" read") + " the story out loud to #personlibrarian,\r");
				ReadStory();
				BlankLine();
				switch(estr) {
					case "Event1-1":
						LastActionDone += 0.1;
						AddText("#personlibrarian calmly observes #slave during the reading, and then takes back the book and says,\r\r");
						if (VarNymphomania < 30) PersonSpeak(13, "That will do for today, you did not put enough feeling into that reading. You need to feel for the protagonist. Try again another time when you can feel for them better.", true);
						else {
							PersonSpeak(13, "You read that well, I could see how much you felt for the protagonist. Next time we will try something more advanced.", true);
							Librarian.MoveToNextEvent(1);
						}
						break;
					case "Event2-2":
						LastActionDone += 0.2;
						AddText("#personlibrarian sits behind her desk and watches #slave during the reading, her hands below the desk. When #slave finishes, the librarian softly sighs and says,\r\r");
						PersonSpeak(13, "I can see you felt for the protagonist. Please relieve those feelings.", true);
						if (VarNymphomania < 50 && VarIntelligence < 50) {
							if (HasCock) AddText("\r\r#slave eagerly strokes " + SlaveHisHer + Plural(" cock") + " and quickly " + NonPlural("cry") + " out and " + NonPlural("cum") + ", jet of cum splattering over the papers on the desk.\r\rThe librarian looks disappointed\r\r");
							else AddText("\r\r#slave eagerly " + NonPlural("rub") + " #slavehisher " + Plural("pussy") + " and quickly " + NonPlural("cry") + " out and small sprays of pussy-juice splatter over the papers on the desk.\r\rThe librarian looks disappointed\r\r");
							PersonSpeak(13, "Please use your common-sense, do not dirty books!", true)
						} else {
							if (HasCock) AddText("\r\r#slave eagerly strokes " + SlaveHisHer + Plural(" cock") + " and quickly " + NonPlural("cry") + " out and " + NonPlural("cum") + ", turning so jets of cum splatter over the wall.\r\rThe librarian smiles,\r\r");
							else AddText("\r\r#slave eagerly " + NonPlural("rub") + " #slavehisher " + Plural("pussy") + " and quickly " + NonPlural("cry") + " out, turning as small sprays of pussy-juice splatter over the wall.\r\rThe librarian smiles,\r\r");
							PersonSpeak(13, "Please clean the wall. Next time we will try something more advanced.", true)
							Librarian.MoveToNextEvent(2);
						}
						break;
					case "Event3-3": 
						LastActionDone += 0.3;
						AddText("As " + SlaveName + NonPlural(" read") + ", the librarian quietly orders #slave to focus on the book. " + SlaveHeSheUC + NonPlural(" read") + " the story and then feels");
						if (HasCock) {
							if (SlaveGender > 3) AddText(" lips and hands on their cocks licking, kissing, alternating between them. The hands start stroking both cocks, and a tongue licks and sucks the head of their cocks. The lips and hands move quickly and as the story reaches it's climax, so " + NonPlural("does") + " #slave their cum pulsing into the persons mouth.\r\r");
							else AddText(" lips on " + SlaveHisHer + Plural(" cock") + " licking, kissing and then hands stroking. The lips and hands move quickly and as the story reaches it's climax, so " + NonPlural("does") + " #slave #slavehisher cum pulsing into the person's mouth.\r\r");
						} else {
							if (SlaveGender > 3) AddText(" lips and fingers touching their pussies, licking and kissing, alternating between them. The hands finger both pussies, and a tongue licks and sucks their clits. The lips and hands move quickly and as the story reaches it's climax, so " + NonPlural("does") + " #slave, orgasming strongly.\r\r");
							else AddText(" lips and fingers touching her pussy, licking expertly. The hand fingers her pussy and a mouth licks and sucks her clit. The lips and hands move quickly and as the story reaches it's climax, so " + NonPlural("does") + " #slave, orgasming strongly.\r\r");
							PersonSpeak(13, "It is best to read truly feeling for the protagonist.", true)
						}
						break;
				}
				BlankLine();
				PersonSpeak(13, "Thank you for your assistance, here is your pay: #paygp", true);

			} else {
				AddText("#personlibrarian gives #slave some reading material from her private library to study for later readings. The works are all tales of passion and above all sex, covering all forms of sexuality. The librarian every so often encourages #slave to 'feel' for the protagonists.\r\rLater " + SlaveIs + " very, very aroused.\r\r");
				PersonSpeak(13, "I trust you enjoyed your study material, here is your pay: #paygp", true);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0);
			}

		}
	}
	
	modulesList.AfterJob("Library");
	FirstTimeTodayLibrary = false;
}

function ReadStory(story:Number)
{
	if (story == 0 || story == undefined) story = Math.floor(Math.random()*15);
	switch(story) {
		case 0: 
			SlaveSpeak("...the noble lady waited nervously, her servant saw her with her lover while her husband was at Court!\r\rThe door opens and the servant walks in,\r\"My lady, I have spoken with the other staff, and we have an agreement. Tonight at the party we shall serve you many drinks, that you will eagerly accept.\"\r\rWith these words he opens the front of his trousers and his erect cock sticks proudly out. He steps forward placing it to her lips with the word \"Drink\". She opens her mouth with a soft moan and...", true);
			break;
		case 1:
			if (IsDickgirlEvent()) SlaveSpeak("...the lady is lying in darkness, seeing only vague shapes. Where are her servants? The last thing she remembers is her carriage sharply moving, then darkness.\r\rShe hear the beating of leathery wing and then a person pressing and lying on top of her, their skin hot. She realise she is naked and she can feel the large breasts of the person, her hot skin and her large erect cock pressing between them. The person kisses the lady fiercely as she thrust her cock deeply into the ladies pussy. The figure gasps and fucks the lady powerfully, her cock pounding deeply over and over. The lady cries out and orgasms, and she hears a laugh of triumph and the figure thrusts in a last time her cock pulsing as cum pours into the ladies womb.\r\rThe figure pulls away, saying,\r\r\"Tonight I have been given a gift, the gift of potency, my dear mother to be of my children...", true);
			else SlaveSpeak("...the lady is lying in darkness, seeing only vague shapes. Where are her servants? The last thing she remembers is her carriage sharply moving, then darkness.\r\rShe hear the beating of leathery wing and then a person pressing and lying on top of her, their skin hot. She realise she is naked and she can feel the muscled torso, his hot skin and his large erect cock pressing between them. The person kisses the lady fiercely as he thrust his cock deeply into the ladies pussy. The figure gasps and fucks the lady powerfully, his cock pounding deeply over and over. The lady cries out and orgasms, and she hears a laugh of triumph and the figure thrusts in a last time his cock pulsing as cum pours into the ladies womb.\r\rThe figure pulls away, saying,\r\r\"Tonight I have been given a gift, the gift of potency, my dear mother to be of my children...", true);
			break;
		case 2:
			SlaveSpeak("...darkness swirls about her, she feels hands tugging at her clothing. Piece after piece fall or a pulled free, until she stands on the rocks in darkness, starlight her only illumination.\r\rThe darkness pushes upon her and she is lying on her back and she sees a shape, a large cylinder of darkness moving toward her pussy...", true);
			break;
		case 3:
			SlaveSpeak("...the shapes coil about her, a large shape pounding into her pussy, a smaller one slowing sliding into her ass. The shape in her mouth pulses and cum floods her mouth and she drinks it eagerly...", true);
			break;
		case 4:
			SlaveSpeak("...he sneaks into his lovers bedroom, dimly lit by the crescent moon. She lies beneath a light sheet, breathing deeply in her sleep. A cloud passes before the moon leaving the room very dark.\r\rBy long experience he moves to the bed, removing the sheet and lightly caressing her. She moans softly, awakening and he feels her touching him. He lightly kisses her neck and he feels her gently push his head toward her breasts. He lick and sucks on her nipples until she moves and rolls over , lifting her hips, presenting herself. He understands and gently enters her, slowly fucking, while caressing her breasts and rubbing her clit. He thrusts faster and feels her shudder through her orgasm. He moans and cums, spurting into her womb.\r\rShe rolls over and the cloud passes and he can see clearly, it is his lover's sister, lying there smiling...", true);
			break;
		case 5:
			SlaveSpeak("...running frantically, she pushes through the trees. Night is falling and she is running from her Master's servants, running deeper and deeper into the forest.\r\rShe hears an odd skittering noise and turns and stumbles into a large mass of sticky threads. She struggles to pull free but the strands just wrap around her binding her in their coils. She hears the skittering noise and sees a large shape with many, hairy limbs. The shape sprays masses of the silk over her until she can barely see or breath. She feels a ripping and her lower clothes are torn away. A large, large, slick cock slides into her pussy, and slowly fucks her. She feels some pain due to it's great size, but that passes and is replaced by a growing pleasure. The cock fucks faster and faster, and then thrusts in and cums, pumping it's seed into her womb. She cries out in orgasm and faints...", true);
			break;
		case 6:
			SlaveSpeak("...her new Master says something, but she can barely understand him. She speaks little of his language and could only make out something about 'make stronger'. He and his assistants grab her and expertly bind her, tying her arms behind her back, and ropes about her breasts, emphasising them. Her legs are bound in a frog-tie, spread but bound shin to thigh. She screams and a ball-gag is put into her mouth, then an assistant raises her and another places a plug into her ass.\r\rShe groans and watches as an assistant passes an ornate box to her Master. He removes a softly glowing object, large and cock-shaped. He whispers something to it and she hears a humming noise and can see droplets of fine oil forming on it's surface. The assistant holds her and spreads her pussy lips and her Master slides the slick dildo into place, and then ties it in place somehow.\r\rShe moans as the dildo hums and vibrates, her passion irresistibly building. The humming changes and she lets out a muffled cry as she orgasms and can feel spurts of something erupt from the dildo. Her Master smiles and says some words and the humming strengthens and the dildo seems to pulse a little.\r\rAs she cries out her second orgasm, her Master and his assistants leave with words like 'exercise' and 'orgasm' and 'hours'...", true);
			break;
		case 7:
			SlaveSpeak("...her fingers are moving quickly both in her pussy and on her clit. Through the crack in the door they are passionately, joyously grinding their hips and pussies together. Pinching their own nipples and rubbing their breasts they are gasping and flushed, near to their peak. She can feel her own orgasm very near but she is trying to hold back and wait for them. The dark-haired one starts moaning loudly. Watching through the door, she puts a hand to her mouth as she cannot stop herself, the shuddering, wonderful orgasm washes over her. She sits as she hears cries of passion from the other room...", true);
			break;
		case 8:
			if (IsDickgirlEvent()) SlaveSpeak("...she is thrusting her cock quickly into her fellow maid's pussy. Her Master was watching, his slave girl slowly licking his cock. She cries out as her cock explodes and she cums, blasts of her cum filling the other maid's womb. She gasps, almost falling backward, her cock wetly pulling free. Her Master tells her 'Please, fuck Dana now, remember to honour the Gods and cum deeply in her pussy'\r\rShe realises now that she is no maid, her Master just wants her for sex, for her to fuck others while he watches...", true);
			else SlaveSpeak("...she is fucking her strap-on quickly into her fellow maid's pussy. Her Master was watching, his slave girl slowly licking his cock. She cries out as she orgasms from the dildo in her pussy. Her fellow maid cries out and orgasms moments later. As she is sighing, her orgasm passing, her Master tells her 'Please, fuck Dana now'\r\rShe realises now that she is no maid, her Master just wants her for sex, for her to fuck or lick others while he watches...", true);
			break;
		case 9:
			SlaveSpeak("...the ambassador watched, a little embarrassed, as the slave girl slowly licks the cock of his host. She looks so content and happy that he wonders why slavery is outlawed in his country. His host groans as his cum splatters over the slave girl's face and then she thanks him! His host then says 'So shall we discuss business now...", true);
			break;
		case 10:
			SlaveSpeak("...the Lady stands there wearing only her jewelry, unable to see anything due to the leather hood on her head, blinding her and locked in place to make sure she is not tempted to remove it. A hand, female?, lightly caresses her bottom, and another lightly touches her breasts. Lips press against her, passionately kissing her, definitely a woman, her breasts pushing against the Ladies. A hand lightly touches her pussy and another woman's lips kiss her, and the Lady tastes a liquid flowing into her mouth from the others. They both swallow as they kiss, and the Lady feels a warm rush of arousal. Hands gently lay her down and the lips continue kissing her. More lips and tongues lick and bite her nipples while the hands caress her body and touch her pussy. Her legs are moved apart and a person thrusts his cock into her wet and willing pussy. The woman kissing her moans, moving rhythmically as if she is being fucked too. The Lady gasps loudly as she has her first orgasm, moments later the man thrusts in deeply and cums powerfully into the Ladies womb. He pulls free and a moment later another man thrusts his cock into the Lady. The woman kissing her breaks the kiss, moaning and orgasming. As she does a cock is placed to the Ladies lips, she licks and it spasms, cum flooding into her mouth. The cock is removed and the woman resumes kissing the Lady, eagerly after her share of the cum...", true); 
			break;
		case 11:
			SlaveSpeakStart("...the couple reaches the ancient tree, said to be touched by the gods, but that is not why they came here. It is private and comfortable with few visitors. The man tenderly kisses his lover, slowly running his hands over her, making it clear what and who he desires. She pulls free, objecting to this, talking about the gods, and that she does not wish to be a mother yet. He talks and whispers and convinces her and they slowly start to make love.\r\rA bright light illuminates them and an angelic woman appears, smiling, 'Do not fear, I will bless your union, despite your intention to disobey the gods'. The man collapses unable to move, his cock expose and erect. The angel floats down, her mouth enveloping his cock, he feels unworldly pleasurable. The man cannot believe the sensation and almost immediately cums crying out as powerful jets of cum spurt into the angel's mouth. He gasps and passes out from the sheer pleasure. The angel swallows all the man's cum and then stands looking at the woman who sees ", true);
			if (IsDickgirlEvent()) AddText("a large, beautiful and thick cock swell and grow from the angel's groin. The angel explains 'I have blessed his seed and will guarantee it's potency.' With that she embraces the woman and kisses her sweetly. The woman cries out with pleasure and the angel thrusts her cock in, the feeling exquisite, nothing like she has ever felt before. The angel makes love to the woman, fucking her with unnatural skill and passion. The woman orgasms over and over at the feeling of the impossibly wonderful cock. Finally the angel thrusts faster and holds the woman closer and shouts her joy as she cums impossibly strong jets of cum deep into the woman's womb.");
			else AddText("a large golden strap-on now fitted to the angel's groin. The angel explains 'I have blessed his seed and will guarantee it's potency.' With that she embraces the woman and kisses her sweetly. The woman cries out with pleasure and the angel thrusts her strap-on in, the feeling exquisite, nothing like she has ever felt before. The angel makes love to the woman, fucking her with unnatural skill and passion. The woman orgasms over and over at the feeling of the impossibly wonderful strap-on. Finally the angel thrusts faster and holds the woman closer and shouts her joy as she orgasms, the woman feels the strap-on pulse and impossibly strong jets of cum spurt deep into her womb. The angel pulls free, cum dripping from her pussy 'Tell him he will have two children...'");
			SlaveSpeakEnd("\r\rThe woman lies gasping, cum filling her womb, knowing she will never be satisfied like this again...");
			break;
		case 12:
			SlaveSpeak("...she is weakly swimming, her strength fading. As she slips beneath the waters she thinks that she should have never taken that bet.\r\rSomething holds her from below and pushes her to the surface. She coughs, gasping for breath, and she feels herself pushed toward shore. Looking down she can see nothing else in the water, but with a start she can see she seems to have lost her swimsuit. A wave washes and she is lying on a small, steep beach still mostly submerged, but safe. She starts to get up and feels firm hands holding her gently in the water. She more feels a thought or idea 'payment' but she can also feel if she really wants she can leave. She is a bit confused but relaxes and feels the hands loosen and then they move all over lightly caressing her breasts, her pussy and ass. She feels something like tongues licking her nipples and then ones licking her clit and even her asshole. Still she can see nothing in the water so she lays back enjoying the sensations. A hard object pushes against her pussy and the hard cock of water pushes into her. It is a bit cold but the hands and tongues continue licking. The cock fucks her, feeling cold and hard but still very good. She cries out, orgasming from all the sensations and she feels spurts of cold fluid as the cock cums into her. The cock softens and the hands and tongues withdraw and she feels sorry it is over. Immediately the tongues and hands resume and the cock, or another, thrusts into her. The tongue at her ass stops and then she feels a hard cock push into her ass.\r\rA long time later she is lying exhausted, sore and remembering her many orgasms. She hears voices, her friends have found her! They ask about how tiring the swim was for her and why she is smiling...", true);
			break;
		case 13:
			SlaveSpeak("...'Master, the gift has been delivered'. The slave girl is pushed to her knees, looks angry and defiant. She is gagged with a large ball-gag, her nipples painfully clamped, and a large phallus fills her ass. 'A defiant one, just how I like. Tie her to the wall and fetch me whip' The woman looks fearful but her pussy is dripping with her excitement...", true);
			break;
		case 14:
			SlaveSpeakStart("...waking from his sleep he feels very aroused. Sleepily he looks down and sees his covers are pulled aside and woman is licking his cock. In the darkness he cannot clearly see her and starts to speak. She looks up and holds a finger to her mouth in a silencing gesture. She moves up, he can see she is naked but little more, and she impales herself on his cock. He groans, quite awake now as this woman bounces and fucks herself on his cock, her hand rubbing her breasts and clit. She fucks faster and he groans, shooting spurts of cum into her. She shudders quietly as she orgasms. Moments later she leaps off him and leaves the room. As she leaves he sees her a bit more clearly and she seems somewhat familiar, but ", true);
			if (IncestOn) SlaveSpeakEnd("there is no-one else in the house, except his younger sister...");
			else SlaveSpeakEnd("there is no-one else in the house...");
			break;
	}
}


// Job - Onsen
function DoJobOnsen() {
	FirstTimeToday = FirstTimeTodayOnsen;
	Backgrounds.ShowOnsen();
	
	if (TotalOnsen == 0) XMLData.DoXMLAct("OnsenIntroduction");
	
	var wash:Boolean = (Math.floor(Math.random()*200) < (VarReputation + VarCharisma + 25));
	var wgender:Number = (Math.floor(Math.random()*4) < 3) ? 2 : 1;
	if (IsDickgirlEvent()) wgender = 3;
	PersonGender = wgender;
	PayRate = SlaveGirl.ShowJobOnsen(wash ? 0 : wgender);
	if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
	if (SelectActImage()) Generic.ShowJobOnsen(wgender);
	genNumber = wash ? 1 : 0;
	XMLData.DoXMLAct("Onsen");
	TotalOnsen++;

	People.ShowPerson(41, 0, 0, 1);
	if (wash) Points(0, 2, -2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0);
	else Points(0, 1, -2, 0, 0, 2, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0);

	ResetEventPicked();
	if (FirstTimeTodayOnsen && wash) NumEvent = 38 + (wgender / 10);

	if (!modulesList.AfterJob("Onsen")) {
		if (NumEvent != 0) {
			if (AppendActText) {
				var agree:String;
				if (PersonGender == 2) {
					AddText("The female customer sighs and leans back slightly spreading her legs. She tells #slave, somewhat imperiously, to now thoroughly 'clean' her pussy...");
					agree = "Does #slave agree to sexually clean the woman?";
				} else if (PersonGender == 3) {
					AddText("The woman turns and thanks #slave who can now clearly see that she is a hermaphrodite and her cock is quite large and erect. The woman asks #slave to help lather soap onto her cock...");
					agree = "Does #slave agree to sexually clean the woman?";
				} else {
					AddText("The male customer turns and thanks #slave, ");
					switch(slrandom(3)) {
						case 1: AddText("the towel around his waist tented by his erect cock. He removes the towel, saying that he now needs his cock thoroughly cleaned..."); break;
						case 2: AddText("the towel parted at the front and he is holding his rather erect cock. He says that his cock needs some careful attention now..."); break;
						case 3: AddText("removing his towel, his cock slowly swelling erect. He asks #slave to help attend to another matter.."); break;
					}
					agree = "Does #slave agree to sexually clean the man?";
				}
				if (NumEvent == 38.1 || NumEvent == 38.2 || NumEvent == 38.3) {
					if (!TestObedience(DifficultyExhib)) {
						AddText("\r\r" + SlaveVerb("blush") + " at the request and " + NonPlural("refuse") + " at doing that in this public place. The customer looks surprised and even a little offended.\r\r#persononsenowner, who owns the Onsen speaks to #slave and politely scolds #slavehimher for refusing the customer, and how impolite it was.\r\rShe asks #slave to leave and gives #slavehimher a token 10GP for payment.");
						Money(10);	
						FirstTimeTodayOnsen = false;
						return;
					} 
					AddText("\r\r" + agree + "\r");
				} 
			}
			DoYesNoEventXY(NumEvent);
			FirstTimeTodayOnsen = false;
			return;
		}
	}
	
	Pay = EarnMoney((3*(Math.floor(VarConstitutionRounded/5)+Math.floor(VarCharismaRounded/5)+Math.floor(VarCleaningRounded/5))) * PayRate);
	
	XMLData.DoXMLAct("OnsenCommonEnd");

	FirstTimeTodayOnsen = false;
}


function JobOnsenService()
{
	HideAllPeople();
	HideSlaveActions();
	HideImages();
	Backgrounds.ShowOnsen();
	
	UseGeneric = false;
	if (PersonGender != 2) ChangeCumslut(1);
	if (SlaveGirl.ShowJobOnsenService(PersonGender) != true) {
		if (slaveData.SelectActImage(false, 10030, undefined, undefined, undefined, true)) Generic.ShowJobOnsenService(PersonGender);
	}
	TotalOnsenService++;

	Pay = EarnMoney((3*(Math.floor(VarConstitutionRounded/5)+Math.floor(VarCharismaRounded/5)+Math.floor(VarCleaningRounded/5))) * PayRate) + (VarBlowJobRounded / 4);

	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0);

	XMLData.DoXMLAct("OnsenService");
}


// Job - Restaurant
// 1012.1 - Waiter/Waitress
// 1012.2 - Chef

function DoJobRestaurant() {
	
	FirstTimeToday = FirstTimeTodayRestaurant;
	Backgrounds.ShowRestaurant();
	
	PayRate = SlaveGirl.ShowJobRestaurant();
	if (PayRate == undefined) { PayRate = 1; UseGeneric = !UseImages; }
	if (SelectActImage()) Generic.ShowJobRestaurant();
	
	TotalRestaurant++;
	
	if (!BitFlag1.CheckBitFlag(33) && VarCookingRounded > 70) {
		BitFlag1.SetBitFlag(33);
		BitFlag1.SetBitFlag(31);
	 	XMLData.DoXMLAct("RestaurantOfferChef");
		return;
	}
	if (Action == 1012.1) DoJobRestaurantWaitress();
	else DoJobRestaurantChef();
	
	People.ShowPerson(28, 0, 1);
	
	modulesList.AfterJob("Restaurant");
	FirstTimeTodayRestaurant = false;
}

function DoJobRestaurantChef()
{
	Pay = EarnMoney((3*Math.floor(VarCookingRounded/4)+Math.floor(VarIntelligenceRounded/4)) * PayRate);
	if (MaidUniformOK == 1 || IsDressMaid()) Pay += 5;
	Points(0, 0, 0.5, 0, 0, 0, 4, 0.5, 0, 0, 0, 0, 0, 0, 0, 0.5, 2, 0, 0, 0);
	XMLData.DoXMLAct("RestaurantChef");
}

function DoJobRestaurantWaitress()
{
	if (!BitFlag1.CheckBitFlag(31)) {
		BitFlag1.SetBitFlag(31);
		XMLData.DoXMLAct("RestaurantIntroduction");
	}
	XMLData.DoXMLAct("RestaurantServing");
	Pay = Math.ceil((3*Math.floor(VarConversationRounded/5)+Math.floor(VarCharismaRounded/5)) * PayRate);
	if (MaidUniformOK == 1 || IsDressMaid()) Pay += 5;
	if (IsDressWaitress()) Pay += 5;
	Pay = EarnMoney(Pay);
	Points(0, 0, -1, 0, 0, 1, IsDressWaitress() ? 1.5 : 1, IsDressWaitress() ? 1 : 0.5, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0);
	if (AppendActText) {
		AddText("At the end of #slavehisher shift, the restaurant owner talks to #slave,\r\r");
		PersonSpeakStart("Restaurant Owner", "Good job as ", true);
		if (SlaveGender > 3) {
			if (SlaveGender == 4) AddText("waiters");
			else if (SlaveGender == 5) AddText("waitresses");
		} else {
			if (SlaveGender == 1) AddText("a waiter");
			else AddText("a waitress");
		}
		AddText(", here is your pay and tips : #paygp", true);
		if (SlaveFemale && Aroused) {
			temp = Math.floor(Math.random()*4);
			if (temp == 1) {
				if (Naked) AddText("\r\rDo you really think it is appropriate to rest your breasts on the customers shoulders as you take orders?");
				else AddText("\r\rYour dress is a little too short, I think all the customers saw your panties today.");
			}
			if (temp == 2) AddText("\r\rOnce or twice I saw you sit on the lap of a customer to take their order. I am sure the customer was happy but in the future please do not do this.");
		}
		if (StandardPlugText && Math.floor(Math.random()*4) == 1) AddText("\r\rYour work was a little slow today, you moved awkwardly, if there is anything limiting your movement please do not wear it in future.");
		PersonSpeakEnd();
	}
}


// Job - Sleazy Bar
function DoJobSleazyBar() {
	
	FirstTimeToday = FirstTimeTodaySleazyBar;
	Backgrounds.ShowBar();
	var dgowner:Boolean = IsDickgirlEvent();
	SleazyBarOwner.SetMet();
	People.ShowPerson(26, 0, 1, dgowner ? 2 : 1);
	
	if (TestObedience(DifficultySleazyBar, 102)) {
		if (BunnySuitOK == 0 && LingerieOK == 0 && (!IsDressSleazyBar()) && (!IsDressLingerie()) && (!IsCatgirl())) {
			Language.PersonSpeakLang(26, "SleazyBarNeedUniform", actNode);
			if (!TestObedience(DifficultyExhib, 122)) {
				BlankLine();
				LastActionDone = 1015.2;
				XMLData.DoXMLAct("SleazyBarStripTeaseWillNotDo");
				if (LastActionDone == 1015.2) return
			}
			if (SlaveGirl.AskSleazyBarStripTease() != true)	DoYesNoEvent(32);
			return;
		}
		WorkInSleazyBar(false);
		
	} else {
		Refused(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, 0, 0, 0, -2, -10, 0);
	}
}


function WorkInSleazyBarStripTease()
{
	if (Slutiness > 5 || VarObedienceRounded>69) AddText("#slave enthusiastically " + NonPlural("agree") + " to do the strip-tease.");
	else AddText(SlaveName + NonPlural(" agree") + " a little reluctantly to do the strip-tease.");
	BlankLine();
	LastActionDone = 1015.1;
	AddText("At the start of #slavehisher shift, the bar owner introduces #slavehimher, and ");
	if (IsDickgirl() || !SlaveFemale) {
		if (!SlaveFemale) AddText("then escorts #slavehimher to a private room, which quickly fills with mostly women and a few men. ");
		else AddText("then escorts #slavehimher to a private room, which quickly fills with a mixture of men and women. ");
		if (SlaveGender > 3) AddText("\r\rThey do a slow, sexy strip-tease, removing piece after piece of clothing, but keeping their cocks obscured. Finally they drop their last piece of clothing and stand, arm in arm before the audience, cocks proudly erect");
		else AddText("\r\r#Slaveheshe does a slow, sexy strip-tease, removing piece after piece of #slavehisher clothing, but keeping #slavehisher cock obscured. Finally " + SlaveVerb("drop") + " #slavehisher last piece and stands before the audience, #slavehisher cock proudly erect");
	} else if (SlaveFemale) {
		if (SlaveGender > 3) AddText("they do a slow, sexy strip-tease, removing piece after piece of clothing, sometimes their own, sometimes from her partner. They both remove their last piece of clothing, letting it drop at the same time.");
		else AddText(SlaveHeShe + " does a slow, sexy strip-tease, removing piece after piece of her clothing, until she is completely naked.");
	}
	if (VarConstitution > 80 && VarCharisma > 80) AddText("\r\rThere is loud, enthusiastic applause after, with many suggestive calls.");
	else if (VarConstitution > 50 || VarCharisma > 50) AddText("\r\rThe customers clap and whistle after, with a few suggestive calls.");
	else AddText("\r\rThere is a smattering of applause after #slavehisher performance.");
	AddText(" The rest of #slavehisher time in the bar " + SlaveHeSheIs + " completely naked.\r\r");
	UpdateSexActLevels(24);
	
	XMLData.DoXMLAct("SleazyBarStripTease");
	
	WorkInSleazyBar(true);
}

function WorkInSleazyBar(strip:Boolean) {
	PayRate = SlaveGirl.ShowJobSleazyBar(strip);
	if (UseImages) {
		ShowActImage();
		if (UseGeneric && strip) ShowActImage(24);
		if (UseGeneric && LingerieOK == 1) ShowActImage(10013);
		if (UseGeneric && BunnySuitOK == 1) ShowActImage(10017);
	} 
	if (!strip) DoXMLAct("SleazyBar");
	if (DemonicBraOK == 1) PayRate = PayRate * 1.1;
	if (IsDressSleazyBar()) PayRate = PayRate * 1.1;
	if (LesbianTraining) PayRate = PayRate * 0.75;
	if (BunnySuitOK == 1) PayRate = PayRate * 1.15;
	else if (LingerieOK == 1 || IsDressLingerie()) PayRate *= 1.05;
	if (Day) PayRate = PayRate * 0.75;
	Pay = (9*Math.floor((VarCharismaRounded+VarConversationRounded)/10)+Math.floor(VarBlowJobRounded/10)+Math.floor(VarIntelligenceRounded/5));
	if (OldLover == 1) Pay += 20;
	if (strip) Pay += 10;
	Pay = EarnMoney(Pay * PayRate);

	if (strip) TotalStripTease++;
	TotalSleazyBar++;
	if (TotalSleazyBar == 1) {
		DifficultySleazyBar = DifficultySleazyBar-5;
		DifficultyExhib = DifficultyExhib-2;
	}
	PersonSpeakEnd(" Here is your pay and tips : #paygp");

	Points(2, -2, 0, -2, -2, 1, 0, 0, 2, 0, 0, 1, 2, 1, 1, 0, 6, 0, 0, 0);
	if (PayRate == 1) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0);

	temp = 0;
	if (!modulesList.AfterJob("SleazyBar")) {
		if (FirstTimeTodaySleazyBar) {
			if (temp != -1) temp = 5;
			if (OldLover > 0) {
				AddText("\r\r" + NameCase(SlaveHisHer) + " older lover cheers #slavehimher on, and then pays for a private 'performance'");
				temp = -1;
			} else if (temp != -1) {
				if (IsCatgirl() || Naked || strip) temp = 2;
				else if (VarNymphomaniaRounded > 79 || Slutiness > 5) temp = 0;
			}
			if (temp == -1 || Math.floor(Math.random()*temp) == 0) {
				if (temp == 0 || temp == -1) {
					NumEvent = LesbianTraining ? 33.1 : 33;
					if (temp == 0) {
						if (LesbianTraining) AddText("\r\r" + SlaveSee + " an attractive female client and offers a 'private' performance to customer, an intimate performance...");
						else if (IsDickgirlEvent()) {
							NumEvent = 33.2;
							AddText("\r\r" + SlaveSee + " an attractive female client and offers a 'private' performance to customer, an intimate performance...");
						} else AddText("\r\r" + SlaveSee + " an attractive male client and offers a 'private' performance to customer, an intimate performance...");
					} 
					DoEvent();
				} else {
					var ftype:Boolean = SlaveFemale ? Math.floor(Math.random()*4) < 3 : Math.floor(Math.random()*4) == 1;
					NumEvent = ftype ? 33.1 : 33;
					if (IsDickgirlEvent()) NumEvent = 33.2;
					if (SlaveGender > 3) {
						if (NumEvent == 33) AddText("\r\rA male customer requests a 'private' performance. #slave are sure this is an intimate performance...\r\rDo #slaveheshe 'perform'?\r");
						else AddText("\r\rA female customer requests a 'private' performance. #slave are sure this is an intimate performance...\r\rDo #slaveheshe 'perform'?\r");
					} else {
						if (NumEvent == 33) AddText("\r\rA male customer requests a 'private' performance. #slave is sure this is an intimate performance...\r\rDoes #slaveheshe 'perform'?\r");
						else AddText("\r\rA female customer requests a 'private' performance. #slave is sure this is an intimate performance...\r\rDoes #slaveheshe 'perform'?\r");
					}
					DoYesNoEventXY();
				}
			} else Catgirls.AfterJobSleazyBar(Pay);
		}
	}
	FirstTimeTodaySleazyBar = false;
}


function JobSleazyBarService(eventno:Number) {
	
	var female:Boolean = (eventno != 33);
	PersonGender = Math.ceil(10 * (eventno - 33));
	HideSlaveActions();
	HideImages();
	Backgrounds.ShowBar();
	if (OldLover > 0) {
		HideAllPeople();
		People.ShowPerson(1000, 0, 2, OldLover);
	} else {
		if (Slutiness > 0 && VarMoralityRounded<26) {
			if (RulesFuck == 1 || Slutiness > 5) temp = Math.floor(Math.random()*3);
			else temp = Math.floor(Math.random()*5);
			if (temp == 1) {
				if (female) OldLover = 2;
				else OldLover = 1;
				People.ShowPerson(1000, 1, 2);
				if (OldLover == 2) {
					SetText("The customer is seated at a table looking a bit distracted. As #slave steps over #slaveheshe can see two maids kneeling, licking the woman's pussy. She talks excitedly to #slave and suggests a similar position is open, for such pretty " + Plural(SlaveBoyGirl) + " as #slave.\r\rShe gasps softly and orgasms, all the time looking at #slave. She offers money and other pretty things to be her little toy. The maids meanwhile have continued licking.\r\r#slave readily " + Plural("accept") + " and the woman has #slavehimher kneel down. One maid sits next to the Lady kissing her passionately as #slave seals the 'oral' contract.");
					OldLover = 3;
					People.ShowPerson(1000, 1, 2, 2);
					if (LesbianTraining) {
						TotalBlowjob++;
						UpdateSexActLevels(5);
					}
				} else {
					People.ShowPerson(1000, 1, 2, 1);
					OldLover = 1;
					SetText("The customer is an older man, short and a bit weird but quite rich. He asks #slave to be his 'lover' for money.\r\r#slave accepted with an 'oral' contract.");
					if (!LesbianTraining) {
						TotalBlowjob++;
						UpdateSexActLevels(5);
					}
				}
				SlaveGirl.OldLoverStartDating();
				Pay = Math.ceil(VarBlowJobRounded / 3);
				XMLData.XMLEvent("StartDatingOldLover", false);
				return;
			}
		}
		AppendActText = true;
		if (!female) ChangeCumslut(1);
		if (SlaveGirl.ShowJobSleazyBarService(female) != true) {
			UseGeneric = true;
			if (UseImages) ShowActImage(10031);
			if (UseGeneric) XMLData.PerformActNow(-50, "BlowJob", SlaveFemale && female);
		}
	}
	TotalSleazyBarService++;
	if (AppendActText) {
		if (female) {
			if (LesbianTraining) {
				TotalBlowjob++;
				UpdateSexActLevels(5);
			}
		} else {
			if (!LesbianTraining) {
				TotalBlowjob++;
				UpdateSexActLevels(5);
			}
		}
		DoXMLAct("SleazyBarService" + (OldLover > 0 ? "OlderLover" : ""));
	}
	Money(Math.ceil(VarBlowJobRounded / 4));
	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0);
	ShowPlanningNext();
}


// Schools
//========

// School - Science
function DoSchoolSciences() {
	
	FirstTimeToday = FirstTimeTodaySciences;
	Backgrounds.ShowSchool();
	
	SlaveGirl.ShowSchoolSciences();
	SelectActImage();
	
	TotalSciences++;
	
 	if (AppendActText) XMLData.DoXMLAct("Sciences");

	UpdateFactors();
	var intinc:Number = 8 + Home.hLibrary;
	intinc = intinc * IntelligenceFactor;
	if ((MaxIntelligence < AssistantMaxIntelligence) && ((VarIntelligence + intinc) > MaxIntelligence)) ChangeMaxStats(0, 0, 0, intinc);
	Points(0, -1, 0, 5 + Home.hLibrary, 0, -1, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 1, 0, 0, 0);
	
	if (FirstTimeTodaySciences && (VarSchoolGirl == 0 || (Math.floor(Math.random()*3) < 2))) modulesList.MeetPerson(19, 0, "schoolgirl");
	
	modulesList.AfterSchool("Sciences");
	FirstTimeTodaySciences = false;
}


// School - Swimming
function DoSchoolSwimming() {
	if ((VarGold + SMGold) < 20) {
		People.ShowPerson(17, 1, 2, 1);
		ServantSpeak(Language.GetHtml("NotEnoughMoney", "Shopping"));
		return;
	}
	
	FirstTimeToday = FirstTimeTodaySwimming;
	People.GetPersonsObject("SwimInstructor").SetVisited();
	if (SlaveGirl.ShowSchoolSwimming() != true) {
		People.ShowPerson("SwimInstructor", 1, 2);
		Backgrounds.ShowBeach(3);
	} else ShowPerson(17, 0, 1, 1);
	TotalSwimming++;
	
	if (Home.HouseType == 10) {
		if (slSwimming < 2) slSwimming += 0.25;
		else if (slSwimming < 3) slSwimming += 0.13;
		FatigueBonus += StatRate * 0.6;
		Points(0, 1.2, 0, 0, 0, 2.4, 0, 0, 0, 0, 0, 0, 0, 0, 2.4, 0, 5, 1.2, 0, 0);
	} else {
		if (slSwimming < 2) slSwimming += 0.25;
		else if (slSwimming < 3) slSwimming += 0.1;
		FatigueBonus += StatRate * 0.5;
		Points(0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 4, 1, 0, 0);
	}
	if (AppendActText) XMLData.DoXMLAct("Swimming");

	if (Supervise) currentCity.MeetSwimInstructor();
	else Money(-20);
	
	modulesList.AfterSchool("Swimming");
	FirstTimeTodaySwimming = false;	
}


// School - Theology
function DoSchoolTheology() {
	
	FirstTimeToday = FirstTimeTodayTheology;
	Backgrounds.ShowTemple();
	SlaveGirl.ShowSchoolTheology();
	SelectActImage();
	XMLData.DoXMLAct("Theology");
	
	if (SMData.SMFaith == 2 && !SMAdvantages.CheckBitFlag(15)) {
		Backgrounds.ShowRuinedTemple(1);
		if ((!(SMAdvantages.CheckBitFlag(7) && SMData.Gender == 1)) && SMData.TotalSMPray <= TotalTheology) {
			AddText("You talk with #slave for a time, but realise you have little more you can teach #slavehimher. You might need to seek more spiritual guidance from a priestess of the old gods.");
			return;
		}
	}
		
	TotalTheology++;
	UpdateFactors();
	var morinc:Number = Home.hLibrary ? 6 : 5;
	if (SMData.SMFaith == 2) morinc = morinc + 1;
	var mormx:Number = 3 + (morinc * MoralityFactor);
	if ((MaxMorality < AssistantMaxMorality) && ((VarMorality + mormx) > MaxMorality)) ChangeMaxStats(0, 0, 0, 0, morinc);

	if (SMData.SMFaith == 2 && !SMAdvantages.CheckBitFlag(15)) {
		
		if (AppendActText) {
			AddText("You spend time showing #slavehimher rituals and talking of the joy and passion of the old gods. You talk of the freedom of their worship and strongly emphasize the passionate forms of worship.");
			if (TotalTheology == 1) AddText("\r\rUnfortunately the old gods do not approve of slavery, as a limit of your freedom. You try to talk about the freedoms permitted loyal slaves and of the ample passion they experience."); 
		}
		if (Home.hLibrary == 2) Points(0, 0, 0, 3, morinc, -1, 0, 0, 0, 0, 0, 0, 1, -1, 1, 0, 1, 0, 0, 0);
		else Points(0, 0, 0, 2, 5, -1, 0, 0, 0, 0, 0, 0, 1, -1, 1, 0, 1, 0, 0, 0);

	} else {

		if (Home.hLibrary == 2) Points(0, 0, 0, 3, morinc, -1, 0, 0, 0, 0, 0, 0, -5, -1, -5, 0, 1, 0, 0, 0);
		else Points(0, 0, 0, 2, morinc, -1, 0, 0, 0, 0, 0, 0, -5, -1, -5, 0, 1, 0, 0, 0);

		if (AppendActText) {
			PersonSpeakStart(24, "Don't forget the Gods always watch us.");
		
			if (Aroused) {
				temp = Math.floor(Math.random()*4);
				if (temp == 1) AddText("\rPlease do not ask so many questions about sins involving sex, it distracts the other students.");
				if (temp == 2 && RulesTouchHerself == 1) {
					if (HasCock) {
						if (SlaveGender > 3) AddText("\rIn a break I saw you both stroking your cocks.");
						else AddText("\rIn a break I saw you stroking your cock.");
					} else {
						if (SlaveGender > 3) AddText("\rIn a break I saw you both rubbing your pussies.");
						else AddText("\rIn a break I saw you rubbing your pussy.");
					}
					AddText(" You must try to control your passions and follow the teachings of the Gods.");
				}
			}
			if (StandardPlugText) {
				temp = Math.floor(Math.random()*2);
				if (temp == 1) {
					AddText("\r\rYou also moved a lot while in meditation, was there a problem?");
					PersonSpeakEnd();
					if (TotalAnal < 20 && Slutiness < 6) AddText("\r\r#slaveis acutely embarrassed and leaves.");
					else AddText("\r\r#slaveA describes how #slaveheshe was moving to try and fuck #slavehimherself on the #plugtype #skaveheshe is wearing. The nun is scandalised and tells #slavehimher to leave and not return with such a thing again.");
				} else PersonSpeakEnd();
			} else PersonSpeakEnd();
		}
		
		People.ShowPerson(24, 0, 6, 3);
		if (Supervise && SMData.TheologyTraining < 10 && FirstTimeTodayTheology) {
			AddText("\r\rAfter the lesson you talk to the nun about the gods. ");
			modulesList.eventsSM.LearnNewGods();
		}
	}
	modulesList.AfterSchool("Theology");

	FirstTimeTodayTheology = false;
}


// School - Refinement
function DoSchoolRefinement() {
	
	FirstTimeToday = FirstTimeTodayRefinement;
	Backgrounds.ShowSchool();
	People.ShowPerson(30, 0, 1);
	SlaveGirl.ShowSchoolRefinement();
	SelectActImage();
	TotalRefinement++;

	if (AppendActText) XMLData.DoXMLAct("Refinement");

	Points(0, 2, IsDressCourtly() ? 4 : 3, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
	
	modulesList.AfterSchool("Refinement");

	FirstTimeTodayRefinement = false;
}


// School - Singing
function DoSchoolSinging() {
	
	FirstTimeToday = FirstTimeTodaySinging;
	Backgrounds.ShowSchool();
	People.ShowPerson(51, 0, 1, 1);
	UseGeneric = true;
	var gen:Boolean = SlaveGirl.ShowSchoolSinging();
	if (gen != true) UseGeneric = true; 
	if (SelectActImage()) Generic.ShowSchoolSinging();

	TotalSinging++;
	
	slSinging += 0.2;

	if (AppendActText) XMLData.DoXMLAct("Singing");
	Points(0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0);
	
	modulesList.AfterSchool("Singing");
	FirstTimeTodaySinging = false;
}


// School - Dance
// 1009 - general
// 1009.1 - Latala owned
function DoSchoolDance() {
	
	FirstTimeToday = FirstTimeTodayDance;
	Backgrounds.ShowSchool();
	var donearoused:Boolean = false;
	if (IsPonygirl()) UseGeneric = true;
	if (Aroused && Math.floor(Math.random()*4) == 1) donearoused = true;
	SlaveGirl.ShowSchoolDance(donearoused);
	if (UseGeneric) Generic.ShowSchoolDance(donearoused);
	genNumber = donearoused ? 1 : 0;

	if (IsPonygirl()) {
		XMLData.DoXMLAct("DancePony");
		TotalDance++;
		ChangeFairyXF(0.5);

		if (slDancing < 3) ChangeDancing(0.1);
		Points(3, 0, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0);
		ChangePonyTraining(3);
		People.ShowPerson(14, 0, 1);
	} else {
		
		// preferentially use Latala as the trainer, otherwise any other slave with training "Dancer"
		// if none of the above then use the general Dance School Teacher
		var sdDancer:Slave = SMData.GetUsableSlaveDetails("Latala");
		if (sdDancer == null) sdDancer = SMData.GetAnySlaveTrainedAs("Dancer", "Tutor");

		TotalDance++;
		ChangeFairyXF(0.5);

		Points(3, 0, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0);
		if (IsDressDancing()) Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		
		if (sdDancer != null) {
			if (slDancing < 3) slDancing += 0.2;
			else if (slDancing < 4) slDancing += 0.1;
			UpdateBasicSlaveSkills();
			Points(0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			HideAllPeople();
			ShowSlave(sdDancer, 0, 7);
		} else {
			People.ShowPerson(14, 0, 1);
			if (slDancing < 3) {
				slDancing += 0.2;
				UpdateBasicSlaveSkills();
			}
		}
		
		XMLData.DoXMLAct("Dance");

		if (AppendActText) XMLData.DoXMLActForSlave("TrainDancing", sdDancer);
	}
	FatigueBonus += StatRate * 0.5;
	modulesList.AfterSchool("Dance");
	FirstTimeTodayDance = false;
}


// School - XXX
function DoSchoolXXX() {
	
	FirstTimeToday = FirstTimeTodayXXX;
	Backgrounds.ShowSchool();
	
	if (TestObedience(DifficultyXXX, 101)) {
		
		UseGeneric = false;
		People.ShowPerson(31, 0, 1);
		var doDG:Boolean = SlaveGirl.ShowSchoolXXX(DickgirlXF == 0 && IsDickgirlEvent());
		SelectActImage();
		genNumber = doDG == true ? 1 : 0;
		var maxf:Number = AssistantMaxFuck > MaxStat ? AssistantMaxFuck : MaxStat;
		var maxb:Number = AssistantMaxBlowJob > MaxStat ? AssistantMaxBlowJob : MaxStat;
		var learnt:Boolean = false;
		var cfuck:Number = LesbianTraining ? VarLesbianFuck : VarFuck;
		var cbj:Number = LesbianTraining ? VarCunnilingus : VarBlowJob;
		if (MaxFuck < maxf || MaxBlowJob < maxb) learnt = true;	
		genNumber2 = learnt ? 1 : 0;
		
		if (AppendActText) XMLData.DoXMLAct("XXX");
		
		TotalXXX++;
		if (TotalXXX == 1) DifficultyXXX = DifficultyXXX-5;
		
		UpdateFactors();
		var fuckinc:Number = 5 * FuckFactor;
		if ((MaxFuck < maxf) && ((cfuck + fuckinc) > MaxFuck)) ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, fuckinc);
		var bjinc:Number = 5 * BlowjobFactor;
		if ((MaxBlowJob < maxb) && ((cbj + bjinc) > MaxBlowJob)) ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, bjinc);

		if (doDG == true) Points(0, 0, -2, 0, -2, 1, 0, 0, 0, 4, 5, -4, 4, 0, -2, 0, 6, 0, 0, 0);
		else Points(0, 0, -2, 0, -2, 1, 0, 0, 0, 3, 4, -3, 4, 0, 1, 0, 4, 0, 0, 0);

		modulesList.AfterSchool("XXX");
		FirstTimeTodayXXX = false;
		
	} else {
		Refused(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, 0, 0, 0, -1, 0, 0);
	}
}


// Chore - Break

function StandardRest(hrs:Number) : Number
{
	var rest:Number = Home.hWards > 0 ? -6.5 : -5;
	if (Home.HouseType == 10) rest--;
	var lib:Number = 0;
	if (Aroused && IsSexPlanningTime()) lib = Math.floor(VarLibidoRounded/5);
	if (ZodaiEffecting > 0) lib *= 2;
	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, lib * hrs, 0, rest * hrs, 0.5 * hrs, 0, 0);
	return rest;
}

function DoChoreBreak() {
	
	//SMTRACE("DoChoreBreak");
	FirstTimeToday = FirstTimeTodayBreak;
	Backgrounds.ShowBedRoom();
	UseGeneric = false;
	var nodreams:Boolean = false;
	if (Aroused && IsSexPlanningTime()) {
		//SMTRACE("nothing");
		nodreams = SlaveGirl.ShowSexActNothing();
		SelectActImage(false, 1);
		XMLData.DoXMLAct("Nothing");
	} else {
		//SMTRACE("break");
		SlaveGirl.ShowBreak();
		SelectActImage(false, 1017);
		XMLData.DoXMLAct("Break");
	}
	TotalBreak++;

	var hrs:Number = Math.round((Action - 1017) * 100) + 1;
	var rest = StandardRest(hrs);
	var lib:Number = 0;
	if (Supervise) {
		if (SMData.SMLust > 40 && IsSexPlanningTime()) lib = Math.floor(SMData.SMLust/10);
		SMData.SMPoints(0, 0, 0, 0, 0, lib * hrs, 0, 0, 0, 0, 0, 0, rest * hrs);
	} else {
		if (AssistantData.VarLibido > 40 && IsSexPlanningTime()) lib = Math.floor(AssistantData.VarLibido/10);
		AssistantData.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, lib * hrs, 0, rest * hrs / 2, 0.5 * hrs, 0, 0);
	}
	UpdateSlave();

	if (AppendActText) {
		if (!IsSexPlanningTime()) {
			if (Supervise) AddText("You relax with #slavehimher for a while. The break from #slavehisher training makes #slavehimher feel better.");
			else ServantSpeak("This rest makes #slavehimher feel better.");
		} else {
			if (IshinaiEffecting == 1) {
				AddText("Because of the drug, you don't know how #slaveheshe feels.\r\r");
			} else if (DoreiEffecting == 1) {
				AddText("The drug makes #slavehimher enjoy the break.\r\r");
			} else if (VarLibidoRounded<30) {
				AddText("This break makes #slavehimher feel better.\r\r");
			} else if (VarLibidoRounded<50) {
				AddText(SlaveHeSheUC + NonPlural(" seem") + " to want to fuck more and more.\r\r");
			} else if (VarLibidoRounded<80) {
				AddText("This break seems like a torture to #slavehimher.\r\r");
			} else {
				AddText(SlaveHeSheUC + " came to beg you to fuck #slavehimher.\r\r");
			}
		}
		if (DickgirlChanged) {
			if (StandardDGText) {
				if (SlaveGender > 3) AddTextToStart("When you look in you see they have changed again and are both playing with their cocks...\r\r");
				else AddTextToStart("When you look in you see " + SlaveHas + " changed again and is playing with #slavehisher cock...\r\r");
			}
			if (RulesTouchHerself == 0) BadGirl = 1;
		}

		if (nodreams != true) {
			var dream:Boolean = false;
			if ((DemonicBraWorn == 1 || DemonicPendantWorn == 1) && Home.hWards != 1) {
				AddText("\r\r...#Slavehisher dreams are filled with demonic visions of couple after couple fucking.");
				ShowSexDream(LesbianTraining);
				dream = true;
			}
			if (VibratorPantiesWorn == 1 && Home.hWards != 1) {
				if (!dream) {
					AddText("\r");
					ShowSexDream(LesbianTraining);
					dream = true;
				}
				AddText("\r...The Vibrator Panties keep #slavehimher aroused and #slaveheshe keeps thinking about sex.");
			}
		}
		trace("VarLibidoRounded = " + VarLibidoRounded + " " + VarLibido + " " + slaveData.VarLibido);
		if (VarLibidoRounded > 30) {
			if (!dream) {
				AddText("\r");
				ShowSexDream(LesbianTraining);
			}
			AddText("\r..." + NameCase(SlaveHeSheIs) + " so generally aroused #slaveheshe has dreams full of sex.");
		}
	}
	FirstTimeTodayBreak = false;
}
