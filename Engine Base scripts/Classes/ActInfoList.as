// A list of acts, images and act states
// Translation status: COMPLETE

import Scripts.Classes.*;

class ActInfoList {
	
	// Variables
	public var ActArray:Array;
	public var ActFolder:String;
	
	private var alternateNames:Boolean;
	public var slaveData:Object;		// parent class instance, the Slave class instance or _root
	private var coreGame:Object;		// core game
	
	private var bLoaded:Boolean;
	private var nTotalLoaded:Number;
	
	// constructor
	public function ActInfoList(sd:Object, folder:String, cgm:Object) { 
		ActFolder = folder == undefined ? "" : folder;
		alternateNames = false;
		coreGame = cgm == undefined ? _root : cgm;
		ResetList(sd);
	}
	
	// sort of destructor
	public function ResetList(sd:Object) {
		if (sd != undefined) slaveData = sd;
		delete ActArray;
		ActArray = new Array();
		bLoaded = false;
		nTotalLoaded = 0;
	}
	public function SetSlave(sdo:Object) { this.slaveData = sdo; }   // DO NOT OVERRIDE
	
	public function IsLoaded(bPart:Boolean) : Boolean { return bLoaded; }
	public function GetTotalLoaded() : Number { return nTotalLoaded; }

	
	// rest on start of a new day, days parameter is currently unused
	public function NewDay(days:Number)
	{
		// search array for an existing act
		var act:ActInfo;
		for (var ai:String in ActArray) {
			act = ActArray[ai];
			act.FirstTimeToday = true;
		}
	}

	
	public function IsAlternateNames() : Boolean { return alternateNames; }
	
	public function GetActRO(act:Object) : ActInfo
	{
		var str:String = String(act).toLowerCase().split(" ").join("");
		var actn:Number = int(Number(act));		// Math.abs()?
		
		// search array for an existing act
		var acti:ActInfo;
		for (var ai:String in ActArray) {
			acti = ActArray[ai];
			if (isNaN(act)) {
				if (acti.strNodeNameLNSP == str) return acti;
			} else if (acti.Act == actn) return acti;
		}
		if (str.substr(0, 6) == "custom") return GetActRO("slave" + str.substr(6));

		return null;
	}
	public function GetActNo(acto:Object) : Number
	{
		var act:ActInfo = GetActRO(acto);
		if (act == null) return 0;
		return act.Act;
	}
	
	// find a given act entry
	public function GetAct(act:Number) : ActInfo
	{
		// search array for an existing act
		var acti:ActInfo;
		for (var ai:String in ActArray) {
			acti = ActArray[ai];
			if (acti.Act == act) return acti;
		}

		if (act == undefined) return null;
		return AddAct(act);
	}
		
	private function AddAct(act:Number) : ActInfo
	{
		var acti:ActInfo = new ActInfo(slaveData, coreGame);
		acti.SetActIDType(act);
		acti.strNodeName = GetActNameBase(act);
		acti.strNodeNameLNSP = acti.strNodeName.toLowerCase().split(" ").join("");
		
		ActArray.push(acti);
		return acti;
	}
	
	// find a given act entry by the name of the act
	// note code must be similar to GetAct()
	public function GetActByName(str:String) : ActInfo
	{
		str = str.split(" ").join("").toLowerCase();
		
		// search array for an existing act
		var acti:ActInfo;
		for (var ai:String in ActArray) {
			acti = ActArray[ai];
			if (acti.strNodeNameLNSP == str) return acti;
		}
		if (str.substr(0, 6) == "custom") return GetActByName("slave" + str.substr(6));

		return null;
	}
	
	// find a given act entry
	public function IsActDefined(act:Object) : Boolean
	{
		if (typeof(act) == "string") return IsActDefinedByName(String(act));
		var actn:Number = Number(act);
		
		// search array for an existing act
		for (var ai:String in ActArray) {
			if (ActArray[ai].Act == actn) return true;
		}
		return false;
	}
	public function IsActDefinedByName(str:String) : Boolean
	{
		str = str.split(" ").join("").toLowerCase();
		// search array for an existing act
		for (var ai:String in ActArray) {
			if (ActArray[ai].strNodeNameLNSP.toLowerCase() == str) return true;
		}
		return false;
	}
	
	// is an act visible
	public function IsActVisible(act:Number) : Boolean
	{
		// search array for an existing act
		var acti:ActInfo;
		for (var ai:String in ActArray) {
			acti = ActArray[ai];
			if (acti.Act == act) return acti.bShown;
		}
		return false;
	}
	
	// is an act available
	public function IsActAvailable(act:Number) : Boolean
	{
		// search array for an existing act
		var acti:ActInfo;
		for (var ai:String in ActArray) {
			acti = ActArray[ai];
			if (acti.Act == act) return acti.Available;
		}
		return false;
	}
	
	// find a new act of the type needed
	public function GetFreeAct(type:Number) : Number
	{
		var min:Number;
		var max:Number;
		if (type == 5 || type == 6) {
			min = 501;
			max = 999;
		} else if (type == 1 || type == 2 || type == 3) {
			min = 1501;
			max = 1999;
		} else if (type == 4) {
			min = 2801;
			max = 2899;
		} else if (type == 8) {
			min = 2401;
			max = 2499;
		} else if (type == 7) {
			min = 2301;
			max = 2499;
		} else if (type == 10) {
			min = 2701;
			max = 2790;
		} else if (type == 12) {
			min = 2901;
			max = 2990;
		} else if (type == 13) {
			min = 3000;
			max = 4999;			
		} else {
			if (type == 9) min = 10001;
			else min = 100001;
			max = 999999;
		}
		var acti:ActInfo;
		for (var i:Number = min; i < max; i++) {
			if (!IsActDefined(i)) return i;
		}
		if (type != 9) return GetFreeAct(9);
		return 0;
	}
	
	
	public function GetActAbs(acto:Object) : ActInfo
	{
		if (typeof(acto) == "number") return GetAct(int(Math.abs(Number(acto))));
		return GetActByName(String(acto));
	}
	
