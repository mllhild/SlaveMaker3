// General XML Data
//
// Translation status: COMPLETE
import Scripts.Classes.*;
import flash.geom.ColorTransform;
import flash.geom.Transform;

class XMLParser extends XMLBase {
	
	// public variables
	public var loopvar:Number;		// loop index use in for loop, often to reference current slave
	public var psd:Object;			// return object for slave target
	
	// private variables
	private var SMData:Object;				// reference of slave maker object

	
	// constructor
	public function XMLParser(cg:Object)
	{ 
		super(cg);
		
		// partial inline of Reset() to save recalling super.Reset() as it is called in super(cg)
		SMData = coreGame.SMData;
	}
	
	// public functions
	
	
	public function ParseSlaveTarget(stat:String) : String
	{
		//trace("ParseSlaveTarget: " + stat + " " + coreGame.PersonOtherIndex);
		// stat_person
		// eg charisma_maran
		var sl:Array = SplitParts(stat);
		var slv:String = sl[1];
		if (sl.length > 2) {
			sl.splice(1, 1);
			stat = sl.join("_");
		} else stat = sl[0];
		
		psd = undefined;
		var idx:Number;
		if (slv == undefined || !isNaN(slv)) {
			stat = sl.join("_");
			idx = -50;
		} else { 
			//trace("ParseSlaveTarget: check event: " + slv);
			var sm:SlaveModule = coreGame.modulesList.GetEventData(slv);
			if (sm != null) {
				psd = sm;
				//stat = sl.join("_");
				//trace("event found: " + stat);
				return stat;
			}
			idx = coreGame.People.DecodePersonDetails(slv, null);
			if (idx == null) {
				//trace("person not found");
				stat = sl.join("_");
				idx = -50;
			}
		}
		//trace("idx = " + idx);
		if (idx >= 0) psd = SMData.SlavesArray[idx];
		else if (idx == -100) psd = SMData;
		else if (idx == -99) psd = coreGame.AssistantData;
		else if (idx == -50) {
			if ("oldgender.corruption.faith.hasfeeldo.hasropes.hassilkenropes.hasegg.weapon.weapontype.weaponclass.armour.armor.armourtype.armortype.ponygirlaware.talentprogress.specialevent.specialeventprogress.hometown.gender.".indexOf(stat + ".") != -1 || stat.substr(0, 2) == "sm" || stat.substr(0, -7) == "trained") psd = SMData;
			else psd = SMData.GetSlaveByIndex(idx);
		}
		return stat;
	}
	
	public function GetSlaveTarget(s:String) : Object
	{
		ParseSlaveTarget(s);
		return psd;
	}
	
	public function GetSlaveIndex(sdo) : Number
	{
		if (typeof(sdo) == "number") return Number(sdo);
		if (sdo == SMData) return -100;
		else if (sdo == coreGame.AssistantData) return -99;
		else if (sdo == _root || sdo == coreGame.slaveData) return -50;
		return sdo.SlaveIndex;
	}

	public function StopXMLParsing()
	{
		SetHandlingEvent(false);
		if (EventText != "") {
			while (EventText.substr(-1, 1) == "\r") EventText = EventText.substr(0, EventText.length-1);
			if (EventText != "") {
				coreGame.Language.AddText(EventText);
				EventText = "";
			}
			if (!coreGame.AskQuestions._visible) coreGame.Language.BlankLine();
		}
		coreGame.NumEvent = 0;
		coreGame.PositionQuestions();
		coreGame.PositionYesNo();
		endparse = true;
	}

	
	// Specific tag processes
	public function ParseConditionalString(str:String, andf:Boolean, nflg:Boolean, defaultnc:Boolean) : Boolean
	{
		str = str.toLowerCase()
		if (str == "true") return true;
		if (str == "false") return false;
		
		var xData:XML = new XML;
		xData.parseXML("<Conditional " + str + ">data</Conditional>");
		return coreGame.ParseConditional(xData.firstChild, andf, nflg, defaultnc) != null;
	}
	
	public function ParseAlternatives(aNode:XMLNode, done:Boolean) : Boolean
	{
		var chances:Array = new Array();
		var missed:Number = 0;
		var str:String;
		var total:Number = 0;
		for (var altNode:XMLNode = aNode.firstChild; altNode != null; altNode = altNode.nextSibling) {
			if (altNode.nodeType != 1) continue;
			if (altNode.nodeName.toLowerCase() == "alternate" || altNode.nodeName.toLowerCase() == "alternative") {
				var chc:Number = 0;
				if (aNode.attributes.altchance.toLowerCase() != undefined) {
					str = aNode.attributes.altchance.substr(-1, 1) == "%" ? aNode.attributes.altchance.substr(0, aNode.attributes.altchance.length - 1) : aNode.attributes.altchance;
					chc = Number(str);
				}
				if (coreGame.ParseConditional(altNode, true, false, true) == null) chc = -1;
				else if (chc == 0) missed++;
				else if (chc > 0) total += chc;
				chances.push(chc);
			}
		}
		var i:Number;
		if (total < 100 && missed > 0) {
			for (i = 0; i < chances.length; i++) {
				if (chances[i] == 0) chances[i] = (100 - total) / missed;
			}
		}
		missed = Math.random() * 100;
		total = 0;
		i = -1;
		for (var altNode:XMLNode = aNode.firstChild; altNode != null; altNode = altNode.nextSibling) {
			if (altNode.nodeType == 1 && (altNode.nodeName.toLowerCase() == "alternate" || altNode.nodeName.toLowerCase() == "alternative")) {
				i++;
				if (chances[i] == -1) continue;
				total += chances[i];
				if (missed < total) {
					delete chances;
					return ParseEvent(altNode.firstChild, done);
				}
			}
		}
		delete chances;
		return done;
	}
	
	public function ParseChoices(aNode:XMLNode, done:Boolean) : Boolean
	{
		var earr:Array;
		var bDay:Boolean = coreGame.Day;
		
		for (var cNode:XMLNode = aNode.firstChild; cNode != null; cNode = cNode.nextSibling) {
			if (cNode.nodeType != 1) continue;
			if (cNode.nodeName.indexOf("-") != -1) earr = cNode.nodeName.split("-", 2);
			else earr = cNode.nodeName.split("_", 2);
			if (earr[0] == "Day" && !bDay) continue;
			if (earr[0] == "Night" && bDay) continue;
	
			if (coreGame.ParseConditional(cNode, true, false, true) != null) return ParseEvent(cNode.firstChild, done);
														
		}
		return done;
	}
	
	public function ParseForLoop(aNode:XMLNode, done:Boolean) : Boolean
	{
		var oldPersonIndex:Number = coreGame.PersonIndex;
		var oldOtherShown:Boolean = coreGame.OtherSlaveShown;
			
		var startv:Number = 0;
		var endv:Number = 0;
		var inc:Number = 1;
	
		for (var attr:String in aNode.attributes) {
			var av:String = attr.toLowerCase();
			if (av == "start") startv = GetExpression(aNode.attributes[attr]);
			else if (av == "end") endv = GetExpression(aNode.attributes[attr]);
			else if (av == "inc") inc = GetExpression(aNode.attributes[attr]);
		}
		if (inc > 0) {
			for (loopvar = startv; loopvar < endv; loopvar += inc) {
				done = ParseEvent(aNode.firstChild, done);
			}
		} else {
			for (loopvar = startv; loopvar > endv; loopvar += inc) {
				done = ParseEvent(aNode.firstChild, done);
			}
		}
		
		if (oldOtherShown) {
			coreGame.GetSlaveInformation(oldPersonIndex);
		} else {
			coreGame.PersonIndex = oldPersonIndex;
			coreGame.UpdateSlaveGenderText();
			coreGame.UpdateSlave();
		}
		return done;
	}
	
