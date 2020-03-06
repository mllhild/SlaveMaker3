// Housing - class defining your current home
// Translation status: COMPLETE

import Scripts.Classes.*;
class HouseDetails extends Place {
	public var HouseType:Number;			// type of the house. An index into the list of <Houses> in Housing.xml
	public var HouseName:String;			// the name of the house
	public var CityName:String;				// name of the city the house is in
	public var AreaName:String;				// name of the area of the city the house is in
	
	public var Price:Number;				// purchase price of the house

	public var DaysOccupied:Number;			// total days you have lived in the home
	
	// Cost of living
	public var hIncome:Number;				// GP per day this house earns
	public var hUpkeep:Number;				// GP per day required to occupy the home

	// required levels of security and home maintenance/cleaning for the house
	public var BaseHouseWork:Number;
	public var BaseSecurity:Number;
	public var ActualHouseWork:Number;
	public var ActualSecurity:Number;
	public var ActualCooking:Number;

	// following are facilities of the house. 
	
	// The number represents quality of the facility
	// 0 = not present
	// 1 = standard
	// 2 = food quality
	// 3 = excellent quality
	public var hKitchen:Number;			
	public var hLibrary:Number;
	public var hDungeon:Number;
	public var hWards:Number;
		
	// no quality, just present or not
	public var hStables:Boolean;
	public var hMilkBarn:Boolean;
	
	// House qualities, a comma-separated list of qualities, can be arbitrary
	// Some set values
	// "TentacleSafe" - is the house currently guarded against tentacles
	// "Navigable" - can be sailed/flown etc from place to place
	// Otherwise these can be considered an arbitrary set of flags for the house
	public var strQualities:String;
		
	// The rooms of the house
	public var totRooms:Number;			// total current rooms
	public var maxRooms:Number;			// maximum possible rooms after upgraded/renovations
		
	// when a background is shown using ShowBath(), ShowBedRoom() etc, these are the selected frames
	// shown for the current house
	public var HomeRoom:Number;
	public var HomeBath:Number;
	public var HomeDungeon:Number;
	public var HomeKitchen:Number;

	public var bPushState:Boolean;
	
	
	// Constructor
	public function HouseDetails(type, cg:Object) { 
		super("", null, cg, 0, true, "", 0, 0);

		//SMTRACE("HouseDetails() " + cg);
		HouseType = type;
		hKitchen = 0;
		hLibrary = 0;
		hDungeon = 0;
		hWards = 0;
		hIncome = 0;
		hUpkeep = 0;
		HomeRoom = 0;
		HomeBath = 0;
		HomeDungeon = 0;
		HomeKitchen = 0;
		DaysOccupied = 0;
		hStables = false;
		hMilkBarn = false;
		totRooms = 0;
		maxRooms = 0;
		BaseHouseWork = 0;
		BaseSecurity = 0;
		Price = 0;
		HouseName = "";
		ImageFolder = "";
		CityName = "Mardukane";		// NOTE: not a translated name, but intended as a class instance
		AreaName = "";
		ActualHouseWork = 0;
		ActualSecurity = 0;
		ActualCooking = 0;
		strQualities = SMData.sTentacleExpert != 0 ? "TentacleSafe" : "";
		bPushState = undefined;

		if (!isNaN(type)) InitialiseHouseByNumber(type);
		else InitialiseHouseByName(type);
	}
	
