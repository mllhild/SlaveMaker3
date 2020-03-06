// ButtonBase - a general button
//
// nooe a close copy of DisplayBase
//
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.geom.ColorTransform;
import flash.geom.Transform;

class ButtonBase {
	
	// Variables
	public var coreGame:Object;			// core game engine
	
	// the MovieClip this Button is associated with
	public var mcBase:MovieClip;
	
	// postion
	private var xpos:Number;
	private var ypos:Number;
	private var nWidth:Number;
	private var nHeight:Number;

		
	// Constructor
	public function ButtonBase(mc:MovieClip, cg:Object, defBtnlabel:String, fobj:Object, func:String, rofunc:String)
	{ 
		coreGame = cg;
		
		mcBase = mc;
		mc.tabChildren = true;
		mc._visible = false;
		mc.fobj = this;
		xpos = mc._x;
		ypos = mc._y;
		nWidth = mc._width;
		nHeight = mc._height;
		
		// set the default state of the button
		InitialiseButton(false, true, defBtnlabel, undefined, fobj == undefined ? this : fobj, func, rofunc);
		Enable();
	}
	
	// Overloads for button actions
	
	public function PressButton()
	{
		mcBase.Btn.onPress();
	}
	
	public function RollOverButton()
	{
		mcBase.alphao = mcBase._alpha;
		if (mcBase._alpha == 0) mcBase._alpha = 10;
		else mcBase._alpha = 80;
		mcBase.hinted = true;
	}
	
	public function RollOutButton()
	{
		HideHints();
		if (!mcBase.hinted) return;
		mcBase._alpha = mcBase.alphao;
		mcBase.hinted = false;
	}
	
	// Button state
		
	public function InitialiseButton(tick:Boolean, available:Boolean, actlabel:String, action:Number, fobj:Object, func:String, rofunc:String, routfunc:String, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number)
	{
		var ti:ButtonBase = this;
		if (actlabel != undefined && actlabel != "") {
			mcBase.tabChildren = true;
			mcBase.alabel = actlabel;
			var lab:TextField = mcBase.LText;
			if (lab == undefined) lab = mcBase.ActLabel;
			if (lab == undefined) lab = mcBase.Label;
			if (lab != undefined) {
				lab.htmlText = actlabel;
				if (lab.bottomScroll > 1) lab._y = 0;
				else lab._y = lab == mcBase.LText ? 5 : 7;
			}
		}
		
		if (action != undefined) mcBase.curract = action;
		
		if (fobj != undefined) {
			mcBase.fobj = fobj;
			var btn:MovieClip = mcBase.ActButton;
			if (btn == undefined) btn = mcBase.Btn;
			if (btn == undefined) btn = mcBase;
			if (func == undefined) {
				btn.onPress = function() {
					ti.coreGame.NewPlanningAction(this._parent.curract, false);
				}
			} else {
				mcBase.func = func;
				if (fobj[func] != undefined) btn.onPress = function() { ti.mcBase.fobj[ti.mcBase.func](); }
				else if (this[func] != undefined) btn.onPress = function() { ti[ti.mcBase.func](); }
				else if (coreGame[func] != undefined) btn.onPress = function() { ti.coreGame[ti.mcBase.func](); }
			}
			if (routfunc != undefined) {
				mcBase.routfunc = routfunc;
				if (fobj[routfunc] != undefined) btn.onRollOut = function() { ti.mcBase.fobj[ti.mcBase.routfunc](); }
				else if (this[routfunc] != undefined) btn.onRollOut = function() { ti[ti.mcBase.routfunc](); }
				else if (coreGame[routfunc] != undefined) btn.onRollOut = function() { ti.coreGame[ti.mcBase.routfunc](); }
			} else btn.onRollOut = function() { ti.RollOutButton(); }
			if (rofunc == undefined) {
				btn.onRollOver = function() {
					if (!ti.coreGame.Hints.IsHints() || ti.coreGame.AskQuestions._visible || ti.coreGame.YesEvent._visible) return;
					ti.RollOverButton();
				}
			} else {
				mcBase.rofunc = rofunc;
				if (fobj[rofunc] != undefined) btn.onRollOver = function() { ti.mcBase.fobj[ti.mcBase.rofunc](); }
				else if (this[rofunc] != undefined) btn.onRollOver = function() { ti[ti.mcBase.rofunc](); }
				else if (coreGame[rofunc] != undefined) btn.onRollOver = function() { ti.coreGame[ti.mcBase.rofunc](); }
			}
		}
		
		if (cost != undefined) mcBase.cost = cost;		
		if (aduration != undefined) mcBase.aduration = aduration;
		if (astart != undefined) mcBase.astart = astart;
		if (aend != undefined) mcBase.aend = aend;
		
		SetButtonDetails(tick, available);
			
		if (shortcut != undefined) mcBase.ShortcutLabel.htmlText = "<font color='#0000FF'>" + shortcut + "<font color='#000000'>";
	}

