// Slave - class defining a specific slave or assistant 
// This is the full slave version
// Translation status: COMPLETE

import Scripts.Classes.*;

class SlaveActions extends SlaveStatistics {

	public var sNode:XMLNode;				// node for slave data, a shortcut reference to save lookups
	public var SlaveFilename:String;		// the filename of the slave's xml/swf file
	public var ImageFolder:String;			// folder of images, mainly for xml based slaves)
	
	public var DifficultyXXXContest:Number;	// XXX contest difficulty

	// list of image by job, chore, sex act. Includes default participants for sex acts
	public var ActInfoCurrent:ActInfoList;	// reference to either Base or Other below
	public var ActInfoBase:ActInfoList;		// standard list of images
	public var ActInfoOther:ActInfoList;	// alternate list, for say a slave that can change form

	// orders given when a trained slave
	public var Order1:Number;
	public var Order2:Number;
	
	// Difficulties for acts/jobs
	public var DifficultyXXX:Number;
	public var DifficultyExhib:Number;
	public var DifficultySleazyBar:Number;
	public var DifficultyBrothel:Number;
	public var DifficultyTouch:Number;
	public var DifficultyLick:Number;
	public var DifficultyFuck:Number;
	public var DifficultyBlowjob:Number;
	public var DifficultyTitsFuck:Number;
	public var DifficultyAnal:Number;
	public var DifficultyMasturbate:Number;
	public var DifficultyDildo:Number;
	public var DifficultyPlug:Number;
	public var DifficultyLesbian:Number;
	public var DifficultyBondage:Number;
	public var DifficultyNaked:Number;
	public var DifficultyMaster:Number;
	public var DifficultyGangBang:Number;
	public var DifficultyLendHer:Number;
	public var DifficultyPonygirl:Number;
	public var DifficultySpank:Number;
	public var DifficultyThreesome:Number;
	public var DifficultyHandjob:Number;
	public var DifficultyFootjob:Number;
	public var Difficulty69:Number;
	public var DifficultyCumBath:Number;
	public var DifficultyOrgy:Number;
	
	public var DoneMaster:Boolean;

	// Total times various acts, walks etc have been donne
	public var Total69:Number;
	public var TotalAnal:Number;
	public var TotalBlowjob:Number;
	public var TotalBondage:Number;
	public var TotalCumBath:Number;
	public var TotalDildo:Number;
	public var TotalFuck:Number;
	public var TotalGangBang:Number;
	public var TotalGroup:Number;
	public var TotalKiss:Number;
	public var TotalLendHer:Number;
	public var TotalLesbian:Number;
	public var TotalLick:Number;
	public var TotalMasturbate:Number;
	public var TotalNaked:Number;
	public var TotalPlug:Number;
	public var TotalPony:Number;
	public var TotalSpank:Number;
	public var TotalStripTease:Number;
	public var TotalThreesome:Number;
	public var TotalTitsFuck:Number;
	public var TotalTouch:Number;
	public var TotalSex1:Number;
	public var TotalSex2:Number;
	public var TotalSex3:Number;
	public var TotalSex4:Number;
	public var TotalHandjob:Number;
	public var TotalFootjob:Number;

	public var TotalXXX:Number;
	public var TotalSleazyBar:Number;
	public var TotalSleazyBarService:Number;
	public var TotalOnsenService:Number;
	public var TotalExpose:Number;
	public var TotalBrothel:Number;
	public var TotalAcolyte:Number;
	public var TotalRestaurant:Number;
	public var TotalCockMilk:Number;
	public var TotalBar:Number;
	public var TotalLibrary:Number;
	public var TotalOnsen:Number;
	public var TotalExercise:Number;
	public var TotalCooking:Number;
	public var TotalCleaning:Number;
	public var TotalBreak:Number;
	public var TotalDance:Number;
	public var TotalSciences:Number;
	public var TotalSinging:Number;
	public var TotalSwimming:Number;
	public var TotalRefinement:Number;
	public var TotalTheology:Number;
	public var TotalDiscuss:Number;
	public var TotalMakeUp:Number;
	
	public var TotalSlaveJob1:Number;
	public var TotalSlaveJob2:Number;
	public var TotalSlaveJob3:Number;
	public var TotalSlaveSchool1:Number;
	public var TotalSlaveSchool2:Number;
	public var TotalSlaveSchool3:Number;
	public var TotalSlaveChore1:Number;
	public var TotalSlaveChore2:Number;
	public var TotalSlaveChore3:Number;
	
	public var TotalWalkBeach:Number;
	public var TotalWalkForest:Number;
	public var TotalWalkFarm:Number;
	public var TotalWalkPalace:Number;
	public var TotalWalkSlums:Number;
	public var TotalWalkLake:Number;
	public var TotalWalkTownCenter:Number;
	public var TotalWalkDocks:Number;
	public var TotalWalkRuins:Number;
	public var TotalWalkSlaveMarket:Number;
	public var TotalWalkHouse:Number;
	public var TotalWalkCustom:Number;
	public var TotalVisit:Number;
	public var TotalVisitAstrid:Number;
	public var TotalMakeupCare:Number;
	public var TotalHairCare:Number;
	public var TotalSkinCare:Number;
	
