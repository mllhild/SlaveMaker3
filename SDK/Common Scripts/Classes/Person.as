// Person - class defining a person to visit
//
// Variables (common to Place)
//
// CustomFlag - standardly contains the reputation gain derived from visiting this person
//
// Standard BitFlags as this eventually inherits from BitFlags
// 128 - Nobility
// 64+ do not reset between slaves
	
// Translation status: COMPLETE

import Scripts.Classes.*;


class Person extends Place
{
	public var PersonName:String;	// their name
	public var PersonGender:Number;	// their gender

	public var SMLove:Number;		// Slave Maker love for person
	public var SlaveLove:Number;	// Slave love for person
	public var LoveSM:Number;		// person's love of Slave Maker
	public var LoveSlave:Number;	// person's love of slave's
	public var PersonFlag:Number;	// generic flag, reset each slave
	
	public var PregnancyGestation:Number;	// state of tentacle pregnancy
	public var PregnancyCount:Number;		// number of offspring
	public var PregnancyType:String;		// type of pregnancy
	public var TotalTentaclePregnancy:Number;	// total tentacle pregnancies
	public var DaysUnavailable:Number;		// days unavailable
	public var TotalChildren:Number;		// total child borths (non-tentacle)
	public var Fertility:Number;			// fertility percent value
	
	public var DifficultyLendMod:Number;	// modifier to difficulty to lend
	public var DifficultyLendStart:Number;	// initial modifier for each slave
	public var TotalLend:Number;			// total times lent
	public var InLoveWith:String;			// name of person they are in love with
	
	private var Met:Boolean;				// true and has met slave/you
	private var VisitedToday:Boolean;		// true and has been visited today
	
	public var strCity:String;				// the city the person lives in
	public var strLocation:String;			// location/area in the city the person lives
	
	// list of image by job, chore, sex act. Includes default participants for sex acts
	public var ActInfoCurrent:ActInfoList;		// 'pointer' to either Base or Other below
	public var ActInfoBase:ActInfoList;			// standard list of images
	public var ActInfoOther:ActInfoList;		// alternate list, for say a slave that can change form
	
	
	public function Person(nn:String, cg:Object, person:Number, mod:Number, can:Boolean, cc:Object)
	{ 
		super(nn, null, cg, person, can == undefined ? false : can);
		Reset(mod, can);
		
		// value of 0 is for an instance of PersonOwner class
		//trace("Person: " + nn + " " + Id + " " + strNodeName);
		if (person == 0) return;
		
		if (cc == undefined) cc = coreGame.currentCity;
		cc.arPeople.push(this);
		parentCity = cc;
		strCity = cc.ModuleName;		
	}
	
	public function Reset(mod:Number, access:Boolean)
	{	
		super.Reset(access == undefined ? false : access);
		
		PersonGender = coreGame.People.GetPersonsGender(Id);
		PersonName = "";

		SMLove = 0;
		SlaveLove = 0;
		LoveSM = 0;
		LoveSlave = 0;
		PersonFlag = 0;
		InLoveWith = "";
		
		PregnancyGestation = 0;
		PregnancyType = "";
		PregnancyCount = 0;
		TotalTentaclePregnancy = 0;
		TotalChildren = 0;
		Fertility = coreGame.config.nDefaultFertility;
		DaysUnavailable = 0;
				
		DifficultyLendMod = mod == undefined ? 0 : mod;
		DifficultyLendStart = DifficultyLendMod;
		TotalLend = 0;
		Met = false;
		VisitedToday = false;
		
		strCity = "Mardukane";
		strLocation = "";
		
		ActInfoBase = null;
		ActInfoOther = null;
		ActInfoCurrent = null;
	}
	
	public function ResetNode()
	{	
		// note: these are the visit/lend nodes for the person
		if (parentCity == null) return;
		// Visit Node
		pNode = parentCity.FindPersonNodeCByName(strNodeName);
		xNode = Language.XMLData.GetNodeC(Language.flNode, "Visits/Visit" + strNodeName);
		if (xNode == null) xNode = Language.XMLData.GetNodeC(pNode, "Visit");
		
		xNodeAlt = Language.XMLData.GetNodeC(Language.flNode, "Visits/Lend" + strNodeName);
		if (xNodeAlt == null) xNodeAlt = Language.XMLData.GetNodeC(pNode, "Lend");
		
		if (ActInfoBase == null) ActInfoBase = new ActInfoList(this, undefined, coreGame);
		else ActInfoBase.ResetList(this);
		ActInfoBase.ActFolder = Language.XMLData.GetXMLString("Folder", pNode);
		ActInfoBase.LoadActImages(pNode, "Images");
		ActInfoCurrent = ActInfoBase;
	}
	
