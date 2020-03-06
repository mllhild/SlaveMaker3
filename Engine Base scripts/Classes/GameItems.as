// GameItems - Item overlay images
//
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.display.BitmapData;

class GameItems extends BaseModule {
		
	private var xmlcustomitem:Boolean;		// are custom items enabled for this slave
	
	public var arGameItems:Array;
	
	public var ItemsOver1:MovieClip;
	public var ItemsOver2:MovieClip;
	public var ItemsUnder1:MovieClip;
	public var ItemsUnder2:MovieClip;
	
	// Constructor
	public function GameItems(cg:Object)
	{ 
		super(cg.mcItems, null, cg);
		
		arGameItems = new Array();
		
		ItemsOver1 = coreGame.ItemsOver1;
		ItemsOver2 = coreGame.ItemsOver2;
		ItemsUnder1 = coreGame.ItemsUnder1;
		ItemsUnder2 = coreGame.ItemsUnder2;
		
		ItemsOver1.DressLeash.gotoAndStop(1);
		ItemsOver1.DressLeashCR.gotoAndStop(1);
		ItemsOver1.DressLeashCentered.gotoAndStop(1);
		ItemsOver2.DressLeash.gotoAndStop(1);
		ItemsOver2.DressLeashCR.gotoAndStop(1);
		ItemsOver2.DressLeashCentered.gotoAndStop(1);
		
		ItemsUnder1.DressTail.gotoAndStop(2);
		ItemsUnder1.DressTail.CatTail.gotoAndStop(1);
		ItemsUnder1.DressTail.PuppyTail.gotoAndStop(1);
		ItemsUnder2.DressTail.gotoAndStop(2);
		ItemsUnder2.DressTail.CatTail.gotoAndStop(1);
		ItemsUnder2.DressTail.PuppyTail.gotoAndStop(1);
		ItemsOver1.DressTailOver.CatTail.gotoAndStop(1);
		ItemsOver1.DressTailOver.gotoAndStop(2);
		ItemsOver1.DressTailOver.CatTail.gotoAndStop(1);
		ItemsOver1.DressTailOver.PuppyTail.gotoAndStop(1);
		ItemsOver2.DressTailOver.gotoAndStop(2);
		ItemsOver2.DressTailOver.CatTail.gotoAndStop(1);
		ItemsOver2.DressTailOver.PuppyTail.gotoAndStop(1);
		ItemsUnder1.DressTailCR.gotoAndStop(2);
		ItemsUnder1.DressTailCR.CatTail.gotoAndStop(1);
		ItemsUnder1.DressTailCR.PuppyTail.gotoAndStop(1);
		ItemsUnder2.DressTailCR.gotoAndStop(2);
		ItemsUnder2.DressTailCR.CatTail.gotoAndStop(1);
		ItemsUnder2.DressTailCR.PuppyTail.gotoAndStop(1);
		ItemsOver1.DressTailOverCR.gotoAndStop(2);
		ItemsOver1.DressTailOverCR.CatTail.gotoAndStop(1);
		ItemsOver2.DressTailOverCR.gotoAndStop(2);
		ItemsOver2.DressTailOverCR.CatTail.gotoAndStop(1);
		ItemsOver2.DressTailOverCR.PuppyTail.gotoAndStop(1);
		
		ItemsUnder1.DressTail.gotoAndStop(1);
		ItemsUnder2.DressTail.gotoAndStop(1);
		ItemsUnder1.DressTailCR.gotoAndStop(1);
		ItemsUnder2.DressTailCR.gotoAndStop(1);
		
		ItemsOver1.DressTailOver.gotoAndStop(1);
		ItemsOver1.DressTailOverCR.gotoAndStop(1);
		ItemsOver2.DressTailOverCR.gotoAndStop(1);
		ItemsOver1.DressBitgag.gotoAndStop(1);
		ItemsOver1.DressBitgagCR.gotoAndStop(1);
		ItemsOver1.DressNymphsTiara.gotoAndStop(1);
		ItemsOver1.DressNymphsTiaraCR.gotoAndStop(1);
		ItemsOver1.DressCatEarsOver.gotoAndStop(1);
		ItemsOver1.DressPuppyEarsOver.gotoAndStop(1);
		ItemsOver1.DressCatEarOver.gotoAndStop(1);
		ItemsOver1.DressDevilTailOver.gotoAndStop(1);
		ItemsOver1.DressDevilTailOverCR.gotoAndStop(1);
		ItemsOver1.WingRightOver.gotoAndStop(1);
		ItemsOver1.WingLeftOver.gotoAndStop(1);
		ItemsOver1.WingsOver.WingLeft.gotoAndStop(1);
		ItemsOver1.WingsOver.WingRight.gotoAndStop(1);
		
		ItemsOver2.DressBitgag.gotoAndStop(1);
		ItemsOver2.DressBitgagCR.gotoAndStop(1);
		ItemsOver2.DressNymphsTiara.gotoAndStop(1);
		ItemsOver2.DressNymphsTiaraCR.gotoAndStop(1);
		ItemsOver2.DressCatEarsOver.gotoAndStop(1);
		ItemsOver2.DressPuppyEarsOver.gotoAndStop(1);
		ItemsOver2.DressCatEarOver.gotoAndStop(1);
		ItemsOver2.DressDevilTailOver.gotoAndStop(1);
		ItemsOver2.DressDevilTailOverCR.gotoAndStop(1);
		ItemsOver2.WingsOver.WingLeft.gotoAndStop(1);
		ItemsOver2.WingsOver.WingRight.gotoAndStop(1);
		ItemsOver2.DressTailOver.gotoAndStop(1);
		
		ItemsUnder1.DressCatEars.gotoAndStop(1);
		ItemsUnder2.DressCatEars.gotoAndStop(1);
		ItemsUnder1.DressPuppyEars.gotoAndStop(1);
		ItemsUnder1.DressDevilTail.gotoAndStop(1);
		ItemsUnder1.DressDevilTailCR.gotoAndStop(1);
		ItemsUnder2.DressDevilTail.gotoAndStop(1);
		ItemsUnder2.DressDevilTailCR.gotoAndStop(1);
		ItemsUnder1.WingRight.gotoAndStop(1);
		ItemsUnder1.WingLeft.gotoAndStop(1);
		ItemsUnder2.WingRight.gotoAndStop(1);
		ItemsUnder2.WingLeft.gotoAndStop(1);
		ItemsUnder1.Wings.WingLeft.gotoAndStop(1);
		ItemsUnder1.Wings.WingRight.gotoAndStop(1);
		ItemsUnder2.Wings.WingLeft.gotoAndStop(1);
		ItemsUnder2.Wings.WingRight.gotoAndStop(1);

		
		Reset();
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();
		Reset();
	}
	
