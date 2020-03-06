// A single act, and the images, participant data for it
// Translation status: COMPLETE

import Scripts.Classes.*;

class ActInfo {
	
	// Variables
	private var coreGame:Object;			// core game engine
	public var slaveData:Object;			// the instance of the Slave class for this slave, null for event/people modules
	
	// saved
	
	// act
	// 0-999 - sex
	//   501+ = assigned custom acts 
	// 1000-1999 - chores, jobs, schools
	//   1501+ = assigned custom acts
	// 2000-2399 - shops
	// 2400-2499 - slave contests
	// 2500-2999 - slave maker
	//   2700+ = custom talk to slave options
	//   2800+ = assigned custom training
	//   2900+ = custom order slave
	// 3000-4000 = endings
	// 10000+ - event
	public var Act:Number;
		
	public var Normal:ActCounts;
	public var Dickgirl:ActCounts;
	public var Lesbian:ActCounts;
	public var Naked:ActCounts;
	public var Catgirl:ActCounts;
	public var Pregnant:ActCounts;
	public var Puppygirl:ActCounts;
	
	public var Participants:Array;			// default array of selected participants for this act as planned
	// max/min - required people for act, special values
	// max 0 = unlimited
	// min 0 = solo act
	public var MaxParticipants:Number;
	public var MinParticipants:Number;
	
	public var TotalDone:Number;
	public var Level:Number;
	
	public var bShown:Boolean;
	public var strNodeName:String;
	public var strNodeNameLNSP:String;
	public var strSubType:String;
	
	// unsaved
	
	// types
	// 0 = not specified
	// 1 = chore
	// 2 = job
	// 3 = school
	// 4 = slave maker
	// 5 = sex normal
	// 6 = sex extreme
	// 7 = minor slave
	// 8 = shop
	// 9 = event
	// 10 = talk to slave option
	// 11 = contest
	// 12 = slave orders
	// 13 = endings
	// defaults based on act number as noted above
	public var Type:Number;
	
	public var FirstTimeToday:Boolean;			// has the act been done today
	
	public var AllowedPartnerGender:String;		// allowed partner gender "male", "female", "dickgirl", "any", "same", "opposite", "fuck"

	// act state
	public var Name:String;
	public var Description:String;
	public var PlanTitle:String;
	public var Duration:Number;
	public var Cost:Number;
	public var Shortcut:String;
	public var StartTime:Number;
	public var EndTime:Number;
	public var Ticked:Boolean;
	public var Available:Boolean;
	
	public var fobj:Object; 
	public var func:String;
	public var rofunc:String;
	public var routfunc:String;
		
	public var childAct:ActInfo;
	public var parentAct:ActInfo;
	
	public var xNode:XMLNode;
	public var imageNode:XMLNode;

	
	// Functions
	
	// Constructor
	public function ActInfo(sd:Object, cg:Object, nn:String) { 
		coreGame = cg;
		slaveData = sd;

		Act = 0;
		Type = 0;
		MinParticipants = 0;
		MaxParticipants = 0;
		TotalDone = 0;
		Level = -1;
		Name = "";
		Description = "";
		Cost = 0;
		Duration = 2;
		Ticked = false;
		Available = true;
		StartTime = undefined;
		EndTime = undefined;
		bShown = true;
		Shortcut = "";
		PlanTitle = "";
		strNodeName = nn == undefined ? "" : nn;
		if (strNodeName != "") strNodeNameLNSP = strNodeName.toLowerCase().split(" ").join("");
		FirstTimeToday = true;
		AllowedPartnerGender = "any";
		childAct = null;
		parentAct = null;
		strSubType = "";
		xNode = null;
		imageNode = null;
		
		Normal = new ActCounts(sd, cg);
		if (sd != null) {
			Dickgirl = new ActCounts(sd, cg);
			Lesbian = new ActCounts(sd, cg);
			Naked = new ActCounts(sd, cg);
			Catgirl = new ActCounts(sd, cg);
			Pregnant = new ActCounts(sd, cg);
			Puppygirl = new ActCounts(sd, cg);
							
			Participants = new Array();
		}
	}
	