	public function GetActCounts() : Number { return ActArray.length; }
	
	public function GetActByIndex(idx:Number) : ActInfo
	{
		return ActArray[idx];
	}

	
	public static function GetActNumber(type:String) : Number
	{
		var typel:String = type.toLowerCase();
		switch (typel) {
			case "needing":
			case "nothing": return 1;
			case "touch": return 2;
			case "lick": return 3;
			case "fuck": return 4;
			case "blowjob": return 5;
			case "masturbateyou":
			case "titsfuck": return 6;
			case "anal": return 7;
			case "masturbate": return 8;
			case "dildo": return 9;
			case "plug": return 10;
			case "lesbian": return 11;
			case "bondage": return 12;
			case "naked": return 13;
			case "master": return 14;
			case "gangbang": return 15;
			case "lend": return 16;
			case "ponygirl": return 17;
			case "spanking":
			case "spank": return 18;
			case "threesome": return 19;
			case "sixtynine":
			case "69": return 20;
			case "group":
			case "orgy": return 21;
			case "kissmale": return 23.1;
			case "kissfemale": return 23.2;
			case "striptease": return 24;
			case "cumbath": return 25;
			case "footjob": return 30;
			case "handjob": return 31;
			
			case "cooking": return 1001;
			case "cleaning": return 1002;
			case "exercise":
			case "fitness": return 1003;
			case "discuss": return 1004;
			case "makeup": return 1005;
			case "scienceschool":
			case "sciences": return 1006;
			case "theologyschool":
			case "theology": return 1007;
			case "refinementeschool":
			case "refinement": return 1008;
			case "danceschool":
			case "dance": return 1009;
			case "xxxschool":
			case "xxx": return 1010;
			case "expose": return 1011;
			case "restaurantjob":
			case "restaurant": return 1012;
			case "acolytejob":
			case "acolyte": return 1013;
			case "barjob":
			case "bar": return 1014;
			case "sleazybarjob":
			case "sleazybar": return 1015;
			case "brotheljob":
			case "brothel": return 1016;
			case "break": return 1017;
			case "read": 
			case "readabook": return 1019;
			case "libraryjob":
			case "library": return 1022;
			case "onsenjob":
			case "onsen": return 1023;
			case "takeawalk":
			case "walk": return 1030;
			case "cockmilk":
			case "cockmilking": return 1031;
			case "singingschool":
			case "singing": return 1032;
			case "swimmingschool": return 1033;
			case "swimming": return 1033;
			
			case "stables": return 2001;
			case "tailor": return 2002;
			case "shop": return 2003;
			case "salon": return 2004;
			case "visit": return 2005;
			
			case "martialtraining": return 2501;
			case "pray": return 2502;
			case "smbar":
			case "relaxbar":
			case "relaxatbar":
			case "smrelaxinabar":
			case "relaxinabar": return 2503; 
			case "attendcourt":
			case "court": return 2504; 
			case "slavemarket": return 2505; 
			case "armory":
			case "armoury": return 2506; 
			case "drugdealer":
			case "dealer": return 2507; 
			case "itemsalesman": return 2508; 
			case "smjobworkguild": return 2509;
			case "smrelaxsleazybar":
			case "smsleazybar": return 2510; 
			case "smnothing": return 2511; 
			case "smspecial": return 2515;
			case "talktoyourslaves":
			case "talkslaves": return 2517;
			case "smjobcockmilk": return 2518;
			case "smjobbrothel": return 2519;
			case "smjobtradegoods": return 2520;
			case "smjobdom": return 2521;
			case "smjobpotions": return 2522;
			case "smjobpreach": return 2523;
			case "smjobmilitia": return 2524;
			case "smjobsleazybar": return 2525;
			
			case "endingmarriage": return 3000;
			
			case "tentaclesex": return 10000;
			case "tired": return 10001;
			case "contestxxx": return 10002;
			case "contestbeauty": return 10003;
			case "contesthousework": return 10004;
			case "contestadvancedhousework": return 10005;
			case "contestcourt": return 10006;
			case "contestdance": return 10007;
			case "contestgeneralknowledge": return 10008;
			case "contestponygirl": return 10009;
			case "eventmilked": return 10010;
			case "dickgirl": return 10011;
			case "eventgigabe": return 10012;
			case "uniformlingerie": 
			case "itemlingerie": return 10013;
			case "uniformswimsuit": return 10014;
			case "itemswimsuit": return 10014;
			case "eventnakedapron": return 10015;
			case "eventraped": return 10016;
			case "uniformbunnysuit":
			case "itembunnysuit": return 10017;
			case "uniformmaid":
			case "itemmaiduniform": return 10018;
			case "eventfaerietransformation": return 10019;
			case "eventslaveretrieved": return 10020;
			case "dating": return 10021;
			case "pregnancyreveal": return 10022;
			case "pregnancybirth":
			case "tentaclebirth": return 10023;
			case "refused": return 10024;
			case "propositionaccepted":
			case "propostionaccepted": return 10025;
			case "propositionrefused":
			case "propostionrefused": return 10026;
			case "loveconfession": return 10027;
			case "loveconfessionaccepted": return 10028;
			case "loveconfessionrefused": return 10029;
			case "onsenservice": return 10030;
			case "sleazybarservice": return 10031;
			case "eventmorningmouthfull":
			case "eventmorningmouthful": return 10032;
			case "assistant": return 10033;
			case "dickgirltransform": return 10034;
			case "loveconfessionunsure": return 10035;
			case "uniformcustom1": return 10036;
			case "uniformcustom2": return 10037;
			case "slavereview": return 10038;
			
			case "appearance": return 20100;
			case "dressplain": return 20000;
			case "dresscourt": return 20001;
			case "dressdance": return 20002;
			case "dressbdsm": return 20003;
			case "dressmiko": return 20004;
			
		}
		return isNaN(type) ? 0 : Number(type);
	}
	
