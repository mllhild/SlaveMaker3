import Scripts.Classes.*;
// Nun

function MeetNun(Description:String) : Number
{
	var choice:Number = Math.floor(Math.random()*5);
	if (VarMoralityRounded > 49 && AngelsTearOK == 0 && Math.floor(Math.random()*3) == 0) choice = 0;
	
	if (modulesList.MeetPerson(24, choice, "nun", Description)) return;
	if (SlaveGirl.MeetNun(Description, choice) == true) return choice;

	if (choice == 0 && VarMoralityRounded > 49 && AngelsTearOK == 0) MeetNunGiveAngelsTear();
	else if ((choice == 1) && (VarMoralityRounded < 31 || VarNymphomaniaRounded > 74 || Slutiness > 5) && (DemonicPendantOK == 0) && (Slutiness > 0)) MeetNunGiveDemonicPendant();
	else if (choice == 2 && VarMoralityRounded < 16) MeetNunGiveScriptures();
	else if (choice == 3) choice = MeetNunPrayForBlessing();
	else {
		choice = 4;
		MeetNunMiscellaneous(Description);
	}
	
	modulesList.AfterMeetPerson(24, choice, Description);
	return choice;
}

// give Angel's Tear
function MeetNunGiveAngelsTear()
{			
	if (SMData.SMFaith == 2) {
		AddText(SlaveVerb("talk") + " to a nun and recognises an item she is wearing. The nun is a member of the Old Faith! The nun explains how she and a few others are in hiding trying to spread the faith.\r\rThey talk for a time and the nun realises the strength of #slave's faith and gives #slavehimher a sacred chalice 'Torun's Chalice', a relic of a hero of the Old Faith. She instructs #slave to use it as #slavehisher normal drinking cup and it will strengthen #slavehisher body and soul.");
		Items.ShowItem(4, true, 4);
	} else {
		if (Naked) AddText(SlaveVerb("talk") + " about morality with a nun who is wearing little clothing. She explains she is honouring the Lady Ameratsu and compliments the honour #slave is giving as well.");
		else AddText(SlaveVerb("talk") + " about morality with a nun who is wearing little clothing. She explains she is honouring the Lady Ameratsu and #slave removes #slavehisher clothing in respect.");
		AddText("\r\rTo congratulate #slave for being righteous, the nun gives #slavehimher an earring named the 'Angel's Tear'.");
		Items.ShowItem(4, true);
		Sounds.PlaySound("Sounds/Choir.mp3");
	}
	ShowPerson(24, 1, 2, IsDickgirlEvent() ? 4 : 3);
	ShowDress(true, true);
	AngelsTearOK = 1;
}

//Give Demonic Penant
function MeetNunGiveDemonicPendant()
{
	Items.ShowItem(3, true);
	
	var temp2:Number = (Math.floor(Math.random()*2)*6) + 1;
	ShowPerson(24, temp2 == 7 ? 1 : 0, 2, temp2);
	if (temp2 != 7)  ShowDress(false, true);
	
	if (SMData.SMFaith == 2) {
		if (Math.floor(Math.random()*2) == 0) AddText(SlaveMeet + " a nun, but she was kind of strange, speaking oddly and dressed in a kinky way. #slave thought she is a follower of the old gods. You are quite certain she was not, but you are uncertain who she worships, fearing some demonic entity.");
		else AddText(SlaveMeet + " a person dressed as a nun, but she was creepy, speaking seductively and wearing minimal clothes with breasts exposed and pierced. #slave was unsure about the woman and <i>if</i> she was actually a nun, you are certain she is a demon worshipper.");
	} else {
		AddText(SlaveMeet + " a nun, but she was kind of strange, speaking oddly and dressed rather sluttily. Possibly she is a follower of the old gods, a wild and passionate pantheon.");
	}
	if (SlaveGender > 3) AddText("\r\rShe gave #slave a pair of pendants, saying that there is a potential in them. They touch their pendants and feel waves of hot arousal.");
	else AddText("\r\rShe gave #slave a pendant, saying that there is a potential in #slavehimher. Touching the pendant makes #slave feel a wave of hot arousal.");
	if (SMData.SMFaith == 2) AddText(" You believe the pendant will grant demonic visions to the wearer.");
	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
	DemonicPendantOK = 1;
}

