// Love
import Scripts.Classes.*;


// Functions


// Love Confession

function CheckLoveConfession()
{	
	//trace("CheckLoveConfession()");
	// are any slaves in love with you
	var j:Number = SMData.nUsable - 1;
	var sd:Object;
	
	while (--j >= -2) {
		// get slave oject/index
		if (j == -1) {
			sd = _root;
			PersonIndex = -50;
		} else if (j == -2) {
			if (AssistantData.SlaveType != 2 && AssistantData.SlaveType != 1 && AssistantData.SlaveType != 0) {
				PersonIndex = -99;
				sd = AssistantData;
			} else continue;
		} else {
			PersonIndex = SMData.arUsableSlaves[j].SlaveIndex;
			sdata = SMData.arUsableSlaves[j];
			sd = sdata;
			//if (sdata.SlaveType != 0 && sdata.SlaveType != 1 && sdata.SlaveType != 2 && sdata.SlaveType != -20) continue;
			//if (sdata.SlaveType == 1 && sdata.CanAssist == false) continue;
		}

		// in love?
		if (sd.VarLovePoints <= 60 || sd.LoveAccepted != 0) continue;
		if (sd.IsSlave("Mugi")) continue;			// has a special version
		if (sd.IsMarried()) continue;				// married to them already, a little redundant but needed for Arak
		if (sd.IsSlave("Brain Slug")) continue;		// ?????
	
		temp = Math.floor(Math.random()*10+Difficulty);
		if (temp >= Math.floor(sd.VarLovePoints/20)) continue;
		
		// yes they are in love and confess
		// bypass for slaves not in lesbian training and can be trained
		if (PersonIndex == -50) {
			if ((SMData.sLesbianTrainer >= 1) &&
				(SMData.Gender == 2 || (DickgirlLesbians && SMData.Gender == 3)) &&
				(!sd.BitFlag1.CheckBitFlag(10)) && (!sd.BitFlag1.CheckBitFlag(11))
			   ) continue;
		}
		
		// has the slave maker learned a little leadership from this?
		if (SMData.sLeadership == 0) SMData.sLeadership = 1;
		UpdateSlaveMaker();
		
		// get slave details
		GetSlaveInformation(PersonIndex);
				
		// how many slaves can be in love
		var iLove:Number = SMData.GetTotalSlavesInLove();
		var iLimit:Number = 1 + ((SMData.sLeadership * 2) - 1);
		if (SMData.sLeadership > 3 || sd.IsSlave("Shampoo")) iLimit = 99999;
		else if (SMData.sLeadership == 1) iLimit = 1;
		
		Lesbian = sd.SlaveGender == 1 || sd.SlaveGender == 4 ? SMData.Gender == 1 : SMData.Gender == 2;

		OtherSlaveShown = PersonIndex != -50;
		GetPersonGenderText(sd.GenderIdentity);
		ShowStatisticsTab(1);
		modulesList.trainLesbians.InitialiseTraining(sd);
		SMAvatar.ShowSlaveMaker();
		
		UseGeneric = false;
		AppendActText = true;
		
		if (iLove < iLimit) {
			
			XMLData.XMLGeneral("Other/LoveConfession", false, GetSlaveObjectXML(sd));
			if (j == -1) SlaveGirl.ShowLoveConfession();
			else sd.ShowActImage(10027);
			
			XMLData.XMLGeneral("Other/LoveConfessionResponses", false, GetSlaveObjectXML(sd));
		} else {
			NumEvent = 9999;
			if (j == -1) {
				SlaveGirl.Lesbian = Lesbian;
				SlaveGirl.ShowLoveRefused();
			} else sd.ShowActImage(10026);
			XMLData.XMLGeneral("Other/LoveConfessionTooManyLovers", false, GetSlaveObjectXML(sd));
			if (IsEventAllowable()) DoEvent(9999);
		}
		
		if (UseGeneric) {
			UseGeneric = false;
			if (j == -1) {
				SlaveGirl.Lesbian = Lesbian;
				SlaveGirl.ShowChoreDiscuss();
			} else sd.ShowActImage(1004);
			if (UseGeneric) ShowSlave(sd, 1, 1);
			AutoAttachAndShowMovie("Hearts (Movie)", 1, 1, iLove < iLimit ? 1 : 2, DummyClip);
		}
				
		if (SMData.Gender != 1) {
			if (sd.BitFlag1.CheckBitFlag(10)) {
				BlankLine();
				if (SMData.Gender == 3 && DickgirlLesbians == false) {
					XMLData.XMLGeneralSA("Other/LoveConfessionLesbianDG", false, GetSlaveObjectXML(sd));
				} else {
					sd.SetSexuality(23);
					if (sd == _root) Icons.SetLoveIcon(_root);
					XMLData.XMLGeneralSA("Other/LoveConfessionLesbian", false, GetSlaveObjectXML(sd));
					sd.DifficultyLesbian = 0;
				}
				PositionQuestions();
				PositionYesNo();
			}
		}
		break;
	}  
}


