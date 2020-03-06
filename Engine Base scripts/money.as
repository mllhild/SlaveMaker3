// Money

// Variables

var PaySM:Number;
var Pay:Number;
var PayRate:Number;

// Functions

function TotalGold() : Number { return VarGold + SMData.SMGold; }

function Money(diff:Number, quiet:Boolean, nodebt:Boolean)
{
	if (isNaN(diff)) diff = 0;
	if (quiet != true) Sounds.PlaySound("Coins");
	if (diff > 0 && SMData.SMDebt > 0) {
		if (Math.floor(diff * 0.9) >= SMData.SMDebt) {
			diff -= SMData.SMDebt;
			SMData.SMDebt = 0;
		} else {
			SMData.SMDebt -= Math.floor(diff * 0.9);
			diff = Math.floor(diff * 0.1);
		}
		SMDebt = SMData.SMDebt;	// Legacy
	}
	VarGold += Math.floor(diff);
	if (VarGold < 0) {
		if (SMData.SMGold > 0 && SMData.GuildMember) {
			SMData.SMGoldSpent += Math.abs(VarGold);
			if (SMData.SMGold > Math.abs(VarGold)) {
				SMData.SMGold += VarGold;
				VarGold = 0;
			} else {
				VarGold += SMData.SMGold;
				SMData.SMGold = 0;
			}
		}
		if (nodebt != true) {
			SMData.SMDebt += Math.abs(VarGold);
			SMDebt = SMData.SMDebt;		// Legacy
		}
		VarGold = 0;
		SMGold = SMData.SMGold;		// Legacy
	}
	dspMain.UpdateMoney();
}


function SMMoney(diff:Number, quiet:Boolean, nodebt:Boolean)
{
	if (!SMData.GuildMember) return Money(diff, quiet, nodebt);
	
	if (isNaN(diff)) diff = 0;
	if (quiet != true) Sounds.PlaySound("Coins");
	if (diff > 0) {
		SMData.SMGoldSpent += diff;
		if (SMData.SMDebt > 0) {
			if (Math.floor(diff * 0.9) >= SMData.SMDebt) {
				diff -= SMData.SMDebt;
				SMData.SMDebt = 0;
			} else {
				SMData.SMDebt -= Math.floor(diff * 0.9);
				diff = Math.floor(diff * 0.1);
			}
		}
	}
	SMData.SMGold += Math.floor(diff);
	if (SMData.SMGold < 0) {
		if (nodebt != true) {
			SMData.SMDebt += Math.abs(SMData.SMGold);
		}
		SMData.SMGold = 0;
	}
	dspMain.UpdateMoney();
	SMGold = SMData.SMGold;		// Legacy
	SMDebt = SMData.SMDebt;		// Legacy
}


function EarnMoney(income:Number) : Number
{
	if (isNaN(income)) income = 0;
	var lpay:Number;
	if (SMAdvantages.CheckBitFlag(5)) lpay = Math.floor(income * 0.95);
	else lpay = Math.floor(income);
	lpay -= Difficulty;
	if (lpay > 175) lpay = 175;
	if (SlaveGender > 3) lpay *= 2;
	if (lpay < 5) lpay = 5;
	var sm:Number = SlaveGirl.EarnMoney(lpay);
	if (sm != undefined) lpay = Math.ceil(sm);
	Money(lpay);
	return lpay;
}

function SMEarnMoney(income:Number) : Number
{
	if (isNaN(income)) income = 0;
	var lpay:Number;
	if (SMAdvantages.CheckBitFlag(5)) lpay = Math.ceil(income * 0.95);
	else lpay = Math.ceil(income);
	lpay -= Difficulty;
	if (lpay > 175) lpay = 175;
	if (lpay < 5) lpay = 5;
	SMMoney(lpay);
	return lpay;
}