	// Load game
	public function Load(lo:Object)
	{
		super.Load(lo);

		HouseType = lo.HouseType;
		HouseName = lo.HouseName;
		DaysOccupied = lo.DaysOccupied;
		if (DaysOccupied == undefined) DaysOccupied = 1;
		
		hKitchen = lo.hKitchen;
		hLibrary = lo.hLibrary;
		hDungeon = lo.hDungeon;
		hWards = lo.hWards;
		hIncome = lo.hIncome;
		HomeRoom = lo.HomeRoom;
		HomeBath = lo.HomeBath;
		HomeDungeon = lo.HomeDungeon;
		HomeKitchen = lo.HomeKitchen;
		hStables = lo.hStables;
		totRooms = lo.totRooms;
		if (totRooms == undefined) totRooms = 0;
		maxRooms = lo.maxRooms;
		if (maxRooms == undefined) maxRooms = totRooms;
		hMilkBarn = lo.hMilkBarn;
		if (hMilkBarn == undefined) hMilkBarn = false;
		
		BaseHouseWork = lo.BaseHouseWork;
		if (BaseHouseWork == undefined) BaseHouseWork = 0;
		BaseSecurity = lo.BaseSecurity;
		if (BaseSecurity == undefined) BaseSecurity = 0;
		ActualHouseWork = lo.ActualHouseWork;
		if (ActualHouseWork == undefined) ActualHouseWork = 0;
		ActualSecurity = lo.ActualSecurity;
		if (ActualSecurity == undefined) ActualSecurity = 0;
		ActualCooking = lo.ActualCooking;
		if (ActualCooking == undefined) ActualCooking = 0;	

		strQualities = lo.strQualities;
		if (strQualities == undefined) {
			if (lo.bTentacleSafe != undefined) strQualities = lo.bTentacleSafe ? "TentacleSafe" : "";
			else strQualities = SMData.sTentacleExpert != 0 ? "TentacleSafe" : "";
		}

		Price = lo.Price;
		if (Price == undefined) Price = 0;
		if (lo.CityName != undefined) CityName = lo.CityName;
		if (lo.AreaName != undefined) AreaName = lo.AreaName;
		else {
			AreaName = "";
			AreaName = GetCityArea();
			if (AreaName == undefined) AreaName = "";
		}
		hUpkeep = lo.hUpkeep;
	}
	
	// Save
	public function Save(so:Object)
	{
		super.Save(so);
		
		so.HouseType = HouseType;
		so.HouseName = HouseName;
		so.DaysOccupied = DaysOccupied;
		so.hKitchen = hKitchen;
		so.hLibrary = hLibrary;
		so.hDungeon = hDungeon;
		so.hWards = hWards;
		so.hIncome = hIncome;
		so.HomeRoom = HomeRoom;
		so.HomeBath = HomeBath;
		so.HomeDungeon = HomeDungeon;
		so.HomeKitchen = HomeKitchen;
		so.hStables = hStables;
		so.totRooms = totRooms;
		so.maxRooms = maxRooms;
		so.hMilkBarn = hMilkBarn;
		
		so.BaseHouseWork = BaseHouseWork;
		so.BaseSecurity = BaseSecurity;
		so.ActualHouseWork = ActualHouseWork;
		so.ActualSecurity = ActualSecurity;
		so.ActualCooking = ActualCooking;
		
		so.strQualities = strQualities;
		
		so.Price = Price;
		so.CityName = CityName;
		so.AreaName = AreaName;
		so.hUpkeep = hUpkeep;
	}
	
	public function InitialiseHouseByNumber(type:Number) : HouseDetails
	{
		if (type == -1) return;
		if (type == undefined) type = HouseType;
		
		var curr:Number = 0;
		var nm:String;
		var tNode:XMLNode;
		var id:Number;
		
		for (var hNode:XMLNode = Language.GetNodeC("Housing/Houses"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "house") {
				nm = Language.XMLData.GetXMLStringSimple("City", hNode.firstChild);
				if (nm != "" && nm != coreGame.currentCity.ModuleName) continue;

				curr++;
				tNode = hNode.firstChild;
				id = Number(hNode.attributes.id);
				if (isNaN(id)) id = curr;
				else curr = id;
				if (id == type) {
					HouseType = id;
					Id = HouseType;
					HouseName = Language.XMLData.GetXMLString("Name", tNode);
					AreaName = Language.XMLData.GetXMLString("CityArea", tNode);
					ImageFolder = Language.XMLData.GetXMLString("Folder", tNode);
					xNode = tNode;
					strNodeName = "House-" + Language.strLineChanges(HouseName).split(" ").join("").split("'").join("").split("\"").join("");
					return this;
				}
			}
		}
		return null;
	}
	
