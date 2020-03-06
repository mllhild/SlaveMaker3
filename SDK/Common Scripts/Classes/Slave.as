// Slave - class defining a specific slave or assistant 
// This is the full slave version
// Translation status: COMPLETE

import Scripts.Classes.*;

class Slave extends SlaveActions {

	//public var sNode:XMLNode;				// node for slave data, a shortcut reference to save lookups
	//  - see SlaveActions for declaration

	public var SlaveId:Number;				// id number for the SlaveGirlXX.txt file (not saved, ceated from the file)
	public var SlaveIndex:Number;			// strictly temporary (unsaved) index in SlavesArray array
		
	// Properties
	
	// Statistics are in SlaveStatistics class
	// Skills are in SlaveSkills class
	// SlaveType property is in SlaveStatistics
	
	// Gender details
	//public var SlaveGender:Number;			// their gender
	//public var GenderIdentity:Number;		// the gender they identidy with
	//public var SlaveGenderBorn:Number;		// gender at birth
	//public var OldSlaveGender:Number;		// original gender at start of training
	//  - see SlaveStatictics for declaration
	
	public var Available:Boolean;			// is the slave available to train, false and they are hidden from the slave market
	public var CanAssist:Boolean;			// is the slave able to be your assistant

	public var SlaveName:String;			// their name
	public var SlaveName1:String;			// name of first twin
	public var SlaveName2:String;			// name of second twin
	
	public var TrainingStart:Number;		// start of training
	public var IntimacyOK:Boolean;			// will the slave do sex acts
	public var Price:Number;				// price to purchase
	public var SMReputationNeeded:Number;	// slave makers reputation needed to hire/train
	public var SlaveDifficulty:Number;		// general rating of how hard the slave is to train
	
	public var Race:String;

	//public var SlaveFilename:String;		// the filename of the slave's xml/swf file
	//public var ImageFolder:String;			// folder of images, mainly for xml based slaves)
	//  - see SlaveActions for declaration
	public var SlaveImage:String;			// filename for image in the slave market

	// speech mannerisms
	public var SlavePronoun:String;			// Pronoun the slave uses (default "I")
	public var SpeechSuffix:String;			// a suffix they add when they speak
	public var SpeechSuffixChance:Number;	// chance they add the suffix

	// Endings for previous trainings
	public var LastEnding:Number;
	public var Endings:Array;

	public var bSupervisedToday:Boolean;
	
	public var VirginVaginal:Boolean;
	public var VirginAnal:Boolean;
	public var VirginOral:Boolean;

	public var Milkable:Boolean;
	
	// Love
	// 	   -1 = confessed but too many lovers
	//  	0 = not confessed
	//		1 = confessed and accepted.
	// 	   10 = confessed and accepted (Ayane special)
	public var LoveAccepted:Number;

	public var NobleLoveType:Number;
	public var NobleLove:Number;

	public var EventBoyfriend:Number;
	public var OldLover:Number;

	// other flags and variables
	
	public var BitFlag1:BitFlags;
	public var BitFlag2:BitFlags;
	public var DemonFlags:BitFlags;

	public var FairyMeeting:Number;
	
	public var TotalProstituteParty:Number;
	public var TotalHighClassParty:Number;

	public var MaxAstrid:Number;
	public var VarIdol:Number;
	public var VarSchoolGirl:Number;
	public var PuppyGirlFlag:Number;

	public var CustomFlag:Number;
	public var CustomFlag1:Number;
	public var CustomFlag2:Number;
	public var CustomFlag3:Number;
	public var CustomFlag4:Number;
	public var CustomFlag5:Number;
	public var CustomFlag6:Number;
	public var CustomFlag7:Number;
	public var CustomFlag8:Number;
	public var CustomFlag9:Number;
	public var CustomString:String;

	public var LesbianInterest:Number;
	public var PonygirlInterest:Number;
	public var CatgirlInterest:Number;
	public var PuppygirlInterest:Number;
	public var SuccubusInterest:Number;

	public var DoneTentacleHarem:Number;

	public var CurrentPath:Number;
	public var MaxPath:Number;// Calculated maximum of Path1, 2, 3
	public var Path1:Number;
	public var Path2:Number;
	public var Path3:Number;

	// Contests
	//public var DifficultyXXXContest:Number;
	//  - see SlaveActions for declaration
	public var WinXXX:Number;
	public var WinHousework:Number;
	public var WinCourt:Number;
	public var WinBeauty:Number;
	public var WinPonygirl:Number;
	public var WinDance:Number;
	public var WinCustom:Number;
	public var WinGeneralKnowledge:Number;
	public var WinHouseworkAdvanced:Number;
	public var TotalContestCustom:Number;
	public var TotalContestXXX:Number;
	public var TotalContestHousework:Number;
	public var TotalContestHouseworkAdvanced:Number;
	public var TotalContestCourt:Number;
	public var TotalContestBeauty:Number;
	public var TotalContestPonygirl:Number;
	public var TotalContestDance:Number;
	public var TotalContestGeneralKnowledge:Number;

	// Owner
	public var Owner:PersonOwner;
	public var StartOwner:PersonOwner;

	// Custom save data
	public var arSaveVars:Array;		// generic variables to load/save, unrestricted number
	
	// Twins
	public var slave1Data:Slave;
	public var slave2Data:Slave;

	// Methods

