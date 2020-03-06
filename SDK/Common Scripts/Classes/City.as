// A city
//
// Translation status: COMPLETE
//
// BitFlags
// 1-8 - visited custom person 1-8

import Scripts.Classes.*;

class City extends SlaveModule
{
	// Global City
	public var bCurrent:Boolean;		// Is this the current City
	public var nBaseYear:Number;		// Time Period, the year at the start of training, default 1252
	
	// Places
	public var arPlaces:Array;
	public var SlaveMarket:PlaceSlaveMarket;		// The SlaveMarket
	// slave makers home in this city
	public var Home:HouseDetails;
	
	// People
	private var People:PeopleModule;
	public var Seer:Person;
	public var arPeople:Array;
	
	// Shops
	public var arShops:Array;	
	public var Armoury:Shop;
	public var Salon:Shop;
	public var GeneralShop:Shop;
	public var Dealer:ShopDealer;
	public var ItemSalesman:ShopItemSalesman;
	public var Stables:ShopStables;
	public var Tailors:ShopTailor;
	public var SlaveMarketAuction:ShopSlaveMarketMinor;
	
	// Areas - large regions you can visit in the city with separate places and maps
	private var strCurrentArea:String;
	
	// the city map
	private var mcMap1:MovieClip;
	private var mcMap2:MovieClip;
	
	// xml nodes
	public var cityNode:XMLNode;
	public var areasNode:XMLNode;
	public var areaNode:XMLNode;
	
	// internal use, the menu movieclips for visit/walk menus
	// TODO? convert to a dialogue class instances?
	private var mcVisitMenu:MovieClip;
	private var mcTakeAWalkMenu:MovieClip;
	
	private var arWalkLocations:Array;		// internal use only
		
	private var nUniqueID:Number;		// for people/places/shops
	
	
	// Constructor
	
	public static function main(cg:Object) : City {	return new City(cg); }
	
	public function City(cg:Object)
	{
		super(null, null, cg);
		
		ModuleName = "";
		ImageFolder = "";
		mcMap1 = null;
		mcMap2 = null;
		arWalkLocations = null;
		strCurrentArea = "";
		
		bCurrent = false;
		Home = new HouseDetails(-1, cg);
		
		mcVisitMenu = coreGame.VisitMenu;
		mcTakeAWalkMenu = coreGame.TakeAWalkMenu;
		
		arPlaces = new Array();
		arPeople = new Array();
		arShops = new Array();
		
		nUniqueID = 99;
		nBaseYear = 1252;
		
		Seer = null;
		SlaveMarket = null;
		Armoury = null;
		Salon = null;
		GeneralShop = null;
		Dealer = null;
		ItemSalesman = null;
		Stables = null;
		Tailors = null;
		SlaveMarketAuction = null;
		
		People = coreGame.People;
	}
	
	// Initalise the city, resetting all places, people, shops and variables
	public function Initialise()
	{
		trace("City.Initialise: " + ModuleName);
		
		cityNode = Language.XMLData.GetNodeC(coreGame.flNode, "City");
		areasNode = Language.XMLData.GetNodeC(coreGame.flNode, "Areas");


		CreatePeople();
		CreatePlaces();
		CreateShops();
		
		for (var so:String in arPlaces) {
			var plc:Place = arPlaces[so];
			plc.Initialise();
			plc.ResetNode();
		}
		for (var so:String in arPeople) {
			var per:Person = arPeople[so];
			per.Initialise();
			per.ResetNode();
		}
		for (var so:String in arShops) {
			var shp:Shop = arShops[so];
			shp.InitialiseModule();
		}	
		
		mcTakeAWalkMenu.tabChildren = true;
		mcVisitMenu.tabChildren = true;
		mcTakeAWalkMenu.ChooseEvent.tabEnabled = false;
				
		ImageFolder = "Images/Cities/" + ModuleName;
		coreGame.WalkZoom._visible = false;
		mcTakeAWalkMenu.WalkBG._visible = false;
		
		nBaseYear = Language.GetXMLValue("BaseYear", cityNode, nBaseYear);

		mcTakeAWalkMenu.House._visible = false;
		mcVisitMenu.CustomPerson1._visible = false;
		mcVisitMenu.CustomPerson2._visible = false;
		mcVisitMenu.CustomPerson3._visible = false;
		mcVisitMenu.CustomPerson4._visible = false;
		mcVisitMenu.CustomPerson5._visible = false;
		mcVisitMenu.CustomPerson6._visible = false;
		mcVisitMenu.CustomPerson7._visible = false;
		mcVisitMenu.CustomPerson8._visible = false;
		
		ChangeArea();
		
		Language.XMLData.InitialiseCommonXML(cityNode, true);
	}
	
	public function DestroyModule()
	{
		super.DestroyModule();
		
		coreGame.SlaveMarket = null;
		cityNode = null;
		bCurrent = false;
		coreGame.currentCity = null;
		coreGame.modulesList.currentCity = null;
		coreGame.Home = null;
	}

	
	// The untranslated name of the city
	public function GetNodeName() : String { return ModuleName; }
	// The translated name of the city
	public function GetName() : String { return Language.GetHtml("Name", "City"); }
	// The area of the city we are in
	public function GetCurrentArea() : String { return strCurrentArea; }
	
	// Get an id for internal uniquness for places, people etc
	public function GetUniqueID() : Number { return ++nUniqueID; }
	
	// This city will now be the city used in game play
	public function SetCurrent()
	{
		bCurrent = true;
		coreGame.currentCity = this;
		coreGame.modulesList.currentCity = this;
		coreGame.Home = Home;
	}

	
	//
	// Areas
	// -----
	// A large regoin of the city, with it's own map and places for walking, events, people etc
	
	// move gameplay to the new area
	public function ChangeArea(area:String)
	{
		coreGame.HouseEvents.ResetAllCustomHouses();
		if (area != undefined) strCurrentArea = area;
		if (strCurrentArea == "") strCurrentArea = GetStartingArea();
		var s:String = strCurrentArea;
		if (s != "") s = "/Areas/" + s;
		
		areaNode = null;
		for (var cNode:XMLNode = areasNode; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "area") {
				if (Language.GetXMLString("Name", cNode.firstChild) == strCurrentArea) {
					areaNode = cNode.firstChild;
					break;
				}
			}
		}
		
