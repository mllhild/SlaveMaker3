import Scripts.Classes.*;

// Animal Girl
// these mirror the versions in the class Slave
var HasTail:Boolean;

// Catgirl
var Catgirl:Boolean;

function IsCatgirl() : Boolean { return slaveData.IsCatgirl(); }
function IsCatgirlComplete() : Boolean { return slaveData.IsCatgirlComplete(); }
function IsCatgirlTraining() : Boolean { return slaveData.IsCatgirlTraining(); }

function ChangeCatTraining(val:Number)
{
	slaveData.slCatTraining = slCatTraining;
	slaveData.ChangeCatTraining(val);
	slCatTraining = slaveData.slCatTraining;		
}

function IsPuppygirl() : Boolean { return slaveData.IsPuppygirl(); }
function IsPuppygirlComplete() : Boolean { return slaveData.IsPuppygirlComplete(); }
function IsPuppygirlTraining() : Boolean { return slaveData.IsPuppygirlTraining(); }	

function ChangePuppyTraining(val:Number) {
	slaveData.ChangePuppyTraining(val);
	slPuppyTraining = slaveData.slPuppyTraining;	
}	



// Fairy
var FairyMeeting:Number;

function IsFairy() : Boolean { return slaveData.IsFairy(); }
function IsFaerie() : Boolean { return slaveData.IsFairy(); }
function IsFairyComplete() : Boolean { return slaveData.IsFairyComplete(); }
function IsFaerieComplete() : Boolean { return slaveData.IsFairyComplete(); }

function ChangeFairyXF(val:Number)
{
	slaveData.FairyXF = FairyXF;
	slaveData.ChangeFairyXF(val);
	FairyXF = slaveData.FairyXF;	
}
function ChangeFaerieXF(val:Number) { ChangeFairyXF(val); }

function SetFairyXF(val:Number)
{
	slaveData.FairyXF = FairyXF;
	slaveData.SetFairyXF(val);
	FairyXF = slaveData.FairyXF;	
}
function SetFaerieXF(val:Number) { SetFairyXF(val); }


function GetSMSkillLevel(skill:Number, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	else if (sd != _root) {
		sd.GetSMSkillLevel(skill);
		return;
	}
	switch(Math.abs(skill)) {
		case 13: return sd.sSlaveTrainer;
		case 1: return sd.sLeadership;
		case 2: return sd.sLesbianTrainer;
		case 3: return sd.sTrader;
		case 4: return sd.sAlchemy;
		case 5: return sd.sPonyTrainer;
		case 6: return sd.sCatTrainer;
		case 7: return sd.sSuccubusTrainer;
		case 8: return sd.sSlutTrainer;
		case 9: return sd.sOrgasmDenialTraining;
		case 10: return sd.sRefined;
		case 11: return sd.sNoble;
		case 12: return sd.sTentacleExpert;
		case 14: return sd.sBreastExpert;
		
		case 50: return sd.sSwordExpertise;
		case 51: return sd.sWhipExpertise;
		case 52: return	sd.sBowExpertise;
		case 53: return	sd.sHammerExpertise;
		case 54: return sd.sNaginataExpertise;
		case 55: return sd.sDaggerExpertise;
		case 56: return sd.sCrossbowExpertise;
		case 57: return sd.sUnarmedExpertise;
		case 58: return sd.sThrownExpertise;
	}
	return 0;
}

function SetSMSkillLevel(skill:Number, skillvalue:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	else if (sd != _root && sd != SMData) {
		sd.SetSMSkillLevel(skill, skillvalue);
		return;
	}
	if (skillvalue == undefined) return;
	switch(Math.abs(skill)) {
		case 13: sd.sSlaveTrainer = skillvalue; break;
		case 1: sd.sLeadership = skillvalue; break;
		case 2: sd.sLesbianTrainer = skillvalue; break;
		case 3: sd.sTrader = skillvalue; break;
		case 4: sd.sAlchemy = skillvalue; break;
		case 5: sd.sPonyTrainer = skillvalue; break;
		case 6: sd.sCatTrainer = skillvalue; break;
		case 7: sd.sSuccubusTrainer = skillvalue; break;
		case 8: sd.sSlutTrainer = skillvalue; break;
		case 9: sd.sOrgasmDenialTraining = skillvalue; break;
		case 10: sd.sRefined = skillvalue; break;
		case 11: sd.sNoble = skillvalue; break;
		case 12: sd.sTentacleExpert = skillvalue; break;
		case 14: sd.sBreastExpert = skillvalue; break;
		
		case 50: sd.sSwordExpertise = skillvalue; break;
		case 51: sd.sWhipExpertise = skillvalue; break;
		case 52: sd.sBowExpertise = skillvalue; break;
		case 53: sd.sHammerExpertise = skillvalue; break;
		case 54: sd.sNaginataExpertise = skillvalue; break;
		case 55: sd.sDaggerExpertise = skillvalue; break;
		case 56: sd.sCrossbowExpertise = skillvalue; break;
		case 57: sd.sUnarmedExpertise = skillvalue; break;
		case 58: sd.sThrownExpertise = skillvalue; break;
	}
}


// Slave Skills
/*
function GetSlaveSkillArrayIndex(name:String) : Number
{
	name = name.split(":").join("").split(" ").join("");
	var sd:Slave = SMData.GetSlaveObject();
	var i:Number = sd.arSkillArray.length;
	if (i == undefined) i = 0;
	while (--i >= 0) {
		if (name == sd.arSkillArray[i].sname.split(":").join("").split(" ").join("")) return i;
	}
	return -1;
}

function GetSlaveSkillArrayEntry(name:String) : MovieClip
{
	name = name.split(":").join("").split(" ").join("");
	var sd:Slave = SMData.GetSlaveObject();
	var i:Number = sd.arSkillArray.length;
	if (i == undefined) i = 0;
	while (--i >= 0) {
		if (name == sd.arSkillArray[i].sname.split(":").join("").split(" ").join("")) return sd.arSkillArray[i];
	}
	return null;
}
*/

function SetSlaveCombatSkill(desc:String, hint:String)
{
	if (desc != undefined) strCombatDescription = desc;
	if (hint != undefined) strCombatHint = hint;
}

function ChangeDancing(val:Number)
{
	slaveData.slDancing = slDancing;
	slaveData.ChangeDancing(val);
	slDancing = slaveData.slDancing;	
}

function ChangeSinging(val:Number)
{
	slaveData.slSinging = slSinging;
	slaveData.ChangeSinging(val);
	slSinging = slaveData.slSinging;	
}

function ChangeSwimming(val:Number)
{
	slaveData.slSwimming = slSwimming;
	slaveData.ChangeSwimming(val);
	slSwimming = slaveData.slSwimming;
}

function ChangeCombat(val:Number)
{
	slaveData.slCombat = slCombat;
	slaveData.ChangeCombat(val);
	slCombat = slaveData.slCombat;
}

function ChangeSlutTraining(val:Number)
{
	slaveData.slSlutTraining = slSlutTraining;
	slaveData.ChangeSlutTraining(val);
	slSlutTraining = slaveData.slSlutTraining;
}

function ChangeCourtesan(val:Number)
{
	slaveData.slCourtesan = slCourtesan;
	slaveData.ChangeCourtesan(val);
	slCourtesan = slaveData.slCourtesan;
}

function ChangeSeduction(val:Number)
{
	slaveData.slSeduction = slSeduction;
	slaveData.ChangeSeduction(val);
	slSeduction = slaveData.slSeduction;
}


function RemoveSlaveSkill(idx:Number)
{
	slaveData.RemoveSlaveSkill(idx);
}

// Acts
function GetActDifficulty(act:Number, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	
	switch (Math.floor(Math.abs(act))) {
		case 2: return sd.DifficultyTouch;
		case 3: return sd.DifficultyLick;
		case 4: return sd.DifficultyFuck;			
		case 5:
		case 99:
			return sd.DifficultyBlowjob;
		case 6: return sd.DifficultyTitsFuck;
		case 7: return sd.DifficultyAnal;
		case 8: return sd.DifficultyMasturbate;
		case 9: return sd.DifficultyDildo;
		case 10: return sd.DifficultyPlug;
		case 11: return sd.DifficultyLesbian;
		case 12: return sd.DifficultyBondage;
		case 13: return sd.DifficultyNaked;
		case 14: return sd.DifficultyMaster;
		case 15: return sd.DifficultyGangBang;
		case 16: return sd.DifficultyLendHer;
		case 17: return sd.DifficultyPonygirl;
		case 18: return sd.DifficultySpank;
		case 19: return sd.DifficultyThreesome;
		case 20: return sd.DifficultyBlowjob + 3;
		case 21: return sd.DifficultyGangBang - 10;
		case 23: return 0;
		case 24: return sd.DifficultyExhib;
		case 25: return sd.DifficultyGangBang-5;
		case 30: return sd.DifficultyFootjob;
		case 31: return sd.DifficultyHandjob;
		case 3000: return sd.DifficultyXXXContest;
	}
}

function SetActDifficulty(act:Number, val:Number, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	
	switch (Math.floor(Math.abs(act))) {
		case 2: return sd.DifficultyTouch = val;
		case 3: return sd.DifficultyLick = val;
		case 4: return sd.DifficultyFuck = val;			
		case 5:
		case 99:
			return sd.DifficultyBlowjob = val;
		case 6: return sd.DifficultyTitsFuck = val;
		case 7: return sd.DifficultyAnal = val;
		case 8: return sd.DifficultyMasturbate = val;
		case 9: return sd.DifficultyDildo = val;
		case 10: return sd.DifficultyPlug = val;
		case 11: return sd.DifficultyLesbian = val;
		case 12: return sd.DifficultyBondage = val;
		case 13: return sd.DifficultyNaked = val;
		case 14: return sd.DifficultyMaster = val;
		case 15: return sd.DifficultyGangBang = val;
		case 16: return sd.DifficultyLendHer = val;
		case 17: return sd.DifficultyPonygirl = val;
		case 18: return sd.DifficultySpank = val;
		case 19: return sd.DifficultyThreesome = val;
		case 24: return sd.DifficultyExhib = val;
		case 30: return sd.DifficultyFootjob = val;
		case 31: return sd.DifficultyHandjob = val;
		case 3000: return sd.DifficultyXXXContest = val;
	}
	return undefined;
}

