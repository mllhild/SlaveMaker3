// Beach Private
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PlaceBeachPrivate extends PlaceBeach
{
	// constructor
	public function PlaceBeachPrivate(mc:MovieClip, cg:Object, cc:City)
	{
		super("BeachPrivate", mc, cg, 9.3, cc);
	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		ResetEvents();
		ClearBitFlag(32);
		ClearBitFlag(33);
		ClearBitFlag(35);
		ClearBitFlag(36);
	}
	
	// Set the valid events when walking
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.EventDefault = "Day-Event1-1";	// set default event

		this.AddEvent("Day-Event1-1");
		this.AddEvent("Day-Event2-2");
		this.AddEvent("Day-Event3-3");
		this.AddEvent("Day-Nothing-4");
		this.AddEvent("Night-Event1-5");
		this.AddEvent("Night-Nothing-6");
		if (coreGame.TentaclesOn == 1) {
			this.AddEvent("Night-Event3-7");
			this.AddEvent("Night-Event4-8");
		}
	}
	
	public function WalkAtPrivateArea() {
		coreGame.WalkPlace = 9.3;
		
		// Select the event and show it 
		super.DoWalkLoaded(this.mcBase,this.ModuleName);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) {
		
		if (!IsDayTime() && coreGame.GameTimeMins < 1320 && coreGame.TentaclesOn == 1 && slrandom(5) == 1) coreGame.SetEvent("TentacleSex");
		else super.GetWalkEvent(exclude,sequential);
				
	}
	
	public function HandleWalk():Boolean {
		SMTRACE("BeachSwim::HandleWalk "+coreGame.StrEvent);

		slaveData.MinLibido += 2;
		
		switch (coreGame.NumEvent) {

		// Lesbian
		case 1:
			temp = slrandom(5) + 4;
			if (temp == 9) {
				Backgrounds.ShowOverlayWhite();
				ShowMovie("BeachWalk/Private", 1, 13, temp);
			} else ShowMovie("BeachWalk/Private", 1, 1, temp);
			AddText(coreGame.SlaveMeet + " some girls passionately kissing and caressing each other, very clearly foreplay and very arousing to #slave. ");
			if (coreGame.SlaveFemale) {
				slaveData.DifficultyLesbian--;
				slaveData.AlterSexuality(-2);
				AddText("The girls gesture imploringly at #slave to join them and continue their foreplay. ");
				if (slaveData.VarLibido > 50 || slaveData.Slutiness > 5 || SMData.SMFaith == 2 || coreGame.LesbianTraining || slaveData.Sexuality < 25) AddText("#slave joyfully accepts.");
				else AddText(coreGame.SlaveVerb("feel") + " reluctant, but watching the girls " + coreGame.SlaveHeSheVerb("feel") + " an overwhelming arousal, almost like it floods in from outside. #slave joyfully accepts.");
				if (coreGame.LesbianTraining) Points(0, 2, 0, 0, SMData.SMFaith == 1 ? -2 : 0, 1, 0, 0, 0, 2, 2, -2, 2, 0, -2, 0, 3, 1, 0, 0);
				else Points(0, 2, 0, 0, SMData.SMFaith == 1 ? -2 : 0, 1, 0, 0, 0, 0, 0, -2, 2, 0, -2, 0, 3, 1, 0, 0);
			} else {
				Points(0, 0, 0, 0, SMData.SMFaith == 1 ? -2 : 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 3, 0, 0, 0, 0, 0);
				AddText("The girls glance at #slave but ignore #slavehimher and passionately have lesbian sex before #slavehisher eyes.");
			}
			return true;

		// Sex
		case 2:
			temp = slrandom(4) + 19;
			ShowMovie("BeachWalk/Private", 1, 1, temp);
			AddText("#slavesee a group of men and women in the light woods, fucking with great enthusiasm and passion. " + coreGame.SlaveVerb("watch") + " and " + coreGame.SlaveVerb("feel") + " an overwhelming arousal, almost like it floods in from outside.\r\rA woman who us being fucked loudly orgasms, and cries out to #slave to join and " + coreGame.OrgasmText() + " many, many times.");
			slaveData.DifficultyGangBang--;
			slaveData.AlterSexuality(2);
			AddText("The girls gesture imploringly at #slave to join them and continue their foreplay. ");
			if (coreGame.TestObedience(slaveData.DifficultyGangBang, coreGame.Action)) AddText(coreGame.SlaveVerb("feel") + " reluctant, but the woman's orgasm was so strong, #slaveheshe joyfully accepts.");
			else AddText("#slave joyfully accepts.\r\rAfter a long period of joyous and unrestrained sex, " + coreGame.SlaveVerb("leave") + " feeling a little confused.");
			var moralitydec:Number = -2;
			if (SMData.SMFaith != 1) moralitydec = -1;
			Points(0, -1, 0, 0, moralitydec, 1, 0, 0, 0, 1, 1, -1, 2, 0, -2, 0, 4, 0, 0, 0);
			return true;

		// Noblewoman
		case 3:
			if (!this.CheckBitFlag(33)) {
				this.SetBitFlag(33);
				if (coreGame.IsDickgirlEvent()) {
					this.SetBitFlag(34);
					AddText(coreGame.SlaveMeet + " a noblewoman relaxing on her own, sunbathing and she is very, very obviously a hermaphrodite as she is trying to get a tan on her rather large cock.\r\rShe talks a little with #slave and then whispers that she knows a secret about the beach and would #slave like to know it?\r\r#slave eagerly " + coreGame.NonPlural("ask") + " and the woman says that there is a price, as she lightly touches her stiffening cock.\r\rWill #slave pay the price?");
					coreGame.DoYesNoEventXY(4306);
				} else {
					AddText(coreGame.SlaveMeet + " a noblewoman relaxing on her own, sunbathing wearing a minimal, fishnet sort of 'swimsuit'.\r\rShe talks a little with #slave and then whispers that she knows a secret about the beach and would #slave like to know it?\r\r#slave eagerly " + coreGame.NonPlural("ask") + " and the woman says that there is a price, as she lightly touches her moist, exposed pussy.\r\rWill #slave pay the price?");
					coreGame.DoYesNoEvent(4306);
				}
			} else {
				if (!this.CheckBitFlag(35)) {
					AddText(coreGame.SlaveMeet + " again the noblewoman relaxing and they talk a little. The noblewoman again offers to tell a secret about the beach for a price.\r\rWill #slave pay the price?");
					coreGame.DoYesNoEvent(4306);
				} else {
					AddText(coreGame.SlaveMeet + " again the noblewoman relaxing and " + coreGame.SlaveHisHer + coreGame.Plural(" mind") + coreGame.NonPlural(" cloud") + " and #slaveheshe " + coreGame.NonPlural("kneel") + " in front of the woman and once again pays the price for a secret.\r\r");
					if (this.CheckBitFlag(34)) {
						AddText("#slave licks the woman's cock which is very hard and the woman moans softly.\r\r#slave licks and sucks the woman's cock but while she moans in pleasure she does not cum! #slave looks up at the woman who groans,\r\r");
						PersonSpeak("Noblewoman", "Ohhh you need to overcum my control and force me to mmmmm, cum. You are doing delightfully...", true);
						AddText("\r\r#slave renews #slavehisher licking of the woman's cock, and plunges fingers into the woman's pussy, fucking her as #slaveheshe licks. The woman moans more, her hips slightly thrusting and whispers 'a little more'. #slave pushes a finger into the noblewoman's ass fucking fingers in pussy and ass while licking the head of her cock.\r\rThe noblewoman gasps and holds #slave's head and cries out cumming long spurts of cum into #slave's mouth for a long while. The woman's cum overflows #slave's mouth and the woman gasps 'Swallow!' and #slave does so, almost involuntarily.");
						AddText("\r\rThe woman collapses breathing heavily and after a bit softly laughs and dismisses #slave.");
					} else {
						AddText("#slave licks the woman's pussy, which is very wet with arousal and the woman moans softly.\r\r#slave licks the woman's pussy and gently sucks and bites her clit, but while she moans in pleasure she does not cum! #slave looks up at the woman who groans,\r\r");
						PersonSpeak("Noblewoman", "Ohhh you need to overcum my control and force me to mmmmm, orgasm. You are doing delightfully...", true);
						AddText("\r\r#slave renews #slavehisher licking of the woman's pussy, and plunges fingers into the woman's pussy, fucking her as #slaveheshe licks. The woman moans more, her hips slightly thrusting and whispers 'a little more'. #slave pushes a finger into the noblewoman's ass fucking fingers in pussy and ass while sucking on her clit.\r\rThe noblewoman gasps and holds #slave's head and cries out orgasming, small spurts of juice squirting into #slave's mouth for a long while. The woman's juices fill #slave's mouth and the woman gasps 'Swallow!' and #slave does so, almost involuntarily.");
						AddText("\r\rThe woman collapses breathing heavily and after a bit softly laughs and dismisses #slave.");	
					}
				}
			}
			if (this.CheckBitFlag(34)) coreGame.BeachWalk.ShowMovie("Private", 1, 2, 18);
			else coreGame.BeachWalk.ShowMovie("Private", 1, 1, 19);
			return true;

	
			// Lesbian
		case 5:
			ShowMovie("BeachWalk/Private", 1, 0, 24);
			AddText(coreGame.SlaveMeet + " some girls passionately kissing and caressing each other, very clearly foreplay and very arousing to #slave. ");
			if (coreGame.SlaveFemale) {
				slaveData.DifficultyLesbian--;
				slaveData.AlterSexuality(-2);
				AddText("The girls gesture imploringly at #slave to join them and continue their foreplay. ");
				if (slaveData.VarLibido > 50 || slaveData.Slutiness > 5 || SMData.SMFaith == 2 || coreGame.LesbianTraining || slaveData.Sexuality < 25) AddText("#slave joyfully accepts.");
				else AddText(coreGame.SlaveVerb("feel") + " reluctant, but watching the girls " + coreGame.SlaveHeSheVerb("feel") + " an overwhelming arousal, almost like it floods in from outside. #slave joyfully accepts.");
				if (coreGame.LesbianTraining) Points(0, 2, 0, 0,  SMData.SMFaith == 1 ? -2 : 0, 1, 0, 0, 0, 2, 2, -2, 2, 0, -2, 0, 3, 1, 0, 0);
				else Points(0, 2, 0, 0, SMData.SMFaith == 1 ? -2 : 0, 1, 0, 0, 0, 0, 0, -2, 2, 0, -2, 0, 3, 1, 0, 0);
			} else {
				Points(0, 0, 0, 0, SMData.SMFaith == 1 ? -2 : 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 3, 0, 0, 0, 0, 0);
				AddText("The girls glance at #slave but ignore #slavehimher and passionately have lesbian sex before #slavehisher eyes.");
			}
			return true;
						
		// Tentacle other
		case 7:
			ShowMovie("BeachWalk/Private", 1, 0, 24 + slrandom(2));
			AddText("#slavesee in the distance a woman is being assaulted by tentacle monsters. The woman does not look in distress, in fact she looks happy and clearly orgasms as " + coreGame.SlaveVerb("watch") + ". The creature or creatures cum powerfully into the woman and then gently put her down.\r\r#slave carefully approaches but the creatures are gone. The woman is smiling and moans a little,\r\r");
			PersonSpeak("Woman", "I wish I could cum here every night but it is difficult to get here so early...", true);
			AddText("\r\rThe woman happily doses off, content, tentacle cum pouring from her womb.\r\r");
			return true;
			
		// Tentacle Sex
		case 8:
		case -1:
			SetText("");
			coreGame.TentacleChoice = Math.floor(Math.random()*3);
			coreGame.Tentacles.TentacleSex(9);
			return true;

		}

		return false;
	}

	
			// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
		 // 4302 - walk beach private
		 case 4302:
			ResetWalkEvent();
			WalkAtPrivateArea();
			return true;
		}
		return false;
	}
	
}