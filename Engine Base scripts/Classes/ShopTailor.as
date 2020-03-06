// Tailor
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class ShopTailor extends Shop {
		
	// constructor
	public function ShopTailor(cg:Object, cc:Object)
	{ 
		super(cg.TailorMenu, cg, "Shopping/Shops/Tailors", cc);
	}
	
		// Visit the shop
	public function VisitShop()
	{
		super.VisitShop();
		
		coreGame.SlaveGirl.DoTailor();
		coreGame.BitFlag1.SetBitFlag(30);
		
		EnableChooseCustomer(mcBase.CustomerBtn);
		
		var ti:ShopTailor = this;
		mcBase.BtnDress1.onPress = function() { ti.AskToPurchaseItem(1, false); }
		mcBase.BtnDress1.onRollOver = function() { ti.AskToPurchaseItem(1, true); }
		mcBase.BtnDress1.onRollOut = coreGame.HideHints;
		
		mcBase.BtnDress2.onPress = function() { ti.AskToPurchaseItem(2, false);	}
		mcBase.BtnDress2.onRollOver = function() { ti.AskToPurchaseItem(2, true); }
		mcBase.BtnDress2.onRollOut = coreGame.HideHints;
		
		mcBase.BtnDress3.onPress = function() { ti.AskToPurchaseItem(3, false);	}
		mcBase.BtnDress3.onRollOver = function() { ti.AskToPurchaseItem(3, true); }
		mcBase.BtnDress3.onRollOut = coreGame.HideHints;
		
		mcBase.BtnDress4.onPress = function() { ti.AskToPurchaseItem(4, false); }
		mcBase.BtnDress4.onRollOver = function() { ti.AskToPurchaseItem(4, true); }
		mcBase.BtnDress4.onRollOut = coreGame.HideHints;
		
		mcBase.BtnDress5.onPress = function() { ti.AskToPurchaseItem(5, false); }
		mcBase.BtnDress5.onRollOver = function() { ti.AskToPurchaseItem(5, true); }
		mcBase.BtnDress5.onRollOut = coreGame.HideHints;
		
		mcBase.BtnDress6.onPress = function() { ti.AskToPurchaseItem(6, false); }
		mcBase.BtnDress6.onRollOver = function() { ti.AskToPurchaseItem(6, true); }
		mcBase.BtnDress6.onRollOut = coreGame.HideHints;
		
		mcBase.CustomerBtn.LText.htmlText = Language.GetHtml("Customer", "Buttons");
		mcBase.LText1.htmlText = Language.GetHtml("TailorsDresses", "Shopping");
		mcBase.LText2.htmlText = Language.GetHtml("TailorsUniforms", "Shopping");
		
		var sdo:Object = coreGame.PersonIndex == -50 ? coreGame.slaveData : sd;	
		for (var i:Number = 7; i < 13; i++) {
			var obj:Object = sdo.GetUniformDetails(i);
			var btn:MovieClip = mcBase["Btn" + obj.dss];
			btn.ActButton.onPress = function() { ti.AskToPurchaseItem(this._parent.curract, false);	}
			btn.ActButton.onRollOver = function() {	ti.AskToPurchaseItem(this._parent.curract, true); }
			btn.ActButton.onRollOut = coreGame.HideHints;			
			delete obj;
		}
	}
	
	public function ShowShopContents()
	{
		super.ShowShopContents();
		mcBase.CustomerBtn._visible = true;
		
		coreGame.dspMain.ShowTabBackground(true);

		var sdo:Object = coreGame.PersonIndex == -50 ? coreGame.slaveData : sd;
		
		if (coreGame.PersonIndex != -100) {
			// not slave maker
			ShowEquipmentButton();
			coreGame.OtherSlaveShown = coreGame.PersonIndex != -50;
			coreGame.PersonGender = sd.SlaveGender;
			if (coreGame.OtherSlaveShown) coreGame.UpdateSlaveCommon(sd);
			else coreGame.slaveData.CopyCommonDetails(_root, coreGame.slaveData);
			coreGame.dspMain.SelectGameTab(1);
	
		} else {
			coreGame.YourStats1.Btn.onPress();
			HideEquipmentButton();
			coreGame.PersonGender = SMData.Gender;
		}
		
		for (var i:Number = 1; i < 7; i++) {
			var sold:Boolean = sd.IsDressForSale(i);
			mcBase["Dress" + i + "Tick"]._visible = sold && sd.IsDressOwned(i);
			mcBase["Dress" + i].htmlText = sd.GetDressName(i);
			mcBase["Dress" + i]._visible = sold;
			mcBase["Dress" + i + "SC"]._visible = sold;
			mcBase["BtnDress" + i]._visible = sold;
		}
		
		for (var i:Number = 7; i < 13; i++) {
			var obj:Object = sdo.GetUniformDetails(i);
			var btn:MovieClip = mcBase["Btn" + obj.dss];
			var short:String = obj.dname[0];
			switch (i) {
				case 7: short = "B"; break;
				case 8: short = "L"; break;
				case 9: short = "<"; break;
				case 10: short = "S"; break;
				case 11: short = "X"; break;
				case 12: short = "Y"; break;
			}
			SetButtonDetails(btn, obj.owned == 1, true, obj.dname, i, short);
			btn._visible = obj.sell == 1;
			delete obj;
		}
			
		coreGame.HideDresses();
		ShowPurchaser(1);
		ShowPurchaser(0);
		Backgrounds.ShowTailors();
		coreGame.GetPersonGenderText();
		coreGame.dspMain.SelectGameTab(1);
	}
	
	public function EnableChooseCustomer(mc:MovieClip)
	{
		mc._visible = true;
		mc.tabChildren = true;

		var ti:ShopTailor = this;
		function PickCallback() { ti.CustomerPicked();	}
		
		mc.Btn.onPress = function() {
			ti.mcBase._visible = false;
			ti.coreGame.Quitter._visible = false;
			ti.HideEquipmentButton();
			function SlaveFilter(idx:Number) {
				if (idx == -100 || idx == -50) return true;
				if (idx < 0) return false;
				return ti.SMData.SlavesArray[idx].SlaveType == -10;
			}
			ti.coreGame.PickASlave(ti.Language.GetHtml("WhoWillBeServed", "Shopping"), true, SlaveFilter, PickCallback);
		}
	}
	
	public function AskToPurchaseItem(dressno:Number, hint:Boolean)
	{
		if (!IsEventAllowable() && hint) return;
		if (hint == true && !IsHints()) return;
		
		var sdo:Object = coreGame.PersonIndex == -50 ? coreGame.slaveData : sd;
		var owned:Number;
		var dname:String;
		var desc:String;
		var price:Number;
		
		if (dressno < 7) {
			var ds:Dress = sdo.GetDressRO(dressno);
			if (ds != null) {
				if (owned == undefined) owned = ds.IsDressOwned() ? 1 : 0;
				if (dname == undefined) dname = ds.strName;
				if (desc == undefined) desc = ds.strDescription;
				if (price == undefined) price = ds.nPrice;
			}
		} else {
			var obj:Object = sdo.GetUniformDetails(dressno);
			dname = obj.dname + "";
			owned = obj.owned;
			desc = obj.desc + "";
			price = obj.price;
			delete obj;
		}

		SetText("");
		coreGame.AppendActText = true;
		if (coreGame.PersonIndex == -50) {
			if (coreGame.SlaveGirl.PurchaseDress(dressno, owned, dname, desc, price, hint) == true) return;
		}
		if (!hint && owned == 1) {
			coreGame.HideYesNoButtons();
			ServantSpeak(Language.GetHtml("AlreadyOwnDress", "Shopping"));
		} else {
			if (hint != true) {
				coreGame.HideImages();
				coreGame.HideDresses();
				Backgrounds.ShowTailors();
				coreGame.SMAppearance._visible = false;
				if (dressno > 6) {
					mcBase._visible = false;
					coreGame.UseGeneric = true;
					if (coreGame.PersonIndex == -100) {
						coreGame.SMAvatar.AutoShowSlaveMaker(dressno, 1, 1, 1, "Images/Items/Mannequin.png");
						switch(dressno) {
							case 7:
								AddText("You try on the Bunny Suit.");
								break;
							case 8:
								AddText("You try on some lingerie.");
								break;
							case 9:
								AddText("You try on the maid uniform.");
								break;
							case 10:
								AddText("You try on the swimsuit.");
								break;
						}
						BlankLine();
					} else {
						switch(dressno) {
							case 7:
								if (coreGame.CurrentAssistant.ShowBunnySuitAsAssistant() != true) {
									if (coreGame.SlaveGirl.ShowBunnySuit() != true) {
										if (coreGame.UseImages) coreGame.ShowActImage(10017);
										if (coreGame.UseGeneric) coreGame.Generic.ShowBunnySuit(); 
									} else if (coreGame.AppendActText) {
										if (coreGame.PersonGender > 3) AddText("#slave try on the Bunny Suits.\r\r");
										else AddText("#slave tries on the Bunny Suit.\r\r");
									}
								}
								break;
							case 8:
								if (coreGame.CurrentAssistant.ShowLingerieAsAssistant() != true) {
									if (coreGame.SlaveGirl.ShowLingerie() != true) {
										if (coreGame.UseImages) coreGame.ShowActImage(10013);
										if (coreGame.UseGeneric) coreGame.Generic.ShowLingerie(); 
									} else if (coreGame.AppendActText) {
										if (coreGame.PersonGender > 3) AddText("#slave try on some lingerie.\r\r");
										else AddText("#slave tries on some lingerie.\r\r");
									}
								}
								break;
							case 9:
								if (coreGame.CurrentAssistant.ShowMaidUniformAsAssistant() != true) {
									if (coreGame.SlaveGirl.ShowMaidUniform() != true) {
										if (coreGame.UseImages) coreGame.ShowActImage(10018);
										if (coreGame.UseGeneric) coreGame.Generic.ShowMaidUniform(); 
									} else if (coreGame.AppendActText) {
										if (coreGame.PersonGender > 3) AddText("#slave try on the maid uniforms.\r\r");
										else AddText("#slave tries on a maid uniform.\r\r");
									}
								}
								break;
							case 10:
								if (coreGame.CurrentAssistant.ShowSwimsuitAsAssistant() != true) {
									if (coreGame.SlaveGirl.ShowSwimsuit() != true) {
										if (coreGame.UseImages) coreGame.ShowActImage(10014);
										if (coreGame.UseGeneric) coreGame.Generic.ShowSwimsuit(); 
									} else if (coreGame.AppendActText) {
										if (coreGame.PersonGender > 3) AddText("#slave try on the swimsuits.\r\r");
										else AddText("#slave tries on a swimsuit.\r\r");
									}
								}
								break;
							case 11:
							case 12:
								AddText("#slave tries on the " + dname + "\r\r");
								if (coreGame.SlaveGirl.ShowUniform(dressno - 10) != true) {
									if (coreGame.UseImages) coreGame.ShowActImage(10036 + dressno - 11);
								}
								break;
						}
					}
				} else {
					if (coreGame.PersonIndex == -100) {
						AddText("You try on the new clothing.\r\r");
						coreGame.SMAvatar.AutoShowSlaveMaker(-20000 - dressno, 1, 1, 1, "Images/Items/Mannequin.png");
					} else {
						if (coreGame.AppendActText) {
							if (coreGame.PersonGender > 3) AddText("#slave try on the dresses.\r\r");
							else AddText("#slave tries on the dress.\r\r");
						}
						var odress:Number = coreGame.DressWorn;
						coreGame.DressWorn = dressno;
						coreGame.ShowDress();
						coreGame.DressWorn = odress;
					}
				}
			}
			if (dressno == 6) PersonSpeakStart(23, dname + "\r\r\r" + Language.GetHtml("TailorDress6", "Shopping"));
			else {
				PersonSpeakStart(23, dname + "\r\r" + desc, true);
				if (dressno < 7) AddText("\r" + sdo.DescribeDress(dressno));
			}
			PersonSpeakEnd("\r" + PurchasePrice(price) + coreGame.GP);
			if (hint != true) {
				ShowPerson(23, 0, 1);
				BlankLine();
				if (coreGame.PersonGender > 3) AddText("Do you wish to buy these articles of clothing?");
				else AddText("Do you wish to buy this article of clothing?");
				DoYesNoItem(-1 * dressno);
			}
		}
		if (hint != true) Beep();
	}
	
	public function BuyDress(cost:Number) :Number
	{
		if (coreGame.PersonIndex == -50) {
			var bd:Number = coreGame.modulesList.BuyDress(cost);
			if (bd == 0 || bd == 1) return bd;
		}
		return BuyItem(23, cost, coreGame.PersonIndex != -50) ? -1 : -2;
	}
	
	public function BuyUniform(cost:Number) :Number
	{
		if (coreGame.PersonIndex == -50) {
			var bd:Number = coreGame.modulesList.BuyUniform(cost);
			if (bd == 0 || bd == 1) return bd;
		}
		if (BuyItem(23, cost, coreGame.PersonIndex != -50)) {
			if (coreGame.PersonIndex == -100) {
				SetText("You pack the costume away for when you need it");
			} else {
				SlaveSpeak("Thank you for the costume.");
				sd.VarLovePoints++;
			}
			return -1;
		}
		return -2;
	}
	
	public function BuyFromShop(itemno:Number)
	{	
		var sdo:Object = coreGame.PersonIndex == -50 ? coreGame.slaveData : sd;
		var owned:Number;
		var dname:String;
		var desc:String;
		var price:Number;
		
		if (itemno > -7) {
			var ds:Dress = sdo.GetDressRO(itemno * -1);
			if (ds != null) {
				if (owned == undefined) owned = ds.IsDressOwned() ? 1 : 0;
				if (dname == undefined) dname = ds.strName;
				if (desc == undefined) desc = ds.strDescription;
				if (price == undefined) price = ds.nPrice;
			}
		} else {
			var obj:Object = sdo.GetUniformDetails(itemno);
			dname = obj.dname + "";
			owned = obj.owned;
			desc = obj.desc + "";
			price = obj.price;
			delete obj;
		}
		
		if (itemno > -7) {
			// buy dress 0-6
			var dress:Number = itemno * -1;
			var ds:Object = sdo.GetDress(dress);
			var ret:Number = BuyDress(ds.nPrice);
			if (ret == 0 || ret == -2) return;
			sdo.SetDressOwned(dress); 
			HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0);
			if (ret != 1) {
				if (coreGame.PersonIndex == -100) {
					SetText("You pack the clothing away for you to wear when you return home.");
				} else {
					if (coreGame.SlaveFemale) SlaveSpeak("Thank you for the lovely clothing.");
					else SlaveSpeak("Thanks.");
					sd.VarLovePoints += 2;
				}
			}
	
		} else if (itemno == -7) {
			coreGame.HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0)
			mcBase._visible = true;
			if (BuyUniform(price) == -1) {
				sd.BunnySuitOK = 1;
				sdo.BunnySuitOK = 1;
			}
			
		} else if (itemno == -8) {
			coreGame.HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0)
			mcBase._visible = true;
			if (BuyUniform(price) == -1) {
				sd.LingerieOK = 1;
				sdo.LingerieOK = 1;
			}
			
		} else if (itemno == -9) {
			coreGame.HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0)
			mcBase._visible = true;
			if (BuyUniform(price) == -1) {
				sd.MaidUniformOK = 1;
				sdo.MaidUniformOK = 1;
				if (coreGame.PersonIndex == -50) Points(0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			}
		} else if (itemno == -10) {
			coreGame.HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0)
			mcBase._visible = true;
			if (BuyUniform(price) == -1) {
				sd.SwimsuitOK = 1;
				sdo.SwimsuitOK = 1;
			}
		} else if (itemno == -11) {
			coreGame.HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0)
			mcBase._visible = true;
			if (BuyUniform(price) == -1) {
				sd.CustomUniform1OK = 1;
				sdo.CustomUniform1OK = 1;
			}
		} else if (itemno == -12) {
			coreGame.HideImages();
			coreGame.HideSlaveActions();
			coreGame.HideDresses();
			ShowPurchaser(1);
			ShowPurchaser(0)
			mcBase._visible = true;
			if (BuyUniform(price) == -1) {
				sd.CustomUniform2OK = 1;
				sdo.CustomUniform2OK = 1;
			}
		}
		ShowShopContents();
	}

	public function DoInitialVisit()
	{
		bInitialVisit = false;
		XMLData.XMLGeneral("Shopping/TailorFirstVisit", true, coreGame.evtNode);
	}

	public function DoLaterVisit()
	{
		XMLData.XMLGeneral("Shopping/TailorLaterVisit", true, coreGame.evtNode);
	}

	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		switch(keya) {
			case 49:
				if (sd.IsDressForSale(1) || coreGame.PersonIndex == -100) { mcBase.BtnDress1.onPress(); return true; }
				break;
			case 50:
				if (sd.IsDressForSale(2) || coreGame.PersonIndex == -100) { mcBase.BtnDress2.onPress(); return true; }
				break;
			case 51:
				if (sd.IsDressForSale(3) || coreGame.PersonIndex == -100) { mcBase.BtnDress3.onPress(); return true; } 
				break;
			case 52: 
				if (sd.IsDressForSale(4) || coreGame.PersonIndex == -100) { mcBase.BtnDress4.onPress(); return true; } 
				break;
			case 53: 
				if (sd.IsDressForSale(5) || coreGame.PersonIndex == -100) { mcBase.BtnDress5.onPress(); return true; } 
				break;
			case 54: 
				if (sd.IsDressForSale(6) || coreGame.PersonIndex == -100) { mcBase.BtnDress6.onPress(); return true; } 
				break;
			case 66:
				if (sd.SellBunnySuit == 1 || coreGame.PersonIndex == -100) { mcBase.BtnBunnySuit.onPress(); return true; }
				break;
			case 76:
				if (sd.SellLingerie == 1 || coreGame.PersonIndex == -100) { mcBase.BtnLingerie.onPress(); return true; }
				break;
			case 77: 
				if (sd.SellMaidUniform == 1 || coreGame.PersonIndex == -100) { mcBase.BtnMaidUniform.onPress(); return true; }
				return;
			case 83: 
				if (sd.SellSwimsuit == 1 || coreGame.PersonIndex == -100) { mcBase.BtnSwimsuit.onPress(); return true; }
				break;
			case 88: 
				if (sd.SellCustomUniform1 == 1 && coreGame.PersonIndex == -50) { mcBase.BtnCustomUniform1.onPress(); return true; }
				break;	
			case 89: 
				if (sd.SellCustomUniform2 == 1 && coreGame.PersonIndex == -50) { mcBase.BtnCustomUniform2.onPress(); return true; }
				break;					
		}
		return false;
	}
}