function GetActTotal(type:Object, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
		
	switch (Math.floor(Math.abs(Number(type)))) {
		case 1017:
		case 1: return sd.TotalBreak;
		case 2: return sd.TotalTouch;
		case 3: return sd.TotalLick;
		case 4: return sd.TotalFuck;
		case 99:
		case 5: return sd.TotalBlowjob;
		case 6: return sd.TotalTitsFuck;
		case 7: return sd.TotalAnal;
		case 8: return sd.TotalMasturbate;
		case 9: return sd.TotalDildo;
		case 10: return sd.TotalPlug;
		case 11: return sd.TotalLesbian;
		case 12: return sd.TotalBondage;
		case 13: return sd.TotalNaked;
		case 14: return sd.DoneMaster ? 1 : 0;
		case 15: return sd.TotalGangBang;
		case 16: return sd.TotalLendHer;
		case 17: return sd.TotalPony;
		case 18: return sd.TotalSpank;
		case 19: return sd.TotalThreesome;
		case 20: return sd.Total69;
		case 21: return sd.TotalGroup;
		case 22: return 1;
		case 23: return sd.TotalKiss;
		case 24: return sd.TotalStripTease;
		case 25: return sd.TotalCumBath;
		case 26: return sd.TotalSex1;
		case 27: return sd.TotalSex2;
		case 28: return sd.TotalSex3;
		case 29: return sd.TotalSex4;
		case 30: return sd.TotalFootjob;
		case 31: return sd.TotalHandjob;
		case 1001: return sd.TotalCooking;
		case 1002: return sd.TotalCleaning;
		case 1003: return sd.TotalExercise;
		case 1004: return sd.TotalDiscuss;
		case 1005: return sd.TotalMakeUp;
		case 1006: return sd.TotalSciences;
		case 1007: return sd.TotalTheology;
		case 1008: return sd.TotalRefinement;
		case 1009: return sd.TotalDance;
		case 1010: return sd.TotalXXX;
		case 1011: return sd.TotalExpose;
		case 1012: return sd.TotalRestaurant;
		case 1013: return sd.TotalAcolyte;
		case 1014: return sd.TotalBar;
		case 1015: return sd.TotalSleazyBar;
		case 1016: return sd.TotalBrothel;
		case 1019: 
			var totbkrd:Number = 0;
			for (var ib:Number = 0; ib < 32; ib++) {
				if (SMData.OtherBooks.CheckBitFlag(ib+32)) totbkrd++;
			}
			totbkrd += Math.floor(sd.TotalBooksRead / 2) + Math.floor(sd.TotalPoetryRead / 2) + sd.TotalScrollsRead + sd.TotalScriptureRead + sd.TotalKamasutraRead;
			return totbkrd;
		case 1022: return sd.TotalLibrary;
		case 1023: return sd.TotalOnsen;
		case 1030: return sd.TotalWalkBeach +sd. TotalWalkForest +sd. TotalWalkFarm + sd.TotalWalkPalace + sd.TotalWalkSlums + sd.TotalWalkLake + sd.TotalWalkTownCenter + sd.TotalWalkDocks + sd.TotalWalkRuins + sd.TotalWalkSlaveMarket + sd.TotalWalkHouse + sd.TotalWalkCustom;
		case 1031: return sd.TotalCockMilk;
		case 1032: return sd.TotalSinging;
		case 1033: return sd.TotalSwimming;
		case 2001: return sd.BitFlag1.CheckBitFlag(35) ? 1 : 0;
		case 2002: return sd.BitFlag1.CheckBitFlag(30) ? 1 : 0;
		case 2003: return sd.BitFlag1.CheckBitFlag(28) ? 1 : 0;
		case 2004: return sd.BitFlag1.CheckBitFlag(29) ? 1 : 0;
		case 2005: return sd.TotalVisit;
		
		case 2501: return SMData.TotalSMMartial;
		case 2502: return SMData.TotalSMPray;
		case 2503: return SMData.TotalSMBar; 
		case 2504: return SMData.TotalSMCourt; 
		case 2505: return TotalWalkSlaveMarket; 
		case 2506: return currentCity.GetShopInstanceString("Armoury").bInitialVisit ? 1 : 0; 
		case 2507: return SMData.NumDealer; 
		case 2508: return NumMerchant; 
		case 2510: return SMData.TotalSMSleazyBar; 
		case 2515: return SMData.TotalSMSpecial;
		case 2516: return SMData.TotalSMCustom;
		case 2517: return SMData.TotalSMTalkSlaves;
	}
	
	if (sd == _root) sd = slaveData;
	var act:ActInfo = sd.ActInfoBase.GetActAbs(type);
	if (act == null) return 0;
	return act.TotalDone;
}

function IncreaseActTotal(type:Object, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	
	var ret:Number = 0;
	var sdobj:Object = sd;
	if (sdobj == _root) sdobj = slaveData;
	var act:ActInfo = sdobj.ActInfoBase.GetActAbs(type);
	if (act != null) {
		if (act.strNodeName == "SlaveJob1") sd.TotalSlaveJob1++;
		else if (act.strNodeName == "SlaveJob2") sd.TotalSlaveJob2++;
		else if (act.strNodeName == "SlaveJob3") sd.TotalSlaveJob3++;
		else if (act.strNodeName == "SlaveChore1") sd.TotalSlaveChore1++;
		else if (act.strNodeName == "SlaveChore2") sd.TotalSlaveChore2++;
		else if (act.strNodeName == "SlaveChore3") sd.TotalSlaveChore3++;
		else if (act.strNodeName == "SlaveSex1") sd.TotalSex1++;
		else if (act.strNodeName == "SlaveSex2") sd.TotalSex2++;
		else if (act.strNodeName == "SlaveSex3") sd.TotalSex3++;
		else if (act.strNodeName == "SlaveSex4") sd.TotalSex4++;
		ret = act.TotalDone++;
	}
	
	switch (Math.floor(Math.abs(Number(type)))) {
		case 1017:
		case 1: return sd.TotalBreak++;
		case 2: return sd.TotalTouch++;
		case 3: return sd.TotalLick++;
		case 4: return sd.TotalFuck++;
		case 99:
		case 5: return sd.TotalBlowjob++;
		case 6: return sd.TotalTitsFuck++;
		case 7: return sd.TotalAnal++;
		case 8: return sd.TotalMasturbate++;
		case 9: return sd.TotalDildo++;
		case 10: return sd.TotalPlug++;
		case 11: return sd.TotalLesbian++;
		case 12: return sd.TotalBondage++;
		case 13: return sd.TotalNaked++;
		case 15: return sd.TotalGangBang++;
		case 16: return sd.TotalLendHer++;
		case 17: return sd.TotalPony++;
		case 18: return sd.TotalSpank++;
		case 19: return sd.TotalThreesome++;
		case 20: return sd.Total69++;
		case 21: return sd.TotalGroup++;
		case 22: return 1;
		case 23: return sd.TotalKiss++;
		case 24: return sd.TotalStripTease++;
		case 25: return sd.TotalCumBath++;
		case 30: return sd.TotalFootjob++;
		case 31: return sd.TotalHandjob++;
		case 1001: return sd.TotalCooking++;
		case 1002: return sd.TotalCleaning++;
		case 1003: return sd.TotalExercise++;
		case 1004: return sd.TotalDiscuss++;
		case 1005: return sd.TotalMakeUp++;
		case 1006: return sd.TotalSciences++;
		case 1007: return sd.TotalTheology++;
		case 1008: return sd.TotalRefinement++;
		case 1009: return sd.TotalDance++;
		case 1010: return sd.TotalXXX++;
		case 1011: return sd.TotalExpose++;
		case 1012: return sd.TotalRestaurant++;
		case 1013: return sd.TotalAcolyte++;
		case 1014: return sd.TotalBar++;
		case 1015: return sd.TotalSleazyBar++;
		case 1016: return sd.TotalBrothel++;
		case 1022: return sd.TotalLibrary++;
		case 1023: return sd.TotalOnsen++;
		case 1031: return sd.TotalCockMilk++;
		case 1032: return sd.TotalSinging++;
		case 1033: return sd.TotalSwimming++;
		case 2001: sd.BitFlag1.SetBitFlag(35); return 1;
		case 2002: sd.BitFlag1.SetBitFlag(30); return 1;
		case 2003: sd.BitFlag1.SetBitFlag(28); return 1;
		case 2004: sd.BitFlag1.SetBitFlag(29); return 1;
		case 2005: return sd.TotalVisit++;
		
		case 2501: return SMData.TotalSMMartial++;
		case 2502: return SMData.TotalSMPray++;
		case 2503: return SMData.TotalSMBar++; 
		case 2504: return SMData.TotalSMCourt++; 
		case 2505: return TotalWalkSlaveMarket++; 
		//case 2506: return currentCity.GetShopInstanceString("Armoury").TotalVisit++;
		case 2507: return SMData.NumDealer++; 
		case 2508: return NumMerchant++; 
		case 2510: return SMData.TotalSMSleazyBar++; 
		case 2515: return SMData.TotalSMSpecial++;
		case 2516: return SMData.TotalSMCustom++;
		case 2517: return SMData.TotalSMTalkSlaves++;
	}
	return ret;
}

function SetActTotal(type:Object, val:Number, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	
	switch (Math.floor(Math.abs(Number(type)))) {
		case 1017:
		case 1: return sd.TotalBreak = val;
		case 2: return sd.TotalTouch = val;
		case 3: return sd.TotalLick = val;
		case 4: return sd.TotalFuck = val;
		case 99:
		case 5: return sd.TotalBlowjob = val;
		case 6: return sd.TotalTitsFuck = val;
		case 7: return sd.TotalAnal = val;
		case 8: return sd.TotalMasturbate = val;
		case 9: return sd.TotalDildo = val;
		case 10: return sd.TotalPlug = val;
		case 11: return sd.TotalLesbian = val;
		case 12: return sd.TotalBondage = val;
		case 13: return sd.TotalNaked = val;
		case 15: return sd.TotalGangBang = val;
		case 16: return sd.TotalLendHer = val;
		case 17: return sd.TotalPony = val;
		case 18: return sd.TotalSpank = val;
		case 19: return sd.TotalThreesome = val;
		case 20: return sd.Total69 = val;
		case 21: return sd.TotalGroup = val;
		case 22: return 1;
		case 23: return sd.TotalKiss = val;
		case 24: return sd.TotalStripTease = val;
		case 25: return sd.TotalCumBath = val;
		case 26: return sd.TotalSex1 = val;
		case 27: return sd.TotalSex2 = val;
		case 28: return sd.TotalSex3 = val;
		case 29: return sd.TotalSex4 = val;
		case 30: return sd.TotalFootjob = val;
		case 31: return sd.TotalHandjob = val;
		case 1001: return sd.TotalCooking = val;
		case 1002: return sd.TotalCleaning = val;
		case 1003: return sd.TotalExercise = val;
		case 1004: return sd.TotalDiscuss = val;
		case 1005: return sd.TotalMakeUp = val;
		case 1006: return sd.TotalSciences = val;
		case 1007: return sd.TotalTheology = val;
		case 1008: return sd.TotalRefinement = val;
		case 1009: return sd.TotalDance = val;
		case 1010: return sd.TotalXXX = val;
		case 1011: return sd.TotalExpose = val;
		case 1012: return sd.TotalRestaurant = val;
		case 1013: return sd.TotalAcolyte = val;
		case 1014: return sd.TotalBar = val;
		case 1015: return sd.TotalSleazyBar = val;
		case 1016: return sd.TotalBrothel = val;
		case 1022: return sd.TotalLibrary = val;
		case 1023: return sd.TotalOnsen = val;
		case 1031: return sd.TotalCockMilk = val;
		case 1032: return sd.TotalSinging = val;
		case 1033: return sd.TotalSwimming = val;
		case 2001: sd.BitFlag1.SetBitFlag(35); return 1;
		case 2002: sd.BitFlag1.SetBitFlag(30); return 1;
		case 2003: sd.BitFlag1.SetBitFlag(28); return 1;
		case 2004: sd.BitFlag1.SetBitFlag(29); return 1;
		case 2005: return sd.TotalVisit = val;
		
		case 2501: return SMData.TotalSMMartial = val;
		case 2502: return SMData.TotalSMPray = val;
		case 2503: return SMData.TotalSMBar = val; 
		case 2504: return SMData.TotalSMCourt = val; 
		case 2505: return TotalWalkSlaveMarket = val; 
		//case 2506: return Armoury.TotalVisit = val;
		case 2507: return SMData.NumDealer = val; 
		case 2508: return NumMerchant = val; 
		case 2510: return SMData.TotalSMSleazyBar = val; 
		case 2515: return SMData.TotalSMSpecial = val;
		case 2516: return SMData.TotalSMCustom = val;
		case 2517: return SMData.TotalSMTalkSlaves = val;
	}
	
	if (sd == _root) sd = slaveData;
	var act:ActInfo = sd.ActInfoBase.GetActAbs(type);
	if (act == null) return 0;
	return act.TotalDone = val;
}