	public function Reset()
	{
		xmlcustomitem = false;
		var gi:GameItemState;
		
		for (var so:String in arGameItems) {
			gi = arGameItems[so];
			arGameItems[so] = null;
			delete gi;
		}
		arGameItems = new Array();
	}
	
	public function GetItemState(item:Number) : GameItemState
	{
		var gi:GameItemState;
		for (var so:String in arGameItems) {
			gi = arGameItems[so];
			if (gi.nItem == item) return gi;
		}
		gi = new GameItemState(item);
		arGameItems.push(gi);
		return gi;
	}
	
	
	// Custom Items
	// XML Nodes
	/*
	<Items>
		<Custom1>
			<Name>Detector</Name>
			<Description>
				<AddText>Criminal Detector</AddText>
			</Description>
			<ShowItem>
				<ShowImage image='Images/Slaves/Mihoshi/Item - Detector.jpg' place='0' align='1'/>
			</ShowItem>
		</Custom1>
		
		<OwnItem>50</OwnItem>
	</Items>
	or use <Equipment> node in <Language>
	*/
	public function IsCustomItems() : Boolean { return xmlcustomitem; }
	public function SetCustomItems(sc:Boolean) { xmlcustomitem = (sc != false); }
	
	
	// Show items
		
	private function GetItemMovieClip(item:Object) : MovieClip
	{
		var mc:MovieClip = MovieClip(item);
		if (typeof(item) == "number") {
			mc = null;
			switch(item) {
				case 0: return mcBase.ObjectsLarge;
				case 1: return mcBase.ObjectPonyTail;
				case 2: return SMData.SMFaith == 2 ? mcBase.ObjectOroborusCandle : mcBase.ObjectHalo;
				case 2.1: return mcBase.ObjectHalo;
				case 2.2: return mcBase.ObjectOroborusCandle;
				case 3: return mcBase.ObjectDemonicPendant;
				case 4: return SMData.SMFaith == 2 ? mcBase.ObjectChalice : mcBase.ObjectAngelsTear;
				case 5: return mcBase.ObjectDemonicBra;
				case 6: return mcBase.ObjectVibratorPanties;
				case 7: return mcBase.ObjectLeash;
				case 8: return mcBase.ObjectTiara;
				case 9: return mcBase.ObjectSpikedBracelet;
				case 10: return mcBase.ObjectHandcuffBracelet;
				case 11: return mcBase.ObjectHarness;
				case 12: return mcBase.ObjectDragonRing;
				case 13: return mcBase.ObjectApron;
				case 14: return mcBase.ObjectBitGag;
				case 15: return mcBase.ObjectStrapOn;
				case 16: return mcBase.ObjectFaeriesRing;
				case 17: return mcBase.ObjectNippleChain;
				case 18: return mcBase.ObjectNippleRings;
				case 19: return mcBase.ObjectKey;
				case 20: return mcBase.ObjectTeddyBear;
				case 21: return mcBase.ObjectTrophy;
				case 22: return mcBase.ObjectScroll;
				case 23: return mcBase.ObjectCatEars;
				case 29:
				case 24: return mcBase.ObjectPonyTail;
				case 25: return mcBase.ObjectOfuda;
				case 26: return mcBase.ObjectBEPotion;
				case 40: return mcBase.ObjectEgg;
				case 47: return coreGame.AutoAttachAndPositionMovie("Item - Feeldo (MovieClip)", 0, 0, 0, 0, 0);
			}
		}
		return mc;
	}
	
