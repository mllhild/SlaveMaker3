// PersonLord - Miss. N the prostitute
// number 8
// lend modifier -5
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonLord extends Person {
		
	public function PersonLord(cg:Object, cc:Object) { 
		super("Lord", cg, 8, -5, false, cc);
	}
	
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowPalace();
			return super.ShowThem(1, 1, 1);
		} else if (place == "lend") {
			Backgrounds.ShowPalace();
			return super.ShowThem(0, 1, 1);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}

	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(false, false, undefined, undefined, false);
		if (SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1)) SetAccessible();
	}
	
	
	// Visiting
	
	// called when checking if the person can be visited.
	public function CanBeVisited() : Boolean
	{
		return ((SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1) || sd.VarRefinement >= 80) && super.CanBeVisited());
	}
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		SetVisited();
		
		if (coreGame.SlaveGirl.DoVisitLord() == true) return true;

		if (PersonFlag < 15) {
			Language.XMLGeneral("Visits/VisitLord/NormalVisit");
			var inc:Number = Math.floor(sd.VarRefinement / 10);
			sd.Points(1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, inc, 0, 0, 0, 0);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 15);
		}
		else
		{
			Language.XMLGeneral("Visits/VisitLord/VisitedEnough");
		}
		
		coreGame.modulesList.VisitChatWithPerson(Id);
		coreGame.People.HearGossip(Id);
		
		var ruins:Place = GetPlace("RuinedTemple");
		if (ruins.CheckBitFlag(32) && (!ruins.CheckBitFlag(38))) {
			//"\r\r" + SlaveVerb("ask") + " the Lord if he has heard of a place called the ruins. He explains that there is an old temple for the old faith that was burned down a long time ago. Since then it has become a lair of dangerous things. He has posted patrols to limit access to it.\r\r" + SlaveHeSheUC + " " + NonPlural("ask") + " to get access and explains why. He refuses, after all #slave is a slave, and Sareth is a legally bought slave."
			BlankLine();
			Language.XMLGeneral("Visits/VisitLord/AskMine");
			ruins.SetBitFlag(38);
		}
		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{	
		return ((SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1) || sd.VarRefinement >= 80) && super.CanBeLoanedTo());
	}

	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendLord() == true) return true;
		
		if (coreGame.SlaveFemale) {
			if (!coreGame.LesbianTraining) sd.AlterSexuality(1);
			coreGame.ResetNotFucked();
			if (coreGame.SlaveGirl.ShowActLend(Id) == false) coreGame.UseGeneric = true;
			// obsolete versions
			coreGame.SlaveGirl.ShowActLendHer();
			coreGame.SlaveGirl.ShowSexActLendHer();
			coreGame.ShowActImage();
			
			if (IsDayTime()) sd.Points(3, -1, 3, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
			else sd.Points(3, -1, 3, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
			if (coreGame.AppendActText) {
				//"The Lord spends the time talking with #slave, pleasantly chatting about politics and many things.\r\rAfter a while he takes #slave to a private chamber and informs " + SlaveHimHer + " that they will now have sex. He is very energetic and demanding, but considerate of #slave's desires. He appears to have no inhibitions at all..."
				Language.XMLGeneral("Visits/LendLord/NormalLendFemale");
			}
		} else {
			ShowThem(1, 1, 1);
			sd.Points(3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
			if (coreGame.AppendActText) {
				//"The Lord spends the time talking with #slave, pleasantly chatting about politics and many things. After a while he has a large breasted slave sit in his lap and he unconsciously gropes her breasts."
				Language.XMLGeneral("Visits/LendLord/NormalLendMale");
			}
		}
		return true;
	}

	// Endings
	
	public function EndingFinish(total:Number) : Boolean 
	{ 
		if (coreGame.Owner.GetOwner() != Id || coreGame.NumFin == 21 || coreGame.NumFin >= 1000) return false;
		
		// Sold to Lord
		AddText("You visit the Palace and are granted an audience to see the Lord. As you approach you see #slave standing near, dressed in the most elegant " + (coreGame.SlaveFemale ? Plural("dress") : Plural("suit")) + ". The Lord leaps up and walks to you and shakes your hand,\r\r");
		PersonSpeakStart(8, "Congratulations " + coreGame.SlaveIs + " wonderful, an asset to me and the court, you are a great Slave Maker!");
		if (SMData.sNoble == 0) {
			PersonSpeakEnd("\r\rI have decided, kneel!", true);
			AddText("\r\rA little confused you kneel and the Lord draws a sword and touches your head, and pronounces you a " + (SMData.Gender == 1 ? "baron" : "baroness") + "\r\r");
			SMData.sNoble = 1;
			PersonSpeak(8, "\r\rYou have done me a great service and I will consider you for special services in future.", true);
		} else {
			PersonSpeakEnd("\r\rYou have done me a great service and I will consider you for special services in future.");
		}
		BlankLine();
		SlaveSpeak("Congratulations!", true);
		SMData.BitFlagSM.SetBitFlag(11);
		coreGame.NumFin = 1000;
	
		return true; 
	}

}