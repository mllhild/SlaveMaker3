// DisplaySlaveVitals - Slave Vitals Panel
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplaySlaveVitals extends DisplayBase {

	// Constructor
	public function DisplaySlaveVitals(cg:Object)
	{ 
		super(cg.SlaveVitalsGroup, cg);
		
		var ti:DisplaySlaveVitals = this;
		
		mcBase.HeightWeightHint.tabEnabled = false;
		mcBase.ClitCockHint.tabEnabled = false;
		mcBase.MeasurementsHint.tabEnabled = false;

		mcBase.BloodTypeHint.tabEnabled = false;
		mcBase.BloodTypeHint.onRollOver = function() {
			ti.SMData.ShowBloodTypeHint(ti.mcBase.BloodType.text);
		}
		mcBase.BloodTypeHint.onRollOut = function() { ti.HideHints(); }
		
		// Measurements
		mcBase.HeightWeightHint.onRollOver = function() { ti.ShowHintLangCR("SlaveHeightWeightHint"); }
		mcBase.HeightWeightHint.onRollOut = mcBase.BloodTypeHint.onRollOut;
		
		mcBase.ClitCockHint.onRollOver = function() {
			if (ti.coreGame.PersonOtherGender != 3 && ti.coreGame.PersonOtherGender != 6) ti.ShowHintLangCR("SlaveClitHint");
			else ti.ShowHintLangCR("SlaveCockHint");
		}
		mcBase.ClitCockHint.onRollOut = HideHints;
		
		mcBase.MeasurementsHint.onRollOver = function() {
			if (ti.coreGame.PersonOtherGender != 3 && ti.coreGame.PersonOtherGender != 6) ti.ShowHintLangCR("SlaveFigureHintFemale");
			else ti.ShowHintLangCR("SlaveFigureHintMale");
		}
		mcBase.MeasurementsHint.onRollOut = mcBase.BloodTypeHint.onRollOut;

		mcBase.PersonalityHint.onRollOver = function()
		{
			var sd:Object = ti.coreGame.StatisticsGroup.sdata;
			if (sd == _root) sd = ti.coreGame.slaveData;
			ti.ShowHint(sd.GetPersonalityDescription());
		}
		mcBase.PersonalityHint.onRollOut = mcBase.BloodTypeHint.onRollOut;
		
		mcBase.AgeHint.onRollOver = SlaveAgeHint;
		mcBase.AgeHint.onRollOut = mcBase.BloodTypeHint.onRollOut;
		
		mcBase.LGender.styleSheet = Language.styles;
		mcBase.LGender.autoSize = true;
		mcBase.LClitCock.styleSheet = Language.styles;

		// Gender
		mcBase.Gender.gotoAndStop(1);
		
		mcBase.GenderHint.onRollOver = function() {
			var sd:Object = ti.coreGame.StatisticsGroup.sdata;
			var sg:Number = sd.SlaveGender;
			var sgb:Number = sd.SlaveGenderBorn;
			
			//#slave was born #generslstring2, but now is #generalstring
			//#slave is #generalstring	
			ti.coreGame.genString = ti.Language.GetGenderString(sg);
			ti.coreGame.genString2 = ti.Language.GetGenderString(sgb);
			if (sgb != sg) ti.ShowHintLang(sg > 3 ? "SlaveTwinsChanged" : "SlaveChanged", "Gender");
			else ti.ShowHintLang(sg > 3 ? "SlaveTwins" : "Slave", "Gender");	
		}
		mcBase.GenderHint.tabEnabled = false;
		mcBase.GenderHint.onRollOut = mcBase.BloodTypeHint.onRollOut;		
	}
	
	public function SlaveAgeHint()
	{
		var pi:Number = coreGame.PersonIndex;
		var sd:Object = coreGame.StatisticsGroup.sdata;
		if (sd == _root) coreGame.PersonIndex = -50;
		else coreGame.PersonIndex = sd.SlaveIndex;
		ShowHintLang("HintAge");
		coreGame.PersonIndex = pi;
	}
		
	public function Show()
	{
		super.Show();
		
		var bShowOwner:Boolean = sd.Owner != null;
		mcBase.LOwner._visible = bShowOwner;
		mcBase.OwnerLabel._visible = bShowOwner;
		mcBase.HLine3._visible = bShowOwner;
		mcBase.HLine2._visible = true;
	}
	
	public function Hide()
	{
		super.Hide();
	}
		
	// Update the display
	
	public function UpdateOtherSlaveDetailsCommon(sd:Object)
	{
		if (sd.IsCumslut() && sd.Titles.indexOf("Cumslut") == -1) sd.SetTitle("Cumslut");
		
		coreGame.vitalsBustCurrent = sd.MilkInfluence > 0 ? Math.floor(sd.vitalsBust * 1.1) : sd.vitalsBust;
		mcBase.Bust.text = coreGame.vitalsBustCurrent;
		mcBase.BWH.text = "(" + Math.floor(coreGame.vitalsBustCurrent / 2.54) + "-" + Math.floor(sd.vitalsWaist / 2.54) + "-" + Math.floor(sd.vitalsHips / 2.54) + ")";
		mcBase.Description.htmlText = sd.SlaveName + ", " + sd.vitalsDescription;
		
		mcBase.Race.htmlText = sd.GetRace();
		
		if (sd != _root) {
			mcBase.Personality.htmlText = sd.GetAttitudeType().charAt(0) + sd.GetPerceptionType().charAt(0) + sd.GetJudgementType().charAt(0) + sd.GetLifestyleType().charAt(0);
			return;
		}
		mcBase.Personality.htmlText = coreGame.slaveData.GetAttitudeType().charAt(0) + NameCase(coreGame.slaveData.GetPerceptionType().charAt(1)) + coreGame.slaveData.GetJudgementType().charAt(0) + coreGame.slaveData.GetLifestyleType().charAt(0);
	}
	
	public function Update(sd:Object)
	{	
		if (sd == undefined) sd = _root;
		
		var Options:DialogOptions = coreGame.Options;
		
		if (Options.MetricOn) mcBase.Waist.text = sd.vitalsWaist;
		else mcBase.Waist.text = Math.round(sd.vitalsWaist / 2.54);
		if (Options.MetricOn) mcBase.Hips.text = sd.vitalsHips;
		else mcBase.Hips.text = Math.round(sd.vitalsHips / 2.54);
		mcBase.BloodType.text = sd.vitalsBloodType;
		if (Options.MetricOn) mcBase.Height.text = sd.vitalsHeight + Language.strCM;
		else {
			var vh:Number = (sd.vitalsHeight / 2.54) / 12;
			mcBase.Height.text = Math.floor(vh) + "'" + Math.floor(12 * (vh - Math.floor(vh))) + "'";
		}
		if (Options.MetricOn) mcBase.Weight.text = sd.vitalsWeight + " " + Language.strKG;
		else mcBase.Weight.text = int(sd.vitalsWeight * 2.2) + " " + Language.strPD;
		mcBase.Age.text = sd.vitalsAge == -1 ? "?" : sd.vitalsAge;
		if (sd.IsFemale()) mcBase.BustChest.htmlText = "<b>B:</b>";
		else mcBase.BustChest.htmlText = "<b>C:</b>";
		var dg:Boolean = sd.IsDickgirl();
		var bHasCock:Boolean = dg || sd.SlaveGender == 1 || sd.SlaveGender == 4;
	
		if (Options.MetricOn) mcBase.ClitCock.htmlText = (bHasCock ? Math.round(sd.ClitCockSize * 33) : (Math.round(sd.ClitCockSize * 10) / 10)) + " " + Language.strCM;
		else mcBase.ClitCock.htmlText = (bHasCock ? Math.round(sd.ClitCockSize * 33 / 2.54) : (Math.round(sd.ClitCockSize * 10 / 2.54) / 10)) + " " + Language.strIN;
		if (sd.Owner == null) return;
		var oid:Number = sd.Owner.GetOwner();
		if (oid == 0 || oid == 3000) oid = -100;
		mcBase.OwnerLabel.htmlText = coreGame.People.GetPersonsName(oid);
	}
	
	public function UpdateSlaveGender(dg:Boolean, hc:Boolean)
	{
		if (dg) mcBase.Gender.gotoAndStop(3);
		else if (hc) mcBase.Gender.gotoAndStop(1);
		else mcBase.Gender.gotoAndStop(2);
		
		mcBase.LClitCock.htmlText = hc ? Language.GetHtml("CockSize", Language.statNode, true, -1, "", ":") : Language.GetHtml("ClitoralSize", Language.statNode, true, -1, "", ":");
		
		if (hc && !dg) {
			mcBase.NymphomaniaLabel.htmlText = Language.GetHtml("Nymphomania", Language.statNode);
			mcBase.BGNymphomaniaLabel.htmlText = Language.GetHtml("Nymphomania", Language.statNode);
		} else {
			mcBase.NymphomaniaLabel.htmlText = Language.GetHtml("Satyriasis", Language.statNode);
			mcBase.BGNymphomaniaLabel.htmlText = Language.GetHtml("Satyriasis", Language.statNode);
		}
	}
	
	// Sexuality
	public function UpdateSexuality(sex:Number)
	{
		// TODO: not use SlaveFemale
		mcBase.SexualityBar._x = (sex * 1.5) + 89;
		if (sex < 25) mcBase.SexualityText.htmlText = Language.GetHtml(coreGame.SlaveFemale ? "SexualityLesbian" : "SexualityGay", Language.statNode);
		else if (sex > 75) mcBase.SexualityText.htmlText = Language.GetHtml("SexualityHetero", Language.statNode);
		else mcBase.SexualityText.htmlText = Language.GetHtml("SexualityBi", Language.statNode);
	}
	
	// Update theme for text contents
		
	public function UpdateText(str:String, aNode:XMLNode)
	{
		Language.ApplyLang(mcBase.LVitalStatistics, "VitalStatistics", false, -1);
		Language.ApplyLang(mcBase.LAge, "Age", true, -1);
		Language.ApplyLang(mcBase.LHeight, "Height", true, -1);
		Language.ApplyLang(mcBase.LWeight, "Weight", true, -1);
		Language.ApplyLang(mcBase.LSexuality, "Sexuality", true, -1);
		Language.ApplyLang(mcBase.LPersonality, "Personality", true, -1);
		Language.ApplyLang(mcBase.LBloodType, "BloodType", true, -1);
		mcBase.LGender.htmlText = Language.GetHtml("Gender", "Gender", true, -1, "", ":");
		mcBase.Gender._x = mcBase.LGender._x + mcBase.LGender._width + 12;
		mcBase.LOwner.htmlText = Language.GetHtml("Person1999", "People") + ":";
		Language.ApplyLang(mcBase.LRace, "Race", true, -1);
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
