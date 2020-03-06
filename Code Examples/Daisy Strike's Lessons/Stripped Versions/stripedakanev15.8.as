// BitFlags
//	1 = offer hammer in shop
//  2 = Shampoo got Priapus Draft

#include "common.as"

// General

function IsCatgirl() : Boolean  //unmodified
{
	return false;
}

function UpdateDateAndItems(NumDays:Number) //unmodified
{ 
	_root.VarTemperament = _root.VarTemperament + (NumDays / 2);
	_root.VarObedience = _root.VarObedience - (NumDays / 2);
}

function ApplyDifficulty(Charisma:Number, Morality:Number, Cooking:Number, Cleaning:Number, Conversation:Number, Fatigue:Number) { //unmodified
	_root.CookingFactor = _root.dmod / 2;
}

function DrinkPotion(potion:Number, price:Number, pname:String, say:String) : Boolean //unmodified removing majority akane only event
{
	/*if (potion == 0) {
		// Dickgirl
		switch(int(Math.random()*3)) {
			case 0:
				_root.SetText(SlaveName + " drops to the ground and irresistibly masturbates over and over, cumming all over even into her own mouth.");
				ClipDickgirl.gotoAndStop(1);
				break;
			case 1:
				_root.SetText(SlaveName + " compulsively sucks on her own huge cock, cumming over and over again, swallowing all of her cum.");
				ClipDickgirl.gotoAndStop(2);
				break;
			case 2:
				_root.HideBackgrounds();
				_root.Backgrounds.ShowSchool();
				if (_root.ServantName == "Shampoo") _root.SetText(SlaveName + " feels an incredible desire to fuck. " + _root.ServantName + " looks a little annoyed and takes her into a store-room. " + SlaveName + " inexpertly starts to fuck, but " + _root.ServantName + " instructs her until they both reach intense orgasms.");
				else _root.SetText(SlaveName + " feels an incredible desire to fuck. Astrid smile and suggest she steps into store-room.\r\r" + SlaveName + " opens the door and sees a woman waiting there who silently starts removing her clothes. " + SlaveName + " inexpertly starts to fuck, and the woman silently instructs her until they both reach intense orgasms, " + SlaveName + " pulling out and cumming over the woman's stomach.");
				ClipDickgirl.gotoAndStop(3);
				break;
		}
		ClipDickgirl._visible = true;
		_root.Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 0, 0, 0, 4, 0, 0);
		_root.AddText("\r\rAfter a time Astrid joins and they fuck each other.");
		return false;
	}*/
	return true;
}

function ShowTrainingComplete() : Boolean //unmodified
{
	if (_root.NobleLove == -2) _root.SetText("The training of " + SlaveName + " is finished and the Lord has taken possession of her.\r\rSome weeks have passed since then...");
	return false;
}

// Assistant

function ShowAsAssistant(type:Number) : Boolean //unmodified
{
	if (type == 4) return false;
	switch(type) {
		case 1:
			_root.ShowMovie(this.EndingBoughtBack, false, 2);
			break;
		case 2:
			_root.ShowMovie(this.ClipTentacle, false, 2, 4);
			_root.AssistantBackground._visible = true;
			break;
		case 3:
			_root.ShowMovie(this.ClipRaped, false, 1);
			break;
		case 5:
			PromenadeClip.gotoAndStop(2);
			_root.ShowMovie(this.PromenadeClip, false, 1);
			break;
		case 6:
			ClipLoveRefused._visible = true;
			break;
	}
	return true;
}

function ShowAsAssistantTentacleSex() : Boolean //unmodified
{
	ShowTentacleSex();
	_root.ShowMovie(this.ClipTentacle, true, 1);
	return true;
}

function ShowAsAssistantAnal() : Boolean //unmodified
{
	AnalClip.gotoAndStop(int(Math.random()*2) + 1);
	AnalClip._visible = true;
	return true;
}

function ShowAsAssistantSpanking() : Boolean //unmodified
{
	SpankClip.gotoAndStop(3);
	SpankClip._visible = true;
	return true;
}

function HideAsAssistant() //unmodified
{
	EndingBoughtBack._visible = false;
	ClipLoveRefused._visible = false;
	ClipRaped._visible = false;
	PromenadeClip._visible = false;
	ClipTentacle._visible = false;
	PromenadeClip._visible = false;
	AnalClip._visible = false;
	SpankClip._visible = false;
}

function InitialiseAsAssistant() { //unmodified
	_root.ServantName = "Akane";
	HideImages();
	HideSlaveActions();
	HideEndings();
	HideRobes();
}


// Contests

function ShowContestBeauty(total:Number) :Number //unmodified
{
	ClipContestsBeauty._visible = true;
	return total;
}

function ShowContestCourt(total:Number) : Number //unmodified
{
	ClipContestsCourt._visible = true;
	return total;
}

function ShowContestHousework(total:Number) : Number //unmodified
{
	ClipContestsHousework._visible = true;
	return total;
}

function ShowContestPonygirl(total:Number) : Number //unmodified
{
	ShowSexActPonygirl();
	return total;
}

function ShowContestXXX(total:Number) : Number //unmodified
{
	if (_root.IsDickgirl()) ClipContestsXXX.gotoAndStop(2);
	else ClipContestsXXX.gotoAndStop(int(Math.random()*2) + 1);
	ClipContestsXXX._visible = true;
	return total;
}


// Dickgirl

function IsDickgirl() : Boolean //unmodified
{
	return false;
}

function DickgirlPotionOffer() //unmodified
{
	/*_root.AddText(" looks unhappy\r\r");
	_root.SlaveSpeak("No! not again, I am a girl, it does not matter how nice it felt.", true); 
	_root.AddText("\r\rAs " + SlaveName + " turns to leave she notices " + _root.ServantName + " whispering to Astrid and they both laugh.\r\r" + SlaveName + " is a little annoyed they did not share their joke.");
	_root.NumEvent = 0;
	_root.SetBitFlag2(2);*/
}

function ShowDickgirlTransform() : Boolean //unmodified
{
	return true;
}

function ShowDickgirlPermanent() : Boolean //unmodified
{
	ClipDickgirl.gotoAndStop(2);
	ClipDickgirl._visible = true;
	return true;
}

function AfterDickgirlPotion(num:Number) //unmodified
{
	/*_root.AddText("\r\r" + SlaveName + " looks very tired but also seems worried.\r\r");
	_root.SlaveSpeak("I am a girl, I do not want a become masculine, and not cute!\r\rIt did feel really, really gooood....", true);
	_root.AddText("\r\r" + _root.ServantName + " looks amused.");*/	
}


// Dress

function RemoveDress() { //unmodified
	if (_root.DressWorn == 1) _root.PointsMod(0, 0, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 2) _root.PointsMod(-10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 3) _root.PointsMod(0, -5, -10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 4) _root.PointsMod(-10, -10, -10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 5) _root.PointsMod(-10, 0, -10, 0, 0, -15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 6) _root.PointsMod(-35, -15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -10, -15, 0, -15);
}

function WearDress() {
	if (_root.DressWorn == 1) _root.PointsMod(0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 2) _root.PointsMod(10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 3) _root.PointsMod(0, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 4) _root.PointsMod(10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 5) _root.PointsMod(10, 0, 10, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 6) _root.PointsMod(35, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 15, 0, 15);
}

