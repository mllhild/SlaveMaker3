import Scripts.Classes.*;

PlanningSelections.ParticipantsBtn.tabChildren = true;
PlanningSelections.ParticipantsBtn.Btn.onPress = ChangeParticipantsLastAct;


function IsParticipant(part) : Boolean
{
	if (part == undefined) return false;
	
	var pn:Number = People.DecodePersonDetails(part);
	
	for (var pa:String in Participants) {
		if (int(Number(Participants[pa])) == pn) return true;
	}
	if (!IsAssistant(part)) return false;
	for (var pa:String in Participants) {
		if (int(Number(Participants[pa])) == -99) return true;
	}	
	return false;
}

function IsPartner(part) : Boolean { return IsParticipant(part); }
function IsPartnerFemale() : Boolean { return PersonGender == 2 || PersonGender == 3; }
function IsPartnerMale() : Boolean { return PersonGender == 1 || PersonGender == 4; }	


function IsCurrentParticipant(part:Number)
{
	for (var pa:String in Participants) {
		if (int(Number(Participants[pa])) == part) return true;
	}
	return false;
}


function RemoveActParticipant(actno:Object, person:Object)
{
	var act:ActInfo = slaveData.ActInfoBase.GetActRO(actno);
	act.RemoveActParticipant(person);
}		
		
function RemoveParticipantChc()
{
	Participants.splice(this._parent.gindex == undefined ? this._parent._parent.gindex : this._parent.gindex, 1);
	ShowParticipants();
}

function AddParticipantChc()
{
	var pn:Number = this._parent.sindex;
	
	if (pn != -50 && (pn == -99 || pn >= 0)) {
		if (pn == -99) sdata = AssistantData;
		else sdata = SlavesArray[pn];
		
		if (GetActDifficulty(Action, sdata) > sdata.VarObedience && sdata.IsAbleToDoAct(Action)) {
			PersonName = sdata.SlaveName;
			if (pn == -99) {
				SetText("");
				Language.SetLangText("RefuseAssistant", "Participants", GetSlaveObjectXML(sdata));
				BlankLine();
				Bloop();
				return;
			} else {
				if (sdata.SlaveType != -20) {
					Language.SetLangText("RefuseOwnedSlave", "Participants", GetSlaveObjectXML(sdata));
					BlankLine();
					DoYesNoEvent(39);
					LastActionRefused = pn;
					return;
				}
			}
		}
	}

	AddActParticipant(Action, pn);
	ShowParticipants();
}

function AddActParticipant(acto:Object, pn:Number)
{
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(acto);
		
	for (var pi:String in Participants) {
		if (int(Number(Participants[pi])) == pn) return;
	}

	var totp:Number = CountParticipants(Participants);
	if (act.MaxParticipants != 0 && totp >= act.MaxParticipants) Participants.splice(-1, 1);
	
	Participants.push(pn);
	Participants.sort(Array.NUMERIC);
}


ParticipantsChanger.ClearButton.tabChildren = true;
ParticipantsChanger.ClearButton.Btn.onPress = function()
{
	Participants.splice(0);
	ShowParticipants();
}

ParticipantsChanger.DefaultBtn.tabChildren = true;
ParticipantsChanger.DefaultBtn.Btn.onPress = function()
{
	if (Participants.length == 0) return;
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(Action);
	delete act.Participants;
	act.Participants = new Array();
	for (i = 0; i < Participants.length; i++) act.Participants.push(Participants[i]);
	Language.SetLangText("SetDefault", "Participants");
}

function ChangeParticipantsLastAct()
{
	var act:PlanningAction = Plannings.arPlanningArray[Plannings.arPlanningArray.length - 1];
	Participants = act.Participants;
	this._parent.LParticipants._visible = false;
	this._parent.LDelete._visible = false;
	ChangeParticipants(act.SlaveAction);
}

function ChangeParticipantsThisAct()
{
	var act:PlanningAction = Plannings.arPlanningArray[this._parent._parent.actIndex];
	Participants = act.Participants;
	this._parent.LParticipants._visible = false;
	this._parent.LDelete._visible = false;
	ChangeParticipants(act.SlaveAction);
}

