 import Scripts.Classes.*;

// Event functions

function SetEvent(enum:Object)
{
	trace("SetEvent: " + enum);
	ResetEventPicked();
	ObjEvent = enum;
	if (isNaN(enum)) {
		if (typeof(enum) == "string") {
			StrEvent = String(enum) + "";
			var earr:Array = StrEvent.split("-");
			if (earr[2] != undefined && earr[2] != "" && !isNaN(earr[2])) NumEvent = Number(earr[2]);
			else if (earr[1] != undefined && earr[1] != "" && !isNaN(earr[1])) NumEvent = Number(earr[1]);
			else if (StrEvent == "TentacleSex") NumEvent = -1;
			else if (StrEvent == "VisitAstrid") NumEvent = -2;
		}
	} else NumEvent = Number(enum);
}

function IsEventAllowable() : Boolean
{
	//trace("IsEventAllowable: " + AskQuestions._visible + " " + VisitMenu._visible + " " + YesEvent._visible + " " + NextEvent._visible + " " + NextEnding._visible + " " + bAllowEvents);
	return (AskQuestions._visible == false && VisitMenu._visible == false && YesEvent._visible == false && NextEvent._visible == false && NextEnding._visible == false && bAllowEvents);
}

function DoEvent(enum:Object, tgt:Object)
{
	trace("DoEvent: enum:" + enum);
	dspMain.HideMainButtons();
	dspMain.PushGameTabs();
	dspMain.HideGameTab(0);
	dspMain.HideGameTab(6);
	//dspMain.HideGameSubTabs();
	NextEnding._visible = false;
	Quitter._visible = false;
	HideYesNoButtons();
	HideQuestions();
	if (enum != undefined) {
		SetEvent(enum);
		if (tgt != undefined && typeof(tgt) != "boolean") ObjEvent = tgt;
		if (NumEvent == 9999 && Plannings.IsStarted()) {
			NextEvent._visible = false;
			ShowPlanningNext();
			DoneEvent = 1;
			return;
		}
	}
	DoneEvent = 1;
	HidePlanningNext();
	NextEvent._visible = true;

	if (NumEvent == 9703 || NumEvent == 9702 || NumEvent == 9701 || NumEvent == 9700 || NumEvent == 9705) {
		StablesMenu._visible = false;
		SalonMenu._visible = false;
		ShopMenu._visible = false;
		DealerMenu._visible = false;
		ArmouryMenu._visible = false;
	}
	Language.BlankLine(false);
	trace("DoEvent: strevent: " + StrEvent + " numevent:" + NumEvent);
}

function HideEventNext() { NextEvent._visible = false; }

function IsEventPicked() : Boolean { return (NumEvent != 0 || StrEvent != "" || ObjEvent != null); }
function IsEventHappening() : Boolean { return DoneEvent != 0; }

function ResetEventPicked() { 
	NumEvent = 0;
	StrEvent = "";
	ObjEvent = null;
}

// Questions
AskQuestions.tabChildren = true;
AskQuestions.CaptionText.wordWrap = true;
AskQuestions.CaptionText.autoSize = true;


function ResetQuestions(Caption:String)
{
	ResetEventPicked();
	AskQuestions.CaptionText.text = "";
	if (Caption != undefined) AskQuestions.CaptionText.htmlText = UpdateMacros(Caption) + "<br>";
	AskQuestions._visible = false;
	ClearGeneralArray();
}

function AddQuestion(evno:Object, EventLabel:String, evtarget:Object, param:Object)
{
	if ((typeof(evno) == "number" && !isNaN(evno) && Number(evno) == 0) || (typeof(evno) == "string" && String(evno) == "") || EventLabel == "" || evno == undefined) return;
	
	var depth:Number = AskQuestions.getNextHighestDepth();
	var image:MovieClip = AskQuestions.attachMovie("Single Question", "Question" + depth, depth);
	image.tabChildren = true;
	var line:Number = arGeneralArray.push(image);
	image.EvChoice = evno;
	image.evtarget = evtarget;
	image.param = param;
	image.QuestionText.wordWrap = true;
	image.QuestionText.autoSize = true;
	if (line < 10) image.QuestionText.htmlText = "<font color='#0000FF'>" + String.fromCharCode(line + 48) + "</font>. " + UpdateMacros(EventLabel);
	else image.QuestionText.htmlText = "<font color='#0000FF'>" + String.fromCharCode(line + 55) + "</font>. " + UpdateMacros(EventLabel);
	image._x = 18;
	image.QuestionBtn.onPress = function() {
		AskQuestionNow(this._parent);
	}
}

function ShowQuestions(Caption:String, main:Boolean) : Number
{
	var lines:Number = arGeneralArray.length;
	if (lines == 0) return 0;
	if (Caption != undefined) AskQuestions.CaptionText.htmlText = UpdateMacros(Caption) + "<br>";
	HidePlanningNext();
	DoneEvent = 1;
	SetEvent(arGeneralArray[0].EvChoice);
	NextEvent._visible = false;
	Quitter._visible = false;
	PlanningButton._visible = false;
	MorningButton._visible = false;
	NextEnding._visible = false;
	HideYesNoButtons();
	AskQuestions._visible = true;
	PositionQuestions(lines, main);	
	if (Language.IsLargerTextShown()) {
		dspMain.HideGameTabsOnly();
		dspMain.SelectSingleGameTab(5);
	} else {
		dspMain.PushGameTabs();
		dspMain.HideGameTab(0);
		dspMain.HideGameTab(6);
	}
	return lines - 1;
}