// OBSOLETE
function GetTotalSlavesOwned(nosmassist:Boolean) : Number { return SMData.GetTotalSlavesOwned(nosmassist); }
function IsSlaveTrained(slave:String) : Boolean { return SMData.IsSlaveTrained(slave); }
function IsSlaveOwned(slave:String) : Boolean { return SMData.IsSlaveOwned(slave); }
function IsSlaveOwnedByIndex(idx:Number) : Boolean { return SMData.IsSlaveOwnedByIndex(idx); }
function GetSlaveDetails(slave:String) : Slave { return SMData.GetSlaveDetails(slave, false); }
function GetSlaveDetailsByName(slave:String) : Slave { return SMData.GetSlaveDetailsByName(slave); }
function GetSlaveDetailsFromFilename(slave:String) : Slave { return SMData.GetSlaveDetailsFromFilename(slave); }
function GetSlaveDetailsFromImageName(slave:String) : Slave { return SMData.GetSlaveDetailsFromImageName(slave); }
function GetTotalOtherMinorSlaves() : Number { return SMData.GetTotalOtherMinorSlaves(); }
function SetSlaveAvailable(slave:String, avail:Boolean) { SMData.SetSlaveAvailable(slave); }

// Images
function ShowActImage(oact:Object, place:Number, frame:Number)
{
	if (!slaveData.ShowActImage(oact, place, 1, frame)) UseGeneric = true;
}

function SelectActImage(noxml:Boolean, oact:Object) : Boolean { return slaveData.SelectActImage(noxml, oact); }

// Dresses
// Dress Functions

function IsNakedDressAvailable() : Boolean { return SMData.IsNakedDressAvailable(); }
function IsDressEasy(dress:Number) : Boolean { return slaveData.IsDressEasy(dress); }
function IsDressCourtly(dress:Number) : Boolean { return slaveData.IsDressCourtly(dress); }
function IsDressSwimsuit(dress:Number) : Boolean { return slaveData.IsDressSwimsuit(dress); }
function IsDressSleazyBar(dress:Number) : Boolean { return slaveData.IsDressSleazyBar(dress); }
function IsDressSlutty(dress:Number) : Boolean { return slaveData.IsDressSlutty(dress); }
function IsDressDancing(dress:Number) : Boolean { return slaveData.IsDressDancing(dress); }
function IsDressMaid(dress:Number) : Boolean { return slaveData.IsDressMaid(dress); }
function IsDressLingerie(dress:Number) : Boolean
{
	if (dress == undefined) dress = DressWorn;
	return slaveData.IsDressLingerie(dress);
}

function IsDressMiko(dress:Number) : Boolean { return slaveData.IsDressMiko(dress); }
function IsDressWaitress(dress:Number) : Boolean { return slaveData.IsDressWaitress(dress); }
function IsDressHoly(dress:Number) : Boolean { return slaveData.IsDressHoly(dress); }
function IsDressDemonic(dress:Number) : Boolean { return slaveData.IsDressDemonic(dress); }
function SetDressEasy(dress:Number) { slaveData.SetDressEasy(dress); }
function SetDressCourtly(dress:Number) { slaveData.SetDressCourtly(dress); }
function SetDressSwimsuit(dress:Number) { slaveData.SetDressSwimsuit(dress); }
function SetDressSleazyBar(dress:Number) { slaveData.SetDressSleazyBar(dress); }
function SetDressSlutty(dress:Number) { slaveData.SetDressSlutty(dress); }
function SetDressDancing(dress:Number) { slaveData.SetDressDancing(dress); }
function SetDressMaid(dress:Number) { slaveData.SetDressMaid(dress); }
function SetDressLingerie(dress:Number) { slaveData.SetDressLingerie(dress); }
function SetDressMiko(dress:Number) { slaveData.SetDressMiko(dress); }
function SetDressWaitress(dress:Number) { slaveData.GetDress(dress).SetDressWaitress(); }
function SetDressHoly(dress:Number) { slaveData.SetDressHoly(dress); }
function SetDressDemonic(dress:Number) { slaveData.SetDressDemonic(dress); }
function SetDressDetails(dress:Number, short:String, desc:String, forsale:Boolean, price:Number) { slaveData.SetDressDetails(dress, short, desc, forsale, price); }
function SetDressStats(dress:Number, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Joy:Number, Special:Number, Special2:Number) { slaveData.SetDressStats(dress, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Joy, Special, Special2); }	
function SetDressStatsByArray(dress:Number, se:Array) { slaveData.SetDressStatsByArray(dress, se); }
function GetDressName(dress:Number) : String { return slaveData.GetDressName(dress); }
function GetTotalDresses() : Number { return slaveData.GetTotalDresses(); }
function IsDressOwned(dress:Number) : Boolean { return slaveData.IsDressOwned(dress); }
function SetDressOwned(dress:Number, own:Boolean) { slaveData.SetDressOwned(dress, own); }
function IsDressForSale(dress:Number) : Boolean { return slaveData.IsDressForSale(dress); }
function SetDressForSale(dress:Number, sold:Boolean) { slaveData.SetDressForSale(dress, sold); }

// Own

function IsDressSwimsuitOwned() : Number { return slaveData.IsDressSwimsuitOwned(); }
function IsDressCourtlyOwned() : Number { return slaveData.IsDressCourtlyOwned(); }
function IsDressMaidOwned() : Number { return slaveData.IsDressMaidOwned(); }
function IsDressLingerieOwned() : Number { return slaveData.IsDressLingerieOwned(); }
function IsDressSleazyBarOwned() : Number { return slaveData.IsDressSleazyBarOwned(); }
function IsDressDancingOwned() : Number { return slaveData.IsDressDancingOwned(); }
function IsDressEasyOwned() : Number { return slaveData.IsDressEasyOwned(); }
function IsDressSluttyOwned() : Number { return slaveData.IsDressSluttyOwned(); }
function IsDressMikoOwned() : Number { return slaveData.IsDressMikoOwned(); }
function IsDressWaitressOwned() : Number { return slaveData.IsDressWaitressOwned(); }
function IsDressHolyOwned() : Number { return slaveData.IsDressHolyOwned(); }
function IsDressDemonicOwned() : Number { return slaveData.IsDressDemonicOwned(); }
function IsDressWorn(dress:Number) {
	if (dress == undefined) return true;
	return dress == DressWorn;
}

function IsDressCatEarsOwned() : Number { return slaveData.IsDressCatEarsOwned(); }
function IsDressCatTailOwned() : Number { return slaveData.IsDressCatTailOwned(); }
function SetDressCatEars(dress:Number) { slaveData.SetDressCatEars(dress); }
function SetDressCatTail(dress:Number) { slaveData.SetDressCatTail(dress); }
function IsDressCatEars(dress:Number) : Boolean { return slaveData.IsDressCatEars(dress); }
function IsDressCatTail(dress:Number) : Boolean { return slaveData.IsDressCatTail(dress); }
function IsDressPuppyEarsOwned() : Number { return slaveData.IsDressPuppyEarsOwned(); }
function IsDressPuppyTailOwned() : Number { return slaveData.IsDressPuppyTailOwned(); }
function SetDressPuppyEars(dress:Number) { slaveData.SetDressPuppyEars(dress); }
function SetDressPuppyTail(dress:Number) { slaveData.SetDressPuppyTail(dress); }
function IsDressPuppyEars(dress:Number) : Boolean {	return slaveData.IsDressPuppyEars(dress); }
function IsDressPuppyTail(dress:Number) : Boolean {	return slaveData.IsDressPuppyTail(dress); }

// Marriage

function IsMarried() : Boolean { return BitFlag1.CheckBitFlag(61); }
function IsProposed() : Boolean { return BitFlag1.CheckBitFlag(60); }

// Pregnancy

// notice they are pregnant
function IsPregnant(sd:Object) : Boolean
{
	if (sd == undefined) sd = _root;
	return sd.PregnancyGestation > 0;
}

// Impregnate
function CanImpregnate(type:String) : Boolean
{
	if (PregnancyGestation > 0 || PregnancyOn == false || SlaveGender == 0 || SlaveGender == 1 || SlaveGender == 4) return false;
	var fer:Number = Fertility;
	if (!BitFlag1.CheckBitFlag(14)) fer = 0;
	if (type.toLowerCase() == "yours" && SMData.Gender == 2) {
		if (!SMData.SMFeeldoOK) return false;
	}
	return (PercentChance(fer) || type.toLowerCase() == "tentacle" || type.toLowerCase() == "tentacles");
}	

function CheckImpregnate(type:String, count:Number, gestation:Number) : Boolean
{
	if (CanImpregnate(type)) {
		Impregnate(type, count, gestation);
		return true;
	}
	return false;
}	

function Impregnate(type:String, count:Number, gestation:Number)
{
	if (PregnancyGestation > 0 || PregnancyOn == false || SlaveGender == 0 || SlaveGender == 1 || SlaveGender == 4) return;
	
	if (type.toLowerCase() == "yours" && SMData.SMSpecialEvent == 2) type = "YoursTentacle";
	PregnancyType = type;
	if (gestation == undefined) {
		if (type.toLowerCase() == "human" || type.toLowerCase() == "yours") {
			var gest:Number = XMLData.GetXMLValue("BaseGestation", slaveNode, config.nBaseGestation);
			PregnancyGestation = gest + Math.floor(Math.random()*10);
		} else PregnancyGestation = 28 + Math.floor(Math.random()*5);
	} else PregnancyGestation = gestation;
	if (count == undefined) PregnancyCount = 1;
	else PregnancyCount = count;
	if (type.toLowerCase() == "yourstentacle" || type.toLowerCase() == "tentacle" || type.toLowerCase() == "tentacles") TentaclePregnancy = PregnancyGestation;
}

function CheckSMImpregnate(type:String, count:Number, gestation:Number) : Boolean { return SMData.CheckImpregnate(type, count, gestation); }

function SMImpregnate(type:String, count:Number, gestation:Number) { SMData.Impregnate(type, count, gestation); }


// Increase pregnancy
function AddToPregnancy(count:Number)
{
	if (PregnancyGestation > 0) PregnancyCount += count;
}

