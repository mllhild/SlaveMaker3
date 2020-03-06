// Housing
// Translation status: COMPLETE

import Scripts.Classes.*;

class HousesModule extends BaseModule
{
	public var Exploring:HouseExplore;
	
	public var Exploration:MovieClip;
	public var ExplorationTitle:MovieClip;
	public var depth:Number;
	
	private var arCustomHouses:Array;
	
	private var XMLData:GameXML;		// reference to corGame object
	
	
	public function HousesModule(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
		
		XMLData = coreGame.XMLData;
		
		Exploring = null;
		ResetCustomHouses();
	}
		
	
	// House Exploration

	public function InitialiseExploration(desc:String, desc2:String)
	{
		coreGame.HideImages();
		coreGame.HideSlaveActions();
		coreGame.HideDresses();
		coreGame.mcMain.MainWindowButton._visible = false;
		if (Exploring != null) {
			Exploring.Destroy();
			delete Exploring;
		}
		Exploring = new HouseExplore(1);
		Exploring.AddFloor(true);
		if (coreGame.config.bColoursOn) coreGame.ApplyColourBtn(ExplorationTitle, 0, 0.6);

		if (desc != undefined) mcBase.ExplorationTitle.HouseTitle.htmlText = desc;
		if (desc2 != undefined) mcBase.ExplorationTitle.HouseTitle2.htmlText = desc2;
		mcBase.ExplorationTitle.MapView.LText.htmlText = Language.GetHtml("MapView", "Buttons");
	}
	
	public function IsExploring() : Boolean { return Exploring != null; }
	
	public function ResetExploring()
	{
		if (Exploring != null) {
			Exploring.Destroy();
			delete Exploring;
			Exploring = null;
		}
	}
	
	public function AddFloor(current:Boolean)
	{
		Exploring.AddFloor(current);
	}
	
	public function AddRoomAndPosition(type:Number, desc:String, eventno:Object, xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number, explored:Boolean)
	{
		Exploring.CurrentFloor.AddRoom(type, desc, eventno, explored).MoveRoom(xpos, ypos, rwidth, rheight, rrotate);
	}
	
	public function AddDoorAndPosition(room1:Number, room2:Number, hidden:Boolean, xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number, locked:Boolean, eventno:Object, quiet:Boolean)
	{
		Exploring.CurrentFloor.AddDoor(room1, room2, hidden, eventno, locked, quiet).MoveDoor(xpos, ypos, rwidth, rheight, rrotate);
	}
	
	public function AddStairs(type:Number, eventno:Number, xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number)
	{
		Exploring.CurrentFloor.AddStairs(type, xpos, ypos, rwidth, rheight, rrotate, eventno);
	}
	
	public function AddDoorToRoom(room1:Number, room2:Number, dpos:Number, rwidth:Number, rheight:Number, eventno:Object, locked:Boolean, quiet:Boolean)
	{
		Exploring.CurrentFloor.AddDoorToRoom(room1, room2, dpos, rwidth, rheight, eventno, locked, quiet);
	}
	
	public function ShowCurrentFloor()
	{
		mcBase.ExplorationTitle._visible = true;
		Exploration._visible = true;
		Exploring.CurrentFloor.ShowFloor();
		Key.removeListener(coreGame.keyListenerMenu);
		coreGame.keyListenerMenu.onKeyUp = HouseListener;
		Key.addListener(coreGame.keyListenerMenu);
		coreGame.mcMain.MainWindowButton._visible = false;
	}
	
	public function HideCurrentFloor()
	{
		mcBase.ExplorationTitle._visible = false;
		Exploration._visible = false;
		Key.removeListener(coreGame.keyListenerMenu);
		coreGame.keyListenerMenu.onKeyUp = null;
	}
	
	public function HideCurrentFloorMap()
	{
		Exploration._visible = false;
	}
	
	public function GetCurrentRoomDescription() : String
	{
		return Exploring.CurrentFloor.GetCurrentRoomDescription();
	}
	
	public function IsCurrentRoomExplored() : Boolean
	{
		return Exploring.CurrentFloor.IsCurrentRoomExplored();
	}
	
	public function IsRoomExplored(room:Number) : Boolean
	{
		return Exploring.CurrentFloor.IsRoomExplored(room);
	}
	
	public function SetRoomExplored(room:Number)
	{
		Exploring.CurrentFloor.SetRoomExplored(room);
	}
	
	public function EnterRoom(room:Number)
	{
		Exploring.CurrentFloor.EnterRoomNo(room);
	}
	
	public function LockDoor(room1:Number, room2:Number)
	{
		Exploring.CurrentFloor.LockDoor(room1, room2);
	}
	
	public function UnlockDoor(room1:Number, room2:Number)
	{
		Exploring.CurrentFloor.UnlockDoor(room1, room2);
	}
	
	public function GetCurrentRoomType() : Number
	{
		return Exploring.CurrentFloor.GetCurrentRoomType();
	}
	
	public function SetCurrentRoom(room:Number)
	{
		return Exploring.CurrentFloor.SetCurrentRoom(room);
	}
	
	
	// Events
	 