function GetCountQuestions() : Number { return arGeneralArray.length; }

function AdjustQuestions(wid:Number, lines:Number) : Number
{
	AskQuestions.CaptionText._width = wid;
	var image:MovieClip;
	for (i = 0; i < lines; i++) {
		image = arGeneralArray[i];
		image.QuestionText._width = wid;
		image.QuestionBtn._width = wid;
		image.QuestionBtn._height = image.QuestionText._height;
		if (i > 0) image._y = arGeneralArray[i - 1]._y + arGeneralArray[i - 1]._height - 2;
		else {
			if (AskQuestions.CaptionText.text != "") {
				image._y = 5 + AskQuestions.CaptionText._height;
				if (image._y < 27) image._y = 27;
			} else image._y = 5;
		}
	}
	return lines > 0 ? arGeneralArray[lines - 1]._y + arGeneralArray[lines - 1]._height : 0;
}

function PositionQuestions(lines:Number, main:Boolean)
{
	if (!AskQuestions._visible) return;
	if (lines == undefined || lines == 0) lines = arGeneralArray.length;
	if (main != true) {
		if (LargerTextField._visible == true) AskQuestions._y = LargerTextField._y + 3 + LargerTextField.content.LargerTextField._height;
		else {
			AdjustQuestions(310, lines);
			AskQuestions._x = GeneralTextField._x;
			AskQuestions._y = GeneralTextField._y + 3 + GeneralTextField._height;
			if ((AskQuestions._y + AskQuestions._height) > 593) {
				ShowLargerText();
				AskQuestions._y = LargerTextField._y + 3;
			}															 
		}
		if (LargerTextField._visible == true) {
			AdjustQuestions(260, lines);
			AskQuestions._x = LargerTextField._x;
			if ((AskQuestions._y + AskQuestions._height) > (LargerTextField._y + LargerTextField._height)) main = true;
		}
	}
	if (main == true) {	
		var bgh:Number;
		if (GirlsStoryTop._visible) {
			AskQuestions.QuestionBG._width = 525;
			bgh = AdjustQuestions(500, lines);
			AskQuestions._x = 160;
			AskQuestions._y = 526 - bgh;
			GirlsStoryTop.BigButton._visible = false;
			GirlsStoryTop.GirlsStoryNext._visible = false;
		} else {
			AskQuestions.QuestionBG._width = 385;
			bgh = AdjustQuestions(360, lines);
			AskQuestions._x = 45;
			AskQuestions._y = 320 - bgh;
		}
		AskQuestions.QuestionBG._height = 20 + bgh;
		AskQuestions.QuestionBG._visible = true;
		mcMain.MainWindowButton._visible = false;
		return;
	}
	AskQuestions.QuestionBG._visible = false;
}

function AskHerQuestions(Event1:Object, Event2:Object, Event3:Object, Event4:Object, Event1Label:String, Event2Label:String, Event3Label:String, Event4Label:String, Caption:String, Event5:Object, Event5Label:String)
{
	ResetQuestions();
	AddQuestion(Event1, Event1Label);
	AddQuestion(Event2, Event2Label);
	AddQuestion(Event3, Event3Label);
	AddQuestion(Event4, Event4Label);
	AddQuestion(Event5, Event5Label);
	ShowQuestions(Caption);
}

function HideQuestions()
{
	if (AskQuestions._visible) {
		AskQuestions._visible = false;
		ClearGeneralArray();
	}
}


function ShowQuestionsModule(mod:SlaveModule, modulename:String)
{
	ShowQuestions();
}


function AskHerQuestionsShortcuts(key:Number) {
	var lines:Number = arGeneralArray.length;
	if (key > 48 && key < 59) {
		var btn:Number = key - 48;
		if (lines >= btn) AskQuestionNow(arGeneralArray[btn - 1]);
	} else if (key > 64 && key < 91 && lines > 9) {
		var btn:Number = key - 55;
		if (lines >= btn) AskQuestionNow(arGeneralArray[btn - 1]);
	} 
};

function AskQuestionNow(mc:MovieClip)
{
	var evt = mc.EvChoice;
	var tgt:Object = mc.evtarget;
	var param:Object = mc.param;
	genNumber = Number(param);
	genString = String(param);
	SetText("");
	HideQuestions();
	if (tgt != undefined) tgt[evt](param);
	else DoEventNext(evt);
}

// hide
function HideButtons(main:Boolean)
{
	if (main == true) dspMain.HideMainButtons();

	NextEnding._visible = false;
	Quitter._visible = false;
	HideYesNoButtons();
	HideQuestions();
	NextEvent._visible = false;
	NextGeneral._visible = false;
}


// Rape

function ShowRaped()
{
	if (SlaveGirl.ShowRaped() == false) Generic.ShowRaped();
}