	public var TotalMilked:Number;


	// Methods

	// Constructor
	public function SlaveActions(cg:Object) {
		super(cg);

		ActInfoBase = null;
		ActInfoCurrent = null;
		ActInfoOther = null;

		// now actually initialise
		Reset();
	}
	// Initialise all variables for the slave
	public function Reset() {
		super.Reset();
		
		if (ActInfoBase != null) delete ActInfoBase;
		ActInfoBase = new ActInfoList(this, undefined, coreGame);
		if (ActInfoOther != null) {
			delete ActInfoOther;
			ActInfoOther = null;
		}
		ActInfoCurrent = ActInfoBase;
				
		DifficultyXXX = 0;
		DifficultyExhib = 0;
		DifficultySleazyBar = 0;
		DifficultyBrothel = 0;
		DifficultyTouch = 0;
		DifficultyLick = 0;
		DifficultyFuck = 0;
		DifficultyBlowjob = 0;
		DifficultyTitsFuck = 0;
		DifficultyAnal = 0;
		DifficultyMasturbate = 0;
		DifficultyDildo = 0;
		DifficultyPlug = 0;
		DifficultyLesbian = 0;
		DifficultyBondage = 0;
		DifficultyNaked = 0;
		DifficultyMaster = 0;
		DifficultyGangBang = 0;
		DifficultyLendHer = 0;
		DifficultyPonygirl = 0;
		DifficultySpank = 0;
		DifficultyThreesome = 0;
		DifficultyHandjob = -1;
		DifficultyFootjob = -1;
		Difficulty69 = -1;
		DifficultyCumBath = -1;
		DifficultyOrgy = -1;		

		TotalMilked = 0;

		TotalBlowjob = 0;
		TotalFuck = 0;
		TotalAnal = 0;
		TotalBondage = 0;
		TotalMasturbate = 0;
		TotalLesbian = 0;
		TotalNaked = 0;
		TotalGangBang = 0;
		TotalTouch = 0;
		TotalLick = 0;
		TotalTitsFuck = 0;
		TotalDildo = 0;
		TotalPlug = 0;
		TotalLendHer = 0;
		TotalSpank = 0;
		TotalThreesome = 0;
		Total69 = 0;
		TotalGroup = 0;
		TotalCumBath = 0;
		TotalKiss = 0;
		TotalStripTease = 0;
		TotalPony = 0;
		TotalHandjob = 0;
		TotalFootjob = 0;
		TotalXXX = 0;
		TotalSleazyBar = 0;
		TotalSleazyBarService = 0;
		TotalOnsenService = 0;
		TotalExpose = 0;
		TotalBrothel = 0;
		TotalAcolyte = 0;
		TotalRestaurant = 0;
		TotalCockMilk = 0;
		TotalBar = 0;
		TotalLibrary = 0;
		TotalOnsen = 0;
		TotalExercise = 0;
		TotalCooking = 0;
		TotalCleaning = 0;
		TotalBreak = 0;
		TotalDance = 0;
		TotalSciences = 0;
		TotalSinging = 0;
		TotalSwimming = 0;
		TotalRefinement = 0;
		TotalTheology = 0;
		TotalDiscuss = 0;
		TotalMakeUp = 0;
		TotalWalkBeach = 0;
		TotalWalkForest = 0;
		TotalWalkFarm = 0;
		TotalWalkPalace = 0;
		TotalWalkSlums = 0;
		TotalWalkLake = 0;
		TotalWalkTownCenter = 0;
		TotalWalkDocks = 0;
		TotalWalkRuins = 0;
		TotalWalkSlaveMarket = 0;
		TotalWalkHouse = 0;
		TotalWalkCustom = 0;
		TotalVisit = 0;
		TotalVisitAstrid = 0;
		TotalMakeupCare = 0;
		TotalHairCare = 0;
		TotalSkinCare = 0;

		TotalSlaveJob1 = 0;
		TotalSlaveJob2 = 0;
		TotalSlaveJob3 = 0;
		TotalSlaveSchool1 = 0;
		TotalSlaveSchool2 = 0;
		TotalSlaveSchool3 = 0;
		TotalSlaveChore1 = 0;
		TotalSlaveChore2 = 0;
		TotalSlaveChore3 = 0;
		TotalSex1 = 0;
		TotalSex2 = 0;
		TotalSex3 = 0;
		TotalSex4 = 0;
		
		DoneMaster = false;
		
		Order1 = 0;
		Order2 = 0;
		
		sNode = null;
		nWideMode = coreGame.config.nDefaultWideScreenMode;
	}
				
		
	// Copy data from/to this object
	// sdFrom and sdTo can be Object types (for load/save cases(
	public function CopyCommonDetails(sdFrom:Object, sdTo:Object) 
	{		
		super.CopyCommonDetails(sdFrom, sdTo);

		sdTo.TotalBlowjob = sdFrom.TotalBlowjob;
		sdTo.TotalFuck = sdFrom.TotalFuck;
		sdTo.TotalAnal = sdFrom.TotalAnal;
		sdTo.TotalMasturbate = sdFrom.TotalMasturbate;
		sdTo.TotalLesbian = sdFrom.TotalLesbian;
		sdTo.TotalNaked = sdFrom.TotalNaked;
		sdTo.TotalGangBang = sdFrom.TotalGangBang;
		sdTo.TotalTouch = sdFrom.TotalTouch;
		sdTo.TotalLick = sdFrom.TotalLick;
		sdTo.TotalTitsFuck = sdFrom.TotalTitsFuck;
		sdTo.TotalDildo = sdFrom.TotalDildo;
		sdTo.TotalPlug = sdFrom.TotalPlug;
		sdTo.TotalLendHer = sdFrom.TotalLendHer;
		sdTo.TotalBondage = sdFrom.TotalBondage;
		sdTo.TotalSpank = sdFrom.TotalSpank;
		sdTo.TotalThreesome = sdFrom.TotalThreesome;
		sdTo.Total69 = sdFrom.Total69;
		sdTo.TotalGroup = sdFrom.TotalGroup;
		sdTo.TotalCumBath = sdFrom.TotalCumBath;
		sdTo.TotalKiss = sdFrom.TotalKiss;
		sdTo.TotalStripTease = sdFrom.TotalStripTease;
		sdTo.TotalPony = sdFrom.TotalPony;
		sdTo.TotalSex1 = sdFrom.TotalSex1;
		sdTo.TotalSex2 = sdFrom.TotalSex2;
		sdTo.TotalSex3 = sdFrom.TotalSex3;
		sdTo.TotalSex4 = sdFrom.TotalSex4;
		sdTo.TotalFootjob = sdFrom.TotalFootjob;
		sdTo.TotalHandjob = sdFrom.TotalHandjob;

		sdTo.TotalXXX = sdFrom.TotalXXX;
		sdTo.TotalSleazyBar = sdFrom.TotalSleazyBar;
		sdTo.TotalSleazyBarService = sdFrom.TotalSleazyBarService;
		sdTo.TotalOnsenService = sdFrom.TotalOnsenService;
		sdTo.TotalExpose = sdFrom.TotalExpose;
		sdTo.TotalBrothel = sdFrom.TotalBrothel;
		sdTo.TotalAcolyte = sdFrom.TotalAcolyte;
		sdTo.TotalRestaurant = sdFrom.TotalRestaurant;
		sdTo.TotalCockMilk = sdFrom.TotalCockMilk;
		sdTo.TotalBar = sdFrom.TotalBar;
		sdTo.TotalExercise = sdFrom.TotalExercise;
		sdTo.TotalCooking = sdFrom.TotalCooking;
		sdTo.TotalCleaning = sdFrom.TotalCleaning;
		sdTo.TotalBreak = sdFrom.TotalBreak;
		sdTo.TotalDance = sdFrom.TotalDance;
		sdTo.TotalSciences = sdFrom.TotalSciences;
		sdTo.TotalSinging = sdFrom.TotalSinging;
		sdTo.TotalSwimming = sdFrom.TotalSwimming;
		sdTo.TotalRefinement = sdFrom.TotalRefinement;
		sdTo.TotalTheology = sdFrom.TotalTheology;

		sdTo.TotalDiscuss = sdFrom.TotalDiscuss;
		sdTo.TotalMakeUp = sdFrom.TotalMakeUp;
		sdTo.TotalWalkBeach = sdFrom.TotalWalkBeach;
		sdTo.TotalWalkForest = sdFrom.TotalWalkForest;
		sdTo.TotalWalkFarm = sdFrom.TotalWalkFarm;
		sdTo.TotalWalkPalace = sdFrom.TotalWalkPalace;
		sdTo.TotalWalkSlums = sdFrom.TotalWalkSlums;
		sdTo.TotalWalkLake = sdFrom.TotalWalkLake;
		sdTo.TotalWalkTownCenter = sdFrom.TotalWalkTownCenter;
		sdTo.TotalWalkDocks = sdFrom.TotalWalkDocks;
		sdTo.TotalWalkRuins = sdFrom.TotalWalkRuins;
		sdTo.TotalWalkSlaveMarket = sdFrom.TotalWalkSlaveMarket;
		sdTo.TotalWalkHouse = sdFrom.TotalWalkHouse;
		sdTo.TotalWalkCustom = sdFrom.TotalWalkCustom;
		sdTo.TotalProstituteParty = sdFrom.TotalProstituteParty;
		sdTo.TotalHighClassParty = sdFrom.TotalHighClassParty;
		sdTo.TotalVisit = sdFrom.TotalVisit;
		sdTo.TotalVisitAstrid = sdFrom.TotalVisitAstrid;
		sdTo.TotalMakeupCare = sdFrom.TotalMakeupCare;
		sdTo.TotalHairCare = sdFrom.TotalHairCare;
		sdTo.TotalSkinCare = sdFrom.TotalSkinCare;
		sdTo.TotalLibrary = sdFrom.TotalLibrary;
		sdTo.TotalOnsen = sdFrom.TotalOnsen;
		sdTo.TotalSlaveJob1 = sdFrom.TotalSlaveJob1;
		sdTo.TotalSlaveJob2 = sdFrom.TotalSlaveJob2;
		sdTo.TotalSlaveJob3 = sdFrom.TotalSlaveJob3;
		sdTo.TotalSlaveSchool1 = sdFrom.TotalSlaveSchool1;
		sdTo.TotalSlaveSchool2 = sdFrom.TotalSlaveSchool2;
		sdTo.TotalSlaveSchool3 = sdFrom.TotalSlaveSchool3;
		sdTo.TotalSlaveChore1 = sdFrom.TotalSlaveChore1;
		sdTo.TotalSlaveChore2 = sdFrom.TotalSlaveChore2;
		sdTo.TotalSlaveChore3 = sdFrom.TotalSlaveChore3;

		sdTo.DifficultyXXX = sdFrom.DifficultyXXX;
		sdTo.DifficultyExhib = sdFrom.DifficultyExhib;
		sdTo.DifficultySleazyBar = sdFrom.DifficultySleazyBar;
		sdTo.DifficultyBrothel = sdFrom.DifficultyBrothel;
		sdTo.DifficultyTouch = sdFrom.DifficultyTouch;
		sdTo.DifficultyLick = sdFrom.DifficultyLick;
		sdTo.DifficultyFuck = sdFrom.DifficultyFuck;
		sdTo.DifficultyBlowjob = sdFrom.DifficultyBlowjob;
		sdTo.DifficultyTitsFuck = sdFrom.DifficultyTitsFuck;
		sdTo.DifficultyAnal = sdFrom.DifficultyAnal;
		sdTo.DifficultyMasturbate = sdFrom.DifficultyMasturbate;
		sdTo.DifficultyDildo = sdFrom.DifficultyDildo;
		sdTo.DifficultyPlug = sdFrom.DifficultyPlug;
		sdTo.DifficultyLesbian = sdFrom.DifficultyLesbian;
		sdTo.DifficultyBondage = sdFrom.DifficultyBondage;
		sdTo.DifficultyNaked = sdFrom.DifficultyNaked;
		sdTo.DifficultyMaster = sdFrom.DifficultyMaster;
		sdTo.DifficultyGangBang = sdFrom.DifficultyGangBang;
		sdTo.DifficultyLendHer = sdFrom.DifficultyLendHer;
		sdTo.DifficultySpank = sdFrom.DifficultySpank;
		sdTo.DifficultyThreesome = sdFrom.DifficultyThreesome;
		sdTo.DifficultyPonygirl = sdFrom.DifficultyPonygirl;
		sdTo.DifficultyHandjob = sdFrom.DifficultyHandjob;
		sdTo.DifficultyFootjob = sdFrom.DifficultyFootjob;
		sdTo.Difficulty69 = sdFrom.Difficulty69;
		sdTo.DifficultyCumBath = sdFrom.DifficultyCumBath;
		sdTo.DifficultyOrgy = sdFrom.DifficultyOrgy;

		sdTo.DoneMaster = sdFrom.DoneMaster;
		
		sdTo.TotalMilked = sdFrom.TotalMilked;
		
		// upgrades
		if (sdFrom.DifficultyFootjob == undefined) {
			sdTo.DifficultyHandjob = sdTo.DifficultyBlowjob - 5;
			sdTo.DifficultyFootjob = sdTo.DifficultyBlowjob - 3;
			sdTo.Difficulty69 = sdTo.DifficultyBlowjob - 3;
			sdTo.DifficultyCumBath = sdTo.DifficultyGangBang - 5;
			sdTo.DifficultyOrgy = sdTo.DifficultyGangBang - 10;
		}
	}
	
