// Timer List
// Translation status: COMPLETE
//
// Usage
/*
function PickASlave(ptitle:String, mainside:Boolean, filterfnc:Function, cfnc:Function, timer:Number)
{
	if (!SlaveList.IsLoadedAll()) {
		if (timer != undefined) return;
		Timers.ShowWait();
		Timers.AddTimer(
			setInterval(_root, "PickASlave", 50, ptitle, mainside, filterfnc, cfnc, Timers.GetNextTimer())
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	.....
*/

import Scripts.Classes.*;

class TimerList extends TimerListBase
{
	public var arTimerArray:Array;
	
	//   General timers
	public var intervalId:Number;
	public var intervalId2:Number;
	public var intervalId3:Number;
	public var intervalId4:Number;
	
	// Private
	private var coreGame:Object;
	private var WaitingClip:MovieClip;

	
	public function TimerList(cg:Object)
	{
		coreGame = cg;
		WaitingClip = coreGame.WaitingClip;
		
		clearInterval(intervalId);
		clearInterval(intervalId2);
		clearInterval(intervalId3);
		clearInterval(intervalId4);
		
		StopAlTimers();
		delete arTimerArray;
		arTimerArray = new Array();
		
		StopWait();
		
	}
	
	public function GetNextTimerIdx() : Number { return arTimerArray.length + 1; }
	public function IsTimerStopped(idx:Number) : Boolean { return arTimerArray[idx - 1].bStopped; }
	
	// Add a Timer
	public function AddTimer(id:Number, val:Object)
	{
		arTimerArray.push(new TimerData(id, val));
	}
	public function AddTimerShowWait(id:Number, val:Object, bDark:Boolean)
	{
		arTimerArray.push(new TimerData(id, val));
		ShowWait(bDark);
	}
	public function AddTimerStopSoon(id:Number, val:Object)
	{
		arTimerArray.push(new TimerData(id, val, false));
	}	
	
	public function StartNamedTimer(str:String, delay:Number, val:Object)
	{
		var intervalId = setInterval(_root, str, delay);
		arTimerArray.push(new TimerData(intervalId, val, false, str));
	}
	public function StartNamedTimerStopSoon(str:String, delay:Number, val:Object)
	{
		var intervalId = setInterval(_root, str, delay);
		arTimerArray.push(new TimerData(intervalId, val, true, str));
	}
	
	// Remove a Timer
	public function RemoveTimer(idx:Number)
	{
		if (idx == undefined || idx == 0) return;
		var ti:TimerData = arTimerArray[idx - 1];
		ti.StopNow();
	}
	public function RemoveNamedTimer(str:String)
	{
		var i:Number = arTimerArray.length;
		if (i == undefined || str == undefined || i == 0) return;
		var ti:TimerData;
		while (--i >= 0) {
			ti = arTimerArray[i];
			if (ti.strName == str) {
				ti.StopNow();
				return;
			}
		}
	}	
	
	public function GetNamedTimerData(str:String) : Object {
		var i:Number = arTimerArray.length;
		if (i == undefined || str == undefined || i == 0) return;
		var ti:TimerData;
		while (--i >= 0) {
			ti = arTimerArray[i];
			if (ti.strName == str) return ti.tdata;
		}
		return undefined;
	}

	
	public function GetTimerData(idx:Number) : Object { return arTimerArray[idx - 1].tdata; }

	public function StopAlTimers()
	{
		var i:Number = arTimerArray.length;
		if (i == undefined) return;
		var ti:TimerData;
		while (--i >= 0) {
			ti = arTimerArray[i];
			ti.Stop();
		}
		
		// cleanup entries
		i = arTimerArray.length;
		while (--i >= 0) {
			ti = arTimerArray[i];
			if (ti.id != 0) return;
		}
		
		i = arTimerArray.length;
		while (--i >= 0) {
			var obj:Object = arTimerArray.pop();
			delete obj;
		}
		delete arTimerArray;
		arTimerArray = new Array();
	}

	
	// Waiting animation
	
	public function ShowWait(bDark:Boolean)
	{
		if (WaitingClip._visible) return;
		if (bDark == true) WaitingClip.blendMode = "darken";
		else WaitingClip.blendMode = "darken";
		WaitingClip._visible = true;
		WaitingClip.Clip.play();
		coreGame.DisableButtons();
	}
	public function StopWait()
	{
		if (!WaitingClip._visible) return;
		WaitingClip._visible = false;
		WaitingClip.Clip.stop();
		coreGame.EnableButtons();
	}
}
