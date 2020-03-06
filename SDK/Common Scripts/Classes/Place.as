// Place - class defining a walk location and your home

// BitFlags 64+ do not reset between slaves
//
// member
//	public var Assistant:MovieClip;	// a common MovieClip for the small assistant image
// is used as the loaded version of the zoomed image of the location

// Translation status: COMPLETE

import Scripts.Classes.*;

class Place extends SlaveModule 
{
	public var Id:Number;				// person/place number
	
	private var Accessible:Boolean;		// can the place be visited
	private var Visited:Boolean;		// has the place ever been successfully visited
	private var InitialVisit:Boolean;	// first visit, can be turned away
	
	public var TotalVisit:Number;		// total times visited
	public var LastVisit:Number;		// last date visited
	public var LastVisitTime:Number;	// time last visited
	public var CustomFlag:Number;		// generic flag, resets each slave
	public var CustomFlag2:Number;		// generic flag, resets each slave
	
	public var SMFlag:Number;			// generic flag, persists across slaves
	public var SMFlag2:Number;			// generic flag, persists across slaves

	private var arEventIndex:Array;		// index for each event
	public var EventDefault:String;		// default event for the place
	private var elen:Number;

	public var strNodeName:String;		// XML Node Name used for this place
	
	public var xpos:Number;				// x,y position of area on city map
	public var ypos:Number;

	public var xNodeAlt:XMLNode			// internal use only, xml node for location/person
	public var pNode:XMLNode			// internal use only, xml node Place/Person in <Places>/<People>
	
	private var parentCity:Object;
	public var strArea:String;
	
	private var excludeLocations:Array;

	// to simplify event conversions (to omit coreGame/_root)
	public var Supervise:Boolean;
	

	// Constructor
	public function Place(nn:String, mc:MovieClip, cg:Object, id:Number, access:Boolean, swf:String, mxpos:Number, mypos:Number, cc:Object) {
		super(mc, null, cg);
		
		strNodeName = nn;
		Id = id;
		xpos = mxpos;
		ypos = mypos;
		ModuleName = swf == undefined ? "" : swf;
		Reset(access, false);
		//trace("Place(): " + strNodeName + " " + ModuleName + " " + loading + " " + Id + " " + cc);
		
		// note: cc is undefined for Person class instances (derived from Place)
		parentCity = cc == undefined ? null : cc;
		if (cc != null) {
			// This is a place instance
			cc.arPlaces.push(this);
			ResetNode();
			
			// get xpos/ypos for zoom from zml if not otherwise set
			if (xpos == 0 && ypos == 0) {
				var bNode:XMLNode = Language.XMLData.GetNode(xNode, "CloseUpImage");
				if (bNode != null) {
					var val:Number = Number(bNode.attributes.xpos);
					if (!isNaN(val)) xpos = val;
					val = Number(bNode.attributes.ypos);
					if (!isNaN(val)) ypos = val;
				}
			}
		}
	}
	
	public function Reset(access:Boolean, noei:Boolean)
	{	
		Accessible = (access == undefined ? true : access);
		Visited = false;
		InitialVisit = true;
		CustomFlag = 0;
		CustomFlag2 = 0;
		LastVisit = 0;
		LastVisitTime = 0;
		SMFlag = 0;
		SMFlag2 = 0;
		if (noei != true) {
			delete arEventIndex;
			arEventIndex = new Array();
			elen = 0;
		}
		TotalVisit = 0;
		xNodeAlt = null;
		excludeLocations = null;
		strArea = "";
		EventDefault = "";
		ResetBitFlags();
		ResetNode();
	}
	
	public function ResetNode()
	{	
		// note: these are the child nodes for the location
		if (parentCity == null) return;
		xNode = Language.XMLData.GetNodeC(Language.walkNode, strNodeName);
		
		pNode = parentCity.FindPlaceNodeCByName(strNodeName);
		xNodeAlt = Language.XMLData.GetNodeC(pNode, "Walk");
	}
	
	// Load/Save
	
