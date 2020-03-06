// Slave Maker information
var SMData:SlaveMaker;

// references to SMData objects
var BitFlagSM:BitFlags;
var SMInitialItems:BitFlags;
var SMSkills:BitFlags;
var SMAdvantages:BitFlags;
var Home:HouseDetails;
var SlavesArray:Array;
var Diary:TrainingLog;

// Slave/Slaves
var slaveData:Slave;		// current slave in training
var ActInfoCurrent:ActInfoList;		// reference

// Slave reference objects
var SlaveGirl:SlaveModule;
var SlaveData:Slave;		// reference - to slaveData object
var sdata:Object;			// reference - common for any slave
var BitFlag1:BitFlags;
var BitFlag2:BitFlags;
var DemonFlags:BitFlags;
var Owner:PersonOwner;

// Participants
var Participants:Array;
var SpecialIndex:Number;
var PersonIndex:Number;
var PersonOtherIndex:Number;
var PersonShown:Number;

var totmales:Number;
var totfemales:Number;
var totdickgirls:Number;

// Modules
var People:PeopleModule;
var Generic:GenericModule;
var Backgrounds:BackgroundModule;
var Parties:PartiesModule;
var Sounds:SoundsModule;
var Faeries:FaeriesModule;
var Furries:FurriesModule;
var HouseEvents:HousesModule;
var Catgirls:CatgirlTraining;
var Tentacles:TentaclesModule;
var Contests:ContestsModule;
var trainSlaveMaker:SlaveMakerTraining;

var modulesList:LoadedModules;

// The places instances
// reference objects
var DocksPort:PlaceDocksPort;
var DocksSlavePens:PlaceDocksSlavePens;
var DocksSlavePensSecure:PlaceDocksSlavePensSecure;
var TownCenter:PlaceTownCenter;
var Slums:PlaceSlums;
var Farm:PlaceFarm;
var Palace:PlacePalace;
var Forest:PlaceForest;
var Lake:PlaceLake;
var RuinedTemple:PlaceRuins;
var BeachWalk:PlaceBeachWalk;
var BeachSwim:PlaceBeachSwim;
var BeachPrivate:PlaceBeachPrivate;
//var SlaveMarket:PlaceSlaveMarket;

// People instances and other variables
// reference objects
var LadyFarun:PersonLadyFarun;
var Knight:Person;
var Lord:Person;
var Prostitute:Person;
var HighClassProstitute:Person;
var Barmaid:Person;
var Maid:Person;
var Merchant:Person;
var Count:Person;
var CuteLesbian:Person;
var BountyHunter:Person;
var PonyMistress:Person;
var SwimInstructor:Person;
var SleazyBarOwner:Person;
var Singer:Person;
var Natsu:Person;
var Tachiba:Person;
var Astrid:Person;

// General variables, not saved
var dmod:Number;

var TentacleChoice:Number;
var TentacleHaunt:Number;
var TentacleFrequency:Number;

var ActionChoice:Number;
var DemonChoice:Number;

var UseGeneric:Boolean;
var StandardPlugText:Boolean;
var AppendActText:Boolean;
var UseImages:Boolean;
var bAllowEvents:Boolean;

var SlaveVersion:String;
var SlaveCredits:String

// Events
// 		internal variables for events, not saved
var NumEvent:Number;
var ObjEvent;
var OldNumEvent:Number;
var StrEvent:String;
var OldStrEvent:String;
var EventTotal:Number;
var tempstr:String;
var eventLoop:Number;

// Images
var arAutoLoadedMovieArray:Array = new Array();
var arLoadedMovieArray:Array = new Array();

var mcLoaderImage:MovieClipLoader = new MovieClipLoader();
var mcLoaderImage2:MovieClipLoader = new MovieClipLoader();
var loadListenerImage:Object = new Object();
var mcLoader:MovieClipLoader = new MovieClipLoader();

var mclListener:Object = new Object();

// Slaves
var ImageFolder:String;

// Global Initialisation when first run
Home = null;

mcLoaderImage.addListener(loadListenerImage);
mcLoaderImage2.addListener(loadListenerImage);

// Take a walk/Lend
var WalkPlace:Number;
var currPlace:Place;
var VisitLendPerson:Number;

var lfnc:Function;

var flNode:XMLNode;
var slaveNode:XMLNode;
var assNode:XMLNode;
var evtNode:XMLNode;
var actNode:XMLNode;
var hintNode:XMLNode;
var statNode:XMLNode;
var walkNode:XMLNode;
var gndNode:XMLNode;
var skNode:XMLNode;

var GP:String;

var modSlaveTrainer:Number;

var OtherSlaveShown:Boolean;

// Statistics Tabs
var StatTab:Number;

// Bloodtype

// common arrays, used in class Slave, defined here to prevent multiple instances

var MasterAffinity:Array = [[-1, 2, 1, -2], [2, -1, -2, 1], [1, -2, -1, 2], [-2, 1, 2, -1]];
var AssistantAffinity:Array = [[2, 1, -1, -2], [1, 2, -2, -1], [-1, -2, 2, 1], [-2, -1, 1, 2]];

