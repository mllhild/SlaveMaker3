// SMSlaveCommon - class defining the skills for a slave maker or assistant
// not currently used for slaves any other types of slaves

// NOTE: extends DressCommon, but that is due to limitations of the inheritance system,
//		 not due to any relationship to this class

// Common to Slave and SlaveMaker
import Scripts.Classes.*;

class SMSlaveCommon extends DressCommon
{
	// Naming
	public var Titles:String;
	
	// Skills
	public var sSlaveTrainer:Number;
	public var sLesbianTrainer:Number;
	public var sGayTrainer:Number;
	public var sTrader:Number;
	public var sAlchemy:Number;
	public var sPonyTrainer:Number;
	public var sCatTrainer:Number;
	public var sPuppyTrainer:Number;
	public var sLeadership:Number;
	
	public var sSwordExpertise:Number;
	public var sWhipExpertise:Number;
	public var sBowExpertise:Number;
	public var sHammerExpertise:Number;
	public var sNaginataExpertise:Number;
	public var sDaggerExpertise:Number;
	public var sCrossbowExpertise:Number;
	public var sUnarmedExpertise:Number;
	public var sThrownExpertise:Number;
	
	public var sSuccubusTrainer:Number;
	public var sSlutTrainer:Number;
	public var sOrgasmDenialTraining:Number;
	public var sRefined:Number;
	public var sNoble:Number;
	public var sTentacleExpert:Number;
	public var sBreastExpert:Number;

	// Experience
	public var arExperience:Array;

	// Pregnancy
	public var DateImpregnated:Number;
	public var PregnancyGestation:Number;
	public var PregnancyType:String;
	public var PregnancyCount:Number;
	public var Fertility:Number;
	public var DaysUnavailable:Number;
	public var TotalChildren:Number;
	
	public var TotalTentaclePregnancy:Number;
	public var TotalTentacle:Number;

	// Personality
	// With 50+ displaying as Extroversion, Sensing, Thinking and Judgement.
	public var SlaveAttitude:Number;	
		// note largely unused
	public var Attitude:Number;
		//values: "Extroverted" and "Introverted"
	public var Perception:Number;
		//values: "Sensing" and "Intuition"
	public var Judgement:Number;
		//values: "Thinking" and "Feeling"
	public var Lifestyle:Number;
		//values "Perception" and "Judgement"
		
	// Drugs
	public var BiyakuEffecting:Number;
	public var IshinaiEffecting:Number;
	public var DoreiEffecting:Number;
	public var ZodaiEffecting:Number;
	public var GamanEffecting:Number;
	public var OrgasmDrugEffecting:Number;
	public var DrugDuration:Number;
	public var DrugAddicted:Number;
	public var NumAddictionLevel:Number;
	public var AddictionLevel:Number;
	public var DateLastAphrodisiac:Number;
	public var DaysUsedAphrodisiac:Number;
	public var UsedAphrodisiac:Number;
	public var NumAphrodisiac:Number;
	
	public var PotionsUsed:Array;
	
	// Physical appearance
	public var HasTail:Boolean;// does the slave have a tail (excludes demon tail)
	public var HasTesticles:Boolean;// if they have a cock, do they have testicles?

		
	// reference
	private var BitFlagC:BitFlags;
		
	
	// Methods
	
	// Constructor
	public function SMSlaveCommon(cg:Object) { 
		super(cg);
		
		Reset();
	}
	
	// Initialise all variables
	public function Reset() {
		
		super.Reset();
		
		Titles = "";
		
		sSlaveTrainer = 0;
		sLesbianTrainer = 0;
		sGayTrainer = 0;
		sTrader = 0;
		sAlchemy = 0;
		sPonyTrainer = 0;
		sCatTrainer = 0;
		sPuppyTrainer = 0;
		sSwordExpertise = 0;
		sWhipExpertise = 0;
		sBowExpertise = 0;
		sLeadership = 0;
		sHammerExpertise = 0;
		sNaginataExpertise = 0;
		sDaggerExpertise = 0;
		sCrossbowExpertise = 0;
		sUnarmedExpertise = 0;
		sThrownExpertise = 0;
		sSuccubusTrainer = 0;
		sSlutTrainer = 0;
		sOrgasmDenialTraining = 0;
		sRefined = 0;
		sNoble = 0;
		sTentacleExpert = 0;
		sBreastExpert = 0;
		arExperience = null;
		
		SlaveAttitude = 0;
		Attitude = -1;
		Perception = -1;
		Judgement = -1;
		Lifestyle = -1;
		
		DaysUnavailable = 0;
		DateImpregnated = 0;
		PregnancyGestation = 0;
		PregnancyType = "";
		PregnancyCount = 0;
		TotalTentaclePregnancy = 0;
		TotalChildren = 0;
		TotalTentacle = 0;
		
		Fertility = coreGame.config.nDefaultFertility;
		
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
		DaysUsedAphrodisiac = 0;
		UsedAphrodisiac = 0;
		
		delete PotionsUsed;
		PotionsUsed = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);		
		
