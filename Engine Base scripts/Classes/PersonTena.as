// PersonMissN - Miss. N the prostitute
// number 10
// lend modifier n/a
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonTena extends Person {
		
	public function PersonTena(cg:Object, cc:Object) { 
		super("CuteLesbian", cg, 10, 0, false, cc);
		strCity = "Mardukane";
	}

	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowBedRoom(6);
			return super.ShowThem(1, 8, 2);
		} else if (place == "lend") {
			Backgrounds.ShowBar();
			return super.ShowThem(0, 1, Math.floor(Math.random()*2) + 1);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}
	
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(false, false, undefined, undefined, false);
	}
	
		// Meeting
	public function Meeting(meet:Number) : Boolean
	{
		trace("PersonTena.Meeting: " + meet);
		if (!super.Meeting(meet)) return false;
		
		ShowPerson(Id, 1, 3, 1);
		if (IsMet()) AddText(coreGame.SlaveMeet + " again Tena, the cute lesbian,");
		else AddText(coreGame.SlaveMeet + " a particularly cute girl, who introduces herself as Tena,");
		SetMet();
		return true;
	}
	
	
	// Visiting
	
	// called when checking if the person can be visited.
	public function CanBeVisited() : Boolean
	{
		return (coreGame.SlaveFemale || SMData.Gender != 1) && super.CanBeVisited();
	}

	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitCuteLesbian() == true) return true;
		SetVisited();

		if (PersonFlag < 5) {
			var inc:Number = Math.floor(sd.VarBlowJob / 5);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 5);
		}
		if (coreGame.LesbianTraining) {
			sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			coreGame.AlterSexuality(-2);
		} else coreGame.AlterSexuality(-1);
		sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
	
		PersonSpeak(10, "Anthy please play with #slave while I speak to #slavemakername but let me end the game", true);
		AddText("\r\rYou watch as Anthy moves very quickly and lightly restrains #slave with ropes. She then kisses #slave passionately then kneels ");
		if (!coreGame.Naked) AddText("removing #slavehisher clothing ");
		AddText("and then with enthusiasm licks and fingers #slave's pussy.\r\rYou sit and talk to Tena, but all the time Tena watches #slave...\r\r");
		
		if (coreGame.modulesList.trainLesbians.SlaveMakerTraining()) AddText("\r\rYou look and see #slave moaning and gasping, so far Anthy has kept #slavehimher from orgasming, keeping #slavehimher near the edge of orgasm. Tena asks Anthy to step aside and with expert touches and licks brings #slave crashing into a screaming, shaking" + coreGame.OrgasmText() + ". As #slave lies there panting, Anthy licks Tena to a fast and strong orgasm.");
	
		coreGame.modulesList.VisitChatWithPerson(10);
		coreGame.People.HearGossip(10);
		
		if (coreGame.RuinedTemple.CheckBitFlag(32) && (!coreGame.RuinedTemple.CheckBitFlag(43))) {
			//"\r\rLater " + SlaveName + NonPlural(" ask") + " Tena if she has heard of a place called the ruins. She thinks but says no.");
			BlankLine();
			Language.XMLGeneral("Visits/VisitCuteLesbian/AskMine"); 
			coreGame.RuinedTemple.SetBitFlag(43);
		}

		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{
		return coreGame.SlaveFemale && super.CanBeLoanedTo();
	}
	
	public function LoanTo() : Boolean
	{
		Money(-1);
		if (coreGame.SlaveGirl.DoLendCuteLesbian() == true) return true;
		
		coreGame.ResetNotFucked();
		
		if (coreGame.SlaveGirl.ShowActLend(7) == false) coreGame.UseGeneric = true;
		// obsolete versions
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		
		coreGame.ShowActImage();
		
		if (coreGame.LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		
		coreGame.AlterSexuality(-3);
		
		if (coreGame.AppendActText) Language.XMLGeneral("Visits/LendCuteLesbian/NormalLend");

		return true;
	}

	
	// Events
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			// 9 - cute lesbian girl sex
			case 9:
				CuteGirlLesbianSex();
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			// 9 - cute lesbian request for sex
			case 9:
				Language.XMLGeneral("Visits/VisitCuteLesbian/HaveSexNo");
				return true;
		}
		return false;
	}
	
	private function CuteGirlLesbianSex()
	{
		coreGame.AlterSexuality(-5);
		coreGame.HideStatChangeIcons();
		coreGame.TotalLesbian++;
		if (coreGame.TestObedience(coreGame.DifficultyLesbian, 11)) {
			if (coreGame.LesbianTraining) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			Points(0, 1, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0, 1, 2, -1, 0, 2, 0, 0, 0);
			AddText("#slave" + NonPlural(" enjoy") + " pleasuring the girl, licking her to a joyous orgasm. Tena very much enjoyed it and thanks #slave profusely.\r\rThe girl moves #slave and ");
			if (IsDickgirl()) {
				AddText("starts a little at the sight of #slave's " + Plural("cock") + ". ");
				if (coreGame.DickgirlLesbians) AddText("She comments that her preference is no cocks, but that " + coreGame.SlaveIs + " still " + Plural("a woman") + "! She gives #slave an awkward blowjob focusing on licking and fingering #slavehisher" + Plural(" pussy") + " until #slaveheshe" + coreGame.OrgasmText() + ". Tena carefully avoids getting any cum on her, but smiles.");
				else AddText("She looks sorry and stands, explaining 'I do not do cocks, sorry!'. She leans in and kisses gently #slave's " + Plural("forehead") + ".");
			} else AddText("expertly returns the favour, licking #slave to several quick orgasms.");
		} else {
			coreGame.DifficultyLesbian = coreGame.DifficultyLesbian - 2;
			Points(0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, -1, 1, 0, 2, 0, 0, 0);
			AddText("#slave did not enjoy pleasuring the girl. When Tena moves to do the same to #slave #slaveheshe" + NonPlural(" refuse") + ". Tena understands and gives #slave pointers for future.");
		}
		
		if (SMData.sLesbianTrainer < 1 && coreGame.Supervise && !IsAccessible()) {
			AddText("\r\rAfter Tena talks to you for a bit,\r\r");
			if (coreGame.IsDickgirl() && coreGame.DickgirlLesbians == false) {
				PersonSpeak(10, "I was thinking about how #slave could make " + Plural("a cute lesbian") + ", but " + coreGame.SlaveHeSheHas + " " + Plural("a cock") + " and this is not interesting to me as a lesbian. Maybe if she loses it? If you train a female slave sometime speak to me again.", true);
			} else {
				if (coreGame.SlaveGender > 3) PersonSpeak(10, "Why don't you train #slave as lesbians! They would make very cute and desirable ones.", true);
				else PersonSpeak(10, "Why don't you train #slave as a lesbian! She would make a very cute and desirable one.", true);
				AddText("\r\rYou explain while you know about training them in lesbian acts, you are not sure how to actually train them to <i>be</i> lesbians.\r\r");
				PersonSpeak(10, "I am no expert in slave training but I am an expert in lesbians. Why don't you bring #slave to <b>visit</b> my home sometime and I'll teach you what I can. I am sure #slave can pay me for my time in the same way as we just did...", true); 
				SetAccessible();
			}
		} else SetAccessible();
	}

}