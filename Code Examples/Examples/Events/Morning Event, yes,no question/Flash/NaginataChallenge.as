// Notes
// Uses event 10000
// 2 custom variables, campaign scope
//

class NaginataChallenge extends SlaveModule
{
	private var ChallengesWon:Number;
	private var ChallengesLost:Number;
	
	public static function main(swfRoot:MovieClip) : SlaveModule 
	{
		// entry point
		var sm:NaginataChallenge = new NaginataChallenge(swfRoot);
		return sm;
	}
	
	public function NaginataChallenge(mc:MovieClip)
	{
		super(mc);
		this.StartSlaveMaker();
	}

	// This event will apply for the duration of the campaign
	public function StartSlaveMaker()
	{
		this.ChallengesWon = 0;
		this.ChallengesLost = 0;
	}
	public function LoadGame(loaddata:Object)
	{
		this.ChallengesWon = loaddata.ChallengesWon;
		this.ChallengesLost = loaddata.ChallengesLost;
		if (loaddata.ChallengesWon == undefined) this.StartSlaveMaker();
	}
	public function SaveGame(savedata:Object)
	{
		savedata.ChallengesWon = this.ChallengesWon;
		savedata.ChallengesLost = this.ChallengesLost;
	}
	
	public function EventsAsAssistant() : Boolean
	{
		// Happens
		//  - no previous event
		//  - your skill 31+
		// - 10% chance each day
		// - if you never refuse
		if (_root.DoneEvent == 0 && _root.sNaginataExpertise > 30 && _root.PercentChance(10) && this.ChallengesWon != -1) {
			super.AutoAttachAndShowMovie("Event - Challenge.jpg", 1, 0, 1);
			if ((this.ChallengesWon + this.ChallengesLost) == 0) {
				_root.SetText("In the morning a young noblewoman requests an audience with you. You let her in and see she is carrying a fine naginata. She sits and speaks very firmly,\r\r");
				_root.PersonSpeak("Lady Grey", "I have heard of your skill with a naginata. It is clearly inferior to mine and I wish to demonstrate this to you. I challenge you to a duel, first blow wins. We should have a token wager, so loser pays the winner 20GP.", true);
				_root.AddText("\r\rIt would be very impolite to refuse and damaging to your reputation, but she is clearly very skilled.\r\rDo you accept?\r");
			} else {
				_root.SetText("Lady Grey arrives at your door and demands another duel.\r\rDo you accept?\r");
			}
			_root.DoYesNoEvent(10000);
			return true;
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		if (_root.NumEvent == 10000) {
			// Yes - have due1
			if (_root.SoundsOn) _root.Sounds.PlaySound("Clang");
			_root.SetText("You both go to the training ground and fight a short but fierce battle, doing your best to use the back of the blade or the haft of the naginata.\r\r");
			var herskill:Number = 75 + (this.ChallengesWon * 5);
			if (herskill > 95) herskill = 95;
			if (_root.sNaginataExpertise > herskill) {
				this.ChallengesWon++;
				_root.AddText("You just win, she is a skilled oponent.\r\rShe looks annoyed and upset, but quickly regains her composure, thanking you for the match. She leaves promising to train harder and defeat you.");
				_root.SMMoney(20, true);
			} else {
				_root.AddText("You lose, she is a skilled oponent.\r\rShe looks pleased and gives you some suggestions to improve your technique. She also promises to return and see how your skill has improved.");
				_root.SMMoney(-20, true);
				this.ChallengesLost++;

			}
			_root.sNaginataExpertise += 1;
			if (_root.sNaginataExpertise > 100) _root.sNaginataExpertise = 100;
			_root.SMPoints(1, 1, 0, 0, 0, 0, 0, 0.25, 0);
			_root.DoEvent(9999);
			return true;
		}
		return false;
	}
	
	
	public function DoEventNoAsAssistant() : Boolean
	{
		if (_root.NumEvent == 10000) {
			// No - refuse
			_root.SetText("Lady Grey looks scornfully and turns her back and leaves.\r\rYou wonder if she will return or tell others about this.");
			this.ChallengesWon = -1;
			_root.SMPoints(0, 0, 0, 0, 0, 0, 0, -5, 0);
			_root.DoEvent(9999);
			return true;
		}
		return false;
	}
}