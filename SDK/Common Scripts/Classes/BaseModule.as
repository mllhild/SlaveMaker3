// SlaveModule - class defining a loaded module, like an event or class of events. 
// Also a container for slaves and assistants, but not their data, for that see the class Slave
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.display.BitmapData;

class BaseModule extends BitFlags
{
	//------------------------------
	// Variables
	public var coreGame:Object;			// core game engine
	
	// base objects
	public var slaveData:Object;			// the instance of the Slave class for this slave, null for event/people modules
	public var sd:Object;					// copy of slaveData for brevity of use internally
	public var SMData:Object;				// reference of slave maker object
	 
	// the MovieClip this Module is loaded into. Any images should be created based on  The supplied functions do this
	// using .FLA files with prebuilt MovieClips they will all be something like mcBase.FuckClip etc
	public var mcBase:MovieClip;
	private var BaseMovie:MovieClip;		// OBSOLETE
	
	// Module Details and State
	public var ModuleName:String;
	public var loading:Boolean;
	
	public var ImageFolder:String;
	public var xNode:XMLNode;				// internal use only, xml node for location/person
					
	// internal use private variables - DO NOT use
	// they are not valid outside of calling LoadModule()
	private var arAutoLoadedMoviesBM:Array;	// for image loading
	private var arLoadedMoviesBM:Array;		// for image loading
	private var nLoadedNum:Number;			// for image loading
	
	// Common variables
	private var temp:Number;		// a commonly used variable, added for convenience
									// note: in some VERY limited cases you may still need to access coreGame.temp
	
	// function pointers to simplify usage of coreGame.functionname()
	// this is very efficient but there is no type checking at compile/sytax check time
	// note this increases memory usage but decreases code size and improves runtime speed (less code executed)
	// use this method for release code or for simple functions with few or no parameters
	private var ShowSupervisor:Function;		// coreGame.ShowSupervisor();
	private var HideBackgrounds:Function;		// coreGame.HideBackgrounds();
	private var IsEventAllowable:Function;		// coreGame.IsEventAllowable();
	private var GetFreeEvent:Function;			// coreGame.GetFreeEvent();
	private var IsDickgirlEvent:Function;		// coreGame.IsDickgirlEvent();
	private var HidePlanningNext:Function;		// coreGame.HidePlanningNext();
	private var ShowPlanningNext:Function;		// coreGame.ShowPlanningNext();
	private var SMTRACE:Function;				// coreGame.SMTRACE();
	
	// module references
	public var Diary:TrainingLog;				// Diary
	public var Backgrounds:BackgroundModule;	// Backgrounds
	private var Timers:TimerListBase;			// Timers
	private var Language:GameLanguageBase;		// common strings, translation tools and text functions
	
	//-----------------------------	
	
	
	//-----------------------------
	//Methods
	
	// Constructor
	//		mc is the MovieClip container the Module is loaded into
	public function BaseModule(mc:MovieClip, slave:Object, cg:Object, nm:String)
	{
		//SMTRACE("BaseModule() " + mc + " " + cg);
		mcBase = mc == undefined ? null : mc;
		BaseMovie = mcBase;
		SetSlave();
		slaveData = slave == null || slave == undefined ? _root : slave;
		sd = slaveData;
		coreGame = cg == undefined ? _root : cg;
		ModuleName = nm == undefined ? "" : nm;
		
		arLoadedMoviesBM = null;
		arAutoLoadedMoviesBM = null;
		loading = undefined;
		ImageFolder = "";
		xNode = null;
		nLoadedNum = 0;
		
		// create function pointers
		ShowSupervisor = coreGame.ShowSupervisor;
		if (ModuleName != "Engine/Backgrounds.swf") HideBackgrounds = coreGame.HideBackgrounds;
		IsEventAllowable = coreGame.IsEventAllowable;
		GetFreeEvent = coreGame.GetFreeEvent;
		IsDickgirlEvent = coreGame.IsDickgirlEvent;
		HidePlanningNext = coreGame.HidePlanningNext;
		ShowPlanningNext = coreGame.ShowPlanningNext;
		SMTRACE = coreGame.SMTRACE;
		
		Backgrounds = coreGame.Backgrounds;
		Diary = coreGame.Diary;
		SMData = coreGame.SMData;
		Timers = coreGame.Timers;
		Language = coreGame.Language;

		if (mc == null || mc == _root) return;
		
		// inlined InitialiseModule();
		
		// hide and stop any images in the MovieClip associated with this Module
		// mainly this can happen for swf based slaves developed using Adobe CSx
		// Note this is more an efficiency measure and to cater for small bugs that can happen during development
		// Note2: reuses mc here to save creating a new variable
		var hd:Boolean = !IsHideInitialImages();
		for (var mv:String in mcBase) {
			mc = MovieClip(mcBase[mv]);
			if (typeof(mc) != "movieclip" || mc == _root) continue;
			mc.stop();
			mc._visible = hd;
		}
	}
	
	
	// Features/Capabilities of this module, override as needed
	//   hide all images in the module swf when loaded
	private function IsHideInitialImages() : Boolean { return true; }
	//   inplement load/save features AND an external xml file
	public function CanLoadSave() : Boolean { return false; }
	
	
	// status - has the associated swf loaded
	// DO NOT OVERRIDE
	public function IsLoaded() : Boolean
	{
		if (loading == false || ModuleName == "") return true;
		return (ModuleName.indexOf("/") == -1);
	}  
	
