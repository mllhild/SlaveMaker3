// SlaveModule - class defining a loaded module, like an event or class of events. 
// Also a container for slaves and assistants, but not their data, for that see the class Slave
// Translation status: COMPLETE

import Scripts.Classes.*;

class SlaveModule extends BaseModule
{
	//------------------------------
	// Variables
				
	// Common Clips
	public var Assistant:MovieClip;	// a common MovieClip for the small assistant image
	
	// Specialised versions
	public var Assisting:Boolean;		// a working assistant
	public var AsEvent:Boolean;			// an external event or other loaded girl
	
	// Obsolete, will be removed
	public var Introduction:MovieClip;		// TODO use methods
			
	// duplicated SlaveGirl variables for ease of use (ie to not use _root/slaveData)
	// these should be considered constant/read-only
	public var Naked:Boolean;
	public var Lesbian:Boolean;
	public var LesbianTraining:Boolean;			// lesbian or gay male
	public var Catgirl:Boolean;
	public var Aroused:Boolean;
	public var ServantName:String;
	public var ServantGender:Number;
	public var SlaveName:String;
	public var SlaveName1:String;
	public var SlaveName2:String;
	public var Elapsed:Number;
	public var Trust:Number;
	public var DickgirlXF:Number;
	public var MaxPath:Number;
	public var CurrentPath:Number;
	
	public var arSaveVars:Array;
	
	//-----------------------------	
	
	//-----------------------------
	//Methods
	public static function main(swfRoot:MovieClip, sdo:Object, cg:Object) : SlaveModule
	{
		// entry point
		return new SlaveModule(swfRoot, sdo, cg);
	}
	
	// Constructor
	//		mc is the MovieClip the Module is loaded into
	public function SlaveModule(mc:MovieClip, slave:Object, core:Object) 
	{
		super(mc, slave, core);
		//SMTRACE("SlaveModule() " + core + " " + coreGame);
		
		Assistant = undefined;
		Introduction = undefined;
		Naked = false;
		Lesbian = false;
		Aroused = false;
		ServantName = "";
		ServantGender = 2;
		SlaveName = "";
		Elapsed = 0;
		AsEvent = false;
		Assisting = false;
	}
		
	public function GetCoreGame() : Object { return super.coreGame; }
	
	public function CanLoadSave() : Boolean { return true; }
	
	public function SetSlaveDetails(sdo:Object) {  // DO NOT OVERRIDE
		if (sdo == null || sdo == undefined) sdo = coreGame;
		this.slaveData = sdo;
		this.sd = sdo;
		Lesbian = coreGame.Lesbian;
		LesbianTraining = coreGame.LesbianTraining;
		Aroused = coreGame.Aroused;
		Naked = sd.DressWorn < 0;
		SlaveName = sd.SlaveName;
		SlaveName1 = sd.SlaveName1;
		SlaveName2 = sd.SlaveName2;
		Trust = sd.VarObedience + sd.VarLovePoints;
		Elapsed = coreGame.Elapsed;
		DickgirlXF = sd.DickgirlXF;
		Catgirl = sd.IsCatgirl();
		SMData = coreGame.SMData;
	}
	// Load/Save custom data, common to all module types
	public function LoadGame(loaddata:Object)
	{
		super.Load(loaddata);
		
		if (arSaveVars != null) {
			var i:Number = arSaveVars.length;
			if (i == undefined) i = 0;
			while (i > 0) {
				var obj:Object = arSaveVars.pop();
				delete obj;
				i--;
			}
			delete arSaveVars;
			arSaveVars = null;
		}
		
		if (loaddata.arSaveVars != undefined) {
			var i:Number = loaddata.arSaveVars.length;
			if (i == undefined) i = 0;
			if (i != 0) {
				arSaveVars = new Array();
				for (var j:Number = 0; j < i; j++) {
					if (typeof(loaddata.arSaveVars[j]) == "string") arSaveVars.push(loaddata.arSaveVars[j] + "");
					else arSaveVars.push(loaddata.arSaveVars[j]);
				}
			}
		}

	}
	
	public function SaveGame(savedata:Object)
	{
		super.Save(savedata);
		
		if (arSaveVars != null) {
			var i:Number = arSaveVars.length;
			if (i == undefined) i = 0;
			if (i != 0) {
				savedata.arSaveVars = new Array();
				for (var j:Number = 0; j < i; j++) {
					if (typeof(arSaveVars[j]) == "string") savedata.arSaveVars.push(new String(arSaveVars[j]));
					else savedata.arSaveVars.push(arSaveVars[j]);
				}
			}
		}
	}
			
	public function SetVariable(num:Object, val:Object) { }
	
	public function GetVariable(num:Object) : Object { return undefined; }
	
	public function GetString(num:Number) : String { return undefined; }
	
	public function SetString(num:Number, str:String) {	}
	
	//---------------------
	// Review screen options
	//---------------------
	public function ShowSlaveTalk() : Boolean { return false; }
	
	public function ShowSlaveIntimacy() : Boolean { return false; }
	
	public function ShowSlaveReview(): Boolean { return false; }
	
	public function DoSlaveTalk(person:String) : Boolean { return false; }
	
	public function DoSlaveIntimacy(person:String) : Boolean { return false; }
	
	public function NewSlaveOrder(person:String, order:Number, hint:Boolean): Boolean { return false; }
	
	public function DoSlaveOrder(person:String, order:Number): Boolean { return false; }

	//---------------------------
	// Participants
	//---------------------------
	public function SetDefaultParticipants(act:Number) : Boolean { return false; }
	
