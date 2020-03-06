// PersonCountGossem - Lady Okyanu the Courtesan
// number 7
// lend modifier 0
// Translation status: COMPLETE

import Scripts.Classes.*;


class PersonCountGossem extends Person {
		
	public function PersonCountGossem(cg:Object, cc:Object) { 
		super("Count", cg, 7, 0, false, cc);
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
		return ((sd.vitalsBust >= 90 || SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1) || sd.VarRefinement >= 60) && super.CanBeLoanedTo());
	}
	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendCount() == true) return true;
		
		if (CheckBitFlag(1) && !CheckBitFlag(2)) {
			var eNode:XMLNode = coreGame.XMLData.GetNode("Visits/VisitCount/BEEvent3");
			if (coreGame.XMLData.XMLEventByNode(eNode, false)) return;
		}
		if (coreGame.SlaveGirl.ShowActLend(7) == false) {
			coreGame.UseGeneric = true;
			// obsolete versions
			coreGame.SlaveGirl.ShowSexActLendHer();
			coreGame.SlaveGirl.ShowActLendHer();
			coreGame.ShowActImage();
		}
		if (coreGame.SlaveFemale) {
			coreGame.ResetNotFucked();
			if (IsDayTime()) Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
			else Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
			if (coreGame.AppendActText) {
				// The Count tells #slave that he only wants #slavehimher sexually, nothing more. He proceeds to fuck #slavehimher often, mostly tit-fucking #slavehimher and sometimes other ways, but always groping #slavehisher breasts.
				coreGame.XMLData.XMLGeneral("Visits/LendCount/NormalLendFemale");
			}
		} else {
			ShowThem(1, 1, 1);
			Points(0, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			if (coreGame.AppendActText) {
				// The Count spends the time talking with #slave about the court and matters of etiquette. After a while he has a large breasted slave sit in his lap and he unconsciously gropes her breasts.
				coreGame.XMLData.XMLGeneral("Visits/LendCount/NormalLendMale");
			}
		}

		return true;
	}

	// Endings
	
	public function EndingFinish(total:Number) : Boolean 
	{ 
		if (coreGame.Owner.GetOwner() != Id || coreGame.NumFin == 21 || coreGame.NumFin >= 1000) return false;
		
		// Sold to Count
		AddText("You visit the Count in his almost palatial mansion and are greeted by a slavegirl, dressed scandalously with her large breasts exposed. She takes you to speak to the Count who is sitting with #slave standing behind him, also dressed with #slavehisher breasts exposed,\r\r");
		PersonSpeak(7, "Thank you, " + coreGame.SlaveIs + " is a delight and is now my personal servant. Her simple qualities make her perfect to serve me <i>here</i>", true);
		AddText("\r\rYou see him look at #slave1's breasts and then reach out and cup a breast. #slave1 does not look completely happy at his handling of her but submits, and then speaks\r\r");
		SlaveSpeak("Thank you, my life here is pleasant, if a little focused on...", true);
		AddText("\r\rShe gasps as the Count pinches her nipple, and he waves you out of the room. You see him leaning in toward #slave1's breast...");
		coreGame.NumFin = 1000;
	
		return true; 
	}
	
}