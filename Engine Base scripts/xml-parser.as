import Scripts.Classes.*;

// Private variables
var genNumber:Number;
var genNumber2:Number;
var genString:String;
var genString2:String;

// Functions

// Get a constant value, like a stat, skill or date etc
function GetStatSkill(str:String) : Object 
{
	return GetStSk(str.toLowerCase().split(" ").join("").split("\\n").join("").split("\\r").join("").split("\r\n").join("").split("\t").join(""));
}

function GetStSk(str:String, strup:String) : Object
{
	//trace("GetStSk: " + str);
	// stat of the slave/slavemaker
	var ro:Object = XMLData.GetStat(str);
	if (ro != undefined) {
		//trace("..XMLData.GetStat: ok = " + ro);
		return ro;
	}
	// bit flags
	if (str.substr(0, 4) == "flag") return XMLData.ParseGetFlags(str);
	
	if (str == "actionfull") return LastActionDone;
	if (str == "action" || str == "lastactiondone") return int(LastActionDone);
	if (str == "lastnumevent") return OldNumEvent;
	if (str == "laststrevent" || str == "lastevent") return OldStrEvent;
	if (str == "currentnumevent") return NumEvent;
	if (str == "currentstrevent" || str == "currentevent") return StrEvent;
	if (str == "currframe" || str == "currentframe") return currFrame;
	
	if (str == "hascock") return HasCock ? 1 : 0;
	
	if (str == "date") {
		var gdate:Number = GameDate;
		if (GameTimeMins >= 1440) gdate++;
		return gdate;
	}
	if (str == "weekday") return nDayOfWeek;
	if (str == "weekdayname") return strDayName;
	if (str == "time") {
		var gtime:Number = GameTimeMins;
		if (gtime >= 1440) gtime -= 1440;
		return gtime / 60;
	}
	if (str == "timemins") {
		var gtime:Number = GameTimeMins;
		if (gtime >= 1440) gtime -= 1440;		
		return gtime;
	}
	if (str == "timeremaining") return TrainingTime - Elapsed;
	if (str == "planningtime") return Plannings.PlanningTime;

	if (str == "difficulty") return Difficulty;
	
	if (str == "money" || str == "gold") return VarGold + SMData.SMGold;
	if (str == "slavegold") return VarGold;
	if (str == "paysm") return PaySM;
	if (str == "paysmgp") return PaySM + Language.GP + "";
	if (str == "pay") return Pay;
	if (str == "payrate") return PayRate;
	if (str == "paygp") return "" + Pay + Language.GP + "";
	
	if (str == "rulestalk") return Rules.RulesTalk;
	if (str == "rulesfuck") return Rules.RulesFuck;
	if (str == "rulesgoout") return Rules.RulesGoOut;
	if (str == "rulestouchherself" || str == "rulesmasturbate") return Rules.RulesTouchHerself;
	if (str == "ruleswriteletters") return Rules.RulesWriteLetters;
	if (str == "rulespocketmoney") return Rules.RulesPocketMoney;
	if (str == "rulespray") return Rules.RulesPray;
	if (str == "rulesmilkherself") return Rules.RulesMilkHerself;
	if (str == "rulesarmed") return Rules.RulesArmed;
	
	if (str == "tentaclehaunt") return TentacleHaunt;
	if (str == "trainingtime") return TrainingTime;
	if (str == "dressframe") return DressFrame;
	if (str == "nakedchoice") return NakedChoice;
	if (str == "participanttotal") return Participants.length;
	if (str == "loop") return XMLData.loopvar;
	if (str == "totalmales") return totmales;
	if (str == "totalfemales") return totfemales;
	if (str == "totaldickgirls") return totdickgirls;
	if (str == "totalslaves") return SMData.GetTotalSlavesOwned();
	if (str == "totalslavesinlove") return SMData.GetTotalSlavesInLove();
	if (str == "totalallpeople") return Home.CalculateUpkeepIncome(); // returns total people in the house and otherwise sets some internal variables
	if (str == "totalallchildren") return SMData.GetTotalChildren(SMData.SMSpecialEvent == 2) + _root.SMData.TotalSMChildren;
	if (str == "lendperson") return LendPerson;
	if (str == "visitperson") return VisitLendPerson;
	if (str == "general" || str == "general1") return genNumber;
	if (str == "general2") return genNumber2;
	if (str == "generalstring" || str == "generalstring1") return genString;
	if (str == "generalstring2") return genString2;
	if (str == "assistantgender") return ServantGender;
	if (str == "partnergender" || str == "persongender") return PersonGender;
	if (str == "personothergender") return PersonOtherGender;
	if (str == "partnergendername" || str == "persongendername") return Language.GetGenderString(PersonGender);
	if (str == "badgirl") return BadGirl;
	
	// Moon
	if (str == "moonphasedate") return MoonPhaseDate;
	if (str == "newmoondays") return MoonPhaseDate < 16 ? 15 - MoonPhaseDate : (29 - MoonPhaseDate) + 15;
	if (str == "fullmoondays") return 29 - MoonPhaseDate;
	
	if (str.substr(0, 3) == "var") {
		var idx:Number = Number(str.substr(3));
		if (!isNaN(idx) && XMLData.tempVars.length < (idx + 1)) {
			for (var id:Number = XMLData.tempVars.length; id <= idx; id++) XMLData.tempVars.push(0);
		}
		//SMTRACE("value: var" + idx + " = " + XMLData.tempVars[idx]);
		return XMLData.tempVars[idx];
	}

	if (str == "eventtotal" || str == "visittotal" || str == "lendtotal" || str == "walktotal") { 
		if (currentShop != null) return currentShop.TotalVisit;
		if (WalkPlace == 0) return EventTotal;
		var plc:Place = currentCity.GetPlaceInstance(WalkPlace);
		if (plc != null) return plc.GetEventTotal(XMLData.GetCurrentNode());
		return 0;
	} 
	
	if (str == "maxslaves") return SMData.SlavesArray.length;
	if (str == "antidotedays") return AntidoteDays;
	if (str == "reluctancelevel") return ReluctanceLevel;
	if (str.substr(0, 11) == "configvalue") {
		str = XMLBase.StripParts(str.substr(11));
		return config.GetValue(str);
	}
	
	if (str.substr(0, 11) == "displaytime") {
		str = XMLBase.StripParts(str.substr(11));
		if (str == "") return DecodeTimeMins(GameTimeMins);
		if (str == "planning") return DecodeTime(Plannings.PlanningTime);
		if (str.substr(0, 4) == "mins") str = str.substr(4);
		return DecodeTime(Number(XMLData.GetExpression(str)));
	}
	if (str.substr(0, 11) == "displaydate") {
		str = XMLBase.StripParts(str.substr(11));
		if (str == "") return DecodeDate(GameDate);
		return DecodeDate(Number(XMLData.GetExpression(str)));
	}
	
	if (str == "ending") return NumFin;
	if (str == "oldending") return OldNumFin;
	if (str == "score") return Score;
	
	if (str == "aroused") return Aroused;
		
	if (str == "previousaction") return PreviousActionDone;
	
	if (str == "slavefolder") return ImageFolder;
	if (str == "assfolder") return AssistantData.ImageFolder;
	
	if (str == "plugtype") return PlugType;
	
	if (str == "slaveexperience") return SlaveExperience;
	if (str == "slaveacts") return SlaveActs;
	if (str == "missingexperience") return GetMissingExperience();
	
	if (str == "doneevent") return DoneEvent;
	if (str == "numerchant" || str == "tradervisits") return NumMerchant;
	
	if (str == "nocturnal") return bNocturnal;
	
	if (str == "bustcurrent") return vitalsBustCurrent;
	
	// Contests
	if (str == "rivalascore") return Contests.RivalAScore;
	if (str == "rivalbscore") return Contests.RivalBScore;
	if (str == "rivalcscore") return Contests.RivalCScore;
	if (str == "rivaldscore") return Contests.RivalDScore;
	if (str == "rivalescore") return Contests.RivalEScore;
	if (str == "placing") return Contests.Placing;
	if (str == "numcontest") return Contests.NumContest;
	if (str == "score") return Score;
	if (str == "scoregp") return Score + Language.GP + "";
	if (str == "wincontest") return WinContest;
	
	// House
	ro = currentCity.Home.ParseGetHomeDetails(str);
	if (ro != undefined) return ro;
	
	// City
	if (str == "cityname") return currentCity.GetName();
	if (str == "cityarea") return currentCity.GetCurrentArea();
	
	// event variables
	ro = modulesList.GetExEventVariable(str);
    if (ro != undefined) return ro;
	
	// Combat
	ro = Combat.ParseGetCombatDetails(str);
	if (ro != undefined) return ro;
	
	// arbitrary as variable
	if (strup == undefined) strup = str;
	if (_root[strup] != undefined) return _root[strup];

	return undefined;
}

