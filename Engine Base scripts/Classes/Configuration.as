// Game Configuration
// Translation status: COMPLETE

import Scripts.Classes.*;

class Configuration
{
	// variables
	
	// Theme
	public var strTheme;
	
	// Colours
	public var bColoursOn:Boolean;
	public var colourMale:ColourScheme;
	public var colourFemale:ColourScheme;
	public var colourDickgirl:ColourScheme;
	public var colourReset:ColourScheme;
	
	public var bZoomOn:Boolean;
	
	public var nDefaultFertility:Number;
	public var nBaseGestation:Number;
	public var nDefaultSexuality:Number;

	private var xConfigXML:XML;
	private var xConfigNode:XMLNode;
	
	private var nConfigNo:Number;
	private var coreGame:Object;
	private var xCurrXML:XML;
	
	public var coreImages:ActInfoList;
	
	public var nScreenXOffset:Number;
	public var nScreenYOffset:Number;
	
	public var mcBGLayout:MovieClip;
	
	public var nParallelLoading:Number;
	
	public var nDefaultWideScreenMode:Number;
	
	// Constructor
	public function Configuration(cg:Object) { 
		coreGame = cg;
		
		bColoursOn = true;
		colourMale = new ColourScheme(cg);
		colourFemale = new ColourScheme(cg);
		colourDickgirl = new ColourScheme(cg);
		colourReset = new ColourScheme(cg);
		
		bZoomOn = true;
		nDefaultFertility = 30;
		nDefaultSexuality = 100;
		nBaseGestation = 270;
		nConfigNo = 0;
		nScreenXOffset = Stage.width > 800 ? GetPublishedStageWidth() - 800 : 0;
		nScreenYOffset = Stage.width > 600 ? GetPublishedStageHeight() - 600 : 0;
		
		xConfigNode = null;
		xConfigXML = new XML();
		xCurrXML = new XML();
		
		mcBGLayout = null;
		
		nParallelLoading = 2;
		nDefaultWideScreenMode = -1;
		
		coreImages = new ActInfoList(new Slave(coreGame), "", coreGame);

		var ti:Configuration = this;
		xCurrXML.onLoad = function(success:Boolean) {
			//ti.coreGame.SMTRACE("loading configuration" + ti.nConfigNo + ".xml - result " + success);
			if (success) ti.coreGame.XMLData.MergeXML(ti.xConfigXML, ti.xCurrXML);
			ti.nConfigNo++;
			if (ti.nConfigNo > 30) ti.ConfigurationLoaded();
			else {
				if (ti.nConfigNo == 30) {
					//ti.xConfigNode = ti.xConfigXML.firstChild.firstChild;
					//ti.strTheme = ti.GetString("Theme");
					ti.strTheme = ti.coreGame.XMLData.GetXMLStringSimple("Theme", ti.xConfigXML.firstChild.firstChild, "Standard");
					ti.coreGame.SMTRACE("Theme: " + ti.strTheme);
					ti.xCurrXML.load("Themes/" + ti.strTheme + "/layout.xml");
				} else ti.xCurrXML.load("configuration" + ti.nConfigNo + ".xml");
			}
		}
		xCurrXML.load("configuration.xml");
	}

