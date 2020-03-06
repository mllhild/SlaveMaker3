// Docks (Slave Pens)
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class PlaceDocksSlavePens extends PlaceDocks
{
	// constructor
	public function PlaceDocksSlavePens(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to xml node DocksSlavePens, id 6.2
		super("DocksSlavePens", mc, cg, 6.2, cc);
		trace("Create DocksSlavePens");
		Accessible = false;
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(1); //, 33);
	}
		
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "NothingSpecial-8";	// set default event

		this.AddEvent("BigBreastedSlave-1");
		this.AddEvent("Sareth-2.1");
		this.AddEvent("Sareth-2.2");
		this.AddEvent("BoundPair-3");
		this.AddEvent("BoundSlave-4");
		this.AddEvent("MerchantSlave-5");
		this.AddEvent("MeetBHPony-6");
		this.AddEvent("MeetNun-7");
		this.AddEvent("NothingSpecial-8");
		if (coreGame.RuinedTemple.CheckBitFlag(0)) {
			this.NoRepeatEvent("Sareth-2.1");
			this.NoRepeatEvent("Sareth-2.2");
		}
	}
	
		// Walking at the Port
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4102);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkDocks++;
		coreGame.EventTotal = slaveData.TotalWalkDocks;
		
		// Select the event and show it
		super.DoWalkLoaded(mc, "");
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		if ((!coreGame.DocksSlavePensSecure.IsAccessible()) || (Math.floor(Math.random()*3) < 2)) super.GetWalkEvent(exclude, true);
		else if (coreGame.NumEvent > 100) {
			coreGame.NumEvent = coreGame.NumEvent - 100;
			super.GetWalkEvent(exclude, true);
		} else super.GetWalkEvent(exclude, false);
		trace("GetWalkEvent: " + coreGame.NumEvent + " " + coreGame.StrEvent);
	}
	
}