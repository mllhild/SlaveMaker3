// Slave Purchasing

// Translation status: COMPLETE

import Scripts.Classes.*;

class ShopSlaveMarketMinor extends Shop {
	
	private var mcSave:MovieClip;
		
	// constructor
	public function ShopSlaveMarketMinor(mc:MovieClip, cg:Object, cc:Object)
	{ 
		super(mc, cg, "Shopping/Shops/SlaveAuction", cc);
		
		mcBase.Cell1.tabChildren = true;
		mcBase.Cell2.tabChildren = true;
		
		mcNextButton = cg.SlavePurchaseNext;
		mcPreviousButton = cg.SlavePurchasePrevious;
	}
	
		// Visit the shop
	public function VisitShop()
	{
		mcBase.thisother = 0;
		nCurrentPage = 2;
		
		BuildOthers();
		
		super.VisitShop();
	}
	
	public function ShowShopContents()
	{	
		var nTot:Number = nTotPages;
		super.ShowShopContents();
		nTotPages = nTot;
		
		coreGame.dspMain.SelectGameTab(1);
		
		SMData.ShowSlaveMaker();
				
		coreGame.ShowLeaveButton(824);
	
		mcBase.Cell1._visible = true;
		mcBase.Cell2._visible = false;
			
		ShowHoldingCellSlaves(nCurrentPage, mcBase.Cell1);

		mcBase._x = 7;
	}
	
	public function BuildOthers()
	{
		trace("BuildOthers");
		coreGame.ClearGeneralArray2();
		
		var nSkip:Number = 19;
		
		// check standard list of minor slaves
		for (var msNode:XMLNode = XMLData.mslavesNode; msNode != null; msNode = msNode.nextSibling) {
			if (msNode.nodeType != 1) continue;
			if (msNode.nodeName.toLowerCase() == "slave") {		
				if (nSkip > 0) {
					nSkip--;
					continue;
				}
				if (!IsSlaveForSale(msNode.firstChild)) continue;
				
				coreGame.arGeneralArray2.push(msNode.firstChild);
			}
		}
		
		// check list of slaves for any that are purchasable minor slaves
		var sdata:Slave;
		for (var so:String in SMData.SlavesArray) {
			sdata = SMData.SlavesArray[so];
			if (sdata.SlaveType == -201) {
				if (sdata.sNode == null) sdata.sNode = GetSlaveXML(undefined, sdata);

				coreGame.arGeneralArray2.push(sdata.sNode);
			}
		}
		
		nTotPages = coreGame.arGeneralArray2.length;
	}
	
	public function ShowHoldingCellSlave(cell:MovieClip, tNode:XMLNode, pos:Number)
	{
		var mc:MovieClip = cell["Slave" + pos];
		mc._visible = true;
		SetMinorSlaveButton(pos, "Slave" + pos, tNode);
		mc.sno = pos;
		mc.sNode = tNode;
	
		mc.SlaveButton._width = 414;
		mc.SlaveButton._height = 600;
		mc._xscale = 100;
		mc._yscale = 100;
		mc._width = 345;
		mc._height = 500;
		mc._x = pos == 1 ? 18 : pos == 2 ? 373 : 704;
		mc._y = 100;
		
		var nm:String = Language.XMLData.GetXMLString("Name", tNode);
		trace("ShowHoldingCellSlave: " + nm);
	
		SMData.ShowSlave(tNode, 7, 1, 1, mc.SlaveImage);
	}
	
