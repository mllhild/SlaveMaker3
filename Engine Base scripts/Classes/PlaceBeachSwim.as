// Beach (Swim)
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceBeachSwim extends PlaceBeach
{
	// constructor
	public function PlaceBeachSwim(mc:MovieClip, cg:Object, cc:City)
	{
		super("BeachSwim", mc, cg, 9.2, cc);
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(7);
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "Day-SwimFar-6";	// set default event

		this.AddEvent("Day-Tama-1");
		this.AddEvent("Day-Offering-2");
		this.AddEvent("Day-MuscleGirl-3");
		this.AddEvent("Day-TinyBikini-4");
		this.AddEvent("Day-DemonGirl-5");
		this.AddEvent("Day-SwimFar-6");
		this.AddEvent("Day-LostSwimsuit-7");
		this.AddEvent("Day-MermaidDiving-8");
		this.AddEvent("Day-MermaidDiving-8.5", true);
		this.AddEvent("Night-MermaidAssault-9");
		this.AddEvent("Night-MeetSwimmer1-10");
		this.AddEvent("Night-MeetSwimmer2-11");
		this.AddEvent("Night-Nothing1-12");
		this.AddEvent("Night-Nothing2-13");
		this.AddEvent("Night-Nothing3-14");
	}
	
	public function SwimAtBeach() {
		coreGame.WalkPlace = 9.2;
		
		if (_root.Day && !IsEventPicked()) {
			ShowPerson(17, 0, 1, 1);
			if (slaveData.slSwimming < 2) SetText(coreGame.SlaveIs + " not " + coreGame.Plural("a good swimmer") + " yet, and could learn more.\r\r" + coreGame.NameCase(coreGame.NonPlural("does")) + " #slaveheshe take a lesson with Alsha, the Swimming Instructor?");
			else SetText(coreGame.SlaveIs + coreGame.Plural(" a fine swimmer") + " but can possibly learn more.\r\r" + coreGame.NameCase(coreGame.NonPlural("does")) + " #slaveheshe take a lesson with Alsha, the Swimming Instructor?");
			coreGame.DoYesNoEvent(4304);
		} else {
			// Select the event and show it 
			super.DoWalkLoaded(this.mcBase,this.ModuleName);
		}
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) {
		
		HidePerson(17);
		coreGame.ShowPlanningNext();
		
		super.GetWalkEvent(exclude,sequential);
		
		if (coreGame.StrEvent == "") return;
		
		if (coreGame.StrEvent == "Day-MermaidDiving-8" && coreGame.PercentChance(25)) ChangeWalkEvent("Day-MermaidDiving-8.5");
		if (coreGame.StrEvent == "Night-MermaidAssault-9" && coreGame.BeachSwim.CheckBitFlag(38)) ChangeWalkEvent("Night-Nothing1-12");
		
		coreGame.slSwimming += 0.1;
		coreGame.ShowSupervisor();
		
		if (IsDayTime()) coreGame.Backgrounds.ShowBeach(1);
		else coreGame.Backgrounds.ShowBeach(4);
	}
	
	public function HandleWalk():Boolean {
		coreGame.SMTRACE("BeachSwim::HandleWalk "+coreGame.StrEvent);
		
		if (super.HandleWalk()) return true;

		switch (coreGame.StrEvent) {

		// Tama
		case "Day-Tama-1":
			slaveData.DifficultyExhib--;
			parentCity.MeetPerson(0, 0, "tama");
			if (this.CheckBitFlag(33)) {
				if (this.CheckBitFlag(34)) {
					ShowMovie("BeachWalk/Swimming", 1, 1, 4);
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0);
					AddText(" walking in the shallows, she seems very distracted, her cock erect and she is lightly touching her breast and cock. #slave" + coreGame.NonPlural(" speak") + " to her but she is very aroused and starts stroking her cock while talking. She cums very quickly, her cum spraying over #slave. Tana sighs and resumes walking, holding her still erect cock.\r\r#slave" + coreGame.NonPlural(" swim") + " for a while and while walking back " + coreGame.NonPlural("see") + " Tana urgently fucking a girl in the shallows. Tana is fucking her doggie-style and " + coreGame.SlaveSee + " Tana cry out cumming into the girl's pussy. The girls moans, orgasming as well. Tana pulls her cock out, dripping with her cum and she slides it into the girl's ass and resumes fucking just as urgently.\r\r#slave" + coreGame.NonPlural(" leave") + " as Tana cums again...");
				} else {
					ShowMovie("BeachWalk/Swimming", 1, 1, 2);
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0);
					AddText(" walking in the shallows, she seems very distracted, she is lightly touching her breast and pussy. #slave" + coreGame.NonPlural(" speak") + " to her but she is very aroused and starts rubbing her pussy while talking. She orgasms very quickly, and Tana sighs and resumes walking, lightly rubbing her pussy.\r\r#slave" + coreGame.NonPlural(" swim") + " for a while and while walking back " + coreGame.NonPlural("see") + " Tana kneeling in the shallows being fucked by a young man. Tana is being fucked doggie-style and " + coreGame.SlaveSee + " Tana cry out orgasming. The young man groans, cumming into Tana's pussy. Tana starts licking the man's cock, clearly wanting more...");
				}
				this.ClearBitFlag(33);
				
			} else {
				if (this.CheckBitFlag(34)) {
					ShowMovie("BeachWalk/Swimming", 1, 1, 3);
					Points(0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0);
					if (this.CheckBitFlag(32)) {
						AddText("walking in the shallows, looking quite happy and still quite naked, her cock swinging free and lovely and firm. She does not appear to be as affected or just so aroused as she was last time.\r\rShe chats with #slave and then happily plays and swims, completely naked.");
					} else AddText("walking in the shallows, she is completely naked and unconcerned that her lovely cock is hanging loose.\r\rThey speak for a bit and #slave" + coreGame.NonPlural(" ask") + " about her swimsuit, and Tana explains that she has hidden it away, and only wore it so she could get onto the beach.");
				} else {
					ShowMovie("BeachWalk/Swimming", 1, 1, 1);
					Points(0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0);
					if (this.CheckBitFlag(32)) {
						AddText("walking in the shallows, looking quite happy and still quite naked. She does not appear to be as affected or just so aroused as she was last time.\r\rShe chats with #slave and then happily plays and swims, completely naked.");
					} else AddText("walking in the shallows, she is completely naked and unconcerned.\r\rThey speak for a bit and #slave" + coreGame.NonPlural(" ask") + " about her swimsuit, and Tana explains that she has hidden it away, and only wore it so she could get onto the beach. She dislikes clothes and loves being naked and would be naked permanently if she could.\r\r" + coreGame.SlaveVerb("consider") + " #slavehisher attitude to showing " + coreGame.SlaveHisHer + coreGame.Plural("body") + ".");
				}
				this.SetBitFlag(33);
			}
			this.SetBitFlag(32);
			return true;

		// Offering
		case "Day-Offering-2":
			if (coreGame.IsDickgirlEvent()) {
				SetText("#slavesee a woman wading out into the water, and is impressed when the woman pulls out a rather large cock from her swimsuit, impressed by it's size and how she concealed it.\r\rThe woman slowly strokes her cock and whispers something, and glances mischievously at #slave. With her free had she waves for #slave to join her,\r\r");
				PersonSpeak("Woman", "I am making an offering to Manannán the God of the Sea and the afterlife. I offer my seed as a salty representation of the sea and as he is a gateway of life, the afterlife but still life. I will make offering as many times as I physically can, aided by a potion hopefully that will be many.\r\rPlease join me and make your own offering too.", true);
				AddText("\r\rShe speeds up stroking her cock while looking admiringly at #slave's " + coreGame.Plural("body") + " and she cries out 'Manannán' and thick ropes of cum erupt from her cock, arcing through the air into the sea. She smiles, stroking her cock slower, and says,\r\r");
				PersonSpeak("Woman", "Thanks for the assistance, you are quite sexy. I will make another offering soon, would you care to as well?", true);
				if (SMData.SMFaith == 2) {
					if (coreGame.HasCock) AddText("\r\r#slave happily assists, masturbating and offering #slavehisher cum as well.");
					else AddText("\r\r#slave happily assists, masturbating and offering #slavehisher pussy juice as well.");
					if (Supervise) AddText(" You also make an offering...");
					else AddText("#assistant makes an offering too...");
				} else AddText("\r\r#slave" + coreGame.NonPlural(" refuse") + " explaining that " + coreGame.SlaveHeSheIs + " not of their faith. The woman smiles and continues to make her offerings.");
				ShowMovie("BeachWalk/Swimming", 1, 3, 5);
				coreGame.OldNumEvent = 2.1;
			} else {
				SetText("#slavesee a small group of people out in the water, away from other. As " + coreGame.SlaveHeShe + coreGame.NonPlural(" near") + " " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " that they are all having sex in pairs, threesomes. A person swims over and says,\r\r");
				PersonSpeak("Swimmer", "We are making offerings to Manannán the God of the Sea and the afterlife. We offer our seeds and juices as a salty representation of the sea and as he is a gateway of life, the afterlife but still life. We will make offerings as many times as we physically can, aided by potions hopefully.\r\rPlease join us and make your own offering too.", true);
				if (SMData.SMFaith == 2) AddText("\r\r#slave happily swims over to join and offer #slavehisher passion and body.");
				else AddText("\r\r#slave" + coreGame.NonPlural(" refuse") + " explaining that " + coreGame.SlaveHeSheIs + " not of their faith. The person smiles and rejoins the others to make their offerings.");
				ShowMovie("BeachWalk/Swimming", 1, 1, 6);
				coreGame.OldNumEvent = 2.2;
			}
			if (SMData.SMFaith == 2) Points(0, 0, -2, 0, 3, 1, 0, 0, 0, 2, 2, 0, 2, 0, -4, 0, 4, 1, 0, 0);
			else Points(0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0);
			return true;

		// Confused muscle dickgirl/Lesbian wrestling
		case "Day-MuscleGirl-3":
			if (coreGame.IsDickgirlEvent() && !this.CheckBitFlag(36)) {
				if (this.CheckBitFlag(35)) {
					this.SetBitFlag(36);
					SetText(coreGame.SlaveMeet + " again the woman who had grown a cock while swimming, sitting on the same rock in the water, again naked and her large cock is quite erect. " + coreGame.SlaveVerb("ask") + "how she is and she smiles,\r\r");
					PersonSpeak("Woman", "Wonderful, I have completely accepted the gift of my cock and use it whenever I can on whoever I can.", true);
					if (SMData.SMSpecialEvent == 6 && Supervise) {
						AddText("\r\rShe looks at you and says,\r\r");
						PersonSpeak("Woman", "Unlike you, you have still to accept your gift.", true);
					}
					AddText("\r\rShe excuses herself, explaining she has a person she is teaching the joy of cocks and have to leave...");
					Points(0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0);
					coreGame.OldNumEvent = 3.2;
				} else {
					SetText(coreGame.SlaveMeet + " a woman sitting on a small rock in the water, she is naked and has a large erect cock, and looks a little confused. She sees #slave and asks what the time is. She then explains,\r\r");
					PersonSpeak("Confused Woman", "I was swimming and something strange happened, I feel a strain or stretching feeling and my swimsuit ripped off. I climbed out and I have a cock now! My body seems a bit different too, maybe a bit larger. What happened!\r\rI did have that intense encounter last night, she was well built and endowed, but it is not like cocks are contagious. I also had such weird dreams last night.", true);
					if (SMData.SMSpecialEvent == 6 && Supervise) {
						AddText("\r\rYou feel an intense arousal as the woman speaks. She looks at you and screams, cumming gouts of cum from her cock. She collapses and you move uncontrollably to her and thrust your hard cock into her. You fuck her, totally out of control, until you scream and cum in her.\r\rYou recover your senses and look at the woman and #slave. Possibly some after effect of the woman's transformation. You leave the woman recovering on the rock...");
					} else AddText("\r\rThey talk a little more and then part as the woman decides to swim to shore and return home.");
					Points(0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0);
					this.SetBitFlag(35);
					this.RepeatEvent(5);
					coreGame.OldNumEvent = 3.1;
				}
				ShowMovie("BeachWalk/Swimming", 1, 1, 7);
			} else {
				slaveData.DifficulyLesbian--;
				SetText("#slavesee two women wrestling or maybe fighting. " + coreGame.SlaveHeSheUC + coreGame.NonPlural(" swim") + " to help, but " + coreGame.NonPlural("stop") + " as " + coreGame.SlaveSee + " that they are not fighting, they are aggressively, enthusiastically having lesbian sex, mostly in a 69 position but varying. There are a few people watching, some look embarrassed, some just aroused.\r\r" + coreGame.SlaveIs + " quite aroused and a little embarrassed. " + coreGame.NameCase(coreGame.SlaveHeSheIs) + " curious about trying such a different style of sex.");
				Points(0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 3, 0, 3, 0, 2, 1, 0, 0);
				ShowMovie("BeachWalk/Swimming", 1, 1, 8);
				coreGame.OldNumEvent = 3.3;
			}
			return true;
			
		// Tiny Bikini
		case "Day-TinyBikini-4":
			slaveData.DifficultyExhib--;
			SetText(coreGame.SlaveMeet + " a young women floating in the water. Her swimsuit is scandalously small, just barely covering her nipples and pussy, but nothing else. " + coreGame.SlaveVerb("talk") + " to her a little about her swimsuit and about wearing it. The woman smiles and explains how a swimsuit is required here, but not how much of a swimsuit. Besides her lovers really like her in it! ...and out of it...\r\r" + coreGame.SlaveVerb("consider") + " #slavehisher attitude to clothing and exposing her body.");
			Points(2, 0, 0, 0, -1, 1, 0, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0);
			ShowMovie("BeachWalk/Swimming", 1, 1, 9);
			return true;
			
		// Demon Girl
		case "Day-DemonGirl-5":
			if (this.CheckBitFlag(37)) SetText(coreGame.SlaveMeet + " again the young woman dressed as a demon and the girl runs up and hugs #slave.");
			else {
				SetText(coreGame.SlaveMeet + " a young woman playing in the water. She is dressed as a demon in a very convincing costume. " + coreGame.SlaveVerb("compliment") + " her costume,\r\r");
				PersonSpeak("Girl", "Sure, a costume. Did you know some claim demons like to play here, just play no corrupting of souls or whatever. Well there is <i>Her</i> but if you avoid the triple rocks at midnight you will be fine.\r\rRace you to the island and back!", true);
				this.SetBitFlag(37);
			}
			AddText("\r\r" + coreGame.SlaveVerb("play") + " happily with the girl until " + coreGame.SlaveHeSheHas + " to leave.");
			Points(0, 1, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0, 0);
			ShowMovie("BeachWalk/Swimming", 1, 1, 10);
			this.NoRepeatEvent(5);
			return true;
			
		// Swimming out far
		case "Day-SwimFar-6":
			SetText(coreGame.SlaveVerb("swim") + " out a long way and " + coreGame.SlaveHeSheVerb("see") + " a woman floating nearby. She waves to #slave and they swim back to shore together.\r\rThe girl suggests another lap, out to sea and back for more exercise and " + coreGame.SlaveVerb("agree") + ".");
			Points(0, 1, 0, 0, 0, 1, 0, 0, -2, 0, 0, 0, -1, 0, 0, 0, 2, 1, 0, 0);
			slaveData.FatigueBonus += 0.5;
			ShowMovie("BeachWalk/Swimming", 1, 1, 11);
			return true;
			
		// lost swim suit
		case "Day-LostSwimsuit-7":
			ShowMovie("BeachWalk/Swimming", 1, 1, 15);
			this.NoRepeatEvent(7);
			SetText(coreGame.SlaveMeet + " a women floating in the water, and she looks quite embarrassed. " + coreGame.SlaveVerb("ask") + " if there is anything wrong and the woman explains,\r\r");
			PersonSpeak("Embarrassed Woman", "I was, well, making love to my dear and feel asleep. When I awoke the tide had washed away my swimsuit. My dear has left to return to their duties long ago.\r\rI cannot walk around naked, I am unsure what to do.\r\rCould you go an buy me a swimsuit, there is a small place nearby. It does not carry the type I like or find normally agreeable but it will have to do. I cannot pay now, obviously, but I will send the money to you as soon as I get home. The suits are a bit expensive, 200GP", true);
			if ((slaveData.VarGold + slaveData.SMGold) >= 200) {
				AddText("\r\rDoes #slave get the swimsuit?");
				slaveData.DoYesNoEventXY(4305);
				return true;
			}
			if (Supervise) AddText("\r\rYou apologise and tell her that you do not have enough money.\r\r");
			else AddText("\r\r#assistant apologises and tells her that they do not have enough money.\r\r");
			SetEvent(4305);
			DoEventNoAsAssistant();
			return true;
			
		// meet mermaid or deep dive
		case "Day-MermaidDiving-8":
			SetText(coreGame.SlaveVerb("swim") + " out and " + coreGame.SlaveHeSheVerb("dive") + " a bit.\r\r" + coreGame.SlaveVerb("enjoy") + " the swim.");
			Points(0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0);
			return true;
			
		case "Day-MermaidDiving-8.5":
			SetText(coreGame.SlaveVerb("swim") + " out and " + coreGame.SlaveHeSheVerb("dive") + " a bit. Underwater " + coreGame.SlaveSee + " a mermaid swimming gracefully in the depths. The mermaid is unearthly beautiful and agile, and she waves to #slave before swimming away.\r\r" + coreGame.SlaveVerb("admire") + " the elegance of the mermaid and " + coreGame.Plural("is") + " happy #slaveheshe saw her.");
			Points(0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0);
			ShowMovie("BeachWalk/Swimming", 1, 1, slrandom(3) + 11);
			return true;
	
		case "Night-MermaidAssault-9":
			this.SetBitFlag(38);
			ShowMovie("BeachWalk/Swimming", 1, 1, 17);
			AddText("#slavesee a commotion and hears a cry for help. Out in the water " + coreGame.SlaveHeSheVerb("see") + " a man holding a mermaid who is calling for help, but he has overpowered her.\r\rThe man appears to be trying to bind her probably to take her as a slave\r\r");
			if (Supervise) AddText("You are annoyed with the man and tell #slave that mermaids make very poor slaves, they utterly hate captivity and living on the land. They are very clever and very skilled and it is very hard to keep them from escaping. Mermaids are not human after all and you have heard it said that they are not merely long lived like the elven folk, but truly immortal. One concern you have is the rumours you have heard that to <b>eat</b> a mermaid's flesh will make you immortal too. You fear the man has these dark desires.");
			else AddText(slaveData.ServantIs + " annoyed with the man and tells #slave that mermaids make very poor slaves, they utterly hate captivity and living on the land. They are very clever and very skilled and it is very hard to keep them from escaping. Mermaids are not human after all and you have heard it said that they are not merely long lived like the elven folk, but truly immortal. One concern " + coreGame.ServantHeSheHas + " is the rumours " + coreGame.ServantHas + " heard that to <b>eat</b> a mermaid's flesh will make you immortal too. #assistant fears the man has these dark desires.");
			AddText("\r\r#slave looks horrified and,\r\r");
			coreGame.AskHerQuestions(4320, 4321, 4322, 0, "Swim in to help", "Look to #super for help", "Scream for help", "", coreGame.SlaveVerb("decide") + " to");
			return true;
			
		case "Night-MeetSwimmer1-10":
			coreGame.ShowMovie(coreGame.BeachWalk.mcBase.Swimming, 1, 1, 19);
			Points(0, 1, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			AddText(coreGame.SlaveMeet + " another girl out swimming and they have a chat. The girl is surprised to see other swimmers and seems a little embarrassed. When asked she confesses that she was planning to meet her lover and thought #slave was him.");
			return true;
			
		case "Night-MeetSwimmer2-11":
			coreGame.ShowMovie(coreGame.BeachWalk.mcBase.Swimming, 1, 1, 20);
			Points(0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
			AddText(coreGame.SlaveMeet + " another girl out swimming and they have a chat. They girl is happy to see other swimmers and welcomes the company.");
			return true;

		}

		return false;
	}
	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// 4300 - walk beach - swim
			 case 4300:
				ResetWalkEvent();
				SwimAtBeach();
				return true;
		
			// 4320 - Beach Swim - Mermaid Rescue - Swim to Help
			case 4320:
				if (coreGame.slCombat > 0) coreGame.slCombat++;
				Points(0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 2, 0, 0, 0);
				if (CustomFlag == -1) CustomFlag = 4;
				else CustomFlag += 4;
				ShowMovie("BeachWalk/Swimming", 1, 1, 18);
				SetLastMovieColour(-200, -70, 0);
				AddText(SlaveVerb("swim") + " quickly towards the mermaid and her attacker. The man is absorbed in wrestling the mermaid, but she notices #slave and starts struggling more.\r\r" + SlaveVerb("grab") + " the man's arm and " + NonPlural("pull") + " a rope free from the mermaid. The mermaid shouts and bites the man's wrist, she has sharp teeth and there is a small spray of blood. The man yells and " + SlaveVerb("pull") + " him away from the mermaid and the mermaid dives into the water.\r\rHe turns angrily to #slave and raises his uninjured hand to strike #slavehimher. Suddenly there is a flash as the mermaid's tail sweeps out of the water and strikes him in the head, stunning him. " + SlaveVerb("feel") + " the mermaid grab #slavehisher" + Plural(" hand") + " and pull #slavehimher underwater. There is a rush in the dark water as the mermaid pulls #slave along undersea until they surface near #super.\r\rThe mermaid hugs #slave wordlessly and then kisses #slavehisher lips and whispers in a slightly odd, but sensual, voice 'Thank you'. She quickly dives into the water as #super can see the man approaching slowly.\r\r" + NameCase(coreGame.SupervisorName) + " and #slave run away from the angry man, quickly losing him in the dark.");
				return true;
				
			// 4321 - Beach Swim - Mermaid Rescue - Look to supervisor
			case 4321:
				if (Supervise) {
					SMData.SMPoints(1, 0, 0, 0, 0, 0, 0, 0, 0);
					Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 1, 3, 0);
					AddText("You swim quickly towards the mermaid and her attacker. The man is absorbed in wrestling the mermaid, but she notices you and starts struggling more.\r\rYou strike the man hard on his head and he slumps unconscious into the water. You free the mermaid and she looks very angrily at the man. She takes a small knife from her waist band, intent on some sort of revenge.\r");
					AskHerQuestions(4323, 4324, 4325, 0, "Let Her", "Stop Her", "Help Her", "", "What do you do?");
		
				} else {
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 2, 0, 0, 0, 0, 0, 0);
					SetText(SlaveVerb("look") + " to #assistant to do something. #assistant explains that " + coreGame.ServantHeSheHas + " a duty to #slavemakername not to the poor mermaid, but if " + SlaveVerb("want") + " to do something, then " + coreGame.SlaveHeSheIs + " welcome.\r\r" + SlaveVerb("nod") + " #slavehisher" + Plural(" head") + "...\r\r");
					SetEvent(4320);
					DoEventNextAsAssistant();
				}
				return true;
				
			// 4322 - Beach Swim - Mermaid Rescue - Scream for Help
			case 4322:
				Points(0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 2, 1, 0, 0);
				if (CustomFlag == -1) CustomFlag = 1;
				else CustomFlag++;
				parentCity.GetPlaceObject("BeachWalk").mcBase.Swimming._visible = false;
				SetText(SlaveName + NonPlural(" scream") + " out for help, loudly and continually. The man starts, looking at #slavehimher and as he does the mermaid turns and bites him on the shoulder. He cries out in pain and even from there #super can see blood. He loosens his grip on her and she breaks free and dives into the sea.\r\rA moment later she surfaces again, and gives #slave a grateful wave, and dives again.\r\rThe man looks at #slave angrily and swims back to shore.");
				return true;
				
			// 4323/4324/4325 - Beach Swim - Mermaid Rescue - Mermaid Revenge
			case 4323:
			case 4324:
			case 4325:
				ShowMovie("BeachWalk/Swimming", 1, 1, 18);
				SetLastMovieColour(-200, -70, 0);
				if (coreGame.NumEvent == 4324) {
					SMData.SMPoints(0, 0, 0, 0, 0, 0, -5, 0, 0);
					SetText("You try to stop her, but she is inhumanly agile and slides past you and");
				} else if (coreGame.NumEvent == 4325) {
					SMData.SMPoints(0, 0, 0, 0, 0, 0, 5, 0, 0);
					SetText("You hold the man ready for the mermaid's vengeance and");
				} else SetText("As you watch");
				AddText(" she cuts off one of the man's fingers! She quickly binds the stump with a piece of thread as the man screams. You hit him again and he passes out. The mermaid looks at you with an odd expression, maybe amused but with an inhuman quality. You move the man onto a small rock outcrop so he does not drown.\r\rShe takes your hand and swims with you back to #slave.\r\rThe mermaid looks at you and says in an odd, unearthly, sensual voice,\r\r");
				PersonSpeak("Mermaid", "Thank you for your rescue. He is now punished as should any who try to steal eternity. Live your life, not another's.", true);
				AddText("\r\rShe embraces you and kisses you passionately, before pulling back and diving into the sea.\r\r");
				return true;
		}		
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {

			// 4304 - Beach Swim - take a lesson
			case 4304:
				coreGame.DoSchoolSwimming();
				return true;
				
			// 4305 - Beach Swim - Get lost swimsuit
			case 4305:
				Points(0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 3, 0, 0, 0);
				Money(100);
				ShowMovie(mcBase.Swimming, 1, 1, 16);
				SetText("#slave visits the small shop to buy the swimsuit. " + NameCase(coreGame.SlaveHeSheIs) + " surprised at the rather erotic and just plain kinky things for sale and buys a swimsuit.\r\r" + SlaveVerb("return") + " and the woman puts on the suit. She looks a bit embarrassed as the suit is translucent but thanks #slave and leaves, blushing.\r\rLater payment is sent to your home, with a bonus 100GP.");
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {

			// 4304 - no do not take a lesson
			case 4304:
				ResetEventPicked();
				temp = Math.floor(Math.random()*100);
				DoWalkLoaded(mcBase, ModuleName);
				return true;
				
			// 4305 - No do not get swimsuit
			case 4305:
				Points(0, 2, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0);
				AddText("The woman blushes and stands and starts walking back, trying to cover herself with her hands and arms. She is very , very embarrassed. " + SlaveVerb("wonders") + " why she is so ashamed of her body.");
				coreGame.DifficultyExhib -= 2;
				return true;
		}
		return false;
	}
}