	// Constructor
	public function Slave(cg:Object) {
		super(cg);

		// basic initialise
		Endings = null;

		arSaveVars = null;
		DemonFlags = null;

		BitFlag1 = null;
		BitFlag2 = null;

		Owner = null;
		StartOwner = null;

		SlaveName = "";
		SlaveName1 = "";
		SlaveName2 = "";
		SlaveType = 0;
		ImageFolder = "";
		SlaveFilename = "";
		SlaveImage = "";
		
		slave1Data = null;
		slave2Data = null;

		// now actually initialise
		Reset();
		
		LastEnding = -10;
	}
	// Initialise all variables for the slave
	public function Reset() {
		
		super.Reset();
		
		if (arSaveVars != null) {
			delete arSaveVars;
			arSaveVars = null;
		}

		if (BitFlag1 != null) delete BitFlag1;
		if (BitFlag2 != null) delete BitFlag2;
		BitFlag1 = new BitFlags;
		BitFlagC = BitFlag1;
		BitFlag2 = new BitFlags;
		if (coreGame.RapeOn) BitFlag1.SetBitFlag(90);
		if (coreGame.TentaclesOn == 1) BitFlag1.SetBitFlag(91);

		if (Owner != null) {
			delete Owner;
			Owner = null;
		}
		if (StartOwner != null) {
			delete StartOwner;
			StartOwner = null;
		}
		if (DemonFlags != null) {
			delete DemonFlags;
			DemonFlags = null;
		}
		
		Available = true;

		Price = 200;
		IntimacyOK = true;
		SlaveDifficulty = 0;
		SlaveIndex = -1;

		SlavePronoun = coreGame.Language.strDefPronoun;
				
		DifficultyXXXContest = 35;
		
		CustomFlag = -1;
		CustomFlag1 = -1;
		CustomFlag2 = -1;
		CustomFlag3 = -1;
		CustomFlag4 = -1;
		CustomFlag5 = -1;
		CustomFlag6 = -1;
		CustomFlag7 = -1;
		CustomFlag8 = -1;
		CustomFlag9 = -1;
				
		DateLastAphrodisiac = -1;
		
		LesbianInterest = 1;
		PonygirlInterest = 1;
		CatgirlInterest = 1;
		PuppygirlInterest = 1;
		SuccubusInterest = 2;

		MaxAstrid = 10;
		
		ClitCockSize = 0.6;
		ClitCockSizeStart = 0.6;

		Fertility = coreGame.config.nDefaultFertility;
		
		TrainingStart = coreGame.GameDate;

		CanAssist = false;

		SpeechSuffix = "";
		SpeechSuffixChance = 0;

		VarIdol = 0;
		VarSchoolGirl = 0;
		OldLover = 0;
		PuppyGirlFlag = 0;

		WinXXX = 0;
		WinHousework = 0;
		WinCourt = 0;
		WinBeauty = 0;
		WinPonygirl = 0;
		WinDance = 0;
		WinCustom = 0;
		WinGeneralKnowledge = 0;
		WinHouseworkAdvanced = 0;
		TotalContestCustom = 0;
		TotalContestXXX = 0;
		TotalContestHousework = 0;
		TotalContestHouseworkAdvanced = 0;
		TotalContestCourt = 0;
		TotalContestBeauty = 0;
		TotalContestPonygirl = 0;
		TotalContestDance = 0;
		TotalContestGeneralKnowledge = 0;

		CustomString = "";
		NobleLove = 0;
		EventBoyfriend = 0;

		MilkInfluence = 0;
		Milkable = false;
		Lactation = 0;
		BreastFixation = 0;
		MilkBuildUp = 0;

		LoveAccepted = 0;
		NumAphrodisiac = 0;
		
		NobleLoveType = 0;
		FairyMeeting = 0;

		VirginVaginal = false;
		VirginAnal = false;
		VirginOral = false;

		TotalProstituteParty = 0;
		TotalHighClassParty = 0;

		DoneTentacleHarem = 0;

		CurrentPath = 0;
		Path1 = 0;
		Path2 = 0;
		Path3 = 0;

		bSupervisedToday = false;

		DaysUnavailable = 0;

		SMReputationNeeded = 0;
		
		Race = coreGame.Language.strHuman + "";
		
		if (slave1Data != null) delete slave1Data;
		if (slave2Data != null) delete slave2Data;
		slave1Data = null;
		slave2Data = null;
	}
	
	// Naming
	
	public function GetFullName() : String
	{
		if (Titles != "") return Titles + " " + SlaveName;
		return SlaveName;
	}
	
	// Images
	
	public function ShowMarketImage(place:Number, align:Number, gframe:Number, target:MovieClip) { coreGame.ShowSlave(this, place, align, gframe, target); }


	
	// Identity	
	public function IsSlaveDetails(slave:String, slnosp:String) : Boolean
	{
		var slchk:String;
		var sl:Array;
		var slwr:String = slave.toLowerCase();
		var slwrnx:String = slwr.split(".")[0];
		var snolwr:String = slnosp.split(".")[0].toLowerCase();
		var bSlashes = slwr.indexOf("/") != -1;

		//trace("IsSlaveDetails: image " + slwr + " " + snolwr + " " + SlaveImage);
				
		// first try image, it is the most unique
		if (SlaveImage != "") {
			if (SlaveImage.toLowerCase() == slwr) return true;
			if (bSlashes) continue;
			sl = SlaveImage.split("/");
			slchk = sl[sl.length - 1].split(".")[0].toLowerCase();
			//trace("...image: " + slchk.split(" ").join(""));
			if (slchk.substr(0, 9) != "assistant") {
				if (slchk.split(" ").join("") == snolwr) return true;			
				sl = slchk.split("-");
				slchk = sl[sl.length - 1];
				//trace("..." + slchk.split(" ").join(""));
				if (slchk.split(" ").join("") == snolwr) return true;
			}
		}
				
		// try the folder the slaves data is in
		//trace("IsSlaveDetails: folder " + slwr + " " + snolwr + " " + ImageFolder);
		if (ImageFolder != "") {
			if (ImageFolder.toLowerCase() == slwr) return true;
			if (bSlashes) continue;
			sl = ImageFolder.split("/");
			slchk = sl[sl.length - 1];
			//trace("...folderL " + slchk.split(" ").join(""));
			sl = slchk.toLowerCase().split("-");
			slchk = sl[sl.length - 1];
			if (slchk.split(" ").join("") == snolwr) return true;
		}
		
		// try the slaves name
		if (!bSlashes) {
			slchk = SlaveMaker.ProcessSlaveName(slwr);
			//trace("IsSlaveDetails: name " + slchk + " " + SlaveName);
			if (SlaveName.toLowerCase() == slchk) return true;
			if (SlaveName.toLowerCase().split(" ").join("") == slchk.toLowerCase().split(" ").join("")) return true;
		}
		
		// lastly try the slaves filename
		if (SlaveFilename == "") return false;
		if (SlaveFilename.toLowerCase() == slwr) return true;
		if (bSlashes) return false;
		sl = SlaveFilename.split("/");
		slchk = sl[sl.length - 1].split(".")[0];
		sl = slchk.toLowerCase().split("-");
		slchk = sl[sl.length - 1];
		return (slchk.split(" ").join("") == snolwr);
	}