	// set current slave details for internal usage
	public function SetSlave(sdo:Object) {  // DO NOT OVERRIDE
		if (sdo == null || sdo == undefined) sdo = coreGame;
		this.slaveData = sdo;
		this.sd = sdo;
	} 

	// stop and hide any child movies
	static public function StopSubMovie(mcs:MovieClip)
	{
		mcs._visible = true;
		var mc:MovieClip;
		for (var mv:String in mcs) {
			mc = mcs[mv];
			if (typeof(mc) != "movieclip" || mc == _root) continue;
			mc.gotoAndStop(1);
			mc._visible = false;
		}
		mcs._visible = false;
	}
		
	// HideModuleImages - hide the loaded images
	// If you override then call
	//		super.HideModuleImages()
	public function HideImages()
	{
		var mc:MovieClip;
		
		if (arAutoLoadedMoviesBM != null) {
			while (arAutoLoadedMoviesBM.length > 0) {
				mc = MovieClip(arAutoLoadedMoviesBM.pop());
				if (mc != _root) mc.removeMovieClip();
			}
		}	
		
		//inlined InitialiseModule
		
		// hide and stop any images in the MovieClip associated with this Module
		if (mcBase == _root || mcBase == null) return;
		
		for (var mv:String in mcBase) {
			mc = MovieClip(mcBase[mv]);
			if (typeof(mc) != "movieclip" || mc == _root) continue;
			mc.stop();
			mc._visible = false;
		}
	}

	// called when the module is loaded
	// generally stop and hide any images
	public function InitialiseModule(mcb:MovieClip) {
		
		Diary = coreGame.Diary;
		SMData = coreGame.SMData;
		Backgrounds = coreGame.Backgrounds;
		Timers = coreGame.Timers;
		Language = coreGame.Language;

		if (mcb === undefined) mcb = mcBase;
		if (mcb === null || mcb == _root) return;
		
		// hide and stop any images in the MovieClip associated with this Module
		var mc:MovieClip;
		var hd:Boolean = !IsHideInitialImages();
		for (var mv:String in mcBase) {
			mc = MovieClip(mcBase[mv]);
			if (typeof(mc) != "movieclip" || mc == _root) continue;
			mc.gotoAndStop(1);
			mc._visible = hd;
		}
	}

	// called when the module is unloaded
	// destroy any permanently created items, especially those on the stage/timeline
	public function DestroyModule()
	{ 
		HideImages();
		if (arLoadedMoviesBM != null) {
			var mc:MovieClip;
			while (arLoadedMoviesBM.length > 0) {
				mc = MovieClip(arLoadedMoviesBM.pop());
				if (mc != _root) mc.removeMovieClip();
			}
		}	
	}
	
