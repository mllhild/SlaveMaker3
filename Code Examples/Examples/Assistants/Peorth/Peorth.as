import Scripts.Classes.*;

class Peorth extends SlaveModule
{
	public static function main(swfRoot:MovieClip, sd:Object, cgm:Object) : SlaveModule 
	{
		// entry point
		return new Peorth(swfRoot, sd, cgm);
	}
	
	public function Peorth(swfRoot:MovieClip, sd:Object, cgm:Object)
	{
		super(swfRoot, sd, cgm);
		
		// stop and hide any graphics on initial load
		mcBase.stop();
		mcBase.Assistant._visible = false;
		mcBase.Assistant.gotoAndStop(1);
		mcBase.AnalClip.gotoAndStop(1);
		mcBase.SexClip.gotoAndStop(1);
		mcBase.TalkClip.gotoAndStop(1);
		mcBase.PregnantClip.gotoAndStop(1);
		mcBase.BlowjobClip.gotoAndStop(1);
		mcBase.LickClip.gotoAndStop(1);
		mcBase.KissClip.gotoAndStop(1);
		mcBase.TitsFuckClip.gotoAndStop(1);	
		
		// Hide
		mcBase.Introduction._visible = false;
		
		// assign references
		Assistant = mcBase.Assistant;
	}
	
	// InitialiseAsAssistant - sets up the assistant
	public function InitialiseAsAssistant(firstload:Boolean) : MovieClip 
	{
		if (slaveData.IsDickgirl()) Assistant.gotoAndStop(6);
		else Assistant.gotoAndStop(1);
		return Assistant;
	}
	
	// ShowAssistant - shows a graphic for the assistant
	// 1 = normal view in small rectangle
	// 2 = tentacle sex (small version shown when slave girl raped)
	// 3 = raped
	// 4 = ignore this (shown when assistant is absent)
	// 5 = wet - she falls in some water
	// 6 = large graphic shown when your slave runs away	
	public function ShowAsAssistant(type:Number) : Boolean
	{
		if (type == 4) return false;
		if (type == 1) {
			if (slaveData.IsDickgirl()) ShowMovie(Assistant, 0, 0, 6);
			else ShowMovie(Assistant, 0, 0, 1);
		} else if (type == 2) ShowMovie(Assistant, 0, 0, 2);
		else if (type == 3) ShowMovie(Assistant, 0, 0, 3);
		else if (type == 5) ShowMovie(Assistant, 0, 0, 4);
		else if (type == 6) ShowMovie(Assistant, 1, 2, 5);
		return true;
	}
	
	// ShowAsAssistantTentacleSex - show large graphic when the assistant is tentacle raped
	// Notes
	//  (Times in milliseconds)
	//  StartFuckIt - starts a fucking like motion, first param = movie clip, second = lock x position
	//  also available
	//  StartFadeImage(duration:Number, target_mc:MovieClip) - fade an image over a period of time
	//  StartChangeImage(duration:Number, target_mc:MovieClip, newpos:Number, say:String, hide_mc:MovieClip, show_mc:MovieClip)
	//		change and image after a period of time and optionally display text, all params after newpos optional. Can hide and show other Movie Clips too
	//  StartShakeIt(target_mc:MovieClip, inittime:Number, comment:String) - shake an image afer a time, optionally display some text
	// or just show the graphic
	// These events are automatically stopped when Next is hit
	public function ShowAsAssistantTentacleSex() : Boolean
	{
		ShowMovie(Assistant, 1, 0, 2);
		coreGame.StartFuckIt(Assistant, true);
		return true;
	}
	
	public function ShowAsAssistantAnal() : Boolean
	{
		ShowMovie(mcBase.Assistant.AnalClip, 1, 1, slrandom(2));
		return true;
	}
	
	public function ShowAsAssistantSpanking() : Boolean 
	{
		ShowMovie(mcBase.Assistant.SpankClip, 1, 1, 1);
		return true;
	}
	public function ShowSexActSpank(whip:Boolean) { ShowAsAssistantSpanking(whip); }
	
	public function ShowSexActKiss() : Boolean 
	{
		if (SMData.Gender == 1) return false;
		temp = slrandom(2);
		ShowMovie(mcBase.KissClip, 1, 1, temp);
		if (temp == 2) Backgrounds.ShowBath();
		else HideBackgrounds();
		return true;
	}
	
	public function ShowSexActBlowjob()
	{
		ShowMovie(mcBase.BlowjobClip, 1, 1, 1);
	}
	
