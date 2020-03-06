//// Yes/No questions

var YesNoFlag:Number;

// Button Show functions
function ShowYesNoButtons()
{
	if (!YesEvent._visible) {
		if (Language.IsLargerTextShown()) {
			dspMain.HideGameTabsOnly();
			dspMain.SelectSingleGameTab(5);
		} else {
			dspMain.PushGameTabs();
			dspMain.HideGameTab(0);
			dspMain.HideGameTab(6);
		}
		Language.BlankLine(false);
		YesEvent._x = GeneralTextField._x + 100;
		NoEvent._x = YesEvent._x + 200;
		YesEvent._y = 558;
		NoEvent._y = 558;
		NoEvent._visible = true;
		YesEvent._visible = true;
	}
}

function HideYesNoButtons()
{
	YesEvent._x = GeneralTextField._x + 100;
	NoEvent._x = YesEvent._x + 200;
	YesEvent._y = 558;
	NoEvent._y = 558;
	if (YesEvent._visible) {
		NoEvent._visible = false;
		YesEvent._visible = false;
	}
}

function DoYesNoEvent(enum:Object, tgt:Object)
{
	DoEvent(enum, tgt);
	YesNoFlag = 2;
	ObjectChoice = 0;
	ShowYesNoButtons();
	NextEvent._visible = false;
}

function PositionYesNo()
{
	if (!YesEvent._visible) return;
	if (LargerTextField._visible) YesEvent._x = 760;
	else YesEvent._x = GeneralTextField._x + 60;
	NoEvent._x = YesEvent._x + 200;

	if (LargerTextField._visible == true) {
		YesEvent._y = LargerTextField._y + LargerTextField.content.LargerTextField._height + 36;
		if (YesEvent._y > 500) YesEvent._y = -1;
	} else {
		YesEvent._y = GeneralTextField._y + GeneralTextField._height + 36;
		if (YesEvent._y > 562) YesEvent._y = -1;
	}
	if (YesEvent._y == -1 || VisitFortuneTeller._visible) {
		trace("-1 or seer");
		YesEvent._y = 558;
		YesEvent._x = 680;
		NoEvent._x = YesEvent._x + 100;
	}
	NoEvent._y = YesEvent._y;
}

function DoYesNoEventXY(enum:Object, tgt:Object)
{
	DoYesNoEvent(enum, tgt);
	PositionYesNo();
}

