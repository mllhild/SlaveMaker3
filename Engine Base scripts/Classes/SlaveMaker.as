// SlaveMaker - class defining your slave maker
// class heirarchy
// SlaveMaker				- base/basics variables/methods
//    ArmsArmour			- weapons armour
//       SlaveMakerSkills	- skills
//          DressCommon		- dresses
// Translation status: COMPLETE

import Scripts.Classes.*;

class SlaveMaker extends SlavesOwned {
	
	// Properties
	
	// Identity
	public var SlaveMakerName:String;
	public var Gender:Number;
	public var GenderIdentity:Number;
	public var OldGender:Number;
	public var Appearance:Number;
	
	// Statistics
	public var SMLust:Number;
	public var SMMinLust:Number;
	public var SMConstitution:Number;
	public var SMAttack:Number;
	public var SMDefence:Number;
	public var SMConversation:Number;
	public var SMReputation:Number;
	public var SMDominance:Number;
	public var ArousalDefence:Number;
	public var Corruption:Number;
	public var SMMinCorruption:Number;
	public var SMCharisma:Number;
	public var SMRefinement:Number;
	public var SMNymphomania:Number;
	public var SMTiredness:Number;
	public var SexualEnergy:Number;
	
	public var vitalsBustSM:Number;
	public var vitalsBustStartSM:Number;
	public var vitalsWaistSM:Number;
	public var vitalsHipsSM:Number;
	public var vitalsBloodTypeSM:String;
	public var vitalsWeightSM:Number;
	public var vitalsHeightSM:Number;
	public var ClitCockSizeSM:Number;
	public var ClitCockSizeStartSM:Number;
	
	// History
	
	// Home Town
	// 0 = Coutry Town
	// 1 = Old Faith Stronghold
	// 2 = Amazon Tribe
	// 3 = Mardukane
	// 4 = Caravan
	// 5 = Elven Forest
	// 6 = Dark Elven Capital
	// 7 = True Catgirl Tribe
	public var SMHomeTown:Number;
	
	// Special Event
	// 1 = Ex-Milk Slave
	// 2 = Tentacle Hybrid
	// 3 = Converted by Tentacles
	// 4 = Ex-Cowgirl
	// 5 = Demonic Cock
	// 6 = Inhuman Ancestry
	// 7 = Succubus
	// 8 = Demon
	public var SMSpecialEvent:Number;
	public var SpecialEventFlags:BitFlags;
	public var SpecialEventProgress:Number;	// OBSOLETE
	
	// Initial Items
	// 0 = Sex Items, all slaves
	// 1 = Ponygirl items, first slave
	// 2 = Ponygirl items, all slaves
	// 3 = catgirl items, first slave
	// 4 = catgirl items, all slaves
	// 5 = 1 dress
	// 6 = sword
	// 7 = leash
	// 8 = 300GP per slave
	// 9 = whip
	// 10 = leather armour
	// 11 = puppygirl items, first slave
	// 12 = puppygirl items, all slaves
	public var SMInitialItems:BitFlags;
	
	// Skills
	// 0 = Slave Trainer 2
	// 1 = Lesbian Trainer 1
	// 2 = Refined 1
	// 3 = Catgirl Trainer 1
	// 4 = Alchemy 1
	// 5 = Trader 1
	// 6 = Pony Trainer 1
	// 7 = Leadership 1
	// 8 = Slut Trainer 1
	// 9 = Gay Trainer 1
	// 10 = Puppy Trainer 1
	public var SMSkills:BitFlags;
	
	// Advantages
	// 0 = Minor Noble - ok
	// 1 = Noble - ok
	// 2 = Experienced Trader - ok
	// 3 = Weapon Master - ok
	// 4 = Sex Addict- ok
	// 5 = Wealthy - ok
	// 6 = Unnatural Cum - ok
	// 7 = Pagan/Witch - ok
	// 8 = Brothel Madam - ok
	// 9 = Cruel Dominatrix/Master - ok
	// 10 = Dominatrix/Master - ok
	// 11 = Pony Expert - ok
	// 12 = Catgirl
	// 13 = Vampire
	// 14 = Furry
	// 15 = Secret Old Faith Worshipper
	// 16 = Attractive to Tentacles
	// 17 = Blunt
	// 18 = Inept Warrior - ok
	// 19 = Fangs & Claws - ok
	// 20 = Chauvinist - ok
	// 21 = Holy - ok
	// 22 = Convincing - ok
	// 23 = Ex-brothel slave
	//      - -5 initial dominance
	//      - +5 minimum lust
	// 24 = Submissive
	//      - -5 initial dominance
	//      - Increased dominance penalty and decreased dominance gain.
	// 25 = Masochist
	//      + Can take more pain than most
	//      - Lusts increases when in pain 
	// 26 = Competitive
	// 27 = Exhibitionist
	// 28 = Mesmerism
	// 29 = reserved for 
	public var SMAdvantages:BitFlags;
	
	public var Talent:Number;			// OBSOLETE
	
	public var SMCustomPoints:Number;
	
	// Current Career
	public var GuildMember:Boolean;
	public var SMFaith:Number;  // 1 = new, 2 = old, 3 = none
	
	public var PonygirlAware:Number;
	public var SkillPoints:Number;

	public var BitFlagSM:BitFlags;

	// Wealth
	public var SMDebt:Number;
	public var SMGold:Number;
	public var SMGoldSpent:Number;
	
	// Possessions

	public var RopesOK:Number;
	public var SilkenRopesOK:Number;
	public var EggOK:Number;
	public var SMPiercingsType:Number;
	public var SMVanityCaseOK:Number;
	public var SMNippleRingsOK:Number;
	public var SMFeeldoOK:Boolean;
		
	public var PotionsOwned:Array;

	// books owned
	public var TotalBooks:Number;
	public var TotalPoetry:Number;

	public var OtherBooks:BitFlags;
		// bits
		// 0 = Ladies Guide
		// 1 = Historical Tales
		// 2 = Exu Kontono's Guide to Masculine Love. Volume 1
		// 3 = Exu Kontono's Guide to Masculine Love. Volume 2
		// 32+ = has been read by slave
	
	// Training and totals
	public var TheologyTraining:Number;

	public var TotalSMCourt:Number;
	public var TotalSMBar:Number;
	public var TotalSMSleazyBar:Number;
	public var TotalSMMartial:Number;
	public var TotalSMPray:Number;
	public var TotalSMJob:Number;
	public var TotalSMNun:Number;
	public var TotalSMCustom:Number;
	public var TotalSMSpecial:Number;
	public var TotalSMTalkSlaves:Number;
	
	// Diary
	public var Diary:TrainingLog;
	
	// Miscellaneous
	public var NumDealer:Number;
	
	// semi private, for game internal use
	public var arSMQualities:Array;
	public var arSMSkills:Array;
	public var clrScheme:ColourScheme;
	
	// OBSOLETE	
	public var TotalSMChildren:Number;
	public var SMTotalTentaclePregnancy:Number;
	
	private var SMHealth:Number;
	
	
	// Methods
	
	// Constructor
	public function SlaveMaker(cg:Object) { 
		super(cg);
		
		SMInitialItems = new BitFlags();
		SMSkills = new BitFlags();
		SMAdvantages = new BitFlags();
		
		if (coreGame.Difficulty == -1) SMCustomPoints = coreGame.config.GetValue("SlaveMakerDefaults/CustomPoints", 100) + 20;
		else if (coreGame.Difficulty == 0) SMCustomPoints = coreGame.config.GetValue("SlaveMakerDefaults/CustomPoints", 100);
		else if (coreGame.Difficulty == 1) SMCustomPoints = coreGame.config.GetValue("SlaveMakerDefaults/CustomPoints", 100) - 10;
		else SMCustomPoints = coreGame.config.GetValue("DefaultCustomPoints", 100) - 20;
		if (SMCustomPoints < 0) SMCustomPoints = 0;
		
		SMHomeTown = 0;
		SMSpecialEvent = -1;
			
		SMLust = 30;
		SMMinLust = 0;
		SMMinCorruption = 0;
		SMConstitution = 45;
		SMAttack = 40;
		SMDefence = 40;
		SMConversation = 30;
		SMReputation = 10;
		SMDominance = 65;
		SMCharisma = 50;
		SMNymphomania = 20;
		SMTiredness = 0;
		SMRefinement = 40;
		ArousalDefence = 1;
		SexualEnergy = 0;
		Corruption = 0;
		
		sSlaveTrainer = 1;
		
		Talent = -1;
		SpecialEventProgress = 0;
		SpecialEventFlags = new BitFlags();
		
		SMDebt = 0;
		SMGold = 0;
		SMGoldSpent = 0;
		
		RopesOK = 0;
		SilkenRopesOK = 0;
		EggOK = 0;
		SMPiercingsType = 0;
		SMVanityCaseOK = 0;
		SMNippleRingsOK = 0;
		TotalBooks = 0;
		TotalPoetry = 0;
		SMFeeldoOK = false;
	
		GuildMember = true;
		PonygirlAware = _root.PonygirlsOn ? 0 : -1;
	
		SkillPoints = 0;
		TheologyTraining = 0;

		BitFlagSM = new BitFlags();
		BitFlagC = BitFlagSM;
	
		TotalSMCourt = 0;
		TotalSMBar = 0;
		TotalSMSleazyBar = 0;
		TotalSMMartial = 0;
		TotalSMPray = 0;
		TotalSMJob = 0;
		TotalSMNun = 0;
		TotalSMCustom = 0;
		TotalSMSpecial = 0;
		TotalSMTalkSlaves = 0;
		
		NumDealer = 0;
		
		vitalsBustSM = 100;
		vitalsBustStartSM = 100;
		vitalsWaistSM = 90;
		vitalsHipsSM = 95;
		vitalsBloodTypeSM = coreGame.config.GetString("SlaveMakerDefaults/BloodType", "O");
		vitalsWeightSM = 65;
		vitalsHeightSM = 178;
		ClitCockSizeSM = coreGame.config.GetValue("SlaveMakerDefaults/Male/ClitCockSize", 0.6);
		ClitCockSizeStartSM = ClitCockSizeSM;
											
		OtherBooks = new BitFlags();
		
		SlaveMakerName = "Slaver";
		Gender = 1;
		GenderIdentity = 1;
		SMFaith = 1;
		Appearance = 1;
		OldGender = Gender;
		
		Diary = new TrainingLog(cg);
				
		PotionsOwned = new Array();
		
		DaysUnavailable = 0;
		
		arSMSkills = new Array();
		
		SetDressDetails(0, coreGame.Language.GetHtml("PlainDress", "Equipment"), coreGame.Language.GetHtml("NoEffects", "Equipment"), false, 0);
		SetDressOwned(0);
		SetDressDetails(1, "Courtly", "Unrestricted actions at Court", true, 400);
		SetDressDetails(2, "Party", "", true, 200);
		SetDressDetails(3, "BDSM", "", true, 200);
		SetDressDetails(4, "Holy", "", true, 200);
		SellBunnySuit = 0;
		SellMaidUniform = 0;

		PonygirlAware = coreGame.PonygirlsOn ? 0 : -1;
		
		var cookiesm:SharedObject = coreGame.GetSaveData("smlastusedslavemaker");
		if (cookiesm.data.SlaveMakerName != undefined) {
			SMFaith = cookiesm.data.SMFaith;
			SlaveMakerName = cookiesm.data.SlaveMakerName;
			Gender = cookiesm.data.Gender;
			GenderIdentity = Gender;
			Appearance = cookiesm.data.Appearance;
			if (Appearance == undefined) Appearance = 1;
		}
		OldGender = Gender;
		
		// OBSOLETE
		TotalSMChildren = 0;
		SMTotalTentaclePregnancy = 0;
	}
	