	// XML
	public function GetSlaveXML() : XMLNode { 
		if (sNode != null) return sNode;	
		return coreGame.XMLData.GetSlaveXML(undefined, this);
	}
	
	// Acts
	
	public function LoadActImages(lNode:XMLNode, imagesnode:String, noreset:Boolean)
	{
		if (imagesnode == undefined) imagesnode = "Images";
		if (lNode == undefined) lNode = sNode;

		if (imagesnode == "Images") {
			if (noreset != true) ActInfoBase.ResetList(this);
			ActInfoBase.LoadActImages(lNode, imagesnode);
			ActInfoCurrent = ActInfoBase;
		} else {
			if (noreset != true) {
				if (ActInfoOther == null) ActInfoOther = new ActInfoList(this);
				else ActInfoOther.ResetList(this);
			}
			ActInfoOther.LoadActImages(lNode, imagesnode);
			ActInfoCurrent = ActInfoOther;
		}
		ActInfoCurrent.ActFolder = ImageFolder;
	}
	
	private var nWideMode:Number;		// Widescreen Display mode
	
	public function GetWidescreenMode() : Number 
	{ 
		if (nWideMode == -1) nWideMode = coreGame.XMLData.GetXMLValue("WideScreen", GetSlaveXML(), 0);
		return nWideMode;
	}
	
