// BitFlags
//	1 = offer hammer in shop
//  2 = Shampoo got Priapus Draft

#include "../../Common Scripts/common.as"

// General

function IsCatgirl() : Boolean
{
	return false;
}

function DrinkPotion(potion:Number, price:Number, pname:String, say:String) : Boolean
{
	if (potion == 0) {
		// Dickgirl
		switch(int(Math.random()*2)) {
			case 0:
				_root.SetText(SlaveName + " drops to the ground and irresistibly masturbates over and over, cumming all over even into her own mouth.");
				ClipDickgirl.gotoAndStop(1);
				break;
			case 1:
				_root.SetText(SlaveName + " compulsively sucks on her own huge cock, cumming over and over again, swallowing all of her cum.");
				ClipDickgirl.gotoAndStop(2);
				break;

		}
		ClipDickgirl._visible = true;
		_root.Points(0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 0, 0, 0, 4, 0, 0);
		_root.AddText("\r\rAfter a time Astrid joins and they fuck each other.");
		return true;
	}
	return false;
}

function ShowTrainingComplete() : Boolean 
{
	return false;
}

// Assistant

function ShowAsAssistant(type:Number) : Boolean
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

function ShowAsAssistantTentacleSex() : Boolean
{
	ShowTentacleSex();
	_root.ShowMovie(this.ClipTentacle, true, 1);
	return true;
}

function ShowAsAssistantAnal() : Boolean
{
	AnalClip.gotoAndStop(int(Math.random()*2) + 1);
	AnalClip._visible = true;
	return true;
}

function ShowAsAssistantSpanking() : Boolean
{
	SpankClip.gotoAndStop(3);
	SpankClip._visible = true;
	return true;
}

function HideAsAssistant()
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

function InitialiseAsAssistant() : MovieClip {
	HideImages();
	HideSlaveActions();
	HideEndings();
	HideDresses();
	_root.AssistantDescription = "A basic slave girl.";
	return EndingBoughtBack;
}


// Contests

function ShowContestBeauty(total:Number) :Number
{
	ClipContestsBeauty._visible = true;
	return total;
}

function ShowContestCourt(total:Number) : Number
{
	ClipContestsCourt._visible = true;
	return total;
}

function ShowContestHousework(total:Number) : Number
{
	ClipContestsHousework._visible = true;
	return total;
}

function ShowContestPonygirl(total:Number) : Number
{
	ShowSexActPonygirl();
	return total;
}

function ShowContestXXX(total:Number) : Number
{
	if (_root.IsDickgirl()) ClipContestsXXX.gotoAndStop(2);
	else ClipContestsXXX.gotoAndStop(int(Math.random()*2) + 1);
	ClipContestsXXX._visible = true;
	return total;
}


// Dickgirl

function IsDickgirl() : Boolean
{
	return false;
}

function DickgirlPotionOffer()
{
}

function ShowDickgirlTransform() : Boolean
{
	return false;
}

function ShowDickgirlPermanent() : Boolean
{
	return false;
}

function AfterDickgirlPotion(num:Number)
{
}


// Dress

