// Timer List (Base version)
// Translation status: COMPLETE
//
// Usage
/*
function PickASlave(ptitle:String, mainside:Boolean, filterfnc:Function, cfnc:Function, timer:Number)
{
	if (!SlaveList.IsLoadedAll()) {
		if (timer != undefined) return;
		ShowWait();
		Timers.AddTimer(
			setInterval(_root, "PickASlave", 50, ptitle, mainside, filterfnc, cfnc, Timers.GetNextTimer())
		);
		return;
	}
	Timers.RemoveTimer(timer);
	Timers.StopWait();
	.....
	
NOTE: any return values in this base class are dummy values and meaningful values will be returned when used
*/
import Scripts.Classes.*;

class TimerListBase
{	
	// Add a Timer, using an index value
	// get next available timer index value
	public function GetNextTimerIdx() : Number { return 0; }
	// has the timer stopped?
	public function IsTimerStopped(idx:Number) : Boolean { return false; }

	// add the timer
	public function AddTimer(id:Number, val:Object) { }
	public function AddTimerShowWait(id:Number, val:Object, bDark:Boolean) { }
	public function AddTimerStopSoon(id:Number, val:Object) { }	
	
	// get the 'other data' (val oarameter above)
	public function GetTimerData(idx:Number) : Object { return undefined; }
	
	// add a timer by a unique name
	public function StartNamedTimer(str:String, delay:Number, val:Object) {	}
	public function StartNamedTimerStopSoon(str:String, delay:Number, val:Object) {	}
	
	// get the 'other data' (val oarameter above) for a named timer
	public function GetNamedTimerData(str:String) : Object { return undefined; }
	
	// Remove a Timer, by index or name
	public function RemoveTimer(idx:Number)	{ }
	public function RemoveNamedTimer(str:String) { }	
	
	// Wait animation
	public function ShowWait(bDark:Boolean)	{ }
	public function StopWait() { }
	
}
