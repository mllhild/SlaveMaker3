// Language XML Strings
// and general text functions
//
// Translation status: INCOMPLETE
import Scripts.Classes.*;
import mx.containers.*;

class GameLanguage extends GameLanguageBase {
	
	// public (see GameLanguageBase)
	// overload with specific class, not Object
	public var XMLData:GameXML;

	// private (internal use only)
	private var coreGame:Object;
	
	private var arLangArray:Array;
		
	private var bLangLoaded:Boolean;
	
	private var fno:Object;
	private var fnc:String;
	private var nLangLoadedCnt:Number;
	private var nLangLoadedMax:Number;
	private var nLangLoadedCurr:Number;
	
	// Text
	private var FontText:String;
	
	public var GeneralTextField:TextField;		// reference
	
	private var strSavetxt:String;
	
	public var LargerTextField:ScrollPane;		// reference

	
	// constructor 
	public function GameLanguage(cg:Object)
	{ 
		coreGame = cg;
		XMLData = cg.XMLData;
		bLangLoaded = false;
		LangType = "English";		
		
		styles = new TextField.StyleSheet();
		styles.setStyle("sp2", {letterSpacing: '-2'} );
		styles.setStyle("sp1", {letterSpacing: '-1'} );
		styles.setStyle("sph", {letterSpacing: '-0.5'} );
		styles.setStyle("ps", {color: '#660000' } );
		styles.setStyle("bluetext",	{color: '#0000ff' } );
		styles.setStyle("redtext", {color: '#ff0000' } );
		styles.setStyle("greentext", {color: '#00ff00' } );
		styles.setStyle("ld2", {leading: 2 } );
		styles.setStyle("ld3", {leading: 3 } );
		styles.setStyle("ld4", {leading: 4 } );
		
		GeneralTextField = coreGame.GeneralTextField;
		LargerTextField = coreGame.LargerTextField;
		
		GeneralText = "";
		LargerText = "";
		FontText = "";
		
		GeneralTextField.wordWrap = true;
		GeneralTextField.autoSize = true;
		LargerTextField.content.LargerTextField.wordWrap = true;
		LargerTextField.content.LargerTextField.autoSize = true;
		LargerTextField.setStyle("borderStyle", "none");
		LargerTextField.tabChildren = false;
		LargerTextField.tabEnabled = false;
		
		spListener = new Object();
		spListener.scroll = function(evt_obj:Object):Void {
			evt_obj.redraw();
		};
		LargerTextField.addEventListener("scroll", spListener);
		
		LargerTextField.content.LargerTextField.styleSheet = styles;
		GeneralTextField.styleSheet = styles;
		coreGame.GirlsStoryTop.BlackText.styleSheet = styles;
		coreGame.GirlsStoryTop.WhiteText.styleSheet = styles;
	}
	
	public function IsLoaded() : Boolean { return bLangLoaded; }


	private function AddXMLCL(str:String, stype:Boolean)
	{		
		// english version
		var strCurr:String;
		if (stype) strCurr = str + ".xml";
		else strCurr = "Language/English/" + str + ".xml";
		arLangArray.push(strCurr);
		//SMTRACE("Adding " + strCurr);
		var xThisLang:XML = new XML();
		var ti:GameLanguage = this;
		xThisLang.onLoad = function(success:Boolean) { ti.LanguageLoaded(success); }
		arLangArray.push(xThisLang);
		
		// translated
		if (LangType == "English") return;
		
		if (stype) strCurr = str + "-" + LangType + ".xml";
		else strCurr = "Language/" + LangType + "/" + str + ".xml";
		arLangArray.push(strCurr);
		//SMTRACE("Adding " + strCurr);
		xThisLang = new XML();
		xThisLang.onLoad = function(success:Boolean) { ti.LanguageLoaded(success); }
		arLangArray.push(xThisLang);
	}
	
	public function ChangeLanguage(assonly:Boolean, fncstr:String, fnobj:Object)
	{
		SMTRACE("ChangeLanguage: " + coreGame.GetUTCMSElapsed(true));
		coreGame.SlaveGender = coreGame.slaveData.SlaveGender;
		
		bLangLoaded = false;
		if (fnobj == undefined) fnobj = _root;
		fno = fnobj;
		fnc = fncstr;
		
		if (assonly != true) {
			delete xNode;
			xNode = new XML();
			var rootn:XMLNode = new XMLNode(1, "Language");
			xNode.appendChild(rootn);
			
			// reset events
			coreGame.modulesList.Reset();
		}
		
		nLangLoadedCnt = 0;
		nLangLoadedMax = 0;
		
		// xml files to load
		var cNode:XMLNode = XMLData.GetNode(coreGame.config.xConfigNode, "XMLFiles");
		if (cNode == null) {
			//SMTRACE("bad xmls in configuration");
			if (fnc != undefined) fno[fnc]();
			return;
		}
		var aNode:XMLNode = cNode;
		if (!assonly) {
			// add general nodes
			for (aNode = aNode.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var str:String = aNode.nodeName.toLowerCase();
				if (str == "file") {
					if (aNode.attributes.city.toLowerCase() == "true" && coreGame.Home == null) continue; 
					nLangLoadedMax++;
					if (LangType != "English") nLangLoadedMax++;
					if (coreGame.slaveData != null && coreGame.SlaveGender > 3 && aNode.attributes.twins.toLowerCase() == "true") nLangLoadedMax++;
				}
			}
			
			// add events
			if (LangType != "English") nLangLoadedMax += 2 * coreGame.modulesList.GetCustomLength();
			else nLangLoadedMax += coreGame.modulesList.GetCustomLength();

			// add slave
			if (coreGame.slaveData != null && coreGame.SlaveFilename != "") {
				nLangLoadedMax++;
				if (LangType != "English") nLangLoadedMax++;
			}
		}
		// assistant
		if (coreGame.AssistantData != null) {
			if (coreGame.AssistantData.SlaveFilename != "") {
				nLangLoadedMax++;
				if (LangType != "English") nLangLoadedMax++;
			}
		} else if (assonly) {
			nLangLoadedMax++;
			if (LangType != "English") nLangLoadedMax++;
			if (coreGame.slaveData != null && coreGame.SlaveGender > 3) {
				nLangLoadedMax++;
				if (LangType != "English") nLangLoadedMax++;
			}
		}
		
		//SMTRACE("ChangeLanguage: " + nLangLoadedMax);
		arLangArray = new Array();
		aNode = cNode;
		
		if (!assonly) {
			// general nodes
			var str:String;
			for (aNode = aNode.firstChild; aNode != null; aNode = aNode.nextSibling) {
				if (aNode.nodeName.toLowerCase() == "file") {
					str = aNode.firstChild.nodeValue;
					if (aNode.attributes.city.toLowerCase() == "true") {
						if (coreGame.currentCity == null) continue;
						str = "Cities/" + coreGame.currentCity.ModuleName + "/" + str;
					}
					AddXMLCL(str, false);
					// twins
					if (coreGame.slaveData != null && coreGame.SlaveGender > 3 && aNode.attributes.twins.toLowerCase() == "true") AddXMLCL(str + " (Twins)", false);
				}
			}
			
			// add events
			var evt:SlaveModule;
			var elength:Number = coreGame.modulesList.GetCustomLength();
			for (var index:Number = 0; index < elength; index++) {		
				evt = coreGame.modulesList.GetEventDataIdx(index);
				AddXMLCL("Events/" + evt.ModuleName.split(".")[0], true); 
			}
			
			// add slave
			if (coreGame.slaveData != null && coreGame.SlaveFilename != "") AddXMLCL(coreGame.SlaveFilename.slice(0, -4), true);
		}

		// assistant
		if (coreGame.AssistantData != null) {
			if (coreGame.AssistantData.SlaveFilename != "") AddXMLCL(coreGame.ServantFilename.slice(0, -4), true);
		} else if (assonly) {
			AddXMLCL("No Assistant", false);
			if (coreGame.slaveData != null && coreGame.SlaveGender > 3) AddXMLCL("No Assistant (Twins)", false);
		}
		
		// load n at a time
		nLangLoadedCurr = 0;
		if (nLangLoadedMax == 0) LanguageLoaded(false);
		else {	
			var iSim:Number = coreGame.config.nParallelLoading;
			trace("parallel: " + iSim);
			for (var i:Number = 0; i < iSim; i++) {
				if (nLangLoadedCurr >= nLangLoadedMax) break;
				//SMTRACE("load lang xml " + arLangArray[2 * nLangLoadedCurr]);
				arLangArray[(2 * nLangLoadedCurr) + 1].load(arLangArray[2 * nLangLoadedCurr]);
				nLangLoadedCurr++;
			}
		}
	}
		
