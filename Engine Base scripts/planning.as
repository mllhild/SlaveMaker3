import Scripts.Classes.*;

// Planning

var Plannings:PlanningList = new PlanningList(_root);
var SavedDayPlannings1:PlanningList = new PlanningList(_root);
var SavedDayPlannings2:PlanningList = new PlanningList(_root);
var SavedDayPlannings3:PlanningList = new PlanningList(_root);
var SavedNightPlannings1:PlanningList = new PlanningList(_root);
var SavedNightPlannings2:PlanningList = new PlanningList(_root);
var SavedNightPlannings3:PlanningList = new PlanningList(_root);
var planActs:PlannableActions = new PlannableActions(_root);

var PlanningSet:Number = 1;

var Action:Number;
var LastActionDone:Number;
var PreviousActionDone:Number;
var SexAction:Number;
var LastActionRefused:Number;
var LastActionStartTime:Number;
var LastActionEndTime:Number;
var LastActionDuration:Number;
var ReluctanceLevel:Number;
var ActLevel:Number;

var FirstTimeTodayBrothel:Boolean;
var FirstTimeTodayAcolyte:Boolean;
var FirstTimeTodaySleazyBar:Boolean;
var FirstTimeTodayDiscuss:Boolean;
var FirstTimeTodayBreak:Boolean;
var FirstTimeTodayTheology:Boolean;
var FirstTimeTodayRestaurant:Boolean;
var FirstTimeTodayBar:Boolean;
var FirstTimeTodaySciences:Boolean;
var FirstTimeTodaySinging:Boolean;
var FirstTimeTodaySwimming:Boolean;
var FirstTimeTodayDance:Boolean;
var FirstTimeTodayRefinement:Boolean;
var FirstTimeTodayExercise:Boolean;
var FirstTimeTodayXXX:Boolean;
var FirstTimeTodayCooking:Boolean;
var FirstTimeTodayCleaning:Boolean;
var FirstTimeTodayExpose:Boolean;
var FirstTimeTodayMakeup:Boolean;
var FirstTimeTodayCustomJob1:Boolean;
var FirstTimeTodayCustomJob2:Boolean;
var FirstTimeTodayCustomJob3:Boolean;
var FirstTimeTodayLibrary:Boolean;
var FirstTimeTodayOnsen:Boolean;
var FirstTimeTodayCockMilking:Boolean;
var FirstTimeTodayCustomChore1:Boolean;
var FirstTimeTodayCustomChore2:Boolean;
var FirstTimeTodayCustomChore3:Boolean;
var FirstTimeTodayCustomSchool1:Boolean;
var FirstTimeTodayCustomSchool2:Boolean;
var FirstTimeTodayCustomSchool3:Boolean;
var FirstTimeTodaySMJob:Boolean;
var FirstTimeToday:Boolean;
var TotalBondageToday:Number;
var TotalBlowJobToday:Number;
var TotalAnalToday:Number;

// Buttons
PlanningPage.tabChildren = true;
PlanningPage.DayNightText.styleSheet = Language.styles;

NextGeneral.Btn.tabChildren = true;
NextGeneral.Btn.onPress = DoPlanningNext;

PlanningButton.tabChildren = true;
PlanningButton.Btn.onPress = DoPlanningButton;


// Functions

function InitialisePlanningCommon()
{
	Plannings.slaveData = slaveData;
	Supervise = ServantName == "";
	GetServantAB();
	GetSlaveAB();
	if (!IsSexPlanningTime()) { // 1800
		Plannings.EndPlanningTime = Day ? 18 : 30;		// 30 = midnight + 6 hrs
	} else {
		Plannings.EndPlanningTime = Day ? 12 : 24;    // midday, or midnight
		if (VarConstitutionRounded > 40) Plannings.EndPlanningTime++;
		if (VarConstitutionRounded > 149)  Plannings.EndPlanningTime++;
	}
	if (SMData.DaysUnavailable != 0) UpdateSupervision(false);
	else if (AssistantData.DaysUnavailable != 0) UpdateSupervision(true);
	if (DaysUnavailable != 0) {
		oldplantab = 6;
		plantab = 6;
	}
}

function InitialisePlanning(hints:Boolean)
{
	HideSlaveActions();
	HideStatChangeIcons();
	HideImages();
	Sounds.StopAndFadeSounds();
	HideDresses();
	HideMenus();
	SelectEquipment.Hide();
	SelectSMEquipment.Hide();
	HideBackgrounds();
	Items.HideItems();
	HideMainButtons();
	HideEquipmentButton();
	HideSMEquipmentButton();
	PlanningSelections.ClearButton._visible = true;
	NextEvent._visible = false;
	PlanningSelections.Set1._visible = true;
	PlanningSelections.Set2._visible = true;
	PlanningSelections.Set3._visible = true;
	PlanningSelections.LSMAction._visible = true;
	PlanningSelections.LSelections.htmlText = Language.GetHtml("PlanningSelections", "Planning");
	HidePlanningNext();
	HidePeople();
	UpdatePlanningSet();
	
	InitialisePlanningCommon();
	
	if (Day) { 
	
		PlanningSelections.ParticipantsBtn._visible = true;
		if (SMAdvantages.CheckBitFlag(4) || SMData.SMSkills.CheckBitFlag(8)) ShowAct(1017, Day);
		else ShowAct(1017);
		slaveData.ActInfoBase.GetActRO(type).ShowAct(showact)
		
		PlanningSelections.ChkSameListDay._visible = true;
		PlanningSelections.ChkSameListNight._visible = false;
		Backgrounds.ShowSky(3);
		PlanningPage.DayNightText.htmlText = Language.GetHtml("Daytime", "Planning", true, -1);
		if (hints != false) {
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(39)) Information.ShowTutorialLang("DayPlanning", DoPlanningButton2);
			else DoPlanningButton2();
		} else DoPlanningButton2();
		
	} else {
		
		PlanningSelections.ParticipantsBtn._visible = true;
		if (SMAdvantages.CheckBitFlag(4) || SMData.SMSkills.CheckBitFlag(8)) ShowAct(1017, Day);
		else ShowAct(1017);
		PlanningSelections.ChkSameListDay._visible = false;
		PlanningSelections.ChkSameListNight._visible = true;
		Backgrounds.ShowNight();
		PlanningPage.DayNightText.htmlText = Language.GetHtml("Nighttime", "Planning", true, -1);
		PlanningPage.SexNormalButton._visible = true;
		PlanningPage.SexExtremeButton._visible = true;
		if (hints != false) {
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(38)) Information.ShowTutorialLang("NightPlanning", DoPlanningButton2);
			else DoPlanningButton2();
		} else DoPlanningButton2();
		
	}
}

// Planning Button
function DoPlanningButton()
{
	InitialisePlanning(true);
	Beep();
}