	public function Load(lo:Object)
	{
		super.Load(lo);
		if (lo.vSMLove == undefined) return;
		SMLove = lo.vSMLove;
		SlaveLove = lo.vSlaveLove;
		LoveSM = lo.vLoveSM;
		LoveSlave = lo.vLoveSlave;
		PersonFlag = lo.vPersonFlag;
		InLoveWith = lo.vInLoveWith;
		
		PregnancyGestation = lo.vPregnancyGestation;
		if (PregnancyGestation == undefined) PregnancyGestation = 0;
		PregnancyCount = lo.vPregnancyCount;
		if (PregnancyCount == undefined) PregnancyCount = 0;
		PregnancyType = lo.vPregnancyType;
		TotalTentaclePregnancy = lo.vTotalTentaclePregnancy;
		DifficultyLendMod = lo.vDifficultyLendMod;
		TotalChildren = lo.TotalChildren;
		if (TotalChildren == undefined) TotalChildren = 0;
		Fertility = lo.Fertility;
		if (Fertility == undefined) Fertility = coreGame.config.nDefaultFertility;
		
		TotalLend = lo.vTotalLend;
		Met = lo.vMet;
		VisitedToday = lo.vVisitedToday;
		DaysUnavailable = lo.DaysUnavailable;
		if (DaysUnavailable == undefined) DaysUnavailable = 0;
		PersonGender = lo.PersonGender;
		if (PersonGender == undefined) PersonGender = coreGame.People.GetPersonsGender(Id);
		PersonName = lo.PersonName;
		if (PersonName == undefined) PersonName = "";
		
		if (lo.strCity != undefined) {
			strCity = lo.strCity;
			strLocation = lo.strLocation;
		}

	}
	public function Save(so:Object)
	{
		super.Save(so);
		so.vSMLove = SMLove;
		so.vSlaveLove = SlaveLove;
		so.vLoveSM = LoveSM;
		so.vLoveSlave = LoveSlave;
		so.vPersonFlag = PersonFlag;
		so.vInLoveWith = InLoveWith;
		
		so.vPregnancyGestation = PregnancyGestation;
		so.vPregnancyCount = PregnancyCount;
		so.vPregnancyType = PregnancyType + "";
		so.vTotalTentaclePregnancy = TotalTentaclePregnancy;
		so.TotalChildren = TotalChildren;
		so.Fertility = Fertility;
		
		so.vDifficultyLendMod = DifficultyLendMod;
		so.vTotalLend = TotalLend;
		so.vMet = Met;
		so.vVisitedToday = VisitedToday;
		so.DaysUnavailable = DaysUnavailable;
		so.PersonGender = PersonGender;
		so.PersonName = PersonName + "";
		
		so.strCity = strCity;
		so.strLocation = strLocation;
	}
	
	// Identity
	
