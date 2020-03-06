// Slave Initialisation and creation XML
//
// Translation status: COMPLETE
import Scripts.Classes.*;

class GameXML extends XMLStatistics {
		
	// constructor (minimal)
	public function GameXML(cg:Object)	{ super(cg); }
	

	// Slave
	
	public function StartGameSlaveXML(sNode:XMLNode, sd:Slave)
	{		
		//if (sNode == undefined) sNode = slaveNode;
		slaveData = coreGame.slaveData;
		coreGame.PersonIndex = sd.SlaveIndex;
		
		var str:String = GetXMLString("Image", sNode);
		if (str != "") sd.SlaveImage = str;
		str = GetXMLString("Name", sNode);
		if (str != "") sd.SlaveName = str;
		str = GetXMLString("Name1", sNode);
		if (str != "") sd.SlaveName1 = str;
		str = GetXMLString("Name2", sNode);
		if (str != "") sd.SlaveName2 = str;
		str = GetXMLString("Folder", sNode);
		if (str != "") sd.ImageFolder = str;
		sd.Price = GetXMLValue("Price", sNode, sd.Price);
		str = GetXMLString("Gender", sNode).toLowerCase();
		if (str != "") {
			sd.SlaveGender = coreGame.GetGender(str);
			sd.GenderIdentity = sd.SlaveGender;
			if (sd.SlaveGender > 3) sd.SlavePronoun = coreGame.Language.strPronounTwins;
		}
		str = GetXMLString("GenderIdentity", sNode).toLowerCase();
		if (str != "") {
			sd.GenderIdentity = coreGame.GetGender(str);
			if (sd.GenderIdentity > 3) sd.SlavePronoun = coreGame.Language.strPronounTwins;
		}	
		str = GetXMLString("GenderBorn", sNode);
		if (str != "") sd.SlaveGenderBorn = coreGame.GetGender(str);
		else sd.SlaveGenderBorn = sd.SlaveGender;
		str = GetXMLString("Race", sNode);
		if (str != "") sd.Race = SMData.DecodeRace(str);
		
		str = GetXMLString("Bust", sNode);
		if (str == "") str = GetXMLString("Chest", sNode);
		if (str != "") {
			sd.vitalsBust = FixNumber(str);
			sd.vitalsBustStart = sd.vitalsBust;
		}
		str = GetXMLString("Waist", sNode);
		if (str != "") sd.vitalsWaist = FixNumber(str);
		str = GetXMLString("Hips", sNode);
		if (str != "") sd.vitalsHips = FixNumber(str);
		str = GetXMLString("Age", sNode);
		if (str != "") {
			if (str == "?" || str == "unknown") sd.vitalsAge = -1;
			else sd.vitalsAge = FixNumber(str);
		}
		sd.IntimacyOK = GetXMLBoolean("IntimacyOK", sNode, sd.IntimacyOK);
		sd.HasTail = GetXMLBoolean("HasTail", sNode, sd.HasTail);
		
		str = GetXMLString("BloodType", sNode);
		if (str != "") sd.vitalsBloodType = str;
		str = GetXMLStringParsed("Description", sNode);
		if (str != "") sd.vitalsDescription = str;
		str = GetXMLString("Weight", sNode);
		if (str != "") sd.vitalsWeight = FixNumber(str);
		str = GetXMLString("Height", sNode);
		if (str != "") sd.vitalsHeight = FixNumber(str);
		str = GetXMLString("ClitCockSize", sNode);
		if (str == "") str = GetXMLString("Clit", sNode);
		if (str == "") str = GetXMLString("Cock", sNode);
		if (str != "") {
			sd.ClitCockSize = FixNumber(str);
			sd.ClitCockSizeStart = sd.ClitCockSize;
		}
		str = GetXMLString("Birthday", sNode);
		if (str != "") {
			var dt:Number = coreGame.ParseDate(str);
			if (!isNaN(dt)) sd.Birthday = dt;
		}
		sd.SetGirlsVitals(undefined, undefined, sd.vitalsBust, sd.vitalsWaist, sd.vitalsHips, sd.vitalsAge, sd.vitalsBloodType, sd.vitalsHeight, sd.vitalsWeight, sd.ClitCockSize, sd.Birthday);
	
		str = GetXMLString("TrainingDifficulty", sNode).toLowerCase();
		if (str != "") {
			if (str == "easy") sd.SlaveDifficulty = 0;
			else if (str == "medium") sd.SlaveDifficulty = 1;
			if (str == "hard") sd.SlaveDifficulty = 2;
		}

		// personality
		str = GetXMLString("Attitude", sNode);
		if (str != "") {
			if (str.toLowerCase() == "extroversion") sd.Attitude = 75;
			else if (str.toLowerCase() == "introversion") sd.Attitude = 25;
			else sd.Attitude = FixNumber(str);
		}
		str = GetXMLString("Perception", sNode);
		if (str != "") {
			if (str.toLowerCase() == "sensing") sd.Perception = 75;
			else if (str.toLowerCase() == "intuition") sd.Perception = 25;
			else sd.Perception = FixNumber(str);
		}
		str = GetXMLString("Judgement", sNode);
		if (str == "") str = GetXMLString("Judgment", sNode);
		if (str != "") {
			if (str.toLowerCase() == "thinking") sd.Judgement = 75;
			else if (str.toLowerCase() == "feeling") sd.Judgement = 25;
			else sd.Judgement = FixNumber(str);
		}
		str = GetXMLString("Lifestyle", sNode);
		if (str != "") {
			if (str.toLowerCase() == "perception") sd.Lifestyle = 75;
			else if (str.toLowerCase() == "judgement" || str.toLowerCase() == "judgment") sd.Lifestyle = 25;
			else sd.Lifestyle = FixNumber(str);
		}
	
		str = GetXMLString("CurrentPath", sNode);
		if (str != "") sd.CurrentPath = FixNumber(str);
		str = GetXMLString("Path1", sNode);
		if (str != "") sd.Path1 = FixNumber(str);
		str = GetXMLString("Path2", sNode);
		if (str != "") sd.Path2 = FixNumber(str);
		str = GetXMLString("Path3", sNode);
		if (str != "") sd.Path3 = FixNumber(str);
		str = GetXMLString("Slutiness", sNode);
		if (str != "") sd.Slutiness = FixNumber(str);
		str = GetXMLString("Loyalty", sNode).toLowerCase();
		if (str != "") {
			if (str == "absolute" || str == "loyal") sd.Loyalty = 0;
			else sd.Loyalty = FixNumber(str);
		}
		str = GetXMLString("ReluctanceLevel", sNode);
		if (str != "") coreGame.ReluctanceLevel = FixNumber(str);
	
		str = GetXMLString("FairyXF", sNode);
		if (str != "") sd.FairyXF = FixNumber(str);
	
		str = GetXMLString("PregnancyGestation", sNode);
		if (str != "") sd.PregnancyGestation = FixNumber(str);
		str = GetXMLString("PregnancyType", sNode);
		if (str != "") sd.PregnancyType = str;
		str = GetXMLString("PregnancyCount", sNode);
		if (str != "") sd.PregnancyCount = FixNumber(str);
		str = GetXMLString("Fertility", sNode);
		if (str != "") sd.Fertility = FixNumber(str.split("%").join(""));
	
		str = GetXMLString("PonygirlInterest", sNode);
		if (str != "") sd.PonygirlInterest = FixNumber(str);
		str = GetXMLString("LesbianInterest", sNode);
		if (str != "") sd.LesbianInterest = FixNumber(str);
		else {
			str = GetXMLString("GayInterest", sNode);
			if (str != "") sd.LesbianInterest = FixNumber(str);
		}
		if (sd.LesbianInterest == -1) {
			sd.Sexuality = 50;
			sd.StartSexuality = 50;
		}
		str = GetXMLString("CatgirlInterest", sNode);
		if (str != "") sd.CatgirlInterest = FixNumber(str);
		str = GetXMLString("SuccubusInterest", sNode);
		if (str != "") sd.SuccubusInterest = FixNumber(str);
		str = GetXMLString("PuppygirlInterest", sNode);
		if (str == "") str = GetXMLString("PuppyslaveInterest", sNode);
		if (str != "") sd.PuppygirlInterest = FixNumber(str);
	
		str = GetXMLString("Effeminate", sNode);
		if (str.toLowerCase() == "true") sd.BitFlag1.SetBitFlag(62);

		str = GetXMLString("Mute", sNode);
		if (str.toLowerCase() == "true") sd.BitFlag1.SetBitFlag(63);

		str = GetXMLString("TotalChildren", sNode);
		if (str != "") sd.TotalChildren = FixNumber(str);
		str = GetXMLString("TotalTentaclePregnancy", sNode);
		if (str != "") sd.TotalTentaclePregnancy = FixNumber(str);
		
		// Statistics
		var iNode:XMLNode = GetNodeC(sNode, "Statistics");
			
		str = GetXMLString("Charisma", iNode);
		if (str != "") sd.VarCharisma = FixNumber(str);
		str = GetXMLString("Sensibility", iNode);
		if (str != "") sd.VarSensibility = FixNumber(str);
		str = GetXMLString("Refinement", iNode);
		if (str != "") sd.VarRefinement = FixNumber(str);
		str = GetXMLString("Intelligence", iNode);
		if (str != "") sd.VarIntelligence = FixNumber(str);
		str = GetXMLString("Morality", iNode);
		if (str != "") sd.VarMorality = FixNumber(str);
		str = GetXMLString("Constitution", iNode);
		if (str != "") sd.VarConstitution = FixNumber(str);
		str = GetXMLString("Cooking", iNode);
		if (str != "") sd.VarCooking = FixNumber(str);
		str = GetXMLString("Cleaning", iNode);
		if (str != "") sd.VarCleaning = FixNumber(str);
		str = GetXMLString("Conversation", iNode);
		if (str != "") sd.VarConversation = FixNumber(str);
		str = GetXMLString("Fitness", iNode);
		if (str != "") sd.FatigueBonus = FixNumber(str);
		str = GetXMLString("BlowJob", iNode);
		if (str != "") sd.VarBlowJob = FixNumber(str);
		str = GetXMLString("Fuck", iNode);
		if (str != "") sd.VarFuck = FixNumber(str);
		str = GetXMLString("Temperament", iNode);
		if (str != "") sd.VarTemperament = FixNumber(str);
		str = GetXMLString("Nymphomania", iNode);
		if (str != "") sd.VarNymphomania = FixNumber(str);
		str = GetXMLString("Obedience", iNode);
		if (str != "") sd.VarObedience = FixNumber(str);
		str = GetXMLString("Lust", iNode);
		if (str != "") sd.VarLibido = FixNumber(str);
		str = GetXMLString("Reputation", iNode);
		if (str != "") sd.VarReputation = FixNumber(str);
		str = GetXMLString("Fatigue", iNode);
		if (str != "") sd.VarFatigue = FixNumber(str);
		str = GetXMLString("Joy", iNode);
		if (str != "") sd.VarJoy = FixNumber(str);
		str = GetXMLString("Love", iNode);
		if (str != "") sd.VarLovePoints = FixNumber(str);
		else {
			str = GetXMLString("LovePoints", iNode);
			if (str != "") sd.VarLovePoints = FixNumber(str);
		}
		str = GetXMLString("SexualEnergy", iNode);
		if (str != "") sd.VarSexualEnergy = FixNumber(str);
		str = GetXMLString("Special", iNode);
		if (str != "") sd.VarSpecial = FixNumber(str);
		str = GetXMLString("Special2", iNode);
		if (str != "") sd.VarSpecial2 = FixNumber(str);
		str = GetXMLString("Cunnilingus", iNode);
		if (str != "") sd.VarCunnilingus = FixNumber(str);
		str = GetXMLString("LesbianFuck", iNode);
		if (str != "") sd.VarLesbianFuck = FixNumber(str);
		str = GetXMLString("Deficiency", iNode);
		if (str != "") sd.Deficiency = SlaveStatistics.GetDeficiencyTalent(str);
		str = GetXMLString("NaturalTalent", iNode);
		if (str != "") sd.NaturalTalent = SlaveStatistics.GetDeficiencyTalent(str);
		
		str = GetXMLString("MaxFuck", iNode);
		if (str != "") sd.MaxFuck = FixNumber(str);
		str = GetXMLString("MaxBlowJob", iNode);
		if (str != "") sd.MaxBlowJob = FixNumber(str);
		str = GetXMLString("MaxObedience", iNode);
		if (str != "") sd.InitialiseMaxObedience(FixNumber(str));
		str = GetXMLString("MaxSpecial", iNode);
		if (str != "") sd.MaxSpecial = FixNumber(str);
		str = GetXMLString("MaxSpecial2", iNode);
		if (str != "") sd.MaxSpecial2 = FixNumber(str);
		str = GetXMLString("MaxLove", iNode);
		if (str != "") sd.MaxLove = FixNumber(str);
		str = GetXMLString("MaxLust", iNode);
		if (str != "") sd.MaxLibido = FixNumber(str);	
		str = GetXMLString("MaxCharisma", iNode);
		if (str != "") sd.MaxCharisma = FixNumber(str);	
		str = GetXMLString("MaxRefinement", iNode);
		if (str != "") sd.MaxRefinement = FixNumber(str);	
		str = GetXMLString("MaxSensibility", iNode);
		if (str != "") sd.MaxSensibility = FixNumber(str);	
		str = GetXMLString("MaxIntelligence", iNode);
		if (str != "") sd.MaxIntelligence = FixNumber(str);	
		str = GetXMLString("MaxMorality", iNode);
		if (str != "") sd.MaxMorality = FixNumber(str);	
		str = GetXMLString("MaxConstitution", iNode);
		if (str != "") sd.MaxConstitution = FixNumber(str);	
		str = GetXMLString("MaxCooking", iNode);
		if (str != "") sd.MaxCooking = FixNumber(str);
		str = GetXMLString("MaxCleaning", iNode);
		if (str != "") sd.MaxCleaning = FixNumber(str);
		str = GetXMLString("MaxConversation", iNode);
		if (str != "") sd.MaxConversation = FixNumber(str);
		str = GetXMLString("MaxTemperament", iNode);
		if (str != "") sd.MaxTemperament = FixNumber(str);
		str = GetXMLString("MaxNymphomania", iNode);
		if (str != "") sd.MaxNymphomania = FixNumber(str);
		str = GetXMLString("MaxJoy", iNode);
		if (str != "") sd.MaxJoy = FixNumber(str);

		str = GetXMLString("MinLust", iNode);
		if (str != "") sd.MinLibido = FixNumber(str);
		str = GetXMLString("MinNymphomania", iNode);
		if (str != "") sd.MinNymphomania = FixNumber(str);

		iNode = GetNodeC(sNode, "StatisticsDetails");
		if (iNode != null) {
			var stNode:XMLNode = GetNode(iNode, "Special");
			if (stNode != null) {
				var nm:String = GetXMLString("Name", stNode.firstChild);
				if (nm.toLowerCase() != "None") {
					if (stNode.attributes.show != "false") sd.ShowSpecialStat(nm);
					else sd.SetSpecialStat(nm);
				}
			}
			stNode = GetNode(iNode, "Special2");
			if (stNode != null) {
				var nm:String = GetXMLString("Name", stNode.firstChild);
				if (nm.toLowerCase() != "None") {
					if (stNode.attributes.show != "false") sd.ShowSpecial2Stat(nm);
					else sd.SetSpecial2Stat(nm);
				}
			}
		} else {
			str = GetXMLString("SpecialStat", sNode);
			if (str != "" && str.toLowerCase() != "None") sd.ShowSpecialStat(str);
		}
		
		// Skills
		iNode = GetNodeC(sNode, "Skills");
		if (iNode != null) {
			
			str = GetXMLString("Singing", iNode);
			if (str != "") sd.slSinging = FixNumber(str);
			str = GetXMLString("Dancing", iNode);
			if (str != "") sd.slDancing = FixNumber(str);
			str = GetXMLString("Swimming", iNode);
			if (str != "") sd.slSwimming = FixNumber(str);
			str = GetXMLString("Combat", iNode);
			if (str != "") sd.slCombat = FixNumber(str);
			str = GetXMLString("Cumslut", iNode);
			if (str != "") sd.CumslutLevel = FixNumber(str);
			str = GetXMLString("CatSlaveTraining", iNode);
			if (str != "") sd.slCatTraining = FixNumber(str);
			str = GetXMLString("PuppySlaveTraining", iNode);
			if (str != "") sd.slPuppyTraining = FixNumber(str);
			str = GetXMLString("PonySlaveTraining", iNode);
			if (str != "") sd.slPonyTraining = FixNumber(str);
			str = GetXMLString("Seduction", iNode);
			if (str != "") sd.slSeduction = FixNumber(str);
			str = GetXMLString("Courtesan", iNode);
			if (str != "") sd.slCourtesan = FixNumber(str);
			str = GetXMLString("SuccubusTraining", iNode);
			if (str != "") sd.slSuccubusTraining = FixNumber(str);
			
			str = GetXMLString("SlaveTrainer", iNode);
			if (str != "") sd.sSlaveTrainer = FixNumber(str);
			str = GetXMLString("LesbianTrainer", iNode);
			if (str != "") sd.sLesbianTrainer = FixNumber(str);
			str = GetXMLString("GayTrainer", iNode);
			if (str != "") sd.sGayTrainer = FixNumber(str);			
			str = GetXMLString("Trader", iNode);
			if (str != "") sd.sTrader = FixNumber(str);
			str = GetXMLString("Alchemy", iNode);
			if (str != "") sd.sAlchemy = FixNumber(str);
			str = GetXMLString("PonyTrainer", iNode);
			if (str != "") sd.sPonyTrainer = FixNumber(str);
			str = GetXMLString("CatTrainer", iNode);
			if (str != "") sd.sCatTrainer = FixNumber(str);
			str = GetXMLString("PuppyTrainer", iNode);
			if (str != "") sd.sPuppyTrainer = FixNumber(str);
			str = GetXMLString("SuccubusTrainer", iNode);
			if (str != "") sd.sSuccubusTrainer = FixNumber(str);
			str = GetXMLString("SlutTrainer", iNode);
			if (str != "") sd.sSlutTrainer = FixNumber(str);
			str = GetXMLString("OrgasmDenialTraining", iNode);
			if (str != "") sd.sOrgasmDenialTraining = FixNumber(str);
			str = GetXMLString("Noble", iNode);
			if (str == "") str = GetXMLString("Nobility", iNode);
			if (str != "") sd.sNoble = FixNumber(str);
			str = GetXMLString("TentacleExpert", iNode);
			if (str != "") sd.sTentacleExpert = FixNumber(str);
			str = GetXMLString("Refined", iNode);
			if (str != "") sd.sRefined = FixNumber(str);
			str = GetXMLString("BreastExpert", iNode);
			if (str != "") sd.sBreastExpert = FixNumber(str);
			
			str = GetXMLString("SwordSkill", iNode);
			if (str != "") sd.sSwordExpertise = FixNumber(str);
			str = GetXMLString("WhipSkill", iNode);
			if (str != "") sd.sWhipExpertise = FixNumber(str);
			str = GetXMLString("BowSkill", iNode);
			if (str != "") sd.sBowExpertise = FixNumber(str);
			str = GetXMLString("Leadership", iNode);
			if (str != "") sd.sLeadership = FixNumber(str);
			str = GetXMLString("HammerSkill", iNode);
			if (str != "") sd.sHammerExpertise = FixNumber(str);
			str = GetXMLString("NaginataSkill", iNode);
			if (str != "") sd.sNaginataExpertise = FixNumber(str);
			str = GetXMLString("DaggerSkill", iNode);
			if (str != "") sd.sDaggerExpertise = FixNumber(str);
			str = GetXMLString("CrossbowSkill", iNode);
			if (str != "") sd.sCrossbowExpertise = FixNumber(str);
			str = GetXMLString("ThrownWeaponSkill", iNode);
			if (str != "") sd.sThrownExpertise = FixNumber(str);
			str = GetXMLString("UnarmedCombat", iNode);
			if (str != "") sd.sUnarmedExpertise = FixNumber(str);

		
			var skNode:XMLNode = GetNode(iNode, "Combat");
			if (skNode != "") {
				var sname:String = skNode.attributes.name;
				var shint:String = skNode.attributes.hint;
				sd.SetSlaveCombatSkill(sname, shint);
			}
			
			// total and levels for sex skills
			// IMPORTANT: sex act full range is 1-999, limited here to 100
			for (var i:Number = 1; i < 100; i++) {
				var strn:String = ActInfoList.GetActNameBase(i);
				str = GetXMLString("Total" + strn, iNode);
				if (str == "") str = GetXMLString("Total-" + strn, iNode);
				if (str != "") sd.SetActTotal(i, FixNumber(str));
				str = GetXMLString("Level" + strn, iNode);
				if (str == "") str = GetXMLString("Level-" + strn, iNode);
				if (str != "") coreGame.SetSexActLevel(i, FixNumber(str), sd);
			}
	
		}
	
		
		// Difficulties
		iNode = GetNodeC(sNode, "Difficulties");
		
		str = GetXMLString("XXX", iNode);
		if (str != "") sd.DifficultyXXX = FixNumber(str);
		str = GetXMLString("XXXContest", iNode);
		if (str != "") sd.DifficultyXXXContest = FixNumber(str);
		str = GetXMLString("Expose", iNode);
		if (str != "") sd.DifficultyExhib = FixNumber(str);
		str = GetXMLString("SleazyBar", iNode);
		if (str != "") sd.DifficultySleazyBar = FixNumber(str);
		str = GetXMLString("Brothel", iNode);
		if (str != "") sd.DifficultyBrothel = FixNumber(str);
		str = GetXMLString("Touch", iNode);
		if (str != "") sd.DifficultyTouch = FixNumber(str);
		str = GetXMLString("Lick", iNode);
		if (str != "") sd.DifficultyLick = FixNumber(str);
		str = GetXMLString("Masturbate", iNode);
		if (str != "") sd.DifficultyMasturbate = FixNumber(str);	
		str = GetXMLString("Fuck", iNode);
		if (str != "") sd.DifficultyFuck = FixNumber(str);
		str = GetXMLString("Blowjob", iNode);
		if (str != "") sd.DifficultyBlowjob = FixNumber(str);
		str = GetXMLString("TitsFuck", iNode);
		if (str != "") sd.DifficultyTitsFuck = FixNumber(str);
		str = GetXMLString("Anal", iNode);
		if (str != "") sd.DifficultyAnal = FixNumber(str);
		str = GetXMLString("Dildo", iNode);
		if (str != "") sd.DifficultyDildo = FixNumber(str);
		str = GetXMLString("Plug", iNode);
		if (str != "") sd.DifficultyPlug = FixNumber(str);
		str = GetXMLString("Lesbian", iNode);
		if (str != "") sd.DifficultyLesbian = FixNumber(str);
		str = GetXMLString("Bondage", iNode);
		if (str != "") sd.DifficultyBondage = FixNumber(str);
		str = GetXMLString("Naked", iNode);
		if (str != "") sd.DifficultyNaked = FixNumber(str);
		str = GetXMLString("Master", iNode);
		if (str != "") sd.DifficultyMaster = FixNumber(str);
		str = GetXMLString("GangBang", iNode);
		if (str != "") sd.DifficultyGangBang = FixNumber(str);
		str = GetXMLString("Lend", iNode);
		if (str == "") str = GetXMLString("LendHer", iNode);
		if (str != "") sd.DifficultyLendHer = FixNumber(str);
		str = GetXMLString("Ponygirl", iNode);
		if (str != "") sd.DifficultyPonygirl = FixNumber(str);
		str = GetXMLString("Spanking", iNode);
		if (str != "") sd.DifficultySpank = FixNumber(str);
		str = GetXMLString("Threesome", iNode);
		if (str != "") sd.DifficultyThreesome = FixNumber(str);
		str = GetXMLString("Handjob", iNode);
		if (str != "") sd.DifficultyHandjob = FixNumber(str);
		str = GetXMLString("Footjob", iNode);
		if (str != "") sd.DifficultyFootjob = FixNumber(str);
		str = GetXMLString("CumBath", iNode);
		if (str != "") sd.DifficultyCumBath = FixNumber(str);
		str = GetXMLString("Orgy", iNode);
		if (str != "") sd.DifficultyOrgy = FixNumber(str);
		str = GetXMLString("SixtyNine", iNode);
		if (str != "") sd.Difficulty69 = FixNumber(str);
		
		// default values
		if (sd.DifficultyHandjob == -1) sd.DifficultyHandjob = sd.DifficultyBlowjob - 5;
		if (sd.DifficultyFootjob == -1) sd.DifficultyFootjob = sd.DifficultyBlowjob - 3;
		if (sd.Difficulty69 == -1) sd.Difficulty69 = sd.DifficultyBlowjob - 3;
		if (sd.DifficultyCumBath == -1) sd.DifficultyCumBath = sd.DifficultyGangBang - 5;
		if (sd.DifficultyOrgy == -1) sd.DifficultyOrgy = sd.DifficultyGangBang - 10;
	
		iNode = GetNode(sNode, "Available");
		if (iNode != null) sd.Available = GetXMLBoolean("Available", sNode, true);
	
		str = GetXMLString("CustomFlag", sNode);
		if (str != "") sd.CustomFlag = GetExpression(str);
		str = GetXMLString("CustomFlag1", sNode);
		if (str != "") sd.CustomFlag1 = GetExpression(str);
		str = GetXMLString("CustomFlag2", sNode);
		if (str != "") sd.CustomFlag2 = GetExpression(str);
		str = GetXMLString("CustomFlag3", sNode);
		if (str != "") sd.CustomFlag3 = GetExpression(str);
		str = GetXMLString("CustomFlag4", sNode);
		if (str != "") sd.CustomFlag4 = GetExpression(str);
		str = GetXMLString("CustomFlag5", sNode);
		if (str != "") sd.CustomFlag5 = GetExpression(str);
		str = GetXMLString("CustomFlag6", sNode);
		if (str != "") sd.CustomFlag6 = GetExpression(str);
		str = GetXMLString("CustomFlag7", sNode);
		if (str != "") sd.CustomFlag7 = GetExpression(str);
		str = GetXMLString("CustomFlag8", sNode);
		if (str != "") sd.CustomFlag8 = GetExpression(str);
		str = GetXMLString("CustomFlag9", sNode);
		if (str != "") sd.CustomFlag9 = GetExpression(str);
		str = GetXMLString("CustomString", sNode);
		if (str != "") sd.CustomString = str;
	
		sd.VirginVaginal = GetXMLBoolean("VirginVaginal", sNode, sd.VirginVaginal);
		sd.VirginAnal = GetXMLBoolean("VirginAnal", sNode, sd.VirginAnal);
		sd.VirginOral = GetXMLBoolean("VirginOral", sNode, sd.VirginOral);
		str = GetXMLString("Sexuality", sNode);
		if (str != "") {
			sd.SetSexuality(GetExpression(str));
			sd.StartSexuality = sd.Sexuality;
		}
		
		// Love
		str = GetXMLString("OldLover", sNode);
		if (str != "") sd.OldLover = FixNumber(str);
		str = GetXMLString("Dating", sNode);
		if (str != "") sd.EventBoyfriend = FixNumber(str);
		str = GetXMLString("NobleLoveType", sNode);
		if (str != "") sd.NobleLoveType = FixNumber(str);
		str = GetXMLString("LoveAccepted", sNode);
		if (str != "") sd.LoveAccepted = FixNumber(str);
		
		// Speech
		str = GetXMLString("Pronoun", sNode);
		if (str != "") sd.SlavePronoun = str;
	
		iNode = GetNodeC(sNode, "Speech");
		if (iNode != null) {
			str = GetXMLString("Pronoun", iNode);
			if (str != "") sd.SlavePronoun = str;
			
			iNode = GetNode(iNode, "Suffix");
			if (iNode != null) {
				var chance:Number = 100;
				for (var attr:String in iNode.attributes) {
					if (attr == "chance") chance = iNode.attributes[attr];
				}
				sd.AddSpeechSuffix(chance, iNode.firstChild.nodeValue);
			}
		}
		
		if (sd == coreGame.slaveData) StartGameMainSlave(sNode);
		StartGameCommonXML(sNode);
	}
	
