import Scripts.Classes.*;
// Standalone version
// uncomment this block to enable and choose Standalone profile in publish settings
// Core Game
var coreGame:Object = _root;
var mcBase:Object = _root;
var Timers:TimerList = new TimerList(coreGame);
var Items:GameItems = new GameItems(coreGame);

var currentShop:Shop = null;		// reference to a shop instance
var currentDialog:DialogBase = null;		// reference to a dialogue instance

var loadednum:Number = 0;
var arPermanentMovieArray:Array = new Array();

// Assistant
var AssistantData:Slave;	// reference
var CurrentAssistant:SlaveModule;

var SMAvatar:Avatar = new Avatar(coreGame);

// Core variables and other objects
var XMLData:GameXML = new GameXML(coreGame);
var Language:GameLanguage = new GameLanguage(coreGame);

var config:Configuration = new Configuration(coreGame);

var SlaveList:TrainableSlaves;

var LoadSave:GameLoadSave = new GameLoadSave(coreGame);

var Combat:GameCombat = new GameCombat(coreGame);

// Options
var TentaclesOn:Number = 1;
var Difficulty:Number = 0;
var CombatDifficulty:Number = 0;
var BDSMOn:Boolean = true;
var RapeOn:Boolean = true;
var BadEndsOn:Boolean = false;
var IncestOn:Boolean = true;
var FurriesOn:Boolean = true;
var NonHumansOn:Boolean = true;
var SandboxMode:Boolean;
var SoundsOn:Boolean = true;
var bShowVanillaOn:Boolean = true;
var PregnancyOn:Boolean = true;
var DickgirlOn:Number = 1;
var AllDickgirlXFOn:Boolean = true;
var DickgirlTesticles:Boolean = true;
var DickgirlLesbians:Boolean = false;
var PonygirlAware:Number = 0;
var PonygirlsOn:Boolean = true;
var bCatgirlsCommon:Boolean = false;
var Options:DialogOptions = new DialogOptions(coreGame);

// Versions, not saved
var GameVersion:Number = 5.02;
var BugVersion:String = "";

// The city
var currentCity:City = null;
var citiesList:CityList = new CityList(coreGame);

// Shopping
//		saved
//		not saved
/*
var Armoury:Shop;
var Salon:Shop;
var Dealer:ShopDealer;
var ItemSalesman:ShopItemSalesman;
var Stables:ShopStables;
var SlaveMarketAuction:ShopSlaveMarketMinor;
var Tailors:ShopTailor;
*/

var EndGame:DialogEndGame = new DialogEndGame(coreGame);
var Potions:GamePotions = new GamePotions(coreGame);
var SelectEquipment:DialogEquipmentSlave = new DialogEquipmentSlave(coreGame);
var SelectSMEquipment:DialogEquipmentSlaveMaker = new DialogEquipmentSlaveMaker(coreGame);
var TitleScreen:DialogTitleScreen = new DialogTitleScreen(coreGame);
var Hints:DisplayHints = new DisplayHints(coreGame);
var Information:DisplayInformation = new DisplayInformation(coreGame);
var AssistantSelect:DialogSelectAssistant = new DialogSelectAssistant(coreGame);
var SlaveSelect:DialogSelectSlave = new DialogSelectSlave(coreGame);
var SlavePicker:DialogPickSlave = new DialogPickSlave(coreGame);
var MorningEvening:DialogMorningEvening = new DialogMorningEvening(coreGame);

var Icons:DisplayIcons;

var dspMain:DisplayGameWindow = new DisplayGameWindow(coreGame, true);
dspMain.Hide();

var temp:Number;
var i:Number;
var nLastAllocatedEvent:Number = 99999;
var utclast:Number = 0;

var Rules:TrainingRules = new TrainingRules(coreGame);
var LoadedSlaves:LoadedSlavesClass;

var NumMerchant:Number;

initialised = true;
// End Standalone
