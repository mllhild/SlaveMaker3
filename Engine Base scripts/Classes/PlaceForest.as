// Forest
// Linked to Walk-Forest.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceForest extends Place
{
	// Constructor
	public function PlaceForest(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to Walk-Forest.swf, xml node Slums, id 1, x = 20, y = 300
		super("Forest", mc, cg, 1, true, "Engine/Walk-Forest.swf", 20, 300, cc);
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(10, 33);
	}
	
	// Images
	public function HideImages()
	{
		this.mcBase.Creatures._visible = false;
		this.mcBase.Unicorn._visible = false;
		this.mcBase.Archer._visible = false;
		this.mcBase.Centaur._visible = false;
		this.mcBase.Elf._visible = false;
		this.mcBase.BEForest._visible = false;
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "MeetCatgirl-7";	// set default event
		
		this.AddEvent("TentacleSex", true);
		this.AddEvent("VisitAstrid", true);
		this.AddEvent("MeetKnight-1");
		this.AddEvent("IgnoredByKnight-1.5", true);
		this.AddEvent("MeetAstridsMaid-2");
		this.AddEvent("AstridsMaidAvoids-2.5", true);
		this.AddEvent("LoseMoney-3");
		this.AddEvent("MeetRefinementTeacher-4");
		this.AddEvent("MeetNun-5");
		this.AddEvent("MeetDancer-6");
		this.AddEvent("MeetDancer-6.2", true);
		this.AddEvent("MeetCatgirl-7");
	}
	
	// Walking in the Forest
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		PlaySound("Sounds/Forest.mp3");
		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			if (coreGame.RuinedTemple.EvilMineFlag == -1) SetEvent(4115);
			else SetEvent(4105);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkForest++;
		coreGame.EventTotal = slaveData.TotalWalkForest;
		
		slaveData.ChangeFairyXF(3);
		
		coreGame.Tentacles.CheckTentacleWalk(coreGame.SlaveIs + " walking and notices the forest is very quiet. A noise behind #slavehimher makes #slavehimher turn and " + coreGame.SlaveSee + " a mass of bloody tentacles fall from a tree. Terrible burns and claw marks cover the flesh and the tentacles are ripped from the bloody body. " + coreGame.SlaveHeSheUC + coreGame.NonPlural(" look") + " away in fright and " + coreGame.NonPlural("walk") + " on.\r\r", " is passing between several large trees");
		
		// Select the event and show it
		if (IsEventAllowable()) super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		if (SMData.SMHomeTown == 5 && coreGame.NumEvent == -1 && Supervise) ResetEventPicked();
	
		if (!SMData.BitFlagSM.CheckBitFlag(3)) {
			// Do not know where Astrid lives
			if (coreGame.StrEvent == "" && coreGame.NumEvent == 0 && slaveData.DickgirlXF != -1 && slaveData.MaxAstrid > 0) {
				var tempmax:Number = slaveData.MaxAstrid;
				if (coreGame.DickgirlOn != 1) tempmax = 10;
				var tempvar:Number = (5 + coreGame.GameDate - coreGame.LastVisitDickgirl) * 3;
				if (slaveData.MaxAstrid > 11) {
					if (slaveData.DickgirlXF == 2 || coreGame.BitFlag1.CheckBitFlag(10)) {
						if (tempvar > 10) tempvar = 10;
					} else {
						if (tempvar > slaveData.MaxAstrid) tempvar = slaveData.MaxAstrid;
					}
				} else {
					if (tempvar > slaveData.MaxAstrid) tempvar = slaveData.MaxAstrid;
				}
				if (PercentChance(tempvar)) coreGame.SetEvent("VisitAstrid");
			}
			if (coreGame.BitFlag1.CheckBitFlag(20) && (!this.CheckBitFlag(33))) {
				if (PercentChance(70)) coreGame.SetEvent("VisitAstrid");
				else SetEvent(2);
			}
		} else NoRepeatEvent("VisitAstrid");

		super.GetWalkEvent(exclude, sequential);

		if (!IsEventPicked()) return;
		
		if (coreGame.NumEvent == 1 && slaveData.VarRefinementRounded < 30) coreGame.SetEvent("IgnoredByKnight-1.5");
		else if (coreGame.NumEvent == 2 && slaveData.VarSensibilityRounded < 30) coreGame.SetEvent("AstridsMaidAvoids-2.5");
		else if (coreGame.NumEvent == 3 && SMData.SMHomeTown == 5) coreGame.SetEvent("MeetCatgirl-7");
	}
	
	public function HandleWalk() : Boolean
	{
		SMTRACE("Forest::HandleWalk " + coreGame.StrEvent);
		
		if (super.HandleWalk()) return true;
		
		switch (coreGame.StrEvent) {
			
		case "VisitAstrid":
			coreGame.VisitAstrid();
			return true;
			
		case "MeetKnight-1":
			ShowPerson(6, 1, 1, Math.floor(Math.random()*2) + 1);
			switch(Math.floor(Math.random()*2)) {
				case 0:
					coreGame.OldNumEvent = 1.1;
					AddText(coreGame.SlaveMeet + " a Knight and they talk briefly about forest battles and then about nature.");
					Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					return true;
				case 1:
					coreGame.OldNumEvent = 1.2;
					PlaySound("Clang");
					if (slaveData.slCombat > 0) slaveData.slCombat++;
					AddText(coreGame.SlaveMeet + " a Knight who is practicing sword techniques. He explains to #slavehimher the forest helps him to focus on his training. He offers to show #slavehimher a few moves and they practice for a time.");
					Points(0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					return true;
			}
			if (coreGame.NobleLoveType == 6) {
				parentCity.MeetPerson(6, 0, "Knight");
				coreGame.NobleLoveEvent(6);
			}
			return true;
			
		case "IgnoredByKnight-1.5":
			ShowPerson(6, 1, 1, Math.floor(Math.random()*2) + 1);
			AddText(coreGame.SlaveMeet + " a Knight but he didn't want to talk with such a lowly person."); 
			return true;
			
		case "MeetAstridsMaid-2":
			if (coreGame.DickgirlOn == 1) {
				ShowPerson(52, 1, 1);
				ShowSupervisor();
			} else ShowPerson(52, 0, 5);
			if (this.CheckBitFlag(32)) AddText(coreGame.SlaveMeet + " the shy maid");
			else AddText(coreGame.SlaveMeet + " a maid, who seems very shy,");
	
			switch(Math.floor(Math.random()*2)) {
				case 0:
					coreGame.OldNumEvent = 2.1;
					AddText(" taking a walk in the forest and they walk together while discussing the beauty of nature. The maid walks slowly as if encumbered or restricted in some way.");
					Points(0, 2, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					return true;
				case 1:
					coreGame.OldNumEvent = 2.2;
					AddText(" looking for herbs in the forest. " + coreGame.SlaveVerb("help") + " her look and they discuss herbs, seasonings and the like. The maid is awkward in her searching and only bends down with some difficulty.");
					Points(0, 0, -2, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					return true;
			}
			AddText("\r\rThe maid says she must return to her Mistress Astrid soon.");
			if (slaveData.BitFlag1.CheckBitFlag(20) && (!coreGame.Lake.CheckBitFlag(33))) {
				AddText("\r\r" + coreGame.SlaveVerb("ask") + " if her Mistress makes a potion called 'Nymph's Tears' and the maid blushes and says yes.");
			}
			AddText("\r\rAs she leaves " + coreGame.SlaveSee + " the maid has raised her skirt and is ");
			if (coreGame.DickgirlOn == 1) AddText("slowly stroking her large cock, saying how her Mistress requires her cock to be erect at all times, ready to cum into her Mistress's mouth whenever she desires!");
			else AddText("working a dildo that is strapped into her pussy, explaining how her Mistress wants her to be aroused at all times!");
			this.SetBitFlag(32);
			return true;
			
		case "AstridsMaidAvoids-2.5":
			ShowPerson(52, 0, 6);
			if (this.CheckBitFlag(32)) AddText(coreGame.SlaveMeet + " the shy maid again but she avoids #slave after looking at #slavehimher a little timidly.");
			else AddText(coreGame.SlaveMeet + " a maid, who seems very shy, and they start talking. The maid is somewhat timid, but when #slave asks a personal question of the maid, the maid looks a little surprised and excuses herself and leaves.");
			this.SetBitFlag(32);
			return true;
			
		case "LoseMoney-3":
			ShowSupervisor();
			switch(Math.floor(Math.random()*2)) {
				case 0:
					coreGame.OldNumEvent = 3.1;
					AddText(coreGame.SlaveA + " stumbles over a tree root and breaks the heel of a shoe.\r\r");
					if (Supervise) AddText("You scold " + coreGame.SlaveHimHerSingle + " and take " + coreGame.SlaveHimHerSingle + " to a cobbler and get the shoe repaired.");
					else AddText(coreGame.ServantName + " scolds " + coreGame.SlaveHimHerSingle + " and takes " + coreGame.SlaveHimHerSingle + " to a cobbler and gets the shoe repaired.");
					Money(-50);
					return true;
				case 1:
					coreGame.OldNumEvent = 3.2;
					coreGame.AutoAttachAndShowMovie("ClipFortuneTelling", 1, 0);
					if (Supervise) AddText("#slave and you meet a wandering fortune teller and for fun decide to get your fortunes told.\r\rThe so-called fortune teller obviously has no talent and you leave unsatisfied.");
					else AddText("#slave and #assistant meet a wandering fortune teller and for fun get their fortunes told.\r\rThe so-called fortune teller obviously had no talent and they leave unsatisfied.");
					Money(-100);
					return true;
			}
			return true;
			
			
		case "MeetDancer-6":
			var Dancer:Person = coreGame.People.GetPersonsObject("Dancer");
			if (slaveData.FaeriesRingOK == 10) {
				Dancer.ShowThem(0, 0);
				if (Dancer.IsVisited()) {
					if (Dancer.CheckBitFlag(33)) AddText(coreGame.SlaveMeet + " the faerie dancer who conceals her nature in the city.\r\rShe looks at #slave in a rather sad way, saying 'they' probably like it, but I do not approve of what you have done. She turns and leaves.");
					else AddText(coreGame.SlaveMeet + " the faerie dancer who conceals her nature in the city.\r\rShe looks at #slave in a rather sad way and walks away.");
				} else AddText(coreGame.SlaveMeet + " a dancer who performs in the city and at court.\r\rShe looks at #slave in a rather sad way, saying 'they' probably like it, but I do not approve of what you have done. She turns and leaves.");
				Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			} else {
				slaveData.ChangeFairyXF(1);
				ShowSupervisor();
				ShowMovie("Faeries/ClipFairyMeeting", 1, 0, 12);
				AddText(coreGame.SlaveMeet + " the faerie dancer who conceals her nature in the city.\r\rThey talk for a time, but the dancer avoids any talk of the faerie folk and her subterfuge. They talk about court and performing. The faerie seems very happy to be out here in the forest, dancing and almost embracing the trees.");
				if (slaveData.FairyMeeting > 0 && slaveData.FairyMeeting < 4) AddText("\r\rShe thanks #slave for rescuing a faerie recently. She says that the band of faeries has not yet moved on, so hunters are still seeking them. Then again 'those' faeries probably don't mind being grabbed and controlled.");
				else if (slaveData.FairyMeeting == 4 && (!Dancer.CheckBitFlag(34))) {
					Dancer.SetBitFlag(34);
					AddText("\r\rShe thanks #slave for rescuing a faerie recently. She says that the band of faeries has mostly moved on, though some may remain in careful secrecy.");
				}
				Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			}
			Dancer.SetBitFlag(33);
			return true;
			
		case "MeetDancer-6.2":
			var Dancer:Person = coreGame.People.GetPersonsObject("Dancer");
			coreGame.modulesList.MeetPerson(Dancer.Id, 0);
			Dancer.ShowThem(0, 0);
			if (Dancer.CheckBitFlag(33)) AddText(coreGame.SlaveMeet + " the faerie dancer, who conceals her nature in the city, ");
			else if (Dancer.IsMet()) AddText(coreGame.SlaveMeet + " a dancer again ");
			else AddText(coreGame.SlaveMeet + " a dancer ");
			AddText("and had a little talk with her.\r\rThe dancer talks about performing at court and is very pleasant but very flighty, moving around at all times.");
			Points(0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			Dancer.SetVisited();
			Dancer.SetMet();
			return true;
			
		case "MeetCatgirl-7":
		default:
			ShowSupervisor();
			if (slaveData.BitFlag1.CheckBitFlag(8)) {
				slaveData.BitFlag1.ClearBitFlag(8);
				if ((!this.CheckBitFlag(33)) && SMData.BitFlagSM.CheckBitFlag(8)) {
					this.SetBitFlag(33);
					coreGame.DoEventNext(8500);
				} else {
					AddText(coreGame.SlaveVerb("wander") + " in the quiet forest, seeing no-one at all. The ambiance improves #slavehisher mood and the walk allows #slavehimher time to think about many things.");
					Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
				}
			} else {
				slaveData.BitFlag1.SetBitFlag(8);
				coreGame.Catgirls.ShowMovie("EventWalk", 1, 0, 2);
				if (slaveData.IsCatgirl()) {
					slaveData.ChangeCatTraining(1);
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
					AddText(coreGame.SlaveSee + " an odd girl in a tree, maybe she is a cat slave too. She waves and leaps down silently and licks " + coreGame.SlaveB + "'s face. She leaps back up and nimbly leaps away through the branches.");
				} else AddText(coreGame.SlaveSee + " an odd girl in a tree, maybe she is a cat slave. She waves and silently, nimbly leaps away through the branches.");
				Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
			}
			return true;
		}
		
		return false;
	}
}