// Special Stat
var SpecialName:String;
var Special2Name:String;

function ChangeSpecial(diff:Number) { Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, diff); }

function SetSpecialStat(slabel:String)
{
	if (slabel != undefined) SpecialName = slabel;
}

function ShowSpecialStat(slabel:String)
{
	ShowSpecial = 1;
	if (slabel != undefined) SpecialName = slabel;
	if (dspMain.GetGameTab() == 2) dspMain.ShowStatisticsTab(1);
}

function HideSpecialStat()
{
	ShowSpecial = 0;
	if (dspMain.GetGameTab() == 2) dspMain.ShowStatisticsTab(1);
}

function ChangeSpecial2(diff:Number) { Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, diff); }

function SetSpecial2Stat(slabel:String)
{
	if (slabel != undefined) Special2Name = slabel;
}

function ShowSpecial2Stat(slabel:String)
{
	ShowSpecial2 = 1;
	if (slabel != undefined) Special2Name = slabel;
}

function HideSpecial2Stat() { ShowSpecial2 = 0; }


// Paths

function ChangePath(p1:Number, p2:Number, p3:Number)
{
	Path1 += p1;
	if (p2 != undefined) {
		Path2 += p2;
		if (p3 != undefined) Path3 += p3;
	}
}

function UpdateCurrentPath()
{
	if (Path3 > Path2 && Path3 > Path1) MaxPath = 3;
	else if (Path2 > Path1 && Path2 > Path3) MaxPath = 2;
	else if (Path1 > Path2 && Path1 > Path3) MaxPath = 1;
	else MaxPath = 0;
	CurrentPath = MaxPath;
	SlaveGirl.CurrentPath = CurrentPath;
	SlaveGirl.MaxPath = CurrentPath;
}

// Speech Suffix
function AddSpeechSuffix(chance:Number, suff:String)
{
	SpeechSuffix = suff;
	SpeechSuffixChance = chance == undefined ? 100 : chance;
}

function SetSexuality(newsexuality:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	sd.Sexuality = newsexuality;
	AlterSexuality(0, sd);
}

function AlterSexuality(sex:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	
	UpdateFactors(sd);

	var nv:Number = sd.Sexuality + (sex * SexualityFactor);
	
	if (sd.LesbianInterest != -1) {
		if (sd.Sexuality < 25 && nv >= 25) nv = 24;
		else if (sd.Sexuality >= 25 && nv < 25) nv = 25;
		else if (sd.Sexuality <= 75 && nv > 75) nv = 76;
	}
	
	sd.Sexuality = nv;
	if (sd.Sexuality < 0) sd.Sexuality = 0;
	if (sd.Sexuality > 100) sd.Sexuality = 100;
	if (sd == _root) dspMain.UpdateSexuality(sd.Sexuality);
}

// love

var LoveAccepted:Number;
var NobleLoveType:Number;
var NobleLove:Number;

// stats
var CustomFlag:Number;
var CustomFlag1:Number;
var CustomFlag2:Number;
var CustomFlag3:Number;
var CustomFlag4:Number;
var CustomFlag5:Number;
var CustomFlag6:Number;
var CustomFlag7:Number;
var CustomFlag8:Number;
var CustomFlag9:Number;
var CustomString:String;

var StatRate:Number;
var MaxStat:Number;

var Behaving:Number;
var PlugInserted:Number;

var Deficiency:Number;
var NaturalTalent:Number;

var SlaveName:String;
var SlaveName1:String;
var SlaveName2:String;
//var SlaveImage:String;
var SlavePronoun:String;

var DoneCourtesan:Boolean;
var Naked:Boolean;
var DoneNaked:Number;
var DoneMaster:Number;
var Aroused:Boolean
var SlaveAttitude:Number;  // 0 = normal, 1 = sexy, 2 = angry, 3 = heroine

var TotalTeddyBear:Number;
var TotalGames:Number;
var TotalJewelry:Number;
var TotalDoll:Number;
var TotalBooks:Number;
var TotalPoetry:Number;
var DurationHairCare:Number;
var DurationFacialCare:Number;
var DurationMakeupCare:Number; 

var Path1:Number;
var Path2:Number;
var Path3:Number;
var CurrentPath:Number;
var MaxPath:Number;
var Trust:Number;
var Available:Boolean;

var VarIdol:Number;
var PuppyGirlFlag:Number;
var VarSchoolGirl:Number;

var PotionsUsed:Array;

var vitalsBust:Number;
var vitalsBustStart:Number;
var vitalsBustCurrent:Number;
var vitalsWaist:Number;
var vitalsHips:Number;
var vitalsAge:Number;
var vitalsDescription:String;
var vitalsWeight:Number;
var vitalsHeight:Number;
var ClitCockSize:Number;
var ClitCockSizeStart:Number;

var HasTesticles:Boolean;
var DickgirlXF:Number;

var vitalsBloodType:String;
var vitalsBloodTypeSM:String;

var PregnancyGestation:Number;
var PregnancyType:String;
var PregnancyCount:Number;
var TotalTentaclePregnancy:Number;
var Fertility:Number;
// obsolete, to be deleted
var TentaclePregnancy:Number;
var SMTotalTentaclePregnancy:Number;

var SlaveFilename:String = "";

// -1 = will not become ine
//  2000 = is a cumslut
var CumslutLevel:Number;

// -1 = will not become 0ne
//  2000 = is a Succubus
var slSuccubusTraining:Number;

var strCombatDescription:String;
var strCombatHint:String;


// slave maker variables

var SlaveMakerName:String;
var SMLust:Number;
var SMConstitution:Number;
var SMAttack:Number;
var SMDefence:Number;
var SMConversation:Number;
var SMReputation:Number;
var SMDominance:Number;
var ArousalDefence:Number;
var SMFaith:Number;  // 1 = new, 2 = old, 3 = none
var Corruption:Number;
var SGMasterName:String;
var Master:String;
var GirlsTrained:Number;
var SMMinCorruption:Number;
var SMMinLust:Number;
var SMCharisma:Number;
var SMRefinement:Number;
var SMNymphomania:Number;
var SMTiredness:Number;
var GuildMember:Boolean = true;

var SMHomeTown:Number;
var SMSpecialEvent:Number;

var Talent:Number;

var OtherBooks:BitFlags;

// Dresses
var DressWorn:Number;
var DressToWear:Number;
var NakedChoice:Number;
var DressFrame:Number;

var SellBunnySuit:Number;
var SellLingerie:Number
var SellMaidUniform:Number
var SellSwimsuit:Number
var LingerieOK:Number;
var BunnySuitOK:Number;
var MaidUniformOK:Number;
var SwimsuitOK:Number;

var ArmourType:Number;
var WeaponType:Number;

function ChoiceNaked(range:Number, offset:Number) : Number
{
	NakedChoice = slaveData.ChoiceNaked(range, offset);
	return NakedChoice;
}

var PositionHaloSimple:Function = PositionHalo;

function ShowRobes() { ShowDress(); }
function HideRobes() { HideDresses(); }

// Milking
var Milkable:Boolean;
var Lactation:Number;
var BreastFixation:Number;
var MilkBuildUp:Number;

function SetMilkEffects(lact:Number, bf:Number, md:Number, bu:Number)
{
	if (lact != undefined) Lactation = lact;
	if (bf != undefined) BreastFixation = bf;
	if (md != undefined) MilkInfluence = md;
	if (bu != undefined) MilkBuildUp = bu;
}

function ChangeMilkEffects(lact:Number, bf:Number, md:Number, bu:Number)
{
	if (lact == undefined) lact = 0;
	if (bf == undefined) bf = 0;
	if (md == undefined) md = 0;
	if (bu == undefined) bu = 0;
	SetMilkEffects(Lactation + lact, BreastFixation + bf, MilkInfluence > 0 ? MilkInfluence + md : MilkInfluence, MilkBuildUp + bu);
}


// House

var House:Number;		// Obsolete

// Gender
function IsFemale() : Boolean { return SlaveGender != 0 && SlaveGender != 1 && SlaveGender != 4; }
function IsWoman() : Boolean { return SlaveGender == 2 || SlaveGender == 5; }
function IsMale() : Boolean { return SlaveGender == 1 || SlaveGender == 4; }
function IsTwins() : Boolean { return SlaveGender > 3; }	

var Gender:Number = 1;
var OldGender:Number;

var SlaveGender:Number;
var SlaveGenderBorn:Number;


function InitialiseMaxObedience(maxo:Number, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	sd.MaxObedience = Math.ceil(maxo * (1 + ((StatRate - 1) / 2)));
	return sd.MaxObedience;
}

// Money
var SMGold:Number;
var SMDebt:Number;
var VarGold:Number;

// Date/Time
var TrainingTime:Number;
var MoonPhaseDate:Number;
var GameDate:Number;
var GameTimeMins:Number;

// Special backgrounds
function IsDominatrix() : Boolean {	return SMData.IsDominatrix(); }
function IsDickgirlAmazon() : Boolean { return SMData.IsDickgirlAmazon(); }

/*
ChangeMaxStats(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Joy, Love, Special);
<ChangeMaxStats>Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Joy, Love, Special</ChangeMaxStats>
*/
function ChangeMaxStats(nCharisma:Number, nSensibility:Number, nRefinement:Number, nIntelligence:Number, nMorality:Number, nConstitution:Number, nCooking:Number, nCleaning:Number, nConversation:Number, nBlowJob:Number, nFuck:Number, nTemperament:Number, nNymphomania:Number, nObedience:Number, nLust:Number, nJoy:Number, nSpecial:Number, nSpecial2:Number, nLove:Number)
{
	MaxCharisma = SlaveStatistics.CapMax(MaxCharisma, nCharisma, AssistantMaxCharisma);
	MaxSensibility = SlaveStatistics.CapMax(MaxSensibility, nSensibility, AssistantMaxSensibility);
	MaxRefinement = SlaveStatistics.CapMax(MaxRefinement, nRefinement, AssistantMaxRefinement);
	MaxIntelligence = SlaveStatistics.CapMax(MaxIntelligence, nIntelligence, AssistantMaxIntelligence);
	MaxMorality = SlaveStatistics.CapMax(MaxMorality, nMorality, AssistantMaxMorality);
	MaxConstitution = SlaveStatistics.CapMax(MaxConstitution, nConstitution, AssistantMaxConstitution);
	MaxCooking = SlaveStatistics.CapMax(MaxCooking, nCooking, AssistantMaxCooking);
	MaxCleaning = SlaveStatistics.CapMax(MaxCleaning, nCleaning, AssistantMaxCleaning);
	MaxConversation = SlaveStatistics.CapMax(MaxConversation, nConversation, AssistantMaxConversation);
	MaxBlowJob = SlaveStatistics.CapMax(MaxBlowJob, nBlowJob, AssistantMaxBlowJob);
	MaxFuck = SlaveStatistics.CapMax(MaxFuck, nFuck, AssistantMaxFuck);
	MaxTemperament = SlaveStatistics.CapMax(MaxTemperament, nTemperament, AssistantMaxTemperament);
	MaxNymphomania = SlaveStatistics.CapMax(MaxNymphomania, nNymphomania, AssistantMaxNymphomania);
	MaxObedience = SlaveStatistics.CapMax(MaxObedience, nObedience, AssistantMaxObedience);
	MaxLibido = SlaveStatistics.CapMax(MaxLibido, nLust, AssistantMaxLibido);
	MaxJoy = SlaveStatistics.CapMax(MaxJoy, nJoy, AssistantMaxJoy);
	MaxSpecial = SlaveStatistics.CapMax(MaxSpecial, nSpecial, 100);
	MaxSpecial2 = SlaveStatistics.CapMax(MaxSpecial2, nSpecial2, 100);
	MaxLove = SlaveStatistics.CapMax(MaxLove, nLove, 100);
	
	LimitAllStats(_root);
	UpdateSlave();
}