//-----
// Yes/No question - YES event
//-----
function DoEventYes()
{
	trace("DoEventYes: strevent: " + StrEvent + " numevent:" + NumEvent + " obj: " + ObjEvent);
	dspMain.PopGameTabs();
	Hints.StopHints();
	DoneEvent = 0;
	OldNumEvent = NumEvent;
	NextEvent._x = 750;
	Quitter._x = 750;
	HideYesNoButtons();
	SetText("");
	Beep();
	if (YesNoFlag == 1) {
		DoNewPlanningYes();
		Quitter._x = 824;
		return;
	}
	
	if (modulesList.DoEventYes()) {
		modulesList.AfterEventYes();
		return;
	}

	if (NumEvent == 0) {
		if (StrEvent == "") {
			XMLEventByNode(ObjEvent, false, undefined);
			modulesList.AfterEventYes();
			return;				
		}
		var earr:Array = StrEvent.split("-");
		if (earr[0] == "CoreEventYes" || earr[0] == "CoreEvent") {
			if (earr[2] != undefined && earr[2] != "" && !isNaN(earr[2])) NumEvent = Number(earr[2]);
			else if (earr[1] != undefined && earr[1] != "" && !isNaN(earr[1])) NumEvent = Number(earr[1]);
		}
		if (StrEvent != "") {
			if (typeof(ObjEvent) != "string") ObjEvent[StrEvent]();		// arbitrary function
			else XMLData.XMLEventLastNode(StrEvent + "Yes", true);
			modulesList.AfterEventYes();
			return;
		}
	} else {
		if (XMLData.XMLEventLastNode("CoreEventYes-" + NumEvent, true)) {
			modulesList.AfterEventYes();
			return;
		} else if (XMLData.XMLEventLastNode("CoreEvent-" + NumEvent, true)) {
			modulesList.AfterEventYes();
			return;
		}																						
	}
	if (NumEvent > 199 && NumEvent < 250) {
		DoDickgirlYes();
		modulesList.AfterEventYes();
		return;
	} else if (NumEvent > 4079 && NumEvent < 4100) {
		DoMilkYes();
		modulesList.AfterEventYes();
		return;
	}
	
	if (Math.floor(NumEvent) == 2) NumEvent = Math.floor(NumEvent);
	
	switch (NumEvent) {
	
	// 1 - rescue and bribed
	case 1:
	case 1.1:
	case 1.2:
		if ((VarGold + SMGold) >= (100 + Difficulty * 20)) Money(-(100 + Difficulty * 20));
		else {
			HideImages();
			if (SlaveGirl.ShowRetrieved() != true) {
				UpdateDateAndItems(3, true, 6, false);
				SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -2);
				Language.AddLangText("NotEnoughMoney", "Shopping");
				BlankLine();
				ServantSpeak(ServantMaster + Language.GetHtml("SlaveRetrieved", assNode), true);
			}
			DoEvent(9999);
		} 
		break;
		
	// 2 - Sold Slave
	case 2:
	case 2.1:
	case 2.2:
	case 2.3:
		Owner.SellSlave(NumEvent);
		break;
		
	// 3 - Love Confession Accepted
	case 3:
		DoLoveConfessionAccepted();
		break;
		
	// 8 - Visit Fortune Teller
	case 8:
		currentCity.DoVisitNow(32, false);
		return;
		
	// 13 - Sold to nobleman
	case 13:
		SellToNoble();
		break;
		
	// Work as chef
	case 31:
		BitFlag1.SetBitFlag(32);
		XMLData.DoXMLAct("RestaurantAcceptChef");
		BlankLine();
		DoJobRestaurant();
		break;
		
	// stripease in Sleazy Bar
	case 32:
		WorkInSleazyBarStripTease(true);
		break;
		
	// sleazy bar service
	case 33:
	case 33.1:
	case 33.2:
		JobSleazyBarService(NumEvent);
		break;
		
	case 36:
		DoEventNext();
		return;
		
	case 38.1:
	case 38.2:
	case 38.3:
		JobOnsenService();
		break;
		
	// Yes, do force
	case 39:
		if (LastActionRefused == -99) sdata = AssistantData;
		else sdata = SlavesArray[LastActionRefused];
		PersonName = sdata.SlaveName;
		XMLData.XMLGeneral("Acts/SlaveSexForceSlave");
		Participants.push(LastActionRefused);
		Participants.sort(Array.NUMERIC);
		ShowParticipants();
		ShowLeaveButton();
		break;
		
	// exorcism
	case 40:
		HideActImages();
		Sounds.PlaySound("Spank");
		XMLData.XMLEvent("ExorcismInvestigate");
		PersonSpeakStart(24, "", true);
		DoJobAcolytePart2(0);
		break;
		
	// change assistant
	case 41:
		SlaveAssistantChange();
		break;
		
	// Fully train
	case 43:
		SlaveFullyTrainYes();
		break;
		
	}

	modulesList.AfterEventYes();
}

