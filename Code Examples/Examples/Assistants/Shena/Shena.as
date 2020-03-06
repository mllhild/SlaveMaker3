/*
CustomFlags:

_root.AssistantData.CustomFlag  Mugi Happiness
_root.AssistantData.CustomFlag1 
_root.AssistantData.CustomFlag2 
_root.AssistantData.CustomFlag3 
_root.AssistantData.CustomFlag4 
_root.AssistantData.CustomString

//BitFlags
//0 Everything Shown
//1 basic
//2 Helper 
//3 Guided
//4 Everything
//5 Everything day and night
//6 Everything day
//7 Everything every 2 day
//8 Everything every 3 days
//9 Guided Advanced Switcher

//Guiding Through Basic Trainings
//10 Prostitute
//11 Normal
//12 Normal -
//13 Normal + 
//14 Maid
//15 Rebel
//16 Sex Addict
//17 Sex Maniac
//18 Wedding
//19 Rich
//20 Drug Addict
//21 S&M
//22 DickGirl
//23 Coutesan
//24 Dickgirl Courtesan
//25 Ponygirl
//26 Dickgirl Ponygirl
//27 Cow Girl

//Advanced Training | Ayane                    | Belldandy | Kasumi           | Minako     | Naru                 | Orihime 
//10 Training 1     | Loyal                    | Daemon    | Cumslut          | Cat-Slave  | Bride of the Goddess | Priestess 
//11 Training 2     | Loyal Dickgirl           | Angel     | Dickgirl Cumslut | Cat Savior |                      | Corrupt Priestess 
//12 Training 3     | Loyal Courtesan          |           | Winner           |            |                      | Demon Lover 
//13 Training 4     | Loyal Dickgirl Courtesan |           | Dickgirl Winner  |            |                      | Deomoness 
//14 Training 5     |                          |           |                  |            |                      | Drug Whore
//15 Training 6     |
//16 Training 7     |
//17 Training 8     |
//18 Training 9     |
//19 Training 10    |
//20 Training 11    |

//Advanced Training | Ranma              | Rei                               | Riesz                    | Shampoo      
//10 Training 1     | Running Away       | Failed Exorcist                   | Dickgirl Toy             | Dickgirl Mother  
//11 Training 2     | Cat-slave          | Failed Exorcist Dickgirl          | Wolf Knight | Cat Savior | Perfect Slave  
//12 Training 3     | Loyal Courtesan    | Pure                              | Dickgirl Wolf Knight     |     
//13 Training 4     | Dickgirl Cat-slave | Pure Dickgirl                     | Tentacle Queen           |       
//14 Training 5     |                    | Failed Exorcist (Corrupt)         | Dickgirl Tentacle Queen             
//15 Training 6     |                    | Failed Exorcist Dickgirl (Corrupt) 
//16 Training 7     |                    | Corrupt 
//17 Training 8     |                    | Corrupt Dickgirl 
//18 Training 9     |                    | Assistant 
//19 Training 10    |                    | Assistant Dickgirl
//20 Training 11    |                    | Bride of the Gods

//Advanced Training | Urd                | Yurika                  | Menace                      
//10 Training 1     | Alchemist          | Dickgirl Cow            | Arena Cat Champion
//11 Training 2     | Dickgirl Alchemist | Duel Prize Dickgirl Cow | Arena Champion        
//12 Training 3     |                    |                         | Drug Whore
//13 Training 4     |                    |                         | Exile
//14 Training 5     |                    |                         | Cat Girl
//15 Training 6     |                    | 
//16 Training 7     |                    |  
//17 Training 8     |                    | 
//18 Training 9     |                    | 
//19 Training 10    |                    | 
//20 Training 11    |                    | 

*/

//basic file added to all pull out of slavemaker SDK examples

// ShowAssistant - shows a graphic for the assistant
// 1 = normal view in small rectangle
// 2 = tentacle sex (small version shown when slave girl raped)
// 3 = raped // small
// 4 = ignore this (shown when assistant is absent)
// 5 = wet - she falls in some water
// 6 = large graphic shown when your slave runs away

function funcClearMyBits() { //this function clears the bit flags so if Mugi is used with 2 slaves in a row the old slaves events arn't saved.
	if (_root.AssistantData.CustomString == _root.SlaveName) {
		return;
	}
	_root.AssistantData.CustomString = _root.SlaveName;
	_root.AssistantData.ClearBitFlag2(0);
	_root.AssistantData.ClearBitFlag2(1);
	_root.AssistantData.ClearBitFlag2(2);
	_root.AssistantData.ClearBitFlag2(3);
	_root.AssistantData.ClearBitFlag2(4);
	_root.AssistantData.ClearBitFlag2(5);
	_root.AssistantData.ClearBitFlag2(6);
	_root.AssistantData.ClearBitFlag2(7);
	_root.AssistantData.ClearBitFlag2(8);
	_root.AssistantData.ClearBitFlag2(9);
	_root.AssistantData.ClearBitFlag2(10);
	_root.AssistantData.ClearBitFlag2(11);
	_root.AssistantData.ClearBitFlag2(12);
	_root.AssistantData.ClearBitFlag2(13);
	_root.AssistantData.ClearBitFlag2(14);
	_root.AssistantData.ClearBitFlag2(15);
	_root.AssistantData.ClearBitFlag2(16);
	_root.AssistantData.ClearBitFlag2(17);
	_root.AssistantData.ClearBitFlag2(18);
	_root.AssistantData.ClearBitFlag2(19);
	_root.AssistantData.ClearBitFlag2(20);
	_root.AssistantData.ClearBitFlag2(21);
	_root.AssistantData.ClearBitFlag2(22);
	_root.AssistantData.ClearBitFlag2(23);
	_root.AssistantData.ClearBitFlag2(24);
	_root.AssistantData.ClearBitFlag2(25);
	_root.AssistantData.ClearBitFlag2(26);
	_root.AssistantData.ClearBitFlag2(27);
	_root.AssistantData.ClearBitFlag2(28);
	_root.AssistantData.ClearBitFlag2(29);
	_root.AssistantData.ClearBitFlag2(30);
	_root.AssistantData.ClearBitFlag2(31);
	_root.AssistantData.ClearBitFlag2(32);
	_root.AssistantData.ClearBitFlag2(33);
	_root.AssistantData.ClearBitFlag2(34);
	_root.AssistantData.ClearBitFlag2(35);
	_root.AssistantData.ClearBitFlag2(36);
	_root.AssistantData.ClearBitFlag2(37);
	_root.AssistantData.ClearBitFlag2(38);
	_root.AssistantData.ClearBitFlag2(39);
	_root.AssistantData.ClearBitFlag2(40);
	_root.AssistantData.ClearBitFlag2(41);
	_root.AssistantData.ClearBitFlag2(42);
	_root.AssistantData.ClearBitFlag2(43);
	_root.AssistantData.ClearBitFlag2(44);
	_root.AssistantData.ClearBitFlag2(45);
	_root.AssistantData.ClearBitFlag2(46);
	_root.AssistantData.ClearBitFlag2(47);
	_root.AssistantData.ClearBitFlag2(48);
	_root.AssistantData.ClearBitFlag2(49);
	_root.AssistantData.ClearBitFlag2(50);
	_root.AssistantData.ClearBitFlag2(51);
	_root.AssistantData.ClearBitFlag2(52);
	_root.AssistantData.ClearBitFlag2(53);
	_root.AssistantData.ClearBitFlag2(54);
	_root.AssistantData.ClearBitFlag2(55);
	_root.AssistantData.ClearBitFlag2(56);
	_root.AssistantData.ClearBitFlag2(57);
	_root.AssistantData.ClearBitFlag2(58);
	_root.AssistantData.ClearBitFlag2(59);
	_root.AssistantData.ClearBitFlag2(60);
	_root.AssistantData.ClearBitFlag2(61);
}

// ShowAssistant - shows a graphic for the assistant
// 1 = normal view in small rectangle
// 2 = tentacle sex (small version shown when slave girl raped)
// 3 = raped
// 4 = ignore this (shown when assistant is absent)
// 5 = wet - she falls in some water
// 6 = large graphic shown when your slave runs away
function ShowAsAssistant(type:Number) : Boolean
{
	if (type == 1) _root.ShowMovie(Assistant, 0, 0, 1);
	else if (type == 3) _root.ShowMovie(Assistant, 0, 1, 3);
	else if (type == 6) _root.ShowMovie(Assistant, 1, 2, 2);
	else return false;
	return true;
}

// HideAsAssistant - hide the assistant graphics
function HideAsAssistant()
{
	Assistant._visible = false;
}

// InitialiseAsAssistant - sets up the assistant

function InitialiseAsAssistant(): MovieClip {
	HideAsAssistant();
	_root.ServantName = "Shena";
	_root.ServantPronoun = "I";	
	_root.ServantGender = 3;	
	_root.AssistantTentacleSex = false;
	_root.AssistantDescription = "A noble from a distant kingdom, one of the rare furry women.\r\rShe is caring and increases Sensibility, but is also a bit of a slut and increases Nymphomania.";	
	_root.AssistantCost = 300;
	_root.AssistantData.sNoble = 1;
	_root.AssistantFurryNeeded = true;

	_root.AssistantData.CustomFlag = 50;
	funcClearMyBits();
	GuidedToday = 0; // guided training start dont want it unassigned 
	_root.AssistantData.SetBitFlag2(0);//advanced is available remove from final
	return Assistant;
}


//If Slavegirl has a generic start messege will replace
function StartMessageAsAssistant() : Boolean
{
	_root.ServantSpeak("The training of our dear #slave will last for " + _root.TrainingTime + " days, and then " + _root.SlaveHeShe + " will be delivered to " + _root.SlaveHisHer + " owner.", true);
	return true;
}

//Night Part 2 when they go to planning
function StartNightAsAssistant(intro:Boolean) : Boolean {
	if (intro) {
		_root.ServantSpeak("Cuddles " + _root.SlaveMakerName + "! You can play with #slave and I hope I get tp play too.", false);
		_root.BlankLine();
		funcNightStart();
		return true;
	}
	return false;
}

//Night Start before planning
function StartEveningAsAssistant() : Boolean {
	_root.ServantSpeak(_root.SlaveMakerName + ", good evening. It was fun today, let's hope tonight will be be more so.", true );
	_root.BlankLine();
	funcWarningsForNight();
	funcNightStart();
	_root.BlankLine();
	return true;
}

function EmployAsAssistant() {
	_root.VarNymphomania += 5;
	_root.VarSensibility += 5;
}

function ApplyDifficultyAsAssistant(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number) {
	_root.SensibilityFactor *= 1.2;
	_root.NymphomaniaFactor *= 1.2;
}

//First events of the day
function StartDayAsAssistant() : Boolean  {
	
	return false;
}

//Also first events of the day
function StartMorningAsAssistant(intro:Boolean) : Boolean 
{
	_root.ServantSpeak("Good morning " + _root.SlaveMakerName + ". Let us play more with #slave?", true);
	_root.BlankLine();
	funcDayStart();
	return true;
}

//Todays Mugi Help!
function funcDayStart() {
	funcWarningsForDay();//look to see if anything important that the SM should be aware of
	if (asCheckDay == 1 ) {
		asCheckDay = 2;
		funcDayWinCheck(); //checks to see the current score and current endings
		if (_root.AssistantData.CheckBitFlag2(3) == true ) {
			_root.BlankLine();
			funcGuidedWin();
		}
	}
	else if (asCheckDay == 2 ) {
		asCheckDay = 3;
		tempTotal = 0; //clears the undone variable this counts to 10, will keep the same item from being suggested over and over
		funcDayUndoneItems(); //checks for undone items and suggests one
		if (_root.AssistantData.CheckBitFlag2(3) == true ) {
			_root.BlankLine();
			funcGuidedWin();
		}
	}
	else {
		if (_root.AssistantData.CheckBitFlag2(1) != true) { //not on Basic function endings
			asCheckDay = 1;
			funcDaySpecialWin();//looks at the available special endings
			if (_root.AssistantData.CheckBitFlag2(3) == true ) {
				_root.BlankLine();
				funcGuidedWin();
			}
		}
		else {
			asCheckDay = 1;
			funcDayStart();//if on basic reset flag and call the function again
		}
	}
	DayCounter = DayCounter + 1;
	if (_root.AssistantData.CheckBitFlag2(5) || _root.AssistantData.CheckBitFlag2(6)) {
		funcShowMeEverything();
		DayCounter = 0;//I know it really doesnt matter but i hate the thought of a variable going on forever
	}
	else if (_root.AssistantData.CheckBitFlag2(7) && DayCounter == 2) {
		funcShowMeEverything();
		DayCounter = 0;
	}
	else if (_root.AssistantData.CheckBitFlag2(7) && DayCounter == 3) {
		funcShowMeEverything();
		DayCounter = 0;
	}
}

//Tonights Mugi Help!
function funcNightStart() {
	if (asCheckNight == 1 ) {//Checks undone items
		asCheckNight = 2;
		tempTotal = 0;//resets number of repeats in undone 
		funcNightUndone();
	}
	else if (asCheckNight == 2 ) {
		asCheckNight = 3;
		funcNightSkillUp();//Looks for a skill up and suggests
	}
	else {
		asCheckNight = 1;
		funcNightSpecial();//Gives advice for training
	}
	if (_root.AssistantData.CheckBitFlag2(5)) {
		funcShowMeEverything();
	}
}

function funcWarningsForDay() { //checks to see if anything needs to be done today or if anything is aproaching
	if (warningsCheck != _root.Elapsed) {//makes sure that funcWarnings isn't repeated multiple times
		warningsCheck = _root.Elapsed;
		if (SlaveName == "Menace" && _root.CheckBitFlag2(40) != true) {
			_root.ServantSpeak("Be advised there are " + funcArenaMath() + " days until the arena championship.", true);
			_root.BlankLine();
		}
		if (SlaveName == "Orihime" && _root.CheckBitFlag2(45) && _root.CheckBitFlag2(46) && _root.CheckBitFlag2(47) != true  && _root.CustomFlag2 < 6) {
			if (_root.CustomFlag2 == 1 ) {
				temp = 5;
			}
			else if (_root.CustomFlag2 == 2 ) {
				temp = 4;
			}
			else if (_root.CustomFlag2 == 3 ) {
				temp = 3;
			}
			else if (_root.CustomFlag2 == 4 ) {
				temp = 2;
			}
			else if (_root.CustomFlag2 == 5 ) {
				temp = 1;
			}
			_root.ServantSpeak("Be advised there are " + temp + " days until the eclipse.", true);
			_root.BlankLine();
		}
		if (_root.AntidoteDays > 0 && _root.DickgirlXF != 0 && _root.DickgirlXF != 2) {
			_root.ServantSpeak("The Priapus draft antidote is available now, just stop by Astrid's place.", true);
		}
		if (_root.AntidoteDays > -1 && _root.DickgirlXF != 0 && _root.DickgirlXF != 2) {
			_root.ServantSpeak("The Priapus draft antidote will be offered by Astrid in " + _root.AntidoteDays + " days.", true);
		}
		if (_root.VarFatigueRounded > 42) {
			_root.ServantSpeak("<b>#slave is looking tired, she needs to rest soon.</b>.", true);
			_root.BlankLine();
		}
	}
}

function funcDayWinCheck() {//checks to see win conditions and where what she would win if completed now
	_root.ServantSpeak("Your training of #slave seems to be leading towards her becoming a " + funcEnding() + ".", true);
	_root.BlankLine();
	_root.ServantSpeak("If I was going to rate your training of #slave it would be around " + funcScoreMath() + ".", true);
	//_root.BlankLine();
}

function funcContestTestingToday() :Boolean{ //returns true if there was a contest or an owner testing today
	if ((_root.GameDate % 8) == 0 ) {
		return true;
	}
	else if  ((_root.GameDate % 7) == 0 ){
		return true;
	}		
	else {
		return false;
	}
}

function funcRaiseScore() {//Guiding to raise overall score
	_root.ServantSpeak("Guided Training: Raise Score", true);
}

function funcLowerScore() {//Guiding to Lower overall score
	_root.ServantSpeak("Guided Training: Lower Score", true);
}

function funcRaiseStat(stat:Number) {//guiding to raise 1 stat, stats are in order of points or list on screen
	if (stat == 1) {
		_root.ServantSpeak("Guided Training: Raise Charisma", true);
	}
	else if (stat == 2) {
		_root.ServantSpeak("Guided Training: Raise Sensibility", true);
	}
	else if (stat == 3) {
		_root.ServantSpeak("Guided Training: Raise Refinment", true);
	}
	else if (stat == 4) {
		_root.ServantSpeak("Guided Training: Raise Intelligence", true);
	}
	else if (stat == 5) {
		_root.ServantSpeak("Guided Training: Raise Morality", true);
	}
	else if (stat == 6) {
		_root.ServantSpeak("Guided Training: Raise Constitution", true);
	}
	else if (stat == 7) {
		_root.ServantSpeak("Guided Training: Raise Cooking", true);
	}
	else if (stat == 8) {
		_root.ServantSpeak("Guided Training: Raise Cleaning", true);
	}
	else if (stat == 9) {
		_root.ServantSpeak("Guided Training: Raise Conversation", true);
	}
	else if (stat == 10) {
		_root.ServantSpeak("Guided Training: Raise Blow Job", true);
	}
	else if (stat == 11) {
		_root.ServantSpeak("Guided Training: Raise Fucking", true);
	}
	else if (stat == 12) {
		_root.ServantSpeak("Guided Training: Raise Temperament", true);
	}
	else if (stat == 13) {
		_root.ServantSpeak("Guided Training: Raise Nymphomania", true);
	}
	else if (stat == 14) {
		_root.ServantSpeak("Guided Training: Raise Obedience", true);
	}
	else if (stat == 15) {
		_root.ServantSpeak("Guided Training: Raise Libido", true);
	}
	else if (stat == 16) {
		_root.ServantSpeak("Guided Training: Raise Reputation", true);
	}
	else if (stat == 17) {
		_root.ServantSpeak("Guided Training: Raise Fatigue", true);
	}
	else if (stat == 18) {
		_root.ServantSpeak("Guided Training: Raise Joy", true);
	}
	else if (stat == 19) {
		_root.ServantSpeak("Guided Training: Raise Love", true);
	}
	else if (stat == 20) {
		_root.ServantSpeak("Guided Training: Raise Special", true);
	}
}