/*
ChangeMinStats(Nymphomania, Lust);
<ChangeMinStats>Nymphomania, Lust</ChangeMinStats>
*/
function ChangeMinStats(Nymphomania:Number, Lust:Number)
{	
	if (!isNaN(Lust)) MinLibido += Lust;
	if (!isNaN(Nymphomania)) MinNymphomania += Nymphomania;
	
	LimitAllStats(_root);
	UpdateSlave();
}

function TestObedienceBase(diff:Number, act:Number) : Boolean
{
	slaveData.CopyCommonDetails(_root);
	return slaveData.IsObedient(diff, act);
}

function LimitStat(stat:Number, inc:Number, max:Number) : Number
{
	return Math.ceil(SMData.LimitStat(stat, inc, max));
}



// ponygirls
var DonePonygirl:Number;

function ChangePonyTraining(val:Number)
{
	if (val != undefined) {
		slPonyTraining = slaveData.LimitStat(slPonyTraining, val, 40 + (sPonyTrainer * 20));
		var ponyindex:Number = slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("PonyTraining", "Skills"));
		arSkillArray[ponyindex].PlusIcon._visible = true;
	}
	UpdateBasicSlaveSkills();
}

// State function
// this must mirror the version in the class Slave
function IsPonygirl() : Boolean
{
	return DonePonygirl == 1;
}

function ShowStatIcons(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Special:Number, Special2:Number, SexualEnergy:Number) {
	
	var lestr:Boolean = BitFlag1.CheckBitFlag(10) && !IsMale();
	
	if (VarCharisma < MaxStat && Charisma>0) slaveData.IconValue(StatisticsGroup.Charisma, Charisma);
	if (VarRefinement  < MaxStat && Refinement>0) slaveData.IconValue(StatisticsGroup.Refinement, Refinement);
	if (VarSensibility < MaxStat && Sensibility>0) slaveData.IconValue(StatisticsGroup.Sensibility, Sensibility);
	if (VarIntelligence < MaxStat && Intelligence>0) slaveData.IconValue(StatisticsGroup.Intelligence, Intelligence);
	if (VarMorality < MaxStat && Morality>0) slaveData.IconValue(StatisticsGroup.Morality, Morality);
	if (VarConstitution < MaxStat && Constitution>0) slaveData.IconValue(StatisticsGroup.Constitution, Constitution);
	if (VarCooking < MaxStat && Cooking>0) slaveData.IconValue(StatisticsGroup.Cooking, Cooking);
	if (VarCleaning < MaxStat && Cleaning>0) slaveData.IconValue(StatisticsGroup.Cleaning, Cleaning);
	if (VarConversation < MaxStat && Conversation>0) slaveData.IconValue(StatisticsGroup.Conversation, Conversation);
	if (lestr) {
		var maxlesbian:Number = currLesbianTrainer * 100;
		if (VarCunnilingus < maxlesbian && BlowJob>0) slaveData.IconValue(StatisticsGroup.Blowjobs, BlowJob);
		if (VarLesbianFuck < maxlesbian && Fuck>0) slaveData.IconValue(StatisticsGroup.Fucking, Fuck);
		if (VarCunnilingus > 0 && BlowJob<0) slaveData.IconValue(StatisticsGroup.BlowJobs, BlowJob);
		if (VarLesbianFuck > 0 && Fuck<0) slaveData.IconValue(StatisticsGroup.Fucking, Fuck);
	} else {
		if (VarBlowJob > 0 && BlowJob<0) slaveData.IconValue(StatisticsGroup.Blowjobs, BlowJob);
		if (VarFuck > 0 && Fuck<0) slaveData.IconValue(StatisticsGroup.Fucking, Fuck);
		if (VarBlowJob < MaxBlowJob && BlowJob>0) slaveData.IconValue(StatisticsGroup.BlowJobs, BlowJob);
		if (VarFuck < MaxFuck && Fuck>0) slaveData.IconValue(StatisticsGroup.Fucking, Fuck);
	}
	if (VarTemperament < MaxStat && Temperament>0) slaveData.IconValue(StatisticsGroup.Temperament, Temperament);
	if (VarNymphomania < MaxStat && Nymphomania>0) slaveData.IconValue(StatisticsGroup.Nymphomania, Nymphomania);
	if (VarObedience < MaxStat && Obedience>0) slaveData.IconValue(StatisticsGroup.Obedience, Obedience); 
	if (VarLibido < MaxStat && Lust>0) slaveData.IconValue(StatisticsGroup.Lust, Lust);
	if (VarReputation < MaxStat && Reputation>0) slaveData.IconValue(StatisticsGroup.Reputation, Reputation);
	if (VarJoy < MaxStat && Joy>0) slaveData.IconValue(StatisticsGroup.Joy, Joy);
	if (VarFatigue < 100 && Fatigue>0) slaveData.IconValue(StatisticsGroup.Tiredness, Fatigue);
	if (Special != undefined && ShowSpecial == 1) if (VarSpecial < MaxSpecial && Special>0) slaveData.IconValue(StatisticsGroup.Special, Special);
	if (SexualEnergy != undefined && IsSuccubus()) if (VarSexualEnergy < 100 && SexualEnergy>0) slaveData.IconValue(StatisticsGroup.SexualEnergy, SexualEnergy);

	if (VarCharisma > 0 && Charisma<0) slaveData.IconValue(StatisticsGroup.Charisma, Charisma);
	if (VarRefinement  > 0 && Refinement<0) slaveData.IconValue(StatisticsGroup.Refinement, Refinement);  
	if (VarSensibility > 0 && Sensibility<0) slaveData.IconValue(StatisticsGroup.Sensibility, Sensibility); 
	if (VarIntelligence > 0 && Intelligence<0) slaveData.IconValue(StatisticsGroup.Intelligence, Intelligence);
	if (VarMorality > 0 && Morality<0) slaveData.IconValue(StatisticsGroup.Morality, Morality);
	if (VarConstitution > 0 && Constitution<0) slaveData.IconValue(StatisticsGroup.Constitution, Constitution);
	if (VarCooking > 0 && Cooking<0) slaveData.IconValue(StatisticsGroup.Cooking, Cooking);
	if (VarCleaning > 0 && Cleaning<0) slaveData.IconValue(StatisticsGroup.Cleaning, Cleaning);
	if (VarConversation > 0 && Conversation<0) slaveData.IconValue(StatisticsGroup.Conversation, Conversation);
	if (VarTemperament > 0 && Temperament<0) slaveData.IconValue(StatisticsGroup.Temperament, Temperament);
	if (VarNymphomania > 0 && Nymphomania<0) slaveData.IconValue(StatisticsGroup.Nymphomania, Nymphomania);
	if (VarObedience > 0 && Obedience<0) slaveData.IconValue(StatisticsGroup.Obedience, Obedience);

	if (VarLibido > 0 && Lust<0) slaveData.IconValue(StatisticsGroup.Lust, Lust);
	if (VarReputation > 0 && Reputation<0) slaveData.IconValue(StatisticsGroup.Reputation, Reputation);
	if (VarJoy > 0 && Joy<0) slaveData.IconValue(StatisticsGroup.Joy, Joy);
	if (VarFatigue > 0 && Fatigue<0) slaveData.IconValue(StatisticsGroup.Tiredness, Fatigue);
	if (Special != undefined && ShowSpecial == 1) if (VarSpecial > 0 && Special<0) slaveData.IconValue(StatisticsGroup.Special, Special);
	if (Special2 != undefined && ShowSpecial2 == 1) if (VarSpecial2 > 0 && Special2<0) slaveData.IconValue(StatisticsGroup.Special2, Special2);
	if (SexualEnergy != undefined && IsSuccubus()) if (VarSexualEnergy > 0 && SexualEnergy < 0) slaveData.IconValue(StatisticsGroup.SexualEnergy, SexualEnergy);
}

/*
PointsMod(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Joy, Special, Special, SexualEnergy);
<StatEffects>Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Joy, Special, Special, SexualEnergy</StatEffects>
*/
function PointsMod(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Joy:Number, Special:Number, Special2:Number, SexualEnergy:Number) {
	
	VarCharismaMod += Charisma;
	VarSensibilityMod += Sensibility;
	VarRefinementMod += Refinement;
	VarIntelligenceMod += Intelligence;
	VarMoralityMod += Morality;
	VarConstitutionMod += Constitution;
	VarCookingMod += Cooking;
	VarCleaningMod += Cleaning;
	VarConversationMod += Conversation;
	VarBlowJobMod += BlowJob;
	VarFuckMod += Fuck;
	VarTemperamentMod += Temperament;
	VarNymphomaniaMod += Nymphomania;
	VarObedienceMod += Obedience;
	VarLibidoMod += Lust;
	VarReputationMod += Reputation;
	VarJoyMod += Joy;
	if (!isNaN(Special)) VarSpecialMod += Special;
	if (!isNaN(Special2)) VarSpecial2Mod += Special2;
	if (!isNaN(SexualEnergy)) VarSexualEnergyMod += SexualEnergy;

	ShowStatIcons(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, 0, Joy, Special, Special2, SexualEnergy);

	UpdateSlave();
}

function ChangeGuildMembership(member:Boolean)
{
	SMData.ChangeGuildMembership(member);
}

function GetPersonsName(person:Number) : String
{
	return People.GetPersonsName(person);
}

// In training

function IsMasochistTraining() : Boolean
{
	return BitFlag1.CheckBitFlag(18);
}

// is the slave a cumslut (note Slave class has a version too)
function IsCumslut() : Boolean
{
	return CumslutLevel == 2000;
}

// is Succubus training happening
function IsSuccubusTraining() : Boolean
{
	return slSuccubusTraining > 0 && slSuccubusTraining != 2000;
}

function IsSuccubusComplete() : Boolean
{
	return slSuccubusTraining == 2000;
}

// is the slave a Succubus (note Slave class has a version too)
function IsSuccubus() : Boolean
{
	return slSuccubusTraining > 0;
}

// is cumslut training happening
function IsCumslutTraining() : Boolean
{
	return SMData.sSlutTrainer == 2 || AssistantData.sSlutTrainer == 2 || IsSlave("Kasumi");
}

function LimitStatFraction(stat:Number, inc:Number, max:Number) : Number
{
	return SMData.LimitStat(stat, inc, max);
}

function SetSkill(skill:String, val:Number) : Number
{
	return SMData.SetSMSkillLevel(skill, val);
}