function ShowNaked() { //unmodified
	_root.DressLeash.gotoAndStop(2);
	if (_root.DickgirlXF > 0) NakedClip.gotoAndStop(_root.ChoiceNaked(2, 4));
	else NakedClip.gotoAndStop(_root.ChoiceNaked(3, 1));
	switch (NakedChoice) {
		case 1:
		_root.DressLeash._width = 80;
		_root.DressLeash._height = 98
		_root.DressLeash._x = 253;
		_root.DressLeash._y = -17;
		_root.DressHalo._x = 197;
		_root.DressHalo._y = 19;
		_root.DressBitgag._x = 210;
		_root.DressBitgag._y = 59;
		_root.DressBitgag._width = 30;
		break;
	case 3:
	case 4:
		_root.DressLeash._width = 100;
		_root.DressLeash._height = 122.5
		_root.DressLeash._x = 248;
		_root.DressLeash._y = 5;
		_root.DressBitgag._x = 185;
		_root.DressBitgag._y = 86;
		_root.DressHalo._rotation = 20;
		_root.DressBitgag._width = 45;
		_root.DressBitgag._height = 9;
		break;
	case 2:
	case 5:
		_root.DressLeash._width = 105;
		_root.DressLeash._height = 122.5
		_root.DressLeash._x = 272;
		_root.DressLeash._y = 7;
		_root.DressHalo._x = 200;
		_root.DressHalo._y = 19;
		_root.DressBitgag._x = 208;
		_root.DressBitgag._y = 95;
		_root.DressBitgag._rotation = -10;
		break;
	}
	NakedClip._visible = true;
}

function ShowDress() { //unmodified
	_root.DressLeash.gotoAndStop(2);
	if (_root.DressWorn == 0) {
		_root.DressLeash._width = 70;
		_root.DressLeash._height = 140;
		_root.DressLeash._x = 295;
		_root.DressLeash._y = -24;
		_root.DressLeash._rotation = 30;
		_root.DressBitgag._x = 215;
		_root.DressBitgag._y = 49;
		_root.DressBitgag._width = 30;
		_root.DressBitgag._rotation = 20;
		RobePlainClip._visible = true;
	} else if (_root.DressWorn == 1) {
		_root.DressLeash._width = 70;
		_root.DressLeash._height = 107;
		_root.DressLeash._x = 264;
		_root.DressLeash._y = -14;
		_root.DressHalo._y = 28;
		_root.DressBitgag._x = 230;
		_root.DressBitgag._y = 63;
		Robe1Clip._visible = true;
	} else if (_root.DressWorn == 2) {
		_root.DressLeash._height = 100;
		_root.DressLeash._x = 195;
		_root.DressLeash._y = -7;
		_root.DressLeash._xscale = -30;
		_root.DressLeash._rotation = 20;
		_root.DressHalo._y = 20;
		_root.DressHalo._rotation = 40;
		_root.DressBitgag._x = 193;
		_root.DressBitgag._y = 70;
		_root.DressBitgag._width = 30;
		_root.DressBitgag._rotation = 20;
		Robe2Clip._visible = true;
	} else if (_root.DressWorn == 3) {
		_root.DressLeash._width = 60;
		_root.DressLeash._height = 100;
		_root.DressLeash._x = 265;
		_root.DressLeash._y = -10;
		_root.DressLeash._rotation = 10;
		Robe3Clip._visible = true;
		_root.DressBitgag._x = 220;
		_root.DressBitgag._y = 61;
		_root.DressBitgag._width = 30;
	} else if (_root.DressWorn == 4) {
		_root.DressLeash._width = 70;
		_root.DressLeash._height = 86.4;
		_root.DressLeash._x = 261;
		_root.DressLeash._y = 1;
		_root.DressHalo._y = 19;
		_root.DressBitgag._x = 219;
		_root.DressBitgag._y = 67;
		_root.DressBitgag._width = 30;
		Robe4Clip._visible = true;
	} else if (_root.DressWorn == 5) {
		Robe5Clip._visible = true;
		_root.DressLeash._width = 95;
		_root.DressLeash._height = 91.2;
		_root.DressLeash._x = 278;
		_root.DressLeash._y = 8;
		_root.DressBitgag._rotation = -20;
		_root.DressBitgag._y = 79;
		_root.DressBitgag._x = 227;
	} else if (_root.DressWorn == 6) {
		_root.DressLeash._width = 90;
		_root.DressLeash._x = 256;
		_root.DressLeash._y = -2;
		_root.DressBitgag._x = 211;
		_root.DressBitgag._y = 88;
		_root.DressHalo._x = 194;
		_root.DressHalo._y = 30;
		Robe6Clip._visible = true;
	}
}



// Items

function ShowBunnySuit() : Boolean //unmodified
{
	SleazyBarClip.gotoAndStop(5);
	SleazyBarClip._visible = true;
	return true;
}


function ShowLingerie() : Boolean //unmodified
{
	SleazyBarClip.gotoAndStop(int(Math.random()*2) + 3);
	SleazyBarClip._visible = true;
	return true;
}

/*function PurchaseWeapon(hint:Boolean) : Boolean //unmodified
{
	if (hint || _root.CheckBitFlag2(1)) return false;
	_root.PersonSpeakEnd();
	_root.AddText("\r\r" + SlaveName + " offers you a large mallet or hammer. You are rather perplexed where she got it from. The merchant looks surprised too.\r\rDo you accept it as a weapon?");
	_root.SetBitFlag2(1);
	_root.DoYesNoEvent(310);
	return true;
}
*/
// Events 

function DoEventYes() : Boolean //unmodified
{
	/*if (_root.NumEvent == 300) {
		_root.HideStatChangeIcons();
		_root.HideImages();
		_root.DressOverlay._visible = true;
		_root.InitialiseNight();
		_root.UseGeneric = false;
		ShowSexActBondage();
		if (_root.UseGeneric) _root.Generic.ShowSexActBondage();
		if (_root.House == 1) _root.Points(0, 2 + _root.SilkenRopesOK, 0, 0, -4, 0, 0, 0, 0, 0, 0, -4, 4, 9, 7, 0, 2, -2, -2, 0);
		_root.Points(0, 2 + _root.SilkenRopesOK, 0, 0, -4, 0, 0, 0, 0, 0, 0, -4, 4, 8, 6, 0, 2, -2, -2, 0);
		_root.NumEvent = 9999;
		_root.SetText("You and " + _root.ServantName + " spend the day correcting " + SlaveName + " while she is tightly tied up. Despite herself she seems to enjoy parts of it, cumming occaisonally.");
		_root.Day = true;
		_root.Behaving = Behaving + 6;
		_root.NextGeneral._visible = true;
		_root.DifficultyBondage = _root.DifficultyBondage - 2;
		return true;
	} else if (_root.NumEvent == 310) {
		_root.WeaponType = 4;
		_root.UpdateEquipment();
		_root.SetText("The hammer is an odd weapon but " + SlaveName + " assures you it is very effective.");
		_root.ObjectsLarge._visible = true;
		_root.ObjectsLarge.gotoAndStop(15);
		_root.HideBackgrounds();
		_root.DoEvent(9700);
		return true;
	}*/
	return false;
}

