// DisplaySlaveMakerVitals - Slave Vitals Panel
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplaySlaveMakerVitals extends DisplayBase {

	// Constructor
	public function DisplaySlaveMakerVitals(cg:Object)
	{ 
		super(cg.SlaveMakerVitalsGroup, cg);
		
		// Slave Maker
		mcBase.HeightWeightHint.tabEnabled = false;
		mcBase.ClitCockHint.tabEnabled = false;
		mcBase.MeasurementsHint.tabEnabled = false;

		var ti:DisplaySlaveMakerVitals = this;
		
		mcBase.BloodTypeHint.tabEnabled = false;
		mcBase.BloodTypeHint.tabEnabled = false;
		mcBase.BloodTypeHint.onRollOver = function() {
			ti.SMData.ShowBloodTypeHint(ti.SMData.vitalsBloodTypeSM);
		}
		mcBase.BloodTypeHint.onRollOut = function() { ti.HideHints(); }
		
		mcBase.GoldHint.tabEnabled = false;
		mcBase.GoldHint.onRollOver = function() {
			ti.ShowHint(ti.Language.GetHtml("HintPersonalGold", ti.Language.hintNode));
		}
		mcBase.GoldHint.onRollOut = mcBase.BloodTypeHint.onRollOut;	
		
		mcBase.DebtHint.tabEnabled = false;
		mcBase.DebtHint.onRollOver = function() {
			ti.ShowHint(ti.Language.GetHtml("HintDebt", ti.Language.hintNode));
		}
		mcBase.DebtHint.onRollOut = mcBase.GoldHint.onRollOut;		
		
		// Measurements
		mcBase.HeightWeightHint.tabEnabled = false;
		mcBase.HeightWeightHint.onRollOver = function() { ti.ShowHintLangCR("SMHeightWeightHint"); }
		mcBase.HeightWeightHint.onRollOut = mcBase.BloodTypeHint.onRollOut;
		
		mcBase.ClitCockHint.tabEnabled = false;
		mcBase.ClitCockHint.onRollOver = function() {
			if (ti.SMData.Gender == 2) ti.ShowHintLangCR("SMClitHint");
			else ti.ShowHintLangCR("SMCockHint");
		}
		mcBase.ClitCockHint.onRollOut = mcBase.BloodTypeHint.onRollOut;
		
		mcBase.MeasurementsHint.tabEnabled = false;
		mcBase.MeasurementsHint.onRollOver = function() {
			if (ti.SMData.Gender != 1) ti.ShowHintLangCR("SMFigureHintFemale");
			else ti.ShowHintLangCR("SMFigureHintMale");
		}
		mcBase.MeasurementsHint.onRollOut = mcBase.BloodTypeHint.onRollOut;

		// Gender
		mcBase.LGender.styleSheet = Language.styles;
		mcBase.LGender.autoSize = true;
		mcBase.GenderHint.tabEnabled = false;
		mcBase.GenderHint.onRollOver = function() {
			//You were born #generslstring2, but now you are #generalstring
			//You are #generalstring
		
			ti.coreGame.genString = ti.Language.GetGenderString(ti.SMData.Gender);
			ti.coreGame.genString2 = ti.Language.GetGenderString(ti.SMData.OldGender);
			if (ti.SMData.OldGender != ti.SMData.Gender) ti.ShowHintLang("SlaveMakerChanged", "Gender");
			else ti.ShowHintLang("SlaveMaker", "Gender");
		}
		mcBase.Gender.tabEnabled = false;
		mcBase.GenderHint.onRollOut = mcBase.BloodTypeHint.onRollOut;
		mcBase.GenderHint.tabEnabled = false;		
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
		mcBase.SMGoldText._visible = SMData.GuildMember;
		mcBase.LPersonal._visible = SMData.GuildMember;
		mcBase.GoldHint._visible = SMData.GuildMember;
		
		mcBase.SMGoldText.text = Math.ceil(SMData.SMGold);
		coreGame.AssistantSelection.SMGoldText.text = Math.ceil(SMData.SMGold);
		mcBase.DebtText.text = Math.ceil(SMData.SMDebt);
	
		if (coreGame.DoneMaster == 1) coreGame.SGMasterName = coreGame.Master;
		else coreGame.SGMasterName = SMData.SlaveMakerName;
		mcBase.SMName.text = SMData.SlaveMakerName;
		
		mcBase.BloodType.text = SMData.vitalsBloodTypeSM;	
			
		if (coreGame.Options.MetricOn) {
			mcBase.Bust.text = Math.round(SMData.vitalsBustSM);
			mcBase.Waist.text = Math.round(SMData.vitalsWaistSM);
			mcBase.Hips.text = Math.round(SMData.vitalsHipsSM);
			mcBase.Height.text = Math.round(SMData.vitalsHeightSM) + Language.strCM;
			mcBase.Weight.text = Math.round(SMData.vitalsWeightSM) + Language.strKG;
			mcBase.ClitCock.htmlText = (SMData.Gender != 2 ? Math.round(SMData.ClitCockSizeSM * 33) : (Math.round(SMData.ClitCockSizeSM * 10) / 10)) + Language.strCM;
			mcBase.BWH.text = "(" + Math.round(SMData.vitalsBustSM / 2.54) + "-" + Math.round(SMData.vitalsWaistSM / 2.54) + "-" + Math.round(SMData.vitalsHipsSM / 2.54) + ")";
		} else {
			var vh:Number = (SMData.vitalsHeightSM / 2.54) / 12;
			mcBase.Bust.text = Math.round(SMData.vitalsBustSM / 2.54);
			mcBase.Waist.text = Math.round(SMData.vitalsWaistSM / 2.54);
			mcBase.Hips.text = Math.round(SMData.vitalsHipsSM / 2.54);
			mcBase.Height.text = Math.floor(vh) + "'" + Math.floor(12 * (vh - Math.floor(vh))) + "'";
			mcBase.Weight.text = int(SMData.vitalsWeightSM * 2.2) + " " + Language.strPD;
			mcBase.ClitCock.htmlText = (SMData.Gender != 2 ? Math.round(SMData.ClitCockSizeSM * 33 / 2.54) : (Math.ceil(SMData.ClitCockSizeSM * 10 / 2.54) / 10)) + " " + Language.strIN;
			mcBase.BWH.text = "(" + Math.round(SMData.vitalsBustSM / 2.54) + "-" + Math.round(SMData.vitalsWaistSM / 2.54) + "-" + Math.round(SMData.vitalsHipsSM / 2.54) + ")";
		}
		
		mcBase.Race.htmlText = SMData.GetRace();		
	}
	
	public function UpdateSlaveMakerGender()
	{		
		mcBase.Gender.gotoAndStop(SMData.Gender);
		mcBase.Gender.gotoAndStop(SMData.Gender);
		if (SMData.Gender == 0) {
			mcBase.Nymphomania.StatLabel.htmlText = Language.GetHtml("Nymphomania", Language.statNode);
			mcBase.Nymphomania.BGStatLabel.htmlText = Language.GetHtml("Nymphomania", Language.statNode);
		} else if (SMData.Gender != 1) {
			mcBase.Nymphomania.StatLabel.htmlText = Language.GetHtml("Nymphomania", Language.statNode);
			mcBase.Nymphomania.BGStatLabel.htmlText = Language.GetHtml("Nymphomania", Language.statNode);
		} else {
			mcBase.Nymphomania.StatLabel.htmlText = Language.GetHtml("Satyriasis", Language.statNode);
			mcBase.Nymphomania.BGStatLabel.htmlText = Language.GetHtml("Satyriasis", Language.statNode);
		}
		mcBase.LClitCock.htmlText = SMData.Gender != 2 ? Language.GetHtml("CockSize", Language.statNode, true, -1, "", ":") : Language.GetHtml("ClitoralSize", Language.statNode, true, -1, "", ":");
		if (SMData.Gender != 1) mcBase.BustChest.htmlText = "<b>B:</b>";
		else mcBase.BustChest.htmlText = "<b>C:</b>";
	}


	// Update contents of text fields
		
	public function UpdateText(str:String, aNode:XMLNode) 
	{
		Language.ApplyLang(mcBase.LYourStats, "YourVitals", false, -1);

		Language.ApplyLang(mcBase.LFinances, "Finances", false, -1);
		Language.ApplyLang(mcBase.LPersonal, "PersonalGold", true, -1);
		Language.ApplyLang(mcBase.LDebt, "Debt", true, -1);

		Language.ApplyLang(mcBase.LVitalStatistics, "VitalStatistics", false, -1);
		Language.ApplyLang(mcBase.LHeight, "Height", true, -1);
		Language.ApplyLang(mcBase.LWeight, "Weight", true, -1);
		Language.ApplyLang(mcBase.LBloodType, "BloodType", true, -1);
		//mcBase.LGender.htmlText = mcBase.LGender.htmlText;
		//mcBase.Gender._x = mcBase.LGender._x + mcBase.LGender._width + 12;
		Language.ApplyLang(mcBase.LRace, "Race", true, -1);
		
		Language.ApplyLang(mcBase.LHouse, "House", false, -1);
		Language.ApplyLang(mcBase.LHomeTown, "HomeTown", false, -1, undefined, false, ":");
	}
	
	public function ApplyTheme(cvo:ColourScheme)	{ }
	
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
