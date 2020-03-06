// DisplaySlaveSkills - Slave Vitals Panel
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplaySlaveSkills extends DisplayBase {
	
	var arSexSkills:Array;


	// Constructor
	public function DisplaySlaveSkills(cg:Object)
	{ 
		super(cg.SlaveSkillsGroup, cg);
		
		mcBase.SexTrainingsHint.tabEnabled = false;
		mcBase.Skills.tabEnabled = false;
		mcBase.Skills.content.tabEnabled = false;
		
		mcBase.SexSkills.setStyle("borderStyle", "none");
		mcBase.Skills.setStyle("borderStyle", "none");
		
		arSexSkills = new Array();
	}
	
	
	public function Show()
	{
		super.Show();
				
		mcBase.LSkills._visible = true;
		mcBase.Skills._visible = true;
		//mcBase.LSkills._y = 155.5; 
		//mcBase.Skills.setSize(282, 99); 
		//mcBase.Skills.move(10, 187.5); 
		
		mcBase.SexSkills.invalidate();
		mcBase.Skills.invalidate();
	}
	
	public function Hide()
	{
		super.Hide();
	}
	
	// Update dislay
	
	public function HideStatChangeIcons() 
	{	
		var i:Number = arSexSkills.length;
		if (i != undefined) while (--i >= 0) arSexSkills[i].PlusIcon._visible = false;
		i = coreGame.slaveData.arSkillArray.length;
		if (i != undefined) while (--i >= 0) coreGame.slaveData.arSkillArray[i].PlusIcon._visible = false;
	}
	

	// Sex Skills	
	
	public function AddSexSkill(skill:Number, sd:Object)
	{
		var image:MovieClip = mcBase.SexSkills.content.attachMovie("Skill (Description) Details", "SexSkill" + arSexSkills.length, mcBase.SexSkills.content.getNextHighestDepth());
		var sn:Number = arSexSkills.push(image);
		sn--;
		var sl:Number = coreGame.GetLastSexActLevel(skill, sd);
		image.PlusIcon._visible = false;
		image.PlusIcon.StatValue._visible = false;
		image.PlusIcon.StatIcon._visible = true;
		image.SexLabel.autoSize = true;
		image.SexCount.autoSize = true;
		image.SexMastery.autoSize = true;
		var sl0:Number = sl == -1 ? 0 : sl;
		image.SexLabel.styleSheet = Language.styles;
		image.SexLabel.htmlText = "<sp2>" + coreGame.GetActName(skill) + " " + sl0 + "</sp2>";
		image._width = 110;
		image._height = 18;
		image._x = (sn % 2) == 1 ? 144 : 5;
		image._y = Math.floor(sn / 2) * 21;
		image.enabled = true;
		var ti:DisplaySlaveSkills = this;
		image.onRollOut = function() { ti.HideHints(); }
		image.onRollOver = function() {
			ti.coreGame.genString = ti.coreGame.GetActName(this.skillno);
			ti.coreGame.genString2 = this.SexMastery.text;
			ti.coreGame.Hints.ShowHint(ti.Language.GetHtml("SexSkillDetails", ti.Language.skNode));
		}
		image._visible = true;
		image.skillno = skill;
	}
	
	public function SetSexSkills(sd:Object)
	{
		if (sd == undefined) sd = _root;
	
		var i = SMData.SlavesArray.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			var sdc:Slave = SMData.SlavesArray[i];
			if (sdc != coreGame.slaveData) sdc.ClearSlaveSkillArray();
		}
		if (sd == coreGame.slaveData) sd.ClearSlaveSkillArray();
		
		i = arSexSkills.length;
			while (--i >= 0) {
			var mc:MovieClip = MovieClip(arSexSkills.pop());
			mc.removeMovieClip();
			delete mc;
		}
		delete arSexSkills;
		arSexSkills = new Array();

		AddSexSkill(20, sd);	// 69
		AddSexSkill(10, sd);	// anal plug
		AddSexSkill(7, sd);		// ass fuck
		AddSexSkill(5, sd);		// blowjob
		AddSexSkill(12, sd);	// bondage
		AddSexSkill(25, sd);	// Cum Bath
		AddSexSkill(9, sd);		// dildo
		AddSexSkill(30, sd);	// Footjob
		AddSexSkill(4, sd);		// Fuck
		AddSexSkill(15, sd);	// Gang-Bang
		AddSexSkill(31, sd);	// Handjob
		AddSexSkill(23, sd);	// Kiss
		//AddSexSkill(16, sd);	// Lend
		AddSexSkill(11, sd);	// Lesbian
		AddSexSkill(3, sd);		// Lick
		AddSexSkill(8, sd);		// Masturbate
		AddSexSkill(13, sd);	// Naked
		AddSexSkill(21, sd);	// Orgy
		AddSexSkill(18, sd);	// Spank
		AddSexSkill(24, sd);	// Strip Tease
		AddSexSkill(19, sd);	// Threesome
		if (coreGame.SlaveFemale) AddSexSkill(6, sd);		// Tits-Fuck
		AddSexSkill(2, sd);		// Touch
		if (sd == _root) {
			if (coreGame.ShowCustomSex1 != 0) AddSexSkill(26, sd);
			if (coreGame.ShowCustomSex2 != 0) AddSexSkill(27, sd);
		}
		if (mcBase._visible) mcBase.SexSkills.invalidate();
	}
	
	public function UpdateSexSkill(skill:Number, sd:Object)
	{
		if (sd == undefined) sd = _root;
		
		var i = arSexSkills.length;
		while (--i >= 0) {
			if (arSexSkills[i].skillno == skill) {
				var image:MovieClip = arSexSkills[i];
				var sl:Number = coreGame.GetLastSexActLevel(skill, sd);
				var sl0:Number = sl == -1 ? 0 : sl;
				image.SexLabel.htmlText = coreGame.GetActName(skill) + " " + sl0;
				switch(coreGame.GetLastSexActLevel(skill, sd)) {
					case -1: image.SexMastery.htmlText = Language.GetHtml("MasteryLevelUntrained", Language.skNode); break;
					case 0:
					case 1: image.SexMastery.htmlText = Language.GetHtml("MasteryLevelLimited", Language.skNode); break;
					case 2: image.SexMastery.htmlText = Language.GetHtml("MasteryLevelBasic", Language.skNode); break;
					case 3: image.SexMastery.htmlText = Language.GetHtml("MasteryLevelSkilled", Language.skNode); break;
					case 4: image.SexMastery.htmlText = Language.GetHtml("MasteryLevelExpert", Language.skNode); break;
					case 5: image.SexMastery.htmlText = Language.GetHtml("MasteryLevelMastered", Language.skNode); break;
				}
				image.SexCount._x = image.SexMastery._x + image.SexMastery._width;
				image.SexCount.text = "(" + coreGame.GetActTotal(skill, sd) + ")";
				return;
			}
		}
	}
	
	public function UpdateSexSkills(sd:Object)
	{
		if (sd == undefined) sd = _root;
	
		//if (!sd.IsDisplayed()) return;
	
		UpdateSexSkill(20, sd);		// 69
		UpdateSexSkill(10, sd);		// anal plug
		UpdateSexSkill(7, sd);		// ass fuck
		UpdateSexSkill(5, sd);		// blowjob
		UpdateSexSkill(12, sd);		// bondage
		UpdateSexSkill(25, sd);		// Cum Bath
		UpdateSexSkill(9, sd);		// dildo
		UpdateSexSkill(30, sd);		// Footjob
		UpdateSexSkill(4, sd);		// Fuck
		UpdateSexSkill(15, sd);		// Gang-Bang
		UpdateSexSkill(31, sd);		// Handjob
		UpdateSexSkill(23, sd);		// Kiss
		//UpdateSexSkill(16, sd);		// Lend
		UpdateSexSkill(11, sd);		// Lesbian
		UpdateSexSkill(3, sd);		// Lick
		UpdateSexSkill(8, sd);		// Masturbate
		UpdateSexSkill(13, sd);		// Naked
		UpdateSexSkill(21, sd);		// Orgy
		UpdateSexSkill(18, sd);		// Spank
		UpdateSexSkill(24, sd);		// Strip Tease
		UpdateSexSkill(19, sd);		// Threesome
		if (coreGame.SlaveFemale) UpdateSexSkill(6, sd);		// Tits-Fuck
		UpdateSexSkill(2, sd);		// Touch	
		if (sd == _root) {
			if (coreGame.ShowCustomSex1 != 0) UpdateSexSkill(26, sd);
			if (coreGame.ShowCustomSex2 != 0) UpdateSexSkill(27, sd);
		}
		if (mcBase._visible) mcBase.SexSkills.invalidate();
	}
	
	public function ShowSexSkillChangeIcon(skill:Number)
	{
		skill = Math.floor(Math.abs(skill));
		var i:Number = arSexSkills.length;
		while (--i >= 0) {
			if (arSexSkills[i].skillno == skill) {
				arSexSkills[i].PlusIcon._visible = true;
				return;
			}
		}
	}
	
	// Slave Skills
	
	public function SlaveSkillHintRollOver(mc:MovieClip)
	{
		var sd:Object = mc.sd;
		var skill:Number = mc.SkillNo;
		var sdo:Slave = SMData.GetSlaveObject(sd);
	
		var combatindex:Number = sdo.GetSlaveSkillArrayIndex(coreGame.strCombatDescription);
		var catindex:Number = sdo.GetSlaveSkillArrayIndex(Language.GetHtml("CatslaveTraining", Language.skNode));
		var seductionindex:Number = sdo.GetSlaveSkillArrayIndex(Language.GetHtml("Seduction", Language.skNode));				
		var puppyindex:Number = sdo.GetSlaveSkillArrayIndex(Language.GetHtml("PuppyslaveTraining", Language.skNode));
		
		SetHintText("<b>" + mc.SkillLabel.text + "</b>\r");
		coreGame.HintText = "";
		if (coreGame.SlaveGirl.SlaveSkillHintRollOver(skill) == true) {
			if (coreGame.HintText == "") {
				coreGame.Hints.ShowHint(Language.GeneralText);
				SetGeneralText("");
			}
			return;
		}
		
		switch(skill) {
			case 0: AddHintText(Language.GetHtml(coreGame.slaveData.GetSkillLang(skill) + "Description", Language.skNode) + "\r"); break;
			case 1: AddHintText(Language.GetHtml(coreGame.slaveData.GetSkillLang(skill) + "Description", Language.skNode) + "\r"); break;
			case 2: AddHintText(Language.GetHtml(coreGame.slaveData.GetSkillLang(skill) + "Description", Language.skNode) + "\r"); break;
			case catindex: AddHintText(Language.GetHtml(coreGame.slaveData.GetSkillLang(skill) + "Description", Language.skNode) + "\r"); break;
			case puppyindex: AddHintText(Language.GetHtml(coreGame.slaveData.GetSkillLang(skill) + "Description", Language.skNode) + "\r"); break;
			case seductionindex:
				coreGame.genNumber = sd.slSeduction;
				if (sd.slSeduction < 65) coreGame.genString = Language.GetHtml("Succubus0to64", Language.skNode);
				else if (sd.slSeduction < 75) coreGame.genString = Language.GetHtml("Succubus65to74", Language.skNode);
				else coreGame.genString = Language.GetHtml("Succubus75Plus", Language.skNode);
				AddHintText(Language.GetHtml(coreGame.slaveData.GetSkillLang(skill) + "Description", Language.skNode) + "\r\r" + Language.GetHtml("GeneralSkillHint", Language.skNode));
				return;
			case combatindex:
				coreGame.Hints.ShowHintAdd(sd.strCombatDescription + ": " + sd.strCombatHint + " (" + sd.slCombat + ")");
				return;
			default: AddHintText(mc.SkillLabel.text + "\r"); break;
		}
		AddHintText(mc.SkillLevel.text);
		
		switch(skill) {
			case 0: AddHintText(" (" + sd.slDancing + ")"); break;
			case 1: AddHintText(" (" + sd.slSinging + ")"); break;
			case 2: AddHintText(" (" + sd.slSwimming + ")"); break;
		}
		ShowHint();
	}
	
	
	public function AddSlaveSkill(sname:String, desc:String, sd:Object) : Number
	{
		if (sd == undefined) sd = _root;
		var image:MovieClip = AddSlaveSkillMC(sname, desc, sd);
		return image.SkillNo;
	}
	
	public function AddSlaveSkillMC(sname:String, desc:String, sd:Object) : MovieClip
	{
		var today_date:Date = new Date();
		var tidx:Number = today_date.valueOf();
		delete today_date;
	
		var sdo:Slave = SMData.GetSlaveObject(sd);
		var image:MovieClip = mcBase.Skills.content.attachMovie("Skill (Simple Description) Details", "SlaveSkill" + sdo.arSkillArray.length + "1" + sdo.SlaveName, mcBase.Skills.content.getNextHighestDepth());
		var sn:Number = sdo.arSkillArray.push(image);
		sn--;
		image.SkillNo = sn;
		image.sd = sd;
		var ti:DisplaySlaveSkills = this;
		image.SkillHint.onRollOut = function() { ti.HideHints(); }
		image.SkillHint.onRollOver = function() { ti.SlaveSkillHintRollOver(this._parent); }
		image.SkillLevel.autoSize = true;
		image.SkillLabel.autoSize = true;
		image.SkillLabel.htmlText = sname;
		image.PlusIcon.StatValue._visible = false;
		image.PlusIcon.StatIcon._visible = true;
		image.PlusIcon._visible = false;
		if (desc != undefined) image.SkillLevel.htmlText = desc;
		image.SkillLevel._x = image.SkillLabel._x + image.SkillLabel._width + 5;
		if (image.SkillLevel._x < 90) image.SkillLevel._x = 90;
		image.SkillHint._width = image.SkillLevel._width + image.SkillLabel._width + 5;
		image._x = 6;
		image._y = sn * 15;
		image.sname = sname;
		image._visible = true;
		return image;
	}
	
	public function AddSlaveSMSkill(skillno:Number, sd:Object)
	{
		var sdo:Slave = SMData.GetSlaveObject(sd);
		var skillvalue:Number = sdo.GetSMSkillLevel(skillno);
		if (skillvalue != 0) AddSlaveSkillMC(SMData.GetSMSkillName(skillno), skillvalue + "", sdo);
	}
	
	public function SetSlaveSkills(sd:Object)
	{
		if (sd == undefined) sd = _root;
		
		var sdo:Slave = SMData.GetSlaveObject(sd);
		
		sdo.ClearSlaveSkillArray();
			
		AddSlaveSkillMC(Language.GetHtml("Dancing", Language.skNode, false, 0, "", ":"), undefined, sd);
		AddSlaveSkillMC(Language.GetHtml("Singing", Language.skNode, false, 0, "", ":"), undefined, sd); 
		AddSlaveSkillMC(Language.GetHtml("Swimming", Language.skNode, false, 0, "", ":"), undefined, sd);
		
		for (var i = 1; i < 17; i++) AddSlaveSMSkill(i, sd);
		for (var i = 50; i < 59; i++) AddSlaveSMSkill(i, sd);
		
		UpdateBasicSlaveSkills(sd);
	}
	
	public function UpdateBasicSlaveSkills(sd:Object)
	{
		if (sd == undefined) sd = _root;
		var sdo:Slave = SMData.GetSlaveObject(sd);
		if (sdo.arSkillArray == null) return;
		
		sdo.arSkillArray[0].SkillLevel.htmlText = Language.GetHtml("DancingLevel" + int(sd.slDancing), Language.skNode);
		sdo.arSkillArray[0].SkillHint._width = sdo.arSkillArray[0].SkillLevel._width + sdo.arSkillArray[0].SkillLabel._width + 5;
		sdo.arSkillArray[0].skillrank = sd.slDancing;
		sdo.arSkillArray[1].SkillLevel.htmlText = Language.GetHtml("SingingLevel" + int(sd.slSinging), Language.skNode);
		sdo.arSkillArray[1].SkillHint._width = sdo.arSkillArray[1].SkillLevel._width + sdo.arSkillArray[1].SkillLabel._width + 5;
		sdo.arSkillArray[1].skillrank = sd.slSinging;
		sdo.arSkillArray[2].SkillLevel.htmlText = Language.GetHtml("SwimmingLevel" + int(sd.slSwimming), Language.skNode);
		sdo.arSkillArray[2].SkillHint._width = sdo.arSkillArray[2].SkillLevel._width + sdo.arSkillArray[2].SkillLabel._width + 5;
		sdo.arSkillArray[2].skillrank = sd.slSwimming;
		sdo.arSkillArray[0]._visible = true;
		sdo.arSkillArray[1]._visible = true;
		sdo.arSkillArray[2]._visible = true;
		
		var mc:MovieClip = undefined;
		if (sd.slCombat > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(sd.strCombatDescription);
			if (mc == null) mc = AddSlaveSkillMC(sd.strCombatDescription + ":", "", sd);
			else mc.SkillLabel.htmlText = sd.strCombatDescription + ":";
			mc.SkillLevel.htmlText = sd.slCombat + "/100";
			mc.skillrank = sd.slCombat;
		}
		if (sd.slCourtesan > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("CourtesanTraining", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("CourtesanTraining", Language.skNode, false, 0, "", ":"), "", sd);
			if (sd.slCourtesan == 100) mc.SkillLevel.htmlText = Language.GetHtml("FullyTrained", Language.skNode);
			else mc.SkillLevel.htmlText = sd.slCourtesan + "/100";
			mc.skillrank = sd.slCourtesan;
		}
		if (sd.slPonyTraining > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("PonyTraining", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("PonyTraining", Language.skNode, false, 0, "", ":"), undefined, sd);
			if (sd.slPonyTraining == 100) mc.SkillLevel.htmlText = Language.GetHtml("IdealPonygirl", Language.skNode);
			else mc.SkillLevel.htmlText = sd.slPonyTraining + "/100";
			mc.skillrank = sd.slPonyTraining;
		}
		if (sd.slCatTraining > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("CatslaveTraining", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("CatslaveTraining", Language.skNode, false, 0, "", ":"), "", sd);
			if (sd.slCatTraining == 100) mc.SkillLevel.htmlText = Language.GetHtml("PerfectCatgirl", Language.skNode);
			else mc.SkillLevel.htmlText = sd.slCatTraining + "/100";
			if (coreGame.IsCatgirlComplete()) mc.SkillLevel.htmlText += " (" + Language.GetHtml("AcceptedCatgirl", Language.skNode) + ")";
			mc.skillrank = sd.slCatTraining;
		}
		if (sd.slPuppyTraining > 0) {
			trace("pt3 = " + sd.slPuppyTraining + " " + coreGame.slPuppyTraining);
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("PuppyslaveTraining", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("PuppyslaveTraining", Language.skNode, false, 0, "", ":"), "", sd);
			if (sd.slPuppyTraining == 100) mc.SkillLevel.htmlText = Language.GetHtml("PerfectPuppy", Language.skNode);
			else mc.SkillLevel.htmlText = sd.slPuppyTraining + "/100";
			if (coreGame.IsPuppygirlComplete()) mc.SkillLevel.htmlText += " (" + Language.GetHtml("AcceptedPuppy", Language.skNode) + ")";
			mc.skillrank = sd.slPuppyTraining;
		}	
		if (sd.slSlutTraining > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("SlutTraining", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("SlutTraining", Language.skNode, false, 0, "", ":"), undefined, sd);
			mc.SkillLevel.htmlText = sd.slSlutTraining + "/100";
			mc.skillrank = sd.slSlutTraining;
		}
		if (sd.FairyXF > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("FairyAffinity", Language.skNode));		
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("FairyAffinity", Language.skNode, false, 0, "", ":"), undefined, sd);
			if (sd.FairyXF == 2000) mc.SkillLevel.htmlText = Language.GetHtml("CompletelyFaerie", Language.skNode);
			else mc.SkillLevel.htmlText = (sd.FairyXF > 100 ? 100 : sd.FairyXF) + "/100";
			mc.skillrank = sd.FairyXF;
		}
		if (sd.slSeduction > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("Seduction", Language.skNode));				
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("Seduction", Language.skNode, false, 0, "", ":"), undefined, sd);
			mc.SkillLevel.htmlText = sd.slSeduction + "/100";
			mc.skillrank = sd.slSeduction;
		}
		if (sd.CumslutLevel > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("Cumslut", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("Cumslut", Language.skNode, false, 0, "", ":"), undefined, sd);
			if (sd.CumslutLevel == 2000) mc.SkillLevel.htmlText = Language.GetHtml("CompleteCumslut", Language.skNode);
			else mc.SkillLevel.htmlText = Math.round(sd.CumslutLevel > 100 ? 100 : sd.CumslutLevel) + "/100";
			mc.skillrank = sd.CumslutLevel;
		}
		if (sd.slSuccubusTraining > 0) {
			mc = sdo.GetSlaveSkillArrayEntry(Language.GetHtml("SuccubusTraining", Language.skNode));
			if (mc == null) mc = AddSlaveSkillMC(Language.GetHtml("SuccubusTraining", Language.skNode, false, 0, "", ":"), undefined, sd);
			if (sd.slSuccubusTraining == 2000) mc.SkillLevel.htmlText = Language.GetHtml("TrueSuccubus", Language.skNode);
			else mc.SkillLevel.htmlText = Math.round(sd.slSuccubusTraining > 100 ? 100 : sd.slSuccubusTraining) + "/100";
			mc.skillrank = sd.slSuccubusTraining;
		}
		if (mc != undefined) {
			mc.SkillLevel._x = mc.SkillLabel._x + mc.SkillLabel._width + 5;
			if (mc.SkillLevel._x < 90) mc.SkillLevel._x = 90;
			mc.SkillHint._width = mc.SkillLevel._width + mc.SkillLabel._width + 5;
			mc._visible = true;
		}
	
		if (mcBase._visible) mcBase.Skills.invalidate();
	}
	
	public function UpdateSlaveSkill(num:Number, slevel:String)
	{
		var combatindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(coreGame.strCombatDescription);
		var courtesanindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("CourtesanTraining", Language.skNode));
		var ponyindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("PonyTraining", Language.skNode));
		var catindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("CatslaveTraining", Language.skNode));
		var slutindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("SlutTraining", Language.skNode));
		var fairyindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("FairyAffinity", Language.skNode));		
		var seductionindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("Seduction", Language.skNode));				
		var csindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("Cumslut", Language.skNode));
		var succubusindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("SuccubusTraining", Language.skNode));
		var puppyindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("PuppyslaveTraining", Language.skNode));
	
		if (num == courtesanindex || num == combatindex || num == ponyindex || num == catindex || num == puppyindex || num == slutindex || num < 3) {
			UpdateBasicSlaveSkills();
			coreGame.slaveData.arSkillArray[num].PlusIcon._visible = true;
		} else {
			coreGame.slaveData.arSkillArray[num].SkillLevel.text = slevel;
			coreGame.slaveData.arSkillArray[num].PlusIcon._visible = true;
			coreGame.slaveData.arSkillArray[num].SkillHint._width = coreGame.slaveData.arSkillArray[num].SkillLevel._width + coreGame.slaveData.arSkillArray[num].SkillLabel._width + 5;
			if (mcBase._visible) mcBase.Skills.invalidate();
		}
	}
	

	// Update theme of text fields
		
	public function UpdateText(str:String, aNode:XMLNode)
	{
		Language.ApplyLang(mcBase.LSexTrainings, "SexTrainings", false, -1);
		Language.ApplyLang(mcBase.LSkills, "Skills", false, -1);
	}
	
	public function ApplyTheme(cvo:ColourScheme)
	{
		mcBase.Skills.setStyle("scrollTrackColor", cvo.nTabBackground);
		mcBase.SexSkills.setStyle("scrollTrackColor", cvo.nTabBackground);
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