function IsSlaveTrainedStandard(ab:String) : Boolean
{
	ab = ab.toLowerCase();
	if (ab == "ponygirl" && IsPonygirl()) return true;
	if (ab == "catgirl" && IsCatgirlComplete()) return true;
	if (ab == "puppygirl" && IsPuppygirlComplete()) return true;
	if (ab == "faerie" && IsFairy()) return true;
	if (ab == "courtesan" && DoneCourtesan) return true;
	return false;
}

function IsSlaveTrainedAs(slave:String, ab1:String, ab2:String) : Boolean
{
	var sdata:Slave = SMData.GetSlaveDetails(slave, true);
	if (sdata == null) return false;
	
	var sNode:XMLNode = GetSlaveObjectXML(sdata);
	if (sNode == null) return false;
	
	var str:String = XMLData.GetXMLStringParsed("Trainings", sNode, "").toLowerCase();
	if (ab1 != "" && str.indexOf(ab1.toLowerCase()) != -1) return true;
	if (ab2 != "" && str.indexOf(ab2.toLowerCase()) != -1) return true;
	if (sdata.IsSlaveTrainedStandard(ab1)) return true;
	return sdata.IsSlaveTrainedStandard(ab2);
}

function BuyItem(person:Object, cost:Number, smgold:Boolean) : Boolean
{
	return currentCity.Tailors.BuyItem(person, cost, smgold);
}

function GetRace() : String { return Race; }

function SetExEventVariable(str:String, val:Number, sval:String) : Number
{
	return modulesList.SetExEventVariable(str, val, sval);
}

function SetExEventBitFlag(str:String, setf:Boolean) : Boolean
{
	return modulesList.SetExEventBitFlag(str, setf);
}

function GetExEventVariable(str) : Object
{
	return modulesList.GetExEventVariable(str);
}

function GetExEventString(str) : String
{
	return modulesList.GetExEventString(str);
}

function GetExEventBitFlag(str:String) : Boolean
{
	return modulesList.GetExEventBitFlag(str);
}

function GetEventData(ename:String) : SlaveModule
{
	return modulesList.GetEventData(ename);
}


// Sex Acts

// Ponygirl
function DoSexActPonygirl() { modulesList.trainPonies.DoPlanningActionAsAssistant(17); }


// Cumsluts

var StandardCSText:Boolean;

// Alter cumslutlevel if cumslut training is happening
function ChangeCumslut(val:Number)
{
	if (!IsCumslutTraining()) return;
	if (CumslutLevel >= 0 && CumslutLevel < 100 && val != undefined) {
		CumslutLevel += val * 1.5;		// rescale to 0-100 range
		if (CumslutLevel > 100) CumslutLevel = 100;
		var csindex:Number = slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("Cumslut", "Skills"));
		arSkillArray[csindex].PlusIcon._visible = true;
		UpdateBasicSlaveSkills();
	} else if (val == undefined) UpdateBasicSlaveSkills();
}

// Alter Succubus training if Succubus training is happening
function ChangeSuccubusTraining(val:Number)
{
	if (!IsSuccubusTraining()) return;
	if (slSuccubusTraining >= 0 && slSuccubusTraining < 100 && val != undefined) {
		slSuccubusTraining += val;
		if (slSuccubusTraining > 100) slSuccubusTraining = 100;
		var succubusindex:Number = slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("SuccubusTraining", "Skills"));
		arSkillArray[succubusindex].PlusIcon._visible = true;
		UpdateBasicSlaveSkills();
	} else if (val == undefined) UpdateBasicSlaveSkills();
}


function DoVisitMenu() { currentCity.ShowVisitMenu(); }
function DoLendMenu() { currentCity.ShowLendMenu(); }

// OBSOLETE
function SetCustomContestDetails(clabel:String, desc:String)
{
	var bHide:Boolean = false;
	if (clabel != undefined) CustomContestLabel = clabel;
	if (desc != undefined) CustomContestDescription = desc;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveContest1");
	if (actno == 0) {
		actno = 2401;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, clabel, desc, "", 0, 2);
	act.Type = 11;
	if (bHide) act.HideAct();
	else act.ShowAct();
	act.strNodeName = "SlaveContest1";
}

function IsDisplayed() : Boolean { return (!OtherSlaveShown); }

function GetActButton(type:Object) : MovieClip
{
	switch (int(Math.abs(Number(type)))) {
		case 10: return MorningEveningMenu.PlugButton;
		case 13: return MorningEveningMenu.NakedButton;
		case 16: return MorningEveningMenu.LendButton;
		case 2515: return MorningEveningMenu.SpecialButton;
	}
	return null;
}

function PointsExact(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number, SexualEnergy:Number) {
	var olddmod = dmod;
	var olddiff = Difficulty;
	Difficulty = 0;
	Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
	Difficulty = olddiff;
	dmod = olddmod;
}

function PointsSlave(sd:Object, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number, SexualEnergy:Number)
{	
	sd.Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
}

/*
PointsAssistant(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2);
*/
function PointsAssistant(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number)
{
	AssistantData.Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2);
}

function UseContraceptives(buse:Boolean)
{
	if (buse) BitFlag1.ClearBitFlag(14);
	else BitFlag1.SetBitFlag(14);
}

// Expression evaluator
function GetExpression(str:String) : Number { return XMLData.GetExpression(str); }

// slave market
function ShowMarketImage(place:Number, align:Number, gframe:Number, target:MovieClip) {	ShowSlave(-50, place, align, gframe, target); }

function IsPermanentDickgirl() : Boolean
{
	if (SlaveGender == 1 || SlaveGender == 4 || SlaveGender == 0) return false;
	return DickgirlXF > 0 || SlaveGender == 3 || SlaveGender == 6;
}

function IsDickgirl() : Boolean
{
	if (SlaveGirl.IsDickgirl() == true) return true;
	if (SlaveGender == 1 || SlaveGender == 4 || SlaveGender == 0) return false;
	return DickgirlChanged || DickgirlXF > 0 || SlaveGender == 3 || SlaveGender == 6;	// || IsPermanentDickgirl() inlined for efficiency
}

function DoDGChange(chance:Number, chance2:Number) : Boolean { return DoDickgirlChange(chance, chance2); }


function SetTitle(str:String)
{
	if (Titles == "") Titles = str;
	else Titles = Titles + " " + str;
}

function GetFullName() : String
{
	if (Titles != "") return Titles + " " + SlaveName;
	return SlaveName;
}

var NumDealer:Number;

// Narana, the demon fan girl

function MeetNarana(img:Number) { currentCity.MeetPerson(39, 0, "narana", "", "" + img + ""); }

function SetBustSizeSM(bust:Number) { SMData.SetBustSize(bust); }
function ChangeBustSizeSM(val:Number) {	SMData.ChangeBustSize(val); }
function SetClitCockSizeSM(clitcock:Number) { SMData.SetClitCockSize(clitcock); }
function ChangeClitCockSizeSM(val:Number, mc:Object) { SMData.ChangeClitCockSize(val); }

function SetBustSize(bust:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	sd.vitalsBust = bust;
	var max:Number = config.GetValue("CommonDefaults/Measurements/Bust");
	if (max > 0 && sd.vitalsBust > max) sd.vitalsBust = max;

	if (sd == _root) UpdateSlave();
}

function ChangeBustSize(val:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	sd.SetBustSize(Math.ceil(sd.vitalsBust * val));
}

function SetClitCockSize(clitcock:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	if (clitcock != undefined) {
		sd.ClitCockSize = clitcock;
		var max:Number = config.GetValue("CommonDefaults/Measurements/ClitCock");
		if (max > 0 && sd.ClitCockSize > max) sd.ClitCockSize = max;
	}
	if (sd == _root) dspMain.UpdateSlaveVitals(sd);
}

function ChangeClitCockSize(val:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	SetClitCockSize(sd.ClitCockSize * val, sd);
}

function MeetAstrid()
{
	currentCity.MeetPerson(16, 0, "Astrid");
}

function MeetCuteLesbian()
{
	currentCity.MeetPerson(10, 0, "Tena");
}

function CuteGirlLesbianSex()
{
	NumEvent = 9;
	DoEventYes();
}

// Lesbian

var Lesbian:Boolean;
var LesbianTraining:Boolean;
var currLesbianTrainer:Number;
var currGayTrainer:Number;

//function IsReluctant(male:Number, female:Number, dickgirl:Number) : Boolean { return modulesList.trainLesbians.IsResistingAct(LastActionDone, male, female, dickgirl); }

function IsSlaveAvailable(slave:String) : Boolean { return SMData.IsSlaveAvailable(slave); }
function IsSlaveForSale(tNode:XMLNode) : Boolean { return IsSlaveForSale(tNode); }
function IsSlaveMinor(slave:String, aNode:XMLNode) : Boolean { return XMLData.IsSlaveMinor(slave, aNode); }
function GetSlaveObjectXML(sd:Object) : XMLNode { return XMLData.GetSlaveObjectXML(sd); }

function DoMartialTraining() { currentCity.DoMartialTraining(); }
function DoSMSleazyBar() { currentCity.DoSMSleazyBar(); }
function DoRelaxSleazyBar() { currentCity.DoRelaxSleazyBar(); }

/*
function FixSlavePath(sdata:Object, str:String)
{
	sdata.SlaveImage = Language.strReplace(sdata.SlaveImage, "Images/" + str, "Images/Slaves/" + str);
	sdata.ImageFolder = Language.strReplace(sdata.ImageFolder, "Images/" + str, "Images/Slaves/" + str);
}
*/

// Variables
var GeneralText:String = "";
var LargerText:String = "";

function GetPotionUsed(potion:Number) : Number
{
	if (potion < slaveData.PotionsUsed.length) return slaveData.PotionsUsed[potion];
	return 0;
}

function SetPotionUsed(potion:Number, num:Number)
{
	var len:Number = slaveData.PotionsUsed.length;
	if (potion < len) {
		for (var i:Number = len; i <= potion; i++) slaveData.PotionsUsed.push(0);
	}
	if (num == undefined) num = 1;
	slaveData.PotionsUsed[potion] = num;
}


function FixMax(mxs:Number) : Number { 
	if (mxs != -1) {
		if (mxs < 0) return 0;
		if (isNaN(mxs) || mxs > MaxStat) return MaxStat;
	}
	return mxs;
}
	