	public function SetSingleRandomParticipant(act:Number, sm:Boolean, assistant:Boolean, male:Number, female:Number, dickgirl:Number) : Boolean { return false; }

	
	//------------------------------------
	// Servant specific functions
	//------------------------------------
	// ShowAssistant - shows a graphic for the assistant
	// 0 = assistant selection image
	// 1 = normal view in small rectangle
	// 2 = tentacle sex (small version shown when slave girl raped)
	// 3 = raped
	// 4 = ignore this (shown when assistant is absent, but you will never get this)
	// 5 = wet - she falls in some water
	// 6 = large graphic shown when your slave runs away
	// 7 = dressed as a maid (small window) [OPTIONAL]
	public function ShowAsAssistant(type:Number) { }

	// InitialiseAsAssistant - sets up the assistant
	/*
	Variables to control servant
			coreGame.ServantName = "Genma";		// name
			coreGame.ServantPronoun = "I";			// Pronoun, default "I"
			coreGame.AssistantTentacleSex = false; // can the assistant be tentacle fucked, default true
			coreGame.AssistantRape = false;		// can the assistant be raped, default true
			coreGame.ServantGender = 1;			// servants gender, 1 = male, 2 = female, 3 = dickgirl, default 1
			coreGame.SlaveLikeServant = true;		// misleading name, does the servant like the slave, default true
			coreGame.AssistantDescription = 		// a description of the assistant and any effects while training slaves
				"An experienced Slave Maker but with odd techniques, often involving humiliation. He is a trained martial artist, but surprising cowardly.\r\rHe can be used to train any girl and increases her Maximum Obedience by 10%.";
			coreGame.AssistantCost = 200;			// The cost to employ their services
	*/
	public function InitialiseAsAssistant(firstload:Boolean, noimage:Boolean) : MovieClip {
		return Assistant;
	}
	public function InitialiseOnlyAsAssistant(firstload:Boolean) : Boolean {
		return true;
	}
	
	public function GetAssistantSelectionImage() : MovieClip
	{
		ShowAsAssistant(0);
		return this.Assistant;
	}
	
	// Apply any initial stat effects when this assistant is employed
	public function EmployAsAssistant() { }
	
	// HideAsAssistant - hide the assistant graphics
	// If you override then call
	//		super.HideAsAssistant()
	public function HideAsAssistant()
	{
		super.HideImages();
	}
	
	// called when the Assistant is unloaded
	public function DestroyAsAssistant() { 
		super.DestroyModule();
	}
	
	public function ShowIntroPage(page:Number, align:Number) : MovieClip { return undefined; };
	
	public function HideIntroPages() { };
	
	public function ShowUntrainable() : MovieClip { return undefined; }
		
	// Assistant
	
	public function DoEventNextAsAssistant() : Boolean { return false; }
	
	public function AfterEventNextAsAssistant() { };
	
	public function PreEventAsAssistant(num:Number) : Boolean { return false; }
	
	public function EventsAsAssistant(possible:Boolean) { };
	public function EventsUrgentAsAssistant(possible:Boolean) { };
	
	public function AfterEventsAsAssistant() : Boolean { return false; }
	
	public function DoEventYesAsAssistant() : Boolean { return false; };
	
	public function AfterEventYesAsAssistant() { };
	
	public function DoEventNoAsAssistant() : Boolean { return false; };
	
	public function AfterEventNoAsAssistant() { };
	
	public function ApplyDifficultyAsAssistant(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, SexualEnergy:Number, Sexuality:Number) { return; };
	
	public function LimitMaxMinStatsAsAssistant() { };
	
	public function UpdateDateAndItemsAsAssistant(NumDays:Number) { };
	
	public function IntroductionAsAssistant(page:Number) : Boolean { return false; }
	
	public function StartMessageAsAssistant(bSGMessage:Boolean) : Boolean { return false; }
	
	public function UpdateSlaveAsAssistant() { };
	
	public function ChangeActButtonsAsAssistant(tab:Number) { };
	
	public function StartDayAsAssistant() : Boolean { return false; }
	
	public function StartMorningAsAssistant() : Boolean { return false; }
	public function StartMorningReportAsAssistant() { }
	public function StartEveningAsAssistant() : Boolean { return false; }	
	public function StartEveningReportAsAssistant() { }
	
	public function StartNightAsAssistant(intro:Boolean) : Boolean { return false; }
		
	public function AfterNightAsAssistant() : Boolean { return false; }
	
	public function NewPlanningActionAsAssistant(type:Number, available:Boolean, hint:Boolean) : Boolean { return false; }
	
	public function DoPlanningActionAsAssistant(Action:Number) : Boolean { return false; }

	public function AfterNewPlanningActionAsAssistant(type:Number, available:Boolean, hint:Boolean) { }
	
	public function AfterPlanningActionAsAssistant(LastActionDone:Number) { }
	
	public function ShowRefusedActionAsAssistant(Action:Number, slave:String, servant:String, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Libido:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, SexualEnergy:Number) { }

	public function EventBuyerAsAssistant() : Boolean { return false; }
	
	public function EventRescueAsAssistant() : Boolean { return false; }
	
	public function ShowAsAssistantAnal() : Boolean { return false; }
	
	public function ShowAsAssistantSpanking() : Boolean { return false; }
	
	public function ShowStatHintAsAssistant(stat:Number) : Boolean { return false; }
	
	
	// Tentacles
	
	public function ShowAsAssistantTentacleSex() { }
	
	public function SupervisorTentacleSexAsAssistant() : Boolean { return false; }
		
	public function SupervisorRepelsTentaclesAsAssistant() { }
	
	
	// Walk

	public function DocksAreasAsAssistant(secure:Boolean) { }
	
