// Log of actions
// Translation status: COMPLETE

import Scripts.Classes.*;

class TrainingLog
{
	public var coreGame:Object;			// core game engine
	private var arTrainingArray:Array;			// current list of TrainingLogEntry objects
	private var Language:GameLanguageBase;		// common strings, translation tools and text functions
	
	// Constructor
	public function TrainingLog(cg:Object)
	{ 
		coreGame = cg;
		Reset();
	}
	
	// Reset on new slave
	public function Reset()
	{
		if (arTrainingArray.length != undefined) {
			var tle:TrainingLogEntry;
			for (var i:Number = 0; i < arTrainingArray.length; i++) { 
				tle = TrainingLogEntry(arTrainingArray.pop());
				delete tle;
			}
		}
		delete arTrainingArray;
		arTrainingArray = new Array();
		Language = coreGame.Language;
	}
	
	// remove future events
	public function ClearFutureEntries()
	{
		var i:Number = 0;
		while (i < arTrainingArray.length) {
			if (arTrainingArray[i].LogDate > coreGame.GameDate) arTrainingArray.splice(i, 1);
			else i++;
		}
	}
	
	// Load/Save
	public function Load(lo:Object)
	{
		Reset();
		for (var i:Number = 0; i < lo.arTrainingArray.length; i++) { 
			var ldd:Object = lo.arTrainingArray[i];
			var newentry:TrainingLogEntry = new TrainingLogEntry();
			newentry.Load(ldd);
			arTrainingArray.push(newentry);
		}
	}
	public function Save(so:Object)
	{
		so.arTrainingArray = new Array();
		for (var i:Number = 0; i < arTrainingArray.length; i++) { 
			var newentry:Object = new Object();
			var tle:TrainingLogEntry = arTrainingArray[i];
			tle.Save(newentry);
			so.arTrainingArray.push(newentry);
		}
	}

	
	// Primary methods to add/remove a diary entry
	
	public function AddEntry(desc:String, tent:Boolean, win:Number, test:Boolean, flag:Number)
	{
		arTrainingArray.push(new TrainingLogEntry(coreGame.UpdateMacros(desc), coreGame.GameDate, tent, win, test, flag));
	}
	
	public function AddEntryFull(desc:String, gdate:Number, tent:Boolean, win:Number, test:Boolean, flag:Number)
	{
		arTrainingArray.push(new TrainingLogEntry(coreGame.UpdateMacros(desc), gdate, tent, win, test, flag));
	}
	
	public function AddEntryLang(desc:String, tent:Boolean, win:Number, test:Boolean, flag:Number)
	{
		arTrainingArray.push(new TrainingLogEntry(Language.GetHtml(desc, "Diary"), coreGame.GameDate, tent, win, test, flag));
	}
	
	public function AddEntryFullLang(desc:String, gdate:Number, tent:Boolean, win:Number, test:Boolean, flag:Number)
	{
		arTrainingArray.push(new TrainingLogEntry(Language.GetHtml(desc, "Diary"), gdate, tent, win, test, flag));
	}

	
	// Get the full list of entries (mainly for use in dialogues
	public function GetTrainingArray() : Array { return arTrainingArray; }

	
	// XML statement parser
	// to add entries to the log
	
	public function ParseDiary(aNode:XMLNode)
	{
		var tent:Boolean = false;
		var win:Number = undefined;
		var test:Boolean = false;
		var date:Number = 0;
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "tentacles") tent = aNode.attributes[attr].toLowerCase() == "true";
			else if (attr.toLowerCase() == "winner") win = Number(aNode.attributes[attr]);
			else if (attr.toLowerCase() == "ownertest") test = aNode.attributes[attr].toLowerCase() == "true";
			else if (attr.toLowerCase() == "date") date = Language.XMLData.GetExpression(aNode.attributes[attr]);
		}
		if (date != 0) AddEntryFull(aNode.firstChild.nodeValue, date, tent, win, test);
		else AddEntry(aNode.firstChild.nodeValue, tent, win, test);
	}
}
