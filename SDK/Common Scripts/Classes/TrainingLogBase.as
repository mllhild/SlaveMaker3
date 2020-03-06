// Log of actions
// Translation status: COMPLETE

// Abstact Base class. never create this object it is use to hold a reference object and purely used in BaseModule class

import Scripts.Classes.*;

class TrainingLogBase
{
	// Primary methods to add a diary entry
	
	public function AddEntry(desc:String, tent:Boolean, win:Number, test:Boolean, flag:Number)	{ }
	
	public function AddEntryFull(desc:String, gdate:Number, tent:Boolean, win:Number, test:Boolean, flag:Number) { }
	
	public function AddEntryLang(desc:String, tent:Boolean, win:Number, test:Boolean, flag:Number) { }
	
	public function AddEntryFullLang(desc:String, gdate:Number, tent:Boolean, win:Number, test:Boolean, flag:Number) { }
	
	public function GetTrainingArray() : Array { return null; }
	
	// Load/Save
	public function Load(lo:Object)	{ }
	public function Save(so:Object)	{ }
}