	private function GetItemNo(item:Object) : Number
	{
		if (typeof(item) == "number") return Number(item);
		
		switch(MovieClip(item)) {
			case mcBase.ObjectsLarge: return 0;
			case mcBase.ObjectPonyTail: return 1;
			case mcBase.ObjectOroborusCandle: return 2;
			case mcBase.ObjectHalo: return 2;
			case mcBase.ObjectDemonicPendant: return 3;
			case mcBase.ObjectChalice: return 4;
			case mcBase.ObjectAngelsTear: return 4;
			case mcBase.ObjectDemonicBra: return 5;
			case mcBase.ObjectVibratorPanties: return 6;
			case mcBase.ObjectLeash: return 7;
			case mcBase.ObjectTiara: return 8;
			case mcBase.ObjectSpikedBracelet: return 9;
			case mcBase.ObjectHandcuffBracelet: return 10;
			case mcBase.ObjectHarness: return 11;
			case mcBase.ObjectDragonRing: return 12;
			case mcBase.ObjectApron: return 13;
			case mcBase.ObjectBitGag: return 14;
			case mcBase.ObjectStrapOn: return 15;
			case mcBase.ObjectFaeriesRing: return 16;
			case mcBase.ObjectNippleChain: return 17;
			case mcBase.ObjectNippleRings: return 18;
			case mcBase.ObjectKey: return 19;
			case mcBase.ObjectTeddyBear: return 20;
			case mcBase.ObjectTrophy: return 21;
			case mcBase.ObjectScroll: return 22;
			case mcBase.ObjectCatEars: return 23;
			case mcBase.ObjectEgg: return 40;
			case mcBase.ObjectOfuda: return 101;
			case mcBase.ObjectBEPotion: return 102;			
		}
		return undefined;
	}
	
	public function HideItem(item:Object)
	{
		var mc:MovieClip = GetItemMovieClip(item);
		// inlined HideItemMC
		mc.stop();
		mc._visible = false;
		var itemno:Number = GetItemNo(item);
		
		coreGame.modulesList.HideItem(itemno, -9);
		if (itemno == 7) {
			coreGame.DressLeash._visible = false;
			coreGame.DressLeashCentered._visible = false;
			coreGame.DressLeashCR._visible = false;
		} else if (itemno == 2) {
			coreGame.DressHalo._visible = false;
			coreGame.DressHaloCR._visible = false;
		}
	}
	
	private function HideItemMC(mc:MovieClip)
	{
		mc.stop();
		mc._visible = false;
	}
	
