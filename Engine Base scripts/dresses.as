import Scripts.Classes.*;

var DressTail:MovieClip;
var DressTailCR:MovieClip;
var DressDevilTail:MovieClip;
var DressDevilTailCR:MovieClip;
var WingLeft:MovieClip;
var WingRight:MovieClip;
var Wings:MovieClip;
var DressCatEars:MovieClip;
var DressPuppyEars:MovieClip;
var DressLeash:MovieClip;
var DressLeashCentered:MovieClip;
var DressLeashCR:MovieClip;
var DressHalo:MovieClip;
var DressHaloCR:MovieClip;
var DressBitgag:MovieClip;
var DressBitgagCR:MovieClip;
var DressNymphsTiara:MovieClip;
var DressNymphsTiaraCR:MovieClip;
var DressTailOver:MovieClip;
var DressTailOverCR:MovieClip;
var DressDevilTailOver:MovieClip;
var DressDevilTailOverCR:MovieClip;
var WingLeftOver:MovieClip;
var WingRightOver:MovieClip;
var WingsOver:MovieClip;
var DressCatEarsOver:MovieClip;
var DressPuppyEarsOver:MovieClip;
var DressCatEarOver:MovieClip;


function RemoveDress() {
	HideStatChangeIcons();
	HideDresses();
	if (IsDressSlutty()) Slutiness -= 1;
	var da:Array = null;
	if (DressWorn > 0) {
		var ds:Dress = slaveData.GetDress(DressWorn);
		da = ds.arDressStats;
		if (da != null) PointsMod(-1 * da[0], -1 * da[1], -1 * da[2], -1 * da[3], -1 * da[4], -1 * da[5], -1 * da[6], -1 * da[7], -1 * da[8], -1 * da[9], -1 * da[10], -1 * da[11], -1 * da[12], -1 * da[13], -1 * da[14], -1 * da[15], -1 * da[16], -1 * da[17], -1 * da[18]);
	}
	SlaveGirl.RemoveDress();
	if (DressWorn > 0) {
		if (!XMLEventByNode(GetNode(slaveNode, "Dresses/Dress"+DressWorn+"/RemoveDress"), false, undefined, true, true) && DressWorn == 0) XMLEventByNode(GetNode(slaveNode, "Dresses/DressPlain/RemoveDress"), false, undefined, true, true);
	}
	if (IsDressOwned(0)) DressWorn = 0;
	else if (SMData.IsNakedDressAvailable()) DressWorn = -10;
	else DressWorn = -1;
	slaveData.WearDress(DressWorn);
}

function WearDress(dress:Number) {
	HideStatChangeIcons();
	slaveData.WearDress(dress);
	DressWorn = dress;
	var da:Array = null;
	if (DressWorn > 0) {
		var ds:Dress = slaveData.GetDress(DressWorn);
		da = ds.arDressStats;
		if (da != null) PointsMod(da[0], da[1], da[2], da[3], da[4], da[5], da[6], da[7], da[8], da[9], da[10], da[11], da[12], da[13], da[14], da[15], da[16], da[17], da[18]);
	}
	SlaveGirl.WearDress();
	if (dress >= 0) {
		if (!XMLEventByNode(GetNode(slaveNode, "Dresses/Dress"+DressWorn+"/WearDress"), false, undefined, true, true) && DressWorn == 0) XMLEventByNode(GetNode(slaveNode, "Dresses/DressPlain/WearDress"), false, undefined, true, true);
	}
	if (IsDressCatEars() && CatEarsWorn > 0) UnEquipItem(23);
	if (IsDressCatTail() && CatTailWorn > 0) UnEquipItem(24);
	if (IsDressPuppyEars() && slaveData.ItemsWorn.CheckBitFlag(29)) UnEquipItem(29);
	if (IsDressPuppyTail() && slaveData.ItemsWorn.CheckBitFlag(30) > 0) UnEquipItem(30);

	if (IsDressSlutty()) Slutiness++;

	UpdateSlave();
}

function PutDressOn(dress:Number) {
	if (!IsDressOwned(dress)) return;
	if (SlaveGirl.PutDressOn(dress) == true) return;
	if (DressWorn == -1) {
		ServantSpeak(Language.GetHtml("CannotBeNaked", "Equipment"));
		SelectEquipment.ShowOtherEquipment();
		Bloop();
	} else {
		RemoveDress();
		SlaveGirl.HideImages();  // for Slave Builder - TODO remove
		DressToWear = 0;
		WearDress(dress);
		ShowDress();
	}
}