// Set a value to a stat/skill
function SetStatSkill(str:String, val:Number, vs:String, strup:String) : Number
{
	str = str.toLowerCase().split(" ").join("").split("\\n").join("").split("\\r").join("").split("\r\n").join("").split("\t").join("");
	//trace("SetStatSkill: " + str);
	var ret:Number = XMLData.SetStat(str, val, vs);
	if (ret != undefined) {
		// psd - object(slave, slave maker) being updated
		if (XMLData.psd == SMData) {
			SMData.UpdateSlaveMaker();
			SMData.ShowSMQualities();
		} else if (XMLData.psd == _root || XMLData.psd == slaveData) UpdateSlave();
		//trace("XMLData.SetStat: ok = " + ret);
		return ret;
	}
	
	if (str.substr(0, 4) == "flag") {
		XMLData.SetSingleFlag(str, val, vs);
		return 0;
	}
	
	if (str == "currentnumevent") return NumEvent = val;
	if (str == "currentstrevent") {
		StrEvent = vs;
		return 0;
	}
	if (str == "actionfull") return LastActionDone = val;
	
	if (str == "rulestalk") return Rules.ChangeRuleTo(0, val, true);
	if (str == "rulesfuck") return Rules.ChangeRuleTo(2, val, true);
	if (str == "rulesgoout") return Rules.ChangeRuleTo(2, val, true);
	if (str == "rulestouchherself" || str == "rulesmasturbate") return Rules.ChangeRuleTo(4, val, true);
	if (str == "ruleswriteletters") return Rules.ChangeRuleTo(5, val, true);
	if (str == "rulespocketmoney") return Rules.ChangeRuleTo(6, val, true);
	if (str == "rulespray") return Rules.ChangeRuleTo(1, val, true);
	if (str == "rulesmilkherself") return Rules.ChangeRuleTo(7, val, true);
	if (str == "rulesarmed") return Rules.ChangeRuleTo(8, val, true);
		
	if (str == "partnergender" || str == "persongender") return PersonGender = GetGender(vals);

	if (str == "paysm") return PaySM = val;
	if (str == "pay") return Pay = val;
	if (str == "payrate") return PayRate = val;
	
	if (str == "lendperson") return LendPerson = val;
	if (str == "tentaclehaunt") {
		var plc:Place = currentCity.GetPlaceObject(vs);
		if (plc != null) val = plc.Id;
		return TentacleHaunt = val;
	}
	if (str == "trainingtime") return TrainingTime = val;
	if (str == "badgirl") return BadGirl = val;
	
	if (str == "intropage") return IntroPage = val;
	
	if (str == "general" || str == "general1") return genNumber = val;
	if (str == "general2") return genNumber2 = val;
	if (str == "generalstring" || str == "generalstring1") {
		genString = vs;
		return 0;
	}
	if (str == "generalstring2") {
		genString2 = vs;
		return 0;
	}	
	
	if (str == "byyou") {
		ByYou = (vs.toLowerCase() == "true");
		return 0;
	}
	if (str == "assistantgender") {
		ChangeAssistantGender(GetGender(vs));
		return ServantGender;
	}
	if (str == "dickgirlchanged") {
		DickgirlChanged = vs.toLowerCase() == "true";
		if (DickgirlChanged) Icons.ShowDickgirlIconNow();
		return 1;
	}
	if (str == "standarddgtext") {
		StandardDGText = vs.toLowerCase() == "true";
		return 1;
	}
	if (str == "standardcstext") {
		StandardCSText = vs.toLowerCase() == "true";
		return 1;
	}
	if (str == "standardplugtext") {
		StandardPlugText = vs.toLowerCase() == "true";
		return 1;
	}	
	if (str == "appendacttext") {
		AppendActText = vs.toLowerCase() == "true";
		return 1;
	}
	if (str == "allowevents") {
		bAllowEvents = vs.toLowerCase() == "true";
		return 1;
	}	
	if (str == "usegeneric") {
		UseGeneric = vs.toLowerCase() == "true";
		return 1;
	}
	if (str == "dressframe" || str == "nakedchoice") {
		if (str == "nakedchoice") return NakedChoice = val;
		else return DressFrame = val;
	}
	if (str == "date") {
		str = XMLData.EventText;
		StopPlanning(false, true);
		UpdateDateAndItems(val, false);
		XMLData.EventText = str;
		return 1;
	}
	if (str == "time") {
		SetTime(val);
		return 1;
	}
	if (str == "timemins") {
		SetTimeMins(val);
		return 1;
	}
	
	if (str == "rivalascore") return Contests.RivalAScore = val;
	if (str == "rivalbscore") return Contests.RivalBScore = val;
	if (str == "rivalcscore") return Contests.RivalCScore = val;
	if (str == "rivaldscore") return Contests.RivalDScore = val;
	if (str == "rivalescore") return Contests.RivalEScore = val;
	if (str == "placing") return Contests.Placing = val;
	if (str == "numcontest") return Contests.NumContest = val;
	if (str == "wincontest") return WinContest = val;
	
	if (str == "antidotedays") return AntidoteDays = val;
	if (str == "reluctancelevel") return ReluctanceLevel = val;
	
	if (str == "ending") return NumFin = val;
	if (str == "score") return Score = val;
	
	if (str == "doneevent") return DoneEvent = val;
	if (str == "numerchant" || str == "tradervisits") return NumMerchant = val;
	
	if (str == "islevelup" || str == "levelup") {
		LevelUp = vs.toLowerCase() == "true";
		return 1;
	}
	
	if (str == "catgirlscommon") {
		bCatgirlsCommon = vs.toLowerCase() == "true";
		return 1;
	}
	
	if (str == "currentsuperviseyourself" || str == "willsupervise") {
		CurrentSuperviseYourself = vs.toLowerCase() == "true";
		return 1;
	}
	
	if (str == "nocturnal") {
		bNocturnal = vs.toLowerCase() == "true";
		return 1;
	}
	
	// house information
	ret = currentCity.Home.ParseSetHomeDetails(str, val, vs);
	if (ret != undefined) return 1;
	
	// events
	ret = modulesList.SetExEventVariable(str, val, vs);
	if (ret != undefined) return ret;
	
	// arbitrary variable
	if (strup == undefined) strup = str;
	if (_root[strup] != undefined) {
		if (typeof(_root[strup]) == "string") {
			_root[strup] = vs;
			return 1;
		} else return _root[strup] = val;
	}
	
	return undefined;
}

//
// Main conditional evaluator

