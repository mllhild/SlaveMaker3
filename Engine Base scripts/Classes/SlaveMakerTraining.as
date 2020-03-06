// SlaveMaker training
//
// Translation status: IMCOMPLETE
//

import Scripts.Classes.*;

class SlaveMakerTraining extends TrainingBase
{
	public function SlaveMakerTraining(cgm:Object)
	{
		super(null, cgm);
		ModuleName = "SlaveMakerTraining";
	}
	
	
	// Nothing
	
	public function DoSlaveMakerNothing()
	{
		// Rest
		var firstact:PlanningAction = coreGame.Plannings.arPlanningArray[0];
		var tm:Number = firstact.PlanningDuration;
		var rest:Number = coreGame.currentCity.Home.hWards > 0 ? -5 : -4;
		rest = rest * tm;
		if (isNaN(rest)) return;
		var lib:Number = 0;
		if (SMData.SMLust > 40 && coreGame.IsSexPlanningTime()) lib = Math.floor(SMData.SMLust/10);
		SMData.SMPoints(0, 0, 0, 0, 0, lib, 0, 0, 0, 0, 0, 0, rest);
	}
	
	
	// Pray
	
	public function DoPrayAtChurch()
	{
		SMData.TotalSMPray++;
		
		if (Language.XMLData.DoXMLAct("PrayAtChurch")) return;
		
		SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1);
		if (SMData.SMFaith == 2) {
			SMData.SMPoints(0, 0, 0, 0, 0, 1, -3);
			Backgrounds.ShowRuinedTemple(1);
			if (SMData.ShowSlaveMaker(-2502, 1, 1) == undefined) { 
				if (slrandom(3) < 3) {
					coreGame.Generic.mcBase.SMTrainingPray.gotoAndStop(4);
					coreGame.Generic.mcBase.SMTrainingPray._visible = true;
				} else ShowPerson(24, 1, 1, 7);
			}
			AddText("You visit a secret place in the ruined temple to meet a priestess of the old gods and some followers. She is dressed as a nun of the new order, but she reveals her lower clothes and exposes herself and her dedication to the passionate ways of the old, true gods.\r\rYou make offerings, dance, drink, eat and celebrate the joy of the life the gods have given you. The priestess and her followers happily celebrate with you and she tells you tales of the ways of the gods. You will tell #slave some of these stories later.");
			coreGame.modulesList.eventsSM.LearnOldGods();
			coreGame.modulesList.AfterMeetPerson(24, 0, "pray");
		} else if (SMData.SMFaith == 1) {
			SMData.SMPoints(0, 0, 0, 0, 0, -2, -3);
			AddText("You visit a church and pray there. After you talk with a nun about the ways of the gods.");
			if (SMData.ShowSlaveMaker(-2502, 1, 1) == undefined) { 
				coreGame.Generic.mcBase.SMTrainingPray.gotoAndStop(Math.floor(Math.random()*3) + 1);
				coreGame.Generic.mcBase.SMTrainingPray._visible = true;
			}
			coreGame.modulesList.eventsSM.LearnNewGods();
			coreGame.modulesList.AfterMeetPerson(24, 0, "pray");
		} else {
			SMData.SMPoints(0, 0, 0, 0, 0, -2, -3);
			AddText("You retreat to a private place and meditate on the nature of good, evil and of ethics.");
			if (SMData.ShowSlaveMaker(-2502, 1, 1) == undefined) { 
				if (SMData.Gender == 1) coreGame.Generic.mcBase.SMTrainingMeditation.gotoAndStop(Math.floor(Math.random()*2) + 2);
				else coreGame.Generic.mcBase.SMTrainingMeditation.gotoAndStop(1);
				coreGame.Generic.mcBase.SMTrainingMeditation._visible = true;
			}
			if (SMData.Corruption > 0) {
				if (SMData.SMSpecialEvent == 6) AddText("\r\rInitially you find it difficult to meditate, your thoughts keep turning to your father.");
				else if (SMData.SMSpecialEvent == 5) AddText("\r\rYour cock becomes intensely erect for a time as you meditate.");
			}
		}
	}
	
	// Relax in a Bar
	public function DoRelaxAtBar()
	{
		if (SMData.ShowSlaveMaker(-2503, 1, 1) == undefined) coreGame.Generic.ShowMovie("SMTrainingBar", 1.1, 2, 1);
		Language.XMLData.DoXMLAct("RelaxAtBar");
	}
	
	
	
	// Job
	public function DoSMJob(job:Number)
	{
		SMData.TotalSMJob++;
		
		if (!coreGame.currentCity.DoSMJob(job)) {
		
			switch(job) {
				case 0: 
					// Work for Guild
					coreGame.Pay = Math.ceil(SMData.sSlaveTrainer * SMData.SMReputation / 5);
					if (Language.XMLData.DoXMLAct("SMJobGuild")) return;
					if (SMData.AutoShowSlaveMaker(-2509, 1, 1) == undefined) { 
						coreGame.Generic.mcBase.SMJobGuild.gotoAndStop(slrandom(6));
						coreGame.Generic.mcBase.SMJobGuild._visible = true;
					}
					SMData.SMPoints(0, 0, 0, 0, 1, -1, 0, 0, 0.5, 0, 0, 0.5, 2);
					SetText("You work for a time for a fellow member of the Slave Maker Guild assisting with particular trainings of their slave.");
					break;
		
				case 1: 
					// Cock Milking
					coreGame.Pay = int(0.2 * (SMData.SMConstitution + SMData.SMLust));
					if (Language.XMLData.DoXMLAct("SMJobCockMilking")) return;
					ShowPerson(16, 1, -3, 1);
					if (SMData.AutoShowSlaveMaker(-2518, 1, 1) == undefined) coreGame.Generic.ShowJobCockMilking();
					SMData.SMPoints(0, 0, 0, 1, 0, -10, 0, 0, -1, 0, 0, 2, 5);
					AddText("You go and visit #personcockmilker to be milked to orgasm after orgasm, cumming huge gouts of cum.\r\r#personcockmilker pays you a percentage of your 'work'.");
					break;
					
				case 2: 
				case 3: 
					// Work in Brothel
					coreGame.Pay = Math.ceil((SMData.SMLust + SMData.SMConstitution + SMData.SMNymphomania) / 6);
					if (Language.XMLData.DoXMLAct("SMJobBrothel")) return;
					Backgrounds.ShowBedRoom();
					var mc = SMData.AutoShowSlaveMaker(-2519, 1, 1);
					if (mc == undefined) {
						if (SMData.Gender == 1) temp = slrandom(2) + 5;
						else temp = slrandom(5);
						coreGame.Generic.ShowMovie("SMJobBrothel", 1, 1, temp);
					}
					if (SMData.SMAdvantages.CheckBitFlag(4)) SetText("You spend a time working in a brothel serving customers, really, really enjoying yourself.");
					else SetText("You spend a time working in your brothel serving customers, rather enjoying yourself.");
					SMData.SMPoints(0, 0, 0, 0, 0, -5, 0, 0, -1, 0, 0, 2, 4);
		
					break;
					
				case 4: 
					// Trade
					coreGame.Pay = Math.ceil(SMData.sTrader * SMData.SMConversation / 5);
					if (Language.XMLData.DoXMLAct("SMJobTrade")) return;
					if (SMData.AutoShowSlaveMaker(-2520, 1, 1) == undefined) AutoLoadImageAndShowMovie("Images/Events/Event - Travelling Merchant 1.jpg", 1, 0);
					SetText("You rent a stall and sell small items and spend a lot of time chatting and bargaining.");
					SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 1);
					break;
					
				case 5: 
					// Dominatrix
					coreGame.Pay = Math.ceil(0.25 * (SMData.SMDominance + SMData.sWhipExpertise));
					if (Language.XMLData.DoXMLAct("SMJobDominatrix")) return;
					Backgrounds.ShowBar();
					if (SMData.AutoShowSlaveMaker(-2521, 1, 1) == undefined) {
						if (SMData.Gender == 3) temp = slrandom(2) + 3;
						if (SMData.Gender == 1) temp = slrandom(2) + 5;
						else temp = slrandom(3);
						ShowMovie(coreGame.Generic.mcBase.SMJobDominatrix, 1, 1, temp);
					}
					SetText("You whip and beat your customers, forcing them to ");
					if (SMData.Gender == 2) AddText("lick your pussy");
					else AddText("suck your cock");
					AddText(" while causing them pain. Their climax is not something you try to help them with, but still they orgasm under your cruel touches.");
					SMData.SMPoints(0, 0, 0, 0, 0, -3, 0, 0, 2, 0, -0.5, 1, 3);
					break;
					
				case 6: 
					// Make Potions
					coreGame.Pay = Math.ceil(SMData.sAlchemy * SMData.SMConversation / 6);
					if (Language.XMLData.DoXMLAct("SMJobMakePotions")) return;
					if (SMData.AutoShowSlaveMaker(-2522, 1, 1) == undefined) {
						coreGame.Generic.mcBase.SMJobPotions.gotoAndStop(1);
						coreGame.Generic.mcBase.SMJobPotions._visible = true;
					}
					SMData.SMPoints(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1);
					SetText("You setup in a stall in the market and sell potions to your fellow slave makers and the general public.");
					break;
					
				case 7: 
					// Preach Old Faith
					coreGame.Pay = Math.ceil(0.25 * (SMData.SMLust + SMData.SMConversation));
					if (Language.XMLData.DoXMLAct("SMJobPreachOldFaith")) return;
					if (SMData.AutoShowSlaveMaker(-2523, 1, 1) == undefined) {
						coreGame.Generic.mcBase.SMJobPagan.gotoAndStop(slrandom(2));
						coreGame.Generic.mcBase.SMJobPagan._visible = true;
					}
					SMData.SMPoints(0, 0, 0, 0, 1, -1, -1, 0, 0, 0, 0, 0, 2);
					SetText("You visit a private area in the Ruins and preach the ways of the Old Faith to small gatherings of the faithful. You are paid small tithes and donations.");
					break;
					
				case 8: 
					// Militia
					var mod:Number = SMData.sBowExpertise;
					if (SMData.sSwordExpertise > mod) mod = SMData.sSwordExpertise;
					if (SMData.sHammerExpertise > mod) mod = SMData.sHammerExpertise;
					if (SMData.sNaginataExpertise > mod) mod = SMData.sNaginataExpertise;
					if (SMData.sDaggerExpertise > mod) mod = SMData.sDaggerExpertise;
					if (SMData.sCrossbowExpertise > mod) mod = SMData.sCrossbowExpertise;
					if (SMData.sWhipExpertise > mod) mod = SMData.sWhipExpertise;
					if (SMData.sUnarmedExpertise > mod) mod = SMData.sUnarmedExpertise;
					coreGame.Pay = Math.ceil(0.25 * (mod + SMData.SMConstitution));
					if (Language.XMLData.DoXMLAct("SMJobMilitia")) return;
					if (SMData.AutoShowSlaveMaker(-2524, 1, 1) == undefined) {
						coreGame.Generic.mcBase.SMJobMilitia.gotoAndStop(slrandom(2));
						coreGame.Generic.mcBase.SMJobMilitia._visible = true;
					}
					SMData.SMPoints(0.5, 0.5, 0, 0.2, 0, 0, 0, 0, 0.1, 0, 0, 0, 3);
					SetText("You work a shift in the militia patrolling the city and arresting criminals.");
					break;
					
				case 9:
					// Sleazy Bar
					coreGame.Pay = Math.ceil((SMData.SMLust + SMData.SMConstitution + SMData.SMCharisma) / 6);
					if (Language.XMLData.DoXMLAct("SMJobSleazyBar")) return;
					if (SMData.AutoShowSlaveMaker(-2525, 1, 1) == undefined) ShowMovie(coreGame.Generic.mcBase.SMJobSleazyBar, 1, 1, slrandom(4));
					SetText("You entertain customers in the sleazy bar, dancing and flirting. Whenever a customer expresses the slightest interest in you, you quite happliy entertain them intimately.");
					SMData.SMPoints(0, 0, 0, 0.5, 0, -3, 0, 0, -0.25, 0.5, -0.5, 1, 4);
					break;
			}
		
		}
		coreGame.Pay = coreGame.SMEarnMoney(coreGame.Pay);
		AddText("\r\rYou earn #paygp.");
	
		coreGame.FirstTimeTodaySMJob = true;
	}

	// Attend Court
	
	public function DoAttendCourt() 
	{	
		//trace("DoAttendCourt");
		if (SMData.AutoShowSlaveMaker(-2504, 1.1, 1) == undefined) {
			coreGame.Generic.mcBase.SMTrainingCourt.gotoAndStop(1);
			coreGame.Generic.mcBase.SMTrainingCourt._visible = true;
		}
	
		SMData.TotalSMCourt++;
		coreGame.EventTotal = SMData.TotalSMCourt;
		
		if (Language.XMLData.XMLEventCached("DoAttendCourt")) return true;
		Language.XMLData.DoXMLAct("AttendCourt");
	}
		
		
	public function AttendCourtLord()
	{
		//trace("AttendCourtLord");
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 2);
		if (coreGame.VarReputationRounded < 61) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0);
	
		Language.XMLData.PickAndDoXMLEvent("/Visits/VisitLord/GeneralMeetings");
	}
	
	public function AttendCourtAmbassadors()
	{
		if (!SMData.BitFlagSM.CheckBitFlag(17)) {
			SMData.BitFlagSM.SetBitFlag(17);
			Language.XMLGeneral("Visits/VisitAmbassadors/VisitIntroduction");
			BlankLine();
		}
	
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 2);
		if (coreGame.VarReputationRounded < 61) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0);
		if (PercentChance(25) || !coreGame.Tachiba.IsMet()) {
			AttendCourtTachiba();
			return;
		}
		Language.XMLData.PickAndDoXMLEvent("/Visits/VisitAmbassadors/GeneralMeetings");
	}
	
	public function AttendCourtGuildMembers()
	{
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 2);
		if (coreGame.VarReputationRounded < 61) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0);
		Language.XMLData.PickAndDoXMLEvent("/Visits/VisitGuildMember/GeneralMeetings");
	}
	
	public function AttendCourtOtherNobles()
	{
		SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 2);
		if (coreGame.VarReputationRounded < 61) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0);
		Language.XMLData.PickAndDoXMLEvent("/Visits/VisitMinorNobles/GeneralMeetings");
	}
	
	
	public function AttendCourtTachiba()
	{
		coreGame.Tachiba.SetVisited();
		coreGame.Tachiba.Points(0, 2, 0, 0, 0);
		if (!coreGame.Tachiba.IsMet()) {
			Language.XMLGeneral("Visits/VisitAmbassadors/Tachiba/VisitIntroduction");
			coreGame.Tachiba.SetMet();
			coreGame.Tachiba.DoneInitialVisit();
			return;
		}
		Language.XMLData.PickAndDoXMLEvent("/Visits/VisitAmbassadors/Tachiba/GeneralMeetings");
	}
	
	
	// Special
	
	function DoMorningSpecial()
	{
		SMData.TotalSMSpecial++;
		if (SMData.SMAdvantages.CheckBitFlag(13)) {
			// Vampire Feeding
			coreGame.PersonIndex = -50;
			SMData.GetSlaveInformation(coreGame.PersonIndex);
			// display image only
			if (coreGame.VarFatigue < 60) {
				ShowMovie(coreGame.Generic.mcBase.VampireFeeding, 1, 2, slrandom(3));
				Backgrounds.ShowOverlay(0);
			}
			Language.XMLData.DoXMLAct("VampiricFeeding");
		}
	}

	
	// Custom Trainings
	
	public function SMCustomTraining(eventno:Number)
	{
		var actno:Number;
		if (eventno == undefined) eventno = 2516;
		else actno = eventno;
		var act:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(eventno);
		act.DoAct();
	}
	
	public function AddSMCustomTraining(slabel:String, hint:String, node) : Number
	{
		var xNode:XMLNode = null;
		var nname:String = "";
		if (typeof(node) == "string") nname = String(node);
		else if (node != undefined) {
			xNode = node;
			nname = xNode.nodeName;
		}
		if (nname == "") nname = "SMCustomTraining" + slabel.split(" ").join("");
		
		var actno:Number;
		trace("adding: " + nname + " defined:" + coreGame.slaveData.ActInfoBase.IsActDefinedByName(nname));
		if (coreGame.slaveData.ActInfoBase.IsActDefinedByName(nname)) actno = coreGame.slaveData.ActInfoBase.GetActByName(nname).Act;
		else actno = coreGame.slaveData.ActInfoBase.GetFreeAct(4);
		trace("actno = " + actno);
		var act:ActInfo = coreGame.slaveData.ActInfoBase.SetActDetails(actno, false, true, slabel, hint, "V", 0, 2);
		act.HideAct();
		act.Type = 4;
		if (hint != undefined) coreGame.SMCustomTrainingDescription = hint;
		if (nname != "" && act.strNodeName == "") act.strNodeName = nname;
		act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
		if (xNode != null) act.xNode = xNode;
		return actno;
	}
	
	public function SetSMCustomTrainingDetails(slabel:String, hint:String)
	{
		trace("setting: " + slabel + " defined:" + coreGame.slaveData.ActInfoBase.IsActDefinedByName(slabel));

		if (hint != undefined) coreGame.SMCustomTrainingDescription = hint;
		var act:ActInfo = coreGame.slaveData.ActInfoBase.SetActDetails(2516, false, true, slabel, hint, "V", 0, 2);
		act.HideAct();
		act.Type = 4;
		act.strNodeName = "SMCustomTraining";
		act.strNodeNameLNSP = act.strNodeName.toLowerCase().split(" ").join("");
	}
	
	public function ShowSMCustomTraining(num:Number, bshow:Boolean)
	{
		var actno:Number;
		if (num == undefined) num = 2516;
		else actno = num;
		if (bshow == undefined) bshow = true;
		coreGame.slaveData.ActInfoBase.GetActAbs(actno).ShowAct(bshow);
	
		coreGame.ShowSMCustomTrainingOK = bshow ? 1 : 0;
	}

	
	// Events
	
	public function DoEventNext() : Boolean
	{
		switch (coreGame.NumEvent) {
			
			// Slave Maker work in Sleazy Bar
			case 24:
				DoSMJob(9);
				return true;
				
			// Slave Maker work in Sleazy Bar
			case 24.1:
				coreGame.currentCity.DoRelaxSleazyBar();
				return true;
		}
		return false;
	}
	
	public function DoEventYes() : Boolean
	{
		switch (coreGame.NumEvent) {
			// tutored Martial training
			case 21:
			case 21.1:
				Language.SetLangText("MartialTraining", "SlaveMaker/Training");
				SMData.SMPoints(1, 1, 0, 0.5, 0, -1, 0, 0, 0, 0, 0, 0, 2, 0);
				SMData.TrainWeapon();
				SMMoney(-50);
				return true;
				
			// Slave Maker work in Sleazy Bar
			case 24:
				DoSMJob(9);
				return true;
		}
		return false;
	}
	
	public function DoEventNo() : Boolean
	{
		switch (coreGame.NumEvent) {

			// refuse tutored Martial training
			case 21:
				Language.SetLangText("RefuseMartialTraining", "SlaveMaker/Training");
				return true;
				
			case 21.1:
				Language.SetLangText("MartialTrainingAlone", "SlaveMaker/Training");
				coreGame.Sounds.PlaySound("Clang");
				SMData.SMPoints(1, 1, 0, 0.5, 0, -1, 0, 0, 0, 0, 0, 0, 2, 0);
				Backgrounds.HideBackgrounds();
				coreGame.Generic.ShowMovie("SMTrainingMartial", 1.1, 1, slrandom(6));
				return true;
				
			// Slave Maker work in Sleazy Bar
			case 24:
				coreGame.currentCity.DoRelaxSleazyBar();
				return true;
		}
		return false;
	}	
	
}
