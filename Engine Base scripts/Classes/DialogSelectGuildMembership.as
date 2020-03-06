// DialogSelectGuildMembership - select slave makers belongs to guild
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogSelectGuildMembership extends DialogBase {
		
	// Constructor
	public function DialogSelectGuildMembership(cg:Object)
	{ 
		super(null, cg);
	}
		
	public function ViewDialog()
	{
		super.ViewDialog();

		var ti:DialogSelectGuildMembership = this;
		
		mcBase = coreGame.AutoAttachAndShowMovie("Slave Maker Guild Membership", 2, 2);
	
		Backgrounds.ShowIntroBackgroundWhite();
		
		var tempstr:String = "<b>" + Language.GetHtml("GuildMember", "Guild") + "\r\r\r\r" + Language.GetHtml("Freelancer", "Guild") + "</b>";
		mcBase.LGuildOptionsWhite.htmlText = tempstr;
		mcBase.LGuildOptionsBlack.htmlText = tempstr;
		tempstr = Language.GetHtml("GuildMemberDetails", "Guild") + "\r\r\r" + Language.GetHtml("FreelancerDetails", "Guild");
		mcBase.LDetailsWhite.htmlText = tempstr;
		mcBase.LDetailsBlack.htmlText = tempstr;
		mcBase.TitleText.htmlText = Language.GetHtml("Title", "Guild", true);
		mcBase.DetailsText.htmlText = Language.GetHtml("Details", "Guild");
		mcBase.QuestionText.htmlText = Language.GetHtml("Questions", "Guild");
	
		mcBase.Member.onPress = function() {
			ti.UpdateGuildMembership(true);
		}
		mcBase.Member.onRollOver = function() { this._alpha = 10; }
		mcBase.Member.onRollOut = function() { this._alpha = 0; }
		mcBase.Freelancer.onPress = function() {
			ti.UpdateGuildMembership(false);
		}
		mcBase.Freelancer.onRollOver = mcBase.Member.onRollOver;
		mcBase.Freelancer.onRollOut = mcBase.Member.onRollOut;
		
		
		mcBase._visible = true;
	}
	
	public function ShowDialogContents() {
		StopHints();
	}
		
	public function UpdateGuildMembership(guild:Boolean)
	{
		SMData.ChangeGuildMembership(guild);
		if (coreGame.citiesList.GetTotalAvailableCities() > 1) {
			LeaveDialog();
			coreGame.TitleScreen.DoIntroNext(6);
		} else {
			coreGame.IntroLoadButton._visible = false;
			coreGame.IntroBackButton._visible = false;
			coreGame.citiesList.ChangeCity(coreGame.citiesList.GetAvailableCity(1), false);
			Timers.ShowWait(true);
			coreGame.Language.ChangeLanguage(false, "CityLanguageUpdate", this);
		}
	}
	public function CityLanguageUpdate() { LeaveDialog(); coreGame.TitleScreen.DoIntroNext(7); }

	// Miscellaneous
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (keya == 49) { UpdateGuildMembership(true); return true; }
		else if (keya == 50) { UpdateGuildMembership(false); return true; }
		return false;
	}
	
}