	public function IsSlave(slave) : Boolean {
		if (typeof(slave) != "string") return this == slave;
		slave = slave.split(".")[0].toLowerCase();
		var sl:Array = slave.split("-");
		slave = sl[sl.length - 1];
		return IsSlaveDetails(slave, slave.split(" ").join(""));
	}
	
	// Status
	public function IsSlaveTrained() : Boolean { return SlaveType == 1 || SlaveType == 0; }

	public function IsSlaveOwned(slave:String) : Boolean
	{
		return ((SlaveType == 1 && CanAssist == true) || SlaveType == 0 || SlaveType == 2);
	}
	
	public function IsSlaveAvailable() : Boolean { return Available; }

	public function IsSlaveForSale() : Boolean
	{
		if (Price == 0) return false;
		
		// inlined IsSlaveOwned()
		if ((SlaveType == 1 && CanAssist == true) || SlaveType == 0 || SlaveType == 2 || SlaveType == -200) return false;
		// partial inline IsSlaveAvailable()
		if (!Available) return false;

		if (coreGame.DickgirlOn == 0 && (SlaveGender == 3 || SlaveGender == 6)) return false;

		var avNode:XMLNode = coreGame.XMLData.GetNode(GetSlaveXML(), "Available");
		if (avNode != null && coreGame.ParseConditional(avNode, true, false) == null) return false;
		return true;
	}
	
	public function IsSlaveMinor() : Boolean { return SlaveType == 0; }
	
	public function SetSlaveAvailable(avail:Boolean)
	{
		if (avail == undefined) avail = true;
		Available = avail;
		coreGame.SMData.BuildOwnedSlaves();
	}
	
	public function IsSlaveTrainedStandard(ab:String) : Boolean
	{
		ab = ab.toLowerCase();
		if (ab == "ponygirl" && IsPonygirl()) return true;
		if (ab == "catgirl" && IsCatgirlComplete()) return true;
		if (ab == "puppygirl" && IsPuppygirlComplete()) return true;
		if ((ab == "faerie" || ab == "fairy") && IsFairyComplete()) return true;
		if (ab == "courtesan" && DoneCourtesan) return true;
		return false;
	}
	public function IsSlaveTrainedAsSingle(ab:String, str:String) : Boolean
	{
		var ar:Array = ab.toLowerCase().split("|");
		for (var i:Number = 0; i < ar.length; i++) {
			if (str.indexOf(ar[i]) != -1 || IsSlaveTrainedStandard(ar[i])) return true;
		}
		return false;
	}
	public function IsSlaveTrainedAs(ab1:String, ab2:String) : Boolean
	{
		var str:String = coreGame.XMLData.GetXMLStringParsed("Trainings", GetSlaveXML(), "").toLowerCase();
		
		if (ab1 != "" && ab1 != undefined) {
			if (!IsSlaveTrainedAsSingle(ab1, str)) return false;
		} 
		if (ab2 != "" && ab2 != undefined) {
			if (!IsSlaveTrainedAsSingle(ab2, str)) return false;
		}
		return true;
	}
	
	public function ChangeSlaveType(type:String)
	{
		type = type.toLowerCase();	// assistant, minor, untrained		
		if (type == "assistant") {
			if (SlaveType == -2 || SlaveType == -20) {
				SlaveType = -1;
				CanAssist = false;
			} else CanAssist = true;
			Available = true;
		} else if (type == "minor" || type == "minorslave") SlaveType = 0;
		else if (type == "untrained") {
			SlaveType = -100;
			CanAssist = false;
		}
	}
	
	// Other trainings
	// see Slaveskills class
	
	public function IsMasochistTraining() : Boolean
	{
		return BitFlag1.CheckBitFlag(18);
	}
	
	// Stat updaters
	public function AlterSexuality(sex:Number)
	{
		coreGame.UpdateFactors(this);

		var nv:Number = Sexuality + (sex * coreGame.SexualityFactor);
		
		if (LesbianInterest != -1) {
			if (Sexuality < 25 && nv >= 25) nv = 24;
			else if (Sexuality >= 25 && nv < 25) nv = 25;
			else if (Sexuality <= 75 && nv > 75) nv = 76;
		}
		
		Sexuality = nv;
		if (Sexuality < 0) Sexuality = 0;
		if (Sexuality > 100) Sexuality = 100;
		if (IsDisplayed()) coreGame.dspMain.UpdateSexuality(Sexuality);

	}

	public function SetSexuality(newsexuality:Number) 
	{
		Sexuality = newsexuality;
		AlterSexuality(0);
	}
		