	public function ShowActImage(oact:Object, place:Number, align:Number, frame:Number) : Boolean 
	{
		if (oact == undefined) oact = coreGame.LastActionDone;
		if (place == undefined) place = GetWidescreenMode() == 0 ? 1 : 1.1;
		
		if (!ActInfoCurrent.IsLoaded()) LoadActImages();

		var frm:Number = ActInfoCurrent.ShowActImage(oact, place, align, frame);
		if (frm == 0 && ActInfoCurrent != ActInfoBase) frm = ActInfoBase.ShowActImage(oact,place,align,frame);
		coreGame.currFrame = frm;
		coreGame.UseGeneric = frm == 0;
		return frm != 0;
	}
	
	public function SelectActImage(noxml:Boolean, oact:Object, place:Number, align:Number, frame:Number, bRetNoShow:Boolean) : Boolean
	{
		if (coreGame.UseGeneric) return true;
		if (noxml == true || !coreGame.IsEventAllowable()) return false;
		
		var purexml:Boolean = (SlaveFilename.indexOf(".xml") != -1) || (SlaveFilename == "");
		if (ActInfoCurrent == null) LoadActImages();
		var tot:Number = ActInfoCurrent.GetTotalLoaded();
		//trace("purexml = " + purexml + " tot = " + tot + " " + ActInfoCurrent + " " + ActInfoBase + " " + coreGame.UseGeneric);
		
		// note: returns true if a generic image is to be shown
		if (purexml || tot > 0 || (Math.random()*10) < 1) {
			if (ShowActImage(oact, place, align, frame)) return false;  // image was actually shown
			
			// no image was shown
			if (bRetNoShow == true) return true;
			
			if (!purexml) coreGame.UseGeneric = false;
			else if (tot == 0) coreGame.UseGeneric = false;
		}
		return coreGame.UseGeneric;
	}	

	
	public function GetActDifficulty(act:Number) : Number
	{
		switch (Math.floor(Math.abs(act))) {
			case 2: return DifficultyTouch;
			case 3: return DifficultyLick;
			case 4: return DifficultyFuck;			
			case 5:
			case 99:
				return DifficultyBlowjob;
			case 6: return DifficultyTitsFuck;
			case 7: return DifficultyAnal;
			case 8: return DifficultyMasturbate;
			case 9: return DifficultyDildo;
			case 10: return DifficultyPlug;
			case 11: return DifficultyLesbian;
			case 12: return DifficultyBondage;
			case 13: return DifficultyNaked;
			case 14: return DifficultyMaster;
			case 15: return DifficultyGangBang;
			case 16: return DifficultyLendHer;
			case 17: return DifficultyPonygirl;
			case 18: return DifficultySpank;
			case 19: return DifficultyThreesome;
			case 20: return DifficultyBlowjob + 3;
			case 21: return DifficultyGangBang - 10;
			case 23: return 0;
			case 24: return DifficultyExhib;
			case 25: return DifficultyGangBang-5;
			case 30: return DifficultyFootjob;
			case 31: return DifficultyHandjob;
			case 3000: return DifficultyXXXContest;
		}
	}
	
