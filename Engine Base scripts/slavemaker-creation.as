import Scripts.Classes.*;

// Slave Maker Creation

// Screen 1 - Basic Details

SlaveMakerCreate1.DifficultyText.styleSheet = Language.styles;
// Combobox bloodtype
SlaveMakerCreate1.BloodtypeCombo.setStyle("backgroundColor", 0x398286);
SlaveMakerCreate1.BloodtypeCombo.setStyle("color", 0xFFFFFF);
SlaveMakerCreate1.BloodtypeCombo.addEventListener("click", checkboxListener);
SlaveMakerCreate1.LBloodtype.styleSheet = Language.styles;

var btListener:Object = new Object();
btListener.change = function(btobj:Object) {
	SMData.vitalsBloodTypeSM = btobj.target.selectedItem.label;
}
btListener.itemRollOver = function(btobj:Object) {
	SMData.ShowBloodTypeHint(SlaveMakerCreate1.BloodtypeCombo.getItemAt(btobj.index).label, SlaveMakerCreate1.BloodtypeCombo._x, SlaveMakerCreate1.BloodtypeCombo.width);
}
btListener.itemRollOut = function (btobj:Object) {
	Hints.HideHints();
}
SlaveMakerCreate1.BloodtypeCombo.addEventListener("change", btListener);
SlaveMakerCreate1.BloodtypeCombo.enabled = false;
SlaveMakerCreate1.BloodtypeCombo.addEventListener("itemRollOver", btListener);
SlaveMakerCreate1.BloodtypeCombo.addEventListener("itemRollOut", btListener);
SlaveMakerCreate1.LBloodtype.styleSheet = Language.styles;

function DoSlaveMakerCreate1()
{
	SMAppearance._visible = false;
	TitleScreen.Introduction = 5.05;
	ResetGame();
	ResetSlaveMaker();
	ResetSlave();
	ResetActImages();
	LoadSave.StartGame();
	Options.UpdateFromGlobalData();
	{
		// default some fields from last used slave maker
		var cookiesm:SharedObject = GetSaveData("smlastusedslavemaker");
		if (cookiesm.data.SlaveMakerName != undefined) {
			SMData.vitalsBloodTypeSM = cookiesm.data.vitalsBloodTypeSM;
			vitalsBloodTypeSM = SMData.vitalsBloodTypeSM;
			SMData.Appearance = cookiesm.data.Appearance;
			SMData.SlaveMakerName = cookiesm.data.SlaveMakerName;
			SlaveMakerName = SMData.SlaveMakerName;
			SMData.Gender = cookiesm.data.Gender;
			Gender = SMData.Gender;
			SMData.SMFaith = cookiesm.data.SMFaith;
			SMFaith = SMData.SMFaith;
		}
	}
	
	SlaveMakerCreate1.radioGroupBuild.selectedData = 1;
	SlaveMakerCreate1.radioGroupCock.selectedData = 1;
	SlaveMakerCreate1.radioGroupBust.selectedData = 1;
	
	SlaveMakerCreate1.BloodtypeCombo.enabled = true;
	SlaveMakerCreate1.BloodtypeCombo.removeAll();
	SlaveMakerCreate1.BloodtypeCombo.addItem("A");
	SlaveMakerCreate1.BloodtypeCombo.addItem("B");
	SlaveMakerCreate1.BloodtypeCombo.addItem("AB");
	SlaveMakerCreate1.BloodtypeCombo.addItem("O");

	SlaveMakerCreate1.tabChildren = true;
	
	var sd:Slave = new Slave(coreGame);
	UpdateSlaveGenderText(sd);

	DoSlaveMakerCreate1a();
}
	
function DoSlaveMakerCreate1a()
{
	SMData.CopySlaveMakerDetails(undefined, _root);
	
	Backgrounds.ShowIntroBackground(37, 80, 80, 0, 0, 0, 0);
	TitleScreen.BackButton.Move(595, 555);
	TitleScreen.BackButton.ShowAligned(4);
	TitleScreen.LoadButton.Move(675, 551);
	TitleScreen.LoadButton.ShowAligned(4);
	
	// reset any options changes
	if (Difficulty == -1) SMData.SMCustomPoints = config.GetValue("SlaveMakerDefaults/CustomPoints", 100) + 20;
	else if (Difficulty == 0) SMData.SMCustomPoints = config.GetValue("SlaveMakerDefaults/CustomPoints", 100);
	else if (Difficulty == 1) SMData.SMCustomPoints = config.GetValue("SlaveMakerDefaults/CustomPoints", 100) - 10;
	else SMData.SMCustomPoints = config.GetValue("DefaultCustomPoints", 100) - 20;
	if (SMData.SMCustomPoints < 0) SMData.SMCustomPoints = 0;
	if (DickgirlOn == 0 && SMData.Gender == 3) SMData.Gender = 2;

	// populate dialog
	SlaveMakerCreate1.SlaveMakerName.text = SMData.SlaveMakerName;
		
	switch(SMData.vitalsBloodTypeSM) {
		case "A": SlaveMakerCreate1.BloodtypeCombo.selectedIndex = 0; break;
		case "B": SlaveMakerCreate1.BloodtypeCombo.selectedIndex = 1; break;
		case "AB": SlaveMakerCreate1.BloodtypeCombo.selectedIndex = 2; break;
		case "O": SlaveMakerCreate1.BloodtypeCombo.selectedIndex = 3; break;
	}
	switch(SMData.Gender) {
		case 1: SlaveMakerCreate1.GenderMale.Btn.onPress(); break;
		case 2: SlaveMakerCreate1.GenderFemale.Btn.onPress(); break;
		case 3: SlaveMakerCreate1.GenderDickgirl.Btn.onPress(); break;
	}
	if (SMData.SMFaith == 2) SlaveMakerCreate1.GodsText.text = Language.GetHtml("OldGods", "Faith");
	else if (SMData.SMFaith == 1) SlaveMakerCreate1.GodsText.text = Language.GetHtml("NewGods", "Faith");
	else SlaveMakerCreate1.GodsText.text = Language.GetHtml("NoGods", "Faith");
	SlaveMakerCreate1.LGods.htmlText = Language.GetHtml("Religion", "Faith");
	
	var aNode:XMLNode = XMLData.GetNodeC(flNode, "SlaveMaker");
	SlaveMakerCreate1.SlimRadio.label = Language.GetHtml("BuildSlim", aNode);
	SlaveMakerCreate1.AverageRadio.label = Language.GetHtml("BuildAverage", aNode);
	SlaveMakerCreate1.HeavyRadio.label = Language.GetHtml("BuildHeavy", aNode);
	SlaveMakerCreate1.SmallCockRadio.label = Language.GetHtml("CockSmall", aNode) + " ";
	SlaveMakerCreate1.LargeCockRadio.label = Language.GetHtml("CockLarge", aNode) + " ";
	SlaveMakerCreate1.AverageCockRadio.label = SlaveMakerCreate1.AverageRadio.label + " ";
	SlaveMakerCreate1.SmallBustRadio.label = SlaveMakerCreate1.SmallCockRadio.label + " ";
	SlaveMakerCreate1.AverageBustRadio.label = SlaveMakerCreate1.AverageRadio.label + " ";
	SlaveMakerCreate1.LargeBustRadio.label = SlaveMakerCreate1.LargeCockRadio.label + " ";
	SlaveMakerCreate1.LBloodtype.htmlText = Language.GetHtml("BloodType", statNode, true, -1).split("\n").join("").split("\r").join("").split(":").join("");
	SlaveMakerCreate1.LGender.text = Language.GetHtml("Gender", "Gender");
	SlaveMakerCreate1.LProfile.htmlText = Language.GetHtml("Profile", aNode, true, 0, "", "", true);
	
	SlaveMakerCreate1.LCreate.htmlText = Language.GetHtml("CreateSM1", aNode, true);
	SlaveMakerCreate1.LDescription.htmlText = Language.GetHtml("CreateSM1Description", aNode, true);
	SlaveMakerCreate1.LName.htmlText = Language.GetHtml("Name", aNode);
	SlaveMakerCreate1.LMeasurements.htmlText = Language.GetHtml("Measurements", aNode);
	SlaveMakerCreate1.LBuild.htmlText = Language.GetHtml("Build", aNode, true, -1);
	SlaveMakerCreate1.LBust.htmlText = Language.GetHtml("Bust", aNode, true, -1);
	SlaveMakerCreate1.LPackageAdvanced.htmlText = Language.GetHtml("PackageAdvanced", aNode, true);
	
	SlaveMakerCreate1.OptionsButton.LText.htmlText = Language.GetHtml("Title", "Options", false, -1);
	SlaveMakerCreate1.LOptions.htmlText = Language.GetHtml("Title", "Options", true);

	SlaveMakerCreate1.LHeight.htmlText = Language.GetHtml("Height", "Statistics", true, -1);
	SlaveMakerCreate1.LWeight.htmlText = Language.GetHtml("Weight", "Statistics", true, -1);
			
	SlaveMakerCreate1._visible = true;
	if (Options.TutorialOn && BitFlagSM.CheckAndSetBitFlag(41)) Information.ShowTutorialLang("CreateSlaveMaker");
	
}