		var str:String = Language.GetXMLString("Folder", cNode.firstChild, ImageFolder + s);
		coreGame.RemoveLoadedImage(mcMap1);
		coreGame.RemoveLoadedImage(mcMap2);
		mcMap1 = coreGame.LoadGameImageAndShowMovie(undefined, str + "/Map.jpg", 1, -2, undefined, undefined, coreGame.WalkZoom);
		mcMap2 = coreGame.LoadGameImageAndShowMovie(undefined, str + "/Map.jpg", 2.1, -2, undefined, undefined, mcTakeAWalkMenu.WalkBG);
		mcMap1._visible = false;
		mcMap2._visible = false;
		coreGame.WalkZoom._visible = false;
		mcTakeAWalkMenu.WalkBG._visible = false;
	}
	
	// get the total areas for the game
	public function GetTotalAreas() : Number
	{
		var tot:Number = 0;
		for (var cNode:XMLNode = areasNode; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "area") tot++;
		}
		return tot;
	}
	
	// get the starting area for the city
	public function GetStartingArea() : String
	{
		var s:String = "";
		for (var cNode:XMLNode = areasNode; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "area") {
				if (cNode.attributes.start == "true") return Language.GetXMLString("Name", cNode.firstChild);
			}
		}
		return GetArea(0);
	}
	
	// Find the numbered area
	public function GetArea(nArea:Number) : String
	{
		for (var cNode:XMLNode = areasNode; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "area") {
				nArea--;
				if (nArea <= 0) return Language.GetXMLString("Name", cNode.firstChild);
			}
		}
		return "";
	}

	//  Display the maps for the take a walk screen
	public function ShowMaps() {
		mcMap1._visible = true;
		mcMap2._visible = true;
	}
	
	// General process to travel to another area, with event during journey
	// Standard cosr 10GP
	public function TravelToArea(str:String) : Boolean
	{
		// return from the island
		ChangeArea(str);
		Money(-10);
		return Language.XMLData.PickAndDoXMLEventByNode(Language.XMLData.GetNode(areaNode, "Places/TravelTo"));
	}
	
	
	//
	// Slave Maker
	//
	public function StartSlaveMaker()
	{
		super.StartSlaveMaker();
		
		CreatePeople();
		CreatePlaces();
		CreateShops();
		
		for (var so:String in arPeople) {
			var per:Person = arPeople[so];
			if (per.CheckBitFlag(128) && (SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1))) per.SetAccessible(true);
			if (per.Id == 11 && (SMData.SMSkills.CheckBitFlag(6) || SMData.SMInitialItems.CheckBitFlag(1))) per.SetAccessible(true);
		}
		
	}
	
	// 
	// Slave 
	// -----

	public function StartNewSlave()
	{ 
		sd = _root;
		
		for (var so:String in arPlaces) {
			var plc:Place = arPlaces[so];
			plc.StartNewSlave();
		}
		for (var so:String in arPeople) {
			var per:Person = arPeople[so];
			per.StartNewSlave();
		}
		
		SetWalkEvents();
	} 
	
	// Check comman separated liksts for a slave against the cities name and geography
	public function IsSlavePresent(sNode:XMLNode) : Boolean
	{
		// Check City node name
		var str:String = Language.XMLData.GetXMLStringParsed("", Language.XMLData.GetNode(sNode, "City")).toLowerCase();
		var cty:String = ModuleName.toLowerCase();
		if (str != "") {
			//trace("IsSlavePresent1: '" + str + "' '" + cty + "' " + str.indexOf(cty) + " " + str.indexOf("!" + cty));
			if (str.indexOf("!" + cty) != -1) return false;
			if (str.indexOf(cty) == -1) {			
				// Check city translated name
				cty = GetName().toLowerCase();
				//trace("IsSlavePresent1a: '" + str + "' '" + cty + "' " + str.indexOf(cty) + " " + str.indexOf("!" + cty));
				if (str.indexOf("!" + cty) != -1) return false;
				if (str.indexOf(cty) == -1) return false;
			}
			
			//trace("name matches");
		}
		
		// Check other geographic properties
		str = Language.XMLData.GetXMLStringParsed("CityGeography", sNode).toLowerCase();
		if (str != "") {
			cty = Language.XMLData.GetXMLStringParsed("Geography", cityNode).toLowerCase();
			//trace("IsSlavePresent2: '" + str + "' '" + cty + "'");
			var ars:Array = str.split(",");
			var arc:Array = cty.split(",");
			var plc:Place;
			// Check all listed items in the comma separated list, all MUST be present
			for (var i:Number = 0; i < ars.length; i++) {
				str = ars[i];
				var bOK:Boolean = false;
				for (var j:Number = 0; j < arc.length; j++) {
					cty = arc[j];
					if (str == ("!" + cty)) return false;
					if (str == cty) {
						bOK = true;
						break;
					}
				}
				if (bOK) continue;
				
				// Check places
				for (var so:String in arPlaces) {
					plc = arPlaces[so];
					cty = plc.strNodeName.toLowerCase();
					if (str == ("!" + cty)) return false;
					if (str == cty) {
						bOK = true;
						break;
					}
				}
				if (bOK) continue;
				
				// Check people
				var per:Person;
				for (var so:String in arPeople) {
					per = arPeople[so];
					if (str.charAt(0) == "!") {
						if (per.IsPerson(str.substr(1))) return false;
					} else if (per.IsPerson(str)) {
						bOK = true;
						break;
					}
				}
				if (bOK) continue;
				
				// Check Owned slaves
				if (str.charAt(0) == "!") {
					if (SMData.IsSlaveOwned(str.substr(1))) return false;
				} else if (SMData.IsSlaveOwned(str)) continue;

				return false;
			}
		}
		return true;
	}

	
	//
	// Places
	// ------
	
	public function CreatePlacesForArea(aNode:XMLNode)
	{
		var nm:String;
		var id:Number;
		var sArea:String = Language.GetXMLString("Name", aNode);
		
		for (var hNode:XMLNode = Language.XMLData.GetNodeC(aNode, "Places"); hNode != null; hNode = hNode.nextSibling) {
		
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "place") {
				nm = hNode.attributes.nodeid;
				if (nm == "Docks" && ModuleName == "Mardukane") nm = "DocksPort";
				else if (nm == "Beach" && ModuleName == "Mardukane") nm = "BeachWalk";
				//trace("checking place " + nm + " to create");
				id = Number(hNode.attributes.id);
				if (isNaN(id) || id == 0) id = GetUniqueID();
				var plc:Place = GetPlaceObjectBase(nm);
				//trace("1. place " + (plc != null ? "exists" : "does not exist"));
				if (plc == null) plc = GetPlaceInstance(id);
				//trace("2. place " + (plc != null ? "exists" : "does not exist"));
				var can:Boolean = Language.GetXMLBoolean("Accessible", hNode.firstChild, true);
				var mxpos:Number = Language.GetXMLValue("xpos", hNode.firstChild);
				var mypos:Number = Language.GetXMLValue("ypos", hNode.firstChild);
				if (plc == null) {
					//trace("create it");
					if (nm.toLowerCase() == "slavemarket" && SlaveMarket == null) {
						SlaveMarket = new PlaceSlaveMarket(coreGame.WalkSlavesMovie, coreGame, this);
						coreGame.SlaveMarket = SlaveMarket;
						plc = SlaveMarket;
					} else plc = new Place(nm, null, coreGame, id, can, "", mxpos, mypos, this);
				}
				if (nm.toLowerCase() != "slavemarket") {
					var mc:MovieClip = null;
					var module:String = Language.GetXMLString("Module", hNode.firstChild);
					if (module == "") {
						switch(nm.toLowerCase()) {
							case "farm": module = "Engine/Walk-Farm.swf"; mc = coreGame.WalkFarmMovie; break;
							case "forest": module = "Engine/Walk-Forest.swf"; mc = coreGame.WalkForestMovie; break;
							case "ruinedtemple": module = "Engine/Walk-Ruins.swf"; mc = coreGame.WalkRuinsMovie; break;
							case "beachwalk":
							case "beach": module = "Engine/Walk-Beach.swf"; mc = coreGame.WalkBeachMovie; break;
							case "docks": module = "Engine/Walk-Docks.swf"; mc = coreGame.WalkDocksMovie; break;
						}
					}
					if (plc.mcBase == null) plc.mcBase = mc;
					if (module != "") plc.ModuleName = module;
				}
				
				if (plc.ImageFolder == "") plc.ImageFolder = Language.GetXMLString("Folder", hNode.firstChild);
				if (plc.EventDefault == "") plc.EventDefault = Language.GetXMLString("DefaultEvent", hNode.firstChild);
				plc.strArea = sArea;
			}
		}
	}
	public function CreatePlaces() 
	{
		//trace("CreatePlaces");
		for (var cNode:XMLNode = areasNode; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "area") {
				CreatePlacesForArea(cNode.firstChild);
			}
		}
		
		if (SlaveMarket == null) {
			SlaveMarket = new PlaceSlaveMarket(coreGame.WalkSlavesMovie, coreGame, this);
			coreGame.SlaveMarket = SlaveMarket;
		}
		
		SetWalkEvents();
	}
	
	public function SetWalkEvents()
	{
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			plc.SetWalkEvents();
		}		
	}
	
	public function ResetPlacesNodes() 
	{
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			plc.ResetNode();
		}
	}
	
	public function GetPlaceInstance(place:Number) : Place
	{
		//trace("GetPlaceInstance: " + place);
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			//trace(plc.strNodeName + " " + plc.Id);
			if (plc.Id == place) {
				plc.Supervise = coreGame.Supervise;
				return plc;
			}
		}	
		return null;
	}
	
	//public function GetPlaceInstanceString(place:String) : Place { return GetPlaceObject(place); }
		
	public function GetPlaceObjectBase(place:String) : Place
	{
		place = place.split(" ").join("").toLowerCase();
		var ar:Array = place.split("/");
		place = ar[ar.length - 1];

		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			ar = plc.strNodeName.split(" ").join("").toLowerCase().split("/");
			if (ar[ar.length - 1] == place) {
				plc.Supervise = coreGame.Supervise;
				return plc;
			}
		}
		return null;
	}
	public function GetPlaceObject(place:String) : Place { return GetPlaceObjectBase(place); }

	private function FindAreaPlaceNodeByName(str:String, aNode:XMLNode) : XMLNode
	{
		// find the CHILD nodes for a given place
		var nm:String;
		str = str.toLowerCase().split(" ").join("");
		
		for (var hNode:XMLNode = Language.XMLData.GetNodeC(aNode, "Places"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "place") {
				nm = hNode.attributes.nodeid;
				if (nm.toLowerCase().split(" ").join("") == str) return hNode;
			}
		}
		
		var plc:Place = GetPlaceObject(str);
		if (plc != null && plc.strNodeName.toLowerCase() != str) return FindPlaceNodeByName(plc.strNodeName);
		return null;
	}
	
	private function FindPlaceNodeByName(str:String) : XMLNode
	{
		var pNode:XMLNode;
		for (var cNode:XMLNode = areasNode; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "area") {
				pNode = FindAreaPlaceNodeByName(str, cNode.firstChild);
				if (pNode != null) return pNode;
			}
		}
		return null;
	}
	
	public function FindPlaceNodeCByName(str:String) : XMLNode
	{
		var rNode:XMLNode = FindPlaceNodeByName(str);
		if (rNode == null) return rNode;
		return rNode.firstChild;
	}
	
	public function GetPlaceName(placeo) : String
	{
		var plc:Place = GetPlaceObject(placeo);
		if (plc == null) return "";
		return Language.GetText("Name", plc.pNode);
	}
	
	// Places - Walking
	
	public function ResetWalkLocations()
	{
		var i:Number = arWalkLocations.length;
		if (i != undefined) {
			var ch:MovieClip;
			while (--i >= 0) {
				ch = MovieClip(arWalkLocations.pop());
				ch.removeMovieClip();
				delete ch;
			}
		}
		delete arWalkLocations;
		arWalkLocations = new Array();
	}
	
	public function AddWalkLocationCommon(image:MovieClip, clabel:String, xpos:Number, ypos:Number, hint:String)
	{
		var ti:City = this;
		
		image.Btn.onRollOver = function() { 
			ti.SetMovieColour(this._parent, 200, 200, 200);
			if (this._parent.HintText != "") {
				ti.ServantSpeak(this._parent.HintText);
				ti.AddText("\r");
			}
		}
		image.Btn.onRollOut = function() { 
			ti.SetMovieColour(this._parent, 0, 0, 0);
			ti.coreGame.Hints.HideHints();
		}
		image.HintText = hint;
		image._x = xpos + 7;
		image._y = ypos + 5;
		image.LText.autoSize = true;
		image.LText.htmlText = "<b>" + clabel + "</b>";
		image.Btn._width = image.LText._width;
		image._visible = false;
	}

	
	public function AddWalkLocation(plc:Place, evt:String, clabel:String, xpos:Number, ypos:Number, hint:String, target:MovieClip, shortcut:String) : MovieClip
	{
		if (target == undefined) target = mcTakeAWalkMenu.Places;
		var image:MovieClip = target.attachMovie("Walk - Custom Place", "Location" + target.getNextHighestDepth(), target.getNextHighestDepth());
		
		image.place = plc.Id;
		image.plc = plc;
		image.evt = evt;
		image.short = shortcut;
				
		var ti:City = this;
		image.Btn.onPress = function() {
			var mc:MovieClip = this._parent;
			ti.DoWalk(mc.place, mc.evt);
		}
		
		AddWalkLocationCommon(image, clabel, xpos, ypos, hint);
		
		arWalkLocations.push(image);
		return image;
	}
	
	private function LoadedWalkPlace(btn:MovieClip)
	{
		trace("LoadedWalkPlace: " + btn);
		var image:MovieClip = btn._parent;
		var pNode:XMLNode = image.pNode;
		var bNode:XMLNode = Language.XMLData.GetNode(pNode, "WalkButton");
		var xpos:Number = Number(bNode.attributes.xpos);
		var ypos:Number = Number(bNode.attributes.ypos);
		var wid:Number = Number(bNode.attributes.width);
		var hei:Number = Number(bNode.attributes.height);
		var short:String = bNode.attributes.shortcut;
		image.short = short;
		btn._width = wid;
		btn._height = hei;
		btn._alpha = 0;
		btn._x = 0;
		btn._y = 0;
		
		image.evt = Language.XMLData.GetXMLStringParsed("WalkEvent", pNode, "");
		image._x = xpos;
		image._y = ypos;
		
		// Label
		var labelxpos:Number = Number(bNode.attributes.labelx);
		if (isNaN(labelxpos)) labelxpos = 0;
		var labelypos:Number = Number(bNode.attributes.labely);
		if (isNaN(labelypos)) labelypos = 0;

		image.LText.wordWrap = true;
		image.LText.autoSize = true;
		var lbl:String = Language.GetHtml(image.plc.strNodeName, "Places");
		if (lbl == "") lbl = Language.GetHtml("Name", pNode, true, 0, short);
		image.LText.htmlText = "<font color='black'><b>" + lbl + "</b></font>";
		image.LTextBG.wordWrap = true;
		image.LTextBG.autoSize = true;
		image.LTextBG.htmlText = "<font color='white'><b>" + lbl + "</b></font>";
		
		//trace("position = " + image.LText._x + " " + wid + " " + labelxpos + " " + image.LText._width);
		image.LText._x += (wid - image.LText._width) / 2 + labelxpos;
		image.LText._y += ((hei - image.LText._height) / 2) - 10 + labelypos;
		image.LTextBG._x += (wid - image.LTextBG._width) / 2 + labelxpos;
		image.LTextBG._y += ((hei - image.LTextBG._height) / 2) - 10 + labelypos;
		
		image._visible = true;
		
		var ti:City = this;
		btn.onPress = function() {
			var mc:MovieClip = this._parent;
			ti.DoWalk(mc.place, mc.evt);
		}
		btn.onRollOver = function() { 
			this._alpha = 25;
			var mc:MovieClip = this._parent;
			var desc:String = ti.Language.GetHtml(mc.plc.strNodeName + "Description", "Places");
			if (desc == "") desc = ti.Language.GetHtml("Description", mc.pNode);
			ti.ServantSpeak(desc);
			ti.AddText("\r");
		}
		btn.onRollOut = function() { 
			this._alpha = 0;
			ti.coreGame.Hints.HideHints();
		}
	}

	public function AddWalkPlace(plc:Place, pNode:XMLNode) : MovieClip
	{
		//trace("AddWalkPlace: " + plc.strNodeName + " " + plc.Id);
		if (pNode == undefined) pNode = FindPlaceNodeCByName(plc.strNodeName);
		if (!Language.GetXMLBooleanParsed("Show", pNode, true)) return null;
		var bNode:XMLNode = Language.XMLData.GetNode(pNode, "WalkButton");
		if (bNode == null) return null;

		var image:MovieClip = mcTakeAWalkMenu.Places.attachMovie("Walk - Standard Place", "Location" + mcTakeAWalkMenu.Places.getNextHighestDepth(), mcTakeAWalkMenu.Places.getNextHighestDepth());
		image.ldf = new Object();
		var ti:City = this;
		image.ldf.LoadDoneImage = function(image:MovieClip) {
			//trace("load done");
			if (image.loaderror == true) return;  // ignore failed load
			ti.LoadedWalkPlace(image);
		}	
		
		coreGame.LoadImageAndPositionMovie(undefined, bNode.firstChild.nodeValue, 0, 0, 0, 0, 0, image, 0, image.ldf.LoadDoneImage);
		image.plc = plc;
		image.place = plc.Id;
		image._visible = false;
		image.pNode = pNode;
		arWalkLocations.push(image);
		return image;
	}

	
	function ShowTakeAWalkMenu(special:Boolean)
	{
		var ti:City = this;
		
		var bStartArea:Boolean = GetStartingArea() == strCurrentArea;
		
		coreGame.HouseEvents.PopCustomHouses();
		ShowPlanningNext();
		ShowSupervisor();
		coreGame.PersonIndex = -50;
		if (!special) {
			ResetEventPicked();
			Beep();
			SetLangText("TakeAWalkStart", "TakeAWalk");
		}
		HidePlanningNext();
		ResetWalkLocations();
		
		mcTakeAWalkMenu.WalkBG._visible = true;
		mcTakeAWalkMenu.TentacleLocation._visible = false;
		
		// standard buttons
		
		var strHomeArea:String = Home.GetCityArea();
		
		if (strHomeArea == strCurrentArea) {
			mcTakeAWalkMenu.House.onPress = function() { ti.DoWalkHouse(ti.Home.HouseType); }
			mcTakeAWalkMenu.House.onRollOver = function() { ti.HouseHint(); }
			mcTakeAWalkMenu.House.onRollOut = function() { ti.coreGame.HideHints(); }
			mcTakeAWalkMenu.House._visible = true;
		} else mcTakeAWalkMenu.House._visible = false;
		
		coreGame.HouseEvents.HideAllCustomHouses(strCurrentArea);
		
		// Places
		var plc:Place;
		for (var hNode:XMLNode = Language.XMLData.GetNodeC(areaNode, "Places"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			var nm:String = hNode.nodeName.toLowerCase();
			if (nm == "place") {
				nm = hNode.attributes.nodeid;
				var bNode:XMLNode = Language.XMLData.GetNode(hNode.firstChild, "WalkButton");
				if (bNode == null) continue;
				
				plc = GetPlaceObject(nm);
				if (plc == null) continue;		
				
				// Add the base place
				if (Language.GetXMLBooleanParsed("ShowCityMap", hNode.firstChild, true)) AddWalkPlace(plc, hNode.firstChild);
				
				// Add any locations for the city map
				//trace("adding locations");
				for (var lNode:XMLNode = Language.XMLData.GetNodeC(hNode.firstChild, "Locations"); lNode != null; lNode = lNode.nextSibling) {
					if (lNode.nodeType != 1 || lNode.nodeName.toLowerCase() != "location") continue;
					//trace("location: " + Language.XMLData.GetXMLStringParsed("Name", lNode.firstChild));
					if (!coreGame.ParseConditional(lNode, true, false)) continue;
					var posNode:XMLNode = Language.XMLData.GetNode(lNode.firstChild, "ShowCityMap");
					if (posNode == null) continue;
					
					// show location
					var evt:String = Language.XMLData.GetXMLString("Event", lNode.firstChild);
					if (evt == "") evt = plc.strNodeName;
					var mc:MovieClip = AddWalkLocation(plc, evt, "<font size='-6'>+ " + Language.XMLData.GetXMLStringParsed("Name", lNode.firstChild) + "</font>", Number(posNode.attributes.xpos), Number(posNode.attributes.ypos), Language.XMLData.GetXMLStringParsed("Description", lNode.firstChild));
					mc._visible = true;
				}
			}
		}		
		
		// Tentacle Icon
		if ((SMData.sTentacleExpert > 1 || coreGame.AssistantData.sTentacleExpert > 1) && coreGame.TentacleHaunt != -1) {
			mcTakeAWalkMenu.TentacleLocation._visible = coreGame.TentacleHaunt != 0;
			plc = GetPlaceInstance(int(coreGame.TentacleHaunt % 1000));
			var bNode:XMLNode = Language.XMLData.GetNode(plc.pNode, "WalkButton");
			var xpos:Number = Number(bNode.attributes.xpos);
			var ypos:Number = Number(bNode.attributes.ypos);
			var wid:Number = Number(bNode.attributes.width);
			var hei:Number = Number(bNode.attributes.height);

			mcTakeAWalkMenu.TentacleLocation._x = (xpos + wid) / 2;
			mcTakeAWalkMenu.TentacleLocation._y = ypos + hei - 100;
		}

		ShowMaps();
		
		coreGame.currPlace = null;
		mcTakeAWalkMenu.ChooseEvent.text = "";
		mcTakeAWalkMenu.ChooseEvent._visible = coreGame.SlaveDebugging;
		coreGame.mcMain.MainWindowButton._visible = false;
		mcTakeAWalkMenu._visible = true;
	}
	
	public function DoWalk(place:Number, specific:Object)
	{
		trace("DoWalk: " + place + " " + specific);
		coreGame.HouseEvents.PopCustomHouses();
		var plc:Place = GetPlaceInstance(place);
		if (!Language.GetXMLBooleanParsed("CanWalk", plc.pNode, true)) {
			Bloop();
			return;
		}

		Beep();
		ResetWalkLocations();
		if (coreGame.config.bZoomOn) coreGame.ShowMovie(coreGame.OnTopOverlayWhite, 0, 0);
		ShowSupervisor();
		mcTakeAWalkMenu._visible = false; 
		SetText("");
		coreGame.HideStatChangeIcons();
		ShowPlanningNext();
		coreGame.OldNumEvent = 0;
		coreGame.OldStrEvent = "";
		
		if (mcTakeAWalkMenu.ChooseEvent.text != "") specific = mcTakeAWalkMenu.ChooseEvent.text;
	
		coreGame.UseGeneric = (Math.floor(Math.random()*6) == 1);
		if (specific != undefined && specific != "" && specific != 0) SetEvent(specific);
		else {
			temp = Math.floor(Math.random()*100);
			ResetEventPicked();
		}
		
		coreGame.WalkPlace = place;
		if (coreGame.modulesList.TakeAWalk(place)) {
			if (IsEventAllowable()) coreGame.modulesList.AfterWalk(place);
			return;
		}
		if (coreGame.StrEvent != "" && coreGame.StrEvent.charAt(0) == "/") {
			coreGame.StrEvent = coreGame.StrEvent.substr(1);
			coreGame.DoEventNext();
			coreGame.modulesList.AfterWalk(place);
		} else DoWalkNow();
	}
	
	public function DoWalkNow() 
	{ 
		trace("DoWalkNow: " + coreGame.WalkPlace);
		coreGame.HouseEvents.PopCustomHouses();
		
		switch (coreGame.WalkPlace) {
			case 10.1: SlaveMarketAuction.VisitShop(); return;
			case 10.2: SlaveMarket.ViewExhibit(); return;
			case 10.3: SlaveMarket.ExhibitSlave(); return;
		}
		var plc:Place = GetPlaceInstance(coreGame.WalkPlace);
		//trace("plc = " + plc.Id);
		if (plc != null) plc.DoWalkEvent();
	}
	
	public function FindWalkPlaceImage(plc:Place, evt:String) : MovieClip
	{
		// Specific places for this city
		var i:Number = arWalkLocations.length;
		if (i == undefined) return null;
		
		var ch:MovieClip;
		while (--i >= 0) {
			ch = arWalkLocations[i];
			if (ch.plc == plc) {
				if (evt != undefined && ch.evt != evt) continue;
				return ch.plc;
			}
		}
		return null;
	}
	public function FindWalkPlaceImageString(s:String, evt:String) : MovieClip
	{
		var plc:Place = GetPlaceObject(s);
		if (plc == null) return null;
		return FindWalkPlaceImage(plc, evt);
	}
		
	public function WalkShortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean 
	{
		// Any custom houses
		if (keya > 48 && keya < 65) {
			var idx:Number = keya - 49;
			var chouse:HouseDetails = coreGame.HouseEvents.FindCustomHouseIdx(idx);
			if (chouse != null && chouse.mcBase._visible) {
				DoWalkHouse(-1 * (idx + 1));
				return true;
			}
			return false;
		}
		
		// Common to all cities
		switch(keya) {
			case 72: DoWalkHouse(Home.HouseType); return true;
			case 65: 
				if (SMData.BitFlagSM.CheckBitFlag(3)) {
					DoWalk(1, -2);
					return true;
				}
				return false;
			case 69: 
				if (SMData.BitFlagSM.CheckBitFlag(0)) {
					Seer.Visit(true);
					return true;
				}
				return false;
		}
		
		// Specific places for this city
		var i:Number = arWalkLocations.length;
		if (i != undefined) {
			var ch:MovieClip;
			while (--i >= 0) {
				ch = arWalkLocations[i];
				var shortal:Number = ch.short.charCodeAt(0);
				if (shortal > 96) shortal = shortal - 32;
				if (ch._visible && shortal == keya) {
					DoWalk(ch.place, ch.evt);
					return true;
				}
			}
		}
		return false;
	}
	
	public function DebugPlaces()
	{
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			AddText("\r\r<b>" + plc.strNodeName + "</b>: " + plc.Id + "\r");
			plc.ShowFlags();
		}
	}
	
	//
	// People
	// ------
	
	public function CreatePeople()
	{
		var nm:String;
		var id:Number;
		
		for (var hNode:XMLNode = Language.XMLData.GetNodeC("People"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "person") {
				nm = hNode.attributes.nodeid;
				id = Number(hNode.attributes.id);
				//trace("person: " + nm + " " + id + " " + isNaN(id));
				if (isNaN(id)) id = People.GetPersonsID(nm);
				//trace("person: " + nm + " " + id + " " + isNaN(id));
				if (id == 0) id = GetUniqueID();
				var per:Person = GetPersonsInstanceString(nm);
				if (per == null) per = GetPersonsInstanceNumber(id);
				if (per == null) {
					//trace("..new person");
					var can:Boolean = Language.GetXMLBooleanParsed("Accessible", hNode.firstChild, true);
					if (can) can = Language.XMLData.GetXMLBoolean("Visit/Accessible", hNode.firstChild, true);
					var mod:Number = Language.GetXMLValue("Lend/LendMod", hNode.firstChild, NaN);
					if (nm == "seer") {
						if (Seer == null) Seer = new PersonSeer(coreGame, this);
						per = Seer;
						can = false;
					} else per = new Person(nm, coreGame, id, mod == NaN ? 0 : mod, can, this);
					nm = Language.GetXMLString("Name", hNode.firstChild);
					if (nm != "") per.PersonName = nm;
					nm = Language.GetXMLString("Gender", hNode.firstChild);
					if (nm != "") per.PersonGender = coreGame.GetGender(nm);
					if (mod != NaN) per.DifficultyLendMod = mod;
					if (Language.GetXMLBooleanParsed("Noble", hNode.firstChild, true)) per.SetBitFlag(128);
				} else per.Id = id;
				if (per.strLocation == "") per.strLocation = Language.GetXMLString("Location", hNode.firstChild);
				if (per.ImageFolder == "") per.ImageFolder = Language.GetXMLString("Folder", hNode.firstChild);
				if (per.strCity == "") per.strCity = ModuleName;
			}
		}
		
		if (Seer == null) {
			Seer = new PersonSeer(coreGame, this);
			Seer.SetAccessible(false);
		}
	}
	
	public function FindPersonNodeByName(str:String) : XMLNode
	{
		// find the CHILD nodes for a given person
		var nm:String;
		str = str.toLowerCase().split(" ").join("");
		
		for (var hNode:XMLNode = Language.XMLData.GetNodeC("People"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "person") {
				nm = hNode.attributes.nodeid;
				if (nm.toLowerCase().split(" ").join("") == str) return hNode;
			}
		}
		
		var per:Person = GetPersonsInstance(str);
		if (per != null && per.strNodeName.toLowerCase() != str) return FindPersonNodeByName(per.strNodeName);
		return null;
	}
	
	public function FindPersonNodeCByName(str:String) : XMLNode
	{
		var rNode:XMLNode = FindPersonNodeByName(str);
		if (rNode == null) return rNode;
		return rNode.firstChild;
	}

	public function GetPersonObject(person) : Person { return GetPersonsInstance(person); }

	public function GetPersonsInstance(person) : Person
	{
		if (typeof(person) == "number") return GetPersonsInstanceNumber(person);
		else {
			var pn:Number = People.GetPersonsID(person);
			if (pn == 0) return GetPersonsInstanceString(person);
			else return GetPersonsInstanceNumber(pn);
		}
	}
	
	public function GetPersonsInstanceNumber(person:Number) : Person
	{
		//trace("GetPersonsInstanceNumber: " + person);
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.Id == person) {
				//trace("found " + per.strNodeName);
				per.SetSlave(_root);
				per.Supervise = coreGame.Supervise;
				return per;
			}
		}	
		if (person > 1003) return Person(coreGame.Owner);
		return null;
	}
	public function GetPersonsInstanceString(person:String) : Person
	{
		person = person.toLowerCase().split(" ").join("");
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.IsPerson(person)) {
				//trace("got them");
				per.SetSlave(_root);
				per.Supervise = coreGame.Supervise;
				return per;
			}
		}
		if (person == "owner") return Person(slaveData.Owner);
		return null;
	}
	
	public function GetPersonsID(person:String) : Number
	{
		var per:Person = GetPersonsInstanceString(person);
		if (per != null) return per.Id;
		return 0;
	}
	
	public function GetPersonsName(person) : String
	{
		var per:Person = GetPersonsInstance(person);
		if (per != null && per.PersonName != "") return per.PersonName;
		return isNaN(person) ? String(person) : Language.GetHtml("Person" + Number(person), "People");
	}
	
	public function ShowPerson(person, place, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var per:Person = People.GetPersonsObject(person);
		if (per == null) return false;
		return per.ShowThem(place, align, gframe, delay);
	}
	
	public function HidePerson(person:Object) : Boolean
	{
		return false;
	}
	
	public function DebugPeople()
	{
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			AddText("\r\r<b>" + GetPersonsName(per.Id) + " (" + per.strNodeName + ")</b>: " + per.Id + "\r");
			per.ShowFlags();
		}
	}
	
	public function HearGossip(person:Number, slut:Boolean, newg:Boolean)
	{
		coreGame.genNumber = person;
		coreGame.PersonName = People.GetPersonsName(person);
		//AddText("\r\r" + Language.GetHtml("Gossiping", "People") + "\r\r");
		//PersonSpeakStart("#person", "", true);
		//switch(People.GetGossip(newg, 16)) {
		//}
		//PersonSpeakEnd();
	}
	
	//
	// People - Visiting
	// -----------------
	
	public function ShowVisitLendCommon()
	{
		mcVisitMenu._visible = true;
		mcVisitMenu.tabChildren = true;
		coreGame.HideEquipmentButton();
		coreGame.HideSMEquipmentButton();
		Backgrounds.ShowBedRoom();
		coreGame.mcMain.MainWindowButton._visible = false;
		Beep();
		
		// button functions
		var ti:City = this;
		mcVisitMenu.CustomPerson1.ActButton.onPress = function() { ti.DoVisit(-1); }
		mcVisitMenu.CustomPerson2.ActButton.onPress = function() { ti.DoVisit(-2); }
		mcVisitMenu.CustomPerson3.ActButton.onPress = function() { ti.DoVisit(-3); }
		mcVisitMenu.CustomPerson4.ActButton.onPress = function() { ti.DoVisit(-4); }
		mcVisitMenu.CustomPerson5.ActButton.onPress = function() { ti.DoVisit(-5); }
		mcVisitMenu.CustomPerson6.ActButton.onPress = function() { ti.DoVisit(-6); }
		mcVisitMenu.CustomPerson7.ActButton.onPress = function() { ti.DoVisit(-7); }
		mcVisitMenu.CustomPerson8.ActButton.onPress = function() { ti.DoVisit(-8); }
		
		for (var i:Number = 1; i < 13; i++) mcVisitMenu["Person" + i]._visible = false;
		
		// People
		var per:Person;
		var btn:Number = 1;
		var strlabel:String;
		var strJoin:String = Language.GetHtml("VisitJoin", "Visits");
		
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (!per.IsAccessible()) continue;
			
			var bstr:String = "Person" + btn;
			mcVisitMenu[bstr].ActButton.onPress = function() { ti.DoVisit(this._parent.Id); }
			mcVisitMenu[bstr].Id = per.Id;
			strlabel = People.GetPersonsName(per.Id) + "\r<font size='-6'>" + strJoin + " " + Language.GetXMLStringSimple("Title", per.xNode, per.strNodeName + "</font>");
			
			coreGame.SetButtonDetails(mcVisitMenu[bstr], false, true, strlabel, undefined, btn + "");
			mcVisitMenu[bstr]._visible = true;
			btn++;
			if (btn > 12) break;
		}
		
		// General GuildMember
		mcVisitMenu.GuildMember.ActButton.onPress = function() { ti.DoVisit(49); }
		coreGame.SetButtonDetails(mcVisitMenu.GuildMember, false, true, People.GetPersonsName(49), undefined, "G");

		
	}
	
	public function ShowVisitMenu(special:Boolean)
	{
		//ServantSpeak("You will take #slave to visit a noted person in the city. This could improve #slavehisher reputation and can educate #slavehimher.\r\rThe people are ones you know or that #slave met and is willing to meet #slavehimher.");
		ServantSpeak(Language.GetHtml("VisitIntro", "Visits"));
	
		mcVisitMenu.LendLabel._visible = false;
		mcVisitMenu.VisitLabel._visible = true;
		
		if (IsDayTime()) Backgrounds.ShowSky(3);
		else Backgrounds.ShowNight();
		
		mcVisitMenu.GuildMember._visible = false;
		ShowVisitLendCommon();
		
		ShowPlanningNext();
		
		mcVisitMenu.Title.htmlText = Language.GetHtml("Visit", Language.actNode, true);
		mcVisitMenu.Description.htmlText = Language.GetHtml("VisitDescription", "Visits", true);
	
		coreGame.modulesList.DoVisitSelect();

	}
	
	// Visit a person (common to all people)
	public function DoVisit(person:Number, walk:Boolean)
	{
		trace("City.DoVisit " + person);
		coreGame.VisitLendPerson = person;
		var lending:Boolean = coreGame.LendPerson == -1000;
		var loaned:Person = GetPersonsInstance(person);
		if (loaned != null) {
			coreGame.PersonGender = loaned.PersonGender;
			coreGame.PersonName = loaned.PersonName;
			coreGame.GetPersonGenderText(coreGame.PersonGender);
			if ((!lending) && loaned.IsVisitedToday()) {
				ServantSpeak(strReplace(Language.GetHtml("TwoVisits", "Visits"), "#value", People.GetPersonsName(person)));
				Bloop();
				return;
			}
			coreGame.EventTotal = loaned.TotalVisit;
		} else coreGame.EventTotal = 1;
		coreGame.UseGeneric = false;
		
		Beep();
		coreGame.VisitMenu._visible = false;
		coreGame.HideDresses();
		SetText("");
		coreGame.HideStatChangeIcons();
		SMData.ShowSlaveMaker();
		
		if (lending) {
			if (coreGame.SlaveGirl.DoLendHerOffer(person) == true) return;
		} else {
			coreGame.mcMain.MainWindowButton._visible = true;
			if (coreGame.modulesList.DoVisit(person)) return;
		}
		
		var visited:Boolean;
		if (person < 0) visited = DoVisitCustomPerson(person);
		else visited = DoVisitNow(person, walk);
		
		if (visited) {
			coreGame.TotalVisit++;
			coreGame.NobleLoveEvent(person, person != 8);
		}
		if (lending) {
			DoEvent(9704);
			if (coreGame.LendPerson == -1000) coreGame.LendPerson = person;
		} else ShowPlanningNext();
	}
	
	// probably obsolete
	public function DoVisitNow(per:Number, walk:Boolean) : Boolean
	{
		ResetWalkLocations();
		
		if (per == 49) return DoVisitGuildMember(); 
		else if (per == 32) return Seer.Visit(walk);  
		
		var person:Person = GetPersonsInstance(per);
		//trace("City.DoVisitNow " + per + " " + person);
		return person.DoVisitNow(walk);
	}
		
	//
	// People - Lending
	// ----------------
	
	public function ShowLendMenu()
	{
		coreGame.HideMainButtons();
		coreGame.HideImages();
		HideBackgrounds();
		coreGame.Items.HideItems();
		coreGame.ShowLeaveButton();
		coreGame.LendPerson = -1000;
		coreGame.MorningEveningMenu._visible = false;
		mcVisitMenu.LendLabel._visible = true;
		mcVisitMenu.VisitLabel._visible = false;
		
		mcVisitMenu.GuildMember._visible = true;
		ShowVisitLendCommon();
			
		mcVisitMenu.Title.htmlText = Language.GetHtml("Lend", Language.actNode, true);
		mcVisitMenu.Description.htmlText = Language.GetHtml("LendDescription", "Visits", true);
				
		ShowDress();
	
		coreGame.modulesList.DoLendSelect();	
	}
	
	public function DoLend()
	{
		coreGame.HideDresses();
		coreGame.VisitLendPerson = coreGame.LendPerson;
		var mod:Number = 0;
		var loaned:Person = GetPersonsInstance(coreGame.LendPerson);
		if (loaned != null) {
			coreGame.PersonGender = loaned.PersonGender;
			coreGame.PersonName = loaned.PersonName;
			coreGame.GetPersonGenderText(coreGame.PersonGender);
		}
			
		if (loaned != null) mod = loaned.DifficultyLendMod;
		mod = AdjustLoaningMod(mod);
		
		if (coreGame.TestObedience(coreGame.DifficultyLendHer + mod, coreGame.Action)) {
					
			coreGame.LevelUpSexAct(coreGame.Action);
			coreGame.HideAllPeople();
			coreGame.TotalLendHer++;
			if (coreGame.TotalLendHer == 1) coreGame.DifficultyLendHer = coreGame.DifficultyLendHer-5;
			
			if (coreGame.modulesList.DoLendHer(coreGame.LendPerson) == true) {
				coreGame.LendPerson = 0;
				return;
			}
			
			if (coreGame.AppendActText && coreGame.StandardDGText && coreGame.DickgirlChanged && (!coreGame.SlaveGirl.IsDickgirl())) {
				var pretext:String = strReplace(Language.GetHtml("LendingCockGrow", "Visits"), "#value", People.GetPersonsName(coreGame.LendPerson)) + "\r\r";
				AddTextToStart(pretext);
			}
	
			if (loaned != null) loaned.TotalLend++;
			
			if (coreGame.LendPerson < 0) DoLendCustomPerson(coreGame.LendPerson * -1);
			else DoLendNow(coreGame.LendPerson);
			coreGame.NobleLoveEvent(coreGame.LendPerson, coreGame.LendPerson != 8);
			
		} else {
			coreGame.Refused(16, "", Language.GetHtml("LendingRefused", "Visits"), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -10, -1, 0, 0, -1, -2, 0);
		}
		coreGame.LendPerson = 0;
	}
	
	public function AdjustLoaningMod(mod:Number) : Number { return mod; }

	
	public function DoLendNow(per:Number) : Boolean
	{
		if (per == 49) {
			DoLendGuildMember();
			return true;
		}
		var person:Person = GetPersonsInstance(per);
		return person.DoLendNow();
	}
	
	public function VisitLendShortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 49:
				if (mcVisitMenu.CustomPerson1._visible) {
					DoVisit(-1);
					return true;
				}
				return false;
			case 50:
				if (mcVisitMenu.CustomPerson2._visible) {
					DoVisit(-2);
					return true;
				}
				return false;
			case 51:
				if (mcVisitMenu.CustomPerson3._visible) {
					DoVisit(-3);
					return true;
				}
				return false;
			case 52:
				if (mcVisitMenu.CustomPerson4._visible) {
					DoVisit(-4);
					return true;
				}
				return false;
			case 53:
				if (mcVisitMenu.CustomPerson5._visible) {
					DoVisit(-5);
					return true;
				}
				return false;
			case 54:
				if (mcVisitMenu.CustomPerson6._visible) {
					DoVisit(-6);
					return true;
				}
				return false;
			case 55:
				if (mcVisitMenu.CustomPerson7._visible) {
					DoVisit(-7);
					return true;
				}
				return false;
			case 56:
				if (mcVisitMenu.CustomPerson8._visible) {
					DoVisit(-8);
					return true;
				}
				return false;		
			case 71:
				if (mcVisitMenu.GuildMember._visible) {
					DoVisit(49);
					return true;
				}
				return false;	
		}	
		return false;
	}

	
	//
	// People - General Meeting
	// ------------------------
	
	public function MeetPerson(personno:Number, choice:Number, personstr:String, say:String, evt:String) : Boolean
	{ 
		var per:Person = GetPersonsInstance(personno);
		if (per != null) return per.Meeting(choice, say);
		per = GetPersonsInstanceString(personstr);
		if (per != null) return per.Meeting(choice, say);
		return false;
	}
	

	//
	// People - Generic Individuals
	// ----------------------------
	
	// Guild Member
	public function DoVisitGuildMember() : Boolean
	{
		coreGame.ShowPerson(49, 1, 0, 1);
		
		SetSlaveDetails(_root);

		if (coreGame.LendPerson == -1000) {
			// You will make arrangements to loan #slave to #
			Language.XMLGeneral("Visits/LendGuildMember/LendArranged");
			return false;
		}
		Language.XMLData.XMLGeneral("Visits/VisitGuildMember/NormalVisit");
		return false;
	}
	
	
	public function DoLendGuildMember()
	{
		coreGame.ShowPerson(49, 0, 0, 1); 
	
		if (coreGame.SlaveGirl.ShowActLend(49) == false) coreGame.UseGeneric = true;
		// obsolete versions
		coreGame.SlaveGirl.ShowSexActLendHer();
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.ShowActImage();
	
		if (IsDayTime()) Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		if (coreGame.AppendActText) {
			Language.XMLData.XMLGeneral("Visits/LendGuildMember/NormalLend");
		}
	}
	
	// The cities swimming instructor
	public function MeetSwimInstructor()
	{
		GetPerson("SwimInstructor").Meeting(0);
	}

	
	
	//
	// Slave/Event specific Custom Person
	// ----------------------------------

	public function ShowCustomVisitPerson(pname:String, person:Number)
	{
		if (person == undefined) person = 1;
		coreGame.SetButtonDetails(mcVisitMenu["CustomPerson" + person], false, true, pname, undefined, person + "");
		mcVisitMenu["CustomPerson" + person]._visible = true;
	}
	
	public function HideCustomVisitPerson(person:Number)
	{
		if (person == undefined) person = 1;
		mcVisitMenu["CustomPerson" + person]._visible = false;
	}
		
	public function DoVisitCustomPerson(person:Number) : Boolean
	{
		if (person == undefined) person = 1;
		else person = Math.abs(person);
		
		var pname:String = mcVisitMenu["CustomPerson" + person].alabel;
		var per:Person = GetPersonsInstance(pname);
		if (per != null) coreGame.EventTotal = per.TotalVisit;
		else coreGame.EventTotal = 0;
		
		//If checking if you can lend to them
		if (coreGame.LendPerson == -1000) {
			if (!CheckBitFlag(person)) {
				// usual message
				// You should at least take #slave to visit #person before trying to lend #slave to her.
				if (Language.XMLData.XMLGeneral("Visits/VisitCustomPerson" + person + "/VisitFirst")) coreGame.LendPerson = 0;
				else if (Language.XMLGeneral("Visits/VisitCustomPerson/VisitFirst")) coreGame.LendPerson = 0;
				if (coreGame.LendPerson == 0) return false;
			}
			// usual message
			// You will make arrangements to loan #slave to #
			if (Language.XMLData.XMLGeneral("Visits/VisitCustomPerson" + person + "/LendArranged")) return false;
			Language.XMLData.XMLGeneral("Visits/VisitCustomPerson/LendArranged");
			return false;
		}

		SetBitFlag(person);
		var bRet:Boolean = coreGame.SlaveGirl.DoVisitCustomPerson(person);
		if (bRet != true) bRet = false;
		
		if (!bRet) bRet = Language.XMLData.XMLGeneral("Visits/VisitCustomPerson" + person + "/NormalVisit");
		if (!bRet) bRet = Language.XMLData.XMLGeneral("Visits/VisitCustomPerson/NormalVisit");
		if (bRet && per != null) per.TotalVisit++;
		return bRet;
	}
	
	public function DoLendCustomPerson(person:Number)
	{
		if (person == undefined) person = 1;
		else person = Math.abs(person);
		
		var pname:String = mcVisitMenu["CustomPerson" + person].alabel;
		var per:Person = GetPersonsInstance(pname);
		if (per != null) coreGame.EventTotal = per.TotalLend;
		else coreGame.EventTotal = 0;

		SetBitFlag(person);

		if (!Language.XMLData.XMLGeneral("Visits/LendCustomPerson" + Math.abs(person )+ "/LendStart")) Language.XMLData.XMLGeneral("Visits/LendCustomPerson/LendStart");
		BlankLine();
		
		if (IsEventAllowable() == false || coreGame.NextEvent._visible || coreGame.VisitLendPerson == 0) return false;

		var bRet:Boolean = coreGame.SlaveGirl.DoLendCustomPerson(person);
		if (bRet != true) bRet = false;
		if (!bRet) bRet = Language.XMLData.XMLGeneral("Visits/LendCustomPerson" + person + "/NormalLend");
		if (!bRet) bRet = Language.XMLData.XMLGeneral("Visits/LendCustomPerson/NormalLend");
		if (bRet && per != null) per.TotalLend++;	
		return bRet;
	}
	
	
	//
	// Contests
	// --------
	
	public function DoContestsNext(numcontest:Number, actno:Number) : Boolean
	{
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.DoContestsNext(numcontest, actno)) return true;
		}
		return false;
	}
	
	// City specific trainings
	
	public function DoMartialTraining() : Boolean
	{
		// Common part of the training
		SMData.TotalSMMartial++;
		
		AddLangText("MartialTrainingStart", "SlaveMaker/Training");
		BlankLine();
		
		if (Language.XMLData.DoXMLAct("MartialTraining")) return true;
		
		return false;
	}
	
	public function DoSMSleazyBar()
	{
		var bWork:Boolean = SMData.SMAdvantages.CheckBitFlag(4);
		if (coreGame.slaveData.ActInfoBase.IsActDefinedByName("smjobsleazybar")) bWork = true;
	
		if (bWork) Language.XMLData.DoXMLAct("RelaxOrWorkAtSleazyBar");
		else DoRelaxSleazyBar();
	}

	public function DoRelaxSleazyBar() : Boolean
	{
		Backgrounds.ShowBar();
		SMMoney(-10);
		SMData.TotalSMSleazyBar++;
		
		if (Language.XMLData.DoXMLAct("RelaxAtSleazyBar")) return true;
	
		if (SMData.ShowSlaveMaker(-2510, 1, 1) == undefined) ShowMovie(coreGame.Generic.mcBase.SMTrainingSleazyBar, 1, 1, 1);
	
		// Generic text
		AddText("You visit the sleazy bar and watch the shows. You consider tipping a girl for a 'special' performance.");
		
		SMData.SMPoints(0, 0, 0, 0, 0.5, -2, 0, 0, 0, 0, -0.5, 0.5, 1);
		
		return false;
	}
	
	public function DoSMJob(job:Number) : Boolean
	{
		return false;
	}

	
	//
	// Houses
	// ------
	
	public function DoWalkHouse(house:Number)
	{
		trace("City.DoWalkHouse: " + house);
		coreGame.HouseEvents.PopCustomHouses();
		Beep();
		ShowSupervisor();
		SetText("");
		coreGame.HideStatChangeIcons();
		mcTakeAWalkMenu._visible = false; 
		if (house >= 0) coreGame.TotalWalkHouse++
		else coreGame.TotalWalkCustom++;
		coreGame.WalkPlace = 0;
	
		delete Language.XMLData.tempVars;
		Language.XMLData.tempVars = new Array();
		Language.XMLData.tempVars.push(0);
		
		if (coreGame.modulesList.DoWalkHouse(house)) {
			coreGame.modulesList.AfterWalk(house < 0 ? -999 + house  : 0);
			ShowPlanningNext();
			return;
		}
		
		var chouse:HouseDetails;
		if (house >= 0) chouse = coreGame.currentCity.Home;
		else chouse = coreGame.HouseEvents.FindCustomHouseIdx((house + 1) * -1);
		//trace("chouse = " + chouse + " " + chouse.Id + " " + chouse.strNodeName);
		
		chouse.TotalVisit++;
		coreGame.EventTotal = chouse.TotalVisit;
		
		var eNode:XMLNode = Language.XMLData.GetNode(Language.walkNode, chouse.strNodeName);
		if (eNode == null) eNode = Language.XMLData.GetNode(Language.XMLData.evtNode, chouse.strNodeName);
		if (eNode == null && house >= 0) eNode = Language.XMLData.GetNode(Home.xNode, "WalkEvent");
		//trace("eNode = " + eNode);
		if (Language.XMLData.XMLEventByNode(eNode)) {
			coreGame.modulesList.AfterWalk(house < 0 ? -999 + house  : 0);
			ShowPlanningNext();
			return;
		}
		coreGame.HidePlanningNext();
		mcTakeAWalkMenu._visible = true; 
	}
	
	function HouseHint()
	{
		ServantSpeak(Language.GetHtml("HouseHint", "Housing") + Home.HouseName);
		AddText("\r\r" + coreGame.SlaveMakerHousing.HouseDescriptionText.text + "\r\r" + coreGame.SlaveMakerHousing.HouseDetails.text + "\r\r");
	}
	
	
	//
	// Shopping
	// --------
	
	public function CreateShops() 
	{		
		var nm:String;
		var id:Number;
		var strStart:String = GetStartingArea();
		
		for (var hNode:XMLNode = Language.XMLData.GetNodeC("Shopping/Shops"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();

			var shp:Shop = GetShopInstanceString(nm);
			//trace("Shop: " + nm + " " + shp);
			if (shp == null) {
				if (nm == "armoury" && Armoury == null) {
					Armoury = new ShopArmoury(coreGame.ArmouryMenu, coreGame, this);
					shp = Armoury;
				} else if (nm == "salon" && Salon == null) {
					Salon = new ShopSalon(coreGame.SalonMenu, coreGame, this);
					shp = Salon;
				} else if (nm == "shop" && GeneralShop == null) {
					GeneralShop = new ShopGeneralShop(coreGame.ShopMenu, coreGame, undefined, this);
					shp = GeneralShop;	
				} else if (nm == "dealer" && Dealer == null) {
					Dealer = new ShopDealer(coreGame.DealerMenu, coreGame, this);
					shp = Dealer;					
				} else if (nm == "itemsalesman" && ItemSalesman == null) {
					ItemSalesman = new ShopItemSalesman(coreGame.ItemSalesmanMenu, coreGame, this);
					shp = ItemSalesman;	
				} else if (nm == "stables" && Stables == null) {
					Stables = new ShopStables(coreGame, this);
					shp = Stables;
				} else if (nm == "tailors" && Tailors == null) {
					Tailors = new ShopTailor(coreGame, this);
					shp = Tailors;
				} else if (nm == "slaveauction" && SlaveMarketAuction == null) {
					SlaveMarketAuction = new ShopSlaveMarketMinor(coreGame.SlavePurchase, coreGame, this);
					shp = SlaveMarketAuction;								
				} else shp = new ShopGeneric(coreGame, "Shopping/Shops/" + nm, this);
			}
			if (shp.strShopKeeper == "") shp.strShopKeeper = Language.GetXMLString("Shopkeeper", hNode.firstChild);
			if (shp.ImageFolder == "") shp.ImageFolder = Language.GetXMLString("Folder", hNode.firstChild);
			if (shp.strArea == "") shp.strArea = Language.GetXMLString("Area", hNode.firstChild, strStart);

		}
		
		if (Armoury == null) Armoury = new ShopArmoury(coreGame.ArmouryMenu, coreGame, this);
		if (Salon == null) Salon = new ShopSalon(coreGame.SalonMenu, coreGame, this);
		if (GeneralShop == null) GeneralShop = new ShopGeneralShop(coreGame.ShopMenu, coreGame, undefined, this);
		if (Dealer == null) Dealer = new ShopDealer(coreGame.DealerMenu, coreGame, this);
		if (ItemSalesman == null) ItemSalesman = new ShopItemSalesman(coreGame.ItemSalesmanMenu, coreGame, this);
		if (Stables == null) Stables = new ShopStables(coreGame, this);
		if (Tailors == null) Tailors = new ShopTailor(coreGame, this);
		if (SlaveMarketAuction == null) SlaveMarketAuction = new ShopSlaveMarketMinor(coreGame.SlavePurchase, coreGame, this);
		//coreGame.Dealer = Dealer;
		//coreGame.ItemSalesman = ItemSalesman;
		//coreGame.Stables = Stables;
		//coreGame.Tailors = Tailors;
		//coreGame.SlaveMarketAuction = SlaveMarketAuction;
		//coreGame.Armoury = Armoury;
		//coreGame.Salon = Salon;

	}
	
	public function Shopping(shop:String, resume:Boolean) : Boolean
	{
		trace("Shopping: " + shop);
		var shp:Shop = GetShopInstanceString(shop);
		if (shp == null) return false;
		
		if (resume == true) shp.ShowShopContents();
		else shp.VisitShop();
		return true;
	}
	
	public function GetShopInstanceString(str:String) : Shop
	{
		str = str.split(" ").join("").toLowerCase();
		var ar:Array = str.split("/");
		str = ar[ar.length - 1];
		if (str == "shop") {
			trace("GeneralShop = " + GeneralShop);
			return GeneralShop;
		}
		
		var shp:Shop;
		
		for (var so:String in arShops) {
			shp = arShops[so];
			ar = shp.strNodeName.split(" ").join("").toLowerCase().split("/");
			if (ar[ar.length - 1] == str) return shp;
		}
		return null;
	}
	
	public function GetShopInstance(sno:Number) : Shop
	{
		if (sno < arShops.length) return arShops[sno];
		return null;
	}
	
	public function FindShopNodeByName(str:String) : XMLNode
	{
		// find the CHILD nodes for a given shop
		var nm:String;
		str = str.toLowerCase().split(" ").join("");

		
		for (var hNode:XMLNode = Language.XMLData.GetNodeC("Shopping/Shops"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm.toLowerCase().split(" ").join("") == str) return hNode;
		}
		
		var shp:Shop = GetShopInstanceString(str);
		if (shp != null && shp.strNodeName.toLowerCase() != str) return FindShopNodeByName(shp.strNodeName);
		return null;
	}
	
	public function FindShopNodeCByName(str:String) : XMLNode
	{
		var rNode:XMLNode = FindShopNodeByName(str);
		if (rNode == null) return rNode;
		return rNode.firstChild;
	}
	
	public function DebugShops()
	{
		var shp:Shop;
		for (var so:String in arShops) {
			shp = arShops[so];
			AddText("\r\rShop:\r<b>" + shp.strNodeName + "</b>: " + shp.strShopKeeper + "\r");
			//shp.ShowFlags();
		}
	}
	
	
	//
	// Items
	// -----
	
	public function ShowOtherEquipment()
	{
		var shp:Shop;
		for (var so:String in arShops) {
			shp = arShops[so];
			shp.ShowOtherEquipment();
		}
	}
	
	public function ShowOtherSMEquipment()
	{
		var shp:Shop;
		for (var so:String in arShops) {
			shp = arShops[so];
			shp.ShowOtherSMEquipment();
		}
	}
	
	
	//
	// Images
	// ------
	
	public function HideImages()
	{
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			plc.HideImages();
		}
		
		super.HideImages();
	}
	
	
	//
	// Events
	// ------
	
	public function DoEventYes() : Boolean
	{
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			if (plc.DoEventYes()) return true;
		}
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.DoEventYes()) return true;
		}
		return false;
	}
	
	public function DoEventNo() : Boolean
	{
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			if (plc.DoEventNo()) return true;
		}
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.DoEventNo()) return true;
		}	
		return false;
	}
	
	public function DoEventNext() : Boolean
	{
		if (coreGame.StrEvent == "VisitSeer" || coreGame.StrEvent == "/VisitSeer") {
			DoVisitNow(32, true);
			coreGame.modulesList.AfterEventNext();
			return true;
		} else if (coreGame.StrEvent == "VisitDealer" || coreGame.StrEvent == "/VisitDealer") {
			Dealer.VisitShop();
			coreGame.modulesList.AfterEventNext();
			return true;
		} else if (coreGame.StrEvent == "FindDealer") {
			Dealer.FindShop();
			coreGame.modulesList.AfterEventNext();
			return true;							
		} 
		
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			if (plc.DoEventNext()) return true;
		}
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.DoEventNext()) return true;
		}		
		return false;
	}

	
	//
	// Date/Time
	// ---------
	
	public function NewDay(nDays:Number)
	{
		for (var i = 1; i < 9; i++) ClearBitFlag(i);
		
		var plc:Place;
		for (var so:String in arPlaces) {
			plc = arPlaces[so];
			plc.NewDay(nDays);
		}
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			per.NewDay(nDays);
		}		
	}

	public function LocateTentacles() : Boolean
	{
		trace("LocateTentacles");
		if (Language.XMLData.XMLEvent("LocateTentacles", false)) return true;
		 
		// Check Places that are accessible and tentacle possible
		 
		return false;
	}
	
	public function UpdateDateAndItems(nDays:Number)
	{
		// Tentacle location
		coreGame.TentacleHaunt = -1;
		if (coreGame.Options.TentaclesOn == 1) {
			var tempFrequency:Number = (coreGame.TentacleFrequency * 2) / 3;
			if (coreGame.AssistantTentacleFrequency != -1) tempFrequency = coreGame.AssistantTentacleFrequency;
			if (coreGame.MoonPhaseDate == 15) tempFrequency = 100;
			else if (coreGame.MoonPhaseDate > 13 && coreGame.MoonPhaseDate < 17) tempFrequency = coreGame.TentacleFrequency * 2;
			if (coreGame.Difficulty == -1) tempFrequency = 0; 
			var rnd:Number = Math.floor(Math.random()*100);
			if (rnd <= tempFrequency) 
			LocateTentacles();
		}
	}

	
	//
	// Endings
	// -------
	
	public function EndingStart() : Boolean
	{
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.EndingStart(coreGame.Score) == true) return true;
		}
		return false;
	}
	
	public function EndingFinish() : Boolean
	{
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			if (per.EndingFinish(coreGame.Score) == true) return true;
		}
		return false;
	}
	
	public function AfterEndingFinish()
	{
		var per:Person;
		for (var so:String in arPeople) {
			per = arPeople[so];
			per.AfterEndingFinish();
		}
	}
	
	
	// Items
	
	public function ShowItem(item:Number, place:Number, align:Number, gframe:Number) : Boolean
	{
		for (var so:String in arShops) {
			var shp:Shop = arShops[so];
			if (shp.ShowItem(item, place, align, gframe)) return true;
		}
		return false;
	}
	
	public function ShowItemDescription(item:Number) : Boolean
	{
		for (var so:String in arShops) {
			var shp:Shop = arShops[so];
			if (shp.ShowItemDescription(item)) return true;
		}		
		return false;
	}


	//
	// Load/Save
	// ---------
	
	public function Load(so:Object, bso:Object)
	{
		trace("City.Load");
		if (so.bCurrent == undefined) return;
		
		CreatePeople();
		CreatePlaces();
		CreateShops();
		
		ModuleName = so.CityName;
		bCurrent = so.bCurrent;
		if (so.strCurrentArea == undefined) strCurrentArea = "";
		else strCurrentArea = so.strCurrentArea;
		
		Home.Load(so.Home);
				
		var sobj:Object;
		for (var si:String in so.Places) {
			sobj = so.Places[si];
			if (ModuleName == "Mardukane" && sobj.Id == 6) sobj.Id = 6.1;	// Upgrade for 3.4.01 saves
			if (sobj.strNodeName == "undefined" || sobj.strNodeName == undefined || sobj.strNodeName == "") continue;		// fix some limited data corruptions
			if (sobj.strNodeName == "Beach" && ModuleName == "Mardukane") continue;
			if (sobj.strNodeName == "Docks" && ModuleName == "Mardukane") continue;
			var plc:Place = GetPlaceObjectBase(sobj.strNodeName);
			if (plc == null) plc = GetPlaceInstance(sobj.Id);
			if (plc == null) continue; //plc = new Place(sobj.strNodeName, null, coreGame, GetUniqueID(), true, "", 0, 0, this);
			if (isNaN(plc.Id) || plc.Id == 0) plc.Id = GetUniqueID();
			plc.Load(sobj);
		}
		for (var si:String in so.People) {
			sobj = so.People[si];
			if (sobj.strNodeName == "undefined" || sobj.strNodeName == undefined) continue;		// fix some limited data corruptions
			var per:Person = null;
			if (sobj.strNodeName != "") per = GetPersonsInstanceString(sobj.strNodeName);
			if (per == null) per = GetPersonsInstance(sobj.Id);
			if (per == null) continue;
				//per = new Person(sobj.strNodeName, coreGame, 0, 0, false, this);
				//per.strCity = ModuleName;
			//}
			if (isNaN(per.Id) || per.Id == 0) per.Id = GetUniqueID();
			per.Load(sobj);
		}
		for (var si:String in so.Shops) {
			sobj = so.Shops[si];
			if (sobj.strNodeName == "undefined" || sobj.strNodeName == undefined || sobj.strNodeName == "") continue;		// fix some limited data corruptions
			var shp:Shop = GetShopInstanceString(sobj.strNodeName);
			if (shp == null) continue; //shp = new ShopGeneric(coreGame, sobj.strNodeName, this);
			shp.Load(sobj);
		}
	}
	
	public function Save(so:Object)
	{
		so.CityName = ModuleName;
		so.bCurrent = bCurrent;
		so.strCurrentArea = strCurrentArea + "";
		
		delete so.Home;
		so.Home = new Object();
		Home.Save(so.Home);
		
		so.Places = new Array;
		for (var si:String in arPlaces) {
			var plc:Place = arPlaces[si];
			var obj:Object = new Object;
			plc.Save(obj);
			so.Places.push(obj);
		}
		so.People = new Array;
		for (var si:String in arPeople) {
			var per:Person = arPeople[si];
			var obj:Object = new Object;
			per.Save(obj);
			so.People.push(obj);
		}
		so.Shops = new Array;
		for (var si:String in arShops) {
			var shp:Shop = arShops[si];
			var obj:Object = new Object;
			shp.Save(obj);
			so.Shops.push(obj);
		}
	}

}