	public function SetActDifficulty(act:Number, val:Number)
	{
		if (val == undefined) return GetActDifficulty(act);
		
		switch (Math.floor(Math.abs(act))) {
			case 2: return DifficultyTouch = val;
			case 3: return DifficultyLick = val;
			case 4: return DifficultyFuck = val;			
			case 5:
			case 99:
				return DifficultyBlowjob = val;
			case 6: return DifficultyTitsFuck = val;
			case 7: return DifficultyAnal = val;
			case 8: return DifficultyMasturbate = val;
			case 9: return DifficultyDildo = val;
			case 10: return DifficultyPlug = val;
			case 11: return DifficultyLesbian = val;
			case 12: return DifficultyBondage = val;
			case 13: return DifficultyNaked = val;
			case 14: return DifficultyMaster = val;
			case 15: return DifficultyGangBang = val;
			case 16: return DifficultyLendHer = val;
			case 17: return DifficultyPonygirl = val;
			case 18: return DifficultySpank = val;
			case 19: return DifficultyThreesome = val;
			case 20: return DifficultyBlowjob + 3;
			case 21: return DifficultyGangBang - 10;
			case 22: return 1;
			case 23: return 0;
			case 24: return DifficultyExhib = val;
			case 25: return DifficultyGangBang-5;
			case 30: return DifficultyFootjob = val;
			case 31: return DifficultyHandjob = val;
			
			case 1010: return DifficultyXXX = val;
			case 1011: return DifficultyExhib = val;
			case 1015: return DifficultySleazyBar = val;
			case 1016: return DifficultyBrothel = val;

			case 3000: return DifficultyXXXContest = val;
		}
		return 0;
	}
	
