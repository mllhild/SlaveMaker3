// CustomFlag - rebellion
// CustomFlag1- own cum addiction
//
// BitFlags
//	1 = offer hammer in shop
//  2 = Shampoo got Priapus Draft
//  3 = breast expansion
//	4 = 'treatment' under way

import Scripts.Classes.*;

class Akane extends SlaveModule
{	

    var chore1:Number;
    var chore2:Number;

	// Constructors
	public static function main(swfRoot:MovieClip, sdo:Object, cg:Object) : SlaveModule
	{
		// entry point
		return new Akane(swfRoot, sdo, cg);
	}
	
	public function Akane(swfRoot:MovieClip, sdo:Object, cg:Object)
	{
		super(swfRoot, sdo, cg);
		
	}
	
// General

/*
public function ShowStatHint(stat:Number) : Boolean
{
	if (stat == 18) {
		SetText("<b>Anger:</b> How angry and aggressive she is feeling.\r\rShe is <b>");
		if (_root.VarSpecialRounded < 25) AddText("calm");
		else if (_root.VarSpecialRounded < 50) AddText("angry");
		else if (_root.VarSpecialRounded < 75) AddText("furious");
		else AddText("in a violent rage");
		AddText("</b>\nwhich is " + _root.VarSpecialRounded + " in a range of 0 to 100.");
		return true;
	}
	return false;
}
*/

public function UpdateDateAndItems(NumDays:Number)
{ 
	_root.VarTemperament = _root.VarTemperament + (NumDays / 2);
	_root.VarObedience = _root.VarObedience - (NumDays / 2);
}

public function ApplyDifficulty(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Fatigue:Number, Joy:Number, Special:Number, SexualEnergy:Number, Sexuality:Number) 
{
	_root.CookingFactor = _root.CookingFactor / 2;
}

public function DrinkPotion(potion:Number, price:Number, pname:String, say:String) : Boolean
{
	if (potion == 0) {
		// Dickgirl
		switch(Math.floor(Math.random()*3)) {
			case 0:
				_root.CustomFlag1++;
				SetText(SlaveName + " drops to the ground and irresistibly masturbates over and over, cumming all over even into her own mouth.");
				mcBase.ClipDickgirl.gotoAndStop(1);
				break;
			case 1:
				_root.CustomFlag1++;
				SetText(SlaveName + " compulsively sucks on her own huge cock, cumming over and over again, swallowing all of her cum.");
				mcBase.ClipDickgirl.gotoAndStop(2);
				break;
			case 2:
				Backgrounds.ShowSchool();
				if (_root.IsAssistant("Shampoo")) {
					mcBase.ClipDickgirl.gotoAndStop(3);
					SetText(SlaveName + " feels an incredible desire to fuck. #assistant looks a little annoyed and takes her into a store-room. #slave inexpertly starts to fuck, but #assistant instructs her until they both reach intense orgasms.");
				} else {
					SetText(SlaveName + " feels an incredible desire to fuck. Astrid smile and suggest she steps into store-room.\r\r#slave opens the door and sees a woman waiting there who silently starts removing her clothes. #slave inexpertly starts to fuck, and the woman silently instructs her until they both reach intense orgasms, #slave pulling out and cumming over the woman's stomach.");
					mcBase.ClipDickgirl.gotoAndStop(4);
				}
				break;
		}
		mcBase.ClipDickgirl._visible = true;
		Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 0, 0, 0, 4, 0, 0);
		AddText("\r\rAfter a time Astrid joins and they fuck each other.");
		return true;
	}
	return false;
}

public function VisitChatWithPerson(person:Number)
{
	if (person == 3) {
		SetText("#slave talks with Miss.N is a familiar way, they clearly know each other well. #slave is a bit embarrassed by Miss.N's work but she still asks for details.\r\rThis discussion makes #slave horny as Miss.N describes in detail some of her more interesting experiences. Miss.N encourages #slave to consider life as a prostitute, working by her side.");
		if (Naked) AddText("\r\rMiss.N comments how a lack of modesty is an advantage in her job, and how beautiful #slave's is, as it always was. #slave blushes but seems pleased.");
	}
}

public function ProstitutePartyOffer(days:Number)
{
	ShowPerson(3, 1, 2, 2);
	_root.ShowDress();
	if (days > 0) {
		SetText("Miss N speaks to you both, but looks admiringly at #slave,\r\r");
		PersonSpeak(3, "#slave you're as sexy as I remembered, and now good and shameless, parading your lovely naked body.\r\rI have been hired for a party in a few days to 'entertain'. I am sure #slave would love it too, #slaveheshe will 'meet' many people, even some advantageous to you and #slavehimher. Well, I do not have an invitation for you, " + _root.SlaveMakerName + ", so I will have to escort #slavehimher for the evening.\r\rIf Akane wants to go to the party please <b>lend her</b> to me at night in " + days + " days.", true);
	} else if (days == 0) {
		PersonSpeak(3, "Akane, you're a beautiful, sexy person and I would love to once again see your naked body. Why don't you return some day when you are naked for all to see.\r\rI will have wonderful thing to offer you...");
		AddText("\r\rThe prostitute slowly runs her hand over her pussy. #slave is somewhat confused by the offer, #slaveheshe knows Miss N is female!");
	}
}


// Assistant

public function ShowAsAssistant(type:Number) : Boolean
{
	if (type == 4) return false;
	switch(type) {
		case 1:
			ShowMovie(mcBase.EndingBoughtBack, 0, 2);
			break;
		case 2:
			ShowMovie(mcBase.ClipTentacle, 0, 2, 4);
			_root.AssistantBackground._visible = true;
			break;
		case 3:
			ShowMovie(mcBase.ClipRaped, 0, 1);
			break;
		case 5:
			mcBase.PromenadeClip.gotoAndStop(2);
			ShowMovie(mcBase.PromenadeClip, 0, 1);
			break;
		case 6:
			mcBase.ClipLoveRefused._visible = true;
			break;
	}
	return true;
}

public function ShowAsAssistantTentacleSex() : Boolean
{
	ShowTentacleSex();
	ShowMovie(mcBase.ClipTentacle, 1, 1);
	return true;
}

public function ShowAsAssistantAnal() : Boolean
{
	mcBase.AnalClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.AnalClip._visible = true;
	return true;
}

public function ShowAsAssistantSpanking() : Boolean
{
	mcBase.SpankClip.gotoAndStop(3);
	mcBase.SpankClip._visible = true;
	return true;
}

public function HideAsAssistant()
{
	mcBase.EndingBoughtBack._visible = false;
	mcBase.ClipLoveRefused._visible = false;
	mcBase.ClipRaped._visible = false;
	mcBase.PromenadeClip._visible = false;
	mcBase.ClipTentacle._visible = false;
	mcBase.PromenadeClip._visible = false;
	mcBase.AnalClip._visible = false;
	mcBase.SpankClip._visible = false;
}

public function InitialiseAsAssistant(first:Boolean) : MovieClip
{
	HideImages();
	HideSlaveActions();
	HideEndings();
	HideDresses();
	HidePeople();
	return mcBase.EndingBoughtBack;
}

public function EmployAsAssistant() {
	_root.DifficultyBondage -= 5;
	_root.DifficultyPonygirl -= 5;
}


// Contests

public function ShowContestBeauty(total:Number) :Number
{
	mcBase.ClipContestsBeauty.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.ClipContestsBeauty._visible = true;
	return total;
}

public function ShowContestCourt(total:Number) : Number
{
	mcBase.ClipContestsCourt.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.ClipContestsCourt._visible = true;
	return total;
}

public function ShowContestHousework(total:Number) : Number
{
	mcBase.ClipContestsHousework._visible = true;
	return total;
}

public function ShowContestPonygirl(total:Number) : Number
{
	ShowSexActPonygirl();
	return total;
}

public function ShowContestXXX(total:Number) : Number
{
	if (_root.IsDickgirl()) mcBase.ClipContestsXXX.gotoAndStop(3);
	else mcBase.ClipContestsXXX.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.ClipContestsXXX._visible = true;
	return total;
}

public function ShowContestDance(total) : Number
{
	mcBase.DanceClip.gotoAndStop(1);
	mcBase.DanceClip._visible = true;
	return total;
}

public function ShowContestAdvancedHousework(total:Number) : Number
{
	ShowMovie(mcBase.ClipContestsAdvancedHousework, 1, 1, 1);
	return total;
}


// Catgirl

public function StartCatgirlTraining(type:Number) : Boolean
{
	HideBackgrounds();
	ShowMovie(mcBase.CatgirlTraining, 1, 1, 1);
	return true;
}

public function FinishedCatgirlTraining() : Boolean
{
	HideBackgrounds();
	ShowMovie(mcBase.CatgirlTraining, 1, 3, 2);
	return true;
}


// Dickgirl

public function DickgirlPotionOffer()
{
	AddText(" looks unhappy\r\r");
	SlaveSpeak("No! not again, I am a girl, it does not matter how nice it felt.", true); 
	AddText("\r\rAs #slave turns to leave she notices #assistant whispering to Astrid and they both laugh.\r\r#slave is a little annoyed they did not share their joke.");
	_root.NumEvent = 0;
	_root.SetBitFlag2(2);
}

public function ShowDickgirlTransform() : Boolean
{
	return false;
}

public function ShowDickgirlPermanent() : Boolean
{
	mcBase.ClipDickgirl.gotoAndStop(2);
	mcBase.ClipDickgirl._visible = true;
	return true;
}

public function AfterDickgirlPotion(num:Number)
{
	if (_root.IsDickgirl()) return;
	AddText("\r\r#slave looks very tired but also seems worried.\r\r");
	SlaveSpeak("I am a girl, I do not want a become masculine, and not cute!\r\rIt did feel really, really gooood....", true);
	AddText("\r\r#assistant looks amused.");	
}


// Dress

public function RemoveDress()
{
	if (_root.DressWorn == 1) _root.PointsMod(0, 0, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 2) _root.PointsMod(-10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 3) _root.PointsMod(0, -5, -10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 4) _root.PointsMod(-10, -10, -10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 5) _root.PointsMod(-10, 0, -10, 0, 0, -15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 6) _root.PointsMod(-35, -15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -10, -15, 0, -15);
}