	// General load/save functions, automatically called by the game
	// If you override, ALWAYS call super.Load(lo);/super.Save(so); as the first line in your function
	public function Load(lo:Object)
	{
		coreGame.LoadSave.CleanSaveGame(lo);
		super.Load(lo);
		
		Diary = coreGame.Diary;
		SMData = coreGame.SMData;
		Timers = coreGame.Timers;
		Language = coreGame.Language;
	}
	public function Save(so:Object)
	{
		super.Save(so);
	}
		// 
	// load the associated sw file
	// DO NOT OVERRIDE (well, if you do take care...)
	private var mcLoaderModule:MovieClipLoader
	private var loadListenerModule:Object;
	private var objFun:Object;
	private var sfn:String;
	private var sargs:Array;

	public function LoadModule(modulename:String, obj:Object, fnc:String, attach:Boolean)
	{
		if (modulename != "" && modulename != undefined) ModuleName = modulename;
		trace("loadModule: " + ModuleName + " " + IsLoaded());		
		if (IsLoaded()) {
			SMTRACE("Already loaded: " + modulename);
			if (fnc != undefined) obj[fnc](mcBase, modulename, arguments);
			return;
		}
		SMTRACE("Loading: " + ModuleName);
		
		objFun = obj;
		sfn = fnc;
		sargs = arguments;
		
		mcBase._visible = false;
		loading = true;
		
		mcLoaderModule = new MovieClipLoader();
		loadListenerModule = new Object();
		mcLoaderModule.addListener(this);		
		mcLoaderModule.loadClip(ModuleName, mcBase);
	}
	
	
	//------------------------------------
	// Private Members, do not override
	//	well you can override, but why?
	//------------------------------------

	private function onLoadInit(mc:MovieClip)
	{
		mcBase = mc;		//? needed
		mc.stop();
		
		delete mcLoaderModule;
		delete loadListenerModule;

		SMTRACE("...loaded: " + ModuleName);
		InitialiseModule();
		loading = false;
		
		mcBase._visible = true;
		if (sfn != undefined) objFun[sfn](mcBase, ModuleName, sargs);
	}
	
	// some common functions that can be used after the module has finished loading
	private function DoEventModule(mod:SlaveModule, modulename:String) { coreGame.DoEvent(); }
	private function ShowQuestionsModule(mod:SlaveModule, modulename:String) { coreGame.ShowQuestions(); }

	
	// Images
	
	// create/load a movie from a bitmap, primarily for FlashDEvelop embedded images, can be used for Flash
	private function AttachBitmap(bmp:String, bRemember:Boolean) : MovieClip
	{
		var bmpdata:BitmapData = BitmapData.loadBitmap(bmp);
		var mc:MovieClip = mcBase.createEmptyMovieClip("LoadedMovieMD" + nLoadedNum, mcBase.getNextHighestDepth());
		nLoadedNum++;
		mc.enabled = false;
		mc._visible = false;
		mc.attachBitmap(bmpdata, mc.getNextHighestDepth());
		if (bRemember != false) {
			if (arLoadedMoviesBM == null) arLoadedMoviesBM = new Array();
			arLoadedMoviesBM.push(mc);
		}
		return mc;
	}

	// create/load a movie, primarily for FlashDEvelop embedded images, can be used for Flash
	private function AttachMovie(movie:String, bRemember:Boolean) : MovieClip
	{
		var image:MovieClip = mcBase.attachMovie(movie, "LoadedMovieMD" + nLoadedNum, mcBase.getNextHighestDepth());
		image.enabled = false;
		image._visible = false;
		nLoadedNum++;
		if (bRemember != false) {
			if (arLoadedMoviesBM == null) arLoadedMoviesBM = new Array();
			arLoadedMoviesBM.push(image);
		}
		return image;
	}
	
	// Load the movie and shows it using ShowMovie
	// You must manually unload the movie, or leave until the slavegirl/assistant is ubnloaded
	private function AttachAndShowMovie(mc:MovieClip, image:String, place:Number, align:Number, gframe:Number) : MovieClip
	{
		if (mc == undefined) mc = AttachMovie(image, false);

		coreGame.ShowMovie(mc, place, align, gframe);
		if (place == 0) coreGame.OnTopOverlayWhite2._visible = false;
		return mc;
	}
	
