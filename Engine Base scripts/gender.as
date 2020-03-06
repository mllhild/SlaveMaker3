// Gender

// Slave
var SlaveHeShe:String;
var SlaveHeSheSingle:String;
var SlaveHeSheIs:String;
var SlaveHeSheHas:String;
var SlaveHimHer:String;
var SlaveHisHer:String;
var SlaveHimHer2:String;
var SlaveHisHer2:String;
var SlaveHimHer3:String;
var SlaveHisHer3:String;
var SlaveHimHer4:String;
var SlaveHisHer4:String;
var SlaveHisHerSingle:String;
var SlaveHimHerSingle:String;
var SlaveGirlGirls:String;
var SlaveBoyGirl:String;
var SlaveHeSheUC:String;
var SlaveFemale:Boolean;
var SlaveMeet:String;
var SlaveSee:String;
var SlaveIs:String;
var SlaveHas:String;
var SlaveMe:String;
var HasCock:Boolean;

function GetGender(str:String) : Number
{
	// note order for efficiency, more likely first
	if (!isNaN(str)) return Number(str);
	str = str.toLowerCase();
	if (str == "male") return 1;
	if (str == "female") return 2;
	if (str == "dickgirl" || str == "hermaphrodite" || str == "futanari") return 3;
	str = str.split(" ").join("");
	if (str == "maletwins") return 4;
	if (str == "femaletwins") return 5;
	if (str == "dickgirltwins" || str == "hermaphroditetwins" || str == "futanaritwins") return 6;
	if (str == "mixedtwins") return 7;
	if (str == "none" || str == "neutral") return 0;
	return 2;
}


function TestGender(str:String, gnd:Number) : Boolean
{
	if (str.toLowerCase() == "masculine") return (gnd != 2 && gnd != 5);
	if (str.toLowerCase() == "feminine") return (gnd != 1 && gnd != 4);
	if (str.toLowerCase() == "twins") return gnd > 3;
	return (GetGender(str) == gnd);
}

