// Common/General People for the game
// Specific people for a city are in the city implementation and are linked here via calling currentCity methods.
//
// Linked to People.swf
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class PeopleModule extends BaseModule
{
	// gossip. simple bit array
	private var Gossip:Number;
		
	// constructor
	public function PeopleModule(mc:MovieClip,  cgm:Object)
	{
		super(mc, null, cgm);
		Gossip = 0;
	}
	
	public function Reset()
	{
		Gossip = 0;
	}
	
	// Images
	public function HideImages()
	{
		super.HideImages();
		mcBase.PeopleLord.gotoAndStop(1);
	}
	
	// load/save
	public function LoadGame(ldo:Object)
	{
		//super.LoadGame();
		this.Gossip = ldo.Gossip;
		if (Gossip == undefined) {
			this.Gossip = ldo.vGossip;
			if (Gossip == undefined) Gossip = 0;
		}
	}
		
	public function SaveGame(sdo:Object)
	{
		//super.SaveGame(sdo);
		sdo.Gossip = Gossip;
	}
	
	// access functions
	
	function GetPersonsObject(person) : Person
	{
		var per:Person = coreGame.currentCity.GetPersonsInstance(person);
		if (per != null) return per;
		return null
	}

	function GetPersonsMovieClip(person:Object) : MovieClip
	{
		var mc:MovieClip = MovieClip(person);
		if (mc._x != undefined) return mc;
		if (typeof(person) == "string") {
			var pi:Person = GetPersonsObject(String(person));
			if (pi != null) return GetPersonsMovieClipMC(pi.Id);
			mc = GetPersonsMovieClipMC(GetPersonsID(String(person)));
			if (mc != null) return mc;
		}
		return GetPersonsMovieClipMC(Number(person));
	}
	
	public function GetPersonsID(person:String) : Number
	{
		switch (person.split(" ").join("").toLowerCase()) {
			case "merchant": return 1;
			case "prostitute": return 3;
			case "highclassprostitute":
			case "courtesan": return 4;
			case "lesbiantrainer": 
			case "cutelesbian": return 10;
			case "ponytrainer": return 11;
			case "librarian": return 13;
			case "dancer": return 14;
			case "salonowner": return 15;
			case "cockmilker": return 16;
			case "swiminstructor": return 17;
			case "armourer": return 21;
			case "weapontrainer": return 22;
			case "tailor": return 23;
			case "nun": return 24;
			case "barowner": return 25;
			case "sleazybarowner": return 26;
			case "pimp": return 27;
			case "cook": return 28;
			case "oddteacher":
			case "privatetutor": return 29;
			case "refinementteacher": return 30;
			case "xxxschoolowner": return 31;
			case "fortuneteller": return 32;
			case "demon": return 33;
			case "angel": return 34;
			case "sailor": return 35;
			case "farmer": return 36;
			case "thug": return 38;
			case "itemsalesman": return 40;
			case "onsenowner": return 41;
			case "jester": return 42;
			case "dealer": return 44;
			case "guildmember": return 49;
			case "catgirltrainer": 
			case "singer": return 51;
			case "genericguard": return 54;
			case "tigergirl": return 58;
			case "bustycatgirl": return 59;
			case "catgirl": return 66;
			case "ladycat": return 67;
			case "maids": return 70;
			case "ringmaster": return 71;			
			
			case "oldlover": return 1000;
			case "malebuyer": return 1001;
			case "femalebuyer": return 1002;
			case "dickgirlbuyer": return 1003;
			
			case "freeperson": return 999;

			case "owner": return coreGame.Owner.GetOwner();
		}
		return coreGame.currentCity.GetPersonsID(person);
	}
	
	public function GetPersonsMovieClipMC(person:Number) : MovieClip
	{
		switch(person) {
			case 1: return mcBase.PeopleMerchant;
			case 2: return mcBase.PeopleBarMaid;
			case 3: return mcBase.PeopleProstitute;
			case 4: return mcBase.PeopleHighClassProstitute;
			case 5: return mcBase.PeopleMaid;
			case 6: return mcBase.PeopleKnight;
			case 7: return mcBase.PeopleCount;
			case 8: return mcBase.PeopleLord;
			case 9: return mcBase.PeopleLadyFarun;
			case 10: return mcBase.PeopleLesbian;
			case 11: return mcBase.PeoplePonyMistress;
			case 12: return mcBase.PeopleBountyHunter;
			case 13: return mcBase.PeopleLibrarian;
			case 14: return mcBase.PeopleDancer;
			case 15: return mcBase.PeopleSalonOwner;
			case 16: return mcBase.PeopleDickgirl;
			case 17: return mcBase.PeopleSwimInstructor;
			case 18: return mcBase.PeopleBeachGuide;
			case 19: return mcBase.PeopleGirl;
			case 20: return mcBase.PeopleIdol;
			case 21: return mcBase.PeopleArmourer;
			case 22: return mcBase.PeopleTrainer;
			case 23: return mcBase.PeopleTailor;
			case 24:
			case 50:
				return mcBase.PeopleNun;
			case 25: return mcBase.PeopleBarOwner;
			case 26: return mcBase.PeopleSleazyBarOwner;
			case 27: return mcBase.PeoplePimp;
			case 28: return mcBase.PeopleCook;
			case 29: return mcBase.PeopleOddTeacher;
			case 30: return mcBase.PeopleRefinementTeacher;
			case 31: return mcBase.PeopleXXXOwner;
			case 32: return mcBase.PeopleFortuneTeller;
			case 33: return mcBase.PeopleDemon;
			case 34: return mcBase.PeopleAngel;
			case 35: return mcBase.PeopleSailor;
			case 36: return mcBase.PeopleFarmer;
			case 37: return mcBase.PeopleDaruna;
			case 38: return mcBase.PeopleThug;
			case 39: return mcBase.PeopleSlut;
			case 40: return mcBase.PeopleItemSalesman;
			case 41: return mcBase.PeopleOnsenOwner;
			case 42: return mcBase.PeopleJester;
			case 43: return mcBase.PeopleMedium;
			case 44: return mcBase.PeopleDealer;
			case 46: return mcBase.PeopleGuard;
			case 47: return mcBase.PeopleLadyFarunsMaid;
			case 49: return mcBase.PeopleGuildMember;
			case 51: return coreGame.Catgirls.mcBase.PeopleSinger;
			case 52: return mcBase.PeopleAstridsMaid;
			case 53: return mcBase.PeoplePuppyGirl;
			case 54: return mcBase.PeopleGenericGuard;
			case 58: 
				coreGame.Farm.CheckBitFlag(33) ? coreGame.Catgirls.mcBase.PeopleTigerGirl.gotoAndStop(2) : coreGame.Catgirls.mcBase.PeopleTigerGirl.gotoAndStop(1);
				return coreGame.Catgirls.mcBase.PeopleTigerGirl;
			case 59: return coreGame.Catgirls.mcBase.PeopleBustyCatSlave;
			case 61: return coreGame.Catgirls.mcBase.PeopleNatsu;
			case 66: return coreGame.Catgirls.mcBase.PeopleCatgirl;
			case 67: return coreGame.Catgirls.mcBase.PeopleLadyCat;
			case 68: return mcBase.PeopleAzana;
			case 69: return mcBase.PeopleLeonthas;
			case 70: return mcBase.PeopleMaidsOthers;
			case 71: return mcBase.PeopleRingMaster;
			case 72: return mcBase.PeopleIceniAmbassador;
			case 73: return mcBase.PeopleGustaf;
			case 1000: return mcBase.PeopleOldLover;
			case 1001: return mcBase.PeopleBuyerMale;
			case 1002: return mcBase.PeopleBuyerFemale;
			case 1003: return mcBase.PeopleBuyerDickgirl;
		}
		return null;
	}
	
	public function GetPersonsName(person) : String
	{
		var psn:String = "";
		if (isNaN(person)) {
			var pstr:String = String(person).toLowerCase();
			if (pstr == "owner") psn = coreGame.slaveData.Owner.PersonName;
			else {
				var pn:Number = GetPersonsID(pstr);
				if (pn != 0) return GetPersonsName(pn);
			}
		} else {
			var pn:Number = Number(person);
			if (pn == -100 || pn == 3000) return Language.GetHtml("PersonYou", "People");
			if (pn == -99) return coreGame.ServantName;
			if (pn == -50) return coreGame.SlaveName;
			if (pn == 999) return Language.GetHtml("Person" + pn, "People");
			if (pn > 1000) psn = coreGame.slaveData.Owner.PersonName;
		}
		if (psn == "" || psn == undefined) return coreGame.currentCity.GetPersonsName(person);
		return psn;
	}
	
	public function GetPersonsGender(person) : Number
	{
		var per:Person = coreGame.currentCity.GetPersonsInstance(person);
		if (per != null) return per.PersonGender;

		switch (person) {
			case 0:
			case 1:
			case 6: 
			case 7:
			case 8:
			case 22:
			case 25:
			case 26:
			case 27:
			case 28:
			case 35:
			case 36:
			case 38:
			case 40:
			case 42:
			case 44:
			case 45:
			case 49:
			case 54:
			case 57:
			case 1999:
			case 1001:
				return 1;
			case 1002:
				return 2;
			case 13:
			case 16: 
			case 29:
			case 51:
			case 1003:
				return coreGame.DickgirlOn == 1 ? 3 : 2;
		}
		return 2;
	}
	
	// Show/Hide
	
	public function ShowPersonBase(person:Object, place:Number, align:Number, gframe:Number, delay:Number)
	{
		var mc:MovieClip = GetPersonsMovieClip(person);
		if (mc == mcBase.PeopleDickgirl && gframe == 1 && !coreGame.DickgirlTesticles) gframe = 2;
		else if (mc == mcBase.PeopleOddTeacher && coreGame.DickgirlOn == 1) {
			if (!coreGame.DickgirlTesticles) gframe = 3;
			else gframe = 2;
		}
		ShowMovie(mc, place, align, gframe, delay);
	}
	public function ShowPersonCommon(person:Object, place:Number)
	{
		if (place == 0) {
			coreGame.HideAssistant();
			if (coreGame.SMAppearance.place == 0) coreGame.SMAppearance.frame = -1000;
			coreGame.SMAppearance._visible = false;
			var mc2:MovieClip = MovieClip(person);
			if (mc2._x == undefined) coreGame.PersonShown = 10000 + Number(person);
			else coreGame.PersonShown = -3;
		}
		coreGame.SMAppearance.pplace = place;
	}
	public function ShowPerson(person:Object, placeo:Object, align:Number, gframe:Number, delay:Number)
	{
		if (coreGame.currentCity.ShowPerson(person, placeo, align, gframe, delay)) ShowPersonCommon(person, Number(placeo));
		else {
			ShowPersonBase(person, Number(placeo), align, gframe, delay);
			ShowPersonCommon(person, Number(placeo));
		}
	}
	
	public function HidePerson(person:Object)
	{
		if (!coreGame.currentCity.HidePerson(person)) GetPersonsMovieClip(person)._visible = false;
	}

	
	
	// Gossip
	
	public function GetGossip(newg:Boolean, tot:Number) : Number
	{
		var iTotal:Number = tot == undefined ? 16 : tot;
		var unheard:Number = 0;
	
		for (var i:Number = 0; i < iTotal; i++) {
			if ((Gossip & (1 << i)) == 0) unheard++;
		}
		if (newg) {
			temp = Math.floor(Math.random()*unheard);
			for (i = 0; i < iTotal; i++) {
				if ((Gossip & (1 << i)) == 0) {
					if (temp <= 0) {
						Gossip = Gossip | (1 << i);
						return i;
					}
					temp--;
				}
			}
		} else {
			temp = Math.floor(Math.random()*iTotal);
			Gossip = Gossip | (1 << temp);
		}
		return temp;
	}
			
	public function HearGossip(person:Number, slut:Boolean, newg:Boolean) {	return coreGame.modulesList.HearGossip(person, slut, newg); }

	
	// XML

	public function DecodePersonDetails(slaveo:Object, def:Number) : Number
	{		
		var slave:String = String(slaveo).toLowerCase();
		trace("DecodePersonDetails: " + slave + " " + coreGame.PersonOtherIndex + " " + coreGame.PersonIndex);
		
		if (slave == "current" || slave == "currentslave") return coreGame.PersonIndex;
		if (slave == "other" || slave == "personother") return coreGame.PersonOtherIndex;
		if (slave == "slave") return -50;
		if (slave == "generic") return -98;
		if (slave == "assistant") return -99;
		if (slave == "slavemaker") return -100;
		if (slave == "allslaves") return -999;
		if (slave == "loop") return Language.XMLData.loopvar;
		if (slave == "supervisor") return coreGame.Supervise ? -100 : -99;
		if (coreGame.Participants.length > 0) {
			if (slave == "allparticipants" && coreGame.Participants.length > 0) return -1000;
			if (slave.substr(0, 11) == "participant") {
				var pnum:Number = Number(slave.substr(11)) - 1;
				if (pnum < 0) pnum = 0;
				if (pnum < coreGame.Participants.length) return coreGame.Participants[pnum];
			}
		}
		var idx:Number = undefined;
		if (slave == "randommale") idx = SMData.GetRandomMaleSlaveOwned().SlaveIndex;
		else if (slave == "randomfemale") idx = SMData.GetRandomFemaleSlaveOwned().SlaveIndex;
		else if (slave == "randomdickgirl") idx = SMData.GetRandomDickgirlSlaveOwned().SlaveIndex;
		else if (slave == "randommaleordickgirl") idx = SMData.GetRandomMaleOrDickgirlSlaveOwned().SlaveIndex;
		else if (slave == "randomfemaleordickgirl") idx = SMData.GetRandomFemaleOrDickgirlSlaveOwned().SlaveIndex;
		else if (slave == "random") idx = SMData.GetRandomSlaveOwned().SlaveIndex;

		if (idx == undefined) {
			if (slaveo == undefined || slaveo == "") return def;
			if (typeof(slaveo) == "number") return Number(slaveo);
			idx = SMData.GetSlaveDetails(coreGame.UpdateMacros(slave), true).SlaveIndex;
		}
		if (idx == coreGame.slaveData.SlaveIndex) return -50;
		return idx;
	}
	
	public function ParsePersonDetails(aNode:XMLNode, def:Number) : Number
	{
		if (def == undefined) def = -50;
		var slave:String = aNode.attributes.slave.toLowerCase();
		if (slave == undefined) slave = aNode.attributes.person.toLowerCase();
		coreGame.PersonIndex = DecodePersonDetails(coreGame.UpdateMacros(slave), def);
		return coreGame.PersonIndex;
	}
	
	
	public function ParseSetPersonDetails(aNode:XMLNode)
	{
		var perd:Person = GetPersonsObject(aNode.attributes.person);
		if (perd == null) return false;
		
		var str:String;
	
		for (var attr:String in aNode.attributes) {
			str = attr.toLowerCase();
			if (str == "met") perd.SetMet(aNode.attributes[attr].toLowerCase() == "true");
			else if (str == "available" || attr.toLowerCase() == "accessible") perd.SetAccessible(aNode.attributes[attr].toLowerCase() == "true");
			else if (str == "visited") perd.SetVisited(aNode.attributes[attr].toLowerCase() == "true");
			else if (str == "doneinitialvisit" && aNode.attributes[attr].toLowerCase() == "true") perd.DoneInitialVisit();
			else if (str == "unavailable") perd.DaysUnavailable = Language.XMLData.GetExpression(aNode.attributes[attr]);
			else {	
				// general format for the attribute
				// flag1-bitno
				// where 1 is the flag
				var sl:Array;
				if (str.indexOf("-") != -1) sl = str.toLowerCase().split("-");
				else sl = str.toLowerCase().split("_");
				if (sl[0] == "flag") {
					var flagt:String = sl[1].toLowerCase();
					if (flagt == "smlove") perd.SMLove = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else if (flagt == "lovesm") perd.LoveSM = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else if (flagt == "sm" || flagt == "sm1") perd.SMFlag = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else if (flagt == "sm2") perd.SMFlag2 = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else if (flagt == "custom" || flagt == "custom1") perd.CustomFlag = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else if (flagt == "custom2") perd.CustomFlag2 = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else if (flagt == "person") perd.PersonFlag = Language.XMLData.GetExpression(aNode.attributes[attr]);
					else {
						if (aNode.attributes[attr].toLowerCase() == "true") perd.SetBitFlag(Number(sl[1]));
						else perd.ClearBitFlag(Number(sl[1]));
					}
				}
			}
		}
		return true;
	}
	
	// XML

	// Meet a person
	function ParseMeeting(aNode:XMLNode) : Boolean
	{
		var person:String = aNode.attributes.person.toLowerCase();
	
		var evt:String = aNode.attributes.event;
		if (evt == undefined) evt = "";
		var say:String = coreGame.UpdateMacros(Language.strLineChanges(aNode.firstChild.nodeValue));
		
		// Generic meetings, common to all cities
		switch (person.split(" ").join("")) {
			
			case "trader":
			case "salesman":
				coreGame.currentCity.ItemSalesman.VisitShop();
				return true;
	
			case "nun": 
				coreGame.MeetNun(say);
				return true;
	
			case "sleazybarowner":
				coreGame.MeetSleazyBarOwner();
				return true;
	
			case "oddteacher":
				var plc:Number = isNaN(evt) ? coreGame.WalkPlace : Number(evt);
				coreGame.MeetOddTeacher(plc, say);
				return true;
				
			case "xxx":
			case "xxxschoolowner":
				coreGame.MeetXXXSchoolOwner();
				return true;			
		}
		return coreGame.modulesList.MeetPerson(0, 0, person, say, evt);
	}
	
	
	// day/time
	//public function NewDay(nDays:Number) { }

	
	// Endings
	
	public function EndingStart() : Boolean
	{
		if (coreGame.currentCity.EndingStart(coreGame.Score) == true) return true;
		return false;
	}
	
	public function EndingFinish() : Boolean
	{
		if (coreGame.currentCity.EndingFinish(coreGame.Score) == true) return true;
		return false;
	}
	
	public function AfterEndingFinish()
	{
		coreGame.currentCity.AfterEndingFinish();
	}


}