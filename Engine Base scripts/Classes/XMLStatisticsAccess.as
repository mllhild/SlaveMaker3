// XML Common Statistics variables
//
// Translation status: COMPLETE
import Scripts.Classes.*;

class XMLStatisticsAccess extends XMLParser {

	private var slaveData:Slave;

	// constructor (minimal)
	public function XMLStatisticsAccess(cg:Object)	{ super(cg); }

	// Statistics checker
	
	public function GetStat(stat:String, sd:Object) : Object
	{
		//trace("GetStat: " + stat);
		var slvt:Boolean = sd != undefined && sd != _root;
		if (sd == undefined) {
			sd = _root;
			psd = _root;
			if ((stat.indexOf("-") != -1) || (stat.indexOf("_") != -1)  || (stat.indexOf(":") != -1)) {
				stat = ParseSlaveTarget(stat);
				if (psd != undefined && psd != _root) sd = psd;
				slvt = true;
				//trace("..revised stat = " + stat + " " + sd);
			} else if ("oldgender.corruption.faith.hasfeeldo.hasropes.hassilkenropes.hasegg.weapon.weapontype.weaponclass.armour.armor.armourtype.armortype.ponygirlaware.talentprogress.specialevent.specialeventprogress.hometown.gender.renown.weaponskill.debt.guildmember.".indexOf(stat + ".") != -1 || stat.substr(0, 2) == "sm" || stat.substr(0, 7) == "totalsm" || stat.substr(-7) == "trained") {
				sd = SMData;
				psd = SMData;
			}
		}
		
		// Note:
		// organised into two lists to slightly improve speed of scanning for a match
		// - common variables
		// - uncommon
		// each grouped by Slave, Common to Slave and Slave Maker, and Slave Maker only
		
		if (sd != SMData) {
			
			// COMMON: Slave only
			if (stat == "charisma") return sd.VarCharisma;
			if (stat == "sensibility") return sd.VarSensibility;
			if (stat == "refinement") return sd.VarRefinement;
			if (stat == "intelligence") return sd.VarIntelligence;
			if (stat == "morality") return sd.VarMorality;
			if (stat == "constitution") return sd.VarConstitution;
			if (stat == "cooking") return sd.VarCooking;
			if (stat == "cleaning") return sd.VarCleaning;
			if (stat == "conversation") return sd.VarConversation;
			if (stat == "blowjob" || stat == "blowjobs") return sd.VarBlowJob;
			if (stat == "cunnilingus") return sd.VarCunnilingus;
			if (stat == "fuck" || stat == "fucking") return sd.VarFuck;
			if (stat == "trib/strap-on" || stat == "lesbianfuck" || stat == "tribstrapon") return sd.VarLesbianFuck;
			if (stat == "temperament") return sd.VarTemperament;
			if (stat == "nymphomania") return sd.VarNymphomania;
			if (stat == "minnymphomania") return sd.MinNymphomania;
			if (stat == "obedience") return sd.VarObedience;
			if (stat == "trust") return sd.VarObedience + sd.VarLovePoints;
			if (stat == "lust") return sd.VarLibido;
			if (stat == "minlust") return sd.MinLibido;
			if (stat == "fatigue" || stat == "tiredness") return sd.VarFatigue;
			if (stat == "joy") return sd.VarJoy;
			if (stat == "reputation") return sd.VarReputation;
			if (stat == "special") return sd.VarSpecial;
			if (stat == "special2") return sd.VarSpecial2;
			if (stat == "sexualenergy") return sd.VarSexualEnergy;
			if (stat == "naturaltalent") return sd.NaturalTalent;
			if (stat == "deficiency") return sd.Deficiency;
			
			if (stat == "customflag" || stat == "customflag0") return sd.CustomFlag;
			if (stat == "customflag1") return sd.CustomFlag1;
			if (stat == "customflag2") return sd.CustomFlag2;
			if (stat == "customflag3") return sd.CustomFlag3;
			if (stat == "customflag4") return sd.CustomFlag4;
			if (stat == "customflag5") return sd.CustomFlag5;
			if (stat == "customflag6") return sd.CustomFlag6;
			if (stat == "customflag7") return sd.CustomFlag7;
			if (stat == "customflag8") return sd.CustomFlag8;
			if (stat == "customflag9") return sd.CustomFlag9;
			if (stat == "path1") return sd.Path1;
			if (stat == "path2") return sd.Path2;
			if (stat == "path3") return sd.Path3;
			if (stat == "currentpath") return sd.CurrentPath;
			if (stat == "maxpath") return sd.MaxPath;
			if (stat == "customstring") return sd.CustomString;
			
			if (stat == "love" || stat == "lovepoints") return sd.VarLovePoints;
			if (stat == "fitness") return sd.FatigueBonus;
			if (stat == "slutiness") return sd.Slutiness;
			if (stat == "sexuality") return sd.Sexuality;
			if (stat == "sexualitystart") return sd.StartSexuality;
			
			if (stat == "lactation") return sd.Lactation;
			if (stat == "milkbuildup") return sd.MilkBuildUp;
			if (stat == "breastfixation") return sd.BreastFixation;
			if (stat == "milkinfluence") return sd.MilkInfluence;
			if (stat == "description") return sd.vitalsDescription;
			if (stat == "age") return sd.vitalsAge;
			
			if (stat == "maxfuck") return sd.MaxFuck;
			if (stat == "maxcharisma") return sd.MaxCharisma;
			if (stat == "maxrefinement") return sd.MaxRefinement;
			if (stat == "maxsensibility") return sd.MaxSensibility;
			if (stat == "maxintelligence") return sd.MaxIntelligence;
			if (stat == "maxmorality") return sd.MaxMorality;
			if (stat == "maxconstitution") return sd.MaxConstitution;
			if (stat == "maxcooking") return sd.MaxCooking;
			if (stat == "maxcleaning") return sd.MaxCleaning;
			if (stat == "maxconversation") return sd.MaxConversation;
			if (stat == "maxblowJob") return sd.MaxBlowJob;
			if (stat == "maxtemperament") return sd.MaxTemperament;
			if (stat == "maxnymphomania") return sd.MaxNymphomania;
			if (stat == "maxobedience") return sd.MaxObedience;
			if (stat == "maxlibido") return sd.MaxLibido;
			if (stat == "maxjoy") return sd.MaxJoy;
			if (stat == "maxlove") return sd.MaxLove;
			if (stat == "maxspecial") return sd.MaxSpecial;
			if (stat == "maxspecial2") return sd.MaxSpecial2;
			
			if (stat == "dickgirlrate") return sd.DickgirlRate;
			if (stat == "slavetype") return sd.SlaveType;
			if (stat == "canassist") return sd.CanAssist ? 1 : 0;
			if (stat == "available") return sd.Available ? 1 : 0;
		}
		
		// COMMON: common to slave and slave maker
		if (stat == "slavegender") return sd == SMData ? sd.Gender : sd.SlaveGender;
		if (stat == "titles") return sd.Titles;
		if (stat == "genderidentity") return sd.GenderIdentity;
	
		if (stat == "bloodtype") return sd == SMData ? sd.vitalsBloodType : sd.vitalsBloodType;
		
		if (stat == "hastail") return sd.HasTail ? 1 : 0;
		
		if (stat == "dressworn") return sd.DressWorn;
	
		if (stat == "daysunavailable") return sd.DaysUnavailable; 
		
		if (stat == "fertility") return sd.Fertility;
		if (stat == "pregnancygestation" || stat == "tentaclepregnancy") return sd.PregnancyGestation == 1000 ? 0.5 : sd.PregnancyGestation;
		if (stat == "pregnancycount") return sd.PregnancyCount;
		if (stat == "pregnancytype") return sd.PregnancyType;
		if (stat == "dateimpregnated") return sd.DateImpregnated;
		if (stat == "totalchildren") return sd.TotalChildren;
		if (stat == "totaltentaclepregnancy") return sd.TotalTentaclePregnancy;
		if (stat == "totaltentacle") return sd.TotalTentacle;
		
		if (stat == "ishinaieffecting") return sd.IshinaiEffecting;
		if (stat == "doreieffecting") return sd.DoreiEffecting;
		if (stat == "biyakueffecting") return sd.BiyakuEffecting;
		if (stat == "zodaieffecting") return sd.ZodaiEffecting;
		if (stat == "gamaneffecting") return sd.GamanEffecting;
		if (stat == "orgasmdrugeffecting") return sd.OrgasmDrugEffecting;
		if (stat == "addictionlevel") return sd.AddictionLevel;
		if (stat == "drugaddicted") return sd.DrugAddicted;
		if (stat == "numaphrodisiac") return sd.NumAphrodisiac;
		if (stat == "usedaphrodisiac") return sd.UsedAphrodisiac;
		if (stat == "drugduration") return sd.DrugDuration;
	
		if (stat == "attitude") return sd.Attitude;
		if (stat == "perception") return sd.Perception;
		if (stat == "judgement") return sd.Judgement;
		if (stat == "lifestyle") return sd.Lifestyle;
		if (stat == "attitudetype") return sd.GetAttitudeType();
		if (stat == "perceptiontype") return sd.GetPerceptionType();
		if (stat == "judgementtype") return sd.GetJudgementType();
		if (stat == "lifestyletype") return sd.GetLifestyleType();
		
		if (stat.substr(0, 7) == "isdress") {
			var sl:Array = SplitParts(stat);
			var dress = Number(sl[1]);
			if (isNaN(dress)) dress = undefined;
			else stat = sl[0];
			if (stat == "isdressswimsuit") return sd.IsDressSwimsuit(dress) ? 1 : 0;
			if (stat == "isdresscourtly") return sd.IsDressCourtly(dress) ? 1 : 0;
			if (stat == "isdressmaid") return sd.IsDressMaid(dress) ? 1 : 0;
			if (stat == "isdresseasy") return sd.IsDressEasy(dress) ? 1 : 0;
			if (stat == "isdresssleazybar") return sd.IsDressSleazyBar(dress) ? 1 : 0;
			if (stat == "isdressslutty") return sd.IsDressSlutty(dress) ? 1 : 0;
			if (stat == "isdressdancing") return sd.IsDressDancing(dress) ? 1 : 0;
			if (stat == "isdresslingerie") return sd.IsDressLingerie(dress) ? 1 : 0;
			if (stat == "isdresscatears") return sd.IsDressCatEars(dress) ? 1 : 0;
			if (stat == "isdresscattail") return sd.IsDressCatTail(dress) ? 1 : 0;
			if (stat == "isdresspuppyears") return sd.IsDressPuppyEars(dress) ? 1 : 0;
			if (stat == "isdresspuppytail") return sd.IsDressPuppyTail(dress) ? 1 : 0;		
			if (stat == "isdressmiko") return sd.IsDressMiko(dress) ? 1 : 0;
			if (stat == "isdresswaitress") return sd.IsDressWaitress(dress) ? 1 : 0;
			if (stat == "isdressholy") return sd.IsDressHoly(dress) ? 1 : 0;
			if (stat == "isdressdemonic") return sd.IsDressDemonic(dress) ? 1 : 0;
			if (stat == "isdressswimsuitowned") return sd.IsDressSwimsuitOwned(dress) ? 1 : 0;
			if (stat == "isdresscourtlyowned") return sd.IsDressCourtlyOwned(dress) ? 1 : 0;
			if (stat == "isdressmaidowned") return sd.IsDressMaidOwned(dress) ? 1 : 0;
			if (stat == "isdresseasyowned") return sd.IsDressEasyOwned(dress) ? 1 : 0;
			if (stat == "isdresssleazybarowned") return sd.IsDressSleazyBaOwnedr(dress) ? 1 : 0;
			if (stat == "isdresssluttyowned") return sd.IsDressSluttyOwned(dress) ? 1 : 0;
			if (stat == "isdressdancingowned") return sd.IsDressDancingOwned(dress) ? 1 : 0;
			if (stat == "isdresslingerieowned") return sd.IsDressLingerieOwned(dress) ? 1 : 0;
			if (stat == "isdresscatearsowned") return sd.IsDressCatEarsOwned(dress) ? 1 : 0;
			if (stat == "isdresscattailowned") return sd.IsDressCatTailOwned(dress) ? 1 : 0;
			if (stat == "isdresspuppyearsowned") return sd.IsDressPuppyEarsOwned(dress) ? 1 : 0;
			if (stat == "isdresspuppytailowned") return sd.IsDressPuppyTailOwned(dress) ? 1 : 0;		
			if (stat == "isdressmikoowned") return sd.IsDressMikoOwned(dress) ? 1 : 0;
			if (stat == "isdresswaitressowned") return sd.IsDressWaitressOwned(dress) ? 1 : 0;
			if (stat == "isdressholyowned") return sd.IsDressHolyOwned(dress) ? 1 : 0;
			if (stat == "isdressdemonicowned") return sd.IsDressDemonicOwned(dress) ? 1 : 0;
			if (stat == "isdressssold") return sd.IsDressForSale(dress) ? 1 : 0;
		}
		
		if (sd == SMData) {
			
			// COMMON: slave maker only
			if (stat == "gender") return SMData.Gender;
			if (stat == "oldgender") return SMData.OldGender;
			if (stat == "smattack") return SMData.SMAttack;
			if (stat == "smdefence" || stat == "smdefense") return SMData.SMDefence;
			if (stat == "corruption") return SMData.Corruption;
			if (stat == "smmincorruption") return SMData.SMMinCorruption;
			if (stat == "smconstitution") return SMData.SMConstitution;
			if (stat == "smconversation") return SMData.SMConversation;
			if (stat == "smreputation" || stat == "smrenown" || stat == "renown") return SMData.SMReputation;
			if (stat == "smlust") return SMData.SMLust;
			if (stat == "smminlust") return SMData.SMMinLust;
			if (stat == "smdominance" || stat == "dominance") return SMData.SMDominance;
			if (stat == "smcharisma") return SMData.SMCharisma;
			if (stat == "smrefinement") return SMData.SMRefinement;
			if (stat == "smnymphomania") return SMData.SMNymphomania;
			if (stat == "smtiredness") return SMData.SMTiredness;
			if (stat == "faith") return SMData.SMFaith;
			
		} else {
		
			// UNCOMMON: Slave Only
			if (stat == "loveaccepted") return sd.LoveAccepted;
			if (stat == "noblelove") return sd.NobleLove;
			if (stat == "noblelover") return sd.NobleLoveType;
			if (stat == "oldlover") return sd.OldLover;
			if (stat == "isdating") return sd.EventBoyfriend == 1 ? 1 : 0;
			if (stat == "isinlove") return sd.LoveAccepted == 1 || sd.LoveAccepted == 10 ? 1 : 0;
			if (stat == "totalmilked") return sd.TotalMilked;
		
			if (stat == "intimacyok") return sd.IntimacyOK ? 1 : 0;
			
			if (stat == "fairytransformation" || stat == "fairyxf") return sd.FairyXF;
			if (stat == "fairymeeting") return sd.FairyMeeting;
		
			if (stat == "donetentacleharem") return sd.DoneTentacleHarem;
			if (stat == "donemaster") return sd.DoneMaster;
		
			if (stat == "ownername") return sd.Owner.GetOwnerName();
			if (stat == "ownergender") return sd.Owner.PersonGender;
			if (stat == "buyer" || stat == "owner" || stat == "soldslave") return sd.Owner.GetOwner();
			
			if (stat == "iscourtesan") return sd.DoneCourtesan == 1 ? 1 : 0;
			
			if (stat == "virginvaginal") return sd.VirginVaginal ? 1 : 0;
			if (stat == "virginanal") return sd.VirginAnal ? 1 : 0;
			if (stat == "virginoral") return sd.VirginOral ? 1 : 0;
				
			if (stat.substr(0, 5) == "level") {
				stat = stat.substr(5);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				return coreGame.GetLastSexActLevel(act.Act, sd);
			}
			if (stat == "winxxx") return sd.WinXXX;
			if (stat == "winhousework") return sd.WinHousework;
			if (stat == "wincourt") return sd.WinCourt;
			if (stat == "winbeauty") return sd.WinBeauty;
			if (stat == "winponygirl") return sd.WinPonygirl;
			if (stat == "windance") return sd.WinDance;
			if (stat == "wincustom") return sd.WinCustom;
			if (stat == "wingeneralknowledge") return sd.WinGeneralKnowledge;
			if (stat == "winhouseworkadvanced") return sd.WinHouseworkAdvanced;
			if (stat == "totalcontestcustom") return sd.TotalContestCustom;
			if (stat == "totalcontestxxx") return sd.TotalContestXXX;
			if (stat == "totalcontesthousework") return sd.TotalContestHousework;
			if (stat == "totalcontesthouseworkadvanced") return sd.TotalContestHouseworkAdvanced;
			if (stat == "totalcontestcourt") return sd.TotalContestCourt;
			if (stat == "totalcontestbeauty") return sd.TotalContestBeauty;
			if (stat == "totalcontestponygirl") return sd.TotalContestPonygirl;
			if (stat == "totalcontestdance") return sd.TotalContestDance;
			if (stat == "totalcontestgeneralknowledge") return sd.TotalContestGeneralKnowledge;
			
			if (stat == "lesbianinterest" || stat == "gayinterest") return sd.LesbianInterest;
			if (stat == "ponygirlinterest") return sd.PonygirlInterest;
			if (stat == "catgirlinterest") return sd.CatgirlInterest;
			if (stat == "puppygirlinterest") return sd.PuppygirlInterest;
			if (stat == "succubusinterest") return sd.SuccubusInterest;
			
			if (stat == "order1") return sd.Order1;
			if (stat == "order2") return sd.Order2;
			
			if (stat == "slavepronoun") return sd.SlavePronoun;
		
			if (stat == "idolmeeting") return sd.VarIdol;
			if (stat == "schoolgirlmeeting") return sd.VarSchoolGirl;
			if (stat == "puppygirlmeeting") return sd.PuppyGirlFlag;
		
			if (stat == "trainingstart") return sd.TrainingStart;
			if (stat.substr(0, 16) == "istrainedas") {
				stat = stat.substr(16);
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				if (sd == SMData) return 0;
				return sd.IsSlaveTrainedAs(stat) ? 1 : 0;
			}
			
			if (stat == "trainings") return GetXMLStringParsed("Abilities", sd.sNode, "");
			
			if (stat == "lastending") return sd.LastEnding;
				
			if (stat == "totalteddybear") return sd.TotalTeddyBear;
			if (stat == "walkhome") return sd.TotalWalkHouse;
			if (stat == "walkcustomhome") return sd.TotalWalkCustom;
		
			if (stat.substr(0, 5) == "total") {
				stat = stat.substr(5);
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				if (act != null) return sd.GetActTotal(act.Act);
			}
			
			if (stat != "difficulty" && stat.substr(0, 10) == "difficulty") {
				// difficulty-slave-bondage
				stat = stat.substr(10);
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				return sd.GetActDifficulty(act.Act);
			}
			
			if (stat.substr(0, 9) == "islevelup" || stat.substr(0, 7) == "levelup") {
				if (stat.substr(0, 2) == "is") stat = stat.substr(9);
				else stat = stat.substr(7);
				if (stat == "") return coreGame.LevelUp ? 1 : 0;
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				return coreGame.GetCurrentSexActLevel(act.Act, sd) > coreGame.GetLastSexActLevel(act.Act, sd) ? 1 : 0;
			}
			if (stat.substr(0, 4) == "cost") {
				stat = stat.substr(4);
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				if (act != null) return act.Cost;
			}
			
			if (stat.substr(0, 8) == "savedvar") {
				stat = stat.substr(8);
				var bString:Boolean = stat.substr(0, 6) == "string";
				if (bString || stat.substr(0, 6) == "number") stat = stat.substr(6);
				var idx:Number = Number(stat);
				if (sd == _root) sd = SMData.GetSlaveObject(sd);
				//trace("check savedvar: " + stat + " " + idx + " " + sd.arSaveVars + " " + sd.arSaveVars.length);
				if (sd.arSaveVars == null) sd.arSaveVars = new Array();
				var len:Number = sd.arSaveVars.length;
				if (!isNaN(idx) && sd.arSaveVars.length < (idx + 1)) {
					for (var id:Number = sd.arSaveVars.length; id <= idx; id++) sd.arSaveVars.push(0);
				}
				if (sd.arSaveVars[idx] == undefined) sd.arSaveVars[idx] = 0;
				//trace("check2 savevars: " + idx + " " + sd.arSaveVars + " " + sd.arSaveVars.length);
				//trace("value: savedvar" + idx + " = " + sd.arSaveVars[idx] + " " + sd.SlaveName);
				return sd.arSaveVars[idx];
			}
			
			// state type flags, NO Set versions
			if (stat == "isfairy" || stat == "isfaerie") return sd.IsFairy() ? 1 : 0;
			if (stat == "isfairycomplete" || stat == "isfaeriecomplete") return sd.IsFairyComplete() ? 1 : 0;
			if (stat == "iscatgirl") return sd.IsCatgirl() ? 1 : 0;
			if (stat == "ispuppygirl") return sd.IsPuppygirl() ? 1 : 0;
			if (stat == "iscatgirlcomplete") return sd.IsCatgirlComplete() ? 1 : 0;
			if (stat == "iscatgirltraining") return sd.IsCatgirlTraining() ? 1 : 0;
			if (stat == "isponygirl") return sd.IsPonygirl() ? 1 : 0;
			if (stat == "isdickgirl") return sd.IsDickgirl() ? 1 : 0;
			if (stat == "issuccubus") return sd.IsSuccubus() ? 1 : 0;
			if (stat == "issuccubuscomplete") return sd.IsSuccubusComplete() ? 1 : 0;
			if (stat == "iscumslut") return sd.IsCumslut() ? 1 : 0;
			if (stat == "iscumsluttraining" || stat == "cumsluttraining") return sd.IsCumslutTraining() ? 1 : 0;
		
			if (stat == "elapsed") return coreGame.GameDate - sd.TrainingStart + 1;
			
			if (stat == "birthday") return sd.Birthday;
			
			if (stat == "durationhaircare") return sd.DurationHairCare;
			if (stat == "durationfacialcare") return sd.DurationFacialCare;
			if (stat == "durationmakeupcare") return sd.DurationMakeupCare;
			
			if (stat == "loyalty") return sd.Loyalty;
			
			if (stat == "slaveimage") return sd.SlaveImage;
			
			if (stat == "combatname") return sd.strCombatDescription;
			if (stat == "specialname") return sd.SpecialName;
			if (stat == "special2name") return sd.Special2Name;
			
			if (stat.substr(0, 4) == "item") {
				var sl:Array = SplitParts(stat);
				var val:Number = coreGame.Items.GetItemIdxFromNameBase(sl[1]);
				if (val == -1) val = Number(sl[1]);
				if (sl[0] == "itemworn") return coreGame.Items.IsItemWorn(val) ? 1 : 0;
				else if (sl[0] == "itemowned") return coreGame.Items.IsItemAvailable(val) ? 1 : 0;
			}
			
			// Slave skills
			var val:Number = sd.GetSkill(stat);
			if (val != undefined) return val;
		}
	
		// UNCOMMON: common to slave and slave maker
		{
			// measurements
			// handle suffixes
			// cm - in centibeters
			// 
			var s:String = stat + "";
			var div:Number = 1;
			var val:Number = -1;
			var bDisp:Boolean = false;
			var bMetric:Boolean = coreGame.Options.MetricOn;
			if (stat.substr(0, 12) == "displayother") { stat = stat.substr(12); bMetric = !bMetric; div = bMetric ? 1 : 2.54; bDisp = true; }
			if (stat.substr(0, 7) == "display") { stat = stat.substr(7); div = bMetric ? 1 : 2.54; bDisp = true; }
			if (stat.substr(-2) == "cm" || stat.substr(-2) == "kg") {
				stat = stat.substr(0, stat.length - 2);
				div = 1;
				bMetric = true;
			}
			else if (stat.substr(-6) == "inches" || stat.substr(-6) == "pounds") {
				stat = stat.substr(0, stat.length - 6); 
				div = 2.54;
				bMetric = false;
			}
			if (stat == "height") {
				val = sd == SMData ? sd.vitalsHeightSM : sd.vitalsHeight;
				if (div != 1) val = Math.floor((10 * val) / div) / 10;
				if (!bDisp) return val;
				if (bMetric) return val + coreGame.Language.strCM + "";
				var vh:Number = val / 12;
				return Math.floor(vh) + "'" + Math.floor(12 * (vh - Math.floor(vh))) + '"';
			} else if (stat == "weight") { 
				val = sd == SMData ? sd.vitalsWeightSM :  sd.vitalsWeight; 
				if (div != 1) val = Math.round((10 * val) * 2.2) / 10;
				if (bDisp) return val + (bMetric ? coreGame.Language.strKG : coreGame.Language.strPD) + "";
				return val;
			} 
			if (stat == "clit") val = Math.ceil(10 * (sd == SMData ? sd.ClitCockSizeSM : sd.ClitCockSize)) / 10;
			else if (stat == "cock") val = sd == SMData ? Math.round(sd.ClitCockSizeSM * 330) / 10 : Math.round(sd.ClitCockSize * 330) / 10;
			else if (stat == "waist") val = sd == SMData ? sd.vitalsWaistSM : sd.vitalsWaist;
			else if (stat == "hips") val = sd == SMData ? sd.vitalsHipsSM : sd.vitalsHips;			
			else if (stat == "clitstart") val = sd == SMData ? sd.ClitCockSizeStartSM : sd.ClitCockSizeStart;
			else if (stat == "cockstart") val = sd == SMData ? Math.round(sd.ClitCockSizeStartSM * 33) : Math.round(sd.ClitCockSizeStart * 33);
			else if (stat == "bust") val = sd == SMData ? sd.vitalsBustSM : sd.vitalsBust;
			else if (stat == "buststart") val = sd == SMData ? sd.vitalsBustStartSM : sd.vitalsBustStart;
			if (val != -1) {
				if (div != 1) val = Math.round((10 * val) / div) / 10;
				if (bDisp) return val + (bMetric ? coreGame.Language.strCM : coreGame.Language.strIN) + "";
				return val;
			}
			
			if (stat == "bustsize") {
				val = sd == SMData ? int(10 * int(sd.vitalsBustSM + 0.9) / int(sd.vitalsBustStartSM)) / 10 : int(10 * int(coreGame.vitalsBustCurrent + 0.9) / int(sd.vitalsBustStart)) / 10;
				if (bDisp) return val + (coreGame.Options.MetricOn ? coreGame.Language.strKG : coreGame.Language.strPD) + "";
				return val;
			}
			if (stat == "cocksize") {
				val = sd == SMData ? int(10 * int(sd.ClitCockSizeSM + 0.9) / int(sd.ClitCockSizeStartSM)) / 10 : int(10 * int(sd.ClitCockSize + 0.9) / int(sd.ClitCockSizeStart)) / 10;
				if (bDisp) return val + (coreGame.Options.MetricOn ? coreGame.Language.strKG : coreGame.Language.strPD) + "";
				return val;
			}
			stat = s;

		}
		if (stat == "slavegenderborn") return sd == SMData ? sd.SlaveGenderBorn : sd.OldGender;
		if (stat.substr(0, 10) == "potionused") {
			var str:String = XMLBase.StripParts(stat.substr(10));
			var pot:Number = coreGame.Potions.GetPotionNumber(str);
			return sd.GetPotionUsed(pot);
		}
	
		// state type flags, NO Set versions
		if (stat == "slavefemale" || stat == "isfemale") return sd.IsFemale() ? 1 : 0;
		if (stat == "iwoman") return sd.IsWoman() ? 1 : 0;
		if (stat == "ismale") return sd.IsMale() ? 1 : 0;
		if (stat == "istwins") return sd.IsTwins() ? 1 : 0;
		
		if (stat == "piercings") return sd == SMData ? SMData.SMPiercingsType : sd.PiercingsType;
		if (stat == "hasvanitycase") return sd == SMData ? SMData.SMVanityCaseOK : sd.VanityCaseOK;
		if (stat == "hasnipplerings") return sd == SMData ? SMData.SMNippleRingsOK : sd.NippleRingsOk;
			
		if (stat == "race") return sd.GetRaceId();
		if (stat == "racename") return sd.GetRace();
		
		if (stat == "numdresses") return sd.GetTotalDresses();
		
		if (sd == SMData) {
			
			// UNCOMMON: Slave Maker only
			if (stat == "catgirlstrained") return SMData.CatgirlsTrained;
			if (stat == "girlstrained") return SMData.GirlsTrained;
			if (stat == "ponygirlstrained") return SMData.PonygirlsTrained;
			if (stat == "lesbianstrained") return SMData.LesbiansTrained;
			if (stat == "catgirlstrained") return SMData.CatgirlsTrained;
			if (stat == "puppygirlstrained") return SMData.PuppygirlsTrained;
			if (stat == "dickgirlstrained") return SMData.DickgirlsTrained;
			if (stat == "slutstrained") return SMData.SlutsTrained;
			if (stat == "cumslutstrained") return SMData.CumslutsTrained;
			if (stat == "succubusestrained") return SMData.SuccubusesTrained;
			
			if (stat == "hasfeeldo") return SMData.SMFeeldoOK ? 1 : 0;
			if (stat == "hasropes") return SMData.RopesOK;
			if (stat == "hassilkenropes") return SMData.SilkenRopesOK;
			if (stat == "hasegg") return SMData.EggOK;
			
			if (stat == "weapon") return SMData.GetWeaponName(SMData.WeaponType);
			if (stat == "armour" || stat == "armor") return SMData.GetArmourName(SMData.ArmourType);
			if (stat == "weapontype") return SMData.WeaponType;
			if (stat == "armourtype" || stat == "armortype") return SMData.ArmourType;
			if (stat == "weaponclass") return SMData.GetWeaponClass();
			if (stat == "ponygirlaware") return SMData.PonygirlAware;
			
			if (stat == "talentprogress" || stat == "specialeventprogress") return SMData.SpecialEventProgress;
			if (stat == "specialevent") return SMData.SMSpecialEvent;
			if (stat == "hometown") return SMData.SMHomeTown;
			
			if (stat == "theologytraining") return SMData.TheologyTraining;
			
			if (stat == "weaponskill") return SMData.GetWeaponSkill();
			
			if (stat == "totalsmnun") return SMData.TotalSMNun;
			if (stat == "totalsmcourt") return SMData.TotalSMCourt;
			if (stat == "totalsmbar") return SMData.TotalSMBar;
			if (stat == "totalsmsleazybar") return SMData.TotalSMSleazyBar;
			if (stat == "totalsmmartial") return SMData.TotalSMMartial;
			if (stat == "totalsmpray") return SMData.TotalSMPray;
			if (stat == "totalsmjob") return SMData.TotalSMJob;
			if (stat == "totalsmcustom") return SMData.TotalSMCustom;
			if (stat == "totalsmspecial") return SMData.TotalSMSpecial;
			if (stat == "totalsmtalkslaves") return SMData.TotalSMTalkSlaves;
			
			if (stat == "smmoney" || stat == "smgold") return SMData.SMGold;
			if (stat == "debt") return SMData.SMDebt;
			
			if (stat == "skillpoints") return SMData.SkillPoints;
			if (stat == "smhealth") return SMData.GetHealth();
				
			// OBSOLETE
			if (stat == "smbust") return SMData.vitalsBustSM;
			if (stat == "smbuststart") return SMData.vitalsBustStartSM;
			if (stat == "smclit") return SMData.ClitCockSizeSM;
			if (stat == "smcock") return Math.round(SMData.ClitCockSizeSM * 33);
			if (stat == "smclitstart") return SMData.ClitCockSizeStartSM;
			if (stat == "smcockstart") return Math.round(SMData.ClitCockSizeStartSM);
			if (stat == "smbloodtype") return SMData.vitalsBloodTypeSM;
			if (stat == "smfertility") return SMData.Fertility;
			if (stat == "smsexualenergy") return SMData.SexualEnergy;
			if (stat == "smpregnancygestation") return SMData.PregnancyGestation == 1000 ? 0.5 : SMData.PregnancyGestation;
			if (stat == "smpregnancycount") return SMData.PregnancyCount;
			if (stat == "smpregnancytype") return SMData.PregnancyType;
			if (stat == "smbustsize") return int(10 * int(SMData.vitalsBustSM + 0.9) / int(SMData.vitalsBustStartSM)) / 10;
			if (stat == "smcocksize") return int(10 * int(SMData.ClitCockSizeSM + 0.9) / int(SMData.ClitCockSizeStartSM)) / 10;
			if (stat == "smrace") return SMData.GetRaceId();		// OBSOLETE	
			if (stat == "smracename") return SMData.GetRace();		// OBSOLETE
			if (stat == "smtotalchildren") return SMData.TotalSMChildren;
		}
		
		if (stat.substr(0, 11) == "potionowned") {
			psd = SMData;
			var str:String = XMLBase.StripParts(stat.substr(11));
			var pot:Number = coreGame.Potions.GetPotionNumber(str);
			return SMData.GetPotionOwned(pot);
		}
	
		
		// Finally, check any slavemaker skills
		
		// default the following to Slave Maker not slave
		var i:Number = SMSlaveCommon.DecodeSMSkill(stat);
		if (!slvt && sd == _root) sd = SMData;
		if (i > 0) {
			//SMTRACE("get skill: " + stat + " - " + i + " for " + (sd == SMData ? "slavemaker" : sd.SlaveName));
			var val:Number = sd.GetSMSkillLevel(i);
			//SMTRACE("...value = " + val);
			return val;
		}
	
		return undefined;
	}
	