// Give Scriptures
function MeetNunGiveScriptures()
{
	ShowPerson(24, 1, 2, 12);
	if (TotalScripture != 0) {
		if (SMData.SMFaith == 2) AddText(SlaveMeet + " a nun who sternly tells #slavehimher that she has not received back the scripture she loaded #slave. She is disapointed that #slave has not studied that scripture yet.");
		else AddText(SlaveMeet + " a nun who says gently that she has not received back the scripture she had loaned #slave. She is disapointed that #slave has not studied that scripture yet.");
	} else {
		if (SMData.SMFaith == 2) AddText(SlaveMeet + " a nun who sternly loans #slavehimher a religious text and almost orders #slavehimher to study it.\r\rYou may ask #slave to read it anytime.");
		else AddText(SlaveMeet + " a nun who loans #slavehimher a religious text to study.\r\rYou may have #slave read it anytime.");
		AddText("\r\rWhen #slave has studied the scripture you will send it back to the nun's temple.");
		TotalScripture++;
		UpdateSlave();
	}
}

// Pray for blessing
function MeetNunPrayForBlessing() : Number
{
	var temp2:Number = Math.floor(Math.random()*2) + 2;
	if (temp2 == 3) ShowPerson(24, 0, 6, temp2);
	else ShowPerson(24, 0, 1, temp2);
	var choice:Number;

	AddText("A nun talks with #slave and offers to pray with #slavehimher to the gods for their blessing.\r\r");
	if (VarMoralityRounded > 49) {
		choice = 3.1;
		Sounds.PlaySound("Sounds/Choir.mp3");
		ShowPerson(34, 1, 1, (Math.random()*2) + 4);
		if (SMData.SMFaith == 2) {
			Points(0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			AddText(SlaveVerb("agree") + ", mainly to not offend the nun. There is a wash of white light and #slave is sure " + SlaveHeShe + NonPlural(" sees") + " an angel! The angel looks at #slave sadly and turns her back on #slave and vanishes.\r\r" + SlaveVerb("feel") + " oddly reassured in #slavehisher faith, even an angel knows of #slavehisher faith!");
		} else {
			AddText("They pray and there is a wash of white light and " + SlaveIs + " sure " + SlaveHeShe + NonPlural(" see") + " an angel!\r\rThe vision fades and " + SlaveName + NonPlural(" feel") + " a wash of peace and strengthened faith in the gods.");
			Points(0, 2, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, -1, 0, -2, 0, 0, 0, 0, 0);
		}
	} else if (VarMoralityRounded > 20) {
		choice = 3.2;
		Points(0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, -1, 0, 0, 0, 0, 0);
		AddText(SlaveName + NonPlural(" agree") + " to pray and stands with the nun and offers prayers ");
		if (SMData.SMFaith == 2) AddText("instead to the old gods, silently to not offend the nun.\r\r#slave is sure #slaveheshe felt a presence while praying.");
		else AddText("to the gods.\r\r" + SlaveIs + " sure #slaveheshe felt a presence while praying.");
	} else {
		choice = 3.3;
		Points(0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		AddText(SlaveIs + " not really interested but ");
		if (Supervise) {
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0);
			AddText("you ask #slavehimher to pray, offering to pray as well. #slave agrees and you both pray to the gods.");
		} else {
			AddText(ServantName);
			if (!SlaveLikeServant) {
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0);
				AddText(" orders #slavehimher to pray as well. Reluctantly " + SlaveName);
			} else {
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0);
				AddText(" asks #slavehimher to pray, offering to pray as well. " + SlaveName);
			}
			AddText(" agrees and they pray to the gods.");
		}
		if (SMData.SMFaith == 2) AddText(" #slave" + NonPlural(" pray") + " silently to the old gods though.");
		AddText("\r\r" + SlaveName + NonPlural(" feel") + " something but does not know what.");
	}
	return choice;
}

