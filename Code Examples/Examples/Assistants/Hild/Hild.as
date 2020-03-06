import Scripts.Classes.*;

// CustomFlag = rape event happened

// BitFlags
//	0 - prevented noble rescue
// 	1 - prevented temple rescue
//	2 - tentacle hybrid query
// 

class Hild extends SlaveModule
{
	private var eventNum1:Number;
	private var eventNum2:Number;
	private var bFirstShow:Boolean;
	
	public static function main(swfRoot:MovieClip, sd:Object, cg:Object) : SlaveModule 
	{
		// entry point
		return new Hild(swfRoot, sd, cg);
	}
	
	public function Hild(swfRoot:MovieClip, sd:Object, cg:Object)
	{
		super(swfRoot, sd, cg);
		
		eventNum1 = GetFreeEvent();
		eventNum2 = GetFreeEvent();
		bFirstShow = true;
	}
	
	public function DestroyAsAssistant()
	{
		coreGame.RemoveLoadedImage(this.Assistant);
	}
	
	// ShowAssistant - shows a graphic for the assistant
	// 1 = normal view in small rectangle
	// 2 = tentacle sex (small version shown when slave girl raped)
	// 3 = raped
	// 4 = never actually passed as a parameter
	// 5 = wet - she falls in some water
	// 6 = large graphic shown when your slave runs away
	public function ShowAsAssistant(type:Number)
	{
		if (type == 1) {
			if (bFirstShow) {
				this.Assistant = undefined;
				bFirstShow = false;
			}
			this.Assistant = coreGame.LoadImageAndShowMovie(this.Assistant, ImageFolder + "/Hild 3.jpg", 0, 6, this.mcBase);
		} else if (type == 3) coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Raped.jpg", 0, 0);
		else if (type == 5) coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Wet.jpg", 1, 1);
		else if (type == 6) {
			coreGame.Backgrounds.ShowOther(11);
			coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Runaway.jpg", 1, 2);
		}
	}

	// HideAsAssistant - hide the assistant graphics
	function HideAsAssistant()
	{
		super.HideAsAssistant();
		this.Assistant._visible = false;
	}
	
	// HideAsAssistant - hide the assistant graphics
	function HideImages()
	{
		super.HideAsAssistant();
		this.Assistant._visible = false;
	}

	// InitialiseAsAssistant - sets up the assistant
	/*
	Variables to control servant
			coreGame.ServantName = "Genma";		// name
			coreGame.ServantPronoun = "I";			// Pronoun, default "I"
			coreGame.AssistantTentacleSex = false; // can the assistant be tentacle fucked, default true
			coreGame.AssistantRape = false;		// can the assistant be raped, default true
			coreGame.ServantGender = 1;			// servants gender, 1 = male, 2 = female, 3 = dickgirl, default 1
			coreGame.SlaveLikeServant = true;		// misleading name, does the servant like the slave, default true
			coreGame.AssistantDescription = 		// a description of the assistant and any effects while training slaves
				"An experienced Slave Maker but with odd techniques, often involving humiliation. He is a trained martial artist, but surprising cowardly.\r\rHe can be used to train any girl and increases her Maximum Obedience by 10%.";
			coreGame.AssistantCost = 200;			// The cost to employ their services
	*/
	public function InitialiseAsAssistant(firsttime:Boolean, noimage:Boolean) : MovieClip {
		coreGame.ServantMaster = coreGame.SlaveMakerName;
		if (this.Assistant != undefined) coreGame.RemoveLoadedImage(this.Assistant);
		this.Assistant = undefined;
		if (noimage == true) return undefined;
		this.Assistant = coreGame.LoadImageAndShowMovie(this.Assistant, ImageFolder + "/Hild 1.jpg", 3, 0, this.mcBase);
		bFirstShow = true;
		return this.Assistant;
	}

	public function EmployAsAssistant() {
		coreGame.VarNymphomania += 5;
		slaveData.CustomFlag = 0;
		slaveData.ClearBitFlag2(0);
		slaveData.ClearBitFlag2(1);
	}

