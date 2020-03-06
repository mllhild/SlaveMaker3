import Scripts.Classes.*;

// Count class details

// Count
//
//PersonFlag
//  Reputation gained (max 20)

function DoVisitCount() : Boolean
{
	ShowPerson(7, 1, 1, 1);
	Backgrounds.ShowPalace();
	
	//If checking if you can lend to him
	if (LendPerson == -1000) {
		if (!Count.IsVisited()) {
			//SetText("You should at least take #slave to visit Count Gossem before trying to lend #slave to him.");
			XMLData.XMLGeneral("Visits/LendCount/VisitFirst");
			LendPerson = 0;
		} else {
			if (Count.CheckBitFlag(0)) XMLData.XMLGeneral("Visits/LendCount/LendArrangedBE");
			else XMLData.XMLGeneral("Visits/LendCount/LendArranged"); //"You will make arrangements to loan #slave to Count Gossem. You hope he will teach #slave more of the Court, but you hear he is a man of passions, so...");
		}
		return false;
	}
	
	// actually visiting
	
	// palace open?
	if (!Palace.IsAccessible()) {
		PersonSpeak(54, Language.GetHtml("PalaceInaccessible", currentCity.FindPlaceNodeCByName("Palace")), true); //"You are not allowed into the Palace, begone!"
		return false;
	}
	
	// First visit ever
	if (Count.IsInitialVisit()) {
		XMLData.XMLGeneral("Visits/VisitCount/VisitIntroduction");
		BlankLine();
		Count.DoneInitialVisit();
	}
	
	// No naked slaves!
	if (Naked) {
		PersonSpeak(7, Language.GetHtml("NakedResponse", GetNodeC("Visits/VisitCount")), true);  //"I will not speak to a naked slave."
		return false;
	}
	
	// does your slave meet the needed criteria
	if (vitalsBust >= 90 || SMAdvantages.CheckBitFlag(0) || SMAdvantages.CheckBitFlag(1) || VarRefinementRounded >= 60 || (NobleLove != 0 && NobleLoveType == 2) || Owner.GetOwner() == 7)
	{
		Count.SetVisited();
		var ret:Boolean = true;
		if (SlaveGirl.DoVisitCount() != true) ret = VisitCount();
		AfterVisitCount();
		return ret;
	}
	
	// no? then turn the slave away
	if (SlaveFemale) PersonSpeak(7, Language.GetHtml("RejectVisitFemale", GetNodeC("Visits/VisitCount")), true); //"Make this slave go away! Ladies may visit not crude girls."
	else PersonSpeak(7, Language.GetHtml("RejectVisitMale", GetNodeC("Visits/VisitCount")), true); //"Make this slave go away! Gentlemen may visit not crude boys."
	return false;
}

// Actually visit the count
function VisitCount() : Boolean {
	if (Count.TotalVisit == 1 && SlaveFemale) {
		var eNode:XMLNode = GetNode("Visits/VisitCount/FirstVisit");
		if (XMLEventByNode(eNode, false)) return false;
	} else if (Count.CheckBitFlag(0) && ((GameDate - Count.SMFlag) > 3) && !Count.CheckBitFlag(1)) {
		var eNode:XMLNode = GetNode("Visits/VisitCount/BEEvent2");
		if (XMLEventByNode(eNode, false)) return false;
	}
																		 

	if (Count.PersonFlag < 20) {
		
		var inc:Number = Math.floor(VarIntelligenceRounded / 10);
		Count.PersonFlag = Person.VisitVar(Count.PersonFlag, inc, 20);
		XMLData.XMLGeneral("Visits/VisitCount/NormalVisit"); //"#slave talks with Count Gossem about stories of the heart and philosophy."
		Points(0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, inc, 0, 0, 0, 0);
		
	} else {
		
		PersonSpeak(7, Language.GetHtml("VisitedEnough", GetNodeC("Visits/VisitCount")), true); //"I enjoyed talking with you but you should see someone else now."

	}
	
	modulesList.VisitChatWithPerson(7);
	People.HearGossip(7);
	return true;
}

function AfterVisitCount()
{
	if (RuinedTemple.CheckBitFlag(32) && (!RuinedTemple.CheckBitFlag(37))) {
		BlankLine();
		XMLData.XMLGeneral("Visits/VisitCount/AskMine"); //"#slave asks Count Gossem if he has heard of a place called the ruins. He shakes his head and tells her it is best not to ask certain questions."
		RuinedTemple.SetBitFlag(37);
	}
}


// Lending

function DoLendCount()
{
	ShowPerson(7, 0, 1, 1);
	Backgrounds.ShowPalace();
	
	if (!Palace.IsAccessible()) {
		PersonSpeak(54, Language.GetHtml("PalaceInaccessible", currentCity.FindPlaceNodeCByName("Palace")), true); //"You are not allowed into the Palace, begone!"
		return;
	}
	if (Naked) {
		PersonSpeak(7, Language.GetHtml("NakedResponse", GetNodeC("Visits/VisitCount")), true);  //"I will not speak to a naked slave."
		return;
	}
	if (vitalsBust >= 90 || SMAdvantages.CheckBitFlag(0) || SMAdvantages.CheckBitFlag(1) || VarRefinementRounded >= 60 || (NobleLove != 0 && NobleLoveType == 2) || Owner.GetOwner() == 7) {
		if (SlaveGirl.DoLendCount() == true) return;
		LendCount();
		return;
	}
	if (SlaveFemale) PersonSpeak(7, Language.GetHtml("RejectVisitFemale", GetNodeC("Visits/VisitCount")), true); //"Make this slave go away! Ladies may visit not crude girls."
	else PersonSpeak(7, Language.GetHtml("RejectVisitMale", GetNodeC("/Visits/VisitCount")), true); //Make this slave go away! Gentlemen may visit not crude boys."
}

function LendCount()
{
	if (Count.CheckBitFlag(1) && !Count.CheckBitFlag(2)) {
		var eNode:XMLNode = GetNode("Visits/VisitCount/BEEvent3");
		if (XMLEventByNode(eNode, false)) return;
	}
	if (SlaveGirl.ShowActLend(7) == false) {
		UseGeneric = true;
		// obsolete versions
		SlaveGirl.ShowSexActLendHer();
		SlaveGirl.ShowActLendHer();
		ShowActImage();
	}
	if (SlaveFemale) {
		ResetNotFucked();
		if (Day) Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		if (AppendActText) {
			// The Count tells #slave that he only wants #slavehimher sexually, nothing more. He proceeds to fuck #slavehimher often, mostly tit-fucking #slavehimher and sometimes other ways, but always groping #slavehisher breasts.
			XMLData.XMLGeneral("Visits/LendCount/NormalLendFemale");
		}
	} else {
		ShowPerson(7, 1, 1, 1);
		Points(0, 3, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (AppendActText) {
			// The Count spends the time talking with #slave about the court and matters of etiquette. After a while he has a large breasted slave sit in his lap and he unconsciously gropes her breasts.
			XMLData.XMLGeneral("Visits/LendCount/NormalLendMale");
		}
	}
}