function funcLowerStat(stat:Number) {//guiding to lower 1 stat, stats are in order of points or list on screen
	if (stat == 1) {
		_root.ServantSpeak("Guided Training: Lower Charisma", true);
	}
	else if (stat == 2) {
		_root.ServantSpeak("Guided Training: Lower Sensibility", true);
	}
	else if (stat == 3) {
		_root.ServantSpeak("Guided Training: Lower Refinment", true);
	}
	else if (stat == 4) {
		_root.ServantSpeak("Guided Training: Lower Intelligence", true);
	}
	else if (stat == 5) {
		_root.ServantSpeak("Guided Training: Lower Morality", true);
	}
	else if (stat == 6) {
		_root.ServantSpeak("Guided Training: Lower Constitution", true);
	}
	else if (stat == 7) {
		_root.ServantSpeak("Guided Training: Lower Cooking", true);
	}
	else if (stat == 8) {
		_root.ServantSpeak("Guided Training: Lower Cleaning", true);
	}
	else if (stat == 9) {
		_root.ServantSpeak("Guided Training: Lower Conversation", true);
	}
	else if (stat == 10) {
		_root.ServantSpeak("Guided Training: Lower Blow Job", true);
	}
	else if (stat == 11) {
		_root.ServantSpeak("Guided Training: Lower Fucking", true);
	}
	else if (stat == 12) {
		_root.ServantSpeak("Guided Training: Lower Temperament", true);
	}
	else if (stat == 13) {
		_root.ServantSpeak("Guided Training: Lower Nymphomania", true);
	}
	else if (stat == 14) {
		_root.ServantSpeak("Guided Training: Lower Obedience", true);
	}
	else if (stat == 15) {
		_root.ServantSpeak("Guided Training: Lower Libido", true);
	}
	else if (stat == 16) {
		_root.ServantSpeak("Guided Training: Lower Reputation", true);
	}
	else if (stat == 17) {
		_root.ServantSpeak("Guided Training: Lower Fatigue", true);
	}
	else if (stat == 18) {
		_root.ServantSpeak("Guided Training: Lower Joy", true);
	}
	else if (stat == 19) {
		_root.ServantSpeak("Guided Training: Lower Love", true);
	}
	else if (stat == 20) {
		_root.ServantSpeak("Guided Training: Lower Special", true);
	}
}

function funcNormalWin(){//normal win conditions.
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 50 && _root.VarObedienceRounded > 30 && _root.VarObedienceRounded < 85) {//check for acomplishment if true exit
		_root.ServantSpeak("I think you have acomplished training <b>Normal</b>.", true);
		return;
	}
	if (funcScoreMath() < 50 && GuidedToday == 0) {//score over 50 for normal
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarObedienceRounded < 30 && GuidedToday == 1) {//odedience over 30 for normal
		funcRaiseStat(14);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarObedienceRounded > 85 && GuidedToday == 2) {//odedience under 85 for normal
		funcLowerStat(14);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcNormalWin();
	}
}

function funcNormalMinusWin(){
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 50 && _root.VarObedienceRounded < 30) {
		_root.ServantSpeak("I think you have acomplished training <b>Normal -</b>.", true);
		return;
	}
	if (funcScoreMath() < 50 && GuidedToday == 0) {
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarObedienceRounded > 30 && GuidedToday == 1) {
		funcLowerStat(14);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcNormalMinusWin();
	}
}

function funcNormalPlusWin(){//Normal +
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 50 && _root.VarObedienceRounded > 85 && _root.VarMoralityRounded > 45) {
		_root.ServantSpeak("I think you have acomplished training <b>Normal +</b>.", true);
		return;
	}
	if (funcScoreMath() < 50 && GuidedToday == 0) {//score under 50
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarObedienceRounded < 85 && GuidedToday == 1) {//obedience under 85
		funcRaiseStat(14);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarMoralityRounded < 45 && GuidedToday == 2) {//morality less then 45
		funcRaiseStat(5);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcNormalPlusWin();
	}
}

function funcMaidWin(){
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 40 && _root.VarCookingRounded > 60 && _root.VarCleaningRounded > 60) {
		_root.ServantSpeak("I think you have acomplished training <b>Maid</b>.", true);
		return;
	}
	if (funcScoreMath() < 40 && GuidedToday == 0) {//need to raise score over 40
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarCookingRounded < 60 && GuidedToday == 1) {//cooking over 60
		funcRaiseStat(7);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarCleaningRounded < 60 && GuidedToday == 2) {//cleaning over 60
		funcRaiseStat(8);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcMaidWin();
	}
}

function funcRebelWin(){
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarObedienceRounded < 15) {
		_root.ServantSpeak("I think you have acomplished training <b>Rebel</b>.", true);
		return;
	}
	else {//lower odedience only option
		funcLowerStat(14);
		GuidedToday = 1;
		return;
	}
}

function funcSexAddictWin(){
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 40 && _root.VarNymphomaniaRounded > 75 && _root.VarLustRounded > 75) {
		_root.ServantSpeak("I think you have acomplished training <b>Sex Addict</b>.", true);
		return;
	}
	if (funcScoreMath() < 40 && GuidedToday == 0) {//need to raise score over 40
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarNymphomaniaRounded < 75 && GuidedToday == 1) {//Nympho under 85
		funcRaiseStat(13);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarLustRounded < 75 && GuidedToday == 2) {//Lust under 85
		funcRaiseStat(15);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcSexAddictWin();
	}
}

function funcSexManiacWin(){
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 40 && _root.VarNymphomaniaRounded > 85 && _root.VarLustRounded > 85) {
		_root.ServantSpeak("I think you have acomplished training <b>Sex Maniac</b>.", true);
		return;
	}
	if (funcScoreMath() < 40 && GuidedToday == 0) {//need to raise score over 40
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarNymphomaniaRounded < 85 && GuidedToday == 1) {//Nympho under 85
		funcRaiseStat(13);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarLustRounded < 85 && GuidedToday == 2) {//Lust under 85
		funcRaiseStat(15);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcSexManiacWin();
	}
}

function funcWeddingWin(){//wedding
	if (funcScoreMath() > 75) {
		_root.ServantSpeak("I think you have acomplished training <b>Wedding</b>.", true);
		return;
	}
	else {//Raise score only option
		funcRaiseScore();
		return;
	}
}

function funcRichWin(){
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 40 && _root.GetTotalDresses() > 4 && _root.VarGold > 3000) {
		_root.ServantSpeak("I think you have acomplished training <b>Rich</b>.", true);
		return;
	}
	if (funcScoreMath() < 40 && GuidedToday == 0) {//need to raise score over 40
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.GetTotalDresses() > 4 && GuidedToday == 1) {//Not enough Dresses
		_root.ServantSpeak("Must have 4 or more dresses.", true);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarGold < 3000 && GuidedToday == 2) {//must have 3000 gold
		_root.ServantSpeak("Must have more then 3000 gold.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRichWin();
	}
}

function funcPotionCounter():Number{
	temp = _root.PotionsUsed[5];//Dorei
	temp = _root.PotionsUsed[6] + temp;//Zodai
	temp = _root.PotionsUsed[7] + temp;//Gaman
	temp = _root.PotionsUsed[8] + temp;//Biyaku
	temp = _root.PotionsUsed[9] + temp;//Ishinai
	return temp;
}

function funcDrugAddictWin(){//Drug Addict
	if (funcPotionCounter() > 3) {
		_root.ServantSpeak("I think you have acomplished training <b>Drug Addict</b>.", true);
		return;
	}
	else {//Raise score only option
		_root.ServantSpeak("You need to get her more drugs, try the slums.", true);
		return;
	}
}

function funcSandMWin() {//S&M
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 40 && _root.TotalBondage > 20) {
		_root.ServantSpeak("I think you have acomplished training <b>S&M</b>.", true);
		return;
	}
	if (funcScoreMath() < 40 && GuidedToday == 0) {//points less then 40
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.TotalBondage < 20 && GuidedToday == 1) {//Bondage less then 20
		_root.ServantSpeak("You need to make her do bondage actions to complete this training.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcSandMWin();
	}
}

function funcCourtesanWin() { //courtesian
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarCharismaRounded > 95 && _root.VarConversationRounded > 99 && _root.VarRefinementRounded > 60 && _root.VarFuckingRounded > 90 && _root.VarBlowjobsRounded > 90 && _root.DoneCourtesan == true) {
		_root.ServantSpeak("I think you have acomplished training <b>Courtesan</b>.", true);
		return;
	}
	if (_root.VarCharismaRounded < 95 && GuidedToday == 0) {//need to raise Charisma over 95
		funcRaiseStat(1);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarConversationRounded < 99 && GuidedToday == 1) {//need to raise conversation over 99
		funcRaiseStat(9);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarRefinementRounded < 60 && GuidedToday == 2) {//need to raise refinement over 60
		funcRaiseStat(3);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (_root.VarFuckingRounded < 90 && GuidedToday == 3) {//need to raise fucking over 90
		funcRaiseStat(11);
		GuidedToday = 4;
		return;
	}
	else {
		GuidedToday = 4;
	}
	if (_root.VarBlowjobsRounded < 90 && GuidedToday == 4) {//Not enough BJ over 90
		funcRaiseStat(10);
		GuidedToday = 5;
		return;
	}
	else {
		GuidedToday = 5;
	}
	if (_root.DoneCourtesan != true && GuidedToday == 5) {//
		_root.ServantSpeak("Training with Courtesian Required", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcCourtesanWin();
	}
}

function funcDickGirlWin() {//Dick Girl 
	if (_root.IsPermanentDickgirl == true) {
		_root.ServantSpeak("I think you have accomplished <b>Dick Girl<\b>", true);
		return;
	}
	if (_root.IsDickgirl == true ) {
		_root.ServantSpeak(SlaveName + " needs to refuse the Priapus draft antidote.  It will be offered by Astrid in " + _root.AntidoteDays + " days.", true);
	}
	else {
		temp = 3 - _root.PotionsUsed[0];
		_root.ServantSpeak(SlaveName + " needs to drink Priapus draft " + temp + " more times, before she can become a dick girl.", true);
		return;
	}
}

function funcDickGirlCourtesanWin() {//Dick Girl Courtesan
	if (_root.DoneCourtesan == true && _root.IsPermanentDickgirl() == true) {
			_root.ServantSpeak("I think you have accomplished <b>Dick Girl Courtesan<\b>", true);
			return;
	}
	else if (DGCW != 1 && _root.IsPermanentDickgirl() != true) {
		DGCW = 1;
		funcDickGirlWin();
		return;
	}
	else {
		if (_root.DoneCourtesan != true && DGCW == 1) {
			DGCW = 0;
			funcCourtesanWin();
			return;
		}
		else {
			DGCW = 0;
			funcDickGirlCourtesanWin();
		}
	}			
}

function funcPonyGirlWin() {//Pony Girl
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() > 50 && _root.DonePonygirl == true) {
		_root.ServantSpeak("I think you have acomplished training <b>Pony Girl</b>.", true);
		return;
	}
	if (_root.sPonyTrainer < 1 ) {
		_root.ServantSpeak("You can not acomplish the training <b>Pony Girl</b> until you are able to train pony girls.  Try <b>Personally</b> walking around the dock.", true);
		return;
	}
	if (_root.BitGagOK != true) {
		_root.ServantSpeak("You need a bit gag to train pony girls.  Try walking around the dock.", true);
		return;
	}
	if (_root.HarnessOK != true) {
		_root.ServantSpeak("You need a harness to train pony girls.  Try purchasing it from the traveling vendor.", true);
		return;
	}
	if (_root.PonyTailOK != true) {
		_root.ServantSpeak("You need a Pony Tail to train pony girls.  Try walking around the Palace.", true);
		return;
	}
	if (funcScoreMath() < 50 && GuidedToday == 0) {//points less then 50
		funcRaiseScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.DonePonygirl != true && GuidedToday == 1) {//Bondage less then 20
		if (_root.DifficultyPonygirl < _root.VarObedienceRounded) {
			funcRaiseStat(14);
		}
		else {
			_root.PersonSpeak("You need to make her agree to be a pony girl.", true);
		}
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcPonyGirlWin();
	}
}

function funcDickGirlPonyGirlWin() {//Dick Girl Pony Girl
	if (_root.DonePonygirl == true && _root.IsPermanentDickgirl() == true) {
		_root.ServantSpeak("I think you have accomplished <b>Dick Girl Pony Girl<\b>", true);
		return;
	}
	else if (DGCW != 1 && _root.IsPermanentDickgirl() != true) {
		DGCW = 1;
		funcDickGirlWin();
		return;
	}
	else {
		if (_root.DonePonygirl != true && DGCW == 1) {
			DGCW = 0;
			funcPonyGirlWin();
			return;
		}
		else {
			DGCW = 0;
			funcDickGirlPonyGirlWIn();
		}
	}		
}

function funcCowGirlWin(){//Cow Girl
	if (_root.TotalMilked > 6 ) {
		_root.ServantSpeak("I think you have accomplished <b>Cow Girl<\b>", true);
		return;
	}
	else {
		temp = 6 - _root.TotalMilked;
		_root.ServantSpeak("To accomplish the cow girl training, #slave needs to be milked " + temp + " more times.", true);
		return;
	}
}

function funcProstituteWin() {//Prostitute
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (funcScoreMath() < 50 && _root.VarObedienceRounded > 15) {
		_root.ServantSpeak("I think you have acomplished training <b>Prostitute</b>.", true);
		return;
	}
	if (funcScoreMath() > 50 && GuidedToday == 0) {//need to raise score over 40
		funcLowerScore();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarObedienceRounded < 15 && GuidedToday == 1) {//Not enough obedience
		funcRaiseStat(14);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcProstituteWin();
	}
}

function funcAyaneLoyalWin() {//Ayane Loyal Win
	_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.", true);  
	return;
}

function funcAyaneLoyalDickgirlWin() {//Ayane Loyal Dickgirl
	if (_root.IsPermanentDickgirl() == true) {
		_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.  You have already accomplished the other goal of permanent dick girl.", true);  
		return;
	}
	else if (LDGW != 1 && _root.IsPermanentDickgirl() != true) {
		LDGW = 1;
		funcDickGirlWin();
		return;
	}
	else {
		_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.", true);  
		LDGW = 0;
		return;
	}		
}

function funcAyaneLoyalCourtesanWin() {//Ayane Loyal Cortesan
	if (_root.DoneCourtesan == true) {
		_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.  You have already accomplished the other goal of Courtesan.", true);  
		return;
	}
	else if (LDGW != 1 && _root.DoneCourtesan != true) {
		LDGW = 1;
		funcCourtesanWin();
		return;
	}
	else {
		_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.", true);  
		LDGW = 0;
		return;
	}		
}

function funcAyaneLoyalCourtesanDickGirlWin(){//Ayane DickGirl Loyal Cortesan
	if (_root.IsPermanentDickgirl() == true && _root.DoneCourtesan == true) {
		_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.  You have already accomplished the other goal of permanent dick girl and Courtesan.", true);  
		return;
	}
	else if (LDGW != 1 && _root.IsPermanentDickgirl() != true && _root.DoneCourtesan != true) {
		LDGW = 1;
		funcDickGirlCourtesanWin();
		return;
	}
	else {
		_root.ServantSpeak("I'm sorry, currently I have no direct way to verify the training <b>Loyal</b>.  What you need to do is defeat #slave when she runs away, afterwards accept to be her owner when she asks.", true);  
		LDGW = 0;
		return;
	}	
}

function funcBelldandyDaemonWin() {//Belldandy Daemon
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarNymphomaniaRounded > 80 && _root.VarObedienceRounded > 80 && _root.VarLustRounded > 80 && _root.VarSpecialRounded > 80) {
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave accepted the demon's offer at the docks.  I can see that she has met all other requirements.", true);
		return;
	}
	if (_root.VarNymphomaniaRounded < 80 && GuidedToday == 0) {//need to raise Nymphomania over 80
		funcRaiseStat(13);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarObedienceRounded < 80 && GuidedToday == 1) {//need to raise Obedience over 80
		funcRaiseStat(14);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarLustRounded < 80 && GuidedToday == 2) {//need to raise Lust over 80
		funcRaiseStat(15);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (_root.VarSpecialRounded < 80 && GuidedToday == 3) {//need to raise Seduction over 80
		_root.ServantSpeak(SlaveName + " needs to raise seduction over 80.", true)
		GuidedToday = 4;
		return;
	}
	else {
		GuidedToday = 4;
	}
	if (GuidedToday == 4) {//belldandy Daemon speach
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave accepted the demon's offer at the docks.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcBelldandyDaemonWin();
	}
}