	public function BeachActivitiesAsAssistant() { }
	
	public function TakeAWalkAsAssistant(place:Number) : Boolean { return false; };

	public function AfterWalkAsAssistant(place:Number, present:Boolean) { };
	
	public function DoWalkHouseAsAssistant(house:Number) : Boolean { return false; }
	
	public function DoWalkBeachSwimAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }
	
	public function DoWalkBeachWalkAsAssistant(NumEvent:Number, present:Boolean): Boolean { return false; }
	
	public function DoWalkBeachPrivateAsAssistant(NumEvent:Number, present:Boolean): Boolean { return false; }
	
	public function DoWalkBeachRocksAsAssistant(NumEvent:Number, present:Boolean): Boolean { return false; }

	public function DoWalkTownCenterAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkForestAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkLakeAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkSlumsAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkPalaceAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkFarmAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }
	
	public function DoWalkRuinsAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkDocksPortAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkDocksSlavePensAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkDocksSlavePensSecureAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }

	public function DoWalkSlaveMarketAsAssistant(NumEvent:Number, present:Boolean) : Boolean { return false; }
	
	
	// Visits
		
	public function DoVisitSelectAsAssistant() { }
	
	public function DoVisitAsAssistant(person:Number) : Boolean { return false; }
		
	public function DoLendSelectAsAssistant() { }
	
	public function DoLendHerAsAssistant(person:Number) : Boolean { return false; }
	
	public function VisitChatWithPersonAsAssistant(person:Number) { }


	
	// Items and Shopping
	
	public function PurchaseItemAsAssistant(item:Number, hint:Boolean) : Boolean { return false; }
	
	public function DoTailorYesAsAssistant(dress:Boolean) : Boolean { return false; }
	
	public function AfterTailorYesAsAssistant(dress:Boolean) { }
	
	public function PurchaseDrugAsAssistant(dnum:Number, hint:Boolean) : Boolean { return false; }
	
	public function HideItemAsAssistant(item:Number, align:Number)  { }
	
	public function ShowItemAsAssistant(item:Number, place:Number, align:Number, gframe:Number) : Boolean { return false; }

	public function HideItemsAsAssistant() { }
		
	public function EquipItemAsAssistant(item:Number) : Boolean  { return false; }
	
	public function WearItemAsAssistant(item:Number) : Boolean  { return true; }
	
	public function UnEquipItemAsAssistant(item:Number) : Boolean  { return false; }
	
	public function RemoveItemAsAssistant(item:Number) : Boolean  { return true; }
	
	public function ShowItemDescriptionAsAssistant(item:Number) : Boolean  { return false; }

	public function DrinkPotionAsAssistant(potion:Number, price:Number, say:String) : Boolean { return false; }

	public function GetCurrentSexActLevelAsAssistant(type:Number) : Number { return undefined; }
	
	public function ShowBunnySuitAsAssistant() : Boolean { return false; }
	
	public function ShowLingerieAsAssistant() : Boolean { return false; }
	
	public function ShowMaidUniformAsAssistant() : Boolean { return false; }
	
	public function ShowSwimsuitAsAssistant() : Boolean { return false; }
	
	public function ShowOtherSMEquipmentAsAssistant() { }

	public function ShowOtherEquipmentAsAssistant() { }

	private var nModuleTab:Number;
	public function SetEquipmentTabsAsAssistant() { }

	public function ShowEquipmentTabAsAssistant(nTab:Number) { }


	// Ending
	
	public function ShowTrainingCompleteAsAssistant() : Boolean { return false; }
	
	public function EndingStartAsAssistant(total:Number) : Boolean { return false; }
	
	public function EndingFinishAsAssistant(total:Number) : Boolean { return false; }
	
	public function AfterEndingFinishAsAssistant(total:Number) { }
	
	public function NumCustomEndingsAsAssistant() : Number { return 0; }
	
	public function ShowEndingsAsAssistant(num:Number) { }
	
	public function HideEndingsAsAssistant() { }
	
	public function CheckMetaEndingsAsAssistant(arMetasDone:Array) : Boolean { return false; }
	
	// Slave Maker
	
	public function SMCustomTrainingAsAssistant(eventno:Number) { }
	
	public function SMPreEvent() : Boolean { 
		// slave maker version of PreEvent, happens before slave based version. Primarily for events
		// like Demonic Cock or Inhuman Ancestry morning events
		return false;
	}
	
	// Combat
	
	public function ShowAttackChoicesAsAssistant(runmsg:Number) : Boolean { return false; }
	
	// Meetings
	
	public function MeetPersonAsAssistant(person:Number, choice:Number, personstr:String, say:String, evt:String) : Boolean { return false; }
	
	public function AfterMeetPersonAsAssistant(person:Number, choice:Number, evt:String) { }

	// Review screen options
	
	public function DoSlaveTalkAsAssistant(person:String) : Boolean { return false; }
	
	public function DoSlaveIntimacyAsAssistant(person:String) : Boolean { return false; }

	public function NewSlaveOrderAsAssistant(person:String, order:Number, hint:Boolean): Boolean { return false; }
	
	public function DoSlaveOrderAsAssistant(person:String, order:Number): Boolean { return false; }


	// Contests
	
	public function StartContestAsAssistant(numcontest:Number, actno:Number) { }
	
	public function DoContestsNextAsAssistant(numcontest:Number, actno:Number) : Boolean { return false; }
	
	// Acts/Experiences
	
	public function AddExperiencesAsAssistant(drugs:Boolean, sd:Object) { }
	
	
	//-------------------------------------
	// Slave Girl specific Functions
	//-----------------------------------
	
	// Start Game
	
	public function Initialise() { 
		super.InitialiseModule();
	}
	
	public function StartGame() { }		// OBSOLETE please use StartNewSlave()
	
	public function StartNewSlave() { StartGame(); }
	
	public function StartMessage() : Boolean { return false; }
	
	public function IsTrainable() : Boolean { return true; }
	
	public function ShowContractSigned() { }
	
	public function Destroy() { 
		super.DestroyModule();
	}
	
	public function HideSlaveActions() { };
	
	// Updates
	
	public function ApplyDifficulty(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, SexualEnergy:Number, Sexuality:Number) { return; };
	
	public function UpdateDateAndItems(NumDays:Number) { };
	
	public function UpdateSlave() { };
	
	public function ChangeActButtons(tab:Number) { };


	// Events & Planning
	
	public function ShowSexDream(LesDream:Boolean) { }
		
	public function PreEvent(num:Number) : Boolean { return false; }
	
	public function Events(possible:Boolean) { };
	public function EventsUrgent(possible:Boolean) { };
	
	public function AfterEvents() : Boolean { return false; }
	
	public function DoEventNext() : Boolean { return false; }
	
	public function AfterEventNext() { };
	
	public function DoEventYes() : Boolean { return false; };
	
	public function AfterEventYes() { };
	
	public function DoEventNo() : Boolean { return false; };
	
	public function AfterEventNo() { };
		
	public function StartDay() : Boolean { return false; }
	
	public function StartNight() : Boolean { return false; }
	
	public function StartMorning() : Boolean { return false; }
	public function StartMorningReport() { }
	public function StartEvening() : Boolean { return false; }
	public function StartEveningReport() { }
	
	public function AfterNight() : Boolean { return false; }
	
	public function NewPlanningAction(type:Number, available:Boolean, hint:Boolean) : Boolean { return false; }
	
	public function AfterNewPlanningAction(type:Number, available:Boolean, hint:Boolean) { }
	
	public function AfterPlanningAction(LastActionDone:Number) { }
	
	public function DoPlanningAction(Action:Number) : Boolean { return false; }
	
	public function DoNewPlanningYes() : Boolean { return false; };

	public function ShowRefusedAction(Action:Number, slave:String, servant:String, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Libido:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, SexualEnergy:Number) : Boolean { return false; }

	public function ShowMaidUniformSmall() { }
	
	public function ShowGigaBE() : Boolean { return false; }
	
	// Others
	
	public function EarnMoney(income:Number) : Number { return income; }
	
	public function SlaveSkillHintRollOver(skill:Number) : Boolean { return false; }
		
	public function TempleHouseRent() : Boolean { return false; }
	
	public function SetRule(rule:Number) : Boolean { return true; }
	
	public function ClearRule(rule:Number) : Boolean { return true; }
	
	public function ShowDemonRape() : Boolean { return false; }
	
	public function TestObedience(Difficulty:Number, Action:Number) : Boolean {
		return coreGame.TestObedienceBase(Difficulty, Action);
	}
	
	public function ShowStatHint(stat:Number) : Boolean { return false; }
	
	public function ShowMorningMouthful() : Boolean { coreGame.UseGeneric = true; return false; }
	public function ShowMorningMouthfull() : Boolean { return ShowMorningMouthful(); }
		
	public function GetCurrentSexActLevel(type:Number) : Number { return undefined;	}
		
	public function EventBuyer() : Boolean { return false; }
	
	public function EventRescue() : Boolean { return false; }
	
	public function OwnerTestSpecial() : Boolean { return false; }
	
	public function OwnerTest(tempstr:String, gain:Number) : Boolean { return false; }
	
	public function ShowRetrieved() : Boolean { return false; }
	
	public function LesbianTrainingAccepted() {  }
	
	public function LesbianTrainingRefused() : Boolean { return false; }

	public function EvilMineStart() {  }
	
	public function ShowNakedApron() : Boolean { return false; }
	
	public function ShowRaped() : Boolean { return false; }
	
	
	// Walking
	
	public function DocksAreas(secure:Boolean) { }
	
	public function BeachActivities() { }

	public function TakeAWalk(place:Number) : Boolean { return false; };

	public function AfterWalk(place:Number) { };
	
	public function DoWalkHouse(house:Number) : Boolean { return false; }
		
	public function DoWalkBeachSwim(NumEvent:Number) : Boolean { return false; }
	
	public function DoWalkBeachWalk(NumEvent:Number) : Boolean { return false; }
	
	public function DoWalkBeachPrivate(NumEvent:Number) : Boolean { return false; }
	
	public function DoWalkBeachRocks(NumEvent:Number) : Boolean { return false; }

	public function DoWalkTownCenter(NumEvent:Number) : Boolean { return false; }

	public function DoWalkForest(NumEvent:Number) : Boolean { return false; }

	public function DoWalkLake(NumEvent:Number) : Boolean { return false; }

	public function DoWalkSlums(NumEvent:Number) : Boolean { return false; }

	public function DoWalkPalace(NumEvent:Number) : Boolean { return false; }

	public function DoWalkFarm(NumEvent:Number) : Boolean { return false; }
	
	public function DoWalkRuins(NumEvent:Number) : Boolean { return false; }

	public function DoWalkDocksPort(NumEvent:Number) : Boolean { return false; }

	public function DoWalkDocksSlavePens(NumEvent:Number) : Boolean { return false; }

	public function DoWalkDocksSlavePensSecure(NumEvent:Number) : Boolean { return false; }

	public function DoWalkSlaveMarket(NumEvent:Number) : Boolean { return false; }

	
	// Tentacles
	
	public function ShowTentacleSex(place:Number) : Boolean { return false; }

	public function ShowTentacleHaremImage(image:Number) { }
			
	public function ShowTentaclePregnancyBirth() : Boolean { return false; }
															
	public function ShowTentaclePregnancyReveal() : Boolean { return false; }
	
	public function SeePregnant() : Boolean { return false; }
	
	public function SupervisorTentacleSex() : Boolean { return false; }
	
	public function SupervisorRepelsTentacles() { }
	
	public function CanSupervisorRepelTentacles() : Boolean { return true; }


	// Pregnancy
	public function ShowPregnancyReveal() : Boolean { return false; }
	
	public function ShowPregnancyBirth() : Boolean { return ShowTentaclePregnancyBirth(); }

		
	// Dickgirls
	
	public function IsDickgirl() : Boolean { return false; }
	
	public function ShowDickgirlTransform(permanent:Boolean) : Boolean { return false; }
	
	public function AfterDickgirlPotion(num:Number) { }
	
	public function ShowDickgirlPermanent() : Boolean { return false; }
	
	public function DickgirlPotionOfferFirstTime() { }
	
	public function DickgirlPotionOffer() { }
		
		
	// Catgirls
	
	public function StartCatgirlTraining(type:Number) : Boolean { return false; }
	
	public function FinishedCatgirlTraining() : Boolean { return false; }
	
	public function ShowEndingCatgirl() : Boolean { return false; }
	
	// 23 = wear cat ears, 24 = wear cat tail, 1 to 6 = put on dress x with cat ears or tail
	public function ShowRefuseCatgirl(type:Number) { }
	
	
	// Puppygirls
	
	public function StartPuppygirlTraining(type:Number) : Boolean { return false; }
	
	public function FinishedPuppygirlTraining() : Boolean { return false; }
	
	public function ShowEndingPuppygirl(type:Number) : Boolean { return false; }
	
	// 29 = wear puppy ears, 30 = wear puppy tail, 1 to 6 = put on dress x with cat ears or tail
	public function ShowRefusePuppygirl(type:Number) { }
	
	
	// Faeries
	
	public function ShowFaerieTransformation() : Boolean { return false; }
	
	public function ShowEndingFaerie() : Boolean { return false; }

		
		
	// Milking
	
	public function ShowMilkFall() : Boolean { return false; }
	
	public function ShowMilkAccident() { }
	
	public function ShowMilking() { }

	public function ShowMilkEnd() : Boolean { return false; }
	
	
	// Ending
	
	public function ShowTrainingComplete() : Boolean { return false; }

	public function GetEndingTotal() : Number { return 0; } 
	
	public function ShowEndingTentacleSlave() { }
	
	public function ShowEndingLesbianSlave() { }
	
	public function ShowEndingHeterosexualSlave() { }
	
	public function ShowEndingPonygirl() : Boolean { return false; }
	
	public function ShowEndingCourtesan() { }
	
	public function ShowEndingCumslut() : Boolean { return false; }
	
	public function ShowEndingDickgirl() { }
	
	public function ShowEndingSM() { }
	
	public function ShowEndingDrugAddict() { }
	
	public function ShowEndingRich() { }
	
	public function ShowEndingMarriage() { }
	
	public function ShowEndingSexManiac() { }
	
	public function ShowEndingSexAddict() { }
	
	public function ShowEndingRebel() { }
	
	public function ShowEndingNormalPlus() { }
	
	public function ShowEndingNormal() { }
	
	public function ShowEndingNormalMinus() { }
	
	public function ShowEndingProstitute() { }
	
	public function ShowEndingMaid() { }
	
	public function ShowEndingCowgirl() { }
	
	public function ShowEndingBoughtBack() { }
	
	public function ShowEndingLove() { }
	
	public function EndingStart(total:Number) : Boolean { return false; }
	
	public function EndingFinish(total:Number) : Boolean { return false; }
	
	public function AfterEndingFinish(total:Number) { }
	
	public function NumCustomEndings() : Number { return 0; }
	
	public function ShowEndings(num:Number) { }
	
	public function HideEndings() { }
	
	public function AskBoughtBackQuestion() { }
	
	public function CheckMetaEndings(arMetasDone:Array) : Boolean { return false; }
	
	
	// Shops
	
	public function DoArmourer() { }
	
	public function DoShop() { }
	
	public function DoTailor() { }
	
	public function DoSalon() { }
	
	public function DoStables() { }
		
	
	// Love & Dating
	
	public function ShowLoveConfession() {  }
	
	public function ShowLoveAccepted() : Boolean { return false; }
	
	public function ShowLoveRefused() : Boolean 
	{
		// at the time of this function call _root.NumEvent is
		//  3.2 actually refused the confession
		//  3.4 unsure  - BUT should use ShowLoveUnsure() below
		//  220 cure of priapus draft
		//  9999 - too many lovers
		return false;
	}
	
	public function ShowLoveUnsure() : Boolean { return false; }
	
	public function ShowPropositionAccepted() {  }
	
	public function ShowPropositionRefused() {  }
	
	public function OldLoverStartDating() { }
	
	public function OldLoverDating() {  }
	
	public function ShowDating() {  }
		
	public function ShowNobleLoveAccepted() {  }
	
	public function ShowNobleLoveRefused() {  }
	
	public function NobleLove(allowoffer:Boolean) { }
	
	// Items
	
	public function HideItem(item:Number, align:Number) {  }
	
	public function ShowItem(item:Number, place:Number, align:Number, gframe:Number) : Boolean { return false; }
	
	public function HideItems() { }
	
	public function EquipItem(item:Number) : Boolean  { return false; }
	
	public function WearItem(item:Number) : Boolean  { return true; }
	
	public function UnEquipItem(item:Number) : Boolean  { return false; }
	
	public function RemoveItem(item:Number) : Boolean  { return true; }
	
	public function ShowItemDescription(item:Number) : Boolean  { return false; }
	
	public function DrinkPotion(potion:Number, price:Number, say:String) : Boolean { return false; }

	public function BuyPotion(person:Object, potion:Number, cost:Number, smgold:Boolean) : Number { return cost; }

	public function RemoveDress() { }
	
	public function WearDress() { }
	
	public function ShowNaked() { }
	
	public function ShowDress() { }
	
	public function ShowNakedSmall() { }
	
	public function ShowDressSmall() { }
	
	public function HideDresses() { }
	
	public function HideRobes() { HideDresses(); }

	public function ShowOtherHouseDetails() { }
	
	public function ShowOtherSMEquipment() { }
	
	public function ShowOtherEquipment() { }
	
	public function PurchaseItem(item:Number, hint:Boolean) : Boolean { return false; }
	
	public function DoTailorYes(dress:Boolean) : Boolean { return false; }

	public function AfterTailorYes(dress:Boolean) {  }

	public function PurchaseDrug(dnum:Number, hint:Boolean) : Boolean { return false; }

	public function ShowBunnySuit() : Boolean { return false; }
	
	public function ShowLingerie() : Boolean { return false; }
	
	public function ShowMaidUniform() : Boolean { return false; }
	
	public function ShowSwimsuit() : Boolean { return false; }
	
	public function ShowUniform(uniform:Number) : Boolean { return false; }
	
	public function BuyDress(cost:Number) : Number { return -1; }
	
	public function BuyUniform(cost:Number) : Number { return -1; }
	
	public function PurchaseDress(dress:Number, owned:Number, dname:String, desc:String, price:Number, hint:Boolean) : Boolean { return false; }
	
	public function IsNakedDressAvailable() : Boolean { return false; }
	
	public function PutDressOn(dress:Number) : Boolean { return false; }
	
	public function TakeDressOff() : Boolean { return false; }
	
	// Meetings
	
	public function MeetPerson(personno:Number, choice:Number, personstr:String, say:String, evt:String) : Boolean { return false; }
	
	public function AfterMeetPerson(person:Number, choice:Number, evt:String) { }
	
	// The following are OBSOLETE Meeting function
	// generally use the above MeetPerson and AfterMeetPerson functions. See Base.xml for person numbers
	
	public function MeetNun(Description:String, choice:Number) : Boolean { return false; }
	
	public function AfterMeetNun(Description:String, choice:Number) { }
	
	public function MeetSleazyBarOwner(choice:Number) : Boolean { return false; }
	
	public function AfterMeetSleazyBarOwner(choice:Number) { }
	
	public function AfterMeetBountyHunter(place:Number, meet:Number) { }
	
	public function AfterMeetOddTeacher(place:Number, meet:Number) { }

	public function MeetXXXSchoolOwner(choice:Number) : Boolean { return false; }
	
	public function AfterMeetXXXSchoolOwner(choice:Number) { }

	public function MeetAstrid() : Boolean { return false; }

	public function MeetPuppyGirl() : Boolean { return false; }
	
	public function AfterMeetPuppyGirl() { }
	
	public function MeetIdol() : Boolean { return false; }
	
	public function AfterMeetIdol() { }
	
	public function MeetSchoolGirl() : Boolean { return false; }
	
	public function AfterMeetSchoolGirl() { }
	
	public function MeetSwimInstructor() : Boolean { return false; }
	
	public function AfterMeetSwimInstructor() { }
	
	
	// Visits
		
	public function DoVisitSelect() { }
	
	public function DoVisit(person:Number) : Boolean { return false; }
	
	// change the standard conversation
	public function VisitChatWithPerson(person:Number) { }

	// prevent or completely replace meeting
	public function DoVisitShop() : Boolean { return false; }
		
	public function DoVisitBarmaid() : Boolean { return false; }
		
	public function DoVisitProstitute() : Boolean { return false; }
	
	public function DoVisitHighClassProstitute() : Boolean { return false; }
	
	public function DoVisitKnight() : Boolean { return false; }

	public function DoVisitCount() : Boolean { return false; }
	
	public function DoVisitLord() : Boolean { return false; }
	
	public function DoVisitMaid() : Boolean { return false; }

	public function DoVisitLadyFarun() : Boolean { return false; }
	
	public function DoVisitCuteLesbian() : Boolean { return false; }
	
	public function DoVisitPonyMistress() : Boolean { return false; }

	public function VisitSeer(reading:String, score:Number) : String {
		// reading - Slaves's reading by the seer
		// score - estimated end game score (information only)
		// return - a modified reading.
		return "";
	}
	
	public function DoVisitBountyHunter() : Boolean { return false; }
	
	public function DoVisitCustomPerson() : Boolean { return false; }
	
	public function HighClassPartyOffer(days:Number) : Boolean { return false; }
	
	public function HighClassPartyCheck() : Boolean { return false; }

	// days = 0 for first reference (request to visit naked)
	// days > 0 actual offer and days to party
	// days -1 missed party and reoffer
	public function ProstitutePartyOffer(days:Number) : Boolean { return false; }

	public function VisitAstrid() : Boolean { return false; }
	
	// Lending
	
	public function DoLendSelect() { }
	
	public function DoLendHer(person:Number) : Boolean { return false; }
	
	public function DoLendHerOffer(person:Number) : Boolean { return false; }
	
	public function ShowActLend(person:Number) : Boolean { return false; }
	
	// OBSOLETE do not use
	public function ShowActLendHer() { }
	public function ShowSexActLendHer() { }
	
	public function DoLendShop() : Boolean { return false; }
	
	public function DoLendBarmaid() : Boolean { return false; }
	
	public function DoLendProstitute() : Boolean { return false; }
	
	public function DoLendHighClassProstitute() : Boolean { return false; }
	
	public function DoLendKnight() : Boolean { return false; }
	
	public function DoLendCount() : Boolean { return false; }
	
	public function DoLendLord() : Boolean { return false; }
	
	public function DoLendMaid() : Boolean { return false; }
	
	public function DoLendLadyFarun() : Boolean { return false; }
	
	public function DoLendBountyHunter() : Boolean { return false; }
	
	public function DoLendPonyMistress() : Boolean { return false; }
	
	public function DoLendCuteLesbian() : Boolean { return false; }
	
	public function DoLendCustomPerson() : Boolean { return false; }
	
	// Slave Maker
	
	public function SMCustomTraining(eventno:Number) { }

	
	// Slave Only Acts
	
	//sex
	public function ShowSlaveSex(eventno:Number) { }
	
	// OBSOLETE
	public function ShowSlaveSex1() { }
	
	public function ShowSlaveSex2() { }
	
	public function ShowSlaveSex3() { }
	
	public function ShowSlaveSex4() { }
	
	// chores
	public function ShowSlaveChore(eventno:Number) { }
	
	// OBSOLETE
	public function ShowSlaveChore1() { }
	
	public function ShowSlaveChore2() { }
	
	public function ShowSlaveChore3() { }
	
	// jobs
	public function ShowSlaveJob(eventno:Number) { }
	
	// OBSOLETE
	public function ShowSlaveJob1() { }
	
	public function ShowSlaveJob2() { }
	
	public function ShowSlaveJob3() { }
	
	// schools
	public function ShowSlaveSchool(eventno:Number) { }
	
	// OBSOLETE
	public function ShowSlaveSchool1() { }
	
	public function ShowSlaveSchool2() { }
	
	public function ShowSlaveSchool3() { }
	
	// shop
	public function ShowSlaveShop(eventno:Number) { }

	
	// others			
	public function ShowActNakedStart() {  }
	public function ShowActNaked() { }

	public function ShowSexActNakedStart() { }		// OBSOLETE
	public function ShowSexActNaked() { }			// OBSOLETE
	
	public function ShowActPlug() : Boolean { return false; }
	
	public function ShowSexActPlug() : Boolean { return false; }		// OBSOLETE
	
	public function DoOrdinaryDiscussion() : Boolean  { return false; }
	
	public function DoCongratulate() : Boolean  { return false; }
	
	public function DoScold() : Boolean  { return false; }
	
	public function DoLaterDiscussion() : Boolean  { return false; }
	
	// Contests
	
	public function ShowContestBeauty(score:Number) : Number { return undefined; }
	
	public function ShowContestXXX(score:Number) : Number { return undefined; }
	
	public function ShowContestPonygirl(score:Number) : Number { return undefined; }
	
	public function ShowContestDance(score:Number) : Number { return undefined; }
	
	public function ShowContestGeneralKnowledge(score:Number) : Number { return undefined; }
	
	public function ShowContestCourt(score:Number) : Number { return undefined; }
	
	public function ShowContestAdvancedHousework(score:Number) : Number { return undefined; }

	public function ShowContestHousework(score:Number) : Number { return undefined; }

	public function StartContest(numcontest:Number, actno:Number) { }
	
	public function DoContestsNext(numcontest:Number, actno:Number) : Boolean { return false; }

	public function ContestBonus(num:Number) : Number { return 0; }

	// Combat
	
	public function ShowAttackChoices(runmsg:Number) : Boolean { return false; }
	
	// Acts/Experiences
	
	public function AddExperiences(drugs:Boolean, sd:Object) { }


	
	//-----------------------------------------------
	// As an external event or other girl
	//-----------------------------------------------
	public function StartSlaveMaker() {
		//trace("SlaveModule.StartSlaveMaker");
		ResetBitFlags();
		
		delete arSaveVars;
		arSaveVars = null;
	}
	
	
	//-------------------------------------
	// Functions common to Assistants and Slave Girls
	//-------------------------------------
	
	public function HearGossip(person:Number, slut:Boolean, newg:Boolean) : Boolean { return false; }
	
	public function HideImages() { 
		super.HideImages();
	}
	
	public function HidePeople() { }
	
	
	// Actions
	
	// Called after(ish) each planning act of this type, in addition to the versions below
	// Actually these are called after the image is shown and standard text for doing the act.
	// Called before some final thing like Sleazy Bar Service or similar.
	public function AfterJob(astr:String) : Boolean { return false; }
	public function AfterChore(astr:String) : Boolean { return false; }
	public function AfterSchool(astr:String) : Boolean { return false; }
	
	
	public function ShowTired(cum:Boolean) { }
	
	public function ShowBreak(sleep:Boolean) { }
	
	public function ShowChoreCooking() { }
	
	public function ShowChoreCleaning() { }
	
	public function ShowChoreDiscuss() { coreGame.UseGeneric = true; }
		
	public function ShowChoreExpose() { }
	
	public function ShowChoreMakeUp() { }
	
	public function ShowChoreExercise() { }
	
	public function ShowChoreWalk() {
		// OBSOLETE: do nothing here.
	}
	
	public function ShowChoreReadABook() : Boolean  { return false; }
	
	public function ShowJobAcolyte(plugged:Boolean) : Number { return 1; }
	
	public function AfterJobAcolyte(pay:Number) {  }
	
	public function ShowJobBar() : Number { return 1; }
	
	public function AfterJobBar(pay:Number) {  }
	
	public function ShowJobBrothel() : Number { return 1; }
	
	public function AfterJobBrothel(pay:Number) {  }
	
	public function ShowJobCockMilking() : Number { return 1; }
	
	public function AfterJobCockMilking(pay:Number) {  }
	
	public function ShowJobLibrary() : Number { return 1; }
	
	public function AfterJobLibrary(pay:Number) {  }
	
	public function ShowJobOnsen(washgender:Number) : Number { return 1; }
	
	public function AfterJobOnsen(pay:Number, eventno:Number) : Boolean { return false; }
	
	public function ShowJobOnsenService(cgender:Number) : Boolean { return false; }
	
	public function ShowJobRestaurant() : Number { return 1; }
	
	public function AfterJobRestaurant(pay:Number) {  }
	
	public function AskSleazyBarStripTease() : Boolean  { return false; }
	
	public function ShowJobSleazyBar(strip:Boolean) : Number { return 1; }
	
	public function AfterJobSleazyBar(pay:Number) : Boolean { return false; }
	
	public function ShowJobSleazyBarService(female:Boolean) : Boolean { return false; }
	
	public function ShowSchoolSciences() { }
	
	public function AfterSchoolSciences() {  }

	public function ShowSchoolSinging() : Boolean { return false; }
	
	public function AfterSchoolSinging() {  }
	
	public function ShowSchoolTheology() { }
	
	public function AfterSchoolTheology() {  }
	
	public function ShowSchoolRefinement() { }
	
	public function AfterSchoolRefinement() {  }
	
	public function ShowSchoolDance() { }
	
	public function AfterSchoolDance() {  }
	
	public function ShowSchoolXXX(dg:Boolean) : Boolean { return false; }
	
	public function AfterSchoolXXX() {  }
	
	public function ShowSchoolSwimming() : Boolean { return false; }
	
	public function AfterSchoolSwimming() {  }
	
	// Sex Actions
	
	public function ShowSexActBlowjob() : Boolean { return false; }
	
	public function ShowSexActHandjob() : Boolean { return false; }
	
	public function ShowSexActFootjob() : Boolean { return false; }
	
	public function ShowSexActNothing() : Boolean { return false; }
	
	public function ShowSexActFuck() : Boolean { return false; }
	
	public function ShowSexActBondage() : Boolean { return false; }
	
	public function ShowSexActTouch() : Boolean { return false; }
	
	public function ShowSexActLick() : Boolean { return false; }
	
	public function ShowSexActAnal() : Boolean { return false; }
	
	public function ShowSexActGangBang() : Boolean { return false; }
	
	public function ShowSexActLesbian() : Boolean { return false; }
	
	public function ShowSexAct69() : Boolean { return false; }
	
	public function ShowSexActDildo() : Boolean { return false; }
	
	public function ShowSexActGroup() { }		// OBSOLETE
	
	public function ShowSexActOrgy() : Boolean { return false; }
	
	public function ShowSexActMasturbate() : Boolean { return false; }
	
	public function ShowSexActMaster() : Boolean { return false; }
	
	public function ShowSexActPonygirl() : Boolean { return false; }
	
	public function ShowSexActCumBath() : Boolean { return false; }
	
	public function ShowSexActKiss() : Boolean { return false; }
	
	public function ShowSexActSpank(whip:Boolean) : Boolean { return false; }
	
	public function SpankComment() : Boolean { return false; }
	
	public function ShowSexActStripTease() : Boolean { return false; }
	
	public function ShowSexActThreesome() : String { return ""; }
	
	public function ShowSexActTitFuck() : Boolean { return false; }
	
	
	// Debugging
	public function DebugModule() : String
	{
		var evtname:String;
		var evtarray:Array;
		var pos:Number;
		
		if (ModuleName.toLowerCase().substr(0, 6) == "event-") {
			evtarray = ModuleName.split("-");
			evtname = evtarray[evtarray.length-1];
		} else evtname = ModuleName.toLowerCase();

		pos = evtname.lastIndexOf(".");
		if (pos != -1) evtname = evtname.substr(0, pos);
		if (evtname.lastIndexOf("/") != -1) evtname = evtname.split("/")[1];
		evtname = Language.NameCase(evtname);

		var say:String = "\r\rEvent: <b>" + evtname + "</b>";
		say += "\r\r  Flags:\r";
		for (var i:Number = 0; i < GetMaxFlag(); i++) {
			say += "    Flag " + i + " = " + (CheckBitFlag(i) == true ? "true" : "false");
			if ((i % 2) != 0) say += "\r";
			else say += "\t";
		}
		var bVar:Boolean = false;
		for (var i:Number = 0; i < 10; i++) {
			if (GetVariable(i) != undefined) {
				bVar = true;
				break;
			}
		}
		if (bVar) {
			say += "\r  Variables:";
			for (var i:Number = 0; i < 10; i += 2) {
				say += "\r    " + i + ": " + (GetVariable(i) == undefined ? "" : GetVariable(i)) + "\t" + (i + 1) + ": " + (GetVariable(i+1) == undefined ? "" : GetVariable(i+1));
			}
		}		
		if (arSaveVars != null) {
			var i:Number = arSaveVars.length;
			if (i == undefined) i = 0;
			if (i != 0) {
				bVar = true;
				say += "\r  Saved Variables:";
				for (var j:Number = 0; j < i; j++) {
					if (bVar) say += "\r    savedvar" + j + " = " + arSaveVars[j];
					else say += "\tsavedvar" + j + " = " + arSaveVars[j];
					bVar = !bVar;
				}
			}
		}
		return say;
	}
			
}