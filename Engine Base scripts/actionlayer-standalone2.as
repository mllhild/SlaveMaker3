import Scripts.Classes.*;
// Standalone version

// 1 to rnd
function slrandom(rnd:Number) : Number
{
	return int(Math.random()*rnd) + 1;	// int is faster
}

function PercentChance(chance:Number) : Boolean
{
	return (Math.random()*100) < chance;
}

//// General use array, mostly contains movieclips
var arGeneralArray:Array;
var arGeneralArray2:Array;

arGeneralArray = new Array();
arGeneralArray2 = new Array();

function ClearGeneralArray()
{
	var mc:MovieClip;
	var obj:Object;
	i = arGeneralArray.length;
	while (--i >= 0) {
		obj = arGeneralArray.pop();
		if (typeof(obj) == "movieclip") {
			mc = MovieClip(obj);
			mc.removeMovieClip();
			delete obj;
		}
	}
	delete arGeneralArray;
	arGeneralArray = new Array();
}
function ClearGeneralArray2()
{
	var mc:MovieClip;
	var obj:Object;
	i = arGeneralArray2.length;
	while (--i >= 0) {
		obj = arGeneralArray2.pop();
		if (typeof(obj) == "movieclip") {
			mc = MovieClip(obj);
			mc.removeMovieClip();
			delete obj;
		}
	}
	delete arGeneralArray2;
	arGeneralArray2 = new Array();
}

function Reset()
{
	currentDialog = null;
	citiesList.Reset();
	
	clearInterval(intervalId);
	clearInterval(intervalId2);
	clearInterval(intervalId3);
	clearInterval(intervalId4);
	
	Timers.StopAlTimers();
	
	People.Reset();
}

// save game/load object
function GetSaveData(so:String) : SharedObject
{
	return SharedObject.getLocal(so);
}

function StopSubMovie(mcs:MovieClip)
{
	mcs._visible = true;
	var mc:MovieClip;
	for (var mv:String in mcs) {
		if (typeof(mcs[mv]) == "movieclip") {
			mc = mcs[mv];
			if (mc != _root) {
				mc.gotoAndStop(1);
				mc._visible = false;
			}
		}
	}
	mcs._visible = false;
}

// Events

function GetFreeEvent() : Number
{
	return ++nLastAllocatedEvent;
}

// Times

function GetUTCMSElapsed(start:Boolean) : Number
{
	if (start == true) utclast = 0;
	var today_date:Date = new Date();
	var diff:Number = today_date.valueOf() - utclast;
	if (utclast == 0) diff = 0;
	utclast = today_date.valueOf();
	return diff;
}

// Tracing
var strLOG:String = "";

function SMTRACE(s:Object)
{
	trace(s);
	
	if (!dspMain.IsGameTabShown(1)) return;
	strLOG += s + "\r";
}
function SMTRACEALWAYS(s:Object)
{
	trace(s);
	strLOG += s + "\r";
}

// End Standalone
