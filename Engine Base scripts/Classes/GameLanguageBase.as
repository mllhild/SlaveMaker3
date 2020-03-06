// Base Language XML Strings
// and general text functions
//
// Base class to minimise dependencies for building slaves etc, and so class GameLamnguage does not need to be distributed
//
// Translation status: COMPLETE
import Scripts.Classes.*;
import mx.containers.*;

class GameLanguageBase {
	
	// public
	public var XMLData:Object;		// type Object to prevent cyclic reference error
	public var LangType:String;
	public var xNode:XML;
	
	public var styles:TextField.StyleSheet;
	
	// cached xml nodes
	public var flNode:XMLNode;
	public var assNode:XMLNode;
	public var actNode:XMLNode;
	public var hintNode:XMLNode;
	public var statNode:XMLNode;
	public var walkNode:XMLNode;
	public var gndNode:XMLNode;
	public var skNode:XMLNode;
	public var btnNode:XMLNode;
	
	// cached common strings
	public var strCM:String;		// "cm"
	public var strKG:String;		// "kg"
	public var strIN:String;		// "in"
	public var strPD:String;		// "lb"
	public var strSLS:String;
	public var strHuman:String;		// "Human"
	public var GP:String;			// "GP"
	
	public var strDefPronoun:String;	// "I"
	public var strPronounTwins:String	// "We"
	
	public var strReview:String;
	public var strRemove:String;
	
	public var PersonalSupervisionString:String;
	public var AssistantSupervisionString:String;
	
	// cached act labels
	public var BreakLabel:String;
	public var RideLabel:String;
	public var CatNapLabel:String;
	public var CatalogingLabel:String;
	public var CatHouseLabel:String;
	public var PreeningLabel:String;
	public var PresentLabel:String;
	public var MakeUpLabel:String;
	public var LibraryLabel:String;
	public var BrothelLabel:String;
	public var ExposeLabel:String;
	public var DanceLabel:String;
	public var GroomingLabel:String;
	public var PrancingLabel:String;
	public var FitnessLabel:String;
	
	// Text variables
	public var GeneralText:String;		// mostly private, do not manually change
	public var LargerText:String;		// mostly private, do not manually change
	
	public var spListener:Object;		// text scroll lostener
	
	public var LargerTextField:Object;		// reference

	
	// Functions
	// These are dummy implementations, actual code is in GameLanguage class
	
	// are the xml files loaded
	public function IsLoaded() : Boolean { return false; }

	// change/reset language
	public function ChangeLanguage(assonly:Boolean, fncstr:String, obj:Object) { }
	public function PopulateLanguage() { }
	public function PopulateLanguageNode(aNode:XMLNode) { }
	
	// Get a general string at anytime
	public function GetHtml(str:String, node, bold:Boolean, spacing:Number, shortcut:String, strplus:String, italic:Boolean) : String { return ""; }
	public function GetHtmlDef(str:String, node, def:String, bold:Boolean, spacing:Number, shortcut:String, strplus:String, italic:Boolean) : String { return ""; }
	public function GetText(str:String, node) : String { return ""; }
	public function GetTextDef(str:String, node, def:String) : String { return ""; }
	
	// display text using xml data
	public function SetLangText(tag:String, node, sNode:XMLNode) { }
	public function SetLangGeneralText(tag:String, node, sNode:XMLNode) { }
	public function AddLangText(tag:String, node, sNode:XMLNode) { }
	public function AddLangGeneralText(tag:String, node, sNode:XMLNode) { }
	public function ServantSpeakLang(tag:String, node, sNode:XMLNode) { }
	
	// General Text (no xml)
	// NOTE: possibly these should be in a separate class for clarity but simpler to be here
	
	public function strTrim(s:String) : String { return ""; }
	public function StripLines(s:String) : String { return ""; }

	public function SetText(str:String) { }
	public function AddText(str:String) { }
	
	public function RemoveText(nchar:Number) { }
	public function AddTextToStart(pstring:String) { }
	public function AddTextToStartGeneral(str:String) {	SetGeneralText(str + GeneralText); }
	public function SetGeneralText(str:String) { }
	public function AddGeneralText(str:String) { }
	public function SetLargerText(str:String) { }
	public function ShowGeneralText(large:Boolean) { }
	public function HideGeneralText() { }
	public function ShowLargerText(large:Boolean) { }
	public function HideLargerText() { }
	public function SaveText() { }
	public function IsTextChanged() : Boolean { return false; }
	public function RestoreText(bAdd:Boolean) { }
	