	public function LanguageLoaded(success:Boolean) {
		nLangLoadedCnt++;
		nLangLoadedCurr--
		//SMTRACE("LanguageLoaded: " + success + " " + nLangLoadedCnt + " " + nLangLoadedCurr);
		if (nLangLoadedMax > 0 && nLangLoadedCnt != nLangLoadedMax) {
			if (nLangLoadedCurr != 0) return;
			var iSim:Number = coreGame.config.nParallelLoading;
			for (var i:Number = 0; i < iSim; i++) {
				if ((nLangLoadedCnt + nLangLoadedCurr) > nLangLoadedMax) break;
				arLangArray[(2 * (nLangLoadedCnt + nLangLoadedCurr)) + 1].load(arLangArray[2 * (nLangLoadedCnt + nLangLoadedCurr)]);
				nLangLoadedCurr++;
			}
			return;
		}
		
		SMTRACE("ChangeLanguage: all files loaded: " + coreGame.GetUTCMSElapsed());
		for (var i:Number = 0; i < nLangLoadedMax; i++) {
			
			var lcs:String = String(arLangArray.shift());
			var xThisLang:XML = XML(arLangArray.shift());
			//SMTRACE("Merging: " + lcs + " " + xThisLang.loaded + " " + i + " " + nLangLoadedMax);
			
			if (xThisLang.loaded) {
				if (lcs.indexOf("/Acts") != -1) {
					//SMTRACE("merge acts");
					if (xThisLang.firstChild.nodeName == "DoPlanning") XMLData.MergeXML(XMLData.GetNode("Planning/Acts"), xThisLang);
					else XMLData.MergeXML(XMLData.GetNode("Planning"), xThisLang);
				} else if (coreGame.slaveData != null && coreGame.SlaveFilename != "" && lcs.indexOf(coreGame.SlaveFilename.slice(0, -4)) != -1) {
					//SMTRACE("merge slave");
					XMLData.MergeXML(xNode, xThisLang, "Assistant");
				} else if (coreGame.AssistantData != null && coreGame.ServantFilename != "" && lcs.indexOf(coreGame.ServantFilename.slice(0, -4)) != -1) {
					//SMTRACE("merge assistant");
					XMLData.MergeXML(XMLData.GetNode("Assistant"), XMLData.GetNode(xThisLang.firstChild.firstChild, "Assistant"), undefined, undefined, undefined, true);
					XMLData.MergeXML(XMLData.GetNode("Assistant/Images"), XMLData.GetNode(xThisLang.firstChild.firstChild, "Slave/Images"), undefined, undefined, undefined, true);
				} else {
					//SMTRACE("merge other");
					if (xThisLang.firstChild.nodeName == "Language") XMLData.MergeXML(xNode, xThisLang);
					else XMLData.MergeXML(xNode.firstChild, xThisLang);
					if (lcs.indexOf("/Base") != -1) {
						flNode = xNode.firstChild.firstChild;
						XMLData.flNode = flNode;
					}
				}
			}
			delete xThisLang;
			delete lcs;
		}
		delete arLangArray;
		
		trace("loading language complete: " + coreGame.GetUTCMSElapsed());
		
		if (coreGame.AssistantData != null) {
			// copy xml into <Assistant> node
			trace("..copy assistant xml details");
			XMLData.MergeXML(XMLData.GetNode(flNode, "Assistant"), coreGame.AssistantData.sNode.parentNode, "Introduction", "Introduction1", undefined, true, true);
		}		
		if (coreGame.SMAvatar.GetXML() != null) {
			trace("..merge slavemaker xml details");
			XMLData.MergeXML(XMLData.GetNode(flNode, "Events"), XMLData.GetNode(coreGame.SMAvatar.GetXML(), "Events"), undefined, undefined, undefined, false, true);
			XMLData.MergeXML(XMLData.GetNode(flNode, "Planning/DoPlanning"), XMLData.GetNode(coreGame.SMAvatar.GetXML(), "Planning/DoPlanning"), undefined, undefined, undefined, true, true);
		}
		
		//trace("popoulating");
		PopulateLanguage();

		bLangLoaded = true;
		//trace("calling: " + fno + "[" + fnc + "]");
		
		if (fnc != undefined) fno[fnc]();
	}
	
