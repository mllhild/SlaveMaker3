import Scripts.Classes.*;

// Day Persions
// Early Monning:		6am
// Daily Events:		7am (or Early Morning + 1 hr)
// Moring:				7am (or later due to events)
// Day Time Planning:	8am (or Daily Events + 1 hr)
//
// Eventing:			6pm
// Eventing Planning:	8pm


// Time/Date

var GameTime:Number;
var Day:Boolean;
var Elapsed:Number;
var bNocturnal:Boolean;
var strDayName:String;
var nDayOfWeek:Number;


// Functions

function GetDayOfYear(gdate:Number) : Number
{
	var yday:Number = Math.abs(gdate) % 400;
	if (yday == 0) yday = 400;
	return gdate < 0 ? 401 - yday : yday;
}


// convert a numeric date to a string like "1255/12" ie yyyy/ddd
function DecodeDate(gdate:Number, byr:Number) : String
{
	// gdate can be negative to represent a date in the past, before the start of the standard calendar at 1252/1
	// normally this represents the birthday of a character
	if (byr == undefined) byr = currentCity == null ? 1252 : currentCity.nBaseYear;
	if (gdate == undefined) gdate = GameDate;
	if (gdate == GameDate && GameTimeMins >= 1440) gdate++;
	var yday:Number = GetDayOfYear(gdate);
	if (gdate < 0) return ((byr - 1) + Math.floor((gdate - yday) / 400)) + "/" + yday;
	return (byr + Math.floor((gdate - yday) / 400)) + "/" + yday;
}

// convert a string date like 1255/12 to a numeric date where 1252/1 is number 1
function ParseDate(gdate:String) : Number
{
	var sl:Array = gdate.split("/");
	if (sl.length == 0) return Number(gdate);
	var yr:Number = Number(sl[0]);
	if (isNaN(yr)) return yr;
	var day:Number = Number(sl[1]);
	if (isNaN(day)) day = 1;
	return ((yr - currentCity.nBaseYear) * 400) + day;
}


function DecodeTimeMins(gtime:Number) : String
{
	if (gtime == undefined) gtime = GameTimeMins;
	if (gtime >= 1440) gtime -= 1440;
	if (gtime == 0)  return Language.GetHtml("Midnight");
	if (gtime == 720) return Language.GetHtml("Midday");
	var hr:Number = Math.floor(gtime / 60);
	var tt:String;
	if (Options.Clock24On) tt = hr + ":";
	else tt = hr > 12 ? (hr - 12) + ":" : hr + ":";
	var mins:Number = gtime % 60;
	if (mins > 9) tt = tt + mins;
	else tt += "0" + mins;

	if (!Options.Clock24On) {
		if (gtime < 720) tt += "am";
		else tt += "pm";
	}
	return tt;
}


function DecodeTime(gtime:Number) : String
{
	if (gtime == undefined) gtime = GameTime;
	return DecodeTimeMins(gtime * 60);
}


function UpdateTime()
{
	GameTime = GameTimeMins / 60;		// ? round to nearest 30 mins
	Day = IsDayTime(GameTimeMins);	
	dspMain.UpdateTime();
}

function IsDayTime(gtm:Number) : Boolean 
{
	if (gtm == undefined) gtm = GameTimeMins;
	return gtm < 1080 && gtm >= 360;	// 6am to 6pm
}

function SetTime(gtime:Number)
{
	GameTimeMins = Math.round(gtime * 60);
	UpdateTime();
}


function AddTime(gtime:Number)
{
	GameTimeMins += Math.round(gtime * 60);
	UpdateTime();
}

function SetTimeMins(gtime:Number)
{
	GameTimeMins = gtime;
	UpdateTime();
}


function AddTimeMins(gtime:Number)
{
	GameTimeMins += gtime;
	UpdateTime();
}

function IsNocturnal() : Boolean { return bNocturnal; }
function SetNocturnal(bSet:Boolean) { bNocturnal = bSet == undefined ? true : bSet; }

