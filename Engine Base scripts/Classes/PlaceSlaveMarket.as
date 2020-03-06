// SlaveMarket
// Linked to Walk-Slaves.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PlaceSlaveMarket extends Place
{
	private var qNum1:Number;
	private var qNum2:Number;
	
	// Constructor
	public function PlaceSlaveMarket(mc:MovieClip, cg:Object, cc:City)
	{
		// Linked to Walk-Slaves.swf, xml node SlaveMarket, id 10, x = 150, y = 220
		super("SlaveMarket", mc, cg, 10, true, "Engine/Walk-Slaves.swf", 150, 220, cc);
		
		qNum1 = GetFreeEvent();
		qNum2 = GetFreeEvent();
	}
	
	public function CanLoadSave() : Boolean { return false; }
	
	// Images
	public function HideImages()
	{
		mcBase.SlavePensIntro._visible = false;
		mcBase.WalkSlavePens._visible = false;
		mcBase.Exhibit._visible = false;
		mcBase.Auction._visible = false;
	}
	
	// Walking in the SlaveMarket
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{
		coreGame.WalkPlace = 10;
		
		ResetQuestions();
		AddQuestion(4005, "Auction");
		AddQuestion(4006, "Look at an Exhibit");
		
		AddText("<b>The Slave Market</b>\rThe place people come to buy slaves either for training by the Slave Maker Guild or a fully trained slave from a Freelancer.\r\rHere you can attend an auction to buy a slave for yourself.\r\rYou may also view other slaves being exhibited by your fellow Slave Makers and see the quality of their work.");
		if (coreGame.LastActionDone != 2505) {
			AddText("\r\rYou may also choose to exhibit #slave to demonstrate #slavehisher training. If #slave's training is advanced and #slave is appealing you may get offers to buy #slave.");
			if (!slaveData.Owner.IsPersonallyOwned()) AddText(" #slave already has an owner so it would be quite dishonourable to sell #slavehimher again, breaking your contract and cheating #slavehisher owner.");
			AddQuestion(4007, "Exhibit #slave");
		}
		if (coreGame.GetTotalSlavesOwned(true)) AddQuestion(4008, "Sell one of your slaves");
		ShowQuestions("Where will you visit?");
		Language.XMLData.XMLGeneral("VisitSlaveMarket");
	}
	
	public function ViewExhibit()
	{
		coreGame.WalkPlace = 10.2;
		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4113);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkSlaveMarket++;
		coreGame.EventTotal = slaveData.TotalWalkSlaveMarket;
		
		// Select the event and show it
		super.DoWalkLoaded(this.mcBase, this.ModuleName);
	}
	
	public function ExhibitSlave()
	{
		coreGame.WalkPlace = 10.3;
		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4113);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkSlaveMarket++;
		coreGame.EventTotal = slaveData.TotalWalkSlaveMarket;
		
		// Select the event and show it
		super.DoWalkLoaded(this.mcBase, this.ModuleName);
	}
	
	public function SellSlave()
	{
		coreGame.WalkPlace = 10.4;
		
		// walk here during evil mine quest
		// does not count as a time walked here
		if (coreGame.RuinedTemple.IsStartedSpecialEvent()) {
			SetEvent(4113);
			coreGame.RuinedTemple.DoEventNextAsAssistant();
			return;
		}
		
		// general counts of times walked here
		slaveData.TotalWalkSlaveMarket++;
		coreGame.EventTotal = slaveData.TotalWalkSlaveMarket;
		
		// Select the event and show it
		super.DoWalkLoaded(this.mcBase, this.ModuleName);

	}
			
	public function GetWalkEvent(exclude:Array, sequential:Boolean) 
	{
		super.GetWalkEvent(exclude, sequential);

		if (coreGame.NumEvent != 0 || coreGame.StrEvent != "") return;
		
		switch (coreGame.WalkPlace) {
			case 10.2:
				if (PercentChance(10)) coreGame.NumEvent = 100;
				else {
					this.CustomFlag++;
					coreGame.NumEvent = this.CustomFlag + 100;
					if (coreGame.NumEvent > 107) coreGame.NumEvent = 100;
				}
				break;
			case 10.3:
			case 10.4:
				coreGame.NumEvent = 100;
				break;
		}
	}
	
	public function HandleWalk() : Boolean
	{
		coreGame.SMTRACE("SlaveMarket::HandleWalk " + coreGame.StrEvent);
		
		if (coreGame.WalkPlace == 10.4) return DoSellSlave();
		if (coreGame.WalkPlace == 10.3) return DoExhibitSlave();
		
		DoViewExhibit();		// default, 10.2
			
	}
	
	private function DoViewExhibit() : Boolean
	{
		// View an Exhibit
		ShowSupervisor();
		if (coreGame.NumEvent == 100) {
			SetText("Unfortunately no-one is exhibiting a slave, you will have to return another time.");
		} else {
			HideBackgrounds();
			ShowMovie(mcBase.Exhibit, 1, 1, coreGame.NumEvent - 100);
			switch(coreGame.NumEvent) {
				case 101:
					SetText("");
					break;
			}
		}
		return true;
	}
		
	private function DoExhibitSlave() : Boolean
	{
		// Exhibit your slave
		coreGame.ShowDress();
		ShowSupervisor();
		Backgrounds.ShowBar(3);
		
		coreGame.CalculateTotalScore();
		
		if (!coreGame.TestObedience(slaveData.DifficultyExhib, 100)) {
			SetText("#slave parades and dances a little. You then tell #slavehimher to expose #slavehisher more intimate parts and #slaveheshe blushes and refuses completely.\r\rYou realise this show of defiance made the audience lose any interest in #slave, and you take #slavehimher home.\r\rIn future you she take care to only exhibit slaves that are well rounded and resonably trained.");
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -5, 0, 0, 0, -1, 0, 0);
			return true;
		}
		SetText("#slave parades and dances a little and then you tell #slavehimher to expose #slavehisher body, and #slaveheshe does. The audience look on");
		if (slaveData.VarCharisma < 30) AddText(", not very interested");
		else if (slaveData.VarCharisma < 60) AddText(", quite interested");
		else AddText(" enthralled");
		AddText(".\r\rYou finish exhibiting #slave ");
		var chc:Number = coreGame.Score < 50 ?  coreGame.Score / 2 : coreGame.Score;
		if (chc > 80) chc = 80;
		if (coreGame.Score < 50) {
			AddText("but no-one seems very interested and you take #slave home, a little disappointed.\r\rYour reputation may of suffered a little from this poor showing.");
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, -1 * ((50 - coreGame.Score) / 10), 0, 0, 0, 0, 0);
			Points(-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, -0.1, 0, 0, 0, 0);
			return;
		} else if (slaveData.VarCharisma < 30 && PercentChance(chc)) {
			AddText("and there is a little interest in #slave and you get a couple of compliments. The only complaint is that #slave could be prettier.");
			SMData.SMPoints(0, 0, 0, 0, 1, 0, 0, 0.1, 0, 0, 0, 0, 1);
			Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0.5, 0, 0.1, 2, 1, 0, 0);
			coreGame.Owner.OfferToBuy(10);
		} else if (PercentChance(chc)) {
			AddText("and there is quite a bit of interest in #slave and you get a couple of compliments. The only complaint is that #slave could be prettier.");
			SMData.SMPoints(0, 0, 0, 0, 1, 0, 0, 0.1, 0, 0, 0, 0, 1);
			Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0.5, 0, 0.1, 2, 1, 0, 0);
			coreGame.Owner.OfferToBuy(10);
		} else {
			if (slaveData.VarCharisma < 30) AddText("and there is a little interest in #slave and you get a couple of compliments. The only complaint is that #slave could be prettier.");
			else AddText("and several people compliment you and your slave but it appears there is little interest otherwise.");
			AddText("\r\rYou take #slave home, a little happy about the compliments.");
			SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 1);
			Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 2, 1, 0, 0);
		}
				
		return true;
	}
	
	private function DoSellSlave() : Boolean
	{
		var thisInstance:PlaceSlaveMarket = this;
		
		function SlaveFilter(idx:Number) {
			if (idx < 0) return false;
			var sgirl:Slave = thisInstance.SMData.SlavesArray[idx];
			if (sgirl.SlaveType == 2 || sgirl.SlaveType == -20 || sgirl.SlaveType == -10) return false;
			if (sgirl.BitFlag1.CheckBitFlag(60) || sgirl.BitFlag1.CheckBitFlag(61)) return false;
			if (sgirl.Price = -1) continue;
			return true;
		}
		function SellCallback()
		{
			thisInstance.SMTRACE("SellCallback");
			thisInstance.coreGame.SlavePicker.ReviewSlave(thisInstance.coreGame.PersonIndex, "SellParticularSlave", thisInstance);
		}
		coreGame.PickASlave("Which Slave will you sell", true, SlaveFilter, SellCallback);
		
		return true;
	}
	
	private function SellParticularSlave()
	{
		SMTRACE("SellParticularSlave");
		// Sell the picked slave
		ShowSupervisor();
		Backgrounds.ShowBar(3);
		
		var slv:Slave = coreGame.dspMain.GetSlaveForGameTabs();
		
		coreGame.CalculateTotalScore(slv);
		if (slv.SlaveType != 1) {
			if (slv.Price > 0) coreGame.Pay = coreGame.Score / 100 * slv.Price;
			else coreGame.Pay = coreGame.Score / 100 * 500;
		}
		
		if (!coreGame.TestObedience(slv.DifficultyExhib, 100)) {
			SetText("#person parades and dances a little. You then tell #personhimher to expose #personhisher more intimate parts and #personheshe blushes and refuses completely.\r\rYou realise this show of defiance made the audience lose most #person, any price will be redused.");
			coreGame.Pay = coreGame.Pay / 2;
		} else SetText("#person parades and dances a little and then you tell #personhimher to expose #personhisher body, and #personheshe does.");
		AddText("\r\rThe audience look at #person");
		if (slv.VarCharisma < 30) AddText(", not very interested");
		else if (slv.VarCharisma < 60) AddText(", quite interested");
		else AddText(" enthralled");
		AddText(".\r\rYou finish exhibiting #person, and offer #personhimher to the auctioneer for an immediate sale ");
		var chc:Number = coreGame.Score;
		if (chc > 85) chc = 85;

		if (coreGame.Score < 30) {
			AddText("but no-one seems very interested and you take #person home, a little disappointed.\r\rYour reputation may of suffered a little from this poor showing.");
			SMData.SMPoints(0, 0, 0, 0, 0, 0, 0, -1 * ((50 - coreGame.Score) / 10), 0, 0, 0, 0, 0);
			slv.Points(-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.5, 0, -0.1, 0, 0, 0, 0);
			coreGame.UpdateSlave();
			return;
		} else if (slv.VarCharisma < 30 && PercentChance(chc)) {
			AddText("and there is a little interest in #slave and you get a couple of compliments. The only complaint is that #person could be prettier.");
			SMData.SMPoints(0, 0, 0, 0, 1, 0, 0, 0.1, 0, 0, 0, 0, 1);
			slv.Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0.5, 0, 0.1, 2, 1, 0, 0);
			coreGame.UpdateSlave();
		} else if (PercentChance(chc)) {
			AddText("and there is quite a bit of interest in #slave and you get a couple of compliments. The only complaint is that #person could be prettier.");
			SMData.SMPoints(0, 0, 0, 0, 1, 0, 0, 0.1, 0, 0, 0, 0, 1);
			slv.Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0.5, 0, 0.1, 2, 1, 0, 0);
		} else {
			if (slv.VarCharisma < 30) AddText("and there is a little interest in #person and you get a couple of compliments. The only complaint is that #person could be prettier.");
			else AddText("and several people compliment you and your slave but it appears there is only a little interest otherwise.");
			SMData.SMPoints(0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 1);
			slv.Points(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 2, 1, 0, 0);
			coreGame.UpdateSlave();
		}
		
		AddText("\r\rThe auction is quickly resolved and the winning offer is " + coreGame.Pay + coreGame.GP + ".");
		ResetQuestions("Do you sell #person");
		AddQuestion(qNum1, "Yes, sell #personhimher");
		AddQuestion(qNum2, "No, keep #personhimher");
		ShowQuestions();
	}
	
	public function DoEventNext() : Boolean
	{
		switch (coreGame.NumEvent) {
		case qNum1:
			// Yes Sell
			SetText("You agree to the sale, #person is no longer your slave.");
			coreGame.sdata.SlaveType = -3;
			SMMoney(coreGame.Pay);
			SMData.BuildOwnedSlaves();
			return true;

		case qNum2:
			// No Keep
			SetText("You decide to keep #person.");
			return true;
		
		// 4005 - walk Slave Market Auction
		 case 4005:
			ResetWalkEvent();
			coreGame.WalkPlace = 10.1;
			parentCity.SlaveMarketAuction.VisitShop();
			return true;
			
		// 4006 - walk slave market look at exhibit
		 case 4006:
			ResetWalkEvent();
			ViewExhibit();
			return true;
			
		// 4007 - walk slave market exhibit
		 case 4007:
			ResetWalkEvent();
			ExhibitSlave();
			return true;
			
		// 4008 - sell a slave
		 case 4008:
			ResetWalkEvent();
			SellSlave();
			return true;
		}
		return false;
	}
	
}