function SlaveMakerCreate1Shortcuts(keyAscii:Number, key:Number)
{
	if (key == 37) {
		SMData.Gender--;
		if (SMData.Gender < 1) {
			if (DickgirlOn == 1) SMData.Gender = 3;
			else SMData.Gender = 2;
		}
		switch(SMData.Gender) {
			case 1: SlaveMakerCreate1.GenderMale.Btn.onPress(); break;
			case 2: SlaveMakerCreate1.GenderFemale.Btn.onPress(); break;
			case 3: SlaveMakerCreate1.GenderDickgirl.Btn.onPress(); break;
		}
	} else if (key == 39) {
		SMData.Gender++;
		if (DickgirlOn == 1) {
			if (SMData.Gender > 3) SMData.Gender = 1;
		} else {
			if (SMData.Gender > 2) SMData.Gender = 1;
		}
		switch(SMData.Gender) {
			case 1: SlaveMakerCreate1.GenderMale.Btn.onPress(); break;
			case 2: SlaveMakerCreate1.GenderFemale.Btn.onPress(); break;
			case 3: SlaveMakerCreate1.GenderDickgirl.Btn.onPress(); break;
		}
	} else if (key == 38) SlaveMakerCreate1.AppearanceMinus.onPress();
	else if (key == 40) SlaveMakerCreate1.AppearancePlus.onPress(); 
}

function SaveMeasurementsSM()
{
	SMData.SlaveMakerName = SlaveMakerCreate1.SlaveMakerName.text;
	VisitFortuneTeller.SlaveMakerName.text = SMData.SlaveMakerName;

	if (SlaveMakerCreate1.radioGroupBuild.selection.data == 0) {
		SMData.vitalsBustSM -= 5;
		SMData.vitalsBustStartSM -= 5;
		SMData.vitalsWaistSM -= 5;
		SMData.vitalsHipsSM -= 5;
		SMData.vitalsHeightSM -= 5;

	} else if (SlaveMakerCreate1.radioGroupBuild.selection.data == 2) {
		SMData.vitalsBustSM += 5;
		SMData.vitalsBustStartSM += 5;
		SMData.vitalsWaistSM += 5;
		SMData.vitalsHipsSM += 5;
		SMData.vitalsWeightSM += 5;
	}
	
	if (SlaveMakerCreate1.radioGroupCock.selection.data == 0) SMData.ClitCockSizeSM *= 0.8;
	else if (SlaveMakerCreate1.radioGroupCock.selection.data == 2) SMData.ClitCockSizeSM *= 1.2;
	SMData.ClitCockSizeStartSM = SMData.ClitCockSizeSM;
	
	if (SMData.Gender != 1) {
		if (SlaveMakerCreate1.radioGroupBust.selection.data == 0) {
			SMData.vitalsBustSM *= 0.8
			SMData.vitalsBustStartSM *= 0.8;
		} else 	if (SlaveMakerCreate1.radioGroupBust.selection.data == 2) {
			SMData.vitalsBustSM *= 1.2
			SMData.vitalsBustStartSM *= 1.2;
		}
	}
	SMData.CopySlaveMakerDetails(undefined, _root);
}

SlaveMakerCreate1.GenderMale.tabChildren = true;
SlaveMakerCreate1.GenderMale.Btn.onPress = function() {
	SMData.Gender = 1;
	SMData.OldGender = SMData.Gender;
	SlaveMakerCreate1.LGenderText.htmlText = Language.GetHtml("MaleSlaveMaker", "SlaveMaker", true, -1);
	SlaveMakerCreate1.LGenderDetails.htmlText = Language.GetHtml("CreateSM1MaleDescription", "SlaveMaker", false, -1);
	SlaveMakerCreate1.LClitCock.htmlText = Language.GetHtml("Cock", "SlaveMaker", true, -1);
	SlaveMakerCreate1.LBust._visible = false;
	SlaveMakerCreate1.SmallBustRadio._visible = false;
	SlaveMakerCreate1.AverageBustRadio._visible = false;
	SlaveMakerCreate1.LargeBustRadio._visible = false;
	SMData.vitalsBustSM = config.GetValue("SlaveMakerDefaults/Male/Chest", 100);
	SMData.vitalsWaistSM = config.GetValue("SlaveMakerDefaults/Male/Waist", 90);
	SMData.vitalsHipsSM = config.GetValue("SlaveMakerDefaults/Male/Hips", 95);
	SMData.vitalsHeightSM = config.GetValue("SlaveMakerDefaults/Male/Height", 178);
	SMData.vitalsWeightSM = SMSlaveCommon.calcWeightMale(SMData.vitalsHeightSM);
	SMData.vitalsBustStartSM = SMData.vitalsBustSM;
	SMAvatar.ChangeAppearance();
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	SlaveMakerCreate1.GenderMale._alpha = 100;
	SlaveMakerCreate1.GenderFemale._alpha = 30;
	SlaveMakerCreate1.GenderDickgirl._alpha = 30;
	Beep();
}

SlaveMakerCreate1.GenderFemale.tabChildren = true;
SlaveMakerCreate1.GenderFemale.Btn.onPress = function() {
	SMData.Gender = 2;
	SMData.OldGender = SMData.Gender;
	SlaveMakerCreate1.LGenderText.htmlText = Language.GetHtml("FemaleSlaveMaker", "SlaveMaker", true, -1);
	SlaveMakerCreate1.LGenderDetails.htmlText = Language.GetHtml("CreateSM1FemaleDescription", "SlaveMaker", false, -1);
	SlaveMakerCreate1.LClitCock.htmlText = Language.GetHtml("Clitoris", "SlaveMaker", true, -1);
	SlaveMakerCreate1.LBust._visible = true;
	SlaveMakerCreate1.SmallBustRadio._visible = true;
	SlaveMakerCreate1.AverageBustRadio._visible = true;
	SlaveMakerCreate1.LargeBustRadio._visible = true;
	SMData.vitalsBustSM = config.GetValue("SlaveMakerDefaults/Female/Bust", 92);
	SMData.vitalsWaistSM = config.GetValue("SlaveMakerDefaults/Female/Waist", 61);
	SMData.vitalsHipsSM = config.GetValue("SlaveMakerDefaults/Female/Hips", 92);
	SMData.vitalsHeightSM = config.GetValue("SlaveMakerDefaults/Female/Height", 170);
	SMData.vitalsWeightSM = SMSlaveCommon.calcWeightFemale(SMData.vitalsHeightSM);
	SMData.vitalsBustStartSM = SMData.vitalsBustSM;
	SMAvatar.ChangeAppearance();
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	SlaveMakerCreate1.GenderMale._alpha = 30;
	SlaveMakerCreate1.GenderFemale._alpha = 100;
	SlaveMakerCreate1.GenderDickgirl._alpha = 30;

	Beep();
}

SlaveMakerCreate1.GenderDickgirl.tabChildren = true;
SlaveMakerCreate1.GenderDickgirl.Btn.onPress = function() {
	SMData.Gender = 3;
	SMData.OldGender = SMData.Gender;

	SlaveMakerCreate1.LGenderText.htmlText = Language.GetHtml("DickgirlSlaveMaker", "SlaveMaker", true, -1);
	SlaveMakerCreate1.LGenderDetails.htmlText = Language.GetHtml("CreateSM1DickgirlDescription", "SlaveMaker", false, -1);
	SlaveMakerCreate1.LClitCock.htmlText = Language.GetHtml("Cock", "SlaveMaker", true, -1);
	SlaveMakerCreate1.LBust._visible = true;
	SlaveMakerCreate1.SmallBustRadio._visible = true;
	SlaveMakerCreate1.AverageBustRadio._visible = true;
	SlaveMakerCreate1.LargeBustRadio._visible = true;
	SMData.vitalsBustSM = config.GetValue("SlaveMakerDefaults/Female/Bust", 92);
	SMData.vitalsWaistSM = config.GetValue("SlaveMakerDefaults/Female/Waist", 61);
	SMData.vitalsHipsSM = config.GetValue("SlaveMakerDefaults/Female/Hips", 92);
	SMData.vitalsHeightSM = config.GetValue("SlaveMakerDefaults/Female/Height", 170);
	SMData.vitalsWeightSM = SMSlaveCommon.calcWeightFemale(SMData.vitalsHeightSM);
	SMData.vitalsBustStartSM = SMData.vitalsBustSM;
	SMAvatar.ChangeAppearance();
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	SlaveMakerCreate1.GenderMale._alpha = 30;
	SlaveMakerCreate1.GenderFemale._alpha = 30;
	SlaveMakerCreate1.GenderDickgirl._alpha = 100;

	Beep();
}


