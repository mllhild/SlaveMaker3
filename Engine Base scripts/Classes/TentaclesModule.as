// Translation status: INCOMPLETE

import Scripts.Classes.*;

class TentaclesModule extends SlaveModule
{
	public var tunneltype:Number;
	public var countrescued:Number;
	public var Wander:Number;
	public var CustomE1:Number;
	public var CustomE2:Number;
	public var CustomE3:Number;
	public var CustomE4:Number;
	public var CustomE5:Number;
	public var CustomE6:Number;
	public var CustomEnd:Number;
	public var CustomF1:Number;
	public var CustomF2:Number;
	public var CustomF3:Number;
	public var CustomF4:Number;
	
	public var starte:Number;
	
	public var ClipTentacleHarem:MovieClip;
	
		
	public function TentaclesModule(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
		this.ModuleName = "Tentacles";
	}
	
	public function CanLoadSave() : Boolean { return false; }

	public function IsTentacleEncounter(haunt:Number) : Boolean
	{
		if (coreGame.TentaclesOn == 0) return false;
		if (coreGame.TentacleHaunt == int(haunt)) return true;
		if (!IsDayTime()) {
			if (slrandom(8) == 1) return true;
		}
		return false;
	}
	
	// IsTentacleEvent() : Boolean now in BaseModule
	
	public function NextCustomEvent(max:Number, base:Number, ince:Number) : Number
	{
		starte = starte + ince;
		if (starte > (max + coreGame.DickgirlOn)) starte = starte - (max + coreGame.DickgirlOn);
		var ev:Number = starte + base;
		if (ev == 14) ev = 12 + Math.floor(Math.random()*2);
		return ev;			
	}
	
	public function TentacleCombat(strong:Boolean, desc:String)
	{
		coreGame.Sounds.StartMoaning(2);
		coreGame.Sounds.StartFucking(2);
		
		var monAttack:Number = 60 + (Math.floor(Math.random()*(4 + coreGame.Difficulty)) * 2);
		var monDefence:Number = 40 + (Math.floor(Math.random()*(5 + coreGame.Difficulty)) * 2);
		var monHealth:Number = 50 + (Math.floor(Math.random()*(5 + coreGame.Difficulty)) * 2);
		var monSpeed:Number = 55;
	
		if (strong) {
			monAttack = monAttack + 15;
			monDefence = monDefence + 10;
			monHealth = monHealth + 10;
		}
		if (coreGame.MoonPhaseDate < 2) {
			monAttack = monAttack - 10;
			monDefence = monDefence - 10;
			monHealth = monHealth - 10;
			monSpeed = monSpeed + 10;
		}
		if (slaveData.BitFlag1.CheckBitFlag(16)) {
			monAttack = 1;
			monDefence = 1;
			monHealth = 1;
		}
		coreGame.AddMonsterTentacle(monAttack, monDefence, monHealth, monSpeed, desc);
	}
	
	
	public function BreedingChamber(image:Number, dgText:String, normalText:String, slayText:String, LeftEvent:Number, RightEvent:Number, ForwardEvent:Number, BackEvent:Number) : Number
	{
		var Action1:Number;
		if (ForwardEvent == 0) Action1 = LeftEvent;
		else Action1 = ForwardEvent;
		coreGame.HideImages();
		HideBackgrounds();
		if (image < 0) {
			if (image == -15 && !coreGame.DickgirlTesticles) temp = -26;
			Backgrounds.ShowTunnels();
			if (image < -999) coreGame.SlaveGirl.ShowTentacleHaremImage(-1 * image);
			else {
				ClipTentacleHarem.gotoAndStop(-1 * image);
				ClipTentacleHarem._visible = true;
			}
			
			if (slaveData.BitFlag1.CheckBitFlag(16)) {
				SetText(slayText);
				BlankLine();
			}
			countrescued++;
			if (Wander == 1) {
				coreGame.HideAssistant();
				AddText("You send #assistant to escort the girls and to get the authorities.");
			} else AddText("You escort the girls back and give them directions out.");
			AddText("\r\rYou look at the ");
		} else SetText("You enter a ");
		if (LeftEvent == 0 && RightEvent == 0 && ForwardEvent == 0) AddText("dead-end chamber with the only way out ");
		else {
			AddText("chamber, which has exits ");
			if (LeftEvent != 0) AddText("left, ");
			if (RightEvent != 0) AddText("right, ");
			if (ForwardEvent != 0) AddText("forward, ");
		}
		AddText("back the way you came.");
		if (image == 0) {
			Backgrounds.ShowTunnelsChamber();
			AddText(" The area was cleared by you already.");
		}
		if (image > 0) {
			if (image == 15 && !coreGame.DickgirlTesticles) temp = 26;
			if (!slaveData.BitFlag1.CheckBitFlag(16)) Wander++;
			Backgrounds.ShowTentacles(1);
			if (image > 999) coreGame.SlaveGirl.ShowTentacleHaremImage(image);
			else {
				ClipTentacleHarem.gotoAndStop(image);
				ClipTentacleHarem._visible = true;
			}
			if (image > 12) AddText("\r\r" + dgText);
			else AddText("\r\r" + normalText);
			AddText(" #slave is not here.");
	
			if (slaveData.BitFlag1.CheckBitFlag(16)) {
				countrescued++;
				AddText("\r\rAs you stand there looking the creatures gently put the girls down. They slither out through small passages in the walls, leaving confused, cum soaked and heavily pregnant girls lying there.\r\r");
				return BreedingChamber(-1 * image, dgText, normalText, slayText, LeftEvent, RightEvent, ForwardEvent, BackEvent);
			} else {
				coreGame.InitialiseCombat("You enter the chamber and a creature pulls free and slides toward you.", BackEvent, coreGame.NumEvent, 125, 126);
				TentacleCombat((coreGame.MoonPhaseDate > 13 && coreGame.MoonPhaseDate < 17), "Thing"); 
				AskHerQuestions(3000, BackEvent, 0, 0, "Attack the creatures to free the girls", "Retreat and abandon them", "", "", "What will you do?");
			}
			return -image;
		}
		var Label1:String;
		if (ForwardEvent != 0) Label1 = "Forward";
		else Label1 = "Left";
		BlankLine();
		AskHerQuestions(Action1, BackEvent, RightEvent, 0, Label1, "Back", "Right", "", "Which way do you want to go?");
		return 0;
	}
	