	public function SetButtonDetails(tick:Boolean, available:Boolean, alphav:Number, bshow:Boolean)
	{
		if (available != undefined && mcBase.NotAvailable != undefined) mcBase.NotAvailable._visible = !available;
		if (tick != undefined && mcBase.Tick != undefined) mcBase.Tick._visible = tick;
		mcBase._visible = bshow == undefined ? true : bshow;
		
		// for act buttons only change the colour of the button
		if (coreGame.config.bColoursOn && mcBase.ActButton != undefined) {
			if (mcBase._parent != coreGame.ShopMenu && mcBase._parent != coreGame.VisitMenu) coreGame.ApplyColourBtn(mcBase.ActButton, -20);
		}
		
		if (alphav != undefined) mcBase._alpha = alphav;
	}
	
	public function UpdateLabel(btnlabel:String, shortcut:String) { InitialiseButton(undefined, undefined, btnlabel, undefined, undefined, undefined, undefined, undefined, shortcut); }
	

	// Position
	public function Move(newx:Number, newy:Number, newwidth:Number, newheight:Number)
	{
		if (newx != undefined) xpos = newx;
		if (newy != undefined) ypos = newy;
		if (newwidth != undefined) nWidth = newwidth;
		if (newheight != undefined) nHeight = newheight;
		PositionButton();
	}

	public function PositionButton(newx:Number, newy:Number, newwidth:Number, newheight:Number)
	{
		if (newx == undefined) newx = xpos;
		if (newy == undefined) newy = ypos;
		if (newwidth == undefined) newwidth = nWidth;
		if (newheight == undefined) newheight = nHeight;
		
		mcBase._x = newx;
		mcBase._y = newy;
		mcBase._width = newwidth;
		mcBase._height = newheight;
	}
	
	// enable/disable
	public function Disable()
	{
		var btn:MovieClip = mcBase.ActButton;
		if (btn == undefined) btn = mcBase.Btn;
		if (btn == undefined) btn = mcBase;

		btn.enabled = false;
	}
	public function Enable()
	{
		var btn:MovieClip = mcBase.ActButton;
		if (btn == undefined) btn = mcBase.Btn;
		if (btn == undefined) btn = mcBase;

		btn.enabled = true;
	}
	
	
	// visibility
	
	// Show the button
	public function Show(newx:Number, newy:Number, newwidth:Number, newheight:Number)
	{
		PositionButton(newx, newy, newwidth, newheight);
		mcBase._visible = true;
		RollOutButton();
	}
	public function ShowAligned(align:Number)
	{
		// align =	1 - center horizontal
		//			2 - left
		//			3 - right
		//			4 - bottom right	
		//			5 = top left
		//			15 = bottom left
		//			16 = center vertical right
		//			17 = center vertical left
		switch(align) {
			case 1: mcBase._x = xpos + (coreGame.config.nScreenXOffset / 2); break;
			case 3: mcBase._x = xpos + coreGame.config.nScreenXOffset; break;
			case 4: 
				mcBase._x = xpos + coreGame.config.nScreenXOffset;
				mcBase._y = ypos + coreGame.config.nScreenYOffset;
				break;
			case 15:
				mcBase._x = xpos;
				mcBase._y = ypos + coreGame.config.nScreenYOffset;
				break;			
		}
		mcBase._visible = true;
		RollOutButton();
	}	
	
	// Hide the button
	public function Hide() { mcBase._visible = false; }	
	
	// is the button visible
	public function IsShown() : Boolean { return mcBase._visible; }

	
	// Miscellaneous
	
	// References to remove use of coreGame. prefix
	private function IsHints() : Boolean { return coreGame.Hints.IsHints(); }
	private function HideHints() { coreGame.Hints.HideHints(); }
}