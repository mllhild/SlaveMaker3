// Mesmerism
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class SMMesmerism extends SMTentacleHybrid
{	
		
	public function SMMesmerism(mc:MovieClip, cgm:Object) { super(mc, null, cgm); }
	
	public function SMPreEvent() : Boolean
	{
		if ((coreGame.currentCity.Home.hWards == 0 && SMData.SMSpecialEvent == 5) || SMData.SMSpecialEvent == 7) return super.SMPreEvent();

		if (SMData.SMAdvantages.CheckBitFlag(28) == false && (coreGame.IsNoAssistant() || coreGame.AssistantData.IsVampire() != true)) return super.SMPreEvent();
		
		Backgrounds.ShowBedRoom();
		coreGame.UseGeneric = false;
		coreGame.SlaveGirl.ShowTired(false);
		if (SMData.SMAdvantages.CheckBitFlag(28)) {
			// Slave Maker
			SetText("You visit #slave's bedroom to try to influence #slavehisher mind using your mesmeric abilities. You shake #slave to wake #slavehimher and as #slaveheshe starts to wakeup you look deeply in their sleepy eyes ");
			if (!PercentChance(SMData.SMDominance)) {
				AddText("but you are unable to get #slave to focus and fail to affect #slavehimher.");
				DoEvent(251);
				return true;
			}
			AddText("and you are able to influence #slavehimher in some way to better serve you.");
		} else {
			// Assistant
			SetText("You visit #slave's bedroom and ask #assistant to quietly join you. You ask #assistant to try to influence #slave's mind using #assistanthisher mesmeric abilities. You shake #slave to wake #slavehimher and as #slaveheshe starts to wakeup #assistant looks deeply in their sleepy eyes ");
			if (!PercentChance(coreGame.AssistantData.VarIntelligence)) {
				AddText("but #assistant is unable to get #slave to focus and fails to affect #slavehimher.");
				DoEvent(251);
				return true;
			}	
			AddText("and #assistant is able to influence #slavehimher in some way to better serve you.");
		}
														
		ResetQuestions("How will #slave be influenced...");
		if ((coreGame.GameDate - coreGame.LastAny) > 1) {
			coreGame.LastAny = coreGame.GameDate;
			AddQuestion(5010, "Once, #slaveheshe will obey sexually");
			AddQuestion(5012, "Once, #slaveheshe will obey non-sexually");
		} else {
			AddQuestion(5014, "#Slavehisher desire will grow");
			AddQuestion(5013, "#Slaveheshe will have visions of sex");
		}
		AddQuestion(5011, "#Slavehisher arousal will grow");
		AddQuestion(5013, "#Slaveheshe will meekly obey");
		AddQuestion(5018, "nothing for now");
		ShowQuestions();
		return true;
	}
	
		
	// Slave has been refused to work as an acolyte
	// So mesmerise the nun to agree
	public function AcolyteRefusedMesmerise()
	{
		SetText("You ask to speak privately with the nun for a moment and you both step into a small room. When the door closes you look deeply into the nun's eyes and start to work your power over her...\r\r");
		if (PercentChance(SMData.SMDominance)) {
			AddText("The nun's eyes glaze over and she quietly agrees to allow #slave to work for her.\r\r");
			Money(-50);
			SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0);
			DoEvent("DoJobAcolyte1", coreGame);
		} else {
			SMData.SMPoints(0, 0, 0, 0, 5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0);
			AddText("The nun looks a little confused but the her face clears and she asks what happened? You realise you cannot affect her and leave the room and give up.\r\r");
			coreGame.ShowPlanningNext();
		}
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
		// 5010 - Mesmerise - any sex
		 case 5010:
			coreGame.AnySex = true;
			Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, -2, 1, 0, 1, 0, 0, 0, 0, 0);
			coreGame.DoEventNext(251);
			return true;
			
		// 5011 - Mesmerise - arousal
		 case 5011:
		 	if (SMData.SMSpecialEvent == 7) Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0);
			else Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0);
			coreGame.DoEventNext(251);
			return true;
			
		// 5012 - Mesmerise - any non sex
		 case 5012:
			coreGame.AnyNonSex = true;
			Points(0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, -2, 1, 0, 1, 0, 0, 0, 0, 0);
			coreGame.DoEventNext(251);
			return true;
			
		// 5013 - Mesmerise - obey
		 case 5013:
			if (SMData.SMSpecialEvent == 7) Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, -2, 1, 2.5, 1, 0, 0, 0, 0, 0);
			else Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, -2, 1, 2, 1, 0, 0, 0, 0, 0);
			coreGame.DoEventNext(251);
			return true;
			
		// 5014 - Mesmerise - desire
		 case 5014:
		 	if (SMData.SMSpecialEvent == 7) Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 0, 0, 0, 0, 0);
			else Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 1, 0, 0, 0, 0, 0);
			coreGame.DoEventNext(251);
			return true;
			
		// 5015 - Mesmerise - visions
		 case 5015:
		 	if (SMData.SMSpecialEvent == 7) {
				coreGame.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
				Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 3, 3, 0, 1, 0, 1, 0, 0, 0, 0, 0);
			} else {
				coreGame.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.5);
				Points(0, 0, 0, -1, -1, 0, 0, 0, 0, 2, 2, 0, 1, 0, 1, 0, 0, 0, 0, 0);
			}
			coreGame.DoEventNext(251);
			return true;
			
		// 5016 - Mesmerise - Nothing
		case 5018:
			coreGame.DoEventNext(251);
			return true;
		}
		return super.DoEventNextAsAssistant();
	}
	
}