function ParseConditional(aNode:XMLNode, andf:Boolean, nflg:Boolean, defaultnc:Boolean) : XMLNode
{
	var doit:Boolean = andf;
	var dothis:Boolean = defaultnc;
	var val:Number;
	var valo:Object;
	var attrl:String;
	var attrvl:String;
	var sd:Object;

	for (var attr:String in aNode.attributes) {
		attrl = attr.toLowerCase();
		attrvl = aNode.attributes[attr].toLowerCase();
		//SMTRACE("conditional: " + attrl + "=" + attrvl);
		if (attrl == "chance") dothis = ((Math.random()*100) < XMLData.GetExpression(attrvl));	// inlined PercentChance
		else if (attrl == "supervise" || attrl == "supervisor") {
			if (attrvl == "slavemaker") dothis = Supervise;
			else if (attrvl == "assistant") dothis = !Supervise;
			else dothis = Supervise == (attrvl == "true");
		} else if (attrl == "supergender" || attrl == "supervisorgender") dothis = TestGender(attrvl, Supervise ? SMData.Gender : ServantGender);
		else if (attrl == "partnergender" || attrl == "persongender") dothis = TestGender(attrvl, PersonGender);
		else if (attrl == "personothergender") dothis = TestGender(attrvl, PersonOtherGender);
		else if (attrl == "gender") dothis = TestGender(attrvl, SMData.Gender);
		else if (attrl == "naked") dothis = Naked == (attrvl != "false");
		else if (attrl == "day") dothis = Day != (attrvl == "false");
		else if (attrl == "guildmember") dothis = SMData.GuildMember != (attrvl == "false");
		else if (attrl == "date" && (attrvl == "contest" || attrvl == "ownertesting")) {
			if (attrvl == "contest") dothis = ((GameDate % 8) == 0);
			else dothis = ((Elapsed % 7) == 0);
		} else if (attrl == "owner") {
			sd = XMLData.GetSlaveTarget(attrl);
			var onn:Number = sd.Owner.GetOwner();
			if (isNaN(attrvl)) {
				if (attrvl == "npc") dothis = (onn > 0 && onn < 1000);
				else if (attrvl == "unowned") dothis = (onn == 0);
				else if (attrvl == "commission") dothis = (onn == 1999);
				else if (attrvl == "named") dothis = ((onn > 0 && onn < 1000) || onn >= 2000);
				else if (attrvl == "another") dothis = onn > 0 && !sd.Owner.IsPersonallyOwned();
				else if (attrvl == "slavemaker") dothis = sd.Owner.IsPersonallyOwned() || onn == 0;
				else dothis = (sd.Owner.GetOwnerName().split(" ").join("").split(".").join("").toLowerCase() == attrvl.split(" ").join("").split(".").join("").toLowerCase());
			} else dothis = onn == Number(attrvl);
		} else if (attrl == "lesbiantraining" || attrl == "gaytraining") dothis = LesbianTraining != (attrvl == "false");
		else if (attrl == "lesbian" || attrl == "gay" || attrl == "lesbianact" || attrl == "gayact") dothis = Lesbian != (attrvl == "false");
		else if (attrl == "isdickgirlchangable") dothis = DickgirlChangable != (attrvl == "false");
		else if (attrl == "ispluginserted") dothis = (PlugInserted  > 0) != (attrvl == "false");
		else if (attrl == "dickgirlchangeevent") dothis = IsDickgirlChangeEvent(Number(attrvl));
		else if (attrl.substr(0, 4) == "item") {
			var sl:Array = XMLBase.SplitParts(attrl);
			val = Items.GetItemIdxFromNameBase(sl[1]);
			if (val == -1) val = Number(sl[1]);
			if (sl[0] == "itemworn") dothis = Items.IsItemWorn(val) != (attrvl == "false");
			else if (sl[0] == "itemowned") dothis = Items.IsItemAvailable(val) != (attrvl == "false");
		} else if (attrl.substr(0, 12) == "uniformowned") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var obj:Object = slaveData.GetUniformDetails(sl[1]);
			dothis = (obj.owned == 1) != (attrvl == "false");
			delete obj;
		} else if (attrl == "weaponowned") dothis = SMData.IsWeaponOwned(attrvl);
		else if (attrl == "armourowned" || attr == "armorowned") dothis = SMData.IsArmourOwned(attrvl);
		else if (attrl.substr(0, 11) == "smadvantage" || attrl.substr(0, 13) == "sminitialitem") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var str:String = sl[1];
			for (var i:Number = 0; i < 29; i++) {
				if (str == SMData.GetSMQualitiesName(i).split(" ").join("").toLowerCase()) {
					str = i + "";
					break;
				}
			}
			if (attrl.substr(0, 11) == "smadvantage") dothis = SMData.SMAdvantages.CheckBitFlag(Number(str)) != (attrvl == "false");
			else dothis = SMData.SMInitialItems.CheckBitFlag(Number(str)) != (attrvl == "false");
		} else if (attrl.substr(0, 10) == "isanyslavetrainedas") {
			var sl:Array = XMLBase.SplitParts(attrl);
			dothis = SMData.GetAnySlaveTrainedAs(sl[1]) != null;
		} else if (attrl == "slaveavailable" || attrl == "isslaveavailable") {
			var sl:Array = XMLBase.SplitParts(attrl);
			if (sl.length > 1) dothis = SMData.IsSlaveAvailable(UpdateMacros(sl[1])) != (attrvl == "false");
			else dothis = SMData.IsSlaveAvailable(UpdateMacros(attrvl));
		} else if (attrl == "slaveowned" || attrl.substr(0, 12) == "isslaveowned") {
			var sl:Array = XMLBase.SplitParts(attrl);
			if (sl.length > 1) dothis = SMData.IsSlaveOwned(UpdateMacros(sl[1])) != (attrvl == "false");
			else dothis = SMData.IsSlaveOwned(UpdateMacros(attrvl));
		} else if (attrl.substr(0, 14) == "isslaveunowned") {
			var sl:Array = XMLBase.SplitParts(attrl);
			if (sl.length > 1) dothis = SMData.IsSlaveUnowned(UpdateMacros(sl[1])) != (attrvl == "false");
			else dothis = SMData.IsSlaveUnowned(UpdateMacros(attrvl));
		} else if (attrl == "slave" || attrl.substr(0, 7) == "isslave") {
			var sd:Object = _root;
			var str:String = XMLData.ParseSlaveTarget(attrl);
			if (XMLData.psd != _root) sd = XMLData.psd;
			if (attrvl == "false" || attrvl == "true") dothis = slaveData.IsSlave(SMData.GetSlaveObject(sd));
			else dothis = sd.IsSlave(UpdateMacros(attrvl));
			
		} else if (attrl == "assistant") {
			if (attrvl == "" || attrvl == undefined || attrvl == "none") dothis = IsNoAssistant();
			else if (attrvl == "any") dothis = !IsNoAssistant();
			else dothis = IsAssistant(UpdateMacros(attrvl));
		} else if (attrl == "tentacleevent") dothis = Tentacles.IsTentacleEvent() != (attrvl == "false");
		else if (attrl == "dickgirlevent" || attrl == "isdickgirlevent") dothis = IsDickgirlEvent() != (attrvl == "false");
		else if (attrl == "catgirlevent" || attrl == "iscatgirlevent") dothis = Catgirls.IsCatgirlEvent() != (attrvl == "false");
		else if (attrl.substr(0, 15) == "istrainingevent") {
			var sl:Array = XMLBase.SplitParts(attrl);
			dothis = modulesList.GetTraining(sl[1]).IsTrainingEvent() != (attrvl == "false");
		} else if (attrl == "firsttimetoday") {
			dothis = FirstTimeToday != (attrvl == "false");
			if (WalkPlace != 0)  {
				var plc:Place = currentCity.GetPlaceInstance(WalkPlace);
				if (plc != null) dothis = plc.GetEventTotalToday(XMLData.GetCurrentNode()) == 0;
			}
		}
		else if (attrl == "iseventallowable") dothis = IsEventAllowable() != (attrvl == "false");
		else if (attrl == "appendacttext") dothis = AppendActText != (attrvl == "false");
		else if (attrl == "allowevents") dothis = bAllowEvents != (attrvl == "false");
		else if (attrl == "byyou") dothis = ByYou != (attrvl == "false");
		else if (attrl == "standardplugtext") dothis = StandardPlugText != (attrvl == "false");
		else if (attrl == "standarddgtext") dothis = StandardDGText != (attrvl == "false");
		else if (attrl == "standardcstext") dothis = StandardCSText != (attrvl == "false");
		else if (attrl == "anyweaponowned") dothis = SMData.IsWeaponClassOwned(attrvl);
		else if (attrl == "dickgirlchanged") dothis = DickgirlChanged != (attrvl == "false");
		else if (attrl == "actionname" || attrl == "actname") {
			if (Plannings.IsStarted()) dothis = (int(LastActionDone) == slaveData.ActInfoBase.GetActByName(attrvl.split("-").join("")).Act);
			else if (ParticipantsChanger._visible) dothis = (Math.abs(int(Action)) == slaveData.ActInfoBase.GetActByName(attrvl.split("-").join("")).Act);
			else dothis = (Math.abs(int(ActionChoice)) == slaveData.ActInfoBase.GetActByName(attrvl.split("-").join("")).Act);
		} else if (attrl == "isactshown" || attrl == "isactavailable") {
			var acti:ActInfo = slaveData.ActInfoBase.GetActByName(attrvl.split("-").join(""));
			dothis = acti == null ? (attrvl == "false") : (acti.IsShown() != (attrvl == "false"));
		} else if (ParticipantsChanger._visible) dothis = (Math.abs(int(Action)) == slaveData.ActInfoBase.GetActByName(attrvl.split("-").join("")).Act);
		else if (attrl == "fullmoon") {
			if (attrvl == "close") dothis = (MoonPhaseDate < 3) != (attrvl == "false");
			else dothis = (MoonPhaseDate == 1) != (attrvl == "false");
		} else if (attrl == "newmoon") {
			if (attrvl == "close") dothis = (MoonPhaseDate > 13 && MoonPhaseDate < 17) != (attrvl == "false");
			else dothis = (MoonPhaseDate == 15) != (attrvl == "false");
		} else if (attrl == "roomexplored" || attrl == "isroomexplored") {
			if (attrvl == "current") dothis = HouseEvents.IsCurrentRoomExplored();
			else dothis = HouseEvents.IsRoomExplored(aNode.attributes[attr]);
		} else if (attrl == "currentslave" || attrl == "partner" || attrl == "participant") {
			if (attrvl == "slavemaker") dothis = (PersonIndex == -100);
			else if (attrvl == "assistant") dothis = (PersonIndex == -99);
			else if (attrvl == "slave") dothis = (PersonIndex == -50);
			else dothis = SMData.GetSlaveByIndex(PersonIndex).IsSlave(UpdateMacros(attrvl));
		} else if (attrl == "anypartner") dothis = IsParticipant(attrvl);
		else if (attrl.substr(0, 11) == "slavegender") dothis = TestGender(attrvl, XMLData.GetSlaveTarget(attrl).SlaveGender);
		else if (attrl == "house") dothis = currentCity.Home.IsHouse(attrvl);
		else if (attrl.substr(0, 10) == "ispregnant") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var per:Person = People.GetPersonsObject(str);
			if (per != null) dothis = (per.PregnancyGestation > 0) != (attrvl == "false");
			else {
				var idx:Number = People.DecodePersonDetails(sl[1], -50);
				dothis = (SMData.GetSlaveByIndex(idx).PregnancyGestation > 0) != (attrvl == "false");
			}
		} else if (attrl.substr(0, 13) == "canimpregnate") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var str:String = sl[1];
			var per:Person = People.GetPersonsObject(str);
			attrvl = UpdateMacros(attrvl).toLowerCase();
			if (attrvl == "true") attrvl = "yours";
			if (per != null) dothis = per.CanImpregnate(attrvl);
			else {
				var idx:Number = People.DecodePersonDetails(str, -50);
				dothis = SMData.GetSlaveByIndex(idx).CanImpregnate(attrvl);
			}			
		} else if (attrl.substr(0, 12) == "isaccessible") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var str:String = sl[1];
			var per:Person = People.GetPersonsObject(str);
			if (per != null) dothis = per.IsAccessible() != (attrvl == "false");
			else {
				var plc:Place = currentCity.GetPlaceObject(str);
				if (plc != null) dothis = plc.IsAccessible() != (attrvl == "false");
			}
		} else if (attrl.substr(0, 9) == "isvisited") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var str:String = sl[1];
			var per:Person = People.GetPersonsObject(str);
			if (per != null) dothis = per.IsVisited() != (attrvl == "false");
			else {
				var plc:Place = currentCity.GetPlaceObject(str);
				if (plc != null) dothis = plc.IsVisited() != (attrvl == "false");
				else if (currentShop != null) dothis = currentShop.bInitialVisit != (attrvl == "true");
			}
		} else if (attrl.substr(0, 13) == "testobedience") {
			var sd:Object = _root;
			var str:String = XMLData.ParseSlaveTarget(attrl);
			if (XMLData.psd != _root) {
				sd = XMLData.psd;
				attrl = str;
			}
			var sl:Array = XMLBase.SplitParts(attrl);
			var str:String = sl[1];
			var idx:Number = slaveData.ActInfoBase.GetActByName(str.split("-").join("")).Act;
			if (sd == _root) dothis = TestObedience(GetActDifficulty(idx), idx) != (attrvl == "false");
			else dothis = sd.IsObedient(GetActDifficulty(idx), idx) != (attrvl == "false");
		} else if (attrl.substr(0, 5) == "ismet") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var str:String = sl[1];
			var per:Person = People.GetPersonsObject(str);
			if (per != null) dothis = per.IsMet() != (attrvl == "false");
		} else if (attrl == "deficiency") {
			if (Deficiency == 0) dothis = false;
			else dothis = Deficiency == SlaveStatistics.GetDeficiencyTalent(attrvl); 
		} else if (attrl == "naturaltalent") {
			if (NaturalTalent == 0) dothis = false;
			else dothis = NaturalTalent == SlaveStatistics.GetDeficiencyTalent(attrvl); 
		} 
		
		else if (attrl.substr(0, 8) == "anyorder") {
			var sd:Object = _root;
			var str:String = XMLData.ParseSlaveTarget(attrl);
			if (XMLData.psd != _root) {
				sd = XMLData.psd;
				attrl = str;
			}
			var sl:Array = XMLBase.SplitParts(attrl);
			var actn:Number = Number(sl[1]);
			if (isNaN(actn)) {
				var act:ActInfo = slaveData.ActInfoCurrent.GetActByName(attrl);
				actn = act.Act;
			}
			dothis = (actn == sd.Order1 || actn == sd.Order2) != (attrvl == "false");
		} else	if (attrl.substr(0, 5) == "level") {
			var sd:Object = _root;
			var str:String = XMLData.ParseSlaveTarget(attrl);
			if (XMLData.psd != _root) {
				sd = XMLData.psd;
				attrl = str;
			}
			var sl:Array = XMLBase.SplitParts(attrl);
			var act:ActInfo = slaveData.ActInfoCurrent.GetActByName(sl[1]);
			val = GetLastSexActLevel(act.Act, sd);
			var bgt:Boolean = false;
			var blt:Boolean = false;
			if (attrvl.substr(-1, 1) == "+") {
				attrvl = attrvl.substr(0, attrvl.length - 1);
				bgt = true;
			} else if (attrvl.substr(-1, 1) == "-") {
				attrvl = attrvl.substr(0, attrvl.length - 1);
				blt = true;
			}
			var valtest:Number = Number(attrvl);
			if (isNaN(valtest)) {
				switch(attrvl) {
					case 'untrained': valtest = -1; break;
					case 'limited skill': valtest = 1; break;
					case 'basic proficiency': valtest = 2; break;
					case 'skilled': valtest = 3; break;
					case 'expert': valtest = 4; break;
					case 'mastered': valtest = 5; break;
				}
			}
			
			if (bgt) {
				if (valtest <= 0) dothis = val > 0;
				else dothis = val >= valtest;
			} else if (blt) {
				if (valtest <= 0) dothis = val <= 0;
				else dothis = val <= valtest;
			} else {
				if (valtest <= 0) dothis = val <= 0;
				else dothis = val == valtest;
			}
		} else if (attrl.substr(0, 9) == "lactating") {
			sd = XMLData.GetSlaveTarget(attrl);
			if ((sd.MilkInfluence > 0 || sd.Lactation > 0) && attrvl == "true") dothis = true;
			else if ((sd.MilkInfluence == 0 && sd.Lactation == 0) && attrvl == "false") dothis = true;
			else dothis = false;
		}
		
		else if (attrl == "doxml") dothis = XMLData.ParseDoEvent("doxml", aNode, attrvl);
		else if (attrl == "doxmlact") dothis = XMLData.ParseDoEvent("doxmlact", aNode, attrvl);
		else if (attrl == "doxmlevent") dothis = XMLData.ParseDoEvent("doxmlevent", aNode, attrvl);
		else if (attrl == "pickanddoxmlevent") dothis = XMLData.ParseDoEvent("pickanddoxmlevent", aNode, attrvl);
		
		else if (attrl == "bustratio") dothis = XMLData.ParsePercentValue(int(10 * int(vitalsBustCurrent + 0.9) / int(vitalsBustStart)) / 10, attrvl);
		else if (attrl == "cockratio") dothis = XMLData.ParsePercentValue(int(10 * int(ClitCockSize + 0.9) / int(ClitCockSizeStart)) / 10, attrvl);
		else if (attrl == "smbustratio") dothis = XMLData.ParsePercentValue(int(10 * int(SMData.vitalsBustSM + 0.9) / int(SMData.vitalsBustStartSM)) / 10, attrvl);
		else if (attrl == "smcockratio") dothis = XMLData.ParsePercentValue(int(10 * int(SMData.ClitCockSizeSM + 0.9) / int(SMData.ClitCockSizeStartSM)) / 10, attrvl);

		else if (attrl == "walkplace") {
			if (!isNaN(attrvl)) dothis = WalkPlace == Number(attrvl);
			else {
				var plc:Place = currentCity.GetPlaceObject(attrvl);
				dothis = WalkPlace == plc.Id;
			}
		}
		else if (attrl == "ismetadone") {
			var sl:Array = XMLBase.SplitParts(attrl);
			var val:Number = sl[1];
			dothis = IsMetaDone(val) != (attrvl == "false");
		}		
		
		// options
		else if (attrl == "furries") dothis = Options.FurriesOn != (attrvl == "false");
		else if (attrl == "nonhumans") dothis = Options.NonHumansOn != (attrvl == "false");
		else if (attrl == "usegeneric") dothis = UseGeneric != (attrvl == "false");
		else if (attrl == "milkable") dothis = Milkable != (attrvl == "false");
		else if (attrl == "incest") dothis = Options.IncestOn != (attrvl == "false");
		else if (attrl == "bdsm") dothis = Options.BDSMOn != (attrvl == "false");
		else if (attrl == "rape") dothis = Options.RapeOn != (attrvl == "false");
		else if (attrl == "pregnancy") dothis = Options.PregnancyOn != (attrvl == "false");
		else if (attrl == "badends") dothis = Options.BadEndsOn != (attrvl == "false");
		else if (attrl == "soundson") dothis = Options.bSoundsOn != (attrvl == "false");
		else if (attrl == "catgirlscommon") dothis = bCatgirlsCommon != (attrvl == "false");
		else if (attrl == "dickgirllesbians") dothis = Options.DickgirlLesbians != (attrvl == "false");
		else if (attrl == "dickgirltesticles") dothis = Options.DickgirlTesticles != (attrvl == "false");
		else if (attrl == "ponygirls") dothis = Options.PonygirlsOn != (attrvl == "false");
		else if (attrl == "dickgirls") dothis = (Options.DickgirlOn == 1) != (attrvl == "false");
		else if (attrl == "tentacles") dothis = (Options.TentaclesOn == 1) != (attrvl == "false");
		
		// assistant
		else if (attrl == "assistantgender") dothis = TestGender(attrvl, ServantGender);
		else if (attrl == "assistantrape") dothis = AssistantRape != (attrvl == "false");
		else if (attrl == "assistanttentaclesex") dothis = AssistantTentacleSex != (attrvl == "false");
		else if (attrl == "assistantfemale") dothis = ServantFemale != (attrvl == "false");		// OBSOLETE
		else if (attrl == "housequalities") dothis = Home.HasQuality(attrvl);
		
		// meta tags for not/and/or
		else if (attrl == "not") {
			nflg = (attrvl == "true");
			continue;
		} else if (attrl == "and") {
			andf = (attrvl == "true");
			continue;
		} else if (attrl == "or") {
			andf = (attrvl != "true");
			continue;
		}

		else {
			// general stat/skill check
			valo = GetStSk(attrl);
			//SMTRACE("  valo: " + valo + " " + typeof(valo));
			if (valo == undefined) {
				var rets:String = modulesList.GetExEventString(attr);
				if (rets != undefined) dothis = (rets.toLowerCase() == aNode.attributes[attr].toLowerCase());
				continue;
			}

			if (typeof(valo) == "number" || typeof(valo) == "boolean") {
				// Number type variable
				val = Number(valo);
				var bgt:Boolean = false;
				var blt:Boolean = false;
				var cnflg:Boolean = false;
				if (attrvl.substr(0, 1) == "!") {
					// not operand eg <if slavetype='!1'>
					cnflg = true;
					attrvl = attrvl.substr(1);
					//trace("not " + attrl + "=" + attrvl + " " + Number(valo));
				}
				attrvl = attrvl.substr(-1, 1) == "%" ? attrvl.substr(0, attrvl.length - 1) : attrvl;
				if (attrvl.substr(-1, 1) == "+") {
					attrvl = attrvl.substr(0, attrvl.length - 1);
					bgt = true;
				} else if (attrvl.substr(-1, 1) == "-") {
					attrvl = attrvl.substr(0, attrvl.length - 1);
					blt = true;
				}
				var testval:Number = XMLData.GetExpression(attrvl);
				//SMTRACE("  testval: " + testval);
				if (bgt) dothis = val >= testval;
				else if (blt) dothis = val <= testval;
				else dothis = val == testval;
				if (cnflg) dothis = !dothis;
			} else {
				// String type
				var ro:Object = GetStSk(attrvl);
				//SMTRACE("  testval: " + ro);
				if (ro == undefined) dothis = (String(valo).toLowerCase() == UpdateMacros(attrvl.toLowerCase()));
				else dothis = (String(valo).toLowerCase() == String(ro).toLowerCase());
			}
		}
		
		//SMTRACE("  curr = " + doit + " : " + attrl + "=" + attrvl + " : result = " + dothis + " : not = " + nflg);
		if (nflg) doit = andf ? doit && !dothis : doit || !dothis;
		else {
			doit = andf ? doit && dothis : doit || dothis;
			if (andf && !dothis) break;		// stop evaluating when we get a false condition
		}
	}

	//SMTRACE("conditional result = " + doit + " (" + dothis + ")");

	// special case, no conditional elements, treat as false
	if (dothis == undefined) return null;

	// if total result true, then return the event node's children
	if (doit) {
		return aNode.firstChild == null ? aNode : aNode.firstChild;
	}
	// find else and return first node after it
	for (var elseNode:XMLNode = aNode.firstChild; elseNode != null; elseNode = elseNode.nextSibling) {
		if (elseNode.nodeType == 1 && elseNode.nodeName.toLowerCase() == "else") return elseNode.nextSibling;
	}
	// no else clause, return null (ie false)
	return null;
}




