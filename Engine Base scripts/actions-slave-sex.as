import Scripts.Classes.*;

// Sex

// Variables
var ByYou:Boolean
var SexPosition:Number;
var LevelUp:Boolean;

// Act Levels

function UpdateSexActLevels(type:Number, sd:Object) : Boolean
{
	if (type == undefined) type = LastActionDone;
	if (GetCurrentSexActLevel(type, sd) > GetLastSexActLevel(type, sd)) {
		SetSexActLevel(type, GetLastSexActLevel(type, sd) + 1, sd);
		if (sd.IsDisplayed()) dspMain.ShowSexSkillChangeIcon(type);
		return true;
	}
	return false;
}

function LevelUpSexAct(type:Number) {
	if (LevelUp) UpdateSexActLevels(type, _root);
}

function GetLastSexActLevel(type:Number, sd:Object) : Number
{
	if (sd == undefined) sd = _root;
	var sf:Boolean = sd.SlaveGender != 0 && sd.SlaveGender != 1 && sd.SlaveGender != 4;
	var isdg:Boolean = (!sf) || sd.SlaveGender == 3 || sd.SlaveGender == 6 || sd.DickgirlXF > 0;
	var lestr:Boolean = sd.BitFlag1.CheckBitFlag(10) && !sd.IsMale();

	switch (Math.floor(Math.abs(type))) {
		case 2: return isdg ? sd.LevelTouchDG : sd.LevelTouch;
		case 3: return isdg ? sd.LevelLickDG : sd.LevelLick;
		case 4: return lestr ? sd.LevelFuckLesbian : sd.LevelFuck;
		case 99:
		case 5: return lestr ? sd.LevelBlowjobLesbian : sd.LevelBlowjob;
		case 6: return lestr ? sd.LevelTitsFuckLesbian : sd.LevelTitsFuck;
		case 7: return sd.LevelAnal;
		case 8: return isdg ? sd.LevelMasturbateDG : sd.LevelMasturbate;
		case 9: return sd.LevelDildo;
		case 10: return sd.LevelPlug;
		case 11: return isdg ? sd.LevelLesbianDG : sd.LevelLesbian;
		case 12: return sd.LevelBondage;
		case 13: return sd.LevelNaked;
		case 14: return 1;
		case 15: return sd.LevelGangBang;
		case 16: return sd.LevelLendHer;
		case 17: return 1;
		case 18: return sd.LevelSpank;
		case 19: return isdg ? sd.LevelThreesomeDG : sd.LevelThreesome;
		case 20: return isdg ? sd.Level69DG : sd.Level69;
		case 21: return sd.LevelGroup;
		case 22: return 1;
		case 23: return sd.LevelKiss;
		case 24: return isdg ? sd.LevelStripTeaseDG : sd.LevelStripTease;
		case 25: return sd.LevelCumBath;
		case 26: return sd.LevelSex1;
		case 27: return sd.LevelSex2;
		case 28: return sd.LevelSex3;
		case 29: return sd.LevelSex4;
		case 30: return sd.LevelFootjob;
		case 31: return sd.LevelHandjob;
	}
	return 0;
}

function GetCurrentSexActLevel(type:Number, sd:Object) : Number
{
	var nlevel:Number;
	if (sd == undefined) sd = _root;
	if (sd == _root) {
		nlevel = CurrentAssistant.GetCurrentSexActLevelAsAssistant(type);
		if (nlevel != undefined) return nlevel;
		nlevel = SlaveGirl.GetCurrentSexActLevel(type);
		if (nlevel != undefined) return nlevel;
	}
	
	nlevel = GetLastSexActLevel(type, sd);
	if (nlevel == -1) nlevel = 0;
	if (nlevel == 5) return nlevel;
	
	var sf:Boolean = sd.SlaveGender != 0 && sd.SlaveGender != 1 && sd.SlaveGender != 4;
	var isdg:Boolean = (!sf) || sd.SlaveGender == 3 || sd.SlaveGender == 6 || sd.DickgirlXF > 0;
	var lestr:Boolean = sd.BitFlag1.CheckBitFlag(10) && !sd.IsMale();

	switch (Math.floor(Math.abs(type))) {
		case 2:
			if (lestr) {
				if (VarNymphomaniaRounded >= 20) nlevel = 1;
				if (VarNymphomaniaRounded >= 30 && nlevel > 0) nlevel = 2;
				if (VarNymphomaniaRounded >= 40 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 50 && nlevel > 2) nlevel = 4;
				if (Trust >= 40 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust>= 5) nlevel = 1;
				if (Trust>= 10 && nlevel > 0) nlevel = 2;
				if (Trust>= 20 && nlevel > 1) nlevel = 3;
				if (Trust >= 30 && VarNymphomaniaRounded >= 30 && nlevel > 2) nlevel = 4;
				if (Trust >= 40 && VarNymphomaniaRounded >= 50 && nlevel > 3) nlevel = 5;
			}
			break;
		case 3:
			if (lestr) {
				if (VarNymphomaniaRounded >= 20) nlevel = 1;
				if (VarNymphomaniaRounded >= 30 && nlevel > 0) nlevel = 2;
				if (VarObedienceRounded >= 10 && nlevel > 1) nlevel = 3;
				if (VarObedienceRounded >= 30 && nlevel > 2) nlevel = 4;
				if (VarObedienceRounded >= 40 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust>= 5) nlevel = 1;
				if (Trust>= 10 && nlevel > 0) nlevel = 2;
				if (Trust>= 20 && nlevel > 1) nlevel = 3;
				if (Trust >= 30 && VarNymphomaniaRounded >= 50 && nlevel > 2) nlevel = 4;
				if (Trust >= 40 && VarNymphomaniaRounded >= 70 && nlevel > 3) nlevel = 5;
			}
			break;
		case 4:
			if (lestr) {
				if (VarFuckRounded >= 10) nlevel = 1;
				if (Trust >= 30 && VarFuckRounded >= 20 && nlevel > 0) nlevel = 2;
				if (Trust>= 40 && VarFuckRounded >= 40 && nlevel > 1) nlevel = 3;
				if (VarFuckRounded >= 60 && nlevel > 2) nlevel = 4;
				if (Trust >= 50 && VarFuckRounded >= 80 && nlevel > 3) nlevel = 5;
			} else {
				if (VarNymphomaniaRounded >= 20 && VarFuckRounded >= 10) nlevel = 1;
				if (VarNymphomaniaRounded >= 30 && VarFuckRounded >= 20 && nlevel > 0) nlevel = 2;
				if (VarFuckRounded >= 40 && nlevel > 1) nlevel = 3;
				if (Trust >= 50 && VarFuckRounded >= 60 && nlevel > 2) nlevel = 4;
				if (VarFuckRounded >= 80 && nlevel > 3) nlevel = 5;
			}
			break;
		case 99:
		case 5:
		case 30:
		case 31:
			if (lestr) {
				if (Trust >= 10) nlevel = 1;
				if (Trust >= 20 && nlevel > 0) nlevel = 2;
				if (VarBlowJobRounded >= 20 && nlevel > 1) nlevel = 3;
				if (VarBlowJobRounded >= 50 && nlevel > 2) nlevel = 4;
				if (VarBlowJobRounded >= 80 && nlevel > 3) nlevel = 5;
			} else {
				if (VarBlowJobRounded >= 10) nlevel = 1;
				if (VarBlowJobRounded >= 20 && nlevel > 0) nlevel = 2;
				if (Trust >= 20 && VarBlowJobRounded >= 40 && nlevel > 1) nlevel = 3;
				if (VarBlowJobRounded >= 60 && nlevel > 2) nlevel = 4;
				if (VarBlowJobRounded >= 80 && nlevel > 3) nlevel = 5;
			}
			break;
		case 6:
			if (lestr) {
				if (VarBlowJobRounded >= 10) nlevel = 1;
				if (VarBlowJobRounded >= 15 && nlevel > 0) nlevel = 2;
				if (VarBlowJobRounded >= 20 && nlevel > 1) nlevel = 3;
				if (VarBlowJobRounded >= 40 && nlevel > 2) nlevel = 4;
				if (VarBlowJobRounded >= 60 && VarObedienceRounded > 30 && nlevel > 3) nlevel = 5;
			} else {
				if (VarNymphomaniaRounded >= 30) nlevel = 1;
				if (VarNymphomaniaRounded >= 40 && VarBlowJobRounded >= 10 && nlevel > 0) nlevel = 2;
				if (Trust >= 20 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 50 && VarBlowJobRounded >= 30 && Trust >= 30 && nlevel > 2) nlevel = 4;
				if (GetLastSexActLevel(5, sd) >= 3 && nlevel > 3) nlevel = 5;
			}
			break;
		case 7: 
			if (lestr) {
				if (Trust >= 60) nlevel = 1;
				if (Trust >= 70) nlevel = 2;
				if (Trust >= 80 && VarFuckRounded >= 40 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 50 && VarFuckRounded >= 60 && nlevel > 2) nlevel = 4;
				if (VarNymphomaniaRounded >= 60 && Trust >= 90 && VarFuckRounded >= 80 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust >= 70) nlevel = 1;
				if (Trust >= 80) nlevel = 2;
				if (Trust >= 90 && VarFuckRounded >= 40 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 50 && VarFuckRounded >= 60 && nlevel > 2) nlevel = 4;
				if (VarNymphomaniaRounded >= 60 && Trust >= 100 && VarFuckRounded >= 80 && nlevel > 3) nlevel = 5;
			}
			break;
		case 8:
			if (Trust >= 10 && nlevel < 1) nlevel = 1;
			if (Trust >= 20 && VarNymphomaniaRounded >= 20 && nlevel < 2) nlevel = 2;
			if (Trust >= 30 && VarNymphomaniaRounded >= 40 && nlevel < 3) nlevel = 3;
			if (VarObedienceRounded >= 30 && VarNymphomaniaRounded >= 50 && nlevel < 4) nlevel = 4;
			if (VarNymphomaniaRounded >= 70) nlevel = 5;
			break;
		case 9:
			if (VarNymphomaniaRounded >= 80 && Trust >= 40) nlevel = 5;
			else if (VarNymphomaniaRounded >= 65 && Trust >= 40) nlevel = 4;
			else if (VarNymphomaniaRounded >= 50 && Trust >= 40) nlevel = 3;
			else if (VarNymphomaniaRounded >= 40 && Trust >= 30) nlevel = 2;
			else if (VarNymphomaniaRounded >= 20) nlevel = 1;
			break;
		case 10:
			if (LevelPlug == 4) nlevel = 5;
			else if (LevelPlug == 3) nlevel = 4;
			else if (LevelPlug == 2) nlevel = 3;
			else if (LevelPlug == 1) nlevel = 2;
			else if (GetLastSexActLevel(24, sd) >= 4 || Trust >= 100) nlevel = 1;
			break;
		case 11:
			if (lestr) {
				if (VarFuckRounded >= 15) nlevel = 1;
				if (VarFuckRounded >= 30 && Trust >= 20 && nlevel > 0) nlevel = 2;
				if (VarFuckRounded >= 45 && nlevel > 1) nlevel = 3;
				if (VarFuckRounded >= 65 && Trust >= 40 && nlevel > 2) nlevel = 4;
				if (VarFuckRounded >= 85 && VarObedienceRounded > 40 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust >= 20) nlevel = 1;
				if (GetLastSexActLevel(2, sd) >= 3 && nlevel > 0) nlevel = 2;
				if (GetLastSexActLevel(3, sd) >= 4 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 50 && Trust >= 40 && nlevel > 2) nlevel = 4;
				if (GetLastSexActLevel(11, sd) >= 4 && VarObedienceRounded > 40 && VarNymphomaniaRounded >= 60 && nlevel > 3) nlevel = 5;
			}
			break;
		case 12:
			if (Trust >= 100) nlevel = 5;
			else if (Trust >= 90) nlevel = 4;
			else if (Trust >= 80) nlevel = 3;
			else if (Trust >= 70) nlevel = 2;
			else if (Trust >= 60) nlevel = 1;
			break;
		case 13: 
			if (TotalExpose >= 15 && nlevel == 4) nlevel = 5;
			else if (TotalExpose >= 12 && nlevel == 3) nlevel = 4;
			else if (TotalExpose >= 9 && nlevel == 2) nlevel = 3;
			else if (TotalExpose >= 6 && nlevel == 1) nlevel = 2;
			else if (TotalExpose >= 3 && Trust >= 90) nlevel = 1;
			break;
		case 15:
			if (lestr) {
				if (Trust >= 60 && GetLastSexActLevel(21, sd) >= 2) nlevel = 1;
				if (GetLastSexActLevel(7, sd) >= 1 && nlevel > 0) nlevel = 2;
				if (GetLastSexActLevel(7, sd) >= 2 && nlevel > 1) nlevel = 3;
				if (Trust >= 100 && nlevel > 2) nlevel = 4;
				if (GetLastSexActLevel(7, sd) >= 4 && GetLastSexActLevel(21) >= 4 && nlevel > 3) nlevel = 5;
			} else {
				if (GetLastSexActLevel(5, sd) >= 3) nlevel = 1;
				if (GetLastSexActLevel(4, sd) >= 3 && nlevel > 0) nlevel = 2;
				if (GetLastSexActLevel(7, sd) >= 3 && nlevel > 1) nlevel = 3;
				if (Trust >= 100 && nlevel > 2) nlevel = 4;
				if (VarFuckRounded >= 90 && VarBlowJobRounded > 90 && VarNymphomaniaRounded > 90 && VarObedienceRounded > 40 && nlevel > 3) nlevel = 5;
			}
			break;
		case 16:
			if (GetLastSexActLevel(4, sd) >= 2 && nlevel == 0) nlevel = 1;
			if (GetLastSexActLevel(21, sd) >= 3 && nlevel == 1) nlevel = 2;
			if (Trust >= 100 && nlevel == 2) nlevel = 3;
			if (GetLastSexActLevel(7, sd) >= 3 && nlevel == 3) nlevel = 4;
			if (GetLastSexActLevel(15, sd) >= 4 && nlevel == 4) nlevel = 5;
			break;
		case 18:
			if (Trust >= 50 && VarNymphomaniaRounded >= 70 && VarMoralityRounded >= 50) nlevel = 5;
			else if (VarMoralityRounded >= 40) nlevel = 4;
			else if (Trust >= 40 && VarMoralityRounded >= 30) nlevel = 3;
			else if (VarMoralityRounded >= 20) nlevel = 2;
			else if (VarMoralityRounded >= 10) nlevel = 1;
			break;
		case 19:
			if (lestr) {
				if (Trust >= 50) nlevel = 1;
				if (GetLastSexActLevel(4, sd) >= 1 && nlevel > 0) nlevel = 2;
				if (Trust >= 60 && nlevel > 1) nlevel = 3;
				if (GetLastSexActLevel(23, sd) >= 3 && nlevel > 2) nlevel = 4;
				if (GetLastSexActLevel(11, sd) >= 4 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust >= 50) nlevel = 1;
				if (Trust >= 60 && nlevel > 0) nlevel = 2;
				if (GetLastSexActLevel(4, sd) >= 2 && nlevel > 1) nlevel = 3;
				if (GetLastSexActLevel(11, sd) >= 3 && nlevel > 2) nlevel = 4;
				if (VarFuckRounded >= 70 && VarObedienceRounded > 50 && VarNymphomaniaRounded >= 60 && nlevel > 3) nlevel = 5;
			}
			break;
		case 20:
			if (lestr) {
				if (Trust >= 10 && GetLastSexActLevel(2, sd) >= 2 && VarBlowJobRounded >= 20) nlevel = 1;
				if (VarBlowJobRounded >= 40 && nlevel > 0) nlevel = 2;
				if (VarBlowJobRounded >= 50 && Trust >= 30 && nlevel > 1) nlevel = 3;
				if (VarObedienceRounded >= 60 && VarBlowJobRounded >= 70 && nlevel > 2) nlevel = 4;
				if (VarObedienceRounded >= 80 && VarBlowJobRounded >= 80 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust >= 20 && VarBlowJobRounded >= 20 && GetLastSexActLevel(5, sd) >= 2) nlevel = 1;
				if (VarBlowJobRounded >= 40 && nlevel > 0) nlevel = 2;
				if (VarBlowJobRounded >= 50 && Trust >= 30 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 60 && VarBlowJobRounded >= 70 && nlevel > 2) nlevel = 4;
				if (VarNymphomaniaRounded >= 80 && VarBlowJobRounded >= 80 && nlevel > 3) nlevel = 5;
			}
			break;
		case 21:
			if (lestr) {
				if (Trust >= 50 && GetLastSexActLevel(2, sd) >= 3 && GetLastSexActLevel(23, sd) >= 1) nlevel = 1;
				if (GetLastSexActLevel(3, sd) >= 3 && nlevel > 0) nlevel = 2;
				if (GetLastSexActLevel(5, sd) >= 4 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 70 && Trust >= 70 && nlevel > 2) nlevel = 4;
				if (VarNymphomaniaRounded >= 80 && GetLastSexActLevel(11, sd) >= 4 && nlevel > 3) nlevel = 5;
			} else {
				if (Trust >= 50 && GetLastSexActLevel(2, sd) >= 4) nlevel = 1;
				if (Trust >= 60 && nlevel > 0) nlevel = 2;
				if (GetLastSexActLevel(4, sd) >= 3 && nlevel > 1) nlevel = 3;
				if (VarNymphomaniaRounded >= 70 && VarFuckRounded >= 60 && nlevel > 2) nlevel = 4;
				if (GetLastSexActLevel(4, sd) >= 4 && GetLastSexActLevel(20, sd) >= 4 && VarNymphomaniaRounded >= 80 && nlevel > 3) nlevel = 5;
			}
			break;
		case 23:
			if (Trust >= 5 && nlevel == 0) nlevel = 1;
			if (Trust >= 10 && nlevel == 1) nlevel = 2;
			if (VarSensibilityRounded >= 30 && nlevel == 2) nlevel = 3;
			if (VarSensibilityRounded >= 40 && nlevel == 3) nlevel = 4;
			if (VarSensibilityRounded >= 50 && nlevel == 4) nlevel = 5;
			break;
		case 24: 
			if (VarCharismaRounded >= 70 && GetLastSexActLevel(8, sd) >= 3 && nlevel > 0) nlevel = 5;
			else if (VarCharismaRounded >= 50 && Trust >= 30 && nlevel > 0) nlevel = 4;
			else if (VarCharismaRounded >= 30 && nlevel > 0) nlevel = 3;
			else if (VarCharismaRounded >= 20 && nlevel > 0) nlevel = 2;
			else if (Trust >= 10) nlevel = 1;
			break;
		case 25:
			if (Trust >= 100 && GetLastSexActLevel(5, sd) >= 4) nlevel = 5;
			else if (Trust >= 90 && VarBlowJobRounded >= 50) nlevel = 4;
			else if (Trust >= 80) nlevel = 3;
			else if (Trust >= 70) nlevel = 2;
			else if (Trust >= 60) nlevel = 1;
			break;
	}
	return nlevel;
}


function SetSexActLevel(type:Number, val:Number, sd:Object)
{
	if (sd == undefined) sd = _root;
	var sf:Boolean = sd.SlaveGender != 0 && sd.SlaveGender != 1 && sd.SlaveGender != 4;
	var isdg:Boolean = (!sf) || sd.SlaveGender == 3 || sd.SlaveGender == 6 || sd.DickgirlXF > 0;
	var lestr:Boolean = sd.BitFlag1.CheckBitFlag(10) && !sd.IsMale();

	switch (Math.floor(Math.abs(type))) {
		case 2: isdg ? sd.LevelTouchDG = val : sd.LevelTouch = val; break;
		case 3: isdg ? sd.LevelLickDG++ : sd.LevelLick = val; break;
		case 4: lestr ? sd.LevelFuckLesbian = val : sd.LevelFuck = val; break;
		case 99:
		case 5: lestr ? sd.LevelBlowjobLesbian = val : sd.LevelBlowjob = val; break;
		case 6: lestr ? sd.LevelTitsFuckLesbian = val : sd.LevelTitsFuck = val; break;;
		case 7: sd.LevelAnal = val; break;
		case 8: isdg ? sd.LevelMasturbateDG = val : sd.LevelMasturbate = val; break;
		case 9: sd.LevelDildo = val; break;
		case 10: sd.LevelPlug = val; break;
		case 11: isdg ? sd.LevelLesbianDG = val : sd.LevelLesbian = val; break;
		case 12: sd.LevelBondage = val; break;
		case 13: sd.LevelNaked = val; break;
		case 15: sd.LevelGangBang = val; break;
		case 16: sd.LevelLendHer = val; break;
		case 18: sd.LevelSpank = val; break;
		case 19: isdg ? sd.LevelThreesomeDG = val : sd.LevelThreesome = val; break;
		case 20: isdg ? sd.Level69DG = val : sd.Level69 = val; break;
		case 21: sd.LevelGroup = val; break;
		case 23: sd.LevelKiss = val; break;
		case 24: isdg ? sd.LevelStripTeaseDG = val : sd.LevelStripTease = val; break;
		case 25: sd.LevelCumBath = val; break;
		case 26: sd.LevelSex1 = val; break;
		case 27: sd.LevelSex2 = val; break;
		case 28: sd.LevelSex3 = val; break;
		case 29: sd.LevelSex4 = val; break;
		case 30: sd.LevelFootjob = val; break;
		case 31: sd.LevelHandjob = val; break;
	}
}

// Stat Updates