	public function Load(lo:Object)
	{
		Reset(undefined, true);
		
		trace("Place.Load " + strNodeName);
		super.LoadGame(lo);
		
		if (lo.vAccessible == undefined) return;
		if (lo.Id != undefined) Id = lo.Id;
		Accessible = lo.vAccessible;
		Visited = lo.vVisited;
		InitialVisit = lo.vInitialVisit;
		CustomFlag = lo.vCustomFlag;
		CustomFlag2 = lo.vCustomFlag2;
		LastVisit = lo.LastVisit;
		LastVisitTime = lo.LastVisitTime;
		SMFlag = lo.vSMFlag;
		SMFlag2 = lo.vSMFlag2;
		TotalVisit = lo.vTotalVisit;
		if (lo.strArea == undefined) strArea = "";
		else strArea = lo.strArea + "";
		
		var str:String;
		var len:Number = lo.EventIndex.length;
		
		if (lo.EventTotals != undefined) {
			// LEGACY/UPGRADE
			trace("...legacy");
			for (var i:Number = 0; i < len; i++) {
				str = lo.EventIndex[i];
				// skip illegal events
				if (str == "Event[object Object]-[object Object]" || str == "BEForest" || str == ""|| str == "Event4002-4002" || str == "Event0-0" || str == "ApplyDifficulty") continue;
				SetEventTotal(str, lo.EventTotals[i]);
			}
			return;
		} 
		
		var pe:PlaceEvent;
		var obj:Object;
		for (var i:Number = 0; i < len; i++) {
			obj = lo.EventIndex[i];
			str = obj.strName;
			// skip illegal events
			if (str == "BEForest" || str == "" || str == "Event4002-4002" || str == "Event0-0" || str == "ApplyDifficulty") continue;
			pe = GetEventDetails(str);		// prevent duplicates
			pe.Load(obj);
			trace("..load event = " + str + " " + pe.GetEventTotal() + " " + pe.IsEventRepeatable());
		}
	}
	
	public function Save(so:Object)
	{
		super.SaveGame(so);
		
		so.Id = Id;
		so.strNodeName = strNodeName + "";
		so.vAccessible = Accessible;
		so.vVisited = Visited;
		so.vInitialVisit = InitialVisit;
		so.vCustomFlag = CustomFlag;
		so.vCustomFlag2 = CustomFlag2;
		so.LastVisit = LastVisit;
		so.LastVisitTime = LastVisitTime;
		so.vSMFlag = SMFlag;
		so.vSMFlag2 = SMFlag2;
		so.vTotalVisit = TotalVisit;
		so.strArea = strArea + "";
		
		so.EventIndex = new Array();
		var pe:PlaceEvent;
		var str:String;
		for (var i:Number = 0; i < elen; i++) {
			pe = arEventIndex[i]; 
			str = pe.strName;
			// skip illegal events
			if (str == "BEForest" || str == "" || str == "Event4002-4002" || str == "Event0-0" || str == "ApplyDifficulty") continue;
			var obj:Object = new Object();
			pe.Save(obj);
			so.EventIndex.push(obj);
		}
		
	}
	
	// disable for places
	public function LoadGame(loaddata:Object) { }
	public function SaveGame(savedata:Object) { }
	
	// Special Events
	// custom events, specific to a place implementation
	
	public function IsStartedSpecialEvent(num:Number) : Boolean { return false; }
	public function IsCompleteSpecialEvent(num:Number) : Boolean { return true; }

	
	// Events
	
	public function AddEvent(evno:Object, norepeat:Boolean) {
		var pe:PlaceEvent = GetEventDetails(evno);
		if (norepeat == true) pe.NoRepeatEvent();
	}
	
	public function AddNumberedEvents(count:Number, strt:Number) {
		if (strt == undefined) strt = 0;
		for (var i:Number = strt; i < (count + strt); i++) GetEventDetails(i + 1);
	}