	// Load/Save
	public function Load(so:Object, strGameId:String)
	{
		coreGame.LoadSave.CleanSaveGame(so);
		CopySlaveMakerDetails(so, this);
		
		super.Load(so, strGameId);
		
		if (so.SMCustomPoints != undefined) SMCustomPoints = so.SMCustomPoints;

		Appearance = so.Appearance;
		SlaveMakerName = so.SlaveMakerName;
		Gender = so.Gender;
		
		GenderIdentity = so.GenderIdentity;
		OldGender = so.OldGender;
	
		Talent = so.Talent;
		if (so.TalentProgress != undefined) SpecialEventProgress = so.TalentProgress;
		else SpecialEventProgress = so.SpecialEventProgress;
		SMHomeTown = so.SMHomeTown;
		
		Corruption = so.Corruption;
		SMMinCorruption = so.SMMinCorruption;
		SMLust = so.SMLust;
		SMMinLust = so.SMMinLust;
		SMConstitution = so.SMConstitution;
		SMAttack = so.SMAttack;
		SMDefence = so.SMDefence;
		SMConversation = so.SMConversation;
		SMReputation = so.SMReputation;
		SMDominance = so.SMDominance;
		SMCharisma = so.SMCharisma;
		SMRefinement = so.SMRefinement;
		SMNymphomania = so.SMNymphomania;
		SMTiredness = so.SMTiredness;
		SexualEnergy = so.SexualEnergy;
				
		ArousalDefence = so.ArousalDefence;
		TheologyTraining = so.TheologyTraining;
		SMFaith = so.SMFaith;
		
		TotalSMBar = so.TotalSMBar;
		TotalSMSleazyBar = so.TotalSMSleazyBar;
		TotalSMMartial = so.TotalSMMartial;
		TotalSMPray = so.TotalSMPray;
		TotalSMJob = so.TotalSMJob;
		TotalSMNun = so.TotalSMNun;
		TotalSMCustom = so.TotalSMCustom;
		TotalSMSpecial = so.TotalSMSpecial;
		TotalSMTalkSlaves = so.TotalSMTalkSlaves;
		
		NumDealer = so.NumDealer;
		
		GuildMember = so.GuildMember;
			
		PonygirlAware = so.PonygirlAware;
		
		SMGold = so.SMGold;
		SMGoldSpent = so.SMGoldSpent;
		SMDebt = so.SMDebt;
		
		vitalsBustSM = so.vitalsBustSM;
		vitalsBustStartSM = so.vitalsBustStartSM;
		vitalsWaistSM = so.vitalsWaistSM;
		vitalsHipsSM = so.vitalsHipsSM;
		vitalsBloodTypeSM = so.vitalsBloodTypeSM;
		vitalsWeightSM = so.vitalsWeightSM;
		vitalsHeightSM = so.vitalsHeightSM;
		ClitCockSizeSM = so.ClitCockSizeSM;
		ClitCockSizeStartSM = so.ClitCockSizeStartSM;
		
		EggOK = so.EggOK;
		SMPiercingsType = so.SMPiercingsType;
		SMVanityCaseOK = so.SMVanityCaseOK;
		SMNippleRingsOK = so.SMNippleRingsOK;
		SilkenRopesOK = so.SilkenRopesOK;
		RopesOK = so.RopesOK;
		SMFeeldoOK = so.SMFeeldoOK;
		
		SkillPoints = so.SkillPoints;
		
		TotalSMCourt = so.TotalSMCourt;
		
		if (so.DressWorn != undefined) {
			DressWorn = so.DressWorn;
			NakedChoice = so.NakedChoice;
			DressToWear = so.DressToWear;
		}
		
		DaysUnavailable = so.DaysUnavailable;
				
		SpecialEventFlags.Load(so.SpecialEventFlags);
		SMSpecialEvent = so.SMSpecialEvent;
		SMInitialItems.Load(so.SMInitialItems);
		SMSkills.Load(so.SMSkills);
		SMAdvantages.Load(so.SMAdvantages);
		BitFlagSM.Load(so.BitFlagSM);
		
		TotalBooks = so.TotalBooks;
		TotalPoetry = so.TotalPoetry;
		OtherBooks.Load(so.OtherBooks);
		
		if (so.vSMSkills != undefined) {
			SMSpecialEvent = so.vSMSpecialEvent;
			SMInitialItems.Load(so.vSMInitialItems);
			SMSkills.Load(so.vSMSkills);
			SMAdvantages.Load(so.vSMAdvantages);
		}
		
		for (var i:Number = 0; i < so.PotionsOwned.length; i++) {
			var entry:Object = so.PotionsOwned[i];
			if (entry.Owned == undefined || isNaN(entry.Owned)) PotionsOwned.push(0);
			else PotionsOwned.push(entry.Owned);
		}
		if (so.PotionsOwned.length <= 14) {
			for (var i:Number = so.PotionsOwned.length; i < 14; i++) PotionsOwned.push(0);
		}
		for (var i:Number = 0; i < so.PotionsUsed.length; i++) {
			var entry:Object = so.PotionsUsed[i];
			if (entry.Used == undefined || isNaN(entry.Used)) PotionsUsed.push(0);
			else PotionsUsed.push(entry.Used);
		}
		if (so.PotionsUsed.length <= 14) {
			for (var i:Number = so.PotionsUsed.length; i < 14; i++) PotionsUsed.push(0);
		}
		
		//coreGame.SMTRACE("..load dresses");
		if (so.arDresses != undefined) {
			var len:Number= so.arDresses.length;
			if (len == undefined) len = 0;
			if (len != 0) {
				arDresses = new Array();
				for (var j:Number = 0; j < len; j++) {
					var dob:DressSlaveMaker = new DressSlaveMaker(this);
					dob.Load(so.arDresses[j]);
					arDresses.push(dob);
				}
			}
		}
		
		// trace("...load diary");
		{
			var cookiediary:SharedObject = coreGame.GetSaveData(strGameId + "diary");
			Diary.Load(cookiediary.data.Diary);
		}
		
		// OBSOLETE
		SMTotalTentaclePregnancy = so.SMTotalTentaclePregnancy;
		TotalSMChildren = so.TotalSMChildren;

		// Upgrades
		if (DateImpregnated == undefined) {
			if (PregnancyGestation > 0) {
				DateImpregnated = coreGame.GameDate - PregnancyGestation;
				BitFlagSM.SetBitFlag(95);		// to prevent all pregnant slaves being announced on upgrade
			} else DateImpregnated = 0;
		}
		if (SMAdvantages.CheckBitFlag(13) || IsVampire()) {
			coreGame.SetNocturnal(true);
			SMAdvantages.SetBitFlag(28)
		}
		coreGame.LoadSave.UpgradeSlaveMakerSave(so, this);

		CopySlaveMakerDetails(this, _root);
	}
	
	public function Save(so:Object, strGameId:String) : Boolean
	{		
		if (super.Save(so, strGameId)) return true;
		
		so.SMCustomPoints = SMCustomPoints;
		
		so.Appearance = Appearance;
		
		so.SlaveMakerName = SlaveMakerName;
		so.Gender = Gender;
		so.GenderIdentity = GenderIdentity;
		so.OldGender = OldGender;
		
		so.Talent = Talent;
		so.SpecialEventProgress = SpecialEventProgress;
		
		so.SMHomeTown = SMHomeTown;
		so.SMSpecialEvent = SMSpecialEvent;
				
		so.Corruption = Corruption;
		so.SMMinCorruption = SMMinCorruption;
		so.ArousalDefence = ArousalDefence;
		so.SMLust = SMLust;
		so.SMMinLust = SMMinLust;
		so.SMConstitution = SMConstitution;
		so.SMAttack = SMAttack;
		so.SMDefence = SMDefence;
		so.SMConversation = SMConversation;
		so.SMReputation = SMReputation;
		so.SMCharisma = SMCharisma;
		so.SMRefinement = SMRefinement;
		so.SMNymphomania = SMNymphomania;
		so.SMTiredness = SMTiredness;
		so.SMDominance = SMDominance;
		so.SexualEnergy = SexualEnergy;
	
		so.SMDebt = SMDebt;
		so.TheologyTraining = TheologyTraining;
		so.SMFaith = SMFaith;
		so.GuildMember = GuildMember;
			
		so.TotalSMBar = TotalSMBar;
		so.TotalSMSleazyBar = TotalSMSleazyBar;
		so.TotalSMMartial = TotalSMMartial;
		so.TotalSMPray = TotalSMPray;
		so.TotalSMJob = TotalSMJob;
		so.TotalSMNun = TotalSMNun;
		so.TotalSMCustom = TotalSMCustom;
		so.TotalSMSpecial = TotalSMSpecial;
		so.TotalSMTalkSlaves = TotalSMTalkSlaves;
		
		so.NumDealer = NumDealer;
				
		so.PonygirlAware = PonygirlAware;
		so.SMGold = SMGold;
		so.SMGoldSpent = SMGoldSpent;
		
		so.vitalsBustSM = vitalsBustSM;
		so.vitalsBustStartSM = vitalsBustStartSM;
		so.vitalsWaistSM = vitalsWaistSM;
		so.vitalsHipsSM = vitalsHipsSM;
		so.vitalsBloodTypeSM = vitalsBloodTypeSM;
		so.vitalsWeightSM = vitalsWeightSM;
		so.vitalsHeightSM = vitalsHeightSM;
		so.ClitCockSizeSM = ClitCockSizeSM;
		so.ClitCockSizeStartSM = ClitCockSizeStartSM;
		
		so.EggOK = EggOK;
		so.SMPiercingsType = SMPiercingsType;
		so.SMVanityCaseOK = SMVanityCaseOK;
		so.SMNippleRingsOK = SMNippleRingsOK;
		so.SilkenRopesOK = SilkenRopesOK;
		so.RopesOK = RopesOK;
		so.SMFeeldoOK = SMFeeldoOK;
		so.TotalBooks = TotalBooks;
		so.TotalPoetry = TotalPoetry;

		so.SkillPoints = SkillPoints;
		
		so.TotalSMCourt = TotalSMCourt;
		
		so.DressWorn = DressWorn;
		so.NakedChoice = NakedChoice;
		so.DressToWear = DressToWear;
		
		so.DaysUnavailable = DaysUnavailable;
				
		delete so.SpecialEventFlags;
		so.SpecialEventFlags = new Object();
		SpecialEventFlags.Save(so.SpecialEventFlags);
		
		delete so.SMInitialItems;
		so.SMInitialItems = new Object();
		SMInitialItems.Save(so.SMInitialItems);
		delete so.SMSkills;
		so.SMSkills = new Object();
		SMSkills.Save(so.SMSkills);
		delete so.SMAdvantages;
		so.SMAdvantages = new Object();
		SMAdvantages.Save(so.SMAdvantages);
		
		delete so.BitFlagSM;
		so.BitFlagSM = new Object();
		BitFlagSM.Save(so.BitFlagSM);
		
		delete so.OtherBooks;
		so.OtherBooks = new BitFlags();
		OtherBooks.Save(so.OtherBooks);
		
		delete so.PotionsOwned;
		so.PotionsOwned = new Array();
		var len:Number = PotionsOwned.length;
		for (var i:Number = 0; i < len; i++) {
			var newentry:Object = new Object();
			newentry.Owned = PotionsOwned[i];
			so.PotionsOwned.push(newentry);
		}
		delete so.PotionsUsed;
		so.PotionsUsed = new Array();
		len = PotionsUsed.length;
		for (var i:Number = 0; i < len; i++) {
			var newentry:Object = new Object();
			newentry.Used = PotionsUsed[i];
			so.PotionsUsed.push(newentry);
		}
		
		delete so.arDresses;
		if (arDresses != null) {
			len = arDresses.length;
			if (len == undefined) len = 0;
			if (len != 0) {
				so.arDresses = new Array();
				for (var j:Number = 0; j < len; j++) {
					var dob:Object = new Object();
					var ds:DressSlaveMaker = arDresses[j]
					ds.Save(dob);
					so.arDresses.push(dob);
				}
			}
		}
		
		so.SMTotalTentaclePregnancy = SMTotalTentaclePregnancy;
		so.TotalSMChildren = TotalSMChildren;
				
		if (strGameId != "") {
			var cookiediary:SharedObject = coreGame.GetSaveData(strGameId + "diary");
			delete cookiediary.data.Diary;
			cookiediary.data.Diary = new Object();
			Diary.Save(cookiediary.data.Diary);
			if (cookiediary.flush() == "pending") return true;
		
		}
		return false;
	}
	
