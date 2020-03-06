// List of trainable slaves
// Translation status: COMPLETE

import Scripts.Classes.*;

class TrainableSlaves  {
	
	public var coreGame:Object;			// core game engine

	// Assistant List
	public var ASSISTANTMAX:Number;
	public var arAssistants:Array;			// current list of possible assistants

	var assistantlv:LoadVars;
	
	// Slave List
	public var SLAVEMAX:Number;
	private var intervalSL:Number;
	private var loadingstep:Number;			// 0 = not loaded, 1 = slaves, 2 = assistants
	private var loadednum:Number;
	private var bSlaveEnglish:Boolean;

	public var arSlaveList:Array;	// current list of possible slaves to reain
	
	private var XMLData:GameXML;
	private var xData:XML;

	// Constructor
	public function TrainableSlaves(cg:Object) {
		coreGame = cg;
		
		coreGame.GetUTCMSElapsed(true);
		arAssistants = new Array();
		arSlaveList = new Array();
		SLAVEMAX = coreGame.config.GetValue("SlavesMax", 150);
		ASSISTANTMAX = coreGame.config.GetValue("AssistantsMax", 39);
		loadednum = 0;
		intervalSL = 0;
		loadingstep = 0;
		
		XMLData = new GameXML(cg);
				
		// Load all Slaves (once off)
		trace("Loading slaves and assistants");
		bSlaveEnglish = coreGame.Language.LangType == "English";
		SlaveTxtLoadedList(true);
	}
	
	public function IsLoadedSlaves() : Boolean { return (loadingstep > 0); }
	public function IsLoadedAll() : Boolean { return (loadingstep == 2); }


	private function CheckAddAssistant(ename:String)
	{
		var str:String;
		var slines:Array;
		var fnd:Boolean;
		var obj:Object;
		
		if (ename.substr(0, 10) == "Assistant-") {
			str = coreGame.Language.StripLines(ename);
			//trace("checking assistant " + str);
			slines = str.split(" ");
			str = slines[0];
			fnd = false;
			for (var so:String in arAssistants) {
				if (arAssistants[so].AssistantName.toLowerCase() == str.toLowerCase()) {
					fnd = true;
					break;
				}
			}
			if (!fnd) {
				obj = new Object();
				obj.AssistantFile = str;
				obj.xmlload = new XML();
				arAssistants.push(obj);
				
				var strmod:String = str.split(".")[0];
				var s:String;
				var sl:Array = strmod.split("/");
				strmod = sl[sl.length - 1];
				sl = strmod.split("-");
				strmod = sl[sl.length - 1];
				obj.AssistantName = strmod;
				//trace("add assistant: " + obj.AssistantName);
			}
		}
	}
	
	public function AssistantLoaded(success:Boolean) {
		//trace("AssistantLoaded: " + loadednum + "(" + success + ")");
		clearInterval(intervalSL);
		if (XMLData.IsLoading()) {
			//trace("LoadAssistantLoadXML: waiting");
			intervalSL = setInterval(this, "AssistantLoaded", 10, success);
			return;
		}
		if (loadednum < ASSISTANTMAX) {
			// Checj the loaded data
			// check .txt version
			for (var ename:String in assistantlv) CheckAddAssistant(ename);
	
			// check .xml version
			for (var aNode:XMLNode = xData.firstChild.firstChild; aNode != null; aNode = aNode.nextSibling) {
				if (aNode.nodeName.toLowerCase() == "file") CheckAddAssistant(aNode.firstChild.nodeValue);
			}

			// move to next file
			delete xData;
			delete assistantlv;
			xData = new XML();
			XMLData.SetNoAddOns();
			XMLData.LoadXML("Assistants/Assistants" + loadednum + ".xml", undefined, undefined, xData, true);
			assistantlv = new LoadVars();
			var ti:TrainableSlaves = this;
			assistantlv.onLoad = function(success:Boolean) { ti.AssistantLoaded(success); }
			loadednum++;
			assistantlv.load("Assistants/Assistants" + loadednum + ".txt");
			//trace("..loading assistant file Assistants/Assistants" + loadednum);	
			
		} else {
			// DONE loading
			trace("loading assistants txt done: " + coreGame.GetUTCMSElapsed() + "ms");
			delete assistantlv;
			delete xData;
			loadednum = -1;
			LoadAssistantXML();
		}
	}