public function WearDress()
{
	if (_root.DressWorn == 1) _root.PointsMod(0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 2) _root.PointsMod(10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 3) _root.PointsMod(0, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 4) _root.PointsMod(10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 5) _root.PointsMod(10, 0, 10, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	else if (_root.DressWorn == 6) _root.PointsMod(35, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 15, 0, 15);
}

public function ShowNaked()
{
	Backgrounds.ShowHousing();
	if (_root.CheckBitFlag2(3) || _root.BiggerBoobs) {
		if (_root.IsDickgirl()) _root.ChoiceNaked(2, 9);
		else _root.ChoiceNaked(3, 6);
	} else {
		if (_root.IsDickgirl()) _root.ChoiceNaked(2, 4);
		else _root.ChoiceNaked(3, 1);
	}
	switch (_root.NakedChoice) {
		case 1:
		case 6:
		_root.PositionHalo(218, 16, 0, 163, 54);
		_root.PositionLeash(2, 256, 32, 0, 79.95, 98, true);
		_root.PositionGag(2, 228, 62, -10, 60, 30, true);
		_root.PositionNymphsTiara(225, 30, 0, 60, 60, false);
		_root.PositionTail(220, 210, 90, 120, 90, true);
		_root.PositionWings(230, 125, -5, 300, 200);
		_root.PositionCatEars(2, 220, 30, 0, 60, 50);
		break;
	case 3:
	case 4:
	case 8:
	case 9:
		_root.PositionHalo(248, 20, 25, 180, 60);
		_root.PositionLeash(2, 250, 60, 0, 90, 122.5, true);
		_root.PositionGag(4, 209, 76, -10, 80, 60, true);
		_root.PositionNymphsTiara(210, 20, 0, 90, 90, false);
		_root.PositionCatEarsOver(2, 220, 30, 20, 90, 50);
		_root.PositionWingRight(326, 168, 0, 217, 300);
		_root.PositionWingLeftOver(347, 168, 0, -217, 300);
		_root.PositionTail(330, 290, 0, 120, 90, true);
		break;
	case 2:
	case 5:
	case 7:
	case 10:
		_root.PositionHalo(220, 20, 0, 190, 65);
		_root.PositionNymphsTiara(221, 25, 0, 90, 90, true);
		_root.PositionCatEarsOver(2, 210, 33, -10, 90, 50);
		_root.PositionTail(290, 286, 0, 120, 90, true);
		_root.PositionLeash(2, 276, 64, 0, 105, 122.5, true);
		_root.PositionGag(4, 222, 81, -35, 85, 50, true);
		_root.PositionWings(235, 180, 5, 360, 300);
		_root.PositionCatEars(2, 220, 30, 0, 60, 50);
		break;
	}
	ShowMovie(mcBase.NakedClip, 1, 1, _root.NakedChoice);
}

public function ShowNakedSmall()
{
	ShowMovie(mcBase.NakedClip, 0, 1, _root.NakedChoice);
}

public function ShowDress()
{
	if (_root.DressWorn != 0) Backgrounds.ShowHousing();
	if (_root.DressWorn == 0) {
		Backgrounds.ShowGrass();
		_root.PositionHalo(205, 44, -20, 200, 120);
		_root.PositionLeash(1, 280, 66, 0, 70, 140, true);
		_root.PositionGag(4, 252, 111, -20, -80, 30, true);
		_root.PositionNymphsTiara(220, 66, -50, 100, 100, true);
		_root.PositionTail(130, 180, -180, 120, 90, true);
		_root.PositionCatEars(2, 220, 55, -30, 130, 100);
		_root.PositionWingLeftOver(137, 155, 0, 150, 200);
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.RobePlainClip, 1, 1, _root.DressFrame);
	} else if (_root.DressWorn == 1) {
		_root.PositionHalo(230, 20, 0, 163, 54);
		_root.PositionLeash(2, 270, 36, 0, 70, 107, true);
		_root.PositionGag(4, 235, 57, 0, -50, 50, true);
		_root.PositionNymphsTiara(240, 22, 0, -60, 60, true);
		_root.PositionTail(180, 240, 90, 120, 90, true);
		_root.PositionCatEarsOver(1, 229, 25, -20, 60, 30);
		_root.PositionWings(243, 130, 0, 300, 200);
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe1Clip, 1, 1, _root.DressFrame);
	} else if (_root.DressWorn == 2) {
		_root.PositionHalo(225, 20, 0, 163, 54);
		_root.PositionLeash(2, 270, 38, 0, 110, 130, true);
		_root.PositionGag(2, 230, 78, 0, 80, 30, true);
		_root.PositionNymphsTiara(230, 30, -10, 80, 60, true);
		_root.PositionCatEarsOver(2, 225, 32, 0, 70, 50);
		_root.PositionTail(280, 230, 0, 120, 90, true);
		_root.PositionWings(223, 140, 10, 300, 200);
		if (_root.DressFrame == 0) {
			_root.DressFrame = _root.IsDickgirl() ? 3 : 1;
			if (_root.CheckBitFlag2(3) || _root.BiggerBoobs) _root.DressFrame++;
		}
		ShowMovie(mcBase.Robe2Clip, 1, 1, _root.DressFrame);
	} else if (_root.DressWorn == 3) {
		_root.PositionHalo(240, 16, 0, 163, 54);
		_root.PositionLeash(2, 222, 33, 0, -65, 110, true);
		_root.PositionGag(3, 243, 67, 0, 55, 30, true);
		_root.PositionNymphsTiara(240, 20, 0, 50, 59, true);
		_root.PositionCatEarsOver(1, 243, 20, 0, 58, 30);
		_root.PositionTail(190, 180, 180, 120, 90, true);
		_root.PositionWings(243, 130, 0, 300, 200);
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe3Clip, 1, 1, _root.DressFrame);
	} else if (_root.DressWorn == 4) {
		_root.PositionHalo(230, 18, 0, 163, 54);
		_root.PositionLeash(2, 262, 32, 0, 80, 119.85, true);
		_root.PositionGag(4, 232, 60, -10, 49, 50, true);
		_root.PositionNymphsTiara(233, 27, 0, 50, 50, true);
		_root.PositionCatEarsOver(1, 233, 30, 10, 58, 30);
		_root.PositionWingLeft(180, 128, 20, 150, 200);
		_root.PositionWingRight(320, 148, 0, 150, 200);
		_root.PositionTail(290, 180, 0, 120, 90, true);
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe4Clip, 1, 1, _root.DressFrame);
	} else if (_root.DressWorn == 5) {
		_root.PositionHalo(220, 20, -20, 170, 60);
		_root.PositionLeash(2, 276, 40, 0, 80, 120, true);
		_root.PositionGag(4, 245, 63, -40, 70, 40, true);
		_root.PositionNymphsTiara(225, 20, -20, 80, 70, true);
		_root.PositionCatEarsOver(2, 228, 30, -20, 90, 50);
		_root.PositionTail(190, 190, 180, 120, 90, true);
		_root.PositionWings(243, 140, 0, 300, 200);
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe5Clip, 1, 1, _root.DressFrame);
	} else if (_root.DressWorn == 6) {
		_root.PositionHalo(195, 26, 0, 190, 60);
		_root.PositionLeash(2, 238, 55, 0, 90, 119.85, true);
		_root.PositionGag(2, 205, 90, -5, 70, 30, true);
		_root.PositionNymphsTiara(195, 29, -20, 80, 80, true);
		_root.PositionCatEarsOver(2, 200, 45, -6, 80, 40);
		_root.PositionTail(150, 190, 180, 120, 90, true);
		_root.PositionWings(200, 150, 0, 300, 200);
		if (_root.DressFrame == 0) {
			_root.DressFrame = _root.IsDickgirl() ? 3 : 1;
			if (_root.CheckBitFlag2(3) || _root.BiggerBoobs) _root.DressFrame++;
		}
		ShowMovie(mcBase.Robe6Clip, 1, 1, _root.DressFrame);
	}
}

public function ShowDressSmall()
{
	if (_root.DressWorn == 0) {
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.RobePlainClip, 0, 1, _root.DressFrame);
	} else if (_root.DressWorn == 1) {
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe1Clip, 0, 1, _root.DressFrame);
	} else if (_root.DressWorn == 2) {
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe2Clip, 0, 1, _root.DressFrame);
	} else if (_root.DressWorn == 3) {
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe3Clip, 0, 1, _root.DressFrame);
	} else if (_root.DressWorn == 4) {
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe4Clip, 0, 1, _root.DressFrame);
	} else if (_root.DressWorn == 5) {
		if (_root.DressFrame == 0) _root.DressFrame = (_root.CheckBitFlag2(3) || _root.BiggerBoobs) ? 2 : 1;
		ShowMovie(mcBase.Robe5Clip, 0, 1, _root.DressFrame);
	} else if (_root.DressWorn == 6) {
		if (_root.DressFrame == 0) {
			_root.DressFrame = _root.IsDickgirl() ? 3 : 1;
			if (_root.CheckBitFlag2(3) || _root.BiggerBoobs) _root.DressFrame++;
		}
		ShowMovie(mcBase.Robe6Clip, 0, 1, _root.DressFrame);
	}
}


// Items

public function ShowBunnySuit() : Boolean
{
	mcBase.SleazyBarClip.gotoAndStop(2);
	mcBase.SleazyBarClip._visible = true;
	return true;
}


public function ShowLingerie() : Boolean
{
	mcBase.SleazyBarClip.gotoAndStop(Math.floor(Math.random()*2) + 4);
	mcBase.SleazyBarClip._visible = true;
	return true;
}

public function ShowMaidUniform() : Boolean
{
	ShowEndingMaid();
	return true;
}

public function ShowSwimsuit() : Boolean
{
	ShowEndingCourtesan();
	return true;
}

public function PurchaseItem(item:Number, hint:Boolean) : Boolean
{
	if (hint || _root.CheckBitFlag2(1)) return false;
	if (_root.currentShop != null && _root.currentShop.IsThisShop("armoury")) {
		AddText("\r\r#slave interrupts, and offers you a large mallet or hammer. You are rather perplexed where she got it from. The merchant looks surprised too.\r\rDo you accept it as a weapon?");
		_root.SetBitFlag2(1);
		DoYesNoEvent(310);
		return true;
	}
	return false;
}

// Events

public function PreEvent() : Boolean
{
	if (_root.MilkInfluence > 0) return false;
	if (_root.CheckBitFlag2(3)) {
		if (Math.floor(Math.random()*3) < 2) {
			mcBase.EventBreasts.gotoAndStop(2);
			mcBase.EventBreasts._visible = true;
			_root.ClearBitFlag2(3);
			Backgrounds.ShowBath();
			SetText("You see #slave emerging from her morning bath, and she is smiling, she really likes baths.\r\rYou also see her breasts are back to their normal, smaller size.");
			return true;
		} else return false;
	} else {
		if (_root.Aroused && Math.floor(Math.random()*3) == 0) {
			mcBase.EventBreasts.gotoAndStop(1);
			mcBase.EventBreasts._visible = true;
			_root.SetBitFlag2(3);
			SetText("You see #slave emerging from her morning bath, she looks a bit distracted.\r\rYou also see her breasts have grown again.");
			return true;
		}
	}
	return false;
}

