// Sado-Masochism training
//
// Translation status: IMCOMPLETE

// BitFlags
// Flag1
//  18  = Odd teacher agreement

import Scripts.Classes.*;

class MasochistTraining extends TrainingBase
{
	public function MasochistTraining(cgm:Object)
	{
		super(null, cgm);
		
		ModuleName = "MasochistTraining";
	}
	
	
	// Slave Training

	public function AskToStartTraining(say:String)
	{
		if (say == undefined) say = "";
		
		AddText(coreGame.SlaveMeet + " ");
		if (coreGame.LadyFarun.CheckBitFlag(68)) AddText("the Private Tutor of Discipline again");
		else if (coreGame.BitFlag1.CheckBitFlag(24)) AddText("the odd Private Tutor again");
		else AddText("a woman calling herself a Private Tutor, but not of what or who,");
		AddText(" " + say);
		ShowSupervisor();
		ShowPerson(29, 1, 2);
		AddText("\r\r" + SlaveVerb("ask") + " about the potion 'Nymph's Tears' and #slavehisher desire to find a supply. The woman says she can supply all of that potion #slave wants, for a <i>price</i>. Expecting a money value, ");
		if (coreGame.Supervise) AddText("you ask the price.\r\rThe tutor says that she wants #slave to take </i>lessons</i> from her whenever and however she wants. You ask what lessons, and the tutor takes out a whip, but does not answer.\r\rDoes #slave agree?\r");
		else AddText("#assistant asks the price.\r\rThe tutor says that she wants #slave to take </i>lessons</i> from her whenever and however she wants. #assistant asks what lessons, and the tutor takes out a whip, but does not answer.\r\rDoes #slave agree?\r");
		DoYesNoEventXY(4070);
	}


	public function StartTraining(type:Number)
	{
		coreGame.LadyFarun.ClearBitFlag(67);
		coreGame.BitFlag1.SetBitFlag(18);
		coreGame.BitFlag1.ClearBitFlag(20);
		if (coreGame.Slutiness > 5) AddText("#slave eagerly " + NonPlural("agree"));
		else AddText("#slave " + NonPlural(" agree") + " nervously");
		AddText(" to the tutors request. The teacher gives #slavehimher several bottles of the potion, saying\r\r");
		PersonSpeak(29, "This potion is very potent, it makes you orgasm stronger and easier and makes you feel wonderfully stimulated. If you take it too much you will find it hard to orgasm without it. You will eventually become a slut, somewhat focused on orgasms and sex in any form. It will slowly wear off, but few want it to.\r\rI look forward to educating you...", true);
		AddText("\r\rShe blows #slave a kiss while walking away, and then cracks her whip and laughs.");
		coreGame.Sounds.PlaySound("WhipCrack");
	}
	
	function RejectTraining()
	{
		if (coreGame.Supervise) AddText("You refuse her price. The tutor smiles,\r\r");
		else AddText("#super refuses her price. The tutor smiles,\r\r");
		PersonSpeak(29, "I'll teach you sometime...", true);
		AddText("\r\rShe cracks the whip and leaves.");
		coreGame.Sounds.PlaySound("WhipCrack");
	}
	
	public function Training(place:Number) : Boolean
	{
		AddText(coreGame.SlaveMeet + " ");
		if (coreGame.LadyFarun.CheckBitFlag(68)) AddText("the Private Tutor of Discipline again");
		else if (coreGame.BitFlag1.CheckBitFlag(24)) AddText("the odd Private Tutor again");
		else AddText("a woman calling herself a Private Tutor, but not of what or who,");

		ShowPerson(29, 0, 2);
		coreGame.UseGeneric = false;
		coreGame.SlaveGirl.ShowSexActSpank(true);
		var tsclip:MovieClip = coreGame.Generic.mcBase.SpankClip;
		if (coreGame.UseGeneric) coreGame.Generic.ShowSexActSpank(true);
		else tsclip = coreGame.lastmc;
		coreGame.intervalId = setInterval(_root, "ShakeIt", 50, 1, tsclip, tsclip._x, "");
		coreGame.Sounds.PlaySound("Whipping");
		AddText(" who demands to <i>teach</i> #slavehimher now ");
		if (place == 2 || place == 3) AddText("and takes #slavehimher to a nearby building.");
		else AddText("and they retreat to her room.");
		if (Naked) AddText("\r\rThe tutor compliments #slave's naked state and tells #slavehimher to"); 
		else AddText("\r\rThe tutor tells #slave to strip naked and");
		AddText(" start masturbating. She then starts lightly whipping #slave varying the strength and timing of the blows. Even with the pain #slave's arousal grows, and the whipping increases until #slave orgasms in a mixture of pleasure and pain.\r\rThe tutor looks satisfied and then undoes the lower part of her garb and tells " + coreGame.SlaveA + " 'lick me!'.\r\rSome time later, sore but satisfied, #slave" + NonPlural(" leave") + ".");
		return true;
	}
	
	
	// Odd Teacher