function SexPoints(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Libido:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number) {
	if (Action != 1) LastActionDone = Action;
	var tempstr:String = slaveData.GetSexActShortDescription(Action);

	// also update other participants
	var j:Number = Participants.length;
	var sd:Slave;
	var toact:Number = Action;
	switch(Action) {
		case 3: toact = 5; break;
		case 5: toact = 3; break;
		case 6: toact = 5; break;
		case 7: toact = 4; break;
		case 18: toact = 0; break;
		case 30: 
		case 31: toact = 2; break;
	}
	while (--j >= 0) {
		if (Participants[j] == -100) {
			SMData.SMPoints(0, 0, 0, Constitution/4, Conversation/4, Libido/4, 0, 0, 0, Charisma/4, Refinement/4, Nymphomania/4, Fatigue/2);
			continue;
		}
		if (Participants[j] == -99) sd = AssistantData;
		else sd = SlavesArray[Participants[j]];
		sd.Points(Charisma/4, Sensibility/4, Refinement/4, Intelligence/4, Morality/4, Constitution/4, Cooking/4, Cleaning/4, Conversation/4, BlowJob/4, Fuck/4, Temperament/4, Nymphomania/4, Obedience/4, Libido/4, Reputation/4, Fatigue/2, Joy/4, Love/4);
		if (sd.ZodaiEffecting > 0) sd.Points(Charisma/4, Sensibility/4, Refinement/4, Intelligence/4, Morality/4, Constitution/4, Cooking/4, Cleaning/4, Conversation/4, BlowJob/4, Fuck/4, Temperament/4, Nymphomania/4, Obedience/4, Libido/4, Reputation/4, Fatigue/2, Joy/4, Love/4);
		// alter sex act totals/levels 1/4 of the time
		if (toact != 0 && PercentChance(25)) {
			UpdateSexActLevels(toact, sd);
			sd.SetActTotal(toact, sd.GetActTotal(toact) + 1);
			UpdateSexActLevels(toact, sd);
		}
	}
	Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special);
	if (ZodaiEffecting > 0) Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special, Special2);
	
	// apply drug effects
	genString = tempstr;
	if (IshinaiEffecting == 1) {
		AddTextToStart(Language.GetHtml("OnIshinai", "Planning") + "\r\r");
		AppendActText = false;
		return false;
	} else if (DoreiEffecting == 1) {
		AddTextToStart(Language.GetHtml("OnDorei", "Planning") + "\r\r");
		AppendActText = false;
		return false;
	}
	return true;
}

function ResetNotFucked()
{
	NumBlowjobSinceFucked = 0;
	NumTitsFuckSinceFucked = 0;
	NumLickSinceFucked = 0;
	NumTouchSinceFucked = 0;
	NumAnalSinceFucked = 0;
	NumMasturbateSinceFucked = 0;
	NumDaysWithoutFuck = -1;
}


// 69
function DoSexAct69()
{	
	if (!TestObedience(Difficulty69, Action)) {
		Refused(20, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0);
		return;
	}
	
	SlaveGirl.ShowSexAct69();
	if (SelectActImage()) Generic.ShowSexAct69();

	Total69++;
	if (Total69 == 1) Difficulty69 = Difficulty69-5;

	if (Lesbian) {
		AlterSexuality(-2);
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ReluctanceLevel * -0.25, 0, 0, 0, ReluctanceLevel * -0.25, ReluctanceLevel * -0.25, 0);
		else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	} else {
		AlterSexuality(0.5);
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.25, 0, 0, 0, ReluctanceLevel * -0.25, ReluctanceLevel * -0.25, 0);
	}
	
	var vo:Boolean = VirginOral;
	
	SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 3, 0, 0, 0, 0, 0);

	if (AppendActText) XMLData.DoXMLAct("SixtyNine");
	LevelUpSexAct(Action);
	
	if (PersonIndex == -100) DoSlaveMaker69();
	else if (PersonGender == 2) DoFemale69();				
	else if (PersonGender == 1) DoMale69();				
	else DoDickgirl69();

	if (StandardCSText && IsCumslutTraining() && PersonGender != 2 && PersonGender != 5 && PersonGender != 0) {
		ChangeCumslut(1);
		if (vo) AddText(" #slave is surprised at the taste of cum. #slave did not realise it is so salty and nice.");
		else AddText(" #slave is eager to taste as much cum as #slave can.");
	}
	if (PersonIndex != -100 && HasCock) sdata.ChangeCumslut(1);
	if (AppendActText && SMAdvantages.CheckBitFlag(6) && PersonIndex == -100) {
		DickgirlRate++;
		AddText(" #slave savours your cum, licking #slavehisher lips.");
	}

	if (StandardDGText && IsDickgirlChangeEvent(50)) {
		AddText("\r\rActually, while her clit is licked you see it grow large and very erect almost like a small cock. #slave screams in pleasure and starts cumming, and does not stop for as long as her clit is sucked and licked.");
	}
}

// 69 with the slave maker
function DoSlaveMaker69()
{
	if (SMData.Gender == 2) {
		// female slavemaker
		if (!AppendActText) {
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 1);
			return;
		}
		SMAvatar.ShowSlaveMaker();
		if (HasCock) {
			if (VarObedienceRounded<15) {
				AddText("#slave doesn't seem to enjoy licking your pussy, but does enjoy your blowjob. #slave seems to focus on #slavehisher own feelings, barely licking you, eventually cumming. #slave stops licking you and lies back, you were nowhere near orgasm.");
			} else if (VarObedienceRounded<30) {
				AddText("#slave enjoys this more and more and loves the blowjob you give, but still remembers to lick you with skill. #slave easily cums with a cry and then concentrates on licking you to orgasm.");
			} else if (VarObedienceRounded<70) {
				AddText("#slave loves your lips and tongue on #slavehisher cock and licks you enthusiastically. #slave cums powerfully, twisting #slavehisher hips and cock, making sure #slaveheshe cums into your mouth! #slave's cock stays somewhat hard as #slaveheshe licks and sucks you to orgasm.\r\rWhen you stop cumming #slavehisher hard cock is insistently prodding at your mouth, ready for another bout.");
			} else {
				AddText("You both expertly bring each other to a strong, simultaneous orgasm, #slavehisher cum flooding into your mouth.\r\r#slave's cock stays hard and #slaveheshe continues licking you and begs you to suck #slavehisher cock again. You decide to indulge #slavehimher and lick and suck #slavehisher cock more. Quicker than last time #slaveheshe cums with a muffled cry. You try to pull #slavehisher cock out of your mouth and to one side but #slaveheshe pushes a little and #slavehisher cum pumps glob after glob of thick cum directly into your mouth.\r\rYou barely hold the large amount of #slavehisher cum in your mouth and move around and quickly kiss #slavehimher, letting all the cum flow into #slavehisher mouth. #slave awkwardly swallows and you feel #slavehisher hardening cock pressing against your pussy. You pull free wiping #slavehisher cum from your face, leaving this training for now.");
			}
		} else {
			if (VarObedienceRounded<15) {
				AddText("#slave doesn't seem to enjoy licking your pussy while being licked by you.");
			} else if (VarObedienceRounded<30) {
				AddText("#slave enjoys this more and more and likes you licking her very much.");
			} else if (VarObedienceRounded<70) {
				AddText("#slave loves to lick your pussy and delights in being licked.");
			} else {
				AddText("Looking at #slavehisher face, #slave can't stop licking you and loves being licked. #slave tried to ensure you both reach orgasm at once.");
			}
		}
		return;
	}
	
	// dickgirl/male slavemaker
	if (!AppendActText) {
		SMData.SMPoints(0, 0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 1);
		VirginOral = false;
		return;
	}
	
	SMAvatar.ShowSlaveMaker();
	if (HasCock) {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy giving you a blowjob while you give #slavehimher a blowjob, focusing too much on #slavehisher own pleasure. #slave does eventually cum but fails to make you cum.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and loves the blowjob you give, but still remembers to suck your cock. #slave easily cums with a cry and then concentrates on sucking your cock until you cum.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves your lips and tongue on #slavehisher cock and sucks your cock enthusiastically. #slave cums powerfully, twisting #slavehisher hips and cock, making sure #slaveheshe cums into your mouth! #slave's cock stays somewhat hard as #slaveheshe licks and sucks you. Gasping as you approach orgasm you tell #slavehimher to take all your cum in #slavehisher mouth. You cry and cum into #slavehisher mouth and #slaveheshe awkwardly swallows all your cum.\r\rWhen you stop cumming #slavehisher hard cock is insistently prodding at your mouth, ready for another bout.");
		} else {
			AddText("You both expertly bring each other to a strong, simultaneous orgasm, cum flooding into each others mouths.\r\r#slave's cock stays hard and #slaveheshe continues sucking your cock and begs you to suck #slavehisher cock again. You decide to indulge #slavehimher and lick and suck #slavehisher cock more. Quicker than last time #slaveheshe cums with a muffled cry. You try to pull #slavehisher cock out of your mouth and to one side but #slaveheshe pushes a little and #slavehisher cum pumps glob after glob of thick cum directly into your mouth.\r\rYou barely hold the large amount of #slavehisher cum in your mouth as you cum, pumping your cum into #slavehisher mouth.\r\rYou sit and move around and quickly kiss #slavehimher, planning to drop #slavehisher cum into #slavehisher own mouth, but #slavehisher mouth is full! Your cum and #slave's mingle and flood over your faces and necks. You both swallow cum, uncertain whose it is....");
		}
	} else {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy sucking you and being licked.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and likes you licking her very much.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves to suck you and delights in you licking her.");
		} else {
			AddText("Looking at her face, #slave can't stop sucking you and loves you licking her.");
		}
	} 
}

// 69 with female slave/servant
function DoFemale69()
{
	ByYou = false;
	if (!AppendActText) return;
	
	ShowSlave(sdata, 0, 1);
	if (HasCock) {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy licking #person while #slave gives #slavehimher a blowjob, focusing too much on #slavehisher own pleasure. #slave does eventually cum but fails to bring #person to orgasm.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and likes the blowjob very much. #slave cums with a cry and licks and sucks #person to orgasm.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves #person giving #slavehimher a blowjob and skillfully licks #person. #slave cums powerfully, gouts of cum filling and then overflowing #person mouth, who gags a little as #slave appears to orgasm as well.\r\rAfter cleaning #personhimherself #person insists on doing it again, licking #personhimher lips as #personheshe asks.");
		} else {
			AddText("They both expertly bring each other to a strong, simultaneous orgasm, #slave's cum flooding in huge globs into #person's mouth. #person does her best to swallow what #slave can, but some overflows and covers her face.\r\rYou order #slave to lick #person's face clean...");
		}
	} else {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy licking #person's pussy while being licked by her.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and likes #person licking her very much.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves to lick #person's pussy and delights in being licked.");
		} else {
			AddText("Looking at her face, #slave can't stop licking #person and loves being licked. #slave tried to ensure they both reach orgasm at once.");
		}
	}
}

// 69 with male slave/servant
function DoMale69()
{
	VirginOral = false;
	ByYou = false;
	
	if (!AppendActText) return;
	
	ShowSlave(sdata, 0, 1);
	var btype:String = "skilled";
	var btypea:String = "a skilled";
	if (PersonGender == 1 || PersonGender == 4) {
		btype = "awkward";
		btypea = "an awkward";
	}
	if (HasCock) {
		if (PersonGender == 1 || PersonGender == 4) AddText(PersonName + " looks at you and protests but you order him to proceed.\r\r");
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy giving #person a blowjob while #personheshe gives #slavehimher " + btypea + " blowjob, focusing too much on #slavehisher own pleasure. #slave does eventually cum but fails to make #person cum.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and loves the " + btype + " blowjob #person gives, but still remembers to suck #personhisher cock. #slave easily cums with a cry and then concentrates on sucking #person cock until #personheshe cums.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves #person's lips and tongue on #slavehisher cock and sucks #personhisher cock enthusiastically. #slave cums powerfully, twisting #slavehisher hips and cock, making sure #slaveheshe cums into #person's mouth! #slave's cock stays somewhat hard as #slaveheshe licks and sucks #person. You tell #slavehimher to take all of #person's cum in #slavehisher mouth as you see #person near #personhisher release. #person cries and cums into #slavehisher mouth and #slaveheshe awkwardly swallows all of #person's cum.\r\rWhen #person stops cumming #slave's hard cock is insistently prodding at #person's mouth, ready for another bout.");
		} else {
			AddText("They both expertly bring each other to a strong, simultaneous orgasm, their cum flooding into each others mouths.\r\r#slave's cock stays hard and #slaveheshe continues sucking #person's cock and begs #personhimher to suck #slavehisher cock again...");
		}
	} else {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy sucking #person's cock and being licked.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and likes #person licking her very much.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves to suck #person's cock and delights in #personhimher licking her pussy.");
		} else {
			AddText("Looking at her face, #slave can't stop sucking #person's cock and loves #personhimher licking her pussy.");
		}
	}
}

// 69 with dickgirl slave/assistant
function DoDickgirl69()
{
	VirginOral = false;
	ByYou = false;
	
	if (!AppendActText) return;
	
	ShowSlave(sdata, 0, 1);

	if (HasCock) {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy giving #person a blowjob while #slave gives #slavehimher a blowjob, focusing too much on #slavehisher own pleasure. #slave does eventually cum but fails to make #person cum.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and loves the blowjob #person gives, but still remembers to suck #slavehisher cock. #slave easily cums with a cry and then concentrates on sucking #person's cock until #slave cums.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves #person's lips and tongue on #slavehisher cock and sucks #slavehisher cock enthusiastically. #slave cums powerfully, twisting #slavehisher hips and cock, making sure #slaveheshe cums into #person's mouth! #slave's cock stays somewhat hard as #slaveheshe licks and sucks #person. You tell #slave to take all of #person's cum in #slavehisher mouth. #person cries and cums into #slavehisher mouth and #slaveheshe awkwardly swallows all of it.\r\rWhen #person stops cumming #slave's hard cock is insistently prodding at #person's mouth, ready for another bout.");
		} else {
			AddText("They both expertly bring each other to a strong, simultaneous climax, cum flooding into each others mouths.\r\r#slave's cock stays hard and #slaveheshe continues sucking #person's cock and begs her to suck #slavehisher cock again. You allow them....");
		}
	} else {
		if (VarObedienceRounded<15) {
			AddText("#slave doesn't seem to enjoy sucking #person's cock and being licked by her.");
		} else if (VarObedienceRounded<30) {
			AddText("#slave enjoys this more and more and likes #person licking her very much. #slave sucks #person's cock and chokes a little when #person powerfully cums in her mouth. A little later #slave gasps and orgasms.");
		} else if (VarObedienceRounded<70) {
			AddText("#slave loves to suck #person's cock and delights in being licking in turn. #slave is surprise at the intensity of #person's climax, getting cum splattered over her face and hair. Moments later #slave loudly orgasms as well.");
		} else {
			AddText("Looking at #slavehisher face, #slave can't stop sucking #person's and loves being licking by her. #slave eagerly swallows all of #person cum when #slave climaxes, orgasming herself as #slave does.\r\r#slave continues sucking #person cock trying to make it erect again for another round. You encourage then to proceed.");
		}
	}
}


// Anal
function DoSexActAnal()
{
	if (!TestObedience(DifficultyAnal, Action)) {
		Refused(7, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -3, -2, 0, 0, -1, -3, 0);
		return;
	}
	
	NumAnalSinceFucked++;
	
	SlaveGirl.ShowSexActAnal();
	if (SelectActImage(true)) Generic.ShowSexActAnal();
	
	TotalAnal++;
	TotalAnalToday++;
	if (TotalAnal == 1) DifficultyAnal = DifficultyAnal-5;
			
	Sounds.StartFucking(1);
	
	if (Lesbian) {
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	} else {
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
	}
	
	if (SexPoints(0, 0, -0.5, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 2, 0, 0, 0)) {
		if (AppendActText) {
			if (VirginAnal) {
				XMLData.DoXMLAct("AnalVirgin");
			} else {
				XMLData.DoXMLAct("Anal");
			}
		}
		LevelUpSexAct(Action);

		if (PersonIndex == -100 && SMData.Gender != 2) {
			// male/dickgirl slavemaker
			if (AppendActText) {
				SMAvatar.ShowSlaveMaker();
				if (TotalAnal<5) {
					AddText("It's still kind of hard to go into #slavehimher.\r\r");
				} else if (TotalAnal<10) {
					AddText("It becomes easier and easier as #slaveheshe learns to relax. #slaveis starting to like it.");
				} else if (TotalAnal<20) {
					AddText("You take #slavehimher easily, #slaveheshe almost came.\r\r");
				} else {
					AddText("Judging by #slavehisher screams, #slaveheshe enjoys it and cums with you.\r\r");
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0);
				}
			}
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		} else if (PersonIndex == -100) {
			// Female Slave Maker strapon
			if (AppendActText) {
				SMAvatar.ShowSlaveMaker();
				if (TotalAnal<5) {
					AddText("It's still kind of hard for you to insert the strap-on into #slavehisher ass.\r\r");
				} else if (TotalAnal<10) {
					AddText("It becomes easier and easier as #slaveheshe learns to relax. #slaveis starting to like it.\r\r");
				} else if (TotalAnal<20) {
					AddText("You take #slavehimher easily, #slaveheshe almost came with you.\r\r");
				} else {
					AddText("Judging by #slavehisher screams, #slaveheshe enjoys it and cums as you do.\r\r");
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0);
				}
			}
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		} else if (PersonGender != 2) {
			// Male slave + dickgirl slave
			if (AppendActText) {
				ShowSlave(sdata, 0, 1);
				if (TotalAnal<5) {
					AddText("It's still kind of hard for #person to enter #slavehisher ass.\r\r");
				} else if (TotalAnal<10) {
					AddText("It becomes easier and easier as #slaveheshe learns to relax. #slaveis starting to like it.\r\r");
				} else if (TotalAnal<20) {
					AddText(PersonName + " takes #slavehimher easily, #slaveheshe almost came.\r\r");
				} else {
					AddText("Judging by #slavehisher screams, #slaveheshe enjoys it and cums as well as #person.\r\r");
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0);
				}
			}
			ByYou = false;
		} else {
			// Female slave with strapon
			if (AppendActText) {
				ShowSlave(sdata, 0, 1);
				if (TotalAnal<5) {
					AddText("It's still kind of hard for #person to insert the strap-on into #slavehisher ass.");
				} else if (TotalAnal<10) {
					AddText("It becomes easier and easier as #slaveheshe learns to relax. #slaveis starting to like it.");
				} else if (TotalAnal<20) {
					AddText("#person takes #slavehimher easily, #slave almost came with her.\r\r");
				} else {
					AddText("Judging by #slavehisher screams, #slaveheshe enjoys it and cums as the slave does.");
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0);
				}
			}
			ByYou = false;
		}
	}
	if (StandardDGText) {
		if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*3) < 2) {
			if (ByYou) AddText("\r\rWhile fucking her ass you see #slave's clit grow large and very erect almost like a small cock. #slave screams how it is throbbing and cums intensely.");
			else AddText("\r\rWhile the slave fucks her ass you see #slave's clit grow large and very erect almost like a small cock. #slave screams how it is throbbing and cums intensely.");
		} else if (DickgirlChanged && (!SlaveGirl.IsDickgirl())) {
			if (ByYou) AddTextToStart("As you penetrate her ass, #slave cries out and you see #slave has suddenly grown a large cock. You continue...\r\r");
			else AddTextToStart("As the slave penetrates her ass, #slave cries out and you see #slave has suddenly grown a large cock. You tell the slave to continue...\r\r");
		}
	}
	VirginAnal = false;
}


