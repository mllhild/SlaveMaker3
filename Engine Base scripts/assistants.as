import Scripts.Classes.*;
import flash.display.BitmapData;

// Assistant

// public variables
var ServantFilename:String = "";
var ServantName:String;
var ServantName1:String;
var ServantName2:String;
var SlaveLikeServant:Boolean;
var ServantMaster:String;
var AssistantCost:Number;
var AssistantReputation:Number;
var AssistantTentacleSex:Boolean;
var AssistantRape:Boolean;
var AssistantDescription:String;
var AssistantDescriptionBase:String = "";
var AssistantFurryNeeded:Boolean;
var AssistantTentaclesNeeded:Boolean;
var AssistantVersion:String;
var AssistantCredits:String;
var AssistantLoadLanguage:XML;
var AssistantVanilla:Boolean;

// Private
var bAssistantLoaded:Boolean = false;
var oldfileAssistant:String;
var changeloadstart:Boolean = false;
var dateLastChangedAssistant:Number;

var mclListenerAssistant:Object = new Object();
var mcLoaderAssistant:MovieClipLoader = new MovieClipLoader();

// General functions

function ServantActAssess(type:Number, difficulty:Number, description:String, newl:Boolean)
{
	if (newl != false) ServantSpeakStart(description, true);
	else AddText(description);
	
	if (ServantName != "" && !TestObedience(difficulty)) {
		if (AssistantData.VarIntelligence > 49) {
			BlankLine();
			if (TestObedience(difficulty - 5)) Language.AddLangText("AssessMaybe", assNode);
			else Language.AddLangText("AssessUnlikely", assNode);
		}
	}
	ServantSpeakEnd();
}

var ServantA:String;
var ServantB:String;
function GetServantAB()
{
	if ((Math.random()*2) < 1) {
		ServantA = ServantName1;
		ServantB = ServantName2;
	} else {
		ServantA = ServantName2;
		ServantB = ServantName1;
	}
}


// ShowAssistant - shows a graphic for the assistant
// 1 = normal view in small rectangle
// 2 = tentacle sex (small version shown when slave girl raped)
// 3 = raped
// 4 = ignore this (shown when assistant is absent)
// 5 = wet - she falls in some water
// 6 = large graphic shown when your slave runs away	
function ShowAssistant(type:Number)
{
	if (IsNoAssistant()) {
		if (type == 1) SMData.ShowSlaveMaker();
		else if (type == 2) SMData.ShowSlaveMaker(-10000, 0, 1);
		else if (type == 3) SMData.ShowSlaveMaker(-10016, 0, 1);
		else if (type == 6) SMData.ShowSlaveMaker(0, 1, 1);
		else SMData.ShowSlaveMaker();
		return;
	}
	AssistantBackground._visible = type == 4;
	CurrentAssistant.HideAsAssistant();
	if (type != 4) {
		if (type == undefined) type = 1;
		if (type != 6) SMAppearance._visible = false;
		// inlined XMLEventCached
		genNumber = type;
		if (assshNode == null) {
			assshNode = GetNode(assNode, "ShowAsAssistant");
			if (assshNode == null) assshNode = GetNode(flNode, "ShowAsAssistant");
		}
		if (!XMLEventByNode(assshNode, false, undefined, true, true)) CurrentAssistant.ShowAsAssistant(type);
		OnTopOverlayWhite2._visible = false;
	} else SMAppearance._visible = false;
	PersonShown = -99;
	if (type > 3) SMAppearance.pplace = 1;
	else SMAppearance.pplace = 0;
}

function ShowAssistantSoon()
{
	intervalId3 = setInterval(_root, "ShowAssistantDelayed", 200);
}

function ShowAssistantDelayed()
{
	clearInterval(intervalId3);
	ShowAssistant();
	WalkZoom._visible = false;
}

function HideAssistant()
{
	AssistantBackground._visible = false;
	CurrentAssistant.HideAsAssistant();
	PersonShown = -3;
}

