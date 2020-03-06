// Docks (Port)
// Linked to Walk-Docks.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceDocksPort extends PlaceDocks
{
	// Constructor
	public function PlaceDocksPort(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to xml node DocksPort, id 6.1/6.0?
		super("DocksPort", mc, cg, 6.1, cc);
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		ResetEvents();
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "TalkSailor-8";	// set default event

		this.AddEvent("TentacleSex", true);
		this.AddEvent("HelpMerchant-1");
		this.AddEvent("PonyMistress-2");
		if (!coreGame.PonygirlsOn) this.NoRepeatEvent("PonyMistress-2");
		this.AddEvent("Mishap-3");
		this.AddEvent("MeetTena-4");
		this.AddEvent("MeetBountyHunter-5");
		this.AddEvent("MeetNun-6");
		this.AddEvent("MeetCook-7");	
		this.AddEvent("TalkSailor-8");
		this.AddEvent("HelpSailor-9");
		this.AddEvent("HelpSailor-9.5", true);
	}
	
	// Walking at the Port
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{			
		SMTRACE("PlacedocksPort.DoWalkLoaded");
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4101);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		coreGame.Backgrounds.ShowBackground(strNodeName);
		
		// general counts of times walked here
		slaveData.TotalWalkDocks++;
		coreGame.EventTotal = slaveData.TotalWalkDocks;
		
		// Tentacles?
		coreGame.Tentacles.CheckTentacleWalk("While #slave starts walking through the docks #slaveheshe smells a foul odour. In a small alley nearby #slaveheshe sees a horribly slain thing, torn tentacles and ripped apart flesh. Terrible burns and claw marks cover the flesh. " + coreGame.SlaveHeSheUC + coreGame.NonPlural(" look") + " away in fright and hurries on.\r\r", " is walking along a dark alley towards a wharf");
		
		// Select the event and show it
		if (IsEventAllowable()) super.DoWalkLoaded(mc, "");
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		if (!IsEventPicked()) {
			if ((!coreGame.DocksSlavePens.IsAccessible()) && (coreGame.VarObedienceRounded > 49 || coreGame.VarReputationRounded > 49)) {
				ShowPerson(46, 1, 1, 1);
				if (ShowSupervisor()) {
					AddText("Some guards, commanded by an attractive woman, approach you and #slave near the Slave Pens and closely question you both. ");
					if (coreGame.VarReputationRounded > 49) AddText("One of the guards says he has heard of #slave as " + coreGame.Plural("an excellent slave"));
					else AddText("The guards are impressed with #slave's obedience to you");
					AddText(".\r\rThe guards tell you that you are granted access to the slave pens if you so desire.\r\r");
				} else {
					AddText("Some guards approach, commanded by an attractive woman, #assistant and #slave near the Slave Pens and are closely questioned. ");
					if (coreGame.VarReputationRounded > 49) AddText("One of the guards says he has heard of #slave " + coreGame.Plural("as an excellent slave"));
					else AddText("The guards are impressed with #slave's obedience to " + coreGame.ServantName);
					AddText(".\r\rThe guards tell #assistant that they are granted access to the slave pens if they so desire.\r\r");
				}
				coreGame.DocksSlavePens.SetAccessible();
				DoEvent(4002);
				return;
			}
			if (!this.IsVisited()) {
				this.SetVisited();
				SetEvent("Introduction-10");
				SMTRACE("Docks: " + coreGame.StrEvent);
			}
		}
		super.GetWalkEvent(exclude, sequential);

		if (coreGame.StrEvent == "") return;
		
		if (coreGame.StrEvent == "HelpSailor-9" && (coreGame.VarLibidoRounded < 25 || !coreGame.SlaveFemale)) coreGame.SetEvent("HelpSailor-9.5");
	}
	
	public function HandleWalk() : Boolean
	{
		SMTRACE("DocksPort::HandleWalk " + coreGame.StrEvent);
		
		if (coreGame.NumEvent == 4002) return true;
		
		if (super.HandleWalk()) return true;
		
		switch (coreGame.StrEvent) {
			
		case "TentacleSex":	
			coreGame.TentacleChoice = Math.floor(Math.random()*4);
			coreGame.Tentacles.TentacleSex(6);
			return true;
			
		case "HelpMerchant-1":
			ShowPerson(1, 1, 1, slrandom(2) + 1);
			switch(Math.floor(Math.random()*3)) {
				case 0:
					coreGame.OldNumEvent = 1.1;
					Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 2, 0, 0, 0);
					AddText(coreGame.SlaveMeet + " a merchant who needs help to unload a box from a ship. " + coreGame.SlaveHeSheUC + coreGame.NonPlural(" help") + " and gets some good exercise and the merchant pays #slavehimher a small reward.");
					return true;
				case 1:
					coreGame.OldNumEvent = 1.2;
					AddText(coreGame.SlaveMeet + " a merchant who is having trouble convincing some sailors that a crate is his. ");
					if (Supervise) AddText("You think they want a bribe and whisper this to #slave");
					else AddText("#assistant whispers that they probably want a bribe");
					AddText(".\r\r" + coreGame.SlaveVerb("step") + " over ");
					if (coreGame.Naked) AddText("and the sailors are very distracted by #slavehisher nakedness. " + coreGame.SlaveHeSheUC + " easily " + coreGame.NonPlural("convince") + " them to leave after accidentally rubbing up against some of them."); 
					else if (coreGame.SlaveFemale && (coreGame.Aroused || (coreGame.SlaveAttitude == 1))) {
						Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0);
						AddText("re-adjusting #slavehisher clothes to emphasise #slavehisher breasts. " + coreGame.SlaveHeSheUC + " flirts with the sailors and lures them to one side. The merchant loads to box while #slaveheshe flirts and touches the sailors. Once the merchant has finished " + coreGame.SlaveHeShe + coreGame.NonPlural(" blow") + " the sailors a kiss and " + coreGame.NonPlural("leave") + " with the merchant. The merchant pays #slavehimher a small reward for the help.");
					} else if (coreGame.SlaveAttitude > 1) {
						Points(0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
						AddText("and lectures the sailors about the evils of corruption and bribery. The sailors seem amused and quite attracted to #slavehimher. While " + coreGame.SlaveHeShe + coreGame.NonPlural(" lecture") + " the merchant loads the box and once finished #slaveheshe joins him and they leave. The merchant insists on paying #slavehimher a small reward for the help.");
					} else {
						Points(0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
						AddText("and talks with the sailors and with the merchants help demonstrates his ownership of the crate. The sailors give-up and leave them. The merchant pays #slavehimher a small reward for the help.");
					}
					return true;
				case 2:
					coreGame.OldNumEvent = 1.3;
					Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 2, 0, 0, 0);
					AddText(coreGame.SlaveMeet + " a merchant who is desperately looking for a crate. He cannot find where it is stored and no-one else is helping. " + coreGame.SlaveHeSheUC + coreGame.NonPlural(" help") + " him to find it and then load it, getting some good exercise and the merchant pays #slavehimher a small reward.");
					return true;
			}
			if (Supervise) {
				Money(50);
				AddText("\r\rYou pocket most of the money but allow #slave some coins to spend on a snack.");
			} else {
				AddText("\r\r#assistant");
				if (coreGame.SlaveLikeServant) {
					Money(50);
					AddText(" pockets most of the money but allows #slave some coins to spend on a snack.");
				} else {
					Money(55);
					AddText(" pockets all the money.");
				}
			}
			return true;
			
		case "PonyMistress-2":
			coreGame.modulesList.trainPonies.StartSlaveMakerTraining();
			return true;
			
		case "Mishap-3":
			ShowSupervisor();
			Money(-100);
			temp = Math.floor(Math.random()*3);
			if (coreGame.Naked) temp = Math.floor(Math.random()*2);
			switch(temp) {
				case 0:
					coreGame.OldNumEvent = 3.1;
					AddText(coreGame.SlaveVerb("jump") + " out of the way of a wagon being poorly driven and hits #super knocking " + coreGame.ServantHimHer + " into the water. ");
					if (Supervise) {
						AddText("You climb out dripping wet and you have lost some money.\r\r#slave apologises and you say it was not #slavehisher fault and you both continue on your way.");
					} else {
						coreGame.ShowAssistant(5);
						AddText("#assistant climbs out dripping wet but has lost " + coreGame.ServantHimHer + " money.\r\r");
						if (coreGame.SlaveLikeServant) AddText("#slave apologises and #assistant says it was not #slavehisher fault and they continue on their way.");
						else AddText("#assistant yells at #slave for #slavehisher clumsiness, ignoring the wagon and it's fault.  They continue on their way #assistant still angry.");
					}
					return true;
				case 1:
					coreGame.OldNumEvent = 3.2;
					AddText(coreGame.SlaveIs + " bumped by a passing sailor and falls into a small stall, breaking a number of fragile items.\r\r");
					if (Supervise) {
						AddText("You apologise to the stall-holder, as does #slave. You then pay for the broken items and continue on your way.");
					} else {
						if (coreGame.SlaveLikeServant) AddText("#assistant apologises to the stall-holder, as does #slave. #assistant then pays for the broken items and they continue on their way.");
						else AddText("#assistant angrily slaps #slave and orders #slavehimher to apologise. #slave does and then #assistant then pays for the broken items and they continue on their way.");
					}
					return true;
				case 2:
					coreGame.OldNumEvent = 3.3;;
					ShowPerson(23, 0, 2);
					AddText(coreGame.SlaveName2 + " tears " + coreGame.SlaveHisHerSingle + " clothing on a packing crate and ");
					if (Supervise) AddText("You find");
					else AddText("#assistant finds");
					AddText(" a tailor to do a repair. The tailor charges a large fee to do the immediate job, but does a fine, invisible repair. ");
					if (!Supervise && !coreGame.SlaveLikeServant) AddText("\r\r#assistant scolds #slave for " + coreGame.SlaveHisHerSingle + " clumsiness.");
					return true;
			}
			return true;
			
		case "MeetTena-4":
			parentCity.MeetPerson(6, 0, "Tena");
			if (coreGame.SlaveFemale) {
				Points(0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 2, 1, 0, 0);
				if (!coreGame.CuteLesbian.IsMet()) {
					switch(Math.floor(Math.random()*3)) {
						case 0:
							Money(20);
							AddText(" and helps her run some errands and Tena gives #slavehimher some money for #slavehimher time.\r\rIn an alley Tena embraces #slave and says she is really aroused and asks if #slave would lick her to orgasm, promising to do the same in return.\r");
							break;
						case 1:
							AddText(" who happily chats with #slave, ignoring #super. They have a pleasant chat, Tena often makes suggestive remarks, but is very cute and charming. After a little they retreat to a tavern for a few drinks.\r\rIn a small booth of the tavern, Tena says she is very attracted to #slave and very turned on. She asks #slave to lick her to orgasm, promising to return the favour.\r");
							break;
						case 2:
							AddText(" who asks #slave to help her carry a box a short distance. #slave carries the light box to a room in a nearby tavern. They sit on the bed and, Tena says she is very attracted to #slave and very excited. She asks #slave to lick her to orgasm, promising to return the favour.\r");
							break;
					}
					coreGame.CuteLesbian.SetMet();
				} else {
					Money(20);
					AddText(" who buys #slavehimher some gifts and gives #slavehimher some money. She then takes #slavehimher into a tavern into a private booth, ignoring #super completely.\r\rIn the booth Tena says that she finds #slave to be the most desirable " + coreGame.Plural("woman") + " she has ever met. She asks #slave to lick her to orgasm, promising to do the same in return to #slave.");
				}
				if (slaveData.Slutiness > 6) {
					AddText(coreGame.SlaveIs + " eager to help.\r\r");
					coreGame.NumEvent = 9;
					coreGame.DoEventYes();
				} else {
					AddText("\r\r" + coreGame.NameCase(coreGame.Plural("does")) + " #slaveheshe pleasure Tena?");
					DoYesNoEvent(9);
				}
			} else {
				Money(20);
				Points(0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0);
				AddText(" and helps her run some errands and Tena gives #slavehimher some money for #slavehisher time.");
			}
			return true;
			
		case "MeetCook-7":
			ShowPerson(28, 0, 0);
			PlaySound("Sounds/Muffled Cry.mp3");
			Points(0, 0, -1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			AddText(coreGame.SlaveMeet + " a ships cook who takes #slavehimher aboard his ship and gives #slavehimher some instructions on meal preparation at sea.");
			if (slaveData.TotalBondage < 1) {
				coreGame.OldNumEvent = 7.1;
				AddText("\r\r" + coreGame.SlaveVerb("hear") + " some soft moans from an adjacent room. He comments with a smile that his assistant is a little tied up at the moment.");
			} else {
				if (SMData.SilkenRopesOK == 0) {
					AddText("\r\r" + coreGame.SlaveVerb("hear") + " some soft moans from an adjacent room and looks in. " + coreGame.SlaveSee + " a girl tied up and sensuously writhing obviously in pleasure. The cook explains she is being punished and gives #slave some silk ropes for #slavehisher pleasure.");
					SMData.SilkenRopesOK = 1;
					coreGame.OldNumEvent = 7.2;
					Backgrounds.ShowOverlay(0xFEECD2);
					temp = 1;
				} else {
					coreGame.OldNumEvent = 7.3;
					Backgrounds.ShowOverlayBlack();
					AddText("\r\r" + coreGame.SlaveSee + " the cook's assistant is still being 'punished' as the girl writhes working her crotch rope and she quickly orgasms.");
					temp = 2;
				}	
				coreGame.AutoLoadImageAndShowMovie("Images/Events/Walk - Ropes " + temp + ".jpg", 1, 2);
			}
			return true;
			
		case "TalkSailor-8":
		default:
			ShowPerson(35, 0, 1, slrandom(5));
			Points(0, 0, 0, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			switch(Math.floor(Math.random()*3)) {
				case 0:
					coreGame.OldNumEvent = 8.1;
					AddText(coreGame.SlaveMeet + " a sailor and they talk of many things including the world, work on ship and more.");
					break;
				case 1:
					coreGame.OldNumEvent = 8.2;
					AddText(coreGame.SlaveMeet + " a sailor they have a talk about life at sea and some of the dockside procedures.");
					break;
				case 2:
					coreGame.OldNumEvent = 8.3;
					AddText(coreGame.SlaveMeet + " a sailor and they talk about distant and exotic lands, the people and creatures that live there.");
					break;
			}
			return true;
			
		case "HelpSailor-9":
		case "HelpSailor-9.5":
			ShowPerson(35, 0, 1, slrandom(5));
			Money(50);
			if (coreGame.NumEvent == 9) {
				Points(1, 0, -1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0);
				AddText(coreGame.SlaveVerb("help") + " some sailors amid ribald comments. " + coreGame.SlaveHeSheUC + " rather enjoys it and after a handsome sailor propositions #slavehimher. ");
				if (coreGame.LesbianTraining) {
					if (coreGame.Slutiness > 6) AddText(coreGame.SlaveIs + " is eager to fuck but explains that " + coreGame.SlaveIs);
					else AddText(coreGame.SlaveVerb("explain") + " that " + coreGame.SlaveHeSheIs);
					if (slaveData.SlaveGender > 3) AddText(" training to be lesbian slaves.");
					else AddText(" training to be a lesbian slave.");
				} else {
					if (slaveData.Slutiness > 6) {
						AddText(coreGame.SlaveIs + " eager to fuck.\r\r");
						SailorSex();
					} else {
						AddText("\r\rWill #slaveheshe have sex with him?");
						DoYesNoEvent(10);
					}
				}
			} else {
				Points(1, 0, -1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0);
				if (coreGame.Naked) AddText("#slave helps some sailors amid ribald comments. #slave rather enjoys it, although they often leer at #slavehisher naked body.");
				else AddText("#slave helps some sailors amid ribald comments, and #slaveheshe rather enjoys it.");
			}
			return true;
			
		case "Introduction-10":
			ShowSlavePensIntroduction();
			return true;
		}
		
		return false;
	}
	
	private function ShowSlavePensIntroduction()
	{
		temp = slrandom(4);
		parentCity.SlaveMarket.ShowMovie("SlavePensIntro", 1, temp == 3 ? 13 : 2, temp);
		if (temp == 2) Backgrounds.ShowOverlay(0);
		else if (temp == 3) HideBackgrounds();
		
		Points(0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (temp == 1 || temp == 3) AddText("#slave sees some naked girls secured in the stocks, heads and hands securely fixed.");
		else if (temp == 2) AddText("#slave sees some naked girls bound with ropes, securely restraining them, and each with a crotch rope firmly between their pussy lips.");
		else AddText("#slave sees some girls wearing lingerie, lightly bound, probably once ladies of high status, even possibly noble.");
		
		AddText(" It appears they are newly arrived by ship or caravan and have been secured here while waiting their new life as slaves.\r\r");
	
		if (ShowSupervisor()) {
			AddText("You explain that they will be moved into the slave pens to await their slave training. As you watch some guards release the girls and move them into the pens.\r\rThe pens are a secure area of the Docks that only trusted people are allowed into. ");
			if (coreGame.DocksSlavePens.IsAccessible()) AddText("We are allowed access to that area.");
			else AddText("You tell #slave that #slaveheshe will probably not be granted access until #slaveheshe proves #slavehisher trustworthiness more.");
		} else {
			AddText("#assistant explains they will be moved into the slave pens to await their slave training. As they watch some guards release the girls and move them into the pens.\r\rThe pens are a secure area of the Docks that only trusted people are allowed into. ");
			if (coreGame.DocksSlavePens.IsAccessible()) AddText("#assistant says that we are allowed access to that area.");
			else AddText("#assistant says that #slave will probably not be granted access until #slaveheshe proves #slavehisher trustworthiness more.");
		}
	}
	
	public function DoEventYes() : Boolean
	{
		switch(coreGame.NumEvent) {
			// 10 - sailor sex
			case 10:
				SailorSex();
				return true;
		}
		return false;
	}
		
	public function DoEventNo() : Boolean
	{
		switch(coreGame.NumEvent) {
			// 10 - sailor sex
			case 10:
				Points(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				if (slaveData.VarLibido > 50) SlaveSpeak("#slavepronoun really wanted him...");
				else SlaveSpeak("Another time!");
				return true;
		}
		return false;
	}
	
	// Sailor sex

	public function SailorSex()
	{
		coreGame.AlterSexuality(5);
		coreGame.HideStatChangeIcons();
		if (coreGame.TestObedience(slaveData.DifficultyFuck, 4)) {
			slaveData.TotalFuck++;
	
			if (slaveData.VarFuck > 50) {
				Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, -2, 0, 2, 1, 0, 0);
				AddText("The sailor is amazed at how skilled #slaveis and says #slaveheshe is the best he has ever had.\r\r#slave is very pleased.");
			} else {
				Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, -2, 0, 2, 0, 0, 0);
				AddText("They have a passionate tryst and leave satisfied.\r\r");
			}
		} else {
			slaveData.DifficultyFuck = slaveData.DifficultyFuck - 2;
			Points(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, -1, 2, 0, 0, 0, -1, 0);
			AddText("They start embracing passionately but #slave shies away nervously.\r\rThe sailor is kind and thanks her.");
		}
	}

}