function ChangeParticipants(actnum:Number, adda:Boolean)
{
	Participants.sort(Array.NUMERIC);
	//for (var pi:String in Participants) {
		//SMTRACE(Participants[pi]);
	//}
	
	rfnc = ShowParticipantsSN;
	lfnc = ShowParticipantsSN;
	if (actnum == undefined) Action = ActionChoice;
	else Action = int(Math.abs(actnum));
	dspMain.ShowStatisticsTab(6);
	
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(Action);
	if (act.MinParticipants == 0) {
		ServantSpeak(Language.GetHtml("NoOtherPersonNeeded", "Planning"));
		Bloop();
		PlanningSelections._visible = true;
		ShowPlanningTab();
		if (Day) Backgrounds.ShowSky();
		else Backgrounds.ShowNight();
		ShowLeaveButton();
		return;
	}
	ParticipantsChanger.AddAfter = adda;
	ParticipantsChanger.ClearButton._visible = true;
	ParticipantsChanger.DefaultBtn._visible = true;
	ParticipantsChanger.LAddSlave._visible = true;
	ParticipantsChanger.LSelections._visible = true;
	ParticipantsChanger.Slaves._visible = true;
	ParticipantsChanger.Parties._visible = true;
	ParticipantsChanger.LMaxMin._visible = true;
	PlanningSelections._visible = false;
	dspMain.ShowTabBackground(false);
	
	if (act.Type != 5 && act.Type != 6) {
		ParticipantsChanger.LSelections.htmlText = Language.GetHtml("TutorFor", "Participants");
		ParticipantsChanger.LAct.htmlText = Language.GetHtml("TutoredBy", "Participants") + " "  + GetActName(Action);
	} else {
		ParticipantsChanger.LSelections.htmlText = Language.GetHtml("WillDoWith", "Participants");
		ParticipantsChanger.LAct.htmlText = Language.GetHtml("ParticipantsFor", "Participants") + " "  + GetActName(Action);		
	}
	
	PlanningPage._visible = false;
	HideMainButtons();
	ShowDressSmall();
	SMAvatar.ShowSlaveMaker();
	SMAppearance._visible = false;
	
	ShowParticipants();
	
	ParticipantsChanger._visible = true;
	dspMain.HideGameTabs();
}

function ShowParticipantsSN()
{
	HideMainButtons();
	ShowDressSmall();
	Backgrounds.ShowNight();
	ShowParticipants();
}

function ShowParticipantsScrollBar()
{
	clearInterval(intervalId3);
	ParticipantsChanger._visible = true;
	ParticipantsChanger.Parties.vScrollPolicy = "auto";
	ParticipantsChanger.Slaves.vScrollPolicy = "auto";
	ParticipantsChanger.Parties.invalidate();
	ParticipantsChanger.Slaves.invalidate();
}