function DoPlanningButton2()
{
	SetText("");
	Supervise = ServantName == "";
	Information.HideInformation();
	UpdateSlave();
	Plannings.RedrawPlanningList();
	
	if (Plannings.IsNewPlanning()) {
		ShowPlanningTab();
		return;
	}
	
	if (DaysUnavailable != 0) PlanningSelections.ChkSameListDay.selected = false;
	if (Day) {
		AddTime(1);
		Plannings.NewPlanning();
		
		if (PlanningSelections.ChkSameListDay.selected && DaysUnavailable == 0) {
			switch (PlanningSet) {
				case 1: Plannings.LoadActions(SavedDayPlannings1, false); break;
				case 2: Plannings.LoadActions(SavedDayPlannings2, false); break;
				case 3: Plannings.LoadActions(SavedDayPlannings3, false); break;
			}
		}
	} else {
		AddTime(2);
		Plannings.NewPlanning();
		
		if (PlanningSelections.ChkSameListNight.selected && DaysUnavailable == 0) {
			switch (PlanningSet) {
				case 1: Plannings.LoadActions(SavedNightPlannings1, false); break;
				case 2: Plannings.LoadActions(SavedNightPlannings2, false); break;
				case 3: Plannings.LoadActions(SavedNightPlannings3, false); break;
			}
		}
	}

	// Form here the terms DAy/Night refer to 
	// Day = chores/jobs/visits type trainings
	// Night = sex trainings
		
	if (!IsSexPlanningTime()) {
		if (DaysUnavailable != 0) {
			oldplantab = 6;
			plantab = 6;
		} else oldplantab = 0;
		
		var tired:Boolean = VarFatigue > (59 + FatigueBonus);
		if (DaysUnavailable == 0 && tired) {
			Plannings.AddDayNightAction(1017.01, false);
			if (VarFatigue > (80 + FatigueBonus)) Plannings.AddDayNightAction(1017.01, false);
			PlanningSelections.ChkSameListDay.selected = false;
		}
		
		
		if (DaysUnavailable == 0 && tired) {
			if (VarFatigue > (80 + FatigueBonus)) say = Language.GetHtml("ExhaustedDescriptionTwice", "Planning");
			else say = Language.GetHtml("ExhaustedDescriptionOnce", "Planning");
			Information.ShowInformation(Language.GetHtml("ExhaustedTitle", "Planning"), UpdateMacros(say), ShowPlanningTab);
		} else ShowPlanningTab();
		
		modulesList.StartDay();
		
	} else {
		
		if (DaysUnavailable != 0) {
			DoEvent(9901);
			XMLData.XMLGeneral("Planning/SlaveUnwellNight", true);
			return;
		}
		
		// Unnatural Cum BJ
		if (SMAdvantages.CheckBitFlag(6)) {
			if (int(Plannings.arPlanningArray[0].SlaveAction) != 5 && int(Plannings.arPlanningArray[0].SlaveAction) != 4) {
				var arPeopleForAct:Array = new Array();
				arPeopleForAct.push(-100);
				if (Math.floor(Math.random()*2) == 1) Plannings.AddDayNightAction(5, false, arPeopleForAct);
				else Plannings.AddDayNightAction(4, false, arPeopleForAct);
				delete arPeopleForAct;
			}
		}
		// Demonic cock
		if (SMData.SMSpecialEvent == 5) {
			if (Plannings.arPlanningArray[0].SlaveAction != 7) {
				var arPeopleForAct:Array = new Array();
				arPeopleForAct.push(-100);
				Plannings.AddDayNightAction(7, false, arPeopleForAct);
				delete arPeopleForAct;
			}
		}
		// dickgirl dominatrix bj
		if (SMData.IsDominatrix() && SMData.Gender != 2) {
			if (Plannings.arPlanningArray[0].SlaveAction != 5) {
				var arPeopleForAct:Array = new Array();
				arPeopleForAct.push(-100);
				Plannings.AddDayNightAction(5, false, arPeopleForAct);
				delete arPeopleForAct;
			}
		}
	
		if (!modulesList.StartNight(true)) XMLData.XMLGeneral("Assistant/StartNightMessage", true);
		BlankLine();
		AddText(Language.strReplace(Language.GetHtml("PlanningDuration", "Planning"), "#value", DecodeTime(Plannings.EndPlanningTime)));
		
		// set bondage action for ponyslave
		if (IsPonygirl()) {
			if (Plannings.GetActionsCount() == 0) Plannings.AddDayNightAction(12, false);
			else {
				if (Plannings.arPlanningArray[0].SlaveAction != 12 && Plannings.arPlanningArray[1].SlaveAction != 12) Plannings.AddDayNightAction(12, false);
			}
			BlankLine();
			Language.AddLangText("BondageSet", "Planning");
		}
		ServantSpeakEnd(".");
		var badd:Boolean = false;
		if (SMData.IsDominatrix() && SMData.Gender != 2) {
			AddText("\r");
			Language.AddLangText("UnnaturalCumBJMale", "SlaveMaker");
			badd = true;
		} else if (SMAdvantages.CheckBitFlag(6)) {
			// Unnatural Cum BJ/Fuck 
			AddText("\r");
			if (SlaveFemale) Language.AddLangText("UnnaturalCumBJFemale", "SlaveMaker");
			else Language.AddLangText("UnnaturalCumBJMale", "SlaveMaker");
			badd = true;
		}
		// Demonic Cock
		if (SMData.SMSpecialEvent == 5) {
			if (!badd) AddText("\r");
			Language.AddLangText("DemonicCockAssFuck", "SlaveMaker");
		}

		if (DaysUnavailable != 0) {
			oldplantab = 6;
			plantab = 6;
		} else oldplantab = 4;
		ShowPlanningTab();
		
		modulesList.StartNight(false);
		
	}
	
	if (Day) 
	
	Hints.StopHints();
	PlanningSelections.Actions.invalidate();
}


// Planning Selections

var plantab:Number = 0;
var oldplantab:Number = 0;
var planpage:Number = 0;

PlanningSelections.tabChildren = true;
PlanningSelections.Actions.tabEnabled = false;
PlanningSelections.Actions.setStyle("borderStyle", "none");

PlanningSelections.ClearButton.tabChildren = true;
PlanningSelections.ClearButton.Btn.onPress = function() { ClearPlanningSelections(); }

function ClearPlanningSelections()
{
	Beep();
	if (plantab == -1) {
		PlanningOrders.Reset(slaveData, 8);
		ShowPlanningPage();
		return;
	}
	Plannings.ClearPlannings();
	if (DaysUnavailable != 0) ShowPlanningTab(6);
	else if (Day) ShowPlanningTab(0);
	else ShowPlanningTab();
}


// Planning Set

function UpdatePlanningSet(pset:Number)
{
	if (pset != undefined) {
		if (DaysUnavailable != 0) {
			Bloop();
			return;
		}
		if (pset > 3) pset = 1;
		else if (pset < 1) pset = 3;
		PlanningSet = pset;
		ClearPlanningSelections();
		if (Day) {
			switch (PlanningSet) {
				case 1: Plannings.LoadActions(SavedDayPlannings1, false); break;
				case 2: Plannings.LoadActions(SavedDayPlannings2, false); break;
				case 3: Plannings.LoadActions(SavedDayPlannings3, false); break;
			}
		} else {
			switch (PlanningSet) {
				case 1: Plannings.LoadActions(SavedNightPlannings1, false); break;
				case 2: Plannings.LoadActions(SavedNightPlannings2, false); break;
				case 3: Plannings.LoadActions(SavedNightPlannings3, false); break;
			}
		}
	}
	PlanningSelections.Set1._alpha = 30
	PlanningSelections.Set2._alpha = 30
	PlanningSelections.Set3._alpha = 30
	switch(PlanningSet) {
		case 1: PlanningSelections.Set1._alpha = 100; break;
		case 2: PlanningSelections.Set2._alpha = 100; break;
		case 3: PlanningSelections.Set3._alpha = 100; break;
	}
}

PlanningSelections.Set1.Btn.tabChildren = true;
PlanningSelections.Set2.Btn.tabChildren = true;
PlanningSelections.Set3.Btn.tabChildren = true;
PlanningSelections.Set1.Btn.onPress = function() { UpdatePlanningSet(1); }
PlanningSelections.Set2.Btn.onPress = function() { UpdatePlanningSet(2); }
PlanningSelections.Set3.Btn.onPress = function() { UpdatePlanningSet(3); }


// Planning Page

function ShowPlanningPosition()
{
	PlanningPage._visible = false;
	ShowPlanningTab();
}
function HidePlanningPosition()
{
	PlanningPage._visible = false;
}