SlaveMakerCreate1.AppearanceMinus.onPress = function() {
	if (SMData.Appearance > 0) SMData.Appearance--;
	else {
		SMData.Appearance++;
		if (SMData.Appearance == 0) SMData.Appearance = -10000;
	}
	SMAvatar.ChangeAppearance(SMData.Appearance);
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	Beep();
}

SlaveMakerCreate1.AppearancePlus.onPress = function() {
	if (SMData.Appearance > 0) SMData.Appearance++;
	else SMData.Appearance--;
	SMAvatar.ChangeAppearance(SMData.Appearance);
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	Beep();
}
SlaveMakerCreate3.AppearanceMinus.onPress = SlaveMakerCreate1.AppearanceMinus.onPress;
SlaveMakerCreate3.AppearancePlus.onPress = SlaveMakerCreate1.AppearancePlus.onPress;

SlaveMakerCreate1.PackageBtn.tabChildren = true;
SlaveMakerCreate1.PackageBtn.Btn.onPress = function() {
	SaveMeasurementsSM();
	TitleScreen.DoIntroNext(5.1);
}
SlaveMakerCreate1.AdvancedBtn.tabChildren = true;
SlaveMakerCreate1.AdvancedBtn.Btn.onPress = function() {
	SaveMeasurementsSM();
	TitleScreen.DoIntroNext(5.2);
}

SlaveMakerCreate1.Gods.tabChildren = true;
SlaveMakerCreate1.Gods.Btn.onPress = function() {
	currentDialog = new DialogSelectFaith(coreGame);
	currentDialog.ViewDialog();
	
	SMAppearance._visible = false;
	SlaveMakerCreate1._visible = false;
	TitleScreen.BackButton.Hide();
	TitleScreen.LoadButton.Hide();
	Beep();
}

SlaveMakerCreate1.UseLast.tabChildren = true;
SlaveMakerCreate1.UseLast.Btn.onPress = function() {

	LoadSlaveMakerTemplate("smlastusedslavemaker");
	ClearGeneralArray();
	if (citiesList.GetTotalAvailableCities() > 1) TitleScreen.DoIntroNext(6);
	else {
		citiesList.ChangeCity(citiesList.GetAvailableCity(1), false);
		Timers.ShowWait(true);
		Language.ChangeLanguage(false, "CityLanguageUpdate", _root);
	}
}

function CityLanguageUpdate() { TitleScreen.DoIntroNext(7); }


function LoadSlaveMakerTemplate(str:String) : Boolean
{
	var cookiesm:SharedObject = GetSaveData(str);
	if (cookiesm.data.SlaveMakerName != undefined) {
		SMData.Load(cookiesm.data, "");
		return true;
	}
	return false;
}

// Packages

SlaveMakerCreate2.Talents.setStyle("borderStyle", "none");
SlaveMakerCreate2.tabChildren = true;
SlaveMakerCreate2.Talents.tabChildren = true;
SlaveMakerCreate2.Talents.tabEnabled = false;
SlaveMakerCreate2.Talents.addEventListener("scroll", Language.spListener);

function AddTalent(talent:Number)
{	
	var image:MovieClip = SlaveMakerCreate2.Talents.content.attachMovie("Advanced Choice", "Talent" + arGeneralArray.length, SlaveMakerCreate2.Talents.content.getNextHighestDepth());
	var tn:Number = arGeneralArray.push(image);
	if (tn < 10) image.Shortcut.text = tn;
	else image.Shortcut.text = String.fromCharCode(tn + 55);
	image.AdvantageWhite.wordWrap = true;
	image.AdvantageWhite.autoSize = true;
	image.AdvantageBlack.wordWrap = true;
	image.AdvantageBlack.autoSize = true;

	image.Tick._visible = false;
	image.LabelWhite.text = Language.GetHtml("Talent" + talent + "Title", "Talents");
	image.LabelBlack.text = image.LabelWhite.text;
	image.AdvantageWhite.text = "+ " + Language.GetHtml("Talent" + talent + "Advantage", "Talents");
	image.AdvantageBlack.text = image.AdvantageWhite.text;
	if (Language.GetHtml("Talent" + talent + "Disadvantage", "Talents") != "") {
		image.DisadvantageWhite.text = "- " + Language.GetHtml("Talent" + talent + "Disadvantage", "Talents");
		image.DisadvantageBlack.text = image.DisadvantageWhite.text;
	}
	image.DisadvantageWhite._y = image.AdvantageWhite._y + image.AdvantageWhite._height + 2;
	image.DisadvantageBlack._y = image.AdvantageBlack._y + image.AdvantageBlack._height + 2;

	
	image._x = 0;
	image._height = 59;
	image._width = 751;
	image._y = (tn - 1) * 60;
	image.enabled = true;
	image.tabEnabled = true;
	image.tabChildren = true;

	image.BtnDisabled._visible = false;
	image.Btn.onPress = SelectTalent;

	image._visible = true;
	image.talent = talent;
}


function DoSlaveMakerCreate2()
{	
	SlaveMakerCreate2.Talent0TitleWhite.htmlText = Language.GetHtml("Talent0Title", "Talents");
	SlaveMakerCreate2.Talent0TitleBlack.htmlText = Language.GetHtml("Talent0Title", "Talents");
	SlaveMakerCreate2.Talent0AdvantageWhite.htmlText = Language.GetHtml("Talent0Advantage", "Talents");
	SlaveMakerCreate2.Talent0AdvantageBlack.htmlText = Language.GetHtml("Talent0Advantage", "Talents");
	SlaveMakerCreate2.LName.htmlText = Language.GetHtml("Name", "SlaveMaker");
	SlaveMakerCreate2.LPackageDetails.htmlText = Language.GetHtml("PackageDetails", "SlaveMaker");
	SlaveMakerCreate2.LTalented.htmlText = Language.GetHtml("PackageDescription", "SlaveMaker");
	
	SlaveMakerCreate2.SlaveMakerName.text = SMData.SlaveMakerName;
	Backgrounds.ShowIntroBackground(37, 80, 80, 0, 0, 0, 0);
	TitleScreen.BackButton.Show(10, 533);
	TitleScreen.LoadButton.Show(10, 561);
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	
	ClearGeneralArray();
	for (i = 1; i < 4; i++) AddTalent(i);
	AddTalent(12);
	AddTalent(13);
	if (SMData.Gender == 1) {
		AddTalent(4);
		if (SMData.SMFaith == 2) AddTalent(11);
		if (TentaclesOn == 1) AddTalent(14);
	}
	if (SMData.Gender == 2) {
		AddTalent(5);
		AddTalent(6);
		AddTalent(15);
		AddTalent(16);
	}
	if (SMData.Gender == 3) {
		if (DickgirlLesbians) AddTalent(6);
		AddTalent(8);
		AddTalent(9);
		AddTalent(10);
		if (TentaclesOn == 1) AddTalent(19);
		AddTalent(20);
		AddTalent(21);
		AddTalent(22);
	}
	if (SMData.Gender == 2 || SMData.Gender == 3) {
		if (SMData.SMFaith == 2) AddTalent(7);
		AddTalent(17);
		AddTalent(25);
		AddTalent(28);
	}
	AddTalent(26);
	if (FurriesOn) AddTalent(27);
	AddTalent(29);
	AddTalent(30);
	if (SMData.Gender != 1) AddTalent(31);
	if (SMData.Gender == 1) AddTalent(32);
	AddTalent(33);

	SlaveMakerCreate2.Talents.invalidate();
	SlaveMakerCreate2._visible = true;
}

function SelectTalent(talent:Number) {
	Beep();
	SMData.SlaveMakerName = SlaveMakerCreate2.SlaveMakerName.text;
	if (talent == undefined) talent = this._parent.talent;
	SMData.Talent = talent;
	SMData.CopySlaveMakerDetails(undefined, _root);
	ClearGeneralArray();
	TitleScreen.DoIntroNext(5.3);
}

SlaveMakerCreate2.Talent0.onPress = function() {
	SMData.SlaveMakerName = SlaveMakerCreate2.SlaveMakerName.text;
	ClearGeneralArray();
	SMData.Talent = 0;
	SMData.CopySlaveMakerDetails(undefined, _root);	
	TitleScreen.DoIntroNext(5.3);
}


function SlaveMakerCreate2Shortcuts(keyAscii:Number, key:Number)
{
	if (keyAscii > 48 && keyAscii < 59) {
		if (keyAscii < (49 + arGeneralArray.length)) SelectTalent(arGeneralArray[keyAscii - 49].talent);
	} else  if (keyAscii > 64 && keyAscii < 91) {
		if (keyAscii < (56 + arGeneralArray.length)) SelectTalent(arGeneralArray[keyAscii - 56].talent);
	}
}


// Advanced
var spListenerSMC:Object = new Object();
spListenerSMC.scroll = function(evt_obj:Object):Void {
	SlaveMakerCreate3.Choices.invalidate();
};