	private function ConfigurationLoaded() {
		//coreGame.SMTRACE("Configurations All Loaded: xml: " + xConfigXML);
		xConfigXML.onLoad = null;
		delete xCurrXML;
		delete nConfigNo;
		xConfigNode = xConfigXML.firstChild.firstChild;
		
		var XMLData:Object = coreGame.XMLData;
			
		// map zoom
		bZoomOn = XMLData.GetXMLBoolean("Zoom", xConfigNode, true);
		
		// colour values
		var aNode:XMLNode = coreGame.XMLData.GetNode(xConfigNode, "Colours");
		if (aNode != null) {
			bColoursOn = aNode.attributes.enable == "true";
			for (aNode = aNode.firstChild; aNode != null; aNode = aNode.nextSibling) {
				var str:String = aNode.nodeName.toLowerCase();
				if (str == "male") colourMale.SetColourValues(aNode);
				else if (str == "female") colourFemale.SetColourValues(aNode);
				else if (str == "dickgirl") colourDickgirl.SetColourValues(aNode);
			}
			aNode.removeNode();		// conserve a little memory
		}
		
		// default fertility value
		nDefaultFertility = XMLData.GetXMLValue("CommonDefaults/DefaultFertility", xConfigNode, nDefaultFertility);
		trace("nDefaultFertility = " + nDefaultFertility);
		// default sexuality value
		nDefaultSexuality = XMLData.GetXMLValue("SlaveDefaults/DefaultSexuality", xConfigNode, nDefaultSexuality);
		// default human gestation
		nBaseGestation = XMLData.GetXMLValue("CommonDefaults/BaseGestation", xConfigNode, nBaseGestation);
		if (nBaseGestation < 35) nBaseGestation = 35;
		
		// Parallel Loading
		nParallelLoading = XMLData.GetXMLValue("ParallelLoading", xConfigNode, nParallelLoading);

		// Default Widescreen layout
		nDefaultWideScreenMode = XMLData.GetXMLValue("WidescreenUsage", xConfigNode, nDefaultWideScreenMode);

		// load images
		coreImages.ActFolder = "Images";
		coreImages.LoadActImages(xConfigNode);
				
		// UI Images
		var str:String = XMLData.GetXMLStringSimple("BackgroundCenter", xConfigNode, "Main Background Layout");
		if (str.indexOf("/") > -1) mcBGLayout = coreGame.LoadImageAndShowMovie(undefined, "Themes/" + strTheme + "/" + str, 2.2, 0, coreGame.mcMain.MainBackground);
		else mcBGLayout = coreGame.AttachAndShowMovie(undefined, str, 2.1, 0, 1, coreGame.mcMain.MainBackground);
		
		// Main window
		coreGame.dspMain = new DisplayGameWindow(coreGame);
		
		// done, now load the language xml files
		coreGame.Language.ChangeLanguage();
		
		// now load slaves/assistants
		coreGame.SlaveList = new TrainableSlaves(coreGame);
	}
	
	public function GetCurrentStageWidth() : Number
	{
		var ssm:String = Stage.scaleMode;
		Stage.scaleMode = "noScale";
		var wid:Number = Stage.width;
		Stage.scaleMode = ssm;
		return wid;
	}
	public function GetPublishedStageWidth() : Number
	{
		var ssm:String = Stage.scaleMode;
		Stage.scaleMode = "showAll";
		var wid:Number = Stage.width;
		Stage.scaleMode = ssm;
		return wid;
	}
	public function GetCurrentStageHeight() : Number
	{
		var ssm:String = Stage.scaleMode;
		Stage.scaleMode = "noScale";
		var hei:Number = Stage.height;
		Stage.scaleMode = ssm;
		return hei;
	}
	public function GetPublishedStageHeight() : Number
	{
		var ssm:String = Stage.scaleMode;
		Stage.scaleMode = "showAll";
		var hei:Number = Stage.height;
		Stage.scaleMode = ssm;
		return hei;
	}
	public function GetScreenScale() : Number
	{
		var sh:Number = coreGame.config.GetPublishedStageHeight() / 600;
		//var sw:Number = coreGame.config.GetPublishedStageWidth() / 800;
		return sh; // < sw ? sh : sw;
	}
	
	public function ShowMonster(str:String, place:Number, align:Number, frame:Number, dg:Boolean)
	{
		var dge:Boolean = coreGame.IsDickgirlEvent() ? true : dg == true;
		coreImages.slaveData.SlaveGender = dge == true ? 3 : 2;
	
		var act:ActInfo = coreImages.GetActByName(str);
		if (act == null) act = coreImages.GetActByName(str + "s");
		coreImages.ShowActImage(act.Act, place, align, frame);
	}

	public function IsLoaded() : Boolean { return xConfigNode != null; }

	public function IsEnabled(str:String) : Boolean { return coreGame.XMLData.GetXMLBoolean(str, xConfigNode, false); }
	
	public function GetValue(str:String, def:Number) : Number { return coreGame.XMLData.GetXMLValue(str, xConfigNode, def == undefined ? 0 : def); }
	
	public function GetString(str:String) : String { return coreGame.XMLData.GetXMLString(str, xConfigNode); }
	
	public function GetNode(str:String) : XMLNode { return coreGame.XMLData.GetNode(xConfigNode, str); }
	public function GetNodeC(str:String) : XMLNode { return coreGame.XMLData.GetNodeC(xConfigNode, str); }
}