	function HideItems()
	{
		coreGame.modulesList.HideItems();
		HideItemMC(mcBase.ObjectsLarge);
		HideItemMC(mcBase.ObjectVibratorPanties);
		HideItemMC(mcBase.ObjectDemonicPendant);
		HideItemMC(mcBase.ObjectFaeriesRing);
		HideItemMC(mcBase.ObjectApron);
		HideItemMC(mcBase.ObjectAngelsTear);
		HideItemMC(mcBase.ObjectDragonRing);
		HideItemMC(mcBase.ObjectDemonicBra);
		HideItemMC(mcBase.ObjectLeash);
		HideItemMC(mcBase.ObjectHandcuffBracelet);
		HideItemMC(mcBase.ObjectSpikedBracelet);
		HideItemMC(mcBase.ObjectTiara);
		HideItemMC(mcBase.ObjectHalo);
		HideItemMC(mcBase.ObjectStrapOn);
		HideItemMC(mcBase.ObjectBitGag);
		HideItemMC(mcBase.ObjectHarness);
		HideItemMC(mcBase.ObjectNippleChain);
		HideItemMC(mcBase.ObjectNippleRings);
		HideItemMC(mcBase.ObjectPonyTail);
		HideItemMC(mcBase.ObjectKey);
		HideItemMC(mcBase.ObjectTeddyBear);
		HideItemMC(mcBase.ObjectTrophy);
		HideItemMC(mcBase.ObjectOroborusCandle);
		HideItemMC(mcBase.ObjectChalice);
		HideItemMC(mcBase.ObjectScroll);
		HideItemMC(mcBase.ObjectEgg);
		HideItemMC(mcBase.ObjectCatEars);
		HideItemMC(mcBase.ObjectOfuda);
		HideItemMC(mcBase.ObjectBEPotion);
	}
	
	public function ShowItem(item:Object, placeo:Object, align:Number, gframe:Number)
	{
		var mc:MovieClip = GetItemMovieClip(item);
		coreGame.lastmc = null;
		var itemno:Number = GetItemNo(item);
		
		var place:Number;
		if (typeof(place) == "string") place = coreGame.DecodePlace(String(placeo));
		else if (typeof(place) == "boolean") place = Boolean(placeo) ? 1 : 0;
		else place = Math.abs(Number(placeo));
		if (place == 0) coreGame.HideAllPeople();
		if (itemno == 29) gframe = 4;
		
		if (itemno == 7 && gframe == -1) {
			gframe = 1;
		} else if (coreGame.modulesList.ShowItem(itemno, place, align, gframe)) return;
		if (mc == null) {
			mc = coreGame.lastmc;
			if (mc == null) return;
		}
	
		if (place == 0) {
			if (align == undefined) align = 9;
			ShowMovie(mc, 0, align, gframe);
		} else {
			if (align == 0 || align == 10) ShowMovie(mc, place, align == 0 ? 9 : 10, gframe);
			else {
				if (gframe != undefined) mc.gotoAndStop(gframe);
				mc._xscale = 100;
				mc._yscale = 100;
				var mratio:Number = mc._width / mc._height;
				mc._height = 220;
				mc._width = 220 * mratio;
				if (align == 4) {
					mc._x = 235;
					mc._y = 121;
				} else {
					mc._x = 120;
					mc._y = 55;
				}
				mc._visible = true;
			}
		}
		if (itemno == 6) mc.play();
	}	
	
	public function ShowReading(mco:Object, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, gframe:Number) : MovieClip
	{
		if (rot == undefined) rot = 30;
		if (wid == undefined) wid = 0;
		if (hei == undefined) hei = 0;
		if (xpos == undefined) xpos = 0;
		if (ypos == undefined) ypos = 0;
		if (gframe == undefined) gframe = 1;
		
		ShowMovie(mcBase.ObjectScroll, 1, 0, 3);
		if (typeof(mco) == "string") return coreGame.AutoLoadImageAndPositionMovie(mco, xpos, ypos, rot, wid, hei, mcBase.ObjectScroll.mcBottom);
		
		var mc:MovieClip = MovieClip(mco);
		mc.gotoAndStop(gframe);
		var bmps:BitmapData = new BitmapData(mc._width, mc._height, true, 0);
		bmps.draw(mc);
		var image:MovieClip = mcBase.ObjectScroll.mcBottom.createEmptyMovieClip("Reading" + coreGame.loadednum, mcBase.ObjectScroll.mcBottom.getNextHighestDepth());
		coreGame.loadednum++;

		image.attachBitmap(bmps, image.getNextHighestDepth(), "auto", true);
		coreGame.arAutoLoadedMovieArray.push(image);
		image._visible = true;
		
		coreGame.PositionMovieSimple(image, xpos, ypos, rot, wid, hei)
		return image;
	}
	
	// Wearing/Owning
	