SlaveMakerCreate3.Choices.setStyle("borderStyle", "none");
SlaveMakerCreate3.Choices.tabChildren = true;
SlaveMakerCreate3.tabChildren = true;
SlaveMakerCreate3.Choices.tabEnabled = false;
SlaveMakerCreate3.StatisticsChange.tabChildren = true;
SlaveMakerCreate3.StatisticsChange.tabEnabled = false;
SlaveMakerCreate3.Choices.addEventListener("scroll", spListenerSMC);

function AddAdvanced(choice:Number, short:Boolean, enable:Boolean, criteria:String)
{	
	if (enable == undefined) enable = true;
	var image:MovieClip = SlaveMakerCreate3.Choices.content.attachMovie("Advanced Choice", "Choice" + arGeneralArray.length, SlaveMakerCreate3.Choices.content.getNextHighestDepth());
	var tn:Number = arGeneralArray.push(image);
	var cost:Number = SMData.GetSMQualitiesCost(choice);
	image.idx = tn - 1; 
	if (tn < 10) image.Shortcut.text = tn;
	else image.Shortcut.text = String.fromCharCode(tn + 55);

	var choicelabel:String = SMData.GetSMQualitiesName(choice);
	var advdesc:String = SMData.GetSMQualitiesAdvantage(choice);
	var disad:String = SMData.GetSMQualitiesDisadvantage(choice);

	image.AdvantageWhite.wordWrap = true;
	image.AdvantageWhite.autoSize = true;
	image.AdvantageBlack.wordWrap = true;
	image.AdvantageBlack.autoSize = true;

	if (!enable) image.LabelWhite.htmlText = "<b><font color='#999999'>" + choicelabel + "</font></b>";
	else image.LabelWhite.htmlText = "<b>" + choicelabel + "</b>";
	image.LabelBlack.htmlText = "<b>" + choicelabel + "</b>";
	if (advdesc != "") {
		if (enable) image.AdvantageWhite.htmlText = "<font color='#FFFFFF'>+ " + advdesc + "</font>";
		else image.AdvantageWhite.htmlText = "<font color='#999999'>+ " + advdesc + "</font>";
		image.AdvantageBlack.text = "+ " + advdesc;
	}
	if (disad != "") {
		if (advdesc == "") {
			if (enable) image.AdvantageWhite.htmlText = "<font color='#FFFFFF'>- " + disad + "</font>";
			else image.AdvantageWhite.htmlText = "<font color='#999999'>- " + disad + "</font>";
			image.AdvantageBlack.text = "- " + disad;
		} else {
			if (enable) image.DisadvantageWhite.htmlText =  "<font color='#FFFFFF'>- " + disad + "</font>";
			else image.DisadvantageWhite.htmlText = "<font color='#999999'>- " + disad + "</font>";
			image.DisadvantageBlack.text =  "- " + disad;
		}
	}
	image.DisadvantageWhite._y = image.AdvantageWhite._y + image.AdvantageWhite._height + 2;
	image.DisadvantageBlack._y = image.AdvantageBlack._y + image.AdvantageBlack._height + 2;
	
	if (image.idx > 0) image._y = arGeneralArray[image.idx - 1].nexty;
	if (short == true) {		
		image.nexty = image._y + 40;
		image.Tick._y = 60;
		image.Btn._height = 75;
	} else {
		image.nexty = image._y + 55;
		image.Tick._y = 72;
	}
	if (enable) {
		if (Math.abs(cost) != 1) image.CostLabel.htmlText = "<font color='#FFFFFF'>" + cost + " points</font>";
		else image.CostLabel.htmlText = "<font color='#FFFFFF'>" + cost + " point</font>";
	} else {
		if (Math.abs(cost) != 1) image.CostLabel.htmlText = "<font color='#999999'>" + cost + " points</font>";
		else image.CostLabel.htmlText = "<font color='#999999'>" + cost + " point</font>";
	}
	image.Tick._visible = false;
	image._height = 59;
	image._width = 751;
	image.enabled = true;
	image.tabEnabled = true;
	image.tabChildren = true;
	image.Btn._visible = enable;
	image.BtnDisabled._visible = !enable;
	image.Btn.onPress = SelectChoice;
	image.Btn.onRollOut = function() { Hints.HideHints(); };
	image.Btn.onRollOver = function() { SMData.SMQualitiesHintRollOver(this._parent); };
	image.BtnDisabled.onRollOver = function() { SMData.SMQualitiesHintRollOver(this._parent); };
	image.BtnDisabled.onRollOut = image.Btn.onRollOut;

	image._visible = true;
	image.choice = choice;
	image.cost = cost;
	image.hint = hint;
	image.criteria = criteria;
}