// BlowJob
function DoSexActBlowjob() {
	var tempstr:String = ServantA;
	var willdo:Boolean = TestObedience(DifficultyBlowjob, Action);
	if (willdo || (SMData.IsDominatrix() && SMData.Gender != 2)) {
		if (!willdo) {
			SetText(SlaveVerb("refuse") + " to give you a blowjob, but you insist, slapping #slavehimher until #slaveheshe agrees. " + SlaveIs + " unhappy but " + NonPlural("does") + " it.\r\r");
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
		}
		var les:Boolean = Lesbian;
		if (Lesbian && (PersonGender == 3 || PersonGender == 6)) {
			Lesbian = false;
			SlaveGirl.Lesbian = false;
		}
		SlaveGirl.ShowSexActBlowjob();
		if (SelectActImage(true)) Generic.ShowSexActBlowjob();
		Lesbian = les;
		SlaveGirl.Lesbian = les;
			
		TotalBlowjob++;
		NumBlowjobSinceFucked++;
		TotalBlowJobToday++;
		
		var vo:Boolean = VirginOral;
		
		if (Lesbian) {
			AlterSexuality(-2);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			AlterSexuality(0.5);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
		
		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("BlowJob");
			LevelUpSexAct(Action);

			if (PersonIndex == -100 && SMData.Gender != 2) {
				// male/dickgirl Slave Maker
				if (AppendActText) {
					SMAvatar.ShowSlaveMaker();
					if (VarObedienceRounded<15) {
						AddText("#slave doesn't seem to enjoy sucking your cock.");
					} else if (VarObedienceRounded<30) {
						AddText("#slave enjoys sucking and licking your cock more and more.");
					} else if (VarObedienceRounded<70) {
						AddText("Looks like #slaveheshe loves to suck your cock.");
					} else {
						AddText("Looking at #slavehisher face, #slaveheshe can't stop sucking your cock.");
					}
				}
				SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
			} else if (PersonIndex == -100) {
				// female Slave Maker
				if (AppendActText) {
					SMAvatar.ShowSlaveMaker();
					if (VarObedienceRounded<15) {
						AddText("#slave doesn't seem to enjoy licking you and fails to make you orgasm.");
					} else if (VarObedienceRounded<30) {
						AddText("#slave enjoys licking your pussy more and more and makes you orgasm.");
					} else if (VarObedienceRounded<70) {
						AddText("Looks like #slaveheshe loves to lick your pussy and brings you to two gasping orgasms.");
					} else {
						AddText("#slave seems happy to lick your pussy and clit to orgasm after orgasm for as long as you want.");
					}
				}
				SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
			} else if (PersonGender == 2) {
				// Female slave/assistant
				if (AppendActText) {
					ShowSlave(sdata, 0, 1);
					if (VarObedienceRounded<15) {
						AddText("#slave doesn't seem to enjoy licking #person's pussy and fails to make her orgasm.");
					} else if (VarObedienceRounded<30) {
						AddText("#slave enjoys licking #person's pussy more and more and makes her orgasm.");
					} else if (VarObedienceRounded<70) {
						AddText("Looks like #slaveheshe loves to lick #person's pussy and clit and brings her to two gasping orgasms.");
					} else {
						AddText("#slave seems happy to lick #person to orgasm after orgasm for as long as #slave wants.");
					}
				}
				ByYou = false;
			} else {
				// Male slave/assistant
				if (AppendActText) {
					ShowSlave(sdata, 0, 1);
					if (VarObedienceRounded<15) {
						AddText("#slave doesn't seem to enjoy sucking #person' cock.");
					} else if (VarObedienceRounded<30) {
						AddText("#slave enjoys sucking and licking #person's cock more and more.");
					} else if (VarObedienceRounded<70) {
						AddText("Looks like #slaveheshe loves to suck and lick #person's cock.");
					} else {
						AddText("Looking at #slavehisher face, #slaveheshe won't stop sucking #person's cock until you make #slavehimher.");
					}
				}
				ByYou = false;
			}
		}
		BlankLine();
		if (StandardDGText) {
			if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*3) < 2) {
				DickgirlChanged = true;
				Icons.ShowDickgirlIconNow();
				if (Lesbian) {
					if (ByYou) AddText("After you orgasm, #assistant tells you how #slave grew a large cock while licking you. #slave stroked it urgently and came with you. The cock immediately shrank and disappeared.");
					else AddText("After " + tempstr + " orgasms, you can see #slave grows a large cock. #slave strokes it urgently and came shortly after. The cock immediately shrank and disappeared.");
				} else if (ByYou) AddText("After you cum, #assistant tells you how #slave grew a large cock while sucking you. #slave stroked it urgently and came with you. The cock immediately shrank and disappeared.");
				else  AddText("After the slave cums, #assistant tells you how #slave grew a large cock while sucking the slave. #slave stroked it urgently and came with the slave. The cock immediately shrank and disappeared.");
				if (RulesTouchHerself == 0) {
					AddText(" #assistant scolds her for masturbating without permission.");
					BadGirl = 1;
				}
				BlankLine();
			} else if (DickgirlChanged && (!SlaveGirl.IsDickgirl())) {
				if (Lesbian) AddTextToStart("She starts licking your pussy. You see that #slave has a large throbbing cock. You have her continue...");
				else if (ByYou) AddTextToStart("She starts licking your cock. You see that #slave has a large throbbing cock. You have her continue...");
				else AddTextToStart("She starts licking the slaves cock. You see that #slave has a large throbbing cock. You have her continue...");
				BlankLine();
			}
		}
		if (IsCumslutTraining() && PersonGender != 2 && PersonGender != 5) {
			ChangeCumslut(1);
			if (!(SMAdvantages.CheckBitFlag(6) && ByYou)) {
				if (vo) AddText("#slave is surprised at the taste of cum. #slave did not realise it is so salty and nice.");
				else AddText("#slave is eager to taste as much cum as #slave can.");
				BlankLine();
			}
		}

		if (willdo && TotalBlowjob == 1) DifficultyBlowjob = DifficultyBlowjob-5;
		 if (SMAdvantages.CheckBitFlag(6) && ByYou) {
			DickgirlRate++;
			if (vo) AddText("#slave is surprised at the taste of your cum, #slaveheshe did not realise it is so salty and so wonderfully delicious.");
			else if (TotalBlowjob == 1) AddText("#slave is surprised at the taste of your cum, saying how strange it is and so wonderfully delicious.");
			else AddText("#slave savour your cum, almost reluctant to swallow it, licking #slavehisher lips, and then swallowing with some pleasure.");
		}
		VirginOral = false;
 
	} else {
		Refused(5, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
	}
}


// Bondage
function DoSexActBondage()
{
	if (Home.hDungeon > 0) Backgrounds.ShowDungeon();
	if (TestObedience(DifficultyBondage, Action)) {
		
		SlaveGirl.ShowSexActBondage();
		if (SelectActImage()) Generic.ShowSexActBondage();
		
		TotalBondage++;
		TotalBondageToday++;
		
		var moralitydec:Number = -2;
		var joydec:Number = 0;
		if (SMData.SMFaith == 2) {
			moralitydec = -3;
			joydec = -0.5;
		}
		var sp:Boolean;
		if (Home.hDungeon > 0) sp = SexPoints(0, 2 + SMData.SilkenRopesOK, 0, 0, moralitydec, 0, 0, 0, 0, 0, 0, -2, 2, 5, 4, 0, 2, joydec, joydec, 0);
		else sp = SexPoints(0, 1 + SMData.SilkenRopesOK, 0, 0, moralitydec, 0, 0, 0, 0, 0, 0, -2, 2, 4, 3, 0, 2, joydec, joydec, 0);
		if (sp) {
			if (AppendActText) XMLData.DoXMLAct("Bondage");
			LevelUpSexAct(Action);

			if (AppendActText) {
				SMAvatar.ShowSlaveMaker();
				if (TotalBondage<5) {
					AddText("The pain and shame of bondage do not make #slave feel good.\r\r");
				} else if (TotalBondage<10) {
					AddText(SlaveVerb("seem") + " to enjoy more and more being tied and " + SlaveHeSheVerb("suggest") + " differing ways to tie #slavehimher. " + SlaveHeSheUC + " also " + NonPlural("ask") + " to be licked or fucked while tied.\r\r");
				} else if (TotalBondage<20) {
					AddText("Being at your feet seems to be the place " + SlaveHeSheVerb("want") + " to be.\r\r");
				} else {
					if (SMData.Gender == 2) AddText(SlaveVerb("beg") + " you to tie #slavehimher tighter, and " + NonPlural("suggest") + " that you spank #slavehimher, then fuck #slavehimher with a strap-on, all while frog-tied.\r\r");
					else AddText(SlaveVerb("beg") + " you to tie #slavehimher tighter, and " + NonPlural("suggest") + " that you spank #slavehimher, then fuck #slavehimher, all while frog-tied.\r\r");
				}
				if (SMData.SilkenRopesOK == 1) AddText("However, #slave does comment that the ropes feel good on #slavehisher skin.\r\r");
			}
		}
		if (TotalBondage == 1) DifficultyBondage = DifficultyBondage-5;
		if (IsPonygirl()) {
			ChangePonyTraining(1);
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
		}
		if (StandardDGText && DickgirlChanged && (!Slavegirl.IsDickgirl())) AddTextToStart("As you start to bind #slavehimher, " + SlaveHisHer + Plural(" clit") + " suddenly " + NonPlural("grow") + " into " + Plural("a large cock") + ". You consider how to vary your bindings...\r\r");
	
	} else {
		Refused(12, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, -2, 0, 0, -1, -10, 0);
	}
}


// Cum Bath
function DoSexActCumBath()
{
	if (TestObedience(DifficultyCumBath, Action)) {
			
		if (SlaveGirl.ShowSexActCumBath() != true && !UseImages) UseGeneric = true;
		if (SelectActImage()) Generic.ShowSexActCumBath();

		TotalCumBath++;
		if (TotalCumBath == 1) DifficultyCumBath = DifficultyCumBath - 5;
		ChangeCumslut(2);
				
		AlterSexuality(0.5);
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -1, 0, 0, 0, ReluctanceLevel * -1, ReluctanceLevel * -1, 0);

		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 2, 2, 2, 0, 0, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("CumBath");
			LevelUpSexAct(Action);

			if (AppendActText) {
				if (SMData.Gender == 2) {
					if (Slutiness > 5 || VarLibidoRounded > 70 || VarNymphomaniaRounded > 70) {
						AddText("As the slaves cum rains down on #slavehimher #slaveheshe happily rubs it into #slavehisher skin, scooping some up and swallowing it. Sometimes #slaveheshe opens #slavehisher mouth to catch some directly from the source.");
						if (HasCock) {
							AddText(" #slave's cock is very erect the whole time. Towards the end #slaveheshe gathers up some of the cum and rubs it over #slavehisher cock, faster and faster until #slaveheshe cums");
							if (IsDickgirl()) AddText(" carefully spraying over #slavehisher own breasts.");
							else AddText(".");
						}
					} else if (VarLibidoRounded > 50 || VarNymphomaniaRounded > 50) {
						AddText("As the slave's cum rains down on #slavehimher #slaveheshe smiles a little and, once #slaveheshe opens #slavehisher mouth to catch a spurt of cum.");
						if (HasCock) AddText(" #slave's cock is very erect the whole time. Every so often #slaveheshe strokes #slavehisher cock but not to orgasm, just to make #slavehimherself more aroused.");
					} else {
						AddText("#slave winces, closing #slavehisher eyes and just waits for it to end.");
						if (HasCock) AddText(" #slave's cock was limp and #slaveheshe never touched it.");
					}
				} else {
					SMAvatar.ShowSlaveMaker();
					if (Slutiness > 5 || VarLibidoRounded > 70 || VarNymphomaniaRounded > 70) {
						AddText("As your cum and the others rains down on #slave #slaveheshe happily rubs it into #slavehisher skin, scooping some up and swallowing it. Sometimes #slaveheshe opens #slavehisher mouth to catch some directly from the source, preferably from you.");
						if (HasCock) {
							AddText(" #slave's cock is very erect the whole time. Towards the end #slaveheshe gathers up some of the cum and rubs it over #slavehisher cock, faster and faster until #slaveheshe cums");
							if (IsDickgirl()) AddText(" carefully spraying over her own breasts.");
							else AddText(".");
						}
					} else if (VarLibidoRounded > 50 || VarNymphomaniaRounded > 50) {
						AddText("As your cum rains and the others rains down on #slave #slaveheshe smiles a little and, once #slaveheshe opens #slavehisher mouth to catch a spurt of cum from you.");
						if (HasCock) AddText(" #slave's cock is very erect the whole time. Every so often #slaveheshe strokes #slavehisher cock but not to orgasm, just to make #slavehimherself more aroused.");
					} else {
						AddText("#slave winces, closing #slavehisher eyes and just waits for it to end.");
						if (HasCock) AddText(" #slave's cock was limp and #slaveheshe never touched it.");
					}
				}
			}
		}
		if (TotalCumBath == 1) DifficultyGangBang = DifficultyGangBang-1;
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddText("\r\rAs they start cumming on her #slave starts masturbating, and a cock grows into her hands. #slave strokes it quickly and it immediately erupts a torrent of cum, adding to the cum over #slavehimher.");
		SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
	} else {
		Refused(25, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -3, -2, 0, 0, -1, -5, 0);
	}
}


// Dildo
function DoSexActDildo()
{
	if (TestObedience(DifficultyDildo, Action)) {
		
		SlaveGirl.ShowSexActDildo();
		if (SelectActImage()) Generic.ShowSexActDildo();

		TotalDildo++;
		

		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 2, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Dildo");
			LevelUpSexAct(Action);

			if (ImprovedDildoOK == 1) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0);
			
			if (SlaveFemale) DoDildoFemale();
			else DoDildoMale();
		}
		
		if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*3) < 2) {
			DickgirlChanged = true;
			Icons.ShowDickgirlIconNow();
			AddText("\r\rAs " + SlaveVerb("near") + " orgasm a cock rapidly grows from her clit. Before #slave can touch it #assistant slaps her to get her attention and tells her to concentrate. Immediately the cock shrinks and disappears.");
		}
		if (TotalDildo == 1) DifficultyDildo = DifficultyDildo-5;
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddTextToStart("She starts fucking the dildo in and out. As #slave does her clit starts throbbing and starts growing in time with the thrusts until it is a large cock\r\r");

	} else {
		Refused(9, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -4, -2, 0, 0, -1, -4, 0);
	}
}

function DoDildoFemale()
{
	if (!AppendActText) return;
	
	if (LevelUp) {
		switch(LevelDildo) {
			case -1:
			case 0:
				SetText("Showing #slave the dildo that you have acquired, you explain to #slavehimher that any well bred lady is skilled in its use, in order to satisfy herself and others watching. While #slave seems doubtful that this is really true, especially the part about others watching, #slave nevertheless accepts to hold and inspect the instrument of satisfaction.\r\rYou ask #slave what #slave does when #slave wishes to satisfy herself, and blushing deeply, #slave whispers something about her fingers. You tell her not to settle for that.\r\rAt your urgings, #slave rubs the dildo up and down her crack, through her thin panties");
				if (IsDickgirl()) AddText(", and tracing over #slavehisher cock");
				AddText(". #slave is frowning and makes a terrible face, #slave doesn't think this is ladylike at all. You tell her to just go on, she'll get the hang of it. #slave tries for a while, but doesn't seem to get any pleasant sensations from it yet.");
				if (IsDickgirl()) AddText(" #slave does not even seem to get an erection.");
				break;
			case 1:
				SetText("Telling #slave that part of the reason #slave doesn't get anything out of using a dildo yet is that #slave is still wearing panties. #slave needs to feel the sensations directly. While #slave doesn't think it'll change anything, #slave agrees to try when you remind her that this is part of being a proper lady.\r\rAs the rigid shaft rubs up and down her crack, you can tell feelings are starting to stir within her.");
				if (IsDickgirl()) AddText(" #slavehisher cock stiffens but you also see that #slave has some confusion about #slavehisher cock and if #slave should use the dildo on it in some way.");
				break;
			case 2:
				SetText("You start by telling #slave to wet the dildo in her mouth. #slave does so only long enough to get it wet. When you tell her to insert it in her pussy, #slave hesitates, and you ask her if #slave doesn't want to be a real woman?\r\rThis prompts her to work the shaft in between her nether lips, with some effort. Once inside, you tell her to leave it there for now, which #slave does, getting used to the sensation.");
				if (IsDickgirl()) AddText(" You watch and see #slavehisher cock stiffen to a full erection.");
				break;
			case 3:
				SetText("With the dildo inserted, you now instruct #slave to move it, slowly. Hesitating, #slave remembers that ladies do this for pleasure, so proceeds to use the dildo on herself. After a while of sliding it back and forth, the noises reveal that #slave has gotten herself wet.");
				if (IsDickgirl()) AddText(" #slavehisher cock is very erect and you suggest #slave should also stroke it with her other hand. #slave tries but find the coordination a bit awkward. Still #slave continues, clearly liking the twin sensations.");
				AddText("\r\rYou catch your assistant watching from the door, licking " + ServantHisHer + " lips, but " + ServantHeShe + " disappears before you can decide whether to involve " + ServantHimHer + ".");
				break;
			case 4:
				SetText("Increasing the tempo of her thrusts, #slave starts moaning as the dildo slides in and out of her. #slave is starting to truly enjoy the sensation of the hard shaft inside her. ");
				if (IsDickgirl()) AddText(" #slave strokes #slavehisher cock in time with the thrusts of the dildo. ");
				AddText("\r\rSoon, you can hear her moaning and gasping, and you see juices start to leak from her pussy");
				if (IsDickgirl()) AddText(" and moisture on the tip of #slavehisher cock");
				AddText(". Not long after that, #slave shudders and comes with a small, cute scream");
				if (IsDickgirl()) AddText(", cum spraying from #slavehisher cock and juices running all over the toy. You praise her, to which #slave smiles.");
				else AddText(" all over the toy. You praise her, to which #slave smiles.");
				break;
			case 5:
				SetText("Telling you that #slave wishes to show you how ladies pleasure themselves, you tell #slave to go on.\r\rMaking a small show of it, #slave first licks and sucks on the dildo, sliding it in between her breasts and rubbing her nipples with it. Slowly, #slave spreads her legs apart and rubs herself in preparation of taking the dildo inside herself.\r\rWhen she's turned herself wet, #slave then rubs the dildo up and down her crack, mixing her juices with the saliva she's applied. Soon, the dildo becomes slick and wet, and taking advantage of that, #slave pushes the head of it inside her, with a small, very feminine gasp. ");
				if (IsDickgirl()) AddText("#slave works her stiffening cock, rubbing and stroking it. ");
				AddText("Turning so you can better see her, #slave then proceeds to fuck herself with the dildo, letting it slide in and out, back and forth.");
				if (IsDickgirl()) AddText(" #slave strokes #slavehisher cock, long strokes in time with the thrusts of the dildo.");
				AddText("\r\rBefore long, #slave climaxes loudly and intensely, but just proceeds to ram it inside her, moaning even louder than usual. As #slave cries out in more orgasms, you congratulate yourself on having taught #slave all about enjoying dildos and showing off herself playing with them.");
				break;
		}
	} else {
		switch(LevelDildo) {
			case -1:
			case 0:
				SetText("You make #slave rub her pussy up and down with the dildo. #slave seems to not like this");
				if (IsDickgirl()) AddText(" complaining #slavehisher cock gets in the way");
				AddText(". #slave will need to get more excited.");
				break;
			case 1:
				SetText("#slave rubs her nude pussy with the dildo with limited results. ");
				if (IsDickgirl()) AddText("#slave seems confused if #slave should also touch #slavehisher cock. ");
				AddText("#slave is still getting used to it. Exciting her and winning her trust is essential.");
				break;
			case 2:
				SetText("After quickly wetting the dildo between her lips, #slave inserts the dildo in her pussy and lets it stay there. ");
				if (IsDickgirl()) AddText("Her cock quickly becomes erect. ");
				AddText("As her excitement and trust increases, so will her skill.");
				break;
			case 3:
				SetText("#slave pushes the dildo in and out of her wet pussy,");
				if (IsDickgirl()) AddText("but doesn't reach climax, despite sometimes stroking #slavehisher cock. Excitement will make her lose her inhibitions.");
				else AddText("but doesn't reach orgasm. Excitement will make her lose her inhibitions.");
				break;
			case 4:
				if (IsDickgirl()) SetText("#slave fucks herself using the dildo and strokes #slavehisher cock until #slave cums.");
				else SetText("#slave fucks herself to an orgasm, using the dildo.");
				AddText("If #slave gets more excited, #slave will no doubt let herself go completely.");
				break;
			case 5:
				SetText("#slave happily puts on a masturbation show with the dildo");
				if (IsDickgirl()) AddText(", using it in #slavehisher pussy and on #slavehisher cock");
				else if (HasCock) AddText(", using it in #slavehisher as and on #slavehisher cock");
				AddText(". You've taught #slavehimher all about this.");
				break;
		}
	}
}

function DoDildoMale()
{
	if (!AppendActText) return;

	SetText("#slave fucks #slavehimherself using the dildo in #slavehisher ass and strokes #slavehisher cock until #slave cums.");
}


// FootJob
function DoSexActFootjob()
{
	var tempstr:String = ServantA;
	var willdo:Boolean = TestObedience(DifficultyFootjob, Action);
	if (willdo) {
		
		if (SlaveGirl.ShowSexActFootjob() != true && !UseImages) UseGeneric = true;
		if (SelectActImage()) Generic.ShowSexActFootjob();

		TotalFootjob++;
		if (TotalFootjob == 1) DifficultyFootjob = DifficultyFootjob-5;
		NumBlowjobSinceFucked++;
		
		if (Lesbian) {
			AlterSexuality(-0.5);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			AlterSexuality(0.5);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
		
		
		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 1, 0, 0, 0, 0, 0)) {
			if (PersonIndex == -100) SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
			if (AppendActText) {
				if (PersonIndex == -100) XMLData.DoXMLAct("FootJobSlaveMaker");
				else XMLData.DoXMLAct("FootJobSlave");
			}
			LevelUpSexAct(Action);
		}
	} else {
		Refused(5, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
	}
}

