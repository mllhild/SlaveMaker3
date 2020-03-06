import Scripts.Classes.*;

function DoEventNext(eventno, xmlnow:Boolean)
{
	if (eventno != undefined) SetEvent(eventno);
	else SetText("");
	trace("DoEventNext: numevent:" + NumEvent + " strevent: " + StrEvent); // + " objevent: " + ObjEvent);
	
	dspMain.PopGameTabs();
	DoneEvent = 0;
	OldNumEvent = NumEvent;
	OldStrEvent = StrEvent;
	NextEvent._x = 750;
	Quitter._x = 750;
	tempstr = Language.SaveText();
	NextEvent._visible = false;
	Beep();
	
	if (Contests.IsContestStarted()) {
		Contests.DoContestsNext();
		return;
	}
	
	if (NumEvent == 0) {		
		if (StrEvent == "") {
			if (ObjEvent == null) return;
			XMLData.XMLEventByNode(ObjEvent, false, undefined, xmlnow == true);
			modulesList.AfterEventNext();
			return;				
		}
		// decode some string events to numbers
		if (StrEvent == "ShowShop" || StrEvent == "ShowDialog") NumEvent = 9700;
		else if (StrEvent == "NewDayEvents") NumEvent = 250;
		else if (StrEvent == "ContinueWalk") NumEvent = 4998;
		else if (StrEvent == "ContinuePlanning") NumEvent = 9903;
		else if (StrEvent == "GameOver") NumEvent = 9800;
		else if (StrEvent == "StartOfNewDay") NumEvent = 9999;
		// Do some standard events
		else if (StrEvent == "ChangeCity") {
			dspMain.SelectGameTab(5);
			HideDresses();
			HideEndings();
			Contests.HideImages();
			HideSlaveActions();
			dspMain.Hide();
			dspMain.HideMainButtons();
			currentDialog = new DialogSelectCity(coreGame);
			currentDialog.ViewDialog(2);
			return;
		} else if (StrEvent == "RecheckBirthing") {
			RecheckBirthing();
			return;
		} else {
			// decode number for string event, legacy from Mardukane events
			var earr:Array = StrEvent.split("-");
			if (earr[0] == "CoreEvent") {
				if (earr[2] != undefined && earr[2] != "" && !isNaN(earr[2])) NumEvent = Number(earr[2]);
				else if (earr[1] != undefined && earr[1] != "" && !isNaN(earr[1])) NumEvent = Number(earr[1]);
			}
		}
		if (NumEvent != 0) StrEvent = "";
		else if (StrEvent != "") {
			if (typeof(ObjEvent) != "string") {
				ObjEvent[StrEvent]();		// arbitrary function
				modulesList.AfterEventNext();
				return;
			} else {
				// xml node
				var bRet:Boolean = XMLData.DoXMLActForSlave(StrEvent, SMData.GetSlaveByIndex(PersonIndex), true);
				if (!bRet) bRet = XMLData.XMLEventLastNode(StrEvent, false);
				if (bRet) {
					modulesList.AfterEventNext();
					return;
				}
			}
		}
	}
	if (modulesList.DoEventNext()) {
		modulesList.AfterEventNext();
		return;
	}
	/*
	if (NumEvent != 0) {
		if (XMLData.XMLEventLastNode("CoreEvent-" + NumEvent, false, xmlnow == true)) {
			modulesList.AfterEventNext();
			return;
		}											
	}
	*/
	if (NumEvent > 199 && NumEvent < 250) {
		DickgirlEvent();
		modulesList.AfterEventNext();
		return;
	}
	if (NumEvent > 2999 && NumEvent < 4000) {
		Combat.CombatEvent(NumEvent);
		modulesList.AfterEventNext(true);
		return;
	}
	if (NumEvent > 8019 && NumEvent < 8080) {
		if (NumEvent < 8040) Parties.ProstituteParty(NumEvent);
		else Parties.HighClassParty(NumEvent);
		modulesList.AfterEventNext();
		return;
	}	
	if (NumEvent > 4079 && NumEvent < 4090) {
		HidePlanningNext();
		DoMilkEvent();
		modulesList.AfterEventNext();
		return;
	}
	
	switch(NumEvent) {
		
	// 3 - Love Confession Accepted
	case 3:
		DoLoveConfessionAccepted();
		break;
		
	// 3.2 - love confession refused
	case 3.2:
		DoLoveConfessionRefused();
		break;
		
	// 3.4 - love confession refused
	case 3.4:
		DoLoveConfessionUnsure();
		break;
		
	// 30 - recapture runaway
	case 30:
		HideImages();
		ShowAssistant();
		if (SlaveGirl.ShowRetrieved() != true) {
			ChangeDate(3);
			if (!Language.IsTextShown()) XMLData.XMLEvent("RecapturedRunaway");
		}
		DoEvent(9999);
		break;

	// sleazy bar service
	case 33:
	case 33.1:
	case 33.2:
		JobSleazyBarService(NumEvent);
		break;
				
	// acolyte job
	case 40.1:
		SetText("");
		DoJobAcolyte1();
		break;
		
	// Marriage
	case 42:
		SlaveMarried();
		break;
			
	// 250 - start new day
	case 250:
		StartMorning();
		break
		
	case 252:
		ServantSpeakStart(ServantMaster + Language.GetHtml("MorningGreeting", assNode));
		HideImages();
		HidePeople();
		HideSlaveActions()
		HideDresses();

	case 253:
		DoneEvent = 0;
		ResetEventPicked();
		TriggerEvents();
		break;
		
	// 251 - early morning 'pre-event'
	case 251:
		HideImages();
		HideBackgrounds();
		SetEvent(250);
		eventLoop++;
		if (DoneEvent < 2) DoneEvent = 0;
		//if (eventLoop == 1) {
			//NumEvent = 250;
			if (MilkPreEvent()) {
				dspMain.ShowGameTabs();
				break;
			}
			//else NumEvent = 251;
		//}
		if (!modulesList.PreEvent(eventLoop)) {
			// in some cases the event will have changed to a custom event. Mostly this is a bug for the slave (failing to return true)
			// so ONLY if the event is 251 then move to morning events
			if (NumEvent == 250 || NumEvent == 251) {
				SetEvent(250);
				DoEventNext();
				return;
			}
		}
		
		if (IsEventAllowable()) {
			if (NumEvent == 0) break;
			DoEvent();
			DoneEvent = 0;
		}
		dspMain.ShowGameTabs();
		break;
		
	case 254:
		NewDay();
		return;
		
	case 4997:
		currentCity.ShowTakeAWalkMenu(false);
		return;
		
	// continue walk, variant 2
	case 4998:
		HideImages();
		Backgrounds.ShowBackground(currPlace.strNodeName);
		currPlace.DoWalkLoadedContinue();
		modulesList.AfterEventNext();
		return;
		
	// continue the walk
	case 4999:
		HideImages();
		Backgrounds.ShowBackground(currPlace.strNodeName);
		ResetEventPicked();
		currentCity.DoWalkNow();
		modulesList.AfterEventNext();
		return;
		
	// 8398 - nothing
	// OBSOLETE (replaced by 9903)
	 case 8398:
		DoPlanningNext();
		return;
		
	// 8399 - end visit
	 case 8399:
		if (LendPerson == 0) {
			TotalVisit++;
			NobleLoveEvent(VisitLendPerson, VisitLendPerson != 8);
		} else {
			DoEvent(9704);
			if (LendPerson == -1) LendPerson = person;
		}
		VisitLendPerson = 0;
		LendPerson = 0;
		ShowPlanningNext();
		return;


	case 9009:
		ActionChoice = ActionChoice + 0.9;
		DoNewPlanningYes();
		return;
		
	case 9008:
		ActionChoice = ActionChoice + 0.8;
		DoNewPlanningYes();
		return;
		
	case 9007:
		ActionChoice = ActionChoice + 0.7;
		DoNewPlanningYes();
		return;
		
	case 9006:
		ActionChoice = ActionChoice + 0.6;
		DoNewPlanningYes();
		return;
		
	case 9005:
		ActionChoice = ActionChoice + 0.5;
		DoNewPlanningYes();
		return;
		
	case 9004:
		ActionChoice = ActionChoice + 0.4;
		DoNewPlanningYes();
		return;
		
	case 9003:
		ActionChoice = ActionChoice + 0.3;
		DoNewPlanningYes();
		return;
		
	case 9002:
		ActionChoice = ActionChoice + 0.2;
		DoNewPlanningYes();
		return;
		
	case 9001:
		ActionChoice = ActionChoice + 0.1;
		DoNewPlanningYes();
		return;
		
	case 9001.1:
		ActionChoice = ActionChoice + 0.01;
		DoNewPlanningYes();
		return;
		
	case 9010:
		if ((Plannings.PlanningTime + 1) < Plannings.EndPlanningTime) ActionChoice = ActionChoice + ((Plannings.EndPlanningTime - Plannings.PlanningTime - 1) * 0.01);
		DoNewPlanningYes();
		return;
		
	case 9011:
	case 9012:
	case 9013:
	case 9014:
		// random
		Participants.push((NumEvent - 9010) * -1);
		DoNewPlanningYes();
		return;
		
	case 9018.1:
	case 9018.2:
	case 9018.3:
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);

		if (NumEvent == 9018.1 && (AssistantData.SlaveGender == 1 || AssistantData.SlaveGender == 4) && asscan) {
			Participants.push(-100);
			Participants.push(-99);
			DoNewPlanningYes();
			return;
		}
		if (NumEvent == 9018.2 && (AssistantData.SlaveGender == 2 || AssistantData.SlaveGender == 5) && asscan) {
			Participants.push(-100);
			Participants.push(-99);
			DoNewPlanningYes();
			return;
		}
		if (NumEvent == 9018.3 && (AssistantData.SlaveGender == 3 || AssistantData.SlaveGender == 6) && asscan) {
			Participants.push(-100);
			Participants.push(-99);
			DoNewPlanningYes();
			return;
		}
		Participants.push(Math.round(10 * (NumEvent - 9018)) * -1);
	case 9020:
		// slavemaker participant
		Participants.push(-100);
		DoNewPlanningYes();
		return;

	case 9019.1:
	case 9019.2:
	case 9019.3:
		Participants.push(Math.round(10 * (NumEvent - 9019)) * -1);				
	case 9019:
		// assistant
		Participants.push(-99);
		DoNewPlanningYes();
		return;	
		
	case 9020.1:
	case 9020.2:
	case 9020.3:
		Participants.push(Math.round(10 * (NumEvent - 9020)) * -1);
	case 9020:
		// slavemaker participant
		Participants.push(-100);
		DoNewPlanningYes();
		return;
		
	case 9021:
		// multiple male
		var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);
		var rem:Number = act.MinParticipants;
		if (SMData.Gender == 3) Participants.push(-100);
		if (--rem == 0) return DoNewPlanningYes();
		if (asscan && !ServantFemale) {
			Participants.push(-99);
			rem--;
		}
		while (rem > 0) {
			Participants.push(-1);
			rem--;
		}
		DoNewPlanningYes();
		return;
		
	case 9022:
		// multiple female
		var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);
		var rem:Number = act.MinParticipants;
		if (SMData.Gender == 2) Participants.push(-100);
		if (--rem == 0) return DoNewPlanningYes();
		if (ascan && ServantFemale) {
			Participants.push(-99);
			rem--;
		}
		while (rem > 0) {
			Participants.push(-2);
			rem--;
		}
		DoNewPlanningYes();
		return;
		
	case 9023:
		// multiple dickgirl
		var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);
		var rem:Number = act.MinParticipants;
		if (SMData.Gender == 3) Participants.push(-100);
		if (--rem == 0) return DoNewPlanningYes();
		if (asscan && AssistantData.IsDickgirl()) {
			Participants.push(-99);
			rem--;
		}
		while (rem > 0) {
			Participants.push(-3);
			rem--;
		}
		DoNewPlanningYes();
		return;	
		
	case 9024:
		// multiple, male or dickgirl
		var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);
		var rem:Number = act.MinParticipants;
		if (SMData.Gender == 1 || SMData.Gender == 3) Participants.push(-100);
		if (--rem == 0) return DoNewPlanningYes();
		if (asscan && (AssistantData.IsDickgirl() || !ServantFemale)) {
			Participants.push(-99);
			rem--;
		}
		while (rem > 0) {
			Participants.push(-4);
			rem--;
		}
		DoNewPlanningYes();
		return;	
		
	case 9025:
		// multiple, female or dickgirl
		var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);
		var rem:Number = act.MinParticipants;
		if (SMData.Gender == 2 || SMData.Gender == 3) Participants.push(-100);
		if (--rem == 0) return DoNewPlanningYes();
		if (asscan && (AssistantData.IsDickgirl() || ServantFemale)) {
			Participants.push(-99);
			rem--;
		}
		while (rem > 0) {
			Participants.push(-5);
			rem--;
		}
		DoNewPlanningYes();
		return;	
		
	case 9026:
		// multiple, any
		var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
		var asscan:Boolean = AssistantData.IsAbleToDoAct(ActionChoice);
		var rem:Number = act.MinParticipants;
		Participants.push(-100);
		if (--rem == 0) return DoNewPlanningYes();
		if (asscan) {
			Participants.push(-99);
			rem--;
		}
		while (rem > 0) {
			Participants.push(-6);
			rem--;
		}
		DoNewPlanningYes();
		return;		
		
	case 9030:
		Participants.push(genNumber);
		DoNewPlanningYes();
		return;
		
	case 9000:
		DoNewPlanningYes();
		return;
		
	case 9098:
		if (Participants.length == 0) SetDefaultParticipants(ActionChoice);
		ChangeParticipants(ActionChoice, true);
		return;
		
	case 9099:
		HideImages();
		HideSlaveActions();
		ShowPlanningTab();
		return;
						
	case 9901:
		StartPlanning();
		return;
	 	
	case 9902:
		DoPlanningButton();
		return;
		
	case 9903:
		DoPlanningNext();
		break;
		
	case 9904:
		DoLeaveButton();
		break;
		
	case 9750:
	case 9752:
		if (NumEvent == 9750) sdata.BitFlagC.SetBitFlag(64);
		else  sdata.BitFlagC.SetBitFlag(65);
		if (Plannings.IsStarted() && (GameTime > (LastActionStartTime + LastActionDuration - 0.4))) SetEvent(9751);
		
	case 9921:	// drug effects
	case 9922:	// needing drugs
	case 9905:	// trial
	case 9906:	// offered herself
	case 9907:	// start going out
	case 9908:  // broke up
	case 9909:	// salesmanvisit
	case 9910:	// dating
	case 9911:	// broke up
	case 9912:	// seeing someone
	case 9913:	// fucking
	case 9914:	// rumour
	case 9999:
	case 9700:
	case 9701:
	case 9702:
	case 9703:
	case 9704:
	case 9705:
	case 9706:
	case 9706.1:
	case 9707:
	case 9749:
	case 9751:
		HideYesNoButtons();
		if (NumEvent != 9750 && NumEvent != 9751 && NumEvent != 9752) HideSlaveActions();
		if (NumEvent != 9750 && NumEvent != 9751 && NumEvent != 9752 && NumEvent != 9749 && NumEvent < 9800) {
			HideImages();
			HidePeople();
			Items.HideItems();
			NextEvent._visible = false;
		}
		if (NumEvent == 9700 || NumEvent == 9701 || NumEvent == 9702 || NumEvent == 9703 || NumEvent == 9705) {
			if (currentShop != null) currentShop.ShowShopContents();
			else if (currentDialog != null) currentDialog.ShowDialogContents();
		}
		else if (NumEvent == 9704) {
			VisitMenu._visible = false;
			if (LendPerson != 0) {
				ClearPlannings();
				Plannings.AddDayNightAction(16);
				UpdateSlave();
			}
			MorningEvening.ViewDialog();
		} else if (int(NumEvent) == 9706) {
			HideBackgrounds();
			ShowDress();
			SelectEquipment.Show();
			HideEquipmentButton();
			ShowLeaveButton();
		} else if (NumEvent == 9707) Potions.ShowDialogContents();
		else if (NumEvent == 9708) Rules.ShowDialogContents();
		else if (NumEvent == 9749) ShowOrders();
		else if (NumEvent == 9750 || NumEvent == 9752) {
			var sd:Object = dspMain.GetSlaveForGameTabs();
			if (LoadedSlaves.IsLoadedSlave(sd)) {
				var sm:SlaveModule = LoadedSlaves.GetLoadedSlave(sd);
				sm.HideImages();
				sm.HideSlaveActions();
				sm.HideEndings();
			}
			HideAssistant();
			HideImages();
			Backgrounds.ShowBedRoom();
			ShowSlaveTalk();
		} else if (NumEvent == 9751) {
			var sd:Object = dspMain.GetSlaveForGameTabs();
			if (LoadedSlaves.IsLoadedSlave(sd)) {
				var sm:SlaveModule = LoadedSlaves.GetLoadedSlave(sd);
				sm.HideImages();
				sm.HideSlaveActions();
				sm.HideEndings();
			}
			HideAssistant();
			HideImages();			
			ClearGeneralArray2();
			HideStatChangeIcons();
			dspMain.SetSlaveForGameTabs(_root);
			StatisticsGroup.review = false;
			NextEvent._visible = false;
			Quitter._visible = false;
			dspMain.SelectGameTab(5);
			LargerTextField._visible = false;
			if (Plannings.IsStarted()) DoPlanningNext();
			else DoEventNextToMain();
		} else DoEventNextToMain();
	}
	modulesList.AfterEventNext();
}

function DoEventNextToMain()
{
	modulesList.trainLesbians.InitialiseTraining();
	if (OtherSlaveShown) {
		HideStatChangeIcons();
		dspMain.SetSlaveForGameTabs(_root);
		StatisticsGroup.review = false;
		NextEvent._visible = false;
		Quitter._visible = false;
		dspMain.SelectGameTab(5);
		LargerTextField._visible = false;
	}
	if (Plannings.IsStarted()) {
		DoPlanningNext();
		return;
	}
	if (currentShop != null) currentShop.LeaveShop(true);
	else if (currentDialog != null) currentDialog.LeaveDialog();
	SetText("");
	HideMenus();
	dspMain.Show();
	dspMain.ShowMainButtons();
	if (NumEvent > 9900 && !Options.bLimitSavesOn) LoadSave.SaveGameString("auto");
}


NextEvent.tabChildren = true;
NextEvent.Btn.onPress = DoEventNext;