function ShowParticipants()
{
	ParticipantsChanger._visible = true;
	ClearGeneralArray2();
	HideImages();
	var image:MovieClip;
	ParticipantsChanger.Parties.vScrollPolicy = "off";
	ParticipantsChanger.Slaves.vScrollPolicy = "off";
	
	// Add existing participants
	
	var ypos:Number = 0;
	if (IsCurrentParticipant(-100)) {
		image = SlavePicker.AddSlave(-100, ParticipantsChanger.Parties.content);
		image._width = 200;
		image._height = 110;
		image.Btn.onPress = RemoveParticipantChc;
		image.RemoveBtn.Btn.onPress = RemoveParticipantChc;
		image.RemoveBtn._visible = true;
		ypos += 112;
	}
	if (IsCurrentParticipant(-99)) {
		image = SlavePicker.AddSlave(-99, ParticipantsChanger.Parties.content);
		image._width = 200;
		image._height = 110;
		image.Btn.onPress = RemoveParticipantChc;
		image.RemoveBtn.Btn.onPress = RemoveParticipantChc;
		image._y = ypos;
		ypos += 112;
		image.RemoveBtn._visible = true;
	}
	if (IsCurrentParticipant(-50)) {
		image = SlavePicker.AddSlave(-50, ParticipantsChanger.Parties.content);
		image._width = 200;
		image._height = 110;
		image.Btn.onPress = RemoveParticipantChc;
		image.RemoveBtn.Btn.onPress = RemoveParticipantChc;
		image._y = ypos;
		ypos += 112;

		image.RemoveBtn._visible = true;
	}	
	var sll:Number = SlavesArray.length;
	for (var isl:Number = -6; isl < sll; isl++) {
		if (DickgirlOn == 0 && (isl == -3 || isl == -4 || isl == -5)) continue;
		var sgirl:Slave = SlavesArray[isl];
		if (isl < 0 || ((sgirl.SlaveType == 0 || sgirl.SlaveType == 2 || sgirl.SlaveType == -20 || (sgirl.SlaveType == 1 && sgirl.CanAssist == true)) && sgirl != AssistantData)) {
			if (!IsCurrentParticipant(isl)) continue;
			image = SlavePicker.AddSlave(isl, ParticipantsChanger.Parties.content);
			image._width = 200;
			image._height = 110;
			image.Btn.onPress = RemoveParticipantChc;
			image.RemoveBtn.Btn.onPress = RemoveParticipantChc;
			var tn:Number = arGeneralArray2.length;
			image._y = ypos;
			ypos += 112;
			image.RemoveBtn._visible = true;
		}
	}
	var totpart:Number = arGeneralArray2.length;
	var act:ActInfo = slaveData.ActInfoBase.GetActAbs(Action);
	
	// Add possible (unused) participants
	
	var xpos:Number = 0;
	if (SMData.IsAbleToDoAct(act) && !IsCurrentParticipant(-100)) {
		image = SlavePicker.AddSlave(-100, ParticipantsChanger.Slaves.content);
		image._width = 145;
		image._height = 80;
		image.Btn.onPress = AddParticipantChc;
		xpos += 145;
	}
	if (ServantName != "" && AssistantData.IsAbleToDoAct(act) && !IsCurrentParticipant(-99)) {
		image = SlavePicker.AddSlave(-99, ParticipantsChanger.Slaves.content);
		image._width = 145;
		image._height = 80;
		image._x = xpos;
		xpos += 145;
		image.Btn.onPress = AddParticipantChc;
	}
	if (slaveData.IsAbleToDoAct(act) && !IsCurrentParticipant(-50) && slaveData.IsTwins()) {
		image = SlavePicker.AddSlave(-50, ParticipantsChanger.Slaves.content);
		image._width = 145;
		image._height = 80;
		image._x = xpos;
		xpos += 145;
		image.Btn.onPress = AddParticipantChc;
	}	
	
	for (var isl:Number = 0; isl < sll; isl++) {
		var sgirl:Slave = SlavesArray[isl];
		if ((sgirl.Available && (sgirl.SlaveType == 0 || sgirl.SlaveType == 2 || sgirl.SlaveType == -20 || (sgirl.SlaveType == 1 && sgirl.CanAssist == true)) && sgirl != AssistantData)) {
			//trace("act = " + act + " " + sgirl.IsAbleToDoAct(act));
			if (!sgirl.IsAbleToDoAct(act) || IsCurrentParticipant(isl)) continue;
			image = SlavePicker.AddSlave(isl, ParticipantsChanger.Slaves.content);
			image._width = 145;
			image._height = 80;
			var tn:Number = arGeneralArray2.length - totpart;
			if ((tn % 3) == 1) {
				// new line
				image._x = 0;
				if (tn > 1) image._y = arGeneralArray2[arGeneralArray2.length - 2]._y + 80;
			} else {
				// append to existing line
				xpos = tn % 3;
				if (xpos == 0) xpos = 3;
				xpos--;
				image._x = xpos * 145;
				if (tn > 1) image._y = arGeneralArray2[arGeneralArray2.length - 2]._y;
			}
			image.Btn.onPress = AddParticipantChc;
		}
	}
	if (act.Type == 5 || act.Type == 6) {
		for (var isl:Number = -6; isl < 0; isl++) {
			if (DickgirlOn == 0 && (isl == -3 || isl == -4 || isl == -5)) continue;
			if (isl == -1) {
				if (!act.IsAbleToDoAct(1)) continue;
				if (SMData.GetTotalMaleSlavesOwned(Action) < 2) continue;
			} else if (isl == -2) {
				if (!act.IsAbleToDoAct(2)) continue;
				if (SMData.GetTotalFemaleSlavesOwned(Action) < 2) continue;
			} else if (isl == -3) {
				if (!act.IsAbleToDoAct(3)) continue;
				if (SMData.GetTotalDickgirlSlavesOwned(Action) < 2) continue;
			} else if (isl == -4) {
				if (!act.IsAbleToDoAct(1)) continue;
				if (!act.IsAbleToDoAct(3)) continue;
				if ((SMData.GetTotalMaleSlavesOwned(Action) + SMData.GetTotalDickgirlSlavesOwned(Action)) < 2) continue;
			} else if (isl == -5) {
				if (!act.IsAbleToDoAct(2)) continue;
				if (!act.IsAbleToDoAct(3)) continue;
				if ((SMData.GetTotalFemaleSlavesOwned(Action) + SMData.GetTotalDickgirlSlavesOwned(Action)) < 2) continue;
			} else if (isl == -6) {
				if (!act.IsAbleToDoAct(1)) continue;
				if (!act.IsAbleToDoAct(2)) continue;
				if (!act.IsAbleToDoAct(3)) continue;
				if (SMData.GetTotalSlavesOwned(false) < 2) continue;
			}
			image = SlavePicker.AddSlave(isl, ParticipantsChanger.Slaves.content);
			image._width = 145;
			image._height = 80;
			var tn:Number = arGeneralArray2.length - totpart;
			if ((tn % 3) == 1) {
				// new line
				image._x = 0;
				if (tn > 1) image._y = arGeneralArray2[arGeneralArray2.length - 2]._y + 80;
			} else {
				// append to existing line
				var xp:Number = tn % 3;
				if (xp == 0) xp = 3;
				xp--;
				image._x = xp * 145;
				if (tn > 1) image._y = arGeneralArray2[arGeneralArray2.length - 2]._y;
			}
			image.Btn.onPress = AddParticipantChc;
		}
	}
	
	var totp:Number = CountParticipants(Participants);
	if (act.MaxParticipants != 0 && totp >= act.MaxParticipants) ParticipantsChanger.LMaxMin.htmlText = Language.GetHtml("Full", "Participants");
	else if (act.MaxParticipants == 0) ParticipantsChanger.LMaxMin.htmlText = totp + "/" + act.MinParticipants + "+";
	else ParticipantsChanger.LMaxMin.htmlText = totp + "/" + act.MaxParticipants;
	if (totp < act.MinParticipants) Quitter._visible = false;
	else ShowLeaveButton();
	intervalId3 = setInterval(_root, "ShowParticipantsScrollBar", 100);
	ParticipantsChanger.Parties.invalidate();
	ParticipantsChanger.Slaves.invalidate();
}

