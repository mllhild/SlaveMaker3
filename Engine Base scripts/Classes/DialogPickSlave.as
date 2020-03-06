// DialogPickSlave - select an owned slave
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogPickSlave extends DialogBase {
	
	// Pick an owned slave
	// Constructor
	public function DialogPickSlave(cg:Object)
	{ 
		super(cg.ParticipantsChanger, cg);
		
		mcBase.Parties.setStyle("borderStyle", "none");
		mcBase.Parties.tabChildren = true;
		mcBase.Parties.tabEnabled = false;
		mcBase.Slaves.setStyle("borderStyle", "none");
		mcBase.Slaves.tabChildren = true;
		mcBase.Slaves.tabEnabled = false;
		
	}

	
	// Choose a slave
	// note function SlavePicker.AddSlave() is in participants.as
	
	public function PickASlave(ptitle:String, mainside:Boolean, filterfnc:Function, cfnc:Function, timer:Number)
	{
		if (!coreGame.SlaveList.IsLoadedAll()) {
			if (timer != undefined) return;
			Timers.AddTimerShowWait(
				setInterval(this, "PickASlave", 50, ptitle, mainside, filterfnc, cfnc, Timers.GetNextTimerIdx())
			);
			return;
		}
		Timers.RemoveTimer(timer);
		Timers.StopWait();
		
		mcBase.ps = mainside;
		mcBase.filterfnc = filterfnc;
	
		coreGame.lfnc = cfnc;
		coreGame.rfnc = ShowAllSlaves;
		
		mcBase.ClearButton._visible = false;
		mcBase.DefaultBtn._visible = false;
		mcBase.LAddSlave._visible = false;
		mcBase.LSelections._visible = false;
		mcBase.Slaves._visible = !mainside;
		mcBase.Parties._visible = mainside;
		mcBase.LMaxMin._visible = false;
		mcBase.LAct.htmlText = ptitle;
		coreGame.PlanningSelections._visible = false;
		
		coreGame.dspMain.ShowTabBackground(false);
		coreGame.PlanningPage._visible = false;
		coreGame.dspMain.HideMainButtons();
		coreGame.HideAssistant();
		
		ShowAllSlaves();
		
		mcBase._visible = true;
		mcBase.Parties.invalidate();
		mcBase.Slaves.invalidate();
		coreGame.dspMain.ShowTabBackground(false);
	}
	
	public function ShowAllSlaves()
	{
		var ps:Boolean = mcBase.ps;
		var target:MovieClip = ps ? mcBase.Parties.content : mcBase.Slaves.content;
		mcBase.Parties.vScrollPolicy = "off";
		mcBase.Slaves.vScrollPolicy = "off";
		mcBase.Slaves._visible = !ps;
		mcBase.Parties._visible = ps;		
		mcBase._visible = true;
		coreGame.dspMain.HideGameTabs();
		coreGame.ClearGeneralArray2();
		coreGame.HideImages();
		
		var ti:DialogPickSlave = this;
		var image:MovieClip;
		var incsm:Boolean = false;
		if (mcBase.filterfnc(-100)) {
			image = AddSlave(-100, target);
			image._width = ps ? 200 : 145;
			image._height = ps ? 110 : 80;
			image.Btn.onPress = function() { ti.PickThisSlave(this._parent.sindex != undefined ? this._parent.sindex : this._parent._parent.sindex); }
			incsm = true;
		}
		
		if (mcBase.filterfnc(-99)) {
			image = AddSlave(-99, target);
			image._width = ps ? 200 : 145;
			image._height = ps ? 110 : 80;
			image.Btn.onPress = function() { ti.PickThisSlave(this._parent.sindex != undefined ? this._parent.sindex : this._parent._parent.sindex); }
			if (incsm) {
				if (ps) image._y = 112;
				else image._x = 145;
			}
		}
		
		var sgirl:Slave;
		var sll:Number = SMData.arUsableSlaves.length;
		for (var isl:Number = 0; isl < sll; isl++) {
			sgirl = SMData.arUsableSlaves[isl];
			if (sgirl == coreGame.AssistantData) continue;
			if (!mcBase.filterfnc(sgirl.SlaveIndex)) continue;
			image = AddSlave(sgirl.SlaveIndex, target);
			image._width = ps ? 200 : 145;
			image._height = ps ? 110 : 80;
			image.Btn.onPress = function() { ti.PickThisSlave(this._parent.sindex != undefined ? this._parent.sindex : this._parent._parent.sindex); }
			var tn:Number = coreGame.arGeneralArray2.length;
			if (ps) {
				if (tn > 1) image._y = coreGame.arGeneralArray2[tn - 2]._y + 112;
			} else {
				if ((tn % 3) == 1) {
					if (tn > 1) image._y = coreGame.arGeneralArray2[tn - 2]._y + 80;
				} else {
					var xp:Number = tn % 3;
					if (xp == 0) xp = 3;
					xp--;
					image._x = xp * 145;
					if (tn > 1) image._y = coreGame.arGeneralArray2[tn - 2]._y;
				}
			}
		}
	
		coreGame.intervalId3 = setInterval(_root, "ShowParticipantsScrollBar", 150);
		SMData.ShowSlaveMaker();
		if (coreGame.lfnc == coreGame.ShowSlaveTalk) coreGame.ShowLeaveButton();
		else if (coreGame.currPlace.IsThisPlace("SlaveMarket") == true) coreGame.ShowPlanningNext();
		coreGame.dspMain.HideGameTabs();
		mcBase._visible = true;
		mcBase.Parties.invalidate();
		mcBase.Slaves.invalidate();
		coreGame.dspMain.ShowTabBackground(false);

	}
	
	public function PickThisSlave(idx:Number)
	{
		coreGame.PersonIndex = idx;
		if (coreGame.PersonIndex >= 0) {
			if (coreGame.slaveData == SMData.SlavesArray[idx]) coreGame.PersonIndex = -50;
		}
		if (coreGame.PersonIndex < 0) coreGame.PersonName = coreGame.GetPersonsName(coreGame.PersonIndex);
		else coreGame.PersonName = SMData.GetSlaveByIndex(coreGame.PersonIndex).SlaveName;
		coreGame.dspMain.ShowTabBackground(true);
		coreGame.ClearGeneralArray2();
		coreGame.HideImages();
		mcBase.idx = idx;
		mcBase._visible = false;
		
		if (coreGame.lfnc != undefined) coreGame.lfnc();
	}
	
	
	public function AddSlave(part:Number, target:MovieClip) : MovieClip
	{	
		var image:MovieClip = target.attachMovie("Slave Choice", "Slave" + coreGame.arGeneralArray2.length, target.getNextHighestDepth());
		var tn:Number = coreGame.arGeneralArray2.push(image);
		if (tn < 10) image.Shortcut.text = tn;
		else image.Shortcut.text = String.fromCharCode(tn + 55);
		trace("AddSlave: " + tn + " " + target);
	
		image.enabled = true;
		image.tabEnabled = true;
		image.tabChildren = true;
		image.RemoveBtn._visible = false;
		var ti:DialogPickSlave = this;
		if (part != -100) {
			image.ReviewBtn.Label.htmlText = Language.strReview;
			image.ReviewBtn.Btn.onPress = function() { ti.ReviewSlave(this._parent._parent.sindex); }
		}
		image.RemoveBtn.Label.htmlText = Language.strRemove;
		image.Btn.onRollOver = function() { ti.SetMovieColour(this, 0, 0, 0, 0, 1, 1, 1, 0.1); };
		image.Btn.onRollOut = function() { ti.SetMovieColour(this, 0, 0, 0, 0, 1, 1, 1, 0); };
	
		image._visible = true;
		image.sindex = part;
		image.gindex = tn - 1;
		
		if (part == -50 || (part >= 0 || part == -99)) {
			var sgirl:Object = SMData.GetSlaveByIndex(part);
			trace("AddSlave: " + sgirl.SlaveName + " " + sgirl.SlaveType);
			var gnd:Number = sgirl.SlaveGender > 3 ? sgirl.SlaveGender - 3 : sgirl.SlaveGender;
			if (sgirl.IsDickgirl()) gnd = 3;
			image.GenderIcon.gotoAndStop(gnd);
			var ltemp:Number = Math.floor(sgirl.VarLovePoints / 12);
			if (sgirl.Sexuality < 25) SetMovieColour(image.LoveIcon, 0, 0, 200);
			if (ltemp > 6) ltemp = 6;
			if (sgirl.LoveAccepted == 1) image.LoveIcon.play();
			else image.LoveIcon.gotoAndStop((ltemp * 4) + 1);
			image.SlaveLabel.wordWrap = true;
			image.SlaveLabel.autoSize = true;
			if (sgirl.Titles != "") image.SlaveLabel.text = sgirl.Titles + " " + sgirl.SlaveName;
			else image.SlaveLabel.text = sgirl.SlaveName;
			//trace("..add " + image.SlaveLabel.text);
			var slh:Number = image.SlaveLabel._height;
			if (slh < 18) {
				slh = 18;
				image.SlaveLabel._height += 2;
				image.SlaveLabel.autoSize = false;
			}
			image.SlaveDescription.text = sgirl.vitalsDescription;
			image.SlaveDescription._y = image.SlaveLabel._y + slh;
			image.WeddingBells._visible = sgirl.IsMarried();
			image.sgirl = sgirl;
			SMData.ShowSlave(sgirl, 6, 14, 1, image.SlaveImage);
			trace("AddSlave2: " + sgirl.SlaveName + " " + sgirl.SlaveType);
		} else {
			if (part == -100) {
				image.WhiteBG._alpha = 100;
				image.ReviewBtn._visible = false;
				image.SlaveLabel.htmlText = Language.GetHtml("Yourself", "Participants");
				image.GenderIcon.gotoAndStop(SMData.Gender);
				image.LoveIcon.gotoAndStop(1);
				image.LoveIcon._visible = false;
				SMData.ShowSlaveMaker(1, 6, 14, 1, "", image.SlaveImage);
				image.WeddingBells._visible = false;
			} else {
				image.ReviewBtn._visible = false;
				image.LoveIcon.gotoAndStop(1);
				image.LoveIcon._visible = false;
				image.WeddingBells._visible = false;
				if (part == -1) {
					image.SlaveLabel.text = Language.GetHtml("RandomMale", "Participants");
					image.GenderIcon.gotoAndStop(1);
				} else if (part == -2) {
					image.SlaveLabel.text = Language.GetHtml("RandomFemale", "Participants");
					image.GenderIcon.gotoAndStop(2);
				} else if (part == -3) {
					image.SlaveLabel.text = Language.GetHtml("RandomDickgirl", "Participants");
					image.GenderIcon.gotoAndStop(3);
				} else if (part == -4) {
					image.SlaveLabel.text = Language.GetHtml("RandomMaleDickgirl", "Participants");
					image.GenderIcon.gotoAndStop(1);
					image.GenderIcon._visible = false;
				} else if (part == -5) {
					image.SlaveLabel.text = Language.GetHtml("RandomFemaleDickgirl", "Participants");
					image.GenderIcon.gotoAndStop(1);
					image.GenderIcon._visible = false;
				} else if (part == -6) {
					image.SlaveLabel.text = Language.GetHtml("RandomAny", "Participants");
					image.GenderIcon.gotoAndStop(1);
					image.GenderIcon._visible = false;
				}
				coreGame.AutoAttachAndShowMovie("Dice", 6, 13, 1, image.SlaveImage);
			}
		}
		return image;
	}
	
	
	// Review a Slave

	public function ReviewSlave(idx:Number, callback:String, callobj:Object)
	{
		SetText("");
		coreGame.HideDresses();
		coreGame.HideAssistant();
		coreGame.HideMenus();
		HideImages();
		
		var sdata:Slave = SMData.GetSlaveByIndex(idx);
		SMTRACE("ReviewSlave: " + idx + ") " + sdata.SlaveName + " " + sdata.SlaveType);
		if (sdata.sNode == null) sdata.sNode = Language.XMLData.GetSlaveXML(sdata.SlaveName, sdata);

		if (sdata.IsSlaveTrainedAs("Maid")) Backgrounds.ShowKitchen();
		else Backgrounds.ShowBedRoom();
		coreGame.StatisticsGroup.review = true;
		coreGame.GetSlaveInformation(idx);
				
		coreGame.dspMain.SetSlaveForGameTabs(sdata);
		coreGame.dspMain.SelectSingleGameTab(1);
		
		SMData.ShowSlaveMaker();
		
		if (idx != -50 && idx != -99) coreGame.LoadedSlaves.ChangeLoadedSlave(sdata);
		ReviewSlave2(idx, sdata, undefined, callback, callobj)
	}
		
	private function ReviewSlave2(idx:Number, sdata:Slave, timer:Number, callback:String, callobj:Object)
	{
		if (idx != -50 && idx != -99) {
			var sm:SlaveModule = coreGame.LoadedSlaves.GetLoadedSlave(sdata);
			if (sm == null) {
				if (timer == undefined) {
					Timers.AddTimer(
						setInterval(this, "ReviewSlave2", 20, idx, sdata, Timers.GetNextTimerIdx(), callback, callobj)
					)
				}
				return;
			}
			Timers.RemoveTimer(timer);
		}
		
		var sNode:XMLNode = Language.XMLData.GetSlaveObjectXML(sdata);
		var ret:Boolean = false;
		if (sNode != null) ret = Language.XMLData.XMLEventByNode(Language.XMLData.GetNode(sNode, "Planning/DoPlanning/SlaveReview"), false, undefined, false, true);

		if (!ret) {
			if (idx == -99) {
				if (coreGame.CurrentAssistant.ShowSlaveReview() != true) sdata.ShowMarketImage(1, 2);
			} else {
				if (coreGame.LoadedSlaves.IsLoadedSlave(sdata)) {
					var sm:SlaveModule = coreGame.LoadedSlaves.GetLoadedSlave(sdata);
					if (sm.ShowSlaveReview() != true) sdata.ShowMarketImage(1, 2);
				} else sdata.ShowMarketImage(1, 2);
			}
		}
			
		AddText("#person: " + sdata.vitalsDescription + "\r\r" + Language.strLineChanges(Language.XMLData.GetXMLMultiLineString("DescriptionDetailed", sNode)));
				
		if (callback != undefined) {
			if (callobj == undefined) callobj = coreGame;
			callobj[callback]();
		} else coreGame.ShowLeaveButton();
	}
	
	
	// XML
	//<PickSlave onpick='MyEventWithSlave' assistant='false' nonslaves='false'>Who will you Date?>/PickSlave>

	function ParsePickASlave(aNode:XMLNode)
	{
		var cap:String = aNode.firstChild.nodeValue;
		var evt:String = "";
		var assok:Boolean = false;
		var nonslaves:Boolean = false;
		var slaves:Boolean = true;
		var gnd:String = undefined;
	
		for (var attr:String in aNode.attributes) {
			if (attr.toLowerCase() == "onpick") evt = aNode.attributes[attr];
			else if (attr.toLowerCase() == "assistant") assok = aNode.attributes[attr].toLowerCase() == "true";
			else if (attr.toLowerCase() == "nonslaves") nonslaves = aNode.attributes[attr].toLowerCase() == "true";
			else if (attr.toLowerCase() == "slaves") slaves = aNode.attributes[attr].toLowerCase() == "true";
			else if (attr.toLowerCase() == "gender") gnd = aNode.attributes[attr].toLowerCase();
		}
	
		SMData.ShowSlaveMaker();
		coreGame.HideDresses();
	
		function SlaveFilter(idx:Number) {
			if (idx == -100) return false;
			if (idx == -99) return assok;
			var sgirl:Slave = SMData.SlavesArray[idx];
			if (gnd != undefined) {
				if (!coreGame.TestGender(gnd, sgirl.SlaveGender)) return false;
			}
			if (!nonslaves) {
				if (sgirl.SlaveType == 2 || sgirl.SlaveType == -20) return false;
			}
			if (slaves) return sgirl.SlaveType != -10;
			return false;
		}
		
		coreGame.StrEvent = evt;
		coreGame.PickASlave(cap, true, SlaveFilter, coreGame.DoEventNext);
	}


}
