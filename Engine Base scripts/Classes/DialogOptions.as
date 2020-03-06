// DialogOptions - Options
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogOptions extends DialogBase {
	
	// Options
	public var TentaclesOn:Number;
	public var Difficulty:Number;
	public var CombatDifficulty:Number;
	public var BDSMOn:Boolean;
	public var RapeOn:Boolean;
	public var GlobalTentacleFrequency:Number;
	public var BadEndsOn:Boolean;
	public var IncestOn:Boolean;
	public var TutorialOn:Boolean;
	public var FurriesOn:Boolean;
	public var NonHumansOn:Boolean;
	public var SandboxOn:Boolean;
	public var Clock24On:Boolean;
	public var FullscreenOn:Boolean;
	//public var LastUpdateCheck:Number;
	public var StatIcons:Boolean;
	public var StatImagesOn:Boolean;
	public var bSoundsOn:Boolean;
	public var MetricOn:Boolean;
	public var bLimitSavesOn:Boolean;
	public var bShowVanillaOn:Boolean;
	public var PregnancyOn:Boolean;
	
	public var DickgirlOn:Number;
	public var AllDickgirlXFOn:Boolean;
	public var GlobalDickgirlFrequency:Number;
	public var DickgirlTesticles:Boolean;
	public var DickgirlStartOn:Boolean;
	public var DickgirlLesbians:Boolean;
	
	public var PonygirlsOn:Boolean;
	
	private var optTabs:TabGroup;
	
	
	// Constructor
	public function DialogOptions(cg:Object)
	{ 
		super(cg.OptionsMenu, cg);
		
		// Options
		TentaclesOn = 1;
		Difficulty = 0;
		CombatDifficulty = 0;
		BDSMOn = true;
		RapeOn = true;
		GlobalTentacleFrequency = 15;
		BadEndsOn = false;
		IncestOn = true;
		TutorialOn = true;
		FurriesOn = true;
		NonHumansOn = true;
		SandboxOn = false;
		Clock24On = false;
		FullscreenOn = true;
		//LastUpdateCheck = 0;
		StatIcons = true;
		StatImagesOn = true;
		bSoundsOn = true;
		MetricOn = true;
		bLimitSavesOn = false;
		bShowVanillaOn = true;
		PregnancyOn = true;
		DickgirlOn = 1;
		AllDickgirlXFOn = true;
		GlobalDickgirlFrequency = 1;
		DickgirlTesticles = true;
		DickgirlStartOn = false;
		DickgirlLesbians = false;
		PonygirlsOn = true;

		LoadGlobalData();
		Copy(this, coreGame);
		
		var ti:DialogOptions = this;
		
		coreGame.SlaveMakerCreate1.OptionsButton.tabChildren = true;
		coreGame.SlaveMakerCreate1.OptionsButton.Btn.onPress = function() {
			ti.ViewDialog();
		}
		coreGame.VisitFortuneTeller.OptionsButton.tabChildren = true;
		coreGame.VisitFortuneTeller.OptionsButton.Btn.onPress = coreGame.SlaveMakerCreate1.OptionsButton.Btn.onPress;
		
		mcBase.tabChildren = true;
	}
	
	public function ViewDialog()
	{
		InitialiseModule();
		SetSlave(coreGame.slaveData);

		var ti:DialogOptions = this;
		
		// close button
		mcBase.CloseButton.tabChildren = true;
		mcBase.CloseButton.Btn.onPress = function() { ti.LeaveDialog();	}
		
		//
		// Appearance Tab
		
		mcBase.Appearance.TutorialOn.onRollOut = OptionsRollout;
		mcBase.Appearance.TutorialOn.onPress = function()
		{
			ti.TutorialOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.TutorialOn.onRollOver = function() 
		{
			ti.OptionHint2("TutorialOn", true);
		}
		mcBase.Appearance.TutorialOff.onRollOut = OptionsRollout;
		mcBase.Appearance.TutorialOff.onPress = function()
		{
			ti.TutorialOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.TutorialOff.onRollOver = function() 
		{
			ti.OptionHint2("TutorialOff", false);
		}
		
		mcBase.Appearance.SoundsOn.onRollOut = OptionsRollout;
		mcBase.Appearance.SoundsOn.onPress = function()
		{
			ti.bSoundsOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.SoundsOn.onRollOver = function() 
		{
			ti.OptionHint("SoundEffects", true);
		}
		mcBase.Appearance.SoundsOff.onRollOut = OptionsRollout;
		mcBase.Appearance.SoundsOff.onPress = function()
		{
			ti.bSoundsOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.SoundsOff.onRollOver = function() 
		{
			ti.OptionHint("SoundEffects", false);
		}
		
		mcBase.Appearance.MetricOff.onRollOut = OptionsRollout;
		mcBase.Appearance.MetricOff.onPress = function()
		{
			ti.MetricOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.MetricOff.onRollOver = function() 
		{
			ti.OptionHint2("MetricOff");
		}
		mcBase.Appearance.MetricOn.onRollOut = OptionsRollout;
		mcBase.Appearance.MetricOn.onPress = function()
		{
			ti.MetricOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.MetricOn.onRollOver = function() 
		{
			ti.OptionHint2("MetricOn");
		}
		
		mcBase.Appearance.StatIconsOff.onRollOut = OptionsRollout;
		mcBase.Appearance.StatIconsOff.onPress = function()
		{
			ti.StatIcons = true;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.StatIconsOff.onRollOver = function() 
		{
			ti.OptionHint2("StatIconOff");
		}
		mcBase.Appearance.StatIconsOn.onRollOut = OptionsRollout;
		mcBase.Appearance.StatIconsOn.onPress = function()
		{
			ti.StatIcons = false;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.StatIconsOn.onRollOver = function() 
		{
			ti.OptionHint2("StatIconOn");
		}
		
		
		mcBase.Appearance.FullOff.onRollOut = OptionsRollout;
		mcBase.Appearance.FullOff.onPress = function()
		{
			ti.FullscreenOn = true;
			fscommand("fullscreen", "fullscreen");
			ti.SaveGlobalData();
		}
		mcBase.Appearance.FullOff.onRollOver = function() 
		{
			ti.OptionHint2("FullscreenOff");
		}
		mcBase.Appearance.FullOn.onRollOut = OptionsRollout;
		mcBase.Appearance.FullOn.onPress = function()
		{
			ti.FullscreenOn = false;
			fscommand("fullscreen", false);
			fscommand("showmenu", false);
			ti.SaveGlobalData();
		}
		mcBase.Appearance.FullOn.onRollOver = function() 
		{
			ti.OptionHint2("FullscreenOn");
		}
		
		mcBase.Appearance.StatImagesOff.onRollOut = OptionsRollout;
		mcBase.Appearance.StatImagesOff.onPress = function()
		{
			ti.StatImagesOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.StatImagesOff.onRollOver = function() 
		{
			ti.OptionHint2("StatImagesOff");
		}
		mcBase.Appearance.StatImagesOn.onRollOut = OptionsRollout;
		mcBase.Appearance.StatImagesOn.onPress = function()
		{
			ti.StatImagesOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.StatImagesOn.onRollOver = function() 
		{
			ti.OptionHint2("StatImagesOn");
		}
		
		mcBase.Appearance.Clock24Off.onRollOut = OptionsRollout;
		mcBase.Appearance.Clock24Off.onPress = function()
		{
			ti.Clock24On = true;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.Clock24Off.onRollOver = function() 
		{
			ti.OptionHint2("ClockOff");
		
		}
		mcBase.Appearance.Clock24On.onRollOut = OptionsRollout;
		mcBase.Appearance.Clock24On.onPress = function()
		{
			ti.Clock24On = false;
			ti.SaveGlobalData();
		}
		mcBase.Appearance.Clock24On.onRollOver = function() 
		{
			ti.OptionHint2("ClockOn");
		}
		
		//
		// Content Tab
		
		mcBase.Content.TentaclesOff.onRollOut = OptionsRollout;
		mcBase.Content.TentaclesOff.onPress = function()
		{
			if (ti.Difficulty == -1) {
				ti.mcBase.Information.text = "Difficulty level is set to Easy, Tentacles cannot be turned on in Easy Difficulty setting";
				ti.Bloop();
			} else {
				ti.TentaclesOn = 1;
				ti.SaveGlobalData();
			}
		}
		mcBase.Content.TentaclesOff.onRollOver = function() 
		{
			ti.OptionHint("Tentacles", false);
		}
		mcBase.Content.TentaclesOn.onRollOut = OptionsRollout;
		mcBase.Content.TentaclesOn.onPress = function()
		{
			ti.TentaclesOn = 0;
			ti.SaveGlobalData();
		}
		mcBase.Content.TentaclesOn.onRollOver = function() 
		{
			ti.OptionHint("Tentacles", true);
		}
		mcBase.Content.TentacleRareOff.onRollOut = OptionsRollout;
		mcBase.Content.TentacleRareOff.onPress = function()
		{
			ti.GlobalTentacleFrequency = 15;
			ti.SaveGlobalData();
		}
		mcBase.Content.TentacleRareOff.onRollOver = function() 
		{
			ti.OptionHint2("TentacleRare");
		}
		mcBase.Content.TentacleRareOn.onRollOut = OptionsRollout;
		mcBase.Content.TentacleRareOn.onRollOver = mcBase.Content.TentacleRareOff.onRollOver;
		mcBase.Content.TentacleUncommonOff.onRollOut = OptionsRollout;
		mcBase.Content.TentacleUncommonOff.onPress = function()
		{
			ti.GlobalTentacleFrequency = 33;
			ti.SaveGlobalData();
		}
		mcBase.Content.TentacleUncommonOff.onRollOver = function() 
		{
			ti.OptionHint2("TentacleUncommon");
		}
		mcBase.Content.TentacleUncommonOn.onRollOut = OptionsRollout;
		mcBase.Content.TentacleUncommonOn.onRollOver = mcBase.Content.TentacleUncommonOff.onRollOver;
		mcBase.Content.TentacleOftenOff.onRollOut = OptionsRollout;
		mcBase.Content.TentacleOftenOff.onPress = function()
		{
			ti.GlobalTentacleFrequency = 50;
			ti.SaveGlobalData();
		}
		mcBase.Content.TentacleOftenOff.onRollOver = function() 
		{
			ti.OptionHint2("TentacleOften");
		}
		mcBase.Content.TentacleOftenOn.onRollOut = OptionsRollout;
		mcBase.Content.TentacleOftenOn.onRollOver = mcBase.Content.TentacleOftenOff.onRollOver;
		mcBase.Content.RapeOn.onRollOut = OptionsRollout;
		mcBase.Content.RapeOn.onPress = function()
		{
			ti.RapeOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.RapeOn.onRollOver = function() 
		{
			ti.OptionHint2("RapeOn");
		}
		mcBase.Content.RapeOff.onRollOut = OptionsRollout;
		mcBase.Content.RapeOff.onPress = function()
		{
			ti.RapeOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.RapeOff.onRollOver = function() 
		{
			ti.OptionHint2("RapeOff");
		}
		mcBase.Content.DickgirlOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlOff.onPress = function()
		{
			ti.DickgirlOn = 1;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlOff.onRollOver = function() 
		{
			ti.OptionHint("Dickgirls", false);
		}
		mcBase.Content.DickgirlOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlOn.onPress = function()
		{
			ti.DickgirlOn = 0;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlOn.onRollOver = function() 
		{
			ti.OptionHint("Dickgirls", true);
		}
		mcBase.Content.AllDickgirlXFOff.onRollOut = OptionsRollout;
		mcBase.Content.AllDickgirlXFOff.onPress = function()
		{
			ti.AllDickgirlXFOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.AllDickgirlXFOff.onRollOver = function() 
		{
			ti.OptionHint2("AllTransformOff");
		}
		mcBase.Content.AllDickgirlXFOn.onRollOut = OptionsRollout;
		mcBase.Content.AllDickgirlXFOn.onPress = function()
		{
			ti.AllDickgirlXFOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.AllDickgirlXFOn.onRollOver = function() 
		{
			ti.OptionHint2("AllTransformOn");
		}
		mcBase.Content.BDSMOn.onRollOut = OptionsRollout;
		mcBase.Content.BDSMOn.onPress = function()
		{
			ti.BDSMOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.BDSMOn.onRollOver = function() 
		{
			ti.OptionHint("BDSM", true);
		}
		mcBase.Content.BDSMOff.onRollOut = OptionsRollout;
		mcBase.Content.BDSMOff.onPress = function()
		{
			ti.BDSMOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.BDSMOff.onRollOver = function() 
		{
			ti.OptionHint("BDSM", false);
		}
		mcBase.Content.PonygirlOff.onRollOut = OptionsRollout;
		mcBase.Content.PonygirlOff.onPress = function()
		{
			ti.PonygirlsOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.PonygirlOff.onRollOver = function() 
		{
			ti.OptionHint2("PonygirlOff");
		}
		mcBase.Content.PonygirlOn.onRollOut = OptionsRollout;
		mcBase.Content.PonygirlOn.onPress = function()
		{
			ti.PonygirlsOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.PonygirlOn.onRollOver = function() 
		{
			ti.OptionHint2("PonygirlOn");
		}
		
		mcBase.Content.BadEndsOff.onRollOut = OptionsRollout;
		mcBase.Content.BadEndsOff.onPress = function()
		{
			ti.BadEndsOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.BadEndsOff.onRollOver = function() 
		{
			ti.OptionHint2("BadEndsOff");
		}
		mcBase.Content.BadEndsOn.onRollOut = OptionsRollout;
		mcBase.Content.BadEndsOn.onPress = function()
		{
			ti.BadEndsOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.BadEndsOn.onRollOver = function() 
		{
			ti.OptionHint2("BadEndsOn");
		}
		mcBase.Content.IncestOff.onRollOut = OptionsRollout;
		mcBase.Content.IncestOff.onPress = function()
		{
			ti.IncestOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.IncestOff.onRollOver = function() 
		{
			ti.OptionHint2("IncestOff");
		}
		mcBase.Content.IncestOn.onRollOut = OptionsRollout;
		mcBase.Content.IncestOn.onPress = function()
		{
			ti.IncestOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.IncestOn.onRollOver = function() 
		{
			ti.OptionHint2("IncestOn");
		}
		
		mcBase.Content.DickgirlRareOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlRareOff.onPress = function()
		{
			ti.GlobalDickgirlFrequency = 0;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlRareOff.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlRare");
		}
		mcBase.Content.DickgirlRareOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlRareOn.onRollOver = mcBase.Content.DickgirlRareOff.onRollOver;
		mcBase.Content.DickgirlCommonOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlCommonOff.onPress = function()
		{
			ti.GlobalDickgirlFrequency = 1;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlCommonOff.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlCommon");
		}
		mcBase.Content.DickgirlCommonOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlCommonOn.onRollOver = mcBase.Content.DickgirlCommonOff.onRollOver;
		mcBase.Content.DickgirlAlwaysOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlAlwaysOff.onPress = function()
		{
			ti.GlobalDickgirlFrequency = 2;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlAlwaysOff.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlAlways");
		}
		mcBase.Content.DickgirlAlwaysOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlAlwaysOn.onRollOver = mcBase.Content.DickgirlAlwaysOff.onRollOver;
		
		mcBase.Content.FurriesOffBtn.onRollOut = OptionsRollout;
		mcBase.Content.FurriesOffBtn.onPress = function()
		{
			ti.FurriesOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.FurriesOffBtn.onRollOver = function()
		{
			ti.OptionHint2("FurriesOff");
		}
		mcBase.Content.FurriesOnBtn.onRollOut = OptionsRollout;
		mcBase.Content.FurriesOnBtn.onPress = function()
		{
			ti.FurriesOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.FurriesOnBtn.onRollOver = function() 
		{
			ti.OptionHint2("FurriesOn");
		}
		
		mcBase.Content.NonHumanOffBtn.onRollOut = OptionsRollout;
		mcBase.Content.NonHumanOffBtn.onPress = function()
		{
			ti.NonHumansOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.NonHumanOffBtn.onRollOver = function()
		{
			ti.OptionHint2("NonHumanOff");
		}
		mcBase.Content.NonHumanOnBtn.onRollOut = OptionsRollout;
		mcBase.Content.NonHumanOnBtn.onPress = function()
		{
			ti.NonHumansOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.NonHumanOnBtn.onRollOver = function() 
		{
			ti.OptionHint2("NonHumanOn");
		}
		
		mcBase.Content.PregnancyOffBtn.onRollOut = OptionsRollout;
		mcBase.Content.PregnancyOffBtn.onPress = function()
		{
			ti.PregnancyOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.PregnancyOffBtn.onRollOver = function()
		{
			ti.OptionHint2("PregnancyOff");
		}
		mcBase.Content.PregnancyOnBtn.onRollOut = OptionsRollout;
		mcBase.Content.PregnancyOnBtn.onPress = function()
		{
			ti.PregnancyOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.PregnancyOnBtn.onRollOver = function() 
		{
			ti.OptionHint2("PregnancyOn");
		}
		
		mcBase.Content.DickgirlLesbiansOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlLesbiansOff.onPress = function()
		{
			ti.DickgirlLesbians = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlLesbiansOff.onRollOver = function() 
		{
			ti.OptionHint2("LesbiansDickgirlsOff");
		}
		mcBase.Content.DickgirlLesbiansOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlLesbiansOn.onPress = function()
		{
			ti.DickgirlLesbians = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlLesbiansOn.onRollOver = function() 
		{
			ti.OptionHint2("LesbiansDickgirlsOn");
		}
		
		mcBase.Content.DickgirlTesticlesOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlTesticlesOff.onPress = function()
		{
			ti.DickgirlTesticles = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlTesticlesOff.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlTesticlesOff");
		}
		mcBase.Content.DickgirlTesticlesOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlTesticlesOn.onPress = function()
		{
			ti.DickgirlTesticles = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlTesticlesOn.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlTesticlesOn");
		}
		
		mcBase.Content.DickgirlStartOff.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlStartOff.onPress = function()
		{
			ti.DickgirlStartOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlStartOff.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlStartOff");
		}
		mcBase.Content.DickgirlStartOn.onRollOut = OptionsRollout;
		mcBase.Content.DickgirlStartOn.onPress = function()
		{
			ti.DickgirlStartOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.DickgirlStartOn.onRollOver = function() 
		{
			ti.OptionHint2("DickgirlStartOn");
		}
		
		mcBase.Content.CatgirlsCommon.onRollOut = OptionsRollout;
		mcBase.Content.CatgirlsCommon.onPress = function()
		{
			ti.coreGame.bCatgirlsCommon = false;
			ti.SaveGlobalData();
		}
		mcBase.Content.CatgirlsCommon.onRollOver = function() 
		{
			ti.OptionHint2("CatgirlsCommonOn");
		}
		mcBase.Content.CatgirlsRare.onRollOut = OptionsRollout;
		mcBase.Content.CatgirlsRare.onPress = function()
		{
			ti.coreGame.bCatgirlsCommon = true;
			ti.SaveGlobalData();
		}
		mcBase.Content.CatgirlsRare.onRollOver = function() 
		{
			ti.OptionHint2("CatgirlsCommonOff");
		}
		
		//
		// Gameplay Tab
		
		mcBase.Gameplay.DifficultyEasyOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyEasyOff.onPress = function()
		{
			ti.Difficulty = -1;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.DifficultyEasyOff.onRollOver = function() 
		{
			ti.mcBase.Information.text = ti.Language.GetHtml("Easy", "Options") + "\r" + ti.Language.GetHtml("DifficultyEasyHint", "Options");
		}
		mcBase.Gameplay.DifficultyEasyOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyEasyOn.onRollOver = mcBase.Gameplay.DifficultyEasyOff.onRollOver;
		mcBase.Gameplay.DifficultyNormalOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyNormalOff.onPress = function()
		{
			ti.Difficulty = 0;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.DifficultyNormalOff.onRollOver = function() 
		{
			ti.mcBase.Information.text = ti.Language.GetHtml("Normal", "Options") + "\r" + ti.Language.GetHtml("DifficultyNormalHint", "Options");
		}
		mcBase.Gameplay.DifficultyNormalOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyNormalOn.onRollOver = mcBase.Gameplay.DifficultyNormalOff.onRollOver;
		mcBase.Gameplay.DifficultyDifficultOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyDifficultOff.onPress = function()
		{
			ti.Difficulty = 1;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.DifficultyDifficultOff.onRollOver = function() 
		{
			ti.mcBase.Information.text = ti.Language.GetHtml("Difficult", "Options") + "\r" + ti.Language.GetHtml("DifficultyDifficultHint", "Options");
		}
		mcBase.Gameplay.DifficultyDifficultOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyDifficultOn.onRollOver = mcBase.Gameplay.DifficultyDifficultOff.onRollOver;
		mcBase.Gameplay.DifficultyHardOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyHardOff.onPress = function()
		{
			ti.Difficulty = 2;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.DifficultyHardOff.onRollOver = function() 
		{
			ti.mcBase.Information.text = ti.Language.GetHtml("Hard", "Options") + "\r" + ti.Language.GetHtml("DifficultyHardHint", "Options");
		}
		mcBase.Gameplay.DifficultyHardOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.DifficultyHardOn.onRollOver = mcBase.Gameplay.DifficultyHardOff.onRollOver;
		mcBase.Gameplay.CombatOffOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatOffOff.onPress = function()
		{
			ti.CombatDifficulty = -1;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.CombatOffOff.onRollOver = function() 
		{
			ti.OptionHint2("CombatOff");
		}
		mcBase.Gameplay.CombatOffOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatOffOn.onRollOver = mcBase.Gameplay.CombatOffOff.onRollOver;
		mcBase.Gameplay.CombatStandardOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatStandardOff.onPress = function()
		{
			ti.CombatDifficulty = 0;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.CombatStandardOff.onRollOver = function() 
		{
			ti.OptionHint2("CombatNormal");
		}
		mcBase.Gameplay.CombatStandardOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatStandardOn.onRollOver = mcBase.Gameplay.CombatStandardOff.onRollOver;
		mcBase.Gameplay.CombatDifficultOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatDifficultOff.onPress = function()
		{
			ti.CombatDifficulty = 1;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.CombatDifficultOff.onRollOver = function() 
		{
			ti.OptionHint2("CombatDifficult");
		}
		mcBase.Gameplay.CombatDifficultOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatDifficultOn.onRollOver = mcBase.Gameplay.CombatDifficultOff.onRollOver;
		mcBase.Gameplay.CombatLoseOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatLoseOff.onPress = function()
		{
			ti.CombatDifficulty = 2;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.CombatLoseOff.onRollOver = function() 
		{
			ti.OptionHint2("CombatLose");
		}
		mcBase.Gameplay.CombatLoseOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.CombatLoseOn.onRollOver = mcBase.Gameplay.CombatLoseOff.onRollOver;
		
		mcBase.Gameplay.LimitSavesOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.LimitSavesOff.onPress = function()
		{	
			ti.bLimitSavesOn = true;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.LimitSavesOff.onRollOver = function() 
		{
			ti.OptionHint2("LimitSavesOff");
		
		}
		mcBase.Gameplay.LimitSavesOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.LimitSavesOn.onPress = function()
		{
			ti.bLimitSavesOn = false;
			ti.SaveGlobalData();
		}
		mcBase.Gameplay.LimitSavesOn.onRollOver = function() 
		{
			ti.OptionHint2("LimitSavesOn");
		}
		
		mcBase.Gameplay.SandboxOff.onRollOut = OptionsRollout;
		mcBase.Gameplay.SandboxOff.onPress = function()
		{
			if (ti.coreGame.SlaveName != "") {
				ti.mcBase.Information.text = ti.Language.GetHtml("CannotChange", "Options");
				ti.Bloop();
			} else {		
				ti.SandboxOn = true;
				ti.SaveGlobalData();
			}
		}
		mcBase.Gameplay.SandboxOff.onRollOver = function() 
		{
			ti.OptionHint2("SandboxOff");
		
		}
		mcBase.Gameplay.SandboxOn.onRollOut = OptionsRollout;
		mcBase.Gameplay.SandboxOn.onPress = function()
		{
			if (ti.coreGame.SlaveName != "") {
				ti.mcBase.Information.text = ti.Language.GetHtml("CannotChange", "Options");
				ti.Bloop();
			} else {		
				ti.SandboxOn = false;
				ti.SaveGlobalData();
			}
		}
		mcBase.Gameplay.SandboxOn.onRollOver = function() 
		{
			ti.OptionHint2("SandboxOn");
		}
		
		mcBase.ContentButton.Btn.onPress();
		
		optTabs = new TabGroup(coreGame, 0xffffff, 0xe0e0e0, this, "ChangeTab");
		optTabs.AddTab(mcBase.GameplayTab);
		optTabs.AddTab(mcBase.ContentTab);
		optTabs.AddTab(mcBase.AppearanceTab);
		
		Language.PopulateLanguageNode(Language.XMLData.GetNode(Language.flNode, "Options"));
				
		UpdateFromGlobalData();
		coreGame.DisableButtons();
		CopyTF(mcBase.CloseButton.LText, coreGame.Quitter.LText);
		if (TutorialOn && SMData.BitFlagSM.CheckAndSetBitFlag(40)) coreGame.Information.ShowTutorial(Language.GetHtml("Title", "Options"), Language.GetHtml("TutorialOptions", "Hints"));
				
		super.ViewDialog();
	}
	
	public function ShowDialogContents(notext:Boolean)
	{
		StopHints();
		coreGame.HideAllImages();
		coreGame.TitleScreen.LoadButton.Hide();
		optTabs.SelectTab(0);
		mcBase._x = 250;
		mcBase._visible = true;

		Backgrounds.ShowIntroBackground();
	}
	
	public function ChangeTab(idx:Number)
	{
		OptionsRollout();
		switch(idx) {
			case 0:
				mcBase.Gameplay._visible = true;
				mcBase.Content._visible = false;
				mcBase.Appearance._visible = false;
				return;
			case 1:
				mcBase.Gameplay._visible = false;
				mcBase.Content._visible = true;
				mcBase.Appearance._visible = false;
				return;
			case 2:
				mcBase.Gameplay._visible = false;
				mcBase.Content._visible = false;
				mcBase.Appearance._visible = true;
				return;
		}
	}


	// Done, close the dialog
	public function LeaveDialog()
	{
		super.LeaveDialog();
		
		mcBase._x = 2250;
		mcBase._visible = false;
		coreGame.TentacleFrequency = GlobalTentacleFrequency;
		coreGame.DickgirlFrequency = GlobalDickgirlFrequency;
		Language.LangType = mcBase.Appearance.LanguageInput.text;
		var slines:Array = Language.LangType.split("\r\n");
		Language.LangType = slines[0];
		slines = Language.LangType.split("\r");
		Language.LangType = slines[0];
		slines = Language.LangType.split("\n");
		Language.LangType = slines[0];
		slines = Language.LangType.split(" ");
		for (var i:Number = 0; i < slines.length; i++) {
			if (slines[i] != "") {
				Language.LangType = slines[i];
				break;
			}
		}
		Language.LangType = NameCase(Language.LangType.toLowerCase());
		coreGame.dmod = 1 - (Difficulty / 7);
		if (SMData.PonygirlAware == -1) SMData.PonygirlAware = PonygirlsOn ? 0 : -1;
		else if (!PonygirlsOn) {
			SMData.PonygirlAware = -1;
			coreGame.DonePonygirl = 0;
		}
		SaveOnlyGlobalData();
		Copy(this, coreGame);		// todo remove
		if (coreGame.TitleScreen.Introduction != 5.05 && coreGame.TitleScreen.Introduction != -1) coreGame.dspMain.Show();
		Timers.ShowWait(true);
		Language.ChangeLanguage(false, "OptionsLanguageUpdate", this);
	}


	public function OptionsLanguageUpdate()
	{
		trace("OptionsLanguageUpdate");
	
		coreGame.SlaveSelect.ClearBackground();
		coreGame.AssistantDescriptionBase = "";
		SMData.ShowSMQualities();
		coreGame.ChangeSlaveMakerGender();
		coreGame.dspMain.UpdateSlaveVitals();
		coreGame.UpdateOtherSlaveDetails();
		coreGame.UpdateSlaveGenderText();
		coreGame.SetActButtonDetailsStartup();
		SMData.ChangeSlaveMakerFaith();
		UpdateFromGlobalData();
		coreGame.UpdateTime();
		coreGame.PlanningSelections.ChkSameListNight.invalidate();
		coreGame.PlanningSelections.ChkSameListDay.invalidate();
		coreGame.EnableButtons();
		Timers.StopWait();
		
		if (coreGame.TitleScreen.Introduction == 5.05) coreGame.DoSlaveMakerCreate1a();
		else if (coreGame.TitleScreen.Introduction == -1) coreGame.currentCity.DoVisitNow(32);
		else {
			coreGame.dspMain.Show();
			coreGame.dspMain.ShowMainButtons();
			coreGame.dspMain.ShowStatisticsTab(0);
		}
	}

	public function OptionsRollout()
	{
		mcBase.Information.text = "";
	}
	
	public function OptionHint(opt:String, opton:Boolean)
	{
		mcBase.Information.htmlText = Language.GetHtml(opt + "Hint", "Options") + "\r" + Language.GetHtml(opton ? "CurrentlyOn" : "CurrentlyOff", "Options");
	}
	
	public function OptionHint2(opt:String)
	{
		mcBase.Information.htmlText = Language.GetHtml(opt + "Hint", "Options");
	}
	
	
	// Load/Save/Update
	
	public function UpdateFromGlobalData(nocopy:Boolean)
	{
		trace("UpdateFromGlobalData");
		if (nocopy != true) Copy(coreGame, this);		// todo remove
		
		mcBase.Appearance.FullOff._visible = !FullscreenOn;
		mcBase.Appearance.FullOn._visible = FullscreenOn;
		mcBase.Appearance.StatIconsOff._visible = !StatIcons;
		mcBase.Appearance.StatIconsOn._visible = StatIcons;
		mcBase.Appearance.StatImagesOff._visible = !StatImagesOn;
		mcBase.Appearance.StatImagesOn._visible = StatImagesOn;
		mcBase.Appearance.MetricOff._visible = !MetricOn;
		mcBase.Appearance.MetricOn._visible = MetricOn;
		mcBase.Appearance.Clock24Off._visible = !Clock24On;
		mcBase.Appearance.Clock24On._visible = Clock24On;
		mcBase.Appearance.TutorialOff._visible = !TutorialOn;
		mcBase.Appearance.TutorialOn._visible = TutorialOn;
		mcBase.Appearance.SoundsOff._visible = !bSoundsOn;
		mcBase.Appearance.SoundsOn._visible = bSoundsOn;
		mcBase.Appearance.LanguageInput.text = Language.LangType;
	
		mcBase.Content.DickgirlLesbiansOff._visible = !DickgirlLesbians;
		mcBase.Content.DickgirlLesbiansOn._visible = DickgirlLesbians;
		mcBase.Content.DickgirlTesticlesOff._visible = !DickgirlTesticles;
		mcBase.Content.DickgirlTesticlesOn._visible = DickgirlTesticles;
		mcBase.Content.PregnancyOffBtn._visible = !PregnancyOn;
		mcBase.Content.PregnancyOnBtn._visible = PregnancyOn;
		mcBase.Content.DickgirlStartOff._visible = !DickgirlStartOn;
		mcBase.Content.DickgirlStartOn._visible = DickgirlStartOn;
		mcBase.Content.FurriesOffBtn._visible = !FurriesOn;
		mcBase.Content.FurriesOnBtn._visible = FurriesOn;
		mcBase.Content.NonHumanOffBtn._visible = !NonHumansOn;
		mcBase.Content.NonHumanOnBtn._visible = NonHumansOn;
		mcBase.Content.CatgirlsRare._visible = !coreGame.bCatgirlsCommon;
		mcBase.Content.CatgirlsCommon._visible = coreGame.bCatgirlsCommon;
	
		mcBase.Gameplay.SandboxOff._visible = !SandboxOn;
		mcBase.Gameplay.SandboxOn._visible = SandboxOn;
		mcBase.Gameplay.LimitSavesOff._visible = !bLimitSavesOn;
		mcBase.Gameplay.LimitSavesOn._visible = bLimitSavesOn;
		
		if ( DickgirlOn == 1) {
			coreGame.SlaveMakerCreate1.DickgirlIcon._visible = true;
			coreGame.SlaveMakerCreate1.GenderDickgirl.Btn._visible = true;
			coreGame.SlaveMakerCreate1.DickgirlIcon._visible = true;
			mcBase.Content.DickgirlOff._visible = false;
			mcBase.Content.DickgirlOn._visible = true;
			coreGame.SlaveMakerCreate1.DickgirlsText.text = Language.GetHtml("DickgirlsOn", "Options");
			coreGame.VisitFortuneTeller.DickgirlsText.text = coreGame.SlaveMakerCreate1.DickgirlsText.text;
		} else {
			coreGame.SlaveMakerCreate1.DickgirlIcon._visible = false;
			coreGame.SlaveMakerCreate1.GenderDickgirl.Btn._visible = false;
			coreGame.SlaveMakerCreate1.DickgirlIcon._visible = false;
			mcBase.Content.DickgirlOn._visible = false;
			mcBase.Content.DickgirlOff._visible = true;
			coreGame.SlaveMakerCreate1.DickgirlsText.text = Language.GetHtml("DickgirlsOff", "Options");
			coreGame.VisitFortuneTeller.DickgirlsText.text = coreGame.SlaveMakerCreate1.DickgirlsText.text;
			AllDickgirlXFOn = false;
		}
		mcBase.Content.AllDickgirlXFOff._visible = !AllDickgirlXFOn;
		mcBase.Content.AllDickgirlXFOn._visible = AllDickgirlXFOn;
		mcBase.Content.BDSMOff._visible = !BDSMOn;
		mcBase.Content.BDSMOn._visible = BDSMOn;
		if (PonygirlsOn) {
			mcBase.Content.PonygirlOff._visible = false;
			mcBase.Content.PonygirlOn._visible = true;
			coreGame.SlaveMakerCreate1.PonygirlsText.text = Language.GetHtml("PonygirlsOn", "Options");
			coreGame.VisitFortuneTeller.PonygirlsText.text = coreGame.SlaveMakerCreate1.PonygirlsText.text;
		} else {
			mcBase.Content.PonygirlOn._visible = false;
			mcBase.Content.PonygirlOff._visible = true;
			coreGame.SlaveMakerCreate1.PonygirlsText.text = Language.GetHtml("PonygirlsOff", "Options");
			coreGame.VisitFortuneTeller.PonygirlsText.text = coreGame.SlaveMakerCreate1.PonygirlsText.text;
		}
		switch(Difficulty) {
			case -1:
				mcBase.Gameplay.DifficultyHardOn._visible = false;
				mcBase.Gameplay.DifficultyHardOff._visible = true;
				mcBase.Gameplay.DifficultyDifficultOn._visible = false;
				mcBase.Gameplay.DifficultyDifficultOff._visible = true;
				mcBase.Gameplay.DifficultyNormalOn._visible = false;
				mcBase.Gameplay.DifficultyNormalOff._visible = true;
				mcBase.Gameplay.DifficultyEasyOn._visible = true;
				mcBase.Gameplay.DifficultyEasyOff._visible = false;
				coreGame.SlaveMakerCreate1.DifficultyText.text = Language.GetHtml("DifficultyEasy", "Options");
				coreGame.VisitFortuneTeller.DifficultyText.text = coreGame.SlaveMakerCreate1.DifficultyText.text;
				TentaclesOn = 0;
				break;
			case 0:
				mcBase.Gameplay.DifficultyHardOn._visible = false;
				mcBase.Gameplay.DifficultyDifficultOn._visible = false;
				mcBase.Gameplay.DifficultyHardOff._visible = true;
				mcBase.Gameplay.DifficultyDifficultOff._visible = true;
				mcBase.Gameplay.DifficultyNormalOn._visible = true;
				mcBase.Gameplay.DifficultyNormalOff._visible = false;
				mcBase.Gameplay.DifficultyEasyOn._visible = false;
				mcBase.Gameplay.DifficultyEasyOff._visible = true;
				coreGame.SlaveMakerCreate1.DifficultyText.text = Language.GetHtml("DifficultyNormal", "Options");
				coreGame.VisitFortuneTeller.DifficultyText.text = coreGame.SlaveMakerCreate1.DifficultyText.text;
				break;
			case 1:
				mcBase.Gameplay.DifficultyHardOn._visible = false;
				mcBase.Gameplay.DifficultyHardOff._visible = true;
				mcBase.Gameplay.DifficultyDifficultOn._visible = true;
				mcBase.Gameplay.DifficultyDifficultOff._visible = false;
				mcBase.Gameplay.DifficultyNormalOn._visible = false;
				mcBase.Gameplay.DifficultyNormalOff._visible = true;
				mcBase.Gameplay.DifficultyEasyOn._visible = false;
				mcBase.Gameplay.DifficultyEasyOff._visible = true;
				coreGame.SlaveMakerCreate1.DifficultyText.text = Language.GetHtml("DifficultyDifficult", "Options");
				coreGame.VisitFortuneTeller.DifficultyText.text = coreGame.SlaveMakerCreate1.DifficultyText.text;
				break;
			case 2:
				mcBase.Gameplay.DifficultyHardOn._visible = true;
				mcBase.Gameplay.DifficultyDifficultOn._visible = false;
				mcBase.Gameplay.DifficultyHardOff._visible = false;
				mcBase.Gameplay.DifficultyDifficultOff._visible = true;
				mcBase.Gameplay.DifficultyNormalOn._visible = false;
				mcBase.Gameplay.DifficultyNormalOff._visible = true;
				mcBase.Gameplay.DifficultyEasyOn._visible = false;
				mcBase.Gameplay.DifficultyEasyOff._visible = true;
				coreGame.SlaveMakerCreate1.DifficultyText.text = Language.GetHtml("DifficultyHard", "Options");
				coreGame.VisitFortuneTeller.DifficultyText.text = coreGame.SlaveMakerCreate1.DifficultyText.text;
				break;
		}
		switch(CombatDifficulty) {
			case -1:
				mcBase.Gameplay.CombatLoseOn._visible = false;
				mcBase.Gameplay.CombatLoseOff._visible = true;
				mcBase.Gameplay.CombatDifficultOn._visible = false;
				mcBase.Gameplay.CombatDifficultOff._visible = true;
				mcBase.Gameplay.CombatStandardOn._visible = false;
				mcBase.Gameplay.CombatStandardOff._visible = true;
				mcBase.Gameplay.CombatOffOn._visible = true;
				mcBase.Gameplay.CombatOffOff._visible = false;
				break;
			case 0:
				mcBase.Gameplay.CombatLoseOn._visible = false;
				mcBase.Gameplay.CombatLoseOff._visible = true;
				mcBase.Gameplay.CombatDifficultOn._visible = false;
				mcBase.Gameplay.CombatDifficultOff._visible = true;
				mcBase.Gameplay.CombatStandardOn._visible = true;
				mcBase.Gameplay.CombatStandardOff._visible = false;
				mcBase.Gameplay.CombatOffOn._visible = false;
				mcBase.Gameplay.CombatOffOff._visible = true;
				break;
			case 1:
				mcBase.Gameplay.CombatLoseOn._visible = false;
				mcBase.Gameplay.CombatLoseOff._visible = true;
				mcBase.Gameplay.CombatDifficultOn._visible = true;
				mcBase.Gameplay.CombatDifficultOff._visible = false;
				mcBase.Gameplay.CombatStandardOn._visible = false;
				mcBase.Gameplay.CombatStandardOff._visible = true;
				mcBase.Gameplay.CombatOffOn._visible = false;
				mcBase.Gameplay.CombatOffOff._visible = true;
				break;
			case 2:
				mcBase.Gameplay.CombatLoseOn._visible = true;
				mcBase.Gameplay.CombatLoseOff._visible = false;
				mcBase.Gameplay.CombatDifficultOn._visible = false;
				mcBase.Gameplay.CombatDifficultOff._visible = true;
				mcBase.Gameplay.CombatStandardOn._visible = false;
				mcBase.Gameplay.CombatStandardOff._visible = true;
				mcBase.Gameplay.CombatOffOn._visible = false;
				mcBase.Gameplay.CombatOffOff._visible = true;
				break;
		}
		if (TentaclesOn == 1) {
			mcBase.Content.TentaclesOff._visible = false;
			mcBase.Content.TentaclesOn._visible = true;
			coreGame.SlaveMakerCreate1.TentaclesText.text = Language.GetHtml("TentaclesOn", "Options");
			coreGame.VisitFortuneTeller.TentaclesText.text = coreGame.SlaveMakerCreate1.TentaclesText.text;
		} else {
			mcBase.Content.TentaclesOn._visible = false;
			mcBase.Content.TentaclesOff._visible = true;
			coreGame.SlaveMakerCreate1.TentaclesText.text = Language.GetHtml("TentaclesOff", "Options");
			coreGame.VisitFortuneTeller.TentaclesText.text = coreGame.SlaveMakerCreate1.TentaclesText.text;
		}
		if (GlobalTentacleFrequency < 16) {
			mcBase.Content.TentacleUncommonOn._visible = false;
			mcBase.Content.TentacleUncommonOff._visible = true;
			mcBase.Content.TentacleOftenOn._visible = false;
			mcBase.Content.TentacleOftenOff._visible = true;
			mcBase.Content.TentacleRareOn._visible = true;
			mcBase.Content.TentacleRareOff._visible = false;
		} else if (GlobalTentacleFrequency < 34) {
			mcBase.Content.TentacleUncommonOn._visible = true;
			mcBase.Content.TentacleUncommonOff._visible = false;
			mcBase.Content.TentacleOftenOn._visible = false;
			mcBase.Content.TentacleOftenOff._visible = true;
			mcBase.Content.TentacleRareOn._visible = false;
			mcBase.Content.TentacleRareOff._visible = true;
		} else {
			mcBase.Content.TentacleUncommonOn._visible = false;
			mcBase.Content.TentacleUncommonOff._visible = true;
			mcBase.Content.TentacleOftenOn._visible = true;
			mcBase.Content.TentacleOftenOff._visible = false;
			mcBase.Content.TentacleRareOn._visible = false;
			mcBase.Content.TentacleRareOff._visible = true;
		}
		mcBase.Content.RapeOff._visible = !RapeOn;
		mcBase.Content.RapeOn._visible = RapeOn;
		if (BadEndsOn) {
			mcBase.Content.BadEndsOff._visible = false;
			mcBase.Content.BadEndsOn._visible = true;
			coreGame.SlaveMakerCreate1.Content.BadEndsText.text = Language.GetHtml("BadEndsOn", "Options");
			coreGame.VisitFortuneTeller.Content.BadEndsText.text = coreGame.SlaveMakerCreate1.Content.BadEndsText.text;
		} else {
			mcBase.Content.BadEndsOff._visible = true;
			mcBase.Content.BadEndsOn._visible = false;
			coreGame.SlaveMakerCreate1.Content.BadEndsText.text = Language.GetHtml("BadEndsOff", "Options");
			coreGame.VisitFortuneTeller.Content.BadEndsText.text = coreGame.SlaveMakerCreate1.Content.BadEndsText.text;
		}
		mcBase.Content.IncestOff._visible = !IncestOn;
		mcBase.Content.IncestOn._visible = IncestOn;
		if (GlobalDickgirlFrequency == 0) {
			mcBase.Content.DickgirlCommonOn._visible = false;
			mcBase.Content.DickgirlCommonOff._visible = true;
			mcBase.Content.DickgirlAlwaysOn._visible = false;
			mcBase.Content.DickgirlAlwaysOff._visible = true;
			mcBase.Content.DickgirlRareOn._visible = true;
			mcBase.Content.DickgirlRareOff._visible = false;
		} else if (GlobalDickgirlFrequency == 1) {
			mcBase.Content.DickgirlCommonOn._visible = true;
			mcBase.Content.DickgirlCommonOff._visible = false;
			mcBase.Content.DickgirlAlwaysOn._visible = false;
			mcBase.Content.DickgirlAlwaysOff._visible = true;
			mcBase.Content.DickgirlRareOn._visible = false;
			mcBase.Content.DickgirlRareOff._visible = true;
		} else {
			mcBase.Content.DickgirlCommonOn._visible = false;
			mcBase.Content.DickgirlCommonOff._visible = true;
			mcBase.Content.DickgirlAlwaysOn._visible = true;
			mcBase.Content.DickgirlAlwaysOff._visible = false;
			mcBase.Content.DickgirlRareOn._visible = false;
			mcBase.Content.DickgirlRareOff._visible = true;
		}
	}
	
	public function SaveGlobalData()
	{
		SaveOnlyGlobalData();
		UpdateFromGlobalData(true);
	}
	
	public function SaveOnlyGlobalData()
	{		
		var smglobal:SharedObject = coreGame.GetSaveData("smglobal");
		smglobal.data.SoundsOn = bSoundsOn ? 1 : 0;
		smglobal.data.DickgirlOn = DickgirlOn;
		smglobal.data.bCatgirlsCommon = coreGame.bCatgirlsCommon;
		smglobal.data.TentaclesOn = TentaclesOn;
		smglobal.data.GlobalTentacleFrequency = GlobalTentacleFrequency;
		smglobal.data.GlobalDickgirlFrequency = GlobalDickgirlFrequency;
		var vPony:Number = PonygirlsOn ? 1 : 0;
		smglobal.data.PonygirlsOn = vPony;
		smglobal.data.Difficulty = Difficulty;
		smglobal.data.CombatDifficulty = CombatDifficulty;
		smglobal.data.BDSMOn = BDSMOn ? 1 : 0;
		smglobal.data.AllDickgirlXFOn = AllDickgirlXFOn ? 1 : 0;
		smglobal.data.RapeOn = RapeOn ? 1 : 0;
		smglobal.data.BadEndsOn = BadEndsOn ? 1 : 0;
		smglobal.data.IncestOn = IncestOn ? 1 : 0;
		smglobal.data.TutorialOn = TutorialOn;
		smglobal.data.FurriesOn = FurriesOn;
		smglobal.data.NonHumansOn = NonHumansOn;
		smglobal.data.SandboxOn = SandboxOn;
		smglobal.data.Clock24On = Clock24On;
		smglobal.data.DickgirlLesbians = DickgirlLesbians;
		smglobal.data.StatIcons = StatIcons;
		smglobal.data.FullscreenOn = FullscreenOn;
		//smglobal.data.LastUpdateCheck = LastUpdateCheck;
		smglobal.data.Language = Language.LangType;
		smglobal.data.DickgirlTesticles = DickgirlTesticles;
		smglobal.data.PregnancyOn = PregnancyOn;
		smglobal.data.DickgirlStartOn = DickgirlStartOn;
		smglobal.data.StatImagesOn = StatImagesOn;
		smglobal.data.MetricOn = MetricOn;
		smglobal.data.LimitSavesOn = bLimitSavesOn;
		smglobal.data.bShowVanillaOn = bShowVanillaOn;
		smglobal.data.nQuickSlot = coreGame.LoadSave.nQuickSlot;
		smglobal.data.nLoadSaveSet = coreGame.LoadSave.nLoadSaveSet;
		
		smglobal.flush(1024);
	}
	
	public function LoadGlobalData()
	{
		var smglobali:SharedObject = coreGame.GetSaveData("smglobal");
		if (smglobali.data.FullscreenOn != undefined) FullscreenOn = smglobali.data.FullscreenOn;
		if (smglobali.data.StatIcons != undefined) StatIcons = smglobali.data.StatIcons;
		if (smglobali.data.DickgirlLesbians != undefined) DickgirlLesbians = smglobali.data.DickgirlLesbians;
		if (smglobali.data.Clock24On != undefined) Clock24On = smglobali.data.Clock24On;
		if (smglobali.data.SandboxOn != undefined) SandboxOn = smglobali.data.SandboxOn;
		if (smglobali.data.BadEndsOn != undefined) BadEndsOn = (smglobali.data.BadEndsOn == 1);
		if (smglobali.data.IncestOn != undefined) IncestOn = (smglobali.data.IncestOn == 1);
		if (smglobali.data.RapeOn != undefined) RapeOn = (smglobali.data.RapeOn == 1);
		if (smglobali.data.BDSMOn != undefined) BDSMOn = (smglobali.data.BDSMOn == 1);
		if (smglobali.data.AllDickgirlXFOn != undefined) AllDickgirlXFOn = (smglobali.data.AllDickgirlXFOn == 1);	
		if (smglobali.data.SoundsOn != undefined) bSoundsOn = (smglobali.data.SoundsOn == 1);
		if (smglobali.data.DickgirlOn != undefined) DickgirlOn = smglobali.data.DickgirlOn;
		if (smglobali.data.TentaclesOn != undefined) TentaclesOn = smglobali.data.TentaclesOn;
		if (smglobali.data.GlobalTentacleFrequency != undefined) GlobalTentacleFrequency = smglobali.data.GlobalTentacleFrequency;
		if (smglobali.data.PonygirlsOn != undefined) PonygirlsOn = smglobali.data.PonygirlsOn == 1;
		if (smglobali.data.Difficulty != undefined) Difficulty = smglobali.data.Difficulty;
		if (smglobali.data.CombatDifficulty != undefined) CombatDifficulty = smglobali.data.CombatDifficulty;
		if (smglobali.data.TutorialOn != undefined) TutorialOn = smglobali.data.TutorialOn;
		if (smglobali.data.FurriesOn != undefined) FurriesOn = smglobali.data.FurriesOn;
		if (smglobali.data.NonHumansOn != undefined) NonHumansOn = smglobali.data.NonHumansOn;
		if (smglobali.data.GlobalDickgirlFrequency != undefined) GlobalDickgirlFrequency = smglobali.data.GlobalDickgirlFrequency;
		if (smglobali.data.Language != undefined) Language.LangType = smglobali.data.Language;
		else Language.LangType = "English";
		if (smglobali.data.DickgirlTesticles != undefined) DickgirlTesticles = smglobali.data.DickgirlTesticles;
		if (smglobali.data.PregnancyOn != undefined) PregnancyOn = smglobali.data.PregnancyOn;
		if (smglobali.data.DickgirlStartOn != undefined) DickgirlStartOn = smglobali.data.DickgirlStartOn;
		if (smglobali.data.StatImagesOn != undefined) StatImagesOn = smglobali.data.StatImagesOn;
		if (smglobali.data.MetricOn != undefined) MetricOn = smglobali.data.MetricOn;
		if (smglobali.data.LimitSavesOn != undefined) bLimitSavesOn = smglobali.data.LimitSavesOn;
		if (smglobali.data.bShowVanillaOn != undefined) bShowVanillaOn = smglobali.data.bShowVanillaOn;
		if (smglobali.data.nQuickSlot != undefined) coreGame.LoadSave.nQuickSlot = smglobali.data.nQuickSlot;
		if (smglobali.data.bCatgirlsCommon != undefined) coreGame.bCatgirlsCommon = smglobali.data.bCatgirlsCommon;
		if (smglobali.data.nLoadSaveSet != undefined) coreGame.LoadSave.nLoadSaveSet = smglobali.data.nLoadSaveSet;
		
		/*
		var sDate:Date = new Date();
		if (smglobali.data.LastUpdateCheck != undefined) LastUpdateCheck = smglobali.data.LastUpdateCheck;
		else LastUpdateCheck = sDate.valueOf() - 800000000; 
	
		if ((sDate.valueOf() - LastUpdateCheck) > 604800000) {
			LastUpdateCheck = sDate.valueOf();
			ucheck.load("http://slavemaker.futanaripalace.com/version.txt");
			if (FullscreenOn) fscommand("fullscreen", true);
		} else delete ucheck;
		delete sDate;
		*/
	}
	
	/*
	var ucheck:LoadVars = new LoadVars();
	ucheck.onLoad = function(success:Boolean) {
		if (FullscreenOn) fscommand("fullscreen", true);
		if (success) {
			if (ucheck.Version != coreGame.GameVersion) {
				if ((ucheck.Version - Math.floor(ucheck.Version)) == 0) IntroTitle.NewVersion.text = "v3." + Math.floor(ucheck.Version) + ".0";
				else IntroTitle.NewVersion.text = "v3." + ucheck.Version;
			}
		}
		SaveGlobalData();
		delete ucheck;
	}
	*/
	
	private function Copy(sdFrom:Object, sdTo:Object)
	{
		sdTo.TentaclesOn = sdFrom.TentaclesOn;
		sdTo.Difficulty = sdFrom.Difficulty;
		sdTo.CombatDifficulty = sdFrom.CombatDifficulty;
		sdTo.BDSMOn = sdFrom.BDSMOn;
		sdTo.RapeOn = sdFrom.RapeOn;
		sdTo.BadEndsOn = sdFrom.BadEndsOn;
		sdTo.IncestOn = sdFrom.IncestOn;
		sdTo.FurriesOn = sdFrom.FurriesOn;
		sdTo.NonHumansOn = sdFrom.NonHumansOn;
		sdTo.bSoundsOn = sdFrom.bSoundsOn;
		sdTo.PregnancyOn = sdFrom.PregnancyOn;
		sdTo.DickgirlOn = sdFrom.DickgirlOn;
		sdTo.AllDickgirlXFOn = sdFrom.AllDickgirlXFOn;
		sdTo.DickgirlTesticles = sdFrom.DickgirlTesticles;
		sdTo.DickgirlLesbians = sdFrom.DickgirlLesbians;
		sdTo.PonygirlsOn = sdFrom.PonygirlsOn;
	}
	
	
	// Update theme of fields
	
	public function UpdateText(str:String, aNode:XMLNode)
	{	
		Language.ApplyLang(mcBase.TitleText, "Title", true);
		Language.ApplyLang(mcBase.GameplayTab.LText, "Gameplay", true, -2);
		Language.ApplyLang(mcBase.AppearanceTab.LText, "Appearance", true, -2);
		Language.ApplyLang(mcBase.ContentTab.LText, "Content", true, -2);
		Language.ApplyLang(mcBase.Appearance.LTutorial, "Tutorial", true, -1);
		Language.ApplyLang(mcBase.Appearance.LZoom, "Zoom", true, -1);
		Language.ApplyLang(mcBase.Appearance.LColours, "Colours", true, -1);
		Language.ApplyLang(mcBase.Appearance.LIcons, "StatisticChangeIcons", true, -1);
		Language.ApplyLang(mcBase.Appearance.LStatImages, "StatImages", true, -1);
		Language.ApplyLang(mcBase.Appearance.LLanguage, "Language", true, -1);
		Language.ApplyLang(mcBase.Appearance.LClock, "Clock", true, -1);
		Language.ApplyLang(mcBase.Appearance.LSoundEffects, "SoundEffects", true, -1);
		Language.ApplyLang(mcBase.Appearance.LFullScreen, "StartFullScreen", true, -1);
		Language.ApplyLang(mcBase.Appearance.LMetric, "Metric", true, -1);
		
		Language.ApplyLang(mcBase.Gameplay.LSandbox, "SandboxMode", true, -1);
		Language.ApplyLang(mcBase.Gameplay.LLimitSaves, "LimitSaves", true, -1);
		Language.ApplyLang(mcBase.Gameplay.LDifficulty, "Difficulty", true, -1);
		Language.ApplyLang(mcBase.Gameplay.LEasy, "Easy", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LNormal1, "Normal", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LDifficult1, "Difficult", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LHard, "Hard", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LCombat, "Combat", true, -1);
		Language.ApplyLang(mcBase.Gameplay.LOff, "Off", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LNormal2, "Normal", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LDifficult2, "Difficult", false, -1);
		Language.ApplyLang(mcBase.Gameplay.LYouLose, "YouLose", false, -1);
		
		Language.ApplyLang(mcBase.Content.LFurries, "Furries", true, -1);
		Language.ApplyLang(mcBase.Content.LNonHuman, "NonHuman", true, -1);
		Language.ApplyLang(mcBase.Content.LPregnancy, "Pregnancy", true, -1);
		Language.ApplyLang(mcBase.Content.LTentacles, "Tentacles", true, -1);
		Language.ApplyLang(mcBase.Content.LDickgirls, "Dickgirls", true, -1);
		Language.ApplyLang(mcBase.Content.LBDSM, "BDSM", true, -1);
		Language.ApplyLang(mcBase.Content.LRape, "Rape", true, -1);
		Language.ApplyLang(mcBase.Content.LBadEnds, "BadEnds", true, -1);
		Language.ApplyLang(mcBase.Content.LIncest, "Incest", true, -1);
		Language.ApplyLang(mcBase.Content.LPonygirl, "PonygirlTraining", false, -1);
		Language.ApplyLang(mcBase.Content.LLesbianDickgirls, "LesbiansDickgirls", false, -1);
		Language.ApplyLang(mcBase.Content.LAllTransform, "AllTransform", false, -1);
		Language.ApplyLang(mcBase.Content.LTentacleRare, "TentacleRare", false, -1);
		Language.ApplyLang(mcBase.Content.LTentacleUncommon, "TentacleUncommon", false, -1);
		Language.ApplyLang(mcBase.Content.LTentacleOften, "TentacleOften", false, -1);
		Language.ApplyLang(mcBase.Content.LDickgirlRare, "DickgirlRare", false, -1);
		Language.ApplyLang(mcBase.Content.LDickgirlCommon, "DickgirlCommon", false, -1);
		Language.ApplyLang(mcBase.Content.LDickgirlAlways, "DickgirlAlways", false, -1);
		Language.ApplyLang(mcBase.Content.LDickgirlsTesticles, "DickgirlTesticles", false, -1);
		Language.ApplyLang(mcBase.Content.LDickgirlStart, "DickgirlStart", false, -1);
		Language.ApplyLang(mcBase.Content.LCatgirlsFrequency, "CatgirlsCommon", true, -1);
	}
	
	private function UsedDuringGame() : Boolean { return false; }
	private function UseCurrentDialog() : Boolean { return false; }

}