// Fuck
function DoSexActFuck()
{
	if (TestObedience(DifficultyFuck, Action)) {
		
		UseGeneric = false;
		SlaveGirl.ShowSexActFuck();
		if (SelectActImage(true)) Generic.ShowSexActFuck(SMData.Gender == 3);
		
		ResetNotFucked();
		TotalFuck++;
				
		if (Lesbian) {
			AlterSexuality(-1);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			AlterSexuality(1);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
		
		
		Sounds.StartFucking(1);
		if (SexPoints(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, -2, 0, 2, 0, 1, 0)) {
			if (AppendActText) {
				if (VirginVaginal) {
					XMLData.DoXMLAct("FuckVirgin");
				} else {
					XMLData.DoXMLAct("Fuck");
				}
			}
			LevelUpSexAct(Action);
			if (SlaveFemale) DoSexActFuckThem();
			else DoSexActFuckOther();
		}
		BlankLine();
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) {
			if (ByYou) AddTextToStart("As you start fucking #slavehimher you hear #slavehimher moan and #slave seems to start rubbing #slavehimher clit. You look and see #slave is stroking a large cock that #slave has grown.\r\r");
			else AddTextToStart("As the slave starts fucking #slavehimher you hear #slavehimher moan and you see a large cock swell out of #slavehimher groin and #slave starts frantically stroking it.\r\r");
		}
		if (TotalFuck == 1) DifficultyFuck = DifficultyFuck-5;
		if (SMAdvantages.CheckBitFlag(6) && ByYou && !Lesbian) DickgirlRate = DickgirlRate + 0.5;
		VirginVaginal = false;
						  		
	} else {
		Refused(4, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
	}
}

// They get vaginally fucked (female, dickgirl slaves only)
function DoSexActFuckThem()
{
	if (PersonIndex == -100 && SMData.Gender == 2) {
		// Female slavemaker strap-on fuck
		if (AppendActText) {
			if (VarObedienceRounded<15) {
				AddText(SlaveHeSheUC + " still " + NonPlural("does") + " not really accept you fucking #slavehimher with the strap-on.");
			} else if (VarObedienceRounded<50) {
				AddText(SlaveVerb("seem") + " to enjoy you fucking #slavehimher.");
			} else if (VarObedienceRounded<80) {
				AddText(SlaveVerb("seem") + " to love to fuck with the strap-on, at one time crying out 'Who needs a cock!'.");
			} else {
				AddText("Looks like #slaveheshe " + NonPlural("does") + " not want to stop. " + SlaveHeSheUC + " " + NonPlural("beg") + " you to be fucked more and with a larger strap-on.");
			}
		}
		SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		CheckImpregnate("Yours");
		return;
	}
		
	if (PersonIndex == -100) {
		// Male/Dickgirl slavemaker
		if (AppendActText) {
			if (VarObedienceRounded<15) {
				AddText(SlaveHeSheUC + " still " + NonPlural("does") + " not really accept you fucking #slavehimher.");
			} else if (VarObedienceRounded<50) {
				AddText(SlaveVerb("seem") + " to enjoy you fucking #slavehimher.");
			} else if (VarObedienceRounded<80) {
				AddText(SlaveVerb("seem") + " to love to fuck.");
			} else {
				AddText("Looks like #slaveheshe " + NonPlural("does") + " not want to stop. " + SlaveHeSheUC + " " + NonPlural("beg") + " you to fuck #slavehimher more.");
			}
		}
		SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		CheckImpregnate("Yours");
		return;

	}
	
	if (PersonGender == 2) {
		// female slave/assistant strap-on
		if (!AppendActText) return;
		
		ShowSlave(sdata, 0, 1);
		if (VarObedienceRounded<15) {
			AddText(SlaveHeSheUC + " still " + NonPlural("does") + " not really accept #person fucking #slavehimher with the strap-on.");
		} else if (VarObedienceRounded<50) {
			AddText(SlaveVerb("seem") + " to enjoy #person fucking #slavehimher.");
		} else if (VarObedienceRounded<80) {
			AddText(SlaveVerb("seem") + " to love to fuck with the strap-on, at one time crying out 'Who needs a cock!'.");
		} else {
			AddText("Looks like #slaveheshe " + NonPlural("does") + " not want to stop. " + SlaveHeSheUC + " " + NonPlural("beg") + " #person to be fucked more and with a larger strap-on.");
		}
		return;
	}
	
	// male/dickgirl fuck
	ByYou = false;
	if (!AppendActText) return;
	
	ShowSlave(sdata, 0, 1);
	if (VarObedienceRounded<15) {
		AddText(SlaveHeSheUC + " still " + NonPlural("does") + " not really accept #person fucking #slavehimher.");
	} else if (VarObedienceRounded<50) {
		AddText(SlaveVerb("seem") + " to enjoy #person fucking #slavehimher.");
	} else if (VarObedienceRounded<80) {
		AddText(SlaveVerb("seem") + " to love to fuck #person.");
	} else {
		AddText("Looks like #slaveheshe " + NonPlural("does") + " not want to stop. " + SlaveHeSheUC + " " + NonPlural("beg") + " you to be fucked more by #person.");
	}
	CheckImpregnate("Human");
}

// They fuck another woman, not a man. Only for male slaves, NOT dickgirl slaves
function DoSexActFuckOther()
{
	if (PersonIndex == -100) {
		// Female/Dickgirl slavemaker
		if (AppendActText) {
			if (VarObedienceRounded<15) {
				AddText(SlaveHeSheUC + " still " + NonPlural("does") + " not really want to fuck you.");
			} else if (VarObedienceRounded<50) {
				AddText(SlaveVerb("seem") + " to enjoy fucking you.");
			} else if (VarObedienceRounded<80) {
				AddText(SlaveVerb("seem") + " to love to fuck you.");
			} else {
				AddText("Looks like #slaveheshe " + NonPlural("does") + " not want to stop. " + SlaveHeSheUC + " " + NonPlural("beg") + " to fuck you more.");
			}
		}
		SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		SMData.CheckImpregnate("Human");
		return;
	}
	
	// female/dickgirl slave/assistant
	ByYou = false;
	if (!AppendActText) return;
	ShowSlave(sdata, 0, 1);
	if (VarObedienceRounded<15) {
		AddText(SlaveHeSheUC + " still " + NonPlural("does") + " not really want to fuck #person.");
	} else if (VarObedienceRounded<50) {
		AddText(SlaveVerb("seem") + " to enjoy fucking #person fucking.");
	} else if (VarObedienceRounded<80) {
		AddText(SlaveVerb("seem") + " to love to fuck #person!");
	} else {
		AddText("Looks like #slaveheshe " + NonPlural("does") + " not want to stop. " + SlaveHeSheUC + " " + NonPlural("beg") + " to fuck #person more and more!");
	}
	sdata.CheckImpregnate("Human");
}


// Gang Bang
function DoSexActGangBang() {
	if (TestObedience(DifficultyGangBang, Action)) {
		
		SlaveGirl.ShowSexActGangBang();
		if (SelectActImage())  Generic.ShowSexActGangBang();
		
		TotalGangBang++;
		ResetNotFucked();
		
		var moralitydec:Number = -3;
		if (SMData.SMFaith != 1) moralitydec = -1;
		
		if (Lesbian) {
			AlterSexuality(-1);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, ReluctanceLevel * -2, 0, 0, 0, ReluctanceLevel * -2, ReluctanceLevel * -2, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			Sounds.StartFucking(3);
			AlterSexuality(2);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -2, 0, 0, 0, ReluctanceLevel * -2, ReluctanceLevel * -2, 0);
		}
		
		if (SexPoints(0, -1, 0, 0, moralitydec, 1, 0, 0, 0, 2, 2, -1, 5, 5, -5, 0, 4, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("GangBang");
			LevelUpSexAct(Action);

			if (totmales > 0 && (totdickgirls + totfemales) == 0 ) {
				// male
				if (AppendActText) {
					if (VarObedienceRounded<80) {
						AddText("#slave doesn't seem to enjoy this, #slaveheshe just tolerated the fuckings.\r\r");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<50) {
						AddText("Doing it with more than one man doesn't seem to bother #slavehimher.\r\r");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<80) {
						AddText("#slave seems to enjoy doing this with many men.\r\r");
					} else {
						AddText("Looks like #slave loves to be gang-banged.\r\r");
					}
				}
				CheckImpregnate("Human");
				
			} else if (totfemales > 0 && (totdickgirls + totmales) == 0 ) {
				// female
				if (AppendActText) {
					if (VarObedienceRounded<80) {
						AddText("#slave doesn't seem to enjoy this. #slave is still a little off-put by the lesbianism.");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<50) {
						AddText("Doing it with more than one woman doesn't seem to bother #slavehimher, but #slave did seem to mainly accept their attention, not really trying to pleasure them.");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<80) {
						AddText("#slave seems to enjoy doing this with many women, happily using fingers and tongue to pleasure them.");
					} else {
						AddText("Looks like #slave loves to be gang-banged, cumming often.\r\r");
					}
				}
				
			} else if (totdickgirls > 0 && (totfemale + totmales) == 0 ) {
				// Dickgirl
				if (AppendActText) {
					if (VarObedienceRounded<80) {
						AddText("#slave doesn't seem to enjoy this, just tolerating it. The hermaphrodites would have preferred #slavehimher to enjoy it but still fucked #slavehimher many times.");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<50) {
						AddText("Doing it with more than one hermaphrodite doesn't seem to bother #slavehimher. They seemed to enjoy #slavehimher cumming often and copiously");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<80) {
						AddText("#slave seems to enjoy doing this with many hermaphrodites, loving the quantity of their cum and their enthusiasm.");
					} else {
						AddText("Looks like #slave loves to be gang-banged. After, lying coated in their cum, #slave commented how much better it is to be fucked by hermaphrodites.");
					}
				}
				CheckImpregnate("Human");
				
			} else {
				// mixture
				if (AppendActText) {
					if (VarObedienceRounded<80) {
						AddText("#slave doesn't seem to enjoy this, still a little off-put by the women present.");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<50) {
						AddText("Doing it with more than one woman doesn't seem to bother #slavehimher, but #slave did seem to mainly accept their attention, not really trying to pleasure them.");
					} else if (VarObedienceRounded<90 && VarNymphomaniaRounded<80) {
						AddText("#slave seems to enjoy doing this with many men and women, happily being fucked and using fingers and tongue on their cocks and pussies to pleasure them.");
					} else {
						AddText("Looks like #slave loves to be gang-banged, cumming often.\r\r");
					}
				}
				CheckImpregnate("Human");
			}
		}
		if (StandardDGText) {
			if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*3) < 2) {
				DickgirlChanged = true;
				Icons.ShowDickgirlIconNow();
				AddText("\r\r#assistant tells you once #slave briefly grew a cock but it did not last long.");
			} else if (DickgirlChanged && (!SlaveGirl.IsDickgirl())) {
				if (Lesbian) AddTextToStart("The women start to lick and the fuck #slavehimher. You see one of them look surprised and see #slave has grown a large cock. The woman opens her mouth and sucks #slave's new cock in.\r\r");
				else AddTextToStart("The men start to lick and then fuck #slave. You see one of them look surprised and see #slave has grown a large cock.\r\r");
			}
		}
		if (TotalGangBang == 1) DifficultyGangBang = DifficultyGangBang-5;
		if (SMAdvantages.CheckBitFlag(6) && Action != 15.2) DickgirlRate = DickgirlRate + 0.5;
		if (SMData.Gender == 3) SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		VirginAnal = false;
		VirginOral = false;
		VirginVaginal = false;

	} else {
		Refused(15, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -8, -2, 0, 0, -1, -15, 0);
	}
}


// HandJob
function DoSexActHandjob()
{
	var willdo:Boolean = TestObedience(DifficultyHandjob, Action);
	if (willdo) {
		if (SlaveGirl.ShowSexActHandjob() != true && !UseImages) UseGeneric = true;
		if (SelectActImage()) Generic.ShowSexActHandjob();
		
		TotalHandjob++;
		if (TotalHandjob == 1) DifficultyHandjob = DifficultyHandjob-5;
		NumBlowjobSinceFucked++;
		
		if (Lesbian) {
			AlterSexuality(-0.5);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			AlterSexuality(0.5);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
		
		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 1, 1, 0, 0, 0, 0, 0)) {
			if (PersonIndex == -100) SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
														
			if (AppendActText) {
				if (PersonIndex == -100) XMLData.DoXMLAct("HandJobSlaveMaker");
				else XMLData.DoXMLAct("HandJobSlave");
			}
			LevelUpSexAct(Action);

		}
	} else {
		Refused(5, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
	}
}


// Kiss
function DoSexActKiss()
{	
	UseGeneric = false;
	if (SlaveGirl.ShowSexActKiss() != true && !UseImages) UseGeneric = true;
	if (SelectActImage()) Generic.ShowSexActKiss();
	
	TotalKiss++;
	
	if (Lesbian) {
		AlterSexuality(-1);
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -1, 0, 0, 0, ReluctanceLevel * -1, PersonIndex == -100 ? 0 : ReluctanceLevel * -1, 0);
	} else {
		AlterSexuality(1);
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -1, 0, 0, 0, ReluctanceLevel * -1, PersonIndex == -100 ? 0 : ReluctanceLevel * -1, 0);
	}

	LevelUpSexAct(Action);
	
	var sp:Boolean;
	
	if (PersonIndex == -100) {
		// Slave Maker
		if ((SMData.Gender != 1 && SlaveFemale) || (SMData.Gender == 1 && !SlaveFemale)) sp = SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 2, 0);
		else sp = SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 2, 0);
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddText("\r\rAfter you part #assistant tells you that #slave briefly grew an erect cock, but it shrank as you broke apart.");
		
	} else if (PersonGender != 1) {
		// Female/Dickgirl
		ShowSlave(sdata, 0, 1);
		if (PersonGender != 1 && !TestObedience(DifficultyLesbian, Action)) sp = SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		else sp = SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0);
	} else {
		// Male
		ShowSlave(sdata, 0, 1);
		if (PersonGender != 1 && !TestObedience(DifficultyLesbian, Action)) sp = SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		else sp = SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0);
	}
	
	if (AppendActText && sp) {
		if (PersonGender != 1) XMLData.DoXMLAct("KissFemale");
		else XMLData.DoXMLAct("KissMale");
	}

	SMData.SMPoints(0, 0, 0, 0, 0, 1, 0);
}


// Lesbian
function DoSexActLesbian() {
	if (TestObedience(DifficultyLesbian, Action)) {
			
		UseGeneric = false;
		SlaveGirl.ShowSexActLesbian();
		if (SelectActImage()) Generic.ShowSexActLesbian();
		
		TotalLesbian++;
		var fuckinc:Number = 0;
		if (HasCock || StrapOnWorn == 1) fuckinc = 1;
				
		AlterSexuality(-3);

		var moralitydec:Number = -3;
		if (SMData.SMFaith != 1) moralitydec = 0;
		if (LesbianTraining) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		
		if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -2, 0, 0, 0, ReluctanceLevel * -2, ReluctanceLevel * -2, 0);
				
		if (SexPoints(0, 1, 0, 0, moralitydec, 0, 0, 0, 0, 0, fuckinc, 0, 2, 3, -2, 0, 2, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Lesbian");
			LevelUpSexAct(Action);

			if (SlaveFemale) DoSexActLesbianSex();
			else DoSexActGaySex();

		}
		if (StandardDGText) {
			if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*2) == 1) {
				DickgirlChanged = true;
				Icons.ShowDickgirlIconNow();
				if (ByYou) {
					AddText("\r\rLater in the training #slave becomes very aroused and asks you to lie face down. ");
					if (StrapOnOK) AddText("and you feel her strap-on enter your pussy, it seems a little different than usual but you let her fuck you. #slave seems to be enjoying it more, grunting and groaning a lot, and fucks fast and urgently. You suddenly hear her cry out and the strap-on pulses? and you feel the unmistakable sensation of a cock pumping large amounts of cum into your pussy. You look around and see her pulling a cock from your pussy, cum spraying over your back. #slave gasps and fall back, the cock shrinks and vanishes.");
					else AddText("and you feel a strap-on enter your pussy, but you know #slave does not have one. You look and #slave has grown a cock and is fucking you with it! You consider but decide to allow her to finish, #slave seem to be enjoying it, grunting and groaning a lot, and fucks fast and urgently. You suddenly hear her cry out and you feel #slavehisher cock pumping large amounts of cum into your pussy. You look around and see her pulling a cock from your pussy, cum spraying over your back. #slave gasps and fall back, the cock shrinks and vanishes.");
				} else AddText("\r\r#assistant tells you one time the other girl thought #slave was being fucked with a strap-on but actually #slave had grown a cock and fucked her with it. .");
			} else if (DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddTextToStart("As the girls start embracing you see #slave has grown a large cock. This rather changes the act...\r\r");
		}
		if (TotalLesbian == 1) DifficultyLesbian = DifficultyLesbian-5;
		
		if (SMData.sLesbianTrainer >= 1 && (!BitFlag1.CheckBitFlag(12)) && SlaveFemale) {
			if (TotalLesbian == 1) AddText("\r\r#slave has agreed to lesbian acts! It is time to discuss #slavehisher future training...");
			else AddText("\r\r#slave has agreed again to lesbian acts! It is time to discuss again #slavehisher future training...");
			DoEvent(270);
			BitFlag1.SetBitFlag(12);
		}
		if (SMData.sGayTrainer >= 1 && (!BitFlag1.CheckBitFlag(12)) && IsMale()) {
			if (TotalLesbian == 1) AddText("\r\r#slave has agreed to homosexual acts! It is time to discuss #slavehisher future training...");
			else AddText("\r\r#slave has agreed again to homosexual acts! It is time to discuss again #slavehisher future training...");
			DoEvent(270);
			BitFlag1.SetBitFlag(12);
		}		
		if (PersonIndex != -100 && HasCock) sdata.ChangeCumslut(1);
  
	} else {
		Refused(11, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -5, -2, 0, 0, -1, -5, 0);
	}
}


function DoSexActLesbianSex()
{
	if (IsDickgirl()) {
		if (PersonIndex == -100) {
			if (AppendActText) {
				SMAvatar.ShowSlaveMaker();
				if (TotalLesbian<5) {
					AddText(SlaveIs + " unused to sex as a hermaphrodite and awkwardly tries to make love to you. #slave eventually fucks you but quickly cums long before you.");
				} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
					AddText("#slave very much enjoys making love to you, #slavehisher foreplay is good and then fucks you expertly to several orgasms, cumming #slavehimherself a few times.");
				} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
					AddText(SlaveIs + " really enthusiastic and expertly arouses you. #slave then fucks you to several mutual orgasms. Impressively #slave seems to stay erect and hard after cumming the first time.");
				} else {
					AddText(SlaveIs + " an expert at loving women and superbly arouses you. #slave then proceeds to fuck you in your pussy and then ass, all without #slavehisher erection fading. After #slavehisher second orgasm, deep in your ass, #slavehisher cock softens, but #slave is willing to continue. You clean #slavehisher cock and then easily lick and suck it back to a full, hard erection. #slave asks if you could continue so #slave can 'complete the set'...");
				}
			}
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
			SMData.CheckImpregnate("Human");
		} else {
			if (AppendActText) {
				ShowSlave(sdata, 0, 1);
				if (TotalLesbian<5) {
					AddText(SlaveIs + " unused to sex with a woman and awkwardly makes love to #person. #slave eventually fucks #person and quickly cums.");
				} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
					AddText("You can see " + SlaveVerb("enjoy") + " sex with another woman. #slavehisher foreplay is skilled and then fucks #person expertly to several orgasms, cumming #slavehimheself a few times.");
				} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
					AddText(SlaveIs + " really enthusiastic and expertly arouses #person. #slave then fucks #person to several mutual orgasms. #person even gives #slave a blowjob to arouse #slavehimher so they could fuck again.");
				} else {
					AddText(SlaveIs + " an expert at loving women and superbly arouses #person. #slave then proceeds to fuck #person in her pussy, ass and mouth. #person is joyful and thanks #slave profusely and asks to be fucked again.");
				}
			}
			SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
			ByYou = false;
			sdata.CheckImpregnate("Human");
		}
		return;
	}

	if (LesbianTraining) {
		if (PersonIndex == -100) {
			if (AppendActText) {
				SMAvatar.ShowSlaveMaker();
				if (VarObedienceRounded<60) {
					AddText("#slave doesn't look like is familiar with this act, unsure how to move her hips. You do not think #slave came.\r\r");
				} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
					AddText("#slave enjoyed this style of sex and orgasms a bit after you.\r\r");
				} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
					AddText(SlaveIs + " really enthusiastic, her hip motions are expert, and came very strongly at almost the same time as you do.");
				} else {
					AddText("#slave likes this very much and after orgasming and making sure you orgasm, #slave says this is her favourite lesbian sex act.");
				}
			}
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		} else {
			ByYou = false;
			if (SMData.Gender != 2) SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
			if (AppendActText) {
				ShowSlave(sdata, 0, 1);
				if (VarObedienceRounded<60) {
					AddText("#slave doesn't look like is familiar with this act, unsure how to move against #person. You do not think #slave came.\r\r");
				} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
					AddText("#slave clearly enjoyed this style of sex and orgasms a bit after #person.");
				} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
					AddText(SlaveIs + " really enthusiastic, her hip motions are expert, and came very strongly at almost the same time as #person does.");
				} else {
					AddText("#slave likes this very much and after orgasming and making sure #person orgasms, #slave says this is her favourite lesbian sex act.");
				}
			}
		}
	} else {
		if (PersonIndex == -100) {
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
			SMAvatar.ShowSlaveMaker();
		} else {
			if (AppendActText) ShowSlave(sdata, 0, 1);
			SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
			ByYou = false;
		}
		if (AppendActText) {
			if (VarObedienceRounded<60) {
				AddText("#slave doesn't look like #slave dares to let herself go, you do not think #slave came.\r\r");
			} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
				AddText("It looks like #slave enjoys sex with another woman.");
			} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
				AddText(SlaveIs + " really enthusiastic and cums several times.\r\r");
			} else {
				AddText("#slave likes this so much it's hard to believe that #slave is not a lesbian.\r\r");
			}
		}
	}
}

