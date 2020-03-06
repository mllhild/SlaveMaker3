// Ruins
// Linked to Walk-Ruins.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceRuins extends QuestEvilMine
{
	// Images
	
	public function PlaceRuins(mc:MovieClip, cg:Object, cc:City)
	{
		super("RuinedTemple", mc, cg, 8, false, "Engine/Walk-Ruins.swf", 300, 20, cc);

	}
	
	// New Slave
	public function StartNewSlave(except:Number, exceptf:Number)
	{
		super.StartNewSlave(1);
	}
	
	public function HideImages()
	{
		this.mcBase.WalkRuinedTemple._visible = false;
	}
	
	public function SetWalkEvents()
	{
		super.SetWalkEvents();
		this.AddEvent("TentacleSex", true);
		this.AddEvent("Explore1-1");
		this.AddEvent("Explore2-2");
		this.AddEvent("Explore3-3");
		this.AddEvent("Wander-4");
	}
	
	private function RuinsEeerieEvent()
	{
		AddText("\r\r");
		switch(Math.floor(Math.random()*6)) {
			case 0:
				AddText("#slave notices during the walk that it is completely silent, no animals, insects, not even the sound of the wind. #slave pauses for a moment and feels a little frightened. They move on and a few minutes later hear a cat in the distance and all the noises of nature return...");
				break;
			case 1:
				AddText("#slave sees a strange pattern drawn in the soil. An intricate diagram written in some strange language, but blurred by the wind. Staring at it #slaveheshe" + coreGame.NonPlural(" feel") + " odd sensations, almost like hands lightly tracing it's fingers over #slavehisher" + coreGame.Plural(" bottom") + ". " + coreGame.SlaveHeSheUC + " starts and they quickly move on...");
				break;
			case 2:
				AddText("#slave sees a hole in the ground, as if a large creature had dug down quickly, hiding. They walk quickly away...");
				break;
			case 3:
				AddText("#slave feels the wind pick up, and feels it blowing #slavehisher hair around. The wind almost feels like fingers running over #slavehisher skin, lightly caressing #slavehisher" + coreGame.Plural(" bottom") + ", and breasts...");
				break;
			case 4:
				AddText("For a time the sun seems to go behind a heavy cloud. #slave looks up and the sun is clear, not a cloud near. The darkness passes...");
				break;
			case 5:
				if (Supervise) AddText("#slave feels an incredible wash of passion run through #slavehimher. You also feel a surge of intense arousal. Equally suddenly the feeling passes and you both look surprised and maybe disappointed..."); 
				else AddText("#slave feels an incredible wash of passion run through #slavehimher. Looking #slaveheshe sees #assistant seems affected too. Equally suddenly the feeling passes and they both look surprised and maybe disappointed...");
				break;
		}
		AddText("\r\r");
	}
	
	// Walking in the Runs
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{
		trace("Ruins.DoWalkLoaded " + EvilMineFlag + " " + IsStartedSpecialEvent() + " " + IsCompleteSpecialEvent());
		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (IsStartedSpecialEvent()) {
			// race("seeking help");
			SetEvent(4120);
			DoEventNextAsAssistant();
			return;
		}
		
		if ((EvilMineFlag != -10) && (!this.CheckBitFlag(41)) && this.CheckBitFlag(0) && this.CheckBitFlag(1)) {
			trace("doing evil mine quest");
			DoEvilMine();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkRuins++;
		coreGame.EventTotal = slaveData.TotalWalkRuins;
		
		coreGame.Tentacles.CheckTentacleWalk("While #slave starts walking around the ruins #slaveheshe smells a foul odour. Between some shattered stones #slaveheshe sees a horribly slain thing. #slave sees torn tentacles and ripped apart flesh. Terrible burns and claw marks cover the flesh. #slave looks away in fright and hurries on.\r\r", " is walking by a shattered wall");

		// Select the event and show it
		if (IsEventAllowable()) super.DoWalkLoaded(mc, modulename);
	}
	
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude, true);
	}
	
	public function HandleWalk() : Boolean
	{
		SMTRACE("Ruins::HandleWalk " + coreGame.StrEvent);
		
		switch (coreGame.StrEvent) {
			
		case "TentacleSex":
			coreGame.TentacleChoice = Math.floor(Math.random()*2);
			coreGame.Tentacles.TentacleSex(8);
			return true;
			
		case "Wander4-4":
			AddText("#slave walks for a time though the grounds of the ruined temple. The main temple building is on a small steep sided hill, almost a plateau. There is signs of an access path that was long ago destroyed. #slave can see no way to access the temple, short of climbing gear.");
			RuinsEeerieEvent();
			AddText("Despite the tales of danger #slaveheshe has a pleasant walk.");
			Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0.5, 0, 0);
			return true;
			
		case "Explore1-1":
			this.NoRepeatEvent();
			ShowSupervisor();
			Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0.5, 0, 0);
			AddText("#slave and #assistant start walking around the grounds of the ruined temple. The grounds are large with the main temple building on a small steep sided hill, almost a plateau. There are signs of an access path that was long ago destroyed. #slave can see no way to access the temple, short of climbing gear.");
			RuinsEeerieEvent();
			AddText("They start walking around the hill but have to stop after a time and return. They will have to finish the walk another day.");
			return true;
			
		case "Explore2-2":
			this.NoRepeatEvent();
			AddText("#slave continues around the outer grounds from the point #slaveheshe left off last time. After a time #slaveheshe reaches ");
			Backgrounds.ShowCave(1);
			if (EvilMineFlag == -10) AddText("that horrible mine, #slaveheshe had forgot exactly where it was. With regret for the girls #slaveheshe moves on.");
			else if (this.CheckBitFlag(41)) AddText("that horrible mine, #slaveheshe had forgot exactly where it was. #slave smiles remembering the freeing of the girls, but has some strange thoughts about their imprisonment. #slave puts aside #slavehimher arousal and moves on.");
			else AddText("a cave, maybe a small mine. It has a large gate over the entrance and a foul odour coming from inside. Wrinkling #slavehisher nose #slaveheshe moves on.");
			RuinsEeerieEvent();
			AddText("#assistant ends the walk and they still have not circled the temple completely, or found a way into the main temple.\r\rAs they are leaving a small patrol of the guard challenge their presence and #assistant shows them a pass.\r\r");
			ShowSupervisor();
			Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0.5, 0, 0);
			return true;
			
		case "Explore3-3":
			this.NoRepeatEvent();
			ShowSupervisor();
			Points(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0.5, 0, 0);
			AddText("#assistant and #assistant continue walking around the grounds of the ruined temple. At one point they see a narrow crack in the cliff wall, very tight, almost impossible to squeeze through. #slave starts to try and is assailed by a horrible stench and staggers back. #assistant insists they continue on.");
			RuinsEeerieEvent();
			AddText("After a long walk they reach the point they originally started, they have circled the temple.");
			return true;

		}
				
		return false;
	}
}