	public static function GetActNameBase(actno:Number) : String
	{
		switch (actno) {
			case 1: return "nothing";
			case 2: return "touch";
			case 3: return "lick";
			case 4: return "fuck";
			case 99:
			case 5: return "blowjob";
			case 6: return "titsfuck";
			case 7: return "anal";
			case 8: return "masturbate";
			case 9: return "dildo";
			case 10: return "plug";
			case 11: return "lesbian";
			case 12: return "bondage";
			case 13: return "naked";
			case 14: return "master";
			case 15: return "gangbang";
			case 16: return "lend";
			case 17: return "ponygirl";
			case 18: return "spanking";
			case 19: return "threesome";
			case 20: return "sixtynine";
			case 21: return "orgy";
			case 23.1: return "kissmale";
			case 23.3: return "kissfemale";
			case 23: return "kiss";
			case 24: return "striptease";
			case 25: return "cumbath";
			case 30: return "footjob";
			case 31: return "handjob";
			
			case 1001: return "cooking";
			case 1002: return "cleaning";
			case 1003: return "fitness";
			case 1004: return "discuss";
			case 1005: return "makeup";
			case 1006: return "sciences";
			case 1007: return "theology";
			case 1008: return "refinement";
			case 1009: return "dance";
			case 1010: return "xxx";
			case 1011: return "expose";
			case 1012: return "restaurant";
			case 1013: return "acolyte";
			case 1014: return "bar";
			case 1015: return "sleazybar";
			case 1016: return "brothel";
			case 1017: return "break";
			case 1019: return "read";
			case 1022: return "library";
			case 1023: return "onsen";
			case 1030: return "takeawalk";
			case 1031: return "cockmilking";
			case 1032: return "singing";
			case 1033: return "swimming";
			
			case 2001: return "stables";
			case 2002: return "tailor";
			case 2003: return "shop";
			case 2004: return "salon";
			case 2005: return "visit";
			
			case 2501: return "martialtraining";
			case 2502: return "pray";
			case 2503: return "relaxinabar";
			case 2504: return "attendcourt";
			case 2505: return "slavemarket";
			case 2506: return "armoury";
			case 2507: return "drugdealer";
			case 2508: return "itemsalesman";
			case 2509: return "smjobworkguild";
			case 2510: return "smsleazybar";
			case 2511: return "smnothing";
			case 2515: return "smspecial";
			case 2517: return "talktoyourslaves";
			case 2518: return "smjobcockmilk";
			case 2519: return "smjobbrothel";
			case 2520: return "smjobtradegoods";
			case 2521: return "smjobdom";
			case 2522: return "smjobpotions";
			case 2523: return "smjobpreach";
			case 2524: return "smjobmilitia";
			case 2525: return "smjobsleazybar";
			
			case 3000: return "endingmarriage";
			
		}
		return "";
	}
	
	public function GetActName(type:Object) : String
	{
		if (Math.abs(Number(type)) == 1012.2) return coreGame.Language.GetHtml("RestaurantChef", coreGame.Language.actNode);
		else if (int(Math.abs(Number(type))) == 1012) return coreGame.Language.GetHtml("RestaurantServing", coreGame.Language.actNode);
		return GetActRO(type).Name;
	}
	
	public function SetActDetails(type:Object, tick:Boolean, available:Boolean, actlabel:String, hint:String, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number, ifunc, irofunc, iroutfunc, fobj:Object) : ActInfo
	{
		var act:ActInfo = GetActAbs(type);
		act.SetActDetails(tick, available, actlabel, hint, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, fobj);
		return act;
	}	
	public function SetActState(type:Object, tick:Boolean, available:Boolean, actlabel:String, cost:Number, aduration:Number, shortcut:String, astart:Number, aend:Number, ifunc:Function, irofunc:Function, iroutfunc:Function, hint:String) : ActInfo { return SetActDetails(type, tick, available, actlabel, hint, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, coreGame); }
	
	public function ShowAct(type:Object, showact:Boolean) { GetActAbs(type).ShowAct(showact); }
	
	// Not used but in case it is needed
	//public function SetButtonFromAct(mc:MovieClip, type:Object) { GetActAbs(type).SetButtonFromAct(mc); }