	public function IncreaseActTotal(type:Object)
	{	
		var act:ActInfo = ActInfoBase.GetActAbs(type);
		if (act != null) {
			if (act.strNodeName == "SlaveJob1") TotalSlaveJob1++;
			else if (act.strNodeName == "SlaveJob2") TotalSlaveJob2++;
			else if (act.strNodeName == "SlaveJob3") TotalSlaveJob3++;
			else if (act.strNodeName == "SlaveChore1") TotalSlaveChore1++;
			else if (act.strNodeName == "SlaveChore2") TotalSlaveChore2++;
			else if (act.strNodeName == "SlaveChore3") TotalSlaveChore3++;
			else if (act.strNodeName == "SlaveSex1") TotalSex1++;
			else if (act.strNodeName == "SlaveSex2") TotalSex2++;
			else if (act.strNodeName == "SlaveSex3") TotalSex3++;
			else if (act.strNodeName == "SlaveSex4") TotalSex4++;
		}
		SetActTotal(type, GetActTotal(type) + 1);
	}
	
	public function SetActTotal(type:Object, val:Number) : Number
	{
		switch (Math.floor(Math.abs(Number(type)))) {
			case 1017:
			case 1: return TotalBreak = val;
			case 2: return TotalTouch = val;
			case 3: return TotalLick = val;
			case 4: return TotalFuck = val;
			case 99:
			case 5: return TotalBlowjob = val;
			case 6: return TotalTitsFuck = val;
			case 7: return TotalAnal = val;
			case 8: return TotalMasturbate = val;
			case 9: return TotalDildo = val;
			case 10: return TotalPlug = val;
			case 11: return TotalLesbian = val;
			case 12: return TotalBondage = val;
			case 13: return TotalNaked = val;
			case 14: {
				if (val != undefined)  DoneMaster = val > 0;
				return DoneMaster ? 1 : 0;
			}
			case 15: return TotalGangBang = val;
			case 16: return TotalLendHer = val;
			case 17: return TotalPony = val;
			case 18: return TotalSpank = val;
			case 19: return TotalThreesome = val;
			case 20: return Total69 = val;
			case 21: return TotalGroup = val;
			case 22: return 1;
			case 23: return TotalKiss = val;
			case 24: return TotalStripTease = val;
			case 25: return TotalCumBath = val;
			case 26: return TotalSex1 = val;
			case 27: return TotalSex2 = val;
			case 28: return TotalSex3 = val;
			case 29: return TotalSex4 = val;
			case 30: return TotalFootjob = val;
			case 31: return TotalHandjob = val;
			case 1001: return TotalCooking = val;
			case 1002: return TotalCleaning = val;
			case 1003: return TotalExercise = val;
			case 1004: return TotalDiscuss = val;
			case 1005: return TotalMakeUp = val;
			case 1006: return TotalSciences = val;
			case 1007: return TotalTheology = val;
			case 1008: return TotalRefinement = val;
			case 1009: return TotalDance = val;
			case 1010: return TotalXXX = val;
			case 1011: return TotalExpose = val;
			case 1012: return TotalRestaurant = val;
			case 1013: return TotalAcolyte = val;
			case 1014: return TotalBar = val;
			case 1015: return TotalSleazyBar = val;
			case 1016: return TotalBrothel = val;
			case 1019: 
				var totbkrd:Number = Math.floor(TotalBooksRead / 2) + Math.floor(TotalPoetryRead / 2) + TotalScrollsRead + TotalScriptureRead + TotalKamasutraRead;
				for (var ib:Number = 0; ib < 32; ib++) {
					if (coreGame.OtherBooks.CheckBitFlag(ib + 32)) totbkrd++;
				}
				return totbkrd;
			case 1022: return TotalLibrary = val;
			case 1023: return TotalOnsen = val;
			case 1031: return TotalCockMilk = val;
			case 1032: return TotalSinging = val;
			case 1033: return TotalSwimming = val;
			case 2001: {
				if (val != undefined) BitFlagC.SetBitFlag(35);
				return BitFlagC.CheckBitFlag(35) ? 1 : 0;
			}
			case 2002: {
				if (val != undefined) BitFlagC.SetBitFlag(30);
				return BitFlagC.CheckBitFlag(30) ? 1 : 0;
			}
			case 2003: {
				if (val != undefined) BitFlagC.SetBitFlag(28);
				return BitFlagC.CheckBitFlag(28) ? 1 : 0;
			}
			case 2004: {
				if (val != undefined) BitFlagC.SetBitFlag(29);
				return BitFlagC.CheckBitFlag(29) ? 1 : 0;
			}
			case 2005: return TotalVisit = val;
		}
		
		var act:ActInfo = ActInfoBase.GetActAbs(type);
		if (act == null) return 0;
		return act.TotalDone = val;
	}
	