	private function GetEventDetails(evno:Object, noadd:Boolean) : PlaceEvent
	{
		var estr:String = typeof(evno) == "string" ? evno : "Event" + evno + "-" + evno;
		var ecnt:Number = elen;
		var pe:PlaceEvent;
		var earr:Array;
		while (--ecnt >= 0) {
			pe = arEventIndex[ecnt]; 
			if (typeof(evno) == "string") {
				if (pe.strName == estr) return pe;
			} else {
				earr = pe.strName.split("-");
				if (earr.length == 3 && !isNaN(earr[2])) {
					if (evno == Number(earr[2])) return pe;
				} else if (earr.length == 2 && !isNaN(earr[1])) {
					if (evno == Number(earr[1])) return pe;
				}
			}
		}
		if (noadd == true || evno == undefined) return null;
		pe = new PlaceEvent(estr)
		elen = arEventIndex.push(pe);
		return pe;
	}
	private function GetEventDetailsIdx(evno:Object, noadd:Boolean) : Number
	{
		var estr:String = typeof(evno) == "string" ? evno : "Event" + evno + "-" + evno;
		var ecnt:Number = elen;
		var pe:PlaceEvent;
		var earr:Array;
		while (--ecnt >= 0) {
			pe = arEventIndex[ecnt]; 
			if (typeof(evno) == "string") {
				if (pe.strName == estr) return ecnt;
			} else {
				earr = pe.strName.split("-");
				if (earr.length == 3 && !isNaN(earr[2])) {
					if (evno == Number(earr[2])) return ecnt;
				} else if (earr.length == 2 && !isNaN(earr[1])) {
					if (evno == Number(earr[1])) return ecnt;
				}
			}
		}
		if (noadd == true || evno == undefined) return -1;
		pe = new PlaceEvent(estr)
		elen = arEventIndex.push(pe);
		return elen;
	}
	
	public function IsEventDone(evno:Object) : Boolean {
		var pe:PlaceEvent = GetEventDetails(evno, true);
		if (pe != null) return pe.IsEventDone();
		return false;
	}
	
	public function IsEventRepeatable(evno:Object) : Boolean {
		var pe:PlaceEvent = GetEventDetails(evno, true);
		if (pe != null) return pe.IsEventRepeatable();
		return true;
	}
	
	public function NoRepeatEvent(evno:Object, noadd:Boolean) { GetEventDetails(evno, noadd).NoRepeatEvent(); }
	public function RepeatEvent(evno:Object, noadd:Boolean) { GetEventDetails(evno, noadd).RepeatEvent(); }
	public function SetEventDone(evno:Object) { GetEventDetails(evno).SetEventDone(); }
	public function SetEventTotal(evno:Object, count:Number) { GetEventDetails(evno).SetEventTotal(count); }
	public function GetEventTotal(evno:Object) : Number { return GetEventDetails(evno).GetEventTotal(); }
	public function GetEventTotalToday(evno:Object) : Number { return GetEventDetails(evno).GetEventTotalToday(); }
	
	public function GetNextEvent(exclude:Array) : String
	{
		var exlen:Number = exclude != undefined ? exclude.length : 0
		var exlenc:Number;
		var pe:PlaceEvent;

		for (var i:Number = 0; i < elen; i++) {
			pe = arEventIndex[i]; 
			if (pe.GetEventTotal() == 0) {
				if (pe.strName.substr(0, 4) == "Day-") {
					if (IsDayTime()) return pe.strName;
					continue;
				}
				if (pe.strName.substr(0, 6) == "Night-") {
					if (!IsDayTime()) return pe.strName;
					continue;
				}
				if (exlen != 0) {
					exlenc = exlen;
					while(--exlenc >= 0) {
						if (exclude[exlenc] == arEventIndex[i]) break;
					}
					if (exlenc >= 0) continue;
				}
				return pe.strName;
			}
		}
		return "";
	}
	
	public function MoveToNextEvent(nxt:Object, exclude:Array) : String
	{
		if (nxt == undefined) nxt = GetNextEvent(exclude);
		SetEventDone(nxt);
		NoRepeatEvent(nxt);
		return nxt + "";
	}
	