function DoEventNo() : Boolean //unmodified
{
	/*if (_root.NumEvent == 300) {
		_root.HideStatChangeIcons();
		_root.HideImages();
		_root.DressOverlay._visible = true;
		ShowChoreDiscuss();
		_root.Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0);
		_root.SetText("You decide to talk to " + SlaveName + " and talk through the issue and tell her she needs to obey " + _root.ServantName + ". She agrees and appreciates the talk.");
		_root.NumEvent = 9999;
		_root.NextVisit._visible = true;
		return true;
	} else if (_root.NumEvent == 310) {
		_root.PurchaseWeapon(false);
		_root.Quitter._visible = true;
		return true;
	}*/
	return false;
}

function Events() //unmodified
{
	/*if (_root.DoneEvent == 0 && _root.CustomFlag < 2 && _root.VarObedience < 50) {
		if ((_root.GameDate > 8 && _root.CustomFlag == 0) || (_root.GameDate > 13 && _root.CustomFlag == 1)) {
			EventShampooTrouble._visible = true;
			temp = _root.CustomFlag + 1;
			if (_root.ServantName != "Shampoo" && temp == 2) temp = 3;
			EventShampooTrouble.gotoAndStop(temp);
			if (_root.CustomFlag == 0) {
				_root.Backgrounds.ShowSlums();
				_root.SetText("You find " + SlaveName + " tied up and rather upset.\r\r");
				_root.SlaveSpeak("I was arguing with that bitch " + _root.ServantName + " and " + _root.ServantHeShe + " got angry and overpowered me and tied me here. She said she would come back and free me but it has been a long time!", true);
				_root.AddText("\r\rYou free " + SlaveName + " and then find " + _root.ServantName + " and scold her.");
			} else {
				_root.SetText("You find " + _root.ServantName + " chastising a tied up " + SlaveName + ". Both are naked and seem rather aroused. " + SlaveName + " seems upset but is not really stuggling to get free. " + _root.ServantName + " is dominating her and also seems to be enjoying it.\r\rYou watch for a bit and then interrupt them and end it. Both of them seem a bit disappointed.");
			}
			_root.DoEvent(9999);
			_root.Points(0, 1 + _root.SilkenRopesOK, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, _root.CustomFlag + 1, 2, _root.CustomFlag + 1, 0, 1, 1, 0, 0);
			_root.CustomFlag = _root.CustomFlag + 1;
		} 
	}
	if (_root.DoneEvent == 0 && _root.VarObedienceRounded<90 && _root.Behaving < 1 && _root.GameDate > 8) {
		temp = int(Math.random()*5);
		if (temp == 1) {
			if (_root.ServantName == "Shampoo") ClipPunish.gotoAndStop(1);
			else ClipPunish.gotoAndStop(2);
			ClipPunish._visible = true;
			_root.ServantSpeak(SlaveName + " was being rebellious and started hitting me. I have restrained her, and think we need to thoroughly discipline her.\r\rShall we spend the day disciplining her?");
			_root.DoYesNoEvent(300);
		} 
	}
	if (_root.DoneEvent == 0 && _root.CheckBitFlag2(2)) {
		_root.PotionsUsed[0] = _root.PotionsUsed[0] + 1;
		if (_root.PotionsUsed[0] == 2) {
			_root.SetText("You hear a garbled cry from " + SlaveName + "'s room and you run in. You see she is covered in cum erupting from a cock that has grown from her groin. A lot of the cum is pouring into her mouth and she is gagging and struggling to swallow it all.\r\rYou pull her cock free and she coughs and gasps, her cock still cumming. Eventually, after coating you both in her cum, she gasps and stops cumming. Her cock shrinks and disappears as she pants and lies back in a large puddle of her cum.\r\rYou wonder why this has happened, possibly some delayed effect of her experience at Astrid's place?\r\rYou see " + _root.ServantName + " standing at the door smiling.");
			_root.DoEvent(9999);
		} else {
			_root.SetText("Again, you hear a garbled cry from " + SlaveName + "'s room and you run in. You see she again is cumming from a large cock, pouring cum over her breasts, her hair, her face, her bed, but mostly into her mouth as she tries to swallow it. You pull her free and hold her, but she keeps cumming and cumming. After a time you realise she does not seem to be stopping. A worried " + _root.ServantName + " runs in and clamps a hand around the base of " + SlaveName + "'s cock, holding tightly. " + SlaveName + " stops cumming but gasps, moans and strains as if she wants to. " + _root.ServantName + " looks ashamed,\r\r");
			_root.ServantSpeak(_root.ServantPronoun + " am sorry " + _root.Master + "! I slipped her some of the Priapus Draft, she seemed to dislike it so much, but also to like it so much.", true);
			_root.AddText("\r\rYou are angry and scold " + _root.ServantName + " promising to punish " + _root.ServantHimHer + " severely. You decide you need to consult with Astrid and between you and " + _root.ServantName + " you work out where she lives.\r\rYou take " + SlaveName + " to Astrid. By the time you get there " + SlaveName + " has calmed a little, and is no longer cumming continuously, but still occaisonally...");
			_root.DoEvent(210);
		}
		ClipDickgirl.gotoAndStop(4);
		ClipDickgirl._visible = true;
		_root.Icons.DickgirlXFIcon._visible = true;
		_root.ClearBitFlag2(2);
		_root.NextEvent._visible = true;
	}*/
}

function ShowDating() //unmodified
{
	_root.Backgrounds.ShowBedRoom();
	ClipDating._visible = true;
}

function ShowTired(cum:Boolean) //unmodified
{
	if (_root.IsDickgirl()) ClipTired.gotoAndStop(2);
	else if (cum || Naked) ClipTired.gotoAndStop(3);
	else ClipTired.gotoAndStop(int(Math.random()*2) + 1);
	ClipTired._visible = true;
}

function ShowPropositionAccepted() //unmodified
{
	ClipPropositionAccepted._visible = true;
}

function ShowPropositionRefused() //unmodified
{
	ClipPropositionRefused._visible = true;
}

function ShowRetrieved() //unmodified
{
	_root.ClipRescue._visible = false;
	_root.ClipRunaway._visible = false;
	if (_root.IsDickgirl()) {
		BondageClip.gotoAndStop(1);
		BondageClip._visible = true;
	} else ClipSlaveRetrieved._visible = true;
}

function ShowRaped() : Boolean //unmodified
{
	if (_root.DickgirlXF > 0) return false;
	ClipRaped._visible = true;
	return true;
}

function AfterPonyMistress() //unmodified
{
	//_root.AddText("\r\r" + SlaveName + " expresses her amazement that someone would want to experience life as a ponygirl. She asks many questions of the mistress and her ponygirls.");
}

function ShowMilkFall() : Boolean //unmodified
{
	ClipTired._visible = true;
	ClipTired.gotoAndStop(2);
	return true;
}

function ShowMilking() //unmodified
{
	_root.UseGeneric = true;
}

function ShowMilkEnd() : Boolean //unmodified
{				
	EventMilk._visible = true;
	return true;
}

function ShowMilkAccident() : Boolean //unmodified
{				
	ExhibClip.gotoAndStop(3);
	ExhibClip._visible = true;
	return true;
}

function ShowMorningMouthfull() : Boolean //unmodified
{
	EventMorningMouthfull._visible = true;
	return true;
}

function ShowNakedApron() : Boolean //unmodified
{
	EventNakedApron._visible = true;
	return true;
}

// Love

function ShowLoveConfession() //unmodified
{
	_root.Backgrounds.ShowTownCenter();
	ClipLoveConfession._visible = true;
}

