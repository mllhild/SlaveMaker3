// Modules and Externam Events
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class LoadedModules extends SlaveModule {
		
	// private variables
	private var evtData:SlaveModule;		// internal reference variable
	private var excludedEvent:SlaveModule;
	
	private var loadedevent:Number;
	private var eventslv:LoadVars;
	private var eindex:Number;
	private var mcLoaderModule:MovieClipLoader;
	private var loadListenerModule:Object;
	private var bEventsLoaded:Boolean;
	
	private var elength:Number;
	private var ecustlength:Number;
	public var arEventsArray:Array;
	
	private var XMLData:GameXML;		// reference
	
	// private module references
	private var LoadedSlaves:LoadedSlavesClass;
	
	// public module instances
	
	public var SlaveGirl:SlaveModule;
	public var CurrentAssistant:SlaveModule;
	public var currentCity:City;
	
	public var trainCourtesans:CourtesanTraining;
	public var trainPonies:PonyTraining;
	public var People:PeopleModule;
	public var Generic:GenericModule;
	public var Parties:PartiesModule;
	public var Sounds:SoundsModule;
	public var Faeries:FaeriesModule;
	public var Furries:FurriesModule;
	public var HouseEvents:HousesModule;
	public var Catgirls:CatgirlTraining;
	public var trainPuppygirls:PuppyTraining;
	public var Tentacles:TentaclesModule;
	public var Contests:ContestsModule;
	public var eventsSM:SMEvents;
	public var trainLesbians:LesbianGayTraining;
	public var trainSlaveMaker:SlaveMakerTraining;
	
	// Constructor
	public function LoadedModules(cg:Object)
	{
		super(cg.LoadedEvents, null, cg);
		
		eindex = 0;
		elength = 0;
		ecustlength = 0;
		loadedevent = 0;
		bEventsLoaded = false;
		arEventsArray = new Array();
		
		XMLData = cg.XMLData;
		
		//ListSMClasses();

		// Backgrounds
		Backgrounds = new BackgroundModule(cg.mcBase.BackgroundsMovie, cg);
		cg.Backgrounds = Backgrounds;

		// Load Generic Actions
		Generic = new GenericModule(cg.mcBase.GenericMovie, cg);
		Generic.LoadModule("Engine/GenericActions.swf", this, "LoadedModules2");
		cg.Generic = Generic;
		
		// Load Housing
		HouseEvents = new HousesModule(cg.mcBase.HouseEventsMovie, cg);
		HouseEvents.LoadModule("Engine/Houses.swf");
		cg.HouseEvents = HouseEvents;
	
		// Contests
		Contests = new ContestsModule(cg.mcBase.ContestsMovie, cg);
		Contests.ModuleName = "Engine/Contests.swf";
		cg.Contests = Contests;
		
		// Parties
		Parties = new PartiesModule(cg.mcBase.PartiesMovie, cg);
		Parties.ModuleName = "Engine/Parties.swf";
		cg.Parties = Parties;
		
		// Furries
		Furries = new FurriesModule(cg.mcBase.FurriesMovie, cg);
		Furries.ModuleName = "Engine/Furries.swf";
		cg.Furries = Furries;
				
		// Puppygirls
		trainPuppygirls = new PuppyTraining(cg);
		
		// Tentacles
		Tentacles = new TentaclesModule(cg.mcBase.TentaclesMovie, cg);
		Tentacles.ModuleName = "Engine/Tentacles.swf";
		cg.Tentacles = Tentacles;
		
		// Load Faeries
		Faeries = new FaeriesModule(cg.mcBase.FaeriesMovie, cg);
		Faeries.ModuleName = "Engine/Faeries.swf";
		cg.Faeries = Faeries;
		
		// other modules
		LoadedSlaves = new LoadedSlavesClass(cg);
		cg.LoadedSlaves = LoadedSlaves;
		
		trainSlaveMaker = new SlaveMakerTraining(cg);
		coreGame.trainSlaveMaker = trainSlaveMaker;
	}

	public function LoadedModules2()
	{
		// Load Sounds
		Sounds = new SoundsModule(coreGame.mcBase.SoundsMovie, coreGame);
		Sounds.LoadModule("Sounds/Sounds.swf");
		coreGame.Sounds = Sounds;
			
		// Load People
		People = new PeopleModule(coreGame.PeopleMovie, coreGame);
		People.LoadModule("Engine/People.swf", this, "LoadedModules3");
		coreGame.People = People;
	}
	
	public function LoadedModules3()
	{	
		// Catgirls
		Catgirls = new CatgirlTraining(coreGame.mcBase.CatgirlsMovie, coreGame);
		Catgirls.LoadModule("Engine/CatgirlTraining.swf");
		coreGame.Catgirls = Catgirls;

		var ti:LoadedModules = this;
		
		// Events
		mcLoaderModule = new MovieClipLoader();
		loadListenerModule = new Object();
		mcLoaderModule.addListener(loadListenerModule);
		
		eventslv = new LoadVars();
		eventslv.onLoad = function(success:Boolean) {
			var emax:Number = ti.coreGame.config.GetValue("EventsMax", 59);
			trace("loaded " + success + " Events" + ti.eindex + ".txt of " + emax);
			if (ti.eindex < emax) {
				ti.eindex++;
				ti.eventslv.load("Events/Events" + ti.eindex + ".txt");
			} else {
				var etotal:Number = 0;
				for (var ename:String in ti.eventslv) {
					if (typeof(ti.eventslv[ename]) == "string") ti.elength++;
				}
				trace("event txt loaded: " + ti.elength);
				for (var ename:String in ti.eventslv) {
					if (typeof(ti.eventslv[ename]) == "string") {
						etotal++;
						ti.LoadExternalEvent(ti.Language.strTrim(ename));
						return;
					}
				}
				if (etotal == 0) ti.EventsLoadComplete();
			}
		}
		eventslv.load("Events/Events.txt");
	}
	
	public function IsEventsLoaded() { return bEventsLoaded; }
	public function GetLength() { return elength; }
	public function GetCustomLength() { return ecustlength; }
	
	public function Exclude(sm:SlaveModule) : LoadedModules { excludedEvent = sm; return this; }
	public function GetExcluded() : SlaveModule { var em:SlaveModule = excludedEvent; excludedEvent = undefined; return em; }

	private function LoadExternalEvent(module:String)
	{
		//trace(module + " " + mcBase);
		var evtarray:Array = module.split("-");
		var evtname:String = evtarray[evtarray.length-1];
		var pos:Number = evtname.lastIndexOf(".");
		if (pos != -1) evtname = evtname.substr(0, pos);
	
		var image:MovieClip = mcBase.attachMovie("Empty Movie", "LoadedEvent" + evtname, mcBase.getNextHighestDepth());
		image.loading = true;
	
		if (module.substr(-4) == ".xml") {
			image.LoadingMC = false;
			image.loading = false;
			ExternalEventLoaded(image, "Events/" + module);
			return;
		}
	
		image._visible = false;
		image.LoadingMC = true;
		trace("load " + "Events/" + module + " into " + image);
		
		var ti:LoadedModules = this;
		loadListenerModule.modulename = "Events/" + module;
		loadListenerModule.onLoadInit = function(module:MovieClip) { ti.ExternalEventLoaded(module, this.modulename); }
		loadListenerModule.onLoadError = function(target_mc:MovieClip, errorCode:String, httpStatus:Number) { trace("error"); }
		mcLoaderModule.loadClip(loadListenerModule.modulename, image);
	}

	public function ExternalEventLoaded(module:MovieClip, modulename:String, timer:Number)
	{
		trace("ExternalEventLoaded: " + modulename + " " + module + " " + module.LoadingMC + " " + module.loading);
		//if (module.LoadingMC != false) return;
		//Timers.RemoveTimer(timer);
				
		module._visible = true;
	
		loadedevent++;
		var mod:SlaveModule;
		var mn:String = modulename.split("/")[1].slice(0, -4);
		var modArray:Array = mn.split("-");
		if (modArray.length > 1) mn = modArray[1];
	
		if (modulename.substr(-4) == ".xml") mod = new SlaveModule(module, null, coreGame);
		else mod = CreateSlaveModuleClass(mn, module, null, coreGame);
	
		mod.InitialiseModule();
		mod.AsEvent = true;
		mod.Assisting = false;
		mod.loading = false;
		mod.ModuleName = modulename.split("/")[1];
		trace("loaded event: " + mod.ModuleName);
		arEventsArray.push(mod);
		module._visible = true;
				
		var evtn:Number = 0;
		for (var ename:String in eventslv) {
			if (typeof(eventslv[ename]) == "string") {
				evtn++;
				if (evtn <= loadedevent) continue;
				LoadExternalEvent(Language.strTrim(ename));
				return;
			}
		}
		EventsLoadComplete();
	}
	
	private function EventsLoadComplete()
	{
		trace("..loading events complete");
		mcLoaderModule.removeListener(loadListenerModule);
		delete mcLoaderModule;
		delete loadListenerModule;
		
		ecustlength = elength;
		arEventsArray.push(Faeries);
		Faeries.InitialiseModule();
		arEventsArray.push(Catgirls);
		Catgirls.ModuleName = "CatgirlTraining";
		Catgirls.InitialiseModule();
		arEventsArray.push(Tentacles);
		arEventsArray.push(Furries);		// note special load/save
		arEventsArray.push(HouseEvents);
		arEventsArray.push(new MasochistTraining(coreGame));
		arEventsArray.push(new CumslutTraining(coreGame));
		arEventsArray.push(new SuccubusTraining(coreGame));
		
		trainLesbians = new LesbianGayTraining(coreGame);
		arEventsArray.push(trainLesbians);
		
		trainPonies = new PonyTraining(coreGame);
		arEventsArray.push(trainPonies);
		
		trainCourtesans = new CourtesanTraining(coreGame);
		arEventsArray.push(trainCourtesans);
		
		arEventsArray.push(trainPuppygirls);
		
		eventsSM = new SMEvents(null, coreGame);
		arEventsArray.push(eventsSM);
		
		arEventsArray.push(Parties);
		
		ecustlength = arEventsArray.length - ecustlength;
		elength += ecustlength;
		
		bEventsLoaded = true;
	}

	public function GetEventDataIdx(idx:Number) : SlaveModule { return arEventsArray[idx]; }

	public function GetEventData(ename:String, sdo:Object) : SlaveModule
	{
		var str:String;
		var sl:Array;
		var elwr:String;
		ename = coreGame.UpdateMacros(ename).toLowerCase();
		var i:Number = arEventsArray.length;	
		if (i == undefined) i = 0;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			sl = evtData.ModuleName.split("/");
			str = sl[sl.length - 1].split(".")[0];
			elwr = evtData.ModuleName.toLowerCase();
			if (ename == elwr || ("event-" + ename + ".swf") == elwr || ("event-" + ename + ".xml") == elwr || (ename + ".swf") == elwr || (ename + ".xml") == elwr || ename == str.toLowerCase()) {
				evtData.SetSlave(sdo);
				return evtData;
			}
		}
		
		// other modules
		if (ename.toLowerCase() == "parties") {
			Parties.SetSlave(sdo);
			return Parties;
		}
		if (ename.toLowerCase() == "contests") {
			Contests.SetSlave(sdo);
			return Contests;
		}
		if (ename.toLowerCase() == "smevents") {
			eventsSM.SetSlave(sdo);
			return eventsSM;
		}
		if (ename.toLowerCase() == "generic" || ename.toLowerCase() == "genericactions") {
			Generic.SetSlave(sdo);
			return Generic;
		}		
		var plc:Place = currentCity.GetPlaceObject(ename);
		if (plc != null) {
			plc.SetSlave(sdo);
			return plc;
		}
		var per:Person = People.GetPersonsObject(ename);
		if (per != null) {
			per.SetSlave(sdo);
			return per;
		}

		return null;
	}
	
	public function GetTraining(ename:String, sdo:Object) : TrainingBase
	{
		var str:String;
		var sl:Array;
		var i:Number = arEventsArray.length;	
		if (i == undefined) i = 0;
		var tb:TrainingBase;
		while (--i >= 0) {
			tb = arEventsArray[i];
			sl = tb.ModuleName.split("/");
			str = sl[sl.length - 1].split(".")[0];
			if ((ename.toLowerCase() + "training") == tb.ModuleName.toLowerCase() || (ename.toLowerCase() == tb.ModuleName.toLowerCase()) || ("Training-" + ename + ".swf") == tb.ModuleName || ("Training-" + ename + ".xml") == tb.ModuleName || (ename + ".swf") == tb.ModuleName || (ename + ".xml") == tb.ModuleName || ename == str) {
				tb.SetSlave(sdo);				
				return tb;
			}
		}
		if (ename.toLowerCase() == "puppygirls" || ename.toLowerCase() == "puppyboys") return trainPuppygirls;
		if (ename.toLowerCase() == "catgirls" || ename.toLowerCase() == "catboys") return Catgirls;
		if (ename.toLowerCase() == "ponygirls" || ename.toLowerCase() == "ponyboys") return trainPonies;
		return null;
	}

	//
	// Actual Events
	//
	private function ParseExEventName(modulename:String) : String
	{
		var evtname:String;
		var evtarray:Array;
		var pos:Number;
	
		if (modulename.toLowerCase().substr(0, 6) == "event-") {
			evtarray = modulename.split("-");
			evtname = evtarray[evtarray.length-1].toLowerCase();
		} else evtname = modulename.toLowerCase();
		var ar:Array = evtname.split("/");
		if (ar.length > 1) evtname = ar[1];
	
		pos = evtname.lastIndexOf(".");
		if (pos != -1) return evtname.substr(0, pos);
		//trace("ParseExEventName: " + evtname);
		return evtname;
	}
	
	public function SetExEventVariable(str:String, val:Number, vals:String) : Number
	{
		//trace("SetExEventVariable: " + str);
		var evt:SlaveModule;
		var evtname:String;
		var tempstr:String = str + "";
		str = str.toLowerCase();
	
		for (var index:String in arEventsArray) {
			evt = arEventsArray[index];
			evtname = ParseExEventName(evt.ModuleName);
			//trace("checking " + str + " " + evtname + "(" + str.substr(0, evtname.length));
	
			if (str.substr(0, evtname.length) == evtname || str.substr(evtname.length * -1) == evtname) {
				if (str.substr(evtname.length * -1) == evtname) tempstr = tempstr.substr(0, tempstr.length - evtname.length).split("-").join("").split("_").join("");
				else tempstr = tempstr.substr(evtname.length).split("-").join("").split("_").join("");
				//trace(".." + evtname + " event matched: " + tempstr);
				if (tempstr.substr(0, 8) == "savedvar") {
					tempstr = tempstr.substr(8);
					var bString:Boolean = tempstr.substr(0, 6) == "string";
					if (bString || tempstr.substr(0, 6) == "number") tempstr = tempstr.substr(6);
					var idx:Number = Number(tempstr);
					//trace("..savedvar: " + idx);					// set/change a variable for the event
					if (evt.arSaveVars == null) evt.arSaveVars = new Array();
					var len:Number = evt.arSaveVars.length;
					if (isNaN(val) == false && len < (idx + 1)) {
						for (var id:Number = len; id <= idx; id++) evt.arSaveVars.push(0);
					}
					if (bString) evt.arSaveVars[idx] = coreGame.UpdateMacros(vals);
					else evt.arSaveVars[idx] = coreGame.XMLData.GetExpression(vals);
					return evt.arSaveVars[idx];
				}
				if (!isNaN(Number(tempstr))) {
					evt.SetVariable(Number(tempstr), val);
					return 0;
				} else if (tempstr.substr(0,6) == "string") {
					tempstr = tempstr.substr(6);
					if (!isNaN(Number(tempstr))) {
						evt.SetString(Number(tempstr), vals);
						return 0;
					}
				}
			}	
		}
		return undefined;
	}
	
	public function SetExEventBitFlag(str:String, setf:Boolean) : Boolean
	{
		var evt:SlaveModule;
		var evtname:String;
		var tmpstr:String;
		str = str.toLowerCase();
	
		for (var index:String in arEventsArray) {
			evt = arEventsArray[index];
			evtname = ParseExEventName(evt.ModuleName);
	
			if ((str.substr(0, 4) == "flag") && (str.substr(4, evtname.length) == evtname) && (str.substr(4 + evtname.length, 1) == "-")) {
				tmpstr = str.substr(5 + evtname.length);
				if (!isNaN(Number(tmpstr))) {
					if (setf) evt.SetBitFlag(Number(tmpstr));
					else evt.ClearBitFlag(Number(tmpstr));
					return true;
				}
			}
		}
		return false;
	}
	
	public function GetExEventVariable(str) : Object
	{
		//trace("GetExEventVariable: " + str);
		var evt:SlaveModule;
		var evtname:String;
		var tempstr:String = str + "";
		str = str.toLowerCase();
	
		for (var index:String in arEventsArray) {
			evt = arEventsArray[index];
			evtname = ParseExEventName(evt.ModuleName);
			//trace("checking " + str + " " + evtname);
	
			if (str.substr(0, evtname.length) == evtname || str.substr(evtname.length * -1) == evtname) {
				if (str.substr(evtname.length * -1) == evtname) tempstr = tempstr.substr(0, tempstr.length - evtname.length).split("-").join("").split("_").join("");
				else tempstr = tempstr.substr(evtname.length).split("-").join("").split("_").join("");
				//trace(".." + evtname + " event matched: " + tempstr);
				if (tempstr.substr(0, 8) == "savedvar") {
					tempstr = tempstr.substr(8);
					var bString:Boolean = tempstr.substr(0, 6) == "string";
					if (bString || tempstr.substr(0, 6) == "number") tempstr = tempstr.substr(6);
					var idx:Number = Number(tempstr);
					//trace("..savedvar: " + idx);
					if (evt.arSaveVars == null) evt.arSaveVars = new Array();
					if (!isNaN(idx) && evt.arSaveVars.length < (idx + 1)) {
						for (var id:Number = evt.arSaveVars.length; id <= idx; id++) evt.arSaveVars.push(0);
					}
					if (evt.arSaveVars[idx] == undefined) evt.arSaveVars[idx] = 0;
					//trace("value: evt.savedvar" + idx + " = " + evt.arSaveVars[idx]);
					return evt.arSaveVars[idx];
				}
				return evt.GetVariable(tempstr);
			}
		}
		return undefined;
	}
	
	public function GetExEventString(str) : String
	{
		var evt:SlaveModule;
		var evtname:String;
		var tmpstr:String;
		str = str.toLowerCase();
	
		for (var index:String in arEventsArray) {
			evt = arEventsArray[index];
			evtname = ParseExEventName(evt.ModuleName);
	
			if (str.substr(0, evtname.length) == evtname) {
				tmpstr = str.substr(evtname.length).split("-").join("").split("_").join("");
				if (tmpstr.substr(0,6) == "string") {
					tmpstr = tmpstr.substr(6);
					if (!isNaN(Number(tmpstr))) return evt.GetString(Number(tmpstr));
				}
				break;
			}
		}
		return undefined;
	}
	
	public function GetExEventBitFlag(str:String) : Boolean
	{
		var evt:SlaveModule;
		var evtname:String;
		var tmpstr:String;
		str = str.toLowerCase();
	
		for (var index:String in arEventsArray) {
			evt = arEventsArray[index];
			evtname = ParseExEventName(evt.ModuleName).split("-").join("").split("_").join("");
			tmpstr = "flag" + evtname;
			
			if (tmpstr == str.substr(0, tmpstr.length)) {
				tmpstr = str.substr(tmpstr.length).split("-").join("").split("_").join("");
				if (!isNaN(Number(tmpstr))) return evt.CheckBitFlag(Number(tmpstr));
				break;
			}
		}
		return undefined;
	}
	
	// Load/Save
	
	public function IsLoadGameComplete() { return eindex == -1; }
	
	private var ecookie:SharedObject;

	public function LoadGame(loadname:String)
	{
		trace("LoadedModules.LoadGame: " + loadname);
		eindex = -1;
		if (loadname == undefined || loadname == "") return;
		
		ecookie = coreGame.GetSaveData(loadname + "custom");
	
		// Assistant
		CurrentAssistant.LoadGame(ecookie.data.AssistantSave);
	
		// Load Special events
		Furries.LoadGame(ecookie.data.FurriesSave);
		Parties.LoadGame(ecookie.data.PartiesSave);
		
		// Current City
		{
			var cookiecity:SharedObject = coreGame.GetSaveData(loadname + "cities");
			var i:Number = cookiecity.data.Cities.length;
			trace("Load City: " + i);
			while (--i >= 0) {
				var cityo:Object = cookiecity.data.Cities[i];
				var nm:String = cityo.CityName;
				if (nm == undefined) nm = "Mardukane";
				if (nm != coreGame.currentCity.ModuleName) continue;
				currentCity.Load(cityo);
				break;
			}
		}
	
		if (ecookie.data.arEventsArray.length == undefined && ecookie.data.EventsArray.length == undefined) {
			ecookie = null;
			return;
		}
		EventLoadGame();
	}
		
	private function EventLoadGame(timer:Number)
	{
		Timers.RemoveTimer(timer);
		
		//var tb:TrainingBase;
		/*
		if (eindex > -1 && eindex < elength) {
			evtData = arEventsArray[eindex];
			tb = arEventsArray[eindex];
		}
		*/
		do {
			eindex++;
			if (eindex >= elength) {
				trace("LoadedModules::LoadGame complete");
				// Now load final things
	
				HouseEvents.LoadGame(ecookie.data.HousesSave);

				eindex = -1;
				return;
			}
			evtData = arEventsArray[eindex];
			evtData.InitialiseModule();
			//tb = arEventsArray[eindex];
		} while (!evtData.CanLoadSave());
		
		var bLoaded:Boolean = false;
		var svData:Array = ecookie.data.arEventsArray;
		if (svData == undefined) svData = ecookie.data.EventsArray;
		if (svData != undefined) {
			var cevtData:Object;
			for (var i:Number = 0; i < svData.length; i++) {
				cevtData = svData[i];
				if (evtData.ModuleName == cevtData.ModuleName) {
					trace("...LoadGame: " + cevtData.ModuleName);
					evtData.SetSlave(_root);
					evtData.LoadGame(cevtData);
					bLoaded = true;
					break;
				}
			}
			if ((coreGame.LoadSave.IsStartingGame() && SMData.GirlsTrained == 0) || !bLoaded) {
				//trace("..(Loading)StartGame: " + evtData.ModuleName);
				evtData.StartSlaveMaker();
				evtData.SetSlave(_root);
				evtData.StartGame();
			}
			
		}
		//XMLData.LoadXML("Events/" + evtData.ModuleName, this, "EventLoadGame", Language.xNode);
		Timers.AddTimerStopSoon(
			setInterval(this, "EventLoadGame", 10, Timers.GetNextTimerIdx())
		);
	}
	
	public function SaveGame(so:Object)
	{
		// Slave and Assistant
		delete so.SlaveSave;
		so.SlaveSave = new Object();
		SlaveGirl.SaveGame(so.SlaveSave);
		delete so.AssistantSave;
		so.AssistantSave = new Object();
		CurrentAssistant.SaveGame(so.AssistantSave);
			
		// Furries
		so.FurriesSave = new Object();
		Furries.SaveGame(so.FurriesSave);
		// Parties
		so.PartiesSave = new Object();
		Parties.SaveGame(so.PartiesSave);
		// House
		so.HousesSave = new Object();
		HouseEvents.SaveGame(so.HousesSave);
		
		// Other events
		var sdata:Object;
		so.EventsArray = new Array();
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (!evtData.CanLoadSave()) continue;
			sdata = new Object();
			sdata.ModuleName = evtData.ModuleName;
			evtData.SaveGame(sdata);
			so.EventsArray.push(sdata);
		}
	}
	
	
	// Start Game
	
	public function IsStartGameComplete() { return eindex == -1; }
	
	public function StartGame()
	{
		XMLData.XMLEventByNode(XMLData.GetNode(coreGame.slaveNode, "StartGame"), false);
		XMLData.XMLGeneral("StartNewSlave", coreGame.SMAvatar.GetXML());
		XMLData.XMLGeneral("StartGame");
		
		SMData.StartNewSlave();
		currentCity.StartNewSlave();
		coreGame.SelectEquipment.StartNewSlave();
	
		eindex = -1;
		
		if (elength == undefined) return;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.InitialiseModule();
			evtData.StartGame();
		}
	}
	
	public function StartSlaveMaker()
	{
		// Restart all external events
		XMLData.XMLEventByNode(XMLData.GetNode(coreGame.slaveNode, "StartSlaveMaker"), false);
		XMLData.XMLGeneral("StartSlaveMaker", coreGame.SMAvatar.GetXML());
		SMData.StartSlaveMaker();
		currentCity.StartSlaveMaker();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.StartSlaveMaker();
			evtData.ResetBitFlags();		// incase it does not call super.StartSlaveMaker()
		}

	}
	
	
	// Images
	
	public function HideImages()
	{
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.HideAsAssistant();
		}
		
		LoadedSlaves.HideLoadedSlaves();
	}
	
	public function HidePeople()
	{
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.HidePeople();
		}
	}
	
	public function HideEndings()
	{
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.HideEndingsAsAssistant();
		}			
	}

	
	// People
	
	public function DoVisitSelect()
	{
		currentCity.DoVisitSelect();
		SlaveGirl.DoVisitSelect();
		XMLData.XMLEvent("VisitSelect");
		CurrentAssistant.DoVisitSelectAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.DoVisitSelectAsAssistant();
		}			
	}
	
	public function DoVisit(person:Number) : Boolean
	{
		if (SlaveGirl.DoVisit(person) == true) return true;
		if (XMLData.XMLEvent("DoVisit", true)) return true;
		if (CurrentAssistant.DoVisitAsAssistant(person) == true) return true;
		if (currentCity.DoVisitAsAssistant(person) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoVisitAsAssistant(person) == true) return true;
		}
			
		return false;
	}
	
	public function VisitChatWithPerson(person:Number)
	{
		SlaveGirl.VisitChatWithPerson(person);
		XMLData.XMLEvent("VisitChatWithPerson");
		CurrentAssistant.VisitChatWithPersonAsAssistant(person);
		currentCity.VisitChatWithPersonAsAssistant(person);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.VisitChatWithPersonAsAssistant(person);
		}			
	}
	
	public function DoLendSelect()
	{
		currentCity.DoLendSelect();
		SlaveGirl.DoLendSelect();
		XMLData.XMLEvent("LendSelect");
		CurrentAssistant.DoLendSelectAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.DoLendSelectAsAssistant();
		}
	}
	
	public function DoLendHer(person:Number) : Boolean
	{
		if (SlaveGirl.DoLendHer(person) == true) return true;
		if (XMLData.XMLEvent("DoLendHer", true)) return true;
		if (XMLData.XMLEvent("DoLend", true)) return true;
		if (CurrentAssistant.DoLendHerAsAssistant(person) == true) return true;
		if (currentCity.DoLendHerAsAssistant(person) == true) return true;
			
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoLendHerAsAssistant(person) == true) return true;
		}			
		return false;
	}

	
	public function MeetPerson(person:Number, chc:Number, personstr:String, say:String, evt:String) : Boolean
	{
		coreGame.VisitLendPerson = person;
		coreGame.genNumber = chc;
		if (SlaveGirl.MeetPerson(person, chc, personstr, say, evt) == true) return true;
		if (person == 20) {
			if (SlaveGirl.MeetIdol() == true) return true;
		}
		if (XMLData.XMLEvent("MeetPerson", true)) return true;
		if (CurrentAssistant.MeetPersonAsAssistant(person, chc, personstr, say, evt) == true) return true;
		if (currentCity.MeetPerson(person, chc, personstr, say, evt)) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.MeetPersonAsAssistant(person, chc, personstr, say, evt) == true) return true;
		}
			
		return false;
	}
	
	public function AfterMeetPerson(person:Number, chc:Number, evt:String) : Boolean
	{
		if (person == 24) {
			if (coreGame.Supervise || evt == "pray") SMData.TotalSMNun++;
		}
		var em:SlaveModule = GetExcluded();
		coreGame.VisitLendPerson = person;
		coreGame.genNumber = chc;
		coreGame.genString = evt;
		if (SlaveGirl.AfterMeetPerson(person, chc, evt) == true) return true;
		if (XMLData.XMLEvent("AfterMeetPerson", true)) return true;
		if (CurrentAssistant.AfterMeetPersonAsAssistant(person, chc, evt) == true) return true;
		if (person == 24) SlaveGirl.AfterMeetNun(evt, chc);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (em != evtData && evtData.AfterMeetPersonAsAssistant(person, chc, evt) == true) return true;
		}
			
		return false;
	}
	
	public function HearGossip(person:Number, slut:Boolean, newg:Boolean) : Boolean
	{
		if (newg == undefined) newg = false;
		if (slut == undefined) slut = false;

		if (SlaveGirl.HearGossip(person, slut, newg) == true) return true; 
		if (coreGame.CurrentAsssistant.HearGossip(person, slut, newg) == true) return true;
		if (currentCity.HearGossip(person, slut, newg) == true) return true; 
		if (XMLData.PickAndDoXMLEvent("HearGossip")) return true;

		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.HearGossip(person, slut, newg) == true) return true;
		}
			
		return false;
	}
	
	// Shopping
	
	public function EventBuyer() : Boolean
	{
		if (CurrentAssistant.EventBuyerAsAssistant() == true) return true;
		if (SlaveGirl.EventBuyer() == true) return true;
		if (XMLData.XMLEvent("EventBuyer", false)) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.EventBuyerAsAssistant() == true) return true;
		}
			
		return false;
	}
	
	/*
		return
		  -1       = do standard purchase
		  1        = the dress was purchased
		  0        = the dress was not purchased
	*/
	public function BuyDress(cost:Number) : Number
	{
		coreGame.genNumber = cost;
		var bd:Number = coreGame.SlaveGirl.BuyDress(cost);
		if (bd == 0 || bd == 1) return bd;
		return XMLData.GetXMLValueParsed("BuyDress", undefined, -1);
	}
	
	/*
		return
		  -1       = do standard purchase
		  1        = the dress was purchased
		  0        = the dress was not purchased
	*/
	public function BuyUniform(cost:Number) : Number
	{
		coreGame.genNumber = cost;
		var bd:Number = coreGame.SlaveGirl.BuyUniform(cost);
		if (bd == 0 || bd == 1) return bd;
		return XMLData.GetXMLValueParsed("BuyUniform", undefined, -1);
	}
	
	// Stats
	
	public function ShowStatHint(stat:Number) : Boolean
	{
		coreGame.Hints.SetHintText("");
		if (SlaveGirl.ShowStatHint(stat) == true) {
			if (!coreGame.Hints.IsHintText()) coreGame.Hints.ShowHint(Language.GeneralText);
			else coreGame.Hints.ShowHint();
			return true;
		}
		if (CurrentAssistant.ShowStatHintAsAssistant(stat) == true) {
			if (!coreGame.Hints.IsHintText()) coreGame.Hints.ShowHint(Language.GeneralText);
			else coreGame.Hints.ShowHint();
			return true;
		}
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.ShowStatHintAsAssistant(stat) == true) {
				if (!coreGame.IsHintText()) coreGame.Hints.ShowHint(Language.GeneralText);
				else coreGame.Hints.ShowHint();
				return true;
			}
		}			
		return false;
	}

	public function LimitMaxMinStats()
	{	
		CurrentAssistant.LimitMaxMinStatsAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.LimitMaxMinStatsAsAssistant();
		}
	}
	
	public function UpdateSlave()
	{
		SlaveGirl.UpdateSlave();
		CurrentAssistant.UpdateSlaveAsAssistant();
		XMLData.XMLEventByNode(XMLData.usNode, false, undefined, true, true);		// "UpdateSlave"

		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.UpdateSlaveAsAssistant();
		}
	}

	
	public function UpdateDateAndItems(NumDays:Number)
	{
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.UpdateDateAndItemsAsAssistant(NumDays);
		}
	}
	
	public function ApplyDifficulty(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, SexualEnergy:Number, Sexuality:Number)
	{
		SlaveGirl.ApplyDifficulty(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special, SexualEnergy, Sexuality);
		XMLData.XMLEventCached("ApplyDifficulty", false, true);
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.ApplyDifficultyAsAssistant(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special, SexualEnergy, Sexuality);
		}
	}
	
	
	// Acts
	
	public function AfterJob(astr:String) : Boolean
	{
		switch (astr.toLowerCase()) {
			case "acolyte":
				SlaveGirl.AfterJobAcolyte(coreGame.Pay);
				if (IsEventAllowable()) Catgirls.AfterJobAcolyte(coreGame.Pay);
				if (IsEventAllowable()) AfterMeetPerson(24, coreGame.Pay, "acolyte");
				break;
			case "bar":
				SlaveGirl.AfterJobBar(coreGame.Pay);
				if (IsEventAllowable()) Catgirls.AfterJobBar(coreGame.Pay);
				break;
			case "brothel":
				SlaveGirl.AfterJobBrothel(coreGame.Pay);
				if (IsEventAllowable()) Catgirls.AfterJobBrothel(coreGame.Pay);
				break;
			case "cockmilking":
				SlaveGirl.AfterJobCockMilking(coreGame.Pay);
				break;
			case "library":
				SlaveGirl.AfterJobLibrary(coreGame.Pay);
				break;
			case "onsen":
				if (SlaveGirl.AfterJobOnsen(coreGame.PayRate, coreGame.NumEvent) == true) return true;
				break;
			case "restaurant":
				SlaveGirl.AfterJobRestaurant(coreGame.Pay);
				if (IsEventAllowable()) Catgirls.AfterJobRestaurant(coreGame.Pay);
				break;
			case "sleazybar":
				if (SlaveGirl.AfterJobSleazyBar(coreGame.Pay) == true) return true;
				break;
		}
		if (!IsEventAllowable()) return true;
		if (currentCity.AfterJob(astr)) return true;
		
		XMLData.DoXMLAct("AfterJob" + astr);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.AfterJob(astr) == true) return true;
		}
		
		return !IsEventAllowable();
	}
	
	public function AfterChore(astr:String) : Boolean
	{
		if (!IsEventAllowable()) return true;
		if (currentCity.AfterChore(astr)) return true;
		
		XMLData.DoXMLAct("AfterChore" + astr);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.AfterChore(astr) == true) return true;
		}
		
		return !IsEventAllowable();
	}
	
	public function AfterSchool(astr:String) : Boolean
	{
		switch (astr.toLowerCase()) {
			case "sciences":
				SlaveGirl.AfterSchoolSciences();
				if (IsEventAllowable()) Catgirls.AfterSchoolSciences();
				break;
			case "swimming":
				if (IsEventAllowable()) SlaveGirl.AfterSchoolSwimming();
				break;
			case "theology":
				SlaveGirl.AfterSchoolTheology();
				if (IsEventAllowable()) AfterMeetPerson(24, 0, "theology");
				break;
			case "refinement":
				SlaveGirl.AfterSchoolRefinement();
				if (IsEventAllowable()) Catgirls.AfterSchoolRefinement();
				break;
			case "singing":
				SlaveGirl.AfterSchoolSinging();
				if (IsEventAllowable()) Catgirls.AfterSchoolSinging();
				break;
			case "dance":
				SlaveGirl.AfterSchoolDance();
				if (IsEventAllowable()) Catgirls.AfterSchoolDance();
				break;
			case "xxx":
				SlaveGirl.AfterSchoolXXX();
				if (IsEventAllowable()) Catgirls.AfterSchoolXXX();			
				break;
		}
		if (!IsEventAllowable()) return true;
		if (currentCity.AfterSchool(astr)) return true;
		
		XMLData.DoXMLAct("AfterSchool" + astr);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.AfterSchool(astr) == true) return true;
		}
		
		return !IsEventAllowable();
	}
	
	
	public function ChangeActButtons(tab:Number)
	{
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.ChangeActButtonsAsAssistant(tab);
		}
	}
	
	public function SMCustomTraining(eventno:Number)
	{
		trainSlaveMaker.SMCustomTraining(eventno);

		SlaveGirl.SMCustomTraining(eventno);
		CurrentAssistant.SMCustomTrainingAsAssistant(eventno);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.ModuleName.toLowerCase().indexOf("smencounter") != -1 && eventno != 2516) continue;
			evtData.SMCustomTrainingAsAssistant(eventno);
		}
			
	}
	
	public function NewPlanningAction(type:Number, available:Boolean, hint:Boolean) : Boolean
	{
		if (SlaveGirl.NewPlanningAction(type, available, hint) == true) return true;
		if (CurrentAssistant.NewPlanningActionAsAssistant(type, available, hint) == true) return true;;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.NewPlanningActionAsAssistant(type, available, hint) == true) return true;
		}
	}
	
	public function AfterNewPlanningAction(type:Number, available:Boolean, hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		SlaveGirl.AfterNewPlanningAction(type, available, hint);
		if (!IsEventAllowable()) return;
		CurrentAssistant.AfterNewPlanningActionAsAssistant(type, available, hint);
		XMLData.XMLEventCached("AfterNewPlanningAction", false, false);
		if (!IsEventAllowable()) return;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterNewPlanningActionAsAssistant(type, available, hint);
			if (!IsEventAllowable()) return;
		}
		
		coreGame.PositionQuestions();
		coreGame.PositionYesNo();
	}
	
	public function DoNewPlanningYes()
	{
		SlaveGirl.DoNewPlanningYes();
		CurrentAssistant.DoNewPlanningYes();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.DoNewPlanningYes();
		}
	}
	
	public function DoPlanningAction(act:Number) : Boolean
	{
		if (SlaveGirl.DoPlanningAction(act) == true) return true;
		if (CurrentAssistant.DoPlanningActionAsAssistant(act) == true) return true;
		if (XMLData.XMLEventCached("DoPlanningAction", false, false)) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoPlanningActionAsAssistant(act) == true) return true;
		}
		return false;
	
	}
	
	public function AfterPlanningAction(evno:Number)
	{
		//trace("AfterPlanningAction");
		if (!IsEventAllowable()) return;
		SlaveGirl.AfterPlanningAction(evno);
		if (!IsEventAllowable()) return;
		CurrentAssistant.AfterPlanningActionAsAssistant(evno);
		if (!IsEventAllowable()) return;
		
		if (XMLData.XMLEventCached("AfterPlanningAction")) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterPlanningActionAsAssistant(evno);
			if (!IsEventAllowable()) return;
		}
			
	}
	
	public function DoSlaveTalk(sd:Object, act:Number) : Boolean
	{
		coreGame.genNumber = act;
		coreGame.Action = act;
		var pname:String = sd.SlaveName; 
		
		if (SlaveGirl.DoSlaveTalk(pname) == true) return true;
		if (XMLData.XMLEventCached("DoSlaveTalk")) return true;
		if (CurrentAssistant.DoSlaveTalkAsAssistant(pname) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoSlaveTalkAsAssistant(pname) == true) return true;
		}
		return false;
	}
	
	public function DoSlaveIntimacy(sd:Object, act:Number) : Boolean
	{
		coreGame.genNumber = act;
		coreGame.Action = act;
		var pname:String = sd.SlaveName; 
		
		if (SlaveGirl.DoSlaveIntimacy(pname) == true) return true;
		if (XMLData.XMLEventCached("DoSlaveIntimacy")) return true;
		if (coreGame.PersonIndex != -50 && coreGame.PersonIndex != -100) {
			var ifNode:XMLNode = XMLData.GetNodeC(coreGame.sdata.sNode, "Events/DoSlaveIntimacy");
			if (ifNode == null) ifNode = XMLData.GetNodeC(coreGame.sdata.sNode, "Planning/DoPlanning/DoSlaveIntimacy");
			if (ifNode == null) ifNode = XMLData.GetNodeC(coreGame.sdata.sNode, "Other/DoSlaveIntimacy");
			if (ifNode != null) {
				if (coreGame.ParseEvent(ifNode, false)) return true;
			}
		}
		if (CurrentAssistant.DoSlaveIntimacyAsAssistant(pname) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoSlaveIntimacyAsAssistant(pname) == true) return true;
		}
		return false;
	}

	
	
	// Event handlers
	
	public function DoEventNext() : Boolean
	{
		if (coreGame.currentDialog != null && coreGame.currentDialog.DoEventNext() == true) return true;
		
		if (SlaveGirl.DoEventNext() == true) return true;
		if (XMLData.XMLEventCached("EventNext")) return true;
		if (CurrentAssistant.DoEventNextAsAssistant() == true) return true;
		if (currentCity.DoEventNext() == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoEventNextAsAssistant() == true) return true;
		}
					
		if (coreGame.EndGame.DoEventNext() == true) return true;
		if (Contests.DoEventNext() == true) return true;		
		if (trainSlaveMaker.DoEventNext() == true) return true;
		return false;
	}
	
	public function AfterEventNext(nonext:Boolean)
	{
		if (nonext != true) {
			if (coreGame.GirlsStoryTop._visible) coreGame.ShowGirlsStory();
			else coreGame.ShowPlanningNext();
		}
		SlaveGirl.AfterEventNext();
		XMLData.XMLEventCached("AfterEventNext");
		CurrentAssistant.AfterEventNextAsAssistant();
		currentCity.AfterEventNextAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterEventNextAsAssistant();
		}
			
	}

	
	public function DoEventYes() : Boolean
	{
		if (coreGame.currentDialog != null && coreGame.currentDialog.DoEventYes() == true) return true;

		if (SlaveGirl.DoEventYes() == true) return true;
		if (XMLData.XMLEventCached("DoEventYes")) return true;
		if (CurrentAssistant.DoEventYesAsAssistant() == true) return true;
		if (currentCity.DoEventYes() == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoEventYesAsAssistant() == true) return true;
		}
					
		if (coreGame.EndGame.DoEventYes() == true) return true;
		if (Contests.DoEventYes() == true) return true;
		if (trainSlaveMaker.DoEventYes() == true) return true;
		
		return false;
	}
	
	private function AfterEventYesNoCommon()
	{
		if (coreGame.currentShop != null) return;
		if (coreGame.Quitter._visible == false && coreGame.NextEvent._visible == false && coreGame.AskQuestions._visible == false && coreGame.YesEvent._visible == false && coreGame.VisitFortuneTeller._visible == false && !coreGame.EndGame.IsShown() && !Contests.IsContestStarted()) {
			if (coreGame.Plannings.IsStarted()) coreGame.ShowPlanningNext();
			else if (coreGame.NumEvent < 100  && coreGame.NumEvent != 0 && coreGame.NumEvent != 43) coreGame.ShowMainButtons();
		}
	}
	
	public function AfterEventYes()
	{
		AfterEventYesNoCommon();
		SlaveGirl.AfterEventYes();
		XMLData.XMLEventCached("AfterEventYes");
		CurrentAssistant.AfterEventYesAsAssistant();
		currentCity.AfterEventYesAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterEventYesAsAssistant();
		}
			
	}
	
	public function DoEventNo() : Boolean
	{
		if (coreGame.currentDialog != null && coreGame.currentDialog.DoEventNo() == true) return true;

		if (SlaveGirl.DoEventNo() == true) return true;
		if (XMLData.XMLEventCached("DoEventNo")) return true;
		if (CurrentAssistant.DoEventNoAsAssistant() == true) return true;
		if (currentCity.DoEventNo() == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoEventNoAsAssistant() == true) return true;
		}
					
		if (coreGame.EndGame.DoEventNo() == true) return true;
		if (Contests.DoEventNo() == true) return true;
		if (trainSlaveMaker.DoEventNo() == true) return true;
		
		return false;
	}
	
	public function AfterEventNo()
	{
		AfterEventYesNoCommon();
		SlaveGirl.AfterEventNo();
		XMLData.XMLEventCached("AfterEventNo");
		CurrentAssistant.AfterEventNoAsAssistant();
		currentCity.AfterEventNoAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterEventNoAsAssistant();
		}
			
	}
	
	public function Events(possible:Boolean)
	{
		if (possible) {
			if (XMLData.PickAndDoXMLEvent("Daily")) {
				if (coreGame.DoneEvent == 0) coreGame.DoEvent(9999);
			}
		}
		
		SlaveGirl.Events(coreGame.DoneEvent == 0);
		CurrentAssistant.EventsAsAssistant(coreGame.DoneEvent == 0);
		currentCity.EventsAsAssistant(coreGame.DoneEvent == 0);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.EventsAsAssistant(coreGame.DoneEvent == 0);
		}
			
	}
	
	public function EventsUrgent(possible:Boolean)
	{
		if (possible) {
			if (XMLData.PickAndDoXMLEvent("DailyUrgent")) {
				if (coreGame.DoneEvent == 0) coreGame.DoEvent(9999);
			}
		}
		
		SlaveGirl.EventsUrgent(coreGame.DoneEvent == 0);
		CurrentAssistant.EventsUrgentAsAssistant(coreGame.DoneEvent == 0);
		currentCity.EventsUrgentAsAssistant(coreGame.DoneEvent == 0);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.EventsUrgentAsAssistant(coreGame.DoneEvent == 0);
		}
	}
	
	public function AfterEvents()
	{
		SlaveGirl.AfterEvents();
		XMLData.XMLEventCached("AfterEvents");
		CurrentAssistant.AfterEventsAsAssistant();
		currentCity.AfterEventsAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterEventsAsAssistant();
		}
	}
	
	public function PreEvent(num:Number) : Boolean
	{
		if (SlaveGirl.PreEvent(num) == true) return true;
		if (CurrentAssistant.PreEventAsAssistant(num) == true) return true;
		if (currentCity.PreEventAsAssistant(num) == true) return true;
		
		if (num == 1) {
			if (XMLData.PickAndDoXMLEvent("EarlyMorning")) return true;
		}
		if (XMLData.PickAndDoXMLEvent("EarlyMorning" + num)) return true; 
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.PreEventAsAssistant(num) == true) return true;
		}
		return false;
	}
	
	public function SMPreEvent() : Boolean
	{
		if (currentCity.SMPreEvent() == true) return true;
		
		if (XMLData.PickAndDoXMLEvent("SlaveMakerEarlyMorning")) return true; 
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.SMPreEvent() == true) return true;
		}			
		return false;
	}
	
	public function StartDay() : Boolean
	{
		if (SlaveGirl.StartDay() == true) return true;
		if (XMLData.PickAndDoXMLEvent("StartDay")) return true;
		if (CurrentAssistant.StartDayAsAssistant() == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.StartDayAsAssistant() == true) return true;
		}
			
		return false;
	}
	
	public function StartNight(beginning:Boolean) : Boolean
	{
		coreGame.FirstTimeToday = beginning;
		if (!beginning) {
			if (SlaveGirl.StartNight() == true) return true;
			if (XMLData.PickAndDoXMLEvent("StartNight")) return true;
		}
		if (CurrentAssistant.StartNightAsAssistant(beginning) == true) return true;
		if (beginning) {
			if (XMLData.PickAndDoXMLEvent("StartNightBeginning")) return true;
			return false;
		}
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.StartNightAsAssistant(beginning) == true) return true;
		}
			
		return false;
	}
	
	public function AfterNight() : Boolean
	{
		if (SlaveGirl.AfterNight() == true) return true;
		if (XMLData.PickAndDoXMLEvent("AfterNight")) return true;
		if (CurrentAssistant.AfterNightAsAssistant() == true) return true;
		if (currentCity.AfterNight() == true) return true;

		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.AfterNightAsAssistant() == true) return true;
		}
		return false;
	}
	
	public function StartMorning() : Boolean
	{
		if (SlaveGirl.StartMorning() == true) return true;
		if (XMLData.PickAndDoXMLEvent("StartMorning")) return true;
		if (CurrentAssistant.StartMorningAsAssistant() == true) return true;
		if (currentCity.StartMorning() == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.StartMorningAsAssistant() == true) return true;
		}
		return false;
	}
	public function StartMorningReport()
	{
		SlaveGirl.StartMorningReport();
		XMLData.PickAndDoXMLEvent("StartMorningReport");
		CurrentAssistant.StartMorningReportAsAssistant();
		currentCity.StartMorningReport();
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.StartMorningReportAsAssistant();
		}			
	}	

	public function StartEvening() : Boolean
	{
		if (SlaveGirl.StartEvening() == true) return true;
		if (XMLData.PickAndDoXMLEvent("StartEvening")) return true;
		if (CurrentAssistant.StartEveningAsAssistant() == true) return true;
		if (currentCity.StartEvening() == true) return true;

		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.StartEveningAsAssistant() == true) return true;
		}
		return false;
	}
	public function StartEveningReport()
	{
		SlaveGirl.StartEveningReport();
		XMLData.PickAndDoXMLEvent("StartEveningReport");
		CurrentAssistant.StartEveningReportAsAssistant();
		currentCity.StartEveningReport();
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.StartEveningReportAsAssistant();
		}			
	}	

	public function EventRescue() : Boolean
	{
		if (SlaveGirl.EventRescue() == true) return true;
		if (CurrentAssistant.EventRescueAsAssistant() == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.EventRescueAsAssistant() == true) return true;
		}
		return false;
	}
	
	
	// Contests

	public function ContestBonus(numcontest:Number)
	{
		coreGame.genNumber = numcontest;
		// assistant
		var ab:Number = coreGame.CurrentAssistant.ContestBonus(numcontest);
		if (ab != undefined) coreGame.Score += Math.floor(ab);
		coreGame.Score += XMLData.GetXMLValueParsed("ContestBonus", Language.assNode);
		
		// slave
		ab = SlaveGirl.ContestBonus(numcontest);
		if (ab != undefined) coreGame.Score += Math.floor(ab);
		coreGame.Score += XMLData.GetXMLValueParsed("ContestBonus", XMLData.GetCurrentSlaveXML());
		
		// Others
		coreGame.Score += XMLData.GetXMLValueParsed("ContestBonus", "Events");
	}
	
	public function StartContest(numcontest:Number, acti:ActInfo)
	{
		coreGame.genNumber = numcontest;
		coreGame.genNumber2 = acti == null ? 0 : acti.Act;
		CurrentAssistant.StartContestAsAssistant(numcontest, coreGame.genNumber2);
		SlaveGirl.StartContest(numcontest, coreGame.genNumber2);
		XMLData.XMLGeneral("Contests/StartContest");
		if (acti != null) XMLData.XMLGeneral("Contests/" + acti.strNodeName + "/StartContest");
		currentCity.StartContestAsAssistant(numcontest, coreGame.genNumber2);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.StartContestAsAssistant(numcontest, coreGame.genNumber2);
		}			
	}
	
	public function DoContestsNext(numcontest:Number, actno:Number) : Boolean
	{
		coreGame.genNumber = numcontest;
		coreGame.genNumber2 = actno;
		if (SlaveGirl.DoContestsNext(numcontest, actno) == true) return true;
		if (XMLData.XMLGeneral("Contests/ContestsNext")) return true;
		if (CurrentAssistant.DoContestsNextAsAssistant(numcontest, actno) == true) return true;
		if (currentCity.DoContestsNext(numcontest, actno) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoContestsNextAsAssistant(numcontest, actno) == true) return true;
		}
		return false;
	}


	// Combat
	
	public function ShowAttackChoices(runmsg:Number) : Boolean
	{
		if (SlaveGirl.ShowAttackChoices(runmsg) == true) return true;
		if (XMLData.XMLEventByNode(XMLData.GetNode(coreGame.slaveNode, "Combat/CustomWeapon"), true, undefined, false, true)) return true;
		if (CurrentAssistant.ShowAttackChoicesAsAssistant(runmsg) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.ShowAttackChoicesAsAssistant(runmsg) == true) return true;
		}
		return false;
	}


	// Walks
	
	public function TakeAWalk(place:Number) : Boolean
	{
		if (SlaveGirl.TakeAWalk(place) == true) return true;
		if (XMLData.XMLEvent("TakeAWalk")) return true;
		if (CurrentAssistant.TakeAWalkAsAssistant(place) == true) return true;
		if (currentCity.TakeAWalkAsAssistant(place) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.TakeAWalkAsAssistant(place) == true) return true;
		}
		return false;
	}
	
	public function DoWalkHouse(house:Number) : Boolean
	{
		if (SlaveGirl.DoWalkHouse(house) == true) return true;
		if (CurrentAssistant.DoWalkHouseAsAssistant(house) == true) return true;
		if (currentCity.DoWalkHouseAsAssistant(house) == true) return true;
		
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkHouseAsAssistant(house) == true) return true;
		}
		return false;
	}
	
	public function AfterWalk(place:Number)
	{
		if (place == 0) return;
		
		SlaveGirl.AfterWalk(place);
		
		if (XMLData.XMLEventCached("AfterWalk")) return;
	
		CurrentAssistant.AfterWalkAsAssistant(place);
		currentCity.AfterWalkAsAssistant(place);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterWalkAsAssistant(place);
		}
	}
	
	public function DoWalk(place:Number) : Boolean
	{
		currentCity.ResetWalkLocations();
		
		if (XMLData.XMLEventCached("DoWalk")) return true;
		
		switch (place) {
			case 1: return DoWalkForest();
			//case 1.1: return DoWalkDeepForest();
			case 2: return DoWalkLake();
			case 3: return DoWalkTownCenter();
			case 4: return DoWalkSlums();
			case 5: return DoWalkPalace();
			case 6.1: return DoWalkDocksPort();
			case 6.2: return DoWalkDocksSlavePens();
			case 6.3: return DoWalkDocksSlavePensSecure();
			case 7: return DoWalkFarm();
			case 8: return DoWalkRuins();
			case 9:
			case 9.1: return DoWalkBeachWalk();
			case 9.2: return DoWalkBeachSwim();
			case 9.3: return DoWalkBeachPrivate();
			case 9.4: return DoWalkBeachRocks();
			case 10: 
			case 10.1: 
			case 10.2: 
			case 10.3: return DoWalkSlaveMarket();
		}
		return false;
	}
	
	public function DoWalkBeachSwim() : Boolean
	{
		if (SlaveGirl.DoWalkBeachSwim(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkBeachSwimAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkBeachSwimAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkBeachWalk() : Boolean
	{
		if (SlaveGirl.DoWalkBeachWalk(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkBeachWalkAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkBeachWalkAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkBeachPrivate() : Boolean
	{
		if (SlaveGirl.DoWalkBeachPrivate(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkBeachPrivateAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkBeachPrivateAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkBeachRocks() : Boolean
	{
		if (SlaveGirl.DoWalkBeachRocks(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkBeachRocksAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkBeachRocksAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkFarm() : Boolean
	{
		if (SlaveGirl.DoWalkFarm(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkFarmAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkFarmAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkForest() : Boolean
	{
		if (SlaveGirl.DoWalkForest(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkForestAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkForestAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkLake() : Boolean
	{
		if (SlaveGirl.DoWalkLake(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkLakeAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkLakeAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkPalace() : Boolean
	{
		if (SlaveGirl.DoWalkPalace(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkPalaceAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkPalaceAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkRuins() : Boolean
	{
		if (SlaveGirl.DoWalkRuins(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkRuinsAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkRuinsAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkSlums() : Boolean
	{
		if (SlaveGirl.DoWalkSlums(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkSlumsAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkSlumsAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkTownCenter() : Boolean
	{
		if (SlaveGirl.DoWalkTownCenter(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkTownCenterAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkTownCenterAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkDocksPort() : Boolean
	{
		if (SlaveGirl.DoWalkDocksPort(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkDocksPortAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkDocksPortAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkDocksSlavePens() : Boolean
	{
		if (SlaveGirl.DoWalkDocksSlavePens(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkDocksSlavePensAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkDocksSlavePensAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DoWalkDocksSlavePensSecure() : Boolean
	{
		if (SlaveGirl.DoWalkDocksSlavePensSecure(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkDocksSlavePensSecureAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkDocksSlavePensSecureAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}
			
		return false;
	}
	
	public function DocksAreas(secure:Boolean)
	{
		SlaveGirl.DocksAreas(secure);
		CurrentAssistant.DocksAreasAsAssistant(secure);
			
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.DocksAreasAsAssistant(secure);
		}			
	}
	
	public function BeachActivities()
	{
		SlaveGirl.BeachActivities();
		CurrentAssistant.BeachActivitiesAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.BeachActivitiesAsAssistant();
		}			
	}
	
	public function DoWalkSlaveMarket() : Boolean
	{
		if (SlaveGirl.DoWalkSlaveMarket(coreGame.NumEvent) == true) return true;
		if (CurrentAssistant.DoWalkSlaveMarketAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.DoWalkSlaveMarketAsAssistant(coreGame.NumEvent, !coreGame.Supervise) == true) return true;
		}			
		return false;
	}
	
	
	// Endings
	
	public function ShowTrainingComplete() : Boolean
	{
		if (SlaveGirl.ShowTrainingComplete() == true) return true;
		if (XMLData.XMLEvent("EndGame/TrainingComplete", true)) return true;
		if (CurrentAssistant.ShowTrainingCompleteAsAssistant() == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.ShowTrainingCompleteAsAssistant() == true) return true;
		}			
		return false;
	}
	
	public function CheckMetaEndings()
	{
		if (XMLData.XMLEvent("EndGame/CheckMetaEndings", true)) return;
		if (SlaveGirl.CheckMetaEndings(coreGame.arGeneralArray) == true) return;
		if (CurrentAssistant.CheckMetaEndingsAsAssistant(coreGame.arGeneralArray) == true) return;
		if (currentCity.CheckMetaEndings(coreGame.arGeneralArray) == true) return;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.CheckMetaEndingsAsAssistant(coreGame.arGeneralArray) == true) return;
		}			
	}
	
	public function EndingStart() : Boolean
	{
		var fin:Number = coreGame.NumFin;
		coreGame.NumFin = 0;
		XMLData.XMLEvent("EndGame/EndingStart", true);
		if (coreGame.NumFin != 0) return true;
		coreGame.NumFin = fin;
		if (SlaveGirl.EndingStart(coreGame.Score) == true) return true;
		if (coreGame.NumFin != fin) return false;
		if (CurrentAssistant.EndingStartAsAssistant(coreGame.Score) == true) return true;
		if (coreGame.NumFin != fin) return false;
		if (People.EndingStart(coreGame.Score) == true) return true;
		if (coreGame.NumFin != fin) return false;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.EndingStartAsAssistant(coreGame.Score) == true) return true;
			if (coreGame.NumFin != fin) return false;
		}
			
		return false;
	}
	
	public function EndingFinish() : Boolean
	{
		if (XMLData.XMLEvent("EndGame/EndingFinish", true)) return true;
		if (SlaveGirl.EndingFinish(coreGame.Score) == true) return true;
		if (CurrentAssistant.EndingFinishAsAssistant(coreGame.Score) == true) return true;
		if (People.EndingFinish(coreGame.Score) == true) return true;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.EndingFinishAsAssistant(coreGame.Score) == true) return true;
		}
			
		return false;
	}
	
	public function AfterEndingFinish()
	{
		XMLData.XMLEvent("EndGame/AfterEndingFinish", true);
		SlaveGirl.AfterEndingFinish(coreGame.Score);
		CurrentAssistant.AfterEndingFinishAsAssistant(coreGame.Score);
		People.AfterEndingFinish(coreGame.Score);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AfterEndingFinishAsAssistant(coreGame.Score);
		}
			
		return false;
	}
	
	public function NumCustomEndings() : Number
	{
		var numc:Number = CurrentAssistant.NumCustomEndingsAsAssistant();
		if (numc == undefined) numc = 0;
		
		var num:Number;
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			num = evtData.NumCustomEndingsAsAssistant();
			if (num != undefined) numc += num;
		}
		return numc;
	}
	
	public function ShowEndings(numend:Number)
	{
		var numc:Number = CurrentAssistant.NumCustomEndingsAsAssistant();
		if (numc == undefined) numc = 0;
		
		if (numc > 0 && numend < numc) {
			CurrentAssistant.ShowEndingsAsAssistant(numend);
			return;
		}
		numend -= numc;
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			numc = evtData.NumCustomEndingsAsAssistant();
			if (numc != undefined && numc > 0) {
				if (numend < numc) {
					evtData.ShowEndingsAsAssistant(numend);
					return;
				}
				numend -= numc;
			}
		}
	}
	
	
	// Items
	
	public function EquipItem(item:Number) : Boolean
	{
		if (SlaveGirl.EquipItem(item) == true) return true;
		if (CurrentAssistant.EquipItemAsAssistant(item) == true) return true;
		coreGame.genNumber = item;
		var iNode:XMLNode = XMLData.GetNodeC(coreGame.slaveNode, "Items");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.slaveNode, "Equipment");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.flNode, "Equipment");
		if (iNode != null) {
			var ciNode:XMLNode;
			if (item >= 50 && item < 80) ciNode = XMLData.GetNode(iNode, "Custom" + (item - 49));
			else ciNode = XMLData.GetNode(iNode, "Item" + item);
			if (ciNode != undefined) {
				if (XMLData.XMLEventByNode(ciNode, true, "EquipItem")) return true;
			}
		}	
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.EquipItemAsAssistant(item) == true) return true;
		}
		return false;
	}
	
	public function WearItem(item:Number) : Boolean
	{
		if (SlaveGirl.WearItem(item) == false) return false;
		if (CurrentAssistant.WearItemAsAssistant(item) == false) return false;
		coreGame.genNumber = item;
		var iNode:XMLNode = XMLData.GetNodeC(coreGame.slaveNode, "Items");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.slaveNode, "Equipment");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.flNode, "Equipment");
		if (iNode != null) {
			var ciNode:XMLNode;
			if (item >= 50 && item < 80) ciNode = XMLData.GetNode(iNode, "Custom" + (item - 49));
			else ciNode = XMLData.GetNode(iNode, "Item" + item);
			if (ciNode != undefined) {
				if (XMLData.XMLEventByNode(ciNode, true, "WearItem")) return false;
			}
		}	
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.WearItemAsAssistant(item) == false) return false;
		}
		return true;
	}
	
	public function UnEquipItem(item:Number) : Boolean
	{
		if (SlaveGirl.UnEquipItem(item) == true) return true;
		if (CurrentAssistant.UnEquipItemAsAssistant(item) == true) return true;
		coreGame.genNumber = item;
		var iNode:XMLNode = XMLData.GetNodeC(coreGame.slaveNode, "Items");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.slaveNode, "Equipment");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.flNode, "Equipment");
		if (iNode != null) {
			var ciNode:XMLNode;
			if (item >= 50 && item < 80) ciNode = XMLData.GetNode(iNode, "Custom" + (item - 49));
			else ciNode = XMLData.GetNode(iNode, "Item" + item);
			if (ciNode != undefined) {
				if (XMLData.XMLEventByNode(ciNode, true, "UnEquipItem")) return true;
			}
		}
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.UnEquipItemAsAssistant(item) == true) return true;
		}
		return false;
	}
	
	public function RemoveItem(item:Number) : Boolean
	{
		if (SlaveGirl.RemoveItem(item) == false) return false;
		if (CurrentAssistant.RemoveItemAsAssistant(item) == false) return false;
		coreGame.genNumber = item;
		var iNode:XMLNode = XMLData.GetNodeC(coreGame.slaveNode, "Items");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.slaveNode, "Equipment");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.flNode, "Equipment");
		if (iNode != null) {
			var ciNode:XMLNode;
			if (item >= 50 && item < 80) ciNode = XMLData.GetNode(iNode, "Custom" + (item - 49));
			else ciNode = XMLData.GetNode(iNode, "Item" + item);
			if (ciNode != undefined) {
				if (XMLData.XMLEventByNode(ciNode, true, "RemoveItem")) return false;
			}
		}
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.RemoveItemAsAssistant(item) == false) return false;
		}
		return true;
	}
	
	public function ShowItemDescription(item:Number) : Boolean
	{
		if (SlaveGirl.ShowItemDescription(item) == true) return true;
		if (CurrentAssistant.ShowItemDescriptionAsAssistant(item) == true) return true;
		coreGame.genNumber = item;
		if (currentCity.ShowItemDescription(item) == true) return true;
		var iNode:XMLNode = XMLData.GetNodeC(coreGame.slaveNode, "Items");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.slaveNode, "Equipment");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.flNode, "Equipment");
		if (iNode != null) {
			var ciNode:XMLNode;
			if (item >= 50 && item < 80) ciNode = XMLData.GetNodeC(iNode, "Custom" + (item - 49));
			else ciNode = XMLData.GetNodeC(iNode, "Item" + item);
			if (ciNode != undefined) {
				Language.SetLangGeneralText("Description", ciNode);
				AddGeneralText("\r\r");
				return true;
			}
		}
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.ShowItemDescriptionAsAssistant(item) == true) return true;
		}
		return false;
	}
	
	public function HideItems()
	{
		SlaveGirl.HideItems();
		CurrentAssistant.HideItemsAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.HideItemsAsAssistant();
		}
	}
	
	public function HideItem(item:Number, align:Number)
	{
		SlaveGirl.HideItem(item, align);
		CurrentAssistant.HideItemAsAssistant(item, align);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.HideItemAsAssistant(item, align);
		}
	}
	
	public function ShowItem(item:Number, place:Number, align:Number, gframe:Number) : Boolean
	{
		if (SlaveGirl.ShowItem(item, place, align, gframe) == true) return true;
		if (CurrentAssistant.ShowItemAsAssistant(item, place, align, gframe) == true) return true;
		if (currentCity.ShowItem(item, place, align, gframe) == true) return true;
		coreGame.genNumber = item;
		var iNode:XMLNode = XMLData.GetNodeC(coreGame.slaveNode, "Items");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.slaveNode, "Equipment");
		if (iNode == null) iNode = XMLData.GetNodeC(coreGame.flNode, "Equipment");
		if (iNode != null) {
			var ciNode:XMLNode;
			if (item >= 50 && item < 80) ciNode = XMLData.GetNode(iNode, "Custom" + (item - 49));
			else ciNode = XMLData.GetNode(iNode, "Item" + item);
			if (ciNode != null) {
				if (XMLData.XMLEventByNode(ciNode, false, "ShowItem", true)) return true;
			}
		}
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			if (evtData.ShowItemAsAssistant(item, place, align, gframe) == true) return true;
		}
		return false;
	}
	
	public function ShowOtherSMEquipment()
	{
		SlaveGirl.ShowOtherSMEquipment();
		XMLData.XMLEvent("ShowOtherSMEquipment", false, true);
		CurrentAssistant.ShowOtherSMEquipmentAsAssistant();
		currentCity.ShowOtherSMEquipment();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.ShowOtherSMEquipmentAsAssistant();
		}
			
	}
	
	public function ShowOtherEquipment() 
	{
		SlaveGirl.ShowOtherEquipment();
		XMLData.XMLEvent("ShowOtherEquipment", false, true);
		CurrentAssistant.ShowOtherEquipmentAsAssistant();
		currentCity.ShowOtherEquipment();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.ShowOtherEquipmentAsAssistant();
		}
	}
	
	public function SetEquipmentTabs()
	{
		CurrentAssistant.SetEquipmentTabsAsAssistant();
		currentCity.SetEquipmentTabsAsAssistant();
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.SetEquipmentTabsAsAssistant();
		}
	}
	
	public function ShowEquipmentTab(nTab:Number)
	{
		CurrentAssistant.ShowEquipmentTabAsAssistant(nTab);
		currentCity.ShowEquipmentTabAsAssistant(nTab);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.ShowEquipmentTabAsAssistant(nTab);
		}
	}
		
	// Special Trainings
	public function GetSpecialTrainingList(sd:Object) : String
	{
		if (sd == undefined) sd = _root;
		
		var str:String = "";
		var tb:TrainingBase;
		
		var i:Number = elength;
		while (--i >= 0) {
			tb = arEventsArray[i];
			if (tb.ModuleName.substr(-8).toLowerCase() != "training") continue;
			var nstr:String = tb.GetTrainingListDetails(sd);
			if (nstr != undefined && nstr != "") str = str + nstr + " ";
		}
		
		if (sd.VirginVaginal && sd.VirginAnal && sd.VirginOral) str = str + Language.GetText("ShortDescriptionUntouched", "SlaveTrainings/Virgin") +  " ";
		else if (sd.IsFemale() && sd.VirginVaginal) str = str + Language.GetText("ShortDescriptionVirgin", "SlaveTrainings/Virgin") + " ";
		
		var strTrain:String = XMLData.GetXMLStringParsed("Trainings", sd == _root ? undefined : sd.sNode, "");
		if (strTrain != "") str = str + " " + strTrain.split(",").join(" ");
		return str;
	}
	
	// Acts/Experiences
	
	public function AddExperiences(drugs:Boolean, sd:Object)
	{
		if (sd == undefined) sd = _root;
		SlaveGirl.AddExperiences(drugs, sd);
		XMLData.XMLEvent("AddExperiences");
		CurrentAssistant.AddExperiencesAsAssistant(drugs, sd);
		currentCity.AddExperiencesAsAssistant(drugs, sd);
		
		var i:Number = elength;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.AddExperiencesAsAssistant(drugs, sd);
		}
	}
	
	// Slave/Module classes
	
	public function CreateSlaveGirl(sdo:Object)
	{
		SlaveGirl = CreateSlaveModuleClassFromFilename(coreGame.SlaveFilename, coreGame.SlaveMovie, _root, coreGame);
		if (SlaveGirl == undefined || SlaveGirl == null) {
			trace("...class not found");
			SlaveGirl = coreGame.SlaveMovie;
			SlaveGirl.mcBase = coreGame.SlaveMovie;
			SlaveGirl.slaveData = _root;
			SlaveGirl.sd = _root;
			SlaveGirl.SMData = SMData;
			SlaveGirl.Diary = Diary;
			SlaveGirl.Backgrounds = Backgrounds;
			SlaveGirl.coreGame = coreGame;
		} else {
			trace("...class found");
			SlaveGirl.slaveData = _root;
			SlaveGirl.sd = _root;
		}
		
		sdo.SlaveType = -10;		// set slave to the current slave in training
		
		coreGame.SlaveGirl = SlaveGirl;
		coreGame.ActInfoCurrent = sdo.ActInfoCurrent;
		coreGame.SlaveData = sdo;		// obsolete
		
		SlaveGirl.InitialiseModule();
	}
	
	private function GetSlaveClassFromFilename(str:String) : String
	{
		var ext:String = str.substr(-4);
		if (ext == "" || ext == ".xml" || ext == undefined) return "GenericSlave";
		var sl:Array = str.slice(0, -4).split("-");
		if (sl[1] != "") return sl[1];
		return sl[0];
	}
	
	public function CreateSlaveModuleClassFromFilename(strName:String, mv:MovieClip, sd:Object, core:Object) : SlaveModule { return CreateSlaveModuleClass(GetSlaveClassFromFilename(strName), mv, sd, core); }
	
	public function CreateSlaveModuleClass(strClass:String, mv:MovieClip, sd:Object, core:Object) : SlaveModule
	{
		//ListSMClasses(mv);
		
		if (strClass == "GenericSlave") return new Scripts.Classes.GenericSlave(mv, sd, core);
		
		// try base name like Ranma or Mai
		var sm:SlaveModule = CreateSMClass(strClass, mv, sd, core);
		if (sm != null) return sm;
		
		// try SlaveRanma 
		return CreateSMClass("Slave" + strClass, mv, sd, core);
	}
	
	private function CreateSMClass(strClass:String, mv:MovieClip, sd:Object, core:Object) : SlaveModule
	{
		// try Scripts 'folder'
		var obj:Object = FindSlaveClass(_global["Classes"], strClass);
		var sm:SlaveModule = obj.main(mv, sd, core);
		if (sm != null) {
			trace("create " + strObj);
			return sm;
		}
			
		// try base folder only, do not iterate containing objects
		for (var strObj:String in _global) {
			if (strObj == strClass) {
				trace("create " + strObj);
				return _global[strObj].main(mv, sd, core);
			}
		}
		
		// try Scripts 'folder'
		obj = FindSlaveClass(_global["Scripts"], strClass);
		sm = obj.main(mv, sd, core);
		if (sm != null) {
			trace("create " + strObj);
			return sm;
		}
	
		// try movieclip specified
		if (mv != undefined) {
			obj = FindSlaveClass(_global[mv._name], strClass);
			trace("obj1 = " + obj);
			if (obj != null) {
				sm = obj.main(mv, sd, core);
				return sm;
			}
			obj = FindSlaveClass(_global[mv._name]["Scripts"], strClass);
			trace("obj2 = " + obj);
			if (obj != null) {
				sm = obj.main(mv, sd, core);
				if (sm != null) {
					trace("create " + strObj);
					return sm;
				}
			}
		}
		sm = mv.main(mv, sd, core);
		return sm;
	}
	
	public function FindSlaveClass(obj:Object, str:String) : Object
	{
		var obj2:Object;
		var tstr:String;
		for (var strObj:String in obj) {
			if (strObj == str) return obj[strObj];
			tstr = typeof(obj[strObj]);
			if (tstr == "function" || tstr == "object" || tstr == "movieclip") {	 
				obj2 = FindSlaveClass(obj[strObj], str);
				if (obj2 != null) return obj2;
			}
		}
		return null;
	}

	/*
	public function ListSMClasses(mv:MovieClip)
	{
		trace("ListSMClasses");
		
		// try Scripts 'folder'
		ListClasses(_global["Classes"], "_global.Classes");
			
		// try base folder only, do not iterate containing objects
		for (var strObj:String in _global) {
			trace("class _global: " + strObj);
		}
		
		// try Scripts 'folder'
		ListClasses(_global["Scripts"], "_global.Scripts");
	
		// try movieclip specified
		trace("ListSMClasses: " + mv);
		if (mv != undefined) {
			ListClasses(_global[mv._name], mv._name);
			trace("ListSMClasses: " + mv + " Scripts");
			ListClasses(_global[mv._name]["Scripts"], mv._name);
		}
	}
	
	public function ListClasses(obj:Object, str:String)
	{
		var obj2:Object;
		var tstr:String;
		for (var strObj:String in obj) {
			trace("class " + str + ": " + strObj);
			tstr = typeof(obj[strObj]);
			if (tstr == "function" || tstr == "object" || tstr == "movieclip") {	 
				ListClasses(obj[strObj], str + "." + strObj);
			}
		}
	}
	*/
	
	// Miscellaneous
	
	public function Reset()
	{
		//var i:Number = elength;
		//while (--i >= 0) evtData = arEventsArray[i];
	}
	
	private function DebugModule() : String
	{
		var evtname:String;
		var evtarray:Array;
		var pos:Number;
		
		if (evtData.ModuleName.toLowerCase().substr(0, 6) == "event-") {
			evtarray = evtData.ModuleName.split("-");
			evtname = evtarray[evtarray.length-1];
		} else evtname = evtData.ModuleName.toLowerCase();

		pos = evtname.lastIndexOf(".");
		if (pos != -1) evtname = evtname.substr(0, pos);
		if (evtname.lastIndexOf("/") != -1) evtname = evtname.split("/")[1];
		evtname = Language.NameCase(evtname);

		var say:String = "\r\rEvent: <b>" + evtname + "</b>";
		say += "\r\r  Flags:\r";
		for (var i:Number = 0; i < evtData.GetMaxFlag(); i++) {
			say += "    Flag " + i + " = " + (evtData.CheckBitFlag(i) == true ? "true" : "false");
			if ((i % 2) != 0) say += "\r";
			else say += "\t";
		}
		var bVar:Boolean = false;
		for (var i:Number = 0; i < 10; i++) {
			if (evtData.GetVariable(i) != undefined) {
				bVar = true;
				break;
			}
		}
		if (bVar) {
			say += "\r  Variables:";
			for (var i:Number = 0; i < 10; i += 2) {
				say += "\r    " + i + ": " + (evtData.GetVariable(i) == undefined ? "" : evtData.GetVariable(i)) + "\t" + (i + 1) + ": " + (evtData.GetVariable(i+1) == undefined ? "" : evtData.GetVariable(i+1));
			}
		}		
		if (evtData.arSaveVars != null) {
			var i:Number = evtData.arSaveVars.length;
			if (i == undefined) i = 0;
			if (i != 0) {
				bVar = true;
				say += "\r  Saved Variables:";
				for (var j:Number = 0; j < i; j++) {
					if (bVar) say += "\r    savedvar" + j + " = " + evtData.arSaveVars[j];
					else say += "\tsavedvar" + j + " = " + evtData.arSaveVars[j];
					bVar = !bVar;
				}
			}
		}
		return say;
	}
	
	public function ShowFlags() : String
	{
		var say:String = "\r\r<b>Total Events: " + arEventsArray.length + "</b>";
		
		for (var index:String in arEventsArray) {
			evtData = arEventsArray[index];
			var s:String = evtData.DebugModule();
			if (s == undefined) say += DebugModule();
			else say += s;
		}
		return say;
	}

	
	public function InitialiseModule(mcb:MovieClip) {
		// partial inlined BaseModule::Initialisemodule
		Diary = coreGame.Diary;
		SMData = coreGame.SMData;
		XMLData = coreGame.XMLData;
		
		LoadedSlaves.InitialiseModule();
		
		Parties.InitialiseModule(null);
		People.InitialiseModule(null);
		Generic.InitialiseModule(null);
		Contests.InitialiseModule(null);
		Sounds.InitialiseModule(null);
		trainSlaveMaker.InitialiseModule(null);
		
		var i:Number = elength;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			evtData = arEventsArray[i];
			evtData.InitialiseModule(null);
		}
	}

}
