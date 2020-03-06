import Scripts.Classes.*;

// Ending

var NumFin:Number;
var OldNumFin:Number;
var Score:Number;

function TrainingComplete(fulltime:Boolean, fin:Number)
{
	trace("TrainingComplete: " + fulltime + " " + fin);
	UpdateSlave();
	slaveData.CopyCommonDetails(_root, slaveData);
	SlaveData = slaveData;		// TODO remove
	Score = slaveData.CalculateTotalScore();
	Pay = slaveData.CalculateValue(Score);
	ExperienceTotal(true);
	ClearGeneralArray();
	
	StopPlanning(false);
	if (fulltime != true) {
		if (SMData.GuildMember) {
			if (GameDate < (TrainingTime + TrainingStart - 1)) {
				if (Elapsed > (TrainingTime * 0.8)) {
					SMData.SkillPoints++;
					trace("..got skill point");
				}
				Diary.AddEntryLang("CompletedTrainingEarly", false, 0, false, 2);
			} else {
				Diary.AddEntryLang("CompletedTraining", false, 0, false, 2);
				SMData.SkillPoints++;
			}
		} else {
			if (Elapsed > 40 && Score > 50) {
				SMData.SkillPoints++;
				trace("..got skill point");
			}
			Diary.AddEntryLang("CompletedTraining", false, 0, false, 2);
		}
	} else {
		Diary.AddEntryLang("CompletedTraining", false, 0, false, 2);
		SMData.SkillPoints++;
	}
	SMData.GirlsTrained++;
	trace("..total girls trained: " + SMData.GirlsTrained);
	// basic slave type change, can alter later in the ending process
	slaveData.SlaveType = 1;

	EndGame.ViewDialog();
	
	// Custom ending
	if (fin != undefined && fin != 0) {
		NumFin = fin;
		DoEndingNext();
		return;
	}
	
	// Special Cowgirl Ending
	if (slaveData.MilkInfluence > 0 && slaveData.MilkInfluence < 1000 && slaveData.TotalMilked >= 6) {
		NumFin = 21;
		SlaveGirl.ShowMilkAccident();
		XMLData.XMLGeneral("EndGame/Slave/EndingStolenCowgirl/TrainingComplete");
		return;
	}
	
	// Standard Ending process
	NumFin = 0;
	ClipTrainingComplete._visible = true;
	
	if (Owner.IsPersonallyOwned() || Owner.IsUnowned()) FreelancerEndTrainingStart();
	else GuildMemberEndTrainingStart();
}

function GuildMemberEndTrainingStart()
{
	if (GameDate < (TrainingTime + TrainingStart)) AddText("You have decided that #slave's training is complete and you sent a messenger to #slavehisher owner."); 
	else if (GameDate > (TrainingTime + TrainingStart)) AddText("You have exceeded your allocated time to train #slave. You know you will be penalised but it was unavoidable."); 
	else AddText("The training of #slave is over, the agreed date has arrived.");
	if (modulesList.ShowTrainingComplete()) return;
	
	AddText("\r\rA delegation from #slavehisher new owner has arrived to take possession of #slavehimher and start to securely bind #slavehimher for transport.");
	if (LoveAccepted == 1 || LoveAccepted == 10) {
		AddText(" You see #slave looking at you with tears in #slavehisher eyes and you remember #slavehisher confession of love ");
		if (LoveAccepted == 1) AddText("and your mutual feelings for #slavehimher. You are torn but feel honour bound to send #slavehimher away.");
		else AddText("and you are sorry but you cannot fall in love with your slaves. Your honour demands you send #slavehimher away.");
	}
	AddText("\r\rThe servants leave you for a bit to arrange their carriage and #slave talks to you,\r\r");
	SlaveSpeakStart("", true);
	if (LoveAccepted == 1 || LoveAccepted == 10) AddText("#slavemakername #slavepronoun do still love you, always remember that!\r\r");
	modulesList.trainLesbians.ShowEndingLesbianSlave();
	
	SlaveSpeakEnd("You have had " + (SlaveGender > 3 ? "us" : "me") + " do many things,");
	if (IsNoAssistant()) AddText("\r\rYou are aware that #slaveheshe has done a total of " + SlaveExperience + " different things, out of a total of " + SlaveActs + ". This includes owning some items, and taking some potions.\r\r");
	else AddText("\r\r#assistant says that #slaveheshe has done a total of " + SlaveExperience + " different things, out of a total of " + SlaveActs + ". This includes owning some items, and taking some potions.\r\r");
	if (SlaveExperience < SlaveActs) SlaveSpeakStart("One thing, you had never had " + (SlaveGender > 3 ? "us" : "me") + " " + GetMissingExperience() + ".");
	
	// Check for Meta Endings
	if (CheckMetaEndings()) return;
	
	GuildMemberEndTrainingEnd();
}

function GuildMemberEndTrainingEnd()
{
	if (!Language.bSpeaking) SlaveSpeakStart("");
	SlaveSpeakEnd("Well, I am sorry to leave you, goodbye for now...");
	AddText("\r\rThe servants return, gag #slave and take #slavehimher to #slavehisher new owner.\r\r");
	if (SMData.GuildMember) AddText("You will visit in a week to finalise payment and review your training with a member of the Slave Maker Guild...");
	else AddText("You will visit in a week to finalise payment and review your training of #slave...");
}

function FreelancerEndTrainingStart()
{
	if (Owner.IsPersonallyOwned()) AddText("You have decided that #slave's training is complete and you are #slavehisher owner."); 
	else AddText("You have decided that #slave's training is complete but you have not found an owner for #slavehimher."); 
	UseGeneric = false;
	if (modulesList.ShowTrainingComplete()) return;

	if (LoveAccepted == 1 || LoveAccepted == 10) {
		AddText("\r\rYou see #slave looking at you with tears in #slavehisher eyes and you remember #slavehisher confession of love ");
		if (LoveAccepted == 1) AddText("and your mutual feelings for #slavehimher. You are torn as you can see #slave believes you will now sell #slavehimher.");
		else AddText("and you can see #slave believes you will now sell #slavehimher.");
	}
	AddText("\r\rBefore you can discuss #slavehisher future #slave talks to you,\r\r");
	SlaveSpeakStart("", true);
	if (LoveAccepted == 1 || LoveAccepted == 10) AddText("#slavemakername #slavepronoun do still love you, always remember that!\r\r");
	modulesList.trainLesbians.ShowEndingLesbianSlave();
	SlaveSpeakEnd("You have had " + (SlaveGender > 3 ? "us" : "me") + " do many things,");
	AddText("\r\r#assistant says that #slaveheshe has done a total of " + SlaveExperience + " different things, out of a total of " + SlaveActs + ". This includes owning some items, and taking some potions.\r\r");
	if (SlaveExperience < SlaveActs) SlaveSpeakStart("One thing, you had never had " + (SlaveGender > 3 ? "us" : "me") + " " + GetMissingExperience() + ".", true);
	
	// Check for Meta Endings
	if (CheckMetaEndings()) return;

	FreelancerEndTrainingEnd(false);
}

