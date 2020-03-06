// Game Configuration
// Translation status: COMPLETE

import Scripts.Classes.*;

class ColourScheme
{
	// variables
	private var coreGame:Object;
	
	// Colours
	public var nMainBackground:Number; 			// colour value for main background
	public var nIconBarIconColour:Number; 		// colour value for icons in the center of the screen
	public var nTabBackground:Number; 			// background colour of the tab panel
	public var nTabSelected:Number; 			// de-selected colour of the tab	
	public var nTabNotSelected:Number; 			// de-selected colour of the tab
	public var nSecondaryTabSelected:Number; 	// selected colour of the secondary tabs
	public var nSecondaryTabNotSelected:Number; // de-selected colour of the secondary tabs
	
	// Text
	public var nGeneralTextBackground:Number;	// background colour of the general text field
	public var nTextColourGL:Number;			// colour of text for general/larger text fields
	public var nTextColourTabSelected:Number;	// colour of text for select tab buttons
	public var nTextColourTabNotSelected:Number;// colour of text for de-selected tab buttons	
	public var nTextColourGold:Number;			// colour of text for Gold labels/value
	public var nTextColourDate:Number;			// colour of text for Date labels/value
	
	// Other
	public var nCalendarIcon:Number;			// colour for Calendar icon
	public var nActButtons:Number;				// colour for act buttons

	// Constructor
	public function ColourScheme(cg:Object)
	{ 
		coreGame = cg;

		nMainBackground = 0;
		nTabBackground = 0;
		nGeneralTextBackground = 0;
		nTextColourGL = 0;
		nTextColourTabSelected = 0;
		nTextColourTabNotSelected = 0;
		nTextColourGold = 0;
		nTextColourDate = 0;
		nCalendarIcon = 0;
		nTabSelected = 0;
		nTabNotSelected = 0;
		nSecondaryTabSelected = 0;
		nSecondaryTabNotSelected = 0;
		nActButtons = 0;
		nIconBarIconColour = 0;
	}
	
	public function SetColourValues(aNode:XMLNode)
	{
		var XMLData:Object = coreGame.XMLData;
		var bNode:XMLNode = aNode.firstChild;
		var iNode:XMLNode = XMLData.GetNode(bNode, "MainBackground");
		if (iNode != null) nMainBackground = GetColourValue(iNode);
		else nMainBackground = 0;

		iNode = XMLData.GetNode(bNode, "IconBarIcons");
		if (iNode != null) nIconBarIconColour = GetColourValue(iNode);
		else nIconBarIconColour = 0;
		
		iNode = XMLData.GetNode(bNode, "TabBackground");
		if (iNode != null) nTabBackground = GetColourValue(iNode);
		else nTabBackground = 0x8FE0D7;

		iNode = XMLData.GetNode(bNode, "TabSelected");
		if (iNode != null) nTabSelected = GetColourValue(iNode);
		else nTabSelected = 0x6FC0B7;
		
		iNode = XMLData.GetNode(bNode, "TabNotSelected");
		if (iNode != null) nTabNotSelected = GetColourValue(iNode);
		else nTabNotSelected = 0x6FC0B7;

		iNode = XMLData.GetNode(bNode, "GeneralTextBackground");
		if (iNode != null) nGeneralTextBackground = GetColourValue(iNode);
		else nGeneralTextBackground = 0x8FE0D7;
		
		iNode = XMLData.GetNode(bNode, "TextColourGL");
		if (iNode != null) nTextColourGL = GetColourValue(iNode);
		else nTextColourGL = 0;
		
		iNode = XMLData.GetNode(bNode, "TextColourTabSelected");
		if (iNode != null) nTextColourTabSelected = GetColourValue(iNode);
		else nTextColourTabSelected = 0;
		
		iNode = XMLData.GetNode(bNode, "TextColourTabNotSelected");
		if (iNode != null) nTextColourTabNotSelected = GetColourValue(iNode);
		else nTextColourTabNotSelected = 0;
		
		iNode = XMLData.GetNode(bNode, "TextColourGold");
		if (iNode != null) nTextColourGold = GetColourValue(iNode);
		else nTextColourGold = nTextColourTabSelected;
		
		iNode = XMLData.GetNode(bNode, "TextColourDate");
		if (iNode != null) nTextColourDate = GetColourValue(iNode);
		else nTextColourDate = nTextColourGL;
		
		iNode = XMLData.GetNode(bNode, "CalendarIcon");
		if (iNode != null) nCalendarIcon = GetColourValue(iNode);
		else nCalendarIcon = 0;	
		
		iNode = XMLData.GetNode(bNode, "SecondaryTabSelected");
		if (iNode != null) nSecondaryTabSelected = GetColourValue(iNode);
		else nSecondaryTabSelected = 0xffffff;	
		
		iNode = XMLData.GetNode(bNode, "SecondaryTabNotSelected");
		if (iNode != null) nSecondaryTabNotSelected = GetColourValue(iNode);
		else nSecondaryTabNotSelected = nTabNotSelected;
		
		iNode = XMLData.GetNode(bNode, "ActButtons");
		if (iNode != null) nActButtons = GetColourValue(iNode);
		else nActButtons = nTabBackground;	
	}
	
	static public function GetColourValue(gNode:XMLNode) : Number {
		var clr:Number = 0;
		if (gNode.attributes.red != undefined) {
			clr = (Number(gNode.attributes.red) << 16) + (Number(gNode.attributes.green) << 8) + Number(gNode.attributes.blue);
			if (gNode.attributes.alpha != undefined) clr += (Number(gNode.attributes.alpha) << 24);
		} else {
			var s:String = "";
			if (gNode.attributes.colour != undefined) s = gNode.attributes.colour;
			else if (gNode.attributes.color != undefined) s = gNode.attributes.color;
			if (s == "white") s = "0xFFFFFF";
			else if (s == "black") s = "0";
			else if (s == "red") s = "0xFF0000";
			else if (s == "green") s = "0x00FF00";
			else if (s == "blue") s = "0x0000FF";
			else if (s == "yellow") s = "0xFFE97F";
			else if (s == "gold") s = "0xFFB27F";
			if (s != "") return clr = Number(s);
		}
		if (gNode.attributes.percentage != undefined) {
			var s:String = gNode.attributes.percentage.substr(-1, 1) == "%" ? gNode.attributes.percentage.substr(0, gNode.attributes.percentage.length - 1) : gNode.attributes.percentage;
			var perc:Number = Number(s) / 100;
			if (perc < 1) clr += perc;
		}
		return clr;
	}
	
	public function UpdateTextColour(tf:TextField, clr:Number)
	{
		tf.textColor = int(clr);
	}
	
	function ApplyThemeBtn(mc:MovieClip, offset:Number, mul:Number, fb:Boolean)
	{
		if (!coreGame.config.bColoursOn) return;
		if (offset == undefined) offset = 0;
		if (mul == undefined) mul = 1;
		if (fb == undefined) fb = true;
		
		var cv:Number = nActButtons;
		var red:Number = (cv >> 16) & 255;
		var green:Number = (cv >> 8) & 255;
		var blue:Number = cv & 255;
		
		coreGame.SetMovieColour(mc, mul * (red + offset), mul * (green + offset), mul * (blue + offset), 0, 1, 1, 1, 1, fb);
	}
}