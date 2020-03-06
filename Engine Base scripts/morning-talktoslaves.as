// Translation status: COMPLETE
import Scripts.Classes.*;

var bDayStart:Boolean;

// Talk/Order Slaves

function DoTalkSlaves()
{
	bDayStart = IsDayTime();
	dspMain.HideGameTabs();
	dspMain.HideMainButtons();	
	HideDresses();
	SlaveDiscussion._visible = false;
	HideEquipmentButton();
	HideSMEquipmentButton();
	MorningEveningMenu._visible = false;
	Backgrounds.ShowBedRoom();

	Timers.AddTimerShowWait(
		setInterval(_root, "DoTalkSlaves2", 20, Timers.GetNextTimerIdx())
	);
	LoadedSlaves.ClearLoadedSlaves();
	Hints.HideHints();
}
	
function DoTalkSlaves2(timer:Number)
{
	Timers.RemoveTimer(timer);

	SetText("Who would you like to talk to?\r\r");
	SlaveDiscussion._visible = false;
	HideEquipmentButton();
	HideSMEquipmentButton();
	MorningEveningMenu._visible = false;
	dspMain.HideGameTabs();
	dspMain.HideMainButtons();
	
	HideDresses();
	Backgrounds.ShowBedRoom();
	SMAvatar.ShowSlaveMaker();
	Timers.ShowWait();
	
	function SlaveFilter(idx:Number) {
		if (idx == -100) return false;
		if (idx == -99) return !Plannings.IsStarted();
		return SlavesArray[idx].SlaveType != -10;
	}
	PickASlave(Language.GetHtml("WhichSlave", "Morning"), true, SlaveFilter, ShowSlaveTalk);
	ShowLeaveButton();
}

