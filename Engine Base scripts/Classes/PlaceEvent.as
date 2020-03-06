// PlaceEvent - a single evnet for a place/person
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class PlaceEvent {
	public var strName:String;
	private var nTotal:Number;
	public var nTotalToday:Number;
	private var bRepeatable:Boolean;
	private var bSelectable:Boolean;
	
	public function PlaceEvent(str:String, tot:Number, rpt:Boolean, sel:Boolean) { 
		strName = str + "";
		nTotal = tot == undefined ? 0 : tot;
		bRepeatable = rpt == undefined ? true : rpt;
		bSelectable = sel == undefined ? true : sel;
		nTotalToday = 0;
	}
	
	public function IsEventDone() : Boolean { return nTotal > 0; }
	public function IsEventRepeatable() : Boolean { return bRepeatable; }
	public function NoRepeatEvent() { bRepeatable = false; }
	public function RepeatEvent() { bRepeatable = true; }
	public function SetEventDone() { nTotal++; nTotalToday++; }
	public function SetEventTotal(count:Number) { nTotal = count; }
	public function GetEventTotal() : Number { return nTotal; }
	public function GetEventTotalToday() : Number { return nTotalToday; }

	public function Load(so:Object)
	{
		strName = so.strName + "";
		nTotal = so.nTotal;
		bRepeatable = so.bRepeatable;
		bSelectable = so.bSelectable;
	}
	
	public function Save(so:Object)
	{
		so.strName = strName + "";
		so.nTotal = nTotal;
		so.bRepeatable = bRepeatable;
		so.bSelectable = bSelectable;
	}

}