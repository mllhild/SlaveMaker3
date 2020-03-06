import Scripts.Classes.*;

// Load a Saved Game

function ResumeGame()
{
	trace("ResumeGame");
	SlaveMovie.stop();
	SlaveMovie._visible = false;
	var mcs:MovieClip;
	for (var mv:String in SlaveMovie) {
		mcs = MovieClip(SlaveMovie[mv]);
		if (typeof(mcs) != "movieclip" || mcs == _root) continue;
		mcs.stop();
	}
	ResumeGame2();
}

function ResumeGame2(timer:Number)
{
	//trace("ResumeGame2: waiting");
	if (!Language.IsLoaded() || !modulesList.IsEventsLoaded() || !SlaveList.IsLoadedAll()) {
		//trace(Language.IsLoaded() + " " + modulesList.IsEventsLoaded() + " " + SlaveList.IsLoadedAll());
		if (timer != undefined) return;
		Timers.AddTimerShowWait(
			setInterval(_root, "ResumeGame2", 20, Timers.GetNextTimerIdx())
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	
	dmod = 1 - (Difficulty / 7);
	SlaveDebugging = false;
	SpecialIndex = 0;
	IntroPage = 0;
	
	ChangeSlaveMakerGender();
	SMData.ChangeSlaveMakerFaith();
	SMData.ChangeGuildMembership();
	UpdateSlaveMaker();
	dspMain.SetSMSkills(SMData);
	SMData.ShowSMQualities();
	SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, 0);
	
	XMLData.SetCurrentSlaveXML(XMLData.GetSlaveXML(undefined, slaveData));

	slaveData.ClearSlaveSkillArray();
	SlaveGirl.Destroy();
	modulesList.CreateSlaveGirl(slaveData);
	SlaveMovie._visible = true;
	SlaveVersion = "";
	SlaveCredits = "";
		
	dspMain.SetSlaveSkills();
	UpdateOtherSlaveDetails();
	
	SelectEquipment.StartNewSlave();
	
	SlaveGirl.Initialise();
	XMLData.InitialiseSlaveXML(false);
	if (SlaveName1 == "") {
		SlaveName1 = SlaveName;
		SlaveName2 = SlaveName;
	}
	if (SlaveGenderBorn == 0) SlaveGenderBorn = SlaveGender;
	if (OldSlaveGender == 0) OldSlaveGender = SlaveGender;
	UpdateSlaveGenderText();
	SetClitCockSize();
	AlterSexuality(0);
	SlaveGirl.CurrentPath = CurrentPath;
	SlaveGirl.ImageFolder = slaveData.ImageFolder;
	slaveData.SlaveType = -10;
	slaveData.CopyCommonDetails(slaveData, _root);

	if (LoadSave.IsStartingGame()) Diary.AddEntry(Language.GetHtml("StartTraining", "Diary"), false, 0, false, 1);
	
	dspMain.SystemMenu.SetSlaveDetails(SlaveVersion, SlaveCredits);
	
	HouseEvents.ChangeHouse(undefined, true);
		
	HideAllPeople();
	HideStatChangeIcons();
	HideSlaveActions();
	HideEndings();
	HideImages();
	if (LoadSave.IsShown()) Backgrounds.ShowIntroBackgroundWhite(true);
	else Backgrounds.ShowIntroBackgroundBlack();
	ChangeDate();

	// Select Assistant or load rhe current assistant
	if (LoadSave.IsStartingGame()) {
		trace("..Starting a new Slave: " + ServantName + " " + SlaveFileName + " " + slaveNode + " " + slaveData.Owner);
		if (ServantName != "") {
			trace("....using set assistant: " + ServantFilename + "(" + ServantName + ")");
			if (ServantFilename != "") ChangeAssistantByFilename(ServantFilename, false);
			else ChangeAssistant(ServantName, false);
		} else {
			trace("....select assistant");
			if (SMData.GuildMember) SMMoney(500);
			SlaveSelection._visible = true;
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(42)) {
				changeloadstart = false;
				if (SMData.GuildMember) Information.ShowTutorialLang("ContractSigned", ChooseAssistant);
				else Information.ShowTutorialLang("SlavePurchased", ChooseAssistant);
				SlaveGirl.ShowContractSigned();
			} else AssistantSelect.ViewDialog();
		}
		if (SMData.GuildMember) {
			if (Owner.GetOwner() == 0) Owner.ChangeOwner(1999);
		}
		if (slaveData.StartOwner == null) {
			slaveData.StartOwner = new PersonOwner(null, coreGame);
			slaveData.StartOwner.Load(Owner);
		}
	} else {
		trace("..Loading an existing Slave");
		var cookie:SharedObject = SharedObject.getLocal(LoadSave.GetLoadName() + "custom");
		SlaveGirl.LoadGame(cookie.data.SlaveSave);
		
		IntroPage = IntroPages + 1;
		if (ServantName != "") {
			if (ServantFilename != "") ChangeAssistantByFilename(ServantFilename, true);
			else ChangeAssistant(ServantName, true);
		} else ChangeAssistantByFilename("", true);
	}
}


// Show all game screens, called after loading or starting a new game

function ResumeShow()
{
	trace("ResumeShow " + GetUTCMSElapsed(true));
	Beep();
	SlaveNumber = 0;

	// UI	
	HideAllImages();
	dspMain.Show();
	dspMain.SetSlaveForGameTabs(_root);
	
	UpdateSlave();
	SetActButtonDetailsStartup();
	dspMain.SetSexSkills();
	
	if (LendPerson != 0) {
		MorningEvening.PressButton();
		dspMain.ShowMainButtons();
	} else {
		HideAllPeople();
		dspMain.ShowMainButtons();	
		ShowDress();
	}
	dspMain.SelectGameTabShow(1);
	
	ResetEventPicked();
				
	modulesList.LoadGame(LoadSave.GetLoadName());
	
	if (LoadSave.IsStartingGame()) {
		SMData.SMTiredness = 0;
		UpdateOtherSlaveDetails();
		if (ServantName != "") {
			if (AssistantCost != 0) SMMoney(AssistantCost * -1, true);
			CurrentAssistant.EmployAsAssistant();
		}
		
		// apply bonus effects from minor slaves
		//trace("apply bonuses");
		var sNode:XMLNode;
	
		for (var so:String in SMData.arUsableSlaves) {
			sdata = SMData.arUsableSlaves[so];
			if (sdata.SlaveType == 0) {
				if (sdata.sNode == null) {
					sNode = XMLData.GetSlaveXML(undefined, sdata);
					sdata.sNode = sNode;
				} else sNode = sdata.sNode;
				
				XMLData.XMLEventByNode(GetNode(sNode, "SlaveBonus"), false, undefined, true); 
			}
			sdata.VarFatigue = 0;
		}
		//trace("bonuses applied");
		
		if (ServantName != "") {
			XMLData.XMLEventByNode(GetNode(assNode, "Employ"), false, undefined, true); 
			XMLData.XMLEventByNode(GetNode(assNode, "SlaveBonus"), false, undefined, true); 
		}
		UpdateSlaveGenderText();
		var bSGMessage:Boolean = SlaveGirl.StartMessage() == true;
		if (!bSGMessage) {
			if (!XMLData.XMLEventByNode(GetNode(slaveNode, "StartGreeting"), false)) {
				if (ServantName != "") {
					if (CurrentAssistant.StartMessageAsAssistant(bSGMessage) != true) {
						if (!XMLData.XMLEventByNode(GetNode(assNode, "StartGreeting"), true, undefined, true)) {
							if (SMData.GuildMember) ServantSpeak(Language.strReplaceValue(Language.GetHtml("StartMessage", assNode), TrainingTime), true);
							else ServantSpeak(Language.GetHtml("StartMessageFreelancer", assNode));
						}
					}
				}
			}
		}
	}

	intervalId = setInterval(_root, "ResumeShow2", 50);
	Timers.ShowWait();
}