	public function PopulateLanguage()
	{
		/*
		XMLData.SetCurrentSlaveXML(null);
		assNode = null;
		XMLData.evtNode = null;
		actNode = null;
		hintNode = null;
		statNode = null;
		walkNode = null;
		XMLData.dpNode = null;
		gndNode = null;
		skNode = null;
		*/
	
		XMLData.Reset();
		flNode = xNode.firstChild.firstChild;
		XMLData.flNode = flNode;
		coreGame.flNode = flNode;
		
		for (var aNode:XMLNode = flNode; aNode != null; aNode = aNode.nextSibling) {
			if (aNode.nodeType != 1 || aNode.nodeName == "Options") continue;
			PopulateLanguageNode(aNode);
		}
		
		delete arLangArray;
		arLangArray = new Array();
	
		XMLData.mslavesNode = XMLData.GetNodeC(flNode, "Slaves");
		XMLData.defimgNode = XMLData.GetNodeC(XMLData.mslavesNode, "Default/Images");
		
		GP = GetHtml("GoldPieces", "Shopping");
		coreGame.GP = GP;
		
		strDefPronoun = GetHtml("Pronoun", gndNode);
		strPronounTwins = GetHtml("PronounTwins", gndNode);
		
		// set standard labels for acts
		BreakLabel = GetHtml("Break", actNode);
		DanceLabel = GetHtml("Dance", actNode);
		MakeUpLabel = GetHtml("MakeUp", actNode);
		LibraryLabel = GetHtml("Library", actNode);
		BrothelLabel = GetHtml("Brothel", actNode);
		CatNapLabel = GetHtml("CatNap", actNode);
		CatalogingLabel = GetHtml("Cataloging", actNode);
		CatHouseLabel = GetHtml("CatHouse", actNode);
		PreeningLabel = GetHtml("Preening", actNode);
		GroomingLabel = GetHtml("Grooming", actNode);
		PrancingLabel = GetHtml("Prancing", actNode);
		FitnessLabel = GetHtml("Fitness", actNode);
		ExposeLabel = GetHtml("Expose", actNode);
		RideLabel = GetHtml("Ride", actNode);
		PresentLabel = GetHtml("Present", actNode);
		
		coreGame.assNode = assNode;
		coreGame.evtNode = XMLData.evtNode;
		coreGame.actNode = actNode;
		coreGame.hintNode = hintNode;
		coreGame.statNode = statNode;
		coreGame.walkNode = walkNode;
		coreGame.gndNode = gndNode;
		coreGame.skNode = skNode;
		
		//coreGame.TitleScreen.SetHowToPlayPage();
		
		coreGame.modulesList.InitialiseModule();		// force reload of base xml nodes
		
		coreGame.currentCity.ResetPlacesNodes();
	}
	
	public function PopulateLanguageNode(aNode:XMLNode)
	{
		var txt:TextField;
		var str:String = aNode.nodeName;
		var i:Number;
		aNode = aNode.firstChild;
	
		if (str == "Slave") XMLData.SetCurrentSlaveXML(aNode);
		else if (str == "Assistant") assNode = aNode;
		else if (str == "Events") {
			XMLData.evtNode = aNode;
			var iDone:Number = 0;
			for (var iNode:XMLNode = aNode; iNode != null && iDone < 3; iNode = iNode.nextSibling) {
				if (iNode.nodeType == 1) {
					if (iNode.nodeName == "Walk") { walkNode = iNode.firstChild; iDone++; }
					else if (iNode.nodeName == "UpdateSlave") { XMLData.usNode = iNode.firstChild; iDone++; }
					else if (iNode.nodeName == "ChangeActButtons") { XMLData.cbNode = iNode.firstChild; iDone++; }
				}
			}
		} else if (str == "Hints") hintNode = aNode;
		else if (str == "Gender") gndNode = aNode;
		else if (str == "Skills") skNode = aNode;
		else if (str == "Participants") coreGame.ParticipantsChanger.LAddSlave.htmlText = GetHtml("PickASlave", aNode);
		else if (str == "Visits") coreGame.PlanningShops.LVisiting.htmlText = GetHtml("VisitingTitle", aNode);		
		else {
			delete arLangArray;
			arLangArray = new Array();
			coreGame.dspMain.UpdateText(str, aNode);
			if (str == "Other") {
				PopulateOther(aNode.firstChild);
				continue;
			}
			if (str == "Statistics") PopulateStatistics(aNode);
			else if (str == "Buttons") PopulateButtons(aNode);
			else if (str == "Options") PopulateOptions(aNode);
			else if (str == "Planning") PopulatePlanning(aNode);
	
			for (var iNode:XMLNode = aNode; iNode != null; iNode = iNode.nextSibling) {
				if (iNode.nodeType == 1) {
					i = arLangArray.length;
					do {
						if (arLangArray[i - 5] == iNode.nodeName) {
							txt = arLangArray[i - 6];
							txt.styleSheet = styles;
							txt.htmlText = UpdateLanguageString(iNode.firstChild.nodeValue, arLangArray[i - 4], iNode.attributes.spacing == undefined ? arLangArray[i - 3] : iNode.attributes.spacing, arLangArray[i - 2], iNode.attributes.fontsize, arLangArray[i - 1], arLangArray[i - 7]);
						}
						i -= 7;
					} while (i > 0);
						
				}
			}
		}
	}
	
	private function ApplyLang(mc:TextField, str:String, bold:Boolean, spacing:Number, shortcut:String, italic:Boolean, strplus:String)
	{
		arLangArray.push(strplus);
		arLangArray.push(mc);
		arLangArray.push(str);
		arLangArray.push(bold);
		arLangArray.push(spacing);
		arLangArray.push(shortcut);
		arLangArray.push(italic);
	}
	
	public function UpdateLanguageString(str:String, bold:Boolean, spacing:Number, shortcut:String, fsize:String, italic:Boolean, strplus:String) : String
	{
		if (str == undefined) str = "";
		if (strplus != undefined) str += strplus;
		str = str.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join("");
		if (str.indexOf("#") != -1) str = coreGame.UpdateMacros(str);
		if (shortcut != undefined && shortcut != "") {
			var idx:Number = str.indexOf(shortcut);
			if (idx == -1) idx = str.indexOf(shortcut.toLowerCase());
			if (idx != -1) {
				var nstr:String = "";
				if (idx > 0) nstr = str.substr(0, idx);
				nstr += "<font color='#0000FF'>" + str.charAt(idx) + "</font>";
				if (idx < (str.length - 1)) nstr += str.substr(idx + 1);
				str = nstr;
			}
		}
		if (bold == true) str = "<b>" + str + "</b>";
		if (italic == true) str = "<i>" + str + "</i>";
		if (fsize != undefined && fsize != "") str = "<font size='" + fsize + "'>" + str + "</font>";
		if (spacing < 0) return "<sp" + Math.abs(spacing) + ">" + str + "</sp" + Math.abs(spacing) + ">";
		return str;
	}
	