public function DoEventNext() : Boolean
{
	if (_root.NumEvent == 4080) {
		_root.HideImages();
		_root.HideSlaveActions();
		Backgrounds.ShowBedRoom(1);
		_root.MilkInfluence = 7;
		_root.NumEvent = 301;
		ShowMilking();
		ShowMovie(mcBase.PeopleDoctor, 0, 2); 
		SetText("She is a little confused as she is helped into the farm and starts feeling a rising arousal. She is helped to lie down on a bed and is aware of a conversation outside, but just hears fragments of words\r\r...she talked...her breasts grow without...need to make up....let's get her...\r\rSometime later a woman enters the room, dressed as a doctor, but slightly untidy as if she dressed quickly. She has quite large breasts, not quite contained by her tight dress. She talks to #slave,\r\r");
		PersonSpeak("Doctor", "I have been told about your condition, let me examine you.", true);
		AddText("\r\rThe woman examines #slave in an awkward way, spending most of her time feeling and massaging #slave's breasts. #slave feels extremely aroused and is very close to cumming when the woman stops, and says,\r\r");
		PersonSpeak("Doctor", "Your condition is treatable, you will have to be completely, thoroughly milked, to empty your breasts. Eventually after enough treatments they will stay normal permanently.", true);
		if (_root.IsDickgirl()) {
			AddText("\r\rShe looks at #slave's very erect cock,\r\r");
			PersonSpeak("Doctor", "Your cock will also have to be treated, and emptied...", true);
		}
		AddText("\r\r#slave finds the doctor a little strange, she seems very seductive, almost slutty.\r\rThe doctor takes #slave to a nearby room, on the way she glimpses a room with a number of girls, moaning and with devices attached to their breasts. The doctor hurries her on, commenting that they are also being <i>treated</i>, smiling oddly.\r\rIn the room the doctor lightly restrains #slave explaining it is to prevent her from harming herself. The doctor attaches two suction cups to the end of long tubes and secures them to #slave's nipples.");
		if (_root.IsDickgirl()) AddText("She then slides a large tube over #slave's cock, reminding her that we need to completely drain her, smiling, and then briefly licking her lips.");
		AddText("\r\rThe doctor places a large dildo below #slave and instructs her to mount it, telling her that it is coated in a medicine that has to be applied <i>internally</i>. Nervously #slave lowers herself onto the dildo, as she does the suction devices start sucking, and " + SlaveName);
		if (_root.IsDickgirl()) AddText(" cries out and cums, her cock spraying cum into the tube.");
		else AddText(" gasps and orgasms, strongly shaking as her pussy contracts on the dildo.");
		AddText("\r\rThe doctor watches for a while as milk flows from #slave's breasts as the suction cups suck and pump continually. ");
		if (_root.IsDickgirl()) AddText("Over and over #slave cums, intensely pumping, spraying her cum into the tube...");
		else AddText(SlaveName + " orgasms repeatedly, as she fucks herself on the dildo...\r\r");
		_root.TotalMilked = 1;
		DoEvent();
		return true;
	} else if (_root.NumEvent == 301) {
		ShowMovie(mcBase.PeopleDoctor, 0, 2); 
		AddText("Time passes and #slave starts feeling exhausted, and the milk stops flowing from her breasts and her orgasms stop. The doctor looks very flushed and steps out of the room for a moment returning with a cup, and then steps behind #slave and from there raises the cup to #slave's lips. She drinks, ");
		if (_root.IsDickgirl()) {
			_root.CustomFlag1++;
			AddText("it's cum! She hears the doctor say,\r\r");
			PersonSpeak("Doctor", "It's yours, treated with medicine. Drink it while I inject some more medicine into you.", true);
			AddText("\r\rAs #slave sips her own cum, mixed with something, she feels the doctor lift her from the dildo and then a large, slippery cock slides into her pussy.\r\r");
			PersonSpeak("Doctor", "Ohhh, I need, I mean you need, uhhgg this.", true);
			AddText("\r\rThe doctor fucks #slave quickly as #slave gulps down her own cum. As she does #slave feels a bit refreshed and her arousal returning. The doctor fucks her hard and fast, and very quickly cums, screaming as she pours her cum deep into #slave's womb. Moments later #slave cums again and passes out.\r");
		} else {
			AddText("it's milk! She hears the doctor say,\r\r");
			PersonSpeak("Doctor", "It's yours, treated with medicine. Drink it while I inject some more medicine into you.", true);
			AddText("\r\rAs #slave sips her own milk, mixed with something, she feels the doctor lift her from the dildo and then a large, slippery strap-on slides into her pussy.\r\r");
			PersonSpeak("Doctor", "Ohhh, I need, I mean you need, uhhgg this.", true);
			AddText("\r\rThe doctor fucks #slave quickly as #slave gulps down her own milk. As she does #slave feels a bit refreshed and her arousal returning. The doctor fucks her hard and fast, and very quickly orgasms. Moments later #slave orgasms again and passes out.\r");
		}
		DoEvent(4081);
		return true;
	} else if (_root.NumEvent == 4081) {
		_root.ShowAct("TreatmentJob");
		_root.SetBitFlag2(4);
		_root.SetBitFlag1(7);
		_root.UpdateSlave();
		_root.StopPlanning(false);
		_root.AddTime(3);
		HideBackgrounds();
		SetText("Later #slave wakes up and sees #assistant looking a bit uncertain. The doctor is sitting nearby, looking neat, tidy and properly dressed. They are talking about #slave's treatment and about how #slave should return here at least weekly for more treatments. The doctor says they will be free, in fact due to certain considerations for #slave's milk, they will actually pay a small fee.\r\r#assistant looks doubtful but agrees for now and takes #slave home.");
		_root.HideImages();
		_root.HidePeople();
		DoEvent(9999);
		ShowMovie(mcBase.PeopleDoctor, 1, 2); 
		return true;
	}
	return false;
}

public function DoEventYes() : Boolean
{
	if (_root.NumEvent == 300) {
		_root.HideStatChangeIcons();
		_root.HideImages();
		_root.DressOverlay._visible = true;
		_root.UseGeneric = false;
		ShowSexActBondage();
		if (_root.UseGeneric) _root.Generic.ShowSexActBondage();
		if (_root.House == 1) Points(0, 2 + _root.SilkenRopesOK, 0, 0, -4, 0, 0, 0, 0, 0, 0, -4, 4, 9, 7, 0, 2, -2, -2, 0);
		Points(0, 2 + _root.SilkenRopesOK, 0, 0, -4, 0, 0, 0, 0, 0, 0, -4, 4, 8, 6, 0, 2, -2, -2, 0);
		DoEvent(9999);
		SetText("You and #assistant spend the day correcting #slave while she is tightly tied up. Despite herself she seems to enjoy parts of it, cumming occasionally.");
		_root.SetTime(18);
		_root.Behaving = _root.Behaving + 6;
		_root.DifficultyBondage = _root.DifficultyBondage - 2;
		return true;
	} else if (_root.NumEvent == 310) {
		_root.ArmouryMenu._visible = false;
		SMData.SetWeaponOwned(4);
		SMData.LoadWeaponImage(4, 1, 1);
		SetText("The hammer is an odd weapon but #slave assures you it is very effective.");
		HideBackgrounds();
		DoEvent(9705);
		return true;
	}
	return false;
}

public function DoEventNo() : Boolean
{
	if (_root.NumEvent == 300) {
		_root.HideStatChangeIcons();
		_root.HideImages();
		_root.DressOverlay._visible = true;
		ShowChoreDiscuss();
		Points(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0);
		SetText("You decide to talk to #slave and talk through the issue and tell her she needs to obey #assistant. She agrees and appreciates the talk.");
		DoEvent(9999);
		return true;
	} else if (_root.NumEvent == 310) {
		_root.Armoury.ShowShopContents();
		_root.ShowLeaveButton();
		return true;
	}
	return false;
}

public function Events()
{
	if (_root.DoneEvent == 0 && _root.CustomFlag < 2 && _root.VarObedience < 50) {
		if ((_root.Elapsed > 8 && _root.CustomFlag == 0) || (_root.Elapsed > 13 && _root.CustomFlag == 1)) {
			mcBase.EventShampooTrouble._visible = true;
			temp = _root.CustomFlag + 1;
			if (_root.IsAssistant("Shampoo") == false && temp == 2) temp = 5;
			if (_root.IsDickgirl()) temp++;
			mcBase.EventShampooTrouble.gotoAndStop(temp);
			if (_root.CustomFlag == 0) {
				Backgrounds.ShowSlums();
				SetText("You find #slave tied up and rather upset.\r\r");
				SlaveSpeakStart("I was arguing with that ", true);
				if (_root.ServantFemale) AddText("bitch ");
				else AddText("bastard ");
				PersonSpeakEnd("#assistant and #assistantheshe got angry and overpowered me and tied me here. #assistant said #assistantheshe would come back and free me but it has been a long time!", true);
				AddText("\r\rYou free #slave and then find #assistant and scold " + _root.ServantHimHer + ".");
			} else {
				SetText("You find #assistant chastising a tied up #slave. Both are naked and seem rather aroused. #slave seems upset but is not really struggling to get free. #assistant is dominating her and also seems to be enjoying it.\r\rYou watch for a bit and then interrupt them and end it. Both of them seem a bit disappointed.");
			}
			DoEvent(9999);
			Points(0, 1 + _root.SilkenRopesOK, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, _root.CustomFlag + 1, 2, _root.CustomFlag + 1, 0, 1, 1, 0, 0);
			_root.CustomFlag = _root.CustomFlag + 3;
		} 
	}
	if (_root.DoneEvent == 0 && _root.VarObedienceRounded<90 && _root.Behaving < 1 && _root.Elapsed > 8) {
		temp = Math.floor(Math.random()*5);
		if (temp == 1) {
			if (_root.IsAssistant("Shampoo")) mcBase.ClipPunish.gotoAndStop(1);
			else mcBase.ClipPunish.gotoAndStop(2);
			mcBase.ClipPunish._visible = true;
			_root.ServantSpeak(SlaveName + " was being rebellious and started hitting me. I have restrained her, and think we need to thoroughly discipline her.\r\rShall we spend the day disciplining her?");
			DoYesNoEvent(300);
		} 
	}
	if (_root.DoneEvent == 0 && _root.CheckBitFlag2(2)) {
		_root.PotionsUsed[0] = _root.PotionsUsed[0] + 1;
		if (_root.PotionsUsed[0] == 2) {
			SetText("You hear a garbled cry from #slave's room and you run in. You see she is covered in cum erupting from a cock that has grown from her groin. A lot of the cum is pouring into her mouth and she is gagging and struggling to swallow it all.\r\rYou pull her cock free and she coughs and gasps, her cock still cumming. Eventually, after coating you both in her cum, she gasps and stops cumming. Her cock shrinks and disappears as she pants and lies back in a large puddle of her cum.\r\rYou wonder why this has happened, possibly some delayed effect of her experience at Astrid's place?\r\rYou see #assistant standing at the door smiling.");
			DoEvent(9999);
		} else {
			SetText("Again, you hear a garbled cry from #slave's room and you run in. You see she again is cumming from a large cock, pouring cum over her breasts, her hair, her face, her bed, but mostly into her mouth as she tries to swallow it. You pull her free and hold her, but she keeps cumming and cumming. After a time you realise she does not seem to be stopping. A worried #assistant runs in and clamps a hand around the base of #slave's cock, holding tightly. #slave stops cumming but gasps, moans and strains as if she wants to. #assistant looks ashamed,\r\r");
			_root.ServantSpeak(_root.ServantPronoun + " am sorry " + _root.Master + "! I slipped her some of the Priapus Draft, she seemed to dislike it so much, but also to like it so much.", true);
			AddText("\r\rYou are angry and scold #assistant promising to punish " + _root.ServantHimHer + " severely. You decide you need to consult with Astrid and between you and #assistant you work out where she lives.\r\rYou take #slave to Astrid. By the time you get there #slave has calmed a little, and is no longer cumming continuously, but still occasionally...");
			DoEvent(210);
		}
		mcBase.ClipDickgirl.gotoAndStop(5);
		mcBase.ClipDickgirl._visible = true;
		_root.Icons.DickgirlXFIcon._visible = true;
		_root.ClearBitFlag2(2);
	}
}