function ShowSlaveTalk()
{
	rfnc = DoTalkSlaves;
	
	HideAllPeople();
	Backgrounds.ShowBedRoom();
	ShowLeaveButton();
	PersonIndex = ParticipantsChanger.idx;
	SlavePicker.ReviewSlave(PersonIndex);
	SMAvatar.ShowSlaveMaker(0, 10);
	coreGame.dspMain.ShowGameTabs();
	coreGame.dspMain.HideGameTab(3);
	
	trace(sdata.SlaveName + " " + sdata.SlaveType);
	
	if (sdata.SlaveType != 0) {
		SlaveDiscussion.BtnTrain._visible = false; 
		SlaveDiscussion.BtnOrder._visible = !(sdata.SlaveType == -20 || sdata.SlaveType == -1 || sdata.SlaveType == 2 || IsAssistant(sdata.SlaveName));
		SlaveDiscussion.BtnAssistant._visible = (Day && !Plannings.IsStarted()) && !IsAssistant(sdata.SlaveName) && !(sdata.SlaveType == -20 || sdata.SlaveType == -1 || sdata.SlaveType == 2); 
		SetButtonDetails(SlaveDiscussion.BtnAssistant, false, dateLastChangedAssistant != GameDate);
	} else {
		SlaveDiscussion.BtnOrder._visible = true;
		SlaveDiscussion.BtnAssistant._visible = false;
		SlaveDiscussion.BtnTrain._visible = true; 
	}
	SlaveDiscussion.BtnMarry._visible = false; //sdata.IsInLove() && !sdata.IsMarried()
	SlaveDiscussion.BtnSexOther._visible = sdata.IntimacyOK;
	SlaveDiscussion.CustomMorning._visible = false;
	SlaveDiscussion._visible = true;
	SMData.TotalSMTalkSlaves++;
	
	Information.ShowSlaveStatus(sdata);
	
	var len:Number = slaveData.ActInfoBase.GetActCounts();
	var act:ActInfo;
	for (var i:Number = 0; i < len; i++) {
		act = coreGame.slaveData.ActInfoBase.GetActByIndex(i);
		if (act.Type != 10) continue;
		act.HideAct();
	}
	
	// Slave specific Custom Talk actions
	var cidx:Number = 0;
	var sNode:XMLNode = sdata.GetSlaveXML();
	for (var cNode:XMLNode = XMLData.GetNodeC(sNode, "Planning/DoPlanning"); cNode != null; cNode = cNode.nextSibling) {
		var str:String = cNode.nodeName.toLowerCase();
		if (str.substr(0, 15) == "slavecustomtalk" || str.substr(0, 10) == "customtalk") {
			var sdesc:String;
			var clabel:String;
			var bshow:Boolean = true;
			var cname:String;
			
			for (var attr:String in cNode.attributes) {
				switch(attr.toLowerCase()) {
					case "name": cname = cNode.attributes[attr]; break;
					case "desc":
					case "description":
					case "label": clabel = cNode.attributes[attr]; break;
					case "show": bshow = XMLData.ParseConditionalString(cNode.attributes[attr], true, false); break;
				}
			}
			if (cname != undefined) {
				cidx++;
				act = slaveData.ActInfoBase.SetActDetails(2800 - cidx, false, true, "", "", "", 0, 0.5);
				act.Type = 10;
				act.HideAct();
				act.SetActDetails(false, true, cname, clabel, "", 0, 0.5);
				act.strNodeName = cNode.nodeName;
				act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
				act.xNode = cNode;
				if (bshow == true) act.ShowAct();
			}
		}
	}
		
	planActs.Reset();
	planActs.AddAllActsByType(10, Language.GetHtml("Others", "SlaveMarket"));
	
	mc._visible = true;
	
	var len:Number = planActs.GetCount();
	if (len == 0) return;

	// process all 5 rows of buttons of the page
	var act:ActInfo = planActs.GetAct(0);
	cidx = 1;
	while (act != null && cidx < 8) {
		if (act.bShown && act.Name != "") cidx++;
		act.func = "SlaveTalkCustom";
		act.fobj = _root;
		act = act.childAct;
	}
	if (cidx == 1) return;
		
	// set acts
	act = planActs.GetAct(0);
	var mc:MovieClip = SlaveDiscussion.CustomMorning;
	
	mc.Button1._visible = false;
	mc.Button2._visible = false;
	mc.Button3._visible = false;
	mc.Button4._visible = false;
	mc.Button5._visible = false;
	mc.Button6._visible = false;
	mc.Button7._visible = false;
	mc.More0._visible = false;
	mc.More1._visible = false;
	mc.More2._visible = false;
	mc.More3._visible = false;
	mc.More4._visible = false;
	mc.More5._visible = false;
	
	cidx = 1;
	while (act != null && cidx < 8) {
		if (act.bShown && act.Name != "") {
			mc["Button" + cidx]._visible = true;
			if (act.PlanTitle != "") mc.Title.htmlText = "<b>" + act.PlanTitle + "</b>";
			else if (i == 1 && cidx == 1) mc.Title.htmlText = "<b>" + planActs.strLastTitle + "</b>";
			SetButtonDetails(mc["Button" + cidx], act.Ticked, act.Available, act.Name, act.Act, act.Shortcut, act.Cost, act.Duration, act.StartTime, act.EndTime, act.func, act.rofunc, act.routfunc, act.fobj);
			cidx++;
		}
		act = act.childAct;
	}
	if (cidx > 1) SlaveDiscussion.CustomMorning._visible = true;
}

