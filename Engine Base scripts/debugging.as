import Scripts.Classes.*;

var SlaveDebugging:Boolean = false;

function ShowDebugging()
{
	if (Plannings.IsStarted()) {
		Bloop();
		return;
	}
	Beep();
	if (Quitter._visible) DoLeaveButton();
	dspMain.HideGameTabsContents();
	HideEquipmentButton();
	HideSMEquipmentButton();
	DebuggingMenu.tabChildren = true;
	
	DebuggingMenu.DBSMGender.onChanged = function()
	{
		if (DebuggingMenu.DBSMGender.text != "") ChangeSlaveMakerGender(Number(DebuggingMenu.DBSMGender.text));
	}
	
	DebuggingMenu.DBGender.onChanged = function()
	{
		if (DebuggingMenu.DBGender.text != "") {
			ChangeSlaveGender(Number(DebuggingMenu.DBGender.text));
			DebugDress();
		}
	}
	
	DebuggingMenu.DBXF.onChanged = function()
	{
		if (DebuggingMenu.DBXF.text != "") {
			DickgirlTransform(Number(DebuggingMenu.DBXF.text));
			DebugDress();
		}
	}
	
	DebuggingMenu.DBPonygirl.onChanged = function()
	{
		DonePonygirl = Number(DebuggingMenu.DBPonygirl.text);
		UpdateSlave();
	}
	
	DebuggingMenu.DBCatgirl.onChanged = function()
	{
		var val:Number = Number(DebuggingMenu.DBCatgirl.text);
		if (val == 0 || val == 1) {
			if (val == 1) BitFlag1.SetBitFlag(15);
			else BitFlag1.ClearBitFlag(15);
			UpdateSlave();
			DebugDress();
		}
	}
	DebuggingMenu.DBPuppygirl.onChanged = function()
	{
		var val:Number = Number(DebuggingMenu.DBPuppygirl.text);
		if (val == 0 || val == 1) {
			if (val == 1) BitFlag1.SetBitFlag(58);
			else BitFlag1.ClearBitFlag(58);
			UpdateSlave();
			DebugDress();
		}
	}	
	
	DebuggingMenu.DBDevil.onChanged = function()
	{
		var val:Number = Number(DebuggingMenu.DBDevil.text);
		if (val == 0 || val == 1) {
			if (val == 1) {
				BitFlag1.SetBitFlag(46);
				BitFlag1.SetBitFlag(50);
			} else {
				BitFlag1.ClearBitFlag(46);
				BitFlag1.ClearBitFlag(50);
			}
			UpdateSlave();
			DebugDress();
		}
	}
	
	DebuggingMenu.DBDress.onChanged = function()
	{
		if (DebuggingMenu.DBDress.text != "" && DebuggingMenu.DBDress.text != "-") {
			DressFrame = 0;
			RemoveDress();
			WearDress(Number(DebuggingMenu.DBDress.text));
			DebugDress();
			DressWorn = Number(DebuggingMenu.DBDress.text);		// to handle some special cases
		}
	}
	
	DebuggingMenu.DressLeft.onPress = function()
	{
		var ds:Number = DressWorn;
		RemoveDress();
		ds--;
		if (ds < 0) ds = 6;
		DebuggingMenu.DBDress.text = ds;
		WearDress(ds);
		DebugDress();
		DebuggingMenu._visible = true;
	}
	
	DebuggingMenu.DressRight.onPress = function()
	{
		var ds:Number = DressWorn;
		RemoveDress();
		ds++;
		if (ds > 6) ds = 0;
		DebuggingMenu.DBDress.text = ds;
		WearDress(ds);
		DebugDress();
		DebuggingMenu._visible = true;
	}
	
	DebuggingMenu.DressNaked.Btn.onPress = function()
	{
		RemoveDress();
		DressWorn = -1;
		DebuggingMenu.DBDress.text = DressWorn;
		WearDress(DressWorn);
		UpdateSlave();
		DebugDress();
	}
	
	DebuggingMenu.DBDressFrame.onChanged = function()
	{
		if (DebuggingMenu.DBDressFrame.text != "") {
			if (DressWorn == -1) {
				var nc:Number = Number(DebuggingMenu.DBDressFrame.text);
				if (nc != undefined) {
					NakedChoice = nc;
					slaveData.NakedChoice = nc;
				}
			} else {
				DressFrame = Number(DebuggingMenu.DBDressFrame.text);
			}
			DebugDress();
		}
	}
	
	DebuggingMenu.FrameLeft.onPress = function()
	{
		if (DressWorn == -1) {
			NakedChoice--;
			slaveData.NakedChoice--;
			if (NakedChoice < 0) {
				NakedChoice = 0;
				slaveData.NakedChoice = 0;
			}
			DebuggingMenu.DBDressFrame.text = NakedChoice;
		} else {
			DressFrame--;
			if (DressFrame < 1) DressFrame = 1;
		}
		DebugDress();
	}
	
	DebuggingMenu.FrameRight.onPress = function()
	{
		if (DressWorn == -1) {
			NakedChoice++;
			slaveData.NakedChoice++;
			DebuggingMenu.DBDressFrame.text = NakedChoice;
		} else {
			DressFrame++;
		}
		DebugDress();
	}
	
	DebuggingMenu.DBFairy.onChanged = function()
	{
		FairyXF = Number(DebuggingMenu.DBFairy.text);
		UpdateSlave();
		DebugDress();
	}
	
	DebuggingMenu.ClearItems.Btn.onPress = function() {
		DebuggingMenu.DBItem.text = "0";
		DebugChangeItem();
		Selection.setFocus(DebuggingMenu.DBItem);
	}
	DebuggingMenu.LoadItems.Btn.onPress = function() {
		DebuggingMenu.DBItem.text = "3";
		HarnessOK = 1;
		NymphsTiaraOK = 1;
		EquipItem(8);
		PonyTailOK = 1;
		EquipItem(1);
		DemonicBraOK = 1;
		HaloOK = 1;
		BitGagOK = 1;
		EquipItem(14);
		EquipItem(2);
		LeashOK = 1;
		CatEarsOK = 1;
		CatTailOK = 1;
		CatEarsWorn = 1;
		slaveData.ItemsOwned.SetBitFlag(29);
		slaveData.ItemsWorn.SetBitFlag(29);
		slaveData.ItemsOwned.SetBitFlag(30);
		slaveData.ItemsWorn.SetBitFlag(30);		
		EquipItem(7);
		if (!BitFlag1.CheckBitFlag(50)) FairyXF = 50;
		SpikedBraceletOK = 1;
		PlugInserted = 1;
		SetDressOwned(1);
		SetDressOwned(2);
		SetDressOwned(3);
		SetDressOwned(4);
		SetDressOwned(5);
		SetDressOwned(6);
		DebugChangeItem();
		Selection.setFocus(DebuggingMenu.DBItem);
		DebugDress();
	}
	DebuggingMenu.ItemPlus.onPress = function() {
		var num:Number = Number(DebuggingMenu.DBItem.text);
		if (num == undefined || num == NaN) num = 0;
		num++;
		if (num > 17) num = 1;
		DebuggingMenu.DBItem.text = num + "";
		DebugSetItemDetails();
		Selection.setFocus(DebuggingMenu.DBItem);
	}
	DebuggingMenu.ItemMinus.onPress = function() {
		var num:Number = Number(DebuggingMenu.DBItem.text);
		if (num == undefined || num == NaN) num = 18;
		num--;
		if (num < 0) num = 17;
		DebuggingMenu.DBItem.text = num + "";
		DebugSetItemDetails();
		Selection.setFocus(DebuggingMenu.DBItem);
	}
	DebuggingMenu.FramePlus.onPress = function() {
		if (DebuggingMenu.DBFrame.text == "N/A") return;
		var num:Number = Number(DebuggingMenu.DBFrame.text);
		if (num == undefined || num == NaN) num = 0;
		num++;
		DebuggingMenu.DBFrame.text = num + "";
		DebugChangeItem();
	}
	DebuggingMenu.FrameMinus.onPress = function() {
		if (DebuggingMenu.DBFrame.text == "N/A") return;
		var num:Number = Number(DebuggingMenu.DBFrame.text);
		if (num == undefined || num == NaN) num = 2;
		num--;
		if (num < 0) num = 1;
		DebuggingMenu.DBFrame.text = num + "";
		DebugChangeItem();
	}
	
	DebuggingMenu.EvalBtn.Btn.onPress = function() {
		if (DebuggingMenu.DBPosition.text.charAt(0) == "<") {
			// xml
			var xData:XML = new XML;
			xData.parseXML(DebuggingMenu.DBPosition.text);
			XMLEventByNode(xData, true, undefined, true);
			DebuggingMenu.DBPosition.text = XMLData.EventText;
			XMLData.EventText = "";
			return;
		}
		if (DebuggingMenu.DBPosition.text.charAt(0) == "=") {
			// xml conditional
			if (XMLData.ParseConditionalString(DebuggingMenu.DBPosition.text.substr(1), true, false)) DebuggingMenu.DBPosition.text = "True";
			else DebuggingMenu.DBPosition.text = "False";
			return;
		}
		
		if (DebuggingMenu.DBPosition.text.charAt(0) == "?") {
			// get value
			var str:String = Language.StripLines(DebuggingMenu.DBPosition.text).substr(1);
			var val:Object;
			if (str.substr(0, 4) == "flag") val = XMLData.ParseGetFlags(str);
			else val = GetStatSkill(str);
			if (val == undefined) DebuggingMenu.DBPosition.text = str + "=" + eval(str);
			else if (typeof(val) == "number") DebuggingMenu.DBPosition.text = str + "=" + String(Number(val));
			else DebuggingMenu.DBPosition.text = str + "=" + String(val);
			return;
		}
		
		// set value
		var ln:Array = StripLines(DebuggingMenu.DBPosition.text).split("=");
		var var1:String = Langauge.strTrim(ln[0]);
		var var2:String = Langauge.strTrim(ln[1]).split("'").join("").split('"').join("");
		
		if (var1.substr(0, 4) == "flag") {
			SetSingleFlag(var1, undefined, var2);
			UpdateSlave();
			return;
		}
		
		if (var2 == "true") var2 = "1";
		else if (var2 == "false") var2 = "0";
		
		if (!isNaN(var2)) {
			// numeric type rparam
			if (SetStatSkill(var1, Number(var2), var2) == undefined) {
				if (_root[var1] != undefined) _root[var1] = Number(var2);
			}
		} else {
			// non-numeric
			if (SetStatSkill(var1, 0, var2) == undefined) {
				if (_root[var1] != undefined) _root[var1] = var2;
			}
		}
		UpdateSlave();
	}
	
	DebuggingMenu.DateBtn.Btn.onPress = function() {
		ChangeDate(1);
	}
	DebuggingMenu.TimeBtn.Btn.onPress = function() {
		AddTime(1);
	}
	DebuggingMenu.BEBtn.Btn.onPress = function() {
		ChangeBustSize(1.2);
		ChangeClitCockSize(1.2);
		DebugDress();
	}
	DebuggingMenu.LOGBtn.Btn.onPress = function() {
		dspMain.ShowStatisticsTab(5);
		ShowLargerText();
		LargerTextField.content.LargerTextField.selectable = true;
		AddText(strLOG);
	}	
	DebuggingMenu.ClearBtn.Btn.onPress = function() {
		DebuggingMenu.DBPosition.text = "";
	}		
	DebuggingMenu.ResetBtn.Btn.onPress = function() {
		currentCity.StartNewSlave();
		LadyFarun.ResetBitFlags();
	}
	DebuggingMenu.LoveBtn.Btn.onPress = function() {
		dspMain.ShowStatisticsTab(5);
		ShowLargerText();
		LargerTextField.content.LargerTextField.selectable = true;
		DebugLoveDetails();
	}	

	DebuggingMenu.SlaveToggle.Btn.onPress = function() {
		if (DebuggingMenu.SlaveToggle.LText.text == "Slave1") SetSlave2Items();
		else SetSlave1Items();
			
		if (DressHalo == ItemsOver1.DressHalo) DebuggingMenu.SlaveToggle.LText.text = "Slave1";
		else DebuggingMenu.SlaveToggle.LText.text = "Slave2";

		DebugDress();
	}
	

	DebuggingMenu.mc_colourPicker._visible = false;
	DebuggingMenu.mc_colourPicker.colours.onPress = function() {
		var srcMC:MovieClip = DebuggingMenu.mc_colourPicker.colours;
		var colourBitmap:BitmapData = new BitmapData(srcMC._width, srcMC._height, true, 0x00000000);
		colourBitmap.draw(srcMC);
		var colourValue:Number = Number("0x"+colourBitmap.getPixel(srcMC._xmouse, srcMC._ymouse).toString(16));
		colourBitmap.dispose();
		var mycolour:Color = new Color(DebuggingMenu.DBTint);
		mycolour.setRGB(colourValue);
		DebuggingMenu.mc_colourPicker._visible = false;
		DebuggingMenu.DBPosition._visible = true;
		DebugChangeItem();
	};
	DebuggingMenu.DBTint.onPress = function() {
		DebuggingMenu.DBPosition._visible = false;
		DebuggingMenu.mc_colourPicker._visible = true;
	}
	
	DebuggingMenu.PeoplePlacesBtn.Btn.onPress = function() {
		dspMain.ShowStatisticsTab(5);
		ShowLargerText();
		AddText("<b>City: #cityname (" + currentCity.ModuleName + ")</b>\r\r");
		
		AddText("<b><u>People</u></b>");
		currentCity.DebugPeople();
		
		AddText("\r<b><u>Places</u></b>");
		currentCity.DebugPlaces();	
		
		AddText("\r<b><u>Shops</u></b>");
		currentCity.DebugShops();	
	}
	
	DebuggingMenu.BitflagsBtn.Btn.onPress = function()
	{
		dspMain.ShowStatisticsTab(5);
		ShowLargerText();
		var say:String = "SoldSlave\t\t" + Owner.GetOwner() + " (" + SoldSlave + ")";
		say += "\rStart Owner\t\t" + slaveData.StartOwner.GetOwner();
		say += "\rTrainingStart\t" + TrainingStart + "(" + Elapsed + ")";
		say += "\rTentacleHaunt\t" + TentacleHaunt;
		say += "\rCustomFlag  \t" + CustomFlag;
		say += "\rCustomFlag1\t" + CustomFlag1;
		say += "\rCustomFlag2\t" + CustomFlag2;
		say += "\rCustomFlag3\t" + CustomFlag3;
		say += "\rCustomFlag4\t" + CustomFlag4;
		say += "\rCustomFlag5\t" + CustomFlag5;
		say += "\rCustomFlag6\t" + CustomFlag6;
		say += "\rCustomFlag7\t" + CustomFlag7;
		say += "\rCustomFlag8\t" + CustomFlag8;
		say += "\rCustomFlag9\t" + CustomFlag9;
		say += "\rCustomString\t" + CustomString;
		say += "\rPath1\t\t\t" + Path1;
		say += "\rPath2\t\t\t" + Path2;
		say += "\rPath3\t\t\t" + Path3;
		say += "\rPregnancy = " + PregnancyGestation;
		say += "\rPregnant With = " + PregnancyType;
		say += "\rFairyMeeting = " + FairyMeeting;
	
		say += "\r\r<b>BitFlag 1</b>\r" + BitFlag1.ShowBitFlags();
		say += "\r<b>BitFlag 2</b>\r" + BitFlag2.ShowBitFlags();
		say += "\r<b>Assistant BitFlag1</b>\r" + AssistantData.BitFlag1.ShowBitFlags();
		say += "\r<b>Assistant BitFlag2</b>\r" + AssistantData.BitFlag2.ShowBitFlags();
		
		say +="\r<b>Slave Maker</b>";
		say += "\rSMPregnancy = " + SMData.PregnancyGestation;
		say += "\rSMPregnant With = " + SMData.PregnancyType;	
		say += "\r\r<b>Advantages</b>\r" + SMData.SMAdvantages.ShowBitFlags();
		say += "\r<b>BitFlag SM</b>\r" + SMData.BitFlagSM.ShowBitFlags();
		
		say += modulesList.ShowFlags();
		say += Plannings.ShowFlags();
		
		if (Key.isDown(Key.SHIFT)) {
			sdata.ActInfoBase.ActArray.sortOn("Act", Array.NUMERIC);
			say += sdata.ActInfoBase.ShowFlags();
		} else {
			slaveData.ActInfoBase.ActArray.sortOn("Act", Array.NUMERIC);
			say += slaveData.ActInfoBase.ShowFlags();		
		}
		AddText(say);
			
	}
	
	DebuggingMenu.SlavesBtn.Btn.onPress = function() {
		dspMain.ShowStatisticsTab(5);
		ShowLargerText();
		var sdata:Slave;
		var say:String;
		var ar:Array = Key.isDown(Key.SHIFT) ? SMData.arUsableSlaves : SMData.SlavesArray;
		if (ar == SMData.arUsableSlaves) say = "<b>Usable Slaves</b>";
		else say = "<b>All Slaves</b>";
		for (var so:String in ar) {
			sdata = ar[so];
			say += sdata.DebugSlave();
		}
		AddText(say);
	}
	
	DebuggingMenu.XMLBtn.Btn.onPress = function() {
		dspMain.ShowStatisticsTab(5);
		ShowLargerText();
	
		var say:String;
		
		var str:String = Language.StripLines(DebuggingMenu.DBPosition.text);
		if (Key.isDown(Key.CONTROL)) {
			var xNode:XMLNode = GetNode(str);
			say = xNode + "";
		} else say = XMLData.ShowNodeDetails("", GetNodeC(str));
		say = say.split("<").join("&lt;").split(">").join("&gt;");
		AddText(say);
	}


	DebuggingMenu.DBItem.onChanged = DebugSetItemDetails;
	DebuggingMenu.DBX.onChanged = DebugChangeItem;
	DebuggingMenu.DBY.onChanged = DebugChangeItem;
	DebuggingMenu.DBHeight.onChanged = DebugChangeItem;
	DebuggingMenu.DBWidth.onChanged = DebugChangeItem;
	DebuggingMenu.DBRotate.onChanged = DebugChangeItem;
	DebuggingMenu.DBFrame.onChanged = DebugChangeItem;
	DebuggingMenu._x = 664;
	
	HideMenus();
	HideImages();
	HideSlaveActions();
	DressFrame = 0;
	DebuggingMenu._visible = true;
	DebuggingMenu.DBSMGender.text = Gender;
	DebuggingMenu.DBGender.text = SlaveGender;
	DebuggingMenu.DBXF.text = DickgirlXF;
	DebuggingMenu.DBFairy.text = FairyXF;
	DebuggingMenu.DBPonygirl.text = DonePonygirl;
	DebuggingMenu.DBCatgirl.text = Catgirl ? "1" : "0";
	DebuggingMenu.DBPuppygirl.text = BitFlag1.CheckBitFlag(58) ? "1" : "0";
	DebuggingMenu.DBDevil.text = BitFlag1.CheckBitFlag(46) ? "1" : "0";
	DebuggingMenu.BitflagsBtn.LText.text = "View Flags";
	DebuggingMenu.SlavesBtn.LText.text = "Slaves";
	DebuggingMenu.PeoplePlacesBtn.LText.text = "People/Places";
	DebuggingMenu.ClearItems.LText.text = "Clear Items";
	DebuggingMenu.LoadItems.LText.text = "Load Items";
	DebuggingMenu.DressNaked.LText.text = "Naked";
	DebuggingMenu.EvalBtn.LText.text = "Evaluate";
	DebuggingMenu.DateBtn.LText.text = "+1 Day";
	DebuggingMenu.TimeBtn.LText.text = "+1 Hour";
	DebuggingMenu.BEBtn.LText.text = "BE";
	DebuggingMenu.LOGBtn.LText.text = "Log";
	DebuggingMenu.ClearBtn.LText.text = "Erase";
	DebuggingMenu.ResetBtn.LText.text = "Reset";
	DebuggingMenu.XMLBtn.LText.text = "View XML";
	DebuggingMenu.LoveBtn.LText.text = "Love";
	if (DressHaloCR == ItemsOver1.DressHaloCR) DebuggingMenu.SlaveToggle.LText.text = "Slave1";
	else DebuggingMenu.SlaveToggle.LText.text = "Slave2";
	DebugDress();

}