	public function EventsAsAssistant(possible:Boolean)
	{
		if (possible && coreGame.Home.HasQuality("TentacleSafe") == false && coreGame.TentaclesOn == 1 && coreGame.Elapsed > 7) {
			if (coreGame.DoneTentacleHarem < coreGame.MaxTentacleHarem) {
				temp = 9;
				if (coreGame.MoonPhaseDate > 13 && coreGame.MoonPhaseDate < 17) temp = 3;
				temp = int(Math.random()*temp);
				if (temp == 1) {
					ServantSpeak("#slave has disappeared from our home! A frightened person who was passing by said they saw a person taken by a monster in the same area! " + coreGame.ServantPronoun + " have told the authorities.\rWill you go and search for #slave or wait for the authorities to hopefully find #slavehimher. It will cost you to search, for gear and bribes.");
					coreGame.Impregnate("Tentacle");
					coreGame.DoneTentacleHarem = coreGame.DoneTentacleHarem + 1;
					SMData.BitFlagSM.SetBitFlag(6);
					Backgrounds.ShowTentacles(1);
					ClipTentacleHarem.gotoAndStop(1)
					ClipTentacleHarem._visible = true;
					DoYesNoEvent(100);
				}
			}
		}
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		var Action1:Number;
		var Action3:Number;
		switch(coreGame.NumEvent) {
				
			// 100 - Tentacle Abduction Start
			case 100:
				LoadModule("", this);
				coreGame.HideImages();
				Backgrounds.ShowTunnels(4 + tunneltype);
				SetText("You search the tunnels for #slave, they frequently branch. You reach a point where the tunnel splits left or right.");
				if (CustomF1 == 0) {
					Action1 = 101;
					Action3 = 102;
				} else {
					Action1 = 102;
					Action3 = 101;
				}
				AskHerQuestions(Action1, Action3, 0, 0, "Left", "Right", "", "", "Which way do you want to go?");
				CustomE1 = Math.abs(CustomE1);
				return true;
		
			// 101 - Tentacle Abduction area 1 (l/r junction)
			case 101:
				coreGame.HideImages();
				Backgrounds.ShowTunnels(4 + tunneltype);
				ClipTentacleHarem._visible = false;
				SetText("You reach another point where the tunnel splits left or right, or you may return back towards the entrance.");
				if (CustomF2 == 0) {
					Action1 = 103;
					Action3 = 104;
				} else {
					Action1 = 104;
					Action3 = 103;
				}
				AskHerQuestions(Action1, 100, Action3, 0, "Left", "Back", "Right", "", "Which way do you want to go?");
				CustomE3 = Math.abs(CustomE3);
				return true;
				
			// 102 - Tentacle Abduction - Chamber E1
			case 102:
				CustomE1 = BreedingChamber(CustomE1, "This is a breeding place with several girls being assaulted by the monstrosities. You see some of the girls are hermaphrodites and the creatures appear to be harvesting their cum!", "This is a breeding chamber with several girls being assaulted by the monstrosities.", "You quickly attack and slay the monsters, freeing the girls.", 0, 0, 0, 100);
				return true;
		
			// 103 - Tentacle Abduction - Chamber E2
			case 103:
				CustomE2 = BreedingChamber(CustomE2, "You find it is a breeding place with several girls being fucked by the monstrosities. You hear orgasmic cries from the girls who seem delirious with lust. Some of the girls are hermaphrodites and appear to be cumming almost continuously!", "You find it is a breeding chamber with several girls being fucked by the monstrosities. You hear orgasmic cries from the girls who seem delirious with lust.", "You quickly attack and slay the monsters, freeing the girls.", 0, 0, 0, 101);
				return true;
				
			// 104 - Tentacle Abduction - area 2 (l/r junction)
			case 104:
				coreGame.HideImages();
				Backgrounds.ShowTunnels(4 + tunneltype);
				ClipTentacleHarem._visible = false;
				SetText("You reach another point where the tunnel splits left or right, or you may return back towards the entrance. Which way do you go?");
				if (CustomF3 == 0) {
					Action1 = 105;
					Action3 = 107;
				} else {
					Action1 = 105;
					Action3 = 107;
				}
				AskHerQuestions(Action1, 101, Action3, 0, "Left", "Back", "Right", "", "Which way do you want to go?");
				CustomE4 = Math.abs(CustomE4);
				return true;
		
			// 105 - Tentacle Abduction - area 3 (f/b chamber)
			case 105: 
				coreGame.HideImages();
				Backgrounds.ShowTunnels(7 + tunneltype);
				SetText("You reach a small empty chamber. A passage continues deeper or you may return towards the entrance. Which way do you go?");
				Action3 = 104;
				if (CustomEnd == 108) Action1 = 120;
				else Action1 = 108;
				AskHerQuestions(Action1, Action3, 0, 0, "Forward", "Back", "", "", "Which way do you want to go?");
				CustomE3 = Math.abs(CustomE3);
				return true;
				
			// 106 - Tentacle Abduction - area 4 (l/r junction)
			case 106:
				coreGame.HideImages();
				Backgrounds.ShowTunnels(4 + tunneltype);
				SetText("You reach another point where the tunnel splits left or right. Which way do you go?");
				if (CustomEnd == 109) Action1 = 120;
				else Action1 = 109;
				if (CustomEnd == 110) Action3 = 120;
				else Action3 = 110;
				if (CustomF4 == 0) {
					var a:Number = Action3;
					Action3 = Action1;
					Action1 = a;
				}
				AskHerQuestions(Action1, 107, Action3, 0, "Left", "Back", "Right", "", "Which way do you want to go?");
				CustomE5 = Math.abs(CustomE5);
				CustomE6 = Math.abs(CustomE6);
				return true;
				
			// 107 - Tentacle Abduction - Chamber E4
			case 107:
				CustomE4 = BreedingChamber(CustomE4, "You find girls being fucked by the monstrosities. They all seem to be orgasming over and over, some of them are hermaphrodites and appear to be cumming almost continuously!", "You find girls being fucked by the monstrosities. They all seem to be orgasming over and over.", "You quickly attack and rescue the girls, who quickly come to their senses.", 0, 0, 106, 104);
				return true;
			
			// 108 - Tentacle Abduction - Chamber E3
			case 108:
				CustomE3 = BreedingChamber(CustomE3, "You hear the orgasmic cries of several girls being fucked by the monstrosities. You see cum spurting into the girls and also from the cocks of some of the them who are hermaphrodites.", "You hear the orgasmic cries of several girls being fucked by the monstrosities. You see torrents of cum erupting from the girls pussies, ass and mouth.", "You attack and free the girls but the monsters flee.", 0, 0, 0, 105);
				return true;
			
			// 109 - Tentacle Abduction - Chamber E5
			case 109:
				CustomE5 = BreedingChamber(CustomE5, "You see monsters fucking pregnant looking girls. Some of the girls have cocks which are obviously cumming!", "You see monsters fucking pregnant looking girls.", "You attack and the monsters drop the girls and flee. The girls have cum leaking from their pussies, ass and mouth but they look almost happy, some still seem to be orgasming. You help them as best you can.", 0, 0, 0, 106);
				return true;
			
			// 110 - Tentacle Abduction - Chamber E6
			case 110:
				CustomE6 = BreedingChamber(CustomE6, "You see several heavily pregnant girls enveloped by tentacles. Some of the girls have cocks that are extremely erect.", "You see several heavily pregnant girls enveloped by tentacles. ", "You charge in and hack the tentacles, freeing the girls. The girls are dazed and seem highly aroused, some start masturbating!", 0, 0, 0, 106);
				return true;
		
			// 120 - Tentacle Abduction - Main Chamber entry
			case 120:
				coreGame.HideImages();
				HideBackgrounds();
				if (Wander > 3) {
					Backgrounds.ShowTunnelsChamber();
					DoEvent(122);
					SetText("You find what appears to be the main chamber but it is empty. It looks like the creatures were aware of you and fled, taking #slave with them. You return home hoping the authorities find #slavehimher.");
				} else {
					SetText("You find the main chamber filled with girls being assaulted by tentacles, fucked in every way possible. Despite this many appear to be in the throes of huge orgasms and the cavern is filled with moans and cries of ecstasy.");
					if (SMData.Gender != 1) AddText(" The smell of the creature's aphrodisiac cum fills the air and you feel hugely aroused."); 
					AddText("\r\rOn the far side you are sure you can see #slave enveloped by them. You advance but a larger creature blocks your way. You prepare to fight...");
					coreGame.InitialiseCombat("You fight, struggling to reach #slave.", 0, 121, 125, 126);
					TentacleCombat(true, "Guard Thing");
					ClipTentacleHarem._visible = true;
					ClipTentacleHarem.gotoAndStop(Math.floor(Math.random()*2) + 3);
					Backgrounds.ShowOverlay(0);
					DoEvent(3000);
				}
				return true;
				
			// 121 - Tentacle Abduction - Main Chamber rescue!
			case 121:
				coreGame.HideImages();
				coreGame.UpdateDateAndItems(1, false, 6, false);
				Backgrounds.ShowTentacles();
				coreGame.TotalTentacle = coreGame.TotalTentacle + 2;
				SetText("You fight your way through and see #slave being fucked by the creatures. A gout of cum erupts from around the tentacle in her pussy and she appears to orgasm! You free her, fighting the tentacles off!\r\rYou hold off the other monstrosities until the city guard arrives and the captives are freed. #slave praises your heroism, and the Lord gives you a reward for your service to the city.");
				if (countrescued > 0) {
					Diary.AddEntry("#slave was abducted by the tentacle monsters. You successfully rescued her and " + countrescued + " other girls.", true); 
					AddText("\r\rThe Lord also congratulates you on your heroism in rescuing other girls from the tentacle monstrosities, and pays you an additional reward."); 
				} else Diary.AddEntry("#slave was abducted by the tentacle monsters. You successfully rescued her.", true); 
				coreGame.UseGeneric = false;
				coreGame.SlaveGirl.ShowTentacleSex(-1);
				if (coreGame.UseGeneric) coreGame.Generic.ShowTentacleSex(-1);
				if (coreGame.CombatDifficulty == -1) SMMoney(100 + (countrescued * 50));
				else if (coreGame.CombatDifficulty == 1) SMMoney(1500 + (countrescued * 50));
				else SMMoney(1000 + (countrescued * 50));
				slaveData.MinLibido = slaveData.MinLibido + 5;
				Points(0, 5, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, -10, 0, 10, 0, 10, 0, 0);
				SMData.SMPoints(8, 0, 0, 0, 0, 0, 0, 0, 0);
				DoEvent(9999);
				return true;
				
			// 122 - Tentacle Abduction - Main Chamber abandoned - aftermath
			case 122:
				coreGame.UpdateDateAndItems(2, false, 6, false);
				coreGame.ShowAssistant();
				coreGame.HideStatChangeIcons();
				Points(0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, -10, 0, 10, -30, -10, 0, 0);
				coreGame.SlaveGirl.ShowTired(true);
				SetText("Two days pass\r\r");
				ServantSpeak(coreGame.Master + ", they have found #slave! A lair of tentacle horrors was found and cleansed. She was found there and has been treated for the effects of her assault.", true);
				if (countrescued > 0) {
					Diary.AddEntry("#slave was abducted by the tentacle monsters. You tried to rescue her but were too slow. You did rescue " + countrescued + " other girls.", true);
					AddText("\r\rThe Lord personally speaks to you and congratulates you on your heroism in rescuing some girls from the tentacle monstrosities, and pays you a small reward."); 
					SMMoney(countrescued * 50);
				} else Diary.AddEntry("#slave was abducted by the tentacle monsters. You tried to rescue her but were too slow.", true);
				DoEvent(9999);
				return true;
				
			// 125/126 - Tentacle Abduction - Defeat - part 1
			case 125:
			case 126:
				DoTentacleDefeat(coreGame.NumEvent);
				return true;
				
			// Defeat - Submit
			case 127:
				DoTentacleDefeatSubmit();
				return true;
				
			// Defeat - Resist
			case 128:
			case 128.5:
				DoTentacleDefeatResist(coreGame.NumEvent);
				return true;
				
			case 129:
				coreGame.UpdateDateAndItems(1, false, 6, false);
				SMData.SMHealth = SMData.SMConstitution;
				SMData.SMLust = 80;
				SMData.SMLust = 80;
				coreGame.HideStatChangeIcons();
				if (coreGame.CombatDifficulty == -1) SMMoney(50 + (countrescued * 50));
				else if (coreGame.CombatDifficulty == 1) SMMoney(600 + (countrescued * 50));
				else SMMoney(400 + (countrescued * 50));
				AddText("They tell you they have found #slave! You are both treated and return home. The Lord gives you a reward for the information and the attempt.");
				if (countrescued > 0) AddText("\r\rThe Lord also congratulates you on your heroism in rescuing some girls from the tentacle monstrosities, and pays you an additional reward."); 
				Points(0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, -10, 0, 10, -30, -10, 0);
				DoEvent(9999);
				return true;
				
			// 130 - acolyte raid, run
			case 130:
				coreGame.HideAllPeople();
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				SetText("As #slave runs, she sees the shadow of a tentacle and a shape slithering. She hears a cry, almost orgasmic in the distance...");
				ShowMovie("EventMorningTentacleVision", 1.1, 2);
				Backgrounds.ShowOverlay(0x241612);
				ShowPlanningNext();
				return true;
				
			// 131 - acolyte raid, help
			case 131:
				coreGame.HideAllPeople();
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				ShowPlanningNext();
				var dgnun:Boolean = IsDickgirlEvent();
				temp = dgnun ? 2 : 1;
				if (coreGame.DickgirlTesticles && dgnun) temp++;
				SetText("#slave runs to help and finds a young nun in a dark alcove, a tentacle monstrosity coiled around her. #slave is shocked and hesitates, as she sees a large tentacle cock is fucking the nun fast and very deep.\r\r");
				if (dgnun) AddText("#slave is surprised to see the nun is a hermaphrodite, they have worked together and it was never mentioned. The nun's cock is very erect and untouched by the tentacle beast. As she looks on the nun cums, screaming in passion as her cock spurts and spurts cum. ");
				else AddText("#slave has worked with this nun, and as she looks on, the nun screams in passion, clearly orgasming. ");
				AddText("\r\r#slave runs to help, and as she reaches the nun she sees the tentacle is cumming, bulges of cum rushing through its cock. The cum squirts out of the nun's cunt, as she is filled beyond her limits.\r\r#slave grabs at the tentacles, and they pull free quickly and slither off into some ducting.\r\rThe nun is lying on the ground gasping as cum flows from her pussy");
				if (dgnun) AddText(" and as her cock still sprays her cum for a few minutes");
				AddText(".\r\rThe nun calms down, and thanks #slave for her help, and as they talk the cries and shouts elsewhere die down. Carefully they look around and find the tentacles have done a mass raid here, assaulting every nun and acolyte here. Few will discuss what happened, but some mention the extreme intensity of their orgasms.\r\r#slave wonders why she was spared, and decides it may have been because she was not dressed as a nun or acolyte...");
				ShowMovie("EventAcolyteTentacleRaid", 1, 0, temp);
				return true;
				
			// 132 - bad end
			case 132:
				Diary.AddEntry("#slave was abducted by the tentacle monsters. You were defeated by the creatures and taken as one of their slaves.", true);
				Backgrounds.ShowTentacles(2);
				ClipTentacleHarem.gotoAndStop(SMData.Gender == 3 ? 25 : 24);
				ClipTentacleHarem._visible = true;
				if (SMData.Gender == 1) SetText("You are dimly aware of being carried, held tight by the tentacles, through tunnels and other dark twisting ways. Something feels very wrong but you are not sure what in the confusion. Eventually you are left in a new chamber, in some unknown location, you completely lost your way in the journey.\r\rYou get up to try and escape and lose you balance, your chest is heavy, you look down and see a large pair of breasts! You feel and your cock is gone and you have a pussy. Somehow you have been changed, you are a woman!\r\rA tentacle monster enters the chamber, and in your shock and confusion overpowers you. You gasp as you feel it's large cock penetrating your new, virginal, pussy. You wonder when help will arrive, or even if you want it...");
				else SetText("You are dimly aware of being carried, held tight by the tentacles, through tunnels and other dark twisting ways. Eventually you are left in a new chamber, in some unknown location, you completely lost your way in the journey.\r\rAs you get up to try and escape a tentacled creature blocks your way, you are tired and sore and it envelops you with it's inhuman strength. As it's cock pushes irresistibly into your pussy you wonder when, or if, help will arrive...");
				DoEvent(9800);
				return true;
					
			// 140 - Assistant Tentacle Sex
			case 140:
				coreGame.HideImages();
				coreGame.HideSlaveActions();
				Backgrounds.ShowTentacles();
				coreGame.ShowAssistant(4);
				coreGame.SlaveGirl.ShowTired(true);
				Diary.AddEntry("#assistant was also assaulted by tentacle monsters.");
				SetText("<b>The things</b> turn their attention to #assistant and coil around " + coreGame.ServantHimHer + " and sliding under " + coreGame.ServantHisHer + " clothes. They methodically rip them off stripping " + coreGame.ServantHimHer + " naked, squeezing " + coreGame.ServantHisHer + " breasts, rubbing " + coreGame.ServantHisHer + coreGame.Plural(" pussy", coreGame.ServantGender) + " and " + coreGame.Plural("bottom", coreGame.ServantGender) + ".\r\r");
				temp = Math.floor(Math.random()*2);
				if (coreGame.ServantGender > 3) temp = 2;
				switch(temp) {
					case 0:
						AddText("A small tentacle slowly inserts itself into her ass while another larger tentacle forcefully enters her pussy and both start fucking her.");
						if (coreGame.ServantGender == 3) AddText(" As they do another tentacle wraps itself around her cock, firmly sliding around it and then stroking it faster and faster. ");
						AddText("The tentacles in her pussy and ass fuck her faster and faster, until ");
						if (coreGame.ServantGender == 3) AddText("she helplessly cums, her cock erupting and spraying her cum.");
						else AddText("she helplessly orgasms");
						AddText(". The large tentacle speeds up and then thrusts itself deep and spews a torrent of cum into her. The one in her ass convulses and cums in her bowels.");
						AddText("\r\rThey drop her next to #slave and disappear.");
						break;
					case 1:
						AddText("A slimy tentacle slowly inserts itself into her ass while others rub her pussy and ");
						if (coreGame.ServantGender == 3) AddText("slide over her cock and tease her cock-head");
						else AddText("clit");
						AddText(". The one in her ass starts to slowly fuck her in a steady rhythm, plunging in very deep. The other tentacles bite her nipples, massage her breasts and ");
						if (coreGame.ServantGender == 3) AddText("tease and rub her cock");
						else AddText("tease her clit");
						AddText(". The rhythm steadily grows faster and deeper, #assistant winces with pain.");
						AddText("Just as she thinks she cannot bear it, the tentacle thrusts in deep and cums, pumping large amounts of its seed into her bowels and withdraws. Another replaces it, sliding easily into her cum slick ass, and starts fucking fast.\r\r#assistant feels a strange heat in her and when another tentacle thrusts into her pussy she ");
						if (coreGame.ServantGender == 3) AddText("cums as it is plunging in. She feels something licking and slurping her cum. As soon as she recovers the one in her ass cums and she cums again and this time she cries out a muffled cry as her cock convulses pouring and pumping cum for and very long cum. Again she feels something licking, swallowing her cum, just lightly touching the head of her cock.\r\rFinally the tentacle in her pussy thrusts and shudders, cumming a torrent and she erupts into another climax spraying impossible amounts of her cum, but it won't stop! She screams and cums, something gathering her cum, until she passes out.");
						else AddText("orgasms as it is plunging in. As soon as she recovers the one in her ass cums and she orgasms again and this time she cries out a muffled cry as the orgasm seem to go on forever.\r\rFinally the tentacle in her pussy thrusts and shudders, cumming a torrent and she erupts into an orgasm that never seems to end, until she passes out.");
						AddText("\r\rThe shapes drop her quivering, cum filled, and cum emptied, body next to #slave and disappear.");
						break;
					case 2:
						coreGame.GetServantAB();
						AddText("A small tentacle slowly inserts itself into " + coreGame.ServantA + "'s ass while another larger tentacle forcefully enters " + coreGame.ServantB + "'s pussy and both start fucking the two of them.");
						if (coreGame.ServantGender == 6) AddText(" As they do tentacles wrap around their cocks, firmly sliding around them and then stroking faster and faster. After a bit the one on " + coreGame.ServantA + "'s cock moves and directs her cock and pushes it into " + coreGame.ServantB + "'s ass! ");
						AddText("The tentacles in " + coreGame.ServantA + "'s pussy and " + coreGame.ServantB + "'s ass fuck faster and faster, until ");
						if (coreGame.ServantGender == 6) AddText("they helplessly cums, " + coreGame.ServantA + "'s cock erupting into " + coreGame.ServantB + "'s bowels.");
						else AddText("they both helplessly orgasm");
						AddText(". The large tentacle speeds up and then thrusts itself deep into " + coreGame.ServantA + " and spews a torrent of cum into her. The one in " + coreGame.ServantB + "'s ass convulses and cums in her bowels.\r\rThe tentacles pull free and there is a brief pause and then the tentacles swap person, the one that pulled free of " + coreGame.ServantA + "'s pussy pushes into " + coreGame.ServantB + "'s pussy and and the other into " + coreGame.ServantA + "'s pussy. Quickly the tentacles fuck them again.");
						AddText("\r\rLater, they drop #assistant next to #slave and disappear.");
						break;
				}
				coreGame.AssistantData.Impregnate("Tentacle");
				ShowPlanningNext();
				coreGame.CurrentAssistant.ShowAsAssistantTentacleSex();
				return true;
				
			// 141 - Slave Maker Tentacle Sex
			case 141:
				SlaveMakerTentacleRape();
				return true;
				
			// 190 - tentacle pregnancy
			case 190:
				DoTentaclePregnancy();
				return true;
			case 191:
				DoYoursTentaclePregnancy();
				return true;
			case 192:
				DoYoursTentaclePregnancy2();
				return true;
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			// YES - start search
			case 100:
				Money(-50 - (Math.floor(Math.random()*3) * 50));
				SetText("You set out and #assistant takes you to the witness, who says they remember nothing.\r\rAfter a payment their memory improves and they lead you to an abandoned sewer. They describe seeing a girl pulled in by a tentacular shape.\r\rYou descend..."); 
				ClipTentacleHarem.gotoAndStop(2);
				tunneltype = Math.floor(Math.random()*3);
				starte = Math.floor(Math.random() * (5 + coreGame.DickgirlOn));
				var ince:Number = ((Math.floor(Math.random() * 2) + 1) * 2) + coreGame.DickgirlOn;
				CustomE1 = NextCustomEvent(7, 7, ince);
				CustomE2 = NextCustomEvent(7, 7, ince);
				CustomE3 = NextCustomEvent(7, 7, ince);
				CustomE4 = NextCustomEvent(7, 7, ince);
				CustomE5 = NextCustomEvent(7, 7, ince);
				CustomE6 = NextCustomEvent(7, 7, ince);
				CustomEnd = Math.floor(Math.random()*3) + 108;
				CustomF1 = Math.floor(Math.random()*2);
				CustomF2 = Math.floor(Math.random()*2);
				CustomF3 = Math.floor(Math.random()*2);
				CustomF4 = Math.floor(Math.random()*2);
				Wander = 0;
				countrescued = 0;
				SMData.SMHealth = SMData.SMConstitution;
				DoEvent(100);
				return true;
				
			case 150:
				coreGame.DoEventNext(4998);
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			// NO - do not search
			case 100:
				coreGame.UpdateDateAndItems(2, false, 6, false);
				coreGame.HideStatChangeIcons();
				ClipTentacleHarem._visible = false;
				Diary.AddEntry("#slave was taken by the tentacle monsters. You decided to let the authorities handle it.", true); 
				Points(0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, -10, 0, 10, -30, -10, 0);
				ServantSpeak("#master, they have found #slave! A lair of tentacle horrors was found and cleansed. She was found there and has been treated for the effects of her assault.");
				DoEvent(9999);
				return true;
				
			case 150:
				SetEvent("TentacleSex");
				coreGame.HideImages();
				coreGame.currPlace.DoWalkLoadedContinue();
				return true;
		}
		return false;
	}
	
