// DisplaySlaveMakerStatistics - Slave Statistics Panel
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplaySlaveMakerStatistics extends DisplayCommonStatistics {

	// Constructor
	public function DisplaySlaveMakerStatistics(cg:Object)
	{ 
		super(cg.SlaveMakerStatisticsGroup, cg);
		
		// Hints
		SetStatHintDetails(mcBase.Conversation, 0);
		SetStatHintDetails(mcBase.Constitution, 1);
		SetStatHintDetails(mcBase.Renown, 2);
		SetStatHintDetails(mcBase.Attack, 3);
		SetStatHintDetails(mcBase.Defence, 4);
		SetStatHintDetails(mcBase.Lust, 5);
		SetStatHintDetails(mcBase.Corruption, 6);
		SetStatHintDetails(mcBase.Dominance, 7);
		SetStatHintDetails(mcBase.Charisma, 8);
		SetStatHintDetails(mcBase.Refinement, 9);
		SetStatHintDetails(mcBase.Nymphomania, 10);
		SetStatHintDetails(mcBase.Tiredness, 11);
		SetStatHintDetails(mcBase.SexualEnergy, 12);
	}
	
	
	public function Show()
	{
		super.Show();		
	}
	
	public function Hide()
	{
		super.Hide();
	}
		
	// Update display
	
	public function Update()
	{	
		mcBase.Constitution.Value.text = Math.ceil(SMData.SMConstitution);
		SetBar(mcBase.Constitution, SMData.SMConstitution);
		mcBase.Lust.Value.text = Math.ceil(SMData.SMLust);
		SetBar(mcBase.Lust, SMData.SMLust);
		mcBase.Corruption.Value.text = Math.ceil(SMData.Corruption);
		SetBar(mcBase.Corruption, SMData.Corruption);
		mcBase.Renown.Value.text = Math.ceil(SMData.SMReputation);
		SetBar(mcBase.Renown, SMData.SMReputation);
		mcBase.Attack.Value.text = Math.ceil(SMData.SMAttack);
		SetBar(mcBase.Attack, SMData.SMAttack);
		mcBase.Defence.Value.text = Math.ceil(SMData.SMDefence);
		SetBar(mcBase.Defence, SMData.SMDefence);
		mcBase.Conversation.Value.text = Math.ceil(SMData.SMConversation);
		SetBar(mcBase.Conversation, SMData.SMConversation);
		mcBase.Dominance.Value.text = Math.ceil(SMData.SMDominance);
		SetBar(mcBase.Dominance, SMData.SMDominance);
		mcBase.Charisma.Value.text = Math.ceil(SMData.SMCharisma);
		SetBar(mcBase.Charisma, SMData.SMCharisma);
		mcBase.Refinement.Value.text = Math.ceil(SMData.SMRefinement);
		SetBar(mcBase.Refinement, SMData.SMRefinement);
		mcBase.Nymphomania.Value.text = Math.ceil(SMData.SMNymphomania);
		SetBar(mcBase.Nymphomania, SMData.SMNymphomania);
		mcBase.Tiredness.Value.text = Math.ceil(SMData.SMTiredness);
		SetBar(mcBase.Tiredness, SMData.SMTiredness);
		SetBar(mcBase.SexualEnergy, SMData.SexualEnergy);
		
		SetBarBase(mcBase.Lust.BarMinimum, SMData.SMMinLust);
		SetBarBase(mcBase.Corruption.BarMinimum, SMData.SMMinCorruption);
	
		var maxconv:Number = SMData.sRefined > 0 ? 100 : 85;
		if (SMData.SMAdvantages.CheckBitFlag(2) && maxconv < 90) maxconv = 90;
		var maxdom:Number = SMData.IsDominatrix() ? 100 : 85;	
		var maxlust:Number = SMData.Gender == 3 ? 80 : 70;
		if (SMData.SMAdvantages.CheckBitFlag(8)) maxlust += 10;
		if (SMData.SMDominance < 40) maxlust += 10;
		else if (SMData.SMDominance < 20) maxlust = 100;
	
		mcBase.Conversation.Limit._visible = SMData.SMConversation >= maxconv && maxconv < 100;
		mcBase.Attack.Limit._visible = SMData.SMAttack >= (SMData.SMAdvantages.CheckBitFlag(3) ? 100 : 75) && SMData.SMAttack < 100;
		mcBase.Defence.Limit._visible = SMData.SMDefence >= (SMData.SMAdvantages.CheckBitFlag(3) ? 100 : 75) && SMData.SMDefence < 100;
		mcBase.Lust.Limit._visible = SMData.SMLust >= maxlust;
		mcBase.Dominance.Limit._visible = SMData.SMDominance >= maxdom;
		
		mcBase.SMName.text = SMData.SlaveMakerName;
	}
	
	public function HideStatChangeIcons() 
	{		
		mcBase.Conversation.PlusIcon._visible = false;
		mcBase.Constitution.PlusIcon._visible = false;
		mcBase.Attack.PlusIcon._visible = false;
		mcBase.Defence.PlusIcon._visible = false;
		mcBase.Renown.PlusIcon._visible = false;
		mcBase.Corruption.PlusIcon._visible = false;
		mcBase.Lust.PlusIcon._visible = false;
		mcBase.Dominance.PlusIcon._visible = false;
		mcBase.Charisma.PlusIcon._visible = false;
		mcBase.Refinement.PlusIcon._visible = false;
		mcBase.Nymphomania.PlusIcon._visible = false;
		mcBase.Tiredness.PlusIcon._visible = false;
			
		mcBase.Conversation.MinusIcon._visible = false;
		mcBase.Constitution.MinusIcon._visible = false;
		mcBase.Attack.MinusIcon._visible = false;
		mcBase.Defence.MinusIcon._visible = false;
		mcBase.Renown.MinusIcon._visible = false;
		mcBase.Corruption.MinusIcon._visible = false;
		mcBase.Lust.MinusIcon._visible = false;
		mcBase.Dominance.MinusIcon._visible = false;
		mcBase.Charisma.MinusIcon._visible = false;
		mcBase.Refinement.MinusIcon._visible = false;
		mcBase.Nymphomania.MinusIcon._visible = false;
		mcBase.Tiredness.MinusIcon._visible = false;	
	}


	// Update thene of text fields
		
	public function UpdateText(str:String, aNode:XMLNode)
	{
		Language.ApplyLang(mcBase.Attack.StatLabel, "Attack");
		Language.ApplyLang(mcBase.Attack.BGStatLabel, "Attack");
		Language.ApplyLang(mcBase.Defence.StatLabel, "Defence");
		Language.ApplyLang(mcBase.Defence.BGStatLabel, "Defence");
		Language.ApplyLang(mcBase.Renown.StatLabel, "Renown");
		Language.ApplyLang(mcBase.Renown.BGStatLabel, "Renown");
		Language.ApplyLang(mcBase.Corruption.StatLabel, "Corruption");
		Language.ApplyLang(mcBase.Corruption.BGStatLabel, "Corruption");
		Language.ApplyLang(mcBase.Dominance.StatLabel, "Dominance");
		Language.ApplyLang(mcBase.Dominance.BGStatLabel, "Dominance");
		Language.ApplyLang(mcBase.Conversation.StatLabel, "Conversation");
		Language.ApplyLang(mcBase.Conversation.BGStatLabel, "Conversation");
		Language.ApplyLang(mcBase.Constitution.StatLabel, "Constitution");
		Language.ApplyLang(mcBase.Constitution.BGStatLabel, "Constitution");
		Language.ApplyLang(mcBase.Lust.StatLabel, "Lust");
		Language.ApplyLang(mcBase.Lust.BGStatLabel, "Lust");	
		Language.ApplyLang(mcBase.Charisma.StatLabel, "Charisma");
		Language.ApplyLang(mcBase.Charisma.BGStatLabel, "Charisma");	
		Language.ApplyLang(mcBase.Refinement.StatLabel, "Refinement");
		Language.ApplyLang(mcBase.Refinement.BGStatLabel, "Refinement");	
		Language.ApplyLang(mcBase.Nymphomania.StatLabel, "Nymphomania");
		Language.ApplyLang(mcBase.Nymphomania.BGStatLabel, "Nymphomania");	
	
		Language.ApplyLang(mcBase.Tiredness.StatLabel, "Tiredness");
		Language.ApplyLang(mcBase.Tiredness.BGStatLabel, "Tiredness");	
	
		Language.ApplyLang(mcBase.Conversation.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Attack.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Defence.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Dominance.Limit.LText, "Limited", true);
		Language.ApplyLang(mcBase.Lust.Limit.LText, "Limited", true);
	
		Language.ApplyLang(mcBase.LYourStats, "YourStatistics", false, -1);
	}
	
	public function ApplyTheme(cvo:ColourScheme) 
	{
		var ypos:Number = 30;
		var gap:Number = 18.8;
		stln = 0;
		ypos = LayoutStats(mcBase.Charisma, ypos, gap);
		ypos = LayoutStats(mcBase.Conversation, ypos, gap);
		ypos = LayoutStats(mcBase.Refinement, ypos, gap);
		ypos = LayoutStats(mcBase.Constitution, ypos, gap);
		ypos = LayoutStats(mcBase.Attack, ypos, gap);
		ypos = LayoutStats(mcBase.Defence, ypos, gap);
		ypos = LayoutStats(mcBase.Nymphomania, ypos, gap);
		ypos = LayoutStats(mcBase.Dominance, ypos, gap);
		ypos = LayoutStats(mcBase.Lust, ypos, gap);
		ypos = LayoutStats(mcBase.Tiredness, ypos, gap);
		ypos = LayoutStats(mcBase.Renown, ypos, gap);
		ypos = LayoutStats(mcBase.Corruption, ypos, gap);
		ypos = LayoutStats(mcBase.SexualEnergy, ypos, gap);
	}
	
	
	// Hints
	
	public function ShowStatHint(stat:Number)
	{
		// standard variables used
		// genNumber - the value of the stat
		// genNumber2 - the maximum value of the stat
		// genString - the description of the stat
		// genString2 - the descrioption of the current value
	
		var nocreate:Boolean = coreGame.SlaveMakerCreate3._visible == false;
		var stNode:XMLNode = GetStatisticHintNode(SMData.GetStatNameBase(stat), SMData, Language.XMLData.GetNodeC("SlaveMaker", "StatisticsDetails"));
		
		coreGame.genString = "<b>" + Language.GetText(SMData.GetStatNameBase(stat), Language.statNode) + "</b>: " + Language.GetHtml("Description", stNode);
		coreGame.genNumber = stat == 6 ? Number(Language.XMLData.GetStat(SMData.GetStatNameBase(stat).toLowerCase(), SMData)) : Number(Language.XMLData.GetStat("sm" + SMData.GetStatNameBase(stat).toLowerCase(), SMData));
		coreGame.genNumber = Math.ceil(coreGame.genNumber);
		var maxval:Number = 100;
		var minval:Number = 0;
		
		switch(stat) {
			case 0:
				maxval = SMData.sRefined > 0 ? 100 : 85;
				if (SMData.SMAdvantages.CheckBitFlag(5) && maxval < 90) maxval = 90;
				break;
			case 3:
			case 4:
				maxval = SMData.SMAdvantages.CheckBitFlag(3) ? 100 : 75;
				break;
			case 5:
				maxval = SMData.Gender == 3 ? 80 : 70;
				if (SMData.SMAdvantages.CheckBitFlag(8)) maxval += 10;
				minval = SMData.SMMinLust;
				break;
			case 6:
				minval = SMData.SMMinCorruption;
				break;			
			case 7:
				maxval = SMData.IsDominatrix() ? 100 : 85;
				break;
		}
		
		if (coreGame.genNumber < 30) coreGame.genString2 = Language.XMLData.GetXMLString("Hint0-29", stNode);
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
		if (nocreate) {
			SetHintText(Language.GetHtml("SMStatHint", "SlaveMaker/StatisticsDetails"));
			if (coreGame.genNumber >= maxval && maxval < 100) AddHintText("\r\r" + Language.GetHtml("Limited", stNode));
			if (minval > 0) {
				var minstr:String = Language.GetHtml("LowerLimit", stNode);
				if (minstr != "") AddHintText("\r\r" + minstr);
			}
			ShowHint();
		} else ShowHint(Language.GetHtml("SMStatHintCreate", "SlaveMaker/StatisticsDetails"));
	}

	
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