function DebugGetItemSize(mc:MovieClip) : Boolean
{
	if (mc.posx != undefined) {
		DebuggingMenu.DBX.text = mc.posx;
		DebuggingMenu.DBY.text = mc.posy;
		DebuggingMenu.DBWidth.text = mc.poswid;
		DebuggingMenu.DBHeight.text = mc.poshei;
		DebuggingMenu.DBRotate.text = mc.posrot;
		var mycolour:Color = new Color(DebuggingMenu.DBTint);
		if (mc.tint != undefined) mycolour.setRGB(mc.tint);
		else {
			mycolour.setRGB(0);
			mc.tint = 0;
		}
		return true;
	}
	DebuggingMenu.DBX.text = mc._x;
	DebuggingMenu.DBY.text = mc._y;
	DebuggingMenu.DBWidth.text = mc._width;
	DebuggingMenu.DBHeight.text = mc._height;
	DebuggingMenu.DBRotate.text = mc._rotation;
	var mycolour:Color = new Color(DebuggingMenu.DBTint);
	mycolour.setRGB(0);
	mc.tint = 0;
	return false;
}
	
function DebugDress()
{
	var df:Number = DressFrame;
	HideDresses();
	DressFrame = df;
	ShowDress();
	DebuggingMenu.I1 = "";
	DebuggingMenu.I2 = "";
	DebuggingMenu.I3 = "";
	DebuggingMenu.I4 = "";
	DebuggingMenu.I5 = "";
	DebuggingMenu.I6 = "";
	DebuggingMenu.I7 = "";
	DebuggingMenu.I8 = "";
	DebuggingMenu.I9 = "";
	DebuggingMenu.I10 = "";
	DebuggingMenu.I11 = "";
	DebuggingMenu.I12 = "";
	DebuggingMenu.I13 = "";
	DebuggingMenu.I14 = "";
	DebuggingMenu.I15 = "";
	DebuggingMenu.I16 = "";
	DebuggingMenu.I17 = "";
	DebuggingMenu.X1 = "";
	DebuggingMenu.X2 = "";
	DebuggingMenu.X3 = "";
	DebuggingMenu.X4 = "";
	DebuggingMenu.X5 = "";
	DebuggingMenu.X6 = "";
	DebuggingMenu.X7 = "";
	DebuggingMenu.X8 = "";
	DebuggingMenu.X9 = "";
	DebuggingMenu.X10 = "";
	DebuggingMenu.X11 = "";
	DebuggingMenu.X12 = "";
	DebuggingMenu.X13 = "";
	DebuggingMenu.X14 = "";
	DebuggingMenu.X15 = "";
	DebuggingMenu.X16 = "";
	DebuggingMenu.X17 = "";
	DebuggingMenu.DBPosition.text = "";
	DebuggingMenu.DBDress.text = DressWorn;
	if (DressFrame == 0) DressFrame = lastmc._currentframe;
	var ilast:Number = 0;
	if (DebuggingMenu.SlaveToggle.LText.text == "Slave1") SetSlave1Items();
	else SetSlave2Items();

	for (i = 1; i < 18; i++) {
		if (DebugGetItemSizeNo(i)) {
			ilast = i;
			DebuggingMenu.DBItem.text = i + "";
			DebugSetItemDetails2();
		}
	}
	var	oPlugInserted:Number = PlugInserted;
	var oPonyTailWorn:Number = PonyTailWorn;
	var oCatTailWorn:Number = CatTailWorn;
	var oCatEarsWorn:Number = CatEarsWorn;
	var oPuppyTailWorn:Boolean = Items.IsItemWorn(30);
	var oPuppyEarsWorn:Boolean = Items.IsItemWorn(29);
	var oHaloWorn:Number = HaloWorn;
	
	DebuggingMenu.DBItem.text = "0";
	DebugChangeItem();
	
	PlugInserted = oPlugInserted;
	PonyTailWorn = oPonyTailWorn;
	CatEarsWorn = oCatEarsWorn;
	CatTailWorn = oCatTailWorn;
	slaveData.ItemsWorn.ChangeBitFlag(29, oPuppyEarsWorn);
	slaveData.ItemsWorn.ChangeBitFlag(30, oPuppyTailWorn);
	HaloWorn = oHaloWorn;

	if (ilast != 0) {
		DebuggingMenu.DBItem.text = ilast + "";
		DebugSetItemDetails2();
	}
	HideDresses();
	if (df != 0) DressFrame = df;
	ShowDress();
	if (DressFrame == 0) DressFrame = 1;
	if (DressWorn == -1) DebuggingMenu.DBDressFrame.text = NakedChoice + "";
	else DebuggingMenu.DBDressFrame.text = DressFrame + "";
	DressHalo._visible = false;
	DressBitgag._visible = false;
	DressLeash._visible = false;
}

