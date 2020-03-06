import Scripts.Classes.*;
// Slave Statistics

/*
Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
<Points>Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy</Points>
*/
function Points(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number, SexualEnergy:Number)
{	
	LimitMaxMinStats();
	UpdateFactors(_root, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special, Special2, SexualEnergy);

	if (Fatigue > 0) {
		if (FatigueBonus > 0) {
			var fact:Number = FatigueBonus;
			if (fact > 150) fact = 150;
			Fatigue = Fatigue / (1 + (fact / 150));
		}
		if (IsDressEasy()) Fatigue *= 0.75;
	}
	
	// Gender effects
	var sameg:Boolean = (SlaveGender == 1 && (SMData.Gender == 1 || SMData.Gender == 4));
	if (DickgirlLesbians) {
		if (SlaveGender == 2 && (SMData.Gender != 1 && SMData.Gender != 4)) sameg = true;
	} else {
		if (SMData.Gender == 2 && (SlaveGender != 1 && SlaveGender != 4)) sameg = true;
		else if (SMData.Gender == 3 && (SlaveGender != 3 && SlaveGender != 6)) sameg = true;
	}
	if (sameg) {
		if (LesbianTraining) Love *= 0.7;
		else Love *= 0.5;
	} else if (SMAdvantages.CheckBitFlag(20)) Love *= 0.5;
	
	// House/Advantages/Events Effects	
	if (SMAdvantages.CheckBitFlag(2)) Refinement *= 0.8;
	if (SMData.SMSpecialEvent == 5 || SMData.SMSpecialEvent == 7) Morality *= 0.6;
	if (SMAdvantages.CheckBitFlag(9)) Love *= 0.75;
	switch (Home.HouseType) {
		case 4:
			Cooking *= 0.8;
			Cleaning *= 0.8;
			Love *= 1.2;
			break;
	}
	if (SMAdvantages.CheckBitFlag(21) && SMData.Corruption < 1) Morality *= 1.1;
	
	// Skill Effects
	if (SMData.sLeadership > 0) Love *= (1 + (SMData.sLeadership * 0.1));
	
	Charisma *= CharismaFactor;
	Sensibility *= SensibilityFactor;
	Refinement *= RefinementFactor;
	Intelligence *= IntelligenceFactor;
	Constitution *= ConstitutionFactor;
	Morality *= MoralityFactor;
	Cooking *= CookingFactor;
	Cleaning *= CleaningFactor;
	Conversation *= ConversationFactor;
	BlowJob *= BlowjobFactor;
	Fuck *= FuckFactor;
	Temperament *= TemperamentFactor;
	Nymphomania *= NymphomaniaFactor;
	Obedience *= ObedienceFactor;
	Lust *= LibidoFactor;
	Reputation *= dmod;
	Fatigue *= FatigueFactor;
	Joy *= JoyFactor;
	Love *= dmod;
	if (!isNaN(Special)) Special *= SpecialFactor;
	if (!isNaN(Special2)) Special2 *= Special2Factor;
	
	if (IsDisplayed()) ShowStatIcons(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Special, Special2, SexualEnergy);
	
	VarCharisma += Charisma;
	VarSensibility += Sensibility;
	VarRefinement += Refinement;
	VarIntelligence += Intelligence;
	VarMorality += Morality;
	VarConstitution += Constitution;
	VarCooking += Cooking;
	VarCleaning += Cleaning;
	VarConversation += Conversation;
	if (LesbianTraining) {
		VarCunnilingus += BlowJob;
		VarLesbianFuck += Fuck;
	} else {
		VarBlowJob += BlowJob;
		VarFuck += Fuck;
	}
	VarTemperament += Temperament;
	VarNymphomania += Nymphomania;
	VarObedience += Obedience;
	VarLibido += Lust;
	VarReputation += Reputation;
	VarFatigue += Fatigue;
	VarJoy += Joy;
	VarLovePoints += Love;
	if (!isNaN(Special)) VarSpecial += Special;
	if (!isNaN(Special2)) VarSpecial2 += Special2;

	UpdateSlave();
}


