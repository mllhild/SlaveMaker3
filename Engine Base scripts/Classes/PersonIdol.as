// PersonIdol - Meigura, the demon idol
// number 20
// lend modifier n/a
// Translation status: INCOMPLETE

// SMFlag = preserve value of VarIdol

import Scripts.Classes.*;


class PersonIdol extends Person {
		
	public function PersonIdol(cg:Object, cc:Object) { 
		super("Idol", cg, 20, 0, false, cc);
	}
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		if (gframe == undefined) return false;
		var mv:String = "Images/Cities/Mardukane/People/Meigura/";
		if (gframe < 5) mv += "Idol " + gframe + ".jpg";
		else mv += "Wish.jpg";
		coreGame.AutoLoadImageAndShowMovie(mv, Number(placeo), align, delay);
		return true;
	}
	
	// Meet her
	public function Meeting(meet:Number) : Boolean
	{
		if (!super.Meeting(sd.VarIdol)) return false;
		if (sd.VarIdol == -1 || SMFlag == -1) return false;
		
		sd.Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 2, 0, 0, 0);
		switch (sd.VarIdol) {
			case 0:
				if (IsDickgirlEvent()) SMData.BitFlagSM.SetBitFlag(1);
				ShowThem(1, 1, 1);
				AddText("#slavesee a girl surrounded by a small crowd. She is beautiful in an odd way. #slave cannot quite work out why she seems so popular but as #slaveheshe watches #slaveheshe feels drawn toward the girl.\r\r");
				if (Supervise) AddText("You see " + coreGame.SlaveIs + " almost in a trance and lightly touch #slavehisher shoulder and  #slaveheshe starts and realises #slaveheshe has walked almost to the group and the idol. You suggest that you both leave.");
				else AddText(SlaveVerb("feel") + " a hand on #slavehisher shoulder and sees #assistant and realises #slaveheshe has walked almost to the group and the idol. #assistant insists they leave.");
				AddText("\r\r#slave still feels fascinated by the girl and wonders about how to improve #slavehisher appearance to be more like the idol.");
				break
			case 1:
				ShowThem(1, 0, 4);
				AddText("#slavemeet again that popular girl with her small crowd of friends. #slave walks over and introduces herself. #Slaveheshe notices some of the others look at #slavehimher with some jealousy. The girl happily chats, and introduces herself as Meigura.\r\r#slave can see how the others almost fawn over Meigura and vie for her attention. Despite all this they all seem friends and talk and play, but everything is centered on Meigura.\r\r");
				if (Supervise) AddText("After a while you tell #slave that it is time to leave.");
				else AddText("After a while #assistant almost drags #slave away, muttering something like 'don't like her'.");
				break;
			case 2:
				ShowThem(1, 0, 4);
				if (Supervise) AddText("#slavemeet again Meigura and her friends and joins them. You feel annoyed at being excluded, and watch from a distance.\r\r#slave spends time chatting with Meigura, and can see how she is expert at manipulating her friends, playing one off against another to get them to do things, or just to tease. #slave can see no malicious or mean intention, just playfulness.\r\rSometimes Meigura says strange things, she seems very knowledgeable, but avoids any talk of the gods, but allows other to talk if they must. Once she got angry when a friend tried to go back on his word, she was furious and insisted he live up to the word, and intention of his promise.\r\rAfter this you insist they leave.");
				else AddText("#slavemeet again Meigura and her friends and joins them. #assistant looks annoyed and watches from a distance.\r\r#slave spends time chatting with Meigura, and can see how she is expert at manipulating her friends, playing one off against another to get them to do things, or just to tease. #slave can see no malicious or mean intention, just playfulness.\r\rSometimes Meigura says strange things, she seems very knowledgeable, but avoids any talk of the gods, but allows other to talk if they must. Once she got angry when a friend tried to go back on his word, she was furious and insisted he live up to the word, and intention of his promise.\r\rAfter this #assistant insisted they leave.");
				break;
			case 3:
				ShowThem(1, 1, 1);
				if (Supervise) AddText("#slave" + NonPlural(" notice") + " Meigura enter a small house and is sorry #slaveheshe missed her. A little time later as you both pass the house again you see a girl leaving, but she is shimmering. She has bat wings and horns on her head! The shimmering stops and you can see it is Meigura, who looks at #slave surprised and runs off.\r\r#slave and you chase after her, and corner her in an alley. She looks unhappy and says,\r\r");
				else AddText("#slave" + NonPlural(" notice") + " Meigura enter a small house and is sorry #slaveheshe missed her. A little time later they pass the house again and see a girl leaving, but she is shimmering. She has bat wings and horns on her head! The shimmering stops and they can see it is Meigura, who looks at them surprised and runs off.\r\r#slave and #assistant chase after her, and corner her in an alley. She looks unhappy and says,\r\r");
				PersonSpeak(Id, "You saw me, didn't you...\r\rAlright, I am a demon but I'm not evil now, I grew tired of torment and lust, I just wanted people to be with, to like and be friends with. I have repented, as such, my ways, but I still reject all gods and their teachings. I am complete in myself, I do not need gods telling me what is right and wrong, I can decide this myself.\r\rPlease do not tell anyone about me, if you do I swear to grant you a boon, some would call it a wish...", true);
				AddText("\r\rShe starts to shimmer again...");
				DoEvent(4014);
				break;
			default:
				ShowThem(1, 1, 1);
				AddText("#slavesee #slavehisher demonic friend Meigura and briefly says 'hello'. ");
				if (!Supervise) AddText("#assistant interrupts and insists they leave, now.\r\r#slave" + NonPlural(" wave") + " goodbye.");
				break
	
		}
		coreGame.SlaveGirl.AfterMeetIdol();
		coreGame.modulesList.AfterMeetPerson(Id, sd.VarIdol);
		if (sd.VarIdol < 4) sd.VarIdol++;
		SMFlag = sd.VarIdol;
		return true;
	}

	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
			// 4014 - demon deal
			case 4014:
				HideBackgrounds();
				coreGame.HideImages();
				ShowThem(1, 1, SMData.BitFlagSM.CheckBitFlag(1) ? 3 : 2);
				PersonSpeak(Id, "I can grant many things, as you are a slave I can give a form of freedom, and many of the standard things. My nature corrupts all wishes a little, so they are sometimes not quite what you would expect. All wishes require power and I need to absorb this from you, do not worry it will not harm you or corrupt you.\r\rIf you do not want these I will just flee the city. I will miss my friends but I can make more in another land.");
				if (!coreGame.Supervise) {
					AddText("\r\r#assistant looks angry, but suddenly faints,\r\r");
					PersonSpeak(Id, "It is alright, #assistantheshe is just dreaming of what #assistantheshe imagines I would do to #assistanthimher.", true);
				}
				AskHerQuestions(4016, 4015, 0, 0, "A Wish", "Nothing, leave this city", "", "", "What does #slave decide?");
				return true;
				
			// 4015 - leave
			case 4015:
				sd.Points(0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText(SlaveVerb("does") + " not want demons in this city, and is also a little afraid for Meigura, demon girls are prized as slaves.\r\r#Slaveheshe asks Meigura to leave the city, for her safety and for her friends.\r\rMeigura looks sad but agrees and walks off into the city.");
				if (!coreGame.Supervise) AddText("\r\rShortly after #assistant wakes up and looks very embarrassed but refuses to talk. They leave.");
				sd.VarIdol = -1;
				SMFlag = -1;
				return true;
				
			// 4016 - demon deal
			case 4016:
				coreGame.HideImages();
				ShowThem(1, 1, SMData.BitFlagSM.CheckBitFlag(1) ? 3 : 2);
				PersonSpeak(Id, "I gain power by....");
				if (SMData.BitFlagSM.CheckBitFlag(1)) AddText("\r\rShe strokes her cocks ");
				else AddText("\r\rShe rubs her breasts ");
				AddText("and then reaches out and touches #slave on #slavehisher shoulders ");
				if (!Naked) AddText("and #slavehisher clothes falls to the ground, ");
				AddText("and Meigura kisses #slavehimher and #slave feels a rush of arousal. Meigura has #slave ");
				if (SMData.BitFlagSM.CheckBitFlag(1)) {
					AddText("lean forwards against a wall, and slowly runs hands over #slave's body, and slides a cock along #slavehisher ass cheeks. After a bit she thrusts both cocks in");
					if (coreGame.SlaveFemale) AddText(", one into #slave's pussy and one into her ass. Her cocks are very large and very hard, and she fucks hard and with skill. She has good control and as #slave feels her orgasm approach, Meigura speeds up and as #slave cums she feels Meigura spasm and her cum pours into #slave's pussy and ass. They pant, Meigura's cocks still in #slave and Meigura whispers 'One', and she slowly resumes fucking, her cocks still hard, sliding easily, lubricated by her own cum.\r\r#slave groans but feels her arousal build, but Meigura cums again quickly after a minute or two. Her cum blasts into #slave seemingly with more power and volume, Meigura cries with the intensity of her orgasm, and raggedly whispers 'Two'.\r\r#slave wonders and can feel Meigura's cocks are still hard, and Meigura, resumes fucking again, very urgently as if she is even more aroused. Meigura fucks fast, her previous cum spurting out around her cocks, she moans with some incredible arousal. #slave feels very aroused and starts to orgasm as she feels Meigura shout almost in pain and she cums again. Her cum blasts like small geysers, tremendous amounts of cum pumping, and she cries and shouts with the intensity of her orgasm.\r\r");
					else AddText(", both tightly into #slave's ass. Her cocks are very large and very hard, and she fucks hard and with skill. She has good control and as #slave feels #slavehisher orgasm approach, Meigura speeds up and as #slave cums #slaveheshe feels Meigura spasm and her cum pours into #slave's ass. They pant, Meigura's cocks still in #slave and Meigura whispers 'One', and she slowly resumes fucking, her cocks still hard, sliding easily, lubricated by her own cum.\r\r#slave groans but feels #slavehisher arousal build, but Meigura cums again quickly after a minute or two. Her cum blasts into #slave seemingly with more power and volume, Meigura cries with the intensity of her orgasm, and raggedly whispers 'Two'.\r\r#slave wonders and can feel Meigura's cocks are still hard, and Meigura, resumes fucking again, very urgently as if she is even more aroused. Meigura fucks fast, her previous cum spurting out around her cocks, she moans with some incredible arousal. #slave feels very aroused and starts to orgasm as ##slaveheshe feels Meigura shout almost in pain and she cums again. Her cum blasts like small geysers, tremendous amounts of cum pumping, and she cries and shouts with the intensity of her orgasm.\r\r");
		
					AddText("They pull apart, cum pouring from #slave and Meigura whispers 'Three, and thanks', her cocks softening.\r");
				} else {
					if (coreGame.HasCock) {
						AddText("lean against a wall as she kneels in front of #slavehimher. She expertly fondles #slave's cock quickly making #slavehimher erect, and then takes #slavehisher cock head into her mouth, licking and sucking. With amazing speed #slave cums, directly into Meigura's mouth, who swallows all the cum, and then whispers 'One'.\r\r#slave sighs after #slavehisher cum, but realises #slavehisher cock is still hard and Meigura is licking and sucking it again. #slave feels #slavehisher orgasm build, and this time it feels stronger, and again #slaveheshe cries and cums, #slavehisher hips thrusting as #slaveheshe cums and cums. Meigura swallows all her cum again, and whispers 'Two'\r\rWith some nervousness #slave feels #slavehisher cock is still hard, maybe harder and #slavehisher arousal has only receded a little. Meigura licks and stokes "+ coreGame.SlaveName + "'s cock expertly");
						if (coreGame.SlaveFemale) AddText(", and works fingers in and out of #slave's pussy");
						AddText(". As she does #slave feels #slavehisher orgasm build, stronger than before. #slave cries as #slavehisher climax hits, #slavehisher knees give way as #slaveheshe feels gouts of cum spurt into Meigura's mouth. #slave cums and cums and sees Meigura swallow part of the way to make more room. #slave cries out and sags as #slavehisher climax stops, and watches Meigura swallow again and whisper 'Three'.\r");
					} else {
						AddText("sit on a box as she kneels in front of her. She expertly lowers her head and licks slowly along #slaves pussy and then lightly licking her clit. She expertly licks and sucks #slave to a very quick orgasm, and whispers 'One'.\r\rMeigura leans back down and continues licking and #slave feels her arousal build quickly, toward something stronger. Again very quickly #slave orgasms, a strong orgasm that leaves her gasping and slumping tiredly. Meigura whispers 'Two'.\r\rMeigura leans in and resumes licking, this time working fingers into #slave's pussy and lightly rubs her ass. #slave feels her orgasm build amazingly quickly as Meigura fucks her fingers in #slave's pussy and slowly inserts a finger into her ass. As she does #slave cries out and orgasms, the strongest and longest she has ever had. She cries and gasps through her orgasm, and as she stops she hear Meigura whisper 'Three'.\r");
					}
				}
				AskHerQuestions(4017, 4018, 4019, 4023, "Freedom", "Love", "Health", "Nothing", "What does #slave wish for?", 4022, "Beauty");
				return true;
		
			// 4017 - freedom
			case 4017:
				coreGame.HideImages();
				Backgrounds.ShowNight();
				ShowThem(1, 1, 5);
				sd.Points(0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0);
				PersonSpeak(Id, "I cannot free you from slavery, but I can help your mind and soul to be free.");
				AddText("\r\rWith that " + SlaveVerb("feel") + " a rush of self-confidence and realises the power of demons.\r\rWhen #slaveheshe" +  NonPlural(" come") + " to #slavehisher senses, Meigura is gone and #assistant is awake and looking very embarrassed and insists they return home.");
				ShowPlanningNext();
				return true;
				
			// 4018 - Love
			case 4018:
				coreGame.HideImages();
				Backgrounds.ShowNight();
				ShowThem(1, 1, 5);
				sd.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 5, 0);
				PersonSpeak(Id, "You will love and be loved by all.");
				AddText("\r\rWith that #slave" + NonPlural(" feel") + " a rush of love and desire.\r\rWhen #slaveheshe" +  NonPlural(" come") + " to #slavehisher senses, Meigura is gone");
				AddText("and #assistant is awake and looking very embarrassed and insists they return home.");
				ShowPlanningNext();
				return true;
				
			// 4019 - health
			case 4019:
				coreGame.HideImages();
				Backgrounds.ShowNight();
				ShowThem(1, 1, 5);
				coreGame.FatigueBonus = coreGame.FatigueBonus + 20;
				sd.Points(0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0);
				if (coreGame.SlaveGender > 3) AddText("#slave feel fitter, rested and they are sure they can last longer before becoming tired.");
				AddText("#slave feels fitter, rested and is sure #slaveheshe can last longer before becoming tired.");
				AddText("\r\rWhen #slaveheshe comes to #slavehisher senses, Meigura is gone and #assistant is awake and looking very embarrassed and insists they return home.");
				ShowPlanningNext();
				return true;
				
			// 4022 - Beauty
			case 4022:
				coreGame.HideImages();
				Backgrounds.ShowNight();
				ShowThem(1, 1, 5);
				coreGame.ChangeClitCockSize(1.1);
				sd.Points(5, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText("#slave's complexion improves and also #slavehisher posture. A rush of arousal floods #slavehisher groin as #slavehisher ");
				if (coreGame.SlaveFemale) {
					coreGame.ChangeBustSize(1.1);
					if (!IsDickgirl()) AddText("clit grows larger and #slavehisher breasts swell larger and larger.");
					else AddText("cock grows larger and #slavehisher breasts swell larger and larger.");
				} else AddText("cock grows larger.");
				AddText("#slave feels an intense wave of arousal and dimly hears Meigura say,\r\r");
				PersonSpeak(Id, "Do not worry, this will pass and then your most beautiful parts will be enhanced.", true);
				AddText("#slave " + coreGame.OrgasmTextNP() + ", screaming with release.");
				AddText("\r\rWhen #slaveheshe comes to #slavehisher senses, Meigura is gone and #assistant is awake and looking very embarrassed and insists they return home.");
				ShowPlanningNext();
				return true;
				
			// 4023 - Nothing
			case 4023:
				Backgrounds.ShowNight();
				ShowThem(1, 1, 5);
				sd.Points(0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, 0, 0, 5, 0, 0);
				AddText("Meigura smiles and says,\r\r");
				PersonSpeak(Id, "In that case I give back to you the power I took.", true);
				AddText("\r\rShe kisses amd holds #slave, who feels an white hot arousal and a sudden, intense orgasm, but just as the orgasm peaks, another more intense sensation floods #slavehisher body. It is as if another orgasm, stronger than the last starts, reinforcing the first, driving #slavehisher pleasure higher. As #slaveheshe cannot think #slavehecan can bear it, a third sensation starts, another impossibly strong orgasm.\r\r#slave collapses orgasm or orgasms of extreme intensity washing though #slavehisher body. Meigura continues to hold #slavehimher, appearing to glow but looking like she is orgasming as well.\r\rWith a last strangled cry, #slave passes out from sheer pleasure.");
				AddText("\r\rWhen #slaveheshe comes to #slavehisher senses, Meigura is gone and #assistant is awake and looking very embarrassed and insists they return home.");
				ShowPlanningNext();
				return true;
				
		}
		return false;
	}
	
	public function StartNewSlave(visit:Boolean, keepmet:Boolean)
	{
		super.StartNewSlave(undefined, true);
		
		if (SMFlag == -1) {
			sd = _root;
			sd.VarIdol = SMFlag;
			coreGame.slaveData.VarIdol = sd.VarIdol;
		}
	}
}