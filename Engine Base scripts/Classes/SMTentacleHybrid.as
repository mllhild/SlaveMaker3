// Tentacle Hybrid background
// Special Event
// 2 = Tentacle Hybrid

// SpecialEvent Bit Flags
// 0 = Dream 1
// 1 = Dream 2
// 2 = Hild impregnated

// SpecialEventProgress
// degree of accepting heritage
// 0 = never prayed/no events
// 100 = queen/king

// Translation status: COMPLETE

import Scripts.Classes.*;

class SMTentacleHybrid extends SMUnusualCum
{	
		
	public function SMTentacleHybrid(mc:MovieClip, cgm:Object) { super(mc, null, cgm); }
	
	public function AfterMeetPersonAsAssistant(person:Number, choice:Number, evt:String)
	{
		if (evt != "pray" || coreGame.AppendActText == false || !IsEventAllowable() || SMData.SMSpecialEvent != 2) {
			super.AfterMeetPersonAsAssistant(person, choice, evt);
			return;
		}
		if (SMData.Corruption > 0) {
			AddTextToStart(Language.GetHtml("SlaveMaker/TentacleHybrid/Pray", Language.flNode) + "\r\r");
		}
		Language.XMLData.PickAndDoXMLEvent("/SlaveMaker/TentacleHybrid/Events", false);
	}
	
}