function LimitMaxMinStats(sd:Object)
{		
	sd.MaxSensibility = FixMax(sd.MaxSensibility);
	sd.MaxRefinement = FixMax(sd.MaxRefinement);
	sd.MaxIntelligence = FixMax(sd.MaxIntelligence);
	sd.MaxMorality = FixMax(sd.MaxMorality);
	sd.MaxCooking = FixMax(sd.MaxCooking);
	sd.MaxCleaning = FixMax(sd.MaxCleaning);
	sd.MaxConversation = FixMax(sd.MaxConversation);
	sd.MaxObedience = FixMax(sd.MaxObedience);
	sd.MaxCharisma = FixMax(sd.MaxCharisma);
	sd.MaxNymphomania = FixMax(sd.MaxNymphomania);
	if (MaxLove > 100) sd.MaxLove = 100;
	if (MaxSpecial > 100) sd.MaxSpecial = 100;
	else if (MaxSpecial < 0) sd.MaxSpecial = 0;
	if (MaxSpecial2 > 100) sd.MaxSpecial2 = 100;
	else if (MaxSpecial2 < 0) sd.MaxSpecial2 = 0;
	if (MinLibido > MaxStat) sd.MinLibido = MaxStat;
	if (MinLibido < 0) sd.MinLibido = 0;
	if (MinNymphomania < 0) sd.MinNymphomania = 0;

	if (sd.FairyXF > 0) {
		var maxfairy:Number = 100;
		if (MaxStat == 200) maxfairy = 300;
		else if (MaxStat == 150) maxfairy = 200;
		else if (MaxStat == 100) maxfairy = 150;
		
		AssistantMaxCharisma = MaxStat + (sd.FairyXF > 100 ? 100 : sd.FairyXF);
		if (AssistantMaxCharisma > maxfairy) AssistantMaxCharisma = maxfairy;
		if (AssistantMaxCharisma > 300) sd.MaxCharisma = 300;
		AssistantMaxNymphomania = MaxStat + (sd.FairyXF > 100 ? 50 : sd.FairyXF * 0.5);
		if (sd.NymphsTiaraWorn == 1) AssistantMaxNymphomania += 50;
		if (sd.MaxNymphomania > maxfairy) AssistantMaxNymphomania = maxfairy;
	} 
	else {
		AssistantMaxCharisma = MaxCharisma == -1 ? MaxStat : MaxCharisma;
		AssistantMaxNymphomania = MaxNymphomania == -1 ? MaxStat : MaxNymphomania;
	}

	
	AssistantMaxSensibility = MaxSensibility == -1 ? MaxStat : MaxSensibility;
	AssistantMaxRefinement = MaxRefinement == -1 ? MaxStat : MaxRefinement;
	AssistantMaxIntelligence = MaxIntelligence == -1 ? MaxStat : MaxIntelligence;
	AssistantMaxMorality = MaxMorality == -1 ? MaxStat : MaxMorality;
	AssistantMaxConstitution = MaxConstitution == -1 ? MaxStat : MaxConstitution;
	AssistantMaxCooking = MaxCooking == -1 ? MaxStat : MaxCooking;
	AssistantMaxCleaning = MaxCleaning == -1 ? MaxStat : MaxCleaning;
	AssistantMaxConversation = MaxConversation == -1 ? MaxStat : MaxConversation;
	AssistantMaxTemperament = MaxTemperament == -1 ? MaxStat : MaxTemperament;
	AssistantMaxObedience = MaxObedience == -1 ? MaxStat : MaxObedience;
	AssistantMaxLibido = MaxLibido == -1 ? MaxStat : MaxLibido;
	AssistantMaxJoy = MaxJoy == -1 ? MaxStat : MaxJoy;
	
	var maxlesbianf:Number = MaxFuck == -1 ? MaxStat : MaxFuck;
	var maxlesbianb:Number = MaxBlowJob == -1 ? MaxStat : MaxBlowJob;
	if (BitFlagC.CheckBitFlag(10)) {
		var maxlesbian:Number = MaxStat;
		if (IsFemale()) maxlesbian = currLesbianTrainer * 100;
		else maxlesbian = currGayTrainer * 100;
		if (IsFemale() && currLesbianTrainer >= 1) {
			maxlesbianf = maxlesbian;
			maxlesbianb = maxlesbian;
		} else if (IsMale() && currGayTrainer >= 1) {
			maxlesbianf = maxlesbian;
			maxlesbianb = maxlesbian;
		}
	}
	AssistantMaxFuck = maxlesbianf;
	AssistantMaxBlowJob = maxlesbianb;

	
	modulesList.LimitMaxMinStats();
}


function LimitAllStats(sd:Object)
{
	if (sd == undefined) sd = _root;

	if (sd.AddictionLevel < 0) sd.AddictionLevel = 0; 
	if (sd.Loyalty < 0) sd.Loyalty = 0;

	var lestr:Boolean = sd.BitFlag1.CheckBitFlag(10);
	var lMinLibido:Number = sd.MinLibido;
	var lMinNymphomania:Number = sd.MinNymphomania;
		 
	if (sd.DoreiEffecting == 0) {
		if (sd.NymphsTiaraWorn == 1) {
			lMinNymphomania = 50;
			if (lMinLibido < 50) lMinLibido = 50;
			lMinNymphomania = 50; 
		} 
	} else {
		lMinNymphomania = 80;
		if (lMinLibido < 80) lMinLibido = 80;
	}

	if (sd.IsPermanentDickgirl() || sd.IsDickgirl()) {
		if (lMinLibido < 40) lMinLibido = 40;
		if (lMinNymphomania < 40) lMinNymphomania = 40;
	}

	if (sd.Slutiness > 5) {
		if (lMinNymphomania < 50) lMinNymphomania = 50;
		if (lMinLibido < 30) lMinLibido = 30;
	}
	
	if (lMinLibido<0) lMinLibido = 0;
	if (lMinLibido > MaxStat) lMinLibido = MaxStat;
	if (lMinNymphomania<0) lMinNymphomania = 0;
	if (lMinNymphomania > MaxStat) lMinNymphomania = MaxStat;

	if (Math.ceil(sd.VarLibido + sd.VarLibidoMod) < lMinLibido) sd.VarLibido = lMinLibido - sd.VarLibidoMod;
	if (Math.ceil(sd.VarNymphomania + sd.VarNymphomaniaMod) < lMinNymphomania) sd.VarNymphomania = lMinNymphomania - sd.VarNymphomaniaMod;
	
	if (sd.slPonyTraining > ((40 + (sPonyTrainer * 20)))) sd.slPonyTraining = (40 + (sPonyTrainer * 20));
	if (sd.slSlutTraining > 100) sd.slSlutTraining = 100;
	if (sd.slSwimming > 4) sd.slSwimming = 4;
	if (sd.slDancing > 4) sd.slDancing = 4;
	if (sd.slSinging > 4) sd.slSinging = 4;
	if (sd.slCombat > 100) sd.slCombat = 100;
	if (sd.slCourtesan > 100) sd.slCourtesan = 100;
	
	sd.LimitMaxMinStats();
	
	sd.VarCharisma = SMData.LimitStat(sd.VarCharisma, 0, AssistantMaxCharisma);
	sd.VarSensibility = SMData.LimitStat(sd.VarSensibility, 0, AssistantMaxSensibility);
	sd.VarRefinement = SMData.LimitStat(sd.VarRefinement, 0, AssistantMaxRefinement);
	sd.VarIntelligence = SMData.LimitStat(sd.VarIntelligence, 0, AssistantMaxIntelligence);
	sd.VarMorality = SMData.LimitStat(sd.VarMorality, 0, AssistantMaxMorality);
	sd.VarConstitution = SMData.LimitStat(sd.VarConstitution, 0, AssistantMaxConstitution);
	sd.VarCooking = SMData.LimitStat(sd.VarCooking, 0, AssistantMaxCooking);
	sd.VarCleaning = SMData.LimitStat(sd.VarCleaning, 0, AssistantMaxCleaning);
	sd.VarConversation = SMData.LimitStat(sd.VarConversation, 0, AssistantMaxConversation);
	sd.VarFuck = SMData.LimitStat(sd.VarFuck, 0, AssistantMaxFuck);
	sd.VarBlowJob = SMData.LimitStat(sd.VarBlowJob, 0, AssistantMaxBlowJob);
	sd.VarLesbianFuck = SMData.LimitStat(sd.VarLesbianFuck, 0, AssistantMaxFuck);
	sd.VarCunnilingus = SMData.LimitStat(sd.VarCunnilingus, 0, AssistantMaxBlowJob);
	sd.VarTemperament = SMData.LimitStat(sd.VarTemperament, 0, AssistantMaxTemperament);
	sd.VarNymphomania = SMData.LimitStat(sd.VarNymphomania, 0, AssistantMaxNymphomania);
	sd.VarObedience = SMData.LimitStat(sd.VarObedience, 0, AssistantMaxObedience);
	sd.VarLibido = SMData.LimitStat(sd.VarLibido, 0, AssistantMaxLibido);
	sd.VarReputation = SMData.LimitStat(sd.VarReputation, 0, 100);
	sd.VarFatigue = SMData.LimitStat(sd.VarFatigue, 0, 100);
	sd.VarJoy = SMData.LimitStat(sd.VarJoy, 0, AssistantMaxJoy);
	sd.VarSpecial = SMData.LimitStat(sd.VarSpecial, 0, sd.MaxSpecial);
	sd.VarSpecial2 = SMData.LimitStat(sd.VarSpecial2, 0, sd.MaxSpecial2);
	sd.VarLovePoints = SMData.LimitStat(sd.VarLovePoints, 0, sd.MaxLove);
	sd.VarSexualEnergy = SMData.LimitStat(sd.VarSexualEnergy, 0, 100);

	if (sd.DickgirlRate > 67) sd.DickgirlRate = 67;
	
	VarMoralityRounded = Math.ceil(SMData.LimitStat(sd.VarMorality, sd.VarMoralityMod, AssistantMaxMorality));
	VarObedienceRounded = Math.ceil(SMData.LimitStat(sd.VarObedience, sd.VarObedienceMod, AssistantMaxObedience));

	if (sd.AngelsTearWorn == 1 && VarMoralityRounded<50) sd.VarMorality = 50 - sd.VarMoralityMod;
	if (VarMoralityRounded>50 && sd.Slutiness > 5) sd.VarMorality = 50 - sd.VarMoralityMod;
	if (sd.DemonicPendantWorn == 1 && VarMoralityRounded>25) sd.VarMorality = 25 - sd.VarMoralityMod;
	if (sd.Loyalty == 0 && VarObedienceRounded < 5) sd.VarObedience = 5 - sd.VarObedienceMod;
	
	VarFatigueRounded = Math.ceil(sd.VarFatigue);
	var cr:Number = Math.ceil(SMData.LimitStat(sd.VarConstitution, sd.VarConstitutionMod, AssistantMaxConstitution));
	if (sd.FatigueBonus > cr) sd.FatigueBonus = cr;
	if (sd.FatigueBonus < 0) sd.FatigueBonus = 0;

	var chartemp:Number = sd.VarCharisma;

	if (sd.DurationHairCare > 0) chartemp += sd.DurationHairCare;
	if (sd.DurationFacialCare > 0) chartemp += sd.DurationFacialCare;
	if (sd.DurationMakeupCare > 0) chartemp += sd.DurationMakeupCare;
	

	VarCharismaRounded = Math.ceil(SMData.LimitStat(chartemp, sd.VarCharismaMod, AssistantMaxCharisma));
	VarSensibilityRounded = Math.ceil(SMData.LimitStat(sd.VarSensibility, sd.VarSensibilityMod, AssistantMaxSensibility));
	VarRefinementRounded = Math.ceil(SMData.LimitStat(sd.VarRefinement, sd.VarRefinementMod, AssistantMaxRefinement));
	VarIntelligenceRounded = Math.ceil(SMData.LimitStat(sd.VarIntelligence, sd.VarIntelligenceMod, AssistantMaxIntelligence));
	VarMoralityRounded = Math.ceil(SMData.LimitStat(sd.VarMorality, sd.VarMoralityMod, AssistantMaxMorality));
	VarConstitutionRounded = cr; //Math.ceil(SMData.LimitStat(sd.VarConstitution, sd.VarConstitutionMod, AssistantMaxConstitution));
	VarCookingRounded = Math.ceil(SMData.LimitStat(sd.VarCooking, sd.VarCookingMod, AssistantMaxCooking));
	VarCleaningRounded = Math.ceil(SMData.LimitStat(sd.VarCleaning, sd.VarCleaningMod, AssistantMaxCleaning));
	VarConversationRounded = Math.ceil(SMData.LimitStat(sd.VarConversation, sd.VarConversationMod, AssistantMaxConversation));	
	VarFuckRounded = Math.ceil(SMData.LimitStat(lestr ? sd.VarLesbianFuck : sd.VarFuck, sd.VarFuckMod, AssistantMaxFuck));
	VarBlowJobRounded = Math.ceil(SMData.LimitStat(lestr ? sd.VarCunnilingus : sd.VarBlowJob, sd.VarBlowJobMod, AssistantMaxBlowJob));
	VarTemperamentRounded = Math.ceil(SMData.LimitStat(sd.VarTemperament, sd.VarTemperamentMod, AssistantMaxTemperament));
	VarNymphomaniaRounded = Math.ceil(SMData.LimitStat(sd.VarNymphomania, sd.VarNymphomaniaMod, AssistantMaxNymphomania));
	VarObedienceRounded = Math.ceil(SMData.LimitStat(sd.VarObedience, sd.VarObedienceMod, AssistantMaxObedience));
	VarReputationRounded = Math.ceil(SMData.LimitStat(sd.VarReputation, sd.VarReputationMod, 100));
	VarLibidoRounded = Math.ceil(SMData.LimitStat(sd.VarLibido, sd.VarLibidoMod, AssistantMaxLibido));
	VarJoyRounded = Math.ceil(SMData.LimitStat(sd.VarJoy, sd.VarJoyMod, AssistantMaxJoy));
	VarSpecialRounded = Math.ceil(SMData.LimitStat(sd.VarSpecial, sd.VarSpecialMod, 100));
	VarSpecial2Rounded = Math.ceil(SMData.LimitStat(sd.VarSpecial2, sd.VarSpecial2Mod, 100));
	VarSexualEnergyRounded = Math.ceil(SMData.LimitStat(sd.VarSexualEnergy, sd.VarSexualEnergyMod, 100));
	
	FatigueBonusRounded = Math.ceil(SMData.LimitStat(sd.FatigueBonus, 0, VarConstitutionRounded));
	
	Trust = sd.VarObedience + sd.VarLovePoints;
}

