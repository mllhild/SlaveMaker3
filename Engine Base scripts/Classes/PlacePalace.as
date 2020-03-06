// Palace
//
// Translation status: INCOMPLETE
//
// BitFlags
//
// Palace
//  32  = Natsu 1
//  33	= hunt catburgler
//	34	= hunt night 2+
//  35-39 - hunt events
//

import Scripts.Classes.*;

class PlacePalace extends Place
{
	// constructor
	public function PlacePalace(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to no swf, xml node Palace, id 5, x = 220, y = 120
		super("Palace", mc, cg, 5, true, "", 220, 120, cc);

	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(10);
		SetAccessible(true);

	}
	
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "MeetLadyOkyanu-4";	// set default event. xml event via Evemts.xml
		
		if (!coreGame.FurriesOn) this.NoRepeatEvent(10);
		this.AddEvent("MeetLord-1");
		this.AddEvent("MeetKnight-3");
		this.AddEvent("MeetKnightDragonRing-3.5", true);
		this.AddEvent("MeetOddTeacherGivePonyTail-5");
		this.AddEvent("MeetOddTeacherTailPlay-5.1", true);
		this.AddEvent("MeetOddTeacherDisappointed-5.2", true);
		this.AddEvent("MeetOddTeacherPatBehind-5.3", true);
		this.AddEvent("MeetNun-6");
		this.AddEvent("MeetRefinementTeacher-7");
		this.AddEvent("MeetDancer-8");
		this.AddEvent("MeetXXXOwner-9");
		this.AddEvent("FurryCat-10");
		this.AddEvent("FurryBondagePalace-13");
	}
	
		// Walking in the Palace
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4107);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkPalace++;
		coreGame.EventTotal = slaveData.TotalWalkPalace;
		
		// Select the event and show it
		super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude, sequential);

		if (!IsEventPicked()) return;
		
		if (coreGame.NumEvent == 10 && !SMData.BitFlagSM.CheckBitFlag(8)) coreGame.SetEvent("MeetXXXOwner-9");
		if ((coreGame.BitFlag1.CheckBitFlag(20) && SMData.BitFlagSM.CheckBitFlag(4) && coreGame.temp < 35)) coreGame.SetEvent("MeetOddTeacherGivePonyTail-5");
		if (coreGame.NumEvent == 5) {
			if (SMData.PonygirlAware == 1) {
				if (coreGame.PonyTailOK == 0) coreGame.SetEvent("MeetOddTeacherGivePonyTail-5");
				else {
					if (coreGame.PonyTailWorn == 1) coreGame.SetEvent("MeetOddTeacherTailPlay-5.1");
					else coreGame.SetEvent("MeetOddTeacherDisappointe-5.2");
				}
			} else coreGame.SetEvent("MeetOddTeacherPatBehind-5.3");
		} else if (coreGame.NumEvent == 3 && (coreGame.VarTemperamentRounded > 19 && coreGame.DragonRingOK == 0)) coreGame.SetEvent("MeetKnightDragonRing-3.5");
	}
	
	public function HandleWalk() : Boolean
	{
		SMTRACE("Palace::HandleWalk " + coreGame.StrEvent);
		
		switch (coreGame.StrEvent) {
			
		case "MeetKnight-3":
		case "MeetKnightDragonRing-3.5":
			ShowSupervisor();
			if (coreGame.NumEvent == 3) {
				ShowPerson(6, 1, 1, Math.floor(Math.random()*2) + 1);
				Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText(coreGame.SlaveMeet + " a Knight who lectures #slavehimher on valour and tries to make #slavehimher walk the honourable path.");
			} else {
				ShowPerson(6, 0, 1, slrandom(2));
				AddText(coreGame.SlaveMeet + " a Knight who liked #slavehisher personality and gave #slavehimher " + coreGame.Plural("a strange ring") + " that he says will temper #slavehisher determination.");
				coreGame.DragonRingOK = 1;
				coreGame.Items.ShowItem(12, true);
			}
			if (coreGame.NobleLoveType == 6) {
				coreGame.NobleLoveEvent(6);
				parentCity.MeetPerson(6, 0, "Knight");
			}
			return true;

			
		case "MeetOddTeacherGivePonyTail-5":
			HideBackgrounds();
			coreGame.DifficultyBondage = coreGame.DifficultyBondage - 5;
			coreGame.PonyTailOK = 1;
			coreGame.Items.ShowItem(1, true, 4, 2);
			Points(0, 0, -1, 0, -1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
			coreGame.MeetOddTeacher(5, "who talks of the joys of bondage and gives #slave a tail for ponyslaves.\r\rShe tells #slave about a certain stable in the upper-class part of the city. This stable is reserved for ponyslaves and the stable-hand sells some specialty items, but only for ponyslaves and their owners.\r\r" + coreGame.SlaveName + coreGame.NonPlural(" wonder") + " what she teaches...");
			ShowPerson(29, 1, 2);
			ShowSupervisor();
			return true;
			
		case "MeetOddTeacherTailPlay-5.1":
			Points(0, 0, -1, 0, -1, 0, 0, 0, 0, 0, 1, 0, 1, 0, -5, 0, 2, 0, 0, 0);
			if (coreGame.HasCock) {
				if (coreGame.SlaveGender > 3) coreGame.MeetOddTeacher(5, "who pats #slave on their behinds. She then slowly twists and pulls #slave's pony tails, caressing them both until they explosively cum, spurting cum over each other.\r\rShe says 'Did you enjoy the lesson?'");
				else coreGame.MeetOddTeacher(5, "who pats #slave on the behind. She then slowly twists and pulls #slave's pony tail, caressing #slavehimher until #slaveheshe explosively orgasms.\r\rShe says 'Did you enjoy the lesson?'");
			} else { 
				if (coreGame.SlaveGender > 3) coreGame.MeetOddTeacher(5, "who pats #slave on their behinds. She then slowly twists and pulls #slave's pony tails, caressing them both until they explosively orgasm.\r\rShe says 'Did you enjoy the lesson?'");
				else coreGame.MeetOddTeacher(5, "who pats #slave on the behind. She then slowly twists and pulls #slave's pony tail, caressing #slavehimher until #slaveheshe explosively orgasms.\r\rShe says 'Did you enjoy the lesson?'");
			}
			return true;
			
			
		case "FurryCat-10":
			if (this.GetEventTotal(10) == 0) coreGame.DoEventNext(8502);
			else if (this.GetEventTotal(10) == 1) coreGame.DoEventNext(8503);
			else {
				 coreGame.DoEventNext(8504);
				 NoRepeatEvent(10);
			}
			return true;
			
		case "FurryBondagePalace-13":
			coreGame.DoEventNext(8506);
			return true;
			
		}
				
		return false;
	}
}