		HasTail = false;
		HasTesticles = false;
	}
	
	
	// Copy data from/to this object
	// sdFrom and sdTo can be Object types (for load/save cases(
	public function CopyCommonDetails(sdFrom:Object, sdTo:Object)
	{
		sdTo.Titles = sdFrom.Titles;
		
		sdTo.BiyakuEffecting = sdFrom.BiyakuEffecting;
		sdTo.IshinaiEffecting = sdFrom.IshinaiEffecting;
		sdTo.DoreiEffecting = sdFrom.DoreiEffecting;
		sdTo.ZodaiEffecting = sdFrom.ZodaiEffecting;
		sdTo.GamanEffecting = sdFrom.GamanEffecting;
		sdTo.OrgasmDrugEffecting = sdFrom.OrgasmDrugEffecting;
		sdTo.DrugDuration = sdFrom.DrugDuration;
		sdTo.DrugAddicted = sdFrom.DrugAddicted;
		sdTo.NumAddictionLevel = sdFrom.NumAddictionLevel;
		sdTo.AddictionLevel = sdFrom.AddictionLevel;
		sdTo.DateLastAphrodisiac = sdFrom.DateLastAphrodisiac;
		sdTo.DaysUsedAphrodisiac = sdFrom.DaysUsedAphrodisiac;
		sdTo.UsedAphrodisiac = sdFrom.UsedAphrodisiac;
		
		sdTo.DaysUnavailable = sdFrom.DaysUnavailable;
		sdTo.DateImpregnated = sdFrom.DateImpregnated;
		sdTo.PregnancyGestation = sdFrom.PregnancyGestation;
		sdTo.PregnancyType = sdFrom.PregnancyType;
		sdTo.PregnancyCount = sdFrom.PregnancyCount;
		sdTo.TotalTentaclePregnancy = sdFrom.TotalTentaclePregnancy;
		sdTo.TotalChildren = sdFrom.TotalChildren;
		sdTo.TotalTentacle = sdFrom.TotalTentacle;
		sdTo.Fertility = sdFrom.Fertility;
		
		sdTo.Attitude = sdFrom.Attitude;
		sdTo.Perception = sdFrom.Perception;
		sdTo.Judgement = sdFrom.Judgement;
		sdTo.Lifestyle = sdFrom.Lifestyle;
		
		sdTo.HasTail = sdFrom.HasTail;
		sdTo.HasTesticles = sdFrom.HasTesticles;
	}

	// Load/Save
	
	public function Load(so:Object)
	{
		super.Load(so);
		
		sSlaveTrainer = so.sSlaveTrainer;
		sLesbianTrainer = so.sLesbianTrainer;
		sGayTrainer = so.sGayTrainer;
		if (sGayTrainer == undefined) sGayTrainer = 0;
		sTrader = so.sTrader;
		sAlchemy = so.sAlchemy;
		sPonyTrainer = so.sPonyTrainer;
		sCatTrainer = so.sCatTrainer;
		sPuppyTrainer = so.sPuppyTrainer;
		if (sPuppyTrainer == undefined) sPuppyTrainer = 0;
		sLeadership = so.sLeadership;
		
		sSwordExpertise = so.sSwordExpertise;
		sWhipExpertise = so.sWhipExpertise;
		sBowExpertise = so.sBowExpertise;
		sHammerExpertise = so.sHammerExpertise;
		sNaginataExpertise = so.sNaginataExpertise;
		sDaggerExpertise = so.sDaggerExpertise;
		sCrossbowExpertise = so.sCrossbowExpertise;
		sUnarmedExpertise = so.sUnarmedExpertise;
		sThrownExpertise = so.sThrownExpertise;
		if (sThrownExpertise == undefined) sThrownExpertise = 0;
		
		sSuccubusTrainer = so.sSuccubusTrainer;
		sSlutTrainer = so.sSlutTrainer;
		sOrgasmDenialTraining = so.sOrgasmDenialTraining;
		sRefined = so.sRefined;
		sNoble = so.sNoble;
		sTentacleExpert = so.sTentacleExpert;
		sBreastExpert = so.sBreastExpert;
		
		if (so.arExperience != undefined) {
			delete arExperience;
			arExperience = new Array();
			var len:Number = so.arExperience.length;
			if (len != 0 && len != undefined) {
				for (var i:Number = 0; i < len; i++) arExperience[i] = so.arExperience[i];
			}
		}
		
		PregnancyGestation = so.PregnancyGestation;
		DateImpregnated = so.DateImpregnated;
		PregnancyType = so.PregnancyType + "";
		PregnancyCount = so.PregnancyCount;
		Fertility = so.Fertility;
		TotalTentaclePregnancy = so.TotalTentaclePregnancy;
		TotalChildren = so.TotalChildren;
		DaysUnavailable = so.DaysUnavailable;

		TotalTentacle = so.TotalTentacle;
		
		Attitude = so.Attitude;
		Perception = so.Perception;
		Judgement = so.Judgement;
		Lifestyle = so.Lifestyle;
		
		so.HasTail = HasTail;		

	}
	
	public function Save(so:Object)
	{
		super.Save(so);
		
		so.sSlaveTrainer = sSlaveTrainer;
		so.sLesbianTrainer = sLesbianTrainer;
		so.sGayTrainer = sGayTrainer;
		so.sTrader = sTrader;
		so.sAlchemy = sAlchemy;
		so.sPonyTrainer = sPonyTrainer;
		so.sCatTrainer = sCatTrainer;
		so.sPuppyTrainer = sPuppyTrainer;
		so.sLeadership = sLeadership;
		
		so.sSwordExpertise = sSwordExpertise;
		so.sWhipExpertise = sWhipExpertise;
		so.sBowExpertise = sBowExpertise;
		so.sHammerExpertise = sHammerExpertise;
		so.sNaginataExpertise = sNaginataExpertise;
		so.sDaggerExpertise = sDaggerExpertise;
		so.sCrossbowExpertise = sCrossbowExpertise;
		so.sUnarmedExpertise = sUnarmedExpertise;
		so.sThrownExpertise = sThrownExpertise;
		
		so.sSuccubusTrainer = sSuccubusTrainer;
		so.sSlutTrainer = sSlutTrainer;
		so.sOrgasmDenialTraining = sOrgasmDenialTraining;
		so.sRefined = sRefined;
		so.sNoble = sNoble;
		so.sTentacleExpert = sTentacleExpert;
		so.sBreastExpert = sBreastExpert;
				
		if (arExperience != null) {
			delete so.arExperience;
			so.arExperience = new Array();
			var len:Number = arExperience.length;
			for (var i:Number = 0; i < len; i++) so.arExperience[i] = arExperience[i];
		}
		
		so.PregnancyGestation = PregnancyGestation;
		so.DateImpregnated = DateImpregnated;
		so.PregnancyType = PregnancyType + "";
		so.PregnancyCount = PregnancyCount;
		so.Fertility = Fertility;
		so.TotalTentaclePregnancy = TotalTentaclePregnancy;
		so.TotalChildren = TotalChildren;
		so.DaysUnavailable = DaysUnavailable;

		so.TotalTentacle = TotalTentacle;
		
		so.Attitude = Attitude;
		so.Perception = Perception;
		so.Judgement = Judgement;
		so.Lifestyle = Lifestyle;
		
		so.HasTail = HasTail;
	}
	
	
	// Gender
	public function IsFemale() : Boolean { return false; }
	public function IsWoman() : Boolean { return false; }
	public function IsMale() : Boolean { return false; }	
	public function IsTwins() : Boolean { return false; }	
	
	// Dickgirl
	public function IsDickgirl() : Boolean { return false; }
	public function IsPermanentDickgirl() : Boolean { return false; }
	
	// Naming
	
	public function GetFullName() : String { return ""; }
	
	public function SetTitle(str:String)
	{
		if (Titles == "") Titles = str;
		else if (Titles.indexOf(str) == -1) Titles = Titles + " " + str;
	}
	
	
	// Experience

	public function AddExperience(type, amt:Number) : Number
	{
		if (type == undefined) return 0;
		if (amt == undefined) amt = 10;
		
		if (arExperience == null) arExperience = new Array();
		var len:Number = arExperience.length;
		
		var typen:Number = DecodeSMSkill(type);
		
		if (len < (typen + 1)) {
			for (var i:Number = len; i < amt; i++) arExperience.push(0);
		}
		arExperience[typen] += amt;
		
		return arExperience[typen];
	}
	
	public static function DecodeSMSkill(skill) : Number
	{
		var skilln:Number;
		if (typeof(skill) != "string") return Math.abs(Number(skill));
		
		var skills:String = String(skill).toLowerCase();
		for (var i:Number = 1; i < 17; i++) {
			if (GetSMSkillLang(i).toLowerCase() == skills) return i;
		}
		if (skill == "slavetrainer") return 13;
		for (var i:Number = 50; i < 59; i++) {
			if (GetSMSkillLang(i).toLowerCase() == skills) return i;
		}
		return 0;
	}
	
	public function GetSMSkillLevel(skill) : Number
	{
		switch(DecodeSMSkill(skill)) {
			case 13: return sSlaveTrainer;
			case 1: return sLeadership;
			case 2: return sLesbianTrainer;
			case 3: return sTrader;
			case 4: return sAlchemy;
			case 5: return sPonyTrainer;
			case 6: return sCatTrainer;
			case 7: return sSuccubusTrainer;
			case 8: return sSlutTrainer;
			case 9: return sOrgasmDenialTraining;
			case 10: return sRefined;
			case 11: return sNoble;
			case 12: return sTentacleExpert;
			case 14: return sBreastExpert;
			case 15: return sGayTrainer;
			case 16: return sPuppyTrainer;
			
			case 50: return sSwordExpertise;
			case 51: return sWhipExpertise;
			case 52: return	sBowExpertise;
			case 53: return	sHammerExpertise;
			case 54: return sNaginataExpertise;
			case 55: return sDaggerExpertise;
			case 56: return sCrossbowExpertise;
			case 57: return sUnarmedExpertise;
			case 58: return sThrownExpertise;
		}
		return undefined;
	}
	
	public function SetSMSkillLevel(skill, skillvalue:Number)
	{
		if (skillvalue == undefined) return undefined;
		
		switch(DecodeSMSkill(skill)) {
			case 13: sSlaveTrainer = skillvalue; break;
			case 1: sLeadership = skillvalue; break;
			case 2: sLesbianTrainer = skillvalue; break;
			case 3: sTrader = skillvalue; break;
			case 4: sAlchemy = skillvalue; break;
			case 5: sPonyTrainer = skillvalue; break;
			case 6: sCatTrainer = skillvalue; break;
			case 7: sSuccubusTrainer = skillvalue; break;
			case 8: sSlutTrainer = skillvalue; break;
			case 9: sOrgasmDenialTraining = skillvalue; break;
			case 10: sRefined = skillvalue; break;
			case 11: sNoble = skillvalue; break;
			case 12: sTentacleExpert = skillvalue; break;
			case 14: sBreastExpert = skillvalue; break;
			case 15: sGayTrainer = skillvalue; break;
			case 16: sPuppyTrainer = skillvalue; break;
			
			case 50: sSwordExpertise = skillvalue; break;
			case 51: sWhipExpertise = skillvalue; break;
			case 52: sBowExpertise = skillvalue; break;
			case 53: sHammerExpertise = skillvalue; break;
			case 54: sNaginataExpertise = skillvalue; break;
			case 55: sDaggerExpertise = skillvalue; break;
			case 56: sCrossbowExpertise = skillvalue; break;
			case 57: sUnarmedExpertise = skillvalue; break;
			case 58: sThrownExpertise = skillvalue; break;
		}
		// limit skill
		if (GetSMSkillLevel(skill) > GetSMMaxSkill(skill)) SetSMSkillLevel(skill, GetSMMaxSkill(skill));
	}
	
	public static function GetSMMaxSkill(skill) : Number
	{
		switch(DecodeSMSkill(skill)) {
			case 13: return 4;
			case 1: return 4;
			case 2: return 3;
			case 3: return 3;
			case 4: return 3;
			case 5: return 3;
			case 6: return 2;
			case 7: return 2;
			case 8: return 2;
			case 9: return 2;
			case 10: return 4;
			case 11: return 3;
			case 12: return 3;
			case 14: return 2;
			case 15: return 3;
			case 16: return 2;
		}
		return 100;
	}
	
	public static function GetSMSkillLang(skill:Number) : String
	{
		switch(Math.abs(skill)) {
			case 13: return "SlaveTraining";
			case 1: return "Leadership";
			case 2: return "LesbianTrainer";
			case 3: return "ExpertTrader";
			case 4: return "Alchemy";
			case 5: return "PonygirlTrainer";
			case 6: return "CatslaveTrainer";
			case 7: return "SuccubusTrainer";
			case 8: return "SlutTrainer";
			case 9: return "OrgasmDenialTrainer";
			case 10: return "Refined";
			case 11: return "Nobility";
			case 12: return "TentacleExpert";
			case 14: return "BreastExpert";
			case 15: return "GayTrainer";
			case 16: return "PuppyslaveTrainer";
			
			case 50: return "SwordSkill";
			case 51: return "WhipSkill";
			case 52: return	"BowSkill";
			case 53: return	"HammerSkill";
			case 54: return "NaginataSkill";
			case 55: return "DaggerSkill";
			case 56: return	"CrossbowSkill";
			case 57: return	"UnarmedCombat";
			case 58: return	"ThrownSkill";
		}
		return "";
	}
	
	public function GetSMSkillName(skill:Number) : String
	{
		return coreGame.Language.GetHtml(GetSMSkillLang(skill), coreGame.skNode);
	}
	
	public function GetSMSkillDescription(skill:Number) : String
	{
		return "<b>" + GetSMSkillName(skill) + "</b>\r" + coreGame.Language.GetHtml(GetSMSkillLang(skill) + "Description", coreGame.skNode);
	}
	
	public function GetSMSkillLevelEffects(skill:Number, level:Number) : String
	{
		if (Math.abs(skill) > 49) {
			var str:String = coreGame.Language.GetHtml("CombatSkillLevels", coreGame.skNode);
			return coreGame.Language.strReplace(str, "#value", level + "");
		} else return coreGame.Language.GetHtml(GetSMSkillLang(skill) + "Level" + int(level), coreGame.skNode);
	}
	
	// Common skill functions (for slave + slave maker)
	public function LimitStat(stat:Number, inc:Number, max:Number) : Number
	{
		if (max == undefined) max = 100;
		var val:Number = stat + inc;
		if (val > max) {
			//if (val > 300) return 300;
			//val -= 10; ?decay large valied
			//if (val < max) return max; 
			return max;
		} else if (val < 0) return 0;
		return val;
	}
	
	public function IconValue(mc:MovieClip, val:Number)
	{
		if (val == 0) return;
		var tot:Number = val;
		if (mc.PlusIcon._visible || mc.MinusIcon._visible) tot += mc.PlusIcon.total;
		if (tot == 0) {
			mc.MinusIcon._visible = false;
			mc.PlusIcon._visible = false;
			return;
		}
		var micon:MovieClip = tot < 0 ? mc.MinusIcon : mc.PlusIcon;
		if (tot > 0) mc.MinusIcon._visible = false;
		else mc.PlusIcon._visible = false;
		if (!coreGame.Options.StatIcons) {
			micon.StatValue.htmlText = tot > 0 ? "+" + Math.round(tot * 10) / 10 : "-" + Math.round(tot * -10) / 10;
			micon.StatValue._visible = true;
			micon.StatIcon._visible = false;
		} else {
			micon.StatValue._visible = false;
			micon.StatIcon._visible = true;
		}
		micon._visible = true;
		mc.PlusIcon.total = tot;
	}
	
	// Pregnancy
	
	// "virtual" to allow for slave/slavemaker differences
	public function Impregnate(type:String, count:Number, gestation:Number) { }
	
	// base version with slave/slavemaker implementations to allow for differences
	public function CanImpregnate(type:String) : Boolean
	{
		if (PregnancyGestation > 0 || coreGame.PregnancyOn == false) return false;
		
		if (type.toLowerCase() == "yours" && coreGame.SMData.Gender == 2) {
			if (!coreGame.SMData.SMFeeldoOK) return false;
		}
		return true;
	}	

	public function CheckImpregnate(type:String, count:Number, gestation:Number) : Boolean {
		if (CanImpregnate(type)) {
			Impregnate(type, count, gestation);
			return true;
		}
		return false;
	}
	
	public function IsPregnant() : Boolean { return PregnancyGestation > 0; }
	
	public function AddToPregnancy(count:Number)
	{
		if (PregnancyGestation > 0) PregnancyCount += count;
	}
	
	public function UseContraceptives(buse:Boolean)
	{
		if (buse) BitFlagC.ClearBitFlag(14);
		else BitFlagC.SetBitFlag(14);
	}

	
	// Race
	
	public function IsElf() : Boolean { return GetRaceId() == 1 || GetRaceId() == 9; }
	public function IsTrueCatgirl() : Boolean { return GetRaceId() == 2; }
	public function IsFurry() : Boolean { return GetRaceId() == 4; }
	public function IsVampire() : Boolean { return GetRaceId() == 3; }
	public function IsHuman() : Boolean { return GetRaceId() == 0; }
	
	// Race
	// 0-9999 = mortal
	// 1000+ = immortal
	// 0 = human
	// 1 = elf
	// 2 = true cat girl
	// 3 = vampire
	// 4 = furry
	// 5 = drider
	// 6 = lamia
	// 7 = centaur
	// 8 = fairy
	// 9 = dark elf
	// 1000 = mermaid
	public function GetRaceId() : Number { return 0; }
	
	public function GetRace() : String
	{
		return DecodeRaceId(GetRaceId());
	}
	
	public function DecodeRace(str:String) : String
	{
		var ret:Number = DecodeRaceNum(str);
		if (ret != -1) return DecodeRaceId(ret);
		return str;
	}
	
	public function DecodeRaceNum(str:String) : Number
	{
		if (!isNaN(str)) return coreGame.XMLData.FixNumber(str);
		
		var strp:String = str.split(" ").join("").toLowerCase();
		
		// default human
		if (strp == "") return 0;

		// mortal
		for (var i:Number = 0; i < 10; i++) {
			if (strp == DecodeRaceId(i).toLowerCase().split(" ").join("")) return i;
		}
		// special alternates
		if (strp == "woodelf") return 1;
		if (strp == "darkelf") return 9;
		if (strp == "drider") return 5;
		if (strp == "faerie") return 8;
		
		// immortal
		if (strp == DecodeRaceId(1000).toLowerCase().split(" ").join("")) return 1000;
		
		// other custom/unknown value
		return -1;
	}
	
	public function DecodeRaceId(rc:Number) : String
	{
		// mortal
		var str:String = coreGame.Language.GetHtml("Race" + rc, "Statistics");
		if (str != "") return str;
		return coreGame.Language.GetHtml("Race0", "Statistics");
	}

	// Personality
	public function DefaultPersonality(sd:Object)
	{
		/*
		Extraversion vs Introversion:
		ExtraversionBloodMultiplier*(3*Conversation + Joy + Nymphomania)
		IntroversionBloodMultiplier*(2*Refinement + Morality + Temperament)
		
		Sensing vs Intuition:
		SensingBloodMultiplier*(2* Intelligence + Conversation)
		IntuitionBloodMultiplier*(2*Sensibility + Morality)
		
		Thinking vs Feeling:
		ThinkingBloodMultiplier*(Intelligence)
		FeelingBloodMultiplier*(Sensiblity)
		
		Judging vs Perception:
		JudgingBloodMultiplier*(Temperament/2+Inteligence+Morality)
		PerceptionversionBloodMultiplier*(Conversation+Sen sibility)
		
		The multiplier is calculated through the Blood Types:
		Blood Types:
		A: Adds a multiplier of 2 to Introversion.
		Adds a multiplier of 1.5 to Perception.
		
		B: Adds a multiplier of 2 to Judging.
		Adds a multiplier of 1.5 to Thinking.
		
		AB: Adds a multiplier of 2 to Feeling.
		Adds a multiplier of 1.5 to Extroversion.
		
		O: Adds a multiplier of 2 to Intuition.
		Adds a multiplier of 1.5 to Perception.
		
		With 50+ displaying as Extroversion, Sensing, Thinking and Judgement.
		*/
		var tempa:Number;
		var tempb:Number;

		if (Attitude == -1 || Attitude == undefined) {
			tempa = 3 * sd.VarConversation + sd.VarJoy + sd.VarNymphomania;		// extroversion
			tempb = 2 * sd.VarRefinement + sd.VarMorality + sd.VarTemperament;	// introversion
			if (sd.vitalsBloodType == "AB") tempa *= 1.5;
			else if (sd.vitalsBloodType == "A") tempb *= 2;
			if (tempa >= tempb) Attitude = 75; // Extroversion
			else Attitude = 25; // Introversion
		}
		if (Perception == -1 || Perception == undefined) {
			tempa = 2 * sd.VarIntelligence + sd.VarConversation;		// sensing
			tempb = 2 * sd.VarSensibility + sd.VarMorality;			// intuition
			if (sd.vitalsBloodType == "O") tempb *= 2;
			if (tempa >= tempb) Perception = 75; // Sensing
			else Perception = 25; // Intuition
		}
		if (Judgement == -1 || Judgement == undefined) {
			tempa = sd.VarIntelligence;		// thinking
			tempb = sd.VarSensibility;		// feeling
			if (sd.vitalsBloodType == "B") tempa *= 1.5;
			else if (sd.vitalsBloodType == "AB") tempb *= 2;
			if (tempa >= tempb) Judgement = 75; // Thinking
			else Judgement = 25; // Feeling
		}
		if (Lifestyle == -1 || Lifestyle == undefined) {
			tempa = sd.VarConversation + sd.VarSensibility;					// Perception
			tempb = sd.VarTemperament / 2 + sd.VarIntelligence + sd.VarMorality;	// Judgement
			if (sd.vitalsBloodType == "A") tempa *= 1.5;
			else if (sd.vitalsBloodType == "B") tempb *= 2;
			if (tempa >= tempb) Lifestyle = 75; // Perception
			else Lifestyle = 25; // Judgement
		}		
	}
	
	public function GetAttitudeType() : String { return Attitude > 50 ? coreGame.Language.GetText("Extroversion", "Statistics") : coreGame.Language.GetText("Introversion", "Statistics"); }
	public function GetPerceptionType() : String { return Perception > 50 ? coreGame.Language.GetText("Sensing", "Statistics") : coreGame.Language.GetText("Intuition", "Statistics"); }
	public function GetJudgementType() : String { return Judgement > 50 ? coreGame.Language.GetText("Thinking", "Statistics") : coreGame.Language.GetText("Feeling", "Statistics"); }
	public function GetLifestyleType() : String { return Lifestyle > 50 ? coreGame.Language.GetText("Perception", "Statistics") : coreGame.Language.GetText("Judgement", "Statistics"); }
	
	public function GetPersonalityDescription() : String
	{
		if (Attitude < 50 && Perception > 50 && Judgement > 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality1", "Statistics"); //"#slave is independent and action oriented.";
		if (Attitude < 50 && Perception <= 50 && Judgement > 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality2", "Statistics"); //"#slave is curious and individualistic.";
		
		if (Attitude < 50 && Perception > 50 && Judgement <= 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality3", "Statistics"); //"#slave is creative and sensitive.";
		if (Attitude < 50 && Perception <= 50 && Judgement <= 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality4", "Statistics"); //"#slave is compassionate and ingenious.";
		
		if (Attitude < 50 && Perception > 50 && Judgement > 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality5", "Statistics"); //"#slave is dependable and honest.";
		if (Attitude < 50 && Perception <= 50 && Judgement > 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality6", "Statistics"); //"#slave is adaptable and determined.";
		
		if (Attitude < 50 && Perception > 50 && Judgement <= 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality7", "Statistics"); //"#slave is reserved and kind.";
		if (Attitude < 50 && Perception <= 50 && Judgement <= 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality8", "Statistics"); //"#slave is empathetic and dedicated.";
		
		if (Attitude > 50 && Perception > 50 && Judgement > 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality9", "Statistics"); //"#slave is responsible and hardworking.";
		if (Attitude > 50 && Perception <= 50 && Judgement > 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality10", "Statistics"); //"#slave is ambitious and focused.";
		
		if (Attitude > 50 && Perception > 50 && Judgement <= 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality11", "Statistics"); //"#slave is social and dutiful.";
		if (Attitude > 50 && Perception <= 50 && Judgement <= 50 && Lifestyle <= 50) return coreGame.Language.GetText("Personality12", "Statistics"); //"#slave is altruistic and charismatic.";
		
		if (Attitude > 50 && Perception > 50 && Judgement > 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality13", "Statistics"); //"#slave is adaptable and enthusiastic.";
		if (Attitude > 50 && Perception <= 50 && Judgement > 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality14", "Statistics"); //"#slave is perceptive and inventive.";
		
		if (Attitude > 50 && Perception > 50 && Judgement <= 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality15", "Statistics"); //"#slave is cooperative and enjoys attention.";
		if (Attitude > 50 && Perception <= 50 && Judgement <= 50 && Lifestyle > 50) return coreGame.Language.GetText("Personality16", "Statistics"); //"#slave is expressive and inspiring.";
		
		return "";
	}
	
	// Measurements

	// Ideal Weight/Height
	/*
	J. D. Robinson Formula (1983)
	
		52 kg + 1.9 kg per inch over 5 feet       (man)
		49 kg + 1.7 kg per inch over 5 feet       (woman) 
	
	D. R. Miller Formula (1983)
	
		56.2 kg + 1.41 kg per inch over 5 feet       (man)
		53.1 kg + 1.36 kg per inch over 5 feet       (woman) 
	
	G. J. Hamwi Formula (1964)
	
		48.0 kg + 2.7 kg per inch over 5 feet       (man)
		45.5 kg + 2.2 kg per inch over 5 feet       (woman) 
	
	B. J. Devine Formula (1974)
	
		50.0 + 2.3 kg per inch over 5 feet       (man)
		45.5 + 2.3 kg per inch over 5 feet       (woman) 
	*/
	static function calcWeightMale(tall:Number) : Number
	{
		var nInches:Number = tall / 2.54;
		var inchesover5:Number = nInches - 60;
		
		if (nInches >= 60) return 50 + int(inchesover5 * 2.3);
		return 35 + int(1.1 * nInches);
	}
	static function calcWeightFemale(tall:Number) : Number
	{
		var nInches:Number = tall / 2.54;
		var inchesover5:Number = nInches - 60;
		
		if (nInches >= 60) return 45.5 + int(inchesover5 * 2.3);
		return 33 + int(1.1 * nInches);
	}
	
	// Potions
	
	public function GetPotionUsed(potion:Number) : Number
	{
		if (potion < PotionsUsed.length) return PotionsUsed[potion];
		return 0;
	}

	public function SetPotionUsed(potion:Number, num:Number)
	{
		var len:Number = PotionsUsed.length;
		if (potion < len) {
			for (var i:Number = len; i <= potion; i++) PotionsUsed.push(0);
		}
		if (num == undefined) num = 1;
		PotionsUsed[potion] = num;
	}
	
	public function ChangePotionUsed(potion:Number, num:Number)
	{
		var len:Number = PotionsUsed.length;
		if (potion < len) {
			for (var i:Number = len; i <= potion; i++) PotionsUsed.push(0);
		}
		if (num == undefined) num = 1;
		PotionsUsed[potion] += num;
	}

	
	// day/time
	public function NewDay(nDays:Number)
	{
		if (PregnancyGestation > 0) {
			PregnancyGestation -= nDays;
			if (PregnancyGestation <= 0) PregnancyGestation = -1000;	// trigger pregnant event next start of day
		}
		
		if (DaysUnavailable != 0) {
			if (DaysUnavailable > 0) {
				DaysUnavailable -= nDays;
				if (DaysUnavailable < 0) DaysUnavailable = 0;
			} else {
				DaysUnavailable += nDays;
				if (DaysUnavailable > 0) DaysUnavailable = 0;					
			}
		}
	}
	
	// Bloodtype
	
	public function ShowBloodTypeHint(type:String, xpos:Number, wid:Number)
	{
		type = type.toUpperCase();
		if (type == "O") coreGame.Hints.ShowHint(coreGame.Language.GetHtml("HintTypeOBlood", coreGame.Language.hintNode), xpos, wid);
		else if (type == "A") coreGame.Hints.ShowHint(coreGame.Language.GetHtml("HintTypeABlood", coreGame.Language.hintNode), xpos, wid);
		else if (type == "B") coreGame.Hints.ShowHint(coreGame.Language.GetHtml("HintTypeBBlood", coreGame.Language.hintNode), xpos, wid);
		else if (type == "AB") coreGame.Hints.ShowHint(coreGame.Language.GetHtml("HintTypeABBlood", coreGame.Language.hintNode), xpos, wid);
	}


}