	public function ParseWhileLoop(aNode:XMLNode, done:Boolean) : Boolean
	{
		var oldPersonIndex:Number = coreGame.PersonIndex;
		var oldOtherShown:Boolean = coreGame.OtherSlaveShown;
	
		while (coreGame.ParseConditional(aNode, true, false, true) != null) {
			done = ParseEvent(aNode.firstChild, done);
		}
		
		if (oldOtherShown) {
			coreGame.GetSlaveInformation(oldPersonIndex);
		} else {
			coreGame.PersonIndex = oldPersonIndex;
			coreGame.UpdateSlaveGenderText();
			coreGame.UpdateSlave();
		}
		return done;
	}
	
	public function ParseGenderVersions(aNode:XMLNode, done:Boolean) : Boolean
	{
		var gnd:Number = coreGame.SlaveGender;
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "slavemaker" && aNode.attributes[attr].toLowerCase() == "true") gnd = SMData.Gender;
			else if (attr.toLowerCase() == "assistant" && aNode.attributes[attr].toLowerCase() == "true") gnd = coreGame.ServantGender;
			else if ((attr.toLowerCase() == "participant" || attr.toLowerCase() == "person") && aNode.attributes[attr].toLowerCase() == "true") gnd = coreGame.PersonGender;
			else gnd = SMData.GetSlaveDetails(attr, true).SlaveGender;
		}
		if (gnd == undefined) gnd = coreGame.SlaveGender;
		var str:String;
		for (var altNode:XMLNode = aNode.firstChild; altNode != null; altNode = altNode.nextSibling) {
			if (altNode.nodeType == 1) {
				str = altNode.nodeName;
				if (coreGame.TestGender(str, gnd)) return ParseEvent(altNode.firstChild, done);
				if (str.toLowerCase() == "other") return ParseEvent(altNode.firstChild, done);
			}
		}
		return done;
	}
	
	
	public function ParseQuestions(aNode:XMLNode)
	{
		var evt:String;
		var str:String;
		var evtnode:XMLNode;
		var qs:String;
		var ifNode:XMLNode;
		
		for (var qNode:XMLNode = aNode; qNode != null; qNode = qNode.nextSibling) {
			if (qNode.nodeType != 1) continue;
	
			evtnode = null;
			qs = "";
			for (var cNode:XMLNode = qNode.firstChild; cNode != null; cNode = cNode.nextSibling) {
				if (cNode.nodeType != 1) continue;
				str = cNode.nodeName.toLowerCase();
				if (str == "event") evtnode = cNode;
				else if (str == "question") qs = cNode.firstChild.nodeValue;
			}
	
			str = qNode.nodeName.toLowerCase();
			if (str == "else") return;
			if (str == "question" || str == "topic") {
				if (qs == "") qs = qNode.firstChild.nodeValue;
				evt = "";
				for (var attr:String in qNode.attributes) {
					if (attr.toLowerCase() == "eventno" || attr.toLowerCase() == "event") {
						evt = qNode.attributes[attr];
						break;
					}
				}
				if (evt == "") {
					if (coreGame.ParseConditional(qNode, true, false, true) == null) continue;
				}
				if (evt == "" && evtnode != null) coreGame.AddQuestion(evtnode, qs);
				else if (evt != "") coreGame.AddQuestion(evt, qs);
				continue;
			}
			if (str == "if") {
				ifNode = coreGame.ParseConditional(qNode, true, false);
				if (ifNode != null) ParseQuestions(ifNode);
				continue;
			}
			if (str == "ifor") {
				ifNode = coreGame.ParseConditional(qNode, false, false);
				if (ifNode != null) ParseQuestions(ifNode);
				continue;
			}
			if (str == "ifnot") {
				ifNode = coreGame.ParseConditional(qNode, false, true);
				if (ifNode != null) ParseQuestions(ifNode);
				continue;
			}
	
		}
	}
	
	public function ParseAskQuestions(str:String, aNode:XMLNode)
	{
		lastNode = currentNode.parentNode.firstChild;
		if (str == "addquestion") {
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "eventno" || attr.toLowerCase() == "event") {
					str = aNode.attributes[attr];
					//trace("addquestion: " + str + " " + aNode.firstChild.nodeValue);
					coreGame.AddQuestion(str, aNode.firstChild.nodeValue);
					break;
				}
			}
			return;
		}
		if (str == "yesnoquestion" || str == "doyesnoevent") {
			EventText += "\r";
			str = "";
			if (aNode.attributes.event != undefined) str = aNode.attributes.event;
			else if (aNode.attributes.eventno != undefined) str = aNode.attributes.eventno;
			if (str == "" || str == undefined) str = aNode.firstChild.nodeValue;
			else {
				if (aNode.firstChild.nodeValue != undefined) EventText += coreGame.Language.strTrim(aNode.firstChild.nodeValue) + "\r";
			}
			coreGame.DoYesNoEventXY(str);
			return;
		}

		// <askquestions> ot <topics>
		var caption:String = "";
		var main:Boolean = coreGame.GirlsStoryTop._visible;
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "caption") caption = aNode.attributes[attr];
			else if (attr.toLowerCase() == "main") main = aNode.attributes[attr].toLowerCase() == "true";
		}
		coreGame.ResetQuestions();

		ParseQuestions(aNode.firstChild);

		coreGame.ShowQuestions(caption, main);
	}
	
	public function SetSingleFlag(sflag:String, val:Number, valset:String)
	{
		// general format for the attribute
		// flag1-bitno
		// where 1 is the flag
		// flag1-tifa-1
		// tifa is the slave to set the flags for
		
		var sl:Array = SplitParts(sflag.toLowerCase());
		
		var flagtype:String = sl[0];
		var flagno:Number = 0;
		var flagstr:String = (sl[1] == undefined) ? "" : sl[1];
		
		if (valset == undefined) valset = "";
		if (val == undefined) val = GetExpression(valset);
		var setf:Boolean = valset.toLowerCase() == "true";
	
		var sd:Object;
		if (isNaN(flagstr)) {
			// format: flag1-tifa-1
			flagno = (sl[2] == undefined) ? 0 : Number(sl[2]);
			sd = SMData.GetSlaveDetails(flagstr, true);
		} else {
			// format flag1-1
			flagno = Number(flagstr);
			sd = _root;
		}
		
		var flagt:String = flagtype.substr(4);
		
		if (flagt == "1") sd.BitFlag1.ChangeBitFlag(flagno, setf);
		else if (flagt == "2") sd.BitFlag2.ChangeBitFlag(flagno, setf);
		else if (flagt == "sm") SMData.BitFlagSM.ChangeBitFlag(flagno, setf);
		else if (flagt == "smadvantages" || flagt == "smadvantage" || flagtype == "smadvantages" || flagtype == "smadvantage") SMData.SMAdvantages.ChangeBitFlag(flagno, setf);
		else if (flagt == "sminitialitems" || flagt == "sminitialitem" || flagtype == "sminitialitems" || flagtype == "sminitialitem") SMData.SMInitialItems.ChangeBitFlag(flagno, setf);
		else if (flagt == "demon") sd.DemonFlags.ChangeBitFlag(flagno, setf);
		else if (flagt == "specialevent" || flagtype == "specialevent") SMData.SpecialEventFlags.ChangeBitFlag(flagno, setf);
		else if (flagt == "smskill" || flagt == "smskills" || flagtype == "smskill" || flagtype == "smskills") return SMData.SMSkills.ChangeBitFlag(flagno, setf);
		else if (flagt == "custom" || flagt == "custom0") sd.CustomFlag = val;
		else if (flagt == "custom1") sd.CustomFlag1 = val;
		else if (flagt == "custom2") sd.CustomFlag2 = val;
		else if (flagt == "custom3") sd.CustomFlag3 = val;
		else if (flagt == "custom4") sd.CustomFlag4 = val;
		else if (flagt == "custom5") sd.CustomFlag5 = val;
		else if (flagt == "custom6") sd.CustomFlag6 = val;
		else if (flagt == "custom7") sd.CustomFlag7 = val;
		else if (flagt == "custom8") sd.CustomFlag8 = val;
		else if (flagt == "custom9") sd.CustomFlag9 = val;
		else {
			var ret:Boolean = coreGame.modulesList.SetExEventBitFlag(flagtype + "-" + flagno, setf);
			//SMTRACE("event " + flagtype + "-" + flagno + " = " + ret);
			if (ret) continue;
	
			var per:Person = coreGame.People.GetPersonsObject(flagt);
			if (per != null) {
				if (flagstr == "sm" || flagstr == "sm1") per.SMFlag = val;
				else if (flagstr == "sm2") per.SMFlag2 = val;
				else if (flagstr == "custom" || flagstr == "custom1") per.CustomFlag = val;
				else if (flagstr == "custom2") per.CustomFlag2 = val;
				else if (flagstr == "person") per.PersonFlag = val;
				else if (flagstr == "smlove") per.SMLove = val;
				else if (flagstr == "lovesm") per.LoveSM = val;
				else if (flagstr == "accessible") per.SetAccessible(setf);
				else if (flagstr == "visited") per.SetVisited(setf);			
				else if (flagstr == "met" && setf) per.SetMet();			
				else per.ChangeBitFlag(flagno, setf);
			} else {
				var plc:Place = coreGame.currentCity.GetPlaceObject(flagt);
				if (plc != null) {
					if (flagstr == "sm" || flagstr == "sm1") plc.SMFlag = val;
					else if (flagstr == "sm2") plc.SMFlag2 = val;
					else if (flagstr == "custom1") plc.CustomFlag = val;
					else if (flagstr == "custom2") plc.CustomFlag2 = val;
					else if (flagstr == "accessible") plc.SetAccessible(setf);
					else if (flagstr == "visited") plc.SetVisited(setf);
					else plc.ChangeBitFlag(flagno, setf);
				}
			}
		}
	}
	
	public function ParseGetFlags(flags:String) : Object
	{
		// general format for the attribute
		// flag1-bitno
		// where 1 is the flag
		// flag1-tifa-1
		// tifa is the slave to set the flags for
		
		var sl:Array = SplitParts(flags);
	
		var flagtype:String = sl[0];
		var flagt:String = flagtype.substr(4);
		var vals:String = (sl[1] == undefined) ? "" : sl[1];
		
		var val:Number;
		var sd:Object;
		if (isNaN(vals)) {
			val = (sl[2] == undefined) ? 0 : Number(sl[2]);
			sd = SMData.GetSlaveDetails(vals, true);
		} else {
			sd = _root;
			val = Number(vals);
		}
		
		if (flagt == "1") return sd == null ? false : sd.BitFlag1.CheckBitFlag(val);
		else if (flagt == "2") return sd == null ? false : sd.BitFlag2.CheckBitFlag(val);
		else if (flagt == "sm") return SMData.BitFlagSM.CheckBitFlag(val);
		else if (flagt == "demon") return sd == null ? false : sd.DemonFlags.CheckBitFlag(val);
		else if (flagt == "specialevent") return SMData.SpecialEventFlags.CheckBitFlag(val);
		else if (flagt == "sminitialitem" || flagt == "sminitialitems" || flagtype == "sminitialitem" || flagtype == "sminitialitems") return SMData.SMInitialItems.CheckBitFlag(val);
		else if (flagt == "smskill" || flagt == "smskills" || flagtype == "smskill" || flagtype == "smskills") return SMData.SMSkills.CheckBitFlag(val);
		else if (flagt == "smadvantage" || flagt == "smadvantages" || flagtype == "smadvantage" || flagtype == "smadvantages") return SMData.SMAdvantages.CheckBitFlag(val);
		else if (flagt == "custom" || flagt == "custom0") return sd == null ? -1 : sd.CustomFlag;
		else if (flagt == "custom1") return sd == null ? -1 : sd.CustomFlag1;
		else if (flagt == "custom2") return sd == null ? -1 : sd.CustomFlag2;
		else if (flagt == "custom3") return sd == null ? -1 : sd.CustomFlag3;
		else if (flagt == "custom4") return sd == null ? -1 : sd.CustomFlag4;
		else if (flagt == "custom5") return sd == null ? -1 : sd.CustomFlag5;
		else if (flagt == "custom6") return sd == null ? -1 : sd.CustomFlag6;
		else if (flagt == "custom7") return sd == null ? -1 : sd.CustomFlag7;
		else if (flagt == "custom8") return sd == null ? -1 : sd.CustomFlag8;
		else if (flagt == "custom9") return sd == null ? -1 : sd.CustomFlag9;
		else if (flagt == "config") return coreGame.config.IsEnabled(vals);
		else {
			var ret:Boolean = coreGame.modulesList.GetExEventBitFlag(flags);
			//SMTRACE("event flag " + ret);
			if (ret != undefined) return ret;
	
			var per:Person = coreGame.People.GetPersonsObject(flagt);
			if (per != null) {
				if (vals == "sm" || vals == "sm1") return per.SMFlag;
				else if (vals == "sm2") return per.SMFlag2;
				else if (vals == "custom" || vals == "custom1") return per.CustomFlag;
				else if (vals == "custom2") return per.CustomFlag2;
				else if (vals == "person") return per.PersonFlag;
				else if (vals == "lovesm") return per.LoveSM;
				else if (vals == "smlove") return per.SMLove;
				else if (vals == "accessible") return per.IsAccessible();
				else if (vals == "visited") return per.IsVisited();
				else if (vals == "initialvisit") return per.IsInitialVisit();
				else if (vals == "met") return per.IsMet();
				else return per.CheckBitFlag(val);
			} else {
				var plc:Place = coreGame.currentCity.GetPlaceObject(flagt);
				if (plc != null) {
					if (vals == "sm" || vals == "sm1") return plc.SMFlag;
					else if (vals == "sm2") return plc.SMFlag2;
					else if (vals == "custom" || vals == "custom1") return plc.CustomFlag;
					else if (vals == "custom2") return plc.CustomFlag2;
					else if (vals == "accessible") return plc.IsAccessible();
					else if (vals == "visited") return plc.IsVisited();
					else if (vals == "initialvisit") return plc.IsInitialVisit();
					else return plc.CheckBitFlag(val);
				}
			}
		}
		return undefined;
	}
	
	public function WaitShow(mc:MovieClip, place:Number, align:Number, delay:Number)
	{
		clearInterval(coreGame.intervalId4);
		coreGame.Timers.AddTimerStopSoon(
			setInterval(_root, "LoadingImage", 20, mc._parent, "", mc, place, align, coreGame.Timers.GetNextTimerIdx(), delay)
		)
	}
	public function WaitTint(mc:MovieClip, clr)
	{
		if (mc.loading == true || !mc._visible) return;
		clearInterval(coreGame.intervalId4);	
		
		if (clr == "now") coreGame.SetMovieNight(mc);
		else if (clr == "night") coreGame.SetMovieColour(mc, -200, -70, 0);
		else coreGame.SetMovieColourARGB(mc, Number(clr));
	}
	
	public function ParseShowImages(str:String, aNode:XMLNode)
	{
		//trace("ParseShowImages: " + str + " " + aNode);
		var align:Number = 1;
		var place:Number = 1;
		var places:String = "";
		var frame:Number = undefined;
		var delay:Number = 0;
		var movie:String = "";
		var flip:Boolean = false;
		var clr:String = "";
		var defaultmv:String = "";
		
		for (var attr:String in aNode.attributes) {
			var strl:String = attr.toLowerCase();
			if (strl == "align") align = coreGame.DecodeAlign(UpdateMacros(aNode.attributes[attr]));
			else if (strl == "place") {
				places = UpdateMacros(aNode.attributes[attr]);
				place = coreGame.DecodePlace(places);
			} else if (strl == "frame" || strl == "imgno") frame = GetExpression(coreGame.UpdateMacros(aNode.attributes[attr]));
			else if (strl == "flip") flip = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "colour" || strl == "color") {
				clr = aNode.attributes[attr].toLowerCase();
				if (clr != "now" && clr != "night") clr = "" + ColourScheme.GetColourValue(aNode);
			}
		}
		if (flip) align = align + 100;
		
		if (str == "backgrounds" || str == "background") {
			align = undefined;
			place = undefined;
			for (var attr:String in aNode.attributes) {
				var strl:String = attr.toLowerCase();
				if (strl == "place") str = aNode.attributes[attr];
				else if (strl == "mplace") place = coreGame.DecodePlace(aNode.attributes[attr]);
				else if (strl == "align") align = coreGame.DecodeAlign(UpdateMacros(aNode.attributes[attr]));
				else if (strl == "hide") {
					if (aNode.attributes[attr].toLowerCase() == "true") coreGame.Backgrounds.HideBackgrounds();
				}
			}
			if (clr != "") {
				if (coreGame.GirlsStoryTop._visible) {
					if (clr == "0") coreGame.SetMovieColour(coreGame.GirlsStory, -255, -255, -255);
					else {
						var transformer = new Transform(coreGame.GirlsStory);
						var colorTransformer:ColorTransform = transformer.colorTransform;
						colorTransformer.rgb = Number(clr);
						delete transformer.colorTransform;
						transformer.colorTransform = colorTransformer;
					}
				} else coreGame.Backgrounds.ShowOverlay(Number(clr));
			} else if (str != "") {
				coreGame.Backgrounds.ShowBackground(str, frame, flip);
				if (align != undefined || place != undefined) coreGame.ShowLastMovie(place == undefined ? 1 : place, align == undefined ? 0 : align);
			}
			return;
		}		
		if (str == "showitem" || str == "hideitem") {
			place = 0;
			if (frame == undefined) frame = 1;
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "item") {
					delay = Number(aNode.attributes[attr]);
					if (isNaN(delay)) delay = coreGame.Items.GetItemIdxFromNameBase(aNode.attributes[attr]);
					break;
				}
			}
			if (delay == 0) return;
			if (str == "showitem") coreGame.Items.ShowItem(delay, place, align, frame);
			else coreGame.Items.HideItem(delay);
			return;
		}
		if (str == "showperson" || str == "hideperson" || str == "showslave" || str == "hideslave") {
			var person:String = "";
			if (frame == undefined) frame = 1;
			for (var attr:String in aNode.attributes) {
				var strl:String = attr.toLowerCase();
				if (strl == "person" || strl == "slave") person = aNode.attributes[attr];
				else if (strl == "delay") delay = Number(aNode.attributes[attr]);
			}
			if (person == "") person = aNode.firstChild.nodeValue;
			if (person == "" || person == undefined) continue;
			if (str == "showslave" || str == "hideslave") {
				if (str == "showslave") SMData.ShowSlave(person, place == NaN ? places : place, align, frame);
				else coreGame.HideImages();
			} else {
				if (str == "showperson") coreGame.People.ShowPerson(person, place == NaN ? places : place, align, frame, delay);
				else coreGame.People.HidePerson(person);
			}
			return;
		}
		if (str == "showbars" || str == "hidebars") {
			coreGame.Bars._visible = str == "showbars";
			return;
		}
	
		var sub:String = "";
		var slave:Boolean = false;
		var internalc:Boolean = false;
		var md:Boolean = false;
		var sm:SlaveModule = null;
	
		for (var attr:String in aNode.attributes) {
			var strl:String = attr.toLowerCase();
			if (strl == "movie" || strl == "image" || strl == "bitmap" || strl == "monster") movie = UpdateMacros(aNode.attributes[attr]);
			else if (strl == "default") defaultmv = UpdateMacros(aNode.attributes[attr]);
			else if (strl == "size" || strl == "delay") delay = Number(aNode.attributes[attr]);
			// obsolete
			else if (strl == "module") sm = coreGame.modulesList.GetEventData(aNode.attributes[attr]);
			else if (strl == "submovie") sub = aNode.attributes[attr];
			else if (strl == "slave") slave = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "internal") internalc = aNode.attributes[attr].toLowerCase() == "true";
		}
		if (str == "changeimagelist") {
			coreGame.ObjEvent = aNode.attributes.eventafter;
			var say:String = aNode.attributes.sayafter;
			for (var iNode:XMLNode = aNode.firstChild; iNode != null; iNode = iNode.nextSibling) {
				if (iNode.nodeName.toLowerCase() == "imagelist") movie = coreGame.Language.strTrim(iNode.firstChild.nodeValue).split("\n").join("").split("\r").join("");
				else if (iNode.nodeName.toLowerCase() == "sayafter") {
					var oet:String = EventText;
					ParseEvent(iNode.firstChild, false);
					say = EventText;
					EventText = oet;
				} else if (iNode.nodeName.toLowerCase() == "eventafter") coreGame.ObjEvent = iNode;
			}
			if (coreGame.ObjEvent == undefined) coreGame.ObjEvent = null;
			if (movie == "") movie = coreGame.Language.strTrim(aNode.firstChild.nodeValue).split("\n").join("").split("\r").join("");
			var bStart:Boolean = aNode.attributes.startwait.toLowerCase() == "true";
			var bHide:Boolean = aNode.attributes.hide.toLowerCase() == "true";
			var bLoop:Boolean = aNode.attributes.loop.toLowerCase() == "true";
			if (bStart) coreGame.StartChangeImageList(delay, movie, place, align, say, bHide, bLoop ? -1 : 1);
			else coreGame.ChangeImageList(delay, movie, place, align, say, bHide, bLoop ? -1 : 1);
			return;
		}
		if (str == "tintmovie" || str == "tintimage") {
			if (movie == "") {
				if (coreGame.lastmc.loading == true) {
					clearInterval(coreGame.intervalId4);
					coreGame.intervalId4 = setInterval(this, "WaitTint", 50, coreGame.lastmc, clr);
				} else {
					if (clr == "now") coreGame.SetLastMovieNight();
					else if (clr == "night") coreGame.SetLastMovieColour(-200, -70, 0);
					else coreGame.SetMovieColourARGB(coreGame.lastmc, Number(clr));
				}
				return;
			}
			var mc:MovieClip;
			if (sm != null) {
				mc = sm.mcBase;
				if (sub != "") mc = mc[sub];
			} else mc = _root[movie];
			if (mc == undefined || slave) mc = coreGame.SlaveMovie[movie];
			if (clr == "now") coreGame.SetMovieNight(mc);
			else if (clr == "night") coreGame.SetMovieColour(mc, -200, -70, 0);
			else coreGame.SetMovieColourARGB(mc, Number(clr));
			return;
		}	
		if (str == "cumsplatter") {
			var mc:MovieClip = this[movie];
			if (mc == undefined || slave) mc = coreGame.SlaveMovie[movie];
			if (mc == undefined) return;
			if (frame == 0) frame = 1;
			if (delay > 0) {
				if (sub == "") coreGame.StartCumSplatter(delay, mc, align, frame, false, internalc);
				else coreGame.StartCumSplatter(delay, mc[sub], align, frame, false, internalc);
			} else {
				if (sub == "") coreGame.DoCumSplatter(mc, align, frame, false, internalc);
				else coreGame.DoCumSplatter(mc[sub], align, frame, false, internalc);
			}
			return;
		}
		if (sm == null && movie == "") {
			if (coreGame.lastmc.loading == true) {
				clearInterval(coreGame.intervalId4);
				coreGame.intervalId4 = setInterval(this, "WaitShow", 20, coreGame.lastmc, place, align, delay);
			} else {
				if (str == "resizemovie") coreGame.ResizeMovie(coreGame.lastmc, delay, align);
				else coreGame.ShowLastMovie(place, align, frame, delay);
			}
			return;
		}
		if (str == "resizemovie") {
			var mc:MovieClip;
			if (sm != null) {
				mc = sm.mcBase;
				if (sub != "") mc = mc[sub];
			} mc = _root[movie];
			if (mc == undefined || slave) mc = coreGame.SlaveMovie[movie];
			if (mc == undefined) return;
			if (sub == "" || sm != null) coreGame.ResizeMovie(mc, delay, align);
			else {
				if (mc[sub] == undefined) coreGame.ResizeMovie(mc.mcBase[sub], align);
				else coreGame.ResizeMovie(mc[sub], align);
			}
		} else if (str == "showmovie") {
			//trace("showmovie " + sm + " " + sm.ModuleName + " " + movie + " " + sub);
			var mc:MovieClip;
			if (sm == null) {
				if (movie.indexOf("/") != -1) {
					//trace("showing for module");
					var sl:Array = movie.split("/");
					coreGame.modulesList.GetEventData(sl[0]).ShowMovie(sl[1], place, align, frame, delay);
					return;
				}
				mc = _root[movie];
				if (mc == undefined || slave) {
					//trace("show for slave");
					mc = coreGame.SlaveMovie[movie];
					if (mc == undefined) return;
				}
			}
			if (frame == 0 || frame == undefined) frame = 1;
			coreGame.currFrame = frame;
			if (sm != null) {
				//trace("call place version");
				sm.ShowMovie(sub, place, align, frame, delay);
			} else if (sub == "") coreGame.ShowMovie(mc, place, align, frame, delay);
			else {
				if (mc[sub] == undefined) coreGame.ShowMovie(mc.mcBase[sub], place, align, frame, delay);
				else coreGame.ShowMovie(mc[sub], place, align, frame, delay);
			}
		} else if (str == "attachmovie") {
			if (frame == 0 || frame == undefined) frame = 1;
			coreGame.currFrame = frame;
			coreGame.AutoAttachAndShowMovie(movie, place, align, frame, undefined, delay);
		} else if (str == "attachbitmap") {
			coreGame.currFrame = 1;
			coreGame.AutoAttachAndShowBitmap(movie, place, align, undefined, delay);
		} else if (str == "showmonster") {
			var dg:Boolean;
			if (aNode.attributes.dickgirl != undefined) dg = aNode.attributes.dickgirl.toLowerCase() != "false";
			else dg = coreGame.IsDickgirlEvent();
			if (frame == 0 || frame == undefined) frame = 1;
			coreGame.currFrame = frame;
			coreGame.config.ShowMonster(movie, place, align, frame, dg);
		} else {
			coreGame.currFrame = frame;
			var mva:String = movie;
			if (frame != 0 && frame != undefined) {
				if (movie.indexOf(" (") != -1) {
					mva += " " + frame + ").jpg";
					if (defaultmv != "") mva += "|" + defaultmv + " " + frame + ").jpg";
					coreGame.AutoLoadImageAndShowMovie(mva, place, align, undefined, delay);
				} else {
					mva += " " + frame + ".jpg";
					if (defaultmv != "") mva += "|" + defaultmv + " " + frame + ".jpg";					
					coreGame.AutoLoadImageAndShowMovie(mva, place, align, undefined, delay);
				}
			} else {
				if (defaultmv != "") mva += "|" + defaultmv;
				coreGame.AutoLoadImageAndShowMovie(mva, place, align, undefined, delay);
			}
		}
	}
	
	public function ParseChangeVars(str:String, aNode:XMLNode)
	{
		var val:Number;
		var len:Number;
		
		for (var attr:String in aNode.attributes) {
			
			var attrl:String = attr.toLowerCase();
			
			if (attrl.substr(0, 3) == "var") {
				// set/change a temporary variable for the event
				val = Number(attr.substr(3));
				len = tempVars.length;
				if (isNaN(val) == false && len < (val + 1)) {
					for (var id:Number = len; id <= val; id++) tempVars.push(0);
				}
				if (str == "setvar" || str == "setvars") tempVars[val] = GetExpression(aNode.attributes[attr]);
				else tempVars[val] += GetExpression(aNode.attributes[attr]);
				//SMTRACE("changed: var" + val + " = " + tempVars[val]);
			} else {
				// set/change a standard game variable
				val = undefined;
				if (str == "changevar" || str == "changevars") val = Number(coreGame.GetStSk(attrl, attr));
				if (isNaN(val)) val = 0;
				coreGame.SetStatSkill(attrl, val + GetExpression(aNode.attributes[attr]), aNode.attributes[attr], attr);
			}
		}
	}
	
	public function PickActImage(aNode:XMLNode)
	{
		var act:String = undefined;
		var frame:Number = 1;
		var place:Number = 1;
		var align:Number = 14;
	
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "act") act = aNode.attributes[attr];
			else if (attr.toLowerCase() == "frame") frame = GetExpression(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "align") align = coreGame.DecodeAlign(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "place") place = coreGame.DecodePlace(aNode.attributes[attr]);
		}
		var per:Number = ParsePersonDetails(aNode);
		if (per == -50) coreGame.slaveData.ActInfoCurrent.ShowActImage(act, place, align, frame);
		else SMData.GetSlaveByIndex(per).ShowActImage(act, place, align, frame);
	}
	
	
	public function ParseChangeSlaveType(aNode:XMLNode)
	{
		var per:Number = ParsePersonDetails(aNode);
		var type:String = aNode.firstChild.nodeValue;		// assistant, minor, untrained
		SMData.ChangeSlaveType(per, type);
	}
	
	public function ParseCallFunction(str:String, aNode:XMLNode)
	{
		if (str == "callslavefunction") {
			str = aNode.firstChild.nodeValue;
			if (str != undefined) coreGame.SlaveGirl[str]();
			return;
		}
		if (str == "callassistantfunction") {
			str = aNode.firstChild.nodeValue;
			if (str != undefined) coreGame.CurrentAssistant[str]();
			return;
		}
		if (str == "callcorefunction") {
			str = aNode.firstChild.nodeValue;
			if (str != undefined) coreGame[str]();
			return;
		}
		if (str == "callgenericfunction") {
			str = aNode.firstChild.nodeValue;
			if (str != undefined) coreGame.Generic[str]();
			return;
		}		
	}
	
	public function ParseDoEvent(str:String, aNode:XMLNode, sevt:String) : Boolean
	{		
		var ifNode:XMLNode;
		sevt = coreGame.UpdateMacros(sevt);
		lastNode = currentNode.parentNode.firstChild;
		
		if (str == "doevent" || str == "doeventnow") {
			var sNode:XMLNode = currentNode;
			var bNow:Boolean = aNode.attributes.now.toLowerCase() == "true" || str == "doeventnow";
			ifNode = GetNode(sNode.parentNode.firstChild, sevt);
			if (ifNode == null) {
				sNode = GetSlaveObjectXML(SMData.GetSlaveByIndex(coreGame.PersonIndex));
				ifNode = GetNode(sNode, "Planning/DoPlanning/" + sevt);
				if (ifNode == null) {
					ifNode = GetNode(evtNode, sevt);
					if (ifNode == null) ifNode = GetNodeC(flNode, sevt);
				}
			}
			if (ifNode == null) {
				if (bNow) coreGame.DoEventNext(sevt, true);
				else coreGame.DoEvent(sevt);				
			} else {
				if (bNow) coreGame.DoEventNext(ifNode, true);
				else coreGame.DoEvent(ifNode);
			}
			if (bNow) currentNode = sNode;
			return true;
		}
			
		var ap:XMLNode = aNode.parentNode;
		var app:XMLNode = aNode.parentNode.parentNode;
	
		if (str == "pickanddoxmlevent") {
			if (coreGame.PersonIndex != -50 && coreGame.PersonIndex != -100) ifNode = GetNode(coreGame.sdata.sNode, "Events/" + sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNode(currentNode.parentNode.firstChild, sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) {
				ifNode = GetNode(evtNode, sevt);
				if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNode(flNode, sevt);
			}
			return PickAndDoXMLEventByNode(ifNode, false);
		}
		
		// allow remaining to have conditionals for execution
		if (aNode.attributes.length > 0) {
			if (coreGame.ParseConditional(aNode, true, false, true) == null) return false;
		}
		
		if (str == "doxml") {
			//trace("doxml " + sevt);
			if (coreGame.PersonIndex != -50 && coreGame.PersonIndex != -100) {
				ifNode = GetNodeC(coreGame.sdata.sNode, "Events/" + sevt);
				if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(coreGame.sdata.sNode, "Planning/DoPlanning/" + sevt);
				if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(coreGame.sdata.sNode, "Other/" + sevt);
			}
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(currentNode.parentNode.firstChild, sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(evtNode, sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(flNode, sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) return false;
			currentNode = ifNode.parentNode;
			return ParseEvent(ifNode, false);
		}
		if (str == "doxmlact" || str == "dobasexmlact") {
			if (str == "doxmlact" && coreGame.PersonIndex != -50 && coreGame.PersonIndex != -100) ifNode = GetNodeC(coreGame.sdata.sNode, "Planning/DoPlanning/" + sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(dpNode, sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) return false;
			currentNode = ifNode.parentNode;
			return ParseEvent(ifNode, false);
		}
		if (str == "doxmlevent") {
			if (coreGame.PersonIndex != -50 && coreGame.PersonIndex != -100) ifNode = GetNodeC(coreGame.sdata.sNode, "Events/" + sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) ifNode = GetNodeC(evtNode, sevt);
			if (ifNode == null || ifNode.parentNode == ap || ifNode.parentNode == app) return false;
			currentNode = ifNode.parentNode;
			return ParseEvent(ifNode, false);
		}
	
		return false;
	}

	public function ParsePercentValue(val:Number, str:String) : Boolean
	{
		str = str.substr(-1, 1) == "%" ? str.substr(0, str.length - 1) : str;
		var valp:Number = Number(str);
		val = int(val * 100);
		return (val >= (valp - 5) && val <= (valp + 5));
	}
	
	// Shopping
	
	public function ParseShopping(aNode:XMLNode)
	{
		var shop:String = aNode.attributes.shop;
		if (shop == undefined) shop = aNode.firstChild.nodeValue;
		if (shop == undefined) return;
		
		var resume:Boolean = aNode.attributes.resume.toLowerCase() == "true";
		shop = shop.toLowerCase().split(" ").join("");
		
		coreGame.currentCity.Shopping(shop, resume);
	}
	
	// Owners
	
	public function ParseChangeOwner(aNode:XMLNode)
	{
		var pn:Number = 1999;
		if (aNode.attributes.number != undefined) pn = Number(aNode.attributes.number);
		var gender:Number = 2;
		if (aNode.attributes.gender != undefined) gender = coreGame.GetGender(aNode.attributes.gender);
		var pname:String = aNode.firstChild.nodeValue;
		if (pname == undefined && aNode.attributes.name != undefined) pname = aNode.attributes.name;
		SMData.GetSlaveByIndex(ParsePersonDetails(aNode)).Owner.ChangeOwner(pn, gender, pname);
	}
	
	
	// Speech
	
	/*
	<PersonSpeak person="Guard">Begone!</PersonSpeak>
	
	<PersonSpeak person="count" start="true">Hello Slave Maker</PersonSpeak>
	<AddText>Whatever</AddText>
	<PersonSpeak end="true"/>
	*/
	public function ParseSpeak(aNode:XMLNode)
	{
		var str:String = "";
		var start:Boolean = false;
		var end:Boolean = false;
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "person" || attr.toLowerCase() == "slave") str = UpdateMacros(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "start") start = true;
			else if (attr.toLowerCase() == "end") end = true;
		}
		var s:String = GetXMLMultiLineStringParsed("", aNode);
		//coreGame.Language.strTrim(aNode.firstChild.nodeValue);
		if (s == undefined) s = "";
		if (isNaN(Number(str))) {
			var pi:Person = coreGame.People.GetPersonsObject(str);
			if (pi != null) str = coreGame.People.GetPersonsName(pi.Id);
			if (str == coreGame.SlaveName) str = "slave";
		}
		if (start) {
			if (EventText != "") {
				if (EventText.substr(-1) != "\r") EventText += "\r\r";
				else EventText += "\r";
			}
			if (str.toLowerCase() == "assistant") coreGame.ServantSpeakStart(s, true);
			else if (str.toLowerCase() == "slave") coreGame.SlaveSpeakStart(s, true);
			else if (str.toLowerCase() == "assistanta") coreGame.Servant1SpeakStart(s, true);
			else if (str.toLowerCase() == "slavea") coreGame.Slave1SpeakStart(s, true);
			else if (str.toLowerCase() == "assistantb") coreGame.Servant2SpeakStart(s, true);
			else if (str.toLowerCase() == "slaveb") coreGame.Slave2SpeakStart(s, true);
			else coreGame.PersonSpeakStart(str, s, true);
		} else if (end) {
			if (str.toLowerCase() == "assistant") coreGame.ServantSpeakEnd(s);
			else if (str.toLowerCase() == "slave") coreGame.SlaveSpeakEnd(s);
			else if (str.toLowerCase() == "slavea") coreGame.Slave1SpeakEnd(s);
			else if (str.toLowerCase() == "slaveb") coreGame.Slave2SpeakEnd(s);
			else coreGame.PersonSpeakEnd(s);
			EventText += "\r";
		} else {
			if (EventText != "") {
				if (EventText.substr(-1) != "\r") EventText += "\r\r";
				else EventText += "\r";
			}
			if (str.toLowerCase() == "assistant") coreGame.ServantSpeak(s, true);
			else if (str.toLowerCase() == "slave") coreGame.SlaveSpeak(s, true);
			else if (str.toLowerCase() == "assistanta") coreGame.Servant1Speak(s, true);
			else if (str.toLowerCase() == "slavea") coreGame.Slave1Speak(s, true);
			else if (str.toLowerCase() == "assistantb") coreGame.Servant2Speak(s, true);
			else if (str.toLowerCase() == "slaveb") coreGame.Slave2Speak(s, true);
			else coreGame.PersonSpeak(str, s, true);
			EventText += "\r";
		}
	}
	
	
	public function ParseSpeechSuffix(aNode:XMLNode)
	{
		var per:Number = ParsePersonDetails(aNode);
		var chance:Number = 100;
		if (aNode.attributes.chance != undefined) chance = aNode.attributes.chance;
		SMData.GetSlaveByIndex(per).AddSpeechSuffix(chance, aNode.firstChild.nodeValue);
	}
	
	// Acts
	public function ParseActs(aNode:XMLNode, str:String)
	{
		//trace("ParseActs: " + str);
		if (str == "pickactimage" || str == "showactimage" || str == "performact") {
			ParsePickActImage(aNode, str);
			return;
		}
	
		var sname:String = undefined;
		var bShow:Boolean = undefined;
		var bTick:Boolean = undefined;
		var acost:Number = undefined;
		var aduration:Number = undefined;
		var bAvailable:Boolean = undefined;
		var astart:Number = undefined;
		var aend:Number = undefined;
		var person:String = "";
		var astr:String = "";
		var strl:String;
	
		for (var attr:String in aNode.attributes) {
			strl = attr.toLowerCase();
			if (strl == "act") astr = aNode.attributes[attr];
			else if (strl == "name") sname = aNode.attributes[attr];
			else if (strl == "show") bShow = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "ticked") bTick = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "available") bAvailable = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "cost") acost = Number(aNode.attributes[attr]);
			else if (strl == "duration") aduration = Number(aNode.attributes[attr]);
			else if (strl == "starttime") astart = Number(aNode.attributes[attr]);
			else if (strl == "endtime") aend = Number(aNode.attributes[attr]);
			else if (strl == "person" || strl == "slave") person = aNode.attributes[attr];
		}
		if (str == "addplanningact" || str == "adddaynightaction") {
			var act:Number;
			if (!isNaN(astr)) act = Number(astr);
			else {
				var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(astr);
				if (acti != null) act = acti.Act;
			}
			coreGame.Plannings.AddDayNightAction(act);
			return;
		}
		if (str == "showact" || str == "hideact" || str == "showjob" || str == "hidejob" || str == "showchore" || str == "hidechore" || str == "showschool" || str == "hideschool" || str == "showsex" || str == "hidesex") {
			if (astr == "") astr = aNode.firstChild.nodeValue;
			//trace("..." + astr);
			var acti:ActInfo;
			if (!isNaN(astr)) {
				// legacy
				acti = coreGame.slaveData.ActInfoCurrent.GetActByName("slave" + str.substr(4) + astr);
				if (acti == null) acti = coreGame.slaveData.ActInfoCurrent.GetActByName(astr);
			} else {
				// by act name
				acti = coreGame.slaveData.ActInfoCurrent.GetActByName(astr);
				if (acti == null) acti = coreGame.slaveData.ActInfoCurrent.GetActByName("slave" + str.substr(4) + astr);
			}
			if (acti != null) acti.ShowAct(str.substr(0, 4) == "show");
			return;
		}
		
		if (str == "setactcounts") {
			var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(astr);
			if (acti == null) return;
			var cnt:ActCounts;
			var stype:String = "";
			
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "subtype") {
					stype = attr;
					continue;
				}
				cnt = acti.GetCounts(attr);
				if (cnt == null) continue;
				
				var normal:Number = undefined;
				var dickgirl:Number = undefined;
				var lesbian:Number = undefined;
				var naked:Number = undefined;
				var catgirl:Number = undefined;
				var pregnant:Number = undefined;
				var puppygirl:Number = undefined;
				
				var sl:Array = attr.toLowerCase().split("-");
				if (sl[1] == "normal" || sl.length < 2) normal = FixNumber(aNode.attributes[attr]);
				else if (sl[1] == "dickgirl") dickgirl = FixNumber(aNode.attributes[attr]);
				else if (sl[1] == "lesbian" || sl[1] == "gay") lesbian = FixNumber(aNode.attributes[attr]);
				else if (sl[1] == "naked") naked = FixNumber(aNode.attributes[attr]);
				else if (sl[1] == "catgirl") catgirl = FixNumber(aNode.attributes[attr]);
				else if (sl[1] == "pregnant") pregnant = FixNumber(aNode.attributes[attr]);
				else if (sl[1] == "puppygirl") puppygirl = FixNumber(aNode.attributes[attr]);
				
				cnt.UpdateActCounts(normal, dickgirl, lesbian, naked, catgirl, pregnant, puppygirl);
				
			}
			
			if (stype != acti.strSubType) {
				acti.ClearAllImages();
				acti.strSubType = stype;
			}
			return;
		}	
		if (str == "setactstate" || str == "setactdetails") {
			var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(astr);
			if (acti == null) return;
			acti.SetActDetails(bTick, bAvailable, sname, "", "", acost, aduration, astart, aend);

			if (bShow != undefined) acti.ShowAct(bShow);
			return;
		}
		if (str == "addactparticipant") {
			var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(astr);
			acti.AddActParticipant(person);
			return;
		}
		if (str == "removeactparticipant") {
			var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(astr);
			acti.RemoveActParticipant(person);
			return;
		}
		if (str == "levelupsexact" || str == "increasesexactlevel") {
			if (astr == "") astr = aNode.firstChild.nodeValue;
			aend = coreGame.People.DecodePersonDetails(person, -50);
			var act:Number;
			if (!isNaN(astr)) act = Number(astr);
			else {
				var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(astr);
				if (acti != null) act = acti.Act;
			}
			var sd:Slave = SMData.GetSlaveByIndex(aend);
			if (str == "increasesexactlevel") {
				coreGame.SetSexActLevel(act, coreGame.GetLastSexActLevel(act, sd) + 1, sd);
				if (sd.IsDisplayed()) coreGame.dspMain.ShowSexSkillChangeIcon(act);
			} else coreGame.UpdateSexActLevels(act, sd);
			return;
		}
	}
	
	public function ParsePickActImage(aNode:XMLNode, str:String)
	{
		var person:String = "";
		var astr:String = "";
		var frame:Number = undefined;
		var place:Number = 1;
		var align:Number = 14;
		var lesbian:Boolean = coreGame.Lesbian;
		var naked:Boolean = coreGame.Naked;
		var strl:String;
		var genericonly:Boolean = false;
	
		for (var attr:String in aNode.attributes) {
			strl = attr.toLowerCase();
			if (strl == "act") astr = aNode.attributes[attr];
			else if (strl == "frame") frame = GetExpression(aNode.attributes[attr]);
			else if (strl == "align") align = coreGame.DecodeAlign(aNode.attributes[attr]);
			else if (strl == "place") place = coreGame.DecodePlace(aNode.attributes[attr]);
			else if (strl == "person" || strl == "slave") person = aNode.attributes[attr];
			else if (strl == "lesbian") lesbian = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "naked") naked = aNode.attributes[attr].toLowerCase() == "true";
			else if (strl == "generic") genericonly = aNode.attributes[attr].toLowerCase() == "true";
		}
		if (astr == "") astr = aNode.firstChild.nodeValue;
		
		var per:Number = coreGame.People.DecodePersonDetails(person, -50);
		coreGame.People.nPersonLast = per;
		
		var bOldNaked:Boolean = coreGame.Naked;
		coreGame.Naked = naked;
			
		if (str == "pickactimage") {
			// xml only
			var sd:Object = SMData.GetSlaveByIndex(per);
			var bOldLesbian:Boolean = coreGame.Lesbian;
			coreGame.Lesbian = lesbian;
			SMData.GetSlaveObject(sd).ActInfoCurrent.ShowActImage(astr, place, align, frame);
			coreGame.Naked = bOldNaked;
			coreGame.Lesbian = bOldLesbian;
			return;
		}
		var acti:ActInfo = PerformActNow(per, astr.split(" ").join(""), lesbian, genericonly, place, align, frame);
		if (str != "performact" || acti == null) return;
		
		var sd:Object = SMData.GetSlaveByIndex(per);
		sd.SetActTotal(acti.Act, sd.GetActTotal(acti.Act) + 1);
		coreGame.dspMain.UpdateSexSkills(sd);
		coreGame.UpdateSexActLevels(acti.Act, sd);
		coreGame.Naked = bOldNaked;
	}
	
	public function PerformActNow(slave, acto, lesact:Boolean, genericonly:Boolean, place:Number, align:Number, frame:Number) : ActInfo
	{
		//trace("PerformActNow: " + slave + " " + acto);
		coreGame.UseGeneric = false;
		var acti:ActInfo = coreGame.slaveData.ActInfoBase.GetActRO(acto);
		if (acti == null) return null;
		
		if (lesact == undefined) lesact = false;
		if (genericonly == undefined) genericonly = false;
		
		var sobj:Object = null;
		var sd:Object;
		var per:Number = GetSlaveIndex(slave);
		if (per == -99 || per == coreGame.AssistantData.SlaveIndex) {
			//trace("..for assistant");
			sobj = coreGame.CurrentAssistant;
			sd = coreGame.AssistantData;
		} else if (per != -50) {
			//trace("..for other slave " + per);
			sd = SMData.GetSlaveByIndex(per);
			if (coreGame.LoadedSlaves.IsLoadedSlave(sd)) sobj = coreGame.LoadedSlaves.GetLoadedSlave(sd);
		} else {
			//trace("..for slave");
			sd = coreGame.slaveData;
			sobj = coreGame.SlaveGirl;
		}
		
		//trace("..act = " + acti.Act);
		var fn:String = "";
		switch(acti.Act) {
			case 1: fn = "ShowSexActNothing"; break;
			case 2: fn = "ShowSexActTouch"; break;
			case 3: fn = "ShowSexActLick"; break;
			case 4: fn = "ShowSexActFuck"; break;
			case 99:
			case 5: fn = "ShowSexActBlowjob"; break;
			case 6: fn = "ShowSexActTitFuck"; break;
			case 7: fn = "ShowSexActAnal"; break;
			case 8: fn = "ShowSexActMasturbate"; break;
			case 9: fn = "ShowSexActDildo"; break;
			case 10: fn = "ShowActPlug"; break;
			case 11: fn = "ShowSexActLesbian"; break;
			case 12: fn = "ShowSexActBondage"; break;
			case 13: fn = "ShowNaked"; break;
			case 14: fn = "ShowSexActMaster"; break;
			case 15: fn = "ShowSexActGangBang"; break;
			case 18: fn = "ShowSexActSpank"; break;
			case 19: fn = "ShowSexActThreesome"; break;
			case 20: fn = "ShowSexAct69"; break;
			case 21: fn = "ShowSexActGroup"; break;
			case 23: fn = "ShowSexActKiss"; break;
			case 24: fn = "ShowSexActStripTease"; break;
			case 25: fn = "ShowSexActCumBath"; break;
			case 30: fn = "ShowSexActHandjob"; break;
			case 31: fn = "ShowSexActFootjob"; break;
			
			case 1004: fn = "ShowChoreDiscuss"; break;
			case 1001: fn = "ShowChoreCooking"; break;
			case 1002: fn = "ShowChoreCleaning"; break;
			case 1003: fn = "ShowChoreExercise"; break;
			case 1005: fn = "ShowChoreMakeUp"; break;
			case 1006: fn = "ShowSchoolSciences"; break;
			case 1007: fn = "ShowSchoolTheology"; break;
			case 1008: fn = "ShowSchoolRefinement"; break;
			case 1009: fn = "ShowSchoolDance"; break;
			case 1010: fn = "ShowSchoolXXX"; break;
			case 1011: fn = "ShowChoreExpose"; break;
			case 1012: fn = "ShowJobRestaurant"; break;
			case 1013: fn = "ShowJobAcolyte"; break;
			case 1014: fn = "ShowJobBar"; break;
			case 1015: fn = "ShowJobSleazyBar"; break;
			case 1016: fn = "ShowJobBrothel"; break;
			case 1017: fn = "ShowBreak"; break;
			case 1019: fn = "ShowChoreReadABook"; break;
			case 1022: fn = "ShowJobLibrary"; break;
			case 1023: fn = "ShowJobOnsen"; break;
			case 1031: fn = "ShowJobCockMilking"; break;
			case 1032: fn = "ShowSchoolSinging"; break;
			case 1033: fn = "ShowSchoolSwimming"; break;
			
			case 3000: fn = "ShowEndingMarriage"; break;
			
			case 10000: fn = "ShowTentacleSex"; break;
			case 10001: fn = "ShowTired"; break;
			case 10002: fn = "ShowContestXXX"; break;
			case 10003: fn = "ShowContestBeauty"; break;
			case 10004: fn = "ShowContestHousework"; break;
			case 10005: fn = "ShowContestAdvancedHousework"; break;
			case 10006: fn = "ShowContestCourt"; break;
			case 10007: fn = "ShowContestDance"; break;
			case 10008: fn = "ShowContestGeneralKnowledge"; break;
			case 10009: fn = "ShowContestPonygirl"; break;
			
			case 10010: fn = "ShowMilked"; break;
			case 10012: fn = "ShowGigaBE"; break;
			case 10013: fn = "ShowLingerie"; break;
			case 10014: fn = "ShowSwimsuit"; break;
			case 10015: fn = "ShowNakedApron"; break;
			case 10016: fn = "ShowRaped"; break;
			case 10017: fn = "ShowBunnySuit"; break;
			case 10018: fn = "ShowMaidUniform"; break;
			case 10019: fn = "ShowFaerieTransformation"; break;
			case 10020: fn = "ShowRetrieved"; break;
			case 10021: fn = "ShowDating"; break;
			case 10022: fn = "ShowPregnancyReveal"; break;
			case 10023: fn = "ShowTentaclePregnancyBirth"; break;
			case 10024: fn = "ShowRefusedAction"; break;
			case 10025: fn = "ShowPropositionAccepted"; break;
			case 10026: fn = "ShowPropositionRefused"; break;
			case 10027: fn = "ShowLoveConfession"; break;
			case 10028: fn = "ShowLoveAccepted"; break;
			case 10029: fn = "ShowLoveRefused"; break;
			case 10035: fn = "ShowLoveUnsure"; break;
			case 10030: fn = "ShowJobOnsenService"; break;
			case 10031: fn = "ShowJobSleazyBarService"; break;
			case 10033: fn = "ShowMorningMouthfull"; break;
		}
	
		// set game state for the act
		var otalent:Number = coreGame.Talent;
		var olesbian:Boolean = coreGame.Lesbian;
		coreGame.Talent = 0;
		coreGame.UseGeneric = genericonly;
		coreGame.Lesbian = lesact;
		sobj.Lesbian = lesact;
		coreGame.PersonGender = lesact ? 2 : 1;
		coreGame.Gender = coreGame.PersonGender;
		
		if (!genericonly) {
			var bShow:Boolean = true;
			coreGame.lastmc = null;
			if (sobj != null && fn != "") {
				sobj[fn]();
				if (coreGame.lastmc != null) {
					coreGame.UseGeneric = false;
					bShow = false;
				}
			}
			if (bShow) {
				if (sd.SelectActImage(false, acti.Act, place, align, frame, true)) coreGame.UseGeneric = true;
			}
		}
		if (coreGame.UseGeneric) {
			coreGame.Generic.SetSlaveDetails(sd);
			coreGame.Generic.Lesbian = coreGame.Lesbian;
			coreGame.Generic[fn]();
			coreGame.Generic.SetSlaveDetails(coreGame.slaveData);
		}
		
		// restore game state
		coreGame.Lesbian = olesbian;
		coreGame.LesbianTraining = coreGame.BitFlag1.CheckBitFlag(10);
		coreGame.SlaveGirl.Lesbian = coreGame.Lesbian;
		coreGame.Gender = SMData.Gender;
		coreGame.SetText("");
		coreGame.Talent = otalent;	
		
		return acti;
	}
	
	// XML

	public function ParseImpregnate(aNode:XMLNode)
	{
		var slave:String = aNode.attributes.slave.toLowerCase();
		if (slave == undefined) slave = aNode.attributes.person.toLowerCase();
	
		var persn:Person = coreGame.People.GetPersonsObject(slave);
		var per:Number = 0;
		if (persn == null) per = ParsePersonDetails(aNode);
		var type:String = "Tentacle";
		var count:Number = undefined;
		var addc:Number = 0;
		var gestation:Number = undefined;
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "type") type = UpdateMacros(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "count") count = GetExpression(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "add") addc = GetExpression(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "gestation") gestation = GetExpression(aNode.attributes[attr]);
		}
		if (addc != 0) {
			if (persn != null) persn.PregnancyCount += addc;
			else if (per == -100) SMData.AddToPregnancy(addc);
			else if (per == -50) coreGame.AddToPregnancy(addc);
			else SMData.GetSlaveByIndex(per).AddToPregnancy(addc);
		} else {
			if (persn != null) persn.Impregnate(type, count, gestation);
			else if (per == -100) SMData.Impregnate(type, count, gestation);
			else if (per == -50) coreGame.Impregnate(type, count, gestation);
			else SMData.GetSlaveByIndex(per).Impregnate(type, count, gestation);
		}
	}

	
	// basic initialise
	public function Reset()
	{
		super.Reset();
		SMData = coreGame.SMData;
	}


	// convenience function
	// Get a constant value, like a stat, skill or date etc
	public function UpdateMacros(s:String) : String { return coreGame.UpdateMacros(s); }	
	private function ParseEvent(eNode:XMLNode, b:Boolean) : Boolean { return coreGame.ParseEvent(eNode, b); }
	private function ParsePersonDetails(aNode:XMLNode) : Number { return coreGame.People.ParsePersonDetails(aNode); }
}