function ShowLoveAccepted()  : Boolean //unmodified
{
	_root.HideBackgrounds();
	ClipLoveConfession._visible = false;
	ClipLoveAccepted._visible = true;
	return false;
}

function ShowLoveRefused() //unmodified
{
	_root.HideBackgrounds();
	ClipLoveConfession._visible = false;
	ClipLoveRefused._visible = true;
	if (_root.NumEvent == 3) {
		_root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0, -15, -20, 0);
		_root.SetText(SlaveName + " is very sad but at least you don't let your personal likes interfere with your job.");
	}
}

/*function NobleLove(allowoffer:Boolean)
{
	if ((allowoffer == true && _root.NobleLove == -1) || _root.NobleLove == 6) {
		_root.AddText("\r\rThe Lord is sure of his love and asks to buy " + SlaveName + " for 1500GP. " + SlaveName + " doesn't wish to be sold saying he is intense and a bit odd.\r\rDo you sell her.");
		_root.Quitter._visible = false;
		_root.ShowMovie(_root.PeopleLord, true, 1);
		_root.DoYesNoEvent(13);
	} else if (_root.NobleLove == -2) _root.AddText("\r\r" + SlaveName + " visits her new owner out of duty.");
	else if (_root.NobleLove == -1) _root.AddText("\r\rThe Lord dotes upon " + SlaveName + " promising her future happiness.");
	else if (_root.NobleLove < 3)  _root.AddText("\r\rThe Lord gives " + SlaveName + " many compliments and praises her beauty. He invites her to visit anytime.");
	else if (_root.NobleLove < 5)  _root.AddText("\r\rThe Lord expresses his ardent admiration of " + SlaveName + " and appears most taken with her.");
	else if (_root.NobleLove < 6)  _root.AddText("\r\rThe Lord enthusiastically confesses his love to " + SlaveName + ". She thanks him but refuses his confession.");
}

function ShowNobleLoveRefused()
{
	_root.SetText("The Lord is very sad but makes it clear he loves her and the offer stands.");
	ClipNobleLove.gotoAndStop(2);
	ClipNobleLove._visible = true;
}

function ShowNobleLoveAccepted()
{
	_root.SetText("The Lord");
	_root.Money(1500);
	ClipNobleLove._visible = true;
	ClipNobleLove.gotoAndStop(1);
}
*/

// Daytime

function ShowChoreCleaning() //unmodified
{
	if (!_root.DoDickgirlChange(33)) CleaningClip._visible = true;
}

function ShowChoreCooking() //unmodified
{
	if (_root.UseGeneric) return;
	temp = int(Math.random()*2) + 1;
	if (temp == 2) _root.HideBackgrounds();
	CookingClip.gotoAndStop(temp);
	CookingClip._visible = true;
}

function ShowChoreDiscuss() //unmodified
{
	_root.HideBackgrounds();
	if (Naked) DiscussClip.gotoAndStop(3);
	else DiscussClip.gotoAndStop(int(Math.random()*2) + 1);
	DiscussClip._visible = true;
}
function ShowChoreExpose() //unmodified
{
	if (_root.DoDickgirlChange(30)) return;
	if (_root.IsDickgirl()) temp = int(Math.random()*2) + 2;
	else temp = int(Math.random()*3) + 1;
	ExhibClip.gotoAndStop(temp);
	ExhibClip._visible = true;
}

function ShowChoreMakeUp() : Boolean { //unmodified
	var donearoused = false;
	if (Naked) BeautyClip.gotoAndStop(2);
	else if (Aroused && int(Math.random()*4) == 1) {
		donearoused = true;
		BeautyClip.gotoAndStop(3);
		_root.SlaveSpeak(_root.SlavePronoun + " need to properly coordinate my clothes. Do you think these panties go with this dress?");
	} else {
		BeautyClip.gotoAndStop(1);
	}
	BeautyClip._visible = true;
	return donearoused;
}

function ShowChoreWalk() { //unmodified
	if (_root.DressWorn == 3) _root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0);
	if (_root.DoDickgirlChange(33) || _root.DonePonygirl == 1) return;
	if (_root.DickgirlXF > 0) {
		EndingDickgirl._visible = true;
		_root.AddText(SlaveName + " takes a walk but starts getting more and more aroused. Her cock grows erect and she washes herself in a public fountain to try to calm down. It does not help much and she returns home, cock very erect.");
		return;
	} else if (Naked) temp = 4;
	else {
		temp = int(Math.random()*3) + 1;
		if (temp == 3) _root.Backgrounds.ShowTownCenter();
	}
	PromenadeClip.gotoAndStop(temp);
	PromenadeClip._visible = true;
}

function ShowSchoolSciences() { //unmodified
	SciencesClip._visible = true;
}

function ShowSchoolTheology() { //unmodified
	TheologyClip._visible = true;
}

function ShowSchoolRefinement() {//unmodified
	RefinementSchoolClip.gotoAndStop(int(Math.random()*2) + 1);
	RefinementSchoolClip._visible = true;
}

function ShowSchoolDance(donearoused:Boolean) { //unmodified
	temp = int(Math.random()*2) + 1;
	if (Naked) temp = 3;
	DanceClip.gotoAndStop(temp);
	if (temp == 2) {
		_root.ShowOverlay(0xEFFFFF);
		_root.HideBackgrounds();
	}
	DanceClip._visible = true;
}

function ShowSchoolXXX(doDG:Boolean) : Boolean { //unmodified
	if (Lesbian) temp = 2;
	else if (doDG) {
		temp = 3;
		_root.PersonSpeak("Teacher", "You need to have some experience with a hermaphrodite, a woman with both genitals. She has a huge libido and you will fuck many times. Please enjoy yourself.");
	} else if (_root.IsDickgirl() || Naked) temp = 1;
	else temp = int(Math.random()*2) + 1;
	XXXClip.gotoAndStop(temp);
	XXXClip._visible = true;
	return temp == 3;
}

function ShowJobRestaurant() : Number { //unmodified
	if (_root.UseGeneric) return 1;
	temp = int(Math.random()*2) + 1;
	RestaurantClip.gotoAndStop(temp);
	RestaurantClip._visible = true;
	return 1;
}

function ShowJobBar() : Number { //unmodified
	if (Naked) {
		if (_root.IsDickgirl()) BarClip.gotoAndStop(3);
		else BarClip.gotoAndStop(2);
	} else BarClip.gotoAndStop(1);
	BarClip._visible = true;
	return 1;
}

function ShowJobAcolyte() : Number { //unmodified
	AcolyteClip._visible = true;
	return 1;
}

function ShowJobSleazyBar(strip:Boolean) : Number { //unmodified
	if (strip) temp = _root.DickgirlXF > 0 ? 8 : 6;
	else if (Naked) temp = _root.DickgirlXF > 0 ? 8 : 5;
	else if (_root.BunnySuitOK) temp = 1;
	else if (_root.DickgirlXF > 0) temp = 7;
	else temp = int(Math.random()*3) + 2;
	SleazyBarClip.gotoAndStop(temp);
	if (temp == 1) {
		_root.HideBackgrounds();
		_root.ShowOverlay(0xC0C0F0);
	}
	SleazyBarClip._visible = true;
	_root.PersonSpeakStart("Sleazy Bar Owner", "The customers like you, I hope to see you again.", true);
	return 1;
}

