import Scripts.Classes.*;

var rfnc:Function;

// Choose a slave

function PickASlave(ptitle:String, mainside:Boolean, filterfnc:Function, cfnc:Function, timer:Number)
{
	if (!SlaveList.IsLoadedAll()) {
		if (timer != undefined) return;
		Timers.AddTimerShowWait(
			setInterval(_root, "PickASlave", 50, ptitle, mainside, filterfnc, cfnc, Timers.GetNextTimerIdx())
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	
	ParticipantsChanger.ps = mainside;
	ParticipantsChanger.filterfnc = filterfnc;

	lfnc = cfnc;
	rfnc = ShowAllSlaves;
	
	ParticipantsChanger.ClearButton._visible = false;
	ParticipantsChanger.DefaultBtn._visible = false;
	ParticipantsChanger.LAddSlave._visible = false;
	ParticipantsChanger.LSelections._visible = false;
	ParticipantsChanger.Slaves._visible = !mainside;
	ParticipantsChanger.Parties._visible = mainside;
	ParticipantsChanger.LMaxMin._visible = false;
	ParticipantsChanger.LAct.htmlText = ptitle;
	PlanningSelections._visible = false;
	
	//sdata = GetSlaveDetailsFromImageName(SlaveImage);
	//slaveData.CopyCommonDetails(_root, sdata);
	
	dspMain.ShowTabBackground(false);
	PlanningPage._visible = false;
	HideMainButtons();
	HideAssistant();
	
	ShowAllSlaves();
}
	
function ShowAllSlaves()
{
	trace("ShowAllSlaves");
	var ps:Boolean = ParticipantsChanger.ps;
	var target:MovieClip = ps ? ParticipantsChanger.Parties.content : ParticipantsChanger.Slaves.content;
	ParticipantsChanger.Parties.vScrollPolicy = "off";
	ParticipantsChanger.Slaves.vScrollPolicy = "off";
	ParticipantsChanger.Slaves._visible = !ps;
	ParticipantsChanger.Parties._visible = ps;
	ClearGeneralArray2();
	HideImages();
	
	var image:MovieClip;
	var incsm:Boolean = false;
	if (ParticipantsChanger.filterfnc(-100)) {
		image = SlavePicker.AddSlave(-100, target);
		image._width = ps ? 200 : 145;
		image._height = ps ? 110 : 80;
		image.Btn.onPress = PickThisSlave;
		incsm = true;
	}
	trace("asstype = " + AssistantData.SlaveType);
	
	if (ParticipantsChanger.filterfnc(-99) && ServantName != "") {
		image = SlavePicker.AddSlave(-99, target);
		image._width = ps ? 200 : 145;
		image._height = ps ? 110 : 80;
		image.Btn.onPress = PickThisSlave;
		if (incsm) {
			if (ps) image._y = 112;
			else image._x = 145;
		}
	}
	
	var sgirl:Slave;
	var sll:Number = SMData.nUsable;
	for (var isl:Number = 0; isl < sll; isl++) {
		sgirl = SMData.arUsableSlaves[isl];
		trace("asstype = " + AssistantData.SlaveType + " " + sgirl.SlaveName);
		if (sgirl == AssistantData) continue;
		if (!ParticipantsChanger.filterfnc(sgirl.SlaveIndex)) continue;
		image = SlavePicker.AddSlave(sgirl.SlaveIndex, target);
		image._width = ps ? 200 : 145;
		image._height = ps ? 110 : 80;
		image.Btn.onPress = PickThisSlave;
		var tn:Number = arGeneralArray2.length;
		if (ps) {
			if (tn > 1) image._y = arGeneralArray2[tn - 2]._y + 112;
		} else {
			if ((tn % 3) == 1) {
				if (tn > 1) image._y = arGeneralArray2[tn - 2]._y + 80;
			} else {
				var xp:Number = tn % 3;
				if (xp == 0) xp = 3;
				xp--;
				image._x = xp * 145;
				if (tn > 1) image._y = arGeneralArray2[tn - 2]._y;
			}
		}
	}

	intervalId3 = setInterval(_root, "ShowParticipantsScrollBar", 150);
	SMAvatar.ShowSlaveMaker();
	if (lfnc == ShowSlaveTalk) ShowLeaveButton();
	else if (currPlace.IsThisPlace("SlaveMarket") == true) ShowPlanningNext();
	
	trace("asstype = " + AssistantData.SlaveType);
	
	dspMain.HideGameTabs();
	ParticipantsChanger._visible = true;
	ParticipantsChanger.Parties.invalidate();
	ParticipantsChanger.Slaves.invalidate();
	dspMain.ShowTabBackground(false);
	
	trace("asstype = " + AssistantData.SlaveType);
}

function PickThisSlave(idx:Number)
{
	PersonIndex = idx;
	if (PersonIndex == undefined) {
		PersonIndex = this._parent.sindex;
		if (PersonIndex == undefined) idx = this._parent._parent.sindex;
	}
	if (PersonIndex >= 0) {
		if (slaveData == SlavesArray[PersonIndex]) PersonIndex = -50;
	}
	if (PersonIndex < 0) PersonName = GetPersonsName(PersonIndex);
	else PersonName = SMData.GetSlaveByIndex(PersonIndex).SlaveName;
	dspMain.ShowTabBackground(true);
	ClearGeneralArray2();
	HideImages();
	ParticipantsChanger.idx = PersonIndex;
	ParticipantsChanger._visible = false;
	if (lfnc != undefined) lfnc();
}