	private function LoadAssistantXML()
	{
		clearInterval(intervalSL);
		if (XMLData.IsLoading()) {
			trace("LoadAssistantLoadXML: waiting");
			intervalSL = setInterval(this, "LoadAssistantXML", 10);
			return;
		}
		
		loadednum++;
		if (loadednum >= arAssistants.length) {
			trace("loading assistants xml done: " + coreGame.GetUTCMSElapsed() + "ms");
			delete XMLData;
			loadingstep = 2;
			return;
		}
		
		var obj:Object = arAssistants[loadednum];
		var str:String = obj.AssistantFile;
		XMLData.SetNoAddOns();
		//trace("loading: " + ("Assistants/" + str));
		XMLData.LoadXML("Assistants/" + str, this, "LoadAssistantXML", obj.xmlload);
	}

	
	function SlaveTxtLoadedList(success:Boolean)
	{
		var slv:LoadVars;
		if (!success) {
			slv = LoadVars(arSlaveList.pop());
			delete slv;
	
			if (!bSlaveEnglish) {
				bSlaveEnglish = true;
				loadednum--;
			} else {
				if (loadednum > SLAVEMAX) {
					trace("loading slave list done: " + coreGame.GetUTCMSElapsed() + "ms");
					loadednum = 0;
					loadingstep = 1;
					xData = new XML();
					XMLData.SetNoAddOns();
					XMLData.LoadXML("Assistants/Assistants.xml", undefined, undefined, xData, true);
					assistantlv = new LoadVars();
					var ti:TrainableSlaves = this;
					assistantlv.onLoad = function(success:Boolean) { ti.AssistantLoaded(success); }
					assistantlv.load("Assistants/Assistants.txt");
					return;
				}
				bSlaveEnglish = coreGame.Language.LangType == "English";
			}
		} else {
			clearInterval(intervalSL);
			if (arSlaveList.length > 1) {
				slv = arSlaveList[arSlaveList.length - 2];
				if (slv.xmlloaded != true) {
					intervalSL = setInterval(this, "SlaveTxtLoadedList", 10, true);
					return;
				}
			}
			
			bSlaveEnglish = coreGame.Language.LangType == "English";
			if (arSlaveList.length > 0) {
				slv = arSlaveList[arSlaveList.length - 1];
				slv.girlname = coreGame.Language.StripLines(slv.girlname);
				trace("adding: " + slv.girlname);
				slv.renown = slv.renown.toLowerCase();
				slv.Tentacles = slv.Tentacles.toLowerCase();
				slv.Dickgirls = slv.Dickgirls.toLowerCase();
				slv.Furries = slv.Furries.toLowerCase();
				slv.Pregnancy = slv.Pregnancy.toLowerCase();
				slv.Ponygirls = slv.Ponygirls.toLowerCase();
				slv.NonHuman = slv.NonHuman.toLowerCase();
				slv.image = coreGame.Language.StripLines(slv.image);
				if (slv.image == undefined) slv.image = "Slave-" + slv.girlname + ".png";
				if (slv.gamefile == undefined) slv.gamefile = "Slave-GenericSlave.swf";
				else slv.gamefile = coreGame.Language.StripLines(slv.gamefile);
				slv.mode = slv.mode.toLowerCase();
				slv.Folder = coreGame.Language.StripLines(slv.Folder);
				slv.available = slv.available.toLowerCase();
				slv.vanilla = slv.vanilla.toLowerCase();
				slv.assistant = slv.assistant.toLowerCase();
				slv.slavetype = slv.slavetype.toLowerCase();
				if (slv.slavetype == undefined) slv.slavetype = "slave";
				slv.xmlload = new XML();
				XMLData.LoadXML("Slaves/" + slv.image, this, "SlaveXMLLoadedList", slv.xmlload);
				//trace("...loading slave xml Slaves/" + slv.image);
			}
		}
		loadednum++;
		slv = new LoadVars();
		slv.xmlloaded = false;
		arSlaveList.push(slv);
		var ti:TrainableSlaves = this;
		slv.onLoad = function(success:Boolean) { ti.SlaveTxtLoadedList(success); }
	
		if (bSlaveEnglish) {
			slv.load("Slaves/SlaveGirl" + loadednum + ".txt");
			//trace("...loading slave Slaves/SlaveGirl" + loadednum + ".txt");
		} else {
			slv.load("Slaves/SlaveGirl" + loadednum + "-" + coreGame.Language.LangType + ".txt");
			//trace("...loading slave Slaves/SlaveGirl" + loadednum + "-" + coreGame.Language.LangType + ".txt");
		}
	}
	
	function SlaveXMLLoadedList(success:Boolean)
	{
		var slv:LoadVars = arSlaveList[arSlaveList.length - 2];
		slv.xmlloaded = true;
	}
	
