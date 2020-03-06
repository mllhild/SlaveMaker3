//import Scripts.Classes.*;
// Buttons

function DisableButtons()
{
	PlanningButton.Btn.enabled = false;
	MorningButton.Btn.enabled = false;
	EveningButton.Btn.enabled = false;
	NextEvent.enabled = false;
	NextEnding.enabled = false;
	NextGeneral.enabled = false;
	DiscussOrdinary.enabled = false;
	DiscussCongratulate.enabled = false;
	DiscussScold.enabled = false;
	SlavePurchaseNext.enabled = false;
	SlavePurchasePrevious.enabled = false;
	DoThePlanning.Btn.enabled = false;
	EquipmentButton.enabled = false;
	SMEquipmentButton.enabled = false;
	PersonHint.enabled = false;
	IntroLoadButton.enabled = false;
	Quitter.Btn.enabled = false;
	DisableMenu(ItemSalesmanMenu);
	DisableMenu(MorningEveningMenu);
	DisableMenu(mcEndGameMenu);
	DisableMenu(VisitMenu);
	DisableMenu(RulesMenu);
	DisableMenu(TakeAWalkMenu);
	DisableMenu(ShopMenu);
	DisableMenu(SalonMenu);
	DisableMenu(TailorMenu);
	DisableMenu(mcDiaryMenu);	
	DisableMenu(DealerMenu);
	DisableMenu(StablesMenu);
	DisableMenu(SlavePurchase);
	DisableMenu(PlanningSelections);
	DisableMenu(PlanningPage);
	DisableMenu(PlanningNightSex);
	DisableMenu(PlanningNightOther);
	DisableMenu(ArmouryMenu);
	DisableMenu(SlaveMakerSkillsMenu);
	DisableMenu(mcEndGame);
	DisableMenu(SlaveSelection);
	DisableMenu(AssistantSelection);
	DisableMenu(IntroTitle);
	LoadSave.Disable();
	SelectSMEquipment.Disable();
	SelectEquipment.Disable();
	dspMain.Disable();
}

function EnableButtons()
{
	PlanningButton.Btn.enabled = true;
	MorningButton.Btn.enabled = true;
	EveningButton.Btn.enabled = true;
	NextEvent.enabled = true;
	NextEnding.enabled = true;
	NextGeneral.enabled = true;
	DiscussOrdinary.enabled = true;
	DiscussCongratulate.enabled = true;
	DiscussScold.enabled = true;
	SlavePurchaseNext.enabled = true;
	SlavePurchasePrevious.enabled = true;
	DoThePlanning.Btn.enabled = true;
	EquipmentButton.enabled = true;
	SMEquipmentButton.enabled = true;
	PersonHint.enabled = true;
	IntroLoadButton.enabled = true;
	Quitter.Btn.enabled = true;
	EnableMenu(ItemSalesmanMenu);
	EnableMenu(MorningEveningMenu);
	EnableMenu(mcEndGameMenu);
	EnableMenu(VisitMenu);
	EnableMenu(RulesMenu);
	EnableMenu(TakeAWalkMenu);
	EnableMenu(ShopMenu);
	EnableMenu(SalonMenu);
	EnableMenu(TailorMenu);
	EnableMenu(mcDiaryMenu);	
	EnableMenu(DealerMenu);
	EnableMenu(StablesMenu);
	EnableMenu(SlavePurchase);
	EnableMenu(PlanningSelections);
	EnableMenu(PlanningPage);
	EnableMenu(ArmouryMenu);
	EnableMenu(SlaveMakerSkillsMenu);
	EnableMenu(mcEndGame);
	EnableMenu(SlaveSelection);
	EnableMenu(AssistantSelection);
	EnableMenu(IntroTitle);
	LoadSave.Enable();
	SelectEquipment.Enable();
	SelectSMEquipment.Enable();
	dspMain.Enable();
}