function ResetAssistant()
{
	ServantName = "";
	ServantName1 = "";
	ServantName2 = "";
	AssistantVersion = "";
	AssistantCredits = "";
	if (SMData.Gender != 1) ServantMaster = "Mistress";
	else ServantMaster = "Master";
	ServantPronoun = Language.GetHtml("Pronoun", gndNode);
	ServantGender = 2;
	ServantHeShe = "she";
	ServantHimHer = "her";
	AssistantTentacleFrequency = -1;
	AssistantCost = 100;
	AssistantReputation = 0;
	AssistantDescription = "";
	if (AssistantDescriptionBase == "") AssistantDescriptionBase = Language.GetHtml("SlaveMakerHire", "SlaveMarket");
	
	AssistantRape = true;
	AssistantTentacleSex = true;
	AssistantVanilla = true;
	AssistantFurryNeeded = false;
	AssistantTentaclesNeeded = false;
	dspMain.SystemMenu.SetAssistantDetails(AssistantVersion, AssistantCredits);
	AssistantData = null;
	CurrentAssistant = null;
}

function DismissAssistant()
{
	ResetAssistant();
	CurrentAssistant.DestroyAsAssistant();
	CurrentAssistant = null;
	modulesList.CurrentAssistant = null;
	UpdateSupervision(true);
}

function IsNoAssistant() : Boolean { return ServantName == ""; }

function IsAssistant(aname:String) : Boolean
{
	if ((aname == "" || aname == undefined) && ServantName == "") return true;
	aname = aname.toLowerCase();
	if (ServantFilename.toLowerCase() == ("slaves/slave-" + aname + ".swf")) return true;
	if (ServantFilename.toLowerCase() == ("slaves/slave-" + aname + ".xml")) return true;
	if (ServantFilename.toLowerCase() == ("assistants/assistant-" + aname + ".swf")) return true;
	if (ServantFilename.toLowerCase() == ("assistants/assistant-" + aname + ".xml")) return true;
	if (AssistantData.IsSlave(aname)) return true;
	var sl:Array = aname.split(" ");
	if (sl.length > 1) return IsAssistant(sl[sl.length - 1]);
	return false;
}


// Change assistant

function ChangeAssistantByFilename(assistantfile:String, loading:Boolean)
{
	SMTRACE("Change assistant: " + assistantfile + " " + loading);
	changeloadstart = loading;
	ResetAssistant();
	if (loading != true) {
		delete oldfileAssistant;
		oldfileAssistant = new String(ServantFilename);
	}
	var ext:String = assistantfile.substr(-4);
	var assArray:Array = assistantfile.slice(0, -4).split("-");
	if (ext == "") ext = ".xml";
	if (assistantfile != "" && ext != ".xml") {
		ext = ".swf";
		assistantfile = assistantfile.substr(0, assistantfile.length-4) + ext;
	}
	var ServantFilename2:String = "Assistants/Assistant-" + assArray[1] + ext;
	ServantFilename = assistantfile;
	if (assistantfile != "") {
	
		var sd:Slave = SMData.GetSlaveDetails(assistantfile, true);
		if (sd == null) {
			var obj:Object = SlaveList.GetAssistantListDetails(assistantfile);
			if (obj != null) {
				sd = SMData.GetSlaveDetails("Assistants/" + obj.AssistantFile, true);
				if (sd == null) {
					CreateAssistantFull("Assistants/" + obj.AssistantFile, obj.xmlload);
					AssistantData.SlaveIndex = SlavesArray.length;
					SlavesArray.push(AssistantData);
					sd = AssistantData;
				}
			}
		}
		AssistantData = sd;
	
		if (bAssistantLoaded) {
			if (oldfileAssistant == assistantfile) {
				if (oldfileAssistant == ServantFilename2) ServantFilename = ServantFilename2;
				ChangeServantLoadDone();
				return;
			}
		}
	}
	CurrentAssistant.DestroyAsAssistant();
	ShowMovie(OnTopOverlay, 12, 0);
	SetLastMovieColourARGB(0x315031);
	LoadedAssistant.unloadMovie();
	
	if (ServantFilename == "") {
		CreateNoAssistant();
		return;
	}
	
	SMTRACE("Load assistant: " + ServantFilename);
	mclListenerAssistant.onLoadInit = ChangeServantLoadDone;
	mclListenerAssistant.onLoadError = ChangeBadServantName;
	mcLoaderAssistant.addListener(mclListenerAssistant);
	if (ext == ".xml") ChangeServantLoadDone();
	else mcLoaderAssistant.loadClip(ServantFilename, LoadedAssistant);

}