function ShowPlanningTab(pos:Number)
{
	clearInterval(intervalId);
	Information.HideInformation();
	if (pos != undefined) plantab = pos;
	else plantab = oldplantab;
	planpage = 1;
	NextEvent._visible = false;
	
	if (plantab != -1) {
		UpdateSupervision();
		Quitter._x = 824;
		Quitter._visible = true;
		DoThePlanning._visible = true;
	}
	
	dspMain.UpdateGameTabs(4);
	
	var btabs:Boolean = plantab != -1;
	if (!IsNoAssistant()) btabs &= plantab != 6; 
	
	PlanningPage.SexNormalButton._visible = IsSexPlanningTime() && btabs;
	PlanningPage.SexExtremeButton._visible = IsSexPlanningTime() && btabs;
	PlanningPage.SlaveMakerButton._visible = IsNoAssistant() && btabs && !IsSexPlanningTime();
	if (IsNoAssistant() && !IsSexPlanningTime()) {
		PlanningPage.SexExtremeButton._x = 37.5;
		PlanningPage.SexExtremeButton._y = 30;
	} else {
		PlanningPage.SexExtremeButton._x = 112;
		PlanningPage.SexExtremeButton._y = 9.8;		
	}
	PlanningPage.JobsButton._visible = btabs;
	PlanningPage.ChoresButton._visible = btabs;
	PlanningPage.SchoolsButton._visible = btabs;
	PlanningPage.ShopsButton._visible = btabs;
	
	SetMovieColour(PlanningPage.JobsButton);
	SetMovieColour(PlanningPage.ChoresButton);
	SetMovieColour(PlanningPage.SchoolsButton);
	SetMovieColour(PlanningPage.ShopsButton);
	SetMovieColour(PlanningPage.SexNormalButton);
	SetMovieColour(PlanningPage.SexExtremeButton);
	SetMovieColour(PlanningPage.SlaveMakerButton);

	SetActButtonDetails();
	
	if (btabs && !IsSexPlanningTime()) oldplantab = plantab;
	else if (IsSexPlanningTime() && (plantab == 4 || plantab == 5)) oldplantab = plantab;
	
	// inline part of UpdateSlave()
	genNumber = plantab;
	modulesList.UpdateSlave();
	
	// change the buttons
	SlaveGirl.ChangeActButtons(plantab)
	CurrentAssistant.ChangeActButtonsAsAssistant(plantab);
	XMLData.XMLEventByNode(XMLData.cbNode);		// "ChangeActButtons"
	modulesList.ChangeActButtons(plantab);
	
	planActs.Reset();

	switch(plantab) {
		case 0: 
			planActs.SetPlanningJobs();
			PlanningPage.Title.htmlText = Language.GetHtml("JobsTitle", "Planning", true);
			SetMovieColour(PlanningPage.JobsButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(48)) Information.ShowTutorialLang("JobsPlanning", FocusJobs);
			else if (!Information.IsShown()) Selection.setFocus(PlanningPage.JobsButton);
			break;
		case 1: 
			planActs.SetPlanningChores();
			PlanningPage.Title.htmlText = Language.GetHtml("ChoresTitle", "Planning", true);
			SetMovieColour(PlanningPage.ChoresButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(47)) Information.ShowTutorialLang("ChoresPlanning");
			break;
		case 2: 
			planActs.SetPlanningSchools();
			PlanningPage.Title.htmlText = Language.GetHtml("SchoolsTitle", "Planning", true);
			SetMovieColour(PlanningPage.SchoolsButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			Selection.setFocus(PlanningPage.SchoolsButton);
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(46)) Information.ShowTutorialLang("SchoolsPlanning");
			break;
		case 3: 
			planActs.SetPlanningShops();
			PlanningPage.Title.htmlText = Language.GetHtml("ShoppingTitle", "Planning", true);
			SetMovieColour(PlanningPage.ShopsButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			Selection.setFocus(PlanningPage.ShopsButton);
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(33)) Information.ShowTutorialLang("ShopsPlanning");
			break;
		case 4: 
			planActs.SetPlanningSexNormal();
			PlanningPage.Title.htmlText = Language.GetHtml("SexNormal", "Buttons", true);
			SetMovieColour(PlanningPage.SexNormalButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			Selection.setFocus(PlanningPage.SexNormalButton);
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(44)) Information.ShowTutorialLang("SexNormalPlanning");
			break;
		case 5:
			planActs.SetPlanningSexExtreme();
			PlanningPage.Title.htmlText = Language.GetHtml("SexExtreme", "Buttons", true);
			SetMovieColour(PlanningPage.SexExtremeButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			Selection.setFocus(PlanningPage.SexExtremeButton);
			if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(43)) Information.ShowTutorialLang("SexExtremePlanning");
			break;
		case 6: 
			SetMovieColour(PlanningPage.SlaveMakerButton, 0, 0, 0, 0, 1.3, 1.3, 1.3);
			Selection.setFocus(PlanningPage.SlaveMakerButton);		
			PlanningPage.Title.htmlText = Language.GetHtml("SlaveMakerTitle", "Planning", true);
			planActs.SetPlanningSlaveMaker();
			break;
		case -1:
			planActs.SetPlanningOrders(sdata);
			break;
	}
		
	ShowPlanningPage();
}

function ShowPlanningPage(page:Number)
{
	if (page == undefined) page = planpage;
	
	len = planActs.GetCount();
	PlanningPage.Page1._visible = len > 6
	PlanningPage.Page2._visible = len > 6;
	PlanningPage.Page3._visible = len > 12;
	PlanningPage.Page4._visible = len > 18;
	PlanningPage.Page5._visible = len > 24;
	PlanningPage.Page1._y = plantab == 6 || plantab == -1 ? 0 : 20.5;
	PlanningPage.Page2._y = plantab == 6 || plantab == -1? 0 : 20.5;
	PlanningPage.Page3._y = plantab == 6 || plantab == -1 ? 0 : 20.5;
	PlanningPage.Page4._y = plantab == 6 || plantab == -1 ? 0 : 20.5;
	PlanningPage.Page5._y = plantab == 6 || plantab == -1 ? 0 : 20.5;

	PlanningPage._visible = true;
	PlanningPage.Act1._visible = false;
	PlanningPage.Act2._visible = false;
	PlanningPage.Act3._visible = false;
	PlanningPage.Act4._visible = false;
	PlanningPage.Act5._visible = false;
	PlanningPage.Act6._visible = false;
	PlanningPage.Act1.Title.htmlText = "";
	PlanningPage.Act2.Title.htmlText = "";
	PlanningPage.Act3.Title.htmlText = "";
	PlanningPage.Act4.Title.htmlText = "";
	PlanningPage.Act5.Title.htmlText = "";
	PlanningPage.Act6.Title.htmlText = "";
	PlanningPage.Act1.Description.htmlText = "";
	PlanningPage.Act2.Description.htmlText = "";
	PlanningPage.Act3.Description.htmlText = "";
	PlanningPage.Act4.Description.htmlText = "";
	PlanningPage.Act5.Description.htmlText = "";
	PlanningPage.Act6.Description.htmlText = "";
	SetMovieColour(PlanningPage.Page1);
	SetMovieColour(PlanningPage.Page2);
	SetMovieColour(PlanningPage.Page3);
	SetMovieColour(PlanningPage.Page4);
	SetMovieColour(PlanningPage.Page5);
	SetMovieColour(PlanningPage["Page" + page], 0, 0, 0, 0, 1.3, 1.3, 1.3);
	
	var len:Number = planActs.GetCount();
	if (len < ((page - 1) * 6) || len == 0) return;

	var act:ActInfo;
	var mc:MovieClip;
	
	var pidx:Number = 0;
	var idxs:Number = 0;
	var i:Number = 1;
	var cidx:Number = 1;
	
	// process all 6 rows of buttons of the page
	while (i < 7 && idxs < len) {
		act = planActs.GetAct(idxs);
		idxs++;
		cidx = 1;
		while (act != null && cidx < 6) {
			if (act.bShown && act.Name != "") {
				cidx++;
			}
			act = act.childAct;
		}
		if (cidx == 1 || pidx < ((page * 6) - 6)) {
			pidx++;
			continue;
		}
		
		// set acts
		act = planActs.GetAct(idxs - 1);
		mc = PlanningPage["Act" + i];
		
		mc.Button1._visible = false;
		mc.Button2._visible = false;
		mc.Button3._visible = false;
		mc.Button4._visible = false;
		mc.Button5._visible = false;
		mc.Button6._visible = false;
		mc.Button7._visible = false;
		mc.More1._visible = false;
		mc.More2._visible = false;
		mc.More3._visible = false;
		mc.More4._visible = false;
		mc.More5._visible = false;
		mc.More6._visible = false;
		
		cidx = 1;
		while (act != null && cidx < 8) {
			if (act.bShown && act.Name != "") {
				mc["Button" + cidx]._visible = true;
				if (act.PlanTitle != "") mc.Title.htmlText = "<b>" + act.PlanTitle + "</b>";
				else if (i == 1 && cidx == 1) mc.Title.htmlText = "<b>" + planActs.strLastTitle + "</b>";
				if (plantab == -1) SetButtonDetails(mc["Button" + cidx], act.Ticked, act.Available, act.Name, act.Act, act.Shortcut, act.Cost, act.Duration, act.StartTime, act.EndTime, "GiveOrder", "GiveOrderHint", "HideHints");
				else act.SetButtonFromAct(mc["Button" + cidx]);

				/*
				if (plantab == 4 || plantab == 5) {
					if (cidx == 2) mc.More1._visible = true;
					else if (cidx == 3) mc.More2._visible = true;
					else if (cidx == 4) mc.More3._visible = true;
					else if (cidx == 5) mc.More4._visible = true;
				}*/
				cidx++;
			}
			act = act.childAct;
		}
		
		mc._visible = true;
		i++;
	}

}