function DoSlaveMakerCreate3()
{
	SMData.CopySlaveMakerDetails(undefined, _root);
	SlaveMakerCreate3.SlaveMakerName.text = SMData.SlaveMakerName;
	Backgrounds.ShowIntroBackground(37, 80, 80, 0, 0, 0, 0);
	TitleScreen.BackButton.Show(10, 570);
	SMAvatar.ShowSlaveMaker(1, 8, 1);
	
	LoadAdvancedTabs();
	SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
	
	SlaveMakerCreate3.LName.htmlText = Language.GetHtml("Name");
	SlaveMakerCreate3.LAdvancedDetails.htmlText = Language.GetHtml("CreateSM3", "SlaveMaker", true);
	SlaveMakerCreate3.LDescription.htmlText = Language.GetHtml("CreateSM3Description", "SlaveMaker", true);
	SlaveMakerCreate3.PointsRemainingWhite.htmlText = Language.GetHtml("CreateSM3Points", "SlaveMaker", true);
	SlaveMakerCreate3.PointsRemainingBlack.htmlText = Language.GetHtml("CreateSM3Points", "SlaveMaker", true);

	SlaveMakerCreate3.StatisticsChange.Stat6.Limit.LText.htmlText = Language.GetHtml("Limited", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat7.Limit.LText.htmlText = Language.GetHtml("Limited", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat9.Limit.LText.htmlText = Language.GetHtml("Limited", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat8.Limit.LText.htmlText = Language.GetHtml("Limited", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat2.Limit.LText.htmlText = Language.GetHtml("Limited", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat5.StatLabel.htmlText = Language.GetHtml("Attack", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat5.BGStatLabel.htmlText = Language.GetHtml("Attack", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat6.StatLabel.htmlText = Language.GetHtml("Defence", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat6.BGStatLabel.htmlText = Language.GetHtml("Defence", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat10.StatLabel.htmlText = Language.GetHtml("Renown", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat10.BGStatLabel.htmlText = Language.GetHtml("Renown", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat11.StatLabel.htmlText = Language.GetHtml("Corruption", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat11.BGStatLabel.htmlText = Language.GetHtml("Corruption", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat8.StatLabel.htmlText = Language.GetHtml("Dominance", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat8.BGStatLabel.htmlText = Language.GetHtml("Dominance", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat2.StatLabel.htmlText = Language.GetHtml("Conversation", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat2.BGStatLabel.htmlText = Language.GetHtml("Conversation", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat4.StatLabel.htmlText = Language.GetHtml("Constitution", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat4.BGStatLabel.htmlText = Language.GetHtml("Constitution", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat9.StatLabel.htmlText = Language.GetHtml("Lust", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat9.BGStatLabel.htmlText = Language.GetHtml("Lust", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat1.StatLabel.htmlText = Language.GetHtml("Charisma", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat1.BGStatLabel.htmlText = Language.GetHtml("Charisma", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat3.StatLabel.htmlText = Language.GetHtml("Refinement", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat3.BGStatLabel.htmlText = Language.GetHtml("Refinement", "Statistics");	
	SlaveMakerCreate3.StatisticsChange.Stat7.StatLabel.htmlText = Language.GetHtml("Nymphomania", "Statistics");
	SlaveMakerCreate3.StatisticsChange.Stat7.BGStatLabel.htmlText = Language.GetHtml("Nymphomania", "Statistics");	
	
	SlaveMakerCreate3.Choices.invalidate();
	SlaveMakerCreate3._visible = true;
}

function PayCustomPoints(pts:Number) : Boolean
{
	if (pts == 0) return true;
	if (pts < 0) {
		SMData.SMCustomPoints -= pts;
		SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
		return true;
	} else {
		if (pts <= SMData.SMCustomPoints) {
			SMData.SMCustomPoints -= pts;
			SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
			return true;
		} else return false;
	}
}

function LoadAdvancedTabs()
{
	SlaveMakerCreate3.HomeTown._alpha = 30;
	SlaveMakerCreate3.SpecialEvent._alpha = 30;
	SlaveMakerCreate3.Advantages._alpha = 30;
	SlaveMakerCreate3.Skills._alpha = 30;
	SlaveMakerCreate3.InitialItems._alpha = 30;
	SlaveMakerCreate3.Statistics._alpha = 30;
	SlaveMakerCreate3.StatisticsChange._visible = SlaveNumber == 5;
	SlaveMakerCreate3.BGImage._visible = false;

	ClearGeneralArray();
	if (SlaveNumber == 0) LoadHomeTown();
	else if (SlaveNumber == 1) LoadSpecialEvent();
	else if (SlaveNumber == 2) LoadAdvantages();
	else if (SlaveNumber == 3) LoadSkills();
	else if (SlaveNumber == 4) LoadInitialItems();
	else if (SlaveNumber == 5) LoadStatistics();
	
	if (SlaveNumber != 5) {
		for (i = 0; i < arGeneralArray.length; i++) {
			var image:MovieClip = arGeneralArray[i];
			image.DisadvantageWhite._y = image.AdvantageWhite._y + image.AdvantageWhite._height + 2;
			image.DisadvantageBlack._y = image.AdvantageBlack._y + image.AdvantageBlack._height + 2;
		}
	}	
	SlaveMakerCreate3.Choices.invalidate();
}

// Home Town
// 0 = Coutry Town
// 1 = Old Faith Stronghold
// 2 = Amazon Tribe
// 3 = Mardukane
// 4 = Caravan
// 5 = Elven Forest
// 6 = Dark Elven Capital
// 7 = True Catgirl Tribe
function LoadHomeTown()
{
	SlaveMakerCreate3.LChoice.htmlText =  Language.GetHtml("CreateSM3HomeTownTitle", "SlaveMaker", true, -1);
	SlaveMakerCreate3.HomeTown._alpha = 100;
	SlaveMakerCreate3.BGImage.gotoAndStop(2);
	SlaveMakerCreate3.BGImage._visible = true;
	
	AddAdvanced(100);
	AddAdvanced(101);
	if (SMData.Gender == 3) AddAdvanced(102);
	else if (SMData.Gender == 2 && DickgirlOn == 0) AddAdvanced(102);
	else AddAdvanced(102);
	AddAdvanced(103);
	AddAdvanced(104);
	AddAdvanced(105);
	AddAdvanced(106);
	AddAdvanced(107);

	arGeneralArray[SMData.SMHomeTown].Tick._visible = true;
}

// Special Event
// 1 = Ex-Milk Slave
// 2 = Tentacle Hybrid
// 3 = Converted by Tentacles
// 4 = Ex-Cowgirl
// 5 = Demonic Cock
// 6 = Inhuman Ancestry
// 7 = Succubus
// 8 = Demon
function LoadSpecialEvent()
{
	SlaveMakerCreate3.LChoice.htmlText = Language.GetHtml("CreateSM3SpecialEventTitle", "SlaveMaker", true, -1);
	SlaveMakerCreate3.SpecialEvent._alpha = 100;
	SlaveMakerCreate3.BGImage.gotoAndStop(4);
	SlaveMakerCreate3.BGImage._visible = true;

	AddAdvanced(206);
	if (DickgirlOn == 1) {
		AddAdvanced(205, false, SMData.Gender == 3, Language.GetHtml("HermaphroditeOnly", "SlaveMaker/Qualities"));
		AddAdvanced(203, false, SMData.Gender == 3, Language.GetHtml("HermaphroditeOnly", "SlaveMaker/Qualities"));
		AddAdvanced(204, false, SMData.Gender == 3, Language.GetHtml("HermaphroditeOnly", "SlaveMaker/Qualities"));
	}
	if (TentaclesOn == 1) AddAdvanced(202, false, SMData.Gender != 2, Language.GetHtml("MaleOrHermaphroditeOnly", "SlaveMaker/Qualities"));
	AddAdvanced(201, false, SMData.Gender == 2, Language.GetHtml("FemaleOnly", "SlaveMaker/Qualities"));

	if (SMData.SMSpecialEvent != -1) {
		for (i = 0; i < arGeneralArray.length; i++) {
			if ((arGeneralArray[i].choice - 200) == SMData.SMSpecialEvent) {
				arGeneralArray[i].Tick._visible = true;
				break;
			}
		}
	}
}

// Advantages
// 0 = Minor Noble - ok
// 1 = Noble - ok
// 2 = Experienced Trader - ok
// 3 = Weapon Master - ok
// 4 = Sex Addict- ok
// 5 = Wealthy - ok
// 6 = Unnatural Cum - ok
// 7 = Pagan/Witch - ok
// 8 = Brothel Madam - ok
// 9 = Cruel Dominatrix/Master - ok
// 10 = Dominatrix/Master - ok
// 11 = Pony Expert - ok
// 12 = Catgirl
// 13 = Vampire
// 14 = Furry
// 15 = Secret Old Faith Worshipper
// 16 = Attractive to Tentacles
// 17 = Blunt
// 18 = Inept Warrior - ok
// 19 = Fangs & Claws - ok
// 20 = Chauvinist - ok
// 21 = Holy - ok
// 22 = Convincing - ok
// 23 = Ex-brothel slave
//      - -5 initial dominance
//      - +5 minimum lust
// 24 = Submissive
//      - -5 initial dominance
//      - Increased dominance penalty and decreased dominance gain.
// 25 = Masochist
//      + Can take more pain than most
//      - Lusts increases when in pain 
// 26 = Competitive
// 27 = Exhibitionist
// 28 = Mesmerism
// 29 = reserved for 

function LoadAdvantages()
{
	SlaveMakerCreate3.LChoice.htmlText = Language.GetHtml("CreateSM3AdvantagesTitle", "SlaveMaker", true, -1);
	SlaveMakerCreate3.Advantages._alpha = 100;
	SlaveMakerCreate3.BGImage.gotoAndStop(3);
	SlaveMakerCreate3.BGImage._visible = true;

	var amazonnoble:Boolean = SMData.SMHomeTown == 2 && ((SMData.Gender == 3) || (SMData.Gender == 2 && DickgirlOn == 0));
	AddAdvanced(0, true, !amazonnoble, Language.GetHtml("AlreadyNoble", "SlaveMaker/Qualities"));
	AddAdvanced(1, true, SMData.SMHomeTown == 3,  Language.GetHtml("MardukaneOnly", "SlaveMaker/Qualities"));
	AddAdvanced(2, true, SMData.SMSkills.CheckBitFlag(5) && (SMData.SMHomeTown == 4 || SMData.SMHomeTown == 7), Language.GetHtml("CaravanTC", "SlaveMaker/Qualities") + "\r" + Language.GetHtml("ExpertTrader", "Skills") + " 1");	
	AddAdvanced(3, true, !SMData.SMAdvantages.CheckBitFlag(18));

	AddAdvanced(4, true);
	AddAdvanced(5, true);

	if (DickgirlOn == 1) AddAdvanced(6, true, SMData.Gender == 3, Language.GetHtml("HermaphroditeOnly", "SlaveMaker/Qualities"));
	if (SMData.Gender == 1) AddAdvanced(7, true, SMData.SMFaith == 2 || SMData.SMHomeTown == 1 || SMData.SMHomeTown == 5, Language.GetHtml("OldFaithOnly", "SlaveMaker/Qualities"));
	else AddAdvanced(7, true, SMData.SMFaith == 2 && (SMData.SMHomeTown == 1 || SMData.SMHomeTown == 5), Language.GetHtml("OldFaithOnly", "SlaveMaker/Qualities"));

	AddAdvanced(8, true, SMData.Gender != 1, Language.GetHtml("FemaleOrHermaphroditeOnly", "SlaveMaker/Qualities"));
	AddAdvanced(23, true);
	
	AddAdvanced(9, false, !SMData.SMAdvantages.CheckBitFlag(24), Language.GetHtml("CannotBeSubmissive", "SlaveMaker/Qualities"));
	AddAdvanced(10, true, !SMData.SMAdvantages.CheckBitFlag(24), Language.GetHtml("CannotBeSubmissive", "SlaveMaker/Qualities"));

	AddAdvanced(12, false, SMData.SMHomeTown != 7 && SMData.Gender != 1, Language.GetHtml("FemaleOrHermaphroditeOnly", "SlaveMaker/Qualities") + "\r" + Language.GetHtml("NoTC", "SlaveMaker/Qualities"));
	if (TentaclesOn == 1) AddAdvanced(16, true, SMData.Gender != 1, Language.GetHtml("FemaleOrHermaphroditeOnly", "SlaveMaker/Qualities"));

	AddAdvanced(11, true, SMData.SMSkills.CheckBitFlag(6), Language.GetHtml("NeedPonyTrainer", "SlaveMaker/Qualities"));
	AddAdvanced(13, false, SMData.SMHomeTown < 5 && !SMData.SMAdvantages.CheckBitFlag(28), Language.GetHtml("NoElvesTC", "SlaveMaker/Qualities"));
	if (FurriesOn) AddAdvanced(14, false, SMData.SMHomeTown != 7, Language.GetHtml("NoTC", "SlaveMaker/Qualities"));
	AddAdvanced(15, false, SMData.SMFaith == 2, Language.GetHtml("OldFaithOnly", "SlaveMaker/Qualities"));
	AddAdvanced(17, true, !SMData.SMSkills.CheckBitFlag(2), Language.GetHtml("NoRefined", "SlaveMaker/Qualities"));
	AddAdvanced(18, true, !SMData.SMAdvantages.CheckBitFlag(3)); 
	AddAdvanced(19, true, SMData.SMHomeTown == 7 || SMData.SMAdvantages.CheckBitFlag(14) || SMData.SMAdvantages.CheckBitFlag(13), Language.GetHtml("VampireFurry", "SlaveMaker/Qualities")); 
	AddAdvanced(20, true, SMData.Gender == 1, Language.GetHtml("MaleOnly", "SlaveMaker/Qualities"));
	AddAdvanced(21, true, SMData.SMFaith != 3, Language.GetHtml("NoNoGods", "SlaveMaker/Qualities"));
	AddAdvanced(22, true);
	AddAdvanced(24, true, !SMData.SMAdvantages.CheckBitFlag(9) && !SMData.SMAdvantages.CheckBitFlag(10), Language.GetHtml("NoMistress", "SlaveMaker/Qualities"));
	AddAdvanced(25, false);
	AddAdvanced(26, false);
	AddAdvanced(27, false);
	AddAdvanced(28, false, !SMData.SMAdvantages.CheckBitFlag(13), Language.GetHtml("VampiresHaveThis", "SlaveMaker/Qualities"));
	
	for (i = 0; i < arGeneralArray.length; i++) arGeneralArray[i].Tick._visible = SMData.SMAdvantages.CheckBitFlag(arGeneralArray[i].choice);
}

// 0 = Slave Trainer 2
// 1 = Lesbian Trainer 1
// 2 = Refined 1
// 3 = Catgirl Trainer 1
// 4 = Alchemy 1
// 5 = Trader 1
// 6 = Pony Trainer 1
// 7 = Leadership 1
// 8 = Slut Trainer 1
// 9 = Gay Trainer 1
// 10 = Puppy Trainer 1
function LoadSkills()
{
	SlaveMakerCreate3.LChoice.htmlText = Language.GetHtml("CreateSM3SkillsTitle", "SlaveMaker", true, -1);
	SlaveMakerCreate3.Skills._alpha = 100;
	
	AddAdvanced(301);
	AddAdvanced(302);
	AddAdvanced(303, false, (SMData.SMHomeTown == 6 || SMData.SMHomeTown == 3) && !SMData.SMAdvantages.CheckBitFlag(17), Language.GetHtml("MardukaneOnly", "SlaveMaker/Qualities") + "\r" + Language.GetHtml("NoBlunt", "SlaveMaker/Qualities"));
	AddAdvanced(304, false, !SMData.SMAdvantages.CheckBitFlag(12), Language.GetHtml("NotNeededCatgirls", "SlaveMaker/Qualities"));
	AddAdvanced(305, false, !(SMData.SMAdvantages.CheckBitFlag(7) && SMData.Gender != 1), Language.GetHtml("WitchAlchemy", "SlaveMaker/Qualities"));
	AddAdvanced(306);
	if (Options.PonygirlsOn == 1) AddAdvanced(307);
	AddAdvanced(308);
	AddAdvanced(309, false, SMData.SMAdvantages.CheckBitFlag(4), Language.GetHtml("MustSexAddict", "SlaveMaker/Qualities"));
	AddAdvanced(310);
	AddAdvanced(311);
	
	for (i = 0; i < arGeneralArray.length; i++) arGeneralArray[i].Tick._visible = SMData.SMSkills.CheckBitFlag(arGeneralArray[i].choice - 301);
}

// 0 = Sex Items, all slaves
// 1 = Ponygirl items, first slave
// 2 = Ponygirl items, all slaves
// 3 = catgirl items, first slave
// 4 = catgirl items, all slaves
// 5 = 1 dress
// 6 = sword
// 7 = leash
// 8 = 300GP per slave
// 9 = whip
// 10 = leather armour
// 11 = puppygirl items, first slave
// 12 = puppygirl items, all slaves

function LoadInitialItems()
{
	SlaveMakerCreate3.LChoice.htmlText = Language.GetHtml("CreateSM3InitialItemsTitle", "SlaveMaker", true, -1);
	SlaveMakerCreate3.InitialItems._alpha = 100;
	SlaveMakerCreate3.BGImage.gotoAndStop(1);
	SlaveMakerCreate3.BGImage._visible = true;
	
	AddAdvanced(-1, true);
	if (Options.PonygirlsOn == 1) {
		AddAdvanced(-2, true);
		AddAdvanced(-3, true);
	}
	AddAdvanced(-4, true);
	AddAdvanced(-5, true);
	AddAdvanced(-6, true);
	AddAdvanced(-7, true);
	AddAdvanced(-8, true);
	AddAdvanced(-9, true);
	AddAdvanced(-10, true);
	AddAdvanced(-11, true);
	AddAdvanced(-12, true);
	AddAdvanced(-13, true);

	for (i = 0; i < arGeneralArray.length; i++) arGeneralArray[i].Tick._visible = SMData.SMInitialItems.CheckBitFlag((arGeneralArray[i].choice * -1) - 1);

}

function LoadStatistics()
{
	SlaveMakerCreate3.LChoice.htmlText = Language.GetHtml("CreateSM3StatisticsTitle", "SlaveMaker", true, -1);
	SlaveMakerCreate3.Statistics._alpha = 100;
	
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat1, 1, SMData.SMCharisma, 1, 8, 45);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat2, 2, SMData.SMConversation, 1, 0, 25);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat3, 3, SMData.SMRefinement, 1, 9, 40);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat4, 4, SMData.SMConstitution, 1, 1, 40);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat5, 6, SMData.SMAttack, 2, 3, 30);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat6, 7, SMData.SMDefence, 2, 4, 30);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat7, 11, SMData.SMNymphomania, 0.5, 10, 10, 20);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat8, 9, SMData.SMDominance, 1, 7, 50);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat9, 8, SMData.SMLust, 1, 5, 30);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat10, 5, SMData.SMReputation, 10, 2, 10);
	SetStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat11, 10, SMData.Corruption, 1, 6, 0);
}

SlaveMakerCreate3.Statistics.tabChildren = true;


SlaveMakerCreate3.HomeTown.onPress = function() {
	Beep();
	SlaveNumber = 0;
	LoadAdvancedTabs();
}
	
SlaveMakerCreate3.SpecialEvent.onPress = function() {
	Beep();
	SlaveNumber = 1;
	LoadAdvancedTabs();
}

SlaveMakerCreate3.Advantages.onPress = function() {
	Beep();
	SlaveNumber = 2;
	LoadAdvancedTabs();
}

SlaveMakerCreate3.Skills.onPress = function() {
	Beep();
	SlaveNumber = 3;
	LoadAdvancedTabs();
}

SlaveMakerCreate3.InitialItems.onPress = function() {
	Beep();
	SlaveNumber = 4;
	LoadAdvancedTabs();
}

SlaveMakerCreate3.Statistics.onPress = function() {
	Beep();
	SlaveNumber = 5;
	LoadAdvancedTabs();
}

function SelectChoice(choice:Number, idx:Number) {
	Beep();
	if (choice == undefined) choice = this._parent.choice;
	if (idx == undefined) idx = this._parent.idx;
	if (!arGeneralArray[idx].Btn._visible) return;
	if (SlaveNumber == 0) {
		// Home Town
		choice -= 100;
		if ((arGeneralArray[idx].cost - arGeneralArray[SMData.SMHomeTown].cost) <= SMData.SMCustomPoints) {
			SMData.SMCustomPoints += arGeneralArray[SMData.SMHomeTown].cost;
			arGeneralArray[SMData.SMHomeTown].Tick._visible = false;
			SMData.UpdateHomeTown(choice);
			arGeneralArray[SMData.SMHomeTown].Tick._visible = true;
			SMData.SMCustomPoints -= arGeneralArray[SMData.SMHomeTown].cost;
			if (choice != 3) {
				if (SMData.SMAdvantages.CheckBitFlag(1)) {
					SMData.SMAdvantages.ClearBitFlag(1);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(1);
				}
				if (choice != 6) {
					if (SMData.SMSkills.CheckBitFlag(2)) {
						SMData.SMSkills.ClearBitFlag(2);
						SMData.SMCustomPoints += SMData.GetSMQualitiesCost(303);
					}
				}
			} else if (choice != 6) {
				if (SMData.SMAdvantages.CheckBitFlag(9)) {
					SMData.SMAdvantages.ClearBitFlag(9);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(9);
				} 
			}
			if (choice != 4 && choice != 7) {
				if (SMData.SMAdvantages.CheckBitFlag(2)) {
					SMData.SMAdvantages.ClearBitFlag(2);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(2);
				}
			}
			if (choice != 1 && choice != 5) {
				if (SMData.SMAdvantages.CheckBitFlag(7)) {
					SMData.SMAdvantages.ClearBitFlag(7);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(7);
				}
			}
			if (choice == 2) {
				var amazonnoble:Boolean = (SMData.Gender == 3) || (SMData.Gender == 2 && DickgirlOn == 0);
				if (amazonnoble && SMData.SMAdvantages.CheckBitFlag(0)) {
					SMData.SMAdvantages.ClearBitFlag(0);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(0);
				}
			}
			if (choice == 7) {
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					SMData.SMAdvantages.ClearBitFlag(14);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(14);
				}
				if (SMData.SMAdvantages.CheckBitFlag(12)) {
					SMData.SMAdvantages.ClearBitFlag(12);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(12);
				}
			} else if (!SMData.SMAdvantages.CheckBitFlag(13) && !SMData.SMAdvantages.CheckBitFlag(14)) {
				if (SMData.SMAdvantages.CheckBitFlag(19)) {
					SMData.SMAdvantages.ClearBitFlag(19);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(19);
				}
			}
			SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
			LoadAdvancedTabs();
		} else Bloop();
		SMAvatar.ShowSlaveMaker(1, 8, 1);
		return;
	} else 	if (SlaveNumber == 1) {
		// Special Event
		choice -= 200;
		var idxspc:Number = -1;
		for (i = 0; i < arGeneralArray.length; i++) {
			if ((arGeneralArray[i].choice - 200) == SMData.SMSpecialEvent) {
				idxspc = arGeneralArray[i].idx;
				break;
			}
		}
		if (arGeneralArray[idx].Tick._visible) {
			SMData.SMCustomPoints += arGeneralArray[idx].cost;
			arGeneralArray[idx].Tick._visible = false;
			SMData.SMSpecialEvent = -1;
			SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
		} else {
			var costcur:Number = 0;
			if (idxspc != -1) costcur = arGeneralArray[idxspc].cost;
			if ((arGeneralArray[idx].cost - costcur) <= SMData.SMCustomPoints) {
				if (idxspc != -1) {
					SMData.SMCustomPoints += arGeneralArray[idxspc].cost;
					arGeneralArray[idxspc].Tick._visible = false;
				}
				SMData.SMSpecialEvent = choice;
				arGeneralArray[idx].Tick._visible = true;
				SMData.SMCustomPoints -= arGeneralArray[idx].cost;
				SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
			} else Bloop();
		}
		SMAvatar.ShowSlaveMaker(1, 8, 1);
		return;
	} else 	if (SlaveNumber == 2) {
		// Advantages/Disadvantages
		if (arGeneralArray[idx].Tick._visible) {
			if (arGeneralArray[idx].cost < 0 && SMData.SMCustomPoints < Math.abs(arGeneralArray[idx].cost)) {
				Bloop();
				Hints.ShowHint(Language.GetHtml("NotEnoughCustomPoints", "SlaveMaker/Qualities"));
				return;
			}
			SMData.SMCustomPoints += arGeneralArray[idx].cost;
			arGeneralArray[idx].Tick._visible = false;
			SMData.SMAdvantages.ClearBitFlag(choice);
			if (choice == 4) {
				if (SMData.SMSkills.CheckBitFlag(8)) {
					SMData.SMSkills.ClearBitFlag(8);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(309);
				}
			} else if (choice == 13 || choice == 14) {
				if (SMData.SMAdvantages.CheckBitFlag(19)) {
					SMData.SMAdvantages.ClearBitFlag(19);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(19);
				}
				if (SMData.SMAdvantages.CheckBitFlag(28)) {
					SMData.SMAdvantages.ClearBitFlag(29);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(28);
				}				
			}
			SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
			LoadAdvancedTabs();
		} else {
			var costcur:Number = arGeneralArray[idx].cost;
			var oldidx:Number = -1;
			var oldidx2:Number = -1;
			var oldchc:Number = -1;
			var oldchc2:Number = -1;
			
				// exclusive 12, 14
			if (choice == 12 || choice == 14) {
				if (SMData.SMAdvantages.CheckBitFlag(12)) oldchc = 12;
				if (SMData.SMAdvantages.CheckBitFlag(14)) oldchc = 14;
			}
			// exclusive 13, 14
			if (choice == 13 || choice == 14) {
				if (SMData.SMAdvantages.CheckBitFlag(13)) oldchc2 = 13;
				if (SMData.SMAdvantages.CheckBitFlag(14)) oldchc = 14;
			}
			// exclusive 24, 9/10
			if (choice == 22 && SMData.SMAdvantages.CheckBitFlag(17)) oldchc = 17;
			if (choice == 17 && SMData.SMAdvantages.CheckBitFlag(22)) oldchc = 22;
			if (choice == 0 && SMData.SMAdvantages.CheckBitFlag(1)) oldchc = 1;
			if (choice == 1 && SMData.SMAdvantages.CheckBitFlag(0)) oldchc = 0;
			if (choice == 9 && SMData.SMAdvantages.CheckBitFlag(10)) oldchc = 10;
			if (choice == 10 && SMData.SMAdvantages.CheckBitFlag(9)) oldchc = 9;
			if (choice == 8 && SMData.SMAdvantages.CheckBitFlag(23)) oldchc = 23;
			if (choice == 23 && SMData.SMAdvantages.CheckBitFlag(8)) oldchc = 8;
						
			if (oldchc != -1 || oldchc2 != -1) {
				for (i = 0; i < arGeneralArray.length; i++) {
					if (arGeneralArray[i].choice == oldchc) oldidx = i;
					if (arGeneralArray[i].choice == oldchc2) oldidx2 = i;
				}
				if (oldidx != -1) costcur -= arGeneralArray[oldidx].cost;
				if (oldidx2 != -1) costcur -= arGeneralArray[oldidx2].cost;
			}
			if (costcur <= SMData.SMCustomPoints) {
				SMData.SMAdvantages.SetBitFlag(choice);
				arGeneralArray[idx].Tick._visible = true;
				SMData.SMCustomPoints -= costcur;
				if (oldidx != -1) {
					SMData.SMAdvantages.ClearBitFlag(oldchc);
					arGeneralArray[oldidx].Tick._visible = false;
				}
				if (oldidx2 != -1) {
					SMData.SMAdvantages.ClearBitFlag(oldchc2);
					arGeneralArray[oldidx2].Tick._visible = false;
				}
				if (choice == 12) {
					if (SMData.SMSkills.CheckBitFlag(3)) {
						SMData.SMSkills.ClearBitFlag(3);
						SMData.SMCustomPoints += SMData.GetSMQualitiesCost(304);
					}
				} else if (choice == 17) {
					if (SMData.SMSkills.CheckBitFlag(2)) {
						SMData.SMSkills.ClearBitFlag(2);
						SMData.SMCustomPoints += SMData.GetSMQualitiesCost(303);
					}
				}
				SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
				LoadAdvancedTabs();
			} else Bloop();
		}
		SMAvatar.ShowSlaveMaker(1, 8, 1);
		return;
	} else 	if (SlaveNumber == 3) {
		// skills
		choice -= 301;
		if (arGeneralArray[idx].Tick._visible) {
			SMData.SMCustomPoints += arGeneralArray[idx].cost;
			arGeneralArray[idx].Tick._visible = false;
			SMData.SMSkills.ClearBitFlag(choice);
			if (choice == 5) {
				if (SMData.SMAdvantages.CheckBitFlag(2)) {
					SMData.SMAdvantages.ClearBitFlag(2);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(2);
				}
			} else 	if (choice == 6) {
				if (SMData.SMAdvantages.CheckBitFlag(11)) {
					SMData.SMAdvantages.ClearBitFlag(11);
					SMData.SMCustomPoints += SMData.GetSMQualitiesCost(11);
				}
			}
			SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
			LoadAdvancedTabs();
		} else {
			var costcur:Number = arGeneralArray[idx].cost;
			if (costcur <= SMData.SMCustomPoints) {
				SMData.SMSkills.SetBitFlag(choice);
				arGeneralArray[idx].Tick._visible = true;
				SMData.SMCustomPoints -= costcur;
				SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
				LoadAdvancedTabs();
			} else Bloop();
		}
		SMAvatar.ShowSlaveMaker(1, 8, 1);
		return;
	} else 	if (SlaveNumber == 4) {
		// items
		choice = (choice * -1) - 1;
		if (arGeneralArray[idx].Tick._visible) {
			SMData.SMCustomPoints += arGeneralArray[idx].cost;
			arGeneralArray[idx].Tick._visible = false;
			SMData.SMInitialItems.ClearBitFlag(choice);
			SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
		} else {
			var costcur:Number = arGeneralArray[idx].cost;
			var oldidx:Number = -1;
			var oldchc:Number = -1;
			if (choice == 1 && SMData.SMInitialItems.CheckBitFlag(2)) oldchc = 2;
			if (choice == 2 && SMData.SMInitialItems.CheckBitFlag(1)) oldchc = 1;
			if (choice == 3 && SMData.SMInitialItems.CheckBitFlag(4)) oldchc = 4;
			if (choice == 4 && SMData.SMInitialItems.CheckBitFlag(3)) oldchc = 3;
			if (oldchc != -1) {
				for (i = 0; i < arGeneralArray.length; i++) {
					if (((arGeneralArray[i].choice * -1) -1) == oldchc) {
						oldidx = i;
						break;
					}
				}
				costcur -= arGeneralArray[oldidx].cost;
			}
			if (costcur <= SMData.SMCustomPoints) {
				SMData.SMInitialItems.SetBitFlag(choice);
				arGeneralArray[idx].Tick._visible = true;
				if (oldidx != -1) {
					arGeneralArray[oldidx].Tick._visible = false;
					SMData.SMInitialItems.ClearBitFlag(oldchc);
				}
				SMData.SMCustomPoints -= costcur;
				SlaveMakerCreate3.PointsRemainingValue.text = SMData.SMCustomPoints;
			} else Bloop();
		}
		SMAvatar.ShowSlaveMaker(1, 8, 1);
		return;
	}
}

function SM3IncreaseStat(stat:Number)
{
	Beep();
	if (stat == undefined) stat = this._parent.stat;
	var cost:Number = this._parent.cost;
	switch(stat) {
		case 1:
			if (SMData.SMCharisma < 80 && PayCustomPoints(cost)) {
				SMData.SMCharisma++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat1, SMData.SMCharisma);
			}
			break;
		case 2:
			if (SMData.SMConversation < 80 && PayCustomPoints(cost)) {
				SMData.SMConversation++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat2, SMData.SMConversation);
			}
			break;
		case 3:
			if (SMData.SMRefinement < 80 && PayCustomPoints(cost)) {
				SMData.SMRefinement++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat3, SMData.SMRefinement);
			}
			break;
		case 4:
			if (SMData.SMConstitution < 80 && PayCustomPoints(cost)) {
				SMData.SMConstitution++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat4, SMData.SMConstitution);
			}
			break;
		case 5:
			if (SMData.SMReputation < 80 && PayCustomPoints(cost)) {
				SMData.SMReputation++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat10, SMData.SMReputation);
			}
			break;
		case 6:
			if (SMData.SMAttack < 80 && PayCustomPoints(cost)) {
				SMData.SMAttack++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat5, SMData.SMAttack);
			}
			break;
		case 7:
			if (SMData.SMDefence < 80 && PayCustomPoints(cost)) {
				SMData.SMDefence++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat6, SMData.SMDefence);
			}
			break;
		case 8:
			if (SMData.SMLust < 80 && PayCustomPoints(cost)) {
				SMData.SMLust++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat9, SMData.SMLust);
			}
			break;
		case 9:
			if (SMData.SMDominance < 80 && PayCustomPoints(cost)) {
				SMData.SMDominance++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat8, SMData.SMDominance);
			}
			break;
		case 10:
			if (SMData.Corruption < 50 && PayCustomPoints(cost)) {
				SMData.Corruption++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat11, SMData.Corruption);
			}
			break;
		case 11:
			if (SMData.SMNymphomania < 20 && PayCustomPoints(cost)) {
				SMData.SMNymphomania++;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat7, SMData.SMNymphomania);
			}
			break;

	}
}

function SM3DecreaseStat(stat:Number)
{
	Beep();
	if (stat == undefined) stat = this._parent.stat;
	var cost:Number = this._parent.cost;

	switch(stat) {
		case 1:
			if (SMData.SMCharisma > 45 && PayCustomPoints(-1 * cost)) {
				SMData.SMCharisma--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat1, SMData.SMCharisma);
			}
			break;
		case 2:
			if (SMData.SMConversation > 25 && PayCustomPoints(-1 * cost)) {
				SMData.SMConversation--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat2, SMData.SMConversation);
			}
			break;
		case 3:
			if (SMData.SMRefinement > 40 && PayCustomPoints(-1 * cost)) {
				SMData.SMRefinement--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat3, SMData.SMRefinement);
			}
			break;
		case 4:
			if (SMData.SMConstitution > 40 && PayCustomPoints(-1 * cost)) {
				SMData.SMConstitution--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat4, SMData.SMConstitution);
			}
			break;
		case 5:
			if (SMData.SMReputation > 10 && PayCustomPoints(-1 * cost)) {
				SMData.SMReputation--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat10, SMData.SMReputation);
			}
			break;
		case 6:
			if (SMData.SMAttack > 30 && PayCustomPoints(-1 * cost)) {
				SMData.SMAttack--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat5, SMData.SMAttack);
			}
			break;
		case 7:
			if (SMData.SMDefence > 30 && PayCustomPoints(-1 * cost)) {
				SMData.SMDefence--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat6, SMData.SMDefence);
			}
			break;
		case 8:
			if (SMData.SMLust > 30 && PayCustomPoints(-1 * cost)) {
				SMData.SMLust--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat9, SMData.SMLust);
			}
			break;
		case 9:
			if (SMData.SMDominance > 50 && PayCustomPoints(-1 * cost)) {
				SMData.SMDominance--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat8, SMData.SMDominance);
			}
			break;
		case 10:
			if (SMData.Corruption > 0 && PayCustomPoints(-1 * cost)) {
				SMData.Corruption--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat11, SMData.Corruption);
			}
			break;
		case 11:
			if (SMData.SMNymphomania > 10 && PayCustomPoints(-1 * cost)) {
				SMData.SMNymphomania--;
				UpdateStatisticChanger(SlaveMakerCreate3.StatisticsChange.Stat7, SMData.SMNymphomania);
			}
			break;
				
	}
}

