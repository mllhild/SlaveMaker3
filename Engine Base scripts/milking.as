import Scripts.Classes.*;

// Milking

function MilkPreEvent() : Boolean
{
	if (MilkInfluence == -2) {
		if (SlaveGender > 3) Diary.AddEntry("#slave realise #slaveheshe were being used as cow-girls.");
		else Diary.AddEntry("#slave realises #slaveheshe was being used as a cow-girl.");
		MilkInfluence = -1;
		Backgrounds.ShowBedRoom();
		FirstTimeTodayBreak = false;
		SetText("You visit #slave in #slavehisher room and " + SlaveHeSheVerb("talk") + " about some dreams #slaveheshe had last night about being milked and fucked, and you see #slavehisher breasts visibly swell and " + SlaveHeSheIs + " very aroused. #Slaveheshe suddenly " + NonPlural("realise") + " this actually happened! #Slavehisher memories clear and " + SlaveHeSheVerb(" remember") + " everything that happened in the barn.\r\r#assistant says #assistantheshe recognises the drug used and prepares a concoction that #assistantheshe says will protect #slave in future. " + SlaveVerb("take") + " it and #slavehisher breasts noticeably decrease in size.\r\r" + SlaveVerb("swear") + " to avoid the barn from now on.");
		if (SlaveGirl.ShowMilkEnd() != true) SlaveGirl.ShowBreak();
		FirstTimeTodayBreak = true;
		SetBustSize(vitalsBust + 1);
		if (AskQuestions._visible == false) {
			AddText("\r\rYou are angry and decide to confront the farmer. You leave #slave recovering in the care of #assistant and go to the farm in question and find the farmer, walking out of the barn. From inside the barn you can hear muffled moans of passion.\r\rYou talk about his crime of abusing #slave and start to threaten him. He laughs and explains how this farm is owned by a certain noble and the authorities will not do anything. He looks at you smiling.");
			AskHerQuestions(4082, 4083, 0, 0, "Hit him and storm off in anger", "Promise to go to #personlord", "", "", "What do you do");
		}
		Points(-2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 3, 0, 0, 0, 1, 0);
		return true;
	} else if (MilkInfluence == -3) {
		Farm.ShowMovie("WalkCowgirl", 1, 0, 9);
		ShowMovie(OnTopOverlay, 1, 0);
		StartFadeImage(50, OnTopOverlay);
		SetText("You groggily wake-up from your sleep. You are gagged, tied, and stripped naked. You hear some noises and a low conversation. Your breasts feel very large and full and something is sucking insistently at your nipples...");
		if (SMData.Gender == 1) {
			HideAllPeople();
			MilkInfluence = -4;
			if (DickgirlOn)	AskHerQuestions(4084, 4085, 0, 0, "Breasts?", "Am I a woman?", "", "", "What????");
			else {
				AddText("\r\rBreasts???");
				DoEvent(4084);
			}
		} else {
			ShowPerson(36, 0, 0);
			MilkInfluence = -1;
			AddText("\r\rYou hear a voice\r\r");
			PersonSpeak("Farmer?", "..was a threat to us here. We have had to move the cows to the second farm, they are mostly settled in. She is now in a stall, we will make sure she is tended to well, in her new, permanent home.", true);
			AddText("\r\rA voice answers,\r\r");
			PersonSpeak("?", "I will negotiate with the owner and at court...", true);
			AddText("\r\rYou feel an oily hand rub over your pussy and then a very large dildo slowly forced in, deeper and deeper, until it is uncomfortably deep and you feel it strapped in place. An intense vibration starts and you immediately orgasm.\r\rFingers start working oil into your ass and you hear a voice\r\r");
			PersonSpeak("Farmer?", "Hold the plug for now, I want her ass first...", true);
			if (BadEndsOn) NumEvent = 9800;
			else NumEvent = 4086;
			DoEvent();
		}
		return true;
	} else if (MilkInfluence > 0 && 1 == 1 && !BitFlag1.CheckBitFlag(7)) {
		if (SlaveGender > 3) SetText("In the morning #slave's dresses side down and their breasts seem very large and milk is running from them.\r\r#assistant seems very concerned and talks about certain drugs that enhance breast size and make them lactate. They are mildly addictive and dull the mind. As long as they are not taken for a week or two the effect will fade.\r\rShe asks #slave if they are using these drugs and briefly they seem confused and then denies taking them.");
		else SetText("In the morning #slave's dress sides down and her breasts seem very large and milk is running from them.\r\r#assistant seems very concerned and talks about certain drugs that enhance breast size and make them lactate. They are mildly addictive and dull the mind. As long as they are not taken for a week or two the effect will fade.\r\rShe asks #slave if she is using these drugs and briefly she seems confused and then denies taking them.");
		SlaveGirl.ShowMilkAccident();
		BitFlag1.SetBitFlag(7);
		if (AskQuestions._visible == false) NextEvent._visible = true;
		return true;
	}
	return false;
}

