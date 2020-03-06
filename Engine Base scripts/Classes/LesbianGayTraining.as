// Lesbian training
//
// Translation status: IMCOMPLETE

// BitFlags
// Flag1
//  10  = in Lesbian training
//	11	= refused Lesbian Training
//	12	= reset = Offer Lesbian Training next Lesbian act
//  27  = set lesbian training at start of day

import Scripts.Classes.*;

class LesbianGayTraining extends TrainingBase
{
	
	public var LesbianTraining:Boolean;
	public var currLesbianTrainer:Number;
	public var currGayTrainer:Number;

	public function LesbianGayTraining(cgm:Object)
	{
		super(null, cgm);
		
		ModuleName = "LesbianGayTraining";
		LesbianTraining = false;
		currLesbianTrainer = 0;
		currGayTrainer = 0;
	}

	
	// Slave Maker Training
	
	public function SlaveMakerTraining() : Boolean
	{
		if (SMData.sLesbianTrainer >= 1) return false;
		
		AddText("#personlesbiantrainer talks with you about training lesbians and encouraging girls to embrace lesbian love. She tells you many things,");
		switch(Math.round(SMData.sLesbianTrainer * 10)) {
			case 0: 
				BlankLine();
				PersonSpeak(10, "Obviously, you must have her do lesbian acts often", true);
				break;
			case 3:
				BlankLine();
				if (coreGame.DickgirlLesbians) PersonSpeak(10, "Lesbian love is the love between women, not men.\r\rMost lesbians also accepts hermaphrodites as lovers, this is a matter of preference. Some prefer hermaphrodite lovers as a way to avoid certain religious decrees.\r\rI personally prefer women but a hermaphrodite is also a woman!", true);
				else {
					PersonSpeakStart(10, "Lesbian love is the love between women, not men");
					if (coreGame.DickgirlOn == 1 && coreGame.DickgirlLesbians == false) AddText(" or hermaphrodites");
					PersonSpeakEnd(", again obvious.");
				}
				break;
			case 6:
				BlankLine();
				PersonSpeak(10, "You must avoid any sexual training with men, involving only women.", true);
				break;
			case 9:
				BlankLine();
				PersonSpeak(10, "You must encourage her desires and have her meet and flirt with as many women as you can. Sometime she will fall in love with a woman and embrace her lesbian nature.", true);
				AddText("\r\rAfter some questions, #personlesbiantrainer says that she thinks you are ready to train lesbian slaves.");
				break;
			default:
				AddText(" and you listen carefully as she intensely watches #slave.");
				break;
				
		}
		XMLGeneral("SlaveMakerTraining", false, xNode);
		SMData.sLesbianTrainer = SMData.sLesbianTrainer + 0.1;
		if (SMData.sLesbianTrainer >= 0.96) SMData.sLesbianTrainer = 1;
		coreGame.UpdateSlaveMaker();
		return true;
	}
	
	
	// Slave Training

	public function AskToStartTraining(say:String)
	{
		coreGame.HideSlaveActions();
		if (sd.IsPermanentDickgirl() && coreGame.DickgirlLesbians == false) {
			coreGame.SlaveGirl.ShowNaked();
			sd.BitFlag1.SetBitFlag(11);
			if (sd.SlaveGender > 3) SetText("Unfortunately, due to their physical condition, that is their large cocks, lesbian training seems to not be right yet. Most lesbians do not desire partners with cocks, but ones who are compeletely female.\r\rYou will wait until they change and become fully women.");
			else SetText("Unfortunately, due to her physical condition, that is her large cock, lesbian training seems to not be right yet. Most lesbians do not desire a partner with a cock, but someone who is compeletely female.\r\rYou will wait until she changes and becomes fully a woman.");
		} else {
			coreGame.Generic.ShowEndingLesbianSlave();
			if (sd.IsMale()) {
				AddText(coreGame.SlaveHas + " agreed to homosexual acts. You talk about the joys of a homosexual life and particularly about being the slave of a homosexual.\r\r");
				if (sd.LesbianInterest != -1 && sd.LesbianInterest <= coreGame.currGayTrainer) {
					if (sd.SlaveGender > 3) AddText("After a long conversation they still say they are not gay but are willing to try some other things now.\r\r");
					else AddText("After a long conversation #slaveheshe still says #slaveheshe is not gay but is willing to try some other things now.\r\r");
					AddText("Do you want to start #slavehimher training as " + Plural("a homosexual slave") + "?\r");
					DoYesNoEvent(271);
				} else {
					sd.BitFlag1.SetBitFlag(11);
					if (coreGame.SlaveGirl.LesbianTrainingRefused() != true) {
						if (sd.LesbianInterest == -1) SetLangText("TrainingRefusedBi", "SlaveTrainings/Lesbian");
						else SetLangText("TrainingRefused", "SlaveTrainings/Gay");
					}
				}
			
			} else {
				AddText(coreGame.SlaveHas + " agreed to lesbian acts. You talk about the joys of a lesbian life and particularly about being the slave of a lesbian.\r\r");
				if (sd.LesbianInterest != -1 && sd.LesbianInterest <= coreGame.currLesbianTrainer) {
					if (sd.SlaveGender > 3) AddText("After a long conversation they still say they are not lesbians but are willing to try some other things now.\r\r");
					else AddText("After a long conversation she still says she is not a lesbian but is willing to try some other things now.\r\r");
					AddText("Do you want to start #slavehimher training as " + Plural("a lesbian slave") + "?\r");
					DoYesNoEvent(271);
				} else {
					sd.BitFlag1.SetBitFlag(11);
					if (coreGame.SlaveGirl.LesbianTrainingRefused() != true) {
						if (sd.LesbianInterest == -1) SetLangText("TrainingRefusedBi", "SlaveTrainings/Lesbian");
						else SetLangText("TrainingRefused", "SlaveTrainings/Lesbian");
					}
				}
			}
		}
	}
	