	private function PopulateStatistics(aNode:XMLNode)
	{	
		statNode = aNode;
				
		coreGame.modulesList.trainLesbians.SetLesbianStats(_root);
											
		strCM = GetText("Centimeters", statNode);
		strKG = GetText("Kilograms", statNode);
		strIN = GetText("Inches", statNode);
		strPD = GetText("Pounds", statNode);
		strSLS = GetHtml("SlaveStatistics", statNode, false, 0, "", ":");
		strHuman = GetText("Race0", statNode);
	}
	
	private function PopulateButtons(aNode:XMLNode)
	{
		btnNode = aNode;
		
		ApplyLang(coreGame.YesEvent.LText, "Yes", false, 0, "Y");
		ApplyLang(coreGame.NoEvent.LText, "No", false, 0 , "N");
		ApplyLang(coreGame.EquipmentButton.LText, "Equipment", false, 0, "q");
		ApplyLang(coreGame.SMEquipmentButton.LText, "YourGear", false, 0, "G");
		ApplyLang(coreGame.MorningEveningMenu.RulesButton.LText, "Rules", false, 0, "R");
		ApplyLang(coreGame.MorningButton.LText, "Morning", false, -1, "M");
		ApplyLang(coreGame.EveningButton.LText, "Evening", false, -1, "E");
		ApplyLang(coreGame.PlanningButton.LText, "Planning", false, -1, "P");
		ApplyLang(coreGame.DoThePlanning.LText, "DoThePlanning", false, -1);
		
		coreGame.Quitter.LText.htmlText = GetHtml("Leave", aNode);
		
		ApplyLang(coreGame.mcEndGame.SaveButton.LText, "Save", false, -1, "S");
		ApplyLang(coreGame.mcEndGame.LoadButton.LText, "Load", false, -1, "L");
	
		ApplyLang(coreGame.IntroBackButton.LText, "Back");
		ApplyLang(coreGame.IntroLoadButton.LText, "Load");
		ApplyLang(coreGame.IntroTitle.BtnCredits.LText, "Credits", false, 0, "C");
		ApplyLang(coreGame.IntroTitle.HowToPlay.LText, "HowToPlay", false, 0, "H");
		ApplyLang(coreGame.IntroTitle.LoadGame.LText, "LoadGame", false, 0, "L");
		ApplyLang(coreGame.IntroTitle.NewGame2.LText, "NewTitle", false, 0, "N");
		ApplyLang(coreGame.IntroSkip.LText, "Skip");
		ApplyLang(coreGame.IntroSkip.LTextBG, "Skip");
		
		coreGame.NextEvent.LText.htmlText = GetHtml("Next", aNode, false, -1);
		CopyTF(coreGame.NextGeneral.LText, coreGame.NextEvent.LText);
		CopyTF(coreGame.GirlsStoryTop.GirlsStoryNext.LText, coreGame.NextEvent.LText);
		CopyTF(coreGame.IntroNextButton.LText, coreGame.NextEvent.LText);
		
		ApplyLang(coreGame.PlanningSelections.ClearButton.LText, "Clear", false, -1);
		ApplyLang(coreGame.ParticipantsChanger.ClearButton.LText, "Clear", false, -1);
		ApplyLang(coreGame.PlanningSelections.Set1.LText, "Set1");
		ApplyLang(coreGame.PlanningSelections.Set2.LText, "Set2");
		ApplyLang(coreGame.PlanningSelections.Set3.LText, "Set3");
		
		ApplyLang(coreGame.SlaveMakerCreate1.Gods.LText, "Change");
		ApplyLang(coreGame.SlaveMakerCreate1.UseLast.LText, "UseLast");
		ApplyLang(coreGame.SlaveMakerCreate1.PackageBtn.Label, "PickPackage");
		ApplyLang(coreGame.SlaveMakerCreate1.AdvancedBtn.Label, "Advanced");
		ApplyLang(coreGame.SlaveMakerCreate2.MoreButton.LText, "More", false, -1);
		
		ApplyLang(coreGame.SlaveMakerCreate3.DoneBtn.LText, "Done", false, -1);
		
		ApplyLang(coreGame.SlaveMakerCreate3.HomeTown.LText, "Origins", false, -1);
		ApplyLang(coreGame.SlaveMakerCreate3.SpecialEvent.LText, "SpecialEvent", false, -1);
		ApplyLang(coreGame.SlaveMakerCreate3.Advantages.LText, "Advantages", false, -1);
		ApplyLang(coreGame.SlaveMakerCreate3.InitialItems.LText, "InitialItems", false, -1);
		ApplyLang(coreGame.SlaveMakerCreate3.Skills.LText, "Skills", false, -1);
		ApplyLang(coreGame.SlaveMakerCreate3.Statistics.LText, "Statistics", false, -1);
		
		ApplyLang(coreGame.PlanningPage.ShopsButton.BlackText, "ShopsWalk", true, -1);
		ApplyLang(coreGame.PlanningPage.ShopsButton.WhiteText, "ShopsWalk", true, -1);
		ApplyLang(coreGame.PlanningPage.SexNormalButton.BlackText, "SexNormal", true, -1);
		ApplyLang(coreGame.PlanningPage.SexNormalButton.WhiteText, "SexNormal", true, -1);
		ApplyLang(coreGame.PlanningPage.SexExtremeButton.BlackText, "SexExtreme", true, -1);
		ApplyLang(coreGame.PlanningPage.SexExtremeButton.WhiteText, "SexExtreme", true, -1);
		ApplyLang(coreGame.PlanningPage.SlaveMakerButton.BlackText, "SlaveMaker", true, -1);
		ApplyLang(coreGame.PlanningPage.SlaveMakerButton.WhiteText, "SlaveMaker", true, -1);
		ApplyLang(coreGame.PlanningPage.Page1.LText, "Page1");
		ApplyLang(coreGame.PlanningPage.Page2.LText, "Page2");
		ApplyLang(coreGame.PlanningPage.Page3.LText, "Page3");
		ApplyLang(coreGame.PlanningPage.Page4.LText, "Page4");
		ApplyLang(coreGame.PlanningPage.Page5.LText, "Page5");
		
		ApplyLang(coreGame.DiscussScold.LText, "Scold", false, -1, "S");
		ApplyLang(coreGame.DiscussCongratulate.LText, "Congratulate", false, -1, "C");
		ApplyLang(coreGame.DiscussOrdinary.LText, "OrdinaryDiscussion", false, -1, "O");
		
		ApplyLang(coreGame.PlanningSelections.ParticipantsBtn.LText,"SelectParticipants", true, -1);
		ApplyLang(coreGame.ParticipantsChanger.DefaultBtn.LText, "Default", false, -1);
							
		strReview = GetHtml("Review", aNode);
		strRemove = GetHtml("Remove", aNode);
	}
	