function DoMilkYes()
{
	switch (NumEvent) {
			// 4080 - takes Milk Drug
		case 4080:
			Diary.AddEntry(SlaveHas + " an odd encounter at the farm and forgot what happened. #Slavehisher breasts are now larger.");
			Farm.mcBase.WalkCowgirl._visible = false;
			Points(2, 0, 0, -2, 0, 3, 0, 0, 0, 0, 3, -3, 3, -1, 3, 0, 3, 0, 0, 0);
			DoEvent(4080);
			if (SlaveGirl.ShowMilkFall() != true) SlaveGirl.ShowTired();
			BitFlag1.SetBitFlag(6);
			if (SlaveGender > 3) {
				AddText("#slave swallow the sweets and immediately feel intense pressure in their chest. ");
				if (Naked) AddText("They look down");
				else AddText("They pull off their clothes");
				AddText(" and their breasts swell, visibly growing, and growing.\r\rTheir breasts finally stop and as they turn toward each other, their breasts pendulously swing and they topple over backward onto the ground. #slave feel a fog descend over their minds and also feel considerably aroused, their breasts feel very sensitive. " + SlaveName);
				if (SlaveGender == 5) AddText(" grow very wet from the unaccustomed sensations, to the extent juices leak from their pussies.");
				else if (SlaveGender == 4) AddText("'s cocks stiffen from the unaccustomed sensations, growing intensely erect.");
				else AddText(" grow very wet and their cocks stiffen from the unaccustomed sensations, to the extent juices leak from their pussies and their cocks become intensely erect.");
			} else {
				AddText("#slave swallows the sweet and immediately feels an intense pressure in #slavehisher chest. ");
				if (Naked) AddText("#Slaveheshe looks down");
				else AddText("#Slaveheshe pulls off #slavehisher clothes");
				AddText(" and #slavehisher breasts swell, visibly growing, and growing.\r\rThey finally stop and as #slaveheshe turns they pendulously swing and #slaveheshe topples over backward onto the ground. #Slaveheshe feels a fog descend on #slavehisher mind and also a considerable arousal, #slavehisher breasts feel very sensitive. " + SlaveHeSheUC);
				if (SlaveGender == 2) AddText(" grows very wet from the unaccustomed sensations, to the extent juices leak from her pussy.");
				else if (SlaveGender == 1) AddText(" cock stiffens from the unaccustomed sensations, growing intensely erect.");
				else  AddText(" grows very wet and her cock stiffens from the unaccustomed sensations, to the extent juices leak from her pussy and her cock grows intensely erect.");
			}
			AddText("\r\r#Slaveheshe feels arms lift #slavehimher..");
			XMLData.XMLEvent("TookMilkingDrug");
			break;
	}
}

