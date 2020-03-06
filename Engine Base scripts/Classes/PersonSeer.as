// PersonSeer - class defining the Fortune Teller
// number 32
// lend modifier n/a
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonSeer extends Person {
		
	public function PersonSeer(cg:Object, cc:Object) { 
		super("Seer", cg, 32, 0, true, cc);
		mcBase = coreGame.VisitFortuneTeller;
	}
	
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();
		SetVisited();
		sd = _root;
		SMData = coreGame.SMData;
		coreGame.HideYesNoButtons();

		if ((coreGame.VarGold + SMData.SMGold) < 11) {
			SetLangText("NotEnoughMoney", "Shopping");
			BlankLine();
			return false;
		}
	
		Money(-10);
		var plc:Place = GetPlace("RuinedTemple");
		if (plc != null) {
			if (plc.IsStartedSpecialEvent()) {
				SetEvent(4111);
				coreGame.RuinedTemple.DoEventNextAsAssistant();
				return true;
			}
		}
		coreGame.dspMain.Hide();
		Backgrounds.ShowIntroBackgroundBlack();
		
		if (walk == undefined) {
			walk = mcBase.walk;
			if (walk == undefined) walk = false;
		}
		if (walk) coreGame.ShowLeaveButton(520);
		else {
			coreGame.NextEvent._visible = true;
			coreGame.NextEvent._x = 750;
		}
		mcBase.walk = walk;
		
		var nFin:Number = 0;
		
		mcBase.SlaveMakerName.text = SMData.SlaveMakerName;
		mcBase.SlaverAppearance.gotoAndStop(SMData.Gender);
		if (sd.Owner.GetOwner() != 0) {
			var remd:Number = coreGame.TrainingTime - coreGame.Elapsed;
			mcBase.DateInfo.text = remd + " day";
			if (remd > 1) mcBase.DateInfo.text = mcBase.DateInfo.text + "s";
			mcBase.DateInfo.text = mcBase.DateInfo.text + " remaining";
		} else mcBase.DateInfo.text = "no limit";
		var premain:Number = coreGame.Elapsed / coreGame.TrainingTime;
		
		switch(SMData.Gender) {
			case 1: mcBase.LGenderText.htmlText = Language.GetHtml("MaleSlaveMaker", "SlaveMaker", true, -1); break;
			case 2: mcBase.LGenderText.htmlText = Language.GetHtml("FemaleSlaveMaker", "SlaveMaker", true, -1); break;
			case 3: mcBase.LGenderText.htmlText = Language.GetHtml("DickgirlSlaveMaker", "SlaveMaker", true, -1); break;
		}
		coreGame.Language.CopyTF(mcBase.LGods, coreGame.SlaveMakerCreate1.LGods);
		mcBase.LDate.styleSheet = coreGame.styles;
		mcBase.LDate.htmlText = coreGame.DecodeDate(coreGame.GameDate);
		mcBase.GodsText.text = coreGame.SlaveMakerCreate1.GodsText.text;
		
		mcBase.LTitle.htmlText = Language.GetHtml("SeerTitle", "Shopping", true);
		mcBase.LQuestion.htmlText = Language.GetHtml("SeerQuestion", "Shopping", true);
		mcBase.SMReadingTitle.htmlText = Language.GetHtml("SeerSMReading", "Shopping", true);
		mcBase.LOptions.htmlText = Language.GetHtml("Title", "Options");
		mcBase.OptionsButton.LText.htmlText = Language.GetHtml("Title", "Options", false, -1);
		mcBase.LName.htmlText = Language.GetHtml("Name", "SlaveMaker");
		mcBase.LProfile.htmlText = Language.GetHtml("Profile", "SlaveMaker", true, 0, "", "", true);
		
		SMData.ShowSlaveMaker(1, 8);
		
		coreGame.Hints.HideHints();
			
		// Your Past
		switch (SMData.Talent) {
			case 0: 
				mcBase.Past.text = "Since childhood you have shown skills as a Slave Maker.";
				break;
			case 1: 
				mcBase.Past.text = "Wealth and privilege have been yours since you were born.";
				break;
			case 2: 
				mcBase.Past.text = "You are a leader, son of a mayor and a renowned warrior. Your mother trained you in the use of the sword.";
				break;
			case 3: 
				mcBase.Past.text = "You have lived all your life surrounded by traders and are an excellent bargainer. You are a little common.";
				break;
			case 4: 
				mcBase.Past.text = "Your father is shrouded in mystery and you have disturbing dreams.";
				break;
			case 5: 
				mcBase.Past.text = "Your greatest delight is the pain and domination of others. You especially like dressing in leather and love handling whips.";
				break;
			case 6: 
				mcBase.Past.text = "You are a specialist in training lesbian slaves.";
				break;
			case 7: 
				mcBase.Past.text = "You were raised in the old ways of the old gods. Trained in the use of potions and in the ancient ways.";
				break;
			case 8: 
				mcBase.Past.text = "You love to fuck and have found some women react with desire to your cum.";
				break;
			case 9: 
				mcBase.Past.text = "Your home is a land of Amazon people, dominated by hermaphrodites. Your breasts are intact so you are not as good an archer as your sisters but still excellent.";
				break;
			case 10: 
				mcBase.Past.text = "When young you were raped by a demonic woman and have had a cock since then. Sometimes your cock seems to guide your actions.";
				break;
		}
			
		// Her reading
		mcBase.SlaveReadingTitle.htmlText = Language.GetHtml("SeerSlaveReading", "Shopping", true);
		
		function EstimateStat(val:Number, premain:Number) : Number
		{
			var newn:Number = val / premain;
			if (newn > 100) newn = 100;
			return newn;
		}
	
		var total:Number = EstimateStat(coreGame.VarCharismaRounded, premain) + EstimateStat(coreGame.VarSensibilityRounded, premain) + EstimateStat(coreGame.VarRefinementRounded, premain) + EstimateStat(coreGame.VarIntelligenceRounded, premain) + EstimateStat(coreGame.VarMoralityRounded, premain) + EstimateStat(coreGame.VarConstitutionRounded, premain) + EstimateStat(coreGame.VarCookingRounded, premain) + EstimateStat(coreGame.VarCleaningRounded, premain) + EstimateStat(coreGame.VarConversationRounded, premain) + EstimateStat(coreGame.VarBlowJobRounded, premain) + EstimateStat(coreGame.VarFuckRounded, premain) + EstimateStat(coreGame.VarTemperamentRounded, premain) + EstimateStat(coreGame.VarNymphomaniaRounded, premain) + EstimateStat(coreGame.VarObedienceRounded, premain) + EstimateStat(coreGame.VarLibidoRounded, premain) + EstimateStat(coreGame.VarJoyRounded, premain) + EstimateStat(coreGame.VarReputationRounded, premain) + EstimateStat(coreGame.VarLovePoints, premain);
		total = Math.floor(total / 18);
		if (coreGame.LoveAccepted == 1 || coreGame.LoveAccepted == 10) {
			if (SMData.sLeadership > 0) total = total - (20 * (SMData.sLeadership * 5));
			else total = total - 20;
		}
	
		var reading:String;
		if (nFin != 1 && coreGame.IsPonygirl() && total > 50 && coreGame.BitGagWorn == 1 && coreGame.HarnessWorn == 1 && (coreGame.PonyTailWorn == 1 || coreGame.HasTail)) {
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " in a stable, harnessed and whinnying.";
		}
		if (nFin != 1 && coreGame.DickgirlXF == 2) {
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " is staring at a cock, it is #slavehisher own!";
		}
		if (nFin != 1 && coreGame.TotalBondage >= 20 && total > 40)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " tied in a bed in a shameful position, loving it.";
		} 
		if (nFin != 1 && coreGame.NumAphrodisiac >= 10)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " on the floor with empty eyes, drooling, an empty vial at #slavehisher side.";
		}
		if (nFin != 1 && coreGame.VarGold >= 3000 && coreGame.GetTotalDresses() >= 5 && total > 40)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " wearing luxurious clothes, in a big house.";
		}
		if (nFin != 1 && total >= 75 && nFin != 1)
		{
			nFin = 1;
			reading = "\"I see the owner will like this " + coreGame.SlaveBoyGirl + ", he will love #slavehimher.";
		} 
		if (nFin != 1 && coreGame.VarLibidoRounded >= 85 && total > 40)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " alone touching #slavehimherself, #slavehisher master is away and #slaveheshe can't bear it.";
		}
		if (nFin != 1 && coreGame.VarNymphomaniaRounded >= 85 && total > 40)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " in the street, trying to charm a young boy.";
		} 
		if (nFin != 1 && coreGame.VarObedienceRounded < 15)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " not obeying #slavehisher master, this one is not happy.";
		} 
		if (nFin != 1 && coreGame.VarCookingRounded >= 60 && coreGame.VarCleaningRounded >= 60 && total > 40)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " doing the cooking for #slavehisher master.";
		} 
		if (nFin != 1 && total >= 50)
		{
			nFin = 1;
			if (coreGame.VarObedienceRounded >= 80 && coreGame.VarMoralityRounded >= 55)
			{
				reading = "\"I see this " + coreGame.SlaveBoyGirl + " hanging at the arm of #slavehisher master, smiling.";
			}
			else if (coreGame.VarObedienceRounded < 30)
			{
				nFin = 1;
				reading = "\"I see this " + coreGame.SlaveBoyGirl + " forced to make #slavehisher master feel good, #slaveheshe is not happy.";
			}
			else
			{
				nFin = 1;
				reading = "\"I see this " + coreGame.SlaveBoyGirl + " making love with #slavehisher master. Looks like #slaveheshe likes this.";
			} 
		}
		if (nFin != 1)
		{
			nFin = 1;
			reading = "\"I see this " + coreGame.SlaveBoyGirl + " sad in a tiny room, #slaveheshe is not on the right path, change your way of training, quickly.";
		}
		
		if (coreGame.MaxTentacleHarem > 0) {
			reading = reading + "\r\rI see a dark thing following and lusting after #slavehimher.";
			if (coreGame.TotalTentacle > 0 && coreGame.SlaveFemale) reading = reading + " I see #slavehimher bearing it's children.";
		} else if (coreGame.TotalTentacle > 0 && coreGame.SlaveFemale) reading = reading + "\r\rI see a dark thing following and lusting after #slavehimher. I see her bearing it's children.";
		if (coreGame.TentacleHaunt != -1) {
			reading = reading + "\r\rPlease have #slavehimher avoid the ";
			switch(int(coreGame.TentacleHaunt % 1000)) {
				case 1:	reading = reading + "forest"; break;
				case 4:	reading = reading + "slums"; break;
				case 6: reading = reading + "port"; break;
				case 8:	reading = reading + "ruins"; break;
				case 9:	reading = reading + "beach"; break;
			}
			reading = reading + ", I see things chasing and catching #slavehimher there.";
		}
		if (coreGame.MilkInfluence > 0) reading = reading + "\r\rI see #slavehisher breasts becoming more and more important to #slavehimher."
		if (coreGame.LoveAccepted != 0 && coreGame.LesbianTraining) reading = reading + "\r\rI see her in the future loving a woman.";
		if (coreGame.VarLovePoints > 50) reading = reading + "\r\rI see this " + coreGame.SlaveBoyGirl + " looking only at you.";
		reading = reading + "\"";
		var slvreading:String = reading + "";
		coreGame.Score = total;
	
		// Your reading
		nFin = 0;
		reading = "\"";
		if (total >= 85) reading = "I see that you treasure this " + coreGame.SlaveBoyGirl + " and will not release her. ";
		if (coreGame.LoveAccepted == 1) reading = reading + "I see you love this " + coreGame.SlaveBoyGirl + ". ";
		reading = reading + "You are "; 
		if (SMData.SMConstitution > 80) reading = reading + "hardy";
		else if (SMData.SMConstitution > 50) reading = reading + "full of health";
		else reading = reading + "fit";
		reading = reading + ", ";
		if (SMData.SMAttack > 80) reading = reading + "a weapon master";
		else if (SMData.SMAttack > 50) reading = reading + "skilled";
		else reading = reading + "trained";
		reading = reading + ", ";
		if (SMData.SMDefence > 80) reading = reading + "nimble as a cat";
		else if (SMData.SMAttack > 50) reading = reading + "agile";
		else reading = reading + "of normal speed";
		reading = reading + ", ";
		if (SMData.SMLust > 80) reading = reading + "always needing sex";
		else if (SMData.SMLust > 50) reading = reading + "aroused";
		else reading = reading + "of normal sexuality";
		reading = reading + " and ";
		if (SMData.SMLust > 80) reading = reading + "silver tongued";
		else if (SMData.SMLust > 50) reading = reading + "well spoken";
		else reading = reading + "can carry a conversation";
		reading = reading + ".\"";
		mcBase.SlaveMakerReading1.text = coreGame.UpdateMacros(reading);
		
		Language.XMLData.EventText = reading;
		if (Language.XMLData.XMLEventByNode(Language.XMLData.GetNode("Visits/VisitSeer/SlaveMakerReading1"), true, undefined, true)) {
			mcBase.SlaveMakerReading1.text = coreGame.UpdateMacros(Language.XMLData.EventText);
		}
		Language.XMLData.EventText = "";
	
		
		reading = "\"";
		if (SMData.SMSpecialEvent == 6) {
			reading = reading + "A dark winged figure looms over you.\"\rShe asks you about your last dream. You tell her ";
			if (SMData.Corruption < 40) reading = reading + " of shapes struggling in the dark. She says \"I see good and evil fighting and evil is being held at bay";
			else if (SMData.Corruption < 60) reading = reading + " of visions of yourself fucking a struggling woman in a dark cavern, there is a tentacle filling her ass. She says \"I see evil winning the fight in you soul. Please try to redeem yourself";
			else reading = reading + " of dreams of yourself fucking a woman's ass. You see another woman near, mouth, ass, pussy full of tentacles, and you see it is #slave! The Seer says \"I see you have abandoned the fight against evil";
		} else if (SMData.SMSpecialEvent == 5) {
			reading = reading + "A horned woman is guiding your cock.\"\rThe Seer asks you about your last dream. You tell her ";
			if (SMData.Corruption < 40) reading = reading + " of dreams of passion and sex. She says\r\"I see you following your own destiny";
			else if (SMData.Corruption < 60) reading = reading + " of a dream of being bound and being fucked and fucking over and over. She says\r\"I see Hell guiding your actions. Please try to redeem yourself";
			else reading = reading + " of dreams of wild fucking, of women begging you to stop. You dream of cumming over and over and screams of pain. The Seer says\r\"I see you have lost, your cock controls you";
		} else reading = reading + "I see you training many girls.";
		reading = reading + "\"";
	
		mcBase.SlaveMakerReading2.text = coreGame.UpdateMacros(reading);
		
		Language.XMLData.EventText = reading;
		if (Language.XMLData.XMLEventByNode(Language.XMLData.GetNode("Visits/VisitSeer/SlaveMakerReading2"), true, undefined, true)) {
			mcBase.SlaveMakerReading2.text = coreGame.UpdateMacros(Language.XMLData.EventText);
		}
		Language.XMLData.EventText = "";
	
		mcBase._visible = true;
		mcBase.SlaveReading.text = coreGame.UpdateMacros(slvreading);
		slvreading = coreGame.SlaveGirl.VisitSeer(slvreading, total);
		if (slvreading != undefined && slvreading != "") mcBase.SlaveMakerReading2.text = coreGame.UpdateMacros(slvreading);
		
		Language.XMLData.EventText = slvreading;
		if (Language.XMLData.XMLEventByNode(Language.XMLData.GetNode("Visits/VisitSeer/SlaveReading"), true, undefined, true)) {
			mcBase.SlaveReading.text = coreGame.UpdateMacros(Language.XMLData.EventText);
		}
		Language.XMLData.EventText = "";
		
		mcBase._visible = true;
		mcBase.BGImage._visible = true;
	}
	
	public function DoEventNext() : Boolean
	{
		switch(coreGame.NumEvent) {
		
		// Fortune teller
		case 8:
			SMData.BitFlagSM.SetBitFlag(0);
			coreGame.UpdateSlaveMaker();
			DoEvent(9999);
			
			coreGame.dspMain.Show();
			coreGame.HideSlaveActions()
			coreGame.dspMain.ShowMainButtons();
			
			//"You now know where the fortune teller's shop is and you may visit it anytime, for 10GP of course."
			Language.SetLangText("AfterSeer", "Shopping");
			return true;
		}
		return false;
	}
	
}