	public function ChangePath(p1:Number,p2:Number,p3:Number) {
		Path1 += p1;
		if (p2 != undefined) {
			Path2 += p2;
			if (p3 != undefined) Path3 += p3;
		}
	}
	public function UpdateCurrentPath() {
		if (Path3 > Path2 && Path3 > Path1) MaxPath = 3;
		else if (Path2 > Path1 && Path2 > Path3) MaxPath = 2;
		else if (Path1 > Path2 && Path1 > Path3) MaxPath = 1;
		else MaxPath = 0;
		CurrentPath = MaxPath;
	}
	
	public function SetGirlsVitals(sname:String, desc:String, bust:Number, waist:Number, hips:Number, age:Number, bloodtype:String, tall:Number, weight:Number, clitcock:Number, birthday:Number)
	{
		if (sname != undefined) {
			SlaveName = sname;
			SlaveName1 = sname;
			SlaveName2 = sname;
		}
		super.ssSetGirlsVitals(desc, bust, waist, hips, age, bloodtype, tall, weight, clitcock, birthday);
	}
		
	// Love and Marriage
	public function IsInLove() : Boolean { return LoveAccepted == 1 || LoveAccepted == 10; }
	public function IsMarried() : Boolean { return BitFlag1.CheckBitFlag(61); }
	public function IsProposed() : Boolean { return BitFlag1.CheckBitFlag(60); }
	
	// Impregnate
	public function Impregnate(type:String, count:Number, gestation:Number)
	{
		if (SlaveGender == 0 || SlaveGender == 1 || SlaveGender == 4 || !super.CanImpregnate(type)) return;

		DateImpregnated = coreGame.GameDate;
		if (type.toLowerCase() == "yours" && coreGame.SMData.SMSpecialEvent == 2) type = "YoursTentacle";
		PregnancyType = type;
		if (gestation == undefined) {
			if (type.toLowerCase() == "human" || type.toLowerCase() == "yours") {
				var gest:Number = coreGame.XMLData.GetXMLValue("BaseGestation", GetSlaveXML(), coreGame.config.nBaseGestation);
				PregnancyGestation = gest + Math.floor(Math.random()*10);
				if (IsTrueCatgirl()) PregnancyGestation -= 30;
				if (IsElf()) PregnancyGestation += 60;
			} else PregnancyGestation = 28 + Math.floor(Math.random()*5);
		} else PregnancyGestation = gestation;
		
		if (count == undefined) {
			if (IsElf()) PregnancyCount = slrandom(slrandom(slrandom(slrandom(2))));
			else if (IsTrueCatgirl()) PregnancyCount = int(3 * ((Math.random() + Math.random() + Math.random() + Math.random() + Math.random()) / 5)) + 1;
			else PregnancyCount = slrandom(slrandom(2));
		}
		else PregnancyCount = count;
	}
	
	public function CanImpregnate(type:String) : Boolean
	{
		if (type.toLowerCase() == "yours" && coreGame.SMData.SMSpecialEvent == 2) type = "YoursTentacle";

		if (SlaveGender == 0 || SlaveGender == 1 || SlaveGender == 4 || !super.CanImpregnate(type)) return false;

		var fer:Number = Fertility;
		if (!BitFlag1.CheckBitFlag(14)) fer = 0;
		return (coreGame.PercentChance(fer) || type.toLowerCase() == "tentacle" || type.toLowerCase() == "tentacles");
	}	
														
	// Speech

	public function AddSpeechSuffix(chance:Number,suff:String) 
	{
		SpeechSuffix = suff;
		SpeechSuffixChance = chance == undefined ? 100 : chance;
	}
	
	private function SlaveSpeakStartCommon(pstring:String, say:String, newl:Boolean)
	{
		coreGame.Language.bSpeaking = true;
		if (newl != true) coreGame.SetText("");
		if (BitGagWorn == 1 && !BitFlag1.CheckBitFlag(63) && coreGame.AssistantData != this) {	
			coreGame.Language.AddLangText(coreGame.IsNoAssistant() ? "RemoveGagSM" : "RemoveGag", "Speech");
			coreGame.AddText("\r");
		}
		if (!coreGame.XMLData.IsHandlingEvent()) {
			if (!coreGame.LargerTextField._visible && coreGame.GeneralTextField._height > 230) coreGame.ShowLargerText();
		}
		if (BitFlag1.CheckBitFlag(63)) pstring += " " + coreGame.Language.GetText("Writes", "Speech");
		coreGame.AddText("<b>"+pstring + ":</b>\r<ps>\"" + say);
	}
	
	public function SlaveSpeakStart(say:String, newl:Boolean) { SlaveSpeakStartCommon(SlaveName, say, newl); }	
	public function Slave1SpeakStart(say:String, newl:Boolean) { SlaveSpeakStartCommon(SlaveName1, say, newl); }
	public function Slave2SpeakStart(say:String, newl:Boolean) { SlaveSpeakStartCommon(SlaveName2, say, newl); }
	
	public function SlaveSpeakEnd(say:String)
	{
		if (!coreGame.Language.bSpeaking) return;
		if (say != undefined) coreGame.AddText(say);
		if (coreGame.PercentChance(SpeechSuffixChance)) coreGame.PersonSpeakEnd(" " + SpeechSuffix + ".");
		else if (IsCatgirl()) coreGame.PersonSpeakEnd(" " +coreGame. Language.GetText("Catgirl", "Speech"));
		else if (IsPonygirl()) coreGame.PersonSpeakEnd(" " + coreGame.Language.GetText("Ponygirl", "Speech"));
		else if (IsPuppygirl()) coreGame.PersonSpeakEnd(" " + coreGame.Language.GetText("Puppygirl", "Speech"));
		else coreGame.PersonSpeakEnd();
	}
	
	public function SlaveSpeak(say:String, newl:Boolean)
	{
		SlaveSpeakStart(say, newl);
		SlaveSpeakEnd();
	}
	
	public function Slave1Speak(say:String, newl:Boolean)
	{
		Slave1SpeakStart(say, newl);
		SlaveSpeakEnd();
	}
	