function DoMilkNo()
{
	switch (NumEvent) {
		// 4080 - refuse Milk Drug
		case 4080:
			Points(0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			AddText(SlaveIs + " suspicious of the man and " + NonPlural("refuse") + ". He looks disappointed and " + SlaveHeShe + NonPlural(" leave") + " looking for #super. A few minutes later " + SlaveVerb("hear") + " " + SupervisorName + " calling, and ");
			if (Supervise) AddText("you meet and finish your walk.");
			else AddText("they meet and finish their walk.");
			break;
	}
}

function DoMilkEvent()
{	
	switch (NumEvent) {
		
	// 4080 - First Milking 
	case 4080:
		UseGeneric = false;
		HideImages();
		HideSlaveActions();
		Backgrounds.ShowFarm(5);
		MilkInfluence = 9;
		if (Day) DoEvent(4081);
		else DoEvent(4081.1);
		AddText(NameCase(SlaveHeSheIs) + " dimly aware of being partly carried into a large building and hearing cries and moans\r\r" + SlaveHeSheIs + " positioned straddling an odd cushioned bench, leaning forward. #Slavehisher huge breasts are lifted onto a platform in front of #slavehimher, intense feelings coming from them, #slavehisher nipples incredibly erect.\r\r#Slavehisher hands are tied above #slavehisher head and #slavehisher feet are strapped into place. " + SlaveHeSheUC + NonPlural(" feel") + " fingers rubbing " + SlaveHisHer);
		if (SlaveGender > 3) {
			AddText(" anuses working some oil expertly in and then large cock-like things are worked into their asses until deeply in place. They feel uncomfortably full.\r\r");
			if (SlaveFemale) AddText("Fingers rub their pussies finding them leaking juices and then larger phalluses are plunged in. They are larger than any human cock and #slave moan, and then cry as the plalluses start to vibrate with increasing strength. ");
			if (HasCock) AddText("#Slaveheshe feel #slavehisher cocks stiffen and then hands lightly stroking them. #Slaveheshe moan and then some kind of tube is slid over #slavehisher cocks. The tubes suck #slavehisher cocks with a rhymthic sucking and #slaveheshe groan and cum, #slavehisher cum spurting and spurting into the tubes.\r\r#Slaveheshe then feel suction cups applied to their nipples that start insistently sucking. Between that, the phalluses and the tubes they cum again, their cum sucked into the tubes.\r\rThey are dimly aware of time passing, cumming over and over into the tubes.");
			else AddText("Almost immediately #slave explode in simultaneous orgasms.\r\rThey then feel suction cups applied to their nipples that start insistently sucking. Between that and the phalluses they orgasm again.\r\rThey are dimly aware of time passing, having orgasm after orgasm.");
			AddText(" Occasionally the dildo in one of their asses is removed and someone's real cock replaces it, fucking her until they cum and then replacing the dildo. A cock is sometimes placed to one of their lips and she sucks it and drinks the cum. They are beyond caring lost in a daze of orgasm and the intense feelings in their breasts.\r\rThey are aware after a while that milk starts to flow from their breasts, and also start hearing low whispering, few words except clearly 'return'.\r\rAfter many fuckings their consciousness fades, and they awaken to ");
		} else {
			AddText(" anus working some oil expertly in and then a large cock-like thing is worked into #slavehisher ass until deeply in place. #Slaveheshe feels uncomfortably full.\r\r");
			if (SlaveFemale) AddText("Fingers rub her pussy, finding her leaking juices and then a larger phallus is plunged in. It is larger than any human cock and she moans, and then cries as it starts to vibrate with increasing strength. ");
			if (HasCock) AddText("#Slaveheshe feels #slavehisher cock stiffen and then a hand lightly strokes it. #Slaveheshe moans and then some kind of tube is slid over #slavehisher cock. The tube sucks #slavehisher cock with a rhymthic sucking and #slaveheshe groans and cums, #slavehisher cum spurting and spurting into the tube.\r\r#Slaveheshe then feels suction cups applied to her nipples that start insistently sucking. Between that, the phallus and the tube she cums again, her cum sucked into the tube.\r\rShe is dimly aware of time passing, cumming over and over into the tube.");
			else AddText("Almost immediately #slave explodes in orgasm.\r\rShe then feels suction cups applied to her nipples that start insistently sucking. Between that and the phallus she orgasms again.\r\rShe is dimly aware of time passing, having orgasm after orgasm.");
			AddText(" Occasionally the dildo in her ass is removed and someone's real cock replaces it, fucking her until they cum and then replacing the dildo. A cock is sometimes placed to her lips and she sucks it and drinks the cum. She is beyond caring lost in a daze of orgasm and the intense feelings in her breasts.\r\rShe is aware after a while that milk starts to flow from her breasts, and also starts hearing low whispering, few words except clearly 'return'.\r\rAfter many fuckings her consciousness fades, and she awakens to ");
		}
		if (Supervise) AddText("you shaking #slavehimher. " + NameCase(SlaveHeSheIs) + " lying in the woods near the farm, remembering nothing.");
		else AddText("#assistant shaking #slavehimher. " + NameCase(SlaveHeSheIs) + " lying in the woods near the farm, remembering nothing.");
		SlaveGirl.ShowMilking();
		if (!UseGeneric && UseImages) ShowActImage(10010);
		if (UseGeneric) Generic.ShowMilking();
		XMLData.XMLEvent("FirstMilking");
		TotalMilked = 1;
		ChangeCumslut(1);
		return;
		
	// 4081 - End of First Milking 
	case 4081:
	case 4081.1:
		StartNewDay(1);
		Backgrounds.ShowHousing();
		ShowDress();
		if (NumEvent == 4081) AddText(SlaveVerb("recover") + " from #slavehisher experience and a full day has passed.");
		else AddText(SlaveVerb("recover") + " from #slavehisher experience and the night has passed.");
		BlankLine();
		AddText("#slave's breasts have returned to normal, but may be a little larger. Sometimes when " + SlaveHeSheIs + " aroused they leak or even squirt a little milk.\r\r" + SlaveHeSheUC + NonPlural(" remember") + " little of the experience but sometimes in #slavehisher sleep #slavehisher breasts swell and milk stains #slavehisher sheets.");
		return;
		
	case 4082:
		DoEvent(250);
		SetText("You punch the farmer and leave the farm in anger.\r\rWhen you return home and explain " + SlaveVerb("thank") + " you for understanding. You see " + SlaveHeSheIs + " blushing.");
		Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 8, 0);
		return;

	case 4083:
		MilkInfluence = -3;
		HideImages();
		Backgrounds.ShowFarm();
		ShowPerson(36, 0, 0);
		SetText("The farmer looks worried, and promises to do something. He explains he needs to talk to a certain noble first. He tells you that he will contact you soon, in the next few days.\r\rHe looks very, very concerned and as you leave he begs you to not do anything until he contacts you.\r");
		AskHerQuestions(4088, 4087, 0, 0, "Agree to wait", "Forget it and go to #personlord", "", "", "What do you do");
		Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 8, 0);
		return;
		
	case 4084:
		NumEvent = 250;
		ChangeSlaveMakerGender(2);
		Diary.AddEntry("You have been changed to a woman after being abducted to the farm.");
		ShowPerson(36, 0, 0);
		NextEvent._visible = true;
		SetText("Breasts, you have breasts!! You try to look down and you can see you have a large pair of breasts.\r\rYou hear a voice\r\r");
		PersonSpeak("Farmer?", "..was a threat to us here. We have had to move the cows to the second farm, they are mostly settled in. The alchemical potion was quite expensive but 'she' is now in a stall, we will make sure she is tended to well, in her new, permanent home.", true);
		AddText("\r\rA voice answers,\r\r");
		PersonSpeak("?", "I will negotiate with the owner and at court...", true);
		AddText("\r\rYou feel an oily hand rub over your pussy, you have a pussy! and you know your cock is gone and you are a woman! As you think this you gasp as a very large dildo slowly forced into your new pussy, deeper and deeper, until it is uncomfortably deep and you feel it strapped in place. An intense vibration starts and you immediately orgasm, your first female orgasm. You are stunned by the intensity, the difference of the sensation.\r\rFingers start working oil into your ass and you hear a voice\r\r");
		PersonSpeak("Farmer?", "Hold the plug for now, I want her ass first...", true);
		if (BadEndsOn) NumEvent = 9800;
		else NumEvent = 4086;
		DoEvent();
		return;
		
	case 4085:
		NumEvent = 250;
		ChangeSlaveMakerGender(3);
		ShowPerson(36, 0, 0);
		NextEvent._visible = true;
		AddText("What are you a woman? Then you feel a hand cup your testicles, which feel larger than before. Your cock feels very erect. You look down and you see you have a large pair of breasts!!\r\rYou hear a voice\r\r");
		PersonSpeak("Farmer?", "..was a threat to us here. We have had to move the cows to the second farm, they are mostly settled in. The alchemical potion was quite expensive but it did not work correctly. 'She' is now a hermaphrodite and is now in a stall, we will make sure she is tended to well, in her new, permanent home. We can sell her 'other' milk to that alchemist.", true);
		AddText("\r\rA voice answers,\r\r");
		PersonSpeak("?", "I will negotiate with the owner and at court...", true);
		AddText("\r\rYou feel an oily hand rub over your pussy, you have a pussy! and you know you are a hermaphrodite! As you think this you gasp as a very large dildo slowly forced into your new pussy, deeper and deeper, until it is uncomfortably deep and you feel it strapped in place. An intense vibration starts and you immediately orgasm, your first female orgasm. You are stunned by the intensity, the difference of the sensation and then you cum again, this time your cock spewing cum.\r\rFingers start working oil into your ass and you hear a voice\r\r");
		PersonSpeak("Farmer?", "Hold the plug for now, I want her ass first...", true);
		if (BadEndsOn) NumEvent = 9800;
		else NumEvent = 4086;
		DoEvent();
		return;
		
	case 4086:
	case 4087:
		HidePeople();
		HideImages();
		Backgrounds.ShowPalace();
		ShowPerson(8, 1, 0);
		SMMoney(500);
		if (NumEvent == 4086) {
			UpdateDateAndItems(3);
			SetText("After a long time and many fuckings you pass out..\r\r");
			var say:String = "You wake-up in a forest clearing, #assistant standing over you and #assistantheshe explains that they finally found you! After nightfall, #assistantheshe was able to sneak in and rescue you, carrying you here. ";
			if (MilkInfluence == -4) say = say + ServantName + " looks embarrassed and comments about how #assistantheshe did not at first recognise you...";
			say = say + "\r\rYou are quite angry and storm to the #placepalace demanding to see #personlord. You are let in and he hears your story. He promises immediate retailation and orders the city guard dispatched to free the captive girls and disband the farm. ";
			if (MilkInfluence == -4) say = say + "#personlord is a bit amused at your change of body, and comments that it will not affect his opinion of you as a Slave Maker.";
			say = say + "\r\r#personlord gives you a reward for your service to the city, and suggests you return home to your training.";
			if (MilkInfluence == -4) say = say + "\r\rYou will need sometime to adjust to your new body, and what it means to being a Slave Maker...";
			ShowMovie(OnTopOverlay, 1, 0);
			StartFadeImage(50, OnTopOverlay, say);
		} else {
			SetText("You are quite angry and ignore his request and storm to the #placepalace demanding to see #personlord. You are let in and he hears your story. He promises immediate retailation and orders the city guard dispatched to free the captive girls and disband the farm.\r\r#personlord gives you a reward for your service to the city, and suggests you return home to your training.");
		}
		DoEvent(250);
		DoneEvent = 3;
		BitFlag1.SetBitFlag(26);
		MilkInfluence = -1;
		return;
		
	case 4088:
		DoEvent(250);
		SetText("You agree to wait a few days before going to #personlord and leave.\r\rWhen you return home and explain " + SlaveVerb("thank") + " you for understanding. You see " + SlaveHeSheIs + " blushing.");
		return;
	}	
}