function DoSexActGaySex()
{
	if (PersonIndex == -100) {
		if (AppendActText) {
			SMAvatar.ShowSlaveMaker();
			if (TotalLesbian<5) {
				AddText(SlaveIs + " unused to sex with another man and awkwardly tries to make love to you. #slave eventually fucks your ass but quickly cums long before you.");
			} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
				AddText("#slave very much enjoys making love to you, #slavehisher foreplay is good and then fucks you expertly to several orgasms, cumming #slavehimherself a few times.");
			} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
				AddText(SlaveIs + " really enthusiastic and expertly arouses you. #slave then fucks you to several mutual orgasms. Impressively #slave seems to stay erect and hard after cumming the first time.");
			} else {
				AddText(SlaveIs + " an expert at loving men and superbly arouses you. #slave then proceeds to fuck you in your ass and then mouth, all without #slavehisher erection fading. After #slavehisher second orgasm, deep in your ass, #slavehisher cock softens, but #slaveheshe is willing to continue. You clean #slavehisher cock and then easily lick and suck it back to a full, hard erection. #slave asks if you could continue so #slaveheshe can 'complete the set'...");
			}
		}
		SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		return;
	}
	
	if (AppendActText) {
		ShowSlave(sdata, 0, 1);
		if (TotalLesbian<5) {
			AddText(SlaveIs + " unused to sex with a male and awkwardly makes love to #person. #slave eventually fucks #person's ass and quickly cums.");
		} else if (VarObedienceRounded<70 && VarSensibilityRounded<50) {
			AddText("You can see " + SlaveVerb("enjoy") + " sex with another man. #slavehisher foreplay is skilled and then fucks #person expertly to several orgasms, cumming #slavehimheself a few times.");
		} else if (VarObedienceRounded<80 && VarSensibilityRounded<70) {
			AddText(SlaveIs + " really enthusiastic and expertly arouses #person. #slave then fucks #person to several mutual orgasms. #person even gives #slave a blowjob to arouse #slavehimher so they could fuck again.");
		} else {
			AddText(SlaveIs + " an expert at loving men and superbly arouses #person. #slave then proceeds to fuck #person in his #peronhisher and mouth. #person is joyful and thanks #slave profusely and asks to be fucked again.");
		}
	}
	SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
	ByYou = false;
}


// Lick
// SexPosition 0 =  lie on back, 1 = sit up
function DoSexActLick() {
	if (TestObedience(DifficultyLick, Action)) {
		
		SlaveGirl.ShowSexActLick();
		if (SelectActImage(true)) Generic.ShowSexActLick();
		
		TotalLick++; 
		NumLickSinceFucked++;
		
		if (Lesbian) {
			AlterSexuality(-2);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ReluctanceLevel * -0.25, 0, 0, 0, ReluctanceLevel * -0.25, ReluctanceLevel * -0.25, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			AlterSexuality(1);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.25, 0, 0, 0, ReluctanceLevel * -0.25, ReluctanceLevel * -0.25, 0);
		}
		
	
		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Lick");
			LevelUpSexAct(Action);

			if (AppendActText) {
				if (StandardDGText && DickgirlChanged && (!IsPermanentDickgirl())) {
					AddText("As ");
					if (PersonIndex == -100) AddText("you start");
					else AddText(PersonName + " starts");
					AddText(", #slave suddenly grows a large erect cock, so you change the act to become a blowjob instead.\r\r");
				}
				var desire:Number = VarLibidoRounded + VarNymphomaniaRounded;
				
				if (PersonIndex == -100) {
					if (HasCock) {
						// 3.0 - slave maker blowjob
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, 0, 0, 1, 0.5, 0);
						if (SexPosition == 0) AddText("You have #slave lie down and lean over ");
						else AddText("You have #slave sit down and you lean in ");
						AddText("and slowly lick #slavehisher cock, ");
						if (desire < 50) AddText("#slave seems distracted and not really interested");
						else if (desire < 100) AddText("#slave sighs and moans in pleasure");
						else if (desire < 150) AddText("#slave gasps in pleasure and rests #slavehisher hands on the back of your head. You pull #slavehisher hands free");
						else AddText("who cries in pleasure and tries to thrust #slavehisher cock into your mouth");
						AddText(".\r\rYou lick ");
						temp = Math.floor(Math.random()*3);
						if (!SlaveFemale) temp = 1;
						switch(temp) {
							case 0: AddText("along the shaft of #slave's cock, then licking the head of #slavehisher cock. You firmly stroke #slave's cock and with your other hand slip fingers into #slave's pussy.\r\rYou lick, stroke and finger faster and faster"); break;
							case 1: AddText("and kiss the head of #slavehisher cock and slowly take the head of #slavehisher cock into your mouth, licking and circling your tongue around the head. You take a firm and tight grasp around the base of #slavehisher cock and lightly rub along the shaft with your other hand.\r\rYou lick and suck #slavehisher cock head with more and more intensity"); break;
							case 2: AddText("and suck on the head of #slavehisher cock and slowly take the cock into your mouth, at the same time working fingers in #slave's pussy and stroking the base of #slavehisher cock.\r\rYou lick and stoke faster and faster"); break;
						}
						AddText(" until you decide #slaveheshe has had enough, as the purpose here is to arouse #slave not make #slavehimher cum.\r\r");
						if (desire < 50) {
							AddText("You pull away, a hand lingering on #slave's cock to assert your control of #slavehisher cock. #slave looks away, a little disappointed.");
						} else if (desire < 100) {
							Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0);
							AddText("You pull away, a hand lingering on #slave's cock to assert your control of #slavehisher cock. #slave begs you to let #slavehimher cum, #slavehisher cock throbbing and intensely erect in your hand.");
						} else {
							Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0);
							AddText("As decide this #slave lets out a cry and cums, pumping large gobs of cum into your mouth. You pull free and spit out #slavehisher cum onto #slavehisher stomach. You scold #slave for #slavehisher lack of control and bend down ");
							if (desire < 150) AddText("and lick #slave's cock until #slavehisher cock is throbbing and hard.");
							else AddText("and lick #slave's cock for a short time until #slave suddenly cries out again, cumming, spurting #slavehisher cum over your face. You scold #slavehimher and order #slavehimher to lick the cum from your face...");				
						}
					} else {
						// 3.0 - slave maker cunnilingus
						if (SexPosition == 0) AddText("You have #slave lie down and ");
						else AddText("You have #slave sit down and ");
							
						AddText("with years of experience you skillfully lick her pussy and clit, stimulating her nearer and nearer to orgasm. #slave ");
						if (desire < 50) AddText("seems tense and not really interested.");
						else if (desire < 100) AddText("sighs in pleasure, enjoying the feel of your tongue.");
						else if (desire < 150) AddText("#slave moans and pants in obvious pleasure, quickly approaching her climax.");
						else AddText("loves the feel of your tongue, rapidly approaching orgasm");
						AddText("\r\rYou decide to stop, as the purpose of the act is to arouse her, not make her orgasm.");
						if (desire < 50) AddText("You see #slave seems nowhere near orgasm or seems to care.");
						else if (desire < 100) AddText("#slave looks frustrated being denied her orgasm.");
						else if (desire < 150) AddText("#slave begs you to finish her off. With a little regret you refuse.");
						else AddText("You barely stop soon enough, #slave was on the verge of orgasming. #slave begs you to finish her off. With a little regret you refuse.");
					}
				} else {
					
					if (HasCock) {
						ShowSlave(sdata, 0, 1);
						if (SexPosition == 0) AddText("You have #slave lie down and ");
						else AddText("You have #slave sit down and ");
						AddText(PersonName + " kneels down and slowly licks #slave's cock ");
						if (desire < 50) AddText("who seems distracted and not really interested");
						else if (desire < 100) AddText("who sighs and moans in pleasure");
						else if (desire < 150) AddText("who gasps in pleasure and rests #slavehisher hands on the back of #person's head");
						else AddText("who cries in pleasure and tries to thrust #slavehisher cock into #person's mouth");
						AddText(".\r\r#person ");
						temp = Math.floor(Math.random()*3);
						if (!SlaveFemale) temp = 1;
						switch(temp) {
							case 0: AddText("licks along the shaft of #slave's cock, then licking the head of #slavehisher cock. One of #person's hands strokes #slave's cock and with the other slips fingers into #slave's pussy.\r\r#person licks and strokes faster and faster"); break;
							case 1: AddText("licks and kisses the head of the cock and slowly takes the cock into #personhisher mouth, deeper and deeper, working #personhisher throat until #slave's cock is fully down #personhisher throat.\r\r#slave moans, and then cries as #person bobs #personhisher head up and down, fucking the cock with #personhisher mouth and throat,"); break;
							case 2: AddText("licks and kisses the head of the cock and slowly takes the cock into #personhisher mouth, at the same time working fingers in #slave's pussy and stroking the base of #slavehisher cock.\r\r#person licks and strokes faster and faster"); break;
						}
						AddText(" until you order #personhimher to stop, as the purpose here is to arouse #slave not make #slavehimher cum.\r\r");
						if (desire < 50) {
							Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
							AddText("The slave pulls away, a hand lingering on #slave's cock, who looks a little disappointed.");
						} else if (desire < 100) {
							Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0);
							AddText("The slave pulls away, a hand lingering on #slave's cock, who begs to cum, #slavehisher cock throbbing and intensely erect.");
						} else {
							Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0);
							AddText("As you say this #slave lets out a cry and cums, spraying seemingly directly into the slave's stomach, the slave coughs and pulls free. You scold the slave for allowing #slave to cum and order #personhimher to make #slave erect again. ");
							if (desire < 150) AddText("The slave licks #slave's cock until #slavehisher cock is throbbing and hard.");
							else AddText("The slave licks #slave's cock for some time until #slave cries out again, cumming, spurting #slavehisher cum over the slave's face. You scold them both, but decide to leave it there.");				
						}
						
					} else {
						// male/female/servant cunnilingus
						if (SexPosition == 0) AddText("You have #slave lie down and ");
						else AddText("You have #slave sit down and ");
							
						ShowSlave(sdata, 0, 1);
						AddText(PersonName + " skillfully licks her pussy and clit, stimulating her nearer and nearer to orgasm. #slave ");
						if (desire < 50) AddText("seems tense and not really interested.");
						else if (desire < 100) AddText("sighs in pleasure, enjoying the feel of #personhisher tongue.");
						else if (desire < 150) AddText("moans and pants in obvious pleasure, quickly approaching her climax.");
						else AddText("loves the feel of #personhisher tongue, rapidly approaching orgasm");
						AddText("\r\rYou order #personhimher to stop, as the purpose of the act is to arouse her, not make her orgasm.");
						if (desire < 50) AddText("You see #slave seems nowhere near orgasm or seems to care.");
						else if (desire < 100) AddText("#slave looks frustrated being denied her orgasm.");
						else if (desire < 150) AddText("#slave begs you to let #personhimher finish her off. With a little regret you refuse.");
						else AddText(PersonName + " barely stops soon enough, #slave was one the verge of orgasming. #slave begs you to let #personhimher finish her off. With a little regret you refuse.");
					}
				}
			}
		}
		if (TotalLick == 1) DifficultyLick = DifficultyLick - 5;
		SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
		if (PersonIndex != -100 && HasCock) sdata.ChangeCumslut(1);

	} else {
		Refused(3, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
	}
}


// Master
function DoSexActMaster() {
	
	if (TestObedience(DifficultyMaster, Action)) {
		
		SlaveGirl.ShowSexActMaster();
		if (SelectActImage()) SlaveGirl.ShowChoreDiscuss();

		if (SMData.Gender == 1) AlterSexuality(5);
		else AlterSexuality(-5);
		if (AppendActText) {
			XMLData.DoXMLAct("Master");
			LevelUpSexAct(Action);
			if (AppendActText) {
				if (SMData.Gender == 1) {
					AddText("You allow #slave to sit by your knees, and " + SlaveHeShe + NonPlural(" look") + " up at you with adoration. A question forms in #slavehisher eyes, and you ask #slavehimher what it is. " + SlaveHeSheUC + NonPlural(" say") + " that " + SlaveHeSheIs + " uncomfortable with using your name, since #slaveheshe doesn't want to be too familiar with you. Nodding, you tell #slavehimher that in the future, #slaveheshe will refer to you as \"Master.\"\r\rA shudder runs through #slave, and " + SlaveHeShe + NonPlural(" taste") + " the word on #slavehisher tongue. Nodding, #slaveheshe turns those adoring eyes back to your face.\r\r");
					SlaveSpeak("Yes... Master. Always and forever, my Master.", true);
				} else {
					AddText("Crawling to you and putting " + SlaveHisHer + Plural(" head") + " in your lap, #slave confesses #slavehisher eternal obedience for you. You tell #slavehimher that if #slaveheshe truly feels this way, then #slaveheshe will honour you by always referring to you as 'Mistress', as is proper for a devoted slave. Thinking only briefly on that, " + SlaveHeShe + NonPlural(" smile") + " at you.\r\r");
					SlaveSpeak("Yes, you are " + (SlaveGender > 3 ? "our" : "my") + " Mistress. Yours forever, Mistress.", true);
					AddText("\r\rYou are pleased, it seems, and you allow yourself a brief, tender kiss with your " + Plural("slave") + ", tousling #slavehisher hair. " + NameCase(SlaveHeSheIs) + " really adorable.");
				}
			}
		}
		Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 5, 3, 0, 0, 0, 10, 0);
		DoneMaster = 1;
		UpdateSlaveMaker();
		
	} else {
		
		Refused(14, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -15, -2, 0, 0, -1, -15, 0);

	}
}


// Masturbate
function DoSexActMasturbate() {
	
	if (TestObedience(DifficultyMasturbate, Action)) {
		
		SlaveGirl.ShowSexActMasturbate();
		if (SelectActImage()) Generic.ShowSexActMasturbate();
		
		SMAvatar.ShowSlaveMaker();

		TotalMasturbate++;
		NumMasturbateSinceFucked = NumMasturbateSinceFucked+1;
				
		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Masturbate");
			LevelUpSexAct(Action);

			if (IsDickgirl()) DoMasturbateDickgirl();
			else if (SlaveFemale) DoMasturbateFemale();
			else DoMasturbateMale();
		}

		if (TotalMasturbate == 1) DifficultyMasturbate = DifficultyMasturbate-5;
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddText("\r\rAs #slave nears orgasm suddenly a large cock erupts from her groin. #slave strokes it once and it immediately erupts a torrent of cum, a lot into her own mouth! The cock disappears quickly.");
		if (IsDickgirl()) {
			Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0);
			if (ZodaiEffecting > 0) Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0);
		} else {
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0);
			if (ZodaiEffecting > 0) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0);
		} 
		SMData.SMPoints(0, 0, 0, 0, 0, 2, 0);
		
	} else {
		
		Refused(8, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -4, -2, 0, 0, -1, -4, 0);

	}
}

function DoMasturbateMale()
{
	if (!AppendActText) return;
	
	AddText("#slave masturbates, stroking #slavehisher cock until you tell #slavehimher to stop.");
}


function DoMasturbateDickgirl()
{
	if (!AppendActText) return;
		
	if (LevelUp) {
		switch(LevelMasturbateDG) {
			case -1:
			case 0:
				AddText("You discuss pleasure with #slave in the light of #slavehisher new bodily changes, you ask #slavehisher what #slaveheshe does now when #slaveheshe gets excited on #slavehisher own. \"It gets..you know, but I don't touch it. I'm not a man\" #slave defiantly tells you. You tell her that #slave is not a man, but a feminine, desirable hermaphrodite. You explain #slavehisher cock is part of her and #slaveheshe will have to adjust to it, understand it.\r\r#slave sees the wisdom of this, especially responding to the talk about her femininity. You tell her that #slaveheshe is a good girl and ask her to try touching it a little more after you leave. #slave agrees.\r\rA little later you hear a muffled cry and when you come back, #slave is wearing a small smile, and a damp cloth is on the bed in front of her.");
				break;
			case 1:
				AddText("#slave tells you that when #slaveheshe has desires and #slavehisher cock stiffens, #slaveheshe also feels #slavehisher nipples react. You say that this is perfectly normal and tell #slavehisher to touch #slavehisher own breasts and nipples, so #slaveheshe can get used to the sensation.\r\r\"Now?\" #slave asks, blushing.\r\rIndicating that #slave should go on, #slaveheshe proceeds to cup her own breasts in her hands, squeezing gently. #slave reaches to touch #slavehisher cock and you tell her to only touch her breasts. Feeling her own nipples stiffen, #slaveheshe carefully uses her fingers on them, squeezing her legs together to suppress other sensations rising in her as #slavehisher cock hardens.\r\rYou tell #slavehimher that is enough for now, and #slaveheshe looks confused and disappointed.");
				break;
			case 2:
				AddText("#slave complains that the strange urges #slaveheshe sometimes feels don't seem to calm down even when #slaveheshe touches #slavehisher cock. You tell her that maybe #slaveheshe's not doing it right, and that #slaveheshe had better show you, so you can correct her.\r\rAt first very hesitant, #slave eventually agrees. Stripping off her clothes, #slave curls up, inserting her hand between her legs, carefully stroking #slavehisher cock, moaning silently. You tell her that you need to take more notes, and as you look #slaveheshe gasps and cums, cum spraying over her chest.\r\rYou mildly scold her, explaining that the purpose here was to arouse herself, not to cum. As you tell her this #slave wipes the cum from herself, and you notice her taste some of it.");
				break;
			case 3:
				AddText("You begin instructing #slave in masturbation techniques, first of all telling #slavehisher not to curl up and shield #slavehimherself like that. If #slaveheshe isn't comfortable with her own body, #slave won't reach the satisfaction that will calm her immediate urges.\r\rTrying to follow your lead, #slave opens up a little more, giving you the opportunity to better study the way her small fingers play and stroke #slavehisher cock. You suggest that #slave touch her pussy as well, slipping a finger in with her other hand.");
				break;
			case 4:
				if (ServantGender != 2) AddText("Calling on your assistant, you order " + ServantHimHer + " to show #slave how " + ServantHeShe + " pleasures " + ServantHimHer + "self. When " + ServantHeShe + " denies doing that, you remind " + ServantHimHer + " how you recently entered " + ServantHisHer + " room, finding " + ServantHimHer + " rapidly stoking " + ServantHisHer + " cock. Both of them blush at that, and your assistant relents. As " + ServantHeShe + " spreads " + ServantHisHer + " legs wide for the two of you to see, " + ServantHeShe + " proceeds to squeeze and rub " + ServantHisHer + " cock until it becomes erect. " + NameCase(ServantHeShe) + " strokes " + ServantHisHer + " cock, until " + ServantHeShe + " cries out in orgasm.\r\rInstructing #slave to emulate " + ServantHimHer + ", #slaveheshe tries to.");
				else if (SMData.Gender != 2) AddText("You show #slave how you pleasure yourself. You spread your legs wide for #slave to see, and proceed rub your cock, soon growing erect. You stroke your cock, until you cry out in climax. Instructing #slave to emulate your demonstration, #slave tries to.");
				else AddText("Calling in a male slave, you order him to show #slave how he pleasures himself. He spreads his legs wide for the two of you to see, proceeds to rubs his cock until it becomes erect. He strokes his cock, until he cries out in climax. Instructing #slave to emulate him, #slave tries to.");
				break;
			case 5:
				AddText("#slave has had repeated practice in pleasuring herself and has carefully watched your ");
				if (ServantGender != 2) AddText("assistant's ");
				else if (SMData.Gender != 2) AddText("your ");
				else AddText("slave's ");
				AddText("technique. When you tell her to show you, #slave slowly, almost theatrically spreads her legs wide, then proceeds stroke her already firm cock. You spot the first telltale signs of her growing wetness.\r\rUsing her slim fingers, #slave plays with both #slavehisher cock and cunt quite ardently.\r\rGripping one of her breasts, #slave continues to urgently stroke #slavehisher cock, soon crying out and cumming many spurts of her cum.\r\rTelling you that #slave still feels strange urges from her still hard cock, you tell her to go on. Doing so, #slave turns over, lying on her belly, snaking a hand in between her spread open legs. As #slave pushes herself up a little on her knees, #slavehisher cock hanging down, and puts something below her groin. Her fingers hypnotically drive in and out of her pussy, with you having a perfect view. #slave does not touch #slavehisher cock until #slave is moaning in passion. #slave quickly strokes it and gasps cumming, spurts of cum splattering below with a tiny noise.\r\r#slave continues stoking #slavehisher cock and fingering her pussy and cums several more times. You are satisfied that #slave knows how to pleasure herself, and in front of others as well. There is no need to teach her more, though it could be fun to watch again.\r\rWhen you say this #slave sits up and picks up a small bowl and you realise #slave had been cumming into to each time. #slave lifts the bowl and slurps and licks up all her cum. #slavehisher cock is hard again and #slave says 'More?'");
				break;
		}
	} else {
		switch(LevelMasturbateDG) {
			case -1:
			case 0:
				AddText("You tell #slave to touch herself in your absence, and soon come back, finding her pleased, a damp cloth soaked in her pleasure. Increasing her trust might allow you to supervise.");
				break;
			case 1:
				AddText("You make #slave play with her own breasts and stiff nipples. As #slave becomes more turned on and trusting, you will teach her more.");
				break;
			case 2:
				AddText("Trying to pleasure herself in front of you, her technique is uncertain and inadequate. Turning her on and gaining more trust is vital to the training.");
				break;
			case 3:
				AddText("Spreading her legs a little, #slave shows you how #slave inexperiencedly plays with herself. When #slave is sufficiently turned on, #slave may need to be better at taking instructions as well.");
				break;
			case 4:
				if (ServantGender != 2) AddText("First your assistant demonstrates masturbation,");
				else if (SMData.Gender != 2) AddText("First you demonstrate masturbation,");
				else AddText("First your slave demonstrates masturbation,");
				AddText(" then #slave tries to emulate. Turning her on should allow her to let herself go completely.");
				break;
			case 5:
				AddText("#slave expertly masturbates in various positions. #slave need learn no more about this.");
				break;
		}
	}
}

