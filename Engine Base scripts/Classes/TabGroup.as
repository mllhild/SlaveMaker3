// TabGroup - a general tab
//
// note: a close copy of DisplayBase
//
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.geom.ColorTransform;
import flash.geom.Transform;

class TabGroup {
	
	// Variables
	public var coreGame:Object;			// core game engine
	
	// the MovieClip this Button is associated with
	public var arTabs:Array;
	
	private var clrSelected:Number
	private var clrNotSelected:Number
	private var clrTextSelected:Number
	private var clrTextNotSelected:Number
	
	private var fobj:Object;
	private var func:String;
	private var rofunc:String;
	
	private var idxSelected:Number;
	private var idxSubSelected:Number;
		
	// Constructor
	public function TabGroup(cg:Object, clrS:Number, clrN:Number, fobjIN:Object, funcIN:String, rofuncIN:String)
	{ 
		coreGame = cg;
		UpdateTabColours(clrS, clrN);
		fobj = fobjIN;
		func = funcIN;
		rofunc = rofuncIN;
		idxSelected = -1;
		idxSubSelected = -1;
		
		arTabs = new Array();
	}
	
	// What tab is selected currently
		
	public function GetTab(tbo) : TabBase
	{
		var tb:TabBase = null;
		if (tbo == undefined && idxSelected != -1) tbo = idxSelected;
		if (typeof(tbo) == "number") {
			var idx:Number = Number(tbo);
			if (idx < arTabs.length) tb = arTabs[idx];
			else return null;
		} else tb = tbo;
		return tb
	}
	
	public function GetCurrentTab() : TabBase {	return GetTab(idxSelected);	}
	public function GetCurrentTabIdx() : Number { return idxSelected; }

	public function GetCurrentSubTabIdx() : Number { return idxSubSelected; }
	public function SetCurrentSubTabIdx(idx:Number) { idxSubSelected = idx; }

	// Adding a new tab to the group
	
	public function AddTab(mc:MovieClip, strLabel:String, icon:String, newx:Number, newy:Number, newwidth:Number, newheight:Number, iconx:Number, icony:Number, iconrot:Number, iconwidth:Number, iconheight:Number) : TabBase
	{
		var tb:TabBase = new TabBase(mc, this, strLabel, icon, undefined, undefined, undefined, iconx, icony, iconrot, iconwidth, iconheight);
		return AddTabObject(tb, newx, newy, newwidth, newheight);
	}
	
	public function AddTabObject(tb:TabBase, newx:Number, newy:Number, newwidth:Number, newheight:Number) : TabBase
	{
		var mc:MovieClip = tb.mcBase;
		mc.tb = tb;
		tb.PositionTab(newx, newy, newwidth, newheight);
		
		var ti:TabGroup = this;
		mc.mcTab.onPress = function() { 
			var tb:TabBase = this._parent.tb;
			tb.group.SelectTab(tb);
		}
		mc.mcTab.onRollOver = function() { 
			var tb:TabBase = this._parent.tb;
			tb.group.RollOverTab(tb);
		}
		mc.mcTab.onRollOut = function() { 
			var tb:TabBase = this._parent.tb;
			tb.group.RollOutTab(tb);
		}
		
		var idx:Number = arTabs.push(tb);
		tb.idx = idx - 1;
		return tb;
	}
	
	// tab actions
	
	public function SelectTabUI(tbo) : TabBase
	{
		var tb:TabBase;
		
		for (var so in arTabs) {
			tb = arTabs[so];
			tb.mcBase.hinted = false;
			coreGame.SetMovieColourARGB(tb.mcBase.mcTab, clrNotSelected);
			if (clrTextNotSelected != undefined) tb.mcBase.LText.textColor = clrTextNotSelected;
		}
		tb = GetTab(tbo == undefined ? idxSelected : tbo);
		if (tb != null) {		
			coreGame.Beep();
			idxSelected = tb.idx;
			coreGame.SetMovieColourARGB(tb.mcBase.mcTab, clrSelected);
			if (clrTextSelected != undefined) tb.mcBase.LText.textColor = clrTextSelected;
			tb.Show();
		}
		return tb;
	}
	public function SelectTab(tbo)
	{
		var oSel = idxSelected;
		var tb:TabBase = SelectTabUI(tbo);
		if (tb == null) return;
		
		if (tb.SelectTab()) return;
		if (func != undefined) fobj[func](idxSelected, oSel);
	}
	