function ShowJobBrothel() : Number { //unmodified
	_root.HideBackgrounds();
	if (int(Math.random()*3) == 1 && !_root.IsDickgirl()) BrothelClip.play();
	else {
		temp = int(Math.random()*2) + 40;
		if (Naked) temp = 40;
		BrothelClip.gotoAndStop(int(Math.random()*2) + 40);
		if (temp == 41) _root.Backgrounds.ShowBedRoom();
	}
	BrothelClip._visible = true;
	return 1;
}

function ShowRefusedAction() //unmodified
{
	RefusedAction._visible = true;
}

function ShowBreak(sleeping:Boolean) { //unmodified
	if (_root.IsDickgirl()) {
		if (sleeping) BreakClip.gotoAndStop(1);
		else BreakClip.gotoAndStop((int(Math.random()*2)*2) + 1);
	} else if (Naked || sleeping) BreakClip.gotoAndStop(2);
	else BreakClip.gotoAndStop(int(Math.random()*2) + 1);
	BreakClip._visible = true;
}

// Sex

function DoSexActions(type:Number) //unmodified
{
	if (type == 2 && Lesbian) {
		/*_root.ServantSpeak("You will touch her and make her more sensitive.");
		_root.AddText("\r\rYou are annoyed at the way " + _root.ServantName + " and " + SlaveName + " argue. You think you might order " + _root.ServantName + " to touch " + SlaveName + ".");
		_root.AskHerQuestions(506, 503, 504, 0, "You will do it yourself", _root.ServantName, "Forget it", "", "Who will touch " + SlaveName + "?");
		return true;*/
	} else if (type == 3 && Lesbian) {
		/*_root.ServantSpeak("You will do cunnilingus to her.");
		_root.AddText("\r\rYou are annoyed at the way " + _root.ServantName + " and " + SlaveName + " argue. You think you might order " + _root.ServantName + " to do it instead.");
		_root.AskHerQuestions(506, 502, 504, 0, "You will do it youself", "Order " + _root.ServantName + " to do it", "Forget it", "", "Who will lick " + SlaveName);
		return true;*/
	} else if (type == 11) {
		/*if (_root.Talent == 9 || _root.Gender != 1 || Lesbian) return false;
		_root.ServantSpeak("She will make love with another female slave, not with <i>me!</i>\r\rDo you want her to do this?");
		_root.NoEvent._visible = true;
		_root.YesEvent._visible = true;
		return true;*/
	} else if (type == 12) {
		/*if (_root.RopesOK == 0 && _root.SilkenRopesOK == 0) return false;
    	_root.ServantSpeak("We can tie her and control her.\r\rDo you want to do this?");
		if (_root.TestObedience(_root.DifficultyBondage)) _root.AddText("\r\r" + SlaveName + " looks annoyed but excited.\r\r");
		else _root.AddText("\r\r" + SlaveName + " looks annoyed.\r\r");
		_root.NoEvent._visible = true;
		_root.YesEvent._visible = true;
		return true;*/
	} else if (type == 19) {
		/*_root.ServantSpeak("You will have sex with " + SlaveName + " and another female slave, <b>not</b> me.\r\rDo you want to do this?");
		_root.NoEvent._visible = true;
		_root.YesEvent._visible = true;
		return true;*/
	}
	return false;
}

function ShowSexActNothing() { //unmodified
	if (_root.IsDickgirl()) temp = 1;
	else if (Naked) temp = 2;
	else temp = int(Math.random()*2) + 1;
	NeedingClip.gotoAndStop(temp);
	if (temp == 2) _root.ShowOverlay(0);
	NeedingClip._visible = true;
}

function ShowSexAct69() { //unmodified
	if (_root.DoDickgirlChange(100)) return;
	if (Lesbian) SixtyNineClip.gotoAndStop(2);
	else if (_root.UseGeneric) return;
	else SixtyNineClip.gotoAndStop(1);
	SixtyNineClip._visible = true;
}

function ShowSexActAnal() { //unmodified
	if (_root.DoDickgirlChange(40)) return;
	if (_root.IsDickgirl()) AnalClip.gotoAndStop(4);
	else if (Lesbian) {
		if (DefaultLesbian(50)) return;
		AnalClip.gotoAndStop(1);
	} else AnalClip.gotoAndStop(int(Math.random()*3) + 1);
	_root.HideBackgrounds();
	AnalClip._visible = true;
}

function ShowSexActBlowjob() { //unmodified
	if (Lesbian) {
		if (DefaultLesbian(33)) return;
		temp = 5;
	} else temp = int(Math.random()*4) + 1;
	_root.HideBackgrounds();
	BlowjobClip.gotoAndStop(temp);
	BlowjobClip._visible = true;
}

function ShowSexActBondage() { //unmodified
	if (_root.DoDickgirlChange(33) || _root.UseGeneric) return;
	if (_root.TotalBondage<5) {
		if (_root.IsDickgirl()) temp = 11;
		else temp = _root.TotalBondage + 1;
	} else {
		if (Lesbian) temp = int(Math.random()*5) + 1;
		else if (_root.IsDickgirl()) {
			temp = int(Math.random()*3) + 7;
			if (temp == 9) temp = 11;
		}
		else temp = int(Math.random()*10) + 1;
	}
	BondageClip.gotoAndStop(temp);
	BondageClip._visible = true;
	switch (temp) {
		case 1:
		case 11:
			_root.SetText("You tie her up and leave her to get accustomed to the feeling.");
			break;
		case 2:
			_root.SetText("You tie her up and leave her for a time on a private beach, to experience the exposure and sensation.");
			_root.Backgrounds.ShowBeach();
			break;
		case 3:
			_root.SetText("You tie her up and spank her pussy to get her aroused. You stop when you realise she has had an orgasm despite the pain.");
			break;
		case 4:
			_root.SetText("You tie her up and place a plug in her ass for a time to help her get accustomed to such things.");
			break;
		case 5:
			_root.SetText("You tie her up and get a reluctant " + _root.ServantName + " to arouse her with a dildo she has. " + SlaveName + " is unhappy with the fact you have " + _root.ServantName + " do it but is unable to control herself and is brought to orgasm after orgasm.");
			break;
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
			if (_root.Gender != 2) _root.SetText("You tie her up and she begs you to fuck her. You decide it is a good experience and do so while she is tied. She seems to love and hate it, hating the control but she has very intense orgasms, stronger than normal.");
			else _root.SetText("You tie her up and she begs to be fucked. You decide it is a good experience and have a male slave do so while she is tied. She seems to love and hate it, hating the control but she has very intense orgasms, stronger than normal.");
			break;
	}
	if (_root.TotalBondage<5) {
		_root.AddText("\r\rShe struggles and yells her annoyance, mainly at " + _root.ServantName + ". When you release her she seems very aroused.");
	} else if (_root.TotalBondage<10) {
		_root.AddText("\r\rShe complains, mainly about " + _root.ServantName + ", but seems to enjoy the experience.");
	} else if (_root.TotalBondage<20) {
		_root.AddText("\r\rShe submits willingly to you and reluctantly to " + _root.ServantName + ". She seems eager for the experience and sorry when you release her.");
	} else {
		_root.AddText("\r\rShe delights in submitting to you and to " + _root.ServantName + " to the extent she tells you she never wants to be freed and is willing to do <i>anything</i> you ask.");
	}
	_root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

}

function ShowSexActCumBath() : Boolean { //unmodified
	GangBangClip.gotoAndStop(3);
	GangBangClip._visible = true;
	return true;
}

