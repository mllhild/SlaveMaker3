// Dealer
// Translation status: COMPLETE

import Scripts.Classes.*;

class ShopDealer extends Shop {
		
	public var nPriceBiyaku:Number;
	public var nPriceIshinai:Number;
	public var nPriceDorei:Number;
	public var nPriceZodai:Number;
	public var nPriceGaman:Number;
		
	// constructor
	public function ShopDealer(mc:MovieClip, cg:Object, cc:Object)
	{ 
		super(mc, cg, "Shopping/Shops/Dealer", cc);
				
		Reset();
	}
	
	public function Reset()
	{
		super.Reset();
		
		nPriceBiyaku = 50;
		nPriceIshinai = 250;
		nPriceDorei = 175;
		nPriceZodai = 25;
		nPriceGaman = 50;
	}
	
	public function Load(lo:Object)
	{
		super.Load(lo);

		nPriceBiyaku = lo.PriceBiyaku;
		nPriceIshinai = lo.PriceIshinai;
		nPriceDorei = lo.PriceDorei;
		nPriceZodai = lo.PriceZodai;
		nPriceGaman = lo.PriceGaman;
		
	}
	
	public function Save(so:Object)
	{
		super.Save(so);
		
		so.PriceBiyaku = nPriceBiyaku;
		so.PriceIshinai = nPriceIshinai;
		so.PriceDorei = nPriceDorei;
		so.PriceZodai = nPriceZodai;
		so.PriceGaman = nPriceGaman;
	}
	
	public function FindShop()
	{
		if (coreGame.Supervise) AddText("While walking, a strange man approaches you and asks to speak to you away from your slave. He offers to sell you some drugs to help you train your pupil.");
		else AddText("While #assistant and #slave are out, a strange man comes to sell you some drugs to help you train your pupil.");
		AddText("These drugs are illegal but no-one enforces the laws for them.\r\rThe drugs also overtly bypass their free-will so you know #slave will not willingly take them. You will have to slip the drugs into #slavehisher food or drink. If " + coreGame.SlaveHeShe + coreGame.NonPlural(" find") + " out #slaveheshe will be upset and angry.");
		if (SMData.SMAdvantages.CheckBitFlag(2) && SMData.NumDealer == 0) {
			coreGame.ShowAct(2507, true);
			AddText("\r\rAs fellow businessman you talk a bit and he tells you where his home is and invites you to visit anytime.");
		}
		VisitShop();
		Backgrounds.ShowSlums(1);
	}