function ResumeShow2()
{
	//trace("ResumeShow2");
	if ((!modulesList.IsLoadGameComplete()) || !SlaveList.IsLoadedAll()) return;
	clearInterval(intervalId);	
	
	Language.PopulateLanguage();
	HouseEvents.ChangeHouse(undefined, true);
	
	PersonIndex = -50;
	XMLData.InitialiseCommonXML(flNode, false);
	slaveData.CopyCommonDetails(_root);
	
	if (NumEvent == 0) ShowAssistantSoon();
	
	ChangeSlaveMakerGender();
	intervalId = setInterval(_root, "ResumeShow3", 50);
	
	SMData.BuildOwnedSlaves();
}

function ResumeShow3()
{
	clearInterval(intervalId);
	
	// reset max stats for all owned slaves
	trace("update slaves " + GetUTCMSElapsed());
	var str:String;	
	var val:Number;
	var sNode:XMLNode;
	
	// check list of minor slaves
	// TODO what about unowned main slaves or assistants?
	for (var msNode:XMLNode = XMLData.mslavesNode; msNode != null; msNode = msNode.nextSibling) {
		if (msNode.nodeType != 1) continue;
		if (msNode.nodeName.toLowerCase() == "slave") {
			str = XMLData.GetXMLStringSimple("Image", msNode.firstChild);
			var bOwned:Boolean = false;
			sdata = SMData.GetSlaveDetailsFromImageName(str);
			if (sdata != null) {
				sdata.sNode = msNode.firstChild;
				bOwned = true;
				if (sdata.SlaveType <= -100 || sdata.SlaveType == -2 || sdata.SlaveType == -3 || sdata.SlaveType == -4) bOwned = false;
				else if (sdata.SlaveType == -1 && sdata != AssistantData) bOwned = false;
				else if (sdata.SlaveType == 1 && sdata.Owner != null) {
					if (sdata.CanAssist == false && !sdata.Owner.IsPersonallyOwned()) bOwned = false;
				}
			}
			if (!bOwned && currentCity.IsSlavePresent(msNode.firstChild)) {
				//trace("....loading events");
				XMLData.AddSlaveEvents(msNode.firstChild, false);
			}
			if (sdata.SlaveType == 0 || sdata.SlaveType == 20 || sdata.SlaveType == 2) {
				sdata.MaxSensibility = -1;
				sdata.MaxRefinement = -1;
				sdata.MaxIntelligence = -1;
				sdata.MaxMorality = -1;
				sdata.MaxCooking = -1;
				sdata.MaxCleaning = -1;
				sdata.MaxConversation = -1;
				sdata.MaxObedience = -1;
				sdata.MaxCharisma = -1;
				sdata.MaxNymphomania = -1;
				sdata.MaxConstitution = -1;
				sdata.MaxTemperament = -1;
				sdata.MaxObedience = -1;
				sdata.MaxLibido = -1;
				sdata.MaxJoy = -1;
			}
		}
	}
	trace("minor slaves updated " +  + GetUTCMSElapsed());
	
	// Update list of owned slaves
	var j:Number = SMData.nUsable;
	while (--j >= 0) {
		sdata = SMData.arUsableSlaves[j];
				
		// semi inlined GetSlaveInformation
		PersonGender = sdata.SlaveGender;		
		PersonName = sdata.SlaveName;
		PersonIndex = sdata.SlaveIndex;

		trace("  updating slave " + sdata.SlaveName + " at " + + GetUTCMSElapsed());

		if (sdata != AssistantData && sdata.sNode == null) {
			sNode = XMLData.GetSlaveXML(undefined, sdata);
			sdata.sNode = sNode;
		} else sNode = sdata.sNode;
		
		if (sNode != null) {
			if (sdata.SlaveType != -10 && sdata.CanAssist != true) {
				if (sdata.SlaveImage == "") {
					str = XMLData.GetXMLStringParsed("Image", sNode);
					if (str != "") sdata.SlaveImage = str;
				}
			}
			if (sdata.vitalsDescription == "Slave girl in training") {
				str = GetXMLString("Description", sNode);
				if (str != "") sdata.vitalsDescription = str;
				else if (sdata.SlaveType == -1 || sdata.SlaveType == 2) sdata.vitalsDescription = Language.GetHtml("SlaveMakerHire", "SlaveMarket");
			}
			if ((sdata.SlaveName == "Thoth" || sdata.SlaveName == "Ponygirl 1") && sdata.SlaveImage.indexOf("/") == -1) {
				var str:String = XMLData.GetXMLString("Image", sNode);
				if (str != "") sdata.SlaveImage = str;
			}
			if (sdata.ImageFolder == "" || sdata.ImageFolder == undefined) {
				trace("fix image folder for " + sdata.SlaveName);
				sdata.ImageFolder = XMLData.GetXMLString("Folder", sNode);
				if (sdata.ImageFolder == "") {
					var slv:LoadVars = SlaveList.GetSlaveListDetails(sdata.SlaveName);
					if (slv.Folder != "") sdata.ImageFolder = slv.Folder;
				}
				if (sdata == AssistantData) CurrentAssistant.ImageFolder = sdata.ImageFolder;
				sdata.ActInfoCurrent.ActFolder = sdata.ImageFolder;
			}	
			if (sdata.SlaveType == 2) {
				if (sdata.SlaveFilename.indexOf("Assistants/Assistant-") == -1) sdata.SlaveType = 1;
			}
			
		}
		
		if (sdata.Fertility == 0 || sdata.Fertility == undefined) {
			if (sNode != null) {
				val = XMLData.GetXMLValue("Fertility", sNode, -1);
				if (val != -1) sdata.Fertility = val;
				else sdata.Fertility = config.nDefaultFertility;
			} else sdata.Fertility = config.nDefaultFertility;
		}
		if (sdata.TrainingStart == undefined) sdata.TrainingStart = GameDate;
		sdata.CheckDefaultPersonality();
		
		if (sdata == AssistantData) {
			sNode = assNode;
			//AssistantData.LoadActImages(assNode);
		}
		
		if (sNode == null) continue;
		
		XMLData.AddSlaveEvents(sNode, true);
		if (sdata.SlaveType != -10) XMLData.InitialiseCommonXML(sNode, true);
	}
	
	slaveData.CopyCommonDetails(slaveData, _root);
		
	trace("slaves updated " +  + GetUTCMSElapsed());
	Timers.StopWait();	
	
	LoadSave.SetLoadingComplete();
	
	Icons.UpdateIcons(_root);
	Icons.SetLoveIcon(_root);
	currentCity.Initialise();
	HouseEvents.ChangeHouse(undefined, true);

	SlavePronoun = slaveData.SlavePronoun;
	
	SMData.UpdateHomeTown();
	ChangeSlaveGender();
	SMData.ChangeSlaveMakerFaith();
	GetPersonGenderText(GenderIdentity);
	
	InitialisePlanningCommon();
	EnableButtons();
	
	Planning.RedrawPlanningList();	
	trace("load done");
}