	// As above but the image is automatically deleted with HideImages or HideAsAssistant
	private function AutoAttachMovie(movie:String) : MovieClip
	{
		//trace("AutoAttachMovie: " + movie + " " + mcBase._visible);
		var image:MovieClip = AttachMovie(movie, false);
		if (arAutoLoadedMoviesBM == null) arAutoLoadedMoviesBM = new Array();
		arAutoLoadedMoviesBM.push(image);
		return image;
	}

	// As above and then calls ShowMovie
	private function AutoAttachAndShowMovie(movie:String, place:Number, align:Number, gframe:Number) : MovieClip
	{
		var bShow:Boolean = false;
		var image:MovieClip = AutoAttachMovie(movie);
		if (align >= 0 && place == 0) {
			align = align * -1;
			if (align == 0) align = -100;
			bShow = true;
		}
		coreGame.ShowMovie(image, place, align, gframe);
		if (place == 0) coreGame.OnTopOverlayWhite2._visible = false;
		if (bShow) image._visible = true;
		return image;
	}
	
	private function LoadImage(image:MovieClip, movie:String) : MovieClip
	{
		return coreGame.LoadImageAndShowMovie(image, movie, undefined, undefined, mcBase);
	}
	
	private function LoadShow(mc:MovieClip, modulename:String, arg:Array)
	{
 		var movie = arg[3];
		var place:Number = arg[4];
		var align:Number = arg[5];
		var frame:Number = arg[6];
		var delay:Number = arg[7];
		delete arg;
		ShowMovie(movie, place, align, frame, delay);
	}
	
	//---------------------------------------
	// Helper private functions
	// primarily to save using coreGame.
	//---------------------------------------
	
	// random numbers
	// 1 to rnd
	private function slrandom(rnd:Number) : Number { return Math.ceil(Math.random()*rnd); }	
	private function PercentChance(chance:Number) : Boolean { return (Math.random()*100) < chance; }
	
	// Text
	
	private function SetText(nstring:String) { Language.SetText(nstring); }
	private function AddText(nstring:String) { Language.AddText(nstring); }
	private function AddTextToStart(pstring:String) { Language.AddTextToStart(pstring);	}
	private function AddTextToStartGeneral(pstring:String) { Language.AddTextToStartGeneral(pstring); }
	private function SetGeneralText(nstring:String) { Language.SetGeneralText(nstring);	}
	private function AddGeneralText(nstring:String) { Language.AddGeneralText(nstring);	}
	private function BlankLine() { Language.BlankLine(); }
	
	private function PersonSpeakStart(person:Object, say:String, newl:Boolean) { Language.PersonSpeakStart(person, say, newl); }	
	private function PersonSpeakEnd(say:String) { Language.PersonSpeakEnd(say);	}
	private function PersonSpeak(person:Object, say:String, newl:Boolean) { Language.PersonSpeak(person, say, newl); }
	private function SlaveSpeakStart(say:String, newl:Boolean) { coreGame.slaveData.SlaveSpeakStart(say, newl); }
	private function SlaveSpeakEnd(say:String) { coreGame.slaveData.SlaveSpeakEnd(say); }
	private function SlaveSpeak(say:String, newl:Boolean) { coreGame.slaveData.SlaveSpeak(say, newl);	}
	private function ServantSpeak(say:String, newl:Boolean) { Language.ServantSpeak(say, newl); }
	private function ServantSpeakStart(say:String, newl:Boolean) { Language.ServantSpeakStart(say, newl); }	
	
	private function SlaveVerb(str:String) : String { return Language.SlaveVerb(str); }
	private function Plural(str:String, gender:Number) : String	{ return Language.Plural(str, gender); }	
	private function NonPlural(str:String, gender:Number) : String { return Language.NonPlural(str, gender); }	
	
	private function NameCase(s:String) : String { return s.substr(0,1).toUpperCase() + s.substr(1); }
	private function strReplace(s:String, search:String, replace:String) : String { return s.split(search).join(replace); }
	private function strReplaceValue(s:String, num:Number) : String { return s.split("#value").join(num + ""); }
		
