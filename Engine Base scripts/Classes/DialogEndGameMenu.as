// DialogEndGameMenu - end game menu
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogEndGameMenu extends DialogBase {
	
	private var lat:String;
		
	// Constructor
	public function DialogEndGameMenu(cg:Object)
	{ 
		super(cg.mcEndGameMenu, cg);
	}
		
	public function ViewDialog()
	{
		lat = coreGame.LargerText + "";
		
		super.ViewDialog();

		var ti:DialogEndGameMenu = this;
		mcBase.BtnRetire.tabChildren = true;
		mcBase.BtnRetire.Btn.onPress = function() {
			ti.coreGame.RetireSlaveMaker();
		}
		mcBase.BtnNewSlave.tabChildren = true;
		mcBase.BtnNewSlave.Btn.onPress = function() {
			ti.coreGame.StartNewSlave();
		}
		mcBase.BtnSandbox.tabChildren = true;
		mcBase.BtnSandbox.Btn.onPress = function() {
			ti.AskSandboxChange();
		}
		mcBase.BtnComplete.tabChildren = true;
		mcBase.BtnComplete.Btn.onPress = function() {
			ti.coreGame.AskCompleteTraining();
		}
		mcBase.BtnChangeHouse.tabChildren = true;
		mcBase.BtnChangeHouse.Btn.onPress = function() {
			ti.coreGame.HouseEvents.MoveHouse();
		}
	
		mcBase.RetireText.LText.htmlText = Language.GetHtml("RetireDescription", "SlaveMarket");
		mcBase.CompleteText.LText.htmlText = Language.GetHtml("CompleteDescription", "SlaveMarket");
		mcBase.SandboxText.LText.htmlText = Language.GetHtml("SandboxDescription", "SlaveMarket");
		mcBase.PurchaseText.LText.htmlText = Language.GetHtml("PurchaseDescription", "SlaveMarket");
		mcBase.NewSlaveText.LText.htmlText = Language.GetHtml("NewSlaveDescription", "SlaveMarket");
		mcBase.ChangeHouseText.LText.htmlText = Language.GetHtml("ChangeHouseDescription", "SlaveMarket");

		mcBase.BtnRetire.Label.htmlText = Language.GetHtml("Retire", "Buttons", false, -1, "R");
		mcBase.BtnComplete.Label.htmlText = Language.GetHtml("Complete", "Buttons", false, -1, "C");
		mcBase.LPurchaseSlave.Label.htmlText = Language.GetHtml("PurchaseSlave", "Buttons", false, -1, "P");
		mcBase.BtnNewSlave.Label.htmlText = Language.GetHtml("NewSlave", "Buttons", false, -1, "N");
		mcBase.BtnSandbox.Label.htmlText = Language.GetHtml("Sandbox", "Buttons", false, -1, "S");
		mcBase.BtnChangeHouse.Label.htmlText = Language.GetHtml("ChangeHouse", "Buttons", false, -1, "H");	
	}
	
	public function ShowDialogContents() 
	{
		StopHints();
		mcBase._visible = true;
		
		HideBackgrounds();
		coreGame.Items.HideItems();
		coreGame.HidePlanningNext();
		coreGame.HideMainButtons();
		coreGame.HideImages();
		coreGame.HideSlaveActions();
		coreGame.HideAllPeople();
		
		mcBase.BtnSandbox._visible = !coreGame.SandboxMode;
		mcBase.SandboxText._visible = !coreGame.SandboxMode;
		mcBase.BtnNewSlave._visible = true;
		mcBase.NewSlaveText._visible = true;
		mcBase.BtnChangeHouse._visible = coreGame.SpecialIndex > 0;
		mcBase.ChangeHouseText._visible = coreGame.SpecialIndex > 0;

		coreGame.mcEndGame._visible = true;
		coreGame.EndGame.HideScore();
		coreGame.mcEndGame.TextBackground._visible = true;
		coreGame.mcEndGame.ChainClip._visible = true;
		coreGame.EndGame.UpdateScore();
		coreGame.EndGame.HideEndingNext();
		
		coreGame.GeneralTextField._visible = false;
		Backgrounds.ShowIntroBackground();
		
		coreGame.UpdateSlaveMaker();
		coreGame.HideLargerText();
		coreGame.ShowGeneralText(true);
		coreGame.ShowLargerText(true);
		
		coreGame.EndGame.mcBase.SaveButton._visible = true;
		coreGame.EndGame.mcBase.LoadButton._visible = true;
		
		Backgrounds.ShowSlaveMarket();
		
		AddText(lat);

	}

	public function AskSandboxChange()
	{
		coreGame.EndGame.HideScore();
		coreGame.mcEndGame.TextBackground._visible = true;
		SetText(Language.GetHtml("ChangeSandbox", "SlaveMarket") + "\r\r");
		DoYesNoEventXY(12);
		
		coreGame.ShowLargerText(true);
		AddText(lat);
	}
		
	public function ChangeSandbox()
	{
		coreGame.EndGame.HideScore();
		coreGame.SandboxMode = true;
		mcBase.BtnSandbox._visible = false;
		mcBase.SandboxText._visible = false;
		coreGame.ShowLargerText(true);
		coreGame.mcEndGame.TextBackground._visible = true;
		AddText(lat);
		BlankLine();
		AddText(Language.GetHtml("NowSandbox", "SlaveMarket"));
	}
	
	
	// Events
	
	public function DoEventYes() : Boolean
	{
		switch (coreGame.NumEvent) {
			// 12 - Sandbox mode
			case 12:
				ChangeSandbox();
				return true;
		}
		return false;
	}
	
	public function DoEventNo() : Boolean
	{
		switch (coreGame.NumEvent) {
			// 12 - Sandbox mode
			case 12:
				ShowDialogContents();
				return true;
		}
		return false;
	}	
	
	// Miscellaneous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 72:
				coreGame.HouseEvents.MoveHouse();
				return true;
			case 76: 
				coreGame.LoadSave.ViewLoadScreen();
				return true;
			case 78:
				coreGame.StartNewSlave();
				return true;
			case 82:
				coreGame.RetireSlaveMaker();
				return true;
			case 83:
				coreGame.LoadSave.ViewSaveScreen();
				return true;
			case 88:
				AskSandboxChange();
				return true;
		}
		return false;
	}
	
}