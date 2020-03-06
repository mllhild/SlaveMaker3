import Scripts.Classes.*;

// SlaveStatistics - class defining the statistics for a slave

class SlaveStatistics extends SlaveSkills {

	// Gender details
	public var SlaveGender:Number;			// their gender
	public var GenderIdentity:Number;		// the gender they identidy with
	public var SlaveGenderBorn:Number;		// gender at birth
	public var OldSlaveGender:Number;		// original gender at start of training
	
	public var DickgirlXF:Number;

	// statistics
	public var ClitCockSize:Number;
	public var ClitCockSizeStart:Number;
	public var vitalsBust:Number;
	public var vitalsBustStart:Number;
	public var vitalsWaist:Number;
	public var vitalsHips:Number;
	public var vitalsAge:Number;
	public var vitalsBloodType:String;
	public var vitalsDescription:String;
	public var vitalsWeight:Number;
	public var vitalsHeight:Number;
	
	public var Birthday:Number;				// the date of birth, can be negative to represent dates before 1252/1

	public var VarCharisma:Number;
	public var VarSensibility:Number;
	public var VarIntelligence:Number;
	public var VarRefinement:Number;
	public var VarMorality:Number;
	public var VarConstitution:Number;
	public var VarCooking:Number;
	public var VarCleaning:Number;
	public var VarConversation:Number;
	public var VarBlowJob:Number;
	public var VarFuck:Number;
	public var VarTemperament:Number;
	public var VarNymphomania:Number;
	public var VarObedience:Number;
	public var VarLibido:Number;
	public var VarReputation:Number;
	public var FatigueBonus:Number;
	public var VarFatigue:Number;
	public var VarJoy:Number;
	public var VarSpecial:Number;
	public var VarSpecial2:Number;
	public var VarLovePoints:Number;
	public var VarCunnilingus:Number;
	public var VarLesbianFuck:Number;
	public var VarSexualEnergy:Number;

	public var ShowSpecial:Number;
	public var SpecialName:String;
	public var ShowSpecial2:Number;
	public var Special2Name:String;

	public var Deficiency:Number;
	public var NaturalTalent:Number;

	public var MaxCharisma:Number;
	public var MaxRefinement:Number;
	public var MaxSensibility:Number;
	public var MaxIntelligence:Number;
	public var MaxMorality:Number;
	public var MaxConstitution:Number;
	public var MaxCooking:Number;
	public var MaxCleaning:Number;
	public var MaxConversation:Number;
	public var MaxFuck:Number;
	public var MaxBlowJob:Number;
	public var MaxTemperament:Number;
	public var MaxNymphomania:Number;
	public var MaxObedience:Number;
	public var MaxLibido:Number;
	public var MaxJoy:Number;
	public var MaxLove:Number;
	public var MaxSpecial:Number;
	public var MaxSpecial2:Number;
	public var MinLibido:Number;
	public var MinNymphomania:Number;

	public var VarCharismaMod:Number;
	public var VarSensibilityMod:Number;
	public var VarRefinementMod:Number;
	public var VarIntelligenceMod:Number;
	public var VarMoralityMod:Number;
	public var VarConstitutionMod:Number;
	public var VarCookingMod:Number;
	public var VarCleaningMod:Number;
	public var VarConversationMod:Number;
	public var VarBlowJobMod:Number;
	public var VarFuckMod:Number;
	public var VarTemperamentMod:Number;
	public var VarNymphomaniaMod:Number;
	public var VarObedienceMod:Number;
	public var VarLibidoMod:Number;
	public var VarReputationMod:Number;
	public var VarJoyMod:Number;
	public var VarSpecialMod:Number;
	public var VarSpecial2Mod:Number;
	public var VarSexualEnergyMod:Number;

	public var MilkInfluence:Number;
	public var Lactation:Number;
	public var BreastFixation:Number;
	public var MilkBuildUp:Number;
	
	public var OldMorality:Number;
	public var OldObedience:Number;
	public var OldIntelligence:Number;
	public var OldVarTemperament:Number;
	
	public var Slutiness:Number;
	public var Loyalty:Number;
	
	public var DickgirlRate:Number;
	
	public var Sexuality:Number;
	public var StartSexuality:Number;

	
	// Methods

	// Constructor
	public function SlaveStatistics(cg:Object) {
		super(cg);

		this.Reset();
	}
	// Initialise all variables for the slave
	public function Reset() {
		
		super.Reset();
		
		SlaveGender = 2;
		GenderIdentity = SlaveGender;
		SlaveGenderBorn = 0;
		OldSlaveGender = 0;
		DickgirlXF = 0;
		
		MaxJoy = coreGame.MaxStat;
		MaxCharisma = MaxJoy;
		MaxRefinement = MaxJoy;
		MaxSensibility = MaxJoy;
		MaxIntelligence = MaxJoy;
		MaxMorality = MaxJoy;
		MaxConstitution = MaxJoy;
		MaxCooking = MaxJoy;
		MaxCleaning = MaxJoy;
		MaxConversation = MaxJoy;
		MaxFuck = MaxJoy;
		MaxBlowJob = MaxJoy;
		MaxTemperament = MaxJoy;
		MaxNymphomania = MaxJoy;
		MaxObedience = MaxJoy;
		MaxLibido = 100;
		MaxLove = 100;

		MaxSpecial = 100;
		MaxSpecial2 = 100;
		
		Birthday = 0;
		ssSetGirlsVitals("Slave girl in training", 90, 54, 85, 18, "O", 158, 49, 0);
		vitalsBustStart = 90;
		
		MinLibido = 0;
		MinNymphomania = 0;

		VarCharismaMod = 0;
		VarSensibilityMod = 0;
		VarRefinementMod = 0;
		VarIntelligenceMod = 0;
		VarMoralityMod = 0;
		VarConstitutionMod = 0;
		VarCookingMod = 0;
		VarCleaningMod = 0;
		VarConversationMod = 0;
		VarBlowJobMod = 0;
		VarFuckMod = 0;
		VarTemperamentMod = 0;
		VarNymphomaniaMod = 0;
		VarObedienceMod = 0;
		VarLibidoMod = 0;
		VarReputationMod = 0;
		VarJoyMod = 0;
		VarSpecialMod = 0;
		VarSpecial2Mod = 0;
		VarSexualEnergyMod = 0;

		MilkInfluence = 0;
		Lactation = 0;
		BreastFixation = 0;
		MilkBuildUp = 0;
		
		VarCharisma = 0;
		VarSensibility = 0;
		VarRefinement = 0;
		VarIntelligence = 0;
		VarMorality = 0;
		VarConstitution = 0;
		VarCooking = 0;
		VarCleaning = 0;
		VarConversation = 0;
		VarBlowJob = 0;
		VarFuck = 0;
		VarTemperament = 0;
		VarNymphomania = 0;
		VarObedience = 0;
		VarLibido = 0;
		VarReputation = 0;
		VarFatigue = 0;
		VarJoy = 0;
		VarSpecial = 0;
		VarSpecial2 = 0;
		VarLovePoints = 0;
		FatigueBonus = 0;
		Deficiency = 0;
		NaturalTalent = 0;
		VarSexualEnergy = 0;
		VarCunnilingus = 0;
		VarLesbianFuck = 0;
		
		ShowSpecial = 0;
		SpecialName = "";
		ShowSpecial2 = 0;
		Special2Name = "";

		OldMorality = 0;
		OldObedience = 0;
		OldIntelligence = 0;
		OldVarTemperament = 0;
		
		Loyalty = 6;
		Slutiness = 1;
		
		DickgirlRate = 0;
		
		Sexuality = coreGame.config.nDefaultSexuality;
		StartSexuality = Sexuality;
	}
	