function UpdateSlaveGenderText(sd:Object)
{
	if (sd == undefined) sd = _root;
	var cgender:Number = sd.GenderIdentity;
	if (sd.IsDickgirl() && sd.SlaveGender != 6) cgender = 3;
	if (cgender > 3) {
		SlaveHimHer = Language.GetHtml("Them", gndNode);
		SlaveHimHer2 = Language.GetHtml("Them2", gndNode);
		if (SlaveHimHer2 == "") SlaveHimHer2 = SlaveHimHer;
		SlaveHimHer3 = Language.GetHtml("Them3", gndNode);
		if (SlaveHimHer3 == "") SlaveHimHer3 = SlaveHimHer;
		SlaveHimHer4 = Language.GetHtml("Them4", gndNode);
		if (SlaveHimHer4 == "") SlaveHimHer4 = SlaveHimHer;
		SlaveHeShe = Language.GetHtml("They", gndNode);
		SlaveHeSheIs = "they are";
		SlaveHeSheHas = "they have";
		SlaveHisHer = Language.GetHtml("Their", gndNode);
		SlaveHisHer2 = Language.GetHtml("Their2", gndNode);
		if (SlaveHisHer2 == "") SlaveHisHer2 = SlaveHisHer;
		SlaveHisHer3 = Language.GetHtml("Their3", gndNode);
		if (SlaveHisHer3 == "") SlaveHisHer3 = SlaveHisHer;
		SlaveHisHer4 = Language.GetHtml("Their4", gndNode);
		if (SlaveHisHer4 == "") SlaveHisHer4 = SlaveHisHer;
		SlaveHeShe = Language.GetHtml("They", gndNode);
		SlaveIs = Language.GetHtml("SlaveIsTwins", gndNode);
		SlaveHas = Language.GetHtml("SlaveHasTwins", gndNode);
		SlaveHeSheSingle = cgender == 4 ? Language.GetHtml("He", gndNode) : Language.GetHtml("She", gndNode);;
		SlaveHisHerSingle = cgender == 4 ? Language.GetHtml("His", gndNode) : Language.GetHtml("Her", gndNode);
		SlaveHimHerSingle = cgender == 4 ? Language.GetHtml("Him", gndNode) : Language.GetHtml("Her", gndNode);
		SlaveGirlGirls = cgender == 4 ? "these boys" : "these girls";
		SlaveBoyGirl = cgender == 4 ? "boy" : "girl";
		SlaveMe = "us";
	} else {
		if (cgender == 0) {
			SlaveHimHer = Language.GetHtml("It", gndNode);
			SlaveHimHer2 = Language.GetHtml("It", gndNode);
			if (SlaveHimHer2 == "") SlaveHimHer2 = SlaveHimHer;
			SlaveHimHer3 = Language.GetHtml("It", gndNode);
			if (SlaveHimHer3 == "") SlaveHimHer3 = SlaveHimHer;
			SlaveHimHer4 = Language.GetHtml("It", gndNode);
			if (SlaveHimHer4 == "") SlaveHimHer4 = SlaveHimHer;
			SlaveHisHer = Language.GetHtml("Its", gndNode);
			SlaveHisHer2 = SlaveHisHer;
			SlaveHisHer3 = SlaveHisHer;
			SlaveHisHer4 = SlaveHisHer;
			SlaveHeShe = Language.GetHtml("It", gndNode);
			SlaveBoyGirl = "girl";
		} else if (cgender != 1) {
			SlaveHimHer = Language.GetHtml("Her", gndNode);
			SlaveHimHer2 = Language.GetHtml("Her2", gndNode);
			if (SlaveHimHer2 == "") SlaveHimHer2 = SlaveHimHer;
			SlaveHimHer3 = Language.GetHtml("Her3", gndNode);
			if (SlaveHimHer3 == "") SlaveHimHer3 = SlaveHimHer;
			SlaveHimHer4 = Language.GetHtml("Her4", gndNode);
			if (SlaveHimHer4 == "") SlaveHimHer4 = SlaveHimHer;
			SlaveHisHer = SlaveHimHer;
			SlaveHisHer2 = SlaveHisHer;
			SlaveHisHer3 = SlaveHisHer;
			SlaveHisHer4 = SlaveHisHer;
			SlaveHeShe = Language.GetHtml("She", gndNode);
			SlaveBoyGirl = "girl";
		} else {
			SlaveHimHer = Language.GetHtml("Him", gndNode);
			SlaveHimHer2 = Language.GetHtml("Him2", gndNode);
			if (SlaveHimHer2 == "") SlaveHimHer2 = SlaveHimHer;
			SlaveHimHer3 = Language.GetHtml("Him3", gndNode);
			if (SlaveHimHer3 == "") SlaveHimHer3 = SlaveHimHer;
			SlaveHimHer4 = Language.GetHtml("Him4", gndNode);
			if (SlaveHimHer4 == "") SlaveHimHer4 = SlaveHimHer;
			SlaveHisHer = Language.GetHtml("His", gndNode);
			SlaveHimHer2 = Language.GetHtml("His2", gndNode);
			if (SlaveHisHer2 == "") SlaveHisHer2 = SlaveHisHer;
			SlaveHisHer3 = Language.GetHtml("His3", gndNode);
			if (SlaveHisHer3 == "") SlaveHisHer3 = SlaveHisHer;
			SlaveHisHer4 = Language.GetHtml("His4", gndNode);
			if (SlaveHisHer4 == "") SlaveHisHer4 = SlaveHisHer;
			SlaveHeShe = Language.GetHtml("He", gndNode);
			SlaveBoyGirl = "boy";
		}
		SlaveHeSheSingle = SlaveHeShe;
		SlaveHisHerSingle = SlaveHisHer;
		SlaveHimHerSingle = SlaveHisHer;
		if (cgender > 3) SlaveIs = Language.GetHtml("SlaveIsTwins", gndNode);
		else SlaveIs = Language.GetHtml("SlaveIs", gndNode);
		if (cgender > 3) SlaveHas = Language.GetHtml("SlaveHasTwins", gndNode);
		else SlaveHas = Language.GetHtml("SlaveHas", gndNode);
		SlaveHeSheIs = SlaveHeShe + " is";
		SlaveHeSheHas = SlaveHeShe + " has";
		SlaveGirlGirls = "this " + SlaveBoyGirl;
		SlaveMe = "me";
	}
	SlaveHeSheUC = NameCase(SlaveHeShe);
	SlaveFemale = sd.SlaveGender != 0 && sd.SlaveGender != 1 && sd.SlaveGender != 4;
	if (cgender > 3) SlaveMeet = Language.GetHtml("SlaveMeetTwins", gndNode);
	else SlaveMeet = Language.GetHtml("SlaveMeet", gndNode);
	if (cgender > 3) SlaveSee = Language.GetHtml("SlaveSeeTwins", gndNode);
	else SlaveSee = Language.GetHtml("SlaveSee", gndNode);
	var dg:Boolean = sd.IsDickgirl();
	HasCock = dg || sd.SlaveGender == 1 || sd.SlaveGender == 4;
}

