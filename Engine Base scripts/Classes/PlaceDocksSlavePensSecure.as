// Docks (SlavePens Secure)
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceDocksSlavePensSecure extends PlaceDocks
{
	public var itemstr:String;
	
	// constructor
	public function PlaceDocksSlavePensSecure(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to xml node DocksSlavePensSecure, id 6.3
		super("DocksSlavePensSecure", mc, cg, 6.3, cc);
		Accessible = false;
		
		this.itemstr = "";
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "SeeCreature-3";	// set default event

		this.AddEvent("DemonGirl-1");
		this.AddEvent("MeetBountyHunter-2");
		this.AddEvent("SeeCreature-3");
		this.AddEvent("NobleParty-4");
		this.AddEvent("FarunRescue-5", true);
	}
	
	// Walking at the Secure Slave Pens
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4103);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkDocks++;
		coreGame.EventTotal = slaveData.TotalWalkDocks;
		
		// Select the event and show it
		super.DoWalkLoaded(mc, "");
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		coreGame.DemonChoice = 0;
		
		if (!IsEventPicked()) {
			if (coreGame.LadyFarun.IsMet() && (!coreGame.LadyFarun.CheckBitFlag(64)) && PercentChance(60)) {
				coreGame.SetEvent("FarunRescue-5");
				super.GetWalkEvent(exclude, sequential);
				return;
			}
			temp = this.GetEventTotal("Lamia");
			if (temp > 0 && temp < 6 && this.IsEventRepeatable("Lamia") && PercentChance(50)) {
				coreGame.SetEvent("SeeCreature-3");	
				super.GetWalkEvent(exclude, sequential);
				return;
			}
			if (!SMData.IsSlaveOwned("Arak") && PercentChance(25)) coreGame.SetEvent("SeeCreature-3");	
		}
		super.GetWalkEvent(exclude, sequential);
	}
	
	public function HandleWalk() : Boolean
	{
		coreGame.SMTRACE("DocksSecureSlavePens::HandleWalk " + coreGame.StrEvent);

		switch (coreGame.StrEvent) {
			
		case "DemonGirl-1":
			ShowSupervisor();
			if (coreGame.DemonChoice == 0) {
				var bRandom:Boolean = coreGame.BitFlag1.CheckBitFlag(2) && coreGame.BitFlag1.CheckBitFlag(3);
				if (coreGame.DickgirlOn == 1) bRandom = bRandom && coreGame.BitFlag1.CheckBitFlag(4);
				if (!bRandom) {
					bRandom = true;
					var bloop:Boolean;
					for (var i:Number = 1; i < 10; i++) {
						bloop = false;
						coreGame.DemonChoice = coreGame.IsDickgirlEvent() ? 3 : Math.floor(Math.random()*2) + 1;
						switch(coreGame.DemonChoice) {
							case 1:
								if (coreGame.BitFlag1.CheckBitFlag(2)) bloop = true;
								coreGame.BitFlag1.SetBitFlag(2);
								break;
							case 2:
								if (coreGame.BitFlag1.CheckBitFlag(3)) bloop = true;
								coreGame.BitFlag1.SetBitFlag(3);
								break;
							case 3:
								if (coreGame.BitFlag1.CheckBitFlag(4)) bloop = true;
								break;
						}
						if (!bloop) {
							bRandom = false;
							break;
						}
					}
				}
				if (bRandom) coreGame.DemonChoice = coreGame.IsDickgirlEvent() ? 3 : Math.floor(Math.random()*2) + 1;
			}
		
			if (coreGame.DemonChoice < 3) ShowPerson(33, 1, 1, coreGame.DemonChoice);
			else HideBackgrounds();
			if (slaveData.DemonicBraWorn == 1 || slaveData.DemonicPendantWorn == 1)
			{
				if (slaveData.DemonicBraWorn == 1) itemstr = "Demonic Bra ";
				else itemstr = "Demonic Pendant ";
				Points(0, 0, 0, 0, -2, 0, 0, 0, 0, 1, 1, 0, 1, 1, 10, 0, 0, 0, 0, 0);
				if (coreGame.DemonChoice == 1) AddText("#slave meets an odd girl chained to a wall, with a slightly demonic appearance who whispers a command to the " + itemstr + coreGame.SlaveIs + " wearing. #slave immediately " + coreGame.SlaveHeSheIs + " filled with lust and visions of depraved, orgasmic sex.\r\r" + coreGame.SlaveVerb("stagger") + " away, leaving the girl.");
				else if (coreGame.DemonChoice == 2) AddText("#slave meets a woman of demonic appearance who stares at #slave. Suddenly the " + itemstr + coreGame.SlaveIs + " wearing flares up and immediately " + coreGame.SlaveHeSheIs + " filled with lust and visions of depraved, orgasmic sex.\r\rWhen " + coreGame.SlaveHeSheVerb("recover") + " " + coreGame.SlaveHeSheVerb("see") + " the woman is obviously orgasming and " + coreGame.NonPlural("leave") + " quickly.");
				else {
					if (coreGame.BitFlag1.CheckBitFlag(4)) {
						if (coreGame.BitFlag1.CheckBitFlag(5)) {
							ShowPerson(33, 1, 3, 3);
							AddText("#slave nervously meets the hermaphrodite demon girl " + coreGame.SlaveHeSheHas + " met previously. " + coreGame.SlaveIs + " relieved to see the girl is securely bound with a tight ring around the base of her very large erect cock, but there is no vibrator in her pussy.\r\rShe looks seductively at #slave and whispers a command to the " + itemstr + coreGame.SlaveIs + " wearing. " + coreGame.SlaveIs + " immediately filled with lust and visions of depraved, orgasmic sex.\r\r" + coreGame.SlaveVerb("stagger") + " away, leaving the girl.");
						} else {
							ShowPerson(33, 1, 3, 4);
							StartDemonGirlCum();
							AddText("<b>#slave</b> nervously sees the demonic looking hermaphrodite girl she had met before. She seems to have been recaptured but is starting to get free again! Her very large cock is erect and she is frantically masturbating. She looks at #slave with a wicked smile and cums a huge spray of cum.");
							coreGame.BitFlag1.SetBitFlag(5);
						}
					} else {
						ShowPerson(33, 1, 3, 4);
						StartDemonGirlCum();
						AddText("<b>#slave</b> meets an odd girl chained by only one wrist to a wall, having freed the other. She has a very large erect cock and is frantically masturbating.");
						coreGame.BitFlag1.SetBitFlag(4);
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0);
					}
				}
			} else {
				if (coreGame.DemonChoice == 1) AddText(coreGame.SlaveMeet + " an odd girl chained to a wall, with a slightly demonic appearance and talks with her about matters of heaven and hell.");
				else if (coreGame.DemonChoice == 2) AddText(coreGame.SlaveMeet + " a woman of demonic appearance shackled to a wall, heavy weights hanging from nipples and clitoris, she even has a tail of some sort! #slave carefully talks with her, and she complains of the gods, her captors and complains about a cruel thing they had placed in her pussy.\r\r#slave offers to help and puts #slavehisher fingers in and searches, The woman moans and tells #slavehimher it is deeper. #slave searches but finds nothing, then feels a spray and convulsions as the woman starts orgasming. When she recovers she smiles and comments how aroused she had been. #slave smiles nervously and leaves.");
				else {
					if (coreGame.BitFlag1.CheckBitFlag(4)) {
						if (coreGame.BitFlag1.CheckBitFlag(5)) {
							ShowPerson(33, 1, 3, 3);
							AddText("#slave nervously meets the hermaphrodite demon girl she has met previously. She is relieved to see the girl is securely bound with a tight ring around the base of her very large erect cock, but there is no vibrator in her pussy. She looks seductively at #slave and talks with her about heaven, hell and at length about sexual encounters.\r\rThe demon girl rubs her cock continuously against the ground as if trying to masturbate and begs #slave to release her cock-ring. Wisely and a little sadly #slave refuses.");
						} else {
							ShowPerson(33, 1, 3, 4);
							StartDemonGirlCum();
							AddText("<b>#slave</b> nervously sees the demonic looking hermaphrodite girl she had met before. She seems to have been recaptured but is starting to get free again! Her very large cock is erect and she is frantically masturbating. She looks at #slave with a wicked smile and cums a huge spray of cum.");
							coreGame.BitFlag1.SetBitFlag(5);
						}
					} else {
						ShowPerson(33, 1, 3, 4);
						StartDemonGirlCum();
						AddText(coreGame.SlaveMeet + " an odd girl chained by only one wrist to a wall, having freed the other. She has a very large erect cock and is masturbating slowly. She looks seductively at #slave and talks with her about heaven, hell and sex.");
						coreGame.BitFlag1.SetBitFlag(4);
					}
				}
				Points(0, 0, 0, 0, -1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			}
			return true;
			
		case "MeetBountyHunter-2":
			ShowSupervisor();
			HideBackgrounds();
			ShowPerson(12, 1, 2, 1);
			Points(0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			if (coreGame.BountyHunterFlag > 0) AddText(coreGame.SlaveSee + " the beautiful bounty hunter, Irina, and she is delivering a bound slave. She looks at #slave but is very busy and waves.\r\r" + coreGame.SlaveVerb("admire") + " Irina's grace while she performs her job.");
			else AddText(coreGame.SlaveMeet + " a beautiful woman, who is a bounty hunter, and she is delivering a bound slave.\r\r" + coreGame.SlaveVerb("admire") + " the bounty hunter's grace while performing her job");
			return true;
			
		case "SeeCreature-3":
		default:
			ShowSupervisor();
			coreGame.Bars._x = 7;
			coreGame.Bars._visible = true;
			
			// check if we should see the Lamia or Arak
			temp = this.GetEventTotal("Lamia");
			if (temp > 0 && temp < 6 && this.IsEventRepeatable("Lamia") && PercentChance(50)) temp = 3;
			else {
				if (PercentChance(30) && !SMData.IsSlaveOwned("Arak")) temp = 2;
				else {
					// no, pick a random event
					if (Language.XMLData.PickAndDoXMLEvent("/Events/Walk/DocksSlavePensSecure/VisitMonster")) {
						trace("visited xml monster");
			  			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0);
						return true;
					}
					temp = 1 + Math.floor(Math.random()*(3 + coreGame.TentaclesOn));
					if (temp == 3 && !this.IsEventRepeatable("Lamia")) temp = 1;
					if (temp == 2 && SMData.IsSlaveOwned("Arak")) temp = 1;
				}
			}
			trace("visiting monster " + temp);
			switch (temp) {
				case 1:
					// Demon
					coreGame.OldNumEvent = 3.1;
					AddText(coreGame.SlaveSee + " in a strong cage a demonic figure ");
					Backgrounds.ShowOverlay(0);
					coreGame.config.ShowMonster("demon", 1, 1);
					if (temp == 1) AddText("very male, a large cock hanging. A woman is standing next to the cage and #slave says demons have the largest cocks of humanoids. Their cum is thick, voluminous and very hot, but they prefer ass fucking if given the chance. #slave looks and sees the woman is flushed and smiling.");
					else AddText("male looking, but with no genitals. A woman is standing next to the cage and #slave says when aroused it's cock appears from within his groin. It is huge and he fucks for a long time before cumming hot, hot cum. They will ass fuck you if given the chance. #slave looks and sees the woman is flushed and smiling."); 
					AddText(" She speaks so certainly as if from personal experience, ");
					parentCity.MeetPerson(39, 0, "Narana", "", "1");
					AddText(", but is focused on the demon.\r\r#slave is a little embarrassed but also quite aroused and leaves Narana staring at the demon, slipping her hands inside her dress, moving, caressing, rubbing..."); 
					parentCity.DocksSlavePens.SetBitFlag(32);
					break;
					
				case 2:
					// Arak the spiderwoman
					coreGame.OldNumEvent = 3.4;
					var sd:Slave = SMData.GetSlaveDetails("Arak", true);
					if (sd != null) {
						if (sd.SlaveType == -4) {
							// gone, do fairy instead
							coreGame.DoEventNext(4220);
							coreGame.OldNumEvent = 3.2;
							break;
						} else {
							if (sd.CustomFlag > 7) {
								sd.SlaveType = -4;
								Backgrounds.ShowOverlay(0);
								AddText("#slavesee an empty cage, it appears to the be the one where #slaveheshe saw the spiderwoman. The inside is heavily damaged and there is rubble and debris in the cell. As #slaveheshe is looking a guard walks over and tells #slavehimher to move on. The guard explains that the slave is gone, freed in the deep woods, but she was very ill and badly injured. The guard hopes the slave will live but it is clear that they do not believe it.");
								break;
							}
						}
						// Later visits
						coreGame.ShowSlave(sd, 1, 0, sd.SlaveGender == 3 ? 2 : 1);
						AddText("#slave again " + coreGame.NonPlural("see") + " the spiderwoman in her cage, pacing and glaring at #slave. #slave can see the woman is still present, and clearly not sold yet.");
						
					} else {
						
						// Never seen before
						sd = SMData.SetSlaveOwned("Arak", false);		// creates the slave record
						sd.SlaveType = -200;
						sd.CustomFlag = 0;		// count down
						if (coreGame.IsDickgirlEvent()) sd.SlaveGender = 3;		// is a dickgirl
						
						ShowPerson(9, 0, 1, 1);
						AddText(coreGame.SlaveVerb("hear") + " a strange skittering noise and " + coreGame.NonPlural("look") + " and #slaveheshe" + coreGame.NonPlural(" see") + " a monstrous woman in a cage, a human body on a large spider's body. She is skittering back and forth in her cage looking nervous and impatient and maybe even a little afraid.");
						coreGame.ShowSlave(sd, 1, 0);
						if (sd.SlaveGender == 3) AddText("The spider woman turns and looks at #slave and #slave clearly " + coreGame.NonPlural("see") + " the woman has a semi-erect cock!");
						AddText("\r\r" + coreGame.SlaveVerb("step") + " towards the spider woman to try and talk to her and " + coreGame.NonPlural("feel") + " a hand on " + coreGame.SlaveHisHer + coreGame.Plural(" shoulder") + " and " + coreGame.NonPlural("see") + " a woman, ");
						if (!coreGame.LadyFarun.IsMet()) AddText("who introduces herself as Lady Farun");
						else AddText("it is the alluring Lady Farun");
						AddText(", who says,\r\r");
						PersonSpeakStart(9, "No, do not approach too near. She is very upset and dangerous. Even in the cage she will try to hurt you if she can.\r\rDo you know of her kind? No? I know something of them, but I do not trade in their kind. She belongs to a rare folk who lives in the deepest forests and they seem to possess simple minds, interested only in breeding and food. They seek us humans for <i>both</i>, as you see she can mate with a human, and you can also see her very, very sharp teeth. They are quite venomous, secreting poisons to kill, paralyse and I hear even for mating. There are males of her kind but they look like huge spiders. The women vary a lot in appearance, it maybe who they mate with, their males or ours...", true);
						if (sd.SlaveGender == 3) AddText("\r\rAs you see she has a cock, I do not know if this is usual or rare for her kind, maybe a parent of hers mated with a hermaphrodite. The guards tell me she is always somewhat erect and that at night just before sleeping she <i>always</i> masturbates over and over and over...");
						PersonSpeakEnd("\r\rThey take very poorly to captivity and seem impossible to train or tame. I heard this one was caught by a special request for a particularly jaded nobleman seeking a new thrill. He visited her here and took her, from what I hear to his considerable pleasure, but she bit him and he almost died from the poison. When he recovered he broke his contract, disgraceful, and left her here.\r\rHer current owner is looking for a new person to purchase her, but no-one wants her, not after the incident and also because of their reputation. I hope an owner can be found, before, well, she stops eating.", true);
						AddText("\r\r" + coreGame.SlaveVerb("watch") + " the spiderwoman pacing back and forward, feeling sorry for her and a little nervous as the woman snarls and shows her many, many sharp, pointed teeth.\r\r");
						PersonSpeak(9, "I have heard that some of the Dark Elves know the art of training these beings, or at least how to deal with them properly.", true);
						if (SMData.SMHomeTown == 6) AddText("\r\rOdd, this must be a rare training, you do not recall ever hearing about fellow Dark Elves with such skills.");
					}
					break;
					
				case 3:
					// Lamia
					coreGame.Bars._visible = false;
					coreGame.OldNumEvent = 3.4;
					Language.XMLData.XMLEventByNode(Language.XMLData.GetNode(coreGame.walkNode, "DocksSlavePensSecure"), true, "VisitMonster/Lamia");
					if (this.IsEventRepeatable("Lamia") && this.GetEventTotal("Lamia") < 6) this.SetEventDone("Lamia");
					break;
					
				case 4:
					// Tentacles
					coreGame.OldNumEvent = 3.3;
					Backgrounds.ShowOverlay(0);
					coreGame.ShowMonster("tentacle", 1, 1);
					AddText(coreGame.SlaveSee + " in a strong cage a tentacle monster. ");
					if (slaveData.TotalTentacle > 0) {
						AddText(coreGame.SlaveHeSheUC + coreGame.NonPlural(" remember") + " #slavehisher assault");
						if (slaveData.TotalTentacle > 1) AddText("s");
						AddText(" by such a creature and #slavehisher incredible orgasms. ");
						if (slaveData.TotalTentacle > 4) AddText("The creature writhes and reaches for #slave who quickly retreats.");
					}
					AddText("\r\r#slave leaves the thing but feels a strong wave of arousal.");
					break;
			}
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0);
			return true;
			
		case "NobleParty-4":
			coreGame.StartMoaning(1);
			coreGame.StartFucking(2);
			temp = Math.floor(Math.random()*(1 + coreGame.TentaclesOn));
			coreGame.Bars._x = 300;
			coreGame.Bars._visible = true;
			if (temp == 0) {
				ShowMovie("SlaveMarket/WalkSlavePens", 1, 5, 11);
				coreGame.OldNumEvent = 4.1;
				AddText(coreGame.SlaveSee + " a group near a cage. It is a small group, all bearing the crests of a noble house.\r\rShe moves near and sees ");
				AddText("a noblewoman in a cage with several beings, humanlike but not human. Guards are leering at the scene, #slave looks closer and sees why. The beings are fucking the woman who is moaning. Cum coats her so it seems this is not her first fucking. Everything from the scene shows she is in control and here to enjoy these beings lusts.");
				AddText("\r\r#slave turns to leave and hears the noblewoman cry out another orgasm. #slave cannot help but feel aroused.");
			} else {
				coreGame.OldNumEvent = 4.2;
				coreGame.Tentacles.NobleWomanTentacleSex();
			}
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0);
			return true;
		
		case "FarunRescue-5":
			this.NoRepeatEvent("FarunRescue-5");
			coreGame.LadyFarun.SetBitFlag(64);
			coreGame.LadyFarun.SetBitFlag(69);
			coreGame.LadyFarun.DaysUnavailable = 2;
			coreGame.LadyFarun.SMFlag = 0.1;		// trigger addiction
			
			// select variant
			temp = Math.floor(Math.random()*2);
			if (coreGame.Tentacles.IsTentacleEvent()) temp = 2;
			var str:String = "FarunRescueOgreStart";
			if (temp == 1) str = "FarunRescueLizardManStart";
			else if (temp == 2) str = "FarunRescueTentaclesStart";
			
			Language.XMLData.XMLEventByNode(Language.XMLData.GetNode(coreGame.walkNode, "DocksSlavePensSecure"), true, str);
			return true;
		}
		
		return false;
	}
	
	private var intervalId:Number;
	
	public function StartDemonGirlCum()
	{
		intervalId = setInterval(this, "DemonGirlCum", 1000, coreGame.lastmc, int(coreGame.lastmc._x));
	}
	
	public function DemonGirlCum(target_mc:MovieClip, origx:Number) {
		clearInterval(intervalId);
		var oldx:Number = target_mc._x;
		if (target_mc._x > origx) target_mc._x = origx - 30;
		else target_mc._x = target_mc._x + 30;
		if (target_mc._x != origx) intervalId = setInterval(this, "DemonGirlCum", 60, target_mc, origx);
		else {
			ShowPerson(33, 1, 3, 5);
			if (coreGame.DemonicBraWorn == 1 || coreGame.DemonicPendantWorn == 1) {
				if (coreGame.BitFlag1.CheckBitFlag(5)) {
					AddText("\r\rThere is a rush of heat in the " + itemstr + "#slaveis wearing and immediately " + coreGame.SlaveHeSheIs + " filled with lust and visions of being fucked by large demonic girl cocks. She is aware the demon girl is masturbating again and feels uncontrollably drawn to her again. She reluctantly staggers over, kneels down and opens her mouth wide.");
					AddText("The demon girl is close to cumming when a woman grabs her hand and pulls it away. The demon girl screams a curse and the woman re-binds her hand. She walks over to #slave and gently shakes her and she snaps to her senses. The woman explains how these girls gain power through orgasm and by leeching power from others.\r\rShe walks over and places a tight ring around the base of the demon girl's cock, explaining that it will prevent her cumming. She then fits the girl with a ball-gag and a set of vibrator panties to stimulate her, mainly for punishment, and she sets them at maximum. The demon girl moans and thrusts her cock trying to cum but failing.\r\r");
					if (coreGame.VibratorPantiesOK == 0) {
						AddText("The woman offers #slave a set of vibrator panties for her personal enjoyment. #slave can see the demon girl is not particularly enjoying hers though.\r\r");
						coreGame.VibratorPantiesOK = 1;
					}
					AddText("As #slave leaves she sees the woman slowly lowering herself onto the demon girl's cock...");
				} else {
					AddText(" She looks passionately at #slave and cums a huge spray of cum.\r\rThere is a rush of heat in the " + itemstr + "#slave is wearing and immediately she is filled with lust and visions of being fucked by large demonic girl cocks. She is aware the demon girl is masturbating again and feels uncontrollably drawn to her. She staggers over, kneels down and opens her mouth wide. #slave feels waves of lust that seem to match the demon girl's strokes of her cock.");
					AddText("The demon girl screams out and cums again, the chain on her wrist snaps, and she pours her spurting cum into #slave's mouth, who automatically tries to swallow all of it. As she swallows she feels an enormous pleasure and orgasms intensely.\r\rWhen she recovers she feels very tired, has cum over her face and the demonic girl is gone.");
				}
			} else {
				if (coreGame.BitFlag1.CheckBitFlag(5)) {
					AddText("\r\rThe girl talks about power and dominance and then starts masturbating again, quickly. #slave grabs her hand to stop her, remembering what happened last time.");
					AddText("They struggle for a bit and another hand reaches in and helps pull the demon girl's hand free. The demon girl screams a curse and #slave sees a woman helping who re-binds the demon girl's hand. The woman thanks #slave and explains how these girls gain power through orgasm and by leeching power from others.\r\rShe then places several tight rings around the base of the demon girl's cock, explaining that it will prevent her cumming, no matter what. She then fits the girl with a ball-gag and a set of vibrator panties to stimulate her, mainly for punishment, and she sets them at maximum. The demon girl moans and thrusts her cock trying to cum but failing.\r\r");
					if (coreGame.VibratorPantiesOK == 0) {
						AddText("In thanks the woman offers #slave a set of vibrator panties for her personal enjoyment. #slave can see the demon girl is not particularly enjoying hers though.\r\r");
						coreGame.VibratorPantiesOK = 1;
					} else {
						AddText("In thanks the woman pays #slave an amount of gold.");
						Money(100 - (coreGame.Difficulty * 10));
					}
					AddText("As #slave leaves she sees the woman slowly lowering herself onto the demon girl's cock...");
				} else {
					AddText("\r\rThe demon girl slowly speeds up and with a shout cums a large spray of cum. The chain on her wrist snaps and when she stops cumming smiles and looks at #slave and gestures. #slave feels a wash of confusion and feels vague for a while. When she recovers, she is bent over a wall, her ass feels a bit sore and she tastes cum. She can feel cum leaking from pussy and ass. The demonic girl is gone.");
				}
			}
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0);
		}
	}
	
}