public function AfterEventYes()
{
	if (_root.OldNumEvent == 4080) {
		SetText(SlaveName + " swallows the sweet and immediately feels an intense, but familiar pressure in her chest. ");
		if (Naked) AddText("She looks down");
		else AddText("She pulls off her clothes");
		AddText(" and her breasts swell, visibly growing, and growing, larger than usual.\r\rThey finally stop and she feels a bit dizzy so sits down, and apologises to the man, explaining briefly about her problem. He looks surprised when she speaks and hesitates a bit. He then suggests that he help her into the farm to rest for a bit.\r\rHe helps her to her feet and they walk toward the farm, her breasts swinging and leaking milk...");
	}
}

public function ShowDating()
{
	Backgrounds.ShowBedRoom();
	mcBase.ClipDating._visible = true;
}

public function ShowTired(cum:Boolean)
{
	if (_root.IsDickgirl()) mcBase.ClipTired.gotoAndStop(2);
	else if (cum || Naked) mcBase.ClipTired.gotoAndStop(3);
	else mcBase.ClipTired.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.ClipTired._visible = true;
}

public function ShowPropositionAccepted()
{
	mcBase.ClipPropositionAccepted._visible = true;
}

public function ShowPropositionRefused()
{
	mcBase.ClipPropositionRefused._visible = true;
}

public function ShowRetrieved()
{
	_root.HideImages();
	if (_root.IsDickgirl()) {
		mcBase.BondageClip.gotoAndStop(1);
		mcBase.BondageClip._visible = true;
	} else mcBase.ClipSlaveRetrieved._visible = true;
}

public function ShowRaped() : Boolean
{
	if (_root.IsDickgirl()) mcBase.ClipRaped.gotoAndStop(2);
	else mcBase.ClipRaped.gotoAndStop(1);
	mcBase.ClipRaped._visible = true;
	return true;
}

public function AfterWalk(place:Number)
{
	if (place == 6.1 && _root.OldNumEvent == 2.1) AddText("\r\r#slave expresses her amazement that someone would want to experience life as a ponygirl. She asks many questions of the mistress and her ponygirls.");
}

public function DoWalkFarm(plc:Number) : Boolean
{
	if (plc != 7) return false;
	if (coreGame.NumEvent == 6 && sd.BitFlag2.CheckFlag(4)) {
		ShowSlaveJob();
		return true;
	}
	return false;
}

public function ShowMilkFall() : Boolean
{
	mcBase.ClipTired._visible = true;
	mcBase.ClipTired.gotoAndStop(2);
	return true;
}

public function ShowMilking()
{
	if (_root.TentacleHaunt == 0) ShowMovie(mcBase.PeopleDoctor, 0, 2); 
	mcBase.EventMilk.gotoAndStop(_root.IsDickgirl() ? 3 : 2);
	mcBase.EventMilk._visible = true;
}

public function ShowMilkEnd() : Boolean
{				
	SetText("You visit #slave in her room and she looks really angry\r\r");
	SlaveSpeak("That doctor is not helping me! She is exploiting me, milking me for profit. I do not think there is any cure or that they are doing anything at all!!", true);
	AddText("\r\rYou have been doubtful and then you hear #assistant loudly agree that the doctor is a fraud. You agree never to send #slave for treatment again.");
	_root.ClearBitFlag2(4);
	_root.HideAct("TreatmentJob");
	mcBase.EventMilk.gotoAndStop(1);
	mcBase.EventMilk._visible = true;
	return true;
}

public function ShowMilkAccident() : Boolean
{				
	mcBase.ExhibClip.gotoAndStop(3);
	mcBase.ExhibClip._visible = true;
	_root.ShowOverlayWhite();
	return true;
}

public function ShowMorningMouthfull() : Boolean
{
	mcBase.EventMorningMouthfull._visible = true;
	return true;
}

public function ShowNakedApron() : Boolean
{
	ShowMovie(mcBase.EventNakedApron, 1.1, 1, slrandom(2));
	return true;
}

// Love

public function ShowLoveConfession()
{
	Backgrounds.ShowTownCenter();
	mcBase.ClipLoveConfession.gotoAndStop(_root.IsDickgirl() ? 2 : 1);
	mcBase.ClipLoveConfession._visible = true;
}

public function ShowLoveAccepted()  : Boolean
{
	HideBackgrounds();
	mcBase.ClipLoveConfession._visible = false;
	mcBase.ClipLoveAccepted._visible = true;
	return false;
}

public function ShowLoveRefused()
{
	HideBackgrounds();
	mcBase.ClipLoveConfession._visible = false;
	mcBase.ClipLoveRefused._visible = true;
	if (_root.NumEvent == 3) {
		Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0, -15, -20, 0);
		SetText(SlaveName + " is very sad but at least you don't let your personal likes interfere with your job.");
	}
}

public function NobleLove(allowoffer:Boolean)
{
	if ((allowoffer == true && _root.NobleLove == -1) || _root.NobleLove == 6) {
		AddText("\r\rThe Lord is sure of his love and asks to buy #slave for 1500GP. #slave doesn't wish to be sold saying he is intense and a bit odd.\r\rDo you sell her.");
		ShowPerson(8, 1, 1, 2);
		_root.ShowOverlay(0x97c526);
		DoYesNoEventXY(13);
	} else if (_root.NobleLove == -2) AddText("\r\r#slave visits her new owner out of duty.");
	else if (_root.NobleLove == -1) AddText("\r\rThe Lord dotes upon #slave promising her future happiness.");
	else if (_root.NobleLove < 3)  AddText("\r\rThe Lord gives #slave many compliments and praises her beauty. He invites her to visit anytime.");
	else if (_root.NobleLove < 5)  AddText("\r\rThe Lord expresses his ardent admiration of #slave and appears most taken with her.");
	else if (_root.NobleLove < 6)  AddText("\r\rThe Lord enthusiastically confesses his love to #slave. She thanks him but refuses his confession.");
}

public function ShowNobleLoveRefused()
{
	SetText("The Lord is very sad but makes it clear he loves her and the offer stands.");
	ShowPerson(8, 1, 1, 3);
	Backgrounds.ShowPalace();
}

public function ShowNobleLoveAccepted()
{
	SMMoney(1500);
	ShowMovie(mcBase.ClipNobleLove, 1, 2, 1);
}


// Daytime

public function ShowChoreCleaning()
{
	if (!_root.DoDickgirlChange(33)) mcBase.CleaningClip._visible = true;
}

public function ShowChoreCooking()
{
	if (_root.UseGeneric) return;
	temp = Math.floor(Math.random()*2) + 1;
	if (temp == 2) HideBackgrounds();
	mcBase.CookingClip.gotoAndStop(temp);
	mcBase.CookingClip._visible = true;
}

public function ShowChoreDiscuss()
{
	HideBackgrounds();
	if (Naked) {
		if (_root.IsDickgirl()) mcBase.DiscussClip.gotoAndStop(4);
		else mcBase.DiscussClip.gotoAndStop(Math.floor(Math.random()*2) + 3);
	} else mcBase.DiscussClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.DiscussClip._visible = true;
}
public function ShowChoreExpose()
{
	if (_root.IsDickgirl()) temp = 4;
	else temp = Math.floor(Math.random()*3) + 1;
	mcBase.ExhibClip.gotoAndStop(temp);
	mcBase.ExhibClip._visible = true;
}

public function ShowChoreMakeUp() : Boolean {
	var donearoused = false;
	if (Naked) mcBase.BeautyClip.gotoAndStop(2);
	else if (Aroused && Math.floor(Math.random()*4) == 1) {
		donearoused = true;
		mcBase.BeautyClip.gotoAndStop(3);
		SlaveSpeak(_root.SlavePronoun + " need to properly coordinate my clothes. Do you think these panties go with this dress?");
	} else {
		mcBase.BeautyClip.gotoAndStop(1);
	}
	mcBase.BeautyClip._visible = true;
	return donearoused;
}

public function ShowChoreExercise() {
	if (_root.DressWorn == 3) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0);
	if (_root.DoDickgirlChange(33) || _root.IsPonygirl()) return;
	if (_root.IsDickgirl()) {
		if (Naked) temp = 5;
		else {
			mcBase.EndingDickgirl._visible = true;
			AddText(SlaveName + " takes a brisk walk but starts getting more and more aroused. Her cock grows erect and she washes herself in a public fountain to try to calm down. It does not help much and she returns home, cock very erect.");
			return;
		}
	} else if (Naked) temp = 4;
	else {
		temp = Math.floor(Math.random()*3) + 1;
		if (temp == 3) Backgrounds.ShowTownCenter();
	}
	mcBase.PromenadeClip.gotoAndStop(temp);
	mcBase.PromenadeClip._visible = true;
}


public function ShowSchoolDance(donearoused:Boolean) {
	temp = Math.floor(Math.random()*2) + 1;
	if (Naked) temp = 3;
	mcBase.DanceClip.gotoAndStop(temp);
	if (temp == 2) {
		_root.ShowOverlay(0xEFFFFF);
		HideBackgrounds();
	}
	mcBase.DanceClip._visible = true;
}

public function ShowSchoolSciences() {
	mcBase.SciencesClip._visible = true;
}

public function ShowSchoolTheology() {
	mcBase.TheologyClip._visible = true;
}

public function ShowSchoolRefinement() {
	mcBase.RefinementSchoolClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.RefinementSchoolClip._visible = true;
}

public function ShowSchoolXXX(doDG:Boolean) : Boolean {
	if (Lesbian) temp = 3;
	else if (doDG) {
		temp = 4;
		PersonSpeak("Teacher", "You need to have some experience with a hermaphrodite, a woman with both genitals. She has a huge libido and you will fuck many times. Please enjoy yourself.");
	} else if (_root.IsDickgirl() || Naked) temp = 1;
	else temp = Math.floor(Math.random()*3) + 1;
	mcBase.XXXClip.gotoAndStop(temp);
	mcBase.XXXClip._visible = true;
	return temp == 3;
}

public function ShowJobAcolyte() : Number {
	mcBase.AcolyteClip._visible = true;
	return 1;
}

public function ShowJobBar() : Number {
	if (Naked) {
		if (_root.IsDickgirl()) mcBase.BarClip.gotoAndStop(3);
		else mcBase.BarClip.gotoAndStop(2);
		HideBackgrounds();
		Backgrounds.ShowBeach();
	} else mcBase.BarClip.gotoAndStop(1);
	mcBase.BarClip._visible = true;
	return 1;
}

public function ShowJobBrothel() : Number {
	HideBackgrounds();
	if (Math.floor(Math.random()*3) == 1 && !_root.IsDickgirl()) mcBase.BrothelClip.play();
	else {
		temp = Math.floor(Math.random()*2) + 40;
		if (Naked) temp = 40;
		mcBase.BrothelClip.gotoAndStop(Math.floor(Math.random()*2) + 40);
		if (temp == 41) Backgrounds.ShowBedRoom();
	}
	mcBase.BrothelClip._visible = true;
	return 1;
}

public function ShowJobOnsen(wgender:Number) : Number
{
	if (_root.IsDickgirl()) {
		mcBase.BreakClip.gotoAndStop(4);
		mcBase.BreakClip._visible = true;
	} else mcBase.JobOnsen._visible = true;
	return 1;
}

