// Dickgirls

// other variables
var DickgirlFrequency:Number;
var AntidoteDays:Number;
var DickgirlChangable:Boolean;
var DickgirlChanged:Boolean;
var StandardDGText:Boolean;


// functions

function DickgirlTransform(xf:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	if (xf == undefined) xf = 1;
	if (xf > 0) {
		if (sd.MinLibido < 40) sd.MinLibido = 40;
		if (sd == _root) {
			if (LesbianTraining && DickgirlLesbians == false) modulesList.trainLesbians.StopTraining();
		}
	}
	if (xf == 2) ChangeSlaveGender(3, sd); 
	else {
		ChangeSlaveGender(sd.SlaveGender > 3 ? 5 : 2, sd);
		sd.DickgirlXF = xf;
		if (sd == _root) {
			if (xf > 0) UnEquipItem(15);
			else BitFlag1.ClearBitFlag(12);
			SetClitCockSize();
		} 
	}
	Icons.ShowDickgirlIconNow();
	genString = sd.SlaveName;
	if (xf == 1) Diary.AddEntryLang("Dickgirl/Transformed", false, 0, true);
	else if (xf == 2) Diary.AddEntryLang("Dickgirl/Permanent", false, 0, true);
	else if (xf <= 0) Diary.AddEntryLang("Dickgirl/Cured", false, 0, true);
}

function CureDickgirlTransform() { DickgirlTransform(0); }

// return true if spontaneous change, UseGeneric == true if using a default image
function DoDickgirlChange(chance:Number, chance2:Number) : Boolean
{
	if (IsDickgirl()) DefaultGeneric(chance);
	else if (DickgirlChanged) return false;
	else if (DickgirlChangable) {
		if (chance2 == undefined) chance2 = 100;
		if (PercentChance(chance2)){
			DickgirlChanged = true;
			if (chance != undefined) DefaultGeneric(chance);
		}
	}
	return DickgirlChanged;
}

function IsDickgirlChangeEvent(chance:Number) : Boolean
{
	if (IsDickgirl() || DickgirlChanged) return false;
	if (DickgirlChangable) {
		if (chance == undefined) chance = 100;
		if (PercentChance(chance)) DickgirlChanged = true;
	}
	return DickgirlChanged;
}

// return true if spontaneous change and generic image to be used
function DoDickgirlChangeGeneric(chance:Number) : Boolean
{
	if (DoDickgirlChange(chance)) return UseGeneric
	return false;
}

function DefaultDickgirl(chance:Number) : Boolean
{
	if (IsDickgirl()) return DefaultGeneric(chance);
	return false;
}

// is a random encounter with the dickgirl version
function IsDickgirlEvent() : Boolean
{
	if (DickgirlOn == 0) return false;
	switch(DickgirlFrequency) {
		case 0: return Math.floor(Math.random()*5) == 1;
		case 1: return Math.floor(Math.random()*5) < 3;
	}
	return true;
}


// Walks