	// load all acts from <Images> node or similar
	public function LoadActImages(sNode:XMLNode, imagesnode:String, subtype:String)
	{	
		if (imagesnode == undefined) imagesnode = "Images";		// default to Images
		bLoaded = true;
		
		var act:ActInfo;
		var bFnd:Boolean;
		var str:String;
		var strl:String;
		var actno:Number;
		var valarr:Array;
		var iNodeF:XMLNode;
		
		if (sNode != undefined) {
			str = coreGame.GetXMLString("Folder", sNode);
			if (str != "") ActFolder = str;
		}
	
		var imageNode:XMLNode = coreGame.XMLData.GetNode(sNode, imagesnode);
		if (imageNode == null) return;
		
		alternateNames = imageNode.attributes.alternatenames.toLowerCase() == "true";
		imageNode = imageNode.firstChild;
		
		while (imageNode != null) {
			if (imageNode.nodeType == 1) {
				
				// get the act number from the node name
				str = imageNode.nodeName;
				strl = str.toLowerCase();
				act = GetActByName(str);
				if (act == null) {
					actno = GetActNumber(str);
					if (actno == 0) {			
						if (strl.substr(0, 5) == "slave") act = GetActByName("custom" + str.substr(5));
						else if (strl.substr(0, 6) == "custom") act = GetActByName("slave" + str.substr(6));
						if (act == null) {
							actno = GetFreeAct();
							act = GetAct(actno);
							act.strNodeName = imageNode.nodeName;
							act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
						}
					} else {
						act = GetAct(actno);
						act.strNodeName = imageNode.nodeName;
						act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
					}
				}
				act.imageNode = imageNode;
				iNodeF = act.imageNode.firstChild;
				if (subtype != undefined) act.strSubType = subtype;
				
				bFnd = false;
				
				while(iNodeF != null) {
					if (iNodeF.nodeType == 1) {
						str = iNodeF.nodeName.toLowerCase();
						// populate subnodes Normal, Dickgirl etc
						if (str == "normal" || str == "count") { 
							bFnd = true;
							nTotalLoaded += act.Normal.PopulateCounts(iNodeF);
						} else if (str == "dickgirl" || str == "futanari") { 
							bFnd = true;
							nTotalLoaded += act.Dickgirl.PopulateCounts(iNodeF);
						} else if (str == "lesbian" || str == "gay") { 
							bFnd = true;
							nTotalLoaded += act.Lesbian.PopulateCounts(iNodeF);
						} else if (str == "naked") { 
							bFnd = true;
							nTotalLoaded += act.Naked.PopulateCounts(iNodeF);
						} else if (str == "catgirl" || str == "catboy") { 
							bFnd = true;
							nTotalLoaded += act.Catgirl.PopulateCounts(iNodeF);
						} else if (str == "pregnant") { 
							bFnd = true;
							nTotalLoaded += act.Pregnant.PopulateCounts(iNodeF);
						} else if (str == "puppygirl" || str == "puppyboy") { 
							bFnd = true;
							nTotalLoaded += act.Puppygirl.PopulateCounts(iNodeF);							
						}						
					}
					iNodeF = iNodeF.nextSibling;
				}
				if (!bFnd) {
					iNodeF = imageNode.firstChild;
					// no subnodes, check if there is a <Count> node
					str = coreGame.XMLData.GetXMLString("Count", iNodeF);
					if (str != "") {
						act.Normal.UpdateActCounts(Number(str));
						act.Normal.NormalNode = imageNode;
						nTotalLoaded += Number(str);
					} else {
						// just a list of comma delimited numbers in the order
						// Normal, Dickgir, Lesbian, Naked, Catgirl, pregnant
						// all are optional (meaningless though to have none), but to specify one you must specify the previous ones
						valarr = iNodeF.nodeValue.split(",");
						nTotalLoaded += act.Normal.UpdateActCounts(Number(valarr[0]));
						nTotalLoaded += act.Dickgirl.UpdateActCounts(Number(valarr[1]));
						nTotalLoaded += act.Lesbian.UpdateActCounts(Number(valarr[2]));
						nTotalLoaded += act.Naked.UpdateActCounts(Number(valarr[3]));
						nTotalLoaded += act.Catgirl.UpdateActCounts(Number(valarr[4]));
						nTotalLoaded += act.Pregnant.UpdateActCounts(Number(valarr[5]));
						nTotalLoaded += act.Puppygirl.UpdateActCounts(Number(valarr[6]));
						act.Normal.NormalNode = imageNode;
					}
				}
			}
			imageNode = imageNode.nextSibling;
		}
	}

	// get total normal images
	// not intended for use where there are subnodes
	public function GetNormalActCount(act:Number) : Number
	{
		return GetAct(act).Normal.Normal;
	}

	// get total naked images
	public function GetNakedActCount(act:Number) : Number
	{
		return GetAct(act).Naked.Normal;
	}
	
	// get total lesbian images
	public function GetLesbianActCount(act:Number) : Number
	{
		return GetAct(act).Lesbian.Normal;
	}
	
	// get total dickgirl images
	public function GetDickgirlActCount(act:Number) : Number
	{
		return GetAct(act).Dickgirl.Normal;
	}
	
	// get total catgirl images
	public function GetCatgirlActCount(act:Number) : Number
	{
		return GetAct(act).Catgirl.Normal;
	}
	
	// get total pregnant images
	public function GetPregnantActCount(act:Number) : Number
	{
		return GetAct(act).Pregnant.Normal;
	}

	// get total puppygirl images
	public function GetPuppygirlActCount(act:Number) : Number
	{
		return GetAct(act).Puppygirl.Normal;
	}
	
