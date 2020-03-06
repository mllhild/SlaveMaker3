// DisplayIcons - Icon Bar icons
//
// Translation status: COMPLETE

import flash.geom.ColorTransform;
import flash.geom.Transform;
import Scripts.Classes.*;

class DisplayIcons extends DisplayBase {
	
	// dickgirl - legacy to be removed
	public var DickgirlXFIcon:MovieClip;


	// Constructor
	public function DisplayIcons(cg:Object)
	{ 
		super(cg.mcMain.mcIcons, cg);
		
		mcBase.tabChildren = true;
		
		// specific icons
		DickgirlXFIcon = mcBase.DickgirlXFIcon;
		
		// Moon
		//mcBase.MoonOverlay._visible = false;
		mcBase.MoonPhase.gotoAndStop(1);
		
		// common initialise
		Reset();
			}
	
	// Show the IconBar
	public function Show() { mcBase._visible = true; }
	

	// Update
	
	public function UpdateIcons(sdo:Object)
	{
		slaveData = sdo;
		sd = sdo;
		
		mcBase.LesbianIcon._visible = sd.BitFlag1.CheckBitFlag(10) || sd.Sexuality < 25;
		mcBase.LesbianHint._visible = mcBase.LesbianIcon._visible;
		mcBase.LesbianIcon.gotoAndStop(sd.IsMale() ? 2 : 1);
		
		mcBase.WeddingBells._visible = sd.IsMarried();
		
		// inlined SetPlugIcon(sd);
		if (sd.PlugInserted > 0)	{
			if (sd.PonyTailWorn == 1) mcBase.PlugIcon.gotoAndStop(2); 
			else if (sd.CatTailWorn == 1) mcBase.PlugIcon.gotoAndStop(3);
			else if (sd.ItemsWorn.CheckBitFlag(30)) mcBase.PlugIcon.gotoAndStop(4);
			else mcBase.PlugIcon.gotoAndStop(1);
			mcBase.PlugIcon._visible = true;
		} else mcBase.PlugIcon._visible = false;
		
		mcBase.Birthday._visible = (coreGame.GetDayOfYear(coreGame.GameDate) == coreGame.GetDayOfYear(sd.Birthday))
		mcBase.BirthdayHint._visible = mcBase.Birthday._visible;
		
		SetLoveIcon(sd);
	}
	
	
	// Moon
	
	public function SetMoonIcon(phase:Number) { mcBase.MoonPhase.gotoAndStop(phase * 2); }

	
	// Dickgirl
	
	public function ShowDickgirlIcon(sd:Object)
	{
		mcBase.DickgirlXFIcon._visible = sd.IsDickgirl();
		if (sd.SlaveGender == 3 || sd.SlaveGender == 6 || sd.DickgirlXF == 2 || sd.DickgirlXF == 3 || sd.DickgirlXF == 4) {
			//SetMovieColour(mcBase.DickgirlXFIcon, 32, 32, 0);
		}
	}
	public function ShowDickgirlIconNow() { mcBase.DickgirlXFIcon._visible = true; }
	public function HideDickgirlIcon() { mcBase.DickgirlXFIcon._visible = false; }
	
	
	// Love
	
	public function SetLoveIcon(sd:Object)
	{
		if (sd.LoveAccepted == 1 || sd.LoveAccepted == 10) {
			mcBase.LoveGauge.play();
			if (sd.Sexuality < 25 || sd.BitFlag1.CheckBitFlag(10)) SetMovieColour(mcBase.LoveGauge, 0, 0, 200);
			else SetMovieColour(mcBase.LoveGauge, 0, 0, 0);
		} else {
			var ltemp:Number = Math.floor(sd.VarLovePoints / 12);
			if (ltemp > 6) ltemp = 6;
			mcBase.LoveGauge.gotoAndStop((ltemp * 4) + 1);
			SetMovieColour(mcBase.LoveGauge, 0, 0, 0);
		}
		mcBase.LoveGauge.cacheAsBitmap = true;
	}
	
	
	// Plugs
	
	public function SetPlugIcon(sd:Object)
	{
		if (sd.PlugInserted > 0)	{
			if (sd.PonyTailWorn == 1) mcBase.PlugIcon.gotoAndStop(2); 
			else if (sd.CatTailWorn == 1) mcBase.PlugIcon.gotoAndStop(3);
			else if (sd.ItemsWorn.CheckBitFlag(30)) mcBase.PlugIcon.gotoAndStop(4);
			else mcBase.PlugIcon.gotoAndStop(1);
			mcBase.PlugIcon._visible = true;
		} else mcBase.PlugIcon._visible = false;
	}
	
	
	// Hints
	public function ShowMoonHint()
	{
		if (coreGame.MoonPhaseDate != 1 && coreGame.MoonPhaseDate != 15) {
			if (coreGame.MoonPhaseDate < 15) ShowHintLang("NewMoonIconHint", "Other");
			else ShowHintLang("FullMoonIconHint", "Other");
		}
	}
	
	public function ShowBirthdayHint()
	{
		coreGame.PersonName = sd.SlaveName;
		ShowHint(Language.GetHtml("Birthday", "Diary"));
	}
	
	public function ShowLesbianHint()
	{
		if (sd.IsMale()) ShowHintLang("IconHint", "SlaveTrainings/Lesbian");
		else ShowHintLang("IconHint", "SlaveTrainings/Gay");
	}
	
	// Miscellaneous
	
	public function Reset()
	{
		InitialiseModule(null);		// force reset of SMData, Backgrounds etc objects, do not change visibilty state of movieclips

		mcBase.LoveGauge.gotoAndStop(1);
		SetMovieColour(mcBase.LoveGauge, 0, 0, 0);
		mcBase.LoveGauge.cacheAsBitmap = true;
		
		mcBase.MoonPhase.LFull.htmlText = Language.GetHtml("Full", "Other", true);
		mcBase.MoonPhase.LNew.htmlText = Language.GetHtml("New", "Other", true);
		
		var ti:DisplayIcons = this;
		mcBase.MoonHint.onRollOver = function() { ti.ShowMoonHint(); }
		mcBase.MoonHint.onRollOut = function() { ti.HideHints(); }
		mcBase.BirthdayHint.onRollOver = function() { ti.ShowBirthdayHint(); }
		mcBase.BirthdayHint.onRollOut = function() { ti.HideHints(); }
		mcBase.LesbianHint.onRollOver = function() { ti.ShowLesbianHint(); }
		mcBase.LesbianHint.onRollOut = function() { ti.HideHints(); }
	}
	
	// Update theme of fields
	/*
	public function UpdateText(str:String, aNode:XMLNode)
	{
	}
	*/
	
	public function ApplyTheme(cvo:ColourScheme)
	{	
		// Assumes the icons are white
		var cv:Number =  cvo.nIconBarIconColour;
		var red:Number = (cv >> 16) & 255;
		var green:Number = (cv >> 8) & 255;
		var blue:Number = cv & 255;

		SetMovieColour(mcBase.LesbianIcon, red, green, blue);
		SetMovieColour(mcBase.PlugIcon, red, green, blue);
		SetMovieColour(mcBase.DickgirlXFIcon, red, green, blue);
		//SetMovieColour(mcBase.Birthday, red, green, blue);
		
		if (cv != 0) mcBase.MoonPhase.blendMode = "lighten";
		else mcBase.MoonPhase.blendMode = "subtract";
	}

}