	// For use in load/save
	// a temporary measure until coregame is updated to use this class at all times
	public function CopySlaveMakerDetails(smFrom:Object, smTo:Object)
	{
		if (smTo == undefined) smTo = this;
		if (smFrom == undefined) smFrom = this;
		super.CopyCommonDetails(smFrom, smTo);
		
		smTo.SlaveMakerName = smFrom.SlaveMakerName;
		smTo.Gender = smFrom.Gender;
		smTo.OldGender = smFrom.OldGender;
		smTo.Talent = smFrom.Talent;
		if (smFrom.TalentProgress != undefined) smTo.SpecialEventProgress = smFrom.TalentProgress;
		else smTo.SpecialEventProgress = smFrom.SpecialEventProgress;
			
		smTo.SMHomeTown = smFrom.SMHomeTown;
		smTo.SMSpecialEvent = smFrom.SMSpecialEvent;
		
		smTo.SilkenRopesOK = smFrom.SilkenRopesOK;
		smTo.RopesOK = smFrom.RopesOK;
		
		smTo.Corruption = smFrom.Corruption;
		smTo.SMMinCorruption = smFrom.SMMinCorruption;
		smTo.ArousalDefence = smFrom.ArousalDefence;
		smTo.SMLust = smFrom.SMLust;
		smTo.SMMinLust = smFrom.SMMinLust;
		smTo.SMConstitution = smFrom.SMConstitution;
		smTo.SMAttack = smFrom.SMAttack;
		smTo.SMDefence = smFrom.SMDefence;
		smTo.SMConversation = smFrom.SMConversation;
		smTo.SMReputation = smFrom.SMReputation;
		smTo.SMCharisma = smFrom.SMCharisma;
		smTo.SMRefinement = smFrom.SMRefinement;
		smTo.SMNymphomania = smFrom.SMNymphomania;
		smTo.SMTiredness = smFrom.SMTiredness;
		smTo.SMDominance = smFrom.SMDominance;
		smTo.SexualEnergy = smFrom.SexualEnergy;
		
		smTo.vitalsBustSM = smFrom.vitalsBustSM;
		smTo.vitalsBustStartSM = smFrom.vitalsBustStartSM;
		smTo.vitalsWaistSM = smFrom.vitalsWaistSM;
		smTo.vitalsHipsSM = smFrom.vitalsHipsSM;
		smTo.vitalsBloodTypeSM = smFrom.vitalsBloodTypeSM;
		smTo.vitalsWeightSM = smFrom.vitalsWeightSM;
		smTo.vitalsHeightSM = smFrom.vitalsHeightSM;
		smTo.ClitCockSizeSM = smFrom.ClitCockSizeSM;
		smTo.ClitCockSizeStartSM = smFrom.ClitCockSizeStartSM;
		
		smTo.SMDebt = smFrom.SMDebt;
		smTo.TheologyTraining = smFrom.TheologyTraining;
		smTo.SMFaith = smFrom.SMFaith;
		smTo.GirlsTrained = smFrom.GirlsTrained;
		smTo.PonygirlsTrained = smFrom.PonygirlsTrained;
		smTo.LesbiansTrained = smFrom.LesbiansTrained;
		smTo.CatgirlsTrained = smFrom.CatgirlsTrained;
		smTo.PuppygirlsTrained = smFrom.PuppygirlsTrained;
		smTo.DickgirlsTrained = smFrom.DickgirlsTrained;
		smTo.SlutsTrained = smFrom.SlutsTrained;
		smTo.CumslutsTrained = smFrom.CumslutsTrained;
		smTo.GuildMember = smFrom.GuildMember;
		smTo.SuccubusesTrained = smFrom.SuccubusesTrained;
		
		smTo.TotalSMBar = smFrom.TotalSMBar;
		smTo.TotalSMSleazyBar = smFrom.TotalSMSleazyBar;
		smTo.TotalSMMartial = smFrom.TotalSMMartial;
		smTo.TotalSMPray = smFrom.TotalSMPray;
		smTo.TotalSMJob = smFrom.TotalSMJob;
		smTo.TotalSMNun = smFrom.TotalSMNun;
		smTo.TotalSMCustom = smFrom.TotalSMCustom;
		smTo.TotalSMSpecial = smFrom.TotalSMSpecial;
		smTo.TotalSMTalkSlaves = smFrom.TotalSMTalkSlaves;
		
		smTo.EggOK = smFrom.EggOK;
		smTo.SMPiercingsType = smFrom.SMPiercingsType;
		smTo.SMVanityCaseOK = smFrom.SMVanityCaseOK;
		smTo.SMNippleRingsOK = smFrom.SMNippleRingsOK;
		smTo.TotalBooks = smFrom.TotalBooks;
		smTo.TotalPoetry = smFrom.TotalPoetry;
		
		smTo.PonygirlAware = smFrom.PonygirlAware;
		smTo.SkillPoints = smFrom.SkillPoints;
		smTo.SMGold = smFrom.SMGold;
		smTo.SMGoldSpent = smFrom.SMGoldSpent;
		
		smTo.sSlaveTrainer = smFrom.sSlaveTrainer;
		smTo.sLesbianTrainer = smFrom.sLesbianTrainer;
		smTo.sGayTrainer = smFrom.sGayTrainer;
		smTo.sTrader = smFrom.sTrader;
		smTo.sAlchemy = smFrom.sAlchemy;
		smTo.sPonyTrainer = smFrom.sPonyTrainer;
		smTo.sCatTrainer = smFrom.sCatTrainer;
		smTo.sPuppyTrainer = smFrom.sPuppyTrainer;
		smTo.sLeadership = smFrom.sLeadership;
		
		smTo.sSwordExpertise = smFrom.sSwordExpertise;
		smTo.sWhipExpertise = smFrom.sWhipExpertise;
		smTo.sBowExpertise = smFrom.sBowExpertise;
		smTo.sHammerExpertise = smFrom.sHammerExpertise;
		smTo.sNaginataExpertise = smFrom.sNaginataExpertise;
		smTo.sDaggerExpertise = smFrom.sDaggerExpertise;
		smTo.sCrossbowExpertise = smFrom.sCrossbowExpertise;
		smTo.sUnarmedExpertise = smFrom.sUnarmedExpertise;
		smTo.sThrownExpertise = smFrom.sThrownExpertise;
		if (smTo.sThrownExpertise == undefined) smTo.sThrownExpertise = 0;
		
		smTo.sSuccubusTrainer = smFrom.sSuccubusTrainer;
		smTo.sSlutTrainer = smFrom.sSlutTrainer;
		smTo.sOrgasmDenialTraining = smFrom.sOrgasmDenialTraining;
		smTo.sRefined = smFrom.sRefined;
		smTo.sNoble = smFrom.sNoble;
		smTo.sTentacleExpert = smFrom.sTentacleExpert;
		smTo.sBreastExpert = smFrom.sBreastExpert;
	}
	
	// reset any created objects
	public function Destroy()
	{
		ResetSMSkills();
		ResetSMQuailities();
	}
	
	// Naming
	
	public function GetFullName() : String
	{
		if (Titles != "") return Titles + " " + SlaveMakerName;
		return SlaveMakerName;
	}
	
	
	// Skills
	
	public function ResetSMSkills()
	{
		var i:Number = arSMSkills.length;
		var mc:MovieClip;
		while (--i >= 0) {
			mc = MovieClip(arSMSkills.pop());
			mc.removeMovieClip();
			delete mc;
		}
		delete arSMSkills;
		arSMSkills = new Array();
	}
	
	public function ResetSMQuailities()
	{
		var i:Number = arSMQualities.length;
		if (i != undefined) {
			var mc:MovieClip;
			while (--i >= 0) {
				mc = MovieClip(arSMQualities.pop());
				mc.removeMovieClip();
				delete mc;
			}
		}
		delete arSMQualities;
		arSMQualities = new Array();
	}
	
	private function AddSMQualities(advno:Number, adv:String)
	{
		var depth:Number = coreGame.SlaveMakerSkillsGroup.Talents.content.getNextHighestDepth();
		var image:MovieClip = coreGame.SlaveMakerSkillsGroup.Talents.content.attachMovie("Skill (Numbered) Details", "SMSkill" + depth, depth);
		var sn:Number = arSMQualities.push(image);
		sn--;
		image.SkillIcon._visible = false;
		image.SkillLabel.autoSize = true;
		if (adv == undefined) image.SkillLabel.text = GetSMQualitiesName(advno);
		else image.SkillLabel.text = adv;
		image.SkillValue._visible = false;
		image._x = (sn % 2) == 0 ? 6 : 136;
		image._y = Math.floor(sn / 2) * 16;
		image._visible = true;
		var ti:SlaveMaker = this;
		image.SkillHint.onRollOut = function() { ti.coreGame.HideHints(); }
		image.SkillHint.onRollOver = function() {	ti.SMQualitiesHintRollOver(this._parent);	}
		image.choice = advno;
	}
	
	public function ShowSMQualities()
	{
		ResetSMQuailities();
		
		if (SMSpecialEvent == 7) coreGame.SlaveMakerStatisticsGroup.SexualEnergy._visible = true;
		else coreGame.SlaveMakerStatisticsGroup.SexualEnergy._visible = false;
		
		for (var i = 0; i < 96; i++) {
			if (SMAdvantages.CheckBitFlag(i)) AddSMQualities(i);
		}
	
		if (SMInitialItems.CheckBitFlag(0)) AddSMQualities(-1, coreGame.Language.GetHtml("QualityNameShort-1", "SlaveMaker/Qualities"));
		if (SMInitialItems.CheckBitFlag(2)) AddSMQualities(-3, coreGame.Language.GetHtml("QualityNameShort-3", "SlaveMaker/Qualities"));
		if (SMInitialItems.CheckBitFlag(4)) AddSMQualities(-5, coreGame.Language.GetHtml("QualityNameShort-5", "SlaveMaker/Qualities"));
		if (SMInitialItems.CheckBitFlag(5)) AddSMQualities(-6);
		if (SMInitialItems.CheckBitFlag(8)) AddSMQualities(-9, coreGame.Language.GetHtml("QualityNameShort-9", "SlaveMaker/Qualities"));
		if (SMInitialItems.CheckBitFlag(12)) AddSMQualities(-13, coreGame.Language.GetHtml("QualityNameShort-13", "SlaveMaker/Qualities"));
	
		coreGame.SlaveMakerSkillsGroup.Talents.invalidate();
	}
	
	public function SMQualitiesHintRollOver(mc:MovieClip)
	{
		var choice:Number = mc.choice;
		var desc:String = GetSMQualitiesDescription(choice);
		var str:String = "";
		if (choice < 0 || coreGame.SlaveMakerCreate3._visible) {
			str = desc;
		} else {
			var adv:String = GetSMQualitiesAdvantage(choice);
			var disad:String = GetSMQualitiesDisadvantage(choice);
			if (adv == "") adv = coreGame.Language.GetHtml("NoAdvantage", "SlaveMaker/Qualities");
			if (disad == "") disad = coreGame.Language.GetHtml("NoDisadvantage", "SlaveMaker/Qualities");
			str = "<b>" + GetSMQualitiesName(choice) + "</b>\r" + desc + "\r<i>Advantages:</i>\r" + adv + "\r<i>Disadvantages:</i>\r" + disad;
		}
	
		if (coreGame.SlaveMakerCreate3._visible) {
			if (mc.BtnDisabled._visible) {
				str += "\r\r<b>" + coreGame.Language.GetHtml("NotAvailable", "SlaveMaker/Qualities") + "</b>";
				if (mc.criteria != undefined) str += "\r<font color='#FF0000'>" + mc.criteria + "</font>";
			}
		} 
		coreGame.Hints.ShowHint(str);
	}
	
