// Custom Actions
//===============
import Scripts.Classes.*;

// Jobs

function AddCustomJob(slabel:String, hint:String, node) : Number
{
	//SMTRACE("AddCustomJob: " + slabel);
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}
	if (nname == "") nname = "CustomJob" + slabel.split(" ").join("");
	var bHide:Boolean = false;
	var actno:Number;
	if (slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = slaveData.ActInfoBase.GetActByName(nname).Act;
	else {
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(2);
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 2);
	if (bHide) act.HideAct();
	//SMTRACE("...Shown " + nname + ": " + act.bShown);
	act.Type = 2;
	if (nname != "" && act.strNodeName == "") act.strNodeName = nname;
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	if (xNode != null) act.xNode = xNode;
	return actno;
}

// Obsolete
var ShowCustomJob1:Number;
var ShowCustomJob2:Number;
var ShowCustomJob3:Number;
var SlaveJob1Description:String;
var SlaveJob2Description:String;
var SlaveJob3Description:String;

function SetCustomJobDetails1(slabel:String, hint:String)
{
	var bHide:Boolean = false;
	if (hint != undefined) SlaveJob1Description = hint;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveJob1");
	if (actno == 0) {
		actno = 1018;
		bHide = true;
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "1", 0, 2);
	act.Type = 2;
	if (bHide) act.HideAct();
	if (act.strNodeName == "") {
		act.strNodeName = "SlaveJob1";
		act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	}
}

function ShowCustomJob(num:Number)
{
	if (num == undefined) num = 1;
	slaveData.ActInfoBase.GetActRO("SlaveJob" + num).ShowAct(true);
	
	if (num == 1) ShowCustomJob1 = 1;
	else if (num == 2) ShowCustomJob2 = 1;
	else ShowCustomJob3 = 1;
}

function HideCustomJob(num:Number)
{
	if (num == undefined) num = 1;
	slaveData.ActInfoBase.GetActRO("SlaveJob" + num).ShowAct(true);
	
	if (num == 1) ShowCustomJob1 = 0;
	else if (num == 2) ShowCustomJob2 = 0;
	else ShowCustomJob3 = 0;
}

function SetCustomJobDetails2(slabel:String, hint:String)
{
	var bHide:Boolean = false;
	if (hint != undefined) SlaveJob2Description = hint;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveJob2");
	if (actno == 0) {
		actno = 1020;
		bHide = true;
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "2", 0, 2);
	act.Type = 2;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveJob2";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
}

function SetCustomJobDetails3(slabel:String, hint:String)
{
	var bHide:Boolean = false;
	if (hint != undefined) SlaveJob3Description = hint;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveJob3");
	if (actno == 0) {
		actno = 1021;
		bHide = true;
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "3", 0, 2);
	act.Type = 2;
	act.HideAct();
	act.strNodeName = "SlaveJob3";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
}

function SetCustomJobDetails(slabel:String, desc:String)
{
	SetCustomJobDetails1(slabel, desc);
}

// Schools

function AddCustomSchool(slabel:String, hint:String, node) : Number
{
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}
	if (nname == "") nname = "CustomSchool" + slabel.split(" ").join("");

	var bHide:Boolean = false;
	var actno:Number;
	if (slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = slaveData.ActInfoBase.GetActByName(nname).Act;
	else {
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(3);
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 50, 2);
	if (bHide) act.HideAct();
	act.Type = 3;
	if (nname != "") {
		act.strNodeName = nname;
		act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	}
	if (xNode != null) act.xNode = xNode;
	return actno;
}

// OBSOLETE
var SlaveSchool1Description:String;
var SlaveSchool2Description:String;
var SlaveSchool3Description:String;
var ShowCustomSchool1:Number;
var ShowCustomSchool2:Number;
var ShowCustomSchool3:Number;

function SetCustomSchoolDetails1(slabel:String, hint:String, cost:Number)
{
	var bHide:Boolean = false;
	if (hint != undefined) SlaveSchool1Description = hint;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveSchool1");
	if (actno == 0) {
		actno = 1024;
		bHide = true;
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(1024, false, true, slabel, hint, "", 0, 2);
	act.Type = 3;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveSchool1";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
}

function ShowCustomSchool(num:Number)
{
	slaveData.ActInfoBase.GetActRO("SlaveSchool" + num).ShowAct(true);

	if (num == 1 || num == undefined) ShowCustomSchool1 = 1;
	else if (num == 2) ShowCustomSchool2 = 1;
	else ShowCustomSchool3 = 1;
}

function HideCustomSchool(num:Number)
{
	slaveData.ActInfoBase.GetActRO("SlaveSchool" + num).ShowAct(false);

	if (num == 1 || num == undefined) ShowCustomSchool1 = 0;
	else if (num == 2) ShowCustomSchool2 = 0;
	else ShowCustomSchool3 = 0;
}

function SetCustomSchoolDetails2(slabel:String, hint:String, cost:Number)
{
	var bHide:Boolean = false;
	if (hint != undefined) SlaveSchool2Description = hint;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveSchool2");
	if (actno == 0) {
		actno = 1025;
		bHide = true;
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 2);
	act.Type = 3;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveSchool2";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");

}

