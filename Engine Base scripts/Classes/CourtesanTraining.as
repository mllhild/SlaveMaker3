// CourtesanTraining training
//
// Translation status: IMCOMPLETE

// HighClassProstitute.PersonFlag

import Scripts.Classes.*;

class CourtesanTraining extends TrainingBase
{
	public function CourtesanTraining(cgm:Object)
	{
		super(null, cgm);
		
		ModuleName = "CourtesanTraining";
	}
	
	
	// Slave Training


	public function StartTraining(type:Number)
	{
		Diary.AddEntry("Accepted Courtesan training.", false, 0, false);
		coreGame.HighClassProstitute.PersonFlag = -1;
		ChangeTraining(10);
		AddText("#personcourtesan is happy and instructs #slavehimher to <b>visit</b> for #slavehisher training.\r\rIn the morning #personcourtesan returns #slave to you.");
		AddText("\r\rAs she leaves, #personcourtesan tells #slave that there is another function in " + coreGame.HighClassProstitute.CustomFlag + " days and " + coreGame.SlaveHeSheIs + " welcome to attend it with her.");
	}
	
	function RejectTraining()
	{
		Diary.AddEntry("Rejected Courtesan training.", false, 0, false);
		coreGame.HighClassProstitute.PersonFlag = -2000;
		AddText("#personcourtesan is a little sad and changes the topic of the conversation.");
		AddText("\r\rIn the morning #personcourtesan returns #slave to you.");
	}
	