function TakeDressOff()
{
	if (SlaveGirl.TakeDressOff() == true) return;
	if (!SMData.IsNakedDressAvailable() && !IsDressOwned(0)) {
		Bloop();
		return;
	}
	RemoveDress();
	if (IsDressOwned(0)) DressToWear = 0;
	else if (SMData.IsNakedDressAvailable()) DressToWear = -10;
	else DressToWear = -1;

	WearDress(DressToWear);
	ShowDress();
}

function SwapDress(dress:Number)
{
	if (dress == undefined) {
		if (slaveData.DressSwap != -1000) {
			RemoveDress();
			WearDress(slaveData.DressSwap);
			HideStatChangeIcons();
			slaveData.DressSwap = -1000;
		}
	} else { 
		slaveData.DressSwap = DressWorn;
		RemoveDress();
		WearDress(dress);
		HideStatChangeIcons();
	}
}


// Dress Items

// Halo
function PositionHalo(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	if (HaloWorn == 1 && SMData.SMFaith != 2) {
		if (xpos == undefined) xpos = 230;
		if (ypos == undefined) ypos = 43;
		if (wid == undefined) wid = 163;
		if (hei == undefined) hei = 54;
		DressHalo._visible = false;
		DressHaloCR._visible = true;
		PositionMovieSimple(DressHaloCR, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}


// Gag

function PositionGag(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, cr:Boolean)
{
	if (BitGagWorn == 1) {
		if (cr == true) {
			DressBitgag._visible = false;
			DressBitgagCR._visible = true;
			DressBitgagCR.gotoAndStop(gframe);
			PositionMovieSimple(DressBitgagCR, xpos, ypos, rot, wid, hei);
		} else {
			DressBitgag._visible = true;
			DressBitgag.gotoAndStop(gframe);
			PositionMovie(DressBitgag, xpos, ypos, rot, wid, hei);
		}
		SetLastMovieColour(0, 0, 0);
	}
}

// Leash

function PositionLeash(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, cr:Boolean)
{
	if (LeashWorn == 1) {
		if (cr == true) {
			DressLeash._visible = false;
			DressLeashCR.gotoAndStop(gframe);
			DressLeashCR._visible = true;
			PositionMovieSimple(DressLeashCR, xpos, ypos, rot, wid, hei);
		} else {
			DressLeash.gotoAndStop(gframe);
			DressLeash._visible = true;
			PositionMovie(DressLeash, xpos, ypos, rot, wid, hei);
		}
		SetLastMovieColour(0, 0, 0);
	}
}

// Tail
function PositionTail(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, cr:Boolean, gframe:Number)
{
	if (PlugInserted > 0 || BitFlag1.CheckBitFlag(46) || (DressWorn == 6 && IsSlave("Shampoo"))) {
		if (BitFlag1.CheckBitFlag(46)) {
			var mc:MovieClip = cr == true ? DressDevilTailCR : DressDevilTail;
			mc._visible = true;
			if (cr == true) PositionMovieSimple(mc, xpos, ypos, rot, wid, hei);
			else PositionMovie(mc, xpos, ypos, rot, wid, hei);
		}
		var mc:MovieClip = cr == true ? DressTailCR : DressTail;
		if (PonyTailWorn == 1) mc.gotoAndStop(1);
		else if (CatTailWorn == 1 || (DressWorn == 6 && IsSlave("Shampoo"))) {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(2);
			mc.CatTail.gotoAndStop(gframe);
		} else if (slaveData.ItemsWorn.CheckBitFlag(30)) {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(3);
			mc.PuppyTail.gotoAndStop(gframe);
			
		} else return;
		mc._visible = true;
		if (cr == true) PositionMovieSimple(mc, xpos, ypos, rot, wid, hei);
		else PositionMovie(mc, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

function PositionTailOver(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, cr:Boolean, gframe:Number)
{
	if (PlugInserted > 0 || BitFlag1.CheckBitFlag(46) || (DressWorn == 6 && IsSlave("Shampoo")))	{
		if (BitFlag1.CheckBitFlag(46)) {
			var mc:MovieClip = cr == true ? DressDevilTailOverCR : DressDevilOverTail;
			mc._visible = true;
			if (cr == true) PositionMovieSimple(mc, xpos, ypos, rot, wid, hei);
			else PositionMovie(mc, xpos, ypos, rot, wid, hei);
		}
		var mc:MovieClip = cr == true ? DressTailOverCR : DressTailOver;
		if (PonyTailWorn == 1) mc.gotoAndStop(1);
		else if (CatTailWorn == 1 || (DressWorn == 6 && IsSlave("Shampoo"))) {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(2);
			mc.CatTail.gotoAndStop(gframe);
		} else if (slaveData.ItemsWorn.CheckBitFlag(30)) {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(3);
			mc.PuppyTail.gotoAndStop(gframe);			
		} else return;
		mc._visible = true;
		if (cr == true) PositionMovieSimple(mc, xpos, ypos, rot, wid, hei);
		else PositionMovie(mc, xpos, ypos, rot, wid, hei);
		mc._visible = true;
		SetLastMovieColour(0, 0, 0);
	}
}


function PositionTailSimple(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (PlugInserted > 0 || BitFlag1.CheckBitFlag(46) || (DressWorn == 6 && IsSlave("Shampoo")))	{
		if (BitFlag1.CheckBitFlag(46)) {
			DressDevilTail._visible = true;
			PositionMovieSimple(DressDevilTail, xpos, ypos, rot, wid, hei);
		}
		if (PonyTailWorn == 1) DressTail.gotoAndStop(1);
		else if (CatTailWorn == 1 || (DressWorn == 6 && IsSlave("Shampoo")))  {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(2);
			mc.CatTail.gotoAndStop(gframe);
		} else if (slaveData.ItemsWorn.CheckBitFlag(30))  {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(3);
			mc.PuppyTail.gotoAndStop(gframe);
			
		} else return;
		DressTail._visible = true;
		PositionMovieSimple(DressTail, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

function PositionTailSimpleOver(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (PlugInserted > 0 || BitFlag1.CheckBitFlag(46) || (DressWorn == 6 && IsSlave("Shampoo")))	{
		if (BitFlag1.CheckBitFlag(46)) {
			DressDevilTailOver._visible = true;
			PositionMovieSimple(DressDevilTailOver, xpos, ypos, rot, wid, hei);
		}
		if (PonyTailWorn == 1) DressTailOver.gotoAndStop(1);
		else if (CatTailWorn == 1 || (DressWorn == 6 && IsSlave("Shampoo"))) {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(2);
			mc.CatTail.gotoAndStop(gframe);
		} else if (slaveData.ItemsWorn.CheckBitFlag(30)) {
			if (gframe == undefined) gframe = 1;
			mc.gotoAndStop(3);
			mc.PuppyTail.gotoAndStop(gframe);
			
		} else return;
		DressTailOver._visible = true;
		PositionMovieSimple(DressTailOver, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

// Nymph's Tiara
function PositionNymphsTiara(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, cr:Boolean)
{
	if (NymphsTiaraWorn == 1) {
		if (xpos == undefined) xpos = 223;
		if (ypos == undefined) ypos = 25;
		if (wid == undefined) wid = 40;
		if (hei == undefined) hei = 40;
		var mc:MovieClip = cr == true ? DressNymphsTiaraCR : DressNymphsTiara;
		mc._visible = true;
		if (cr == true) PositionMovieSimple(mc, xpos, ypos, rot, wid, hei);
		else PositionMovie(mc, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}


// Wings
function PositionWings(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (FairyXF > 0 || BitFlag1.CheckBitFlag(50)) { 
		WingRight._visible = false;
		WingLeft._visible = false;
		WingRightOver._visible = false;
		WingLeftOver._visible = false;
		if (FairyXF > 0) gframe = 1;
		else if (gframe == undefined) gframe = 2;

		Wings.WingLeft.gotoAndStop(gframe);
		Wings.WingRight.gotoAndStop(gframe);
		Wings._visible = true;
		PositionMovieSimple(Wings, xpos, ypos, rot, wid, hei);
		var ao:Number = 100;
		if (gframe == 1) ao = ((FairyXF == 2000) ? 100 : ((FairyXF > 100) ? 90 : ((FairyXF < 40) ? 40 : FairyXF)));
		SetLastMovieColour(0, 0, 0, 0, 1, 1, 1, ao / 100);	
	}
}

function PositionWingLeft(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (FairyXF > 0 || BitFlag1.CheckBitFlag(50)) { 
		Wings._visible = false;
		WingOver._visible = false;
		WingLeft._visible = true;
		if (FairyXF > 0) gframe = 1;
		else if (gframe == undefined) gframe = 2;
		WingLeft.gotoAndStop(gframe);
		PositionMovieSimple(WingLeft, xpos, ypos, rot, wid, hei);
		var ao:Number = 100;
		if (gframe == 1) ao = ((FairyXF == 2000) ? 100 : ((FairyXF > 100) ? 90 : ((FairyXF < 40) ? 40 : FairyXF)));
		SetLastMovieColour(0, 0, 0, 0, 1, 1, 1, ao / 100);		
	}
}

function PositionWingRight(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (FairyXF > 0 || BitFlag1.CheckBitFlag(50)) { 
		Wings._visible = false;
		WingOver._visible = false;
		WingRight._visible = true;
		if (FairyXF > 0) gframe = 1;
		else if (gframe == undefined) gframe = 2;
		WingRight.gotoAndStop(gframe);
		PositionMovieSimple(WingRight, xpos, ypos, rot, wid, hei);
		var ao:Number = 100;
		if (gframe == 1) ao = ((FairyXF == 2000) ? 100 : ((FairyXF > 100) ? 90 : ((FairyXF < 40) ? 40 : FairyXF)));
		SetLastMovieColour(0, 0, 0, 0, 1, 1, 1, ao / 100);	
	}
}

function PositionWingsOver(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (FairyXF > 0 || BitFlag1.CheckBitFlag(50)) { 
		WingRight._visible = false;
		WingLeft._visible = false;
		WingRight._visible = false;
		WingRightOver._visible = false;
		WingLeftOver._visible = false;
		if (FairyXF > 0) {
			if (gframe == undefined) gframe = 1;
		} else if (gframe == undefined) gframe = 2;
		WingsOver.WingLeft.gotoAndStop(gframe);
		WingsOver.WingRight.gotoAndStop(gframe);
		WingsOver._visible = true;
		PositionMovieSimple(WingsOver, xpos, ypos, rot, wid, hei, gframe);
		var ao:Number = 100;
		if (gframe == 1) ao = ((FairyXF == 2000) ? 100 : ((FairyXF > 100) ? 90 : ((FairyXF < 40) ? 40 : FairyXF)));
		SetLastMovieColour(0, 0, 0, 0, 1, 1, 1, ao / 100);	
	}
}

function PositionWingLeftOver(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (FairyXF > 0 || BitFlag1.CheckBitFlag(50)) { 
		Wings._visible = false;
		WingOver._visible = false;
		if (FairyXF > 0) {
			if (gframe == undefined) gframe = 1;
		} else if (gframe == undefined) gframe = 2;
		WingLeftOver.gotoAndStop(gframe);
		WingLeftOver._visible = true;
		PositionMovieSimple(WingLeftOver, xpos, ypos, rot, wid, hei);
		var ao:Number = 100;
		if (gframe == 1) ao = ((FairyXF == 2000) ? 100 : ((FairyXF > 100) ? 90 : ((FairyXF < 40) ? 40 : FairyXF)));
		SetLastMovieColour(0, 0, 0, 0, 1, 1, 1, ao / 100);	
	}
}

function PositionWingRightOver(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number)
{
	if (FairyXF > 0 || BitFlag1.CheckBitFlag(50)) { 
		Wings._visible = false;
		WingOver._visible = false;
		if (FairyXF > 0) {
			if (gframe == undefined) gframe = 1;
		} else if (gframe == undefined) gframe = 2;
		
		WingRightOver.gotoAndStop(gframe);
		WingRightOver._visible = true;
		PositionMovieSimple(WingRightOver, xpos, ypos, rot, wid, hei);
		var ao:Number = 100;
		if (gframe == 1) ao = ((FairyXF == 2000) ? 100 : ((FairyXF > 100) ? 90 : ((FairyXF < 40) ? 40 : FairyXF)));
		SetLastMovieColour(0, 0, 0, 0, 1, 1, 1, ao / 100);		
	}
}

// Cat Ears

function PositionCatEars(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	if (CatEarsWorn == 1) {
		DressCatEars._visible = true;
		DressCatEars.gotoAndStop(gframe);
		PositionMovieSimple(DressCatEars, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

function PositionCatEarsOver(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	if (CatEarsWorn == 1) {
		DressCatEarsOver._visible = true;
		DressCatEarsOver.gotoAndStop(gframe);
		PositionMovieSimple(DressCatEarsOver, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

function PositionCatEarOver(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	if (CatEarsWorn == 1) {
		DressCatEarOver._visible = true;
		DressCatEarOver.gotoAndStop(gframe);
		PositionMovieSimple(DressCatEarOver, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

// Puppy Ears
function PositionPuppyEars(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	if (slaveData.ItemsWorn.CheckBitFlag(29)) {
		DressPuppyEars._visible = true;
		DressPuppyEars.gotoAndStop(gframe);
		PositionMovieSimple(DressPuppyEars, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

function PositionPuppyEarsOver(gframe:Number, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	if (slaveData.ItemsWorn.CheckBitFlag(29)) {
		DressPuppyEarsOver._visible = true;
		DressPuppyEarsOver.gotoAndStop(gframe);
		PositionMovieSimple(DressPuppyEarsOver, xpos, ypos, rot, wid, hei);
		SetLastMovieColour(0, 0, 0);
	}
}

// Main Dress Image
function ShowDress(small:Boolean, keeplast:Boolean)
{
	var lastBG:MovieClip = Backgrounds.GetLastBG();
	
	if (small) {
		ShowDressSmall();
		if (keeplast == true) {
			HideBackgrounds();
			lastBG._visible = true;
		}
		return;
	}
	if (DaysUnavailable != 0) {
		if (keeplast != true) Backgrounds.ShowBedRoom();
		SlaveGirl.ShowTired(false);
		if (keeplast == true) {
			HideBackgrounds();
			lastBG._visible = true;
		}
		return;
	}
	HideDressItems(ItemsOver1, ItemsUnder1);
	HideDressItems(ItemsOver2, ItemsUnder2);

	DressHalo._visible = HaloWorn == 1 && SMData.SMFaith != 2;
	DressBitgag._visible = BitGagWorn == 1;
	DressLeash._visible = LeashWorn == 1;
	DressBitgag.gotoAndStop(1);
	DressLeash.gotoAndStop(1);
	if (SlaveDebugging) {
		DressLeash.posx = undefined;
		DressLeashCentered.posx = undefined;
		DressLeashCR.posx = undefined;
		DressHaloCR.posx = undefined;
		DressBitgag.posx = undefined;
		DressBitgagCR.posx = undefined;
		DressTail.posx = undefined;
		DressTailCR.posx = undefined;
		DressTailOver.posx = undefined;
		DressTailOverCR.posx = undefined;
		DressNymphsTiara.posx = undefined;
		DressNymphsTiaraCR.posx = undefined;
		WingLeft.posx = undefined;
		WingRight.posx = undefined;
		Wings.posx = undefined;
		WingLeftOver.posx = undefined;
		WingRightOver.posx = undefined;
		WingsOver.posx = undefined;
		DressCatEars.posx = undefined;
		DressCatEarOver.posx = undefined;
		DressCatEarsOver.posx = undefined;
		DressPuppyEars.posx = undefined;
		DressPuppyEarsOver.posx = undefined;		
	}
	var dsNode:XMLNode;
	
	var ntype:String = "/Normal";
	if (IsDickgirl() && slaveData.ActInfoCurrent.GetDickgirlActCount(13) > 0) ntype = "/Dickgirl";
	if (IsCatgirl() && slaveData.ActInfoCurrent.GetCatgirlActCount(13) > 0) ntype = "/Catgirl";
	
	var DressXMLNode:XMLNode;
	if (Naked) {
		//SlaveGirl.ShowNaked();
		/*
		<NakedChoice1 be10="true" be25="true" be50="true">
			<BitGag image="1" x="100" y="50" rotation="0" width="100" height="50"/>
		</NakedChoice1>
		*/
		dsNode = GetNodeC(slaveNode, "Images");
		DressXMLNode = GetNode(dsNode, "Naked" + ntype + "/NakedChoice" + NakedChoice);
		if (DressXMLNode == null) DressXMLNode = GetNode(dsNode, "Naked/NakedChoice" + NakedChoice);

	} else {
		//SlaveGirl.ShowDress();
		/*
		<Dress1>
			<BitGag image="1" x="100" y="50" rotation="0" width="100" height="50"/>
		</Dress1>
		
		<Dress2>
			<Normal>
				<Frame1 be10="true" be25="true" be50="true">
					<BitGag frame="1" x="XMLEventByNode(100" y="50" rotation="0" width="100" height="50"/>
				</Frame2>
				<Frame1 be10="true" be25="true" be50="true">
					<BitGag frame="1" x="100" y="50" rotation="0" width="100" height="50"/>
				</Frame2>		
			</Normal>
		</Dress2>
		*/
		dsNode = GetNodeC(slaveNode, "Dresses");
		DressXMLNode = GetNode(dsNode, "Dress" + DressWorn + ntype);
		if (DressWorn == 0 && DressXMLNode == null) DressXMLNode = GetNode(dsNode, "DressPlain" + ntype);
		if (DressXMLNode == null) {
			DressXMLNode = GetNode(dsNode, "Dress" + DressWorn);
			if (DressWorn == 0 && DressXMLNode == null) DressXMLNode = GetNode(dsNode, "DressPlain");
		}

	}
	if (DressXMLNode == null) {
		if (Naked) SlaveGirl.ShowNaked();
		else SlaveGirl.ShowDress();
	
		if (dsNode != null) {
			DressBitgag._visible = false;
			DressLeash._visible = false;
			DressHalo._visible = false;
		}
		if (keeplast == true) {
			HideBackgrounds();
			lastBG._visible = true;
		}
		return;
	}
	if (!XMLData.XMLEventByNode(DressXMLNode, false, "Show", true, true)) {
		if (Naked) SlaveGirl.ShowNaked();
		else SlaveGirl.ShowDress();

		if (DressFrame != 0) {
			var fNode:XMLNode = GetNode(DressXMLNode.firstChild, "Image" + DressFrame);
			if (fNode != null) DressXMLNode = fNode;
		}
		PlaceXMLItems(DressXMLNode);
	}
	
	if (keeplast == true) {
		HideBackgrounds();
		lastBG._visible = true;
	}
}

function PlaceXMLItems(dressNode:XMLNode)
{
	var dNode:XMLNode = dressNode.firstChild;
	var asln:Boolean = false;
	var iNode:XMLNode = GetNodeC(dNode, "Slave1");
	if (iNode != null) {
		SetSlave1Items();
		PlaceSlaveXMLItems(iNode);
		asln = true;
	}
	iNode = GetNodeC(dNode, "Slave2");
	if (iNode != null) {
		SetSlave2Items();
		PlaceSlaveXMLItems(iNode);
		asln = true;
	}
	if (!asln) PlaceSlaveXMLItems(dNode);
}

function PlaceSlaveXMLItems(dNode:XMLNode)
{
	var xpos:Number;
	var ypos:Number;
	var irotation:Number;
	var iwidth:Number;
	var iheight:Number;
	var frame:Number;
	var over:Boolean;
	var tint:Number;
	
	function GetPlacement(dNode:XMLNode, node:String, iframe:Number) : Boolean {
		var iNode:XMLNode = GetNode(dNode, node);
		if (iNode == null) {
			iNode = GetNode(dNode.parentNode.parentNode.firstChild, node);
			if (iNode == null) return false;
		}
		xpos = 0;
		ypos = 0;
		irotation = 0;
		iwidth = 0;
		iheight = 0;
		frame = iframe;
		over = false;
		tint = 0;
		for (var attr:String in iNode.attributes) {
			switch(attr.toLowerCase()) {
				case "x": xpos = Number(iNode.attributes[attr]); break;
				case "y": ypos = Number(iNode.attributes[attr]); break;
				case "rotation": irotation = Number(iNode.attributes[attr]); break;
				case "width": iwidth = Number(iNode.attributes[attr]); break;
				case "height": iheight = Number(iNode.attributes[attr]); break;
				case "frame": frame = Number(iNode.attributes[attr]); break;
				case "over": over = iNode.attributes[attr].toLowerCase() == "true"; break;
				case "tint": tint = Number(iNode.attributes[attr]); break;
			}
		}
		if (slaveData.GetWidescreenMode() == 1 && xpos != 0) xpos += 76;
		return true;
	}

	if (GetPlacement(dNode, "BitGag", 1)) {
		PositionGag(frame, xpos, ypos, irotation, iwidth, iheight, true);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	} else DressBitgag._visible = false;
	if (GetPlacement(dNode, "Leash", 1)) {
		PositionLeash(frame, xpos, ypos, irotation, iwidth, iheight, true);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	} else DressLeash._visible = false;
	if (GetPlacement(dNode, "Halo", 1)) {
		PositionHalo(xpos, ypos, irotation, iwidth, iheight);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	} else DressHalo._visible = false;
	if (GetPlacement(dNode, "NymphsTiara", 1)) {
		PositionNymphsTiara(xpos, ypos, irotation, iwidth, iheight, true);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	if (GetPlacement(dNode, "CatEars", 1)) {
		over ? PositionCatEarsOver(frame, xpos, ypos, irotation, iwidth, iheight) : PositionCatEars(frame, xpos, ypos, irotation, iwidth, iheight);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	if (GetPlacement(dNode, "PuppyEars", 1)) {
		over ? PositionPuppyEarsOver(frame, xpos, ypos, irotation, iwidth, iheight) : PositionPuppyEars(frame, xpos, ypos, irotation, iwidth, iheight);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	if (GetPlacement(dNode, "CatEar", 1)) {
		PositionCatEarOver(frame, xpos, ypos, irotation, iwidth, iheight);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	if (GetPlacement(dNode, "Wings", undefined)) {
		over ? PositionWingsOver(xpos, ypos, irotation, iwidth, iheight, frame) : PositionWings(xpos, ypos, irotation, iwidth, iheight, frame);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	if (GetPlacement(dNode, "WingLeft", undefined)) {
		over ? PositionWingLeftOver(frame, xpos, ypos, irotation, iwidth, iheight) : PositionWingLeft(frame, xpos, ypos, irotation, iwidth, iheight);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	if (GetPlacement(dNode, "WingRight", undefined)) {
		over ? PositionWingRightOver(frame, xpos, ypos, irotation, iwidth, iheight) : PositionWingRight(frame, xpos, ypos, irotation, iwidth, iheight);
		if (tint != 0) SetMovieColourARGB(lastmc, tint);
	}
	var tailpos:Boolean = false;
	if (CatTailWorn == 1 || (DressWorn == 6 && IsSlave("Shampoo"))) {
		if (GetPlacement(dNode, "CatTail", 1)) {
			over ? PositionTailOver(xpos, ypos, irotation, iwidth, iheight, true) : PositionTail(xpos, ypos, irotation, iwidth, iheight, true, frame);
			if (tint != 0) SetMovieColourARGB(lastmc, tint);
			tailpos = true;
		}
	} else if (slaveData.ItemsWorn.CheckBitFlag(30))  {
		if (GetPlacement(dNode, "PuppyTail", 1)) {
			over ? PositionTailOver(xpos, ypos, irotation, iwidth, iheight, true) : PositionTail(xpos, ypos, irotation, iwidth, iheight, true, frame);
			if (tint != 0) SetMovieColourARGB(lastmc, tint);
			tailpos = true;
		}	
	} else if (PonyTailWorn == 1) {
		if (GetPlacement(dNode, "PonyTail", 1)) {
			over ? PositionTailOver(xpos, ypos, irotation, iwidth, iheight, true) : PositionTail(xpos, ypos, irotation, iwidth, iheight, true, frame);
			if (tint != 0) SetMovieColourARGB(lastmc, tint);
			tailpos = true;
		}			
	}
	if (!tailpos) {
		if (GetPlacement(dNode, "Tail", 1)) {
			over ? PositionTailOver(xpos, ypos, irotation, iwidth, iheight, true) : PositionTail(xpos, ypos, irotation, iwidth, iheight, true, frame);
			if (tint != 0) SetMovieColourARGB(lastmc, tint);
		}
	}
}

function ParseDresses(aNode:XMLNode, str:String)
{
	if (str == "showdress") {
		var place:Number = DecodePlace(aNode.attributes.place);
		ShowDress(place == 0, true);
	} else if (str == "shownaked") {
		var place:Number = DecodePlace(aNode.attributes.place);
		if (place == 0) ShowNakedSmall();
		else ShowNaked();
	} else if (str == "positiondressitems") PlaceXMLItems(aNode);
	else if (str == "setcustomuniform") {
		var num:Number = Number(aNode.attributes.num);
		slaveData.SetCustomUniform(num, aNode.firstChild.nodeValue);
	} else if (str == "sellcustomuniform") {
		var num:Number = Number(aNode.attributes.num);
		var sell:Boolean = aNode.attributes.sell.toLowerCase() != "false";
		slaveData.SellCustomUniform(num, selle);		
	} else HideDresses();
}


function ShowDressSmall()
{
	HideSupervisor();
	if (SlaveGirl.ShowDressSmall == undefined) SlaveGirl.ShowAsAssistant(1);
	else if (Naked) SlaveGirl.ShowNakedSmall();
	else SlaveGirl.ShowDressSmall();
	PersonShown = -50;
}

function SetSlave1Items()
{
	// over
	DressLeash = ItemsOver1.DressLeash;
	DressLeashCentered = ItemsOver1.DressLeashCR;
	DressLeashCR = ItemsOver1.DressLeashCR;
	DressHalo = ItemsOver1.DressHalo;
	DressHaloCR = ItemsOver1.DressHaloCR;
	DressBitgag = ItemsOver1.DressBitgag;
	DressBitgagCR = ItemsOver1.DressBitgagCR;
	DressNymphsTiara = ItemsOver1.DressNymphsTiara;
	DressNymphsTiaraCR = ItemsOver1.DressNymphsTiaraCR;
	DressTailOver = ItemsOver1.DressTailOver;
	DressTailOverCR = ItemsOver1.DressTailOverCR;
	DressDevilTailOver = ItemsOver1.DressDevilTailOver;
	DressDevilTailOverCR = ItemsOver1.DressDevilTailOverCR;
	WingLeftOver = ItemsOver1.WingLeftOver;
	WingRightOver = ItemsOver1.WingRightOver;
	WingsOver = ItemsOver1.WingsOver;
	DressCatEarsOver = ItemsOver1.DressCatEarsOver;
	DressCatEarOver = ItemsOver1.DressCatEarOver;
	DressPuppyEarsOver = ItemsOver1.DressPuppyEarsOver;
	
	// under
	DressTail = ItemsUnder1.DressTail;
	DressTailCR = ItemsUnder1.DressTailCR;
	DressDevilTail = ItemsUnder1.DressDevilTail;
	DressDevilTailCR = ItemsUnder1.DressDevilTailCR;

	WingLeft = ItemsUnder1.WingLeft;
	WingRight = ItemsUnder1.WingRight;
	Wings = ItemsUnder1.Wings;
	DressCatEars = ItemsUnder1.DressCatEars;
	DressPuppyEars = ItemsUnder1.DressPuppyEars;
}
function SetSlave2Items()
{
	// over
	DressLeash = ItemsOver2.DressLeash;
	DressLeashCentered = ItemsOver2.DressLeashCR;
	DressLeashCR = ItemsOver2.DressLeashCR;
	DressHalo = ItemsOver2.DressHalo;
	DressHaloCR = ItemsOver2.DressHaloCR;
	DressBitgag = ItemsOver2.DressBitgag;
	DressBitgagCR = ItemsOver2.DressBitgagCR;
	DressNymphsTiara = ItemsOver2.DressNymphsTiara;
	DressNymphsTiaraCR = ItemsOver2.DressNymphsTiaraCR;
	DressTailOver = ItemsOver2.DressTailOver;
	DressTailOverCR = ItemsOver2.DressTailOverCR;
	DressDevilTailOver = ItemsOver2.DressDevilTailOver;
	DressDevilTailOverCR = ItemsOver2.DressDevilTailOverCR;
	WingLeftOver = ItemsOver2.WingLeftOver;
	WingRightOver = ItemsOver2.WingRightOver;
	WingsOver = ItemsOver2.WingsOver;
	DressPuppyEarsOver = ItemsOver2.DressPuppyEarsOver;
	DressCatEarsOver = ItemsOver2.DressCatEarsOver;
	DressCatEarOver = ItemsOver2.DressCatEarOver;
	
	// under
	DressTail = ItemsUnder2.DressTail;
	DressTailCR = ItemsUnder2.DressTailCR;
	DressDevilTail = ItemsUnder2.DressDevilTail;
	DressDevilTailCR = ItemsUnder2.DressDevilTailCR;

	WingLeft = ItemsUnder2.WingLeft;
	WingRight = ItemsUnder2.WingRight;
	Wings = ItemsUnder2.Wings;
	DressCatEars = ItemsUnder2.DressCatEars;
	DressPuppyEars = ItemsUnder2.DressPuppyEars;
}

function HideDressItems(mco:MovieClip, mcu:MovieClip) {
	// over
	mco.DressLeash._visible = false;
	mco.DressLeashCentered._visible = false;
	mco.DressLeashCR._visible = false;
	mco.DressHalo._visible = false;
	mco.DressHaloCR._visible = false;
	mco.DressBitgag._visible = false;
	mco.DressBitgagCR._visible = false;
	mco.DressNymphsTiara._visible = false;
	mco.DressNymphsTiaraCR._visible = false;

	mco.DressTailOver._visible = false;
	mco.DressTailOverCR._visible = false;
	mco.DressDevilTailOver._visible = false;
	mco.DressDevilTailOverCR._visible = false;

	mco.WingLeftOver._visible = false;
	mco.WingRightOver._visible = false;
	mco.WingsOver._visible = false;

	mco.DressCatEarsOver._visible = false;
	mco.DressCatEarOver._visible = false;

	mco.DressPuppyEarsOver._visible = false;

	// under
	mcu.DressTail._visible = false;
	mcu.DressTailCR._visible = false;
	mcu.DressDevilTail._visible = false;
	mcu.DressDevilTailCR._visible = false;

	mcu.WingLeft._visible = false;
	mcu.WingRight._visible = false;
	mcu.Wings._visible = false;
	mcu.DressCatEars._visible = false;
	mcu.DressPuppyEars._visible = false;
}

function HideDresses() {	
	HideDressItems(ItemsOver1, ItemsUnder1);
	HideDressItems(ItemsOver2, ItemsUnder2);
	
	DressFrame = 0;
	SlaveGirl.HideRobes();
	SlaveGirl.HideDresses();
	SlaveGirl.HideAsAssistant();
	// inlined HideBackgrounds
	HouseEvents.HideBG();
	Backgrounds.HideBG();
}

// custom uniforms
function SetCustomUniform(num:Number, str:String) { slaveData.SetCustomUniform(num, str); }
function SellCustomUniform(num:Number, sell:Number) { slaveData.SellCustomUniform(num, sell); }