	public function Slave2Speak(say:String, newl:Boolean)
	{
		Slave2SpeakStart(say, newl);
		SlaveSpeakEnd();
	}
			
		
	// Copy data from/to this object
	// sdFrom and sdTo can be Object types (for load/save cases(
	public function CopyCommonDetails(sdFrom:Object, sdTo:Object) 
	{
		if (sdTo == undefined) sdTo = this;
		
		super.CopyCommonDetails(sdFrom, sdTo);

		sdTo.SlaveType = sdFrom.SlaveType;
		sdTo.CanAssist = sdFrom.CanAssist;

		sdTo.SlaveGender = sdFrom.SlaveGender;
		sdTo.GenderIdentity = sdFrom.GenderIdentity;
		sdTo.SlaveGenderBorn = sdFrom.SlaveGenderBorn;
		sdTo.OldSlaveGender = sdFrom.OldSlaveGender;
		sdTo.SlaveFilename = sdFrom.SlaveFilename + "";
		sdTo.ImageFolder = sdFrom.ImageFolder + "";		
		sdTo.Race = sdFrom.Race + "";

		sdTo.SlavePronoun = sdFrom.SlavePronoun;
		sdTo.SpeechSuffix = sdFrom.SpeechSuffix + "";
		sdTo.SpeechSuffixChance = sdFrom.SpeechSuffixChance;
		
		sdTo.TrainingStart = sdFrom.TrainingStart;

		sdTo.LesbianInterest = sdFrom.LesbianInterest;
		sdTo.PonygirlInterest = sdFrom.PonygirlInterest;
		sdTo.CatgirlInterest = sdFrom.CatgirlInterest;
		sdTo.PuppygirlInterest = sdFrom.PuppygirlInterest;
		sdTo.SuccubusInterest = sdFrom.SuccubusInterest;

		sdTo.LoveAccepted = sdFrom.LoveAccepted;
		sdTo.Path1 = sdFrom.Path1;
		sdTo.Path2 = sdFrom.Path2;
		sdTo.Path3 = sdFrom.Path3;
		sdTo.CurrentPath = sdFrom.CurrentPath;

		sdTo.VirginVaginal = sdFrom.VirginVaginal;
		sdTo.VirginAnal = sdFrom.VirginAnal;
		sdTo.VirginOral = sdFrom.VirginOral;
		coreGame.SetGirlsVitals(sdFrom.SlaveName, sdFrom.vitalsDescription, sdFrom.vitalsBust,sdFrom.vitalsWaist,sdFrom.vitalsHips,sdFrom.vitalsAge,sdFrom.vitalsBloodType,sdFrom.vitalsHeight,sdFrom.vitalsWeight,sdFrom.ClitCockSize, sdFrom.Birthday, sdTo);

		sdTo.vitalsBustStart = sdFrom.vitalsBustStart;
		sdTo.ClitCockSizeStart = sdFrom.ClitCockSizeStart;

		sdTo.NumAphrodisiac = sdFrom.NumAphrodisiac;

		sdTo.NobleLove = sdFrom.NobleLove;
		sdTo.NobleLoveType = sdFrom.NobleLoveType;
		sdTo.VarIdol = sdFrom.VarIdol;
		sdTo.PuppyGirlFlag = sdFrom.PuppyGirlFlag;
		sdTo.VarSchoolGirl = sdFrom.VarSchoolGirl;
		sdTo.EventBoyfriend = sdFrom.EventBoyfriend;

		sdTo.FairyMeeting = sdFrom.FairyMeeting;

		sdTo.DifficultyXXXContest = sdFrom.DifficultyXXXContest;

		sdTo.WinXXX = sdFrom.WinXXX;
		sdTo.WinHousework = sdFrom.WinHousework;
		sdTo.WinHouseworkAdvanced = sdFrom.WinHouseworkAdvanced;
		sdTo.WinCourt = sdFrom.WinCourt;
		sdTo.WinBeauty = sdFrom.WinBeauty;
		sdTo.WinPonygirl = sdFrom.WinPonygirl;
		sdTo.WinCustom = sdFrom.WinCustom;
		sdTo.WinDance = sdFrom.WinDance;
		sdTo.WinGeneralKnowledge = sdFrom.WinGeneralKnowledge;
		sdTo.TotalContestXXX = sdFrom.TotalContestXXX;
		sdTo.TotalContestHousework = sdFrom.TotalContestHousework;
		sdTo.TotalContestHouseworkAdvanced = sdFrom.TotalContestHouseworkAdvanced;
		sdTo.TotalContestCourt = sdFrom.TotalContestCourt;
		sdTo.TotalContestBeauty = sdFrom.TotalContestBeauty;
		sdTo.TotalContestPonygirl = sdFrom.TotalContestPonygirl;
		sdTo.TotalContestDance = sdFrom.TotalContestDance;
		sdTo.TotalContestGeneralKnowledge = sdFrom.TotalContestGeneralKnowledge;
		sdTo.TotalContestCustom = sdFrom.TotalContestCustom;

		sdTo.CustomFlag = sdFrom.CustomFlag;
		sdTo.CustomFlag1 = sdFrom.CustomFlag1;
		sdTo.CustomFlag2 = sdFrom.CustomFlag2;
		sdTo.CustomFlag3 = sdFrom.CustomFlag3;
		sdTo.CustomFlag4 = sdFrom.CustomFlag4;
		sdTo.CustomFlag5 = sdFrom.CustomFlag5;
		sdTo.CustomFlag6 = sdFrom.CustomFlag6;
		sdTo.CustomFlag7 = sdFrom.CustomFlag7;
		sdTo.CustomFlag8 = sdFrom.CustomFlag8;
		sdTo.CustomFlag9 = sdFrom.CustomFlag9;
		sdTo.CustomString = sdFrom.CustomString;

		sdTo.TotalMilked = sdFrom.TotalMilked;
		sdTo.MilkInfluence = sdFrom.MilkInfluence;
		sdTo.Lactation = sdFrom.Lactation;
		sdTo.BreastFixation = sdFrom.BreastFixation;
		sdTo.MilkBuildUp = sdFrom.MilkBuildUp;

		sdTo.DoneTentacleHarem = sdFrom.DoneTentacleHarem;

		sdTo.MaxAstrid = sdFrom.MaxAstrid;

		delete sdTo.PotionsUsed;
		sdTo.PotionsUsed = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		var len:Number = sdFrom.PotionsUsed.length;
		if (len != undefined) {
			for (var i:Number = 0; i < len; i++) {
				sdTo.PotionsUsed[i] = sdFrom.PotionsUsed[i];
			}
		}

		sdTo.OldMorality = sdFrom.OldMorality;
		sdTo.OldObedience = sdFrom.OldObedience;
		sdTo.OldIntelligence = sdFrom.OldIntelligence;
		sdTo.OldVarTemperament = sdFrom.OldVarTemperament;

		sdTo.Order1 = sdFrom.Order1;
		sdTo.Order2 = sdFrom.Order2;
		sdTo.bSupervisedToday = sdFrom.bSupervisedToday;

		sdTo.Available = sdFrom.Available;

		sdTo.OldLover = sdFrom.OldLover;
		
		// upgrades
		if (sdFrom.DifficultyFootjob == undefined) {
			sdTo.DifficultyHandjob = sdTo.DifficultyBlowjob - 5;
			sdTo.DifficultyFootjob = sdTo.DifficultyBlowjob - 3;
			sdTo.Difficulty69 = sdTo.DifficultyBlowjob - 3;
			sdTo.DifficultyCumBath = sdTo.DifficultyGangBang - 5;
			sdTo.DifficultyOrgy = sdTo.DifficultyGangBang - 10;
		}
	}
	