	public function GetEvent(base:Object, exclude:Array) : String
	{
		trace("GetEvent: ");
		var pe:PlaceEvent;
		var idx:Number;
		if (base == undefined) idx = 0;
		else idx = GetEventDetailsIdx(base);
		var ecount:Number = elen;
		var unvisited:Number = 0;
		var repeatable:Number = 0;
		
		var eNode:XMLNode;
		var exlen:Number = exclude != undefined ? exclude.length : 0
		var exlenc:Number;
		
		var chc:Array = new Array();
		
		trace("..from: " + idx + " to: " + ecount);
		for (var i:Number = idx; i < ecount; i++) {
			pe = arEventIndex[i];
			if (!pe.IsEventRepeatable()) continue;
			trace("..possible event: " + pe.strName);
			if (pe.strName.substr(0, 4) == "Day-" && !IsDayTime()) continue;
			if (pe.strName.substr(0, 6) == "Night-" && IsDayTime()) continue;
			
			if (exlen != 0) {
				exlenc = exlen;
				while(--exlenc >= 0) {
					if (exclude[exlenc] == pe.strName) break;
				}
				if (exlenc >= 0) continue;
			}
			if (xNode != null || xNodeAlt != "") {
				trace("..check node: " + pe.strName);
				eNode = Language.XMLData.GetNode(xNode, pe.strName);
				if (eNode == null) eNode = Language.XMLData.GetNode(xNodeAlt, pe.strName);
				if (eNode != null) {
					var tot:Number = 0;
					for (var attr:String in eNode.attributes) tot++;
					if (tot > 0) {
						trace("......has conditionals: " + tot);
						/*
						trace("......check conditionsl");
						if (coreGame.ParseConditional(eNode, true, false) == null) {
							trace("......conditionsl failed");
							continue;
						}
						trace("....conditionsl ok");
						*/
						continue;
					} else trace("......no conditionals");
				}
			}

			if (pe.GetEventTotal() == 0) {
				trace("..unvisited");
				unvisited++;
			} else {
				repeatable++; 
				trace("..repeatable");
			}
			trace("..add " + i + " " + arEventIndex[i].strName);
			chc.push(i);
		}
		ecount = -1;
		trace(".total = " + (unvisited + repeatable) + " unvisited: " + unvisited + " repeatable: " + repeatable);
		if ((unvisited + repeatable) > 0) ecount = chc[Math.floor(Math.random()*(unvisited + repeatable))];
		delete chc;
		trace("return (" + ecount + ") = " + (ecount == -1 ? "" : arEventIndex[ecount].strName));
		return ecount == -1 ? "" : arEventIndex[ecount].strName;
	}
	
	public function ResetEvents(except:Number)
	{
		InitialiseModule();
		
		except = GetEventDetailsIdx(except);
		for (var i:Number = 0; i < elen; i++) {
			if (i != except) {
				var pe:PlaceEvent = arEventIndex[i];
				var evno:Number = 0;
				var earr:Array = pe.strName.split("-");
				if (earr[2] != undefined && Number(earr[2]) != NaN) evno = Number(earr[2]);
				else if (earr[1] != undefined && Number(earr[1]) != NaN) evno = Number(earr[1]);
				pe.SetEventTotal(0);
				if (evno != int(evno) || pe.strName == "TentacleSex" || pe.strName == "VisitAstrid") pe.NoRepeatEvent();
			}
		}
	}

	// Accessibility
	
	public function IsAccessible() : Boolean { return Accessible; }
	public function SetAccessible(seta:Boolean) { Accessible = seta == undefined ? true : seta; }
	
	// Visits
	public function IsVisited() : Boolean {	return Visited;	}
	
	public function SetVisited(seta:Boolean) {
		if (seta == false) {
			Visited = false;
			LastVisit = 0;
			LastVisitTime = 0;
			return;
		}
		Visited = true;
		LastVisit = coreGame.GameDate;
		LastVisitTime = coreGame.GameTimeMins;
	}
	
	public function IsInitialVisit() : Boolean {
		return InitialVisit;
	}
	
	public function DoneInitialVisit() {
		InitialVisit = false;
		Language.SaveText();
	}
	
	public function NewDay(nDays:Number)
	{
		var ecnt:Number = elen;
		while (--ecnt >= 0) {
			arEventIndex[ecnt].nTotalToday = 0;
		}
	}
	
	// Reset (new slave)
	
