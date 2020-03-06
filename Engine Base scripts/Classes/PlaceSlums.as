// Slums
// Linked to Walk-Slums.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceSlums extends Place
{
	// Constructor
	public function PlaceSlums(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to Walk-Slums.swf, xml node Slums, id 4, x = 400, y = 290
		super("Slums", null, cg, 4, true, "", 400, 290, cc);
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(11);
	}
	
	// Images
	public function HideImages()
	{
		this.mcBase.Walk._visible = false;
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "MeetProstitute-1";	// set default event
		
		this.AddEvent("MeetProstitute-1");
		this.AddEvent("MeetCourtesan-2");
		this.AddEvent("Raped-3");
		this.AddEvent("Robbed-4");
		AddNumberedEvents(2, 4);
		this.AddEvent("MeetSleazyBarOwner-7");
		this.AddEvent("MeetXXXSchoolOwner-8");
		AddNumberedEvents(1, 8);
		this.AddEvent("MeetNun-11");
		this.AddEvent("FindDealer");
	}

	// Walking in the Slums
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4109);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkSlums++;
		coreGame.EventTotal = slaveData.TotalWalkSlums;
		
		coreGame.Tentacles.CheckTentacleWalk("While #slave starts walking through the slums #slaveheshe smells a foul odour. In a small alley nearby #slaveheshe sees a horribly slain thing, torn tentacles and ripped apart flesh. Terrible burns and claw marks cover the flesh. #slave looks away in fright and hurries on.\r\r", " is walking in an abandoned area");
		
		// Select the event and show it
		if (IsEventAllowable()) super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude, sequential);

		if (!IsEventPicked()) return;
		
		if (coreGame.NumEvent == 3) {
			if (SMData.SMSpecialEvent == 6 && (coreGame.TentaclesOn == 1  && ((coreGame.MoonPhaseDate > 14 && coreGame.MoonPhaseDate < 18 && Math.floor(Math.random()*(3 - coreGame.Diffculty)) == 0) || (slaveData.MaxTentacleHarem > 1 && Math.floor(Math.random()*(6 - coreGame.Difficulty)) == 1)))) coreGame.SetEvent("TentacleSex");
			else {
				if (coreGame.Home.HouseType == 4 && coreGame.PercentChance(40)) coreGame.NumEvent = 6;
				else coreGame.NumEvent = (slaveData.VarCharismaRounded > 30) ? 3 : 3.5;
			}
		} 
		else if (coreGame.NumEvent == 5) coreGame.NumEvent = (coreGame.VarReputationRounded > 40) ? 5 : 5.5;
		else if (coreGame.NumEvent == 6) coreGame.NumEvent = (coreGame.VarMoralityRounded >= 10) ? 6 : 6.5;
		else if (coreGame.NumEvent == 9) coreGame.NumEvent = (coreGame.VarConversationRounded > 20) ? 9 : 9.5;
		else if ((SMData.SMAdvantages.CheckBitFlag(2) && SMData.NumDealer > 1) && (coreGame.NumEvent == 10)) coreGame.NumEvent = 8;
	}
	
	public function HandleWalk() : Boolean
	{
		SMTRACE("Slums::HandleWalk " + coreGame.StrEvent);
		
		switch (coreGame.NumEvent) {
			
		case 3.5:
			ShowSupervisor();
			if (!this.CheckBitFlag(32) && !coreGame.RapeOn) {
				coreGame.Backgrounds.ShowAlley(1);
				if (coreGame.IsDickgirlEvent()) coreGame.AutoLoadImageAndShowMovie("Images/Cities/Mardukane/Events/Walk Slums - Bad Encounter 2 (As Dickgirl).png", 1, 1);
				else coreGame.AutoLoadImageAndShowMovie("Images/Cities/Mardukane/Events/Walk Slums - Bad Encounter 2.png", 1, 1);
				AddText(coreGame.SlaveSee + " some sad looking slave-girls being led toward a very seedy looking brothel. " + coreGame.SlaveHeSheUC + " is unsure if they are being forced to work there by an uncaring Master or if they are owned by the brothel.\r\rEither way #slave feels a little unhappy at their sadness.");
				if (slaveData.Slutiness > 5) AddText(" " + coreGame.SlaveIs + " at least happy they will be getting plenty of sex.");
				this.SetBitFlag(32);
				Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0);
			} else {
				AddText("A strange guy was following #slave but he stopped after a while.");
			}
			return true;
			
		case 5:
		case 5.5:
			ShowSupervisor();
			ShowPerson(6, 1, 1, Math.floor(Math.random()*2) + 1);
			if (coreGame.NumEvent == 5) {
				var bribe:Number = 100 - (coreGame.Difficulty * 10);
				Money(bribe);
				AddText(coreGame.SlaveMeet + " a Knight in a not so advantageous situation. He gives #slavehimher " + bribe + "GP to not tell this to anyone.");
				coreGame.NobleLoveEvent(6);
			} else {
				AddText(coreGame.SlaveMeet + " a Knight in a not so advantageous situation. As his reputation is far higher than the reputation of #slave, he doesn't pay attention to #slavehimher.");
			} 
			return true;
			
		case 6:
		case 6.5:
			ShowPerson(27, 0, 0);
			if (coreGame.NumEvent == 6) {
				slaveData.DifficultyBrothel = slaveData.DifficultyBrothel - 5;
				Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				if (coreGame.TestObedience(slaveData.DifficultyBrothel, 113)) {
					AddText("#slave has been complimented by a pimp, who said how sexy " + coreGame.SlaveHeSheIs + ". " + coreGame.SlaveName2 + " called back 'I'll look forward to working for you sometime!'");
				} else {
					AddText("#slave has been complimented by a pimp, who said how sexy " + coreGame.SlaveHeSheIs + ". The work at the brothel does not seem so bad now.");
				}  
			} else {
				Money(150 - (coreGame.Difficulty * 25));
				if (slaveData.Slutiness < 6) Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 2, 0, 5, 0, 0, 0, 0, -5, 0, 0);
				else Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 2, 0, 5, 0, 0, 0, 0, 1, 0, 0);
				AddText("A pimp convinced #slave to let him test #slavehisher talents. He gave #slave " + (150 - (coreGame.Difficulty * 25)) + "GP afterward to convince #slavehimher to come work in his brothel.");
				slaveData.DifficultyBrothel = slaveData.DifficultyBrothel - 5;
			} 
			return true;
						
		case 9:
		case 9.5:
			if (coreGame.NumEvent == 9 && !coreGame.IsAssistant("Sora")) {
				ShowPerson(2, 1, 1, Math.floor(Math.random()*2) + 1);
				coreGame.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
				AddText(coreGame.SlaveName + coreGame.NonPlural(" talk") + " with a barmaid of a sleazy bar who gives #slavehimher some advice about making customers enjoy the bar.");
				parentCity.MeetPerson(2, 0, "barmaid");
				Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			} else {
				if (coreGame.IsAssistant("Sora")) ShowPerson(2, 1, 1, Math.floor(Math.random()*2) + 8);
				else ShowPerson(2, 1, 1, Math.floor(Math.random()*2) + 1);
				AddText(coreGame.SlaveMeet + " a barmaid of a sleazy bar but after a clumsy opening by #slave the barmaid didn't want to talk with #slavehimher .");
			} 
			return true;
			
		}
		
		return super.HandleWalk();
	}
}
