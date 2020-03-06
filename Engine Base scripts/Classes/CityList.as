// City List
//
// Translation status: COMPLETE
//

import Scripts.Classes.*;

class CityList
{
	private var arCities:Array;		// list of cities for current game
	private var coreGame:Object;	// standard reference to the core game
	
	private var bLoading:Boolean;
	
	// constructor
	public function CityList(cg:Object)
	{
		coreGame = cg;
		Reset();
	}
	
	// clear the list
	public function Reset()
	{
		var i:Number = arCities.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			var obj:Object = arCities.pop();
			delete obj;
		}
		delete arCities;
		arCities = new Array();
		
		coreGame.currentCity = null;
		coreGame.modulesList.currentCity = null;
		bLoading = false;
	}
	
	public function IsLoading() : Boolean { return bLoading; }
	
	// Get available cities for the game (from configuration.xml)
	
	public function GetTotalAvailableCities() : Number
	{
		//trace("GetTotalAvailableCities");
		var tot:Number = 0;
		for (var cNode:XMLNode = coreGame.config.GetNodeC("Cities"); cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "city") tot++;
		}
		//trace("..tot = " + tot);
		return tot;
	}
	public function GetAvailableCity(nCity:Number) : String
	{
		//trace("GetAvailableCity: " + nCity);
		for (var cNode:XMLNode = coreGame.config.GetNodeC("Cities"); cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeName.toLowerCase() == "city") {
				nCity--;
				if (nCity <= 0) {
					//trace("..got " + cNode.firstChild.nodeValue);
					return cNode.firstChild.nodeValue;
				}
			}
		}
		//trace("..none");
		return "";
	}
	
	// Change City
	
	public function ChangeCity(str:String)
	{
		trace("ChangeCity: " + str);
		var cc:City = GetCity(str);
		if (cc == null) cc = AddCity(str);
		for (var i:Number = 0; i < arCities.length; i++) arCities[i].bCurrent = false;
		trace(".." + cc.ModuleName);
		cc.SetCurrent();
		coreGame.currentCity = cc;
	}
		
	// Add a city
	public function AddCity(curr) : City
	{			
		if (typeof(curr) == "string") {
			// add city by name
			var nm:String;
			if (curr == undefined) nm = "Mardukane";
			else nm = curr + "";
			if (nm.substr(0, 4) != "City") nm = "City" + nm;
			var cc:City = CreateCityClass(nm);
			if (cc == null) cc = new City(coreGame);
			cc.ModuleName = nm.substr(4);
			arCities.push(cc);
			return cc;
		}
		arCities.push(curr);
		return curr;
	}
	
	// Find an existing city by name
	public function GetCity(str:String) : City
	{
		str = str.toLowerCase();
		for (var i:Number = 0; i < arCities.length; i++) {
			if (arCities[i].ModuleName.toLowerCase() == str) return arCities[i];
		}
		return null;
	}
	public function GetCityIdx(str:String) : Number
	{
		str = str.toLowerCase();
		for (var i:Number = 0; i < arCities.length; i++) {
			if (arCities[i].ModuleName.toLowerCase() == str) return i;
		}
		return -1;
	}	
	
	public function SetCityCurrent(curr)
	{
		var cc:City = curr;
		if (typeof(curr) == "string") {
			var str:String = curr.toLowerCase();
			cc = null;
			for (var i:Number = 0; i < arCities.length; i++) {
				arCities[i].bCurrent = false;
				if (arCities[i].ModuleName.toLowerCase() == str) cc = arCities[i];
			}
		}
		if (cc == null) cc = AddCity(str);
		
		cc.SetCurrent();
	}
	
	// find the named city class
	private function CreateCityClass(strClass:String) : City
	{
		// try Scripts 'folder'
		var obj:Object = coreGame.modulesList.FindSlaveClass(_global["Classes"], strClass);
		var cc:City = obj.main(coreGame);
		if (cc != null) return cc;
			
		// try base folder only, do not iterate contianing objects
		for (var strObj:String in _global) {
			if (strObj == strClass) return _global[strObj].main(coreGame);
		}
		
		// try Scripts 'folder'
		obj = coreGame.modulesList.FindSlaveClass(_global["Scripts"], strClass);
		cc = obj.main(coreGame);
		if (cc != null) return cc;
		
		return null;
	}
	
	// Load/Save
	public function Save(so:Object)
	{
		so.Cities = new Array();
		
		var cc:Object;
		
		var i:Number = arCities.length;
		while (--i >= 0) {
			cc = arCities[i];
			var cityo:Object = new Object();
			cc.Save(cityo);
			so.Cities.push(cityo);
		}
	}
	
	public function Load(lo:Object, bso:Object) 
	{
		Reset();
		bLoading = true;
		
		var cc:Object;

		var i:Number = lo.Cities.length;
		if (i == undefined) {
			i = 0;
			cc = AddCity("Mardukane");
			cc.SetCurrent();
			lo = bso;
		}
		while (--i >= 0) {
			var cityo:Object = lo.Cities[i];
			if (cityo == undefined) cityo = bso;
			var nm:String = cityo.CityName;
			if (nm == undefined) nm = "Mardukane";
			cc = AddCity(nm);
			cc.Load(cityo, bso);
			if (cc.bCurrent) cc.SetCurrent();
		}
		
		coreGame.Home = coreGame.currentCity.Home;
		coreGame.currentCity.SetWalkEvents();
		bLoading = false;
	}
	
}
