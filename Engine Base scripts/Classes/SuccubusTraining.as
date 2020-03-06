// Succubus training
//
// Translation status: IMCOMPLETE

// BitFlags
// Flag1
//  18  = Odd teacher agreement

import Scripts.Classes.*;

class SuccubusTraining extends TrainingBase
{
	public function SuccubusTraining(cgm:Object)
	{
		super(null, cgm);
		ModuleName = "SuccubusTraining";
	}
	
	
	// Slave Training

	
	public function AskToStartTraining(say:String)
	{
		slaveData.DemonFlags.SetBitFlag(0);
		ShowPerson(33, 1, 1, 12);
		SetText("#slaveis walking naked in the town center, her demon tail curling and waving. People are looking at #slavehimher, scandalised at her demonic tail, but some are flushed and aroused.\r\rA figure waves to #slavehimher from a small alley, a girl with large red demonic wings and a demonic tail. #slave walks into the alley, and the girl looks at #slavehimher lustfully, slowly masturbating,\r\r");
		PersonSpeak(33, "Lovely, truly lovely tail, and ass. Mmmmm But you do not have any wings, you are not a demon yet but really you need wings. Ahhhhh", true);
		AddText("\r\rThe demon girl cries out and orgasms, pussy juice squirting from her pussy but she catches most of it cupped in one of her hands. She stands and offers her hand and the juice to #slave.\r\r");
		PersonSpeak(33, "Demons gain power from <i>our</i> orgasms and can share it with others. Drink, and start the path to true enlightenment and freedom.", true);
		AddText("\r\rDoes #slave drink?\r");
		DoYesNoEventXY(5040)
	}
	
	/* unused
	public function StartTraining(type:Number)
	{
		if (coreGame.IsSuccubusTraining() || coreGame.slSuccubusTraining < 0) return;
		if (type != undefined) coreGame.slSuccubusTraining += type;
		else coreGame.slSuccubusTraining = 1;
		if (coreGame.slSuccubusTraining > 100) coreGame.slSuccubusTraining = 100;
		var succubusindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("SuccubusTraining", "Skills"));
		coreGame.arSkillArray[succubusindex].PlusIcon._visible = true;
		coreGame.UpdateBasicSlaveSkills();
	}
		
	public function FinishedTraining()
	{
		if (!coreGame.IsSuccubusTraining()) return;
		coreGame.slSuccubusTraining = 2000;
		var succubusindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("SuccubusTraining", "Skills"));
		coreGame.arSkillArray[succubusindex].PlusIcon._visible = true;
		coreGame.UpdateBasicSlaveSkills();
	}
	*/
	
	public function Training(place:Number)
	{
		ShowPlanningNext();
		
		var plc:Place = coreGame.currentCity.GetPlaceInstance(place);
		coreGame.genString2 = Language.XMLData.GetXMLString("Name", coreGame.currentCity.FindPlaceNodeCByName(plc.strNodeName)).toLowerCase();
		trace("WingQuest: " + coreGame.genString2);
		
		coreGame.PersonGender = IsDickgirlEvent() ? 3 : slrandom(2);
		switch(coreGame.PersonGender) {
			case 1: 
				SetText("A man approaches #slave, looking angry and aroused and starts to lecture #slave on the immorality of walking around pretending to be a demon.");
				break;
			case 2: 
				SetText("A woman approaches #slave, looking embarrassed and tells #slave that it is inappropriate to walk around naked and looking like a demon.");
				break;
			case 3: 
				SetText("A woman approaches #slave, a clear bulge in her groin. The aroused hermaphrodite tells #slave that #slaveheshe is inviting trouble walking around like that.");
				break;
		}
		ShowSupervisor();

		if (!PercentChance(slaveData.slSeduction + 20)) {
			// Failed!
			Language.SaveText();
			coreGame.SlaveGirl.ShowPropositionRefused();
			Language.RestoreText();
			AddText("\r\r#slave tries to explain but they refuse to listen to #slavehimher. The person leaves #slave feeling frustrated, realising #slaveheshe needs to learn more about seduction.");
			Points(0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0);
			slaveData.ChangeSeduction(3);
			return;
		}
		
		// Success!
		Diary.AddEntry("#slave seduced a person at the #generalstring2");
		Language.SaveText();
		coreGame.SlaveGirl.ShowPropositionAccepted();
		Language.RestoreText();		
		Points(0, 0, -2, 0, -2, 2, 0, 0, 1, 1, 1, 1, 2, 0, 2, 0, 3, 0, 0, 0);
		AddText("\r\r#slave smiles and explains seductively about how free and enjoyable it is. #slave leans in and kisses the person, lightly at first. They do not resist and return the kiss with passion.\r\rThen and there they have passionate sex, watched by all the other passers by.");
		slaveData.ChangeSeduction(5);
		slaveData.DemonFlags.SetBitFlag(int(place));
		trace("Set " + int(place));
		
		// all done?
		for (var so:String in coreGame.currentCity.arPlaces) {
			plc = coreGame.currentCity.arPlaces[so];
			trace("..checking place: " + plc.strNodeName);
			if (coreGame.currentCity.FindPlaceNodeByName(plc.strNodeName).attributes.wingquest == "false") continue;
			trace("..valid place " + plc.Id);
			if (!slaveData.DemonFlags.CheckBitFlag(int(plc.Id))) return;
		}
		trace("done!");
		AddText("\r\rAs #slave leaves #slaveheshe feels <b>something</b>...");
		DoEvent("WingComplete", this);
	}
	
