// Inhuman Ancestry background

// Translation status: INCOMPLETE

import Scripts.Classes.*;

class SMInhumanAncestry extends SMMesmerism
{	
		
	public function SMInhumanAncestry(mc:MovieClip, cgm:Object) { super(mc, null, cgm); }
	
	public function AfterMeetPersonAsAssistant(person:Number, choice:Number, evt:String)
	{
		if (evt != "pray" || coreGame.AppendActText == false || !IsEventAllowable() || SMData.SMSpecialEvent != 6) {
			super.AfterMeetPersonAsAssistant(person, choice, evt);
		} else if (SMData.Corruption > 0) {
			 AddTextToStart(Language.GetHtml("SlaveMaker/InhumanAncestry/Pray", Language.flNode) + "\r\r");
		}
	}
	
	public function SMPreEvent() : Boolean
	{
		if (coreGame.currentCity.Home.hWards == 0 && ((SMData.SMSpecialEvent == 6 || SMData.SMSpecialEvent == 8) && coreGame.TentacleHaunt != -1)) {
			InhumanAncestryEarlyMorningEvent();
			return true;
		}
		return super.SMPreEvent();
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
					
		// 5020 - Inhuman ancestory - destroy
		 case 5020:
		 	SMData.SMPoints(0, 0, 0, 0, 0, 0, 1, 0, 0);
			coreGame.TentacleHaunt += 1000;
			coreGame.DoEventNext(251);
			return true;
			
		// 5021 - Inhuman ancestory - destroy and take
		 case 5021:
			coreGame.TentacleHaunt += 2000;
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 10, 0, 0);
			
		// 5022 - Inhuman ancestory - nothing
		 case 5022:
			coreGame.DoEventNext(251);
			return true;
			
		}
		return super.DoEventNextAsAssistant();
	}	
	
	public function InhumanAncestryEarlyMorningEvent()
	{
		SMData.ShowSlaveMaker(0);
		coreGame.Tentacles.ShowMovie("EventMorningTentacleVision", 1.1, 2);
		Backgrounds.ShowOverlay(0x241612);

		PlaySound("Breathing");
		SetText("You are dreaming, a deep but troubled sleep. You are moving quickly and low to the ground. You are following #slave, walking in ");
		switch(coreGame.TentacleHaunt) {
			case 1: AddText("a green place"); break;
			case 4: AddText("a place of narrow streets"); break;
			case 6.1: AddText("a place of wood and water"); break;
			case 8: AddText("the temple"); break;
			case 8: AddText("sand"); break;
		}
		AddText(".\r\rYou see a thing full of lust and desire to breed moving to take #slavehisher soft body. You know a darker presence is near, ready serve you. He can slay the thing, or save #slave for himself!");
		AskHerQuestions(5020, 5021, 5022, 0, "Destroy it!", "Destroy it and take #slavehimher", "Have him do nothing", "", "What will happen?");
	}
	
	public function DemonHelpAndRape(say:String)
	{
		coreGame.ShowAssistant(4);
		coreGame.StartMoaning(1);
		if (coreGame.SlaveGirl.ShowDemonRape() != true) coreGame.Generic.ShowDemonRape();
		Points(0, 5, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, -5, 0, 10, -5, 0, 0);
		AddText("#slave" + say + " and a large thing grabs #slavehimher, tentacles winding around her body. ");
		switch(Math.floor(Math.random()*3)) {
			case 0:	AddText("A tentacle probes her mouth trying to force it's way in, while another pulls at her panties."); break;
			case 1:	
				if (Naked) AddText("A tentacle slides over her bare skin winding around her breasts, another sliding towards her groin.");
				else AddText("A tentacle slides into her dress winding around her breasts, another slipping into her panties.");
				break;
			case 2:	
				if (Naked) AddText("A slimy tentacle slides along her bare skin, and rubs along the slit of her pussy.");
				else AddText("A slimy tentacle slides under her dress and panties, and rubs along the slit of her pussy.");
				break;
		}
		AddText("\r\rShe hears an inhuman shriek and the tentacle is pulled away by an impossibly black shape. She hears a sickening tearing and a spraying of blood and fluids. All the time she can barely see a large black shape between her and the tentacled thing.\r\rThe light dims and she hears the dark shape softly whispering 'mine'. Afraid she gets up to run but feels strong hands grab her, holding her immobile. Quickly the pitch black hands strip her naked while holding her firm against it's incredibly muscled body. As she is stripped she is aware of a large maleness growing from <b>his</b> groin.\r\r");
		switch(Math.floor(Math.random()*3)) {
			case 0:	
				coreGame.StartFucking(1);
				AddText("The figure bends her, kneeling face down and she feels the large cock sliding along the crease of her ass. She cries out as the large cock, slick with pre-cum or something else, plunges into her ass. The cock seems to enter impossibly deep until she feel the slap of his large testicles. Making no noise he fucks her, paying no care for her comfort or pleasure. He fucks fast, hard, deep, and she feels little arousal.\r\rHe fucks for many minutes until she feels slapping his testicles swell larger and larger. She hears a soft whisper and he thrusts in and cums, and she suddenly, impossibly orgasms, screaming her passion, as his cum pours into her bowels.");
				break;
			case 1:	
				coreGame.StartFucking(1);
				AddText("The figure leans her over and she feels a large cock sliding along the crease of her ass. She moans as he plunges into her pussy, his cock already slick. He fucks hard, fast, deep paying no attention to her needs or comfort. His large testicles slap against her clit and her arousal grows despite the terrible situation.\r\rHe fucks for minute after minute, silently and quickly. She whimpers and orgasms after a time, but he ignores her and continues fucking. Minutes later she feels his testicles swell and she hears an indistinct whisper and he thrusts in and cums, and she orgasms again, screaming her passion, as his cum floods and pours into her womb."); 
				break;
			case 2:	
				coreGame.StartFucking(2);
				AddText("The figure bends her over, a large cock sliding along the crease of her ass. She then feels another presence, he has two cocks! She cries out as he plunges slick cocks into both pussy and ass. He fucks hard and fast, paying no attention to her needs or comfort. His large testicles slap against her clit and her arousal grows despite the pain in her ass.\r\rHe fucks for minute after minute, silently and quickly. She whimpers and orgasms after a time, but he ignores her and continues fucking. Minutes later she feels his testicles swell huge and she hears a soft whisper and he thrusts both cocks in and cums. She also orgasms screaming and crying, as his cum floods and pours into her womb and bowels.");
				break;
		}
		AddText("\r\rThe thing drops her to the ground, cum dribbling out of her. She sees the shape fade into the darkness. Moments later the darkness lifts and she can see her surroundings. She gets to her feet and walks painfully home.");
		ShowPlanningNext();
	}
	
	public function EndingFinishAsAssistant(total:Number) : Boolean 
	{
		if (SMData.SMSpecialEvent == 6 && SMData.Corruption > 79) {
			// Demon
			coreGame.HideEndings();
			HideBackgrounds();			
			coreGame.AutoLoadImageAndShowMovie(coreGame.SMAvatar.GetFolder() + "/Ending - Demon.jpg|Images/Appearances/Default Images/Ending - Demon.jpg", 1, 1);
			coreGame.NumFin += 96;
			Language.XMLData.XMLGeneral("EndGame/SlaveMaker/EndingDemon/ReviewScene");
			coreGame.EndGame.ShowEndingNext();
			return true;
		}
		return super.EndingFinishAsAssistant(total);
	}
	
}
