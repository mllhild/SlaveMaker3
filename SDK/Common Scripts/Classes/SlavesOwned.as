// SlavesOwned  - class defining the slaves owned by your slave maker
// class heirarchy
// parent SlaveMaker
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class SlavesOwned extends ArmsArmour {
	
	// Properties
	
	// Slaves
	public var SlavesArray:Array;
	
	// counts
	public var GirlsTrained:Number;
	public var PonygirlsTrained:Number;
	public var LesbiansTrained:Number;
	public var CatgirlsTrained:Number;
	public var PuppygirlsTrained:Number;
	public var DickgirlsTrained:Number;
	public var SlutsTrained:Number;
	public var CumslutsTrained:Number;
	public var SuccubusesTrained:Number;
	
	public var lasttype:Number;
	
	// internal version
	// Slaves that are available for use/present in the home
	public var arUsableSlaves:Array;
	public var nUsable:Number;
	
	// cached ownerships
	private var bMaranOwned:Boolean;
	private var bSomaOwned:Boolean;
	private var bNarryOwned:Boolean;
	
	private var nTotalOwned:Number;
	private var nTotalSellable:Number;
	
	
	// Avatar
	public function ShowSlaveMaker(typeo:Object, place:Number, align:Number, frame:Number, defimg:String, target:MovieClip) : MovieClip
	{
		return coreGame.SMAvatar.ShowSlaveMaker(typeo, place, align, frame, defimg, target);
	}
	public function AutoShowSlaveMaker(typeo:Object, place:Number, align:Number, frame:Number, defimg:String) : MovieClip
	{
		return coreGame.SMAvatar.AutoShowSlaveMaker(typeo, place, align, frame, defimg);
	}	
	
	
	// Methods
	
	// Constructor
	public function SlavesOwned(cg:Object) { 
		super(cg);
		
		SlavesArray = new Array();
		
		GirlsTrained = 0;
		PonygirlsTrained = 0;
		LesbiansTrained = 0;
		CatgirlsTrained = 0;
		PuppygirlsTrained = 0;
		DickgirlsTrained = 0;
		SlutsTrained = 0;
		CumslutsTrained = 0;
		SuccubusesTrained = 0;
		lasttype = -1;
		
		arUsableSlaves = null;
		bMaranOwned = false;
		bSomaOwned = false;
		bNarryOwned = false;
		
		nTotalOwned = 0;
		nTotalSellable = 0;
		BuildOwnedSlaves();
	}
	
	public function IsMaranOwned() : Boolean { return bMaranOwned; }
	public function IsSomaOwned() : Boolean { return bSomaOwned; }
	public function IsNarryOwned() : Boolean { return bNarryOwned; }
	
	// Load/Save
	public function Load(so:Object, strGameId:String)
	{
		super.Load(so);
		
		GirlsTrained = so.GirlsTrained;
		PonygirlsTrained = so.PonygirlsTrained;
		LesbiansTrained = so.LesbiansTrained;
		CatgirlsTrained = so.CatgirlsTrained;
		PuppygirlsTrained = so.PuppygirlsTrained;
		DickgirlsTrained = so.DickgirlsTrained;
		SlutsTrained = so.SlutsTrained;
		CumslutsTrained = so.CumslutsTrained;
		
		if (strGameId == "" || strGameId == undefined) return;
			
		trace("..load slaves");

		var cookieslaves:SharedObject = coreGame.GetSaveData(strGameId + "slaves");
		var len:Number = cookieslaves.data.SlavesArray.length;
		var sobj:Object;
		var idx:Number;
		var sgirl:Slave;
		for (var isl:Number = 0; isl < len; isl++) {
			sobj = cookieslaves.data.SlavesArray[isl];
			trace("LOADING (Load) " + sobj.SlaveName + " " + coreGame.GetUTCMSElapsed(true));
			if (sobj.SlaveName == "undefined" || sobj.SlaveName == undefined || sobj.SlaveName == "" || sobj.SlaveType == undefined) continue;		// fix some limited data corruptions
			coreGame.LoadSave.CleanSaveGame(sobj);
			sgirl = new Slave(coreGame);
			sgirl.Load(sobj);
			idx = SlavesArray.push(sgirl);
			sgirl.SlaveIndex = idx - 1;
			//trace("loaded " + sobj.SlaveName + " " + sobj.VarCharisma + " " + coreGame.GetUTCMSElapsed());
		}
		BuildOwnedSlaves();
	}
	
	public function Save(so:Object, strGameId:String) : Boolean
	{
		super.Save(so);
		
		so.GirlsTrained = GirlsTrained;
		so.PonygirlsTrained = PonygirlsTrained;
		so.LesbiansTrained = LesbiansTrained;
		so.CatgirlsTrained = CatgirlsTrained;
		so.PuppygirlsTrained = PuppygirlsTrained;
		so.DickgirlsTrained = DickgirlsTrained;
		so.SlutsTrained = SlutsTrained;
		so.CumslutsTrained = CumslutsTrained;
				
		if (strGameId == "" || strGameId == undefined) return false;
		
		var sfailed:Boolean = false;
		{
			var cookieslaves:SharedObject = coreGame.GetSaveData(strGameId + "slaves");
			cookieslaves.clear();
	
			var sae:Slave;
			var sgirl:Object;
			delete cookieslaves.data.SlavesArray;
			cookieslaves.data.SlavesArray = new Array();
			var len:Number = SlavesArray.length;
			for (var i:Number = 0; i < len; i++) {
				sae = SlavesArray[i];
				//trace("..save: " + i + " " + sae.SlaveName);
				sgirl = new Object();
				sae.Save(sgirl);
				cookieslaves.data.SlavesArray.push(sgirl);
				
			}
			if (cookieslaves.flush() == "pending") sfailed = true;
		}
		return sfailed;
	}
	
		// For use in load/save
	// a temporary measure until coregame is updated to use this class at all times
	public function CopyCommonDetails(smFrom:Object, smTo:Object)
	{
		super.CopyCommonDetails(smFrom, smTo);
		
		smTo.GirlsTrained = smFrom.GirlsTrained;
		smTo.PonygirlsTrained = smFrom.PonygirlsTrained;
		smTo.LesbiansTrained = smFrom.LesbiansTrained;
		smTo.CatgirlsTrained = smFrom.CatgirlsTrained;
		smTo.PuppygirlsTrained = smFrom.PuppygirlsTrained;
		smTo.DickgirlsTrained = smFrom.DickgirlsTrained;
		smTo.SlutsTrained = smFrom.SlutsTrained;
		smTo.CumslutsTrained = smFrom.CumslutsTrained;
		smTo.SuccubusesTrained = smFrom.SuccubusesTrained;
	}
	
	public function BuildOwnedSlaves()
	{
		lasttype = -1;
		delete arUsableSlaves;
		arUsableSlaves = new Array();
		var sdata:Slave;
		var sld:Slave = null;
		var len:Number = SlavesArray.length;
		for (var i:Number = 0; i < len; i++) {
			sdata = SlavesArray[i];
			//sdata.SlaveIndex = i;
			if (sdata.SlaveType == -10) { sld = SlavesArray[i]; continue; }
			if (sdata.SlaveType <= -100 || sdata.SlaveType == -2 || sdata.SlaveType == -3 || sdata.SlaveType == -4) continue;
			if (sdata.SlaveType == -1 && sdata != coreGame.AssistantData) continue;
			if (sdata.SlaveType == 1 && sdata.Owner != null) {
				if (sdata.CanAssist == false && !sdata.Owner.IsPersonallyOwned()) continue;
			}
			arUsableSlaves.push(sdata);
		}
		if (sld != null) arUsableSlaves.push(sld);
		nUsable = arUsableSlaves.length;

		bMaranOwned = IsSlaveOwned("Maran");
		bSomaOwned = IsSlaveOwned("Soma");
		bNarryOwned = IsSlaveOwned("Narry");
		
		nTotalOwned = 0;
		nTotalSellable = 0;
		var j:Number = nUsable;
		while (--j >= 0) {
			sdata = arUsableSlaves[j];
			if (sdata.SlaveType == -20) continue;
			if ((sdata.SlaveType == 1 && sdata.CanAssist == true) || sdata.SlaveType == 0) {
				nTotalOwned++;
				nTotalSellable++;
			} else if (sdata.SlaveType == 2) nTotalOwned++;
		}
	}
	
	public function GetSlaveBeingTrained() : Slave
	{
		var sdata:Slave;
		var j:Number = nUsable;
		while (--j >= 0) {
			sdata = arUsableSlaves[j];
			if (sdata.SlaveType == -10) return sdata;
		}
		return null;
	}
	
		
	// Slaves
	static public function ProcessSlaveName(slave:String) : String
	{
		//Images// - .png
		// strip extension
		slave = slave.toLowerCase();
		var sl:Array = slave.split(".");
		if (sl.length > 1) {
			// check if the last is an extension
			var s:String = sl[sl.length -1];
			if (s == 'xml' || s == 'png' || s == 'jpg' || s == 'gif' || s == 'swf' || s == 'jpeg') {
				sl.pop();
				slave = sl.join(".");
			}
		}
				
		sl = slave.split("/");
		slave = sl[sl.length - 1];
		sl = slave.split("-");
		slave = sl[sl.length - 1];
		
		if (slave == " " || slave == "") return "";
		while (slave.substr( -1, 1) == " ") slave = slave.substr(0, slave.length - 1);
		if (slave == " ") return "";
		while (true) {
			if (slave.charAt(0) != " ") break;
			slave = slave.substr(1);
		}

		if (slave.substr(0, 7) == "Cumslut") slave = slave.substr(8);
		if (slave.substr(-12) == " (testicles)") return slave.substr(0, slave.length - 12);
		return slave;
	}
		

	public function GetSlaveDetails(slave:String, noadd:Boolean) : Slave
	{
		if (slave == "current" && coreGame.PersonIndex >= 0) return SlavesArray[coreGame.PersonIndex];
		if (slave == "assistant") return coreGame.IsNoAssistant() ? null : coreGame.AssistantData;
		
		var s:String = slave.split(" ").join("");
		
		// scan list of slaves
		var sdata:Slave;
		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
			// NOTE: would be faster to "inline" this call, but not sure if merited
			if (sdata.IsSlaveDetails(slave, s)) return sdata;
		}
		
		// try replacing & with and
		if (slave.indexOf("&") != -1) {
			s = slave.split(" ").join("").split("&").join("");
			var sand:String = slave.split("&").join("and");
		
			// scan list of slaves
			for (var so:String in SlavesArray) {
				sdata = SlavesArray[so];
				// NOTE: would be faster to "inline" this call, but not sure if merited
				if (sdata.IsSlaveDetails(sand, s)) return sdata;
			}
		}
		
		if (noadd == true) {
			//trace("..GetSlaveDetails: not found " + slave);
			return null;
		}
		
		// Does not exist, create has hidden slave
		trace("..GetSlaveDetails: adding slave " + slave);
		sdata = new Slave(coreGame);
		sdata.SlaveType = -100;
		sdata.SlaveName = slave;
		var sNode:XMLNode = sdata.GetSlaveXML();
		if (sNode != null) coreGame.XMLData.StartGameSlaveXML(sNode, sdata);
		var idx:Number = SlavesArray.push(sdata);
		sdata.SlaveIndex = idx - 1;
		return sdata;
	}
	
	public function GetUsableSlaveDetails(slave:String) : Slave
	{
		//trace("slavesOwned.GetUsableSlaveDetails: " + slave);
		slave = slave.toLowerCase();
		if (slave == "current" && coreGame.PersonIndex >= 0) return SlavesArray[coreGame.PersonIndex];
		if (slave == "assistant") return coreGame.IsNoAssistant() ? null : coreGame.AssistantData;
		
		var s:String = slave.split(" ").join("");
		
		// scan list of slaves
		var sdata:Slave;
		for (var so:String in arUsableSlaves) {
			sdata = arUsableSlaves[so];
			//trace("check: " + sdata.SlaveName);
			// NOTE: would be faster to "inline" this call, but not sure if merited
			if (sdata.IsSlaveDetails(slave, s)) return sdata;
		}
		
		// try replacing & with and
		if (slave.indexOf("&") != -1) {
			s = slave.split(" ").join("").split("&").join("");
			var sand:String = slave.split("&").join("and");
		
			// scan list of slaves
			for (var so:String in arUsableSlaves) {
				sdata = arUsableSlaves[so];
				// NOTE: would be faster to "inline" this call, but not sure if merited
				if (sdata.IsSlaveDetails(sand, s)) return sdata;
			}
		}
		return null;
	}

	
	public function GetSlaveDetailsByName(slave:String) : Slave
	{
		slave = slave.toLowerCase();
		if (slave == "current" && coreGame.PersonIndex >= 0) return SlavesArray[coreGame.PersonIndex];
		if (slave == "assistant") return coreGame.AssistantData;
	
		var sdata:Slave;
		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
			if (sdata.SlaveName.toLowerCase() == slave) return sdata;
		}
		return null;
	}
	
	public function GetSlaveDetailsByNode(node:XMLNode) : Slave
	{	
		var sdata:Slave;
		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
			if (sdata.sNode == node) return sdata;
		}
		return null;
	}
	
	public function GetSlaveDetailsFromFilename(slavefile:String) : Slave
	{
		slavefile = slavefile.toLowerCase();
		if (slavefile == "current" && coreGame.PersonIndex >= 0) return SlavesArray[coreGame.PersonIndex];
		if (slavefile == "assistant") return coreGame.AssistantData;
	
		var slchk:String;
		var sdata:Slave;
		var sl:Array;
		var s:String = slavefile.split(" ").join("");

		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
		
			slchk = sdata.SlaveFilename.toLowerCase();
			if (slchk == "") continue
			if (slchk.split(" ").join("") == s) return sdata;
			sl = slchk.split("/");
			slchk = sl[sl.length - 1].split(".")[0];
			sl = slchk.toLowerCase().split("-");
			slchk = sl[sl.length - 1];
			if (slchk.substr(0, 9) != "Assistant") {
				if (slchk.split(" ").join("") == s) return sdata;
			}
		}
		return null;
	}
	
	public function GetSlaveDetailsFromImageName(slavefile:String) : Slave
	{
		slavefile = slavefile.toLowerCase();
		if (slavefile == "current" && coreGame.PersonIndex >= 0) return SlavesArray[coreGame.PersonIndex];
		if (slavefile == "assistant") return coreGame.AssistantData;
	
		var s:String = slavefile.split(" ").join("");
		if (s.indexOf("slave-") == -1) return null;
		var slchk:String;
		var sdata:Slave;
		var sl:Array;
		
		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
			slchk = sdata.SlaveImage.toLowerCase();
			if (slchk == "") continue
			if (slchk.split(" ").join("") == s) return sdata;
			sl = slchk.split("/");
			slchk = sl[sl.length - 1].split(".")[0];
			sl = slchk.toLowerCase().split("-");
			slchk = sl[sl.length - 1];
			if (slchk.substr(0, 9) != "Assistant") {
				if (slchk.split(" ").join("") == s) return sdata;
			}
		}
		return null;
	}
	public function GetSlaveDetailsFromFolderName(fldr:String) : Slave
	{
		fldr = fldr.toLowerCase();
		if (fldr == "current" && coreGame.PersonIndex >= 0) return SlavesArray[coreGame.PersonIndex];
		if (fldr == "assistant") return coreGame.AssistantData;
		if (fldr.indexOf("slave-") == -1) return null;
	
		var slchk:String;
		var sdata:Slave;
		var sl:Array;
		var s:String = fldr.split(" ").join("");
		
		for (var so:String in SlavesArray) {
			sdata = SlavesArray[so];
			slchk = sdata.ImageFolder.toLowerCase();
			if (slchk == "") continue
			if (slchk.split(" ").join("") == s) return sdata;
		}
		return null;
	}	
	
	public function GetSlaveByIndex(idx:Number) : Object
	{
		if (idx == -100) return this;
		if (idx == -99) return coreGame.AssistantData;
		if (idx == -50) return _root;
		if (idx >= 0) return SlavesArray[idx];
		return null;
	}
	
	public function GetSlaveObject(sd) : Slave { return (sd == _root || sd == undefined) ? coreGame.slaveData : sd;	}


	public function IsSlaveTrained(slave:String) : Boolean
	{
		var sdata:Slave = GetSlaveDetails(slave, true);
		return sdata.SlaveType == 1 || sdata.SlaveType == 0;
	}
	
	// slave parameter can be a name or a Slave object or an XML Node for the slave
	public function IsSlaveOwned(slave) : Boolean
	{
		//trace("IsSlaveOwned: " + slave);
		var sdata:Slave;
		if (typeof(slave) == "string") {
			// Name of the slave
			sdata = GetUsableSlaveDetails(slave);
			if (sdata == null) return false;
			return sdata.IsSlaveOwned();
		}
		var j:Number = nUsable;
		if (slave.SlaveName != undefined) {
			// Slave object
			var sd:Slave = slave;
			while (--j >= 0) {
				sdata = arUsableSlaves[j];
				if (sdata == sd) return true;
			}			
		} else {
			// XML node
			var sNode:XMLNode = slave;
			while (--j >= 0) {
				sdata = arUsableSlaves[j];
				if (sdata.sNode == sNode) return true;
			}
		}
		return false;
	}

	// slave parameter can be a name or a Slave object
	public function IsSlaveUnowned(slave) : Boolean
	{
		//trace("IsSlaveUnowned: " + slave);
		var sdata:Slave;
		if (typeof(slave) == "string") sdata = GetSlaveDetails(slave, true);	// Name of the slave
		else if (slave.SlaveName != undefined) sdata = slave;	// Slave object
		if (sdata == null || sdata == undefined) return true;
		if (sdata.IsSlaveOwned()) return false;	// Owned by you!
		return sdata.SlaveType != -5 && sdata.SlaveType < -3 && sdata.SlaveType != -10;
	}

	public function IsSlaveOwnedByIndex(idx:Number) : Boolean
	{
		if (idx < 0) return true;
		var sdata:Slave = SlavesArray[idx];
		return ((sdata.SlaveType == 1 && sdata.CanAssist == true) || sdata.SlaveType == 0 || sdata.SlaveType == 2);
	}

	public function GetTotalSlavesOwned(nosmassist:Boolean) : Number { return nosmassist ? nTotalSellable : nTotalOwned; }
	
	public function GetTotalChildren(tent:Boolean) : Number
	{
		var sdata:Slave;
		var tot:Number = 0;
		var j:Number = nUsable;
		while (--j >= 0) {
			sdata = arUsableSlaves[j];
			if (sdata.SlaveType == -20) continue;
			if (tent == true) tot += sdata.TotalTentaclePregnancy;
			else tot += sdata.TotalChildren;
		}
		return tot;
	}
	
	public function GetTotalOtherMinorSlaves() : Number
	{
		var tot:Number = 0;
	
		for (var msNode:XMLNode = coreGame.XMLData.mslavesNode; msNode != null; msNode = msNode.nextSibling) {
			if (msNode.nodeType != 1) continue;
			var str:String = msNode.nodeName.toLowerCase();
			if (str == "slave") tot++;
		}
		return tot - 19;	// 16 standard slaves, 3 specials
	}
	
	public function SetSlaveAvailable(slave:String, avail:Boolean) { GetSlaveDetails(slave).SetSlaveAvailable(avail); }
	
	public function GetTotalSlavesInLove() : Number
	{
		var sdata:Slave;
		var tot:Number = 0;
		var type:Number;
		var j:Number = nUsable;
		while (--j >= 0) {
			sdata = arUsableSlaves[j];
			if (sdata.SlaveFilename == "Slaves/Slave-Shampoo.swf") continue;
			type = sdata.SlaveType;
			if (type == 0 || type == 2 || (type == 1 && sdata.CanAssist == true)) {
				if (sdata.LoveAccepted == 1 || sdata.LoveAccepted == 10) tot++;
			}
		}
		return tot;
	}
	
	public function GetAnySlaveTrainedAs(ab1:String, ab2:String, sdexcept:Slave) : Slave
	{
		var sdata:Slave;
		for (var so:String in arUsableSlaves) {
			sdata = arUsableSlaves[so];
			if (sdata == sdexcept) continue;
			if (sdata.IsSlaveTrainedAs(ab1, ab2)) return sdata;
		}
		return null;
	}
	public function GetTotalSlavesTrainedAs(ab1:String, ab2:String, sdexcept:Slave) : Number
	{
		var tot:Number = 0;
		var sdata:Slave;
		for (var so:String in arUsableSlaves) {
			sdata = arUsableSlaves[so];
			if (sdata == sdexcept) continue;
			if (sdata.IsSlaveTrainedAs(ab1, ab2)) tot++;
		}
		return tot;
	}
	
	
	public function IsAnySlaveTrainedAs(ab1:String, ab2:String, sdexcept:Slave) : Boolean { return GetAnySlaveTrainedAs(ab1, ab2, sdexcept) != null; }

	
	// All Slaves

	public function GetTotalMaleSlavesOwned(sextype:Number, noassistant:Boolean) : Number
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var tot:Number = 0;
		var sdata:Slave;
		var j:Number = nUsable - 1;
		while (--j >= -2) {
			sdata = arUsableSlaves[j];
			if (sdata == coreGame.AssistantData && noassistant == true) continue;
			if (sdata.SlaveType == -100 || sdata.DaysUnavailable != 0) continue;
			if (sdata.SlaveGender != 1 && sdata.SlaveGender != 4) continue;
			if (sextype != undefined) {
				if (sdata.IsAbleToDoAct(acti) != true) continue;
				if ((acti.Type == 5 || acti.Type == 6) && !sdata.IntimacyOK) continue;
			}
			tot += (Math.floor(sdata.SlaveGender / 4) + 1);
		}
		return tot;
	}
	
	
	public function GetTotalFemaleSlavesOwned(sextype:Number, noassistant:Boolean) : Number
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var tot:Number = 0;
		var sdata:Slave;
		var j:Number = nUsable - 1;
		while (--j >= -2) {
			sdata = arUsableSlaves[j];
			if (sdata.SlaveGender == 2 || sdata.SlaveGender == 5) {
				if (sdata == coreGame.AssistantData && noassistant == true) continue;
				if (sdata.DaysUnavailable != 0) continue;
				if (sextype != undefined) {
					if (sdata.IsAbleToDoAct(acti) != true) continue;
					if ((acti.Type == 5 || acti.Type == 6) && !sdata.IntimacyOK) continue;
				}
				tot += Math.floor(sdata.SlaveGender / 4) + 1;
			}
		}
		return tot;
	}
	
	
	public function GetTotalDickgirlSlavesOwned(sextype:Number, noassistant:Boolean) : Number
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var tot:Number = 0;
		var sdata:Slave;
		var j:Number = nUsable - 1;
		while (--j >= -2) {
			sdata = arUsableSlaves[j];
			if (sdata.SlaveGender == 3 || sdata.SlaveGender == 6) {
				if (sdata == coreGame.AssistantData && noassistant == true) continue;
				if (sdata.DaysUnavailable != 0) continue;
				if (sextype != undefined) {
					if (sdata.IsAbleToDoAct(acti) != true) continue;
					if ((acti.Type == 5 || acti.Type == 6) && !sdata.IntimacyOK) continue;
				}
				tot += Math.floor(sdata.SlaveGender / 4) + 1;
			}
		}
		return tot;
	}
	
	
	public function GetSlaveTotals(sextype:Number)
	{
		sextype = Math.floor(sextype);
		if (lasttype == sextype) return;
		lasttype = sextype;
		coreGame.totmales = GetTotalMaleSlavesOwned(sextype, true);
		coreGame.totfemales = GetTotalFemaleSlavesOwned(sextype, true);
		coreGame.totdickgirls = GetTotalDickgirlSlavesOwned(sextype, true);
	}

	public function GetRandomSlaveOwnedByType(type:String, sextype:Number, except:Array) : Slave
	{
		switch (type.toLowerCase().split(" ").join("")) {
			case "female": return GetRandomFemaleSlaveOwned(sextype, except);
			case "male": return GetRandomMaleSlaveOwned(sextype, except);
			case "femaleordickgirl": return GetRandomFemaleOrDickgirlSlaveOwned(sextype, except);
			case "maleordickgirl": return GetRandomMaleOrDickgirlSlaveOwned(sextype, except);
			case "dickgirl": return GetRandomDickgirlSlaveOwned(sextype, except);
		}
		return GetRandomSlaveOwned(sextype, except);
	}
	
	public function GetRandomFemaleSlaveOwned(sextype:Number, except:Array) : Slave
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var sdata:Slave;
	
		var totf:Number = slrandom(GetTotalFemaleSlavesOwned(sextype, true));
		
		var ex:Number = except.length;
		if (ex == undefined) ex = 0;
		else {
			for (var j:Number = 0; j < ex; j++) {
				if (except[j] >= 0) {
					var gnd:Number = SlavesArray[except[j]].SlaveGender;
					if (gnd == 2 || gnd == 5) totf -= Math.floor(gnd / 4) + 1;
				}
			}
		}
		
		var tot:Number = 0;
		var i:Number = SlavesArray.length;
		while (--i >= 0) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == -20 || sdata.SlaveType == 0 || sdata.SlaveType == 2 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				if (sdata.SlaveGender == 2 || sdata.SlaveGender == 5) {
					if (sextype != undefined) {
						if (sdata.IsAbleToDoAct(acti) != true) continue;
					}
					if (sdata.DaysUnavailable != 0) continue;
					totf--;
					if (totf == 0) return sdata; 
				}
			}
		}
		return null;
	}
	
	public function GetRandomFemaleOrDickgirlSlaveOwned(sextype:Number, except:Array) : Slave
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var sdata:Slave;
	
		var totf:Number = slrandom(GetTotalFemaleSlavesOwned(sextype, true)+ GetTotalDickgirlSlavesOwned(sextype, true));
		
		var ex:Number = except.length;
		if (ex == undefined) ex = 0;
		else {
			for (var j:Number = 0; j < ex; j++) {
				if (except[j] >= 0) {
					var gnd:Number = SlavesArray[except[j]].SlaveGender;
					if (gnd == 2 || gnd == 3 || gnd == 5 || gnd == 6) totf -= Math.floor(gnd / 4) + 1;
				}
			}
		}
		
		var tot:Number = 0;
		var i:Number = SlavesArray.length;
		while (--i >= 0) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == -20 || sdata.SlaveType == 0 || sdata.SlaveType == 2 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				if (sdata.SlaveGender == 2 || sdata.SlaveGender == 3 || sdata.SlaveGender == 5 || sdata.SlaveGender == 6) {
					if (sextype != undefined) {
						if (sdata.IsAbleToDoAct(acti) != true) continue;
					}
					if (sdata.DaysUnavailable != 0) continue;
					totf--;
					if (totf == 0) return sdata; 
				}
			}
		}
		return null;
	}
	
	public function GetRandomMaleSlaveOwned(sextype:Number, except:Array) : Slave
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var sdata:Slave;
		var totm:Number = slrandom(GetTotalMaleSlavesOwned(sextype, true));
			
		var ex:Number = except.length;
		if (ex == undefined) ex = 0;
		else {
			for (var j:Number = 0; j < ex; j++) {
				if (except[j] >= 0) {
					var gnd:Number = SlavesArray[except[j]].SlaveGender;
					if (gnd == 1 || gnd == 4) totm -= Math.floor(gnd / 4) + 1;
				}
			}
		}
	
		var len:Number = SlavesArray.length;
		for (var i:Number = 0; i < len; i++) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == 0 || sdata.SlaveType == 2 || sdata.SlaveType == -20 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				if (sdata.SlaveGender == 1 || sdata.SlaveGender == 4) {
					var bSkip:Boolean = false;
					for (var j:Number = 0; j < ex; j++) {
						if (sdata.SlaveIndex == except[j]) {
							bSkip = true;
							break;
						}
					}
					if (bSkip) continue;
					if (sdata == coreGame.AssistantData) continue;
					if (sextype != undefined) {
						if (sdata.IsAbleToDoAct(acti) != true) continue;
					}
					if (sdata.DaysUnavailable != 0) continue;
					totm--;
					if (totm == 0) return sdata;
				}
			}
		}
		return null;
	}
	
	public function GetRandomMaleOrDickgirlSlaveOwned(sextype:Number, except:Array) : Slave
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var sdata:Slave;
		var totm:Number = slrandom(GetTotalMaleSlavesOwned(sextype, true) + GetTotalDickgirlSlavesOwned(sextype, true));
			
		var ex:Number = except.length;
		if (ex == undefined) ex = 0;
		else {
			for (var j:Number = 0; j < ex; j++) {
				if (except[j] >= 0) {
					var gnd:Number = SlavesArray[except[j]].SlaveGender;
					if (gnd == 1 || gnd == 3 || gnd == 4 || gnd == 6) totm -= Math.floor(gnd / 4) + 1;
				}
			}
		}
	
		var len:Number = SlavesArray.length;
		for (var i:Number = 0; i < len; i++) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == 0 || sdata.SlaveType == 2 || sdata.SlaveType == -20 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				if (sdata.SlaveGender == 1 || sdata.SlaveGender == 4) {
					var bSkip:Boolean = false;
					for (var j:Number = 0; j < ex; j++) {
						if (sdata.SlaveIndex == except[j]) {
							bSkip = true;
							break;
						}
					}
					if (bSkip) continue;
					if (sdata == coreGame.AssistantData) continue;
					if (sextype != undefined) {
						if (sdata.IsAbleToDoAct(acti) != true) continue;
					}
					if (sdata.DaysUnavailable != 0) continue;
					totm--;
					if (totm == 0) return sdata;
				}
			}
		}
		for (var i:Number = 0; i < len; i++) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == 0 || sdata.SlaveType == 2 || sdata.SlaveType == -20 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				if (sdata.SlaveGender == 3 || sdata.SlaveGender == 6) {
					if (sdata.SlaveName == except) continue;
					if (sdata == coreGame.AssistantData) continue;
					if (sdata.IsAbleToDoAct(acti) != true) continue;
					totm--;
					if (totm == 0) return sdata; 
				}
			}
		}
		return null;
	}
	
	public function GetRandomDickgirlSlaveOwned(sextype:Number, except:Array) : Slave
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var sdata:Slave;
	
		var totdg:Number = slrandom(GetTotalDickgirlSlavesOwned(sextype, true));
		var ex:Number = except.length;
		if (ex == undefined) ex = 0;
		else {
			for (var j:Number = 0; j < ex; j++) {
				if (except[j] >= 0) {
					var gnd:Number = SlavesArray[except[j]].SlaveGender;
					if (gnd == 3 || gnd == 6) totdg -= Math.floor(gnd / 4) + 1;
				}
			}
		}
	
		var i:Number = SlavesArray.length;
		while (--i >= 0) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == 0 || sdata.SlaveType == 2 || sdata.SlaveType == -20 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				if (sdata.SlaveGender == 3 || sdata.SlaveGender == 6) {
					var bSkip:Boolean = false;
					for (var j:Number = 0; j < ex; j++) {
						if (sdata.SlaveIndex == except[j]) {
							bSkip = true;
							break;
						}
					}
					if (bSkip) continue;
					if (sdata == coreGame.AssistantData) continue;
					if (sextype != undefined) {
						if (sdata.IsAbleToDoAct(acti) != true) continue;
					}
					totdg--;
					if (totdg == 0) return sdata; 
				}
			}
		}
		return null;
	}
	
	public function GetRandomSlaveOwned(sextype:Number, except:Array) : Slave
	{
		sextype = Math.floor(sextype);
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(sextype);
		
		var sdata:Slave;
	
		var tot:Number = slrandom(GetTotalSlavesOwned(true));
		//trace("tot = " + tot + " " + GetTotalSlavesOwned(true));
		var ex:Number = except.length;
		if (ex == undefined) ex = 0;
		else {
			for (var j:Number = 0; j < ex; j++) {
				if (except[j] >= 0) {
					var gnd:Number = SlavesArray[except[j]].SlaveGender;
					tot -= Math.floor(gnd / 4) + 1;
				}
			}
		}
	
		var i:Number = SlavesArray.length;
		while (--i >= 0) {
			sdata = SlavesArray[i];
			if (sdata.SlaveType == 0 || sdata.SlaveType == 2 || sdata.SlaveType == -20 || (sdata.SlaveType == 1 && sdata.CanAssist == true)) {
				var bSkip:Boolean = false;
				for (var j:Number = 0; j < ex; j++) {
					if (sdata.SlaveIndex == except[j]) {
						bSkip = true;
						break;
					}
				}
				if (bSkip) continue;
				if (sdata == coreGame.AssistantData) continue;
				if (sextype != undefined) {
					if (sdata.IsAbleToDoAct(acti) != true) {
						trace("will not do it");
						continue;
					}
				}
				tot--;
				if (tot == 0) return sdata; 
			}
		}
		return null;
	}
	
	public function GetSlaveInformation(sdo, dotext:Boolean) : Object
	{	
		var idx:Number = -50;
		var sd:Object;
		if (typeof(sdo) == "number") idx = Number(sdo);
		else if (typeof(sdo) == "string") {
			sdo = GetSlaveDetails(String(sdo), true);
			idx = sdo.SlaveIndex;
		} else {
			if (sdo == this) idx = -100;
			else if (sdo == coreGame.AssistantData) idx = -99;
			else if (sdo == _root || sdo == coreGame.slaveData) idx = -50;
			else idx = sdo.SlaveIndex;
		}
		if (idx == undefined) idx = -50;
		
		if (idx == -100) {
			coreGame.PersonGender = coreGame.SMData.Gender;
			coreGame.PersonName = coreGame.GetPersonsName(idx);
			sd = this;
		} else if (idx == -99) {
			coreGame.PersonGender = coreGame.ServantGender;
			coreGame.PersonName = coreGame.ServantA;
			sd = coreGame.AssistantData;
		} else if (idx == -50) {
			coreGame.PersonGender = coreGame.SlaveGender;
			coreGame.PersonName = coreGame.GetPersonsName(idx);
			sd = _root;
		} else if (idx == -98) {
			sd = coreGame.Generic;
			coreGame.PersonGender = coreGame.SlaveGender;
			coreGame.PersonName = coreGame.SlaveName;
		} else {
			if (typeof(sdo) == "number") sd = SlavesArray[idx];
			else sd = sdo;
			if (sd == undefined) {
				coreGame.PersonGender = 2;
				coreGame.PersonName = "";
			} else {
				coreGame.PersonGender = sd.SlaveGender;		
				coreGame.PersonName = sd.SlaveName;
			}
		}
		coreGame.PersonGenderIdentity = sd.GenderIdentity;
		if (coreGame.PersonGenderIdentity == undefined) coreGame.PersonGenderIdentity = coreGame.GenderIdentity;
		if (dotext != false) coreGame.GetPersonGenderText(coreGame.PersonGenderIdentity);
		coreGame.PersonIndex = idx;
		coreGame.sdata = sd;
		return sd;
	}
	
	public function GetOtherSlaveInformation(sdo) : Object
	{	
		//trace("GetOtherSlaveInformation: " + sdo);
		var idx:Number = -50;
		var sd:Object;
		if (typeof(sdo) == "number") idx = Number(sdo);
		else if (typeof(sdo) == "string") {
			sdo = GetSlaveDetails(String(sdo), true);
			idx = sdo.SlaveIndex;
		} else {
			if (sdo == this) idx = -100;
			else if (sdo == coreGame.AssistantData) idx = -99;
			else if (sdo == _root || sdo == coreGame.slaveData) idx = -50;
			else idx = sdo.SlaveIndex;
		}
		if (idx == undefined) idx = -50;
		
		if (idx == -100) {
			coreGame.PersonOtherGender = coreGame.SMData.Gender;
			coreGame.PersonOtherName = coreGame.GetPersonsName(idx);
			sd = this;
		} else if (idx == -99) {
			coreGame.PersonOtherGender = coreGame.ServantGender;
			coreGame.PersonOtherName = coreGame.ServantA;
			sd = coreGame.AssistantData;
		} else if (idx == -50) {
			coreGame.PersonOtherGender = coreGame.SlaveGender;
			coreGame.PersonOtherName = coreGame.GetPersonsName(idx);
			sd = _root;
		} else if (idx == -98) {
			sd = coreGame.Generic;
			coreGame.PersonOtherGender = coreGame.SlaveGender;
			coreGame.PersonOtherName = coreGame.SlaveName;
		} else {
			if (typeof(sdo) == "number") sd = SlavesArray[idx];
			else sd = sdo;
			coreGame.PersonOtherGender = sd.SlaveGender;		
			coreGame.PersonOtherName = sd.SlaveName;
		}
		coreGame.PersonOtherIndex = idx;
		coreGame.GetPersonOtherGenderText(coreGame.PersonOtherGender);
		return sd;
	}
	
	public function SetSlaveOwned(slave, own:Boolean) : Slave
	{
		trace("SetSlaveOwned: " + slave);
		if (own == undefined) own = true;
		
		var sNode:XMLNode = null;
		
		//trace("IsSlaveOwned: " + slave);
		var sgirl:Slave = null;
		if (typeof(slave) == "string") {
			// Name of the slave
			trace("..name");
			var str:String = slave;
			str = str.toLowerCase();
			sgirl = GetSlaveDetails(str, true);
		} else {
			if (slave.SlaveName != undefined) {
				// Slave object
				trace("..Slave object");
				for (var so:String in SlavesArray) {
					if (SlavesArray[so] == slave) {
						sgirl = SlavesArray[so];
						break;
					}
				}
			} else {
				// XML node
				trace("..xml node");
				var sdata:Slave;
				sNode = slave;
				for (var so:String in SlavesArray) {
					sdata = SlavesArray[so];
					if (sdata.sNode == sNode) {
						sgirl = sdata;
						break;
					}
				}
			}
		}
		
		if (own && sgirl != null) {
			if (sgirl.IsSlaveOwned()) return sgirl;
		}
		
		var bNew:Boolean = false;
		if (sgirl == null) {
			sgirl = new Slave(coreGame);
			sgirl.SlaveIndex = SlavesArray.length;
			bNew = true;
		}
		trace("...SetSlaveOwned: " + slave + " own=" + own + " new=" + bNew + " name=" + sgirl.SlaveName + " obj=" + sgirl);
		
		if (sNode == null) sNode = coreGame.XMLData.GetSlaveXML(slave);
		if (sNode != null) {
			trace("...node found");
			sgirl.sNode = sNode;
			if (bNew) coreGame.XMLData.StartGameSlaveXML(sNode, sgirl);
			sgirl.LoadActImages(sNode);
			
			if (own) {
				trace("...adding more");
				coreGame.XMLData.AddSlaveEvents(sNode);
				trace("...adding more2");
				// apply bonus effects from minor slaves for the current slave
				coreGame.XMLData.XMLEventByNode(coreGame.XMLData.GetNode(sNode, "SlaveBonus"), false, undefined, true); 
				// apply bonus effects from minor slaves for the slave maker
				coreGame.XMLData.XMLEventByNode(coreGame.XMLData.GetNode(sNode, "SlaveMakerBonus"), false, undefined, true); 
				trace("...adding more3");
				coreGame.XMLData.currentCity.ResetPlacesNodes();
				trace("...adding more4");
			}
		}
		if (bNew) {
			trace("ADD SLAVE: (SetSlaveOwned) - " + slave);
			SlavesArray.push(sgirl);
		}
		if (own) {
			if (sgirl.SlaveType == -1) sgirl.SlaveType = 2;
			else if (sgirl.SlaveType == -100) sgirl.SlaveType = 1;
			else sgirl.SlaveType = 0;
			sgirl.TrainingStart = coreGame.GameDate;
			sgirl.Available = true;
		} else {
			if (sgirl.SlaveType == 0) sgirl.SlaveType = -200;
			else if (sgirl.SlaveType == 2) sgirl.SlaveType = -1;
			else if (sgirl.SlaveType == 1) sgirl.SlaveType = -100;
		}
		trace("BuildOwnedSlaves");
		BuildOwnedSlaves();
		return sgirl;
	}
	
	public function IsSlaveAvailable(slave:String) : Boolean
	{
		var sdata:Slave = GetSlaveDetails(slave, true);
		if (sdata != null) return sdata.Available;
		var sNode:XMLNode = coreGame.XMLData.GetSlaveXML(slave);
		if (sNode == null) return false;
		var avNode:XMLNode = coreGame.XMLData.GetNode(sNode, "Available");
		if (avNode != null && coreGame.ParseConditional(avNode, true, false) == null) return false;
		return true;
	}
	
	public function ChangeSlaveType(slave:Object, type:String)
	{
		trace("ChangeSlaveType: " + slave + " " + type);
		var sd:Object = GetSlaveByIndex(coreGame.People.DecodePersonDetails(slave, -50));
		trace("ChangeSlaveType2: " + sd.SlaveName + " " + type);
		sd.ChangeSlaveType(type);
		BuildOwnedSlaves();
	}
	
	public function ShowSlave(slaveo, place:Number, align:Number, gframe:Number, target:MovieClip)
	{
		trace("ShowSlave");
		if (place == undefined) place = 0;
		if (align == undefined) align = 1;
	
		var sgirl:Slave;
		if (typeof(slaveo) == "number") {
			var pn:Number = Number(slaveo);
			if (place == 0) coreGame.PersonShown = pn;
			if (pn == -99) sgirl = coreGame.AssistantData;
			else if (pn == -100) {
				ShowSlaveMaker(1, place, align, gframe, "", target);
				return;
			} else if (pn == -50) {
				coreGame.AutoLoadImageAndShowMovie(coreGame.slaveData.SlaveImage, place, align, target);
				return;
			} else sgirl = SlavesArray[pn];
		} else if (typeof(slaveo) != "string") {
			if (slaveo.SlaveName == undefined) {
				// assume this is an xml node
				//trace("..xml node");
				var sNode:XMLNode = slaveo;
				var nm:String = coreGame.XMLData.GetXMLString("Image", sNode);
				if (nm != "") {
					//trace("..image = " + nm);
					sgirl = GetSlaveDetailsFromImageName(nm);
				} else {
					nm = coreGame.XMLData.GetXMLString("Folder", sNode);
					//trace("..folder = " + nm);
					sgirl = GetSlaveDetailsFromFolderName(nm);
				}
				if (sgirl == null) {
					sgirl = new Slave(coreGame);
					coreGame.XMLData.StartGameSlaveXML(sNode, sgirl);
				}	
				sgirl.sNode = sNode;
			} else sgirl = slaveo;		// a Slave object
			coreGame.PersonName = sgirl.SlaveName;
		} else {
			var slave:String = String(slaveo);
			sgirl = GetSlaveDetails(slave, true);
			if (sgirl == null) {
				var sNode:XMLNode = coreGame.XMLData.GetSlaveXML(slave);
				sgirl = new Slave(coreGame);
				if (sNode != null) coreGame.XMLData.StartGameSlaveXML(sNode, sgirl);
			}
			coreGame.PersonName = sgirl.SlaveName;
		}
	
		if (target == undefined && place == 0) coreGame.HideSupervisor();
		if (sgirl == coreGame.AssistantData) {
			if (target == undefined) target = coreGame.LoadedMovies;
			var image:MovieClip = target.createEmptyMovieClip("LoadedMovie" + coreGame.loadednum, target.getNextHighestDepth());
			image._visible = false;
			target._visible = true;
			coreGame.loadednum++;
			var mc:MovieClip = coreGame.CurrentAssistant.InitialiseAsAssistant();
			if (mc == undefined) {
				coreGame.ShowAssistant();
				coreGame.HideAssistant();
				mc = coreGame.LoadedAssistant.Assistant;
			}
			mc.gotoAndStop(1);
			//mc = CurrentAssistant.InitialiseAsAssistant();
			//if (mc == undefined) mc = LoadedAssistant.Assistant;
			mc.hide = true;
			if (place == 0) coreGame.PersonShown = -99;
			coreGame.LoadedSlaves.ShowLoadedSlave2(image, mc, place, align, gframe, undefined);
	
		} else {
			var ext:String = sgirl.SlaveFilename.substr(-3, 3);
			if (sgirl.SlaveType == 2) {
				if (!coreGame.LoadedSlaves.IsLoadedSlave(sgirl)) coreGame.LoadedSlaves.ChangeLoadedSlave(sgirl);
				coreGame.LoadedSlaves.ShowLoadedSlave(sgirl, place, align, gframe, target);
				return;
			}
			if (sgirl.sNode == null) sgirl.sNode = coreGame.XMLData.GetSlaveXML(undefined, sgirl);
			var iNode:XMLNode = coreGame.XMLData.GetNode(sgirl.sNode, "Image");
			var xpos:Number = 0;
			var ypos:Number = 0;
			var wid:Number = 0;
			var hei:Number = 0;
			if (place == 7) {
				if (!isNaN(iNode.attributes.xpos)) xpos = Number(iNode.attributes.xpos);
				if (!isNaN(iNode.attributes.ypos)) ypos = Number(iNode.attributes.ypos);
				if (!isNaN(iNode.attributes.width)) wid = Number(iNode.attributes.width);
				if (!isNaN(iNode.attributes.height)) hei = Number(iNode.attributes.height);
			}
			if (iNode.attributes.frame != undefined) gframe = coreGame.XMLData.GetExpression(iNode.attributes.frame);
	
			var img:String = sgirl.SlaveImage;
			//trace(".." + sgirl.SlaveName + " " + img + " " + iNode.attributes.frame + " " + gframe);
			if (img == undefined && sgirl == _root) img = coreGame.slaveData.SlaveImage;
			if (img.substr(-12) == " (Testicles)" && !coreGame.DickgirlTesticles) img = img.split(" (Testicles)").join("");
			if (xpos == 0 && ypos == 0 && wid == 0 && hei == 0) {
				if (img.indexOf(".") != -1) {
					if (gframe != undefined) img = img.split(" 1.").join(" " + gframe + ".");
					coreGame.AutoLoadImageAndShowMovie(img, place, align, target, 0);
				} else coreGame.AutoAttachAndShowMovie(img, place, align, gframe, target);
			} else {
				if (img.indexOf(".") != -1) {
					if (gframe != undefined) img = img.split(" 1.").join(" " + gframe + ".");
					coreGame.AutoLoadImageAndPositionMovie(img, xpos, ypos, 0, wid, hei, target);
				} else {
					var mc:MovieClip = coreGame.AutoAttachAndPositionMovie(img, xpos, ypos, 0, wid, hei, target);
					mc.gotoAndStop(gframe);
	
				}
			}
			if (place == 0) coreGame.PersonShown = sgirl.SlaveIndex;
		}
	}
	
	public function ClearOtherSlaveSkills()
	{	
		var i:Number = SlavesArray.length;
		if (i == undefined) return;
		var sdc:Slave;
		while (--i >= 0) {
			sdc = SlavesArray[i];
			if (sdc.SlaveType != -10) sdc.ClearSlaveSkillArray();
		}
	}
	
	public function DoAllSlavesOrders()
	{
		// Apply daily effect to all owned slaves
		var j:Number = nUsable - 1;
		var sd:Slave;
		while (--j >= 0) {
			sd = arUsableSlaves[j];
			if (sd.SlaveType != 0 && sd.SlaveType != 1) continue;
			if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
			if (sd.Order1 == 0 && sd.Order2 == 0) continue;
			
			trace("doing orders for " + sd.SlaveName);
			coreGame.PersonName = sd.SlaveName;
			coreGame.PersonIndex = j;
			//GetSlaveInformation(sd, false);
			sd.DoSlaveOrder(sd.Order1);
			sd.DoSlaveOrder(sd.Order2);
		}
	}

}