	public function ShowSlaveIntimacy() : Boolean { 
		if (Lesbian) {
			if (slaveData.IsDickgirl()) temp = 1;
			else temp = coreGame.slrandom(2);
			coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Lesbian " + temp + ".jpg", 1, 1);
		} else {
			if (slaveData.IsDickgirl()) coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Event - Slave Retrieved 2.jpg", 1, 1);
			else {
				temp = slrandom(3);
				if (temp == 1) coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Anal.jpg", 1, 1);
				else if (temp == 2) coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Event - Slave Retrieved 1.jpg", 1, 1);
				else coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Event - Slave Retrieved 3.jpg", 1, 1);
			}
		}
		return true;
	}
	
	public function ShowSlaveReview() : Boolean
	{
		coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild 2.png", 1, 2);
		return true;
	}
	
	public function ShowSlaveTalk() : Boolean { 
		coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Discuss.jpg", 1, 1);
		coreGame.AppendActText = false;
		SetText("You talk for a time with Hild, she flirts with you both subtly and overtly.");
		if (coreGame.SMData.SMSpecialEvent != 2) return true;
		
		if (slaveData.CheckBitFlag2(2)) return false;
		
		slaveData.SetBitFlag2(2);
		AddText("\r\rYou decide to ask Hild about your childhood and origin. After all she had told you how she was an expert in all things demonic and some religious people had decribed the tentacle beasts as somewhat demonic.\r\rYou talk for a while to Hild about your past and she listens with interest. After you finish she tells you,\r\r");
		coreGame.ServantSpeak("Despite what you have heard the tentacle beasts are not demons. You may of heard the holy people of the New Gods talk about the tentacle beasts being the children of Lord Tsukiyomi. While it maybe his spawn intermingled with the tentacle beasts they are just another race of creatures, a people, a race, but different to humans.\r\rI will tell you this, you are one of their children, part human part beast. Your future will be decided by which part of your soul you choose to follow.\r\rResist their desires and follow the way of your mother, and avoid their lusts, and you can stay the person you are, no matter how limited that may be.\r\rEmbrace their desires and you will become a leader of their kind, ravaging and seeding your offspring in as many women as you can.", true);
		AddText("\r\rShe looks at you appraisingly\r\r");
		coreGame.ServantSpeak("If you would like to take another step to embracing your heritage, then you may start your army with me?", true);
		AddText("\r\rYou feel your cock hardening at the thought of taking Hild. Do you embrace her?\r");
		DoYesNoEventXY(eventNum2);
		return true;
	}
	
	public function ShowAsAssistantAnal() : Boolean
	{
		coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Anal.jpg", 1, 0);
		return true;
	}
	
	public function ShowAsAssistantSpanking(whip:Boolean) : Boolean
	{
		coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Spanked.jpg", 1, 0);
		return true;
	}
	public function ShowSexActSpank(whip:Boolean) { ShowAsAssistantSpanking(whip); }
	
	public function StartMessageAsAssistant(bSGMessage:Boolean) : Boolean
	{
		if (bSGMessage) return false;
		ServantSpeak("The training of this slut will last for " + coreGame.TrainingTime + " days, and then #slaveheshe will be delivered to #slavehisher owner's cock.", true);
		return true;
	}
	
	public function StartNightAsAssistant(intro:Boolean) : Boolean {
		if (intro) {
			ServantSpeakStart("Good evening #slavemakername! It is now time for us to fuck #slave hard and make #slavehimher submit to our desires.");
			return true;
		}
		return false;
	}
	
	public function StartEveningAsAssistant() : Boolean {
		ServantSpeak(coreGame.SlaveMakerName + ", good evening. We have finished playing with #slave for the daytime and it is now time for #slavehimher to eat food. Later, eat other things...");
		return true;
	}
	
	public function UpdateDateAndItemsAsAssistant(NumDays:Number)
	{
		coreGame.VarLibido += NumDays * 2;
		if (coreGame.DemonicBraWorn == 1) {
			if (coreGame.Home.hWards == 1) coreGame.VarLibido += NumDays;
			else coreGame.VarLibido += NumDays * 6;
		}
		if (coreGame.DemonicPendantWorn == 1) {
			coreGame.VarFuck += NumDays;
		}
	}
	