function funcBelldandyAngelWin(){//Belldandy Angel
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarCharismaRounded > 80 && _root.VarMoralityRounded > 80 && _root.VarJoyRounded > 80 && _root.DressWorn == 6) {
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave has refused the demon's offer at the docks, and accepted the angels offer at the lake.  I can see that she has met all other requirements.", true);
		return;
	}
	if (_root.VarCharismaRounded < 80 && GuidedToday == 0) {//need to raise Nymphomania over 80
		funcRaiseStat(1);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarMoralityRounded < 80 && GuidedToday == 1) {//need to raise Morality over 80
		funcRaiseStat(5);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarJoyRounded < 80 && GuidedToday == 2) {//need to raise Joy over 80
		funcRaiseStat(18);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (_root.DressWorn == 6 && GuidedToday == 3) {//need to wear angel dress
		_root.ServantSpeak(SlaveName + " needs to be wearing the Angel dress.", true)
		GuidedToday = 4;
		return;
	}
	else {
		GuidedToday = 4;
	}
	if (GuidedToday == 4) {//belldandy Angel speach
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave has refused the demon's offer at the docks, and accepted the angels offer at the lake.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcBelldandyAngelWin();
	}
}

function funcKasumiCumslutWin() {//Kasumi Cumslut
	if (SlaveName == "Cumslut Kasumi") {
		_root.ServantSpeak("She seems to be #slave congratulation you have acomplished her special training.", true);
	}
	else {
		_root.ServantSpeak(SlaveName + " is still not a cumslut, continue to make her give blowjobs.  At this time I can not count how many she still needs to give a blowjob.", true);
	}
}

function funcKasumiCumslutDickgirlWin() {//Kasumi Cumslut DickGirl
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (SlaveName == "Cumslut Kasumi" && _root.IsDickgirl() == true) {
		_root.ServantSpeak("She seems to be #slave and a dickgirl congratulation you have acomplished her special training.", true);
		return;
	}
	if (_root.IsDickgirl() != true && GuidedToday == 0) {//need to raise Nymphomania over 80
		funcDickGirlWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (SlaveName != "Cumslut Kasumi" && GuidedToday == 1) {//need to raise Morality over 80
		_root.ServantSpeak(SlaveName + " is still not a cumslut, continue to make her give blowjobs.  At this time I can not count how many she still needs to give a blowjob.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcKasumiCumslutDickgirlWin();
	}
}

function funcKasumiWinnerWin(){//Kasumi Winner
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarConstitutionRounded > 80 && _root.VarTemperamentRounded > 70 && _root.VarOtherRounded > 80 && funcScoreMath() > 75 ) {
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave has been reminded of her love of martial arts.  I can see that she has met all other requirements.", true);
		return;
	}
	if (_root.VarConstitutionRounded < 80 && GuidedToday == 0) {//need to raise Constitution over 80
		funcRaiseStat(6);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarTemperamentRounded < 70 && GuidedToday == 1) {//need to raise Temperament over 70
		funcRaiseStat(12);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarOtherRounded < 80 && GuidedToday == 2) {//need to raise Other over 80
		funcRaiseStat(20);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (funcScoreMath() < 75 && GuidedToday == 3) {//Need to raise score over 75
		funcRaiseScore();
		GuidedToday = 4;
		return;
	}
	else {
		GuidedToday = 4;
	}
	if (GuidedToday == 4) {//belldandy Angel speach
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave has refused to be a cumslut, please make sure that you remind her of love of martial arts.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcKasumiWinnerWin();
	}
}

function funcKasumiWinnerDickGirlWin() {//Kasumi DickGirl Winner
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarConstitutionRounded > 80 && _root.VarTemperamentRounded > 70 && _root.VarOtherRounded > 80 && funcScoreMath() > 75 && _root.IsDickgirl() == true) {
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave has been reminded of her love of martial arts.  I can see that she has met all other requirements, including being a dickgirl.", true);
		return;
	}
	if (_root.VarConstitutionRounded < 80 && GuidedToday == 0) {//need to raise Constitution over 80
		funcRaiseStat(6);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarTemperamentRounded < 70 && GuidedToday == 1) {//need to raise Temperament over 70
		funcRaiseStat(12);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarOtherRounded < 80 && GuidedToday == 2) {//need to raise Other over 80
		funcRaiseStat(20);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (funcScoreMath() < 75 && GuidedToday == 3) {//Need to raise score over 75
		funcRaiseScore();
		GuidedToday = 4;
		return;
	}
	else {
		GuidedToday = 4;
	}
	if (_root.IsDickgirl() != true && GuidedToday == 4) {//need to be a dickgirl
		funcDickGirlWin();
		GuidedToday = 5;
		return;
	}
	else {
		GuidedToday = 5;
	}
	if (GuidedToday == 5) {//belldandy Angel speach
		_root.ServantSpeak("I am sorry, I can not at this time check to see if #slave has been reminded of her love of martial arts.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcKasumiWinnerDickGirlWin();
	}
	
}

function funcMenaceArenaCatChampionWin() { //Menace Cat Champion Win
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.CheckBitFlag2(6) && _root.CheckBitFlag2(19)) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Arena Cat Champion.", true);	
		return;
	}
	if (_root.CheckBitFlag2(6) != true && GuidedToday == 0) {//Arena Win
		_root.ServantSpeak(SlaveName + " needs to win the arena to advance towards her special training.", true);	
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.CheckBitFlag2(19) != true && GuidedToday == 1) {//Cat Win
		funcMenaceCatGirlWin();	
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcMenaceArenaCatChampionWin();
	}
}

function funcMenaceArenaChampionWin() { //Menace Champion Win
	if (_root.CheckBitFlag2(6)) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Cat Champion.", true);									   
	}
	else {
		_root.ServantSpeak(SlaveName + " needs to win the arena to advance towards her special training.", true);	
	}
}

function funcMenaceDrugWhoreWin(){//Menace Drug Whore
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.CheckBitFlag2(36) && _root.BadEndsOn == true) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Drug Whore.", true);
		return;
	}
	if (_root.BadEndsOn != true && GuidedToday == 0) {//Bad Ends ON
		_root.ServantSpeak("To get the ending <b>Drug Whore</b>, you will need to turn bad ends on, please visit the seer.", true);	
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.PotionsUsed[5] != 0 && GuidedToday == 1) {//Drug Dorei not taken
		_root.ServantSpeak(SlaveName + " needs to drink the drug Dorei.", true);	
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if ((_root.CheckBitFlag2(35) != true || _root.CheckBitFlag2(36) != true )&& GuidedToday == 2 && _root.PotionsUsed[5] > 0) {//Drug
		_root.ServantSpeak(SlaveName + " needs to drink any back alley drug.", true);	
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcMenaceDrugWhoreWin();
	}
}

function funcMenaceExileWin() {
	if ( _root.DoneCourtesan == true && _root.CheckBitFlag2(40)) {
		_root.ServantSpeak(SlaveName + " seems to have accomplshed the special training exile.", true);	
		return;
	}
	else {
		funcCourtesanWin();
	}
}

function funcMenaceCatGirlWin() {
	if (_root.CheckBitFlag2(19)) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Cat Girl, even more trainings may be available to include this one.", true);
		return;
	}
	if (_root.sCatTrainer == 0) {
		_root.ServantSpeak("You needs to be a cat slave trainer, to train #slave in this path.", true);
		return;
	}
	else if (_root.CheckBitFlag2(32) != true) {
		if ( _root.CustomFlag3 < 11) {
			_root.ServantSpeak(SlaveName + " needs to meet more cat slaves.", true);
		}
		else {
			_root.ServantSpeak(SlaveName + " needs to walk in town, before she can make a choice to become a cat slave.", true);
		}
	}
	else if (_root.CheckBitFlag2(19) != true) {
		_root.ServantSpeak(SlaveName + " needs to visit more cat slaves, I hear there is a meeting of cat slaves in the town.", true);
	}
}

function funcMinakoCatSlaveWin() {
	if (_root.DressWorn == 6) {
		_root.ServantSpeak("I am sorry, I can not confirm if #slave has accomplished her special training <b>Cat Slave</b>.  She may need to  meet cat slaves and keep talking to them about their life when given the opportunity.  Eventually, she will accept being a cat slave.  I can confirm that she is properly attired.", true);
		return;
	}
	else {
		_root.ServantSpeak(SlaveName + " needs to be wearing the cat dress.");
	}
}

function funcMinakoCatSaviorWin(){
	if (_root.DressWorn == 6) {
		_root.ServantSpeak("I am sorry, I can not confirm if #slave has accomplished her special training <b>Cat Savior</b>.  She will also need to meet cat slaves and keep talking to them about their life when given the opportunity.  Eventually, she will accept being a cat slave.  She will then need to meet the Cat slave at the Brothel to find that True Catgirls live in the Forest and be given the proper greeting.  She will then go to the Lake and agree to help Millenia.  Find Malerna being abused by Tirana using the lend.  Discuss with her and then lend her to free Malerna, suggest loaning her, then Lend Her again, say you want to learn more, and then attack now. All other choices will fail. You will be Fined when you succeed and for each failure.  I can confirm that she is properly attired.", true);
		return;
	}
	else {
		_root.ServantSpeak(SlaveName + " needs to be wearing the cat dress.");
	}
}

function funcNaruBrideoftheGoddessWin(){
	if (funcScoreMath() > 75 ) {
		_root.ServantSpeak("I think you have accomplised the special training <b>Bride of the Goddess</b>.", true);
		return;
	}
	else {
		funcRaiseScore();
	}
}




function funcOrihimePriestessWin() {
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.CustomFlag > 25 && _root.VarIntelligence >= 78 && _root.VarMorality >= 78 ) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Priestess</b>.", true);
		return;
	}
	if (_root.CustomFlag < 25 && GuidedToday == 0) {//not enough preaches
		_root.ServantSpeak(SlaveName + " needs to preach the word of the old gods.", true);	
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarIntelligence < 78 && GuidedToday == 1) {//intelligence less then 78
		funcRaiseStat(4);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarMorality < 78 && GuidedToday == 2 ) {//morality less then 78
		funcRaiseStat(5);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcOrihimePriestessWin();
	}
}

function funcOrihimeCorruptPriestessWin() {
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.CustomFlag > 25 && _root.VarIntelligence > 78 && _root.VarMorality < 26 ) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Corrupt Priestess</b>.", true);
		return;
	}
	if (_root.CustomFlag < 25 && GuidedToday == 0) {//not enough preaches
		_root.ServantSpeak(SlaveName + " needs to preach the word of the old gods.", true);	
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarIntelligence < 78 && GuidedToday == 1) {//intelligence less then 78
		funcRaiseStat(4);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarMorality > 26 && GuidedToday == 2 ) {//morality greater then 26
		funcLowerStat(5);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcOrihimeCorruptPriestessWin();
	}
}
	
function funcOrihimeDemonLoverWin() {
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.CheckBitFlag2(47) == true  && _root.CheckBitFlag2(48) != true) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Demon Lover</b>.", true);
		return;
	}
	if (_root.CheckBitFlag2(40) != true ) {
		if (_root.CustomFlag4 < 5 && GuidedToday == 0) {//number of Demon Lover Events
			_root.ServantSpeak(SlaveName + " needs to meet with the darkness more often.", true);	
			GuidedToday = 1;
			return;
		}
		else {
			GuidedTop = 1;
			GuidedToday = 1;
		}
		if (_root.DressWorn != 6 && GuidedToday == 1) {//needs to wear a different dress
			_root.ServantSpeak(SlaveName + " needs to wear a demons dress.", true);	
			GuidedToday = 2;
			return;
		}
		else {
			GuidedToday = 2;
		}
		if (_root.DressWorn == 6 && _root.CustomFlag4 > 4 && _root.CheckBitFlag2(40) != true && GuidedToday == 2 ) {//morality greater then 26
			_root.ServantSpeak(SlaveName + " needs to meet with the darkness and accept him.", true);	
			GuidedToday = 0;
			return;
		}
		else {
			GuidedToday = 0;
		}
		if (GuidedTop == 1) {
			return;
		}
		else {
			funcOrihimeDemonLoverWin();
		}
	}
	else if (_root.CheckBitFlag2(45) != true) {
		_root.ServantSpeak(SlaveName + " needs to walk in the slums and purchase the odd item.", true);	
		return;
	}
	else if (_root.CheckBitFlag2(46) != true) {
		_root.ServantSpeak(SlaveName + " needs to visit the farm at night on a full moon or new moon, I will anounce those days in my night warnings.", true);	
		return;
	}
	else if (_root.CheckBitFlag2(47) != true) {
		_root.ServantSpeak(SlaveName + " needs to visit the lake at noon on the day of the eclipse, when given the choice she must choose to not give in to her inner demon.", true);	
		return;
	}
}

function funcOrihimeDemonessWin() {//demoness
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.CheckBitFlag2(48) == true) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Demoness</b>.", true);
		return;
	}
	if (_root.CheckBitFlag2(40) != true ) {
		if (_root.CustomFlag4 < 5 && GuidedToday == 0) {//number of Demon Lover Events
			_root.ServantSpeak(SlaveName + " needs to meet with the darkness more often.", true);	
			GuidedToday = 1;
			return;
		}
		else {
			GuidedTop = 1;
			GuidedToday = 1;
		}
		if (_root.DressWorn != 6 && GuidedToday == 1) {//needs to wear a different dress
			_root.ServantSpeak(SlaveName + " needs to wear a demons dress.", true);	
			GuidedToday = 2;
			return;
		}
		else {
			GuidedToday = 2;
		}
		if (_root.DressWorn == 6 && _root.CustomFlag4 > 4 && _root.CheckBitFlag2(40) != true && GuidedToday == 2 ) {//morality greater then 26
			_root.ServantSpeak(SlaveName + " needs to meet with the darkness and accept him.", true);	
			GuidedToday = 0;
			return;
		}
		else {
			GuidedToday = 0;
		}
		if (GuidedTop == 1) {
			return;
		}
		else {
			funcOrihimeDemonessWin();
		}
	}
	else if (_root.CheckBitFlag2(45) != true) {
		_root.ServantSpeak(SlaveName + " needs to walk in the slums and purchase the odd item.", true);	
		return;
	}
	else if (_root.CheckBitFlag2(46) != true) {
		_root.ServantSpeak(SlaveName + " needs to visit the farm at night on a full moon or new moon, I will anounce those days in my night warnings.", true);	
		return;
	}
	else if (_root.CheckBitFlag2(47) != true) {
		_root.ServantSpeak(SlaveName + " needs to visit the lake at noon on the day of the eclipse, when given the choice she must choose to give in to her inner demon.", true);	
		return;
	}
}

function funcOrihimeDrugWhoreWin() {
	if ( _root.CheckBitFlag2(5)) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Drug Whore</b>.", true);
		return;
	}
	else if (_root.BadEndsOn != true) {
		_root.SlaveSpeak("You need to visit the seer and change bad ends on to accomplish this end.", true);
		return;
	}
	else {
		_root.SlaveSpeak(SlaveName + " must drink the potion Priapus Draft, I hear its manufactured near the lake.", true);
		return;
	}
}

function funcRanmaRunningAwayWin() {//Running Away
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarIntelligenceRounded < 20 && _root.VarTemperamentRounded > 35) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Running Away</b>.", true);
		return;
	}
	if (_root.VarIntelligenceRounded > 20 && GuidedToday == 0) {//Intelligence greater then then 20
		funcLowerStat(4);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.DressWorn != 6 && GuidedToday == 1) {//Temperment less then 35
		funcRaiseStat(12);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRanmaRunningAwayWin();
	}	
}

function funcRanmaCatSlaveWin(){//Cat Slave Win
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarConstitutionRounded > 80 && _root.VarLustRounded > 80 && _root.VarJoyRounded > 80 && _root.DressWorn == 6) {
		_root.SlaveSpeak("I think you have accomplished the special training <b>Cat Slave</b>.", true);
		return;
	}
	if (_root.VarConstitutionRounded < 80 && GuidedToday == 0) {//Constitution less then 80
		funcRaiseStat(6);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarLustRounded < 80 && GuidedToday == 1) {//Lust less then 80
		funcRaiseStat(15);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarJoyRounded < 80 && GuidedToday == 2) {//Joy less then 80
		funcRaiseStat(18);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (_root.DressWorn != 6 && GuidedToday == 3) {//Not wearing cat dress
		_root.ServantSpeak(SlaveName + " needs to be wearing the cat dress.", true);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRanmaCatSlaveWin();
	}
}
	
function funcRanmaDickGirlCatSlaveWin() {//Ranma Cat Slave Dick Girl
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarConstitutionRounded > 80 && _root.VarLustRounded > 80 && _root.VarJoyRounded > 80 && _root.DressWorn == 6 && _root.DickgirlXF == 2) {
		_root.ServantSpeak("I think you have accomplished the special training <b>Cat Slave Dick Girl</b>");
	}
	if ((_root.VarConstitutionRounded > 80 && _root.VarLustRounded > 80 && _root.VarJoyRounded > 80 && _root.DressWorn == 6) != true && GuidedToday == 0) {//check to see if Cat Girl is done
		funcRanmaCatSlaveWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if ( _root.DickgirlXF != 2 && GuidedToday == 1) {//Not a dick girl
		funcDickGirlWin();
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRanmaDickGirlCatSlaveWin();
	}
}

function funcReiFailedExorcistWin() { //Rei Failed Exorcist
	_root.ServantSpeak("I am still unable to check to see if this path has been completed.");
	return;
}

