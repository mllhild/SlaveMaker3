// DialogUseSkillPoints -  SlaveMaker Skill Increase
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogUseSkillPoints extends DialogBase {
	
	// Constructor
	public function DialogUseSkillPoints(cg:Object)
	{ 
		super(cg.SlaveMakerSkillsMenu, cg);
		
		mcBase.LeaveButton.tabChildren = true;
		
		var ti:DialogUseSkillPoints = this;
		mcBase.LeaveButton.Btn.onPress = function() { ti.LeaveDialog(); }
	}
	
	public function ViewDialog()
	{
		SetSlave(coreGame.slaveData);
		
		mcBase.LSkillsImproved.htmlText = Language.GetHtml("SkillsImproved", "EndGame", true);
		mcBase.LDetails.htmlText = Language.GetHtml("SkillsDetails", "EndGame");
		mcBase.LSkillPoints.htmlText = Language.GetHtml("SkillPoints", "EndGame");
		mcBase.LSkillName1.htmlText = Language.GetHtml("SkillName", "EndGame");
		mcBase.LSkillName2.htmlText = Language.GetHtml("SkillName", "EndGame");
		mcBase.LSkillLevel1.htmlText = Language.GetHtml("SkillLevel", "EndGame");
		mcBase.LSkillLevel2.htmlText = Language.GetHtml("SkillLevel", "EndGame");
		mcBase.LSkillName3.htmlText = Language.GetHtml("OtherUpgrade", "EndGame");
		CopyTF(mcBase.LeaveButton.LText, coreGame.Quitter.LText);

		coreGame.ClearGeneralArray();
		
		mcBase.SkillPointsText.text = SMData.SkillPoints;
		
		var skill:Number = 0;
		skill = AddSMSkillIncrease(skill, SMData.sSlaveTrainer, 13);
		skill = AddSMSkillIncrease(skill, SMData.sLeadership, 1);
		skill = AddSMSkillIncrease(skill, SMData.sLesbianTrainer, 2);
		skill = AddSMSkillIncrease(skill, SMData.sTrader, 3);
		skill = AddSMSkillIncrease(skill, SMData.sAlchemy, 4);
		skill = AddSMSkillIncrease(skill, SMData.sPonyTrainer, 5);
		skill = AddSMSkillIncrease(skill, SMData.sCatTrainer, 6);
		skill = AddSMSkillIncrease(skill, SMData.sSuccubusTrainer, 7);
		skill = AddSMSkillIncrease(skill, SMData.sSlutTrainer, 8);
		skill = AddSMSkillIncrease(skill, SMData.sOrgasmDenialTraining, 9);
		skill = AddSMSkillIncrease(skill, SMData.sRefined, 10);
		skill = AddSMSkillIncrease(skill, SMData.sNoble, 11);
		skill = AddSMSkillIncrease(skill, SMData.sTentacleExpert, 12);
		skill = AddSMSkillIncrease(skill, SMData.sBreastExpert, 14);
		skill = AddSMSkillIncrease(skill, SMData.sGayTrainer, 15);
		skill = AddSMSkillIncrease(skill, SMData.sPuppyTrainer, 16);
		skill = AddSMSkillIncrease(skill, SMData.sSwordExpertise, 50);
		skill = AddSMSkillIncrease(skill, SMData.sWhipExpertise, 51);
		skill = AddSMSkillIncrease(skill, SMData.sBowExpertise, 52);
		skill = AddSMSkillIncrease(skill, SMData.sHammerExpertise, 53);
		skill = AddSMSkillIncrease(skill, SMData.sNaginataExpertise, 54);
		skill = AddSMSkillIncrease(skill, SMData.sDaggerExpertise, 55);
		skill = AddSMSkillIncrease(skill, SMData.sCrossbowExpertise, 56);
		skill = AddSMSkillIncrease(skill, SMData.sUnarmedExpertise, 57);
		skill = AddSMSkillIncrease(skill, SMData.sThrownExpertise, 58);
		
		skill = 0;
		if (SMData.GuildMember) skill = AddSMUpgrade(skill, Language.GetHtml("BuyPoint", "EndGame"), 25000, 101);
		else skill = AddSMUpgrade(skill, Language.GetHtml("BuyPoint", "EndGame"), 50000, 101);
		skill = AddSMUpgrade(skill, Language.GetHtml("OneYear", "EndGame"), 1, 102);
		
		coreGame.HideAllImages();
				
		super.ViewDialog();
		
		Backgrounds.ShowIntroBackgroundARGB(0x225252);
	}
	
	public function LeaveDialog()
	{
		super.LeaveDialog();
		
		coreGame.UpdateSlaveMaker();
		coreGame.ClearGeneralArray();
		
		coreGame.EndGame.Show();
		coreGame.DoEndingNext();		// TODO: remove?
	}

	private function AddSMSkillIncrease(skill:Number, skillvalue:Number, skillno:Number) : Number
	{
		if (skillvalue < 1) return skill;
		var depth:Number = mcBase.SkillsList.getNextHighestDepth();
		var image:MovieClip = mcBase.SkillsList.attachMovie("Skill Advance Details", "SMSkillIncrease" + skill, depth);
		image.tabChildren = true;
		coreGame.arGeneralArray.push(image);
		image.SkillLabel.autoSize = true;
		image.SkillLabel.text = SMData.GetSMSkillName(skillno);
		image.SkillValue.text = Math.floor(skillvalue);
		image.SkillLevel = skillvalue;
		image._x = (skill % 2) == 0 ? 0 : 245;
		image._y = Math.floor(skill / 2) * 30;
		image._visible = true;
		var ti:DialogUseSkillPoints = this;
		image.SkillHint.onRollOut = function() { ti.HideHints(); }
		image.SkillHint.onRollOver = function() { ti.SkillIncreaseHintRollOver(this._parent.SkillNo, this._parent.SkillLevel); }
		image.SkillNo = skillno;
		image.SkillIndex = skill;
		if (SMSlaveCommon.GetSMMaxSkill(skillno) > skillvalue && skillno != 11) {
			image.SkillHint.onPress = function() { ti.AddSMSkillPoint(this._parent); }
			if (skillno > 49) image.IncreaseText.text = "1";
			else image.IncreaseText.text = Math.floor(skillvalue) - Math.round((skillvalue - Math.floor(skillvalue)) * 5);
			image.AddPointButton.LText.htmlText = Language.GetHtml("AddPoint", "Buttons");
			if (skill != 102) image.PointsText.text = Language.GetHtml("PointsToIncrease", "EndGame");
			else image.PointsText.text = "50000GP";
		} else {
			image.IncreaseText._visible = false;
			image.PointsText._visible = false;
			image.AddPointButton._visible = false;
		}
		skill++;
		return skill;
	}

	private function AddSMUpgrade(skill:Number, strLabel:String, upvalue:Number, upno:Number) : Number
	{
		if (upvalue < 1) return skill;
		var depth:Number = mcBase.SkillsList.getNextHighestDepth();
		var image:MovieClip = mcBase.SkillsList.attachMovie("Skill Advance Details", "SMSkillIncrease" + skill, depth);
		image.tabChildren = true;
		coreGame.arGeneralArray.push(image);
		image.SkillLabel.autoSize = true;
		image.SkillLabel.text = strLabel;
		image.SkillValue._width = 110;
		image.SkillValue.text = Math.floor(upvalue);
		image.SkillLevel = upvalue;
		image._x = 500;
		image._y = skill * 30;
		image._visible = true;
		var ti:DialogUseSkillPoints = this;
		image.SkillHint.onRollOut = function() { ti.HideHints(); }
		image.SkillHint.onRollOver = function() { ti.SkillIncreaseHintRollOver(this._parent.SkillNo, this._parent.SkillLevel); }
		image.SkillNo = upno;
		image.SkillIndex = skill;
		image.SkillHint.onPress = function() { ti.AddSMSkillPoint(this._parent); }
		if (upvalue > 1000) image.IncreaseText.text = upvalue + Language.GP;
		else image.IncreaseText.text = upvalue;
		image.PointsText.text = Language.GetHtml("PointsToIncrease", "EndGame");
		image.AddPointButton._visible = false;
	
		skill++;
		return skill;
	}

	
	public function SkillIncreaseHintRollOver(skillno:Number, skilllevel:Number)
	{
		switch (skillno) {
			case 101:
				if (SMData.GuildMember) mcBase.HintText.htmlText = Language.GetHtml("BuyPointGuildHint", "EndGame");
				else mcBase.HintText.htmlText = Language.GetHtml("BuyPointFreeHint", "EndGame");
				return;
			case 102:
				mcBase.HintText.htmlText = Language.GetHtml("OneYearHint", "EndGame");
				return;				
			default:
				if (SMSlaveCommon.GetSMMaxSkill(skillno) > skilllevel && skillno < 50) mcBase.HintText.htmlText = Language.GetHtml("ThisLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(skillno, skilllevel) + "\r" + Language.GetHtml("NextLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(skillno, skilllevel + 1);
				else mcBase.HintText.htmlText = Language.GetHtml("ThisLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(skillno, skilllevel);
				break;
		}
	}
	
	public function IncreaseSkill(skillevel:Number) : Number
	{
		var oldint:Number = Math.floor(skillevel);
		var pts:Number = Math.round(5 * (skillevel - oldint));
		pts++;
		if (oldint == 0) {
			if (pts < 5) return oldint + (pts * 0.2);
			else return 1;
		} else {
			if (pts < oldint) return oldint + (pts * 0.2);
			else return oldint + 1;
		}
	}
	
	public function ImproveSMSkill(skillno:Number) : Number
	{
		switch(skillno) {
			case 13: SMData.sSlaveTrainer = IncreaseSkill(SMData.sSlaveTrainer); return SMData.sSlaveTrainer;
			case 1: SMData.sLeadership = IncreaseSkill(SMData.sLeadership); return SMData.sLeadership;
			case 2: SMData.sLesbianTrainer = IncreaseSkill(SMData.sLesbianTrainer); return SMData.sLesbianTrainer;
			case 3: SMData.sTrader = IncreaseSkill(SMData.sTrader); return SMData.sTrader;
			case 4: SMData.sAlchemy = IncreaseSkill(SMData.sAlchemy); return SMData.sAlchemy;
			case 5: SMData.sPonyTrainer = IncreaseSkill(SMData.sPonyTrainer); return SMData.sPonyTrainer;
			case 6: SMData.sCatTrainer = IncreaseSkill(SMData.sCatTrainer); return SMData.sCatTrainer;
			case 7: SMData.sSuccubusTrainer = IncreaseSkill(SMData.sSuccubusTrainer); return SMData.sSuccubusTrainer;
			case 8: SMData.sSlutTrainer = IncreaseSkill(SMData.sSlutTrainer); return SMData.sSlutTrainer;
			case 9: SMData.sOrgasmDenialTraining = IncreaseSkill(SMData.sOrgasmDenialTraining); return SMData.sOrgasmDenialTraining;
			case 10: SMData.sRefined = IncreaseSkill(SMData.sRefined); return SMData.sRefined;
			case 11: SMData.sNoble = IncreaseSkill(SMData.sNoble); return SMData.sNoble;
			case 12: SMData.sTentacleExpert = IncreaseSkill(SMData.sTentacleExpert); return SMData.sTentacleExpert;
			case 14: SMData.sBreastExpert = IncreaseSkill(SMData.sBreastExpert); return SMData.sBreastExpert;
			case 15: SMData.sGayTrainer = IncreaseSkill(SMData.sGayTrainer); return SMData.sGayTrainer;
			case 16: SMData.sPuppyTrainer = IncreaseSkill(SMData.sPuppyTrainer); return SMData.sPuppyTrainer;
			
			case 50: SMData.sSwordExpertise += 10; return SMData.sSwordExpertise;
			case 51: SMData.sWhipExpertise += 10; return SMData.sWhipExpertise;
			case 52: SMData.sBowExpertise += 10; return SMData.sBowExpertise;
			case 53: SMData.sHammerExpertise += 10; return SMData.sHammerExpertise;
			case 54: SMData.sNaginataExpertise += 10; return SMData.sNaginataExpertise;
			case 55: SMData.sDaggerExpertise += 10; return SMData.sDaggerExpertise;
			case 56: SMData.sCrossbowExpertise += 10; return SMData.sCrossbowExpertise;
			case 57: SMData.sUnarmedExpertise += 10; return SMData.sUnarmedExpertise;
			case 58: SMData.sThrownExpertise += 10; return SMData.sThrownExpertise;
		}
	}
	
	public function AddSMSkillPoint(image:MovieClip)
	{
		var skillno:Number = image.SkillNo;
		if (SMData.SkillPoints == 0 && skillno != 101) {
			Bloop();
			mcBase.HintText.htmlText = Language.GetHtml("NoSkillPoints", "EndGame");
			return;
		}
				
		switch (skillno) {
				
			case 101:
				var cost:Number = SMData.GuildMember ? 25000 : 50000;
				if ((SMData.SMGold + coreGame.VarGold) >= cost) {
					SMMoney(-1 * cost);
					SMData.SkillPoints = SMData.SkillPoints + 2;
					coreGame.ChangeDate(14);
				} else {
					Bloop();
					return;
				}
				break;
				
	
			case 102:
				coreGame.ChangeDate(400);
				break;
				
			
			default:
				var newv:Number = ImproveSMSkill(skillno);
			
				image.SkillValue.text = Math.floor(newv);
				image.SkillLevel = newv;
				if (SMSlaveCommon.GetSMMaxSkill(image.SkillNo) > newv && image.SkillNo != 11 && image.SkillNo != 8) {
					if (image.SkillNo > 49) {
						image.IncreaseText.text = "1";
						mcBase.HintText.htmlText = Language.GetHtml("ThisLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(image.SkillNo, newv);
					} else {
						image.IncreaseText.text = Math.floor(newv) - Math.round((newv - Math.floor(newv)) * 5);
						mcBase.HintText.htmlText = Language.GetHtml("ThisLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(image.SkillNo, newv) + "\r" + Language.GetHtml("NextLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(image.SkillNo, newv + 1);
					}
				} else {
					image.IncreaseText._visible = false;
					image.PointsText._visible = false;
					image.AddPointButton._visible = false;
					delete image.SkillHint.onPress;
					mcBase.HintText.htmlText = Language.GetHtml("ThisLevel", "EndGame", true) + "\r" + SMData.GetSMSkillLevelEffects(image.SkillNo, newv);
				}
				break;
		}
		
		SMData.SkillPoints--;
		mcBase.SkillPointsText.text = SMData.SkillPoints;
	}
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (key == 13) {
			LeaveDialog();
			return true;
		}
		return false;
	} 
	
	
	// use
	private function UsedDuringGame() : Boolean { return false; }
}