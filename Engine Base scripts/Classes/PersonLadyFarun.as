// PersonLadyFarun - class defining Lady Farun
// number 9
// lend modifier -10

// BitFlag1 flags
//  17  = Lady Farun favour owed to slave
//  18  = Odd teacher agreement with slave
//  19  = Fix race for slave
//  20  = slave is Searching for nymphs tear supply
//	48	= made offer of cat items for slave
//	55  = slave rescued her

// Class Instance: LadyFarun:PersonLadyFarun
//
// Note: keep the comments aligned with visit&lending-ladyfarun.as
//
// BitFlags
//	0  - offered favour

//	64 - Rescue Event
//  65 - Slave Maker fought for her
//  67 - supply cut off
//  68 - alternate supply arranged (linked to bitflag1 18 for slave arranging supply)
//	69 - first visit after Rescue event
//	70 - discuss Nymph's Tears usage
//  71 - Slave Maker fought and won for her
//  72 - Lara's attitude
//  73 - Statues revealed
//  74 - Favour owed by Slave Maker

// SMFlag - addiction level to Nymph's Tears
//  -1 = cured
//	0  = not addicted
//  1-150 = level
//  > 100 only possible if she has a supply of the drug
// also percent chance she will be interrupted masturbating when visiting

// CustomFlag
//	reputation gain for visiting Lady Farun

// CustomFlag2
// finding permits for Ruins
//	0		- not looking
//  > 0 	- visits remaining to having problems, 1 is the visit where she reports issues or finds them
//  -1	 	- obtain permits next time the Slave Maker visits court and locates Lady Farun
//  -2		- got permits
//
// Translation status: COMPLETE

import Scripts.Classes.*;


class PersonLadyFarun extends Person {
		