function SetCustomSchoolDetails3(slabel:String, hint:String, cost:Number)
{
	var bHide:Boolean = false;
	if (hint != undefined) SlaveSchool3Description = hint;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveSchool2");
	if (actno == 0) {
		actno = 1026;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 2);
	act.Type = 3;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveSchool3";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");

}

// Chores
var SlaveChore1Description:String;
var SlaveChore2Description:String;
var SlaveChore3Description:String;
var ShowCustomChore1:Number;
var ShowCustomChore2:Number;
var ShowCustomChore3:Number;

function AddCustomChore(slabel:String, hint:String, node) : Number
{
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}
	if (nname == "") nname = "CustomChore" + slabel.split(" ").join("");
	
	var bHide:Boolean = false;
	var actno:Number;
	if (slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = slaveData.ActInfoBase.GetActByName(nname).Act;
	else {
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(1);
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 2);
	if (bHide) act.HideAct();
	act.Type = 1;
	if (nname != "") {
		act.strNodeName = nname;
		act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	}
	if (xNode != null) act.xNode = xNode;
	return actno;
}

// OBSOLETE
function SetCustomChoreDetails1(slabel:String, desc:String)
{
	var bHide:Boolean = false;
	if (desc != undefined) SlaveChore1Description = desc;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveChore1");
	if (actno == 0) {
		actno = 1027;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, desc, "", 0, 2);
	act.Type = 1;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveChore1";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
}

function ShowCustomChore(num:Number)
{
	slaveData.ActInfoBase.GetActRO("SlaveChore" + num).ShowAct(true);
	
	if (num == 1 || num == undefined) ShowCustomChore1 = 1;
	else if (num == 2) ShowCustomChore2 = 1;
	else ShowCustomChore3 = 1;
}

function HideCustomChore(num:Number)
{
	slaveData.ActInfoBase.GetActRO("SlaveChore" + num).ShowAct(false);

	if (num == 1 || num == undefined) ShowCustomChore1 = 0;
	else if (num == 2) ShowCustomChore2 = 0;
	else ShowCustomChore3 = 0;
}

function SetCustomChoreDetails2(slabel:String, desc:String)
{
	if (desc != undefined) SlaveChore2Description = desc;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveChore2");
	if (actno == 0) {
		actno = 1028;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, desc, "", 0, 2);
	act.Type = 1;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveChore2";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");

}

function SetCustomChoreDetails3(slabel:String, desc:String)
{
	var bHide:Boolean = false;
	if (desc != undefined) SlaveChore3Description = desc;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveChore3");
	if (actno == 0) {
		actno = 1029;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, desc, "", 0, 2);
	act.Type = 1;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveChore3";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");

}

// Custom Sex Acts

function AddCustomSexNormal(slabel:String, hint:String, node, min:Number, max:Number, ptype:String) : Number
{
	//SMTRACE("AddCustomSexNormal: " + slabel + " " + nname);
	
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}

	var act:ActInfo;
	var bHide:Boolean = false;
	var actno:Number;
	if (nname == "") nname = "CustomSex" + slabel.split(" ").join("");
	
	if (slaveData.ActInfoBase.IsActDefinedByName(nname)) {
		//SMTRACE("...existis");
		act = slaveData.ActInfoBase.GetActByName(nname);
		actno = act.Act;
		bHide = !act.bShown;
	} else {
		//SMTRACE("...new");
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(5);
	}
	act = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 1);
	if (bHide) act.HideAct();
	else act.ShowAct();
	//SMTRACE("...shown: " + act.bShown);
	act.Type = 5;
	if (!isNaN(min)) {
		act.MinParticipants = min;
		act.MaxParticipants = min;
	} else act.MinParticipants = 0;
	if (!isNaN(max)) act.MaxParticipants = max;
	if (nname != "") act.strNodeName = nname;
	if (ptype != undefined) act.AllowedPartnerGender = ptype.toLowerCase();
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	if (xNode != null) act.xNode = xNode;
	return actno;
}
	
function AddCustomSexExtreme(slabel:String, hint:String, nname:String, min:Number, max:Number, ptype:String) : Number
{
	//SMTRACE("AddCustomSexExtreme: " + slabel);
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}
	
	var bHide:Boolean = false;
	var actno:Number;
	if (nname == "") nname = "CustomSex" + slabel.split(" ").join("");

	if (slaveData.ActInfoBase.IsActDefinedByName(nname)) {
		actno = slaveData.ActInfoBase.GetActByName(nname).Act;
		//SMTRACE("Act: " + actno);
	} else {
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(6);
		//SMTRACE("Act: " + actno);
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 1);
	if (bHide) act.HideAct();
	act.Type = 6;
	if (!isNaN(min))  {
		act.MinParticipants = min;
		act.MaxParticipants = min;
	} else act.MinParticipants = 0;
	if (!isNaN(max)) act.MaxParticipants = max;	
	if (nname != "") act.strNodeName = nname;
	if (ptype != undefined) act.AllowedPartnerGender = ptype.toLowerCase();
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	if (xNode != null) act.xNode = xNode;
	return actno;
}