	public function EventsUrgentAsAssistant(possible:Boolean)
	{
		if (possible && coreGame.currentCity.Home.HouseType == 6 && (coreGame.Elapsed == 11 || coreGame.Elapsed == 26 || coreGame.Elapsed == 34 || coreGame.Elapsed == 44 || coreGame.Elapsed == 58 || coreGame.Elapsed == 72)) {
			if (coreGame.SlaveGirl.TempleHouseRent() != true) {
				ServantSpeak("Today our rent for the temple is due.");
				if (coreGame.Elapsed == 11 || coreGame.Elapsed == 35 || coreGame.Elapsed == 58) {
					Points(0, 0, 2, 2, 6, 0, 0, 0, 1, 0, 0, 0, -1, 0, -2, 0, 0, 0, 0, 0);
					mcBase.House6Ceremony.gotoAndStop(1);
					AddText("\r\rA couple of junior priestesses arrive to do simple consecrations and rituals. #slaveis required to assist for the day, helping them with the rituals.");
					if (SMData.Corruption > 49) AddText("\r\rThe priestesses fearfully avoid you. Later in the day one tries to talk to you about the wrongs in following hell, but her voice tails off and she retreats.");
					if (SMData.SMFaith != 1) AddText("\r\rThese rituals are not of your faith but you do not have any prejudice against them.");
					else if (SMData.SpecialEvent == 5 || SMData.SpecialEvent == 6) AddText("\r\rYou feel a stirring in your cock at the sight of the priestesses.");
					AddText("\r\rThe priestesses leave late in the day.");
					Diary.AddEntry("Priestesses arrived to handle the rent of the temple house.");
					coreGame.DoEvent(6000);
				} else {
					Points(0, 2, 4, 2, 2, 2, 2, 2, 1, 0, 0, 0, -1, 0, -2, 1, 2, 0, 0, 0);
					mcBase.House6Ceremony.gotoAndStop(2);
					if (coreGame.Elapsed == 26) {
						Diary.AddEntry("High Priestess Daruna arrived to handle the rent of the temple house.");
						AddText("\r\rA large delegation from the church arrives, led by a high priestess named Daruna.\r\rShe is very imperious ordering everyone around casually. She treats #slave as just another servant and has #slavehimher perform a wide range of tasks.\r\rDaruna inspects the home and has #slave clean parts she feels that are not good enough. She then has #slave prepare meals for everyone.\r\rFor the rest of the day there are small ceremonies but you suspect Daruna is treating this as a holiday to rest and do as little as possible.\r\rAs she leaves she thanks you for the hospitality.");
						DoEvent(6000);
					} else {
						coreGame.SetTime(14);
						AddText("\r\rThe High Priestess Daruna arrives with a small party and informs you she will be performing inspections and ceremonies for the day and leaving in the evening. She is elegant and beautiful, but seems quite uninterested when talking about the ceremonies, brushing over them.\r\rFor the morning and early afternoon she does little beside rest and allow her party to entertain her. She does a token ceremony in the morning but nothing else.\r\rShe often asks #slave to tell her stories, dance or entertain her in other ways. Once or twice she lightly caresses #slave's " + coreGame.Plural("cheek") + " in an affectionate way and praises #slavehisher beauty.\r\rLate in the day she makes some odd references to Benten, the Goddess of Love and <i>other</i> types of entertainment. She asks you if you will allow #slave to 'entertain' her as the Goddess sometimes allows, for a small bonus payment? She smiles and tells you strictly that it is not some sort of prostitution! Nothing immoral is involved and no payment for service is involved, just a reward for yourself.");
						DoYesNoEventXY(6001);
					}
				}
				mcBase.House6Ceremony._visible = true;
			}
		}
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			// 6000 - ceremony at temple house
			 case 6000:
				coreGame.SetTime(18);
				coreGame.InitialisePlanning(false);
				return true;
				
			case 6999:
				HideCurrentFloor();
				SMData.ShowSlaveMaker();
				Exploring.Destroy();
				Exploring = null;
				if (coreGame.Plannings.IsStarted()) coreGame.DoPlanningNext();
				else coreGame.DoEventNext(9999);
				return true;
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		if (coreGame.StrEvent == "MoveHouse") {
			MoveHouse();
			return true;
		}
		
		switch(coreGame.NumEvent) {
			// 6001 - entertain high priestess
			case 6001:
				Diary.AddEntry("High Priestess Daruna arrived to handle the rent of the temple house and #slave 'entertained' her.");
				mcBase.House6Ceremony._visible = false;
				Backgrounds.ShowBedRoom();
				coreGame.UseGeneric = false;
				if (coreGame.HasCock) temp = Math.floor(Math.random()*3);
				else temp = Math.floor(Math.random()*2);
				switch (temp) {
					case 0: 
						coreGame.SlaveGirl.ShowSexActMasturbate();
						if (coreGame.UseGeneric) coreGame.Generic.ShowSexActMasturbate();
						SetText("Daruna, the high priestess, asks #slave to masturbate for her enjoyment, explaining how the gods approve of masturbation, and some assistance is permitted. She directs #slave to stand in one room while she watches from an adjacent room. A dividing door is partially closed so that #slave can only see the High Priestesses upper body. #slave hears a rustling of clothes and the High Priestess sighs and orders #slavehimher to start.\r\r");
						if (coreGame.HasCock) {
							if (coreGame.SlaveGender > 3) {
								if (coreGame.Aroused) SetText("#slave look at each other, a little surprised but they remove their clothes as they see Daruna whisper to someone in the other room 'slower'. They rub their cocks quickly erect and stroke their large cocks as Daruna watches passionately, whispering 'faster'. They enjoy performing before Daruna and their arousal grows quickly and they quickly gasp and cum, spurting jets of cum flying across the room. Daruna cries out and orgasms at the same time.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and happily ");
								else SetText("#slave look at each other, a little surprised but after a little they nervously remove their clothes as they see Daruna whisper to someone in the other room 'slower'. They rub their cocks, slowly becoming erect and stroke awkwardly as Daruna watches passionately, whispering 'faster'. They find Daruna's passionate gaze distracting and their arousal slowly grows, and they gasp and cum, spurting jets of cum flying across the room. Daruna cries out and orgasms at the same time.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and with some effort ");
							} else {
								if (coreGame.Aroused) SetText("#slave looks a little surprised but after a little #slaveheshe removes #slavehisher clothes and slowly rubs #slavehisher cock and quickly becomes erect, and then strokes #slavehisher cock faster and faster as Daruna watches passionately, whispering 'faster'. " + coreGame.SlaveHeSheUC + " seems to enjoy performing before Daruna and #slavehisher arousal grows quickly and #slavehisher cock explodes and sprays spurts of cum. Daruna cries out and orgasms at the same time.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and happily ");
								else SetText("#slave looks a little surprised but after a little #slaveheshe removes #slavehisher clothes and slowly rubs #slavehisher cock, slowly becoming erect, and then slowly strokes #slavehisher cock as Daruna watches passionately, whispering 'faster'. " + coreGame.SlaveHeSheUC + " seems to find Daruna's gaze distracting but strokes faster and faster, #slavehisher arousal slowly growing and then #slavehisher cock explodes and sprays spurts of cum. Daruna cries out and orgasms at the same time.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and with some effort ");
							}
						} else {
							if (coreGame.SlaveGender > 3) {
								if (coreGame.Aroused) SetText("#slave look a little surprised but after a little they remove their clothes as she sees Daruna whisper to someone in the other room 'slower'. They slowly rub their pussies and breasts as Daruna watches passionately, whispering 'faster'. They seem to enjoy performing before the audience and their arousal grows quickly and they bring themselves to strong, simultaneous, orgasms. Daruna cries out and orgasms at the same time.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and happily ");
								else SetText("#slave look a little surprised but after a little they remove their clothes as they see Daruna whisper to someone in the other room 'slower'. They slowly rub their pussies and breasts as Daruna watches passionately, whispering 'faster'. They seem to find the audience distracting but their arousal slowly grows and they eventually brings themselves, separately, to mild orgasms. Daruna cries out and orgasms a little later.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and with some effort ");
							} else {
								if (coreGame.Aroused) SetText("#slave looks a little surprised but after a little she removes her clothes as she sees Daruna whisper to someone in the other room 'slower'. She slowly rubs her pussy and breasts as Daruna watches passionately, whispering 'faster'. She seems to enjoy performing before the audience and her arousal grows quickly and she brings herself to a strong orgasm. Daruna cries out and orgasms at the same time.\r\rDaruna sighs and whispers 'keep licking' and then orders #slave to do it again, and happily ");
								else SetText("#slave looks a little surprised but after a little she removes her clothes as she sees Daruna whisper to someone in the other room 'slower'. She slowly rubs her pussy and breasts as Daruna watches passionately, whispering 'faster'. She seems to find the audience distracting but her arousal slowly grows and she eventually brings herself to a mild orgasm. Daruna cries out and orgasms a little later.\r\rDaruna sighs and whispers 'keep licking' and then order her to do it again, and with some effort ");
							}
						}
						AddText(coreGame.SlaveName + coreGame.NonPlural(" orgasm") + " again. Daruna then tells #slavehimher to do it again, and then again, until " + coreGame.SlaveHeSheIs + " sore and exhausted.\r\rAll the time Daruna has orgasm after orgasm, while watching #slave.");
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0);
						coreGame.TotalMasturbate = coreGame.TotalMasturbate+3;
						break;
					case 1:
						var oldles:Boolean = coreGame.Lesbian;
						coreGame.Lesbian = true;
						coreGame.UseGeneric = false;
						coreGame.SlaveGirl.Lesbian = true;
						coreGame.SlaveGirl.ShowSexActBlowjob();
						if (coreGame.UseGeneric) coreGame.Generic.ShowSexActBlowjob();
						if (!oldles) {
							coreGame.Lesbian = false;
							coreGame.SlaveGirl.Lesbian = false;
						}
						coreGame.TotalBlowjob++;
						if (coreGame.Lesbian) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0);
						SetText("Daruna, the High Priestess, removes her robes and has " + coreGame.SlaveName1 + " lick her pussy, commenting how assisted masturbation is permitted. She quickly moans and orgasms under " + coreGame.SlaveName1 + "'s tongue.. ");
						if (coreGame.SlaveGender > 3) AddText("She sighs and then asks " + coreGame.SlaveName2 + " to do the same. She has them alternate, licking her to orgasm after orgasm, until their tongues are tired.");
						else AddText("She sights and then asks #slave to do it again, licking her to orgasm after orgasm, until #slave's tongue is sore.\r\r");
						if (coreGame.TestObedience(coreGame.DifficultyBlowjob, 5)) AddText("After, she lies satisfied and thanks #slave.");
						else AddText("After, she lies satisfied and says she saw how reluctant #slave was and thanks #slavehimher for #slavehisher effort.");				
						break;
					case 2:
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -3, 0, 0, 0, 0, 0, 0, 0);
						coreGame.Generic.ShowSexActAnal(9);
						SetText("Daruna, the High Priestess, asks #slave to assist her to masturbate, explaining how the gods approve of masturbation, and some assistance is permitted. She rubs and tweaks her pussy and then raises her legs almost so her ankles are behind her head. She sighs and explains how #slave can help her to orgasm by fucking her ass with #slavehisher cock. After all, anal sex is not mentioned by the scriptures and as long as there is no chance of pregnancy, this is just masturbation.\r\r" + coreGame.SlaveName);
						if (coreGame.SlaveGender > 3) AddText(" look surprised but eagerly take turns fucking Daruna's ass, always taking case to cum deeply inside her ass to ensure no chance of pregnancy.");
						else AddText(" looks surprised but eagerly fucks Daruna's ass, making sure to follow her instructions and cums deeply inside her ass, to ensue no chance of pregnancy.");
						AddText("\r\rDaruna 'masturbates' herself to orgasm after orgasm...");
						break;
				}
				SMMoney(100);
				DoEvent(6000);
				AddText("\r\rDaruna's party leaves late in the day and as they are leaving Daruna looks at #slave, smiles and thanks #slavehimher for the 'entertainment'.\r\r");
				return true;
		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {	
			// 6001 - refuse to entertain high priestess
			case 6001:
				Diary.AddEntry("High Priestess Daruna arrived to handle the rent of the temple house but #slave refused to 'entertain' her.");
				Points(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				AddText("You refuse, Daruna is a disappointed but says, maybe next month.\r\rHer party leaves late in the afternoon.");
				coreGame.NumEvent = 9999;
				coreGame.ShowLeaveButton();
				return true;
		}
		return false;
	}
	
	
	// Images
	
	public function HideImages()
	{
		// note no call to super.HideImages()
		mcBase.House6Ceremony._visible = false;
		mcBase.House7._visible = false;
		mcBase.House10._visible = false;
		mcBase.ConstructionMenu._visible = false;
	}
	
	public function HideBG()
	{
		mcBase.BGHouse._visible = false;
	}
		
	public function HouseListener() {
		var key:Number = Key.getCode();
		switch(key) {
			case Key.ENTER: Exploration._visible = !Exploration._visible; break;
		}
	};
	
	
	// General House Functions
	
	public function StartNewSlave()
	{
		XMLData.XMLEventByNode(coreGame.currentCity.Home.xNode.parentNode, false, "StartNewSlave", true);
	}
		
	public function ChangeHouse(house, noshow:Boolean)
	{
		SMTRACE("HousesModule.ChangeHouse: " + house + " " + SMData + " " + coreGame.currentCity.Home.HouseType);
		if (house == undefined) {
			house = coreGame.currentCity.Home.HouseType;
			coreGame.currentCity.Home.InitialiseHouseByNumber(coreGame.currentCity.Home.HouseType);
			if (coreGame.currentCity.Home.hUpkeep == undefined) coreGame.currentCity.Home.hUpkeep = XMLData.GetXMLValue("Upkeep", coreGame.currentCity.Home.xNode, 6);
		} else {
			delete coreGame.currentCity.Home;
			coreGame.currentCity.Home = new HouseDetails(house, coreGame);
			coreGame.Home = coreGame.currentCity.Home;
			coreGame.currentCity.Home.ChangeHouse();
		}
		coreGame.House = house; // TODO remove
		if (noshow != true) {
			coreGame.HideImages();
			HideBackgrounds();
			ShowHouse(house);
		}

		// Map positon for button
		var iNode:XMLNode = XMLData.GetNode(coreGame.currentCity.Home.xNode, "MapPosition");
		var htype:Boolean = true;
		var xpos:Number = 0;
		var ypos:Number = 0;
		for (var attr:String in iNode.attributes) {
			switch(attr.toLowerCase()) {
				case "type": htype = iNode.attributes[attr].toLowerCase() == "left"; break;
				case "x": xpos = Number(iNode.attributes[attr]); break;
				case "y": ypos = Number(iNode.attributes[attr]); break;
			}
		}
		if (htype) coreGame.TakeAWalkMenu.House.LText.htmlText = "X " + Language.GetHtml("Home", "Buttons");
		else coreGame.TakeAWalkMenu.House.LText.htmlText = Language.GetHtml("Home", "Buttons") + " X";
		
		coreGame.TakeAWalkMenu.House._visible = true;
		coreGame.TakeAWalkMenu.House._x = xpos;
		coreGame.TakeAWalkMenu.House._y = ypos;
		
		// text information
		coreGame.SlaveMakerHousing.HouseDescriptionText.htmlText = Language.GetHtml("Description", coreGame.currentCity.Home.xNode, false, -1);
		coreGame.SlaveMakerHousing.HouseDetails.htmlText = Language.GetHtml("Details", coreGame.currentCity.Home.xNode);
		coreGame.SlaveMakerHousing.mcPurchasePrice.PriceText.htmlText = coreGame.currentCity.Home.Price;
		
		coreGame.currentCity.Home.HouseName = Language.GetHtml("Name", coreGame.currentCity.Home.xNode);
		coreGame.SlaveMakerHousing.HouseNameText.text = coreGame.currentCity.Home.HouseName;
		coreGame.SlaveMakerVitalsGroup.HouseLabel.text = coreGame.currentCity.Home.HouseName;
		
		// Add events
		XMLData.AddSlaveEvents(house.xNode, true);

		
		ApplyRelocations();
	}
	
	public function HouseIntroduction()
	{
		coreGame.ShowGirlsStoryStart();
		coreGame.GirlsStory._visible = true;
		coreGame.GirlsStoryTop._visible = true;
		coreGame.GirlsStoryTop.LTitle.htmlText = Language.GetHtml("NewHouse", "Housing", true);
		Backgrounds.ShowIntroBackground(0, 20, 0, 0, 0.8, 0.8, 0.8);

		coreGame.TxtValue = coreGame.currentCity.Home.hIncome;
		coreGame.genNumber = coreGame.TitleScreen.Introduction;
		XMLData.EventText = "";
		
		if (coreGame.TitleScreen.Introduction == 10) {
			XMLData.XMLEventByNode(coreGame.currentCity.Home.xNode.parentNode, false, "Introduction1", true);
			if (XMLData.GetNode(coreGame.currentCity.Home.xNode, "Introduction2") != null) coreGame.TitleScreen.Introduction = 9.1;
		} else {
			XMLData.XMLEventByNode(coreGame.currentCity.Home.xNode.parentNode, false, "Introduction2", true);
			coreGame.TitleScreen.Introduction = 9.2;
		}
		coreGame.SetIntroText(XMLData.EventText);
	
		Backgrounds.ShowHousing();
		coreGame.ShowLastMovie(4, 0);
		
		switch(coreGame.currentCity.Home.HouseType) {
			case 7:
				if (coreGame.TitleScreen.Introduction != 9) coreGame.ShowMovie(mcBase.House7, 4, 0, 1);
				break;
			case 10:
				coreGame.ShowMovie(mcBase.House10, 4, 0, 1);
				break;
		}
	
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();
		
		Exploration = mcBase.Exploration;
		ExplorationTitle = mcBase.ExplorationTitle;
		
		Exploration.Room._visible = false;
		Exploration.Passage._visible = false;
		Exploration.RoomRough._visible = false;
		Exploration.PassageRough._visible = false;
		Exploration.Room._visible = false;
		Exploration.TrapDoor._visible = false;
		Exploration.Stairs._visible = false;
		Exploration.Door.gotoAndStop(1);
		Exploration.Door._visible = false;

		var ti:HousesModule = this;
		ExplorationTitle.MapView.tabChildren = true;
		ExplorationTitle.MapView.Btn.onPress = function () {
			ti.mcBase.Exploration._visible = !ti.mcBase.Exploration._visible;
		}
		
		depth = mcBase.getNextHighestDepth();
		
		HideCurrentFloorMap();
	}
	
	public function GetTotalHouses()
	{
		var tot:Number = 0;
		var str:String;
		for (var hNode:XMLNode = XMLData.GetNodeC("Housing/Houses"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeName.toLowerCase() == "house") {
				str = XMLData.GetXMLStringSimple("City", hNode.firstChild);
				if (str != "" && str != coreGame.currentCity.ModuleName) continue;
				tot++;
			}
		}
		return tot;
	}
	
	public function ShowHouse(num:Number)
	{
		if (num == undefined || num > 10) num = coreGame.currentCity.Home.HouseType;

		if (!XMLData.XMLEventByNode(coreGame.currentCity.Home.xNode.parentNode, false, "ShowOutside", true)) {
			mcBase.BGHouse.gotoAndStop(num);
			ShowMovie(mcBase.BGHouse, 1.1, 2);
		}
	}
	
	public function MoveHouse()
	{
		coreGame.currentDialog = new DialogSelectHouse(coreGame);
		coreGame.currentDialog.ViewDialog(2);
	}

	
	// Custom Houses
	
	public function GetTotalCustomHouses() { return arCustomHouses.length; }

	public function FindCustomHouse(hname:String) : HouseDetails
	{
		hname = hname.toLowerCase().split(" ").join("").split("'").join("").split("\"").join("");
		for (var i:Number = 0; i < arCustomHouses.length; i++) {
			if (arCustomHouses[i].HouseName.toLowerCase().split(" ").join("").split("'").join("").split("\"").join("") == hname) return arCustomHouses[i];
			if (arCustomHouses[i].strNodeName.toLowerCase() == hname) return arCustomHouses[i];
			if (arCustomHouses[i].strNodeName.toLowerCase() == "customhouse-" + hname) return arCustomHouses[i];
		}
		return null;
	}
	
	function FindCustomHouseIdx(idx:Number) : HouseDetails
	{
		if (idx == undefined) idx = 0;
		if (idx < arCustomHouses.length) return arCustomHouses[idx];
		return null;
	}
	
	public function ResetCustomHouses()
	{
		var i:Number = arCustomHouses.length;
		if (i != undefined) {
			while (--i >= 0) {
				var ch:HouseDetails = HouseDetails(arCustomHouses.pop());
				ch.mcBase.removeMovieClip();
				delete ch.mcBase;
				delete ch;
			}
		}
		delete arCustomHouses;
		arCustomHouses = new Array();
	}
	
	public function HideCustomHouse(idx)
	{
		var chouse:HouseDetails;
		if (!isNaN(Number(idx))) chouse = FindCustomHouseIdx(Number(idx));
		else chouse = FindCustomHouse(String(idx));
		chouse.mcBase._visible = false;
		chouse.SetAccessible(false);
	}
	
	public function ShowCustomHouse(clabel:Object, xpos:Number, ypos:Number, hint:String)
	{
		var idx:Number;
		if (!isNaN(Number(clabel))) {
			FindCustomHouseIdx(Number(clabel)).mcBase._visible = true;
			return;
		} else {
			var chouse:HouseDetails = FindCustomHouse(String(clabel));
			if (chouse != null) {
				chouse.mcBase._visible = true;
				chouse.SetAccessible(true);
				return;
			}
		}
		chouse = SetCustomHouseDetails(0, String(clabel), xpos, ypos, hint);
		chouse.mcBase._visible = true;
	}
	
	public function SetCustomHouseDetails(idx:Number, clabel:String, xpos:Number, ypos:Number, hint:String) : HouseDetails
	{
		//trace("SetCustomHouseDetails: " + clabel + " " + xpos);
		var chouse:HouseDetails;
	
		if ((idx + 1) > GetTotalCustomHouses()) {
			for (var i:Number = GetTotalCustomHouses(); i < (idx + 1); i++) {
				
				chouse = new HouseDetails(0, coreGame);
				arCustomHouses.push(chouse);
				chouse.mcBase = coreGame.TakeAWalkMenu.attachMovie("Walk - Custom Place", "House" + i, coreGame.TakeAWalkMenu.getNextHighestDepth());
			}
		} else {
			chouse = FindCustomHouseIdx(idx);
		}
		
		var image:MovieClip = chouse.mcBase;
		image.chouse = chouse;
		
		chouse.Id = idx;
		
		chouse.HouseName = clabel;
		chouse.strNodeName = "CustomHouse-" + Language.strLineChanges(clabel).split(" ").join("").split("'").join("").split("\"").join("");
		
		var areaNode:XMLNode = coreGame.currentCity.areaNode;
		var plcNode:XMLNode = Language.XMLData.GetNode(areaNode, "Places/Relocations/" + chouse.strNodeName);
		if (plcNode == null) {
			plcNode = Language.XMLData.GetNode(areaNode, "Places/Relocations/" + Language.strLineChanges(clabel).split(" ").join("").split("'").join("").split("\"").join(""));
			if (plcNode == null) plcNode = Language.XMLData.GetNode(areaNode, "Places/Relocations/All");
		}
		if (plcNode != null) {
			if (plcNode.attributes.xpos != undefined) xpos = XMLData.GetExpression(plcNode.attributes.xpos);
			if (plcNode.attributes.ypos != undefined) ypos = XMLData.GetExpression(plcNode.attributes.ypos);
			if (plcNode.attributes.xoffset != undefined) xpos += XMLData.GetExpression(plcNode.attributes.xoffset);
			if (plcNode.attributes.yoffset != undefined) ypos += XMLData.GetExpression(plcNode.attributes.yoffset);
			if (plcNode.attributes.hint != undefined) image.HintText = plcNode.attributes.hint;
		}

		chouse.xpos = xpos;
		chouse.ypos = ypos;
		
		var ti:HousesModule = this;
		image.Btn.onPress = function() { ti.coreGame.currentCity.DoWalkHouse(-1 * (this._parent.chouse.Id + 1)); }
		
		coreGame.currentCity.AddWalkLocationCommon(image, clabel, xpos, ypos, hint);

		return chouse;
	}
	
	public function ApplyRelocations()
	{
		var i:Number = arCustomHouses.length;
		if (i != undefined) {
			var areaNode:XMLNode = coreGame.currentCity.areaNode;
			while (--i >= 0) {
				var chouse:HouseDetails = HouseDetails(arCustomHouses[i]);
				var plcNode:XMLNode = Language.XMLData.GetNode(areaNode, "Places/Relocations/" + chouse.strNodeName);
				if (plcNode == null) {
					plcNode = Language.XMLData.GetNode(areaNode, "Places/Relocations/" + Language.strLineChanges(chouse.HouseName).split(" ").join("").split("'").join("").split("\"").join(""));
					if (plcNode == null) plcNode = Language.XMLData.GetNode(areaNode, "Places/Relocations/All");
				}
				if (plcNode != null) {
					var xpos:Number = undefined;
					var ypos:Number = undefined;
					var hint:String = undefined;					
					if (plcNode.attributes.xpos != undefined) xpos = XMLData.GetExpression(plcNode.attributes.xpos);
					if (plcNode.attributes.ypos != undefined) ypos = XMLData.GetExpression(plcNode.attributes.ypos);
					if (plcNode.attributes.hint != undefined) image.HintText = plcNode.attributes.hint;
					var image:MovieClip = chouse.mcBase;
					if (xpos != undefined) {
						chouse.xpos = xpos;
						image._x = xpos + 7;
					}
					if (xpos != undefined) {
						chouse.ypos = ypos;
						image._y = ypos + 5;
					}
					if (hint != undefined) image.HintText = hint;
				}
			}
		}
	}
	
	public function CustomHouseHint(mc:MovieClip)
	{
		SetMovieColour(mc, 200, 200, 200);
		if (mc.HintText != "") ServantSpeak(mc.HintText);
	}
	
	public function HideCustomHint(mc:MovieClip)
	{
		SetMovieColour(mc, 0, 0, 0);
		coreGame.Hints.HideHints();
	}

	public function AddCustomHouseObj(clabel:String, xpos:Number, ypos:Number, hint:String) : HouseDetails
	{
		//trace("AddCustomHouse: " + clabel);
		var idx:Number;
		var chouse:HouseDetails = FindCustomHouse(clabel);
		if (chouse != null) idx = chouse.Id;
		else idx = GetTotalCustomHouses();
		chouse = SetCustomHouseDetails(idx, clabel, xpos, ypos, hint);
		return chouse;
	}
	public function AddCustomHouse(clabel:String, xpos:Number, ypos:Number, hint:String) : Number
	{
		var chouse:HouseDetails = AddCustomHouseObj(clabel, xpos, ypos, hint);
		return chouse.Id;
	}
	
	public function PushCustomHouses()
	{
		var hd:HouseDetails;
		for (var i:Number = 0; i < arCustomHouses.length; i++) {
			hd = arCustomHouses[i];
			hd.Push();
		}
	}
	public function HideAllCustomHouses(strArea:String)
	{
		var hd:HouseDetails;
		for (var i:Number = 0; i < arCustomHouses.length; i++) {
			hd = arCustomHouses[i];
			hd.Push();
			if (strArea != undefined) {
				if (hd.GetCityArea() != strArea) hd.mcBase._visible = false;
			} else hd.mcBase._visible = false;
		}
	}
	public function ResetAllCustomHouses()
	{
		var hd:HouseDetails;
		for (var i:Number = 0; i < arCustomHouses.length; i++) {
			hd = arCustomHouses[i];
			hd.bPushState = undefined;
		}
	}	
	public function PopCustomHouses()
	{
		var hd:HouseDetails;
		for (var i:Number = 0; i < arCustomHouses.length; i++) {
			hd = arCustomHouses[i];
			hd.Pop();
		}
	}	

	
	//XML
	
	public function AddAllCustomHouses(hNode:XMLNode)
	{
		for (var pNode:XMLNode = hNode; pNode != null; pNode = pNode.nextSibling) {
			if (pNode.nodeType != 1) continue;
			var str:String = pNode.nodeName.toLowerCase();
			if (str.substr(0, 12) == "customhouse-") ApplyHouseDetails(pNode);
		}	
	}
	
	public function ApplyHouseDetails(eNode:XMLNode)
	{
		var hname:String;
		var hhint:String;
		var xpos:Number;
		var ypos:Number;
		var bshow:Boolean = false;
		var carea:String = "";
		
		//trace("ApplyHouseDetails: " + eNode);
		
		for (var attr:String in eNode.attributes) {
			switch(attr.toLowerCase()) {
				case "name": hname = eNode.attributes[attr]; break;
				case "hint": hhint = eNode.attributes[attr]; break;
				case "show": bshow = XMLData.ParseConditionalString(eNode.attributes[attr], true, false); break;
				case "xpos": xpos = XMLData.GetExpression(eNode.attributes[attr]); break;
				case "ypos": ypos = XMLData.GetExpression(eNode.attributes[attr]); break;
				case "cityarea": carea = eNode.attributes[attr]; break;

			}
		}
		
		var chouse:HouseDetails = AddCustomHouseObj(hname, xpos, ypos, hhint);
		chouse.strNodeName = eNode.nodeName;
		chouse.AreaName = carea;
		if (bshow) chouse.mcBase._visible = true;
	}

	public function ParseHousing(str:String, aNode:XMLNode) : Boolean
	{
		if (str == "changehouse") {
			ChangeHouse(aNode.firstChild.nodeValue);
			return true;
		}
		if (str == "showcustomhouse" || str == "hidecustomhouse") {
			var nm:String = aNode.firstChild.nodeValue;
			var chouse:HouseDetails = FindCustomHouse(nm);
			if (chouse != null) {
				// inlined show/hidecustomhouse
				if (str == "hidecustomhouse") chouse.mcBase._visible = false;
				else chouse.mcBase._visible = true;
			}
			return true;
		}
		if (str == "showcurrentfloor") {
			ShowCurrentFloor();
			return true;
		}	
		if (str == "hidecurrentfloor") {
			HideCurrentFloor();
			return true;
		}
		if (str == "stopexploring") {
			DoEvent(6999);
			return true;
		}
		if (str == "setroomexplored") {
			SetRoomExplored(XMLData.GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "enterroom") {
			EnterRoom(XMLData.GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "setcurrentroom") {
			SetCurrentRoom(XMLData.GetExpression(aNode.firstChild.nodeValue));
			return true;
		}
		if (str == "lockdoor" || str == "unlockdoor") {
			var frmd:Number = 0;
			var tod:Number = 0;
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "from") frmd = XMLData.GetExpression(aNode.attributes[attr]);
				else if (attr.toLowerCase() == "to") tod = XMLData.GetExpression(aNode.attributes[attr]);
			}
			if (str == "lockdoor") LockDoor(frmd, tod);
			else UnlockDoor(frmd, tod);
			return true;
		}
		if (str == "exploration") {
			var desc:String = "";
			var desc2:String = "";
			for (var attr:String in aNode.attributes) {
				if (attr.toLowerCase() == "description") desc = aNode.attributes[attr];
				else if (attr.toLowerCase() == "description2") desc2 = aNode.attributes[attr];
			}
			InitialiseExploration(desc, desc2);
			
			var xpos:Number;
			var ypos:Number;
			var rwidth:Number;
			var rheight:Number;
			var evt:String;
			var type:Number;
			var desc:String;
			var rot:Number;
			var quiet:Boolean;
			
			for (var dNode:XMLNode = aNode.firstChild; dNode != null; dNode = dNode.nextSibling) {
				str = dNode.nodeName.toLowerCase();
				if (str == "room") {
					type = 1;
					xpos = 0;
					ypos = 0;
					rwidth = 60;
					rheight = 60;
					evt = undefined;
					rot = 0;
					desc = "";
					for (var attr:String in dNode.attributes) {
						var strl:String = attr.toLowerCase();
						if (strl == "type") type = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "xpos") xpos = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "description") desc = dNode.attributes[attr];
						else if (strl == "ypos") ypos = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "width") rwidth = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "height") rheight = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "rotate") rot = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "event") evt = dNode.attributes[attr];
					}
					AddRoomAndPosition(type, desc, evt, xpos, ypos, rwidth, rheight, rot, false);
					
				} else if (str == "door") {
					xpos = 0;
					rwidth = 5;
					rheight = 20;
					evt = undefined;
					type = -1;
					ypos = 0;
					quiet = false;
					for (var attr:String in dNode.attributes) {
						var strl:String = attr.toLowerCase();
						if (strl == "from") xpos = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "to") ypos = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "dpos") type = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "width") rwidth = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "height") rheight = XMLData.GetExpression(dNode.attributes[attr]);
						else if (strl == "event") evt = dNode.attributes[attr];
						else if (strl == "quiet") quiet = dNode.attributes[attr].toLowerCase() == "true";
					}
					AddDoorToRoom(xpos, ypos, type, rwidth, rheight, evt, false, quiet);
				}
			}
			return true;
		}
		return false;
	}
	
	// Load/Save
	public function CanLoadSave() : Boolean { return false; }	

	public function LoadGame(loaddata:Object)
	{
		if (loaddata == undefined) return;
		if (loaddata.arCustomHouses == undefined) return;
		if (loaddata.arCustomHouses.length == 0) return;
		
		for (var i:Number = 0; i < loaddata.arCustomHouses.length; i++) {
			// Could load here, but probably avoid for now for legacy reasons
				var chouse:HouseDetails = FindCustomHouse(loaddata.arCustomHouses.strNodeName);
				if (chouse != null) {
					if (chouse.IsAccessible()) chouse.mcBase._visible = true;
				}
		}
		
	}
		
	public function SaveGame(savedata:Object)
	{
		savedata.arCustomHouses = new Array();
		for (var i:Number = 0; i < arCustomHouses.length; i++) {
			var obj:Object = new Object;
			arCustomHouses.Save(obj);
			savedata.arCustomHouses.push(obj);
		}
	}
	
}