function DoLoveConfessionAccepted()
{
	Diary.AddEntryLang("LoveConfessionAccepted");
	HideStatChangeIcons();
	GetSlaveInformation(PersonIndex);
	HideImages();
	AppendActText = true;
	UseGeneric = false;
	if (PersonIndex == -50) {
		LoveAccepted = 1;
		MaxObedience = SlaveStatistics.CapMax(MaxObedience, 5, AssistantMaxObedience);
		Icons.SetLoveIcon(_root);
		if (SlaveGirl.ShowLoveAccepted() == true) return;
		if (Language.IsTextShown()) AppendActText = false;
	} else {
		sdata.LoveAccepted = 1;
		sdata.MaxObedience = SlaveStatistics.CapMax(sdata.MaxObedience, 5, AssistantMaxObedience);
		sdata.ShowActImage(10028);
		if (sdata.SlaveType == -1) sdata.SlaveType = 2;
	}
	PointsByIndex(PersonIndex, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 10, 10, 0);
	if (UseGeneric) {
		UseGeneric = false;
		if (PersonIndex == -50) SlaveGirl.ShowChoreDiscuss();
		else sdata.ShowActImage(1004);
		if (UseGeneric) ShowSlave(sdata, 1, 1);
		AutoAttachAndShowMovie("Hearts (Movie)", 1, 1, 1, DummyClip);
		SetText("");	// remove any text from discuss act
		AppendActText = true;
	}
	XMLData.XMLGeneralSA("Other/LoveConfessionAccepted", false, GetSlaveObjectXML(sdata));
	if (IsEventAllowable()) DoEvent(9999);
}

function DoLoveConfessionRefused()
{
	Diary.AddEntryLang("LoveRefused");
	GetSlaveInformation(PersonIndex);
	HideStatChangeIcons();
	HideImages();
	AppendActText = true;
	UseGeneric = false;
	if (PersonIndex == -50) {
		SlaveGirl.ShowLoveRefused();
		if (Language.IsTextShown()) AppendActText = false;
	} else {
		sdata.ShowActImage(10035);
		if (UseGeneric) sdata.ShowActImage(10029);
	}
	if (UseGeneric) {
		UseGeneric = false;
		if (PersonIndex == -50) SlaveGirl.ShowChoreDiscuss();
		else sdata.ShowActImage(1004);
		if (UseGeneric) ShowSlave(sdata, 1, 1);
		AutoAttachAndShowMovie("Hearts (Movie)", 1, 1, 2, DummyClip);
	}
	if (PersonIndex == -50) LoveAccepted = 2;
	else sdata.LoveAccepted = 2;

	XMLData.XMLGeneralSA("Other/LoveConfessionRefused", false, GetSlaveObjectXML(sdata));

	if (IsEventAllowable()) DoEvent(9999);
}

function DoLoveConfessionUnsure()
{
	Diary.AddEntryLang("LoveUnsure");
	GetSlaveInformation(PersonIndex);
	HideStatChangeIcons();
	HideImages();
	UseGeneric = false;
	if (PersonIndex == -50) {
		if (SlaveGirl.ShowLoveUnsure() != true) SlaveGirl.ShowLoveRefused();
	} else sdata.ShowActImage(10026);
	if (UseGeneric) {
		UseGeneric = false;
		if (PersonIndex == -50) SlaveGirl.ShowChoreDiscuss();
		else sdata.ShowActImage(1004);
		if (UseGeneric) ShowSlave(sdata, 1, 1);
		AutoAttachAndShowMovie("Hearts (Movie)", 1, 1, 2, DummyClip);
	}
	if (PersonIndex == -50) LoveAccepted = 0;
	else sdata.LoveAccepted = 0;

	if (!Language.IsTextShown()) AppendActText = true;
	XMLData.XMLGeneralSA("Other/LoveConfessionUnsure", false, GetSlaveObjectXML(sdata));
	if (IsEventAllowable()) DoEvent(9999);

}


// Noble Love

function NobleLoveEvent(noble:Number, allowoffer:Boolean)
{
	if (NobleLoveType != noble && NobleLoveType != -1) return;
	
	if (NobleLove >= 0) NobleLove++;
	genNumber = allowoffer == true ? 1 : 0;
	VisitLendPerson = noble;
	
	SlaveGirl.NobleLove(allowoffer);
	XMLData.XMLGeneral("Other/NobleLove", false, GetSlaveObjectXML(slaveData));
}

function SellToNoble()
{
	HideStatChangeIcons();
	HideImages();
	HideBackgrounds();
	HidePeople();
	//PersonName = "";
	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0, -10, -10, 0);
	XMLData.XMLGeneralSA("Other/NobleLoveAccepted", false, GetSlaveObjectXML(slaveData));
	BlankLine();
	SlaveGirl.ShowNobleLoveAccepted();
	NobleLove = -2;
	Owner.ChangeOwner(NobleLoveType);
	
}

function RefuseSaleToNoble()
{
	HideStatChangeIcons();
	HideImages();
	HideBackgrounds();
	HidePeople();
	SlaveGirl.ShowNobleLoveRefused();
	XMLData.XMLGeneralSA("Other/NobleLoveRefused", false, GetSlaveObjectXML(slaveData));
	NobleLove = -1;
	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 2, 0);
	if (!Plannings.IsStarted()) DoEvent(9999);
}