	private function GetBaseImageName(iact:Number, actobj:ActInfo) : String
	{
		var oact:Number = iact;
		var act:Number = int(oact);
		var iname:String = "";

		switch(act) {
			case 1: iname = "Nothing"; break;
			case 2: iname = "Touch"; break;
			case 3: iname = "Lick"; break;
			case 4: iname = "Fuck"; break;
			case 99:
			case 5: iname = "Blowjob"; break;
			case 6: iname = "Tits Fuck"; break;
			case 7: iname = "Anal"; break;
			case 8: iname = "Masturbate"; break;
			case 9: iname = "Dildo"; break;
			case 10: iname = "Plug"; break;
			case 11: iname = "Lesbian"; break;
			case 12: iname = "Bondage"; break;
			case 13: iname = "Naked"; break;
			case 14: iname = "Master"; break;
			case 15: iname = "Gang-Bang"; break;
			case 16: iname = "Lend"; break;
			case 17: iname = "Ponygirl"; break;
			case 18: iname = "Spanking"; break;
			case 19: iname = "Threesome"; break;
			case 20: iname = "69"; break;
			case 21: iname = "Orgy"; break;
			case 23: 
				if (coreGame.PersonGender == 1 || oact == 23.1) iname = "Kiss Male";
				else iname = "Kiss Female";
				break;
			case 24: iname = "Strip Tease"; break;
			case 25: iname = "Cum Bath"; break;
			case 30: iname = "Footjob"; break;
			case 31: iname = "Handjob"; break;
			case 1001: iname = "Chore - Cooking"; break;
			case 1002: iname = "Chore - Cleaning"; break;
			case 1003: iname = "Chore - Exercise"; break;
			case 1004: iname = "Chore - Discuss"; break;
			case 1005: iname = "Chore - Make Up"; break;
			case 1006: iname = "School - Sciences"; break;
			case 1007: iname = "School - Theology"; break;
			case 1008: iname = "School - Refinement"; break;
			case 1009: 
				if (oact == 1009) iname = "School - Dance";
				else iname = "School - Prancing";
				break;
			case 1010: iname = "School - XXX"; break;
			case 1011: iname = "Chore - Expose Themself"; break;
			case 1012: iname = "Job - Restaurant"; break;
			case 1013: iname = "Job - Acolyte"; break;
			case 1014: iname = "Job - Bar"; break;
			case 1015:
				if (oact == 1015) iname = "Job - Sleazy Bar";
				else iname = "Job - Sleazy Bar Strip-Tease";
				break;
			case 2519:
			case 1016: iname = "Job - Brothel"; break;
			case 1017: iname = "Break"; break;
			case 1019: iname = "Chore - Read"; break;
			case 1022: iname = "Job - Library"; break;
			case 1023: iname = "Job - Onsen"; break;
			case 2518:
			case 1031: iname = "Job - Cock Milking"; break;
			case 1032: iname = "School - Singing"; break;
			case 1033: iname = "School - Swimming"; break;
			
			case 2501: iname = "Training - Martial"; break;
			case 2502: iname = "Training - Pray At Church"; break;
			case 2503: iname = "Training - Relax - Bar"; break;
			case 2504: iname = "Attend Court"; break;
			case 2509: iname = "Job - Work For Guild"; break;
			case 2510: iname = "Training - Relax - Sleazy Bar"; break;
			case 2520: iname = "Job - Trade Goods"; break;
			case 2521: iname = "Job - Dominate"; break;
			case 2522: iname = "Job - Sell Potions"; break;
			case 2523: iname = "Job - Preach"; break;
			case 2524: iname = "Job - Militia"; break;
			case 2525: iname = "Job - Sleazy Bar"; break;
			
			case 3000: iname = "Ending - Marriage"; break;
			
			case 10000: iname = "Tentacle Sex"; break;
			case 10001: iname = "Tired"; break;
			case 10002: iname = "Contest - XXX"; break;
			case 10003: iname = "Contest - Beauty"; break;
			case 10004: iname = "Contest - Housework"; break;
			case 10005: iname = "Contest - Advanced Housework"; break;
			case 10006: iname = "Contest - Court"; break;
			case 10007: iname = "Contest - Dance"; break;
			case 10008: iname = "Contest - General Knowledge"; break;
			case 10009: iname = "Contest - Ponygirl"; break;
			case 10010: iname = "Event - Milk - Milked"; break;
			case 10011: iname = "Dickgirl"; break;
			case 10012: iname = "Event - Giga BE"; break;
			case 10013: iname = "Item - Lingerie"; break;
			case 10014: iname = "Item - Swimsuit"; break;
			case 10015: iname = "Event - Naked Apron"; break;
			case 10016: iname = "Event - Raped"; break;
			case 10017: iname = "Item - Bunny Suit"; break;
			case 10018: iname = "Item - Maid Uniform"; break;
			case 10019: iname = "Event - Faerie Transformation"; break;
			case 10020: iname = "Event - Slave Retrieved"; break;
			case 10021: iname = "Dating"; break;
			case 10022: iname = "Event - Pregnancy Reveal"; break;
			case 10023: iname = "Event - Tentacle Birth"; break;
			case 10024: iname = "Refused"; break;
			case 10025: iname = "Propositions a guy and they have sex"; break;
			case 10026: iname = "Propositions a guy and is refused"; break;
			case 10027: iname = "Love Confession"; break;
			case 10028: iname = "Love Confession Accepted"; break;
			case 10029: iname = "Love Confession Refused"; break;
			case 10030: iname = "Job - Onsen Service"; break;
			case 10031: iname = "Job - Sleazy Bar Service"; break;
			case 10032: iname = "Event - Morning Mouthfull"; break;
			case 10033: iname = "Assistant"; break;
			case 10034: iname = "Dickgirl Transformation"; break;
			case 10035: iname = "Love Confession Unsure"; break;
			case 10036: iname = "Uniform - Custom1"; break;
			case 10037: iname = "Uniform - Custom2"; break;
			case 10038: iname = "Review"; break;
			
			case 20100: iname = "Appearance"; break;
			case 20000: iname = "Dress Plain"; break;
			case 20001: iname = "Dress Court"; break;
			case 20002: iname = "Dress Dance"; break;
			case 20003: iname = "Dress BDSM"; break;
			case 20004: iname = "Dress Miko"; break;

		}
		if (act < 1000) {
			if (act > 499) {
				var ipref:String = "";
				if (actobj.strNodeNameLNSP.substr(0, 5) == "slave") ipref = actobj.strNodeName.substr(5);
				else if (actobj.strNodeNameLNSP.substr(0, 6) == "custom") ipref = actobj.strNodeName.substr(6);
				if (ipref != "") iname = "Custom" + ipref.substr(3);
				else iname = actobj.strNodeName;
			}
			iname = "Sex Act - " + iname;
		} else {
			if (iname == "") {
				var ipref:String = "";
				if (actobj.strNodeNameLNSP.substr(0, 5) == "slave") ipref = actobj.strNodeName.substr(5);
				else if (actobj.strNodeNameLNSP.substr(0, 6) == "custom") ipref = actobj.strNodeName.substr(6);
				if (ipref != "" && actobj.Type != 99) {
					switch(actobj.Type) {
						case 1: iname = "Chore - Custom" + ipref.substr(5); break;
						case 2: iname = "Job - Custom" + ipref.substr(3); break;
						case 3: iname = "School - Custom" + ipref.substr(6); break;
						case 4: iname = "SlaveMaker - Custom" + ipref.substr(10); break;
						case 8: iname = "Shop - Custom" + ipref.substr(4); break;
						case 9: iname = "Event - Custom" + ipref.substr(5); break;
						case 10: iname = "TalkToSlave - Custom" + ipref.substr(9); break;
						case 11: iname = "Contest - Custom" + ipref.substr(7); break;
					}
				} else iname = actobj.strNodeName;
			}
		}
		return iname;
	}
	