	public function SetActIDType(act:Number, type:Number)
	{
		
		if (act != undefined) Act = act;
		if (type != undefined) Type = type;
		else {
			if (Act > 0 && Act < 1000 && Act != 10 && (Act < 26 || Act > 29)) {
				if ((Act > 10 && Act < 19) || Act == 21 || Act == 25) Type = 6;
				else Type = 5;
			} else if (Act < 2000) Type = 0;		// general to prevent AddAllActByType showing
			else if (Act < 2400) Type = 8;
			else if (Act < 2500) Type = 11;
			else if (Act >= 2900 && Act < 3000) Type = 12;
			else if (Act < 10000) Type = 4;
			else if (Act < 100000) Type = 9;
			else Type = 99;
		}
		
		if (Act == 15 || Act == 25 || Act == 21) {
			// group acts
			MinParticipants = 3;
			MaxParticipants = 0;
			if (Act == 25) AllowedPartnerGender = "maculine";
		} else if (Act == 19) {
			// threesome
			MinParticipants = 2;
			MaxParticipants = 2;
		} else if (Act == 8 || Act == 9 || Act == 10 || Act == 12 || Act == 13 || Act == 14 || Act == 16 || Act == 17 || Act == 18 || Act == 24 || Act == 26 || Act == 27 || Act == 28 || Act == 29 || Act == 99 || (Act >= 1040 && Act < 1500)) {
			// solo act
			MinParticipants = 0;
			MaxParticipants = 0;				
		} else {
			// 1 on 1
			MaxParticipants = 1;
			MinParticipants = 1;
			if (Act == 11) AllowedPartnerGender = "same";
			else if (Act == 4) AllowedPartnerGender = "fuck";	
		}
	}
	
	public function GetTotalImages() : Number
	{
		return Normal.GetTotalImages() + Dickgirl.GetTotalImages() + Lesbian.GetTotalImages() + Naked.GetTotalImages() + Catgirl.GetTotalImages() + Pregnant.GetTotalImages() + Puppygirl.GetTotalImages();
	}
			
	
	// Save/Load
	public function Save(so:Object)
	{
		so.Act = Act;
		delete so.Participants;
		so.Participants = new Array();
		var len:Number = Participants.length;
		for (var i:Number = 0; i < len; i++) so.Participants.push(Participants[i]);
		so.MaxParticipants = MaxParticipants;
		so.MinParticipants = MinParticipants;
		so.TotalDone = TotalDone;
		so.Level = Level;
		so.bShown = bShown;
		so.strNodeName = strNodeName;
		so.FirstTimeToday = FirstTimeToday;
		so.strSubType = strSubType;
		
		so.Normal = new Object();
		Normal.Save(so.Normal);

		so.Dickgirl = new Object();
		Dickgirl.Save(so.Dickgirl);
		so.Lesbian = new Object();
		Lesbian.Save(so.Lesbian);
		so.Naked = new Object();
		Naked.Save(so.Naked);
		so.Catgirl = new Object();
		Catgirl.Save(so.Catgirl);
		so.Pregnant = new Object();
		Pregnant.Save(so.Pregnant);
		so.Puppygirl = new Object();
		Puppygirl.Save(so.Puppygirl);		
	}
	public function Load(lo:Object)
	{
		delete Participants;
		Participants = new Array();
		var len:Number = lo.Participants.length;
		for (var i:Number = 0; i < len; i++) Participants.push(lo.Participants[i]);
		TotalDone = lo.TotalDone;
		if (TotalDone == undefined) TotalDone = 0;
		Level = lo.Level;
		if (Level == undefined) Level = -1;
		strSubType = lo.strSubType;
		if (strSubType == undefined) strSubType = "";
		
		SetActIDType(lo.Act);
		
		MaxParticipants = lo.MaxParticipants;
		MinParticipants = lo.MinParticipants;

		bShown = lo.bShown;
		if (bShown == undefined) bShown = true;
		if (strNodeName == "") {
			strNodeName = lo.strNodeName;
			strNodeNameLNSP = strNodeName.toLowerCase().split(" ").join("");
			if (lo.strNodeName == undefined) strNodeName = "";
		}
		FirstTimeToday = lo.FirstTimeToday;
		if (FirstTimeToday == undefined) FirstTimeToday = true;
				
		Normal.Load(lo.Normal);
		Dickgirl.Load(lo.Dickgirl);
		Lesbian.Load(lo.Lesbian);
		Naked.Load(lo.Naked);
		Catgirl.Load(lo.Catgirl);
		Pregnant.Load(lo.Pregnant);
		Puppygirl.Load(lo.Puppygirl);
	}
	
	// child/parent acts
	public function AddChildAct(act:ActInfo) : ActInfo
	{
		childAct = act;
		act.parentAct = this;
		act.childAct = null;
		return act;
	}
	
