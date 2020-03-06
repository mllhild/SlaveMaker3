//
// Furries
//
// Linked to Furries.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class FurriesModule extends SlaveModule
{
	public var FurryBondage:Number;
	private var FurryBondagePlace:Number;
	private var FurryBondageDate:Number;
	private var FurryBondageLastDate:Number;
	private var FurryBondageGuard:Number;
	private var FurryBondageDay:Number;
	
	public function FurriesModule(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
		StartSlaveMaker();
	}
	
	public function CanLoadSave() : Boolean { return false; }

	public function GetVariable(num:Object) : Object 
	{ 
		var str:String = (num + "").toLowerCase();
		if (str == "furrybondage") return FurryBondage;
		if (str == "furrybondageguard") return FurryBondageGuard;
		if (str == "furrybondageplace") return FurryBondagePlace;
		if (str == "furrybondageday") return FurryBondageDay;
		if (str == "furrybondagelastdate") return FurryBondageLastDate;
		return undefined;
	}

	public function StartSlaveMaker()
	{
		FurryBondage = 0;
		FurryBondagePlace = 0;
		FurryBondageDay = 0;
		FurryBondageLastDate = 0;
		FurryBondageGuard = 0;
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// 8500 - Furry Forest chase 1
			case 8500:
				if (coreGame.Supervise) AddText("You and #slave are walking in a remote part of the forest and you hear a noise in a nearby tree. You look up but do not see anything, " + coreGame.SlaveName1 + " calls out and points. You see sitting in a tree, panting for breath, a woman but a strange woman. She is quite naked but covered in fur, has a tail and animal like features. You think she is one of the furry women you have heard of! She looks at you and smiles, but then starts and you both hear the noise of a barking dog in the distance.\r\rShe leaps from the tree landing near to you, and you see she is flushed and looks happy. You can clearly see glistening wetness from her quite human looking pussy. She looks at you, lightly touching her fur covered breasts, and then pinching her nipples. She softly growls and you hear the dogs again and she runs off into the forest, running with an inhuman grace and speed, quickly vanishing from sight, just leaving an odd, musky smell..."); 
				else AddText("#assistant and #slave are walking in a remote part of the forest and #slave hear a noise in a nearby tree. #assistant looks up but does not see anything, " + coreGame.SlaveName1 + " calls out and points. Sitting in a tree, panting for breath, is a woman but a strange woman. She is quite naked but covered in fur, has a tail and animal like features. #assistant explains that she is one the furry women #assistantheshe has heard of! She looks at #slave and smiles, but then starts at the noise of a barking dog in the distance.\r\rShe leaps from the tree landing near to #slave, and #slaveheshe can see she is flushed and looks happy. " + coreGame.SlaveHeSheUC + " can clearly see glistening wetness from her quite human looking pussy. She looks at #slave, lightly pinching her own nipples and making a soft almost growling noise. She glances and " + coreGame.SlaveVerb("hear") + " the dogs again and the woman runs off into the forest, running with an inhuman grace and speed, quickly vanishing from sight, just leaving an odd, musky smell...");
				ShowMovie("EventForestMeeting", 1, 0, 1);
				Points(0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0);
				DoEvent(8501);
				return true;
				
			// 8501 - Furry Forest chase 2
			case 8501:
				SetText("A few minutes later a small band of men, leading a couple of dogs runs past, in hot pursuit of the furry woman, totally ignoring " + coreGame.SupervisorName + " and #slave.\r\r" + coreGame.NameCase(coreGame.SupervisorName) + " and #slave continue walking and maybe 10 minutes or so later hear a commotion not far away. #slave asks to investigate and but ignores the answer and runs to the noise.\r\r");
				if (coreGame.Supervise) AddText("You follow and enter");
				else AddText("#assistant follows and enters");
				AddText(" a small clearing. The furry woman has been captured and a bar fitted to her legs to stop her running. She looks happy and is presenting her ass and shaking it. She speaks in an odd, growling but seductive way,\r\r");
				PersonSpeak("Animal Girl", "You have caught me, now fuck me, all of you fuck me!", true);
				AddText("\r\rThe leader of the men speaks,\r\r");
				PersonSpeak("Leader", "We can't! Our master has made it clear that you are his and not for us to enjoy...", true);
				BlankLine();
				PersonSpeak("Animal Girl", "Silly, I'll not tell and I really, really need it. A good chase is the biggest turn-on. Fuck me please!", true);
				if (coreGame.Supervise) {
					AddText("\r\rThe leader looks at you about to say something, and you interrupt, explaining you are just passing and do not even know who they are or the woman, and how you could not tell anyone what happens here.\r\r");
					if (SMData.Gender != 2) AddText("Of course, you continue, if you could, ummm, help the woman, then you would never speak. The leader nods his head and starts to remove his clothing.\r\rYou walk behind the furry woman who looks at you eagerly and again you smell the musky odour, stronger than before. Your cock is very erect and you remove your clothes and thrust into the woman. The feeling is at once different and very familiar. The woman growls, you think in passion, as you fuck her. The leader moves in front of her and she licks his cock. You fuck her faster, the sensation very erotic and your climax building quickly. The woman cries out, almost howling and you feel her pussy strongly contracting around your cock as she orgasms. Your cock erupts as you climax, cum spurting and spurting into her womb. As your climax finishes you feel her pussy still strongly contracting as her orgasm continues. Finally she relaxes and resumes licking the leaders cock. You step away and one of the other men takes your place...");
					else AddText("Of course, you continue as you start removing your clothes, if you could, ummm, assist, then you would never speak. The leader nods his head and starts to remove his clothing.\r\rYou walk in front of the woman and she leans in and kisses your pussy. The leader walks behind her and simply thrusts his cock into her. The woman licks your pussy, her tongue feels strange, but very good. You feel your orgasm rising quickly and the woman pulls free and howls, clearly orgasming and you see the leader groaning, cumming too. The woman's orgasm is long and strong, but she resumes licking you with enthusiasm and quickly you also orgasm strongly. When you recover you see another man has replaced the leader and is fucking the woman.");
					AddText("\r\rYou leave the men and the animal woman to their pleasure. For a while you often hear howls of passion in the distance...\r\r");
				} else {
					AddText("\r\rThe leader looks at #assistant about to say something, and #slave interrupt, explaining they are just passing and do not even know who they are or the woman, and how they could not tell anyone what happens here.\r\r");
					if (coreGame.HasCock) {
						AddText("Of course, " + coreGame.SlaveHeSheSingle + " continues, if " + coreGame.SlaveHeSheSingle + " could, ummm, help the woman, then they would never speak. The leader nods his head and starts to remove his clothing. " + coreGame.SlaveName1 + " walks behind the furry woman who looks at " + coreGame.SlaveName1 + " eagerly. " + coreGame.NameCase(coreGame.SlaveName1) + "'s cock is very erect and " + coreGame.SlaveHeSheSingle + " removes " + coreGame.SlaveHisHerSingle + " clothes and thrusts into the woman. The feeling is at once different and very familiar. The woman growls, probably in passion, as " + coreGame.SlaveHeSheSingle + " fucks her. The leader moves in front of her and she licks his cock. " + coreGame.SlaveName1 + " fucks her faster, the sensation very erotic, " + coreGame.SlaveHisHerSingle + " climax building quickly. The woman cries out, almost howling and " + coreGame.SlaveName1 + " feels her pussy strongly contracting around " + coreGame.SlaveHisHerSingle + " cock as she orgasms. " + coreGame.NameCase(coreGame.SlaveHisHerSingle) + " cock erupts as " + coreGame.SlaveHeSheSingle + " climaxes, cum spurting and spurting into her womb. As " + coreGame.SlaveHisHerSingle + " climax finishes " + coreGame.SlaveName1 + " feels her pussy still strongly contracting as her orgasm continues. Finally she relaxes and resumes licking the leaders cock. " + coreGame.SlaveName1 + " steps away and ");
						if (coreGame.SlaveGender > 3) AddText(coreGame.SlaveName2 + " takes " + coreGame.SlaveHisHerSingle + " place...");
						else AddText("one of the other men takes your place...");
					} else {
						AddText("Of course, " + coreGame.SlaveHeSheSingle + " continues as " + coreGame.SlaveHeSheSingle + " start removing " + coreGame.SlaveHisHerSingle + " clothes, if you could, ummm, assist, then you would never speak. The leader nods his head and starts to remove his clothing. " + coreGame.SlaveName1 + " walks in front of the woman and she leans in and kisses " + coreGame.SlaveHisHerSingle + " pussy. The leader walks behind her and simply thrusts his cock into her. The woman licks " + coreGame.SlaveName1 + "'s pussy, her tongue feeling strange, but very good. " + coreGame.SlaveName1 + " feels " + coreGame.SlaveHisHerSingle + " orgasm rising quickly and the woman pulls free and howls, clearly orgasming as the leader groans, cumming too. The woman's orgasm is long and strong, but she resumes licking " + coreGame.SlaveName1 + " with enthusiasm and quickly " + coreGame.SlaveHeSheSingle + " also orgasms strongly. When " + coreGame.SlaveHeSheSingle + " recovers ");
						if (coreGame.SlaveGender > 3) AddText(coreGame.SlaveName2 + " takes " + coreGame.SlaveHisHerSingle + " place...");
						else AddText(coreGame.SlaveHeSheSingle + " sees another man has replaced the leader and is fucking the woman.");
					}
					AddText("\r\rLater #assistant and #slave leave the men and the animal woman to their pleasure. For a while you often hear howls of passion in the distance...\r\r");
	
				}
				ShowMovie("EventForestMeeting", 1, 1, 2);
				ShowPlanningNext();
				return true;
				
			// 8502 - Furry cat Palace meeting 1
			case 8502:
				ShowSupervisor();
				Points(0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
				ShowMovie("EventMisc", 1, 1, 2);
				Backgrounds.ShowOverlay(0x463d36);
				SetText("As " + coreGame.SlaveIs + " walking through an area of the Palace " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " a happy looking slave sitting surrounded by a group of people. At first " + coreGame.SlaveVerb("think") + " she is a cat-slave, but then can see the girl has distinctly animal features. Maybe a True Catgirl? " + coreGame.SlaveHeSheUC + " asks one of the people nearby,\r\r");
				PersonSpeak("Noble", "No, she has entirely the wrong features for one of those rare people. Also her tail is quite wrong and other features. A slaver took her in the mountains, so she is one of the 'furry' girls who are being found. Her owner is quite proudly displaying her here, but take care, she is quite wild, incapable or unwilling to speak and she will claw and bite if given the opportunity.\r\rI am told though that her...pussy...is quite human, and that she really, really likes...", true);
				AddText("\r\rThe man looks a bit embarrassed, and notices finally that " + coreGame.SlaveIs + " a slave and orders #slavehimher to leave and " + coreGame.SupervisorName);
				if (coreGame.Supervise) AddText(" decide to leave things there.\r\r");
				else AddText(" decides to leave things there.\r\r");
				return true;
				
			// 8503 - Furry cat Palace meeting 2
			case 8503:
				ShowSupervisor();
				Points(0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
				ShowMovie("EventMisc", 1, 1, 3);
				Backgrounds.ShowOverlay(0x463d36);
				SetText(coreGame.SlaveSee + " the furry cat-like girl sitting in a corner of a room and tries to talk to her. The girl looks very happy, but only makes soft purring noises. " + coreGame.SlaveVerb("notice") + " the collar and leash and " + coreGame.NonPlural("suspect") + " it may be limiting her speech and moves to loosen it. " + coreGame.SlaveHeSheVerb("hear") + " a stern voice,\r\r");
				PersonSpeak("Noble", "Do not touch her! She is rather vicious and will bite you with her very sharp teeth.", true);
				AddText("\r\r" + coreGame.SlaveSee + " the girl had lent forward mouth open, but #slave thought she was anxious to have her collar removed. The furry girl sits back looking disappointed. The man continues\r\r");
				PersonSpeak("Noble", "The only time she restrains her vicious streak is when,...umm..., well she is being fucked. As long as she has a cock in her or someone is licking her she is very accommodating, and eagerly takes cocks into her mouth or licks pussies...Umm she has no respect for the gods and will do absolutely anything sexual. Nothing else though.\r\rIf you will excuse me...", true);
				AddText("\r\rThe man starts removing his clothes and the furry girl looks very, very happy, purring loudly...");
				return true;
				
			// 8504 - Furry cat Palace meeting 3
			case 8504:
				ShowSupervisor();
				Points(0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
				ShowMovie("EventMisc", 1, 1, 4);
				Backgrounds.ShowOverlay(0x463d36);
				SetText(coreGame.SlaveSee + " the furry cat-like girl again sitting in a corner of a room and tries to talk to her again, not really believing she cannot speak. The girl looks very happy, and moves, presenting her pussy, ready to be fucked or licked. " + coreGame.SlaveHeSheUCVerb("hear") + " a stern voice,\r\r");
				PersonSpeak("Noble", "She is not for you! She is for nobles, not for slaves to enjoy, leave now!", true);
				AddText("\r\rThe man waits until #slave leaves and then walks over and loudly spanks the furry girl.");
				return true;
				
			// Furry Bondage
			case 8506:
				DoFurryBondage();
				return true;
				
			// Furry Bondage Talk - first time
			case 8507:
				SetText(coreGame.SlaveVerb("talk") + " to Lia about life as a slave and about trying to accept and enjoy it. It is difficult as Lia is gagged and cannot reply or give clear responses, just growls and other noises. Sola the guard watches them closely.\r\r");
				if (slaveData.VarJoy < 50) AddText(coreGame.SlaveIs + " not very convincing as " + coreGame.SlaveHeShe + coreGame.NonPlural("does") + " not really enjoy life as " + coreGame.Plural("a slave"));
				else AddText(coreGame.SlaveIs + " quite convincing, talking about the pleasure of serving a Master or Mistress");
				AddText("\r\rAfter a bit Sola thanks #slave for comforting Lia. ");
				FurryBondage = 40 - (slaveData.VarConversationRounded + slaveData.VarJoyRounded) / 10;
				if (FurryBondage < -100) FurryBondage = -100;
				if (FurryBondage == 0) FurryBondage = 1;
				AddText("\r\rA voice startles the guard and #slave and they turn. The guard immediately kneels and says\r\r");
				PersonSpeak(46, "My Lord!", true);
				AddText("\r\r" + coreGame.SlaveSee + " a young nobleman, no older than 25 who looks pleasant but who is staring at the furry girl Lia. He steps over and hugs her awkwardly and politely orders the guard, Sola, that they will return home now. He completely ignores " +coreGame.SlaveName + " and " + coreGame.SupervisorName + ".\r\rAs they leave " + coreGame.SlaveVerb("decide") + " to try to help Lia.");
				Points(0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				return true;
				
			// Furry Bondage Free
			case 8508:
				coreGame.HideDresses();
				FurryBondage = 40;
				ShowPerson(46, 1, 7, 1);
				SetText(coreGame.SlaveVerb("wait") + " for a moment when the guard-woman is looking away and sneaks over and starts to free Lia's bonds. Immediately " + coreGame.SlaveHeSheIs + " pulled away, and " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " the guard looking at #slavehimher intensely,\r\r");
				PersonSpeak(46, "No! I cannot let you free her. My oath of duty to My Lord is absolute, I cannot let her free or allow anyone else to free her.\r\rNo matter what I feel should be done...\r\rIf you truly want to help her then talk to her and try to help her accept her life.\r\rMaybe sometime something can be done otherwise but I fear for her. Every day she struggles more, today 3 times more than when she first arrived.", true);
				AddText("\r\rA voice startles the guard and #slave and they turn. The guard immediately kneels and says\r\r");
				PersonSpeak(46, "My Lord!", true);
				AddText("\r\r" + coreGame.SlaveSee + " a young nobleman, no older than 25 who looks pleasant but who is staring at the furry girl Lia. He steps over and hugs her awkwardly and politely orders the guard, Sola, that they will return home now. He completely ignores " +coreGame.SlaveName + " and " + coreGame.SupervisorName + ".\r\rAs they leave " + coreGame.SlaveVerb("decide") + " to try to help Lia.");
				Points(0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				return true;
				
			// Furry Bondage - Stop
			case 8509:
				if (FurryBondage == 0) FurryBondage = 40;
				coreGame.SlaveGirl.ShowRefusedAction(0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				if (coreGame.Supervise) {
					if (SMData.SMDominance > 70) {
						SetText("You tell #slave to stop, Lia is a slave, and she is for the use and pleasure of her Master. She will get used to her situation and come to accept and hopefully enjoy it.\r\rYou stress it is not for #slave to get involved as " + coreGame.SlaveIs + " a slave too. " + coreGame.SlaveVerb("look") + " unhappily at the furry slave and you lead #slavehimher away.");
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 2, 0, 0, -1, -2, 0);
					} else if (SMData.SMDominance > 40) {
						SetText("You explain to #slave that we should not interfere with the slave Lia's training. Her Master will get over his fascination with her. She will get used to her situation and come to accept and hopefully enjoy it.\r\rYou gently lead away, but " + coreGame.SlaveVerb("look") + " unhappily at the furry slave as you leave.");
						Points(0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 1, 2, 0, 0, 0, 0, 0);
					} else if (SMData.SMDominance > 20) {
						SetText("You ask #slave to stop as you do not want to offend the slave's Master and the strong looking guard. " + coreGame.SlaveVerb("start") + " to object but you quiet #slavehimher and quickly lead #slavehimher away.");
						Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, -1, 0);
					} else {
						SetText("You carefully explain to #slave while looking at the guard that Lia is a slave and she should serve her Master however he wishes. She will come to enjoy her life, especially as she seems to love sex so much.\r\rYou apologise to the guard and guide #slave away.");
						Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, -1, 2, 0, 0, 0, -1, 0);
					}
				} else {
					SetText(coreGame.ServantName + " tells #slave to stop, Lia is a slave, and she is for the use and pleasure of her Master. She will get used to her situation and come to accept and hopefully enjoy it.\r\r#assistant stresses it is not for #slave to get involved as " + coreGame.SlaveIs + " a slave too. " + coreGame.SlaveVerb("look") + " unhappily at the furry slave and #assistant leads #slavehimher away.");
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 2, 0, 0, -1, 0, 0);
				}
				return true;
				
			// Furry Bondage Talk - Accept - later times
			case 8510:
				FurryBondageGuard = -1 * Math.abs(FurryBondageGuard);
				SetText(coreGame.SlaveVerb("talk") + " to Lia about life as a slave and about trying to accept and enjoy it. It is difficult as Lia is gagged and cannot reply or give clear responses, just growls and other noises. Sola the guard watches them closely.\r\r");
				if (slaveData.VarJoyRounded < 50) AddText(coreGame.SlaveIs + " not very convincing as " + coreGame.SlaveHeShe + coreGame.NonPlural("does") + " not really enjoy life as " + coreGame.Plural("a slave"));
				else AddText(coreGame.SlaveIs + " quite convincing, talking about the pleasure of serving a Master or Mistress");
				AddText("\r\rAfter a bit Sola thanks #slave for comforting Lia. ");
				FurryBondage -= (slaveData.VarConversationRounded + slaveData.VarJoyRounded) / 10;
				if (FurryBondage < 100) FurryBondage = -100;
				if (FurryBondage == 0) FurryBondage = 1;
				Points(0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				return true;
				
			// Furry Bondage Talk - Promise - Later
			case 8511:
				FurryBondageGuard = Math.abs(FurryBondageGuard);
				SetText(coreGame.SlaveVerb("talk") + " to Lia about life as a slave and about trying to accept and enjoy it. Every so often #slaveheshe mentions how slaves are sometimes freed and even rescued. #slave often mentions this, trying to keep up Lia's hopes and also as #slaveheshe really wants to free Lia.\r\rSola the guard watches them closely, and clearly notices these references,\r\r");
				switch(FurryBondageGuard) {
					case 1:
						PersonSpeak(46, "Do not think to try and free Lia in some sneaky or illegal way. She is kept very securely and I would consider it a personal insult if you try to free her.\r\rThe only way she will go free is if My Lord, or his wife frees her. Or if she becomes a trustworthy and happy slave.", true);
						break;
					case 2:
						PersonSpeak(46, "As I mentioned another time, only My Lord can free Lia but he never will, he is obsessed with her.\r\rSuch a pity, he has a beautiful wife and they had a lovely, caring relationship. Not loving, theirs was an arranged marriage, between her ancient noble family and his wealthy but common family. He assumed nobility through marriage to her and her family gained his wealth. Still they were quite fond of each other, and were close friends. That is until Lia...", true);
						break;
					case 3:
						PersonSpeak(46, "I was thinking recently, My Lord's wife, the #persononsenowner, has no ill feelings toward Lia, but she would be quite happy to see Lia gone. I wonder if she could arrange something? At times I think she actually loves My Lord, but this is not something she talks to me about.\r\rI could not ask her, it would be contrary to my oath to My Lord, but someone could ask.", true);
						break;
					case 4:
						PersonSpeak(46, "Have you ever met the #persononsenowner, a beautiful woman who is fond of her husband, happy to do anything he wants, most of the time. She is very fond of dancing and has a few odd tastes that I cannot mention. She seems a bit shy and does not talk a lot unless her husband is present.", true);
						break;
					default:
						PersonSpeak(46, "Have you ever met the #persononsenowner, a beautiful but shy woman.", true);
						break;
				}
				AddText("\r\rSola refuses to speak any more and leaves #slave to talk more with Lia, but still watches closely.\r\r");
				Points(0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				FurryBondage -= (slaveData.VarConversationRounded + slaveData.VarJoyRounded) / 10;
				if (FurryBondage <= 0) FurryBondage = 1;
				FurryBondageGuard++;
				return true;
				
			case 8512:
			case 8512.1:
			case 8512.2:
				if (FurryBondageGuard > 2 && FurryBondage < 1000) {
					// Meet #persononsenowner at the party
					if (coreGame.NumEvent == 8512.1) {
						AddText("\r\rAfter the dance #persononsenowner takes #slave to a private room to chat for a bit.");
						DoEvent(8512.2);
						return true;
					}
					if (coreGame.NumEvent == 8512.2) {
						Backgrounds.ShowBedRoom(12);
						ShowPerson(41, 1, 1, 3);
						coreGame.DifficultyBondage -= 2;
						SetText("#persononsenowner invites #slave to spend the rest of the evening here, and they spend the time chatting, and eating snacks.\r\rAfter a while #persononsenowner comments that her clothing can be uncomfortable and removes most of it, revealing she is bound in a rope webbing, complete with a moist crotch rope. She explain matter-of-factly that she is completely dedicated to her beloved husband's desires and will, and this is a symbol of her love for him. Also that she very much likes it, especially the crotch rope.");
					}
					AddText("\r\r#persononsenowner blushes a little, and looks directly at #slave and says,\r\r");
					PersonSpeak(41, "I understand from my husband's guard that you have met his slave Lia. He dearly loves that girl, but he thinks of nothing and <b>no-one</b> else.\r\rDespite our arranged marriage, I love my husband and want him to be happy, even if it is with that slave. I have also heard that she hates slavery and wants to be free. I could free her if I wanted, but it would make my husband unhappy.", true);
					AddText("\r\r" + coreGame.SlaveVerb("want") + " Lia to be free, and feels #persononsenowner's husband needs to free Lia, his obsession is unhealthy.\r\r");
					AskHerQuestions(8513, 8514, 8515, 0, "Free Lia to help husband", "Free Lia the rival","Insist husband be equal in attention", "", "What will #slave suggest?\r");	
					return;
					
				} else coreGame.modulesList.Parties.HighClassParty(8078);
				return true;
			
			case 8513:
				ShowPerson(41, 0, 1, 1);
				ShowMovie("EventMisc", 1, 2, 6);
				SetText(coreGame.SlaveVerb("talk") + " to #persononsenowner about how her husband's obsession with Lia is ruining his life and stopping him from doing anything other than be with and fuck Lia. Also about how it would really help him if Lia were to be freed so he can realise what was happening. He will be sad for a time, but #persononsenowner can help him to get over it and be happy again.\r\rThe #persononsenowner considers this and orders a servant to fetch the slave Lia. She mentions to #slave that her husband will be asleep now after having 'spent' a lot of time with Lia.\r\rSome time later the servant returns with Lia, and #persononsenowner orders her bindings removed. Lia look surprised and #persononsenowner explains that she is free, and that it is due to #slave's help. Lia looks extremely happy and hugs #slave and then licks #slavehisher cheek. She then leaps up and runs, leaping though a window with inhuman speed and grace, vanishing into the night.\r\r#persononsenowner looks a bit surprised and stands, simply saying that she is leaving to speak to her husband.");
				FurryBondage = 3000;
				Diary.AddEntry(coreGame.SlaveVerb("free") + " the furry slave Lia.");
				Points(0, 2, 1, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0);
				coreGame.modulesList.Parties.HighClassParty(8078);
				return true;
		
			case 8514:
				HidePerson(41);
				SetText(coreGame.SlaveVerb("talk") + " to #persononsenowner about how freeing Lia will allow her to gain her husband's attention fully. #persononsenowner blushes and says she could not do that, it would be against her husband's will and it does not help him in any way. She stands and excuses herself, and leaves, and does not return.");
				Points(0, 0, 0, 1, -1, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
				coreGame.Parties.HighClassParty(8078);
				return true;
				
			case 8515:
				ShowMovie("EventMisc", 1, 2, 5);
				SetText(coreGame.SlaveVerb("talk") + " to #persononsenowner about how her husband is wrong to be obsessed with Lia and how he owes her attention." + coreGame.SlaveVerb("suggest") + " that #persononsenowner could insist that her husband involve her whenever he is with Lia, and that she can help to lessen his obsession and at least still get his attention.\r\r#persononsenowner blushes, and orders a servant to fetch the slave Lia. She mentions to #slave that her husband will be asleep now after having 'spent' a lot of time with Lia.\r\rSome time later the servant returns with Lia, and #persononsenowner tells Lia that she will not be controlling her and moderating her husband's behaviour. About how he will have to love them both, and how #persononsenowner will make sure he does. She reassures Lia that she will be better treated now and that she will be given more freedom.\r\r#persononsenowner blushes brightly and walks to a cabinet and takes out a strap-on and puts it on.");
				if (!coreGame.HasCock) AddText(" She hands " + coreGame.SlaveName1 + " one as well and tells her to put it on.");
				AddText(" #persononsenowner tells Lia that she will be firmly in control of her now, and that she feels a demonstration is in order. #persononsenowner looks at " + coreGame.SlaveName1 + " and quietly says 'her umm behind is yours'.\r\rLia's gag and dildos are removed by the servant as #persononsenowner lies down. The servant moves a confused looking Lia and sits her down, impaling her pussy on #persononsenowner's large strap-on. Lia growls a little and starts to speak when ");
				if (coreGame.HasCock) AddText("#slave pushes #slavehisher cock into Lia's ass.");
				else AddText("#slave pushes her strap-on into Lia's ass.");
				AddText(" Lia growls in passion as she moves on #persononsenowner's strap-on and as " + coreGame.SlaveName1 + " fucks her ass. #persononsenowner moves her hips a bit awkwardly, fucking Lia at the same time.\r\rAfter a little while Lia growls and orgasms, one of her intense, shuddering orgasms");
				if (coreGame.HasCock) AddText(" and it feels incredible as her ass seems to massage and milk " + coreGame.SlaveName1 + "'s cock, who cums immediately deeply into Lia's ass.");
				else AddText(" and #slave orgasms moments later.");
				AddText(" #persononsenowner orgasms a little while later, with what appears some difficulty.\r\r#persononsenowner redresses and leads Lia away, saying they will now visit her husband. She looks at #slave as they leave and simply says 'Thank you'");
				FurryBondage = 4000;
				Diary.AddEntry(coreGame.SlaveVerb("arrange") + " the furry slave Lia and #persononsenowner relationship.");
				Points(0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 2, 0, 2, 0, 2, 1, 2, 1, 0, 0);
				coreGame.Parties.HighClassParty(8078);
				return true;
		}
		return false;
	}
	
	public function TakeAWalkAsAssistant(place:Number) {
		if (FurryBondage == 0 && place == 3 && coreGame.FurriesOn && IsEventPicked() == false && SMData.sSlaveTrainer > 1 && SMData.GirlsTrained > 1 && slaveData.VarConversation >= 50) {
			coreGame.NumEvent = 12;
		} else if (FurryBondage != 0 && FurryBondage < 1000) {
			if (place == FurryBondagePlace && FurryBondageLastDate != coreGame.GameDate && FurryBondageDay == (coreGame.Elapsed % 4)) {
				coreGame.NumEvent = place == 3 ? 12 : 13;
			}
		}
	}
	
	public function DoFurryBondageStart()
	{
		FurryBondagePlace = PercentChance(20) ? 5 : 3;
		Diary.AddEntry(coreGame.SlaveMeet + " the furry slave Lia.");
		FurryBondageDay = coreGame.Elapsed % 4;
		SetText(coreGame.SlaveSee + " a slave, one of the rare furry girls, being closely guarded. The girl is very securely bound, gagged and with a large plug in her pussy. She looks very aroused, her tail is slowly wagging, but she has tears in her eyes and looks distressed.\r\r" + coreGame.SlaveVerb("walk") + " toward the girl but the guard stops #slavehimher immediately,\r\r");
		PersonSpeak(46, "Please stop, I have been ordered to carefully guard this slave, no-one is permitted to touch her and she must remain gagged.\rMy Lord is nearby on business and I am guarding her until he returns.", true);
		AddText("\r\rA worried look passes over the guard's face as she talks of her Lord. " + coreGame.SlaveVerb("ask") + " concerned and after a little the guard blushes a little,\r\r");
		PersonSpeak(46, "My Lord is very fond of this slave, visiting here every few days for more potions. I cannot say more now. Maybe if we meet again, you may see us here again in a few days, in the morning, or sometime at the palace when My Lord <i>must</i> attend.", true);
		AddText("\r\rShe blushes again, and excuses herself to return to her duties.");
		AddText("\r\r" + coreGame.SlaveSee + " the furry slave is struggling against her bindings and chewing on her gag. #slave can see the slave's hips wriggling and the dildo in her pussy is moving as she does.\r\rThe slave screams, muffled by her gag, huge spasms racking her body as spurts of juices erupt around the dildo. The guard steps over and holds the slave so she does not collapse as her spasms continue on and on. After a while the slave slumps, making whimpering noises through her gag, a small puddle of her juices on the ground.\r\rThe guard is flushed and comments,\r");
		PersonSpeak(46, "My Lord once mentioned how this girl is very sensitive and how very strong and wet her orgasms are. She would make a perfect sex slave, if she did not want so desperately to be free. I talk to her often in her cell, she hates being a slave and has often begged to be free.\r\rI named her Lia, she had no name when she arrived and did not understand for a while the idea of a name!", true);
		AddText("\r\r" + coreGame.SlaveVerb("want") + " to do something for the furry slave Lia, either to help her accept life as a slave or try to free her. " + coreGame.SlaveVerb("speak") + " to " + coreGame.SupervisorName + " and explains that #slaveheshe wants to help.\r");
		ResetQuestions();
		AddQuestion(8507, "Talk to Lia about accepting life as a slave");
		AddQuestion(8508, "Try to free her");
		AddQuestion(8509, "Nothing, " + coreGame.SupervisorName + " will stop " + coreGame.SlaveHimHer);
		ShowQuestions("What will #slave do?", true);
	
	}
	
	public function DoFurryBondage()
	{
		coreGame.ShowDressSmall();
		ShowMovie("EventMisc", 1, 2, 5);
		ShowPerson(46, 1, 3, 1);
		FurryBondageLastDate = coreGame.GameDate;
	
		if (FurryBondage == 0) return DoFurryBondageStart();
	
		if (FurryBondage > -100) FurryBondage += (coreGame.GameDate - FurryBondageLastDate) * 4;
	
		var fstage:Number = Math.floor(FurryBondage / 20);
		if (fstage >= 5) {
			FurryBondage = 2000;
			SetText(coreGame.SlaveSee + " the guard Sola walking through the town center and asks after the slave Lia. Sola looks a bit sad and says,\r\r");
			PersonSpeak(46, "I wish I could of done something for her, but my duty and honour prevented it. Now nothing can be done.", true);
			AddText("\r\rSaying nothing more the guard leaves. " + coreGame.SlaveIs + " very sad, wondering what happened and dreading knowing.");
			Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0);
			return;
		}
		
		if (FurryBondagePlace == 3) SetText("Once again " + coreGame.SlaveSee + " the furry slave Lia being guarded by the guard Sola. They seem to be waiting again in front of a shop that sells potions.");
		else SetText("Once again " + coreGame.SlaveSee + " the furry slave Lia being guarded by the guard Sola. They are waiting in a small reception area, clearly their Lord is here attending a court function.");
		AddText("\r\r#slave " + coreGame.NonPlural("speak") + " to the guard Sola.\r\r"); 
		FurryBondagePlace = PercentChance(20) ? 5 : 3;
		
		switch(fstage) {	
			case 4:
				PersonSpeak(46, "Lia is doing badly, she snarls and growls, desperately struggling to be free, a 4 in my rating. She never talks only screaming and crying. It breaks my heart but I cannot free her.\r\rMy Lord is very concerned for her but will not even consider freeing her. It is breaking his heart but he cannot and will not free her.", true);
				break;
			case 3:
				PersonSpeak(46, "Lia is doing very poorly, she loathes her slavery, desperately struggling to be free, a 3 in my rating. She screams and begs me to be free when we are alone. It breaks my heart but I cannot free her.\r\rMy Lord is very concerned for her but will not even consider freeing her.", true);
				break;
			case 2:
				PersonSpeak(46, "Lia is doing poorly, she loathes her slavery and struggles against everything, a 2 in my rating. She begs me to be free when we are alone and often cries.\r\rMy Lord is quite concerned for her and buys her more and more potions for her health and to arouse her.", true);
				break;
			case 1:
				PersonSpeak(46, "Lia is not doing well, she hates her slavery and she struggles regularly, a 1 in my rating, sometimes just waiting for rescue.", true);
				break;
			case 0:
				PersonSpeak(46, "Lia is doing fine, she hates her slavery but she only struggles sometimes, a 0 in my rating, often just waiting hoping for rescue.", true);
				break;
			case -1:
				PersonSpeak(46, "Lia is doing alright, she dislikes her slavery and she only rarely struggles, a -1 in my rating. She rather likes being fucked by my Lord, her orgasms loud and strong.\r\rShe still asks to be free whenever we talk.", true);
				break;
			case -2:
				PersonSpeak(46, "Lia is doing well, she is indifferent to her slavery and she almost never struggles, a -2 in my rating. She is enthusiastic when my Lord fucks her, her orgasms loud and strong.\r\rShe still asks to be free whenever we talk, but she also talks about loving sex.", true);
				break;
			case -3:
				PersonSpeak(46, "Lia is doing quite well, she does not complain about her slavery, a -3 in my rating. She is enthusiastic when my Lord fucks her, her orgasms loud and strong.\r\rShe sometimes asks to be free when we talk, but she often talks about loving sex and sometimes fondly about My Lord.", true);
				break;
			case -4:
				PersonSpeak(46, "Lia is doing very well, she accepts slavery and never struggles, a -4 in my rating. She begs my Lord to fuck her, and will do anything sexually.\r\rShe rarely asks to be free when we talk, but she always talks about sex and my Lord.", true);
				break;
			case -5:
				FurryBondage = 1000;
				PersonSpeak(46, "Lia is doing great, she likes her slavery and seems quite trustworthy, a -5 in my rating. She is a complete slut, doing anything my Lord wishes sexually, and often asks to pleasure me.\r\rShe seldom asks to be free when we talk, it seems a token question. She appears to love being a sex slave and is very fond of my Lord.", true);
				break;
		}
		Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		AddText("\r\rSola sits next to Lia and starts moving the dildo in Lia's pussy, and says\r\r");
		PersonSpeak(46, "My Lord has told me that when you arrive I am to make it clear that Lia is a sex slave.", true);
		AddText("\r\rSola works the dildo with one hand, using the other to touch Lia's breasts and clit. She is clearly very skilled at this and Lia growls and moans in passion, becoming very aroused. Lia moves her hips fucking the dildo as Sola works it in her pussy.\r\rSola starts rubbing Lia's clit hard as she fucks the dido and with a muffled cry Lia orgasms. She shudders as intense spasms wrack her body, and sprays of juice splatter over Sola's hands. Sola quickly places a large cup below Lia's pussy and catches most of Lia's juices. Lia's orgasm is very, very intense, lasting on and on, for at least a minute.\r\rLia gasps and collapses as her orgasm fades, and Sola holds up the cup and then empties it into a bottle.");
		if (FurryBondageGuard == 0) {
			AddText(" She explains,\r\r");
			PersonSpeak(46, "My Lord loves the taste of Lia's juices, and drinks some of her juices. The rest he mixes with her drinks. Some days is seems she is only drinking her own juices, there is so much.\r\rMy Lord never told me what to do with any excess, her juices are strange and rather delicious...", true);
			FurryBondageGuard++;
		}
		AddText("\r");
		if (FurryBondage == 1000) {
			AddText("\rLia seems quite happy now as a slave and " + coreGame.SlaveIs + " happy #slaveheshe could help. The guard Sola smiles and thanks #slave,\r\r");
			PersonSpeak(46, "Thank you, Lia is now content, and my Lord recently said she will be given more freedom as he now trusts her. I think they will be happy together now. I doubt you will see us around in the city much anymore. I will not have to guard her and she will probably be with my Lord from now on.\r\rThanks you again.", true);
			Diary.AddEntry("The furry slave Lia has accepted her life as a slave.");
			Points(0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 5, 0, 0);
		} else AskHerQuestions(8510, 8511, 8509, 0, "Talk to Lia about accepting slavery", "Talk to Lia, subtly mentioning rescue", coreGame.NameCase(coreGame.SupervisorName) + " will stop " + coreGame.SlaveName, "", "What will #slave do?\r");																															
	}
	
	public function LoadGame(loaddata:Object)
	{
		FurryBondage = loaddata.FurryBondage;
		if (FurryBondage == undefined) {
			FurryBondage = 0;
			FurryBondagePlace = 0;
			FurryBondageDay = 0;
			FurryBondageLastDate = 0;
			FurryBondageGuard = 0;
		} else {
			FurryBondagePlace = loaddata.FurryBondagePlace;
			FurryBondageDay = loaddata.FurryBondageDay;
			FurryBondageLastDate = loaddata.FurryBondageLastDate;
			FurryBondageGuard = loaddata.FurryBondageGuard;
		}
	}
		
	public function SaveGame(savedata:Object)
	{
		savedata.FurryBondage = FurryBondage;
		savedata.FurryBondagePlace = FurryBondagePlace;
		savedata.FurryBondageDay = FurryBondageDay;
		savedata.FurryBondageLastDate = FurryBondageLastDate;
		savedata.FurryBondageGuard = FurryBondageGuard;
	}
	
	public function HideAsAssistant()
	{
		mcBase.EventForestMeeting._visible = false;
		mcBase.EventMisc._visible = false;
	}

}