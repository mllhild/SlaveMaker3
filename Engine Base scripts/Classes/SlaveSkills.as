// SlaveSkills - class defining the skills for a slave or assistant
// Translation status: COMPLETE

import Scripts.Classes.*;

class SlaveSkills extends SlaveItems {
	
	// Slave Type
	// 
	// -201 = special minor slave (unowned yet and can be purchased)
	// -200 = special minor slave (unowned yet amd not purchaseable)
	// -100 = untrained slave
	// -20 = special participant for the current slave
	// -10 = slave in training
	// -6 = gone away (moved to aother country etc)
	// -5 = dead
	// -4 = escaped
	// -3 = sold slave
	// -2 = special participant, but not for the current slave (to preserve stats etc)
	// -1 = slave maker assistant
	//  0 = minor slave
	//  1 = trained slave
	//	 2 = 'owned' slavemaker assistant
	public var SlaveType:Number;
	
	// Skills
	public var slDancing:Number;
	public var slSwimming:Number;
	public var slSinging:Number;
	public var slPonyTraining:Number;
	public var slCatTraining:Number;
	public var slPuppyTraining:Number;
	public var slSlutTraining:Number;
	public var slCourtesan:Number;
	public var slSeduction:Number;
	public var slSuccubusTraining:Number;
	
	// 	-1 = will not become one
	//  1000 = is a cumslut
	public var CumslutLevel:Number;

	// Customisable Skills
	// Combat
	public var slCombat:Number;
	public var strCombatDescription:String;
	public var strCombatHint:String;
	
	public var DonePonygirl:Number;
	public var DoneCourtesan:Boolean;
	
	public var FairyXF:Number;			// progress of fairy transformation

	// Sex Act Skill Levels (Default values -1)
	// TODO: Possibly these should move to SlaveActions?
	public var LevelMasturbate:Number;
	public var LevelLesbian:Number;
	public var LevelTouch:Number;
	public var LevelLick:Number;
	public var LevelThreesome:Number;
	public var Level69:Number;
	public var LevelStripTease:Number;
	public var LevelMasturbateDG:Number;
	public var LevelLesbianDG:Number;
	public var LevelTouchDG:Number;
	public var LevelLickDG:Number;
	public var LevelThreesomeDG:Number;
	public var Level69DG:Number;
	public var LevelStripTeaseDG:Number;
	public var LevelFuck:Number;
	public var LevelFuckLesbian:Number;
	public var LevelAnal:Number;
	public var LevelGangBang:Number;
	public var LevelDildo:Number;
	public var LevelGroup:Number;
	public var LevelLendHer:Number;
	public var LevelTitsFuck:Number;
	public var LevelTitsFuckLesbian:Number;
	public var LevelNaked:Number;
	public var LevelPlug:Number;
	public var LevelBlowjob:Number;
	public var LevelBlowjobLesbian:Number;
	public var LevelSpank:Number;
	public var LevelCumBath:Number;
	public var LevelKiss:Number;
	public var LevelBondage:Number;
	public var LevelPony:Number;
	public var LevelSex1:Number;
	public var LevelSex2:Number;
	public var LevelSex3:Number;
	public var LevelSex4:Number;
	public var LevelHandjob:Number;
	public var LevelFootjob:Number;
	
	// unsaved/temp
	public var arSkillArray:Array;
	
	// Methods
	
	// Constructor
	public function SlaveSkills(cg:Object) { 
		super(cg);
		Reset();
		
		SetFaerieXF = SetFairyXF;
		ChangeFaerieXF = ChangeFairyXF;
		IsFaerie = IsFairy;
		IsFaerieComplete = IsFairyComplete;
	}
	
