// DialogTitleScreen - game title screen
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogTitleScreen extends DialogBase
{		
	private var mcHowTo:MovieClip;
	private var ss1:MovieClip;
	private var ss2:MovieClip;
	
	private var SkipButton:ButtonBase;
	public var BackButton:ButtonBase;
	public var LoadButton:ButtonBase;
	private var NextButton:ButtonBase;
	
	public var Introduction:Number;
	
	
	// Constructor
	public function DialogTitleScreen(cg:Object)
	{ 
		super(cg.IntroTitle, cg, 1);
		
		mcBase.BtnCredits.LText.htmlText = "<font color='#0000FF'>C</font>redits";
		mcBase.HowToPlay.LText.htmlText = "<font color='#0000FF'>H</font>ow to Play";
		mcBase.LoadGame.LText.htmlText = "<font color='#0000FF'>L</font>oad Game";
		mcBase.NewGame2.LText.htmlText = "<font color='#0000FF'>N</font>ew";
				
		mcHowTo = null;
		ss1 = null;
		ss2 = null;
		
		SkipButton = new ButtonBase(cg.IntroSkip, cg, "Skip", this, "PressSkipButton");
		BackButton = new ButtonBase(cg.IntroBackButton, cg, "Back", this, "PressBackButton");
		LoadButton = new ButtonBase(cg.IntroLoadButton, cg, "Load", this, "PressLoadButton");
		NextButton = new ButtonBase(cg.IntroNextButton, cg, "Next", this, "DoIntroNext");
		
		Introduction = 0;
	}

	// View
	public function ViewDialog() 
	{
		coreGame.HideAllImages();
		Introduction = 0;
		super.ViewDialog();
	}
	
	public function ShowDialogContents() 
	{
		mcBase._visible = true;
		Backgrounds.HideIntroBackground();
				
		if ((coreGame.GameVersion - Math.floor(coreGame.GameVersion)) == 0) mcBase.Version.text = "v3." + Math.floor(coreGame.GameVersion) + ".0" + coreGame.BugVersion;
		else if ((Math.round((100 * coreGame.GameVersion) + 10) % 10) == 0) mcBase.Version.text = "v3." + Math.floor(coreGame.GameVersion) + "0" + coreGame.BugVersion;
		else mcBase.Version.text = "v3." + coreGame.GameVersion + coreGame.BugVersion;

		var ti:DialogTitleScreen = this;
		
		var img:MovieClip = AddLargeButton();
	
		// Title
		mcBase.NewGame2.Btn.onPress = function() { ti.NewGame(); }
		mcBase.NewGame2.tabChildren = true;
		img.onPress = mcBase.NewGame2.Btn.onPress;
		mcBase.LoadGame.Btn.onPress = function() { ti.coreGame.LoadSave.ViewLoadScreen(); }
		mcBase.LoadGame.tabChildren = true;
	
		// Credits
		mcBase.BtnCredits.Btn.onPress = function() { ti.ShowCredits(); }
		mcBase.BtnCredits.tabChildren = true;
	
		// How to Play
		mcBase.HowToPlay.tabChildren = true;
		mcBase.HowToPlay.Btn.onPress = function() { ti.ShowHowToPlay();	}
		
		LoadButton.Hide();
	}
	
	public function NewGame()
	{
		coreGame.LoadSaveGames._visible = false;
		Introduction = 0;
		DoIntroNext();
	}
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (key == 13) {
			NewGame();
			return true;
		}
		switch(keya) {
			case 76:
				coreGame.LoadSave.ViewLoadScreen();
				return true;
			case 78:
				NewGame();
				return true;
			case 67:
				ShowCredits();
				return true;
			case 72:
				ShowHowToPlay();
				return true;
		}
		return false;
	}
	
	// How To Play
	
	private function LoadScreenShot(mv:String, xpos:Number, ypos:Number, wid:Number, hei:Number) : MovieClip
	{
		xpos = xpos + 520;
		ypos = ypos + 260;

		var mvm:String = mv;
		if (Language.LangType != "English") mvm += "|" + mv.split(Language.LangType).join("English");
		return coreGame.LoadImageAndPositionMovie(undefined, mvm, xpos + (wid/2), ypos + (hei/2), 0, wid, hei, mcHowTo);
	}
		
	public function ShowHowToPlay()
	{
		mcHowTo = coreGame.AutoAttachAndShowMovie("Title - How To Play", 2, 2);
		mcHowTo._visible = false;

		mcHowTo.LHow1x1.wordWrap = true;
		mcHowTo.LHow1x1.autoSize = true;
		mcHowTo.LHow1x2.wordWrap = true;
		mcHowTo.LHow1x2.autoSize = true;
		mcHowTo.LHow2x1.wordWrap = true;
		mcHowTo.LHow2x1.autoSize = true;
		mcHowTo.LHow2x2.wordWrap = true;
		mcHowTo.LHow2x2.autoSize = true;
		mcHowTo.LHow3x1.wordWrap = true;
		mcHowTo.LHow3x1.autoSize = true;
		mcHowTo.LHow3x2.wordWrap = true;
		mcHowTo.LHow3x2.autoSize = true;
		mcHowTo.LHow4x1.wordWrap = true;
		mcHowTo.LHow4x1.autoSize = true;
		mcHowTo.LHow4x2.wordWrap = true;
		mcHowTo.LHow4x2.autoSize = true;		
		
		var ti:DialogTitleScreen = this;
		mcHowTo.HowToNext.tabChildren = true;
		mcHowTo.HowToNext.Btn.onPress = function() {
			ti.Beep();
			ti.SetHowToPlayPage(ti.nCurrentPage + 1);
		}
		mcHowTo.Leave.tabChildren = true;
		mcHowTo.Leave.Btn.onPress = function() {
			ti.Beep();
			removeMovieClip(ti.ss1);
			removeMovieClip(ti.ss2);
			ti.ss1 = null;
			ti.ss2 = null;
			ti.coreGame.HideImages();
			ti.ShowDialogContents();
		}
		ShowHowToPlay2();
	}
		
	public function ShowHowToPlay2(timer:Number)
	{
		if (Language.IsLoaded() == false) {
			if (timer != undefined) return;
			Timers.AddTimerShowWait(
				setInterval(this, "ShowHowToPlay2", 10, Timers.GetNextTimerIdx())
				,undefined,true
			)
			return;
		}
		Timers.RemoveTimer(timer);
		Timers.StopWait();
		SetHowToPlayPage(1);
		mcBase._visible = false;
		mcHowTo._visible = true;
		Backgrounds.ShowIntroBackground();
		Beep();

	}
	public function SetHowToPlayPage(page:Number)
	{
		if (mcHowTo == null) return;
		
		var ti:DialogTitleScreen = this;

		if (page != undefined) {
			nCurrentPage = page;
			if (nCurrentPage < 5) mcHowTo.gotoAndStop(nCurrentPage);
			else mcHowTo.gotoAndStop(2);
			removeMovieClip(ss1);
			removeMovieClip(ss2);
			ss1 = null;
			ss2 = null;
			switch(nCurrentPage) {
				case 1:
					ss1 = LoadScreenShot("Language/" + Language.LangType + "/How To - Slaver.jpg", -115, -254, 380, 285);
					ss2 = LoadScreenShot("Language/" + Language.LangType + "/How To - House.jpg", -510, 40, 380, 285);
					break;
				case 2:
					ss1 = LoadScreenShot("Language/" + Language.LangType + "/How To - Slave Selection.jpg", -140, -248, 410, 307);
					break;
				case 3:
					ss1 = LoadScreenShot("Language/" + Language.LangType + "/How To - Morning.jpg", -144, -252, 410, 307);
					break;
				case 4:
					ss1 = LoadScreenShot("Language/" + Language.LangType + "/How To - Planning.jpg", -65.5, -254.5, 335, 251);
					ss2 = LoadScreenShot("Language/" + Language.LangType + "/How To - Night.jpg", -512, 75.5, 335, 251);
					break;
				default:
					ss1 = LoadScreenShot("Language/" + Language.LangType + "/How To - Page " + nCurrentPage + ".jpg", -140, -248, 410, 307);
					break;
			}
				
		}
		mcHowTo.HowToNext.LText.htmlText = Language.GetHtmlDef("Next", "Buttons");
		mcHowTo.Leave.LText.htmlText = Language.GetHtmlDef("Leave", "Buttons");
		mcHowTo.LTitle.htmlText = Language.GetHtmlDef("HowToTitle", "Hints", "How to Play SlaveMaker", true);

		//trace(nCurrentPage + " " + mcHowTo.LHow4x1);
		switch(nCurrentPage) {
			case 1:
				mcHowTo.LHow1x1.htmlText = Language.GetHtml("HowTo1x1", "Hints", true);
				mcHowTo.LHow1x2.htmlText = Language.GetHtml("HowTo1x2", "Hints", true);
				break;
			case 2:
				mcHowTo.LHow2x1.htmlText = Language.GetHtml("HowTo2x1", "Hints", true);
				mcHowTo.LHow2x2.htmlText = Language.GetHtml("HowTo2x2", "Hints", true);
				break;				
			case 3:
				mcHowTo.LHow3x1.htmlText = Language.GetHtml("HowTo3x1", "Hints", true);
				mcHowTo.LHow3x2.htmlText = Language.GetHtml("HowTo3x2", "Hints", true);
				break;
			case 4:
				mcHowTo.LHow4x1.htmlText = Language.GetHtml("HowTo4x1", "Hints", true);
				mcHowTo.LHow4x2.htmlText = Language.GetHtml("HowTo4x2", "Hints", true);
				break;
			default:
				mcHowTo.LHow2x1.htmlText = Language.GetHtml("HowTo" + nCurrentPage + "x1", "Hints", true);
				mcHowTo.LHow2x2.htmlText = Language.GetHtml("HowTo" + nCurrentPage + "x2", "Hints", true);
				break;				
			
		}
		mcHowTo.HowToNext._visible = Language.GetHtml("HowTo" + (nCurrentPage + 1) + "x1", "Hints") != "";
	}
	
	// Credits
	
	public function ShowCredits()
	{
		var image:MovieClip = coreGame.AutoAttachAndShowMovie("Title - Credits", 2, 1)
		image.BigButton.onPress = coreGame.DoIntroNext;
		image.BtnMore.LText.htmlText = Language.GetHtmlDef("More", "Buttons");
		image.BtnLeave.LText.htmlText = Language.GetHtmlDef("Leave", "Buttons");
	
		var ti:DialogTitleScreen = this;
		image.BtnMore.tabChildren = true;
		image.BtnMore.Btn.onPress = function() {
			ti.Beep();
			this._parent._parent.gotoAndStop(this._parent._parent._currentFrame + 1);
		}
		image.BtnLeave.tabChildren = true;
		image.BtnLeave.Btn.onPress = function() {
			ti.Beep();
			ti.coreGame.HideImages();
			ti.ShowDialogContents();
		}
		mcBase._visible = false;
		Beep();
	}
	
	// Introduction screens
	
	public function DoIntroNext(val:Number, timer:Number)
	{
		if (val != undefined && val > -1) Introduction = val;
		if (Introduction == 12) return;
		
		var bWait:Boolean = !coreGame.config.IsLoaded() || !Language.IsLoaded();
		if (Introduction == 5 && !coreGame.SMAvatar.IsLoaded()) bWait = true;
		if (bWait) {
			if (timer != undefined) return;
			Timers.AddTimerShowWait(
				setInterval(this, "DoIntroNext", 20, -1, Timers.GetNextTimerIdx())
				,undefined,true
			);
			return;
		}
		Timers.RemoveTimer(timer);
		Timers.StopWait();
	
		clearInterval(coreGame.intervalId4);
		trace("DoIntroNext: " + Introduction);
		Beep();
		LeaveDialog();
		
		LoadButton.Hide();
		coreGame.LoadSaveGames._visible = false;
		coreGame.SMAppearance._visible = false;
		
		coreGame.SlaveMakerCreate1._visible = false;
		coreGame.SlaveMakerCreate2._visible = false;
		coreGame.SlaveMakerCreate3._visible = false;
		coreGame.SlaveMakerHousing._visible = false;
		if (Introduction != 11) {
			Backgrounds.HideBackgrounds();
			coreGame.HideImages();
			Backgrounds.ShowIntroBackground();
		} else Backgrounds.ShowIntroBackground(0, 0, 0);
		coreGame.HideAllPeople();
		coreGame.GirlsStory._visible = false;
		coreGame.GirlsStoryTop._visible = false;
		
		NextButton.Hide();
		BackButton.Hide();
		SkipButton.Hide();
		BackButton.Move(573, 571);
		LoadButton.PositionButton(677.5, 549);
		
		if (Introduction == 0) 
		{
			// Fall of the Gods screen
			Introduction = 0.5;
			var image:MovieClip = coreGame.AutoAttachAndPositionMovie("Intro - 1a", 0, 0, 0, 1700, 800);
			Backgrounds.ShowIntroBackgroundBlack();
			var str:String = Language.GetHtml("Intro1a1", "Introduction");
			if (str == "") str = "1252, after the fall of the Gods\r\r";
			image.LText1.htmlText = str;
			str = Language.GetHtml("Intro1a2", "Introduction");
			if (str == "") str = "Kingdom of Mioya\r\r";
			image.LText2.htmlText = str;
			image.enabled = true;
			var ti:DialogTitleScreen = this;
			image.onPress = function() { ti.DoIntroNext(); }
	
			ShowIntroNextButton();
		}
		else if (Introduction == 0.5) 
		{
			// Coda screen
			Introduction = 1;
			var image:MovieClip = coreGame.AutoAttachAndPositionMovie("Intro - 1b", coreGame.config.nScreenXOffset / 4, 0, 0, coreGame.config.GetPublishedStageHeight() * 1.333, coreGame.config.GetPublishedStageHeight());
			Backgrounds.ShowIntroBackgroundBlack();
			var str:String = Language.GetHtml("Intro1b", "Introduction");
			if (str == "") str = "From the Coda Talyanii.\rExcerpt from the Book of Regeneration:\r\r\"Thus did the New Gods stride upon the face of the world, and it was remade in their image.\rYea, and the vault of heaven opened and angels and demons were free to walk among men.\rDivers creatures both boon and foul followed them unto the land, and the people did wonder\rat these marvels.\"";
			image.LText1.htmlText = str;
			image.enabled = true;
			var ti:DialogTitleScreen = this;
			image.onPress = function() { ti.DoIntroNext(); }
			ShowIntroNextButton();
		}
		else if (Introduction == 1) 
		{
			// World Map
			Introduction = 2;
			Backgrounds.ShowIntroBackgroundWhite();
			coreGame.AutoAttachAndShowMovie("World Map (Movie Clip)", 2, 1, coreGame.LoadedMovies);
			AutoLoadImageAndShowMovie("Images/World Map.jpeg", 2, 1, coreGame.LoadedMovies);
			var image:MovieClip = coreGame.AutoAttachAndPositionMovie("Intro - 2", 200 + coreGame.config.nScreenXOffset / 2, 0, 0, 572, 344, coreGame.LoadedMovies);
			image.LText.htmlText = "<b>The Kingdom of Mioya is a little country surrounded by gigantic empires in the middle of the continent.\rDespite her big neighbours, the Kingdom of Mioya became the richest country of all the continent.</b>";
			image._xscale = 100;
			image._yscale = 100;
			ShowIntroNextButton();
			coreGame.intervalId4 = setInterval(this, "Intro2a", 20, image);
		}
		else if (Introduction == 2)
		{
			// Intro page 3
			Introduction = 3;
			Backgrounds.HideIntroBackground();
			coreGame.AutoAttachAndShowMovie("Intro - 3", 2, 1);
			ShowTextBox(3.1, -10, 10, Language.GetHtml("Intro3", "Introduction"), 0);
			AddLargeButton();
			ShowIntroNextButton();
		}
		else if (Introduction == 3)
		{
			Introduction = 4;
			Backgrounds.ShowIntroBackground(0, 0, 60, 0, 0, 0, 0);
			coreGame.AutoAttachAndShowMovie("Intro - 4", 2, 1);
			ShowTextBox(3.1, -10, 10, Language.GetHtml("Intro4", "Introduction"));
			AddLargeButton();			
			ShowIntroNextButton();
		}
		else if (Introduction == 4)
		{
			Backgrounds.ShowIntroBackgroundBlack();
			Introduction = 5;
			coreGame.AutoAttachAndShowMovie("Intro - 5", 2, 1);
			ShowTextBox(3.1, -10, 10, Language.GetHtml("Intro5", "Introduction"));
			AddLargeButton();			
			ShowIntroNextButton();
			coreGame.SlaveNumber = 0;		// for advanced screen
		}
		else if (Introduction == 5) coreGame.DoSlaveMakerCreate1();
		else if (Introduction == 5.05) coreGame.DoSlaveMakerCreate1a();
		else if (Introduction == 5.1) coreGame.DoSlaveMakerCreate2();
		else if (Introduction == 5.2) coreGame.DoSlaveMakerCreate3();
		else if (Introduction == 5.3)
		{
			BackButton.Move(715, 522);
			BackButton.ShowAligned(4);			
			LoadButton.Move(680, 551);
			LoadButton.ShowAligned(4);
			coreGame.currentDialog = new DialogSelectGuildMembership(coreGame);
			coreGame.currentDialog.ViewDialog();
		} 
		else if (Introduction == 6)
		{
			trace("StartSlaveMaker");
			coreGame.StartSlaveMaker();
			SMData = coreGame.SMData;
			
			LoadButton.Hide();
			coreGame.SpecialIndex = 0;
			Introduction = 7;
			BackButton.Move(595, 555);
			BackButton.ShowAligned(4);
			LoadButton.Move(675, 551);
			LoadButton.ShowAligned(4);
			coreGame.currentDialog = new DialogSelectCity(coreGame);
			coreGame.currentDialog.ViewDialog(0);
		} 
		else if (Introduction == 7)
		{
			ShowIntroNextButton();
			if (coreGame.citiesList.GetTotalAvailableCities() == 1) {
				coreGame.Options.SaveOnlyGlobalData();
				coreGame.StartSlaveMaker();
				SMData = coreGame.SMData;
			}
			coreGame.modulesList.eventsSM.ShowSMIntroduction();
			AddLargeButton();
			Introduction = 8;
		} 
		else if (Introduction == 8)
		{
			LoadButton.Hide();
			coreGame.SpecialIndex = 0;
			Introduction = 9;
			coreGame.currentDialog = new DialogSelectHouse(coreGame);
			coreGame.currentDialog.ViewDialog(0);
		}
		else if (Introduction == 9 || Introduction == 9.1)
		{
			coreGame.SpecialIndex = undefined;
			if (Introduction == 9) Introduction = 10;
			coreGame.HouseEvents.HouseIntroduction();
	
			var ti:DialogTitleScreen = this
			coreGame.GirlsStoryTop.BigButton.onPress = function() { ti.DoIntroNext(); }
			coreGame.GirlsStoryTop.GirlsStoryNext.Btn.onPress = function() { ti.DoIntroNext() }
			BackButton.ShowAligned(4);
		}
		else if (Introduction == 10 || Introduction == 9.2)
		{
			Backgrounds.ShowIntroBackground(0, 0, 0, 0, 1, 1, 1);
			Introduction = 11;
			ShowIntroNextButton();
			Backgrounds.ShowSlaveMarket(1);
			coreGame.ShowLastMovie(2, 2);
			
			ShowTextBox(3.1, -10, 10, Language.GetHtml(SMData.GuildMember ? "Intro8Guild" : "Intro8Freelancer", "Introduction"));
			AddLargeButton();			
		}
		else if (Introduction == 11)
		{
			Introduction = 12;
			coreGame.StartNewSlave();
		}
	}
	
	public function Intro2a(image:MovieClip)
	{
		if (Language.IsLoaded()) {
			clearInterval(coreGame.intervalId4);
			image.LText.htmlText = "<b>" + Language.GetHtml("Intro2", "Introduction") + "</b>";
		}
		AddLargeButton();
	}
	
	private function AddLargeButton() : MovieClip
	{
		var img:MovieClip = coreGame.AutoAttachAndShowMovie("Transparent (Movie)", 2, 0, coreGame.LoadedMovies);
		img.enabled = true;
		var ti:DialogTitleScreen = this;
		img.onPress = function() { ti.DoIntroNext(); }
		return img;
	}
	
	private function ShowTextBox(align:Number, xpos:Number, ypos:Number, str:String, clr:Number)
	{
		var image:MovieClip = coreGame.AutoAttachAndShowMovie("Intro - Textbox", 2, align);
		image.LText.wordWrap = true;
		image.LText.autoSize = true;
		image.LText.htmlText = str;
		image._x += xpos;
		image._y += ypos;
		if (clr != undefined) image.LText.textColor = clr;
	}
	
	private function ShowIntroNextButton()
	{
		BackButton.ShowAligned(4);
		NextButton.ShowAligned(4);
		if (Introduction < 6) SkipButton.ShowAligned(15);
	}
	
	public function PressSkipButton()
	{
		coreGame.SlaveNumber = 0;		// for advanced screen
		Introduction = 5;
		DoIntroNext();
	}
	
	public function PressLoadButton()
	{
		coreGame.LoadSave.ViewLoadScreen(true);
	}
	
	public function PressBackButton()
	{
		Beep();
		if (Introduction >= 5.1 && Introduction < 7) {
			coreGame.ClearGeneralArray();
			Introduction = 5;		// 5.05 to preserve details, but coding needed....
			DoIntroNext();
		} else if (Introduction == 5.05) {
			Introduction = 4;
			DoIntroNext();
		} else if (Introduction > 1) {
			if (Introduction == 8) {
				if (coreGame.citiesList.GetTotalAvailableCities() > 1) Introduction = 6;
				else {
					coreGame.ClearGeneralArray();
					Introduction = 5;		// 5.05 to preserve details, but coding needed....
				}
			} else if (Introduction == 9.1) Introduction = 8;
			else if (Introduction == 9.2) Introduction = 9;
			else if (Introduction == 11 && coreGame.Home.HouseType == 7) Introduction = 9.1;
			else if (Introduction == 2) Introduction = 0.5;
			else Introduction -= 2; 
			DoIntroNext();
		} else if (Introduction == 1) {
			Introduction = 0;
			DoIntroNext();
		} else ViewDialog();

	}

}
