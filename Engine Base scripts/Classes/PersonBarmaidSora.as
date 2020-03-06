// PersonBarmaidSora Sora the Barmaid
// number 2
// lend modifier -15
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonBarmaidSora extends Person {
		
	public function PersonBarmaidSora(cg:Object, cc:Object) { super("Barmaid", cg, 2, -15, false, cc); }
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(false, false, undefined, undefined, false);
	}
	
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowBar();
			if (IsInitialVisit()) return super.ShowThem(1, 1, 1);
			else return super.ShowThem(1, 1, Math.floor(Math.random()*2) + 1);
		} else if (place == "lend") {
			Backgrounds.ShowBar();
			return super.ShowThem(0, 1, Math.floor(Math.random()*2) + 1);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}
	
	// Identity
	
	public function IsPerson(str:String) : Boolean
	{		
		if (str.toLowerCase() == "sora") return true;
		return super.IsPerson(str);
	}
	
	// Meet her
	public function Meeting(meet:Number) : Boolean
	{
		if (!super.Meeting(meet)) return false;
		
		if (!IsAccessible()) {
			SetAccessible();
			AddText("\r\rThe barmaid tells #slave about the places she works and suggests that #slaveheshe could <b>visit</b> her sometime while working.");
		}
		return true;
	}
	
	
	// Contests
	
	public function DoContestsNext(numcontest:Number, actno:Number) : Boolean
	{
		if (numcontest != 30) return false;
		if (coreGame.IsAssistant("Sora")) return false;
		
		coreGame.modulesList.Contests.mcBase.ClipRivalABeauty.gotoAndStop(temp);
		coreGame.modulesList.Contests.mcBase.ClipRivalABeauty._visible = true;
			
		if (IsAccessible()) AddText("This girl tried hard.\r\rShe obtained : #rivalascore pts\r\r");
		else AddText("Sora, the barmaid, tried hard.\r\rShe obtained : #rivalascore pts\r\r");
		return true;
	}
	
	
	// Visiting
	
	// Can the slave be visited to
	public function CanBeVisited() : Boolean
	{
		return (sd.VarConversation >= 30) && super.CanBeVisited();
	}
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitBarmaid() == true) return true;		
		SetVisited();

		var askq:Boolean = false;
		
		if (PersonFlag < 5)
		{
			var inc:Number = Math.floor(sd.VarConversation / 10);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 5);
			Language.XMLGeneral("Visits/VisitBarmaid/NormalVisit");
			askq = true;
			
		} else {
			//"Sora takes a break and sits and talks with #slave about many things, but she has little more she can teach #slave\
			//PersonSpeak(2, "I enjoy talking with you but you should seek out other teachers."
			Language.XMLGeneral("Visits/VisitBarmaid/VisitedEnough");
		}
		
		coreGame.modulesList.VisitChatWithPerson(Id);
		
		var ruins:Place = GetPlace("RuinedTemple");
		if (ruins.CheckBitFlag(32) && (!ruins.CheckBitFlag(39))) {
			//"\r\r" + SlaveVerb("ask") + " Sora if she has heard of a place called the ruins. Sora thinks a bit but shakes her head no.");
			BlankLine();
			Language.XMLGeneral("Visits/VisitBarmaid/AskMine"); 
			ruins.SetBitFlag(39);
		}
		if (askq) {
			// AskHerQuestions(8000, 8001, 8002, 9903, "Tell me about yourself", "'Other' entertainments", "Gossip", "Nothing", "What will #slave ask her about?");
			Language.XMLGeneral("Visits/VisitBarmaid/QuestionSora");
			return false;
		}
		return true;
	}
	
	// Lending
	
	// Can the slave be loadned to
	public function CanBeLoanedTo() : Boolean
	{
		return (sd.VarConversation >= 30) && super.CanBeLoanedTo();
	}

	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendBarmaid() == true) return true;
		
		coreGame.ResetNotFucked();
		
		coreGame.UseGeneric = false;
		coreGame.PayRate = coreGame.SlaveGirl.ShowJobSleazyBar(false);
		if (coreGame.UseImages || coreGame.UseGeneric) {
			coreGame.ShowActImage(24);
			if (coreGame.UseGeneric && sd.LingerieOK == 1) coreGame.ShowActImage(10013);
			if (coreGame.UseGeneric && sd.BunnySuitOK == 1) coreGame.ShowActImage(10017);
			if (coreGame.UseGeneric) coreGame.ShowActImage(16);
		} 
				
		if (coreGame.SlaveFemale) sd.AlterSexuality(-3);
		if (LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		
		if (coreGame.AppendActText) Language.XMLGeneral("Visits/LendBarmaid/NormalLend");

		return true;
	}

	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
			// 8001
			case 8001:
				ShowThem(1, 1, 3);
				sd.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
				sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				if (SMData.Gender != 2) {
					AddText("The barmaid asks you to join them in a private booth and sit comfortably. She kneels down and gives you an amazingly good blowjob, the best you can remember. She licks and sucks until you cum with a gasp into her mouth. She swallows, looking at you with a smile. She then explains to #slave some fine points of technique.");
					if (SMData.Gender == 3) AddText("\r\rShe discusses the differences between a man and a hermaphrodite, especially the hermaphrodite's libido. She gestures are your hardening cock and she leans down and gives another 'demonstration', this time fingering your pussy as well. You cum quickly from her skilled attention, again she swallows with a smile.");
					AddText("\r\rSora stands and quickly kisses your forehead\r\r");
					PersonSpeak(Id, "Thanks for your assistance.", true);
				} else AddText("The barmaid takes #slave into a private booth, you follow at a distance. You see the barmaid kneel before a customer, take out his cock and give him what appears to be a skillful blowjob.\r\rJust before he cums she stops and describes techniques to #slave to the frustration of the man. She resumes for a bit, demonstrating, again stopping before he cums. She straightens and then finishes him by hand, the man cums quite strongly, cum spraying into the air.\r\rThey return to you, and you hear the barmaid comment how only the worthy or cute are finished by mouth.");
				coreGame.DoEventNext(8399);
				ShowPlanningNext();
				return true;
				
			// 8002
			case 8002:
				coreGame.People.HearGossip(Id, true);
				sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0);
				coreGame.DoEventNext(8399);
				ShowPlanningNext();
				return true;
				
			// fist meeting with the barmaid
			case 8003:
				coreGame.HideSlaveImages();
				coreGame.HideSlaveActions();
				Visit(false);
				ShowPlanningNext();
				return true;
													
		}
		return false;
	}

}