function SetButtonDetails(mc:MovieClip, tick:Boolean, available:Boolean, actlabel:String, action:Number, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number, ifunc, irofunc, iroutfunc, fobj:Object)
{
	if (mc == undefined) return;
	if (actlabel != undefined && actlabel != "") {
		mc.tabChildren = true;
		mc.alabel = actlabel;
		if (mc.ActLabel != undefined) {
			mc.ActLabel.htmlText = actlabel;
			if (mc.ActLabel.bottomScroll > 1) mc.ActLabel._y = 0;
			else mc.ActLabel._y = 7;
		} else if (mc.Label != undefined) mc.Label.htmlText = actlabel;
	}
	if (action != undefined) mc.curract = action;
	if (cost != undefined) {
		mc.cost = cost;
		var btn:Button = mc.ActButton;
		if (btn == undefined) btn = mc.Btn;
		if (fobj == undefined) fobj = _root;
		if (ifunc == undefined) {
			btn.onPress = function() {
				NewPlanningAction(this._parent.curract, false);
			}
		} else {
			btn.onPress = function() {
				fobj[ActInfo.getFunctionName(ifunc, fobj)](this._parent.curract);
			}
		}
		if (iroutfunc != undefined) {
			btn.onRollOut = function() {
				fobj[ActInfo.getFunctionName(iroutfunc, fobj)](this._parent.curract);
			}
		} else if (btn.onRollOut == undefined) btn.onRollOut = HideHints;
		if (irofunc == undefined) {
			btn.onRollOver = function() {
				if (!Hints.IsHints() || AskQuestions._visible || YesEvent._visible) return;
				NewPlanningAction(this._parent.curract, true);
			}
		} else if (btn.onRollOver == undefined) {
			btn.onRollOver = function() {
				fobj[ActInfo.getFunctionName(irofunc, fobj)](this._parent.curract);
			}
		}
	}
	if (aduration != undefined) mc.aduration = aduration;
	if (astart != undefined) mc.astart = astart;
	if (aend != undefined) mc.aend = aend;

	if (available != undefined && mc.NotAvailable != undefined) mc.NotAvailable._visible = !available;
	if (tick != undefined && mc.Tick != undefined) mc.Tick._visible = tick;
	if (shortcut != undefined) mc.ShortcutLabel.htmlText = "<font color='#0000FF'>" + shortcut + "<font color='#000000'>";
	if (config.bColoursOn && (mc.ActButton != undefined || mc.Btn != undefined)) {
		if (mc._parent == ShopMenu || mc._parent == VisitMenu) return;		
		SMData.clrScheme.ApplyThemeBtn(mc.ActButton);
	}
}

function ShowLeaveButton(xpos:Number, ypos:Number)
{
	if (xpos == undefined) Quitter._x = 750;
	else Quitter._x = xpos;
	if (ypos == undefined) Quitter._y = 535;
	else Quitter._y = ypos;
	NextGeneral._visible = false;
	NextEvent._visible = false;
	NextEnding._visible = false;
	Quitter._visible = true;
	HideYesNoButtons();
	HideQuestions();
}
function HideLeaveButton() { Quitter._visible = false; }

// Specific Button events

