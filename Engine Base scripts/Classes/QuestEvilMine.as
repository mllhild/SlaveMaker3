// Evil Mine Quest
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class QuestEvilMine extends Place
{
	public var EvilMineFlag:Number;
		
	public function QuestEvilMine(nn, mc:MovieClip, cg:Object, id:Number, access:Boolean, swf:String, mxpos:Number, mypos:Number, cc:City)
	{
		super(nn, mc, cg, id, access, swf, mxpos, mypos, cc);
		EvilMineFlag = 0;
	}
	
	public function IsStartedSpecialEvent(num:Number) : Boolean { return EvilMineFlag > 0; }
	public function IsCompleteSpecialEvent(num:Number) : Boolean { return EvilMineFlag < 0; }

	public function DoEvilMine()
	{
		trace("DoEvilMine: " + EvilMineFlag);
		ShowPlanningNext();
		
		ShowSupervisor();
		if (EvilMineFlag == -1) {
			// trace("abandoned");
			AddText("You, #slave and #assistant return to the mine. You see no activity at all. You search for a long time but find no sign of the girls or the zombies. You find several dead zombies from your last encounter, but nothing else.\r\rSadly you return home, unable to find where the girls have gone, remembering their cries of pain and ecstasy.");
			ClearBitFlag(2);
			EvilMineFlag = -10;
			return;
		}
		if (CheckBitFlag(2)) AddText("#slave follows Lady Farun's directions and reaches the ruins without challenge.\r\r");
		AddText("#slavesee an odd looking wagon near the ruins with a large man in a cloak loading what looks like rocks or maybe ore. Even from this distance #slaveheshe can smell a horrible odour from the man.\r\rLooking back #slaveheshe can see a dark cave with some sort of activity. ");
		if (Supervise) AddText("You whisper to be cautious, and you advance...");
		else AddText("#super whispers to be cautious, and they advance...");
		Backgrounds.ShowCave(1);
		DoEvent(4100);
		EvilMineFlag = 1;
		
		var monAttack:Number = 75 + (Math.floor(Math.random()*(6 + coreGame.Difficulty)) * 2);
		var monDefence:Number = 45 + (Math.floor(Math.random()*(6 + coreGame.Difficulty)) * 2);
		var monHealth:Number = 65 + (Math.floor(Math.random()*(6 + coreGame.Difficulty)) * 2);
		var monSpeed:Number = 40;
	
		var actno:Number;
		if (coreGame.Difficulty > -1) actno = 4133;
		else actno = 4131;
	
		coreGame.InitialiseCombat("You enter the mine and see several shambling shapes advance, zombies, the living dead.", 4132, 4130, actno, actno);
		
		coreGame.AddMonster(new MonsterZombie(monAttack, monDefence, monHealth, monSpeed, "Zombie"));
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
		// 4100 - Evil Mine Start
		 case 4100:
			SetBitFlag(0);
			SetBitFlag(1);
			DoEvent(4199);
			ShowMovie(mcBase.WalkRuinedTemple, 1, 0, 1);
			ShowDressSmall();
			if (Supervise) AddText("#slave and #supername approach the tunnel and see a pair of bound girls pulling a cart of some sort. They seem to be being used to work a mine of some sort. They are tightly bound with gags, leather harnesses, large nipple piercings and their arms are bound behind their backs. Large dildos are secured somehow to their leggings and as they walk the dildos thrust in and out in time with their steps.\r\rOne of them lets out a muffled cry and stumbles, ");
			if (coreGame.DocksSlavePens.CheckBitFlag(34) || coreGame.DocksSlavePens.CheckBitFlag(37)) AddText("and #slave can clearly see it is Sareth, ");
			AddText("looking bruised, dirty, but flushed with passion. The other girl is not familiar but she looks dirtier with many welt marks and bruises on her skin.\r\rA sudden crack startles #slave as a whip hits ");
			if (!coreGame.DocksSlavePens.CheckBitFlag(35)) AddText("Sareth");
			else AddText("the fallen girl");
			AddText(". #slave looks and sees a horrible, skeletal creature holding a cruel whip, who whips her again. She gets up and they move on pulling the cart, sweat glistening on their skin. As they move away #super whisper that they also have uncomfortably large plugs in their asses...\r\r");
			if (coreGame.SlaveGirl.EvilMineStart() != true) {
				AddText("#slaveis desperate to help but realises #slaveheshe cannot do anything here, especially against the living dead. The living dead have a fearsome, terrible reputation for huge strength (and other disgusting things).\r\r");
				if (Supervise) AddText(coreGame.SlaveHeSheUC + NonPlural(" know") + " #slaveheshe needs your help but suggests that you seek other assistance.\r\rYou withdraw and");
				else AddText(coreGame.SlaveHeSheUC + NonPlural(" know") + " #slaveheshe needs to ask you for help but it is possible to seek other assistance.\r\rThey withdraw and both");
				AddText(" can see other moving shapes deep in the mine, and hear a girl cry out in a strange, mixed cry of pain and passion..");
			}
			return true;
			
		// docks
		case 4101:
		case 4102:
		case 4103:
			if (coreGame.BountyHunter.IsMet()) {
				EvilMineFlag = 2;
				coreGame.Combat.SMCurrentAttack = coreGame.Combat.SMCurrentAttack + 35;
				coreGame.Combat.SMCurrentDefence = coreGame.Combat.SMCurrentDefence + 15;
				ShowPerson(12, 1, 0, 2);
				AddText(SlaveVerb("think") + " of looking for the beautiful bounty hunter, Irina, and asks after her. Quickly " + SlaveVerb("find") + " Irina relaxing in a bar and explains. Irina looks worried but says she will help ");
				if (coreGame.BountyHunter.CheckBitFlag(0)) AddText("as #slave is a friend.");
				else {
					AddText("but the dead are dangerous and asks a fee from #slavehisher Slave Maker of 300GP, or whatever can be afforded.");
					if (!coreGame.BountyHunter.CheckBitFlag(32)) Money(-300, false, true);
				}
				AddText("\r\rIrina quickly gets some things and they run to the ruins...");
			} else {
				AddText(SlaveVerb("look") + " around the docks in general. " + NameCase(coreGame.SlaveHeSheHas) + " heard of some guards and some bounty hunters that have been seen there, but " + SlaveVerb("find") + " no-one that will help.\r\r" + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			}
			DoEvent(4120);
			return true;
		
		// try farm
		case 4104:
			SetText(SlaveVerb("look") + " around the farm to find some farm-hands or hunters but finds no-one." + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
	
		// try forest
		case 4105:
			SetText(SlaveVerb("look") + " around the forest to find some woodsmen or hunters but finds no-one.\r\r" + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
	
		// try lake
		case 4106:
			EvilMineFlag = 5;
			if (SMData.Corruption < 50) coreGame.Combat.SMCurrentDefence = coreGame.SMCurrentDefence + 40;
			SetText(SlaveVerb("run") + " to the lake, the pure waters of the lake are rumoured to ward against many forms of evil. #slave collects a bottle and liberally washes #slavehimherself.\r\r" + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
			
		// try palace
		case 4107:
			SetText(SlaveVerb("run") + " to the Palace hoping to find a guard or military officer or a knight. #slave starts asking around and notices a few shocked looks.\r\rA couple of palace guards step up to #slavehimher and escort #slavehimher out of the Palace. They inform #slavehimher the Chancellor has ordered that #slaveheshe is not allowed access to the Palace anymore!\r\rShocked " + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			coreGame.Palace.SetAccessible(false);
			DoEvent(4120);
			return true;
			
		// try town center
		case 4108:
			SetText(SlaveVerb("look") + " around the town center for someone to help but #slaveheshe has no luck in the crowd of people.\r\r" + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
	
		// try slums
		case 4109:
			ShowPerson(38, 0, 0);
			EvilMineFlag = 3;
			coreGame.Combat.SMCurrentDefence = coreGame.Combat.SMCurrentDefence + 5;
			coreGame.Combat.SMCurrentAttack = coreGame.Combat.SMCurrentAttack + 10;
			Money(-50);
			SetText(SlaveVerb("run") + " to the slums, and hires a couple of thugs to help, #slaveheshe doubts they will be much help.\r\r" + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
			
		// try dealer
		case 4110:
			SetText(SlaveVerb("run") + " to the drug dealer, maybe he has a drug or potion to help. He says plainly that he does not sell things like that.\r\r " + NameCase(SlaveVerb("run")) + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
	
		// try seer
		case 4111:
			coreGame.TakeAWalkMenu._visible = false;
			Backgrounds.ShowBath(1);
			ShowPerson(43, 1, 1);
			SetText(SlaveVerb("run") + " to the seer, hoping she has some arcane knowledge of the living dead. The seer says that she does not, but knows a medium who can and they walk to the baths.\r\rThe seer introduces her to Misana an oddly dressed woman, ropes tied over her clothes in a suggestive way. She looks relaxed and has just finished her bath. #slave explains her need, and Misana states, as a matter of fact,\r\r");
			PersonSpeak(43, "I am intimately familiar with the dead and their ways. The dead do not belong in this world, and are bound to the basest part of their living life.\r\rI guarantee I can put the wretches to peace. My fee is 1000GP.", true);  
			AddText("\r\rDoes #slave hire her?\r\r");
			DoYesNoEventXY(4115);
			return true;
			
		// try salesman
		case 4112:
			EvilMineFlag = 4;
			if (SMData.Corruption < 50) coreGame.Combat.SMCurrentDefence = coreGame.Combat.SMCurrentDefence + 30;
			SetText(SlaveVerb("run") + " to the salesman, maybe he has an item that can help. He says he has nothing for sale but gives #slavehimher a small holy item, to hopefully protect #slavehimher.\r\r" + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
	
		// try slave market
		case 4113:
			SetText(SlaveVerb("run") + " to the slave market, maybe a guard or other slave maker will help. At the entrance a guard forbids #slavehimher entry, " + coreGame.SlaveHeSheIs + " only an unaccompanied slave.\r\rFrustrated, " + SlaveVerb("run") + " back to the ruins as fast as #slaveheshe can...");
			DoEvent(4120);
			return true;
	
		// try lake
		case 4114:
			SetText(SlaveVerb("run") + " to the beach, but there are only people playing, no-one is interested in helping\r\rFrustrated, " + SlaveVerb("run") + " back to the mine...");
			DoEvent(4120);
			return true;
			
		// try Astrid
		case 4115:
			SetText(SlaveVerb("run") + " to Astrid's home, but she does not seem to be home.\r\rFrustrated, " + SlaveVerb("run") + " back to the mine...");
			DoEvent(4120);
			return true;
			
		// meet up
		case 4120:
			coreGame.HidePeople();
			coreGame.HideImages();
			HideBackgrounds();
			coreGame.TakeAWalkMenu.Ruins._visible = true;
			Backgrounds.ShowCave(1);
			
			if (Supervise) {
				AddText("You hurry home and explain to #assistant about the mine in the ruins, and about #slave's determination to rescue the girls held there. You get ");
				if (coreGame.WeaponType != 0) AddText("your #weapon");
				else AddText("some gear");
				AddText(" and go as fast as possible to the mine in the ruins with #assistant.\r\r");
	
			} else {
				AddText("#assistant runs in and breathlessly explains to you about the mine in the ruins, and about #slave's determination to rescue the girls held there. After some thought you agree that something should be done. You get ");
				if (coreGame.WeaponType != 0) AddText("your #weapon");
				else AddText("some gear");
				AddText(" and go as fast as possible to the mine in the ruins with #assistant.\r\r");
			}
			AddText("You arrive in the afternoon, seeing no sign of patrols or other people. You survey the mine and a little while later #slave arrives ");
			switch(EvilMineFlag) {
				case 2:
					AddText("with the beautiful bounty hunter Irina. She promises to fight by your side and she carries a large weapon");
					break;
				case 3: 
					AddText("with a couple of thugs, looking tough but maybe a little scared when the living dead are mentioned");
					break;
				case 4:
					AddText("and offers you a holy symbol the help protect you. ");
					if (SMData.Corruption < 50) {
						if (SMData.SMFaith != 1) AddText("You apologise but it is not of your gods and refused to wear it");
						else AddText(" You happily put it on");
					} else AddText(" You look at it and refuse to wear it");
					break;
				case 5:
					AddText("and offers some of the pure waters of the holy lake.");
					if (SMData.Corruption < 50) AddText(" You wash ritually in the water to purify yourself. hoping it will protect against the evil of the mine");
					else AddText(" You look at it and tell #slavehimher to use the water #slavehimherself");
					break;
				case 6:
					AddText("with the medium Misana. She smiles and tells you she will put them to rest");
					break;
			}
			AddText(".\r\rYou order #slave to stay at the rear and ask #assistant to guard #slavehimher. As a group you advance to the cave.\r\rYou see no movement near or in the mine and the wagon is long gone. You can hear muted noises from deep inside.\r\rYou enter the mine tunnel...\r\r");
			DoEvent(4121);
			return true;
			
		case 4121:
			ShowMovie(mcBase.WalkRuinedTemple, 1, 0, 2);
			coreGame.Sounds.StartMoaning(1);
			AddText("You pass along tunnels, mostly long, long disused, partially filled with rubble and dust. A few areas show some signs of crude working, and there are footprints everywhere. Your only guide is the low sounds in the distance, so you follow the sound, until you reach a dimly lit room and see a horrible, disgusting sight.\r\rA band of the living dead, zombies, are swarming over the girls ");
			if (Supervise) AddText("you and #slave");
			else AddText("#slave and #assistant");
			AddText(" saw earlier. Some memory of their life must remain in their decayed flesh and they are trying to satisfy their lust on the girls. Some of the creatures are too far gone, dust is the only thing that remains of their genitals.\r\rOthers are fresher and you can see one is forcing a girl to give him a blowjob. Another is behind, fucking her crudely. The girl is dirty and bruised but seems oddly enthusiastic, almost enjoying her fucking. As you look on disgusted, the zombie fucking the girl thrusts in, obviously cumming, making no noise than a dry sighing. It pulls out and another zombie pushes it aside and tries to push it's cock into the girl's ass.");
			AddText("\r\rYou hear a muffled scream, and you see the other girl");
			if (!coreGame.DocksSlavePens.CheckBitFlag(35)) AddText(", Sareth,");
			AddText(" is being roughly fucked by many zombies, decayed but hard cocks pounding her pussy and ass. A zombie is fucking it's cock between her breasts and she is crying out in pain and horror, muffled by another cock in her mouth. As you watch the one in her mouth pulls out and spews a disgusting liquid over her face, immediately followed by the one between her breasts, spraying jets of equally disgusting cum over her face.\r\rThe first girl screams out, orgasming as the cock in her mouth spews its foul load into her throat.\r\r");
			if (EvilMineFlag == 6) {
				AddText("Misana tells you to wait, she will deal with them...");
				DoEvent(4122);
			} else {
				AddText("Horrified, you");
				switch(EvilMineFlag) {
				case 2:
					coreGame.HideAssistant();
					ShowPerson(12, 0, 2, 1);
					AddText(" and Irina");
					break;
				case 3: 
					ShowPerson(38, 0, 0);
					AddText(", followed by the thugs,");
					break;
				}
				AddText(" attack...");
				SMData.SetHealth();
				DoEvent(3000);
			}
			return true;
		}
			
		switch(coreGame.NumEvent) {
		case 4122:
		case 4130:
			if (coreGame.NumEvent == 4122) {
				mcBase.Walk_visible = false;
				Backgrounds.ShowCave(1);
				coreGame.Sounds.StopAllSounds();
				coreGame.Sounds.PlaySound("WhipCrack");
				Backgrounds.ShowTunnels(9);
				ShowPerson(43, 1, 4);
				SetText("Misana advances, she turns and smiles, and the ropes binding her body writhe and ripple. They erupt and whip, striking all the zombies. The zombies collapse, unmoving, motionless dead bodies once again.\r\r");
				AddText("You advance and pull the motionless zombies from the girls. One girl looks distressed and bewildered, after a bit you find out she has been captive here for a long time. She is unsure how long, maybe years, and had come to enjoy in some way the fucking, beating and harsh treatment.\r\rThe other girl");
			} else {
				SetText("The last zombie has fallen. #slave runs up to the girls. One girl looks distressed and bewildered, after a bit you find out she has been captive here for a long time. She is unsure how long, maybe years, and had come to enjoy in some way the fucking, beating and harsh treatment.\r\rThe other girl");
			}
		
			if (coreGame.DocksSlavePens.CheckBitFlag(34) || coreGame.DocksSlavePens.CheckBitFlag(37)) AddText(", Sareth,");
			AddText(" is newly arrived and is crying and thanking ");
			if (coreGame.DocksSlavePens.CheckBitFlag(34) || coreGame.DocksSlavePens.CheckBitFlag(37)) AddText(SlaveName);
			else AddText("you");
			AddText(" for rescuing her from the pain and forced pleasure of the harnesses and dildos and their cocks.\r\r");
			if (coreGame.CombatDifficulty != -1) {
				coreGame.VibratorPantiesOK = 1;
				coreGame.BitGagOK = 1;
				if (coreGame.HarnessOK == 0) coreGame.HarnessOK = 1;
				coreGame.PonygirlAware = 1;
				SMData.PonygirlAware = 1;
				AddText("You find in the room two sets of harnesses, two bit-gags, two pony-tails and two odd versions of dildo panties/vibrator panties. You take all these items, but when you examine the pony-tails you see that are cruel devices with barbs designed to hurt the wearer. Wisely you abandon these devices of pain");
				if (SMData.IsDominatrix()) AddText(", there are plenty of ways to hurt someone and not cause so much injury");
				AddText(".");
			}
			AddText("\r\rSometime later you all return home, including the rescued girls. You decide eventually to give the girls their freedom if they want.\r\rOne girl");
			if (!coreGame.DocksSlavePens.CheckBitFlag(35)) AddText(", Sareth,");
			AddText(" joyously thanks you promising to return to her distant home as soon as she can.");
			if (coreGame.DocksSlavePens.CheckBitFlag(34)) AddText(" #slave gives Sareth a teddy bear, saying she is returning it, her friend from the Slave Pens held it. Sareth starts crying, happy, joyous tears.");
			else if (!coreGame.DocksSlavePens.CheckBitFlag(35) && coreGame.TotalTeddyBear > 0) AddText(" #slave gives Sareth a teddy bear, saying she is sorry she could not give her one before. Sareth starts crying, happy, joyous tears.");
			AddText("\r\r#slave thanks you for saving the girls, blushing as she says so.");
			Points(0, 2, 0, 0, 0, 1, 0, 0, 2, 0, 0, 2, 2, 1, 3, 0, 10, 5, 5, 0);
			Diary.AddEntry("You rescued Sareth from the evil mine.");
	
			EvilMineFlag = 0;
			SetBitFlag(41);
			ClearBitFlag(2);
	
			AddText("\r\rThe girl who had been long captive, is somewhat confused and even has trouble remembering her own name. After a little she tells you her name is 'Deala' and asks to remain a slave. She does not directly say but you know she wants to be whipped, beaten, fucked. ");
			if (SMData.IsDominatrix()) AddText("You promise her all the pain and pleasure you can enjoy and she <i>might</i> tolerate. The girl looks a little frightened but also happy.");
			else AddText("You promise to locate an appropriate Master or Mistress for her.");
	
			AddText("\r\rDo you want to keep Deala for yourself, otherwise you will sell her at auction under the condition of strict bondage?");
			DoYesNoEventXY(4140);
			return true;
			
		// lose rescued
		case 4131:
			coreGame.HideImages();
			Backgrounds.ShowCave(1);
			coreGame.ShowMovie(coreGame.OnTopOverlay, 1, 0);
			if (coreGame.tempstr == "") {
				if (coreGame.Difficulty > -1) AddText("You pass out from the pain...");
				else AddText("You collapse to the ground filled with pain.");
			}
			var say:String = "\r\rYou awaken some time later outside the cave and see #slave";
			switch(EvilMineFlag) {
				case 2:
					if (coreGame.Difficulty > -1) say = say + " and Irina. #slave tells you that they were almost overwhelmed when you fell and had to run. Once Irina had got #slave to safety she returned back and found you, and freed you from the zombies, dragging you free.";
					else say = say + " and Irina. #slave tells you that Irina pulled you free of the zombies when you fell and saw there was no hope of winning.";
					ShowPerson(12, 0, 2, 1);
					break;
				case 3: 
					ShowPerson(38, 0, 0);
					if (coreGame.Difficulty > -1) say = say + " and one of the thugs. #slave tells you that they were almost overwhelmed when you fell and had to run. Once the thug had got #slave to safety he returned back and found you, and freed you from the zombies, dragging you free.";
					say = say + " and one of the thugs, the other fled in terror at the start of the fight. She tells you she pulled you free while thug held off the zombies briefly and they ran.";
					break;
				default:
					if (coreGame.Difficulty > -1) say = say + " and #assistant and they tell you that they were almost overwhelmed when you fell and had to run. Once #assistant had got #slave to safety she returned back and found you, and freed you from the zombies, dragging you free.";
					else say = say + " and #assistant and they tell you they were able to pull you free once you fell. They carried you out of the cave.";
					break;
			}
			say = say + "\r\rThe last they saw the zombies were dragging the girls deeper into the mine. You are determined to return the following day to try again.";
			EvilMineFlag = -1;
			Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 8, -5, 0, 0);
			coreGame.StartFadeImage(50, coreGame.OnTopOverlay, say);
			Diary.AddEntry("You tried to rescue Sareth from the evil mine but failed.");
			ShowPlanningNext();
			return true;
	
		// run away
		case 4132:
			coreGame.HideImages();
			Backgrounds.ShowCave(1);
			Diary.AddEntry("You tried to rescue Sareth from the evil mine, but fled from the zombies.");
			SetText("You decide you cannot win and tell the others to run, you bring up the rear holding the zombies briefly off and the run out of the mine.");
			AddText("\r\rThe last you saw the zombies were dragging the girls deeper into the mine. You are determined to return the following day to try again.");
			EvilMineFlag = -1;
			Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 8, -5, 0, 0);
			ShowPlanningNext();
			return true;
			
		// lose
		case 4133:
			HideBackgrounds();
			EvilMineFlag = -1;
			coreGame.HideImages();
			Backgrounds.ShowOverlay(0);
			AddText("You collapse to the ground filled with pain.");
			coreGame.HideEventNext();
			ResetEventPicked();
			if (SMData.Gender == 1) coreGame.Sounds.StartFucking(3);
			else coreGame.Sounds.StartFucking(1);
			Timers.AddTimer(
				setInterval(this, "ShowAfterLoss", 2000, coreGame.Timers.GetNextTimerIdx())
			)
			coreGame.HouseEvents.Exploring = new HouseExplore(1);
			return true;
			
		// lose - bad end
		case 4135:
			HideBackgrounds();
			coreGame.HideImages();
			Backgrounds.ShowOverlay(0);
			AddText("You collapse to the ground filled with pain.");
			var say:String = "\r\rYou awaken some time later filled with pain ";
			DoEvent(9800);
			coreGame.HideEventNext();
			say = say + "and you see you are in some unknown chamber, the captive girls are near, freed of their bindings, but look confused, drugged most likely.\r\rYou feel a large thing plugging you ass, very large and deeply in. Your pussy is filled with an even larger dildo that seems to be softly humming or vibrating.";
			if (SMData.Gender == 3) say = say + " Your cock is very tightly bound in some way, you look and see a cage surrounding it preventing anyone touching it and there is a tight ring around it's base.";
			say = say + "\r\rYou try to call out and realise your mouth is gagged with a bit gag. You struggle trying to get free and as you move you feel the dildo in your pussy moving, sliding in and out, in time with your movement. The other girls watch, a bit dazed, and you see they are covered in dirt and bruises. One of them says 'Welcome to your new home, don't worry, they will be here to fuck us soon'";
			ShowMovie(mcBase.WalkRuinedTemple, 1, -10, 5);
			coreGame.StartChangeImage(2000, mcBase.WalkRuinedTemple, 5, say, undefined, coreGame.NextEvent);
			return true;
	
		case 4199:
			HideBackgrounds();
			coreGame.HideImages();
			ResetEventPicked();
			coreGame.NextEvent._visible = false;
			if (Supervise) {
				SetText("You will return home and get #assistant");
				if (coreGame.WeaponType != 0 ||coreGame.ArmourType != 0) AddText(" and equip yourself");
			} else SetText("#assistant says #assistantheshe will ask you to help");
			AddText(", meanwhile #slave will try to get other help.\r\rWhere will #slaveheshe go?");
			coreGame.currentCity.ShowTakeAWalkMenu(true);
			coreGame.TakeAWalkMenu.Ruins._visible = false;
			return true;
		}
		return false;
	}
	
	public function ShowAfterLoss(timer:Number)
	{
		Timers.RemoveTimer(timer);
		
		coreGame.HouseEvents.Exploring = null;
		if (SMData.Gender == 1) ShowMovie(mcBase.WalkRuinedTemple, 1, 1, 4);
		else ShowMovie(mcBase.WalkRuinedTemple, 1, 10, 3);
		var say:String = "\r\rYou awaken some time later filled with pain ";
		if (SMData.Gender == 1) {
			say = say + "and feel bite marks and claw marks all over. You see one of the captive girls push a zombie off of you and cover your body with hers. She says something about distracting them, pulling zombie hands from you. You see her grab a zombie cock and put it in her mouth. Despite the pain, your cock starts to stiffen, then you feel to grab it and stroke it to full hardness. She straddles you and mounts your cock slowly fucking you and sucking the zombie.\r\rAbruptly she is pulled off you, you fear they are after you, but she is just flipped over and a zombie thrusts into her pussy. You feel a hand, hers, a zombies, grab your cock and shove it into her ass. The zombies fuck her on top of you, their cocks in her mouth and pussy, and you involuntarily fuck her ass. After a while, you feel your orgasm building, and the feel her shudder and orgasm. Moments later you peak and cum into her ass.\r\r";
			if (coreGame.BadEndsOn) {
				SetEvent(9800);
				say = say + "You feel a huge pain as you head is smashed and you breathe your last.\r\rSometime later your corpse rises to join the ranks of the guardians...";
			} else {
				say = say + "You feel a huge pain as something hits your head...";
				SetEvent(4131);
			}
		} else {
			say = say + "and the presence of a cold body on you. You see a zombie lying on you and the feel a cold, unnaturally hard cock enter your pussy. ";
			if (SMData.Gender == 3) say = say + "Your cock is pressed hard between you and the zombie, and to your embarrassment it is hard and erect. ";
			say = say + "The zombie is disgusting and foul smelling, but fucks hard and fast, making little noise. Despite your pain and the situation, long before the zombie ";
			if (SMData.Gender == 3) say = say + "you erupt and cum, spurting cum between your bodies";
			else say = say + "you orgasm, a long shuddering climax";
			say = say + ". The zombie pays no attention and continues fucking, eventually thrusting deep and you feel a cold eruption of cum in your womb.\r\rThe zombie stands and you move to get free and another knocks you to the ground with inhuman strength. You are held down, face down, and then its cold, rock-hard cock impales your ass...\r\rZombie after zombie fuck you, filling your pussy and ass over and over again with their cold cum. You have orgasm after unwilling orgasm until finally the exhaustion and your injuries become too much...";
			if (coreGame.BadEndsOn) SetEvent(4135);
			else SetEvent(4131);
		}
		SetText(say);
		coreGame.DoEventNext(coreGame.NumEvent);
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
	
			// 4115 - Hire Medium
			case 4115:
				if ((coreGame.VarGold + SMData.SMGold) > 999) {
					Money(-1000);
					EvilMineFlag = 6;
					AddText(coreGame.SlaveHeSheUC + NonPlural(" promise") + " to pay and #slaveheshe " + NonPlural("drag") + " Misana back to the mine, running.");
				} else {
					AddText(coreGame.SlaveHeSheUC + NonPlural(" remember") + " you cannot pay and " + NonPlural("run") + " back to the mine.");
				}
				DoEvent(4120);
				return true;
				
			case 4140:
				SetText("You tell Deala that she will be your slave now and promise to treat her exactly as she wants. You immediately re-bind her and replace her gag. She looks somewhat happy.");
				SMData.SetSlaveOwned("Deala");
				SMData.SetSlaveAvailable("Deala");
				coreGame.ShowSlave("Deala", 1, 1);
				Backgrounds.ShowCave(1);
				return true;
		}
		return false;
	}
	
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
						
			// 4115 - Hire Medium - no
			case 4115:
				AddText(SlaveName + NonPlural(" does") + " not believe Misana and " + NonPlural("refuse") + ".\r\r" + NameCase(coreGame.SlaveHeShe) + NonPlural(" run") + " back to the ruins.");
				DoEvent(4120);
				return true;
	
			case 4140:
				SetText("You tell Deala that that you will find a new owner who will treat her as she wants. You re-bind her and lead her to the Slave Market, and place her for sale, under condition of her being a strict bondage slave.\r\rTo your surpise she immediately sells for 500GP.");
				coreGame.SetSlaveAvailable("Deala");
				coreGame.SetSlaveOwned("Deala");
				coreGame.ShowSlave("Deala", 1, 1);
				SMMoney(500);
				return true;
		}
		return false;
	}
	
	public function InitialiseModule(mcb:MovieClip)
	{
		super.InitialiseModule(mcb);
		EvilMineFlag = 0;
	}
}