function IsSexPlanningTime(gtm:Number) : Boolean
{
	if (gtm == undefined) gtm = GameTimeMins;
	return (!IsDayTime(gtm) && !bNocturnal) || (IsDayTime(gtm) && bNocturnal);
}


function ChangeDate(NumDays:Number, endt:Boolean)
{
	if (NumDays != 0 && NumDays != undefined) {
		GameDate += NumDays;
		MoonPhaseDate += NumDays;
		
		var bNarry:Boolean = SMData.IsNarryOwned();

		// Apply daily effect to all owned slaves
		var j:Number = SMData.nUsable - 1;
		var sd:Object;
		var slv:Slave;
		while (--j >= -3) {
			slv = null;
			if (j == -1) {
				if (slaveData == null) continue;
				sd = _root;
				slv = slaveData;
			} else if (j == -2) {
				if (AssistantData == null) continue;
				slv = AssistantData;
				if (AssistantData.SlaveType != 1 && AssistantData.SlaveType != 2 && AssistantData.SlaveType != 0) sd = AssistantData;
				else break;	// assistant is the last
			} else if (j == -3) {
				if (SpecialIndex == undefined) continue;
				sd = SlavesArray[SpecialIndex];
				slv = SlavesArray[SpecialIndex];
			} else {
				sd = SMData.arUsableSlaves[j];
				if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
				if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
				slv = SMData.arUsableSlaves[j];
			}
			GetSlaveInformation(sd);
			
			// reset done today for talk/custom talk
			sd.BitFlagC.ClearBitFlag(64);
			sd.BitFlagC.ClearBitFlag(65);
			
			// check for change of age
			// -1 is unknown, so do not alter
			if (sd.vitalsAge != -1) {
				var bday:Number = GetDayOfYear(sd.Birthday);		// day of year
				var gday1:Number = GetDayOfYear(GameDate - NumDays);		// day of year
				var gday2:Number = GetDayOfYear(GameDate);		// day of year
				var bHB:Boolean = false;
				if (gday1 < gday2 && gday1 < bday && gday2 >= bday) bHB = true;
				else if (gday1 > gday2 && (bday > gday1 || bday <= gday2)) bHB = true;
				if (bHB) {
					// happy birthday!
					if (NumDays < 400) sd.vitalsAge += 1;
					else sd.vitalsAge += int(NumDays / 400);
					if (sd == _root) dspMain.UpdateSlaveVitals();
				}   
			}
						
			if (sd.PregnancyGestation > 0) {
				sd.PregnancyGestation -= NumDays;
				if (sd.PregnancyGestation <= 0) sd.PregnancyGestation = -1000;	// trigger pregnant event next start of day
				if (j == -1 && (sd.PregnancyType.toLowerCase() == "tentacle" || sd.PregnancyType.toLowerCase() == "tentacles")) TentaclePregnancy = PregnancyGestation;
			}
			
			if (sd.DaysUnavailable != 0) {
				if (sd.DaysUnavailable > 0) {
					sd.DaysUnavailable -= NumDays;
					if (sd.DaysUnavailable < 0) sd.DaysUnavailable = 0;
				} else {
					sd.DaysUnavailable += NumDays;
					if (sd.DaysUnavailable > 0) sd.DaysUnavailable = 0;					
				}
			}
			
			if (sd.HandcuffBraceletWorn == 1) sd.VarObedience += NumDays;
	
			if (sd.HaloWorn == 1) {
				if (Home.hWards == 1) {
					if (SMData.SMFaith == 2) sd.VarLibido += NumDays/2;
					sd.VarMorality += NumDays+(NumDays/2);
				} else {
					if (SMData.SMFaith == 2) sd.VarLibido += NumDays;
					sd.VarMorality += NumDays+NumDays;
				}
			}
		 
			if (sd.DemonicBraWorn == 1) {
				if (Home.hWards == 1) sd.VarLibido += NumDays * 3;
				else sd.VarLibido += NumDays * 5;
			}
			
			if (sd.HarnessWorn == 1) {
				if (sd.HarnessOK == 1) sd.VarLibido += NumDays * 1;
				else {
					sd.VarLibido += NumDays * 2;
					sd.VarNymphomania += NumDays;
				}
			}
		  
			if (sd.NippleRingsWorn == 1 || sd.NippleChainWorn == 1) sd.VarLibido += NumDays;
		
			if (sd.SpikedBraceletWorn == 1) sd.VarTemperament += NumDays * 2;
		
			if (sd.DemonicPendantWorn == 1) {
				if (Home.hWards == 1) {
					sd.VarCharisma += NumDays;
					sd.VarFuck += NumDays;
				} else {
					sd.VarCharisma += NumDays * 2;
					sd.VarFuck += NumDays;
				}
			}
			
			if (sd.AngelsTearWorn == 1) {
				if (SMData.SMFaith == 2) sd.VarConstitution += NumDays;
				else sd.VarSensibility += NumDays;
			}
			
			if (sd.FaeriesRingWorn == 1) {
				if (Home.hWards == 1) {
					sd.VarSensibility += NumDays / 2;
					sd.VarCharisma += NumDays / 2;
				} else {
					sd.VarSensibility += NumDays;
					sd.VarCharisma += NumDays;
				}
				if (sd.FairyXF > 0) {
					if (sd.FairyXF < 100) sd.ChangeFairyXF(1);
					if (sd.FairyXF >= 100 && sd.FairyXF < 2000) sd.FairyXF = 1000;
				}

			}
			
			if (sd.GamanEffecting == 1) sd.VarFatigue += (NumDays * 5);
	
			if (sd,BiyakuEffecting == 1) {
				sd.VarLibido += NumDays * 20;
				sd.VarNymphomania += NumDays * 20;
			} 
			if (sd.DrugDuration > 0 && NumDays > 1) {
				sd.DrugDuration -= NumDays - 1;
				if (sd.DrugDuration < 1) sd.DrugDuration = 1;
			}
			if (sd.OrgasmDrugEffecting > 0) {
				if (sd.OrgasmDrugEffecting != 8 && sd.OrgasmDrugEffecting != 16) sd.OrgasmDrugEffecting--;
				sd.MinLibido += NumDays;
				sd.VarLibido += NumDays;
			}
			
			if (sd.FairyXF == 2000) {
				sd.VarNymphomania += NumDays;
			}
			
			if (SMAdvantages.CheckBitFlag(12)) sd.VarJoy += NumDays;
			
			if (sd.MilkInfluence > 0 && sd.MilkInfluence < 1000) {
				sd.MilkInfluence -= NumDays;
				if (sd.MilkInfluence <= 0) sd.MilkInfluence = -2;
			}		

			var beautyrate = NumDays;
			if (sd.VanityCaseOK == 0) beautyrate += NumDays;
			sd.DurationHairCare -= beautyrate;
			if (sd.DurationHairCare < 0) sd.DurationHairCare = 0;
			sd.DurationFacialCare -= beautyrate;
			if (sd.DurationFacialCare < 0) sd.DurationFacialCare = 0;
			sd.DurationMakeupCare -= beautyrate;
			if (sd.DurationMakeupCare < 0) sd.DurationMakeupCare = 0;
			
			// now for slaves other than the current slave
			if (j == -1) continue;
						
			// House/Advantages Effects
			if (SMAdvantages.CheckBitFlag(9)) {
				sd.VarObedience += NumDays;
				if (sd.SlaveName != "Shampoo") sd.VarLovePoints = 0;
			}
			// Update for owned slaves
			if (bNarry) sd.VarJoy += 1;
			
			// Skill effects
			sd.VarObedience += SMData.sLeadership * 0.25;
			
			// acts
			sd.ActInfoBase.NewDay(NumDays);
	
			if (sd.GamanEffecting == 1 || sd.BiyakuEffecting == 1 || sd.DoreiEffecting == 1 || sd.IshinaiEffecting == 1 || sd.ZodaiEffecting == 1) {
				sd.DrugDuration -= NumDays;
				if (sd.DrugDuration <= 0) {
					sd.DrugDuration = 0;
					if (sd.GamanEffecting == 1) sd.VarConstitution = sd.VarConstitution-30;
					if (sd.DoreiEffecting == 1) {
						sd.VarObedience = sd.VarObedience-30;
						sd.VarMorality = sd.OldMorality;
					} 
					if (sd.IshinaiEffecting == 1) {
						sd.VarObedience = sd.OldObedience;
						sd.VarIntelligence = sd.OldIntelligence;
						sd.VarTemperament = sd.OldVarTemperament;
						sd.VarMorality = sd.OldMorality;
						sd.VarJoy = sd.VarJoy-30;
						sd.VarLovePoints = sd.VarLovePoints-30;
						sd.VarObedience = sd.VarObedience-10;
					} 
					sd.GamanEffecting = 0;
					sd.BiyakuEffecting = 0;
					sd.ZodaiEffecting = 0;
					sd.IshinaiEffecting = 0;
					sd.DoreiEffecting = 0;
					if (sd.AddictionLevel > Math.floor(Math.random()*100)) {
						sd.DrugAddicted = 1;
						sd.NumAddictionLevel = sd.NumAddictionLevel+1;
					} 
				} 
			}
			if (j < 0) {
				sd.VarFatigue -= 10 * NumDays;
				if (sd.VarFatigue < 0) sd.VarFatigue = 0;
				continue;
			}
			
			var totOrders:Number = sd.Order1 != 0 ? 1 : 0;
			if (sd.Order2 != 0) totOrders++;
				
			sd.VarFatigue -= (2 - totOrders) * 10 * NumDays;
			if (sd.VarFatigue < 0) sd.VarFatigue = 0;
		}
		
		// SlaveMaker effects
		SMData.NewDay(NumDays, endt);
		
		// People
		//People.NewDay(NumDays);

		// City		
		currentCity.NewDay(NumDays);
		
		// Parties
		Parties.NewDay(NumDays);
		
		// Owned slaves
		if (NumDays > 1) {
			for (var i:Number = 0; i < NumDays; i++) SMData.DoAllSlavesOrders();
		}

		// set time of day
		if (bNocturnal) SetTime(18);
		else SetTime(7);
		
	} else UpdateTime();
	
	if (MoonPhaseDate > 29) MoonPhaseDate -= 29;
	Icons.SetMoonIcon(MoonPhaseDate);
	Elapsed = GameDate - TrainingStart + 1;
	
	nDayOfWeek = GameDate % 8;
	if (nDayWeek == 0) nDayWeek = 8
	strDayName = Language.GetText("Day" + nDayOfWeek, "Diary/WeekDays");

	UpdateSlave();
}


