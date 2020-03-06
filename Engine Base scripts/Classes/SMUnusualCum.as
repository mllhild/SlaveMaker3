// Unusual Cum background

// Translation status: INCOMPLETE

import Scripts.Classes.*;

class SMUnusualCum extends SlaveModule
{	
		
	public function SMUnusualCum(mc:MovieClip, cgm:Object) { super(mc, null, cgm); }
	
	public function EventsAsAssistant(possible:Boolean)
	{
		if (possible && SMData.SMAdvantages.CheckBitFlag(6)) CheckUnusualCumTransform();
	}
	
	private function CheckUnusualCumTransform()
	{
		// are any slaves tranforming due to unusual cum
		var j:Number = SMData.SlavesArray.length;
		while (--j >= -2) {
			var sd:Object;
			if (j == -1) {
				sd = _root;
				coreGame.PersonIndex = -50;
			} else if (j == -2) {
				if (coreGame.AssistantData.SlaveType != 2 && coreGame.AssistantData.SlaveType != 1 && coreGame.AssistantData.SlaveType != 0) {
					coreGame.PersonIndex = -99;
					sd = coreGame.AssistantData;
				} else continue;
			} else {
				coreGame.PersonIndex = j;
				sd = SMData.SlavesArray[j];
				if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
			}
			coreGame.GetSlaveInformation(coreGame.PersonIndex);
			
			var dg:Boolean = sd.IsDickgirl();
			var hc:Boolean = dg || sd.SlaveGender == 1 || sd.SlaveGender == 4;
	
			if (hc == false && sd.DickgirlRate > 66) {
				UnusualCumEvents(sd);
				return;
			}
		}
	}
	
	private function UnusualCumEvents(sd:Object)
	{
		if (sd == undefined) sd = _root;
		
		if (sd != _root) coreGame.GetPersonGenderText(sd.GenderIdentity);
		coreGame.UseGeneric = false;
		
		Backgrounds.ShowBedRoom();
		coreGame.NumEvent = 212;
		if (sd == _root) {
			if (coreGame.SlaveGirl.ShowDickgirlPermanent() != true) coreGame.Generic.ShowDickgirlPermanent(false);
		} else coreGame.Generic.ShowDickgirlPermanent(false);
		SetText("You hear screams, possibly of passion from #person's room and run there. You see #personhimher lying coated in cum and with a large erect cock. She is now a hermaphrodite like you!");
		if (sd != coreGame.AssistantData) AddText("\r\r#assistant runs in and you both carefully examine #person and find her cock is extremely sensitive, making her cum with the slightest touch, in an intense back-arching orgasm. ");
		else AddText("\r\rYou carefully examine #person and find her cock is extremely sensitive, making her cum with the slightest touch, in an intense back-arching orgasm. ");
		if (sd == _root) {
			if (!coreGame.SlaveLikeServant) AddText("#assistant seems to delight in accidentally touching her cock and triggering another orgasm. ");
		}
		if (coreGame.NumEvent == 212) {
			AddText("\r\rAfter some time #person calms down and it seems her cock appears to be permanent.");
			
			if (sd == _root) {
				AddText(" You are aware there is a treatment to cure her.");
				if (coreGame.LastVisitDickgirl > 0) AddText("You will have #assistant locate the woman Astrid and try to see if she can source the antidote.");
				else AddText(" You do not know where to find an antidote and will have to find someone in the city who can help.");
				coreGame.LastVisitDickgirl = -1;
			}
			if (coreGame.MilkInfluence > 0) AddText("\r\rYou are surprised when you notice milk leaking #person's.");
			coreGame.DickgirlTransform(1, sd);
			Diary.AddEntry("#person has become a hermaphrodite through exposure to your cum.");
			DoEvent(9999);
		} else {
			AddText("\r\rAfter some time #person calms down and #personhisher cock shrinks and fades away.");
			DoEvent(9999);
		}
		coreGame.DoneEvent = 2;
	}
	
}