function ShowSexActDildo() { //unmodified
	_root.HideBackgrounds();
	if (_root.DoDickgirlChange(33)) return;
	if (_root.DickgirlXF > 0) {
		if (int(Math.random()*3) > 1) {
			ClipDickgirl.gotoAndStop(1);
			ClipDickgirl._visible = true;
			return;
		} else DildoClip.gotoAndStop(3);
	} else DildoClip.gotoAndStop(int(Math.random()*2) + 1);
	DildoClip._visible = true;
}

function ShowSexActFuck() { //unmodified
	if (_root.DoDickgirlChange(30)) return;
	if (Lesbian) {
		if (_root.DefaultGeneric(50)) return;
		FuckClipa._visible = true;
		FuckClipa.gotoAndStop(1);
	} else if (_root.IsDickgirl() && int(Math.random()*3) == 1) {
		FuckClipa._visible = true;
		FuckClipa.gotoAndStop(4);
	} else if (_root.IsDickgirl() || int(Math.random()*3) == 1) {
		_root.HideBackgrounds();
		FuckClipb._visible = true;
		FuckClipb.play();
	} else {
		temp = int(Math.random()*3) + 1;
		if (Naked) temp = 3;
		if (temp == 2) _root.HideBackgrounds();
		FuckClipa._visible = true;
		FuckClipa.gotoAndStop(temp);
	}
}

function ShowSexActGangBang() { //unmodified
	if (Lesbian) _root.UseGeneric = true;
	if (_root.UseGeneric) return;

	if (_root.IsDickgirl()) {
		if (_root.DefaultGeneric(33)) return;
		GangBangClip.gotoAndStop(5);
	}
	else if (Naked) GangBangClip.gotoAndStop(int(Math.random()*2) + 3);
	else GangBangClip.gotoAndStop(int(Math.random()*4) + 1);
	GangBangClip._visible = true;
}

function ShowSexActGroup() { //unmodified
	if (Lesbian) {
		if (_root.UseGeneric) return;
		GroupClip.gotoAndStop(3);
		_root.HideBackgrounds();
	} else if (_root.DoDickgirlChange(100)) return;
	else GroupClip.gotoAndStop(int(Math.random()*2) + 1);
	GroupClip._visible = true;
}

function ShowSexActKiss() : Boolean { //unmodified
	if (((_root.SexAction == 23.1 || _root.SexAction == 23) && _root.Gender == 1) || (_root.SexAction == 23.2 && _root.Gender == 2)) {
		// male
		KissClip._visible = true;
	} else {
		// female
		EndingLesbianSlave._visible = true;
	}
	return true;
}

function ShowSexActLendHer() : String { //unmodified
	if (Lesbian) temp = 3;
	else if (_root.IsDickgirl()) temp = 2;
	else temp = int(Math.random()*2) + 1;
	LendClip.gotoAndStop(temp);
	if (temp == 2) _root.HideBackgrounds();
	LendClip._visible = true;
	return "";
}

function ShowSexActLesbian() { //unmodified
	if (_root.DoDickgirlChange(50)) return;
	if (_root.IsDickgirl()) {
		if (int(Math.random()*3) == 0) {
			ClipDickgirl.gotoAndStop(3);
			ClipDickgirl._visible = true;
			return;
		}
		temp = 2;
	} else {
		if (Lesbian) {
			if (_root.UseGeneric) return;
			temp = int(Math.random()*3) + 2;
		} else if (Naked) temp = int(Math.random()*2) + 2;
		else temp = int(Math.random()*3) + 1;
	}
	LesbianClip.gotoAndStop(temp);
	if (temp == 2) _root.ShowOverlay(0);
	LesbianClip._visible = true;
}

function ShowSexActLick() { //unmodified
	if (_root.DoDickgirlChange(40)) return;

	if (_root.SexAction == 3.3) {
		_root.AppendActText = false;
		temp = 4;
		_root.SetText("You order " + _root.ServantName + " instead to lick her. " + _root.ServantName + " looks annoyed, but skillfully licks her pussy.\r\r");
	} else {
		if (_root.IsDickgirl()) temp = 6;
		else if (_root.Gender == 1 || _root.SexAction == 3.4) temp = int(Math.random()*3) + 1;
		else temp = int(Math.random()*3) + 3;
	}
	LickClip.gotoAndStop(temp);
	LickClip._visible = true;
}

function ShowSexActMaster() { //unmodified
	_root.HideBackgrounds();
	if (_root.IsDickgirl()) {
		if (Naked) {
			NakedClip.gotoAndStop(int(Math.random()*2) + 4);
			NakedClip._visible = true;
			return;
		} else temp = 1;
	} else if (Naked) temp = 3;
	else temp = int(Math.random()*2) + 1;
	if (temp == 3) _root.Backgrounds.ShowOnsen();
	MasterClip.gotoAndStop(temp);
	MasterClip._visible = true;
}

function ShowSexActMasturbate() { //unmodified
	if (_root.DoDickgirlChange(25)) return;
	
	if (_root.IsDickgirl()) {
		if (int(Math.random()*3) < 2) temp = 4;
		else {
			ClipDickgirl.gotoAndStop(int(Math.random()*2) + 1);
			ClipDickgirl._visible = true;
			return;
		}
	} else temp = int(Math.random()*3) + 1;
	if (Naked) temp = 3; 
	MasturbateClip.gotoAndStop(temp);
	MasturbateClip._visible = true;
}

function ShowSexActNaked() { } //unmodified
 
function ShowSexActPlug() //unmodified
{
	if (_root.DoDickgirlChange(100)) return;
	PlugClip._visible = true;
}

function ShowSexActPonygirl() //unmodified
{
	_root.ShowOverlay(0xF1FADB);
	PonygirlClip._visible = true;
}

function SpankComment() : Boolean //unmodified
{
	_root.ServantSpeak("She deserves a good spanking and really seems to be enjoying it, she is very wet.", true);
	return true;
}

function ShowSexActSpank(whip:Boolean) //unmodified
{
	if (whip) _root.UseGeneric = true;
	if (_root.UseGeneric) return;
	if (Naked || _root.Gender != 1) SpankClip.gotoAndStop(int(Math.random()*2) + 2);
	else SpankClip.gotoAndStop(int(Math.random()*3) + 1);
	SpankClip._visible = true;
}

function ShowSexActThreesome() //unmodified
{
	if (_root.Talent == 9 && _root.IsDickgirl()) {
		_root.UseGeneric = true;
		return;
	} else if (_root.IsDickgirl()) ThreesomeClip.gotoAndStop(int(Math.random()*3) + 3);
	else if (Lesbian) ThreesomeClip.gotoAndStop(6);
	else ThreesomeClip.gotoAndStop(int(Math.random()*5) + 1);
	ThreesomeClip._visible = true;
}