	public function GetActTotal(type:Object) : Number
	{
		switch (Math.floor(Math.abs(Number(type)))) {
			case 1017:
			case 1: return TotalBreak;
			case 2: return TotalTouch;
			case 3: return TotalLick;
			case 4: return TotalFuck;
			case 99:
			case 5: return TotalBlowjob;
			case 6: return TotalTitsFuck;
			case 7: return TotalAnal;
			case 8: return TotalMasturbate;
			case 9: return TotalDildo;
			case 10: return TotalPlug;
			case 11: return TotalLesbian;
			case 12: return TotalBondage;
			case 13: return TotalNaked;
			case 14: return DoneMaster ? 1 : 0;
			case 15: return TotalGangBang;
			case 16: return TotalLendHer;
			case 17: return TotalPony;
			case 18: return TotalSpank;
			case 19: return TotalThreesome;
			case 20: return Total69;
			case 21: return TotalGroup;
			case 22: return 1;
			case 23: return TotalKiss;
			case 24: return TotalStripTease;
			case 25: return TotalCumBath;
			case 26: return TotalSex1;
			case 27: return TotalSex2;
			case 28: return TotalSex3;
			case 29: return TotalSex4;
			case 30: return TotalFootjob;
			case 31: return TotalHandjob;
			case 1001: return TotalCooking;
			case 1002: return TotalCleaning;
			case 1003: return TotalExercise;
			case 1004: return TotalDiscuss;
			case 1005: return TotalMakeUp;
			case 1006: return TotalSciences;
			case 1007: return TotalTheology;
			case 1008: return TotalRefinement;
			case 1009: return TotalDance;
			case 1010: return TotalXXX;
			case 1011: return TotalExpose;
			case 1012: return TotalRestaurant;
			case 1013: return TotalAcolyte;
			case 1014: return TotalBar;
			case 1015: return TotalSleazyBar;
			case 1016: return TotalBrothel;
			case 1019: 
				var totbkrd:Number = 0;
				for (var ib:Number = 0; ib < 32; ib++) {
					if (coreGame.OtherBooks.CheckBitFlag(ib+32)) totbkrd++;
				}
				totbkrd += Math.floor(TotalBooksRead / 2) + Math.floor(TotalPoetryRead / 2) + TotalScrollsRead + TotalScriptureRead + TotalKamasutraRead;
				return totbkrd;
			case 1022: return TotalLibrary;
			case 1023: return TotalOnsen;
			case 1030: return TotalWalkBeach + TotalWalkForest + TotalWalkFarm + TotalWalkPalace + TotalWalkSlums + TotalWalkLake + TotalWalkTownCenter + TotalWalkDocks + TotalWalkRuins + TotalWalkSlaveMarket + TotalWalkHouse + TotalWalkCustom;
			case 1031: return TotalCockMilk;
			case 1032: return TotalSinging;
			case 1033: return TotalSwimming;
			case 2001: return BitFlagC.CheckBitFlag(35) ? 1 : 0;
			case 2002: return BitFlagC.CheckBitFlag(30) ? 1 : 0;
			case 2003: return BitFlagC.CheckBitFlag(28) ? 1 : 0;
			case 2004: return BitFlagC.CheckBitFlag(29) ? 1 : 0;
			case 2005: return TotalVisit;
		}
		
		var act:ActInfo = ActInfoBase.GetActAbs(type);
		if (act == null) return 0;
		return act.TotalDone;
	}
	
