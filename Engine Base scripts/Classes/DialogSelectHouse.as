// DialogSelectHouse - select slave makers house
//
// Translation status: COMPLETE
//
// Types
// type = 0 - start of game
// type = 1 - move house
// type = 2 - purchase a new house while moving cities at the end of game
// type = 3 - purchase a new house while moving cities during a game in progress

import Scripts.Classes.*;

class DialogSelectHouse extends DialogBase {
	
	private var nOldHouse:Number;
	
	// Constructor
	public function DialogSelectHouse(cg:Object)
	{ 
		super(cg.SlaveMakerHousing, cg, 2);
		
		mcBase.LText2.wordWrap = true;
		mcBase.LText2.autoSize = true;
		
		mcBase.LText1.htmlText = Language.GetHtml("AvailableHousing", "Housing", true);
		mcBase.LText2.htmlText = Language.GetHtml("Instructions", "Housing");
		
		mcBase.mcBorder._width = 454;
		mcBase.HouseNameText._x = 626 - 152;
		mcBase.HouseNameText._width = 372 + 152;
		mcBase.HouseDescriptionText._x = 626 - 152;
		mcBase.HouseDescriptionText._width = 372 + 152;
		mcBase.House._width = 454;

	}
		
	public function ViewDialog(type:Number)
	{
		var ti:DialogSelectHouse = this;
		
		nOldHouse = type == 0 ? -1 : coreGame.currentCity.Home.HouseType;
		
		coreGame.LargerTextField._visible = false;
		coreGame.EndGame.Hide();
		Backgrounds.LoadModule("");		// force loading of background swf file for later use
		HideBackgrounds();
		Backgrounds.ShowIntroBackground(37, 80, 80, 0, 0, 0, 0);
		if (type == 0) {
			coreGame.TitleScreen.BackButton.Move(595, 555);
			coreGame.TitleScreen.BackButton.ShowAligned(4);
			coreGame.TitleScreen.LoadButton.Move(675, 551);
			coreGame.TitleScreen.LoadButton.ShowAligned(4);
			mcBase.mcPurchasePrice._visible = false;
		} else {
			coreGame.TitleScreen.BackButton.Hide();
			mcBase.mcPurchasePrice._visible = true;
			mcBase.mcPurchasePrice.LPrice.htmlText = Language.GetHtml("Price", "Shopping");
		}
		if (nOldHouse == -1) coreGame.HouseEvents.ChangeHouse(1);
		else coreGame.HouseEvents.ChangeHouse();
		coreGame.lastmc._x = 10;
		coreGame.lastmc._y = 62;
		
		mcBase.House.onPress = function() { ti.SelectHouse(); }
		
		mcBase.Left.onPress = function() { ti.HouseLeft(); }
		mcBase.Left.onRollOver = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0); }
		mcBase.Left.onRollOut = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0, 0, 0.75, 0.75, 0.75); }

		mcBase.Right.onPress = function() { ti.HouseRight(); }
		mcBase.Right.onRollOver = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0); }
		mcBase.Right.onRollOut = function() { ti.coreGame.SetMovieColour(this, 0, 0, 0, 0, 0.75, 0.75, 0.75); }
		
		super.ViewDialog(type);
	}
	
	public function ShowDialogContents() 
	{
		StopHints();
		mcBase._visible = true;
		
		coreGame.HouseEvents.ChangeHouse();
		coreGame.lastmc._x = 10;
		coreGame.lastmc._y = 62;
		
		if (nType != 0) coreGame.ShowLeaveButton(864, 2);
	}

	public function HouseLeft() {
		var maxh:Number = coreGame.HouseEvents.GetTotalHouses();
		var curr:Number;
		
		while (true) {
			curr = coreGame.currentCity.Home.HouseType + 1;
			coreGame.currentCity.Home.InitialiseHouseByNumber(curr);
			if (curr > maxh) {
				coreGame.currentCity.Home.HouseType = 0;
				continue;
			}
			if (coreGame.currentCity.Home.HouseType == nOldHouse) continue;
			if (!coreGame.currentCity.Home.IsAvailable()) continue;
			break;
		};
		coreGame.HouseEvents.ChangeHouse();
		coreGame.lastmc._x = 10;
		coreGame.lastmc._y = 62;
	}

	public function HouseRight() {
		var maxh:Number = coreGame.HouseEvents.GetTotalHouses();
		var curr:Number;
		
		while (true) {
			curr = coreGame.currentCity.Home.HouseType - 1;
			coreGame.currentCity.Home.InitialiseHouseByNumber(curr);
			if (curr < 1) {
				coreGame.currentCity.Home.HouseType = maxh + 1;
				continue;
			}
			if (coreGame.currentCity.Home.HouseType == nOldHouse) continue;
			if (!coreGame.currentCity.Home.IsAvailable()) continue;
			break;
		};
		coreGame.HouseEvents.ChangeHouse();
		coreGame.lastmc._x = 10;
		coreGame.lastmc._y = 62;
	}

	public function SelectHouse()
	{
		trace("SelectHouse: for city " + coreGame.currentCity.ModuleName + " " + nType);
		
		if (nType == 0) {
			// Select a house at start of game play
			coreGame.HouseEvents.ChangeHouse(coreGame.currentCity.Home.HouseType);
			coreGame.HouseEvents.HideImages();
			coreGame.HouseEvents.HideBG();
			Backgrounds.HideBackgrounds();			
			LeaveDialog();
			coreGame.TitleScreen.DoIntroNext();
		} else {
			// Buying the house
			var price:Number = coreGame.currentCity.Home.GetHousePrice();
			if ((SMData.SMGold + coreGame.VarGold) < price) {
				Bloop();
				return;
			}
			SMMoney(price * -1);
			coreGame.HouseEvents.ChangeHouse(coreGame.currentCity.Home.HouseType);
			coreGame.HouseEvents.HideImages();
			coreGame.HouseEvents.HideBG();
			Backgrounds.HideBackgrounds();						
			LeaveDialog();
			if (nType == 1) {
				// Move house within current city at the end of game
				coreGame.EndGame.ShowMenuContents();			
			} else if (nType == 2) {
				// purchase a house when moving cities at end of game
				coreGame.EndGame.ShowMenuContents();			
			} else {
				// purchase a house when moving cities during a game in progress
				Timers.ShowWait();
				coreGame.Language.ChangeLanguage(false, "HouseLanguageUpdate", this);
			}
		}
	}
	
	public function HouseLanguageUpdate()
	{
		Timers.StopWait();
		LeaveDialog();
		trace("HouseLanguageUpdate: for city " + coreGame.currentCity.ModuleName);
		coreGame.currentCity.Initialise();
		coreGame.dspMain.Show();
		coreGame.dspMain.ShowMainButtons();
		coreGame.dspMain.ShowStatisticsTab(0);
	}
	
	public function Cancel()
	{
		coreGame.HouseEvents.ChangeHouse(nOldHouse);
		coreGame.HouseEvents.HideImages();
		coreGame.HouseEvents.HideBG();
		Backgrounds.HideBackgrounds();
		super.LeaveDialog();
	}

	
	// Miscellaneous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (keya == 76) coreGame.LoadSave.ViewLoadScreen();
		else if (key == 37) HouseLeft()
		else if (key == 39) HouseRight();
		else if (key == 13) SelectHouse();
		return false;
	}
	
}