import Scripts.Classes.*;

// Order Slave
var PlanningOrders:PlanningList = new PlanningList(_root, true);

// Fuctions
function SlaveOrder()
{
	if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(50)) Information.ShowTutorialLang("GiveOrders");

	if (!Plannings.IsStarted() && ((Day && GameTimeMins >=1080) || (!Day && GameTimeMins > 1380))) {		// 1600 & 2300
		Language.SetLangText("NotEnoughTime", "Planning");
		BlankLine();
		Bloop();
		return;
	}
	SlaveDiscussion._visible = false;
	SlaveStatus._visible = false;
	Hints.HideHints();
	UpdateSlaveCommon(sdata == _root ? slaveData : sdata);
	ActLevel = 1;
	PlanningOrders.Reset(slaveData, 8);
	PlanningOrders.PlanningTime = 8;
	PlanningOrders.EndPlanningTime = 16;
	
	if (sdata.Order1 != 0) PlanningOrders.AddDayNightAction(sdata.Order1, true);
	if (sdata.Order2 != 0) PlanningOrders.AddDayNightAction(sdata.Order2, true);
	
	ShowOrders();
}

function ShowOrders()
{
	PlanningPage._visible = true;
	plantab = -1;
	
	HideImages();
	Backgrounds.ShowBedRoom();
	ShowLeaveButton();
	PersonIndex = ParticipantsChanger.idx;
	SlavePicker.ReviewSlave(PersonIndex);
	SMAvatar.ShowSlaveMaker();
	
	dspMain.SelectGameTab(5);
	dspMain.ShowTabBackground(false);
	PlanningSelections._visible = true;
	PlanningSelections.ClearButton._visible = true;
	PlanningSelections.Set1._visible = false;
	PlanningSelections.Set2._visible = false;
	PlanningSelections.Set3._visible = false;
	PlanningSelections.ParticipantsBtn._visible = false;
	PlanningSelections.ChkSameListDay._visible = false;
	PlanningSelections.ChkSameListNight._visible = false;
	PlanningSelections.SupervisionBtn._visible = false
	PlanningSelections.LSMAction._visible = false;
	
	PlanningSelections.LSelections.htmlText = Language.GetHtml("DaytimeOrdersSelection", "Planning");
	PlanningPage.DayNightText.htmlText = Language.GetHtml("DaytimeOrders", "Planning");
	PlanningPage.Title.htmlText = Language.GetHtml("DaytimeOrdersDetails", "Planning");
	
	Plannings.ResetImages();
	
	var len:Number = slaveData.ActInfoBase.GetActCounts();
	var act:ActInfo;
	for (var i:Number = 0; i < len; i++) {
		act = coreGame.slaveData.ActInfoBase.GetActByIndex(i);
		if (act.Type != 12) continue;
		act.HideAct();
	}
	
	// Custom Order
	var sNode:XMLNode = sdata.GetSlaveXML();
	var cidx:Number = 0;
	var sNode:XMLNode = sdata.GetSlaveXML();
	for (var cNode:XMLNode = XMLData.GetNodeC(sNode, "Planning/DoPlanning"); cNode != null; cNode = cNode.nextSibling) {
		var str:String = cNode.nodeName.toLowerCase();
		if (str.substr(0, 16) == "slavecustomorder" || str.substr(0, 11) == "customorder") {
	
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
				act = slaveData.ActInfoBase.SetActDetails(3000 - cidx, false, true, "", "", "", 0, 0.5);
				act.Type = 12;
				act.HideAct();
				act.SetActDetails(false, true, cname, clabel, "", 0, 0.5);
				act.strNodeName = cNode.nodeName;
				act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
				act.xNode = cNode;
				if (bshow == true) act.ShowAct();
			}
		}
	}
	
	dspMain.ShowGameTab(6);
	dspMain.ShowTabBackground(false);
	
	reShowOrders();
}
function reShowOrders()
{
	ShowPlanningTab(-1);
}

function GiveOrder(order)
{
	var act:ActInfo = slaveData.ActInfoBase.GetAct(order);
	if (!act.IsShown()) return;
	Hints.HideHints();	
	PlanningPage._visible = false;
	PlanningSelections._visible = false;;
	
	genNumber = order;
	if (SlaveGirl.NewSlaveOrder(PersonName, order, false) == true) {
		UpdateSlaveCommon(sdata);
		if (IsEventAllowable()) reShowOrders();
		return;
	}
	if (CurrentAssistant.NewSlaveOrderAsAssistant(PersonName, order, false) == true) {
		UpdateSlaveCommon(sdata);
		if (IsEventAllowable()) reShowOrders();
		return;
	}
	if (XMLData.DoXMLActForSlave("NewSlaveOrder", sdata)) {
		UpdateSlaveCommon(sdata);
		if (IsEventAllowable()) reShowOrders();
		return;
	}

	PlanningOrders.AddDayNightAction(order, false);
	
	if (IsEventAllowable()) reShowOrders();
}

function LeaveOrders()
{
	// save orders
	sdata.Order1 = 0;
	sdata.Order2 = 0;

	var pact:PlanningAction;
	for (var i:Number = 0; i < PlanningOrders.arPlanningArray.length; i++) {
		pact = PlanningOrders.arPlanningArray[i];
		if (i == 0) sdata.Order1 = pact.SlaveAction;
		else sdata.Order2 = pact.SlaveAction;
	}

	// clear and return
	PlanningOrders.Reset(sdata);
	ShowSlaveTalk();
}

function GiveOrderHint(order:Number)
{
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(order);
	ServantSpeak(act.Description);
}

function RollOverBtnOrder()
{
	Hints.ShowHint(Language.GetHtml("HintSlaveOrder", hintNode));
}

function GiveOrdersShortcuts(keyAscii:Number, key:Number)
{
	switch (keyAscii) {
		case 65:
			GiveOrder(1045);
			return;	
		case 66:
			GiveOrder(1046);
			return;				
		case 67:
			GiveOrder(1001);
			return;
		case 70:
			GiveOrder(1043);
			return;
		case 71:
			GiveOrder(1002);
			return;
		case 79:
			GiveOrder(1047);
			return;	
		case 80:
			GiveOrder(1042);
			return;				
		case 82:
			GiveOrder(1044);
			return;	
		case 84:
			GiveOrder(1041);
			return;				
	}
}