	public function IsItemWorn(item:Number) : Boolean
	{
		// slave
		if (item < 1) return coreGame.slaveData.IsDressWorn(item);
		switch(item) {
			case 1: return coreGame.PonyTailWorn == 1;
			case 2: return coreGame.HaloWorn == 1; 
			case 3: return coreGame.DemonicPendantWorn == 1;
			case 4: return coreGame.AngelsTearWorn == 1;
			case 5: return coreGame.DemonicBraWorn == 1;
			case 6: return coreGame.VibratorPantiesWorn == 1;
			case 7: return coreGame.LeashWorn == 1;
			case 8: return coreGame.NymphsTiaraWorn == 1;
			case 9: return coreGame.SpikedBraceletWorn == 1;
			case 10: return coreGame.HandcuffBraceletWorn == 1;
			case 11: return coreGame.HarnessWorn == 1;
			case 12: return coreGame.DragonRingWorn == 1;
			case 13: return coreGame.ApronWorn == 1;
			case 14: return coreGame.BitGagWorn == 1;
			case 15: return coreGame.StrapOnWorn == 1;
			case 16: return coreGame.FaeriesRingWorn == 1;
			case 17: return coreGame.NippleChainWorn == 1;
			case 18: return coreGame.NippleRingsWorn == 1;
			case 23: return coreGame.CatEarsWorn == 1;
			case 24: return coreGame.CatTailWorn == 1;
		}
		// slave maker
		if (item > 39 && item < 50) return SMData.IsItemWorn(item);

		return coreGame.slaveData.ItemsWorn.CheckBitFlag(item);
	}
	
	function IsItemAvailable(item:Number) : Boolean
	{
		// slave
		if (item <= 0) return coreGame.slaveData.IsDressOwned(item);
		switch(item) {
			case 1: return coreGame.PonyTailOK == 1;
			case 2: return coreGame.HaloOK == 1; 
			case 3: return coreGame.DemonicPendantOK == 1;
			case 4: return coreGame.AngelsTearOK == 1;
			case 5: return coreGame.DemonicBraOK == 1;
			case 6:	return coreGame.VibratorPantiesOK == 1;
			case 7: return coreGame.LeashOK == 1;
			case 8: return coreGame.NymphsTiaraOK == 1;
			case 9: return coreGame.SpikedBraceletOK == 1;
			case 10: return coreGame.HandcuffBraceletOK == 1;
			case 11: return coreGame.HarnessOK > 0;
			case 12: return coreGame.DragonRingOK == 1;
			case 13: return coreGame.ApronOK == 1;
			case 14: return coreGame.BitGagOK == 1;
			case 15: return coreGame.StrapOnOK == 1;
			case 16: return coreGame.FaeriesRingOK == 1;
			case 17: return coreGame.NippleChainOK == 1;
			case 18: return coreGame.NippleRingsOK == 1;
			case 23: return coreGame.CatEarsOK == 1;
			case 24: return coreGame.CatTailOK == 1;
			case 25: return coreGame.LingerieOK == 1;
			case 26: return coreGame.BunnySuitOK == 1;
			case 27: return coreGame.MaidUniformOK == 1;
			case 28: return coreGame.SwimsuitOK == 1;
		}
		
		// slave maker
		if (item > 39 && item < 50) return SMData.IsItemAvailable(item);

		return coreGame.slaveData.ItemsOwned.CheckBitFlag(item);
	}

	
	public function SetItemOwned(item:Number, own:Boolean)
	{
		if (own == undefined) own = true;
		var flg:Number = own ? 1 : 0;
	
		coreGame.slaveData.SetItemOwned(item, own);
		
		switch(item) {
			case 1: coreGame.PonyTailOK = flg; break;
			case 2: coreGame.HaloOK = flg; break; 
			case 3: coreGame.DemonicPendantOK = flg; break;
			case 4: coreGame.AngelsTearOK = flg; break;
			case 5: coreGame.DemonicBraOK = flg; break;
			case 6: coreGame.VibratorPantiesOK = flg; break;
			case 7: coreGame.LeashOK = flg; break;
			case 8: coreGame.NymphsTiaraOK = flg; break;
			case 9: coreGame.SpikedBraceletOK = flg; break;
			case 10: coreGame.HandcuffBraceletOK = flg; break;
			case 11: coreGame.HarnessOK = flg; break;
			case 12: coreGame.DragonRingOK = flg; break;
			case 13: coreGame.ApronOK = flg; break;
			case 14: coreGame.BitGagOK = flg; break;
			case 15: coreGame.StrapOnOK = flg; break;
			case 16: coreGame.FaeriesRingOK = flg; break;
			case 17: coreGame.NippleChainOK = flg; break;
			case 18: coreGame.NippleRingsOK = flg; break;
			case 23: coreGame.CatEarsOK = flg; break;
			case 24: coreGame.CatTailOK = flg; break;
			case 25: coreGame.LingerieOK = flg; break;
			case 26: coreGame.BunnySuitOK = flg; break;
			case 27: coreGame.MaidUniformOK = flg; break;
			case 28: coreGame.SwimsuitOK = flg; break;
		}
		if (item >= 50 && item < 80) coreGame.SelectEquipment.ShowCustomEquipmentButton(item, own);
		else if (item > 39) SMData.SetItemOwned(item, own);
	}
	