	public function ShowSexActLick() 
	{
		ShowMovie(mcBase.BlowjobClip, 1, 1, Lesbian ? 2 : 1);
	}
		
	public function ShowSlaveIntimacy() : Boolean
	{
		if (SMData.Gender == 2) {
			HideBackgrounds();
			ShowMovie(mcBase.SexClip, 1, 3, 4);
		} else {
			temp = slrandom(4);
			if (temp > 3) ShowMovie(mcBase.AnalClip, 1, 1, slrandom(2));
			else ShowMovie(mcBase.SexClip, 1, 1, temp);
		}
		return true;
	}
	
	public function ShowSlaveReview() : Boolean
	{
		if (slaveData.IsDickgirl()) ShowMovie(Assistant, 1, 2, 6);
		else ShowMovie(Assistant, 1, 2, 1);
		Backgrounds.ShowOverlay(0x2c3033);
		return true;
	}
	
	public function ShowSlaveTalk() : Boolean
	{
		HideBackgrounds();
		ShowMovie(mcBase.TalkClip, 1, 2, slrandom(2));
		return true;
	}
	
	public function ShowPregnancyReveal() : Boolean
	{
		Backgrounds.ShowBeach();
		ShowMovie(mcBase.PregnantClip, 1, 1, 1);
		return true;
	}

	
	public function ShowLingerieAsAssistant() : Boolean
	{
		if (PercentChance(10)) {
			AutoAttachAndShowMovie("Items", 1, 1, 1);
			AddText("#assistant declares that she will model some lingerie for you.\r\r");
			return true;
		}
		return false;
	}
	
	public function ShowSwimsuitAsAssistant() : Boolean
	{
		if (PercentChance(10)) {
			AddText("#assistant tries on a swimsuit as well as #slave.\r\r");
			AutoAttachAndShowMovie("Items", 1, 1, 3);
			return true;
		}
		return false;
	}
	
	public function ShowMaidUniformAsAssistant() : Boolean
	{
		if (PercentChance(10)) {
			AddText("#assistant also tries on a very, very revealing uniform.\r\r");
			AutoAttachAndShowMovie("Items", 1, 1, 2);
		}
		return false;
	}

	
	// HideAsAssistant - hide the assistant graphics
	public function HideAsAssistant()
	{
		super.HideAsAssistant();
		
		Assistant._visible = false;
		mcBase.SpankClip._visible = false;
		mcBase.AnalClip._visible = false;
		mcBase.SexClip._visible = false;
		mcBase.TalkClip._visible = false;
		mcBase.PregnantClip._visible = false;
		mcBase.BlowjobClip._visible = false;
		mcBase.LickClip._visible = false;
		mcBase.KissClip._visible = false;
		mcBase.TitsFuckClip._visible = false;
	}	
	
	public function ApplyDifficultyAsAssistant(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, SexualEnergy:Number, Sexuality:Number)
	{
		_root.MoralityFactor *= 1.2;
		_root.NymphomaniaFactor *= 1.2;
	}
	
	public function UpdateDateAndItemsAsAssistant(nDays:Number)
	{
		if (slaveData.HaloWorn == 1) {
			if (SMData.SMFaith == 2) slaveData.VarLibido += nDays / 2;
			slaveData.VarMorality += nDays / 2;
		}
		if (slaveData.AngelsTearWorn == 1) {
			if (SMData.SMFaith == 2) slaveData.VarConstitution += nDays / 2;
			else slaveData.VarSensibility += nDays / 2;
		}
	}
	
	public function StartNightAsAssistant(intro:Boolean) : Boolean 
	{
		if (intro) {
			ServantSpeakStart("Good evening #slavemakername! It is now time for us enhance #slave's passion and #slavehisher desire to obey.");
			return true;
		}
		return false;
	}
	
	public function StartEveningAsAssistant() : Boolean 
	{
		ServantSpeak("#slavemakername, good evening. We have finished educating #slave for the daytime and it is now time to consider the ways of love and passion.");
		return true;
	}
	
	public function AfterNewPlanningActionAsAssistant(type:Number, available:Boolean)
	{
		// prevent supervision of brothel
		if (type == 1016) coreGame.CurrentSuperviseYourself = true;
	}
	
	public function IntroductionAsAssistant() : Boolean
	{
		AutoAttachAndShowMovie("Introduction (Movie)", 4, 3, 1);
		// return false to allow xml to show text
		return false;
	}
}