	// Initialise all variables for the slave
	public function Reset() {
		
		super.Reset();
		
		slDancing = 0;
		slSwimming = 0;
		slSinging = 0;
		
		slPonyTraining = 0;
		slCatTraining = 0;
		slPuppyTraining = 0;
		slSlutTraining = 0;
		
		slCombat = 0;
		strCombatDescription = "";
		strCombatHint = "";

		slCourtesan = 0;
		slSeduction = 0;
		slSuccubusTraining = 0;;
		CumslutLevel = 0;
		
		DonePonygirl = 0;
		DoneCourtesan = false;
		
		LevelMasturbate = -1;
		LevelLesbian = -1;
		LevelTouch = -1;
		LevelLick = -1;
		LevelThreesome = -1;
		Level69 = -1;
		LevelStripTease = -1;
		LevelMasturbateDG = -1;
		LevelLesbianDG = -1;
		LevelTouchDG = -1;
		LevelLickDG = -1;
		LevelThreesomeDG = -1;
		Level69DG = -1;
		LevelStripTeaseDG = -1;
		LevelFuck = -1;
		LevelFuckLesbian = -1;
		LevelAnal = -1;
		LevelGangBang = -1;
		LevelDildo = -1;
		LevelGroup = -1;
		LevelLendHer = -1;
		LevelTitsFuck = -1;
		LevelTitsFuckLesbian = -1;
		LevelNaked = -1;
		LevelPlug = -1;
		LevelBlowjob = -1;
		LevelBlowjobLesbian = -1;
		LevelSpank = -1;
		LevelCumBath = -1;
		LevelKiss = -1;
		LevelBondage = -1;
		LevelPony = -1;
		LevelHandjob = -1;
		LevelFootjob = -1;
		LevelSex1 = -1;
		LevelSex2 = -1;
		LevelSex3 = -1;
		LevelSex4 = -1;
		
		FairyXF = -1;
	}
	
	public function IsDisplayed() : Boolean
	{
		return (SlaveType == -10 && !coreGame.OtherSlaveShown) || (coreGame.StatisticsGroup.sdata == this && coreGame.OtherSlaveShown);
	}
	
	public function IsSlaveFreePerson() : Boolean { return SlaveType == -1 || SlaveType == 2 || SlaveType == -20 || SlaveType == -2; }

	
	// Load/Save
	
	// Copy data from/to this object
	// sdFrom and sdTo can be Object types (for load/save cases(
	public function CopyCommonDetails(sdFrom:Object, sdTo:Object)
	{
		super.CopyCommonDetails(sdFrom, sdTo);
		
		sdTo.slDancing = sdFrom.slDancing;
		sdTo.slSinging = sdFrom.slSinging;
		sdTo.slSwimming = sdFrom.slSwimming;
		sdTo.slPonyTraining = sdFrom.slPonyTraining;
		sdTo.slCatTraining = sdFrom.slCatTraining;
		trace("from = " + sdFrom.slPuppyTraining);
		sdTo.slPuppyTraining = sdFrom.slPuppyTraining;
		sdTo.slCombat = sdFrom.slCombat;
		sdTo.strCombatDescription = sdFrom.strCombatDescription + "";
		sdTo.strCombatHint = sdFrom.strCombatHint + "";

		sdTo.slCourtesan = sdFrom.slCourtesan;
		sdTo.slSeduction = sdFrom.slSeduction;
		
		sdTo.CumslutLevel = sdFrom.CumslutLevel;
		sdTo.slSuccubusTraining = sdFrom.slSuccubusTraining;
		
		sdTo.DonePonygirl = sdFrom.DonePonygirl;
		sdTo.DoneCourtesan = sdFrom.DoneCourtesan;

		sdTo.LevelMasturbateDG = sdFrom.LevelMasturbateDG;
		sdTo.LevelLesbianDG = sdFrom.LevelLesbianDG;
		sdTo.LevelTouchDG = sdFrom.LevelTouchDG;
		sdTo.LevelLickDG = sdFrom.LevelLickDG;
		sdTo.LevelThreesomeDG = sdFrom.LevelThreesomeDG;
		sdTo.Level69DG = sdFrom.Level69DG;
		sdTo.LevelStripTeaseDG = sdFrom.LevelStripTeaseDG;

		sdTo.LevelBlowjob = sdFrom.LevelBlowjob;
		sdTo.LevelBlowjobLesbian = sdFrom.LevelBlowjobLesbian;
		sdTo.LevelFuck = sdFrom.LevelFuck;
		sdTo.LevelFuckLesbian = sdFrom.LevelFuckLesbian;
		sdTo.LevelAnal = sdFrom.LevelAnal;
		sdTo.LevelMasturbate = sdFrom.LevelMasturbate;
		sdTo.LevelLesbian = sdFrom.LevelLesbian;
		sdTo.LevelNaked = sdFrom.LevelNaked;
		sdTo.LevelGangBang = sdFrom.LevelGangBang;
		sdTo.LevelTouch = sdFrom.LevelTouch;
		sdTo.LevelLick = sdFrom.LevelLick;
		sdTo.LevelTitsFuck = sdFrom.LevelTitsFuck;
		sdTo.LevelTitsFuckLesbian = sdFrom.LevelTitsFuckLesbian;
		sdTo.LevelDildo = sdFrom.LevelDildo;
		sdTo.LevelPlug = sdFrom.LevelPlug;
		sdTo.LevelLendHer = sdFrom.LevelLendHer;
		sdTo.LevelBondage = sdFrom.LevelBondage;
		sdTo.LevelSpank = sdFrom.LevelSpank;
		sdTo.LevelThreesome = sdFrom.LevelThreesome;
		sdTo.Level69 = sdFrom.Level69;
		sdTo.LevelGroup = sdFrom.LevelGroup;
		sdTo.LevelCumBath = sdFrom.LevelCumBath;
		sdTo.LevelKiss = sdFrom.LevelKiss;
		sdTo.LevelStripTease = sdFrom.LevelStripTease;
		sdTo.LevelPony = sdFrom.LevelPony;
		sdTo.LevelSex1 = sdFrom.LevelSex1;
		sdTo.LevelSex2 = sdFrom.LevelSex2;
		sdTo.LevelSex3 = sdFrom.LevelSex3;
		sdTo.LevelSex4 = sdFrom.LevelSex4;
		sdTo.LevelFootjob = sdFrom.LevelFootjob;
		sdTo.LevelHandjob = sdFrom.LevelHandjob;
		
		sdTo.FairyXF = sdFrom.FairyXF;

	}
	