//
// Main event parser
//
function ParseEvent(eNode:XMLNode, done:Boolean) : Boolean
{
	var ifNode:XMLNode;
	var str:String;
	var per:Number;
	//trace("ParseEvent: " + eNode.parentNode.nodeName);
	
	for (var aNode:XMLNode = eNode; aNode != null && !XMLData.endparse; aNode = aNode.nextSibling) {
		if (aNode.nodeType == 3) {
			done = true;
			// inlined strLineChanges
			str = aNode.nodeValue;
			if (str != undefined) {
				XMLData.EventText += UpdateMacros(str.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join(""));
				//SMTRACE("..XMLData.EventText = " + XMLData.EventText);
			}
			continue;
		}

		str = aNode.nodeName.toLowerCase();
		//SMTRACE("handling xml: <" + str + ">");
		
		if (str == "if") {
			ifNode = ParseConditional(aNode, true, false);
			if (ifNode != null) done = ParseEvent(ifNode, done);
			continue;
		}
		if (str == "ifor") {
			ifNode = ParseConditional(aNode, false, false);
			if (ifNode != null) done = ParseEvent(ifNode, done);
			continue;
		}
		if (str == "ifnot") {
			ifNode = ParseConditional(aNode, false, true);
			if (ifNode != null) done = ParseEvent(ifNode, done);
			continue;
		}
		
		if (str == "addtext" || str == "settext") {
			done = true;
			var buse:Boolean = XMLData.IsHandlingEvent();
			var lfb:Number = 0;
			var lfa:Number = 0;
			var bStart:Boolean = false;
			var bGeneral:Boolean = false;
			var bypass:Boolean = false;
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "before") lfb = Number(aNode.attributes[attr]);
				else if (attr.toLowerCase() == "after") lfa = Number(aNode.attributes[attr]);
				else if (attr.toLowerCase() == "bypass") bypass = aNode.attributes[attr].toLowerCase() == "true";
				else if (attr.toLowerCase() == "start") bStart = aNode.attributes[attr].toLowerCase() == "true";
			}
			if (str == "settext") {
				// SetText()
				XMLData.EventText = "";
				FontText = "";
				Language.LargerText = "";
				if (!GirlsStoryTop._visible && !NextEnding._visible) {
					LargerTextField.content.LargerTextField.htmlText = "";
					LargerTextField._visible = false;
					LargerTextField.invalidate();
				}
				Language.GeneralText = "";
				if (bypass) {
					XMLData.SetHandlingEvent(false);
					SetText("");
					XMLData.SetHandlingEvent(buse);
				}
			}
			if (lfb > 0) for (var i:Number = 0; i < lfb; i++) XMLData.EventText += "\r";
			// inlined strLineChanges
			ParseEvent(aNode.firstChild, done);
			//str = aNode.firstChild.nodeValue;
			//if (str != undefined) XMLData.EventText += UpdateMacros(str.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join(""));
			if (lfa != 0) {
				for (var i:Number = 0; i < lfa; i++) XMLData.EventText += "\r";
			}
			if (bStart || bypass) {
				XMLData.SetHandlingEvent(false);
				if (bStart) AddTextToStart(XMLData.EventText);
				else if (str == "settext") SetText(XMLData.EventText);
				else AddText(XMLData.EventText);
				XMLData.SetHandlingEvent(buse);
				XMLData.EventText = "";
			}
			continue;
		}
		
		if (str == "personspeak") {
			done = true;
			XMLData.ParseSpeak(aNode);
			continue;
		}

		if (str == "points") {
			done = true;
			XMLData.ParsePoints(aNode);
			continue;
		}
		if (str == "smpoints") {
			done = true;
			SMData.ParseSMPoints(aNode);
			continue;
		}
		if (str == "setfactors") {
			done = true;
			XMLData.ParseSetFactors(aNode);
			continue;
		}
		if ("showimage.background.backgrounds.showmovie.showperson.hideperson.attachmovie.showslave.hideslave.cumsplatter.showitem.hideitem.attachbitmap.showmonster.resizemovie.tintmovie.tintimage.showbars.hidebars.changeimagelist.".indexOf(str + ".") != -1) {
		//if (str == "showimage" || str == "showmovie" || str == "showperson" || str == "hideperson" || str == "attachmovie" || str == "showslave" || str == "hideslave" || str == "background" || str == "backgrounds" || str == "cumsplatter" || str == "showitem" || str == "hideitem" || str == "attachbitmap" || str == "showmonster" || str == "resizemovie" || str == "tintmovie" || str == "tintimage" || str =="showbars") {
			done = true;
			XMLData.ParseShowImages(str, aNode);
			continue;
		}
		if (str == "showslavemaker" || str == "showsupervisor" || str == "showassistant") {
			done = true;
			if (str == "showsupervisor") {
				if (Supervise) str = "showslavemaker";
				else str = "showassistant";
			}
			var s:String = aNode.firstChild.nodeValue;
			var place:Number = 0;
			var align:Number = 1;
			if (aNode.attributes.place != undefined) place = DecodePlace(aNode.attributes.place);
			if (aNode.attributes.align != undefined) align = DecodeAlign(aNode.attributes.align);
			
			if (str == "showassistant") {
				var type:Number = 0;
				if (!isNaN(s)) type = Number(s);
				else if (s == undefined) type = 1;
				switch(s.split(" ").join("").toLowerCase()) {
					case "raped": type = 3; break;
					case "tentacle":
					case "tentaclesex": type = 2; break;
					case "wet": type = 5; break;
					case "runaway": type = 6; break;
				}
				if (type != 0) ShowAssistant(type);
				else AssistantData.ShowActImage(s, place, align);
			} else SMAvatar.ShowSlaveMaker(s, place, align);
			continue;
		}
		if (str == "yesnoquestion" || str == "askquestions" || str == "askquestion" || str == "addquestion" || str == "doyesnoevent" || str == "topics") {
			done = true;
			XMLData.ParseAskQuestions(str, aNode);
			continue;
		}
		if (str == "doevent" || str == "doeventnow" || str == "doxml" || str == "doxmlact" || str == "dobasexmlact" || str == "doxmlevent" || str == "pickanddoxmlevent") {
			var bDone = done;
			done = XMLData.ParseDoEvent(str, aNode, aNode.firstChild.nodeValue);
			if (bDone && !done) done = bDone;
			continue;
		}
		if (str == "setflags" || str == "setflag" || str == "clearflags") {
			done = true;
			for (var attr:String in aNode.attributes) XMLData.SetSingleFlag(attr, undefined, aNode.attributes[attr]);
			continue;
		}
		if (str == "setvar" || str == "changevar" || str == "setvars" || str == "changevars") {
			done = true;
			XMLData.ParseChangeVars(str, aNode);
			continue;
		}

		if (str == "alternatives") {
			done = XMLData.ParseAlternatives(aNode, done);
			continue;
		}
		if (str == "choices") {
			done = XMLData.ParseChoices(aNode, done);
			continue;
		}
		if (str == "hideimages") {
			done = true;
			HideImages();
			HideSlaveActions();
			HideAllPeople();
			Items.HideItems();
			EndGame.HideEndings();
			if (aNode.attributes.menus.toLowerCase() == "true") HideMenus();
			if (aNode.attributes.backgrounds.toLowerCase() == "true") Backgrounds.HideBackgrounds();
			continue;
		}
		if (str == "genderversions") {
			done = XMLData.ParseGenderVersions(aNode, done);
			continue;
		}
		if (str == "money" || str == "smmoney") {
			done = true;
			var quiet:Boolean = false;
			if (aNode.attributes.quiet != undefined) quiet = aNode.attributes.quiet.toLowerCase() == "true";
			var nodebt:Boolean = false;
			if (aNode.attributes.nodebt != undefined) nodebt = aNode.attributes.quiet.toLowerCase() == "true";
			if (str == "money") Money(XMLData.GetExpression(aNode.firstChild.nodeValue), quiet, nodebt);
			else SMMoney(XMLData.GetExpression(aNode.firstChild.nodeValue), quiet, nodebt);
			continue;
		}
		if (str == "earnmoney") {
			done = true;
			Pay = EarnMoney(XMLData.GetExpression(aNode.firstChild.nodeValue));
			continue;
		}
		if (str == "smearnmoney") {
			done = true;
			PaySM = SMEarnMoney(XMLData.GetExpression(aNode.firstChild.nodeValue));
			continue;
		}
		if (str == "repeatevent" || str == "norepeatevent") {
			var plc:Place = currentCity.GetPlaceInstance(WalkPlace);
			if (plc == null) continue;
			done = true;
			var evt:String = aNode.firstChild.nodeValue;
			if (evt == undefined) evt = XMLData.GetCurrentNode();
			if (str == "norepeatevent") plc.NoRepeatEvent(evt, false);
			else plc.RepeatEvent(evt, false);
			continue;
		}		
		if (str == "blankline") {
			done = true;
			XMLData.EventText += "\r\r";
			continue;
		}
		if (str == "playsound") {
			done = true;
			if (aNode.attributes.stop.toLowerCase() == "true") Sounds.StopAllSounds();
			if (aNode.attributes.stopandfade.toLowerCase() == "true") Sounds.StopAndFadeSounds();
			if (aNode.firstChild.nodeValue == undefined) continue;
			var vol:Number = Number(aNode.attributes.volume);
			if (isNaN(vol)) vol = 100;
			Sounds.PlaySound(aNode.firstChild.nodeValue, Number(aNode.attributes.repeats), Number(aNode.attributes.count), vol, Number(aNode.attributes.delay));
			continue;
		}
		if (str == "showdress" || str == "hidedress" || str == "hidedresses" || str == "shownaked" || str == "positiondressitems" || str == "setcustomuniform" || str == "sellcustomuniform") {
			ParseDresses(aNode, str);
			done = true;
			continue;
		}
		if (str == "ownitem" || str == "owndress" || str == "setitemowned") {
			done = true;
			var own:Boolean = aNode.attributes.own.toLowerCase() != "false";
			var item:Number = Number(aNode.firstChild.nodeValue);
			if (isNaN(item)) item = Items.GetItemIdxFromNameBase(aNode.firstChild.nodeValue);
			if (str == "owndress") item = Math.abs(item) * -1; 
			per = People.ParsePersonDetails(aNode);
			if (per == -50) SetItemOwned(item, own);
			else if (per > 0) SMData.GetSlaveByIndex(per).SetItemOwned(item, own);
			continue;
		}
		if (str == "setdresssold") {
			done = true;
			var sold:Boolean = aNode.attributes.own.toLowerCase() != "false";
			var dress:Number = Number(aNode.firstChild.nodeValue);
			SetDressForSale(dress, sold);
			continue;
		}
		if (str == "wearitem" || str == "weardress") {
			done = true;
			var item:Number = Number(aNode.firstChild.nodeValue);
			if (isNaN(item)) item = Items.GetItemIdxFromNameBase(aNode.firstChild.nodeValue);
			if (str == "weardress") item = Math.abs(item) * -1; 
			per = People.ParsePersonDetails(aNode);
			if (item < 1) {
				if (itemno == -10) PutDressOn(-10);
				else if (itemno == -1) TakeDressOff();
				else PutDressOn(Math.abs(item));
			}
			else Items.WearItem(item);
			continue;
		}
		if (str == "removeitem" || str == "removedress") {
			done = true;
			var item:Number = Number(aNode.firstChild.nodeValue);
			if (isNaN(item)) item = Items.GetItemIdxFromNameBase(aNode.firstChild.nodeValue);
			per = People.ParsePersonDetails(aNode);
			if (str == "removedress" || item < 1) TakeDressOff();
			else Items.RemoveItem(item);
			continue;
		}
		if (str == "ownweapon" || str == "setweaponowned") {
			done = true;
			SMData.SetWeaponOwned(aNode.firstChild.nodeValue);
			continue;
		}
		if (str == "ownarmour" || str == "setarmourowned" || str == "ownarmor" || str == "setarmorowned") {
			done = true;
			SMData.SetArmourOwned(aNode.firstChild.nodeValue);
			continue;
		}
		if (str == "diary") {
			done = true;
			Diary.ParseDiary(aNode);
			continue;
		}
		if (str == "combat") {
			done = true;
			Combat.ParseCombat(aNode)
			continue;
		}
		if (str == "changedate" || str == "updatedateanditems" || str == "newday" || str == "startevening") {
			done = true;
			ParseDayNight(aNode, str);
			continue;
		}
		if (str == "changetime" || str == "changetimemins" || str == "addtime" || str == "addtimemins") {
			done = true;
			if (str == "changetime" || str == 'addtime') AddTime(XMLData.GetExpression(aNode.firstChild.nodeValue));
			else AddTimeMins(XMLData.GetExpression(aNode.firstChild.nodeValue));
			continue;
		}
		if (str == "settime" || str == "settimemins") {
			done = true;
			var tv:String = aNode.firstChild.nodeValue.toLowerCase();
			if (tv == "midnight") tv = "0";
			if (str == "settime") {
				if (tv == "noon") tv = "12";			
				SetTime(XMLData.GetExpression(tv));
			} else {
				if (tv == "noon") tv = "720";
				SetTimeMins(XMLData.GetExpression(tv));
			}
			continue;
		}
		if (str == "impregnate") {
			done = true;
			XMLData.ParseImpregnate(aNode);
			continue;
		}
		if (str == "addspeechsuffix") {
			done = true;
			XMLData.ParseSpeechSuffix(aNode);
			continue;
		}
		if (str == "for") {
			done = XMLData.ParseForLoop(aNode, done);
			continue;
		}
		if (str == "while") {
			done = XMLData.ParseWhileLoop(aNode, done);
			continue;
		}
		if (str == "getparticipantdetails") {
			var pn:Number = XMLData.GetExpression(aNode.firstChild.nodeValue);
			if (Participants.length == 0) continue;
			if (pn < Participants.length) {
				SMData.GetSlaveInformation(Participants[pn]);
				if (Participants[pn] >= 0) UpdateSlaveCommon(sdata);
			}
			continue;
		}
		if (str == "getslaveinformation" || str == "getotherslaveinformation") {
			per = People.ParsePersonDetails(aNode);
			if (str == "getslaveinformation") {
				SMData.GetSlaveInformation(per);
				if (per >= 0) UpdateSlaveCommon(sdata);
			} else SMData.GetOtherSlaveInformation(per);
			if (per == -50) UpdateSlave();
			continue;
		}		
		if (str == "setpersondetails") {
			done = People.ParseSetPersonDetails(aNode);
			continue;
		}
		if (str == "setslaveowned" || str == "ownslave") {
			done = true;
			str = aNode.firstChild.nodeValue;
			if (str == undefined) str = aNode.attributes.slave;
			if (str == undefined || str == "") continue;
			var own:Boolean = true;
			if (aNode.attributes.own != undefined) own = aNode.attributes.own.toLowerCase() == "true";
			SMData.SetSlaveOwned(str, own);
			continue;
		}
		if (XMLData.ParseStatSkill(str, aNode)) {
			done = true;
			continue;
		}
		if (HouseEvents.ParseHousing(str, aNode)) {
			done = true;
			continue;
		}
		if (str == "meet") {
			done = People.ParseMeeting(aNode);
			continue;
		}
		if (str == "showstatistics") {
			done = true;
			if (aNode.attributes.show.toLowerCase() != "false") dspMain.ShowStatisticsTab(1);
			else dspMain.ShowStatisticsTab(5);
			continue;
		}
		if (str == "hidestatchangeicons") {
			done = true;
			HideStatChangeIcons();
			continue;
		}
		if (str == "hidebuttons") {
			done = true;
			HideButtons(aNode.attributes.main.toLowerCase() == "true");
			continue;
		}
		if (str.substr(0, 4) == "call") {
			done = true;
			XMLData.ParseCallFunction(str, aNode);
			continue;
		}
		if (str == "changeowner") {
			XMLData.ParseChangeOwner(aNode);
			done = true;
			continue;
		}
		if (str == "changeassistant") {
			done = true;
			ChangeAssistant(aNode.firstChild.nodeValue);
			continue;
		}
		if (str == "changesupervisor" || str == "updatesupervision") {
			done = true;
			UpdateSupervision(aNode.firstChild.nodeValue.toLowerCase() == "true" || aNode.firstChild.nodeValue.toLowerCase() == "slavemaker");
			continue;
		}
		if (str == "changeslavetype") {
			done = true;
			XMLData.ParseChangeSlaveType(aNode);
			continue;
		}
		if (str == "pickaslave") {
			done = true;
			SlavePicker.ParsePickASlave(aNode);
			continue;
		}
		if (str == "showcustomvisitperson" || str == "hidecustomvisitperson") {
			done = true;
			if (str == "hidecustomvisitperson") {
				per = Number(aNode.firstChild.nodeValue);
				if (isNaN(per)) per = Number(aNode.attributes.person);
				if (isNaN(per)) per = 1;
				currentCity.HideCustomVisitPerson(per);
			} else {
				per = Number(aNode.attributes.person);
				if (isNaN(per)) per = 1;
				currentCity.ShowCustomVisitPerson(aNode.firstChild.nodeValue, per);
			}
			continue;
		}	

		if (str == "endevent") {
			if (aNode.attributes.handled != undefined) done = (aNode.attributes.handled.toLowerCase() != "false");
			XMLData.endparse = done == false ? false : true;
			return done;
		}	
		if (str == "repick") {
			XMLData.bRepick = true;
			XMLData.endparse = true;
			done = true;
			continue;
		}
		if (str == "addparticipant" || str == "addparticipants" || str == "changeparticipant" || str == "changeparticipanta") {
			done = true;
			XMLData.ParseAddParticipant(aNode);
			SMData.BuildOwnedSlaves();
			continue;
		}
		if (str == "setending" || str == "showendingnext") {
			EndGame.SetEnding(XMLData.GetExpression(aNode.attributes.num), aNode.firstChild.nodeValue);
			done = true;
			continue;
		}
		if (str == "setcontest" || str == "showcontestsnext" || str == "showcustomcontest") {
			Contests.ParseContests(aNode, str);
			done = true;
			continue;
		}
		if (str == "trainingcomplete") {
			done = true;
			var full:Boolean = aNode.attributes.fulltime.toLowerCase() == "true";
			var bNow:Boolean = aNode.attributes.now.toLowerCase() == "true";
			if (aNode.attributes.ending != undefined) NumFin = Number(aNode.attributes.ending);
			else NumFin = 0;
			if (bNow) {
				XMLData.StopXMLParsing();
				DoEventNext(full ? 9899 : 9898);
			} else DoEvent(full ? 9899 : 9898);
			continue;
		}
		if (str == "showact" || str == "hideact" || str == "showjob" || str == "hidejob" || str == "showchore" || str == "hidechore" || str == "showschool" || str == "hideschool" || str == "showsex" || str == "hidesex" || str == "setactstate" || str == "setactdetails" || str == "addactparticipant" || str == "removeactparticipant" || str == "increasesexactlevel" || str == "levelupsexact" || str == "pickactimage" || str == "showactimage" || str == "performact" || str == "addplanningact" || str == "adddaynightaction" || str == "setactcounts") {
			done = true;
			XMLData.ParseActs(aNode, str);
			continue;
		}
		if (str == "drinkpotion" || str == "addpotion" || str == "buypotion") {
			done = true;
			Potions.ParsePotions(aNode, str);
			continue;
		}
		if (str == "goshopping") {
			done = true;
			XMLData.StopXMLParsing();
			XMLData.ParseShopping(aNode);
			continue;
		}
		if (str == "adddexperience") {
			done = true;
			CalcExperienceLang(XMLData.GetExpression(aNode.firstChild.nodeValue));
			continue;
		}
		if (str == "showendingshint") {
			done = true;
			EndGame.ShowEndingsHint();
			continue;
		}		
		if (str == "trace" || str == "smtrace") {
			SMTRACE(UpdateMacros(aNode.firstChild.nodeValue));
			continue;
		}
		if (str == "setvalue") {
			done = true;
			XMLData.EventText = UpdateMacros(aNode.firstChild.nodeValue);
			continue;
		}
		if (str == "nobleloveevent") {
			done = true;
			var psn:Person = People.GetPersonsObject(aNode.attributes.person);
			if (psn == null) psn = People.GetPersonsObject(aNode.firstChild.nodeValue);
			if (psn == null) continue;
			var bOffer:Boolean = aNode.attributes.allowoffer.toLowerCase() == "true";
			XMLData.StopXMLParsing();
			NobleLoveEvent(psn.Id, bOffer);
			continue;
		}
		
		if (str == "takeawalk") {
			var plc:Place = currentCity.GetPlaceObject(aNode.firstChild.nodeValue);
			if (plc == null) continue;
			done = true;
			WalkPlace = plc.Id;
			var evt:String = aNode.attributes.event == undefined ? "" : aNode.attributes.event;
			XMLData.StopXMLParsing();
			if (evt != "") plc.DoWalkThisEvent(evt);
			else {
				plc.ResetEventPicked();
				plc.DoWalkEvent();
			}			
			continue;
		}
		if (str == "changecity") {
			done = true;
			citiesList.ChangeCity(aNode.firstChild.nodeValue);
			XMLData.StopXMLParsing();
			continue;
		}
		
		if (str == "else") break;

		if (str == "b" || str == "font" || str == "bluetext" || str == "redtext" || str == "greentext" || str == "ld3" || str == "ld4" || str == "ld2" || str == "ps" || str == "i" || str == "u" || str == "p" || str == "br" || str == "sph" || str == "sp1" || str == "sp2") {
			XMLData.EventText += "<" + aNode.nodeName;
			for (var attr:String in aNode.attributes) XMLData.EventText += " " + attr + "='" + aNode.attributes[attr] + "'";
			XMLData.EventText += ">"
			done = ParseEvent(aNode.firstChild, done);
			XMLData.EventText += "</" + aNode.nodeName + ">";
			continue;
		}
		done = ParseEvent(aNode.firstChild, done)
	}
	return done;
}