	// Show the image for an act, randomly pick an image, or pick a specific Normal image
	public function ShowActImage(iacto:Object, place:Number, align:Number, frame:Number, delay:Number) : Number
	{
		//trace("Slave.ShowActImage: " + iacto);
		var actobj:ActInfo = null;
		var iact:Number;
		if (iacto == undefined) iact = coreGame.LastActionDone;
		else if (!isNaN(iacto)) {
			iact = Number(iacto);
		} else {
			actobj = GetActByName(String(iacto));
			if (actobj != null) iact = actobj.Act;
		}
		//trace("iact = " + iact);
		if (iact == undefined) return 0;
		
		var oact:Number = iact;
		var act:Number = int(oact);
		if (act == 23) {
			if (coreGame.PersonGender == 1) act = 23.1;
			else act = 23.2;
		}
		if (act == 1009 && oact != 1009) act = 1009.1;
		if (act == 1015 && oact != 1015) act = 1015.1;

		if (place == undefined) {
			if (slaveData != null) place = slaveData.GetWidescreenMode() == 0 ? 1 : 1.1;
			else place = 1;
		}
		if (align == undefined) align = 9;
		
		if (actobj == null) actobj = GetAct(act);
		var iname:String = GetBaseImageName(act, actobj);
		trace("iname = " + iname + " " + frame);

		if (iname == "") return 0;
		
		iname += actobj.strSubType;
				
		var actarr:Array;
		var actImageNode:XMLNode;
		
		if (frame != undefined && frame != 0) {
			
			// a selected image frame (Normal only supported)
			iname += " " + frame;
			actarr = actobj.Normal.NormalArray;
			actImageNode = actobj.Normal.NormalNode;
			
		} else {
			// Pick a random frame
			frame = 0;
			
			// Try genersl <Show> node for the act
			if (actobj.imageNode != null) {
				frame = HandleActShow(actobj.imageNode);
				if (frame != 0) return frame;
			}
					
			if (slaveData != null) {
				if (slaveData.PregnancyGestation > 0) {
					//trace("preg");
					if (actobj.Pregnant.GetImage(act, 5)) {
						frame = actobj.Pregnant.imgIndex;
						if (frame > 0) {
							actarr = actobj.Pregnant.actarr;
							actImageNode = actobj.Pregnant.actNode;
							if (alternateNames) iname += " " +  actobj.Pregnant.imgName + "Pregnant " + frame;
							else iname += " (" +  actobj.Pregnant.imgName + "Pregnant " + frame + ")";
						}
					}
				}				
				if (slaveData.IsCatgirl()) {
					//trace("cat");
					if (actobj.Catgirl.GetImage(act, 4)) {
						frame = actobj.Catgirl.imgIndex;
						if (frame > 0) {
							actarr = actobj.Catgirl.actarr;
							actImageNode = actobj.Catgirl.actNode;
							if (alternateNames) iname += " " +  actobj.Catgirl.imgName + "Catgirl " + frame;
							else iname += " (As " +  actobj.Catgirl.imgName + "Catgirl " + frame + ")";
						}
					}
				}
				if (slaveData.IsPuppygirl()) {
					//trace("puppy");
					if (actobj.Puppygirl.GetImage(act, 6)) {
						frame = actobj.Puppygirl.imgIndex;
						if (frame > 0) {
							actarr = actobj.Puppygirl.actarr;
							actImageNode = actobj.Puppygirl.actNode;
							if (alternateNames) iname += " " +  actobj.Puppygirl.imgName + "Puppygirl " + frame;
							else iname += " (As " +  actobj.Puppygirl.imgName + "Puppygirl " + frame + ")";
						}
					}
				}				
				if (slaveData.IsDickgirl() && frame == 0) {
					//trace("dg");
					if (actobj.Dickgirl.GetImage(act, 1)) {
						frame = actobj.Dickgirl.imgIndex;
						if (frame > 0) {
							actarr = actobj.Dickgirl.actarr;
							actImageNode = actobj.Dickgirl.actNode;
							if (alternateNames) iname += " " +  actobj.Dickgirl.imgName + "Dickgirl " + frame;
							else iname += " (As " +  actobj.Dickgirl.imgName + "Dickgirl " + frame + ")";
						}
					}
					// if the slave is masturbating/being licked and no dickgirl images are provided, use a generic image
					if (frame == 0 && (act == 3 || act == 8) && (slaveData.SlaveGender == 2 || slaveData.SlaveGender == 5)) return 0;
				}
				if (((act == 11 && slaveData.CheckBitFlag(10)) || (act != 11 && coreGame.Lesbian)) && frame == 0) {
					//trace("les");
					if (actobj.Lesbian.GetImage(act, 2)) {
						frame = actobj.Lesbian.imgIndex;
						if (frame > 0) {
							actarr = actobj.Lesbian.actarr;
							actImageNode = actobj.Lesbian.actNode;
							/*
							if (slaveData.IsMale()) {
								if (alternateNames) iname += " " +  actobj.Lesbian.imgName + "Gay " + frame;
								else iname += " (" +  actobj.Lesbian.imgName + "Gay " + frame + ")";
							} else {
							*/
								if (alternateNames) iname += " " +  actobj.Lesbian.imgName + "Lesbian " + frame;
								else iname += " (" +  actobj.Lesbian.imgName + "Lesbian " + frame + ")";
							//}
						}
					}
				}
				if (slaveData.DressWorn < 0 && frame == 0) {
					//trace("naked");
					if (actobj.Naked.GetImage(act, 3)) {
						frame = actobj.Naked.imgIndex;
						if (frame > 0) {
							actarr = actobj.Naked.actarr;
							actImageNode = actobj.Naked.actNode;
							if (alternateNames) iname += " " +  actobj.Naked.imgName + "Naked " + frame;
							else iname += " (" +  actobj.Naked.imgName + "Naked " + frame + ")";
						}
					}
				}
			}
			
			if (frame <= 0) {
				var totnm:Number = actobj.Normal.GetTotalImages(act);
				var totnk:Number = actobj.Naked.GetTotalImagesUsable(act);
				var totls:Number = actobj.Lesbian.GetTotalImagesUsable(act);
				var tot:Number = totnm;
				if (totnm == 0) tot = totnk;
				else if (act < 1000) {
					tot += totnk;
					if (act == 11 || coreGame.Lesbian) tot += totls;
				}
				if (tot > 0) {
					var idx:Number = int(Math.random()*tot) + 1;
					if (idx <= totnm || frame < 0) {
						if (frame < 0) {
							frame = frame * -1;
							actarr = actobj.Normal.NormalArray;
							actImageNode = actobj.Normal.NormalNode;
							iname += " " + frame;
						} else if (actobj.Normal.GetImage(act, 0)) {
							frame = actobj.Normal.imgIndex;
							actarr = actobj.Normal.actarr;
							actImageNode = actobj.Normal.actNode;
							iname += " " + frame;
						}
					} else if (idx <= (totnm + totnk)) {
						if (actobj.Naked.GetImage(act, 3)) {
							frame = actobj.Naked.imgIndex;
							actarr = actobj.Naked.actarr;
							actImageNode = actobj.Naked.actNode;
							if (alternateNames) iname += " " +  actobj.Naked.imgName + "Naked " + frame;
							else iname += " (" +  actobj.Naked.imgName + "Naked " + frame + ")";
						}
					} else {
						if (actobj.Lesbian.GetImage(act, 2)) {
							frame = actobj.Lesbian.imgIndex;
							actarr = actobj.Lesbian.actarr;
							actImageNode = actobj.Lesbian.actNode;
							if (alternateNames) iname += " " +  actobj.Lesbian.imgName + "Lesbian " + frame;
							else iname += " (" +  actobj.Lesbian.imgName + "Lesbian " + frame + ")";
						}
					}
				}
			}
		}

		
		// is it a valid image?
		trace("frame = " + frame);
		if (iname == "" || frame == 0 || actarr == null) {
			// Try <Show> node for 
			if (actImageNode == undefined) actImageNode = actobj.Normal.NormalNode;
			if (actImageNode == null) {
				//trace("no node 1: " + slaveData.sNode.parentNode.nodeName + " " + slaveData.sNode.parentNode.parentNode.nodeName);
				if (slaveData.sNode.parentNode.parentNode.nodeName == "Slaves") {
					// a minor slave try default version for minor slaves
					actImageNode = coreGame.XMLData.GetNode(coreGame.XMLData.defimgNode, actobj.strNodeName);
					//trace("no node: default " + actImageNode);
				} else {
					trace("no image(1): " + frame);
					return 0;
				}
			}
			frame = HandleActShow(actImageNode);
			trace("no image(2): " + frame);
			if (frame == 0) coreGame.UseGeneric = true;
			return frame;   // no, use a generic image
		}
		
		// Try <Show> for the particular act variant (ie <Normal><Show>)
		var sf:Number = HandleActShow(actImageNode);
		if (sf != 0) return sf;
		
		// have a valid image, show it
		
		// add any folder bits
		var fldr:String = actImageNode.attributes.folder;
		if (fldr == undefined) fldr = actImageNode.parentNode.attributes.folder;
		if (fldr != undefined) iname = fldr + "/" + iname;
		if (ActFolder != "") iname = ActFolder + "/" + iname;
		
		var fNode:XMLNode = coreGame.XMLData.GetNode(actImageNode.firstChild, "Image" + frame);
		if (fNode == null) fNode = actImageNode;		
		if (fNode != null) {
			var bgframe:Number = undefined;
			for (var attr:String in fNode.attributes) {
				var strl:String = attr.toLowerCase();
				if (strl == "bgframe") bgframe = Number(fNode.attributes[attr]);
				else if (strl == "bg") coreGame.Backgrounds.ShowBackground(fNode.attributes[attr], bgframe);
				else if (strl == "colour" || strl == "color") coreGame.Backgrounds.ShowOverlay(Number(fNode.attributes[attr]));
				else if (strl == "align") align = coreGame.DecodeAlign(fNode.attributes[attr]);
			}
		}
		
		frame--;
		trace("iname = " + iname);
		actarr[frame] = coreGame.LoadPermanentlyImageAndShowMovie(actarr[frame], iname + ".jpg", place, align, undefined, delay);
		return frame + 1;
	}
	