function PlanningActionsRight()
{
	if (PlanningSlaveMaker._visible) return;
	plantab++;
	if (PlanningPage.SexNormalButton._visible == false) {
		if (plantab > 3) {
			if (IsNoAssistant() && !IsSexPlanningTime()) plantab = plantab > 6 ? 0 : 6;
			else plantab = 0;
		}
	}
	if (plantab > 5) {
		if (!IsNoAssistant() || IsSexPlanningTime() || plantab > 6) plantab = 0;
	}
	if (Day) oldplantab = plantab;
	clearInterval(intervalId);
	intervalId = setInterval(_root, "ShowPlanningTab", 20, plantab);
}

function PlanningActionsLeft()
{
	if (PlanningSlaveMaker._visible) return;
	plantab--;
	if (plantab < 0) {
		if (IsNoAssistant() && !IsSexPlanningTime()) plantab = 6;
		else plantab = PlanningPage.SexNormalButton._visible ? 5 : 3;
	} else {
		if (plantab == 5 && !IsSexPlanningTime()) plantab = 3;
	}
	if (Day) oldplantab = plantab;
	clearInterval(intervalId);
	intervalId = setInterval(_root, "ShowPlanningTab", 20, plantab);
}

function PlanningPageUp()
{
	var len:Number = planActs.GetCount();
	planpage--;
	if (planpage < 0) {
		if (len < 6) planpage = 1;
		else planpage = int(len / 6) + 1;
	}
	ShowPlanningPage();
}

function PlanningPageDown()
{
	var len:Number = planActs.GetCount();
	planpage++;
	if (planpage > (int(len / 6) + 1)) planpage = 1;
	ShowPlanningPage();
}

function FocusJobs()
{
	Selection.setFocus(PlanningPage.JobsButton);
	Information.HideInformation();
}


PlanningPage.JobsButton.tabChildren = true;
PlanningPage.JobsButton.ActClassButton.onPress = function () {
	ShowPlanningTab(0);
}

PlanningPage.ChoresButton.tabChildren = true;
PlanningPage.ChoresButton.ActClassButton.onPress = function () {
	ShowPlanningTab(1);
}

PlanningPage.SchoolsButton.tabChildren = true;
PlanningPage.SchoolsButton.ActClassButton.onPress = function () {
	ShowPlanningTab(2);
}

PlanningPage.ShopsButton.tabChildren = true;
PlanningPage.ShopsButton.ActClassButton.onPress = function () {
	ShowPlanningTab(3);
}

PlanningPage.SexNormalButton.tabChildren = true;
PlanningPage.SexNormalButton.ActClassButton.onPress = function () {
	ShowPlanningTab(4);
}

PlanningPage.SexExtremeButton.tabChildren = true;
PlanningPage.SexExtremeButton.ActClassButton.onPress = function () {
	ShowPlanningTab(5);
}
PlanningPage.SlaveMakerButton.tabChildren = true;
PlanningPage.SlaveMakerButton.ActClassButton.onPress = function () {
	ShowPlanningTab(6);
}

PlanningPage.Page1.tabChildren = true;
PlanningPage.Page1.Btn.onPress = function () {
	ShowPlanningPage(1);
}
PlanningPage.Page2.tabChildren = true;
PlanningPage.Page2.Btn.onPress = function () {
	ShowPlanningPage(2);
}
PlanningPage.Page3.tabChildren = true;
PlanningPage.Page3.Btn.onPress = function () {
	ShowPlanningPage(3);
}
PlanningPage.Page4.tabChildren = true;
PlanningPage.Page4.Btn.onPress = function () {
	ShowPlanningPage(4);
}
PlanningPage.Page5.tabChildren = true;
PlanningPage.Page5.Btn.onPress = function () {
	ShowPlanningPage(5);
}


// Other functions

function DoNewPlanningYes()
{
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(ActionChoice);
	var atype:Number = act.Type;

	PlanningSelections.ParticipantsBtn._visible = false;
	if (ActionChoice == 2515 || ActionChoice == 10 || ActionChoice == 13 || (atype == 10 && ActionChoice != 2517)) {
		Plannings.StartPlanning();
		SlaveDiscussion._visible = false;
		SlaveStatus._visible = false;
		HideEquipmentButton();
		HideSMEquipmentButton();
		MorningEveningMenu._visible = false;
		HideMainButtons();
		HideDresses();
		Action = ActionChoice;
		LastActionStartTime = GameTime;
		LastActionEndTime = GameTime;
		DoActionNow();
	} else {
		if ((DonePony == 1 && (ActionChoice == 1003 || ActionChoice == 1005 || int(Math.abs(ActionChoice)) == 1017)) || ActionChoice == 1004 || (ActionChoice < 2000 && CurrentSuperviseYourself) || ActionChoice < 1000 || (ActionChoice > 2000 && ActionChoice < 2500)) ActionChoice = ActionChoice * -1;
		if (Math.abs(ActionChoice) < 1000 && Participants.length == 0) SetDefaultParticipants(ActionChoice);

		if (DaysUnavailable != 0) {
			var dur:Number = act.GetActDuration(ActionChoice);
			Plannings.AddDayNightAction(1017 + (dur * 0.01), false);
		}
		var dosm:Boolean = Plannings.AddDayNightAction(ActionChoice, false, Participants, DaysUnavailable != 0 ? false : undefined);
		if (SMData.DaysUnavailable != 0) dosm = false;
		else if (DaysUnavailable != 0) dosm = true;
		if (IsNoAssistant()) dosm = false;

		if (ActionChoice != -16) {
			if (!IsSexPlanningTime() && dosm) {
				oldplantab = plantab;
				if (Plannings.GetActionsCount() == 1) ServantSpeak(ServantMaster + Language.GetHtml("SlaveMakerTraining", assNode));
				ShowPlanningTab(6);	
				if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(49)) Information.ShowTutorialLang("SlaveMakerPlanning");
			} else ShowPlanningTab();
		}
	}
	modulesList.DoNewPlanningYes();
}