// Start a new game

function StartNewSlave(timer:Number)
{
	if (!SlaveList.IsLoadedSlaves()) {
		if (timer != undefined) return;
		Timers.AddTimerShowWait(
			setInterval(_root, "StartNewSlave", 20, Timers.GetNextTimerIdx())
			, undefined, true
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	Beep();
		
	NumFin = 0;
	
	ResetActImages();
	
	SpecialIndex = Home.HouseType;

	SlaveSelect.ViewDialog();
}

function StartGame(mc:MovieClip)
{
	trace("StartGame " + SlaveFilename);
	mc.stop();
	mc._visible = false;
	var mcs:MovieClip;
	for (var mv:String in mc) {
		mcs = MovieClip(mc[mv]);
		if (typeof(mcs) != "movieclip" || mcs == _root) continue;
		//trace("Stopping " + mv);
		mcs.stop();
	}
	StartGameWait();
}

	
function StartGameWait(timer:Number)
{
	if (!Language.IsLoaded() || !modulesList.IsEventsLoaded()) {
		if (timer != undefined) return;
		Timers.AddTimerShowWait(
			setInterval(_root, "StartGameWait", 40, Timers.GetNextTimerIdx())
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	//trace("StartGameWait");
	
	XMLData.SetCurrentSlaveXML(XMLData.GetSlaveXML(undefined, slaveData));

	// reset special participants
	{
		var sdata:Slave;
		for (var so:String in SMData.arUsableSlaves) {
			sdata = SMData.arUsableSlaves[so];
			if (sdata.SlaveType == -20) sdata.SlaveType = -2;
		}
	}
	//SlaveGirl.Destroy();
	modulesList.CreateSlaveGirl(slaveData);
	SlaveMovie._visible = true;
	
	if (SandboxMode && slaveData.SlaveType != -100) {
		var idx:Number = slaveData.SlaveIndex;
		slaveData.Reset();
		slaveData.SlaveIndex = idx;
	}
	slaveData.CopyCommonDetails(slaveData, _root);
	
	var str:String = XMLData.GetXMLString("Folder", slaveNode);
	if (str != slaveData.ImageFolder) slaveData.ImageFolder = str;
	
	// set references
	BitFlag1 = slaveData.BitFlag1;
	BitFlag2 = slaveData.BitFlag2;
	DemonFlags = slaveData.DemonFlags;
	Owner = slaveData.Owner;
		
	dspMain.UpdateSlaveMaker();
	dspMain.SetSlaveSkills();
	dspMain.HideGameTabs();
	HasTesticles = undefined;
	EndGame.Reset();
	
	if ((SandboxMode && slaveData.SlaveType == 1) || slaveData.SlaveType == -100 || slaveData.SlaveType == -10) {
		trace("reset/update slaveData");
		slaveData.ResetDresses();
		slaveData.SetDressDetails(0, Language.GetHtml("PlainDress", "Equipment"), Language.GetHtml("PlainDress", "Equipment") + "\r\r" + Language.GetHtml("NoEffects", "Equipment"), true, 0);
		slaveData.SetDressOwned(0);
		slaveData.SetDressDetails(1, "", StatisticsGroup.Refinement.StatLabel.text + " + 5", SlaveFilename != "", 100);
		slaveData.SetDressDetails(2, "", StatisticsGroup.Charisma.StatLabel.text + " + 10", SlaveFilename != "", 150);
		slaveData.SetDressDetails(3, "", StatisticsGroup.Refinement.StatLabel.text + " + 10\r" + StatisticsGroup.Sensibility.StatLabel.text + " + 5", SlaveFilename != "", 300);
		slaveData.SetDressDetails(4, "", StatisticsGroup.Refinement.StatLabel.text + " + 10\r" + StatisticsGroup.Charisma.StatLabel.text + " + 10\r" + StatisticsGroup.Sensibility.StatLabel.text + " + 10", SlaveFilename != "", 500);
		slaveData.SetDressDetails(5, "", "", SlaveFilename != "", 700);
		slaveData.SetDressDetails(6, "","", SlaveFilename != "", 4000);
		slaveData.DemonFlags = new BitFlags();
		slaveData.ItemsOwned = new BitFlags();
		slaveData.ItemsWorn = new BitFlags();
		DemonFlags = slaveData.DemonFlags;
		if (slaveData.Owner == null) slaveData.Owner = new PersonOwner(slaveData, coreGame);
		Owner = slaveData.Owner;
		MaxCharisma = MaxStat;
		MaxRefinement = MaxStat;
		MaxSensibility = MaxStat;
		MaxIntelligence = MaxStat;
		MaxMorality = MaxStat;
		MaxConstitution = MaxStat;
		MaxCooking = MaxStat;
		MaxCleaning = MaxStat;
		MaxConversation = MaxStat;
		MaxFuck = MaxStat;
		MaxBlowJob = MaxStat;
		MaxTemperament = MaxStat;
		MaxNymphomania = MaxStat;
		MaxObedience = MaxStat;
		MaxJoy = MaxStat;

		SlaveGirl.StartGame();
		if (LesbianInterest == -1 && Sexuality == 100) Sexuality = 50;
		slaveData.CopyCommonDetails(_root);
		if ((SandboxMode && slaveData.SlaveType == 1) || (slaveData.TrainingStart == GameDate)) XMLData.StartGameSlaveXML(slaveNode, slaveData);
		else {
			// training an alreay trained slave (usually a minor slave)
			XMLData.StartGameMainSlave(slaveNode);
			XMLData.StartGameCommonXML(slaveNode);
		}
		vitalsBustStart = vitalsBust;
		ClitCockSizeStart = ClitCockSize;
		StartSexuality = Sexuality;
		slaveData.CopyCommonDetails(slaveData, _root);
	}
	slaveData.CheckDefaultPersonality();
	slaveData.SlaveType = -10;
	TrainingStart = GameDate;
	slaveData.TrainingStart = GameDate;
	
	// 0 = Sex Items, all slaves
	// 1 = Ponygirl items, first slave
	// 2 = Ponygirl items, all slaves
	// 3 = catgirl items, first slave
	// 4 = catgirl items, all slaves
	// 5 = 1 dress
	// 6 = sword
	// 7 = leash
	// 9 = whip
	// 10 = leather armour
	// 11 = puppygirl items, first slave
	// 12 = puppygirl items, all slaves	
	if (GameDate == 1) {
		if (SMData.SMInitialItems.CheckBitFlag(1)) {
			HarnessOK = 1;
			BitGagOK = 1;
			PonyTailOK = 1;
		}
		if (SMData.SMInitialItems.CheckBitFlag(3)) {
			CatEarsOK = 1;
			CatTailOK = 1;
		}
		if (SMData.SMInitialItems.CheckBitFlag(7)) LeashOK = 1;
		if (SMData.SMInitialItems.CheckBitFlag(11)) {
			slaveData.ItemsOwned.SetBitFlag(29);
			slaveData.ItemsOwned.SetBitFlag(30);
			modulesList.GetTraining("Puppygirls").SetBitFlag(0);
		}		
	}

	if (Options.DickgirlStartOn && (SlaveGender == 2 || SlaveGender == 5)) SlaveGender = SlaveGender > 3 ? 6 : 3;
	
	if (HasTesticles == undefined) {
		if (SlaveGender == 1 || SlaveGender == 4) HasTesticles = true;
		else if (SlaveGender == 3 || SlaveGender == 6) {
			if (!DickgirlTesticles) HasTesticles = false;
			else HasTesticles = slrandom(2) == 1;
		} else HasTesticles = false;
	}

	if (ClitCockSize == 0) ClitCockSize = 0.6;
	
	LoadSave.StartGame();
	SlaveGirl.Initialise();
	
	XMLData.InitialiseSlaveXML(true);
	XMLData.StartGameCommonXML(flNode);
	currentCity.Initialise();
	HideAllPeople();
	HideSlaveActions();
	HideEndings();
	HideDresses();
	HideImages();
	HideBackgrounds();

	function DoDifficulty(val:Number) : Number
	{
		var newval:Number = 0;
		if (Difficulty == -1) newval = val - Math.floor(Math.random() * 3) - 2;
		else {
			if (val != 0) newval = val  + (Math.floor(Math.random()*Difficulty) * 3) + (Difficulty * 2);
			else newval = val;
		}
		if (newval < 0) newval = 0;
		return newval;
	}
	
	DifficultyXXX = DoDifficulty(DifficultyXXX);
    DifficultyExhib = DoDifficulty(DifficultyExhib);
    DifficultySleazyBar = DoDifficulty(DifficultySleazyBar);
    DifficultyBrothel = DoDifficulty(DifficultyBrothel);
    DifficultyTouch = DoDifficulty(DifficultyTouch);
    DifficultyLick = DoDifficulty(DifficultyLick);
    DifficultyFuck = DoDifficulty(DifficultyFuck);
    DifficultyBlowjob = DoDifficulty(DifficultyBlowjob);
    DifficultyTitsFuck = DoDifficulty(DifficultyTitsFuck);
    DifficultyAnal = DoDifficulty(DifficultyAnal);
    DifficultyMasturbate = DoDifficulty(DifficultyMasturbate);
    DifficultyDildo = DoDifficulty(DifficultyDildo);
    DifficultyPlug = DoDifficulty(DifficultyPlug);
    DifficultyLesbian = DoDifficulty(DifficultyLesbian);
    DifficultyBondage = DoDifficulty(DifficultyBondage);
    DifficultyNaked = DoDifficulty(DifficultyNaked);
    DifficultyMaster = DoDifficulty(DifficultyMaster);
    DifficultyGangBang = DoDifficulty(DifficultyGangBang);
    DifficultyLendHer = DoDifficulty(DifficultyLendHer);
	DifficultyPonygirl = DoDifficulty(DifficultyPonygirl);
	DifficultySpank = DoDifficulty(DifficultySpank);
	DifficultyThreesome = DoDifficulty(DifficultyThreesome);
	
	if (Difficulty > 0) MaxTentacleHarem++;
	
	TrainingTime -= ((Difficulty - 1) * 3);
	
	if (SMData.OldGender == 3 || SMData.Gender == 3) {
		DickgirlOn = 1;
		Options.UpdateFromGlobalData();
	}
	
	// Apply initial bonuses from Talent
	switch (SMData.Talent) {
		case 2:
			Loyalty -= 2;
			VarLove += 5;
			DifficultyBondage += 5;
			break;
		case 3:
			VarRefinement -= 5;
			break;
		case 5:
			VarLove = 0;
			DifficultyPonygirl -= 5;
			DifficultyBondage -= 5;
			break;
		case 6:
			DifficultyLesbian -= 8;
			DifficultyFuck += 2;
			DifficultyBlowjob += 2;
			DifficultyTitsFuck += 2;
			DifficultyAnal += 2;
			break;
		case 8:
			DifficultyBlowjob = 0;
			break;
		case 9:
			DifficultyPonygirl -= 5;
			DifficultyBondage -= 5;
			break;
		case 15:
			DifficultyBrothel -= 8;
			DifficultyTouch -= 5;
			DifficultyLick -= 5;
			DifficultyFuck -= 5;
			DifficultyBlowjob -= 5;
			DifficultyTitsFuck -= 5;
			DifficultyAnal -= 5;
			DifficultyMasturbate -= 5;
			DifficultyDildo -= 5;
			DifficultyPlug -= 5;
			DifficultyLesbian -= 5;
			DifficultyBondage -= 5;
			DifficultyGangBang -= 5;
			DifficultyThreesome -= 5;
			break;
		case 21:
			DifficultyPonygirl -= 5;
			DifficultyBondage -= 5;
			break;
	}
		
	// Advantages
	if (SMData.SMAdvantages.CheckBitFlag(27)) DifficultyExhib -= 10;
	if (SMData.SMAdvantages.CheckBitFlag(13)) SetTimeMins(1080);
	
	// Initial Items
	// 0 = Sex Items, all slaves
	// 1 = Ponygirl items, first slave
	// 2 = Ponygirl items, all slaves
	// 3 = catgirl items, first slave
	// 4 = catgirl items, all slaves
	// 5 = 1 dress
	// 6 = sword
	// 7 = leash
	// 8 = money
	// 9 = whip
	// 10 = leather armour
	// 11 = puppygirl items, first slave
	// 12 = puppygirl items, all slaves	
	if (SMData.SMInitialItems.CheckBitFlag(0)) {
		VibratorPantiesOK = 1;
		StrapOnOK = 1;
		DildoOK = 1;
		PlugOK = 1;
	}
	if (SMData.SMInitialItems.CheckBitFlag(2)) {
		HarnessOK = 1;
		BitGagOK = 1;
		PonyTailOK = 1;
		PonygirlsOn = true;
		SMData.PonygirlAware = 1;
		PonygirlAware = 1;			
	}
	if (SMData.SMInitialItems.CheckBitFlag(4)) {
		CatEarsOK = 1;
		CatTailOK = 1;		
	}	
	if (SMData.SMInitialItems.CheckBitFlag(5)) {
		if (IsDressForSale(2)) SetDressOwned(2);
		else if (IsDressForSale(1)) SetDressOwned(1);
		else if (IsDressForSale(3)) SetDressOwned(3);
	}
	if (SMData.SMInitialItems.CheckBitFlag(8)) SMMoney(300, true);
	if (SMData.SMInitialItems.CheckBitFlag(12)) {
		slaveData.ItemsOwned.SetBitFlag(29);
		slaveData.ItemsOwned.SetBitFlag(30);
		modulesList.GetTraining("Puppygirls").SetBitFlag(0);
	}
	// initialise from house effects
	SetActButtonDetailsStartup();
	modulesList.HouseEvents.StartNewSlave();
		
	// Apply Skill effects
	if (SMData.sNoble > 0) VarRefinement += (SMData.sNoble * 4);
	
	slaveData.CopyCommonDetails(_root);
	modulesList.StartGame();
	StartGame2();
}

function StartGame2(timer:Number)
{
	//trace("StartGame2");
	if (!modulesList.IsStartGameComplete()) {
		if (timer != undefined) return;
		Timers.AddTimerShowWait(
			setInterval(_root, "StartGame2", 40, Timers.GetNextTimerIdx())
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	ResumeGame(true);
}


// Start a new Slave Maker

function StartSlaveMaker()
{
	Diary.AddEntry(Language.GetHtml("StartCareer", "Diary"));
	
	{
		// save last used slavemaker
		var cookiesm:SharedObject = SharedObject.getLocal("smlastusedslavemaker");
		cookiesm.clear();
		SMData.Save(cookiesm.data, "");
		cookiesm.flush();
	}

	SandboxMode = Options.SandboxOn;
	TentacleFrequency = Options.GlobalTentacleFrequency;
	DickgirlFrequency = Options.GlobalDickgirlFrequency;
	
	SMData.ShowSMQualities();
	
	// Restart all external events
	modulesList.StartSlaveMaker();
	Options.UpdateFromGlobalData();
	
	UpdateSlaveMaker();
}


function RetireSlaveMaker()
{
	Beep();
	dspMain.HideGameTabs();
	HideAllImages();
	ResetActImages();
	slaveData.ClearSlaveSkillArray();
	SlaveGirl.Destroy();
	TitleScreen.DoIntroNext(5);
}

// Acts

// Startup

function SetActButtonDetailsStartup()
{
	//Language.PopulateLanguage();
	var acts:ActInfoList = slaveData.ActInfoBase;
		
	acts.SetActState(17, false, true, Language.GetHtml("Ponygirl", Language.actNode), 0, 1, "Y");
	acts.SetActState(4, false, true, Language.GetHtml("Fuck", Language.actNode), 0, 1, "F");
	acts.SetActState(9, false, true, Language.GetHtml("Dildo", "Equipment"), 0, 1, "D");
	acts.SetActState(12, false, true, Language.GetHtml("Bondage", Language.actNode), 0, 1, "B");
	acts.SetActState(15, false, true, Language.GetHtml("GangBang", Language.actNode), 0, 1, "G");
	acts.SetActState(18, false, true, "", 0, 1, "S");
	acts.SetActState(20, false, true, "69", 0, 1, "6");
	acts.SetActState(25, false, true, Language.GetHtml("CumBath", Language.actNode), 0, 1, "Q");
	acts.SetActState(19, false, true, Language.GetHtml("Threesome", Language.actNode), 0, 1, "3");
	acts.SetActState(21, false, true, Language.GetHtml("Orgy", Language.actNode), 0, 1, "R");
	acts.SetActState(23, false, true, Language.GetHtml("Kiss", Language.actNode), 0, 1, "I");
	acts.SetActState(24, false, true, "", 0, 1, "Z");
	acts.SetActState(8, false, true, Language.GetHtml("Masturbate", Language.actNode), 0, 1, "U");
	acts.SetActState(7, false, true, Language.GetHtml("AssFuck", Language.actNode), 0, 1, "A");
	acts.SetActState(2, false, true, Language.GetHtml("Touch", Language.actNode), 0, 1, "O");
	acts.SetActState(99, false, true, Language.GetHtml("Blowjob", Language.actNode), 0, 1, "W");
	acts.SetActState(3, false, true, Language.GetHtml("Lick", Language.actNode), 0, 1, "C");
	acts.SetActState(5, false, true, Language.GetHtml("Blowjob", Language.actNode), 0, 1, "J");
	acts.SetActState(6, false, true, Language.GetHtml("TitsFuck", Language.actNode), 0, 1, "T");
	acts.SetActState(11, false, true, Language.GetHtml("Lesbian", Language.actNode), 0, 1, "L");
	acts.SetActState(10, false, true, Language.GetHtml("AnalPlug", Language.actNode), 0, 0, "A");
	acts.SetActState(13, false, true, Language.GetHtml("Naked", Language.actNode), 0, 0, "N");
	acts.SetActState(30, false, true, Language.GetHtml("Footjob", Language.actNode), 0, 1, "Shift+F");
	acts.SetActState(31, false, true, Language.GetHtml("Handjob", Language.actNode), 0, 1, "Shift+H");
	
	acts.SetActState(1017, false, true, Language.BreakLabel, 0, 1, "R");
	acts.ShowAct(1017, true);
	acts.SetActState(1016, false, true, Language.BrothelLabel, 0, 2, "H");
	acts.SetActState(1005, false, true, Language.MakeUpLabel, 0, 1, "M");
	acts.SetActState(1009, false, true, Language.DanceLabel, 50, 2, ", or Shift+N", 8, 18);
	acts.SetActState(1003, false, true, Language.FitnessLabel, 0, 2, "F");
	acts.SetActState(1022, false, true, Language.LibraryLabel, 0, 2, "Y");
	acts.SetActState(1011, false, true, Language.ExposeLabel, 0, 2, "Shift+P");
	acts.SetActState(1019, false, true, Language.GetHtml("ReadABook", Language.actNode), 0, 2, "K");

	acts.SetActState(1043, false, true, Language.GetHtml("Fitness", Language.actNode), 0, 2, "F", undefined, undefined, undefined, undefined, undefined, "#person will exercise.");
	acts.SetActState(1044, false, true, Language.GetHtml("Break", Language.actNode), 0, 2, "R", undefined, undefined, undefined, undefined, undefined, Language.GetHtml("BreakDescription", Language.actNode));
	acts.SetActState(1041, false, true, "Patrol", 0, 2, "T", undefined, undefined, undefined, undefined, undefined, "#person will partol for security, to prevent intruders and slaves escaping.");
	acts.SetActState(1042, false, true, "Play", 0, 2, "P", undefined, undefined, undefined, undefined, undefined, "#person will have some spare time to have fun at whatever they enjoy.");
	acts.SetActState(1045, false, true, "Work the Farm", 0, 2, "A", undefined, undefined, undefined, undefined, undefined, "Your pony-slave #person will work your farm.");
	acts.SetActState(1046, false, true, "For your Brothel", 0, 2, "B", undefined, undefined, undefined, undefined, undefined, "#person will work for your brothel.");
	acts.SetActState(1047, false, true, "For your Onsen", 0, 2, "O", undefined, undefined, undefined, undefined, undefined, "#person will work in your Onsen.");
						
	SetButtonState(SlaveDiscussion.BtnDiscuss, false, true, Language.GetHtml("Discuss", Language.actNode), 0, SlaveTalk, 0, RollOverBtnDiscuss, "D");
	SetButtonState(SlaveDiscussion.BtnSex, false, true, Language.GetHtml("IntimacyFuck", "Buttons"), 0, SlaveSexFuck, 0, RollOverBtnSex, "I");
	SetButtonState(SlaveDiscussion.BtnSexOther, false, true, Language.GetHtml("IntimacyOther", "Buttons"), 0, SlaveSexOther, 0, RollOverBtnSexOther, "M");
	SetButtonState(SlaveDiscussion.BtnOrder, false, true, Language.GetHtml("GiveOrders", "Buttons"), 0, SlaveOrder, 0, RollOverBtnOrder, "O");
	SetButtonState(SlaveDiscussion.BtnAssistant, false, true, Language.GetHtml("BeAssistant", "Buttons"), 0, SlaveAssistant, 0, RollOverBtnAssistant, "A");
	SetButtonState(SlaveDiscussion.BtnMarry, false, true, Language.GetHtml("MarryMe", "Buttons"), 0, SlaveMarry, 0, RollOverBtnMarry, "Y");
	SetButtonState(SlaveDiscussion.BtnTrain, false, true, Language.GetHtml("FullyTrain", "Buttons"), 0, SlaveFullyTrain, 0, RollOverBtnTrain, "F")
	
	SetActButtonDetails();
}

function SetActButtonDetails(sdata:Object)
{
	if (sdata == undefined) sdata = _root;
	var acts:ActInfoList = slaveData.ActInfoBase;
	
	var gnd:Number = sdata.SlaveGender;
	var sm:Boolean = gnd == 1 || gnd == 4;
	var sf:Boolean = gnd != 0 && !sm;
	var cgender:Number = sdata.GenderIdentity;
	var sfe:Boolean = cgender != 0 && cgender != 1 && cgender != 4;
	var iscat:Boolean = sdata.BitFlag1.CheckBitFlag(15) || sdata.BitFlag1.CheckBitFlag(45);
	var isdog:Boolean = sdata.BitFlag1.CheckBitFlag(57) || sdata.BitFlag1.CheckBitFlag(58);
	var lestr:Boolean = sdata.BitFlag1.CheckBitFlag(10);
	var dg:Boolean = sdata.IsDickgirl();
	var cock:Boolean = dg || sm;

	if (sfe) acts.SetActState(17, sdata.IsPonygirl(), (sdata.DoneMaster == 1), Language.GetHtml("Ponygirl", Language.actNode), 0, 1, "Y");
	else acts.SetActState(17, sdata.IsPonygirl(), (sdata.DoneMaster == 1), Language.GetHtml("Ponyboy", Language.actNode), 0, 1, "Y");
	
	if (SMData.IsDominatrix()) {
		if (SMData.IsWeaponClassOwned("whip")) acts.SetActState(18, false, true, Language.GetHtml("Whip", Language.actNode));
		else acts.SetActState(18, false, true, Language.GetHtml("Hurt", Language.actNode));
	} else acts.SetActState(18, false, true, Language.GetHtml("Spanking", Language.actNode));

	acts.SetActState(9, false, sdata.DildoOK == 1 || sdata.ImprovedDildoOK == 1, Language.GetHtml("Dildo", "Equipment"));
	acts.SetActState(12, false, SMData.RopesOK == 1, Language.GetHtml("Bondage", Language.actNode));
	acts.SetActState(15, false, true, Language.GetHtml("GangBang", Language.actNode));
	acts.SetActState(20, false, true, "69");
	acts.SetActState(25, false, true, Language.GetHtml("CumBath", Language.actNode));
	acts.SetActState(19, false, true, Language.GetHtml("Threesome", Language.actNode));
	acts.SetActState(21, false, true, Language.GetHtml("Orgy", Language.actNode));
	acts.SetActState(23, false, true, Language.GetHtml("Kiss", Language.actNode));
	acts.SetActState(24, false, true, Language.GetHtml("StripTease", Language.actNode));
	acts.SetActState(8, false, true, Language.GetHtml("Masturbate", Language.actNode), 0, 1, "U");
	acts.SetActState(7, false, true, Language.GetHtml("AssFuck", Language.actNode), 0, 1, "A");
	acts.SetActState(2, false, true, Language.GetHtml("Touch", Language.actNode), 0, 1, "O");
	acts.SetActState(30, false, true, Language.GetHtml("Footjob", Language.actNode));
	acts.SetActState(31, false, true, Language.GetHtml("Handjob", Language.actNode));
				
	acts.SetActState(1004, false, true, Language.GetHtml("Discuss", Language.actNode), 0, 1, "D");
	acts.SetActState(1002, false, true, Language.GetHtml("Cleaning", Language.actNode), 0, 2, "G", undefined, undefined, undefined, undefined, undefined, "#person will clean and maintain your home.");
	acts.SetActState(1001, false, true, Language.GetHtml("Cooking", Language.actNode), 0, 2, "C", undefined, undefined, undefined, undefined, undefined, "#person will cook meals for your household.");
	acts.SetActState(1013, false, true, Language.GetHtml("Acolyte", Language.actNode), 0, 2, "A");
	acts.SetActState(1006, false, true, Language.GetHtml("Sciences", Language.actNode), 50, 2, "S", 8, 18);
	acts.SetActState(1007, false, true, Language.GetHtml("Theology", Language.actNode), 50, 2, "T", 8, 18);
	acts.SetActState(1010, false, true, Language.GetHtml("XXX", Language.actNode), 50, 2, "X");
	acts.SetActState(1012, false, true, Language.GetHtml("Restaurant", Language.actNode), 0, 2, "U", 8, 22);
	acts.SetActState(1014, false, true, Language.GetHtml("Bar", Language.actNode), 0, 2, "B");
	acts.SetActState(1015, false, true, Language.GetHtml("SleazyBar", Language.actNode), 0, 2, "Z");
		
	acts.SetActState(1008, false, true, Language.GetHtml("Etiquette", Language.actNode), 50, 2, "E", 8, 18);
	acts.SetActState(1023, false, true, Language.GetHtml("Onsen", Language.actNode), 0, 2, "Q");
	acts.SetActState(1031, false, true, Language.GetHtml("CockMilking", Language.actNode), 0, 2, "");
	acts.SetActState(1032, false, true, Language.GetHtml("Singing", Language.actNode), 50, 2, ". or Shift+G", 8, 18);

	acts.SetActState(2001, false, true, Language.GetHtml("Stables", Language.actNode), 0, 1, "L");
	acts.SetActState(2002, false, true, Language.GetHtml("Tailors", Language.actNode), 0, 1, "I", 8, 18);
	acts.SetActState(2003, false, true, Language.GetHtml("Shop", Language.actNode), 0, 1, "O", 8, 18);
	acts.SetActState(2005, false, true, Language.GetHtml("Visit", Language.actNode), 0, 2, "V");
	acts.SetActState(2004, false, true, Language.GetHtml("Salon", Language.actNode), 0, 1, "N", 8, 18);

	if (lestr && !sm) {
		acts.SetActState(4, false, true, Language.GetHtml("StrapOnFuck", Language.actNode), 0, 1, "F");
		if (SMData.Gender == 2) acts.SetActState(6, false, true, Language.GetHtml("TouchYou", Language.actNode), 0, 1, "F");
		else acts.SetActState(6, false, true, Language.GetHtml("TouchAnotherWoman", Language.actNode), 0, 1, "F");
	} else {
		if (gnd == 1 || gnd == 4) acts.SetActState(4, false, true, Language.GetHtml("WillFuck", Language.actNode), 0, 1, "F");
		else acts.SetActState(4, false, true, Language.GetHtml("Fuck", Language.actNode), 0, 1, "F");
		acts.SetActState(6, false, true, Language.GetHtml("TitsFuck", Language.actNode), 0, 1, "F");
	}
				
	acts.SetActState(14, (sdata.DoneMaster == 1), true, Master, 0, 1, "M");
	if (sdata.IsPonygirl()) {
		acts.SetActState(1003, false, true, Language.RideLabel, undefined, undefined, "I");
		acts.SetActState(1005, false, true, Language.GroomingLabel);
		acts.SetActState(1009, false, true, Language.PrancingLabel);
	} else {
		acts.SetActState(1003, false, true, Language.FitnessLabel);
		acts.SetActState(1005, false, true, Language.MakeUpLabel);
		acts.SetActState(1009, false, true, Language.DanceLabel);
	}
	if (iscat) {
		acts.SetActState(1017, false, true, Language.CatNapLabel);
		acts.SetActState(1022, false, true, Language.CatalogingLabel);
		acts.SetActState(1016, false, true, Language.CatHouseLabel);
		acts.SetActState(1011, false, true, Language.PresentLabel);
		if (!sdata.IsPonygirl()) acts.SetActState(1005, false, true, Language.PreeningLabel);
		acts.SetActState(1030, false, true, Language.GetHtml("TakeAWalk", Language.actNode), 0, 2, "W");
	} else if (isdog) {
		acts.SetActState(1011, false, true, Language.PresentLabel);
		acts.SetActState(1005, false, true, Language.GroomingLabel);
		acts.SetActState(1030, false, true, Language.GetHtml("Walkies", Language.actNode), 0, 2, "W");
		acts.SetActState(4, false, true, Language.GetHtml("DoggyStyle", Language.actNode));
	} else {
		acts.SetActState(1017, false, true, Language.BreakLabel);
		acts.SetActState(1022, false, true, Language.LibraryLabel);
		acts.SetActState(1016, false, true, Language.BrothelLabel);
		acts.SetActState(1011, false, true, Language.ExposeLabel);
		acts.SetActState(1030, false, true, Language.GetHtml("TakeAWalk", Language.actNode), 0, 2, "W");
	}

	var totbk:Number = 0;
	var totbkrd:Number = 0;
	for (var ib:Number = 0; ib < 32; ib++) {
		if (SMData.OtherBooks.CheckBitFlag(ib)) totbk++;
		if (SMData.OtherBooks.CheckBitFlag(ib+32)) totbkrd++;
	}
	if ((totbk + SMData.TotalBooks + SMData.TotalPoetry + TotalScrolls + TotalScripture + TotalKamasutra - Math.floor(sdata.TotalBooksRead / 2) - Math.floor(sdata.TotalPoetryRead / 2) - sdata.TotalScrollsRead - sdata.TotalScriptureRead - sdata.TotalKamasutraRead - totbkrd) > 0) acts.SetActState(1019, false, true, Language.GetHtml("ReadABook", Language.actNode));
	else acts.SetActState(1019, false, false, Language.GetHtml("ReadABook", Language.actNode));

	if (cock) {
		if (lestr && !sm) {
			if (SMData.Gender == 2) acts.SetActState(5, false, true, Language.GetHtml("LickYou", Language.actNode));
			else acts.SetActState(5, false, true, Language.GetHtml("LickAnotherWoman", Language.actNode));
		} else acts.SetActState(5, false, true, Language.GetHtml("Blowjob", Language.actNode));
		
		if (sf) acts.SetActState(11, false, true, Language.GetHtml("FuckAWoman", Language.actNode));
		else acts.SetActState(11, false, true, Language.GetHtml("LesbianMale", Language.actNode));
		
		acts.SetActState(3, false, true, Language.GetHtml("GiveBlowjob", Language.actNode));
	} else {
		acts.SetActState(3, false, true, Language.GetHtml("Lick", Language.actNode), 0, 1, "C");
		if (lestr) {
			if (SMData.Gender == 2) acts.SetActState(5, false, true, Language.GetHtml("LickYou", Language.actNode));
			else acts.SetActState(5, false, true, Language.GetHtml("LickAnotherWoman", Language.actNode));
			acts.SetActState(11, false, true, Language.GetHtml("Tribadism", Language.actNode));
		} else {
			acts.SetActState(5, false, true, Language.GetHtml("Blowjob", Language.actNode));
			if (!sf) acts.SetActState(11, false, !SMData.IsDickgirlAmazon(), Language.GetHtml("LesbianMale", Language.actNode));
			else acts.SetActState(11, false, !SMData.IsDickgirlAmazon(), Language.GetHtml("Lesbian", Language.actNode));
		}
	}
	if (SMData.SMFaith == 2) {
		if (!SMAdvantages.CheckBitFlag(15)) acts.SetActState(1013, false, false);
		acts.SetActState(2502, false, true, Language.GetHtml("PractiseYourFaith", Language.actNode), 0, 2, "P");
	} else if (SMData.SMFaith == 1) {
		acts.SetActState(1013, false, true);
		acts.SetActState(2502, false, true, Language.GetHtml("PrayAtChurch", Language.actNode), 0, 2, "P");
	} else {
		acts.SetActState(1013, false, true);
		acts.SetActState(2502, false, true, Language.GetHtml("Meditate", Language.actNode), 0, 2, "P");
	}
	if (sdata.DildoOK == 0 && sdata.ImprovedDildoOK == 0) acts.SetActState(9, false, false);
	else acts.SetActState(9, false, true);

	acts.ShowAct(1031, SMData.SMSpecialEvent == 4 && dg);
	acts.ShowAct(2001, SMData.PonygirlAware > 0);
	acts.ShowAct(12, Options.BDSMOn);
	acts.ShowAct(17, SMData.sPonyTrainer >= 1);  
	acts.ShowAct(6, gnd != 1);
	acts.ShowAct(99, SMData.IsDominatrix() && SMData.Gender == 3);
	
	acts.SetActState(2501, false, true, Language.GetHtml("MartialTraining", Language.actNode), 0, 2, "M");
	acts.SetActState(2503, false, true, Language.GetHtml("RelaxInABar", Language.actNode), 0, 2, "B");
	acts.SetActState(2504, false, true, Language.GetHtml("AttendCourt", Language.actNode), 0, 2, "C");
	acts.SetActState(2505, false, true, Language.GetHtml("SlaveMarket", Language.actNode), 0, 1, "S");
	acts.SetActState(2506, false, true, Language.GetHtml("Armoury", Language.actNode), 0, 1, "A");
	acts.SetActState(2507, false, true, Language.GetHtml("Dealer", Language.actNode), 0, 1, "D");
	acts.SetActState(2508, false, true, Language.GetHtml("ItemSalesman", Language.actNode), 0, 1, "I");
	acts.SetActState(2510, false, true, Language.GetHtml("RelaxInASleazyBar", Language.actNode), 0, 2, "Z");
	acts.SetActState(2517, false, true, Language.GetHtml("SlavesDiscuss", "Buttons"), 0, 1, "Shift+T");

	acts.SetActState(2509, false, true, Language.GetHtml("WorkForTheGuild", Language.actNode), 0, 2, "0", undefined, undefined, undefined, undefined, undefined, "You will work for the Slave Maker Guild doing small jobs or assisting in training others slaves.");
	acts.SetActState(2511, false, true, Language.GetHtml("Nothing", Language.actNode), 0, 1, "H");
	acts.SetActState(2518, false, true, Language.GetHtml("CockMilking", Language.actNode), 0, 2, "1", undefined, undefined, undefined, undefined, undefined, "You will visit Astrid to have your cock milked.");
	if (SMData.SMAdvantages.CheckBitFlag(8)) acts.SetActState(2519, false, true, Language.GetHtml("WorkInABrothel", Language.actNode), 0, 2, "2", undefined, undefined, undefined, undefined, undefined, "You will work a shift in your own brothel. A familiar and pleasurable job for you.");
	else acts.SetActState(2519, false, true, Language.GetHtml("WorkInABrothel", Language.actNode), 0, 2, "2", undefined, undefined, undefined, undefined, undefined, "You will work a shift in a brothel. A fun job for you.");
	acts.SetActState(2520, false, true, Language.GetHtml("TradeGoods", Language.actNode), 0, 2, "3", undefined, undefined, undefined, undefined, undefined, "You will setup a small stall in the market and trade small items.")
	if (SMData.Gender == 1) acts.SetActState(2521, false, true, Language.GetHtml("WorkAsMaster", Language.actNode), 0, 2, "4", undefined, undefined, undefined, undefined, undefined, "You will work in a brothel giving pain and pleasure to your customers.");
	else acts.SetActState(2521, false, true, Language.GetHtml("WorkAsDominatrix", Language.actNode), 0, 2, "5", undefined, undefined, undefined, undefined, undefined, "You will work in a brothel giving pain and pleasure to your customers.");
	acts.SetActState(2522, false, true, Language.GetHtml("MakePotions", Language.actNode), 0, 2, "6", undefined, undefined, undefined, undefined, undefined, "You will make potions and sell them to fellow slave makers or members of the general public.");
	acts.SetActState(2523, false, true, Language.GetHtml("PreachTheOldFaith", Language.actNode), 0, 2, "7", undefined, undefined, undefined, undefined, undefined, "You will preach the ways of the Old Faith accepting gifts and tithes.");
	acts.SetActState(2524, false, true, Language.GetHtml("WorkForMilitia", Language.actNode), 0, 2, "8", undefined, undefined, undefined, undefined, undefined, "You will work for the city militia patrolling the city and arresting criminals.");
	acts.SetActState(2525, false, true, Language.GetHtml("WorkInASleazyBar", Language.actNode), 0, 2, "9", undefined, undefined, undefined, undefined, undefined, "You will work in a Sleazy Bar, entertaining and serving guests.");

	acts.ShowAct(2509, SMData.GuildMember);
	acts.ShowAct(2518, SMData.SMSpecialEvent == 4);
	acts.ShowAct(2519, SMData.SMAdvantages.CheckBitFlag(8) || SMData.SMAdvantages.CheckBitFlag(4));
	acts.ShowAct(2520, SMData.SMAdvantages.CheckBitFlag(2));
	acts.ShowAct(2521, SMData.IsDominatrix());
	acts.ShowAct(2522, SMData.SMAdvantages.CheckBitFlag(7) && SMData.Gender != 1);
	acts.ShowAct(2523, SMData.SMAdvantages.CheckBitFlag(7));
	acts.ShowAct(2524, SMData.SMAdvantages.CheckBitFlag(3));
	acts.ShowAct(2525, SMData.SMAdvantages.CheckBitFlag(4));
		
	acts.ShowAct(2507, SMData.BitFlagSM.CheckBitFlag(13));
	acts.ShowAct(2508, SMData.BitFlagSM.CheckBitFlag(12));
	acts.ShowAct(2516, ShowSMCustomTrainingOK == 1);
}
