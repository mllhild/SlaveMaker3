// PersonMaidSumi - Sumi the Maid
// number 5
// lend modifier -15
// Translation status: COMPLETE

import Scripts.Classes.*;


class PersonMaidSumi extends Person {
		
	public function PersonMaidSumi(cg:Object, cc:Object) { 
		super("Maid", cg, 5, -15, true, cc);
	}
	
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowKitchen(2);
			return super.ShowThem(1, 1, 1);
		} else if (place == "lend") {
			Backgrounds.ShowKitchen(2);
			return super.ShowThem(0, 1, 2);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}

	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(false, false, undefined, undefined, false);
	}
	
	
	// Visiting
	
	// called when checking if the person can be visited.
	public function CanBeVisited() : Boolean
	{
		return sd.VarSensibility >= 30 && super.CanBeVisited();
	}

	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitMaid() == true) return true;
		SetVisited();
		
		if (PersonFlag < 10)
		{
			Language.XMLGeneral("Visits/VisitMaid/NormalVisit");
			var inc:Number = Math.floor((sd.VarCooking + sd.VarCleaning) / 20);
			sd.Points(0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, inc, 0, 0, 0, 0);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 10);
	
		} else Language.XMLGeneral("Visits/VisitMaid/VisitedEnough");
		
		coreGame.modulesList.VisitChatWithPerson(Id);
		coreGame.People.HearGossip(Id);
		var ruins:Place = GetPlace("RuinedTemple");
		if (ruins.CheckBitFlag(32) && (!ruins.CheckBitFlag(35))) {
			BlankLine();
			Language.XMLGeneral("Visits/VisitMaid/AskMine"); //SlaveVerb("ask") + " the Maid if she has heard of a place called the ruins. The maid shakes her head and says no.
			ruins.SetBitFlag(35);
		}
		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{
		return sd.VarSensibility >= 30 && super.CanBeLoanedTo();
	}

	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendMaid() == true) return true;
		
		coreGame.ResetNotFucked();
		if (coreGame.SlaveGirl.ShowActLend(Id) == false) coreGame.UseGeneric = true;
		// obsolete versions	
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		coreGame.ShowActImage();
		
		sd.AlterSexuality(-2);
		if (coreGame.LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		
		if (coreGame.AppendActText) {
			if (coreGame.SlaveFemale) sd.AlterSexuality(-3);
			Language.XMLGeneral("Visits/LendMaid/NormalLend");
		}
		return true;
	}

}