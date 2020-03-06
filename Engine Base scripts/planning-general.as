import Scripts.Classes.*;

// Choose Action

function NewPlanningAction(type:Number, hint:Boolean)
{
	if (hint == undefined) hint = false;
	ResetQuestions();
	HideYesNoButtons();
	YesNoFlag = 1;
	
	var acti:ActInfo = slaveData.ActInfoBase.GetActAbs(type);
	var atype:Number = acti.Type;
	if (!acti.bShown) return;		// handle case where standard act is hidden
	
	// Set default participants
	delete Participants;
	Participants = new Array();
	var len:Number = act.Participants.length;
	for (i = 0; i < len; i++) Participants.push(act.Participants[i]);
	
	if (!hint) {
		
		if ((type < 2500 && int(type) != 1017) && DaysUnavailable != 0 && acti.Type != 4 && acti.Type != 10) {
			XMLData.XMLGeneral("Planning/SlaveUnwell", true);
			Bloop();
			return;
		}
		
		if ((VarGold + SMData.SMGold) < acti.Cost) {
			ServantSpeak(Language.GetHtml("NotEnoughMoney", "Shopping"));
			Bloop();
			return;
		}
		
		if (acti.Act == 16) {
			// special case for Lend, clear list as it is the only permitted training
			Plannings.Reset(slaveData);
		}
		
		var lastentry:Number = Plannings.arPlanningArray.length - 1;
		var ptime:Number = Plannings.PlanningTime;
		if (plantab == 6) ptime = Plannings.arPlanningArray[lastentry].PlanningTime;
		var adur:Number = acti.GetActDuration();
		
		//trace("act: " + type + " " + ptime + " " + adur + " " + Plannings.EndPlanningTime + " " + atype + " " + plantab);
		
		if (plantab != 6 && SlaveDiscussion._visible == false && MorningEveningMenu._visible == false && SlaveDiscussion._visible == false) {
			if ((ptime + adur) > Plannings.EndPlanningTime) {
				genNumber = adur;
				XMLData.XMLGeneral("Planning/NotEnoughHours", true);
				Bloop();
				return;
			}
		}
		var astart:Number = acti.StartTime;
		var aend:Number = acti.EndTime;
		if (astart != undefined && aend != undefined && astart != 0 && aend != 0) {
			if (Plannings.PlanningTime < astart || Plannings.PlanningTime > aend) {
				ServantSpeak("This is only open between #displaytime-" + astart + " and #displaytime-" + aend);
				Bloop();
				return true;
			}
		}
		
		if (acti.Type == 4 || acti.Type == 10) {
			var sact:Number = Plannings.arPlanningArray[lastentry].SlaveAction;
			if (sact != 0 && sact != undefined && !IsNoAssistant() && DaysUnavailable == 0) {
				var sdur:Number = GetActDuration(sact);
				if (adur > sdur) {
					genNumber = adur;
					genNumber2 = sdur;
					ServantSpeak(Language.GetHtml("NotEnoughHoursDuring", "Planning"));
					Bloop();
					return;
				}
			}
		}
		
	
		if (acti.Participants.length == 0) PlanningSelections.ParticipantsBtn._visible = false;

		Beep();
	}
	CurrentSuperviseYourself = SuperviseYourself;
	ActionChoice = type;
	SetText("");
	
	var available:Boolean = acti.Available;
	
	if (hint == false || SlaveVersion != "") {
		if (modulesList.NewPlanningAction(ActionChoice, available, hint)) {
			if (ActionChoice == 0) return true;
			modulesList.AfterNewPlanningAction(ActionChoice, available, hint);
			if (ActionChoice != 10 && ActionChoice != 13 && ActionChoice != 16 && atype != 10) Quitter._visible = true;
			if (hint == false && AskQuestions._visible == false && VisitMenu._visible == false && YesEvent._visible == false) DoNewPlanningYes();
			return;
		}
	}

	if (type < 1000) {
		if (NewPlanningActionSex(type, hint)) return;
	} else if (type < 2000) {
		if (NewPlanningActionChoresSchools(type, hint)) return;
	} else {
		
		switch (type) {
		
		// Shop - Stables
		case 2001:
			SetText(Language.GetHtml("StablesDescription", actNode) + "\r\r");
			break;
			
		// Shop - Tailors
		case 2002:
			SetText(Language.GetHtml("TailorsDescription", actNode) + "\r\r");
			break;
			
		// Shop - Shop
		case 2003:
			SetText(Language.GetHtml("ShopDescription", actNode) + "\r\r");
			break;

		// Shop - Salon
		case 2004:
			SetText(Language.GetHtml("SalonDescription", actNode) + "\r\r");
			break;
			
		// Visit
		case 2005:
			SetText(Language.GetHtml("VisitDescription", actNode) + "\r\r");
			break;
			
		// Slave Maker - Martial
		case 2501:
			SetText(Language.GetHtml("MartialTrainingDescription", actNode) + "\r\r");
			break;
			
		// Slave Maker - Pray
		case 2502:
			Language.SetLangText("PrayAtChurchDescription", actNode);
			BlankLine();
			break;
			
		// Slave Maker - Relax in Bar
		case 2503:
			SetText(Language.GetHtml("RelaxInABarDescription", actNode));
			break;
			
		// Slave Maker - Relax in Sleazy Bar
		case 2510:
			if (!hint && Plannings.PlanningTime > 6 && Plannings.PlanningTime < 12) {
				ServantSpeak(Language.GetHtml("SleazyBarHours", "Planning"));
				Bloop();
				return true;
			}
			Language.SetLangText("RelaxInASleazyBarDescription", actNode);
			break;
			
		// Slave Maker - Attend Court
		case 2504:
			SetText(Language.GetHtml("AttendCourtDescription", actNode) + "\r\r");
			break;
			
		// Slave Market
		case 2505:
			ServantSpeak(Language.GetHtml("Description", currentCity.FindPlaceNodeCByName("SlaveMarket")));
			break;
			
		// Armoury
		case 2506:
			ServantSpeakStart(Language.GetHtml("ArmouryDescription", actNode));
			if (SMData.GuildMember) {
				BlankLine();
				ServantSpeakEnd(Language.GetHtml("PersonalFundsOnly", "Shopping"));
			} else ServantSpeakEnd();
			break;

		// Dealer
		case 2507:
			ServantSpeak(Language.GetHtml("DealerDescription", actNode));
			break;

		// Item Salesman
		case 2508:
			ServantSpeak(Language.GetHtml("ItemSalesmanDescription", actNode));
			break;
			
		// rest
		case 2511:
			ServantSpeak(Language.GetHtml("BreakSM", actNode));
			break;
			
		// Special (Feeding etc)
		case 2515:
			if (SMAdvantages.CheckBitFlag(13)) SetText(Language.GetHtml("FeedingDescription", actNode) + "\r\r");
			break;
			
		// custom - OBSOLETE
		case 2516:
			ServantSpeak(SMCustomTrainingDescription);
			break;		
			
		// talk to slaves
		case 2517:
			ServantSpeak(Language.GetHtml("SlavesDiscussDescription", actNode));
			break;		

		// custom
		default:
			if (DaysUnavailable != 0 && (acti.Type != 4 && acti.Type != 10)) {
				XMLData.XMLGeneral("Planning/SlaveUnwell", true);
				Bloop();
				return;
			}
			var act:ActInfo = slaveData.ActInfoBase.GetActAbs(type);
			ServantSpeak(act.Description);
			break;
		}
	}
	AddText("\r");
	modulesList.AfterNewPlanningAction(ActionChoice, available);
	if (MorningEveningMenu._visible == false && SlaveDiscussion._visible == false) Quitter._visible = true;
	else if (hint == false && SlaveDiscussion._visible) Quitter._visible = false;
	if (hint == false && AskQuestions._visible == false && VisitMenu._visible == false && YesEvent._visible == false) DoNewPlanningYes();
}


