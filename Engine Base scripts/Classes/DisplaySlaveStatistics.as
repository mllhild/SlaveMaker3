// DisplaySlaveStatistics - Slave Statistics Panel
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplaySlaveStatistics extends DisplayCommonStatistics {

	// Constructor
	public function DisplaySlaveStatistics(cg:Object)
	{ 
		super(cg.StatisticsGroup, cg);
		
		SetStatHintDetails(mcBase.Charisma, 0);
		SetStatHintDetails(mcBase.Sensibility, 1);
		SetStatHintDetails(mcBase.Refinement, 2);
		SetStatHintDetails(mcBase.Intelligence, 3);
		SetStatHintDetails(mcBase.Morality, 4);
		SetStatHintDetails(mcBase.Constitution, 5);
		SetStatHintDetails(mcBase.Cooking, 6);
		SetStatHintDetails(mcBase.Cleaning, 7);
		SetStatHintDetails(mcBase.Conversation, 8);
		SetStatHintDetails(mcBase.BlowJobs, 9);
		SetStatHintDetails(mcBase.Fucking, 10);
		SetStatHintDetails(mcBase.Temperament, 11);
		SetStatHintDetails(mcBase.Nymphomania, 12);
		SetStatHintDetails(mcBase.Obedience, 13);
		SetStatHintDetails(mcBase.Lust, 14);
		SetStatHintDetails(mcBase.Tiredness, 15);
		SetStatHintDetails(mcBase.Joy, 16);
		SetStatHintDetails(mcBase.Reputation, 17);
		SetStatHintDetails(mcBase.Special, 18);
		SetStatHintDetails(mcBase.Special2, 22);
	}
	
	public function SetSlave(sdo:Object) { 
		super.SetSlave(sdo);
		mcBase.sdata = sd;
	} 
	
	public function GetStatClipString(stat:String) : MovieClip
	{
		switch(stat.toLowerCase()) {
			case "charisma": return mcBase.Charisma;
			case "sensibility": return mcBase.Sensibility;
			case "refinement": return mcBase.Refinement;
			case "intelligence": return mcBase.Intelligence;
			case "morality":
			case "faith":
			case "ethics":
				return mcBase.Morality;
			case "constitution": 
			case "fitness":
				return mcBase.Constitution;
			case "cooking": return mcBase.Cooking;
			case "cleaning": return mcBase.Cleaning;
			case "conversation": return mcBase.Conversation;
			case "blowjobs":
			case "blowjob":
				return mcBase.Blowjobs;
			case "fucking":
			case "fuck":
				return mcBase.Fucking;
			case "temperament": return mcBase.Temperament;
			case "nymphomania": return mcBase.Nymphomania;
			case "obedience": return mcBase.Obedience;
			case "lust":
			case "libido":
				return mcBase.Lust;
			case "tiredness":
			case "fatigue":
				return mcBase.Tiredness;
			case "joy": return mcBase.Joy;
			case "reputation": return mcBase.Reputation; 
			case "special": return mcBase.Special;
			case "special2": return mcBase.Special2;
		}
		return null;
	}

	
	public function Show()
	{
		super.Show();
		
		var ypos:Number = 0;
		var gap:Number = 18.8;
		//if (sd.ShowSpecial != 1) gap++;
		//if (sd.ShowSpecial2 != 1) gap++;
		//if (sd.slSuccubusTraining == 0) gap++;
		//if (gap > 25) gap = 25;
		stln = 0;
		ypos = LayoutStats(mcBase.Charisma, ypos, gap);
		ypos = LayoutStats(mcBase.Sensibility, ypos, gap);
		ypos = LayoutStats(mcBase.Refinement, ypos, gap);
		ypos = LayoutStats(mcBase.Intelligence, ypos, gap);
		ypos = LayoutStats(mcBase.Morality, ypos, gap);
		ypos = LayoutStats(mcBase.Constitution, ypos, gap);
		ypos = LayoutStats(mcBase.Cooking, ypos, gap);
		ypos = LayoutStats(mcBase.Cleaning, ypos, gap);
		ypos = LayoutStats(mcBase.Conversation, ypos, gap);
		ypos = LayoutStats(mcBase.BlowJobs, ypos, gap);
		ypos = LayoutStats(mcBase.Fucking, ypos, gap);
		ypos = LayoutStats(mcBase.Temperament, ypos, gap);
		ypos = LayoutStats(mcBase.Nymphomania, ypos, gap);
		ypos = LayoutStats(mcBase.Obedience, ypos, gap);
		ypos = LayoutStats(mcBase.Lust, ypos, gap);
		ypos = LayoutStats(mcBase.Tiredness, ypos, gap);
		ypos = LayoutStats(mcBase.Joy, ypos, gap);
		ypos = LayoutStats(mcBase.Reputation, ypos, gap);
		ypos = LayoutStats(mcBase.Special, ypos, gap);
		ypos = LayoutStats(mcBase.Special2, ypos, gap);
		ypos = LayoutStats(mcBase.SexualEnergy, ypos, gap);
	}
	
	public function Hide()
	{
		super.Hide();
	}
		
	// Update display
	
	public function UpdateOtherSlaveDetailsCommon(sd:Object)
	{
		mcBase.Charisma.Value.text = coreGame.VarCharismaRounded;
		mcBase.Sensibility.Value.text = coreGame.VarSensibilityRounded;
		mcBase.Refinement.Value.text = coreGame.VarRefinementRounded;
		mcBase.Intelligence.Value.text = coreGame.VarIntelligenceRounded;
		mcBase.Constitution.Value.text = coreGame.VarConstitutionRounded;
		mcBase.Cooking.Value.text = coreGame.VarCookingRounded;
		mcBase.Cleaning.Value.text = coreGame.VarCleaningRounded;	
		mcBase.Conversation.Value.text = coreGame.VarConversationRounded;
		mcBase.Fucking.Value.text = coreGame.VarFuckRounded;
		mcBase.BlowJobs.Value.text = coreGame.VarBlowJobRounded;
		mcBase.Temperament.Value.text = coreGame.VarTemperamentRounded;
		mcBase.Obedience.Value.text = coreGame.VarObedienceRounded;
		mcBase.Tiredness.Value.text = coreGame.VarFatigueRounded;
		mcBase.Reputation.Value.text = coreGame.VarReputationRounded;
		mcBase.Joy.Value.text = coreGame.VarJoyRounded;
		mcBase.Lust.Value.text = coreGame.VarLibidoRounded;
		mcBase.Nymphomania.Value.text = coreGame.VarNymphomaniaRounded;
		mcBase.Morality.Value.text = coreGame.VarMoralityRounded;
		mcBase.Special.Value.text = coreGame.VarSpecialRounded;
		mcBase.Special2.Value.text = coreGame.VarSpecial2Rounded;
		mcBase.Sexualenergy.Value.text = coreGame.VarSexualEnergyRounded;
		
		var barmax:Number = coreGame.MaxStat;
		if (barmax < 100) barmax = 100;
		var maxlesbianb:Number = barmax;
		var maxlesbianf:Number = barmax;
		var lestr:Boolean = sd.BitFlag1.CheckBitFlag(10);
		if (lestr) {
			if (sd.IsFemale()) {
				maxlesbianb = coreGame.currLesbianTrainer * 100;
				maxlesbianf = coreGame.currLesbianTrainer * 100;
			} else {
				maxlesbianb = coreGame.currGayTrainer * 100;
				maxlesbianf = coreGame.currGayTrainer * 100;
			}
		}
		if (maxlesbianb < coreGame.AssistantMaxBlowJob) maxlesbianb = coreGame.AssistantMaxBlowJob;
		if (maxlesbianf < coreGame.AssistantMaxFuck) maxlesbianf = coreGame.AssistantMaxFuck;
	
		var maxo:Number = coreGame.AssistantMaxObedience;
		if (maxo < barmax) maxo = barmax;
		
		var maxn:Number = coreGame.AssistantMaxNymphomania > coreGame.MaxStat ? coreGame.AssistantMaxNymphomania : coreGame.MaxStat;
		if (maxn < 100) maxn = 100;
		if (maxn < sd.MaxRefinement) maxr = sd.MaxNymphomania;
		var maxc:Number = coreGame.AssistantMaxCharisma > coreGame.MaxStat ? coreGame.AssistantMaxCharisma : coreGame.MaxStat;
		if (maxc < 100) maxc = 100;
		if (maxc < sd.MaxCharisma) maxc = sd.MaxCharisma;
		var maxt:Number = coreGame.AssistantMaxTemperament > coreGame.MaxStat ? coreGame.AssistantMaxTemperament : coreGame.MaxStat;
		if (maxt < 100) maxt = 100;
		if (maxt < sd.MaxTemperament) maxt = sd.MaxTemperament;
		var maxs:Number = coreGame.AssistantMaxSensibility > coreGame.MaxStat ? coreGame.AssistantMaxSensibility : coreGame.MaxStat;
		if (maxs < 100) maxs = 100;
		if (maxs < sd.MaxSensibility) maxs = sd.MaxSensibility;
		var maxr:Number = coreGame.AssistantMaxRefinement > coreGame.MaxStat ? coreGame.AssistantMaxRefinement : coreGame.MaxStat;
		if (maxr < 100) maxr = 100;
		if (maxr < sd.MaxRefinement) maxr = sd.MaxRefinement;
		var maxcon:Number = coreGame.AssistantMaxConstitution > coreGame.MaxStat ? coreGame.AssistantMaxConstitution : coreGame.MaxStat;
		if (maxcon < 100) maxcon = 100;
		if (maxcon < sd.MaxConstitution) maxcon = sd.MaxConstitution;
		var maxj:Number = coreGame.AssistantMaxJoy > coreGame.MaxStat ? coreGame.AssistantMaxJoy : coreGame.MaxStat;
		if (maxj < 100) maxj = 100;
		if (maxj < sd.MaxJoy) maxj = sd.MaxJoy;
	
		barmax = 100 / barmax;
		SetBar(mcBase.Charisma, 100 * coreGame.VarCharismaRounded / maxc);
		SetBar(mcBase.Sensibility, 100 * coreGame.VarSensibilityRounded / maxs);
		SetBar(mcBase.Refinement, 100 * coreGame.VarRefinementRounded / maxr);
		SetBar(mcBase.Intelligence, coreGame.VarIntelligenceRounded * barmax);
		SetBar(mcBase.Morality, coreGame.VarMoralityRounded * barmax);
		SetBar(mcBase.Constitution, 100 * coreGame.VarConstitutionRounded / maxcon);
		SetBar(mcBase.Cooking, coreGame.VarCookingRounded * barmax);
		SetBar(mcBase.Cleaning, coreGame.VarCleaningRounded * barmax);
		SetBar(mcBase.Conversation, coreGame.VarConversationRounded * barmax);
		SetBar(mcBase.BlowJobs, 100 * coreGame.VarBlowJobRounded / maxlesbianb);
		SetBar(mcBase.Fucking, 100 * coreGame.VarFuckRounded / maxlesbianf);
		SetBar(mcBase.Temperament, 100 * coreGame.VarTemperamentRounded / maxt);
		SetBar(mcBase.Obedience, 100 * coreGame.VarObedienceRounded / maxo);
		SetBar(mcBase.Nymphomania, 100 * coreGame.VarNymphomaniaRounded / maxn);
		SetBar(mcBase.Lust, coreGame.VarLibidoRounded * barmax);
		SetBar(mcBase.Tiredness, sd.VarFatigue);
		SetBar(mcBase.Joy, 100 * coreGame.VarJoyRounded / maxj);
		SetBar(mcBase.Reputation, coreGame.VarReputationRounded);
		SetBarBase(mcBase.Nymphomania.BarMinimum, sd.MinNymphomania * barmax);
		SetBarBase(mcBase.Lust.BarMinimum, sd.MinLibido * barmax);
		SetBarBase(mcBase.BarFitness, 100 * sd.FatigueBonus / maxcon);
		barmax = sd.MaxSpecial > 100 ? 100 / sd.MaxSpecial : 1;
		SetBar(mcBase.Special, coreGame.VarSpecialRounded * barmax);
		barmax = sd.MaxSpecial2 > 100 ? 100 / sd.MaxSpecial2 : 1;
		SetBar(mcBase.Special2, coreGame.VarSpecial2Rounded * barmax);
		SetBar(mcBase.SexualEnergy, coreGame.VarSexualEnergyRounded);
		
		mcBase.Fucking.Limit._visible = ((lestr ? sd.VarFuckLesbian : sd.VarFuck) == sd.MaxFuck && sd.MaxFuck < coreGame.AssistantMaxFuck);
		mcBase.BlowJobs.Limit._visible = ((lestr ? sd.VarCunnilingus : sd.VarBlowJob) == sd.MaxBlowJob && sd.MaxBlowJob < coreGame.AssistantMaxBlowJob);
		mcBase.Obedience.Limit._visible = (sd.VarObedience == sd.MaxObedience && sd.MaxObedience < coreGame.AssistantMaxObedience);
		mcBase.Charisma.Limit._visible = (sd.VarCharisma == sd.MaxCharisma && sd.MaxCharisma < coreGame.AssistantMaxCharisma);
		mcBase.Refinement.Limit._visible = (sd.VarRefinement == sd.MaxRefinement && sd.MaxRefinement < coreGame.AssistantMaxRefinement);
		mcBase.Intelligence.Limit._visible = (sd.VarIntelligence == sd.MaxIntelligence && sd.MaxIntelligence < coreGame.AssistantMaxIntelligence);
		mcBase.Morality.Limit._visible = (sd.VarMorality == sd.MaxMorality && sd.MaxMorality < coreGame.AssistantMaxMorality);
		mcBase.Cooking.Limit._visible = (sd.VarCooking == sd.MaxCooking && sd.MaxCooking < coreGame.AssistantMaxCooking);
		mcBase.Cleaning.Limit._visible = (sd.VarCleaning == sd.MaxCleaning && sd.MaxCleaning < coreGame.AssistantMaxCleaning);
		mcBase.Conversation.Limit._visible = (sd.VarConversation == sd.MaxConversation && sd.MaxConversation < coreGame.AssistantMaxConversation);
		mcBase.Special.Limit._visible = (sd.VarSpecial == sd.MaxSpecial && sd.MaxSpecial < 100);
		mcBase.Special2.Limit._visible = (sd.VarSpecial2 == sd.MaxSpecial2 && sd.MaxSpecial2 < 100);
		
		mcBase.Special._visible = sd.ShowSpecial == 1;
		mcBase.Special.StatLabel.text = sd.SpecialName;
		mcBase.Special.BGStatLabel.text = sd.SpecialName;
		mcBase.Special2._visible = sd.ShowSpecial2 == 1;
		mcBase.Special2.StatLabel.text = sd.Special2Name;
		mcBase.Special2.BGStatLabel.text = sd.Special2Name;
		
		mcBase.HerStatistics.text = Language.strReplace(Language.strSLS, "#value", sd.GetFullName());
		
		mcBase.SexualEnergy._visible = sd.slSuccubusTraining > 0;		
	}
	
	public function HideStatChangeIcons() 
	{
		mcBase.Charisma.PlusIcon._visible = false;
		mcBase.Sensibility.PlusIcon._visible = false;
		mcBase.Refinement.PlusIcon._visible = false;
		mcBase.Intelligence.PlusIcon._visible = false;
		mcBase.Morality.PlusIcon._visible = false;
		mcBase.Constitution.PlusIcon._visible = false;
		mcBase.Cooking.PlusIcon._visible = false;
		mcBase.Cleaning.PlusIcon._visible = false;
		mcBase.Conversation.PlusIcon._visible = false;
		mcBase.BlowJobs.PlusIcon._visible = false;
		mcBase.Fucking.PlusIcon._visible = false;
		mcBase.Temperament.PlusIcon._visible = false;
		mcBase.Nymphomania.PlusIcon._visible = false;
		mcBase.Obedience.PlusIcon._visible = false;
		mcBase.Lust.PlusIcon._visible = false;
		mcBase.Tiredness.PlusIcon._visible = false;
		mcBase.Joy.PlusIcon._visible = false;
		mcBase.Reputation.PlusIcon._visible = false;
		mcBase.Special.PlusIcon._visible = false;
			
		mcBase.Charisma.MinusIcon._visible = false;
		mcBase.Sensibility.MinusIcon._visible = false;
		mcBase.Refinement.MinusIcon._visible = false;
		mcBase.Intelligence.MinusIcon._visible = false;
		mcBase.Morality.MinusIcon._visible = false;
		mcBase.Constitution.MinusIcon._visible = false;
		mcBase.Cooking.MinusIcon._visible = false;
		mcBase.Cleaning.MinusIcon._visible = false;
		mcBase.Conversation.MinusIcon._visible = false;
		mcBase.Temperament.MinusIcon._visible = false;
		mcBase.BlowJobs.MinusIcon._visible = false;
		mcBase.Fucking.MinusIcon._visible = false;
		mcBase.Nymphomania.MinusIcon._visible = false;
		mcBase.Obedience.MinusIcon._visible = false;
		mcBase.Lust.MinusIcon._visible = false;
		mcBase.Tiredness.MinusIcon._visible = false;
		mcBase.Joy.MinusIcon._visible = false;
		mcBase.Reputation.MinusIcon._visible = false;
		mcBase.Special.MinusIcon._visible = false;
		
	}
	
	// Hints
	
	public function ShowStatHint(stat:Number)
	{
		// standard variables used
		// genNumber - the value of the stat
		// genNumber2 - the maximum value of the stat
		// genString - the description of the stat
		// genString2 - the descrioption of the current value
			
		if (!coreGame.OtherSlaveShown && coreGame.modulesList.ShowStatHint(stat)) return;
		
		var sdo:Slave = SMData.GetSlaveObject(sd);
		
		if (coreGame.PersonOtherName != sd.SlaveName) coreGame.GetPersonOtherGenderText(sd.GenderIdentity);
		
		var lestr:Boolean = sd.BitFlag1.CheckBitFlag(10);
		var effm:Boolean = sd.BitFlag1.CheckBitFlag(62);
		
		var stb:String = sdo.GetStatNameBase(stat);
		if (stat == 4) stb = "morality";
		var MaxStat = coreGame.MaxStat;
		
		var appear:Boolean = stat == 0;
		
		var stNode:XMLNode = GetStatisticHintNode(stb, sdo, Language.XMLData.GetNodeC(sdo.sNode, "StatisticsDetails"), appear);
		if (stNode == null) stNode = GetStatisticHintNode(stb, sdo, Language.XMLData.GetNodeC("Statistics/StatisticsDetails"), appear);
		
		coreGame.genNumber = Math.ceil(Number(Language.XMLData.GetStat(stb.toLowerCase(), sd)));
		coreGame.genNumber2 = 100;
		var minval:Number = 0;
		var maxs:Number = 0;
		var maxval:Number = MaxStat;
		coreGame.genString2 = "";
	
		var maxlesbianb:Number = MaxStat;
		if (lestr) {
			if (sd.IsFemale()) maxlesbianb = coreGame.currLesbianTrainer * 100;
			else maxlesbianb = coreGame.currGayTrainer * 100;
		}
		
		switch(stat) {
			case 0:
				maxval = coreGame.AssistantMaxCharisma > MaxStat ? coreGame.AssistantMaxCharisma : MaxStat;
				maxs = sd.MaxCharisma;
				break;
			case 1:
				maxval = coreGame.AssistantMaxSensibility > MaxStat ? coreGame.AssistantMaxSensibility : MaxStat;
				maxs = sd.MaxSensibility;
				break;
			case 2:
				maxval = coreGame.AssistantMaxRefinement > MaxStat ? coreGame.AssistantMaxRefinement : MaxStat;
				maxs = sd.MaxRefinement;
				break;
			case 3:
				maxval = coreGame.AssistantMaxIntelligence > MaxStat ? coreGame.AssistantMaxIntelligence : MaxStat;
				maxs = sd.MaxIntelligence;
				break;
			case 4:
				maxval = coreGame.AssistantMaxMorality > MaxStat ? coreGame.AssistantMaxMorality : MaxStat;
				maxs = sd.MaxMorality;		
				break;
			case 5:
				maxval = coreGame.AssistantMaxConstitution > MaxStat ? coreGame.AssistantMaxConstitution : MaxStat;
				maxs = sd.MaxConstitution;		
				break;
			case 6:
				maxval = coreGame.AssistantMaxCooking > MaxStat ? coreGame.AssistantMaxCooking : MaxStat;
				maxs = sd.MaxCooking;
				break;
			case 7:
				maxval = coreGame.AssistantMaxCleaning > MaxStat ? coreGame.AssistantMaxCleaning : MaxStat;
				maxs = sd.MaxCleaning;
				break;		
			case 8:
				maxval = coreGame.AssistantMaxConversation > MaxStat ? coreGame.AssistantMaxConversation : MaxStat;
				maxs = sd.MaxConversation;		
				break;
			case 9:
				maxval = coreGame.AssistantMaxBlowJob > maxlesbianb ? coreGame.AssistantMaxBlowJob : maxlesbianb;
				maxs = sd.MaxBlowJob;
				break;
			case 10:
				maxval = coreGame.AssistantMaxFuck > maxlesbianb ? coreGame.AssistantMaxFuck : maxlesbianb;
				maxs = sd.MaxFuck;
				break;
			case 11:
				maxval = coreGame.AssistantMaxTemperament > MaxStat ? coreGame.AssistantMaxTemperament : MaxStat;
				maxs = sd.MaxTemperament;		
				break;
			case 12:
				maxval = coreGame.AssistantMaxNymphomania > MaxStat ? coreGame.AssistantMaxNymphomania : MaxStat;
				maxs = sd.MaxNymphomaniat;			
				break;
			case 13:
				maxval = coreGame.AssistantMaxObedience > MaxStat ? coreGame.AssistantMaxObedience : MaxStat;
				maxs = sd.MaxObedience;			
				break;
			case 14:
				maxval = coreGame.AssistantMaxLibido > MaxStat ? coreGame.AssistantMaxLibido : MaxStat;
				maxs = sd.MaxLibido;			
				minval = sd.MinLibido;
				break;
			case 16:
				maxval = coreGame.AssistantMaxJoy > MaxStat ? coreGame.AssistantMaxJoy : MaxStat;
				maxs = sd.MaxJoy;				
				break;
		}
		
		if (maxval < maxs) maxval = maxs;
		coreGame.genNumber2 = maxval < 100 ? 100 : maxval;
		coreGame.genString = "<b>";
		var mc:MovieClip = coreGame.dspMain.GetStatClipString(stb);
		if (mc == null) coreGame.genString += Language.GetText(stb, Language.statNode) + ":";
		else coreGame.genString += mc.StatLabel.text;
		coreGame.genString += "</b> " + Language.GetHtml("Description", stNode);
	
		if (stat == 9 && sd.VirginOral) coreGame.genString2 = Language.XMLData.GetXMLString("Virgin", stNode);
		else if (stat == 10 && (sd.VirginVaginal || sd.VirginAnal)) coreGame.genString2 = Language.XMLData.GetXMLString("Virgin", stNode);
		else if (coreGame.genNumber < 30) coreGame.genString2 = Language.XMLData.GetXMLString("Hint0-29", stNode);
		else if (coreGame.genNumber < 60) coreGame.genString2 = Language.XMLData.GetXMLString("Hint30-59", stNode);
		else if (coreGame.genNumber < 80) coreGame.genString2 = Language.XMLData.GetXMLString("Hint60-79", stNode);
		else coreGame.genString2 = Language.XMLData.GetXMLString("Hint80-100", stNode);
		if (coreGame.genString2 == "") {
			// non standard groups of stats ranges
			for (var aNode:XMLNode = stNode; aNode != null; aNode = aNode.nextSibling) {
				coreGame.genString2 = aNode.nodeName;
				if (coreGame.genString2.substr(0, 4).toLowerCase() == "hint") {
					var sl:Array = coreGame.genString2.substr(4).split("-");
					var rng1:Number = Number(sl[0]);
					var rng2:Number = rng1;
					if (sl.length > 1) {
						if (sl[1].toLowerCase() == "max") rng2 = 300;
						else rng2 = Number(sl[1]);
					}
					if (coreGame.genNumber >= rng1 && coreGame.genNumber <= rng2) {
						coreGame.genString2 = aNode.firstChild.nodeValue;
						break;
					}
				}
	
			}
		}
		if (stat == 5) {
			if (sd.FatigueBonus < 10) coreGame.genString2 += " " + Language.GetHtml("FitnessHint0-9", stNode);
			else if (sd.FatigueBonus < 30)  coreGame.genString2 += " " + Language.GetHtml("FitnessHint10-29", stNode);
			else if (sd.FatigueBonus < 60)  coreGame.genString2 += " " + Language.GetHtml("FitnessHint30-59", stNode);
			else coreGame.genString2 += " " + Language.GetHtml("FitnessHint60-max", stNode);
		} 
		
		coreGame.genString2 = coreGame.UpdateMacros(coreGame.genString2);
		SetHintText(Language.GetHtml("StatHint", "Statistics/StatisticsDetails"));
		if (coreGame.genNumber >= maxs && coreGame.genNumber2 < coreGame.genNumber2) AddHintText("\r\r" + Language.GetHtml("Limited", stNode));
		if (minval > 0) {
			var minstr:String = Language.GetHtml("LowerLimit", stNode);
			if (minstr != "") AddHintText("\r\r" + minstr);
		}
		
		// special stat modifiers
		if (stat == 12 || stat == 0) {
			if (!coreGame.OtherSlaveShown && sd.FairyXF > 0) coreGame.Hints.AddHintLang("\r\r" + Language.GetHtml("FaerieEffects", stNode));
		}
	
		ShowHint();
	}



	// Update theme of text fields
		
	public function UpdateText(str:String, aNode:XMLNode)
	{
		Language.ApplyLang(mcBase.Charisma.StatLabel, "Charisma");
		Language.ApplyLang(mcBase.Charisma.BGStatLabel, "Charisma");
		Language.ApplyLang(mcBase.Sensibility.StatLabel, "Sensibility");
		Language.ApplyLang(mcBase.Sensibility.BGStatLabel, "Sensibility");
		Language.ApplyLang(mcBase.Intelligence.StatLabel, "Intelligence");
		Language.ApplyLang(mcBase.Intelligence.BGStatLabel, "Intelligence");
		Language.ApplyLang(mcBase.Refinement.StatLabel, "Refinement");
		Language.ApplyLang(mcBase.Refinement.BGStatLabel, "Refinement");
		Language.ApplyLang(mcBase.Cooking.StatLabel, "Cooking");
		Language.ApplyLang(mcBase.Cooking.BGStatLabel, "Cooking");
		Language.ApplyLang(mcBase.Cleaning.StatLabel, "Cleaning");
		Language.ApplyLang(mcBase.Cleaning.BGStatLabel, "Cleaning");
		Language.ApplyLang(mcBase.Conversation.StatLabel, "Conversation");
		Language.ApplyLang(mcBase.Conversation.BGStatLabel, "Conversation");
		Language.ApplyLang(mcBase.Constitution.StatLabel, "Constitution");
		Language.ApplyLang(mcBase.Constitution.BGStatLabel, "Constitution");
		
		Language.ApplyLang(mcBase.Temperament.StatLabel, "Temperament");
		Language.ApplyLang(mcBase.Temperament.BGStatLabel, "Temperament");
		Language.ApplyLang(mcBase.Nymphomania.StatLabel, "Nymphomania");
		Language.ApplyLang(mcBase.Nymphomania.BGStatLabel, "Nymphomania");
		Language.ApplyLang(mcBase.Lust.StatLabel, "Lust");
		Language.ApplyLang(mcBase.Lust.BGStatLabel, "Lust");
		Language.ApplyLang(mcBase.Obedience.StatLabel, "Obedience");
		Language.ApplyLang(mcBase.Obedience.BGStatLabel, "Obedience");
		Language.ApplyLang(mcBase.Tiredness.StatLabel, "Tiredness");
		Language.ApplyLang(mcBase.Tiredness.BGStatLabel, "Tiredness");
		Language.ApplyLang(mcBase.Joy.StatLabel, "Joy");
		Language.ApplyLang(mcBase.Joy.BGStatLabel, "Joy");
		Language.ApplyLang(mcBase.Reputation.StatLabel, "Reputation");
		Language.ApplyLang(mcBase.Reputation.BGStatLabel, "Reputation");
		
		Language.ApplyLang(mcBase.Charisma.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Refinement.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Intelligence.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Morality.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Cooking.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Cleaning.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Conversation.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Fuck.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Blowjobs.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Obedience.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Fucking.Limit.LText, "Limited", true);
	}
	
	public function ApplyTheme(cvo:ColourScheme) { }

	
	// enable/disable
	public function Disable()
	{
		super.Disable();
	}
	
	public function Enable()
	{
		super.Enable();
	}
	
	public function Reset()
	{
		InitialiseModule();
	}
	
}