function UpdateSlaveGender(sd:Object)
{
	UpdateSlaveGenderText(sd);
	dspMain.UpdateSlaveGender(sd);
	SetClitCockSize(undefined, sd);
}

function ChangeSlaveGender(gnd:Number, sd:Object, noid:Boolean)
{
	if (sd == undefined) sd = _root;
	if (sd != _root) {
		sd.ChangeSlaveGender(gnd);
		return;
	}
	if (gnd != undefined) {
		DickgirlXF = 0;
		SlaveGender = gnd;
		if (noid != true) GenderIdentity = gnd;
		if (gnd == 3 || gnd == 6) {
			if (MinLibido < 40) MinLibido = 40;
			DickgirlXF = 2;
			slaveData.SlaveGender = gnd;
			Icons.ShowDickgirlIconNow();
		} else Icons.HideDickgirlIcon();
		if (gnd == 3 || gnd == 1 || gnd == 4 || gnd == 6) UnEquipItem(15);
		if (gnd == 1 || gnd == 4) UnEquipItem(6);
		SetActButtonDetailsStartup();
		slaveData.CopyCommonDetails(_root);
	} else SetActButtonDetailsStartup();
	UpdateSlaveGender();
	UpdateSlave();
}

// Slave Maker
var SlaveMakerHeShe:String;
var SlaveMakerHimHer:String;
var SlaveMakerHisHer:String;

function ChangeSlaveMakerGender(gnd:Number)
{
	if (gnd != undefined) Gender = gnd;
	if (Gender > 3) {
		Gender = Gender % 3;
		if (Gender == 0) Gender = 1;
	}
	SMData.Gender = Gender;
	
	if (SMData.Gender == 0) {
		SlaveMakerHimHer = Language.GetHtml("It", gndNode);
		SlaveMakerHeShe = Language.GetHtml("It", gndNode);
		SlaveMakerHisHer = Language.GetHtml("Its", gndNode);
		Master = Language.GetHtml("Master", actNode);
	} else if (SMData.Gender != 1) {
		SlaveMakerHimHer = Language.GetHtml("Her", gndNode);
		SlaveMakerHeShe = Language.GetHtml("She", gndNode);
		SlaveMakerHisHer = SlaveMakerHimHer;
		Master = Language.GetHtml("Mistress", actNode);
	} else {
		Master = Language.GetHtml("Master", actNode);
		SlaveMakerHimHer = Language.GetHtml("Him", gndNode);
		SlaveMakerHisHer = Language.GetHtml("His", gndNode);
		SlaveMakerHeShe = Language.GetHtml("He", gndNode);
	}
	if (ServantMaster == "Mistress" || ServantMaster == "Master") ServantMaster = Master;

	UpdateSlaveMaker();
	dspMain.UpdateSlaveMakerGender();
	
	SMAvatar.ChangeAppearance(SMData.Appearance);
	if (config.bColoursOn) {
		if (SMData.Gender == 1) SMData.clrScheme = config.colourMale;
		else if (SMData.Gender == 2) SMData.clrScheme = config.colourFemale;
		else SMData.clrScheme = config.colourDickgirl;
	} else SMData.clrScheme = config.colourReset;
	dspMain.ApplyTheme(SMData.clrScheme);
}

// Assistant
var ServantHeSheSingle:String;
var ServantHeShe:String;
var ServantGender:Number;
var ServantHeSheIs:String;
var ServantHeSheHas:String;
var ServantHisHer:String;
var ServantHisHer2:String;
var ServantHisHer3:String;
var ServantHisHer4:String;
var ServantHimHer:String;
var ServantHimHer2:String;
var ServantHimHer3:String;
var ServantHimHer4:String;
var ServantGirlGirls:String;
var ServantHeSheUC:String;
var ServantFemale:Boolean;
var ServantWoman:Boolean;
var ServantIs:String;
var ServantMe:String;

function ChangeAssistantGender(gender:Number) {	AssistantData.ChangeSlaveGender(gender); }

