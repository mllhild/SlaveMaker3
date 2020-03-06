// DialogBase - a general screen/page with interaction
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogBase extends DisplayBase {

	private var nCurrentPage:Number;
	private var nTotPages:Number;
	private var oldDialog:Object;
	private var nType:Number;
	
	// align =	1 - center horizontal
	//			2 - left
	//			3 - right
	//			4 - bottom right	
	//			5 = top left
	//			15 = bottom left
	//			16 = center vertical right
	//			17 = center vertical left
	private var nAlign:Number;
		
	// Constructor
	public function DialogBase(mc:MovieClip, cg:Object, align:Number)
	{ 
		super(mc, cg);
		nAlign = align;
	}

	
	// Show the Dialog
	
	public function ViewDialog(type:Number)
	{
		InitialiseModule(null);		// force reset of SMData, Backgrounds etc objects, do not change visibilty state of movieclips
		if (UseCurrentDialog()) {
			oldDialog = coreGame.currentDialog;
			coreGame.currentDialog = this;
		}
		nCurrentPage = 1;
		nType = type == undefined ? 0 : type;

		coreGame.mcMain.MainWindowButton._visible = false;
		coreGame.TakeAWalkMenu._visible = false;
		mcBase._xscale = nStartXScale;
		mcBase._yscale = nStartYScale;
		var sm:Number = coreGame.config.GetScreenScale();
		
		switch(nAlign) {
			case 1:
				mcBase._xscale = nStartXScale * sm;
				mcBase._yscale = nStartYScale * sm;
				mcBase._x = nStartXPos + (coreGame.config.GetPublishedStageWidth() - mcBase._width) / 2;
				mcBase._y = nStartYPos + (coreGame.config.GetPublishedStageHeight() - mcBase._height) / 2;
				break;
			case 2:
				mcBase._xscale = nStartXScale * sm;
				mcBase._yscale = nStartYScale * sm;
				mcBase._x = 0;
				mcBase._y = 0;
				break;
			case 3:
				mcBase._xscale = nStartXScale * sm;
				mcBase._yscale = nStartYScale * sm;			
				mcBase._x = nStartXPos + (coreGame.config.GetPublishedStageWidth() - mcBase._width);
				mcBase._y = 0;
				break;
			case 4: 
				mcBase._xscale = nStartXScale * sm;
				mcBase._yscale = nStartYScale * sm;
				mcBase._x = nStartXPos + (coreGame.config.GetPublishedStageWidth() - mcBase._width);
				mcBase._x = nStartXPos + (coreGame.config.GetPublishedStageHeight() - mcBase._height);
				break;
		}
		
		ShowDialogContents();
	}
	
	public function ShowDialogContents(notext:Boolean)
	{
		StopHints();
		mcBase._visible = true;
		if (UseCurrentDialog()) coreGame.currentDialog = this;
		HideBackgrounds();
		coreGame.Items.HideItems();
		coreGame.HidePlanningNext();
		coreGame.dspMain.HideMainButtons();
		coreGame.HideSlaveActions();
		if (UsedDuringGame()) {
			coreGame.HideImages();
			coreGame.dspMain.Show();
		} else coreGame.dspMain.Hide();
						
		nTotPages = GetTotalPages();
	}
	
	// overtide to set the tabs viaible for this dialog
	public function SetGameTabs()
	{
	}
	
	public function Cancel()
	{
		LeaveDialog();
	}
	
	// Done, close the dialog
	public function LeaveDialog()
	{
		mcBase._xscale = nStartXScale;
		mcBase._yscale = nStartYScale;
		mcBase._x = nStartXPos;
		mcBase._y = nStartYPos;
		Hide();
		if (UseCurrentDialog()) coreGame.currentDialog = oldDialog;
	}
	
	
	// for multiple page dialogues
	public function GetTotalPages() : Number { return 1; }
	public function GetCurrentPage() : Number { return nCurrentPage; }
	public function GetTotalItemsSold() : Number { return 1; }


	// Events
	public function DoEventNext() : Boolean { return false; }

	public function DoEventYes() : Boolean { return false; };

	public function DoEventNo() : Boolean { return false; };


	//
	// Utility Functions
	// In general no reason to override any of the following functions
	//		

	// currency
	public function IsCurrent() : Boolean { return coreGame.currentDialog == this; }

	private function UseCurrentDialog() : Boolean { return true; }
	private function UsedDuringGame() : Boolean { return true; }
}