// Slave's Introduction at start of training

var IntroPage:Number;
var IntroPages:Number;
var nAssIntroPage:Number;

// support functions

function ShowGirlsStoryStart()
{
	GirlsStoryTop.GirlsStoryNext.tabChildren = true;
	GirlsStoryTop.tabChildren = true;
	GirlsStoryTop.BigButton.tabEnabled = false;
	GirlsStoryTop.BigButton._visible = true;
	GirlsStoryTop.GirlsStoryNext._visible = true;
	GirlsStoryTop.LTitle.htmlText = Language.GetHtml("ANewSlave", "Introduction", true);
	GirlsStoryTop.BlackText._visible = true;
	GirlsStoryTop.WhiteText._visible = false;
	GirlsStoryTop.GirlsStoryNext._x = 873 + config.nScreenXOffset - 224;
	GirlsStoryTop.GirlsStoryNext._y = 553.6 + config.nScreenYOffset;
	GirlsStoryTop.BlackText._width = 989.7 + config.nScreenXOffset - 224;
	GirlsStoryTop.WhiteText._width = 989.7 + config.nScreenXOffset - 224;

	GirlsStory._width = 770 + config.nScreenXOffset;
	GirlsStory._height = 510 + config.nScreenYOffset;
	SetMovieColour(GirlsStory, 255, 255, 255);
	
	ChangeSlaveMakerGender();

	dspMain.Hide();	
	HideImages();
	HideDresses();
	Backgrounds.HideBackgrounds();
}

function ShowIntroPage(trainable:Boolean)
{
	trace("ShowIntroPage: " + trainable + " slaveNode = " + slaveNode);
	XMLData.EventText = "";
	var mc:MovieClip = undefined;
	var iNode:XMLNode;
	if (trainable) {
		if (SMData.GuildMember) iNode = XMLData.GetNode(slaveNode, "IntroductionGuild" + IntroPage);
		else iNode = XMLData.GetNode(slaveNode, "IntroductionFreelancer" + IntroPage);
		if (iNode == null) iNode = XMLData.GetNode(slaveNode, "Introduction" + IntroPage);
		var align:Number = 2;
		if (iNode.attributes.align != undefined) align = DecodeAlign(iNode.attributes.align);
		var talign:String = "";
		if (iNode.attributes.textalign != undefined) talign = iNode.attributes.textalign;
		
		mc = SlaveGirl.ShowIntroPage(IntroPage, align);
		if (SlaveGirl.ShowIntroPage == undefined || mc === undefined) {
			mc = SlaveMovie.Introduction;
			if (mc == undefined) mc = SlaveGirl.mcBase.Introduction;
			mc.gotoAndStop(IntroPage);	// TO DO remove
			mc._visible = true;	// TO DO remove
		}
		if (XMLData.XMLEventByNode(iNode, true, undefined, true)) {
			if (talign != "") XMLData.EventText = "<p align='" + talign + "'>" + XMLData.EventText + "</p>";
			if (iNode.attributes.black == "true") Language.AddIntroText(XMLData.EventText, true, false);
			else if (iNode.attributes.white == "true") Language.AddIntroText(XMLData.EventText, false, true);
			else Language.SetIntroText(XMLData.EventText);
			if (iNode.attributes.colour != undefined || Node.attributes.color != undefined) SetStoryColourARGB(ColourScheme.GetColourValue(iNode));
			XMLData.EventText = "";
		} 
	} else {
		if (IntroPage > 0) {
			mc = SlaveGirl.ShowUntrainable();
			iNode = XMLData.GetNode(slaveNode, "Untrainable");
			var talign:String = "";
			if (iNode.attributes.textalign != undefined) talign = iNode.attributes.textalign;			
			if (XMLData.XMLEventByNode(iNode, true, undefined, true)) {
				if (talign != "") XMLData.EventText = "<p align='" + talign + "'>" + XMLData.EventText + "</p>";
				if (iNode.attributes.black == "true") Language.AddIntroText(XMLData.EventText, true, false);
				else if (iNode.attributes.white == "true") Language.AddIntroText(XMLData.EventText, false, true);
				else Language.AddIntroText(XMLData.EventText);
				if (iNode.attributes.colour != undefined || Node.attributes.color != undefined) SetStoryColourARGB(ColourScheme.GetColourValue(iNode));
				XMLData.EventText = "";
			}
			IntroPage = -1;
		} else {
			IntroPage = -1;
			GirlsStory._visible = false;
			GirlsStoryTop._visible = false;
			StartNewSlave();
			return;
		}
	}
	if (mc != undefined) {
		var intro:String = mc.WhiteText.htmlText;
		if (intro == undefined) intro = mc.BlackText.htmlText;
		if (intro != undefined) {
			intro = UpdateMacros(intro);
			mc.WhiteText.htmlText = intro;
			mc.BlackText.htmlText = intro;
		}
	}
}

