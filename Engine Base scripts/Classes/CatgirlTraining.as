//
// Catgirls
//
// BitFlags
// 0	- limit 50
// 1	- unlimited
//
// Core Variables
// coreGame.Catgirl:Boolean
// slaveData.slCatTraining:Number, 0-100, max 60/100
// coreGame.sCatTrainer:Number, 2 levels
//       1 - cat slave
//       2 - catgirl
// coreGame.CatgirlInterest, level of sCatTrainer needed to train (3 = impossible)
//
// Core Functions
// coreGame.ChangeCatTraining(val:Number)
// slaveData.IsCatgirl():Boolean
//
// Core BitFlags
// 1  - 15 - catgirl
// 1  - 45 - started catgirl training
// SM - 15 - catgirl rumour
//
//
// People - Singer
//
//BitFlags
//	32 - limit 30
//  33 - limit 50
//  34 - did party unlimited
//
//SMFlag - 	0-1 = finding out she is a catgirl
//			2+ = she is a catgirl
//

// Slums
//	34  = cat girl at brothel
//	35  = cat girl at sleazy bar
// Translation status: INCOMPLETE
import Scripts.Classes.*;

class CatgirlTraining extends TrainingBase
{
	public var CatgirlEvents:Boolean;
		
	public function CatgirlTraining(mc:MovieClip, cgm:Object)
	{
		super(mc, cgm);
		//trace("CatgirlTraining(): " + cgm + " " + coreGame);
		this.ModuleName = "CatgirlTraining";
		CatgirlEvents = true;
	}
	
	public function CanLoadSave() : Boolean { return false; }

	public function IsCatgirlEvent() : Boolean
	{
		if (!this.CatgirlEvents || !slaveData.IsCatgirl() || !coreGame.bAllowEvents) return false;
		
		var chance:Number = 33;
		if (coreGame.modulesList.GetExEventBitFlag("flagcatgirl-3")) chance = 66;
		else if (coreGame.bCatgirlsCommon) chance = 50;
		
		return PercentChance(chance);
	}
	
	public function IsTrainingEvent(ev:Object) : Boolean { 
		if (!bEventsAllowed) return false;
		return IsCatgirlEvent();
	}