function StartPlanning()
{
	HideMenus();
	dspMain.HideStatChangeIcons();
	HideImages();
	Sounds.StopAndFadeSounds();
	dspMain.HideMainButtons();
	Beep();
	HideAllPeople();
	HideSlaveActions();
	HideYesNoButtons();
	SMData.CopySlaveMakerDetails(SMData, _root);
	HideEquipmentButton();
	HideSMEquipmentButton();
	DoThePlanning._visible = false;
	Quitter._visible = false;
	PlanninPage._visible = false;
	PlanningSelections.Set1._visible = false;
	PlanningSelections.Set2._visible = false;
	PlanningSelections.Set3._visible = false;
	PlanningSelections.ClearButton._visible = false;
	dspMain.SelectGameTab(1);
	if (Day) {
		if (PlanningSelections.ChkSameListDay.selected && LendPerson == 0 && DaysUnavailable == 0) {
			switch(PlanningSet) {
				case 1: SavedDayPlannings1.LoadFrom(Plannings); break;
				case 2: SavedDayPlannings2.LoadFrom(Plannings); break;
				case 3: SavedDayPlannings3.LoadFrom(Plannings); break;
			}
		}
	} else {
		if (PlanningSelections.ChkSameListNight.selected && LendPerson == 0 && DaysUnavailable == 0) {
			switch(PlanningSet) {
				case 1: SavedNightPlannings1.LoadFrom(Plannings); break;
				case 2: SavedNightPlannings2.LoadFrom(Plannings); break;
				case 3: SavedNightPlannings3.LoadFrom(Plannings); break;
			}
		}
	}
	PlanningSelections.ChkSameListDay._visible = false;
	PlanningSelections.ChkSameListNight._visible = false;
	Plannings.StartPlanning();
	if (LendPerson == 0 && slaveData.ActInfoBase.IsActVisible(1017) && ((Plannings.PlanningTime + 0.6) < Plannings.EndPlanningTime)) Plannings.AddDayNightAction(1017 + ((Plannings.EndPlanningTime - Plannings.PlanningTime - 1) * 0.01));
	LastActionStartTime = GameTime;
	LastActionEndTime = GameTime;
	if (Plannings.GetActionsCount() == 0) DoPlanningNext();
	else {
		if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(34)) Information.ShowTutorialLang("Planning", DoPlanningAction);
		else DoPlanningAction();
	}
}

DoThePlanning.tabChildren = true;
DoThePlanning.Btn.onPress = StartPlanning;