	// Acts
	
	public function IsAbleToDoAct(act) : Boolean
	{
		if (IntimacyOK == false || DaysUnavailable != 0) return false;
		var acti:ActInfo;
		if (act == undefined || typeof(act) == "number") {
			var actn:Number;
			if (act == undefined) actn = coreGame.ActionChoice;
			else actn = Number(act);
			acti = coreGame.slaveData.ActInfoBase.GetActAbs(actn);
		} else if (act != undefined && typeof(act) == "string") acti = coreGame.slaveData.ActInfoBase.GetActByName(String(act));
		else acti = act;
		
		// special cases for tutoring
		if (acti.Act == 1009) return IsSlaveTrainedAs("Dancer", "Tutor");

		if (!acti.IsAbleToDoAct(SlaveGender)) return false;
		return coreGame.XMLData.GetXMLBooleanParsed("Other/AbleToDoAct", GetSlaveXML(), true);
	}	

	// Obedience
	public function IsObedient(diff:Number, act:Number) : Boolean
	{
		if (Slutiness > 8 || diff <= 0) return true;
		act = int(Math.abs(act));
		var tmp:Number = Math.round(VarObedience - int(VarIntelligence/40));
		if (coreGame.SMData.SMFaith == 1) tmp -= Math.floor(VarMorality/40);
		if (coreGame.SMData.SMAdvantages.CheckBitFlag(22)) tmp += 5;
		tmp -= Math.floor(VarTemperament/40) + (Math.floor(VarFatigue/40));
		tmp += Math.floor(VarJoy/40) + Math.floor(VarNymphomania/40) + Math.floor(VarLovePoints/40);
		diff += Math.floor(Math.random()*2);
		if (act == 7 || act == 8 || act == 20 || act == 19 || act == 2 || act == 3 || act == 4 || act == 5 || act == 6 || act == 15 || act == 19) {
			if (tmp >= diff || VarLibido >= diff*2) return true;
		} else if (tmp >= diff) return true;
	
		if (act != undefined && SlaveType == -10) {
			if (coreGame.AnySex && act < 1000 && act != 14 && act != 17 && act != 16) {
				coreGame.AnySex = false;
				return true;
			}
			if (coreGame.AnyNonSex && act > 999) {
				coreGame.AnyNonSex = false;
				return true;
			}
		}
		return false;
	}
	
	// Race
	
	// a general string, but there is a set of standard values than can be accessed bu number, see SlaveMaker class and Base.xml
	public function GetRace() : String { return Race; }
	public function GetRaceId() : Number { 
		var ret:Number = DecodeRaceNum(Race); // see SMSlaveCommon for values
		return ret == -1 ? 0 : ret;
	}

	// Personality
	
	public function CheckDefaultPersonality() { super.DefaultPersonality(this); }
	
	public function CalculateScore(newscore:Number) : Number
	{
		var Score:Number = newscore == undefined ? 0 : newscore;
		if (SlaveType == -10) {
			if (!IsSlave("Shampoo")) {
				if (LoveAccepted == 1 || LoveAccepted == 10) {
					if (coreGame.SMData.sLeadership > 0){
						if (coreGame.SMData.sLeadership < 3) Score -= (20 - (coreGame.SMData.sLeadership * 5));
					} else Score -= 20;
				}
			}
			if (Owner != null) {
				if (coreGame.SMData.GuildMember && StartOwner != null) {
					if (Owner.GetOwner() != StartOwner.GetOwner()) Score -= 20;
				}
			}
		}
		if (IsPonygirl()) Score += 10;
		if (DoneCourtesan) Score += 20;
		if (IsCatgirlComplete()) Score += 15;
		if (IsPuppygirlComplete()) Score += 10;
		if (BitFlag1.CheckBitFlag(46)) Score += 5;
		if (coreGame.Elapsed > 16) {
			if (VirginVaginal && VirginAnal && VirginOral) Score += 1000;
			else if (IsFemale() && VirginVaginal) Score += 500;
		}
		return Score;
	}
	
