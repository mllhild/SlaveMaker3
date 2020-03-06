// DisplayInformation - Tutorial Screen
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DisplayInformation extends DisplayBase {
	
	private var checkboxListenerContra:Object;

	// Constructor
	public function DisplayInformation(cg:Object)
	{ 
		super(null, cg);
		
		// contraceptives checkbox
		var ti:DisplayInformation = this;
		checkboxListenerContra = new Object();
		checkboxListenerContra.click = function(cbObj:Object) {
			if (cbObj.target.selected) ti.coreGame.sdata.UseContraceptives(true);
			else ti.coreGame.sdata.UseContraceptives(false);
		};
		coreGame.SlaveStatus.Contraceptives.addEventListener("click", checkboxListenerContra);
		coreGame.SlaveStatus.Contraceptives.setStyle("fontWeight", "bold");
		coreGame.SlaveStatus.Contraceptives.setStyle("symbolBackgroundColor", "0xe0ffff"); 
		coreGame.SlaveStatus.Contraceptives.setStyle("symbolBackgroundDisabledColor", "0xe0ffff");
	}
	
	public function Continue()
	{
		mcBase.ContinueButton.onPress();
	}

	public function ShowInformation(caption:String, nstring:String, nextfunc:Function, nextevent:Number, mc:MovieClip)
	{
		if (mcBase == null) mcBase = coreGame.AttachAndPositionMovie(undefined, "Tutorial Screen", 0, 0, 0, undefined, undefined, coreGame.TutorialMovie);
		mcBase.ContinueText.htmlText = Language.GetHtml("Continue", "Buttons")
		mcBase.TutorialCaption.htmlText = coreGame.UpdateMacros(caption);
		mcBase.TutorialTextField.htmlText = coreGame.UpdateMacros(nstring);
		
		var szx:Number = coreGame.config.nScreenXOffset;
		var szy:Number = coreGame.config.nScreenYOffset;
		mcBase.ContinueText._x = szx + 636;
		mcBase.ContinueText._y = szy + 554;
		mcBase.RectangleContinue._x = szx + 650.3;
		mcBase.RectangleContinue._y = szy + 551.8;
		mcBase.RectangleMain._width = szx + 755.3;
		mcBase.RectangleMain._height = szy + 525.8;
		mcBase.TutorialCaption._width = szx + 757;
		mcBase.TutorialTextField._width = szx + 748.3;
		
		var ti:DisplayInformation = this;
		if (nextfunc != undefined) mcBase.ContinueButton.onPress = nextfunc;
		else if (nextevent != undefined && nextevent != 0) {
			coreGame.NumEvent = nextevent;
			mcBase.ContinueButton.onPress = coreGame.DoEventNext;
		} else mcBase.ContinueButton.onPress = function() { ti.HideInformation(); }
		if (mc != undefined && mc != null) {
			if (mc._parent != _root) coreGame.DummyClip.swapDepths(mc._parent);
			else coreGame.DummyClip.swapDepths(mc);
			mc._visible = true;
			mc._width = 754;
			mc._height = 565;
			mc._x = 26;
			mc._y = 20;
			mcBase.swapmc = mc;
			mcBase.Rectangle2._visible = false;
		} else mcBase.Rectangle2._visible = true;
		coreGame.DisableButtons();
		mcBase._visible = true;
		Selection.setFocus(mcBase.TutorialCaption);
	}
	
	public function HideInformation()
	{
		coreGame.DummyClip._visible = false;
		if (!mcBase._visible) return;
		
		mcBase.TutorialTextField.htmlText = "";
		mcBase.TutorialCaption.htmlText = "";
		coreGame.EnableButtons();
		mcBase._visible = false;
		if (mcBase.swapmc != undefined) {
			mcBase.swapmc._visible = false;
			if (mcBase.swapmc._parent != _root) coreGame.DummyClip.swapDepths(mcBase.swapmc._parent);
			else coreGame.DummyClip.swapDepths(mcBase.swapmc);
			mcBase.swapmc = undefined;
		}
	}
	
	public function IsShown() : Boolean { return mcBase._visible; }
	
	public function ShowTutorial(caption:String, nstring:String, nextfunc:Function, nextevent:Number, mc:MovieClip)
	{
		ShowInformation(Language.GetHtml("Tutorial", "Options") + " - " +  coreGame.UpdateMacros(caption),  coreGame.UpdateMacros(nstring), nextfunc, nextevent, mc);
	}
	
	public function ShowTutorialLang(langs:String, nextfunc:Function, nextevent:Number, mc:MovieClip)
	{
		ShowInformation(Language.GetHtml("Tutorial", "Options") + " - " + Language.GetHtml("Tutorial" + langs + "Title", coreGame.hintNode), Language.GetHtml("Tutorial" + langs, coreGame.hintNode), nextfunc, nextevent, mc);
	}
	
	public function HideTutorial() { HideInformation(); }
	
	
	// Slave Status
	
	// main show function
	public function ShowSlaveStatus(sd:Object)
	{	
		var mc:MovieClip = coreGame.SlaveStatus;
		mc.Contraceptives.label = Language.GetHtml("UsingContraceptives", "Morning");
		mc.LChildren.htmlText = Language.GetHtml("Children", "Morning", true);
		mc.LTentacleSpawn.htmlText = Language.GetHtml("TentacleSpawn", "Morning", true);
		var str:String = Language.GetHtml("Status", "Morning", true);
		if (sd.IsMarried()) str += " Married\r";
		else if (sd.IsInLove()) str += " Lover\r";
		mc.LTitle.htmlText = str;
		
		var bShowChild:Boolean = sd.IsFemale() || sd.TotalChildren > 0 || sd.TotalTentaclePregnancy > 0;
		
		mc._visible = true;
		str = coreGame.modulesList.GetSpecialTrainingList(sd);
		if (str == "") str = Language.GetHtml("Normal", "Options");
		if ((sd.SlaveType == 0 || sd.SlaveType == 1) && sd.Order1 != 0 && sd.Order2 != 0) {
			str += "\r\r<font size='+1'><b>" + Language.GetHtml("Orders", "Other") + ":</b> ";
			if (sd.Order1 != 0) str += coreGame.GetActName(sd.Order1);
			if (sd.Order2 != 0) str += ", " + coreGame.GetActName(sd.Order2);
			str += "</font>";
		}
		mc.LStatusEffects.htmlText = str;
		
		mc.Contraceptives._visible = bShowChild && sd.SlaveType != -1 && sd.SlaveType != -20;
		mc.ChildrenValue._visible = bShowChild;
		mc.TentacleSpawnValue._visible = bShowChild && coreGame.TentaclesOn == 1;
		mc.LChildren._visible = bShowChild;
		mc.LTentacleSpawn._visible = bShowChild && coreGame.TentaclesOn == 1;
		if (bShowChild) {
			mc.Contraceptives.selected = !sd.BitFlag1.CheckBitFlag(14);
			mc.ChildrenValue.htmlText = sd.TotalChildren + "";
			mc.TentacleSpawnValue.htmlText = sd.TotalTentaclePregnancy + "";
		}
		mc.Contraceptives.invalidate();
	}
}