function SetStatisticChanger(mc:MovieClip, stat:Number, val:Number, cost:Number, hintno:Number, min:Number, max:Number, limit:Number)
{
	if (limit == undefined) limit = 1000;
	if (min == undefined) min = 0;
	if (max == undefined) max = 80;
	
	mc.PlusBtn.onPress = SM3IncreaseStat;
	mc.MinusBtn.onPress = SM3DecreaseStat;
	mc.stat = stat;
	mc.cost = cost;
	mc.Hint.currStat = hintno;
	mc.tabChildren = true;
	mc.min = min;
	mc.max = max;
	mc.limit = limit;
	mc.Hint.onRollOver = function() { dspMain.ShowSlaveMakerStatHint(this.currStat); }
	mc.Hint.onRollOut = function() { Hints.HideHints(); };
	mc.PlusBtn.onRollOut = function() { Hints.HideHints(); };
	mc.PlusBtn.onRollOver = function() { Hints.ShowHint("Costs " + this._parent.cost); };
	mc.MinusBtn.onRollOver = function() { Hints.ShowHint("Returns " + this._parent.cost); };
	mc.MinusBtn.onRollOut = function() { Hints.HideHints(); };
	
	UpdateStatisticChanger(mc, val);
}

function UpdateStatisticChanger(mc:MovieClip, val:Number)
{
	mc.StatValue.text = val;
	mc.Limit._visible = val >= mc.limit;
	mc.Bar._width = val;
	mc.BarMinimum._width = mc.min;
	
	mc.MinusBtn.enabled = val > mc.min;
	if (val > mc.min) SetMovieColour(mc.MinusBtn, 0, 0, 0);
	else SetMovieColour(mc.MinusBtn, -75, -75, -75);
	
	mc.PlusBtn.enabled = val < mc.max;
	if (val < mc.max) SetMovieColour(mc.PlusBtn, 0, 0, 0);
	else SetMovieColour(mc.PlusBtn, -75, -75, -75);	
}