function DoActionNow()
{
	Beep();
	HidePlanningNext();
	ResetQuestions();
	tempstr = "";
	LastActionDone = Math.abs(Action);
	DickgirlChangable = DickgirlXF == 0 && HasCock == false && Math.random()*100 < DickgirlRate;
	DickgirlChanged = false;
	WalkPlace = 0;
	EventTotal = GetActTotal(LastActionDone);
	StandardDGText = true;
	StandardCSText = true;
	AppendActText = true;
	bAllowEvents = true;
	StandardPlugText = PlugInserted == 1;
	Catgirls.CatgirlEvents = true;
	ByYou = true;
	LevelUp = false;
	ActLevel = GetLastSexActLevel(Action);
	SetText("");
	GetServantAB();
	GetSlaveAB();
	
	var iAction:Number = int(LastActionDone);
	var act:ActInfo = slaveData.ActInfoBase.GetAct(iAction);
	FirstTimeToday = act.FirstTimeToday;

	Supervise = Action < 1000 || Action > 2500 || act.Type == 8 || act.Type == 5 || act.Type == 6 || act.Type == 10 || ServantName == "";
	UpdateSlaveGenderText();
	if (ShowSupervisor()) {
		PersonIndex = -100;
		SupervisorGivenName = SMData.SlaveMakerName;
		SupervisorName = "you";
		SupervisorHimHer = SlaveMakerHimHer;
		SupervisorHeShe = SlaveMakerHeShe;
		SupervisorHisHer = SlaveMakerHisHer;
		if (Day) ActualSecurity += LastActionDuration / 2;
	} else {
		PersonIndex = -99;
		SupervisorGivenName = ServantName;
		SupervisorName = ServantName;
		SupervisorHimHer = ServantHimHer;
		SupervisorHeShe = ServantHeShe;
		SupervisorHisHer = ServantHisHer;
	}
	
	OtherSlaveShown = false;		// TODO: not needed?
	if (iAction > 2500 && iAction < 2700) dspMain.SelectGameTab(3);
	else dspMain.SelectGameTab(1);
	
	if (iAction < 1000) {
		Backgrounds.ShowBedRoom();
		SexAction = LastActionDone;
		CountParticipantGenders(Participants);
		LevelUp = GetCurrentSexActLevel(iAction) > GetLastSexActLevel(iAction);
	} else {
		Backgrounds.ShowSky();
		totmales = 0;
		totfemales = 0;
		totdickgirls = 0;
	}
	Lesbian = modulesList.trainLesbians.IsTrainingEvent(LastActionDone);
	ReluctanceLevel = modulesList.trainLesbians.GetReluctanceLevel();
	//SMTRACE("Lesbian = " + Lesbian);
	SlaveGirl.Lesbian = Lesbian;
	//SMTRACE("ReluctanceLevel = " + ReluctanceLevel);

	UseGeneric = Generic.SetUseGeneric();
	FirstTimeToday = act.FirstTimeToday;
	Action = LastActionDone;
		
	if (modulesList.DoPlanningAction(LastActionDone) == true) {
		act.FirstTimeToday = false;
		ShowPlanningNext();
		return;
	}
	
	// special cases for shops/walk/visit
	if (iAction == 1030 || iAction == 2001 || iAction == 2002 || iAction == 2003 ||
		iAction == 2004 || iAction == 2005 || iAction == 2506 || iAction == 2507 || iAction == 2508) {
	
		if (iAction == 1030) currentCity.ShowTakeAWalkMenu(false);
		else if (iAction == 2001) currentCity.Shopping("Stables");
		else if (iAction == 2002) currentCity.Shopping("Tailors");
		else if (iAction == 2003) currentCity.Shopping("Shop");
		else if (iAction == 2004) currentCity.Shopping("Salon");
		else if (iAction == 2005) currentCity.ShowVisitMenu();
		else if (iAction == 2506) currentCity.Shopping("Armoury");
		else if (iAction == 2507) currentCity.Shopping("Dealer");
		else if (iAction == 2508) currentCity.Shopping("ItemSalesman");
		act.FirstTimeToday = false;
		return;
	}

	if (iAction == 2) DoSexActTouch();
	else if (iAction == 3) DoSexActLick();
	else if (iAction == 4) DoSexActFuck();
	else if (iAction == 5 || iAction == 99) DoSexActBlowjob();
	else if (iAction == 6) DoSexActTitsFuck();
	else if (iAction == 7) DoSexActAnal();
	else if (iAction == 8) DoSexActMasturbate();
	else if (iAction == 9) DoSexActDildo();
	else if (iAction == 10) DoActPlug();
	else if (iAction == 11) DoSexActLesbian();
	else if (iAction == 12) DoSexActBondage();
	else if (iAction == 13) DoActNaked();
	else if (iAction == 14) DoSexActMaster();
	else if (iAction == 15) DoSexActGangBang();
	else if (iAction == 16) currentCity.DoLend();
	// 17 - see PonyTraining class
	else if (iAction == 18) DoSexActSpank();
	else if (iAction == 19) DoSexActThreesome();
	else if (iAction == 20) DoSexAct69();
	else if (iAction == 21) DoSexActOrgy();
	else if (iAction == 23) DoSexActKiss();
	else if (iAction == 24) DoSexActStripTease();
	else if (iAction == 25) DoSexActCumBath();
	else if (iAction == 30) DoSexActFootjob();
	else if (iAction == 31) DoSexActHandjob();
	else if (iAction == 1001) DoChoreCooking();
	else if (iAction == 1002) DoChoreCleaning();
	else if (iAction == 1003) DoChoreExercise();
	else if (iAction == 1004) DoChoreDiscuss();
	else if (iAction == 1005) DoChoreMakeUp();
	else if (iAction == 1006) DoSchoolSciences();
	else if (iAction == 1007) DoSchoolTheology();
	else if (iAction == 1008) DoSchoolRefinement();
	else if (iAction == 1009) DoSchoolDance();
	else if (iAction == 1010) DoSchoolXXX();
	else if (iAction == 1011) DoChoreExpose();
	else if (iAction == 1012) DoJobRestaurant();
	else if (iAction == 1013) DoJobAcolyte();
	else if (iAction == 1014) DoJobBar();
	else if (iAction == 1015) DoJobSleazyBar();
	else if (iAction == 1016) DoJobBrothel();
	else if (iAction == 1017) DoChoreBreak();
	else if (iAction == 1019) DoChoreReadBook();
	else if (iAction == 1022) DoJobLibrary();
	else if (iAction == 1023) DoJobOnsen();
	else if (iAction == 1031) DoJobCockMilking();
	else if (iAction == 1032) DoSchoolSinging();
	else if (iAction == 1033) DoSchoolSwimming();
	else if (iAction == 2501) currentCity.DoMartialTraining();
	else if (iAction == 2502) trainSlaveMaker.DoPrayAtChurch();
	else if (iAction == 2503) trainSlaveMaker.DoRelaxAtBar();
	else if (iAction == 2504) trainSlaveMaker.DoAttendCourt();
	else if (iAction == 2505) currentCity.SlaveMarket.DoWalkEvent();
	else if (iAction == 2509) trainSlaveMaker.DoSMJob(0);
	else if (iAction == 2510) currentCity.DoSMSleazyBar();
	else if (iAction == 2511) trainSlaveMaker.DoSlaveMakerNothing();
	else if (iAction == 2515) trainSlaveMaker.DoMorningSpecial();
	else if (iAction == 2517) DoTalkSlaves();
	else if (iAction == 2518) trainSlaveMaker.DoSMJob(1);
	else if (iAction == 2519) trainSlaveMaker.DoSMJob(2);
	else if (iAction == 2520) trainSlaveMaker.DoSMJob(4);
	else if (iAction == 2521) trainSlaveMaker.DoSMJob(5);
	else if (iAction == 2522) trainSlaveMaker.DoSMJob(6);
	else if (iAction == 2523) trainSlaveMaker.DoSMJob(7);
	else if (iAction == 2524) trainSlaveMaker.DoSMJob(8);
	else if (iAction == 2525) trainSlaveMaker.DoSMJob(9);
	else {
		// custom acts
		UseGeneric = false;
		if (UseImages) ShowActImage();
		switch (act.Type) {
			case 1: //chore
				if (act.strNodeName == "SlaveChore1") SlaveGirl.ShowSlaveChore1();
				else if (act.strNodeName == "SlaveChore2") SlaveGirl.ShowSlaveChore2();
				else if (act.strNodeName == "SlaveChore3") SlaveGirl.ShowSlaveChore3();
				SlaveGirl.ShowSlaveChore(iAction);
				modulesList.AfterChore(act.strNodeName);
				break;
			case 2:	// 2 = job
				if (act.strNodeName == "SlaveJob1") SlaveGirl.ShowSlaveJob1();
				else if (act.strNodeName == "SlaveJob2") SlaveGirl.ShowSlaveJob2();
				else if (act.strNodeName == "SlaveJob3") SlaveGirl.ShowSlaveJob3();
				SlaveGirl.ShowSlaveJob(iAction);
				modulesList.AfterJob(act.strNodeName);
				break;
			case 3:	// school
				if (act.strNodeName == "SlaveSchool1") SlaveGirl.ShowSlaveSchool1();
				else if (act.strNodeName == "SlaveSchool2") SlaveGirl.ShowSlaveSchool2();
				else if (act.strNodeName == "SlaveSchool3") SlaveGirl.ShowSlaveSchool3();
				SlaveGirl.ShowSlaveSchool(iAction);
				modulesList.AfterSchool(act.strNodeName);
				break;
			case 4:	// slave maker
				modulesList.SMCustomTraining(iAction);
				break;
			case 5:	// sex normal
			case 6: // sex extreme
				ShowSlave(PersonIndex);
				if (act.strNodeName == "SlaveSex1") SlaveGirl.ShowSlaveSex1();
				else if (act.strNodeName == "SlaveSex2") SlaveGirl.ShowSlaveSex2();
				else if (act.strNodeName == "SlaveSex3") CurrentAssistant.ShowSlaveSex3();
				else if (act.strNodeName == "SlaveSex4") CurrentAssistant.ShowSlaveSex4();
				SlaveGirl.ShowSlaveSex(iAction);
				break;
			case 9: // shop
				SlaveGirl.ShowSlaveShop(iAction);		
				break;
		}
		IncreaseActTotal(LastActionDone);
		act.DoAct();
	}
	act.FirstTimeToday = false;
	ShowPlanningNext();
}

function DoPlanningAction()
{
	Information.HideInformation();
	var firstact:PlanningAction = Plannings.arPlanningArray[0];
	if (firstact.SlaveMakerAction == undefined) firstact.SlaveMakerAction = 0;
	if (firstact.SlaveAction != 0) Action = firstact.SlaveAction;
	else if (firstact.SlaveMakerAction != 0) Action = firstact.SlaveMakerAction;
	
	LastActionStartTime = firstact.PlanningTime;
	LastActionDuration = firstact.PlanningDuration;
	
	// set participants, allow for random choices
	delete Participants;
	Participants = new Array();
	var part:Number;
	for (var i:Number = 0; i < firstact.Participants.length; i++) {
		part = firstact.Participants[i];
		if (part == -1) {
			sdata = GetRandomMaleSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
		} else if (part == -2) {
			sdata = GetRandomFemaleSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
		} else if (part == -3) {
			sdata = GetRandomDickgirlSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
		} else if (part == -4) {
			sdata = GetRandomMaleOrDickgirlSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
		} else if (part == -5) {
			sdata = GetRandomFemaleOrDickgirlSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
		}  else if (part == -6) {
			sdata = GetRandomSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
		} else Participants.push(part);
	}
	
	SetTime(LastActionStartTime);
	
	DoActionNow();
	
	modulesList.AfterPlanningAction(LastActionDone);

	if (firstact.SlaveAction != 0) {
		firstact.SlaveAction = 0;
		firstact.image.SlaveAction.Action.htmlText = "";
		
		if (firstact.SlaveMakerAction == 0) {
			if (SMData.DaysUnavailable > 0 || !Supervise) trainSlaveMaker.DoSlaveMakerNothing();
		}
	} else if (firstact.SlaveMakerAction != 0) {
		firstact.SlaveMakerAction = 0;
		firstact.image.SlaveMakerAction.Action.htmlText = "";
	}
	if (firstact.SlaveAction == 0 && firstact.SlaveMakerAction == 0) {
		firstact = PlanningAction(Plannings.arPlanningArray.shift());
		firstact.image.removeMovieClip();
		delete firstact;
	}
	Plannings.RedrawPlanningList(true);
	
	if (LastActionDone == 2511) DoPlanningNext();
}

