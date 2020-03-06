// DialogSelectSlave - select a slave
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogSelectSlave extends DialogBase {
	
	private var mcSlaveSelectionBG:MovieClip;
		
	private var XMLData:GameXML;		// reference to corGame object
	private var SlaveList:TrainableSlaves;		// reference to corGame object

	private var SlaveNumber:Number;
	private var SlavePosition:Number;
	private var nSNumLastPage:Number;
	private var nSNumThisPage:Number;
	
	private var checkboxListener:Object;
	private var cbListener:Object;
	
	private var mcLoaderSS1:MovieClipLoader;
	private var mcLoaderSS2:MovieClipLoader;
	private var mcLoaderSS3:MovieClipLoader;
	private var mcLoaderSS4:MovieClipLoader;
	private var mcLoaderSS5:MovieClipLoader;
	private var mcLoaderSS6:MovieClipLoader;
	private var mcLoaderSS7:MovieClipLoader;
	private var mcLoaderSS8:MovieClipLoader;
	private var mcLoaderSS9:MovieClipLoader;
	private var loadListenerSS1:Object;
	private var loadListenerSS2:Object;
	private var loadListenerSS3:Object;
	private var loadListenerSS4:Object;
	private var loadListenerSS5:Object;
	private var loadListenerSS6:Object;
	private var loadListenerSS7:Object;
	private var loadListenerSS8:Object;
	private var loadListenerSS9:Object;
	
	private var intervalId4:Number;
	
	private var totadd:Number;
	
	private var SLAVESLOTS:Number;
	

// Slave Selection
	// Constructor
	public function DialogSelectSlave(cg:Object)
	{ 
		super(cg.SlaveSelection, cg);
		
		mcSlaveSelectionBG = null;
		SLAVESLOTS = 9;
		
		var ti:DialogSelectSlave = this;
		
		mcBase.Difficulty.gotoAndStop(1);
		mcBase.GenderIcon.gotoAndStop(2);
		
		// Combobox list
		mcBase.SlaveCombo.setStyle("backgroundColor", 0x7b4d29);
		mcBase.SlaveCombo.setStyle("color", 0xFFFFFF);
				
		cbListener = new Object();
		cbListener.change = function (cbobj:Object) {
			if (cbobj.target.selectedItem.data != null) ti.SlaveChoicePress(cbobj.target.selectedItem.data);
		}
		mcBase.SlaveCombo.addEventListener("change", cbListener);
		mcBase.SlaveCombo.enabled = false;
		
		// Vanilla Checkbox
		mcBase.ShowVanilla.setStyle("color", 0xFFFFFF);
	
		checkboxListener = new Object();
		checkboxListener.click = function(evt_obj:Object) {
			if (evt_obj.target.selected) {
				ti.coreGame.Options.bShowVanillaOn = false;
				ti.coreGame.Options.SaveOnlyGlobalData();
			} else {
				ti.coreGame.Options.bShowVanillaOn = true;
				ti.coreGame.Options.SaveOnlyGlobalData();
			}
			ti.SlaveNumber = 0;
			ti.SlavePosition = 0;
			ti.ViewDialog();
		}
		mcBase.ShowVanilla.addEventListener("click", checkboxListener);
		
		mcBase.InformationBtn.onRollOver = function() { ti.SlaveInformationRollOver(); }
		mcBase.SlaveChoice1.onPress = function() { ti.SlaveChoicePress(this.sd); }
		mcBase.SlaveChoice1.onRollOver = function() { ti.SlaveChoiceRollover(this);	}
		mcBase.SlaveChoice1.onRollOut = function() { ti.SlaveChoiceRollout(this); }
		for (var i:Number = 2; i <= SLAVESLOTS; i++) {
			mcBase["SlaveChoice" + i].onPress = mcBase.SlaveChoice1.onPress;
			mcBase["SlaveChoice" + i].onRollOver = mcBase.SlaveChoice1.onRollOver;
			mcBase["SlaveChoice" + i].onRollOut = mcBase.SlaveChoice1.onRollOut;
		}		
		mcBase.MoreButton.onPress = function() { ti.ShowDialogContents(); }
		mcBase.LessButton.onPress = function() {
			ti.SlaveNumber = ti.nSNumLastPage;
			ti.SlavePosition = 0;
			ti.ShowDialogContents();
		}
		mcBase.tabChildren = true;
	}
	
	public function LoadBackground()
	{
		ClearBackground();
		// Position, size = -76, -42, 1082, 660
		if (Language.LangType != "English") mcSlaveSelectionBG = coreGame.LoadImageAndPositionMovie(undefined, "Language/" + coreGame.Language.LangType + "/SlaveMarket.png|Language/English/SlaveMarket.png", -76, -42, 0, 1082, 660, mcBase.mcSlaveSelectionBG);
		else mcSlaveSelectionBG = coreGame.LoadImageAndPositionMovie(undefined, "Language/" + coreGame.Language.LangType + "/SlaveMarket.png", -76, -42, 0, 1082, 660, mcBase.mcSlaveSelectionBG);
	}
	public function ClearBackground()
	{
		if (mcSlaveSelectionBG == null) return;
		removeMovieClip(mcSlaveSelectionBG);
		mcSlaveSelectionBG = null;
	}
	
	public function ViewDialog()
	{
		XMLData = coreGame.XMLData;
		SlaveList = coreGame.SlaveList;
		
		SlaveNumber = 0;
		SlavePosition = 0;
		nSNumLastPage = 0;
		nSNumThisPage = 0;
		
		coreGame.HideAllImages();
		Timers.ShowWait();
		
		if (mcSlaveSelectionBG == null) LoadBackground();
		
		coreGame.ClearGeneralArray();
		
		mcBase.SlaveCombo.enabled = true;
		mcBase.SlaveCombo.removeAll();
		mcBase.SlaveCombo.addItem(Language.GetHtml("PickaSlave", "SlaveMarket"), null);

		InitialiseModule(null);		// force reset of SMData, Backgrounds etc objects, do not change visibilty state of movieclips
		Backgrounds.ShowIntroBackgroundBlack();
		Backgrounds.ShowSlaveMarket(1);
		coreGame.ShowLastMovie(2, 2);

		var str:String;
		var sdata:Slave;
		for (var msNode:XMLNode = XMLData.mslavesNode; msNode != null; msNode = msNode.nextSibling) {
			if (msNode.nodeType != 1) continue;
			if (msNode.nodeName.toLowerCase() == "slave") {
				str = XMLData.GetXMLStringSimple("Image", msNode.firstChild);
				sdata = SMData.GetSlaveDetailsFromImageName(str);
				if (sdata != null) sdata.sNode = msNode.firstChild;
			}
		}

		totadd = 0;
		ViewDialog2();
	}
	
	public function ViewDialog2(timer:Number)
	{
		Timers.RemoveTimer(timer);
		var sllen:Number = SlaveList.arSlaveList.length;
		var maxn:Number = sllen + SMData.SlavesArray.length;
		
		if (SlaveNumber < maxn) {
			var sdata:Slave = null;
			var nRenown:Number = 0;
			var aNode:XMLNode = null;
			
			if (SlaveNumber < sllen) {
				var slv:LoadVars = SlaveList.arSlaveList[SlaveNumber];
				//trace("Checking: " + slv.image);
				sdata = SMData.GetSlaveDetails(slv.image, true);
				if (sdata == null) {
					//trace("create temp slave");
					sdata = CreateSlaveFromLV(slv, undefined);
				} else if (sdata.SlaveFilename == "") {
					//trace("slave filename empty");
					var av:Boolean = sdata.Available;
					CreateSlaveFromLV(slv, sdata);
					sdata.Available = av;
				} //else trace("existing");
		
				aNode = XMLData.GetNodeC(slv.xmlload.firstChild.firstChild, "Slave");
				
				if (aNode != null) {
					str = XMLData.GetXMLString("Price", aNode);
					if (str != "") sdata.Price = XMLData.FixNumber(str);
				}

			} else {
				sdata = SMData.SlavesArray[SlaveNumber - sllen];
				
				if (!SlaveList.IsLoadedAll()) {
					if (sdata.ImageFolder.indexOf("Images/Assistants") != -1) {
						// wait for assistants xml to finish loading before handling this slave
						Timers.AddTimer(
							setInterval(this, "ViewDialog2", 10, Timers.GetNextTimerIdx())
						)
						return;
					}
				}
					
				//sdata.sNode = null;

				//trace("from SlavesArray Existing: " + sdata.SlaveImage );
				if (sdata.sNode == null) {
					aNode = XMLData.GetSlaveXML(undefined, sdata);
					//trace("..got node: " + aNode.parentNode.nodeName);
					sdata.sNode = aNode;
				}

				for (var sld:String in coreGame.arGeneralArray) {
					if (coreGame.arGeneralArray[sld] == sdata) {
						sdata = null;
						break;
					}
				}

			}
			
			if (aNode != null) {
				sdata.sNode = aNode;
				var str:String = XMLData.GetXMLString("Folder", aNode);
				if (str != "") sdata.ImageFolder = str;
				str = XMLData.GetXMLString("Image", aNode);
				if (str != "") sdata.SlaveImage = str;
				str = XMLData.GetXMLString("Name", aNode);
				if (sdata.SlaveName == "" && str != "") sdata.SlaveName = str;
				str = XMLData.GetXMLString("Vanilla", aNode);
				if (str != "") sdata.BitFlag1.ChangeBitFlag(92, str.toLowerCase() == "true");
				str = XMLData.GetXMLString("Renown", aNode);
				if (str != "") sdata.SMReputationNeeded = XMLData.FixNumber(str);
				str = XMLData.GetXMLString("TrainingDifficulty", aNode).toLowerCase();
				if (str != "") {
					if (str == "easy") sdata.SlaveDifficulty = 0;
					else if (str == "medium") sdata.SlaveDifficulty = 1;
					if (str == "hard") sdata.SlaveDifficulty = 2;
				}
				str = XMLData.GetXMLString("Gender", aNode).toLowerCase();
				if (str != "") sdata.SlaveGender = coreGame.GetGender(str);
			}
			
			if (sdata != null) {
				var available:Boolean = coreGame.SandboxMode;
				if (!available) {
					available = sdata.Available && (sdata.SlaveType == -100);
					if (!coreGame.bShowVanillaOn && sdata.BitFlag1.CheckBitFlag(92)) available = false;
				}
				
				if (!coreGame.currentCity.IsSlavePresent(aNode)) available = false;
			
				var trainable:Boolean = SMData.SMReputation >= sdata.SMReputationNeeded;
				var nottrain:Boolean = (coreGame.TentaclesOn == 0 && sdata.BitFlag1.CheckBitFlag(91)) || (coreGame.DickgirlsOn == 0 && sdata.BitFlag1.CheckBitFlag(89)) || (coreGame.FurriesOn == false && sdata.BitFlag1.CheckBitFlag(93)) || (coreGame.PregnancyOn == false && sdata.BitFlag1.CheckBitFlag(88)) || (coreGame.NonHumansOn == false && sdata.BitFlag1.CheckBitFlag(87)) || (coreGame.PonygirlsOn == false && sdata.BitFlag1.CheckBitFlag(86));
				//trace("trainable = " + trainable + " nottrain = " + nottrain);
				trainable = trainable && !nottrain;
				var iNode:XMLNode = XMLData.GetNode(aNode, "Available");
				if (iNode != null && coreGame.ParseConditional(iNode, true, false) == null) available = false;
				iNode = XMLData.GetNode(aNode, "Trainable");
				if (iNode != null && coreGame.ParseConditional(iNode, true, false) == null) trainable = false;
				//trace("available = " + available);
				//trace("adding slave: " + sdata.SlaveName + " " + (trainable && available));
				if (coreGame.SandboxMode || (trainable && available)) {
					//trace("..adding to combobox");
					mcBase.SlaveCombo.addItem(sdata.SlaveName, sdata);
					sdata.BitFlag1.SetBitFlag(85);
					totadd++;
				} else sdata.BitFlag1.ClearBitFlag(85);
	
				coreGame.arGeneralArray.push(sdata);
			}
			SlaveNumber++; 
			if (SlaveNumber < maxn) {
				if ((SlaveNumber % 5) != 0) ViewDialog2();
				else Timers.AddTimer(
					setInterval(this, "ViewDialog2", 10, Timers.GetNextTimerIdx())
				)
				return;
			}
		}
		
		
		mcBase.SlaveCombo.visible = true;
		mcBase.SlaveCombo.enabled = true;
		function upperCaseFunc(a, b) : Boolean
		{
			return a.label.toUpperCase() > b.label.toUpperCase();
		}
		mcBase.SlaveCombo.sortItems(upperCaseFunc);
		mcBase.SlaveCombo.selectedIndex = 0;
		mcBase.SlaveCombo.invalidate();
		
		coreGame.ResetSlave();
		Timers.StopWait();
				
		mcBase.ShowVanilla.label = Language.GetHtml("HideVanillaS", "Options");
		
		if (totadd <= SLAVESLOTS) {
			// only one page of slaves
			mcBase.MoreButton._visible = false;
			mcBase.LessButton._visible = false;
			mcBase.LLess._visible = false;
			mcBase.LMore._visible = false;
		} else {
			mcBase.LLess.htmlText = Language.GetHtml("Less", "Buttons");
			mcBase.LMore.htmlText = Language.GetHtml("More", "Buttons");
		}
		
		super.ViewDialog();		// will call ShowDialogContents()
	}
	
	public function ShowDialogContents()
	{
		mcBase._visible = true;
		mcBase.ShowVanilla.selected = !coreGame.Options.bShowVanillaOn;
		Backgrounds.ShowIntroBackgroundBlack();
	
		mcBase.Difficulty._visible = false;
		mcBase.GenderIcon._visible = false;
		mcBase.Vanilla._visible = false;
		mcBase.SlaveInformation.htmlText = "";
		var sllen:Number = SlaveList.arSlaveList.length;
		var maxn:Number = sllen + SMData.SlavesArray.length;

		if (SlaveNumber >= maxn) {
			SlaveNumber = 0;
			SlavePosition = 0;
		}
		nSNumLastPage = nSNumThisPage;
		nSNumThisPage = SlaveNumber;
	
		mcBase.MoreButton.enabled = true;
		mcBase.LoadButton.enabled = true;
		
		for (var i:Number = 1; i <= SLAVESLOTS; i++) mcBase["SlaveChoice" + i].enabled = true;
		
		if (SlavePosition == 0) {
			for (var i:Number = 1; i <= SLAVESLOTS; i++) {
				mcBase["SlaveChoice" + i]._visible = false;
				mcBase["SlavePrice" + i]._visible = false;
				mcBase["ShortCut" + i]._visible = false;
			}
		}
		
		CheckSlaveTrainable();
		Beep();
	}
	
	
	public function LoadInit(id:Number) {
		trace("LoadInit: " + id);
		this["mcLoaderSS" + id].removeListener(this["loadListenerSS" + id]);
		this["mcLoaderSS" + id] = null;
		ResizeSlaveButton(mcBase["SlaveChoice" + id], mcBase["SlavePrice" + id], id - 1);
	}
	
	public function ResizeSlaveButton(mc:MovieClip, mcPrice:MovieClip, pos:Number)
	{
		trace("ResizeSlaveButton: " + mc + " " + mcPrice + " " + pos);
		mc.stop();
		var xoffset:Number;
		var yoffset:Number;
		var sc:MovieClip;
		switch(pos) {
			case 0: xoffset = 0; yoffset = 117; sc = mcBase.ShortCut1; break;
			case 1:	xoffset = 0; yoffset = 375; sc = mcBase.ShortCut2; break;
			case 2:	xoffset = 200; yoffset = 117; sc = mcBase.ShortCut3; break;
			case 3:	xoffset = 200; yoffset = 375; sc = mcBase.ShortCut4; break;
			case 4:	xoffset = 406; yoffset = 117; sc = mcBase.ShortCut5; break;
			case 5:	xoffset = 602; yoffset = 117; sc = mcBase.ShortCut6; break;
			case 6:	xoffset = 602; yoffset = 375; sc = mcBase.ShortCut7; break;
			case 7:	xoffset = 802; yoffset = 117; sc = mcBase.ShortCut8; break;
			case 8:	xoffset = 802; yoffset = 375; sc = mcBase.ShortCut9; break;
		}
		var sd:Slave = mc.sd;
		
		var mci:MovieClip;
		if (sd.SlaveImage.indexOf(".") == -1) mci = mc["SlaveImageA"];
		else mci = mc["SlaveImage"];
		mci.forceSmoothing = true;
		var ratio:Number = mci._height / mci._width;
		if (ratio > 1) {
			mci._width = 600 / ratio;
			mci._height = 600;
		} else {
			mci._width = 414;
			mci._height = 414 * ratio;
		}
		mc.SlaveButton._width = mci._width;
		mc.SlaveButton._height = mci._height;
		if (ratio > 1) {
			mc._width = 190 / ratio;
			mc._height = 190;
		} else {
			mc._width = 190;
			mc._height = 190 * ratio;
		}
		mc._x = (xoffset + 70) - (mc._width / 2);
		mc._y = (yoffset + 192) - (mc._height);
	
		if ((!coreGame.SandboxMode && sd.Available == false) || (!coreGame.currentCity.IsSlavePresent(sd.sNode))) {
			// not available at all
			SlavePosition--;
			mc._visible = false;
		} else {
			mcPrice._visible = !SMData.GuildMember;
			mcPrice.Btn.enabled = false;
				
			if (sd.Price == undefined) sd.Price = 200;
			if (sd.Price == 0 || sd.Price == -1) mcPrice.LText.htmlText = Language.GetHtml("Free", "SlaveMarket");
			else if (sd.Price < 0) mcPrice.LText.htmlText = Language.GetHtml("OnCommission", "SlaveMarket");
			else mcPrice.LText.htmlText = sd.Price + coreGame.GP;
			
			if (sd.BitFlag1.CheckBitFlag(85) || coreGame.SandboxMode) SetMovieColour(mc, 0, 0, 0);
			else SetMovieColour(mc, -130, -130, -130);
			mc._visible = true;
		}
		
		SlavePosition++;
		SlaveNumber++;
	
		var maxn:Number = SlaveList.arSlaveList.length + SMData.SlavesArray.length;
		if (SlavePosition >= SLAVESLOTS) SlavePosition = 0;
		else if (SlaveNumber < maxn) CheckSlaveTrainable();
	}
	
	public function CheckSlaveTrainable()
	{
		clearInterval(intervalId4);
		var mc:MovieClip = mcBase["SlaveChoice" + (SlavePosition + 1)];

		var sdata:Slave = coreGame.arGeneralArray[SlaveNumber];
		//trace("CheckSlaveTrainable: " + sdata.SlaveName + " " + SlavePosition + " " + SlaveNumber);
		mc.sd = sdata;
		// semi inlined GetSlaveInformation
		coreGame.PersonGender = sdata.SlaveGender;		
		coreGame.PersonName = sdata.SlaveName;
		coreGame.PersonIndex = sdata.SlaveIndex;
		
		//var aNode:XMLNode = XMLData.GetSlaveXML(undefined, sdata);
		//var str:String = XMLData.GetXMLStringParsed("Image", aNode);
		//if (str != "") sdata.SlaveImage = str;
		
		var avail:Boolean = coreGame.SandboxMode;
		if (!avail) {
			avail = sdata.Available && (sdata.SlaveType == -100) && sdata.Available;
			if (!coreGame.Options.bShowVanillaOn && sdata.BitFlag1.CheckBitFlag(92)) avail = false;
		}
		var img:String = sdata.SlaveImage;
		//trace("avail = " + avail + " " + mc.enabled + " " + img);
		coreGame.RemoveAttachedMovie(mc["SlaveImageA"]);
		mc.SlaveImage._visible = false;
		mc["SlaveImageA"]._visible = false;
		if (img.indexOf(".") == -1) {
			var mcn:MovieClip = mc.createEmptyMovieClip("SlaveImageA", mc.getNextHighestDepth());
			var mca:MovieClip = coreGame.AttachMovie(img, mcn);
			mca._visible = true;
			ResizeSlaveButton(mc, mcBase["SlavePrice" + (SlavePosition + 1)], SlavePosition);
			return;
		}

		var ti:DialogSelectSlave = this;
		if (avail && mc.enabled) {
			var sp:Number = SlavePosition + 1;
			this["mcLoaderSS" + sp] = new MovieClipLoader();
			this["loadListenerSS" + sp] = new Object();
			this["mcLoaderSS" + sp].addListener(this["loadListenerSS" + sp]);
			this["loadListenerSS" + sp].onLoadInit = function() { ti.LoadInit(sp); }
			this["mcLoaderSS" + sp].loadClip(img, mc.SlaveImage);	
			return;
		}
	
		// skip to next slave
		SlaveNumber++;
		var maxn:Number = SlaveList.arSlaveList.length + SMData.SlavesArray.length;
		if (SlaveNumber < maxn) intervalId4 = setInterval(this, "CheckSlaveTrainable", 10);
	}
	
	public function SlaveChoicePress(sdata:Slave)
	{
		
		if (coreGame.TentaclesOn == 0 && sdata.BitFlag1.CheckBitFlag(91)) mcBase.SlaveInformation.htmlText = Language.GetHtml("TentaclesNeeded", "SlaveMarket");
		else if (coreGame.DickgirlsOn == 0 && sdata.BitFlag1.CheckBitFlag(89)) mcBase.SlaveInformation.htmlText = Language.GetHtml("DickgirlsNeeded", "SlaveMarket");
		else if (coreGame.FurriesOn == false && sdata.BitFlag1.CheckBitFlag(93)) mcBase.SlaveInformation.htmlText = Language.GetHtml("FurriesNeeded", "SlaveMarket");
		else if (coreGame.PregnancyOn == false && sdata.BitFlag1.CheckBitFlag(88)) mcBase.SlaveInformation.htmlText = Language.GetHtml("PregnancyNeeded", "SlaveMarket");
		else if (coreGame.NonHumansOn == false && sdata.BitFlag1.CheckBitFlag(87)) mcBase.SlaveInformation.htmlText = Language.GetHtml("NonHumansNeeded", "SlaveMarket");
		else if (coreGame.PonygirlsOn == false && sdata.BitFlag1.CheckBitFlag(86)) mcBase.SlaveInformation.htmlText = Language.GetHtml("PonygirlsNeeded", "SlaveMarket");
		else if (coreGame.SandboxMode == false && SMData.SMReputation < sdata.SMReputationNeeded) mcBase.SlaveInformation.htmlText = Language.GetHtml("NotRenownedEnough", "SlaveMarket");
		else if (sdata.BitFlag1.CheckBitFlag(85) == false) return;
		else {
			mcBase.SlaveCombo.enabled = false;
			mcBase.SlaveCombo.visible = false;
			mcBase.SlaveCombo.invalidate();
			for (var i:Number = 1; i <= SLAVESLOTS; i++) {
				mcBase["SlaveChoice" + i].enabled = false;
				SetMovieColour(mcBase["SlaveChoice" + i], -100, -100, -100);
			}	
			mcBase.MoreButton.enabled = false;
			mcBase.LoadButton.enabled = false;

			if (!SMData.GuildMember) {
				if (sdata.Price == undefined) Money(-200);
				else if (sdata.Price != 0 && sdata.Price != -1) Money(Number(sdata.Price) * -1);
			}
			
			coreGame.slaveData = sdata;
			XMLData.SetCurrentSlaveXML(null);
			
			if (sdata.SlaveIndex == -1) {
				//trace("ADD SLAVE: (SlaveChoicePress) - " + sd.SlaveFilename);
				sdata.SlaveIndex = SMData.SlavesArray.push(sdata);
				sdata.SlaveIndex--;
			}
			
			coreGame.ClearGeneralArray();
				
			coreGame.SlaveMovie.unloadMovie();
			coreGame.modulesList.SlaveGirl = undefined;
			coreGame.SlaveGirl = undefined;
			coreGame.SlaveFilename = sdata.SlaveFilename;
			if (coreGame.SlaveFilename == "Slaves/Slave-GenericSlave.swf") coreGame.SlaveFilename = sdata.SlaveImage.split(".")[0] + ".xml";
				
			//trace("reloading xml for " + coreGame.SlaveFilename + " " + sdata.SlaveName);
			Language.ChangeLanguage(false, "SlaveChoicePress2", this);
		}
	}
	
	public function SlaveChoiceError(target_mc:MovieClip, errorCode:String, httpStatus:Number)
	{
		SMTRACE("Load Error: " + target_mc + " " + errorCode + " " + httpStatus);
	}
	
	public function SlaveChoicePress2()
	{
		//trace("SlaveChoicePress2: " + coreGame.SlaveFilename);
		var ti:DialogSelectSlave = this;
		coreGame.mclListener.onLoadInit = coreGame.StartGame;
		coreGame.mclListener.onLoadError = function() { ti.SlaveChoiceError(); }
		coreGame.mcLoader.addListener(coreGame.mclListener);
	
		if (coreGame.SlaveFilename.indexOf(".xml") != -1 || coreGame.SlaveFilename == "") coreGame.StartGame();
		else coreGame.mcLoader.loadClip(coreGame.SlaveFilename, coreGame.SlaveMovie);
		coreGame.currentDialog = null;
	}
	
	public function SlaveChoiceRollover(mc:MovieClip)
	{
		var sd:Slave = mc.sd;
	
		if (sd.BitFlag1.CheckBitFlag(85) || coreGame.SandboxMode) SetMovieColour(mc, 25, 25, 25);
		else SetMovieColour(mc, -80, -80, -80);
		
		mcBase.SlaveCombo.close();
		mcBase.SlaveCombo._visible = false;
		mcBase.Difficulty._visible = false;
		mcBase.Vanilla._visible = false;
		mcBase.GenderIcon._visible = false;
		if (coreGame.TentaclesOn == 0 && sd.BitFlag1.CheckBitFlag(91)) mcBase.SlaveInformation.htmlText = Language.GetHtml("TentaclesNeeded", "SlaveMarket");
		else if (coreGame.DickgirlsOn == 0 && sd.BitFlag1.CheckBitFlag(89)) mcBase.SlaveInformation.htmlText = Language.GetHtml("DickgirlsNeeded", "SlaveMarket");
		else if (coreGame.FurriesOn == false && sd.BitFlag1.CheckBitFlag(93)) mcBase.SlaveInformation.htmlText = Language.GetHtml("FurriesNeeded", "SlaveMarket");
		else if (coreGame.PregnancyOn == false && sd.BitFlag1.CheckBitFlag(88)) mcBase.SlaveInformation.htmlText = Language.GetHtml("PregnancyNeeded", "SlaveMarket");
		else if (coreGame.NonHumansOn == false && sd.BitFlag1.CheckBitFlag(87)) mcBase.SlaveInformation.htmlText = Language.GetHtml("NonHumansNeeded", "SlaveMarket");
		else if (coreGame.PonygirlsOn == false && sd.BitFlag1.CheckBitFlag(86)) mcBase.SlaveInformation.htmlText = Language.GetHtml("PonygirlsNeeded", "SlaveMarket");
		else if (coreGame.SandboxMode == false && SMData.SMReputation < sd.SMReputationNeeded) mcBase.SlaveInformation.htmlText = Language.GetHtml("NotRenownedEnough", "SlaveMarket");
		else if (sd.BitFlag1.CheckBitFlag(85) == false) mcBase.SlaveInformation.htmlText = Language.GetHtml("NotTrainable", "SlaveMarket");		
		else {
			mcBase.SlaveInformation.htmlText = "<b>" + sd.SlaveName + ":</b>\r" + coreGame.UpdateMacros(sd.vitalsDescription);
			if (sd.SlaveDifficulty == 0) mcBase.Difficulty.gotoAndStop(2);
			else if (sd.SlaveDifficulty == 2) mcBase.Difficulty.gotoAndStop(4);
			else mcBase.Difficulty.gotoAndStop(3);
			mcBase.Difficulty._visible = true;
			mcBase.Vanilla._visible = sd.BitFlag1.CheckBitFlag(92);
			var sgnd:Number = sd.SlaveGender;
			if (sgnd > 3) sgnd -= 3;
			mcBase.GenderIcon.gotoAndStop(sgnd);
			mcBase.GenderIcon._visible = true;
		}
	}
	public function SlaveChoiceRollout(mc:MovieClip)
	{
		if (mc.sd.BitFlag1.CheckBitFlag(85) || coreGame.SandboxMode) SetMovieColour(mc, 0, 0, 0);
		else SetMovieColour(mc, -130, -130, -130);
	}
	
	public function SlaveInformationRollOver()
	{
		mcBase.SlaveCombo._visible = true;
		mcBase.Difficulty._visible = false;
		mcBase.Vanilla._visible = false;
		mcBase.GenderIcon._visible = false;
		mcBase.SlaveInformation.htmlText = "";
	}
	
	public function CreateSlaveFromLV(slv:LoadVars, sdata:Slave) : Slave
	{
		if (sdata == undefined) sdata = new Slave(coreGame);
		sdata.SlaveName = slv.girlname;
		sdata.SlaveGender = slv.gender == undefined ? 2 : Number(slv.gender);
		sdata.GenderIdentity = sdata.SlaveGender;
		if (sdata.SlaveGender > 3) sdata.SlavePronoun = coreGame.Language.strPronounTwins;
		if (slv.available == "false") sdata.Available = false;
		sdata.SlaveImage = "Slaves/" + slv.image;
		if (slv.gamefile == undefined) sdata.SlaveFilename = sdata.SlaveImage.split(".")[0] + ".xml";
		else {
			sdata.SlaveFilename = "Slaves/" + slv.gamefile;
			if (sdata.SlaveFilename == "Slaves/Slave-GenericSlave.swf") sdata.SlaveFilename = sdata.SlaveImage.split(".")[0] + ".xml";
		}
		if (slv.Folder != undefined && slv.Folder != "") sdata.ImageFolder = slv.Folder;
		sdata.SlaveType = -100;
		if (slv.slavetype == "minor") sdata.SlaveType = -201;
		else if (slv.slavetype == "assistant") sdata.SlaveType = -1;
		if (slv.assistant == "true") {
			sdata.SlaveType = -100;
			sdata.CanAssist = true;
		}

		if (slv.Price != undefined) sdata.Price = coreGame.XMLData.FixNumber(slv.Price);
		
		if (slv.renown == "none") sdata.SMReputationNeeded = 0;
		else if (slv.renown == "low") sdata.SMReputationNeeded = 10;
		else if (slv.renown == "medium") sdata.SMReputationNeeded = 30;
		else if (slv.renown == "high") sdata.SMReputationNeeded = 60;
		else if (slv.renown == "max") sdata.SMReputationNeeded = 100;
		else if (!isNaN(slv.renown)) sdata.SMReputationNeeded = Number(slv.renown);
		
		if (slv.Tentacles == "true") sdata.BitFlag1.SetBitFlag(91);
		if (slv.Dickgirls == "true") sdata.BitFlag1.SetBitFlag(89);
		if (slv.Furries == "true") sdata.BitFlag1.SetBitFlag(93);
		if (slv.Pregnancy == "true") sdata.BitFlag1.SetBitFlag(88);
		if (slv.NonHuman == "true") sdata.BitFlag1.SetBitFlag(87);
		if (slv.Ponygirls == "true") sdata.BitFlag1.SetBitFlag(86);
		if (slv.vanilla == "true") sdata.BitFlag1.SetBitFlag(92);
	
		sdata.vitalsDescription = slv.girldesc;
		if (slv.available == "false") sdata.Available = false;
		
		if (slv.mode != "") {
			if (slv.mode == "easy") sdata.SlaveDifficulty = 0;
			else if (slv.mode == "medium") sdata.SlaveDifficulty = 1;
			if (slv.mode == "hard") sdata.SlaveDifficulty = 2;
		}
		
		return sdata;
	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if (mcBase.LessButton._visible) {
			if (key == 37) {
				mcBase.LessButton.onPress();
				return true;
			} else if (key == 39) {
				ShowDialogContents();
				return true;
			}
		}
		if (key == 13) {
			ShowDialogContents();
			return true;
		}
		if (keya > 64 && keya < (65 + SLAVESLOTS)) {
			if (mcBase["ShortCut" + (keya - 64)]._visible) {
				mcBase["SlaveChoice" + (keya - 64)].onPress();
				return true;
			}
		}
		return false;
	} 
}

