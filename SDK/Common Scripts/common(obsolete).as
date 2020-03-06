//---------------------------------------
// Helper functions
// Note these are already included in the SlaveModule class
//---------------------------------------

// random numbers
// 1 to rnd
function slrandom(rnd:Number) : Number
{
	return int(Math.random()*rnd) + 1;
}

// Text Functions

function AddTextToStart(pstring:String)
{
	_root.AddTextToStart(pstring);
}

function AddTextToStartGeneral(pstring:String)
{
	_root.AddTextToStartGeneral(pstring);
}

function SetText(nstring:String)
{
	_root.SetText(nstring);
}

function SetGeneralText(nstring:String)
{
	_root.SetGeneralText(nstring);
}

function AddText(nstring:String)
{
	_root.AddText(nstring);
}

function PersonSpeakStart(person:String, say:String, newl:Boolean)
{
	_root.PersonSpeakStart(person, say, newl);
}

function PersonSpeakEnd(say:String)
{
	_root.PersonSpeakEnd(say);
}

function PersonSpeak(person:String, say:String, newl:Boolean)
{
	_root.PersonSpeak(person, say, newl);
}

function SlaveSpeakStart(say:String, newl:Boolean)
{
	_root.SlaveSpeakStart(say, newl);
}

function SlaveSpeakEnd(say:String)
{
	_root.SlaveSpeakEnd(say);
}

function SlaveSpeak(say:String, newl:Boolean)
{
	_root.SlaveSpeak(say, newl);
}

function ServantSpeak(say:String, newl:Boolean)
{
	_root.ServantSpeak(say, newl)
}

function ServantSpeakStart(say:String, newl:Boolean)
{
	_root.ServantSpeakStart(say, newl);
}

function SlaveVerb(say:String)
{
	_root.SlaveVerb(say);
}

function BlankLine() { _root.AddText("\r\r"); }

// Bit Flags

function CheckBitFlag1(flag:Number) : Boolean
{
	return _root.CheckBitFlag1(flag);
}

function SetBitFlag1(flag:Number)
{
	_root.SetBitFlag1(flag);
}

function ClearBitFlag1(flag:Number)
{
	_root.ClearBitFlag1(flag);
}

function CheckAndSetBitFlag1(flag:Number) : Boolean
{
	return _root.CheckAndSetBitFlag1(flag);
}

// bitflags 2 (for girl use)
function CheckBitFlag2(flag:Number) : Boolean
{
	return _root.CheckBitFlag2(flag);
}

function SetBitFlag2(flag:Number)
{
	_root.SetBitFlag2(flag);
}

function ClearBitFlag2(flag:Number)
{
	_root.ClearBitFlag2(flag);
}

function CheckAndSetBitFlag2(flag:Number) : Boolean
{
	return _root.CheckAndSetBitFlag2(flag);
}

// Events

function DoEvent(enum:Number)
{
	_root.DoEvent(enum);
}

function DoYesNoEvent(enum:Number)
{
	_root.DoYesNoEvent(enum);
}

function DoYesNoEventXY(enum:Number)
{
	_root.DoYesNoEventXY(enum);
}

function AskHerQuestions(Event1:Number, Event2:Number, Event3:Number, Event4:Number, Event1Label:String, Event2Label:String, Event3Label:String, Event4Label:String, Caption:String, Event5:Number, Event5Label:String)
{
	 _root.AskHerQuestions(Event1, Event2, Event3, Event4, Event1Label, Event2Label, Event3Label, Event4Label, Caption, Event5, Event5Label);
}

// Images

function ShowMovie(movie:MovieClip, placeo:Object, align:Number, gframe:Number)
{
	_root.ShowMovie(movie, placeo, align, gframe);
}

// Stats
function Points(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number)
{
	_root.Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special);
}

function ALIFShowMovie(movie:String, place:Number, align:Number) : MovieClip
{
	if (_root.ImageFolder != "") movie = _root.ImageFolder + "/" + movie;
	return _root.AutoLoadImageAndShowMovie(image, movie, place, align);
}