// #slave = SlaveName
// #assistant = ServantName
// ...
function UpdateMacros(s:String) : String
{
	if (s == undefined || s.indexOf("#") == -1) return s;
	
	if (SlaveGender > 3 && Language.LangType == "English") {
		// global tweaks for twin type slaves
		s = s.split("#slave is ").join("#slave are ").split("#slave sees ").join("#slave see ").split("#slave has ").join("#slave have ").split("#slave meets ").join("#slave meet ");
	}

	if (s.indexOf("#slave") != -1) {
		if (Language.LangType != "English") s = s.split("#slavehimher2").join(SlaveHimHer2).split("#slavehimher3").join(SlaveHimHer3).split("#slavehimher4").join(SlaveHimHer4).split("#slavehisher2").join(SlaveHisHer2).split("#slavehisher3").join(SlaveHisHer3).split("#slavehisher4").join(SlaveHisHer4).split("#assistanthimher2").join(ServantHimHer2).split("#assistanthimher3").join(ServantHimHer3).split("#assistanthimher4").join(ServantHimHer4).split("#assistanthisher2").join(ServantHisHer2).split("#assistanthisher3").join(ServantHisHer3).split("#assistanthisher4").join(ServantHisHer4);
		s = s.split("#slavepronoun").join(SlavePronoun).split("#slavemakername").join(SMData.GetFullName()).split("#slaveheshe").join(SlaveHeShe).split("#slavehimher").join(SlaveHimHer).split("#slavehisher").join(SlaveHisHer).split("#slavehas").join(SlaveHas).split("#slaveis").join(SlaveIs).split("#slavesee").join(SlaveSee).split("#slavemeet").join(SlaveMeet).split("#slaveA").join(SlaveA).split("#slavea").join(SlaveA).split("#slaveB").join(SlaveB).split("#slaveb").join(SlaveB).split("#slave1").join(SlaveName1).split("#slave2").join(SlaveName2).split("#slave").join(GetFullName());
	}
	if (s.indexOf("#Slave") != -1) {
		if (Language.LangType != "English") s = s.split("#Slavehimher2").join(NameCase(SlaveHimHer2)).split("#Slavehimher3").join(NameCase(SlaveHimHer3)).split("#Slavehimher4").join(NameCase(SlaveHimHer4)).split("#Slavehisher2").join(NameCase(SlaveHisHer2)).split("#Slavehisher3").join(NameCase(SlaveHisHer3)).split("#Slavehisher4").join(NameCase(SlaveHisHer4)).split("#assistanthimher2").join(NameCase(ServantHimHer2)).split("#assistanthimher3").join(NameCase(ServantHimHer3)).split("#assistanthimher4").join(NameCase(ServantHimHer4)).split("#assistanthisher2").join(NameCase(ServantHisHer2)).split("#assistanthisher3").join(NameCase(ServantHisHer3)).split("#assistanthisher4").join(NameCase(ServantHisHer4));		
		s = s.split("#Slaveheshe").join(NameCase(SlaveHeShe)).split("#Slavehimher").join(NameCase(SlaveHimHer)).split("#Slavehisher").join(NameCase(SlaveHisHer)).split("#Slavehas").join(NameCase(SlaveHas)).split("#Slaveis").join(NameCase(SlaveIs)).split("#Slavesee").join(NameCase(SlaveSee)).split("#Slavemeet").join(NameCase(SlaveMeet)).split("#SlaveA").join(NameCase(SlaveA)).split("#Slavea").join(NameCase(SlaveA)).split("#SlaveB").join(NameCase(SlaveB)).split("#Slaveb").join(NameCase(SlaveB)).split("#Slave").join(NameCase(GetFullName()));
	}	
	s = s.split("#superhisher").join(SupervisorHisHer).split("#Superhisher").join(NameCase(SupervisorHisHer)).split("#superheshe").join(SupervisorHeShe).split("#Superheshe").join(NameCase(SupervisorHeShe)).split("#supername").join(SupervisorGivenName).split("#super").join(SupervisorName).split("#Super").join(NameCase(SupervisorName)).split("#assistantpronoun").join(ServantPronoun).split("#assistantmaster").join(ServantMaster).split("#assistantA").join(ServantA).split("#assistantB").join(ServantB).split("#assistantheshe").join(ServantHeShe).split("#Assistantheshe").join(NameCase(ServantHeShe)).split("#assistanthimher").join(ServantHimHer).split("#Assistanthimher").join(NameCase(ServantHimHer)).split("#assistanthisher").join(ServantHisHer).split("#Assistanthisher").join(NameCase(ServantHisHer)).split("#assistantis").join(ServantIs).split("#assistanthas").join(ServantHas).split("#assistantme").join(ServantMe).split("#master").join(Master).split("#Master").join(Master);
	if (AssistantData != null) s = s.split("#assistant").join(AssistantData.GetFullName());
	else s = s.split("#assistant").join(ServantHeShe);
	if (s.indexOf("#") == -1) return s;
	if (s.indexOf("#person") != -1 || s.indexOf("#Person") != -1) {
		if (s.indexOf("#personother") != -1) s = s.split("#personotherhesheuc").join(NameCase(PersonOtherHeShe)).split("#personotherheshe").join(PersonOtherHeShe).split("#personotherhimher").join(PersonOtherHimHer).split("#personotherhisher").join(PersonOtherHisHer).split("#personothermaster").join(PersonOtherMaster).split("#personother").join(PersonOtherName);
		if (s.indexOf("#Personother") != -1) s = s.split("#Personotherheshe").join(NameCase(PersonOtherHeShe)).split("#Personotherhimher").join(NameCase(PersonOtherHimHer)).split("#Personotherhisher").join(NameCase(PersonOtherHisHer)).split("#Personothermaster").join(NameCase(PersonOtherMaster)).split("#Personother").join(PersonOtherName);
		if (Language.LangType != "English") {
			s = s.split("#personhimher2").join(PersonHimHer2).split("#personhimher3").join(PersonHimHer3).split("#personhimher4").join(PersonHimHer4).split("#personhisher2").join(PersonHisHer2).split("#personhisher3").join(PersonHisHer3).split("#personhisher4").join(PersonHisHer4);
			s = s.split("#Personhimher2").join(NameCase(PersonHimHer2)).split("#Personhimher3").join(NameCase(PersonHimHer3)).split("#Personhimher4").join(NameCase(PersonHimHer4)).split("#Personhisher2").join(NameCase(PersonHisHer2)).split("#Personhisher3").join(NameCase(PersonHisHer3)).split("#Personhisher4").join(NameCase(PersonHisHer4));
		}
		s = s.split("#personhesheuc").join(NameCase(PersonHeShe)).split("#personheshe").join(PersonHeShe).split("#personhimher").join(PersonHimHer).split("#personhisher").join(PersonHisHer).split("#personmaster").join(PersonMaster);
		s = s.split("#Personheshe").join(NameCase(PersonHeShe)).split("#Personhimher").join(NameCase(PersonHimHer)).split("#Personhisher").join(NameCase(PersonHisHer)).split("#Personmaster").join(NameCase(PersonMaster));
		var p:String = "#person";
		var pn:Number = s.indexOf(p);
		var ps:String
		while (pn != -1) {
			pn += 7;
			ps = "";
			while (pn < s.length && (s.charAt(pn) >= "0" || s.charAt(pn) == "-" || s.charAt(pn) == "_") && s.charAt(pn) != ":" && s.charAt(pn) != "<" && s.charAt(pn) != ">") {
				ps += s.charAt(pn);
				pn++;
			}
			if (ps != "") {
				p += ps;
				ps = People.GetPersonsName(ps);
			} else ps = PersonName;
			//trace("p = " + p + " ps = " + ps);
			s = s.split(p).join(ps);
			p = "#person";
			pn = s.indexOf(p);
		}
	}
	if (s.indexOf("#place") != -1) {
		var p:String = "#place";
		var pn:Number = s.indexOf(p);
		var ps:String
		while (pn != -1) {
			pn += 6;
			ps = "";
			while (pn < s.length && (s.charAt(pn) >= "0" || s.charAt(pn) == "-" || s.charAt(pn) == "_") && s.charAt(pn) != ":" && s.charAt(pn) != "<" && s.charAt(pn) != ">") {
				ps += s.charAt(pn);
				pn++;
			}
			if (ps != "") {
				p += ps;
				ps = currentCity.GetPlaceName(ps);
			} else break;
			//trace("p = " + p + " ps = " + ps);
			s = s.split(p).join(ps);
			p = "#place";
			pn = s.indexOf(p);
		}		
	}
	if (s.indexOf("#participant") != -1) {
		var p:String = "#participant";
		var pn:Number = s.indexOf(p);
		var ps:String
		while (pn != -1) {
			pn += 12;
			ps = "";
			while (pn < s.length && s.charAt(pn) >= "0" && s.charAt(pn) <= "9") {
				ps += s.charAt(pn);
				pn++;
			}
			if (ps != "") {
				p += ps;
				pn = Number(ps);
				if (Participants.length <= pn) {
					if (pn == -100) ps = SMData.SlaveMakerName;
					else if (pn == -99) ps = ServantName;
					else if (pn == -50) ps = SlaveName;
					else if (pn == -1000) ps = Language.GetHtml("Everyone", "Participants");
					else ps = SMData.SlavesArray[Participants[pn]].SlaveName;
				} else ps = "";
			}
			s = s.split(p).join(ps);
			p = "#participant";
			pn = s.indexOf(p);
		}
	}
	var pn:Number = s.indexOf("#");
	var ps:String = "";
	var ar:Array;
	while (pn != -1) {
		pn += 1;
		ps = "";
		while (pn < s.length && s.charAt(pn) >= "0" || s.charAt(pn) == "-" || s.charAt(pn) == "_") {
			if (s.charAt(pn) == "<") break;
			ps += s.charAt(pn);
			if (ps == "value") break;
			pn++;
		}
		if (ps == "value" || ps == "") break;
		var val:Object = GetStSk(ps.toLowerCase().split(" ").join("").split("\\n").join("").split("\\r").join("").split("\r\n").join("").split("\t").join(""));
		if (val == undefined) {
			var rets:String = modulesList.GetExEventString(ps);
			if (rets != undefined) s = s.split("#" + ps).join(rets);
			else s = s.split("#" + ps).join("");
		} else {
			ar = s.split("#" + ps);
			var stemp:String = String(ar.shift());
			s = stemp + val;
			if (ar.length > 0) s += ar.join("#" + ps);
		}
		pn = s.indexOf("#");
	}
	return s;
}