function DoMasturbateFemale()
{
	if (!AppendActText) return;
	
	if (LevelUp) {
		switch(LevelMasturbate) {
			case -1:
			case 0:
				AddText("Discussing pleasure with #slave, you ask her what #slave does when #slave gets excited on her own. \"Nothing,\" #slave whispers, casting her eyes down. Probing her, it seems that #slave is serious, not acting on any sexual urges that arise in her. Explaining to her that it can be harmful if #slave denies her own desires, you go on to tell her that healthy young women pleasure themselves so their feelings won't distract them in their everyday life.\r\r#slave sees the wisdom of this, but is uncertain how one would go about acting on these desires, if one actually had them. Asking her where #slave might feel these desires, if #slave has them, #slave blushes furiously, then hesitantly points towards her crotch. You tell her that #slave is a good girl and asks her to try touching it a little more after you leave. #slave agrees. When you come back, #slave is wearing a small smile.");
				break;
			case 1:
				AddText("#slave tells you that when #slave has desires, #slave also feels her nipples react. You say that this is perfectly normal and tell her to touch her own breasts and nipples, so #slave can get used to the sensation. \"Now?\" #slave asks, blushing. Indicating that #slave should go on, #slave proceeds to cup her own breasts in her hands, squeezing gently. Feeling her own nipples stiffen, #slave carefully uses her fingers on them, squeezing her legs together to suppress other sensations rising in her.");
				break;
			case 2:
				AddText("#slave complains that the strange urges #slave sometimes feels don't seem to calm down even when #slave touches herself. You tell her that maybe she's not doing it right, and that #slave had better show you, so you can correct her. At first very hesitant, #slave eventually agrees. Stripping off her clothes, #slave curls up, inserting her hand between her legs, carefully stroking her own pussy, moaning silently. You tell her that you need to take more notes.");
				break;
			case 3:
				AddText("You begin instructing #slave in masturbation techniques, first of all telling her not to curl up and shield herself like that. If #slave isn't comfortable with her own body, #slave won't reach the satisfaction that will calm her immediate urges.\r\rTrying to follow your lead, #slave opens up a little more, giving you the opportunity to better study the way her small fingers play with her own wet pussy.");
				break;
			case 4:
				if (ServantGender == 2) AddText("Calling on your assistant, you order her to show #slave how #assistant pleasures herself. When #assistant denies doing that, you remind her how you recently entered her room, finding her with two fingers shoved far up her own wet cunt. Both of them blush at that, and your assistant relents. As #assistant spreads her legs wide for the two of you to see, #assistant proceeds to finger her cunt and clit, soon growing wet. Several fingers vanish into her crack while #assistant rubs her clit, until #assistant cries out in orgasm. Instructing #slave to emulate her, #slave tries to.");
				else if (SMData.Gender == 2) AddText("You show #slave how you pleasure yourself. You spread your legs wide for #slave to see, and proceed to finger your cunt and clit, soon growing wet. Several fingers vanish into your crack while you rub your clit, until you cry out in orgasm. Instructing #slave to emulate your demonstration, #slave tries to.");
				else AddText("Calling in a female slave, you order her to show #slave how #slave pleasures herself. #slave blushes a little and relents. As #slave spreads her legs wide for the two of you to see, #slave proceeds to finger her cunt and clit, soon growing wet. Several fingers vanish into her crack while #slave rubs her clit, until #slave cries out in orgasm. Instructing #slave to emulate her, #slave tries to.");
				break;
			case 5:
				AddText("#slave has had repeated practice in pleasuring herself and has carefully watched your ");
				if (ServantGender == 2) AddText("assistant's ");
				else if (SMData.Gender != 2) AddText("slave's ");
				AddText("technique. When you tell her to show you, #slave slowly, almost theatrically spreads her legs wide, then proceeds to finger herself. You spot the first telltale signs of her growing wetness. Using her slim fingers, #slave plays with both clit and cunt quite ardently.\r\rGripping one of her breasts, #slave continues to thrust fingers into herself, soon crying out in orgasm. Telling you that #slave still feels strange urges, you tell her to go on. Doing so, #slave turns over, lying on her belly, snaking a hand in between her spread open legs. As #slave pushes herself up a little on her knees, her fingers hypnotically drive in and out of her, with you having a perfect view.\r\rRepeatedly #slave comes and start over again in new positions. You are satisfied that #slave knows how to pleasure herself, and in front of others as well. There is no need to teach her more, though it could be fun to watch again.");
				break;
		}
	} else {
		switch(LevelMasturbate) {
			case -1:
			case 0:
				AddText("You tell #slave to touch herself in your absence, and soon come back, finding her pleased. Increasing her trust might allow you to supervise.");
				break;
			case 1:
				AddText("You make #slave play with her own breasts and stiff nipples. As #slave becomes more turned on and trusting, you will teach her more.");
				break;
			case 2:
				AddText("Trying to pleasure herself in front of you, her technique is uncertain and inadequate. Turning her on and gaining more trust is vital to the training.");
				break;
			case 3:
				AddText("Spreading her legs a little, #slave shows you how #slave inexperiencedly plays with herself. When #slave is sufficiently turned on, #slave may need to be better at taking instructions as well.");
				break;
			case 4:
				if (ServantGender == 2) AddText("First your assistant demonstrates masturbation,");
				else if (SMData.Gender == 2) AddText("First you demonstrate masturbation,");
				else AddText("First your slave demonstrates masturbation,");
				AddText(" then #slave tries to emulate. Turning her on should allow her to let herself go completely.");
				break;
			case 5:
				AddText("#slave expertly masturbates in various positions. #slave need learn no more about this.");
				break;
		}
	}
}


// Orgy
// 21.0 mixture
// 21.2 female only
// 21.3 dickgirl only
function DoSexActOrgy() {
	if (TestObedience(DifficultyOrgy, Action)) {
		
		if (SlaveGirl.ShowSexActOrgy() != true) SlaveGirl.ShowSexActGroup();
		if (SelectActImage()) Generic.ShowSexActOrgy();
		
		ResetNotFucked();
		TotalGroup++;
		if (TotalGroup == 1) DifficultyOrgy = DifficultyOrgy - 5;


		var moralitydec:Number = -1;
		if (SMData.SMFaith != 1) moralitydec = 0;
		
		if (Lesbian) {
			AlterSexuality(-2);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
			
		if (SexPoints(0, 1, 0, 0, moralitydec, 1, 0, 0, 0, 1, 1, 0, 3, 2, -3, 0, 4, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Orgy");
			LevelUpSexAct(Action);
	
			if (totdickgirls > 0 && (totmales + totfemales) == 0 ) {
				// dickgirl only
				if (AppendActText) {
					if (VarObedienceRounded<15) {
						AddText(SlaveHeSheUC + NonPlural(" does") + " not like fucking with a group.\r\r");
						if (SMData.Gender == 2) AddText(", #slaveheshe only fucked with you.\r\r");
					} else if (VarObedienceRounded<30) {
						AddText(SlaveHeSheUC + NonPlural(" enjoy") + " fucking in a group and changed partners.\r\r");
					} else if (VarObedienceRounded<70) {
						AddText(SlaveHeSheUC + " fucked everyone at least once and loudly came several times.");
					} else {
						AddText(SlaveHeSheUC + " did #slavehisher best to fuck everyone in every combination possible, cumming often and happily drinking #slavehisher partners cum.");
					}
				}
				CheckImpregnate("Human");
				for (var pa:String in Participants) {
					idx = int(Number(Participants[pa]));
					if (idx == -100) SMData.CheckImpregnate("Human");
					else SlavesArray[idx].CheckImpregnate("Human");
				}
			} else if (totfemales > 0 && (totdickgirls + totfemales) == 0 ) {
				if (AppendActText) {
					if (TotalGroup < 3) {
						AddText(SlaveHeSheUC + NonPlural(" does") + " not like sex with a group of women.\r\r");
					} else if (TotalGroup < 8 && VarObedienceRounded<30) {
						AddText(SlaveHeSheUC + NonPlural(" enjoy") + " sex with the group of women and changed partners.\r\r");
					} else if (TotalGroup < 10 && VarObedienceRounded<70) {
						AddText(SlaveHeSheUC + " licked, rubbed, caressed everyone making them all orgasm, and orgasming several times loudly.");
					} else {
						AddText(SlaveHeSheUC + " did #slavehisher best to please everyone present, orgasming often and trying to make them orgasm at least as often.");
					}
				}
			} else {
				// Mixture
				if (AppendActText) {
					if (VarObedienceRounded<15) {
						AddText(SlaveHeSheUC + NonPlural(" does") + " not like fucking with a group.\r\r");
						if (SMData.Gender == 2) AddText(", #slaveheshe only fucked with you.\r\r");
					} else if (VarObedienceRounded<30) {
						AddText(SlaveHeSheUC + NonPlural(" enjoy") + " fucking in a group and changed partners.\r\r");
					} else if (VarObedienceRounded<70) {
						AddText(SlaveHeSheUC + " fucked everyone at least once and loudly came several times.");
					} else {
						AddText(SlaveHeSheUC + " did #slavehisher best to fuck everyone in every combination possible, cumming often and happily drinking #slavehisher partners cum.");
					}
				}
				CheckImpregnate("Human");
				for (var pa:String in Participants) {
					idx = int(Number(Participants[pa]));
					if (idx == -100) SMData.CheckImpregnate("Human");
					else SlavesArray[idx].CheckImpregnate("Human");
				}
			}
		}
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddTextToStart("While you are fucking another woman you hear #slave cry in passion and you look. You see " + SlaveHeSheHas + " " + Plural("a large cock") + " and " + SlaveHeSheIs + " cumming in a huge spray.\r\r");
		if (TotalGroup == 1) DifficultyGangBang = DifficultyGangBang-2;
		if (SMAdvantages.CheckBitFlag(6) && !Lesbian) DickgirlRate = DickgirlRate + 0.5;
		SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		VirginAnal = false;
		VirginOral = false;
		VirginVaginal = false;
		if (!Lesbian) ChangeCumslut(1);

	} else {
		Refused(20, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0);
	}
}

function DoSexActSpank() {
	if (TestObedience(DifficultySpank, Action)) {
		
		lastmc = null;
		SlaveGirl.ShowSexActSpank(SMData.IsDominatrix() && SMData.IsWeaponClassOwned("whip"));
		if (SelectActImage(true)) Generic.ShowSexActSpank(SMData.IsDominatrix() && SMData.IsWeaponClassOwned("whip"));
		
		if (lastmc != null) StartShakeIt(lastmc, 50, "");
		
		DoneSpank++;
		TotalSpank++;
		if (DoneSpank > 2 && Slutiness < 6) {
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -1, -1, 0, 2, -1, -1, 0);
			if (ZodaiEffecting > 0) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -1, -1, 0, 4, -1, -1, 0);
			if (AppendActText) XMLData.DoXMLAct("Spanking");
			LevelUpSexAct(Action);
			if (AppendActText) {
				SlaveSpeak("Owww! Owww! Stop please!", true);
				AddText("\r\r");
				ServantSpeak("#slave seems to be in pain.", true);
				if (SMData.IsDominatrix()) AddText("\r\rYou smile.");
			}
			MaxObedience = SlaveStatistics.CapMax(MaxObedience, -0.5, AssistantMaxObedience);
		} else if (SMData.IsDominatrix() && SMData.IsWeaponClassOwned("whip")) {
			if (AppendActText) XMLData.DoXMLAct("Spanking");
			LevelUpSexAct(Action);
			Sounds.PlaySound("Whipping");
			if (SMData.sWhipExpertise < 60) SMData.sWhipExpertise += 0.5;

			if (DoneScold || BadGirl == 1) {
				if (Slutiness > 5) {
					if (AppendActText) {
						SlaveSpeak("Ahhh! Ohhhh! " + SlavePronoun + " am a very bad girl, whip me more!", true);
						if (HasCock) AddText("\r\r#slave loves the pain and is very aroused. You make sure the whip sometimes hits #slavehisher cock to stimulate #slavehimher.");
						else AddText("\r\r#slave loves the pain and is very aroused. You make sure the whip sometimes hits #slavehisher pussy to stimulate her.");
					}
					Points(0, 0, 0, 0, 0.5, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, 0, 1, 0);
				} else {
					if (AppendActText) {
						SlaveSpeak("Ahhhh! Ohhh! Please, please, enough, " + SlavePronoun + " will try to be good!", true);
						AddText("\r\r");
					}
					if (Aroused) {
						if (HasCock) ServantSpeak("#slave really seems to like the pain, especially if you hit #slavehisher cock.", true);
						else ServantSpeak("#slave really seems to like the pain, especially if you hit her pussy.", true);
					}
					Points(0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, 0, 1, 0);
				}
				if (ZodaiEffecting > 0) Points(0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, 0, 1, 0);
				if (DoneSpank == 1) MaxObedience = SlaveStatistics.CapMax(MaxObedience, 0.5, AssistantMaxObedience);
			} else {
				if (AppendActText) {
					if (Slutiness > 5) {
						if (SlaveFemale) SlaveSpeak("Ahhh! Ohhhh! " + SlavePronoun + " am a bad girl, whip me more!", true);
						else SlaveSpeak("Ahhh! Ohhhh! " + SlavePronoun + " am a bad boy, whip me more!", true);
						if (HasCock) AddText("\r\r#slave loves the pain and is very aroused. You make sure the whip sometimes hits #slavehisher cock to stimulate #slavehimher.");
						else AddText("\r\r#slave loves the pain and is very aroused. You make sure the whip sometimes hits her pussy to stimulate her.");
					} else {
						SlaveSpeak("Ohhh! Ahhhhh! " + SlavePronoun + " have already been good, please please whip, I mean don't whip me!", true);
						AddText("\r\r");
						if (Aroused) if (SlaveGirl.SpankComment() != true) {
							if (HasCock) ServantSpeak("#slave really seems to like the pain, especially if you hit #slavehisher cock.", true);
							else ServantSpeak("#slave really seems to like the pain, especially if you hit her pussy.", true);
						}
					}
				}
				var moralitychange:Number = 0.5;
				var joychange:Number = 0;
				if (SMData.SMFaith == 2) {
					moralitychange = 0;
					joychange = -0.5;
				}
				Points(0, 0, 0, 0, moralitychange, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, joychange, 0, 0);
				if (ZodaiEffecting > 0) Points(0, 0, 0, 0, moralitychange, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, joychange, 0, 0);
			}
			if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddTextToStart("You see #slave has grown a large cock again. As #slave is whipped it grows more and more erect.\r\r");
			MaxObedience = SlaveStatistics.CapMax(MaxObedience, 0.5, AssistantMaxObedience);
			Behaving = Behaving + 0.5;
			
			if (SMAdvantages.CheckBitFlag(23)) {
				MaxObedience = SlaveStatistics.CapMax(MaxObedience, 0.5, AssistantMaxObedience);
				Behaving = Behaving + 0.5;
			}

		} else {
			Sounds.PlaySound("Spank");
			if (AppendActText) XMLData.DoXMLAct("Spanking");
			LevelUpSexAct(Action);
	
			if (DoneScold || BadGirl == 1) {
				if (Slutiness > 5) {
					if (AppendActText) {
						if (SlaveFemale) {
							SlaveSpeak("Ohhh! Owww! " + SlavePronoun + " am a very bad girl, spank me harder! Why don't you spank #assistant too, #assistantheshe would love it!", true);
							AddText("\r\r#slave loves the pain and is very aroused. #slave appears to orgasm just from the spanking!");
						} else {
							SlaveSpeak("Ohhh! Owww! " + SlavePronoun + " am a very bad boy, spank me harder! Why don't you spank #assistant too, #assistantheshe would love it!", true);
							AddText("\r\r#slave loves the pain and is very aroused. #slave appears to cum just from the spanking!");
						}
					}
					Points(0, 0, 0, 0, 0.5, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, 0, 1, 0);
				} else {
					if (AppendActText) {
						SlaveSpeak("Owww! Ohhh! Ok, " + SlavePronoun + " will try to be good!", true);
						AddText("\r\r");
					}
					if (Aroused) if (SlaveGirl.SpankComment() != true) {
						if (HasCock) ServantSpeak("#slave really seems to be enjoying it, #slave's cock is very hard.", true);
						else ServantSpeak("She really seems to be enjoying it, #slave is very wet.", true);
					}
					Points(0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, 0, 1, 0);
				}
				if (ZodaiEffecting > 0) Points(0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, 0, 1, 0);
				if (DoneSpank == 1) MaxObedience = SlaveStatistics.CapMax(MaxObedience, 0.5, AssistantMaxObedience);
			} else {
				if (AppendActText) {
					if (Slutiness > 5) {
						if (SlaveFemale) {
							SlaveSpeak("Ohhh! Owww! " + SlavePronoun + " am a bad girl, spank me harder! Why don't you spank #assistant too, #assistantheshe would love it!", true);
							AddText("\r\r#slave loves the pain and is very aroused. #slave appears to orgasm just from the spanking!");
						} else {
							SlaveSpeak("Ohhh! Owww! " + SlavePronoun + " am a bad boy, spank me harder! Why don't you spank #assistant too, #assistantheshe would love it!", true);
							AddText("\r\r#slave loves the pain and is very aroused. #slave appears to cum just from the spanking!");
						}
					} else {
						SlaveSpeak("Ohhh! Owww! " + SlavePronoun + " have already been good!", true);
						AddText("\r\r");
						if (Aroused) if (SlaveGirl.SpankComment() != true) {
							if (HasCock) ServantSpeak("#slave really seems to be enjoying it, #slave's cock is very hard.", true);
							else ServantSpeak("She really seems to be enjoying it, #slave is very wet.", true);
						}
					}
				}
				var moralitychange:Number = 0.5;
				var joychange:Number = 0;
				if (SMData.SMFaith != 1) {
					moralitychange = 0;
					joychange = -0.5;
				}
				Points(0, 0, 0, 0, moralitychange, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, joychange, 0, 0);
				if (ZodaiEffecting > 0) Points(0, 0, 0, 0, moralitychange, 1, 0, 0, 0, 0, 0, -1, 0, 0, 2, 0, 2, joychange, 0, 0);
			}
			if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddTextToStart("You see #slave has grown a large cock again. As #slave is spanked it grows more and more erect.\r\r");
			MaxObedience = SlaveStatistics.CapMax(MaxObedience, (StatRate * 0.5), AssistantMaxObedience);
			Behaving = Behaving + (StatRate * 0.5);
			if (SMAdvantages.CheckBitFlag(23)) {
				MaxObedience = SlaveStatistics.CapMax(MaxObedience, 0.5, AssistantMaxObedience);
				Behaving = Behaving + 0.5;
			}
		}
		SMData.SMPoints(0, 0, 0, 0, 0, 2, 0, 0, 1);

	} else {
		Refused(18, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0);
	}
}


