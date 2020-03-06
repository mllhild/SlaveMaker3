// DialogSelectCity - select the city to play the game in
//
// Translation status: COMPLETE
//
// Types
// type = 0 - start of game
// type = 1 - moving cities at the end of game
// type = 2 - moving cities during a game in progress

import Scripts.Classes.*;

class DialogSelectCity extends DialogBase {
		
	private var citiesList:CityList;
	
	private var xCity:XML;
	private var cbobj:Object;
	private var nOldCity:Number;
	
	// Constructor
	public function DialogSelectCity(cg:Object)
	{ 
		super(cg.SlaveMakerHousing, cg, 2);
		
		citiesList = coreGame.citiesList;
		
		mcBase.LText2.wordWrap = true;
		mcBase.LText2.autoSize = true;
		
		mcBase.LText1.htmlText = Language.GetHtml("AvailableCities", "City", true);
		mcBase.LText2.htmlText = Language.GetHtml("Instructions", "City");
		
		cbobj = new Object();
		
		mcBase.mcBorder._width = 606;
		mcBase.HouseNameText._x = 626;
		mcBase.HouseNameText._width = 372;
		mcBase.HouseDescriptionText._x = 626;
		mcBase.HouseDescriptionText._width = 372;
		mcBase.House._width = 606;
	}
		
	public function ViewDialog(type:Number)
	{
		nOldCity = -1;
		if (type != 0) nOldCity = citiesList.GetCityIdx(coreGame.currentCity.GetNodeName()) + 1;
		coreGame.currentCity.DestroyModule();
		
		var ti:DialogSelectCity = this;
		cbobj.LoaderC = function(mc:MovieClip) 
		{
			if (mc.loaderror != true) {
				// ignore failed loads
				mc._x = 10;
				mc._y = 62;
				return;
			}
			var mv:String = mc.mv;
			var mv2:String = mv.split("Preview").join("Map").split(".")[0] + ".jpg";
			if (mv2 != mv) ti.AutoLoadImageAndShowMovie(mv2, 1.1, 0, undefined, undefined, ti.cbobj.LoaderC);
		}
		
		coreGame.LargerTextField._visible = false;
		coreGame.EndGame.Hide();
		//Backgrounds.LoadModule("");		// force loading of background swf file for later use
		HideBackgrounds();
		Backgrounds.ShowIntroBackground(17, 60, 100, 0, 0, 0, 0);
		mcBase.mcPurchasePrice._visible = false;
		if (type != 0) coreGame.TitleScreen.BackButton.Hide();
		
		mcBase.House.onPress = function() { ti.SelectCity(); }
		
		mcBase.Left.onPress = function() { ti.CityLeft(); }
		mcBase.Left.onRollOver = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0); }
		mcBase.Left.onRollOut = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0, 0, 0.75, 0.75, 0.75); }

		mcBase.Right.onPress = function() { ti.CityRight(); }
		mcBase.Right.onRollOver = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0); }
		mcBase.Right.onRollOut = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0, 0, 0.75, 0.75, 0.75); }
		
		super.ViewDialog(type);
	}
	
	public function ShowDialogContents() {
		StopHints();
		
		if (nCurrentPage == nOldCity) CityLeft();
		else ShowCity();
		
		mcBase._visible = true;
	}
	
	private function ShowCity()
	{
		var str:String = citiesList.GetAvailableCity(nCurrentPage);
		xCity = new XML();
		coreGame.XMLData.LoadXML("Language/" + coreGame.Language.LangType + "/Cities/" + str + "/City.xml", this, "ShowCity2", xCity);
		
		coreGame.HideImages();
		AutoLoadImageAndShowMovie("Images/Cities/" + str + "/Preview.jpg", 1.1, 0, undefined, undefined, cbobj.LoaderC);
	}
	public function ShowCity2()
	{
		// text information
		coreGame.SlaveMakerHousing.HouseNameText.text = coreGame.Language.GetHtml("City/Name", xCity.firstChild.firstChild);
		coreGame.SlaveMakerHousing.HouseDescriptionText.htmlText = coreGame.Language.GetHtml("City/Description", xCity.firstChild.firstChild, false, -1);
		coreGame.SlaveMakerHousing.HouseDetails.htmlText = coreGame.Language.GetHtml("City/Details", xCity.firstChild.firstChild);
		delete xCity;
		xCity = null;
	}

	public function CityLeft() {
		while (true) {
			nCurrentPage++;
			if (nCurrentPage == nOldCity) continue;
			if (nCurrentPage > citiesList.GetTotalAvailableCities()) {
				nCurrentPage = 0;
				continue;
			}
			break;
		}
		ShowCity();
	}

	public function CityRight() {
		while (true) {
			nCurrentPage--;
			if (nCurrentPage == nOldCity) continue;
			if (nCurrentPage < 1) {
				nCurrentPage = citiesList.GetTotalAvailableCities() + 1;
				continue;
			}
			break;
		}
		ShowCity();
	}

	public function SelectCity()
	{
		coreGame.IntroLoadButton._visible = false;
		coreGame.IntroBackButton._visible = false;
		coreGame.HideImages();
		coreGame.SpecialIndex = 0;
		mcBase._visible = false;
		citiesList.ChangeCity(citiesList.GetAvailableCity(nCurrentPage));
		if (nType == 0) {
			Timers.ShowWait();
			coreGame.Language.ChangeLanguage(false, "CityLanguageUpdate", this);
		} else if (nType == 1) {
			SMMoney(-1000);		// flat cost of move, possibly should be proportional to size of household + base
			LeaveDialog();
			coreGame.EndGame.ShowMenuContents();
		} else {
			Timers.ShowWait();
			SMMoney(-1000);		// flat cost of move, possibly should be proportional to size of household + base
			coreGame.Language.ChangeLanguage(false, "CityLanguageUpdateMove", this);
		}
	}
	
	public function CityLanguageUpdateMove()
	{
		trace("CityLanguageUpdateMove");
		LeaveDialog(); 
		Timers.StopWait();
		if (coreGame.currentCity.Home.HouseType == -1) {
			// No house in the new city
			trace("get a new house now");
			coreGame.currentDialog = new DialogSelectHouse(coreGame);
			coreGame.currentDialog.ViewDialog(3);
		} else {
			// there is a house
			trace("got a house");
			coreGame.currentCity.Initialise();
			coreGame.dspMain.Show();
			coreGame.dspMain.ShowMainButtons();
			coreGame.dspMain.ShowStatisticsTab(0);
		}
	}
	
	public function CityLanguageUpdate() { LeaveDialog(); Timers.StopWait(); coreGame.TitleScreen.DoIntroNext(); }
	
	// Miscellaneous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (keya == 76) coreGame.LoadSave.ViewLoadScreen();
		else if (key == 37) CityLeft();
		else if (key == 39) CityRight();
		else if (key == 13) SelectCity();
		return false;
	}
	
}