	private function SetLangGeneralText(tag:String, node, sNode:XMLNode) { Language.SetLangGeneralText(tag, node, sNode); }
	private function SetLangText(tag:String, node, sNode:XMLNode) { Language.SetLangText(tag, node, sNode); }
	private function AddLangText(tag:String, node, sNode:XMLNode) { Language.AddLangText(tag, node, sNode); }
	private function AddLangGeneralText(tag:String, node, sNode:XMLNode) { Language.AddLangGeneralText(tag, node, sNode); }
		
	// Images
	public function ShowMovie(movie, placeo:Object, align:Number, gframe:Number, delay:Number) {
		//trace("BaseMovie.ShowMovie: " + movie + " " + IsLoaded());
		if (!IsLoaded()) LoadModule("", this, "LoadShow", movie, placeo, align, gframe, delay);
		else {
			if (typeof(movie) == "string" && mcBase[movie] != undefined) coreGame.ShowMovie(mcBase[movie], placeo, align, gframe, delay);
			else coreGame.ShowMovie(movie, placeo, align, gframe, delay);
		}
	}
	private function AutoLoadImageAndShowMovie(movie:String, place:Number, align:Number, target:MovieClip, delay:Number, imgCallback:Function) : MovieClip { return coreGame.AutoLoadImageAndShowMovie(movie, place, align, target, delay, imgCallback); }
	
	private function SetMovieColour(mc:MovieClip, red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number, fb:Boolean) { coreGame.SetMovieColour(mc, red, green, blue, alphao, redmul, greenmul, bluemul, alphamul, fb); }
	private function SetMovieColourARGB(mc:MovieClip, clr:Number, fb:Boolean) { coreGame.SetMovieColourARGB(mc, clr, fb); }
	private function SetLastMovieColour(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number, fb:Boolean) { coreGame.SetMovieColour(coreGame.lastmc, red, green, blue, alphao, redmul, greenmul, bluemul, alphamul, fb); }
	private function SetLastMovieNight(always:Boolean) { coreGame.SetLastMovieNight(always); }

	private function ShowPerson(person:Object, place:Object, align:Number, gframe:Number, delay:Number) { coreGame.People.ShowPerson(person, place, align, gframe, delay);	}
	private function HidePerson(person:Object) { coreGame.People.HidePerson(person); }
	
	// money
	private function TotalGold() : Number { return coreGame.VarGold + SMData.SMGold; }
	private function Money(diff:Number, quiet:Boolean, nodebt:Boolean) { coreGame.Money(diff, quiet, nodebt); }
	private function SMMoney(diff:Number, quiet:Boolean, nodebt:Boolean) { coreGame.SMMoney(diff, quiet, nodebt); }
	