function SlaveTalkCustom(actno:Number)
{
	if ((bDayStart != Day) || (!Plannings.IsStarted() && (!Day && GameTimeMins > 1380))) {	// 1600 and 2300
		Language.SetLangText("NotEnoughTime", "Planning");
		BlankLine();
		Bloop();
		return;
	}

	if (!XMLData.IsHandlingEvent()) {
		AppendActText = true;
		SetText("");
	}
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	HideStatChangeIcons();
	Lesbian = sdata.SlaveGender == 1 || sdata.SlaveGender == 4 ? SMData.Gender == 1 : SMData.Gender == 2;
	SlaveGirl.Lesbian = Lesbian;
	SMAvatar.ShowSlaveMaker();
	UseGeneric = false;
	HideImages();
	
	FirstTimeToday = !sdata.BitFlagC.CheckBitFlag(65);
	
	if (PersonIndex == -99) {
		CurrentAssistant.Lesbian = Lesbian;
		if (CurrentAssistant.ShowSlaveTalk() != true) {
			AssistantData.ShowActImage(1004);
			if (UseGeneric && CurrentAssistant.ShowChoreDiscuss != undefined) {
				UseGeneric = false;
				CurrentAssistant.ShowChoreDiscuss();
			} 
			if (UseGeneric) AssistantData.ShowMarketImage(1, 2);
		}
	} else {
		if (LoadedSlaves.IsLoadedSlave(sdata)) {
			var sm:SlaveModule = LoadedSlaves.GetLoadedSlave(sdata);
			sm.Lesbian = Lesbian;
			sm.Naked = false;
			UseGeneric = sm.ShowSlaveTalk() != true;
			if (UseGeneric) sdata.ShowActImage(1004);
			if (UseGeneric) sm.slaveData.ShowActImage(1004);
			if (UseGeneric && sm.ShowChoreDiscuss != undefined) {
				UseGeneric = false;
				sm.ShowChoreDiscuss();
			} else if (UseGeneric) {
				sdata.ShowMarketImage(1, 1);
				UseGeneric = false;
			}
		} else UseGeneric = true;
		if (UseGeneric) sdata.ShowActImage(1004);
		if (UseGeneric) sdata.ShowMarketImage(1, 1);
		sdata.bSupervisedToday = true;
	}
	
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(actno);
	if (act.xNode != null) act.DoAct();
	else XMLData.DoXMLActForSlave("CustomTalk", sdata);

	UpdateSlaveCommon(sdata);
	
	if (!IsEventAllowable()) return;
	
	DoEvent(9752);
}

function SlaveTalk()
{
	if ((bDayStart != Day) || (!Plannings.IsStarted() && (!Day && GameTimeMins > 1380))) {	// 1600 and 2300
		Language.SetLangText("NotEnoughTime", "Planning");
		BlankLine();
		Bloop();
		return;
	}

	if (!XMLData.IsHandlingEvent()) {
		AppendActText = true;
		SetText("");
	}
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	HideStatChangeIcons();
	Lesbian = sdata.SlaveGender == 1 || sdata.SlaveGender == 4 ? SMData.Gender == 1 : SMData.Gender == 2;
	SlaveGirl.Lesbian = Lesbian;
	SMAvatar.ShowSlaveMaker();
	UseGeneric = false;
	HideImages();
	
	FirstTimeToday = !sdata.BitFlagC.CheckBitFlag(64);
	
	if (modulesList.DoSlaveTalk(sdata, Action)) {
		UpdateSlaveCommon(sdata);
		BlankLine();
		if (IsEventAllowable()) DoEvent(9750);
		return;
	}
	
	if (PersonIndex == -99) {
		CurrentAssistant.Lesbian = Lesbian;
		if (CurrentAssistant.ShowSlaveTalk() != true) {
			AssistantData.ShowActImage(1004);
			if (UseGeneric && CurrentAssistant.ShowChoreDiscuss != undefined) {
				UseGeneric = false;
				CurrentAssistant.ShowChoreDiscuss();
			} 
			if (UseGeneric) AssistantData.ShowMarketImage(1, 2);
		}
	} else {
		trace("is loaded? " + sdata.ImageFolder);
		if (LoadedSlaves.IsLoadedSlave(sdata)) {
			trace("loaded!");
			var sm:SlaveModule = LoadedSlaves.GetLoadedSlave(sdata);
			sm.Lesbian = Lesbian;
			sm.Naked = false;
			UseGeneric = sm.ShowSlaveTalk() != true;
			if (UseGeneric) sdata.ShowActImage(1004);
			if (UseGeneric) sm.slaveData.ShowActImage(1004);
			if (UseGeneric && sm.ShowChoreDiscuss != undefined) {
				UseGeneric = false;
				sm.ShowChoreDiscuss();
			} else if (UseGeneric) {
				sdata.ShowMarketImage(1, 1);
				UseGeneric = false;
			}
		} else UseGeneric = true;
		if (UseGeneric) sdata.ShowActImage(1004);
		if (UseGeneric) sdata.ShowMarketImage(1, 1);
		sdata.bSupervisedToday = true;
	}
	
	var done:Boolean = false;
	var sNode:XMLNode = GetSlaveObjectXML(sdata);
	if (sNode != null) done = XMLData.XMLEventByNode(GetNode(sNode, "Planning/DoPlanning/SlaveTalk"));

	if (!done) XMLData.DoXMLActForSlave("SlaveTalk", sdata);  // default effect

	UpdateSlaveCommon(sdata);
	
	if (!IsEventAllowable()) return;
	
	DoEvent(9750);
}

