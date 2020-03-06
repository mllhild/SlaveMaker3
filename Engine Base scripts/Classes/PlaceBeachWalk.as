// Beach
// Linked to Walk-Beach.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceBeachWalk extends PlaceBeach {
	
	private var qNum1:Number;
	private var nNum2:Number;

	public function PlaceBeachWalk(mc:MovieClip, cg:Object, cc:City)
	{
		super("BeachWalk", mc, cg, 9.1, cc);
		ModuleName = "Engine/Walk-Beach.swf";
		loading = undefined;
		
		qNum1 = GetFreeEvent();
		nNum2 = GetFreeEvent();
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		ResetEvents();
		ClearBitFlag(32);
		ClearBitFlag(33);
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "Day-Event1-1";// set default event

		this.AddEvent("Day-Event1-1");
		this.AddEvent("Day-Event2-2");
		this.AddEvent("Day-LadyOkyanu-3");
		this.AddEvent("Day-Event4-4");
		this.AddEvent("Day-Event5-5");
		this.AddEvent("Day-Event6-6");
		this.AddEvent("Day-LadyAzure-7");
		this.AddEvent("Day-Event8-8");
		this.AddEvent("Day-Event9-9");
		this.AddEvent("Day-Event10-10");
		this.AddEvent("Day-Event11-11");
		this.AddEvent("Day-Event12-12");
		this.AddEvent("Night-Event1-13");
		this.AddEvent("Night-Event2-14");
		this.AddEvent("Night-Event3-15");
	}
	// Walking in the SlaveMarket
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String) {
		PlaySound("Sounds/Beach.mp3");
		coreGame.WalkPlace = 9.1;
		var bNode:XMLNode = parentCity.FindPlaceNodeCByName("Beach");

		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4114);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		if ((!IsDayTime()) && coreGame.TotalWalkBeach == 0 && !coreGame.SwimInstructor.IsMet()) {
			SetLangText("BeachClosed", bNode);
			coreGame.ShowPlanningNext();
			return;
		}
		
		// Wing Quest, ignore standard events (xml included)
		if (slaveData.DemonFlags.CheckBitFlag(31) && slaveData.Naked && !slaveData.DemonFlags.CheckBitFlag(9)) {
			var s:String = strNodeName + "";
			strNodeName = "Beach";
			GetTraining("Succubus").Training(9.1);
			strNodeName = s;
			return;
		}
		
		if (slaveData.SwimsuitOK == 0 && coreGame.IsDressSwimsuitOwned() == -1) {
			Language.XMLData.XMLGeneral("BeachWalk/RefuseAccess",false,coreGame.walkNode);
			if (coreGame.NumEvent == 9999) {
				coreGame.ShowPlanningNext();
				return;
			}
		}
		var bpdress:Boolean = false;
		if (!coreGame.IsDressSwimsuit()) {
			var dress:Number = coreGame.IsDressSwimsuitOwned();
			if (dress != -1 || slaveData.SwimsuitOK != 0) {
				Language.XMLData.XMLGeneral("BeachWalk/MeetMarine",false,coreGame.walkNode);
				BlankLine();
				PersonSpeak(18, "I am sorry, you must be wearing swimsuits to visit the Beach, it is an unwritten but strict rule here.", true);
				if (dress == -1) {
					AddText("\r\r#slave changes into #slavehisher swimsuit.\r\r");
				} else {
					AddText("\r\r#slave changes into #slavehisher "+coreGame.GetDressName(dress)+".\r\r");
					coreGame.SwapDress(dress);
				}
			}
			Backgrounds.ShowBeach();
			bpdress = true;
		}
		// general counts of times walked here 
		slaveData.TotalWalkBeach++;
		coreGame.EventTotal = slaveData.TotalWalkBeach;

		if (!coreGame.SwimInstructor.IsMet()) {
			if (!bpdress) {
				Language.XMLData.XMLGeneral("BeachWalk/MeetMarine",false,coreGame.walkNode);
			}
			PersonSpeak(18,"Welcome to the beach! Let me give you a brief tour, please? I enjoy meeting people and showing them around. Before you ask my name is really a nickname and I rather like it.\r\rNow as you see the Lord has spent quite a lot to make this beach, importing exotic plants and having his workers sculpt the landscape. He often visits here in the afternoons after his duties, often in the company of a Lady. It is odd how he never remarried after his wife's death all those years ago, but they say he loved her dearly. You would not think he is quite so old, he looks young and handsome after all. Such a pity I am not some grand Lady.\r\rBy the way did you hear about his daughter, they say now it was four guardsmen found in her...\r\rAnyway, let's walk on...",true);
			coreGame.DoEvent(4310);
			return;
		} else if (coreGame.TotalWalkBeach == 1) {
			if (!bpdress) {
				Language.XMLData.XMLGeneral("BeachWalk/MeetMarine",false,coreGame.walkNode);
			}
			PersonSpeak(18,"Welcome to the beach! I know people from #slavemakername's, ummm, household, have been here before so I guess you already know about the beach. Please enjoy your self!",true);
			coreGame.BlankLine();
		}
		if (Supervise) SMData.SMPoints(0,0,0,0,0,1,0,0,0);

		AddText(Language.GetHtml("Description2", bNode));
		AskHerQuestions(4300, 4301, 4302, 4303, Language.GetHtml("Name",  parentCity.FindPlaceNodeCByName("BeachSwim")), Language.GetHtml("Name",  parentCity.FindPlaceNodeCByName("BeachWalk")), Language.GetHtml("Name",  parentCity.FindPlaceNodeCByName("BeachPrivate")), Language.GetHtml("Name",  parentCity.FindPlaceNodeCByName("BeachRocks")));
		coreGame.modulesList.BeachActivities();
	}
	
	public function WalkOnBeach() {
		coreGame.WalkPlace = 9.1;
		// Select the event and show it 
		super.DoWalkLoaded(this.mcBase,this.ModuleName);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude,sequential);

		if (!IsEventPicked()) return;
		
		var sd:Slave = SMData.GetSlaveDetails("Arak", true);
		if (sd != null) {
			if (sd.SlaveType != 0 && !sd.CanAssist && sd.SlaveType != -1 && sd.SlaveType != 1 && sd.SlaveType != 2 && sd.SlaveType != -4 && sd.SlaveType != -10 && sd.SlaveType != -3 && sd.SlaveType != 1 && sd.Available && sd.CustomFlag2 != -2) {
				if (slrandom(10) < 5) coreGame.NumEvent = 8;
				return;
			}
		}

		if (coreGame.NumEvent == 5 && coreGame.GameTimeMins > 720) coreGame.NumEvent = slrandom(3);
		else if (coreGame.NumEvent == 6 && coreGame.IsAssistant("Sora")) coreGame.NumEvent = slrandom(3);
		else if (coreGame.GameTimeMins >= 960 && coreGame.GameTimeMins < 1080 && coreGame.NumEvent < 4) coreGame.NumEvent = 12;
	}
	
	public function HandleWalk():Boolean {
		SMTRACE("BeachWalk::HandleWalk "+coreGame.NumEvent);
		
		if (super.HandleWalk()) return true;
		
		switch (coreGame.NumEvent) {

				// Nun
			case 1 :
				var choice:Number = coreGame.MeetNun("");
				if (choice == 4) {
					ShowPerson(24,1,1,6);
					SetText(coreGame.SlaveMeet+" a nun who is trying to convince people to be modest. Few seem to be listening.\r\rThe nun is wearing a swimsuit as all must but strangely one of the most revealing ones that "+coreGame.SlaveHas+" ever seen. When asked, the nun explains that it was the only one she could find. She then whispers under her breath <font size='-2'>'or wanted to wear'</font>.");
				}
				return true;

				// Lady Farun
			case 2 :
				ShowPerson(9,1,0,10);
				SetText(coreGame.SlaveMeet+" the alluring Lady Farun relaxing on the beach, being attended by her maid. The maid is very attentive to the Lady's needs and very cute.\r\r"+coreGame.SlaveVerb("spend")+" some time talking with Lady Farun but after a while "+ coreGame.NonPlural("notice")+" the maid appears to be competing for the Lady's attention, bring drinks, snacks and sometimes interrupting #slave.\r\rLady Farun tells the maid to calm down, that "+ coreGame.SlaveIs+" not her "+coreGame.Plural("lover")+". The maid blushes and restrains herself.");
				if (coreGame.LadyFarun.IsAccessible()) {
					AddText("Lady Farun smiles and then adds '..yet..'");
				}
				AddText("\r\rThe Lady is very sensual and a great pleasure to talk to. ");
				if (Supervise) {
					AddText("You feel a great reluctance to leave her");
					if (coreGame.LadyFarun.IsAccessible()) {
						AddText(" and some jealousy at the word 'yet'");
					}
					AddText(".");
				}
				Points(0,0,2,0,0,0,0,0,2,0,0,0,3,0,3,0,0,2,0,0);
				return true;


				// Maid, Sumi
			case 4 :
				ShowPerson(5,1,1,4);
				if (coreGame.Maid.IsVisited()) {
					AddText(coreGame.SlaveMeet+" Sumi, the kind and gentle maid, that "+coreGame.SlaveHeSheHas+" met before");
				} else {
					AddText(coreGame.SlaveMeet+" a kind and gentle maid who introduces herself as Sumi,");
				}
				AddText(" and they walk and talk a bit.\r\rSumi avoids talking about housework and instead just chats about pleasant, little things. She has a subtle sense of humour and at times is a bit mischievous.");
				Points(0,2,0,0,0,0,0,0,2,0,0,0,1,0,2,0,3,2,0,0);
				return true;

				// Miss N
			case 5 :
				ShowPerson(3,1,1,14);
				Points(0,0,0,0,0,0,0,0,2,0,0,0,2,0,2,0,0,3,0,0);
				SetText(coreGame.SlaveMeet+" Miss N. coming back from a swim and they relax and chat happily.\r\rMiss N. is very happy and carefree and her good mood is contagious.");
				return true;

				// Barmaid
			case 6 :
				ShowPerson(2,1,1,7);
				Points(0,0,0,0,0,0,0,0,2,1,0,0,1,0,2,0,0,1,0,0);
				SetText(coreGame.SlaveIs+" walking along and "+coreGame.NonPlural("see")+" ");
				if (coreGame.Barmaid.IsAccessible()) {
					AddText("Sora the Barmaid");
				} else {
					AddText("a young woman");
				}
				AddText(" walking along eating an icecream. She seems a little distracted by something, but then she notices #slave.\r\rThey talk a little and ");
				if (coreGame.Barmaid.IsAccessible()) {
					AddText("Sora");
				} else {
					AddText("the young woman");
				}
				AddText(" makes references to how eating the icecream can be 'practice' for some aspects of her job. She giggles and says 'larger than most of those aspects too'.");
				return true;

				// elf
			case 8 :
				if (this.CheckBitFlag(32)) {
					SetText(coreGame.SlaveMeet+" the dark-elf girl happily playing on the beach, walking, splashing in the water. No-one seems to care she is a dark-elf and she seems to have made friends.\r\rShe sees #slave and runs over and embraces "+coreGame.SlaveHimHer);
					if (Supervise) {
						AddText(" and the hugs you and gives you a kiss on the cheek");
					}
					AddText(". She thanks #slave for the help earlier and invites #slavehimher to play.");
					if (Supervise) {
						Points(0,0,0,0,0,1,0,0,0,0,0,0,1,0,2,0,2,1,2,0);
					} else {
						Points(0,0,0,0,0,1,0,0,0,0,0,0,1,0,2,0,2,1,0,0);
					}
					coreGame.ShowMovie(this.mcBase.Walk,1,1,slrandom(3)+1);
					coreGame.OldNumEvent = 8.2;
				} else {
					if (Supervise) {
						Points(0,1,0,3,0,0,0,0,2,0,0,0,1,1,2,0,0,0,1,0);
					} else {
						Points(0,1,0,3,0,0,0,0,2,0,0,0,1,0,2,0,0,0,0,0);
					}
					coreGame.ShowMovie(this.mcBase.Walk, 1, 1, 1);
					SetText(coreGame.SlaveVerb("walk")+" along the beach and at the fringe in some bushes "+coreGame.SlaveHeSheVerb("see")+" an exotic woman sitting, a member of the elven kind. "+coreGame.SlaveIs+" only slightly familiar with elves and "+coreGame.NonPlural("ask")+" to join the young elf to chat. The elf is a little reluctant but agrees and they talk a little. The elf talks a little about her people,\r\r");
					PersonSpeak("Elf Girl","The elven kind are a long lived people, many times the life-span of humans and we are divided into two races, the forest-kin, or wood-elves and my kind the dark elves or High-elves as we call ourselves.\r\rThe wood-elves are a very reclusive people who seldom have anything to do with other peoples, even with my kind. They are the longest-lived of all the peoples. They seldom leave their home towns, and they are very, very conservative. I have heard rumours that there has been a revolt of some-sort in their lands and some of their people are now wandering the world.\r\rThe dark-elves are better known to humans, after all we have fought many wars against your kind. Most dark-elves consider humans to be little more than animals, to be enslaved and treated however they desire. Generally as labourers or sex-slaves, after all we cannot impregnate each other and human cocks are slightly different in shape and size.\r\rI do not share these beliefs of my people, humans are people, just as we are.",true);
					AddText("\r\r#slave and the elf girl talk for a while more, and eventually "+coreGame.SlaveVerb("realise")+" the elf girl is shy and reluctant to openly walk and play, feeling the humans would hate her or discriminate against her for being a dark-elf.\r\r");
					if (Supervise) {
						AddText("You explain");
					} else {
						AddText(coreGame.SlaveVerb("explain"));
					}
					AddText(" that few people here in Mioya care as this country has never warred against the dark-elves. The elf girl looks happier and promises to try another time, and she introduces herself as Lainath.");
					this.SetBitFlag(32);
					coreGame.OldNumEvent = 8.1;
				}
				TalkArak();
				return true;

				// topless
			case 9 :
				slaveData.DifficultyExhib--;
				SetText("#slavesee that quite a few women on the beach seem to prefer to go topless, wearing only the bottom on their bikini's.\r\r"+coreGame.NameCase(coreGame.SlaveHeSheVerb("guess"))+" that they do this for the suntan");
				if (coreGame.IsDickgirlEvent()) {
					AddText(" observing one hermaphrodite applying lotion and then leaving her top off. The woman did also carefully apply lotion all over her cock before reluctantly replacing the bottom of her bikini.");
					coreGame.ShowMovie(this.mcBase.Walk,1,1,13);
					coreGame.OldNumEvent = 9.1;
				} else {
					coreGame.ShowMovie(this.mcBase.Walk,1,1,slrandom(2)+9);
					AddText("...");
				}
				if (SMData.SMFaith == 1) {
					Points(1,0,0,0,-1,1,0,0,1,0,0,0,2,0,3,0,0,0,0,0);
				} else {
					Points(1,0,0,0,0,1,0,0,1,0,0,0,2,0,3,0,0,0,0,0);
				}
				return true;

				// mermaid
			case 10 :
				coreGame.ShowMovie(this.mcBase.Walk,1,0,5);
				this.NoRepeatEvent(10);
				Points(0,2,0,2,2,0,0,0,0,0,0,2,2,0,3,1,2,-1,0,0);
				SetText("#slavesee a commotion on a small jetty, and "+coreGame.NonPlural("run")+" over to look. "+coreGame.SlaveIs+" shocked to see a mermaid bound with straps, gagged with a ball-gag and being held down by a man. He is pulling a series of beads or large pearls from her ass! The man is talking very angrily,\r\r");
				PersonSpeak("Man","...inhuman thing, how dare you pretend to be human and sneak into my home and steal my family's heirloom and then when I catch you it is in your ass!",true);
				AddText("\r\rHe slaps her and the ball-gag comes free. She yells out in an odd, pained voice,\r\r");
				PersonSpeak("Mermaid","Your great-grandfather stole it from me, I am just recovering what is mine. Oww, and its proper place is in my ass, and nowhere else!",true);
				AddText("\r\rThe man is furious and pulls the last of the beads from her ass. He quickly puts the gag back in her mouth, and stands over her. He lowers his trousers clearly planning to fuck her, but he has difficulty getting an erection. Eventually he fucks her ass, his cock not very hard,\r\r");
				PersonSpeak("Man","Damn you inhuman thing, you deserve to be fucked but how can I be interested in fucking a fish...",true);
				AddText("\r\r"+coreGame.SlaveVerb("want")+" to do something. Will #slaveheshe run to help the mermaid and return the beads to her, or ask #super to help, or look on helplessly,\r\r");
				coreGame.AskHerQuestions(4330,4331,4332,0,"Run to help","Look to #super for help","Feel sad for the mermaid","","What "+coreGame.NonPlural("does")+" #slaveheshe do?");
				return true;

			// lord
			case 12 :
				ShowPerson(8,1,2,5);
				SetText("#slavesee the Lord and a small party relaxing on the beach. There is a Lady with him subtly flirting with him, but he seems to be not noticing, or choosing not to notice.\r\rHe ");
				if (coreGame.VarRefinementRounded>50) {
					Points(2,0,2,0,0,1,0,0,0,0,0,0,1,0,2,3,3,1,0,0);
					AddText("waves hello to #slave but the Lady distracts him before he moves to talk to #slave.");
				} else {
					AddText("greets #slave and talks briefly with #slavehimher, to the Ladies annoyance.");
					Points(2,0,2,0,0,1,0,0,0,0,0,0,1,0,2,5,3,1,0,0);
				}
				return true;

			case 13 :
				coreGame.ShowMovie(this.mcBase.Walk,1,1,14);
				AddText(coreGame.SlaveMeet+" some girls using fireworks and they invite #slavehimher to join them. #slave has a pleasant, fun time.");
				Points(0,2,0,0,0,0,0,0,1,0,0,0,1,0,2,0,-4,3,0,0);
				return true;

			case 14 :
				coreGame.ShowMovie(this.mcBase.Walk,1,1,15);
				AddText(coreGame.SlaveMeet+" meets a couple of girls walking on the beach but they seem to want privacy and "+coreGame.SlaveVerb("leave")+" them alone.");
				Points(0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0);
				return true;

			case 15 :
				coreGame.ShowMovie(this.mcBase.Walk,1,1,16);
				AddText("#slavesee a very strange being sitting in the shallow water, clearly female, but of a race "+coreGame.SlaveHas+" never heard of. The being is glowing softly and she looks at #slave who "+coreGame.NonPlural("feel")+" a strange sensation, a mixture of confidence, joy and lust.\r\rThe being stands and just fades away, almost melting into the sea.");
				Points(0,0,0,0,0,0,0,0,0,0,0,3,1,0,1,0,3,3,0,0);
				return true;

			// people
			case 11 :
			default :
				coreGame.ShowMovie(this.mcBase.Walk,1,0,slrandom(4)+6);
				AddText("#slavesee a lot of people are playing and relaxing on the beach and speaks to many people about many things.");
				Points(1,0,1,1,0,1,1,0,2,0,0,0,1,0,2,0,3,0,0,0);
				return true;

		}

		return false;
	}
	
	private function TalkArak()
	{
		var sd:Slave = SMData.GetSlaveDetails("Arak", true);
		if (sd == null) return;		// never met
		if (sd.SlaveType == 0 || sd.CanAssist || sd.SlaveType == -1 || sd.SlaveType == 1 || sd.SlaveType == 2) return;		// already owned
		if (sd.SlaveType == -3 || sd.SlaveType == -4 || sd.SlaveType == -5 || sd.SlaveType == -6 || sd.Available == false) return;		// gone
		if (sd.SlaveType == -10) return;		// currently in training
		
		// Arak is in the Slave Pens and Lady Farun has talked about training
		if (!Supervise) {
			AddText("\r\rIn passing #assistant mentions the spiderwoman in the Slave Pens, and the elf girl looks startled. #assistant asks her why, but she refuses, explaining some things can only be discussed between Masters and Mistresses.");
			return;
		}
		ShowMovie(this.mcBase.Walk, 1, 1, 1);
		
		// Personal supervision
		AddText("\r\rYou ask the elf girl Lainath about the spiderwoman in the Secure Slave Pens. The elf girl looks at you a little surprised and also a little angry.\r\r");
		PersonSpeak("Lainath","That poor dear, her kind hates captivity, and refuse to eat when imprisoned. Even if they did eat I doubt they would feed her the right diet anyway.\r\rAre you interested in her?", true);
		DoYesNoEventXY(qNum1);
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			// Yes interested
			case qNum1:
				var sd:Slave = SMData.GetSlaveDetails("Arak");
				sd.CustomFlag2 = -1;
				AddText("The Elf girl looks more cheerful,\r\r");
				PersonSpeak("Lainath","All right!! Let's go and collect her, I'll explain the basics of her care on the way, and with those you should be able to keep her alive as you learn the rest.\r\rHer kind is a bit odd, they are intelligent but they have a very focused set of desires. They want food, sex and to breed, I have never seen one of their kind be interested in anything else. They can understand speech but normally ignore anything not about their desires. They very, very seldom speak, as a matter of fact for a long time I thought they were mute. The only way you will be able to keep her is to satisfy her desires, this means feed her <b>meat and blood</b> but only every few days. The meat can be anything at all, but the blood <i>has</i> to be that of her mate. <b>You</b> will have to take her as your mate, I do not mean anything like marriage, I mean sex.", true);
				if (SMData.Gender == 2) {
					AddText("\rLainath looks at you");
					if (sd.SlaveGender == 3) {
						AddText(" and asks if the spiderwoman has a cock and you answer yes.");
						PersonSpeak("Lainath", "She will fuck you as often as she can, and she is fertile with most of the races. When she fucks you she will also take her fill of blood from you, be careful she does not over-indulge.", true);
					} else {
						AddText("\r\r");
						PersonSpeak("Lainath", "Even if you are both female, she can still lay her eggs in your womb, and I believe they can be fertile. When she does this she will take her fill of your blood, make sure she does not over-indulge.", true);
					}
				} else {
					AddText("\r\r");
					PersonSpeak("Lainath", "She will want you to fuck her very often, and when you do she will take her fill of blood. Be careful she does not over-indulge.", true);
				}
				AddText("\r\rShe explains more as you travel to the docks\r\r");
				PersonSpeak("Lainath", "She will need somewhere dark and cool to live. A cellar or dungeon is perfect, but at a pinch board up the windows in a room and make sure there is plenty of water around.\r\rAs we mentioned, never, ever lock her up. You can tie her up for pleasure, but release her afterwards.", true);
				AddText("\r\rYou arrive at the docks and Lainath quickly leads you to the Slave Pens, and then after a quick chat with a guard arrive at the cell containing the spider woman...");
				DoEvent(nNum2);
				return true;
			
				
			// 4306 - Private - Noblewoman - accept price
			case 4306:
				coreGame.BeachPrivate.SetBitFlag(35);
				PerformActNow(-50, "BlowJob", !coreGame.BeachPrivate.CheckBitFlag(34));
				AddText(coreGame.SlaveHas + " an odd feeling as " + coreGame.SlaveHeSheVerb("kneel") + " before the woman but cannot quite work out what. ");
				if (coreGame.BeachPrivate.CheckBitFlag(34)) {
					AddText("She licks the woman's cock which is very hard and the woman moans softly.\r\r#slave licks and sucks the woman's cock but while she moans in pleasure she does not cum! #slave looks up at the woman who groans,\r\r");
					PersonSpeak("Noblewoman", "Ohhh you need to overcum my control and force me to mmmmm, cum. You are doing delightfully...", true);
					AddText("\r\r#slave renews her licking of the woman's cock, and plunges fingers into the woman's pussy, fucking her as she licks. The woman moans more, her hips slightly thrusting and whispers 'a little more'. #slave pushes a finger into the noblewoman's ass fucking fingers in pussy and ass while licking the head of her cock.\r\rThe noblewoman gasps and holds #slave's head and cries out cumming long spurts of cum into #slave's mouth for a long while. The woman's cum overflows #slave's mouth and the woman gasps 'Swallow!' and #slave does so, almost involuntarily.");
					AddText("\r\rThe woman collapses breathing heavily and after a bit softly laughs and says,\r\r");
					PersonSpeak("Noblewoman", "Let me tell you a secret, the greatest pleasure is to cum into a cute slave's mouth!", true);
					if (!coreGame.Lesbian) {
						coreGame.TotalBlowjob++;
						coreGame.UpdateSexActLevels(5);
					}
				} else {
					AddText("She licks the woman's pussy, which is very wet with arousal and the woman moans softly.\r\r#slave licks the woman's pussy and gently sucks and bites her clit, but while she moans in pleasure she does not cum! #slave looks up at the woman who groans,\r\r");
					PersonSpeak("Noblewoman", "Ohhh you need to overcum my control and force me to mmmmm, orgasm. You are doing delightfully...", true);
					AddText("\r\r#slave renews her licking of the woman's pussy, and plunges fingers into the woman's pussy, fucking her as she licks. The woman moans more, her hips slightly thrusting and whispers 'a little more'. #slave pushes a finger into the noblewoman's ass fucking fingers in pussy and ass while sucking on her clit.\r\rThe noblewoman gasps and holds #slave's head and cries out orgasming, small spurts of juice squirting into #slave's mouth for a long while. The woman's juices fill #slave's mouth and the woman gasps 'Swallow!' and #slave does so, almost involuntarily.");
					AddText("\r\rThe woman collapses breathing heavily and after a bit softly laughs and says,\r\r");
					PersonSpeak("Noblewoman", "Let me tell you a secret, the greatest pleasure is to orgasm on a cute slave's mouth!", true);
					if (coreGame.LesbianTraining && !coreGame.IsMale()) {
						coreGame.TotalBlowjob++;
						coreGame.UpdateSexActLevels(5);
					}
				}
				AddText("\r\r" + SlaveVerb("look") + " betrayed, and the woman laughs again,\r\r");
				PersonSpeak("NobleWoman", "No that is not the secret I promised, just a matter of my pleasure I thought to share.\r\rThis beach is under the dominion of my Mistress, the Dark Lady of the Rocks, a Demon of power, beauty and passion. With my help and those of my Cult, She seeks to bring Lust, Passion, and Desire to all, to make them realise their true hearts. She does not control their minds or souls, although She can, for it is better for people to embrace Her ways than be forced into them.\r\rDo not think in outrage you can do something about this, my Mistress is a being of immense power and no mortal can oppose her. Embrace your desire and passion as you see the many who visit this beach have.\r\rNow let me rest for a while.", true);
				AddText("\r\r#slave immediately leaves, not sure why and confused a little.");
				if (SMData.SMFaith == 2) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -1, 1, 1, 1, 0, 0, 0, 0, 0);
				else Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 2, 0, -1, 1, 1, 1, 0, 0, 0, 0, 0);
				return true;

		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			// not interested
			case qNum1:
				var sd:Slave = SMData.GetSlaveDetails("Arak");
				sd.CustomFlag2 = -2;
				AddText("The Elf Girl looks sad and walks away, softly saying,\r\r");
				PersonSpeak("Lainath", "That poor dear...");
				return true;
				
			// 4306 - Private - Noblewoman - refuse price
			case 4306:
				AddText(SlaveVerb("refuse") + " and the noblewoman looks disappointed but then smiles. They talk a little more and they part with the noblewoman offering to tell the secret another time, for the same price.");
				if (SMData.SMFaith == 1) Points(0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0, 2, 1, 0, 3, 0.5, 0, 0, 0, 0);
				else Points(0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 2, 1, 0, 3, 0.5, 0, 0, 0, 0);
				return true;
		}
		return false;
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			// 4301 - walk beach walk
			 case 4301:
				ResetWalkEvent();
				WalkOnBeach();
				return true;
				
			// 4310 - Beach Guide - Swimming
			case 4310:
				ShowMovie(mcBase.Tour, 1, 0, 1);
				PersonSpeak(18, "Of course many come here to just swim and play in the water, the local sea is quite calm, with few large waves and clear water. I love swimming here and many people from all over the city swim here, but unfortunately few of the lower classes can afford cute swimsuits.\r\rWell I am not saying only noble ladies and gentlemen swim here, after all I once saw a certain courtesan here with a Lady! Makes you hope the Kraken would take them, but I suspect they would enjoy it. Oh the Kraken, just a story about a beast that haunts the shallows molesting women with large hard....I digress....");
				DoEvent(4311);
				return true;
		
			// 4311 - Beach Guide - Swimming Instructor
			case 4311:
				ShowPerson(18, 0, 7, 1);
				mcBase.Tour._visible = false;
				ShowPerson(17, 1, 2, 1);
				Backgrounds.ShowBeach(3);
				PersonSpeak(18, "May I introduce you to Alsha, she is our resident swimming instructor. She is a superb swimmer, almost like a water nymph!");
				BlankLine();
				PersonSpeak(17, "I am happy to teach anyone the joys of swimming for a small fee, 20GP a lesson.\r\rTry to not let Marine bore you too much with her incessant chatter, she is a harmless gossip, but cute.", true);
				BlankLine();
				PersonSpeak(18, "I'm not a gossip, but I am cute! Let us move on, bye Alsha.\r\rNow Alsha is a beautiful woman, but rather too fond of sex. It is said that often she has her male customers pay in a 'different' way...", true);
				BlankLine();
				parentCity.SwimInstructor.SetMet();
				DoEvent(4312);
				return true;
		
			// 4312 - Beach Guide - Walking
			case 4312:
				ShowSupervisor();
				HidePerson(17);
				ShowPerson(18, 1, 2, 1);
				var dg:Boolean = IsDickgirlEvent();
				ShowMovie(mcBase.Tour, 1, 0, dg ? 2 : 3);
				PersonSpeakStart(18, "Often I like to just walk along the beach and talk to the people here relaxing and sunbathing. You meet a lot of interesting people here, ");
				if (dg) AddText("now look at her, I would not of thought you would want to tan those! Then again I hear she only comes here for one thing, or should I say two. She should put them away. Do you think she cums twice as strong as a man?");
				else AddText("\r\rHi Kana!\r\rNow it is not nice to call someone a prostitute, after all it is a disreputable profession, but she loves dating men and they always give her gifts of money. She always gives them the gift of her body.");
				PersonSpeakEnd("\r\rIt seems people are much more open to their desires here at the beach, maybe it is the skimpy swimsuits...");
				DoEvent(4313);
				return true;
				
			// 4313 - Beach Guide - Private
			case 4313:
				Backgrounds.ShowForest(8);
				ShowMovie(mcBase.Tour, 1, 3, 4);
				SetText("Marine leads #slave and #super away from the beach into the tress. There are some small, discrete buildings.\r\r");
				PersonSpeak(18, "Here are the changing areas and some private rooms for discrete meetings. The trees can make things very private for assignations.", true);
				AddText("\r\r#slave" + NonPlural(" look") + " into a small sheltered area and in there is a young woman liberally applying lotion. She is quite naked and is paying particular attention to her breasts making sure to rub the lotion all over them and then carefully rubbing it very thoroughly over her nipples.\r\rShe looks at #slave and starts pouring the lotion onto her pussy rubbing it in and carefully making sure her clit is well, well covered. She moans and says,\r\r");
				PersonSpeak("Lotion Girl", "I have to ummm make sure the lotion covers all parts of my body. Ohhh the sensitive bits, mmmm , need special, special coverage....", true);
				AddText("\r\rShe stiffens and then shudders in a strong orgasm, spurts of liquid squirting from her pussy. She sighs still rubbing lotion over her body.\r\r");
				PersonSpeak(18, "Well, let us leave her to finish, well maybe she has...", true);
				AddText("\r\r" + coreGame.SlaveSee + " another woman walking toward the sheltered area, her skin glistening with lotion...");
				DoEvent(4314);
				return true;
				
			// 4314 - Beach Guide - Rocks
			case 4314:
				ShowMovie(mcBase.Tour, 1, 0, 5);
				PersonSpeak(18, "This is the north end of the beach and there are many natural rocks here, not too stable and a bit dangerous. Still some people like the climb over them...");
				AddText("\r\rShe breaks off and waves to an approaching girl,\r\r");
				PersonSpeak("Girl", "Hi Marine, yes I know the rocks are not safe, but I wanted to see if I could find a good diving spot, but nothing. Too many rocks in the water.\r\rI saw a shape in the water though, they do say the Kraken is mostly seen around here, well normally at midday though. Well I am returning to my friends, bye!", true);
				AddText("\r\rThe girl leaves,");
				if (coreGame.TentaclesOn == 1) AddText(" and #slave is a little puzzled, aren't the tentacle creatures nocturnal?");
				BlankLine();
				PersonSpeak(18, "Bye! Now take care here the rocks are very dangerous, especially at night...", true);
				DoEvent(4315);
				return true;
				
			// 4315 - Beach Guide - Mermaids
			case 4315:
				Points(0, 0, 0, 4, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0);
				HideBackgrounds();
				ShowMovie(mcBase.Tour, 1, 3, 6);
				PersonSpeak(18, "If you are lucky you may see one of the immortal mermaids sometime. They sometimes can be seen at sea and some say they visit the rocks.\r\rPlease leave them be, they are nervous around people and can be unpredictable. You may have heard legends that if you eat the flesh of a mermaid you will gain their immortality. Sometimes the more horrible of us hunt them but you know I have never heard of someone catching a mermaid. Still the mermaids are very defensive and avoid us where possible.\r\rStill, please respect them...I was just thinking of Alsha and you know I have never heard of mermen...");
				AddText("\r\rMarine talks on at length, but about nothing much as she guides #slave around the beach. She often discusses the sexual tastes of people they pass, and often referring to her friend Alsha's taste for sex.\r\rAfter a while they part company with smiles and Marine gives some parting words,\r\r");
				PersonSpeak(18, "The beach is restricted at night, but there is a private gate nearby you can use.", true);
				AddText("\r\rShe shows #slave where the gate is.\r\rDuring the entire 'tour' Marine mainly talks to #slave, she does not ignore #super but never really talks to #super. ");
				if (Supervise) AddText("You ask");
				else AddText(ServantName + " asks");
				AddText(" why,\r\r");
				PersonSpeak(18, "I am sorry, but slavery is wrong, we should all be free to enjoy life as we want.", true);
				AddText("\r\rWith that she blushes, turns and walks away, giving a little wave over her shoulder.");
				ShowPlanningNext();
				return true;			
		
			// Arrive
			case nNum2:
				coreGame.HideImages();
				coreGame.Bars._visible = true;
				var sd:Slave = SMData.GetSlaveDetails("Arak");
				sd.BitFlag1.SetBitFlag(61);
				coreGame.ShowSlave(sd, 1, 0, sd.SlaveGender == 3 ? 2 : 1);
				SMData.SetSlaveOwned("Arak");
				SMData.GetOtherSlaveInformation(sd);
				Diary.AddEntry(Language.GetHtml("NowOwn", "SlaveMarket"));
				AddText("The Elf Girl looks at the spiderwoman and talks for a while to her in a variant of the dark elven language that you do not understand. You hear no reply from the spiderwoman, but Lainath nods her head and speaks to you,\r\r");
				PersonSpeak("Lainath","She has agreed to take you as her mate, go and claim her while I purchase her for you. No cost for you, my gift to you for this service.");
				AddText("\r\rYou are fairly sure what Lainath means by 'claim her' but to be sure you ask. Lainath, tells you how the spiderwoman is named Arak, and that she has eaten meat recently, but badly needs her mating. You are now sure what is expected, and a guard approches and lets you into the cage. You see Lainath happily leave to purchase the spiderwoman, Arak?\r\rUncertainly you looks at the spiderwoman as she approaches you, her white hair flowing and she has a rather beautiful face. You are unsure about her body though ");
				if (sd.SlaveGender == 3) AddText(" and you see her cock looks very much like a human one, but with odd markings and very, very erect. Your eyes are also drawn to her abdomen and an odd sort of shape at the end.");
				else AddText(" and your eyes are also drawn to her abdomen and an odd sort of shape at the end.");
				AddText("\r\rShe closely approaches you and you see her licking her lips, With some force she hugs you and kisses you with surprising passion. Her hands frantically start to remove your clothing, but she is clearly unfamiliar with the design of your clothes. You assist and quickly Arak removes all your clothing, and you see her bending low to the ground looking up at you with clear lust in her eyes. ");
				if (SMData.Gender == 2) {
					// Female
					AddText("");
					if (sd.SlaveGender == 3) {
						// Arak is a dickgirl
						AddText("");
					} else {
						// Arak female
						AddText("");
					}
					SMData.SMImpregnate("Arak", slrandom(3) + 3, 45 + slrandom(5));
				} else {
					// Male/Dickgirl
					AddText("");
					if (sd.SlaveGender == 3) {
						// Arak is a dickgirl
						AddText("");
					} else {
						// Arak female
						AddText("");
					}
				}
				if (SMData.Gender != 2) sd.Impregnate("Yours", slrandom(3), 45 + slrandom(5));
				AddText("\r\rLater as you leave the cage you see Lainath looking at another cage, studiously not watching the mating. She turns as she hears you and hugs you and kisses your cheek,\r\r");
				PersonSpeak("Lainath","Congratulations, she is your mate. Did I mention her kind mates for life?", true);
				return true;
				
			// 4330 - Beach Walk - Mermaid Assault - slave help
			case 4330:
				mcBase.Walk._visible = false;
				Backgrounds.ShowBeach();
				Lesbian = false;
				coreGame.SlaveGirl.Lesbian = false;
				coreGame.UseGeneric = false;
				coreGame.SlaveGirl.ShowSexActGangBang();
				if (!coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(15);
				if (coreGame.UseGeneric) coreGame.Generic.ShowSexActGangBang();
				coreGame.TotalGangBang++;
				coreGame.ResetNotFucked();
				Points(0, -1, 0, 0, 0, 1, 0, 0, 0, 2, 2, -1, 5, 5, -5, 0, 4, 0, 0, 0);
				if (parentCity.GetPlaceObject("BeachSwim").CustomFlag == -1) parentCity.GetPlaceObject("BeachSwim").CustomFlag = 4;
				else parentCity.GetPlaceObject("BeachSwim").CustomFlag += 4;
				
				SetText("#slavesee a young man standing nearby holding a beach ball, and watching with a somewhat disgusted expression on his face, but a growing erection. " + SlaveVerb("borrow") + " the ball and throws it at the man and then runs full speed into him, as if #slaveheshe was trying to catch it. The man stumbles over, his cock barely erect as he lies there surprised. " + SlaveVerb("fall") + " onto the mermaid and 'accidentally' frees her bindings.\r\rThe mermaid leaps in a mighty, inhuman leap, onto the man, grabbing the pearl beads and then leaps into the sea in a graceful splash. The man yells in anger unable to react quickly, his trousers around his ankles preventing quick action.\r\rNo-one watching makes any move to do anything, except as " + SlaveVerb("look") + " #slaveheshe can see most of them were masturbating while watching and now look a bit annoyed.\r\rThe man speaks to #super, yelling in his anger and demands recompense. " + NameCase(coreGame.SupervisorName) + NonPlural(" offer", Supervise ? 4 : 1) + " gold but the man refuses, demanding #slave's body instead. The crowd cries out in agreement and gathers around looking angry and very, very aroused and #super reluctantly " + NonPlural("agree", Supervise ? 4 : 1) + ".\r\rThe man pushes " + coreGame.SlaveName2 + " over and pushes his now hard cock into " + coreGame.SlaveHisHerSingle + " ass. He fucks " + coreGame.SlaveHimHerSingle + " quickly, cumming almost immediately. A person from the crowd pushes him aside and starts fucking " + coreGame.SlaveName2 + ". A woman sits in front of " + coreGame.SlaveName2 + " and tells #slavehimher to lick her pussy.\r\rTime passes as person after person fuck #slave singly or many at once. None of them ask permission and all seem extremely aroused.\r\rEventually " + coreGame.SupervisorName);
				if (Supervise) AddText(" are able to get #slave free...");
				else AddText(" is able to get #slave free...");
				DoEvent(4333);
				return true;
				
			// 4331 - Beach Walk - Mermaid Assault - supervisor help
			case 4331:
				if (Supervise) {
					SetText("You walk up to the man and push him very hard, enough that he falls into the shallow sea below the jetty. You quickly cut the bindings of the mermaid and she laughs and dives into the sea after the man. You watch as she bites, scratches and beats the man with fists and tail. She takes back the pearls and swims away quickly.\r\rThe battered and bruised man climbs back onto the jetty and yells angrily at you, demanding retribution. ");
					if (SMData.sNoble > 0) {
						Points(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 3, 0, 0, 0, 3, 0);
						AddText("You introduce yourself and your noble house, and the man pales in shock and fear. He kneels and apologises and quickly leaves. The crowd looked angry and aroused but at your revelation quickly disperse.");
					} else {
						Points(0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 3, 0);
						AddText("You suggest a duel to settle the matter, introducing yourself. The man looks afraid, and you see clearly he has no standing in court, a merchant it appears. He backs away, afraid of possible repercussions, but making comments about seeking legal help.\r\rTo quiet him you pay him 100GP and tell him to never, ever cross your path again.");
						Money(-100);
					}
					SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 1, 0);
					DoEvent(4333);
				} else {
					SetText(coreGame.SupervisorName + " walks up to the man and slaps him very hard, enough that he falls backward. #assistant frees the mermaid, but while doing so pushes her off the jetty, into the sea. The mermaid looks oddly at #assistant and dives into the sea.\r\rThe man screams at #assistant who looks at him with scorn and drops some gold at his feet. 'For compensation, and treatment of your potency problem'. The man looks hugely angry and moves to strike #assistant and then the watching crowd laughs. He stops, hugely embarrassed, and also realises his trousers are still at his ankles. He bends down and picks up to hold and pulls up his trousers. He glares at #assistant and leaves.");
					Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0);
					Money(-100);
				}
				return true;
				
			// 4332 - Beach Walk - Mermaid Assault - slave helpless
			case 4332:
				SetText(SlaveVerb("feel") + " helpless, especially as " + coreGame.SlaveHeSheVerb("look") + " at the crowd. The people look both disgusted at the man, but most are looking very aroused, some openly masturbating.\r\rThe man has considerably difficulty but eventually weakly cums. He steps back and crowd advances, intent on their turn, but he yells for them to get back, how this fish is his to punish. He pushes the still bound mermaid off the jetty and walks away.\r\r" + SlaveVerb("dive") + " off the jetty and " + NonPlural("see") + " the mermaid struggling in her bindings. " + SlaveVerb("free") + " the mermaid and they surface. The mermaid, looks strange, probably humiliated and angry but inhumanly calm and collected. She looks at #slave and says,\r\r");
				PersonSpeak("Mermaid", "I will recover the pearls, be it tomorrow or in a hundred years. I will also make him and his descendents regret his rape of me.\r\rThank you for your help.", true);
				AddText("\r\rWith that the mermaid dives and rapidly swims away. #slave rejoins #super...");
				Points(0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, -2, 2, 0, 3, 0, 1, -1, 0, 0);
				return true;
				
			// 4333 - Beach Walk - Mermaid Assault - thanks
			case 4333:
				HideBackgrounds();
				coreGame.HideSlaveActions();
				ShowMovie(mcBase.Walk, 1, 0, 6);
				if (Supervise) SetText("You are taking #slave home and you are passing some rocks next to the beach.\r\rYou see the mermaid rear out of the sea, the pearls clearly in her ass again. She looks at you and #slave and smiles. You watch her sink back into the sea and you just hear the words 'Thank you'");
				else SetText(coreGame.SupervisorName + " is taking #slave home and are passing some rocks next to the beach.\r\r#super sees the mermaid rear out of the sea, the pearls clearly in her ass again. She looks at #slave and smiles. #assistant watches her sink back into the sea and can just hear the words 'Thank you'"); 
				return true;

		}
		return false;
	}

}