function RemoveDress() {
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

function ShowNaked() {
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

function ShowDress() {
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

function ShowBunnySuit() : Boolean
{
	SleazyBarClip.gotoAndStop(5);
	SleazyBarClip._visible = true;
	return true;
}


function ShowLingerie() : Boolean
{
	SleazyBarClip.gotoAndStop(int(Math.random()*2) + 3);
	SleazyBarClip._visible = true;
	return true;
}

// Events 


function ShowDating()
{
	_root.Backgrounds.ShowBedRoom();
	ClipDating._visible = true;
}

function ShowTired(cum:Boolean)
{
	if (_root.IsDickgirl()) ClipTired.gotoAndStop(2);
	else if (cum || Naked) ClipTired.gotoAndStop(3);
	else ClipTired.gotoAndStop(int(Math.random()*2) + 1);
	ClipTired._visible = true;
}

function ShowPropositionAccepted()
{
	ClipPropositionAccepted._visible = true;
}

function ShowPropositionRefused()
{
	ClipPropositionRefused._visible = true;
}

function ShowRetrieved()
{
	_root.ClipRescue._visible = false;
	_root.ClipRunaway._visible = false;
	if (_root.IsDickgirl()) {
		BondageClip.gotoAndStop(1);
		BondageClip._visible = true;
	} else ClipSlaveRetrieved._visible = true;
}

function ShowRaped() : Boolean
{
	if (_root.DickgirlXF > 0) return false;
	ClipRaped._visible = true;
	return true;
}

function ShowMilkFall() : Boolean
{
	ClipTired._visible = true;
	ClipTired.gotoAndStop(2);
	return true;
}

function ShowMilking()
{
	_root.UseGeneric = true;
}

function ShowMilkEnd() : Boolean
{				
	EventMilk._visible = true;
	return true;
}

function ShowMilkAccident() : Boolean
{				
	ExhibClip.gotoAndStop(3);
	ExhibClip._visible = true;
	return true;
}

function ShowMorningMouthfull() : Boolean
{
	EventMorningMouthfull._visible = true;
	return true;
}

function ShowNakedApron() : Boolean
{
	EventNakedApron._visible = true;
	return true;
}

// Love

function ShowLoveConfession()
{
	_root.Backgrounds.ShowTownCenter();
	ClipLoveConfession._visible = true;
}

function ShowLoveAccepted()  : Boolean
{
	_root.HideBackgrounds();
	ClipLoveConfession._visible = false;
	ClipLoveAccepted._visible = true;
	return false;
}

function ShowLoveRefused()
{
	_root.HideBackgrounds();
	ClipLoveConfession._visible = false;
	ClipLoveRefused._visible = true;
	if (_root.NumEvent == 3) {
		_root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0, -15, -20, 0);
		_root.SetText(SlaveName + " is very sad but at least you don't let your personal likes interfere with your job.");
	}
}


// Daytime

function ShowChoreCleaning()
{
	if (!_root.DoDickgirlChange(33)) CleaningClip._visible = true;
}

function ShowChoreCooking()
{
	if (_root.UseGeneric) return;
	temp = int(Math.random()*2) + 1;
	if (temp == 2) _root.HideBackgrounds();
	CookingClip.gotoAndStop(temp);
	CookingClip._visible = true;
}

function ShowChoreDiscuss()
{
	_root.HideBackgrounds();
	if (Naked) DiscussClip.gotoAndStop(3);
	else DiscussClip.gotoAndStop(int(Math.random()*2) + 1);
	DiscussClip._visible = true;
}
function ShowChoreExpose()
{
	if (_root.DoDickgirlChange(30)) return;
	if (_root.IsDickgirl()) temp = int(Math.random()*2) + 2;
	else temp = int(Math.random()*3) + 1;
	ExhibClip.gotoAndStop(temp);
	ExhibClip._visible = true;
}

function ShowChoreMakeUp() : Boolean {
	var donearoused = false;
	if (Naked) BeautyClip.gotoAndStop(2);
	else BeautyClip.gotoAndStop(1);
	BeautyClip._visible = true;
	return donearoused;
}

function ShowChoreExercise() {
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

function ShowSchoolSciences() {
	SciencesClip._visible = true;
}

function ShowSchoolTheology() {
	TheologyClip._visible = true;
}

function ShowSchoolRefinement() {
	RefinementSchoolClip.gotoAndStop(int(Math.random()*2) + 1);
	RefinementSchoolClip._visible = true;
}

function ShowSchoolDance(donearoused:Boolean) {
	temp = int(Math.random()*2) + 1;
	if (Naked) temp = 3;
	DanceClip.gotoAndStop(temp);
	if (temp == 2) {
		_root.ShowOverlay(0xEFFFFF);
		_root.HideBackgrounds();
	}
	DanceClip._visible = true;
}

function ShowSchoolXXX(doDG:Boolean) : Boolean {
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

function ShowJobRestaurant() : Number {
	if (_root.UseGeneric) return 1;
	temp = int(Math.random()*2) + 1;
	RestaurantClip.gotoAndStop(temp);
	RestaurantClip._visible = true;
	return 1;
}

function ShowJobBar() : Number {
	if (Naked) {
		if (_root.IsDickgirl()) BarClip.gotoAndStop(3);
		else BarClip.gotoAndStop(2);
	} else BarClip.gotoAndStop(1);
	BarClip._visible = true;
	return 1;
}

function ShowJobAcolyte() : Number {
	AcolyteClip._visible = true;
	return 1;
}

function ShowJobSleazyBar(strip:Boolean) : Number {
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

function ShowJobBrothel() : Number {
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

function ShowJobOnsen(wgender:Number) : Number
{
	if (_root.IsDickgirl()) {
		BreakClip.gotoAndStop(4);
		BreakClip._visible = true;
	} else JobOnsen._visible = true;
	return 1;
}

function ShowJobOnsenService(cgender:Number) : Boolean
{
	switch(cgender) {
		case 1:
			BlowjobClip.gotoAndStop(_root.slrandom(4));
			BlowjobClip._visible = true;
			break;
		case 2:
			BlowjobClip.gotoAndStop(5);
			BlowjobClip._visible = true;
			break;
		case 3:
			BlowjobClip.gotoAndStop(_root.slrandom(4));
			BlowjobClip._visible = true;
			break;
	}
	return true;
}

function ShowRefusedAction()
{
	RefusedAction._visible = true;
}

function ShowBreak(sleeping:Boolean) {
	if (_root.IsDickgirl()) {
		if (sleeping) BreakClip.gotoAndStop(1);
		else BreakClip.gotoAndStop((int(Math.random()*2)*2) + 1);
	} else if (Naked || sleeping) BreakClip.gotoAndStop(2);
	else BreakClip.gotoAndStop(int(Math.random()*2) + 1);
	BreakClip._visible = true;
}

// Sex


function ShowSexActNothing() {
	if (_root.IsDickgirl()) temp = 1;
	else if (Naked) temp = 2;
	else temp = int(Math.random()*2) + 1;
	NeedingClip.gotoAndStop(temp);
	if (temp == 2) _root.ShowOverlay(0);
	NeedingClip._visible = true;
}

function ShowSexAct69() {
	if (_root.DoDickgirlChange(100)) return;
	if (Lesbian) SixtyNineClip.gotoAndStop(2);
	else if (_root.UseGeneric) return;
	else SixtyNineClip.gotoAndStop(1);
	SixtyNineClip._visible = true;
}

function ShowSexActAnal() {
	if (_root.DoDickgirlChange(40)) return;
	if (_root.IsDickgirl()) AnalClip.gotoAndStop(4);
	else if (Lesbian) {
		if (DefaultLesbian(50)) return;
		AnalClip.gotoAndStop(1);
	} else AnalClip.gotoAndStop(int(Math.random()*3) + 1);
	_root.HideBackgrounds();
	AnalClip._visible = true;
}

function ShowSexActBlowjob() {
	if (Lesbian) {
		if (DefaultLesbian(33)) return;
		temp = 5;
	} else temp = int(Math.random()*4) + 1;
	_root.HideBackgrounds();
	BlowjobClip.gotoAndStop(temp);
	BlowjobClip._visible = true;
}

function ShowSexActBondage() {
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
}

function ShowSexActCumBath() : Boolean {
	GangBangClip.gotoAndStop(3);
	GangBangClip._visible = true;
	return true;
}

function ShowSexActDildo() {
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

function ShowSexActFuck() {
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

function ShowSexActGangBang() {
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

function ShowSexActGroup() {
	if (Lesbian) {
		if (_root.UseGeneric) return;
		GroupClip.gotoAndStop(3);
		_root.HideBackgrounds();
	} else if (_root.DoDickgirlChange(100)) return;
	else GroupClip.gotoAndStop(int(Math.random()*2) + 1);
	GroupClip._visible = true;
}

function ShowSexActKiss() : Boolean {
	if (((_root.SexAction == 23.1 || _root.SexAction == 23) && _root.Gender == 1) || (_root.SexAction == 23.2 && _root.Gender == 2)) {
		// male
		KissClip._visible = true;
	} else {
		// female
		EndingLesbianSlave._visible = true;
	}
	return true;
}

function ShowSexActLendHer() : String {
	if (Lesbian) temp = 3;
	else if (_root.IsDickgirl()) temp = 2;
	else temp = int(Math.random()*2) + 1;
	LendClip.gotoAndStop(temp);
	if (temp == 2) _root.HideBackgrounds();
	LendClip._visible = true;
	return "";
}

function ShowSexActLesbian() {
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

function ShowSexActLick() {
	if (_root.DoDickgirlChange(40)) return;

	LickClip.gotoAndStop(temp);
	LickClip._visible = true;
}

function ShowSexActMaster() {
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

function ShowSexActMasturbate() {
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

function ShowSexActNaked() { }

function ShowSexActPlug()
{
	if (_root.DoDickgirlChange(100)) return;
	PlugClip._visible = true;
}

function ShowSexActPonygirl()
{
	_root.ShowOverlay(0xF1FADB);
	PonygirlClip._visible = true;
}

function ShowSexActSpank(whip:Boolean)
{
	if (whip) _root.UseGeneric = true;
	if (_root.UseGeneric) return;
	if (Naked || _root.Gender != 1) SpankClip.gotoAndStop(int(Math.random()*2) + 2);
	else SpankClip.gotoAndStop(int(Math.random()*3) + 1);
	SpankClip._visible = true;
}

function ShowSexActThreesome()
{
	if (_root.Talent == 9 && _root.IsDickgirl()) {
		_root.UseGeneric = true;
		return;
	} else if (_root.IsDickgirl()) ThreesomeClip.gotoAndStop(int(Math.random()*3) + 3);
	else if (Lesbian) ThreesomeClip.gotoAndStop(6);
	else ThreesomeClip.gotoAndStop(int(Math.random()*5) + 1);
	ThreesomeClip._visible = true;
}

function ShowSexActTitFuck()
{
	_root.HideBackgrounds();
	if (Lesbian) {
		_root.UseGeneric = false;
		temp = int(Math.random()*2) + 18;
		TitsFuckClip.gotoAndStop(temp);
	} else TitsFuckClip.gotoAndPlay(1);
	TitsFuckClip._visible = true;
}

function ShowSexActTouch()
{
	if (_root.DoDickgirlChange(100)) return;

	 if (_root.SexAction == 2 || _root.SexAction == 2.3) {
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

function ShowTentacleSex(place:Number) : Boolean
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

function ShowEndingCourtesan()
{
	_root.Backgrounds.ShowBeach();
	EndingCourtesan._visible = true;
}

function ShowEndingCowgirl() 
{
	ShowMilking();
}

function ShowEndingBoughtBack()
{
	EndingBoughtBack._visible = true;
}

function ShowEndingDickgirl()
{
	EndingDickgirl._visible = true;
}

function ShowEndingDrugAddict()
{
	_root.Backgrounds.ShowBedRoom();
	EndingDrugAddict._visible = true;
}

function ShowEndingLesbianSlave()
{
	EndingLesbianSlave._visible = true;
}

function ShowEndingMaid()
{
	_root.Backgrounds.ShowBar();
	EndingMaid._visible = true;
}

function ShowEndingMarriage()
{
	_root.ShowOverlay(0xF9F0F2);
	EndingMarriage._visible = true;
}

function ShowEndingNormal()
{
	_root.Backgrounds.ShowBedRoom();
	EndingNormal._visible = true;
}

function ShowEndingNormalMinus()
{
	_root.Backgrounds.ShowBedRoom();
	EndingNormalMinus._visible = true;
}

function ShowEndingNormalPlus()
{
	_root.Backgrounds.ShowBedRoom();
	EndingNormalPlus._visible = true;
}

function ShowEndingProstitute()
{
	_root.ShowOverlay(0);
	EndingProstitute._visible = true;
}

function ShowEndingRebel()
{
	EndingRebel._visible = true;
}

function ShowEndingRich()
{
	EndingRich._visible = true;
}

function ShowEndingSexAddict()
{
	_root.Backgrounds.ShowSchool();
	EndingSexAddict._visible = true;
}

function ShowEndingSexManiac()
{
	_root.Backgrounds.ShowSchool();
	EndingSexManiac._visible = true;
}

function ShowEndingSM()
{
	_root.ShowOverlay(0x36214b);
	EndingSM._visible = true;
}

function ShowEndingTentacleSlave()
{
	ShowTentacleSex();
}

function ShowTentaclePregnancyReveal() : Boolean
{			
	if (_root.DickgirlXF > 0) EventTentaclePregnancy.gotoAndStop(2);
	else EventTentaclePregnancy.gotoAndStop(1);
	EventTentaclePregnancy._visible = true;
	return true;
}

function NumCustomEndings() : Number
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
	JobOnsen._visible = false;
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

function Initialise() {
	_root.SetGirlsVitals("Slave Girl", "the basic girl", 85, 55, 87, 19, "O", 163, 50);

	
	_root.SetDressDetails(1, "Long Dress");
	_root.SetDressDetails(2, "Short Dress");
	_root.SetDressDetails(3, "Country Dress", "Refinement + 10\rSensibility + 5\rEnjoys walks more.");
	_root.SetDressDetails(4, "Kimono", "Refinement + 10\rCharisma + 10\rSensibility + 10");
	_root.SetDressDetails(5, "Gym Clothes", "Refinement + 10\rCharisma + 10\rConstitution + 15");
	_root.SetDressDetails(6, "Mini Skirt", "Charisma + 35, Obedience + 10\rLibido + 15, Nymphomania + 15\rSensibility + 15, Joy + 15\rShe is carefree and energetic.");
	_root.SetDressCourtly(4);
	_root.SetDressEasy(5);
	_root.SetDressEasy(6);
	
	_root.Milkable = true;
	_root.SlaveLikeServant = false;
	_root.SlaveAttitude = 2;
}

function StartGame()
{
	_root.TrainingTime = 60;
	
    _root.VarCharisma = 10;
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
    _root.VarObedience = 0;
    _root.VarLibido = 0;
    _root.VarReputation = 0;
    _root.VarFatigue = 0;
	_root.MaxObedience = 90;
    _root.VarJoy = 0;

    _root.VarLovePoints = 0;
    _root.DifficultyXXX = 50;
	_root.DifficultyXXXContest = 35;
    _root.DifficultyExhib = 40;
    _root.DifficultySleazyBar = 25;
    _root.DifficultyBrothel = 75;
    _root.DifficultyTouch = 0;
    _root.DifficultyLick = 5;
    _root.DifficultyFuck = 10;
    _root.DifficultyBlowjob = 12;
    _root.DifficultyTitsFuck = 12;
    _root.DifficultyAnal = 0;
    _root.DifficultyMasturbate = 0;
    _root.DifficultyDildo = 40;
    _root.DifficultyPlug = 50;
    _root.DifficultyLesbian = 50;
    _root.DifficultyBondage = 50;
    _root.DifficultyNaked = 65;
    _root.DifficultyMaster = 65;
    _root.DifficultyGangBang = 75;
    _root.DifficultyLendHer = 90;
	_root.DifficultyPonygirl = 65;
	_root.DifficultySpank = 30;
	_root.DifficultyThreesome = 20;
	
	_root.IntroPages = 2;
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
JobOnsen.gotoAndStop(1);
Introduction.gotoAndStop(1);
HideImages();
HideSlaveActions();
HideEndings();
HideDresses();
stop();