	// Training
	
	
	public function StartTraining(type:Number)
	{
		ResetEventPicked();
		XMLGeneral("StartCatgirlTraining", true, xNode);
		if (coreGame.SlaveGirl.StartCatgirlTraining(type) != true) {
			HideBackgrounds();
			ShowMovie(this.mcBase.Training, 1, 1, 1);
		}
		if (coreGame.NumEvent != 0) return;
		Diary.AddEntry("#slave started training as a cat slave.");
		var Singer:Person = coreGame.People.GetPersonsObject("Singer");
		Singer.SetBitFlag(32);
		coreGame.ShowStatisticsTab(2);
		slaveData.BitFlag1.SetBitFlag(45);
		coreGame.Catgirl = true;
		coreGame.HideDresses();
		coreGame.SelectEquipment.Hide();
		coreGame.HideEquipmentButton();
		DoEvent(9706);
		if (slaveData.slCatTraining < 1) {
			slaveData.slCatTraining = 1;
			coreGame.UpdateSlave();
		}
	}
	
	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		if (sd == undefined) return coreGame.IsCatgirl();
		return sd.IsCatgirl();
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) return coreGame.IsCatgirlComplete();
		return sd.IsCatgirlComplete();
	}

	
	// Items
	
	public function WearItemAsAssistant(item:Number) : Boolean
	{
		if (item == 23) {
			if (slaveData.IsPonygirl()) {
				SetLangText("NoPonygirlCatgirls", xNode);
				return false;
			}
			if (slaveData.IsPuppygirl()) {
				SetLangText("NoPuppygirlCatgirls", "SlaveTrainings/Puppygirl");
				return false;
			}		
			if (slaveData.IsDressCatEars()) {
				SetLangText("AlreadyHasCatEars", xNode);
				Bloop();
				return false;
			}
			if (SMData.sCatTrainer < slaveData.CatgirlInterest) {
				XMLGeneral("RefuseCatgirlEars", true, xNode);
				coreGame.SlaveGirl.ShowRefuseCatgirl(23);
				coreGame.SelectEquipment.ShowOtherEquipment();
				Bloop();
				return false;
			}
			if (coreGame.CatTailWorn == 1) {
				StartTraining(item);
				if (coreGame.NumEvent == 9706) coreGame.EquipItem(item);
				return false;
			}
		}
		if (item == 24) {
			if (slaveData.IsPonygirl()) {
				SetLangText("NoPonygirlCatgirls", xNode);
				return false;
			}
			if (slaveData.IsPuppygirl()) {
				SetLangText("NoPuppygirlCatgirls", "SlaveTrainings/Puppygirl");
				return false;
			}		
			if (slaveData.IsDressCatTail()) {
				SetLangText("AlreadyHasCatTail", xNode);
				Bloop();
				return false;
			}
			if (SMData.sCatTrainer < slaveData.CatgirlInterest) {
				XMLGeneral("RefuseCatgirlTail", true, xNode);
				coreGame.SlaveGirl.ShowRefuseCatgirl(24);
				coreGame.SelectEquipment.ShowOtherEquipment();
				Bloop();
				return false;
			}
			if (!coreGame.TestObedience(coreGame.DifficultyPlug)) {
				ServantSpeak("#slave refuses to wear it, it looks like #slaveheshe is not yet ready to have an anal plug, even in the form of a cat tail.");
				coreGame.SelectEquipment.ShowOtherEquipment();
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, -1, -1);
				Bloop();
				return false;
			}
			if (coreGame.CatEarsWorn == 1)  {
				StartTraining();
				if (coreGame.NumEvent == 9706) coreGame.EquipItem(item);
				return false;
			}
		}
		return true;
	}
	
	public function RemoveItemAsAssistant(item:Number) : Boolean
	{ 
		switch(item) {
			case 23:
				if (slaveData.BitFlag1.CheckBitFlag(15)) {
					SlaveSpeak(Language.GetHtml("RefuseToRemoveCatgirlItem", xNode));
					Bloop();
					return false;
				} else if (slaveData.BitFlag1.CheckBitFlag(45)) {
					ServantSpeak(Language.GetHtml("RemoveCatGirlItem", xNode));
					coreGame.SelectEquipment.ShowOtherEquipment();
					DoYesNoEvent(2050);
					coreGame.ShowDress();
					return false;
				}
				break;
				
			case 24:
				if (slaveData.BitFlag1.CheckBitFlag(15)) {
					SlaveSpeak(Language.GetHtml("RefuseToRemoveCatgirlItem", xNode));
					Bloop();
					return false;
				} else if (slaveData.BitFlag1.CheckBitFlag(45)) {
					ServantSpeak(Language.GetHtml("RemoveCatGirlItem", xNode));
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
		switch (item) {
			case 23: coreGame.CatEarsWorn = 1; break;
			case 24: coreGame.CatTailWorn = 1; coreGame.PlugInserted = 1; break;
		}
		return false;
	}
	
	
	public function UnEquipItemAsAssistant(item:Number) : Boolean
	{ 
		switch (item) {
			case 23: coreGame.CatEarsWorn = 0; break;
			case 24: coreGame.CatTailWorn = 0; coreGame.PlugInserted = 0; break;
		}
		return false;
	}	
	
	public function SetEquipmentTabsAsAssistant()
	{
		nModuleTab = coreGame.SelectEquipment.SetTabDetails(Language.GetHtml("Cat", "Equipment"));
	}
	
	public function ShowEquipmentTabAsAssistant(nTab:Number)
	{
		if (nTab != nModuleTab) return;
		
		coreGame.SelectEquipment.AddEquipmentButton(1, 23, coreGame.CatEarsWorn == 1, coreGame.CatEarsOK == 1, Language.GetHtml("CatEars", "Equipment"), "Q");
		coreGame.SelectEquipment.AddEquipmentButton(2, 24, coreGame.CatTailWorn == 1, coreGame.CatTailOK == 1, Language.GetHtml("CatTail", "Equipment"), "I");
	}
	
	
	// Jobs
	
	public function AfterJobAcolyte(pay:Number)
	{
		if (coreGame.FirstTimeTodayAcolyte && slaveData.IsCatgirl()) {
			if (coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
			if (IsCatgirlEvent()) {
				AddTextToStart("During her work in the shrine, #slavemeet a cat slave in training. The cat slave is sweeping the yard, looking very cute and somewhat elegant. Briefly they chat on the gods, cat and life in general.\r\r");
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				HideBackgrounds();
				ShowMovie(this.mcBase.PlanningJobs, 1, 1, 1);
				coreGame.ChangeCatTraining(1);
			}
		}
	}
	
	public function AfterJobBar(pay:Number)
	{
		if (coreGame.FirstTimeTodayBar && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
		
			if (IsCatgirlEvent()) {
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				Backgrounds.ShowBar();
				ShowMovie(this.mcBase.PlanningJobs, 1, 1, slrandom(2) + 2);
				coreGame.ChangeCatTraining(1);
				if (GetPlace("TownCenter").CheckBitFlag(34)) AddText("\r\r#slave serves a cat slave while working and has a pleasant talk with her.");
				else AddText("\r\r#slave serves the cat slave regular while working and has a pleasant talk with her.");
	
			}
		}
	}
	
	public function AfterJobBrothel(pay:Number)
	{
		if (coreGame.FirstTimeTodayBrothel && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
			
			if (IsCatgirlEvent() && GetPlace("Slums").CheckBitFlag(34) == false) {
				GetPlace("Slums").SetBitFlag(34);
				SetText("#slave's first customer is an attractive catgirl who lies down beside #slave and looks at #slavehimher,\r\r");
				PersonSpeak(66, "Mmmmm, I love cat slaves, especially new ones in training, all cute and inexperienced, as a cat girl. Let us explore and enjoy love as catgirls, Meeeeow", true);
				AddText("\r\rThey spend the entire duration of #slave's shift licking and caressing and rubbing each other to orgasm after orgasm. The catgirl customer shows #slave some interesting uses for their tails...\r\rAfter the catgirl leaves a substantial tip for #slave,\r\r");
				Money(100, true);
				PersonSpeak(27, "The lady was a special customer of our and she complimented you skill. Here is your pay: " + (pay + 100) + coreGame.GP, true);
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				HideBackgrounds();
				ShowMovie(this.mcBase.PlanningJobs, 1, 0, 2);
				coreGame.ChangeCatTraining(3);
				return;
			}
		}
		if (GetPerson("Natsu").CheckBitFlag(32) && GetPerson("Natsu").CheckBitFlag(51) == false) {
			AddText("After collecting payment #slaveis leaving and #slaveheshe hears a familiar voice...");
			GetPerson("Natsu").SetBitFlag(51);
			DoEvent(2070);
		}
	}
	
	public function AfterJobRestaurant(pay:Number)
	{
		if (coreGame.FirstTimeTodayRestaurant && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
	
			if (IsCatgirlEvent()) {
				AddText("\r\rShe works with another waitress during her shift. The girl is a rather buxom cat slave and she is quite clumsy, maybe deliberately.\r\rThey talk a bit during breaks about their lives.");
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				Backgrounds.ShowRestaurant();
				ShowMovie(this.mcBase.PlanningJobs, 1, 1, slrandom(2) + 4);
				coreGame.ChangeCatTraining(1);
			}
		}
	}
	
	public function AfterJobSleazyBar(pay:Number)
	{
		if (coreGame.FirstTimeTodaySleazyBar && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
		
			if (PercentChance(50) && GetPlace("Slums").CheckBitFlag(35) == false) {
				GetPlace("Slums").SetBitFlag(35);
				temp = slrandom(2) + 6;
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				if (temp == 7) {
					HideBackgrounds();
					AddText("\r\rJust as #slaveis finishing her shift a pair of catgirl step out, completely naked but looking very happy and start energetically serving customers.\r\rBy serving, they ignore all pretense as one straddles the lap of a male customer and takes out his erect cock and mounts herself, fucking him quickly. The other catgirl expertly deep throats another customer while masturbating herself.\r\rWhen #slave returns from changing clothing the first catgirl is being fucked by three customers, cocks in her pussy, ass and mouth. The other catgirl is kneeling over the face of a female customer, who is awkwardly licking her pussy. A male customer is cumming and pumping his cum into her mouth. When he stop she licks her lips and meows 'more!'");
				} else {
					Backgrounds.ShowBar();
					AddText("\r\rJust as #slaveis finishing her shift a catgirl dresses in a bunny suit gives an rather cute and sensual dance. She is rather reserved, and refuses several requests for 'special service', but she is very cute and sensual.");
				}
				ShowMovie(this.mcBase.PlanningJobs, 1, 1, temp);
				coreGame.ChangeCatTraining(3);
			}
		}
	}
	
	
	// Schools
	
	public function AfterSchoolDance()
	{
		if (coreGame.FirstTimeTodayDancing && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
	
			if (IsCatgirlEvent()) {
				AddTextToStart("During the lesson, #slave notices another student, a cat slave in training. The cat slave is an excellent dancer and gives #slave some pointers about dancing with a tail.");
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				HideBackgrounds();
				ShowMovie(this.mcBase.PlanningSchools, 1, 1, 1);
				coreGame.ChangeCatTraining(1);
			}
		}
	}
	
	public function AfterSchoolRefinement()
	{
		if (coreGame.FirstTimeTodayRefinement && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
			
			if (IsCatgirlEvent()) {
				AddText("\r\r#slave chats after class with a cute girl cat slave.");
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				HideBackgrounds();
				ShowMovie(this.mcBase.PlanningSchools, 1, 1, 2);
				coreGame.ChangeCatTraining(1);
			}	
		}
	}
	
	public function AfterSchoolSciences()
	{
		if (coreGame.FirstTimeTodaySciences && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
	
			if (IsCatgirlEvent()) {
				AddText("\r\r#slave chats after class with a cute girl cat slave.");
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				HideBackgrounds();
				ShowMovie(this.mcBase.PlanningSchools, 1, 1, slrandom(2) + 2);
				coreGame.ChangeCatTraining(1);
			}
		}
	}
	
	public function SlaveMakerTraining() : Boolean 
	{ 
		var Singer:Person = coreGame.People.GetPersonsObject("Singer");
		if (!(coreGame.Supervise && Singer.SMFlag >= 3 && SMData.sCatTrainer < 1)) return false;
		
		AddText("You talk with #personsinger after the lesson about the nature of catgirls and how to encourage slaves to become cat slaves.\r\r");
		switch (int(SMData.sCatTrainer * 10)) {
			case 0:
				SMMoney(-50);
				coreGame.HideSlaveActions();
				HideBackgrounds();
				ShowPerson(51, 1, 1, 4);
				PersonSpeak(51, "Most importantly a catgirl must wear cat ears and a tail. They must be a girl who looks and acts like a cat. These items must always be worn, but can at times be concealed.", true);
				AddText("\r\rShe adjusts her already cat-like hair and a pair of cat ears spring up. Rather cutely she shakes her bottom and you see a cat tail drop out. She smiles and just says 'Meow!'\r\rYou ask about where to get these ears and tail but she just smiles and almost purrs. She continues, ignoring the question,\r\r");					
				PersonSpeak(51, "You could even train a male to be a catboy, a rather rare type of slave, Meow!", true);
				break;
			case 1:
				PersonSpeak(51, "A catgirl is happy and cute! Meow!", true);
				AddText("\r\rShe pauses expectantly,\r");
				coreGame.AskHerQuestions(2000, 2001, 0, 0, "#personsinger, you are cute!", coreGame.SlaveIs + " cute!", "", "", "What do you say");
				break;
			case 2:
				SMMoney(-50);
				if (SMData.PonygirlAware > 0) coreGame.PersonSpeakStart(51, "A catgirl is a catgirl, and not any other type of animal. There are no pony catgirls!", true);
				else coreGame.PersonSpeakStart(51, "Being a catgirl should be your slave's main focus.", true);
				coreGame.PersonSpeakEnd("\r\rThey can also have other trainings, they can be sex-kittens, courtesans, martial artists, singing tutors and more. Meow!"); 
				break;
			case 3:
				if (coreGame.DickgirlOn != 0) PersonSpeak(51, "Catgirls can be tom-cats, both male and girls who have cocks. They should always be feminine or masculine as appropriate, and be cute! Meow!", true);
				else PersonSpeak(51, "Catgirls should always be feminine or masculine as appropriate, and be cute! Meow!", true);
				AddText("\r\rShe pauses,\r");
				coreGame.AskHerQuestions(2002, 2003, 0, 0, "#personsinger, you're feminine and cute!", coreGame.SlaveIs + " cute!", "", "", "What do you say");
				break;
			case 4:
				coreGame.HideSlaveActions();
				HideBackgrounds();
				PersonSpeak(51, "Catgirls should also be sex kittens and when appropriate refer to loving 'cream' and loving it's taste. Always 'cream' not those other names. Meeeow", true);
				AddText("\r\rShe seductively removes some of her clothing and lies down and you can swear you can hear her purring,\r\r");
				ShowPerson(51, 1, 1, coreGame.DickgirlOn != 0 ? 7 : 6);
				if (coreGame.DickgirlOn != 0) {
					PersonSpeak(51, "A catgirl is happy to use tongue, pussy, ass or her cock at anytime. To lick 'cream' be it someone else's or her own... Purrr!", true);
					AddText("\r\rShe gestures for you to approach and when you do she removes your lower clothing and passionately licks your ");
					if (SMData.Gender == 2) AddText("pussy with her wonderfully skilled tongue.");
					else AddText("cock with her lovely tongue and then takes it inside her mouth, licking the head with her tongue.");
					AddText("\r\rShe pauses before you can climax and she asks #slave to drink her 'cream'. #slave kneels and #slaveheshe licks her cock. #slaveA takes #personsinger's cock into #slavehisher mouth, and #personsinger resumes her licking of you.\r\rAfter a few more minutes, you ");
					if (SMData.Gender == 2) AddText("orgasm and #personsinger licks up all your juices. When she is finished she strains and cums into #slaveA's mouth.");
					else AddText("cum and #personsinger swallows all of your cum. When she finishes she strains and cums into #slaveA's mouth.");
				} else {
					PersonSpeak(51, "A catgirl is happy to use tongue, pussy or ass at anytime. To lick 'cream' be it someone's male or female... Meow!", true);
					AddText("\r\rShe gestures for you to approach and when you do she removes your lower clothing and passionately licks your ");
					if (SMData.Gender == 2) AddText("pussy with her wonderfully skilled tongue.");
					else AddText("cock with her lovely tongue and then takes it inside her mouth, licking the head with her tongue.");
					AddText("\r\rShe pauses before you can climax and she asks #slave to lick her 'cream'. #slave kneels and #slaveheshe licks her pussy, and #personsinger resumes her licking of you.\r\rAfter a few more minutes, you ");
					if (SMData.Gender == 2) AddText("orgasm and #personsinger licks up all your juices. When she is finished she strains and orgasms as well.");
					else AddText("cum and #personsinger swallows all of your cum. When she finishes she strains and orgasms as well.");
				}
				AddText("\r\rAfter, #personsinger licks her hands and washes her face in a rather cat-like fashion. You hear her mutter something about how jam goes well with 'cream'.\r\rWith a blush she says that she is not a prostitute so this lesson is free.");
				SMData.SMPoints(0, 0, 0, 0, 0, -3, 0, 0, 0);
				Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
				break;
			case 5:
				SMMoney(-50);
				coreGame.HideSlaveActions();
				HideBackgrounds();
				PersonSpeak(51, "Catgirls should emulate cats at all times, and also use cat words where possible, so take cat naps, or visit the cat house and so on.\r\rParticularly nap like a cat and try to look cute even when asleep. Meow!", true);
				AddText("\r\rShe demonstrates a little how to prepare for sleep.");
				ShowPerson(51, 1, 1, 2);
				Backgrounds.ShowOverlay(0xFFCEEE);
				break;
			case 6:
				SMMoney(-50);
				coreGame.HideSlaveActions();
				HideBackgrounds();
				GetPerson("Natsu").SetMet();
				PersonSpeak(51, "It is important to learn how to be a catgirl. A catgirl must meet many other catgirls and talk about their life and how they like being a catgirl. Meow!", true);
				AddText("\r\rShe introduces you and #slave to a friend of hers, a catgirl named Natsu, a slightly crude girl, but apparently from a minor noble house. #personsinger explains she is a good example of a female tom-cat, a wild and dominant catgirl, but still very cute.\r\rNatsu talks for a while with #slave of her life as a catgirl and of how she serves with the City Militia.");
				ShowPerson(61, 1, 3, 1);
				Backgrounds.ShowOther(1);
				coreGame.ChangeCatTraining(1);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				break;
			case 7:
				SMMoney(-50);
				coreGame.HideSlaveActions();
				HideBackgrounds();
				PersonSpeak(51, "A person has to want to be a catgirl you cannot force her into it, or trick her. Let her decide for herself and eventually she will decide one way or another, and since being a catgirl is fun, then Meow!", true);
				ShowPerson(51, 1, 1, 4);
				break;
			case 8:
				SMMoney(-50);
				coreGame.HideSlaveActions();
				HideBackgrounds();
				PersonSpeak(51, "A catgirl must always end her speech with Meow!\r\rWell, when tutoring I do not but it always feels wrong and I often do so under my breath. Meow!", true);
				ShowPerson(51, 1, 1, 8);
				break;
			case 9:
				SMMoney(-50);
				coreGame.HideSlaveActions();
				PersonSpeak(51, "A catgirl must be proud of her nature, after all you live with a cat, a cat does not live with you.\r\rBut then again a cat can also be your pet...\r\rMeow!", true);
				ShowPerson(51, 1, 3, 3);
				Backgrounds.ShowOverlay(0xDCDCDE);
				break;
		}
		XMLGeneral("SlaveMakerTraining", false, xNode);
		coreGame.ChangeCatTraining(1);
		SMData.sCatTrainer += 0.1;
		if (SMData.sCatTrainer > 0.9) {
			SMData.sCatTrainer = 1;
			AddText("\r\r#personsinger congratulates you,\r\r");
			coreGame.HideSlaveActions();
			PersonSpeak(51, "I think you now know enough to train catgirls. I will teach them both singing and how to be a catgirl when they visit but only a certain amount.\r\rBy the way I have heard a certain Lady Farun deals in exotic slaves and she is sure to have a supply of cat ears and tails! Meow!", true);
			ShowPerson(51, 1, 3, 3);
			Backgrounds.ShowOverlay(0xDCDCDE);
		}
		return true;
	}

	
	public function AfterSchoolSinging()
	{
		trace("Catgirls.AfterSchoolSinging: " + coreGame + " " + coreGame.FirstTimeTodaySinging + " " + (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()));
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return;
		
		//if (coreGame.FirstTimeTodaySinging) {
			var Singer:Person = coreGame.People.GetPersonsObject("Singer");
			switch(Singer.SMFlag) {
				case 0:
					Singer.SMFlag = 1;
					AddText("After the lesson, the tutor whose name is #personsinger, talks for a while to #slave about music and comments about how the music from Firee sounds like caterwalling to her. She smiles and says,\r\r");
					PersonSpeak(51, "Not that cat-erwalling is bad. Meow!", true);
					AddText("\r\rShe blushes a little and bids #slave goodbye.");
					return;
				case 1:
					if (slaveData.slSinging >= 1) Singer.SMFlag = 2;
					break;
				case 2:
					coreGame.HideSlaveActions();
					HideBackgrounds();
					ShowPerson("Singer", 1, 1, 4);
					ShowSupervisor();
					Singer.SMFlag = 3;
					SetText("During the lesson, the tutor #personsinger, trips over and makes a loud 'Meow!' and #slavesee #personsinger kneeling, looking very catlike.\r\r");
					PersonSpeak(51, "Meow! As you see, I am a catgirl and I love it! I am so tired of hiding it and pretending! Some people think singing is a high art and feel I should be a more formal, elegant woman. I just do not let out my cattishness during lessons.\r\rStill, I love being a catgirl, and would encourage everyone to try it, there is no harm and it is really fun! Meow!", true);
					if (SMData.sCatTrainer == 0) {
						if (coreGame.Supervise) AddText("\r\rYou ask her about training cat slaves and who trained her? She blushes and says that she is not a slave to be trained, and learned it herself. She then smiles and suggests that she can train you instead, in how to train catgirls!\r\rShe talks a little, but tells you to return with your slave and that she will educate you after the lesson in the ways of catgirls.");
						else AddText("\r\r#assistant" + coreGame.NonPlural(" ask", coreGame.ServantGender) + " about the nature of catgirls and explains that you are not educated in how to train catgirls. #personsinger smiles and suggests that she can train you in how to train catgirls!\r\rShe talks a little, but tells #assistant to have you return with your slave and that she will educate you after the lesson in the ways of catgirls."); 
						AddText("\r\r#personsinger does explain the training will cost a little extra, about 50GP a lesson.");
					}
					return;
			}
			if (!SlaveMakerTraining()) {
				if (slaveData.IsCatgirl()) {
					if (slaveData.slCatTraining > 0 && slaveData.slCatTraining < 30) coreGame.ChangeCatTraining(1);
				}
				switch(slrandom(4)) {
					case 1:
						AddText("After the lesson #personsinger tells #slave to try practicing some vocal exercises in #slavehisher free time. She tells #slave to experiment with a word and she give a demonstration 'Meow, Meeeow, Meooow, Meowwww'");
						break;
					case 2:
						AddText("During the lesson #personsinger acts very playful and happy. Her mood is rather infectious and makes #slave happy too.");
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0);
						break;
					case 3:
						AddText("After the lesson #personsinger congratulates #slave and leans in to kiss #slavehisher cheek, but instead licks #slavehisher cheek.");
						break;
					case 4:
						AddText("After the lesson as #slaveis leaving #personsinger waves goodbye, somewhat enthusiastically and as she does a tail falls down and is clearly visible hanging down between her legs.");
						break;
				}
			}
		//}
	}
	
	public function AfterSchoolXXX()
	{
		if (coreGame.FirstTimeToday && coreGame.IsCatgirlTraining()) {
	
			if (this.CatgirlEvents == false || !coreGame.bAllowEvents || coreGame.AppendActText == false || coreGame.NextEvent._visible || coreGame.AskQuestions._visible || coreGame.YesEvent._visible || coreGame.TakeAWalkMenu._visible || coreGame.HouseEvents.IsExploring()) return; 
		
			if (IsCatgirlEvent()) {
				ShowMovie(this.mcBase.PlanningSchools, 1, 13, 5);
				coreGame.ChangeCatTraining(1);
				Backgrounds.ShowOverlay(0x6e6f84);
				var say:String = "For the first part of the lesson the teacher introduces a pair of cat slaves. They demonstrate team-work by giving a blowjob to a male student in the class, expertly taking turns at licking his cock and balls, and more importantly doing so together. They happily accept his 'cream' all over their faces.\r\rFor the rest of the lesson they proceed around the class, demonstrating the same to all the cocks in the class";
				if (coreGame.HasCock) {
					say += "including #slave";
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, -3, 0, 1, 0, 0, 0);
				} else Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
				AddTextToStart(say + "...");
			}
		}
	}
	
	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// 2000 - #personsinger is cute
			case 2000:
				Points(1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, -2, 0);
				AddText("You say 'Just like you!'. She smiles and continues,\r\r");
				PersonSpeak(51, "If a catgirl is unhappy or not pretty then she is not a catgirl, she is just a person dressing-up! Keep them happy and pretty.\r\rSince you are so clear sighted, this lesson is free. Meow!", true);
				Money(50);
				return true;
	
			// 2001 - Slave is cute
			case 2001:
				Points(1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 2, 0);
				AddText("You say 'Just like #slave!'. #slave smiles but #personsinger looks a little surprised and continues,\r\r");
				PersonSpeak(51, "Oh my...well, if a catgirl is unhappy or not pretty then she is not a catgirl, she is just a person dressing-up! Keep them happy and pretty. Meow!", true);
				return true;
				
			// 2002 - #personsinger is cute
			// 2003 - Slave is cute
			case 2002:
			case 2003:
				if (coreGame.NumEvent == 2002) {
					Money(50);
					Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0);
					AddText("You say 'You are very feminine and very cute!'. She smiles and continues,\r\r");
					PersonSpeak(51, "Train your slave to be their best\r\rSince you are so clear sighted, this lesson is free. Meow! ", true);
				} else {
					Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 2, 0);
					AddText("You say 'Just like #slaveis cute!'. #slave smiles but #personsinger looks a little surprised, she hesitates and continues,\r\r");
					PersonSpeak(51, "Oh...all right. Train your slave to be their best. Meow!", true);
				}
				return true;
	
			// Get swimsuit and lotion
			case 2020:
				Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 1, 4, 0, 3, 0, 0, 0, 0, 0);
				ShowPerson(42, 0, 0);
				SetText("#slave goes to the building and looks in the door. There is no sign of a swimsuit but there are several bottles of lotion. #slave reaches for one and a strange looking man stops #slavehimher. He just shakes his head and says,\r\r");
				PersonSpeak(42, "She has had enough.", true);
				AddText("\r\rHe waves at #slave to leave. #slave returns and tells the catgirl. She looks devastated and starts to cry, making soft meowing noises. She sits down and #slave tries to comfort her. The catgirl continues her sad noises, and then raises her shirt, exposing her cock. It is glistening with moisture or some sort of oil. She slides a hand along her cock and stops crying. She pounces on #slaveA, hugging #slavehimher as she stokes her cock. The catgirl licks #slaveA's ear and as she meows and cums. #slaveA sees that while the catgirl is clearly in great pleasure, she does not ejaculate, no cum at all. The catgirl, stands a little wearily and walks away.\r\rA moment later a voice can be heard from the direction of the building,\r\r");
				PersonSpeak(42, "How many times can you orgasm and cum? For her, well that is our secret.", true);
				AddText("\r\r#slave and #super look but no-one is to be seen.");
				return true;
				
			// Refuse and escort
			case 2021:
				Points(0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0);
				SetText("#slave and #super are doubtful and refuses to go, quite sure the catgirl is lying. Instead telling the catgirl they will escort the catgirl to a safe place or even to her home. The catgirl look rather disappointed and pounces off, running into the bushes.\r\rClearly she did not get what she wanted and left to find another to try and trick.");
				return true;
				
			// Ask questions
			case 2022:
				Points(0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 2, 0, 0, 0, 0, 0);
				SetText("#slave and #super are doubtful and ask the catgirl more about the building and why she cannot go there herself. She looks disappointed and just sits down, shaking her head. She whispers something like 'no allowed more, meow' and just raises her shirt, exposing her cock. It is glistening with moisture or some sort of oil. She slides a hand along her cock and masturbates very fast, her hand moving fast as she makes meowing noises. She meows loudly and orgasms, clearly in great pleasure, but she does not ejaculate. She meows and leans against a tree, and whispers,\r\r");
				PersonSpeak("Catgirl", "No more 'cream' but if I could be more lotion then plenty more. Not now, not meow.", true);
				AddText("\r\rShe falls asleep, and #slave and #super leave her to her dreams of 'cream'.");
				return true;
				
			// Help Natsu
			case 2030:
			// Help Woman
			case 2031:
				coreGame.Sounds.StopAllSounds();
				GetPerson("Natsu").SetBitFlag(50);
				ShowMovie(this.mcBase.EventWalk, 1, 0, 19);
				coreGame.ChangeCatTraining(3);
				Points(0, 0, 0, 1, 2, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 4, 3, 0, 0, 0);
				if (coreGame.NumEvent == 2031) SetText("#slave move to the assaulted woman to get her clear of the fight and notices she is reaching for a vase, #slave assumes to hit the Catburglar. The woman is startled by #slave and drops the vase, and as it hits the ground the Catburglar looks to see what happened and Natsu pounces and is able to restrain her.");
				else SetText("#slave leaps and grabs the Catburglar who was focusing all her attention on fighting Natsu. They fall to the ground and Natsu pounces and they are able to easily restrain the Catburglar.");
				AddText("\r\rNatsu ties up the Catburglar who looks resigned and stares at the woman she was robbing,\r\r");
				PersonSpeak(62, "Ah well, I lose, such a pity this one was such a very good prey, wealthy and sexy. It took me a while to stalk her and work out what she had and wanted. Meow!", true);
				AddText("\r\rNatsu looks curious and asks the Catburglar about the stalking and what the woman wanted?\r\r");
				PersonSpeak(62, "I pick wealthy women who will not miss what I steal. I also prefer women that like a cat's tongue and pussy. Meow!", true);
				AddText("\r\rMarna blushes red and stammers,\r\r");
				PersonSpeak(65, "Nonsense, that is against the gods, it is immoral!", true);
				AddText("\r\r#slave can clearly remember the orgasm the woman was having as they arrived and the very light bindings, bindings anyone could of escaped from. The Catburglar was clearly give the woman the excuse that she was forced, but equally clearly she was passionately enjoying it.\r\rNatsu smiles, and removes the Catburglar's cat ears and tail. The now burglar strongly objects, insisting they be replaced, and Natsu replies,\r\r");
				PersonSpeak(61, "You do not deserve to be a catgirl. You are a thief, catgirl's hunt prey but this is a game. We do not take, we are given what we deserve.\r\r#slave, it is a disgrace for a catgirl to have her ears and tail removed, maybe someday she will earn hers back but until then she is a normal person. Meeoow!", true);
				AddText("\r\rNatsu's final Meoow was very emphasised.\r\rAfter a while more members of the militia arrive and they take the burglar away.\r\rNatsu and #slave leave the house, the owner still looking very embarrassed.\r\r");
				PersonSpeak(61, "Hunt's over #slave, thanks for your help. Meow!", true);
				return true;
				
			// Aid Catburglar
			case 2032:
			// Hesitate
			case 2033:
				ShowPerson(61, 1, 0, 20);
				coreGame.ChangeCatTraining(3);
				if (coreGame.NumEvent == 2033) {
					Points(0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0);
					SetText("#slaveis uncertain what to do and waits a bit. The woman who owns the home, Marna,  steps towards the fight, holding a vase and accidentally hits Natsu over her head. Marna blushes and looks at #slave as Natsu falls to the ground. The Catburglar smiles and leaps on #slave and quickly restrains #slavehimher. The Catburglar quickly and very securely ties up #slave.");
				} else {
					Points(0, 0, 0, 1, -3, 1, 0, 0, 1, 0, 0, 3, 2, 0, 2, 0, 2, 0, 0, 0);
					Money(100, true);
					SetText("#slave can clearly see the woman Marna is quite willing, at worst this is prostitution, not a robbery. Natsu will never believe this, especially as she is fighting the Catburglar now, so #slaveA leaps into the fight and 'accidentally' trips and lands on Natsu. The Catburglar pounces and hits Natsu who falls unconscious. She looks at #slave a bit quizzically and #slave explains #slavehisher reasoning. The Catburglar looks at Marna and smiles.\r\r");
					PersonSpeak(62, "I lick and suck her to orgasm and take money, so you could call it that.\r\rThank you, I'll give you a share of the loot, unfortunately we do not have time to share Marna here.", true);
					AddText("\r\rMarna blushes deeply and the Catburglar explains she will have to tie up #slave to pretend #slaveheshe was overpowered by the Catburglar.");
				}
				AddText(" She then strips Natsu to her underwear and then secures her, ignoring Marna, who is standing there blushing deeply.\r\rThe Catburglar walks over the Marna and lightly ties her hands behind her back.\r\rThe Catburglar removes Natsu's cat ears and tail and then inserts a dildo in Natsu's pussy. Natsu wakes and demands her ears and tail be replaced.\r\r");
				PersonSpeak(62, "No, I won this catfight, so you are my mouse to play with. Unfortunately we will not have much time, I assume your friends will be here soon. I will have to lay low for a while and stop hunting. Such a pity this one was such a very good prey, wealthy and sexy. It took me a while to stalk her and work out what she had and wanted. Meow!", true);
				AddText("\r\rNatsu is angry and demands the Catburglar explain,\r\r");
				PersonSpeak(62, "No! Mice do not make demands of cats.\r\rNow, my prey, Marna, use your tongue as I did for you. Keep them busy while I escape. You know what I will do if you do not... Meow!", true);
				AddText("\r\rThe woman blushes red and the Catburglar releases her hands , bust before leaves, probably escaping through the back door. Marna stammers,\r\r");
				PersonSpeak(65, "I have to do this immoral thing, I must...", true);
				AddText("\r\rMarna licks and sucks Natsu's clit and works the dildo in and out of her pussy. Natsu looks quite angry and struggles a bit but she is aroused by Marna's fairly skilled attention.\r\rNatsu is doing her best to hide her growing arousal, but sometimes she lets out a soft meow. There is a noise at the door and Natsu looks almost in panic and calls out 'Here'. Marna realises what this means and fucks the dildo faster and sucks on Natsu's clit with renewed vigour. A couple of militia men enter the room as Natsu flushes red and orgasms, softly meowing and growling. Marna continues licking as the men look on, surprised but then smiling. Natsu pants and says,\r\r");
				PersonSpeak(61, "the back door..ahh meow!", true);
				AddText("\r\rWith barely a pause Marna stops licking Natsu's clit and instead licks and fingers Natsu's asshole. Natsu moans 'not that back door' and the men smile and leave the room to check the rear entrance.\r\rMarna licks Natsu's asshole with some vigour, and continues working the dildo in Natsu's pussy. After a while, Natsu meows and orgasms again, meowing and shuddering in what #slave can see is an even stronger orgasm than her last one.\r\rThe militia men immediately enter the room, smiling, and one says,\r\r");
				PersonSpeak("Militia Man", "The back door looks clean...of sign of the criminal.", true);
				AddText("\r\rStill smiling they free Natsu and #slave. Immediately Natsu puts on her cat ears and tail back on, and then the rest of her clothing. She looks at Marna rather angrily but also blushing, and she leave the house, dragging #slave along.\r\r");
				PersonSpeak(61, "The hunt is over, that Catburglar will hide now so we will not be able to find her. I'll catch her one day, just not for  awhile.\r\rThat, that woman Marna, I am tempted to arrest her, but she can claim she was threatened. Rubbish, she was a willing accomplice, just lusting after catgirl pussy and tongue, but repressed into believing it wrong by the church. Meeoow!", true);
				AddText("\r\rNatsu is clearly angry, but #slave can remember how strongly Natsu orgasmed, so who is hiding her desires now?");
				return true;
				
			// High class party catgirl
			case 2040:
				coreGame.ChangeCatTraining(2);
				ShowPerson(67, 1, 2, 1);
				SetText("The Lady Cat and #slave talk for a while, pleasantly, the Lady explains why she shook her head,\r\r");
				PersonSpeak("Lady Cat", "The Lady is an interesting conversationalist but a bit self-centered. She is only really interested in being pleasured by her maids.\r\rSeances are boring, nothing really happens so don't go there.\r\rNow how about something to drink?", true);
				AddText("\r\rThat Lady looks rather intense with the question. #slaveis unsure why, will #slaveheshe go for a drink?\r");
				DoYesNoEvent(2040);
				return true;
	
			// catgirl wife
			case 2061:
				coreGame.ChangeCatTraining(4);
				GetPerson("Natsu").SetBitFlag(34);
				Points(0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 2, 2, 1, 0);
				GetPerson("Natsu").SetBitFlag(43);
				AddText("#slave tells the catgirl that she is a catgirl and if her owner cannot accept that he does not truly love her. She should be a catgirl wife not a catgirl or a wife!\r\rThe catgirl smiles and agrees, and immediately leaves saying she is going to see her owner!");
				AddText("\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try and hunt again.");
				return true;
	
			// love not catgirl
			case 2062:		
				coreGame.ChangeCatTraining(-2);
				AddText("and meet a naked catgirl, stalking and running through the Town Center. She runs on all fours, on two feet but always looks very catlike and the only thing she says is 'Meow!'.\r\rNatsu comments that she admires the other girl's attitude and training.\r\rThe rest of the time passes and they find nothing.");
				GetPerson("Natsu").SetBitFlag(34);
				Points(0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, -2, 0, 1, 0, 0, 2, 1, 2, 0);
				GetPerson("Natsu").SetBitFlag(43);
				AddText("#slave tells the catgirl that love is more important than being a catgirl! If her owner cannot accepts her as a catgirl wife then is it better to be a wife.\r\rThe catgirl smiles a little and hesitantly removes her cat ears, and a little reluctantly leaves saying she is going to see her owner!");
				AddText("\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try and hunt again.");
				return true;
				
			// Natsu Brothel
			case 2070:
				SetText("#slave peeks into the room and sees the catgirl Natsu passionately fucking a customer. There is no acting here, Natsu is very aroused and very much enjoying it. Natsu looks up and notices #slave watching and she smiles. Her customer groans and stiffens as he cums into Natsu. While still looking at #slave Natsu rubs her clit hard and a little later orgasms as well.\r\rSometime later Natsu joins #slave, still smiling and they talk,\r\r");
				PersonSpeak(61, "Don't mention this, I was trying to get something from that man. Meow!", true);
				AddText("\rShe smiles\r");
				PersonSpeak(61, "Not <i>that</i> but some information. As I told you before I sometimes have to do 'undercover work' Meow!", true);
				coreGame.HideSlaveActions();
				coreGame.HideImages();
				ShowPerson(61, 1, 3, 4);
				Backgrounds.ShowOverlay(0);
				coreGame.ChangeCatTraining(1);
				return true;
	
			// Prostitute Party - Maid - Outside
			case 8031:
				if (!(slaveData.IsCatgirl() && CatgirlEvents && coreGame.bAllowEvents)) return false;
				SetText("#slave" + coreGame.NonPlural(" walk") + " outside expecting to serve drinks and the like. A man approaches and attaches " + coreGame.Plural("a leash") + " to " + coreGame.SlaveHisHer + coreGame.Plural(" neck") + " and explains that Masters and Mistress like to show off their slaves here. #slave can see several slaves and maids kneeling submissively, some crawling on all fours acting like dogs or cats. Their Masters or Mistresses leading them with leashes and demonstrating how animal-like they are.\r\r");
	
				if (slaveData.slCatTraining > 45) {
					var Singer:Person = coreGame.People.GetPersonsObject("Singer");
					Singer.SetBitFlag(34);
					coreGame.ChangeCatTraining(3);
					AddText("#slave meows and pounces and leaps around, being a good little kitty");
					if (coreGame.SlaveFemale) AddText(", showing " + coreGame.SlaveHisHer + coreGame.Plural(" pussy") + " to all.");
					else AddText(".");
					AddText("\r\r#slave finally understands and completely and fully considers #slavehimher to be <b>a cat slave!</b>");
					if (coreGame.SlaveGirl.FinishedTraining() != true) {
						ShowMovie(this.mcBase.Training, 1, 0, 2);
						XMLGeneral("FinishedCatgirlTraining", false, xNode);
					}
					slaveData.BitFlag1.SetBitFlag(15);
				} else {
					coreGame.ChangeCatTraining(2);
					AddText("#slave meows and pounces and leaps around, being a good little kitty");
					if (coreGame.SlaveFemale) AddText(", showing " + coreGame.SlaveHisHer + coreGame.Plural(" pussy") + " to all.");
					else AddText(".");
					AddText("\r\r#slave cannot fully get into the role of a cat slave, #slavehisher training needs to be more advanced, maybe then....");
					ShowMovie(this.mcBase.Parties, 1, 0, 1);
	
				}
				if (coreGame.FurriesOn) {
					AddText("\r\rLater #slave overhears two Master talking,\r\r");
					PersonSpeak("Master 1", "I would like to have one of those furry slaves here, after all they are half animal and can truly be the part.", true);
					BlankLine();
					PersonSpeak("Master 2", "No, no, that is their nature. The point here is the slave is submitting to you, willing to become an animal for you. It is their desire to obey and follow your desire that is important.", true);
					AddText("\r\rThe two argue for a while, reaching no conclusion.");
				}
				Points(0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 2, 0, 0, 1, 1, 0, 0);
				DoEvent(8039);
				return true;
				
			// Dinner
			case 8050:
				temp = ((Math.floor(Math.random()*2))*8) + 5;
				ShowMovie("Parties/EventParties", 1, 0, temp);
				ShowPerson(67, 0, 2, 1);
				SetText(coreGame.SlaveVerb("spend") + " part of the evening eating dinner and chatting with other guests.\r\r");
				if (temp == 13) {
					AddText("Part way through the meal, a large covered tray is placed on the dining table. The butler serving removes the cloth and " + coreGame.SlaveSee + " a pair of girls lying on the platter with food laid out over their bodies. There is a small round of applause and the diners carefully eat the food from off the girls.");
				} else {
					AddText("After a while " + coreGame.SlaveHeShe + coreGame.NonPlural(" hear") + " some muffled noise and looks up. A slave is bound near the roof, made to be some sort of odd candelabra. " + coreGame.SlaveIs + " a bit offended by this and quietly retreats from the dining room.");
				}
				AddText("\r\rAs " + coreGame.SlaveName + coreGame.NonPlural(" glance") + " away " + coreGame.SlaveHeShe + coreGame.NonPlural(" see") + " an elegant but somewhat imperious Lady who suggests that maybe #slaveheshe would like something different? There is a seance underway, how about visiting it?");
				AddText("\r\rAs they discuss this #slavesee an elegantly dressed catgirl sitting in a corner. The catgirl shakes her head and makes a beckoning gesture.\r\r");
				HidePerson(4);
				slaveData.BitFlag1.SetBitFlag(40);
				Points(0, 0, 3, 3, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0);
				coreGame.AskHerQuestions(8056, 8060, 2040, 0, "Sure, lets attend", "No thanks, lets talk more here", "Sorry no, and visit catgirl", "", "What is #slave's reply");
				return true;
				
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// buy cat ears/tail
			case 23:
				//Lady Farun gives you the items, but leaves her ears on. As you leave you hear some rather passionate meowing.
				SetLangText("BuyCatEarsTail", "Shopping");
				Money(-800);
				coreGame.CatTailOK = 1;
				coreGame.CatEarsOK = 1;
				ShowPlanningNext();
				return true;
		
			// remove catears
			case 2050:
				coreGame.ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				if (slaveData.BitFlag1.CheckBitFlag(45)) {
					slaveData.BitFlag1.ClearBitFlag(45);
					coreGame.CatEarsWorn = 0;
					coreGame.Catgirl = false;
				} else {
					slaveData.BitFlag1.ClearBitFlag(57);
					coreGame.ItemsWorn.ClearBitFlag(29);
				}
				coreGame.UpdateOtherSlaveDetails();
				coreGame.ShowDress();
				coreGame.ShowLeaveButton();
				SetEvent(9999);
				return true;
				
			// remove cat tail
			case 2051:
				coreGame.ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				coreGame.PlugInserted = 0;
				if (slaveData.BitFlag1.CheckBitFlag(45)) {
					slaveData.BitFlag1.ClearBitFlag(45);
					coreGame.CatTailWorn = 0;
					coreGame.Catgirl = false;
				} else {
					slaveData.BitFlag1.ClearBitFlag(57);
					coreGame.ItemsWorn.ClearBitFlag(30);
				}
				coreGame.ShowDress();
				coreGame.UpdateOtherSlaveDetails();
				coreGame.ShowLeaveButton();
				SetEvent(9999);
				return true;
				
			// remove dress and no other ears/tail
			case 2052:
				coreGame.ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				if (slaveData.BitFlag1.CheckBitFlag(45)) {
					slaveData.BitFlag1.ClearBitFlag(45);
					coreGame.Catgirl = false;
				} else {
					slaveData.BitFlag1.ClearBitFlag(57);
				}
				coreGame.ShowLeaveButton();
				coreGame.TakeDressOff();
				SetEvent(9999);
				return true;
				
			// put on other dress and no other ears/tail
			case 2053:
				coreGame.ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				if (slaveData.BitFlag1.CheckBitFlag(45)) {
					slaveData.BitFlag1.ClearBitFlag(45);
					coreGame.Catgirl = false;
				} else {
					slaveData.BitFlag1.ClearBitFlag(57);
				}
				coreGame.ShowLeaveButton();
				coreGame.PutDressOn(coreGame.ObjectChoice);
				SetEvent(9999);
				return true;
				
			// Tiger Girl lesson
			case 2012:
				var Singer:Person = coreGame.People.GetPersonsObject("Singer");
				Singer.SetBitFlag(33);
				GetPlace("Farm").SetBitFlag(35);
				coreGame.ChangeCatTraining(5);
				Points(0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 2, 0, 2, 1, -2, 0, 3, 0, 0, 0);
				var dg:Boolean = GetPlace("Farm").CheckBitFlag(33);
				if (coreGame.SlaveFemale) {
					if (coreGame.IsDickgirl()) {
						SetText("The Tiger Girl aggressively mounts herself onto #slave's erect cock, passionately fucking herself and making growling and meowing noises.");
						if (dg) AddText(" As she does she strokes her own cock with one hand, the other resting on one of #slave's breasts.");
						else AddText(" As she does she massages her clit with one hand, the other resting on one of #slave's breasts.");
						AddText("\r\r#slave groans in passion and suddenly the Tiger Girl stops moving, she glances at #super and slaps #slave hard on #slavehisher face, and pinches #slavehisher nipple hard. She says, a little breathlessly,\r\r");
						PersonSpeak(58, "No! not ohh, ow or ahhh, it is meow, meeeeeow, or even purrr or growl! You are a catgirl! Meow!", true);
						BlankLine();
						if (dg) AddText("With that she resumes fucking herself on #slave's cock, and stroking her cock quickly and in time with her fucking.");
						else AddText("With that she resumes fucking herself on #slave's cock, and rubbing her clit quickly.");
						AddText(" #slave makes an awkward meow noise and the Tiger Girl fucks faster, leaning down and kissing #slave. She pulls back and moments later #slave yells in passion as #slaveheshe cums powerfully into the Tiger Girl's pussy. The girl stops fucking again but waits for #slave to finish cumming. When #slaveheshe does the Tiger Girl bites #slavehimher on the shoulder and pinches #slavehisher nipples very hard. #slave moans in pain, and the Tiger Girl panting says,\r\r");
						PersonSpeak(58, "No again! It is meow!!!! Mmmmm, you had a good cum, your cream feels nice. Now lick our cream! Meoow!", true);
						AddText("\r\rShe dismounts and straddles #slave's face positioning her pussy over #slave's mouth. #slave's cum drips into #slavehisher mouth and #slaveheshe licks it. ");
						if (dg) AddText("The Tiger Girl quickly strokes her cock as #slave licks, and she growls and meows, and says breathlessly,\r\r");
						else AddText("The Tiger Girl quickly rubs her clit and pinches her nipples as #slave licks, and she growls and meows, and says breathlessly,\r\r");
						PersonSpeak(58, "Meow!!!! now lick my cream! Meeeeeooooow!!!", true);
						if (dg)AddText("\r\rShe moves quickly and thrusts her cock into #slave's mouth and with a loud Meow! cums large spurts of cum into #slave's mouth.");
						else AddText("\r\rShe stiffens and orgasms with a loud Meow! juices squirting from her pussy.");
						AddText("\r\rThe Tiger Girl lies down on top of #slave and licks #slavehisher face, licking the juices from #slavehisher lips.");
						if (dg) {
							AddText("\r\rAfter a little she starts kissing #slave and holding #slavehimher tightly. After a little the Tiger Girl works her legs in-between #slave's, parting them wider and wider. She raises herself a bit and #slave can see the Tiger Girl's cock is erect again and near the entrance of #slave's pussy. The Tiger Girl smiles and makes a soft purring meow as she thrusts her cock into #slave's pussy. #slave moans, and then quickly meows, and the Tiger Girl looks at #slave, her cock fully in #slave's pussy. The Tiger Girl grabs both of #slave's nipples and pinches very hard. She just says 'No! Meow!'\r\rThe Tiger Girl starts to fuck #slave and after a moment moves one hand to #slave's cock stroking it hard and fast. #slave makes passionate noises, mostly meowing sounds as the Tiger Girl fucks and strokes #slavehimher. The Tiger Girl kisses #slave and then licks #slavehisher face as #slave quickly nears climax. Just before #slave cums the Tiger Girl pulls out and moves down and envelops #slave's cock in her mouth. A moment later #slave cums, #slavehisher cum pouring into the Tiger Girl's mouth.\r\rAs #slave recovers from #slavehisher climax the Tiger Girl gives #slavehimher an open mouth kiss, and #slave starts as she tastes her own cum flooding into her mouth. The Tiger Girl breaks the kiss, swallowing some of the cum and then quickly straddles #slave's face and pushes her cock into #slave's mouth. With a loud Meow!!! she cums, spurting her cum into #slave's mouth, mixing with #slave's cums already there. The Tiger Girl cums very powerfully this time, and #slave has to swallow a couple of times to take all of her own cum and the Tiger Girl's.");
							AddText("\r\rAgain, the Tiger Girl lies down on top of #slave and licks #slavehisher face, licking the cum from #slavehisher lips.");
							AddText("The Tiger Girl says,\r\r");
							PersonSpeak(58, "One more lesson, here you take the cream, but some owners will get you to lick it, but not me. Meow!", true);
							AddText("\r\rThe Tiger Girl rolls #slave onto her side and positions herself behind #slave. The Tiger Girl caresses #slave's breasts and fondles her cock. #slave then feels the Tiger Girl probing her ass and then the Tiger Girl raises one of #slave's legs as she slowly pushes her once again erect cock into #slave's ass. #slave involuntarily groans in pain, and then quickly makes a cat growl. The Tiger Girl bites #slave' shoulder and yanks her hair. She just says 'Meow' and starts fucking #slave's ass very hard, paying little attention to #slave's comfort. After a little the Tiger Girl starts stroking #slave's cock but just slowly. The Tiger Girl fucks faster and harder, meowing in passion and then with a loud Meow cums very, very hard, spewing large amounts of cum into #slave's ass. She gasps and meows and then pulls free from #slave's ass and there is a noise as her cums spurts from #slave's ass.\r\rThe Tiger Girl rolls #slave onto her back and licks and sucks her cock, quickly bringing her to the edge of climax. Just as #slave starts cumming the Tiger Girl points #slave's cock at her breasts and #slave cums over the Tiger Girl's breasts. #slave gasps and meows and then collapses back. The Tiger Girl tells her,\r\r");
							PersonSpeak(58, "Lick your cream! Meow!!", true);
							AddText("\r\r#slave moves and starts licking her own cum from the Tiger Girl's breasts, swallowing as she does.");
						}
					} else {
						if (dg) {
							AddText("The Tiger Girl starts aggressively kissing #slave and holding #slavehimher tightly. After a little the Tiger Girl works her legs in-between #slave's, parting them wider and wider. She raises herself a bit and #slave can see the Tiger Girl's cock is erect and near the entrance of #slave's pussy. The Tiger Girl smiles and makes a soft purring meow as she thrusts her cock into #slave's pussy. #slave moans, and then quickly meows, and the Tiger Girl looks at #slave, her cock fully in #slave's pussy. The Tiger Girl grabs both of #slave's nipple and pinches very hard. She says,\r\r");
							PersonSpeak(58, "No! not ohh, ow or ahhh, it is meow, meeeeeow, or even purrr or growl! You are a catgirl! Meow!", true);
							AddText("\r\rThe Tiger Girl starts to fuck #slave and after a moment moves one hand to #slave's clit rubbing it hard and fast. #slave makes passionate noises, and then some meowing sounds as the Tiger Girl fucks #slavehimher. The Tiger Girl continues fucking but pinches #slave's clit hard and painfully and whispers 'No! Meow'. The Tiger Girl kisses #slave and then licks #slavehisher face and the pain is quickly replaced by arousal as #slave quickly nears orgasm. Just before #slave orgasms the Tiger Girl fucks harder and faster and as #slave orgasms with a noise, maybe a meow, the Tiger Girl pulls out and cums over #slave's breasts and stomach.\r\rFor a moment they gasp and meow as they finish cumming. The Tiger Girl smiles and licks her lips and leans down and licks all her cum from #slave's body\r\rThe Tiger Girl then gives #slave an open mouth kiss, and #slave starts as she tastes the Tiger Girl's cum flooding into her mouth. The Tiger Girl breaks the kiss, swallowing some of the cum. The Tiger Girl smiles and says,\r\r");
							PersonSpeak(58, "Cream! Meow!", true);
							AddText("\r\rThe Tiger Girl lies down on top of #slave and licks #slavehisher face, licking the cum from #slavehisher lips.\r\r");
							PersonSpeak(58, "One more lesson, here you take the cream, but some owners will get you to lick it, but not me. Meow!", true);
							AddText("\r\rThe Tiger Girl rolls #slave onto her side and positions herself behind #slave. The Tiger Girl caresses #slave's breasts and lightly rubs her clit. #slave then feels the Tiger Girl probing her ass and then the Tiger Girl raises one of #slave's legs as she slowly pushes her once again erect cock into #slave's ass.\r\r#slave involuntarily groans in pain, and then quickly makes a cat growl. The Tiger Girl bites #slave' shoulder and yanks her hair. She just says 'Meow' and starts fucking #slave's ass very hard, paying little attention to #slave's comfort.\r\rAfter a little the Tiger Girl starts rubbing #slave's clit but just slowly. The Tiger Girl fucks faster and harder, meowing in passion and then with a loud Meow cums very, very hard, spewing large amounts of cum into #slave's ass. She gasps and meows and then pulls free from #slave's ass and there is a noise as her cum spurts from #slave's ass.");
						} else {
							AddText("The Tiger Girl starts aggressively kissing #slave and holding #slavehimher tightly. After a little the Tiger Girl works a leg in-between #slave's, parting them and then moving her hips so their pussies and clits are rubbing against each other. She pauses and caresses #slave's breasts and leans so her breasts rub against #slave's, their nipples touching and rubbing against each other. #slave moans, and then quickly meows, and the Tiger Girl looks at #slave. The Tiger Girl grabs both of #slave's nipples and pinches very hard. She says,\r\r");
							PersonSpeak(58, "No! not ohh, ow or ahhh, it is meow, meeeeeow, or even purrr or growl! You are a catgirl! Meow!", true);
							AddText("\r\rThe Tiger Girl starts to move her hips and rubs her pussy against #slave's in a fucking like motion. #slave makes passionate noises, and then some meowing sounds as the Tiger Girl fucks #slavehimher. The Tiger Girl continues moving her hips but pinches #slave's clit hard and painfully and whispers 'No! Meow'. The Tiger Girl kisses #slave and then licks #slavehisher face and the pain is quickly replaced by arousal as #slave quickly nears orgasm. Just before #slave orgasms the Tiger Girl pushes #slave down and moves so they are both in a 69 position, she says,\r\r");
							PersonSpeak(58, "Lick my cream! Meow!", true);
							AddText("\r\rThe Tiger Girl licks hard at #slave's pussy and clit and #slave does the same. A little later #slave orgasms and she feels the Tiger Girl still licking at her pussy and all the juices. When #slave recovers the Tiger Girl's pussy is still above her face and she feels the Tiger Girl slowly licking her pussy and #slave resumes licking the Tiger Girl. Almost immediately the Tiger Girl orgasms, juices spurting from her pussy and #slave licks it all up.\r\rThe Tiger Girl moves and lies down on top of #slave and licks #slavehisher face, licking the juices from #slavehisher lips.\r\r");
							PersonSpeak(58, "One more lesson. Meow!", true);
							AddText("\r\rThe Tiger Girl reaches into the straw and takes out a strap-on and puts it on. She rolls #slave onto her side and positions herself behind #slave. The Tiger Girl caresses #slave's breasts and lightly rubs her clit. #slave then feels the Tiger Girl probing her ass and then the Tiger Girl raises one of #slave's legs as she slowly pushes the strap-on into #slave's ass. #slave involuntarily groans in pain, and then quickly makes a cat growl. The Tiger Girl bites #slave's shoulder and yanks her hair. She just says 'Meow' and starts fucking #slave's ass very hard, paying little attention to #slave's comfort. After a little the Tiger Girl starts rubbing #slave's clit but just slowly. The Tiger Girl fucks faster and harder, meowing in passion and then with a loud Meow orgasms. She gasps and meows and then pulls the strap-on free from #slave's ass.");
						}
					}
				} else {
					SetText("The Tiger Girl aggressively mounts herself onto #slave's erect cock, passionately fucking herself and making growling and meowing noises.");
					if (dg) AddText(" As she does she strokes her own cock with one hand, the other resting on #slave's shoulder.");
					else AddText(" As she does massages her clit with one hand, the other resting on #slave's shoulder.");
					AddText("\r\r#slave groans in passion and suddenly the Tiger Girl stops moving, she glances at #super and slaps #slave hard on #slavehisher face, and she says, a little breathlessly,\r\r");
					PersonSpeak(58, "No! not ohh, ow or ahhh, it is meow, meeeeeow, or even purrr or growl! You are a cat! Meow!", true);
					BlankLine();
					if (dg) AddText("With that she resumes fucking herself on #slave's cock, and stroking her cock quickly and in time with her fucking.");
					else AddText("With that she resumes fucking herself on #slave's cock, and rubbing her clit quickly.");
					AddText(" #slave makes an awkward meow noise and the Tiger Girl fucks faster, leaning down and kissing #slave. She pulls back and moments later #slave yells in passion as #slaveheshe cums powerfully into the Tiger Girl's pussy. The girl stops fucking again but waits for #slave to finish cumming. When #slaveheshe does the Tiger Girl bites #slavehimher on the shoulder and pinches #slavehisher nipples very hard. #slave moans in pain, and the Tiger Girl panting says,\r\r");
					PersonSpeak(58, "No again! It is meow!!!! Mmmmm, you had a good cum, your cream feels nice. Now lick our cream! Meoow!", true);
					AddText("\r\rShe dismounts and straddles #slave's face positioning her pussy over #slave's mouth. #slave's cum drips into #slavehisher mouth and #slaveheshe licks it. ");
					if (dg) AddText("The Tiger Girl quickly strokes her cock as #slave licks, and she growls and meows, and says breathlessly,\r\r");
					else AddText("The Tiger Girl quickly rubs her clit and pinches her nipples as #slave licks, and she growls and meows, and says breathlessly,\r\r");
					PersonSpeak(58, "Meow!!!! now lick my cream! Meeeeeooooow!!!", true);
					if (dg)AddText("\r\rShe moves quickly and thrusts her cock into #slave's mouth and with a loud Meow! cums large spurts of cum into #slave's mouth.");
					else AddText("\r\rShe stiffens and orgasms with a loud Meow! juices squirting from her pussy.");
					AddText("\r\rThe Tiger Girl lies down on top of #slave and licks #slavehisher face, licking the juices from #slavehisher lips.");
				}
				AddText("\r\rThe Tiger Girl looks at #super and says,\r\r");
				PersonSpeak(58, "I think you can continue this training now and I have had my prey!\r\rI love teaching cat slaves. Meow!", true);
				return true;
				
			// catgirl milk
			case 2013:
				ShowPerson(59, 0, 13);
				if (coreGame.MilkInfluence > 0) {
					coreGame.ChangeBustSize(1.1);
					coreGame.ChangeClitCockSize(1.2);
					Points(0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 10, 5, 0, 0);
					SetText("#slave takes a sip of the potion and collapses onto the sand, her breasts growing larger and larger. Her swimsuit tears and the busty cat slave removes it. #slave's pussy is very, very wet ");
					if (coreGame.HasCock) AddText("and her cock immediately stiffens and becomes erect.");
					else AddText("and her clit is stiff and larger than #super can remember.");
					AddText("\r\r#slave makes a moaning, meowing noise and her nipples become large and stiff and then milk starts pulsing and squirting out. The busty cat slave exclaims,\r\r");
					PersonSpeak(59, "Wow, Wow! Milk, cats love milk!\r\rOhh sorry, this is one reaction to the potion, a lot more severe than usual, maybe I let her drink too much. I think she will stay like this as long as her breasts are swollen like this. Help me we need to empty her breasts, Meow!", true);
					AddText("\r\rThe cat slave eagerly starts sucking on one of #slave's breasts. After a moment #super can see she is drinking mouthfuls of #slave's breast milk. She swallows many mouthfuls and then looks up at #super, milk dribbling from her mouth, a joyful look on her face. ");
					if (coreGame.Supervise) AddText("You no longer hesitate and join her and start sucking on #slave's other breast.");
					else AddText("#super no longer hesitates and joins her and starts sucking on #slave's other breast.");
					BlankLine();
					if (coreGame.HasCock) AddText("Immediately #slave intensely cums, her cock spurting and spurting large globs of cum over herself.");
					else AddText("Immediately #slave orgasms , her pussy squirting juices over the sand.");
					AddText(" The busty cat slave and #super suck and drink #slave's milk for what seems a long time. The milk pours from #slave's breasts and it is hard to drink it all. #slave climaxes over and over, but her milk only slightly lessens in volume. The busty cat slave seems to enjoy this process enormously, masturbating herself and orgasming often.\r\rAfter while #super and the busty cat slave give up drinking and roll #slave over and start milking #slave by hand, the milk spraying over the sand. The busty cat girl then positions herself so the milk sprays over her, soaking her hair and body in the milk. #slave's screams and intensely climaxes and the milk slows and then stops flowing and she lies there, tired and only semi-conscious. Her breasts have shrunk a bit but still seem larger than before.\r\rThe busty cat slave stands there, covered in milk and tells #super,\r\r");
					PersonSpeak(59, "Thank you! So, so wonderful, and so very delicious Meow!", true);
					AddText("\r\rShe licks some dribbles of milk from #slave and then kisses her. She then smiles and leaves #super and #slave, heading to wash and swim in the sea.\r\rAs #super and #slave redress, #super cannot help but notice that #slave's ");
					if (coreGame.HasCock) AddText("cock is also somewhat larger.");
					else AddText("clit is also a larger.");
				} else {
					coreGame.ChangeBustSize(1.05);
					coreGame.ChangeClitCockSize(1.1);
					Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 7, 3, 0, 0);
					SetText("#slave takes a sip of the potion and moans and meows in arousal as her breasts visibly swell. She lies down and removes the top of her swimsuit as it is getting tight, and then the rest. Her pussy is very wet ");
					if (coreGame.HasCock) AddText("and her cock immediately stiffens and becomes erect.");
					else AddText("and her clit is stiff and larger than #super can remember.");
					AddText("\r\rShe makes a moaning, meowing noise and her nipples become large and stiff and then start dribbling what looks like milk. The busty cat slave exclaims,\r\r");
					PersonSpeak(59, "Wow, milk, cats love milk!\r\rOhh sorry, this is one reaction to the potion, a little more severe than usual, maybe I let her drink too much. She will stay like this as long as her breasts are swollen like this. Help me we need to empty her breasts, Meow!", true);
					AddText("\r\rThe cat slave eagerly starts licking and sucking on one of #slave's breasts. After a moment #super can see she is sucking and drinking #slave's breast milk. She swallows many mouthfuls and then looks up at #super, milk dribbling from her mouth, a joyful look on her face. ");
					if (coreGame.Supervise) AddText("You no longer hesitate and join her and start sucking on #slave's other breast.");
					else AddText("#super no longer hesitates and joins her and starts sucking on #slave's other breast.");
					BlankLine();
					if (coreGame.HasCock) AddText("Immediately #slave cums, her cock spurting globs of cum over her stomach.");
					else AddText("Immediately #slave orgasms , her pussy squirting juices over the sand.");
					AddText(" The busty cat slave and #super suck and drink #slave's milk for what seems a long time. #slave climaxes over and over, but her milk only slightly lessens in volume. The busty cat slave seems to enjoy this process enormously, masturbating herself and orgasming often.\r\rAfter a final, very strong climax, #slave's milk slows and then stops flowing and she lies there tired and only semi-conscious. Her breasts have shrunk a bit but still seem larger than before.\r\rThe busty cat slave licks her lips and tells #super,\r\r");
					PersonSpeak(59, "Wonderful , delicious Meow!", true);
					AddText("\r\rShe licks some dribbles of milk from #slave and then smiles and leaves #super and #slave to go for a swim.\r\rAs #super and #slave redress, #super cannot help but notice that #slave's ");
					if (coreGame.HasCock) AddText("cock is also a bit larger.");
					else AddText("clit is also a bit larger.");
				}
				coreGame.ChangeCatTraining(1);
				ShowMovie(this.mcBase.EventWalkBeach2, 1, 3, -1);
				return true;
	
			// High Class party drink
			case 2040:
				coreGame.ChangeCatTraining(2);
				ShowPerson(67, 1, 0, 2);
				Points(0, 0, 1, 0, -1, 1, 0, 0, 1, 5, 0, 0, 3, 2, 3, 1, 3, 0, 0, 0);
				SetText("The Lady Cat takes #slave to a discrete room and she removes all of her clothing, she looks at #slave, who does the same. A servant collects the clothing and they sit on some chairs. The Lady rings a bell and several male servants enter the room. #slave cannot see any carrying drinks trays, and asks,\r\r");
				PersonSpeak("Lady Cat", "They are the drinks, after all cats love to drink 'cream' Meow!", true);
				AddText("\r\rA servant undoes his trousers and places his cock to the ladies lips. Another placing a cock in one of her hands. She licks and strokes the cocks vigorously until the one in her mouth cums and she eagerly and excitedly drinks it all. She looks at #slave,\r\r");
				PersonSpeak("Lady Cat", "Marvelous vintage, drink! Meow!", true);
				AddText("\r\rA servant places his cock at #slaveA's lips....\r\rLater the Lady has drunk from dozens of cocks, a little spilling sometimes, cum covering her face and breasts, but she looks very, very happy. #slave sucked cock after cock, drinking but nowhere near as much as the Lady did.");
				coreGame.modulesList.Parties.HighClassParty(8078);
				return true;
				
			// drunk catgirl
			case 2060:
				GetPerson("Natsu").SetBitFlag(34);
				Points(0, 0, -2, 0, 0, 1, 0, 0, 0, 1, 1, -1, 2, 0, -2, 0, 5, 8, 0, 0);
				coreGame.ChangeDancing(0.2);
				GetPerson("Natsu").SetBitFlag(42);
				AddText("#slaveis immediately filled with happiness and a complete lack of interest in hunting or anything really. #slave and the catgirl dance and have fun while Natsu leaves to continue the hunt.\r\rEventually Natsu returns and takes #slave back to the militia building. #slave cannot remember too much of the time but can dimly remember happily offering herself to anyone that passed, and many took her offer.");
				AddText("\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try and hunt again.");
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// buy catgirl items
			case 23:
				//You refuse, Lady Farun smiles, but notes that she doubts she will have any spare sets for a while, maybe your next slave?
				SetLangText("RefuseBuyCatEarsTail", "Shopping");
				return true;
				
			// Tiger girl training no
			case 2012:
				if (coreGame.Supervise) SetText("You tell the Tiger Girl no, not now.");
				else SetText("#assistant tells the Tiger Girl no!");
				AddText("\r\rThe girl looks very frustrated and growls, and pounces into the long stalks of grains. In the distance #super can hear,\r\r");
				PersonSpeak(58, "That one is my prey! Bring #slavehimher back and I will teach #slavehimher, over and over!", true);
				return true;
				
			// breast potion no
			case 2013:
				if (coreGame.Supervise) SetText("The cat slave holds out the potion and you refuse the offer.");
				else SetText("The cat slave holds out the potion and #assistant refuses the offer.");
				AddText(" The cat slave smile and sips a small amount of the potion. She sighs and her nipples become intensely erect and she says goodbye to #slave.\r\rAs #slave and #super leave they see the cat slave removing her bikini bottom and touches her pussy and she stiffens in and intense orgasm and she collapses and falls asleep with a smile.");
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0);
				if (coreGame.Supervise) SMData.SMPoints(0, 0, 0, 0, 0, 2, 0, 0, 0);
				return true;
				
			// High Class party drink
			case 2040:
				Points(0, 1, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
				SetText("#slaveis unsure and politely refuses. The Lady stand and says 'more for me' and leaves.");
				coreGame.modulesList.Parties.HighClassParty(8078);
				return true;
				
			case 2060:
				GetPerson("Natsu").SetBitFlag(34);
				Points(0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 2, 0, 3, 1, 0, 0);
				GetPerson("Natsu").SetBitFlag(42);
				AddText("The catgirl laughs and drinks the liquid and dances off into the night. Later as they are passing near the same area Natsu and #slave see the catgirl again, hands against the wall as she is being fucked by a cloaked man. The catgirl and meowing is passion and the man pulls his cock free and cums over her back. Natsu leads them away, but comments,\r\r");
				PersonSpeak(61, "You know that looked quite a bit like my commanding officer. He is also hunting for the cat burglar. Maybe he caught himself some pussy...", true);
				AddText("\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try and hunt again.");
				return true;
		}
		return false;
	}
	
	
	// Walks
	
	
	// BeachPrivate
	//  32  = first catgirl meeting
	//  36  = second catgirl meeting
	public function DoWalkBeachPrivateAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
		
		if (slaveData.IsCatgirl() && IsDayTime() && (coreGame.BeachPrivate.CheckBitFlag(32) == false || coreGame.BeachPrivate.CheckBitFlag(36) == false) && (eventno == 2 || eventno == 4)) {
			coreGame.ChangeCatTraining(2);
			if (!coreGame.BeachPrivate.CheckBitFlag(32)) {
				coreGame.BeachPrivate.SetBitFlag(32)
				temp = coreGame.IsDickgirlEvent() ? 15 : 3;
			} else if (!coreGame.BeachPrivate.CheckBitFlag(36)) {
				coreGame.BeachPrivate.SetBitFlag(36)
				temp = coreGame.IsDickgirlEvent() ? 16 : 4;
			} else temp = coreGame.IsDickgirlEvent() ? 14 + slrandom(2) : 2 + slrandom(2);
			switch(temp) {
				case 3:
					ShowMovie(this.mcBase.EventWalk, 1, 13, temp);
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 3, 0, -1, 0, 0, 0);
					SetText("In a fairly open area #super and #slave see a catgirl very enthusiastically giving a man a handjob, quickly stroking his cock, occasionally licking the tip of his cock. Her mouth is poised expectantly, ready for his 'cream', and her tail is waving around in a very cat-like fashion.\r\rWith a groan the man cums and the catgirl takes it in her mouth and licking up all the cum. She looks very happy and loves all the cum, meowing and waving her ass and tail energetically.\r\rAfter she smiles at #slave and then licks her lips as she bends down and resumes licking the man's cock, clearly after more 'cream'."); 
					break;
				case 4:
					ShowMovie(this.mcBase.EventWalk, 1, 13, temp);
					Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 2, 0, 3, 0, 0, 1, 0, 0);
					SetText("#super and #slave see a small building and have a look is a window. Inside there is a group of men standing watching an man fuck a catgirl. She is meowing in passion as the man is fucking her quickly. He shouts and stiffens, cumming into the catgirl.\r\rHe pulls free and one of the other men almost pushes him to the side and he thrusts his cock into the catgirl. She hugs him, looking happy and meows as he starts fucking her.\r\rOne of the other men notices #slave and steps to the window. He makes a 'silence' gesture and closes the curtain.");
					break;
				case 15:
					ShowMovie(this.mcBase.EventWalk, 1, 0, temp);
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 3, 0, -1, 0, 0, 0);
					SetText("In a fairly open area #super and #slave see a catgirl very enthusiastically giving a woman a handjob, they are both hermaphrodites. The catgirls cock is very erect with a dribble of her excitement glistening at it's tip. The catgirl is quickly stroking the woman's cock, occasionally licking the tip of her cock. The catgirl's mouth is poised expectantly, ready for her 'cream', and her tail is waving around in a very cat-like fashion.\r\rWith a groan the woman cums and the catgirl takes the powerful spurts of cum in her mouth and licking up all the cum. She looks very happy and loves all the cum, meowing and waving her ass and tail energetically.\r\rAfter she smiles at #slave and then bends and strokes her cock and very quickly meows and cums, her cum spurting and she bends so most of it goes into her own mouth.\r\rShe licks her lips and moves over and resumes licking the woman's cock, clearly after more 'cream'."); 
					break;
				case 16:
					ShowMovie(this.mcBase.EventWalk, 1, 1, temp);
					SetText("A catgirl approaches #slave, looking very distracted. She is wearing a very thin, wet shirt, and only the shirt. She has an erect cock, the shirt clinging to it. She asks #slave,\r\r");
					PersonSpeak("Catgirl", "I have lost my swimsuit....I was using some lotion, I think and I forget what happened....meow...", true);
					AddText("\r\rNeither #super or #slave thinks the girl is quite telling the truth, but she seems embarrassed and aroused. She continues,\r\r");
					PersonSpeak("Catgirl", "I think I know where it is, over there in that small building....Would you get it for me, I should hide to not get thrown out of the beach....I also left some tanning lotion can you get some...it as well...please, I really want it...meow...", true);
					AddText("\r\rNo one is convinced by the catgirl's words.\r");
					coreGame.AskHerQuestions(2020, 2021, 2022, 0, "Get the swimsuit and lotion", "Refuse and escort the catgirl", "Ask about the swimsuit and lotion", "","What will #slave do?");
					break;
			}
			return true;
		}
		return false;
	}
	
	public function DoWalkBeachSwimAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
	
		if (slaveData.IsCatgirl() && IsDayTime() && eventno == 6) {
			coreGame.ChangeCatTraining(2);
			ShowMovie(this.mcBase.EventWalk, 1, 1, 5);
			Points(0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 2, 1, 0, 0);
			SetText("#slave and #super swim out a long way and see a rather buxom cat slave floating nearby. She waves to #slave and they swim back to shore together.\r\rWhen they reach the shore the cat slave comments,\r\r");
			PersonSpeak(60, "I know cats are not supposed to like water, but I do!\r\rI do not think that is something we really need to copy.\r\rHave you felt how great the beach makes you feel, I feel like I am in heat. Meow!", true);
			AddText("\r\rThe cat slave swims out a short distance and she floats there in her floatation ring. #slavesee the slave move a hand and clearly starts masturbating. She smiles and rubs herself quickly under the water and after a little while she cries out 'Meow' and orgasms. With a smile she waves and floats along the beach.");
			return true;
		}
		return false;
	}
	
	// BeachWalk
	//	33	= catgirl
	public function DoWalkBeachWalkAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
	
		if (slaveData.IsCatgirl() && IsDayTime() && coreGame.BeachWalk.CheckBitFlag(33) == false) {
			coreGame.BeachWalk.SetBitFlag(33);
			Backgrounds.ShowBeach(3);
			coreGame.ChangeCatTraining(3);
			ShowPerson(59, 1, 0);
			Points(3, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 2, 0, -3, 1, 0, 0);
			SetText("#slave and #super meet a cat slave relaxing on the beach. She is wearing a bikini that just restrains her large breasts. The slave invites #slave to join her and they talk for a while. The cat slave notices #slave glancing at her breasts and she laughs,\r\r");
			PersonSpeak(59, "Mmmm my owner likes my breasts too. I do my best to emphasise them and wear clothing cut the right way and I pose myself to maximise them. Me-ow!", true);
			AddText("\r\rThey talk for a while about how to make your breasts appear larger and to attract the eye to them.");
			if (coreGame.SlaveFemale) {
				AddText("\r\rThe cat slave takes out a bottle of milky liquid. She offers some to #slave,\r\r");
				PersonSpeak(59, "I have this potion my owner imports from a distant country. It slightly improves your breasts but it is also a mild aphrodisiac. Be warned that many people can have odd reactions to it, but they are only temporary, well mostly. Meow!", true);
				AddText("\r\rWill #slave take the potion?\r");
				DoYesNoEventXY(2013);
			}
			return true;
		}
		
		if (slaveData.IsCatgirl() && IsDayTime() && GetPerson("Natsu").CheckBitFlag(52) == false && PercentChance(50)) {
			// Natsu Beach
			SetText("#slave meets the catgirl Natsu relaxing on the beach with another girl. Natsu introduces the girl to #slave as her good friend Miyu and as a fellow member of the Militia. They all talk for a while and #slave can see Natsu and Miyu are very close, almost intimate. They could even be lovers, they seem that close.");
			ShowPerson(61, 1, 3, 3);
			coreGame.ChangeCatTraining(1);
			GetPerson("Natsu").SetBitFlag(52);
			return true;
		}
		return false;
	}
	
	
	// Farm
	//  32  = butterfly catgirl
	//  33  = tiger catgirl (dickgirl)
	//  34  = tiger catgirl (normal)
	//  35  = accept tiger catgirl training
	public function DoWalkFarmAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
	
		if (!slaveData.IsCatgirl()) return false;
		if (slaveData.slCatTraining >= 30 && GetPlace("Farm").CheckBitFlag(35) == false && IsCatgirlEvent()) eventno = 1;
		if (slaveData.slCatTraining >= 30 && int(eventno) == 1) {
			if (!GetPlace("Farm").CheckBitFlag(32)) {
				GetPlace("Farm").SetBitFlag(32);
				ShowMovie(this.mcBase.EventWalk, 1, 1, 7);
				coreGame.DifficultyExhib -= 3;
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
				SetText("#slaveis taking a walk though some fields and can see a cat slave nearby and she seems to be hunting? She is quite naked and appears to be chasing butterflies, pouncing and swatting at them. She never quite catches one, every so often making cute meowing noises.\r\rShe notices #slave, stands and walks over and introduces herself. She does not seem to notice or care she is naked.\r\rShe pleasantly talks to #slave and she notices that #slaveis wearing cat ears. #slaveA asks about what the girl is doing out here. The girl explains,\r\r");
				PersonSpeak(60, "I am training myself to be a cat. To be a catgirl you must act like a cat, play like a cat, be a cat. But remember you are also a girl. Meow!", true);
				AddText("\r\rShe briefly cups her breasts and continues,\r\r");
				PersonSpeak(60, "A cat does not wear clothing, just a collar. Purrr!", true);
				AddText("\r\rWith that she pounces on something in the field and runs off.");
				coreGame.ChangeCatTraining(3);
				return true;
			} else if (slaveData.slCatTraining >= 30 && GetPlace("Farm").CheckBitFlag(35) == false) {
				var dg:Boolean = GetPlace("Farm").CheckBitFlag(33);
				coreGame.ShowDressSmall();
				if ((!GetPlace("Farm").CheckBitFlag(33)) && (!GetPlace("Farm").CheckBitFlag(34))) {
					if (coreGame.IsDickgirlEvent()) GetPlace("Farm").SetBitFlag(33);
					else GetPlace("Farm").SetBitFlag(34);
					dg = GetPlace("Farm").CheckBitFlag(33);
					SetText("#slavemeet a catgirl in a field of very tall grain. She completely naked and has tiger-stripes all over her body. ");
					if (dg) AddText("#slaveis also a bit surprised to see the girl is a hermaphrodite and the stripes are also on her cock!");
					AddText("\r\rThe girl leaps and hugs #slave and slowly licks #slavehisher neck. She looks at #super and says\r\r");
					PersonSpeak(58, "I love to hunt here, and look what I have caught, a cat slave in training. Meeeeeow", true);
					if (coreGame.Supervise) AddText("\r\rYou ask");
					else AddText("\r\r#assistant asks");
					AddText(" her to let go of #slave and why she calls #slavehimher a cat slave in training. The Tiger Girl holds #slave closer, ");
					if (dg) AddText("her now erect cock poking between");
					else AddText("her hips and pussy rubbing against");
					AddText(" #slave's legs. She licks #slave's neck, and answers,\r\r");
					PersonSpeak(58, "I am very expert in the ways of cat slaves. I bet #slavehisher training is stalled, unable to become more catgirl-like. Meow!", true);
					AddText("\r\r" + coreGame.NameCase(coreGame.SupervisorName) + " can only agree that that is the case. The girl smiles and with considerable strength wrestles #slave onto a large bed of straw ");
					if (!coreGame.Naked) AddText("and with amazing speed strips #slave naked");
					AddText(". She kisses #slave passionately, making soft meowing noises, ");
					if (dg) AddText("rubbing her cock on #slave's belly");
					else AddText("rubbing her pussy on #slave's leg");
					AddText(". Just as #super reach for her, the Tiger Girl says,\r\r");
					PersonSpeak(58, "This one is not enough of a sex kitten, while #slave may know sex, #slaveheshe does not know sex as a catgirl. Let me teach #slavehimher! Meow!", true);
					AddText("\r\rShe forcefully and passionately kisses #slave, but keeps an eye on #super.");
				} else {
					SetText("Once again #slavemeet the tiger catgirl in the field of very tall grain. She still completely naked she instantly launches herself onto #slave wrestling #slave to the ground");
					if (!coreGame.Naked) AddText("and forcefully and quickly stripping #slavehimher naked");
					AddText("\r\rThe Tiger Girl holds #slave down and kisses #slave passionately, and then licks over #slavehisher body, looking at #super\r\r");
					PersonSpeak(58, "Please let me teach this slave sex as a cat girl, I very, very much want #slavehimher, Meow! to learn from me! Meow!", true);
	
				}
				if (coreGame.TestObedience(coreGame.DifficultyThreesome)) { 
					AddText("\r\rWill #super allow the Tiger Girl to teach #slave?\r");
					DoYesNoEventXY(2012);
				} else AddText("\r\r#slave pushes the Tiger Girl and she lets #slave go and #super can clearly see #slaveis not ready for this. #slave will need to be better used to sex with several people present.");
				ShowPerson(58, 1, 1);
				coreGame.SetLastMovieNight();
				Backgrounds.ShowFarm(IsDayTime() ? 1 : 6);
				coreGame.ChangeCatTraining(1);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0);
				return true;
			}
		}
		return false;
	}
	
	
	// Forest
	//  34  = pond catgirl
	public function DoWalkForestAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
	
		if (slaveData.IsCatgirl() && GetPlace("Forest").CheckBitFlag(34) && PercentChance(33)) {
			coreGame.ChangeCatTraining(2);
			coreGame.Forest.SetBitFlag(34);
			ShowMovie(this.mcBase.EventWalk, 1, 0, 7);
			Points(0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			AddText("#slavesee a cat slave next to a small pond in the heart of the forest and calls out to her. The girl seems startled and stumbles, falling into the pond. For some reason her fall seemed almost deliberate.\r\rThe girl climbs out and while she fixes her clothes they talk for a time.\r\r");
			if (slaveData.VarConversationRounded < 50) AddText(coreGame.SlaveIs + " not quite sure how to ask about the girls fall, except asking if she is alright.");
			else {
				coreGame.ChangeCatTraining(2);
				AddText(coreGame.SlaveVerb("ask") + " the girl about her fall and if it was really an accident. She blushes a little and explains,\r\r");
				PersonSpeak(60, "I was training in how to be clumsy. While a good catgirl is graceful and surefooted, people still find it cute if we fall over and say 'Oww' or get a bit dirty. They can come to our 'rescue' and comfort us, something we both like! Meow!", true);
			}
			BlankLine();
			AddText("They talk pleasantly and part, the girl waving goodbye with a cute 'Meow!'");
			return true;
		}
		return false;
	}
	
	public function DoWalkPalaceAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
	
		if (slaveData.IsCatgirl() && GetPerson("Natsu").CheckBitFlag(32) == false) {
			slaveData.ChangeCatTraining(4);
			HideBackgrounds();
			ShowPerson(61, 1, 3, 1);
			coreGame.ShowDressSmall();
			GetPerson("Natsu").SetMet();
			GetPerson("Natsu").SetBitFlag(32);
			Points(0, 1, 1, 1, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0);
			AddText(coreGame.SlaveMeet + " the catgirl Natsu walking in the Palace. She invites #slave to sit for a while and talk. Natsu is still wearing little more than a swimsuit, but she explains she is still on duty for the militia,\r\r");
			PersonSpeak(61, "People assume catgirls are cute little pets. We can have claws, Meow!", true);
			AddText("\r\rShe talks about doing her almost <i>undercover</i> duty while people think her harmless, and cute. She blushes a little and hesitates over the word 'undercover', and she mentions how many nobles very much like ummm sex kittens, and how she has to play along.");
			if (!GetPerson("Natsu").CheckBitFlag(33)) {
				AddText("\r\rShe talks about how at night she is hunting an actual cat burglar, a catgirl who robs peoples homes. Natsu asks #slave if #slaveheshe would like to accompany her on the hunt tonight?\r\rIf so Natsu says she will meet #slave in the Town Center tonight at 10pm. Natsu talks a little more about the hunt, but she is a little vague about some details.\r\rThey part, with Natsu reminding #slave '10pm Meow!'");
				GetPerson("Natsu").SetBitFlag(33);
			}
			return true;
		}
		return false;
	}
	
	
	// Town Center
	//	32	= catgirl
	//  33  = catburglar caught
	public function DoWalkTownCenterAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (this.CatgirlEvents == false || !coreGame.bAllowEvents) return false;
	
		if ((GetPerson("Natsu").CheckBitFlag(33) || GetPerson("Natsu").CheckBitFlag(34)) && IsDayTime() == false && coreGame.GameTimeMins == 1320) {
			Backgrounds.ShowTownCenter();
			ShowPerson(61, 0, 3, 1);
			slaveData.ChangeCatTraining(1);
			SetText("As #slave enters the Town Center, #slaveheshe is immediately met by the militia catgirl Natsu. Natsu looks happy and explains,\r\r");
			PersonSpeak(61, "We will stalk through the area, alert for strange occurrences. I also have some informers and other helpers who will give clues.\r\rI am sorry #supername I will have to ask you to wait for us in the Militia headquarters nearby. I need to keep the group as small as possible so it is best we cats prowl the night.", true);
			AddText("\r\rThey leave #super and walk pleasantly for a while ");
			GetPerson("Natsu").ClearBitFlag(33);
			GetPerson("Natsu").ClearBitFlag(34);
			temp = 0;
			var nDone = 0;
			for (var i:Number = 35; i < 44; i++) {
				if (!GetPerson("Natsu").CheckBitFlag(i)) temp++;
				else nDone++;
			}
			var evt:Number = 0;
			if (nDone > 3) evt = 49;
			else {
				if (GetPerson("Natsu").CheckBitFlag(38) && (!GetPerson("Natsu").CheckBitFlag(39) || !GetPerson("Natsu").CheckBitFlag(40))) {
					evt = !GetPerson("Natsu").CheckBitFlag(39) ? 39 : 40;
				} else {
					temp = slrandom(temp) - 1;
					for (var i:Number = 35; i < 44; i++) {
						if (!GetPerson("Natsu").CheckBitFlag(i)) {
							if (temp <= 0) {
								evt = i;
								break;
							}
							temp--;
						}
					}
				}
			}
			if (evt == 0 || PercentChance(30)) {
				AddText("but by the end of the time they find nothing.\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try again.");
				GetPerson("Natsu").SetBitFlag(34);
				Points(0, 0, 0, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 3, 0, 0, 0);
				return true;
			}
			switch(evt) {
				case 35:
					coreGame.ShowDressSmall();
					coreGame.ChangeCatTraining(2);
					ShowMovie(this.mcBase.EventWalk, 1, 1, 11);
					AddText("and meet a naked catgirl, stalking and running through the Town Center. She runs on all fours, on two feet but always looks very catlike and the only thing she says is 'Meow!'.\r\rNatsu comments that she admires the other girl's attitude and training.\r\rThe rest of the time passes and they find nothing.");
					GetPerson("Natsu").SetBitFlag(34);
					Points(0, 0, 0, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 3, 0, 0, 0);
					break;
				case 36:
					coreGame.ShowDressSmall();
					slaveData.ChangeCatTraining(2);
					ShowMovie(this.mcBase.EventWalk, 1, 1, 12);
					AddText("and meet a catgirl waiting in front of a shop, dressed rather elegantly. Natsu asks what she is doing, and the girl explains,\r\r");
					PersonSpeak("Catgirl", "My owner is closing the shop. I am waiting for him and then we will be going on a date! Meow!", true);
					AddText("\r\rThe girl is very happy and anxious for her owner. A moment later a man steps out of the shop and the catgirl hugs him. Natsu and #slave leave them alone.\r\rThe rest of the time passes and they find nothing.");
					GetPerson("Natsu").SetBitFlag(34);
					Points(0, 1, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 3, 0, 0, 0);
					break;
				case 37:
					AddText("and a young boy runs up to Natsu and says he has found her! Natsu runs after him, quickly followed by #slave. They arrive at an apartment, but they are refused access. A person inside tells them with some embarrassment in their voice,\r\r");
					PersonSpeak("Person", "They have gone, she took some money and did <b>nothing</b> else at <b>all</b>", true);
					AddText("\r\rNatsu insists on going in but the person is adamant, completely refusing and eventually they have to leave.\r\rNatsu is frustrated and says that is all for tonight!");
					GetPerson("Natsu").SetBitFlag(34);
					Backgrounds.ShowHouseOutside(8);
					GetPerson("Natsu").SetBitFlag(evt);
					Points(0, 1, 0, 1, 0, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0);
					return true;
				case 38:
				case 39:
				case 40:
					coreGame.ShowDressSmall();
					slaveData.ChangeCatTraining(3);
					if (!GetPerson("Natsu").CheckBitFlag(38)) {
						ShowMovie(this.mcBase.EventWalk, 1, 1, 17);
						GetPerson("Natsu").SetBitFlag(38);
						AddText("and they see a dark haired catgirl sitting next to a small fountain. She is playing with a small cat, but Natsu points out that the catgirl is also studying the cat, learning how to be more cat like.");
					} else if (!GetPerson("Natsu").CheckBitFlag(39)) {
						ShowMovie(this.mcBase.EventWalk, 1, 13, 21);
						Backgrounds.ShowOverlay(0);
						GetPerson("Natsu").SetBitFlag(39);
						AddText("and again they see the dark haired catgirl, this time lying down in the shallow fountain. She is again playing with a small cat, but is relaxing, not studying the cat as intensely as last time. She looks at #slave and smiles,\r\r");
						PersonSpeak(66, "Not everything is about training, relax and have fun. Meow", true);
						AddText("\r\rThe catgirl seems to almost read their minds. The girl smiles again, showing rather catlike, pointy teeth,\r\r");
						PersonSpeak(66, "and not only humans like cats. Meow!", true);
						AddText("\r\rThere is a rush of wings and the catgirl and her cat disappears.");
					} else {
						ShowMovie(this.mcBase.EventWalk, 1, 3, 22);
						GetPerson("Natsu").SetBitFlag(40);
						AddText("and again they see the dark haired catgirl, sitting inside a window of a small shop, eating some cherries. Natsu and #slave look at her curiously and she smiles again, her lips very red and a hint of sharp teeth,\r\r");
						PersonSpeak(66, "You want to know about me? No, everyone has their secrets, especially if people think the wrong things about <i>what</i> they are.\r\rPeople call many friendly beings <b>monsters</b> when really they are just different. Some beings have different appetites but that does not make them murderers.\r\rLet us talk of something different, how about catgirls? I love cats and love being one. My friends all think I should actually prefer being a puppy girl, or more accurately a wolf-girl, but cats are more interesting. Fellow creatures of the night and so, so cute. Meow", true);
						AddText("\r\rThe girl smiles again, showing noticeable fangs. Natsu and #slave feel a dull sensation pass over their minds and they sit down and start to fall asleep,\r\r");
						PersonSpeak(66, "You are not the only beings hunting tonight. This will be the last time we meet, I cannot have people hunting me as well.\r\rDo not fear, this will not hurt, actually the exact opposite. Meow", true);
						AddText("\r\r#slave can barely stay awake and watches as the catgirl leans over Natsu and bites her on the neck, fangs sinking in. Natsu moans passionately and then shudders in what is clearly an orgasm.\r\rThe girl licks Natsu's neck and then straddles #slaveA and bites #slavehisher neck. Immediately #slaveA feels an intense pleasure radiate from #slavehisher neck and #slaveheshe moans as well and then cries as an orgasm erupts through #slavehisher body.\r\rNatsu and #slave fall asleep and wake sometime later, feeling completely fine, and with clear bite marks in their necks.");
					}
					AddText("\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try and hunt again.");
	
					GetPerson("Natsu").SetBitFlag(34);
					Points(0, 1, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 3, 0, 0, 0);
					return true;
				case 41:
					coreGame.ShowDressSmall();
					slaveData.ChangeCatTraining(2);
					ShowMovie(this.mcBase.EventWalk, 1, 1, 23);
					AddText("and meet an armed catgirl, walking cautiously through Town Center. Natsu looks a bit angry and unhappy, and she whispers\r\r");
					PersonSpeak(61, "She is a hunter, chasing and capturing anyone or anything for money. We cannot prove she does anything illegal, but I am quite sure she steals and kidnaps. Very un-catlike, Meow!", true);
					AddText("\r\rThe girl looks at Natsu rather sternly,\r\r");
					PersonSpeak(66, "No need to whisper. Despite your thoughts I always obey my owner and I do not do anything <i>immoral</i>. I am a catgirl, a panther of the night, not some sort of dog or scavenger. Meow!", true);
					AddText("\r\rShe turns her back on Natsu and walks away.");
					GetPerson("Natsu").SetBitFlag(34);
					Points(0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 3, 0, 0, 0);
					break;
				case 42:
					coreGame.ShowDressSmall();
					slaveData.ChangeCatTraining(2);
					ShowMovie(this.mcBase.EventWalk, 1, 0, 24);
					AddText("and meet a catgirl dancing happily in the streets. There is a small bar nearby and she appears slightly drunk,\r\r");
					PersonSpeak(66, "I wish catnip worked on us. But there are plenty of other ways to get the same effect. Drink! Meow!", true);
					AddText("\r\rShe offers a half filled vial of red liquid to #slave.\r\rDoes #slave drink?\r");
					DoYesNoEventXY(2060);
					GetPerson("Natsu").SetBitFlag(34);
					Points(0, 1, 1, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 3, 0, 0, 0);
					return true;
				case 43:
					coreGame.ShowDressSmall();
					ShowMovie(this.mcBase.EventWalk, 1, 1, 25);
					AddText("and meet a catgirl quietly waiting at a closed stall in the market place. She is dressed as a waitress in a short skirt and a small apron. She has a ribbon she is playing with, whirling it but she does not really look happy. She is very focused, but it is hard to say if she is sad or just concentrating.\r\rShe stops whirling the ribbon and briefly comments,\r\r");
					PersonSpeak(66, "My owner wants me to stop being a catgirl, and just be a normal girl...\r\rHe said he loves me and wants a normal girl to be his wife. But I want to be a catgirl and be his wife. What should I do?", true);
					BlankLine();
					coreGame.AskHerQuestions(2061, 2062, 0, 0, "No, be a catgirl wife", "Love not catgirl", "", "", "What is #slave's reply?"); 
					return true;
				case 49:
					GetPerson("Natsu").SetBitFlag(evt);
					coreGame.ShowDressSmall();
					slaveData.ChangeCatTraining(1);
					coreGame.StartMoaning(1);
					ShowMovie(this.mcBase.EventWalk, 1, 1, 18);
					AddText("and a young boy runs up to Natsu and says he has found her! Natsu runs after him, quickly followed by #slave. They arrive at a small house, that Natsu identifies are the home of a wealthy woman named Marna. They can hear noises from inside, someone crying out. Natsu very quickly picks the lock and sneaks in, followed by #slave.\r\rThey follow the sounds and see a woman lightly tied up, the woman Marna, very lightly. A catgirl, the Catburglar?, is energetically licking Marna's pussy from behind. Marna is making cries, not of distress, but of passion. With considerable moaning she orgasms, a long hard orgasm, shuddering as the Catburglar continues licking her. The woman groans and looks behind, straight at Natsu and #slave. She looks startled, embarrassed and blushes deeply. Natsu shows her badge of office and Marna flushes a deeper red and somewhat awkwardly says 'help'.\r\rNatsu leaps toward the Catburglar who is alerted by Marna's reaction, and she rolls to the side. For a time Natsu and the Catburglar wrestle but they are quite evenly matched.\r\r");
					coreGame.AskHerQuestions(2030, 2031, 2032, 2033, "Wrestle the Catburglar too", "Help Marna", "Aid the Catburglar", "Hesitate", "How does #slave react?"); 
					return true;
			}
			GetPerson("Natsu").SetBitFlag(evt);
			AddText("\r\rNatsu invites #slave to return the following night, or actually any night for the next while, to try and hunt again.");
			return true;
		}
		if (slaveData.IsCatgirl() && (eventno == 8 || eventno == 11) && PercentChance(33) ) {
			slaveData.ChangeCatTraining(1);
			slaveData.DifficultyExhib -= 1;
			ShowMovie(this.mcBase.EventWalk, 1, 1, 14);
			ShowPerson(1, 0, 1, 1);
			Points(2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0);
			if (!GetPlace("TownCenter").CheckBitFlag(32)) {
				AddText("#slavesee a cat slave walking slowly with measured steps through the streets of the town center. She is quite, quite naked but still elegant and refined.\r\r#slave and #super approach the cat slave to talk but the slave just smiles and puts a finger to her mouth to signal 'quiet' and she continues walking her hips swaying and her tail moving side to side.\r\r#slaveis impressed by the cat slave's elegance and the way she walks. As the slave leaves a merchant passing tells #super,\r\r");
				PersonSpeak(1, "She walks here often, never speaking but always elegant and beautiful", true);
				AddText("\r\rHe looks after the cat slave with desire in his eyes.");
			} else {
				AddText("Once again #slavesee the elegant and silent cat slave walking slowly through the streets of the town center. She smiles at #slave and then puts a finger to her mouth to signal 'quiet' and she continues walking her hips swaying and her tail moving side to side.\r\r#slaveis impressed by the cat slaves elegance and the way she walks. As the slave leaves a merchant passing tells #super,\r\r");
				AddText("\r\rNearby #super can see the merchant staring at the cat slave.");
			}
			return true;
		}
		return false;
	}
	
	
	// Endings
	
	public function EndingStartAsAssistant(total:Number) : Boolean
	{ 

		if (coreGame.IsCatgirlComplete() && total > 50 && (coreGame.CatEarsWorn == 1 || coreGame.IsDressCatEars()) && coreGame.VarJoyRounded >= 80 && (coreGame.CatTailWorn == 1 || coreGame.IsDressCatTail()) && coreGame.VarCharismaRounded >= 80) {
			// Catgirl
			switch(int(SMData.sCatTrainer)) {
				case 1: coreGame.SetEnding(3, coreGame.GetXMLString("EndingCatgirl/NameLevel1", "EndGame/Slave")); break;
				case 2: 
					if (coreGame.SlaveFemale) coreGame.SetEnding(3, coreGame.GetXMLString("EndingCatgirl/NameLevel2Female", "EndGame/Slave"))
					else coreGame.SetEnding(3, coreGame.GetXMLString("EndingCatgirl/NameLevel2Male", "EndGame/Slave"))
					break;
			}
			if (coreGame.SlaveGirl.ShowEndingCatgirl() != true) ShowMovie(this.mcBase.Ending, 1, 0, SMData.sCatTrainer == 1 ? 1 : 2);
		}
		
		return false;
	}
	
	public function EndingFinishAsAssistant(total:Number) : Boolean
	{
		if (coreGame.NumFin == 3) {
			// Catgirl
			if (coreGame.IsPermanentDickgirl()) {
		
				AddText("When you show up at the house the owner is there to greet you at the door. #personheshuc welcomes you in enthusiastically, and as you walk inside you discuss #slave and #slavehisher past history, as well as #slavehisher current temperament.\r\r");
				PersonSpeak(coreGame.Owner.GetOwnerName(), "I can see that #slaveheshe has a very prominent cock, after all, and enjoys using it like a natural. Still, I was very pleased find that you’ve turned #slavehimher into an excellent catslave.", true);
				AddText("\rInside you find that #slave is dozing in a corner, still wearing #slavehisher catgirl outfit. It appears to be a permanent fixture now. The owner calls #slavehimher name, and #slaveheshe wakes up with a yawn, stretching in a very feline fashion. Spotting you, #slavehisher face lights up and she rubs against your leg affectionately.\r\rThe owner grins and sits down in a nearby chair. He unzips his pants.\r\r");
				PersonSpeak(coreGame.Owner.GetOwnerName(), "Come here kitty, come get your milk.", true);
				if (coreGame.Owner.PersonGender == 1) AddText("\r#slave lets out a soft mewl and slinks up to #slavehisher master. She laps at his cock while looking up at him in a most adorable fashion. As he comes to climax she gulps down every last drop of his cum, and then licks stray flecks from #slavehisher lips. Then she purrs contently.\r\r");
				if (coreGame.Owner.PersonGender == 2) AddText("\r#slave lets out a soft mewl and sits on #slavehisher masters knee. She begins sucking her breast while looking up at her in a most adorable fashion. Finished with the foreplay, #slave goes down and laps at #slavehisher masters pussy. As she comes to climax she gulps down every last drop of her juices. Then she purrs contently.\r\r");
				if (coreGame.Owner.PersonGender == 3) AddText("\r#slave lets out a soft mewl and sits on #slavehisher masters knee. She begins sucking her breast while looking up at her in a most adorable fashion. Finished with the foreplay, #slave goes down and laps at #slavehisher masters pussy and cock. As she comes to climax she gulps down every last drop of her juices and cum, and then licks stray flecks while purring contently.\r\r");
				PersonSpeak(coreGame.Owner.GetOwnerName(), "You’ve done a good job of focusing on #slavehisher training as a cat slave. Her cock doesn’t other me in the least—in fact, I often have #slavehimher lap up #slavehisher own milk to entertain me.", true);
				AddText("\r#slave sits on the floor and raises one of #slavehisher pawed hands like a cat. #slave cocks #slavehisher head and smiles at you.\r\r");
				SlaveSpeak("When I first arrived in Mioya I never thought I would be able to accept being a slave. Thank you for showing me otherwise, meow!", true);
				
			} else {
	
				AddText("When you show up at the house the owner is there to greet you at the door. #personheshuc welcomes you in enthusiastically, and as you walk inside you discuss #slave and #slavehisher past history, as well as #slavehisher current temperament.\r\r");
				PersonSpeak(coreGame.Owner.GetOwnerName(), "You’ve done a great job of making #slavehimher accept #slavehimher new life. I was very pleased find that you’ve turned #slavehimher into an excellent catgirl.");
				AddText("\rInside you find that #slave is dozing in a corner, still wearing #slavehisher catgirl outfit. It appears to be a permanent fixture now. The owner calls #slavehimher name, and she wakes up with a yawn, stretching in a very feline fashion. Spotting you, #slavehisher face lights up and she rubs against your leg affectionately.\r\rThe owner grins and sits down in a nearby chair. He unzips his pants.\r\r");
				PersonSpeak(coreGame.Owner.GetOwnerName(), "Come here kitty, come get your milk.", true);
				if (coreGame.Owner.PersonGender == 1) AddText("\r#slave lets out a soft mewl and slinks up to #slavehisher master. #SlaveHeShe laps at his cock while looking up at him in a most adorable fashion. As he comes to climax #slaveheshe gulps down every last drop of his cum, and then licks stray flecks from #slavehisher lips. Then #slaveheshe purrs contently.\r\r");
				if (coreGame.Owner.PersonGender == 2) AddText("\r#slave lets out a soft mewl and sits on #slavehisher masters knee. #SlaveHeShe begins sucking her breast while looking up at her in a most adorable fashion. Finished with the foreplay, #slave goes down and laps at #slavehisher masters pussy. As she comes to climax #slaveheshe gulps down every last drop of her juices. Then #slaveheshe purrs contently.\r\r");
				if (coreGame.Owner.PersonGender == 3) AddText("\r#slave lets out a soft mewl and sits on #slavehisher masters knee. #SlaveHeShe begins sucking her breast while looking up at her in a most adorable fashion. Finished with the foreplay, #slave goes down and laps at #slavehisher masters pussy and cock. As she comes to climax she gulps down every last drop of her juices and cum, and then licks stray flecks while purring contently.\r\r");
				if (coreGame.IsMale()) PersonSpeak(coreGame.Owner.GetOwnerName(), "You’ve done a great job of stamping out #slavehisher masculinity and focusing on #slavehisher training as a cat girl. He is lithe and feminine and makes a fine slave. Good job.", true);
				else PersonSpeak(coreGame.Owner.GetOwnerName(), "You’ve done a great job of stamping out #slavehisher tomboyism and focusing on #slavehisher training as a cat girl. She is lithe and feminine and makes a fine slave. Good job.", true);
				AddText("\r#slave sits on the floor and raises one of #slavehisher pawed hands like a cat. #slave cocks #slavehisher head and smiles at you.\r\r");
				SlaveSpeak("When I first arrived in Mioya I never thought I would be able to accept being a slave girl. Thank you for showing me otherwise, meow!");
			}
			coreGame.NumFin = 1000;
			return true;
		} 

		return false;
	} 
	
	public function NumCustomEndingsAsAssistant() : Number { return 1; }
	
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText(Language.GetHtml("EndingCatgirl/Hint", "Endings"));
	}

	
	// Images
	
	public function HidePeople()
	{
		this.mcBase.PeopleSinger._visible = false;
		this.mcBase.PeopleCatgirl._visible = false;
		this.mcBase.PeopleLadyCat._visible = false;
		this.mcBase.PeopleNatsu._visible = false;
		this.mcBase.PeopleBustyCatSlave._visible = false;
		this.mcBase.PeopleTigerGirl._visible = false;
	}
	
	public function HideAsAssistant()
	{
		super.HideAsAssistant();
		
		this.mcBase.EventWalk._visible = false;
		this.mcBase.Ending._visible = false;
		this.mcBase.Training._visible = false;
		this.mcBase.PlanningJobs._visible = false;
		this.mcBase.PlanningSchools._visible = false;
		this.mcBase.Parties._visible = false;
		this.mcBase.EventWalkBeach2._visible = false;
		this.mcBase.EventWalkBeach2.gotoAndStop(1);
		this.mcBase.CatgirlRumours._visible = false;
	}
}