function ParticipantsChangersShortcuts(keyal:Number, key:Number) : Boolean
{
	if (key == 46 && ParticipantsChanger.ClearButton._visible) {		// Del
		if (bControl) ParticipantsChanger.ClearButton.Btn.onPress();
		else {
			Participants.splice(Participants.length - 1, 1);
			ShowParticipants();
		}
		return true;
	} 
	if (keyal == 68 && bControl && ParticipantsChanger.DefaultBtn._visible) {
		ParticipantsChanger.DefaultBtn.Btn.onPress();
		return true;
	}
	var tot:Number = arGeneralArray2.length;
	var idx:Number = tot;
	if (keyal < 59 && keyal > 48) idx = keyal - 49;
	else if (keyal < 91 && keyal > 64) idx = keyal - 56;
	if (idx < tot) {
		arGeneralArray2[idx].Btn.onPress();
		return true;
	}
	return false;
}

// General Participant functions

function CountParticipants(pa:Array) : Number
{
	if (pa.length == 0) return 0;
	
	var tot:Number = 0;
	var idx:Number;

	for (var pi:String in pa) {
		idx = int(Number(pa[pi]));
		if (idx == -100) tot += Math.floor(SMData.Gender / 4) + 1;
		else if (idx == -99) tot += Math.floor(ServantGender / 4) + 1;
		else if (idx == -50) tot += Math.floor(SlaveGender / 4) + 1;
		else if (idx < 0) tot++;
		else tot += Math.floor(SlavesArray[idx].SlaveGender / 4) + 1;
	}
	return tot;
}