function UpdateServantGenderText()
{
	if (IsNoAssistant()) {
		ServantHisHer = Language.GetHtml("PersonYour", "People");
		ServantHeShe = Language.GetHtml("PersonYou", "People");
		ServantHeSheUC = NameCase(ServantHeShe);
		ServantPronoun = NameCase(ServantHeShe);
		return;
	}
	if (ServantGender > 3) {
		ServantIs = Language.GetHtml("AssistantIsTwins", gndNode);
		ServantHimHer = Language.GetHtml("Them", gndNode);
		ServantHimHer2 = Language.GetHtml("Them2", gndNode);
		if (ServantHimHer2 == "") ServantHimHer2 = ServantHimHer;
		ServantHimHer3 = Language.GetHtml("Them3", gndNode);
		if (ServantHimHer3 == "") ServantHimHer3 = ServantHimHer;
		ServantHimHer4 = Language.GetHtml("Them4", gndNode);
		if (ServantHimHer4 == "") ServantHimHer4 = ServantHimHer;
		ServantHisHer = Language.GetHtml("Their", gndNode);
		ServantHisHer2 = Language.GetHtml("Their2", gndNode);
		if (ServantHisHer2 == "") ServantHisHer2 = ServantHisHer;
		ServantHisHer3 = Language.GetHtml("Their3", gndNode);
		if (ServantHisHer3 == "") ServantHisHer3 = ServantHisHer;
		ServantHisHer4 = Language.GetHtml("Their4", gndNode);
		if (ServantHisHer4 == "") ServantHisHer4 = ServantHisHer;
		ServantHeShe = Language.GetHtml("They", gndNode);
		ServantHeSheIs = "they are";
		ServantHeSheHas = "they have";
		ServantHeSheSingle = gender == 4 ? Language.GetHtml("He", gndNode) : Language.GetHtml("She", gndNode);
		ServantGirlGirls = gender == 4 ? "these boys" : "these girls";
		ServantMe = "us";
	} else {
		if (AssistantData.GenderIdentity == 0) {
			ServantHimHer = Language.GetHtml("It", gndNode);
			ServantHimHer2 = Language.GetHtml("It", gndNode);
			if (ServantHimHer2 == "") ServantHimHer2 = ServantHimHer;
			ServantHimHer3 = Language.GetHtml("It", gndNode);
			if (ServantHimHer3 == "") ServantHimHer3 = ServantHimHer;
			ServantHimHer4 = Language.GetHtml("It", gndNode);
			if (ServantHimHer4 == "") ServantHimHer4 = ServantHimHer;
			ServantHisHer = Language.GetHtml("Its", gndNode);
			ServantHisHer2 = ServantHisHer;
			ServantHisHer3 = ServantHisHer;
			ServantHisHer4 = ServantHisHer;
			ServantHeShe = Language.GetHtml("It", gndNode);
			ServantGirlGirls = "this person";
		} else 
		if (AssistantData.GenderIdentity != 1) {
			ServantHimHer = Language.GetHtml("Her", gndNode);
			ServantHimHer2 = Language.GetHtml("Her2", gndNode);
			if (ServantHimHer2 == "") ServantHimHer2 = ServantHimHer;
			ServantHimHer3 = Language.GetHtml("Her3", gndNode);
			if (ServantHimHer3 == "") ServantHimHer3 = ServantHimHer;
			ServantHimHer4 = Language.GetHtml("Her4", gndNode);
			if (ServantHimHer4 == "") ServantHimHer4 = ServantHimHer;
			ServantHisHer = ServantHimHer;
			ServantHisHer2 = ServantHisHer;
			ServantHisHer3 = ServantHisHer;
			ServantHisHer4 = ServantHisHer;
			ServantHeShe = Language.GetHtml("She", gndNode);
			ServantGirlGirls = "this girl";
		} else {
			ServantHimHer = Language.GetHtml("Him", gndNode);
			ServantHimHer2 = Language.GetHtml("Him2", gndNode);
			if (ServantHimHer2 == "") ServantHimHer2 = ServantHimHer;
			ServantHimHer3 = Language.GetHtml("Him3", gndNode);
			if (ServantHimHer3 == "") ServantHimHer3 = ServantHimHer;
			ServantHimHer4 = Language.GetHtml("Him4", gndNode);
			if (ServantHimHer4 == "") ServantHimHer4 = ServantHimHer;
			ServantHisHer = Language.GetHtml("His", gndNode);
			ServantHisHer2 = Language.GetHtml("His2", gndNode);
			if (ServantHisHer2 == "") ServantHisHer2 = ServantHisHer;
			ServantHisHer3 = Language.GetHtml("His3", gndNode);
			if (ServantHisHer3 == "") ServantHisHer3 = ServantHisHer;
			ServantHisHer4 = Language.GetHtml("His4", gndNode);
			if (ServantHisHer4 == "") ServantHisHer4 = ServantHisHer;
			ServantHeShe = Language.GetHtml("He", gndNode);
			ServantGirlGirls = "this boy";
		}
		ServantIs = Language.GetHtml("AssistantIs", gndNode);
		ServantMe = "me";
		ServantHeSheSingle = ServantHeShe;
		ServantHeSheIs = ServantHeShe + " is";
		ServantHeSheHas = ServantHeShe + " has";
	}
	ServantHeSheUC = NameCase(ServantHeShe);
	ServantFemale = ServantGender != 1 && ServantGender != 4;
	ServantWoman = (AssistantData.IsDickgirl() == false) && (ServantGender == 2 || ServantGender == 5);
}


