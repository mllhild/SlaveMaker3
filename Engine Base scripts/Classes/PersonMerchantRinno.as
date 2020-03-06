// PersonMerchantRinno - Merchant Rinno
// number 1
// lend modifier -10
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonMerchantRinno extends Person {
		
	public function PersonMerchantRinno(cg:Object, cc:Object) { 
		super("Merchant", cg, 1, -10, true, cc);
	}
	
	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "shop") {
			HideBackgrounds();
			return super.ShowThem(1, 2, 4, delay);
		} else if (place == "visit") {
			super.ShowThem(1, 1, 1, delay);
			Backgrounds.ShowShop();
		} else if (place == "lend") {
			Backgrounds.ShowShop();
			if (coreGame.LendPerson == -1000) return super.ShowThem(1, 1, 1, delay);
			else return super.ShowThem(0, 0, 1, delay);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(true, false, undefined, undefined, false);
	}
	
	// Visiting
	
	// called when checking if the person can be visited.
	public function CanBeVisited() : Boolean
	{
		return ((sd.VarCharisma >= 30 && sd.VarConversation >= 30) && super.CanBeVisited());
	}
	
	
	// called to do the actual visit to the person
	public function Visit(walk:Boolean) : Boolean
	{
		DoneInitialVisit();		// see Place class
		if (coreGame.SlaveGirl.DoVisitShop() == true) return true;
		SetVisited();

		if (PersonFlag < 10)
		{
			AddText(SlaveVerb("talk") + " with Rinno, the shop owner, who explains to #slavehimher how to earn money while #slaveheshe helps out. #Slaveheshe flirts and charms the customers while he does the sale. He gets customers from a wide range of social classes and professions.\r\rHe gives #slavehimher some gold to thank #slavehimher for #slavehisher assistance.");
			coreGame.modulesList.VisitChatWithPerson(1);
			coreGame.People.HearGossip(Id);
			Money(50);
			var inc:Number = Math.floor(sd.VarCharisma / 20) + Math.floor(sd.VarConversation / 20);
			PersonFlag = Person.VisitVar(PersonFlag, inc, 10);
			sd.Points(0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, inc, 0, 0, 0, 0);
			
		} else PersonSpeak(1, "It was great to talk with you but I don't have the time anymore.");
		if (coreGame.RuinedTemple.CheckBitFlag(32) && (!coreGame.RuinedTemple.CheckBitFlag(40))) {
			AddText("\r\r" + SlaveVerb("ask") + " Rinno if he has heard of a place called the ruins. He mentions he once sold some mining gear to a odd, disgusting person who muttered to himself as he left 'ruins, mine, mine, heartstone, dead'.");
			coreGame.RuinedTemple.SetBitFlag(40);
		}
	
		return true;
	}
	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{
		if (sd.OrgasmDrugEffecting == -1) {
			SetText("Rinno refuses to be loaned #slave to prevent the possibility of another overdose.");
			return false;
		}
		return ((sd.VarCharisma >= 30 && sd.VarConversation >= 30) && super.CanBeLoanedTo());
	}
	
	public function LoanTo() : Boolean
	{
		if (IsDayTime()) {
			if (sd.VarCharisma >= 30 && sd.VarConversation >= 30 && !coreGame.Naked) {
				sd.Points(-2, 0, 0, -2, 0, 0, 0, 9 + (3 * parentCity.Home.hKitchen), 0, 0, 0, 0, -2, 0, 0, 0, 9 - (3 * parentCity.Home.hKitchen), 0, 0, 0);
				coreGame.SlaveGirl.ShowChoreCleaning();
				if (coreGame.UseImages) coreGame.ShowActImage(1002);
				if (coreGame.UseGeneric) coreGame.Generic.ShowChoreCleaning();
				SetText("Rinno the Merchant has #slave help around the shop, cleaning and serving customers. He does tell #slave to flirt with any ");
				if (coreGame.SlaveFemale) AddText("male");
				else AddText("female");
				AddText(" customers, but nothing too overt or obscene. He mentions often he wants his store to be an orderly and respectable place.");
			} else {
				sd.Points(-2, 0, 0, -2, 0, 0, 0, 9 + (3 * parentCity.Home.hKitchen), 0, 0, 0, 0, -2, 0, 0, 0, 9 - (3 * parentCity.Home.hKitchen), 0, 0, 0);
				coreGame.SlaveGirl.ShowChoreCleaning();
				if (coreGame.UseImages) coreGame.ShowActImage(1002);
				if (coreGame.UseGeneric) coreGame.Generic.ShowChoreCleaning();
				if (coreGame.Naked) {
					SetText("Rinno the Merchant has #slave clean the store areas of the shop, explaining that he is not running a brothel or sleazy bar.");
					if (coreGame.SlaveFemale) AddText(" While explaining this he looks long and appreciatively at #slave's body.");
					else AddText(" He briefly comments about 'why a male..'");
				} else 	{
					SetText("Rinno the Merchant has #slave clean the store areas of the shop, explaining.\r\r");
					PersonSpeak(1, SlaveName + ", you need to learn more to assist in serving my customers. Oh, I do not mean 'serving', this is not a brothel, I mean attending their needs. Again I do not mean 'needs' but what they want to buy here.\r\rMy customer has some standards for those who server here and so far you are not up to those standards.", true);
				}
				AddText("\r\rOccasionally he visits to get an item from the stores and gives instructions or even to briefly chat.");
			}
		} else {
			if (coreGame.SlaveFemale) {
				coreGame.ResetNotFucked();
				coreGame.SlaveGirl.ShowSexActLendHer();
				coreGame.ShowActImage();
				sd.Points(0, -4, 0, 0, -4, 3, 0, 0, 0, 3, 3, -4, 20, 18, -6, 0, 6, 0, 2, 0);
				SetText("Rinno states that tonight is just for enjoyment as the shop is not open, and makes it clear that he wants #slave for sex. He ");
				if (!coreGame.Naked) AddText("has #slavehimher strip completely naked and then he ");
				AddText("lightly ties #slavehimher securely enough so #slaveheshe cannot get free or resist, but loose enough to be comfortable. He then strips naked, his figure is thin and not athletic.\r\r");
				if (coreGame.PotionsUsed[13] == 0) {
					AddText("Rinno picks up a bottle and pours a liquid from it onto #slave's genitals, working it, a fine oil, carefully into pussy and ass. ");
					if (coreGame.HasCock) AddText("He avoids touching #slavehimher" + coreGame.CockText() + ", with a look of slight distaste and a muttered 'sorry'. "); 
					AddText("With no more foreplay he easily slides his cock into " + coreGame.SlaveName1 + "'s pussy, fucking urgently and cumming very quickly with a grunt. He pulls free and stands, his cock softening. He picks up another potion bottle and sips a little, his cock immediately springs erect. He kneels before " + SlaveName2 + " and raises her legs and slips his cock into her well oiled ass. He fucks less urgently but cums almost as quickly.\r\r" + SlaveVerb("look") + " a bit disappointed, ");
					if (coreGame.HasCock) AddText("#slavehisher" + coreGame.CockText() + " barely erect, ");
					AddText("and watch as he takes another sip, his cock springing erect again. ");
					AddText("He then picks up a bottle, a dark purple colour and offers #slave a drink to help #slavehimher enjoy this evening.");
				} else {
					AddText("He offers #slave a drink of the purple orgasm potion to help #slavehimher enjoy this evening.");
				}
				AddText("\r\rDoes #slave drink?\r");
				DoYesNoEventXY(8400);
			} else {
				sd.Points(0, 0, 3, 3 ,0, -2, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				coreGame.SlaveGirl.ShowChoreDiscuss();
				SetText("During the evening Rinno just talks with #slave on a wide range of issues, from business to potion lore and how to deal with people.\r\rHe is a surprisingly good speaker and entertaining.");
			}
		}
		return true;
	}

	
	// Events
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.NumEvent) {
				
			// Orgasm drug bad ending
			case 8401:
				BadEndingOrgasmDrug();
				return true;
				
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			case 8400:
				if (coreGame.HasCock) SetText("Rinno quickly places " + Plural("a sheath") + " over #slave's " + Plural("cock") + " explaining it will catch #slavehisher cum and keep things cleaner.\r\r");
				if (!coreGame.Potions.DrinkPotion(13, 0, "")) {
					AddText(SlaveName + " ");
					AddText(coreGame.PotionsUsed[13] == 0 ? "curiously " + NonPlural("drink") + " the potion" : "eagerly " + NonPlural("drink") + " the potion");
					if (coreGame.PotionsUsed[13] == 1) {
						AddText(" while Rinno starts fucking " + SlaveName1 + " again. #slave starts feeling very odd and very, very aroused. Rinno fucks a bit slower, clearly waiting, ");
						if (coreGame.HasCock) AddText("and #slave can feel an extreme arousal with waves of heat pulsing through #slavehisher breasts and #slavehisher" + coreGame.CockText() + " throbs, intensely erect in the " + Plural("sheath") + ". #Slavehisher nipples feel intensely hard and #slavehisher skin tingles and flushes. The arousal is almost too intense and #slaveheshe" + NonPlural(" scream") + " out in passion and then strains as incredible spasms explode though #slavehisher" + coreGame.CockText() + " intense spurts of cum flooding into the " + Plural("sheath") + ". Rinno quickly speeds up and cums into " + SlaveName1 + "'s orgasming pussy.\r\rRinno sits back smiling as he watches #slave, shuddering through the most intense " + Plural("climax") + " #slaveheshe has ever experienced. The " + Plural("climax") + " " + NonPlural("continue") + " on and on, cum spraying and spurting. Rinno's cock is erect again and he starts fucking the cumming " + SlaveName2 + " whose cock won't stop cumming. As he fucks he tells #slavehimher\r\r");
						else AddText("and #slave can feel an extreme arousal with waves of heat pulsing through #slavehisher breasts and " + Plural("pussy") + ". #Slavehisher nipples feel intensely hard and #slavehisher skin tingles and flushes. The arousal is almost too intense and #slaveheshe" + NonPlural(" scream") + " out in passion and then strains as incredible spasms of orgasm explode though #slavehisher" + Plural("body") + ". Rinno quickly speeds up and cums into " + SlaveName1 + "'s orgasming pussy.\r\rRinno sits back smiling as he watches #slave, shuddering through the most intense " + Plural("orgasm") + " #slaveheshe has ever experienced. The " + Plural("orgasm") + " " + NonPlural("continue") + " on and on, each time fading and then bursting anew as strong as before. Rinno's cock is erect again and he starts fucking the orgasming " + SlaveName2 + " whose orgasm won't stop. As he fucks he tells #slavehimher\r\r");
						PersonSpeak(1, "Oh, that is the most powerful sex drug, bringing the strongest orgasm, but a bit too strong. Ummm it lasts as long as the drug is in your body, maybe an hour or two. Ahhhhhh", true);
						if (coreGame.HasCock) AddText("\r\rHe cums again, but #slave " + NonPlural("does") + " not notice, lost in never ending climax. He fucks #slave many times, occasionally sipping his potion and also giving #slave energy drinks so #slaveheshe " + NonPlural("does") + " faint from exhaustion. Eventually Rinno tires and leaves #slave to #slavehisher" + Plural(" orgasm") + ", slowly lessening in strength but still not stopping. After quite a long time #slave collapses, the " + Plural("orgasm") + " fading and stopping, and #slaveheshe faints...");
						else AddText("\r\rHe cums again, but #slave " + NonPlural("does") + " not notice, lost in never ending orgasm. He fucks #slave many times, occasionally sipping his potion and also giving #slave energy drinks so #slaveheshe " + NonPlural("does") + " not faint from exhaustion. Eventually Rinno tires and leaves #slave orgasming, #slavehisher pussy wet and still still spasming, slowly lessening in strength but still not stopping. After quite a long time #slave collapses, the " + Plural("orgasm") + " fading and stopping, and #slaveheshe faints..."); 
						AddText("\r\rWhen " + SlaveVerb("recover") + " Rinno explains more about the potion and cautions #slavehimher not to take it too often, less than weekly, as it can have extreme side effects if abused. He asks #slave to remind him if he is giving it too often when #slaveheshe is loaned again, he is a little forgetful..."); 
					} else {
						if (coreGame.OrgasmDrugEffecting > 23) {
							AddText(" and #slave screams as incredibly intense waves of orgasm crash through #slavehimher");
							if (coreGame.HasCock) AddText(", #slavehisher" + coreGame.CockText() + " pumping and pulsing jets of cum");
							AddText(". #Slaveheshe loses all rationality, lost completely in the intensity of #slavehisher" + coreGame.OrgasmText() + ". The pleasure is impossibly intense and the" + coreGame.OrgasmText() + " reaches an extreme intensity, and does not fade, like #slavehimher is at the peak of the strongest possible" + coreGame.OrgasmText() + " that never stops.\r\rRinno looks concerned and gives #slavehimher a potion but it has no effect.\r\rSometime later a messenger arrives and asks you to immediately visit Rinno. You head there immediately, and you see #slave lying unconscious and Rinno sitting there.\r\r");
							if (coreGame.BadEndsOn) {
								PersonSpeak(1, "I am sorry, #slave has overdosed on a potion meant to give pleasurable orgasms. #Slavehisher body will not stop orgasming, feel #slaveheshe is still orgasming weakly, despite passing out from exhaustion. When #slaveheshe wakes the orgasm will intensify again, and I do not know how to stop it.\r\rThere is not cure or treatment, I have consulted my books and I am sorry, I will recompense you for your slave. I will arrange for an associate of mine to study and research a treatment. Hopefully #slave can be eventually cured, but until then #slaveheshe will be treated well.", true);
								AddText("\r\rYou are shocked by this revelation, and shout and argue with Rinno, but eventually you understand he speaks truthfully and nothing can be done. You negotiate a payment and regretfully leave #slave to him.");
								DoEvent(8401);
							} else {
								coreGame.VarLibido = 0;
								PersonSpeak(1, "I am sorry, #alave has overdosed on a potion meant to give pleasurable orgasms. #Slavehisher body will not stop orgasming, feel #slaveheshe is still orgasming weakly, despite passing out from exhaustion. When #slaveheshe wakes the orgasm will probably pass, but I cannot risk another overdose. Please make sure #slaveheshe take some Soothing Potions. I will no longer accept #slave for a loan just in case I forget again. I know #slave will never refuse the potion. The overdose will heighten #slave's arousal, probably permanently.", true);
								AddText("\r\rYou are shocked by this revelation, and take #slave home.");
								coreGame.OrgasmDrugEffecting = -1;
								coreGame.MinLibido = 100;
							}
						} else if (coreGame.OrgasmDrugEffecting > 8) {
							AddText(" and #slave screams as incredibly intense waves of orgasm crash through #slavehimher");
							if (coreGame.HasCock) AddText(", #slavehisher" + coreGame.CockText() + " pumping and pulsing jets of cum");
							AddText(". #Slaveheshe loses all rationality, lost completely in the intensity of #slavehisher" + coreGame.OrgasmText() + ".\r\rRinno looks concerned and gives #slavehimher a potion that lessens the intensity of #slave's" + coreGame.OrgasmText() + " and #slaveheshe is aware of him saying,\r\r");
							PersonSpeak(1, "You have taken this too often. The potion fades very slowly and if you take too much it can have a permanent effect. Do not have anymore.", true);
							AddText("\r\rWith that he resumes fucking #slave but all #slave can think of is the amazing pleasure of #slavehisher" + coreGame.OrgasmText() + "...");
						} else {
							AddText(" and #slave can feel the fast rush of the drug, waves of heat and tingling skin. As Rinno starts fucking " + coreGame.SlaveName2 + " #slaveheshe");
							if (coreGame.SlaveGender > 3) AddText(" both ");
							AddText("erupt in screaming ");
							if (coreGame.HasCock) AddText(Plural("climax") + " " + coreGame.CockText() + " spurting cum non-stop");
							else AddText("non-stop " + Plural("orgasm"));
							AddText(". Time passes in a blur as #slavehisher" + coreGame.OrgasmText() + " crest and fade, but never stop. Rinno fucks #slavehimher many times until he tires, leaving #slavehimher to #slavehisher" + coreGame.OrgasmText() + "."); 
						}
					}
				}
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{		
		switch(coreGame.NumEvent) {
			case 8400:
				SetText("Rinno shrugs and puts the potion down and turns back to #slave his cock erect.\r\rTime passes as he fucks #slave over and over using several potions to maintain his erection and to revitalise himself. He seems to have no interest in oral sex, but fucks #slave's in the pussy and ass equally. Despite his speed and lack of technique, #slave does orgasm a few times, more due to persistence and frequency of the fuckings than any skill.\r\rEventually he tires or loses interest and talks a little about potions and business but only for a little before he dozes off to sleep, leaving #slave tied and leaking his cum.");
				return true;
		}
		return false;
	}
	
	private function BadEndingOrgasmDrug()
	{
		AddText(coreGame.SlaveName + " wakes from an exhausted sleep, having a dim memory of days passing in intense orgasm, but most of all remembering the pleasure. " + NameCase(coreGame.SlaveHeSheVerb("feel")) + " different, the orgasm strange, and " + SlaveName2 + " can clearly feel a person's cock fucking her ass. ");
		if (coreGame.DickgirlOn == 1) {
			AddText("#Slavehisher" + coreGame.CockText() + " is encased in a tube and there is a strong suction on it.");
			if (!coreGame.IsDickgirl()) AddText("What?" + coreGame.CockText() + "? #Slaveheshe knows now that #slaveheshe is a hermaphrodite somehow!");
			AddText("\r\rThe person fucking " + coreGame.SlaveName2 + " thrusts in and cums in a long shuddering orgasm, cum flooding into " + coreGame.SlaveName2 + "'s bowels. #slave" + coreGame.OrgasmText() + " intensely, and again it continues on and on. The person who was fucking " + SlaveName2 + " walks around so #slavehimher can see them, ");
			if (coreGame.TotalVisitAstrid > 0) AddText("it is Astrid");
			else AddText("it is a woman, well a hermaphrodite, who introduces herself as Astrid");
			AddText(",\r\r");
			PersonSpeak(16, "I see you are awake and that your condition continues. Do not worry just enjoy your orgasms, I am trying to treat you, hopefully I can do something. Until then you are mine to use and harvest as I like. Your " + coreGame.CockText() + NonPlural(" make") + " a moderate amount of cum for me to process, and your " + Plural("body") + NonPlural(" is") + " enjoyable for me to fuck.\r\rDo not fear, even if I cannot cure you I will make sure you have a long life of pleasure, and I have many people who love to fuck women in orgasm. Also I assure you motherhood, my friends and I do want children.", true);
			AddText("\r\rAstrid's cock stiffens and she slowly strokes it,\r\r");
			PersonSpeak(16, "You know, it is so 'hard' to get time to research and study, I am surrounded by beautiful women cumming delightfully. How can I not be erect all the time? Also a certain potion means their cum is the only food I need or want, it is so delicious. It also heightens my need to cum.\r\rWell, #slave you are new...", true);
		} else {
			AddText("\r\rThe person fucking " + coreGame.SlaveName2 + " thrusts in and cums in a long shuddering orgasm, cum flooding into " + coreGame.SlaveName2 + "'s bowels. #slave" + coreGame.OrgasmText() + " intensely, and again it continues on and on. Another person walks in so #slavehimher can see them, ");
			if (coreGame.TotalVisitAstrid > 0) AddText("it is Astrid");
			else AddText("it is a woman, who introduces herself as Astrid");
			AddText(",\r\r");
			PersonSpeak(16, "I see you are awake and that your condition continues. Do not worry just enjoy your orgasms, I am trying to treat you, hopefully I can do something. Until then you are mine to use and harvest as I like. Your " + Plural("body") + " are enjoyable for my friends to fuck.\r\rDo not fear, even if I cannot cure you I will make sure you have a long life of pleasure, and I have many people who love to fuck women in orgasm. Also I assure you motherhood, my friends do want children...", true);
		}
		coreGame.TrainingComplete(false, 9003);
	}


}