// NumDays pass, update for any effects
function UpdateDateAndItems(NumDays:Number, free:Boolean, gtime:Number, hidei:Boolean)
{
	if (NumDays == undefined) NumDays = 1;
	if (free == undefined) free = false;
	if (gtime == undefined || gtime == 0) gtime = bNocturnal ? 18 : 6;
	
	StopPlanning(false, true, hidei);
	genNumber = NumDays;
	
	DoneEvent = 0;
	BadGirl = 0;
	DoneSpank = 0;
	WinContest = 0;
	AnySex = false;
	AnyNonSex = false;
	DoneScold = false;
	DickgirlChanged = false;
	DoneNaked = 0;
	DonePlug = 0;
	LendPerson = 0;
	WalkPlace = 0;

	ChangeDate(NumDays);
	
	Home.ChangeDate(NumDays, free);
	
	GetServantAB();
	GetSlaveAB();
	
	if (AntidoteDays > 0) {
		AntidoteDays -= NumDays;
		if (AntidoteDays < 0) AntidoteDays = 0;
	}
	
	currentCity.UpdateDateAndItems(NumDays);
		
	if (PlugInserted == 1 && PonyTailWorn == 0 && CatTailWorn == 0) PlugInserted = 0;
	
	if (BitFlag1.CheckBitFlag(27)) modulesList.trainLesbians.StartTraining();
			
	SlaveGirl.UpdateDateAndItems(NumDays);
	XMLData.XMLEvent("UpdateDateAndItems");
	Elapsed = GameDate - TrainingStart + 1;
	
	FirstTimeTodayBrothel = true;
	FirstTimeTodayAcolyte = true;
	FirstTimeTodaySleazyBar = true;
	FirstTimeTodayDiscuss = true;
	FirstTimeTodayBreak = true;
	FirstTimeTodayTheology = true;
	FirstTimeTodayRestaurant = true;
	FirstTimeTodayBar = true;
	FirstTimeTodaySciences = true;
	FirstTimeTodaySinging = true;
	FirstTimeTodaySwimming = true;
	FirstTimeTodayDance = true;
	FirstTimeTodayRefinement = true;
	FirstTimeTodayExercise = true;
	FirstTimeTodayXXX = true;
	FirstTimeTodayCooking = true;
	FirstTimeTodayCleaning = true;
	FirstTimeTodayExpose = true;
	FirstTimeTodayMakeup = true;
	FirstTimeTodayCustomJob1 = true;
	FirstTimeTodayCustomJob2 = true;
	FirstTimeTodayCustomJob3 = true;
	FirstTimeTodayLibrary = true;
	FirstTimeTodayOnsen = true;
	FirstTimeTodayCockMilking = true;
	FirstTimeTodayCustomChore1 = true;
	FirstTimeTodayCustomChore2 = true;
	FirstTimeTodayCustomChore3 = true;
	FirstTimeTodayCustomSchool1 = true;
	FirstTimeTodayCustomSchool2 = true;
	FirstTimeTodayCustomSchool3 = true;
	FirstTimeTodaySMJob = true;
		
	if (free != true) {
		CurrentAssistant.UpdateDateAndItemsAsAssistant(NumDays);
		modulesList.UpdateDateAndItems(NumDays);
		
		if (UsedAphrodisiac == 1) {
			if (DateLastAphrodisiac == (GameDate - 1)) DaysUsedAphrodisiac++;
			DateLastAphrodisiac = GameDate;
			if (DaysUsedAphrodisiac >= 5) {
				if (DaysUsedAphrodisiac == 5) {
					SetText("#slave is acting more and more aroused all the time. The continual use of aphrodisiacs is making #slavehimher horny all the time.");
					MinLibido += 5;
				} else MinLibido++;
			}
		} else DaysUsedAphrodisiac = 0;
		
		if (RulesTalk == 0) {
			VarConversation -= NumDays;
			VarSensibility += NumDays;
		} 
	  
		if (RulesGoOut == 0) {
			VarJoy -= NumDays * 3;
			VarSensibility -= NumDays;
			VarReputation -= NumDays;
			VarConstitution -= NumDays;
		} else {
			if (RulesFuck == 1) {
				if (VarNymphomaniaRounded>50) {
					libidoinc = NumDays * (Math.floor(Math.random()*Math.floor(Slutiness / 3) + 1) + 1);
					temp = Math.floor(Math.random()*3);
					if (temp == 2) {
						VarFuck += libidoinc;
						libidoinc = 0;
					} 
					temp = Math.floor(Math.random()*3);
					if (temp == 2) {
						bjinc = NumDays * (Math.floor(Math.random()*Math.floor(Slutiness / 3) + 1) + 1);
						VarBlowJob += bjinc;
						libidoinc += bjinc;
					}
					VarLibido += libidoinc;  
				}  
			}
		}
	  
		if (RulesTouchHerself == 1) {
			if (VarLibidoRounded>60) {
				VarLibido -= NumDays;
				VarTemperament -= NumDays;
			}
		} else VarLibido += NumDays / 2;
	  
		if (RulesWriteLetters == 1) {
			VarSensibility += NumDays;
			VarJoy -= NumDays;
		}
	  
		if (RulesPocketMoney == 1 && VarGold > 1) {
			VarSensibility -= NumDays;
			VarJoy += NumDays;
			Money(-2 * NumDays, true);
		}
	
		if (RulesPray == 1) {
			if (VarMoralityRounded>50) {
				VarMorality += NumDays;
				VarLibido -= NumDays * 3;
				VarNymphomania -= NumDays * 3;
			} else {
				VarLibido -= NumDays;
			}
		}
		
		NumDaysWithoutFuck = NumDaysWithoutFuck+NumDays;
		if (VibratorPantiesWorn == 1) {
			if (Home.hWards != 1) VarLibido += NumDaysWithoutFuck*7;
			else VarLibido += NumDaysWithoutFuck*4;
		}
		
		if (IsPonygirl() &&	TotalBondageToday == 0) VarJoy -= NumDays * 5;

	}
	
	Behaving -= NumDays;
	if (Behaving < 0) Behaving = 0;
		
	if (DressWorn == -1) {
		WearDress(DressToWear);
		HideStatChangeIcons();
		DressToWear = 0;
	} else if (DressWorn == -10) {
		LevelUpSexAct(13);
		TotalNaked++;
	}
	NakedChoice = 0;
	slaveData.NakedChoice = 0;
		
	SetTime(gtime);
	
	UpdateSlave();
}


