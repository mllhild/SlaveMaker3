// Other Girl
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.display.BitmapData;

class OtherSlaveClass extends BaseModule {
	
	private var strOtherSlaveFilename:String = "";
	private var oldfileOtherSlave:String = "";
	
	public var Module:SlaveModule;
	
	private var objOnload:Object;
	private var strFun:String;

	// Constructor
	public function OtherSlaveClass(cg:Object) {
		super(cg.OtherSlaveMovie, null, cg);
		
		ModuleName = ".";
	}
	
	public function Load(lo:Object)
	{
		strOtherSlaveFilename = lo.strOtherSlaveFilename;
		if (strOtherSlaveFilename == undefined) strOtherSlaveFilename = lo.OtherGirlFilename;
		if (strOtherSlaveFilename == undefined) strOtherSlaveFilename = lo.vOtherGirlFilename;

	}
	
	public function Save(so:Object)
	{
		so.strOtherSlaveFilename = strOtherSlaveFilename;
	}
	
	function ChangeOtherSlave(girl:String, obj:Object, onload:String)
	{
		if (girl == undefined) girl = strOtherSlaveFilename;
		objOnload = obj;
		strFun = onload;
		
		oldfileOtherSlave = strOtherSlaveFilename;
		strOtherSlaveFilename = girl;
		if (strOtherSlaveFilename == undefined || strOtherSlaveFilename == "" || (IsLoaded() && oldfileOtherSlave == strOtherSlaveFilename)) {
			if (objOnload != undefined) objOnload[strFun]();
			return;
		}
		mcBase.unloadMovie();
		
		mcBase.loading = true;
		loading = true;
		LoadModule(sd.SlaveFilename, this, "OtherSlaveFinishedLoading");
	}
	
	function OtherSlaveFinishedLoading()
	{
		var assArray:Array = strOtherSlaveFilename.slice(0, -4).split("-");
		Module = coreGame.modulesList.CreateSlaveModuleClassFromFilename(strOtherSlaveFilename, mcBase, null, coreGame);
		if (Module == undefined || Module == null) Module = coreGame.OtherSlaveMovie;
		mcBase.loading = false;
		loading = false;
		Module.HideAsAssistant();
		Module.HideImages();
		Module.HideEndings();
		Module.HideDresses();
		Module.HideRobes();
		Module.HideSlaveActions();
		
		Module.Assisting = false;
		Module.AsEvent = false;
		Module.Naked = false;
		Module.Lesbian = false;
		Module.Aroused = false;
			
		if (objOnload != undefined) objOnload[strFun]();
	}
	
	function ClearOtherSlave()
	{
		if (!IsLoaded()) return;
		mcBase.unloadMovie();
		strOtherSlaveFilename = "";
		oldfileOtherSlave = "";
		Module = null;
	}
	
	function ShowOtherSlave(place:Number, align:Number, gframe:Number, target:MovieClip, timer:Number)
	{
		if (!IsLoaded()) return;
	
		if (mcBase.getBytesLoaded() != mcBase.getBytesTotal() || mcBase.loading != false) {
			if (timer != undefined) return;
			Timers.AddTimer(
				setInterval(this, "ShowOtherSlave", 40, place, align, gframe, target,Timers.GetNextTimerIdx())
			);
			return;
		}
		Timers.RemoveTimer(timer);
		
		if (target == undefined) target = coreGame.LoadedMovies;
		var image:MovieClip = target.createEmptyMovieClip("LoadedMovie" + nLoadedNum, target.getNextHighestDepth());
		image._visible = false;
		target._visible = true;
		nLoadedNum++;
		var mc:MovieClip = Module.InitialiseAsAssistant();
		//mc.gotoAndStop(1);
		var mwidth:Number = mc._width / mc._xscale * 100;
		var mheight:Number = mc._height / mc._yscale * 100;
		if (mc == undefined) {
			mc = mcBase.Assistant;
			mc.gotoAndStop(1);
			mwidth = mc._width / mc._xscale * 100;
			mheight = mc._height / mc._yscale * 100;
		}
		mc._visible = true;
		var bmps:BitmapData = new BitmapData(mwidth, mheight, true, 0);
		//bmps.draw(mc);
		image.attachBitmap(bmps, image.getNextHighestDepth(), "auto", true);
		mc._visible = false;
		ShowMovie(image, place, align);
		coreGame.OnTopOverlayWhite2._visible = false;
		coreGame.arAutoLoadedMovieArray.push(image);
	}
	
	function IsOtherSlave(slave:String) : Boolean
	{
		if (!IsLoaded()) return false;
		slave = slave.split(".")[0].toLowerCase();
		var sl:Array = slave.split("-");
		slave = sl[sl.length - 1];
		sl = slave.split(" ");
		var slnsp:String = sl[sl.length - 1];
		var slchk:String;
		
		sl = strOtherSlaveFilename.split("/");
		slchk = sl[sl.length - 1].split(".")[0];
		sl = slchk.split("-");
		slchk = sl[sl.length - 1];
		if (slchk.toLowerCase() == slnsp) return true;
		return false;
	}
}