	// Stat updaters
	/*
	ChangeMinStats(Nymphomania, Lust);
	<ChangeMinStats>Nymphomania, Lust</ChangeMinStats>
	*/
	public function ChangeMinStats(Nymphomania:Number, Lust:Number)
	{	
		if (!isNaN(Lust)) MinLibido += Lust;
		if (!isNaN(Nymphomania)) MinNymphomania += Nymphomania;
		
		LimitAllStats();
	}
	
	public static function CapMax(max:Number, diff:Number, amax:Number, maxme:Number) : Number
	{
		if (!isNaN(diff) && !isNaN(max) && max != -1) {
			var nOld:Number = max;
			var lim:Number = maxme == undefined ? _root.MaxStat : maxme;
			if (lim < amax) lim = amax;
			max += diff;
			if (nOld <= lim && max > lim) return lim;
		}
		return max;
	}
	
	/*
	ChangeMaxStats(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Joy, Love, Special);
	<ChangeMaxStats>Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Joy, Love, Special</ChangeMaxStats>
	*/
	public function ChangeMaxStats(nCharisma:Number, nSensibility:Number, nRefinement:Number, nIntelligence:Number, nMorality:Number, nConstitution:Number, nCooking:Number, nCleaning:Number, nConversation:Number, nBlowJob:Number, nFuck:Number, nTemperament:Number, nNymphomania:Number, nObedience:Number, nLust:Number, nJoy:Number, nSpecial:Number, nSpecial2:Number, nLove:Number)
	{	
		var MaxStat:Number = GetMaxPossibleStat();
		MaxCharisma = CapMax(MaxCharisma, nCharisma, coreGame.AssistantMaxCharisma, MaxStat);
		MaxSensibility = CapMax(MaxSensibility, nSensibility, coreGame.AssistantMaxSensibility, MaxStat);
		MaxRefinement = CapMax(MaxRefinement, nRefinement, coreGame.AssistantMaxRefinement, MaxStat);
		MaxIntelligence = CapMax(MaxIntelligence, nIntelligence, coreGame.AssistantMaxIntelligence, MaxStat);
		MaxMorality = CapMax(MaxMorality, nMorality, coreGame.AssistantMaxMorality, MaxStat);
		MaxConstitution = CapMax(MaxConstitution, nConstitution, coreGame.AssistantMaxConstitution, MaxStat);
		MaxCooking = CapMax(MaxCooking, nCooking, coreGame.AssistantMaxCooking, MaxStat);
		MaxCleaning = CapMax(MaxCleaning, nCleaning, coreGame.AssistantMaxCleaning, MaxStat);
		MaxConversation = CapMax(MaxConversation, nConversation, coreGame.AssistantMaxConversation, MaxStat);
		MaxBlowJob = CapMax(MaxBlowJob, nBlowJob, coreGame.AssistantMaxBlowJob, MaxStat);
		MaxFuck = CapMax(MaxFuck, nFuck, coreGame.AssistantMaxFuck, MaxStat);
		MaxTemperament = CapMax(MaxTemperament, nTemperament, coreGame.AssistantMaxTemperament, MaxStat);
		MaxNymphomania = CapMax(MaxNymphomania, nNymphomania, coreGame.AssistantMaxNymphomania, MaxStat);
		MaxObedience = CapMax(MaxObedience, nObedience, coreGame.AssistantMaxObedience, MaxStat);
		MaxLibido = CapMax(MaxLibido, nLust, coreGame.AssistantMaxLibido, MaxStat);
		MaxJoy = CapMax(MaxJoy, nJoy, coreGame.AssistantMaxJoy, MaxStat);
		MaxSpecial = CapMax(MaxSpecial, nSpecial, 100);
		MaxSpecial2 = CapMax(MaxSpecial2, nSpecial2, 100);
		MaxLove = CapMax(MaxLove, nLove, 100);
		
		LimitAllStats();
	}
	
