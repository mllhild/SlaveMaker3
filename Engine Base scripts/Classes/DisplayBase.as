// DisplayBase - a general screen/page with interaction
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DisplayBase extends BaseModule {
	
	private var nStartXPos:Number;
	private var nStartYPos:Number;
	private var nStartXScale:Number;
	private var nStartYScale:Number;
	
	// Constructor
	public function DisplayBase(mc:MovieClip, cg:Object)
	{ 
		super(mc, null, cg);
		//trace("DisplayBase: " + mcBase);
		
		nStartXPos = mc._x != undefined ? mc._x : 0;
		nStartYPos = mc._y != undefined ? mc._y : 0;
		nStartXScale = mc._x != undefined ? mc._xscale : 0;
		nStartYScale = mc._y != undefined ? mc._yscale : 0;
		
		mc.tabChildren = true;
		mc._visible = false;
	}

	
	// Show the page
	public function Show()
	{
		InitialiseModule(null);		// force reset of SMData, Backgrounds etc objects, do not change visibilty state of movieclips
		mcBase._visible = true;
	}
	
	// Hide the page
	public function Hide() { mcBase._visible = false; }	
	
	// Shortcut keys
	// - keya is ascii version of keystroke
	// - key is the case insensitive version
	//   eg var keya:Number = key > 96 ? key - 32 : key;
	// - bControl is true if the Shift key is held down
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean { return false; }

	
	//
	// Utility Functions
	// In general no reason to override any of the following functions
	//
	
	// general counting
	private function DoCounted(count:Number, desc:String)
	{
		if (count == 0) return;
		AddText("  " + count + " " + desc);
		if (count > 1) AddText("s");
		AddText("\r\r");
	}
	
	private function CopyTF(txtto:TextField, txtfrm:TextField)
	{
		txtto.htmlText = txtfrm.htmlText;
		txtto.styleSheet = txtfrm.styleSheet;
	}
		
	// enable/disable
	public function Disable()
	{
		mcBase.onRollOver = function() { };
		mcBase.useHandCursor = false;
	}
	public function Enable()
	{
		delete mcBase.onRollOver;
		mcBase.useHandCursor = true;
	}
	
	// Theme
	public function ApplyTheme(cvo:ColourScheme) { }
	
	public function UpdateText(aNode:XMLNode) {	}
	
	
	// visibility
	public function IsShown() : Boolean { return mcBase._visible; }
	
	private function IsHideInitialImages() : Boolean { return false; }

	// Miscellaneous
	public function SetSlave(sdo:Object) { super.SetSlave(sdo); coreGame.sdata = sd; }
	
	// References to remove use of coreGame. prefix
	private function SetButtonDetails(mc:MovieClip, tick:Boolean, available:Boolean, actlabel:String, action:Number, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number, ifunc, irofunc, iroutfunc, fobj:Object) { coreGame.SetButtonDetails(mc, tick, available, actlabel, action, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, fobj); }
	private function SetActDetails(type:Object, tick:Boolean, available:Boolean, actlabel:String, hint:String, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number, ifunc, irofunc, iroutfunc, fobj:Object) : ActInfo { return coreGame.slaveData.ActInfoBase.SetActDetails(type, tick, available, actlabel, hint, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, fobj); }

	private function IsHints() : Boolean { return coreGame.Hints.IsHints(); }
	private function HideHints() { coreGame.Hints.HideHints(); }
	private function StopHints() { coreGame.Hints.StopHints(); }
	public function SetHintText(txt:String) { coreGame.Hints.SetHintText(txt); }
	public function AddHintText(txt:String) { coreGame.Hints.AddHintText(txt); }
	public function ShowHintAdd(txt:String) { coreGame.Hints.ShowHintAdd(txt); }
	public function ShowHint(txt:String, xpos:Number, wid:Number) { coreGame.Hints.ShowHint(txt, xpos, wid); }
	public function ShowHintLang(node:String, base, xpos:Number, wid:Number) { coreGame.Hints.ShowHintLang(node, base, xpos, wid); }
	public function ShowHintLangCR(node:String, base, xpos:Number, wid:Number) { coreGame.Hints.ShowHintLangCR(node, base, xpos, wid); }
	
	private function ShowEquipmentButton(xpos:Number) { coreGame.SelectEquipment.ShowEquipmentButton(xpos); }
	private function HideEquipmentButton() { coreGame.SelectEquipment.HideEquipmentButton(); }
	private function ShowSMEquipmentButton(xpos:Number) { coreGame.SelectSMEquipment.ShowSMEquipmentButton(xpos); }
	private function HideSMEquipmentButton() { coreGame.SelectSMEquipment.HideSMEquipmentButton(); }
}