	public function ChangeItem(item:Number)
	{
		if (IsItemAvailable(item)) {
			if (item < 1) {
				if (coreGame.DressWorn == Math.abs(item)) coreGame.TakeDressOff();
				else coreGame.PutDressOn(Math.abs(item));
			} else {
				if (IsItemWorn(item)) RemoveItem(item);
				else WearItem(item);
			}
		}
	}
	
	public function WearItem(item:Number)
	{
		Beep();
		if ((item == 1 || item == 24 || item == 30) && coreGame.PlugInserted > 0) {
			Language.XMLData.XMLGeneral("Equipment/AnalPlugWillNotFit");
			//coreGame.SelectEquipment.ShowOtherEquipment();
			Bloop();
			return;
		}
		if (item == 1) {
			if (!coreGame.TestObedience(coreGame.DifficultyPlug)) {
				Language.XMLData.XMLGeneral("Equipment/AnalPlugWillNotUse");
				coreGame.SelectEquipment.ShowOtherEquipment();
				Bloop();
				return;
			}
		}
		
		if (coreGame.modulesList.WearItem(item)) {
			coreGame.HideStatChangeIcons();
			ShowItemDescription(item);
			switch(item) {
				case 2:
					coreGame.Hints.HideHints();
					if (SMData.SMFaith == 2) SetGeneralText(Language.GetHtml("OroburusCandleStopUsing", "Equipment") + "\r\r" + Language.GetHtml("OroborusCandleDescription", "Equipment"));
					break;
				case 5:
					coreGame.Hints.StopHints();
					SetLangText("WearDemonicBra", "Equipment");
					break;
				case 15:
					if (coreGame.HasCock) {
						SlaveSpeak(Language.GetHtml("CannotUseStrapOn", "Equipment"));
						coreGame.SelectEquipment.ShowOtherEquipment();
						Bloop();
						return;
					}
					break;
			}
			coreGame.EquipItem(item);
			coreGame.ShowDress();
		}
	}
	
	public function RemoveItem(item:Number)
	{
		Beep();
		if (coreGame.modulesList.RemoveItem(item)) {
			coreGame.HideStatChangeIcons();
			ShowItemDescription(item);
			switch(item) {
				case 2: 
					coreGame.StopHints();
					if (SMData.SMFaith == 2) SetGeneralText(Language.GetHtml("OroburusCandleUse", "Equipment") + "\r\r" + Language.GetHtml("OroborusCandleDescription", "Equipment"));
					break;
				case 5:
					coreGame.StopHints();
					SetLangGeneralText("RemoveDemonicBra", "Equipment");
					break;
					
			}
			coreGame.UnEquipItem(item);
			coreGame.ShowDress();
		}
	}

	
	public function ShowItemDescription(item:Number)
	{
		if (coreGame.modulesList.ShowItemDescription(item) == true) return;
		
		SetGeneralText("");
		switch(item) {
			case 1: SetLangGeneralText("PonyTailDescription", "Equipment"); break;
			case 2:
				if (SMData.SMFaith == 2) SetLangGeneralText("OroborusCandleDescription", "Equipment");
				else SetLangGeneralText("HaloDescription", "Equipment");
				break;
			case 3: SetGeneralText(coreGame.DemonicPendantDescription); break;
			case 4:
				if (SMData.SMFaith == 2) SetLangGeneralText("TorunsChaliceDescription", "Equipment");
				else SetLangGeneralText("AngelsTearDescription", "Equipment");
				break;
			case 5: SetGeneralText(coreGame.DemonicBraDescription); break;
			case 6: SetLangGeneralText(coreGame.SlaveFemale ? "VibratorPantiesDescriptionFemale" : "VibratorPantiesDescriptionMale", "Equipment"); break;
			case 7:
				if (SMData.PonygirlAware == 1) SetGeneralText(coreGame.LeashPonyDescription);
				else SetGeneralText(coreGame.LeashDescription);
				break;
			case 8: SetLangGeneralText("NymphsTiaraDescription", "Equipment"); break;
			case 9: SetLangGeneralText("SpikedBraceletDescription", "Equipment"); break;
			case 10: SetLangGeneralText("HandcuffBraceletDescription", "Equipment"); break;
			case 11:
				if (coreGame.HarnessOK == 1) SetLangGeneralText("BasicHarnessDescription", "Equipment");
				else SetLangGeneralText("SuperiorHarnessDescription", "Equipment");
				break;
			case 12: SetLangGeneralText("DragonRingDescription", "Equipment"); break;
			case 13: SetLangGeneralText("ApronDescription", "Equipment"); break;
			case 14: SetLangGeneralText("BitGagDescription", "Equipment");	break;
			case 15: SetLangGeneralText("StrapOnDescription", "Equipment"); break;
			case 16: SetLangGeneralText("FaeriesRingDescription", "Equipment"); break;
			case 17: SetLangGeneralText("NippleChainDescription", "Equipment"); break;
			case 18: SetLangGeneralText("NippleRingsDescription", "Equipment"); break;
		}
	}

	
	// General Items
	