function ShowPlanningNext()
{
	if (!Plannings.IsStarted()) return;
	if (NextEnding._visible || Quitter._visible || NextEvent._visible || AskQuestions._visible || YesEvent._visible || TakeAWalkMenu._visible || HouseEvents.IsExploring()) return;

	Language.BlankLine(false);
	NextGeneral._visible = true;
	mcMain.MainWindowButton._visible = true;
}

function HidePlanningNext()
{
	NextGeneral._visible = false;
	mcMain.MainWindowButton._visible = false;
}

function AdvancePlanningTime()
{
	var adur:Number = GetActDuration(LastActionDone);
	if ((LastActionStartTime + adur) > LastActionEndTime) AddTime(adur);
	else SetTime(LastActionEndTime);
	LastActionEndTime = GameTime;
}

function DoPlanningNext()
{
	//trace("DoPlanningNext");
	EventTotal = 0;
	WalkPlace = 0;
	dspMain.PopGameTabs();
	clearInterval(intervalId);
	clearInterval(intervalId2);
	clearInterval(intervalId3);
	clearInterval(intervalId4);
	if (slaveData.DressSwap != -1000) SwapDress();
	if (SMData.DressSwap != -1000) SMData.SwapDress();
	
	if (currentShop != null) currentShop.LeaveShop(true);
	else if (currentDialog != null) currentDialog.LeaveDialog();
	
	if (!Plannings.IsStarted()) {
		//trace("DoPlanningNext - not started");
		dspMain.ShowMainButtons();
		return;
	}
	
	PreviousActionDone = LastActionDone;

	ShowSupervisor();
	DiscussOrdinary._visible = false;
	DiscussCongratulate._visible = false;
	DiscussScold._visible = false;
	Quitter._visible = false;  // not needed?
	NextEvent._visible = false;   // not needed?
	
	AdvancePlanningTime();

	if (LastActionDone == 1004) FirstTimeTodayDiscuss = false;
	
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(LastActionDone);
	var atype:Number = act.Type;
	if (atype == 10) {
		
		//trace("DoPlanningNext - talking");
		Beep();
		StopPlanning(false);
		ShowSlaveTalk();	
		
	} else if (LastActionDone == 2515 || LastActionDone == 10 || LastActionDone == 13) {
		
		//trace("DoPlanningNext - morning");
		Beep();
		StopPlanning();
		MorningEvening.ViewDialog();
		
	} else if (Plannings.GetActionsCount() != 0) {
		
		HideEquipmentButton();
		HideSMEquipmentButton();
		HideStatChangeIcons();
		HideMenus();
		HideImages();
		Sounds.StopAndFadeSounds();
		Items.HideItems();
		HideEndings();
		HideSlaveActions();
		HideAllPeople();
		HideDresses();
		
		DoPlanningAction();
		
	} else {
		
		//trace("DoPlanningNext - done");
		HideEquipmentButton();
		HideSMEquipmentButton();
		Beep();
		if (Plannings.bDayTime) {
			//trace("DoPlanningNext - end day");
			if (bNocturnal) EndOfDay();
			else StartEvening();
		} else {
			if (DaysUnavailable > 0) {
				// Slave is ill, apply a standard rest amount
				StandardRest(2);
			}
			if (bNocturnal) {
				SetTime(7);
				StartMorning();
			} else EndOfDay();
		}
	}
}

function StopPlanning(showm:Boolean, resetp:Boolean, hidei:Boolean)
{
	if (slaveData.DressSwap != -1000) SwapDress();
	if (SMData.DressSwap != -1000) SMData.SwapDress();

	WalkPlace = 0;
	HidePlanningNext();
	if (resetp == true) Plannings.Reset(slaveData);
	Supervise = false;
	bAllowEvents = true;
	Plannings.EndPlanning();

	if (hidei != false) {
		dspMain.HideStatChangeIcons();
		HideDresses();
		HideImages();
		Sounds.StopAndFadeSounds();
		HideSlaveActions();
		HideEndings();
		dspMain.SelectGameTab(1);
		PlanningSelections.Actions.invalidate();
		PlanningSelections.ClearButton._visible = true;
		PlanningSelections.Set1._visible = true;
		PlanningSelections.Set2._visible = true;
		PlanningSelections.Set3._visible = true;
		HideMenus();
	}
	if (showm != false) {
		dspMain.ShowMainButtons();
		SetText("");
	}
}


// for button click handling
function DeleteSlaveAction(index:Number, noredraw:Boolean)
{
	var mc:MovieClip = this._parent._parent;
	if (index == undefined) index = mc.actIndex;
	mc.plist.DeleteSlaveAction(index, noredraw);
}

function DeleteSlaveMakerAction()
{
	var mc:MovieClip = this._parent._parent;
	mc.plist.DeleteSlaveMakerAction(mc.actIndex);
}


function SetNightActions(enum1:Number, enum2:Number, enum3:Number, enum4:Number, enum5:Number, enum6:Number, enum7:Number, enum8:Number, enum9:Number, enum10:Number)
{
	SetTime(bNocturnal ? 6 : 18);
	InitialisePlanning(false);
	PlanningSelections.ChkSameListDay.selected = false;
	DoPlanningButton2();
	Plannings.AddDayNightAction(enum1);
	Plannings.AddDayNightAction(enum2);
	Plannings.AddDayNightAction(enum3);
	Plannings.AddDayNightAction(enum4);
	Plannings.AddDayNightAction(enum5);
	Plannings.AddDayNightAction(enum6);
	Plannings.AddDayNightAction(enum7);
	Plannings.AddDayNightAction(enum8);
	Plannings.AddDayNightAction(enum9);
	Plannings.AddDayNightAction(enum10);
}


// Shortcuts