	public function StartGameMainSlave(sNode:XMLNode)
	{
		// main slave only
		var iNode:XMLNode = GetNodeC(sNode, "Dresses");
		InitialiseDresses(iNode, true);
		
		var str:String = GetXMLString("TrainingTime", sNode);
		if (str != "") coreGame.TrainingTime = FixNumber(str);
		str = GetXMLString("MaxTentacleHarem", sNode);
		if (str != "") coreGame.MaxTentacleHarem = FixNumber(str);
		str = GetXMLString("SoldSlave", sNode);
		if (str != "") ParseChangeOwner(GetNode(sNode, "SoldSlave"));
		else {
			str = GetXMLString("Owner", sNode);
			if (str != "") ParseChangeOwner(GetNode(sNode, "Owner"));
		}
		str = GetXMLString("IntroPages", sNode);
		if (str != "") coreGame.IntroPages = FixNumber(str);
	}
	
	
	public function ApplyDressEffects(dress:Number, eNode:XMLNode)
	{
		ApplyDressStats(dress, eNode);
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "holy": slaveData.SetDressHoly(dress); break;
				case "easy": slaveData.SetDressEasy(dress); break;
				case "courtly": slaveData.SetDressCourtly(dress); break;
				case "swimsuit": slaveData.SetDressSwimsuit(dress); break;
				case "sleazybar": slaveData.SetDressSleazyBar(dress); break;
				case "slutty": slaveData.SetDressSlutty(dress); break;
				case "dance":
				case "dancing": slaveData.SetDressDancing(dress); break;
				case "maid": slaveData.SetDressMaid(dress); break;
				case "lingerie": slaveData.SetDressLingerie(dress); break;
				case "catears": slaveData.SetDressCatEars(dress); break;
				case "cattail": slaveData.SetDressCatTail(dress); break;
				case "miko": slaveData.SetDressMiko(dress); break;
				case "waitress": slaveData.SetDressWaitress(dress); break;
				case "demonic": slaveData.SetDressDemonic(dress); break;
				case "puppyears": slaveData.SetDressPuppyEars(dress); break;
				case "puppytail": slaveData.SetDressPuppyTail(dress); break;
				
			}
		}
	}

	
	public function InitialiseDress(dNode:XMLNode, id:Number, start:Boolean)
	{	
		var act:ActInfo = slaveData.ActInfoBase.GetAct(id * -1);
		act.strNodeName = "Dress " + id;
		act.Normal.UpdateActCounts(1, 0, 0, 0);
	
		var str:String = coreGame.Language.GetHtml("Name", dNode);
		if (str != "") slaveData.SetDressDetails(id, str);
		
		str = GetXMLString("Price", dNode);
		if (str != "") slaveData.SetDressDetails(id, undefined, undefined, undefined, FixNumber(str));
		
		if (start == true) {
			str = GetXMLString("Sold", dNode, slaveData.SlaveFilename == "" ? "true" : "");
			if (str != "") slaveData.SetDressDetails(id, undefined, undefined, str.toLowerCase() == "true");
		}
		
		var eNode:XMLNode = GetNode(dNode, "StatEffects");
		if (eNode != null) ApplyDressEffects(id, eNode);
		
		str = GetXMLMultiLineString("Effects", dNode);
		if (str != "") slaveData.SetDressDetails(id, undefined, coreGame.Language.strLineChanges(str));
	
		var iNodeF:XMLNode = GetNodeC(dNode, "Normal");
		if (iNodeF != null) {
			str = GetXMLString("Count", iNodeF);
			if (str == "") str = iNodeF.nodeValue;
			if (str != "") act.Normal.UpdateActCounts(FixNumber(str));
		}
	
		iNodeF = GetNodeC(dNode, "Dickgirl");
		if (iNodeF != null) {
			str = GetXMLString("Count", iNodeF);
			if (str == "") str = coreGame.Language.GetHtml("Dickgirl", dNode);
			if (str != "") act.Dickgirl.UpdateActCounts(FixNumber(str));
		}
		
		iNodeF = GetNodeC(dNode, "Catgirl");
		if (iNodeF != null) {
			str = GetXMLString("Count", iNodeF);
			if (str == "") str = coreGame.Language.GetHtml("Catgirl", dNode);
			if (str != "") act.Catgirl.UpdateActCounts(FixNumber(str));
		}
		
		iNodeF = GetNodeC(dNode, "Puppygirl");
		if (iNodeF != null) {
			str = GetXMLString("Count", iNodeF);
			if (str == "") str = coreGame.Language.GetHtml("Puppygirl", dNode);
			if (str != "") act.Puppygirl.UpdateActCounts(FixNumber(str));
		}
	
		iNodeF = GetNodeC(dNode, "Pregnant");
		if (iNodeF != null) {
			str = GetXMLString("Count", iNodeF);
			if (str == "") str = coreGame.Language.GetHtml("Pregnant", dNode);
			if (str != "") act.Pregnant.UpdateActCounts(FixNumber(str));
		}
	}
	
	
	public function InitialiseDresses(iNode:XMLNode, start:Boolean)
	{		
		var str:String;
		var dNode:XMLNode;
	
		for (var id:Number = 0; id < 7; id++) {
			dNode = GetNodeC(iNode, "Dress" + id);
			if (dNode != null) InitialiseDress(dNode, id, start);
		}
		
		dNode = GetNodeC(iNode, "DressPlain");
		if (dNode != null) InitialiseDress(dNode, 0, start);
		
		dNode = GetNodeC(iNode, "CustomUniform1");
		if (dNode != null) {
			var str:String = coreGame.Language.GetHtml("Name", dNode);
			if (str != "") slaveData.SetCustomUniform(1, str);
		}
		dNode = GetNodeC(iNode, "CustomUniform2");
		if (dNode != null) {
			var str:String = coreGame.Language.GetHtml("Name", dNode);
			if (str != "") slaveData.SetCustomUniform(2, str);
		}
	}
		
	public function InitialiseSlaveXML(start:Boolean)
	{
		var iNode:XMLNode = GetNodeC(slaveNode, "Dresses");

		slaveData = coreGame.slaveData;
		InitialiseDresses(iNode, start);
		var str:String = GetXMLString("Version", slaveNode);
		if (str != "") coreGame.SlaveVersion = str + "";
		str = GetXMLString("Credits", slaveNode);
		if (str != "") coreGame.SlaveCredits = str + "";
	
		coreGame.SlaveLikeServant = GetXMLBoolean("SlaveLikeServant", slaveNode, coreGame.SlaveLikeServant);
		coreGame.Milkable = GetXMLBoolean("Milkable", slaveNode, coreGame.Milkable);
		coreGame.OwnerTesting = GetXMLBoolean("OwnerTesting", slaveNode, coreGame.OwnerTesting);
		coreGame.OwnerTestingUrgent = GetXMLBoolean("OwnerTestingUrgent", slaveNode, coreGame.OwnerTestingUrgent);	
				
		// Items
		iNode = GetNodeC(slaveNode, "Items");
		if (iNode == null) iNode = GetNodeC(slaveNode, "Equipment");
		if (iNode == null) iNode = GetNodeC(flNode, "Equipment");
		if (iNode != null) {
			for (var i:Number = 50; i < 79; i++) {
				var ciNode:XMLNode = GetNodeC(iNode, "Custom" + (i - 49));
				if (ciNode != null) {
					coreGame.Items.SetCustomItems(true);
					str = GetXMLString("Name", ciNode);
					if (str != "") coreGame.SelectEquipment.SetEquipmentLabel(i, str);
				}
			}
		}
			
		InitialiseCommonXML(slaveNode, false);		// slaveData initialised in InitialuseDresses()
		
		if (start == true) return;
			
		slaveData.LoadActImages(slaveNode, undefined, true);
	}
	
	
	// Assistant
	
	public function InitialiseAssistantXML(aNode:XMLNode)
	{	
		if (aNode == undefined) aNode = GetNodeC(flNode, "Assistant");
		coreGame.PersonIndex = -99;
		
		var str:String = GetXMLMultiLineStringParsed("AssistantDescription", aNode);
		if (str != "") coreGame.AssistantDescription = str;
		str = GetXMLString("Cost", aNode);
		if (str != "") coreGame.AssistantCost = FixNumber(str);
		str = GetXMLString("Renown", aNode);
		if (str != "") coreGame.AssistantReputation = FixNumber(str);
		str = GetXMLString("SlaveType", aNode);
		if (str != "") coreGame.AssistantData.SlaveType = FixNumber(str);
		
		str = GetXMLString("Version", aNode);
		if (str != "") coreGame.AssistantVersion = str;
		str = GetXMLString("Credits", aNode);
		if (str != "") coreGame.AssistantCredits = str;
		
		if (coreGame.ServantName == "") {
			str = GetXMLString("Name", aNode);
			if (str != "") coreGame.ServantName = UpdateMacros(str);
			str = GetXMLString("Name1", aNode);
			if (str != "") coreGame.ServantName1 = UpdateMacros(str);
			str = GetXMLString("Name2", aNode);
			if (str != "") coreGame.ServantName2 = UpdateMacros(str);
		}
		
		coreGame.AssistantRape = GetXMLBoolean("AssistantRape", aNode, coreGame.AssistantRape);
		coreGame.AssistantTentacleSex = GetXMLBoolean("AssistantTentacleSex", aNode, coreGame.AssistantTentacleSex);
		coreGame.AssistantFurryNeeded = GetXMLBoolean("AssistantFurryNeeded", aNode, coreGame.AssistantFurryNeeded);
		coreGame.AssistantVanilla = GetXMLBoolean("Vanilla", aNode, coreGame.AssistantVanilla);
		
		str = GetXMLString("AssistantMaster", aNode);
		if (str != "") coreGame.ServantMaster = str;
		
		str = GetXMLString("Pronoun", aNode);
		if (str != "") coreGame.ServantPronoun = str;
	
		var iNode:XMLNode = GetNodeC(aNode, "Speech");
		if (iNode != null) {
			str = GetXMLString("Pronoun", iNode);
			if (str != "") coreGame.ServantPronoun = str;
			
			iNode = GetNode(iNode, "Suffix");
			if (iNode != null) {
				var chance:Number = 100;
				for (var attr:String in iNode.attributes) {
					if (attr == "chance") chance = aNode.attributes[attr];
				}
				coreGame.AssistantData.AddSpeechSuffix(chance, iNode.firstChild.nodeValue);
			}
		}
	}

	
	// Common (slave, assistant, event etc)
	
	public function StartGameCommonXML(sNode:XMLNode)
	{
		var oet:String = EventText;
		// General initialisation (allow for british/american spelling
		if (!XMLEventByNode(GetNode(sNode, "StartGame"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		} else if (XMLEventByNode(GetNode(sNode, "StartGame"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		}
	}	
	
	public function ApplyJobDetails(eNode:XMLNode)
	{
		var jobname:String;
		var joblabel:String;
		var bshow:Boolean = false;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": jobname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": joblabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
			}
		}
		if (jobname == undefined) return;
		var bNewAct:Boolean = !slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		//SMTRACE("Adding Job: " + eNode.nodeName + " show: " + bshow + " new: " + bNewAct);
		var actno:Number = coreGame.AddCustomJob(jobname, joblabel, eNode);
		var acti:ActInfo = slaveData.ActInfoBase.GetActRO(actno);
		if (bNewAct && bshow != undefined) ShowAct(actno, bshow);
	}
	
	public function ApplyChoreDetails(eNode:XMLNode)
	{
		var cname:String;
		var clabel:String;
		var bshow:Boolean = false;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": cname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": clabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
			}
		}
		if (cname == undefined) return;
		var bNewAct:Boolean = !slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		var actno:Number = coreGame.AddCustomChore(cname, clabel, eNode);
		if (bNewAct && bshow != undefined) ShowAct(actno, bshow);
	}
	
	public function ApplySchoolDetails(eNode:XMLNode)
	{
		var cname:String;
		var clabel:String;
		var bshow:Boolean = undefined;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": cname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": clabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
			}
		}
		if (cname == undefined) return;
		var bNewAct:Boolean = !slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		var actno:Number = coreGame.AddCustomSchool(cname, clabel, eNode);
		if (bNewAct && bshow != undefined) ShowAct(actno, bshow);
	}
	
	public function ApplySexDetails(sex:Number, eNode:XMLNode)
	{
		//SMTRACE("ApplySexDetails: " + sex + " " + eNode);
		var sdesc:String;
		var clabel:String;
		var cname:String;
		var bshow:Boolean = undefined;
		var minp:Number = undefined;
		var maxp:Number = undefined;
		var type:Number = 5;
		var partners:String = "any";
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": cname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": clabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
				case "min": minp = eNode.attributes[attr].toLowerCase() == "solo" ? 0 : Number(eNode.attributes[attr]); break;
				case "max": maxp = eNode.attributes[attr].toLowerCase() == "unlimited" ? 0 : Number(eNode.attributes[attr]); break;
				case "extreme": type = eNode.attributes[attr].toLowerCase() == "true" ? 6 : 5; break;
				case "partners": partners = eNode.attributes[attr].toLowerCase(); break;
			}
		}
		if (clabel == undefined) return;
		var bNewAct:Boolean = !slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		var actno:Number;
		if (type == 5) actno = coreGame.AddCustomSexNormal(cname, clabel, eNode, minp, maxp, partners);
		else actno = coreGame.AddCustomSexExtreme(cname, clabel, eNode, minp, maxp, partners);
		if (bNewAct && bshow != undefined) ShowAct(actno, bshow);
	}
	
	public function ApplyTalkToSlaves(eNode:XMLNode)
	{
		var sdesc:String;
		var clabel:String;
		var bshow:Boolean = undefined;
		var cname:String;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": cname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": clabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
			}
		}
		if (clabel == undefined) return;
		//SMTRACE("Add " + cname + " " + clabel);
		var bNewAct:Boolean = !slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		var actno:Number = coreGame.AddCustomTalkToSlave(cname, clabel, eNode);
		if (bNewAct && bshow != undefined) ShowAct(actno, bshow);
	}
	
	public function ApplyOrderSlaves(eNode:XMLNode)
	{
		//trace("ApplyOrderSlaves");
		var sdesc:String;
		var clabel:String;
		var bshow:Boolean = undefined;
		var cname:String;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": cname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": clabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
			}
		}
		if (clabel == undefined) return;
		//SMTRACE("Add " + cname + " " + clabel);
		var actno:Number = coreGame.AddCustomOrderSlave(cname, clabel, eNode);
		if (bshow == true) ShowAct(actno);
	}
	
	public function ApplySMCustomTraining(eNode:XMLNode)
	{
		var trname:String;
		var trlabel:String;
		var bshow:Boolean = false;
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": trname = eNode.attributes[attr]; break;
				case "desc":
				case "description":
				case "label": trlabel = eNode.attributes[attr]; break;
				case "show": bshow = ParseConditionalString(eNode.attributes[attr], true, false); break;
			}
		}
		if (trname == undefined) return;
		var bNewAct:Boolean = !slaveData.ActInfoBase.IsActDefinedByName(eNode.nodeName);
		//SMTRACE("Adding Custom SM Training: " + eNode.nodeName + " show: " + bshow + " new: " + bNewAct);
		var actno:Number = coreGame.modulesList.trainSlaveMaker.AddSMCustomTraining(trname, trlabel, eNode);
		var acti:ActInfo = slaveData.ActInfoBase.GetActRO(actno);
		if (bNewAct && bshow != undefined) ShowAct(actno, bshow);
	}

	
	public function InitialiseActs(iNode:XMLNode)
	{
		var bsNode:XMLNode = iNode;
		var nl:String;
		
		for (; bsNode != null; bsNode = bsNode.nextSibling) {
			if (bsNode.nodeType != 1) continue;
			nl = bsNode.nodeName.toLowerCase();
			if (nl.substr(0, 8) == "slavesex") ApplySexDetails(Number(nl.substr(8)), bsNode);
			else if (nl.substr(0, 8) == "slavejob") ApplyJobDetails(bsNode);
			else if (nl.substr(0, 10) == "slavechore") ApplyChoreDetails(bsNode);
			else if (nl.substr(0, 11) == "slaveschool") ApplySchoolDetails(bsNode);
			else if (nl.substr(0, 15) == "slavecustomtalk") ApplyTalkToSlaves(bsNode);
			else if (nl.substr(0, 16) == "slavecustomorder") ApplyOrderSlaves(bsNode);
			else if (nl.substr(0, 16) == "smcustomtraining") ApplySMCustomTraining(bsNode);
			else if (nl.substr(0, 12) == "slavecontest" || nl.substr(0, 13) == "customcontest") coreGame.Contests.ApplyContests(bsNode);
		}
	}
		
	public function InitialiseCommonXML(sNode:XMLNode, minor:Boolean)
	{	
		slaveData = coreGame.slaveData;
		
		// slaves can vary number of tentale abductions
		var str:String = GetXMLString("MaxTentacleHarem", sNode);
		if (str != "") coreGame.MaxTentacleHarem = FixNumber(str);
			
		// Custom Acts
		// limited allowed versions for minor slaves
		// plannings
		InitialiseActs(GetNodeC(sNode, "Planning/DoPlanning"));
		// contests
		InitialiseActs(GetNodeC(sNode, "Contests"));
		
		if (minor != true) {
			// Slave/Assistant
			coreGame.SetNocturnal(GetXMLBoolean("Nocturnal", sNode, coreGame.IsNocturnal()));

			InitialiseActs(sNode);
			InitialiseActs(GetNodeC(sNode, "Planning/Acts/DoPlanning"));
			InitialiseActs(GetNodeC(coreGame.Language.actNode, "DoPlanning"));
			InitialiseActs(coreGame.Language.actNode);
			InitialiseActs(evtNode);
				
			var iNode:XMLNode = GetNode(sNode, "SpecialParticipants");
			for (var pNode:XMLNode = iNode.firstChild; pNode != null; pNode = pNode.nextSibling) {
				if (pNode.nodeType != 1) continue;
				if (pNode.nodeName.toLowerCase() == "participant") ParseAddParticipant(pNode, pNode.firstChild);
			}
		
			// Custom House
			coreGame.HouseEvents.AddAllCustomHouses(coreGame.Language.walkNode);
			coreGame.HouseEvents.AddAllCustomHouses(evtNode);
		}
				
		// General slave initialisation (allow for british/american spelling
		var oet:String = EventText;
		if (XMLEventByNode(GetNode(sNode, "Initialise"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		} else if (XMLEventByNode(GetNode(sNode, "Initialize"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		} else if (XMLEventByNode(GetNode(sNode, "Events/Initialise"), true, undefined, true)) {
			// ignore any text output
			EventText = "";
		} else if (XMLEventByNode(GetNode(sNode, "Events/Initialize"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		}
		
		if (minor == true) return;
		
		if (XMLEventByNode(GetNode(evtNode, "Initialise"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		} else if (XMLEventByNode(GetNode(evtNode, "Initialize"), true, undefined, true)) {
			// ignore any text output
			EventText = oet;
		}	
	}
	
	// XML

	public function ParseAddParticipant(aNode:XMLNode, statNode:XMLNode)
	{
		var atype:String = aNode.nodeName.toLowerCase();
		var enable:Boolean = true;
		var owned:Boolean = false;
			
		var nm:String = "";
		if (statNode != undefined) nm = GetXMLString("Name", statNode);
		
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "enable") enable = aNode.attributes[attr].toLowerCase() == "true";
			else if (attr.toLowerCase() == "name") nm = aNode.attributes[attr];
			else if (attr.toLowerCase() == "owned") owned = aNode.attributes[attr].toLowerCase() == "true";
		}
		if (nm == "") return;
	
		if (statNode == undefined) {
			statNode = aNode.firstChild;
			if (GetXMLString("Name", statNode) == "") statNode = GetSlaveXML(nm);
		}
		
		var img:String = "";
		if (statNode != null) img = GetXMLString("Image", statNode);
		var sdata:Slave = null;
		if (img != "") sdata = SMData.GetSlaveDetailsFromImageName(img);
		if (sdata == null) sdata = SMData.GetSlaveDetails(nm, true);
		if (sdata == null) {
			trace("ADD SLAVE: (ParseAddParticipant) - " + nm);
			sdata = new Slave(coreGame);
			sdata.SlaveName = nm;
			sdata.SlaveIndex = SMData.SlavesArray.length;
			StartGameSlaveXML(statNode, sdata);
			SMData.SlavesArray.push(sdata);
			trace("..added " + sdata.SlaveName + " " + sdata.ImageFolder);
		} else {
			if (sdata.SlaveType == -2 || sdata.SlaveType == -20) coreGame.SpecialIndex = sdata.SlaveIndex;
			if (atype == "participant") {
				// loading a game, do not alter enabled, owner
				enable = sdata.SlaveType == -20;
				owned = sdata.SlaveType == 0;
			}
		}
		sdata.sNode = statNode;
		if (statNode != null) sdata.SlaveImage = img;
		if (owned) {
			sdata.SlaveType = 0;
			sdata.Available = true;
			coreGame.SpecialIndex = sdata.SlaveIndex;
		} else {
			sdata.SlaveType = enable == true ? -20 : -2;
			if (enable == true) {
				sdata.Available = true;
				coreGame.SpecialIndex = sdata.SlaveIndex;
			} else sdata.Available = false;
		}
		var iNode:XMLNode = GetNode(statNode, "Images");
		if (iNode != null) {
			trace("..loading images " + sdata.SlaveName + " " + sdata.ImageFolder);
			sdata.LoadActImages(statNode);
		}
	}
	
	public function ParseStatSkill(str:String, aNode:XMLNode) : Boolean
	{
		var per:Number;
		if (str == "altersexuality") {
			per = ParsePersonDetails(aNode);
			if (per == -100) continue;
			SMData.GetSlaveByIndex(per).AlterSexuality(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changebustsize") {
			per = ParsePersonDetails(aNode);
			if (per == -100) SMData.ChangeBustSize(GetExpression(aNode.firstChild.nodeValue));
			else if (per == -50) coreGame.ChangeBustSize(GetExpression(aNode.firstChild.nodeValue));
			else coreGame.ChangeBustSize(GetExpression(aNode.firstChild.nodeValue), SMData.GetSlaveByIndex(per));
			return true;
		}
		if (str == "changewaistsize") {
			per = ParsePersonDetails(aNode);
			if (per == -100) {
				SMData.vitalsWaistSM = SMData.vitalsWaistSM * GetExpression(aNode.firstChild.nodeValue);
				coreGame.UpdateSlaveMaker();
			} else {
				var sd:Object = SMData.GetSlaveByIndex(per);
				sd.vitalsWaist = sd.vitalsWaist * GetExpression(aNode.firstChild.nodeValue);
				if (sd.IsDisplayed()) coreGame.dspMain.UpdateSlaveVitals(sd);
			}
			return true;
		}
		if (str == "changehipssize") {
			per = ParsePersonDetails(aNode);
			if (per == -100) {
				SMData.vitalsHipsSM = SMData.vitalsHipsSM * GetExpression(aNode.firstChild.nodeValue);
				coreGame.UpdateSlaveMaker();
			} else {
				var sd:Object = SMData.GetSlaveByIndex(per);
				sd.vitalsHips = sd.vitalsHips * GetExpression(aNode.firstChild.nodeValue);
				if (sd.IsDisplayed()) coreGame.dspMain.UpdateSlaveVitals(sd);
			}
			return true;
		}
		if (str == "changeheight") {
			per = ParsePersonDetails(aNode);
			if (per == -100) {
				SMData.vitalsHeightsSM = SMData.vitalsHeightsSM * GetExpression(aNode.firstChild.nodeValue);
				coreGame.UpdateSlaveMaker();
			} else {
				var sd:Object = SMData.GetSlaveByIndex(per);
				sd.vitalsHeight = sd.vitalsHeight * GetExpression(aNode.firstChild.nodeValue);
				if (sd.IsDisplayed()) coreGame.dspMain.UpdateSlaveVitals(sd);
			}
			return true;
		}		
		if (str == "changeclitcocksize") {
			per = ParsePersonDetails(aNode);
			if (per == -100) SMData.ChangeClitCockSize(GetExpression(aNode.firstChild.nodeValue));
			else if (per == -50) coreGame.ChangeClitCockSize(GetExpression(aNode.firstChild.nodeValue));
			else coreGame.ChangeClitCockSize(GetExpression(aNode.firstChild.nodeValue), SMData.GetSlaveByIndex(per));
			return true;
		}
	
		if (str == "renamestatistic") {
			var stat:String = aNode.attributes.stat.toLowerCase();
			if (stat != "" && stat != undefined) return false;
			coreGame.RenameStatistic(stat, coreGame.Language.strTrim(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changecombat") {
			per = ParsePersonDetails(aNode);
			if (per == -100) SMData.TrainWeapon();
			else SMData.GetSlaveByIndex(per).ChangeCombat(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changeswimming") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeSwimming(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changecourtesan") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeCourtesan(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changefairyxf" || str == "changefaeriexf") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeFairyXF(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "setfairyxf" || str == "setfaeriexf") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).SetFairyXF(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changeseduction") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeSeduction(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changesinging") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeSinging(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changedancing") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeDancing(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changecattraining") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeCatTraining(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changepuppytraining") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangePuppyTraining(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}	
		if (str == "changeponytraining") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangePonyTraining(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changemilkeffects") {
			var lact:Number = undefined;
			var bf:Number = undefined;
			var md:Number = undefined;
			var bu:Number = undefined;
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "lactation") lact = GetExpression(aNode.attributes[attr]);
				else if (attr.toLowerCase() == "breastfixation") bf = GetExpression(aNode.attributes[attr]);
				else if (attr.toLowerCase() == "milkinfluence") md = GetExpression(aNode.attributes[attr]);
				else if (attr.toLowerCase() == "milkbuildup") bu = GetExpression(aNode.attributes[attr]);
			}
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeMilkEffects(lact, bf, md, bu);
			return true;
		}
		if (str == "changepath") {
			var sl:Array = aNode.firstChild.nodeValue.split(",");
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangePath(GetExpression(sl[0]), GetExpression(sl[1]),GetExpression(sl[2]));
			return true;
		}
		if (str == "updatecurrentpath") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).UpdateCurrentPath();
			return true;
		}
	
		if (str == "showspecialstat") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ShowSpecialStat(aNode.firstChild.nodeValue);
			return true;
		}
		if (str == "changespecial") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeSpecial(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "hidespecialstat") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).HideSpecialStat();
			return true;
		}
		if (str == "showspecial2stat") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ShowSpecial2Stat(aNode.firstChild.nodeValue);
			return true;
		}
		if (str == "changespecial2") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeSpecial2(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "hidespecial2stat") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).HideSpecial2Stat();
			return true;
		}
		if (str == "changecumslut") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeCumslut(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changesexualenergy") {
			per = ParsePersonDetails(aNode);
			if (per == -50) coreGame.ChangeSexualEnergy(GetExpression(aNode.firstChild.nodeValue));
			else if (per == -100) SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GetExpression(aNode.firstChild.nodeValue));
			else SMData.GetSlaveByIndex(per).ChangeSexualEnergy(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "startsuccubustraining") {
			per = ParsePersonDetails(aNode);
			if (per == -50) coreGame.modulesList.GetTraining("SuccubusTraining").StartTraining(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "changesuccubustraining") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).ChangeSuccubusTraining(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "completesuccubustraining") {
			per = ParsePersonDetails(aNode);
			SMData.GetSlaveByIndex(per).CompleteSuccubusTraining(GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "nobleloveevent") {
			var allow:Boolean = false;
			if (aNode.attributes.allowoffer != undefined) allow = aNode.attributes.allowoffer.toLowerCase() == "true";
			coreGame.NobleLoveEvent(GetExpression(aNode.firstChild.nodeValue), allow);
			return true;
		}
		if (str == "changemaxstats") {
			ParseMaxStats(aNode);
			return true;
		}
		if (str == "changeminstats") {
			ParseMinStats(aNode);
			return true;
		}
		if (str == "trainlesbiantrainer") {
			coreGame.modulesList.trainLesbians.SlaveMakerTraining();
			return true;
		}
		if (str == "traincatgirltrainer") {
			coreGame.modulesList.Catgirls.SlaveMakerTraining();
			return true;
		}		
		if (str == "trainponytrainer") {
			coreGame.modulesList.trainPonies.SlaveMakerTraining();
			return true;
		}
		if (str == "starttrainponytrainer") {
			coreGame.modulesList.trainPonies.StartSlaveMakerTraining();
			return true;
		}			
		return false;
	}
	
	// Slave XML
	
	public function AddSlaveEvents(sNode:XMLNode, owned:Boolean)
	{
		if (sNode == flNode) return;
		
		// Events for the slave
		var eNode:XMLNode;
		if (sNode != slaveNode) {
			var cty:String = coreGame.currentCity.GetName();
			if (owned == false || (owned == undefined && !coreGame.SMData.IsSlaveOwned(sNode))) {
				eNode = GetNode(sNode, "Unowned");
				if (eNode != null) MergeXML(eNode.attributes.atroot.toLowerCase() == "true" ? flNode.parentNode : GetNode("Events"), eNode, undefined, undefined, undefined, undefined, true);
				eNode = GetNode(sNode, "Unowned" + cty);
				if (eNode != null) MergeXML(eNode.attributes.atroot.toLowerCase() == "true" ? flNode.parentNode : GetNode("Events"), eNode, undefined, undefined, undefined, undefined, true);
				
				// Planning overloads, append by default
				eNode = GetNode(sNode, "Planning/UnownedAdditions");
				if (eNode != null) MergeXML(GetNode("Planning/Acts/DoPlanning"), eNode, undefined, undefined, undefined, undefined, false, true);
				
			} else {
				eNode = GetNode(sNode, "Events");
				if (eNode == null) eNode = GetNode(sNode, "Owned");
				if (eNode != null) MergeXML(eNode.attributes.atroot.toLowerCase() == "true" ? flNode.parentNode : GetNode("Events"), eNode, undefined, undefined, undefined, undefined, true);
				eNode = GetNode(sNode, "Owned" + cty);
				if (eNode != null) MergeXML(eNode.attributes.atroot.toLowerCase() == "true" ? flNode.parentNode : GetNode("Events"), eNode, undefined, undefined, undefined, undefined, true);
				
				// Planning overloads, append by default
				eNode = GetNode(sNode, "Planning/Additions");
				if (eNode != null) MergeXML(GetNode("Planning/Acts/DoPlanning"), eNode, undefined, undefined, undefined, undefined, false, true);
			}
		}		
	}


	//reference	
	private function ShowAct(type:Object, showact:Boolean) { slaveData.ActInfoBase.GetActRO(type).ShowAct(showact); }

}
