// PersonKnightShan - Knight Shan
// number 6
// lend modifier -10
// Translation status: COMPLETE

import Scripts.Classes.*;


class PersonKnightShan extends Person {
		
	public function PersonKnightShan(cg:Object, cc:Object) { 
		super("Knight", cg, 6, -10, false, cc);
	}
	
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowOther(10);
			return super.ShowThem(1, 1, slrandom(2));
		} else if (place == "lend") {
			Backgrounds.ShowOther(10);
			return super.ShowThem(0, 1, 2);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}

	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(true, false, undefined, undefined, false);
		if (SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1)) SetAccessible();
	}
	
	
	// Meeting
	public function Meeting(meet:Number) : Boolean
	{
		if (!super.Meeting(meet)) return false;
		
		if (!IsAccessible()) {
			SetAccessible();
			if (sd.NobleLoveType == Id) AddText("\r\rThe Knight Shan looks a little embarrassed and invites #slave to <b>visit</b> his mansion sometime to discuss battle and ethics more.");
			else if (sd.VarRefinement >= 50 && sd.VarMorality > 25) AddText("\r\rThe Knight Shan invites #slave to <b>visit</b> his mansion sometime to discuss battle and ethics more.");
			else AddText("\r\rThe Knight Shan suggests #slave could sometime learn more of chivalry from him. When #slaveheshe has studied more #slaveheshe can <b>visit</b> his mansion.");
		}
		return true;
	}
	
	
	// Visiting
	
	// called when checking if the person can be visited.
	public function CanBeVisited() : Boolean
	{
		return SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1) || (sd.VarRefinement >= 50 && sd.VarMorality >= 25) && super.CanBeVisited();
	}
	
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitKnight() == true) return true;
		SetVisited();
		
		if (PersonFlag < 15)
		{
			Language.XMLGeneral("Visits/VisitKnight/NormalVisit");
			var inc:Number = Math.floor(sd.VarSensibility / 10);
			sd.Points(0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, inc, 0, 0, 0, 0);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 15);
	
		} else Language.XMLGeneral("Visits/VisitKnight/VisitedEnough");
		
		coreGame.modulesList.VisitChatWithPerson(Id);
		coreGame.People.HearGossip(Id);
		var ruins:Place = GetPlace("RuinedTemple");
		if (ruins.CheckBitFlag(32) && (!ruins.CheckBitFlag(36))) {
			//SlaveVerb("ask") + " the Knight if he has heard of a place called the ruins. He says there is a forbidden place that the Lord has restricted access to. He refuses to talk any more.
			BlankLine();
			Language.XMLGeneral("Visits/VisitKnight/AskMine");
			ruins.SetBitFlag(36);
		}

		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{
		return SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1) || (sd.VarRefinement >= 50 && sd.VarMorality >= 25) && super.CanBeLoanedTo();
	}
	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendKight() == true) return true;
		
		coreGame.ResetNotFucked();
		
		if (coreGame.SlaveGirl.ShowActLend(Id) == false) coreGame.UseGeneric = true;
		// obsolete versions
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		coreGame.ShowActImage();
		
		Language.XMLGeneral("Visits/LendKnight/LendStart");
		
		if (sd.slCombat != 0 || !coreGame.SlaveFemale) {
			if (sd.slCombat > 0) sd.slCombat += 3;
			Language.XMLGeneral("Visits/LendKnight/TrainingLend");
		} else {
			if (!coreGame.LesbianTraining) sd.AlterSexuality(1);
			coreGame.SlaveGirl.ShowActLendHer();
			coreGame.SlaveGirl.ShowSexActLendHer();
			if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
			else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
			if (coreGame.AppendActText) Language.XMLGeneral("Visits/LendKnight/SexLend");
		}
		return true;
	}
	
	public function EndingFinish(total:Number) : Boolean 
	{ 
		if (coreGame.Owner.GetOwner() != Id || coreGame.NumFin == 21 || coreGame.NumFin >= 1000) return false;
		
		// Sold to Knight
		AddText("You visit the Knight Shan's mansion and are let in immediately to see him. You do not immediately see #slave and he explains,\r\r");
		PersonSpeak(6, coreGame.SlaveIs + " currently training in sword-play, wooden swords of course " + coreGame.SlaveHeSheIs + " a slave after all. Thank you for selling #slavehimher to me, I very much appreciate #slavehisher company, and, ummm, other services.", true);
		AddText("\r\rA little while later #slave enters the room, looking fit and healthy, sweat covering #slavehisher skin, but looking quite happy. " + coreGame.SlaveHeSheUC + " tells you,\r\r");
		SlaveSpeak("Thank you for your training and for my new Master.", true);
		coreGame.NumFin = 1000;
	
		return true; 
	}

}