function VisitAstrid()
{
	//Backgrounds.ShowHouseOutside(5);
	AutoLoadImageAndShowMovie("Images/Cities/Mardukane/Areas/City/Places/Astrid's Cottage 2.jpg", 1.1, 3);

	TotalVisitAstrid++;
	if (TotalVisitAstrid > 2) BitFlagSM.SetBitFlag(3);
	ShowPerson(16, 0, 6, 1);
	if (SlaveGirl.VisitAstrid() == true) {
		
		currentCity.MeetPerson(16, 0, "Astrid");
		LastVisitDickgirl = GameDate;
		return;
	}
	var eNode:XMLNode = GetNode("Visits/VisitAstrid/Visit");
	if (XMLEventByNode(eNode, false)) {
		currentCity.MeetPerson(16, 0, "Astrid");
		LastVisitDickgirl = GameDate;
		return;
	}

	if (DickgirlOn != 1 || !SlaveFemale) {
		if (LastVisitDickgirl >= TrainingStart) AddText("#slave again meets Astrid at her out of the way cottage.");
		else AddText(SlaveMeet + " a woman named Astrid in an out of the way cottage. She mentions she is running a small alchemical business but will not go into details.");
		if (!Supervise) AddText(" To #assistant's annoyance " + ServantHeShe + " is asked to wait outside and they enter the cottage.\r\r");
		AddText("Astrid has her maid serve drinks.\r\r");
		if (!MeetAstrid()) AddText("They have a pleasant talk about the forest and gossip a little about people in the city.");
		AddText("The maid is shy and stays out of sight. Once " + SlaveVerb("hear") + " her sigh, or moan a little, but Astrid says she is fine, just doing her duties.");
		if (!Supervise) AddText("\r\r" + SlaveVerb("leave") + " and rejoins #assistant.");
		Points(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		LastVisitDickgirl = GameDate;
		return;
	}
	
	SetEvent(200);
	genNumber = PotionsUsed[0];
	if (DickgirlXF == 0 && !IsPermanentDickgirl()) {
		if (PotionsUsed[0] == 0) {
			if (LastVisitDickgirl >= TrainingStart) AddText("#slave again meets");
			else AddText("#slave and #super meet a woman named");
			AddText(" Astrid near an out of the way cottage and she invites ");
			if (Supervise) AddText("you both");
			else AddText("them");
			AddText(" in.\r\rThe interior of the cottage has many books of alchemy and there is an odd smell. Astrid explains that she runs a business making and selling specialist alchemical potions. While she talks #slave can see Astrid is a very fit and well muscled woman of striking good looks. There is a set of well maintained armour and a fine sword displayed.\r\r");
			MeetAstrid();
			AddText("She summons a maid who looks rather nervous as she enters the room, glancing rapidly at #slave and #super. Astrid whispers something to her and a few minutes later she returns with a large clear vessel filled with a milky liquid.\r\rAstrid offers #slave to drink the potion which is called the 'Priapus Draft' promising a transcendent experience. She refuses with a smile to explain more but reassures #slavehimher that it is perfectly safe. She again assures that it is something every woman should try.");
			if (!XMLData.XMLEvent("DickgirlPotionOfferFirstTime")) SlaveGirl.DickgirlPotionOfferFirstTime();
		} else {
			AddText(SlaveVerb("come") + " to Astrid's cottage, remembering #slavehisher last experience with the 'Priapus Draft' and having a cock.\r\r");
			MeetAstrid();
			AddText("Astrid again offers to #slave to try the 'Priapus Draft'. Astrid's maid places the potion in front of #slave. Astrid explains that every woman should have a cock and that it is her desire to give this blessing to all, at least for a time.\r\r");
			if (PotionsUsed[0] > 1 && LesbianTraining && DickgirlLesbians == false) {
				if (Supervise) AddText("You explain that it is not appropriate to take the draft again as " + SlaveIs + " undergoing training as " + Plural("a lesbian slave") + ".\r\rAstrid argues that having a cock would make the perfect lesbian but you refuse.");
				else AddText(ServantName + " says that it is not appropriate to take the draft again as " + SlaveIs + " undergoing training as " + Plural("a lesbian slave") + ".\r\rAstrid argues that having a cock would make the perfect lesbian but #assistant refuses.");
				ResetEventPicked();
			} else {
				if (!XMLData.XMLEvent("DickgirlPotionOffer")) SlaveGirl.DickgirlPotionOffer();
			}
		}
	}
	if (DickgirlXF > 0) {
		if (DickgirlXF == 1 && AntidoteDays != -1) {
			if (LastVisitDickgirl < 0) {
				StartFucking(1);
				ShowPerson(16, 1, 1, 4);
				if (LastVisitDickgirl > 0) AddText("#slave again meets");
				else AddText(SlaveMeet + " a woman named");
				AddText(" Astrid in an out of the way cottage.");
				MeetAstrid();
				if (PotionsUsed[0] == 0) AddText("Astrid offers #slave to drink a potion called the 'Priapus Draft' promising a transcendent experience.");
				else AddText("Astrid offers #slave to again drink the 'Priapus Draft'.");
				AddText("\r\rShe then notices " + SlaveHeSheHas + " " + Plural("a large erection") + " and they talk. #slave explains how it spontaneously appeared and how #slavehisher Slave Maker wants an antidote for it, despite being a hermaphrodite herself! Astrid promises to locate the antidote but says it will take some time.\r\rShe suggests she can do something about #slave's erection though and proceeds to give her an expert blowjob. When #slave cums she collapses gasping. ");
				if (Naked) AddText(SlaveHeSheUC);
				else AddText(SlaveHeSheUC + " feels her lower clothes moved aside and");
				AddText(" sees Astrid has removed her clothes and also has a large cock. Before #slave can comment Astrid thrusts in, whispering 'payment'.\r\rAstrid fucks her many times, in pussy, ass and mouth, but she happily allows #slave to fuck her too.");
				AntidoteDays = 15 + Math.floor(Math.random()*3);
			} else if (AntidoteDays > 0) {
				AddText(Language.GetHtml("CureNotReady", "SlaveTrainings/Dickgirl") + "\r\r");
				MeetAstrid();
			} else {
				MeetAstrid();
				XMLData.XMLGeneral("SlaveTrainings/Dickgirl/CureReady");
			}
		} else {
			XMLData.XMLGeneral("SlaveTrainings/Dickgirl/AstridSex");
			BlankLine();
			MeetAstrid();
		}
	} else {
		if (NumEvent > 0) {
			if (NumEvent != 210 && NumEvent != 201) {
				AddText("\r\r" + Language.GetHtml("AskToDrink", "SlaveTrainings/Dickgirl") + "\r"); 
				DoYesNoEventXY(NumEvent);
			} else DoEvent();
		}
	}
	LastVisitDickgirl = GameDate;
}


// Dickgirl Events

function DickgirlEvent()
{
	switch(NumEvent) {
		
	// Drink Priapus Draft - stage 2
	case 200:
		HideImages();
		DickgirlChanged = true;
		Potions.DrinkPotion(0, 0, "");
		DoEvent(240);
		break;

	// Drink Priapus Draft - stage 1
	case 201:
		SetEvent(200);
		Icons.ShowDickgirlIconNow();
		HideImages();
		if (SlaveGirl.ShowDickgirlTransform(false) != true) Generic.ShowDickgirlTransform(false);
		DoEvent();
		break;
		
	// Drink Priapus Draft - permanent stage 0
	case 202:
		SetEvent(210);
		Icons.ShowDickgirlIconNow();
		HideImages();
		if (SlaveGirl.ShowDickgirlTransform(true) != true) Generic.ShowDickgirlTransform(true);
		DoEvent();
		break;
		
	// 210 - Drink Priapus Draft - permanent transform - stage 1
	case 210:
		Icons.ShowDickgirlIconNow();
		slaveData.ChangePotionUsed(0);
		clearInterval(intervalId);
		HideAssistant();
		XMLData.XMLGeneral("SlaveTrainings/Dickgirl/PermanentTransform1");
		break;
		
	// 211 - Drink Priapus Draft - permanent transform - stage 2
	case 211:
		HideImages();
		HideSlaveActions();
		HidePeople();
		SetText("");
		if (SlaveGirl.ShowDickgirlPermanent() != true) Generic.ShowDickgirlPermanent();
		if (!Language.IsTextShown()) {
			HideAssistant();
			XMLData.XMLGeneral("SlaveTrainings/Dickgirl/PermanentTransform2");
		}
		
	// 212 - Drink Priapus Draft - permanent transform - stage 3
	case 212:
		SetEvent(240);
		DickgirlTransform(1);
		DoEvent();
		break;
		
	// 240 - after dickgirl potion
	case 240:
		Diary.AddEntryLang("Dickgirl/TemporaryChange");
		var oldsuper:Boolean = Supervise;
		DickgirlChanged = false;
		if (PotionsUsed[0] == 1) {
			AddText(Language.GetHtml("FirstTimeAfter", "SlaveTrainings/Dickgirl") + "\r\r");
			ShowPlanningNext();
		} else if (DickgirlXF == 1) {
			AddText(Language.GetHtml("AfterPermanentXF", "SlaveTrainings/Dickgirl") + "\r\r");
			if (AntidoteDays == 0) AntidoteDays = 15 + Math.floor(Math.random()*3);
			if (Plannings.IsStarted()) AdvancePlanningTime();
			StopPlanning();
		} else if (PotionsUsed[0] > 2) {
			AddText(Language.GetHtml("AfterMultipleUseNoXF", "SlaveTrainings/Dickgirl") + "\r\r");
			ChangeMinStats(0, 10);
			if (DickgirlRate == 0) DickgirlRate = 20;
			else DickgirlRate = DickgirlRate + 10;
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0);
			ShowPlanningNext();
		} else {
			AddText(Language.GetHtml("SecondTimeAfter", "SlaveTrainings/Dickgirl") + "\r\r");			
			ShowPlanningNext();
		}
		if (IsDickgirl()) {
			if (oldsuper) AddText("You decide it is best to return home to discuss this event and reconsider #slavehisher training.\r\r");
			else AddText("#assistant decides it is best to return home to discuss this event with you.\r\r");
			AddText("At home you talk with #slave about #slavehisher changes and how #slavehisher" + Plural(" new cock") + " will affect #slavehisher training and future. Some acts will now obviously be different and you will have to experiment with #slavehisher changes.");
			if (LesbianTraining && DickgirlLesbians == false) {
				AddText("\r\rRegretfully, you will have to end #slave's lesbian training due to #slavehisher changes. A hermaphrodite is not purely a woman and this will cause problems for lesbian owners. Sometime if " + SlaveVerb("become") + Plural(" a woman") + " again, then you could resume the training.");
			}
		}
		HideImages();
		HideSlaveActions();
		dspMain.ShowStatisticsTab(1);
		HideBackgrounds();
		ShowDress();
		SlaveGirl.AfterDickgirlPotion(PotionsUsed[0]);
		if (!XMLData.XMLEvent("AfterDickgirlPotion")) BlankLine();
		break;
	}
}

