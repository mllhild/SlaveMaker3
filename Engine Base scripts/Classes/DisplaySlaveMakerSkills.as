// DisplaySlaveMakerSkills - Slave Vitals Panel
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplaySlaveMakerSkills extends DisplayBase {

	// Constructor
	public function DisplaySlaveMakerSkills(cg:Object)
	{ 
		super(cg.SlaveMakerSkillsGroup, cg);
		
		mcBase.Skills.tabEnabled = false;
		mcBase.TalentLabel.tabEnabled = false;
		
		mcBase.Skills.setStyle("borderStyle", "none");
		mcBase.Talents.setStyle("borderStyle", "none");

	}
	
	
	public function Show()
	{
		super.Show();
		mcBase.Skills.invalidate();
		
	}
	
	public function Hide()
	{
		super.Hide();
	}
	
	// Update display
	public function Update()
	{
		UpdateSMSkills();
		
		mcBase.SMName.text = SMData.SlaveMakerName;
		
		var efftalent:Number = SMData.GetEffectivePackage();
		if (efftalent > -1) mcBase.TalentLabel.htmlText = Language.GetHtml("Talent" + efftalent + "Title", "Talents");
		
		if (coreGame.AssistantData != undefined && coreGame.AssistantData.sLesbianTrainer > SMData.sLesbianTrainer) coreGame.currLesbianTrainer = coreGame.AssistantData.sLesbianTrainer;
		else coreGame.currLesbianTrainer = SMData.sLesbianTrainer;
		if (coreGame.AssistantData != undefined && coreGame.AssistantData.sGayTrainer > SMData.sGayTrainer) coreGame.currGayTrainer = coreGame.AssistantData.sGayTrainer;
		else coreGame.currGayTrainer = SMData.sGayTrainer;	
			
		coreGame.StatRate = 1;
		coreGame.MaxStat = 80;
		coreGame.modSlaveTrainer = Math.floor(SMData.sSlaveTrainer);
		if (coreGame.AssistantData != null && coreGame.AssistantData != undefined && coreGame.AssistantData.sSlaveTrainer > SMData.sSlaveTrainer) {
			coreGame.modSlaveTrainer++;
			if (coreGame.modSlaveTrainer > coreGame.AssistantData.sSlaveTrainer) coreGame.modSlaveTrainer = coreGame.AssistantData.sSlaveTrainer;
			if (coreGame.modSlaveTrainer > 4)coreGame. modSlaveTrainer = 4;
		}
		switch(coreGame.modSlaveTrainer) {
			case 2:
				coreGame.StatRate = 1.25;
				coreGame.MaxStat = 100;
				break;
			case 3:
				coreGame.StatRate = 1.5;
				coreGame.MaxStat = 150;
				break;
			case 4:
				coreGame.StatRate = 1.75;
				coreGame.MaxStat = 200;
				break;
		}
	}
	
	public function HideStatChangeIcons() 
	{	
		var i:Number = SMData.arSMSkills.length;
		if (i != undefined) while (--i >= 0) SMData.arSMSkills[i].SkillIcon._visible = false;
	}
	
	// SlaveMaker Skills

	public function SkillHintRollOver(sd:Object, skill:Number)
	{
		SetHintText(SMData.GetSMSkillDescription(skill));
		switch(Math.floor(Math.abs(skill))) {
			case 50:
			case 51:
			case 52:
			case 53:
			case 54:
			case 55:
			case 56:
			case 57:
			case 58:
				coreGame.Hints.AddHintText("\r\r" + Language.strReplaceValue(Language.GetHtml("CombatSkillLevels", Language.skNode), Math.floor(sd.GetSMSkillLevel(skill))) + "\r\r");
				break;
	
			default:
				coreGame.genNumber = sd.GetSMSkillLevel(skill);
				coreGame.genNumber2 = SMSlaveCommon.GetSMMaxSkill(skill);
				coreGame.Hints.AddHintText("\r\r");
				coreGame.Hints.AddHintText(Language.GetHtml("GeneralSkillLevel", Language.skNode));
				coreGame.Hints.AddHintText(SMData.GetSMSkillLevelEffects(skill, sd.GetSMSkillLevel(skill))); 
				coreGame.Hints.AddHintText("\r\r");
				break;
						
		}
		coreGame.Hints.ShowHint();
	}
	
	public function AddSMSkill(skill:Number, skillno:Number, sd:Object) : Number
	{
		var skillvalue:Number = sd.GetSMSkillLevel(skillno);
		if (skillvalue == 0) return skill;
		var depth:Number = mcBase.Skills.content.getNextHighestDepth();
		var image:MovieClip = mcBase.Skills.content.attachMovie("Skill (Numbered) Details", "SMSkill" + depth, depth);
		SMData.arSMSkills.push(image);
		image.SkillIcon.StatValue._visible = false;
		image.SkillIcon.StatIcon._visible = true;
		image.SkillIcon._visible = false;
		image.SkillLabel.autoSize = true;
		image.SkillLabel.htmlText = SMData.GetSMSkillName(skillno);
		image.SkillValue.htmlText = Math.floor(skillvalue);
		image._x = (skill % 2) == 0 ? 6 : 136;
		image._y = Math.floor(skill / 2) * 16;
		image._visible = true;
		var ti:DisplaySlaveMakerSkills = this;
		image.SkillHint.onRollOut = function() { ti.HideHints(); }
		image.SkillHint.onRollOver = function() { ti.SkillHintRollOver(this._parent.sd, this._parent.SkillNo); }
		image.SkillNo = -1 * skillno;
		image.sd = sd;
		skill++;
		return skill;
	}
	
	public function SetSMSkills(sd:Object)
	{
		if (sd == undefined) sd = SMData;
		
		SMData.ResetSMSkills();
		
		var skill:Number = 0;
		skill = AddSMSkill(skill, 13, sd);
		skill = AddSMSkill(skill, 1, sd);
		skill = AddSMSkill(skill, 2, sd);
		skill = AddSMSkill(skill, 5, sd);
		skill = AddSMSkill(skill, 6, sd);
		skill = AddSMSkill(skill, 7, sd);
		skill = AddSMSkill(skill, 8, sd);
		skill = AddSMSkill(skill, 9, sd);
		skill = AddSMSkill(skill, 3, sd);
		skill = AddSMSkill(skill, 4, sd);
		skill = AddSMSkill(skill, 10, sd);
		skill = AddSMSkill(skill, 11, sd);
		skill = AddSMSkill(skill, 12, sd);
		skill = AddSMSkill(skill, 14, sd);
		skill = AddSMSkill(skill, 15, sd);
		skill = AddSMSkill(skill, 16, sd);
		
		skill = AddSMSkill(skill, 50, sd);
		skill = AddSMSkill(skill, 51, sd);
		skill = AddSMSkill(skill, 52, sd);
		skill = AddSMSkill(skill, 53, sd);
		skill = AddSMSkill(skill, 54, sd);
		skill = AddSMSkill(skill, 55, sd);
		skill = AddSMSkill(skill, 56, sd);
		skill = AddSMSkill(skill, 57, sd);
		skill = AddSMSkill(skill, 58, sd);
	}
	
	public function UpdateSMSkillNoI(skillno:Number, skillvalue:Number, sd:Object) : Number
	{
		if (sd == undefined) sd = SMData;
		if (skillvalue == undefined) skillvalue = sd.GetSMSkillLevel(skillno);
		if (skillvalue == 0) return -1;
		skillno *= -1;
		var i = SMData.arSMSkills.length;
		while (--i >= 0) {
			if (SMData.arSMSkills[i].SkillNo == skillno) {
				SMData.arSMSkills[i].SkillValue.htmlText = Math.floor(skillvalue);
				return i;
			}
		}
		SetSMSkills(sd);
		while (--i >= 0) {
			if (SMData.arSMSkills[i].SkillNo == skillno) {
				SMData.arSMSkills[i].SkillIcon._visible = true;
				return i;
			}
		}
		return 0;
	}
	
	public function UpdateSMSkill(skillno:Number, inc:Number, skillvalue:Number, sd:Object) : Number
	{
		if (sd == undefined) sd = SMData;
		if (skillvalue == undefined) skillvalue = sd.GetSMSkillLevel(skillno);
		else sd.SetSMSkillLevel(skillno, skillvalue);
		if (inc != undefined) skillvalue += inc;
		var idx:Number = UpdateSMSkillNoI(skillno, skillvalue, sd);
		if (idx != -1 && inc != undefined) SMData.arSMSkills[idx].SkillIcon._visible = true;
		if (mcBase._visible) mcBase.Skills.invalidate();
		return skillvalue;
	}
	
	
	public function UpdateSMSkills(sd:Object)
	{
		UpdateSMSkillNoI(13, undefined, sd);
		UpdateSMSkillNoI(1, undefined, sd);
		UpdateSMSkillNoI(2, undefined, sd);
		UpdateSMSkillNoI(5, undefined, sd);
		UpdateSMSkillNoI(6, undefined, sd);
		UpdateSMSkillNoI(7, undefined, sd);
		UpdateSMSkillNoI(8, undefined, sd);
		UpdateSMSkillNoI(9, undefined, sd);
		UpdateSMSkillNoI(3, undefined, sd);
		UpdateSMSkillNoI(4, undefined, sd);
		UpdateSMSkillNoI(10, undefined, sd);
		UpdateSMSkillNoI(11, undefined, sd);
		UpdateSMSkillNoI(12, undefined, sd);
		UpdateSMSkillNoI(14, undefined, sd);
		UpdateSMSkillNoI(15, undefined, sd);
		UpdateSMSkillNoI(16, undefined, sd);
		
		UpdateSMSkillNoI(50, undefined, sd);
		UpdateSMSkillNoI(51, undefined, sd);
		UpdateSMSkillNoI(52, undefined, sd);
		UpdateSMSkillNoI(53, undefined, sd);
		UpdateSMSkillNoI(54, undefined, sd);
		UpdateSMSkillNoI(55, undefined, sd);
		UpdateSMSkillNoI(56, undefined, sd);
		UpdateSMSkillNoI(57, undefined, sd);
		UpdateSMSkillNoI(58, undefined, sd);
		if (mcBase._visible) mcBase.Skills.invalidate();
	}


	// Update theme of text fields
		
	public function UpdateText(str:String, aNode:XMLNode)
	{	
		Language.ApplyLang(mcBase.LSkillsTalents, "Skills", false, -1);
		Language.ApplyLang(mcBase.LYourSkills, "YourSkills", false, -1);
		Language.ApplyLang(mcBase.LTalentsAdvantages, "TalentsAdvantages", false, -1);
	
		mcBase.TalentLabel.htmlText = "<b>" + Language.GetHtml("Background") + ":</b> ";
	}
	
	public function ApplyTheme(cvo:ColourScheme)
	{
		Language.ApplyLang(mcBase.LYourStats, "YourSkills", false, -1);

		mcBase.Skills.setStyle("scrollTrackColor", cvo.nTabBackground);
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
