// Lake
// Linked to Walk-Lake.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceLake extends Place
{
	// Constructor
	public function PlaceLake(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to Walk-Lake.swf, xml node Lake, id 2, x = 20, y = 260
		super("Lake", null, cg, 2, true, "", 20, 260, cc);		
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(10);
	}
	
	public function Load(lo:Object)
	{
		super.Load(lo);

		var len:Number = arEventIndex.length;
		var pe:PlaceEvent;
		for (var i:Number = 0; i < len; i++) {
			pe = arEventIndex[i]; 
			// skip illegal events
			if (pe.strName != "Night-Elf" && pe.strName.indexOf("Night-Elf") != -1) pe.NoRepeatEvent();
		}
	}


	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		EventDefault = "MeetAngel-5.5";	// set default event
		
		AddEvent("NakedApron-1");
		AddEvent("GetApron-1.5", true);
		AddEvent("Swim-2");
		AddEvent("Robbed-2.5", true);
		AddEvent("MeetOddTeacher-4");
		AddEvent("NymphsTears-4.5", true);
		AddEvent("MeetAngelwithHolyItems-5");
		AddEvent("MeetAngel-5.5", true);
		AddEvent("MeetCount-6");
		AddEvent("MeetCountIgnored-6.5", true);
		
		RepeatEvent("Night-Elf");
	}
	
	// Walking at the Lake
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4106);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkLake++;
		coreGame.EventTotal = slaveData.TotalWalkLake;
		
		// Select the event and show it
		super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		if (slaveData.BitFlag1.CheckBitFlag(20) && SMData.BitFlagSM.CheckBitFlag(4) && coreGame.temp < 40) coreGame.NumEvent = 4;
		else super.GetWalkEvent(exclude, sequential);

		// Special case, override some xml events to get the apron
		if ((slrandom(100) < 20) && (slaveData.VarCooking >= (30 + coreGame.Difficulty)) && (slaveData.ApronOK == 0)) coreGame.SetEvent("GetApron-1.5");

		if (!IsEventPicked()) return;
		
		if (coreGame.NumEvent == 1 && (slaveData.VarCooking >= (30 + coreGame.Difficulty)) && (slaveData.ApronOK == 0)) coreGame.SetEvent("GetApron-1.5");
		else if (coreGame.NumEvent == 2 && Math.floor(Math.random()*2)) coreGame.SetEvent("Robbed-2.5");
		else if (coreGame.NumEvent == 4 && slaveData.VarIntelligence <= (30 + coreGame.Difficulty)) coreGame.SetEvent("NymphsTears-4.5");
		else if (coreGame.NumEvent == 5 && (slaveData.AngelsTearWorn == 0 && slaveData.HaloWorn == 0)) coreGame.SetEvent("MeetAngel-5.5");
		else if (coreGame.NumEvent == 6 && slaveData.VarReputation <= (40 + coreGame.Difficulty)) coreGame.SetEvent("MeetCountIgnored-6.5");
	}
	
	public function HandleWalk() : Boolean
	{
		coreGame.SMTRACE("Lake::HandleWalk " + coreGame.StrEvent);
		
		if (super.HandleWalk()) return true;
		
		switch (coreGame.StrEvent) {
			
		case "NakedApron-1":
			ShowPerson(5, 0, 1, 1);
			Points(0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			coreGame.UseGeneric = false;
			if (coreGame.SlaveGirl.ShowNakedApron() != true) coreGame.Generic.ShowNakedApron();
			if (slaveData.ApronOK == 1) {
				AddText("#slaveA fell into the lake and muddies " + coreGame.SlaveHisHerSingle + " clothes. The kind and gentle maid who gifted #slavehimher the apron is walking nearby and takes #slave to her nearby home and helps " + coreGame.SlaveName1 + " to wash " + coreGame.SlaveHisHerSingle + " clothes. She does insist " + coreGame.SlaveName1 + " wear " + coreGame.SlaveHisHerSingle + " apron while helping, " + coreGame.SlaveName1 + " wears <i>only</i> the apron, claiming " + coreGame.SlaveHeSheHas + " nothing else to wear.");
			} else {
				AddText(coreGame.SlaveName2 + " slips in a puddle and muddies " + coreGame.SlaveHisHerSingle + " clothes. ");
				if (coreGame.Maid.IsVisited()) AddText("Sumi, the kind and gentle maid, that #slaveheshe has met before,  is walking nearby");
				else AddText("A kind and gentle maid is walking nearby, and she introduces herself as Sumi");
				AddText(". Sumi takes #slave to her nearby home and helps " + coreGame.SlaveName2 + " to wash " + coreGame.SlaveHisHerSingle + " clothes.\r\rShe loans " + coreGame.SlaveName2 + " an apron to wear while helping, " + coreGame.SlaveName2 + " wears <i>only</i> the apron, claiming " + coreGame.SlaveHeSheHas + " nothing else to wear.");
			}
			coreGame.Maid.SetVisited();
			coreGame.Lake.SetBitFlag(33);
			return true;
			
		 case "GetApron-1.5":
			if (coreGame.Maid.IsVisited()) AddText(coreGame.SlaveMeet + " Sumi, the kind and gentle maid, that " + coreGame.SlaveHeSheHas + " met before");
			else AddText(coreGame.SlaveMeet + " a kind and gentle maid who introduces herself as Sumi,");
			AddText(" and they talk for a while. The maid is impressed with #slave's knowledge of housekeeping and congratulates #slavehimher and gives #slave her own apron");
			if (coreGame.Lake.CheckBitFlag(33)) AddText(", the same apron #slave has worn before. The maid comments a little embarrassed that #slaveheshe should wear other protective clothing too");
			AddText(".\r\rThe maid talks about how #slave now has the true badge of a maid that #slaveheshe may wish to <b>visit</b> sometime and they could talk about maid work and the like. " + coreGame.SlaveName + coreGame.NonPlural(" understand") + " that she is a gentle woman and would be reluctant to talk much with someone who is not also caring and considerate.");
			slaveData.ApronOK = 1;
			coreGame.Maid.SetAccessible();
			coreGame.Maid.SetVisited();
			coreGame.Items.ShowItem(13, 1);
			ShowPerson(5, 0, 1, 1);
			return true;
			
			
		case "NymphsTears-4.5":
			var tempstr:String;
			if (coreGame.Lake.CheckBitFlag(32)) tempstr = "who gives #slavehimher another dose of the powerful natural aphrodisiac called 'Nymph's Tears'. The Tutor says the sexual rush is unsurpassable.";
			else tempstr = "who gives #slavehimher a natural potion called 'Nymph's Tears'. The Tutor seemed flushed and excited when she gives it, promising a wonderful experience.";
			tempstr += "\r\r<i>The 'Nymph's Tears' can now be used whenever you wish, choose the 'Drink Potion' option in your slave's equipment.</i>";
			SMData.ChangePotionOwned(12, coreGame.SlaveGender > 3 ? 2 : 1);
			SMData.BitFlagSM.SetBitFlag(4);
			if (coreGame.MeetOddTeacher(2, tempstr)) return true;
			coreGame.AutoAttachAndShowMovie("ClipRumours", 1, 0, 1);
			return true;
			
		case "MeetCount-6":
			ShowSupervisor();
			ShowPerson(7, 1, 1, slrandom(2));
			Points(0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			AddText(coreGame.SlaveMeet + " the Count who was taking a walk. They discuss the beauty of the lake.");
			if (coreGame.SlaveFemale) AddText("\r\rOnce or twice #slave" + coreGame.NonPlural(" think") + " " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " him looking at #slavehisher breasts.");
			coreGame.NobleLoveEvent(7);
			return true;
			
		case "MeetCountIgnored-6.5":
			ShowSupervisor();
			ShowPerson(7, 1, 1, 1);
			AddText(coreGame.SlaveMeet + " the Count but he didn't even pay attention to #slavehimher.");
			return true;
	
		case "MeetAngelwithHolyItems-5":
			ShowSupervisor();
			ShowPerson(34, 1, 1, Math.floor(Math.random()*3) + 1);
			AddText(coreGame.SlaveMeet + " an Angel near the lake who notices #slave's heavenly items. The Angel blesses #slavehimher and #slaveheshe collapses to the ground in ecstasy.\r\rLater " + coreGame.SlaveHeShe + coreGame.NonPlural(" recover") + " and the Angel is gone.");
			Points(0, 4, 0, 0, 4, -2, 0, 0, 0, 0, 0, 0, -1, 0, -5, 0, 4, 1, 0, 0);
			return true;
			
		case "MeetAngel-5.5":
			ShowSupervisor();
			ShowPerson(34, 1, 1, Math.floor(Math.random()*3) + 1);
			AddText(coreGame.SlaveSee + " an angelic figure floating above the lake. The sight fills #slavehimher with peace and contentment.");
			Points(0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, -2, 0, 0, 0);
			return true;
		}
		
		return false;
	}
}