	// Other
	private function Points(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number, SexualEnergy:Number) { coreGame.Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy); }
	private function SMPoints(attack:Number, defence:Number, arousaldef:Number, constitution:Number, conversation:Number, lust:Number, corrupt:Number, renown:Number, dominance:Number, charisma:Number, refinement:Number, nymphomania:Number, tiredness:Number, sexualenergy:Number) { coreGame.SMData.SMPoints(attack, defence, arousaldef, constitution, conversation, lust, corrupt, renown, dominance, charisma, refinement, nymphomania, tiredness, sexualenergy); }
			
	private function PerformActNow(slave, act, lesbian:Boolean, genericonly:Boolean, place:Number, align:Number, frame:Number) { Language.XMLData.PerformActNow(slave, act, lesbian, genericonly, place, align, frame); }

	private function DefaultLesbian(chance:Number) : Boolean { 
		if (coreGame.Lesbian == false) return false;
		return DefaultGeneric(chance);
	}
	private function DefaultGeneric(chance:Number) : Boolean { 
		if (coreGame.UseGeneric || chance == undefined || Math.floor(Math.random()*100) < chance) {
			coreGame.UseGeneric = true;
			return true;
		}
		return false;
	}
	
	private function IsDayTime() : Boolean { return coreGame.IsDayTime(); };
	private function IsSupervising() : Boolean { return coreGame.Supervise; };
	
	// Get instances of other modules, places or people
	// note: GetOtherModule is unused and may not be used
	//private function GetOtherModule(str:String) : SlaveModule { return coreGame.modulesList.GetEventData(str); }
	private function GetTraining(str:String) : Object { return coreGame.modulesList.GetTraining(str); }
	private function GetPlace(str:String) : Place { return coreGame.currentCity.GetPlaceObject(str); }
	private function GetPerson(str:String) : Object { return coreGame.People.GetPersonsObject(str); }
	private function GetShop(str:String) : Object { return coreGame.currentCity.GetShopInstanceString(str); }
		
	// Sounds
	private function PlaySound(snd:String, repeats:Number, cnt:Number, vol:Number, delay:Number, timer:Number) { coreGame.Sounds.PlaySound(snd, repeats, cnt, vol, delay, timer); }
	private function Beep() { coreGame.Sounds.Beep(); }
	private function Bloop() { coreGame.Sounds.Bloop(); }
	
	// Events
	
	private function SetEvent(enum:Object) { coreGame.SetEvent(enum); }
	private function DoEvent(oEvno:Object, tgt:Object) { coreGame.DoEvent(oEvno, tgt); }
	private function DoYesNoEvent(oEvno:Object) { coreGame.DoYesNoEvent(oEvno);	}
	private function DoYesNoEventXY(oEvno:Object) {	coreGame.DoYesNoEventXY(oEvno);	}
	
	private function AskHerQuestions(Event1:Object, Event2:Object, Event3:Object, Event4:Object, Event1Label:String, Event2Label:String, Event3Label:String, Event4Label:String, Caption:String, Event5:Object, Event5Label:String) { coreGame.AskHerQuestions(Event1, Event2, Event3, Event4, Event1Label, Event2Label, Event3Label, Event4Label, Caption, Event5, Event5Label); } // OBSOLETE
	private function ResetQuestions(strCaption:String) { coreGame.ResetQuestions(strCaption); }
	private function AddQuestion(evno:Object, strLabel:String, evtarget:Object, param:Object) { coreGame.AddQuestion(evno, strLabel, evtarget, param); }
	private function ShowQuestions(strCaption:String, bMain:Boolean) : Number {	return coreGame.ShowQuestions(strCaption, bMain); }
		
	public function IsTentacleEvent() : Boolean	{ return coreGame.TentaclesOn != 0 && PercentChance(coreGame.TentacleFrequency); }
	
	public function IsEventPicked() : Boolean { return (coreGame.NumEvent != 0 || coreGame.StrEvent != "" || coreGame.ObjEvent != null); }
	public function ResetEventPicked() { coreGame.NumEvent = 0; coreGame.StrEvent = "";	coreGame.ObjEvent = null; }
	
	// participants in the current act
	private function IsPartnerFemale() : Boolean { return coreGame.PersonGender == 2 || coreGame.PersonGender == 3; }
	private function IsPartnerMale() : Boolean { return coreGame.PersonGender == 1 || coreGame.PersonGender == 4; }	
	private function IsParticipant(part) : Boolean { return coreGame.IsParticipant(part); }

	// Bit Flags - OBSOLETE
	
	private function CheckBitFlag1(flag:Number) : Boolean { return coreGame.BitFlag1.CheckBitFlag(flag); }
	private function SetBitFlag1(flag:Number) {	coreGame.BitFlag1.SetBitFlag(flag);	}
	private function ClearBitFlag1(flag:Number) { coreGame.BitFlag1.ClearBitFlag(flag);	}
	private function CheckAndSetBitFlag1(flag:Number) : Boolean { return coreGame.BitFlag1.CheckAndSetBitFlag(flag); }
	
	// bitflags 2 (for girl use) - OBSOLETE
	
	private function CheckBitFlag2(flag:Number) : Boolean {	return coreGame.BitFlag2.CheckBitFlag(flag); }
	private function SetBitFlag2(flag:Number) {	coreGame.BitFlag2.SetBitFlag(flag);	}
	private function ClearBitFlag2(flag:Number)	{ coreGame.BitFlag2.ClearBitFlag(flag);	}
	private function CheckAndSetBitFlag2(flag:Number) : Boolean	{ return coreGame.BitFlag2.CheckAndSetBitFlag(flag); }
}