// Start a new day, and do any early morning events
function NewDay(NumDays:Number, NewTime:Number, free:Boolean, tired:Boolean)
{
	SetText("");
	NewDayNoEvents(NumDays, NewTime, free);
	
	if (tired == true) DoneEvent = 3;
	
	if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(32)) {
		if (SMData.GuildMember) Information.ShowTutorial(Language.GetHtml("TutorialNewDayTitle", hintNode), Language.GetHtml("TutorialNewDayGuildMember", hintNode), EarlyMorningEvents);
		else Information.ShowTutorialLang("NewDay", EarlyMorningEvents);
	} else EarlyMorningEvents();

}

// Start a new day, NO morning events
function NewDayNoEvents(NumDays:Number, NewTime:Number, free:Boolean)
{
	PlanningSelections._visible = false;
	HideBackgrounds();
	HideDresses();
	HideStatChangeIcons();
	Items.HideItems();
	Supervise = ServantName == "";
	HidePeople();
	
	UpdateDateAndItems(NumDays, free, NewTime);
	
	PlanningSelections.Actions.invalidate();
}

function StartMorning()
{
	StopPlanning(false, true);
	AddTime(1);
	HidePlanningNext();
	HideSlaveActions()
	HideImages();
	Sounds.StopAndFadeSounds();
	Items.HideItems();
	HidePeople();
	HideDresses();
	NextEvent._visible = false;
	if (DoneEvent < 2) DoneEvent = 0;
	ResetEventPicked();
	SetText("");
	
	// Morning,standard greeting
	UpdateSlave();
	var ret:Boolean = modulesList.StartMorning();
	if (Language.IsTextShown() == false && ServantName != "") ServantSpeakStart(ServantMaster + Language.GetHtml("MorningGreeting", assNode));
	if (IsEventAllowable() && !ret) {
		ResetEventPicked();
		
		// Parties check
		Parties.CheckReminder();
		
		// birthday checks
		var totbday:Number = 0;
		var gday:Number = GetDayOfYear(GameDate);		// day of year
		for (var so:String in SMData.arUsableSlaves) {
			sdata = SMData.arUsableSlaves[so];
			if (gday == GetDayOfYear(sdata.Birthday)) totbday++;
		}
		if (totbday > 0) {
			// happy birthday!
			ServantSpeakEnd();
			AddText("\r" + Language.GetHtml("CheerfulNote", "Assistant") + "\r");
			ServantSpeakStart("", true);
			for (var so:String in SMData.arUsableSlaves) {
				sdata = SMData.arUsableSlaves[so];
				if (gday == GetDayOfYear(sdata.Birthday)) {
					PersonName = sdata.SlaveName;
					AddText(Language.GetHtml("HappyBirthday", "Assistant"));
					AppendActText = true;
					XMLData.XMLGeneral("Other/BirthdayResponse", false, GetSlaveObjectXML(sdata));		// a response to the greeting
					if (totbday > 1) AddText("\r");
					totbday--;
				}
			}
			for (var so:String in SMData.arUsableSlaves) {
				sdata = SMData.arUsableSlaves[so];
				if (gday == GetDayOfYear(sdata.Birthday)) {
					PersonName = sdata.SlaveName;
					if (XMLData.XMLGeneral("Other/BirthdayEvent", false, GetSlaveObjectXML(sdata))) break;		// only one actual event per day
				}
			}
		}

	}
	TriggerEvents();
}