// Strip Tease
function DoSexActStripTease()
{
	if (TestObedience(DifficultyExhib, Action)) {

		if (SlaveGirl.ShowSexActStripTease() != true) {
			UseGeneric = !UseImages;
			if (SelectActImage()) {
				SlaveGirl.ShowJobSleazyBar(true);
				if (UseGeneric) ShowActImage(1015);
			} 
			SetText("");
		}
		
		TotalStripTease++;
				
 		if (SexPoints(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 2, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("StripTease");
			LevelUpSexAct(Action);

			if (AppendActText) {
				if (Slutiness > 5 || VarLibidoRounded > 70 || VarNymphomaniaRounded > 60) {
					if (Math.floor(Math.random()*2) == 0 && SlaveFemale) {
						AddText(SlaveVerb("perform") + " a very sensual striptease, caressing #slavehimherself as #slaveheshe removes #slavehisher clothing. #slave spends a lot of time rubbing #slavehisher breasts through her clothing and then as #slave removes her panties #slave virtually masturbates herself as #slave rubs them and pulls them.");
						if (HasCock) AddText("#slave's cock is clearly visible and very erect, sometimes #slaveheshe touches it and lightly strokes it.");
					} else {
						if (HasCock) AddText(SlaveVerb("perform") + " an energetic dance, occasionally removing bits of clothing and always rubbing, caressing #slavehimherself and stroking #slavehisher cock. Part way #slave orgasms in an exaggerated fashion, throwing off a piece of clothing as #slavehisher cum flies in spurts through the air.\r\r#slave quickly continues #slavehisher dance a bit slower and more seductively, taking care to not show #slavehisher cock again.");
						else AddText(SlaveVerb("perform") + " an energetic dance, occasionally removing bits of clothing and always rubbing, caressing her self. Part way #slaveheshe orgasms in an exaggerated fashion, throwing off a piece of clothing as #slave does.\r\r#slave quickly continues her dance a bit slower and more seductively, always hiding her groin.");
					}
					AddText("\r\rFinally with #slavehisher back to you #slave removes #slavehisher underwear and then seductively turns and reveals #slavehimherself to you. #slave is breathing heavily from the energetic dancing and from #slavehisher arousal.");
					if (HasCock) AddText(" #slavehisher cock is fully, throbbingly erect.");
				}
				else if (VarConstitution > 50 || VarLibidoRounded > 50) {
					if (Math.floor(Math.random()*2) == 0) {
						AddText(SlaveVerb("perform") + " a slow seductive striptease, keeping " + SlaveHisHer + CockPussyText() + " always hidden, even once #slave has removed #slavehisher underwear. #slave slowly removes the rest of #slavehisher clothes and is sitting with #slavehisher back to you. #slave slowly swivels around and reveals ");
						if (HasCock) AddText("#slavehisher naked body and erect cock.");
						else AddText("#slavehisher naked form and moist pussy.");
					} else {
						AddText(SlaveVerb("perform") + " a slow seductive striptease, dancing and swaying with one hand almost always ");
						if (HasCock) AddText("stroking or holding #slavehisher cock");
						else AddText("at her pussy, rubbing and cupping");
						AddText(". #slave's breathing and dancing speeds up and as #slave removes #slavehisher last piece of clothing, #slave ");
						if (HasCock) AddText("gasps and cums, spurting cum towards you!");
						else AddText("cries out and orgasms, a sweet shuddering orgasm.");
					}
				} else {
					AddText(SlaveVerb("perform") + " a simple striptease, sensually but simply removing #slavehisher clothes. " + SlaveHeSheUCVerb("look") + " a little aroused as #slaveheshe finally " + NonPlural("stand") + " naked before you.");
				}
			}
		}
		if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddText("\r\rWhen #slave finally reveals herself, to <i>both<i> of your surprise, #slave has a large, erect cock. #slave curiously touches it and cries out, cumming large jets of cum. #slave screams and cries through her orgasm, until it finally stops and the cock shrinks and vanishes.");
		SMData.SMPoints(0, 0, 0, 0, 0, 1, 0);
	} else {
		Refused(25, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -3, -2, 0, 0, -1, -5, 0);
	}
}


// Threesome
function DoSexActThreesome() 
{
	if (TestObedience(DifficultyThreesome, Action)) {
		
		UseGeneric = false;
		PersonName = SlaveGirl.ShowSexActThreesome();
		
		var MainPerson:String;
		var person1:Number = Participants[0];
		if (person1 == -100) {
			MainPerson = "you";
			SMAvatar.ShowSlaveMaker();
			ByYou = true;
		} else if (person1 == -99) {
			MainPerson = ServantA;
			ShowAssistant();
		} else {
			sdata = SlavesArray[person1];
			MainPerson = sdata.SlaveName;
			ShowSlave(sdata, 0, 1);
		}
		var person2:Number = Participants[1];
		if (person2 == -100) {
			PersonName = "you";
			SMAvatar.ShowSlaveMaker();
			ByYou = true;
		} else if (person2 == -99) {
			PersonName = ServantB;
			ShowAssistant();
		} else {
			sdata = SlavesArray[person2];
			PersonName = sdata.SlaveName;
			ShowSlave(sdata, 0, 1);
		}
		
		if (SelectActImage()) Generic.ShowSexActThreesome();

		ByYou = false;
				
		ResetNotFucked();
		TotalThreesome++;

		if (Lesbian) {
			AlterSexuality(-1);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
		
		if (SexPoints(0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 2, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Threesome");
			LevelUpSexAct(Action);			

			if (AppendActText) {
				if (VarObedienceRounded<15) {
					AddText("#slave still doesn't really accept " + MainPerson + " and barely touched #person.");
				} else if (VarObedienceRounded<50) {
					AddText("#slave seems to enjoy this and helped " + MainPerson + " and #person to cum.");
				} else if (VarObedienceRounded<80) {
					AddText("#slave seems to love being able to lick and caress " + MainPerson + " and #person.");
				} else {
					AddText("Looks like #slaveheshe doesn't want to stop. #slave enthusiastically pleasures " + MainPerson + " as much as #person.");
				}
			}
		}
		
		if (ByYou) {
			if (StandardDGText && DickgirlChanged && (!SlaveGirl.IsDickgirl())) AddTextToStart("You and the other person start caressing #slave, #slave grows a large cock...\r\r");
			if (SMAdvantages.CheckBitFlag(6) && !Lesbian) {
				DickgirlRate++;
				AddText("\r\r" + SlaveVerb("savour") + " your cum, licking #slavehisher lips.");
			}
			SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
		}
		if (PersonIndex != -100 && (HasCock || SMData.Gender == 1 || SMData.Gender == 3)) sdata.ChangeCumslut(1);
		
	} else {
		Refused(19, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0);
	}
}


// Tits Fuck
function DoSexActTitsFuck() {
	if (TestObedience(DifficultyTitsFuck, Action)) {
		
		SlaveGirl.ShowSexActTitFuck();
		if (SelectActImage()) Generic.ShowSexActTitFuck();
		
		NumTitsFuckSinceFucked = NumTitsFuckSinceFucked+1;
		TotalTitsFuck++;
		TotalBlowjob++;
		
		if (Lesbian) {
			AlterSexuality(-2);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			AlterSexuality(1);
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.5, 0, 0, 0, ReluctanceLevel * -0.5, ReluctanceLevel * -0.5, 0);
		}
		
		var vo:Boolean = VirginOral;
		
		if (SexPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("TitsFuck");
			LevelUpSexAct(Action);

			if (PersonIndex == -100 && SMData.Gender != 2) {
				// male/dickgirl slavemaker titfuck
				if (AppendActText) {
					if (VarObedienceRounded<15) {
						AddText("#slave doesn't seem to like to do that, complaining it is awkward.");
					} else if (VarObediencRounded<30) {
						AddText("#slave seems to enjoy making you cum with her tits and seems to be stimulated as #slave plays with her nipples..");
					} else if (VarObedienceRounded<70) {
						AddText("#slave works harder to make you feel good, #slave plays expertly with her breasts and nipples.");
					} else {
						AddText("Looks like #slave won't let you go, it almost seems like #slave could orgasm just from this.");
					}
				}
				SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
				ChangeCumslut(1);
				
			} else if (PersonIndex == -100) {
				// masturbate female slave maker (lesbian)
				if (AppendActText) {
					if (VarObedienceRounded<15) {
						AddText("#slave is awkward in touching you and fails to make you orgasm.");
					} else if (VarObediencRounded<30) {
						AddText("#slave seems to enjoy touching and caressing you and easily brings you to a satisfying orgasm.");
					} else if (VarObedienceRounded<70) {
						AddText("#slave enjoys touching you and works expertly to bring you carefully nearer and nearer to orgasm and then, with skill you cum to a loud crying orgasm.");
					} else {
						AddText("#slave is tender and arouses you expertly to several strong orgasms. #slave is flushed and aroused but awaits your touch to make her orgasm.");
					}
				}
				SMData.SMPoints(0, 0, 0, 0, 0, -5, 0);
				
			} else if (PersonGender == 2) {
				// masturbate female assistant/slave
				if (AppendActText) {
					ShowSlave(sdata, 0, 1);
					if (VarObedienceRounded<15) {
						AddText("#slave is awkward in touching #person and fails to make her orgasm.");
					} else if (VarObediencRounded<30) {
						AddText("#slave seems to enjoy touching and caressing #person and easily brings her to a satisfying orgasm.");
					} else if (VarObedienceRounded<70) {
						AddText("#slave enjoys touching #person and works expertly to bring her carefully nearer and nearer to orgasm and then, with skill #slave cums to a loud crying orgasm.");
					} else {
						AddText("#slave is tender and arouses #person expertly to several strong orgasms. #slave is flushed and aroused but awaits her touch to make her orgasm.");
					}
				}
			
			} else {
				// 6.4 = titfuck to male slave
				// 6.5 = titfuck to male/dickgirl assistant
				// 6.6 = titfuck to dickgirl slave
				if (AppendActText) {
					ShowSlave(sdata, 0, 1);
					if (VarObedienceRounded<15) {
						AddText("#slave doesn't seem to like to do that to #person, complaining it is awkward.\r\r");
					} else if (VarObediencRounded<30) {
						AddText("#slave seems to enjoy making #person cum with her tits and seems to be stimulated as #slave plays with her nipples..");
					} else if (VarObedienceRounded<70) {
						AddText("#slave works harder to make #person feel good, #slave plays expertly with her breasts and nipples.\r\r");
					} else {
						AddText("Looks like #slave won't let #persons cock go, it almost seems like #slave could orgasm just from this.");
					}
				}
				ChangeCumslut(1);
			}
		}
		if (StandardDGText) {
			if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*2) == 1) {
				DickgirlChanged = true;
				Icons.ShowDickgirlIconNow();
				if (SMData.Gender == 2) AddText("\r\rAfter the slave cums, ");
				else AddText("\r\rAfter you cum, ");
				if (LesbianTraining) AddText("#assistant tells you how #slave grew a large cock while caressing you. #slave stroked it urgently and came with you. The cock immediately shrunk and disappeared.");
				else AddText("#assistant tells you how #slave grew a large cock while tit-fucking you. #slave stroked it urgently and came with you. The cock immediately shrunk and disappeared.");
				if (RulesTouchHerself == 0) {
					AddText("#assistant scolds her for masturbating without permission.");
					BadGirl = 1;
				}
			} else if (DickgirlChanged && (!SlaveGirl.IsDickgirl())) {
				if (LesbianTraining) AddTextToStart("The #slave starts to caress you, you see #slave has grown a large cock. You tell her to continue...\r\r");
				else if (SMData.Gender == 2) AddTextToStart("The slave starts to fuck his cock between her tits and you see #slave has grown a large cock. The slave alters his fucking, so he is not on #slavehisher cock...\r\r");
				else AddTextToStart("You start to fuck your cock between her tits and feel something. You look and see #slave has grown a large cock. You instead work out how to work your cock with her tits, so you are not on #slavehisher cock...\r\r");
			}
		}
		
		if (TotalTitsFuck == 1) DifficultyTitsFuck = DifficultyTitsFuck-5;
		if (NippleChainWorn == 1 || NippleRingsWorn == 1) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		if (!Lesbian && IsCumslutTraining() && PersonGender != 2 && PersonGender != 5 && PersonGender != 0) {
			if (vo) AddText(" #slave is surprised at the taste of cum. #slave did not realise it is so salty and nice.\r\r");
			else AddText(" #slave is eager to taste as much cum as #slave can.\r\r");
			ChangeCumslut(1);
		}
	
		if (SMAdvantages.CheckBitFlag(6) && PersonIndex == -100) {
			DickgirlRate++;
			AddText("\r\r" + SlaveVerb("savour") + " your cum, licking it from #slavehisher breasts.");
		}
		
	} else {
		Refused(6, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2, 0);
	}
}


// Touch
// 2.0 = touch by male slave maker (all slave genders)
// 2.1 = handjob or touch by female/dickgirl slavemaker (all slave genders)
// 2.2 = handjob or touch by female slave
// 2.3 = touch by male slave
// 2.4 = handjob or touch by assistant
// 2.5 = handjob or touch by dickgirl slave

function DoSexActTouch() {
	if (TestObedience(DifficultyTouch, Action)) {
		
		SlaveGirl.ShowSexActTouch();
		if (SelectActImage()) Generic.ShowSexActTouch();
		
		NumTouchSinceFucked++;
		TotalTouch++;

		var libidoinc:Number = 1;
		if (IsDickgirl()) libidoinc = -2;
				
		if (Lesbian) {
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls)) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.25, 0, 0, 0, ReluctanceLevel * -0.25, ReluctanceLevel * -0.25, 0);
			else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			if (modulesList.trainLesbians.IsResistingAct(LastActionDone, totmales, totfemales, totdickgirls))Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ReluctanceLevel * -0.25, 0, 0, 0, ReluctanceLevel * -0.25, ReluctanceLevel * -0.25, 0);
		}
				
		if (SexPoints(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, libidoinc, 0, 0, 0, 0, 0)) {
			if (AppendActText) XMLData.DoXMLAct("Touch");
			LevelUpSexAct(Action);

			// additional stat effects
			if (NippleChainWorn == 1 || NippleRingsWorn == 1) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			if (SMData.IsDominatrix()) {
				// Dominatrix
				if (TotalLesbian == 0 && SMData.Gender != 1) {
					DifficultyLesbian = DifficultyLesbian - 0.5;
					Points(0, 0, 0, 0, -0.5, 0, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, 0, 0, -0.5, 0, 0);
				}
				if (SMData.Gender == 1) AlterSexuality(1);
				else if (SMData.Gender == 2) AlterSexuality(-1);
				else AlterSexuality(-0.5);
			} else if (PersonIndex == -100 && SMData.Gender == 1) {
				// Male Slave Maker
				AlterSexuality(1);
			} else if (PersonIndex == -100) {
				// Female/Dickgirl Slave Maker
				if (SMData.Gender == 2) AlterSexuality(-1);
				else AlterSexuality(-0.5);
				if (TotalLesbian == 0 && SlaveFemale) {
					DifficultyLesbian = DifficultyLesbian - 0.5;
					Points(0, 0, 0, 0, -0.5, 0, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, 0, 0, -0.5, 0, 0);
				}

			} else if (PersonGender != 1) {
				// Female Slave/Assistant
				AlterSexuality(-0.5);
				if (TotalLesbian == 0 && SlaveFemale) {
					DifficultyLesbian = DifficultyLesbian - 0.5;
					Points(0, 0, 0, 0, -0.5, 0, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, 0, 0, -0.5, 0, 0);
				}
			} else {
				// Male Slave/Assistant
				AlterSexuality(0.5);
			}

			// Description
			if (AppendActText) {
				if (StandardDGText) {
					if (DickgirlChanged && (!IsPermanentDickgirl())) {
						AddText("As ");
						if (PersonIndex == -100) AddText("you start");
						else AddText(PersonName + " starts");
						AddText(" #slave suddenly cries out and grows a large erect cock, ");
					}
				}
				var sensitivity:Number = (VarLibidoRounded / 2) + VarSensibilityRounded;
				if (SMData.IsDominatrix()) {
					// Dominatrix
					DoDominatrixTouch(sensitivity);
				} else if (PersonIndex == -100 && SMData.Gender == 1) {
					// Male Slave Maker
					DoMaleSMTouch(sensitivity);
				} else if (PersonIndex == -100) {
					// Female/Dickgirl Slave Maker
					DoFemaleSMTouch(sensitivity);
				} else if (PersonGender != 1) {
					// Female Slave/Assistant
					DoFemaleSlaveTouch(sensitivity);
				} else {
					// Male Slave/Assistant
					DoMaleSlaveTouch(sensitivity);
				}
			}
		}
		if (StandardDGText) {
			if (DickgirlChangable && DickgirlChanged == false && Math.floor(Math.random()*2) == 1) {
				AddText("\r\rAs ");
				if (PersonIndex == -100) AddText("you caress ");
				else AddText(PersonName + " caresses ");
				AddText(SlaveHimHer + " you see #slave's clit grow large and very erect almost like a small cock. #slave rubs it almost unconsciously.");
			}
		}
		if (TotalTouch == 1) DifficultyTouch = DifficultyTouch-4;

	} else {
		Refused(2, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, -1, 0, 0, -1, -2);
	}
}

function DoMaleSlaveTouch(sensitivity:Number)
{
	var sgirl:Slave;
	ShowSlave(sdata, 0, 1);
	AddText(PersonName + " moves next to #slave and starts to run his hands over #slavehisher body, caressing #slavehisher ");
	if (HasCock) AddText("cock");
	else AddText("breasts and touching pussy");
	AddText("and ass. Sometimes he crudely gropes #slavehisher ");
	if (HasCock) AddText("cock");
	else AddText("breasts");
	AddText("or ass, and you tell him to stop. You make sure he does not stimulate #slavehisher " + CockPussyText() + " too much. You are trying to make #slavehimher more aware of #slavehisher body and to arouse, but not have him masturbate #slavehimher and make #slavehimher orgasm.\r\r");
	if (sensitivity < 50) AddText("#slave does not respond much to #person touch, a little confused, expecting him to make #slavehimher orgasm.");
	else if (sensitivity < 90) {
		AddText("#slave sighs, moving beneath #person's touch, but #slavehisher nipples are especially sensitive.");
		if (MilkInfluence > 0 || PregnancyGestation > 0) AddText(" You are a little surprised to see moisture leaking from her nipples, milk maybe?");
	} else if (sensitivity < 130) {
		AddText("#slave responds with moans and sighs to #person's touch. #slave's nipples and ");
		if (HasCock) AddText("cock");
		else AddText("clit");
		AddText(" become hard quickly and #slave seems to delight in every touch. Every time he touches her " + CockPussyText() + " #slave strains, hoping to be made to orgasm.");
	} else {
		AddText("#slave is very responsive and arouses quickly and easily. #person cannot touch #slavehisher " + CockPussyText() + " much as #slave seems to rapidly approach orgasm.");
	}
}

