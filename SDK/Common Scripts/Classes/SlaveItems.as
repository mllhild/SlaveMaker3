// Slave - class defining a specific slave or assistant 
// This is the full slave version
// Translation status: COMPLETE

import Scripts.Classes.*;

class SlaveItems extends SMSlaveCommon {

	// Items
	public var HarnessOK:Number;
	public var NymphsTiaraOK:Number;
	public var SpikedBraceletOK:Number;
	public var HaloOK:Number;
	public var HandcuffBraceletOK:Number;
	public var AngelsTearOK:Number;
	public var DemonicBraOK:Number;
	public var VibratorPantiesOK:Number;
	public var FaeriesRingOK:Number;
	public var DragonRingOK:Number;
	public var DemonicPendantOK:Number;
	public var ApronOK:Number;
	public var StrapOnOK:Number;
	public var BitGagOK:Number;
	public var PonyTailOK:Number;
	public var CatTailOK:Number;
	public var CatEarsOK:Number;
	public var NippleChainOK:Number;
	public var NippleRingsOK:Number;
	public var SpikedBraceletWorn:Number;
	public var NymphsTiaraWorn:Number;
	public var DemonicBraWorn:Number;
	public var AngelsTearWorn:Number;
	public var VibratorPantiesWorn:Number;
	public var FaeriesRingWorn:Number;
	public var DragonRingWorn:Number;
	public var DemonicPendantWorn:Number;
	public var LeashWorn:Number;
	public var ApronWorn:Number;
	public var StrapOnWorn:Number;
	public var BitGagWorn:Number;
	public var HarnessWorn:Number;
	public var PonyTailWorn:Number;
	public var CatTailWorn:Number;
	public var CatEarsWorn:Number;
	public var HandcuffBraceletWorn:Number;
	public var HaloWorn:Number;
	public var NippleChainWorn:Number;
	public var NippleRingsWorn:Number;
	public var PiercingsType:Number;
	public var VanityCaseOK:Number;
	public var PonyCartOK:Number;
	public var PonyBootsOK:Number;
	public var DildoOK:Number;
	public var ImprovedDildoOK:Number;
	public var PlugOK:Number;
	public var TrophyOK:Number;
	public var SmallTrophyOK:Number;
	public var LeashOK:Number;

	public var TotalTeddyBear:Number;
	public var TotalGames:Number;
	public var TotalJewelry:Number;
	public var TotalDoll:Number;
	
	public var TotalBooksRead:Number;
	public var TotalPoetryRead:Number;
	public var TotalScrollsRead:Number;
	public var TotalScriptureRead:Number;
	public var TotalKamasutraRead:Number;

	public var ItemsOwned:BitFlags;
	public var ItemsWorn:BitFlags;

	public var DurationHairCare:Number;
	public var DurationFacialCare:Number;
	public var DurationMakeupCare:Number;
	
	// Methods