SlaveMakerCreate3.DoneBtn.Btn.onPress = function() {
	ClearGeneralArray();
	SMData.SlaveMakerName = SlaveMakerCreate3.SlaveMakerName.text;
	SMMoney(SMData.SMCustomPoints * 3, true);
	SMData.CopySlaveMakerDetails(undefined, _root);	
	SMAvatar.ShowSlaveMaker();
	SMAppearance._visible = false;
	TitleScreen.DoIntroNext(5.3);
}


function SlaveMakerCreate3Shortcuts(keyAscii:Number, key:Number)
{
	if (key == 38) SlaveMakerCreate1.AppearanceMinus.onPress();
	else if (key == 40) SlaveMakerCreate1.AppearancePlus.onPress(); 
	else {
		if (keyAscii > 48 && keyAscii < 59) {
			if (keyAscii < (49 + arGeneralArray.length)) SelectChoice(arGeneralArray[keyAscii - 49].choice, arGeneralArray[keyAscii - 49].idx);
		} else  if (keyAscii > 64 && keyAscii < 91) {
			if (keyAscii < (56 + arGeneralArray.length)) SelectChoice(arGeneralArray[keyAscii - 56].choice, arGeneralArray[keyAscii - 56].idx);
		}
	}
}

SlaveMakerCreate3.BGImage.gotoAndStop(1);