	public function StartTraining(type:Number)
	{
		trace("trainlesbians.StartTraining");
		sd.BitFlag1.SetBitFlag(27);
		XMLGeneral(sd.IsMale() ? "SlaveTrainings/Gay/TrainingAccepted" : "SlaveTrainings/Lesbian/TrainingAccepted");
		coreGame.SlaveGirl.LesbianTrainingAccepted();
		
		sd.BitFlag1.SetBitFlag(10);
		InitialiseTraining(sd)
		if (sd.VarLesbianFuck == 0) sd.VarLesbianFuck = sd.VarFuck / 10;
		if (sd.VarCunnilingus == 0) sd.VarCunnilingus = sd.TotalLick;
		coreGame.UpdateSlave();
		sd.BitFlag1.ClearBitFlag(27);
		if (!Language.IsTextShown()) ServantSpeak(Language.GetHtml("TrainingStarted", sd.IsMale() ? "SlaveTrainings/Gay" : "SlaveTrainings/Lesbian"));
	}
	
	public function RejectTraining()
	{
		sd.BitFlag1.SetBitFlag(11);
		Language.XMLGeneral(sd.IsMale() ? "SlaveTrainings/Gay/DoNotTrain" : "SlaveTrainings/Lesbian/DoNotTrain");
	}
	
	public function StopTraining()
	{
		sd.BitFlag1.ClearBitFlag(10);
		InitialiseTraining();
	}
	
	/*
	public function FinishedTraining()
	{
	}
	*/
	
	public function InitialiseTraining(sdo:Object)
	{
		if (sdo != undefined) SetSlave(sdo);
		SetLesbianStats(sd);
		LesbianTraining = sd.BitFlag1.CheckBitFlag(10);
		coreGame.LesbianTraining = LesbianTraining;
		coreGame.Icons.UpdateIcons(sd);
	}
	
	
	public function SetLesbianStats(sdt:Object)
	{	
		if (sdt.BitFlag1 == undefined) return;
		var lestr:Boolean = sdt.BitFlag1.CheckBitFlag(10);
		if (lestr && !sdt.IsMale()) {
			coreGame.StatisticsGroup.BlowJobs.StatLabel.text = Language.GetHtml("Cunnilingus", Language.statNode);
			coreGame.StatisticsGroup.BlowJobs.BGStatLabel.text = coreGame.StatisticsGroup.BlowJobs.StatLabel.text;
			coreGame.StatisticsGroup.Fucking.StatLabel.text = Language.GetHtml("TribStrapOn", Language.statNode);
			coreGame.StatisticsGroup.Fucking.BGStatLabel.text = coreGame.StatisticsGroup.Fucking.StatLabel.text;
		} else {
			coreGame.StatisticsGroup.BlowJobs.StatLabel.text = Language.GetHtml("Blowjobs", Language.statNode);
			coreGame.StatisticsGroup.BlowJobs.BGStatLabel.text = coreGame.StatisticsGroup.BlowJobs.StatLabel.text;
			coreGame.StatisticsGroup.Fucking.StatLabel.text = Language.GetHtml("Fucking", Language.statNode);
			coreGame.StatisticsGroup.Fucking.BGStatLabel.text = coreGame.StatisticsGroup.Fucking.StatLabel.text
		}
	}
	
	
	// Slave Status
	
