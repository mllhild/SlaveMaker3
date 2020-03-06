// Loaded Girl
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.display.BitmapData;

class LoadedSlavesClass extends BaseModule {
	
	// loaded slave List
	private var arLoadedSlaveArray:Array;			// current list of possible assistants

	// Constructor
	public function LoadedSlavesClass(cg:Object) {
		super(null, null, cg);
		
		ModuleName = ".";
		arLoadedSlaveArray = new Array();
	}
	
	public function IsLoadedSlave(slave:Object) : Boolean
	{
		return GetLoadedSlave(slave) != null;
	}
	
	public function HideLoadedSlaves()
	{
		var i:Number = arLoadedSlaveArray.length;
		if (i == undefined) return;
		while (i > 0) {
			i -= 2;
			var sm:SlaveModule = arLoadedSlaveArray[i];
			sm.HideAsAssistant();
			sm.HideImages();
		}
	}

	public function GetLoadedSlave(girl:Object) : SlaveModule
	{
		var sdo:Object = girl;
		if (typeof(girl) == "string") sdo = SMData.GetSlaveDetails(String(girl), true);
	
		var i:Number = arLoadedSlaveArray.length;
		var sm:SlaveModule;
		while (i > 0) {
			i -= 2;
			sm = arLoadedSlaveArray[i];
			if (sm.slaveData == sdo) return sm;
		}
		return null;
	}
	
	public function ChangeLoadedSlave(girl:Object)
	{
		//SMTRACE("ChangeLoadedSlave");
		var sd:Object = girl;
		if (typeof(girl) == "string") sd = SMData.GetSlaveDetails(String(girl), true);
		
		var sm:SlaveModule = GetLoadedSlave(sd);
		if (sm != null) return;
		
		var image:MovieClip = coreGame.LoadedSlavesMovie.createEmptyMovieClip("LoadedSlave" + nLoadedNum, coreGame.LoadedSlavesMovie.getNextHighestDepth());
		nLoadedNum++;
	
		//SMTRACE("ChangeLoadedSlave: " + sd.SlaveName + " " + sd.SlaveFilename);
		var ext:String = sd.SlaveFilename.substr(-4);
		//image.loading = true;
		if (ext != ".xml" && ext != "") {
			loading = true;
			mcBase = image;
			LoadModule(sd.SlaveFilename, this, "LoadedSlaveFinishedLoading");
		}
		coreGame.GetSlaveObjectXML(sd);
		arLoadedSlaveArray.push(image);
		arLoadedSlaveArray.push(sd);
		if (ext == ".xml" || ext == "") LoadedSlaveFinishedLoading(image, ModuleName, arguments);
	}
	
	private function LoadedSlaveFinishedLoading(mc:MovieClip)
	{
		var i:Number = arLoadedSlaveArray.length;
		while (i > 0) {
			i -= 2;
			if (arLoadedSlaveArray[i] == mc) break;
		}
		if (i < 0) return;
		
		var lgo:Object = arLoadedSlaveArray[i + 1];
		
		var LoadedSlave:Object = coreGame.modulesList.CreateSlaveModuleClassFromFilename(lgo.SlaveFilename, mc, lgo, coreGame);
		if (LoadedSlave == undefined || LoadedSlave == null) LoadedSlave = mc;
		LoadedSlave.mcBase = mc;
		LoadedSlave.slaveData = lgo;
		LoadedSlave.coreGame = _root;
		
		coreGame.GetSlaveObjectXML(LoadedSlave.slaveData);
		LoadedSlave.slaveData.ActInfoBase.ActFolder = LoadedSlave.slaveData.ImageFolder;
		LoadedSlave.ImageFolder = LoadedSlave.slaveData.ImageFolder;
		
		LoadedSlave.HideAsAssistant();
		
		LoadedSlave.Assisting = false;
		LoadedSlave.AsEvent = false;
		LoadedSlave.Lesbian = false;
		LoadedSlave.LesbianTraining = false;
		LoadedSlave.Aroused = false;
		LoadedSlave.Naked = false;
		LoadedSlave.SlaveName = lgo.SlaveName;
		LoadedSlave.Elapsed = coreGame.Elapsed;
		LoadedSlave.DickgirlXF = lgo.DickgirlXF;
		
		mc.loading = false;
		arLoadedSlaveArray[i] = LoadedSlave;
	}
	