	// Constructor
	public function SlaveItems(cg:Object) {
		super(cg);
		Reset();
	}
	// Initialise all variables for the slave
	public function Reset() {
		
		super.Reset();
		
		HarnessOK = 0;
		NymphsTiaraOK = 0;
		SpikedBraceletOK = 0;
		HaloOK = 0;
		HandcuffBraceletOK = 0;
		AngelsTearOK = 0;
		DemonicBraOK = 0;
		VibratorPantiesOK = 0;
		FaeriesRingOK = 0;
		DragonRingOK = 0;
		DemonicPendantOK = 0;
		ApronOK = 0;
		StrapOnOK = 0;
		BitGagOK = 0;
		PonyTailOK = 0;
		CatTailOK = 0;
		CatEarsOK = 0;
		NippleChainOK = 0;
		NippleRingsOK = 0;
		SpikedBraceletWorn = 0;
		NymphsTiaraWorn = 0;
		DemonicBraWorn = 0;
		AngelsTearWorn = 0;
		VibratorPantiesWorn = 0;
		FaeriesRingWorn = 0;
		DragonRingWorn = 0;
		DemonicPendantWorn = 0;
		LeashWorn = 0;
		ApronWorn = 0;
		StrapOnWorn = 0;
		BitGagWorn = 0;
		HarnessWorn = 0;
		PonyTailWorn = 0;
		CatTailWorn = 0;
		CatEarsWorn = 0;
		HandcuffBraceletWorn = 0;
		HaloWorn = 0;
		NippleChainWorn = 0;
		NippleRingsWorn = 0;
		PiercingsType = 0;
		VanityCaseOK = 0;
		PonyCartOK = 0;
		PonyBootsOK = 0;
		DildoOK = 0;
		ImprovedDildoOK = 0;
		PlugOK = 0;
		TrophyOK = 0;
		SmallTrophyOK = 0;
		LeashOK = 0;
		ItemsOwned = null;
		ItemsWorn = null;

		TotalTeddyBear = 0;
		TotalGames = 0;
		TotalJewelry = 0;
		TotalDoll = 0;
		
		TotalBooksRead = 0;
		TotalPoetryRead = 0;
		TotalScrollsRead = 0;
		TotalScriptureRead = 0;
		TotalKamasutraRead = 0;
		
		DurationHairCare = 0;
		DurationFacialCare = 0;
		DurationMakeupCare = 0;
	}
	
	
	// Copy data from/to this object
	// sdFrom and sdTo can be Object types (for load/save cases(
	public function CopyCommonDetails(sdFrom:Object, sdTo:Object)
	{
		super.CopyCommonDetails(sdFrom, sdTo);

		sdTo.NymphsTiaraOK = sdFrom.NymphsTiaraOK;
		sdTo.SpikedBraceletOK = sdFrom.SpikedBraceletOK;
		sdTo.DemonicBraOK = sdFrom.DemonicBraOK;
		sdTo.HaloOK = sdFrom.HaloOK;
		sdTo.HandcuffBraceletOK = sdFrom.HandcuffBraceletOK;
		sdTo.AngelsTearOK = sdFrom.AngelsTearOK;
		sdTo.VibratorPantiesOK = sdFrom.VibratorPantiesOK;
		sdTo.FaeriesRingOK = sdFrom.FaeriesRingOK;
		sdTo.DragonRingOK = sdFrom.DragonRingOK;
		sdTo.DemonicPendantOK = sdFrom.DemonicPendantOK;
		sdTo.LeashOK = sdFrom.LeashOK;
		sdTo.ApronOK = sdFrom.ApronOK;
		sdTo.StrapOnOK = sdFrom.StrapOnOK;
		sdTo.BitGagOK = sdFrom.BitGagOK;
		sdTo.HarnessOK = sdFrom.HarnessOK;
		sdTo.PonyTailOK = sdFrom.PonyTailOK;
		sdTo.CatTailOK = sdFrom.CatTailOK;
		sdTo.CatEarsOK = sdFrom.CatEarsOK;
		
		sdTo.SpikedBraceletWorn = sdFrom.SpikedBraceletWorn;
		sdTo.NymphsTiaraWorn = sdFrom.NymphsTiaraWorn;
		sdTo.DemonicBraWorn = sdFrom.DemonicBraWorn;
		sdTo.AngelsTearWorn = sdFrom.AngelsTearWorn;
		sdTo.VibratorPantiesWorn = sdFrom.VibratorPantiesWorn;
		sdTo.FaeriesRingWorn = sdFrom.FaeriesRingWorn;
		sdTo.DragonRingWorn = sdFrom.DragonRingWorn;
		sdTo.DemonicPendantWorn = sdFrom.DemonicPendantWorn;
		sdTo.LeashWorn = sdFrom.LeashWorn;
		sdTo.ApronWorn = sdFrom.ApronWorn;
		sdTo.StrapOnWorn = sdFrom.StrapOnWorn;
		sdTo.BitGagWorn = sdFrom.BitGagWorn;
		sdTo.HarnessWorn = sdFrom.HarnessWorn;
		sdTo.PonyTailWorn = sdFrom.PonyTailWorn;
		sdTo.CatTailWorn = sdFrom.CatTailWorn;
		sdTo.CatEarsWorn = sdFrom.CatEarsWorn;		
		sdTo.HandcuffBraceletWorn = sdFrom.HandcuffBraceletWorn;
		sdTo.HaloWorn = sdFrom.HaloWorn;
		sdTo.NippleChainOK = sdFrom.NippleChainOK;
		sdTo.NippleRingsOK = sdFrom.NippleRingsOK;
		sdTo.NippleChainWorn = sdFrom.NippleChainWorn;
		sdTo.NippleRingsWorn = sdFrom.NippleRingsWorn;
		sdTo.DildoOK = sdFrom.DildoOK;
		sdTo.ImprovedDildoOK = sdFrom.ImprovedDildoOK;
		sdTo.PlugOK = sdFrom.PlugOK;
		sdTo.PonyCartOK = sdFrom.PonyCartOK;
		sdTo.PonyBootsOK = sdFrom.PonyBootsOK;
		sdTo.TrophyOK = sdFrom.TrophyOK;
		sdTo.SmallTrophyOK = sdFrom.SmallTrophyOK;
		sdTo.VanityCaseOK = sdFrom.VanityCaseOK;

		sdTo.PiercingsType = sdFrom.PiercingsType;

		sdTo.TotalTeddyBear = sdFrom.TotalTeddyBear;
		sdTo.TotalGames = sdFrom.TotalGames;
		sdTo.TotalJewelry = sdFrom.TotalJewelry;
		sdTo.TotalDoll = sdFrom.TotalDoll;

		sdTo.TotalBooksRead = sdFrom.TotalBooksRead;
		sdTo.TotalPoetryRead = sdFrom.TotalPoetryRead;
		sdTo.TotalScrollsRead = sdFrom.TotalScrollsRead;
		sdTo.TotalScriptureRead = sdFrom.TotalScriptureRead;
		sdTo.TotalKamasutraRead = sdFrom.TotalKamasutraRead;
		
		// from DressCommon
		sdTo.DressWorn = sdFrom.DressWorn;
		sdTo.NakedChoice = sdFrom.NakedChoice;
		sdTo.DressToWear = sdFrom.DressToWear;

		sdTo.BunnySuitOK = sdFrom.BunnySuitOK;
		sdTo.LingerieOK = sdFrom.LingerieOK;
		sdTo.MaidUniformOK = sdFrom.MaidUniformOK;
		sdTo.SwimsuitOK = sdFrom.SwimsuitOK;
		sdTo.SellBunnySuit = sdFrom.SellBunnySuit;
		sdTo.SellLingerie = sdFrom.SellLingerie;
		sdTo.SellMaidUniform = sdFrom.SellMaidUniform;
		sdTo.SellSwimsuit = sdFrom.SellSwimsuit;

		sdTo.DurationHairCare = sdFrom.DurationHairCare;
		sdTo.DurationFacialCare = sdFrom.DurationFacialCare;
		sdTo.DurationMakeupCare = sdFrom.DurationMakeupCare;
	}
	