function CreateNoAssistant()
{
	trace("Using no assistant");
	ServantGender = 0;
	Supervise = true;
	SuperviseYourself = true;
	ServantPronoun = NameCase(Language.GetHtml("PersonYou", "People"));
	Language.ChangeLanguage(!LoadSave.IsGameInProgress(), "ChangeServantLoadDone3");
	SMData.BuildOwnedSlaves();
}

function ChangeAssistant(assistant:Object, loading:Boolean)
{
	trace("ChangeAssistant: " + assistant);
	var sd:Slave = null;
	if (typeof(assistant) == "string") {
		sd = SMData.GetSlaveDetails(String(assistant), true);
		if (sd == null) {
			var obj:Object = SlaveList.GetAssistantListDetails(String(assistant));
			if (obj != null) {
				sd = SMData.GetSlaveDetails("Assistants/" + obj.AssistantFile, true);
				if (sd == null) {
					ChangeAssistantByFilename("Assistants/" + obj.AssistantFile, loading);
					return;
				}
				sd = AssistantData;
			}
		}
	} else if (assistant != undefined) sd = Slave(assistant);
	if (sd != null && sd.SlaveFilename != "") {
		ChangeAssistantByFilename(sd.SlaveFilename, loading);
		return;
	}
	
	SMTRACE("Change assistant(object): " + sd.SlaveName);
	changeloadstart = loading;
	ResetAssistant();
	if (loading != true) {
		delete oldfileAssistant;
		if (ServantFilename == "") oldfileAssistant = new String(sd.SlaveImage);
		else oldfileAssistant = new String(ServantFilename);
	}
	ServantFilename = "";

	CurrentAssistant.DestroyAsAssistant();
	LoadedAssistant.unloadMovie();
	
	AssistantData = sd;
	
	if (sd == null) {
		CreateNoAssistant();
		return;
	}
	
	bAssistantLoaded = true;
	
	CurrentAssistant = modulesList.CreateSlaveModuleClassFromFilename("", LoadedAssistant, AssistantData, coreGame);
	modulesList.CurrentAssistant = CurrentAssistant;
	CurrentAssistant.InitialiseModule();
	
	CurrentAssistant.Assisting = true;
	CurrentAssistant.AsEvent = false;
	ServantName1 = "";
	ServantName2 = "";
	CurrentAssistant.Naked = false;
	CurrentAssistant.Lesbian = false;
	CurrentAssistant.Aroused = false;
	
	CurrentAssistant.ImageFolder = AssistantData.ImageFolder;
	AssistantData.sNode = null;
	AssistantData.sNode = XMLData.GetSlaveXML(undefined, AssistantData);

	Language.ChangeLanguage(!LoadSave.IsGameInProgress(), "ChangeServantLoadDone");
}

function ChangeBadServantName(target_mc:MovieClip, errorCode:String, httpStatus:Number)
{
	clearInterval(intervalId);
	if (!Language.IsLoaded()) {
		intervalId = setInterval(_root, "ChangeBadServantName", 40, target_mc, errorCode, httpStatus);
		return;
	}
	var newName:String = "Assistants/Assistant" + ServantFilename.substr(12);
	ServantFilename = newName;
	mcLoaderAssistant.removeListener(mclListenerAssistant);
	mclListenerAssistant.onLoadInit = ChangeServantLoadDone;
	mclListenerAssistant.onLoadError = ChangeBadServantNameShampoo;
	mcLoaderAssistant.addListener(mclListenerAssistant);
	mcLoaderAssistant.loadClip(ServantFilename, LoadedAssistant);
}

function ChangeBadServantNameShampoo(target_mc:MovieClip, errorCode:String, httpStatus:Number)
{
	clearInterval(intervalId);
	if (!Language.IsLoaded()) {
		intervalId = setInterval(_root, "ChangeBadServantNameShampoo", 20, target_mc, errorCode, httpStatus);
		return;
	}
	ServantFilename = "Slaves/Slave-Shampoo.swf";
	mcLoaderAssistant.removeListener(mclListenerAssistant);
	mclListenerAssistant.onLoadInit = ChangeServantLoadDone;
	mclListenerAssistant.onLoadError = ChangeBadServantName;
	mcLoaderAssistant.addListener(mclListenerAssistant);
	mcLoaderAssistant.loadClip(ServantFilename, LoadedAssistant);
}