function DebugSetItemDetails()
{
	clearInterval(intervalId1);
	intervalId1 = setInterval(_root, "DebugSetItemDetails2", 200);
}

function DebugGetItemSizeNo(item:Number) : Boolean
{
	switch(item) {
		case 1:
			return DebugGetItemSize(DressTailCR);
		case 2:
			return DebugGetItemSize(DressTailOverCR);
		case 3:
			return DebugGetItemSize(DressHaloCR);
		case 4:
			return DebugGetItemSize(DressLeashCR);
		case 5:
			return DebugGetItemSize(DressBitgagCR);
		case 6:
			return DebugGetItemSize(DressNymphsTiaraCR);
		case 7:
			return DebugGetItemSize(Wings);
		case 8:
			return DebugGetItemSize(WingsOver);
		case 9:
			return DebugGetItemSize(DressCatEars);
		case 10:
			return DebugGetItemSize(DressCatEarsOver);
		case 11:
			return DebugGetItemSize(WingLeftOver);
		case 12:
			return DebugGetItemSize(WingRightOver);
		case 13:
			return DebugGetItemSize(WingLeft);
		case 14:
			return DebugGetItemSize(WingRight);
		case 15:
			return DebugGetItemSize(DressCatEarOver);
		case 16:
			return DebugGetItemSize(DressPuppyEars);
		case 17:
			return DebugGetItemSize(DressPuppyEarsOver);			

	}
}