	public function IsPerson(str:String) : Boolean
	{
		str = str.toLowerCase();
		if (strNodeName.toLowerCase() == str) return true;
		var pn:String = PersonName;
		if (PersonName == "") pn = Language.GetHtml("Person" + Id, "People");
		if (pn.split(" ").join("").toLowerCase() == str.split(" ").join("")) return true;
		var ar:Array = pn.split(" ");
		if (ar[ar.length - 1].toLowerCase() == str) return true;
		if (ar.length == 1) return false;
		pn = ar[0].toLowerCase();
		if (pn != "lord" && pn != "lady") return pn == str;
		return false;
	}
	
	
	/*
	Points(flag, lovesm, loveslave, smlove, slavelove)
	*/
	public function PointsPerson(flag:Number, lovesm:Number, loveslave:Number, smlove:Number, slavelove:Number)
	{
		PersonFlag += flag;
		if (smlove != undefined) {
			SMLove += smlove;
			if (SMLove > 100) SMLove = 100;
			if (SMLove < 0) SMLove = 0;
		}
		if (slavelove != undefined) {
			SlaveLove += slavelove;
			if (SlaveLove > 100) SlaveLove = 100;
			if (SlaveLove < 0) SlaveLove = 0;
		}
		if (LoveSlave >= 0 && LoveSM >= 0) {
			if (lovesm != undefined) {
				LoveSM += lovesm;
				if (LoveSM > 100) LoveSM = 100;
				if (LoveSM < 0) LoveSM = 0;
			}
			if (loveslave != undefined) {
				LoveSlave += loveslave;
				if (LoveSlave > 100) LoveSlave = 100;
				if (LoveSlave < 0) LoveSlave = 0;
			}
		}
	}
	public function Points(flag:Number, lovesm:Number, loveslave:Number, smlove:Number, slavelove:Number)
	{
		PointsPerson(flag, lovesm, loveslave, smlove, slavelove);
	}

	
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		LastVisit = 0;	
		LastVisitTime = 0;
		PersonFlag = 0;
		CustomFlag = 0;
		if (keepmet != true) Met = false;
		SlaveLove = 0;
		TotalLend = 0;
		VisitedToday = false;
		DifficultyLendMod = DifficultyLendStart;
		if (LoveSlave > 0) LoveSlave = 0;
		if (visit != undefined) {
			if (visit == false) super.SetAccessible(visit);
		}
		