	public function GetSMQualitiesName(choice:Number) : String
	{
		var Language = coreGame.Language;
		
		switch(choice) {
			case 5: return Language.GetHtml("Talent1Title", "Talents");
			case 6: return Language.GetHtml("Talent8Title", "Talents");
			case 7:
				if (Gender == 1) return Language.GetHtml("Talent11Title", "Talents");
				else return Language.GetHtml("Talent7Title", "Talents");
			case 8: return Language.GetHtml("Talent15Title", "Talents");
			case 9:
				if (Gender == 1) return Language.GetHtml("QualityName9m", "SlaveMaker/Qualities");
				else return Language.GetHtml("QualityName9f", "SlaveMaker/Qualities");
			case 10:
				if (Gender == 1) return Language.GetHtml("Master", Language.actNode)
				else return Language.GetHtml("Talent5Title", "Talents");
			case 11: return Language.GetHtml("Talent12Title", "Talents");
			case 12: return Language.GetHtml("Talent25Title", "Talents");
			case 13: return Language.GetHtml("Talent26Title", "Talents");
			case 14: return Language.GetHtml("Talent27Title", "Talents");
			
			case 100: 
			case 101: 
			case 102: 
			case 103:
			case 104:
			case 105:
			case 106:
			case 107:
				return Language.GetHtml("Town" + (choice - 100), "SlaveMaker/Qualities")
	
			case 206: return Language.GetHtml("Talent4Title", "Talents");
			case 205: return Language.GetHtml("Talent10Title", "Talents");
			case 204: return Language.GetHtml("Talent20Title", "Talents");
			case 203: return Language.GetHtml("Talent19Title", "Talents");
			case 202: return Language.GetHtml("Talent14Title", "Talents");
			case 201: return Language.GetHtml("Talent28Title", "Talents");
	
			case 301: return Language.GetHtml("SlaveTraining", "Skills") + " 2";
			case 302: return Language.GetHtml("LesbianTrainer", "Skills") + " 1";
			case 303: return Language.GetHtml("Refined", "Skills") + " 1";
			case 304: return Language.GetHtml("CatslaveTrainer", "Skills") + " 1";
			case 305: return Language.GetHtml("Alchemy", "Skills") + " 1";
			case 306: return Language.GetHtml("ExpertTrader", "Skills") + " 1";
			case 307: return Language.GetHtml("PonygirlTrainer", "Skills") + " 1";
			case 308: return Language.GetHtml("Leadership", "Skills") + " 1";
			case 309: return Language.GetHtml("SlutTrainer", "Skills") + " 1";
			case 310: return Language.GetHtml("GayTrainer", "Skills") + " 1";
			case 311: return Language.GetHtml("PuppyslaveTrainer", "Skills") + " 1";
		}
		return Language.GetHtml("QualityName" + choice, "SlaveMaker/Qualities");
	}
	
	public function GetSMQualitiesCost(choice:Number) : Number
	{
		switch(choice) {
			case -1: return 20;
			case -2: return 10;
			case -3: return 40;
			case -4: return 15;
			case -5: return 40;
			case -6: return 10;
			case -7: return 5;
			case -8: return 5;
			case -9: return 25;
			case -10: return 5;
			case -11: return 5;
			case -12: return 5;
			case -13: return 20;
			
			 case 0: return 10;
			case 1: return 20;
			case 2: return 10;
			case 3: return 10;
			case 4: return 5;
			case 5: return 5;
			case 6: return 20;
			case 7:	return 20;
			case 8: return 20;
			case 9: return 10;
			case 10: return 20;
			case 11: return 10;
			case 12: return 20;
			case 13: return 10;
			case 14: return 10;
			case 15: return 10;
			case 16: return -5;
			case 17: return -5;
			case 18: return -5;
			case 19: return 10;
			case 20: return -10;
			case 21: return 10;
			case 22: return 10;
			case 23: return -5;
			case 24: return -5;
			case 25: return -5;
			case 26: return 10;
			case 27: return -5;
			case 28: return 20;
			
			case 100: return 0;
			case 101: 
			case 103:
			case 104:
				return 5;
			case 102:
				if (Gender == 3) return 25;
				else if (Gender == 2 && coreGame.Options.DickgirlOn == 0) return 25;
				return -5;
			case 105: return 10;
			case 106: return 10;
			case 107: return 15;
	
			case 206: 
			case 205: 
			case 204: 
			case 203: 
			case 202: 
			case 201: 
				return 10;
	
			case 301: 
				return 30;
			case 302: 
			case 303:
			case 304: 
			case 305: 
			case 306: 
			case 307: 
			case 308:
			case 309:
			case 310:
			case 311:
				return 15;
		}
		return coreGame.Language.XMLData.GetXMLValue("SlaveMaker/Qualities/QualityCost" + choice);
	}
	
	public function GetSMQualitiesAdvantage(choice:Number) : String
	{
		var Language = coreGame.Language;
		
		switch(choice) {
			case -1:
			case -3:
			case -5:
			case -6:
			case -9:
				choice = -1;
				break;
			case -2:
			case -4:
			case -7:
			case -8:
			case -10:
			case -11:
				choice = -8;
				break;
				
			 case 0: return Language.GetHtml("NobilityLevel1", "Skills");
			case 1: return Language.GetHtml("NobilityLevel2", "Skills");
			case 7:
				if (Gender == 1) return Language.GetHtml("QualityAdvantage7m", "SlaveMaker/Qualities");
				else return Language.GetHtml("QualityAdvantage7f", "SlaveMaker/Qualities");
				break;
			case 10:
				choice = 9;
				break;
			case 12: return Language.GetHtml("Talent25Advantage", "Talents");
			case 13: return Language.GetHtml("Talent26Advantage", "Talents");
			case 14: return Language.GetHtml("Talent27Advantage", "Talents");
			
			case 100: return Language.GetHtml("NoAdvantage", "SlaveMaker/Qualities");
			case 101: return Language.GetHtml("QualityAdvantage101", "SlaveMaker/Qualities") + ", " + coreGame.SlaveMakerStatisticsGroup.Charisma.StatLabel.text + " + 2";
			case 102:
				if (Gender == 3) return coreGame.SlaveMakerStatisticsGroup.Dominance.StatLabel.text + " +4, " + Language.GetHtml("NobilityLevel1", "Skills");
				else if (Gender == 2 && coreGame.Options.DickgirlOn == 0) return coreGame.SlaveMakerStatisticsGroup.Dominance.StatLabel.text + " +4, " + Language.GetHtml("NobilityLevel1", "Skills");
				else return coreGame.SlaveMakerStatisticsGroup.Constitution.StatLabel.text + " +4";
			case 103: return Language.GetHtml("QualityAdvantage103", "SlaveMaker/Qualities") + ", " + coreGame.SlaveMakerStatisticsGroup.Refinement.StatLabel.text + " +2";
			case 104: return Language.GetHtml("QualityAdvantage104", "SlaveMaker/Qualities") + ", " + coreGame.SlaveMakerStatisticsGroup.Constitution.StatLabel.text + " +5, " + coreGame.SlaveMakerStatisticsGroup.Defence.StatLabel.text + " +5";
			case 105: return Language.GetHtml("QualityAdvantage105", "SlaveMaker/Qualities") + ", " + coreGame.SlaveMakerStatisticsGroup.Charisma.StatLabel.text + " + 2";
			case 106: return Language.GetHtml("QualityAdvantage106", "SlaveMaker/Qualities") + ", " + coreGame.SlaveMakerStatisticsGroup.Dominance.StatLabel.text + " +4";
			case 107: return Language.GetHtml("QualityAdvantage107", "SlaveMaker/Qualities") + ", " + coreGame.SlaveMakerStatisticsGroup.Constitution.StatLabel.text + " +5, " + coreGame.SlaveMakerStatisticsGroup.Defence.StatLabel.text + " +5";
			
			case 206: return Language.GetHtml("Talent4Advantage", "Talents");
			case 205: return Language.GetHtml("Talent10Advantage", "Talents");
			case 204: return Language.GetHtml("Talent20Advantage", "Talents");
			case 203: return Language.GetHtml("Talent19Advantage", "Talents");
			case 202: return Language.GetHtml("Talent14Advantage", "Talents");
	
			case 301: return Language.GetHtml("SlaveTrainingLevel2", "Skills");
			case 302: return Language.GetHtml("LesbianTrainerLevel1", "Skills");
			case 303: return Language.GetHtml("RefinedLevel1", "Skills");
			case 304: return Language.GetHtml("CatslaveTrainerLevel1", "Skills");
			case 305: return Language.GetHtml("AlchemyLevel1", "Skills");
			case 306: return Language.GetHtml("ExpertTraderLevel1", "Skills");
			case 307: return Language.GetHtml("PonygirlTrainerLevel1", "Skills");
			case 308: return Language.GetHtml("LeadershipLevel1", "Skills");
			case 309: return Language.GetHtml("SlutTrainerDescription", "Skills");
			case 310: return Language.GetHtml("GayTrainerDescription", "Skills");
			case 311: return Language.GetHtml("PuppyslaveTrainerDescription", "Skills");
	
		}
		return Language.GetHtml("QualityAdvantage" + choice, "SlaveMaker/Qualities");
	}
	
	public function GetSMQualitiesDisadvantage(choice:Number) : String
	{
		if (choice < 9 || (choice > 299 && choice < 400)) return "";
		var Language = coreGame.Language;
		switch(choice) {
			
			case 12: return Language.GetHtml("Talent25Disadvantage", "Talents");
			case 13: return Language.GetHtml("Talent26Disadvantage", "Talents");
			case 14: return Language.GetHtml("Talent27Disadvantage", "Talents");
			
			case 100: 
			case 101:
			case 103:
			case 105:
				return Language.GetHtml("NoDisadvantage", "SlaveMaker/Qualities");
			case 102:
				if (Gender == 3) return coreGame.SlaveMakerStatisticsGroup.Refinement.StatLabel.text + " -2";
				else if (Gender == 2 && coreGame.Options.DickgirlOn == 0) return coreGame.SlaveMakerStatisticsGroup.Refinement.StatLabel.text + " -2";
				else return coreGame.SlaveMakerStatisticsGroup.Dominance.StatLabel.text + " -2"; 
			case 104: return coreGame.SlaveMakerStatisticsGroup.Refinement.StatLabel.text + " -1";
			case 106: return Language.GetHtml("Talent30Disadvantage", "Talents");
			case 107: return Language.GetHtml("Talent31Disadvantage", "Talents");
	
			case 206: return Language.GetHtml("Talent4Disadvantage", "Talents");
			case 205: return Language.GetHtml("Talent10Disadvantage", "Talents");
			case 204: return Language.GetHtml("Talent20Disadvantage", "Talents");
			case 203: return Language.GetHtml("Talent19Disadvantage", "Talents");
			case 202: return Language.GetHtml("Talent14Disadvantage", "Talents");
		}
		return Language.GetHtml("QualityDisadvantage" + choice, "SlaveMaker/Qualities");
	}
	
	function GetSMQualitiesDescription(choice:Number) : String
	{
		var Language = coreGame.Language;
		switch(choice) {
			case 7:
				if (Gender == 1) return Language.GetHtml("QualityDescription7m", "SlaveMaker/Qualities");
				else return Language.GetHtml("QualityDescription7f", "SlaveMaker/Qualities");
			case 102:
				if (Gender == 3) return Language.GetHtml("QualityDescription102d", "SlaveMaker/Qualities");
				else if (Gender == 2 && coreGame.Options.DickgirlOn == 0) return Language.GetHtml("QualityDescription102f", "SlaveMaker/Qualities");
				else return coreGame.Options.DickgirlOn == 1 ? Language.GetHtml("QualityDescription102md", "SlaveMaker/Qualities") : Language.GetHtml("QualityDescription102mf", "SlaveMaker/Qualities");
			case 301: return Language.GetHtml("SlaveTrainingDescription", "Skills");
			case 302: return Language.GetHtml("LesbianTrainerDescription", "Skills");
			case 303: return Language.GetHtml("RefinedDescription", "Skills");
			case 304: return Language.GetHtml("CatslaveTrainerDescription", "Skills");
			case 305: return Language.GetHtml("AlchemyDescription", "Skills");
			case 306: return Language.GetHtml("ExpertTraderDescription", "Skills");
			case 307: return Language.GetHtml("PonygirlTrainerDescription", "Skills");
			case 308: return Language.GetHtml("LeadershipDescription", "Skills");
			case 309: return Language.GetHtml("SlutTrainerDescription", "Skills");
			case 310: return Language.GetHtml("GayTrainerDescription", "Skills");
			case 311: return Language.GetHtml("PuppyslaveTrainerDescription", "Skills");
		}
		return Language.GetHtml("QualityDescription" + choice, "SlaveMaker/Qualities");
	}	
	