	/*
	public function MeetPerson(personno:Number, choice:Number, personstr:String, say:String, evt:String) : Boolean
	{
		if (personno != 29) return false;
		
		var choice:Number = 2;
		if (coreGame.BitFlag1.CheckBitFlag(20) && SMData.BitFlagSM.CheckBitFlag(4)) choice = 0;
		else if (coreGame.BitFlag1.CheckBitFlag(18)) choice = 1;
		
		if (coreGame.modulesList.MeetPerson(29, choice)) return true;
			
		if (choice == 0) {
			AskToStartTraining();
			coreGame.SlaveGirl.AfterMeetOddTeacher(coreGame.WalkPlace, 0);
			coreGame.modulesList.AfterMeetPerson(29, 0);
			return true;
		} else if (choice == 1) {
			Training(coreGame.WalkPlace);
			coreGame.SlaveGirl.AfterMeetOddTeacher(coreGame.WalkPlace, 1);
			coreGame.modulesList.AfterMeetPerson(29, 1);
			return true;
		}
		
		// general meeting
		AddText(coreGame.SlaveMeet + " ");
		if (coreGame.LadyFarun.CheckBitFlag(68)) AddText("the Private Tutor of Discipline again");
		else if (coreGame.BitFlag1.CheckBitFlag(24)) AddText("the odd Private Tutor again");
		else AddText("a woman calling herself a Private Tutor, but not of what or who,");
	
		AddText(" " + say);
		coreGame.ShowPerson(29, 0, 5);
		coreGame.BitFlag1.SetBitFlag(24);
		coreGame.SlaveGirl.AfterMeetOddTeacher(coreGame.WalkPlace, 2);
		coreGame.modulesList.AfterMeetPerson(29, 2);
		return true;
	}
	*/
	
	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		if (sd == undefined) sd == coreGame;
		return sd.BitFlag1.SetBitFlag(18);
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) sd == coreGame;
		return sd.BitFlag1.SetBitFlag(18);
	}
	
	// Events
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// 4070 - agree to tutors price
			case 4070:
				StartTraining(0);
				return true;
				
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// 4070 - agree to tutors price
			case 4070:
				RejectTraining();
				return true;
				
		}
		return false;
	}
	
	
	// Ending
	
	public function EndingStartAsAssistant() : Boolean
	{ 
		if (coreGame.NumFin == 0 && coreGame.TotalBondage >= 20 && coreGame.Score > 40) {
			// S&M
			SetEnding(9, Language.XMLData.GetXMLString("EndingSM/Name", "EndGame/Slave"));
			coreGame.SlaveGirl.ShowEndingSM();
			return true;
		}
		
		return false;
	}
	
	
	public function EndingFinishAsAssistant(total:Number) : Boolean
	{
		if (coreGame.NumFin == 9) {
			// S&M
			AddText("Upon arriving at the address, you find the owner already waiting for you. #personhesheuc is dressed all in leather. #personhesheuc compliments you on your appearance, and then leads you not into the house but around back to a small shed. Inside, you find stairs leading down into a small dungeon.\r\rThe dungeon is dark and dusty, but the owner lights a candle and points over to a corner. There you see #slave, tied while bent over so that #slavehisher legs are locked behind #slavehisher head, and #slavehisher mouth is forced to wrap around ");
			if (coreGame.HasCock) AddText(coreGame.SlaveHisHer + " own dick");
			else AddText("a large strap on");
			AddText(". A collar is tied around #slavehisher neck, and to top it off #slaveheshe is confined within what appears to be a large birdcage—just big enough to allow #slave to sit.\r\rThe owner unlocks the cage and unties enough bonds to allow #slave to stand, though #slaveheshe does this with difficulty. #slave is blindfolded and waits patiently for orders. The owner says nothing, but takes out a leash and attaches it to a ring in #slave's newly pierced ");
			if (coreGame.HasCock) AddText("cock");
			else AddText("clitoris");
			AddText(".\r\r");
			PersonSpeak(coreGame.Owner.GetOwnerName(), "I was delighted to find that #slaveheshe is so experienced with bondage. Why, just look how excited #slaveheshe is. #slave really loves this, don't you slut?", true);
			SlaveSpeak("Yes, #personmaster.", true);
			AddText("\r\rThe owner takes out a riding crop and runs it up one of #slave's thighs, then across the groin and down the other. #slave shivers with delight, dripping wet with anticipation.\r\r");
			PersonSpeak(coreGame.Owner.GetOwnerName(), " I've never been able to push any of my other slaves this far, and I'm looking forward to discovering just how much #slave can take. Don't worry, #slaveheshe is in good hands.", true);
			coreGame.NumFin = 1000;
			return true;
		}
		return false;
		
	} 
	
	public function NumCustomEndingsAsAssistant() : Number { return 1; }
	
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText("To get the ending 'S&M', have your slave do more than 20 Bondage actions and get a score above 40.");
	}

}