function ShowGirlsStory()
{	
	GirlsStory.tabChildren = true;
	ShowGirlsStoryStart();
	if (currentShop != null && currentShop == currentCity.SlaveMarketAuction) return;
	
	GirlsStoryTop.BlackText.htmlText = "";
	GirlsStoryTop.WhiteText.htmlText = "";
	
	GirlsStoryTop.BigButton.onPress = ShowGirlsStory;
	GirlsStoryTop.GirlsStoryNext.Btn.onPress = ShowGirlsStory;

	SlaveGirl.HideIntroPages();
	SlaveGirl.Introduction._visible = false; // TO DO remove
	SlaveGirl.mcBase.Introduction._visible = false; // TO DO remove
	
	var trainable:Boolean = SlaveGirl.IsTrainable();
	trace("trainable = " + trainable);
	if (trainable == undefined) trainable = true;
	var iNode:XMLNode = XMLData.GetNode(slaveNode, "Untrainable");
	if (iNode != null && ParseConditional(iNode, true, false) != null) trainable = false;
	
	if (IntroPage == 0) {
		nAssIntroPage = 1;
		IntroPage++;
		SlaveSelection._visible = false;
		IntroLoadButton._visible = false;
		SlaveInformation._visible = false;
		mcLoader.removeListener(mclListener);
		GirlsStory._visible = true;
		GirlsStoryTop._visible = true;
		
		if (SlaveFilename != "") {
			ShowIntroPage(IntroPages > 1 || trainable);
			return;
		}
		// training a minor slave
		var iNode:XMLNode;
		if (IntroPages > 1 || trainable) {
			if (SMData.GuildMember) iNode = XMLData.GetNode(slaveNode, "IntroductionGuild" + IntroPage);
			else iNode = XMLData.GetNode(slaveNode, "IntroductionFreelancer" + IntroPage);
			if (iNode == null) iNode = XMLData.GetNode(slaveNode, "Introduction" + IntroPage);
			if (iNode != null) {
				ShowIntroPage(IntroPages > 1 || trainable);
				return;
			}
		}
	}
	if (Key.isDown(Key.CONTROL)) {
		// reshow current
		IntroPage--;
		Language.ChangeLanguage(false, IntroPage == 0 ? "ShowGirlsStory" : "ShowGirlsStory2");
	} else if (Key.isDown(Key.SHIFT)) {
		// back one page
		IntroPage -= 2;
		if (IntroPage < 0) IntroPage = 0;
		Language.ChangeLanguage(false, IntroPage == 0 ? "ShowGirlsStory" : "ShowGirlsStory2");
	}  else ShowGirlsStory2();
}
	