	public function WingComplete()
	{
		// COMPLETE!
		coreGame.HideImages();
		slaveData.DemonFlags.ClearBitFlag(32);
		slaveData.BitFlag1.SetBitFlag(50);
		AddText("#slave feels a rush of heat in #slavehisher back and screams in ecstasy as a pair of demonic wings erupt from #slavehisher back.\r\r#slaveis aware of a strange insight, that the wings can appear and disappear at will, and can vary in appearance as desired.\r\r#slave leaves with a new confidence and lust swelling in #slavehisher heart.");
		Points(2, 0, 0, 0, -4, 0, 0, 0, 0, 0, 0, 5, 5, 0, 5, 0, 0, 0, 0, 0);
		Diary.AddEntry("#slave has demon wings!");
		
		coreGame.ShowDress();
		Backgrounds.ShowCurrentPlace();
	}
	
	
	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		if (sd == undefined) sd == coreGame;
		return sd.slSuccubusTraining > 0;
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) sd == coreGame;
		return sd.slSuccubusTraining == 2000;
	}
	
	public function ChangeTraining(val:Number, sd:Slave)
	{
		if (sd == undefined) sd == coreGame;
		sd.ChangeSuccubusTraining(val);
	}
	
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
				
			// 5040 - Drink
			 case 5040:
				Diary.AddEntry("Started seduction quest for demon wings");
				slaveData.DemonFlags.SetBitFlag(31);
				slaveData.ChangeSeduction(5 + int(coreGame.VarConversation / 10) + int(coreGame.VarNymphomania / 10));
				SetText("#slave drinks and feels a rush of heat and lust flood through #slavehisher body. The demon girl whispers to #slavehimher,\r\r");
				PersonSpeak(33, "Good, now prove yourself and the wings are yours. Do as you did today, but walk everywhere, naked and show your tail. Seduce the first person who speaks to you and build your power.\r\rYou need only visit some places like the Docks once, not all the places there. Once you have seduced and flaunted your nature, the wings will be yours.", true);
				AddText("\r\rThe demon girl walks into the shadows in the alley and disappears from sight.");
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
			// 5040 - do not drink
			 case 5040:
				Diary.AddEntry("Refused offer for demon wings");
				SetText("The demon girl looks disappointed, and gestures with her other hand. A man steps out of the shadows, he looks a little dazed and is completely naked, his cock hanging limp. He eagerly licks and drinks from the demon girl's hand, and his cock springs erect. The girl bends a little and the man starts fucking her. The demon girl gestures at #slave and #slave's demon tail vanishes. The demon girl sighs,\r\r");
				PersonSpeak(33, "Mmmmm if you do not want to be one with me, then you do not need the tail. Ohhhh look what you are missing, my power can keep him erect and eager for as long as I want, and I always want!", true);
				AddText("\r\rThe shadows shift and the demon girl and the man disappear into darkness.");
				slaveData.BitFlag1.ClearBitFlag(46);
				return true;
		}
		return false;
	}



}