function ShowSexActTitFuck() //unmodified
{
	_root.HideBackgrounds();
	if (Lesbian) {
		_root.UseGeneric = false;
		temp = int(Math.random()*2) + 18;
		/*if (temp == 19) {
			_root.SetText("You ask " + SlaveName + " to instead masturbate " + _root.ServantName + ". They both look at you with surprise, " + _root.ServantName + " especially.\r\rYou insist and " + SlaveName + " moves in but " + _root.ServantName + " resists and they start wrestling and writhing. " + SlaveName + " gets her in a hold and rubs her pussy and breasts.\r\r");
			if (_root.VarConstitutionRounded<40) {
				_root.AddText("She is awkward and fails to overpower " + _root.ServantName + ". You scold " + _root.ServantName + ".");
			} else if (_root.VarConstitutionRounded<55) {
				_root.AddText("She seems to enjoy the struggle and is able to pin " + _root.ServantName + ", touching and caressing her and easily brings her to a reluctant orgasm.");
			} else if (_root.VarConstitutionRounded<70) {
				_root.AddText("She enjoys wrestling and easily overpowers " + _root.ServantName + " and works expertly to bring her carefuly nearer and nearer to orgasm, keeping her there until she begs to cum. " + SlaveName + " brings her to a very strong orgasm.");
			} else {
				_root.AddText("She dominates " + _root.ServantName + " and skillfully brings her to orgasm after orgasm, despite her protests.");
			}
		}*/
		TitsFuckClip.gotoAndStop(temp);
	} else TitsFuckClip.gotoAndPlay(1);
	TitsFuckClip._visible = true;
}

function ShowSexActTouch()//unmodified
{
	if (_root.DoDickgirlChange(100)) return;

	if (_root.SexAction == 2.4) {
		temp = 4;
		_root.AppendActText = false;
		_root.AppendActText = false;
		/*_root.SetText("You order " + _root.ServantName + " to caress her to help her accept more women. " + _root.ServantName + " starts to protest but reconsiders and agrees\r\r" + SlaveName);
		if (_root.VarSensibilityRounded<15) {
			_root.AddText(" doesn't like this much yet and especially as it is " + _root.ServantName + " doing it!");
		} else if (_root.VarSensibilityRounded<50) {
			_root.AddText(" doesn't mind being caressed and seems to tolerate " + _root.ServantName + ".");
		} else if (_root.VarSensibilityRounded<80) {
			_root.AddText(" seems to love being caressed. She sometimes looks passionately at you and at " + _root.ServantName + ".");
		} else {
			_root.AddText(" almost came just from " + _root.ServantName + "'s touches and moans her name often.");
		}*/
	} else if (_root.SexAction == 2 || _root.SexAction == 2.3) {
		if (Naked) temp = int(Math.random()*2) + 1;
		else temp = int(Math.random()*3) + 1;
	} else {
		_root.UseGeneric = true;
		return;
	}
	TouchClip.gotoAndStop(temp);
	if (temp == 2) _root.ShowOverlay(0x6F576F);
	TouchClip._visible = true;
}

function ShowTentacleSex(place:Number) : Boolean //unmodified
{
	if (_root.DoDickgirlChange(30)) return false;
	_root.UseGeneric = false;
	if (_root.IsDickgirl()) ClipTentacle.gotoAndStop(6);
	else if (Naked) ClipTentacle.gotoAndStop(int(Math.random()*3) + 3);
	else if (place == 4) ClipTentacle.gotoAndStop(int(Math.random()*4) + 2);
	else if (place == -1) ClipTentacle.gotoAndStop(int(Math.random()*5) + 1);
	else ClipTentacle.gotoAndStop(int(Math.random()*4) + 1);
	ClipTentacle._visible = true;
	return false;
}

// Endings

function ShowEndingCourtesan() //unmodified
{
	_root.Backgrounds.ShowBeach();
	EndingCourtesan._visible = true;
}

function ShowEndingCowgirl()  //unmodified
{
	ShowMilking();
}

function ShowEndingBoughtBack() //unmodified
{
	EndingBoughtBack._visible = true;
}

function ShowEndingDickgirl() //unmodified
{
	EndingDickgirl._visible = true;
}

function ShowEndingDrugAddict() //unmodified
{
	_root.Backgrounds.ShowBedRoom();
	EndingDrugAddict._visible = true;
}

function ShowEndingLesbianSlave() //unmodified
{
	EndingLesbianSlave._visible = true;
}

function ShowEndingMaid() //unmodified
{
	_root.Backgrounds.ShowBar();
	EndingMaid._visible = true;
}

function ShowEndingMarriage() //unmodified
{
	_root.ShowOverlay(0xF9F0F2);
	EndingMarriage._visible = true;
}

function ShowEndingNormal() //unmodified
{
	_root.Backgrounds.ShowBedRoom();
	EndingNormal._visible = true;
}

function ShowEndingNormalMinus() //unmodified
{
	_root.Backgrounds.ShowBedRoom();
	EndingNormalMinus._visible = true;
}

function ShowEndingNormalPlus() //unmodified
{
	_root.Backgrounds.ShowBedRoom();
	EndingNormalPlus._visible = true;
}

function ShowEndingProstitute() //unmodified
{
	_root.ShowOverlay(0);
	EndingProstitute._visible = true;
}

function ShowEndingRebel() //unmodified
{
	EndingRebel._visible = true;
}

function ShowEndingRich() //unmodified
{
	EndingRich._visible = true;
}

function ShowEndingSexAddict() //unmodified
{
	_root.Backgrounds.ShowSchool();
	EndingSexAddict._visible = true;
}

function ShowEndingSexManiac() //unmodified
{
	_root.Backgrounds.ShowSchool();
	EndingSexManiac._visible = true;
}

function ShowEndingSM() //unmodified
{
	_root.ShowOverlay(0x36214b);
	EndingSM._visible = true;
}

function ShowEndingTentacleSlave() //unmodified
{
	ShowTentacleSex();
}

function ShowTentaclePregnancyReveal() : Boolean //unmodified
{			
	if (_root.DickgirlXF > 0) EventTentaclePregnancy.gotoAndStop(2);
	else EventTentaclePregnancy.gotoAndStop(1);
	EventTentaclePregnancy._visible = true;
	return true;
}

function NumCustomEndings() : Number //unmodified
{
	return 0;
}

// Images

function HideImages() { 
	ClipPunish._visible = false;
	ClipNobleLove._visible = false;
	ClipContestsBeauty._visible = false;
	ClipContestsCourt._visible = false;
	ClipContestsXXX._visible = false;
	ClipContestsHousework._visible = false;
	EventShampooTrouble._visible = false;
	ClipSlaveRetrieved._visible = false;
	EventMilk._visible = false;
	EventNakedApron._visible = false;
	EventMorningMouthfull._visible = false;
	RefusedAction._visible = false;
	Introduction._visible = false;
	ClipRaped._visible = false;
	ClipDating._visible = false;
	ClipLoveAccepted._visible = false;
	ClipLoveRefused._visible = false;
	ClipLoveConfession._visible = false;
	ClipPropositionAccepted._visible = false;
	ClipPropositionRefused._visible = false;
	ClipTired._visible = false;
	EventTentaclePregnancy._visible = false;
	EndingDickgirl._visible = false;
	EndingLesbianSlave._visible = false;
}