function funcReiFailedExorcistDickgirlWin() {//Rei Failed Exorcist Dickgirl
	if (_root.DickgirlXF == 2) {
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished one part dick girl.");
		return;
	}
	else {
		funcDickGirlWin();
	}
}

function funcReiPureWin():Boolean { //pure
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarSpecialRounded > 90 && _root.VarMoralityRounded > 80) {
		_root.ServantSpeak("I think you have accomplished the special training <b>Pure</b>");
		return true;
	}
	if (_root.VarPureRounded < 90 && GuidedToday == 0) {//special 90
		funcRaiseStat(20);
		GuidedToday = 1;
		return false;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if ( _root.VarMoralityRounded < 80 && GuidedToday == 1) {//Moraltiity 80
		funcRaiseStat(20);
		GuidedToday = 2;
		return false;
	}
	else {
		GuidedToday = 2;
	}
	if (GuidedToday == 2) {//win 4 of the exorcist events
		_root.ServantSpeak(SlaveName + " must succeed majority of exorcism tests (any 4).", true);
		GuidedToday = 0;
		return false;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return true;
	}
	else {
		funcReiPureWin();
	}
}

function funcReiPureDickGirlWin() {
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarSpecialRounded > 90 && _root.VarMoralityRounded > 80 && _root.DickgirlXF == 2) {
		_root.ServantSpeak("I think you have accomplished the special training <b>Dick Girl Pure</b>");
		return true;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return false;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if ( (_root.VarSpecialRounded > 90 && _root.VarMoralityRounded > 80) != true  && GuidedToday == 1) {//Pure
		funcReiPureWin();
		GuidedToday = 2;
		return false;
	}
	else {
		GuidedToday = 2;
	}
	if (GuidedToday == 2) {//win 4 of the exorcist events
		_root.ServantSpeak(SlaveName + " must succeed majority of exorcism tests (any 4).", true);
		GuidedToday = 0;
		return false;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return true;
	}
	else {
		funcReiPureDickGirlWin();
	}
}

function funcReiFailedExorcistCorruptWin() {
	_root.ServantSpeak("I am still unable to check to see if this path has been completed.");
}

function funcReiFailedExorcistCorruptDickGirlWin() {
	if (_root.DickgirlXF == 2) {
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished one part dick girl.");
		return;
	}
	else {
		funcDickGirlWin();
	}
}

function funcReiCorruptWin():Boolean {
	GuidedTop = 0;  //makes sure that all variables are checked and repeats it if they wernt if they were will exit out
	if (_root.VarSpecialRounded > 90 && _root.VarConversationRounded > 55 && _root.VarCharismaRounded > 90 && _root.VarConstitutionRounded > 60 && _root.VarBlowjobsRounded > 50 ) {
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished all the stat needed for it.  You will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.  Lastly she will need to recruit three followers.");
		return true;
	}
	if (_root.VarSpecialRounded < 90 && GuidedToday == 0) {//corruption 
		funcRaiseStat(20);
		GuidedToday = 1;
		return false;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarConversationRounded < 55 && GuidedToday == 1) {//Conversation
		funcRaiseStat(9);
		GuidedToday = 2;
		return false;
	}
	else {
		GuidedToday = 2;
	}
	if ( _root.VarCharismaRounded < 90 && GuidedToday == 2) {//Charisma
		funcRaiseStat(1);
		GuidedToday = 3;
		return false;
	}
	else {
		GuidedToday = 3;
	}
	if ( _root.VarConstitutionRounded < 60 && GuidedToday == 3) {//Constitution
		funcRaiseStat(6);
		GuidedToday = 4;
		return false;
	}
	else {
		GuidedToday = 4;
	}
	if ( _root.VarBlowjobsRounded < 50 && GuidedToday == 4) {//Blowjobs
		funcRaiseStat(10);
		GuidedToday = 5;
		return false;
	}
	else {
		GuidedToday = 5;
	}
	if (GuidedToday == 5) {//everything else
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished all the stat needed for it.  You will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.  Lastly she will need to recruit three followers.");
		GuidedToday = 0;
		return false;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return true;
	}
	else {
		funcReiCorruptWin();
	}
}