function Milked()
{
	Diary.AddEntry(SlaveVerb("disappear") + " near the farm, returning tired, milk on #slavehisher breasts.");
	Backgrounds.ShowFarm(5);
	UseGeneric = false;
	if (TentacleHaunt > 0) {
		if (PregnancyGestation == 0) PregnancyGestation = 28 + Math.floor(Math.random()*5);
		TotalTentacle = TotalTentacle + 1;
		if (SlaveGender > 3) {
			SetText("#slave seem to hear voices and act oddly. They dart into the woods and lose " + SupervisorName + ". In a daze they make their way towards the barn, unaware of a rustling noise in the bushes. They take their places in stalls, the farm-hand attaches the suction cups to their breasts and inserts their dildos. Their breasts swell and their milking starts.\r\rLost in the pleasure from their breasts and from the slow pulsing in the dildos they are only dimly aware of the farm-hand crying out and collapsing. They feel the dildo in their pussy roughly pulled out. They are a little confused, accustomed to the one in their ass being removed. They moan as large cocks thrust into their pussies. They hears another girl cry out and looks over. #slave see the girl entwined in tentacular forms, and as they watch a tentacle pushes into the girl's moist pussy. The girl looks as surprised, but then looks almost reassured as a large tentacle slides into her mouth.\r\r#slave gasps as they feel the tentacles in them quiver, it's cum flooding into them. They cry out and shake with orgasm. The other girl lets out a muffled groan as she also orgasms, then coughs as cum sprays into her mouth.");
			AddText("\r\rOther tentacles sink into #slave's pussies as they watch a gout of cum erupt around the tentacle in the other girl's pussy.\r\rSometime later the things withdraw and #slave gets out of their stalls, leaves the barn and joins");
		} else {
			SetText("#slave seems to hear voices and acts oddly. She darts into the woods and loses " + SupervisorName + ". In a daze she makes her way towards the barn, unaware of a rustling noise in the bushes. She takes her place in a stall, the farm-hand attaches the suction cups to her breasts and inserts her dildos. Her breasts swell and her milking starts.\r\rLost in the pleasure from her breasts and from the slow pulsing in the dildos she is only dimly aware of the farm-hand crying out and collapsing. She feels the dildo in her pussy roughly pulled out. She is a little confused, accustomed to the one in her ass being removed. She moans as a large cock thrusts into her pussy. She hears another girl cry out and looks over. She sees the girl entwined in tentacular forms, and as she watches a tentacle pushes into the girl's moist pussy. The girl looks as surprised, but then looks almost reassured as a large tentacle slides into her mouth.\r\r#slave gasps as she feels the tentacle in her quiver, it's cum flooding into her. She cries out and shakes with her own orgasm. The other girl lets out a muffled groan as she also orgasms, then coughs as cum sprays into her mouth.");
			AddText("\r\rAnother tentacle sinks into #slave's pussy as she watches a gout of cum erupt around the tentacle in the other girl's pussy.\r\rSometime later the things withdraw and #slave gets out of her stall, leaves the barn and joins");
		}
		UseGeneric = true;
	} else {
		if (SlaveGender > 3) {
			AddText("#slave seem to hear voices and act oddly. They dart into the woods and lose " + SupervisorName + ". They make their way to the barn and take their places in stalls. A farm-hand attaches the suction cups to their breasts and inserts their dildos ");
			if (IsDickgirl()) AddText("and larger suction devices are placed over their cocks. Their breasts swell, milk spurting from their nipples and their milking starts. The device on their cocks sucks gently, enough to arouse but not enough to make them cum.\r\rThe farmer arrives to supervise, feeds them the sweet-like drug, whispering in their ears. As the drug takes effect #slave explode in orgasm, cum pouring from their cocks into the devices. " + SlaveName1 + " barely feels the farmer's cock enter her ass as her orgasm goes on and on. When she recovers the farmer is fucking her ass and a farm-hand has his cock in " + SlaveName2 + "'s ass.\r\rSometime later #slave leave and joins");
			else AddText(". Their breasts swell, milk spurting from their nipples and their milking starts.\r\rThe farmer arrives to supervise, feeding them the sweet-like drug and drops his pants and unceremoniously ass fucks " + SlaveName1 + ". The farm-hand simultaneously places his cock into " + SlaveName2 + "'s ass.\r\rSometime later #slave leave and joins");
		} else {
			AddText("#slave seems to hear voices and acts oddly. She darts into the woods and loses " + SupervisorName + ". She makes her way to the barn and takes her place in a stall. A farm-hand attaches the suction cups to her breasts and inserts her dildos ");
			if (IsDickgirl()) AddText("and a larger suction device is placed over her cock. Her breasts swell, milk spurting from her nipples and her milking starts. The device on her cock sucks gently, enough to arouse but not enough to make her cum.\r\rThe farmer arrives to supervise, feeds her a sweet-like drug, whispering in her ear. As the drug takes effect she explodes in orgasm, cum pouring from her cock into the device. She barely feels the farmer's cock enter her ass as her orgasm goes on and on. When she recovers the farmer is fucking her ass and a farm-hand has his cock in her mouth.\r\rSometime later she leaves and joins an angry #assistant.");
			else AddText(". Her breasts swell, milk spurting from her nipples and her milking starts.\r\rThe farmer arrives to supervise, feeds her a sweet-like drug and drops his pants and unceremoniously ass fucks her. The farm-hand simultaneously places his cock to her lips.\r\rSometime later she leaves and joins");
		}
	} 
	if (Supervise) AddText(" you, angry at losing #slavehimher.");
	else AddText(" an angry #assistant.");
	SlaveGirl.ShowMilking();
	if (!UseGeneric && UseImages) ShowActImage(10010);
	if (UseGeneric) Generic.ShowMilking();
	TotalMilked++;
	MilkInfluence = MilkInfluence + 9;
	if (MilkInfluence > 16) MilkInfluence = 16;
	Points(1, 0, 0, -1, 0, 0, 0, 0, 0, 1, 1, -1, 1, 0, -2, 0, 2, 0, 0, 0);
	ChangeCumslut(1);
	XMLData.XMLEvent("Milked");
}