public function ShowJobOnsenService(cgender:Number) : Boolean
{
	switch(cgender) {
		case 1:
			mcBase.BlowjobClip.gotoAndStop(slrandom(4));
			mcBase.BlowjobClip._visible = true;
			break;
		case 2:
			mcBase.BlowjobClip.gotoAndStop(5);
			mcBase.BlowjobClip._visible = true;
			break;
		case 3:
			mcBase.BlowjobClip.gotoAndStop(slrandom(4));
			mcBase.BlowjobClip._visible = true;
			break;
	}
	return true;
}

public function ShowJobRestaurant() : Number {
	if (_root.UseGeneric) return 1;
	if (Naked) {
		if (_root.IsDickgirl()) temp = 5;
		else temp = 3;
	} else {
		if (_root.IsDickgirl()) {
			HideBackgrounds();
			temp = 4;
		} else temp = Math.floor(Math.random()*2) + 1;
	}
	mcBase.RestaurantClip.gotoAndStop(temp);
	mcBase.RestaurantClip._visible = true;
	return 1;
}

public function ShowJobSleazyBar(strip:Boolean) : Number {
	if (strip) temp = _root.IsDickgirl() ? 9 : 7;
	else if (Naked) temp = _root.IsDickgirl() ? 9 : 6;
	else if (_root.BunnySuitOK) temp = slrandom(2);
	else if (_root.IsDickgirl()) temp = 8;
	else temp = Math.floor(Math.random()*3) + 3;
	mcBase.SleazyBarClip.gotoAndStop(temp);
	if (temp == 1) {
		HideBackgrounds();
		_root.ShowOverlay(0xC0C0F0);
	} else if (temp == 2) HideBackgrounds();
	mcBase.SleazyBarClip._visible = true;
	PersonSpeakStart("Sleazy Bar Owner", "The customers like you, I hope to see you again.", true);
	return 1;
}

public function ShowSlaveJob(act:Number)
{
	// only 1 custom job, so no need to test act
	ShowMilking();
	_root.TotalMilked = _root.TotalMilked + 1;
	_root.MilkInfluence = _root.MilkInfluence + 9;
	if (_root.MilkInfluence > 16) _root.MilkInfluence = 16;

	var pay:Number = int(0.8 * (_root.VarConstitutionRounded + _root.VarLibidoRounded));
	_root.EarnMoney(pay);
	Points(0, 1, 0, -0.5, 0, 1, 0, 0, -1, 0, 0, 0, 1, 0, -2, 0, 3, 0, 0, 0);
	AddText(_root.SlaveName + " visits the farm and the doctor is sent for. After a little while the doctor arrives and commences her treatment of #slave.\r\rAfter, she gives #slave her fee for the treatment : "+pay+"GP");
}

public function ShowRefusedAction(Action:Number, slave:String, servant:String, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Libido:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number) : Boolean
{
	mcBase.RefusedAction._visible = true;
	return false;
}

public function ShowBreak(sleeping:Boolean) {
	if (_root.IsDickgirl()) {
		if (sleeping) temp = 1;
		else temp = (Math.floor(Math.random()*2)*3) + 1;
	} else if (Naked || sleeping) temp = 1;
	else temp = Math.floor(Math.random()*3) + 1;
	if (temp == 3) Backgrounds.ShowBath();
	mcBase.BreakClip.gotoAndStop(temp);
	mcBase.BreakClip._visible = true;
}

// Sex

public function AfterNewPlanningAction(type:Number, available:Boolean, hint:Boolean)
{
	if (!_root.IsAssistant("Shampoo")) return;
	
	if (type == 2) {
		AddText("\rYou are annoyed at the way #assistant and #slave argue. You think you might order #assistant to touch #slave.");
	} else if (type == 3 ) {
		AddText("\rYou are annoyed at the way #assistant and #slave argue. You think you might order #assistant to do it instead.");
	} else if (type == 11) {
		AddText("\r");
		_root.ServantSpeak("She will make love with another female slave, not with <i>Shampoo!</i>", true);
	} else if (type == 12) {
		if (_root.RopesOK == 0 && _root.SilkenRopesOK == 0) return false;
    	_root.ServantSpeak("We can tie her and control her.");
		if (_root.TestObedience(_root.DifficultyBondage)) AddText("\r\r#slave looks annoyed but excited.\r\r");
		else AddText("\r\r#slave looks annoyed.\r\r");
	} else if (type == 19) {
		AddText("\r");
		_root.ServantSpeak("But <b>not</b> with Shampoo.", true);
	}
}

public function ShowSexActNothing() {
	if (_root.IsDickgirl()) temp = 1;
	else if (Naked) temp = 2;
	else temp = Math.floor(Math.random()*2) + 1;
	mcBase.NeedingClip.gotoAndStop(temp);
	if (temp == 2) _root.ShowOverlay(0);
	mcBase.NeedingClip._visible = true;
}

public function ShowSexAct69() {
	if (_root.DoDickgirlChange(100)) return;
	if (Lesbian) mcBase.SixtyNineClip.gotoAndStop(2);
	else if (_root.UseGeneric) return;
	else mcBase.SixtyNineClip.gotoAndStop(1);
	mcBase.SixtyNineClip._visible = true;
}

public function ShowSexActAnal() {
	if (_root.DoDickgirlChange(40)) return;
	if (_root.IsDickgirl()) mcBase.AnalClip.gotoAndStop(4);
	else if (Lesbian) {
		if (_root.DefaultLesbian(50)) return;
		mcBase.AnalClip.gotoAndStop(1);
	} else mcBase.AnalClip.gotoAndStop(Math.floor(Math.random()*3) + 1);
	HideBackgrounds();
	mcBase.AnalClip._visible = true;
}

public function ShowSexActBlowjob() {
	if (Lesbian) {
		if (_root.DefaultLesbian(33)) return;
		temp = 5;
	} else temp = Math.floor(Math.random()*4) + 1;
	HideBackgrounds();
	// if dickgirl receiver use different version of frame 1
	if (temp == 1 && ((_root.LastActionDone == 5 && _root.Gender == 3) || _root.LastActionDone == 5.5 || _root.LastActionDone == 5.6)) temp = 6;
	if (temp == 2) {
		_root.StartChangeImage(1000, mcBase.BlowjobClip, 7);
		_root.StartCumSplatter(1250, mcBase.BlowjobClip, 2, 8, 1250);
	}
	ShowMovie(mcBase.BlowjobClip, 1, 2, temp);
}

public function ShowSexActBondage() {
	if (_root.DoDickgirlChange(33) || _root.UseGeneric) return;
	if (_root.TotalBondage<5) {
		if (_root.IsDickgirl()) temp = Math.floor(Math.random()*2) + 11;
		else temp = _root.TotalBondage + 1;
	} else {
		if (Lesbian) temp = Math.floor(Math.random()*5) + 1;
		else if (_root.IsDickgirl()) {
			temp = Math.floor(Math.random()*3) + 7;
			if (temp == 9) temp = 11;
		}
		else temp = Math.floor(Math.random()*10) + 1;
	}
	mcBase.BondageClip.gotoAndStop(temp);
	mcBase.BondageClip._visible = true;
	switch (temp) {
		case 1:
		case 11:
			SetText("You tie her up and leave her to get accustomed to the feeling.");
			break;
		case 2:
			SetText("You tie her up and leave her for a time on a private beach, to experience the exposure and sensation.");
			Backgrounds.ShowBeach();
			break;
		case 3:
			SetText("You tie her up and spank her pussy to get her aroused. You stop when you realise she has had an orgasm despite the pain.");
			break;
		case 4:
			SetText("You tie her up and place a plug in her ass for a time to help her get accustomed to such things.");
			break;
		case 5:
			SetText("You tie her up and get a reluctant #assistant to arouse her with a dildo she has. #slave is unhappy with the fact you have #assistant do it but is unable to control herself and is brought to orgasm after orgasm.");
			break;
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
			if (_root.Gender != 2) SetText("You tie her up and she begs you to fuck her. You decide it is a good experience and do so while she is tied. She seems to love and hate it, hating the control but she has very intense orgasms, stronger than normal.");
			else SetText("You tie her up and she begs to be fucked. You decide it is a good experience and have a male slave do so while she is tied. She seems to love and hate it, hating the control but she has very intense orgasms, stronger than normal.");
			break;
	}
	if (_root.TotalBondage<5) {
		AddText("\r\rShe struggles and yells her annoyance, mainly at #assistant. When you release her she seems very aroused.");
	} else if (_root.TotalBondage<10) {
		AddText("\r\rShe complains, mainly about #assistant, but seems to enjoy the experience.");
	} else if (_root.TotalBondage<20) {
		AddText("\r\rShe submits willingly to you and reluctantly to #assistant. She seems eager for the experience and sorry when you release her.");
	} else {
		AddText("\r\rShe delights in submitting to you and to #assistant to the extent she tells you she never wants to be freed and is willing to do <i>anything</i> you ask.");
	}
	Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

}

public function ShowSexActCumBath() : Boolean {
	temp = slrandom(3);
	if (temp == 3) {
		mcBase.GangBangClip.gotoAndStop(3);
		mcBase.GangBangClip._visible = true;
	} else ShowMovie(mcBase.CumBathClip, 1, 2, temp);
	return true;
}

public function ShowSexActDildo() {
	HideBackgrounds();
	if (_root.DoDickgirlChange(33)) return;
	if (_root.IsDickgirl()) {
		if (Math.floor(Math.random()*3) > 2) {
			mcBase.ClipDickgirl.gotoAndStop(1);
			mcBase.ClipDickgirl._visible = true;
			return;
		} else mcBase.DildoClip.gotoAndStop(Math.floor(Math.random()*2) + 3);
	} else mcBase.DildoClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.DildoClip._visible = true;
}

public function ShowSexActFootjob() : Boolean
{
	if (coreGame.PersonGender == 2) return false;
	
	ShowMovie(mcBase.FootjobClip, 1, 1, 1);
	return true;
}

public function ShowSexActFuck() {
	if (_root.DoDickgirlChange(30)) return;
	if (Lesbian) {
		if (_root.DefaultGeneric(50)) return;
		mcBase.FuckClipa._visible = true;
		mcBase.FuckClipa.gotoAndStop(slrandom(2));
	} else if (_root.IsDickgirl() && Math.floor(Math.random()*3) == 1) {
		mcBase.FuckClipa._visible = true;
		mcBase.FuckClipa.gotoAndStop(5);
	} else if (_root.IsDickgirl() || Math.floor(Math.random()*3) == 1) {
		HideBackgrounds();
		mcBase.FuckClipb._visible = true;
		mcBase.FuckClipb.play();
	} else {
		if (_root.Gender == 3) temp = Math.floor(Math.random()*2) + 1;
		else temp = Math.floor(Math.random()*4) + 1;
		if (Naked) temp = 4;
		if (temp == 2) HideBackgrounds();
		// if dickgirl fucker use different frame
		if (temp == 4 && (_root.LastActionDone == 4 && _root.Gender == 3)) temp = 2;

		mcBase.FuckClipa._visible = true;
		mcBase.FuckClipa.gotoAndStop(temp);
	}
}