function StartEvening()
{
	//trace("StartEvening");
	StopPlanning(false, true);
	SetTime(18);
	SetText("");
	ResetEventPicked();
	SMData.DoAllSlavesOrders();
	UpdateSlave();
	//trace("StartEvening - done orders");
	if (IsEventAllowable()) {
		var ret:Boolean = modulesList.StartEvening();
		//trace("StartEvening = " + ret);
		if (Language.IsTextShown() == false && ServantName != "") ServantSpeak(ServantMaster + Language.GetHtml("EveningGreeting", assNode));
		if (IsEventAllowable()) {
			Parties.CheckReminder();
			ShowMainButtons();
		}
	}
}

function EarlyMorningEvents()
{
	eventLoop = 0;
	Information.HideInformation();
	if (!modulesList.SMPreEvent()) DoEventNext(251);
}

function StartNewDay(NumDays:Number, hidei:Boolean, free:Boolean)
{
	StopPlanning(true, true, hidei);
	UpdateDateAndItems(NumDays, free);
	AddTime(1);
}

function EndOfDay()
{
	//trace("EndOfDay");
	StopPlanning(false, true);
	ResetEventPicked();
	NumEvent = 254;
	if (modulesList.AfterNight()) {
		if (IsEventAllowable()) DoEvent(254);
		return;
	}
	
	// late night
	// Read Maculine Love Vol 1
	if (SMData.OtherBooks.CheckBitFlag(2) && !SMData.OtherBooks.CheckBitFlag(66)) {
		SMData.sGayTrainer += 0.2;
		sGayTrainer += 0.2;
		SMData.OtherBooks.SetBitFlag(66);
		var image:MovieClip = Items.ShowReading(Generic.mcBase.BondageClip, 261, -100, 30, 0, 336, 7);
		XMLData.XMLGeneral("Equipment/ReadMasculineGuide1");
		return;
	}
	// Read Maculine Love Vol 2
	if (SMData.OtherBooks.CheckBitFlag(3) && !SMData.OtherBooks.CheckBitFlag(67)) {
		SMData.sGayTrainer += 0.2;
		sGayTrainer += 0.2;
		SMData.OtherBooks.SetBitFlag(67);
		var image:MovieClip = Items.ShowReading(Generic.mcBase.BondageClip, 261, -100, 30, 0, 336, 6);
		XMLData.XMLGeneral("Equipment/ReadMasculineGuide2");
		return;
	}	
	
	NewDay();
}

function ParseDayNight(aNode:XMLNode, str:String)
{
	if (str == "startevening") {
		XMLData.StopXMLParsing();
		StartEvening();
		return;
	}

	var s:String = XMLData.EventText;
	var free:Boolean = aNode.attributes.free.toLowerCase() == "true";
	if (str == "newday") NewDay(XMLData.GetExpression(aNode.firstChild.nodeValue), 6, free);
	else if (str == "changedate" || str == "updatedateanditems") StartNewDay(XMLData.GetExpression(aNode.firstChild.nodeValue), free);
	XMLData.EventText = s;
}