function PointsByIndex(idx:Number, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, Special2:Number, SexualEnergy:Number)
{
	if (idx == -50) Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
	else if (idx == -100) SMData.SMPoints(0, 0, 0, Constitution, Conversation, Lust, 0, Reputation, Obedience * -1, Charisma, Refinement, Nymphomania, Fatigue, SexualEnergy);
	else if (idx == -99) AssistantData.Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
	else SlavesArray[idx].Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Fatigue, Joy, Love, Special, Special2, SexualEnergy);
}
	
function SetFactors(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, Special2:Number, fSexualEnergy:Number, fSexuality:Number)
{
	//trace("SetFactors: " + Cooking);
	if (!isNaN(Charisma)) CharismaFactor *= Charisma;
	if (!isNaN(Morality)) MoralityFactor *= Morality;
	if (!isNaN(Obedience)) ObedienceFactor *= Obedience;
	if (!isNaN(Morality)) MoralityFactor *= Morality;
	if (!isNaN(Cooking)) CookingFactor *= Cooking;
	if (!isNaN(Cleaning)) CleaningFactor *= Cleaning;
	if (!isNaN(Conversation)) ConversationFactor *= Conversation;
	if (!isNaN(Fatigue)) FatigueFactor *= Fatigue;
	if (!isNaN(BlowJob)) BlowjobFactor *= BlowJob;
	if (!isNaN(Fuck)) FuckFactor *= Fuck;
	if (!isNaN(Nymphomania)) NymphomaniaFactor *= Nymphomania;
	if (!isNaN(Lust)) LibidoFactor *= Lust;
	if (!isNaN(Sensibility)) SensibilityFactor *= Sensibility;
	if (!isNaN(Refinement)) RefinementFactor *= Refinement;
	if (!isNaN(Intelligence)) IntelligenceFactor *= Intelligence;
	if (!isNaN(Constitution)) ConstitutionFactor *= Constitution;
	if (!isNaN(Temperament)) TemperamentFactor *= Temperament;
	if (!isNaN(Joy)) JoyFactor *= Joy;
	if (!isNaN(Special)) SpecialFactor *= Special;
	if (!isNaN(Special2)) Special2Factor *= Special2;
	if (!isNaN(fSexualEnergy)) SexualEnergyFactor *= fSexualEnergy;
	if (!isNaN(fSexuality)) SexualityFactor *= fSexuality;
}

