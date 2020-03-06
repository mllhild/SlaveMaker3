import Scripts.Classes.*;
// SlaveMakerSkills - class defining the skills for a slave maker or assistant
// not currently used for slaves any other types of slaves

// NOTE: extends DressCommon, but that is due to limitations of the inheritance system,
//		 not due to any relationship to this class

// Common to Slave and SlaveMaker

class SlaveMakerSkills extends DressCommon {
	
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

	public var arExperience:Array;
	
	// Methods
	
	// Constructor
	public function SlaveMakerSkills(cg:Object) { 
		super(cg);
		
		Reset();
	}
	
	// Initialise all variables
	public function Reset() {
		
		super.Reset();
		
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
	}
		
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
		if (skills == "slavetrainer") return 13;
		for (var i:Number = 50; i < 59; i++) {
			if (GetSMSkillLang(i).toLowerCase() == skills) return i;
		}
		
		// alternate names
		if (skills == "puppytrainer") return 16;
		if (skills == "cattrainer") return 6;

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
			return coreGame.strReplace(str, "#value", level + "");
		} else return coreGame.Language.GetHtml(GetSMSkillLang(skill) + "Level" + int(level), coreGame.skNode);
	}
	
	// Common skill functions (for slave + slave maker)
	public function LimitStat(stat:Number, inc:Number, max:Number) : Number
	{
		if (max == undefined) max = 100;
		var val:Number = stat + inc;
		if (val > max) {
			if (val > 300) return 300;
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
		if (!coreGame.StatIcons) {
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
	
}