	// Gender
	public function IsFemale() : Boolean { return Gender > 1; }
	public function IsWoman() : Boolean { return Gender == 2; }
	public function IsMale() : Boolean { return Gender == 1; }	
	public function IsTwins() : Boolean { return false; }	
	public function IsDickgirl() : Boolean { return Gender == 3; }
	
	// Special backgrounds
	 public function IsDominatrix() : Boolean
	{
		return SMAdvantages.CheckBitFlag(9) || SMAdvantages.CheckBitFlag(10);
	}
	
	public function IsDickgirlAmazon() : Boolean
	{
		return SMHomeTown == 2 && Gender == 3;
	}
	
	public function IsFemaleAmazon() : Boolean
	{
		return SMHomeTown == 2 && Gender == 2 && coreGame.Options.DickgirlOn == 0;
	}
	
	
	// Home Town
	public function UpdateHomeTown(town:Number)
	{
		if (town == undefined) town = SMHomeTown;
		else SMHomeTown = town;
		coreGame.SMHomeTown = town;		// TODO remove
		coreGame.SlaveMakerVitalsGroup.HomeTownLabel.text = GetSMQualitiesName(100 + town);
	}
	
	// Dresses - override function
	public function GetDress(dress:Number) : DressSlaveMaker
	{
		dress = Math.abs(dress);
		if (dress > 6) dress = 6;
		if (arDresses == null) {
			arDresses = new Array();
			for (var i:Number = 0; i < 7; i++) {
				var ds:DressSlaveMaker = new DressSlaveMaker(this);
				ds.SetDressForSale(false);
				arDresses.push(ds);
			}
		}
		if (dress > arDresses.length) return null;
		return arDresses[dress];
	}
		
	// pregnancy
	public function CanImpregnate(type:String) : Boolean
	{
		if (super.CanImpregnate(type) == false || Gender < 2) return false;
		var fer:Number = Fertility;
		if (!BitFlagSM.CheckBitFlag(14)) fer = 0;
	
		return (coreGame.PercentChance(fer) || type.toLowerCase() == "tentacle" || type.toLowerCase() == "tentacles");
	}
	
	public function Impregnate(type:String, count:Number, gestation:Number)
	{
		if (super.CanImpregnate(type) == false || Gender < 2) return;
		
		DateImpregnated = coreGame.GameDate;
		PregnancyType = type;
		if (gestation == undefined) {
			if (type.toLowerCase() == "human") {
				PregnancyGestation = coreGame.config.nBaseGestation + Math.floor(Math.random()*10);
				if (IsTrueCatgirl()) PregnancyGestation -= 30;
				if (IsElf()) PregnancyGestation += 60;
			} else PregnancyGestation = 28 + Math.floor(Math.random()*5);
		} else PregnancyGestation = gestation;
		if (count == undefined) {
			if (IsElf()) PregnancyCount = slrandom(slrandom(slrandom(slrandom(2))));
			else if (IsTrueCatgirl()) PregnancyCount = int(3 * ((Math.random() + Math.random() + Math.random() + Math.random() + Math.random()) / 5)) + 1;
			else PregnancyCount = slrandom(slrandom(2));
		} else PregnancyCount = count;
		
		if (type.toLowerCase() == "tentacle" || type.toLowerCase() == "tentacles") coreGame.BitFlag1.SetBitFlag(34);
	}
	
	// stats
	public function GetStatNameBase(stat:Number) : String
	{
		switch(stat) {
			case 0: return "Conversation";
			case 1: return "Constitution";
			case 2: return "Renown";
			case 3: return "Attack";
			case 4: return "Defence";
			case 5: return "Lust";
			case 6: return "Corruption";
			case 7: return "Dominance";
			case 8: return "Charisma";
			case 9: return "Refinement";
			case 10: return "Nymphomania";
			case 11: return "Tiredness";
			case 12: return "ArousalDefence";
			case 13: return "SexualEnergy";
		}
		return "";
	}
	
	// the slave makers stat names, for use in generating descriptions
	private function GetStatName(id:Number) : String { return coreGame.Language.GetText(GetStatNameBase(id), "Statistics"); }
	
	/*
	SMPoints(attack, defence, arousaldef, constitution, conversation, lust, corrupt, renown, dominance, charisma, refinement, nymphomania, tiredness, sexualenergy);
	<SMPoints>attack, defence, arousaldef, constitution, conversation, lust, corrupt, renown, dominance, charisma, refinement, nymphomania, tiredness, sexualenergy</SMPoints>
	*/
	public function SMPoints(attack:Number, defence:Number, arousaldef:Number, constitution:Number, conversation:Number, lust:Number, corrupt:Number, renown:Number, dominance:Number, charisma:Number, refinement:Number, nymphomania:Number, tiredness:Number, sexualenergy:Number)
	{
		var dmod:Number = coreGame.dmod;
		if (isNaN(tiredness)) tiredness = 0;
		if (isNaN(nymphomania)) nymphomania = 0;
		if (isNaN(refinement)) refinement = 0;
		if (isNaN(charisma)) charisma = 0;
		if (isNaN(renown)) renown = 0;
		if (isNaN(dominance)) dominance = 0;
		if (isNaN(corrupt)) corrupt = 0;
		if (isNaN(sexualenergy)) sexualenergy = 0;
		if (SMAdvantages.CheckBitFlag(3)) {
			attack *= 1.1;
			defence *= 1.1;
			conversation *= 0.9;
		} else if (SMAdvantages.CheckBitFlag(18)) {
			attack *= 0.9;
			defence *= 0.9;
		}
		if (SMAdvantages.CheckBitFlag(24)) {
			if (dominance > 0) dominance *= 0.5;
			else if (dominance < 0) dominance *= 1.5;
		}
		if (SMAdvantages.CheckBitFlag(0) || SMAdvantages.CheckBitFlag(1)) conversation *= 1.1;
		if (dominance > 0) {
			if (SMDominance < 25) dominance *= 0.8;
			else if (SMDominance > 75) dominance *= 1.2;
		} else if (dominance < 0) {
			if (SMDominance < 25) dominance *= 1.2;
			else if (SMDominance > 75) dominance *= 0.8;
		}
		
		var maxlust:Number = Gender == 3 ? 80 : 70;
		if (SMAdvantages.CheckBitFlag(8)) maxlust += 10;
		if (SMDominance < 40) maxlust += 10;
		else if (SMDominance < 20) maxlust = 100;
		SMLust = LimitStat(SMLust, lust * dmod, maxlust);
		if (SMMinLust > 60) SMMinLust = Gender == 3 ? 70 : 60;
		if (SMLust < SMMinLust) SMLust = SMMinLust;
		
		SMConstitution = LimitStat(SMConstitution, constitution * dmod);
		SMAttack = LimitStat(SMAttack, attack * dmod * 0.1, SMAdvantages.CheckBitFlag(3) ? 100 : 75);
		SMDefence = LimitStat(SMDefence, defence * dmod * 0.1, SMAdvantages.CheckBitFlag(3) ? 100 : 75);
		if (attack > 0) {
			var wtype:String = GetWeaponClass();
			switch (wtype) {
				case "unarmed":
					sUnarmedExpertise = LimitStat(sUnarmedExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(57));
					break;
				case "sword": 
					if (sSwordExpertise > 4) sSwordExpertise = LimitStat(sSwordExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(50));
					break;
				case "bow": 
					if (sBowExpertise > 4) sBowExpertise = LimitStat(sBowExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(51));
					break;
				case "whip": 
					if (sWhipExpertise > 4) sWhipExpertise = LimitStat(sWhipExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(52));
					break;
				case "hammer":
					if (sHammerExpertise > 4) sHammerExpertise = LimitStat(sHammerExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(53));
					break;
				case "naginata":
					if (sNaginataExpertise > 4) sNaginataExpertise = LimitStat(sNaginataExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(54));
					break;
				case "dagger":
					if (sDaggerExpertise > 4) sDaggerExpertise = LimitStat(sDaggerExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(55));
					break;
				case "crossbow":
					if (sCrossbowExpertise > 4) sCrossbowExpertise = LimitStat(sCrossbowExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(56));
					break;
				case "thrown":
					if (sThrownExpertise > 4) sThrownExpertise = LimitStat(sThrownExpertise, attack * dmod * 0.9, SMSlaveCommon.GetSMMaxSkill(58));
					break;
			}
		}
		var maxconv:Number = sRefined > 0 ? 100 : 85;
		if (SMAdvantages.CheckBitFlag(2) && maxconv < 90) maxconv = 90;
		SMConversation = LimitStat(SMConversation, conversation * dmod, maxconv);
				
		var maxdom:Number = IsDominatrix() ? 100 : 85;
		SMDominance = LimitStat(SMDominance, dominance * dmod, maxdom);
		
		ArousalDefence = LimitStat(ArousalDefence, arousaldef * dmod);
		SMReputation = LimitStat(SMReputation, renown * dmod);
		Corruption = LimitStat(Corruption, corrupt);
		SMCharisma = LimitStat(SMCharisma, charisma);
		SMRefinement = LimitStat(SMRefinement, refinement);
		SMNymphomania = LimitStat(SMNymphomania, nymphomania);
		SMTiredness = LimitStat(SMTiredness, tiredness);
		SexualEnergy = LimitStat(SexualEnergy, sexualenergy);
		
		if (SMAttack < 100 && attack > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Attack, attack * dmod);
		if (SMDefence  < 100 && defence > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Defence, defence * dmod);
		if (Corruption < 100 && corrupt > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Corruption, corrupt * dmod);
		if (SMConstitution < 100 && constitution > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Constitution, constitution * dmod);
		if (SMConversation < 100 && conversation > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Conversation, conversation * dmod);
		if (SMReputation < 100 && renown > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Renown, renown * dmod);
		if (SMLust < 100 && lust > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Lust, lust * dmod);
		if (SMDominance < 100 && dominance > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Dominance, dominance * dmod);
		if (SMCharisma < 100 && charisma > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Charisma, charisma * dmod);
		if (SMRefinement < 100 && refinement > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Refinement, refinement * dmod);
		if (SMNymphomania < 100 && nymphomania > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Nymphomania, nymphomania * dmod);
		if (SMTiredness < 100 && tiredness > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Tiredness, tiredness * dmod);
		if (SexualEnergy < 100 && sexualenergy > 0) IconValue(coreGame.SlaveMakerStatisticsGroup.SexualEnergy, sexualenergy * dmod);
		
		if (SMAttack > 0 && attack < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Attack, attack * dmod);
		if (SMDefence > 0 && defence < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Defence, defence * dmod);
		if (Corruption > 0 && corrupt < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Corruption, corrupt * dmod);
		if (SMConstitution > 0 && constitution < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Constitution, constitution * dmod);
		if (SMConversation > 0 && conversation < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Conversation, conversation * dmod);
		if (SMReputation > 0 && renown < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Renown, renown * dmod);
		if (SMLust > 0 && lust < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Lust, lust * dmod);
		if (SMDominance > 0 && dominance < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Dominance, dominance * dmod);
		if (SMCharisma > 0 && charisma < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Charisma, charisma * dmod);
		if (SMRefinement > 0 && refinement < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Refinement, refinement * dmod);
		if (SMNymphomania > 0 && nymphomania < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Nymphomania, nymphomania * dmod);
		if (SMTiredness > 0 && tiredness < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.Tiredness, tiredness * dmod);
		if (SexualEnergy > 0 && sexualenergy < 0) IconValue(coreGame.SlaveMakerStatisticsGroup.SexualEnergy, sexualenergy * dmod);

		UpdateSlaveMaker();
	}
	
