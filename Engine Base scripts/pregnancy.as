import Scripts.Classes.*;

// Pregnancy

// BitFlags
// Flag1
//  13	= gaining weight/pregnant
//	14	= NOT on contraceptives
//	95	= announced pregnancy

// FlagSM
//  95	= announced pregnancy

function SeePregnant(sd:Object)
{
	if (sd == undefined) sd = _root;
	if (sd.PregnancyGestation > 0 && sd.PregnancyGestation < 20 && (!sd.BitFlag1.CheckBitFlag(13))) {
		sd.BitFlag1.SetBitFlag(13);
		if (sd == _root && SlaveGirl.SeePregnant() == true) return;
		BlankLine();
		Language.AddLangText("PregnancyGainingWeight", "Other");
	}
}

// Check if someone is about to give birth or is newly pregnant
// returns true if someone gives birth
function CheckBirthing(report:Boolean) : Boolean
{
	// are any slaves due to give birth
	var j:Number = SMData.nUsable - 1;
	var idxTell:Number = -1000;
	while (--j >= -4) {
		var sd:Object;
		if (j == -1) {
			sd = _root;
			PersonIndex = -50;
		} else if (j == -2) {
			if (AssistantData.SlaveType != 1 && AssistantData.SlaveType != 2 && AssistantData.SlaveType != 0) {
				PersonIndex = -99;
				sd = AssistantData;
			} else continue;
		} else if (j == -3) {
				if (SpecialIndex != undefined) {
					sd = SlavesArray[SpecialIndex];
					PersonIndex = sd.SlaveIndex;
				} else continue;
		} else if (j == -4) {
			sd = SMData;
			PersonIndex = -100;
		} else {
			sd = SMData.arUsableSlaves[j];
			PersonIndex = sd.SlaveIndex;
			if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
			if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
		}
		GetSlaveInformation(PersonIndex);		// set #personxxxxx
		if (sd.PregnancyGestation == -1000) {
			SetText("");
			if (PersonIndex == -100) GiveBirthSM();
			else GiveBirth(sd);
			trace("gave birth");
			return true;
		}
		if (sd.PregnancyGestation == 0) continue;
		if (PersonIndex == -100) {
			if (BitFlagSM.CheckBitFlag(95)) continue;
		} else if (sd.BitFlag1.CheckBitFlag(95)) continue;
		
		var el:Number = GameDate - sd.DateImpregnated;
		if (el > 29 || sd.PregnancyGestation < 20) idxTell = PersonIndex;
	}
	
	// no births today, check if anyone is recognised as pregnant
	// If a nurse or midwife slave is owend then report
	if (idxTell == -1000 || !report) return false;
	
	// there is someone pending
	var sdNurse:Slave = SMData.GetUsableSlaveDetails("Cora");
	if (sdNurse != null) {
		if (!sdNurse.IsSlaveOwned()) sdNurse = null;
	}
	if (sdNurse == null) sdNurse = SMData.GetAnySlaveTrainedAs("Nurse|MidWife");
	if (sdNurse == null) return false;
	if (sdNurse != null) {
		if (!sdNurse.IsSlaveOwned()) return false;
	}
	GetOtherSlaveInformation(sdNurse.SlaveIndex);
	
	var sd:Object = GetSlaveInformation(idxTell);
	if (sd == null) return false;
	
	HideImages();
	Backgrounds.ShowBedRoom();
	
	// set flag that this has been announces
	var strn:String = "Other/PregnancyReport";
	if (sd != SMData) {
		if (sdNurse.SlaveIndex == idxTell) strn += "Self";
		// show default image and set flag
		if (sdNurse == slaveData) SlaveGirl.ShowChoreDiscuss();
		else sdNurse.ShowActImage(1004);
		sd.BitFlag1.SetBitFlag(95);
	} else {
		SMData.ShowSlaveMaker(0, 1, 1);
		SMData.BitFlagSM.SetBitFlag(95);
	}
	
	// give report
	// allow for a customised xml version for nurse
	DoEvent(9999);
	var sNodeNurse:XMLNode = GetSlaveObjectXML(sdNurse);
	if (sNodeNurse != null) if (XMLData.XMLEventByNode(GetNode(sNodeNurse, strn), true)) return true;
	
	// no custom version, so do a general version
	XMLData.XMLEventByNode(GetNode(flNode, strn), true);
	return true;
}

function RecheckBirthing() : Boolean
{
	//trace("RecheckBirthing: " + config.IsEnabled("CommonDefaults/MultipleBirthsPerDay"));
	if (config.IsEnabled("CommonDefaults/MultipleBirthsPerDay")) {
		// trace("checking");
		if (CheckBirthing(false)) {
			DoneEvent = 1;
			return true;
		}
		trace("no births");
	}
	DoEventNext(9999);
}