	public function IsTrainingStarted(sdt:Slave) : Boolean
	{
		if (sdt == undefined) return coreGame.BitFlag1.CheckBitFlag(10);
		return sdt.BitFlag1.CheckBitFlag(10);
	}
	
	public function IsTrainingComplete(sdt:Slave) : Boolean
	{
		if (sdt == undefined) return coreGame.Sexuality < 25;
		return sdt.Sexuality < 25;
	}
	
	public function ChangeTraining(val:Number, sdt:Slave)
	{
		if (sdt == undefined) coreGame.AlterSexuality(val);
		else sdt.AlterSexuality(val);
	}
	
	
	// Lesbian Act
	
	public function IsTrainingEvent(ev:Object) : Boolean { 
		
		var act:Number = Number(ev)

		if (!coreGame.SlaveFemale) {
			// Male slave, is this a homosexual act		
			return (coreGame.totfemales == 0);
		}
		
		// Female/dickgirl slave, is this a lesbian act
		if (coreGame.totmales != 0) return false;
		if (coreGame.totdickgirls != 0) {
			if (!coreGame.DickgirlLesbians) return false;
			if (coreGame.totfemales == 0) return true;
		}
		return (coreGame.totfemales != 0);
	}
	
	// Slave declares they are a lesbian
	private function LesbianDeclaration()
	{
		Backgrounds.ShowBedRoom();
		coreGame.UseGeneric = false;
		coreGame.SlaveGirl.ShowBreak();
		if (coreGame.UseImages) coreGame.ShowActImage(1017);
		coreGame.ShowSexDream(true);
		SetText(SlaveVerb("ask") + " to talk to you, and #slaveheshe" + SlaveVerb("tell") + " you about " + coreGame.SlaveHisHerVerb("dream") + ",\r\r");
		if (sd.IsMale()) {
			SlaveSpeak("#slavepronoun have been having a lot of erotic dreams recently. More and more though they are of gentle or passionate or wild sex with other men. #slavepronoun have not dreamed of women in a while now, only of embracing and loving other men.", true);
			AddText("\r\r" + SlaveVerb("blush") + " and " + NonPlural("look") + " at you, continuing,\r\r");
			SlaveSpeakStart("#slavepronoun think #slavepronoun want to follow this more and more, #slavepronoun have decided #slavepronoun gay!", true);
		} else {
			SlaveSpeak("#slavepronoun have been having a lot of erotic dreams recently. More and more though they are of gentle or passionate or wild sex with other women. #slavepronoun have not dreamed of men or cocks in a while now, only of embracing and loving other women.", true);
			AddText("\r\r" + SlaveVerb("blush") + " and " + NonPlural("look") + " at you, continuing,\r\r");
			SlaveSpeakStart("#slavepronoun think #slavepronoun want to follow this more and more, #slavepronoun have decided #slavepronoun ", true);
			if (sd.SlaveGender > 3) AddText("are lesbians!");
			else AddText("am a lesbian!");
		}
		SlaveSpeakEnd("\r\rYour training has helped to show " + coreGame.SlaveMe + " this truth and #slavepronoun thank you!");
		sd.SetSexuality(23);
		sd.DifficultyLesbian = 0;
		coreGame.Icons.SetLoveIcon(_root);
		Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 4, 0);
		DoEvent(9999);
	}
	
	
	// Reluctance
	
	public function GetReluctanceLevel() : Number
	{
		if (coreGame.ReluctanceLevel == -1) return -1;
		if (coreGame.Participants.length == 1 && coreGame.PersonIndex == -100 && slaveData.LoveAccepted == 1) return 0;
		
		if (slaveData.Sexuality < 25 && coreGame.Lesbian == false) return 3;
		if (slaveData.Sexuality < 40 && coreGame.Lesbian == false) return 1;
		if (slaveData.Sexuality < 75 && slaveData.Sexuality > 60 && coreGame.Lesbian) return 1;
		if (slaveData.Sexuality > 75 && coreGame.Lesbian) return 3;
		return 0;
	}
	
	public function IsResistingAct(act:Number, male:Number, female:Number, dickgirl:Number) : Boolean
	{
		if (female == undefined) female = 0;
		if (male == undefined) male = 0;
		if (dickgirl == undefined) dickgirl = 0;
		
		var type:String;
		if (coreGame.ReluctanceLevel == 0 || coreGame.ReluctanceLevel == -1) return false;
		if (coreGame.Lesbian) {
			if (coreGame.SlaveFemale) {
				if (female > 0) type = dickgirl > 0 ? "female or hermaphrodite" : "female";
				else type = "hermaphrodite";
			} else {
				if (male > 0) type = dickgirl > 0 ? "male or hermaphrodite" : "male";
				else type = "hermaphrodite";
			}
			if (coreGame.DickgirlLesbians) female += dickgirl;
			if (female > 1) {
				if (coreGame.ReluctanceLevel == 1) AddText("#slaveis uncomfortable with the fact only " + type + " partners are involved in this training.\r\r");
				else AddText("#slaveis very reluctant to do this training, particularly because only " + type + " partners are involved in this training.\r\r");
			} else {
				if (coreGame.ReluctanceLevel == 1) AddText("#slaveis uncomfortable with the fact #slavehisher partner is " + type + ".\r\r");
				else AddText("#slaveis very reluctant to do this training, particularly because #slavehisher partner is " + type + ".\r\r");
			}
			return true;
		}
		if (coreGame.SlaveFemale) {
			if (male > 0) type = dickgirl > 0 ? "male or hermaphrodite" : "male";
			else type = "hermaphrodite";
		} else {
			if (female > 0) type = dickgirl > 0 ? "female or hermaphrodite" : "female";
			else type = "hermaphrodite";
		}
		if (!coreGame.DickgirlLesbians) male += dickgirl;
		if (male > 0) {
			if (coreGame.ReluctanceLevel == 1) AddText("#slaveis uncomfortable with the fact only " + type + " partners are involved in this training.\r\r");
			else AddText("#slaveis very reluctant to do this training, particularly because only " + type + " partners are involved in this training.\r\r");
		} else {
			if (coreGame.ReluctanceLevel == 1) AddText("#slaveis uncomfortable with the fact #slavehisher partner is a " + type + ".\r\r");
			else AddText("#slaveis very reluctant to do this training, particularly because #slavehisher partner is a " + type + ".\r\r");
		}
		return true;
	}
	
	// Events
	// Decided they are lesbian (or gay)
	public function EventsAsAssistant(possible:Boolean)
	{
		if (possible && LesbianTraining && sd.Sexuality == 25 && sd.LesbianInterest != -1) {
			
			// slave in lesbian/gay training and at verge of declaring
			
			// Male slave maker or Dickgirl and Lesbian do not love Dickgirls
			if (sd.IsMale() || (SMData.Gender == 1 || (coreGame.DickgirlLesbians == false && SMData.Gender == 3))) {
				if (Math.floor(Math.random() * 10 + coreGame.Difficulty) < 4) {
					LesbianDeclaration();
				}
				return;
			}
			
			// Female slave, Female slave maker or Dickgirl and Lesbian do love Dickgirls
			if (SMData.Gender == 2 || (coreGame.DickgirlLesbians == true && SMData.Gender == 3)) {
				if (Math.floor(Math.random() * 5 + coreGame.Difficulty) < 4) {
					LesbianDeclaration();
				}
			}
		}
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// shall we start lesbian training?
			case 270:
				AskToStartTraining();
				return true;
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// Start Lesbian Training
			case 271:
				StartTraining();
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// Refuse Lesbian Training
			case 271:
				RejectTraining();
				return true;
		}
		return false;
	}
	
	// Endings
	
	public function ShowEndingLesbianSlave()
	{
		if (coreGame.StartSexuality >= 25 && coreGame.Sexuality < 25 && coreGame.LesbianInterest != -1) {
			coreGame.EndGame.ViewBasic();
			AddText("Thank you for " + (coreGame.SlaveGender > 3 ? "our" : "my") + " training and making " + (coreGame.SlaveGender > 3 ? "us" : "me") + " realise " + (coreGame.SlaveGender > 3 ? "our" : "my") + " sexuality and the joy of " + (coreGame.SlaveFemale ? "lesbian" : "gay") + " love and sex.\r\r");
			Backgrounds.ShowBedRoom();
			coreGame.SlaveGirl.ShowEndingLesbianSlave();
		}
	}
		

}