	/*
	Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
	<Points>Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy</Points>
	*/
	public function Points(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number, SexualEnergy:Number)
	{	
		LimitMaxMinStats();
		coreGame.UpdateFactors(this, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special, Special2, SexualEnergy);
		
		if (Fatigue > 0) {
			if (FatigueBonus > 0) {
				var fact:Number = FatigueBonus;
				if (fact > 150) fact = 150;
				Fatigue = Fatigue / (1 + (fact / 150));
			}
			if (IsDressEasy()) Fatigue *= 0.75;
		}
		
		// Gender effects
		var lestr:Boolean = BitFlagC.CheckBitFlag(10);	
		var sameg:Boolean = (SlaveGender == 1 && (coreGame.SMData.Gender == 1 || coreGame.SMData.Gender == 4));
		if (coreGame.DickgirlLesbians) {
			if (SlaveGender == 2 && (coreGame.SMData.Gender != 1 && coreGame.SMData.Gender != 4)) sameg = true;
		} else {
			if (coreGame.SMData.Gender == 2 && (SlaveGender != 1 && SlaveGender != 4)) sameg = true;
			else if (coreGame.SMData.Gender == 3 && (SlaveGender != 3 && SlaveGender != 6)) sameg = true;
		}
		if (sameg) {
			if (lestr) Love *= 0.7;
			else Love *= 0.5;
		} else if (coreGame.SMData.SMAdvantages.CheckBitFlag(20)) Love *= 0.5;
		
		// Talent/House/Advantages/Events Effects	
		if (coreGame.SMData.SMAdvantages.CheckBitFlag(2)) Refinement *= 0.8;
		if (coreGame.SMData.SMSpecialEvent == 5 || coreGame.SMData.SMSpecialEvent == 7) Morality *= 0.6;
		if (coreGame.SMData.SMAdvantages.CheckBitFlag(9)) Love *= 0.75;
		switch (coreGame.Home.HouseType) {
			case 4:
				Cooking *= 0.8;
				Cleaning *= 0.8;
				Love *= 1.2;
				break;
		}
		if (coreGame.SMData.SMAdvantages.CheckBitFlag(21) && coreGame.SMData.Corruption < 1) Morality *= 1.1;
		
		// Skill Effects
		if (coreGame.SMData.sLeadership > 0) Love *= (1 + (coreGame.SMData.sLeadership * 0.1));
		
		Charisma *= coreGame.CharismaFactor;
		Sensibility *= coreGame.SensibilityFactor;
		Refinement *= coreGame.RefinementFactor;
		Intelligence *= coreGame.IntelligenceFactor;
		Constitution *= coreGame.ConstitutionFactor;
		Morality *= coreGame.MoralityFactor;
		Cooking *= coreGame.CookingFactor;
		Cleaning *= coreGame.CleaningFactor;
		Conversation *= coreGame.ConversationFactor;
		BlowJob *= coreGame.BlowjobFactor;
		Fuck *= coreGame.FuckFactor;
		Temperament *= coreGame.TemperamentFactor;
		Nymphomania *= coreGame.NymphomaniaFactor;
		Obedience *= coreGame.ObedienceFactor;
		Lust *= coreGame.LibidoFactor;
		Reputation *= coreGame.dmod;
		Fatigue *= coreGame.FatigueFactor;
		Joy *= coreGame.JoyFactor;
		Love *= coreGame.dmod;
		if (!isNaN(Special)) Special *= coreGame.SpecialFactor;
		if (!isNaN(Special2)) Special2 *= coreGame.Special2Factor;
		
		if (IsDisplayed()) ShowStatIcons(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Special, Special2, SexualEnergy);
		
		VarCharisma += Charisma;
		VarSensibility += Sensibility;
		VarRefinement += Refinement;
		VarIntelligence += Intelligence;
		VarMorality += Morality;
		VarConstitution += Constitution;
		VarCooking += Cooking;
		VarCleaning += Cleaning;
		VarConversation += Conversation;
		if (lestr) {
			VarCunnilingus += BlowJob;
			VarLesbianFuck += Fuck;
		} else {
			VarBlowJob += BlowJob;
			VarFuck += Fuck;
		}
		VarTemperament += Temperament;
		VarNymphomania += Nymphomania;
		VarObedience += Obedience;
		VarLibido += Lust;
		VarReputation += Reputation;
		VarFatigue += Fatigue;
		VarJoy += Joy;
		VarLovePoints += Love;
		if (!isNaN(Special)) VarSpecial += Special;
		if (!isNaN(Special2)) VarSpecial2 += Special2;
	
		coreGame.UpdateSlave(this);
	}
	
	/*
	PointsMod(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Joy, Special, Special, SexualEnergy);
	<StatEffects>Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Joy, Special, Special, SexualEnergy</StatEffects>
	*/
	public function PointsMod(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Joy:Number, Special:Number, Special2:Number, SexualEnergy:Number) {
		
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
		
		if (IsDisplayed()) {
			ShowStatIcons(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, 0, Joy, Special, Special2, SexualEnergy);
			coreGame.UpdateSlave(this);
		}
	}
	
	public function UpdateSlaveCommon()
	{
		coreGame.OtherSlaveShown = SlaveType != -10;
		LimitAllStats();
		coreGame.dspMain.UpdateSlaveGender(this);
		coreGame.dspMain.UpdateOtherSlaveDetailsCommon(this);
	}
	
	public function ssSetGirlsVitals(desc:String, bust:Number, waist:Number, hips:Number, age:Number, bloodtype:String, tall:Number, weight:Number, clitcock:Number, birthday:Number)
	{
		if (bust != undefined) vitalsBust = bust;
		if (waist != undefined) vitalsWaist = waist;
		if (hips != undefined) vitalsHips = hips;
		if (age != undefined) vitalsAge = age;
		if (bloodtype != undefined) vitalsBloodType = bloodtype;
		if (desc != undefined) vitalsDescription = desc;
		if (weight != undefined) vitalsWeight = weight;
		if (tall != undefined) vitalsHeight = tall;
		if (clitcock != undefined) {
			ClitCockSize = clitcock;
			ClitCockSizeStart = clitcock;
		}
		if (birthday != 0 && birthday != undefined && birthday != -7200) Birthday = birthday;
		else if ((Birthday == 0 || Birthday == -7200) && age != undefined) Birthday = coreGame.GameDate - (vitalsAge * 400) - slrandom(300);  // 400 days per year, plus small random factor
	}

	public function SetBustSize(bust:Number) {
		if (bust == undefined) return;
		
		vitalsBust = bust;
		var max:Number = coreGame.config.GetValue("CommonDefaults/Measurements/Bust");
		if (max > 0 && vitalsBust > max) vitalsBust = max;

		if (IsDisplayed()) coreGame.UpdateSlave(this);
	}
	public function ChangeBustSize(val:Number) {
		if (val != undefined) SetBustSize(vitalsBust * val);
	}
	public function SetClitCockSize(clitcock:Number) {
		if (clitcock == undefined) return;
		
		ClitCockSize = clitcock;
		var max:Number = coreGame.config.GetValue("CommonDefaults/Measurements/ClitCock");
		if (max > 0 && ClitCockSize > max) ClitCockSize = max;

		if (IsDisplayed()) coreGame.UpdateSlave(this);
	}
	public function ChangeClitCockSize(val:Number) {
		if (val != undefined) SetClitCockSize(ClitCockSize * val);
	}
	
	public function SetMilkEffects(lact:Number,bf:Number,md:Number,bu:Number) {
		if (lact != undefined) this.Lactation = lact;
		if (bf != undefined) this.BreastFixation = bf;
		if (md != undefined) this.MilkInfluence = md;
		if (bu != undefined) this.MilkBuildUp = bu;
	}
	public function ChangeMilkEffects(lact:Number,bf:Number,md:Number,bu:Number) {
		if (lact == undefined) lact = 0;
		if (bf == undefined) bf = 0;
		if (md == undefined) md = 0;
		if (bu == undefined) bu = 0;

		this.SetMilkEffects(this.Lactation + lact,this.BreastFixation + bf,this.MilkInfluence > 0 ? this.MilkInfluence + md:this.MilkInfluence,this.MilkBuildUp + bu);
	}
	
	public function InitialiseMaxObedience(maxo:Number) : Number
	{
		MaxObedience = Math.ceil(maxo * (1 + ((coreGame.StatRate - 1) / 2)));
		return MaxObedience;
	}
		