public function ShowSexActGangBang() {
	if (Lesbian) _root.UseGeneric = true;
	if (_root.UseGeneric) return;

	if (_root.IsDickgirl()) {
		if (_root.DefaultGeneric(33)) return;
		mcBase.GangBangClip.gotoAndStop(5);
	}
	else if (Naked) mcBase.GangBangClip.gotoAndStop(Math.floor(Math.random()*2) + 3);
	else mcBase.GangBangClip.gotoAndStop(Math.floor(Math.random()*4) + 1);
	mcBase.GangBangClip._visible = true;
}

public function ShowSexActGroup() {
	if (Lesbian) {
		mcBase.GroupClip.gotoAndStop(4);
		HideBackgrounds();
	} else if (_root.DoDickgirlChange(50)) return;
	else if (_root.IsDickgirl()) mcBase.GroupClip.gotoAndStop(4);
	else if (Naked) mcBase.GroupClip.gotoAndStop(Math.floor(Math.random()*3) + 2);
	else mcBase.GroupClip.gotoAndStop(Math.floor(Math.random()*4) + 1);
	mcBase.GroupClip._visible = true;
}

public function ShowSexActHandjob() : Boolean
{
	if (coreGame.PersonGender == 2) return false;
	ShowMovie(mcBase.HandjobClip, 1, 1, 1);
	return true;
}

public function ShowSexActKiss() : Boolean {
	if (_root.PersonGender == 2) {
		// male
		mcBase.KissClip._visible = true;
	} else {
		// female
		mcBase.EndingLesbianSlave._visible = true;
	}
	return true;
}

public function ShowActLendHer() : String {
	if (_root.LendPerson == 3) temp = 4;
	else if (Lesbian) {
		if (_root.IsDickgirl()) {
			mcBase.ClipDickgirl.gotoAndStop(4);
			mcBase.ClipDickgirl._visible = true;
			return "";
		}
		temp = Math.floor(Math.random()*2) + 3;
	} else if (_root.IsDickgirl()) {
		mcBase.FuckClipa._visible = true;
		mcBase.FuckClipa.gotoAndStop(5);
		return "";
	} else temp = 1;
	mcBase.LendClip.gotoAndStop(temp);
	if (temp == 2) HideBackgrounds();
	mcBase.LendClip._visible = true;
	return "";
}

public function ShowSexActLesbian() {
	if (_root.DoDickgirlChange(50)) return;
	_root.UseGeneric = false;
	if (_root.IsDickgirl()) {
		if (Math.floor(Math.random()*3) == 0) {
			if (_root.IsAssistant("Shampoo")) mcBase.ClipDickgirl.gotoAndStop(3);
			else mcBase.ClipDickgirl.gotoAndStop(4);
			mcBase.ClipDickgirl._visible = true;
			return;
		}
		temp = 1;
	} else {
		if (Naked) {
			temp = Math.floor(Math.random()*4);
			if (temp == 2) temp = 5;
		} else {
			temp = Math.floor(Math.random()*5) + 1;
		}
	}
	if (temp == 5) {
		mcBase.LendClip.gotoAndStop(3);
		mcBase.LendClip._visible = true;
		return;
	}
	mcBase.LesbianClip.gotoAndStop(temp);
	if (temp == 1) {
		_root.ShowOverlay(0);
		mcBase.Door._visible = !_root.IsAssistant("Ranma");
	}
	mcBase.LesbianClip._visible = true;
}

public function ShowSexActLick() {
	if (_root.DoDickgirlChange(40)) return;

	if (_root.LastActionDone == 3.3) {
		_root.AppendActText = false;
		temp = 4;
		SetText("You order #assistant instead to lick her. #assistant looks annoyed, but skillfully licks her pussy.\r\r");
	} else {
		if (_root.IsDickgirl()) temp = 7;
		else if (_root.Gender == 1 || _root.LastActionDone == 3.4) temp = Math.floor(Math.random()*3) + 1;
		else temp = Math.floor(Math.random()*3) + 4;
	}
	mcBase.LickClip.gotoAndStop(temp);
	mcBase.LickClip._visible = true;
}

public function ShowSexActMaster() {
	HideBackgrounds();
	if (_root.IsDickgirl()) {
		if (Naked) {
			ShowMovie(mcBase.NakedClip, 1, 1, Math.floor(Math.random()*2) + 4);
			return;
		} else temp = 1;
	} else if (Naked) temp = 3;
	else temp = Math.floor(Math.random()*2) + 1;
	if (temp == 3) Backgrounds.ShowOnsen();
	mcBase.MasterClip.gotoAndStop(temp);
	mcBase.MasterClip._visible = true;
}

public function ShowSexActMasturbate() {
	if (!_root.DoDickgirlChange(25)) {
		if (_root.IsDickgirl()) {
			if (Math.floor(Math.random()*3) < 2) {
				mcBase.MasturbateClip.gotoAndStop(Math.floor(Math.random()*2) + 4);
				mcBase.MasturbateClip._visible = true;
				HideBackgrounds();
			} else {
				mcBase.ClipDickgirl.gotoAndStop(Math.floor(Math.random()*2) + 1);
				mcBase.ClipDickgirl._visible = true;
			}
		} else {
			if (Naked) temp = 3; 
			else temp = Math.floor(Math.random()*3) + 1;
			mcBase.MasturbateClip.gotoAndStop(temp);
			mcBase.MasturbateClip._visible = true;
			if (temp != 2) HideBackgrounds();
		}
	}
	
	_root.AppendActText = false;
	
	if (_root.IsDickgirl()) {
		if (_root.LevelUp) {
			switch(_root.LevelMasturbateDG) {
				case -1:
				case 0:
					SetText("You discuss pleasure with #slave in the light of her new bodily changes, you ask her what she does now when she gets excited on her own. \"It gets..you know, but I don't touch it. I'm not a man\" she defiantly tells you. You tell her that she is not a man, but a feminine, desirable hermaphrodite. You explain her cock is part of her and she will have to adjust to it, understand it.\r\r#slave sees the wisdom of this, especially responding to the talk about her femininity. You tell her that she is a good girl and ask her to try touching it a little more after you leave. She agrees.\r\rA little later you hear a muffled cry and when you come back, she is wearing a small smile, and a damp cloth is on the bed in front of her.");
					break;
				case 1:
					SetText(SlaveName + " tells you that when she has desires and her cock stiffens, she also feels her nipples react. You say that this is perfectly normal and tell her to touch her own breasts and nipples, so she can get used to the sensation. \"Now?\" she asks, blushing. Indicating that she should go on, she proceeds to cup her own breasts in her hands, squeezing gently. She reaches to touch her cock and you tell her to only touch her breasts. Feeling her own nipples stiffen, she carefully uses her fingers on them, squeezing her legs together to suppress other sensations rising in her as her cock hardens.");
					break;
				case 2:
					SetText(SlaveName + " complains that the strange urges she sometimes feels don't seem to calm down even when she touches her cock. You tell her that maybe she's not doing it right, and that she had better show you, so you can correct her. At first very hesitant, she eventually agrees. Stripping off her clothes, she curls up, inserting her hand between her legs, carefully stroking her cock, moaning silently. You tell her that you need to take more notes, and as you look she gasps and cums, cum spraying over her chest.\r\rYou mildly scold her, explaining that the purpose here was to arouse herself, not to cum. As you tell her this she wipes the cums from herself, and you notice her taste some of it.");
					break;
				case 3:
					SetText("You begin instructing #slave in masturbation techniques, first of all telling her not to curl up and shield herself like that. If she isn't comfortable with her own body, she won't reach the satisfaction that will calm her immediate urges. Trying to follow your lead, she opens up a little more, giving you the opportunity to better study the way her small fingers play and stroke her cock. You suggest that she touch her pussy as well, slipping a finger in with her other hand.");
					break;
				case 4:
					if (_root.ServantGender != 2) SetText("Calling on your assistant, you order " + _root.ServantHimHer + " to show #slave how #assistantheshe pleasures " + _root.ServantHimHer + "self. When #assistantheshe denies doing that, you remind her how you recently entered her room, finding her rapidly stoking her cock. Both of them blush at that, and your assistant relents. As #assistantheshe spreads " + _root.ServantHisHer + " legs wide for the two of you to see, #assistantheshe proceeds to squeeze and rub " + _root.ServantHisHer + " cock until it becomes erect. " + _root.NameCase(_root.ServantHeShe) + " strokes her cock, until #assistantheshe cries out in orgasm. Instructing #slave to emulate " + _root.ServantHimHer + ", she tries to.");
					else if (_root.Gender != 2) SetText("You show #slave how you pleasure yourself. You spread your legs wide for #slave to see, and proceed rub your cock, soon growing erect. You stroke your cock, until you cry out in climax. Instructing #slave to emulate your demonstration, she tries to.");
					else SetText("Calling in a male slave, you order him to show #slave how he pleasures himself. He spreads his legs wide for the two of you to see, proceeds to rubs his cock until it becomes erect. He strokes his cock, until he cries out in climax. Instructing #slave to emulate him, she tries to.");
					break;
				case 5:
					SetText(SlaveName + " has had repeated practice in pleasuring herself and has carefully watched your ");
					if (_root.ServantGender != 2) AddText("assistant's ");
					else if (_root.Gender != 2) AddText("your");
					else AddText("slave's ");
					AddText("technique. When you tell her to show you, she slowly, almost theatrically spreads her legs wide, then proceeds stroke her already firm cock. You spot the first telltale signs of her growing wetness.\r\rUsing her slim fingers, she plays with both her cock and cunt quite ardently.\r\rGripping one of her breasts, she continues to urgently stroke her cock, soon crying out and cumming many spurts of her cum.\r\rTelling you that she still feels strange urges from her still hard cock, you tell her to go on. Doing so, she turns over, lying on her belly, snaking a hand in between her spread open legs. As she pushes herself up a little on her knees, her cock hanging down, and puts something below her groin. Her fingers hypnotically drive in and out of her pussy, with you having a perfect view. She does not touch her cock until she is moaning in passion. She quickly strokes it and gasps cumming, spurts of cum splattering below with a tinny noise.\r\rShe continues stoking her cock and fingering her pussy and cums several more times. You are satisfied that she knows how to pleasure herself, and in front of others as well. There is no need to teach her more, though it could be fun to watch again.\r\rWhen you say this she sits up and picks up a small bowl and you realise she had been cumming into to each time. She lifts the bowl and slurps and licks up all her cum. Her cock is hard again and she says 'More?'");
					break;
			}
		} else {
			switch(_root.LevelMasturbateDG) {
				case -1:
				case 0:
					SetText("You tell #slave to touch herself in your absence, and soon come back, finding her pleased, a damp cloth soaked in her pleasure. Increasing her trust might allow you to supervise.");
					break;
				case 1:
					SetText("You make #slave play with her own breasts and stiff nipples. As she becomes more turned on and trusting, you will teach her more.");
					break;
				case 2:
					SetText("Trying to pleasure herself in front of you, her technique is uncertain and inadequate. Turning her on and gaining more trust is vital to the training.");
					break;
				case 3:
					SetText("Spreading her legs a little, #slave shows you how she inexperiencedly plays with herself. When she is sufficiently turned on, she may need to be better at taking instructions as well.");
					break;
				case 4:
					if (_root.ServantGender != 2) SetText("First your assistant demonstrates masturbation,");
					else if (_root.Gender != 2) SetText("First you demonstrate masturbation,");
					else SetText("First your slave demonstrates masturbation,");
					AddText(" then #slave tries to emulate. Turning her on should allow her to let herself go completely.");
					break;
				case 5:
					SetText(SlaveName + " expertly masturbates in various positions. She need learn no more about this.");
					break;
			}
		}

	} else {
		if (_root.LevelUp) {
			switch(_root.LevelMasturbate) {
				case -1:
				case 0:
					SetText("Discussing pleasure with #slave, you ask her what she does when she gets excited on her own. \"Nothing,\" she whispers, casting her eyes down. Probing her, it seems that she is serious, not acting on any sexual urges that arise in her. Explaining to her that it can be harmful if she denies her own desires, you go on to tell her that healthy young women pleasure themselves so their feelings won't distract them in their everyday life.\r\r#slave sees the wisdom of this, but is uncertain how one would go about acting on these desires, if one actually had them. Asking her where she might feel these desires, if she has them, she blushes furiously, then hesitantly points towards her crotch. You tell her that she is a good girl and asks her to try touching it a little more after you leave. She agrees. When you come back, she is wearing a small smile.");
					break;
				case 1:
					SetText(SlaveName + " tells you that when she has desires, she also feels her nipples react. You say that this is perfectly normal and tell her to touch her own breasts and nipples, so she can get used to the sensation. \"Now?\" she asks, blushing. Indicating that she should go on, she proceeds to cup her own breasts in her hands, squeezing gently. Feeling her own nipples stiffen, she carefully uses her fingers on them, squeezing her legs together to suppress other sensations rising in her.");
					break;
				case 2:
					SetText(SlaveName + " complains that the strange urges she sometimes feels don't seem to calm down even when she touches herself. You tell her that maybe she's not doing it right, and that she had better show you, so you can correct her. At first very hesitant, she eventually agrees. Stripping off her clothes, she curls up, inserting her hand between her legs, carefully stroking her own pussy, moaning silently. You tell her that you need to take more notes.");
					break;
				case 3:
					SetText("You begin instructing #slave in masturbation techniques, first of all telling her not to curl up and shield herself like that. If she isn't comfortable with her own body, she won't reach the satisfaction that will calm her immediate urges. Trying to follow your lead, she opens up a little more, giving you the opportunity to better study the way her small fingers play with her own wet pussy.");
					break;
				case 4:
					if (_root.ServantGender == 2) SetText("Calling on your assistant, you order her to show #slave how she pleasures herself. When she denies doing that, you remind her how you recently entered her room, finding her with two fingers shoved far up her own wet cunt. Both of them blush at that, and your assistant relents. As she spreads her legs wide for the two of you to see, she proceeds to finger her cunt and clit, soon growing wet. Several fingers vanish into her crack while she rubs her clit, until she cries out in orgasm. Instructing #slave to emulate her, she tries to.");
					else if (_root.Gender == 2) SetText("You show #slave how you pleasure yourself. You spread your legs wide for #slave to see, and proceed to finger your cunt and clit, soon growing wet. Several fingers vanish into your crack while you rub your clit, until you cry out in orgasm. Instructing #slave to emulate your demonstration, she tries to.");
					else SetText("Calling in a female slave, you order her to show #slave how she pleasures herself. She blushes a little and relents. As she spreads her legs wide for the two of you to see, she proceeds to finger her cunt and clit, soon growing wet. Several fingers vanish into her crack while she rubs her clit, until she cries out in orgasm. Instructing #slave to emulate her, she tries to.");
					break;
				case 5:
					SetText(SlaveName + " has had repeated practice in pleasuring herself and has carefully watched your ");
					if (_root.ServantGender == 2) AddText("assistant's ");
					else if (_root.Gender != 2) AddText("slave's ");
					AddText("technique. When you tell her to show you, she slowly, almost theatrically spreads her legs wide, then proceeds to finger herself. You spot the first telltale signs of her growing wetness. Using her slim fingers, she plays with both clit and cunt quite ardently.\r\rGripping one of her breasts, she continues to thrust fingers into herself, soon crying out in orgasm. Telling you that she still feels strange urges, you tell her to go on. Doing so, she turns over, lying on her belly, snaking a hand in between her spread open legs. As she pushes herself up a little on her knees, her fingers hypnotically drive in and out of her, with you having a perfect view.\r\rRepeatedly she comes and start over again in new positions. You are satisfied that she knows how to pleasure herself, and in front of others as well. There is no need to teach her more, though it could be fun to watch again.");
					break;
			}
		} else {
			switch(_root.LevelMasturbate) {
				case -1:
				case 0:
					SetText("You tell #slave to touch herself in your absence, and soon come back, finding her pleased. Increasing her trust might allow you to supervise.");
					break;
				case 1:
					SetText("You make #slave play with her own breasts and stiff nipples. As she becomes more turned on and trusting, you will teach her more.");
					break;
				case 2:
					SetText("Trying to pleasure herself in front of you, her technique is uncertain and inadequate. Turning her on and gaining more trust is vital to the training.");
					break;
				case 3:
					SetText("Spreading her legs a little, #slave shows you how she inexperiencedly plays with herself. When she is sufficiently turned on, she may need to be better at taking instructions as well.");
					break;
				case 4:
					if (_root.ServantGender == 2) SetText("First your assistant demonstrates masturbation,");
					else if (_root.Gender == 2) SetText("First you demonstrate masturbation,");
					else SetText("First your slave demonstrates masturbation,");
					AddText(" then #slave tries to emulate. Turning her on should allow her to let herself go completely.");
					break;
				case 5:
					SetText(SlaveName + " expertly masturbates in various positions. She need learn no more about this.");
					break;
			}
		}
	}
}

