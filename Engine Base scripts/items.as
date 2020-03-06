import Scripts.Classes.*;

// Variables
var ObjectChoice:Number;

// Descriptions
var DemonicPendantDescription:String;
var DemonicPendantDescriptionOF:String;
var LeashPonyDescription:String;
var LeashDescription:String;
var DemonicBraDescription:String;

// Items

function EquipItem(item:Number)
{
	if (!modulesList.EquipItem(item)) {
		HideStatChangeIcons();
		slaveData.ItemsWorn.SetBitFlag(item);

		switch(item) {
			case 1:
				if (PonyTailWorn != 1) {
					DifficultyBondage = DifficultyBondage - 5;
					PointsMod(0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0);
				}
				PonyTailWorn = 1;
				PlugInserted = 1;
				break;
			case 2:
				HaloWorn = 1; 
				break;
			case 3: DemonicPendantWorn = 1; break;
			case 4:
				AngelsTearWorn = 1;
				break;
			case 5:
				if (DemonicBraWorn == 0) {
					DemonicBraWorn = 1;
					PointsMod(0, 0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					DifficultyXXX = DifficultyXXX - 5;
					DifficultyBrothel = DifficultyBrothel - 5;
					DifficultyTouch = DifficultyTouch - 5;
					DifficultyLick = DifficultyLick - 5;
					DifficultyFuck = DifficultyFuck - 5;
					DifficultyBlowjob = DifficultyBlowjob - 5;
					DifficultyTitsFuck = DifficultyTitsFuck - 5;
					DifficultyDildo = DifficultyDildo - 5;
					DifficultyLesbian = DifficultyLesbian - 5;
					DifficultyBondage = DifficultyBondage - 5;
					DifficultyThreesome = DifficultyThreesome - 5;
					DifficultyGangBang = 0;
				}
				break;
			case 6:
				if (VibratorPantiesWorn == 0) {
					VibratorPantiesWorn = 1;
					PointsMod(0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					DifficultyDildo = DifficultyDildo - 2;
					MinLibido = MinLibido + 5;
					NumDaysWithoutFuck = 0;
				}
				break;
			case 7:
				if (LeashWorn == 0) {
					if (Loyalty >= 0) Loyalty = Loyalty - 1;
					PointsMod(0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 0, -5, 0, 11, 0, 0, 0);
					LeashWorn = 1;
				}
				break;
			case 8:
				if (NymphsTiaraWorn == 0) PointsMod(20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				NymphsTiaraWorn = 1;
				break;
			case 9: SpikedBraceletWorn = 1; break;
			case 10: HandcuffBraceletWorn = 1; break;
			case 11:
				if (HarnessWorn == 0) DifficultyBondage = DifficultyBondage - 10;
				HarnessWorn = 1;
				break;
			case 12:
				if (DragonRingWorn == 0) PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0);
				DragonRingWorn = 1;
				break;
			case 13:
				if (ApronWorn == 0) PointsMod(0, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				ApronWorn = 1;
				break;
			case 14:
				if (BitGagWorn == 0) PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 5, 0, 0, -5);
				BitGagWorn = 1;
				RulesTalk = 0;
				break;
			case 15:
				if (StrapOnWorn == 0) PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0);
				StrapOnWorn = 1;
				break;
			case 16: FaeriesRingWorn = 1; break;
			case 17: NippleChainWorn = 1; NippleRingsWorn = 0; break;
			case 18: NippleChainWorn = 0; NippleRingsWorn = 1; break;
			
		}
		UpdateSlave();
	}
}


function UnEquipItem(item:Number)
{
	HideStatChangeIcons();
	if (!modulesList.UnEquipItem(item)) {
		slaveData.ItemsWorn.ClearBitFlag(item);

		switch(item) {
			case 1:
				if (PonyTailWorn == 1) {
					DifficultyBondage += 5;
					if (!IsPermanentDickgirl()) Icons.HideDickgirlIcon();
					PointsMod(0, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0);
					PonyTailWorn = 0;
					PlugInserted = 0;
				}
				break;
			case 2: 
				HaloWorn = 0; 
				Hints.StopHints();
				break;
			case 3: DemonicPendantWorn = 0; break;
			case 4: 
				AngelsTearWorn = 0;
				break;
			case 5:
				break;
			case 6:	
				if (VibratorPantiesWorn == 1) {
					PointsMod(0, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					DifficultyDildo += 2;
					MinLibido -= 5;
					VibratorPantiesWorn = 0;
				}
				break;
			case 7:
				if (LeashWorn == 1) {
					if (Loyalty > 0) Loyalty++;
					PointsMod(0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 5, 0, -11, 0, 0, 0);
					LeashWorn = 0;
				}
				break;
			case 8:
				if (NymphsTiaraWorn == 1) PointsMod(-20, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				NymphsTiaraWorn = 0;
				break;
			case 9: SpikedBraceletWorn = 0; break;
			case 10: HandcuffBraceletWorn = 0; break;
			case 11:
				if (HarnessWorn == 1) DifficultyBondage = DifficultyBondage + 10;
				HarnessWorn = 0;
				break;
			case 12:
				if (DragonRingWorn == 1) PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -20, 0, 0, 0, 0, 0);
				DragonRingWorn = 0;
				break;
			case 13:
				if (ApronWorn == 1) PointsMod(0, 0, 0, 0, 0, 0, -10, -10, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				ApronWorn = 0;
				break;
			case 14:
				if (BitGagWorn == 1) PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, -5, 0, 0, 5);
				BitGagWorn = 0;
				break;
			case 15:
				if (StrapOnWorn == 1) PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0, 0, 0);
				StrapOnWorn = 0;
				break;
			case 16: FaeriesRingWorn = 0; break;
			case 17: NippleChainWorn = 0; break;
			case 18: NippleRingsWorn = 0; break;
		}
		UpdateSlave();
	}
}