var vitalsBustSM:Number;
var vitalsBustStartSM:Number;
var vitalsWaistSM:Number;
var vitalsHipsSM:Number;
var vitalsWeightSM:Number;
var vitalsHeightSM:Number;
var ClitCockSizeSM:Number;
var ClitCockSizeStartSM:Number;

// OBSLETE
var SMCustomTrainingDescription:String;
var ShowSMCustomTrainingOK:Number;

// Main Disply
function ShowMainDisplay() { dspMain.Show(); }
function HideMainDisplay() { dspMain.Hide(); }
function ShowMainButtons() { dspMain.ShowMainButtons(); }
function HideMainButtons() { dspMain.HideMainButtons(); }

function HideStatChangeIcons() { dspMain.HideStatChangeIcons(); }
function UpdateSlaveMaker() { dspMain.UpdateSlaveMaker(); }

function ShowStatisticsTab(tab:Number) { dspMain.ShowStatisticsTab(tab); }
function PlanningTabSelect() { dspMain.ShowStatisticsTab(6); }
function ShowStatistics(showhide:Boolean)
{
	if (showhide == false) dspMain.ShowStatisticsTab(5);
	else dspMain.ShowStatisticsTab(1);
}

// Slave Statistics
var BiggerBoobs:Boolean;

// Vital Statistics

function SetGirlsVitals(sname:String, desc:String, bust:Number, waist:Number, hips:Number, age:Number, bloodtype:String, tall:Number, weight:Number, clitcock:Number, birthday:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	if (sname != undefined) {
		sd.SlaveName = sname;
		sd.SlaveName1 = sname;
		sd.SlaveName2 = sname;
	}
	if (bust != undefined) sd.vitalsBust = bust;
	if (waist != undefined) sd.vitalsWaist = waist;
	if (hips != undefined) sd.vitalsHips = hips;
	if (age != undefined) sd.vitalsAge = age;
	if (bloodtype != undefined) sd.vitalsBloodType = bloodtype;
	if (desc != undefined) sd.vitalsDescription = desc;
	if (weight != undefined) sd.vitalsWeight = weight;
	if (tall != undefined) sd.vitalsHeight = tall;
	if (clitcock != undefined) {
		sd.ClitCockSize = clitcock;
		sd.ClitCockSizeStart = clitcock;
	}
	if (birthday != undefined && birthday != 0 && birthday != -7200) sd.Birthday = birthday;
	else if ((sd.Birthday == 0 || sd.Birthday == -7200) && age != undefined) sd.Birthday = GameDate - (sd.vitalsAge * 400) - slrandom(300);  // 400 days per year, plus small random factor
}

var SMHealth:Number;
var CombatTime:Number;
var Hit:Boolean;
var FirstArousalHit:Boolean;


var OwnerTesting:Boolean;
var OwnerTestingUrgent:Boolean;

// Following should be completely unused!

function DoOwnerTest()
{
	if ((!Owner.IsPersonallyOwned() && !Owner.IsUnowned()) && OwnerTesting && DoneEvent == 0 && ((Elapsed % 7) == 0)) {
		Diary.AddEntry(Language.GetText("OwnerTesting", "Diary"), false, 0, true);
		DoEvent(9999);
		AddTime(2);
		SetText("");
		if (SlaveGirl.OwnerTestSpecial() == true) return;
		if (XMLData.XMLEvent("OwnerTestSpecial", false)) return;
		
		temp = Math.floor(Math.random()*9)+1;
		genNumber = temp;
		if (temp == 1) {
			genString = "beauty";
			Score = VarCharismaRounded*2;
		} else if (temp == 2) {
			genString = "sensibility";
			Score = VarSensibilityRounded*2;
		} else if (temp == 3) {
			genString = "behaviour at court";
			Score = VarRefinementRounded*2;
		} else if (temp == 4) {
			genString = "intelligence";
			Score = VarIntelligenceRounded*2;
		} else if (temp == 5) {
			genString = "morality";
			Score = VarMoralityRounded*2;
		} else if (temp == 6) {
			genString = "endurance";
			Score = VarConstitution*2;
		} else if (temp == 7) {
			genString = "talents as a maid";
			Score = VarCookingRounded+VarCleaningRounded;
		} else if (temp == 8) {
			genString = "conversation";
			Score = VarConversationRounded*2;
		} else {
			genString = "skills at sex";
			temp = Math.floor(Math.random()*5)+1;
			genNumber += temp;
			if (temp == 1) {
				Score = VarFuckRounded*2;
			} else if (temp == 2) {
				Score = VarBlowJobRounded*2;
			} else if (temp == 3) {

				if (TestObedience(20)) {
					Score = VarFuckRounded*2;
				} else {
					Score = VarFuckRounded;
				}
			} else if (temp == 4) {
				if (TestObedience(30)) {
					Score = VarFuckRounded*2;
				} else {
					Score = VarFuckRounded;
				}
			} else if (temp == 5) {
				if (TestObedience(50)) {
					Score = VarFuckRounded*2;
				} else {
					Score = VarFuckRounded;
				}
			} else if (temp == 6) {
				if (TestObedience(60)) {
					Score = VarFuckRounded*2;
				} else {
					Score = VarFuckRounded;
				}
			}  
		}
		
		ShowDress();
		Score = Math.ceil(Score) + 2 - Difficulty;
		if (slaveData.Owner.GetOwner() == 3000) PersonGender = SMData.Gender;
		else PersonGender = slaveData.Owner.PersonGender;
		PersonName = GetPersonsName(Owner.GetOwner());
		GetPersonGenderText(PersonGender);
		if (SlaveGirl.OwnerTest(genString, Score) != true) XMLData.XMLEvent("OwnerTest", false);
		else Money(Score);
	}
}

function OfferToBuy(place:Number)
{
		NumEvent = 2;
		if (!modulesList.EventBuyer()) {
			var gnd:Number;
			if (IsDickgirlEvent()) gnd = 3;
			else gnd = slrandom(2);
			if (SMData.sLesbianTrainer >= 1) {
				if (Math.floor(Math.random()*2) == 0) gnd = 2;
			}
			NumEvent = 2 + (gnd / 10);
			if (FontText != "") ServantSpeakEnd();
			PlaySound("Sounds/Knocking.mp3");
			Pay = Math.ceil(VarCharisma) * 10;
			AddText("There is a knock at the door and the visitor is ");
			if (gnd == 3) AddText("a hermaphrodite");
			else if (gnd == 2) AddText("a woman");
			else if (gnd == 1) AddText("a man");
			AddText(" who has seen #slave and wants to buy #slavehimher, and offers you #pay GP.");
			if (Owner.GetOwner() != 0 && Owner.GetOwner() != 3000) AddText("\r\rIf you accept, you could have some problems with #slavehisher current owner.");
			PersonSpeakEnd();
			AddText("\r\rDo you choose to sell #slavehimher?");
			switch(gnd) {
				case 1: temp = slrandom(5); break;
				case 2: temp = slrandom(7); break;
				case 3: temp = DickgirlTesticles ? slrandom(4) + 2 : slrandom(4); break;
			}
			People.ShowPerson(1000 + gnd, 1, 1, temp);
		}
		DoYesNoEvent(NumEvent);
}  

function SellSlave(evno:Number)
{
	SMMoney(VarCharismaRounded * 10);
	HideImages();
	HideBackgrounds();
	genNumber = TrainingTime - Elapsed;
	if (genNumber < 8) genNumber = 8;
	
	SetText("The new owner says that they will require #slave to be delivered in #general days, and asks that you please finalise #slavehisher training before then.");
	if (Owner.GetOwner() != 0 && Owner.GetOwner() != 3000) {
		BitFlagSM.SetBitFlag(21);
		AddText("\r\rYou have illegally sold #slave, hopefully the original owner will not be able to do anything.")
	} else AddText("\r\rYou have sold #slave, and now have an owner for #slavehimher.");
	
	Owner.ChangeOwner(1001 + Math.round(10 * (evno - 2 + 0.05)));
	PersonName = Owner.GetOwnerName();
	Diary.AddEntry(Language.GetText("SoldSlave", "Diary"), false, 0, true);
	OwnerTesting = true;
}

var nWideMode:Number;		// Widescreen Display mode
	
function GetWidescreenMode() : Number 
{ 
	if (nWideMode == -1) nWideMode = XMLData.GetXMLValue("WideScreen", slaveData.GetSlaveXML(), 0);
	return nWideMode;
}