// Give Birth - SlaveMaker
function GiveBirthSM()
{
	// Impregnated
	SMData.PregnancyGestation = 0;
	
	HideImages();
	HideSlaveActions();
	if (SMData.ShowSlaveMaker(-10022, 1, 1) == undefined) {
		if (SMData.Gender == 3) {
			if (DickgirlTesticles) temp = Math.floor(Math.random()*2) + 1;
			else temp = 3;
			AutoLoadImageAndShowMovie("Images/Appearances/Default Images/Event - Pregnancy Reveal (As Dickgirl " + temp + ").jpg", 1, 1);

		} else {
			temp = Math.floor(Math.random()*2) + 1;
			AutoLoadImageAndShowMovie("Images/Appearances/Default Images/Event - Pregnancy Reveal " + temp + ".jpg", 1, 1);
		}
	}
	SMData.BitFlagSM.ClearBitFlag(95);

	var bHandled:Boolean = XMLData.XMLGeneral("Other/SM" + SMData.PregnancyType + "Pregnancy", true, SMAvatar.GetXML());
	if (bHandled == false && SMData.PregnancyType.toLowerCase() == "tentacles") bHandled = XMLData.XMLGeneral("Other/SMTentaclePregnancy", true, SMAvatar.GetXML());
	if (!bHandled) {
		var sd:Object = GetSlaveInformation(SMData.PregnancyType);
		if (sd != null) {
			var sNode:XMLNode = GetSlaveObjectXML(sd);
			if (sNode != null) bHandled = XMLEventByNode(GetNode(sNode, "Other/SM" + SMData.PregnancyType + "Pregnancy"), true);
			if (bHandled == false) bHandled = XMLData.XMLGeneral("Other/SMHumanPregnancy", true, SMAvatar.GetXML());
		}
	}
	
	switch(SMData.PregnancyType.toLowerCase()) {
		case "tentacle":
		case "tentacles":
			SMData.SMTotalTentaclePregnancy += SMData.PregnancyCount;
			//BitFlag1.ClearBitFlag(34);		// OBSOLETE flag to indicate Slave Maker pregnancies
			break;
			
		default:
			SMData.TotalSMChildren += SMData.PregnancyCount;
			break;
	}
	if (IsEventAllowable()) DoEvent("RecheckBirthing");
}

// Give Birth
function GiveBirth(sd:Object)
{
	if (sd == undefined) sd = _root;
	trace("slave " + sd.SlaveName + " gives birth to " + sd.PregnancyType);
	
	if (sd != _root) GetPersonGenderText(sd.GenderIdentity);
	HideImages();
	Generic.SetSlave(sd);
	sd.PregnancyGestation = 0;
	sd.BitFlag1.ClearBitFlag(13);
	sd.BitFlag1.ClearBitFlag(95);
	SMData.ShowSlaveMaker();
	Backgrounds.ShowBedRoom();
	UseGeneric = false;
	
	var bHandled:Boolean = XMLData.XMLGeneral("Other/" + sd.PregnancyType + "Pregnancy", false, GetSlaveObjectXML(sdata));
	if (!bHandled) {
		if (!bHandled) {
			var xNode:XMLNode = XMLData.GetSlaveXML(sd.PregnancyType);
			if (xNode != null) bHandled = XMLData.XMLGeneral("Other/" + sd.PregnancyType + "Pregnancy", false, xNode);
		}
		if (!bHandled && sd.PregnancyType.toLowerCase() == "tentacles") bHandled = XMLData.XMLGeneral("Other/TentaclePregnancy", true);
		if (!bHandled) bHandled = XMLData.XMLGeneral("Other/" + sd.PregnancyType + "Pregnancy", true);
	}
	if (!bHandled) {
		var sd2:Object = GetSlaveInformation(sd.PregnancyType);
		if (sd2 != null) {
			var sNode:XMLNode = GetSlaveObjectXML(sd2);
			if (sNode != null) bHandled = XMLData.XMLEventByNode(GetNode(sNode, "Other/SM" + sd.PregnancyType + "Pregnancy"), true);
		}
	}
	
	switch(sd.PregnancyType.toLowerCase()) {
		case "tentacle":
		case "tentacles":
		case "yourstentacle":
			sd.TotalTentaclePregnancy += sd.PregnancyCount;
			if (PersonIndex == -50) {
				if (SlaveGirl.ShowTentaclePregnancyBirth() != true) {
					if (SlaveGirl.ShowPregnancyBirth() != true) {
						if (SlaveGirl.ShowTentaclePregnancyReveal() != true) {
							if (SlaveGirl.ShowPregnancyReveal() != true) UseGeneric = true;
						}
					}
				}
			} else if (PersonIndex == -99) {
				if (CurrentAssistant.ShowTentaclePregnancyBirth() != true) {
					if (CurrentAssistant.ShowPregnancyBirth() != true) {
						if (CurrentAssistant.ShowTentaclePregnancyReveal() != true) {
							if (CurrentAssistant.ShowPregnancyReveal() != true) UseGeneric = true;
						}
					}
				}
			} else UseGeneric = true;
			if (UseGeneric) {
				sd.ShowActImage(10023);
				if (UseGeneric) sd.ShowActImage(10022);
				if (UseGeneric) {
					Generic.ShowTentaclePregnancyBirth();
					ShowSlave(sd, 0, 1);
				}
			}
			break;
			
	 	default:
			sd.TotalChildren += sd.PregnancyCount;
			if (PersonIndex == -50) {
				if (SlaveGirl.ShowPregnancyBirth() != true) {
					if (SlaveGirl.ShowPregnancyReveal() != true) UseGeneric = true;
				}
			} else if (PersonIndex == -99) {
				if (CurrentAssistant.ShowPregnancyBirth() != true) {
					if (CurrentAssistant.ShowPregnancyReveal() != true) UseGeneric = true;
				}
			} else UseGeneric = true;
			if (UseGeneric) sd.ShowActImage(10023.1);
			if (UseGeneric) sd.ShowActImage(10022);
			if (UseGeneric) {
				if (!Generic.ShowPregnancyBirth()) Generic.ShowPregnancyReveal();
				ShowSlave(sd, 0, 1);
			}
			break;
	}
	Generic.SetSlave(slaveData);
	if (IsEventAllowable()) {
		DoEvent("RecheckBirthing");
		DoneEvent = 1;
	}
}