function DoLeaveButton()
{
	Beep();
	var vf:Boolean = VisitFortuneTeller._visible;
	HideImages();
	Sounds.StopAndFadeSounds();
	HideSlaveActions();
	HideStatChangeIcons();
	Items.HideItems();
	HideAllPeople();
	HideEndings();
	SetText("");
	ItemSalesmanMenu._visible = false;
	mcEndGameMenu._visible = false;
	DealerMenu._visible = false;
	HideYesNoButtons();
	LoadSaveGames._visible = false;
	mcDiaryMenu._visible = false;
	DoThePlanning._visible = false;
	Quitter._visible = false;
	HideEquipmentButton();
	HideSMEquipmentButton();
	mcMain.MainWindowButton._visible = false;
	ParticipantsBtn._visible = false;
	SlavePurchasePrevious._visible = false;
	SlavePurchaseNext._visible = false;
	Hints.StopHints();		
	if (PlanningPage._visible) {
		PlanningSelections._visible = false;
		PlanningPage._visible = false;
		if (plantab == -1) {
			LeaveOrders();
			return;
		}
		dspMain.SelectGameTab(1);
	}
	if (ParticipantsChanger._visible) {
		ParticipantsChanger._visible = false;
		ClearGeneralArray2();
		HideImages();
		Sounds.StopAndFadeSounds();
		LoadedSlaves.ClearLoadedSlaves();
		HideDresses();
		HideAssistant();
		SMAppearance._visible = false;
		ShowSupervisor();
		if (Plannings.IsStarted()) {
			DoPlanningNext();
			return;
		}
		if (lfnc == ShowSlaveTalk) {
			dspMain.ShowGameTabs();
			dspMain.SelectGameTab(1);
			dspMain.SetSlaveForGameTabs(_root);
			MorningEvening.PressButton();
			return;
		} else if (Potions.IsCurrent()) {
			Potions.ShowDialogContents();
			return;
		} else {
			dspMain.SetSlaveForGameTabs(_root);
			dspMain.SelectGameTab(1);
			PlanningSelections._visible = true;
			ShowPlanningTab();
			if (Day) Backgrounds.ShowSky();
			else Backgrounds.ShowNight();
			if (ParticipantsChanger.AddAfter == true) DoNewPlanningYes();
			ShowLeaveButton(824);
			return;
		}
	} 
	if (SalonMenu._visible) {
		currentDialog = null;
		currentShop = null;
		dspMain.SetSlaveForGameTabs(_root);
	} else if (dspMain.IsGameTabShown(2) && StatisticsGroup.review == true) {
		SlaveDiscussion._visible = false;
		StatisticsGroup.review = false;
		dspMain.SetSlaveForGameTabs(_root);
		Backgrounds.ShowBedRoom();
		SMAvatar.ShowSlaveMaker();
		rfnc();
		return;
	} else if (SelectEquipment.IsShown()) {
		SelectEquipment.LeaveDialog();
		if (!Plannings.IsStarted()) {
			MorningEvening.ViewDialog();
			return;
		} else {
			ShowEquipmentButton();
			HideDresses();
			if (Action == 2001) currentCity.GetShopInstanceString("Stables").ShowShopContents();
			else if (Action == 2002) currentCity.GetShopInstanceString("Tailors").ShowShopContents();
			else if (Action == 2003) currentCity.GetShopInstanceString("Shop").ShowShopContents();
			else if (Action == 2004) currentCity.GetShopInstanceString("Salon").ShowShopContents();
			else if (Action == 2507) currentCity.GetShopInstanceString("Dealer").ShowShopContents();
			else if (Action == 2508) currentCity.GetShopInstanceString("ItemSalesman").ShowShopContents();
			else if (currentShop != null) currentShop.ShowShopContents();
			return;
		}
	} else if (SelectSMEquipment.IsShown()) {
		SelectSMEquipment.LeaveDialog();
		if (!Plannings.IsStarted()) MorningEvening.ViewDialog();
		else {
			HideDresses();
			if (Action == 2506) currentCity.GetShopInstanceString("Armoury").ShowShopContents();
		}
		return;
	} else if (RulesMenu._visible) {
		ClearGeneralArray();
    	RulesMenu._visible = false;
		MorningEvening.ViewDialog();
		return;
	}
	if (SlavePurchase._visible) {
		currentDialog = null;
		currentShop = null;
		ClearGeneralArray();
		SlaveMarketOverlay._visible = false;
		SlavePurchase._visible = false;
		SlavePurchasePrevious._visible = false;
		SlavePurchaseNext._visible = false;
	}
	if (Potions.IsCurrent()) {
		currentDialog.LeaveDialog();
		dspMain.SetSlaveForGameTabs(_root);
		MorningEvening.ViewDialog();
		return;
	}
	if (VisitMenu._visible) {
		if (LendPerson == -1000) LendPerson = 0;
		VisitMenu._visible = false;
		MorningEvening.ViewDialog();
		return;
	}
	if (HouseMenu._visible) {
		currentDialog.LeaveDialog();
		currentDialog = null;
		ShowMainButtons();
		dspMain.ShowStatisticsTab(1);
		MorningEvening.ViewDialog();
		return;
	}
	if (EndGame.IsEndGameMenuShown()) {
		currentDialog.Cancel();
		currentDialog = null;
		EndGame.ShowMenuContents();
		return;
	}
	if (vf) {
		currentDialog = null;
		currentShop = null;
		VisitFortuneTeller._visible = false;
		SMData.SlaveMakerName = VisitFortuneTeller.SlaveMakerName.text;
		SlaveMakerName = SMData.SlaveMakerName;
		dspMain.Show();
		dspMain.ShowStatisticsTab(1);
		if (Plannings.IsStarted()) {
			ShowSupervisor();
			DoPlanningNext();
			return;
		}
	}
	DoPlanningNext();
}

Quitter.Btn.onPress = DoLeaveButton;
Quitter.tabChildren = true;