	public function DoTentaclePregnancy()
	{
		var sd:Object = SMData.GetSlaveInformation(coreGame.PersonIndex);
		coreGame.UseGeneric = false;
	
		Language.XMLData.XMLEvent("Daily/" + sd.PregnancyType + "Birth", true);
		Diary.AddEntry("#person gave birth to a spawn of the tentacle monsters.", true); 
		temp = Math.floor(Math.random()*3);
		if (coreGame.Home.HouseType == 1) temp = 0;
		AddText("You take #person to a secure place to await the birth. During the day her belly grows visibly. Something of the creatures strange aphrodisiac courses through her and incredible desire washes through her. She beg's you to help her orgasm, and you and #assistant help her for a time.\r\rAfter some time she is lost in desire and spontaneously orgasms every so often. Hours pass.\r\rThe birth is near ");
		switch (temp) {
			case 0:
				Money(100, true);
				AddText("and you hear a howling outside and a smashing at the door. #person cries in pain and the thing emerges from her womb in a thankfully quick birth. The howling increases in noise but it is unable to gain entrance.");
				break;
			case 1:
				AddText("and you hear a howling outside and a smashing at the door. #person cries in pain and the thing emerges from her womb in a thankfully quick birth. The howling increases and the door is smashed in. A dark blur flies in and grabs the spawn. It is so quick you can barely make out a many limbed thing before it flies out the door.");
				break;
			case 2:
				AddText("and #person cries in pain and the thing emerges from her womb in a thankfully quick birth. The spawn scuttles quickly away and you reach for it. It emits a cry and a cloud of some pale gas and you feel faint and pass out.\r\rWhen you awaken you see the others unconscious and the spawn is nowhere to be seen.");
				break;
		}
		if (temp == 0) AddText("\r\rYou turn the spawn over to the temple authorities to be dealt with. #person ensures that it will be humanely treated and <i>not</i> killed! The authorities give you a small reward.");
		if (coreGame.PersonIndex == -50) {
			AddText("\r\rIt is two days before #person can resume her training. She has some after effects from her experience, her libido is considerably increased from the odd effects before the birth but she seems oddly happy.");
			sd.MinLibido = sd.MinLibido + 20;
			Points(0, 3, 0, 0, 0, 2, 0, 0, 0, 2, 2, 0, 5, 0, 10, 0, 0, 5, 3, 0);
			if (coreGame.SlaveGirl.ShowTentaclePregnancyBirth() != true) coreGame.Generic.ShowTentaclePregnancyBirth();
			coreGame.UpdateDateAndItems(2, false, 6, false);
		} else {
			AddText("\r\rFor the next two days #person will be unavailable to assist in training #slave. She has some after effects from her experience, her libido is considerably increased from the odd effects before the birth but she seems oddly happy.");
			sd.MinLibido = sd.MinLibido + 20;
			coreGame.PointsByIndex(coreGame.PersonIndex, 0, 3, 0, 0, 0, 2, 0, 0, 0, 2, 2, 0, 5, 0, 10, 0, 0, 5, 3, 0);
			if (coreGame.PersonIndex == -50) coreGame.slaveData.ActInfoCurrent.ShowActImage(10022);
			else sd.ActInfoCurrent.ShowActImage(10022);
			if (coreGame.UseGeneric) coreGame.Generic.ShowTentaclePregnancyBirth();
			sd.DaysUnavailable += 2;
		}
		DoEvent("RecheckBirthing");
	}

	public function DoYoursTentaclePregnancy()
	{
		var sd:Object = coreGame.GetSlaveInformation(coreGame.PersonIndex);
		coreGame.UseGeneric = false;
	
		Diary.AddEntry("#person gave birth to a spawn of your tentacle monsters.", true); 
		AddText("You take #person to a secure place to await the birth. During the day her belly grows visibly. Something of the tentacles strange aphrodisiac courses through her and incredible desire washes through her. She beg's you to help her orgasm, and you and #assistant help her for a time.\r\rAfter some time she is lost in desire and spontaneously orgasms every so often. Hours pass.\r\rThe birth is near and #person cries in pain and the thing emerges from her womb in a thankfully quick birth. The spawn crawls toward you, it's father and master.");
		if (coreGame.PersonIndex == -50) {
			AddText("\r\rIt is two days before #person can resume her training. She has some after effects from her experience, her libido is considerably increased from the odd effects before the birth but she seems oddly happy.");
			sd.MinLibido = sd.MinLibido + 20;
			Points(0, 3, 0, 0, 0, 2, 0, 0, 0, 2, 2, 0, 5, 0, 10, 0, 0, 5, 3, 0);
			if (coreGame.SlaveGirl.ShowTentaclePregnancyBirth() != true) coreGame.Generic.ShowTentaclePregnancyBirth();
			coreGame.UpdateDateAndItems(2, false, 6, false);
		} else {
			AddText("\r\rFor the next two days #person will be unavailable to assist in training #slave. She has some after effects from her experience, her libido is considerably increased from the odd effects before the birth but she seems oddly happy.");
			sd.MinLibido = sd.MinLibido + 20;
			coreGame.PointsByIndex(coreGame.PersonIndex, 0, 3, 0, 0, 0, 2, 0, 0, 0, 2, 2, 0, 5, 0, 10, 0, 0, 5, 3, 0);
			if (coreGame.PersonIndex == -50) coreGame.slaveData.ActInfoCurrent.ShowActImage(10022);
			else sd.ActInfoCurrent.ShowActImage(10022);
			if (coreGame.UseGeneric) coreGame.Generic.ShowTentaclePregnancyBirth();
			sd.DaysUnavailable += 2;
		}
		DoEvent(192);
	}
	public function DoYoursTentaclePregnancy2()
	{
		coreGame.HideImages();
		coreGame.HideSlaveActions();
		var sd:Object = coreGame.GetSlaveInformation();
		coreGame.UseGeneric = false;
	
		var tot:Number = SMData.GetTotalChildren(true);
		Backgrounds.ShowDungeon();
		ShowMovie("Offspring", 1, 1, 1);
		if (tot == 1) SetText("This is your first child of the tentacle kind. For some almost instinctive reason you reailse the child needs to be kept closely confined and warm for some time. You decide it is best to keep the child in an well ventilated jar and the child seems very happy!");
		else SetText("This is your child number " + tot + " and you care for the child as the previous ones, storing until the child grows and develops to serve you.");
		DoEvent("RecheckBirthing");
	}
	