function DebugSetItemDetails2()
{
	clearInterval(intervalId1);
	DebugGetItemSizeNo(Number(DebuggingMenu.DBItem.text));
	switch(Number(DebuggingMenu.DBItem.text)) {
		case 1:
			DebuggingMenu.DBFrame.text = DressTailCR._currentframe;
			break;
		case 2:
			DebuggingMenu.DBFrame.text = DressTailOverCR._currentframe;
			break;
		case 3:
			DebuggingMenu.DBFrame.text = "N/A";
			break;
		case 4:
			DebuggingMenu.DBFrame.text = DressLeashCR._currentframe;
			break;
		case 5:
			DebuggingMenu.DBFrame.text = DressBitgagCR._currentframe;
			break;
		case 6:
			DebuggingMenu.DBFrame.text = DressNymphsTiaraCR._currentframe + "";
			break;
		case 7:
			DebuggingMenu.DBFrame.text = Wings._currentframe + "";
			break;		
		case 8:
			DebuggingMenu.DBFrame.text = "N/A";
			break;
		case 11:
			DebuggingMenu.DBFrame.text = WingLeftOver._currentframe;
			break;
		case 12:
			DebuggingMenu.DBFrame.text = WingRightOver._currentframe;
			break;
		case 13:
			DebuggingMenu.DBFrame.text = WingLeft._currentframe;
			break;
		case 14:
			DebuggingMenu.DBFrame.text = WingRight._currentframe;
			break;
		case 9:
			DebuggingMenu.DBFrame.text = DressCatEars._currentframe + "";
			break;
		case 10:
			DebuggingMenu.DBFrame.text = DressCatEarsOver._currentframe + "";
			break;
		case 15:
			DebuggingMenu.DBFrame.text = DressCatEarOver._currentframe + "";
			break;
		case 16:
			DebuggingMenu.DBFrame.text = DressPuppyEars._currentframe + "";
			break;
		case 17:
			DebuggingMenu.DBFrame.text = DressPuppyEarsOver._currentframe + "";
			break;
			

	}
	DebugChangeItem();
}