function funcReiCorruptDickGirlWin():Boolean {//Corrput Dick Girl Win
	if (_root.VarSpecialRounded > 90 && _root.VarConversationRounded > 55 && _root.VarCharismaRounded > 90 && _root.VarConstitutionRounded > 60 && _root.VarBlowjobsRounded > 50 && _root.DickgirlXF == 2) {
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished all the stat needed for it.  You will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.  Lastly she will need to recruit three followers.  I see that she is a dickgirl, can't say this is good, but it does fullfill the requirements for her training.");
		return true;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return false;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if ( (_root.VarSpecialRounded > 90 && _root.VarConversationRounded > 55 && _root.VarCharismaRounded > 90 && _root.VarConstitutionRounded > 60 && _root.VarBlowjobsRounded > 50) != true  && GuidedToday == 1) {//Pure
		funcReiCorruptWin();
		GuidedToday = 0;
		return false;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return true;
	}
	else {
		funcReiCorruptDickGirlWin();
	}
}

function funcReiAssistantWin():Boolean { //Rei Assistant
	if (_root.VarSpecialRounded > 85 && _root.DressWorn == 5) {
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished all the stat needed for it and you are wearing the correct dress.");
		return true;
	}
	if (_root.DressWorn != 5 && GuidedToday == 0) {//Wearing Chinese Dress
		_root.ServantSpeak(SlaveName + " needs to wear the chinese dress.");
		GuidedToday = 1;
		return false;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarSpecialRounded < 85 && GuidedToday == 1) {//Raise Special Stat 
		funcRaiseStat(20);
		GuidedToday = 0;
		return false;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return true;
	}
	else {
		funcReiAssistantWin();
	}
}

function funcReiAssistantDickgirlWin() { //Rei Assistant Dick Girl Win
	if (_root.VarSpecialRounded > 85 && _root.DressWorn == 5 && _root.DickgirlXF == 2) {
		_root.ServantSpeak("I am still unable to check to see if this path has been completed.  I can see that you have acomplished all the stat needed for it and you are wearing the correct dress and she is a dick girl.");
		return;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarSpecialRounded < 85 || _root.DressWorn != 5  && GuidedToday == 1) {//Assistant
		funcReiAssistantWin();
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcReiAssistantDickgirlWin();
	}
}

function funcReiBrideoftheGodWin() {//Rei Bride of the God Win
	if ( funcScoreMath() > 75 ) {
		_root.ServantSpeak("I am sorry, I can not see if you have completed this path.  #slave needs to be an assistant.  I can see that she has the necessary score for the ending, <b>Bride of the Gods</b>.");
		return;
	}
	else {
		funcRaiseScore();
	}
}

function funcRieszDickgirlToyWin() {//Riesz Dickgirl Toy
	if (_root.DickgirlXF == 2 && (_root.TotalBrothel + _root.TotalSleazyBar) > 20) {
		_root.ServantSpeak("I am sorry, I can not see if you have completed this training.  I can see that she has accomplished the training dick girl, and has been to the brothel and sleazy bar enough times.  The only other actions she will need to acomplish is to NOT bribe the hermaphite delegation and then Sell her to the dickgirl who appears later.");
		return;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if ((_root.TotalBrothel + _root.TotalSleazyBar) < 20  && GuidedToday == 1) {//Need more sleasy bar and brothel
		_root.ServantSpeak(SlaveName + " needs to work more at the Brothel and Sleazy Bar to accomplish this training.");
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRieszDickgirlToyWin();
	}
}

function funcRieszWolfKnightWin() {//Riesz Wolf Knight
	_root.ServantSpeak("I am sorry I can not guide you in the training of <b>Wolf Knight</b>, I can make some suggestions.\r\rShe will need to wear the wolf knight dress.  She will need to visit the knight to start a quest, for the quest she will need to capture 3 fairies, capture a demon girl, defeat 3 tentacles, and last harvest 7 leters of cum from a demon.", true);
}

function funcRieszWolfKnightDickGirlWin(){//Riesz Wolf Knight Dick Girl
	if (_root.DickgirlXF == 2 && (_root.TotalBrothel + _root.TotalSleazyBar) > 20) {
		_root.ServantSpeak("I am sorry I can not guide you in the training of <b>Dick Girl Wolf Knight</b>, I can make some suggestions.\r\rShe will need to wear the wolf knight dress.  She will need to visit the knight to start a quest, for the quest she will need to capture 3 fairies, capture a demon girl, defeat 3 tentacles, and last harvest 7 leters of cum from a demon.", true);
		return;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (true  && GuidedToday == 1) {//Wolf Knight
		funcRieszWolfKnightWin();
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRieszWolfKnightDickGirlWin();
	}
}

function funcRieszTentacleQueenWin() {//Riesz Tentacle Queen
	if (_root.VarConversationRounded > 66 && _root.VarNymphomaniaRounded > 70 && _root.VarLibidoRounded > 70 && _root.VarSpecialRounded > 46) {
		_root.ServantSpeak("I will help you in training #slave to become <b>Tentacle Queen</b>, unfortunatly there are many things I can not check for.  I can see that she has accomplished all the training she needs to recruit tentacle followers.\r\rShe will need to submit to the tentacles, then convert 4 people into tentacle followers.", true);
	}
	if (_root.VarConversationRounded < 66 && GuidedToday == 0) {//coversation less then 66
		funcRaiseStat(9);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (_root.VarNymphomaniaRounded < 70  && GuidedToday == 1) {//Nympho less then 70
		funcRaiseStat(13);
		GuidedToday = 2;
		return;
	}
	else {
		GuidedToday = 2;
	}
	if (_root.VarLibidoRounded < 70  && GuidedToday == 2) {//Libido less then 70
		funcRaiseStat(15);
		GuidedToday = 3;
		return;
	}
	else {
		GuidedToday = 3;
	}
	if (_root.VarSpecialRounded < 46  && GuidedToday == 3) {//special less then 46
		funcRaiseStat(20);
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRieszWolfKnightDickGirlWin();
	}
}

function funcRieszTentacleQueenDickGirlWin() {//Riesz Tentacle Queen Dick Girl
	if (_root.DickgirlXF == 2 && _root.VarConversationRounded > 66 && _root.VarNymphomaniaRounded > 70 && _root.VarLibidoRounded > 70 && _root.VarSpecialRounded > 46) {
		_root.ServantSpeak("I will help you in training #slave to become <b>Dick girl Tentacle Queen</b>, unfortunatly there are many things I can not check for.  I can see that she has accomplished all the training she needs to recruit tentacle followers and that she is a dick girl.\r\rShe will need to submit to the tentacles, then convert 4 people into tentacle followers.", true);
		return;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (true  && GuidedToday == 1) {//Tentacle Queen
		funcRieszTentacleQueenWin();
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcRieszWolfKnightDickGirlWin();
	}
}

function funcShampooDickgirlMotherWin() {//shampoo Dickgirl mother
	if (_root.DickgirlXF == 2) {
		_root.ServantSpeak("I think you have accomplished the ending <b>Dickgirl Mother</b>.  As long as you have accepted the proposition by #slave.", true);
	}
	else {
		funcDickGirlWin();
		return;
	}
}

function funcShampooPerfectSlaveWin() {//shampoo Perfect Slave
	if (funcscoremath > 85) {
		_root.ServantSpeak("I think you have accomplished the ending <b>Perfect Slave</b>.", true);
	}
	else {
		funcRaiseScore();
	}
}

function funcUrdAlchemistWin() {//Urd Alchemist 
	if (_root.VarSpecialRounded > 80 && funcScoreMath() > 80) {
		_root.ServantSpeak("I think you have accomplished the ending <b>Alchemist</b>", true);
		return;
	}
	if (_root.VarSpecialRounded < 80 && GuidedToday == 0) {//Special less then 80
		funcRaiseStat(20);
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (funcScoreMath() < 80  && GuidedToday == 1) {//Score less then 80
		funcRaiseScore();
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcUrdAlchemistWin();
	}
}

function funcUrdDickgirlAlchemistWin() {//Urd DickgirlAlchemist
	if (_root.DickgirlXF == 2 && _root.VarSpecialRounded > 80 && funcScoreMath() > 80) {
		_root.ServantSpeak("I think you have accomplished the ending <b>DickGirl Alchemist</b>.", true);
		return;
	}
	if (_root.DickgirlXF =! 2 && GuidedToday == 0) {//check dick girl
		funcDickGirlWin();
		GuidedToday = 1;
		return;
	}
	else {
		GuidedTop = 1;
		GuidedToday = 1;
	}
	if (true  && GuidedToday == 1) {//check ALchemist
		funcUrdAlchemistWin();
		GuidedToday = 0;
		return;
	}
	else {
		GuidedToday = 0;
	}
	if (GuidedTop == 1) {
		return;
	}
	else {
		funcUrdDickgirlAlchemistWin();
	}
}

function funcYurikaDickgirlCowWin() {//Yurika Dickgirl Cow 
	if (_root.DickgirlXF == 2 ) {
		_root.ServantSpeak("I can not tell if you have accomplished the ending <b>DickGirl Cow</b>.  I can see that Yurika is a dick girl when she runs away let Astrid purchase her.", true);
		return;
	}
	else {
		funcDickGirlWin();
		return;
	}
}

function funcYurikaPrizeDickgirlCowWin() {
	if (_root.DickgirlXF == 2 ) {
		_root.ServantSpeak("I can not tell if you have accomplished the ending <b>Prize DickGirl Cow</b>.  I can see that Yurika is a dick girl when she runs away lose to Astrid.", true);
		return;
	}
	else {
		funcDickGirlWin();
		return;
	}
}
	
function funcGuidedWin() {
	if (_root.AssistantData.CheckBitFlag2(10) && _root.AssistantData.CheckBitFlag2(9) != true) {//Prostitute
		funcProstituteWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && _root.AssistantData.CheckBitFlag2(9) != true) {//Normal
		funcNormalWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && _root.AssistantData.CheckBitFlag2(9) != true) {//Normal -
		funcNormalMinusWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && _root.AssistantData.CheckBitFlag2(9) != true) {//Normal +
		funcNormalPlusWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(14) && _root.AssistantData.CheckBitFlag2(9) != true) {//Maid 
		funcMaidWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(15) && _root.AssistantData.CheckBitFlag2(9) != true) {//Rebel
		funcRebelWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(16) && _root.AssistantData.CheckBitFlag2(9) != true) {//Sex Addict
		funcSexAddictWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(17) && _root.AssistantData.CheckBitFlag2(9) != true) {//Sex Maniac
		funcSexManiacWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(18) && _root.AssistantData.CheckBitFlag2(9) != true) {//Wedding
		funcWeddingWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(19) && _root.AssistantData.CheckBitFlag2(9) != true) {//Rich
		funcRichWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(20) && _root.AssistantData.CheckBitFlag2(9) != true) {//Drug Addict
		funcDrugAddictWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(21) && _root.AssistantData.CheckBitFlag2(9) != true) {//S&M
		funcSandMWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(22) && _root.AssistantData.CheckBitFlag2(9) != true) {//Courtesan
		funcCourtesanWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(23) && _root.AssistantData.CheckBitFlag2(9) != true) {//Dickgirl Courtesan
		funcDickGirlCourtesanWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(24) && _root.AssistantData.CheckBitFlag2(9) != true) {//Dickgirl
		funcDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(25) && _root.AssistantData.CheckBitFlag2(9) != true) {//Pony Girl
		funcPonyGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(26) && _root.AssistantData.CheckBitFlag2(9) != true) {//Dickgirl Ponygirl
		funcDickGirlPonyGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(27) && _root.AssistantData.CheckBitFlag2(9) != true) {//Cow Girl
		funcCowGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Ayane") {//Loyal
		funcAyaneLoyalWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Ayane") {//Loyal Dickgirl 
		funcAyaneLoyalDickgirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && SlaveName == "Ayane") {//Loyal Courtesan 
		funcAyaneLoyalCourtesanWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && SlaveName == "Ayane") {//Loyal Dickgirl Courtesan 
		funcAyaneLoyalCourtesanDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Belldandy") {//Daemon
		funcBelldandyDaemonWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Belldandy") {//Angel
		funcBelldandyAngelWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && (SlaveName == "Kasumi" || SlaveName == "Cumslut Kasumi")) {//Cumslut
		funcKasumiCumslutWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && (SlaveName == "Kasumi" || SlaveName == "Cumslut Kasumi")) {//Dickgirl Cumslut  
		funcKasumiCumslutDickgirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && (SlaveName == "Kasumi" || SlaveName == "Cumslut Kasumi")) {//Winner 
		funcKasumiWinnerWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && (SlaveName == "Kasumi" || SlaveName == "Cumslut Kasumi")) {//Dickgirl Winner 
		funcKasumiWinnerDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Menace") {//Arena Cat Champion
		funcMenaceArenaCatChampionWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Menace") {//Arena Champion  
		funcMenaceArenaChampionWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && SlaveName == "Menace") {//Drug Whore 
		funcMenaceDrugWhoreWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && SlaveName == "Menace") {//Exile 
		funcMenaceExileWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(14) && SlaveName == "Menace") {//Cat Girl 
		funcMenaceCatGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Minako") {//Cat-Slave
		funcMinakoCatSlaveWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Minako") {//Cat Savior
		funcMinakoCatSaviorWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Naru") {//Bride of the Goddess
		funcNaruBrideoftheGoddessWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Orihime") {//Priestess
		funcOrihimePriestessWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Orihime") {//Corrupt Priestess  
		funcOrihimeCorruptPriestessWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && SlaveName == "Orihime") {//Demon Lover 
		funcOrihimeDemonLoverWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && SlaveName == "Orihime") {//Deomoness 
		funcOrihimeDemonessWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(14) && SlaveName == "Orihime") {//Drug Whore 
		funcOrihimeDrugWhoreWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Ranma") {//Running Away
		funcRanmaRunningAwayWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Ranma") {//Cat-slave   
		funcRanmaCatSlaveWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && SlaveName == "Ranma") {//Dickgirl Cat-slave 
		funcRanmaDickGirlCatSlaveWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Rei") {//Failed Exorcist
		funcReiFailedExorcistWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Rei") {//Failed Exorcist Dickgirl 
		funcReiFailedExorcistDickgirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && SlaveName == "Rei") {//Pure 
		funcReiPureWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && SlaveName == "Rei") {//Pure Dickgirl
		funcReiPureDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(14) && SlaveName == "Rei") {//Failed Exorcist (Corrupt) 
		funcReiFailedExorcistCorruptWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(15) && SlaveName == "Rei") {//Failed Exorcist Dickgirl (Corrupt)  
		funcReiFailedExorcistCorruptDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(16) && SlaveName == "Rei") {//Corrupt 
		funcReiCorruptWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(17) && SlaveName == "Rei") {//Corrupt Dickgirl 
		funcReiCorruptDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(18) && SlaveName == "Rei") {//Assistant
		funcReiAssistantWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(19) && SlaveName == "Rei") {//Assistant Dickgirl    
		funcReiAssistantDickgirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(20) && SlaveName == "Rei") {//Bride of the Gods 
		funcReiBrideoftheGodWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Riesz") {//Dickgirl Toy 
		funcRieszDickgirlToyWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Riesz") {//Wolf Knight  
		funcRieszWolfKnightWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(12) && SlaveName == "Riesz") {//Dickgirl Wolf Knight 
		funcRieszWolfKnightDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(13) && SlaveName == "Riesz") {//Tentacle Queen 
		funcRieszTentacleQueenWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(14) && SlaveName == "Riesz") {//Dickgirl Tentacle Queen
		funcRieszTentacleQueenDickGirlWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Shampoo") {//Dickgirl Mother
		funcShampooDickgirlMotherWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Shampoo") {//Perfect Slave 
		funcShampooPerfectSlaveWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Urd") {//Alchemist
		funcUrdAlchemistWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Urd") {//Dickgirl Alchemist 
		funcUrdDickgirlAlchemistWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(10) && SlaveName == "Yurika") {//Dickgirl Cow 
		funcYurikaDickgirlCowWin();
	}
	else if (_root.AssistantData.CheckBitFlag2(11) && SlaveName == "Yurika") {//Duel Prize Dickgirl Cow 
		funcYurikaPrizeDickgirlCowWin();
	}
}

function funcDayUndoneItems() { //checks to see items that are not done yet and could be
	if (tempTotal == 10) {//will try to check for 10 items then give up no infinite looping or lagging the user.
		tempTotal = 0;
		_root.ServantSpeak("Have a great day!", true);
		return;
	}
	else {
		temp = int(Math.random()*52) + 1;
		tempTotal = tempTotal + 1;
	}
	if (temp == 1 && _root.TotalSleazyBar == 0 && ( _root.DifficultySleazyBar < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has still not worked at a Sleazy Bar.", true); 
	}
	else if (temp == 2 && _root.TotalExpose == 0 && ( _root.DifficultyExhib  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has still not Exposed herself in public.", true); 
	}
	else if (temp == 3 && _root.TotalBrothel == 0 && ( _root.DifficultyBrothel  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has still not worked at a Brothel.", true);										 
	}
	else if (temp == 4 && _root.TotalAcolyte == 0 && _root.SMFaith != 2){
		_root.ServantSpeak(SlaveName + " has still not worked at a Acolyte.", true);										 
	}
	else if (temp == 5 && _root.TotalRestaurant == 0 ){
		_root.ServantSpeak(SlaveName + " has still not worked at a Restaurant.", true); 
	}
	else if (temp == 6 && _root.TotalBar == 0) {
		_root.ServantSpeak(SlaveName + " has still not worked at a Bar.", true);										 
	}
	else if (temp == 7 && _root.TotalExercise == 0){
		_root.ServantSpeak(SlaveName + " has never been Excercised.", true);										 
	}
	else if (temp == 8 && _root.TotalCooking == 0 ){
		_root.ServantSpeak(SlaveName + " has never been Cooking.", true);										 
	}
	else if (temp == 9 && _root.TotalCleaning == 0 ){
		_root.ServantSpeak(SlaveName + " has never been Cleaning.", true);										 
	}
	else if (temp == 10 && _root.TotalBreak == 0){
		_root.ServantSpeak(SlaveName + " has never taken a Break.", true); 
	}
	else if (temp == 11 && _root.TotalDance == 0){
		_root.ServantSpeak(SlaveName + " has never been Dancing.", true);										 
	}
	else if (temp == 12 && _root.TotalSciences == 0){
		_root.ServantSpeak(SlaveName + " has never taken a Science Class.", true); 
	}
	else if (temp == 13 && _root.TotalRefinement == 0 ){
		_root.ServantSpeak(SlaveName + " has never taken a Refinement Class.", true); 
	}
	else if (temp == 14 && _root.TotalNaked == 0 && ( _root.DifficultyExhib  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never been Naked.", true); 
	}
	else if (temp == 15 && _root.TotalDiscuss == 0 ){
		_root.ServantSpeak("You have never talked to #slave.", true); 
	}
	else if (temp == 16 && _root.TotalMakeUp == 0 ){
		_root.ServantSpeak(SlaveName + " has never had Makeup applied.", true); 
	}
	else if (temp == 17 && _root.TotalWalkForest == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk in the Forest.", true); 
	}
	else if (temp == 18 && _root.TotalWalkFarm == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk at the Farm.", true);										 
	}
	else if (temp == 19 && _root.TotalWalkPalace == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk at the Palace.", true); 
	}
	else if (temp == 20 && _root.TotalWalkSlums == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk in the Slums.", true); 
	}
	else if (temp == 21 && _root.TotalWalkLake == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk at the Lake.", true); 
	}
	else if (temp == 22 && _root.TotalWalkTownCenter == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk at the Town Center.", true); 
	}
	else if (temp == 23 && _root.TotalWalkDocks == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk at the Docks.", true); 
	}
	else if (temp == 24 && _root.TotalWalkRuins == 0 ){
		_root.ServantSpeak(SlaveName + " has never been for a Walk at the Ruins.", true); 
	}
	else if (temp == 25 && _root.TotalVisitAstrid == 0 ){
		_root.ServantSpeak(SlaveName + " has never Visited Astrid.", true); 
	}
	else if (temp == 26 && _root.TotalTentacle == 0 ){
		_root.ServantSpeak(SlaveName + " has never seen a Tentacle monster, isn't that a good thing?", true); 
	}
	else if (temp == 27 && _root.TotalMilked == 0 ){
		_root.ServantSpeak(SlaveName + " has never been Milked, why is that even on my list?", true);										 
	}
	else if (temp == 28 && _root.TotalTeddyBear == 0 ){
		_root.ServantSpeak(SlaveName + " has never gotten a Teddy Bear, isn't that a bit sad?", true); 
	}
	else if (temp == 29 && _root.TotalGames == 0 ){
		_root.ServantSpeak(SlaveName + " has never gotten a Games, oh I love to play parchese!", true); 
	}
	else if (temp == 30 && _root.TotalJewelry == 0 ){
		_root.ServantSpeak(SlaveName + " has no Jewelry, do you want me to give her one of mine?", true);										 
	}
	else if (temp == 31 && _root.TotalDoll == 0 ){
		_root.ServantSpeak(SlaveName + " has never gotten a Doll, do you want me to make her one?", true); 
	}
	else if (temp == 32 && _root.TotalHairCare == 0 ){
		_root.ServantSpeak(SlaveName + " has never gotten been to get her Hair done at the salon.", true); 
	}
	else if (temp == 33 && _root.TotalSkinCare == 0 ){
		_root.ServantSpeak(SlaveName + " has never gotten been to get her Skin Care done at the salon.", true); 
	}
	else if (temp == 34 && _root.TotalBooksRead == 0 && _root.TotalBooks > 0){
		_root.ServantSpeak(SlaveName + " has never read a Book, should slaves really be allowed to read?", true); 
	}
	else if (temp == 35 && _root.TotalPoetryRead == 0 ){
		_root.ServantSpeak(SlaveName + " has never read a Poetry Book, should slaves really be allowed to read?", true); 
	}
	else if (temp == 36 && _root.TotalScriptureRead == 0 && _root.TotalScripture > 0){
		_root.ServantSpeak(SlaveName + " has never read a Scripture, should slaves really be allowed to read?", true); 
	}
	else if (temp == 37 && _root.TotalKamasutraRead == 0 && _root.TotalKamasutra > 0){
		_root.ServantSpeak(SlaveName + " has never read a Kamasutra, should slaves really be allowed to read?", true); 
	}
	else if (temp == 38 && _root.PotionsUsed[0] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Priapus Draft, I'm not even sure what type of drug that is?", true);										 
	}
	else if (temp == 39 && _root.PotionsUsed[1] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Uninhibitor potion, when you give that to her can I watch?", true);										 
	}
	else if (temp == 40 && _root.PotionsUsed[2]== 0){
		_root.ServantSpeak(SlaveName + " has never drank a Aphrodisiac potion, when you give that to her can I watch?", true);										 
	}
	else if (temp == 41 && _root.PotionsUsed[3] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Soothing Potion.", true); 
	}
	else if (temp == 42 && _root.PotionsUsed[4] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank an Energy Drink, I've heard that these allow the slaves to keep going far past the point of exhaustion.", true); 
	}
	else if (temp == 43 && _root.PotionsUsed[5] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Dorei Potion, what type of drug is that?", true); 
	}
	else if (temp == 44 && _root.PotionsUsed[6]== 0){
		_root.ServantSpeak(SlaveName + " has never drank a Zodai Potion, what type of drug is that?", true); 
	}
	else if (temp == 45 && _root.PotionsUsed[7] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Gaman Potion, what type of drug is that?", true); 
	}
	else if (temp == 46 && _root.PotionsUsed[8] == 0 ){//
		_root.ServantSpeak(SlaveName + " has never drank a Biyaku Potion, what type of drug is that?", true); 
	}
	else if (temp == 47 && _root.PotionsUsed[9]== 0){
		_root.ServantSpeak(SlaveName + " has never drank a Ishinai Potion, what type of drug is that?", true);										 
	}
	else if (temp == 48 && _root.PotionsUsed[10] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Lust Draft Potion, what type of drug is that?", true); 
	}
	else if (temp == 49 && _root.PotionsUsed[11] == 0 ){
		_root.ServantSpeak(SlaveName + " has never taken an Odd Pill, I have seen a number of people give this out around town, but they won't let me have one...", true);										 
	}
	else if (temp == 50 && _root.PotionsUsed[12] == 0 ){
		_root.ServantSpeak(SlaveName + " has never drank a Nymph's Tears, I have a freind who can't live with out this potion, its very addictive.", true); 
	}
	else if (temp == 51 && _root.PotionsUsed[13]== 0){
		_root.ServantSpeak(SlaveName + " has never drank a Junkens' Orgasm Potion, this sounds like fun.", true);										 
	}
	else if (temp == 52 && _root.TotalPlug == 0 && ( _root.DifficultyPlug  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never used a Plug.  I have to ask why not?", true); 
	}
	else {
		funcDayUndoneItems();
	}
}

function funcSpecialAkaneWin(){
	_root.ServantSpeak("This slave has has no extra paths available to her.", true);
}

function funcSpecialAyaneWin() {
	_root.ServantSpeak("This slave has 4 paths available to her, Loyal Dickgirl Courtesan, Loyal Courtesan, Loyal Dickgirl, and Loyal.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialBelldandyWin() {
	_root.ServantSpeak("This slave has 2 paths available to her, Daemon and Angel.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialKasumiWin() {
	_root.ServantSpeak("This slave has 4 paths available to her, Winner, Dickgirl Winner, Cumslut, and Dickgirl Cumslut.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialMenaceWin() {
	if (SlaveName == "Menace" && _root.CheckBitFlag2(6) && _root.CheckBitFlag2(19)) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Arena Cat Champion.", true);									   
	}
	else if (SlaveName == "Menace" && _root.CheckBitFlag2(6) ) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Arena Champion.", true);
	}
	else if (SlaveName == "Menace" && _root.CheckBitFlag2(36) ) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Drug Whore.", true);
	}
	else if (SlaveName == "Menace" && _root.CheckBitFlag2(40) ) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Exile, her rank in this training is still yet to be determined.", true);
	}
	else if (SlaveName == "Menace" && _root.CheckBitFlag2(19) ) {
		_root.ServantSpeak(SlaveName + " has accomplished a special training, Cat Girl, even more trainings may be available to include this one.", true);
	}
	else if (SlaveName == "Menace") {
		_root.ServantSpeak(SlaveName + " has not accomplished any special training, I can see 5 paths available for her, Arena Champion, Drug Whore, Exile, Cat Girl, and Arena Cat Champion.", true);
	}
}

function funcSpecialOrihimeWin() {
	if(SlaveName == "Orihime" && _root.CheckBitFlag2(5)) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Drug Whore.", true);
	}
	else if(SlaveName == "Orihime" && _root.CustomFlag > 25 && _root.VarIntelligence > 78 && _root.VarMorality < 26 ) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Corrupt Priestess.", true);
	}
	else if(SlaveName == "Orihime" && _root.CustomFlag > 25 && _root.VarIntelligence >= 78 && _root.VarMorality >= 78 ) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Priestess.", true);
	}
	else if(SlaveName == "Orihime" && _root.CheckBitFlag2(47) == true  && _root.CheckBitFlag2(48) != true ) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Demon Lover.", true);
	}
	else if(SlaveName == "Orihime" && _root.CheckBitFlag2(48) == true ) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Demoness.", true);
	}
	else if (SlaveName == "Orihime") {
		_root.ServantSpeak(SlaveName + " has not accomplished any special training, I can see 5 paths available for her, Corrupt Priestess, Priestess, Demon Lover, Demoness, and Drug Whore.", true);
	}
}

function funcSpecialMinakoWin() {
	_root.ServantSpeak("This slave has 2 paths available to her, Cat Slave and Cat Saviour. Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialNaruWin() {
	_root.ServantSpeak(SlaveName + " has one perfect path for her, Bride of the Goddess.  She will need to get her over all score over 85 it is currently around " + funcScoreMath() + ".", true);
}

function funcSpecialRanmaWin() {
	if (SlaveName == "Ranma" && _root.VarIntelligenceRounded < 20 && _root.VarTemperamentRounded > 35) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Running Away.", true);
	}
	else if (SlaveName == "Ranma" && _root.VarConstitutionRounded > 80 && _root.VarLibidoRounded > 80 && _root.VarJoyRounded > 80 && _root.DressWorn == 6) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Cat-Slave.", true);
	}
	else if (SlaveName == "Ranma" && _root.VarConstitutionRounded > 80 && _root.VarLibidoRounded > 80 && _root.VarJoyRounded > 80 && _root.DressWorn == 6 && _root.DickgirlXF == 2) {
		_root.ServantSpeak(SlaveName + " has accomplished the special training, Dick Girl Cat-Slave.", true);
	}
	else if (SlaveName == "Ranma") {
		_root.ServantSpeak(SlaveName + " has not accomplished any special training, I can see 3 paths available for her, Running Away, Cat-Slave, and Dick Girl Cat Slave.", true);
	}
}

function funcSpecialReiWin() {
	_root.ServantSpeak("This slave has 12 paths available to her, Demon Lover, Failed Exorcist, Failed Exorcist Dickgirl, Pure, Pure Dickgirl, Failed Exorcist (Corrupt), Failed Exorcist Dickgirl (Corrupt), Corrupt, Corrupt Dickgirl, Assistant, Assistant Dickgirl, and Bride of the Gods.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialRieszWin() {
	_root.ServantSpeak("This slave has 5 paths available to her, Dickgirl Toy, Wolf Knight, Dickgirl Wolf Knight, Tentacle Queen, and Dickgirl Tentacle Queen.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialShampooWin() {
	_root.ServantSpeak("This slave has 2 paths available to her, Dickgirl Mother and Perfect Slave.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialUrdWin() {
	_root.ServantSpeak("This slave has 2 paths available to her, Alchemist and Dickgirl Alchemist.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcSpecialYurikaWin() {
	_root.ServantSpeak("This slave has 1 paths available to her, Dickgirl Cow.  Unfortunatly I am unable to see her path at this point.", true);
}

function funcDaySpecialWin() { //checks how close she is to winning special endings
	if (SlaveName == "Akane" ) {
		funcSpecialAkaneWin();
	}
	else if (SlaveName == "Ayane" ) {
		funcSpecialAyaneWin();
	}
	else if (SlaveName == "Belldandy" ) {
		funcSpecialBelldandyWin();
	}
	else if (SlaveName == "Kasumi" || SlaveName == "Cumslut Kasumi") {
		funcSpecialKasumiWin();
	}
	else if (SlaveName == "Menace") {
		funcSpecialMenaceWin();
	}
	else if (SlaveName == "Orihime") {
		funcSpecialOrihimeWin();
	}
	else if (SlaveName == "Minako" ) {
		funcSpecialMinakoWin();
	}
	else if (SlaveName == "Naru") {
		funcSpecialNaruWin();
	}
	else if (SlaveName == "Ranma") {
		funcSpecialRanmaWin();
	}
	else if (SlaveName == "Rei" ) {
		funcSpecialReiWin();
	}
	else if (SlaveName == "Riesz") {
		funcSpecialRieszWin();
	}
	else if (SlaveName == "Shampoo" ) {
		funcSpecialShampooWin();
	}
	else if (SlaveName == "Urd" ) {
		funcSpecialUrdWin();
	}
	else if (SlaveName == "Yurika" ) {
		funcSpecialYurikaWin();
	}
	else {
			_root.ServantSpeak("I am not that familiar with this slave, I don't think I can predict special trainings for her.", true);
	}
}

function funcShowMeEverything() {//shows all flags, bit flags, and paths, for programmers really
	_root.BlankLine();
	_root.ServantSpeak("CustomFlag: " + _root.CustomFlag + ", CustomFlag1: " + _root.CustomFlag1 + ", CustomFlag2: " + _root.CustomFlag2 + ", CustomFlag3: " + _root.CustomFlag3 + ", CustomFlag4: " + _root.CustomFlag4 + ".", true);
	_root.BlankLine();
	_root.ServantSpeak("Not sure if that helped lets take a look at the Paths, Path1: " + _root.Path1 + ", Path2: " + _root.Path2 + ", Path3: " + _root.Path3 + ", Current Path: " + CurrentPath + ".", true); 
	_root.BlankLine();
	_root.ServantSpeak("0: " + _root.CheckBitFlag2(0) + " 1: " + _root.CheckBitFlag2(1) + " 2: " + _root.CheckBitFlag2(2) + " 3: " + _root.CheckBitFlag2(3) +" 4: " + _root.CheckBitFlag2(4) +" 5: " + _root.CheckBitFlag2(5) +" 6: " + _root.CheckBitFlag2(6) +" 7: " + _root.CheckBitFlag2(7) +" 8: " + _root.CheckBitFlag2(8) +" 9: " + _root.CheckBitFlag2(9) +" 10: " + _root.CheckBitFlag2(10) +" 11: " + _root.CheckBitFlag2(11) +" 12: " + _root.CheckBitFlag2(12) +" 13: " + _root.CheckBitFlag2(13) +" 14: " + _root.CheckBitFlag2(14) +" 15: " + _root.CheckBitFlag2(15) +" 16: " + _root.CheckBitFlag2(16) +" 17: " + _root.CheckBitFlag2(17) +" 18: " + _root.CheckBitFlag2(18) +" 19: " + _root.CheckBitFlag2(19) +" 20: " + _root.CheckBitFlag2(20) +" 21: " + _root.CheckBitFlag2(21) +" 22: " + _root.CheckBitFlag2(22) +" 23: " + _root.CheckBitFlag2(23) +" 24: " + _root.CheckBitFlag2(24) +" 25: " + _root.CheckBitFlag2(25) +" 26: " + _root.CheckBitFlag2(26) +" 27: " + _root.CheckBitFlag2(27) +" 28: " + _root.CheckBitFlag2(28) +" 29: " + _root.CheckBitFlag2(29) +" 30: " + _root.CheckBitFlag2(30) +" 31: " + _root.CheckBitFlag2(31) +" 32: " + _root.CheckBitFlag2(32) +" 33: " + _root.CheckBitFlag2(33) +" 34: " + _root.CheckBitFlag2(34) +" 35: " + _root.CheckBitFlag2(35) +" 36: " + _root.CheckBitFlag2(36) +" 37: " + _root.CheckBitFlag2(37) +" 38: " + _root.CheckBitFlag2(38) +" 39: " + _root.CheckBitFlag2(39) +" 40: " + _root.CheckBitFlag2(40) +" 41: " + _root.CheckBitFlag2(41) +" 42: " + _root.CheckBitFlag2(42) +" 43: " + _root.CheckBitFlag2(43) +" 44: " + _root.CheckBitFlag2(44) +" 45: " + _root.CheckBitFlag2(45) +" 46: " + _root.CheckBitFlag2(46) +" 47: " + _root.CheckBitFlag2(47) +" 48: " + _root.CheckBitFlag2(48) +" 49: " + _root.CheckBitFlag2(49) +" 50: " + _root.CheckBitFlag2(50) +" 51: " + _root.CheckBitFlag2(51) +" 52: " + _root.CheckBitFlag2(52) +" 53: " + _root.CheckBitFlag2(53) +" 54: " + _root.CheckBitFlag2(54) +" 55: " + _root.CheckBitFlag2(55) +" 56: " + _root.CheckBitFlag2(56) +" 57: " + _root.CheckBitFlag2(57) +" 58: " +   _root.CheckBitFlag2(58) +" 59: " + _root.CheckBitFlag2(59) +" 60: " + _root.CheckBitFlag2(60) +" 61: " + _root.CheckBitFlag2(61), true);
}


function funcArenaMath() {//menace arena math for menace warnings
	if ( _root.Elapsed < 14 ) {
		temp = 14 - _root.Elapsed;
	}
	else if ( _root.Elapsed < 28 ) {
		temp = 28 - _root.Elapsed;
	}
	else if ( _root.Elapsed < 42) {
		temp = 42 - _root.Elapsed;
	}
	else if ( _root.Elapsed < 56 ) {
		temp = 56 - _root.Elapsed;
	}
	return temp;
}

function funcScoreMath():Number { //try to find out the score.
	temp = _root.VarConversationRounded + _root.VarCharismaRounded + _root.VarObedienceRounded + _root.VarReputationRounded + _root.VarSensibilityRounded + _root.VarRefinementRounded + _root.VarIntelligenceRounded + _root.VarMoralityRounded + _root.VarConstitutionRounded + _root.VarCleaningRounded + _root.VarCookingRounded + _root.VarBlowJobRounded + _root.VarFuckRounded + _root.VarTemperamentRounded + _root.VarNymphomaniaRounded + _root.VarJoyRounded + _root.VarLibidoRounded + _root.VarSpecialRounded - _root.VarFatigueRounded;
	temp = temp / 21.5;
	temp = dpn(temp, 0);//round it out
	return temp;
}

function funcEnding() :String{//basically checks to see what ending the player will get and return it for funcDayWinCheck
	if (tempEndingOr != 1) {//got to keep it checking other stuff will only run this every other time
		tempEndingOr = 1;
		if (_root.VarObedienceRounded < 15) {
			return "Rebel";
		}
		else if (( SlaveName != "Belldandy" || SlaveName != "Naru" || SlaveName != "Shampoo" || SlaveName != "Urd" || SlaveName != "Yurika") && _root.TotalMilked > 6  ) {
			return "Cow Girl";
		}
		else if (_root.slPonygirlTraining > 75 && funcScoreMath() > 50) {
			return "Pony Girl";
		}
		else if (_root.slPonygirlTraining > 75 && funcScoreMath() > 50 && _root.DickgirlXF == 2 ) {
			return "Dickgirl Ponygirl";
		}
		else if (_root.DickgirlXF == 2) {
			return "Dickgirl";
		}
		else if (_root.VarCharismaRounded > 95 && _root.VarConversationRounded > 99 && _root.VarRefinementRounded > 60 && _root.VarFuckingRounded > 90 && _root.VarBlowjobsRounded > 90 && _root.DoneCourtesan == true) {
			return "Courtesan";
		}
		else if (_root.VarCharismaRounded > 95 && _root.VarConversationRounded > 99 && _root.VarRefinementRounded > 60 && _root.VarFuckingRounded > 90 && _root.VarBlowjobsRounded > 90 && _root.DoneCourtesan == true && _root.DickgirlXF == 2) {
			return "Dickgirl Corutesan";
		}
		else if (funcScoreMath() > 40 && _root.TotalBondage > 20) {
			return "S&M";
		}
		else if (_root.VarGold < 3000 && funcScoreMath() > 40 && _root.GetTotalDresses() > 4) {
			return "Rich";
		}
		else if (funcScoreMath() > 75) {
			return "Wedding";
		}
		else if (funcScoreMath() > 40 && _root.VarNymphomaniaRounded > 85 && _root.VarLustRounded > 85) {
			return "Sex Maniac";
		}
		else if (funcScoreMath() > 40 && _root.VarNymphomaniaRounded > 75 && _root.VarLustRounded > 75) {
			return "Sex Addict";
		}
		else if (funcScoreMath() > 40 && _root.VarCookingRounded > 60 && _root.VarCleaningRounded > 60) {
			return "Maid";
		}
		else if (funcScoreMath() > 50 && _root.VarObedienceRounded > 85 && _root.VarMoralityRounded > 45) {
			return "Normal +";
		}
		else if (funcScoreMath() > 50 && _root.VarObedienceRounded < 30 ) {
			return "Normal -";
		}
		else if (funcScoreMath() > 50 ) {
			return "Normal";
		}
		else if (funcPotionCounter > 3) {
			return "Drug Addict";
		}
		return "Prostitute";
	}
	else {
		tempEndingOr = 0;
		if ( _root.TotalTentacle > 4 ) {
			return "Tentacle Slave";
		}
		else if ( funcScoreMath() > 85 ) {
			return "Bought Back";
		}
		else if ( _root.LoveAccepted == 1 && funcScoreMath() > 50 ) {
			return "Love";
		}
		else if (_root.Lesbian == true) {
			return "Lesbian";
		}
		return "no idea(no special trainings yet)";
	}
	return "nada";//will bottom out should never be called just an emergency check
}

function funcWarningsForNight() {//checks for night events Warning.
	if (_root.Prostitute.CheckBitFlag(32) == true && _root.Prostitute.CustomFlag == 0) {
		if (_root.DifficultyLendHer < _root.VarObedienceRounded) {
			_root.ServantSpeak("<font color='#FF0000'>Tonight you promised to allow #slave to go to a party with Miss N.<font color='#000000'>", true);
		}
		else {
			_root.ServantSpeak("<font color='#FF0000'>Tonight you promised to allow #slave to go to a party with Miss N, <b> I don't think she will obey this command</b>.<font color='#000000'>", true);
		}
	}
	if (_root.HighClassProstitute.CheckBitFlag(32) == true && _root.HighClassProstitute.CustomFlag == 0) {
		if (_root.DifficultyLendHer < _root.VarObedienceRounded) {
			_root.ServantSpeak("<font color='#FF0000'>Tonight is the party with Lady Okyanu, #slave seems to be looking forward to it.<font color='#000000'>", true);
		}
		else {
			_root.ServantSpeak("<font color='#FF0000'>Tonight is the party with Lady Okyanu, <b>#slave will most likely not obey this command</b>.<font color='#000000'>", true);
		}
	}
	if (SlaveName == "Orihime" && _root.CheckBitFlag2(45) == true && _root.CheckBitFlag2(46) != true) {
		_root.BlankLine();
		if (_root.MoonPhaseDate == 16 || _root.MoonPhaseDate == 15 || _root.MoonPhaseDate == 13 || _root.MoonPhaseDate == 0 || _root.MoonPhaseDate == 1) { 
			_root.ServantSpeak("I feel a dark thing is moving to the north west tonight.", true);
		}
		else {
			_root.ServantSpeak("There is a dark thing to the north west, but it is not moving tonight.", true);
		}
	}
	if (_root.VarFatigueRounded > 42) {
			_root.ServantSpeak("<b>#slave is looking tired, she needs to rest soon.</b>.", true);
			_root.BlankLine();
		}
}

function funcNightUndone() { //checks to see undone items that can be done
	if (tempTotal == 10) {//will try to check for 10 items then give up no infinite looping or lagging the user.
		tempTotal = 0;
		_root.ServantSpeak("Have a great day!", true);
		return;
	}
	else {
		temp = int(Math.random()*20) + 1;
		tempTotal = tempTotal + 1;
	}
	if (temp == 1 && _root.TotalBlowjob == 0 && ( _root.DifficultyBlowjob < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never performed a Blow Job, not that I'm interested or anything...", true); 
	}
	else if (temp == 2 && _root.TotalFuck == 0 && ( _root.DifficultyFuck < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never performed a Fuck, I really don't want to see that.", true); 
	}
	else if (temp == 3 && _root.TotalAnal == 0 && ( _root.DifficultyAnal  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never done Anal Sex, if you toss me a strap-on I'll take care of that.", true); 
	}
	else if (temp == 4 && _root.TotalBondage == 0  && ( _root.DifficultyBondage  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never done Bondage, ropes and toys, I really want to see it!", true); 
	}
	else if (temp == 5 && _root.TotalMasturbate == 0 ){
		_root.ServantSpeak(SlaveName + " has never Masturbated, can I ask you why not?", true); 
	}
	else if (temp == 6 && _root.TotalLesbian == 0 && ( _root.DifficultyLesbian  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never had Lesbian sex, I want to see that!", true);										 
	}
	else if (temp == 7 && _root.TotalGangBang == 0 && ( _root.DifficultyGangBang  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never been Gang Banged, do it, do it, do it.", true);										 
	}
	else if (temp == 8 && _root.TotalTouch == 0){
		_root.ServantSpeak(SlaveName + " has never been Touched, if you haven't done it, I will.", true); 
	}
	else if (temp == 9 && _root.TotalLick == 0 && ( _root.DifficultyLick  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never been Licked, I'm more then happy to train her in that.", true); 
	}
	else if (temp == 10 && _root.TotalTitsFuck == 0 && ( _root.DifficultyTitsFuck  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never done a Tit Fuck, but I really don't care.", true); 
	}
	else if (temp == 11 && _root.TotalDildo == 0 && ( _root.DifficultyDildo  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never used a Dildo, it's a good show, get her started.", true); 
	}
	else if (temp == 12 && _root.TotalLendHer == 0  && ( _root.DifficultyLendHer  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never been Lent to anyone.  Just visit someone, then select lend to them.", true); 
	}
	else if (temp == 13 && _root.TotalThreesome == 0 && ( _root.DifficultyThreesome  < _root.VarObedienceRounded )){
		_root.ServantSpeak(SlaveName + " has never done a Threesome.  You, me, and her!", true); 
	}
	else if (temp == 14 && _root.TotalProstituteParty == 0 && (_root.DifficultyLendHer  < _root.VarObedienceRounded )){
		_root.ServantSpeak(SlaveName + " has never been to Ms. N's party, it's a great party, I highly recomend it, if you have never been.", true); 
	}
	else if (temp == 15 && _root.TotalSpank == 0 && ( _root.DifficultySpank  < _root.VarObedienceRounded )){
		_root.ServantSpeak(SlaveName + " has never been Spank, spanking her twice a day will raise her obedience.", true); 
	}
	else if (temp == 16 && _root.Total69 == 0 && ((_root.DifficultyBlowjob + 3)  < _root.VarObedienceRounded ) ){
		_root.ServantSpeak(SlaveName + " has never done a 69, I want to do it!", true);										 
	}
	else if (temp == 17 && _root.TotalGroup == 0 && ((_root.DifficultyGangBang - 10)  < _root.VarObedienceRounded )){
		_root.ServantSpeak(SlaveName + " has never done a Gang Bang.  This is great training for the slave, and a fun thing to watch.", true); 
	}
	else if (temp == 18 && _root.TotalCumBath == 0 && ((_root.DifficultyGangBang - 5 )  < _root.VarObedienceRounded )){
		_root.ServantSpeak(SlaveName + " has never done a Cum Bath.  Not that she needs to, it sounds sticky.", true);										 
	}
	else if (temp == 19 && _root.TotalKiss == 0 ){
		_root.ServantSpeak(SlaveName + " has never been Kissed.  How is she supposed to know she is special if you don't show her affection?", true); 
	}
	else if (temp == 20 && _root.TotalStripTease == 0 && (_root.DifficultySleazyBar  < _root.VarObedienceRounded )){
		_root.ServantSpeak(SlaveName + " has never done a Striptease, make her take it off!", true); 
	}
	else {
		funcNightUndone();
	}
}
//9
//night skill temp makes sure Mugi doesnt say the same thing every night.
function funcNightSkillUp() { //checks to see what items that have been done can be advanced tonight these are very general and could be wrong
	if (_root.DifficultyDildo < _root.VarObedienceRounded && _root.LevelDildo < 5 && nightSkillTemp != 1) {
		_root.ServantSpeak("Training her with a dildo tonight, will give the fastest results in getting the rest of her trainings increased.", true);
		nightSkillTemp = 1;
	}
	else if (_root.TotalMasturbate > 9 && _root.LevelMasturbate < 1 && nightSkillTemp != 2) {
		_root.ServantSpeak("I think she can become better at Masturbating tonight with 1 or 2 trainings.  (Masturbate 1)", true);
		nightSkillTemp = 2;
	}
	else if (_root.TotalMasturbate > 17 && _root.LevelMasturbate < 2 && _root.VarObedienceRounded > 20 && nightSkillTemp != 3) {
		_root.ServantSpeak("I think she can become better at Masturbating tonight with 1 or 2 trainings.  (Masturbate 2)", true);
		nightSkillTemp = 3;
	}
	else if (_root.TotalMasturbate > 30 && _root.LevelMasturbate < 3 && _root.VarObedienceRounded > 33 && nightSkillTemp != 8) {
		_root.ServantSpeak("I think she can become better at Masturbating tonight with 1 or 2 trainings.  (Masturbate 3)", true);
		nightSkillTemp = 8;
	}
	else if (_root.TotalMasturbate > 40 && _root.LevelMasturbate < 4 && _root.VarObedienceRounded > 46 && nightSkillTemp != 9) {
		_root.ServantSpeak("I think she can become better at Masturbating tonight with 1 or 2 trainings.  (Masturbate 4)", true);
		nightSkillTemp = 9;
	}
	else if (_root.DifficultyLick < _root.VarObedienceRounded && _root.LevelLick < 1 && nightSkillTemp != 4) {
		_root.ServantSpeak("Licking her will teach her the basics of licking you.", true);
		nightSkillTemp = 4;
	}
	else if (_root.DiffiicultyTouch  < _root.VarObedienceRounded && _root.LevelTouch < 1 && nightSkillTemp != 5) {
		_root.ServantSpeak("Touching her will teach her the basics, so she can bring pleasure when touching her lover. (Touch 1)", true);
		nightSkillTemp = 5;
	}
	else if (_root.DiffiicultyTouch  < _root.VarObedienceRounded && _root.LevelTouch < 2 && _root.VarLustRounded > 22 && nightSkillTemp != 6) {
		_root.ServantSpeak("Touching her will teach her the basics, so she can bring pleasure when touching her lover. (Touch 2)", true);
		nightSkillTemp = 6;
	}
	else if (_root.DiffiicultyKiss  < _root.VarObedienceRounded && _root.LevelKiss < 1 && _root.VarLustRounded > 40 && ((_root.VarSensibilityRounded > 15 && _root.Gender != 1) || _root.Gender == 1) && nightSkillTemp != 7) {
		_root.ServantSpeak("I think #slave will become better at kissing tonight. (Kiss 1)", true);
		nightSkillTemp = 7;
	}
	else {
		_root.ServantSpeak("I don't see a skill she can level up on tonight with a few training.", true);
	}
}

function funcNightSpecial() { //extra items suggestions from mugi on what may advance training in the long run or her personal feelings.
	if (_root.VarObedienceRounded < 5 ) {
		_root.ServantSpeak("Given her lack of training, I recommend you make her masturbate.", true);
	}
	else if ( (_root.VarObedienceRounded > _root.DifficultyDildo) && _root.LevelDildo != 5) {
		_root.ServantSpeak("Training with a dildo would increase her sensitive, and speed up her training.", true);
	}
	else {
		_root.ServantSpeak("I don't have a good suggestion at this time.", true);
	}
}

function DoEventNextAsAssistant() : Boolean {//events!!! yay the meat 
	//assistant is 7000-7499
	if (_root.NumEvent == 7000) {//first round of mugi checks chose basic 
		_root.ServantSpeak("As you wish, Basic it is.", true);
		_root.AssistantData.SetBitFlag2(1);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;
		return true;
	}
	else if (_root.NumEvent == 7001) {//first round of mugi checks chose Helper 
		_root.ServantSpeak("As you wish, Helper it is.", true);
		_root.AssistantData.SetBitFlag2(2);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;			
		return true;
	}
	else if (_root.NumEvent == 7002) {//first round of mugi checks chose Guided 
		_root.ServantSpeak("As you wish, Guided it is.", true);
		_root.AssistantData.SetBitFlag2(3);
		if (SlaveName == "Ayane" || SlaveName == "Belldandy" || SlaveName == "Kasumi" || SlaveName == "Menace" || SlaveName == "Minako" || SlaveName == "Naru" || SlaveName == "Orihime" || SlaveName == "Ranma" || SlaveName == "Rei" || SlaveName == "Riesz" || SlaveName == "Shampoo" || SlaveName == "Urd" || SlaveName == "Yurika") {
			_root.AskHerQuestions(7010, 7011, 0, 0, "Standard Trainings", "Special Trainings", "", "", "Please select a Training Path?");
		}
		else {
			_root.BlankLine();
			_root.ServantSpeak("My knowledge of this girl is limited the best I can offer is guide you towards a standard training.", true);
			_root.AskHerQuestions(7010, 0, 0, 0, "Standard Trainings", "", "", "", "Please select a Training Path?");
		}
		return true;
	}
	else if (_root.NumEvent == 7003) {//first round of mugi checks chose Everything 
		_root.ServantSpeak("As you wish, Everything it is.   How often do you want to be shown everything?", true);
		_root.AssistantData.SetBitFlag2(4);
		_root.AskHerQuestions(7004, 7005, 7006, 7007, "Every Day and Night", "Every Day", "Every Other Day", "Every Three Days", "Please select how often?");
		return true;
	}
	else if (_root.NumEvent == 7004) {//Everything Day and Night
		_root.ServantSpeak("I will tell you everything I know every day and every night.", true);
		_root.AssistantData.SetBitFlag2(5);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;
		return true;
	}
	else if (_root.NumEvent == 7005) {//Everything Day
		_root.ServantSpeak("I will tell you everything I know every day.", true);
		_root.AssistantData.SetBitFlag2(6);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;
		return true;
	}
	else if (_root.NumEvent == 7006) {//Everything 2 Day
		_root.ServantSpeak("I will tell you everything I know every other day.", true);
		_root.AssistantData.SetBitFlag2(7);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;
		return true;
	}
	else if (_root.NumEvent == 7007) {//Everything 3 Day
		_root.ServantSpeak("I will tell you everything I know every three days.", true);
		_root.AssistantData.SetBitFlag2(8);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;
		return true;
	}
	else if (_root.NumEvent == 7010) {//standard trainings page 1
		MoreTrainings = 1;
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		_root.AskHerQuestions(7020, 7021, 7022, 7012, "Prostitute", "Normal", "Normal -", "More", "Please select a Training Path?");
		return true;
	}
	else if (_root.NumEvent == 7011) {//advanced training selections
		_root.ServantSpeak("Here is the advanced trainings I see for this slave:", true);
		if (SlaveName == "Ayane") {
			_root.AskHerQuestions(7040, 7041, 7042, 7013, "Loyal", "Loyal Dickgirl", "Loyal Courtesan ", "More", "Please select a Training Path?"); 
			MoreTrainings = 2;
		}
		else if (SlaveName == "Belldandy") {
			_root.AskHerQuestions(7040, 7041, 7002, 0, "Daemon", "Angel", "Training Path", "", "Please select a Training Path?"); 
		}
		else if (SlaveName == "Kasumi") {
			_root.AskHerQuestions(7040, 7041, 7042, 7013, "Cumslut", "Dickgirl Cumslut", "Winner", "More", "Please select a Training Path?");
			MoreTrainings = 2;
		}
		else if (SlaveName == "Menace") {
			_root.AskHerQuestions(7040, 7041, 7042, 7013, "Arena Cat Champion", "Arena Champion", "Drug Whore", "More", "Please select a Training Path?");
			MoreTrainings = 2;
		}
		else if (SlaveName == "Minako") {
			_root.AskHerQuestions(7040, 7041, 7002, 0, "Cat-Slave", "Cat Savior", "Training Path", "", "Please select a Training Path?");
		}
		else if (SlaveName == "Naru") {
			_root.AskHerQuestions(7040, 7002, 0, 0, "Bride of the Goddess", "Training Path", "", "", "Please select a Training Path?");
		}
		else if (SlaveName == "Orihime") {
			_root.AskHerQuestions(7040, 7041, 7042, 7013, "Priestess", "Corrupt Priestess", "Demon Lover", "More", "Please select a Training Path?");
			MoreTrainings = 2;
		}
		else if (SlaveName == "Ranma") {
			_root.AskHerQuestions(7040, 7041, 7042, 7002, "Running Away", "Cat-slave", "Dickgirl Cat-slave", "Training Path", "Please select a Training Path?");
		}
		else if (SlaveName == "Rei") {
			_root.AskHerQuestions(7040, 7041, 7042, 7013, "Demon Lover", "Failed Exorcist", "Failed Exorcist Dickgirl", "More", "Please select a Training Path?");
			MoreTrainings = 2;
		}
		else if (SlaveName == "Riesz") {
			_root.AskHerQuestions(7040, 7041, 7042, 7013, "Dickgirl Toy", "Wolf Knight", "Dickgirl Wolf Knight", "More", "Please select a Training Path?");
			MoreTrainings = 2;
		}
		else if (SlaveName == "Shampoo") {
			_root.AskHerQuestions(7040, 7041, 7002, 0, "Dickgirl Mother", "Perfect Slave", "Training Path", "", "Please select a Training Path?");
		}
		else if (SlaveName == "Urd") {
			_root.AskHerQuestions(7040, 7041, 7002, 0, "Alchemist", "Dickgirl Alchemist", "Training Path", "", "Please select a Training Path?");
		}
		else if (SlaveName == "Yurika") {
			_root.AskHerQuestions(7040, 7041, 7002, 0, "Dickgirl Cow", "Duel Prize Dickgirl Cow", "Training Path", "", "Please select a Training Path?");
		}
		else {
			_root.ServantSpeak("I messed up somewhere.", true);
			_root.AskHerQuestions(7002, 0, 0, 0, "Training Path", "", "", "", "Please select a Training Path?");
		}
		return true;
	}
	else if (_root.NumEvent == 7012 && MoreTrainings == 1) {//standard trainings page 2
		MoreTrainings = 2;
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		_root.AskHerQuestions(7023, 7024, 7025, 7012, "Normal +", "Maid", "Rebel", "More", "Please select a Training Path?");
		return true;
	}
	else if (_root.NumEvent == 7012 && MoreTrainings == 2) {//standard trainings page 3
		MoreTrainings = 3;
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		_root.AskHerQuestions(7026, 7027, 7028, 7012, "Sex Addict", "Sex Maniac", "Wedding", "More", "Please select a Training Path?");
		return true;
	}
	else if (_root.NumEvent == 7012 && MoreTrainings == 3) {//standard trainings page 4
		MoreTrainings = 4;
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		_root.AskHerQuestions(7029, 7030, 7031, 7012, "Rich", "Drug Addict", "S&M", "More", "Please select a Training Path?");
		return true;
	}
	else if (_root.NumEvent == 7012 && MoreTrainings == 4) {//standard trainings page 5
		MoreTrainings = 5;
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		_root.AskHerQuestions(7032, 7033, 7034, 7012, "Courtesan", "Dickgirl Courtesan", "Dickgirl", "More", "Please select a Training Path?");
		return true;
	}
	else if (_root.NumEvent == 7012 && MoreTrainings == 5) {//standard trainings page 6
		MoreTrainings = 1;
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		if (SlaveName != "Belldandy" || SlaveName != "Naru" || SlaveName != "Shampoo" || SlaveName != "Urd" || SlaveName != "Yurika"){
			_root.AskHerQuestions(7035, 7036, 7037, 7012, "Pony Girl", "Dickgirl Ponygirl", "Cow Girl", "More", "Please select a Training Path?");
			MoreTrainings = 6;
		}
		else {
			_root.AskHerQuestions(7035, 7036, 7010, 7002, "Pony Girl", "Dickgirl Ponygirl", "Go Back to Start", "Training Type Selection", "Please select a Training Path?");
		}
		return true;
	}
	else if (_root.NumEvent == 7012 && MoreTrainings == 6) {//standard trainings page 7
		_root.ServantSpeak("What training would you like to accomplish with #slave?", true);
		_root.AskHerQuestions( 7010, 7002, 0, 0, "Go Back to Start", "Training Type Selection", "" , "" , "Please select a Training Path?");
		return true;
	}
	else if (_root.NumEvent == 7013 && MoreTrainings == 2) {//advanced training selections
		_root.ServantSpeak("Here is the advanced trainings I see for this slave:", true);
		if (SlaveName == "Ayane") {
			_root.AskHerQuestions(7043, 7011, 7002, 0, "Loyal Dickgirl Courtesan","Go Back to Start", "Training Type Selection",  "", "Please select a Training Path?"); 
			MoreTrainings = 0;
		}
		else if (SlaveName == "Kasumi") {
			_root.AskHerQuestions(7043, 7011, 7002, 0, "Dickgirl Winner","Go Back to Start", "Training Type Selection",  "", "Please select a Training Path?"); 
			MoreTrainings = 0;
		}
		else if (SlaveName == "Menace") {
			_root.AskHerQuestions(7043, 7044, 7011, 7002, "Exile","Cat Girl" ,"Go Back to Start", "Training Type Selection", "Please select a Training Path?"); 
			MoreTrainings = 0;
		}
		else if (SlaveName == "Orihime") {
			_root.AskHerQuestions(7043, 7044, 7011, 7002, "Deomoness","Drug Whore" ,"Go Back to Start", "Training Type Selection", "Please select a Training Path?"); 
			MoreTrainings = 0;
		}
		else if (SlaveName == "Rei") {
			_root.AskHerQuestions(7043, 7044, 7045, 7013, "Pure","Pure Dickgirl" ,"Failed Exorcist (Corrupt)", "More", "Please select a Training Path?"); 
			MoreTrainings = 3;
		}
		else if (SlaveName == "Riesz") {
			_root.AskHerQuestions(7043, 7044, 7011, 7002, "Tentacle Queen","Dickgirl Tentacle Queen" ,"Go Back to Start", "Training Type Selection", "Please select a Training Path?"); 
			MoreTrainings = 0;
		}
		return true;
	}
	else if (_root.NumEvent == 7013 && MoreTrainings == 3) {//advanced training selections
		_root.ServantSpeak("Here is the advanced trainings I see for this slave:", true);
		if (SlaveName == "Rei") {
			_root.AskHerQuestions(7046, 7047, 7048, 7013, "Failed Exorcist Dickgirl (Corrupt)","Corrupt" ,"Corrupt Dickgirl", "More", "Please select a Training Path?"); 
			MoreTrainings = 4;
		}
		return true;
	}
	else if (_root.NumEvent == 7013 && MoreTrainings == 4) {//advanced training selections
		_root.ServantSpeak("Here is the advanced trainings I see for this slave:", true);
		if (SlaveName == "Rei") {
			_root.AskHerQuestions(7049, 7050, 7051, 7013, "Assistant","Assistant Dickgirl" ,"Bride of the Gods", "More", "Please select a Training Path?"); 
			MoreTrainings = 5;
		}
		return true;
	}
	else if (_root.NumEvent == 7013 && MoreTrainings == 5) {//advanced training selections
		_root.ServantSpeak("Here is the advanced trainings I see for this slave:", true);
		if (SlaveName == "Rei") {
			_root.AskHerQuestions(7011, 7002, 0, 0, "Back to Start","Training Type Selection" ,"", "", "Please select a Training Path?"); 
			MoreTrainings = 0;
		}
		return true;
	}
	else if (_root.NumEvent == 7020) {//Prostitute
		_root.AssistantData.SetBitFlag2(10);
		_root.ServantSpeak("I will help you in training #slave to become a <b>Prostitute</b>.\r\rThis training is completed when the slave no longer qualifys for any other trainings.", true);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7021) {//Normal
		_root.ServantSpeak("I will help you in training #slave to become <b>Normal</b>.\r\rThis training is completed when the slave has a score better then 50 and Obedience greater then 30.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7022) {//Normal -
		_root.ServantSpeak("I will help you in training #slave to become <b>Normal -</b>.\r\rThis training is completed when the slave has a score better then 50 and Obedience less then 30.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7023) {//Normal +
		_root.ServantSpeak("I will help you in training #slave to become <b>Normal +</b>.\r\rThis training is completed when the slave has a score better then 50, Obedience greater then 85 and morality greater then 45.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7024) {//Maid 
		_root.ServantSpeak("I will help you in training #slave to become <b>Maid</b>.\r\rThis training is completed when the slave has a score better then 40, Cleaning greater then 60 and Cooking greater then 60.", true);
		_root.AssistantData.SetBitFlag2(14);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7025) {//Rebel
		_root.ServantSpeak("I will help you in training #slave to become <b>Rebel</b>.\r\rCongratulations you have completed this training.  Why are you wasting my time with stuff like this?", true);
		_root.AssistantData.SetBitFlag2(15);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7026) {//Sex Addict
		_root.ServantSpeak("I will help you in training #slave to become <b>Sex Addict</b>.\r\rThis training is completed when the slave has a score better then 40, Nymphomania greater then 75 and Lust greater then 75.", true);
		_root.AssistantData.SetBitFlag2(16);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7027) {//Sex Maniac
		_root.ServantSpeak("I will help you in training #slave to become <b>Sex Maniac</b>.\r\rThis training is completed when the slave has a score better then 40, Nymphomania greater then 85 and Lust greater then 85.", true);
		_root.AssistantData.SetBitFlag2(17);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7028) {//Wedding
		_root.ServantSpeak("I will help you in training #slave to become <b>Wedding</b>.\r\rThis training is completed when the slave has a score better then 75.", true);
		_root.AssistantData.SetBitFlag2(18);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7029) {//Rich
		_root.ServantSpeak("I will help you in training #slave to become <b>Rich</b>.\r\rThis training is completed when the slave has a score better then 40, owns more then 4 dresses, and have more then 3000 gold.", true);
		_root.AssistantData.SetBitFlag2(19);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7030) {//Drug Addict
		_root.ServantSpeak("I will help you in training #slave to become <b>Drug Addict</b>.\r\rThis training is completed when the slave has taken more then 3 drugs.", true);
		_root.AssistantData.SetBitFlag2(20);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7031) {//S&M
		_root.ServantSpeak("I will help you in training #slave to become <b>S&M</b>.\r\rThis training is completed when the slave has a score better then 40, and has done more then 20 bondage trainings.", true);
		_root.AssistantData.SetBitFlag2(21);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7032) {//Courtesan
		_root.ServantSpeak("I will help you in training #slave to become <b>Courtesan</b>.\r\rThis training is completed when the slave has trained under Lady Okyanu, has Charisma greater then 95, Conversation greater then 99, Refinement greater then 60, Fucking greater then 90, and Blowjobs greater then 90.", true);
		_root.AssistantData.SetBitFlag2(22);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7033) {//Dickgirl Courtesan
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Courtesan</b>.\r\rThis training is completed when the slave has trained under Lady Okyanu, has Charisma greater then 95, Conversation greater then 99, Refinement greater then 60, Fucking greater then 90, and Blowjobs greater then 90.  She will also need to drink Astrids potion more then three times and choose not to be cured.", true);
		_root.AssistantData.SetBitFlag2(23);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7034) {//Dickgirl
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl</b>.\r\rShe will need to drink Astrids potion more then three times and choose not to be cured.", true);
		_root.AssistantData.SetBitFlag2(24);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7035) {//Pony Girl
		_root.ServantSpeak("I will help you in training #slave to become <b>Ponygirl</b>.\r\rShe will need a score greater then 50 and be a ponygirl.", true);
		_root.AssistantData.SetBitFlag2(25);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7036) {//Dickgirl Ponygirl
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Ponygirl</b>.\r\rShe will need a score greater then 50 and be a ponygirl.  She will also need to drink Astrids potion more then three times and choose not to be cured.", true);
		_root.AssistantData.SetBitFlag2(26);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7037) {//Cow Girl
		_root.ServantSpeak("I will help you in training #slave to become <b>Cow Girl</b>.\r\rShe will need to be milked more then six times.", true);
		_root.AssistantData.SetBitFlag2(27);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Ayane") {//Loyal
		_root.ServantSpeak("I will help you in training #slave to become <b>Loyal</b>.\r\rShe will need to be defeated when she runs away by you and then afterwards you will need to accept her as your slave.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Ayane") {//Loyal Dickgirl 
		_root.ServantSpeak("I will help you in training #slave to become <b>Loyal Dickgirl</b>.\r\rShe will need to be defeated when she runs away by you and then afterwards you will need to accept her as your slave.  She will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Ayane") {//Loyal Courtesan 
		_root.ServantSpeak("I will help you in training #slave to become <b>Loyal Courtesan</b>.\r\rShe will need to be defeated when she runs away by you and then afterwards you will need to accept her as your slave.  She will also need to be a courtesan.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7043 && SlaveName == "Ayane") {//Loyal Dickgirl Courtesan
		_root.ServantSpeak("I will help you in training #slave to become <b>Loyal Dickgirl Courtesan</b>.\r\rShe will need to be defeated when she runs away by you and then afterwards you will need to accept her as your slave.  She will also need to be a courtesan and a dick girl.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Belldandy") {//Daemon
		_root.ServantSpeak("I will help you in training #slave to become <b>Daemon</b>.\r\rShe will need to accept an offer from a daemon.  She will also need the skills of nymphomania greater then 80, obedience greater then 80, lust greater then 80, and seduction greater then 80.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Belldandy") {//Angel 
		_root.ServantSpeak("I will help you in training #slave to become <b>Angel</b>.\r\rShe will need refuse an offer from a daemon, and then accept an offer from an angel.  She will also need the skills of charisma greater then 80, morality greater then 80, and joy great then 80.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Kasumi") {//Cumslut
		_root.ServantSpeak("I will help you in training #slave to become <b>Cumslut</b>.\r\rShe will need to drink as much cum as possible.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Kasumi") {//Dickgirl Cumslut 
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Cumslut</b>.\r\rShe will need to drink as much cum as possible.  She will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Kasumi") {//Winner 
		_root.ServantSpeak("I will help you in training #slave to become <b>Winner</b>.\r\rHer combat skill must be greater then 80, constitution greater then 80, temperament greater then 70, score greater then 75.  If at any time she confesses her love of cum to you, remind her of her love for martial arts.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7043 && SlaveName == "Kasumi") {//Dickgirl Winner
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Winner</b>.\r\rHer combat skill must be greater then 80, constitution greater then 80, temperament greater then 70, score greater then 75.  If at any time she confesses her love of cum to you, remind her of her love for martial arts.  She will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Menace") {//Arena Cat Champion
		_root.ServantSpeak("I will help you in training #slave to become <b>Arena Cat Champion</b>.\r\rShe will need visit a large number of cat girls and choose to become one.  She will also need to win in the Arena.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Menace") {//Arena Champion  
		_root.ServantSpeak("I will help you in training #slave to become <b>Arena Champion </b>.\r\rShe will need to win in the Arena.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Menace") {//Drug Whore 
		_root.ServantSpeak("I will help you in training #slave to become <b>Drug Whore</b>.\r\rShe will need to drink the drug Dorei, and then 2 other rare drugs.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7043 && SlaveName == "Menace") {//Exile
		_root.ServantSpeak("I will help you in training #slave to become <b>Exile</b>.\r\rShe will need to accomplish high class courtesian training.  After that the slave will need to gain support from many notables.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7044 && SlaveName == "Menace") {//Cat Girl
		_root.ServantSpeak("I will help you in training #slave to become <b>Cat Girl</b>.\r\rShe will need visit a large number of cat girls and choose to become one.", true);
		_root.AssistantData.SetBitFlag2(14);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Minako") {//Cat-Slave
		_root.ServantSpeak("I will help you in training #slave to become <b>Cat-Slave</b>.\r\rShe will need a Catgirl Suit.  She will also need to meet cat slaves and keep talking to them about their life when given the opportunity.  Eventually, she will accept being a cat slave.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Minako") {//Cat Savior  
		_root.ServantSpeak("I will help you in training #slave to become <b>Cat Savior</b>.\r\rShe will need a Catgirl Suit.  She will also need to meet cat slaves and keep talking to them about their life when given the opportunity.  Eventually, she will accept being a cat slave.  She will then need to meet the Cat slave at the Brothel to find that True Catgirls live in the Forest and be given the proper greeting.  She will then go to the Lake and agree to help Millenia.  Find Malerna being abused by Tirana using the lend.  Discuss with her and then lend her to free Malerna, suggest loaning her, then Lend Her again, say you want to learn more, and then attack now. All other choices will fail. You will be Fined when you succeed and for each failure.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Naru") {//Bride of the Goddess 
		_root.ServantSpeak("I will help you in training #slave to become <b>Bride of the Goddess</b>.\r\rShe will need a total score greater then 75.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Orihime") {//Priestess
		_root.ServantSpeak("I will help you in training #slave to become <b>Priestess</b>.\r\rShe will need to be cleaned of the taint following her, after the cleaning she will need to choose to become a priestess.  After that she will need to preach the word of the old gods many times in the street.  Orihime will also need intelligence greater then 75 and morality greater then 85.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Orihime") {//Corrupt Priestess 
		_root.ServantSpeak("I will help you in training #slave to become <b>Corrupt Priestess</b>.\r\rShe will need to be cleaned of the taint following her, after the cleaning she will need to choose to become a priestess.  After that she will need to preach the word of the old gods many times in the street.  Orihime will also need intelligence greater then 75 and morality less then 25.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Orihime") {//Demon Lover 
		_root.ServantSpeak("I will help you in training #slave to become <b>Demon Lover</b>.\r\rShe will need a demon's dress, and to accept the darkness.  She will then need to gain the peices of a demon, a tail, horn, and wings.  Finally she will have to choose to become the lover of a demon.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7043 && SlaveName == "Orihime") {//Deomoness
		_root.ServantSpeak("I will help you in training #slave to become <b>Demon Lover</b>.\r\rShe will need a demon's dress, and to accept the darkness.  She will then need to gain the peices of a demon, a tail, horn, and wings.  Finally she will have to choose not to become a demon.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7044 && SlaveName == "Orihime") {//Drug Whore 
		_root.ServantSpeak("I will help you in training #slave to become <b>Drug Whore</b>.\r\rShe will need to drink Nymph's Tear three times.", true);
		_root.AssistantData.SetBitFlag2(14);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Ranma") {//Running Away
		_root.ServantSpeak("I will help you in training #slave to become <b>Running Away</b>.\r\rShe will need stats of intelligence less then 20 and temperment greater then 35.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Ranma") {//Cat-slave 
		_root.ServantSpeak("I will help you in training #slave to become <b>Cat-slave</b>.\r\rShe will need to wear the cat outfit.  She will also need constitution greater then 80, lust greater then 80, and joy greater then 80.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Ranma") {//Dickgirl Cat-slave  
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Cat-slave</b>.\r\rShe will need to wear the cat outfit.  She will also need constitution greater then 80, lust greater then 80, and joy greater then 80.  Lastly she will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Rei") {//Failed Exorcist
		_root.ServantSpeak("I will help you in training #slave to become <b>Failed Exorcist</b>.\r\rShe will need to be be an exorcist and that is it.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Rei") {//Failed Exorcist Dickgirl
		_root.ServantSpeak("I will help you in training #slave to become <b>Failed Exorcist Dickgirl</b>.\r\rShe will need to be be an exorcist and that is it.  She will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Rei") {//Pure 
		_root.ServantSpeak("I will help you in training #slave to become <b>Pure</b>.\r\rShe will need to be be an exorcist.  She will also need a purity greater then 90, also morality greater then 80.  She must also succeed the majority of exorcism tests (any 4).", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7043 && SlaveName == "Rei") {//Pure Dickgirl
		_root.ServantSpeak("I will help you in training #slave to become <b>Pure Dickgirl</b>.\r\rShe will need to be be an exorcist.  She will also need a purity greater then 90, also morality greater then 80.  She must also succeed the majority of exorcism tests (any 4).  Finally, she will also need to be a dickgirl.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7044 && SlaveName == "Rei") {//Failed Exorcist (Corrupt)  
		_root.ServantSpeak("I will help you in training #slave to become <b>Failed Exorcist (Corrupt)</b>.\r\rYou will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.", true);
		_root.AssistantData.SetBitFlag2(14);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7045 && SlaveName == "Rei") {//Failed Exorcist Dickgirl (Corrupt) 
		_root.ServantSpeak("I will help you in training #slave to become <b>Failed Exorcist Dickgirl (Corrupt)</b>.\r\rYou will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.  Finally, she will also need to be a dickgirl.", true);
		_root.AssistantData.SetBitFlag2(15);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7046 && SlaveName == "Rei") {//Corrupt
		_root.ServantSpeak("I will help you in training #slave to become <b>Corrupt</b>.\r\rYou will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.  She will also need conservation greater then 55, charisma greater then 90, constitution greater then 60, and blowjob greater then 50.  Lastly she will need to recruit three followers.", true);
		_root.AssistantData.SetBitFlag2(16);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7047 && SlaveName == "Rei") {//Corrupt Dickgirl
		_root.ServantSpeak("I will help you in training #slave to become <b>Corrupt Dickgirl</b>.\r\rYou will need to discuss demons with her every day.  You will also need to anythng you can to lower her morality.  She will also need conservation greater then 55, charisma greater then 90, constitution greater then 60, and blowjob greater then 50.  Then she will also need to recruit three followers.  Finally, she will need to be a dickgirl.", true);
		_root.AssistantData.SetBitFlag2(17);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7048 && SlaveName == "Rei") {//Assistant
		_root.ServantSpeak("I will help you in training #slave to become <b>Assistant</b>.\r\rYou will need to discuss the world and fun every day.  You will also need to lower her morality.  Last she will need to experience as many possible things as possible.", true);
		_root.AssistantData.SetBitFlag2(18);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7049 && SlaveName == "Rei") {//Assistant Dickgirl 
		_root.ServantSpeak("I will help you in training #slave to become <b>Assistant Dickgirl</b>.\r\rYou will need to discuss the world and fun every day.  You will also need to lower her morality.  Last she will need to experience as many possible things as possible.  Finally, she will need to be a dickgirl.", true);
		_root.AssistantData.SetBitFlag2(19);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7050 && SlaveName == "Rei") {//Bride of the Gods 
		_root.ServantSpeak("I will help you in training #slave to become <b>Bride of the Gods</b>.\r\rYou will need to discuss the world and fun every day.  You will also need to lower her morality.  Last she will need to experience as many possible things as possible.  Finally she will need a score greater then 75.", true);
		_root.AssistantData.SetBitFlag2(20);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Riesz") {//Dickgirl Toy
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Toy</b>.\r\rShe will need go to the brothel brothel and sleazy bar many times.  Do not bribe the fake delegation.  She will also need to become a dick girl.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Riesz") {//Wolf Knight
		_root.ServantSpeak("I will help you in training #slave to become <b>Wolf Knight</b>.\r\rShe will need to wear the wolf knight dress.  She will need to visit the knight to start a quest, for the quest she will need to capture 3 fairies, capture a demon girl, defeat 3 tentacles, and last harvest 7 leters of cum from a demon.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7042 && SlaveName == "Riesz") {//Dickgirl Wolf Knight 
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Wolf Knight</b>.\r\rShe will need to wear the wolf knight dress.  She will need to visit the knight to start a quest, for the quest she will need to capture 3 fairies, capture a demon girl, defeat 3 tentacles, and last harvest 7 leters of cum from a demon.  She will also need to become a dick girl.", true);
		_root.AssistantData.SetBitFlag2(12);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7043 && SlaveName == "Riesz") {//Tentacle Queen 
		_root.ServantSpeak("I will help you in training #slave to become <b>Tentacle Queen</b>.\r\rShe will need to submit to the tentacles, then convert 4 people into tentacle followers.  This will require stats of conservation greater then 66, nymphomania greater then 70, lust greater then 70, and special stat hunting greater then 46.", true);
		_root.AssistantData.SetBitFlag2(13);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7044 && SlaveName == "Riesz") {//Dickgirl Tentacle Queen 
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Tentacle Queen</b>.\r\rShe will need to submit to the tentacles, then convert 4 people into tentacle followers.  This will require stats of conservation greater then 66, nymphomania greater then 70, lust greater then 70, and special stat hunting greater then 46. She will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(14);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Shampoo") {//Dickgirl Mother
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Mother</b>.\r\rShe will need to drink 3 of Astrid's potions and then accept her conditions.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Shampoo") {//Perfect Slave 
		_root.ServantSpeak("I will help you in training #slave to become <b>Perfect Slave </b>.\r\rShe will need a score greater then 85.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7040 && SlaveName == "Urd") {//Alchemist
		_root.ServantSpeak("I will help you in training #slave to become <b>Alchemist</b>.\r\rShe will need a score greater then 80, and an alchemy score greater then 80.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Urd") {//Dickgirl Alchemist
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Alchemist</b>.\r\rShe will need a score greater then 80, and an alchemy score greater then 80.  She will also need to be a dick girl.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
		else if (_root.NumEvent == 7040 && SlaveName == "Yurika") {//Dickgirl Cow
		_root.ServantSpeak("I will help you in training #slave to become <b>Dickgirl Cow</b>.\r\rShe will need to drink Astrid's potion three times, when Astrid offer's to buy her accept.", true);
		_root.AssistantData.SetBitFlag2(10);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7041 && SlaveName == "Yurika") {//Duel Prize Dickgirl Cow
		_root.ServantSpeak("I will help you in training #slave to become <b>Duel Prize Dickgirl Cow</b>.\r\rShe will need to drink Astrid's potion three times, when Astrid offer's to buy her decline, and then lose the battle to Astrid.", true);
		_root.AssistantData.SetBitFlag2(11);
		_root.AssistantData.SetBitFlag2(9);
		_root.NumEvent = 9999;
		_root.NextEvent._visible = true;		
		return true;
	}
	else if (_root.NumEvent == 7075) {		
		_root.AssistantData.SetBitFlag2(50);
		funcMugiTrainingMenu();
		return true;
	}
	else if (_root.NumEvent == 7076) {
		funcMugiTrainingMenu();
		return true;
	}
		
	return false;
}

//training menu can be called for events on or off so this makes sure there is only one copy
function funcMugiTrainingMenu() {
	_root.ServantSpeak("Next, I need to know how much help you want me to give you.", true);
	_root.BlankLine();
	_root.ServantSpeak("I offer three levels of help:\r\rBasic, I will warn of events, suggest undone items, and best training methods.  \r\rBasic is designed for new Slave Makers, who want to be surprised and are not that familiar with training slaves.  \r\rHelper: I will tell you what endings you are moving towards, and also will give you the same help as basic.  \r\rHelper is designed to provide you with a bit more information about endings but only currently achieved endings.  \r\rGuided:You can select an ending and I will guide you to it, as well as give the help that is provided with both basic and helper.", true);
	_root.BlankLine();
	if (_root.AssistantData.CheckBitFlag2(0) != true ) {
		_root.AskHerQuestions(7000, 7001, 7002, 0, "Basic", "Helper", "Guided", "", "How much help do you want?");
	}
	else {
		_root.ServantSpeak("Advanced: I will show you all my secrets.  \r\rAdvanced is only recomeneded for SM developers.", true);
		_root.AskHerQuestions(7000, 7001, 7002, 7003, "Basic", "Helper", "Guided", "Advanced", "How much help do you want?");
	}
}

_global.dpn = function(x, d) {
	x = x * Math.pow(10, d);
	var y = Math.round(x);
	y = y / Math.pow(10, d);
	return y;
// Created by Mark Freeman 
// markfreemanwebdesigner@yahoo.com
}

// stop and hide any graphics on initial load
Assistant.gotoAndStop(1);
HideAsAssistant();