	// Speech
	public var bSpeaking:Boolean;
	
	public function SlaveSpeakLang(tag:String, node, sNode:XMLNode) { }
	public function PersonSpeakLang(person:Object, tag:String, node, sNode:XMLNode) { }
	public function PersonSpeakStart(person:Object, say:String, newl:Boolean) { }
	public function PersonSpeakEnd(say:String) { }
	public function PersonSpeak(person:Object, say:String, newl:Boolean) { }

	public function ServantSpeak(say:String, newl:Boolean) { }
	public function ServantSpeakStart(say:String, newl:Boolean) { }
	public function Servant1SpeakStart(say:String, newl:Boolean) { }
	public function Servant2SpeakStart(say:String, newl:Boolean) { }
	public function Servant1Speak(say:String, newl:Boolean) { }
	public function Servant2Speak(say:String, newl:Boolean) { }
	public function ServantSpeakEnd(say:String) { }
	
	public function Plural(str:String, gender:Number) : String { return ""; }
	public function NonPlural(str:String, gender:Number) : String { return ""; }

	public function SlaveVerb(str:String) : String { return ""; }
	public function Slave1Verb(str:String) : String { return ""; }
	public function Slave2Verb(str:String) : String	{ return ""; }
	public function SlaveHeSheVerb(str:String) : String { return ""; }
	public function SlaveHeSheUCVerb(str:String) : String { return ""; }
	public function SlaveHisHerVerb(str:String) : String { return ""; }
	
	public function GetGenderString(gnd:Number) : String { return ""; }

	// OBSOLETE
	public function SlaveText() : String { return ""; }
	public function CockText() : String { return ""; }
	public function PussyText() : String { return ""; }
	public function CockPussyText() : String { return ""; }
	public function OrgasmText() : String { return ""; }
	public function OrgasmTextNP() : String { return ""; }

	
	// Introduction Text
	public function SetIntroText(intro:String, blk:Boolean, wht:Boolean) { }
	public function AddIntroText(intro:String, blk:Boolean, wht:Boolean) { }
	
	// Theme
	public function ApplyTheme(cvo:ColourScheme) { }
	public function ApplyLang(mc:TextField, str:String, bold:Boolean, spacing:Number, shortcut:String, italic:Boolean, strplus:String) { }

	

	// following simple functions implemented here
	public function BlankLine(bAlways:Boolean) {
		var s:String = GeneralText + LargerText;
		if (s == "") return;
		if (bAlways == false) {
			if (s.substr(-2, 2) != "\n\n") AddText("\n\n");
		} else AddText("\n\n");
	}
	public function CopyTF(txtto:TextField, txtfrm:TextField) { txtto.htmlText = txtfrm.htmlText; txtto.styleSheet = txtfrm.styleSheet;	}
	public function IsTextShown() : Boolean { return (GeneralText + LargerText) != ""; }
	public function IsLargerTextShown() : Boolean { return LargerText != ""; }

	public function NameCase(s:String) : String { return s.substr(0,1).toUpperCase() + s.substr(1); }
	public function strReplace(s:String, search:String, replace:String) : String { return s.split(search).join(replace); }
	public function strReplaceValue(s:String, num:Number) : String { return s.split("#value").join(num + ""); }
	public function strLineChanges(s:String) : String {
		if (s == "" || s == undefined) return "";
		return s.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join("");
	}	
	
	// XML references (to simplify using the functions in classes with no easy access to XMLData and so type checking is done)
	public function GetNodeC(baseNode, node:String) : XMLNode { return XMLData.GetNodeC(baseNode, node); }
	public function GetNode(base, node:String) : XMLNode { return XMLData.GetNode(base, node); }
	public function GetXMLBoolean(str:String, node, def:Boolean) : Boolean { return XMLData.GetXMLBoolean(str, node, def); }
	public function GetXMLBooleanParsed(str:String, node, def:Boolean) : Boolean { return XMLData.GetXMLBooleanParsed(str, node, def); }
	public function GetXMLString(str:String, node, def:String) : String { return XMLData.GetXMLString(str, node, def); }
	public function GetXMLStringSimple(str:String, node, def:String) : String { return XMLData.GetXMLStringSimple(str, node, def); }
	public function GetXMLValue(str:String, node, def:Number) : Number { return XMLData.GetXMLValue(str, node, def); }
	public function XMLGeneral(tag:String, sett:Boolean, basenode:XMLNode) : Boolean { return XMLData.XMLGeneral(tag, sett, basenode); }
	//public function GetExpression(s:String) : Number { return XMLData.GetExpression(s); }

}