	// Visit the shop
	public function VisitShop()
	{		
		super.VisitShop();
		
		coreGame.PersonIndex = -100;
		
		Backgrounds.ShowSlums();
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4110);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}

		SMData.NumDealer++;
		coreGame.NumDealer++;		// todo remove
		if (SMData.SMAdvantages.CheckBitFlag(2)) SMData.BitFlagSM.SetBitFlag(13);

		var ti:ShopDealer = this;
		mcBase.Zodai.ActButton.onPress = function() { ti.AskToPurchaseItem(16); }
		mcBase.Zodai.ActButton.onRollOver = function() { ti.AskToPurchaseItem(16, true); }
		mcBase.Gaman.ActButton.onPress = function() { ti.AskToPurchaseItem(17); }
		mcBase.Gaman.ActButton.onRollOver = function() { ti.AskToPurchaseItem(17, true);	}
		mcBase.Biyaku.ActButton.onPress = function() { ti.AskToPurchaseItem(18);	}
		mcBase.Biyaku.ActButton.onRollOver = function() { ti.AskToPurchaseItem(18, true); }
		mcBase.Dorei.ActButton.onPress = function() { ti.AskToPurchaseItem(15); }
		mcBase.Dorei.ActButton.onRollOver = function() { ti.AskToPurchaseItem(15, true); }
		mcBase.Ishinai.ActButton.onPress = function() { ti.AskToPurchaseItem(19); }
		mcBase.Ishinai.ActButton.onRollOver = function() { ti.AskToPurchaseItem(19, true); }
		
		SetButtonDetails(mcBase.Ishinai, false, true, Potions.GetPotionName(9), undefined, "I");
		SetButtonDetails(mcBase.Dorei, false, true, Potions.GetPotionName(5), undefined, "D");
		SetButtonDetails(mcBase.Biyaku, false, true, Potions.GetPotionName(8), undefined, "B");
		SetButtonDetails(mcBase.Gaman, false, true, Potions.GetPotionName(7), undefined, "G");
		SetButtonDetails(mcBase.Zodai, false, true, Potions.GetPotionName(6), undefined, "Z");

	}
		
	public function ShowShopContents()
	{
		super.ShowShopContents();
		
		Backgrounds.ShowSlums();
		ShowPerson(44, 1, 2, 1);
		SMData.ShowSlaveMaker();
	}


	private function AskToPurchaseItem(itemno:Number, hint:Boolean)
	{
		if (!IsEventAllowable()) return;
		if (hint == true && !IsHints()) return;
		if (coreGame.SlaveGirl.PurchaseDrug(itemno, hint) == true) return;
		if (coreGame.CurrentAssistant.PurchaseDrugAsAssistant(itemno, hint) == true) return;
		
		var price:Number;
		var drugindex;
		if (itemno == 15) {
			price =  nPriceDorei;
			drugindex = 5;
		} else if (itemno == 19) {
			price = nPriceIshinai;
			drugindex = 9;
		} else if (itemno == 18) {
			price = nPriceBiyaku;
			drugindex = 8;
		} else if (itemno == 17) {
			price = nPriceGaman;
			drugindex = 7;
		} else if (itemno == 16) {
			price = nPriceZodai;
			drugindex = 6;
		}
		var desc:String = Potions.GetPotionDescription(drugindex);
		var newprice:Number = PotionPrice(price, drugindex);
		PersonSpeak(44, desc + "\r" + Language.GetHtml("Price", "Shopping") + " " + PurchasePrice(newprice) + coreGame.GP);
		if (hint != true) {
			BlankLine();
			AddText(Language.GetHtml("DoYouDrug", xNode));
			DoYesNoItem(itemno);
		}
	}
	
	public function BuyFromShop(itemno:Number)
	{
		if (itemno == 15)
		{
			if (coreGame.DoreiEffecting == 1) {
				SetLangText("RefuseToSellDrug", xNode);
				return;
			}
			if (BuyPotion(44, 5, nPriceDorei)) {
				nPriceDorei += Math.floor(nPriceDorei / 5);
				LeaveShop();
			}
			return;
		}
		if (itemno == 16)
		{
			if (BuyPotion(44, 6, nPriceZodai)) {
				nPriceZodai += Math.floor(nPriceZodai / 5);
				LeaveShop();
			}
			return;
		}
		if (itemno == 17)
		{
			if (coreGame.GamanEffecting == 1) {
				SetLangText("RefuseToSellDrug", xNode);
				return;
			}
			if (BuyPotion(44, 7, nPriceGaman)) {
				nPriceGaman += Math.floor(nPriceGaman / 5);
				LeaveShop();
			}
		}
		else if (itemno == 18)
		{
			if (coreGame.BiyakuEffecting == 1) {
				SetLangText("RefuseToSellDrug", xNode);
				return;
			}
			if (BuyPotion(44, 8, nPriceBiyaku)) {
				nPriceBiyaku = nPriceBiyaku + Math.floor(nPriceBiyaku / 5);
				LeaveShop();
			}
			return;
		}
		if (itemno == 19)
		{
			if (coreGame.IshinaiEffecting == 1) {
				SetLangText("RefuseToSellDrug", xNode);
				return;
			}
			if (BuyPotion(44, 9, nPriceIshinai)) {
				nPriceIshinai = nPriceIshinai + Math.floor(nPriceIshinai / 5);
				LeaveShop();
			}
			return;
		} 
	}
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 66: 
				AskToPurchaseItem(18); return true;
			case 68:
				AskToPurchaseItem(15); return true;
			case 71: 
				AskToPurchaseItem(17); return true;
			case 73: 
				AskToPurchaseItem(19); return true;
			case 90: 
				AskToPurchaseItem(16); return true;
		}
		return false;
	}
}