function DoDickgirlYes()
{
	switch (NumEvent) {
		// 200 - drink Priapus Draft (Astrid)
		case 200:
			Icons.ShowDickgirlIconNow();
			if (PotionsUsed[0] == 2 && AllDickgirlXFOn) SetEvent(210); 

			if (SlaveGirl.ShowDickgirlTransform() != true) {
				Generic.ShowDickgirlTransform(NumEvent == 210);
			}
			DoEvent();
			break;
			
		// 220 - drink dickgirl antidote
		case 220:
			if (DressWorn < 0) {
				NakedChoice = 0;
				slaveData.NakedChoice = 0;
			}
			CureDickgirlTransform();
			SlaveGirl.ShowLoveRefused();
			Language.AddLangText("TakeCure", "SlaveTrainings/Dickgirl");
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -5, 0, 0, -1, 0, 0);
			PotionsUsed[0] = 1;
			BitFlag1.ClearBitFlag(12);
			ResetEventPicked();
			break;
	}
}

function DoDickgirlNo()
{
	switch (NumEvent) {
		// 200 - Priapus Draft (Astrid)
		case 200:
			if (PotionsUsed[0] > 0) {
				HideStatChangeIcons();
				Language.SlaveSpeakLang("RefusedLater", "SlaveTrainings/Dickgirl");
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 2, 0, 0, 0, 0, 0);
			} else Language.AddLangText("RefusedFirst", "SlaveTrainings/Dickgirl");
			break;
			
		// 220 - Do not take dickgirl antidote
		case 220:
			HideStatChangeIcons();
			if (DressWorn == -1) {
				NakedChoice = 0;
				slaveData.NakedChoice = 0;
			}
			DickgirlTransform(2);
			Language.AddLangText("RefuseCure", "SlaveTrainings/Dickgirl");
			Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 1, 2, 2, 1, 5, 5, 0);
			break;
	}
}