	// Special Stats
	public function ChangeSpecial(special:Number) {	Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,special);	}
	public function SetSpecialStat(slabel:String) {
		if (slabel != undefined) SpecialName = slabel;
	}
	public function ShowSpecialStat(slabel:String) {
		ShowSpecial = 1;
		if (slabel != undefined) SpecialName = slabel;
	}
	public function HideSpecialStat() {	ShowSpecial = 0; }
	public function ChangeSpecial2(special:Number) { Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,special); }
	public function SetSpecial2Stat(slabel:String) {
		if (slabel != undefined) Special2Name = slabel;
	}
	public function ShowSpecial2Stat(slabel:String) {
		ShowSpecial2 = 1;
		if (slabel != undefined) Special2Name = slabel;
	}
	public function HideSpecial2Stat() { ShowSpecial2 = 0; }
	
	// blood type
	private function BloodTypeToNumber(bloodtype:String) : Number
	{
		switch (bloodtype.toUpperCase())
		{
			case "A": return 0;
			case "B": return 1;
			case "AB": return 2;
			case "O": return 3;
		}
		return -1;
	}
	
	public function GetBloodFactor() : Number
	{
		var slaveBF:Number = BloodTypeToNumber(vitalsBloodType);
		var smBF:Number = BloodTypeToNumber(coreGame.SMData.vitalsBloodTypeSM);
		var assBF:Number = BloodTypeToNumber(coreGame.AssistantData.vitalsBloodType);
		
		var masterAff:Number = smBF == -1 || slaveBF == -1 ? 0 : coreGame.MasterAffinity[smBF][slaveBF];
		var assAff:Number = assBF == -1 || slaveBF == -1 ? 0 : coreGame.AssistantAffinity[assBF][slaveBF];
		return (masterAff + assAff) / 100 + 1;
	}
		
	// Copy data from/to this object
	// sdFrom and sdTo can be Object types (for load/save cases(
	public function CopyCommonDetails(sdFrom:Object, sdTo:Object) {
		if (sdTo == undefined) sdTo = this;
		
		super.CopyCommonDetails(sdFrom, sdTo);

		coreGame.SetGirlsVitals(sdFrom.SlaveName,sdFrom.vitalsDescription,sdFrom.vitalsBust,sdFrom.vitalsWaist,sdFrom.vitalsHips,sdFrom.vitalsAge,sdFrom.vitalsBloodType,sdFrom.vitalsHeight,sdFrom.vitalsWeight,sdFrom.ClitCockSize, sdFrom.BirthDay, sdTo);
		sdTo.vitalsBustStart = sdFrom.vitalsBustStart;
		sdTo.ClitCockSizeStart = sdFrom.ClitCockSizeStart;

		sdTo.VarCharisma = sdFrom.VarCharisma;
		sdTo.VarSensibility = sdFrom.VarSensibility;
		sdTo.VarRefinement = sdFrom.VarRefinement;
		sdTo.VarIntelligence = sdFrom.VarIntelligence;
		sdTo.VarMorality = sdFrom.VarMorality;
		sdTo.VarConstitution = sdFrom.VarConstitution;
		sdTo.VarCooking = sdFrom.VarCooking;
		sdTo.VarCleaning = sdFrom.VarCleaning;
		sdTo.VarConversation = sdFrom.VarConversation;
		sdTo.VarBlowJob = sdFrom.VarBlowJob;
		sdTo.VarFuck = sdFrom.VarFuck;
		sdTo.VarCunnilingus = sdFrom.VarCunnilingus;
		sdTo.VarLesbianFuck = sdFrom.VarLesbianFuck;
		sdTo.VarTemperament = sdFrom.VarTemperament;
		sdTo.VarNymphomania = sdFrom.VarNymphomania;
		sdTo.VarObedience = sdFrom.VarObedience;
		sdTo.VarReputation = sdFrom.VarReputation;
		sdTo.VarFatigue = sdFrom.VarFatigue;
		sdTo.VarLibido = sdFrom.VarLibido;
		sdTo.VarJoy = sdFrom.VarJoy;
		sdTo.VarSpecial = sdFrom.VarSpecial;
		sdTo.VarSpecial2 = sdFrom.VarSpecial2;
		sdTo.VarSexualEnergy = sdFrom.VarSexualEnergy;

		sdTo.VarCharismaMod = sdFrom.VarCharismaMod;
		sdTo.VarSensibilityMod = sdFrom.VarSensibilityMod;
		sdTo.VarRefinementMod = sdFrom.VarRefinementMod;
		sdTo.VarIntelligenceMod = sdFrom.VarIntelligenceMod;
		sdTo.VarMoralityMod = sdFrom.VarMoralityMod;
		sdTo.VarConstitutionMod = sdFrom.VarConstitutionMod;
		sdTo.VarCookingMod = sdFrom.VarCookingMod;
		sdTo.VarCleaningMod = sdFrom.VarCleaningMod;
		sdTo.VarConversationMod = sdFrom.VarConversationMod;
		sdTo.VarBlowJobMod = sdFrom.VarBlowJobMod;
		sdTo.VarFuckMod = sdFrom.VarFuckMod;
		sdTo.VarTemperamentMod = sdFrom.VarTemperamentMod;
		sdTo.VarNymphomaniaMod = sdFrom.VarNymphomaniaMod;
		sdTo.VarObedienceMod = sdFrom.VarObedienceMod;
		sdTo.VarReputationMod = sdFrom.VarReputationMod;
		sdTo.VarLibidoMod = sdFrom.VarLibidoMod;
		sdTo.VarJoyMod = sdFrom.VarJoyMod;
		sdTo.VarSpecialMod = sdFrom.VarSpecialMod;
		sdTo.VarSpecial2Mod = sdFrom.VarSpecial2Mod;
		sdTo.VarSexualEnergyMod = sdFrom.VarSexualEnergyMod;
		sdTo.VarLovePoints = sdFrom.VarLovePoints;
		
		sdTo.ShowSpecial = sdFrom.ShowSpecial;
		sdTo.ShowSpecial2 = sdFrom.ShowSpecial2;
		sdTo.SpecialName = sdFrom.SpecialName;
		sdTo.Special2Name = sdFrom.Special2Name;
		
		sdTo.Deficiency = sdFrom.Deficiency;
		sdTo.NaturalTalent = sdFrom.NaturalTalent;

		sdTo.MaxCharisma = sdFrom.MaxCharisma;
		sdTo.MaxSensibility = sdFrom.MaxSensibility;
		sdTo.MaxRefinement = sdFrom.MaxRefinement;
		sdTo.MaxIntelligence = sdFrom.MaxIntelligence;
		sdTo.MaxMorality = sdFrom.MaxMorality;
		sdTo.MaxConstitution = sdFrom.MaxConstitution;
		sdTo.MaxCooking = sdFrom.MaxCooking;
		sdTo.MaxCleaning = sdFrom.MaxCleaning;
		sdTo.MaxConversation = sdFrom.MaxConversation;
		sdTo.MaxFuck = sdFrom.MaxFuck;
		sdTo.MaxBlowJob = sdFrom.MaxBlowJob;
		sdTo.MaxTemperament = sdFrom.MaxTemperament;
		sdTo.MaxNymphomania = sdFrom.MaxNymphomania;
		sdTo.MaxObedience = sdFrom.MaxObedience;
		sdTo.MaxLibido = sdFrom.MaxLibido;
		sdTo.MaxJoy = sdFrom.MaxJoy;
		sdTo.MaxLove = sdFrom.MaxLove;
		sdTo.MaxSpecial = sdFrom.MaxSpecial;
		sdTo.MaxSpecial2 = sdFrom.MaxSpecial2;
		sdTo.MinLibido = sdFrom.MinLibido;
		sdTo.MinNymphomania = sdFrom.MinNymphomania;
		
		sdTo.FatigueBonus = sdFrom.FatigueBonus;

		sdTo.MilkInfluence = sdFrom.MilkInfluence;
		sdTo.Lactation = sdFrom.Lactation;
		sdTo.BreastFixation = sdFrom.BreastFixation;
		sdTo.MilkBuildUp = sdFrom.MilkBuildUp;

		sdTo.OldMorality = sdFrom.OldMorality;
		sdTo.OldObedience = sdFrom.OldObedience;
		sdTo.OldIntelligence = sdFrom.OldIntelligence;
		sdTo.OldVarTemperament = sdFrom.OldVarTemperament;
		
		sdTo.Slutiness = sdFrom.Slutiness;
		sdTo.Loyalty = sdFrom.Loyalty;
		
		sdTo.DickgirlRate = sdFrom.DickgirlRate;
		sdTo.DickgirlXF = sdFrom.DickgirlXF;
		
		sdTo.Sexuality = sdFrom.Sexuality;
		sdTo.StartSexuality = sdFrom.StartSexuality;
		
		// fix special stats
		if (sdTo.SpecialName == "None") {
			sdTo.ShowSpecial = 0;
			sdTo.SpecialName = "";
		}
		if (sdTo.Special2Name == "None") {
			sdTo.ShowSpecial2 = 0;
			sdTo.Special2Name = "";
		}
	}
	
	public function ShowStatIcons(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Special:Number, Special2:Number, SexualEnergy:Number) {
	
		var lestr:Boolean = !IsMale() && BitFlagC.CheckBitFlag(10);
		var MaxStat:Number = GetMaxPossibleStat();
		
		if (VarCharisma < MaxStat && Charisma>0) IconValue(coreGame.StatisticsGroup.Charisma, Charisma);
		if (VarRefinement  < MaxStat && Refinement>0) IconValue(coreGame.StatisticsGroup.Refinement, Refinement);
		if (VarSensibility < MaxStat && Sensibility>0) IconValue(coreGame.StatisticsGroup.Sensibility, Sensibility);
		if (VarIntelligence < MaxStat && Intelligence>0) IconValue(coreGame.StatisticsGroup.Intelligence, Intelligence);
		if (VarMorality < MaxStat && Morality>0) IconValue(coreGame.StatisticsGroup.Morality, Morality);
		if (VarConstitution < MaxStat && Constitution>0) IconValue(coreGame.StatisticsGroup.Constitution, Constitution);
		if (VarCooking < MaxStat && Cooking>0) IconValue(coreGame.StatisticsGroup.Cooking, Cooking);
		if (VarCleaning < MaxStat && Cleaning>0) IconValue(coreGame.StatisticsGroup.Cleaning, Cleaning);
		if (VarConversation < MaxStat && Conversation>0) IconValue(coreGame.StatisticsGroup.Conversation, Conversation);
		if (lestr) {
			var maxlesbian:Number = coreGame.currLesbianTrainer * 100;
			if (VarCunnilingus < maxlesbian && BlowJob>0) IconValue(coreGame.StatisticsGroup.Blowjobs, BlowJob);
			if (VarLesbianFuck < maxlesbian && Fuck>0) IconValue(coreGame.StatisticsGroup.Fucking, Fuck);
			if (VarCunnilingus > 0 && BlowJob<0) IconValue(coreGame.StatisticsGroup.BlowJobs, BlowJob);
			if (VarLesbianFuck > 0 && Fuck<0) IconValue(coreGame.StatisticsGroup.Fucking, Fuck);
		} else {
			if (VarBlowJob > 0 && BlowJob<0) IconValue(coreGame.StatisticsGroup.Blowjobs, BlowJob);
			if (VarFuck > 0 && Fuck<0) IconValue(coreGame.StatisticsGroup.Fucking, Fuck);
			if (VarBlowJob < MaxBlowJob && BlowJob>0) IconValue(coreGame.StatisticsGroup.BlowJobs, BlowJob);
			if (VarFuck < MaxFuck && Fuck>0) IconValue(coreGame.StatisticsGroup.Fucking, Fuck);
		}
		if (VarTemperament < MaxStat && Temperament>0) IconValue(coreGame.StatisticsGroup.Temperament, Temperament);
		if (VarNymphomania < MaxStat && Nymphomania>0) IconValue(coreGame.StatisticsGroup.Nymphomania, Nymphomania);
		if (VarObedience < MaxStat && Obedience>0) IconValue(coreGame.StatisticsGroup.Obedience, Obedience); 
		if (VarLibido < MaxStat && Lust>0) IconValue(coreGame.StatisticsGroup.Lust, Lust);
		if (VarReputation < MaxStat && Reputation>0) IconValue(coreGame.StatisticsGroup.Reputation, Reputation);
		if (VarJoy < MaxStat && Joy>0) IconValue(coreGame.StatisticsGroup.Joy, Joy);
		if (VarFatigue < 100 && Fatigue>0) IconValue(coreGame.StatisticsGroup.Tiredness, Fatigue);
		if (Special != undefined && ShowSpecial == 1) if (VarSpecial < MaxSpecial && Special>0) IconValue(coreGame.StatisticsGroup.Special, Special);
		if (SexualEnergy != undefined && IsSuccubus()) if (VarSexualEnergy < 100 && SexualEnergy>0) IconValue(coreGame.StatisticsGroup.SexualEnergy, SexualEnergy);
	
		if (VarCharisma > 0 && Charisma<0) IconValue(coreGame.StatisticsGroup.Charisma, Charisma);
		if (VarRefinement  > 0 && Refinement<0) IconValue(coreGame.StatisticsGroup.Refinement, Refinement);  
		if (VarSensibility > 0 && Sensibility<0) IconValue(coreGame.StatisticsGroup.Sensibility, Sensibility); 
		if (VarIntelligence > 0 && Intelligence<0) IconValue(coreGame.StatisticsGroup.Intelligence, Intelligence);
		if (VarMorality > 0 && Morality<0) IconValue(coreGame.StatisticsGroup.Morality, Morality);
		if (VarConstitution > 0 && Constitution<0) IconValue(coreGame.StatisticsGroup.Constitution, Constitution);
		if (VarCooking > 0 && Cooking<0) IconValue(coreGame.StatisticsGroup.Cooking, Cooking);
		if (VarCleaning > 0 && Cleaning<0) IconValue(coreGame.StatisticsGroup.Cleaning, Cleaning);
		if (VarConversation > 0 && Conversation<0) IconValue(coreGame.StatisticsGroup.Conversation, Conversation);
		if (VarTemperament > 0 && Temperament<0) IconValue(coreGame.StatisticsGroup.Temperament, Temperament);
		if (VarNymphomania > 0 && Nymphomania<0) IconValue(coreGame.StatisticsGroup.Nymphomania, Nymphomania);
		if (VarObedience > 0 && Obedience<0) IconValue(coreGame.StatisticsGroup.Obedience, Obedience);
		if (VarLibido > 0 && Lust<0) IconValue(coreGame.StatisticsGroup.Lust, Lust);
		if (VarReputation > 0 && Reputation<0) IconValue(coreGame.StatisticsGroup.Reputation, Reputation);
		if (VarJoy > 0 && Joy<0) IconValue(coreGame.StatisticsGroup.Joy, Joy);
		if (VarFatigue > 0 && Fatigue<0) IconValue(coreGame.StatisticsGroup.Tiredness, Fatigue);
		if (Special != undefined && ShowSpecial == 1) if (VarSpecial > 0 && Special<0) IconValue(coreGame.StatisticsGroup.Special, Special);
		if (Special2 != undefined && ShowSpecial2 == 1) if (VarSpecial2 > 0 && Special2<0) IconValue(coreGame.StatisticsGroup.Special2, Special2);
		if (SexualEnergy != undefined && IsSuccubus()) if (VarSexualEnergy > 0 && SexualEnergy < 0) IconValue(coreGame.StatisticsGroup.SexualEnergy, SexualEnergy);
	}
	
	public static function GetDeficiencyTalent(str:String) : Number
	{
		switch(str.toLowerCase()) {
			case "charisma": return 1;
			case "sensibility": return 2;
			case "refinement": return 3;
			case "intelligence": return 4;
			case "morality": return 5;
			case "constitution": return 6;
			case "cooking": return 7;
			case "cleaning": return 8;
			case "conversation": return 9;
			case "blowjob":
			case "blowjobs": return 10;
			case "fuck":
			case "fucking": return 11;
			case "temperament": return 12;
			case "nymphomania": return 13;
			case "obedience": return 14;
			case "lust": return 15;
			case "fatigue":
			case "tiredness": return 16
			case "joy": return 17;
			case "reputation": return 18;
			case "special": return 19;
			case "sex": return 20;
			case "slut": return 21;
			case "sexualenergy": return 22;
			case "special2": return 23;
			case "love": return 24;
			case "sexuality": return 25;
		}
		return 0;
	}
	
	public function GetStatNameBase(stat:Number) : String
	{
		var lestr:Boolean = BitFlagC.CheckBitFlag(10);
		
		switch(stat) {
			case 0: return "Charisma";
			case 1: return "Sensibility";
			case 2: return "Refinement";
			case 3: return "Intelligence";
			case 4:
				if (coreGame.SMData.SMFaith == 2) return "Faith";
				else if (coreGame.SMData.SMFaith == 3) return "Ethics";
				return "Morality";
			case 5: return "Constitution";
			case 6: return "Cooking";
			case 7: return "Cleaning";
			case 8: return "Conversation";
			case 9:
				if (lestr) return "Cunnilingus";
				else return "Blowjobs";
			case 10:
				if (lestr) return "TribStrapOn";
				else return "Fucking";
			case 11: return "Temperament";
			case 12: return "Nymphomania";
			case 13: return "Obedience";
			case 14: return "Lust";
			case 15: return "Tiredness";
			case 16: return "Joy";
			case 17: return "Reputation"; 
			case 18: return "Special";
			case 22: return "Special2";
			case 23: return "Love";
		}
		return "";
	}
	
	public function GetMaxPossibleStat()
	{
		return IsSlaveFreePerson() ? 300 : coreGame.MaxStat;
	}
	
	// the slave's stat names, for use in generating descriptions
	public function GetStatName(id:Number) : String { return coreGame.Language.GetText(GetStatNameBase(id < 15 ? id : id + 1), "Statistics"); }
	
	public function FixMax(mxs:Number) : Number {
		if (mxs != -1) {
			if (mxs < 0) return 0;
			var maxme:Number = GetMaxPossibleStat();
			if (isNaN(mxs) || mxs > maxme) return maxme;
		}
		return mxs;
	}
		
	public function LimitMaxMinStats()
	{	
		var MaxStat:Number = GetMaxPossibleStat();
		
		MaxSensibility = FixMax(MaxSensibility);
		MaxRefinement = FixMax(MaxRefinement);
		MaxIntelligence = FixMax(MaxIntelligence);
		MaxMorality = FixMax(MaxMorality);
		MaxCooking = FixMax(MaxCooking);
		MaxCleaning = FixMax(MaxCleaning);
		MaxConversation = FixMax(MaxConversation);
		MaxObedience = FixMax(MaxObedience);
		MaxCharisma = FixMax(MaxCharisma);
		MaxNymphomania = FixMax(MaxNymphomania);
		if (MaxLove > 100) MaxLove = 100;
		if (MaxSpecial > 100) MaxSpecial = 100;
		else if (MaxSpecial < 0) MaxSpecial = 0;
		if (MaxSpecial2 > 100) MaxSpecial2 = 100;
		else if (MaxSpecial2 < 0) MaxSpecial2 = 0;
		if (MinLibido > MaxStat) MinLibido = MaxStat;
		if (MinLibido < 0) MinLibido = 0;
		if (MinNymphomania < 0) MinNymphomania = 0;

		if (FairyXF > 0) {
			var maxfairy:Number = 100;
			if (MaxStat == 200) maxfairy = 300;
			else if (MaxStat == 150) maxfairy = 200;
			else if (MaxStat == 100) maxfairy = 150;
			
			coreGame.AssistantMaxCharisma = MaxStat + (FairyXF > 100 ? 100 : FairyXF);
			if (coreGame.AssistantMaxCharisma > maxfairy) coreGame.AssistantMaxCharisma = maxfairy;
			if (coreGame.AssistantMaxCharisma > 300) MaxCharisma = 300;
			coreGame.AssistantMaxNymphomania = MaxStat + (FairyXF > 100 ? 50 : FairyXF * 0.5);
			if (NymphsTiaraWorn == 1) coreGame.AssistantMaxNymphomania += 50;
			if (MaxNymphomania > maxfairy) coreGame.AssistantMaxNymphomania = maxfairy;
		} 
		else {
			coreGame.AssistantMaxCharisma = MaxCharisma == -1 ? MaxStat : MaxCharisma;
			coreGame.AssistantMaxNymphomania = MaxNymphomania == -1 ? MaxStat : MaxNymphomania;
		}
		
		coreGame.AssistantMaxSensibility = MaxSensibility == -1 ? MaxStat : MaxSensibility;
		coreGame.AssistantMaxRefinement = MaxRefinement == -1 ? MaxStat : MaxRefinement;
		coreGame.AssistantMaxIntelligence = MaxIntelligence == -1 ? MaxStat : MaxIntelligence;
		coreGame.AssistantMaxMorality = MaxMorality == -1 ? MaxStat : MaxMorality;
		coreGame.AssistantMaxConstitution = MaxConstitution == -1 ? MaxStat : MaxConstitution;
		coreGame.AssistantMaxCooking = MaxCooking == -1 ? MaxStat : MaxCooking;
		coreGame.AssistantMaxCleaning = MaxCleaning == -1 ? MaxStat : MaxCleaning;
		coreGame.AssistantMaxConversation = MaxConversation == -1 ? MaxStat : MaxConversation;
		coreGame.AssistantMaxTemperament = MaxTemperament == -1 ? MaxStat : MaxTemperament;
		coreGame.AssistantMaxObedience = MaxObedience == -1 ? MaxStat : MaxObedience;
		coreGame.AssistantMaxLibido = MaxLibido == -1 ? MaxStat : MaxLibido;
		coreGame.AssistantMaxJoy = MaxJoy == -1 ? MaxStat : MaxJoy;
		
		var maxlesbianf:Number = MaxFuck == -1 ? MaxStat : MaxFuck;
		var maxlesbianb:Number = MaxBlowJob == -1 ? MaxStat : MaxBlowJob;
		if (BitFlagC.CheckBitFlag(10)) {
			var maxlesbian:Number = MaxStat;
			if (IsFemale()) maxlesbian = coreGame.currLesbianTrainer * 100;
			else maxlesbian = coreGame.currGayTrainer * 100;
			if (IsFemale() && coreGame.currLesbianTrainer >= 1) {
				maxlesbianf = maxlesbian;
				maxlesbianb = maxlesbian;
			} else if (IsMale() && coreGame.currGayTrainer >= 1) {
				maxlesbianf = maxlesbian;
				maxlesbianb = maxlesbian;
			}
		}
		coreGame.AssistantMaxFuck = maxlesbianf;
		coreGame.AssistantMaxBlowJob = maxlesbianb;
		
		coreGame.modulesList.LimitMaxMinStats();
	}
	
	public function LimitAllStats()
	{
		trace("LimitAllStats: " + IsFemale() + " " + IsPermanentDickgirl() + " " + IsMale());
		var MaxStat:Number = GetMaxPossibleStat();
	
		if (AddictionLevel<0) AddictionLevel = 0; 
		if (Loyalty < 0) Loyalty = 0;
	
		var lestr:Boolean = BitFlagC.CheckBitFlag(10);
		var lMinLibido:Number = MinLibido;
		var lMinNymphomania:Number = MinNymphomania;
			 
		if (DoreiEffecting == 0) {
			if (NymphsTiaraWorn == 1) {
				lMinNymphomania = 50;
				if (lMinLibido < 50) lMinLibido = 50;
				lMinNymphomania = 50; 
			} 
		} else {
			lMinNymphomania = 80;
			if (lMinLibido < 80) lMinLibido = 80;
		}
	
		if (IsPermanentDickgirl() || IsDickgirl()) {
			if (lMinLibido < 40) lMinLibido = 40;
			if (lMinNymphomania < 40) lMinNymphomania = 40;
		}
	
		if (Slutiness > 5) {
			if (lMinNymphomania < 50) lMinNymphomania = 50;
			if (lMinLibido < 30) lMinLibido = 30;
		}
		
		if (lMinLibido<0) lMinLibido = 0;
		if (lMinLibido > MaxStat) lMinLibido = MaxStat;
		if (lMinNymphomania<0) lMinNymphomania = 0;
		if (lMinNymphomania > MaxStat) lMinNymphomania = MaxStat;
	
		if (Math.ceil(VarLibido + VarLibidoMod) < lMinLibido) VarLibido = lMinLibido - VarLibidoMod;
		if (Math.ceil(VarNymphomania + VarNymphomaniaMod) < lMinNymphomania) VarNymphomania = lMinNymphomania - VarNymphomaniaMod;
		
		if (slPonyTraining > ((40 + (sPonyTrainer * 20)))) slPonyTraining = (40 + (sPonyTrainer * 20));
		if (slSlutTraining > 100) slSlutTraining = 100;
		if (slSwimming > 4) slSwimming = 4;
		if (slDancing > 4) slDancing = 4;
		if (slSinging > 4) slSinging = 4;
		if (slCombat > 100) slCombat = 100;
		if (slCourtesan > 100) slCourtesan = 100;
		
		LimitMaxMinStats();
		
		VarCharisma = LimitStat(VarCharisma, 0, coreGame.AssistantMaxCharisma);
		VarSensibility = LimitStat(VarSensibility, 0, coreGame.AssistantMaxSensibility);
		VarRefinement = LimitStat(VarRefinement, 0, coreGame.AssistantMaxRefinement);
		VarIntelligence = LimitStat(VarIntelligence, 0, coreGame.AssistantMaxIntelligence);
		VarMorality = LimitStat(VarMorality, 0, coreGame.AssistantMaxMorality);
		VarConstitution = LimitStat(VarConstitution, 0, coreGame.AssistantMaxConstitution);
		VarCooking = LimitStat(VarCooking, 0, coreGame.AssistantMaxCooking);
		VarCleaning = LimitStat(VarCleaning, 0, coreGame.AssistantMaxCleaning);
		VarConversation = LimitStat(VarConversation, 0, coreGame.AssistantMaxConversation);
		VarFuck = LimitStat(VarFuck, 0, coreGame.AssistantMaxFuck);
		VarBlowJob = LimitStat(VarBlowJob, 0, coreGame.AssistantMaxBlowJob);
		VarLesbianFuck = LimitStat(VarLesbianFuck, 0, coreGame.AssistantMaxFuck);
		VarCunnilingus = LimitStat(VarCunnilingus, 0, coreGame.AssistantMaxBlowJob);
		VarTemperament = LimitStat(VarTemperament, 0, coreGame.AssistantMaxTemperament);
		VarNymphomania = LimitStat(VarNymphomania, 0, coreGame.AssistantMaxNymphomania);
		VarObedience = LimitStat(VarObedience, 0, coreGame.AssistantMaxObedience);
		VarLibido = LimitStat(VarLibido, 0, coreGame.AssistantMaxLibido);
		VarReputation = LimitStat(VarReputation, 0, 100);
		VarFatigue = LimitStat(VarFatigue, 0, 100);
		VarJoy = LimitStat(VarJoy, 0, coreGame.AssistantMaxJoy);
		VarSpecial = LimitStat(VarSpecial, 0, MaxSpecial);
		VarSpecial2 = LimitStat(VarSpecial2, 0, MaxSpecial2);
		VarLovePoints = LimitStat(VarLovePoints, 0, MaxLove);
		VarSexualEnergy = LimitStat(VarSexualEnergy, 0, 100);
	
		if (DickgirlRate > 67) DickgirlRate = 67;
			
		// coregame references
		var chartemp:Number = VarCharisma;
		if (DurationHairCare > 0) chartemp += DurationHairCare;
		if (DurationFacialCare > 0) chartemp += DurationFacialCare;
		if (DurationMakeupCare > 0) chartemp += DurationMakeupCare;
		
		coreGame.VarMoralityRounded = Math.ceil(LimitStat(VarMorality, VarMoralityMod, coreGame.AssistantMaxMorality));
		coreGame.VarObedienceRounded = Math.ceil(LimitStat(VarObedience, VarObedienceMod, coreGame.AssistantMaxObedience));
	
		if (AngelsTearWorn == 1 && coreGame.VarMoralityRounded<50) VarMorality = 50 - VarMoralityMod;
		if (coreGame.VarMoralityRounded>50 && Slutiness > 5) VarMorality = 50 - VarMoralityMod;
		if (DemonicPendantWorn == 1 && coreGame.VarMoralityRounded>25) VarMorality = 25 - VarMoralityMod;
		if (Loyalty == 0 && coreGame.VarObedienceRounded < 5) VarObedience = 5 - VarObedienceMod;
		
		coreGame.VarFatigueRounded = Math.ceil(VarFatigue);
		var cr:Number = Math.ceil(LimitStat(VarConstitution, VarConstitutionMod, coreGame.AssistantMaxConstitution));
		if (FatigueBonus > cr) FatigueBonus = cr;
		if (FatigueBonus < 0) FatigueBonus = 0;
	
		coreGame.VarCharismaRounded = Math.ceil(LimitStat(chartemp, VarCharismaMod, coreGame.AssistantMaxCharisma));
		coreGame.VarSensibilityRounded = Math.ceil(LimitStat(VarSensibility, VarSensibilityMod, coreGame.AssistantMaxSensibility));
		coreGame.VarRefinementRounded = Math.ceil(LimitStat(VarRefinement, VarRefinementMod, coreGame.AssistantMaxRefinement));
		coreGame.VarIntelligenceRounded = Math.ceil(LimitStat(VarIntelligence, VarIntelligenceMod, coreGame.AssistantMaxIntelligence));
		coreGame.VarMoralityRounded = Math.ceil(LimitStat(VarMorality, VarMoralityMod, coreGame.AssistantMaxMorality));
		coreGame.VarConstitutionRounded = cr; //Math.ceil(LimitStat(VarConstitution, VarConstitutionMod, coreGame.AssistantMaxConstitution));
		coreGame.VarCookingRounded = Math.ceil(LimitStat(VarCooking, VarCookingMod, coreGame.AssistantMaxCooking));
		coreGame.VarCleaningRounded = Math.ceil(LimitStat(VarCleaning, VarCleaningMod, coreGame.AssistantMaxCleaning));
		coreGame.VarConversationRounded = Math.ceil(LimitStat(VarConversation, VarConversationMod, coreGame.AssistantMaxConversation));	
		coreGame.VarFuckRounded = Math.ceil(LimitStat(lestr ? VarLesbianFuck : VarFuck, VarFuckMod, coreGame.AssistantMaxFuck));
		coreGame.VarBlowJobRounded = Math.ceil(LimitStat(lestr ? VarCunnilingus : VarBlowJob, VarBlowJobMod, coreGame.AssistantMaxBlowJob));
		coreGame.VarTemperamentRounded = Math.ceil(LimitStat(VarTemperament, VarTemperamentMod, coreGame.AssistantMaxTemperament));
		coreGame.VarNymphomaniaRounded = Math.ceil(LimitStat(VarNymphomania, VarNymphomaniaMod, coreGame.AssistantMaxNymphomania));
		coreGame.VarObedienceRounded = Math.ceil(LimitStat(VarObedience, VarObedienceMod, coreGame.AssistantMaxObedience));
		coreGame.VarReputationRounded = Math.ceil(LimitStat(VarReputation, VarReputationMod, 100));
		coreGame.VarLibidoRounded = Math.ceil(LimitStat(VarLibido, VarLibidoMod, coreGame.AssistantMaxLibido));
		coreGame.VarJoyRounded = Math.ceil(LimitStat(VarJoy, VarJoyMod, coreGame.AssistantMaxJoy));
		coreGame.VarSpecialRounded = Math.ceil(LimitStat(VarSpecial, VarSpecialMod, 100));
		coreGame.VarSpecial2Rounded = Math.ceil(LimitStat(VarSpecial2, VarSpecial2Mod, 100));
		coreGame.VarSexualEnergyRounded = Math.ceil(LimitStat(VarSexualEnergy, VarSexualEnergyMod, 100));
		
		coreGame.FatigueBonusRounded = Math.ceil(LimitStat(FatigueBonus, 0, coreGame.VarConstitutionRounded));
		
		coreGame.Trust = VarObedience + VarLovePoints;
	}
	
	// Gender
	
	public function IsFemale() : Boolean { return SlaveGender != 0 && SlaveGender != 1 && SlaveGender != 4; }
	public function IsWoman() : Boolean { return SlaveGender == 2 || SlaveGender == 5; }
	public function IsMale() : Boolean { return SlaveGender == 1 || SlaveGender == 4; }	
	public function IsTwins() : Boolean { return SlaveGender > 3; }	

	public function ChangeSlaveGender(gnd:Number, noid:Boolean) {
		if (gnd != undefined) {
			DickgirlXF = 0;
			SlaveGender = gnd;
			if (noid != true) GenderIdentity = gnd;
			if (gnd == 3 || gnd == 6) {
				if (MinLibido < 40) MinLibido = 40;
				DickgirlXF = 2;
				if (IsDisplayed()) coreGame.Icons.ShowDickgirlIconNow();
			} else if (IsDisplayed()) coreGame.Icons.HideDickgirlIcon();
		}
		if (coreGame.AssistantData == this) {
			if (gnd != undefined) coreGame.ServantGender = gnd;
			coreGame.UpdateServantGenderText();
		} else if (SlaveType == -10) {
			if (gnd == 3 || gnd == 1 || gnd == 4 || gnd == 6) coreGame.UnEquipItem(15);
			if (gnd == 1 || gnd == 4) coreGame.UnEquipItem(6);
			coreGame.DickgirlXF = DickgirlXF;
			coreGame.SlaveGender = SlaveGender;
			coreGame.GenderIdentity = GenderIdentity;
			coreGame.MinLibido = MinLibido;
			coreGame.SetActButtonDetailsStartup();
			coreGame.UpdateSlaveGender();
			coreGame.UpdateSlave();
		}
	}
		
	// Dickgirl
	public function IsDickgirl() : Boolean {
		if (SlaveGender == 1 || SlaveGender == 4 || SlaveGender == 0) return false;
		return DickgirlXF > 0 || SlaveGender == 3 || SlaveGender == 6;// || IsPermanentDickgirl() inlined for efficiency
	}
	public function IsPermanentDickgirl() : Boolean {
		if (SlaveGender == 1 || SlaveGender == 4 || SlaveGender == 0) return false;
		return DickgirlXF > 0 || SlaveGender == 3 || SlaveGender == 6;
	}


}