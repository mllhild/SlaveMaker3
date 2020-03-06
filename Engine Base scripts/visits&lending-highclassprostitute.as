import Scripts.Classes.*;

// Visit
function DoVisitHighClassProstitute() : Boolean
{
	ShowPerson(4, 1, 1, 1);
	Backgrounds.ShowBedRoom(16);

	//If checking if you can lend to her
	if (LendPerson == -1000) {
		if (!HighClassProstitute.IsVisited()) {
			if (XMLData.XMLGeneral("Visits/LendHighClassProstitute/VisitFirst")) LendPerson = 0;
		} else if (HighClassProstitute.CustomFlag == 0 && HighClassProstitute.CheckBitFlag(32)) {
			if (Day) SetText("The function Lady Okyanu spoke of is tonight but she will happily educate #slave today as well.");
			else SetText("The function Lady Okyanu spoke of is tonight so you will send #slave to attend the event with her.");
		} else {
			XMLData.XMLGeneral("Visits/LendHighClassProstitute/LendArranged");
		}
		return false;
	}
	
	// First visit ever
	if (HighClassProstitute.IsInitialVisit()) {
		XMLData.XMLGeneral("Visits/VisitHighClassProstitute/VisitIntroduction");
		HighClassProstitute.DoneInitialVisit();
	}
		
	// if she unwell/unavailable
	if (HighClassProstitute.DaysUnavailable != 0) {
		if (XMLData.XMLGeneral("Visits/VisitHighClassProstitute/Unavailable")) {
			LendPerson = 0;
			return false;
		}
	}
	
	// does your slave meet the needed criteria
	if (Home.HouseType == 5 || VarRefinement >= 25 || NobleLoveType == 4 || Owner.GetOwner() == 4) {
		HighClassProstitute.SetVisited();
		var ret:Boolean = true;
		if (SlaveGirl.DoVisitHighClassProstitute() != true) ret = VisitHighClassProstitute();
		return ret;
	}
	
	// no? then turn the slave away
	XMLData.XMLGeneral("Visits/VisitHighClassProstitute/RejectVisit");
	return false;
}