function ChangeServantLoadDone()
{
	trace("ChangeServantLoadDone: " + AssistantData + " " + AssistantData.SlaveName);
	bAssistantLoaded = true;
	CurrentAssistant = modulesList.CreateSlaveModuleClassFromFilename(ServantFilename, LoadedAssistant, AssistantData, coreGame);
	if (CurrentAssistant == undefined || CurrentAssistant == null) {
		CurrentAssistant = LoadedAssistant;
		CurrentAssistant.mcBase = LoadedAssistant;
		CurrentAssistant.slaveData = AssistantData;
		CurrentAssistant.sd = AssistantData;
		CurrentAssistant.SMData = SMData;
		CurrentAssistant.Diary = Diary;
		CurrentAssistant.coreGame = coreGame;
	}
	modulesList.CurrentAssistant = CurrentAssistant;
	CurrentAssistant.InitialiseModule();
	CurrentAssistant.HideAsAssistant();
	CurrentAssistant.HideImages();
	CurrentAssistant.HideEndings();
	CurrentAssistant.HideDresses();
	CurrentAssistant.HideRobes();
	CurrentAssistant.HideSlaveActions();
	
	CurrentAssistant.Assisting = true;
	CurrentAssistant.AsEvent = false;
	ServantName1 = "";
	ServantName2 = "";
	CurrentAssistant.Naked = false;
	CurrentAssistant.Lesbian = false;
	CurrentAssistant.Aroused = false;
	
	if (AssistantData == null) AssistantData = SMData.GetSlaveDetails(ServantFilename, true);
	if (AssistantData == null) {
		CreateAssistantFull(ServantFilename, undefined, XMLData.GetSlaveXML(ServantFilename));
		CurrentAssistant.slaveData = AssistantData;
		CurrentAssistant.sd = AssistantData;
	}
	CurrentAssistant.ImageFolder = AssistantData.ImageFolder;
	CurrentAssistant.slaveData = AssistantData;
	
	SMData.BuildOwnedSlaves();
	
	Language.ChangeLanguage(!LoadSave.IsGameInProgress(), "ChangeServantLoadDone2");;
}
	