function UpdateFactors(sd:Object, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, Special2:Number, fSexualEnergy:Number, fSexuality:Number)
{
	if (sd == undefined) sd = _root;
	
	var mod:Number = dmod * StatRate;
	if (sd == _root) mod = mod * slaveData.GetBloodFactor();
	else mod = mod * sd.GetBloodFactor();
	var nmod:Number = modSlaveTrainer > 1 ? 1 - int(modSlaveTrainer - 1) * 0.1 : 1;
	if (SMData.IsMaranOwned()) mod *= 1.05;
	CharismaFactor = Charisma < 0 ? nmod * mod : mod;
	MoralityFactor = Morality < 0 ? nmod * mod : mod;
	ObedienceFactor = Obedience < 0 ? nmod * mod : mod;
	if (SMData.IsSomaOwned()){
		ObedienceFactor *= 0.95;
		if (SMData.SMFaith != 2) MoralityFactor *= 1.1;
	}
	if (sd == _root) {
		if (sd.IsDressHoly()) MoralityFactor *= 1.1;
		else if (sd.IsDressDemonic()) MoralityFactor *= 0.9;
	}
	CookingFactor = Cooking < 0 ? nmod * mod : mod;
	CleaningFactor = Cleaning < 0 ? nmod * mod : mod;
	ConversationFactor = Conversation < 0 ? nmod * mod : mod;
	if (Fatigue > 0 && !isNaN(Fatigue)) FatigueFactor = dmod;
	else FatigueFactor = mod;
	BlowjobFactor = BlowJob < 0 ? nmod * mod : mod;
	FuckFactor = Fuck < 0 ? nmod * mod : mod;
	NymphomaniaFactor = Nymphomania < 0 ? nmod * mod : mod;
	LibidoFactor = mod;
	SensibilityFactor = Sensibility < 0 ? nmod * mod : mod;
	RefinementFactor = Refinement < 0 ? nmod * mod : mod;
	var effref:Number = sRefined;
	if (AssistantData.sRefined > effref) effref = AssistantData.sRefined;
	if (effref > 0) RefinementFactor = RefinementFactor * (1 + (effref * 0.5));
	IntelligenceFactor = Intelligence < 0 ? nmod * mod : mod;
	ConstitutionFactor = Constitution < 0 ? nmod * mod : mod;
	TemperamentFactor = Temperament < 0 ? nmod * mod : mod;
	JoyFactor = Joy < 0 ? nmod * mod : mod;
	if (isNaN(Special)) SpecialFactor = mod;
	else SpecialFactor = Special < 0 ? nmod * mod : mod;
	if (isNaN(Special2)) Special2Factor = mod;
	else Special2Factor = Special2 < 0 ? nmod * mod : mod;
	if (isNaN(fSexualEnergy)) SexualEnergyFactor = mod;
	else SexualEnergyFactor = fSexualEnergy < 0 ? nmod * mod : mod;
	if (isNaN(fSexuality)) SexualityFactor = mod;
	else SexualityFactor = fSexuality < 0 ? nmod * mod : mod;

	if (sd.Deficiency != 0) {
		switch(sd.Deficiency) {
			case 1: CharismaFactor *= 0.5; break;
			case 2: SensibilityFactor *= 0.5; break;
			case 3: RefinementFactor *= 0.5; break;
			case 4: IntelligenceFactor *= 0.5; break;
			case 5: MoralityFactor *= 0.5; break;
			case 6: ConstitutionFactor *= 0.5; break;
			case 7: CookingFactor *= 0.5; break;
			case 8: CleaningFactor *= 0.5; break;
			case 9: ConversationFactor *= 0.5; break;
			case 10: BlowjobFactor *= 0.5; break;
			case 11: FuckFactor *= 0.5; break;
			case 12: TemperamentFactor *= 0.5; break;
			case 13: NymphomaniaFactor *= 0.5; break;
			case 14: ObedienceFactor *= 0.5; break;
			case 15: LibidoFactor *= 0.5; break;
			case 16: FatigueFactor *= 0.5; break;
			case 17: JoyFactor *= 0.5; break;
			case 19: SpecialFactor *= 0.5; break;
			case 20: BlowjobFactor *= 0.5; FuckFactor *= 0.5; break;
			case 21: LibidoFactor *= 0.5; NymphomaniaFactor *= 0.5; break;
			case 22: SexualEnergyFactor *= 0.5; break;
			case 23: Special2Factor *= 0.5; break;
			case 25: SexualityFactor *= 0.5; break;
		}
	}
	if (AssistantData.Deficiency != 0) {
		switch(AssistantData.Deficiency) {
			case 1: CharismaFactor *= 0.8; break;
			case 2: SensibilityFactor *= 0.8; break;
			case 3: RefinementFactor *= 0.8; break;
			case 4: IntelligenceFactor *= 0.8; break;
			case 5: MoralityFactor *= 0.8; break;
			case 6: ConstitutionFactor *= 0.8; break;
			case 7: CookingFactor *= 0.8; break;
			case 8: CleaningFactor *= 0.8; break;
			case 9: ConversationFactor *= 0.8; break;
			case 10: BlowjobFactor *= 0.8; break;
			case 11: FuckFactor *= 0.8; break;
			case 12: TemperamentFactor *= 0.8; break;
			case 13: NymphomaniaFactor *= 0.8; break;
			case 14: ObedienceFactor *= 0.8; break;
			case 15: LibidoFactor *= 0.8; break;
			case 16: FatigueFactor *= 0.8; break;
			case 17: JoyFactor *= 0.8; break;
			case 19: SpecialFactor *= 0.8; break;
			case 20: BlowjobFactor *= 0.8; FuckFactor *= 0.8; break;
			case 21: LibidoFactor *= 0.8; NymphomaniaFactor *= 0.8; break;
			case 22: SexualEnergyFactor *= 0.8; break;
			case 23: Special2Factor *= 0.8; break;
			case 25: SexualityFactor *= 0.8; break;
		}
	}
	
	if (sd.NaturalTalent != 0) {
		switch(sd.NaturalTalent) {
			case 1: CharismaFactor *= 1.5; break;
			case 2: SensibilityFactor *= 1.5; break;
			case 3: RefinementFactor *= 1.5; break;
			case 4: IntelligenceFactor *= 1.5; break;
			case 5: MoralityFactor *= 1.5; break;
			case 6: ConstitutionFactor *= 1.5; break;
			case 7: CookingFactor *= 1.5; break;
			case 8: CleaningFactor *= 1.5; break;
			case 9: ConversationFactor *= 1.5; break;
			case 10: BlowjobFactor *= 1.5; break;
			case 11: FuckFactor *= 1.5; break;
			case 12: TemperamentFactor *= 1.5; break;
			case 13: NymphomaniaFactor *= 1.5; break;
			case 14: ObedienceFactor *= 1.5; break;
			case 15: LibidoFactor *= 1.5; break;
			case 16: FatigueFactor *= 1.5; break;
			case 17: JoyFactor *= 1.5; break;
			case 19: SpecialFactor *= 1.5; break;
			case 20: BlowjobFactor *= 1.5; FuckFactor *= 1.5; break;
			case 21: LibidoFactor *= 1.5; NymphomaniaFactor *= 1.5; break;
			case 22: SexualEnergyFactor *= 1.5; break;
			case 23: Special2Factor *= 1.5; break;
			case 25: SexualityFactor *= 1.5; break;
		}
	}
	if (AssistantData.NaturalTalent != 0) {
		switch(AssistantData.NaturalTalent) {
			case 1: CharismaFactor *= 1.2; break;
			case 2: SensibilityFactor *= 1.2; break;
			case 3: RefinementFactor *= 1.2; break;
			case 4: IntelligenceFactor *= 1.2; break;
			case 5: MoralityFactor *= 1.2; break;
			case 6: ConstitutionFactor *= 1.2; break;
			case 7: CookingFactor *= 1.2; break;
			case 8: CleaningFactor *= 1.2; break;
			case 9: ConversationFactor *= 1.2; break;
			case 10: BlowjobFactor *= 1.2; break;
			case 11: FuckFactor *= 1.2; break;
			case 12: TemperamentFactor *= 1.2; break;
			case 13: NymphomaniaFactor *= 1.2; break;
			case 14: ObedienceFactor *= 1.2; break;
			case 15: LibidoFactor *= 1.2; break;
			case 16: FatigueFactor *= 1.2; break;
			case 17: JoyFactor *= 1.2; break;
			case 19: SpecialFactor *= 1.2; break;
			case 20: BlowjobFactor *= 1.2; FuckFactor *= 1.2; break;
			case 21: LibidoFactor *= 1.2; NymphomaniaFactor *= 1.2; break;
			case 22: SexualEnergyFactor *= 1.2; break;
			case 23: Special2Factor *= 1.2; break;
			case 25: SexualityFactor *= 1.2; break;
		}
	}
	
	CurrentAssistant.ApplyDifficultyAsAssistant(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special, Special2, SexualEnergy, Sexuality);

	if (sd == _root) modulesList.ApplyDifficulty(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special, Special2, SexualEnergy, Sexuality);
}