function RollOverBtnDiscuss()
{
	Hints.ShowHint(Language.GetHtml("HintSlaveTalk", hintNode));
}

// Imtimacy, fuck/lesbian
function SlaveSexFuck()
{
	if (!Plannings.IsStarted() && ((Day && GameTimeMins >=1080) || (!Day && GameTimeMins > 1380))) {	// 1600 & 2300
		Language.SetLangText("NotEnoughTime", "Planning");
		BlankLine();
		Bloop();
		return;
	}
	
	if (!XMLData.IsHandlingEvent()) {
		AppendActText = true;
		SetText("");
	}
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	HideStatChangeIcons();
	Backgrounds.ShowBedRoom();
	
	if (sdata.SlaveGender == 1 || sdata.SlaveGender == 4) Lesbian = (SMData.Gender == 1);
	else Lesbian = (SMData.Gender == 2);

	SlaveGirl.Lesbian = Lesbian;
	
	HideImages();
	SMAvatar.ShowSlaveMaker();
	UseGeneric = false;
	
	Action = Lesbian ? 11 : 4;
	if (modulesList.DoSlaveIntimacy(sdata, Action)) {
		UpdateSlaveCommon(sdata);
		if (IsEventAllowable()) DoEvent(9750);
		return;
	}
	
	var sNode:XMLNode = GetSlaveObjectXML(sdata);
	var bDefault:Boolean = true;
	
	if (PersonIndex == -99) {
		CurrentAssistant.Lesbian = Lesbian;
		if (CurrentAssistant.ShowSlaveIntimacy() == true) bDefault = false;
		else {
			if (Lesbian) sdata.ShowActImage(11);
			if (UseGeneric || !Lesbian) sdata.ShowActImage(4);
			if (UseGeneric && CurrentAssistant.ShowSexActFuck != undefined) {
				UseGeneric = false;
				UseGeneric = CurrentAssistant.ShowSexActFuck() != true;
			}
			if (UseGeneric) UseGeneric = CurrentAssistant.ShowAsAssistantAnal() != true;
			bDefault = UseGeneric;
		}
	}
	if (bDefault) {
		HideImages();
		if (LoadedSlaves.IsLoadedSlave(sdata)) {
			var sm:SlaveModule = LoadedSlaves.GetLoadedSlave(sdata);
			sm.Lesbian = Lesbian;
			sm.Naked = true;
			UseGeneric = sm.ShowSlaveIntimacy() != true;
			if (UseGeneric && Lesbian) sdata.ShowActImage(11);
			if (UseGeneric) sdata.ShowActImage(4);
			if (UseGeneric && sm.ShowSexActFuck != undefined) {
				lastmc = null;
				UseGeneric = false;
				var ret:Boolean = sm.ShowSexActFuck();
				if (ret != undefined) UseGeneric = !ret;
				else if (lastmc == null) UseGeneric = true;
			}
			if (UseGeneric) UseGeneric = sm.ShowAsAssistantAnal() != true;
		} else UseGeneric = true;
		if (UseGeneric) sdata.ShowActImage(4);
		if (UseGeneric) sdata.ShowMarketImage(1, 1);
	}

	var done:Boolean = false;
	if (sNode != null) done = XMLData.XMLEventByNode(XMLData.GetNode(sNode, "Planning/DoPlanning/SlaveIntimacyFuck"));
	if (!done) {
		done = XMLData.XMLEventByNode(XMLData.GetNode(sNode, "Planning/DoPlanning/SlaveIntimacy"));
		if (!done) {
			done = XMLData.XMLEventByNode(XMLData.GetNode(sNode, "Planning/DoPlanning/SlaveSex"));		// obsolete version
			if (!done) {
				if (!XMLData.DoXMLAct("SlaveIntimacyFuck")) {		// default effect
					XMLData.DoXMLAct("SlaveSex");			// default effect, obsolete version
				}
			}
		}
	}
	// update sex skills
	var toact:Number = Lesbian ? 11 : 4;
	sdata.SetActTotal(toact, sdata.GetActTotal(toact) + 1);
	UpdateSexActLevels(toact, sdata);
	
	dspMain.UpdateSexSkills(sdata);
	UpdateSlaveCommon(sdata);

	if (!IsEventAllowable()) return;
	
	DoEvent(9750);
}