function ChangeServantLoadDone2()
{
	trace("ChangeServantLoadDone2: " + AssistantData + " " + AssistantData.SlaveName + " " + ServantFilename + " " + CurrentAssistant);
	if (AssistantData == null) {
		CreateAssistantFull(ServantFilename, undefined, XMLData.GetSlaveXML(ServantFilename));
		CurrentAssistant.ImageFolder = AssistantData.ImageFolder;
		CurrentAssistant.slaveData = AssistantData;
		CurrentAssistant.sd = AssistantData;
	} else if (ServantFilename.substr(-4) == ".swf") {
		CurrentAssistant.ImageFolder = AssistantData.ImageFolder;
		CurrentAssistant.InitialiseModule();
		LoadedAssistant._visible = true;
		
		var mc:MovieClip = CurrentAssistant.InitialiseAsAssistant(true, true);
		mc._visible = false;
		mc.hide = true;
		CurrentAssistant.HideImages();
		CurrentAssistant.HideEndings();
		CurrentAssistant.HideDresses();
		CurrentAssistant.HideRobes();
		CurrentAssistant.HideSlaveActions();
				
		if (mc == undefined) {
			mc = LoadedAssistant.InitialiseAsAssistant(true, true);
			LoadedAssistant.HideImages();
			LoadedAssistant.HideAsAssistant();
			LoadedAssistant.HideEndings();
			LoadedAssistant.HideDresses();
			LoadedAssistant.HideRobes();
			LoadedAssistant.HideSlaveActions();
			mc._visible = false;
		}
	}

	AssistantData.sNode = null;
	AssistantData.sNode = XMLData.GetSlaveXML(undefined, AssistantData);
	var aNode:XMLNode = AssistantData.sNode;

	if (AssistantData == null || AssistantData.SlaveType == -100) {
		trace("ADD SLAVE: (ChangeServantLoadDone2) - " + ServantFilename);
		CreateAssistant(CurrentAssistant, aNode, ServantFilename);
		AssistantData.SlaveIndex = SlavesArray.length;
		SlavesArray.push(AssistantData);
		AssistantData.SlaveIndex = SlavesArray.length;
	} else {
		if (AssistantData.SlaveType > -1) AssistantCost = 0;
		CurrentAssistant.InitialiseOnlyAsAssistant(false);
	}
	PersonIndex = -99;
	if (ServantFilename == "") {
		XMLData.InitialiseAssistantXML(AssistantData.sNode);
		XMLData.InitialiseCommonXML(AssistantData.sNode, false);
	} else {
		XMLData.InitialiseAssistantXML(aNode);
		XMLData.InitialiseCommonXML(aNode, false);
	}
	
	CurrentAssistant.ImageFolder = AssistantData.ImageFolder;
	CurrentAssistant.HideAsAssistant();
	CurrentAssistant.HideEndings();
	CurrentAssistant.HideDresses();
	CurrentAssistant.HideRobes();
	CurrentAssistant.HideSlaveActions();

	if (AssistantData.SlaveType == 2) AssistantCost = int(AssistantCost * 0.67);
	
	AssistantData.LoadActImages(aNode);

	AssistantData.ActInfoCurrent = AssistantData.ActInfoBase;
	AssistantData.ActInfoBase.ActFolder = AssistantData.ImageFolder;

	if (ServantHeShe == "he" || ServantHimHer == "him" && ServantGender == 2) AssistantData.SlaveGender = 1;
	ServantName = AssistantData.SlaveName;
	ServantName1 = AssistantData.SlaveName1;
	ServantName2 = AssistantData.SlaveName2;
	ServantGender = AssistantData.SlaveGender;
	if (AssistantData.SlaveImage == "") AssistantData.SlaveImage = AssistantData.ImageFolder + "/Assistant.png";
	if (AssistantData.SlaveImage == "") AssistantData.SlaveImage = ServantFilename;
	if (AssistantData.DickgirlXF > 0) ServantGender = ServantGender > 3 ? 6 : 3;
	if (AssistantData.ClitCockSize == 0) AssistantData.ClitCockSize = 0.6;
	if (ServantName1 == "") ServantName1 = ServantName;
	if (ServantName2 == "") ServantName2 = ServantName;
	if (AssistantDescription != "") AssistantData.vitalsDescription = AssistantDescription;
	else AssistantDescription = AssistantData.vitalsDescription;
		
	dspMain.SystemMenu.SetAssistantDetails(AssistantVersion, AssistantCredits);

	CurrentAssistant.ServantName = ServantName;
	CurrentAssistant.ServantGender = ServantGender;
	ChangeAssistantGender();
	OnTopOverlay._visible = false;
	
	ChangeServantLoadDone3();
}

function ChangeServantLoadDone3()
{
	trace("ChangeServantLoadDone3: " + changeloadstart); 
	if (changeloadstart == true) ResumeShow();
	else {
		dateLastChangedAssistant = GameDate;
		if (changeloadstart == false) ShowGirlsStory();
	}
}

function CreateAssistantFull(fname:String, xmlload:XML, node:XMLNode) 
{
	// create the assistant
	ServantFilename = fname;
	var aNode:XMLNode = node == undefined ? XMLData.GetNodeC(xmlload.firstChild.firstChild, "Assistant") : node;

	var sm:SlaveModule = modulesList.CreateSlaveModuleClassFromFilename(ServantFilename, LoadedAssistant, AssistantData, coreGame);
	if (sm == undefined || sm == null) {
		sm = LoadedAssistant;
		sm.mcBase = LoadedAssistant;
		sm.slaveData = AssistantData;
		sm.coreGame = coreGame;
	}
	CreateAssistant(sm, aNode, ServantFilename);
	delete sm;
}

