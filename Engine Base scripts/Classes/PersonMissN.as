// PersonMissN - Miss. N the prostitute
// number 3
// lend modifier n/a
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonMissN extends Person {
		
	public function PersonMissN(cg:Object, cc:Object) { 
		super("Prostitute", cg, 3, 0, true, cc);
	}
	
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") return super.ShowThem(1.1, 1, Math.floor(Math.random()*2) + 1);
		else if (place == "lend") return super.ShowThem(1.1, 1, Math.floor(Math.random()*2) + 1);
		return super.ShowThem(placeo, align, gframe, delay);
	}

	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(true, false, undefined, undefined, false);
		ResetOtherFlags();
	}
	
	
	// Visiting
	
	// called when checking if the person can be visited.
	public function CanBeVisited() : Boolean
	{
		return ((((SMData.SMGold + coreGame.VarGold) >= 1) || coreGame.Owner.GetOwner() == 3) && super.CanBeVisited());
	}
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		trace("Visit:MissN " + PersonFlag);
		Money(-1);
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitProstitute() == true) return true;
		SetVisited();

		SetEvent(8012);
		if (PersonFlag >= 0 && PersonFlag < 5)
		{
			var inc:Number = Math.floor(sd.VarBlowJob / 5);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 5);
			AddText(SlaveVerb("talk") + " with the prostitute about her work. This discussion seems to make #slave horny.");
			sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, inc, 0, 0, 0, 0);
			if (Naked) {
				AddText("The prostitute comments how a lack of modesty is an advantage in her job. She also says how beautiful #slave's " + Plural("body") + " " + Plural("is") + ". " + SlaveName + NonPlural(" blush") + " but " + NonPlural("seem") + " pleased.");
				sd.Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
			}
			coreGame.modulesList.VisitChatWithPerson(Id);
			coreGame.People.HearGossip(Id, true);
			coreGame.ResetEventPicked();
		} else if (CheckBitFlag(32) && CustomFlag < 0) {
			CustomFlag = Math.floor(Math.random()*2) + 3;
			PersonSpeak(Id, "I am sorry you missed the cocks, I mean party. There is another in " + CustomFlag + " more days, come back then.", true);
			coreGame.People.HearGossip(Id, true);
			Diary.AddEntryFull("Party with Miss N.", coreGame.GameDate + CustomFlag, false, 0, false);
			coreGame.SlaveGirl.ProstitutePartyOffer(-1);
		} else if (CheckBitFlag(32) && CustomFlag == 0) {
			// Party
			Backgrounds.ShowBedRoom(16);
			ShowThem(1, 1, 11);
			SetText("You arrive at your friend, the prostitutes home, she is preparing for the party, trying on lingerie,\r\r");
			PersonSpeak(Id, "Well, Hi, #slavemakername and especially #slave, the party is on tonight. Instead of #slavehisher usual evening 'activities' <b>lend #slave</b> to me and I will escort #slavehimher for an evening of pleasure and money.\r\rNow everyone loves money and sex, but if you do not want #slave to 'come' with me then just do not load #slavehimher to me tonight.", true);
		} else if (!CheckBitFlag(32)) {
			if (Naked) {
				SetBitFlag(32);
				CustomFlag = Math.floor(Math.random()*2) + 3;
				Diary.AddEntryFull("Party with Miss N.", coreGame.GameDate + CustomFlag, false, 0, false);
				AddText("Miss N speaks to you both, but looks admiringly at #slave,\r\r");
				PersonSpeakStart(Id, "#slave you're as sexy as I thought, also good and shameless, parading your lovely naked " + Plural("body") + ".", true);
				if (!coreGame.SlaveFemale) AddText(" Your " + coreGame.CockText() + Plural(" is") + " especially nice, large and thick, yumm!");
				PersonSpeakEnd("\r\rI have been hired for a party in a few days to 'entertain'. I think #slave would love it too, #slaveheshe will 'meet' many people, even some advantageous to you and #slavehimher. Well, I do not have an invitation for you, #slavemakername, so I will have to escort #slavehimher for the evening.\r\rIf " + coreGame.SlaveHeShe + NonPlural(" want") + " to go to the party please <b>lend #slavehimher</b> to me at night in " + CustomFlag + " days.");
				coreGame.SlaveGirl.ProstitutePartyOffer(CustomFlag);
			} else if (PersonFlag == 100) PersonSpeak(Id, "Please, come back sometime, I would love to see your naked body.\r\rFor now we can have a chat but there is not much I can teach you, it is better to experience!", true);
			else {
				if (sd.SlaveGender > 3) PersonSpeak(Id, "#slave, you're beautiful, sexy people and I would love to see your naked bodies. Why don't you return some day when you are naked for all to see.\r\rI will have wonderful thing for you...", true);
				else PersonSpeak(Id, coreGame.SlaveName + ", you're a beautiful, sexy person and I would love to see your naked body. Why don't you return some day when you are naked for all to see.\r\rI will have wonderful thing for you...", true);
				AddText("\r\rThe prostitute slowly runs her hand over her pussy. #slave is somewhat confused by the offer, #slaveheshe knows Miss N is female!");
				sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
				PersonFlag = 100;
				coreGame.SlaveGirl.ProstitutePartyOffer(0);
			}
		} else {
			PersonSpeakStart(Id, "You're so eager, you'll love the party, but it is not today, come back ", true);
			if (CustomFlag > 1) PersonSpeakEnd("in " + CustomFlag + " days.");
			else PersonSpeakEnd("tomorrow.");
			coreGame.People.HearGossip(Id, true);
		}
		var ruins:Place = GetPlace("RuinedTemple");
		if (ruins.CheckBitFlag(32) && (!ruins.CheckBitFlag(33))) {
			AddText("\r\r" + SlaveVerb("ask") + " the prostitute if she has heard of a place called the ruins. She thinks a bit and says she once had a customer of the old faith who mentioned a ruined temple in passing.");
			ruins.SetBitFlag(33);
		}
		if (coreGame.NumEvent == 8012) {
			DoEvent(8012);
			return false;
		}
		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{
		return ((((SMData.SMGold + coreGame.VarGold) >= 1) || sd.Owner.GetOwner() == 3) && super.CanBeLoanedTo());
	}
	
	public function LoanTo() : Boolean
	{
		if (CustomFlag == 0 && CheckBitFlag(32) && !IsDayTime()) {
			coreGame.modulesList.Parties.ProstituteParty(8020);
			return true;
		}
		Money(-1);
		if (coreGame.SlaveGirl.DoLendProstitute() == true) return true;
		
		if (IsDayTime()) {
			Backgrounds.ShowTownCenter();
			sd.Points(0, 1, 1, 1 ,0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 2, 1, 0, 0);
			SetText("In the morning Miss N. relaxes for a while and chats pleasantly with #slave. After a late breakfast she take #slave shopping in the Town Center. She is very energetic and flirts with all the salespersons, but never does anything more than flirt, despite a few offers. She happily refuses them with a comment about 'another time'.");
			var dg:Boolean = IsDickgirlEvent();
			ShowThem(1, 1, dg ? 13 : 12);
			if (dg) {
				AddText("\r\rWhile chatting a little, " + coreGame.SlaveSee + " Miss N. has grown a large cock and it is poking out of her very short skirt. #slave can also clearly see Miss N. is not wearing any panties. Miss N. hides her cock as best as she can in her skirt and explains,\r\r");
				switch(slrandom(4)) {
					case 1: PersonSpeakStart(Id, "Last night I had a Lady customer who insisted I fuck her, so I had to take a mild potion. The Lady was very, very much in need and had me fuck her many times, enough to need a couple of doses of the potion.", true); break;
					case 2: PersonSpeakStart(Id, "Last night I had a Gentleman customer who insisted I take a potion to make me temporarily a hermaphrodite. He had me masturbate for his pleasure and he fucked me but did not touch my cock. He then made me fuck a maid of his but the potion wore off before I 'finished'. He made me drink another to 'finish' the maid.", true); break;
					case 3: PersonSpeakStart(Id, "Last night I had a Gentleman customer who insisted I take a potion to make me temporarily a hermaphrodite. He had me masturbate for his pleasure and he fucked me, masturbating my cock, but not letting me cum. He came strongly in my pussy and then made me ass-fuck one of his maids as she licked his cock. Unfortunately the potion wore off before I 'finished' and he made me drink another to 'finish' the maid.", true); break;
					case 4: PersonSpeakStart(Id, "Last night I had a customer, a hermaphrodite, who says she only fucks other hermaphrodites. She gave me a mild potion to temporarily make me a hermaphrodite. She then fucked me and I her many times, enough to require several doses of the potion.", true); break;
				}
				PersonSpeakEnd(" Taking that much of the potion can have some lingering effects.");
				AddText("\r\rShe points to her erection under her skirt and smiles. She then leads #slave into a dark alley and takes her erect cock out. She asks, or maybe tells, #slave to please 'deal' with it, as she gently pushes #slave to #slavehisher knees. #slave happily agrees and licks Miss N.'s cock until she cums passionately and strongly into " + SlaveName1 + "'s mouth.");
			}
			AddText("\r\rLater they have lunch and then Miss N. tells #slave 'Time for work'...");
			DoEvent(8410);
			
		} else coreGame.DoEventNext(8410);
		return true;
	}

	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
			// 8012 After Prostitute
			case 8012:
				AfterProstitute();
				break;
				
			// Lend to Miss N
			case 8410:
				Backgrounds.ShowBedRoom(16);
				ShowThem(0, 1, Math.floor(Math.random()*2) + 1);
				coreGame.ResetNotFucked();
				
				coreGame.PayRate = coreGame.SlaveGirl.ShowJobBrothel();
				if (coreGame.PayRate == undefined) { coreGame.PayRate = 1; coreGame.UseGeneric = !coreGame.UseImages; }
				if (coreGame.UseImages) coreGame.ShowActImage(16);
				if (coreGame.UseGeneric) coreGame.Generic.ShowJobBrothel();
	
				var tempvar:Number = -2;
				if (coreGame.VarNymphomaniaRounded>94) tempvar = 1;
				if (coreGame.PayRate > 1) tempvar = 1;
				tempvar = tempvar * 2;
				var pay:Number = 3 * EarnMoney((10*Math.floor((sd.VarCharisma+sd.VarConstitution)/10)+Math.floor(sd.VarBlowJob/30)+Math.floor(sd.VarFuck/5)+Math.floor(sd.VarIntelligence/5)) * coreGame.PayRate);
				sd.Points(0, tempvar, -3, -2, -4, 4, 0, 0, 0, 0, 2, 4, 6, 2, 0, 0, 16, tempvar, tempvar, 0);
				
				if (IsDayTime()) SetText("In the afternoon ");
				else SetText("");
				AddText("Miss N. takes #slave to visit several customers, and has #slave actively participate. The customer is surprised that " + coreGame.SlaveIs + " there but Miss N. explains that " + coreGame.SlaveHeSheIs + " a bonus...");
	
				ShowPlanningNext();
				return true;
				
		}
		return false;
	}
	
	public function AfterProstitute()
	{
		Backgrounds.ShowBedRoom(6);
		AddText("As you get up to leave, Miss N speaks to you,\r\r");
		PersonSpeak(Id, "Well you have paid for my services and you are <i>both</i> very attractive...", true);
		if (coreGame.TestObedience(sd.DifficultyThreesome, 111)) {
			if (Math.floor(Math.random()*3) < 2) {
				if (SMData.Gender == 2) temp = 6;
				else if (IsDickgirl()) temp = 5;
				else temp = 7;
			} else temp = Math.floor(Math.random()*3) + 8;
			if (LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			sd.Points(0, 0.5, 0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0.5, 0, -0.5, 0, 1, 0, 0, 0);
			AddText("\r\rHappily you both accept her offer...");
		} else {
			AddText("\r\r" + coreGame.SlaveIs + " reluctant, so you refuse her offer, for now...");
			temp = Math.floor(Math.random()*3) + 8;
		}
		if (temp == 10) HideBackgrounds();
		ShowThem(1, 1, temp);
		coreGame.NobleLoveEvent(Id, true);
	}
	
	public function NewDay(nDays:Number)
	{
		super.NewDay(nDays);
		
		CustomFlag -= nDays;
	}

}