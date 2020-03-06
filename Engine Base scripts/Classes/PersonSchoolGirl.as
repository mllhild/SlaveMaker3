// PersonSchoolGirl - Snow, the school girl
// number 19
// lend modifier n/a
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonSchoolGirl extends Person {
		
	public function PersonSchoolGirl(cg:Object, cc:Object) { 
		super("SchoolGirl", cg, 19, 0, false, cc);
	}
	
	// Meet her
	public function Meeting(meet:Number) : Boolean
	{
		if (!super.Meeting(sd.VarSchoolGirl)) return false;
		if (coreGame.SlaveGirl.MeetSchoolGirl() == true) return true;
		
		HidePeople();
		BlankLine();
		if ((sd.VarSchoolGirl == 0.1 && sd.VarConversationRounded < 40) || sd.VarSchoolGirl == 0) {
			ShowThem(0, 0, 1);
			if (sd.VarSchoolGirl == 0) AddText(coreGame.SlaveSee + " a girl in the class who seems quite bright. After class, she is very friendly and many students talk to her.\r\rShe even introduces herself to #slave as Snow, with a little laugh, explaining her parents are odd and choose funny names. She offers to help #slave anytime if " + coreGame.SlaveHeSheHas + " problems understanding the work.");
			else AddText("#slave briefly " + NonPlural("talk") + " with the girl Snow about the class. She is friendly and kind but a bit aloof.");
			sd.Points(0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			sd.VarSchoolGirl = 0.1;
			return true;
		}
		
		switch (Math.floor(sd.VarSchoolGirl)) {
			case 0:
				sd.Points(0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0); 
				sd.VarSchoolGirl = 1;
				ShowThem(0, 0, 3);
				AddText(coreGame.SlaveName + NonPlural(" talk") + " more to the girl Snow. She finally gets the girl to talk about some personal things, but Snow looks a bit upset when she realises she had opened up. #slave is surprised at her burst of anger, and apologises. Snow calms down and apologises too, and they have a pleasant chat, but a bit more reserved.");
				break
			case 1:
				ShowThem(0, 0, 1);
				sd.Points(0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);	
				AddText(coreGame.SlaveName + NonPlural(" chats") + " pleasantly with the girl Snow, mainly complaining in a friendly way about family and friends. Snow carefully avoids any talk about slavery and #slave's training.");
				if (sd.VarConversation > 50) sd.VarSchoolGirl++;
				break;
			case 2:
				if (sd.TotalSleazyBar < 0) {
					ShowThem(0, 0, 1);
					AddText("While talking to Snow, #slave realises she is hiding a lot, she makes odd references to things and #slaveheshe" + NonPlural(" realise") + " Snow may not be the nice, good student she appears to be");
					AddText(" but #slaveheshe cannot quite pin her down or convince her to talk more.");
				} else {
					ShowThem(0, 0, 2);
					PerformActNow(-50, "Lick", true);
					AddText("While talking to Snow, #slave realises she is hiding a lot, she makes odd references to things and #slaveheshe" + NonPlural(" realise") + " Snow may not be the nice, good student she appears to be");
					AddText(" and #slaveheshe" + NonPlural(" remember") + " seeing a girl while working in the sleazy bar. She was partying very enthusiastically with some people, drinking, and dancing. #slave once saw her moaning as someone under the table was clearly licking her pussy.\r\r#slave confronts Snow, who looks surprised, but also a little relieved, and happily confesses to loving to party. She talks about how her family is a little odd, but strongly wants her to succeed at everything. They want her to train, to study, but partying is discouraged. Snow often sneaks out on a pretense and indulges in her enjoyment of parties, men, women, whoever.\r\rShe asks #slave to join her in a back room for a private chat, and they step out. In the room Snow sits down on a table and asks #slave to do the same. A moment later some other female students join them and kneel in front of them. Snow removes her skirt and panties and the girl enthusiastically licks her pussy. #slave" + NonPlural(" feel") + " the other girl ");
					if (sd.SlaveGender > 3) {
						if (!Naked) AddText("remove their underwear and starts licking their ");
						if (sd.HasCock) AddText("cocks");
						else AddText("pussies");
						AddText(", alternating between them");
					} else {
						if (!Naked) AddText("remove #slavehisher underwear and starts licking her ");
						if (sd.HasCock) AddText("cock");
						else AddText("pussy");
					}
					AddText(". Snow groans and comments about it is a perk of being helpful...");
					AskHerQuestions(34, 35, 0, 0, "Let the girl lick #slavehimher", "Refuse", "", "", "What does #slave do?");
				}
				break;
			case 3:
				ShowThem(0, 0, 1);
				AddText(SlaveVerb("start") + " to talk to Snow, but she politely says,\r\r");
				PersonSpeak(Id, "Join me in the backroom and we can talk there...", true);
				AddText("\r\rand she steps out with two fellow, female, students.\r");
				AskHerQuestions(36, 37, 0, 0, "Join her", "Refuse", "", "", "What does #slave do?");
				break;
			case 4:
				ShowThem(0, 0, 4);
				AddText(SlaveVerb("talk") + " to Snow, about class, and her experiences and adventures in the night life of Mioya.\r\rAfter a time Snow invites #slave to attend a club meeting and walks to the backroom. " + NameCase(NonPlural("does")) + " #slave join her?\r");
				DoYesNoEvent(36);
				break
	
		}
		coreGame.modulesList.AfterMeetPerson(Id, sd.VarSchoolGirl);
		coreGame.SlaveGirl.AfterMeetSchoolGirl();
		return true;
	}

	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
		// school girl - lick
		case 34:
			coreGame.HideSlaveActions();
			PerformActNow(-50, "Lick", true);
			if (SMData.SMFaith == 1) sd.Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 1, 0, 0, 0);
			else sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 1, 0, 0, 0);
			if (sd.HasCock) SetText(SlaveVerb("close") + " #slavehisher eyes and the girl expertly sucks and licks #slavehisher cock, making #slavehisher cum very quickly. The girl pulls away and most of #slaves cum spatters over her face. She wipes it away with a smile.");
			else SetText(SlaveVerb("close") + " #slavehisher eyes and the girl expertly licks her pussy and clit, bringing her quickly to orgasm.");
			AddText("\r\rAfter, Snow welcomes #slavehimher to the club...");
			sd.VarSchoolGirl = 4; 
			return true;
			
		// school girl - refuse
		case 35:
			if (SMData.SMFaith == 1) sd.Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			SetText("#slave shy's away, refusing the girl. Snow looks disappointed and closes her eyes as the girl licks her.\r\r#slave" + NonPlural(" leave") + " class before Snow returns.");
			sd.VarSchoolGirl = 3;
			return true;
			
		// club - lick later/club meeting
		case 36:
			ShowThem(0, 0, 2);
			coreGame.HideSlaveActions();
			PerformActNow(-50, "Lick", true);
			if (SMData.SMFaith == 1) sd.Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 1, 0, 0, 0);
			else sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 1, 0, 0, 0);
			SetText(SlaveVerb("join") + " Snow in the back room and Snow sits down on a table and asks #slave to do the same.The two other girls kneel in front of them and Snow removes her skirt and panties and the girl enthusiastically licks her pussy. #slave feels the other girl ");
			if (!Naked) AddText("remove #slavehisher underwear and starts licking #slavehisher");
			if (sd.HasCock) AddText(" cock");
			else AddText(" pussy");
			AddText(". Snow groans and comments about it is a perk of being helpful...\r\r");
			if (sd.HasCock) AddText(SlaveVerb("close") + " #slavehisher eyes and the girl expertly sucks and licks #slavehisher cock, making #slavehimher cum very quickly. The girl pulls away and most of #slaves cum spatters over her face. She wipes it away with a smile.");
			else AddText(SlaveVerb("close") + " #slavehisher eyes and the girl expertly licks her pussy and clit, bringing her quickly to orgasm.");
			if (sd.VarSchoolGirl != 4) AddText("\r\rAfter, Snow welcomes #slavehimher to the club...");
			sd.VarSchoolGirl = 4; 
			return true;
			
		// club refuse
		case 37:
			if (SMData.SMFaith == 1) sd.Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
			if (sd.SlaveGender > 3) SetText("#slave shy");
			else SetText("#slave shy's");
			AddText("away, refusing the girl. Snow looks disappointed and leaves.\r\r#slave" + NonPlural(" leave") + " class before Snow returns.");
			sd.VarSchoolGirl = 3;
			return true;
				
		}
		return false;
	}

}