	public function GetParentActCount() : Number
	{
		var tot:Number = 0;
		var act:ActInfo = this;
		while (act.parentAct != null) {
			tot++;
			act = act.parentAct;
		}
		return tot;
	}
	public function GetShownParentActCount() : Number
	{
		var tot:Number = 0;
		var act:ActInfo = this;
		while (act.parentAct != null) {
			if (act.bShown) tot++;
			act = act.parentAct;
		}
		return tot;
	}
	public function GetChildActCount() : Number
	{
		var tot:Number = 0;
		var act:ActInfo = this;
		while (act.childAct != null) {
			tot++;
			act = act.childAct;
		}
		return tot;
	}
	
	// set the state of the act
	public function SetActDetails(tick:Boolean, available:Boolean, actlabel:String, hint:String, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number, ifunc, irofunc, iroutfunc, ifobj:Object)
	{
		if (tick != undefined) Ticked = tick;
		if (available != undefined) {
			Available = available;
			if (!Available) coreGame.Plannings.RemoveActionByType(Act);
		}
		if (actlabel != undefined) Name = actlabel;
		if (cost != undefined) Cost = cost;
		if (aduration != undefined) Duration = aduration;
		if (shortcut != undefined) Shortcut = shortcut;
		if (astart != undefined && astart >= 0) StartTime = astart;
		if (aend != undefined && aend >= 0) EndTime = aend;
		if (hint != undefined) Description = hint;
		if (ifobj == undefined) fobj = coreGame;
		else fobj = ifobj;
		if (ifunc != undefined) func = getFunctionName(ifunc, fobj);
		if (irofunc != undefined) rofunc = getFunctionName(irofunc, fobj);
		if (iroutfunc != undefined) routfunc = getFunctionName(iroutfunc, fobj);
	}
	
	// legacy version
	public function SetActState(tick:Boolean, avail:Boolean, actlabel:String, acost:Number, aduration:Number, shortcut:String, astart:Number, aend:Number, ifunc:Function, irofunc:Function, iroutfunc:Function, hint:String) { SetActDetails(tick, avail, actlabel, hint, shortcut, acost, aduration, astart, aend, ifunc, irofunc, iroutfunc, coreGame); }
	
	public function SetButtonFromAct(mc:MovieClip) { coreGame.SetButtonDetails(mc, Ticked, Available, Name, Act, Shortcut, Cost, Duration, StartTime, EndTime, func, rofunc, routfunc, fobj); }
	
	static public function getFunctionName(func, o:Object) : String
	{
		if (typeof(func) == "string") return func;
		for(var name:String in o) {
			if (typeof(o[name]) == "function" && o[name] == func) return name;
		}
		return "";
	}
	
	public function ShowAct(showact:Boolean)
	{
		if (showact == undefined) showact = true;
		if (!showact) HideAct();
		else bShown = showact;
	}
	
	public function HideAct()
	{
		bShown = false;
		
		coreGame.Plannings.RemoveActionByType(Act);
	}
	
	public function IsShown() : Boolean { return bShown; }
	
	public function ClearImage(mc:MovieClip) : Boolean
	{
		if (Normal.ClearImage(mc)) return true;
		if (Dickgirl != null) if (Dickgirl.ClearImage(mc)) return true;
		if (Lesbian != null) if (Lesbian.ClearImage(mc)) return true;
		if (Naked != null) if (Naked.ClearImage(mc)) return true;
		if (Catgirl != null) if (Catgirl.ClearImage(mc)) return true;
		if (Pregnant != null) if (Pregnant.ClearImage(mc)) return true;
		if (Puppygirl != null) if (Puppygirl.ClearImage(mc)) return true;
		return false;
	}
	
	public function ClearAllImages()
	{
		Normal.ClearAllImages();
		Dickgirl.ClearAllImages();
		Lesbian.ClearAllImages();
		Naked.ClearAllImages();
		Catgirl.ClearAllImages();
		Pregnant.ClearAllImages();
		Puppygirl.ClearAllImages();
	}