	private function PopulateOptions(aNode:XMLNode)
	{		
		coreGame.Options.UpdateText("Options", aNode);
		
		ApplyLang(coreGame.SlaveMakerCreate1.OptionsButton.LText, "Title", false, -1);
		ApplyLang(coreGame.SlaveMakerCreate1.LOptions, "Title");
	}
	
	private function PopulatePlanning(aNode:XMLNode)
	{
		trace("PopulatePlanning");
		
		for (var iNode:XMLNode = aNode; iNode != null; iNode = iNode.nextSibling) {
			if (iNode.nodeType == 1 && iNode.nodeName == "Acts") {
				actNode = iNode.firstChild;
				break;
			}
		}
		ApplyLang(coreGame.PlanningSelections.LSlaveAction, "SlaveAction", true, -1);
		ApplyLang(coreGame.PlanningSelections.LSMAction, "SlaveMakerAction", true, -1);
		coreGame.PlanningSelections.ChkSameListDay.label = GetHtml("UseTomorrow", aNode);
		coreGame.PlanningSelections.ChkSameListNight.label = coreGame.PlanningSelections.ChkSameListDay.label;
		
		ApplyLang(coreGame.PlanningPage.JobsButton.BlackText, "JobsTitle", true, -1);
		ApplyLang(coreGame.PlanningPage.JobsButton.WhiteText, "JobsTitle", true, -1);
		ApplyLang(coreGame.PlanningPage.ChoresButton.BlackText, "ChoresTitle", true, -1);
		ApplyLang(coreGame.PlanningPage.ChoresButton.WhiteText, "ChoresTitle", true, -1);
		ApplyLang(coreGame.PlanningPage.SchoolsButton.BlackText, "SchoolsTitle", true, -1);
		ApplyLang(coreGame.PlanningPage.SchoolsButton.WhiteText, "SchoolsTitle", true, -1);
		
		PersonalSupervisionString = GetHtml("PersonalSupervision", aNode);
		AssistantSupervisionString = GetHtml("AssistantSupervision", aNode);
		
		XMLData.dpNode = XMLData.GetNodeC(actNode, "DoPlanning");
	}
	
	private function PopulateOther(aNode:XMLNode)
	{	
		coreGame.PlanningSelections.LTime.htmlText = GetHtml("Time", aNode, true, -1);
	}
	
	// Get a general string at anytime
	public function GetHtml(str:String, node, bold:Boolean, spacing:Number, shortcut:String, strplus:String, italic:Boolean) : String
	{
		var iNode:XMLNode;
		if (typeof(node) == "string") {
			if (node == "Acts") iNode = actNode;
			else if (node == "Statistics") iNode = statNode;
			else if (node == "Hints") iNode = hintNode;
			else if (node == "Buttons") iNode = btnNode;
			else if (node == "Assistants") iNode = assNode;
			else if (node == "Events") iNode = XMLData.evtNode;
			else if (node == "Walk") iNode = walkNode;
			else iNode = XMLData.GetNodeC(flNode, node);
		} else iNode = node == undefined ? XMLData.GetNodeC(flNode, "Other") : node;
		
		if (str.indexOf("/") != -1) iNode = XMLData.GetNode(iNode, str);
		else {
			// simplified version of GetNode()
			while (iNode != null) {
				if (iNode.nodeType == 1 && str == iNode.nodeName) break;
				iNode = iNode.nextSibling
			}
		}
		if (iNode != null) return UpdateLanguageString(iNode.firstChild.nodeValue, bold, iNode.attributes.spacing == undefined ? spacing : iNode.attributes.spacing, shortcut, iNode.attributes.fontsize, italic, strplus);
		return "";
	}
	
	public function GetHtmlDef(str:String, node, def:String, bold:Boolean, spacing:Number, shortcut:String, strplus:String, italic:Boolean) : String
	{
		var rstr:String = GetHtml(str, node, bold, spacing, shortcut, strplus, italic);
		if (rstr == "") return def == undefined ? str : coreGame.UpdateMacros(def);
		return rstr;
	}
	
	public function GetText(str:String, node) : String
	{
		var iNode:XMLNode;
		if (typeof(node) == "string") {
			if (node == "Acts") iNode = actNode;
			else if (node == "Statistics") iNode = statNode;
			else if (node == "Hints") iNode = hintNode;
			else if (node == "Buttons") iNode = btnNode;
			else if (node == "Assistants") iNode = assNode;
			else if (node == "Events") iNode = XMLData.evtNode;
			else if (node == "Walk") iNode = walkNode;
			else iNode = XMLData.GetNodeC(flNode, node);
		} else iNode = node == undefined ? XMLData.GetNodeC(flNode, "Other") : node;
		
		if (str.indexOf("/") != -1) iNode = XMLData.GetNode(iNode, str);
		else {
			// simplified version of GetNode()
			while (iNode != null) {
				if (iNode.nodeType == 1 && str == iNode.nodeName) break;
				iNode = iNode.nextSibling
			}
		}
		if (iNode != null) {
			str = iNode.firstChild.nodeValue.split("\\r").join("\r").split("\\n").join("\n").split("\r\n").join("\r");
			if (str.indexOf("#") != -1) str = coreGame.UpdateMacros(str);		
			return str;
		}
		return "";
	}
	
	public function GetTextDef(str:String, node, def:String) : String
	{
		var rstr:String = GetText(str, node);
		if (rstr == "") return def == undefined ? str : coreGame.UpdateMacros(def);
		return rstr;
	}
	
	
	private function RepositionQuestions()
	{
		if (coreGame.AskQuestions._visible) coreGame.PositionQuestions();
		if (coreGame.YesEvent._visible) coreGame.PositionYesNo();
	}
	