	public function LimitAllStats()
	{
		// Gold (legacy updates and corruptions)
		if (SMGold == undefined || isNaN(SMGold)) SMGold = 0;
		if (coreGame.SMGold == undefined || isNaN(coreGame.SMGold)) coreGame.SMGold = SMGold;
		if (coreGame.SMGold != SMGold) SMGold = coreGame.SMGold;
		
		var maxlust:Number = Gender == 3 ? 80 : 70;
		if (SMAdvantages.CheckBitFlag(8)) maxlust += 10;
		if (SMDominance < 40) maxlust += 10;
		else if (SMDominance < 20) maxlust = 100;
		SMLust = LimitStat(SMLust, 0, maxlust);
		if (SMMinLust > 60) SMMinLust = Gender == 3 ? 70 : 60;
		if (SMMinLust < 0) SMMinLust = 0;
		if (SMLust < SMMinLust) SMLust = SMMinLust;
		
		var maxconv:Number = sRefined > 0 ? 100 : 85;
		if (SMAdvantages.CheckBitFlag(2) && maxconv < 90) maxconv = 90;
		var maxdom:Number = IsDominatrix() ? 100 : 85;
		SMConversation = LimitStat(SMConversation, 0, maxconv);
		SMDominance = LimitStat(SMDominance, 0, maxdom);
		
		if (SMMinCorruption < 0) SMMinCorruption = 0;
		if (SMMinCorruption > 100) SMMinCorruption = 100;
		if (SexualEnergy > 100) SexualEnergy = 100;
		if (SexualEnergy < 0) SexualEnergy = 0;
				
		if (sUnarmedExpertise > 100) sUnarmedExpertise = 100;
		if (sSwordExpertise > 100) sSwordExpertise = 100;
		if (sBowExpertise > 100) sBowExpertise = 100;
		if (sWhipExpertise > 100) sWhipExpertise = 100;
		if (sHammerExpertise > 100) sHammerExpertise = 100;
		if (sNaginataExpertise > 100) sNaginataExpertise = 100;
		if (sDaggerExpertise > 100) sDaggerExpertise = 100;
		if (sCrossbowExpertise > 100) sCrossbowExpertise = 100;
		if (sThrownExpertise > 100) sThrownExpertise = 100;
		if (sGayTrainer > 3) sGayTrainer = 3;
	}
	
	public function UpdateSlaveMaker() { coreGame.dspMain.UpdateSlaveMaker(); }
	
	// Xml parser for <SMPoints> node
	/*
	<SMPoints>attack, defence, arousaldef, constitution, conversation, lust, corrupt, renown, dominance, charisma, refinement, nymphomania, tiredness, sexualenergy</SMPoints>
	or
	<SMPoints>
	     <Attack>1</Attack>
		 <Corruptopn>-1</Corruption>
	</SMPoints>
	*/
	private function ParseSMStat(sNode:XMLNode, obc:Object) {
		var ifNode:XMLNode;
		var str:String;
		for (var stNode:XMLNode = sNode; stNode != null; stNode = stNode.nextSibling) {
			if (stNode.nodeType != 1) continue;
			str = stNode.nodeName.toLowerCase();
			if (str == "else") return;
			if (str == "if") {
				ifNode = coreGame.ParseConditional(stNode, true, false);
				if (ifNode != null) ParseSMStat(ifNode, obc);
				continue;
			}
			if (str == "ifor") {
				ifNode = coreGame.ParseConditional(stNode, false, false);
				if (ifNode != null) ParseSMStat(ifNode, obc);
				continue;
			}
			if (str == "ifnot") {
				ifNode = coreGame.ParseConditional(stNode, false, true);
				if (ifNode != null) ParseSMStat(ifNode, obc);
				continue;
			}

			for (var i:Number = 0; i < 14; i++) {
				if (str == GetStatNameBase(i).toLowerCase()) {
					var val:Number = coreGame.XMLData.GetExpression(stNode.firstChild.nodeValue);
					switch(i) {
						case 0: obc.conversation = val; break;
						case 1: obc.constitution = val; break;
						case 2: obc.renown = val; break;
						case 3: obc.attack = val; break;
						case 4: obc.defence = val; break;
						case 5: obc.lust = val; break;
						case 6: obc.corrupt = val; break;
						case 7: obc.dominance = val; break;
						case 8: obc.charisma = val; break;
						case 9: obc.refinement = val; break;
						case 10: obc.nymphomania = val; break;
						case 11: obc.tiredness = val; break;
						case 12: obc.arousaldef = val; break;
						case 13: obc.sexualenergy = val; break;
					}
					break;
				}
			}
		}
	}
		
	public function ParseSMPoints(aNode:XMLNode, bNegate:Boolean)
	{
		var obc:Object = new Object();
		obc.attack = 0;
		obc.defence = 0;
		obc.arousaldef = 0;
		obc.constitution = 0;
		obc.conversation = 0;
		obc.lust = 0;
		obc.corrupt = 0;
		obc.renown = 0;
		obc.dominance = 0;
		obc.charisma = 0;
		obc.refinement = 0;
		obc.nymphomania = 0;
		obc.tiredness = 0;
		obc.sexualenergy = 0;
	
		if (aNode.firstChild.nodeValue != null && aNode.firstChild.nodeValue.indexOf(",") != -1) {
			var sl:Array = aNode.firstChild.nodeValue.split(",");
			obc.attack = coreGame.XMLData.GetExpression(sl[0]);
			obc.defence = coreGame.XMLData.GetExpression(sl[1]);
			obc.arousaldef = coreGame.XMLData.GetExpression(sl[2]);
			obc.constitution = coreGame.XMLData.GetExpression(sl[3]);
			obc.conversation = coreGame.XMLData.GetExpression(sl[4]);
			obc.lust = coreGame.XMLData.GetExpression(sl[5]);
			obc.corrupt = coreGame.XMLData.GetExpression(sl[6]);
			obc.renown = coreGame.XMLData.GetExpression(sl[7]);
			obc.dominance = coreGame.XMLData.GetExpression(sl[8]);
			obc.charisma = coreGame.XMLData.GetExpression(sl[9]);
			obc.refinement = coreGame.XMLData.GetExpression(sl[10]);
			obc.nymphomania = coreGame.XMLData.GetExpression(sl[11]);
			obc.tiredness = coreGame.XMLData.GetExpression(sl[12]);
			obc.sexualenergy = coreGame.XMLData.GetExpression(sl[13]);
		} else ParseSMStat(aNode.firstChild, obc);

		if (bNegate == true) SMPoints(-1 * obc.attack, -1 * obc.defence, -1 * obc.arousaldef, -1 * obc.constitution, -1 * obc.conversation, -1 * obc.lust, -1 * obc.corrupt, -1 * obc.renown, -1 * obc.dominance, -1 * obc.charisma, -1 * obc.refinement, -1 * obc.nymphomania, -1 * obc.tiredness, -1 * obc.sexualenergy);
		else SMPoints(obc.attack, obc.defence, obc.arousaldef, obc.constitution, obc.conversation, obc.lust, obc.corrupt, obc.renown, obc.dominance, obc.charisma, obc.refinement, obc.nymphomania, obc.tiredness, obc.sexualenergy);
	}
	
	/*
	SMChangeMinStats(Corruption, Lust);
	<SMChangeMinStats>Corruption, Lust</Points>
	*/
	public function SMChangeMinStats(Corruption:Number, Lust:Number)
	{
		if (!isNaN(Lust)) SMMinLust += Lust;
		if (!isNaN(Corruption)) SMMinCorruption += Corruption;
		coreGame.SMMinLust = SMMinLust;		// TODO remove
		coreGame.SMMinCorruption = SMMinCorruption;		// TODO remove
		
		UpdateSlaveMaker();
	}
	