		if (all != false) super.StartNewSlave(except, exceptf);
	}
	
	public function StartNewSlaveAll(visit:Boolean, keepmet:Boolean, excpt:Number, exceptf:Number)
	{
		StartNewSlave(visit, keepmet);
		super.StartNewSlave(excpt);
	}
	
	public function InLove(sname:String, loyal:Boolean)
	{
		InLoveWith = sname;
		if (loyal == true) {
			if (sname == coreGame.SMData.SlaveMakerName) LoveSM = -1;
			else LoveSlave = -1;
		}
	}
	
	
	// Meetings
	
	public function IsMet() : Boolean {	return Met;	}
	public function SetMet(met:Boolean) { Met = met == undefined ? true : met; }
	
	public function Meeting(meet:Number, say:String) : Boolean
	{
		//trace("Person.Meeting = " + strCity + " " + coreGame.currentCity.ModuleName);
		if (strNodeName == "") return false;
		if (strCity != "") {
			if (strCity.toLowerCase() != coreGame.currentCity.ModuleName.toLowerCase()) return false;
		}
		SetSlaveDetails(_root);
		SMData = coreGame.SMData;
		Supervise = coreGame.Supervise;
		
		ShowThem(0, 0);
		coreGame.genNumber = meet;
		coreGame.genString = say;
		Language.XMLGeneral("Meeting", undefined, xNode);
		if (say != "" && say != undefined) AddText(say);
		return true;
	}

	
	// Visits
	
	// Visit process for a person
	// 1) call core/slave function DoVisit(person)
	// 2) call ShowThem("Visit")
	// 3) if this is actually preparing for a lend, then assorted tests (see lending below)
	// 4) if this is the first time visiting then use Visits/xmlnode/VisitIntroduction 
	//		eg Visits/VisitLadyFarun/VisitIntroduction
	// 5) check if the person is unavailable (ill/recent child birth etc) based on DaysUnavailable, if so process
	//		Visits/xmlnode/Unavailable 
	// 6) if the slave is naked call a contidional xml Visits/xmlnode/NakedResponse
	//		if anything is done then the visit is stopped. Text can be shown and visit using <EndEvent done='false'/>
	// 7) check if the slave is acceptable to be visited. Checks CanBeVisited and associated xml Visits/xmlnode/CanVisit
	// 8) process xml Visits/xmlnode/VisitStart
	// 9) call for the person Visit()
	
	// called as soon as the the visit starts, before any tests
	// normally here show the persons image/background for the visit
	
	// called when checking if the person can be visited.
	// events/text etc are permitted here
	// standardly apply a stat text to see if the slave is a candidate. Do always apply Available as well
	// return: return true if they can be visited
	public function CanBeVisited() : Boolean
	{
		if (strCity != "") {
			if (strCity.toLowerCase() != coreGame.currentCity.ModuleName.toLowerCase()) return false;
		}
		if (strLocation != "") {
			var plc:Place = coreGame.currentCity.GetPlaceObject(strLocation);
			if (plc != null && !plc.IsAccessible()) {
				Language.XMLGeneral(strLocation + "Inaccessible", undefined, xNode);
				return false;
			}
		}
		return (Language.XMLData.GetXMLBooleanParsed("CanVisit", xNode, true) && Accessible);
	}
	
	// actually do the visit now to a person )common to all people)
	// should not be a reason to overload this
	public function DoVisitNow(walk:Boolean) : Boolean
	{
		//trace("Person.DoVisitNow: " + xNode.parentNode);
		//If checking if you can lend to them
		SetSlaveDetails(_root);
		coreGame.genNumber = walk ? 1 : 0;
		ShowThem("Visit");
		coreGame.EventTotal = TotalVisit;

		if (coreGame.LendPerson == -1000) {
			if (!IsVisited()) {
				// usual message
				// You should at least take #slave to visit #person before trying to lend #slave to her.
				if (Language.XMLGeneral("VisitFirst", undefined, xNodeAlt)) coreGame.LendPerson = 0;
			} else {
				// usual message
				// You will make arrangements to loan #slave to #
				Language.XMLGeneral("LendArranged", undefined, xNodeAlt);
			}
			return false;
		}
		
		if (IsDayTime()) {
			// Limit visits by Day only
			if (Language.XMLGeneral("DayResponse", undefined, xNode)) {
				coreGame.HideImages();
				Backgrounds.ShowSky(3);
				return false;
			}
		} else {
			// Limit visits by Night only
			if (Language.XMLGeneral("NightResponse", undefined, xNode)) {
				coreGame.HideImages();
				Backgrounds.ShowNight();
				return false;
			}			
		}
		
		// First visit ever
		if (IsInitialVisit()) {
			// usual message
			// You decide to visit Lady Farun, the beautiful court lady, and bring #slave to learn of the court from her. At least that is the reason you give yourself.
			Language.XMLGeneral("VisitIntroduction", undefined, xNode);
			DoneInitialVisit();
			BlankLine();
		}

		// if she unwell/unavailable
		if (DaysUnavailable != 0) {
			DoneInitialVisit();
			if (Language.XMLGeneral("Unavailable", undefined, xNode)) {
				coreGame.LendPerson = 0;
				return false;
			}
		}
		
		// Naked slave?
		if (coreGame.Naked) {
			if (Language.XMLGeneral("NakedResponse", undefined, xNode)) return false;
		}
		
		// Are you allowed?
		// do you know her and allowed to visit
		// does your slave meet the needed criteria
		if ((!CanBeVisited()) && !(coreGame.Owner.GetOwner() == Id || coreGame.NobleLoveType == Id)) {		
			// no? then turn the slave away
			Language.XMLGeneral("RejectVisit", undefined, xNode);
			return false;
		}
				
		// common initial text, or initial text on the first visit
		if (Language.XMLGeneral("VisitStart", undefined, xNode)) BlankLine();
		
		if (IsEventAllowable() == false || coreGame.NextEvent._visible || coreGame.VisitLendPerson == 0) return false;

		// Visit the person
		return Visit(walk);
	}
	
	// called to do the actual visit to the person
	// this is very basic a standard visit below, probably call in an actual visit using super.Visit(walk)
	// return: true actually visited. NOTE: in almost all cases return true
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		SetVisited();

		var bVisit:Boolean = Language.XMLGeneral("NormalVisit", undefined, xNode);
		if (bVisit) {
			coreGame.modulesList.VisitChatWithPerson(Id);
			coreGame.People.HearGossip(Id, Language.GetXMLBoolean("Slut", pNode, false));
		}
		return bVisit;
	}
	
	// flag that the person has been visited today
	// parameter: visit = true - then they were visited
	//                  = false - used to undo a visit (rarely used)
	public function SetVisited(visit:Boolean) {
		if (visit == false) {
			Visited = false;
			VisitedToday = true;
			if (LastVisit == coreGame.GameDate) TotalVisit--;
			LastVisit = 0;
		} else {
			super.SetVisited();
			SetMet();
			VisitedToday = true;
			TotalVisit++;
		}
	}
	
	// Has this person been visit this day, resets at dawn
	public function IsVisitedToday() : Boolean { return VisitedToday; }
	
	// Loans
	
	// Loan process for a person
	// 1) call core/slave function DoLendHerOffer(person)
	// 2) call ShowThem("Lend")
	// 3) check if the person is unavailable (ill/recent child birth etc) based on DaysUnavailable, if so process
	//		Visits/xmlnode/Unavailable 
	// 4) if the slave is naked call a contidional xml Visits/xmlnode/NakedResponse
	//		if anything is done then the visit is stopped. Text can be shown and visit using <EndEvent done='false'/>
	// 5) check if the slave is acceptable to be visited. Checks CanBeLoanedTo and associated xml Visits/xmlnode/CanVisit
	// 6) process xml Visits/xmlnode/VisitStart
	// 7) call for the person LoanTo()

	
	// called as soon as the the visit starts, before any tests
	// normally here show the persons image/background for the visit
	
	// get the difficulty mod for lending
	// implemented here to allow overloading
	public function GetDifficultyLendMod() : Number { return DifficultyLendMod; }
	
	// called when checking if the person can be visited.
	// events/text etc are permitted here
	// standardly apply a stat text to see if the slave is a candidate. Do always apply Accessible as well
	// return: return true if they can be visited
	public function CanBeLoanedTo() : Boolean
	{
		if (strCity != "") {
			if (strCity.toLowerCase() != coreGame.currentCity.ModuleName.toLowerCase()) return false;
		}
		if (strLocation != "") {
			var plc:Place = coreGame.currentCity.GetPlaceObject(strLocation);
			if (plc != null && !plc.IsAccessible()) {
				Language.XMLGeneral(strLocation + "Inaccessible", undefined, xNode);
				return false;
			}
		}		
		return (Language.XMLData.GetXMLBooleanParsed("CanLend", xNodeAlt, true) && Accessible);
	}
	
	// Starr the lend process, common to all people, should not require overloading/customisation
	public function DoLendNow() : Boolean
	{
		SetSlaveDetails(_root);
		ShowThem("Lend");
		coreGame.EventTotal = TotalLend;
		
		// are they unwell/unavailable
		if (DaysUnavailable != 0) {
			if (Language.XMLGeneral("Unavailable", undefined, xNode)) {
				coreGame.LendPerson = 0;
				return false;
			}
		}
		
		if (IsDayTime()) {
			// Limit visits by Day only
			if (Language.XMLGeneral("DayResponse", undefined, xNode)) {
				coreGame.HideImages();
				Backgrounds.ShowSky(3);
				return false;
			}
		} else {
			// Limit visits by Night only
			if (Language.XMLGeneral("NightResponse", undefined, xNode)) {
				coreGame.HideImages();
				Backgrounds.ShowNight();
				return false;
			}			
		}
		
		if (coreGame.Naked) {
			if (Language.XMLGeneral("NakedResponse", undefined, xNode)) return false;
		}
		
		// does your slave meet the needed criteria
		if ((!CanBeLoanedTo()) && !(coreGame.Owner.GetOwner() == Id || coreGame.NobleLoveType == Id)) {		
			// no? then turn the slave away
			Language.XMLGeneral("RejectLend", undefined, xNodeAlt);
			return false;
		}
		
		// common initial text, or initial text on the first visit
		Language.XMLGeneral("LendStart", undefined, xNodeAlt);
		BlankLine();
		
		if (IsEventAllowable() == false || coreGame.NextEvent._visible || coreGame.VisitLendPerson == 0) return false;


		return LoanTo();
	}

	// Do the actual loan
	// below is a standard implementation, can be called using super.LoadTo() but not mandatory, but the SlaveGirl function should be called in any implementation
	// return true if the loan was successful NOTE: in almost all cases return true
	public function LoanTo() : Boolean
	{
		coreGame.ResetNotFucked();
		if (coreGame.SlaveGirl.ShowActLend(coreGame.VisitLendPerson) == false) coreGame.UseGeneric = true;
		// obsolete versions	
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		coreGame.ShowActImage();
				
		if (coreGame.AppendActText) {
			return Language.XMLGeneral("NormalLend", undefined, xNodeAlt);
		}
		return true;
	}
	
	
	// Day reset
	
	public function NewDay(NumDays:Number)
	{
		VisitedToday = false;
		
		if (PregnancyGestation > 0) {
			PregnancyGestation -= NumDays;
			// do not give birth until visited
			if (PregnancyGestation < 1) PregnancyGestation = 1;
		}
		if (DaysUnavailable != 0) {
			if (DaysUnavailable > 0) {
				DaysUnavailable -= NumDays;
				if (DaysUnavailable < 0) DaysUnavailable = 0;
			} else {
				DaysUnavailable += NumDays;
				if (DaysUnavailable > 0) DaysUnavailable = 0;				
			}
		}
	}

	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		//trace("Person.ShowThem: " + placeo);
		var place:Number = Number(placeo);
		if (typeof(placeo) == "string") {
			var places:String = placeo;
			if (places == "Visit") {
				if (Language.XMLGeneral("ShowVisit", undefined, xNode)) return true;
				place = 1;
				align = 1;
				gframe = 1;
				
			} else if (places == "Lend") {
				if (Language.XMLGeneral("ShowLend", undefined, xNodeAlt)) return true;
				place = 1;
				align = 1;
				gframe = 1;				
			} else {
				Language.XMLGeneral("Show" + places, undefined, pNode);
				return true;
			}
		}
		var frm:Number = 0;
		if (ActInfoCurrent != null) frm = ActInfoCurrent.ShowActImage(20100, place, align, gframe);
		if (frm == 0) coreGame.People.ShowPersonBase(Id, place, align, gframe, delay);
		return true;
	}
	
	
	// Pregnancy
	
	public function CanImpregnate(type:String) : Boolean
	{
		if (PregnancyGestation > 0 || coreGame.PregnancyOn == false) return false;
		
		var sf:Boolean = PersonGender != 0 && PersonGender != 1 && PersonGender != 4;
		if (!sf) return false;
		if (type.toLowerCase() == "yours" && SMData.Gender == 2) {
			if (!coreGame.SMData.SMFeeldoOK) return false;
		}
		return true;
	}

	public function CheckImpregnate(type:String, count:Number, gestation:Number) : Boolean {
		if (CanImpregnate(type)) {
			var fer:Number = Fertility;
			if (PercentChance(fer) || type.substr(0, 8).toLowerCase() == "tentacle") {
				Impregnate(type, count, gestation);
				return true;
			}
		}
		return false;
	}
	
	public function Impregnate(type:String, count:Number, gestation:Number)
	{
		if (!CanImpregnate(type)) return;
		
		PregnancyType = type;
		if (gestation == undefined) {
			if (type.toLowerCase() == "human") PregnancyGestation = coreGame.config.nBaseGestation + Math.floor(Math.random()*10);
			else PregnancyGestation = 28 + Math.floor(Math.random()*5);
		} else PregnancyGestation = gestation;
		if (count == undefined) PregnancyCount = slrandom(slrandom(2));
		else PregnancyCount = count;
	}
	
	
	// 'Noble' love
	// note: mostly obsolete

	public function NobleLoveEvent()
	{
		if (sd.NobleLoveType != Id && sd.NobleLoveType != -1) return;
		
		if (sd.NobleLove >= 0) sd.NobleLove++;
		coreGame.genNumber = 1;
		coreGame.VisitLendPerson = Id;
		
		coreGame.SlaveGirl.NobleLove(true);
		Language.XMLGeneral("Other/NobleLove", false, coreGame.GetSlaveObjectXML(coreGame.slaveData));
	}

	
	// Miscellaneous
	// common to all people, no variation for people
	
	public function GetPersonDetails()
	{
		coreGame.PersonName = coreGame.People.GetPersonsName(Id);
		coreGame.PersonGender = PersonGender;
		coreGame.GetPersonGenderText(PersonGender);
	}
	
	static function VisitVar(vv:Number, inc:Number, max:Number) : Number
	{
		if (vv == 0.01 || vv == 0.02) vv = 0;
		if ((vv + inc) > max) inc = max + 1 - vv;
		if (vv == 0 && inc > max) inc = max - 1;

		vv = vv + inc;
		if (vv == 0) return 0.01;
		return vv;
	}
	
	public function ShowFlags()
	{
		super.ShowFlags();
		var say:String = "  Person Flag = " + PersonFlag;
		say += "  Met = " + IsMet() + "\r";
		say += "  Total Visits = " + TotalVisit;
		say += "  Total Lends = " + TotalLend + "\r";
		say += "  Pregnancy = " + PregnancyGestation;
		say += "  Pregnant With = " + PregnancyType + "\r";
		AddText(say);
	}
	
}