	public function InitialiseHouseByName(name:String) : HouseDetails
	{
		var curr:Number = 0;
		var nm:String;
		var id:Number;
		var tNode:XMLNode;
		name = name.split(" ").join("").toLowerCase();
		var ar:Array = name.split("/");
		name = ar[ar.length - 1];
		
		for (var hNode:XMLNode = Language.GetNodeC("Housing/Houses"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "house") {
				nm = Language.XMLData.GetXMLStringSimple("City", hNode.firstChild);
				if (nm != "" && nm != coreGame.currentCity.ModuleName) continue;
				
				curr++;
				tNode = hNode.firstChild;
				nm = Language.GetXMLString("Name", tNode);
				id = Number(hNode.attributes.id);
				if (isNaN(id)) id = curr;
				else curr = id;
				if (name == nm.split(" ").join("").toLowerCase()) {
					HouseType = id;
					HouseName = nm;
					Id = HouseType;
					xNode = tNode;
					ImageFolder = Language.XMLData.GetXMLString("Folder", tNode);
					AreaName = Language.XMLData.GetXMLString("CityArea", tNode);
					strNodeName = "House-" + Language.strLineChanges(HouseName).split(" ").join("").split("'").join("").split("\"").join("");
					return this;
				}
			}
		}
		return null;
	}
	
	private function GetHouseArea(aNode:XMLNode, subnode:String, def:Number) : Number
	{
		var pNode:XMLNode = Language.GetNode(aNode, subnode);
		if (pNode == null) return def;
		var str:String = pNode.firstChild.nodeValue.toLowerCase();
		return GetAreaTypeString(str);
	}
	public function GetAreaType(num:Number) : String
	{
		switch(num) {
			case 1: return Language.GetHtml("QualityStandard", "Housing");
			case 2: return Language.GetHtml("QualityGood", "Housing");
			case 3: return Language.GetHtml("QualityExcellent", "Housing");
		}
		// 0 or default
		return Language.GetHtml("QualityNone", "Housing");
	}
	public function GetAreaTypeString(str:String) : Number
	{
		switch(str) {
			case "standard": return 1;
			case "good": return 2;
			case "excellent": return 3;
		}
		// "none" or default
		return 0;
	}	
	
	public function ChangeHouse()
	{
		//SMTRACE("HouseDetails.ChangeHouse: " + HouseType);
		InitialiseHouseByNumber(HouseType);
		
		hKitchen = 1;		// default standard
		
		hIncome = Language.GetXMLValue("Income", xNode, 0);
		hUpkeep = Language.GetXMLValue("Upkeep", xNode, 6);
		
		BaseHouseWork = Language.GetXMLValue("BaseHouseWork", xNode, 1);
		BaseSecurity = Language.GetXMLValue("BaseSecurity", xNode, 1);
		Price = Language.GetXMLValue("Price", xNode, 10000);
		
		var aNode:XMLNode = Language.GetNodeC(xNode, "Areas");
		if (aNode != null) {
			// parts of the house
			hDungeon = GetHouseArea(aNode, "Dungeon", 0);
			hLibrary = GetHouseArea(aNode, "Library", 0);
			hWards = GetHouseArea(aNode, "Wards", 0);
			hKitchen = GetHouseArea(aNode, "Kitchen", hKitchen);
			
			hStables = Language.GetXMLBoolean("Stables", aNode, false);
			hMilkBarn = Language.GetXMLBoolean("Barn", aNode, false);
		}
		
		totRooms = Language.GetXMLValue("TotalRooms", xNode, 6);
		maxRooms = Language.GetXMLValue("MaximumRooms", xNode, 10);
		
		switch(HouseType) {
			case 3:
				coreGame.PonygirlsOn = true;
				if (SMData.PonygirlAware < 1) SMData.PonygirlAware = 1;
				break;
			case 10:
				hDungeon = 1;
				break;
	
		}
		Language.XMLData.XMLEventByNode(xNode.parentNode, false, "Initialise", true);
	}

	
	public function IsHouse(type) : Boolean
	{
		if (!isNaN(type)) return type == HouseType;
		var nm:String = type;
		if (nm.split(" ").join("").toLowerCase() == HouseName.split(" ").join("").toLowerCase()) return true;
		var sl:Array = ImageFolder.split("/");
		nm = sl[sl.length - 1].toLowerCase();
		return nm.split(" ").join("") == HouseName.split(" ").join("").toLowerCase();
	}
	