	public function FindItemNodeCByIndex(idx:Number, sNode:XMLNode, nn:String, nc:String) : XMLNode
	{
		if (sNode == undefined) sNode = xNode;
		var curr:Number = -1;
		if (nn == undefined) nn = "item";
		else nn = nn.toLowerCase();
		var ar:Array = nn.split("/");
		if (nc == undefined) nc = ar[0] + "s";
		else nc = nc.toLowerCase();				
			
		for (var iNode:XMLNode = Language.XMLData.GetNodeC(sNode, nc); iNode != null; iNode = iNode.nextSibling) {
			if (iNode.nodeType != 1) continue;
			for (var ss:String in ar) {
				if (ar[ss] == iNode.nodeName.toLowerCase()) {
					curr++;
					if (curr == idx) return iNode.firstChild;
					break;
				}
			}
		}
		return null;
	}
	public function FindItemNodeCById(type:Number, sNode:XMLNode, nn:String, nc:String) : XMLNode
	{
		if (sNode == undefined) sNode = xNode;
		var curr:Number = -1;
		if (type == undefined) return null;
		if (nn == undefined) nn = "item";
		else nn = nn.toLowerCase();
		var ar:Array = nn.split("/");
		if (nc == undefined) nc = ar[0] + "s";
		else nc = nc.toLowerCase();		
		var id:Number;
			
		for (var iNode:XMLNode = Language.XMLData.GetNodeC(sNode, nc); iNode != null; iNode = iNode.nextSibling) {
			if (iNode.nodeType != 1) continue;
			for (var ss:String in ar) {
				if (ar[ss] == iNode.nodeName.toLowerCase()) {
					id = Number(iNode.attributes.id);
					if (id == type) return iNode.firstChild;
				}
			}
		}
		return null;
	}	
	
	public function FindItemIdByName(str:String, sNode:XMLNode, nn:String, nc:String) : Number
	{
		if (sNode == undefined) sNode = xNode;
		var curr:Number = -1;
		var nm:String;
		str = str.toLowerCase().split(" ").join("").split("'").join("");
		if (nn == undefined) nn = "item";
		else nn = nn.toLowerCase();
		var ar:Array = nn.split("/");
		if (nc == undefined) nc = ar[0] + "s";
		else nc = nc.toLowerCase();				
		var id:Number;
			
		for (var iNode:XMLNode = Language.XMLData.GetNodeC(sNode, nc); iNode != null; iNode = iNode.nextSibling) {
			if (iNode.nodeType != 1) continue;
			for (var ss:String in ar) {
				if (ar[ss] == iNode.nodeName.toLowerCase()) {
					curr++;
					id = Number(iNode.attributes.id);
					nm = Language.XMLData.GetXMLStringParsed("Name", iNode.firstChild);
					if (nm.toLowerCase().split(" ").join("").split("'").join("") == str) return isNaN(id) ? curr : id;
				}
			}
		}
		return -1;
	}