	public function CalculateTotalScore() : Number
	{
		var Score:Number = VarCharisma + VarSensibility + VarRefinement + VarIntelligence + VarMorality + VarConstitution + VarCooking + VarCleaning + VarConversation + VarBlowJob + VarFuck + VarTemperament + VarNymphomania + VarObedience + VarLibido + VarJoy + VarReputation + VarLovePoints;
		Score = Math.floor(Score / 18);
		Score = CalculateScore(Score);
		return Score;
	}
	
	public function CalculateValue(score:Number) : Number
	{
		if (score == undefined) score = CalculateTotalScore();
		var pay:Number = score * 10;
		if (coreGame.SMData.sTrader > 0) pay *= 1 + (coreGame.SMData.sTrader * 0.05);
		return pay;
	}
	
	// Load/Save
	public function Load(so:Object) {
		//coreGame.LoadSave.CleanSaveGame(so);

		super.Load(so);

		LastEnding = so.LastEnding;
		SlaveName = so.SlaveName;
		SlaveName1 = so.SlaveName1;
		SlaveName2 = so.SlaveName2;
		if (SlaveName1 == undefined || SlaveName1 == "") {
			SlaveName1 = SlaveName;
			SlaveName2 = SlaveName;
		}
		IntimacyOK = so.IntimacyOK;

		var len:Number = so.Endings.length;
		if (so.Endings != undefined && len != 0) {
			var nze:Number = 0;
			for (var i:Number = 0; i < len; i++) {
				if (so.Endings[i] != 0) {
					nze++;
				}
			}
			if (nze != 0) {
				Endings = new Array();
				for (var i:Number = 0; i < len; i++) {
					Endings[i] = so.Endings[i];
				}
			}
		}

		BitFlag1.Load(so.BitFlag1);
		BitFlag2.Load(so.BitFlag2);

		if (so.Owner != undefined) {
			delete Owner;
			Owner = new PersonOwner(this, coreGame);
			Owner.Load(so.Owner);
		}
		if (so.StartOwner != undefined) {
			delete StartOwner;
			StartOwner = new PersonOwner(null, coreGame);
			StartOwner.Load(so.StartOwner);
		}
		if (so.DemonFlags != undefined) {
			delete DemonFlags;
			DemonFlags = new BitFlags();
			DemonFlags.Load(so.DemonFlags);
		}
		if (so.arSaveVars != undefined) {
			//trace("load save vars");
			len = so.arSaveVars.length;
			if (len == undefined) len = 0;
			if (len != 0) {
				var idx:Number;
				arSaveVars = new Array();
				for (var j:Number = 0; j < len; j++) {
					if (typeof(so.arSaveVars[j]) == "string") {
						idx = arSaveVars.push("");
						arSaveVars[idx - 1] = so.arSaveVars[j] + "";
					} else {
						arSaveVars.push(so.arSaveVars[j]);
					}
				}
			}
		}

		SlaveImage = so.SlaveImage + "";
		
		CopyCommonDetails(so, this);
			
		// Twins Data
		if (so.Slave1 != undefined) {
			slave1Data = new Slave(coreGame);
			slave1Data.Load(so.Slave1);
		}
		if (so.Slave2 != undefined) {
			slave2Data = new Slave(coreGame);
			slave2Data.Load(so.Slave2);
		}		
		
		// upgrades
		if (ImageFolder == undefined) ImageFolder = "";
		if (SlaveName == "Cumslut Kasumi") sSlutTrainer = 2;
		if (SlaveImage == "" || SlaveImage == undefined) SlaveImage = SlaveFilename.slice(0,-4) + ".png";
		if (typeof(so.Race) == "number") Race = coreGame.SMData.DecodeRaceId(so.Race);
		if (Race == "" || typeof(Race) == "number" || Race == undefined || Race == "undefined") Race = DecodeRaceId(0) + "";
		if (SlavePronoun == coreGame.Language.strDefPronoun && SlaveGender > 3) SlavePronoun = coreGame.Language.strPronounTwins;
		if (slPuppyTraining == undefined) slPuppyTraining = 0;
		if (PuppygirlInterest == undefined) PuppygirlInterest = 0;
		if (GenderIdentity == undefined) GenderIdentity = SlaveGender;
		if (DateImpregnated == undefined) {
			if (PregnancyGestation > 0) {
				DateImpregnated = coreGame.GameDate - PregnancyGestation;
				BitFlag1.SetBitFlag(95);		// to prevent all pregnant slaves being announced on upgrade
			} else DateImpregnated = 0;
		}
		if (Titles == undefined) Titles = "";
		if (SlaveName.substr(0, 7) == "Cumslut") {
			SlaveName = SlaveName.substr(8);
			Titles = "Cumslut";
		}
		if (isNaN(MaxLove)) MaxLove = 100;
		/*
		if (CanAssist == undefined) CanAssist = false;
		if (EventBoyfriend != undefined) return;
		
		if (strCombatDescription == undefined) strCombatDescription = "";
		if (strCombatHint == undefined) strCombatHint = "";
		if (isNaN(TotalChildren)) TotalChildren = 0;
		if (isNaN(VarSpecial2)) VarSpecial2 = 0;
		if (isNaN(MaxSpecial2)) MaxSpecial2 = 0;
		if (isNaN(ShowSpecial2)) ShowSpecial2 = 0;
		if (SlaveFilename == undefined) SlaveFilename = "";
		if (ImageFolder == undefined) ImageFolder = "";
		if (isNaN(VarSexualEnergy)) VarSexualEnergy = 0;
		if (VarSexualEnergyMod == undefined) VarSexualEnergyMod = 0;
		if (MilkBuildUp == undefined) MilkBuildUp = 0;
		if (TotalFootjob == undefined) TotalFootjob = 0;
		if (TotalHandjob == undefined) TotalHandjob = 0;
		if (coreGame.RapeOn) BitFlag1.SetBitFlag(90);
		if (coreGame.TentaclesOn == 1) BitFlag1.SetBitFlag(91);
		if (SlavePronoun == undefined || SlavePronoun == "") SlavePronoun = coreGame.Language.GetHtml("Pronoun","Gender");
		if (MaxAstrid == undefined) MaxAstrid = 10;
		if (VarSpecial2Mod == undefined) VarSpecial2Mod = 0;
		
		if (SlaveGenderBorn == undefined) SlaveGenderBorn = SlaveGender;
		if (EventBoyfriend == undefined) EventBoyfriend = 0;
		if (bSupervisedToday == undefined) bSupervisedToday = false;
		*/
	}
	