function FreelancerEndTrainingEnd(bMeta:Boolean)
{
	if (Language.bSpeaking) {
		SlaveSpeakEnd(" Thank you!");
		BlankLine();
	}
	var numc:Number = modulesList.NumCustomEndings();
	if (numc > 0) {
		trace("FreelancerEndTrainingEnd1: " + NumFin);
		modulesList.EndingStart();
		trace("FreelancerEndTrainingEnd1a: " + NumFin);
		if (NumFin != 0) {
			trace("FreelancerEndTrainingEnd2: " + NumFin);
			EndGame.HideEndings();
			ClipTrainingComplete._visible = true;
			if (!bMeta) {
				NumFin = 0;
				EndGame.ShowEndingNext();
				return;
			} else {
				NumFin = 0;
				DoEndingNext();
				return;
			}
		}
	}
	
	AddText("You must now either sell #slave in an open auction or just keep #slave as your own personal slave. You are aware that a sale in an open auction may not give a very high price.");
	ResetQuestions();
	AddQuestion(25, "Sell #slavehimher at auction");
	AddQuestion(26, "Keep #slavehimher for yourself");
	ShowQuestions("What would you like to do?");
}

function IsMetaDone(fin:Number) : Boolean
{
	var len:Number = arGeneralArray.length;
	if (len == undefined) return false;
	for (var i:Number = 0; i < len; i++) {
		if (arGeneralArray[i] == fin) return true;
	}
	return false;
}

function CheckMetaEndings() : Boolean
{
	// Check for Meta Endings
	// check first for standard endings
	if (IsFemale() && DickgirlXF == 2 && !IsMetaDone(19)) {
		// Dickgirl
		EndGame.SetEnding(19, XMLData.GetXMLString("EndingDickgirl/Name", "EndGame/Slave"));
	}
	modulesList.CheckMetaEndings(arGeneralArray);
	if (NumFin != 0) {
		arGeneralArray.push(NumFin);
		SlaveSpeakEnd();
		BlankLine();
		Language.AddLangText("MetaEndingStart", "EndGame");
		BlankLine();
		EndGame.ShowEndingNext();
		return true;
	}
	return false
}