function VisitHighClassProstitute() : Boolean
{
	if (Home.HouseType == 5 || (HighClassProstitute.PersonFlag >= 0 && HighClassProstitute.PersonFlag < 5))
	{
		var done:Boolean = false;
		AddText(SlaveVerb("talk") + " with the High Class Prostitute, Lady Okyanu, and they discuss how to please their companions through conversations, games, but mainly sex.");
		temp = Math.floor(Math.random()*2);
		if (LesbianTraining && temp < 1) temp = 1;
		if (HighClassProstitute.PersonFlag < 0 || HighClassProstitute.PersonFlag >= 5) {
			Points(0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			done = true;
		} else {
			ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 1);
			var inc:Number = Math.floor(VarFuckRounded / 10);
			HighClassProstitute.PersonFlag = Person.VisitVar(HighClassProstitute.PersonFlag, inc, 5);
			Points(0, 0, 2, 0, 0, 0, 0, 0, 1, 0, temp, 0, 0, 0, 1, inc, 0, 0, 0, 0);
		}
		if (LesbianTraining) AddText("\r\rLady Okyanu also discusses serving women companions and gives a few suggestions.");
		if (Naked) {
			AddText("\r\rLady Okyanu says that most of her customers would prefer #slave wearing " + Plural("an elegant dress") + ". She also says how #slave's naked " + Plural("body") + Plural(" is") + " very sexy.");
			Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		}
		if (IsDickgirl()) AddText("\r\rLady Okyanu seems unconcerned about #slave's" + CockText() + ", but does talk about how hermaphrodites can be popular in her profession.");
		modulesList.VisitChatWithPerson(4);
		People.HearGossip(4);
		if (Home.HouseType != 5) return true;
		if (!done) return true;
		AddText("\r\r");
	}
	
	if (modulesList.trainCourtesans.Training()) return true;
	
	if (HighClassProstitute.CustomFlag < 0 && HighClassProstitute.CheckBitFlag(32)) {
		HighClassProstitute.CustomFlag = Math.floor(Math.random()*3) + 6;
		Diary.AddEntryFull("Function with Lady Okyanu", GameDate + HighClassProstitute.CustomFlag, false, 0, false);
		PersonSpeak(4, "I am sorry but you missed the function. If you still want there is another in " + HighClassProstitute.CustomFlag + " more days, come back then.", true);
	} else if (HighClassProstitute.CustomFlag == 0 && HighClassProstitute.CheckBitFlag(32)) {
		// Party
		Backgrounds.ShowBedRoom(16);
		ShowPerson(4, 1, 1, 2);
		SetText("You take #slave to see the courtesan, Lady Okyanu, who is dressed prettily but somewhat casually. She looks over #slave and says,\r\r");
		PersonSpeakStart(4, "Good morning my dears, the function is confirmed to start this evening at nightfall. " + SlaveName, true);
		var canattend:Boolean = true;
		if (((VarCharismaMod + VarRefinementMod) > 25) || IsDressCourtly()) AddText(", you are wearing " + Plural("a lovely and elegant dress") + ", and some nice jewellery. They are perfectly suited to attend the function.");
		else {
			canattend = false;
			AddText(", I am sorry, but your " + Plural("dress") + " and accessories are not really of the right style. I cannot let you accompany me to the function. You need to wear " + Plural("a beautiful dress") + " or " + Plural("one") + " suited to the court.");
		}
		if (VarRefinementRounded > 59) AddText(" #slave you are well spoken and courteous, and will comport yourself well.");
		else {
			AddText(" I am afraid #slave, you need some additional education in etiquette. I cannot allow you to attend the function, it would disgrace my reputation.");
			canattend = false;
		}
		if (canattend) {
			PersonSpeakEnd("\r\rIf you would still like #slave to attend lend #slave to me tonight and I will take #slavehimher to the function.");
		} else {
			PersonSpeakEnd("\r\rUnfortunately #slave cannot come with me tonight. There are similar functions almost weekly, come back another day when " + SlaveHeSheIs + " better trained.");
			HighClassProstitute.CustomFlag = Math.floor(Math.random()*3) + 6;
		}
	} else if (!HighClassProstitute.CheckBitFlag(32)) {
		var convgoal:Number = 100;
		if (MaxStat >= 150) convgoal = 150;
		if (VarConversationRounded >= convgoal) {
			HighClassProstitute.SetBitFlag(32);
			HighClassProstitute.CustomFlag = Math.floor(Math.random()*2) + 3;
			Diary.AddEntryFull("Function with Lady Okyanu", GameDate + HighClassProstitute.CustomFlag, false, 0, false);
			PersonSpeak(4, SlaveName + ", you are " + Plural("a charming young lady") + " and " + Plural("a talented conversationalist") + ". I do see that you need some education in the fine art of high-class conversation.\r\rThere is a social function I have been invited to participate in. If you like I can escort you there and train you in the art of fine conversation. Some other, physical, skills may also be needed to help entertain...", true);
			if (Slutiness < 5) AddText("\r\r" + SlaveVerb("wonder") + " if she means dancing?");
			else  AddText("\r\r" + SlaveIs + " sure she means sex, after all she is a prostitute, a high-class one but still a prostitute.");
			BlankLine();
			PersonSpeakStart(4, SlaveName + ", you will have to dress appropriately and act in an elegant and refined manner. ", true);
			var canattend:Boolean = true;
			if (((VarCharismaMod + VarRefinementMod) > 25) || IsDressCourtly()) AddText("You are wearing a lovely and elegant dress, and some nice jewellery. They are perfectly suited to attend the function.");
			else {
				canattend = false;
				AddText("I am sorry, but your clothes and accessories are not really of the right style. I could not let you accompany me to the function. You need to wear a beautiful dress or one suited to the court.");
			}
			if (VarRefinementRounded > 59) AddText(" #slave you are well spoken and courteous, and would be able to deal with the noble persons at the function.");
			else {
				AddText(" I am afraid #slave, you need some additional education in etiquette. I could not allow you to attend the function, it would disgrace my reputation.");
				canattend = false;
			}
			AddText("\r\rThe function is planned for the evening in " + HighClassProstitute.CustomFlag + " days time. ");
			if (canattend) PersonSpeakEnd("Please #slavemakername <b>lend #slave</b> to me then, dressed as " + SlaveHeSheIs + " now.");
			else PersonSpeakEnd("Please train and try improving your attire and accessories. You can have #slavemakername lend you to me for the function and if you are acceptable I will accompany you.");
			SlaveGirl.HighClassPartyOffer(days);
			Points(1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		} else {
			PersonSpeak(4, "I have nothing more to teach you but we can gossip and tell stories.");
			AddText("\r\rThey have a pleasant but inconsequential chat ");
			if (HighClassProstitute.PersonFlag < 500) {
				AddText("but as #slave leaves the Lady mentions,\r\r");
				PersonSpeak(4, "Sometime I can teach you more about entertaining and being a fine conversationalist, but you need more experience. Go out and talk and chat with many people.\r\rYou need you learn as much as you possibly can of the art of conversation", true);
				if (sSlaveTrainer < 2) {
					AddText("\r\rShe gestures to you and you lean over. She whispers,\r\r");
					PersonSpeak(4, "Actually I doubt #slaveheshe can train well enough, you need to learn more of the art of training slaves.", true);
					AddText("\r\rShe caresses your cheek, and starts chatting with #slave.");
				}
				HighClassProstitute.PersonFlag = 500;
			} else AddText(".");
		}
	} else {
		PersonSpeakStart(4, "You're a bit early, the function is not today, come back ", true);
		if (HighClassProstitute.CustomFlag > 1) AddText("in " + HighClassProstitute.CustomFlag + " days.");
		else AddText("tomorrow.");
		if (SlaveGirl.HighClassPartyCheck() == true) return true;
		if (((VarCharismaMod + VarRefinementMod) > 25) || IsDressCourtly()) AddText("\r\rYou are wearing a lovely and elegant dress, and some nice jewellery. They are perfectly suited to attend the function.");
		else AddText("\r\rI am sorry, but your clothes and accessories are not really of the right style. I could not let you accompany me to the function. You need to wear a beautiful dress or one suited to the court.");
		if (VarRefinementRounded > 59) PersonSpeakEnd("\r\r#slave you are well spoken and courteous, and would be able to deal with the noble persons at the function.");
		else PersonSpeakEnd("\r\rI am afraid #slave, you need some additional education in etiquette. I could not allow you to attend the function, it would disgrace my reputation.");
	}
	if (RuinedTemple.CheckBitFlag(32) && (!RuinedTemple.CheckBitFlag(34))) {
		AddText("\r\r" + SlaveName + NonPlural(" ask") + " Lady Okyanu if she has heard of a place called the ruins. She says she once heard a certain nobleman talk to a person about a business in the 'the lower ruins'. She refuses to name the nobleman.");
		RuinedTemple.SetBitFlag(34);
	}
	return true;
}
