//
// Puppy Training
//
// Core Variables
// coreGame.Catgirl:Boolean
// slaveData.slPuppyTraining:Number, 0-100, max 60/100
// coreGame.sPuppyTrainer:Number, 2 levels
//       1 - cat slave
//       2 - catgirl
// coreGame.PuppygirlInterest, level of sPuppyTrainer needed to train (3 = impossible)
//
// Core Functions
// coreGame.ChangePuppyTraining(val:Number)
// slaveData.IsPuppygirl():Boolean
// function IsPuppygirlComplete() : Boolean 
// function IsPuppygirlTraining() : Boolean {
	
// Core BitFlags
// 1  - 58 - puppygirl
// 1  - 57 - started puppygirl training
// 1  - 59 - accepted wolfgirl training
//
// Items
// 29 = Puppy Ears
// 30 = Puppy Tail
//
// PuppyTrzining event bit flags
// 0 = met Gustaf
//
//
// Translation status: INCOMPLETE
import Scripts.Classes.*;

class PuppyTraining extends TrainingBase
{	
	public function PuppyTraining(cgm:Object)
	{
		super(undefined, cgm);
		this.ModuleName = "PuppygirlTraining";
	}

	public function IsTrainingEvent(ev:Object) : Boolean
	{
		if (!bEventsAllowed || !slaveData.IsPuppygirl()) return false;
		return IsTrainingComplete(coreGame.slaveData) ? PercentChance(15) : PercentChance(33);
	}

	
	// Training
	