	public function DoTentacleDefeat(eventno:Number)
	{
		coreGame.HideImages();
		HideBackgrounds();
		SMData.SMChangeMinStats(0, 3);
		coreGame.UpdateSlaveMaker();
		if (SMData.SMHealth <= 0 || SMData.SMLust >= 100) {
			if (eventno == 125) SetText("You collapse to the ground from the pain of your injuries.\r\rYou");
			else {
				if (SMData.Gender == 1) SetText("You stagger to your knees as your cock erupts in an intense climax that continues on and on.\r\rYou");
				else if (SMData.Gender == 2) SetText("The arousal you are feeling peaks and you come to a painfully strong orgasm and you collapse shuddering to the ground.\r\rYou");
				else SetText("Your cock feels painfully erect and your pussy is leaking. You feel your cock rubbing in your underclothes and you scream and orgasm, cum soaking your clothes, and you collapse to your knees.\r\rYou");
			}
		} else SetText("You wake-up and");
		
		if (SMData.Gender == 1) {
			AddText(" feel tentacles lift you and wrap around your limbs. Your cock is still painfully erect and you feel a tendril wrap around it, and slowly stroke it. You are completely immobilised and can only see tentaclular shapes.\r\rSome move and you see a woman's ass poking out, rhythmically moving as a large tentacle fucks her anus. A large spray of cum erupts from around the tentacle as the thing cums in her bowels. You feel the tendril on you cock stroking faster and you cum as well, with painful intensity.\r\rThe woman is moved onto her back, still you can only see her lower half, and you see a larger tentacle thrust into her pussy. As this happens you feel something like a mouth envelop your cock...\r\rTime passes and you are forced to many painful and intense orgasms while watching the woman fucked over and over. Occasionally you hear a muffled cry as she seems to orgasm..."); 
			ClipTentacleHarem.gotoAndStop(16);
			if (coreGame.BadEndsOn) DoEvent(132);
			else {
				Diary.AddEntry("#slave was abducted by the tentacle monsters. You were defeated by the creatures.", true);
				AddText("\r\rYou are rescued sometime later by the military cleansing the lair. ");
				coreGame.NumEvent = 129;
				DoEventNextAsAssistant();
			}
		} else if (SMData.Gender == 2) {
			AddText(" feel worm-like tentacles tightly bind your limbs and you are sat down, arms raised and immobile. Your legs are spread and a pair of tentacles reach up and run their tips along your pussy lips and flick your clit.\r\rAnother tentacle tries to force itself into your mouth but you clench your teeth preventing it. The tentacle stops after a few tries, pulling back and you see it convulse spewing a huge amount of cum over your face.\r\rYou cough and shake your head as cum enters your lips, nostrils and coats your hair. You start feeling aroused for no reason, the cum taking some effect.");
			AddText("\r\rA tentacle forces itself slowly and painfully into your ass while another rips your dress exposing a breast, the tip flicking your nipple. The one in your ass enters very, very deeply and pauses, you feel sore and very full. The tentacle starts fucking slowly but quickly speeds up. Through the pain you still feel aroused and this feeling grows, as the other tentacles stroke nipple, clit and pussy.\r\rBefore your arousal grows too much the tentacle in your ass thrusts in deeps and cums, you feel ripples running along it into your bowels as huge amounts of cum fill your bowels. You feel your stomach swell and feel uncomfortably full. The tentacle pulls free and cum starts pouring out of your ass.\r\rAnother tentacle thrusts into your ass and the fucking resumes. The tentacles on your pussy and clit never touch you enough, never letting you orgasm. You feel frustrated as you feel another huge load of cum fill your ass.\r\rThe tentacle before your face quivers, it wants you to suck it.")
			AddText("\r\rDo you submit, hoping it will let you cum or do you resist, denying it that indignity?\r");
			AskHerQuestions(127, 128, 0, 0, "Submit", "Resist", "", "", "What do you do?");
			Backgrounds.ShowTentacles(1);
			ClipTentacleHarem.gotoAndStop(17);
			ClipTentacleHarem.Female1.gotoAndPlay(1);
	
		} else if (SMData.SMHomeTown == 2) {
			AddText(" feel tentacles lift you, binding you and lie you on your back. Your cock is still painfully erect and you feel a tentacle slowly insert itself into your pussy. An equally large one inserts itself into your ass, and they slowly fuck you. The one in your pussy only fucks slowly but the one in your ass steadily speeds up and after some time it convulses and cums. You are feeling highly aroused by their fucking, but it was not enough to make you cum.\r\rThe tentacle in you ass pulls free and another replaces it and fucks. The one in your pussy still just slowly fucks, stimulates you but never cums. Tentacle after tentacle fuck and cum in you ass but it is never enough to make you cum. You wonder if they are punishing you for fighting them...\r\rA slightly different tentacle, more cock like, approaches your mouth but you are able to grab it with a hand. You know somehow they want you to suck it. Maybe if you do they will finally let you cum..."); 
			Backgrounds.ShowTentacles(1);
			ClipTentacleHarem.gotoAndStop(19);
			AddText("\r\rDo you submit, hoping it will make you cum or do you resist, denying it that indignity?\r");
			AskHerQuestions(127, 128, 0, 0, "Submit", "Resist", "", "", "What do you do?");
	
		} else {
			AddText(" feel tentacles lift you and wrap around your limbs. You hear a moaning and see another girl next to you. She is also a hermaphrodite and is being heavily fucked, a tentacle is stroking her cock quickly and another is fucking her pussy. She cries out and cums a spray of cum, and the tentacle cums in her pussy.\r\rYou feel a large knobbed tentacle enter your pussy and another wrap around your cock. You hear the girl moan and see another tentacle is starting to fuck her. Her cock is hard and seems to have stayed that way after her last climax.\r\rThe tentacles fuck you both, hard and fast, but despite their lack of foreplay you feel very aroused. You hear the girl cry out and see her cumming again and you are very close. You see the girl looking at you, spraying cum from her cock and she cries out,\r\r");
			PersonSpeakStart("Girl", "Don't! Uh, uh, oh....", true);
			AddText("</ps>\rshe gasps and stops cumming\r" + coreGame.FontText + "\r");
			PersonSpeakEnd("If you cum they will feel it and release their potent seed and impregnate you, like me...");
			AddText("\r\rYou try to focus but the tentacle is fucking you hard and the other is stroking your cock. Resisting will be very difficult and very, very frustrating.")
			ClipTentacleHarem.gotoAndStop(21);
			AddText("\r\rDo you give in to your lust and cum, or do you resist trying not to cum?\r");
			AskHerQuestions(127, 128, 0, 0, "Give up", "Resist", "", "", "What do you do?");
		}
		ClipTentacleHarem._visible = true;
	}
	