	public function IsHouseName(name:String) : Boolean
	{
		return name.split(" ").join("").toLowerCase() == HouseName.split(" ").join("").toLowerCase();
	}
	public function GetHouseGeopgraphy() : String {	return Language.GetXMLString("Gengraphy", xNode); }
	public function GetHouseCity() : String { return Language.GetXMLString("City", xNode); }
	public function IsHouseLocated(str:String) : Boolean { return GetHouseGeopgraphy().indexOf(str) != -1; }
	public function GetHousePrice() : Number {	return Price; }
	
	public function GetCityArea() : String {
		if (AreaName != "") return AreaName;
		return coreGame.currentCity.GetStartingArea();
	}
	
	public function IsAvailable() : Boolean
	{
		var avNode:XMLNode = Language.GetNode(xNode, "Available");
		if (avNode == null) return true;
		return coreGame.ParseConditional(avNode, true, false, true) != null;
	}
	
	public function ParseGetHomeDetails(str:String) : Object
	{
		if (str == "house" || str == "home") return HouseType;
		if (str == "housekitchen") return hKitchen;
		if (str == "houselibrary") return hLibrary;
		if (str == "housedungeon") return hDungeon;
		if (str == "housewards") return hWards;
		if (str == "houseincome") return hIncome;
		if (str == "houseprice") return Price;
		if (str == "housetotrooms") return totRooms;
		if (str == "housemaxrooms") return maxRooms;
		if (str == "housemilkbarn") return hMilkBarn;
		if (str == "housestables") return hStables;
		if (str == "houseupkeep") return hUpkeep;
		if (str == "housedaysoccupied") return DaysOccupied;
		if (str == "housecity") return CityName;
		if (str == "housecityarea") return GetCityArea();
		if (str == "housename") return HouseName;
		
		if (str == "housebasesecurity") return BaseSecurity;
		if (str == "housebasehousework") return BaseHouseWork;
		if (str == "housesecurity") return ActualSecurity;
		if (str == "househousework") return ActualHouseWork;
		if (str == "housecooking") return ActualCooking;	
		
		if (str == "housequalities") return strQualities;	

		return undefined;
	}
	