	public function PersonLadyFarun(cg:Object, cc:Object) { 
		super("LadyFarun", cg, 9, -10, false, cc);
	}

	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			if (coreGame.LendPerson == -1000) {
				Backgrounds.ShowBedRoom(7);
				return super.ShowThem(1, 3, 3);
			}
			return true;
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}

	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(true, true, undefined, undefined, true);
		if (SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1)) SetAccessible();
	}

	public function HasNymphsTearSupply() : Boolean
	{ 
		return (CheckBitFlag(67) == false || CheckBitFlag(68));
	}
	
	public function NewDay(NumDays:Number)
	{
		super.NewDay(NumDays);
		
		if (SMFlag > 0) {
			SMFlag += NumDays * 20;
			if (HasNymphsTearSupply()) {
				if (SMFlag > 150) SMFlag = 150;
			} else {
				if (SMFlag > 100) SMFlag = 100;
			}
		}
	}

	// Visiting
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		SetVisited();

		PointsPerson(0, 1, 0, 0, 0);

		if (coreGame.SlaveGirl.DoVisitLadyFarun() == true) return false;
			
		if (CheckBitFlag(69)) {
			ClearBitFlag(69);
			// "Visits/VisitLadyFarun/FirstVisitAfterRescue"
			Language.XMLGeneral("Visits/VisitLadyFarun/FirstVisitAfterRescue");
		} 
		
		if (CustomFlag2 != 0) {
			// looking for permits for the ruins
			if (LadyFarunRuinsPermits()) return true;
		}
		
		if (sd.BitFlag1.CheckBitFlag(17) && !CheckBitFlag(0)) {
			// offer a favour to slave
			SetBitFlag(0);
			Language.XMLGeneral("Visits/VisitLadyFarun/OfferFavour"); // Lady Farun again thanks #slave for her rescue from the deformed thing. She says she has influence with the contests, and with many court officials,
		}
		Language.XMLGeneral("Visits/VisitLadyFarun/NormalVisit"); // #slave talks with Lady Farun and gossips about people and events at court.
		
		if (CustomFlag < 10) {
			CustomFlag++;
			sd.Points(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
		}
		if (IsEventAllowable() == false || coreGame.NextEvent._visible) return false;
		
		coreGame.modulesList.VisitChatWithPerson(9);
		return true;
	}
	
	
	public function LadyFarunRuinsPermits() : Boolean
	{
		if (CustomFlag2 == 1 || CustomFlag2 == -1) {
			// Looking for the permits at court, slave maker help needed
			if (CustomFlag2 == 1) Language.XMLData.XMLGeneral("Visits/VisitLadyFarun/PermitHelpNeeded");
			else Language.XMLGeneral("Visits/VisitLadyFarun/PermitPleaseHelp");
			return false;
		}
		if (CustomFlag2 != -2) {
			Language.XMLGeneral("Visits/VisitLadyFarun/VisitPermitLooking");
			return false;
		}
		
		// Got the permits/location of mine
		
		// has the slave found the Nymph's Tear Supply
		if (sd.BitFlag1.CheckBitFlag(18)) {
			Language.XMLGeneral("Visits/VisitLadyFarun/VisitGotSupply");
			Language.SaveText();
			coreGame.Potions.DrinkPotion(12, 0, "");
			Language.RestoreText();
			return true;
		}
		
		// no supply, ask for help
		if (sd.BitFlag1.CheckBitFlag(20)) {
			Language.XMLGeneral("Visits/VisitLadyFarun/VisitNeedingPotion");
			BlankLine();
			return true;
		}
		
		// got permits
		
		// is she addicted to nymph's tears then, trigger nymph's tear quest
		if (SMFlag > 0) {
			// trigger quest
			Language.XMLGeneral("Visits/VisitLadyFarun/VisitNymphsTearQuest");
		} else {
			// no, so just deliver the permits/location
			Language.XMLGeneral("Visits/VisitLadyFarun/VisitGotPermits");
		}
		return true;
	}

	
	// Lending
	
	// Do the actual loan
	public function LoanTo() : Boolean
	{	
		if (coreGame.SlaveGirl.DoLendLadyFarun() == true) return true;
		
		coreGame.ResetNotFucked();
		if (coreGame.SlaveGirl.ShowActLend(9) == false) coreGame.UseGeneric = true;
		// obsolete versions	
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		
		coreGame.ShowActImage();
		
		if (coreGame.LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		
		if (coreGame.AppendActText) {
			if (coreGame.SlaveFemale) sd.AlterSexuality(-3);
			Language.XMLGeneral("Visits/LendLadyFarun/NormalLend");
		}
		return true;
	}

		
	// Events
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			case 8299:
				if (coreGame.LendPerson == 0) {
					if (coreGame.VisitLendPerson != 0) Visit(false);
					else break;
				} else LoanTo();
				if (IsEventAllowable() && coreGame.EventNext._visible == false) coreGame.DoEventNext(8399);
				return true;	
				
			case 11002: 
				AttendCourt();
				return true;
				
		}
		return false;
	}

	
	// Slave Maker Actions

	public function AttendCourt()
	{
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 2);
		if (sd.VarReputation < 61) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0);
	
		PointsPerson(0, 4, 0, 0, 0);
		
		// Lady Farun Events
		if (CustomFlag2 == -1) {
			Language.XMLGeneral("Visits/VisitLadyFarun/PermitCourtHelp");
			return;
		} else if (CustomFlag2 > 0) {
			Language.XMLGeneral("Visits/VisitLadyFarun/PermitCourtLooking");
			return;
		}
		// is Lady Farun now as slut, show some gossip up to 1 in 3 visits
		if (PercentChance(int(SMFlag) / 3)) {
			Language.XMLGeneral("Visits/VisitLadyFarun/LadyFarunGossip");
		}
		
		if (DaysUnavailable != 0 || PercentChance(20)) Language.XMLData.XMLGeneral("Visits/VisitLadyFarun/LadyFarunNotFound");
		else Language.XMLGeneral("Visits/VisitLadyFarun/LadyFarunFound");
	}
	
}