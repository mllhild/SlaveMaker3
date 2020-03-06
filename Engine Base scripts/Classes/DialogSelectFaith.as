// DialogSelectFaith - select slave makers faith
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogSelectFaith extends DialogBase {
		
	// Constructor
	public function DialogSelectFaith(cg:Object)
	{ 
		super(null, cg);
	}
		
	public function ViewDialog()
	{
		super.ViewDialog();

		var ti:DialogSelectFaith = this;
		
		mcBase = coreGame.AutoAttachAndShowMovie("Slave Maker Faith", 2, 2);

		var tempstr:String = Language.GetHtml("NewGods", "Faith") + "\r\r\r\r" + Language.GetHtml("OldGods", "Faith")+ "\r\r\r\r" + Language.GetHtml("NoGods", "Faith");
		mcBase.LReligionsWhite.htmlText = tempstr;
		mcBase.LReligionsBlack.htmlText = tempstr;
		tempstr = Language.GetHtml("NewGodsDetails", "Faith") + "\r\r\r" + Language.GetHtml("OldGodsDetails", "Faith")+ "\r\r\r" + Language.GetHtml("NoGodsDetails", "Faith");
		mcBase.LDetailsWhite.htmlText = tempstr;
		mcBase.LDetailsBlack.htmlText = tempstr;
		mcBase.TitleText.htmlText = Language.GetHtml("Title", "Faith", true);
		mcBase.DetailsText.htmlText = Language.GetHtml("Details", "Faith");
		mcBase.QuestionText.htmlText = Language.GetHtml("Question", "Faith");

		mcBase.FaithNew.onPress = function() {
			ti.UpdateFaith(1);
		}
		mcBase.FaithOld.onPress = function() {
			ti.UpdateFaith(2);
		}
		mcBase.FaithNone.onPress = function() {
			ti.UpdateFaith(3);
		}
		mcBase.DetailsText.wordWrap = true;
		mcBase.DetailsText.autoSize = true;
		
		mcBase._visible = true;
	}
	
	public function ShowDialogContents() {
		StopHints();
	}
		
	function UpdateFaith(faith:Number)
	{
		SMData.ChangeSlaveMakerFaith(faith);
		coreGame.SMAppearance._visible = true;
		coreGame.HideImages();
		coreGame.DoSlaveMakerCreate1a();
		LeaveDialog();
	}
	
	// Miscellaneous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (keya == 49) { UpdateFaith(1); return true; }
		else if (keya == 50) { UpdateFaith(2); return true; }
		else if (keya == 51) { UpdateFaith(3); return true; }
		return false;
	}
	
}