	public function ShowHoldingCellSlaves(page:Number, cell:MovieClip)
	{
		cell.Bars._x = 0;
		cell.Slave1._visible = false;
		cell.Slave2._visible = false;
		cell.Slave3._visible = false;
		cell.Slave4._visible = false;
		
		var tNode:XMLNode;
		
		switch(page) {
			case 1:
				tNode = GetSlaveXML("Maran");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 1);
				tNode = GetSlaveXML("Lian&Dian");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 2);
				tNode = GetSlaveXML("Laan");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 3);
				tNode = GetSlaveXML("Deala");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 4);
				return;
			case 2:
				tNode = GetSlaveXML("Ardala");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 1);
				tNode = GetSlaveXML("Ella");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 2);
				tNode = GetSlaveXML("Narry");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 3);
				tNode = GetSlaveXML("Ryah");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 4);
				return;
			case 3:
				tNode = GetSlaveXML("Soma");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 1);
				tNode = GetSlaveXML("Thoth");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 2);
				tNode = GetSlaveXML("Ryoga");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 3);
				tNode = GetSlaveXML("Lance");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 4);
				return;
			case 4:
				tNode = GetSlaveXML("Haro");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 1);
				tNode = GetSlaveXML("Sana");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 2);
				tNode = GetSlaveXML("Latala");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 3);
				tNode = GetSlaveXML("Cora");
				if (IsSlaveForSale(tNode)) ShowHoldingCellSlave(cell, tNode, 4);
				return;
		}
			
		var iPos:Number = 1;
		for (var idx:Number = mcBase.thisother; idx < mcBase.thisother + 3; idx++) {
			if (idx >= coreGame.arGeneralArray2.length) break;
			
			ShowHoldingCellSlave(cell, coreGame.arGeneralArray2[idx], iPos);
			iPos++;
			if (iPos > 3) iPos = 1;
			
		}
	
	}
	
	
	public function SetNextPreviousButtons(caption:String)
	{
		mcPreviousButton._visible = true;
		mcNextButton._visible = true;
		switch(nCurrentPage) {
			// Females
			case 1: 
				if (nTotPages > 2) mcPreviousButton.Area.text = Language.GetHtml("Others", "SlaveMarket") + " " + int((nTotPages + 1) / 3);
				else mcPreviousButton.Area.text = Language.GetHtml("Others", "SlaveMarket");
				mcNextButton.Area.text = coreGame.DickgirlOn == 1 ? Language.GetHtml("Hermaphrodites", "SlaveMarket") :  Language.GetHtml("Males", "SlaveMarket");
				break;
			// Dickgirls
			case 2:
				mcPreviousButton.Area.text = Language.GetHtml("Females", "SlaveMarket");
				mcNextButton.Area.text = Language.GetHtml("Males", "SlaveMarket");
				break;
			// Males
			case 3:
				mcPreviousButton.Area.text = coreGame.DickgirlOn == 1 ? Language.GetHtml("Hermaphrodites", "SlaveMarket") :  Language.GetHtml("Females", "SlaveMarket");
				mcNextButton.Area.text = Language.GetHtml("Servants", "SlaveMarket");
				break;
			// Servants
			case 4:
				mcPreviousButton.Area.text = Language.GetHtml("Males", "SlaveMarket");
				if (nTotPages > 2) mcNextButton.Area.text = Language.GetHtml("Others", "SlaveMarket") + " 1";
				else mcNextButton.Area.text = Language.GetHtml("Others", "SlaveMarket");
				break;
			// Others
			case 5:
				if (nTotPages > 2 && mcBase.thisother > 0) mcPreviousButton.Area.text = Language.GetHtml("Others", "SlaveMarket") + " " + int(mcBase.thisother / 3);
				else mcPreviousButton.Area.text = Language.GetHtml("Servants", "SlaveMarket");
				
				if (nTotPages > 2 && ((mcBase.thisother + 3) < nTotPages)) mcNextButton.Area.text = Language.GetHtml("Others", "SlaveMarket") + " " + (2 + int(mcBase.thisother / 3));
				else mcNextButton.Area.text = Language.GetHtml("Females", "SlaveMarket");
				break;
		}
	}
	
		
	public function BuyFromShop(itemno:Number)
	{
		var sNode:XMLNode = coreGame.ObjEvent;
		trace("BuyFromShop: " + sNode + " " + sNode.parentNode);
		if (SMData.IsSlaveOwned(sNode)) return;
		
		if (BuyItem(coreGame.GetPersonsName(55), XMLData.GetXMLValue("Price", sNode), true)) {
			coreGame.PersonOtherName = XMLData.GetXMLString("Name", sNode);
			var sdp:Slave = SMData.SetSlaveOwned(sNode);
			PlaySound("DoorClang");
	
			coreGame.AppendActText = true;
			var aNode:XMLNode = XMLData.GetNode(sNode, "MinorSlaveIntroduction");
			if (aNode == null) aNode = XMLData.GetNode(sNode, "Introduction");
			if (aNode != null) {
				coreGame.ShowGirlsStoryStart();
				
				coreGame.GirlsStory._visible = true;
				coreGame.GirlsStoryTop._visible = true;
				var ti:ShopSlaveMarketMinor = this;
				coreGame.GirlsStoryTop.BigButton.onPress = function() {
					ti.ShowShopContents();
				}
				coreGame.GirlsStoryTop.GirlsStoryNext.Btn.onPress = coreGame.GirlsStoryTop.BigButton.onPress;
				if (XMLData.XMLEventByNode(aNode, true, undefined, true)) {
					if (aNode.attributes.black == "true") Language.SetIntroText(XMLData.EventText, true, false);
					else if (aNode.attributes.white == "true") Language.SetIntroText(XMLData.EventText, false, true);
					else Language.SetIntroText(Language.XMLData.EventText);
					Language.XMLData.EventText = "";
				} 
			} else {
			
				var mc:MovieClip = mcSave;
				mc.enabled = false;
				if (mcBase.Cell1._visible) coreGame.StartMoveImage(mcBase.Cell1.Bars, 40, 15, 0, 0, -800, 0);
				else coreGame.StartMoveImage(mcBase.Cell2.Bars, 40, 15, 0, 0, -800, 0);
				coreGame.StartFadeImage(50, mc);
			}
			if (coreGame.AppendActText) {
				Diary.AddEntry(Language.GetHtml("NowOwn", "SlaveMarket"));
				SetGeneralText(Language.GetHtml("NowOwn", "SlaveMarket"));
				AddGeneralText("\r\r");
			}
			
			if (nCurrentPage > 4) {
				Timers.AddTimer(
					setInterval(this, "RebuildOthers", 100, Timers.GetNextTimerIdx())
				)
			}

		}
		coreGame.Quitter._x = 824;
	}
	
	public function RebuildOthers(timer:Number)
	{
		Timers.RemoveTimer(timer);
		BuildOthers();
	}
	
	public function PurchaseMinorSlave(mc:MovieClip, hint:Boolean)
	{
		var sNode:XMLNode = mc.sNode;
		var shortc:Number = mc.sno + 48;
		
		var sd:Slave = new Slave();
		sd.LoadActImages(sNode);
		coreGame.genNumber = sd.GetTotalImages();
		SetGeneralText("<font color='#0000FF'>" + String.fromCharCode(shortc) + "</font>) <b>" + XMLData.GetXMLMultiLineString("Name", sNode) + "\r" + PurchasePrice(XMLData.GetXMLValue("Price", sNode)) + "GP</b>\rAvailable Images: #general\r\r" + Language.strLineChanges(XMLData.GetXMLMultiLineString("DescriptionDetailed", sNode)) + "\r");
	
		mcSave = mc;
		PurchaseItem(5000, hint);
		coreGame.ObjEvent = sNode;
	}
	
	public function SetMinorSlaveButton(sno:Number, slavemc:String, sNode:XMLNode)
	{
		var mc1:MovieClip = mcBase.Cell1[slavemc];
		var mc2:MovieClip = mcBase.Cell2[slavemc];
		mc1.sNode = sNode;
		mc2.sNode = sNode;
		mc1.sno = sno;
		mc2.sno = sno;
		
		mc1.enabled = true;
		mc2.enabled = true;
		var ti:ShopSlaveMarketMinor = this;
		mc1.onPress = function() { ti.PurchaseMinorSlave(this, false); }
		mc1.onRollOver = function() {
			ti.coreGame.SetMovieColour(this, 50, 50, 50);
			if (ti.coreGame.YesEvent._visible == false && ti.IsHints()) ti.PurchaseMinorSlave(this, true);
		}
		mc1.onRollOut = function() { ti.HideHints(true); ti.coreGame.SetMovieColour(this, 0, 0, 0); };
		SetMovieColour(mc1, 0, 0, 0);
		SetMovieColour(mc2, 0, 0, 0);
		mc2.onPress = mc1.onPress;
		mc2.onRollOver = mc1.onRollOver;
		mc2.onRollOut = mc1.onRollOut;
	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		super.Shortcuts(keya, key);
		switch(keya) {
			case 49:
				if (mcBase.Cell1.Slave1._visible) {
					mcBase.Cell1.Slave1.onPress();
					return true;
				}
				break;
			case 50:
				if (mcBase.Cell1.Slave2._visible) {
					mcBase.Cell1.Slave2.onPress();
					return true;
				}
				break;
			case 51:
				if (mcBase.Cell1.Slave3._visible) {
					mcBase.Cell1.Slave3.onPress();
					return true;
				}
				break;
			case 52:
				if (mcBase.Cell1.Slave4._visible) {
					mcBase.Cell1.Slave4.onPress();
					return true;
				}
				break;
		}
		return false;
	}
	
	public function PressPurchaseNext()
	{
		SetGeneralText("");
		coreGame.HideYesNoButtons();
		coreGame.HideImages();
		coreGame.Quitter._x = 824;
		
		mcBase.Cell1._visible = true;
		//ShowHoldingCellSlaves(nCurrentPage, mcBase.Cell1);
		mcBase._x = 7;
		if (nCurrentPage == 5) {
			if (nTotPages > 2 && ((mcBase.thisother + 3) < nTotPages)) mcBase.thisother += 3;
			else nCurrentPage++;
		} else {
			nCurrentPage++;
			if (nCurrentPage == 5) mcBase.thisother = 0;
		}
		if (nCurrentPage > 5) nCurrentPage = 1;
		if (coreGame.DickgirlOn == 0 && nCurrentPage == 2) nCurrentPage++;
		//mcBase.Cell2._visible = true;
		ShowHoldingCellSlaves(nCurrentPage, mcBase.Cell1);
		SetNextPreviousButtons();
		//StartMoveImage(SlavePurchase, 20, 6, 7, 5, -441, 5, mcBase.Cell1);
		PlaySound("Footsteps");
	}
	
	public function PressPurchasePrevious()
	{
		SetGeneralText("");
		coreGame.HideYesNoButtons();
		coreGame.HideImages();
		coreGame.Quitter._x = 824;
		//mcBase.Cell2._visible = true;
	
		//ShowHoldingCellSlaves(nCurrentPage, mcBase.Cell2);
		mcBase._x = 7; //-441;
		if (nCurrentPage == 5) {
			if (nTotPages > 2 && mcBase.thisother > 0) mcBase.thisother -= 3;
			else nCurrentPage--;
		} else nCurrentPage--;
		if (nCurrentPage < 1) {
			nCurrentPage = 5;
			mcBase.thisother = 3 * int(nTotPages / 3);
			if (mcBase.thisother > 0) mcBase.thisother -= 3;
		}
		if (coreGame.DickgirlOn == 0 && nCurrentPage == 2) nCurrentPage--;
		mcBase.Cell1._visible = true;
		ShowHoldingCellSlaves(nCurrentPage, mcBase.Cell1);
		SetNextPreviousButtons();
		//StartMoveImage(SlavePurchase, 20, 6, -441, 5, 7, 5, mcBase.Cell2);
		PlaySound("Footsteps");
	}
	
	function IsSlaveForSale(tNode:XMLNode) : Boolean
	{
		if (Language.XMLData.GetXMLValue("Price", tNode) <= 0) return false;
		
		if (!coreGame.currentCity.IsSlavePresent(tNode)) return false;
		
		var sdata:Slave = SMData.GetSlaveDetailsByNode(tNode);
		//sdata = SMData.GetSlaveDetails(Language.XMLData.GetXMLString("Folder", tNode), true);		// was "Name"
		if (sdata != null) {
			// inlined IsSlaveOwned()
			if ((sdata.SlaveType == 1 && sdata.CanAssist == true) || sdata.SlaveType == 0 || sdata.SlaveType == 2 || sdata.SlaveType == -200 || sdata.Available == false) return false;
			if (sdata.SlaveType < -2 && sdata.SlaveType != -10 && sdata.SlaveType != -100) return false;
			if (coreGame.DickgirlOn == 0 && sdata.SlaveGender == 3) return false;
		} else {
			if (coreGame.DickgirlOn == 0) {
				if (Language.XMLData.GetXMLValue("Gender", tNode) == 3) return false;
			}
		}
		var avNode:XMLNode = Language.XMLData.GetNode(tNode, "Available");
		if (avNode != null && coreGame.ParseConditional(avNode, true, false) == null) return false;
		return true;
	}
	
	private function GetSlaveXML(slave:String, obj:Object) : XMLNode { return XMLData.GetSlaveXML(slave, obj); }

}