function RollOverBtnSex()
{
	Hints.ShowHint(Language.GetHtml("HintSlaveSex", hintNode));
}


// Imtimacy, select act
function SlaveSexOther()
{
	if (!Plannings.IsStarted() && ((Day && GameTimeMins >=1080) || (!Day && GameTimeMins > 1380))) {	// 1600 & 2300
		Language.SetLangText("NotEnoughTime", "Planning");
		BlankLine();
		Bloop();
		return;
	}
	
	if (!XMLData.IsHandlingEvent()) {
		AppendActText = true;
		SetText("");
	}
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	HideStatChangeIcons();
	Backgrounds.ShowBedRoom();
	
	if (sdata.SlaveGender == 1 || sdata.SlaveGender == 4) Lesbian = (SMData.Gender == 1);
	else Lesbian = (SMData.Gender == 2);
	SlaveGirl.Lesbian = Lesbian;
	CurrentAssistant.Lesbian = Lesbian;
	UseGeneric = false;

	UpdateSlaveGenderText(sdata);		// as "Fuck" node uses #slavehimher
	ResetQuestions();
	if (SlaveFemale == false && Lesbian) AddQuestion("SlaveSexFuck", Lesbian ? Language.GetHtml("LesbianMale", actNode) : Language.GetHtml("FuckYou", actNode), _root);
	else AddQuestion("SlaveSexFuck", Lesbian ? Language.GetHtml("Lesbian", actNode) : Language.GetHtml("Fuck", actNode), _root);
	ShowQuestions();
	XMLData.DoXMLActForSlave("IntimacyQuestions", sdata);
	UpdateSlaveGenderText();		// reset back to current slave
}

function RollOverBtnSexOther()
{
	Hints.ShowHint(Language.GetHtml("HintSlaveSex", hintNode));
}


// Be My Assistant

function SlaveAssistant()
{
	if (dateLastChangedAssistant == GameDate) {
		Language.SetLangText("OnlyOncePerDay", "Planning");
		BlankLine();
		Bloop();
		return;
	}
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	Language.SetLangText("ChangeAssistant", "Assistant");
	BlankLine();
	DoYesNoEvent(41);
}
	
function SlaveAssistantChange()
{
	Language.SetLangText("NewAssistant", "Assistant");
	BlankLine();
	
	ChangeAssistantByFilename(sdata.SlaveFilename, undefined);
	
	DoEvent(9750);
}

function RollOverBtnAssistant()
{
	Hints.ShowHint(Language.GetHtml("HintBeAssistant", hintNode));
}

function SlaveMarry()
{
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	XMLData.XMLGeneral("Other/MarryMe", false, GetSlaveObjectXML(sdata));
}

function SlaveMarried()
{
	sdata.BitFlag1.SetBitFlag(61);
	Backgrounds.ShowChapel();
	if (LoadedSlaves.IsLoadedSlave(sdata)) {
		var sm:SlaveModule = LoadedSlaves.GetLoadedSlave(sdata);
		sm.ShowEndingMarriage();
	}
	ChangeDate(1);
	DoEvent(9751);
	XMLData.XMLGeneral("Other/Marriage", false, GetSlaveObjectXML(sdata));
}

function RollOverBtnMarry()
{
	Hints.ShowHint(Language.GetHtml("HintMarryMe", hintNode));
}

function SlaveFullyTrain()
{
	SlaveDiscussion._visible = false;
	Hints.HideHints();
	genNumber = sdata.GetTotalImages();
	Language.SetLangText("FullyTrain", "Planning");
	BlankLine();
	DoYesNoEvent(43);
}

function SlaveFullyTrainYes()
{
	Language.SetLangText("FullyTrainYes", "Planning");
	sdata.SlaveType = -100;
	sdata.Price = 0;
	sdata.Available = true;
	if (sdata.Owner == null) {
		// Keep the slave as your own personal slave
		sdata.Owner = new PersonOwner(slaveData, coreGame);
		sdata.Owner.ChangeOwner(3000);
	}
	SMData.BuildOwnedSlaves();
	DoEvent(9750);
}

function RollOverBtnTrain()
{
	Hints.ShowHint(Language.GetHtml("HintFullyTrain", hintNode));
}
