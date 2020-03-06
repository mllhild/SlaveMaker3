// TabBase - a general tab
//
// note: a close copy of DisplayBase
//
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.geom.ColorTransform;
import flash.geom.Transform;

class TabBase {
	
	// Variables
	public var group:Object;			// core game engine
	
	// the MovieClip this Button is associated with
	public var mcBase:MovieClip;
	
	public var idx:Number;
	
	public var idxChild:Number;
	
	// postion
	private var xpos:Number;
	private var ypos:Number;
	private var nWidth:Number;
	private var nHeight:Number;
	
	private var fobj:Object;
	private var func:String;
	private var rofunc:String;
	
	private var bPushState:Boolean;
		
	// Constructor
	public function TabBase(mc:MovieClip, gp:Object, defBtnlabel:String, icon:String, fobjIN:Object, funcIN:String, rofuncIN:String, iconx:Number, icony:Number, iconrot:Number, iconwidth:Number, iconheight:Number)
	{ 
		group = gp;
		fobj = fobjIN;
		func = funcIN;
		rofunc = rofuncIN;
		idx = -1;
		idxChild = -1;
		
		mcBase = mc;
		mc.tabChildren = true;
		mc.fobj = this;
		xpos = mc._x;
		ypos = mc._y;
		nWidth = mc._width;
		nHeight = mc._height;
		bPushState = undefined;
		
		// set the default state of the button
		InitialiseTab(defBtnlabel, icon, fobj == undefined ? this : fobj, func, rofunc, undefined, iconx, icony, iconrot, iconwidth, iconheight);
		Enable();
	}
	
	// Overloads for tab actions
	
	public function SelectTab() : Boolean
	{
		if (func != undefined) {
			fobj[func]();
			return true;
		}
		return false;
	}
	
	public function RollOverTab() : Boolean
	{
		if (mcBase.mcTab._alpha == 0) mcBase.mcTab._alpha = 10;
		var colorTransformer:ColorTransform = mcBase.mcTab.transform.colorTransform;
		group.coreGame.SetMovieColour(mcBase.mcTab, colorTransformer.redOffset + 40, colorTransformer.greenOffset + 40, colorTransformer.blueOffset + 40);
		mcBase.hinted = true;
		
		if (rofunc != undefined) {
			fobj[rofunc](idx);
			return true;
		}
		return false;
		
	}
	
	public function RollOutTab()
	{
		HideHints();
		if (mcBase.hinted) {
			if (mcBase.mcTab._alpha == 10) mcBase.mcTab._alpha = 0;
			var colorTransformer:ColorTransform = mcBase.mcTab.transform.colorTransform;
			group.coreGame.SetMovieColour(mcBase.mcTab, colorTransformer.redOffset - 40, colorTransformer.greenOffset - 40, colorTransformer.blueOffset - 40);
			mcBase.hinted = false;
		}
	}
	
	// Button state
		
	public function InitialiseTab(actlabel:String, icon:String, fobjIN:Object, funcIN:String, rofuncIN:String, shortcut:String, iconx:Number, icony:Number, iconrot:Number, iconwidth:Number, iconheight:Number)
	{
		var ti:TabBase = this;
		var lab:TextField = mcBase.LText;
		if (mcBase.mcIcon == undefined && actlabel != undefined && actlabel != "") {
			mcBase.tabChildren = true;
			mcBase.alabel = actlabel;
			lab.wordWrap = true;
			lab.autoSize = true;
			lab.htmlText = actlabel;
			if (lab.bottomScroll > 1) lab._y = 0;
			else lab._y = 7.5;
			lab._visible = true;
		}		
		if (icon != undefined && icon != "") {
			if (iconx == undefined) iconx = 25;
			if (icony == undefined) icony = 8;
			if (iconrot == undefined) iconrot = 0;
			if (iconwidth == undefined) iconwidth = 34;
			if (iconheight == undefined) iconheight = 0;
			
			var mc:MovieClip = mcBase.mcIcon;
			if (icon.indexOf("/") == -1) mc = group.coreGame.AttachAndPositionMovie(mc, icon, iconx, icony, iconrot, iconwidth, iconheight, mcBase);
			else mc = group.coreGame.LoadImageAndPositionMovie(mc, "Themes/" + group.coreGame.config.strTheme + "/" + icon,  iconx, icony, iconrot, iconwidth, iconheight, 0, mcBase);
			lab._visible = false;
			mcBase.mcIcon = mc;
		}
		if (fobjIN != undefined) {
			fobj = fobjIN;
			func = funcIN;
			if (rofuncIN != undefined) rofunc = rofuncIN;
		}
	}
	
	public function UpdateLabel(btnlabel:String, icon:String, shortcut:String) { InitialiseTab(btnlabel, icon, undefined, undefined, undefined, shortcut); }
	

	// Position

	public function PositionTab(newx:Number, newy:Number, newwidth:Number, newheight:Number)
	{
		if (newx == undefined) newx = xpos;
		else xpos = newx;
		if (newy == undefined) newy = ypos;
		else ypos = newy;
		if (newwidth == undefined) newwidth = nWidth;
		else nWidth = newwidth;
		if (newheight == undefined) newheight = nHeight;
		else nHeight = newheight;
		
		mcBase._x = newx;
		mcBase._y = newy;
		mcBase._width = newwidth;
		mcBase._height = newheight;
	}
	
	// enable/disable
	public function Disable()
	{
		mcBase.mcTab.enabled = false;
	}
	public function Enable()
	{
		mcBase.mcTab.enabled = true;
	}
	
	
	// visibility
	
	// Show the button
	public function Show(newx:Number, newy:Number, newwidth:Number, newheight:Number)
	{
		PositionTab(newx, newy, newwidth, newheight);
		mcBase._visible = true;
	}
	
	// Hide the tab
	public function Hide() { mcBase._visible = false; }	
	
	// is the tab shown
	public function IsShown() : Boolean { return mcBase._visible; }

	// Push/Pop
	public function Push() {
		if (bPushState == undefined) bPushState = mcBase._visible;
	}	
	public function Pop() {
		if (bPushState != undefined) {
			mcBase._visible = bPushState;
			bPushState = undefined;
		}
	}	

	// Miscellaneous
	
	// References to remove use of group.coreGame. prefix
	private function IsHints() : Boolean { return group.coreGame.Hints.IsHints(); }
	private function HideHints() { group.coreGame.Hints.HideHints(); }
}