// General Person
var PersonHeShe:String;
var PersonHimHer:String;
var PersonHisHer:String;
var PersonGender:Number;
var PersonGenderIdentity:Number;
var PersonName:String;
var PersonMaster:String;

function GetPersonGenderText(pgender:Number)
{
	if (pgender == undefined) {
		if (PersonIndex == -100) {
			PersonGender = Gender;
			PersonHisHer = Language.GetHtml("PersonYour", "People");
			PersonHeShe = Language.GetHtml("PersonYou", "People");
			PersonHimHer = Language.GetHtml("PersonYou", "People");
			return;
		} else if (PersonIndex == -99) pgender = AssistantData.GenderIdentity;
		else if (PersonIndex == -50) pgender = GenderIdentity;
		else pgender = PersonGender;
		PersonGender = pgender;
	}
	if (pgender > 3) {
		PersonHimHer = Language.GetHtml("Them", gndNode);
		PersonHeShe = Language.GetHtml("They", gndNode);
		PersonHisHer = Language.GetHtml("Their", gndNode);
		if (pgender == 4) PersonMaster = Language.GetHtml("Master", actNode);
		else PersonMaster = Language.GetHtml("Mistress", actNode);
	} else {
		if (pgender == 0) {
			PersonHimHer = Language.GetHtml("It", gndNode);
			PersonHeShe = PersonHimHer;
			PersonHisHer = Language.GetHtml("Its", gndNode);
			PersonMaster = Language.GetHtml("Master", actNode);
		} else if (pgender != 1) {
			PersonHimHer = Language.GetHtml("Her", gndNode);
			PersonHeShe = Language.GetHtml("She", gndNode);
			PersonHisHer = PersonHimHer;
			PersonMaster = Language.GetHtml("Mistress", actNode);
		} else {
			PersonHimHer = Language.GetHtml("Him", gndNode);
			PersonHeShe = Language.GetHtml("He", gndNode);
			PersonHisHer = Language.GetHtml("His", gndNode);
			PersonMaster = Language.GetHtml("Master", actNode);
		}
	}
}

// Another General Person
var PersonOtherHeShe:String;
var PersonOtherHimHer:String;
var PersonOtherHisHer:String;
var PersonOtherGender:Number;
var PersonOtherName:String;
var PersonOtherMaster:String;

function GetPersonOtherGenderText(pgender:Number)
{
	if (pgender == undefined) pgender = 2;
	if (pgender > 3) {
		PersonOtherHimHer = Language.GetHtml("Them", gndNode);
		PersonOtherHeShe = Language.GetHtml("They", gndNode);
		PersonOtherHisHer = Language.GetHtml("Their", gndNode);
		if (pgender == 4) PersonOtherMaster = Language.GetHtml("Master", actNode);
		else PersonOtherMaster = Language.GetHtml("Mistress", actNode);
	} else {
		if (pgender == 0) {
			PersonOtherHimHer = Language.GetHtml("It", gndNode);
			PersonOtherHeShe = PersonOtherHimHer;
			PersonOtherHisHer = Language.GetHtml("Its", gndNode);
			PersonOtherMaster = Language.GetHtml("Master", actNode);
		} else if (pgender != 1) {
			PersonOtherHimHer = Language.GetHtml("Her", gndNode);
			PersonOtherHeShe = Language.GetHtml("She", gndNode);
			PersonOtherHisHer = PersonOtherHimHer;
			PersonOtherMaster = Language.GetHtml("Mistress", actNode);
		} else {
			PersonOtherHimHer = Language.GetHtml("Him", gndNode);
			PersonOtherHeShe = Language.GetHtml("He", gndNode);
			PersonOtherHisHer = Language.GetHtml("His", gndNode);
			PersonOtherMaster = Language.GetHtml("Master", actNode);

		}
	}
}