	public function ResetOtherFlags(except:Number)
	{
		for (var i:Number = 0; i < 64; i++) {
			if (i != except) super.ClearBitFlag(i);
		}
	}
	
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		LastVisit = 0;	
		LastVisitTime = 0;
		TotalVisit = 0;
		CustomFlag = 0;
		CustomFlag2 = 0;
		ResetEvents();
		ResetOtherFlags(exceptf);
		for (var i:Number = 0; i < elen; i++) {
			if (i != (except - 1)) {
				var pe:PlaceEvent = arEventIndex[i];
				pe.SetEventTotal(0);
			}
		}
	}
	
	
	// Walk Events
	
	public function GetLocationsCount(qlist:Boolean) : Number
	{
		var lNode:XMLNode = Language.XMLData.GetNodeC(coreGame.currentCity.FindPlaceNodeCByName(strNodeName), "Locations");
		if (lNode == null) return 0;
		if (qlist == undefined) qlist = false;
		
		var cnt:Number = 0;
		for (var hNode:XMLNode = lNode; hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType == 1 && hNode.nodeName.toLowerCase() == "location") {
				if (coreGame.ParseConditional(hNode, true, false)) {
					if (Language.XMLData.GetXMLBooleanParsed("ShowList", hNode.firstChild, false) == qlist) cnt++;
				}
			}
		}
		return cnt;

	}
	
	// DoWalkEvent
	// handles when the slave+supervisor walks to the place
	public function DoWalkEvent()
	{
		trace("DoWalkEvent: " + strNodeName + " " + coreGame.GetUTCMSElapsed(true));
		// show the location
		Backgrounds.ShowBackground(Language.XMLData.GetXMLString("Background", pNode, strNodeName));

		// set common use variables for simplified use
		Supervise = coreGame.Supervise;
		coreGame.currPlace = this;
		coreGame.EventTotal = TotalVisit;
		
		// hide next button and zoom in on the location
		HidePlanningNext();
		
		LoadModule();
		
		if (coreGame.config.bZoomOn && GetLocationsCount() == 0) coreGame.StartZoomImage(coreGame.WalkZoom, 20, 7, 400, xpos, ypos, this, "DoWalkLoadedPre");
		else DoWalkLoaded();
	}
	
	// DoWalkLoadedPre
	// called when the swf file has been loaded
	public function DoWalkLoadedPre(mc:MovieClip, modulename:String, sequential:Boolean)
	{
		DoWalkLoaded(mc, modulename, sequential);
	}
	
	// DoWalkLoaded
	// called when the swf file has been loaded
	public function DoWalkLoaded(mc:MovieClip, modulename:String, sequential:Boolean)
	{
		trace("DoWalkLoaded " + coreGame.GetUTCMSElapsed());
		var str:String = Language.XMLData.GetXMLString("BackgroundSound", pNode);
		if (str != "") PlaySound(str);
		
		// Start Wing Quest, ignore standard events (xml included)
		if (coreGame.Naked) {
			if (strNodeName == "TownCenter" && coreGame.GameTimeMins == 720 && slaveData.BitFlag1.CheckBitFlag(46) && slaveData.BitFlag1.CheckBitFlag(50) == false && !slaveData.DemonFlags.CheckBitFlag(0)) {
				GetTraining("Succubus").AskToStartTraining("");
				return;
			}
			// Wing Quest, ignore standard events (xml included)
			if (slaveData.DemonFlags.CheckBitFlag(31) && !slaveData.DemonFlags.CheckBitFlag(int(Id))) {
				GetTraining("Succubus").Training(int(Id));
				return;
			}
		}
		
		// Tentacle encounter
		str = Language.XMLData.GetXMLString("TentacleStartMessage", pNode);
		if (str != "") coreGame.Tentacles.CheckTentacleWalk(str);
		
		if (!IsEventAllowable()) return;

		// show zoomed location if present
		var lcnt:Number = GetLocationsCount(true);
		
		if (lcnt != 0 && !IsEventPicked()) {
			str = Language.XMLData.GetXMLString("CloseUpImage", pNode);
			if (str != "") {
				var cuNode:XMLNode = Language.XMLData.GetNode(pNode, "CloseUpImage");
				var align:String = cuNode.attributes.align;
				if (align == undefined) align = "left";
				AutoLoadImageAndShowMovie(str, 1.1, coreGame.DecodeAlign(align), coreGame.LoadedMovies);
			}
		}
		
		if (!Language.XMLData.XMLEventByNode(xNode.parentNode, false, "StartWalk", true, true)) Language.XMLData.XMLEventByNode(xNodeAlt.parentNode, false, "StartWalk", true, true);
		if (!IsEventAllowable()) return;
		
		excludeLocations = new Array();
		
		// check if a list of locations should be shown
		if (lcnt == 0 || IsEventPicked()) {
			// no, do an event
			DoWalkLoadedContinue(sequential);
			return;
		}
		
		// ok, show a list of locations
		ResetQuestions(Language.GetHtmlDef("WhereVisit", pNode, Language.GetHtml("WhereVisit", "TakeAWalk")));
		for (var hNode:XMLNode = Language.XMLData.GetNodeC(pNode, "Locations"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType == 1 && hNode.nodeName.toLowerCase() == "location") {
				if (coreGame.ParseConditional(hNode, true, false)) {
					if (!Language.XMLData.GetXMLBooleanParsed("ShowList", hNode.firstChild, false)) continue;

					// show location
					var plc:Object = this;
					var evt:String = Language.XMLData.GetXMLString("Event", hNode.firstChild);
					if (evt == "") {
						evt = Language.XMLData.GetXMLString("Place", hNode.firstChild);
						if (evt != "") plc = coreGame.currentCity.GetPlaceObject(hNode.attributes.place);
					}
					AddQuestion("DoWalkThisEvent", Language.XMLData.GetXMLStringParsed("Name", hNode.firstChild), plc, evt);
					excludeLocations.push(evt);					
					var posNode:XMLNode = Language.XMLData.GetNode(hNode.firstChild, "ShowCloseUpMap");
					if (posNode != undefined) {
						var mcl:MovieClip = parentCity.AddWalkLocation(plc, evt, "<font size='-10'>+ " + Language.XMLData.GetXMLStringParsed("Name", hNode.firstChild) + "</font>", Number(posNode.attributes.xpos), Number(posNode.attributes.ypos), "", coreGame.LoadedMovies);
						mcl.Btn.onPress = function() {
							var plco:Object = this._parent.plc;
							plco.DoWalkThisEvent(this._parent.evt);
						}
						mcl._visible = true;
					}
				}
			}
		}
		AddQuestion("DoWalkThisEvent", Language.GetHtmlDef("WanderAround", pNode, Language.GetHtml("WanderAround", "TakeAWalk")), this, "");
		ShowQuestions();
	}

	public function DoWalkThisEvent(evt:String)
	{
		coreGame.HideQuestions();
		HideImages();
		coreGame.HideImages();
		Backgrounds.ShowBackground(Language.XMLData.GetXMLString("Background", pNode, strNodeName));
		ResetEventPicked();
		if (isNaN(evt)) coreGame.StrEvent = evt != "" && evt != undefined ? evt : "";
		else coreGame.NumEvent = Number(evt);
		if (coreGame.StrEvent != "" && coreGame.StrEvent.charAt(0) == "/") {
			coreGame.DoEventNext();
			coreGame.modulesList.AfterWalk(Id);
		} else DoWalkLoadedContinue();
	}
	
	public function DoWalkLoadedContinue(sequential:Boolean)
	{
		trace("DoWalkLoadedContinue: " + coreGame.NumEvent + " " + coreGame.StrEvent);
		ShowPlanningNext();
		
		// set common use variables for simplified use
		Supervise = coreGame.Supervise;
		coreGame.FirstTimeToday = LastVisit != coreGame.GameDate;
		
		if (sequential == undefined) sequential = false;
		
		var imax:Number = 10;
		var exclude:Array = excludeLocations;
		excludeLocations = null;
		if (exclude == undefined) exclude = new Array();
		do {
			
			GetWalkEvent(exclude, sequential);
			
			if (coreGame.modulesList.DoWalk(coreGame.WalkPlace) || HandleWalkIntercept()) {
				delete exclude;
				if (coreGame.WalkPlace != 0) coreGame.modulesList.AfterWalk(coreGame.WalkPlace);
				SetVisited();
				TotalVisit++;
				return;
			}
			
			// xml pick event failed
			exclude.push(coreGame.StrEvent);
			ResetEventPicked();
			
		} while (--imax > 0);
		delete exclude;
	}

	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{	
		SMTRACE("GetWalkEvent: " + IsEventPicked() + " " + coreGame.NumEvent + " " + coreGame.StrEvent + "(" + (coreGame.StrEvent == "") + ") " + coreGame.ObjEvent  + "(" + (coreGame.ObjEvent == null) + ") || (" + (coreGame.ObjEvent == undefined) + ")");
		if (!IsEventPicked()) {
			coreGame.genNumber = sequential ? 1 : 0;
			Language.XMLData.XMLEventByNode(xNode.parentNode, false, "SelectWalkEvent", true, true);
			Language.XMLData.XMLEventByNode(xNodeAlt.parentNode, false, "SelectWalkEvent", true, true);
			sequential = coreGame.genNumber == 1;
		}
		if (!IsEventPicked()) {
			var str:String = Language.XMLData.PickXMLEventByNode(xNode.parentNode, exclude, this);
			if (str == "") str = Language.XMLData.PickXMLEventByNode(xNodeAlt.parentNode, exclude, this);
			if (str != "") {
				trace("picked: " + str);
				if (!IsEventRepeatable(str)) {
					trace("..not repeatable");
					str = "";
				} else SetEvent(str);
			}
			if (str == "") {
				trace("none picked: " + sequential);
				if (sequential == true) str = MoveToNextEvent();
				else str = GetEvent();
				trace("GetEvent picked: " + str);
				if (str == "") {
					SetEvent(EventDefault);
					if (!IsEventPicked()) return;
				} else SetEvent(str);
			}
			if (coreGame.NumEvent == -2) SetEvent("VisitAstrid");
		} else if (coreGame.NumEvent == -1) SetEvent("TentacleSex");
		else if (coreGame.NumEvent == -2) SetEvent("VisitAstrid");
		
		if (coreGame.NumEvent != 0) {
			trace("picked number: " + coreGame.NumEvent);
			var ev:Number = coreGame.NumEvent;
			var pe:PlaceEvent = GetEventDetails(coreGame.NumEvent, true);
			if (pe != null) {
				SetEvent(pe.strName);
				trace("set: " + pe.strName);
				if (coreGame.NumEvent == 0) coreGame.NumEvent = ev;
			}
		}
		SMTRACE("GetWalkEvent: " + IsEventPicked() + " " + coreGame.NumEvent + " " + coreGame.StrEvent);

		if (!IsEventPicked()) {
			// pick default
			SetEvent(EventDefault);
		}
		
		coreGame.OldNumEvent = coreGame.NumEvent;
		coreGame.OldStrEvent = coreGame.StrEvent;
	}

	public function HandleWalkIntercept(exclude:Array) : Boolean
	{
		SMTRACE("HandleWalkIntercept: " + IsEventPicked() + " " + coreGame.NumEvent + " " + coreGame.StrEvent + " " + coreGame.GetUTCMSElapsed());
		var fract:Boolean = false;
		if (coreGame.OldNumEvent != coreGame.NumEvent) {
			if (coreGame.NumEvent == -1) SetEvent("TentacleSex");
			else if (coreGame.NumEvent == -2) SetEvent("VisitAstrid");
			else {
				trace(".NumEvent = " + coreGame.NumEvent);
				var pe:PlaceEvent = GetEventDetails(coreGame.NumEvent, true);
				if (pe != null) SetEvent(pe.strName);
				trace(".NumEvent = " + coreGame.NumEvent + " " + pe);
			}
			if (Math.floor(coreGame.NumEvent) == Math.floor(coreGame.OldNumEvent)) {
				var pe:PlaceEvent = GetEventDetails(coreGame.OldNumEvent, true);
				if (pe != null) {
					trace(".set " + pe.strName);
					SetEventDone(pe.strName); 
					fract = true;
				}
			}
		}
		trace(".NumEvent = " + coreGame.NumEvent);
		coreGame.OldNumEvent = coreGame.NumEvent;
		coreGame.OldStrEvent = coreGame.StrEvent;
		
		delete Language.XMLData.tempVars;
		Language.XMLData.tempVars = new Array();
		Language.XMLData.tempVars.push(0);
		
		var bDoneXML:Boolean = false;
		if (coreGame.StrEvent != "") {
			//trace(".StrEvent = " + coreGame.StrEvent);
			if (Language.XMLData.GetNode(xNode, coreGame.StrEvent) != null) {
				Language.XMLData.lastNode = xNode.parentNode.parentNode;
				bDoneXML = Language.XMLData.XMLEventByNode(xNode.parentNode, false, coreGame.StrEvent);
			} else {
				Language.XMLData.lastNode = xNode.parentNode.parentNode;
				bDoneXML = Language.XMLData.XMLEventByNode(xNodeAlt.parentNode, false, coreGame.StrEvent);
			}
		} else {
			if (Language.XMLData.GetNode(xNode, "CoreEvent-" + coreGame.NumEvent) != null) bDoneXML = Language.XMLData.XMLEventByNode(xNode.parentNode, false, "CoreEvent-" + coreGame.NumEvent);
			else bDoneXML = Language.XMLData.XMLEventByNode(xNodeAlt.parentNode, false, "CoreEvent-" + coreGame.NumEvent);
		}
		if (bDoneXML) {
			if (coreGame.OldStrEvent != "") {
				SetEventDone(coreGame.OldStrEvent);
				if (fract) NoRepeatEvent(coreGame.OldStrEvent);
			}
			return true;
		}
		return HandleWalk();
	}
	
	public function SetWalkEvents()
	{
		// reset all current events
		//delete arEventIndex;
		//arEventIndex = new Array();
		//elen = 0;
		
		/* optionally use this list of nodes
			<PickEventList>
				<Event default='true'>Day-Pleasant-1</Event>
				<Event norepeat='true'>Day-FurryReptile-2</Event>
				<Event>Night-Dangerous-3</Event>
			</PickEventList>
		*/
		var pel:XMLNode = Language.XMLData.GetNode(xNode, "PickEventList");
		if (pel == null) pel = Language.XMLData.GetNode(xNodeAlt, "PickEventList");
		if (pel != null) {
			pel = pel.firstChild;
			var strl:String;
			var evs:String;
			while (pel != null) {
				if (pel.nodeType == 1 && pel.nodeName == "Event") {
					evs = pel.firstChild.nodeValue;
					AddEvent(evs);
					for (var attr:String in pel.attributes) {
						strl = attr.toLowerCase();
						if (strl == "default") EventDefault = evs;			// set default event
						else if (strl == "norepeat") {
							var cXML:XML = new XML;
							cXML.parseXML("<if " + pel.attributes[attr] + "/>");
							if (coreGame.ParseConditional(cXML.firstChild, true, false)) NoRepeatEvent(evs);
							delete cXML;
						}
					}
				}
				pel = pel.nextSibling;
			}
		}
	}

	
	public function HandleWalk() : Boolean
	{
		SMTRACE("HandleWalk (" + Id + ") " + coreGame.StrEvent);
		switch (coreGame.StrEvent) {
			
		case "TentacleSex":
			coreGame.TentacleChoice = Math.floor(Math.random()*4);
			coreGame.Tentacles.TentacleSex(Id);
			return true;
			
		case "FindDealer":
			parentCity.Dealer.FindShop();
			return true;
			
		}
		return false;
	}
	
	public function ChangeWalkEvent(evt:String)
	{
		SetEvent(evt);
		coreGame.OldStrEvent = evt;
		var earr:Array = coreGame.StrEvent.split("-");
		if (earr[2] != undefined && earr[2] != "" && Number(earr[2]) != NaN) coreGame.OldNumEvent = Number(earr[2]);
	}
	
	public function ResetWalkEvent()
	{
		ResetEventPicked();
		if (coreGame.TakeAWalkMenu.ChooseEvent.text != "") SetEvent(coreGame.TakeAWalkMenu.ChooseEvent.text);
		temp = Math.floor(Math.random()*100);
		coreGame.HideAllPeople();
		ShowSupervisor();
	}
	
	public function IsThisPlace(str:String) : Boolean
	{
		str = str.split(" ").join("").toLowerCase();
		var ar:Array = str.split("/");
		str = ar[ar.length - 1];
		ar = strNodeName.split(" ").join("").toLowerCase().split("/");
		return (ar[ar.length - 1] == str);
	}
	
	// Images
	public function HideImages()
	{
		super.HideImages();
		Assistant._visible = false;
	}
	
	// Diagnostic
	
	public function ShowFlags()
	{
		var say:String = super.ShowBitFlags();
		say += "  Custom Flag = " + CustomFlag;
		say += "  Custom Flag2 = " + CustomFlag2 + "\r";;
		say += "  Accessible = " + IsAccessible();
		say += "  Visited = " + IsVisited() + "\r";
		say += "  SM Flag = " + SMFlag;
		say += "  SM Flag2 = " + SMFlag2 + "\r";
		
		say += "  Events\r";
		var ecnt:Number = elen;
		while (--ecnt >= 0) {
			say += "    " + arEventIndex[ecnt].strName + " (seen " + arEventIndex[ecnt].GetEventTotal() + ", repeatable = " + arEventIndex[ecnt].IsEventRepeatable() + ")\r";
		}
		AddText(say);
	}
}