	// Items

	public function IsItemWorn(item:Number) : Boolean
	{
		if (item < 1) return DressWorn == (item * -1);
			
		switch(item) {
			case 1: return PonyTailWorn == 1;
			case 2: return HaloWorn == 1; 
			case 3: return DemonicPendantWorn == 1;
			case 4: return AngelsTearWorn == 1;
			case 5: return DemonicBraWorn == 1;
			case 6:	return VibratorPantiesWorn == 1;
			case 7: return LeashWorn == 1;
			case 8: return NymphsTiaraWorn == 1;
			case 9: return SpikedBraceletWorn == 1;
			case 10: return HandcuffBraceletWorn == 1;
			case 11: return HarnessWorn == 1;
			case 12: return DragonRingWorn == 1;
			case 13: return ApronWorn == 1;
			case 14: return BitGagWorn == 1;
			case 15: return StrapOnWorn == 1;
			case 16: return FaeriesRingWorn == 1;
			case 17: return NippleChainWorn == 1;
			case 18: return NippleRingsWorn == 1;
			case 23: return CatEarsWorn == 1;
			case 24: return CatTailWorn == 1;
		}
		return ItemsWorn.CheckBitFlag(item);
	}
	
	public function IsItemAvailable(item:Number) : Boolean
	{
		if (item <= 0) return IsDressOwned(item * -1);
		switch(item) {
			case 1: return PonyTailOK == 1;
			case 2: return HaloOK == 1; 
			case 3: return DemonicPendantOK == 1;
			case 4: return AngelsTearOK == 1;
			case 5: return DemonicBraOK == 1;
			case 6:	return VibratorPantiesOK == 1;
			case 7: return LeashOK == 1;
			case 8: return NymphsTiaraOK == 1;
			case 9: return SpikedBraceletOK == 1;
			case 10: return HandcuffBraceletOK == 1;
			case 11: return HarnessOK > 0;
			case 12: return DragonRingOK == 1;
			case 13: return ApronOK == 1;
			case 14: return BitGagOK == 1;
			case 15: return StrapOnOK == 1;
			case 16: return FaeriesRingOK == 1;
			case 17: return NippleChainOK == 1;
			case 18: return NippleRingsOK == 1;
			case 23: return CatEarsOK == 1;
			case 24: return CatTailOK == 1;
			case 25: return LingerieOK == 1;
			case 26: return BunnySuitOK == 1;
			case 27: return MaidUniformOK == 1;
			case 28: return SwimsuitOK == 1;
		}
		return ItemsOwned.CheckBitFlag(item);
	}
	