	private function HandleActShow(aNode:XMLNode) : Number
	{
		var sNode:XMLNode = coreGame.XMLData.GetNode(aNode.firstChild, "Show");
		if (sNode == null) {
			sNode = coreGame.XMLData.GetNode(aNode.firstChild, "PickActImage");
			if (sNode == null) sNode = coreGame.XMLData.GetNode(aNode.firstChild, "ShowImage");
			if (sNode == null) sNode = coreGame.XMLData.GetNode(aNode.firstChild, "ShowSlave");
			if (sNode == null) sNode = coreGame.XMLData.GetNode(aNode.firstChild, "PerformAct");
			if (sNode != null) sNode = aNode;
		}
		if (sNode != null && coreGame.XMLData.XMLEventByNode(sNode, false, undefined, true)) return 1;
		return 0;
	}
	
	public function SetActDefaultCount(acto:Object, cnt:Number)
	{
		if (!IsActDefined(acto)) {
			var act:ActInfo = GetActAbs(acto);
			act.Normal.UpdateActCounts(cnt == undefined ? 1 : cnt);
		}
	}
	
	function ClearImage(mc:MovieClip)
	{
		var act:ActInfo;
		for (var ai:String in ActArray) {
			act = ActArray[ai];
			if (act.ClearImage(mc)) return;
		}

	}
		