// Miscellaneous meeting
function MeetNunMiscellaneous(Description:String)
{
	if (VarMoralityRounded < 21) {
		ShowPerson(24, 0, 0, 2);
		AddText(SlaveMeet + " a nun who was praying so #slaveheshe did not interrupt.");
	} else {
		var temp2:Number = Math.floor(Math.random()*2) + 2;
		if (temp2 == 3) ShowPerson(24, 0, 6, temp2);
		else ShowPerson(24, 0, 1, temp2);

		Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0);
		if (Description.substr(0, SlaveName.length) == SlaveName) AddText(Description);
		else AddText(SlaveName + Description);

		if (Lectures == 0 || Lectures == 2) {
			AddText("\r\rThe nun lectures #slavehimher about the gods and what is moral. The gods gave us sex for procreation and is a private matter between lovers, not strangers. The Goddess of Love and Sex wishes us to enjoy it so she gave us the joy of orgasm. She emphasises modesty and privacy.\r\rThe gods do not approve of slavery but it is not immoral to be a slave.");
			Lectures = Lectures + 1;
		}
	}
	ShowDress(false, true);
}



// Sleazy Bar Owner

function MeetSleazyBarOwner()
{
	var dg:Boolean = IsDickgirlEvent();
	temp = Math.floor(Math.random()*2);
	if (temp == 0) {
		if (VarNymphomaniaRounded >= 50) temp = dg ? 0.1 : 0.2;
	} else if (temp == 1 && (VarObedienceRounded < 40 || DemonicBraOK == 1 || !SlaveFemale)) temp = 1;
	else temp = 2;
																						 
	ShowPerson(26, 0, 0, dg ? 2 : 1);
	
	if (modulesList.MeetPerson(26, choice)) return;
	if (SlaveGirl.MeetSleazyBarOwner(temp) == true) return;

	if (temp < 1) {
        if (temp == 0) {
			ShowDress(false, true);

			DifficultySleazyBar = DifficultySleazyBar - 5;
			Points(1, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			if (TestObedience(DifficultySleazyBar, 112)) {
				if (dg) AddText(SlaveMeet + " a woman, the owner of a sleazy bar and she compliments " + SlaveHisHer + Plural(" figure") + " and personality.\r\r" + SlaveA + " tells her 'I'll look forward to working for you!'.");
            	else AddText(SlaveMeet + " a man, the owner of a sleazy bar and he compliments " + SlaveHisHer + Plural(" figure") + " and personality.\r\r" + SlaveA + " tells him 'I'll look forward to working for you!'.");
			} else {
				if (dg) AddText(SlaveMeet + " a woman, the owner of a sleazy bar and she compliments " + SlaveHisHer + Plural(" figure") + " and personality.\r\rWhen leaving " + SlaveHeShe + NonPlural(" talk") + " to " + SupervisorName + " and it seems the idea of working at the sleazy bar seems more interesting to #slavehimher now.");
				else AddText(SlaveMeet + " a man, the owner of a sleazy bar and he compliments " + SlaveHisHer + Plural(" figure") + " and personality.\r\rWhen leaving " + SlaveHeShe + NonPlural(" talk") + " to " + SupervisorName + " and it seems the idea of working at the sleazy bar seems more interesting to #slavehimher now.");
			}
			SlaveGirl.AfterMeetSleazyBarOwner(0);
        } else {
			if (SMData.SMFaith == 2) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
            else Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			SleazyBarOwner.CustomFlag++;
			TotalBlowjob++;
			UpdateSexActLevels(5);
			XMLData.PerformActNow(-50, "Blowjob", false);
			if (dg) {
				// dickgirl version
				if (BitFlag1.CheckBitFlag(23)) {
					SetText(SlaveMeet + " again the charismatic and sleazy woman. ");
					if (Supervise) AddText("You feel uncertain, not really trusting the woman for some reason. The woman talks to you, whispering odd, seductive words and you feel a bit tired and decide to sit down for a while. You doze off a little, not really aware of what happens.");
					else AddText("#assistant looks wary and a little angry. The woman talks to " + ServantHimHer + ", who looks a bit tired and sits down.");
				} else {
					SetText(SlaveMeet + " a charismatic but somehow sleazy woman. ");
					if (Supervise) AddText("She privately speaks to you suggesting she can help educate #slave. You are a little uncertain but she whispers strange words and caresses your cheek. You now feel the woman should be allowed to help your slave, as you trust her. The woman suggests you leave them alone for a little while so she can concentrate on teaching #slave and you of course agree.");
					else AddText("She privately speaks to #assistant who looks a little odd and leaves explaining " + ServantHeShe + " will return in a little while.");
					BitFlag1.SetBitFlag(23);
				}
				AddText("\r\rThe woman politely explains that she is a hermaphrodite and asks #slave to give her a blowjob, ");
				if (TestObedience(DifficultyBlowjob, 5)) AddText("and " + SlaveHeShe + NonPlural(" agree") + " as the woman seems so very attractive.");
				else AddText("but " + SlaveIs + " very reluctant. The woman speaks skillfully, whispering words #slave can barely hear. #slave suddenly " + NonPlural("change") + " " + SlaveHisHer + Plural(" mind") + " and " + NonPlural("agree") + ".");
				AddText("\r\r" + SlaveHas + " difficulty trying to make her cum, despite the reputation of hermaphrodites and their libido. Her cock is large and hard but she seems to be expertly holding herself back.\r\r#slave licks, sucks her for many minutes, also working fingers in the woman's pussy. The woman finally gasps and grabs #slave's head, holding #slavehisher mouth over her cock and unloads spurt after spurt of hot cum into #slave's mouth. She moans and mutters in a strange language, finally pulling her semi-hard cock free of #slave's cum filled mouth, whispering 'swallow'. Despite #slavehimherself #slave swallows all of her hot, hot cum.\r\r");
				AddText("When she recovers and rearranges her clothes, she");
			} else {
				// male only
				if (BitFlag1.CheckBitFlag(22)) {
					SetText("#slave again meets the charismatic and sleazy man. ");
					if (Supervise) AddText("You feel uncertain, not really trusting him for some reason. The man stares at you, very intently, and you feel a bit tired and decide to sit down for a while. You doze off a little, not really aware of what happens.");
					else AddText("#assistant looks wary and a little angry. The man talks to " + ServantHimHer + ", who looks a bit tired and sits down.");
				} else {
					SetText(SlaveMeet + " a charismatic but somehow sleazy man. ");
					if (Supervise) AddText("He privately speaks to you suggesting he can help educate #slave. You are a little uncertain but looks, almost stares, at you intently. You now feel the man should be allowed to help your slave, as you trust him. The man suggests you leave them alone for a little while so he can concentrate on teaching #slave and you of course agree.");
					AddText("He privately speaks to #assistant who looks a little odd and leaves explaining " + ServantHeShe + " will return in a little while.");
					BitFlag1.SetBitFlag(22);
				}
				AddText("\r\rThe man politely asks #slave to give him a blowjob, ");
				if (TestObedience(DifficultyBlowjob, 5)) AddText("and " + SlaveHeShe + NonPlural(" agree") + " as he seems so very attractive.");
				else AddText("but " + SlaveIs + " very reluctant. The man skillfully speaks and whispers words #slave can barely hear. #slave suddenly " + NonPlural("change") + " " + SlaveHisHer + Plural(" mind") + " and " + NonPlural("agree") + ".");
				AddText("\r\r#slave has difficulty trying to make him cum. His cock is large and hard but he seems to be holding himself back. #slave licks and sucks him for many, many minutes until he gasps and grabs #slavehisher head.\r\rHe holds #slavehisher mouth over his cock and unloads spurt after spurt into #slavehisher mouth. He gasps and mutters in a strange language and finally pulls his softening cock free of #slavehisher cum filled mouth, whispering 'swallow'. Despite #slavehimherself #slave swallows all of his hot, hot cum.\r\r");
				AddText("When he recovers and rearranges his clothes, he");
			}
			AddText(" politely thanks #slave and gives #slavehimher a strange pill in gratitude.\r\r");
			if (Supervise) AddText("Shortly later you rejoin them feeling a little confused and decide it is best to leave, now. You examine the pill but it is totally unknown to you.");
			else AddText("Shortly later " + SlaveIs + " aware of #assistant who seems a little confused and insists they return to you. You examine the pill but it is totally unknown to you.");
			AddText("\r\r<i>The odd pill can now be used whenever you wish, choose the 'Drink Potion' option in your slave's equipment.</i>");
			SMData.ChangePotionOwned(11, SlaveGender > 3 ? 2 : 1);
			SlaveGirl.AfterMeetSleazyBarOwner(dg ? 0.1 : 0.2);
        }
	} else {
		ShowDress(false, true);

		if (temp == 1) {
            Points(2, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
            if (dg) AddText(SlaveMeet + " a woman, the owner of a sleazy bar who compliments #slavehisher beauty and tries to convince #slavehimher to work at her bar.");
			else AddText(SlaveMeet + " a man, the owner of a sleazy bar who compliments #slavehisher beauty and tries to convince #slavehimher to work at his bar.");
			DifficultySleazyBar = DifficultySleazyBar - 1;
			if (TestObedience(DifficultySleazyBar, 112)) AddText("\r\r#slave replies 'Sure anytime!'");
			else AddText("\r\r#slave seems reluctant still.");
			SlaveGirl.AfterMeetSleazyBarOwner(1);
        } else {
			if (dg) {
				AddText(SlaveMeet + " a woman, the owner of a sleazy bar and they talk about working in the bar.\r\rShe gives #slavehimher " + Plural("a strange and skimpy bra") + ", explaining that her customers like girls who wear these types of bras.\r\r");
				if (Supervise) AddText("When you examine it ");
				else AddText("#assistant does not trust her or the bra. When you examine it ");
			} else {
				AddText(SlaveMeet + " a man, the owner of a sleazy bar and they talk about working in the bar.\r\rHe gives #slavehimher " + Plural("a strange and skimpy bra") + ", explaining that his customers like girls who wear these types of bras.\r\r");
				if (Supervise) AddText("When you examine it ");
				else AddText("#assistant does not trust him or the bra. When you examine it ");
			}
			if (SMData.SMFaith == 2) AddText("you feel this thing is probably of hellish origin.");
			else if (SMData.SMSpecialEvent == 5 || SMData.SMSpecialEvent == 6) {
				AddText("you feel a strange feeling and your cock becomes intensely erect. In a slight daze you have #slave immediately wear the bra.");
				DemonicBraWorn = 1;
			} else if (SMData.Gender != 1) AddText("you feel a wave of arousal as you touch it.");
			else AddText("you see the bra is of a very exotic origin but little more.");
            DemonicBraOK = 1;
			DifficultySleazyBar = 0;
			Items.ShowItem(5, true);
			SlaveGirl.AfterMeetSleazyBarOwner(2);
        }
	}
	modulesList.AfterMeetPerson(26, temp);
	SleazyBarOwner.SetMet();
}


// Odd Teacher

function MeetOddTeacher(place:Number, say:String) : Boolean
{
	var choice:Number = 2;
	if (BitFlag1.CheckBitFlag(20) && SMData.BitFlagSM.CheckBitFlag(4)) choice = 0;
	else if (BitFlag1.CheckBitFlag(18)) choice = 1;
	
	if (modulesList.MeetPerson(29, choice)) return;
		
	if (choice == 0) {
		modulesList.GetTraining("Masochist").AskToStartTraining();
		SlaveGirl.AfterMeetOddTeacher(place, 0);
		modulesList.AfterMeetPerson(29, 0);
		return true;
	} else if (choice == 1) {
		modulesList.GetTraining("Masochist").Training(place);
		SlaveGirl.AfterMeetOddTeacher(place, 1);
		modulesList.AfterMeetPerson(29, 1);
		return true;
	}
	
	// general meeting
	AddText(SlaveMeet + " ");
	if (LadyFarun.CheckBitFlag(68)) AddText("the Private Tutor of Discipline again");
	else if (BitFlag1.CheckBitFlag(24)) AddText("the odd Private Tutor again");
	else AddText("a woman calling herself a Private Tutor, but not of what or who,");

	AddText(" " + say);
	ShowPerson(29, 0, 5);
	BitFlag1.SetBitFlag(24);
	SlaveGirl.AfterMeetOddTeacher(place, 2);
	modulesList.AfterMeetPerson(29, 2);
	return false;
}


// XXX Owner

function MeetXXXSchoolOwner()
{
	ShowPerson(31, 1, 13, 2);
	ShowDress(true, false);
    MaxFuck++;
    MaxBlowJob++;
    temp = Math.floor(Math.random() * 3);
	if (modulesList.MeetPerson(31, temp)) return;
    if (SlaveGirl.MeetXXXSchoolOwner(temp) == true) return;

    if (temp == 0) {
        if (VarMoralityRounded > 20) {
            if (SMData.SMFaith == 2) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 5, 0, 0, 0, 0, 0);
			else Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 0, 5, 0, 5, 0, 0, 0, 0, 0);
            AddText(SlaveMeet + " the owner of the XXX School and they talk about their sexual experiences. " + SlaveIs + " amazed at the variety of partners the woman talks about.");
            if (Lectures == 0 || Lectures == 1) {
                AddText("\r\rThe woman complains about the hypocrisy of the gods and morality. About how joyous love between women is wrong and how it is wrong to enjoy being fucked when tied.");
                if (TentaclesOn) AddText(" Also how the god of nature created tentacle beasts who mate with us to breed. And how they produce one of the strongest aphrodisiacs, but the gods say it is wrong to have sex with them.");
                Lectures = Lectures + 2;
				Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            }
        } else {
			ShowPerson(31, 0, 0, 1);
            AddText(SlaveMeet + " the owner of the XXX School who loans #slavehimher a book of the Kamasutra to broaden #slavehisher knowledge of sexual techniques.\r\rYou can have #slave read it when you wish to order #slavehimher to.\r\rWhen #slave finishes reading it you will send the book back to the owner of the XXX school.");
			if (IsDickgirlEvent()) AutoLoadImageAndShowMovie("Images/Events/Walk - Kamasutra (Dickgirl 1).jpg", 1.1, 2);
			else AutoLoadImageAndShowMovie("Images/Events/Walk - Kamasutra " + (Math.floor(Math.random() * 3) + 1) + ".jpg", 1.1, 2);
			TotalKamasutra++;
			UpdateSlave();
        }
    }
    else if (temp == 1) {
        if (VarMoralityRounded < 35 && VibratorPantiesOK != 1) {
            AddText(SlaveMeet + " the owner of the XXX School who talks about how things are clearer and more enjoyable when you are aroused, and she gives #slave " + Plural("a vibrator panty") + ".\r\rThis is a vibrating phallus set inside a leather panty, locked in place and is designed to stimulate and arouse the wearer. It can be adjusted for various levels but normally it is set to bring the wearer to just short of orgasm.\r\rThe woman lifts her dress and shows #slave the set she is wearing...");
            VibratorPantiesOK = 1;
			Items.ShowItem(6, true);
        } else {
			if (SMData.SMFaith == 2) Points(0, 0, 0, 0, -3, 0, 0, 0, 0, 0, 0, 0, 5, 0, 5, 0, 0, 0, 0, 0);
            else Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 0, 5, 0, 5, 0, 0, 0, 0, 0);
            AddText(SlaveMeet + " the owner of the XXX School who describes how the feeling of sexual arousal is marvelous and how you can be aroused all day if you try. The teacher shows #slave by masturbating them both almost to orgasm several times while getting #slave to describe a sexual fantasy.");
        }
    }
	else if (VarMoralityRounded > 15 && VarNymphomaniaRounded < 50) {
        Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 5, 0, 0, 0, 0, 0);
        AddText(SlaveMeet + " the owner of the XXX School who asks #slavehimher about #slavehisher best sexual experience. The teacher insists that #slave masturbate while describing it. As " + SlaveHeShe + NonPlural(" near") + " orgasm the teacher stops #slavehimher and ends their talk, to #slave's frustration.");
    } else {
        Backgrounds.ShowPalace();
		if (SMData.SMFaith == 2) Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 5, 5, 0, 2, 0, 0, 0, 0, 0, 0, 0);
        else Points(0, 0, 0, 0, -2, 0, 0, 0, 0, 5, 5, 0, 2, 0, 0, 0, 0, 0, 0, 0);
        AddText(SlaveMeet + " the owner of the XXX School who takes #slave into a room of a discrete building near the Palace to be used as " + Plural("a model") + " for her school.\r\r" + SlaveIs + " used to demonstrate a number of sexual techniques. Each time a demonstration is finished the teacher makes #slave cum to a huge orgasm.");
    }
	SlaveGirl.AfterMeetXXXSchoolOwner(temp);
	modulesList.AfterMeetPerson(31, temp);
}