	public function SetItemOwned(item:Number, own:Boolean)
	{
		if (own == undefined) own = true;
		var flg:Number = own ? 1 : 0;
		if (item > 0) {
			if (own) ItemsOwned.SetBitFlag(item);
			else ItemsOwned.ClearBitFlag(item);
		} else {
			GetDressRO(item).SetDressOwned(own);
			return;
		}
		
		switch(item) {
			case 1: PonyTailOK = flg; return;
			case 2: HaloOK = flg; return; 
			case 3: DemonicPendantOK = flg; return;
			case 4: AngelsTearOK = flg; return;
			case 5: DemonicBraOK = flg; return;
			case 6:	VibratorPantiesOK = flg; return;
			case 7: LeashOK = flg; return;
			case 8: NymphsTiaraOK = flg; return;
			case 9: SpikedBraceletOK = flg; return;
			case 10: HandcuffBraceletOK = flg; return;
			case 11: HarnessOK = flg;
			case 12: DragonRingOK = flg; return;
			case 13: ApronOK = flg; return;
			case 14: BitGagOK = flg; return;
			case 15: StrapOnOK = flg; return;
			case 16: FaeriesRingOK = flg; return;
			case 17: NippleChainOK = flg; return;
			case 18: NippleRingsOK = flg; return;
			case 23: CatEarsOK = flg; return;
			case 24: CatTailOK = flg; return;
			case 25: LingerieOK = flg; return;
			case 26: BunnySuitOK = flg; return;
			case 27: MaidUniformOK = flg; return;
			case 28: SwimsuitOK = flg; return;
		}
	}
	
	// Dresses 
	
	// override function
	public function GetDress(dress:Number) : DressSlave
	{
		dress = Math.abs(dress);
		if (dress > 6) dress = 6;

		if (arDresses == null) {
			arDresses = new Array();
			for (var i:Number = 0; i < 7; i++) {
				arDresses.push(new DressSlave(this));
			}
		}
		if (dress > arDresses.length) return null;
		return arDresses[dress];
	}
	
	// Load/Save
	public function Load(so:Object)
	{
		super.Load(so);

		if (so.ItemsOwned != undefined) {
			delete ItemsOwned;
			ItemsOwned = new BitFlags();
			ItemsOwned.Load(so.ItemsOwned);
		}
		if (so.ItemsWorn != undefined) {
			delete ItemsWorn;
			ItemsWorn = new BitFlags();
			ItemsWorn.Load(so.ItemsWorn);
		}
		
		// Dresses
		if (so.arDresses != undefined) {
			var len:Number = so.arDresses.length;
			if (len == undefined) len = 0;
			if (len != 0) {
				arDresses = new Array();
				for (var j:Number = 0; j < len; j++) {
					var dob:DressSlave = new DressSlave(this);
					dob.Load(so.arDresses[j]);
					arDresses.push(dob);
				}
			}
		}
	}
	
	public function Save(so:Object)
	{
		super.Save(so);

		if (ItemsOwned != null) {
			so.ItemsOwned = new Object();
			ItemsOwned.Save(so.ItemsOwned);
		}
		if (ItemsWorn != null) {
			so.ItemsWorn = new Object();
			ItemsWorn.Save(so.ItemsWorn);
		}
		
		// Dresses
		if (arDresses != null) {
			var len:Number = arDresses.length;
			if (len != undefined && len != 0) {
				so.arDresses = new Array();
				for (var j:Number = 0; j < len; j++) {
					var dob:Object = new Object();
					var ds:DressSlave = arDresses[j];
					ds.Save(dob);
					so.arDresses.push(dob);
				}
			}
		}
	}
}