var bInUS:Boolean = false;
function UpdateSlave(sd:Object) {	
	if (bInUS) return;
	if (sd != undefined && sd != slaveData && sd != _root) {
		if (sd.IsDisplayed()) UpdateSlaveCommon(sd);
		else sd.LimitAllStats();
		return;
	}
	
	bInUS = true;
	if (VarGold < 0 || isNaN(VarGold)) VarGold = 0;
	LesbianTraining = BitFlag1.CheckBitFlag(10);
	LimitAllStats();
	dspMain.UpdateSlaveGender();
	UpdateOtherSlaveDetails();
		
	modulesList.UpdateSlave();
	bInUS = false;
}

function UpdateSlaveCommon(sd:Object)
{
	OtherSlaveShown = (sd != _root && sd != slaveData);
	sd.LimitAllStats();
	dspMain.UpdateSlaveGender(sd);
	dspMain.UpdateOtherSlaveDetailsCommon(sd);
}

function UpdateOtherSlaveDetails()
{	
	dspMain.UpdateMoney();
	
	Aroused = (DemonicBraWorn == 1 || DemonicPendantWorn == 1 || VibratorPantiesWorn == 1 || VarLibidoRounded > 25);
	DoneCourtesan = slCourtesan == 100;
	Naked = DressWorn < 0;
	Catgirl = BitFlag1.CheckBitFlag(15) || BitFlag1.CheckBitFlag(45); // inlined IsCatgirl
	
	if (PregnancyType == "Tentacle") TentaclePregnancy = PregnancyGestation;
	SlaveGirl.Lesbian = Lesbian;
	SlaveGirl.LesbianTraining = LesbianTraining;
	SlaveGirl.Aroused = Aroused;
	SlaveGirl.Naked = Naked;
	SlaveGirl.SlaveName = SlaveName;
	SlaveGirl.Trust = Trust;
	SlaveGirl.Elapsed = Elapsed;
	SlaveGirl.DickgirlXF = DickgirlXF;
	SlaveGirl.Catgirl = Catgirl;
	CurrentAssistant.SlaveName = SlaveName;
	CurrentAssistant.Elapsed = Elapsed;
	Generic.SetSlaveDetails(slaveData);
		
	dspMain.UpdateSexSkills();
	dspMain.UpdateBasicSlaveSkills();
	
	dspMain.UpdateOtherSlaveDetailsCommon();
	SlaveGirl.MaxPath = MaxPath;
	
	BiggerBoobs = int(vitalsBustCurrent + 0.9) > int(vitalsBustStart * 1.1);
}

