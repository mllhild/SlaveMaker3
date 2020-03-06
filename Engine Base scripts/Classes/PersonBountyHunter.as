// PersonBountyHunter Irinia the Bounty Hunter
// number 12
// lend modifier 100
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonBountyHunter extends Person {
		
	public function PersonBountyHunter(cg:Object, cc:Object) { 
		super("BountyHunter", cg, 12, 100, false, cc);
	}
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowBar(1);
			return super.ShowThem(1, 2, 1);
		} else if (place == "lend") {
			Backgrounds.ShowBar(1);
			return super.ShowThem(0, 2, 1);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		Initialise();
		AddNumberedEvents(6);
		ResetEvents(4);
		NoRepeatEvent(4);

		super.StartNewSlave(false, false, undefined, undefined, false);
	}
	
	// Meet her
	public function Meeting(mt:Number) : Boolean
	{
		if (!super.Meeting(mt)) return false;
		
		ShowSupervisor();
		SetMet();
		var meet:String = GetNextEvent();
		if (meet == "") meet = GetEvent();
		else SetEventDone(meet);
		var i:Number;
		if (CheckBitFlag(32)) i = 5 + slrandom(2);
		else {
			var earr:Array = meet.split("-");
			i = Number(earr[1]);
		}
	
		switch (i) {
			case 1:
				PointsPerson(0, 0, 1, 0, 2);
				NoRepeatEvent(1);
				ShowThem(1, 2, 1);
				sd.Points(2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0);
				AddText(coreGame.SlaveMeet + " a beautiful woman, who is a bounty hunter, sometimes hunting run-away slaves, other times criminals or dangerous monstrosities.\r\rShe is a little busy so they only briefly talk but she is happy and cheerful.\r\r#slave's mood is lightened by the short chat. " + coreGame.SlaveHeSheUC + " is also impressed with the woman's beauty and decides to vary #slavehisher hair and makeup a little to match her's.");
				break
			case 2:
			case 5:
				PointsPerson(0, 0, 5, 0, 0);
				ShowThem(1, 2, 1);
				Backgrounds.ShowBar();
				sd.Points(0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, -2, 1, 0, 0);
				if (coreGame.Supervise) 	AddText(coreGame.SlaveMeet + " the beautiful bounty hunter again. She has some free time and invites you and #slave for a drink in a nearby tavern.\r\r");
				else AddText(coreGame.SlaveMeet + " the beautiful bounty hunter again. She has some free time and invites #slave and #assistant for a drink in a nearby tavern.\r\r");
				if (meet == 1) AddText("She introduces herself as Irina, and they");
				else AddText("They ");
				AddText("have a lengthy talk about her work, she mainly talks about the hunt of dangerous 'things' and criminals, but it is obvious she hunts slaves at times. ");
				if (Supervise) AddText("You change");
				else AddText("#assistant changes");
				AddText(" the topic of the conversation and they have a pleasant talk.\r\rIrina is cheerful and friendly and seems to like #slave. ");
				if (!IsAccessible()) {
					SetAccessible();
					BlankLine();
					PersonSpeak(Id, "I very much enjoy my chats with #slave, would it be possibly to arrange some meetings, so that #slaveheshe could <b>visit</b> me sometime? I could teach #slavehimher a lot and would enjoy it too. I understand slave's in training can also be <b>loaned</b> and I would be happy to have this happen. I would even pay a little for the privilege!", true);
					BlankLine();
				}
				AddText("They part friendly and #slave feels happy and rested.");
				SetBitFlag(1);
				break;
			case 3:
			case 6:
				PointsPerson(0, 0, 2, 0, 0);
				ShowThem(1, 0, 2);
				Backgrounds.ShowOverlayBlack();
				sd.Points(0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
				if (coreGame.Supervise)  AddText("You see the beautiful bounty hunter Irina running along the street and point her out to #slave. " + coreGame.SlaveHeSheUC + NonPlural(" wave") + " and Irina waves back but continues running very gracefully.\r\r" + SlaveVerb("admire") + " the elegance and precision of her motions and resolves to improve #slavehisher physical training.");
				else AddText("#assistant gestures and #slave sees the beautiful bounty hunter Irina running along the street. She waves and Irina waves back but continues running very gracefully.\r\r#slave admires the elegance and precision of her motions and resolves to improve #slavehisher physical training.");
				break;
			case 4:
				PointsPerson(0, 0, 20, 0, 0);
				NoRepeatEvent(meet);
				ShowThem(1.1, 0, 3);
				sd.Points(0, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText(coreGame.SlaveMeet + " the beautiful bounty hunter Irina but she seems very sad. They go to a private place and Irina explains that she has lost someone very dear to her and starts crying.\r\r#slave comforts her until she regains her composure. They talk for a time, a little about Irina's beloved, who may of even been related to her but whom she loved completely, and a little about life in general.\r\rWhen they part Irina sincerely thanks #slave.");
				SetBitFlag(0);
				break;
			case 7:
				ShowThem(1, 2, 1);
				Backgrounds.ShowDocks();
				sd.Points(0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, -2, 1, 0, 0);
				AddText(coreGame.SlaveMeet + " the beautiful bounty hunter Irina again. They briefly kiss and talk for a little while about nothing much but still pleasant chitchat.\r\r");
				if (coreGame.Supervise && CheckBitFlag(33)) {
					PointsPerson(0, 1, 0, 0, 0);
					AddText("Irina looks at you a little nervously and quickly leaves.");
				}
				break;
		}
		coreGame.modulesList.AfterMeetPerson(Id, Number(meet));
		coreGame.SlaveGirl.AfterMeetBountyHunter(coreGame.WalkPlace, Number(meet));

		return true;
	}
	
	
	// Visiting
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitBountyHunter() == true) return true;		
		SetVisited();

		if (PersonFlag < 5) {
			var inc:Number = Math.floor(sd.VarTemperament / 10);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 5);
			sd.Points(0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, inc, 0, 0, 0, 0);
		} else sd.Points(0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
		PointsPerson(0, 0, 6, 1, 2);
		
		if (CheckBitFlag(32)) {
			if (CheckBitFlag(33)) {
				AddText("Irina looks nervously at you and quietly thanks you for your gift of #slave and chats pleasantly about some aspects of her work and just about her life in general. All the time she holds #slave's hands and looks at #slavehimher intently. Irina is very clearly in love.\r\rAfter some time you tell Irina that her 'service' is required...")
				DoEvent(8303);
				return false;
			} else {
				AddText("Irina again thanks you for your gift of #slave and chats pleasantly about some aspects of her work and just about her life in general. All the time she holds #slave's hands and looks at #slavehimher intently. Irina is very clearly in love.");
				coreGame.SlaveGirl.VisitChatWithPerson(Id);
				coreGame.People.HearGossip(Id);
			}
		} else {
			// normal visit
			Language.XMLGeneral("Visits/VisitBountyHunter/NormalVisit");
			coreGame.modulesList.VisitChatWithPerson(Id);
			coreGame.People.HearGossip(Id);
		}
		
		var ruins:Place = GetPlace("RuinedTemple");
		if (ruins.CheckBitFlag(32) && (!ruins.CheckBitFlag(43))) {
			BlankLine();
			Language.XMLGeneral("Visits/VisitBountyHunter/AskMine"); 
			ruins.SetBitFlag(43);
		}
		
		if (LoveSlave > 65 && InLoveWith == "") {
			AddText("\r\rAs you prepare to leave, Irina grabs #slave by the shoulders,\r\r");
			PersonSpeak(Id, coreGame.SlaveName + " I love you! You have been such a good friend, especially during my loss that I have come to love you!", true);
			BlankLine();
			if (sd.LoveAccepted != 0) {
				InLove(coreGame.SlaveName, false);
				AddText("#slave" + NonPlural(" look") + " at you and back at Irina and sadly say that #slaveheshe has already give #slavehisher love to another. Irina looks at you and blushes, small tears forming in her eyes,\r\r");
				PersonSpeak(Id, "I still love you #slave but I understand. Please do not let this change things, please I still want to be friends!", true);
			} else {
				AddText("#slave" + NonPlural(" blush") + " and " + NonPlural(" look") + " at you and back at Irina and looks unsure, and you gently interrupt reminding Irina that " + coreGame.SlaveIs + " " + Plural("a slave") + " owned by another.\r\rIrina suggests buying #slave and you mention a likely price and she looks surprised. She says that there is no way she could afford that, she is well paid but her profession is also expensive needing many weapons, travel costs and other items. You could possibly give #slave to her, but it would be costly and hurt your reputation, and also it is dishonourable,\r\r");
				AskHerQuestions(8300, 8301, 8302, 0, "It is dishonourable to give #slave", "Give #slave freely", "Give #slave on condition", "What will you do?");
				return false;
			}
		}		
		return true;
	}

	
	// Lending
	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendBountyHunter() == true) return true;
		
		if (coreGame.SlaveGirl.ShowActLend(Id) == false) coreGame.UseGeneric = true;
		// obsolete versions
		coreGame.SlaveGirl.ShowActLendHer();
		coreGame.SlaveGirl.ShowSexActLendHer();
		
		coreGame.ShowActImage();
		
		coreGame.ResetNotFucked();
		if (coreGame.LesbianTraining) sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) sd.Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else sd.Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);
		PointsPerson(0, 0, 5, 0, 2);
		
		if (coreGame.AppendActText) {
			if (coreGame.SlaveFemale) coreGame.AlterSexuality(-2);
			Language.XMLGeneral("Visits/LendBountyHunter/NormalLend");
		}
		return true;
	}

	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
		// Refuse to give slave to Irina
		case 8300:
			InLove(coreGame.SlaveName, false);
			coreGame.SlaveGirl.ShowLoveConfession();
			SetText("You are contracted to train #slave for #slavehisher owner and it would be dishonourable to give or sell #slavehimher to another. It would also be very costly, forfeiting your payment for this training and also hurt your reputation.\r\rYou explain this to Irina, who starts crying, but says she understands contracts and honour. Again she professes her love to #slave begging you to still let #slavehimher visit, and then quickly leaves in tears.\r\r" + coreGame.SlaveName + NonPlural(" look") + " at you, tears in #slavehisher eyes, but blushing slightly. You wonder if #slaveheshe may of not quite understood your reasons, or thought you had other reasons.");
			sd.Points(0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 4, 0);
			return true;
			
		// Give slave to Irina
		case 8301:
			PointsPerson(0, 15, 0, 0, 0);
			if (sd.Loyalty > 0) {
				sd.Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 0, 0);
				InLove(coreGame.SlaveName, true);
				if (coreGame.SlaveFemale) coreGame.Generic.ShowEndingLesbianSlave();
				coreGame.Owner.ChangeOwner(Id);
				DifficultyLendMod = -100;
				SMData.BitFlagSM.SetBitFlag(21);
				AddText("You decide to <b>give</b> #slave to Irina, they seem to be in love and it would be a great pity to separate them.\r\rThis will cost you financially and in reputation, but you think it is best. You explain to Irina that you will finish #slave's training and then you will give #slave to her. You also tell her you will make arrangements with #slave's current owner but they are likely to be very angry.\r\r" + coreGame.SlaveName + NonPlural(" look") + " a bit uncertain but this is lost as Irina embraces #slavehimher kissing #slavehimher passionately.\r\rYou decide to leave them alone for a while, and leave the room. Sometime later you return and ask #slave if this is what #slaveheshe wants? #slave still look a little uncertain but tell you that it is!\r\r");
				PersonSpeak(Id, "Thank you! I promise that you can use my services as a bounty hunter for free from now on!", true);
				SetBitFlag(32);
			} else {
				sd.Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, -2, -4, 0);
				coreGame.SlaveGirl.ShowRefusedAction(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				SetText("You start to talk about giving #slave to Irina, and #slave interrupts, refusing completely, pledging her loyalty to you and you alone!\r\rIrina looks unhappy, tears start flowing and she apologises, asking #slave to still visit her sometimes, and then leaves crying.");
			}
			return true;
			
		// Conditionally Give slave to Irina
		case 8302:
			if (sd.Loyalty > 0) {
				PointsPerson(0, 10, 0, 0, 0);
				sd.Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 0, 0);
				InLove(coreGame.SlaveName, true);
				ShowThem(1, 0, 5);
				coreGame.Owner.ChangeOwner(Id);
				SMData.BitFlagSM.SetBitFlag(21);
				AddText("You decide to <b>give</b> #slave to Irina, they seem to be in love and you believe you can turn this to your advantage.\r\rThis will cost you financially and in reputation, but so what, it is only money. You explain to Irina that you will finish #slave's training and then you will give #slave to her. You also tell her you will make arrangements with #slave's current owner but they are likely to be very angry.\r\r" + coreGame.SlaveName + NonPlural(" look") + " a bit uncertain but this is lost as Irina embraces #slavehimher kissing #slavehimher passionately.\r\rYou decide to leave them alone for a while, and leave the room. Sometime later you return and tell Irina that you want her services in future for free,\r\r");
				PersonSpeak(Id, "Certainly, I promise that you can use my services as a bounty hunter for free from now on!", true);
				AddText("\r\rYou smile and tell her that those are not the only services you want and step forward and kiss her. She is surprised and you easily embrace her, removing her clothes and lying her on the table. You can see Irina is troubled, looking at "  + coreGame.SlaveName + " but you can see she come to a decision and she nods her head and ");
				if (SMData.Gender == 2) {
					AddText("you kneel over her face and tell her to lick! Irina slowly licks your pussy and then gasps as ");
					if (coreGame.HasCock) {
						AddText(coreGame.SlaveName1 + " thrusts #slavehisher cock into Irina's pussy. You tell Irina to continue and she licks you faster, bouncing a little as she is fucked. You orgasm quickly and turn to see " + coreGame.SlaveName1 + " straining as #slaveheshe cums into Irina's pussy and you look and see Irina orgasming as well.");
						if (sd.SlaveGender > 3) AddText("\r\r" + coreGame.SlaveName2 + " quickly turns Irina onto her stomache and thrusts " + coreGame.SlaveHisHerSingle + " cock into Irina's ass. You sit in front of Irina and raise her head to your pussy and tell her to lick");
					} else {
						AddText("#slave" + NonPlural(" lick") + " Irina's pussy. You tell Irina to continue and she licks you faster, moving a little as she is licked. You orgasm quickly and turn to see Irina orgasming as well.");
					}
				} else {
					AddText("you remove your clothes and place your erect cock to Irina's mouth and she reluctantly opens and licks the head of your cock. ");
					if (coreGame.HasCock) {
						AddText(coreGame.SlaveName1 + " removes #slavehisher clothes too and licks Irina's pussy and then stands and thrusts #slavehisher cock into Irina's pussy. ");
						if (sd.SlaveGender > 3) AddText(coreGame.SlaveName2 + " moves Irina a bit and shoves #slavehisher cock into Irina's ass. ");
						AddText("Irina a little awkwardly sucks your cock but you are quite aroused and quickly cum into her mouth.\r\r");
						if (sd.SlaveGender > 3) AddText("As you recover you see #slave both ramming their cocks into Irina and then they both cry out, cumming at once into her pussy and ass.");
						else AddText("As you recover you see #slave thrusting #slavehisher cock quickly into Irina's pussy and then cries out and #slaveheshe cums powerfully into Irina's womb! Iriana gasps and orgasms moments later.");
					} else {
						AddText(coreGame.SlaveName1 + " kneels and licks Irina's pussy as she licks your cock. Irina a little awkwardly sucks your cock but you are quite aroused and quickly cum into her mouth.\r\rAs you recover you see " + coreGame.SlaveName1 + " expertly licking Irina who starts orgasming, with your cum still on her lips.");
					}
					AddText("\r\rYou lean down and kiss Irina on her forehead and promise to 'employ' her 'services' often. Irina looks unhappy, but still flushed from her orgasm.");
				}
				SetBitFlag(32);
				SetBitFlag(33);
			} else {
				sd.Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, -2, -4, 0);
				coreGame.SlaveGirl.ShowRefusedAction(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				SetText("You start to talk about giving #slave to Irina, and #slave interrupts, refusing completely, pledging #slavehisher loyalty to you and you alone!\r\rIrina looks unhappy, tears start flowing and she apologises, asking #slave to still visit her sometimes, and then leaves crying.");
			}
			return true;
			
		// after
		case 8303:
			AfterBountyHunter();
			return true;
				
		}
		return false;
	}
	
	public function AfterBountyHunter()
	{
		Backgrounds.ShowBedRoom();
		ShowThem(1, 0, 5);
		SMData.SMPoints(0, 0, 0, 0, 0, -3, 0, 0, 0);
		var submission:Number = Math.floor(LoveSM / 10);
		SetText("You lead Irina and #slave and hire a room in the tavern and you sit down on a chair in the room ");
		switch(submission) {
			case 1:
				if (coreGame.SlaveName == InLoveWith) AddText("Irina looks nervous, her eyes darting between you and #slave. You speak calmly insisting that this is a matter of serving, not a matter of cheating on her lover, after all " + coreGame.SlaveIs + " here. Irina calms a little but is still nervous.");
				else AddText("Irina looks nervous, her eyes darting between you and #slave. You speak calmly insisting that this is a matter of serving, not a matter of cheating on her lover. Irina calms a little but is still nervous.");
				break;
			case 2:
				AddText("Irina looks nervous, glancing at #slave.");
				break;
			case 3:
				AddText("Irina looks unhappy but resigned. You talk to her about how she show not look on this as chore but as pleasant interlude. She does not look convinced.");
				break;
			case 4:
				AddText("Irina looks resigned to what is to come.");
				break;
			case 5:
				AddText("Irina does not look unhappy, even smiling briefly. You smile at her asking what she would like to do. She looks at you but does not reply.");
				break;
			case 6:
				AddText("Irina smiles briefly and awaits your desire.");
				break;
			case 7:
				AddText("Irina looks happy, and ready to do what you want, but she does not speak.");
				break;
			case 8:
				AddText("Irina looks happily at you, quietly waiting for you.");
				break;
			case 9:
			case 10:
				AddText(".\r\r");
				PersonSpeak(Id, coreGame.Master + " what do you desire today?", true);
		}
		switch(slrandom(3)) {
			case 1:
				AddText("\r\rYou tell Irina to orally satisfy you and you remove your lower clothing. She leans in and ");
				if (submission < 5) AddText("reluctantly ");
				if (SMData.Gender == 2) AddText("licks your pussy, it's lips and then your clit. She is fairly skilled and licks and sucks your clit harder until you cry out and orgasm.");
				else AddText("licks the head of your cock, a little awkwardly. She the licks the shaft of your cock and then takes much of your cock into her mouth. She is inexperienced but not unskilled. She licks and sucks your cock until you feel the impending orgasm. You hold her head and cum spurting your jets of cum directly into her mouth.");
				AddText("\r\rYou sit back and tell her to now pleasure #slave...");
				break;
			case 2:
				AddText("\r\rYou tell Irina that you will now fuck her and you remove your clothing. She lies on the bed ");
				if (submission < 5) AddText("reluctantly ");
				if (SMData.Gender == 2) AddText(" while you put on your strap-on. First you tell #slave to lick Irina to arouse her for you. " + coreGame.SlaveName + NonPlural(" lower") + " #slavehimherself and " + NonPlural("lick") + " Irina's pussy and as you watch you slowly rub your breasts and move the strap-on to masturbate yourself.\r\rYou tell #slave to stop and step to the side, You lie on top of Irina and kiss her slowly penetrating her with your strap-on. She moans as you start fucking her and you kiss her more. You fuck faster, the strap-on rubbing against your clit as you fuck Irina. You try to time your thrusts and just as you feel ready and Irina is you fuck faster. Irina cries out in orgasm and moments later you orgasm too.\r\rWhen you recover you pull out of Irina and ");
				else AddText(". First you tell #slave to lick Irina to arouse her for you. " + coreGame.SlaveName + NonPlural(" lower") + " #slavehimherself and " + NonPlural("lick") + " Irina's pussy and as you watch you slowly stroke your cock.\r\rYou tell #slave to stop and step to the side, You lie on top of Irina and kiss her slowly penetrating her with your cock. She moans as you start fucking her and you kiss her more. You fuck faster, your cock feeling wonderful in Irina. You try to time your thrusts and just as you feel ready and Irina is you fuck faster. Irina cries out in orgasm and moments later you cum, pouring your cum into her womb.\r\rWhen you recover you pull out of Irina, your cum dribbling from her pussy, and "); 
				AddText("tell #slave that it is #slavehisher turn now");
				if (SMData.Gender == 2 && !coreGame.HasCock) AddText("and hand over the strap-on");
				else if (!coreGame.HasCock) AddText("and hand over a strap-on");
				AddText("...");
				break;
			case 3:
				AddText("\r\rYou tell Irina that you will now tie her up. She looks uncomfortable as you strip her naked and bind her immobile in a frog-tie. You make sure to tease her and arouse her as much as you can and by the time you are done Irina is flushed and aroused. You tell her that you will now fuck her ");
				if (SMData.Gender == 2) AddText(" while you put on your strap-on. First you tell #slave to lick Irina to arouse her for you. " + coreGame.SlaveName + NonPlural(" lower") + " #slavehimherself and " + NonPlural("lick") + " Irina's pussy and as your watch you slowly rub your breasts and move the strap-on to masturbate yourself.\r\rYou tell #slave to stop and step to the side, You lie on top of Irina and kiss her slowly, lowering your hips, pushing the strap-on into her ass. She groans as you start fucking her and you kiss her more. You tell #slave to masturbate Irina's pussy and clit as you fuck her ass. You fuck faster, the strap-on rubbing against your clit as you fuck Irina. You try to time your thrusts and just as you feel ready and Irina is you fuck faster. Irina cries out in orgasm and moments later you orgasm too.\r\rWhen you recover you pull out of Irina and ");
				else AddText(". First you tell #slave to lick Irina to arouse her for you. " + coreGame.SlaveName + NonPlural(" lower") + " #slavehimherself and " + NonPlural("lick") + " Irina's pussy and as you watch you slowly stroke your cock.\r\rYou tell #slave to stop and step to the side, You lie on top of Irina and kiss her slowly, lowering your hips, pushing your cock into her ass. She groans as you start fucking her and you kiss her more. You tell #slave to masturbate Irina's pussy and clit as you fuck her ass. You fuck faster, your cock feeling wonderful in Irina. You try to time your thrusts and just as you feel ready and Irina is you fuck faster. Irina cries out in orgasm and moments later you cum, pouring your cum into her bowels.\r\rWhen you recover you pull out of Irina, your cum dribbling from her ass, and "); 
				AddText("tell #slave that it is #slavehisher turn now");
				if (SMData.Gender == 2 && !coreGame.HasCock) AddText("and hand over the strap-on");
				else if (!coreGame.HasCock) AddText("and hand over a strap-on");
				AddText("...");
				break;
		}
		PointsPerson(0, 10, 0, 0, 0);
	}
	
	public function EndingFinish(total:Number) : Boolean 
	{ 
		if (coreGame.Owner.GetOwner() != Id || coreGame.NumFin >= 1000) return false;
		
		// Gift to Irina
		AddText("You visit Irina at a room in the tavern you usually meet in. When you arrive you see Irina and #slave embracing. They look up at you and Irina speaks,\r\r");
		PersonSpeak(12, "Thanks you for allowing our love to blossom. I deeply and truly love #slave!", true);
		BlankLine();
		SlaveSpeak(coreGame.SlavePronoun + " love you too!", true);
		AddText("\r\rYou are happy to see them content");
		if (CheckBitFlag(33)) {
			AddText(", but speak to Irina about your agreement. Irina smiles a little and says,\r\r");
			PersonSpeak(12, "That is fine, I would suck any cock, lick any pussy and do anything to have #slave!", true);
			AddText("\r\rWith that she kneels in front of you, ready to service you however you want.");
		}
		coreGame.NumFin = 1000;
	
		return true; 
	}

	public function Initialise()
	{ 
		super.Initialise();
		
		AddNumberedEvents(6);
		NoRepeatEvent(4);
	}

}