	public function StartTraining(type:Number)
	{
		ResetEventPicked();
		XMLGeneral("StartPuppygirlTraining", true, xNode);
		if (coreGame.SlaveGirl.StartPuppygirlTraining(type) != true) {
			// default image?
		}
		if (coreGame.NumEvent != 0) return;
		Diary.AddEntry("#slave started training as a puppy slave.");
		coreGame.ShowStatisticsTab(2);
		slaveData.BitFlag1.SetBitFlag(57);
		coreGame.HideDresses();
		coreGame.SelectEquipment.Hide();
		coreGame.HideEquipmentButton();
		coreGame.ShowDress();
		DoEvent(9706);
		if (slaveData.slPuppyTraining < 1) {
			slaveData.slPuppyTraining = 1;
			coreGame.slPuppyTraining = 1;
			coreGame.UpdateSlave();
		}
	}
	
	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		return sd.BitFlag1.CheckBitFlag(57) || sd.BitFlag1.CheckBitFlag(58) || sd.BitFlag1.CheckBitFlag(59);
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		return sd.BitFlag1.CheckBitFlag(58) || sd.BitFlag1.CheckBitFlag(59);
	}
	
	public function ChangeTraining(val:Number, sd:Slave) { sd.ChangePuppyTraining(val); }
	
	
	// People
	
	public function MeetPersonAsAssistant(person:Number, choice:Number, personstr:String, say:String, evt:String) : Boolean
	{
		switch(personstr) {
			
			case "puppygirl":
			case "milly":
				MeetPuppyGirl();
				return true;
				
		}
		return false;
	}
	
	//public function AfterMeetPersonAsAssistant(person:Number, choice:Number) { }
	
	
	// Items
	
	public function WearItemAsAssistant(item:Number) : Boolean
	{
		if (item == 29) {
			if (slaveData.IsPonygirl()) {
				SetLangText("NoPonygirlPuppygirls", xNode);
				return false;
			}
			if (slaveData.IsCatgirl()) {
				SetLangText("NoPuppygirlCatgirls", xNode);
				return false;
			}
			if (slaveData.IsDressPuppyEars()) {
				SetLangText("AlreadyHasPuppyEars", xNode);
				Bloop();
				return false;
			}
			if (SMData.sPuppyTrainer < slaveData.PuppygirlInterest) {
				XMLGeneral("RefusePuppygirlEars", true, xNode);
				coreGame.SlaveGirl.ShowRefusePuppygirl(29);
				coreGame.SelectEquipment.ShowOtherEquipment();
				Bloop();
				return false;
			}
			if (coreGame.slaveData.ItemsWorn.CheckBitFlag(30)) {
				StartTraining(item);
				if (coreGame.NumEvent == 9706) coreGame.EquipItem(item);
				return false;
			}
		}
		if (item == 30) {
			if (slaveData.IsPonygirl()) {
				SetLangText("NoPonygirlPuppygirls", xNode);
				return false;
			}
			if (slaveData.IsCatgirl()) {
				SetLangText("NoPuppygirlCatgirls", xNode);
				return false;
			}		
			if (slaveData.IsDressPuppyTail()) {
				SetLangText("AlreadyHasPuppyTail", xNode);
				Bloop();
				return false;
			}
			if (SMData.sPuppyTrainer < slaveData.PuppygirlInterest) {
				Language.XMLData.XMLGeneral("RefusePuppygirlTail", true, xNode);
				coreGame.SlaveGirl.ShowRefusePuppygirl(30);
				coreGame.SelectEquipment.ShowOtherEquipment();
				Bloop();
				return false;
			}
			if (!coreGame.TestObedience(coreGame.DifficultyPlug)) {
				Language.XMLData.XMLGeneral("RefuseTailPlug", true, xNode);
				coreGame.SelectEquipment.ShowOtherEquipment();
				Bloop();
				return false;
			}
			if (coreGame.slaveData.ItemsWorn.CheckBitFlag(29))  {
				StartTraining(item);
				if (coreGame.NumEvent == 9706) coreGame.EquipItem(item);
				return false;
			}
		}
		return true;
	}
	
	public function RemoveItemAsAssistant(item:Number) : Boolean
	{ 
		switch(item) {
			case 29:
				if (slaveData.BitFlag1.CheckBitFlag(58)) {
					SlaveSpeak(Language.GetHtml("RefuseToRemovePuppyGirlItem", xNode));
					Bloop();
					return false;
				} else if (slaveData.BitFlag1.CheckBitFlag(57)) {
					ServantSpeak(Language.GetHtml("RemovePuppyGirlItem", xNode));
					coreGame.SelectEquipment.ShowOtherEquipment();
					DoYesNoEvent(2050);
					coreGame.ShowDress();
					return false;
				}
				break;
				
			case 30:
				if (slaveData.BitFlag1.CheckBitFlag(58)) {
					SlaveSpeak(Language.GetHtml("RefuseToRemovePuppyGirlItem", xNode));
					Bloop();
					return false;
				} else if (slaveData.BitFlag1.CheckBitFlag(57)) {
					ServantSpeak(Language.GetHtml("RemovePuppyGirlItem", xNode));
					coreGame.SelectEquipment.ShowOtherEquipment();
					DoYesNoEvent(2051);
					coreGame.ShowDress();
					return false;
				}
				break;
		}
		return true;
	}
	
	public function EquipItemAsAssistant(item:Number) : Boolean
	{
		if (item == 30) coreGame.PlugInserted = 1; 
		return false;
	}
	
	
	public function UnEquipItemAsAssistant(item:Number) : Boolean
	{ 
		if (item == 30) coreGame.PlugInserted = 0; 
		return false;
	}

	public function SetEquipmentTabsAsAssistant()
	{
		nModuleTab = coreGame.SelectEquipment.SetTabDetails(Language.GetHtml("Puppy", "Equipment"));
	}

	public function ShowEquipmentTabAsAssistant(nTab:Number)
	{
		if (nTab != nModuleTab) return;
		
		var Kennels:Shop = GetShop("Kennels");
		trace("Kennels = " + Kennels + " " + Kennels.GetItemName(29));
		coreGame.SelectEquipment.AddEquipmentButton(1, 29, coreGame.slaveData.ItemsWorn.CheckBitFlag(29), coreGame.slaveData.ItemsOwned.CheckBitFlag(29), Kennels.GetItemName(29), "Q");
		coreGame.SelectEquipment.AddEquipmentButton(2, 30, coreGame.slaveData.ItemsWorn.CheckBitFlag(30), coreGame.slaveData.ItemsOwned.CheckBitFlag(30), Kennels.GetItemName(30), "I");
	}
	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
		
			// 4010 - peek puppy girl's mine
			case 4010:
				HideImages();
				Backgrounds.ShowAlley(3);
				if (coreGame.BitFlag1.CheckBitFlag(43)) {
					ShowPerson(53, 1, 2, 2);
					SetText(SlaveVerb("look") + " and sees in a small alcove another girl, who moans, or maybe whines when she sees #slave. She is lying on her back and has a large erect cock, leaking pre-cum. She puts a finger to her mouth in a gesture of silence and then waves to #slave to approach, again making a soft whining noise.\r\r#slave approaches and the girl, who is still moaning, and leans in to whisper and ask what is wrong. Before she can say anything the girl reaches out and puts one of #slave's hands on her cock and then kisses her. The girl whines again, slightly thrusting her hips and looks imploringly. For some reason #slave cannot bear to refuse.\r\r" + SlaveName + " smiles");
					if (!coreGame.Naked) AddText(" while rearranging her clothing and panties ");
					AddText("and slowly lowers herself, impaling her pussy on the girl's cock. ");
					if (IsDickgirl()) AddText("As she does she takes on of the girls hands and places it on her own cock. ");
					AddText("The girl whines in a passionate way and thrusts her cock a little, meeting #slave who groans at the size and feeling of the girl's cock. After a brief pause, #slave moves up and down, fucking the girl's cock. ");
					if (IsDickgirl()) AddText("The girl strokes #slave's cock a little awkwardly, but quickly gets the correct rhythm. ");
					AddText("The girl whines and moans fucking skillfully and with obvious pleasure. She fucks quicker and after a time lets out a soft cry, almost a growl and cums and cums, a large load into #slave's pussy. ");
					if (IsDickgirl()) AddText("As she cums, #slave feels her own orgasm approach and as the girl stops cumming and goes limp, #slave gasps and cums, spraying her cum over the girl's breasts. ");
					else AddText("As the girl cums #slave quickly orgasms, feeling the girl's cum filling her and the touch of the girls tongue licking her face. ")
					AddText("\r\r#slave is about to thank the girl, and again the girl puts a finger to her lips, and just lets out a contented whine. #slave puts a hand to her head and pats her, and returns back to the entry of the alley.\r\rAs she does the Puppy Girl returns from her chase, looking happy and panting in an exaggerated way. #slave pats her head, feeling happy for her encounter, but a little awkward for her little betrayal.");
					Points(0, 0, 0, 0, -2, 1, 0, 0, 0, 0, 1, 0, 1, 0, -2, 0, 2, 0, 1, 0, 0);
				} else {
					ShowPerson(53, 1, 0, 3);
					SetText(SlaveVerb("look") + " and sees a small alcove and some shadows moving at a window and cautiously sneaks up and peeks in.\r\rShe sees another girl with dog ears and tail, Mine?, presenting her rear to a man but due to the window and curtains #slave can barely see the man. She does see the man's cock, pressed against the girl's ass, and slowly worked in. The girl whines loudly and #slave can see her playing with her ");
					AddText("clit and pussy. #slave cannot help herself and ");
					if (!coreGame.Naked) AddText("reaches into her clothes and ");
					AddText("massages her pussy and rubs her clit. The man fucks the girl, with some skill and care, fucking faster but not too fast to cause pain. The girl gasps and whines, and looks straight at #slave orgasming while looking directly in her eyes. #slave is surprised, aroused and ");
					AddText("orgasms, holding one hand over her mouth to stop from screaming out loud. The man also cums, unloading his cum into the girl's ass. The girl whines as he pulls free and licks his face, glancing at #slave.\r\r#slave quietly retreats to the entry of the alley and waits for #assistant and the Puppy Girl to return.");
					Points(0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, 0, 2, 0, 1, 0, 0);
				}
				ShowPlanningNext();
				return true;	
				
			// 4011 - look catgirl
			case 4011:
				SetText(SlaveVerb("gesture") + " and says 'Look a catgirl', hoping the Puppy Girl will run off looking. The girl looks alertly, but refuses to leave.\r\r");
				AddText("The Puppy Girl smiles and wags her tail and has a happy chat with a slightly disappointed #slave.\r\rAfter a time they part with a Woof!!");
				ShowPlanningNext();
				return true;	
				
			// 4012 - get servant to play
			case 4012:
				if (coreGame.VarConversationRounded < 30) {
					SetText("#slave can see that #assistant likes the Puppy Girl and tries to convince #assistanthimher to play with her for a while, like when the catgirl was here.\r\r#assistant looks tempted but refuses, explaining about #assistanthisher duty to supervise #slave.");
				} else {
					coreGame.HideAssistant();
					SetText("#slave can see that #assistant likes the Puppy Girl and suggests #assistantheshe go play with her for a while, reassuring that #slave will talk a little rest here. #assistant looks tempted and agrees and they run off, happily playing.\r\rMeanwhile #slave");
					Backgrounds.ShowAlley(3);
					AddText(" steps into the alley and ");
					switch(Math.floor(Math.random()*6)) {
						case 0:
						case 1:
							ShowPerson(53, 1, 2, 2);
							AddText("sees in the small alcove the girl, who moans, or whines, happily when she sees #slave. She is again lying on her back and her cock immediately springs erect. She puts a finger to her mouth in a gesture of silence and points towards the house and then her pussy, a slight dribble of cum is leaking from it. #slave understands, her Master had recently visited. She wonder at the girl's relationship with the other puppy girl.\r\r" + SlaveName);
							if (!coreGame.Naked) AddText(" removes some of her clothing and her panties ");
							AddText("and lies next to the girl, who virtually jumps on to her, thrusting her cock into #slave's pussy, no foreplay, no warning. Fortunately #slave is very aroused and the girl easily slides in. The girl softly whines and licks #slave's face and neck, while fucking urgently. The girl quickly whines and arches her back, cumming into #slave large gouts of cum. #slave is a little disappointed, nowhere near cumming herself.\r\rThe girl leaves her cock inside #slave and licks and kisses her, and #slave feels the girl's cock grow hard again. The girl whines and starts fucking again, slower and less urgently. She fucks, building speed and depth and #slave feels her orgasm approaching and then the girl whines and cums again, whining and moaning as her cum pours into #slave again. She pulls out of a frustrated " + SlaveName);
							if (IsDickgirl()) AddText(" and she quickly slides down and takes #slave's cock into her mouth and sucks and licks until #slave cums strongly into her mouth.");
							else AddText(" and she quickly slides down and licks #slave's pussy and clit until she orgasms strongly.");
							break;
						case 2:
						case 3:
							ShowPerson(53, 1, 2, 2);
							AddText("sees in the small alcove the girl, who moans, or whines, happily when she sees #slave. She is sitting, lightly and slowly stroking her cock. She puts a finger to her mouth in a gesture of silence and points towards the entrance of the alley. #slave makes a gesture that it is ok, and the girl waves her over. #slave wonders, does this girl can love the Puppy Girl and maybe...?\r\rThe girl ");
							if (!coreGame.Naked) AddText(" quickly removes some of #slave's clothing ");
							AddText("and makes her kneel on hands and kneels. The words 'doggie style' pass through #slave's mind, and is erased as the girl thrusts her cock into #slave's pussy, and starts fucking slowly. The girl plays with #slave's breasts and ");
							if (IsDickgirl()) AddText(" cock");
							else AddText(" clit");
							AddText(". She fucks #slave faster and faster, sometimes licking her neck or face. After a time she fucks faster and whines and cums a torrential load of cum into #slave's pussy and as she does " + SlaveName);
							if (IsDickgirl()) AddText("'s cock erupts, and she gasps her orgasm, spraying cum over the ground.");
							else AddText(" orgasms, barely holding in her cry of passion.");
							break;
						case 4:
							ShowPerson(53, 1, 0, 3);
							AddText("the girl is not there! She sees some shadows moving at a window and cautiously sneaks up and peeks in.\r\rShe sees the girl presenting her rear to a man but due to the window and curtains #slave can barely see the man. She sees the man's cock pressed against the girl's ass, and slowly worked in. The girl whines loudly and #slave can see her playing with her own cock, stroking it slowly. ");
							AddText("#slave cannot help herself and ");
							if (IsDickgirl()) AddText(" grabs her cock and strokes it in time with the man as he fucks the girl's ass");
							else AddText(" massages her pussy and rubs her clit");
							AddText(". The man fucks the girl, with some skill and care, fucking faster but not too fast to cause pain. The girl gasps and whines, and looks straight at #slave cumming while looking directly in her eyes. #slave is surprised, aroused and ");
							if (IsDickgirl()) AddText("cums, spraying her cums over the side of the house.");
							else AddText("orgasms, holding one hand over her mouth to prevent her screaming out loud.");
							AddText(" The man also cums, unloading his cum into the girl's ass. The girl whines as he pulls free and licks his face, glancing at #slave.\r\r#slave quietly retreats to the entry of the alley and waits for #assistant and the Puppy Girl to return.");
							Points(0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0, 1, 0, -2, 0, 2, 0, 1, 0, 0);
							return true;
						case 5:
							HideBackgrounds();
							Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
							AddText("and before she takes another step, hears the Puppy Girl return, saying,\r\r");
							PersonSpeak(53, "I cannot leave my post! Woof!! Mine might play with someone! Woof!!", true);
							AddText("\r\rShe looks happily at #slave who pretends she was just stretching. They chat for a time and the girl talks of her Master and occasionally refers to 'Mine', and once said puppies, but maybe she just was talking about herself.");
							return true;
					}
					AddText("\r\r#slave pats the girl's head, and the girl contentedly whines. #slave leaves and waits briefly for #assistant and the Puppy Girl to return, feeling happy but a bit guilty.");
					Points(0, 0, 0, 0, -2, 1, 0, 0, 0, 0, 1, 0, 1, 0, -2, 0, 2, 0, 1, 0, 0);
				}
				ShowPlanningNext();
				return true;	
				
			// 4013 - no do not
			case 4013:
				Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 2, 0, 0, 0, 0, 0);
				AddText(SlaveVerb("decide") + " it would be wrong to betray the Puppy Girl and forgets about tricking her. The Puppy Girl smiles and wags her tail and has a happy chat with #slave.\r\rAfter a time they part with a Woof!!");
				coreGame.PuppyGirlFlag = 4;
				ShowPlanningNext();
				return true;	
		}

		return false;
	}
	
	// Puppy Girl

	public function MeetPuppyGirl()
	{
		coreGame.ChangePuppyTraining(2);
		coreGame.WalkZoom._visible = false;
		ShowSupervisor();
		HideBackgrounds();
		switch (coreGame.PuppyGirlFlag) {
			case 0:
				if (IsDickgirlEvent()) coreGame.BitFlag1.SetBitFlag(43);
				else coreGame.BitFlag1.SetBitFlag(44);
				ShowPerson(53, 1, 2, 1);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0);
				AddText(coreGame.SlaveMeet + " an odd slave girl who is sitting in front of a short alley leading to a small home. The alley is overgrown with vines and #slave can barely see the house. The girl looks at #slave and smiles,\r\r");
				PersonSpeak(53, "I'm a guard dog! Woof!!", true);
				AddText("\r\r#slave asks what is she guarding?\r\r");
				PersonSpeak(53, "What is mine! Also my Master's home! Woof!!", true);
				AddText("\r\r#slave is amused by the girl's cheerfulness and spirited attitude, and sits and talks for a while with her. The girl is a little strange, always ending her sentences with Woof!!\r\rAfter a time they part with a Woof!!");
				break
			case 1:
				ShowPerson(53, 1, 2, 1);
				ShowMovie(coreGame.Catgirls.mcBase.PeopleCatgirl, 1, -3, 1);
				coreGame.StartChangeImage(1000, coreGame.Catgirls.mcBase.EventWalk);
				Points(0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, -2, 1, 0, 0);
				AddText(coreGame.SlaveMeet + " the little puppy girl again, still guarding her house. They talk a little bit, until #slave notices a girl with cat ears walking past and the puppy girl leaps,\r\r");
				PersonSpeak(53, "Catgirl! Catgirl!", true);
				AddText("\r\rShe runs off chasing the catgirl. #slave can see she is playing and the catgirl is pretending to be afraid, running awkwardly. Amused #assistant follows, playing a little with them.\r\r#slave wonders a little about the puppy girl's previous talk about 'guarding what is mine' and peeks down the alley...");
				DoEvent(4010);
				break;
			case 2:
				ShowPerson(53, 1, 2, 1);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0);
				AddText(coreGame.SlaveMeet + " again the Puppy Girl guarding her home, who looks at her and smiles,\r\r");
				PersonSpeak(53, "Woof!! You're here again! You are cute, but I have a Master! Woof!!", true);
				if (coreGame.BitFlag1.CheckBitFlag(43)) {
					AddText("\r\rThey talk a little, but #slave cannot but help to remember her little betrayal last time, but the other girl really enjoyed it, in fact started it!\r\r");
					PersonSpeak(53, "I'm still guarding mine and my Masters home! Catgirl's won't trick me again.", true);
					AddText("\r\r#slave thinks, maybe she could, maybe, trick the girl away from her post. She is very unsure, and will think more on this. Maybe the next time she returns she will have decided.");
				} else AddText("\r\r#slave is still amused by the girl's happiness and determination, and sits and talks for a while with her.\r\rAfter a time they part with a Woof!!");
				break;
			case 3:
				ShowPerson(53, 1, 2, 1);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0);
				AddText(coreGame.SlaveMeet + " again the Puppy Girl guarding her home, who looks at her and smiles, somehow wagging her tail,\r\r");
				PersonSpeak(53, "Woof!! Woof!! You're back! You are cute, maybe you join me and Master? Woof!!", true);
				AddText("\r\r#assistant is amused and explains that #slave has a #master already. ");
				if (coreGame.BitFlag1.CheckBitFlag(43)) {
					AddText("\r\r#slave has thought over the last while and thinks she can trick the Puppy Girl for a bit, but does she want to do this, just so she can 'visit' her 'bitch'?\r\r");
					AskHerQuestions(4011, 4012, 4013, 0, "'Look a catgirl'", "Have #assistant play with her", "No, don't do it!", "", "What does she do?");
					return;
				} else AddText("The Puppy Girl smiles and wags her tail and has a happy chat with #slave.\r\rAfter a time they part with a Woof!!");
				break;
			case 4:
				ShowPerson(53, 1, 2, 1);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0);
				AddText(coreGame.SlaveMeet + " again the Puppy Girl guarding her home, who looks at her and smiles, somehow wagging her tail,\r\r");
				PersonSpeak(53, "Woof!! Woof!! You're back! You are cute, maybe you join me and Master? Woof!!", true);
				AddText("\r\r#assistant is amused and explains that #slave has a #master already. ");
				AddText("The Puppy Girl smiles and wags her tail and has a happy chat with #slave.\r\rAfter a time they part with a Woof!!");
				break
	
		}
		coreGame.modulesList.Exclude(this).AfterMeetPerson(53, coreGame.PuppyGirlFlag);
		if (coreGame.PuppyGirlFlag < 3) coreGame.PuppyGirlFlag++;
	}
		
	
	// Endings
	
	public function EndingStartAsAssistant() : Boolean
	{
		if (coreGame.IsPuppygirlComplete() && coreGame.Score > 50 && (coreGame.slaveData.ItemsOwned.CheckBitFlag(29) || coreGame.IsDressPuppyEars())  && (coreGame.slaveData.ItemsOwned.CheckBitFlag(30) || coreGame.IsDressPuppyTail())) {
			// Puppygirl
			// Bitch		- Requirements: Puppygirl Trainer Lvl1, Puppygirl Skill 01 - 39, Temperment > 50%
			// Puppygirl	- Requirements: Puppygirl Trainer Lvl 1, Puppygirl Skill 40+
			// Pedigree		- Requirements: Puppygirl Trainer Lvl 2, Puppygirl Skill 50+

			var type:Number = 1;
			if (coreGame.sPuppyTrainer > 1 && sd.slPuppyTraining >= 50) {
				coreGame.SetEnding(4, coreGame.GetXMLString("EndingPuppygirl/NameLevel3" + (coreGame.SlaveFemale ? "Female" : "Male"), "EndGame/Slave"));
				type = 3;
			} else if (sd.slPuppyTraining < 40 && coreGame.VarTemperament > 50) coreGame.SetEnding(4, coreGame.GetXMLString("EndingPuppygirl/NameLevel1" + (coreGame.SlaveFemale ? "Female" : "Male"), "EndGame/Slave"));
			else {
				coreGame.SetEnding(4, coreGame.GetXMLString("EndingPuppygirl/NameLevel2" + (coreGame.SlaveFemale ? "Female" : "Male"), "EndGame/Slave"));
				type = 2;
			}
			if (coreGame.SlaveGirl.ShowEndingPuppygirl(type) != true) {
				var gm:GenericSlave = new GenericSlave(null, coreGame.slaveData, coreGame);
				gm.ShowEndingPuppygirl(type);
			}
		}
		
		return false;
	}
	
	public function EndingFinishAsAssistant(total:Number) : Boolean
	{
		if (coreGame.NumFin == 4) {
			// Puppygirl
			var type:Number = 1;
			if (coreGame.sPuppyTrainer > 1 && sd.slPuppyTraining >= 50) type = 3;
			else if (sd.slPuppyTraining < 40 && coreGame.VarTemperament > 50) type = 1;
			else type = 2;
			if (!Language.XMLData.XMLGeneral("EndGame/Slave/EndingPuppygirl/ReviewLevel" + type + (coreGame.SlaveFemale ? "Female" : "Male"))) Language.XMLData.XMLGeneral("EndGame/Slave/EndingPuppygirl/ReviewLevel" + type);
			
			coreGame.NumFin = 1000;
			return true;
		} 

		return false;
	} 
	
	public function NumCustomEndingsAsAssistant() : Number { return 1; }
	
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText(Language.GetHtml("EndingPuppy/Hint", "Endings"));
	}

}
