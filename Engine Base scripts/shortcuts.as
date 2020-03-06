// Shortcuts

var bControl:Boolean;
var keyListenerMenu:Object = new Object();

function EnterShortcuts()
{
	if (LoadSave.IsShown()) return LoadSave.LeaveDialog();
	if (OptionsMenu._visible) return Options.LeaveDialog();
	if (Information.IsShown()) Information.Continue();
	
	if (NextGeneral._visible) return DoPlanningNext();
	if (NextEvent._visible) return DoEventNext();
	if (Quitter._visible) return DoLeaveButton();
	if (GirlsStoryTop._visible) return GirlsStoryTop.GirlsStoryNext.Btn.onPress();
	if (IntroNextButton._visible) return TitleScreen.DoIntroNext();
	
	if (Contests.IsContestStarted()) Contests.DoContestsNext();
	else if (currentDialog != null) return currentDialog.Shortcuts(13, 13, bControl);
}

var keyListenerMain:Object = new Object();

keyListenerMain.onKeyDown = function()
{
	var key:Number = Key.getCode();
	bControl = Key.isDown(Key.SHIFT);
	
	var keya:Number = Key.getAscii();
	if (keya == 0) keya = key;
	var keyal:Number = keya > 96 ? keya - 32 : keya;
	
	if (LoadSave.IsShown()) return LoadSave.Shortcuts(keyal, key, bControl);
	
	if (key == 13) return EnterShortcuts();
	if (dspMain.IsGameTabShown(1)) return;
	
	if (AskQuestions._visible) return AskHerQuestionsShortcuts(keyal);
	
	if (OptionsMenu._visible) return;
	if (!bControl && key > 111 && key < 124) return LoadSave.LoadGame(key - 111);

	if (YesEvent._visible) {
		if (keyal == 89) return	DoEventYes();
		else if (keyal == 78) return DoEventNo();
	}

	if (SlaveDiscussion._visible) {
		if (MorningEvening.Shortcuts(keyal)) return;
	}
	if (MorningButton._visible || EveningButton._visible) {
		if (bControl && key > 111 && key < 124) {
			if (!Plannings.IsStarted()) {
				if (!(Options.bLimitSavesOn && (((GameDate % 8) != 0) || Day))) {
					LoadSave.SaveGame(key - 111);
					return;
				}
			}
		}
		switch (keyal) {
			case 69:
				if (!Day) {		// 1800
					MorningEvening.PressButton();
					return;
				}
				break;
			case 76:
				if (bControl) LoadSave.LoadGame(LoadSave.nQuickSlot);
				return;
			case 77:
				if (Day) {
					MorningEvening.PressButton();
					return;
				}
				break;
			case 80:
				DoPlanningButton();
				return;
			case 83:
				if (bControl && (!(Options.bLimitSavesOn && (((GameDate % 8) != 0) || Day)))) {
					LoadSave.SaveGame(LoadSave.nQuickSlot);
					return;
				}
				break;
		}
	}
	if (dspMain.IsShown()) {
		if (dspMain.Shortcuts(keyal, key, bControl)) return;
	} 
	if (EquipmentButton._visible) {
		if (keyal == 81) {
			SelectEquipment.ViewDialog();
			return;
		}
	}
	trace("short1");
	if (SMEquipmentButton._visible) {
		if (keyal == 71) {
			SelectSMEquipment.ViewDialog();
			return;
		}
	}
	trace("short2");
	if (ParticipantsChanger._visible) {
		if (ParticipantsChangersShortcuts(keyal, key)) return;
	}
	trace("short3");
	if (currentDialog != null) {
		currentDialog.Shortcuts(keyal, key, bControl);
		return;
	}
	if (MorningEvening.IsShown()) {
		MorningEvening.Shortcuts(keyal, key, bControl);
		return;
	}		
	trace("short4");
	if (PlanningPage._visible) return PlanningShortcuts(keyal, key);
	if (TakeAWalkMenu._visible) {
		currentCity.WalkShortcuts(keyal, key, bControl);
		return;
	}
	if (VisitMenu._visible) {
		currentCity.VisitLendShortcuts(keyal, key, bControl);
		return;
	}
	if (SlaveMakerCreate1._visible) return SlaveMakerCreate1Shortcuts(keyal, key);
	if (SlaveMakerCreate2._visible) return SlaveMakerCreate2Shortcuts(keyal, key);
	if (SlaveMakerCreate3._visible) return SlaveMakerCreate3Shortcuts(keyal, key);
	if (DiscussOrdinary._visible) {
		switch (keyal) {
			case 13:
			case 79:
				DoOrdinaryDiscussion();
				return;
			case 67:
				DoCongratulate();
				return;
			case 83:
				DoScold();
				return;
		}
	} 
}

Key.addListener(keyListenerMain);