	public function RollOverTab(tbo)
	{
		var tb:TabBase = GetTab(tbo);
		if (tb.RollOverTab()) return;
		
		if (rofunc != undefined) fobj[rofunc](tb.idx);
	}
	
	public function RollOutTab(tbo)
	{
		GetTab(tbo).RollOutTab();
	}
	
	// tab state
	
	public function UpdateTabColours(clrS:Number, clrN:Number, clrTS:Number, clrTN:Number)
	{ 
		clrTextSelected = clrTS;
		clrTextNotSelected = clrTN;
		clrSelected = clrS;
		if (clrN != undefined) clrNotSelected = clrN;
		else {
			// Use a darker shade for de-selected
			var red:Number = (clrS >> 16) & 255;
			red -= 20;
			if (red < 0) red = 0;
			var green:Number = (clrS >> 8) & 255;
			green -= 20;
			if (green < 0) green = 0;
			var blue:Number = clrS & 255;
			blue -= 20;
			if (blue < 0) blue = 0;
			clrNotSelected = (red * 65536) + (green * 256) + blue;
		}
		var tb:TabBase;
		for (var so in arTabs) {
			tb = arTabs[so];
			if (tb.idx == idxSelected) {
				coreGame.SetMovieColourARGB(tb.mcBase.mcTab, clrSelected);
				if (clrTextSelected != undefined) tb.mcBase.LText.textColor = clrTextSelected;
			} else {
				coreGame.SetMovieColourARGB(tb.mcBase.mcTab, clrNotSelected);
				if (clrTextNotSelected != undefined) tb.mcBase.LText.textColor = clrTextNotSelected;				
			}
		}
	}
			
	public function UpdateTabLabel(tbo, btnlabel:String, icon:String, shortcut:String)
	{
		GetTab(tbo).UpdateLabel(btnlabel, icon, shortcut);
	}
	
	
	// enable/disable
	public function DisableTab(tbo)	{ GetTab(tbo).Disable(); }
	public function EnableTab(tbo) { GetTab(tbo).Enable(); 
	}
	public function DisableAllTabs()
	{
		for (var so in arTabs) {
			var tb:TabBase = arTabs[so];
			tb.Disable();
		}
	}
	public function EnableAllTabs()
	{
		for (var so in arTabs) {
			var tb:TabBase = arTabs[so];
			tb.Enable();
		}		
	}	
	
	// visibility/Position
	
	public function ShowTab(tbo, newx:Number, newy:Number, newwidth:Number, newheight:Number)
	{
		GetTab(tbo).Show(newx, newy, newwidth, newheight);
	}
	
	public function HideTab(tbo)
	{ 
		GetTab(tbo).Hide();
	}
	
	public function ShowAllTabs()
	{
		for (var so in arTabs) {
			var tb:TabBase = arTabs[so];
			tb.Show();
		}
	}
	
	public function HideAllTabs()
	{ 
		for (var so in arTabs) {
			var tb:TabBase = arTabs[so];
			tb.Hide();
		}
	}
	
	public function Push()
	{
		for (var so in arTabs) {
			var tb:TabBase = arTabs[so];
			tb.Push();
		}
	}
	
	public function Pop()
	{ 
		for (var so in arTabs) {
			var tb:TabBase = arTabs[so];
			tb.Pop();
		}
	}
	
	// is the button tab shown
	public function IsShownTab(tbo) : Boolean
	{ 
		return GetTab(tbo).IsShown();
	}

	
	// Miscellaneous
	
	// References to remove use of coreGame. prefix
	private function IsHints() : Boolean { return coreGame.Hints.IsHints(); }
	private function HideHints() { coreGame.Hints.HideHints(); }
}