// OBSOLETE
var ShowCustomSex1:Number;
var ShowCustomSex2:Number;
var ShowCustomSex3:Number;
var ShowCustomSex4:Number;
var SlaveSex1Description:String;
var SlaveSex2Description:String;
var SlaveSex3Description:String;
var SlaveSex4Description:String;

function SetCustomSexAct1(slabel:String, desc:String)
{
	var bHide:Boolean = false;
	if (desc != undefined) SlaveSex1Description = desc;
	
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveSex1");
	if (actno == 0) {
		actno = 26;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, desc, "", 0, 1);
	act.Type = 5;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveSex1";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");

}

function ShowCustomSexAct(num:Number)
{
	var act:ActInfo = slaveData.ActInfoBase.GetActRO("SlaveSex" + num);
	act.ShowAct(true);
	//trace("ShowCustomSexAct = " + num + "(" + act.Act + ") " + act.bShown);

	if (num == 4) ShowCustomSex4 = 1;
	else if (num == 3) ShowCustomSex3 = 1;
	else if (num == 2) ShowCustomSex2 = 1;
	else ShowCustomSex1 = 1;
	dspMain.SetSexSkills();
}

function HideCustomSexAct(num:Number)
{
	slaveData.ActInfoBase.GetActRO("SlaveSex" + num).ShowAct(false);

	if (num == 4) ShowCustomSex4 = 0;
	else if (num == 3) ShowCustomSex3 = 0;
	else if (num == 2) ShowCustomSex2 = 0;
	else ShowCustomSex1 = 0; 
}

function SetCustomSexAct2(slabel:String, desc:String)
{
	var bHide:Boolean = false;
	if (desc != undefined) SlaveSex2Description = desc;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveSex2");
	if (actno == 0) {
		actno = 27;
		bHide = true;
	}

	var act:ActInfo = slaveData.ActInfoBase.GetAct(actno);
	act.SetActDetails(false, true, slabel, desc, "", 0, 1);
	act.Type = 6;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveSex2";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");

}

function SetCustomSexAct(num:Number, slabel:String, desc:String)
{
	//trace("SetCustomSexAct: " + num + " " + slabel);
	var bHide:Boolean = false;
	var actno:Number = slaveData.ActInfoBase.GetActNo("SlaveSex" + num);
	if (actno == 0) {
		actno = 25 + num;
		bHide = true;
	}
	
	var act:ActInfo = slaveData.ActInfoBase.GetAct(actno);
	act.SetActDetails(false, true, slabel, desc, "", 0, 1);
	act.Type = 5;
	if (bHide) act.HideAct();
	act.strNodeName = "SlaveSex" + num;
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	
	if (num == 4) SlaveSex4Description = desc;
	else if (num == 3) SlaveSex3Description = desc;
	else if (num == 2) SlaveSex2Description = desc;
	else SlaveSex1Description = desc;
}


// Contests
// see ContestsModule class


// Talk To Slave

function AddCustomTalkToSlave(slabel:String, hint:String, node) : Number
{
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}
	
	var bHide:Boolean = false;
	var actno:Number;
	if (nname != undefined && slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = slaveData.ActInfoBase.GetActByName(nname).Act;
	else {
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(10);
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 0.5);
	if (bHide) act.HideAct();
	act.Type = 10;
	if (nname != "") act.strNodeName = nname;
	if (act.strNodeName == "") act.strNodeName = "SlaveTalk";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	if (xNode != null) act.xNode = xNode;
	return actno;
}

// Order Slave

function AddCustomOrderSlave(slabel:String, hint:String, node) : Number
{
	//trace("AddCustomOrderSlave: " + slabel);
	var xNode:XMLNode = null;
	var nname:String = "";
	if (typeof(node) == "string") nname = String(node);
	else if (node != undefined) {
		xNode = node;
		nname = xNode.nodeName;
	}
	
	var bHide:Boolean = false;
	var actno:Number;
	if (nname != undefined && slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = slaveData.ActInfoBase.GetActByName(nname).Act;
	else {
		bHide = true;
		actno = slaveData.ActInfoBase.GetFreeAct(12);
	}
	var act:ActInfo = slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "", 0, 0.5);
	if (bHide) act.HideAct();
	act.Type = 12;
	if (nname != "") act.strNodeName = nname;
	if (act.strNodeName == "") act.strNodeName = "SlaveOrder";
	act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	if (xNode != null) act.xNode = xNode;
	return actno;
}