	public function ParseSetHomeDetails(str:String, val:Number, vs:String) : Number
	{
		if (str == "housekitchen") return hKitchen = val;
		if (str == "houselibrary") return hLibrary = val;
		if (str == "housedungeon") return hDungeon = val;
		if (str == "housewards") return hWards = val;
		if (str == "houseincome") return hIncome = val;
		if (str == "housestables") {
			hStables = vs.toLowerCase() == "true";
			return 1;
		}
		if (str == "houseprice") return Price = val;
		if (str == "housetotrooms") return totRooms = val;
		if (str == "housemaxrooms") return totRooms = val;
		if (str == "housemilkbarn") {
			hMilkBarn = vs.toLowerCase() == "true";
			return 1;
		}
		if (str == "houseupkeep") return hUpkeep = val;
		
		if (str == "housebasesecurity") return BaseSecurity = val;
		if (str == "housebasehousework") return BaseHouseWork = val;
		if (str == "housesecurity") return ActualSecurity = val;
		if (str == "househousework") return ActualHouseWork = val;
		if (str == "housecooking") return ActualCooking = val;		
		if (str == "housecityarea") {
			AreaName = vs;
			return 1;
		}
		if (str == "housequalities") {
			var ar:Array = vs.split(",");
			for (var i:Number = 0; i < ar.length; i++) {
				if (ar[i].charAt(0) == "-") RemoveQuality(str.substr(1));
				else if (ar[i].charAt(0) == "+") AddQuality(str.substr(1));
				else AddQuality(ar[i]);
			}
			return 1;
		}
		
		return undefined;
	}

	public var currUpkeep:Number;
	public var currIncome:Number;
	private var unsuper:Number;
	
	public function CalculateUpkeepIncome(free:Boolean) : Number
	{
		// total occupants and slaves unsupervised
		var tot:Number = free ? 1 : 2;	// 2 = current slave + slave maker
		var j:Number = SMData.SlavesArray.length;
		var sd:Object;
		while (--j >= 0) {
			sd = SMData.SlavesArray[j];
			if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
			if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
			
			if (!sd.bSupervisedToday) unsuper++;
			tot++;
		}
		if (coreGame.AssistantData.SlaveType == -1) tot++;
		
		// upkeep
		currUpkeep = hUpkeep + Math.ceil(tot * 0.1);
		var needhw:Number = Math.ceil(tot / 3);
		var needclean:Number = BaseHouseWork;
		var needcook:Number = needhw / 2;
		needclean += needhw / 2;
		
		if (ActualHouseWork < needclean) {
			currUpkeep += (needclean - ActualHouseWork) * 0.2;
		}
		if (ActualCooking < needcook) {
			currUpkeep += (needcook - ActualCooking) * 0.2;
		}
		var needsec:Number = Math.ceil(BaseSecurity + (unsuper / 4));
		needsec -= 1; // slave maker
		if (coreGame.ServantName != "") needsec -= 2; // assistant
		
		if (ActualSecurity < needsec) {
			currUpkeep += (needsec - ActualSecurity) * 0.5;
		}

		// income
		currIncome = hIncome;
		return tot;
	}
	
	public function ChangeDate(NumDays:Number, free:Boolean)
	{
		coreGame.genNumber = NumDays;
		if (free != true) Language.XMLData.XMLEventByNode(xNode.parentNode, false, "UpdateDateAndItems", true, true);
		DaysOccupied += NumDays;
		
		// total people in house
		CalculateUpkeepIncome(free);

		if (currUpkeep > 0) SMMoney(int(currUpkeep * NumDays) * -1, true, true);
		if (currIncome > 0) SMMoney(int(currIncome * NumDays), true, true);
		
		ActualHouseWork = 0;
		ActualSecurity = 0;
		ActualCooking = 0;
	}
	
	
	// Qualities
	
	public function HasQuality(str) : Boolean { return strQualities.toLowerCase().indexOf(str.toLowerCase()) != -1; }
	
	public function AddQuality(str) {
		if (HasQuality(str)) return;
		if (strQualities == "") strQualities = str;
		else strQualities += "," + str;
	}
	
	public function RemoveQuality(str) {
		if (!HasQuality(str)) return;
		// TODO: not fully case insensitive
		if (strQualities.toLowerCase() == str.toLowerCase()) strQualities = "";
		else strQualities = strQualities.split("," + str).join("");
	}
	
	
	// Push/Pop
	
	public function Push() {
		if (bPushState == undefined) bPushState = mcBase._visible;
	}	
	public function Pop() {
		if (bPushState != undefined) {
			mcBase._visible = bPushState;
			bPushState = undefined;
		}
	}

	
}