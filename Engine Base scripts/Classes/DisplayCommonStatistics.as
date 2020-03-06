// DisplayCommonStatistics - common statistics panel for both slave and slave maker
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplayCommonStatistics extends DisplayBase {

	// Constructor
	public function DisplayCommonStatistics(mc:MovieClip, cg:Object)
	{ 
		super(mc, cg);
	}
	
	// Update display
	var stln:Number;
	
	private function LayoutStats(mc:MovieClip, ypos:Number, gap:Number) : Number {
		if (!mc._visible) return ypos;
		if ((stln % 2) != 0) mc.BackgroundBar._alpha = 0;
		else mc.BackgroundBar._alpha = 50;
		mc._y = ypos;
		stln++;
		return ypos + gap;
	}
	
	
	// Hints
	
	private function SetStatHintDetails(mc:MovieClip, stat:Number)
	{
		var ti:DisplayCommonStatistics = this;
		mc.currStat = stat;
		mc.onRollOver = function() { ti.ShowStatHint(this.currStat); }
		mc.onRollOut = function() { ti.HideHints(); }
		mc.tabEnabled = false;
		mc.Limit._visible = false;
		mc.BarMinimum._width = 0;
	}
	
	private function GetStatisticHintNode(stat:String, sd:Object, iNode:XMLNode, appear:Boolean) : XMLNode
	{	
		if (appear == undefined) appear = false;
		var stNode:XMLNode = null;
		if (sd.IsDickgirl()) stNode = Language.XMLData.GetNodeC(iNode, stat + "Dickgirl");
		if (stNode == null) {
			if (sd.IsFemale() || (appear && sd.BitFlagC.CheckBitFlag(62))) stNode = Language.XMLData.GetNodeC(iNode, stat + "Female");
			else stNode = Language.XMLData.GetNodeC(iNode, stat + "Male");
		}
		if (stNode == null) return Language.XMLData.GetNodeC(iNode, stat);
		return stNode;
	}
	
	private function SetBar(mc:MovieClip, wid:Number) { 
		mc.Bar._width = Math.ceil(1.64 * wid);
	}
	private function SetBarBase(mc:MovieClip, wid:Number) { 
		mc._width = Math.ceil(1.64 * wid);
	}
	
	public function ShowStatHint(stat:Number) { }	
}
