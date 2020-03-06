//
// Training - a general form of training
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class TrainingBase extends SlaveModule
{
	public var bEventsAllowed:Boolean;
	//private var SMData:SlaveMaker;
	
		
	public function TrainingBase(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
		//trace("TrainingBase(): " + cgm + " " + coreGame);
		
		// ModuleName = "CatgirlTraining"; // set to unique name for training, MUST end ing "Training"
		AsEvent = false;
		bEventsAllowed = true;
	}
	
	public function CanLoadSave() : Boolean { return true; }

	
	// General Events
	
	public function IsTrainingEvent(ev:Object) : Boolean { 
		if (!bEventsAllowed) return false;
		
		// check if an event is possible. by chance, training started etc
		return PercentChance(10);
	}
	
	
	// Slave Maker Training

	// Introduction or start of slave maker training
	public function StartSlaveMakerTraining() {  }
	
	// An idividual session of training
	public function SlaveMakerTraining() : Boolean { return false; }

	
	// Slave Training

	// initial query if training should start
	public function AskToStartTraining(say:String)
	{
	}
	
	// start training the current slave
	public function StartTraining(type:Number)
	{
	}

	// they reject training
	public function RejectTraining()
	{
	}
	
	// a training event for the slave
	public function Training(place:Number) : Boolean
	{
		return false;
	}
	
	// stop training the slave
	public function StopTraining()
	{
	}
	
	// their training is complete
	public function FinishedTraining()
	{
	}
	
	// initialiseation on loading a game or starting a new slave (like Initialise()) for slaves
	public function InitialiseTraining(sd:Object)
	{
		SetSlave(sd);
	}
	
	// Slave Status

	public function IsTraining(sd:Slave) : Boolean
	{
		return IsTrainingStarted(sd) || IsTrainingComplete(sd);
	}
	
	public function IsTrainingStarted(sd:Slave) : Boolean { return IsTrainingComplete(sd); }
	
	public function IsTrainingComplete(sd:Object) : Boolean
	{
		return false;
	}
	
	public function ChangeTraining(val:Number, sd:Slave)
	{
	}
	
	public function GetTrainingListDetails(sd:Object) : String
	{ 
		if (!IsTrainingComplete(sd)) return "";
		return Language.GetText("ShortDescription", xNode);
	}
	
	public function IsResistingAct(act:Number, male:Number, female:Number, dickgirl:Number) : Boolean { return false; }
	
	
	// Ending
	// standard from SlaveModule class
	/*
	public function EndingStartAsAssistant() : Boolean { return false; }

	public function EndingFinishAsAssistant(total:Number) : Boolean { return false; }
	
	public function NumCustomEndingsAsAssistant() : Number { return 0; }
	
	public function ShowEndingsAsAssistant(num:Number) { }
	
	public function HideEndingsAsAssistant() { }
	
	public function CheckMetaEndingsAsAssistant() : Boolean { return false; }
	*/
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText(Language.GetHtml("Ending" + ModuleName + "/Hint", "Endings"));
	}
	
	
	// Generai initialisation
	
	public function InitialiseModule(mcb:MovieClip)
	{
		super.InitialiseModule(mcb);
		
		xNode = Language.XMLData.GetNodeC("SlaveTrainings/" + ModuleName.substr(0, ModuleName.length - 8));
	}
	
	
	// References
	
	private function SetEnding(fin:Number, endstr:String) { coreGame.SetEnding(fin, endstr); }
	
	private function XMLEvent(node:String, sett:Boolean, nlast:Boolean) : Boolean { return Language.XMLData.XMLEvent(node, sett, nlast); } 
	private function DoXMLAct(act:String) : Boolean { return Language.XMLData.DoXMLAct(act); } 
	private function XMLGeneral(tag:String, sett:Boolean, basenode:XMLNode) : Boolean { return Language.XMLData.XMLGeneral(tag, sett, basenode); } 

	// Overrides to prevent some bugs due to typos, ideally fix instances but this is to prevent
	// unknown cases
	public function DoEventNext(enum:Number, xmlnow:Boolean) { coreGame.DoEventNext(enum, xmlnow); }
	
	private function GetShop(str:String) : Shop { return coreGame.currentCity.GetShopInstanceString(str); }


}