function RenameStatistic(stat:String, newname:String)
{
	var mc:MovieClip = dspMain.GetStatClipString(stat);
	if (mc == null) return;
	mc.StatLabel.text = newname;
	mc.BGStatLabel.text = newname;
}

// Experience

var SlaveExperience:Number = 0;
var SlaveActs:Number = 0;
var SlaveActsIdx:Number = 0;
var arSlaveActs:Array;
function CalcExperience(total:Number, desc:String)
{
	SlaveActs++;
	if (total < 0 || total > 0.01) SlaveExperience++;
	else arSlaveActs.push(new String(desc));
}
function CalcExperienceLang(total:Number)
{
	SlaveActs++;
	if (total < 0 || total > 0.01) {
		SlaveExperience++;
		return;
	}
	
	SlaveActsIdx++;
	var str:String = "";
	var eNode:XMLNode = XMLData.GetNodeC(Language.flNode, "Experiences");
	var i:Number = 0;
	for (; eNode != null; eNode = eNode.nextSibling) {
		if (eNode.nodeType != 1 || eNode.nodeName != "Experience") continue;
		i++;
		if (i == SlaveActsIdx) {
			str = UpdateMacros(eNode.firstChild.nodeValue);
			break;
		}
	}
	if (str != "") arSlaveActs.push(new String(str));
}