	public function SetStat(stat:String, val:Number, vals:String) : Number
	{
		var slvt:Boolean = false;
		var sd:Object = _root;
		if ((stat.indexOf("-") != -1) || (stat.indexOf("_") != -1)) {
			stat = ParseSlaveTarget(stat);
			if (psd != undefined && psd != _root) sd = psd;
			slvt = true;
		} else if ("oldgender.corruption.faith.hasfeeldo.hasropes.hassilkenropes.hasegg.weapon.weapontype.weaponclass.armour.armor.armourtype.armortype.ponygirlaware.talentprogress.specialevent.hometown.gender.dominance.debt.".indexOf(stat + ".") != -1 || stat.substr(0, 2) == "sm"|| stat.substr(0, 7) == "totalsm" || stat.substr(0, -7) == "trained") {
			sd = SMData;
			psd = SMData;
		}
		
		//if (sd == SMData) trace("SetStat - SlaveMaker: " + stat);
		//else trace("SetStat - Slave: " + stat);
		
		// Note:
		// organised into two lists to slightly improve speed of scanning for a match
		// - common variables
		// - uncommon
		// each grouped by Slave, Common to Slave and Slave Maker, and Slave Maker only
		
		if (sd != SMData) {
			
			// COMMON: Slave only
			if (stat == "charisma") return sd.VarCharisma = val;
			if (stat == "sensibility") return sd.VarSensibility = val;
			if (stat == "refinement") return sd.VarRefinement = val;
			if (stat == "intelligence") return sd.VarIntelligence = val;
			if (stat == "morality") return sd.VarMorality = val;
			if (stat == "constitution") return sd.VarConstitution = val;
			if (stat == "cooking") return sd.VarCooking = val;
			if (stat == "cleaning") return sd.VarCleaning = val;
			if (stat == "conversation") return sd.VarConversation = val;
			if (stat == "blowjob" || stat == "blowjobs" || stat == "cunnilingus") return sd.VarBlowJob = val;
			if (stat == "fuck" || stat == "fucking" || stat == "trib/strap-on") return sd.VarFuck = val;
			if (stat == "temperament") return sd.VarTemperament = val;
			if (stat == "nymphomania") return sd.VarNymphomania = val;
			if (stat == "minnymphomania") return sd.MinNymphomania = val;
			if (stat == "obedience") return sd.VarObedience = val;
			// trust is readonly
			if (stat == "lust") return sd.VarLibido = val;
			if (stat == "minlust") return sd.MinLibido = val;
			if (stat == "fatigue" || stat == "tiredness") return sd.VarFatigue = val;
			if (stat == "joy") return sd.VarJoy = val;
			if (stat == "reputation") return sd.VarReputation = val;
			if (stat == "special") return sd.VarSpecial = val;
			if (stat == "special2") return sd.VarSpecial2 = val;
			if (stat == "sexualenergy") return sd.VarSexualEnergy = val;
			if (stat == "naturaltalent") {
				var tal:Number = SlaveStatistics.GetDeficiencyTalent(vals);
				return sd.NaturalTalent = tal != 0 ? tal : val;
				return 0;
			}
			if (stat == "deficiency") {
				var tal:Number = SlaveStatistics.GetDeficiencyTalent(vals);
				return sd.Deficiency = tal != 0 ? tal : val;
			}
			
			if (stat == "customflag" || stat == "customflag0") return sd.CustomFlag = val; 
			if (stat == "customflag1") return sd.CustomFlag1 = val; 
			if (stat == "customflag2") return sd.CustomFlag2 = val; 
			if (stat == "customflag3") return sd.CustomFlag3 = val; 
			if (stat == "customflag4") return sd.CustomFlag4 = val; 
			if (stat == "customflag5") return sd.CustomFlag5 = val; 
			if (stat == "customflag6") return sd.CustomFlag6 = val; 
			if (stat == "customflag7") return sd.CustomFlag7 = val; 
			if (stat == "customflag8") return sd.CustomFlag8 = val; 
			if (stat == "customflag9") return sd.CustomFlag9 = val; 
			if (stat == "path1") return sd.Path1 = val; 
			if (stat == "path2") return sd.Path2 = val; 
			if (stat == "path3") return sd.Path3 = val; 
			if (stat == "customstring") {
				sd.CustomString = vals;
				return 0;
			}
		
			if (stat == "love" || stat == "lovepoints") return sd.VarLovePoints = val;
			if (stat == "fitness") return sd.FatigueBonus = val;
			if (stat == "slutiness") return sd.Slutiness = val;
			if (stat == "sexuality") {
				sd.Sexuality = val;
				sd.AlterSexuality(0);
				return val;
			}
			
			if (stat == "lactation") return sd.Lactation = val;
			if (stat == "breastfixation") return sd.BreastFixation = val;
			if (stat == "milkinfluence") return sd.MilkInfluence = val;
			if (stat == "milkbuildup") return sd.MilkBuildUp = val;
			if (stat == "description") {
				sd.vitalsDescription = vals;
				coreGame.dspMain.UpdateSlaveVitals(sd);
				return 1;
			}
			if (stat == "age") {
				sd.vitalsAge = val;
				coreGame.dspMain.UpdateSlaveVitals(sd);
				return val;
			}
		
			if (stat == "maxfuck") return sd.MaxFuck = val;
			if (stat == "maxcharisma") return sd.MaxCharisma = val;
			if (stat == "maxrefinement") return sd.MaxRefinement = val;
			if (stat == "maxsensibility") return sd.MaxSensibility = val;
			if (stat == "maxintelligence") return sd.MaxIntelligence = val;
			if (stat == "maxmorality") return sd.MaxMorality = val;
			if (stat == "maxconstitution") return sd.MaxConstitution = val;
			if (stat == "maxcooking") return sd.MaxCooking = val;
			if (stat == "maxcleaning") return sd.MaxCleaning = val;
			if (stat == "maxconversation") return sd.MaxConversation = val;
			if (stat == "maxblowjob") return sd.MaxBlowJob = val;
			if (stat == "maxtemperament") return sd.MaxTemperament = val;
			if (stat == "maxnymphomania") return sd.MaxNymphomania = val;
			if (stat == "maxobedience") return sd.MaxObedience = val;
			if (stat == "maxlibido") return sd.MaxLibido = val;
			if (stat == "maxjoy") return sd.MaxJoy = val;
			if (stat == "maxlove") return sd.MaxLove = val;
			if (stat == "maxspecial") return sd.MaxSpecial = val;
			if (stat == "maxspecial2") return sd.MaxSpecial2 = val;
			if (stat == "dickgirlrate") return sd.DickgirlRate = val;
			if (stat == "slavetype") {
				if (isNaN(vals)) {
					if (sd == slaveData || sd == _root) SMData.ChangeSlaveType(-50, vals);
					else SMData.ChangeSlaveType(sd.SlaveIndex, vals);
				} else {
					if (sd == slaveData || sd == _root) {
						if (val == -1) slaveData.CanAssist = true;
						else slaveData.SlaveType = val;
					} else {
						if (val == -1) {
							if (sd.SlaveType == -2 || sd.SlaveType == -20) {
								sd.SlaveType = -1;
								sd.CanAssist = false;
							} else sd.CanAssist = true;
							sd.Available = true;
						} else if (val == -100) {
							sd.SlaveType = -100;
							sd.CanAssist = false;
						} else sd.SlaveType = val;
					}
				}
				SMData.BuildOwnedSlaves();
				return 0;
			}
			if (stat == "canassist") {
				sd.CanAssist = vals.toLowerCase() == "true";
				return 0;
			}
			if (stat == "available") {
				sd.Available = vals.toLowerCase() == "true";
				return 0;
			}
		}
		
		// COMMON: common to slave and slave maker
		if (stat == "slavegender") {
			if (sd == SMData) coreGame.ChangeSlaveMakerGender(coreGame.GetGender(vals));
			else coreGame.ChangeSlaveGender(coreGame.GetGender(vals), sd);
			return 0;
		}
		if (stat == "titles") {
			sd.SetTitle(vals);
			return 0;
		}
		if (stat == "genderidentity") {
			sd.GenderIdentity =coreGame. GetGender(vals);
			if (sd == SMData) return sd.GenderIdentity;
			if (sd.IsDisplayed()) coreGame.GetPersonOtherGenderText(sd.GenderIdentity);
			if (sd == _root || sd == slaveData) {
				coreGame.UpdateSlaveGenderText(sd);
				coreGame.SetActButtonDetailsStartup();
			}
			return sd.GenderIdentity;
		}	
		if (stat == "bust") {
			sd == SMData ? sd.vitalsBustSM = val : sd.vitalsBust = val;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}
		if (stat == "clit") {
			sd == SMData ? sd.ClitCockSizeSM = val : sd.ClitCockSize = val;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}
		if (stat == "cock") {
			sd == SMData ? sd.ClitCockSizeSM = val * 33 : sd.ClitCockSize = val * 33;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}
		if (stat == "bloodtype") {
			if (sd == SMData) sd.vitalsBloodTypeSM = vals;
			else {
				coreGame.dspMain.UpdateSlaveVitals(sd);
				sd.vitalsBloodType = vals;
			}
			return 0;
		}
		if (stat == "height") {
			sd == SMData ? sd.vitalsHeightSM = val : sd.vitalsHeight = val;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}
		if (stat == "weight") {
			sd == SMData ? sd.vitalsWeightSM = val : sd.vitalsWeight = val;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}
		if (stat == "waist") {
			sd == SMData ? sd.vitalsWaistSM = val : sd.vitalsWaist = val;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}			
		if (stat == "hips") {
			sd == SMData ? sd.vitalsHipsSM = val : sd.vitalsHips = val;
			coreGame.dspMain.UpdateSlaveVitals(sd);
			return val;
		}
	
		if (stat == "hastail") {
			sd.HasTail = vals.toLowerCase() == "true";
			return 0;
		}
		if (stat == "daysunavailable") return sd.DaysUnavailable = val;
			
		if (stat == "fertility") return sd.Fertility = val;
		if (stat == "pregnancygestation" || stat == "tentaclepregnancy") return sd.PregnancyGestation = val;
		if (stat == "pregnancycount") return sd.PregnancyCount = val;
		if (stat == "pregnancytype") {
			sd.PregnancyType = vals;
			return 0;
		}
		if (stat == "totalchildren") return sd.TotalChildren = val;
		if (stat == "totaltentaclepregnancy") return sd.TotalTentaclePregnancy = val;
		if (stat == "totaltentacle") return sd.TotalTentacle = val;
		
		if (stat == "ishinaieffecting") return sd.IshinaiEffecting = val < 0 ? 0 : val;
		if (stat == "doreieffecting") return sd.DoreiEffecting = val < 0 ? 0 : val;
		if (stat == "biyakueffecting") return sd.BiyakuEffecting = val < 0 ? 0 : val;
		if (stat == "zodaieffecting") return sd.ZodaiEffecting = val < 0 ? 0 : val;
		if (stat == "gamaneffecting") return sd.GamanEffecting = val < 0 ? 0 : val;
		if (stat == "orgasmdrugeffecting") return sd.OrgasmDrugEffecting = val < 0 ? 0 : val;
		if (stat == "addictionlevel") return sd.AddictionLevel = val;
		if (stat == "drugaddicted") return sd.DrugAddicted = val;
		if (stat == "numaphrodisiac") return sd.NumAphrodisiac = val;
		if (stat == "usedaphrodisiac") return sd.UsedAphrodisiac = val;
		if (stat == "drugduration") return sd.DrugDuration = val;
	
		if (stat == "attitude") {
			if (vals == "extroversion") return sd.Attitude = 75;
			else if (vals == "introversion") return sd.Attitude = 25;
			return sd.Attitude = val;
		}
		if (stat == "perception") {
			if (vals == "sensing") sd.Perception = 75;
			else if (vals == "intuition") sd.Perception = 25;
			return sd.Perception = val;
		}		
		if (stat == "judgement" || stat == "judgment") {
			if (vals == "thinking") return sd.Judgement = 75;
			else if (vals == "feeling") return sd.Judgement = 25;
			return sd.Jugdement = val;
		}		
		if (stat == "lifestyle") {
			if (vals == "perception") return sd.Lifestyle = 75;
			else if (vals == "judgement" || vals == "judgment") return sd.Lifestyle = 25;
			return sd.Lifestyle = val;
		}
		
		if (sd == SMData) {
			
			// COMMON: slave maker only
			if (stat == "gender") {
				coreGame.ChangeSlaveMakerGender(coreGame.GetGender(vals));
				return SMData.Gender;
			}
			if (stat == "smattack") return SMData.SMAttack = val;
			if (stat == "smdefence" || stat == "smdefense") return SMData.SMDefence = val;
			if (stat == "corruption") return SMData.Corruption = val;
			if (stat == "smmincorruption") return SMData.SMMinCorruption = val;
			if (stat == "smconstitution") return SMData.SMConstitution = val;
			if (stat == "smconversation") return SMData.SMConversation = val;
			if (stat == "smreputation" || stat == "smrenown" || stat == "renown") return SMData.SMReputation = val;
			if (stat == "smlust") return SMData.SMLust = val;
			if (stat == "smminlust") return SMData.SMMinLust = val;
			if (stat == "smdominance" || stat == "dominance") return SMData.SMDominance = val;
			if (stat == "smcharisma") return SMData.SMCharisma = val;
			if (stat == "smrefinement") return SMData.SMRefinement = val;
			if (stat == "smnymphomania") return SMData.SMNymphomania = val;
			if (stat == "smtiredness") return SMData.SMTiredness = val;
			if (stat == "faith") {
				SMData.ChangeSlaveMakerFaith(val);
				return val;
			}
			
		} else {
	
			// UNCOMMON: Slave Only
			if (stat == "loveaccepted") return sd.LoveAccepted = val;
			if (stat == "noblelove") return sd.NobleLove = val;
			if (stat == "noblelover") return sd.NobleLoveType = val;
			if (stat == "oldlover") return sd.OldLover = val;
			if (stat == "dating") return sd.EventBoyfriend = val;
			if (stat == "totalmilked") return sd.TotalMilked = val;
			
			if (stat == "intimacyok") {
				sd.IntimacyOK = (vals.toLowerCase() == "true");
				return 0;
			}
			
			if (stat == "fairytransformation" || stat == "fairyxf") return sd.FairyXF = val;
			if (stat == "fairymeeting") return sd.FairyMeeting = val;
			
			if (stat == "donetentacleharem") {
				sd.DoneTentacleHarem = (vals.toLowerCase() == "true");
				return 0;
			}
			if (stat == "donemaster") {
				sd.DoneMaster = (vals.toLowerCase() == "true");
				return 0;
			}
			
			if (stat == "ownername") {
				sd.Owner.PersonName = vals;
				return 0;
			}
			if (stat == "ownergender") {
				sd.Owner.PersonGender = coreGame.GetGender(vals);
				return val;
			}
			if (stat == "buyer" || stat == "owner" || stat == "soldslave") return sd.Owner.ChangeOwner(val);
			
			if (stat == "virginvaginal") {
				sd.VirginVaginal = vals.toLowerCase() == "true";
				return 0;
			} 
			if (stat == "virginanal") {
				sd.VirginAnal = vals.toLowerCase() == "true";
				return 0;
			}
			if (stat == "virginoral") {
				sd.VirginOral = vals.toLowerCase() == "true";
				return 0;
			}
		
			if (stat.substr(0, 5) == "level") {
				stat = StripParts(stat.substr(5));
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				if (val > 5) val = 5;
				else if (val < 0) val = 0;
				coreGame.SetSexActLevel(act.Act, val, sd);
				coreGame.dspMain.UpdateSexSkills();
				return 0;
			}
			
			if (stat.substr(0, 14) == "totalactimages") {
				stat = StripParts(stat.substr(14));
				var act:ActInfo = slaveData.ActInfoCurrent.GetActByName(stat);
				return act.GetTotalImages();
			}
			
			if (stat == "lesbianinterest" || stat == "gayinterest") return sd.LesbianInterest = val;
			if (stat == "ponygirlinterest") return sd.PonygirlInterest = val;
			if (stat == "catgirlinterest") return sd.CatgirlInterest = val;
			if (stat == "puppygirlinterest") return sd.PuppygirlInterest = val;
			if (stat == "succubusinterest") return sd.SuccubusInterest = val;
			
			if (stat == "order1") return sd.Order1 = val;
			if (stat == "order2") return sd.Order2 = val;
		
			if (stat == 'slavepronoun') {
				sd.SlavePronoun = vals;
				return 0;
			}
			
			if (stat == "idolmeeting") return sd.VarIdol = val;
			if (stat == "schoolgirlmeeting") return sd.VarSchoolGirl = val;
			if (stat == "puppygirlmeeting") return sd.PuppyGirlFlag = val;
		
			if (stat == "trainings") {
				var str:String = GetXMLStringParsed("Abilities", sd.sNode, "");
				if (str != "") str += "," + vals;
				else str += vals;
				return 0;
			}
			
			if (stat == "lastending") return sd.LastEnding = val;
			
			if (stat == "totalteddybear") return sd.TotalTeddyBear = val;
		
			if (stat.substr(0, 5) == "total") {
				stat = stat.substr(5);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				if (act != null) {
					sd.SetActTotal(act.Act, val);
					coreGame.dspMain.UpdateSexSkills(sd);
					return 0;
				}
			}
			
			if (stat != "difficulty" && stat.substr(0, 10) == "difficulty") {
				stat = stat.substr(10);
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				sd.SetActDifficulty(act.Act, val);
				return 0;
			}
			
			if (stat.substr(0, 4) == "cost") {
				stat = stat.substr(4);
				if (stat.charAt(0) == '_') stat = stat.substr(1);
				var act:ActInfo = slaveData.ActInfoBase.GetActByName(stat);
				if (act != null) {
					act.Cost = val;
					return act.Cost;
				}
			}
			
			if (stat.substr(0, 8) == "savedvar") {
				// set/change a temporary variable for the event
				trace("setting saved var for " + sd.SlaveName + " " + sd.ModuleName);
				stat = stat.substr(8);
				var bString:Boolean = stat.substr(0, 6) == "string";
				if (bString || stat.substr(0, 6) == "number") stat = stat.substr(6);
				var idx:Number = Number(stat);
				if (sd == _root) sd = SMData.GetSlaveObject(sd);
				if (sd.arSaveVars == null) sd.arSaveVars = new Array();
				var len:Number = sd.arSaveVars.length;
				if (isNaN(val) == false && len < (idx + 1)) {
					for (var id:Number = len; id <= idx; id++) sd.arSaveVars.push(0);
				}
				if (bString) sd.arSaveVars[idx] = coreGame.UpdateMacros(vals);
				else sd.arSaveVars[idx] = val;
				return 0;
			}
			
			if (stat == "slavename") {
				sd.SlaveName = vals;
				if (sd == _root || sd == slaveData) coreGame.UpdateOtherSlaveDetails();
				else if (sd == coreGame.AssistantData) coreGame.ServantName = vals;
				return 0;
			}
			if (stat == "slavename1") {
				sd.SlaveName1 = vals;
				if (sd == coreGame.AssistantData) coreGame.ServantName1 = vals;
				return 0;
			}
			if (stat == "slavename2") {
				sd.SlaveName2 = vals;
				if (sd == coreGame.AssistantData) coreGame.ServantName2 = vals;
				return 0;
			}
			
			if (stat == "birthday") return sd.Birthday = val;
			
			if (stat == "loyalty") return sd.Loyalty = val;
		
		}
			
		// UNCOMMON: common to slave and slave maker
		if (stat.substr(0, 10) == "potionused") {
			var str:String = XMLBase.StripParts(stat.substr(10));
			var pot:Number = coreGame.Potions.GetPotionNumber(str);
			return sd.SetPotionUsed(pot, val);
		}
		
		if (stat == "piercings") return sd.PiercingsType = val;
		if (stat == "hasvanitycase") {
			if (sd == SMData) SMData.SMVanityCaseOK = vals.toLowerCase() == "true" ? 1 : 0;
			else sd.VanityCaseOK = vals.toLowerCase() == "true" ? 1 : 0;
			return 0;
		}
		if (stat == "hasnipplerings") {
			if (sd == SMData) SMData.SMNippleRingsOK = vals.toLowerCase() == "true" ? 1 : 0;
			else sd.NippleRingsOk = vals.toLowerCase() == "true" ? 1 : 0;
			return 0;
		}
						
		if (stat == "race") {
			sd.Race = SMData.DecodeRace(vals);
			return 0;
		}
		
		if (sd == SMData) {
			// UNCOMMON: Slave Maker only	
			if (stat == "catgirlstrained") return SMData.CatgirlsTrained = val;
			if (stat == "girlstrained") return SMData.GirlsTrained = val;
			if (stat == "ponygirlstrained") return SMData.PonygirlsTrained = val;
			if (stat == "lesbianstrained") return SMData.LesbiansTrained = val;
			if (stat == "catgirlstrained") return SMData.CatgirlsTrained = val;
			if (stat == "puppygirlstrained") return SMData.PuppygirlsTrained = val;
			if (stat == "dickgirlstrained") return SMData.DickgirlsTrained = val;
			if (stat == "slutstrained") return SMData.SlutsTrained = val;
			if (stat == "cumslutstrained") return SMData.CumslutsTrained = val;
			if (stat == "succubusestrained") return SMData.SuccubusesTrained = val;
			
			if (stat == "talentprogress") return SMData.TalentProgress = val;
			if (stat == "specialevent") return SMData.SMSpecialEvent = val;
			if (stat == "hometown") return SMData.SMHomeTown = val;
			
			if (stat == "hasfeeldo") {
				SMData.SMFeeldoOK = vals.toLowerCase() == "true";
				return 1;
			}
			if (stat == "hasropes") {
				SMData.RopesOK = vals.toLowerCase() == "true" ? 1 : 0;
				return 0;
			}
			if (stat == "hassilkenropes") {
				SMData.SilkenRopesOK = vals.toLowerCase() == "true" ? 1 : 0;
				return 0;
			}
			if (stat == "hasegg") {
				SMData.EggOK = vals.toLowerCase() == "true" ? 1 : 0;
				return 0;
			}
			
			if (stat == "weapontype") {
				if (isNaN(vals)) return SMData.WeaponType = SMData.FindWeaponIdByName(vals);
				return SMData.WeaponType = val;
			}
			if (stat == "armourtype" || stat == "armortype") {
				if (isNaN(vals)) return SMData.WeaponType = SMData.FindArmourIdByName(vals);
				return SMData.ArmourType = val;
			}
			if (stat == "ponygirlaware") {
				if (isNaN(vals)) SMData.PonygirlAware = vals.toLowerCase() == "true" ? 1 : 0;
				else SMData.PonygirlAware = val;
				return 0;
			}
			
			if (stat == "guildmember") {
				SMData.ChangeGuildMembership(vals.toLowerCase() == "true");
				return 0;
			}
			
			if (stat == "theologytraining") return SMData.TheologyTraining = val;
			
			if (stat == "totalsmnun") return SMData.TotalSMNun = val;
			if (stat == "totalsmcourt") return SMData.TotalSMCourt = val;
			if (stat == "totalsmbar") return SMData.TotalSMBar = val;
			if (stat == "totalsmsleazybar") return SMData.TotalSMSleazyBar = val;
			if (stat == "totalsmmartial") return SMData.TotalSMMartial = val;
			if (stat == "totalsmpray") return SMData.TotalSMPray = val;
			if (stat == "totalsmjob") return SMData.TotalSMJob = val;
			if (stat == "totalsmcustom") return SMData.TotalSMCustom = val;
			if (stat == "totalsmspecial") return SMData.TotalSMSpecial = val;
			if (stat == "totalsmtalkslaves") return SMData.TotalSMTalkSlaves = val;
			
			if (stat == "smmoney" || stat == "smgold") return SMData.SMGold = val;
			if (stat == "debt") return SMData.SMDebt = val;
			
			if (stat == "skillpoints") return SMData.SkillPoints = val;
			if (stat == "smhealth") {
				SMData.SetHealth(val);
				return SMData.GetHealth();
			}

			
			// OBSOLETE
			if (stat == "smbust") return SMData.vitalsBustSM = val;
			if (stat == "smclit") return SMData.ClitCockSizeSM = val;
			if (stat == "smcock") return SMData.ClitCockSizeSM = val * 33;
			if (stat == "smfertility") return SMData.Fertility = val;
			if (stat == "smsexualenergy") return SMData.SexualEnergy = val;
				if (stat == "smpregnancygestation") return SMData.PregnancyGestation = val;
			if (stat == "smpregnancycount") return SMData.PregnancyCount = val;
			if (stat == "smpregnancytype") {
				SMData.PregnancyType = vals;
				return 0;
			}
			if (stat == "smtotalchildren") return SMData.TotalSMChildren = val;
	
		}
		
		if (stat.substr(0, 11) == "potionowned") {
			psd = SMData;
			var str:String = XMLBase.StripParts(stat.substr(11));
			var pot:Number = coreGame.Potions.GetPotionNumber(str);
			return SMData.SetPotionOwned(pot, val);
		}
		
		// OTHER
		if (stat == "assistantgender") {
			coreGame.ChangeSlaveGender(coreGame.GetGender(vals), coreGame.AssistantData);
			return sd.SlaveGender;
		}
		
		// Finally, any skills
		
		// slavemaker type skills
		// default the following to Slave Maker not slave
		var i:Number = SMSlaveCommon.DecodeSMSkill(stat);
		trace("skill: " + stat + " " + i);
		if (i > 0) {
			if (!slvt && sd == _root) {
				sd = SMData;
				psd = SMData;	// force update of slavemaker
			} else if (slvt && sd == _root) sd = coreGame.slaveData;
			SMTRACE("set skill: " + stat + " to " + val + " for " + (sd == SMData ? "slavemaker" : sd.SlaveName));
			sd.SetSMSkillLevel(i, val);
			return val;
		}
		
		return undefined;
	}
	
}
