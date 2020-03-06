// a particular Timer
// Translation status: COMPLETE

import Scripts.Classes.*;

class TimerData
{
	public var id:Number;		// actual timer object/handle
	public var tdata:Object;	// arbitrary data for timer
	public var bStopped:Boolean;	// is the timer stopped
	private var bStopImmed:Boolean;	// when stopped does the time get stopped or wait for the operation to complete. Normally used for image loading
	public var strName:String;		// ithe name of the timer
	
	public function TimerData(idi:Number, tdatao:Object, immed:Boolean, str:String)
	{
		id = idi;
		bStopped = false;
		bStopImmed = immed == undefined ? true : immed;
		tdata = tdatao != undefined ? tdatao : null;
		strName = str == undefined ? "" : str;
	}

	public function Stop()
	{
		if (bStopImmed) StopNow();
		else StopSoon();
	}
	public function StopNow()
	{
		clearInterval(id);
		id = 0;
		
		// inlined StopSoon()
		if (typeof(tdata) == "object") delete tdata;
		bStopped = true;
	}
	public function StopSoon()
	{
		if (typeof(tdata) == "object") delete tdata;
		bStopped = true;
	}	
}
