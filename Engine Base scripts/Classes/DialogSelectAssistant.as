// DialogSelectAssistant - select an assistant
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogSelectAssistant extends DialogBase {
		
	private var cbasListener:Object;
	
	private var assNumber:Number;
	private var assPosition:Number;
	private var nQueueCnt;
	
	private var mclListener:Object;
	private var mcLoader:MovieClipLoader;
	
	private var checkboxListener:Object;
	private var cbListener:Object;

	private var XMLData:Object;		// reference to corGame object
	
	private var arAssArray:Array;
	
	private var ASSISTANTSLOTS:Number;

	
	// Constructor
	public function DialogSelectAssistant(cg:Object)
	{ 
		super(cg.AssistantSelection, cg);
		
		arAssArray = null;
		ASSISTANTSLOTS = 9;

		for (var i:Number = 1; i <= ASSISTANTSLOTS; i++) mcBase["AssistantChoice" + i].GenderIcon.gotoAndStop(1);

		// Combobox list
		mcBase.AssistantCombo.setStyle("backgroundColor", 0x7b4d29);
		mcBase.AssistantCombo.setStyle("color", 0xFFFFFF);
		mcBase.AssistantCombo.enabled = false;
		
		mclListener = new Object();
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(mclListener);

		var ti:DialogSelectAssistant = this;
		cbasListener = new Object();
		cbasListener.change = function (cbobj:Object) {
			if (cbobj.target.selectedItem.data != null) ti.AssistantChoicePress(cbobj.target.selectedItem.data);
		}
		
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
			ti.ViewDialog();
		}
		mcBase.ShowVanilla.addEventListener("click", checkboxListener);
	}
	
	public function ViewDialog()
	{
		InitialiseModule(null);		// force reset of SMData, Backgrounds etc objects, do not change visibilty state of movieclips
		
		//SMTRACE("ChooseAssistant/ViewDialog");
		XMLData = Language.XMLData;
		coreGame.changeloadstart = false;
		coreGame.Information.HideInformation();
		assNumber = -1;
		
		mcBase.LPersonal.htmlText = Language.GetHtml("PersonalGold", "Statistics", true, -1);
		mcBase.LMore.htmlText = Language.GetHtml("More", "Buttons");
		mcBase.LLoad.htmlText = Language.GetHtml("Load", "Buttons");
		
		Timers.ShowWait();
	
		var ti:DialogSelectAssistant = this;
		mclListener.onLoadInit = function() { ti.ChooseAssistantLoad(); }
		mclListener.onLoadError = function() { ti.ChooseAssistantLoadFailed(); }
		
		mcBase.ShowVanilla.label = Language.GetHtml("HideVanillaA", "Options");
		
		super.ViewDialog();
	}
	
	public function ShowDialogContents()
	{
		//trace("ShowDialogContents");
		if (arAssArray != null) {
			var i:Number = arAssArray.length;
			if (i == undefined) i = 0;
			while (--i >= 0) arAssArray[i] = null;
			delete arAssArray;
		}
		arAssArray = new Array();
		
		mcBase.ShowVanilla.selected = !coreGame.Options.bShowVanillaOn;

		ChooseAssistantLoad();
	}
	
	public function ChooseAssistantLoadFailed()
	{
		//trace("ChooseAssistantLoadFailed: " + assNumber);
		if (assNumber >= 0) {
			assNumber++;
			if (assNumber >= coreGame.SlaveList.arAssistants.length) ChooseAssistant2();
			else ChooseAssistantLoad();
		} else {
			assNumber--;
			if (Math.abs(assNumber) > (SMData.SlavesArray.length + 1)) assNumber = 1;
			ChooseAssistantLoad();
		}
	}
	
	public function SlaveSortFunc(a:Slave, b:Slave) : Number
	{
		var name1:String = a.SlaveName.toUpperCase();
		var name2:String = b.SlaveName.toUpperCase();
		if (name1<name2) return -1;
		if (name1>name2) return 1;
		return 0;
	
	}
	
	public function ChooseAssistantLoad(timer:Number)
	{
		if (XMLData.IsLoading() || !coreGame.SlaveList.IsLoadedAll()) {
			if (timer != undefined) return;
			Timers.AddTimer(
				setInterval(this, "ChooseAssistantLoad", 10, Timers.GetNextTimerIdx())
			)
			return;
		}
		//trace("ChooseAssistantLoad: " + assNumber);
		Timers.RemoveTimer(timer);
		var obj:Object;
		var aNode:XMLNode;
		var str:String;
		var nAdded = 0;
		var ad:Slave = null;
		
		do {
			aNode = null;
			if (assNumber > 0) {
				obj = coreGame.SlaveList.arAssistants[assNumber - 1];
				if (assNumber == 1 && (obj.xmlload == null || obj == undefined)) {
					ChooseAssistant2();
					break;		// no assistants at all
				}
				assNumber++;
				ad = SMData.GetSlaveDetails("Assistants/" + obj.AssistantFile, true);
				if (ad == null) {
					if (coreGame.currentCity.IsSlavePresent(obj.xmlload.firstChild.firstChild)) {
						//trace("unused " + obj.AssistantFile);
						coreGame.CreateAssistantFull("Assistants/" + obj.AssistantFile, obj.xmlload);
						ad = coreGame.AssistantData;
						aNode = ad.sNode;
						ad.SlaveIndex = -1 * arAssArray.length;
						arAssArray.push(ad);
						if (coreGame.ServantFilename.substr(-4) == ".swf") coreGame.LoadedAssistant.unloadMovie();
						nAdded++;
					}
					
					if ((assNumber - 1) >= coreGame.SlaveList.arAssistants.length) {
						//trace("done");
						arAssArray.sort(SlaveSortFunc);
						ChooseAssistant2();
						return;
					}
					obj = coreGame.SlaveList.arAssistants[assNumber - 1];
					break;
					 
				}
				
				// Existing
				//trace("existing");
				aNode = XMLData.GetNodeC(obj.xmlload.firstChild.firstChild, "Assistant");
				
			} else {
				assNumber--;
				if (Math.abs(assNumber) > (SMData.SlavesArray.length + 1)) {
					assNumber = 1;
					continue;
				}  
				obj = null;
				ad = SMData.GetSlaveByIndex(Math.abs(assNumber + 2));
				//trace("check list details " + sd.SlaveName);
				if (ad.SlaveType != -1) continue;
				if (coreGame.SlaveList.GetAssistantListDetails(ad.SlaveName) != null) continue;
				aNode = null;
			}
					
			// existing assistant
			ad.sNode = null;
			if (aNode == null) aNode = XMLData.GetSlaveXML(undefined, ad);
			
			// Check are they actually available here
			
			// Are they in the city?
			str = Language.XMLData.GetXMLStringSimple("City", aNode);
			if (str == coreGame.currentCity.ModuleName) str = "";		// Yes they are
			// Are the otherwise not available
			var iNode:XMLNode = XMLData.GetNode(aNode, "Available");
			if (iNode != null && coreGame.ParseConditional(iNode, true, false) == null) str = "no";
			
			// Not here
			if (str != "") {
				ChooseAssistantLoad();
				return;
			}
			arAssArray.push(ad);
			nAdded++;
			str = XMLData.GetXMLString("Renown", aNode);
			if (str != "") ad.SMReputationNeeded = XMLData.FixNumber(str); 
			ad.sNode = aNode;
			
			if (ad.ImageFolder.indexOf("Images/Assistants") == -1 && ad.ImageFolder.indexOf("Images/Slaves") == -1) ad.ImageFolder = strReplace(ad.ImageFolder, "Images/", "Images/Assistants/");
			
			if ((assNumber - 1) >= coreGame.SlaveList.arAssistants.length) {
				arAssArray.sort(coreGame.SlaveSortFunc);
				ChooseAssistant2();
				return;
			} 
			
		} while (assNumber >= 0 && obj.xmlload != null);
	
		//obj.xmlload = new XML();
		
		if (obj != null) coreGame.ServantFilename = "Assistants/" + obj.AssistantFile;
		else {
			if (ad == null) {
				ChooseAssistantLoad();
				return;
			}
			coreGame.ServantFilename = ad.SlaveFilename;
		}
		
		//trace("loading assistant: " + coreGame.ServantFilename);
		if (coreGame.ServantFilename.substr(-4) == ".swf") {
			mcLoader.loadClip(coreGame.ServantFilename, coreGame.LoadedAssistant);
		} else {
			if ((assNumber % 5) != 0) ChooseAssistantLoad();
			else Timers.AddTimer(
				setInterval(this, "ChooseAssistantLoad", 10, Timers.GetNextTimerIdx())
			)
		}
	}
	
	public function ChooseAssistant2()
	{
		//SMTRACE("ChooseAssistant2");
		assNumber = -1;
		assPosition = ASSISTANTSLOTS + 1;
		nQueueCnt = 0;
		Timers.StopWait();
		
		var ti:DialogSelectAssistant = this;
		mcBase.AssistantChoice1.onPress = function() { ti.AssistantChoicePress(this.sdata); }
		mcBase.AssistantChoice1.onRollOver = function() { ti.SetMovieColour(this, 25, 25, 25); };
		mcBase.AssistantChoice1.onRollOut = function() { ti.SetMovieColour(this, 0, 0, 0); };
		for (var i:Number = 2; i <= ASSISTANTSLOTS; i++) {
			mcBase["AssistantChoice" + i].onPress = mcBase.AssistantChoice1.onPress;
			mcBase["AssistantChoice" + i].onRollOver = mcBase.AssistantChoice1.onRollOver;
			mcBase["AssistantChoice" + i].onRollOut = mcBase.AssistantChoice1.onRollOut;
		}
		
		mcBase.LoadButton.onPress = function() { ti.coreGame.LoadSave.ViewLoadScreen(); }
		mcBase.MoreButton.onPress = function() {ti.DoAssistantMoreBtn(); }
	
		mcBase.tabChildren = true;
		mcBase.AssistantCombo.enabled = true;
		mcBase.AssistantCombo.addEventListener("change", cbasListener);
		mclListener.onLoadInit = function() {	ti.LoadAssistant(); }
		mclListener.onLoadError = function() { ti.LoadAssistantFailed(); }

		
		Beep();
		
		mcBase.LText1.htmlText = Language.GetHtml("ChooseAssistantTitle", "SlaveMarket", true);
		mcBase.LText2.htmlText = Language.GetHtml("ChooseAssistantDesc", "SlaveMarket", true);
		
		mcBase.AssistantCombo.removeAll();
		mcBase.AssistantCombo.addItem(Language.GetHtml("PickAssistant", "SlaveMarket"), null);
	
		var sdata:Slave;
		var cnt:Number = 0;
		for (var i:Number = 0; i < arAssArray.length; i++) {
			sdata = arAssArray[i];
			if ((sdata.BitFlag1.CheckBitFlag(93) && !coreGame.FurriesOn) || (sdata.BitFlag1.CheckBitFlag(94) && coreGame.TentaclesOn == 0) || (sdata.BitFlag1.CheckBitFlag(92) && !coreGame.Options.bShowVanillaOn) || (SMData.SMReputation < sdata.SMReputationNeeded)) continue;
			mcBase.AssistantCombo.addItem(sdata.SlaveName, sdata);
			cnt++;
		}
		for (var i:Number = 0; i < SMData.SlavesArray.length; i++) {
			sdata = SMData.SlavesArray[i];
			if (sdata.CanAssist == true && sdata.Available) {
				mcBase.AssistantCombo.addItem(sdata.SlaveName, sdata);
				cnt++;
			}
		}
		
		coreGame.HideAllImages();
		Backgrounds.ShowIntroBackgroundARGB(0xA87850);
		
		mcBase.LMore._visible = cnt > ASSISTANTSLOTS;
		mcBase.MoreButton._visible = cnt > ASSISTANTSLOTS;
		mcBase.SMGoldText.text = SMData.GuildMember ? SMData.SMGold : coreGame.VarGold;
		mcBase._visible = true;
		Backgrounds.ShowShop(3);
		coreGame.ShowLastMovie(2, 5);
	
		mcBase.AssistantCombo.selectedIndex = 0;
		mcBase.AssistantCombo.invalidate();
	
		DoAssistantMore();
	}
	
	public function DoAssistantMore()
	{
		coreGame.bAssistantLoaded = false;
		if (!mcBase._visible) return;
	
		if (assPosition > ASSISTANTSLOTS) {
			for (var i:Number = 1; i <= ASSISTANTSLOTS; i++) {
				mcBase["AssistantChoice" + i]._visible = false;
				mcBase["ShortCut" + i]._visible = false;
				mcBase["AssistantChoice" + i].AssistantImage.unloadMovie();
			}
			assPosition = 1;
		}
		var mc:MovieClip = mcBase["AssistantChoice" + assPosition];
	
		// find an assistant
		var sdata:Slave = null;
		
		if (assNumber != -1) {
			do {
				if (assNumber < 0) {
					sdata = SMData.SlavesArray[(assNumber + 2) * -1];
					if (sdata.SlaveType == 2 || sdata.CanAssist == true) break;
					assNumber--;
					if (Math.abs(assNumber + 2) >= SMData.SlavesArray.length) assNumber = 0;
				} else {
					sdata = arAssArray[assNumber];
					break;
				}
			} while (true);
		}
	
		coreGame.ResetAssistant();
	
		if (assNumber == -1) coreGame.ServantFilename = "";
		else coreGame.ServantFilename = sdata.SlaveFilename;
		var ext:String = coreGame.ServantFilename.substr(-4);
		if (ext == "") ext = ".xml";
		if (ext != ".xml") {
			ext = ".swf";
			mcLoader.loadClip(coreGame.ServantFilename, mc.AssistantImage);
		}
	
		mc.Reputation.htmlText = Language.GetHtml("InsufficientReputation", "SlaveMarket", true, -1);
		if (ext == ".xml") {
			Timers.AddTimer(
				setInterval(this, "LoadAssistant", 10, Timers.GetNextTimerIdx())
			)
		}
	}
	
	public function LoadAssistant(timer:Number)
	{
		Timers.RemoveTimer(timer);
	
		if (!mcBase._visible) return;
	
		var mcb:MovieClip = mcBase["AssistantChoice" + assPosition];
		
		coreGame.AssistantData = null;
		if (assNumber == -1) {
			mcb.AssistantImage._x = 0;
			mcb.AssistantImage._y = 0;
			mcb.AssistantImage._xscale = 100;
			mcb.AssistantImage._yscale = 100;
			mcb.AssistantImage._x = 0;
			mcb.AssistantImage._y = 0;
			mcb.AssistantImage._rotation = 0;
			mcb.sdata = null;
			
			var ti:DialogSelectAssistant = this;
			mcb.LoadDone = function(mc:MovieClip) {
				if (mc.loaderror == true) {
					// Failed, try again (only once)
					ti.coreGame.LoadImageAndShowMovie(mc, "Images/no-sign.png", 3, 0, mc._parent);
					return;
				}
				mc._x = 0;
				mc._y = 0;
				var ratio:Number = mc._height / mc._width;
				mc._width = 414;
				mc._height = 414 * ratio;
				if (mc._height > 600) mc._height = 600;
				mc.forceSmoothing = true;
				mc._visible = true;
			}
			var mc:MovieClip = coreGame.LoadImageAndShowMovie(undefined, "Images/no-sign.png", 3, 0, mcb.AssistantImage, 0, mcb.LoadDone);
			mcb.SlaveFilename = coreGame.ServantFilename;
			mcb.SMReputationNeeded = 0;
			mcBase["ShortCut"+assPosition]._visible = true;
			mcb.Description.htmlText = Language.GetHtml("NoAssistant", "Assistant");
			mcb._visible = true;
			
			mcb.GenderIcon._visible = false;
			mcb.Vanilla._visible = false;
			mcb.WeddingBells._visible = false;
			mcb.Reputation._visible = false;
			mcb.AssistantImage._visible = true;
			assPosition++;

		} else {
		
			if (assNumber < 0) coreGame.AssistantData = SMData.SlavesArray[(assNumber + 2) * -1];
			else coreGame.AssistantData = arAssArray[assNumber];
		
			var afound:Boolean = false;
			
			if (coreGame.AssistantData.CanAssist == false) {
				if (assNumber < 0) {
					if (coreGame.AssistantData.SlaveType != 1 && coreGame.AssistantData.SlaveType != 2) afound = true;
				}
			}
			
			var aNode:XMLNode = coreGame.AssistantData.sNode;
			if (aNode == null) aNode = XMLData.GetSlaveObjectXML(coreGame.AssistantData);
		
			trace("LoadAssistant: " + coreGame.AssistantData.SlaveName);
			XMLData.InitialiseAssistantXML(aNode);
		
			coreGame.ServantName = coreGame.AssistantData.SlaveName;
			coreGame.ServantGender = coreGame.AssistantData.SlaveGender;
			if (coreGame.AssistantData.SlaveImage == "") {
				if (coreGame.AssistantData.ImageFolder != "") coreGame.AssistantData.SlaveImage = coreGame.AssistantData.ImageFolder + "/Assistant.png";
				else coreGame.AssistantData.SlaveImage = coreGame.AssistantData.SlaveFilename.split(".")[0] + ".png";
			}
			
			mcb.AssistantImage._x = 0;
			mcb.AssistantImage._y = 0;
			mcb.AssistantImage._xscale = 100;
			mcb.AssistantImage._yscale = 100;
			mcb.AssistantImage._x = 0;
			mcb.AssistantImage._y = 0;
			mcb.AssistantImage._rotation = 0;
			mcb.sdata = coreGame.AssistantData;
			
			var gm:GenericSlave;
			var sm:SlaveModule = coreGame.modulesList.CreateSlaveModuleClassFromFilename(coreGame.ServantFilename, mcb.AssistantImage, coreGame.AssistantData, coreGame);
			if (sm == undefined || sm == null) {
				trace("..no class");
				sm = mcb.AssistantImage;
				sm.mcBase = mcb.AssistantImage;
				sm.slaveData = coreGame.AssistantData;
				sm.coreGame = coreGame;
			} else trace("got class");
			sm.ImageFolder = coreGame.AssistantData.ImageFolder;
			sm.InitialiseModule();
		
			sm.HideImages();
			sm.HideEndings();
			sm.HideDresses();
			sm.HideRobes();
			sm.HideSlaveActions();
			
			if ((coreGame.AssistantFurryNeeded && !coreGame.FurriesOn) || (coreGame.AssistantData.BitFlag1.CheckBitFlag(94) && coreGame.TentaclesOn == 0) || (coreGame.AssistantData.BitFlag1.CheckBitFlag(92) && !coreGame.Options.bShowVanillaOn)) afound = true;
			
			trace(afound);
			if (!afound) {
				trace("calling sm.InitialiseAsAssistant()");
				var mc:MovieClip = sm.InitialiseAsAssistant();
				if (coreGame.AssistantData.SlaveImage == "") {
					if (coreGame.AssistantData.ImageFolder != "") coreGame.AssistantData.SlaveImage = coreGame.AssistantData.ImageFolder + "/Assistant.png";
					else coreGame.AssistantData.SlaveImage = coreGame.AssistantData.SlaveFilename.split(".")[0] + ".png";
				}
			
				if (mc == undefined) {
					trace("returned undefined");
					mcb.AssistantImage.HideImages();
					mcb.AssistantImage.HideEndings();
					mcb.AssistantImage.HideDresses();
					mcb.AssistantImage.HideRobes();
					mcb.AssistantImage.HideSlaveActions();
					mc = mcb.AssistantImage.InitialiseAsAssistant();
					if (mc == undefined) mc = mcb.AssistantImage.Assistant;
				}
			
				mc._visible = true;
	
				mcb.SlaveFilename = coreGame.ServantFilename;
				mcb.SMReputationNeeded = coreGame.AssistantReputation;
				mcBase["ShortCut"+assPosition]._visible = true;
				mcb._visible = true;
				
				coreGame.AssistantData.SlaveName = coreGame.ServantName;
				coreGame.AssistantData.SlaveGender = coreGame.ServantGender;
				if (coreGame.ServantHeShe == "he" || coreGame.ServantHimHer == "him" && coreGame.ServantGender != 1) coreGame.ServantGender = 1;
				if (coreGame.ServantPronoun == Language.strDefPronoun && coreGame.ServantGender > 3) {
					coreGame.ServantPronoun = Language.strPronounTwins;
					coreGame.AssistantData.SlavePronoun = coreGame.ServantPronoun;
				}
		
				if (coreGame.AssistantData.DickgirlXF > 0) coreGame.ServantGender = coreGame.ServantGender > 3 ? 6 : 3;
				
				if (coreGame.AssistantDescription != "") coreGame.AssistantData.vitalsDescription = coreGame.AssistantDescription;
				else coreGame.AssistantDescription = coreGame.AssistantData.vitalsDescription;
		
				if (coreGame.AssistantData.SlaveType == 2) coreGame.AssistantCost = int(coreGame.AssistantCost * 0.67);
				if (assNumber < 0 && coreGame.AssistantData.SlaveType != 2) mcb.Description.htmlText = "<b>" + coreGame.AssistantData.GetFullName() + " - " + Language.GetHtml("OwnedSlave", "Assistant") + "</b>\r" + coreGame.UpdateMacros(coreGame.AssistantDescription);
				else mcb.Description.htmlText = "<b>" + coreGame.AssistantData.GetFullName() + " " + coreGame.AssistantCost + coreGame.GP +"</b>\r" + coreGame.UpdateMacros(coreGame.AssistantDescription);
		
				var sgnd:Number = coreGame.ServantGender;
				if (sgnd == 0 || sgnd > 6) mcb.GenderIcon._visible = false;
				else mcb.GenderIcon._visible = true;
				if (sgnd > 3) sgnd -= 3;
				mcb.GenderIcon.gotoAndStop(sgnd);
				mcb.Vanilla._visible = coreGame.AssistantVanilla;
				mcb.WeddingBells._visible = coreGame.AssistantData.IsMarried();
				mcb.Reputation._visible = SMData.SMReputation < coreGame.AssistantData.SMReputationNeeded;
				mcb.AssistantImage._visible = true;
				if (mc.loading != true) {
					mc._x = 0;
					mc._y = 0;
					var ratio:Number = mc._height / mc._width;
					mc._width = 414;
					mc._height = 414 * ratio;
					if (mc._height > 600) mc._height = 600;
					mc.forceSmoothing = true;
					mc._visible = true;
				}
				assPosition++;
			}
			delete sm;
			
		}
		if (assNumber >= 0) {
			assNumber++;
			if (assNumber >= arAssArray.length) {
				assNumber = -1;
				assPosition = ASSISTANTSLOTS + 1;
				coreGame.bAssistantLoaded = true;
				nQueueCnt = 0;
				return;
			}
		} else {
			assNumber--;
			if (Math.abs(assNumber + 2) >= SMData.SlavesArray.length) assNumber = 0;
		}
		if (assPosition <= ASSISTANTSLOTS) DoAssistantMore();
		else {
			coreGame.bAssistantLoaded = true;
			nQueueCnt = 0;
		}
	}
	
	
	function LoadAssistantFailed()
	{
		if (assNumber < 0) {
			assNumber = 0;
			DoAssistantMore();
		} else {
			assNumber++;
			if (assNumber >= SMData.SlavesArray.length) {
				assNumber = -1;
				assPosition = ASSISTANTSLOTS + 1;
				coreGame.bAssistantLoaded = true;
				nQueueCnt = 0;
			} else DoAssistantMore();
		}
	}
			
	public function DoAssistantMoreBtn(timer:Number)
	{
		if (coreGame.bAssistantLoaded == false) {
			if (timer != undefined || nQueueCnt > 0) return;
			nQueueCnt++;
			Timers.AddTimer(
				setInterval(this, "DoAssistantMoreBtn", 10, Timers.GetNextTimerIdx())
			)
			return;
		} else Timers.RemoveTimer(timer);
		DoAssistantMore();
	}
	
	public function AssistantChoicePress(sd:Slave)
	{
		if (sd != null && SMData.SMReputation < sd.SMReputationNeeded) {
			Bloop();
			return;
		}
		if (arAssArray != null) {
			var i:Number = arAssArray.length;
			if (i == undefined) i = 0;
			while (--i >= 0) arAssArray[i] = null;
			delete arAssArray;
			arAssArray = new Array();
		}
		
		mcBase.AssistantCombo.enabled = false;
		mcBase.AssistantCombo.removeEventListener("change", cbasListener);
		mcBase.AssistantCombo.close();
		Beep();
		HideBackgrounds();
		mcBase._visible = false;
		Backgrounds.ShowIntroBackground();
		for (var i:Number = 1; i <= ASSISTANTSLOTS; i++) {
			mcBase["AssistantChoice" + i].AssistantImage.DestroyAsAssistant();
			mcLoader.unloadClip(mcBase["AssistantChoice" + i].AssistantImage);
		}
		coreGame.ServantFilename = "";
		LeaveDialog();
		if (sd.SlaveIndex < 0) {
			trace("ADD SLAVE: (AssistantChoicePress) - " + sd.SlaveFilename);
			var idx:Number = SMData.SlavesArray.push(sd);
			sd.SlaveIndex = idx - 1;
		}
		coreGame.ChangeAssistant(sd, false);
	}
	
	
	public function Shortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean
	{
		if ((key == 13 || key == 37 || key == 39) && mcBase.MoreButton._visible) {
			DoAssistantMoreBtn();
			return true;
		}

		if (keya > 64 && keya < (65 + ASSISTANTSLOTS)) {
			if (mcBase["AssistantChoice" + (keya - 64)]._visible) {
				mcBase["AssistantChoice" + (keya - 64)].onPress();
				return true;
			}
		}
		if (keya == 76) {
			coreGame.LoadSave.ViewLoadScreen();
			return true;
		}
		return false;
	} 

}