	// Change functions
	private function SetSkillPlusIcon(idx:Number)
	{
		arSkillArray[idx].PlusIcon._visible = true;
		coreGame.UpdateBasicSlaveSkills();
	}
	public function ChangeCatTraining(val:Number) {
		if (val == undefined || slCatTraining == 0) return;

		var limit:Number = 20 + coreGame.sCatTrainer * 40;
		var tb:Object = coreGame.modulesList.GetTraining("Catgirl");
		if (!coreGame.Singer.CheckBitFlag(34) && !tb.CheckBitFlag(1)) {
			if (coreGame.Singer.CheckBitFlag(33) || tb.CheckBitFlag(0)) limit = 50;
			else limit = limit > 30 ? 30 : limit;
		}
		slCatTraining = LimitStat(slCatTraining, val, limit);
		if (IsDisplayed()) SetSkillPlusIcon(GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("CatslaveTraining", "Skills")));
	}
	public function ChangePuppyTraining(val:Number) {
		trace("ChangePuppyTraining1: " + slPuppyTraining);
		if (val == undefined || slPuppyTraining == 0) return;
		var limit:Number = 20 + coreGame.sPuppyTrainer * 40;
		slPuppyTraining = LimitStat(slPuppyTraining, val, limit);
		trace("ChangePuppyTraining2: " + slPuppyTraining);
		if (IsDisplayed()) SetSkillPlusIcon(GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("PuppyslaveTraining", "Skills")));
	}	
	public function ChangeDancing(val:Number) {
		if (val == undefined) return;
		slDancing+= val;
		if (slDancing > 4) slDancing = 4;
		if (IsDisplayed()) SetSkillPlusIcon(0);
	}
	public function ChangeSinging(val:Number) {
		if (val == undefined) return;
		slSinging += val;
		if (slSinging > 4) slSinging = 4;
		if (IsDisplayed()) SetSkillPlusIcon(1);	
	}
	public function ChangeSwimming(val:Number) {
		if (val == undefined) return;
		slSwimming += val;
		if (slSwimming > 4) slSwimming = 4;
		if (IsDisplayed()) SetSkillPlusIcon(2);
	}
	public function ChangeSlutTraining(val:Number) {
		if (val == undefined) return;
		slSlutTraining = LimitStat(slSlutTraining,val);
		if (IsDisplayed()) SetSkillPlusIcon(GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("SlutTraining", coreGame.Language.skNode)));
	}
	public function ChangeCourtesan(val:Number) {
		if (val == undefined) return;
		slCourtesan = LimitStat(slCourtesan,val,90);
		if (IsDisplayed()) SetSkillPlusIcon(GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("CourtesanTraining", coreGame.Language.skNode)));
	}
	public function ChangeSeduction(val:Number) {
		if (val == undefined) return;
		slSeduction = LimitStat(slSeduction, val);
		if (IsDisplayed()) SetSkillPlusIcon(GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("Seduction", coreGame.Language.skNode)));		
	}
	
	// Animal Girl
	public function IsCatgirl() : Boolean { return BitFlagC.CheckBitFlag(15) || BitFlagC.CheckBitFlag(45); }
	public function IsCatgirlComplete() : Boolean { return BitFlagC.CheckBitFlag(15); }
	public function IsCatgirlTraining() : Boolean { return BitFlagC.CheckBitFlag(45); }	
	public function IsPuppygirl() : Boolean { return BitFlagC.CheckBitFlag(57) || BitFlagC.CheckBitFlag(58) || BitFlagC.CheckBitFlag(59); }
	public function IsPuppygirlComplete() : Boolean { return BitFlagC.CheckBitFlag(58) || BitFlagC.CheckBitFlag(59); }
	public function IsPuppygirlTraining() : Boolean { return BitFlagC.CheckBitFlag(57); }	

	
	// Combat
	public function ChangeCombat(val:Number) {
		if (val == undefined) return;

		if (coreGame.SMData.SMAdvantages.CheckBitFlag(3)) val *= 1.2;
		slCombat = LimitStat(slCombat,val);
		if (IsDisplayed()) SetSkillPlusIcon(GetSlaveSkillArrayIndex(strCombatDescription));
	}
	
	public function SetSlaveCombatSkill(desc:String, hint:String)
	{
		if (desc != undefined) strCombatDescription = desc;
		if (hint != undefined) strCombatHint = hint;
	}

	
	// Alter Succubus training if Succubus training is happening
	public function ChangeSuccubusTraining(val:Number) {
		if (slSuccubusTraining < 0 || slSuccubusTraining == 2000) return;
		if (slSuccubusTraining >= 0 && slSuccubusTraining < 100 && val != undefined) {
			slSuccubusTraining += val;
			if (slSuccubusTraining > 100) slSuccubusTraining = 100;
		}
	}
	public function IsSuccubus() : Boolean { return slSuccubusTraining > 0;	}
	public function IsSuccubusComplete() : Boolean { return slSuccubusTraining == 2000;	}
	public function IsSuccubusTraining() : Boolean { return slSuccubusTraining > 0 && slSuccubusTraining != 2000; }
	
	// cumslut
	public function ChangeCumslut(val:Number) {
		if (CumslutLevel > 0 && CumslutLevel < 100 && val != undefined) {
			CumslutLevel += val;
			if (CumslutLevel > 100) CumslutLevel = 100;
		}
	}
	public function IsCumslut() : Boolean {	return CumslutLevel == 2000; }
	
	// Ponygirl
	public function ChangePonyTraining(val:Number) {
		if (val != undefined) {
			slPonyTraining = LimitStat(slPonyTraining,val,40 + coreGame.sPonyTrainer * 20);
		}
	}

	public function IsPonygirl() : Boolean { return DonePonygirl == 1;	}
	
	// Fairy
	public function IsFairy() : Boolean { return FairyXF > 0; }
	public function IsFairyComplete() : Boolean { return FairyXF == 2000; }
	public function ChangeFairyXF(val:Number) {
		if (FaeriesRingWorn == 0 || val == undefined) return;
		if (FairyXF > 0 && FairyXF < 100) FairyXF += val;
		if (IsDisplayed()) {
			var fairyindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("FairyAffinity", "Skills"));		
			arSkillArray[fairyindex].PlusIcon._visible = true;
			coreGame.UpdateBasicSlaveSkills();
		}
	}
	public function SetFairyXF(val:Number) {
		FairyXF = val;
		if (IsDisplayed()) {
			var fairyindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("FairyAffinity", "Skills"));		
			arSkillArray[fairyindex].PlusIcon._visible = true;
			coreGame.UpdateBasicSlaveSkills();
		}
	}
	
	// Skill Array
	public function ClearSlaveSkillArray()
	{
		var i:Number = arSkillArray.length;
		if (i == 0) return;
		if (i == undefined) i = 0;
		while (--i >= 0) RemoveSlaveSkill(i);
		delete arSkillArray;
		arSkillArray = new Array();
	}
	public function HideSlaveSkillArray(bShow:Boolean)
	{
		if (bShow == undefined) bShow = false;
		var i:Number = arSkillArray.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			var mc:MovieClip = arSkillArray[i];
			mc._visible = bShow;
		}
	}
	public function GetSlaveSkillArrayIndex(sname:String) : Number
	{
		sname = sname.split(":").join("").split(" ").join("");
		var i:Number = arSkillArray.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			if (sname == arSkillArray[i].sname.split(":").join("").split(" ").join("")) return i;
		}
		return -1;
	}
	public function GetSlaveSkillArrayEntry(sname:String) : MovieClip
	{
		sname = sname.split(":").join("").split(" ").join("");
		var i:Number = arSkillArray.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			if (sname == arSkillArray[i].sname.split(":").join("").split(" ").join("")) return arSkillArray[i];
		}
		return null;
	}	
	
	public function RemoveSlaveSkill(idx:Number)
	{
		var mc:MovieClip = arSkillArray[idx];
		coreGame.RemoveAttachedMovie(mc);
		arSkillArray.splice(idx, 1);
	}
	
	public function GetSkillLang(skill:Number) : String
	{
		switch(skill) {
			case 0: return "Dancing";
			case 1: return "Singing";
			case 2: return "Swimming";
		}
		var combatindex:Number = GetSlaveSkillArrayIndex(strCombatDescription);
		var courtesanindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("CourtesanTraining", "Skills"));
		var ponyindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("PonyTraining", "Skills"));
		var catindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("CatslaveTraining", "Skills"));
		var slutindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("SlutTraining", "Skills"));
		var fairyindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("FairyAffinity", "Skills"));		
		var seductionindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("Seduction", "Skills"));				
		var csindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("Cumslut", "Skills"));
		var succubusindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("SuccubusTraining", "Skills"));
		var puppyindex:Number = GetSlaveSkillArrayIndex(coreGame.Language.GetHtml("PuppyslaveTraining", "Skills"));
	
		switch(skill) {
			case catindex: return "CatslaveTraining";
			case seductionindex: return "Seduction";
			case courtesanindex: return "Courtesan";
			case ponyindex: return "PonyTraining";
			case slutindex: return "SlutTraining";
			case fairyindex: return "FairyAffinity";
			case combatindex: return "Combat";
			case csindex: return "Cumslut";
			case succubusindex: return "SuccubusTraining";
			case puppyindex: return "PuppyslaveTraining";
		}
		var i:Number = arSkillArray.length;
		if (i == undefined) return "";
		while (--i > 2) {
			if (arSkillArray[i].SkillNo == skill) {
				var sn:String = arSkillArray[i].SkillLabel.text;
				return sn.split(" ").join("");
			}
		}
		return "";
	}
	
	public function GetSkill(skill:String) : Number
	{
		//trace("GetSkill: " + skill);
		
		// Standard skills
		switch(skill.toLowerCase()) {
			case "dancing": return slDancing;
			case "singing": return slSinging;
			case "swimming": return slSwimming;
			case "catslavetraining": return slCatTraining;
			case "seduction": return slSeduction;
			case "courtesan": return slCourtesan;
			case "ponytraining": return slPonyTraining;
			case "sluttraining": return slSlutTraining;
			case "fairyaffinity": return FairyXF;
			case "combat": return slCombat;
			case "cumslut": return CumslutLevel;
			case "succubustraining": return slSuccubusTraining;
			case "puppytraining":
			case "puppyslavetraining": return slPuppyTraining;
		}
	
		// Other skills
		var i:Number = arSkillArray.length;
		if (i == undefined) return undefined;
		var sn:String;
		while (--i >= 0) {
			//trace("..check " + GetSkillLang(i).toLowerCase());
			if (GetSkillLang(i).toLowerCase() == skill) {
				var mc:MovieClip = arSkillArray[i];
				//trace("..found " + skill + " value " + mc.skillrank);
				return mc.skillrank;
			}
		}
		return undefined;
	}

	// references
	public var SetFaerieXF:Function;
	public var ChangeFaerieXF:Function;
	public var IsFaerie:Function;
	public var IsFaerieComplete:Function;
}