	public function StartMorningAsAssistant(intro:Boolean) : Boolean 
	{
		ServantSpeakStart("Good morning #slavemakername. I have <i>aroused</i> #slave and " + coreGame.SlaveHeSheIs + " ready to be played with.");
		return true;
	}

	public function DoWalkSlumsAsAssistant(eventno:Number, present:Boolean) : Boolean
	{
		if (eventno == 3 && coreGame.RapeOn) {
			if (slaveData.CustomFlag == 1) coreGame.NumEvent = 3.5;
		}
		return false;
	}
	public function AfterWalkAsAssistant(place:Number)
	{
		if (place == 4 && coreGame.RapeOn && coreGame.OldStrEvent == "Raped-3" && (!coreGame.Supervise)) {
			// Hild supervising
			if (slaveData.CustomFlag == 0) {
				slaveData.CustomFlag = 1;
				AddText("\r\rAs they finish and start to walk away, a dark shadow falls over them and Hild appears, very angry...");
				coreGame.DoEvent(eventNum1);
			} else coreGame.NumEvent = 3.5;
		}
	}
	public function AfterEventNextAsAssistant()
	{
		if (coreGame.Supervise && (coreGame.OldStrEvent == "RapeEventSubmit" || coreGame.OldStrEvent == "RapeEventRaped") && coreGame.RapeOn && slaveData.CustomFlag == 0) {
			// slave maker supervising
			slaveData.CustomFlag = 1;
			AddText("\r\rAs they finish and start to walk away, a dark shadow falls over them and Hild appears, very angry...");
			coreGame.DoEvent(eventNum1);
		}
	}
	
	public function EventRescueAsAssistant() : Boolean
	{
		if ((coreGame.NumEvent == 1.1 || coreGame.NumEvent == 1) && slaveData.CheckBitFlag2(0)) return true;
		if (coreGame.NumEvent == 1.2 && slaveData.CheckBitFlag2(1)) return true;
		return false;
	}

	public function DoEventYesAsAssistant() : Boolean {
		if (int(coreGame.NumEvent == 1)) {
			coreGame.ClipRescue._visible = false;
			SetText("#assistant tells you to save your money, she will rescue #slave. The delegation takes #slave away and #assistant follows at a discrete distance.\r\rThe following morning #assistant and #slave return, exhausted, saying they have convinced the people never to return. You suspect a lot of sex was involved...");
			coreGame.UpdateDateAndItems(1);
			coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Event - Slave Retrieved 1", 1, 0);
			coreGame.DoEvent(9999);
			coreGame.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, -2, 0, 1, 0, 0, 8);
			if (coreGame.NumEvent == 1 || coreGame.NumEvent == 1.1) slaveData.SetBitFlag2(0);
			else slaveData.SetBitFlag2(1);
			return true;
		}
		if (coreGame.NumEvent == eventNum2) {
			ShowSlaveIntimacy();
			SMPoints(0, 0, -0.1, 0, 0, -5, 5, 0, 0, 0, 0, 2, 3, 0);
			slaveData.Impregnate("YoursTentacle", slrandom(3), 14 + Math.floor(Math.random()*5));
			SetText("You embrace Hild and you immediately feel strange stirrings from your cock. It lengthens and grows into a long tentacular cock and erupts out of your clothing. Hild looks on, aroused, and quickly removes her clothing.\r\rYour cock thusts deeply into her pussy, without any thought on your part. You fuck her wildly and passionately, barely noticing her considerably pleasure. Hild orgasms multiple times befire you finally cum, your cock pouring torrents of cum into her womb. You collapse, your cock receeding back to normal. Hild smiles,\r\r");
			coreGame.ServantSpeak("Be happy, there is no doubt a new life is spawning in me now.", true);
			coreGame.TalentProgress += 5;
			coreGame.SMData.SpecialEventFlags.SetBitFlag(2);
			DoEvent(9750);
			return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean {
		if (int(coreGame.NumEvent) == 1) {
			coreGame.ClipRescue._visible = false;
			SetText("#assistant tells you she will rescue #slave. The delegation takes #slave away and #assistant follows at a discrete distance.\r\rThe following morning #assistant and #slave return, exhausted, saying they have convinced the people never to return. You suspect a lot of sex was involved...");
			coreGame.UpdateDateAndItems(1);
			coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Event - Slave Retrieved 1", 1, 0);
			coreGame.DoEvent(9999);
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, -2, 0, 1, 0, 0, 0);
			if (coreGame.NumEvent == 1 || coreGame.NumEvent == 1.1) slaveData.SetBitFlag2(0);
			else slaveData.SetBitFlag2(1);
			return true;
		}
		if (coreGame.NumEvent == eventNum2) {
			SetText("You back away from Hild, shaking your head. As you leave you hear her laughing.");
			SMPoints(0, 0, 0.1, 0, 0, 5, -5, 0, 1, 0, 0, 1, 0, 0);
			coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Love Confession Accepted 1.jpg", 1, 1);
			coreGame.ShowOverlay(0);
			DoEvent(9750);
			return true;
		}
		return false;
	}
	
