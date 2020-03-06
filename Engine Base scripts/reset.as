import Scripts.Classes.*;

// Reset details
function ResetGame()
{
	SMTRACE("ResetGame");

	GameDate = 1;
	MoonPhaseDate = Math.floor(Math.random()*14) + 1;
	dmod = 1;
	imgCallback = null;
	VarGold = 0;
	bNocturnal = false;
	ResetEventPicked();
	ResetAssistant();
	
	LoadedSlaves.ClearLoadedSlaves();	
	
	//HouseEvents.ResetCustomHouses();
	//AddCustomHouse();
	
	Items.Reset();
	
	planActs.Reset();
	delete planActs;
	planActs = new PlannableActions(coreGame);
	
	Reset();
	
	RuinedTemple = null;
	
	citiesList.Reset();
	
	bAllowEvents = true;
	currentShop = null;
}

function ResetSlaveMaker()
{
	
	// Base slavemaker objects
	SlavesArray = null;
	Diary = null;
	
	SMData.Destroy();
	delete SMData;
	SMData = new SlaveMaker(coreGame);
	SMAvatar.ResetList(SMData);
		
	SMData.CopySlaveMakerDetails(SMData, _root);
	
	// create references to SMData
	SMInitialItems = SMData.SMInitialItems;
	SMSkills = SMData.SMSkills;
	SMAdvantages = SMData.SMAdvantages;
	BitFlagSM = SMData.BitFlagSM;
	OtherBooks = SMData.OtherBooks;
	Diary = SMData.Diary;
	SlavesArray = SMData.SlavesArray;
	
	XMLData.Reset();

	HouseEvents.InitialiseModule();
	Items.InitialiseModule();
	currentCity.InitialiseModule();
	Potions.InitialiseModule();
	Rules.InitialiseModule();
	SelectEquipment.InitialiseModule(null);
	SelectSMEquipment.InitialiseModule(null);
	SlavePicker.InitialiseModule();
	LoadSave.InitialiseModule();
	Hints.InitialiseModule();
	Information.InitialiseModule();
	modulesList.InitialiseModule();
	dspMain.Reset();
	
	ShowSMCustomTrainingOK = 0;
	StatRate = 1;		
	MaxStat = 300;
	
	EndGame.Reset();
}