//-----
// Yes/No question - NO event
//-----
function DoEventNo()
{
	trace("DoEventNo: strevent: " + StrEvent + " numevent:" + NumEvent);
	dspMain.PopGameTabs();
	DoneEvent = 0;
	Hints.StopHints();
	OldNumEvent = NumEvent;
	NextEvent._x = 750;
	Quitter._x = 750;
	HideYesNoButtons();
	HideQuestions();
	SetText("");
	Beep();
	if (YesNoFlag == 0) {
		ActionChoice = 0;
		Items.HideItems();
		ShowLeaveButton();
		if (Action == 2508) SMAvatar.ShowSlaveMaker();
		else if (SlavePurchase._visible == true) {
			SetCellNextPreviousButtons();
			Quitter._x = 824;
		} else {
			if (DealerMenu._visible) HideEquipmentButton();
			else ShowEquipmentButton();
			HideImages();
			HideSlaveActions();
			if (currentShop != currentCity.Tailors) {
				currentShop.ShowShopContents();
				return;
			}
			HideDresses();
			currentCity.GetShopInstance(0).ShowPurchaser(0);
			currentCity.GetShopInstance(0).ShowPurchaser(1);
			Backgrounds.ShowTailors();
			TailorMenu._visible = true;
		}
		smodulesList.AfterEventNo();
		return;
	} else if (YesNoFlag == 1) {
		Quitter._x = 824;
		return;
	}

	if (modulesList.DoEventNo()) {
		modulesList.AfterEventNo();
		return;
	}
	
	if (NumEvent == 0) {
		if (StrEvent == "") {
			XMLEventByNode(ObjEvent, false, undefined);
			modulesList.AfterEventNo();
			return;				
		}
		var earr:Array = StrEvent.split("-");
		if (earr[0] == "CoreEvent" || earr[0] == "CoreEventNo") {
			if (earr[2] != undefined && earr[2] != "" && !isNaN(earr[2])) NumEvent = Number(earr[2]);
			else if (earr[1] != undefined && earr[1] != "" && !isNaN(earr[1])) NumEvent = Number(earr[1]);
		}
		if (StrEvent != "") {
			if (typeof(ObjEvent) != "string") ObjEvent[StrEvent]();		// arbitrary function
			else XMLData.XMLEventLastNode(StrEvent + "No", true);
			modulesList.AfterEventNo();
			return;
		}
	} else {
		if (XMLData.XMLEventLastNode("CoreEventNo-" + NumEvent, true)) {
			modulesList.AfterEventNo();
			return;
		} else if (XMLData.XMLEventLastNode("CoreEvent-" + NumEvent, true)) {
			modulesList.AfterEventNo();
			return;
		}																																
	}
	if (NumEvent > 199 && NumEvent < 250) {
		DoDickgirlNo();
		modulesList.AfterEventNo();
		return;
	} else if (NumEvent >= 4079 && NumEvent < 4100) {
		DoMilkNo();
		modulesList.AfterEventNo();
		return;
	}
	
	switch(NumEvent) {
		
	// 1 - slave rescue, no bribe
	case 1:
	case 1.1:
	case 1.2:
		HideImages();
		HideBackgrounds();
		if (SlaveGirl.ShowRetrieved() != true) {
			UpdateDateAndItems(3, true, 6, false);
			ShowAssistant();
			ServantSpeak(ServantMaster + Language.GetHtml("SlaveRetrieved", assNode));
		}
		SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -2);
		DoEvent(9999);
    	break;
		
	// 3.2 - love confession refused
	case 3:
	case 3.2:
		DoLoveConfessionRefused();
		break;

	// 13 - refused sale to noble
	case 13:
		RefuseSaleToNoble();
		break;
		
	// Work as chef
	case 31:
		XMLData.DoXMLAct("RestaurantRefuseChef");
		DoJobRestaurant();
		break;
					
	// stripease in Sleazy Bar
	case 32:
		XMLData.DoXMLAct("SleazyBarStripTeaseRefuse");
		break;
		
	// 33: Sleazybar service - do nothing
	case 36:
		if (SMData.SMFaith == 1) Points(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		break;
		
	// Sleazybar service
	case 38.1:
	case 38.2:
	case 38.3:
		XMLData.DoXMLAct("OnsenServiceRefuse");
		break;
		
	// No, do not force
	case 39:
		ShowLeaveButton();
		break;
		
	// exorcism
	case 40:
		XMLData.XMLEvent("ExorcismIgnore");
		
		DoJobAcolytePart2(2);
		break;

	// Fully train
	case 43:
		DoEventNext(9750);
		break;
	}
	
	modulesList.AfterEventNo();
}


YesEvent.YesEvent.onPress = DoEventYes;
NoEvent.NoEvent.onPress = DoEventNo;