	public function Save(so:Object) {
		super.Save(so);

		so.LastEnding = LastEnding;
		so.SlaveName = SlaveName + "";
		so.SlaveName1 = SlaveName1 + "";
		so.SlaveName2 = SlaveName2 + "";
		so.SlaveGender = SlaveGender;
		so.GenderIdentity = GenderIdentity;
		so.IntimacyOK = IntimacyOK;
		var len:Number = Endings.length;
		if (LastEnding != -10 && Endings != null) {
			var nze:Number = 0;
			for (var i:Number = 0; i < len; i++) {
				if (Endings[i] != 0) nze++;
			}
			if (nze != 0) {
				so.Endings = new Array();
				for (var i:Number = 0; i < len; i++) {
					so.Endings[i].push(Endings[i]);
				}
			}
		}
		CopyCommonDetails(this, so);
		
		so.SlaveImage = SlaveImage + "";

		so.BitFlag1 = new Object();
		BitFlag1.Save(so.BitFlag1);
		so.BitFlag2 = new Object();
		BitFlag2.Save(so.BitFlag2);

		if (DemonFlags != null) {
			so.DemonFlags = new Object();
			DemonFlags.Save(so.DemonFlags);
		}
		//delete so.Owner;
		if (Owner != null) {
			so.Owner = new Object();
			Owner.Save(so.Owner);
		}
		//delete so.StartOwner;
		if (StartOwner != null) {
			so.StartOwner = new Object();
			StartOwner.Save(so.StartOwner);
		}
		//delete so.arSaveVars;
		if (arSaveVars != null) {
			len = arSaveVars.length;
			if (len != undefined && len != 0) {
				var idx:Number;
				so.arSaveVars = new Array();
				for (var j:Number = 0; j < len; j++) {
					if (typeof(arSaveVars[j]) == "string") {
						idx = so.arSaveVars.push("");
						so.arSaveVars[idx - 1] = arSaveVars[j];
					} else {
						so.arSaveVars.push(arSaveVars[j]);
					}
				}
			}
		}
		
		// Twins data
		if (slave1Data != null) {
			so.Slave1 = new Object();
			slave1Data.Save(so.Slave1);
		}
		if (slave2Data != null) {
			so.Slave2 = new Object();
			slave2Data.Save(so.Slave2);
		}		

	}
	
	public function DebugSlave(): String
	{
		var say:String = "\r\r<u>Slave</u>" + SlaveIndex + ": <b>" + SlaveName + "</b>";
		say = say + "\r  Type: " + SlaveType;
		say = say + "\tCanAssist: " + CanAssist;
		say = say + "\r  Image: " + SlaveImage;
		say = say + "\r  Folder: " + ImageFolder;
		say = say + "\r  Filename: " + SlaveFilename;
		say = say + "\r  Pregnancy = " + PregnancyGestation;
		say = say + "\tPregnant With = " + PregnancyType;
		say = say + "\r  Fertility = " + Fertility;
		say = say + "\tGender = " + SlaveGender;		
		say = say + "\r  IntimacyOK = " + IntimacyOK;
		say = say + "\tCumslut = " + CumslutLevel;
		say = say + "\r  Order1 = " + Order1;
		say = say + "\tOrder2 = " + Order2;
		say = say + "\r  Birthday = " + Birthday + "(" + coreGame.DecodeDate(Birthday) + ")";
		say = say + "\rNode:\r";
		var nd:String = sNode + "";
		say += nd.split("<").join("&lt;").split(">").join("&gt;");
		if (arSaveVars != null) {
			var i:Number = arSaveVars.length;
			if (i == undefined) i = 0;
			if (i != 0) {
				var bLeft = true;
				for (var j:Number = 0; j < i; j++) {
					if (j == 0) say += "\rSaved Variables:";
					if (bLeft) say += "\r  savedvar" + j + " = " + arSaveVars[j];
					else say += "\tsavedvar" + j + " = " + arSaveVars[j];
					bLeft = !bLeft;
				}
			}
		}
		return say;
	}

		
	// Bit Flags - OBSOLETE

	private function CheckBitFlag1(flag:Number) : Boolean { return BitFlag1.CheckBitFlag(flag); }
	private function SetBitFlag1(flag:Number) { BitFlag1.SetBitFlag(flag); }
	private function ClearBitFlag1(flag:Number) { BitFlag1.ClearBitFlag(flag); }
	private function CheckAndSetBitFlag1(flag:Number) : Boolean { return BitFlag1.CheckAndSetBitFlag(flag); }
	// bitflags 2 (for girl use)
	private function CheckBitFlag2(flag:Number) : Boolean { return BitFlag2.CheckBitFlag(flag); }
	private function SetBitFlag2(flag:Number) { BitFlag2.SetBitFlag(flag); }
	private function ClearBitFlag2(flag:Number) { BitFlag2.ClearBitFlag(flag); }
	private function CheckAndSetBitFlag2(flag:Number) : Boolean { return BitFlag2.CheckAndSetBitFlag(flag);	}


}