function PlanningShortcuts(keyAscii:Number, key:Number)
{
	if (plantab == -1) return GiveOrdersShortcuts(keyAscii, key);
	
	if (keyAscii == 91 || keyAscii == 93 || (bControl && keyAscii == 68)) {
		StartPlanning();
		return;
	}
	if (bControl) {
		if (keyAscii == 83) {
			if (bControl && !IsNoAssistant()) {
				dspMain.UpdateSupervision(!SuperviseYourself);
				return;
			}
		}
		if (keyAscii == 85) {
			if (Day) PlanningSelections.ChkSameListDay.selected = !PlanningSelections.ChkSameListDay.selected;
			else PlanningSelections.ChkSameListNight.selected = !PlanningSelections.ChkSameListNight.selected;
			return;
		} 
		if (keyAscii == 49) UpdatePlanningSet(1);
		else if (keyAscii == 50) UpdatePlanningSet(2);
		else if (keyAscii == 51) UpdatePlanningSet(3);
	}
	if (plantab == 6) {
		switch (keyAscii) {
			case 49:	// 1
				if (slaveData.ActInfoBase.GetActRO(2509).bShown == true) NewPlanningAction(2509);
				return;
			case 50:	// 2
				if (slaveData.ActInfoBase.GetActRO(2518).bShown == true) NewPlanningAction(2518);
				return;
			case 51:	// 3
				if (slaveData.ActInfoBase.GetActRO(2519).bShown == true) NewPlanningAction(2519);
				return;
			case 52:	// 4
				if (slaveData.ActInfoBase.GetActRO(2520).bShown == true) NewPlanningAction(2520);
				return;
			case 53:	// 5
				if (slaveData.ActInfoBase.GetActRO(2521).bShown == true) NewPlanningAction(2521);
				return;
			case 54:	// 6
				if (slaveData.ActInfoBase.GetActRO(2522).bShown == true) NewPlanningAction(2522);
				return;
			case 55:	// 7
				if (slaveData.ActInfoBase.GetActRO(2523).bShown == true) NewPlanningAction(2523);
				return;
			case 56:	// 8
				if (slaveData.ActInfoBase.GetActRO(2524).bShown == true) NewPlanningAction(2524);
				return;
			case 57:	// 9
				if (slaveData.ActInfoBase.GetActRO(2525).bShown == true) NewPlanningAction(2525);
				return;				
			case 65:	// A
				if (slaveData.ActInfoBase.GetActRO(2506).bShown == true) NewPlanningAction(2506);
				return;
			case 66:	// B
				NewPlanningAction(2503);
				return;
			case 67:	// C
				NewPlanningAction(2504);
				return;
			case 68: 	// D
				if (slaveData.ActInfoBase.GetActRO(2507).bShown == true) NewPlanningAction(2507);
				return;
			case 72:	// H
				NewPlanningAction(2511);
				return;
			case 73: 	// I
				if (slaveData.ActInfoBase.GetActRO(2508).bShown == true) NewPlanningAction(2508);
				return;
			case 77:	// M
				NewPlanningAction(2501);
				return;
			case 80:	// P
				NewPlanningAction(2502);
				return;
			case 83: 	// S
				if (slaveData.ActInfoBase.GetActRO(2505).bShown == true) NewPlanningAction(2505);
				return;
			case 84: 	// T
				if (bControl) NewPlanningAction(2517);
				return;
			case 86: 	// T
				if (ShowSMCustomTrainingOK == 1) NewPlanningAction(2516);
				return;
			case 90:	// Z
				NewPlanningAction(2510);
				return;

		}
	} else if (plantab == 4 || plantab == 5) {
		switch (keyAscii) {
			case 51:	// 3
				if (AskQuestions._visible == false) NewPlanningAction(19);
				return;
			case 54:	// 6
				NewPlanningAction(20);
				return;
			case 65:	// A
				NewPlanningAction(7);
				return;
			case 66:	// B
				if (BDSMOn == 1) NewPlanningAction(12);
				return;
			case 67:	// C
				NewPlanningAction(3);
				return;
			case 68:	// D
				NewPlanningAction(9);
				return;
			case 70:	// F
				if (bControl) NewPlanningAction(30);
				else NewPlanningAction(4);
				return;
			case 71:	// G
				NewPlanningAction(15);
				return;
			case 72:	// H
				if (bControl) NewPlanningAction(31);
				else if (!(SMAdvantages.CheckBitFlag(4) || SMData.SMSkills.CheckBitFlag(8)) || Day) NewPlanningAction(1017);
				return;
			case 73:
				NewPlanningAction(23);
				return;
			case 74:
				NewPlanningAction(5);
				return;
			case 76:
				NewPlanningAction(11);
				return;
			case 77:
				NewPlanningAction(14);
				return;
			case 79:
				NewPlanningAction(2);
				return;
			case 81:
				NewPlanningAction(25);
				return;
			case 82:
				NewPlanningAction(21);
				return;
			case 83:
				NewPlanningAction(18);
				return;
			case 84:
				NewPlanningAction(6);
				return;
			case 85:
				NewPlanningAction(8);
				return;
			case 86:
				NewPlanningAction(2005);
				return;
			case 87:
				NewPlanningAction(1030);
				return;
			case 89:
				if (sPonyTrainer >= 1) NewPlanningAction(17);
				return;
			case 90:
				NewPlanningAction(24);
				return;
		}
	} else {

		switch (keyAscii) {
			case 44:
				NewPlanningAction(1009);
				return;
			case 46:
				NewPlanningAction(1032);
				return;
			case 49:
				if (AskQuestions._visible == false && ShowCustomJob1 == 1) NewPlanningAction(1018);
				return;
			case 50:
				if (AskQuestions._visible == false && ShowCustomJob2 == 1) NewPlanningAction(1020);
				return;
			case 51:
				if (AskQuestions._visible == false && ShowCustomJob3 == 1) NewPlanningAction(1021);
				return;
			case 52:
				if (AskQuestions._visible == false && ShowCustomSchool1 == 1) NewPlanningAction(1024);
				return;
			case 53:
				if (AskQuestions._visible == false && ShowCustomSchool2 == 1) NewPlanningAction(1025);
				return;
			case 54:
				if (AskQuestions._visible == false && ShowCustomSchool3 == 1) NewPlanningAction(1026);
				return;
			case 55:
				if (AskQuestions._visible == false && ShowCustomChore1 == 1) NewPlanningAction(1027);
				return;
			case 56:
				if (AskQuestions._visible == false && ShowCustomChore2 == 1) NewPlanningAction(1028);
				return;
			case 57:
				if (AskQuestions._visible == false && ShowCustomChore3 == 1) NewPlanningAction(1029);
				return;
			case 65:
				NewPlanningAction(1013);
				 return;
			case 66:
				NewPlanningAction(1014);
				return;
			case 67:
				NewPlanningAction(1001);
				return;
			case 68:
				NewPlanningAction(1004);
				return;
			case 69:
				NewPlanningAction(1008);
				return;
			case 70:
				NewPlanningAction(1003);
				return;
			case 71:
				if (bControl) NewPlanningAction(1032);
				else NewPlanningAction(1002);
				return;
			case 72:
				NewPlanningAction(1016);
				return;
			case 73:
				NewPlanningAction(2002);
				return;
			case 75:
				NewPlanningAction(1019);
				return;
			case 76:
				if (SMData.PonygirlAware > 0) NewPlanningAction(2001);
				return;
			case 77:
				NewPlanningAction(1005);
				return;
			case 78:
				if (bControl) NewPlanningAction(1009);
				else NewPlanningAction(2004);
				return;
			case 79:
				NewPlanningAction(2003);
				return;
			case 80:
				if (bControl) NewPlanningAction(1011);
				return;
			case 81:
				NewPlanningAction(1023);
				return;
			case 82:
				if (!(SMAdvantages.CheckBitFlag(4) || SMData.SMSkills.CheckBitFlag(8)) || Day) NewPlanningAction(1017);
				return;
			case 83:
				NewPlanningAction(1006);
				return;
			case 84:
				NewPlanningAction(1007);
				return;
			case 85:
				NewPlanningAction(1012);
				return;
			case 86:
				NewPlanningAction(2005);
				return;
			case 87:
				NewPlanningAction(1030);
				return;
			case 88:
				NewPlanningAction(1010);
				return;
			case 89:
				NewPlanningAction(1022);
				return;
			case 90:
				NewPlanningAction(1015);
				return;
		}
	}

	if (key == 46) {		// Del
		if (bControl) ClearPlanningSelections();
		else {
			var index:Number = Plannings.arPlanningArray.length - 1;
			Plannings.arPlanningArray[index].SlaveMakerAction = 0;
			Plannings.DeleteSlaveAction(index);
		}
		return;
	} else if (key == 45) {		// Ins
		var act:PlanningAction = Plannings.arPlanningArray[Plannings.arPlanningArray.length - 1];
		Participants = act.Participants;
		ChangeParticipants(act.SlaveAction);
		return;
	} else if (key == 37) {
		PlanningActionsLeft();
		return;
	} else if (key == 39) {
		PlanningActionsRight();
		return;
	} else if (key == 38) {
		PlanningPageUp();
		return;
	} else if (key == 40) {
		PlanningPageDown();
		return;
	} else if (bControl) {
		if (key > 111 && key < 124) { // Crtl+F1-F12
			LoadSave.SaveGame(key - 111);
			return;
		}
	}
}

var SlaveA:String;
var SlaveB:String;
function GetSlaveAB()
{
	if ((Math.random()*2) < 1) {
		SlaveA = SlaveName1;
		SlaveB = SlaveName2;
	} else {
		SlaveA = SlaveName2;
		SlaveB = SlaveName1;
	}
}