public function ShowActPlug()
{
	if (_root.DoDickgirlChange(100)) return;
	mcBase.PlugClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.PlugClip._visible = true;
}

public function ShowSexActPonygirl()
{
	HideBackgrounds();
	mcBase.PonygirlClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
	mcBase.PonygirlClip._visible = true;
}

public function SpankComment() : Boolean
{
	_root.ServantSpeak("She deserves a good spanking and really seems to be enjoying it, she is very wet.", true);
	return true;
}

public function ShowSexActSpank(whip:Boolean)
{
	if (whip) _root.UseGeneric = true;
	if (_root.UseGeneric) return;
	if (Naked || _root.PersonGender != 1) temp = Math.floor(Math.random()*2) + 2;
	else temp = Math.floor(Math.random()*3) + 1;
	ShowMovie(mcBase.SpankClip, 1.1, 1, temp);
}

public function ShowSexActThreesome()
{
	if (_root.Talent == 9 && _root.IsDickgirl()) {
		_root.UseGeneric = true;
		return;
	} else if (_root.IsDickgirl()) mcBase.ThreesomeClip.gotoAndStop(Math.floor(Math.random()*3) + 3);
	else if (Lesbian) mcBase.ThreesomeClip.gotoAndStop(Math.floor(Math.random()*2) + 6);
	else mcBase.ThreesomeClip.gotoAndStop(Math.floor(Math.random()*5) + 1);
	mcBase.ThreesomeClip._visible = true;
}

public function ShowSexActTitFuck()
{
	HideBackgrounds();
	if (Lesbian) {
		_root.UseGeneric = false;
		temp = Math.floor(Math.random()*2) + 3;
		if (temp == 19) {
			SetText("You ask #slave to instead masturbate #assistant. They both look at you with surprise, #assistant especially.\r\rYou insist and #slave moves in but #assistant resists and they start wrestling and writhing. #slave gets her in a hold and rubs her pussy and breasts.\r\r");
			if (_root.VarConstitutionRounded<40) {
				AddText("She is awkward and fails to overpower #assistant. You scold #assistant.");
			} else if (_root.VarConstitutionRounded<55) {
				AddText("She seems to enjoy the struggle and is able to pin #assistant, touching and caressing her and easily brings her to a reluctant orgasm.");
			} else if (_root.VarConstitutionRounded<70) {
				AddText("She enjoys wrestling and easily overpowers #assistant and works expertly to bring her carefully nearer and nearer to orgasm, keeping her there until she begs to cum. #slave brings her to a very strong orgasm.");
			} else {
				AddText("She dominates #assistant and skillfully brings her to orgasm after orgasm, despite her protests.");
			}
		}
	} else {
		temp = 1;
		_root.StartCumSplatter(1000, mcBase.TitsFuckClip, 3, 2);
	}
	ShowMovie(mcBase.TitsFuckClip, 1, 3, temp);
}

public function ShowSexActTouch()
{
	if (_root.DoDickgirlChange(100)) return;

	if (_root.LastActionDone == 2.4) {
		temp = 4;
		_root.AppendActText = false;
		SetText("You order #assistant to caress her to help her accept more women. #assistant starts to protest but reconsiders and agrees\r\r" + SlaveName);
		if (_root.VarSensibilityRounded<15) {
			AddText(" doesn't like this much yet and especially as it is #assistant doing it!");
		} else if (_root.VarSensibilityRounded<50) {
			AddText(" doesn't mind being caressed and seems to tolerate #assistant.");
		} else if (_root.VarSensibilityRounded<80) {
			AddText(" seems to love being caressed. She sometimes looks passionately at you and at #assistant.");
		} else {
			AddText(" almost came just from #assistant's touches and moans her name often.");
		}
	} else if (_root.LastActionDone == 2 || _root.LastActionDone == 2.3) {
		if (Naked) temp = Math.floor(Math.random()*2) + 1;
		else temp = Math.floor(Math.random()*3) + 1;
	} else {
		_root.UseGeneric = true;
		return;
	}
	mcBase.TouchClip.gotoAndStop(temp);
	if (temp == 2) _root.ShowOverlay(0x6F576F);
	mcBase.TouchClip._visible = true;
}

public function ShowTentacleSex(place:Number) : Boolean
{
	if (_root.DoDickgirlChange(30)) return false;
	_root.UseGeneric = false;
	if (_root.IsDickgirl()) mcBase.ClipTentacle.gotoAndStop(6);
	else if (Naked) mcBase.ClipTentacle.gotoAndStop(Math.floor(Math.random()*3) + 3);
	else if (place == 4) mcBase.ClipTentacle.gotoAndStop(Math.floor(Math.random()*4) + 2);
	else if (place == -1) mcBase.ClipTentacle.gotoAndStop(Math.floor(Math.random()*5) + 1);
	else mcBase.ClipTentacle.gotoAndStop(Math.floor(Math.random()*4) + 1);
	mcBase.ClipTentacle._visible = true;
	return false;
}

// Endings

public function ShowEndingCatgirl() : Boolean
{
	Backgrounds.ShowBedRoom();
	ShowMovie(mcBase.EndingCatgirl, 1, 1);
	return true;
}

public function ShowEndingCourtesan()
{
	Backgrounds.ShowBeach();
	mcBase.EndingCourtesan.gotoAndStop(_root.IsDickgirl() ? 2 : 1);
	mcBase.EndingCourtesan._visible = true;
}