function DoFemaleSlaveTouch(sensitivity:Number)
{
	var sgirl:Slave;
	ShowSlave(sdata, 0, 1);
	if (PersonIndex != -2) AddText("You order #person to do this act with #slave\r\r");
	AddText("You have #person move behind #slave, while you speak reassuringly to #slavehimher.");
	if (TotalLesbian == 0 && SlaveFemale) {
		AddText(" #slave starts a little at #person's touch and the feel of #personhisher breasts on her back.");
	}

	if (HasCock) {
		AddText(" #person slowly starts to run #personhisher hands over #slave's body, caressing #slavehisher ");
		if (SlaveFemale) AddText("breasts and touching her ");
		AddText("ass and carefully touching #slavehisher cock. You tell #person to take care not to grope #slavehimher");
		if (SlaveFemale) AddText("breasts or ass");
		AddText(", but you see #slavehisher cock quickly becomes hard and erect. You warn #person that #personheshe must be careful of #slavehisher cock, you are trying to make #slavehimher more aware of #slavehisher body and to arouse, but not to masturbate #slavehimher and make #slavehimher cum.\r\r");
		if (sensitivity < 50) {
			AddText("#slave does not respond much to #person's touches, ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("#slave is uncomfortable with another woman's touch.");
			else AddText("#slave is a little confused, expecting #person to just masturbate #slavehimher.");
			AddText(" As you feel #slave has had enough and tell #person to stop, but #person seems not to hear and continues stroking and #slave cries out and you see #slavehisher cock spew out a gout of cum. It was only a mild orgasm, and once #slave recovers you mildly scold #slavehisher lack of self control. You also scold #person for #personhisher lack of control.");
		} else if (sensitivity < 90) {
			AddText("#slave sighs, moving ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortably ");
			AddText("beneath #person's touch, but #slavehisher nipples are especially sensitive, large and erect. ");
			if (MilkInfluence > 0 || PregnancyGestation > 0) AddText(" You are a little surprised to see moisture leaking from her nipples, milk maybe?");
			AddText(" As you tell #person to touch #slaves nipples you hear #slave suppress a moan, then you see spurt after spurt of cum erupting from #slavehisher cock. #slave calms down after #slavehisher orgasm, and looks a little embarrassed. You scold #slavehimher for #slavehisher lack of self control.");
		} else if (sensitivity < 120) {
			AddText("#slave responds with moans and sighs to #person's touch.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" #slave's nipples and cock become hard quickly and #slave seems to delight in every touch. You tell #person to stroke #slavehisher cock and try to keep #slavehimher from cumming. After a short time you see #slave is trying to hide #slavehisher arousal, but #person does not notice. You are about to tell #personhimher when you see #slave's back arch and cum erupts from #slavehisher cock, spurt after spurt flying across the room. When #slave recovers to scold them both for losing control.");
		} else {
			AddText("#slave is very responsive and arouses quickly and easily.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" You see #person is finding it difficult to prevent #slave from cumming. Instead you tell #person to ");
			switch(Math.floor(Math.random()*2)) {
				case 0: AddText("move down and use #personhisher tits to masturbate #slave. " + NameCase(PersonHeShe) + " does so expertly until #slave is groaning and about to cum. You tell #person to capture all #slavehisher cum in #personhisher mouth. #slave pants and gasps and cums into #person's mouth. When #slave gasps and falls back #person looks up at you, #personhisher mouth full of #slave's cum. You tell #personhimher 'swallow'..."); break;
				case 1: AddText("to quickly make #slave cum. Quickly #personheshe makes #slave's cock erupt glob after glob of cum. You then tell #person to make #slavehimher cum again, deciding that after a half a dozen cums #slavehisher cock will be very sensitive..."); BadGirl = 1; break;
			}
		}
	} else {
		AddText(" #person slowly starts to run #personhisher hands over #slave's body, caressing her breasts and touching her ass and making sure not to stimulate her pussy too much. You tell #person to take care not to grope her breasts or ass. You warn #person not to stimulate her pussy too much. You are trying to make her more aware of her body and to arouse, but not to masturbate her and make her orgasm.\r\r");

		if (sensitivity < 40) {
			AddText("#slave does not respond much to #person, ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortable with another woman's touch.");
			else AddText("a little confused, expecting #person to make her orgasm.");
		} else if (sensitivity < 80) {
			AddText("#slave sighs, moving ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortably ");
			AddText("beneath #person touch, but her nipples are especially sensitive.");
			if (MilkInfluence > 0 || PregnancyGestation > 0) AddText(" You are a little surprised to see moisture leaking from her nipples, milk maybe?");
		} else if (sensitivity < 120) {
			AddText("#slave responds with moans and sighs to #person's touch.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" Her nipples and clit become hard quickly and #slave seems to delight in every touch. Every time #person touches her pussy #slave strains, hoping #slave will touch her more and make her orgasm.");
		} else {
			AddText("#slave is very responsive and arouses quickly and easily.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" #person cannot touch her pussy much as #slave seems to rapidly approach orgasm.");
			if (TotalLesbian > 0) 
			switch(Math.floor(Math.random()*2)) {
				case 0: AddText("#slave whispers to #person, suggesting instead #slave could put a finger in her ass..."); break;
				case 1: AddText("As #person touches her, #slave gasps and you see her orgasm. You realise #slave had been trying to conceal her responses. You scold her for her deception."); BadGirl = 1; break;
			}
		}
	}
}

function DoFemaleSMTouch(sensitivity:Number)
{
	if (HasCock) {
		AddText("You move behind #slave, speaking reassuringly to #slavehimher, and kiss #slavehimher on the neck.");
		if (TotalLesbian == 0 && SlaveFemale) {
			AddText(" #slave starts a little at your touch and the feel of your breasts on her back.");
		}
		AddText(" You slowly start to run your hands over #slavehisher body, caressing #slavehisher ");
		if (SlaveFemale) AddText("breasts, touching her ");
		AddText("ass and carefully touching #slavehisher cock.\r\rYou take care not to grope #slavehisher ");
		if (SlaveFemale) AddText("breasts or ");
		AddText("ass, but #slavehisher cock quickly becomes hard and erect. You must be careful of #slavehisher cock, you are trying to make #slavehimher more aware of #slavehisher body and to arouse, but not to masturbate #slavehimher and make #slavehimher cum.\r\r");
		if (sensitivity < 40) {
			AddText("#slave does not respond much to most of your touches, ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("#slave is uncomfortable with another woman's touch.");
			else AddText("#slave is a little confused, expecting you to just masturbate #slavehimher.");
			AddText(" As you feel #slave has had enough, #slave cries out and you feel and see #slavehisher cock spew out a gout of cum. It was only a mild orgasm, and once #slave recovers you mildly scold #slavehisher lack of self control.");
		} else if (sensitivity < 80) {
			AddText("#slave sighs, moving ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortably ");
			AddText("beneath your touch, but #slavehisher nipples are especially sensitive. ");
			if (MilkInfluence > 0 || PregnancyGestation > 0) AddText(" You are a little surprised to feel moisture leaking from her nipples, milk maybe?");
			AddText(" As you touch #slavehisher nipples you hear #slavehimher suppress a moan, then you see spurt after spurt of cum erupting from #slavehisher cock. #slave calms down after #slavehisher orgasm, and looks a little embarrassed. You scold #slavehimher for #slavehisher lack of self control.");
		} else if (sensitivity < 120) {
			AddText("#slave responds with moans and sighs to your touch.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" #slave's nipples and cock become hard quickly and #slave seems to delight in every touch. You stroke #slavehisher cock trying to keep #slavehimher from cumming but also trying to keep #slavehimher near to cumming.\r\r#slave seems frustrated and seems try to deceive you and hide #slavehisher arousal. You have a sort of competition trying to keep #slavehimher from cumming while #slave does #slavehisher best to cum. After a while #slave is sweating and breathing heavily, and you are tired. #slave suddenly reaches up and pinches #slavehisher nipples and you feel and great pulse in #slavehisher cock. You look and see huge spurts and gobs of cum pumping from #slavehisher cock, coating #slavehisher face, stomache, some even getting on you! #slave cries and shouts and cums for a long time, then collapses, tired and whispers 'thank you'");
		} else {
			AddText("#slave is very responsive and arouses quickly and easily.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" You find #slavehisher cock is very sensitive and find it difficult to prevent #slavehimher from cumming. After a time of attempting to prevent #slavehimher you give up and move around. You quickly stroke #slavehisher cock until #slave gasps ");
			switch(Math.floor(Math.random()*2)) {
				case 0: AddText("and you bend down and place your mouth over the end of #slavehisher cock and #slave cums spurt after spurt into your mouth, until #slave lies down panting and your mouth is full of #slavehisher cum. You move and lie on #slavehimher, and kiss #slavehimher on the mouth, letting all of #slave's cum pour into #slavehisher own mouth. #slave looks surprised, and a little startled as you order 'swallow'..."); break;
				case 1: AddText("and you direct #slavehisher spraying cum over your breasts. #slave lies down panting, but you order #slavehimher up, to lick the cum off your breasts..."); BadGirl = 1; break;
			}
		}
	} else {
		AddText("You move behind #slave, speaking reassuringly to #slavehimher, and kiss her on the neck.");
		if (TotalLesbian == 0 && SlaveFemale) {
			AddText(" #slave starts a little at your touch and the feel of your breasts on her back.");
		}
		AddText(" You slowly start to run your hands over #slavehisher body, caressing her breasts, touching her pussy and rubbing her ass.\r\rYou take care not to grope her breasts or ass, and you make sure not to stimulate her pussy too much. You are trying to make her more aware of her body and to arouse, but not to masturbate her and make her orgasm.\r\r");
		if (sensitivity < 40) {
			AddText("#slave does not respond much to you, ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortable with another woman's touch.");
			else AddText("a little confused, expecting you to make her orgasm.");
		} else if (sensitivity < 80) {
			AddText("#slave sighs, moving ");
			if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortably ");
			AddText("beneath your touch, but her nipples are especially sensitive.");
			if (MilkInfluence > 0 || PregnancyGestation > 0) AddText(" You are a little surprised to feel moisture leaking from her nipples, milk maybe?");
		} else if (sensitivity < 120) {
			AddText("#slave responds with moans and sighs to your touch.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" Her nipples and clit become hard quickly and #slave seems to delight in every touch. Every time you touch her pussy #slave strains, hoping you will touch her more and make her orgasm.");
		} else {
			AddText("#slave is very responsive and arouses quickly and easily.");
			if (TotalLesbian == 0 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
			AddText(" You cannot touch her pussy much as #slave seems to rapidly approach orgasm.");
			if (TotalLesbian > 0) 
			switch(Math.floor(Math.random()*2)) {
				case 0: AddText("#slave whispers to you, suggesting instead you could put a finger in her ass..."); break;
				case 1: AddText("As you touch her, #slave gasps and you feel her orgasm. You realise #slave had been trying to conceal her responses. You scold her for her deception."); BadGirl = 1; break;
			}
		}
	}
}

function DoMaleSMTouch(sensitivity:Number)
{
	AddText("You move next to #slave and speak reassuringly to #slavehimher, and slowly start to run your hands over #slavehisher body, ");
	if (SlaveFemale) AddText("caressing #slavehisher breasts, touching her pussy ");
	if (HasCock) {
		AddText("and rubbing #slavehisher cock.\r\rYou take care not to grope #slavehisher ");
		if (SlaveFemale) AddText("breasts or ");
		AddText("ass, and you make sure not to stroke #slavehisher cock too much.");
	} else AddText("and rubbing her ass.\r\rYou take care not to grope her breasts or ass, and you make sure not to stimulate her pussy too much.");
	AddText("You are trying to make #slavehimher more aware of #slavehisher body and to arouse, but not to masturbate #slavehimher and make #slavehimher orgasm.\r\r");
	if (sensitivity < 40) AddText("#slave does not respond much to your touch, a little confused, expecting you to make #slavehimher orgasm.");
	else if (sensitivity < 80) {
		AddText("#slave sighs, moving beneath your touch, but #slavehisher nipples are especially sensitive.");
		if (MilkInfluence > 0 || PregnancyGestation > 0) AddText(" You are a little surprised to feel moisture leaking from her nipples, milk maybe?");
	} else if (sensitivity < 120) {
		AddText("#slave responds with moans and sighs to your touch. #slave's nipples ");
		if (HasCock) AddText("and cock become hard quickly and #slave seems to delight in every touch. Every time you touch #slavehisher cock #slave strains, hoping you will stroke #slavehimher more and make #slavehimher cum.");
		else AddText("and clit become hard quickly and #slave seems to delight in every touch. Every time you touch her pussy #slave strains, hoping you will touch her more and make her orgasm.");
	} else {
		AddText("#slave is very responsive and arouses quickly and easily. You cannot touch #slavehisher ");
		if (HasCock) AddText("cock much as #slave seems rapidly approach climax.");
		else AddText("pussy much as #slave seems rapidly approach orgasm.");
		switch(Math.floor(Math.random()*2)) {
			case 0: AddText("#slave whispers to you, suggesting instead you could put a finger in #slavehisher ass..."); break;
			case 1: 
				if (HasCock) AddText("As you touch #slavehimher, #slave gasps and cums, spurting over your hand. You realise #slave had been trying to conceal #slavehisher responses. You scold #slavehimher for #slavehisher deception.");
				else AddText("As you touch her, #slave gasps and you feel her orgasm. You realise #slave had been trying to conceal her responses. You scold her for her deception.");
				BadGirl = 1;
				break;
		}
	}
}

function DoDominatrixTouch(sensitivity:Number)
{
	AddText("You move behind #slave, chastising #slavehimher, and bite #slavehimher on the neck.");
	if (TotalLesbian == 0 && SMData.Gender != 1) {
		AddText(" #slave starts at your bite and the feel of your breasts on her back.");
	}
	if (HasCock) {
		AddText(" You start to pinch #slavehisher nipples and ");
		if (SlaveFemale) AddText("then her pussy lips and ");
		AddText("forcefully grab #slavehisher cock. You spank and slap #slavehisher ");
		if (SlaveFemale) AddText("breasts and #slavehisher ");
		AddText("cock, creating red welts. Tears are slowly falling from #slavehisher eyes, from the pain and humiliation.\r\r");
	} else AddText(" You start to pinch her nipples and then her pussy lips and clit. You spank and slap her breasts and her pussy, creating red welts. Tears are slowly falling from her eyes, from the pain and humiliation.\r\r");
	if (sensitivity < 40) {
		AddText("#slave only really responds to the pain, ");
		if (TotalLesbian == 0 && SMData.Gender != 1 && SlaveFemale) AddText("uncomfortable with another woman's touch.");
		else AddText("a little confused, expecting you to make #slavehimher orgasm.");
	} else if (sensitivity < 80) {
		AddText("#slave occasionally moans, moving ");
		if (TotalLesbian == 0 && SlaveFemale) AddText("uncomfortably ");
		AddText("beneath your touch, #slavehimher nipples hard.");
	} else if (sensitivity < 120) {
		if (HasCock) AddText("#slave responds with moans and sighs to your slaps, #slavehisher cock becoming erect and #slavehimher nipples hard.");
		else AddText("#slave responds with moans and sighs to your slaps, slowly becoming wet, nipples erect.");
		if (TotalLesbian == 0 && SMData.Gender != 1 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's punishment.");
	} else {
		AddText("#slave is very responsive and arouses quickly and easily, despite the pain.");
		if (TotalLesbian == 0 && SMData.Gender != 1 && SlaveFemale) AddText(" #slave seems very unsure, but aroused by another woman's touch.");
		if (SlaveFemale) AddText(" You cannot spank her pussy much as #slave seems rapidly approach orgasm.");
		switch(Math.floor(Math.random()*2)) {
			case 0: AddText(" #slave whispers to you, suggesting you could paddle #slavehisher ass..."); break;
			case 1: 
				if (HasCock) AddText("As you spank #slavehimher, #slaveheshe gasps cums spurting over your hands. You realise #slaveheshe had been trying to conceal #slavehisher responses. You scold #slavehimher for #slavehisher deception.");
				else AddText("As you spank #slavehisher pussy, #slave gasps and you see her orgasm. You realise #slaveheshe had been trying to conceal #slavehisher responses. You scold #slavehimher for #slavehisher deception.");
				BadGirl = 1;
				break;
		}
	}
	if (SMData.IsDominatrix() && SMData.Gender != 2) AddText("\r\rYou leave #slavehimher lying in #slavehisher pain and pleasure, and stand over #slavehimher. Your cock very erect and you quickly masturbate and cum over #slavehisher prone body.");
}


// Naked

function DoActNaked() {
	if (TestObedience(DifficultyNaked, LastActionDone)) {
		HideBackgrounds();
		
		DoneNaked = 1;
		NakedChoice = 0;
		slaveData.NakedChoice = 0;

		SlaveGirl.ShowSexActNakedStart();
		SlaveGirl.ShowActNakedStart();
		XMLData.DoXMLAct("NakedStart");
		
		if (DressWorn != -1) {
			DressToWear = DressWorn;
			slaveData.DressToWear = DressWorn;
		}
		RemoveDress();
		
		SetActButtonState(13, true);
		HideStatChangeIcons();
		LevelUpSexAct(LastActionDone);
		DressWorn = -1;
		slaveData.DressWorn = DressWorn;
		Naked = true;
		
		SlaveGirl.ShowSexActNaked();
		SlaveGirl.ShowActNaked();
		ShowDress();
		
		TotalNaked++;
		if (TotalNaked == 1) DifficultyNaked = DifficultyNaked-5;
		
		var ndlevel:Number = 3;
		if (SMData.sSlutTrainer == 2 || IsSlave("Naru")) ndlevel = 1;
		else if (SMData.sSlutTrainer >= 1) ndlevel = 2;
		var nd:Boolean = BitFlagSM.CheckBitFlag(19) && LevelNaked >= ndlevel;		
		
		if (AppendActText) XMLData.DoXMLAct("Naked");
		
		if (SexPoints(2, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0, 3, 4, 5, 0, 0, 0, 0, 0)) {
			if (AppendActText) {
				AddText(SlaveName + " will be naked for the rest of the day and night, until tomorrow morning.\r\r");
				switch(LevelNaked) {
					case 0:
						AddText("After telling #slave to strip, you collect #slavehisher clothes and lock them away. " + SlaveHeSheUC + " looks at you strangely. You instruct #slavehimher that #slavehisher clothes will not be returned to #slavehimher until #slaveheshe has pleased you sufficiently. Asking you what it is you desire, you tell #slavehisher that it isn’t anything specific, just that #slaveheshe has to make you happy.\r\r#slave proceeds to attempt to work out what you want from #slavehimher, but you keep a neutral expression no matter what #slaveheshe does. Frustrated, #slaveheshe tells you to ask something of #slavehimher. You just tell #slavehisher that since #slaveheshe didn’t come up with anything suitable, #slaveheshe will just have to go without clothes tomorrow. Looking mortified, #slaveheshe begs you to give #slavehisher just something, but you are adamant, and fearfully #slaveheshe gives up, looking like #slaveheshe isn’t going to get any sleep tonight.");
						break;
					case 1:
						AddText("You pick an event that you were unhappy with and inform #slave that since #slaveheshe displeased you, #slaveheshe will have to hand over#slavehisher clothes. " + SlaveHeSheUC + " does so, sullenly, preparing to go through the night without anything to cover #slavehimher. Once the clothes are locked away, you tell #slavehisher that #slaveheshe might get them back tomorrow night if #slaveheshe’s been good. #slavehisher face pales considerably. “I have to go naked again?!” You reaffirm this, much to #slavehisher embarrassment.");
						break;
					case 2:
						AddText("After #slave has stripped, you tell #slavehisher that #slavehisher body is beautiful and that #slaveheshe should cease being so ashamed of it. " + SlaveHeSheUC + " somewhat agrees, which is enough for you to say that in order to combat #slavehisher shame, #slaveheshe will go naked about tomorrow. “Wha-at!?”#slaveheshe asks, and you repeat that since #slaveheshe shouldn’t be ashamed of #slavehimherself, #slaveheshe will be naked all day tomorrow. #slave really thinks this is more than is necessary, but #slavehisher clothes are locked away, out of #slavehisher reach.");
						break;
					case 3:
						AddText("Fearing the worst, #slave hands over #slavehisher clothes a little nervously. As you lock them away, #slaveheshe sighs in defeat. “I’m going to be naked all day again?” #slaveheshe asks. You tell #slavehimher, just so. Proceeding to compliment #slavehisher body, you ask #slavehisher to emphasize some things #slaveheshe likes about herself. Reluctantly, #slaveheshe mentions #slavehisher ");
						if (SlaveFemale) AddText("breasts and #slavehisher thigh at least. You instruct #slavehisher to not try to cover #slavehisher breasts so much tomorrow, to which #slaveheshe agrees, shyly.");
						else AddText("chest and #slavehisher cock at least. You instruct #slavehisher to not try to cover " + SlaveHinHer + "self so much tomorrow, to which #slaveheshe agrees, shyly.");
						break;
					case 4:
						AddText("Watching you lock #slavehisher clothes away, #slave sighs. “Naked again today?” You nod, again asking what other parts of #slavehisher body #slaveheshe is proud of. Mentioning #slavehisher complexion and the swell of #slavehisher ass, you tell #slavehisher to be more revealing tomorrow, and stop being so conscious of #slavehisher own body. Beneath our clothes, all of us are naked all the time. This piece of “logic” puzzles #slavehimher, giving #slavehimher something to think about.");
						break;
					case 5:
						if (LevelUp) {
							AddText(SlaveName + " hands you #slavehisher clothes, saying that #slaveheshe thinks #slaveheshe understands now. " + NameCase(SlaveHisHer) + " body is nothing to be ashamed of, it’s all the people who have to hide themselves who should be ashamed. You’re a little confused as to how #slaveheshe came to this conclusion, but seeing as #slaveheshe will now go about in the nude freely, you can hardly complain.\r\rRunning #slavehisher hands over #slavehisher body, #slaveheshe tells you how anyone should be proud of #slavehimherself, seeing how they’re the most beautiful creatures in the world. When you ask #slavehisher if there are any parts that are shameful, #slaveheshe tells you none, and spreads #slavehisher legs for you to see, then bends over and spreads #slavehisher ass open, so you can even see #slavehisher asshole. Giggling, #slaveheshe bounces a few times,");
							if (SlaveFemale) AddText(" breasts going up and down");
							if (HasCock) AddText(" and her cock swinging up and down");
							AddText("." + SlaveHeSheUC + " seems happy.");
						} else {
							AddText("Gladly accepting to go naked, #slave is proud of every little bit of #slavehisher own body");
							if (HasCock) AddText(", especially her cock!");
							else AddText(".");
						}
						break;
				}
				if (LevelUp && nd && !IsSlave("Naru")) {
					AddText("\r\rYou can now see #slave is getting used to being naked. You decide to use Naru's 'Naked Dress' idea. There is now a 'Naked' dress available for #slave to wear. The 'Naked' training option will no longer be available.");
				}
			}
		}
		Sounds.PlaySound("Clothes");

	} else {
		if (DoneNaked == 0) Refused(13, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -8, -2, 0, 0, -1, -8, 0);
		else Refused(13, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		DoneNaked = 1;
	}
}


// Anal Plug

function DoActPlug() {
	if (TestObedience(DifficultyPlug, LastActionDone)) {
		LevelUpSexAct(LastActionDone);
		PlugInserted = 1;
		Icons.SetPlugIcon(_root);
		DonePlug = 1;
		SetActButtonState(10, true, (PlugOK == 1) || (PonyTailOK == 1));
		SlaveGirl.ShowSexActPlug();
		SlaveGirl.ShowActPlug();
		if (!UseGeneric && UseImages) ShowActImage();
		if (UseGeneric) Generic.ShowSexActPlug();
		TotalAnal++;
		TotalPlug++;
 
		if (SexPoints(0, 0, -1, 0, -2, 1, 0, 0, 0, 0, 0, 0, 3, 3, 4, 0, 8, 0, 0, 0)) {
			
			if (AppendActText) XMLData.DoXMLAct("Plug");
			
			if (AppendActText) {
				if (SlaveGender > 3) {
					AddText(SlaveName + " will wear a anal plugs, inserted into their asses for the rest of the day and night, until tomorrow morning.\r\r");
					if (TotalAnal<5) {
						AddText("You find it is still hard to put the plugs in.");
						if (HasCock) AddText(" Their cocks stiffen as you put the plugs in.");
					} else if (TotalAnal<10) {
						AddText("You find it becomes easier to put the plugs in.");
						if (HasCock) AddText(" Their cocks become erect as you put the plugs in.");
					} else if (TotalAnal<20) {
						AddText("You can put the plugs in very easily.");
						if (HasCock) AddText(" Their cocks are intensely erect after you insert the plugs.");
					} else {
						AddText("Judging by their position, they are waiting for their plugs with envy.");
						if (HasCock) AddText(" Their cocks erect as they wait.");
					}
				} else {
					AddText(SlaveName + " will wear an anal plug, inserted in #slavehisher ass for the rest of the day and night, until tomorrow morning.\r\r");
					if (TotalAnal<5) {
						AddText("It is still hard to put the plug in.");
						if (HasCock) AddText(" #slavehisher cock stiffens as you put the plug in.");
					} else if (TotalAnal<10) {
						AddText("It becomes easier to put the plug in.");
						if (HasCock) AddText(" #slavehisher cock becomes erect as you put the plug in.");
					} else if (TotalAnal<20) {
						AddText("You can put the plug in very easily.");
						if (HasCock) AddText(" #slavehisher cock intensely erect after you insert the plug.");
					} else {
						AddText("Judging by #slavehisher position, " + SlaveHeSheIs + " waiting for that plug with envy.");
						if (HasCock) AddText(" #slavehisher cock erect as #slaveheshe waits.");
					}
				}
			}
		}
		if (StandardDGText) {
			if (DickgirlChangable && DickgirlChanged == false && DickgirlXF == 0 && Math.floor(Math.random()*3) < 2) {
				if (SlaveGender > 3) AddText("\r\rAs you insert the plugs you see #slave's clits grow large and very erect almost like they are small cocks.");
				else AddText("\r\rAs you insert the plug you see #slave's clit grow large and very erect almost like a small cock.");
			} else if (DickgirlChanged && (!SlaveGirl.IsDickgirl())) {
				if (SlaveGender > 3) AddText("As you insert the plugs you see #slave have both grown large cocks.\r\r");
				else AddText("As you insert the plug you see #slave has grown a large cock.\r\r");
			}
		}
		
		if (TotalPlug == 1) DifficultyPlug = DifficultyPlug-5;
	} else {
		if (DonePlug == 0) Refused(10, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, -2, 0, 0, -1, -7, 0);
		else Refused(10, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		DonePlug = 1;
	}
}