	// Love and Marriage
	public function GetTotalMarried() : Number
	{
		var sdata:Slave;
		var tot:Number = 0;
		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
			if (sdata.IsMarried()) tot++;
		}
		return tot;
	}
	
	// capability
	public function IsNakedDressAvailable() : Boolean
	{
		if (coreGame.SlaveGirl.IsNakedDressAvailable() == true) return true;
		var ndlevel:Number = 3;
		if (coreGame.IsSlave("Naru")) ndlevel = 0;
		else if (sSlutTrainer == 2) ndlevel = 1;
		else if (sSlutTrainer >= 1) ndlevel = 2;
		return BitFlagSM.CheckBitFlag(19) && coreGame.LevelNaked >= ndlevel;
	}
	
	public function IsCumslutTraining() : Boolean
	{
		return sSlutTrainer == 2 || coreGame.AssistantData.sSlutTrainer == 2 || coreGame.IsSlave("Kasumi");
	}
	
	// Guild/Freelancer
	public function ChangeGuildMembership(member:Boolean)
	{
		if (member != undefined) {
			GuildMember = member;
			coreGame.GuildMember = member;
		}
		
		if (GuildMember) coreGame.SlaveMakerVitalsGroup.LGuildMember.text = coreGame.Language.GetHtml("GuildMember", "Guild");
		else coreGame.SlaveMakerVitalsGroup.LGuildMember.text = coreGame.Language.GetHtml("Freelancer", "Guild");
	}
	
	// Start Career
	public function GetEffectivePackage() : Number
	{
		var eff:Number = Talent;
		if (eff == -1) {
			if (SMSpecialEvent != -1) {
			if (SMSpecialEvent == 8) eff = 24;
			if (SMSpecialEvent == 7) eff = 23;
			if (SMSpecialEvent == 6) eff = 4;
			if (SMSpecialEvent == 5) eff = 10;
			if (SMSpecialEvent == 3) eff = 19;
			if (SMSpecialEvent == 4) eff = 20;
			if (SMSpecialEvent == 2) eff = 14;
			if (SMSpecialEvent == 1) eff = 28;
			} else {
				if (IsDominatrix() && Gender == 3) eff = 21;
				else if (SMAdvantages.CheckBitFlag(6)) eff = 8;
				else if (SMAdvantages.CheckBitFlag(13)) eff = 26;
				else if (SMAdvantages.CheckBitFlag(4) && SMSkills.CheckBitFlag(8)) eff = 17;
				else if (IsDickgirlAmazon()) eff = 9;
				else if (SMAdvantages.CheckBitFlag(8)) eff = 15;
				else if (SMAdvantages.CheckBitFlag(7)) {
					if (Gender == 1) eff = 11;
					else eff = 7;
				} else if (SMAdvantages.CheckBitFlag(5)) eff = 1;
				else if (SMAdvantages.CheckBitFlag(2)) eff = 3;
				else if (SMAdvantages.CheckBitFlag(14)) eff = 27;
			}
		}
		return eff;
	}
	
	public function StartSlaveMaker()
	{
		switch(Talent) {
			case 0:	// No Talent
				SMDominance = 70;
				SkillPoints++;
				break;
			case 1:	// Wealthy
				SMConversation = 35;
				SMAdvantages.SetBitFlag(5);
				break;
			case 2:  // Leader
				SMConversation = 40;
				sLeadership = 2;
				sSwordExpertise += 5;
				break;
			case 3:  //Trader
				SMConstitution = 50;
				SMConversation = 40;
				SMDefence = 50;
				break;
			case 4: // Inhuman
				SMLust = 40;
				break;
			case 5:  // Dominatrix
				SMLust = 40;
				SMDominance = 75;
				break;
			case 6:  // Lesbian Trainer
				SMConversation = 40;
				break;
			case 7:  // Witch
				SMLust = 40;
				SMMinLust = 5;
				SMConstitution = 50;
				break;
			case 8:   // Unnatural Cum
				SMLust = 50;
				SMConstitution = 50;
				break;
			case 9:	// Amazon
				SMAttack = 50;
				SMConstitution = 50;
				SMConversation = 20;
				break;
			case 10:	// Demonic Cock
				SMLust = 20;
				SMDominance = 50;
				SMMinCorruption = 5;
				break;
			case 11:	// Pagan
				SMLust = 40;
				SMMinLust = 5;
				SMDominance = 70;
				break;
			case 12:	// Pony Master
				SMDominance = 70;
				sPonyTrainer = 2;
				break;
			case 13:	// Warrior
				ArousalDefence = 0.5;
				SMConstitution = 50;
				SMAttack = 50;
				SMDefence = 50;
				break;
			case 14:	// Tentacle Hybrid
				SMConversation = 40;
				Corruption = 5;
				SMLust = 40;
				break;
			case 15:	// Brothel Madam
				SMDominance = 55;
				SMConstitution = 47;
				SMConversation = 40;
				SMLust = 50;
				SMAttack = 20;
				SMDefence = 30;
				SMAdvantages.SetBitFlag(8);
				break;
			case 16:	// Lady in Waiting
				SMConversation = 50;
				SMAttack = 25;
				SMDefence = 25;
				break;
			case 17:	// Slut Maker
				SMConstitution = 50;
				SMLust = 50;
				sSlutTrainer = 1;
				SMMinLust = 30;
				SMNymphomania = 30;
				SMRefinement = 20;
				SMAdvantages.SetBitFlag(4);
				break;
			case 18:	// Demon Consort
				sSuccubusTrainer = 1;
				sOrgasmDenialTraining = 1;
				SMFaith = 3;
				Corruption = 5;
				SMMinCorruption = 5;
				SMMinLust = 30;
				SMLust = 40;
				break;
			case 19:	// Converted by Tentacles
				SMLust = 40;
				SMDominance = 60;
				break;
			case 20:	// Ex Cowgirl
				SMLust = 40;
				SMDominance = 50;
				break;
			case 21:	// Mistress Cock
				SMLust = 40;
				SMDominance = 75;
				break;
			case 22:	// Court Manipulator
				SMAttack = 25;
				SMDefence = 25;
				SMConversation = 55;
				SMDominance = 70;
				break;
			case 32:  // Gay Trainer
				sGayTrainer = 2;
				break;	
			case 33:  // Puppy Trainer
				sPuppyTrainer = 2;
				break;					
		}
		
		// Special Events
		switch (SMSpecialEvent) {
						
			// 1 = Ex-Milk Slave
			case 1:
				SMMinLust = 10;
				break;
	
			// 2 = Tentacle Hybrid
			case 2:
				SMMinCorruption = 5;
				sTentacleExpert = 2;
				SMMinLust = 30;
				break;
				
			// 3 = Converted by Tentacles
			case 3:
				OldGender = 2;
				SMMinLust = 30;
				sTentacleExpert = 1;
				break;
				
			// 4 = Ex-Cowgirl
			case 4:
				SMMinLust = 40;
				BitFlagSM.SetBitFlag(3);
				break;
				
			// 5 = Demonic Cock
			case 5:
				SMMinLust = 30;
				OldGender = 2;
				coreGame.RuinedTemple.SetAccessible();
				break;
	
			// 6 = Inhuman Ancestry
			case 6:
				SMMinCorruption = 5;
				SMMinLust = 10;
				coreGame.RuinedTemple.SetAccessible();
				sTentacleExpert = 1;
				break;
		}
		
		// Home Town Effects
		// Home Town
		// 0 = Coutry Town
		// 1 = Old Faith Stronghold
		// 2 = Amazon Tribe
		// 3 = Mardukane
		// 4 = Caravan
		// 5 = Elven Forest
		// 6 = Dark Elven Capital
		// 7 = True Catgirl Tribe
		switch (SMHomeTown) {
			// 0 = Coutry Town
			// no effects
	
			// 1 = Old Faith Stronghold
			case 1:
				SMCharisma += 2;
				break;
				
			// 2 = Amazon Tribe
			case 2:
				sBowExpertise += 5;
				coreGame.PonygirlsOn = true;
				PonygirlAware = 1;
				if ((coreGame.Options.DickgirlOn == 1 && Gender == 3) || (coreGame.Options.DickgirlOn == 0 && Gender == 2))  {
					SMDominance += 4;
					sNoble = 1;
					SMRefinement -= 2;
				} else {
					SMDominance -= 2;
					SMConstitution += 4;
				}
				break;
	
			// 3 = Mardukane
			case 3:
				SMRefinement += 2;
				break;
	
			// 4 = Caravan
			case 4:
				SMConstitution += 5;
				SMDefence += 5;
				SMRefinement -= 1;
				break;
			
			// 5 = Elven Forest
			case 5:
				SMCharisma += 2;
				break;
				
			// 6 = Dark Elven Capital
			case 6:
				SMDominance += 4;
				break;
	
			// 7 = True Catgirl Tribe
			case 7:
				SMConstitution += 5;
				SMDefence += 5;
				break;
	
		}
	
		// 0 = Slave Trainer 2
		// 1 = Lesbian Trainer 1
		// 2 = Refined 1
		// 3 = Catgirl Trainer 1
		// 4 = Alchemy 1
		// 5 = Trader 1
		// 6 = Pony Trainer 1
		// 7 = Leadership 1
		// 8 = Slut Trainer 1
		// 9 = Gsy Trainer 1
		// 10 = Puppy Trainer
		if (SMSkills.CheckBitFlag(0)) sSlaveTrainer = 2;
		if (SMSkills.CheckBitFlag(1)) {
			if (sLesbianTrainer < 2) sLesbianTrainer = 1;
			coreGame.CuteLesbian.SetAccessible();
		}
		if (SMSkills.CheckBitFlag(2)) sRefined = 1;
		if (SMAdvantages.CheckBitFlag(12) || SMSkills.CheckBitFlag(3)) sCatTrainer = 1;
		if (SMSkills.CheckBitFlag(4)) sAlchemy = 1;
		if (SMSkills.CheckBitFlag(5)) sTrader = 1;
		if (SMSkills.CheckBitFlag(6)) {
			sPonyTrainer = 1;
			coreGame.PonygirlsOn = true;
			PonygirlAware = 1;
			BitFlagSM.SetBitFlag(35);
		}
		if (SMSkills.CheckBitFlag(7) && sLeadership < 1) sLeadership = 1;
		if (SMSkills.CheckBitFlag(8) && sSlutTrainer < 1) sSlutTrainer = 1;
		if (SMSkills.CheckBitFlag(9) && sGayTrainer < 1) sGayTrainer = 1;
		if (SMSkills.CheckBitFlag(10) && sPuppyTrainer < 1) {
			sPuppyTrainer = 1;
			coreGame.modulesList.GetTraining("Puppygirls").SetBitFlag(0);
		}
	
		
		// Advantages
		// 0 = Minor Noble
		// 1 = Noble
		// 2 = Experienced Trader
		// 3 = Weapon Master
		// 4 = Slut
		// 5 = Wealthy
		// 6 = Unnatural Cum
		// 7 = Pagan/Witch
		// 8 = Brothel Madam
		// 9 = Cruel Dominatrix/Master
		// 10 = Dominatrix/Master
		// 11 = Pony Expert
		// 12 = catgirl
		// 13 = Vampire
		// 14 = Furry
		// 15 = Secret Old Faith Worshipper
		// 16 = Attractive to Tentacles
		// 17 = Blunt
		// 18 - Inept Warrior
		// 19 = Fangs & Claws - ok
		// 20 = Chauvinist - ok
		// 21 = Holy
		// 22 = Convincing - ok
		// 23 = Ex-brothel slave
		//      - -5 initial dominance
		//      - +5 minimum lust
		// 24 = Submissive
		//      - -5 initial dominance
		//      - Increased dominance penalty and decreased dominance gain.
		// 25 = Masochist
		//      + Can take more pain than most
		//      - Lusts increases when in pain 
		// 26 = Competitive
		// 27 = Exhibitionist
		if (SMAdvantages.CheckBitFlag(9) || SMAdvantages.CheckBitFlag(10)) sWhipExpertise += 5;
		if (SMAdvantages.CheckBitFlag(7) && Gender != 1) sAlchemy = 1;
		if (SMAdvantages.CheckBitFlag(7)) SMFaith = 2;
		if (SMAdvantages.CheckBitFlag(8)) SMMinLust = 5;
		if (SMAdvantages.CheckBitFlag(0) || SMAdvantages.CheckBitFlag(1)) {
			if (SMAdvantages.CheckBitFlag(0)) sNoble = 1;
			else sNoble = 2;
		}
		if (SMAdvantages.CheckBitFlag(3)) {
			sUnarmedExpertise += 5;
			sBowExpertise += 10;
			sWhipExpertise += 5;
			sSwordExpertise += 10;
			sHammerExpertise += 10;
			sNaginataExpertise += 10;
			sDaggerExpertise += 10;
			sCrossbowExpertise += 10;
			sThrownExpertise += 10;
		}
		if (SMAdvantages.CheckBitFlag(19)) sUnarmedExpertise += 5;
		if (SMAdvantages.CheckBitFlag(14)) BitFlagSM.SetBitFlag(8);
		if (SMAdvantages.CheckBitFlag(12)) BitFlagSM.SetBitFlag(15);
		if (SMAdvantages.CheckBitFlag(11)) SetSlaveOwned("Ponygirl1");

		if (sTentacleExpert > 0) coreGame.TentaclesOn = 1;
		if (SMFaith == 2) coreGame.RuinedTemple.SetAccessible();
		if (SMAdvantages.CheckBitFlag(23)) {
			SMDominance -= 5;
			SMMinLust += 5;
		}
		if (SMAdvantages.CheckBitFlag(24)) SMDominance -= 5;
		if (SMAdvantages.CheckBitFlag(13)) {
			coreGame.SetNocturnal(true);
			SMAdvantages.SetBitFlag(28)
		}

		switch(Talent) {
			case 1:
				SMInitialItems.SetBitFlag(8);
				break;
			case 9:
				SMInitialItems.SetBitFlag(7);
				break;
			case 17:
				SMInitialItems.SetBitFlag(0);
				break;
			case 12:
				SMInitialItems.SetBitFlag(1);
				SetSlaveOwned("Ponygirl1");
				break;
			case 22:
				SMInitialItems.SetBitFlag(5);
				break;
		}
		
		// 0 = Sex Items, all slaves
		// 1 = Ponygirl items, first slave
		// 2 = Ponygirl items, all slaves
		// 3 = catgirl items, first slave
		// 4 = catgirl items, all slaves
		// 5 = 1 dress
		// 6 = sword
		// 7 = leash
		// 9 = whip
		if (SMInitialItems.CheckBitFlag(6)) SetWeaponOwned(1);
		if (SMInitialItems.CheckBitFlag(7)) coreGame.LeashOK = 1;
		if (SMInitialItems.CheckBitFlag(9)) SetWeaponOwned(3);
		if (SMInitialItems.CheckBitFlag(10)) SetArmourOwned(1);
		
		CopySlaveMakerDetails(this, _root);		// TODO remove
	}
	
	// Start a new Slave
	public function StartNewSlave()
	{
		var bFirstSlave:Boolean = (coreGame.GameDate == 1);
		
		switch(Talent) {
			case 0:
				coreGame.SMMoney(300, true);
				break;
			case 5:
				coreGame.HarnessOK = 1;
				break;
			case 12:
				SMInitialItems.SetBitFlag(1);
				SetSlaveOwned("Ponygirl1");
				break;
			case 21:
				coreGame.HarnessOK = 1;
				break;
		}
		
		// 0 = Sex Items, all slaves
		// 1 = Ponygirl items, first slave
		// 2 = Ponygirl items, all slaves
		// 3 = catgirl items, first slave
		// 4 = catgirl items, all slaves
		// 5 = 1 dress
		// 6 = sword
		// 7 = leash
		// 9 = whip
	
		if (SMInitialItems.CheckBitFlag(1)) {
			coreGame.HarnessOK = 1;
			coreGame.BitGagOK = 1;
			coreGame.PonyTailOK = 1;
			coreGame.PonygirlsOn = true;
			PonygirlAware = 1;			
		}
		if (SMInitialItems.CheckBitFlag(4)) {
			coreGame.CatEarsOK = 1;
			coreGame.CatTailOK = 1;
		}
		
		// Special Events
		switch (SMSpecialEvent ) {
			
			// Cowgirl (Astrid)
			case 4:
				BitFlagSM.SetBitFlag(3);
				break;
				
			// 6 = Inhuman Ancestry
			case 6:
				Corruption += 10;
				coreGame.Corruption = Corruption;
				break;
		}

		
		for (var i:Number = 32; i < 64; i++) OtherBooks.ClearBitFlag(i);
		
		// updates from avatar xml
		ParseSMPoints(coreGame.XMLData.GetNode(coreGame.SMAvatar.GetXML(), "Statistics"));
		
		CopySlaveMakerDetails(this, _root);		// TODO remove
	}
	
	// Race - see SMSlaveCommon for values
	
	public function GetRaceId() : Number
	{
		if (SMHomeTown == 5) return 1;
		if (SMHomeTown == 6) return 9;
		if (SMHomeTown == 7) return 2;
		if (SMAdvantages.CheckBitFlag(13)) return 3;
		if (SMAdvantages.CheckBitFlag(14)) return 4;
		return 0;
	}	
	
	public function IsAbleToDoAct(act) : Boolean
	{
		if (DaysUnavailable != 0) return false;
		var acti:ActInfo;
		if (act == undefined && typeof(act) == "number") {
			var actn:Number;
			if (act == undefined) actn = coreGame.ActionChoice;
			else actn = Number(act);
			acti = coreGame.slaveData.ActInfoBase.GetActAbs(actn);
		} else if (act != undefined && typeof(act) == "string") acti = coreGame.slaveData.ActInfoBase.GetActByName(String(act));
		else acti = act;
		
		if (acti.Act == 1009) return false;
		
		if (!acti.IsAbleToDoAct(Gender)) return false;
		return coreGame.XMLData.GetXMLBooleanParsed("Other/SMAbleToDoAct", undefined, true);
	}

	
	// Faith
	// Slavemaker faith

	public function ChangeSlaveMakerFaith(faith:Number)
	{
		if (faith != undefined) {
			coreGame.SMFaith = faith;
			SMFaith = faith;
		}
		coreGame.StatisticsGroup.MoralityLabel.styleSheet = coreGame.styles;
		coreGame.StatisticsGroup.BGMoralityLabel.styleSheet = coreGame.styles;
		if (SMFaith == 2) {
			coreGame.StatisticsGroup.Morality.StatLabel.htmlText = coreGame.Language.GetHtml("Faith", coreGame.statNode);
		} else if (SMFaith == 1) {
			coreGame.StatisticsGroup.Morality.StatLabel.htmlText = coreGame.Language.GetHtml("Morality", coreGame.statNode);
		} else {
			coreGame.StatisticsGroup.Morality.StatLabel.htmlText = coreGame.Language.GetHtml("Ethics", coreGame.statNode);
		}
		coreGame.StatisticsGroup.Morality.BGStatLabel.text = coreGame.StatisticsGroup.Morality.StatLabel.text;
	}

	
	// Potions

	public function GetPotionOwned(potion:Number) : Number
	{
		if (potion < PotionsOwned.length) return PotionsOwned[potion];
		return 0;
	}
	
	public function SetPotionOwned(potion:Number, num:Number)
	{
		var len:Number = PotionsOwned.length;
		if (potion >= len) {
			for (var i:Number = len; i <= potion; i++) PotionsOwned.push(0);
		}
		if (num == undefined) num = 1;
		else if (num < 0) num = 0;
		PotionsOwned[potion] = num;
	}
	
	public function ChangePotionOwned(potion:Number, num:Number)
	{
		var len:Number = PotionsOwned.length;
		if (potion >= len) {
			for (var i:Number = len; i <= potion; i++) PotionsOwned.push(0);
		}
		if (num == undefined) num = 1;
		if ((PotionsOwned[potion] + num) < 0) PotionsOwned[potion] = 0;
		else PotionsOwned[potion] = PotionsOwned[potion] + num;
	}
	
	public function GetLastPotionOwned() : Number { return PotionsOwned.length; }
	
	public function EndGameEffects()
	{
		var sd:Object = coreGame.slaveData;
		if (sd.IsPonygirl()) PonygirlsTrained++;
		if (sd.Sexuality < 25) LesbiansTrained++;
		if (sd.IsCatgirl()) CatgirlsTrained++;
		if (sd.IsPuppygirl()) PuppygirlsTrained++;
		if (sd.DickgirlXF == 2) DickgirlsTrained++;
		if (sd.IsCumslut()) CumslutsTrained++;
		if (sd.IsSuccubus()) SuccubusesTrained++;
		if (sd.VarNymphomania > 90 && sd.VarLibido > 90) SlutsTrained++;	
		
		if (GuildMember) {
			coreGame.VarGold = 0;
			if (SMDebt > 0) {
				SMGold -= SMDebt;
				if (SMGold < 0) {
					SMDebt = SMGold * -1;
					SMGold = 0;
				}
			}
		} else {
			if (SMDebt > 0) {
				coreGame.VarGold -= SMDebt;
				if (coreGame.VarGold < 0) {
					SMDebt = coreGame.VarGold * -1;
					coreGame.VarGold = 0;
				}
			}
		}
		SMGoldSpent = 0;
		SMPoints(0, 0, 0, 0, 0, -30, 0, 0, 0, 0, 0, 0, -90);
		DaysUnavailable = 0;
		coreGame.SMGold = SMGold;
		coreGame.SMGoldSpent = SMGoldSpent;
		coreGame.SMDebt = SMDebt;
		
		// SlaveMaker Education
		if (sd.IsCumslut() && sSlutTrainer < 2) {
			if (SMAdvantages.CheckBitFlag(8)) sSlutTrainer += 0.4;
			else sSlutTrainer += 0.3;
			if (sSlutTrainer > 2) {
				sSlutTrainer = 2;
				coreGame.BlankLine();
				coreGame.XMLData.XMLGeneral("SlaveTrainings/Cumslut/CumslutEducation");
			}
		}
	}
	
	// Measurements
	
	public function SetBustSize(bust:Number)
	{
		vitalsBustSM = bust;
		var max:Number = coreGame.config.GetValue("CommonDefaults/Measurements/Bust");
		if (max > 0 && vitalsBustSM > max) vitalsBustSM = max;
	
		UpdateSlaveMaker();
	}
	
	public function ChangeBustSize(val:Number)
	{
		SetBustSize(Math.ceil(vitalsBustSM * val));
	}
	
	public function SetClitCockSize(clitcock:Number)
	{
		if (clitcock != undefined) {
			ClitCockSizeSM = clitcock;
			var max:Number = coreGame.config.GetValue("CommonDefaults/Measurements/ClitCock");
			if (max > 0 && ClitCockSizeSM > max) ClitCockSizeSM = max;
		}
		if (coreGame.Options.MetricOn) coreGame.SlaveMakerStatisticsGroup.ClitCock.htmlText = (Gender != 2 ? Math.round(ClitCockSizeSM * 33) : (Math.round(ClitCockSizeSM * 10) / 10)) + coreGame.Language.strCM;
		else coreGame.SlaveMakerStatisticsGroup.ClitCock.htmlText = (Gender != 2 ? Math.round(ClitCockSizeSM * 33 / 2.54) : (Math.round(ClitCockSizeSM * 10 / 2.54) / 10)) + coreGame.Language.strIN;
		UpdateSlaveMaker();
	}
	
	public function ChangeClitCockSize(val:Number, mc:Object)
	{
		SetClitCockSize(ClitCockSizeSM * val);
	}
	
	// day/time
	public function NewDay(nDays:Number, endt:Boolean)
	{
		super.NewDay(nDays);
		
		// Health
		coreGame.SMHealth = SMConstitution;
		if (SMAdvantages.CheckBitFlag(25)) coreGame.SMHealth += 20;
		
		// training effects
		if (SMAdvantages.CheckBitFlag(6) && coreGame.TotalAnalToday == 0 && coreGame.TotalBlowJobToday == 0) SMLust = 100;

		// stat changes on a daily basis
		if (endt != true) {
			var condec:Number = SMAdvantages.CheckBitFlag(13) ? -5 * nDays : 0;
			var cinc:Number = 0;
			var smlinc = Gender == 3 ? 10 : 5; //TODO: base off slut/nymphomania
			if (SMNippleRingsOK == 1) smlinc++;
		
			if (SMSpecialEvent == 5 || SMSpecialEvent == 6) cinc = nDays * 2;
			SMPoints(0, 0, 0, condec, nDays, smlinc * nDays, cinc, 0);
		}
		
		// special slaves owned (technically should be in SlaveOwned class)
		var sd:Slave = GetSlaveDetails("Arak", true);
		if (endt != true && sd != null) {
			if (sd.SlaveType == -200) sd.CustomFlag++;
		}
	}
	
	// Items - Wearing/Owning
	
	public function IsItemWorn(item:Number) : Boolean
	{
		// slave maker
		switch(item) {
			case 45: return SMNippleRingsOK == 1;
		}
		return false;
	}
	
	function IsItemAvailable(item:Number) : Boolean
	{
		// slave maker
		switch(item) {
			case 40: return EggOK == 1;
			case 41: return OtherBooks.CheckBitFlag(0);
			case 42: return OtherBooks.CheckBitFlag(1);
			case 43: return RopesOK == 1;
			case 44: return SilkenRopesOK == 1;
			case 45: return SMNippleRingsOK == 1;
			case 46: return SMVanityCaseOK == 1;
			case 47: return SMFeeldoOK;
			case 48: return OtherBooks.CheckBitFlag(2);
			case 49: return OtherBooks.CheckBitFlag(3);
		}
		return false;
	}

	
	public function SetItemOwned(item:Number, own:Boolean)
	{
		if (own == undefined) own = true;
		var flg:Number = own ? 1 : 0;
	
		switch(item) {
			case 40: EggOK = flg; break;
			case 41: 
				own ? OtherBooks.SetBitFlag(0) : OtherBooks.ClearBitFlag(0);
				break;
			case 42: 
				own ? OtherBooks.SetBitFlag(1) : OtherBooks.ClearBitFlag(1);
				break;
			case 43: RopesOK = flg; break;
			case 44: SilkenRopesOK = flg; break;
			case 45: SMNippleRingsOK = flg; break;
			case 46: SMVanityCaseOK = flg; break;
			case 47: SMFeeldoOK = own; break;
			case 48: 
				own ? OtherBooks.SetBitFlag(2) : OtherBooks.ClearBitFlag(2);
				break;
			case 49: 
				own ? OtherBooks.SetBitFlag(3) : OtherBooks.ClearBitFlag(3);
				break;	
		}
	}
	
	// Health
	
	public function ChangeHealth(amt:Number)
	{
		if (amt != undefined) SetHealth(SMHealth + amt);
	}
	public function SetHealth(amt:Number)
	{
		if (amt == undefined) {
			amt = SMConstitution;
			if (SMAdvantages.CheckBitFlag(25)) amt += 20;
		}
		SMHealth = amt;
		var lim:Number = SMConstitution;
		if (SMAdvantages.CheckBitFlag(25)) lim += 20;
		if (SMHealth > lim) SMHealth = lim;
		else if (SMHealth < 0) SMHealth = 0;

		coreGame.SMHealth = SMHealth;
	}	
	
	public function GetHealth() : Number
	{
		if (coreGame.SMHealth != SMHealth) SMHealth = coreGame.SMHealth;
		return SMHealth;
	}

}