	public function ClearLoadedSlaves(girl:Object)
	{
		var sd:Object = girl;
		if (typeof(girl) == "string") sd = coreGame.GetSlaveDetails(String(girl), true);
	
		var i:Number = arLoadedSlaveArray.length;
		if (i != undefined) {
			while (i > 0) {
				i -= 2;
				var sm:SlaveModule = arLoadedSlaveArray[i];
				if (girl != undefined && sm.slaveData == sd) {
					sm.mcBase.unloadMovie();
					sm.mcBase.removeMovieClip();
					delete sm;
					arLoadedSlaveArray.splice(i, 2);
					return;
				} else {
					sm.mcBase.unloadMovie();
					sm.mcBase.removeMovieClip();
					delete sm;
					arLoadedSlaveArray.pop();
					arLoadedSlaveArray.pop();
				}
			}
		}
		delete arLoadedSlaveArray;
		arLoadedSlaveArray = new Array();	
	}
	
	public function ShowLoadedSlave(girl:Object, place:Number, align:Number, gframe:Number, target:MovieClip, timer:Number)
	{
		var sm:SlaveModule = GetLoadedSlave(girl);
		if (sm == null) {
			if (timer != undefined) return;
			Timers.AddTimerStopSoon(
				setInterval(this, "ShowLoadedSlave", 40, girl, place, align, gframe, target, Timers.GetNextTimerIdx())
			);
			return;
		}
		Timers.RemoveTimer(timer);
		
		if (target == undefined) target = coreGame.LoadedMovies;
		var image:MovieClip = target.createEmptyMovieClip("LoadedMovie" + nLoadedNum, target.getNextHighestDepth());
		image._visible = false;
		target._visible = true;
		nLoadedNum++;
		
		// Preserve servant details
		var oServantName:String = coreGame.ServantName;
		var oServantPronoun:String = coreGame.ServantPronoun;
		var oAssistantTentacleSex:Boolean = coreGame.AssistantTentacleSex;
		var oAssistantRape:Boolean = coreGame.AssistantRape;
		var oServantGender:Number = coreGame.ServantGender;
		var oSlaveLikeServant:Boolean = coreGame.SlaveLikeServant;
		var oAssistantDescription:String = coreGame.AssistantDescription;
		var oAssistantCost:Number = coreGame.AssistantCost;
		var oServantMaster:String = coreGame.ServantMaster;
		var sda:Slave = new Slave();
		sda.CopyCommonDetails(coreGame.AssistantData, sda);
	
		var mc:MovieClip = sm.InitialiseAsAssistant();
		if (mc == undefined) mc = sm.mcBase.Assistant;
		mc.gotoAndStop(1);
		//mc = sm.InitialiseAsAssistant();
		//if (mc == undefined) mc = sm.mcBase.Assistant;
		mc._visible = false;
		if (place == 0) coreGame.PersonShown = girl.SlaveIndex;
		
		// restore
		coreGame.ServantName = oServantName;
		coreGame.ServantPronoun = oServantPronoun;
		coreGame.AssistantTentacleSex = oAssistantTentacleSex;
		coreGame.AssistantRape = oAssistantRape;
		coreGame.ServantGender = oServantGender;
		coreGame.SlaveLikeServant = oSlaveLikeServant;
		coreGame.AssistantDescription = oAssistantDescription;
		coreGame.AssistantCost = oAssistantCost;
		coreGame.ServantMaster = oServantMaster;
		sda.CopyCommonDetails(sda, coreGame.AssistantData);
		sda = null; delete sda;
		
		ShowLoadedSlave2(image, mc, place, align, gframe, undefined);
	}
	
	public function ShowLoadedSlave2(image:MovieClip, mc:MovieClip, place:Number, align:Number, gframe:Number, timer:Number)
	{
		if (mc.loading == true) {
			if (timer != undefined) return;
			Timers.AddTimerStopSoon(
				setInterval(this, "ShowLoadedSlave2", 80, image, mc, place, align, gframe, Timers.GetNextTimerIdx())
			);
			return;
		}
		trace("ShowLoadedSlave2");
		mc.hide = true;
		Timers.RemoveTimer(timer);
		
		var mwidth:Number = mc._width / mc._xscale * 100;
		var mheight:Number = mc._height / mc._yscale * 100;
	
		mc._visible = true;
		var bmps:BitmapData = new BitmapData(mwidth, mheight, true, 0);
		bmps.draw(mc);
		image.attachBitmap(bmps, image.getNextHighestDepth(), "auto", true);
		mc._visible = false;
		coreGame.ShowMovie(image, place, align);
		coreGame.OnTopOverlayWhite2._visible = false;
		coreGame.arAutoLoadedMovieArray.push(image);
	}

}
