// GameItemState - a single item for the game
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class GameItemState
{
	public var nItem:Number;
	public var strLabel:String;
	public var bShown:Boolean;
	public var shortcut:String;
	public var mc:MovieClip;
	
	public function GameItemState(item:Number) {
		nItem = item;
		strLabel = "";
		bShown = false;
		shortcut = "";
		mc = null;
	}
	
	public function SetItemState(str:String, shown:Boolean, short:String)
	{
		if (str != undefined) strLabel = str + "";
		if (shown != undefined) bShown = shown;
		if (short != "" && short != undefined) shortcut = short + "";
	}

}