function HideSlaveActions() { 
	BondageClip._visible = false;
    AnalClip._visible = false;
	FuckClipa.gotoAndStop(1);
    FuckClipa._visible = false;
	FuckClipb.gotoAndStop(1);
    FuckClipb._visible = false;
	TitsFuckClip.gotoAndStop(1);
    TitsFuckClip._visible = false;
    MasturbateClip._visible = false;
    DildoClip._visible = false;
	KissClip._visible = false;
    LickClip._visible = false;
    MasterClip._visible = false;
    BlowjobClip._visible = false;
    PlugClip._visible = false;
    GangBangClip._visible = false;
    LendClip._visible = false;
    NeedingClip._visible = false;
    TouchClip._visible = false;
    LesbianClip._visible = false;
	SpankClip._visible = false;
    AcolyteClip._visible = false;
    BarClip._visible = false;
    SleazyBarClip._visible = false;
    BeautyClip._visible = false;
    BrothelClip._visible = false;
    RefinementSchoolClip._visible = false;
	CookingClip._visible = false;
    DanceClip._visible = false;
    DiscussClip._visible = false;
    ExhibClip._visible = false;
    CleaningClip._visible = false;
    PromenadeClip._visible = false;
    BreakClip._visible = false;
    RestaurantClip._visible = false;
    SciencesClip._visible = false;
    TheologyClip._visible = false;
    XXXClip._visible = false;
	ClipTentacle._visible = false;
	ClipDickgirl._visible = false;
	ThreesomeClip._visible = false;
	SixtyNineClip._visible = false;
	GroupClip._visible = false;
	PonygirlClip._visible = false;
}

function HideRobes() {
	NakedClip._visible = false;
	RobePlainClip._visible = false;
	Robe1Clip._visible = false;
	Robe2Clip._visible = false;
	Robe3Clip._visible = false;
	Robe4Clip._visible = false;
	Robe5Clip._visible = false;
	Robe6Clip._visible = false;
}

function HideEndings() {
	EndingDrugAddict._visible = false;
	EndingNormalPlus._visible = false;
	EndingSexManiac._visible = false;
	EndingMarriage._visible = false;
	EndingNormal._visible = false;
	EndingSexAddict._visible = false;
	EndingProstitute._visible = false;
	EndingBoughtBack._visible = false;
	EndingRebel._visible = false;
	EndingRich._visible = false;
	EndingSM._visible = false;
	EndingMaid._visible = false;
	EndingNormalMinus._visible = false;
	EndingLesbianSlave._visible = false;
	EndingDickgirl._visible = false;
	EndingCourtesan._visible = false;
}

// Startup

function Initialise() { //unmodified
	_root.SlaveName = "Akane";
	
	_root.SetDressDetails(1, "Long Dress");
	_root.SetDressDetails(2, "Short Dress");
	_root.SetDressDetails(3, "Country Dress", "Refinement + 10\rSensibility + 5\rEnjoys walks more.");
	_root.SetDressDetails(4, "Kimono", "Refinement + 10\rCharisma + 10\rSensibility + 10");
	_root.SetDressDetails(5, "Gym Clothes", "Refinement + 10\rCharisma + 10\rConstitution + 15");
	_root.SetDressDetails(6, "Mini Skirt", "Charisma + 35, Obedience + 10\rLibido + 15, Nymphomania + 15\rSensibility + 15, Joy + 15\rShe is carefree and energetic.");
	_root.SetDressCourtly(4);
	_root.SetDressEasy(5);
	_root.SetDressEasy(6);
	
	_root.NobleLoveType = 8;
	_root.Milkable = true;
	_root.SlaveLikeServant = false;
	_root.SlaveAttitude = 2;
}

function StartGame() //debugging settings 
{
	_root.TrainingTime = 60;
	
    _root.VarCharisma = 10;  //unset akane defaults
    _root.VarSensibility = 10;
    _root.VarRefinement = 10;
    _root.VarIntelligence = 5;
    _root.VarMorality = 0;
    _root.VarConstitution = 10;
    _root.VarCooking = 7;
    _root.VarCleaning = 7;
    _root.VarConversation = 10;
    _root.VarBlowJob = 15;
    _root.VarFuck = 20;
    _root.VarTemperament = 20;
    _root.VarNymphomania = 15;
    _root.VarObedience = 100;
    _root.VarLibido = 0;
    _root.VarReputation = 0;
    _root.VarFatigue = 0;
	_root.MaxObedience = 90;
    _root.VarJoy = 0;
    _root.VarGold = _root.VarGold + 50000;  // a little bonus spending money
    _root.VarLovePoints = 0;//all difficulty set to zero
    _root.DifficultyXXX = 0;
	_root.DifficultyXXXContest = 0;
    _root.DifficultyExhib = 0;
    _root.DifficultySleazyBar = 0;
    _root.DifficultyBrothel = 0;
    _root.DifficultyTouch = 0;
    _root.DifficultyLick = 0;
    _root.DifficultyFuck = 0;
    _root.DifficultyBlowjob = 0;
    _root.DifficultyTitsFuck = 0;
    _root.DifficultyAnal = 0;
    _root.DifficultyMasturbate = 0;
    _root.DifficultyDildo = 0;
    _root.DifficultyPlug = 0;
    _root.DifficultyLesbian = 0;
    _root.DifficultyBondage = 0;
    _root.DifficultyNaked = 0;
    _root.DifficultyMaster = 0;
    _root.DifficultyGangBang = 0;
    _root.DifficultyLendHer = 0;
	_root.DifficultyPonygirl = 0;
	_root.DifficultySpank = 0;
	_root.DifficultyThreesome = 0;
	
	_root.SlaveDebugging = true;
	
	_root.CustomFlag = 0; //setting all custom flags to 0
	_root.CustomFlag1 = 0;
	_root.CustomFlag2 = 0;
	_root.CustomFlag3 = 0;
	_root.CustomFlag4 = 0;
}

Robe6Clip.gotoAndStop(1);
ClipDickgirl.gotoAndStop(1);
BreakClip.gotoAndStop(1);
BeautyClip.gotoAndStop(1);
CookingClip.gotoAndStop(1);
DanceClip.gotoAndStop(1);
SciencesClip.gotoAndStop(1);
DiscussClip.gotoAndStop(1);
ExhibClip.gotoAndStop(1);
PromenadeClip.gotoAndStop(1);
RefinementSchoolClip.gotoAndStop(1);
BarClip.gotoAndStop(1);
TheologyClip.gotoAndStop(1)
BrothelClip.gotoAndStop(1);
SleazyBarClip.gotoAndStop(1);
RestaurantClip.gotoAndStop(1);
XXXClip.gotoAndStop(1);
SixtyNineClip.gotoAndStop(1);
AnalClip.gotoAndStop(1);
BlowjobClip.gotoAndStop(1);
BondageClip.gotoAndStop(1);
DildoClip.gotoAndStop(1);
GangBangClip.gotoAndStop(1);
GroupClip.gotoAndStop(1);
FuckClipa.gotoAndStop(1);
FuckClipb.gotoAndStop(1);
LendClip.gotoAndStop(1);
LesbianClip.gotoAndStop(1);
LickClip.gotoAndStop(1);
MasterClip.gotoAndStop(1);
MasturbateClip.gotoAndStop(1);
NakedClip.gotoAndStop(1);
PlugClip.gotoAndStop(1);
NeedingClip.gotoAndStop(1);
SpankClip.gotoAndStop(1);
TitsFuckClip.gotoAndStop(1);
ThreesomeClip.gotoAndStop(1);
TouchClip.gotoAndStop(1);
ClipTentacle.gotoAndStop(1);
ClipTired.gotoAndStop(1);
EventShampooTrouble.gotoAndStop(1);
ClipNobleLove.gotoAndStop(1);
EventMilk.gotoAndStop(1);
ClipContestsXXX.gotoAndStop(1);
EventTentaclePregnancy.gotoAndStop(1);
ClipPunish.gotoAndStop(1);