public function ShowEndingCowgirl() 
{
	mcBase.EventMilk.gotoAndStop(_root.IsDickgirl() ? 3 : 2);
	mcBase.EventMilk._visible = true;
}

public function ShowEndingBoughtBack()
{
	mcBase.EndingBoughtBack._visible = true;
}

public function ShowEndingDickgirl()
{
	mcBase.EndingDickgirl._visible = true;
}

public function ShowEndingDrugAddict()
{
	Backgrounds.ShowBedRoom();
	mcBase.EndingDrugAddict._visible = true;
}

public function ShowEndingLesbianSlave()
{
	mcBase.EndingLesbianSlave._visible = true;
}

public function ShowEndingMaid()
{
	Backgrounds.ShowBar();
	mcBase.EndingMaid._visible = true;
}

public function ShowEndingMarriage()
{
	_root.ShowOverlay(0xF9F0F2);
	mcBase.EndingMarriage._visible = true;
}

public function ShowEndingNormal()
{
	Backgrounds.ShowBedRoom();
	mcBase.EndingNormal._visible = true;
}

public function ShowEndingNormalMinus()
{
	Backgrounds.ShowBedRoom();
	mcBase.EndingNormalMinus._visible = true;
}

public function ShowEndingNormalPlus()
{
	Backgrounds.ShowBedRoom();
	mcBase.EndingNormalPlus._visible = true;
}

public function ShowEndingProstitute()
{
	_root.ShowOverlay(0);
	mcBase.EndingProstitute._visible = true;
}

public function ShowEndingRebel()
{
	mcBase.EndingRebel._visible = true;
}

public function ShowEndingRich()
{
	mcBase.EndingRich._visible = true;
}

public function ShowEndingSexAddict()
{
	Backgrounds.ShowSchool();
	mcBase.EndingSexAddict._visible = true;
}

public function ShowEndingSexManiac()
{
	Backgrounds.ShowSchool();
	mcBase.EndingSexManiac._visible = true;
}

public function ShowEndingSM()
{
	mcBase.EndingSM._visible = true;
}

public function ShowEndingTentacleSlave()
{
	ShowTentacleSex();
}

public function ShowTentaclePregnancyReveal() : Boolean
{			
	if (_root.IsDickgirl()) mcBase.EventTentaclePregnancy.gotoAndStop(2);
	else mcBase.EventTentaclePregnancy.gotoAndStop(1);
	mcBase.EventTentaclePregnancy._visible = true;
	return true;
}

public function NumCustomEndings() : Number
{
	return 0;
}

// Images

public function HideImages()
{
	mcBase.ClipPunish._visible = false;
	mcBase.ClipNobleLove._visible = false;
	mcBase.ClipContestsBeauty._visible = false;
	mcBase.ClipContestsCourt._visible = false;
	mcBase.ClipContestsXXX._visible = false;
	mcBase.ClipContestsHousework._visible = false;
	mcBase.EventShampooTrouble._visible = false;
	mcBase.ClipSlaveRetrieved._visible = false;
	mcBase.EventMilk._visible = false;
	mcBase.EventNakedApron._visible = false;
	mcBase.EventMorningMouthfull._visible = false;
	mcBase.RefusedAction._visible = false;
	mcBase.Introduction._visible = false;
	mcBase.ClipRaped._visible = false;
	mcBase.ClipDating._visible = false;
	mcBase.ClipLoveAccepted._visible = false;
	mcBase.ClipLoveRefused._visible = false;
	mcBase.ClipLoveConfession._visible = false;
	mcBase.ClipPropositionAccepted._visible = false;
	mcBase.ClipPropositionRefused._visible = false;
	mcBase.ClipTired._visible = false;
	mcBase.EventTentaclePregnancy._visible = false;
	mcBase.EndingDickgirl._visible = false;
	mcBase.EndingLesbianSlave._visible = false;
	mcBase.EndingMaid._visible = false;
	mcBase.EndingCourtesan._visible = false;
	mcBase.EventBreasts._visible = false;
	mcBase.CatgirlTraining._visible = false;
	mcBase.ClipContestsAdvancedHousework._visible = false;
}

public function HideSlaveActions() 
{
	mcBase.BondageClip._visible = false;
    mcBase.AnalClip._visible = false;
	mcBase.CumBathClip._visible = false;
	mcBase.FuckClipa.gotoAndStop(1);
    mcBase.FuckClipa._visible = false;
	mcBase.FuckClipb.gotoAndStop(1);
    mcBase.FuckClipb._visible = false;
	mcBase.TitsFuckClip.gotoAndStop(1);
    mcBase.TitsFuckClip._visible = false;
    mcBase.MasturbateClip._visible = false;
    mcBase.DildoClip._visible = false;
	mcBase.KissClip._visible = false;
    mcBase.LickClip._visible = false;
    mcBase.MasterClip._visible = false;
    mcBase.BlowjobClip._visible = false;
    mcBase.PlugClip._visible = false;
    mcBase.GangBangClip._visible = false;
    mcBase.LendClip._visible = false;
    mcBase.NeedingClip._visible = false;
    mcBase.TouchClip._visible = false;
    mcBase.LesbianClip._visible = false;
	mcBase.SpankClip._visible = false;
    mcBase.AcolyteClip._visible = false;
    mcBase.BarClip._visible = false;
    mcBase.SleazyBarClip._visible = false;
    mcBase.BeautyClip._visible = false;
    mcBase.BrothelClip._visible = false;
    mcBase.RefinementSchoolClip._visible = false;
	mcBase.CookingClip._visible = false;
    mcBase.DanceClip._visible = false;
    mcBase.DiscussClip._visible = false;
    mcBase.ExhibClip._visible = false;
    mcBase.CleaningClip._visible = false;
    mcBase.PromenadeClip._visible = false;
    mcBase.BreakClip._visible = false;
    mcBase.RestaurantClip._visible = false;
    mcBase.SciencesClip._visible = false;
    mcBase.TheologyClip._visible = false;
    mcBase.XXXClip._visible = false;
	mcBase.ClipTentacle._visible = false;
	mcBase.ClipDickgirl._visible = false;
	mcBase.ThreesomeClip._visible = false;
	mcBase.SixtyNineClip._visible = false;
	mcBase.GroupClip._visible = false;
	mcBase.PonygirlClip._visible = false;
	mcBase.JobOnsen._visible = false;
	mcBase.EventMilk._visible = false;
	mcBase.FootjobClip._visible = false;
	mcBase.HandjobClip._visible = false;	
}

public function HidePeople()
{
	mcBase.PeopleDoctor._visible = false;
}

public function HideDresses() 
{
	mcBase.NakedClip._visible = false;
	mcBase.RobePlainClip._visible = false;
	mcBase.Robe1Clip._visible = false;
	mcBase.Robe2Clip._visible = false;
	mcBase.Robe3Clip._visible = false;
	mcBase.Robe4Clip._visible = false;
	mcBase.Robe5Clip._visible = false;
	mcBase.Robe6Clip._visible = false;
}

public function HideEndings()
{
	mcBase.EndingDrugAddict._visible = false;
	mcBase.EndingNormalPlus._visible = false;
	mcBase.EndingSexManiac._visible = false;
	mcBase.EndingMarriage._visible = false;
	mcBase.EndingNormal._visible = false;
	mcBase.EndingSexAddict._visible = false;
	mcBase.EndingProstitute._visible = false;
	mcBase.EndingBoughtBack._visible = false;
	mcBase.EndingRebel._visible = false;
	mcBase.EndingRich._visible = false;
	mcBase.EndingSM._visible = false;
	mcBase.EndingMaid._visible = false;
	mcBase.EndingNormalMinus._visible = false;
	mcBase.EndingLesbianSlave._visible = false;
	mcBase.EndingDickgirl._visible = false;
	mcBase.EndingCourtesan._visible = false;
	mcBase.EventMilk._visible = false;
	mcBase.EndingCatgirl._visible = false;
}

// Startup

public function Initialise()
{
	_root.SetDressDetails(1, "Long Dress");
	_root.SetDressDetails(2, "Chinese Dress");
	_root.SetDressDetails(3, "Country Dress", "Refinement + 10\rSensibility + 5\rEnjoys walks more.");
	_root.SetDressDetails(4, "Kimono");
	_root.SetDressDetails(5, "Gym Clothes", "Refinement + 10\rCharisma + 10\rConstitution + 15");
	_root.SetDressDetails(6, "Mini Skirt", "Charisma + 35, Obedience + 10\rLibido + 15, Nymphomania + 15\rSensibility + 15, Joy + 15\rShe is carefree and energetic.");
	_root.SetDressCourtly(4);
	_root.SetDressEasy(5);
	_root.SetDressEasy(6);
	_root.SetDressSleazyBar(2);
	
	//_root.ShowSpecialStat("Anger :");
	_root.AddCustomJob("Go for Treatment", "visit the Doctor for treatment of her breasts, being milked", "TreatmentJob");

	if (_root.CheckBitFlag2(4)) _root.ShowAct("TreatmentJob");	
}

public function StartGame()
{
	_root.SetBitFlag2(3);
}

public function StartMessage() : Boolean
{
	if (_root.GuildMember) _root.ServantSpeak("The training of #slave will last for " + _root.TrainingTime + " days, and then she will be delivered to her owner.");
	else _root.ServantSpeak("We will train #slave until her stubborn streak is controlled...");
	ShowPerson(3, 0, 1);
	AddText("\r\rAs you are talking there is a knock at your door. Before you can answer it, Miss. N enters the room. She is a friend of yours and has access to your home,\r\r");
	PersonSpeak(3, _root.SlaveMakerName + " Baby, I have heard you are now training Akane. I have a personal favour to ask you, please let me help you to train her. I do not mean as your assistant, I do not have that much free time and I dount you could afford me on a 24 hour a day basis.", true);
	AddText("\r\rShe winks,\r\r");
	PersonSpeak(3, "Anytime you need a woman to partner with Akane I will happily do it. In fact please every time possible if I am free, please?", true);
	AddText("\r\rYou can see this is very important to her, and you can see Akane is blushing. Clearly they have a history together, and you ask,\r\r");
	PersonSpeak(3, "Sorry Baby, this is a matter between Akane and me.", true);
	AddText("\r\rYou wonder why she will not confide in you, she is normally very open, but there are some things she keeps private, particularly her past, so clearly it is tied up with that. You do not press and assure Miss. N you will use her services whenever possible. You start to discuss her fee, and her next words shock you,\r\r");
	PersonSpeak(3, "That is fine, I'll do it for <b>free</b>", true);
	AddText("\r\rWhile you are still stunned, she kisses your cheek and leaves.");
	DoEvent(9999);
	
	return true;
}

public function ShowIntroPage(page:Number) : MovieClip
{
	if (page == 1) coreGame.SetIntroColourARGB(0xF6E7E4);
	else coreGame.SetIntroColourARGB(0xd3d3d3);
	ShowMovie(mcBase.Introduction, 4, page == 1 ? 2 : 3, page);
	return mcBase.Introduction;
}

public function HideIntroPages()
{
	mcBase.Introduction._visible = false;
}


public function InitialiseModule(mcb:MovieClip)
{
	if (mcb == undefined) mcb = mcBase;
	else mcBase = mcb;
	
	HideImages();
	HideSlaveActions();
	HideEndings();
	HideDresses();
}

}