	public function SetLangText(tag:String, node, sNode:XMLNode)
	{
		SetText(XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode));
		RepositionQuestions();
	}

	
	public function SetLangGeneralText(tag:String, node, sNode:XMLNode)
	{
		SetGeneralText(XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode));
		RepositionQuestions();
	}
	
	public function AddLangText(tag:String, node, sNode:XMLNode)
	{
		AddText(XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode));
		RepositionQuestions();
	}
	
	public function AddLangGeneralText(tag:String, node, sNode:XMLNode)
	{
		AddGeneralText(XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode));
		RepositionQuestions();
	}
	
	public function ServantSpeakLang(tag:String, node, sNode:XMLNode)
	{
		coreGame.ServantSpeak(XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode == undefined ? assNode : sNode));
		RepositionQuestions();
	}
	
	public function SlaveSpeakLang(tag:String, node, sNode:XMLNode)
	{
		coreGame.SlaveSpeak(XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode));
		RepositionQuestions();
	}
	
	public function PersonSpeakLang(person:Object, tag:String, node, sNode:XMLNode)
	{
		PersonSpeak(person, XMLData.GetXMLMultiLineStringParsed(tag, node, "", sNode));
		RepositionQuestions();
	}	
	
	// Text
	
	private function LegacyCopy() { coreGame.GeneralText = GeneralText + ""; coreGame.LargerText = LargerText + ""; }
		
	public function strTrim(s:String) : String
	{
		s = s.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join("");
		if (s == undefined || s == "" || s == " ") return "";
		while (s.substr(-1, 1) == " ") s = s.substr(0, s.length-1);
		if (s == "" || s == " ") return "";
		while (true) {
			if (s.charAt(0) != " ") break;
			s = s.substr(1);
		}
		return s;
	}
	
	public function StripLines(s:String) : String
	{
		// inlined strTrim
		if (s == undefined || s == "" || s == " ") return "";
		while (s.substr(-1, 1) == " ") s = s.substr(0, s.length-1);
		if (s == "" || s == " ") return "";
		while (true) {
			if (s.charAt(0) != " ") break;
			s = s.substr(1);
		}
		var sl:Array = s.split("\r");
		return sl[0].split("\n")[0];
	}
	
	private function AddWords(str:String)
	{
		if (LargerTextField._visible) LargerText += str;
		else {
			var sl:Array = str.split(" ");
			var slen:Number = sl.length - 1;
			var ot:String;
			var tw:String;
			for (var i2:Number = 0; i2 <= slen; i2++) {
				tw = sl[i2];
				if (LargerTextField._visible) {
					LargerText += tw;
					if (i2 != slen) LargerText += " ";
				} else {
					ot = GeneralText;
					GeneralText += tw;
					// Note: this is not generic, supports only <ps> style
					var bFntNow:Boolean = false;
					if (tw.indexOf("<ps>") != -1) {
						FontText = "<ps>";
						bFntNow = true;
					} else if (tw.indexOf("</ps>") != -1) FontText = "";
					if (i2 != slen) GeneralText += " ";
					GeneralTextField.htmlText = GeneralText;
					if (GeneralTextField._height <= 242) continue;
					
					// at end of the general text field, overflowed into larger
					GeneralText = ot;
					GeneralTextField.htmlText = GeneralText;
					ShowLargerText();
					if (!bFntNow) LargerText = FontText;
					if (tw != "") {
						if (tw.charAt(0) == " ") LargerText += tw.slice(1, sl[i2].length); 
						else LargerText += tw;
						if (i2 != slen) LargerText += " ";
					}
				}
			}
		}
	}
	
	public function AddText(str:String)
	{
		if (XMLData.IsHandlingEvent()) {
			XMLData.EventText += coreGame.UpdateMacros(str);
			return;
		} else if (coreGame.GirlsStoryTop._visible) {
			AddIntroText(str);
			return;
		}
		
		if (LargerTextField._visible) LargerText += coreGame.UpdateMacros(str);
		else {
			var sl:Array = coreGame.UpdateMacros(str).split("\r");
			var slen:Number = sl.length - 1;
			for (var il:Number = 0; il <= slen; il++) {
				if (LargerTextField._visible) {
					if (LargerText == "" && sl[il] == "") continue;
					LargerText += sl[il];
					if (il < slen) LargerText += "\n";
				} else {
					AddWords(sl[il]);
					if (il == slen) break;
					if (LargerTextField._visible) {
						if (LargerText == "" && sl[il] == "") continue;
						LargerText += "\n";
					} else {
						GeneralText += "\n";
						GeneralTextField.htmlText = GeneralText;
					}
				}
			}
		}
		if (LargerTextField._visible) {
			LargerTextField.content.LargerTextField.htmlText = LargerText;

			/*
			if (LargerTextField.width == 450 && LargerTextField.content.LargerTextField._height > 525) {
				LargerTextField.setSize(440, 525);
				LargerTextField.content.LargerTextField._width = 420;
			}
			*/
			LargerTextField.invalidate();
		}
		LegacyCopy();
	}
	
	public function RemoveText(nchar:Number)
	{
		if (LargerTextField._visible) {
			if (nchar < 0) LargerText = LargerText.substr(0, LargerText.length + nchar);
			else LargerText = LargerText.substr(nchar);
			LargerTextField.content.LargerTextField.htmlText = LargerText;
			if (LargerTextField.width == 310 && LargerTextField.content.LargerTextField._height > 525) {
				LargerTextField.setSize(295, 525);
				LargerTextField.content.LargerTextField._width = 266;
			}
			LargerTextField.invalidate();
		} else {
			if (nchar < 0) GeneralText = GeneralText.substr(0, GeneralText.length + nchar);
			else GeneralText = GeneralText.substr(nchar);
			GeneralTextField.htmlText = GeneralText;
		}
		LegacyCopy();
	}
		
	
	public function AddTextToStart(pstring:String)
	{
		if (XMLData.IsHandlingEvent()) XMLData.EventText = pstring + XMLData.EventText;
		else SetText(pstring + GeneralText + LargerText);
	}
		
	public function SetText(str:String)
	{
		FontText = "";
		if (XMLData.IsHandlingEvent()) { 
			XMLData.EventText = str;
			return;
		} 
		if (coreGame.GirlsStoryTop._visible) {
			SetIntroText(str);
			return;
		}
		if (!coreGame.NextEnding._visible) HideLargerText();
		GeneralText = "";
		GeneralTextField.htmlText = "";
		GeneralTextField._visible = true;
		if (str != "") AddText(str);
		else LegacyCopy();
	}
	
	public function SetGeneralText(str:String)
	{
		GeneralText = coreGame.UpdateMacros(str);
		GeneralTextField.htmlText = GeneralText;
		LegacyCopy();
	}
	
	public function AddGeneralText(str:String)
	{
		GeneralText += coreGame.UpdateMacros(str);
		GeneralTextField.htmlText = GeneralText;
		LegacyCopy();
	}
	
	public function SetLargerText(str:String)
	{
		if (str != undefined) {
			LargerText = coreGame.UpdateMacros(str);
			LegacyCopy();
		}
		LargerTextField.content.LargerTextField.htmlText = LargerText;
		LargerTextField.invalidate();
	}
	
	public function ShowGeneralText(large:Boolean)
	{
		GeneralText = "";
		if (large == true) {
			GeneralTextField._x = 7;
			GeneralTextField._width = 600;
		} else {
			GeneralTextField._x = 182.5;
			GeneralTextField._width = 425.4;
		}
		GeneralTextField._visible = true;
		LegacyCopy();
	}
	public function HideGeneralText()
	{
		GeneralText = "";
		GeneralTextField._x = 182.5;
		GeneralTextField._width = 425.4;
		GeneralTextField._visible = false;
		LegacyCopy();
	}
	
	public function ShowLargerText(large:Boolean)
	{
		LargerText = "";
		
		if (large == true) {
			LargerTextField.move(610, 3);
			LargerTextField.setSize(450, 590);
			LargerTextField.content.LargerTextField._width = 430;
		} else {
			LargerTextField.move(670, 57);
			LargerTextField.setSize(390, 460);
			LargerTextField.content.LargerTextField._width = 370;
		}
		if (coreGame.dspMain.IsGameTabShown(5)) coreGame.dspMain.SelectGameTab(5);
		else coreGame.dspMain.HideGameTabs();
		SetLargerText();
		LargerTextField._visible = true;		
		LegacyCopy();
	}
	
	
	public function HideLargerText()
	{
		LargerText = "";
		LargerTextField.content.LargerTextField.htmlText = "";
		if (LargerTextField._visible && coreGame.dspMain.IsShown()) {
			coreGame.Hints.StopHints();
			if (!coreGame.ParticipantsChanger._visible) coreGame.dspMain.ShowStatisticsTab(1);
		}
		LargerTextField._visible = false;
		LegacyCopy();
	}
	
	public function SaveText() : String
	{
		// TODO use local GeneralText/LargerText
		if (XMLData.IsHandlingEvent()) strSavetxt = XMLData.EventText + "";
		else {
			strSavetxt = GeneralText;
			if (LargerText != "") strSavetxt += "\r" + LargerText;
		}
		return strSavetxt;
	}
	
	public function IsTextChanged() : Boolean 
	{ 
		var strNow;
		if (XMLData.IsHandlingEvent()) strNow = XMLData.EventText + "";
		else {
			strNow = GeneralText;
			if (LargerText != "") strNow += "\r" + LargerText;
		}
		return strSavetxt == strNow;
	}
	
	public function RestoreText(bAdd:Boolean) {	
		if (bAdd == true) AddText(strSavetxt);
		else SetText(strSavetxt);
	}


	// Speech
	
	public function PersonSpeakStart(person:Object, say:String, newl:Boolean)
	{
		var pstring:String = String(person);
		if (!isNaN(pstring)) pstring = coreGame.People.GetPersonsName(Number(person)); 
		if (newl != true) SetText("");
		bSpeaking = true;
		if (!XMLData.IsHandlingEvent()) {
			if (!LargerTextField._visible && GeneralTextField._height > 230) ShowLargerText();
		}
		AddText("<b>"+pstring + ":</b>\r<ps>\"" + say);
	}
	
	public function PersonSpeakEnd(say:String)
	{
		if (bSpeaking) {
			if (say != undefined) AddText(say + "\"</ps>");
			else AddText("\"</ps>");
			bSpeaking = false;
		}
	}
	
	public function PersonSpeak(person:Object, say:String, newl:Boolean)
	{
		var pstring:String = String(person);
		if (typeof(person) == "number") pstring = coreGame.People.GetPersonsName(Number(person));
		else if (Number(pstring) != NaN && Number(pstring) > 0) pstring = coreGame.People.GetPersonsName(Number(pstring)); 
	
		if (newl != true) SetText("");
		bSpeaking = true;
		if (!XMLData.IsHandlingEvent()) {
			if (!LargerTextField._visible && GeneralTextField._height > 230) ShowLargerText();
		}
		AddText("<b>"+pstring + ":</b>\r<ps>\"" + say + "\"</ps>");
	}
	
	public function ServantSpeak(say:String, newl:Boolean)
	{
		if (coreGame.ServantName == "") {
			if (newl != true) SetText(say + "\r");
			else AddText(say + "\r");
		} else coreGame.AssistantData.SlaveSpeak(say, newl);
	}
	
	public function ServantSpeakStart(say:String, newl:Boolean)
	{
		if (coreGame.ServantName == "") {
			if (newl != true) SetText(say);
			else AddText(say);
			bSpeaking = true;
		} else coreGame.AssistantData.SlaveSpeakStart(say, newl);
	}
	
	public function Servant1SpeakStart(say:String, newl:Boolean)
	{
		if (coreGame.ServantName == "") {
			if (newl != true) SetText(say);
			else AddText(say);
			bSpeaking = true;
		} else coreGame.AssistantData.Slave1SpeakStart(say, newl);
	}
	
	public function Servant2SpeakStart(say:String, newl:Boolean)
	{
		if (coreGame.ServantName == "") {
			if (newl != true) SetText(say);
			else AddText(say);
			bSpeaking = true;
		} else coreGame.AssistantData.Slave2SpeakStart(say, newl);
	}
	
	public function Servant1Speak(say:String, newl:Boolean)
	{
		if (coreGame.ServantName == "") {
			if (newl != true) SetText(say);
			else AddText(say);
			bSpeaking = true;
		} else coreGame.AssistantData.Slave1Speak(say, newl);
	}
	
	public function Servant2Speak(say:String, newl:Boolean)
	{
		if (coreGame.ServantName == "") {
			if (newl != true) SetText(say);
			else AddText(say);
			bSpeaking = true;
		} else coreGame.AssistantData.Slave2Speak(say, newl);
	}
	
	public function ServantSpeakEnd(say:String)
	{
		if (coreGame.ServantName == "") {
			if (bSpeaking) AddText("\r");
			bSpeaking = false;
		} else coreGame.AssistantData.SlaveSpeakEnd(say);
	}
	
	public function Plural(str:String, gender:Number) : String
	{
		if (gender == undefined) gender = coreGame.SlaveGender;
		var str2:String = str.charAt(0);
		if (str2 != " ") str2 = "";
		else str = str.substring(1);
		if (gender > 3) {
			if (str.substr(0, 2) == "a ") str = str2 + str.substr(2);
			else if (str.substr(0, 3) == "an ") str = str.substr(3);
			if (str == "it") return str2 + "them";
			if (str == "gives") return str2 + "give";
			if (str == "does") return str2 + "do";
			if (str == "was") return str2 + "were";
			if (str == "am") return str2 + "are";
			if (str == "is") return str2 + "are";
			if (str == "enjoy") return str2 + "enjoys";
			if (str == "ask") return str2 + "asks";
			if (str == "play") return str2 + "plays";
			if (str == "boy") return str2 + "boys";
			if (str == "say") return str2 + "says";
			if (str.substr(-1) == "y") return str2 + str.substr(0, str.length-1) + "ies";
			if (str.substr(-1) == "s") return str2 + str + "es";
			if (str.substr(-1) == "x") return str2 + str + "es";
			if (str == "woman") return str2 + "women";
			if (str == "man") return str2 + "men";
			if (str == "person") return str2 + "people";
			if (str == "blush") return str2 + "blushes";
			if (str == "sheath") return str2 + "sheathes";
			if (str == "watch") return str2 + "watches";
			return str2 + str + "s";
		} else return str2 + str;
	}
	
	public function NonPlural(str:String, gender:Number) : String
	{
		if (gender == undefined) gender = coreGame.SlaveGender;
		var str2:String = str.charAt(0);
		if (str2 != " ") str2 = "";
		else str = str.substring(1);
		if (gender < 4) {
			if (str.substr(0, 2) == "a ") str = str2 + str.substr(2);
			else if (str.substr(0, 3) == "an ") str = str.substr(3);
			if (str == "gives") return str2 + str;
			if (str == "does") return str2 + "does";
			if (str == "was") return str2 + "were";
			if (str == "it") return str2 + "them";
			if (str == "is") return str2 + "are";
			if (str == "am") return str2 + "are";
			if (str == "say") return str2 + "says";
			if (str == "boy") return str2 + "boys";
			if (str == "play") return str2 + "plays";
			if (str == "enjoy") return str2 + "enjoys"
			if (str == "ask") return str2 + "asks";
			if (str == "chats") return str2 + "chats";
			if (str.substr(-1) == "y") return str2 + str.substr(0, str.length-1) + "ies";
			if (str.substr(-1) == "s") return str2 + str + "es";
			if (str.substr(-1) == "x") return str2 + str + "es";
			if (str == "woman") return str2 + "women";
			if (str == "man") return str2 + "men";
			if (str == "person") return str2 + "people";
			if (str == "blush") return str2 + "blushes";
			if (str == "sheath") return str2 + "sheathes";
			if (str == "watch") return str2 + "watches";
			return str2 + str + "s";
		} else {
			if (str == "chats") return str2 + "chat";
			if (str == "gives") return str2 + "give";
			if (str == "does") return str2 + "do";
			return str2 + str;
		}
	}

	public function SlaveVerb(str:String) : String { return coreGame.SlaveName + " " + NonPlural(str); }
	public function Slave1Verb(str:String) : String { return coreGame.SlaveName1 + " " + NonPlural(str); }
	public function Slave2Verb(str:String) : String	{ return coreGame.SlaveName2 + " " + NonPlural(str); }
	public function SlaveHeSheVerb(str:String) : String { return coreGame.SlaveHeShe + " " + NonPlural(str); }
	public function SlaveHeSheUCVerb(str:String) : String { return coreGame.SlaveHeSheUC + " " + NonPlural(str); }
	public function SlaveHisHerVerb(str:String) : String { return coreGame.SlaveHisHer + " " + NonPlural(str); }
	
	
	// Gender Text
	
	public function GetGenderString(gnd:Number) : String
	{
		switch(gnd) {
			case 0:
				return GetHtml("NoGender", gndNode);
			case 1:
				return GetHtml("Male", gndNode);
			case 4:
				return GetHtml("MaleTwins", gndNode);
			case 2:
				return GetHtml("Female", gndNode);
			case 5:
				return GetHtml("FemaleTwins", gndNode);
			case 3:
				return "an " + GetHtml("Dickgirl", gndNode);
			case 6:
				return GetHtml("DickgirlTwins", gndNode);
			case 7:
				return GetHtml("MixedTwins", gndNode);
		}
		return "";
	}
	
	// OBSOLETE
	public function SlaveText() : String { return coreGame.SlaveGender > 3 ? " slaves" : " slave"; }
	public function CockText() : String { return coreGame.SlaveGender > 3 ? " cocks" : " cock"; }
	public function PussyText() : String { return coreGame.SlaveGender > 3 ? " pussies" : " pussy"; }
	public function CockPussyText() : String { return coreGame.HasCock ? CockText() : PussyText(); }
	public function OrgasmText() : String { return coreGame.HasCock ? Plural(" climax") : Plural(" orgasm"); }
	public function OrgasmTextNP() : String { return coreGame.HasCock ? NonPlural(" climax") : NonPlural(" orgasm"); }

	
	// Introduction Text
	
	public function SetIntroText(intro:String, blk:Boolean, wht:Boolean)
	{	
		coreGame.GirlsStoryTop.BlackText.htmlText = "";
		coreGame.GirlsStoryTop.WhiteText.htmlText = "";
		AddIntroText(intro, blk, wht);
	}
	
	public function AddIntroText(intro:String, blk:Boolean, wht:Boolean)
	{
		var rcol:Number = coreGame.GirlsStory.transform.colorTransform.redOffset;
		var gcol:Number = coreGame.GirlsStory.transform.colorTransform.greenOffset;
		var bcol:Number = coreGame.GirlsStory.transform.colorTransform.blueOffset;
		if (blk == undefined && wht == undefined) {
			wht = true;
			blk = false;
			if (((rcol + gcol + bcol) / 3) > 200 && blk == undefined && wht == undefined) {
				wht = false;
				blk = true;
			}
		}
	
		if (blk != undefined) coreGame.GirlsStoryTop.BlackText._visible = blk;
		if (wht != undefined) coreGame.GirlsStoryTop.WhiteText._visible = wht;
		intro = coreGame.UpdateMacros(intro);
		
		coreGame.GirlsStoryTop.BlackText.htmlText += intro;
		coreGame.GirlsStoryTop.WhiteText.htmlText += intro;
	}
	
	public function ApplyTheme(cvo:ColourScheme)
	{
		// Text Colour
		trace("general text colour = " + cvo.nMainBackground);
		GeneralTextField.textColor = cvo.nTextColourGL;
		LargerTextField.setStyle("scrollTrackColor", cvo.nGeneralTextBackground);
		LargerTextField.content.LargerTextField.textColor = cvo.nTextColourGL;
	}


	// Reference functions
	private function SMTRACE(s:Object) { coreGame.SMTRACE(s); }
}