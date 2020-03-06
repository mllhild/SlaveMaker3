// Notes
// No event numbers
// uses 1 custom variable, occurs for rach slave

class Furrysesh1 extends SlaveModule
{
	private var FurryState:Number;
	
	public static function main(swfRoot:MovieClip) : SlaveModule 
	{
		// entry point
		var sm:Furrysesh1 = new Furrysesh1(swfRoot);
		return sm;
	}
	
	public function Furrysesh1(mc:MovieClip)
	{
		super(mc);
		StartGame();
	}

	public function StartGame()
	{
		this.FurryState = 0;
	}
	public function LoadGame(loaddata:Object)
	{
		this.FurryState = loaddata.FurryState;
		if (this.FurryState == undefined) StartGame();
	}
	public function SaveGame(savedata:Object)
	{
		savedata.FurryState = this.FurryState;
	}
	
	public function DoWalkTownCenterAsAssistant(NumEvent:Number, present:Boolean) : Boolean
	{
		if (this.FurryState > 1) return false;
		this.FurryState++;

		super.AutoAttachAndShowMovie("Event - Furry Bondage.jpg", 1, 1, 1);
		switch (this.FurryState) {
			case 1: 
				_root.SetText("You meet an odd slave bound outside of a shop.\r\r" + _root.SlaveIs + " a little aroused by the slaves clear arousal.");
				break;
			case 2:
				_root.SetText("The odd slave is still there.\r\r");
				break;
		}
		_root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
		return true;
	}

}