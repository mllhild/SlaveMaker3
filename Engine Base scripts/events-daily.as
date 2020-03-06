import Scripts.Classes.*;
var DoneEvent:Number;


// Daily Events

function TriggerEvents()
{
	if (IsEventPicked() == false && Quitter._visible == false && AskQuestions._visible == false) {
		Events();
		if (EndGame.IsShown()) return;
	}
	UsedAphrodisiac = 0;
	TotalBondageToday = 0;
	TotalBlowJobToday = 0;
	TotalAnalToday = 0;
	
	if (IsEventPicked() == false && Quitter._visible == false && AskQuestions._visible == false && (DoneEvent == 0 || DoneEvent == 3)) {
		// Morning, no events
		ServantSpeakEnd();
		ShowDress();
		if (!Options.bLimitSavesOn) LoadSave.SaveGameString("auto");
		dspMain.ShowMainButtons();
	} else {
		dspMain.ShowGameTabs();
		modulesList.AfterEvents();
		if (NumEvent > 9899 && NumEvent < 9999) {
			if (DoneEvent != 2) {
				ServantSpeakEnd();
				dspMain.ShowMainButtons(true);
				if (DoneEvent == 0) ShowDress();
			}
		}
	}
}

function Events()
{
	trace("Events: " + DoneEvent);
	
	if (OwnerTestingUrgent) Owner.DoOwnerTest();
	
	// End of Training
	if (Owner.GetOwner() != 0 && DoneEvent == 0) {
		if (Owner.GetOwner() != 3000) {
			if (Elapsed >= TrainingTime) {
				TrainingComplete();
				return;
			}
		} 
	}
	
	modulesList.EventsUrgent(DoneEvent == 0);
  	
	// Contests
	if (DoneEvent == 0 && ((GameDate % 8) == 0)) {
		HideMainButtons();
		Backgrounds.ShowFestival();
		if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(35)) Information.ShowTutorialLang("Contests");
		Contests.StartContests();
		NumEvent = 9999;
		return;
	}
 
	if (!OwnerTestingUrgent) Owner.DoOwnerTest();
	
	// Pregnancy
	if (DoneEvent == 0) CheckBirthing(true);
	
	if (DoneEvent == 0) {
		// are any slaves tired
		var j:Number = SMData.nUsable - 1;
		while (--j >= -2) {
			var sd:Object;
			if (j < 0) {
				sd = _root;
				PersonIndex = (j == -1) ? -50 : -100;
			} else {
				sd = SMData.arUsableSlaves[j];
				PersonIndex = sd.SlaveIndex;
				if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
			}
			if (SMData.IsSlaveOwned("Cora")) temp = 75-(Difficulty * 4);
			else temp = 60-(Difficulty * 4);
			
			if (j == -2) {
				if (SMData.SMTiredness > temp) {
					temp = Math.floor(Math.random()*2);
					if (temp == 1) {
						Backgrounds.ShowBedRoom();
						if (SMData.DaysUnavailable >= 0) SMData.DaysUnavailable++;
						else SMData.DaysUnavailable--;
						XMLData.XMLEvent("Daily/SMFellSick");
						break;
					}
				}
			} else if (sd.VarFatigue > temp) {
				temp = Math.floor(Math.random()*2);
				if (temp == 1) {
					GetSlaveInformation(PersonIndex);
					Backgrounds.ShowBedRoom();
					if (j == -1) {
						SlaveGirl.ShowTired(false);
						if (DaysUnavailable >= 0) {
							if (SMData.IsSlaveOwned("Cora")) DaysUnavailable++;
							else DaysUnavailable += 2;
						} else {
							if (SMData.IsSlaveOwned("Cora")) DaysUnavailable--;
							else DaysUnavailable -= 2;
						}
					} else {
						sd.ShowActImage(10001);
						if (sd.DaysUnavailable >= 0) {
							if (SMData.IsSlaveOwned("Cora")) sd.DaysUnavailable++;
							else sd.DaysUnavailable += 2;
						} else {
							if (SMData.IsSlaveOwned("Cora")) sd.DaysUnavailable--;
							else sd.DaysUnavailable -= 2;
						}
						PointsByIndex(PersonIndex, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -10, 0, 0, 0);
					}
					XMLData.XMLEvent("Daily/FellSick");
					break;
				} 
			}
		}
	}
	
	if (DoneEvent == 0 && (GamanEffecting == 1 || BiyakuEffecting == 1 || DoreiEffecting == 1 || IshinaiEffecting == 1 || ZodaiEffecting == 1)) {
		DrugDuration--;
		if (DrugDuration <= 0) {
			if (DoreiEffecting != 1 && IshinaiEffecting != 1) Language.AddLangText("Daily/DrugsWearOff/DidNotKnow", evtNode);
			if (GamanEffecting == 1) VarConstitution = VarConstitution-30;
			if (DoreiEffecting == 1) {
				BlankLine();
				Language.AddLangText("Daily/DrugsWearOff/DidKnow", evtNode);
				VarObedience = VarObedience-30;
				VarMorality = OldMorality;
				DoneEvent = 1;
				NumEvent = 9921;
				ShowDress();
			} 
			if (IshinaiEffecting == 1) {
				BlankLine();
				Language.AddLangText("Daily/DrugsWearOff/DidKnow", evtNode);
				VarObedience = OldObedience;
				VarIntelligence = OldIntelligence;
				VarTemperament = OldVarTemperament;
				VarMorality = OldMorality;
				VarJoy = VarJoy-30;
				VarLovePoints = VarLovePoints-30;
				VarObedience = VarObedience-10;
				DoneEvent = 1;
				NumEvent = 9921;
				ShowDress();
			} 
			GamanEffecting = 0;
			BiyakuEffecting = 0;
			ZodaiEffecting = 0;
			IshinaiEffecting = 0;
			DoreiEffecting = 0;
			temp = Math.floor(Math.random()*100);
			if (AddictionLevel>temp) {
				DrugAddicted = 1;
				NumAddictionLevel++;
			} 
		} 
	} 

	modulesList.Events(DoneEvent == 0);
	
	if (DoneEvent == 0 && Elapsed > 8 && VarReputation > 10 && VarCharismaRounded>45 && VarRefinementRounded>30 && (Owner.GetOwner() == 0 || Owner.GetOwner() > 1000) && Loyalty != 0 && NobleLove != -2) {
		temp = Math.floor(Math.random()*6);
		if (temp == 4) {
			OfferToBuy(0);
		}  
	}
  
	if (DoneEvent == 0) CheckLoveConfession();
 
	if (DoneEvent == 0 && VarLibidoRounded>=25 && VarNymphomaniaRounded>=25 && (Slutiness > 8 || RulesGoOut == 1)) {
		temp = Math.floor(Math.random()*(7 - Difficulty - Math.floor(Slutiness / 3)));
		if (temp == 1) {
			XMLData.XMLEvent("Daily/Proposition", true);
			DoneEvent = 2;
		} 
	}
 
	if (DoneEvent == 0 && OldLover > 0 && RulesGoOut == 1) {
		temp = 15 + Difficulty + (Math.floor(Slutiness / 3) * 5); 
		if (Slutiness > 0 && Behaving < 1 && Math.floor((VarObedienceRounded+VarMoralityRounded)/5)<temp) {
			ShowPerson(1000, 1, 2, OldLover);
			Pay = Math.round(VarCharisma) / 2;
			BadGirl = 1;
			XMLData.XMLEvent("Daily/DatingOldLover", true);
			SlaveGirl.OldLoverDating();
		} else {
			OldLover = 0;
			ShowPerson(1000, 1, 2, OldLover);
			XMLData.XMLEvent("Daily/BreakupOldLover", true);
		}
	}
  
	if (DoneEvent == 0 && VarGold >= 500 && NumMerchant < 4 && !BitFlagSM.CheckBitFlag(12)) {
		temp = Math.floor(Math.random()*3);
		if (temp == 1) {
			AddTime(1);
			SetEvent(9909);
			NumMerchant++;
			currentCity.ItemSalesman.VisitShop();
			XMLData.XMLEvent("Daily/ItemSalesmanVisit", false);
			if (NumEvent == 9909) DoEvent();
			DoneEvent = 2;
		}  
	}
  
	if (DoneEvent == 0 && (VarMoralityRounded > 20 || VarNymphomaniaRounded > 50)) {
		temp = Math.floor(Math.random()*7 - Difficulty);
		if (temp == 3) {
			AppendActText = true;
			genNumber = slrandom(2);
			NumEvent = 1 + (genNumber / 10);
			if (!modulesList.EventRescue()) {
				if (DoneEvent == 0) {
					DoEvent();
					NextEvent._visible = false;
				}
				DoneEvent = 2;
				YesNoFlag = 2;
				genNumber = Math.round((NumEvent - 1) * 10);
				Pay = (100 + Difficulty * 20);
				XMLData.XMLEvent("Daily/Rescuers");
				if (NumEvent != 9999) ShowYesNoButtons();
			}
		} 
	}
  
	if (DoneEvent == 0 && Home.HouseType != 1 && Home.HouseType != 10 && VarObedienceRounded<5 && Loyalty >= 0) {
		temp = Math.floor(Math.random()*Loyalty - (Difficulty / 2));
		if (temp == 2) XMLData.XMLEvent("Daily/Runaway");
	}
 
	if (DoneEvent == 0 && EventBoyfriend == 1 && (Slutiness > 8 || RulesGoOut == 1) && BitGagWorn == 0) {
		if (RulesFuck == 1 || Slutiness > 8) temp = -10;
		else temp = 0;
		temp -= (Math.floor(Slutiness / 3)  * 5);
 
		if (VarLibidoRounded>50 && VarLibidoRounded>VarObedienceRounded+temp) {
			if (RulesFuck == 0) BadGirl = 1;
			XMLData.XMLEvent("Daily/Dating");
			SlaveGirl.ShowDating();
		} else {
			HideImages();
			ShowDress();
			XMLData.XMLEvent("Daily/DatingBrokeUp");
		}
	}
  
	if (DoneEvent == 0 && EventBoyfriend != -1 && VarNymphomaniaRounded>10 && (Slutiness > 8 || (RulesGoOut == 1 && BitGagWorn == 0))) {
		if (NumBlowjobSinceFucked>=5 || NumTitsFuckSinceFucked>=5 || NumLickSinceFucked>=5 || NumTouchSinceFucked>=5 || NumAnalSinceFucked>=5 || NumMasturbateSinceFucked>=5) {
			if (RulesFuck == 0) BadGirl = 1;
			XMLData.XMLEvent("Daily/StartDatingSex");
			SlaveGirl.ShowDating();
		}  
	}
 
	if (DoneEvent == 0 && EventBoyfriend == 0 && VarCharismaRounded >= 25 && RulesGoOut == 1 && BitGagWorn == 0) {
		temp = Math.floor(Math.random()*3);
		if (temp == 2) {
			if (RulesFuck == 1) temp = -10;
			else temp = 0;
			temp -= (Math.floor(Slutiness / 3)  * 5);

			if (VarLibidoRounded > 50 && VarLibidoRounded > (VarObedienceRounded + temp)) {
				if (RulesFuck == 0) BadGirl = 1;
				XMLData.XMLEvent("Daily/StartDating");
				SlaveGirl.ShowDating();
			}  
		}  
	}

	if (DoneEvent == 0 && (!BitFlagSM.CheckBitFlag(0)) && (VarGold + SMGold) > 9 && (Elapsed > 16 || PercentChance(25))) {
		BitFlagSM.SetBitFlag(0);
		XMLData.XMLEvent("Daily/FortuneTellerVisit", true);
	}
  
  	if (DoneEvent == 0) {
		if (XMLData.PickAndDoXMLEvent("Daily/Rumours")) {
			RemoveText(-2);
			DoEvent(9914);
		}
	}
}