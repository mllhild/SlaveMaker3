// Farm
// Linked to Walk-Farm.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceFarm extends Place
{
	// Constructor
	public function PlaceFarm(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to Walk-Farm.swf, xml node Farm, id 7, x = 20, y = 20
		super("Farm", mc, cg, 7, true, "Engine/Walk-Farm.swf", 20, 20, cc);

	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(7);
	}
	
	// Images
	public function HideImages()
	{
		this.mcBase.WalkCowgirl._visible = false;
		this.mcBase.Demon._visible = false;
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "Event1-1";	// set default event

		this.AddNumberedEvents(7);
		if (!coreGame.PonygirlsOn) this.NoRepeatEvent(1);
		this.AddEvent("Event1.5-1.5");
	}
	// Walking in the Farm
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4104);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkFarm++;
		coreGame.EventTotal = slaveData.TotalWalkFarm;
		
		// Select the event and show it
		super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude, sequential);

		if (slaveData.FairyMeeting == 3 || slaveData.FairyMeeting == 63) coreGame.SetEvent("FaerieRescueFarm");
		else if (!slaveData.BitFlag1.CheckBitFlag(6) && (coreGame.Milkable && coreGame.VarConstitutionRounded > 29)) coreGame.NumEvent = 6;

		if (!IsEventPicked()) return;
		
		if (coreGame.NumEvent == 4 && (coreGame.VarReputationRounded <= (40 + coreGame.Difficulty))) coreGame.NumEvent = 4.5;
		else if (coreGame.NumEvent == 6) {
			if (coreGame.BitFlag1.CheckBitFlag(6) && slaveData.TotalMilked == 0) coreGame.NumEvent = 6.5;
			else coreGame.NumEvent = ((coreGame.Milkable && coreGame.VarConstitutionRounded > 29 && Math.floor(Math.random()*2) == 1) || (slaveData.MilkInfluence > 0 && slaveData.MilkInfluence < 1000)) ? 6 : 6.5;
		}
	}
	
	public function HandleWalk() : Boolean
	{
		SMTRACE("Farm::HandleWalk " + coreGame.StrEvent);
		
		if (super.HandleWalk()) return true;
		
		switch (coreGame.NumEvent) {
			
		case 1.5:
			coreGame.BitFlag1.SetBitFlag(0);
			if (coreGame.BitFlag1.CheckBitFlag(6) && (slaveData.MilkInfluence > 0 && slaveData.MilkInfluence < 1000)) coreGame.Milked();
			else {
				ShowSupervisor();
				ShowMovie("WalkCowgirl", 1, 3, Math.floor(Math.random()*4) + 1);
				AddText(coreGame.SlaveVerb("visit") + " a small barn and sees a strangely dressed girl with tubes attached to her breasts. She appears to be being milked!\r\rThe girl is very distracted but they talk for a little, maybe oddly about milk.\r\rThe girl sometimes makes mooing noises apparently unconsciously. She is very aroused and the talk ends when she seems to have a strong orgasm, crying out a loud 'Mooo!' and faints.");
				Points(0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			}
			return true;
			
		case 3:
			ShowSupervisor();
			temp = Math.floor(Math.random()*2);
			if (coreGame.Naked) temp = 0;
			switch(temp) {
				case 0:
					coreGame.OldNumEvent = 3.1;
					if (Supervise) AddText(coreGame.SlaveSee + " some dairy products for sale and asks you to buy some for dinner. You buy the milk and cheese but are surprised by the rather high price.");
					else AddText(coreGame.SlaveSee + " some dairy products for sale and asks #assistant to buy some for dinner. A little reluctantly #assistant does but is surprised by the high price.");
					return true;
				case 1:
					coreGame.OldNumEvent = 3.2;
					coreGame.UseGeneric = false;
					if (coreGame.SlaveGirl.ShowNakedApron() != true) coreGame.Generic.ShowNakedApron();
					if (Supervise) {
						AddText(coreGame.SlaveName1 + " trips, getting covered head to toe in mud and you take #slavehimher into a farm building and asks a woman there to wash #slavehisher clothes as quickly as possible. You pay a small fee for the cleaning.\r\rWhile waiting #slave is given an apron to cover #slavehimherself. You wonder why <i>only</i> an apron is available. #slave's clothes are returned clean by the woman, who is smiling broadly.");
						if (slaveData.VarLovePoints > 30) AddText("\r\rWhile waiting #slave seems to make a point to 'accidentally' show you #slavehisher exposed " + coreGame.Plural("rear") + ", smiling coyly.");
					} else {
						AddText(coreGame.SlaveName2 + " trips, getting covered head to toe in mud and #assistant takes #slavehimher into a farm building and asks a woman there to wash #slavehisher clothes as quickly as possible. #assistant pays a small fee for the cleaning.\r\rWhile waiting #slave is given an apron to cover #slavehimherself. " + coreGame.NameCase(coreGame.SlaveHeShe) + " wonders why <i>only</i> an apron is available. " + coreGame.NameCase(coreGame.SlaveHisHer) + " clothes are returned clean by the woman, who is smiling broadly.");
						if (!coreGame.SlaveLikeServant) AddText("\r\rAs they leave #assistant scolds #slave for her clumsiness.");
	
					}
					return true;
			}
			Money(-50);
			return true;
			
		case 4:
		case 4.5:
			ShowSupervisor();
			ShowPerson(7, 1, 1);
			if (coreGame.NumEvent == 4) {
				slaveData.BitFlag1.SetBitFlag(25);
				Points(0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText(coreGame.SlaveMeet + " the Count who was visiting this farm on business. He is the owner of this farm and is here to review some operations. He sounded a little odd when he said 'operations'.\r\rThey discuss importance of rural life and farming to the Mioya's culture.");
				slaveData.NobleLoveEvent(7);
			} else {
				AddText(coreGame.SlaveMeet + " the Count who was visiting this farm on some business.\r\rHe didn't pay any attention to #slave.");
				if (Supervise) AddText(" He briefly nods at you but excuses himself as being on pressing business.");
			}
			return true;
			
		case 6:
			if (!coreGame.BitFlag1.CheckBitFlag(6)) {
				coreGame.BitFlag1.SetBitFlag(6);
				ShowMovie("WalkCowgirl", 1, 0, 5);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText(coreGame.SlaveIs + " walking near the farm and by chance briefly loses #super.\r\r" + coreGame.SlaveMeet + " a man, a farm hand, and " + coreGame.SlaveHeShe + coreGame.NonPlural(" ask") + " directions and they talk a little. The man offers #slavehimher " + coreGame.Plural("a snack") + " in the form of odd looking sweets. He seems a little intense...\r\rWill #slaveheshe eat it?");
				DoYesNoEvent(4080);
			} else if (slaveData.MilkInfluence > 0 && slaveData.MilkInfluence < 1000) coreGame.Milked();
			else {
				ShowSupervisor();
				Points(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0);
				if (Supervise) AddText("You carefully make");
				else AddText(coreGame.ServantName + " carefully makes");
				AddText(" sure " + coreGame.SlaveName + coreGame.NonPlural(" avoid") + " the barn and most of the rest of the buildings, but #slave clearly remembers #slavehisher experiences there.\r\rUnconsciously #slaveheshe briefly caresses #slavehisher breasts.");
			}
			return true;
			
		case 7:
			ShowSupervisor();
			AddText(coreGame.SlaveHas + " a pleasant walk around the fields and streams. ");
			if (!coreGame.BitFlag1.CheckBitFlag(26)) {
				temp = coreGame.IsDickgirlEvent() ? (coreGame.DickgirlTesticles ? 10 : 8) : Math.floor(Math.random()*2) + 6;
				ShowMovie("WalkCowgirl", 1, 1, temp);
				AddText("In the distance #slaveheshe can see a girl walking, dressed a bit oddly. The girl seems rather distracted, often fondling her breasts");
				if (temp == 8) AddText(" and cock");
				if (slaveData.MilkInfluence > 0) AddText(".\r\r#slave unconsciously " + coreGame.NonPlural("massage") + " #slavehisher own breasts.");
				else AddText(".");
			}
			Points(0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0);
			return true;		
		}
		return false;
	}
}