function ExperienceTotal(drugs:Boolean, sd:Object) : Number
{ 
	if (sd == undefined) sd = _root;
	SlaveActs = 0;
	SlaveActsIdx = 0;
	SlaveExperience = 0;
	delete arSlaveActs;
	arSlaveActs = new Array();
	
	CalcExperienceLang(sd.TotalContestBeauty);
	CalcExperienceLang(sd.TotalContestCourt);
	CalcExperienceLang(sd.TotalContestHousework);
	CalcExperienceLang(sd.TotalContestHouseworkAdvanced);
	if (SMData.PonygirlAware >=0) CalcExperienceLang(sd.TotalContestPonygirl);
	else SlaveActsIdx++;
	CalcExperienceLang(sd.TotalContestXXX);
	CalcExperienceLang(sd.TotalContestDance);
	CalcExperienceLang(sd.TotalContestGeneralKnowledge);
	
	if (LesbianTraining) {
		CalcExperienceLang(sd.TotalBlowjob);
		CalcExperienceLang(sd.TotalFuck);
		CalcExperienceLang(sd.TotalLesbian);
		CalcExperienceLang(sd.TotalTitsFuck);
		SlaveActsIdx += 5;
	} else {
		SlaveActsIdx += 4;
		CalcExperienceLang(sd.TotalBlowjob);
		CalcExperienceLang(sd.TotalFuck);
		if (!SMData.IsDickgirlAmazon()) CalcExperienceLang(sd.TotalLesbian);
		else SlaveActsIdx++;
		CalcExperienceLang(sd.TotalTitsFuck);
		CalcExperienceLang(sd.TotalCumBath);
	}
	CalcExperienceLang(sd.TotalAnal);
	CalcExperienceLang(sd.TotalMasturbate);
	
	CalcExperienceLang(sd.TotalNaked);
	CalcExperienceLang(sd.TotalGangBang);
	CalcExperienceLang(sd.TotalTouch);
	CalcExperienceLang(sd.TotalLick);
	
	CalcExperienceLang(sd.TotalDildo);
	CalcExperienceLang(sd.TotalPlug);
	CalcExperienceLang(sd.TotalLendHer);
	if (BDSMOn == 1) CalcExperienceLang(sd.TotalBondage);
	else SlaveActsIdx++;
	CalcExperienceLang(sd.TotalSpank);
	CalcExperienceLang(sd.TotalThreesome);
	CalcExperienceLang(sd.Total69);
	CalcExperienceLang(sd.TotalGroup);
	CalcExperienceLang(sd.TotalKiss);
	CalcExperienceLang(sd.TotalStripTease);
	CalcExperienceLang(sd.TotalXXX);
	CalcExperienceLang(sd.TotalSleazyBar);
	CalcExperienceLang(sd.TotalSleazyBarService);
	CalcExperienceLang(sd.TotalOnsenService);
	CalcExperienceLang(sd.TotalExpose);
	CalcExperienceLang(sd.TotalBrothel);
	if (TentaclesOn == 1) CalcExperienceLang(sd.TotalTentacle);
	else SlaveActsIdx++;
	if (SMData.PonygirlAware >= 0) CalcExperienceLang(sd.TotalPony);
	else SlaveActsIdx++;
	CalcExperienceLang(sd.TotalAcolyte);
	CalcExperienceLang(sd.TotalRestaurant);
	CalcExperienceLang(sd.TotalBar);
	CalcExperienceLang(sd.TotalLibrary);
	CalcExperienceLang(sd.TotalOnsen);
	CalcExperienceLang(sd.TotalExercise);
	CalcExperienceLang(sd.TotalCooking);
	CalcExperienceLang(sd.TotalCleaning);
	CalcExperienceLang(sd.TotalBreak);
	CalcExperienceLang(sd.TotalDance);
	CalcExperienceLang(sd.TotalSciences);
	CalcExperienceLang(sd.TotalSinging);
	CalcExperienceLang(sd.TotalRefinement);
	CalcExperienceLang(sd.TotalTheology);
	CalcExperienceLang(sd.TotalDiscuss);
	CalcExperienceLang(sd.TotalMakeUp);
	
	CalcExperienceLang(sd.TotalMakeupCare);
	CalcExperienceLang(sd.TotalHairCare);
	CalcExperienceLang(sd.TotalSkinCare);
	
	CalcExperienceLang(sd.TotalTeddyBear);
	CalcExperienceLang(sd.TotalGames);
	CalcExperienceLang(sd.TotalJewelry);
	CalcExperienceLang(sd.TotalDoll);
	CalcExperienceLang(sd.TotalBooksRead);
	CalcExperienceLang(sd.TotalPoetryRead);
	CalcExperienceLang(sd.TotalScriptureRead);
	CalcExperienceLang(sd.TotalKamasutraRead);
	CalcExperienceLang(sd.FairyMeeting);
	CalcExperienceLang(sd.PiercingsType);
	CalcExperienceLang(sd.LingerieOK);
	CalcExperienceLang(sd.BunnySuitOK);
		
	if (Milkable) CalcExperienceLang(sd.TotalMilked);
	else SlaveActsIdx++;
	CalcExperienceLang(sd.DoneMaster);
	
	CalcExperienceLang(sd.PuppyGirlFlag);
	CalcExperienceLang(sd.VarSchoolGirl);
	
	if (DickgirlOn == 1) CalcExperienceLang(sd.PotionsUsed[0]);
	else SlaveActsIdx++;
	CalcExperienceLang(sd.PotionsUsed[1]);
	CalcExperienceLang(sd.PotionsUsed[2]);
	CalcExperienceLang(sd.PotionsUsed[3]);
	CalcExperienceLang(sd.PotionsUsed[4]);
	if (drugs) {
		CalcExperienceLang(sd.PotionsUsed[5]);
		CalcExperienceLang(sd.PotionsUsed[6]);
		CalcExperienceLang(sd.PotionsUsed[7]);
		CalcExperienceLang(sd.PotionsUsed[8]);
		CalcExperienceLang(sd.PotionsUsed[9]);
	} else SlaveActsIdx += 5;
	CalcExperienceLang(sd.PotionsUsed[10]);
	CalcExperienceLang(sd.PotionsUsed[11]);
	CalcExperienceLang(sd.PotionsUsed[12]);
	CalcExperienceLang(sd.PotionsUsed[13]);
	CalcExperienceLang(sd.PotionsUsed[14]);
	
	CalcExperienceLang(sd.TotalWalkBeach);
	CalcExperienceLang(sd.TotalWalkForest);
	CalcExperienceLang(sd.TotalWalkFarm);
	CalcExperienceLang(sd.TotalWalkPalace);
	CalcExperienceLang(sd.TotalWalkSlums);
	CalcExperienceLang(sd.TotalWalkLake);
	CalcExperienceLang(sd.TotalWalkTownCenter);
	CalcExperienceLang(sd.TotalWalkDocks);
	CalcExperienceLang(sd.TotalWalkRuins);
	CalcExperienceLang(sd.BitFlag1.CheckBitFlag(37) ? 1 : 0);
	CalcExperienceLang(sd.BitFlag1.CheckBitFlag(39) ? 1 : 0);
	CalcExperienceLang(sd.BitFlag1.CheckBitFlag(38) ? 1 : 0);
	CalcExperienceLang(sd.BitFlag1.CheckBitFlag(40) ? 1 : 0);
	CalcExperienceLang(sd.TotalVisitAstrid);

	if (sd == _root) {
		CalcExperienceLang(Prostitute.IsVisited() ? 1 : 0);
		CalcExperienceLang(HighClassProstitute.IsVisited() ? 1 : 0);
		CalcExperienceLang(Barmaid.IsVisited() ? 1 : 0);
		CalcExperienceLang(Maid.IsVisited() ? 1 : 0);
		CalcExperienceLang(Merchant.IsVisited() ? 1 : 0);
		CalcExperienceLang(Knight.IsVisited() ? 1 : 0);
		CalcExperienceLang(Count.IsVisited() ? 1 : 0);
		CalcExperienceLang(Lord.IsVisited() ? 1 : 0);
		CalcExperienceLang(LadyFarun.IsVisited() ? 1 : 0);
		var ponyt:Person = coreGame.People.GetPersonsObject("ponytrainer");
		CalcExperienceLang(ponyt.IsVisited() ? 1 : 0);
		CalcExperienceLang(SwimInstructor.IsVisited() ? 1 : 0);
		CalcExperienceLang(VarIdol);
		CalcExperienceLang(BountyHunter.IsVisited() ? 1 : 0);
	} else SlaveActsIdx += 13;
	
	modulesList.AddExperiences(drugs, sd);
	
	return Math.ceil(100 * (SlaveExperience / SlaveActs));
}

function GetMissingExperience() : String
{
	if (ExperienceTotal() == 100) return "";
	return arSlaveActs[Math.floor(Math.random()*arSlaveActs.length)];
}