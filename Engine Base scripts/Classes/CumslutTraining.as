// CumslutTraining training
//
// Translation status: IMCOMPLETE

import Scripts.Classes.*;

class CumslutTraining extends TrainingBase
{
	public function CumslutTraining(cgm:Object)
	{
		super(null, cgm);
		
		ModuleName = "CumslutTraining";
	}

	
	// Slave Status
		
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		if (sd == undefined) return coreGame.CumslutLevel > 0;
		return sd.CumslutLevel > 0;
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) coreGame.CumslutLevel == 2000;
		return sd.CumslutLevel == 2000;
	}
	
	public function ChangeTraining(val:Number, sd:Slave)
	{
		if (sd == undefined) coreGame.ChangeCumslut(val);
		else sd.ChangeCumslut(val);
	}
	
	// Events
	// Warning no bondage
	public function EventsAsAssistant(possible:Boolean)
	{
		if (possible == false || !coreGame.IsCumslutTraining()) return;
		
		temp = SMData.SMAdvantages.CheckBitFlag(6) ? 60 : 80;
		
		// are any slaves now cumsluts
		var j:Number = SMData.nUsable - 1;
		var sd:Object;
		
		while (--j >= -1) {
			if (j < 0) {
				sd = _root;
				coreGame.PersonIndex = -50;
			} else {
				coreGame.PersonIndex = j;
				coreGame.sdata = SMData.arUsableSlaves[j];
				sd = coreGame.sdata;
				if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
				if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
			}
			if (sd.IsCumslut()) continue;				// already a cumslut
			if (sd.CumslutLevel <= temp) continue;		// not yet ready
			if (sd.IsSlave("Brain Slug")) continue;		// ??????
			if (sd.IsSlave("Arak")) continue;			// not appropriate
			
			// ready to confess
			
			// get slave information
			coreGame.GetSlaveInformation(coreGame.PersonIndex);
					
			// show image
			coreGame.UseGeneric = false;
			if (j == -1) {
				var aw:Boolean = coreGame.SlaveGirl.ShowMorningMouthfull(false);
				if (aw == undefined) coreGame.UseGeneric = true;
			} else sd.ShowActImage(5);
			if (coreGame.UseGeneric) {
				coreGame.UseGeneric = false;
				if (j == -1) coreGame.SlaveGirl.ShowChoreDiscuss();
				else sd.ShowActImage(1004);
				if (coreGame.UseGeneric) coreGame.ShowSlave(sd, 1, 1);
			}
			
			coreGame.OtherSlaveShown = coreGame.PersonIndex != -50;
			coreGame.UpdateSlaveGenderText(sd);
			coreGame.ShowStatisticsTab(1);
			coreGame.modulesList.trainLesbians.InitialiseTraining(sd);
			SMData.ShowSlaveMaker();
			
			coreGame.Cum.gotoAndStop(1);
			coreGame.Cum.WhiteOut._visible = false;
			coreGame.Cum._visible = true;
		
			if (XMLGeneral("SlaveTrainings/Cumslut/CumslutDeclaration", false, coreGame.GetSlaveObjectXML(sd))) {
				// reset training
				sd.CumslutLevel = -1;
			}
			return;
		}
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		if (coreGame.NumEvent == 2500) {
			coreGame.HideSlaveActions();
			coreGame.UseGeneric = false;
			coreGame.GetSlaveInformation(coreGame.PersonIndex);
			if (coreGame.PersonIndex == -50) coreGame.SlaveGirl.ShowChoreDiscuss();
			else coreGame.sdata.ShowActImage(1004);
			if (coreGame.UseGeneric) coreGame.ShowSlave(coreGame.sdata, 1, 1);
			
			var csindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("Cumslut", "Skills"));
			coreGame.RemoveSlaveSkill(csindex);
			coreGame.UpdateBasicSlaveSkills();
	
			DoEvent(9999);
			XMLGeneral("SlaveTrainings/Cumslut/CumslutRefused", false, coreGame.GetSlaveObjectXML(coreGame.sdata));
			return true;
		}
		if (coreGame.NumEvent == 2501) {
			coreGame.HideSlaveActions();
			coreGame.GetSlaveInformation(coreGame.PersonIndex);
			if (coreGame.PersonIndex == -50) coreGame.SlaveGirl.ShowChoreDiscuss();
			else coreGame.sdata.ShowActImage(1004);
			if (coreGame.UseGeneric) coreGame.ShowSlave(coreGame.sdata, 1, 1);
			
			if (coreGame.PersonIndex == -50) {
				coreGame.CumslutLevel = 2000;
				var csindex:Number = coreGame.slaveData.GetSlaveSkillArrayIndex(Language.GetHtml("Cumslut", "Skills"));
				coreGame.arSkillArray[csindex].PlusIcon._visible = true;
				coreGame.UpdateBasicSlaveSkills();
				coreGame.slaveData.SetTitles("Cumslut");
				coreGame.Titles = coreGame.slaveData.Titles;
			} else {
				coreGame.sdata.CumslutLevel = 2000;
				if (coreGame.sdata.SlaveName.substr(0, 7) != Language.GetHtml("Cumslut", "Skills")) coreGame.sdata.SetGirlsVitals(Language.GetHtml("Cumslut", "Skills") + " " + sd.SlaveName);
			}
			DoEvent(9999);
			XMLGeneral("SlaveTrainings/Cumslut/CumslutAgreed", false, coreGame.GetSlaveObjectXML(coreGame.sdata));
			return true;
		}

		return false;
	}
	
	
	// Ending
	
	public function CheckMetaEndingsAsAssistant() : Boolean
	{ 
		if (coreGame.IsCumslut() && !coreGame.IsMetaDone(27)) {
			trace("yes a cumslut");
			if (coreGame.IsDickgirl()) SetEnding(27, Language.XMLData.GetXMLString("EndingCumslut/DickgirlName", "EndGame/Slave"));
			else SetEnding(27, Language.XMLData.GetXMLString("EndingCumslut/Name", "EndGame/Slave"));
			return true;
		}
		return false;
	}
	
	
	public function EndingFinishAsAssistant(total:Number) : Boolean
	{
		if (coreGame.NumFin == 27) {
			// Cumslut
			coreGame.HideImages();
			coreGame.ClipTrainingComplete._visible = false;
			Backgrounds.ShowBedRoom();
			coreGame.NumFin = -1;
			XMLGeneral("EndGame/Slave/EndingCumslut/ReviewScene");
			if (coreGame.SlaveGirl.ShowEndingCumslut() != true) {
				coreGame.UseGeneric = false;
				coreGame.SlaveGirl.ShowMorningMouthfull();
				if (coreGame.UseGeneric) coreGame.Generic.ShowMorningMouthfull();
			}
			return true;
		}
		return false;
		
	} 
	
	public function NumCustomEndingsAsAssistant() : Number { return 1; }
	
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText("To get the ending 'Cumslut', train #slave and have #slavehimher drink a lot of cum, then call #slavehimher a cumslut when #slaveheshe confesses #slavehiaher taste for it.");
	}
	
}