function ShowGirlsStory2()
{
	trace("ShowGirlsStory2: " + LoadSave.IsStartingGame() + " " + IntroPage + " " + IntroPages);
	if (LoadSave.IsStartingGame() && IntroPage > 0 && IntroPage < IntroPages) {
		trace("..show");
		IntroPage++;
		ShowIntroPage(true);
		return;
	} else {
		var trainable:Boolean = SlaveGirl.IsTrainable();
		trace("..trainable? " + trainable);
		if (trainable == undefined) trainable = true;
		var iNode:XMLNode = XMLData.GetNode(slaveNode, "Untrainable");
		if (iNode != null && ParseConditional(iNode, true, false) != null) trainable = false;

		if (!trainable) {
			ShowIntroPage(trainable);
			return;
		}
	}
	if (IntroPage == IntroPages) {
		trace("..done?");
		var naip:Number = nAssIntroPage;
		if (CurrentAssistant.IntroductionAsAssistant(nAssIntroPage) == true) {
			GirlsStoryTop.LTitle.htmlText = Language.GetHtml("YourAssistant", "Introduction", true);
			if (nAssIntroPage == naip) {
				if (Home.DaysOccupied == 0) IntroPage = -1;
				else IntroPage++;
			}
			nAssIntroPage = naip;
			return;
		}
		var iNode:XMLNode = XMLData.GetNode(assNode, "Introduction");
		if (iNode == null) iNode = XMLData.GetNode(assNode, "AssistantIntroduction");
		if (iNode == null) iNode = XMLData.GetNode(assNode, "Introduction" + nAssIntroPage);
		if (iNode == null) iNode = XMLData.GetNode(assNode, "AssistantIntroduction" + nAssIntroPage);
		if (XMLData.XMLEventByNode(iNode, true, undefined, true)) {
			var talign:String = "";
			if (iNode.attributes.textalign != undefined) talign = iNode.attributes.textalign;
			if (talign != "") XMLData.EventText = "<p align='" + talign + "'>" + XMLData.EventText + "</p>";
			GirlsStoryTop.LTitle.htmlText = Language.GetHtml("YourAssistant", "Introduction", true);
			if (iNode.attributes.black == "true") Language.SetIntroText(XMLData.EventText, true, false);
			else if (iNode.attributes.white == "true") Language.SetIntroText(XMLData.EventText, false, true);
			else Language.SetIntroText(XMLData.EventText);
			if (iNode.attributes.colour != undefined || Node.attributes.color != undefined) SetStoryColourARGB(ColourScheme.GetColourValue(iNode));
			XMLData.EventText = "";
			nAssIntroPage++;
			iNode = XMLData.GetNode(assNode, "Introduction" + nAssIntroPage);
			if (iNode == null) iNode = XMLData.GetNode(assNode, "AssistantIntroduction" + nAssIntroPage);
			if (iNode == null) {
				if (Home.DaysOccupied == 0) IntroPage = -1;
				else IntroPage++;
			}
			return;
		}
	}
	trace("..start game!");
	Backgrounds.HideBackgrounds();
	ResumeShow();
}

// public functions

function SetIntroText(intro:String, blk:Boolean, wht:Boolean) { Language.SetIntroText(intro, blk, wht); }

function AddIntroText(intro:String, blk:Boolean, wht:Boolean) { Language.AddIntroText(intro, blk, wht); }

function SetIntroColour(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number)
{
	SetMovieColour(GirlsStory, red, green, blue, alphao, redmul, greenmul, bluemul, alphamul);
}
function SetIntroColourARGB(clr:Number)
{
	var red:Number = (clr >> 16) & 255;
	var green:Number = (clr >> 8) & 255;
	var blue:Number = clr & 255;
	SetMovieColour(GirlsStory, red, green, blue, alphao, 1, 1, 1, 1);
}

function SetStoryColour(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number) { SetIntroColour(red, green, blue, alphao, redmul, greenmul, bluemul, alphamul); }
function SetStoryColourARGB(clr:Number) { SetIntroColourARGB(clr); }

function SetStoryColourARGB(colour:Number)
{
	SetMovieColourARGB(GirlsStory, colour);
}