function EndingStart()
{	
	trace("EndingStart");
	EndGame.Show();
	UseGeneric = false;
	EndGame.ShowEndingNext();
	PlanningSmall._visible = false;
	ShowLargerText(true);

	EndGame.UpdateScore();
}

	
function EndingStartSelect()
{
	trace("EndingStartSelect: " + NumFin);
	UpdateSlave();
	UseGeneric = false;
	if (NumFin == 21) return;
	if (TotalTentacle > 4) {
		// Tentacle Slave
		Backgrounds.ShowTentacles(1, false, 11);
		AddText("Later that day a messenger tells you that the carriage carrying #slave was attacked by tentacle monstrosities and #slaveheshe was taken by the creatures. The servants and guards tries to fight the creatures but they were very strong and determined. #slave was unable to resist when to creatures enveloped #slavehimher due to #slavehisher tight bindings.!\r\rA search party was sent out, as most of the time the person taken will be found nearby, after the creatures had slaked their lust. After a long search they failed to find #slave\r\rDays pass and you are left in a difficult situation, worried about #slave and not having technically completed your contract as final payment has not been made. You find yourself looking for #slave and are unable to start training a new slave.\r\rA few weeks later you hear a lair of the creatures has been found and you accompany the raiding party.\r\r");
	    AddText("The well equipped party overcomes the creatures, it is never easy as the things are strong and clever. You find #slave");
		if (PregnancyOn) AddText(", " + SlaveHeSheIs + " heavily pregnant with the monsters' brood and");
		AddText("is delirious with sexual desire. The monsters cum is a powerful aphrodisiac and #slaveheshe has consumed little else as #slaveheshe was forced to drink their cum as they fucked #alavehimher many, many times!\r\r" + NameCase(SlaveHeSheIs) + " treated and delivered to #slavehimher new owner, with a large and permanent libido. You arrange to visit and check on #slavehimher in a week...");
		temp = slrandom(5);
		ChangeDate(12 + temp, true);
		EndGame.HideScore();
		TotalTentacle = TotalTentacle * -1;
		SlaveGirl.ShowEndingTentacleSlave();
		NumFin = 20;
		return;
	}
	
	EndGame.ViewBasic();
	Backgrounds.ShowOverlayWhite();
 
	if (NumAphrodisiac >= 10) {
		// Drug Addict
		EndGame.SetEnding(12, XMLData.GetXMLString("EndingDrugAddict/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingDrugAddict();
	} else if (VarGold >= 3000 && GetTotalDresses() >= 5 && Score > 40) {
		// Rich
		EndGame.SetEnding(8, XMLData.GetXMLString("EndingRich/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingRich();
	} else if (Score >= 75) {
		// Marriage
		EndGame.SetEnding(2, XMLData.GetXMLString("EndingWedding/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingMarriage();
	} else if (VarLibido >= 85 && VarNymphomania >= 85 && Score > 40) {
		// Sex Maniac
		EndGame.SetEnding(7, XMLData.GetXMLString("EndingSexManiac/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingSexManiac();
	} else if (VarNymphomania >= 75 && VarLibido > 75 && Score > 40) {
		// Sex Addict
		EndGame.SetEnding(6, XMLData.GetXMLString("EndingSexAddict/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingSexAddict();
	} else if (VarObedience < 15) {
		// Rebel
		EndGame.SetEnding(13, XMLData.GetXMLString("EndingRebel/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingRebel();
	} else if (VarCooking >= 60 && VarCleaning >= 60 && Score > 40 && (MaidUniformOK == 1 || IsDressMaid())) {
		// Maid
		EndGame.SetEnding(10, XMLData.GetXMLString("EndingMaid/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingMaid();
	} else if (Score >= 50)	{
		if (VarObedience >= 85 && VarMorality >= 45) {
			// Normal +
			EndGame.SetEnding(14, XMLData.GetXMLString("EndingNormalPlus/Name", "EndGame/Slave"));
			SlaveGirl.ShowEndingNormalPlus();
		} else if (VarObedience < 30) {
			// Normal -
			EndGame.SetEnding(16, XMLData.GetXMLString("EndingNormalMinus/Name", "EndGame/Slave"));
			SlaveGirl.ShowEndingNormalMinus();
		} else {
			// Normal
			EndGame.SetEnding(15, XMLData.GetXMLString("EndingNormal/Name", "EndGame/Slave"));
			SlaveGirl.ShowEndingNormal();
		}
	} else {
		// Prostitute
		EndGame.SetEnding(17, XMLData.GetXMLString("EndingProstitute/Name", "EndGame/Slave"));
		SlaveGirl.ShowEndingProstitute();
	}
}

function EndingStartEnd()
{
	trace("EndingStartEnd1: " + NumFin);
	if (IsDickgirl() && NumFin != 2) EndGame.SetEndingText("Dickgirl " + EndGame.GetEndingText());

	trace("EndingStartEnd2: " + NumFin);
	if (NumFin != 21 && NumFin != 20 && NumFin != 19 && NumFin != 27) {
		if (!modulesList.EndingStart()) {
			AddText("A week passes and you visit #slave's owner and discuss the quality of #slavehisher training and to agree on a final price.");
			if (SMData.GuildMember) AddText(" An official of the Slave Makers Guild meets you there to supervise the final negotiations and to review your training.");
			AddText("\r\r");
		}
	}
	
	slaveData.LastEnding = NumFin;
	if (NumFin < 100) {
		if (slaveData.Endings == null) {
			slaveData.Endings = new Array();
			for (var i:Number = 0; i < 100; i++) slaveData.Endings.push(0);
		}
		if (slaveData.Endings[NumFin] < Score) slaveData.Endings[NumFin] = Score;
	}
	Diary.AddEntry(Language.GetHtml("SlaveEnding", "Diary") + ": " + EndGame.GetEndingText(), false, 0, false, 2);
	trace("EndingStartEnd4: " + NumFin);

	EndGame.HideEndingNext();
	Timers.AddTimerShowWait(
		setInterval(_root, "EndingStartEnd2", 20, Timers.GetNextTimerIdx())
	);
}

function EndingStartEnd2(timer:Number)
{
	Timers.RemoveTimer(timer);
	ChangeDate(8, true);
	Timers.StopWait();
	EndGame.ShowEndingNext();
}

function DoEndingNext()
{
	Beep();
	if (NumFin == 20) NumFin = 0;
	trace("DoEndingNext: " + NumFin);

	ShowLargerText(true);

	// meta ending
	if (NumFin < 0) {
		NumFin = 0;
		if (CheckMetaEndings()) return;
		if (Owner.IsPersonallyOwned() || Owner.IsUnowned()) FreelancerEndTrainingEnd(true);
		else GuildMemberEndTrainingEnd();
		return;
	}
	
    if (NumFin == 0 || NumFin == 21) {
		EndingStart();
		EndingStartSelect();
		EndingStartEnd();
	}
	ShowLargerText(true);
	OldNumFin = NumFin;
	
	EndGame.UpdateScore(true);
	//if (NumFin != 21) BitGagWorn = 0;
	
	EndGame.ShowEndingNext();
	if (!modulesList.EndingFinish()) {
		trace("..standard endings");
		if (NumFin < 1000) SlaveEndings();
		else AfterSlaveEndings();
	}
	modulesList.AfterEndingFinish();
}

function SlaveEndings()
{
	UseGeneric = false;
	
	// Meta endings
	if (NumFin == 19) {
		// Dickgirl
		EndGame.HideEndings();
		ClipTrainingComplete._visible = false;
		NumFin = -1;
		XMLData.XMLGeneral("EndGame/Slave/EndingDickgirl/ReviewScene");
		SlaveGirl.ShowEndingDickgirl();
		if (UseGeneric) Generic.ShowEndingDickgirl();
		return;
	} 
	
	// Standard endings
	if (NumFin == 2) {
		// Wedding
		if (LoveAccepted == 1 || LoveAccepted == 10) {
			AddText("You are greeted warmly at the door by the owner, who seems oddly relieved to meet you. " + SlaveHeSheUC + " ushers you into his house and immediately calls for #slave. " + SlaveHeSheUC + " enters the room dressed in a splendid wedding outfit, looking a little sad. #slavehisher face lights up upon seeing you. The owner explains that they were just rehearsing, and that they were supposed to be married the next day.\r\r");
			PersonSpeak(Owner.GetOwnerName(), "#slave is the most amazing " + SlaveBoyGirl + " I've ever met. I'm glad that I bought #slavehimher—#slaveheshe has been wonderful, and I quickly fell in love with #slavehimher. However, #slaveheshe doesn't seem to feel the same way and confessed that #slaveheshe's actually in love with you.", true);
			AddText("\r\r#slave looks over at you with wet eyes.\r\r");
			SlaveSpeak("I know that I'm just a slave and that I cannot decide my own fate, but I do not want to marry someone I do not love. Please, my heart belongs only to you, #slavemakername!", true);
			AddText("\r\rThe owner looks disappointed but nods in understanding.\r\r");
			PersonSpeak(Owner.GetOwnerName(), "I love #slave too much to want to see #slavehimher sad. The wedding shall be cancelled.", true);
		} else {
			AddText("You are greeted warmly at the door by the owner, who looks genuinely excited to meet you. He ushers you into his house and immediately calls for #slave. " + SlaveHeSheUC + " enters the room dressed in a splendid wedding outfit, looking nervous but absolutely stunning. The owner explains that they were just rehearsing, and that they're due to be married the next day.\r\r");
			PersonSpeak(Owner.GetOwnerName(), "#slave is the most amazing " + SlaveBoyGirl + " I've ever met! I'm so glad that I bought #slavehimher. Some credit must go to you, of course, who trained #slavehimher. You must have done a wonderful job!", true);
			AddText("\r\r#slave looks over at you and smiles.\r\r");
			SlaveSpeak("You were a great Slave Maker. Thank you for teaching me so many different things. I would never have earned this honour without you.", true);
			AddText("\r\rIt is unusual in Mioya for an owner to want to marry a slave, so you are surprised but not displeased by this turn of events. You can tell that the owner is truly smitten with your pupil. You ask #slavehimher if this means that #slave will continue serving as a slave even while married. " + SlaveHeSheUC + " laughs,\r\r");
			PersonSpeak(Owner.GetOwnerName(), "Of course #slaveheshe will! We wouldn't want to waste your expert training. Isn't that right, my love?", true);
			AddText("\r\r#slave blushes and bows #slavehisher head in submission.\r\r");
			if (Owner.PersonGender == 1) SlaveSpeak("Yes, my master and husband.", true);
			else SlaveSpeak("Yes, my master and wife.", true);
		}
		NumFin = 1000;
		return;
	}
	if (NumFin == 6) {
		// Sex Addict
		AddText("When you arrive at the house you enter to find #slave masturbating shamelessly on the floor. #slave is so caught up in #slavehisher actions that #slaveheshe barely seems to notice your arrival. The owner is lying on a couch nearby looking a little tired but not unhappy. #personhesheuc nods at #slave and explains that #slaveheshe's been like this ever since #slaveheshe first arrived.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "You've trained a " + SlaveBoyGirl + " who's really addicted to sex. I don't think #slaveheshe's ever not been horny here, even for a minute.", true);
		AddText("\r\rYou ask if it's a problem and the owner laughs.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "Well, it can be tiring sometimes, but it's nice to have a sex slave that's ready whenever I want #slavehimher.", true);
		AddText("\r\rAt this point #slave lets out a moan and looks at both of you with lust filled eyes.\r\r");
		SlaveSpeak("Please...please fuck me. I need it.", true);
		if (Owner.PersonGender == 2) AddText("\r\rThe owner grins and shakes #personhisher head in disbelief as #personheshe stands up and disrobes. #personhesheuc puts on a strap-on and moves over behind #slave, who positions #slavehimherself eagerly. The owner easily penetrates #slavehimher and begins smacking #slavehisher ass in time with #personhisher thrusts. #personhesheuc invites you to join #personhimher, and you happily accept, shoving your crotch into #slave's face.\r\rAn hour later, you leave the house, confident that #slave will be just fine where #slaveheshe is.");
		else AddText("\r\rThe owner grins and shakes his head in disbelief as #personheshe stands up and disrobes. #personhesheuc moves over behind #slave, who positions #slavehimherself eagerly. The owner easily penetrates #slavehimher and begins smacking #slavehisher ass in time with #personhisher thrusts. #personhesheuc invites you to join #personhimher, and you happily accept, shoving your crotch into #slave's face.\r\rAn hour later, you leave the house, confident that #slave will be just fine where she is.");
		NumFin = 1000;
		return;
    } 
	if (NumFin == 7) {
		// Sex Maniac
		AddText("Upon arrival at the house you find a note taped to the door directing you to a market nearby. Curious, you quickly go to the address. There you find the owner seated comfortably in a chair with a sun shade and a wine glass. Out in the street there seems to be some sort of commotion. After a moment you realize that it's #slave, fucking with a number of partners who appear to be regular passersby while a larger crowd looks on.\r\r#slave seems to be enjoying #slavehimherself so much that #slaveheshe doesn't notice your arrival at all. The owner greets you with a handshake and then gestures at #slave.\r\r");
		PersonSpeak(Owner.GetOwnerName(), SlaveHeSheUC + "'s something else, isn't #slaveheshe? My friend, you've trained one hell of a nymphomaniac.", true);
		AddText("\r\rAs if to punctuate the point, #slave seems to orgasm loudly to cheers from the crowd. The owner grins and takes a sip from his glass, clearly enjoying the show.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "It only took me a few days to realize that fucking #slavehimher myself was never going to satisfy #slavehisher appetites. " + SlaveHeSheUC + " kept throwing #slavehimherself at random people in the street, so I figured why not give #slavehimher what #slaveheshe wants?", true);
		AddText("\r\r#slave's partners, exhausted, stand up and zip up their pants. More onlookers move to take their place. #slave licks #slavehisher lips and stares lustfully through lidded eyes. Minutes later, #slavehisher moans start up again.\r\rYou grin. #slave seems to be quite happy where #slaveheshe is.");
		NumFin = 1000;
		return;
    } 
	if (NumFin == 8) {
		// Rich
		AddText("As you approach the owner's mansion you are impressed by the size of #personhisher estate—clearly #personheshe is considerably wealthy.\r\rYou are met at the door by servants who lead you into an incredibly fancy hall decked with chandelier and expensive ornaments. In another room you finally meet the owner, who is lounging on a velvet cushion. #slave is lying by #personhisher side, wearing a fancy outfit and a contented smirk.\r\rAfter introducing yourself, you ask if #personheshe is satisfied with the work you did. The owner rubs #slavehisher chin thoughtfully.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "My friend, it's hard to say. Clearly you spared no expense in training this slave, but #slavehisher tastes are similarly extravagant! It can be difficult at times to satisfy #slavehisher caprices, isn't that right #slave?", true);
		AddText("The owner scratches #slave behind #slavehisher ears like a pet, and #slaveheshe coos in response.\r\r");
		SlaveSpeak("I only ask for what's best, #personmaster. You are a person of excellent taste, and you should settle for nothing but the best. After all, that's why you own me, isn't it?", true);
		AddText("\r\rThe owner laughs at that and slaps #slavehisher belly in amusement. #personhesheuc informs you that the job you did was just fine, but that not every owner would have the wealth to satisfy such a " + SlaveBoyGirl + ".");
		NumFin = 1000;
		return;
    } 
	if (NumFin == 10) {
		// Maid
		AddText(SlaveName + NonPlural(" greet") + " you at the door with a polite bow, dressed in #slavehisher maid " + Plural("uniform") + ". #slavehisher apron is spotless and #slaveheshe smiles at you briefly before leading you into the house. #slave guides you and the representative through a number of neatly kept rooms until you find yourself in a parlor with #slavehisher owner. After #slaveheshe introduces you, the owner pats #slave on the ass, then orders #slavehimher to prepare refreshment for his guests.\r\r");
		PersonSpeak(Owner.GetOwnerName(), " I pride myself on having a high standard for my domestic servants, and I must say you've done a very good job with this " + SlaveBoyGirl + ". "+ SlaveHisHer + " cooking and cleaning skills are impressive. I have #slavehimher do...other...things for me, of course, but "+ SlaveHeShe + " makes a first rate maid.", true);
		AddText("\r\r#slave returns balancing a tray full of expertly prepared snacks. The owner reaches over to grope #slavehimher absentmindedly as #slaveheshe serves you tea. "+ SlaveHeShe + " stands quietly at attention while you sit comfortably and eat.\r\r");
		PersonSpeak(Owner.GetOwnerName(), " #slave looks very cute with "+ SlaveHisHer + " apron, don't you agree sir? "+ SlaveHeShe + " really is one of the finest household servants I've ever seen—and it's all thanks to your training. Isn't that right, #slave?", true);
		AddText("\r\r#slave bows low, glances at you, and smiles.\r\r");
		SlaveSpeak("Yes Master, I was trained very hard in housework. It was difficult at the time, but I'm glad now that I can at least be useful around the mansion.", true);
		NumFin = 1000;
		return;
    } 
	if (NumFin == 12) {
		// Drug Addict
		AddText("When you arrive at the address you notice that the customer is not the usual wealthy trader or noble—indeed, #slaveheshe lives on the border of the slums. The house is nice enough, but the moment you step through the door you find weapons and suspicious crates lying around. The owner is obviously involved in some illegal activity.\r\rThe Slave Maker Guild representative assures you that it's not a problem, as the Guild is known for providing discreet services to many different types of clientele. A little unsettled, you walk further inside.\r\rIn another room you abruptly come across #slave lying on a dirty mattress, #slavehisher eyes glazed over, drool trickling from #slavehisher mouth. A number of empty vials and tablets are strewn around #slavehimher. The scene is familiar. Clearly, #slave is still addicted to drugs and #slavehisher owner has been feeding the habit.\r\rThe owner, a seedy looking man with long and unkempt hair emerges from another room and introduces himself. He thanks you for coming by.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "I was surprised to find that you'd used so many drugs in #slave's training, but I can't complain. " + SlaveHeSheUC + " is a good slut, very pliable, and there's nothing I can't get #slavehimher to do thanks to #slavehisher various addictions.", true);
		AddText("As if to demonstrate, the owner disrobes and lowers #slavehimherself onto #slave and begins enthusiastically fucking #slavehimher. #slave groans, but the owner simply empties a vial into #slavehisher lips and #slaveheshe gasps in pleasure.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "See? #slaveheshe can't live without my drugs. " + SlaveHeSheUC + " couldn't disobey me even if #slaveheshe wanted to.", true);
		AddText("\r\rThe customer seems satisfied, but you remember how different and full of personality #slave used to be when you first began training #slavehimher. Shaking your head, you turn and leave disappointed.");
		NumFin = 1000;
		return;
    } 
	if (NumFin == 13) {
		// Rebel
		AddText("When you show up at the owner's residence you notice that there are signs of a recent scuffle. A vase lies broken on the floor, and some of the furniture is overturned. The owner himself is not there to greet you, but you ask one of the other servants what happened. Dryly, the girl informs you that these are leftovers from the last time that #slave tried to escape.\r\rA few minutes later the owner enters the room, looking very irritated. He doesn't shake your hand, and instead crosses his arms.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "So you're the one who was supposed to train #slave. I was beginning to wonder if #slaveheshe'd had any training at all!", true);
		AddText("\r\rYou ask if he's been having any trouble with #slave, and he laughs.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "Trouble? I'll show you trouble—hey #slave, get out here!", true);
		AddText("\r\r" + SlaveName + NonPlural(" enter") + " from another room, #slavehisher arms bound behind #slavehisher back, glaring angrily at all of you. " + NameCase(SlaveHisHer) + " hair is messed up and #slaveheshe's sporting a few cuts and bruises.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "Look who came to visit! It's your old trainer, slave. Got anything to say to him?", true);
		BlankLine();
		Slave1Speak("I'm a person, not a slave, no matter what any of you say!", true);
		BlankLine();
		if (SlaveGender > 3) AddText(Slave2Name + " nods #slavehisher head.");
		AddText("You try to reason with #slave, but " + SlaveHeSheIs + " intractable. " + SlaveHeSheUC + " acts temperamentally and insists on being treated like an equal. Finally the owner slaps #slavehimher, and in response #slaveheshe tries to fight back. However with #slavehisher arms bound, the owner has little difficulty in subduing #slave and forcing #slavehimher to the ground.\r\rRight there in front of everyone, the owner pulls down his trousers and unabashedly begins to fuck #slave as #slaveheshe lets out angry moans.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "See how poor your job was? This is the only way I can ever enjoy #slavehimher, not to mention the only way I can shut #slavehimher up. ", true);
        NumFin = 1000;
		return;
    } 
	if (NumFin == 14) {
		// Normal +
		AddText("When you approach the house you are surprised to find that #slave is outside, walking around freely. " + SlaveHeSheUC + " seems pleased to see you, and immediately greets you and the Guild Representative by kneeling and kissing your feet. " + SlaveHeSheUC + " quickly escorts you inside where the owner introduces himself and orders #slave to wait there while you talk.\r\r#slave obediently clasps #slavehisher hands in front of #slavehimher and bows #slavehisher head in compliance. The owner grins at you and thanks you for a job well done, gesturing at #slave as if to prove his point.\r\r");
		PersonSpeak(Owner.GetOwnerName(), " #slave is an extremely well behaved piece of property! #slave is so loyal that I can let #slavehimher walk around freely and still have #slavehimher at my feet in an instant. In fact, tell them what happened the other day, slave.", true);
		AddText("\r\r#slave blushes and happily relates the tale.\r\r");
		SlaveSpeak("While my Master was occupied, some foolish men who oppose slavery tried to free me! I resisted, and they were quickly arrested. I know my place, and I would never try to disappoint my Master.", true);
		AddText("The owner smiles, then unzips his fly and asks #slavehimher to service him. Without a moment of hesitation, #slave kneels down and begins to give him a blowjob as the owner continues to speak as though she weren't there at all.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "There is nothing I cannot have #slave do for me. I couldn't ask for a better slave.", true);
		NumFin = 1000;
		return;
    } 
	if (NumFin == 15) {
		// Normal
		AddText("When you approach the house you are surprised to see three slave " + SlaveBoyGirl + "s chained to a post out in front. They are all naked. It takes you a moment to realize that one of them is #slave. The door soon opens and the owner steps outside.\r\r");
		PersonSpeak(Owner.GetOwnerName(), " Ah, right, the guild was supposed to come today. Nice to meet you both—ah, which one of these did you train again?", true);
		AddText("\r\rYou explain that you trained #slave, but the owner still seems confused. He asks you to point #slavehimher out. After you do so he nods vigorously and invites you inside, taking the slaves along with him.\r\rThe owner tells you that you've done a perfectly passable job, and that he's gone through many slaves like #slave. As a token of his gratitude, he offers you the services of his slaves, and you politely accept. You, the guild representative, and the owner all sit down in separate chairs as each of the three slaves buries their heads in your groins. By chance #slave ends up servicing you, though it seems that any of the others could have done just as well.\r\r");
		PersonSpeak(Owner.GetOwnerName(), SlaveHeSheUC + "'s a bit plain, but I can't really complain. I haven't had too many problems with...whatever #slavehisher name is.", true);
		AddText("\r\rYou make some small chat while generally ignoring the slaves. When your business is concluded, you and the owner bid each other goodbye. As you rise to leave and pull up your pants, you see all three slaves move to attend to the owner. #slave looks right at home alongside the others, an ordinary slave.");
		NumFin = 1000;
		return;
    } 
	if (NumFin == 16) {
		// Normal -
		AddText("When you arrive at the house, you are met by the door by a butler, who escorts you inside. The customer is evidently a wealthy man who owns dozens of slaves, all of whom go without clothes as they see to his every whim. You find the owner lounging upon a great cushioned chair. He is immensely fat, and five slave girls are busy massaging or stroking various parts of his body.\r\rMeanwhile, #slave lies bored at the owner's feet. A crude rope is tied around #slavehisher neck and the owner loosely holds the end of it.\r\rYou ask how " + SlaveHas + " been doing, and whether or not he is pleased with the training.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "I'd like to say it was a good job, but this " + SlaveBoyGirl + " just isn't very motivated as a servant. I'm not sure if she's actually good for anything, and she often requires encouragement to obey.", true);
		AddText("\r\rTo demonstrate, the owner yanks on the rope. #slave yelps in surprise, casts a resentful look up at #slavehisher Master, but grudgingly goes through the motions of stroking #slavehimher. You can tell #slaveheshe's not really trying, and you feel a little embarrassed by the lame performance.\r\r");
		PersonSpeak(Owner.GetOwnerName(), " I know that not every job is perfect, but it really feels like you barely trained this " + SlaveBoyGirl + " at all. I might have to pass #slavehimher off to a different Slave Maker.", true);
		NumFin = 1000;
		return;
    } 
	if (NumFin == 17) {
		// Prostitute
		AddText("You arrive at the house and are met at the door by a grumpy looking gentleman. He grudgingly invites you and the representative inside. You ask him where " +SlaveIs + ", and in response he snorts.\r\r");
		PersonSpeak(Owner.GetOwnerName(), SlaveHeSheUC + "'s working.", true);
		AddText("\r\rConfused, you ask him what that means.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "It means that your work was hardly satisfactory! I wanted a valuable slave, not a whore good for nothing but sex. I sold that worthless tramp to a brothel, and good riddance!", true);
		AddText("\r\rDismayed, you apologize and ask which brothel #slave was sold to. After a little persuasion, the owner relents and gives you the address, but tells you not to expect any more business from him. Telling the representative that you'll meet him later, you rush to investigate.\r\rYou find that the brothel is an establishment of bad reputation, located in the slums. The bouncer at the door refuses to let you in because you're not a customer. Peering in through one of the windows, you see #slave, #slavehisher hair bedraggled, fucking a toothless man. The man cums inside #slavehimher, as tears run down #slavehisher face.\r\rDisappointed, you turn away and return home, knowing that #slave will spend the rest of #slavehisher days being used as a common prostitute.");
		NumFin = 1000;
		return;
    } 
	if (NumFin == 21) {
		// Cowgirl
		Backgrounds.ShowFarm();
		SlaveGirl.ShowEndingCowgirl();
		HideAllPeople();
		EndGame.SetEndingText(XMLData.GetXMLString("EndingStolenCowgirl/Name", "EndGame/Slave"));
		AddText("A few days later, after the search for #slave has been called off");
		if (Owner.IsOwnedByAnother()) AddText(" and the owner informed of the loss,");
		AddText(" you go to bed disappointed. You wake up feeling dizzy, and find yourself tied to a chair. Looking around, you find that you're sitting inside a barn. All around you there are stalls filled with girls being milked, their breasts huge, dildos cramming their pussies and asses.\r\r");
		PersonSpeak("?", "It looks like you're finally awake.", true);
		AddText("\r\rYou look up and are shocked to see a farmer and farmhand standing in front of you, wide grins on their faces. Right beside them is #slave, wearing a dotted outfit to make her look like a cow. Her eyes seem unfocused and her huge breasts dangle beneath her, dripping milk. There is no trace of intelligence or spirit left on her face—it doesn't seem like she needs to be drugged anymore.\r\r");
		PersonSpeak("Farmer", "We heard you were #slave's trainer, so brought you here to show our appreciation. #slave has been such a good cow, producing great quantities of milk for us. Thank you for blindly allowing her to continue visiting the countryside.", true);
		AddText("\r\rThe farmhand grins as he unzips his pants and inserts his cock into #slave's mouth. #slave dumbly begins to suck, mooing as she does so.\r\r");
		PersonSpeak("Farmhand", "And thanks for never teaching her not to take candy from strangers!", true);
		AddText("\r\rAs #slave services the farmhand, the farmer attaches suction cups to her tits and then slides his cock into her ass. He sighs in satisfaction as you look on.\r\r");
		PersonSpeak("Farmer", "The good Count tells me that he's actually heard of this slave before. He likes playing with her breasts on his visits. I think he enjoys seeing such a promising young girl reduced to a pair of tits.", true);
		AddText("\r\rThe farmer and farmhand cum almost at the same time, and #slave moos again as she gulps it down. At the same time she seems to come to orgasm and milk flows down the tubes attached to her.\r\r");
		PersonSpeak("Farmer", "#slave has been so profitable, we're going to pay you a little for your loss. Just remember in case you think about causing any trouble—if we wanted to, we could easily turn you into one of our cows as well.", true);
		AddText("\r\rThe farmhand zips up his pants, and then walks over to you. He swings his fist and everything goes black.\r\rYou wake up with a headache in the morning. Your pockets are filled with gold and a jar of milk. You remember the sound of #slave's mooing, and you shake your head, knowing that you'll never see her again.");
        NumFin = SMData.SkillPoints > 0 ? 9002 : 9004;
		return;
    } 
}
	
function AfterSlaveEndings()
{
	if (NumFin == 1000) {
		if (SMData.GuildMember) ShowEndingAssessmentGuild();
		else ShowEndingAssessmentFreelancer();
	} else if (NumFin == 1001) {
		// Bought Back
		EndGame.ShowScore();
		EndGame.HideEndings();	
		Backgrounds.ShowBedRoom();
		SlaveGirl.ShowBreak();
		if (UseImages) ShowActImage(1017);
		AddText("Later, after all the business is concluded and #slave is dismissed, you find yourself reflecting upon #slave's training.\r\rYou recall how perfect #slaveheshe turned out in the end, like a work of art. Few slaves ever have such a successful education, and you begin to fantasize about how nice it would be to keep #slavehimher around as " + Plural("a gem") + " of your own collection.\r\r");
		if (LoveAccepted == 1 || LoveAccepted == 10) AddText("\r\rYou also recall the vows that you once made to each other, and how strong your personal feelings are for #slave. It would break both your hearts to leave #slavehimher in the hands of another master.\r\r");
		AddText("Do you approach #slave's owner to try to purchase #slave?");
		NumEvent = 20;
		SlaveGirl.AskBoughtBackQuestion();
		DoYesNoEvent();
	} else if (NumFin == 1002) {
		// Bought Back
		EndGame.HideEndings();	
		Backgrounds.ShowBedRoom();
		AddText("With your mind made up, you again approach the owner and explain your feelings. At the same time, you make a generous offer to purchase #slave permanently. The owner seems surprised at first, then begins to think about it.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "They do say that Slave Makers sometimes get attached to their own pupils. I can't blame you, myself. #slave is an extremely fine slave.", true);
		AddText("\r\rYou reiterate again how determined you are to buy #slave. The owner seems impressed by both your resolve and your price, and finally agrees.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "I can always get another slave, I suppose, and I can tell that this one will be special to you in ways #slaveheshe could never be for me.", true);
		AddText("\r\rThe owner promises to draw up the paperwork immediately, and gold is hastily exchanged. You quickly seek out #slave to tell #slavehimher the good news. " + SlaveHeSheUC + " seems surprised to see you again, but smiles when you tell #slavehimher that you will be #slavehisher new owner.\r\r");
		SlaveSpeak("That is as it should be. You made me what I am, and I could never truly feel loyal to anyone else..." + Master, true);
		AddText("\r\rYou grin, then attach a leash to #slave's collar and lead #slavehimher home for good.");
		AddText("\r\rYou have to forfeit all pay for training #slave including your original 500GP retainer and pay an additional 500GP to the owner.\r\r")
		SlaveGirl.ShowEndingBoughtBack();
		EndGame.SetEndingText(XMLData.GetXMLString("EndingBoughtBack/Name", "EndGame/Slave"));
		AddText(Language.GetHtml("RevisedEnding", "EndGame") + " " + EndGame.GetEndingText());
		Diary.AddEntry(Language.GetHtml("RevisedEnding", "EndGame") + " " + EndGame.GetEndingText(), false, 0, false, 2);
		SMMoney(-1 * (Pay + 1000), true);
		slaveData.CanAssist = true;
		slaveData.SlaveType = 1;
		NumFin = SMData.SkillPoints > 0 ? 9002 : 9004;
	} else if (NumFin == 1003) {
		EndGame.HideEndings();	
		Backgrounds.ShowSunset();
		slaveData.SlaveType = -3;
		AddText("With great reluctance you decide it is best to stay true to your profession and honour and turn your back on #slave and #slavehisher new owner, trying to forget #slavehimher.");
		NumFin = SMData.SkillPoints > 0 ? 9002 : 9004;
	} else if (NumFin == 1004) {
		// Love
		AddText("A little later, after all business is settled and #slave has been dismissed, the owner invites you into his private study for a personal talk. He tells you that over the past few days he has noticed how much #slave pines for you, how #slaveheshe cries when #slaveheshe thinks no one is looking, how #slaveheshe mumbles your name at night. The owner claims to be moved by #slavehisher devotion.\r\r");
		PersonSpeak(Owner.GetOwnerName(), "I have no desire to keep #slave from #slavehisher true Master. Furthermore, #slaveheshe wouldn't be of much use to me anyway if #slaveheshe only dreams of being with you. I will release #slavehimher back to you for a fair price.", true);
		AddText("\r\rKnowing how much you love #slave as well, you hastily agree to #slavehisher offer. The owner promises to draw up the paperwork immediately, and then calls in #slave to tell #slavehimher the good news.\r\r#slave enters the room and clasps #slavehisher hand to #slavehisher mouth in delight and disbelief upon hearing what had happened. " + SlaveHeSheUC + " runs into your arms and kisses you passionately.\r\r");
		SlaveSpeak("From now on, I'm only yours — forever.", true);
		AddText("\r\rYou have to forfeit all pay for training #slave including your original 500GP retainer and pay an additional 500GP to the owner.\r\r");
		EndGame.SetEndingText(XMLData.GetXMLString("EndingLove/Name", "EndGame/Slave"));
		AddText(Language.GetHtml("RevisedEnding", "EndGame") + " " + EndGame.GetEndingText());
		Diary.AddEntry(Language.GetHtml("RevisedEnding", "EndGame") + " " + EndGame.GetEndingText(), false, 0, false, 2);
		SlaveGirl.ShowEndingLove();
		SMMoney(-1 * (Pay + 1000), true);
		slaveData.CanAssist = true;
		slaveData.SlaveType = 1;
		NumFin = SMData.SkillPoints > 0 ? 9002 : 9004;
	} else if (NumFin == 1005) {
		// Keep for yourself
		EndGame.HideEndings();	
		Backgrounds.ShowBedRoom();
		AddText("You are determined to keep #slave as your own personal slave and you tell #slavehimher.\r\r")
		SlaveGirl.ShowEndingBoughtBack();
		if (LoveAccepted == 1 || LoveAccepted == 10) {
			AddText("\r\rKnowing how much you love #slave you embrace #slavehimher and kiss #slavehimher passionately.\r\r");
			SlaveSpeak("From now on, I'm only yours — forever.", true);
			AddText("\r\rYou have to forfeit all pay for training #slave including your original 500GP retainer and pay an additional 500GP to the owner.\r\r")
			EndGame.SetEndingText(XMLData.GetXMLString("EndingLove/Name", "EndGame/Slave"));
		} else {
			SlaveSpeak("That is as it should be. You made me what I am, and I could never truly feel loyal to anyone else..." + Master, true);
			AddText("\r\rYou grin, then attach a leash to #slave's collar.\r\r");
			EndGame.SetEndingText(XMLData.GetXMLString("EndingBoughtBack/Name", "EndGame/Slave"));
		}
		AddText(Language.GetHtml("RevisedEnding", "EndGame") + " " + EndGame.GetEndingText());
		Diary.AddEntry(Language.GetHtml("RevisedEnding", "EndGame") + " " + EndGame.GetEndingText(), false, 0, false, 2);
		slaveData.CanAssist = true;
		slaveData.SlaveType = 1;
		NumFin = SMData.SkillPoints > 0 ? 9002 : 9004;
	} else if (NumFin == 1006) {
		// Sell at auction
		EndGame.HideEndings();	
		ShowDress();
		Backgrounds.ShowBar(3);
		Pay = Math.ceil(Pay * 0.66);
		NumFin = 0;
		slaveData.SlaveType = -3;
		slaveData.Owner.ChangeOwner(1000 + (IsDickgirlEvent() ? 3 : slrandom(2)));
		XMLData.XMLGeneral("EndGame/Slave/EndingSellAtAuction/ReviewScene");
	} else if (NumFin == 9002 || NumFin == 9003 || NumFin == 9098 || NumFin == 9099) {
		NumFin += 2;
		if (SMData.SkillPoints == 0) EndGame.FinishEndings();
		else EndGame.ShowSkillPoints();
    } else if (NumFin == 9004 || NumFin == 9005 || NumFin == 9100 || NumFin == 9101) EndGame.FinishEndings();
}

function ShowEndingAssessmentGuild()
{
	NumFin = 9002;
	if (Score >= 100) NumFin = 1001;
	if (LoveAccepted == 1 || LoveAccepted == 10) NumFin = 1004;
	
	EndGame.ShowScore();
	
	var badending:Boolean = slaveData.LastEnding == 17 || slaveData.LastEnding == 12 || slaveData.LastEnding == 13;
	var unrefined:Boolean = badending || slaveData.LastEnding == 7 || slaveData.LastEnding == 6;
	
	ShowLargerText(true);
	AddText("You have a private discussion with the Slave Guild Representative and he assesses your training of #slave. First he tells you your rating\r\r<b>Score " + Score + "</b>\r");
	if (EndGame.IsSpecialTrainingsDone()) AddText("#slave has completed special trainings and you get a bonus for each.\r");
	if ((LoveAccepted == 1 || LoveAccepted == 10) && sLeadership < 3) AddText("He tells you he has heard rumours of a romance between you and #slave and you have been penalised for this unprofessional behaviour.\r");
	if (SMData.GuildMember && Owner.GetOwner() != slaveData.StartOwner.GetOwner()) AddText("He looks annoyed and mentions your sale of #slave as a very unprofessional thing, and you have been penalised.\r");

	if (Owner.GetOwner() == 12) {
		EndGame.HideEndings();
		ShowPerson(12, 1, 2, 1);
		AddText("\r\rAs you have given away #slave to Irina you have forfeited your fee for training #slave plus all expenses incurred.");
		if (VarGold > 0) AddText(" It is decided that you will get a commission on the remaining money left from her training, a total of " + Math.floor(VarGold / 10) + "GP.");
		Pay = Math.floor(VarGold / 10)
		SMMoney(Pay);
		SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, -3, 0);
		AddText("\r\rAs word of your generosity spreads you may find it harder to get commissions to train slaves.");
		NumFin = 9002;
		return;
	}
	
	AddText("\rYou then discuss the final payment for your training of #slave and you agree to a payment of " + Pay + "GP.");
	if (badending) {
		AddText("\r\rAs #slave's new owner is unhappy with your work will not be reimbursed your costs for training #slavehimher or your commission for money earned.");
		if ((SMAdvantages.CheckBitFlag(0) || SMAdvantages.CheckBitFlag(1)) && unrefined) {
			AddText("\r\r#slave is a rather unrefined, and you expect this to be heard at court, hurting your reputation.")
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, -4, 0);
		}
		SMMoney(Pay);
	} else {
		if (SMData.GuildMember) {
			AddText("\r\rYou also receive " + int(SMData.SMGoldSpent + Math.floor(VarGold / 10)) + "GP for your expenses in training #slave and a commission for some of the money #slaveheshe earned.");
			Pay += int(SMData.SMGoldSpent + Math.floor(VarGold / 10));
		}
		SMMoney(Pay);
	}
	if (Score > 49) SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 2 + Math.ceil(Score / 50), 0);
	if (Owner.GetOwner() > 0 && Owner.GetOwner() < 1000) NumFin = 9002;
}

function ShowEndingAssessmentFreelancer()
{
	if (Score >= 100) NumFin = 1001;
	else NumFin = 9002;
	if (LoveAccepted == 1 || LoveAccepted == 10) NumFin = 1004;
	
	EndGame.ShowScore();
	
	var badending:Boolean = slaveData.LastEnding == 17 || slaveData.LastEnding == 12 || slaveData.LastEnding == 13;
	var unrefined:Boolean = badending || slaveData.LastEnding == 7 || slaveData.LastEnding == 6;
	
	ShowLargerText(true);
	AddText("You have a private discussion with #slave's owner and between you you assess your training of #slave.\r\r<b>Score " + Score + "</b>\r");
	if (EndGame.IsSpecialTrainingsDone()) AddText("#slave has completed special trainings and you get a bonus for each.\r");

	if (Owner.GetOwner() == 12) {
		EndGame.HideEndings();
		ShowPerson(12, 1, 2, 1);
		AddText("\r\rAs you have given away #slave to Irina.");
		SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, -3, 0);
		AddText(" As word of your generosity spreads you may find it harder to get commissions to train slaves.");
		NumFin = 9002;
		return;
	}
	
	AddText("\rYou then discuss the final payment for your training of #slave with #slavehisher owner and you agree to a payment of " + Pay + "GP.");
	if (badending) {
		if ((SMAdvantages.CheckBitFlag(0) || SMAdvantages.CheckBitFlag(1)) && unrefined) {
			AddText("\r\r#slave is a rather unrefined, and you expect this to be heard at court, hurting your reputation.")
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, -4, 0);
		}
	}
	SMMoney(Pay);

	if (Score > 49) SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 2 + Math.ceil(Score / 50), 0);
	if (Owner.GetOwner() > 0 && Owner.GetOwner() < 1000) NumFin = 9002;
}