	// save the act list details
	public function Save(so:Object)
	{
		so.ActFolder = ActFolder;
		so.alternateNames = alternateNames;
		delete so.ActArray;
		so.ActArray = new Array();
		var len:Number = ActArray.length;
		for (var i:Number = 0; i < len; i++) { 
			var act:ActInfo = ActArray[i];
			var actsave:Object = new Object();
			act.Save(actsave);
			so.ActArray.push(actsave);
		}
	}
	
	// load the act list details
	public function Load(lo:Object)
	{
		if (lo == undefined) return;
		
		ActFolder = lo.ActFolder;
		alternateNames = lo.alternateNames;
		var len:Number = lo.ActArray.length;
		if (lo.ActArray == undefined || len == undefined) return;
		for (var i:Number = 0; i < len; i++) { 
			if (lo.ActArray[i].Act >= 0) {
				var actno:Number = lo.ActArray[i].Act;
				var bNew:Boolean = false;
				var act:ActInfo;
				if (lo.ActArray[i].strNodeName != "")  {
					act = GetActByName(lo.ActArray[i].strNodeName);
					if (act == null) {
						act = AddAct(actno);
						bNew = true;
					} else actno = act.Act;
				} else {
					act = GetActRO(actno);
					if (act == null) {
						act = AddAct(actno);
						bNew = true;
					} else actno = act.Act;
				}
				act.Load(lo.ActArray[i]);
				if (!bNew) act.Act = actno;
				trace("load act: " + act.Act + " " + act.strNodeName);
			}
		}
	}
	
	// debugging
	
	public function ShowFlags() : String
	{
		var say:String = "\r\r<b>Acts</b>\r(total images: " + GetTotalLoaded() + ")\r";
		var act:ActInfo;	
		var len:Number = GetActCounts();
		for (var i:Number = 0; i < len; i++) {
			act = GetActByIndex(i);
			say += "<b>Act " + act.Act + "</b>: " + act.strNodeName + "\r  Type: " + act.Type + "\tShown: " + act.bShown + "/" + act.Available + "\r  Duration: " + act.Duration + "\r  Counts: " + GetNormalActCount(act.Act) + "," + GetDickgirlActCount(act.Act)+ "," + GetCatgirlActCount(act.Act) + "\r";
		}
		return say;
	}

}