	public function IsAbleToDoAct(gnd:Number) : Boolean
	{
		// AllowedPartnerGender
		// allowed partner genders "male", "female", "dickgirl", "any", "same", "opposite", "fuck"
		if (AllowedPartnerGender == "any") return true;

		var tgnd:String = AllowedPartnerGender.toLowerCase();
		var anot:Array = tgnd.split(" ");
		var bNot:Boolean = false;
		if (anot.length > 1) {
			bNot = anot[0] == "not";
			tgnd = anot[1];
		}
		
		if (tgnd == "maculine") {
			if (gnd == 2 || gnd == 5 || gnd == 7) return bNot;   // male/dickgirl only
			return !bNot;
		}

		if (tgnd == "male") {
			if (gnd == 1 || gnd == 4 || gnd == 7) return !bNot;   // male only
			return bNot;
		}
		if (tgnd == "female" || tgnd == "feminine") {
			if (gnd == 2 || gnd == 5 || gnd == 7) return !bNot;   // female only
			if (tgnd == "feminine") return !bNot;
			if (coreGame.DickgirlLesbians && (gnd == 3 || gnd == 6)) return !bNot;   // female only			
			return bNot;
		}
		if (tgnd == "dickgirl" || tgnd == "hermaphrodite") {
			if (gnd == 3 || gnd == 6) return !bNot;;   // dickgirl only
			return bNot;
		}
		if (tgnd == "fuck") {
			if (slaveData.SlaveGender == 1 || slaveData.SlaveGender == 4) {
				if (gnd == 1) return bNot;
			}
			return !bNot;
		}	
		if (tgnd == "twins") {
			if (gnd > 3) return !bNot;   // twins only
			return bNot;
		}
		// "same" or "opposite"
		if (tgnd == "opposite") bNot = !bNot;
		if (gnd == 7) return !bNot;
		if (gnd > 3) gnd -= 3;
		var sgnd:Number = slaveData.SlaveGender;
		if (sgnd > 3) sgnd -= 3;
		if (gnd == sgnd) return !bNot;
		if (Act == 11 && sgnd != 1) {
			if (coreGame.DickgirlLesbians && ((gnd == 2 && sgnd == 3) || (gnd == 3 && sgnd == 2))) return !bNot;
		} else if (Act == 11) {
			if (coreGame.DickgirlLesbians && ((gnd == 1 && sgnd == 3) || (gnd == 3 && sgnd == 1))) return !bNot;
		}
		return bNot;
	}
	
	public function GetActDuration(actno:Number) : Number
	{
		if (actno == undefined) actno = Act;
		
		if (isNaN(actno) == false && Math.floor(Math.abs(actno)) == 1017) return Math.round((Math.abs(actno) - 1017) * 100) + 1;
		return Duration;
	}
	
	public function GetCounts(str:String) : ActCounts
	{
		var sl:Array = str.toLowerCase().split("-");
		if (sl[0] == "normal" || sl[0] == "") return Normal;
		if (sl[0] == "dickgirl") return Dickgirl;
		if (sl[0] == "lesbian" || sl[0] == "gay") return Lesbian;
		if (sl[0] == "catgirl") return Catgirl;
		if (sl[0] == "pregnant") return Pregnant;
		if (sl[0] == "puppygirl") return Puppygirl;
		if (sl[0] == "naked") return Naked;
		return null;
	}
	
	public function DoAct()
	{
		coreGame.XMLData.DoXMLAct(strNodeName, xNode);
		FirstTimeToday = false;
	}
	
	// Participants 
	
	public function IsShowParticipants() : Boolean
	{
		if (Act != 0 && Act != 99 && (Type == 5 || Type == 6)) return (MinParticipants != 0);
		if (Type == 5 || Type == 6) return false;
		if (MinParticipants == 0) return false;
		return (Participants != null && Participants.length > 0);
	}
	
	public function AddActParticipant(person:Object)
	{
		var pn:Number = coreGame.People.DecodePersonDetails(person);
		for (var pi:String in Participants) {
			if (int(Number(Participants[pi])) == pn) return;
		}
	
		var totp:Number = coreGame.CountParticipants(Participants);
		if (MaxParticipants != 0 && totp >= MaxParticipants) Participants.splice(-1, 1);
		
		Participants.push(pn);
		Participants.sort(Array.NUMERIC);
	}
	
	public function RemoveActParticipant(person:Object)
	{
		var pn:Number = coreGame.People.DecodePersonDetails(person);
		var i:Number = 0;
		var idx:Number = -1;
		for (var pi:String in Participants) {
			if (int(Number(Participants[pi])) == pn) {
				idx = i;
				break;
			}
			i++;
		}
		if (idx != -1) Participants.splice(idx, 1);
	}	

}