	function DoLoadAllSlaves()
	{
		var slv:LoadVars;
		for (var so:String in arSlaveList) {
			slv = arSlaveList[so];
	
			var sdata:Slave = coreGame.GetSlaveDetailsFromImageName("Slaves/" + slv.image);
			if (sdata == null) {
				//trace("ADD (DoLoadAllSlaves): " + slv.image + " " + slv.girlname);
				sdata = new Slave(coreGame);
				sdata.SlaveName = slv.girlname;
				sdata.SlaveGender = slv.gender == undefined ? 2 : coreGame.GetGender(slv.gender);
				if (slv.available == "false") sdata.Available = false;
				sdata.SlaveImage = "Slaves/" + slv.image;
				sdata.SlaveFilename = "Slaves/" + slv.gamefile;
				if (sdata.SlaveFilename == "Slaves/Slave-GenericSlave.swf") sdata.SlaveFilename = sdata.SlaveImage.split(".")[0] + ".xml";
				sdata.SlaveType = -100;
				if (slv.slavetype == "minor") sdata.SlaveType = -201;
				else if (slv.slavetype == "assistant") sdata.SlaveType = -1;
				if (slv.assistant == "true") {
					sdata.SlaveType = -100;
					sdata.CanAssist = true;
				}
				sdata.SlaveIndex = coreGame.SlavesArray.length;
				coreGame.SlavesArray.push(sdata);
			}
		}
	}
	
	function GetSlaveListDetails(slave:String) : LoadVars
	{
		slave = SlaveMaker.ProcessSlaveName(slave);
		
		var slchk:String;
		var slv:LoadVars;
		var slnsp:String = slave.split(" ").join("");
		var sl:Array;
		
		for (var so:String in arSlaveList) {
			slv = arSlaveList[so];
			if (slv.girlname.toLowerCase() == slave) return slv;
			if (slv.girlname.toLowerCase().split(" ").join("") == slnsp) return slv;
			if (slv.image != "") {
				sl = slv.image.split("/");
				slchk = sl[sl.length - 1].split(".")[0];
				sl = slchk.split("-").toLowerCase();
				slchk = sl[sl.length - 1];
				if (slchk.split(" ").join("") == slnsp) return slv;
			}
			if (slv.Folder != "") {
				sl = slv.Folder.split("/");
				slchk = sl[sl.length - 1].split(".")[0];
				sl = slchk.split("-").toLowerCase();
				slchk = sl[sl.length - 1];
				if (slchk.split(" ").join("") == slnsp) return slv;
			}
		}
		
		// remove first word from name and re-check
		sl = slave.split(" ");
		if (sl.length < 2) return null;
		sl.shift();
		slave = sl.join(" ");
		
		for (var so:String in arSlaveList) {
			slv = arSlaveList[so];
			if (slv.girlname.toLowerCase() == slave) return slv;
			if (slv.girlname.toLowerCase().split(" ").join("") == slnsp) return slv;
			if (slv.image != "") {
				sl = slv.image.split("/");
				slchk = sl[sl.length - 1].split(".")[0];
				sl = slchk.split("-").toLowerCase();
				slchk = sl[sl.length - 1];
				if (slchk.split(" ").join("") == slnsp) return slv;
			}
			if (slv.Folder != "") {
				sl = slv.Folder.split("/");
				slchk = sl[sl.length - 1].split(".")[0];
				sl = slchk.split("-").toLowerCase();
				slchk = sl[sl.length - 1];
				if (slchk.split(" ").join("") == slnsp) return slv;
			}
		}

		return null;
	}

	function GetAssistantListDetails(slave:String) : Object
	{
		slave = SlaveMaker.ProcessSlaveName(slave);
		
		var slchk:String;
		var obj:Object;
		var slnsp:String = slave.split(" ").join("");
		
		for (var so:String in arAssistants) {
			obj = arAssistants[so];
			if (obj.AssistantFile.toLowerCase() == slave) return obj;
			if (obj.AssistantFile.toLowerCase().split(" ").join("") == slnsp) return obj;			
			if (obj.AssistantName.toLowerCase() == slave) return obj;
			if (obj.AssistantName.toLowerCase().split(" ").join("") == slnsp) return obj;
		}
		
		// remove first word from name
		var sl:Array = slave.split(" ");
		if (sl.length < 2) return null;
		sl.shift();
		slave = sl.join(" ");

		for (var so:String in arAssistants) {
			obj = arAssistants[so];
			if (obj.AssistantFile.toLowerCase() == slave) return obj;
			if (obj.AssistantFile.toLowerCase().split(" ").join("") == slnsp) return obj;			
			if (obj.AssistantName.toLowerCase() == slave) return obj;
			if (obj.AssistantName.toLowerCase().split(" ").join("") == slnsp) return obj;
		}
		
		return null;
	}
}