function CountParticipantGenders(pa:Array)
{	
	SMData.lasttype = 0;
	totmales = 0;
	totfemales = 0;
	totdickgirls = 0;

	if (pa.length == 0) return;
	
	PersonIndex = -99;
	PersonGender = ServantGender;
	PersonName = ServantA;
	PersonGenderIdentity = AssistantData.GenderIdentity;

	var part:Number = 0;
	
	for (var pi:String in pa) {
		PersonIndex = int(Number(pa[pi]));
		//trace("PersonIndex = " + PersonIndex + " " + ServantGender);
		if (PersonIndex == -100) {
			PersonGender = Gender;
			PersonGenderIdentity = SMData.GenderIdentity;
		} else if (PersonIndex == -99) {
			PersonGender = ServantGender;
			PersonGenderIdentity = AssistantData.GenderIdentity;
		} else if (PersonIndex == -50) {
			PersonGender = SlaveGender;
			PersonGenderIdentity = GenderIdentity;
		} else {
			PersonGender = SlavesArray[PersonIndex].SlaveGender;
			PersonGenderIdentity = SlavesArray[PersonIndex].GenderIdentity;
		}
		if (PersonGender == 1 || PersonGender == 4) totmales += Math.floor(PersonGender / 4) + 1;
		else if (PersonGender == 2 || PersonGender == 5) totfemales += Math.floor(PersonGender / 4) + 1;
		else totdickgirls += Math.floor(PersonGender / 4) + 1;
		
		PersonGender = ((PersonGender - 1) % 3) + 1;
	}
	
	if (PersonIndex >= 0) {
		sdata = SlavesArray[PersonIndex];
		PersonName = sdata.SlaveName;
	} else if (PersonIndex == -100) PersonName = GetPersonsName(PersonIndex);
	else {
		PersonName = ServantName;
		sdata = AssistantData;
	}
	GetPersonGenderText(PersonGenderIdentity);
}

function SetDefaultParticipants(act:Number)
{
	//SMTRACE("SetDefaultParticipants: " + act);
	act = Math.abs(act);
	var acti:ActInfo = slaveData.ActInfoBase.GetActAbs(act);
	var asscan:Boolean = (!IsNoAssistant()) && AssistantData.IsAbleToDoAct(acti);

	switch (int(act)) {
						
		case 99:
			// Mistress Cock Blowjob, strictly personal
			Participants.push(-100);
			return;
								
		case 15: 
			// Gang Bang
			for (var i:Number = 0; i < 3; i++) Participants.push(-6);
			break;
			
		case 19: 
			// Threesome
			if (SMData.IsAbleToDoAct(acti)) Participants.push(-100);
			else if (asscan) Participants.push(-99);
			sdata = SMData.GetRandomSlaveOwned(Action, Participants);
			if (sdata != null) Participants.push(sdata.SlaveIndex);
			if (Participants.length < 2) {
				sdata = SMData.GetRandomSlaveOwned(Action, Participants);
				if (sdata != null) Participants.push(sdata.SlaveIndex);
			}
			return;
			
		case 21: 
			// Orgy
			for (var i:Number = 0; i < 3; i++) Participants.push(-6);
			return;
			
		case 25: 
			// Cum Bath
			if (SMData.IsDickgirlAmazon()) {
				Participants.push(-100);
				if (asscan) Participants.push(-99);
				while (true) {
					sdata = GetRandomDickgirlSlaveOwned(Action, Participants);
					if (sdata == null) break;
					Participants.push(sdata.SlaveIndex);
				}
			} else {
				if (SMData.Gender != 2 && SMData.IsAbleToDoAct(acti)) Participants.push(-100);
				if (!ServantWoman && asscan) Participants.push(-99);
				while (true) {
					sdata = GetRandomMaleOrDickgirlSlaveOwned(Action, Participants);
					if (sdata == null) break;
					Participants.push(sdata.SlaveIndex);
				}
			}			
			return;
	}
	
	if (Participants.length != 0) return;
			
	if (SMData.IsAbleToDoAct(acti)) Participants.push(-100);
	else if (asscan) Participants.push(-99);
	else {
		sdata = SMData.GetRandomSlaveOwned(act);
		if (sdata != null) Participants.push(sdata.SlaveIndex);
	}
}