function DebugRelease(mc:MovieClip)
{
	mc.posx = mc._x;
	mc.posy = mc._y;
	DebugGetItemSize(mc);
	DebugChangeItem();
}

function DebugSetDraggable(mc:MovieClip, item:Number) 
{
	mc.enabled = true;
	mc.ditem = item;
	mc.onPress = function() { DebuggingMenu.DBItem.text = this.ditem + ""; startDrag(this); }
	mc.onRelease = function() { stopDrag(); DebugRelease(this); }
}

function DebugClearDraggable(mc:MovieClip) 
{
	mc.enabled = false;
	mc.onPress = null;
	mc.onRelease = null;
}

	
function DebugChangeItem()
{
	function FixVal(s:String) : Number
	{
		var val:Number = Number(s);
		if (s == "" || s == "N/A") return 0;
		return Math.round(val * 10) / 10;
	}
	var frame:Number = FixVal(DebuggingMenu.DBFrame.text);
	if (frame == 0) frame = 1;
	else frame = Math.round(Number(DebuggingMenu.DBFrame.text));
	var xpos:Number = FixVal(DebuggingMenu.DBX.text);
	var ypos:Number = FixVal(DebuggingMenu.DBY.text);
	var rot:Number = FixVal(DebuggingMenu.DBRotate.text);
	var wid:Number = FixVal(DebuggingMenu.DBWidth.text);
	var hei:Number = FixVal(DebuggingMenu.DBHeight.text);
		
	var transformer = new Transform(DebuggingMenu.DBTint);
	var ctf:ColorTransform = transformer.colorTransform;
	var tint:Number = ctf.rgb;
	
	DebugClearDraggable(DressHaloCR);
	DebugClearDraggable(DressTailCR);
	DebugClearDraggable(DressTailOverCR);
	DebugClearDraggable(DressLeashCR);
	DebugClearDraggable(DressBitgagCR);
	DebugClearDraggable(DressNymphsTiaraCR);
	DebugClearDraggable(Wings);
	DebugClearDraggable(WingLeft);
	DebugClearDraggable(WingRight);
	DebugClearDraggable(WingsOver);
	DebugClearDraggable(WingLeftOver);
	DebugClearDraggable(WingRightOver);
	DebugClearDraggable(DressCatEars);
	DebugClearDraggable(DressCatEarsOver);
	DebugClearDraggable(DressCatEarOver);
	DebugClearDraggable(DressPuppyEars);
	DebugClearDraggable(DressPuppyEarsOver);

	switch(Number(DebuggingMenu.DBItem.text)) {
		case 0:
			HideDressItems(ItemsOver1, ItemsUnder1);
			HideDressItems(ItemsOver2, ItemsUnder2);

			PlugInserted = 0;
			PonyTailWorn = 0;
			slaveData.ItemsWorn.ClearBitFlag(29);
			slaveData.ItemsWorn.ClearBitFlag(30);
			CatTailWorn = 0;
			CatEarsWorn = 0;
			HaloWorn = 0;
			DebuggingMenu.DBPosition.text = "";
			return;
		case 1:
			DebugSetDraggable(DressTailCR, 1);
			PonyTailWorn = 0;
			slaveData.ItemsWorn.ClearBitFlag(30);
			CatTailWorn = 0;
			if (IsCatgirl()) CatTailWorn = 1;
			else if (IsPuppygirl()) slaveData.ItemsWorn.SetBitFlag(30);
			else PonyTailWorn = 1;
			PlugInserted = 1;
			DressTailCR._visible = true;
			PositionTail(xpos, ypos, rot, wid, hei, true, frame);
			DebuggingMenu.I1 = "_root.PositionTail(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", true";
			if (frame > 1) DebuggingMenu.I1 += ", " + frame;
			DebuggingMenu.I1 += ");\r";
			if (tint != 0) DebuggingMenu.I1 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X1 = "<Tail x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' frame='"  + frame + "'";
			if (rot != 0) DebuggingMenu.X1 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X1 += " tint='" + tint + "'";
			DebuggingMenu.X1 += "/>\r";
			break;
		case 2:
			DebugSetDraggable(DressTailOverCR, 2);
			PonyTailWorn = 0;
			slaveData.ItemsWorn.ClearBitFlag(30);
			CatTailWorn = 0;
			if (IsCatgirl()) CatTailWorn = 1;
			else if (IsPuppygirl()) slaveData.ItemsWorn.SetBitFlag(30);
			else PonyTailWorn = 1;
			PlugInserted = 1;
			DressTailOverCR._visible = true;
			PositionTailOver(xpos, ypos, rot, wid, hei, true, frame);
			DebuggingMenu.I2 = "_root.PositionTailOver(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", true";
			if (frame > 1) DebuggingMenu.I2 += ", " + frame;
			DebuggingMenu.I2 += ");\r";
			if (tint != 0) DebuggingMenu.I2 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X2 = "<Tail x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' frame='"  + frame + "' over='true'";
			if (rot != 0) DebuggingMenu.X2 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X2 += " tint='" + tint + "'";
			DebuggingMenu.X2 += "/>\r";
			break;
		case 3:
			DebugSetDraggable(DressHaloCR, 3);
			HaloWorn = 1;
			DressHaloCR._visible = true;
			var odf:Number = SMData.SMFaith;
			SMData.SMFaith = 1;
			PositionHalo(xpos, ypos, rot, wid, hei);
			SMData.SMFaith = odf;

			DebuggingMenu.I3 = "_root.PositionHalo(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I3 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X3 = "<Halo x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			if (rot != 0) DebuggingMenu.X3 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X3 += " tint='" + tint + "'";
			DebuggingMenu.X3 += "/>\r";
			break;
		case 4:
			DebugSetDraggable(DressLeashCR, 4);
			LeashWorn = 1;
			PositionLeash(frame, xpos, ypos, rot, wid, hei, true);
			DebuggingMenu.I4 = "_root.PositionLeash(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", true);\r";
			if (tint != 0) DebuggingMenu.I4 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X4 = "<Leash x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' frame='" + frame + "'";
			if (rot != 0) DebuggingMenu.X4 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X4 += " tint='" + tint + "'";
			DebuggingMenu.X4 += "/>\r";
			break;
		case 5:
			DebugSetDraggable(DressBitgagCR, 5);
			BitGagWorn = 1;
			PositionGag(frame, xpos, ypos, rot, wid, hei, true);	
			DebuggingMenu.I5 = "_root.PositionGag(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", true);\r";
			if (tint != 0) DebuggingMenu.I5 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X5 = "<BitGag frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			if (rot != 0) DebuggingMenu.X5 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X5 += " tint='" + tint + "'";
			DebuggingMenu.X5 += "/>\r";
			break;
		case 6:
			NymphsTiaraWorn = 1;
			DebugSetDraggable(DressNymphsTiaraCR, 6);
			DressNymphsTiaraCR._visible = false;
			DressNymphsTiara._visible = false;
			PositionNymphsTiara(xpos, ypos, rot, wid, hei, true);
			DebuggingMenu.I6 = "_root.PositionNymphsTiara(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", true);\r";
			if (tint != 0) DebuggingMenu.I6 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X6 = "<NymphsTiara x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			if (rot != 0) DebuggingMenu.X6 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X6 += " tint='" + tint + "'";
			DebuggingMenu.X6 += "/>\r";
			break;
		case 7:
			if (FairyXF == 0 || !BitFlag1.CheckBitFlag(50)) FairyXF = 50;
			Wings._visible = true;
			DebugSetDraggable(Wings, 7);
			PositionWings(xpos, ypos, rot, wid, hei, frame);
			if (frame != NaN) DebuggingMenu.I7 = "_root.PositionWings(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", " + frame + ");\r";
			else DebuggingMenu.I7 = "_root.PositionWings(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I7 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			if (frame != NaN) DebuggingMenu.X7 = "<Wings frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			else DebuggingMenu.X7 = "<Wings x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";

			if (rot != 0) DebuggingMenu.X7 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X7 += " tint='" + tint + "'";
			DebuggingMenu.X7 += "/>\r";
			break;
		case 8:
			if (FairyXF == 0 || !BitFlag1.CheckBitFlag(50)) FairyXF = 50;
			WingsOver._visible = true;
			DebugSetDraggable(WingsOver, 8);
			PositionWingsOver(xpos, ypos, rot, wid, hei, frame);
			if (tint != 0) DebuggingMenu.I8 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			if (frame != NaN) DebuggingMenu.I8 = "_root.PositionWingsOver(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (frame != NaN) DebuggingMenu.X8 = "<Wings frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' over='true'";
			else DebuggingMenu.X8 = "<Wings x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' over='true'";
			if (rot != 0) DebuggingMenu.X8 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X8 += " tint='" + tint + "'";
			DebuggingMenu.X8 += "/>\r";
			break;
		case 9:
			CatEarsWorn = 1;
			DebugSetDraggable(DressCatEars, 9);
			PositionCatEars(frame, xpos, ypos, rot, wid, hei);
			DebuggingMenu.I9 = "_root.PositionCatEars(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I9 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X9 = "<CatEars frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' rotation='" + rot + "' width='" + wid + "' height='" + hei + "'";
			if (tint != 0) DebuggingMenu.X9 += " tint='" + tint + "'";
			DebuggingMenu.X9 += "/>\r";
			break;
		case 10:
			CatEarsWorn = 1;
			DebugSetDraggable(DressCatEarsOver, 10);
			PositionCatEarsOver(frame, xpos, ypos, rot, wid, hei);
			DebuggingMenu.I10 = "_root.PositionCatEarsOver(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I10 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X10 = "<CatEars frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' rotation='" + rot + "' width='" + wid + "' height='" + hei + "' over='true'";
			if (tint != 0) DebuggingMenu.X10 += " tint='" + tint + "'";
			DebuggingMenu.X10 += "/>\r";
			break;
		case 11:
			if (FairyXF == 0 || !BitFlag1.CheckBitFlag(50)) FairyXF = 50;
			WingLeftOver._visible = true;
			DebugSetDraggable(WingLeftOver, 11);
			PositionWingLeftOver(xpos, ypos, rot, wid, hei, frame);
			DebuggingMenu.I11 = "_root.PositionWingLeftOver(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", " + frame + ");\r";
			if (tint != 0) DebuggingMenu.I11 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X11 = "<WingLeft frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' rotation='" + rot + "' width='" + wid + "' height='" + hei + "' over='true'";
			if (rot != 0) DebuggingMenu.X11 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X11 += " tint='" + tint + "'";
			DebuggingMenu.X11 += "/>\r";
			break;
		case 12:
			if (FairyXF == 0 || !BitFlag1.CheckBitFlag(50)) FairyXF = 50;
			DebugSetDraggable(WingRightOver, 12);
			WingRightOver._visible = true;
			PositionWingRightOver(xpos, ypos, rot, wid, hei, frame);
			DebuggingMenu.I12 = "_root.PositionWingRightOver(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", " + frame + ");\r";
			if (tint != 0) DebuggingMenu.I12 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X12 = "<WingRight frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' over='true'";
			if (rot != 0) DebuggingMenu.X12 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X12 += " tint='" + tint + "'";
			DebuggingMenu.X12 += "/>\r";
			break;
		case 13:
			if (FairyXF == 0 || !BitFlag1.CheckBitFlag(50)) FairyXF = 50;
			DebugSetDraggable(WingLeft, 13);
			WingLeft._visible = true;
			PositionWingLeft(xpos, ypos, rot, wid, hei, frame);
			DebuggingMenu.I13 = "_root.PositionWingLeft(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", " + frame + ");\r";
			if (tint != 0) DebuggingMenu.I13 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X13 = "<WingLeft frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			if (rot != 0) DebuggingMenu.X13 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X13 += " tint='" + tint + "'";
			DebuggingMenu.X13 += "/>\r";
			break;
		case 14:
			if (FairyXF == 0 || !BitFlag1.CheckBitFlag(50)) FairyXF = 50;
			DebugSetDraggable(WingRight, 14);
			WingRight._visible = true;
			PositionWingRight(xpos, ypos, rot, wid, hei, frame);
			if (tint != 0) DebuggingMenu.I14 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.I14 = "_root.PositionWingRight(" + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ", " + frame + ");\r";
			DebuggingMenu.X14 = "<WingRight frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			if (rot != 0) DebuggingMenu.X14 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X14 += " tint='" + tint + "'";
			DebuggingMenu.X14 += "/>\r";
			break;
		case 15:
			DebugSetDraggable(DressCatEarOver, 15);
			CatEarsWorn = 1;
			PositionCatEarOver(frame, xpos, ypos, rot, wid, hei);
			DebuggingMenu.I15 = "_root.PositionCatEarOver(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I15 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X15 = "<CatEar frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' over='true'";
			if (rot != 0) DebuggingMenu.X15 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X15 += " tint='" + tint + "'";
			DebuggingMenu.X15 += "/>\r";
			break;
		case 16:
			slaveData.ItemsWorn.SetBitFlag(29);
			DebugSetDraggable(DressPuppyEars, 16);
			PositionPuppyEars(frame, xpos, ypos, rot, wid, hei);
			DebuggingMenu.I16 = "_root.PositionPuppyEars(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I16 += "_root.SetLastMovieColourARGB(" + tint + ");\r";			
			DebuggingMenu.X16 = "<PuppyEars frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "'";
			if (rot != 0) DebuggingMenu.X16 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X16 += " tint='" + tint + "'";
			DebuggingMenu.X16 += "/>\r";
			break;
		case 17:
			slaveData.ItemsWorn.SetBitFlag(29);
			DebugSetDraggable(DressPuppyEarsOver, 17);
			PositionPuppyEarsOver(frame, xpos, ypos, rot, wid, hei);
			DebuggingMenu.I17 = "_root.PositionPuppyEarsOver(" + frame + ", " + xpos+", " + ypos + ", " + rot + ", " + wid + ", " + hei + ");\r";
			if (tint != 0) DebuggingMenu.I17 += "_root.SetLastMovieColourARGB(" + tint + ");\r";
			DebuggingMenu.X17 = "<PuppyEars frame='"  + frame + "' x='" + xpos+"' y='" + ypos + "' width='" + wid + "' height='" + hei + "' over='true'";
			if (rot != 0) DebuggingMenu.X17 += " rotation='" + rot + "'";
			if (tint != 0) DebuggingMenu.X17 += " tint='" + tint + "'";
			DebuggingMenu.X17 += "/>\r";
			break;

	}
	
	if (Number(DebuggingMenu.DBItem.text) < 18) SetLastMovieColourARGB(tint);

	DebuggingMenu.DBPosition.text = "XML\r<" + DebuggingMenu.SlaveToggle.LText.text + ">\r" + DebuggingMenu.X3;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X4;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X5;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X6;
	
	//DebuggingMenu.DBPosition.text += "\r// Over\r"
	DebuggingMenu.DBPosition.text += DebuggingMenu.X2;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X8;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X10;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X11;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X12;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X15;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X16;
	
	//DebuggingMenu.DBPosition.text += "\r// Under";
	DebuggingMenu.DBPosition.text += DebuggingMenu.X1;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X7;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X9;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X13;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X14;
	DebuggingMenu.DBPosition.text += DebuggingMenu.X17;
	
	DebuggingMenu.DBPosition.text += "</" + DebuggingMenu.SlaveToggle.LText.text + ">\r";
	
	DebuggingMenu.DBPosition.text += "\rActionscript\r" + DebuggingMenu.I3;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I4;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I5;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I6;
	
	//DebuggingMenu.DBPosition.text += "\r// Over\r"
	DebuggingMenu.DBPosition.text += DebuggingMenu.I2;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I8;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I10;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I11;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I12;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I15;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I16;
	
	//DebuggingMenu.DBPosition.text += "\r// Under";
	DebuggingMenu.DBPosition.text += DebuggingMenu.I1;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I7;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I9;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I13;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I14;
	DebuggingMenu.DBPosition.text += DebuggingMenu.I17;
}

