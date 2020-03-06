// DialogHouseInformation - House Information
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogHouseInformation extends DialogBase {
		
	private var checkboxListenerTentacleSafe:Object;
	private var Home:HouseDetails;
	
	// Constructor
	public function DialogHouseInformation(cg:Object)
	{ 
		super(cg.HouseMenu, cg);

		checkboxListenerTentacleSafe = new Object();
		var ti:DialogHouseInformation = this;
		checkboxListenerTentacleSafe.click = function(cbObj:Object) {
			if (cbObj.target.selected) {
				ti.Home.AddQuality("TentacleSafe");
				ti.mcBase.TentacleSafe.label = " " + ti.Language.GetHtml("TentacleSafeYes", "Morning");
			} else {
				ti.Home.RemoveQuality("TentacleSafe");
				ti.mcBase.TentacleSafe.label = " " + ti.Language.GetHtml("TentacleSafeNo", "Morning");
			}
		};
	
		mcBase.TentacleSafe.addEventListener("click", checkboxListenerTentacleSafe);
		mcBase.TentacleSafe.setStyle("symbolBackgroundColor", "0xCCFFCC"); 
		mcBase.TentacleSafe.setStyle("symbolBackgroundDisabledColor", "0xCCFFCC"); 
		mcBase.TentacleSafe.setStyle("color", "0");
		mcBase.TentacleSafe.setStyle("fontSize", "22"); 
	}
	
	public function ViewDialog()
	{
		Home = coreGame.currentCity.Home;
		SetSlave(coreGame.slaveData);
		mcBase.HouseIncomeLabel.htmlText = Language.GetHtml("Income", "Housing", true);
		mcBase.HouseUpkeepLabel.htmlText = Language.GetHtml("Upkeep", "Housing", true);
		mcBase.HouseOccupantsLabel.htmlText = Language.GetHtml("Occupants", "Housing", true);
		mcBase.LTotal1.htmlText = Language.GetHtml("Total", "Housing", true);
		mcBase.LTotal2.htmlText = Language.GetHtml("Total", "Housing", true);
		
		super.ViewDialog();
	}
	
	public function SetGameTabs()
	{
		coreGame.dspMain.HideGameTabs();
	}
	
	public function ShowDialogContents()
	{
		coreGame.HideMenus();
		
		super.ShowDialogContents();
				
		Beep();
		coreGame.HideDresses();
		coreGame.HidePeople();
		HideEquipmentButton();
		coreGame.SMEquipmentButton._visible = false;
		
		SetText("");
		
		coreGame.dspMain.SelectGameTab(5);
		SMData.ShowSlaveMaker();
		
		Backgrounds.ShowOverlay(0xCCFFCC);
		coreGame.HouseEvents.ShowHouse();
		coreGame.lastmc._x = 18;
		coreGame.lastmc._y = 14;
		coreGame.lastmc._width = 251;
		coreGame.lastmc._height = 188;
		
		// text information
		mcBase.HouseDescriptionText.htmlText = Language.GetHtml("Description", Home.xNode, false, -1);
		mcBase.HouseDetails.htmlText = Language.GetHtml("Details", Home.xNode);
		mcBase.HouseNameText.text = Home.HouseName;
		
		coreGame.genNumber = Home.CalculateUpkeepIncome();
		coreGame.genNumber2 = SMData.GetTotalChildren(SMData.SMSpecialEvent == 2) + SMData.TotalSMChildren;
		if (coreGame.genNumber2 > 0) mcBase.HouseOccupants.htmlText = coreGame.UpdateMacros(Language.GetHtml("UpkeepTotalPeople", "Housing"));
		else mcBase.HouseOccupants.htmlText = coreGame.genNumber;
	
		coreGame.genNumber2 = Math.ceil(coreGame.genNumber * 0.1);
		coreGame.Pay = int(Home.currUpkeep - Home.hUpkeep - coreGame.genNumber2);
		mcBase.HouseUpkeepCalc.htmlText = coreGame.UpdateMacros(Language.GetHtml("UpkeepTotals", "Housing"));

		mcBase.HouseUpkeep.htmlText = int(Home.currUpkeep) + coreGame.GP;
		
		// income
		mcBase.HouseIncomeCalc.htmlText = coreGame.UpdateMacros(Language.GetHtml("IncomeTotal", "Housing"));
		mcBase.HouseIncome.htmlText = Home.currIncome + coreGame.GP;
		
		// basic text
		SetText(Language.GetHtml("HouseHint", "Housing") + Home.HouseName + "\r\r");	
		ShowOtherHouseDetails();
		
		// Tentacles	
		if (SMData.sTentacleExpert != 0 || coreGame.AssistantData.sTentacleExpert != 0) {
			if (Home.HasQuality("TentacleSafe")) mcBase.TentacleSafe.label = " " + Language.GetHtml("TentacleSafeYes", "Morning");
			else mcBase.TentacleSafe.label = " " + Language.GetHtml("TentacleSafeNo", "Morning");
			mcBase.TentacleSafe.selected = Home.HasQuality("TentacleSafe");
			mcBase.TentacleSafe.visible = true;
		} else mcBase.TentacleSafe.visible = false;
		mcBase.TentacleSafe.invalidate();
	
		coreGame.ShowLeaveButton();

	}
	
	public function ShowOtherHouseDetails()
	{
		coreGame.ShowLargerText();
		AddText("<b>" + Language.GetHtml("Areas", "Housing") + "</b>\r");
		AddText("\r  " + Language.GetHtml("Kitchen", "Housing") + ": " + Home.GetAreaType(Home.hKitchen));
		AddText("\r  " + Language.GetHtml("Library", "Housing") + ": " + Home.GetAreaType(Home.hLibrary));
		AddText("\r  " + Language.GetHtml("Dungeon", "Housing") + ": " + Home.GetAreaType(Home.hDungeon));	
		AddText("\r  " + Language.GetHtml("MagicalWards", "Housing") + ": " + Home.GetAreaType(Home.hWards));
		if (Home.hStables || Home.hMilkBarn) {
			AddText("\r\r<b>" + Language.GetHtml("SpecialPlaces", "Housing") + "</b>\r");
			if (Home.hStables) AddText("\r  " + Language.GetHtml("PonygirlStables", "Housing") + ": " + (Home.hStables ? Language.GetHtml("Yes", "Buttons") : Language.GetHtml("No", "Buttons")));
			if (Home.hMilkBarn) AddText("\r  " + Language.GetHtml("Barn", "Housing") + ": " + (Home.hMilkBarn ? Language.GetHtml("Yes", "Buttons") : Language.GetHtml("No", "Buttons")));
		}
		AddText("\r\r<b>" + Language.GetHtml("Others", "SlaveMarket") + "</b>\r");
		AddText("\r  " + Language.GetHtml("DaysOccupied", "Housing") + ": " + (Home.DaysOccupied + 1) + " " + Language.GetHtml("Days", "Other"));
	
		coreGame.SlaveGirl.ShowOtherHouseDetails();
		Language.XMLData.XMLEvent("ShowOtherHouseDetails", false, true);					
	}

}