function NewPlanningActionChoresSchools(type:Number, hint:Boolean) : Boolean
{
	switch (type) {
		// Cooking
		//	1001	- normal training
		//	1001.1 	- trained by a tutor
		//	1002.2	- trained by Haro (minor slave)
		//	1002.3	- trained by Sana (minor slave)
		//	1001.4 	- clean as she can (but she is at max cleaning)
		case 1001:
			UpdateFactors();
			var cookinc:Number = Home.hKitchen + 3;
			cookinc = cookinc * CookingFactor;
			if ((MaxCooking < AssistantMaxCooking) && ((VarCooking + cookinc) > MaxCooking)) {
				if (SMData.IsAnySlaveTrainedAs("Maid")) {
					ServantSpeak(Language.GetHtml("CookingTutoredSlave", actNode));
					if (SMData.IsSlaveOwned("Haro")) {
						var sd:Slave = SMData.GetSlaveDetails("Haro", true);
						PersonName = sd.SlaveName;
						AddQuestion(9002, Language.GetHtml("CookingTutoredWho", actNode));
					}
					if (SMData.IsSlaveOwned("Sana")) {
						var sd:Slave = SMData.GetSlaveDetails("Sana", true);
						PersonName = sd.SlaveName;
						AddQuestion(9003, Language.GetHtml("CookingTutoredWho", actNode));
					}
					if (hint) break;
					AddQuestion(9000, Language.GetHtml("CookingAsKnows", actNode));
					AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
					ShowQuestions(Language.GetHtml("CookingQuestions", actNode));
					break;
				} else if ((SMData.SMGold + VarGold) >= 25) {
					ServantSpeak(Language.GetHtml("CookingTutored", actNode));
					AskHerQuestions(9001, 9004, 9008, 0, Language.GetHtml("HireTutor", "Planning"), Language.GetHtml("CookingAsKnows", actNode), Language.GetHtml("ForgetIt", "Participants"), "", Language.GetHtml("WhatWillYouDo", "Participants"));
					break;
				} else ServantSpeak(Language.GetHtml("CookingNoMoneyTutor", actNode));
			} else ServantSpeak(Language.GetHtml("CookingDescription", actNode));
			break;
			
		// Cleaning
		//	1002	- normal training
		//	1002.1 	- trained by a tutor
		//	1002.2	- trained by Haro (minor slave)
		//	1002.3	- trained by Sana (minor slave)
		//	1002.4	- clean as she can (but she is at max cleaning)
		case 1002:
			UpdateFactors();
			var cleaninc:Number = Home.hKitchen + 3;
			cleaninc = cleaninc * CleaningFactor;
    		if ((MaxCleaning < AssistantMaxCleaning) && ((VarCleaning + cleaninc) > MaxCleaning)) {
				if (SMData.IsAnySlaveTrainedAs("Maid")) {
					ServantSpeak(Language.GetHtml("CleaningTutoredSlave", actNode));
					if (SMData.IsSlaveOwned("Haro")) {
						var sd:Slave = SMData.GetSlaveDetails("Haro", true);
						PersonName = sd.SlaveName;
						AddQuestion(9002, Language.GetHtml("CookingTutoredWho", actNode));
					}
					if (SMData.IsSlaveOwned("Sana")) {
						var sd:Slave = SMData.GetSlaveDetails("Sana", true);
						PersonName = sd.SlaveName;
						AddQuestion(9003, Language.GetHtml("CookingTutoredWho", actNode));
					}
					AddQuestion(9004, Language.GetHtml("CleaningAsKnows", actNode));
					AddQuestion(9008, Language.GetHtml("ForgetIt", "Participants"));
					ShowQuestions(Language.GetHtml("CleaningQuestions", actNode));
					break;
				} else if ((SMData.SMGold + VarGold) >= 25) {
					ServantSpeak(NameCase(SlaveHeSheIs) + " very skilled at cleaning and management. Just having #slavehimher clean the house will not train #slavehimher anymore. " + ServnantPronoun + " can hire a tutor to teach #slavehimher for 25" + GP + ".");
					AskHerQuestions(9001, 9000, 9008, 0, Language.GetHtml("HireTutor", "Planning"), Language.GetHtml("CleaningAsKnows", actNode), Language.GetHtml("ForgetIt", "Participants"), "", Language.GetHtml("WhatWillYouDo", "Planning"));
					break;
				} else ServantSpeak(Language.GetHtml("CleaningNoMoneyTutor", actNode));
			} else ServantSpeak(Language.GetHtml("CleaningDescription", actNode));
			break;
			
		// Exercise
		case 1003:
			if (IsPonygirl()) {
				ServantSpeak(Language.GetHtml("RideDescription", actNode));
			} else {
				if (SuperviseYourself) ServantSpeak(Language.GetHtml("FitnessDescriptionSM", actNode));
				else ServantSpeak(Language.GetHtml("FitnessDescriptionAss", actNode));
			}
			break;
			
		// Discuss
		case 1004:
    		ServantSpeak(Language.GetHtml("DiscussDescription", actNode));
			break;
			
		// Make Up
		case 1005:
			if (IsPonygirl()) {
				ServantSpeak(Language.GetHtml("GroomingDescription", actNode));
			} else {
				if (SlaveFemale || BitFlag1.CheckBitFlag(62)) ServantSpeak(Language.GetHtml("MakeUpDescriptionFemale", actNode));
				else ServantSpeak(Language.GetHtml("MakeUpDescriptionMale", actNode));
			}
			break;
			
		// School - Science
		case 1006:
			if (!hint && (Plannings.PlanningTime % 2) != 0) {
				ServantSpeak(Language.GetHtml("SciencesHours", actNode));
				Bloop();
				return true;
			}
    		ServantSpeak(Language.GetHtml("SciencesDescription", actNode));
			break;
			
		// School - Theology
		case 1007:
			if (!hint && (Plannings.PlanningTime % 2) != 0) {
				ServantSpeak(Language.GetHtml("TheologyHours", actNode));
				Bloop();
				return true;
			}
			if (SMData.SMFaith == 2 && !SMAdvantages.CheckBitFlag(15)) {
				ServantSpeak(Language.GetHtml("TheologyDescriptionOld", actNode));
			} else {
				ServantSpeak(Language.GetHtml("TheologyDescriptionNew", actNode)); 
			}
			break;
			
		// School - Etiquette
		case 1008:
			if (!hint && (Plannings.PlanningTime % 2) != 0) {
				ServantSpeak(Language.GetHtml("EtiquetteHours", actNode));
				Bloop();
				return true;
			}
			ServantSpeak(Language.GetHtml("EtiquetteDescription", actNode));
			break;
			
		// School - Dance
		case 1009:
			if (!hint && (Plannings.PlanningTime % 2) != 0) {
				ServantSpeak(Language.GetHtml("DanceHours", actNode));
				Bloop();
				return true;
			}
			if (IsPonygirl()) ServantSpeak(Language.GetHtml("PrancingDescription", actNode));
    		else ServantSpeak(Language.GetHtml("DanceDescription", actNode));
			
			if (hint || Participants.length != 0) return false;
			var nDancers:Number = SMData.GetTotalSlavesTrainedAs("Dancer", "Tutor");
			if (nDancers == 0) return false;
			
			if (nDancers == 1) {
				sdDancer = SMData.GetAnySlaveTrainedAs("Dancer", "Tutor");
				SMData.GetSlaveInformation(sdDancer);
				AddQuestion(9030, "#person", undefined, sdDancer);
				AddText("\r\r#person is the only person who can assist in tutoring #slave at the dance school.");
			} else {
				AddText("\r\rYou can have one of your slaves assist in tutoring #slave at the dance school");
				AddQuestion(9098, Language.GetHtml("PickTutor", "Participants", true));
			}
			AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
			ShowQuestions(Language.GetHtml("WhoWillTutor", "Planning"));
			break;
			
		// School - XXX
		case 1010:
    		ServantSpeak(Language.strReplaceValue(Language.GetHtml("XXXSchoolDescription", actNode), GetActCost(type)));
			break;
			
		// Expose
		case 1011:
			if (!hint && Naked) {
				ServantSpeak(Language.GetHtml("ExposeNaked", "Planning"));
				Bloop();
				return true;
			}
			if (SuperviseYourself) ServantSpeak(Language.GetHtml("ExposeDescriptionPersonal", actNode));
			else ServantSpeak(Language.GetHtml("ExposeDescription", actNode));
			break;
			
		// Job - Restaurant
		// 1012.1 - Waiter/Waitress
		// 1012.2 - Chef
		case 1012:
			if (BitFlag1.CheckBitFlag(33)) {
				if (Naked) {
					ActionChoice = 1012.1;
					ServantSpeak(Language.GetHtml(SlaveMale ? "NakedMaleChef" : "NakedFemaleChef", actNode));
					break;
				}
			}
			if (BitFlag1.CheckBitFlag(32)) {
				if (!hint) {
					AddQuestion(9001, SlaveFemale ? Language.GetHtml("RestaurantJobWaitressQuestion", actNode) : Language.GetHtml("RestaurantJobWaiterQuestion", actNode));
					AddQuestion(9002, Language.GetHtml("RestaurantJobChefQuestion", actNode));
					ShowQuestions(Language.GetHtml("RestaurantQuestion", actNode));
				}
			} else {
				ActionChoice = 1012.1;
				ServantSpeak(Language.GetHtml(SlaveMale ? "RestaurantJobWaiter" : "RestaurantJobWaitress", actNode));
			}
			break;
			
		// Job - Acolyte
		case 1013:
			if (!hint && SMData.SMFaith == 2 && !SMAdvantages.CheckBitFlag(15)) {
				PersonSpeak(24, Language.GetHtml("NoOldFaith", "Planning"));
				Bloop();
				return true;
			} else {
				ServantSpeak(Language.GetHtml("AcolyteDescription", actNode));
			}
			break;
			
		// Job - Bar
		case 1014:
    		//"#slave will go and work in a bar, mainly preparing drinks and counter lunches, but also chatting with the customers and entertaining them (but not 'entertaining' them)."
			ServantSpeak(Language.GetHtml("BarDescription", actNode));
			break;
			
		// Job - Sleazy Bar
		case 1015:
			if (!hint && Plannings.PlanningTime > 6 && Plannings.PlanningTime < 12) {
				ServantSpeak(Language.GetHtml("SleazyBarHours", "Planning"));
				Bloop();
				return true;
			}
    		ServantSpeak(Language.GetHtml("SleazyBarDescription", actNode));
			break;
			
		// Job - Brothel
		case 1016:
			ServantSpeak(Language.GetHtml("BrothelDescription", actNode));
			break;
			
		// Break
		case 1017:
			//"A little break will make #slavehimher less tired."
			ServantSpeak(Language.GetHtml("BreakDescription", actNode));
			if (!hint && (Plannings.PlanningTime + 2) <= Plannings.EndPlanningTime) {
				AskHerQuestions(9000, 9001.1, 9010, 9099, Language.GetHtml("BreakTime1", actNode), Language.GetHtml("BreakTime2", actNode), Day ? "The rest of the day" : "The rest of the night", Language.GetHtml("ForgetIt", "Participants"), Language.GetHtml("BreakQuestion", actNode));
			}
			return false;
						
		// Read a Book
		// 1019.1 = general knowedge book
		// 1019.2 = peotry book
		// 1019.3 = scroll (custom per girl)
		// 1019.4 = scriptures
		// 1019.5 = kamasutra
		// 1019.6 = ladies guide
		// 1019.7 = historical guide
		case 1019:
			var totbk:Number = SMData.TotalBooks + SMData.TotalPoetry + TotalScripture + TotalKamasutra + TotalScrolls;
			for (i = 0; i < 32; i++) {
				if (SMData.OtherBooks.CheckBitFlag(i)) totbk++;
			}
			if (!hint && totbk == 0) {
				ServantSpeak(Language.GetHtml("ReadNoBooks", actNode));
				Bloop();
				return true;
			} else if (!hint && PlanningChores.ReadButton.NotAvailable._visible) {
				ServantSpeak(Language.GetHtml("ReadAllBooks", actNode));
				Bloop();
				return true;
			} else {
				if (hint) {
					ServantSpeak(Language.GetHtml("ReadABookHint", actNode));
					break;
				}
				ActionChoice = 1019;
				if (TotalScrolls > TotalScrollsRead) AddQuestion(9003, Language.GetHtml("Scroll", "Equipment"));
				if (TotalScripture > TotalScriptureRead) AddQuestion(9004, Language.GetHtml("ScriptureBook", "Equipment"));
				if (TotalKamasutra > TotalKamasutraRead) AddQuestion(9005, Language.GetHtml("KamasutraBook", "Equipment"));
				if ((SMData.TotalBooks * 2) > TotalBooksRead) AddQuestion(9001, Language.GetHtml("Book", "Equipment"));
				if ((SMData.TotalPoetry * 2) > TotalPoetryRead) AddQuestion(9002, Language.GetHtml("PoetryBook", "Equipment"));
				if (SMData.OtherBooks.CheckBitFlag(0) && !SMData.OtherBooks.CheckBitFlag(32)) AddQuestion(9006, Language.GetHtml("LadiesGuide", "Equipment"));
				if (SMData.OtherBooks.CheckBitFlag(1) && !SMData.OtherBooks.CheckBitFlag(33)) AddQuestion(9007, Language.GetHtml("HistoricalTales", "Equipment"));
				if (SMData.OtherBooks.CheckBitFlag(2) && !SMData.OtherBooks.CheckBitFlag(34)) AddQuestion(9008, Language.GetHtml("MasculineLove1", "Equipment"));
				if (SMData.OtherBooks.CheckBitFlag(3) && !SMData.OtherBooks.CheckBitFlag(35)) AddQuestion(9009, Language.GetHtml("MasculineLove2", "Equipment"));
		
				if (EvChoice2 == 0){
					genString = AskQuestions.Question1Text.text.substr(3).toLowerCase();
					ServantSpeak(Language.GetHtml("ReadDescriptionOneBook", actNode));
					ActionChoice = 1019 + ((EvChoice1 - 9000) / 10);
				} else {
					ServantSpeak(Language.GetHtml("ReadDescription", actNode));
					AddQuestion(9099, Language.GetHtml("ForgetIt", "Participants"));
					ShowQuestions(Language.GetHtml("ReadABookQuestion", actNode));
				}
			}
			break;
						
		// Job - Library
		case 1022:
			if (!hint && Plannings.PlanningTime < 8 || Plannings.PlanningTime > 20) {
				ServantSpeak(Language.GetHtml("LibraryHours", "Planning"));
				Bloop();
				return true;
			}
		    //"#slave will work in the library, assisting the librarians."
			ServantSpeak(Language.GetHtml("LibraryDescription", actNode));
			break;
			
		// Job - Onsen
		case 1023:
		   //"#slave will work in a hotspring resort, or Onsen. Mainly cleaning and sometimes helping to wash some customers.\r\rSome customers expect 'other' forms of service and will reward #slavehimher for such 'help'."
			ServantSpeak(Language.GetHtml("OnsenDescription", actNode));
			break;
						
		// Talk A Walk
		case 1030:
			if (SuperviseYourself) Language.SetLangText("TakeAWalkSMDescription", actNode);
			else Language.SetLangText("TakeAWalkServantDescription", actNode);
			break;
			
		// Cock Milking
		case 1031:
			//	"You will take #slave to Astrid's to be milked while you are also milked. Milked of your cum mainly..."
			ServantSpeak(Language.GetHtml("CockMilkingDescription", actNode));
			break;

		// School - Singing
		case 1032:
    		ServantSpeak(Language.strReplaceValue(Language.GetHtml("SingingDescription", actNode), GetActCost(type)));
			break;
			
		// custom
		default:
			if (DaysUnavailable != 0) {
				XMLData.XMLGeneral("Planning/SlaveUnwell", true);
				Bloop();
				return;
			}		
			var act:ActInfo = slaveData.ActInfoBase.GetActAbs(type);
			ServantSpeak(act.Description);
			break;
			
	}
	return false;
}