function DebugLoveDetails()
{
	var iLove:Number = SMData.GetTotalSlavesInLove();
	var iLimit:Number = 1 + ((SMData.sLeadership * 2) - 1);
	if (SMData.sLeadership > 3 || IsSlave("Shampoo")) iLimit = 99999;
	else if (SMData.sLeadership == 1) iLimit = 1;
	
	// Gender effects
	var sameg:Boolean = (SlaveGender == 1 && (SMData.Gender == 1 || SMData.Gender == 4));
	if (DickgirlLesbians) {
		if (SlaveGender == 2 && (SMData.Gender != 1 && SMData.Gender != 4)) sameg = true;
	} else {
		if (SMData.Gender == 2 && (SlaveGender != 1 && SlaveGender != 4)) sameg = true;
		else if (SMData.Gender == 3 && (SlaveGender != 3 && SlaveGender != 6)) sameg = true;
	}
	var lf:Number = 1;
	if (sameg) {
		if (LesbianTraining) lf *= 0.7;
		else lf *= 0.5;
	} else if (SMAdvantages.CheckBitFlag(20)) lf *= 0.5;
	if (SMAdvantages.CheckBitFlag(9)) lf *= 0.75;
	switch (Home.HouseType) {
		case 4:
			lf *= 1.2;
			break;
	}
	if (SMData.sLeadership > 0) lf *= (1 + (SMData.sLeadership * 0.1));
	lf *= dmod;


	var say:String = "Total Lovers:\t\t\t" + iLove;
	say += "\rLeadership\t\t\t" + SMData.sLeadership;
	say += "\rLimit of Lovers\t\t\t" + iLimit;
	say += "\rMarried\t\t\t" + SMData.GetTotalMarried();
	say += "\rLove (current)\t\t\t" + VarLovePoints;
	say += "\rLove Factor\t\t\t" + lf;
	
	var sdata:Slave;
	for (var so:String in SlavesArray) {
		sdata = SlavesArray[so];
		if (sdata.IsSlaveOwned() || sdata,SlaveType == -10) {
			say = say + "\r\r<u>Slave</u>" + sdata.SlaveIndex + ": <b>" + sdata.SlaveName + "</b>";
			say = say + "\r  Love = " + sdata.VarLovePoints;
			say = say + "\tAccepted = " + sdata.LoveAccepted;
			say = say + "\r  Noble Love = " + sdata.NobleLove;
			say = say + "\tType = " + sdata.NobleLoveType;
			say = say + "\r  Old Lover = " + sdata.OldLover;
			say = say + "\tBoyfriend = " + sdata.EventBoyfriend;		
		}
	}
	AddText(say);
}