	public function GetActNumber(type:Object) : Number { return ActInfoBase.GetActRO(type).Act;	}
	
	
	public function DoSlaveOrder(order:Number)
	{
		if (VarFatigue > 60) order = 1044;
		var std:Boolean = true;
		
		switch (int(Math.abs(order))) {
			// patrol
			case 1041:
				coreGame.Home.ActualSecurity += 2;
				Points(0, 0, 0, 0.5, 0, 0.5, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 1, 0, 0, 0, 0, 0);
				break;
			// play
			case 1042:
				Points(0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0);
				break;
			// exercise
			case 1043:
				Points(0, 0.5, 0, 0, 0, 0.5, 0, 0, -1, 0, 0, 0, -0.5, 0, 0, 0, 0.5, 0.5, 0, 0);
				FatigueBonus += coreGame.StatRate * 1;
				break;			
			// rest
			case 1044: 
				VarFatigue -= 10;
				if (VarFatigue < 0) VarFatigue = 0;
				break;
			// farm work
			case 1045: 
				Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.25, -1, 0, 0.25, 0.25, 0, 0.5, 0, 0, 0, 0, 0);
				FatigueBonus += coreGame.StatRate * 1;
				break;
			// brothel
			case 1046: 
				Points(0, -1, -1, -1, -1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 4, -1, -1, 0);
				coreGame.SMMoney(1 + (VarCharisma + VarConstitution) / 100);
				break;
			// onsen
			case 1047: 
				Points(0, 0, 0, 0, 0, 0.25, 0, 0.25, 0, 0.25, 0, 0, 0, 0, 0.25, 0, 0.5, 0, 0, 0, 0, 0);
				coreGame.Home.ActualHouseWork += 0.5;
				coreGame.SMMoney(1 + VarCharisma / 100);
				break;
			
			case 1001:
				Points(0, 0, -0.5, 0, 0, 0, 1 + coreGame.Home.hKitchen, 0, 0, 0, 0, 0, -0.5, 0, 0, 0, 1, 0, 0, 0);
				coreGame.Home.ActualCooking += 1 + (VarCooking / 50);
				break;
			case 1002:
				Points(-0.5, 0, 0, -0.5, 0, 0, 0, 1 + coreGame.Home.hKitchen, 0, 0, 0, 0, -0.5, 0, 0, 0, 1, 0, 0, 0);
				coreGame.Home.ActualHouseWork += 1 + (VarCleaning / 50);
				break;
			default:
				std = false;
				break;
		}	
	
		coreGame.genNumber = order;
		if (coreGame.SlaveGirl.DoSlaveOrder(coreGame.PersonName, order) == true) return;
		if (coreGame.CurrentAssistant.DoSlaveOrder(coreGame.PersonName, order) == true) return;
		
		if (!std) {
			var act:ActInfo = coreGame.slaveData.ActInfoBase.GetAct(order);
			if (act.Type == 12) {
				if (act.xNode != null) {
					act.DoAct();
					return true;
				} else return coreGame.XMLData.DoXMLActForSlave(act.strNodeName, this);
			}
		}
		return coreGame.XMLData.DoXMLActForSlave("SlaveOrder", this);
	}
	
	public function GetSexActShortDescription(type:Number) : String
	{
		var LesbianTraining:Boolean = coreGame.LesbianTraining;
		type = Math.floor(Math.abs(type));
		if (type == 4 && LesbianTraining && !IsMale()) type = 4.1;
		else if (type == 5 || type == 99) {
			if (type == 5 && LesbianTraining && !IsMale()) type = 5.1;
			else type = 5;
		} else if (type == 6 && LesbianTraining && !IsMale()) type = 6.1;
		else if (type == 7 && LesbianTraining && !IsMale()) type = 7.1;
		else if (type == 11 && LesbianTraining && !IsMale()) type = 11.1;
		else if (type == 18 && coreGame.SMData.IsDominatrix()) {
			if (coreGame.SMData.IsWeaponClassOwned("whip")) type = 18.1;
			else type = 18.2;
		}
		
		var str:String = GetExperienceLang(type);
		if (str == "") str = ActInfoBase.GetActName(type);
		return str;
	}
	
	public function GetTotalImages() : Number
	{
		if (ActInfoCurrent == null) LoadActImages();
		var cnt:Number = ActInfoCurrent.GetTotalLoaded() + 1;	// +1 for slave image
		// approximation for minor slaves, does not count variations for each dress
		if (SlaveFilename == "") {
			for (var id:Number = 0; id < 7; id++) {
				if (coreGame.XMLData.GetNodeC(sNode, "Dresses/Dress" + id) != null) cnt++;
			}
			if (coreGame.XMLData.GetNodeC(sNode, "Dresses/DressPlain") != null) cnt++;
		}
		return cnt;
	}
	
	// Experiences
	
	public function GetExperienceLang(id:Number)
	{
		var eNode:XMLNode = coreGame.XMLData.GetNodeC(coreGame.Language.flNode, "Experiences");
		for (; eNode != null; eNode = eNode.nextSibling) {
			if (eNode.nodeType != 1 || eNode.nodeName != "Experience") continue;
			if (Number(eNode.attributes.id) == id) return coreGame.UpdateMacros(eNode.firstChild.nodeValue);
		}
		return ""
	}
	
	// Resting
	
	public function StandardRest(hrs:Number)
	{
		var arsd = (DemonicBraWorn == 1 || DemonicPendantWorn == 1 || VibratorPantiesWorn == 1 || VarLibido > 25);
		var rest:Number = coreGame.Home.hWards > 0 ? -6.5 : -5;
		if (coreGame.Home.HouseType == 10) rest--;
		var lib:Number = 0;
		if (arsd && coreGame.IsSexPlanningTime()) lib = Math.floor(VarLibido/5);
		if (ZodaiEffecting > 0) lib *= 2;
		Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, lib * hrs, 0, rest * hrs, 0.5 * hrs, 0, 0);
	}

}