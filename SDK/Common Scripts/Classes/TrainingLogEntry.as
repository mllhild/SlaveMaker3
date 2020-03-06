// A training record entry
// Translation status: COMPLETE

import Scripts.Classes.*;

class TrainingLogEntry {
	public var Description:String;
	public var LogDate:Number;
	public var Tentacle:Boolean;
	public var OwnerTest:Boolean;
	public var Winner:Number;
	public var Flag:Number;
	
	public function TrainingLogEntry(desc:String, gdate:Number, tent:Boolean, win:Number, test:Boolean, flag:Number) { 
		LogDate = gdate;
		Description = desc;
		Tentacle = tent == undefined ? false : tent;
		Winner = win == undefined || win > 3 ? 0 : win;
		OwnerTest = test == undefined ? false : test;
		Flag = flag == undefined ? 0 : flag;
	}
	public function Load(lo:Object)
	{
		Description = lo.Description;
		LogDate = lo.LogDate;
		Tentacle = lo.Tentacle;
		OwnerTest = lo.OwnerTest;
		Winner = lo.Winner;
		Flag = lo.Flag;
	}
	public function Save(so:Object)
	{
		so.Description = Description;
		so.LogDate = LogDate;
		so.Tentacle = Tentacle;
		so.OwnerTest = OwnerTest;
		so.Winner = Winner;
		so.Flag = Flag;
	}
}