function ResetSlave(noimage:Boolean) 
{	
	trace("ResetSlave");
	XMLData.Reset();
	XMLData.SetCurrentSlaveXML(null);
	HouseEvents.ResetExploring();
	
	SpecialIndex = undefined;
	currFrame = 0;
	EventTotal = 0;
	
	UseImages = false;
	bControl = false;
	SlaveName = "";
	SlaveName1 = "";
	SlaveName2 = "";
	Titles = "";
	DressToWear = 0;
	NakedChoice = 0;
	
	Trust = -1;
	TotalScrolls = 0;
	TotalScripture = 0;
	TotalKamasutra = 0;
	
	slCombat = 0;
	slCourtesan = 0;
	slPonyTraining = 0;
	slCatTraining = 0;
	slPuppyTraining = 0;
	slSlutTraining = 0;
	FairyXF = 0;
	slSeduction = 0;
	CumslutLevel = 0;
	slSuccubusTraining = 0;
	nWideMode = config.nDefaultWideScreenMode;

	slaveData.ClearSlaveSkillArray();
	
	if (noimage != true) {
		var i:Number = arAutoLoadedMovieArray.length;
		if (i == undefined) i = 0;
		while (i > 0) {
			var mc:MovieClip = MovieClip(arAutoLoadedMovieArray.pop());
			mc.removeMovieClip();
			delete mc;
			i--;
		}
		delete arAutoLoadedMovieArray;
		arAutoLoadedMovieArray = new Array();
	}
	
	Sounds.StopAllSounds(true);
	
	DemonicBraDescription = Language.GetText("DemonicBraDescription", "Equipment");
	DemonicPendantDescription = Language.GetText("DemonicPendantDescription", "Equipment");
	DemonicPendantDescriptionOF = Language.GetText("DemonicPendantDescriptionOF", "Equipment");
	LeashPonyDescription = Language.GetText("LeashPonyDescription", "Equipment");
	LeashDescription = Language.GetText("LeashDescription", "Equipment");

	SlaveCombatDescription = "";
	
	GameTimeMins = 420;
	NumFin = 0;
	Day = true;
	TrainingTime = 60;
	TrainingStart = GameDate;
	Supervise = false;
	PersonShown = -3;
	OwnerTesting = SMData.GuildMember;
	OwnerTestingUrgent = false;
	Lesbian = false;
	Owner = null;
	SoldSlave = undefined;
	
	Rules.Reset();
	
	BiyakuEffecting = 0;
	IshinaiEffecting = 0;
	DoreiEffecting = 0;
	ZodaiEffecting = 0;
	GamanEffecting = 0;
	OrgasmDrugEffecting = 0;
	DrugDuration = 0;
	DrugAddicted = 0;
	NumAddictionLevel = 0;
	AddictionLevel = 0;
	
	ResetNotFucked();
	
	LastActionRefused = 0;
	LastActionDone = 0;
	DoneEvent = 0;
	DoneSpank = 0;
	DoneNaked = 0;
	DonePlug = 0;
	LendPerson = 0;
	DoneScold = false;
	BadGirl = 0;
	AntidoteDays = 0;
	SlaveLikeServant = true;
	Lectures = 0;
	Behaving = 0;
	WinContest = 0;
	PlugInserted = 0;
	LastVisitDickgirl = GameDate - 5;
	
	dspMain.Reset();
	
	ServantFilename = "";
	ServantName = "";
	
	Assisting = false;
	AsEvent = false;

	SavedDayPlannings1.Reset();
	SavedDayPlannings2.Reset();
	SavedDayPlannings3.Reset();
	SavedNightPlannings1.Reset();
	SavedNightPlannings2.Reset();
	SavedNightPlannings3.Reset();
	Plannings.Reset(slaveData);
	
	Icons.Reset();

	SetActButtonDetailsStartup();
	
	SelectEquipment.StartNewSlave();

	Hints.HideHints();
	
	currentCity.StartNewSlave();

	IntroPage = 1;
	IntroPages = 1;
	
	AnySex = false;
	AnyNonSex = false;
	LastAny = -10;
	
	ShowCustomJob1 = 0;
	ShowCustomJob2 = 0;
	ShowCustomJob3 = 0;
	ShowCustomSchool1 = 0;
	ShowCustomSchool2 = 0;
	ShowCustomSchool3 = 0;
	ShowCustomChore1 = 0;
	ShowCustomChore2 = 0;
	ShowCustomChore3 = 0;
	ShowCustomSex1 = 0;
	ShowCustomSex2 = 0;
	ShowCustomSex3 = 0;
	ShowCustomSex4 = 0;
	
	ShowCustomContestOK = 0;
	CustomContestLabel = "";
	CustomContestDescription = "";
	
	TentacleHaunt = -1;
	AssistantTentacleFrequency = -1;
	MaxTentacleHarem = 1;
	
	FirstTimeTodayBreak = true;
	FirstTimeTodayBrothel = true;
	FirstTimeTodayAcolyte = true;
	FirstTimeTodaySleazyBar = true;
	FirstTimeTodayDiscuss = true;
	FirstTimeTodayTheology = true;
	FirstTimeTodayRestaurant = true;
	FirstTimeTodayBar = true;
	FirstTimeTodaySciences = true;
	FirstTimeTodaySinging = true;
	FirstTimeTodaySwimming = true;
	FirstTimeTodayDance = true;
	FirstTimeTodayRefinement = true;
	FirstTimeTodayWalk = true;
	FirstTimeTodayXXX = true;
	FirstTimeTodayCooking = true;
	FirstTimeTodayCleaning = true;
	FirstTimeTodayExpose = true;
	FirstTimeTodayMakeup = true;
	FirstTimeTodayCustomJob1 = true;
	FirstTimeTodayCustomJob2 = true;
	FirstTimeTodayCustomJob3 = true;
	FirstTimeTodayLibrary = true;
	FirstTimeTodayOnsen = true;
	FirstTimeTodayCockMilking = true;
	FirstTimeTodayCustomChore1 = true;
	FirstTimeTodayCustomChore2 = true;
	FirstTimeTodayCustomChore3 = true;
	FirstTimeTodayCustomSchool1 = true;
	FirstTimeTodayCustomSchool2 = true;
	FirstTimeTodayCustomSchool3 = true;
	FirstTimeTodaySMJob = true;
	TotalBondageToday = 0;
	TotalBlowJobToday = 0;
	TotalAnalToday = 0;

	NumMerchant = 0;
	
	SlaveFemale = true;
	
	temp = Math.floor(Math.random()*2) + 1;
	ObjectTiara.gotoAndStop(temp);
	DressNymphsTiara.gotoAndStop(temp);
	DressNymphsTiaraCR.gotoAndStop(temp);
	
	delete Participants;
	Participants = new Array();
	
	SetSlave1Items();
	
	slaveData = null;
}
