// PersonPonyMistress - Mistress Epona
// number 11
// lend modifier 0
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonPonyMistress extends Person {
		
	public function PersonPonyMistress(cg:Object, cc:Object) { 
		super("PonyMistress", cg, 11, 0, false, cc);
		strCity = "Mardukane";
	}
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowOther(1);
			return super.ShowThem(1, 1, 2);
		} else if (place == "lend") {
			Backgrounds.ShowKitchen(2);
			return super.ShowThem(0, 1, 2);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}
	
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(undefined, undefined, undefined, undefined, false);
	}
	
	
	// Visiting

	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		SetVisited();
		
		if (sd.BitGagOK == 0) {
			PersonSpeak(Id, "Before I will talk with you, your slave must be fitted with a bit-gag. Return another time when you have one.", true);
			return true;
		}
		if (sd.BitGagWorn == 0) {
			AddText("Before you talk Mistress Epona insists " + SlaveName + NonPlural(" wear") + " #slavehisher " + Plural("bit-gag") + ". She is insistent so you fit the " + Plural("gag") + ". ");
			if (sd.PonygirlInterest > SMData.sPonyTrainer) coreGame.EquipItem(14);
			else {
				AddText("\r\r" + SlaveVerb("refuse") + " and Mistress Epona looks a little angry and insistes you leave.");
				return true;
			}
		}
		if (PersonFlag < 5) {
			var inc:Number = Math.floor(sd.VarConstitution / 10);
			sd.Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, inc, 0, 0, 0, 0);
			AddText("While you talk with Mistress Epona she has you order #slave to exercise, mainly run around the room. #slave");
			if (Naked) AddText(" starts, running beautiful and naked.\r\r");
			else AddText(" starts but Mistress Epona stops #slavehimher and tells you that #slaveheshe must be naked, a horse is naked to the sky! You ask #slave and #slaveheshe agrees, a bit shyly.\r\r");
		}
		if (!coreGame.modulesList.trainPonies.SlaveMakerTraining()) AddText("Mistress Epona talks with you about the joy of being the Mistress of a ponygirl.");

		coreGame.modulesList.VisitChatWithPerson(Id);
		coreGame.People.HearGossip(Id, false);
		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{	
		return coreGame.IsPonygirl() && super.CanBeVisited();
	}
	
	public function LoanTo() : Boolean
	{
		coreGame.ResetNotFucked();
		if (coreGame.SlaveGirl.ShowActLend(Id) == false) coreGame.UseGeneric = true;
		// obsolete versions
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		coreGame.ShowActImage();
		
		coreGame.ChangePonyTraining(3);
		if (coreGame.LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		if (coreGame.AppendActText) {
			if (coreGame.SlaveFemale) AddText("Mistress Epona tells #slave that #slaveheshe will be bound and bred. Quickly #slave is securely bound and then a group of men, all wearing masks enters the room. The men fuck #slave over and over, always cumming into #slavehisher" + coreGame.PussyText() + "\r\rDuring this Mistress Epona kneels over " + coreGame.SlaveName1 + " face and orders her to lick...");
			else AddText("Mistress Epona tells #slave that #slaveheshe will be bound and bred. Quickly #slave is securely bound and then a group of ponygirls enter the room. They 'mount' #slave in turn, fucking #slavehimher over and over, always making sure #slaveheshe cums into their pussies.\r\rDuring this Mistress Epona kneels over " + coreGame.SlaveName1 + " face and orders him to lick...");
		}
		return true;
	}

}