// General XML Data
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class XMLBase extends ExpressionParser {
	
	// Private		
	private var loadfnc:String;
	private var xLoadIntoXML:XML;
	private var xCurrXML:XML;
	private var nXMLLoaded:Number;
	private var bNoAddOn:Boolean;
	
	private var slaveNode:XMLNode;

	private var bUseEvent:Boolean;
	
	public var lastNode:XMLNode;
	private var currentNode:XMLNode;
	
	public var endparse:Boolean;
	
	// cached nodes
	private var arCacheArray:Object;
	
	// public

	public var flNode:XMLNode;
	public var evtNode:XMLNode;
	public var dpNode:XMLNode;
	public var usNode:XMLNode;
	public var cbNode:XMLNode;	
	public var mslavesNode:XMLNode;
	public var defimgNode:XMLNode;
	
	public var tempVars:Array;		// custom local variables for the event
	public var bRepick:Boolean;
	
	public var EventText:String;
	

	
	// constructor
	public function XMLBase(cg:Object)
	{ 
		super(cg);
		SetCurrentSlaveXML(null);
		xCurrXML = null;
		bNoAddOn = false;
		currentNode = null;
		lastNode = null;
		
		Reset();
	}
	
	public function Reset()
	{
		EventText = "";
		bUseEvent = false;
		
		delete arCacheArray;
		arCacheArray = new Object();
		
		delete tempVars;
		tempVars = new Array();	
	}
	
	// functions
	

	public function SetCurrentSlaveXML(sn:XMLNode) { slaveNode = sn; coreGame.slaveNode = sn; }
	public function GetCurrentSlaveXML() : XMLNode { return slaveNode; }
	public function SetNoAddOns() { bNoAddOn = true; }
	
	public function IsLoading() : Boolean { return xCurrXML != null; }
	
	public function IsHandlingEvent() : Boolean { return bUseEvent; }
	public function SetHandlingEvent(setf:Boolean) { bUseEvent = setf == undefined ? true : setf; }
	public function GetCurrentNode() : String { return currentNode.nodeName; }
	
	private var fobj:Object;
	private var strData:String;
	
	public function LoadXML(xmlfile:String, callobj:Object, fnc:String, xInto:XML, nolang:Boolean)
	{
		strData = xmlfile.split(".")[0];  //strip extension
		//SMTRACE("  loading xml " + strData);
		
		xLoadIntoXML = xInto;
		loadfnc = fnc;
		fobj = callobj;
		
		if (nolang != true) {
			var rootn:XMLNode = new XMLNode(1, "Language");
			xLoadIntoXML.appendChild(rootn);
		}
		
		nXMLLoaded = undefined;
		LoadXMLLoaded(false);
	}
	
	private function LoadXMLLoaded(success:Boolean)
	{
		if (success) MergeXML(xLoadIntoXML, xCurrXML);
		
		//SMTRACE("LoadXMLLoaded: " + success + " " + nXMLLoaded + " " + strData);
		var strCurr:String;
		if (nXMLLoaded == undefined) {
			nXMLLoaded = 0;
			strCurr = strData + ".xml";
		} else {
			if (nXMLLoaded > 0 && !success) {
				nXMLLoaded = -1;
				success = true;
			} else if (nXMLLoaded >= 0) {
				if (bNoAddOn) {
					nXMLLoaded = -1;
					success = true;
					strCurr = "";
				} else {
					nXMLLoaded++;
					strCurr = strData + "-AddOn" + nXMLLoaded + ".xml";
				}
			}
			if (nXMLLoaded < 0) {
				if (nXMLLoaded < 0 && !success) strCurr = "";
				else if (nXMLLoaded == -1) {
					if (coreGame.Language.LangType != "English") strCurr = strData + "-" + coreGame.Language.LangType + ".xml";
					else strCurr = "";
				} else {
					if (coreGame.Language.LangType != "English" && !bNoAddOn) strCurr = strData + "-AddOn" + ((nXMLLoaded * -1) - 1) + "-" + coreGame.Language.LangType + ".xml";
					else strCurr = "";
				}
				nXMLLoaded--;
			}
		}
			
		//SMTRACE("loading xml: " + strCurr);
		if (strCurr != "") {
			delete xCurrXML;
			xCurrXML = new XML();
			var ti:XMLBase = this;
			xCurrXML.onLoad = function(success2:Boolean) {
				ti.LoadXMLLoaded(success2);
			}
			//SMTRACE("loadxml: " + strCurr);
			xCurrXML.load(strCurr);
			return;
		}
		//SMTRACE("  loaded " + strData);
		delete xCurrXML;
		xCurrXML = null;
		bNoAddOn = false;
		if (fobj != undefined) fobj[loadfnc]();
	}
	
	
	//public var bTra:Boolean = false;
	public function MergeXML(xOld:XMLNode, xNew:XMLNode, exclude1:String, exclude2:String, exclude3:String, alwaysreplace:Boolean, clone:Boolean, alwaysappend:Boolean)
	{
		if (xOld == null || xNew == null) return;
		//if (bTra) trace("into: " + xOld.nodeName);
		var ar:Boolean = alwaysreplace == undefined ? false : alwaysreplace;
		if (clone == undefined) clone = false;
		var newNode:XMLNode = xNew.firstChild;
		var bFnd:Boolean;
		var bAp:Boolean;
		var nNode:XMLNode;
		var nnn:String;
		var bRep:Boolean;
		var bTop:Boolean;
		var pnn:String = xOld.nodeName;
		if (pnn == "Owned" || pnn == "Unowned") pnn = "Events";
		var ex1:Boolean = exclude1 == "Introduction" || exclude2 == "Introduction1";
		
		while(newNode != null) {
			nnn = newNode.nodeName;
			if (newNode.nodeType == 1) {
				//if (bTra == true) SMTRACE("mergexml: " + nnn);
				if ((pnn != "Assistant" && pnn != "Slave") || ex1) {
					if (nnn == exclude1 || nnn == exclude2 || nnn == exclude3) {
						//if (bTra == true) SMTRACE("exclude: " + nnn);
						if (newNode.nodeValue != null) xOld.firstChild.nodeValue = newNode.nodeValue;
						newNode = newNode.nextSibling;
						continue;
					}
				}
				bFnd = false;
				
				for (var mainNode:XMLNode = xOld.firstChild; mainNode != null; mainNode = mainNode.nextSibling) {
					if (mainNode.nodeType != 1 || mainNode.nodeName != nnn) continue;
					//if (bTra == true) SMTRACE("found match");
					bFnd = true;
					nNode = newNode.nextSibling;
					if (mainNode.hasChildNodes()) {
						if (newNode.hasChildNodes()) {
							if (pnn == "Images") {
								// skip to next input node
								newNode = newNode.nextSibling;
								break;
							}
							bRep = ar;
							bAp = alwaysappend != undefined ? alwaysappend : newNode.attributes.append.toLowerCase() == "true";
							bTop = newNode.attributes.top.toLowerCase() == "true";
							
							// container nodes, never delete all contents and add, just step into and process contents
							if (nnn == "UpdateDateAndItems" || nnn == "DrinkPotion" || nnn == "Daily" ||
								nnn == "EventNext" || nnn == "AfterEventNext" || nnn == "AfterEventYes" ||
								nnn == "AfterEventNo" || nnn == "EarlyMorning" || nnn == "StartDay" ||
								nnn == "StartMorning" || nnn == "StartNight" || nnn == "StartEvening" || nnn == "AfterWalk" || nnn == "AfterNight" ||
								nnn == "TrainingComplete" || nnn == "EndingStart" || nnn == "EndingFinish" || 
								nnn == "UpdateSlave" || nnn == "Walk" || pnn == "Walk" || nnn == "DoPlanning" || nnn == "Acts" || nnn == "Rumours" || 
								nnn == "DoPlanningAction" || nnn == "AfterPlanningAction" || nnn == "ApplyDifficulty" || nnn == "Shops" || nnn == "PotionDetails"
								) bRep = false;
							// node that by default should replace the contenta of any nodes in common
							if (nnn == "Events" || (nnn == "Slave" && pnn != "EndGame") || nnn == "Assistant" || nnn == "EndGame" || nnn == "DoPlanning" || nnn == "Acts") ar = true;
							if (nnn == "Slave" && pnn == "EndGame") { ar = false; bRep = false; }
							
							//if (bTra == true) SMTRACE("now merge: " + bRep + " " + ar + " " + bAp);
							// nodes to merge with some intelligence
							if (nnn == "Slaves") SmartMergeXML(mainNode, newNode, "Slave", "Image", clone);
							else if (nnn == "SpecialParticipants") SmartMergeXML(mainNode, newNode, "Participant", "Image", clone);
							else if (nnn == "Houses") SmartMergeXML(mainNode, newNode, "House", "Folder", clone);
							else if (nnn == "Weapons") SmartMergeXML(mainNode, newNode, "Weapon", "Image", clone);
							else if (nnn == "ArmourSets") SmartMergeXML(mainNode, newNode, "Armour", "Image", clone);
							else if (nnn == "Items") SmartMergeXML(mainNode, newNode, "Item", "Image", clone);
							else if (nnn == "Topics") SmartMergeXML(mainNode, newNode, "Topic", "Question", clone);
							else if (nnn == "Areas") SmartMergeXML(mainNode, newNode, "Area", "Name", clone);
							else if (nnn == "PotionDetails") SmartMergeXML(mainNode, newNode, "Potion", "Image", clone);
							else if (nnn == "AskQuestions") {
								if (GetNode(newNode.firstChild, "Question") != null) AttributeMergeXML(mainNode, newNode, "Question", "event", "eventno", clone);
								else SmartMergeXML(mainNode, newNode, "Topic", "Question", clone);
							} else if (nnn == "Choices") AttributeMergeXML(mainNode, newNode, "Choice", "all", undefined, clone);
							else if (nnn == "Places") AttributeMergeXML(mainNode, newNode, "Place", "nodeid", undefined, clone);
							else if (nnn == "People") AttributeMergeXML(mainNode, newNode, "Person", "nodeid", undefined, clone);
							else if (nnn == "People") AttributeMergeXML(mainNode, newNode, "Person", "nodeid", undefined, clone);
	
							else if (bAp || bTop) {
								// node to just append
								//if (bTra == true) SMTRACE("append " + nnn);
								var appNode:XMLNode = newNode.firstChild;
								while (appNode != null) {
									if (clone) {
										var appNodeClone:XMLNode = appNode.cloneNode(true);
										if (bTop) mainNode.insertBefore(appNodeClone, mainNode.firstChild);
										else mainNode.appendChild(appNodeClone);
										appNode = appNode.nextSibling;
									} else {
										if (bTop) mainNode.insertBefore(appNode, mainNode.firstChild);
										else mainNode.appendChild(appNode);
										appNode = newNode.firstChild;
									}
								}
							} else if (bRep || (newNode.attributes.replace == "true")) {
								// node to replace contents	
								//if (bTra == true) SMTRACE("replace " + nnn);
								mainNode.removeNode();
								if (clone) newNode = newNode.cloneNode(true);
								xOld.appendChild(newNode);
							} else {
								//if (bTra == true) SMTRACE("found, merge " + nnn);
								MergeXML(mainNode, newNode, exclude1, exclude2, exclude3, ar, clone, alwaysappend);  // node to merge
							}
							ar = alwaysreplace == undefined ? false : alwaysreplace;
						}
					} else {
						// append the node as there is no matching content
						//if (bTra == true) SMTRACE("not found, append 1");
						mainNode.removeNode();
						if (clone) newNode = newNode.cloneNode(true);
						xOld.appendChild(newNode);
					}
					newNode = nNode;
					break;
				}
				if (bFnd == false) {
					// not found, append the new node
					//if (bTra == true) SMTRACE("not found, append 2");
					nNode = newNode.nextSibling;
					if (clone) newNode = newNode.cloneNode(true);
					xOld.appendChild(newNode);
					newNode = nNode;
				}
			} else {
				if (newNode.nodeType == 3) {
					// Text only node, overwrite
					if (newNode.nodeValue != null && xOld.firstChild.nodeValue != null) xOld.firstChild.nodeValue = newNode.nodeValue;
				} // Other nodes - do nothing!!!
				newNode = newNode.nextSibling;
			}
		}
		//bTra = false;
	}
	
	private function SmartMergeXML(xOld:XMLNode, xNew:XMLNode, keynode:String, cmptag:String, clone:Boolean)
	{
		var newNode:XMLNode = xNew.firstChild;
		var bFnd:Boolean;
		var nNode:XMLNode;
		var nnn:String;
		var keyvalNew:String;
		var keyvalOld:String;
		var xNode:XMLNode;
		
		while(newNode != null) {
			nnn = newNode.nodeName;
			if (newNode.nodeType == 1) {
				bFnd = false;
				
				if (nnn == keynode) keyvalNew = GetXMLStringSimple(cmptag, newNode.firstChild);
				
				for (var mainNode:XMLNode = xOld.firstChild; mainNode != null; mainNode = mainNode.nextSibling) {
					if (mainNode.nodeType != 1 || mainNode.nodeName != nnn) continue;
					
					if (!mainNode.hasChildNodes()) {
						bFnd = true;
						mainNode.removeNode();
						if (clone) newNode = newNode.cloneNode(true);
						xOld.appendChild(newNode);
						newNode = newNode.nextSibling;
						break;
					}
					if (!newNode.hasChildNodes()) {
						bFnd = true;
						newNode = newNode.nextSibling;
						break;
					}
					if (nnn == keynode) {
						keyvalOld = GetXMLStringSimple(cmptag, mainNode.firstChild);
						if (keyvalOld != keyvalNew) continue;
					}
					
					// found matching node with correct key value OR a non-matching node
					bFnd = true;
					nNode = newNode.nextSibling;
					
					//mainNode.removeNode();
					//xOld.appendChild(newNode);
					MergeXML(mainNode, newNode, "", "", "", true, clone);
					
					newNode = nNode;
					break;
				}
				
				if (!bFnd) {
					// no matching node, append
					nNode = newNode.nextSibling;
					if (clone) newNode = newNode.cloneNode(true);
					xOld.appendChild(newNode);
					newNode = nNode;
				}
				
			} else {
				// text node
				if (newNode.nodeValue != null) xOld.firstChild.nodeValue = newNode.nodeValue;
				newNode = newNode.nextSibling;
			}
		}
	}
	
	private function AttributeMergeXML(xOld:XMLNode, xNew:XMLNode, keynode:String, attribute:String, altattribute:String, clone:Boolean)
	{
		var newNode:XMLNode = xNew.firstChild;
		var bFnd:Boolean;
		var nNode:XMLNode;
		var nnn:String;
		var keyvalNew:String;
		var keyvalOld:String;
		var xNode:XMLNode;
		
		while(newNode != null) {
			nnn = newNode.nodeName;
			if (newNode.nodeType == 1) {
				bFnd = false;
				
				if (nnn == keynode) {
					keyvalNew = GetNodeAttribute(newNode, attribute);
					if (keyvalNew == "") keyvalNew = GetNodeAttribute(newNode, altattribute);
				}
				
				for (var mainNode:XMLNode = xOld.firstChild; mainNode != null; mainNode = mainNode.nextSibling) {
					if (mainNode.nodeType != 1 || mainNode.nodeName != nnn) continue;
					
					if (!mainNode.hasChildNodes()) {
						bFnd = true;
						mainNode.removeNode();
						if (clone) newNode = newNode.cloneNode(true);
						xOld.appendChild(newNode);
						newNode = newNode.nextSibling;
						break;
					}
					if (!newNode.hasChildNodes()) {
						bFnd = true;
						newNode = newNode.nextSibling;
						break;
					}
					if (nnn == keynode) {
						keyvalOld = GetNodeAttribute(mainNode, attribute);
						if (keyvalOld == "") keyvalOld = GetNodeAttribute(mainNode, altattribute);
						if (keyvalOld != keyvalNew) continue;
					}
					
					// found matching node with correct key value OR a non-matching node
					bFnd = true;
					nNode = newNode.nextSibling;
					
					//mainNode.removeNode();
					//xOld.appendChild(newNode);
					MergeXML(mainNode, newNode, "", "", "", true, clone);
					
					newNode = nNode;
					break;
				}
				
				if (!bFnd) {
					// no matching node, append
					nNode = newNode.nextSibling;
					if (clone) newNode = newNode.cloneNode(true);
					xOld.appendChild(newNode);
					newNode = nNode;
				}
				
			} else {
				// text node
				if (newNode.nodeValue != null) xOld.firstChild.nodeValue = newNode.nodeValue;
				newNode = newNode.nextSibling;
			}
		}
	}
	
	private function GetNodeAttribute(aNode:XMLNode, sattr:String) : String
	{
		sattr = sattr.toLowerCase();
		if (sattr == "all") return aNode.attributes.toString();
		
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == sattr) return aNode.attributes[attr];
		}
		return "";
	}
	
	/*
	public function GetNodeChildren(baseNode, node:String) : XMLNode
	{
		var iNode:XMLNode = GetNode(baseNode, node);
		if (iNode == null) return null;
		return iNode.firstChild;
	}
	*/
	public function GetNodeC(baseNode, node:String) : XMLNode
	{
		var iNode:XMLNode = GetNode(baseNode, node);
		if (iNode == null) return null;
		return iNode.firstChild;
	}
	
	public function GetNode(base, node:String) : XMLNode
	{
		var aNode:XMLNode;
		if (typeof(base) == "string") {
			aNode = flNode;
			if (node == undefined || node == null) node = String(base);
			else node = String(base) + "/" + node;
			if (node.charAt(0) == "/") node = node.substr(1);
		} else {
			if (node == undefined || node == null) return base;
			aNode = base;
		}
		
		var narr:Array = node.split("/");
		node = narr[0].toLowerCase();
		
		for (; aNode != null; aNode = aNode.nextSibling) {
			if (aNode.nodeType == 1 && aNode.nodeName.toLowerCase() == node) {
				if (narr.length > 1) {
					narr.shift();
					return GetNode(aNode.firstChild, narr.join("/"));
				}
				return aNode;
			}
		}
		return null;
	}

	public function GetXMLBoolean(str:String, node, def:Boolean) : Boolean
	{	
		if (node === undefined) node = slaveNode;
		var aNode:XMLNode = GetNode(node, str);
		if (aNode == null) return def == undefined ? false : def;
		
		if (aNode.firstChild == null) return (coreGame.ParseConditional(aNode, true, false) != null);
		
		str = aNode.firstChild.nodeValue;
		if (str == "") return def == undefined ? false : def;
		
		//inlined StripLines (includes strTrim)
		while (str.substr(-1, 1) == " ") str = str.substr(0, str.length-1);
		while (true) {
			if (str.charAt(0) != " ") break;
			str = str.substr(1);
		}
		str = str.split("\r")[0].split("\n")[0].toLowerCase();

		if (str == "") return def == undefined ? false : def;
		if (str == "true") return true;
		else if (str == "false") return false;
		return (GetExpression(str) == 1);
	}

	public function GetXMLBooleanParsed(str:String, node, def:Boolean) : Boolean
	{
		if (node === undefined) node = slaveNode;
		var aNode:XMLNode = GetNode(node, str);
		if (aNode == null) return def == undefined ? false : def;
		
		if (aNode.firstChild == null) return (coreGame.ParseConditional(aNode, true, false) != null);
		
		str = GetXMLStringParsed("", aNode);
		if (str == "") return def == undefined ? false : def;
		return (str.toLowerCase() == "true");
	}
	
	public function GetXMLString(str:String, node, def:String) : String
	{
		if (node === undefined) node = slaveNode;
		var aNode:XMLNode = GetNode(node, str);
		if (aNode == null) return def == undefined ? "" : def;
		
		str = aNode.firstChild.nodeValue;
		if (str == "") return def == undefined ? "" : def;
		
		//inlined StripLines (includes strTrim)
		while (str.substr(-1, 1) == " ") str = str.substr(0, str.length-1);
		while (true) {
			if (str.charAt(0) != " ") break;
			str = str.substr(1);
		}
		return str.split("\r")[0].split("\n")[0];
	}
	
	public function GetXMLStringSimple(str:String, node, def:String) : String
	{
		if (node === undefined) node = slaveNode;
		var aNode:XMLNode = GetNodeC(node, str);
		if (aNode == null) return def == undefined ? "" : def;
		
		str = aNode.toString();
		return str == "" ?  def : str;
	}	
	
	public function GetXMLMultiLineStringParsed(tag:String, node, def:String, oNode:XMLNode) : String
	{
		if (node === undefined) node = slaveNode;
		
		// inlined DoLangText()
		var oet:String = EventText;
		EventText = "";
		
		var aNode:XMLNode;
		if (typeof(node) == "string") {
			aNode = evtNode;
			tag = String(node) + "/" + tag;
		} else aNode = node;
		
		var bDone:Boolean = false;
		if (tag != "") {
			if (oNode != undefined) bDone = XMLEventByNode(GetNode(aNode, "Other/" + tag), true, undefined, true, true);
			if (bDone == false && !XMLEventByNode(GetNode(aNode, tag), true, undefined, true, true)) {
				if (node != undefined) XMLEventByNode(GetNode(flNode, tag), true, undefined, true, true);
			}
		} else XMLEventByNode(aNode, true, undefined, true, true);
		tag = EventText;
		EventText = oet;

		if (tag == "") return def == undefined ? "" : def;
		
		//inlined strTrim
		// do not trim single spaces
		if (tag.substr(-2, 2) == "  ") {
			while (tag.substr(-1, 1) == " ") tag = tag.substr(0, tag.length-1);
		}
		if (tag.substr(0, 2) == "  ") {
			while (true) {
				if (tag.charAt(0) != " ") break;
				tag = tag.substr(1);
			}
		}
		return tag.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join("");
	}

	public function GetXMLStringParsed(tag:String, node, def:String, oNode:XMLNode) : String
	{
		if (node === undefined) node = slaveNode;
		
		// inlined DoLangText()
		var oet:String = EventText;
		EventText = "";
		
		var aNode:XMLNode;
		if (typeof(node) == "string") {
			aNode = evtNode;
			tag = String(node) + "/" + tag;
		} else aNode = node;
		
		var bDone:Boolean = false;
		if (tag != "") {
			if (oNode != undefined) bDone = XMLEventByNode(GetNode(aNode, "Other/" + tag), true, undefined, true, true);
			if (bDone == false && !XMLEventByNode(GetNode(aNode, tag), true, undefined, true, true)) {
				if (node != undefined) XMLEventByNode(GetNode(flNode, tag), true, undefined, true, true);
			}
		} else XMLEventByNode(aNode, true, undefined, true, true);
		tag = EventText;
		EventText = oet;

		if (tag == "") return def == undefined ? "" : def;
		
		//inlined StripLines (includes strTrim)
		if (tag.substr(-2, 2) == "  ") {
			while (tag.substr(-1, 1) == " ") tag = tag.substr(0, tag.length-1);
		}
		if (tag.substr(0, 2) == "  ") {
			while (true) {
				if (tag.charAt(0) != " ") break;
				tag = tag.substr(1);
			}
		}
		return tag.split("\r")[0].split("\n")[0];
	}

	public function GetXMLMultiLineString(str:String, node, def:String) : String
	{
		if (node === undefined) node = slaveNode;
		var aNode:XMLNode = GetNode(node, str);
		if (aNode == null) return def == undefined ? "" : def;
		
		str = aNode.firstChild.nodeValue;
		if (str == "") return def == undefined ? "" : def;
		return str;
	}

	public function GetXMLValue(str:String, node, def:Number) : Number
	{
		if (node === undefined) node = slaveNode;
		var aNode:XMLNode = GetNode(node, str);
		if (aNode != null) return FixNumber(aNode.firstChild.nodeValue);
		return def == undefined ? 0 : def;
	}
	
	public function GetXMLValueParsed(str:String, node, def:Number) : Number
	{
		var oet:String = new String(EventText);
		if (node == undefined) node = slaveNode;
		var aNode:XMLNode = GetNode(node, str);
		if (aNode != null) {
			EventText = "";
			if (!XMLEventByNode(aNode, true, undefined, true, true)) {
				if (node == undefined) {
					EventText = oet;
					return def == undefined ? 0 : def;
				}
				XMLEventByNode(GetNode(flNode, node), true, undefined, true, true);
			}
			if (EventText != "") def = FixNumber(EventText);
		}
		EventText = oet;
		return def == undefined ? 0 : def;
	}
	
	public function FixNumber(str:String) : Number
	{
		// try to handle . or , separators
		if (!isNaN(str)) return Number(str);
		var val:Number = Number(str.split(",").join("."));
		if (!isNaN(val)) return val;
		val = Number(str.split(".").join(","));
		if (!isNaN(val)) return val;
		return 0;
	}
	
	static public function SplitParts(s:String) : Array
	{
		if (s.indexOf("-") != -1) return s.split("-");
		if (s.indexOf("_") != -1) return s.split("_");
		return s.split(":");
	}
	
	static public function StripParts(s:String) : String
	{
		if (s.charAt(0) == '-' || s.charAt(0) == '_' || s.charAt(0) == ':') return s.substr(1);
		return s;
	}
	//
	// Event selection/processing functions
	//
	
	public function XMLEventLastNode(node:String, sett:Boolean, sptext:Boolean) : Boolean
	{
		trace("XMLEventLastNode: " + node);
		var eNode:XMLNode;
		if (currentNode != null) eNode = GetNode(currentNode.parentNode.firstChild, node);
		if (eNode == null) eNode = GetNode(lastNode, node);
		if (eNode == null) eNode = GetNode(lastNode.firstChild, node);
		if (eNode == null) eNode = GetNode(lastNode.parentNode, node);
		if (eNode == null) eNode = GetNode(lastNode.parentNode.parentNode, node);
		if (eNode == null) eNode = GetNode(evtNode, node);
		if (eNode == null) eNode = GetNode(flNode, node);
		if (eNode == null) return false;
		
		return XMLEventByNode(eNode, sett, undefined, sptext);
	}
	
	public function XMLEvent(node:String, sett:Boolean) : Boolean
	{
		if (!bUseEvent) {
			delete tempVars;
			tempVars = new Array();
		}
		
		return XMLEventByNode(GetNode(evtNode, node), sett, undefined, false);
	}
	
	public function XMLEventCached(node:String, sett:Boolean, sptext:Boolean, base:XMLNode) : Boolean
	{
		var aNode:XMLNode = arCacheArray[node];
		if (aNode === undefined) {
			if (base != undefined) aNode = GetNode(base, node);
			else aNode = GetNode(evtNode, node);
			arCacheArray[node] = aNode;
		}
		return XMLEventByNode(aNode, sett, undefined, sptext);
	}
	
	public function XMLEventByNode(eNode:XMLNode, sett:Boolean, evno:String, sptext:Boolean) : Boolean
	{
		bRepick = false;
		if (evno != undefined) eNode = GetNode(eNode.firstChild, evno); 
		if (eNode == null || eNode.firstChild == null) return false;
		
		//trace("XMLEventByNode: " + evno + " " + eNode.nodeName + " " + bUseEvent + " " + sptext);
		
		var bUseOld:Boolean = bUseEvent;
		bUseEvent = true;
		endparse = false;
		var ocNode:XMLNode = currentNode;
		currentNode = eNode;
		
		var los:String = coreGame.OldStrEvent;
		
		var done:Boolean = coreGame.ParseEvent(eNode.firstChild, false);
		bUseEvent = bUseOld;
		currentNode = ocNode;
	
		if (sptext == true) return done;
		
		//trace("EventText = " + EventText + " " + bUseOld + " " + sett);
	
		if (EventText != "" && !bUseOld) {
			while (EventText.substr(-1, 1) == "\r") EventText = EventText.substr(0, EventText.length-1);
			if (EventText != "") {
				if (sett == true) coreGame.SetText(EventText);
				else coreGame.AddText(EventText);
				EventText = "";
			}
			if (!coreGame.AskQuestions._visible) coreGame.BlankLine();
			
			coreGame.PositionQuestions();
			coreGame.PositionYesNo();
		}
		
		//trace("done = " + done);
		if (!done) return done;

	
		if (los == coreGame.OldStrEvent) coreGame.OldStrEvent = eNode.nodeName;
		
		var earr:Array;
		if (eNode.nodeName.indexOf("-") != -1) earr = eNode.nodeName.split("-");
		else earr = eNode.nodeName.split("_");
		if (!isNaN(earr[2])) coreGame.OldNumEvent = Number(earr[2]);
		else if (!isNaN(earr[1])) coreGame.OldNumEvent = Number(earr[1]);
		
		return true;
	}

		
	
	public function PickXMLEvent(node:String, exclude:Array) : String
	{
		var eNode:XMLNode = GetNode(evtNode, node);
		if (eNode == null) eNode = GetNode(flNode, node);
		if (eNode == null) return "";
	
		return PickXMLEventByNode(eNode, exclude);
	}
	
	public function PickXMLEventByNode(eNode:XMLNode, exclude:Array, pl:Place) : String
	{
		trace("PickXMLEventByNode: " + eNode.nodeName);
		var earr:Array;
		var elen:Number = exclude != undefined ? exclude.length : 0
		var bDay:Boolean = coreGame.Day;
		var str:String;
		
		for (var aNode:XMLNode = eNode.firstChild; aNode != null; aNode = aNode.nextSibling) {
			if (aNode.nodeType != 1) continue;
			str = aNode.nodeName;
			if (elen != 0) {
				var elenc:Number = elen;
				while(--elenc >= 0) {
					if (exclude[elenc] == str) break;
				}
				if (elenc >= 0) continue;
			}
			SMTRACE("checking event: " + str);	
			if (coreGame.ParseConditional(aNode, true, false) != null)
			{
				SMTRACE("...conditional ok: " + str);
				if (str.indexOf("-") != -1) earr = str.split("-", 2);
				else earr = str.split("_", 2);
				if (earr[0] == "Day" && !bDay) continue;
				if (earr[0] == "Night" && bDay) continue;

				if (pl != undefined && pl != null) {
					SMTRACE("...is repeatable?");
					if (!pl.IsEventRepeatable(str)) {
						SMTRACE("...no");
						continue;
					}
				}
				SMTRACE("...pick event: " + str);
				delete tempVars;
				tempVars = new Array();
				return str;
				
			} //else SMTRACE("...conditional failed");		
		}
		
		return "";
	}
	
	public function PickAndDoXMLEvent(node:String, sett:Boolean, exclude:Array) : Boolean
	{
		if (node.charAt(0) == "/") return PickAndDoXMLEventByNode(node, sett, exclude);
		else return PickAndDoXMLEventByNode(GetNode(evtNode, node), sett, exclude);
	}
	
	public function PickAndDoXMLEventByNode(node, sett:Boolean, exclude:Array) : Boolean
	{
		var eNode:XMLNode = GetNode(node);
		if (eNode == null) return false;
				
		var ret:Boolean;
		var evt:String;
		bRepick = true;
		var bFirst:Boolean = true;
		while (bRepick == true) {
			evt = PickXMLEventByNode(eNode, exclude);
			if (evt == "") return false;
			if (bFirst) XMLEventByNode(eNode, sett, "Common");
			ret = XMLEventByNode(eNode, sett, evt);
			if (bRepick) {
				if (exclude == undefined) exclude = new Array();
				exclude.push(evt);
				ret = true;
			}
		}
		return ret;
	}
	
	public function DoXMLAct(act:String, xNode:XMLNode, noreset:Boolean) : Boolean
	{
		trace("DoXMLAct: " + act);
		if (!bUseEvent) EventText = "";
		if (noreset != true) {
			delete tempVars;
			tempVars = new Array();
		}
	
		var eNode:XMLNode = xNode;
		if (eNode == null || eNode.firstChild == null) {
			eNode = GetNode(coreGame.currentCity.areaNode, "Planning/DoPlanning/" + act);
			if (eNode == null || eNode.firstChild == null) {
				eNode = GetNode(dpNode, act);
				if ((eNode == null || eNode.firstChild == null) && (act.substr(0, 5).toLowerCase() == "slave")) {
					eNode = GetNode(coreGame.actNode, act);
					if (eNode == null || eNode.firstChild == null) eNode = GetNode(slaveNode, act);
				}
			}
		}
		return XMLEventByNode(eNode, false);
	}

	public function DoXMLActForSlave(act:String, sd:Object, noreset:Boolean) : Boolean
	{
		trace("DoXMLActForSlave: " + act + " for " + sd.SlaveName);
		if (!bUseEvent) EventText = "";
		if (noreset != true) {
			delete tempVars;
			tempVars = new Array();
		}

		var sNode:XMLNode = GetSlaveObjectXML(sd);
		if (sNode != null) {
			var pNode:XMLNode = GetNodeC(sNode, "Planning");
			if (pNode != null) {
				if (XMLEventByNode(GetNode(pNode, "DoPlanning/" + act))) return true;
				if (XMLEventByNode(GetNode(pNode, "Acts/DoPlanning/" + act))) return true;
			}
			pNode = GetNodeC(sNode, "Other");
			if (pNode != null) {
				if (XMLEventByNode(GetNode(pNode, act))) return true;
			}
			pNode = GetNodeC(sNode, "Events");
			if (pNode != null) {
				if (XMLEventByNode(GetNode(pNode, act))) return true;
			}			
		}
		return DoXMLAct(act, null, true);
	}

	public function XMLGeneral(tag:String, sett:Boolean, basenode:XMLNode) : Boolean
	{
		//trace("XMLGeneral: " + tag + " " + sett + " " + bUseEvent);
		if (basenode === null) return false;
		var bNode:XMLNode = basenode;
		if (basenode === undefined) bNode = flNode;
		
		if (!bUseEvent) {
			delete tempVars;
			tempVars = new Array();
		}
		
		var bUseOld:Boolean = bUseEvent;
	
		if (!XMLEventByNode(GetNode(bNode, tag), sett, undefined, true)) {
			if (bNode != evtNode && !XMLEventByNode(GetNode(evtNode, tag), sett, undefined, true)) {
				if (bNode == flNode) return false;
				if (!XMLEventByNode(GetNode(flNode, tag), sett, undefined, true)) return false;
			}
		}
		//trace("EventText = " + EventText);
		
		bUseEvent = bUseOld;

		
		if (EventText != "" && !bUseOld) {
			while (EventText.substr(-1, 1) == "\r") EventText = EventText.substr(0, EventText.length-1);
			if (EventText != "") {
				if (sett == true) coreGame.SetText(EventText);
				else coreGame.AddText(EventText);
			}
			EventText = "";
		}
		
		coreGame.PositionQuestions();
		coreGame.PositionYesNo();
		return true;
	}
	
	public function XMLGeneralSA(tag:String, sett:Boolean, basenode:XMLNode) : Boolean
	{
		if (XMLGeneral(tag, sett, basenode)) {
			coreGame.Language.BlankLine();
			return true;
		}
		return false;
	}
	
	
	// Slave XML
	
	// Get actual xml for a slave. This is the unmerged xml for the slave. Used for <Other> node and similar
	public function GetSlaveXML(slave:String, obj:Object) : XMLNode
	{	
		var s:String;
		s = slave.split(" ").join("");
		//trace("GetSlaveXML: " + slave);
			
		var sd:Object;
		if (obj != null && obj != undefined) {
			sd = obj;
			if (sd == coreGame.slaveData && slaveNode != null) return slaveNode;
			if (sd == coreGame.AssistantData && coreGame.assNode != null && coreGame.AssistantData.sNode != null) return coreGame.assNode;
			if (slave == "" || slave == undefined) {
				if (sd.SlaveFilename != "" && sd.SlaveFilename != undefined) slave = sd.SlaveFilename;
				else if (sd.SlaveImage != "" && sd.SlaveImage != undefined) slave = sd.SlaveImage;
				else slave = sd.SlaveName;
				if (slave == undefined) slave = coreGame.PersonName;
			}
		} else {
			if (slave == undefined) slave = coreGame.PersonName;
			if (coreGame.IsSlave(slave) && slaveNode != null) return slaveNode;
			sd = coreGame.SMData.GetSlaveDetails(slave, true);
		}
		
		if (sd != null && sd.sNode != null) return sd.sNode;
		
		slave = slave.split("&").join("");
		
		// check list of loaded assistants
		obj = coreGame.SlaveList.GetAssistantListDetails(slave);
		if (obj != null) {
			var sNode:XMLNode = GetNodeC(obj.xmlload.firstChild.firstChild, sd == null || sd.SlaveType == -1 || sd.SlaveType == 2 ? "Assistant" : "Slave");
			if (sNode != null) {
				trace("..got loaded assistant");
				return sNode;
			}
		}
		
		// check list of minor slaves
		for (var msNode:XMLNode = mslavesNode; msNode != null; msNode = msNode.nextSibling) {
			if (msNode.nodeType != 1) continue;
			if (msNode.nodeName.toLowerCase() == "slave") {
				if (IsSlaveMinor(slave, msNode)) {
					trace("..got minor slave");
					return msNode.firstChild;
				}
			}
		}
		
		// check if they are a special participant for the current slave
		for (var msNode:XMLNode = GetNodeC(slaveNode, "SpecialParticipants"); msNode != null; msNode = msNode.nextSibling) {
			if (msNode.nodeType != 1) continue;
			if (msNode.nodeName.toLowerCase() == "participant") {
				if (IsSlaveMinor(slave, msNode)) {
					trace("..got participant: " + slave);
					return msNode.firstChild;
				}
			}
		}
		
		// check list of loaded slaves 
		var slv:LoadVars = coreGame.SlaveList.GetSlaveListDetails(slave);
		if (slv != null) {
			var sNode:XMLNode = GetNodeC(slv.xmlload.firstChild.firstChild, sd.SlaveType == -1 || sd.SlaveType == 2 ? "Assistant" : "Slave");
			if (sNode != null) {
				trace("..got slave list");
				return sNode;
			}
		}
		
		// try for special participant for other slave
		for (var so:String in coreGame.SlaveList.arSlaveList) {
			slv = coreGame.SlaveList.arSlaveList[so];
			for (var msNode:XMLNode = GetNodeC(slv.xmlload.firstChild.firstChild.firstChild, "SpecialParticipants"); msNode != null; msNode = msNode.nextSibling) {
				if (msNode.nodeType != 1) continue;
				if (msNode.nodeName.toLowerCase() == "participant") {
					//trace("checking " + slave + " against " + GetXMLString("Name", msNode.firstChild).toLowerCase());
					if (IsSlaveMinor(slave, msNode)) {
						trace("..got participant (other)");
						return msNode.firstChild;
					}
				}
			}
		}
		
		// check list of loaded assistants for a special participant
		for (var so:String in coreGame.SlaveList.arAssistants) {
			obj = coreGame.SlaveList.arAssistants[so];
			for (var msNode:XMLNode = GetNodeC(obj.xmlload.firstChild.firstChild.firstChild, "SpecialParticipants"); msNode != null; msNode = msNode.nextSibling) {
				if (msNode.nodeType != 1) continue;
				if (msNode.nodeName.toLowerCase() == "participant") {
					if (IsSlaveMinor(slave, msNode)) {
						trace("..got participant (assistant)");
						return msNode.firstChild;
					}
				}
			}
		}
	
		// no match at all!
		trace("not found");
		return null;
	}
	
	// return adjusted xml
	// main slave 	- slaveNode children of <Slave> node
	// assistant 	- assNode children of <Assistant> node
	// other		- return actual xml node from Slaves Array using GetSlaveXML as needed
	public function GetSlaveObjectXML(sd:Object) : XMLNode
	{
		if (sd == _root || sd == coreGame.SMData || sd == coreGame.slaveData) return coreGame.slaveNode;
		if (sd == coreGame.AssistantData) return coreGame.assNode;
		if (sd.sNode == null) sd.sNode = GetSlaveXML(sd.SlaveName);
		if (sd != null && sd.sNode != null) return sd.sNode;
	
		return null;
	}
	
	// Minor Slaves
	public function IsSlaveMinor(slave:String, aNode:XMLNode) : Boolean
	{
		var sl:Array = slave.split(" ");
		var slnsp:String = slave.split(" ").join("").toLowerCase();
	
		var str:String = GetXMLString("Name", aNode.firstChild).toLowerCase();
		//trace("IsSlaveMinor: " + slave + " " + str);
		var slchk:String = SlaveMaker.ProcessSlaveName(slave);
		if (str == slchk) return true;
		if (str.split(" ").join("") == slchk.split(" ").join("")) return true;
		
		
		str = GetXMLStringSimple("Folder", aNode.firstChild).toLowerCase();
		if (str != "") {
			if (str == slave.toLowerCase()) return true;
			sl = str.split("/");
			slchk = sl[sl.length - 1];
			if (slchk.split(" ").join("") == slnsp) return true;
		}
		str = GetXMLStringSimple("Image", aNode.firstChild).toLowerCase();
		if (str != "") {
			if (str.toLowerCase() == slave.toLowerCase()) return true;
			sl = str.split("/");
			slchk = sl[sl.length - 1].split(".")[0];
			sl = slchk.toLowerCase().split("-");
			slchk = sl[sl.length - 1];
			if (slchk.substr(0, 9) != "Assistant") {
				if (slchk.split(" ").join("") == slnsp) return true;
			}
		}
		if (slave.indexOf("&") != -1) return IsSlaveMinor(slave.split("&").join(""), aNode);
		return false;
	}
	
	// Events (General)
	
	public function GetEventToPerform(aNode:XMLNode) : Object
	{
		if (aNode.firstChild.nodeType == 1 || aNode.firstChild.hasChildNodes()) return aNode;
		var str:String = aNode.firstChild.nodeValue;
		if (isNaN(str.charAt(0))) return String(str);
		else return Number(str);
	}
	
	// Debugging
	public function ShowNodeDetails(say:String, xNode:XMLNode) : String
	{
		for (var aNode:XMLNode = xNode; aNode != null; aNode = aNode.nextSibling) {
			if (aNode.nodeType == 1) say += "<" + aNode.nodeName + ">\r";
		}
		return say;
	}
	
	// debugging
	private function SMTRACE(s:Object) { coreGame.SMTRACE(s); }

	
}