function CreateAssistant(sm:SlaveModule, aNode:XMLNode, strFilename:String)
{
	ResetAssistant();
	AssistantData = new Slave(coreGame);
	AssistantData.SlaveType = -1;
	AssistantData.SlaveName = ServantName;
	AssistantData.SlaveGender = ServantGender;
	AssistantData.SlaveFilename = strFilename;
	if (AssistantDescriptionBase == "") AssistantDescriptionBase = Language.GetHtml("SlaveMakerHire", "SlaveMarket");
	AssistantData.vitalsDescription = AssistantDescriptionBase;
	
	AssistantData.VarCharisma = 30;
	AssistantData.VarSensibility = 30;
	AssistantData.VarRefinement = 30;
	AssistantData.VarIntelligence = 30;
	AssistantData.VarMorality = 20;
	AssistantData.VarConstitution = 40;
	AssistantData.VarCooking = 20;
	AssistantData.VarCleaning = 20;
	AssistantData.VarConversation = 30;
	AssistantData.VarBlowJob = 30;
	AssistantData.VarFuck = 30;
	AssistantData.VarTemperament = 50;
	AssistantData.VarNymphomania = 20;
	AssistantData.VarObedience = 40;
	AssistantData.VarLibido = 40;
	AssistantData.VarReputation = 30;
	AssistantData.VarJoy = 0;
	AssistantData.FatigueBonus = 20;
	AssistantData.ClitCockSize = 0.6;
	AssistantData.vitalsBust = 90;
	AssistantData.vitalsWaist = 54;
	AssistantData.vitalsHips = 85;
	AssistantData.vitalsAge = 24;
	AssistantData.vitalsBloodType = "O";
	AssistantData.vitalsWeight = 49;
	AssistantData.vitalsHeight = 165;
	AssistantDescription = "";
	
	ServantName = AssistantData.SlaveName;
	ServantName1 = AssistantData.SlaveName1;
	ServantName2 = AssistantData.SlaveName2;
	ServantGender = AssistantData.SlaveGender;
	
	if (strFilename.substr(-4) == ".swf") {
		sm.ImageFolder = AssistantData.ImageFolder;
		sm.InitialiseModule();
		
		var mc:MovieClip = sm.InitialiseAsAssistant(true);
		mc._visible = false;
		mc.hide = true;
		sm.HideImages();
		sm.HideEndings();
		sm.HideDresses();
		sm.HideRobes();
		sm.HideSlaveActions();
				
		if (mc == undefined) {
			mc = LoadedAssistant.InitialiseAsAssistant(true);
			LoadedAssistant.HideImages();
			LoadedAssistant.HideAsAssistant();
			LoadedAssistant.HideEndings();
			LoadedAssistant.HideDresses();
			LoadedAssistant.HideRobes();
			LoadedAssistant.HideSlaveActions();
			mc._visible = false;
		}
	}
	
	if (aNode != null) {
		XMLData.StartGameSlaveXML(aNode, AssistantData);
		ServantGender = AssistantData.SlaveGender;
		XMLData.InitialiseAssistantXML(aNode);
		AssistantData.SlaveName = ServantName;
		AssistantData.SlaveName1 = ServantName1;
		AssistantData.SlaveName2 = ServantName2;
		AssistantData.sNode = aNode;
	}
	
	AssistantData.SlaveName = ServantName;
	AssistantData.SlaveGender = ServantGender;
	AssistantData.SlaveName1 = ServantName1;
	AssistantData.SlaveName2 = ServantName2;
	if (AssistantData.LesbianInterest == -1 && AssistantData.Sexuality == 100) AssistantData.Sexuality = 50;
	AssistantData.StartSexuality = AssistantData.Sexuality;
	if (ServantPronoun == Language.strDefPronoun && ServantGender > 3) {
		ServantPronoun = Language.strPronounTwins;
		AssistantData.SlavePronoun = ServantPronoun;
	}
	if (AssistantDescription != "") AssistantData.vitalsDescription = AssistantDescription;
	else AssistantDescription = AssistantData.vitalsDescription;
	if (AssistantData.SlaveImage == "") {
		if (AssistantData.ImageFolder != "") AssistantData.SlaveImage = AssistantData.ImageFolder + "/Assistant.png";
		else AssistantData.SlaveImage = AssistantData.SlaveFilename.split(".")[0] + ".png";
	}
	
	if (AssistantFurryNeeded) AssistantData.BitFlag1.SetBitFlag(93);
	if (AssistantTentaclesNeeded) AssistantData.BitFlag1.SetBitFlag(94);
	if (AssistantRape) AssistantData.BitFlag1.SetBitFlag(90);
	if (AssistantTentacleSex) AssistantData.BitFlag1.SetBitFlag(91);
	if (AssistantVanilla) AssistantData.BitFlag1.SetBitFlag(92);
	AssistantData.SMReputationNeeded = AssistantReputation;
}