	public function LoadItemImage(item, place:Number, align:Number, gframe:Number, target:MovieClip, delay:Number, imgCallback:Function, sNode:XMLNode, nn:String, nc:String) : MovieClip
	{
		if (sNode == undefined) sNode = xNode;
		if (nn == undefined) nn = "item";
		else nn = nn.toLowerCase();		
		var wNode:XMLNode;
		if (typeof(item) == "number") wNode = FindItemNodeCById(Number(item), sNode, nn, nc);
		else wNode = item;
		
		var img:String = Language.XMLData.GetXMLStringParsed("Image", wNode);
		wNode = Language.XMLData.GetNode(wNode, "Image");
		
		var mc:MovieClip;
		if (wNode.attributes.attach.toLowerCase() == "true") {
			mc = coreGame.AutoAttachAndShowMovie(img, place, align, gframe, target, delay);
			if (imgCallback != undefined) imgCallback(mc);
		} else mc = AutoLoadImageAndShowMovie(img, place, align, target, delay, imgCallback);
		return mc;
	}
	
	
	public function GetItemNameBase(idx:Number) : String
	{
		switch (idx) {
			case 1: return "PonyTail";
			case 2: return SMData.SMFaith == 2 ? "OroborusCandle" : "Halo";
			case 2.1: return "Halo";
			case 2.2: return "OroborusCandle";
			case 3: return "Demonic Pendant"
			case 4: return SMData.SMFaith == 2 ? "TorunsChalice" : "AngelsTear";
			case 5: return "DemonicBra";
			case 6: return "VibratorPanties";
			case 7: return "Leash";
			case 8: return "Tiara";
			case 9: return "SpikedBracelet";
			case 10: return "HandcuffBracelet";
			case 11: return "Harness";
			case 12: return "DragonRing";
			case 13: return "Apron";
			case 14: return "BitGag";
			case 15: return "StrapOn";
			case 16: return "FaeriesRing";
			case 17: return "NippleChain";
			case 18: return "NippleRings";
			case 19: return "Key";
			case 20: return "TeddyBear";
			case 21: return "Trophy";
			case 22: return "Scroll";
			case 23: return "CatEars";
			case 29:
			case 24: return "CatTail";
			case 25: return "Lingerie";
			case 26: return "BunnySuit";
			case 27: return "MaidUniform";
			case 28: return "Swimsuit";
			case 29: return "PuppyEars";
			case 30: return "PuppyTail";
			case 40: return "Egg";
			case 41: return "LadiesGuide";
			case 42: return "HistoricalTales";
			case 43: return "Ropes";
			case 44: return "SilkenRopes";
			case 45: return "SMNippleRings";
			case 46: return "SMVanityCase";
			case 47: return "Feeldo";
			case 48: return "MasculineLove1";
			case 49: return "MasculineLove2";
		}
		return "";
	}
	
	public function GetItemIdxFromNameBase(str:String) : Number
	{
		switch (str.toLowerCase().split(" ").join("").split("'").join("")) {
			case "ponytail": return 1; 
			case "oroboruscandle" : 
			case "halo":
				return 2;
			case "demonicpendant": return 3;
			case "torunschalice":
			case "angelstear": return 4;
			case "demonicbra": return 5;
			case "vibratorpanties": return 6;
			case "leash": return 7;
			case "nymphstiara":
			case "tiara":
				return 8;
			case "spikedbracelet": return 9;
			case "handcuffbracelet": return 10;
			case "harness": return 11;
			case "dragonring": return 12;
			case "apron": return 13;
			case "bitgag": return 14;
			case "strapon": return 15;
			case "faeriesring": return 16;
			case "nipplechain": return 17;
			case "nipplerings": return 18;
			case "key": return 19;
			case "teddybear": return 20;
			case "trophy": return 21;
			case "scroll": return 22;
			case "catears": return 23;
			case "cattail":	return 24;
			case "lingerie": return 25;
			case "bunnysuit": return 26;
			case "maiduniform": return 27;
			case "swimsuit": return 28;
			case "puppyears": return 29;
			case "puppytail":	return 30;
			case "egg": return 40;
			case "ladiesguide": return 41;
			case "historicaltales": return 42;
			case "ropes": return 43;
			case "silkenropes": return 44;
			case "smnipplerings": return 45;
			case "smvanitycase": return 46;
			case "feeldo": return 47;
			case "masulinelove1": return 48;
			case "masulinelove2": return 49;
		}
		return -1;
	}

}