	public function DoTentacleDefeatSubmit()
	{
		SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -5);
		SetText("You feel very aroused, frustrated and immobile. There is nothing you can do to escape so there is little you can do and ");
		if (SMData.Gender == 2) {
			ClipTentacleHarem.gotoAndStop(18);
			ClipTentacleHarem.Female2.gotoAndPlay(1);
			AddText("decide you might as well orgasm too. As you decide you feel ripples of cum forced into your ass. You open your mouth and the tentacle gently inserts itself. You feel the tentacles at your pussy both thrust in. That is enough and with a muffled cry you orgasm intensely.\r\rThe tentacles continue fucking and you suck, lick, tongue the one in your mouth. As you do you seem to hear or feel voices and emotions not your own. The feelings seem cry in joy and the tentacles in your pussy and ass erupt with large bulges of cum pouring and pumping into you. As you start to feel bloated the one in your mouth cums a flood. You swallow and swallow, drinking the cum.");
		} else if (SMData.SMHomeTown == 2) {
			AddText("pull the tentacle to your mouth and lick the head of the cock.\r\rAs you do the tentacle in your pussy starts fucking a bit harder and faster. You lick and suck harder and it fucks you harder and faster, until you feel it swell and cum. You feel an overpowering rush and you scream as you finally cum, spraying your release. When you recover there is cum on your face and you feel a huge sense of satisfaction but you realise it is coming from somewhere else.");
			ClipTentacleHarem.gotoAndStop(20);
		} else {
			AddText("give in, feeling your orgasm build. You feel a sense of delight and think you hear the girl thank you. You look and see she is looking at you, cock very erect still and a sad smile on her face. The tentacles fuck and stroke faster and faster and you see the girl is being fucked again too. Moments later you cry out and your cock spasms and you cum and cum and cum. You dimly feel the cock in your pussy unload a thick potent load of cum into you.");
			ClipTentacleHarem.gotoAndStop(23);
		}
		AddText("\r\rYou realise the voices and feeling must be coming from the creatures, somehow you are attuned to their minds. You do not think they are truly intelligent, no actual words just feelings, but they have a cunning and cleverness. You strongly feel their passion and joy in fucking you ");
		if (coreGame.PregnancyOn) AddText("and also some sort of affection for you, probably because they believe you now <b>carry one of their children</b>. They will not fight you anymore or anytime you bear their offspring. They will keep you here, to protect you, to fuck you, to enjoy you, to breed with you.\r\r");
		else AddText(". ");
		AddText("You feel their desire grow and the tentacles start moving again, stimulating you, fucking you...");
		if (coreGame.BadEndsOn) DoEvent(132);
		else {
			Diary.AddEntry("#slave was abducted by the tentacle monsters. You were defeated by the creatures and submitted to their lusts.", true);
			AddText("\r\rHours later and many orgasms and fuckings later you see human shapes pull the tentacles from you and shapes fighting and fleeing. You realise the city guard has arrived and is cleansing the lair!\r\r");
			coreGame.NumEvent = 129;
			DoEventNextAsAssistant();
		}
		ClipTentacleHarem._visible = true;
		slaveData.BitFlag1.SetBitFlag(16);
		SMData.SMPoints(2, 0, 0, 0, 0, 0, 0, 0, 0);
		SMData.Impregnate("Tentacle");
	}
	
	public function DoTentacleDefeatResist(eventno:Number)
	{
		SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, 5);
		if (eventno == 128) {
			SMData.SMPoints(4, 0, 0, 0, 0, 0, 0, 0, 0);
			SetText("You feel very aroused, frustrated and immobile. There is nothing you can do to escape but you refuse to surrender to the things. ");
		} else SetText("");
		if (SMData.Gender == 2) {
			AddText("The things keeps fucking your ass, cumming repeatedly, while the ones at your pussy tease and arouse you continuously. After a time you can dimly hear something and feel odd things. For no reason you think the creatures are not being cruel, just trying to help you adapt to your place here. They want you to accept their passion, their lust, their children.\r\rAfter a long frustrating time, you hear noise, like fighting in the distance. You feel the creatures regret as they slowly release you, but as they do a tentacle thrusts into your pussy and fucks you fast. You orgasm almost immediately, collapsing, shuddering onto the ground, free of the tentacles...");
			if (!coreGame.BadEndsOn) AddText("\r\rThe next you are aware a man is standing over you, the city guard has arrived to cleanse the lair."); 
		} else if (SMData.SMHomeTown == 2) {
			AddText("The things keeps fucking your ass, cumming repeatedly, while the one in your pussy slowly fucks. After a time you can dimly hear something and feels odd things. For no reason you think the creatures are not being cruel, just trying to help you adapt to your place here. They want you to accept their passion, their lust, their children.\r\rAfter a long frustrating time, you hear noise, like fighting in the distance. You feel the creatures regret as they slowly release you, but as they do a tentacle thrusts into your pussy and fucks you fast. You orgasm almost immediately, collapsing, shuddering onto the ground, free of the tentacles..."); 
			if (!coreGame.BadEndsOn) AddText("\r\rThe next you are aware a man is standing over you, the city guard has arrived to cleanse the lair."); 
		} else {
			if (eventno == 128) {
				AddText("With all the self-control you can muster you resist, trying to ignore the sensations from your pussy and cock.\r\rYou try to talk to the girl but she finds it difficult as they often fuck her. They seem to alternate periods of intense fucking with times of slow caressing and still penetration. You do your best to ignore the fact her cock seems to stay very, very hard and she always cums very, very strongly.\r\rAfter a time you feel a strange emotion and think you hear a voice,\r\r");
				PersonSpeak("Girl", "It's them, you can feel their desire, their lust, their emotions, Ohhhhhh", true);
				AddText("\r\rYou look and she is cumming again, but your tentacles stop fucking and stroking, staying inside your pussy but releasing your cock. You feel they are disappointed and have given up for now, and you are hugely aroused, your cock throbbing with your need to cum.\r\r");
				PersonSpeak("Girl", "Quickly, they are ignoring you now, you can cum if you like. You can use my, well you know...", true);
				AddText("\rYou see her look, and see her ass is free and if you stretch you could...\r\rYou cannot resist this offer and push, your cock easily enters her ass. She gasps and you fuck her quickly, your huge arousal allowing for little finesse. You feel the tentacle in her pussy fucking slowly and she moans in arousal. At this your cock bursts, gouts of cum pumping into her ass. You scream with joy and release and see that she also cums, but this fades as you pass-out from fatigue and ecstasy...\r\r");
				ClipTentacleHarem.gotoAndStop(22);
				ClipTentacleHarem._visible = true;
				coreGame.NumEvent = coreGame.BadEndsOn ? 132 : 128.5;
				DoEvent();
				return;
			} else {
				ShowMovie(coreGame.OnTopOverlay, 1, 0);
				ClipTentacleHarem._visible = false;
				Backgrounds.ShowTentacles(1);
				coreGame.SlaveGirl.ShowTired(true);
				AddText("When you awake you see the girl shaking you, and a young man, a member of the city guard standing behind her. He looks rather embarrassed. The guard has arrived to cleanse the lair!\r\rThe girl leans down and whispers,\r\r");
				PersonSpeak("Girl", "I heard some noises a while ago and they left!\r\rWhile waiting, I thought, umm, repayment...", true);
				AddText("\r\rShe kisses you and you are aware of soreness and a wet dribbling sensation from your ass. The girl smiles and looks at the guardsman, who blushes.\r\r");
				coreGame.StartFadeImage(50, coreGame.OnTopOverlay);
			}
		}
		if (coreGame.BadEndsOn) DoEvent(132);
		else {
			Diary.AddEntry("#slave was abducted by the tentacle monsters. You were defeated by the creatures and resist their lusts.", true);
			coreGame.NumEvent = 129;
			DoEventNextAsAssistant();
		}
	}
	
	public function DoSupervisorTentacleSex()
	{
		ShowPlanningNext();
		if (coreGame.SlaveGirl.SupervisorTentacleSex() == true) return;
		if (coreGame.Supervise) {
			if (SMData.Gender == 1) {
				AddText(". All the time the creatures hold you so you can clearly see them fucking #slave. When they finish they drop you on #slave and flee.");
			} else {
				DoEvent(141);
				AddText(" and turn to their attention to you, held immobile while they took #slave...");
			}
		} else if (coreGame.AssistantTentacleSex && coreGame.ServantGender != 1) { 
			if (coreGame.CurrentAssistant.SupervisorTentacleSexAsAssistant() == true) return;
			if (Math.floor(Math.random()*2) == 1)  {
				AddText(". #assistant was able to get free while they took #slave and ran!");
			} else {
				DoEvent(140);
				AddText(" and turn to #assistant, held immobile while they took #slave...");
			}
		} else {
			AddText(". #assistant is nowhere to be seen.");
		}
	}
	
	public function CanSupervisorRepel()
	{
		if (!coreGame.Supervise || SMData.WeaponType == 0) return false;
		var can:Boolean = coreGame.SlaveGirl.CanSupervisorRepelTentacles();
		if (can != undefined) return can;
		return true;
	}
	
	public function TentacleSex(place:Number)
	{
		SMData.BitFlagSM.SetBitFlag(6);
		if (CanSupervisorRepel() && coreGame.slrandom(3) < 3) {
			SetText("As you are walking with #slave you see a dark slithering shape approach, a large mass of tentacles and clawed hands. You immediately ready your weapon, and the thing jumps in what appears to be fright and it flees into the shadows.");
			if (coreGame.SlaveGirl.SupervisorRepelsTentacles() == true) return;
			coreGame.CurrentAssistant.SupervisorRepelsTentaclesAsAssistant();
			return;
		}
		slaveData.Impregnate("Tentacle");
		coreGame.TotalTentacle++;
		coreGame.HideImages();
		Backgrounds.ShowTentacles(1);
		if ((!coreGame.Supervise) && place != -1) {
			if (coreGame.AssistantTentacleSex) coreGame.ShowAssistant(2);
			else coreGame.ShowAssistant(4);	
		} else SMData.ShowSlaveMaker();
		place = int(place);
		if (coreGame.SlaveGirl.ShowTentacleSex(place) == true) {
			if (coreGame.UseGeneric) coreGame.Generic.ShowTentacleSex(place, slaveData.IsDickgirl() ? ( coreGame.SlaveGender > 3 ? 6 : 3) : coreGame.SlaveGender);
		} else {
			Diary.AddEntry("#slave was assaulted by tentacle monsters.", true); 
			if (coreGame.UseGeneric) coreGame.Generic.ShowTentacleSex(place, slaveData.IsDickgirl() ? ( coreGame.SlaveGender > 3 ? 6 : 3) : coreGame.SlaveGender);
			slaveData.MinLibido = slaveData.MinLibido + 5;
			if (!slaveData.SlaveFemale) {
				AddText("<b>#slave</b> walks along and long tentacles reach out and #slaveheshe is dragged into a dark area. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. #slave is tightly held face-down on the ground.\r\r");
				if (!slaveData.Naked) AddText("Claws reach out and rip #slavehisher clothing, exposing #slavehisher ass and cock. ");
				AddText("A large sucker like tentacle envelops #slavehisher cock completely and licks and sucks and #slaveheshe cries out as it bites. A thick tentacle shoves itself into #slavehisher mouth as #slaveheshe cries out. A long large tentacle approaches #slavehimher from behind and ");
				AddText("#slave feels the long hard tentacle easily penetrate #slavehisher ass and then start a fucking motion. His arousal grows, #slaveheshe cries out in pain as a thin whip-like tentacle sharply hits #slavehisher bottom, one cheek a few times then the other. Another pair sharply hit #slavehisher testicles and the sucker insistently works on his cock and it feels like it is getting a fast blowjob. Tears run down #slavehisher cheeks, but the cock continues it's urgent fucking and the whipping gets faster and faster. A second tendril starts whipping #slavehisher ass, #slavehisher arousal growing slowly.");
				AddText("\r\rThe lashes and fucking increase and #slavehisher arousal grows faster, the cock thrusts harder and deeper. #slave is on the edge and the cocks in his mouth and ass swell and thrust deep, pulsing and cumming. The whipping and sucking peak and #slaveheshe spasms, a shuddering orgasm overwhelming #slavehimher, cum spurting from #slavehisher cock into the sucker like tentacle.\r\rIn #slavehisher pain and ecstasy, #slaveheshe does not feel as they withdraw");
				DoSupervisorTentacleSex();
			} else {
				switch (place) {
					case 1: DoTentacleForest(); break; 
					case 4: DoTentacleSlums(); break;
					case 6: DoTentacleDocks(); break;
					case 8: DoTentacleRuins(); break;
					case 9: DoTentacleBeach(); break;
				}
			}
		}
	}
	
	public function DoTentacleDocks()
	{
		Points(0, 5, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, -10, 0, 15, -15, 0, 0);
		if (!Language.IsTextShown()) {
			if (coreGame.TentacleChoice > 3) coreGame.TentacleChoice = 3;
			switch(coreGame.TentacleChoice) {
				case 0:
					AddText("In a secluded area tentacular shapes rear out of the water and grab #slave and drag her under the dock. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. Huge cock like tentacles ");
					if (!slaveData.Naked) AddText("rip aside her clothes and ");
					if (slaveData.IsDickgirl()) AddText("enter #slave's pussy, her ass and then her mouth. A tentacle tightly grabs her cock, stroking it, and they start fucking her urgently. Their inhumanly large cocks irresistibly make her cum over and over until they erupt huge amounts of their cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					else AddText("enter her pussy, her ass and then her mouth. They start fucking her urgently. She cannot believe their size, and despite herself she is brought to orgasm after orgasm until they erupt huge amounts of cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					DoSupervisorTentacleSex();
					break;
				case 1:
					if (slaveData.IsDickgirl()) {
						AddText("<b>#slave</b> is walking past an overgrown area and tentacular shapes rear out of the water and grab her, dragging her into the undergrowth. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile.\r\rSlimy tentacles rub all over her body leaving trails of slime that sting and feel hot. Small tendrils wrap around her nipples and wrap around her cock and the hot sensation follows them. They tease and stroke, painfully but despite this her arousal grows to near orgasm. They stop for a time and let her arousal recede and start again until she is on the verge again. A large tentacle rubs around the entry of her pussy.");
						AddText("#slave is on the verge of orgasm and the large tentacle thrusts deep inside her pussy and stops. Simultaneously the tendrils tweak her nipples and rub her cock and she cums torrentially, over her tits and stomach.\r\rThe tentacle pulls back and pushes back in, fucking her and her arousal builds quickly again. The tentacle seems to time itself, varying its pace waiting. Uncontrollably and irresistibly #slave bucks and cums, and it then thrusts in deep, tenses and cums its huge load into her, cumming and cumming for a long time.\r\rThe thing leaves #slave lying, cum leaking from pussy and cock");
					} else {
						AddText("<b>#slave</b> is walking past an overgrown area and tentacular shapes rear out of the water and grab her, dragging her into the undergrowth. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile.\r\rSlimy tentacles rub all over her body leaving trails of slime that sting and feel hot. Small tendrils wrap around her nipples and clitoris and the hot sensation follows them. They tease and tweak, somewhat painfully but despite this her arousal grows to near orgasm. They stop for a time and let her arousal recede and start again until she is on the verge again. A large tentacle rubs around the entry of her pussy.");
						AddText("#slave is on the verge of orgasm and the large tentacle thrusts deep inside her pussy and stops. Simultaneously the tendrils tweak her nipples and clit and she orgasms.\r\rThe tentacle pulls back and pushes back in, fucking her and her arousal builds quickly again. The tentacle seems to time itself, varying its pace waiting. Uncontrollably and irresistibly #slave bucks and orgasms, and it then thrusts in deep, tenses and cums a huge load into her, cumming and cumming for a long time.\r\rThe thing leaves #slave lying, cum leaking from her");
					}
					DoSupervisorTentacleSex();
					break;
				case 2:
					AddText("<b>#slave</b> walks along a beach near the docks and long tentacles reach out and she is dragged into the water. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. She is pulled to an overgrown rock and held face-down on it.\r\r");
					if (!slaveData.Naked) AddText("Claws reach out and rip her clothing, exposing her round bottom and ample breasts. ");
					AddText("Large sucker like tentacles attach themselves to her nipples and start to suck. ");
					if (slaveData.IsDickgirl()) {
						AddText("A larger one envelops her cock completely and licks and sucks and she cries out as it bites. A thick tentacle shoves itself into her mouth as she cries out. A pair of long large tentacles approach her from behind.");
						AddText("#slave feels the two long hard tentacles easily penetrate her pussy and ass and then start an alternating fucking motion. Her arousal grows, she cries out in pain as a thin whip-like tentacle sharply hits her bottom, one cheek a few times then the other. Another pair sharply hit her breasts and the suckers insistently work on her nipples and her cock feels like it is getting a fast blowjob. Tears run down her cheeks, but the twin cocks continue their urgent fucking and the whipping gets faster and faster. A second tendril starts whipping her ass, her arousal growing slowly.");
						AddText("\r\rThe lashes and fucking increase and her arousal grows faster, the cocks then alter their pattern so they thrust at the same time. She is on the edge and the cocks swell and thrust deep, pulsing and cumming. The whipping and sucking peak and she spasms, a shuddering orgasm overwhelming her, cum spurting into it.\r\rIn her pain and ecstasy, she does not feel as they withdraw");
					} else {
						AddText("A smaller one attaches itself to her clit and shudders and sucks and she cries out as it bites. A thick tentacle shoves itself into her mouth as she cries out. A pair of long large tentacles approach her from behind...");
						AddText("#slave feels the two long hard tentacles easily penetrate her pussy and ass and then start an alternating fucking motion. As her arousal grows she cries out in pain as a thin whip like tentacle sharply hits her bottom, hitting one cheek a few times then the other. Another pair sharply hit her breasts and the suckers insistently work on her nipples and clit. Tears run down her cheeks, but the twin cocks continue their urgent fucking and the whipping gets faster and faster. Another tendril starts whipping and now both ass cheeks are whipped at once...");
						AddText("\r\rThe fucking speeds up and the suckers work harder, biting and sucking, but her arousal grows slowly. The whipping and fucking intensify and her arousal grows quickly, the cocks alter their pattern so they thrust at the same time. She feels herself on the edge of a huge orgasm and the cocks swell and thrust in deeply and pulse, cumming. The whipping and sucking peak and she spasms in a blinding, shaking orgasm.\r\rIn her pain and ecstasy, she does not feel as they withdraw");
					}
					DoSupervisorTentacleSex();
					break;
				case 3:
					if (slaveData.IsDickgirl()) {
						AddText("<b>#slave</b> is near a warehouse and is quickly dragged into a packing crate. By surprise, more tentacles grab #super pulling " + coreGame.SupervisorHimHer + " inside as well.\r\rDark shapes strip her and long tentacles rub over her body, paying special attention to her cock, carefully rubbing and stroking it until she is erect. A mouth like tentacle envelops her cock while others slide over her body and squeeze her breasts.\r\rThe mouth-like tentacle sucks and licks her cock expertly and she quickly cums and it gulps all of it.");
						AddText("Gasping she recovers but feels it is continuing to suck and lick and she becomes erect quickly. The other tentacles reassert and tighten her restraints and rhythmically squeeze her breasts. Smaller ones lightly trace her pussy and anus. She is brought again to a gasping, panting orgasm, spewing her cum which is gobbled down.\r\rHer cock feels a little sore but it still continues to suck her. The small tendrils penetrate her ass and pussy and writhe and tease her erect again. The mouth-like one again makes her cum, which it drinks\rand again\rand again\rand again\rUntil she is sobbing, gasping, and unable to cum.\r\rThey leave the drained girl");
					} else AddText("#slave is near a warehouse and is dragged into a packing crate. Dark shapes strip her and long tentacles rub over her body, paying special attention to her pussy and clit, carefully rubbing and flicking her clit. A mouth-like tentacle attached to her pussy and licks her clit while others rub her breasts. The tentacle licks and sucks her expertly and she quickly orgasms, even ejaculating a little and it seems to drink it and her other fluids. She recovers and it is still licking and it quickly brings her to orgasm again, and again, and again.\r\rThey leave the drained girl");
					DoSupervisorTentacleSex();
					break;
			}
		}
	}
	
	public function DoTentacleForest()
	{
		Points(0, 5, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, -10, 0, 15, -15, 0, 0);
		if (coreGame.GeneralTextField.text == "") {
			if (coreGame.TentacleChoice > 1) coreGame.TentacleChoice = 1;
			switch(coreGame.TentacleChoice) {
				case 0:
					AddText("In a secluded area vine-like tentacles fly out of the trees and grab #slave and drag her back in. More tentacles grab #super, taking " + coreGame.SupervisorHimHer + " by surprise, holding " + coreGame.SupervisorHimHer + " immobile. Huge cock like vines ");
					if (!slaveData.Naked) AddText("rip aside her clothes and ");
					AddText("enter her pussy, her ass and then her mouth. ");
					if (slaveData.IsDickgirl()) AddText("A vine tightly grabs her cock, stroking it, and they start fucking her urgently. Their inhumanly large cocks irresistibly make her cum over and over until they erupt huge amounts of their cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					else AddText("They start fucking her urgently. She cannot believe their size, and despite herself she is brought to orgasm after orgasm until they erupt huge amounts of cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					DoSupervisorTentacleSex();
					break;
				case 1:
					AddText("<b>#slave</b> is pushing her way through a heavily overgrown area when vine-like tentacles wrap around her legs, pulling her down. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile.\r\rSpiny vines with fine barbs and hairs scrape over her skin leaving fine scratches, sometimes digging in painfully. Small hairy tendrils slide ");
					if (slaveData.Naked) AddText("along her bare skin");
					else AddText("under her dress");
					AddText(" wrapping around her nipples and a larger one ");
					if (slaveData.IsDickgirl()) {
						AddText("with coarse hairs wraps around her soft cock. The scratches and cuts start itching and the vine on her cock squeezes and tickles. The itching intensifies and she moans loudly, her cock becoming hard under the stroking of the vine.\r\rThe tendril strokes her cock faster and faster, she cries and moans nearing orgasm. She shouts as a spiny, hairy thing probes her pussy and her cock spasms as she cums, spurting her cum into some velvety opening.\r\r");
						AddText("#slave moans, she cock feeling a bit sore but still very hard, the tendril slowly stroking. She feels the vine at her pussy push in, soft spines and hairs tickling her as it enters deep. The tendril strokes her cock faster as the vine inside throbs, not moving but growing thicker and thicker. With a whimpering cry she cums again, cum spewing into some soft opening. As she does the vine in her pussy throbs intensely and something pumps into her womb.\r\rShe gasps, thinking it is done with her but her cock is still hard and the tendril slowly starts stroking again. The vine in her pussy slowly grows thicker.\r\rA long time later the vines release her, after making her cum over and over and over, until she could not cum again and her cock was sore and limp. The vines seem to sink into the earth, leaving cum and what looks like seeds dribbling from her pussy");
					} else {
						AddText("attaches itself to her clit. She feels a painful prick from a spine directly on her clit and she whimpers. Almost immediately the pain disappears, replaced with a rush of arousal, her clit feels like it swells to several times its normal size.\r\rA large spiny, hairy thing probes her pussy and slowly pushes in, soft spines and hairs tickling her as it enters deep.\r\rShe moans softly, expecting it to start fucking her but it stays still, throbbing and slowly growing thicker. The vine at her clit rubs and tickles while the one in her pussy grows thicker and thicker. She cries out as her arousal peaks, orgasm washes over her. ");
						AddText("#slave feels the one in her pussy throb and pump something into her. She gasps hoping it is over, but the vine in her pussy stays still and the nibbling, tickling of the tendrils on her nipples and clit continue. The vine in her pussy slowly grows thicker and she feels again a growing arousal.\r\rA long time later, the vines leave her, after bringing her to orgasm after orgasm, and cumming many times into her. The vines seem to sink into the earth, leaving cum and what looks like seeds dribbling from her pussy");
					}
					DoSupervisorTentacleSex();
					break;
			}
		}
	}
	
	public function DoTentacleRuins()
	{
		Points(0, 5, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, -5, 0, 10, -5, 0, 0);
		if (coreGame.GeneralTextField.text == "") {
			if (coreGame.TentacleChoice > 1) coreGame.TentacleChoice = 1;
			switch(coreGame.TentacleChoice) {
				case 0:
					AddText("Stepping over a low wall, vine-like tentacles fly out of the rubble and grab #slave and drag her down. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. Huge cock like vines ");
					if (!slaveData.Naked) AddText("rip aside her clothes and ");
					AddText("enter her pussy, her ass and then her mouth. ");
					if (slaveData.IsDickgirl()) AddText("A vine tightly grabs her cock, stroking it, and they start fucking her urgently. Their inhumanly large cocks irresistibly make her cum over and over until they erupt huge amounts of their cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					else AddText("They start fucking her urgently. She cannot believe their size, and despite herself she is brought to orgasm after orgasm until they erupt huge amounts of cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					DoSupervisorTentacleSex();
					break;
				case 1:
					AddText("<b>#slave</b> is pushing her way through a heavily overgrown shattered building when vine-like tentacles wrap around her legs, pulling her down. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile.\r\rSpiny vines with fine barbs and hairs scrape over her skin leaving fine scratches, sometimes digging in painfully. Small hairy tendrils slide ");
					if (slaveData.Naked) AddText("along her bare skin");
					else AddText("under her dress");
					AddText("and wrap around her nipples and a larger one ");
					if (slaveData.IsDickgirl()) {
						AddText("with coarse hairs slips under her dress and wraps around her soft cock. The scratches and cuts start itching and the vine on her cock squeezes and tickles. The itching intensifies and she moans loudly, her cock becoming hard under the stroking of the vine.\r\rThe tendril strokes her cock faster and faster, she cries and moans nearing orgasm. She shouts as a spiny, hairy thing probes her pussy and her cock spasms as she cums, spurting her cum into some velvety opening.\r\r");
						AddText("#slave moans, she cock feeling a bit sore but still very hard, the tendril slowly stroking. She feels the vine at her pussy push in, soft spines and hairs tickling her as it enters deep. The tendril strokes her cock faster as the vine inside throbs, not moving but growing thicker and thicker. With a whimpering cry she cums again, cum spewing into some soft opening. As she does the vine in her pussy throbs intensely and something pumps into her womb.\r\rShe gasps, thinking it is done with her but her cock is still hard and the tendril slowly starts stroking again. The vine in her pussy slowly grows thicker.\r\rA long time later the vines release her, after making her cum over and over and over, until she could not cum again and her cock was sore and limp. The vines seem to sink into the earth, leaving cum and what looks like seeds dribbling from her pussy");
					} else {
						AddText("attaches itself to her clit. She feels a painful prick from a spine directly on her clit and she whimpers. Almost immediately the pain disappears, replaced with a rush of arousal, her clit feels like it swells to several times its normal size.\r\rA large spiny, hairy thing probes her pussy and slowly pushes in, soft spines and hairs tickling her as it enters deep.\r\rShe moans softly, expecting it to start fucking her but it stays still, throbbing and slowly growing thicker. The vine at her clit rubs and tickles while the one in her pussy grows thicker and thicker. She cries out as her arousal peaks, orgasm washes over her. ");
						AddText("#slave feels the one in her pussy throb and pump something into her. She gasps hoping it is over, but the vine in her pussy stays still and the nibbling, tickling of the tendrils on her nipples and clit continue. The vine in her pussy slowly grows thicker and she feels again a growing arousal.\r\rA long time later, the vines leave her, after bringing her to orgasm after orgasm, and cumming many times into her. The vines seem to sink into the earth, leaving cum and what looks like seeds dribbling from her pussy");
					}
					DoSupervisorTentacleSex();
					break;
			}
		}
	}
	
	public function DoTentacleSlums()
	{
		Points(0, 5, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, -10, 0, 10, -10, 0, 0);
		if (coreGame.GeneralTextField.text == "") {
			if (coreGame.TentacleChoice > 3) coreGame.TentacleChoice = 3;
			switch(coreGame.TentacleChoice) {
				case 0:
					if (slaveData.IsDickgirl()) AddText("A strange shape from the shadows grabs #slave and drags her into an abandoned building. By surprise, more tentacles grab #super dragging " + coreGame.SupervisorHimHer + " as well. Monstrous forms envelope her and huge penile forms shaped like tentacles thrust themselves into her mouth, pussy and ass and fuck her. Another tentacle wraps around her cock and strokes it and despite the horror and fear she is made to cum time after time until they erupt huge amounts of cum into her womb, bowels and mouth.\r\rThey then drop her and withdraw");
					else AddText("A strange shape from the shadows grabs #slave and drags her into an abandoned building. By surprise, more tentacles grab #super dragging " + coreGame.SupervisorHimHer + " as well. Monstrous forms envelope her and huge penile forms shaped like tentacles thrust themselves into her mouth, pussy and ass and fuck her. Despite the horror and fear she is brought to orgasm after orgasm until they erupt huge amounts of cum into her womb, bowels and mouth.\r\rThey then drop her and withdraw.");
					break;
				case 1:
					AddText("<b>Walking</b> in an alley a rope like tentacle grabs #slave's ankle tripping her and then pulls her into a dark alcove. By surprise, more tentacles grab #super dragging " + coreGame.SupervisorHimHer + " as well. The rope like shapes quickly bind her and writhe around her");
					if (!slaveData.Naked) AddText(", exposing her skin and ripping her clothes");
					AddText(".\r\rA larger one forces itself into her mouth and starts to work itself in and out. ");
					if (slaveData.IsDickgirl()) {
						AddText("Others rub her breasts and tease her cock arousing her, even one plays with her anus. After a while the one in her mouth tenses and pours a gout of cum that she is forced to swallow.");
						AddText("#slave feels an overpowering rush of lust as she swallows the cum, her cock becoming powerfully erect, and stops resisting, wanting only to be fucked.\r\rTentacle after tentacle start to fuck her, each spewing their cum deep into her womb. They crowd her pussy trying to fuck her and some who cannot instead fuck her ass filling her bowels with their cum.\r\rPeriodically one spews its load into her mouth which she eagerly drinks.\r\rShe cums repeatedly, never losing her erection or desire to cum again.\r\rAfter a long time they finally tire and release her cum soaked body");
					} else {
						AddText("Others rub her breasts and clit arousing her, even one plays with her anus. After a while the one in her mouth tenses and pours a gout of cum that she is forced to swallow.");
						AddText("#slave feels an overpowering rush of lust as she swallows the cum, and stops resisting, wanting only to be fucked.\r\rTentacle after tentacle start to fuck her, each spewing their cum into her womb. They crowd her pussy trying to fuck her and some who cannot instead fuck her ass filling her bowels with their cum.\r\rPeriodically one spews its load into her mouth which she eagerly drinks.\r\rShe orgasms repeatedly, more and more often until they seem to merge together into one long orgasm.\r\rAfter a long time they finally tire and release her cum soaked body");
					}
					break;
				case 2:
					AddText("<b>From</b> behind a strong thing seizes #slave and drags her deep into the shadows. By surprise, more tentacles grab #super, dragging " + coreGame.SupervisorHimHer + " as well. As she starts to yell a large penile tentacle is thrust into her mouth. She feels ");
					if (!slaveData.Naked) AddText("things rip her clothes and ");
					AddText("a very large slimy cock like thing works itself into her ass, burying itself deep. It starts to fuck her, almost pulling out and then plunging in deeply, and repeating slowly.\r\rAs she is fucked she can see people in the distance moving, but she is help fast deep in the shadows. The cock steadily speeds up.");
					AddText("The ass fucking is now very fast and then cock plunges in deeply and convulses, pumping what feels like gallons of cum into her.\r\r");
					if (slaveData.IsDickgirl()) {
						AddText("The cock remains buried deeply in #slave's ass and she feels a rush of lust, her cock swells erect, intensely and demandingly hard.\r\rShe is roughly turned, the thing's cock still in her ass, and a larger cock like tentacle buries itself in her pussy and starts a fast fucking. #slave cannot control herself, moaning and crying, desperate for it to touch her cock and to cum. Finally, the thing's cock buries itself deep. She can see ripples in it as cum pours through it. As she sees this she shakes, the dam bursts, and she cums, her cum spraying in a spurting fountain. The tentacle in her ass cums again copiously and the one in her mouth pours cum into her.\r\rThey drop her still shooting cum to the ground");
					} else {
						AddText("The cock remains buried deeply in #slave's ass and she feels a rush of lust, her clit throbs and her nipples are very hard.\r\rShe is roughly turned, the thing's cock still in her ass, and a larger cock like tentacle buries itself in her pussy and starts a fast thrusting. #slave can barely control herself, moaning and crying, desperate to orgasm. Finally, the thing's cock buries itself deep. She can see ripples in it as cum pours through it. As she sees this she cannot stop herself and orgasms. The tentacle in her ass cums again copiously and the one in her mouth pours cum into her.\r\rThey drop her still orgasming to the ground");
					}
					break;
				case 3:
					AddText("<b>#slave</b> " + coreGame.NonPlural("hear") + " a noise and tentacular shapes erupt from a sewer grate. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. She is pulled into a partially collapsed drain and the tentacles envelop her");
					if (!slaveData.Naked) AddText(", she feels her clothes tear and fall away");
					AddText(". ");
					if (slaveData.IsDickgirl()) {
						AddText("Tentacles writhe over her, but hesitate when they feel her cock, but resume when one touches her pussy.\r\rShe is firmly held and her legs are forced open. A small tentacle starts rubbing her cock and to her shame she is immediately erect. The tentacle suddenly wraps itself tightly around the base of her cock, a little painfully.");
						AddText("With no further preparation a large tentacle cock penetrates her pussy and fucks her fast. She is dry due to lack of foreplay but it seems to not care. A minute later it cums a bucket-load, cum spraying out around itself. She starts feeling odd and her cock becomes painfully, demandingly erect. Another cock inserts itself and starts fucking and she almost cums but when she starts the one clamping on her cock squeezes tighter and to her despair she cannot.\r\rThe tentacle cums and another fucks her, her need to cum grows more and more desperate. Tentacle after tentacle fuck her but they will not let her cum, her cock becomes painful.\r\rAfter a long time the last one cums and she is lying in a pool of their cum and the one on her cock lessens its grip and starts stroking her. She painfully, ecstatically, cums, dimly aware the cum is collected by a mouth-like tentacle.\r\rThey leave her slumped in their cum");
					} else {
						AddText("Tentacles writhe over her exploring everywhere.\r\rShe is firmly held and her legs are forced open. A small tentacle wraps itself around her clit and she feels odd tingling sensations in her clit that alternate between pleasant and painful.");
						AddText("With no further preparation a large tentacle cock penetrates her pussy and fucks her fast. She is dry due to lack of foreplay but it seems to not care. A minute later it cums a bucket-load, cum spraying out around itself. She starts feeling odd and feels enormously aroused. Another cock inserts itself and starts fucking and she almost orgasms but when she starts she feels a huge shock run through her clit, stopping her.\r\rThe tentacle cums and another fucks her, her need to orgasm re-grows quickly and seemingly more intense. Tentacle after tentacle fuck her but they will not let her cum, shocking her each time she reaches the verge of orgasm.\r\rAfter a long time the last one cums and she starts to orgasm again but this time she just feels a tingle and finally orgasms and orgasms. She is dimly aware of ejaculating and a thing drinking and licking her juices.\r\rThey leave her slumped in their cum");
					}
					break;
	
			}
			DoSupervisorTentacleSex();
		}
	}
	
	public function DoTentacleBeach()
	{
		Points(0, 5, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, -10, 0, 15, -15, 0, 0);
		if (coreGame.GeneralTextField.text == "") {
			if (coreGame.TentacleChoice > 3) coreGame.TentacleChoice = 3;
			switch(coreGame.TentacleChoice) {
				case 0:
					AddText("In a secluded area tentacular shapes rear out of the water and grab #slave and drag her under the dock. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. Huge cock like tentacles ");
					if (!slaveData.Naked) AddText("rip aside her clothes and ");
					if (slaveData.IsDickgirl()) AddText("enter #slave's pussy, her ass and then her mouth. A tentacle tightly grabs her cock, stroking it, and they start fucking her urgently. Their inhumanly large cocks irresistibly make her cum over and over until they erupt huge amounts of their cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					else AddText("enter her pussy, her ass and then her mouth. They start fucking her urgently. She cannot believe their size, and despite herself she is brought to orgasm after orgasm until they erupt huge amounts of cum into her womb, bowel and stomach.\r\rThey then drop her and slither away");
					DoSupervisorTentacleSex();
					break;
				case 1:
					if (slaveData.IsDickgirl()) {
						AddText("<b>#slave</b> is walking past an overgrown area and tentacular shapes rear out of the water and grab her, dragging her into the undergrowth. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile.\r\rSlimy tentacles rub all over her body leaving trails of slime that sting and feel hot. Small tendrils wrap around her nipples and wrap around her cock and the hot sensation follows them. They tease and stroke, painfully but despite this her arousal grows to near orgasm. They stop for a time and let her arousal recede and start again until she is on the verge again. A large tentacle rubs around the entry of her pussy.");
						AddText("#slave is on the verge of orgasm and the large tentacle thrusts deep inside her pussy and stops. Simultaneously the tendrils tweak her nipples and rub her cock and she cums torrentially, over her tits and stomach.\r\rThe tentacle pulls back and pushes back in, fucking her and her arousal builds quickly again. The tentacle seems to time itself, varying its pace waiting. Uncontrollably and irresistibly #slave bucks and cums, and it then thrusts in deep, tenses and cums its huge load into her, cumming and cumming for a long time.\r\rThe thing leaves #slave lying, cum leaking from pussy and cock");
					} else {
						AddText("<b>#slave</b> is walking past an overgrown area and tentacular shapes rear out of the water and grab her, dragging her into the undergrowth. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile.\r\rSlimy tentacles rub all over her body leaving trails of slime that sting and feel hot. Small tendrils wrap around her nipples and clitoris and the hot sensation follows them. They tease and tweak, somewhat painfully but despite this her arousal grows to near orgasm. They stop for a time and let her arousal recede and start again until she is on the verge again. A large tentacle rubs around the entry of her pussy.");
						AddText("#slave is on the verge of orgasm and the large tentacle thrusts deep inside her pussy and stops. Simultaneously the tendrils tweak her nipples and clit and she orgasms.\r\rThe tentacle pulls back and pushes back in, fucking her and her arousal builds quickly again. The tentacle seems to time itself, varying its pace waiting. Uncontrollably and irresistibly #slave bucks and orgasms, and it then thrusts in deep, tenses and cums a huge load into her, cumming and cumming for a long time.\r\rThe thing leaves #slave lying, cum leaking from her");
					}
					DoSupervisorTentacleSex();
					break;
	
				case 2:
					AddText("<b>#slave</b> walks along the beach and long tentacles reach out and she is dragged into the water. By surprise, more tentacles grab #super holding " + coreGame.SupervisorHimHer + " immobile. She is pulled to an overgrown rock and held face-down on it.\r\r");
					if (!slaveData.Naked) AddText("Claws reach out and rip her clothing, exposing her round bottom and ample breasts. ");
					AddText("Large sucker like tentacles attach themselves to her nipples and start to suck. ");
					if (slaveData.IsDickgirl()) {
						AddText("A larger one envelops her cock completely and licks and sucks and she cries out as it bites. A thick tentacle shoves itself into her mouth as she cries out. A pair of long large tentacles approach her from behind.");
						AddText("#slave feels the two long hard tentacles easily penetrate her pussy and ass and then start an alternating fucking motion. Her arousal grows, she cries out in pain as a thin whip-like tentacle sharply hits her bottom, one cheek a few times then the other. Another pair sharply hit her breasts and the suckers insistently work on her nipples and her cock feels like it is getting a fast blowjob. Tears run down her cheeks, but the twin cocks continue their urgent fucking and the whipping gets faster and faster. A second tendril starts whipping her ass, her arousal growing slowly.");
						AddText("\r\rThe lashes and fucking increase and her arousal grows faster, the cocks then alter their pattern so they thrust at the same time. She is on the edge and the cocks swell and thrust deep, pulsing and cumming. The whipping and sucking peak and she spasms, a shuddering orgasm overwhelming her, cum spurting into it.\r\rIn her pain and ecstasy, she does not feel as they withdraw");
					} else {
						AddText("A smaller one attaches itself to her clit and shudders and sucks and she cries out as it bites. A thick tentacle shoves itself into her mouth as she cries out. A pair of long large tentacles approach her from behind...");
						AddText("#slave feels the two long hard tentacles easily penetrate her pussy and ass and then start an alternating fucking motion. As her arousal grows she cries out in pain as a thin whip like tentacle sharply hits her bottom, hitting one cheek a few times then the other. Another pair sharply hit her breasts and the suckers insistently work on her nipples and clit. Tears run down her cheeks, but the twin cocks continue their urgent fucking and the whipping gets faster and faster. Another tendril starts whipping and now both ass cheeks are whipped at once...");
						AddText("\r\rThe fucking speeds up and the suckers work harder, biting and sucking, but her arousal grows slowly. The whipping and fucking intensify and her arousal grows quickly, the cocks alter their pattern so they thrust at the same time. She feels herself on the edge of a huge orgasm and the cocks swell and thrust in deeply and pulse, cumming. The whipping and sucking peak and she spasms in a blinding, shaking orgasm.\r\rIn her pain and ecstasy, she does not feel as they withdraw");
					}
					DoSupervisorTentacleSex();
					break;
				case 3:
					if (slaveData.IsDickgirl()) {
						AddText("<b>#slave</b> is dragged into changing room. By surprise, more tentacles grab #super pulling " + coreGame.SupervisorHimHer + " inside as well.\r\rDark shapes strip her and long tentacles rub over her body, paying special attention to her cock, carefully rubbing and stroking it until she is erect. A mouth like tentacle envelops her cock while others slide over her body and squeeze her breasts.\r\rThe mouth-like tentacle sucks and licks her cock expertly and she quickly cums and it gulps all of it.");
						AddText("Gasping she recovers but feels it is continuing to suck and lick and she becomes erect quickly. The other tentacles reassert and tighten her restraints and rhythmically squeeze her breasts. Smaller ones lightly trace her pussy and anus. She is brought again to a gasping, panting orgasm, spewing her cum which is gobbled down.\r\rHer cock feels a little sore but it still continues to suck her. The small tendrils penetrate her ass and pussy and writhe and tease her erect again. The mouth-like one again makes her cum, which it drinks\rand again\rand again\rand again\rUntil she is sobbing, gasping, and unable to cum.\r\rThey leave the drained girl");
					} else AddText("#slave is near a changing room and is dragged inside. Dark shapes strip her and long tentacles rub over her body, paying special attention to her pussy and clit, carefully rubbing and flicking her clit. A mouth-like tentacle attached to her pussy and licks her clit while others rub her breasts. The tentacle licks and sucks her expertly and she quickly orgasms, even ejaculating a little and it seems to drink it and her other fluids. She recovers and it is still licking and it quickly brings her to orgasm again, and again, and again.\r\rThey leave the drained girl");
					DoSupervisorTentacleSex();
					break;
			}
		}
	}
	
	
	public function NobleWomanTentacleSex()
	{
		temp = Math.floor(Math.random()*3) + 1;
		ShowMovie("EventNobleWoman", 1, temp == 3 ? 3 : 0, temp);
		switch(temp) {
			case 1: 
			case 2:
				AddText(coreGame.SlaveSee + " a group near a cage. It is a small group, all bearing the crest of a noble house.\r\r" + coreGame.SlaveHeSheVerb("move") + " near and " + coreGame.NonPlural("see") + " ");
				AddText("a young noblewoman in a cage with a tentacle monster, being fucked in pussy and ass. Her servants seem to be controlling the situation. " + coreGame.SlaveSee + " the creature orgasm, spewing gouts of cum into the noblewoman, and she screams her own orgasm.\r\rEverything from the scene shows she is doing this deliberately and her servants are here to help her. It seems she is here to enjoy this creatures lusts.");
				AddText("\r\r" + coreGame.SlaveName + coreGame.NonPlural(" turn") + " to leave and hears the noblewoman cry out another orgasm. #slave cannot help but feel aroused.");
				break;
			case 3:
				Backgrounds.ShowRuinedTemple(3);
				AddText(coreGame.SlaveSee + " a group near a cage. It is a small group, all bearing the crest of a noble house.\r\r" + coreGame.SlaveHeSheVerb("move") + " near and " + coreGame.NonPlural("see") + " a noblewoman leading a heavily pregnant maid. The maid looks nervous and the noblewoman orders her to enter a cage.\r\r" + coreGame.SlaveSee + " a tentacle creature wrap itself around the maid. Guards are watching, supervising and controlling the situation. " + coreGame.SlaveSee + " the creature sliding moist tentacles into the maid's pussy and ass and slowly fucks her. " + coreGame.SlaveVerb(" overhear") + " the noblewoman,\r\r");
				PersonSpeak("Noble Woman", "...the offspring she carries needs special nutrients...", true);
				AddText("\r\r" + coreGame.SlaveSee + " the creature cumming strongly into the maid, who is screaming in orgasm.\r\r" + coreGame.SlaveVerb("start") + " to leave and " + coreGame.NonPlural("hear") + " the noblewoman again,\r\r");
				PersonSpeak("Noble Woman", "...to be sure, let it have her a few more times, as we did yesterday...", true);
				break;
		}
	
	}
	
	public function AcolyteTentacleRaid()
	{
		coreGame.HideSupervisor();
		if (coreGame.Supervise) AddText("\r\rYou leave the temple to wait for #slave to change.");
		else AddText("\r\r#assistant leaves the temple to wait for #slave to change.");
		AddText("\r\rAs #slave changes into her normal clothes, preparing to leave, she hears shouts, cries and some moans. She can just run or she can try to help,\r");
		AskHerQuestions(130, 131, 0, 0, "Run", "Try to help", "", "", "What will she do?");
	}
	
	public function SlaveMakerTentacleRape() 
	{
		coreGame.SMChangeMinStats(0, 3);
		coreGame.UpdateSlaveMaker();
		coreGame.HideImages();
		coreGame.HideSlaveActions();
		Backgrounds.ShowTentacles();
		coreGame.HideAllPeople();
		if (SMData.AutoShowSlaveMaker(-10000, 1, 1) == undefined) coreGame.Generic.ShowTentacleSex(coreGame.WalkPlace, SMData.Gender);
		if (SMData.SMDominance > 70) {
			
			Diary.AddEntry("You were also assaulted by tentacle beasts.");
	
			SetText("<b>The things</b> turn their attention to you and coil around you tighter as you struggle more fiercely to escape, sliding under your clothes. They methodically rip them off stripping you completely naked, squeezing your breasts, rubbing your pussy ");
			if (SMData.Gender == 3)AddText(", touching your cock and squeezing your bottom.");
			else AddText("and bottom."); 
			AddText("\r\rA small tentacle slowly inserts itself into your ass while another larger tentacle forcefully enters your pussy and both start fucking.");
			if (SMData.Gender == 3) AddText(" As they do another tentacle wraps itself around your cock, firmly sliding around it and then stroking it faster and faster. ");
			AddText("The tentacles in your pussy and ass fuck faster and faster, until ");
			if (SMData.Gender == 3) AddText("you helplessly cum, your cock erupting and spraying your cum");
			else AddText("you helplessly orgasm");
			AddText(".\r\rThe large tentacle speeds up and then thrusts itself deep and spews a torrent of cum into your womb. The one in your ass convulses and cums into your bowels.");
			AddText("\r\rThey drop you next to #slave and disappear.\r\r");
			
		} else if (SMData.SMDominance > 40) {
			 
			Diary.AddEntry("You were also raped by tentacle beasts.");
	
			SetText("<b>The things</b> turn their attention to you and coil around you tighter as you struggle, sliding under your clothes. You moan in dismay as they methodically rip your clothes off, stripping you completely naked. Tentacles then begin to feel you up, squeezing your breasts, rubbing your pussy");
			if (SMData.Gender == 3) AddText(", touching your cock and squeezing your bottom.");
			else AddText(" and bottom.");
			AddText("\r\rA small tentacle slowly inserts itself into your ass while another larger tentacle forcefully enters your pussy and both start fucking.");
			if (SMData.Gender == 3) AddText(" As they do another tentacle wraps itself around your cock, firmly sliding around it and then stroking it faster and faster. ");
			AddText("The tentacles in your pussy and ass fuck faster and faster, until ");
			if (SMData.Gender == 3) AddText("you helplessly cum, your cock erupting and spraying your cum, crying out in shame.");
			else AddText("you helplessly orgasm, crying out in shame.");
			AddText("\r\rThe large tentacle speeds up and then thrusts itself deep and spews a torrent of cum into your womb. The one in your ass convulses and cums into your bowels.");
			AddText("\r\rThey drop your ravished body next to #slave and disappear.\r\r");
	
		} else if (SMData.SMDominance > 20) {
			
			Diary.AddEntry("You were also fucked by tentacle beasts.");
	
			SetText("You have been watching your slave get completely ravished by the things. As she cries out her forced orgasms, your arousal grows at a rapid rate, leaving you breathless, your breasts heaving");
			if (SMData.Gender == 3) AddText(", your cock hard as a rock");
			AddText(" and your pussy needy. Sensing your desire to be mated, the tentacle beasts slackens their grip on you as they concentrate on reducing your slave into a puddle of satiated female flesh. You take this opportunity to prepare yourself, feeling like a complete slut for wanting to fuck the beasts, ");
			if (SMData.WeaponType > 0) AddText("discarding your weapon, ");
			if (coreGame.ArmourType > 0) AddText("unbuckling your armor, ");
			AddText("stripping off your clothing and underwear, and tossing them away.");
			AddText("\r\rHaving finally rendered your slave unconscious by the intensity of her orgasms, the creatures turn their attention to you naked before them. Their tentacles reach out, squeezing your breasts, rubbing your pussy");
			if (SMData.Gender == 3) AddText(", touching your cock and squeezing your bottom. ");
			else AddText(" and bottom. ");
			AddText("You moan at the contact, feeling the suckers clamping on your nipples and clit, hungry for more.");
			AddText("\r\rThe tentacles begin to coil around you more tightly, holding your arms and legs spread apart and tentacles inserts themselves into your ass and your wet pussy and both start fucking. ");
			if (SMData.Gender == 3) AddText("As they do another tentacle wraps itself around your cock, firmly sliding around it and then stroking it faster and faster. ");
			AddText("Yet another tentacle hovers in front of you and plunges into your openly inviting mouth. The tentacles fuck you faster and faster, mauling your breasts and sucking hard at your nipples and clit until the wondrous sensations overcome you as ");
			if (SMData.Gender == 3) AddText("you helplessly cum, your cock erupting and spraying your cum.");
			else AddText("you helplessly orgasm.");
			AddText("\r\rThe large tentacles speeds up and then thrusts itself deep and spews a torrent of cum into your womb and bowels as you swallow the gushing tentacle in your mouth. The creatures doesn't let up and instead continues to fuck you at an even greater intensity as you continue to orgasm over and over, crying out in passion and lust, until you were finally overcomed by the pleasure.");
	
			if (coreGame.SMConstitution < 60) AddText("\r\rA while later, having sated their lusts on your body, they drop your drained body next to #slave and disappear.");
			else  AddText("\r\rA while later, having sated their lusts on your body, they drop your drained body next to #slave. You slowly stir to as you feel the tentacles leaving your well used pussy and ass, copious amounts of tentacle cum leaking out. In a post-orgasmic daze you watch with in contentment as they disappear, eating spent tentacle cum covering your body. A small part of you hopes to be discovered by other beasts or unscrupulous men.");
	
		} else {
			Diary.AddEntry("You were also used by tentacle beasts.");
	
			SetText("You have been watching your slave get completely ravished by the beasts. As she cries out her forced orgasms and the tentacles hold you down firmly, your arousal burns fiercely at your helplessness, leaving you short of breath, your breasts heaving");
			if (SMData.Gender == 3) AddText(", your cock hard as a rock");
			AddText(" and your soaking pussy needing to be fucked. Sensing your desire to be mated, the tentacle beasts slackens their grip on you as they concentrate on reducing your slave into a puddle of satiated female flesh. You take this opportunity to prepare yourself, a complete slut for desparately wanting to be fucked by the beasts, ");
			if (SMData.WeaponType > 0) AddText("discarding your weapon, ");
			if (SMData.ArmourType > 0) AddText("unbuckling your armor, ");
			AddText("stripping off your clothing and underwear tossing them away, ");
			AddText("and pressing your naked flesh against nearby tentacles, trying to get them to fuck you.");
			AddText("\r\rHaving finally rendered your slave unconscious by the intensity of her orgasms, the creatures turn their attention to you naked before them. Their tentacles reach out, squeezing your breasts, rubbing your pussy and bottom. ");
			if (SMData.Gender == 3) AddText("You moan passionately at the contact, feeling the suckers clamping on your nipples and sucking on your cock, begging for more.");
			else AddText("You moan passionately at the contact, feeling the suckers clamping on your nipples and clit, begging for more.");
			AddText("\r\rThe tentacles begin to coil around you more tightly, holding your arms and legs spread apart as you thrust out your dripping and needy pussy at the mass of tentacles before you. The tentacles tease and taunt you for a bit as you begged to be fucked and used. Then large tentacles inserts themselves into your ass and your wet pussy and both start fucking. ");
			if (SMData.Gender == 3) AddText("As they do another tentacle wraps itself around your cock, firmly sliding around it and then stroking it faster and faster. ");
			AddText("Yet another tentacle hovers in front of you and plunges into your openly inviting mouth. The tentacles fuck you faster and faster, mauling your breasts and sucking hard at your nipples and clit until the wondrous sensations overcome you as ");
			if (SMData.Gender == 3) AddText("you helplessly cum, your cock erupting and spraying your cum.");
			else AddText("you helplessly orgasm.");
			AddText("\r\rThe large tentacles speeds up and then thrusts itself deep and spews a torrent of cum into your womb and bowels as you swallow the gushing tentacle in your mouth. The creatures doesn't let up and instead continues to fuck you at an even greater intensity as you continue to orgasm over and over, crying out in passion and lust, until you were finally overcomed by the pleasure.");
			if (SMData.SMConstitution < 60) AddText("\r\rA while later, having sated their lusts on your body, they drop your used and spent body next to #slave and disappear.");
			else AddText("\r\rA while later, having sated their lusts on your body, they drop your used and spent body next to #slave. You slowly stir to as you feel the tentacles leaving your well used pussy and ass, copious amounts of tentacle cum leaking out, and in a post-orgasmic daze you watch with quiet discontent as they disappear. To console yourself, you scoop up tentacle cum from your body and the ground around you to savour its taste. Soon, you have eaten most of the cum on you but instead of recovering your discarded items, you begin to drag yourself over to your slave's unconscious body covered in tentacle cum. As you lap at her leaking cum filled pussy, a part of you hopes to be discovered by other beasts or unscrupulous men.");
		} 
		ShowPlanningNext();
	}
	
	public function CheckTentacleWalk(strSlain:String, strWalk:String)
	{
		trace("CheckTentacleWalk: " + coreGame.TentacleHaunt + " " + coreGame.WalkPlace);
		if (coreGame.TentacleHaunt == (coreGame.WalkPlace + 1000)) {
			AddText(strSlain);
			coreGame.TentacleHaunt = -1;
			return;
		}
		if (coreGame.TentacleHaunt == (coreGame.WalkPlace + 2000)) {
			coreGame.modulesList.eventsSM.DemonHelpAndRape(strWalk);
			return;
		}
		
		if (!IsTentacleEncounter(coreGame.WalkPlace)) return;
		
		if (SMData.sTentacleExpert == 3) {
			coreGame.HideImages();
			coreGame.config.ShowMonster("tentacle", 1, 1, 4);
			Backgrounds.ShowOverlay(0);
			SMData.ShowSlaveMaker();
			SetText("You realise that the tentacle beasts are present in the place #slave is about to go to. Do you have #slave avoid where the creatures are likely to be?");
			coreGame.DoYesNoEvent(150);
			return;
		}
		coreGame.SetEvent("TentacleSex");
	}

	
	public function HideAsAssistant()
	{
		super.HideAsAssistant();
		
		mcBase.EventMorningTentacleVision._visible = false;
		mcBase.EventNobleWoman._visible = false;
		mcBase.EventAcolyteTentacleRaid._visible = false;
		mcBase.Nuns._visible = false;
		mcBase.Offspring._visible = false;
		if (this.ClipTentacleHarem._visible) {
			this.ClipTentacleHarem.gotoAndStop(17);
			this.ClipTentacleHarem.Female1.stop();
			this.ClipTentacleHarem.gotoAndStop(18);
			this.ClipTentacleHarem.Female2.stop();
			this.ClipTentacleHarem._visible = false;
		}
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();
		
		this.ClipTentacleHarem = mcBase.ClipTentacleHarem;
	}
}
