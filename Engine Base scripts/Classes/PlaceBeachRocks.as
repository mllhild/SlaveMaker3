// Beach (Rocks)
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceBeachRocks extends PlaceBeach
{
	// constructor
	public function PlaceBeachRocks(mc:MovieClip, cg:Object, cc:City)
	{
		super("BeachRocks", mc, cg, 9.4, cc);
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		ResetEvents();
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "Day-Pleasant-1";	// set default event

		this.AddEvent("Day-Pleasant-1");
		this.AddEvent("Day-FurryReptile-2");
		this.AddEvent("Night-Dangerous-3");
		
	}
	
	public function WalkOnRocks() {
		coreGame.WalkPlace = 9.4;
		
		super.DoWalkLoaded(this.mcBase,this.ModuleName);
	}
	
	public function HandleWalk():Boolean {
		SMTRACE("BeachRocks::HandleWalk "+coreGame.StrEvent);

		switch (coreGame.StrEvent) {

		case "Day-FurryReptile-2":
			coreGame.DoEventNext(8505);
			return true;
		}
		
	}

	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// 4303 - walk beach rocks
			case 4303:
				ResetWalkEvent();
				WalkOnRocks();
				return true;
		}
		return false;
	}
	
}