	public function DoEventNextAsAssistant() : Boolean {
		if (coreGame.NumEvent == eventNum1) {
			coreGame.HideSlaveActions();
			coreGame.HideImages();
			coreGame.Backgrounds.ShowOther(11);
			coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Hild - Angry.jpg", 1, 1);
			ServantSpeak(coreGame.SlaveIs + coreGame.Plural(" my plaything") + " to use or abuse, not yours!", true);
			AddText("\r\rShe gestures and there is a rush of flames and a gate of some sort opens to a blasted landscape. There is a rush of black figures and the rapists are dragged screaming through the gate. The gate closes and Hild says\r\r");
			ServantSpeak("Even this is a learning experience, but I will not allow it to happen again!", true);
			coreGame.ShowPlanningNext();
			return true;
		}
		return false;
	}
	
	public function DoTailorYesAsAssistant(dress:Boolean) : Boolean {
		if (coreGame.ObjectChoice == 1) {
			if (coreGame.PotionsUsed[1] == 2) {
				ServantSpeak("This should be the last time you use this potion. Any more uses will not work in the way you desire.", true);
				AddText("\r\r");
			}
		} else if (coreGame.ObjectChoice > 1.1 && coreGame.ObjectChoice < 1.3) {
			ServantSpeakStart("I am very familiar with this potion, so much so I can precisely control it's effects. There will be no randomness in it's effects.", true);
			if (coreGame.SlaveGender == 1) coreGame.ServantSpeakEnd("\r\rIt will increase the size of #slave's cock!");
			else {
				coreGame.ServantSpeakEnd("\r\rWhat would you like it to do?", true);
				coreGame.ResetQuestions("What will the potion do?");
				if (coreGame.SlaveFemale) coreGame.AddQuestion(22.1, "Increase #slavehisher breast size");
				coreGame.AddQuestion(22.2, "Increase the size of #slavehisher genitals");
				if (!coreGame.CheckBitFlag1(46) || !coreGame.CheckBitFlag1(50)) coreGame.AddQuestion(22.3, "#slave will become much cuter");
				coreGame.ShowQuestions();
				return true;
			}
		}
		return false;
	}
	
	public function AfterTailorYesAsAssistant(dress:Boolean) {
		if (coreGame.ObjectChoice == 1.5) {
			AddText("\r\rHild smiles and compliments #slave's tail,\r\r");
			ServantSpeak("Maybe you would like a matching set of wings? There is someone you can meet, just go for a walk in the Town Center at midday, wearing only your tail and she will meet you.", true);
		}
	}
	
	public function AfterNewPlanningActionAsAssistant(type:Number, available:Boolean)
	{
		if (type == 1007 || type == 1013) coreGame.CurrentSuperviseYourself = true;
	}
	
	public function ShowPregnancyReveal() : Boolean
	{
		coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Event - Pregnancy Reveal 1.png", 1, 2);
		return true;
	}
	
	public function ShowPregnancyBirth() : Boolean
	{
		coreGame.AutoLoadImageAndShowMovie(ImageFolder + "/Event - Pregnancy Birth 1.jpg", 1, 1);
		return true;
	}

}