	public function Training(place:Number) : Boolean
	{
		if (coreGame.HighClassProstitute.PersonFlag == -2000) return false;
		
		if (coreGame.HighClassProstitute.PersonFlag == -1)
		{
			coreGame.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 2);
			if (IsDickgirl()) {
				coreGame.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3);
				PersonSpeak(4, "As you are a hermaphrodite I have taken a certain potion. Today we shall discuss how to sexually please a gentleman as a hermaphrodite. You need to be careful to determine their reaction to your cock...");
				temp = coreGame.DickgirlTesticles ? 5 : 10;
			} else {
				PersonSpeak(4, "Today we shall discuss how to sexually please a gentleman...");
				temp = 4;
			}
			Points(0, 0, 2, 2, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0);
			ShowPerson(4, 1, 1, temp);
			coreGame.HighClassProstitute.PersonFlag = -2;
			ChangeTraining(25);
			coreGame.ChangeSeduction(5);
			Backgrounds.ShowBedRoom(16);
			return true;
		}
		
		if (coreGame.HighClassProstitute.PersonFlag == -2)
		{
			PersonSpeak(4, "Today we shall discuss how tease and arouse your customer...");
			coreGame.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 4);
			ShowPerson(4, 1, 1, 6);
			ChangeTraining(25);
			coreGame.ChangeSeduction(5);
			Points(2, 4, 2, 2, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
			coreGame.HighClassProstitute.PersonFlag = -3;
			return true;
		} 
		
		if (coreGame.HighClassProstitute.PersonFlag == -3)
		{
			PersonSpeak(4, "Today we shall discuss refined conversation and etiquette...");
			AddText("\r\rAfter the lesson #personcourtesan congratulates #slave,\r\r");
			PersonSpeak(4, "My dear, there is little more I can teach you now, you are a trained courtesan. You will should now try to be the best escort a gentleman or lady could desire.", true);
			ShowPerson(4, 1, 1, 7);
			coreGame.slCourtesan = 100;
			coreGame.DoneCourtesan = true;
			ChangeTraining();
			coreGame.ChangeSeduction(5);
			coreGame.HighClassProstitute.PersonFlag = -4;
			Diary.AddEntry("Completed Courtesan training.", false, 0, false);
			Points(2, 2, 4, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			return true;
		}
		return false;
	}
	
	
	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		if (sd == undefined) return coreGame.slCourtesan > 0;
		return sd.slCourtesan > 0;
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) return coreGame.DoneCourtesan;
		return sd.DoneCourtesan;
	}
	
	function ChangeTraining(val:Number, sd:Slave)
	{
		if (sd == undefined) coreGame.ChangeCourtesan(val);
		else sd.ChangeCourtesan(val);
	}
	
	// Events
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// Courtesan training	
			case 8079:
				StartTraining(0);
				return true;
				
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// Courtesan training
			case 8079:
				RejectTraining();
				return true;
				
		}
		return false;
	}
	
	
	// Ending
	
	public function EndingStartAsAssistant() : Boolean
	{
		if (coreGame.VarConversation > 99 && coreGame.VarCharisma > 95 && coreGame.VarRefinement > 60 && coreGame.VarFuck > 90 && coreGame.VarBlowJob > 90 && coreGame.DoneCourtesan) {
			// Courtesan
			SetEnding(26, Language.XMLData.GetXMLString("EndingCourtesan/Name", "EndGame/Slave"));
			coreGame.SlaveGirl.ShowEndingCourtesan();
		}
		return false;
	}
	
	
	public function EndingFinishAsAssistant(total:Number) : Boolean
	{
		if (coreGame.NumFin == 26) {
			// Courtesan
			AddText("You arrive at the address only to find that there is a social event going on. Although it is an average mansion belonging to a rich but ordinary merchant, you recognize many famous and noble faces in the crowd—clearly this is a high class gathering. Though you do not have invitations, the minute you mention that you were responsible for training #slave, you and your party are quickly welcomed inside and told to enjoy yourselves.\r\r");
			if (SMData.GuildMember) AddText("The Guild Representative looks impressed, but before he can say a word he is whisked away by an attractive and well dressed dancer. You smirk, knowing that you won't be seeing him for a while.\r\r");
			AddText("Out on the dance floor, you spot #slave #slavehimherself, waltzing with the Lord of the realm while other nobles cast jealous glances their way. From the way #slaveheshe whispers in the Lord's ear, you can guess that they'll be spending some private time together later.\r\rDeciding not to interrupt, you navigate your way towards the dining area where a lavish feast is spread out buffet style. You pick your way through the food and sample the wine, amazed at how rich everything tastes. A maid offers to satisfy any other needs you might have, and you accept, sitting down to eat at a table while she attends to you under it.\r\rAs you enjoy yourself, you spot the #personcourtesan entering the room. You greet her, and she smiles and quickly comes over to you.\r\r");
			PersonSpeak(4, "I hope you like the party, my dear. Have you seen #slave? That's my protégé for you. There are many courtesans working the nobility here tonight, but #slaveheshe is the center of attention.", true);
			AddText("\rYou ask her if she's worried that her student might have surpassed #slavehisher teacher. #personcourtesan laughs and shakes her head.\r\r");
			PersonSpeak(4, "This whole affair has only improved my own reputation—as I'm sure it'll improve yours.", true);
			AddText("\rWith that, she says that she must attend to her own employer, leaving you to enjoy the rest of the night. After the party is over, the owner approaches you with #slave dangling from #personhisher arm. #personhesheuc thanks you profusely for #slave's training, telling you that thanks to #slavehimher #personhisher social status has improved remarkably.\r\r");
			PersonSpeakStart(coreGame.Owner.GetOwnerName(), "Your training is above and beyond anything I expected. Most people have to pay enormous sums for the services of a courtesan, but I actually own one! ", true);
			if (coreGame.IsDickgirl()) AddText("Furthermore, her cock is a novelty which makes her even more desirable among the nobility.");
			PersonSpeakEnd("Thanks to you, I expect the Lord to name me a full noble soon.", true);
			AddText("\r#slave smiles at you so charmingly that it makes even your heart flutter.\r\r");
			SlaveSpeak("Thank you so much for my excellent education, sir. I promise I'll be putting it to good use.", true);
			AddText("\rAfter thanking the owner for a wonderful evening");
			if (SMData.GuildMember) AddText(", you prepare to leave. You find the Guild Representative passed out by the punch bowl with his fly undone and lipstick marks all over his face. You roughly wake him up, and he stumbles out the door behind you.");
			else AddText(" you leave the party.");
			coreGame.NumFin = 1000;
			return true;
		}
		return false;
		
	} 
	
	public function NumCustomEndingsAsAssistant() : Number { return 1; }
	
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText(Language.GetHtml("EndingCourtesan/Hint", "Endings"));
	}

}

