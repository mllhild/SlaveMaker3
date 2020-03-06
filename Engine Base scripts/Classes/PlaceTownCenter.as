// Town Center
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceTownCenter extends Place
{
	// constructor
	public function PlaceTownCenter(mc:MovieClip, cg:Object, cc:Object)
	{
		// Linked to no swf, xml node TownCenter, id 3, x = 200, y = 200
		super("TownCenter", mc, cg, 3, true, "", 200, 200, cc);

	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(12);
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "Event1-1";	// set default event

		this.AddEvent("Event1-1");
		this.AddEvent("Event2-2");
		this.AddEvent("Event3-3");
		this.AddEvent("MeetBarman-4");
		this.AddEvent("MeetSleazyBarOwner-5");			
		this.AddEvent("MeetNun-6");
		this.AddEvent("Event7-7");
		this.AddEvent("MeetXXXSchoolOwner-9");			
		this.AddEvent("MeetIdol-10", coreGame.VarIdol == -1);
		this.AddEvent("Event11-11", !coreGame.PonygirlsOn);
		this.AddEvent("Event12-12", true);

		this.AddEvent("Event2.1-2.1", true);
		this.AddEvent("Event2.2-2.2", true);
		this.AddEvent("Event1.5-1.5", true);
		this.AddEvent("Event7.5-7.5", true);

	}

	// Walking in the Town Center
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4108);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkTownCenter++;
		coreGame.EventTotal = slaveData.TotalWalkTownCenter;
		
		// Select the event and show it
		super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude, sequential);
		
		if (!IsEventPicked()) return;
		
		if (coreGame.NumEvent == 2) {
			if (slaveData.StrapOnOK == 0)	coreGame.NumEvent = 2;
			else if (Math.floor(Math.random()*3) == 1 && slaveData.ImprovedDildoOK == 0) coreGame.NumEvent = 2.1;
			else coreGame.NumEvent = 2.2;
		} else if (coreGame.NumEvent == 7 && !coreGame.BitFlag1.CheckBitFlag(8)) coreGame.NumEvent = 7.5;
	}
	
	public function HandleWalk() : Boolean
	{
		coreGame.SMTRACE("TownCenter::HandleWalk " + coreGame.StrEvent + " " + coreGame.NumEvent);
		
		if (super.HandleWalk()) return true;
		
		switch (coreGame.NumEvent) {
			
		case 2:
			parentCity.MeetPerson(6, 0, "Tena");
			if (coreGame.SlaveFemale) {
				AddText(" who flirts with #slavehimher and gives #slavehimher ");
				if (coreGame.SlaveGender > 3) AddText("a pair of strap-ons and graphic instructions for their use. She darts in and kisses both #slave on their cheeks and runs off, waving.\r\r" + coreGame.SlaveHeSheUC + " are now more interested in lesbian sex (so #slaveheshe can try out the strap-ons).");
				else AddText("a strap-on and graphic instructions of its use. She darts in and kisses #slave on #slavehisher cheek and runs off, waving.\r\r" + coreGame.SlaveHeSheUC + " is now more interested in lesbian sex (so #slaveheshe can try it out).");
				Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
				slaveData.StrapOnOK = 1;
				slaveData.DifficultyLesbian = slaveData.DifficultyLesbian - 5;
				slaveData.AlterSexuality(-3);
				coreGame.Items.ShowItem(15, false, 0);
				ShowPerson(10, 1, 3, 1);
			} else {
				AddText(" who talks a little with #slavehimher but they quickly part. Tena says that she is sorry, she likes girls...");
				Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			}
			return true;
			
		case 2.1:
			slaveData.ImprovedDildoOK = 1;
			Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			parentCity.MeetPerson(10, 0, "Tena");
			AddText(" who flirts with #slavehimher. They talk about sex and she gives #slave a realistic but large cock shaped dildo saying it is the best dildo she had ever used.");
			slaveData.DifficultyLesbian = slaveData.DifficultyLesbian - 2;
			slaveData.AlterSexuality(-2);
			return true;
			
		case 2.2:
			trace("event 2.2");
			Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			if (coreGame.LesbianTraining) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			trace("event 2.2 1");
			parentCity.MeetPerson(10, 0, "Tena");
			trace("event 2.2 2");
			if (coreGame.TestObedience(slaveData.DifficultyLesbian, 11)) AddText(" who flirts with #slavehimher. The girl gives #slave suggestions and ideas for having sex with women, smiling suggestively.");
			else AddText(" who flirts with #slavehimher.\r\r" + NameCase(coreGame.SlaveHeSheIs) + " now more open to the idea of lesbian sex.");
			trace("event 2.2 3");
			slaveData.DifficultyLesbian = slaveData.DifficultyLesbian - 2;
			slaveData.AlterSexuality(-1);
			trace("event 2.2 4");
			return true;
			
		case 3:
			if (coreGame.VarCharismaRounded > 49) AddText("A passing nobleman sees #slave and takes an instant fancy to #slavehimher");
			else AddText("A passing nobleman sees #slave and says that " + coreGame.SlaveHeSheHas + " potential");
			if (ShowSupervisor()) {
				AddText(" and orders you to hand #slavehimher over to his possession.\r\r");
				if (coreGame.sNoble > 0) AddText("You politely tell him of your noble heritage, and refuse his request.");
				else {
					AddText("You are taken aback but cannot refuse and reluctantly agree. #slave looks distressed but the noble has #slavehimher placed into his carriage and then enters into a shop.\r\rYou speak to a servant on the carriage and bribe them to allow #slave to escape. Quickly, #slave lightly hits the servant and you and #slaveheshe run away into the city, hoping the noble does not know who you actually are.");
					Money(-200 - (coreGame.Difficulty * 25));
				}
			} else {
				AddText(" and orders #assistant to hand #slavehimher over to his possession.\r\r");
				if (coreGame.AssistantData.sNoble > 0) AddText("#assistant politely tells him of " + coreGame.ServantHisHer + " noble lineage, and refuses his request.");
				else if (coreGame.sNoble > 0) AddText("#assistant explains about your noble lineage, but the arrogant noble refuses to listen to a mere servant. ");
				else AddText("#assistant is taken aback but cannot refuse and reluctantly agrees. ");
				AddText(coreGame.SlaveName + coreGame.NonPlural(" look") + " distressed but the noble has #slavehimher placed into his carriage and then enters into a shop.\r\r#assistant speaks to a servant on the carriage and bribes them to allow #slave to escape. Quickly, #slave lightly hits the servant and #assistant and #slaveheshe run away into the city, hoping the noble does not know who they actually are.");
				Money(-200 - (coreGame.Difficulty * 25));
			}
			return true;
			
		case 7:
		case 7.5:
			if (coreGame.NumEvent == 7) {
				coreGame.BitFlag1.ClearBitFlag(8);
				AddText(coreGame.SlaveMeet + " a cook who gives #slavehimher some advice.\r\r");
			} else {
				coreGame.BitFlag1.SetBitFlag(8);
				coreGame.ShowMovie(coreGame.Catgirls.mcBase.EventWalk, 1, 2, 1);
				if (coreGame.IsCatgirl()) {
					coreGame.ChangeCatTraining(1);
					AddText(coreGame.SlaveMeet + " a cook who gives #slavehimher some advice.\r\rWhile leaving " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " an odd girl nearby, maybe she is a cat slave too. She nods and disappears for a moment returning with two large fresh fish, smiling. She gives #slave one and quickly leaves.");
				} else AddText(coreGame.SlaveMeet + " a cook who gives #slavehimher some cooking tips.\r\rWhile leaving " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " an odd girl nearby, maybe she is a cat slave. She nods and disappears for a moment returning with a large fresh fish, smiling. She quickly leaves.");
			}
			ShowPerson(28, 0, 0);
			Points(0, 0, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			return true;
			
		case 11:
			ShowSupervisor();
			slaveData.DifficultyBondage--;
			this.NoRepeatEvent(11);
			if (coreGame.IsDickgirlEvent()) AutoLoadImageAndShowMovie("Images/Trainings/Pony/Walk - Ponygirl Meeting 4 (As Dickgirl).jpg", 1, 1);
			else AutoLoadImageAndShowMovie("Images/Trainings/Pony/Walk - Ponygirl Meeting 4.jpg", 1, 1);
			if (slaveData.IsPonygirl()) AddText(coreGame.SlaveMeet + " a fellow");
			else AddText(coreGame.SlaveMeet + " a");
			if (SMData.PonygirlAware > 0) AddText(" ponygirl");
			else AddText(" slave");
	
			AddText(" lightly bound sitting in front of a shop, patiently waiting for her Master or Mistress, gagged with a bit like a horse's. " + coreGame.SlaveName2 + " wants to talk to her and reaches out to remove her gag. The girl sharply turns her head away.\r\rA moment later a man speaks,\r\r");
			PersonSpeak(1999, "No, little one, she is my ponygirl and her gag must stay on always, except to eat or for my pleasure. Her tail....\r\rFillie, what has happened to your tail?", true);
			AddText("\r\rThe ponygirl looks at her owner, adoration in her eyes, and she looks down the street and shakes her bottom, and makes a neighing noise,\r\r");
			PersonSpeak(1999, "You lost your tail, no, it was stolen! I see...", true);
			if (Supervise) {
				AddText("\r\rHe turns to you while starting to undo his trousers,\r\r");
				PersonSpeak(1999, "Honoured Slave Maker, can you please have your slave buy me an Anal Plug for my dear girl here. We have a rule we both must respect. My dear's tail must always be in her ass, unless my cock is inside it or she is, ummm, cleaning herself.", true);
			} else {
				AddText("\r\rHe turns to #assistant while starting to undo his trousers,\r\r");
				PersonSpeak(1999, "Servant, will you have your slave buy me an Anal Plug for my dear girl here. We have a rule we both must respect. My dear's tail must always be in her as, unless my cock is inside it or she is, ummm, cleaning herself.", true);
			}
			AddText("\r\rThe girl stands and bends over, almost head on her ankles and her owner carefully thrusts his cock into her ass, slowly fucking her. He hands some gold to #slave who runs to " + coreGame.GetPersonsName(1) + "'s Shop and purchases an Anal Plug. " + coreGame.SlaveHeSheUC + " returns a few minutes later and sees the man still fucking his slave, controlling his pace well. When he sees #slave he speeds up, fucking fast and quickly cums deep in his slave's ass. The girl looks completely happy and sighs as the man puts the anal plug into her cum slick ass. He thanks #slave and gives #slavehimher a small reward.");
			if (coreGame.sPonyTrainer < 2 && Supervise) {
				if (SMData.PonygirlAware == 0) {
					coreGame.PonygirlAware = 1;
					SMData.PonygirlAware = 1;
					AddText("\r\rYou ask him about what he means by a ponygirl, having never hear of such a slave. He explains how they are in a form of submissive bondage where she becomes your 'mount' and lives a much simpler and pleasurable life.\r\rA ponygirl dresses in a particular way needed certain items like the bit, tail and a harness.");
				} else AddText("\r\rYou speak to him for a little about owning and training such a contented ponygirl.");
				AddText(" He is no expert, he just loves his ponygirl and wants to treat her properly.");
			}
			Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 1, 3, 0, 0, 0, 0, 0);
			return true;
			
		case 12:
			coreGame.DoEventNext(8506);
			return true;
		}
		
		return false;
	}
}