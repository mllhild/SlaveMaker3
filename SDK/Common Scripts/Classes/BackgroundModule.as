// Backgrounds
// Linked to Backgrounds.swf
//
// Translation status: COMPLETE

import Scripts.Classes.*;
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Transform;

class BackgroundModule extends BaseModule
{
	// Images
	private var lastBG:MovieClip;
	
	private var colorTrans:ColorTransform;
	private var trans:Transform;

	
	public function BackgroundModule(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm, "Engine/Backgrounds.swf");
	}
	
	public function ResetBackgrounds()
	{
		coreGame.HouseEvents.HideBG();
		HideBG();
		mcBase.DressOverlay._visible = false;
	}
	
	public function GetLastBG() : MovieClip { return lastBG; }
	
	private function ShowBG(mco:Object, gframe:Number, flip:Boolean, colour:Number, align:Number)
	{
		if (gframe == undefined) gframe = 1;
		coreGame.HouseEvents.HideBG();
		HideBG();
		if (align == undefined) align = 5;
		if (flip) align += 100;
		ShowMovie(mco, 1.1, align, gframe);
		if (typeof(mco) == "string") lastBG = mcBase[mco];
		else lastBG = MovieClip(mco);
		if (colour != undefined) ShowOverlay(colour, true);
		else mcBase.DressOverlay._visible = false;
	}
	
	private function ShowBGOutside(mco:Object, gframe:Number, flip:Boolean, nonight:Boolean, colour:Number, align:Number)
	{
		ShowBG(mco, gframe, flip, colour, align);
		if (nonight != true) coreGame.SetMovieNight(lastBG);
	}

	
	// Specific Backgrounds
	
	public function ShowAlcove(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGAlcove, gframe, flip, gframe == 1 ? 0 : 0xffffff);
	}
	
	public function ShowAlley(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 1;
		ShowBGOutside(mcBase.BGAlley, gframe, flip, false, gframe != 3 ? 0 : 5);
	}
	
	public function ShowArena(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBGOutside(mcBase.BGArena, gframe, flip, false, undefined, 0);
	}
	
	public function ShowArmoury(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = (2 * Math.floor(Math.random()*2)) + 1;
		ShowBG(mcBase.BGArmoury, gframe, flip);
	}
	
	public function ShowBar(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBG(mcBase.BGBar, gframe, flip);
	}
	
	// gframe = -1 show your home room
	//  1-5 - normal
	//  6-16 - rich
	public function ShowBedRoom(gframe:Number, flip:Boolean)
	{
		ResetBackgrounds();
		var align:Number = flip == true ? 105 : 5;
		if (gframe == undefined) {
			if (coreGame.Home.HomeRoom == 0) {
				if (coreGame.Home.HouseType == 5) coreGame.Home.HomeRoom = Math.floor(Math.random()*11) + 6;
				else coreGame.Home.HomeRoom = Math.floor(Math.random()*5) + 1;
			}
			gframe = coreGame.Home.HomeRoom;
		} 
		ShowMovie(mcBase.BGRoom, 1.1, align, gframe);
		if (gframe == 8) ShowOverlay(0x3c3331, true);
	}
	
	public function ShowBath(gframe:Number, flip:Boolean)
	{
		ResetBackgrounds();
		var align:Number = flip == true ? 105 : 5;
		if (gframe == undefined) {
			if (coreGame.Home.HomeBath == 0) {
				if (coreGame.Home.HouseType == 5) coreGame.Home.HomeBath = Math.floor(Math.random()*2) + 1;
				else coreGame.Home.HomeBath = Math.floor(Math.random()*2) + 2;
			}
			gframe = coreGame.Home.HomeBath;
		}
		ShowMovie(mcBase.BGBath, 1.1, align, gframe);
	}
	
	public function ShowBeach(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*3) + 1 : Math.floor(Math.random()*2) + 5;
		ShowBGOutside(mcBase.BGBeach, gframe, flip, true);
	}
	
	public function ShowBeachRocks(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*2) + 7 : Math.floor(Math.random()*2) + 9;
		ShowBGOutside(mcBase.BGBeach, gframe, flip, true);
	}
	
	public function ShowCave(gframe:Number, fadein:Boolean, flip:Boolean)
	{
		ResetBackgrounds();
		var align:Number = flip == true ? 105 : 5;
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 1;
		if (fadein == true) coreGame.StartChangeImage(2000, mcBase.BGCave, gframe, "", undefined, coreGame.NextEvent);
		else ShowMovie(mcBase.BGCave, 1.1, align, gframe, 0);
		if (gframe < 3) coreGame.SetLastMovieNight();
	}
	
	public function ShowCellar(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBG(mcBase.BGCellar, gframe, flip);
	}
	
	public function ShowCemetary(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? slrandom(2) : 4;
		ShowBG(mcBase.BGCemetary, gframe, flip);
	}
	
	public function ShowCircus(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 1;
		ShowBGOutside(mcBase.BGCircus, gframe, flip);
	}
	
	public function ShowChapel(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGChapel, gframe, flip);
	}
	
	public function ShowDeepForest(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*8) + 1 : Math.floor(Math.random()*6) + 3;
		ShowBG(mcBase.BGDeepForest, gframe, flip, 0);
	}
	
	public function ShowDiningRoom(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*4) + 1;
		ShowBG(mcBase.BGDiningRoom, gframe, flip);
	}
	
	public function ShowDocks(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*3) + 1 : 4;
		ShowBG(mcBase.BGDocks, gframe, flip);
	}
	
	public function ShowDungeon(gframe:Number, flip:Boolean)
	{
		ResetBackgrounds();
		if (gframe == undefined) {
			if (coreGame.Home.HomeDungeon == 0) coreGame.Home.HomeDungeon = Math.floor(Math.random()*3) + 1;
			gframe = coreGame.Home.HomeDungeon;
		}
		ShowBG(mcBase.BGDungeon, gframe, flip, 0);
	}
	
	public function ShowFarm(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*6) + 1 : Math.floor(Math.random()*6) + 2;
		if (gframe != 7) ShowBGOutside(mcBase.BGFarm, gframe, flip);
		else ShowBG(mcBase.BGFarm, gframe, flip);
	}
	
	public function ShowFestival(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGFestival, gframe, flip, gframe == 1 ? 0xf42429 : 0);
	}
	
	public function ShowForest(gframe:Number, flip:Boolean)
	{
		ResetBackgrounds();
		var align:Number = flip == true ? 105 : 5;
		var specific:Boolean = gframe != undefined;
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*18) + 1 : Math.floor(Math.random()*5) + 3;
		if (IsDayTime() || specific) ShowMovie(mcBase.BGForest, 1.1, align, gframe);
		else ShowMovie(mcBase.BGDeepForest, 1.1, align, gframe);
	}
	
	public function ShowGarden(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*4) + 1 : Math.floor(Math.random()*3) + 5;
		ShowBG(mcBase.BGGarden, gframe, flip);
	
	}
	
	public function ShowGrass(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGGrass, gframe, flip);
	}
	
	public function ShowHallway(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*18) + 1;
		ShowBG(mcBase.BGHallway, gframe, flip);
	}
	
	public function ShowHouseOutside(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*10) + 1;
		if (gframe != 9) ShowBGOutside(mcBase.BGHouseOutside, gframe, flip);
		else ShowBG(mcBase.BGHouseOutside, gframe, flip);
	}
	
	public function ShowKennels(gframe:Number, flip:Boolean)
	{
		ShowBGOutside(mcBase.BGKennels, gframe, flip);
	}
	
	public function ShowKitchen(gframe:Number, flip:Boolean)
	{
		ResetBackgrounds();
		var align:Number = flip == true ? 105 : 5;
		if (gframe == undefined) {
			if (coreGame.Home.HomeKitchen == 0) {
				if (coreGame.Home.HouseType == 5) coreGame.Home.HomeKitchen = 2;
				else coreGame.Home.HomeKitchen = 1;
			}
			gframe = coreGame.Home.HomeKitchen;
		}
		ShowMovie(mcBase.BGKitchen, 1.1, align, gframe);
	}
	
	public function ShowLake(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*5) + 1 : 6;
		ShowBG(mcBase.BGLake, gframe, flip);
	}
	
	public function ShowLibrary(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*9) + 1;
		ShowBG(mcBase.BGLibrary, gframe, flip, 0);
	}
	
	public function ShowLivingRoom(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*12) + 1;
		ShowBG(mcBase.BGLivingRoom, gframe, flip);
	}
	
	public function ShowNight(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBG(mcBase.BGNight, gframe, flip, 0);
	}
	
	public function ShowOnsen(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*5) + 1 : 6;
		ShowBGOutside(mcBase.BGOnsen, gframe, flip, gframe == 6);
	}
	
	public function ShowOther(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*14) + 1;
		ShowBG(mcBase.BGOther, gframe, flip);
	}
	
	public function ShowPalace(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBGOutside(mcBase.BGPalace,gframe, flip);
	}
	
	public function ShowPotions(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 1;
		var col:Number = undefined;
		if (gframe == 2) col = 0;
		else if (gframe == 1) col = 0x16160e;
		ShowBG(mcBase.BGPotions, gframe, flip, col);
	}
	
	public function ShowRestaurant(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBG(mcBase.BGRestaurant,gframe, flip);
	}
	
	public function ShowRuinedTemple(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*5) + 1 : Math.floor(Math.random()*2) + 6;
		if (gframe < 7) ShowBGOutside(mcBase.BGRuins,gframe, flip);
		else ShowBG(mcBase.BGRuins,gframe, flip);
	}
	
	public function ShowSakura(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined)  gframe = IsDayTime() ? Math.floor(Math.random()*2) + 1 : 3;
		ShowBG(mcBase.BGSakura,gframe, flip);
	}
	
	public function ShowSalon(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGSalon, gframe, flip);
	}
	
	public function ShowSchool(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGSchool, gframe, flip);
	}
	
	public function ShowShop(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGShop, gframe, flip, 0);
	}
	
	public function ShowShip(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGShip, gframe, flip);
	}
	
	public function ShowSky(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 1;
		ShowBG(mcBase.BGSky, gframe, flip);
	}
	
	public function ShowSlaveMarket(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*4) + 1;
		if (gframe == 1) ShowBG("BGSlaveMarket", gframe, flip, 0, 1);
		else if (gframe == 4) ShowBG("BGSlaveMarket", gframe, flip, 0xffffff, 3);
		else ShowBG("BGSlaveMarket", gframe, flip);
	}
	
	public function ShowSlaveMakerRoom(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? 1 : 2;
		ShowBG(mcBase.BGSlaveMakerRoom, gframe, flip, 0);
	}
	
	public function ShowSlavePens(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGSlavePens, gframe, flip, 0x0A0404);
	}
	
	public function ShowSlums(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*3) + 1 : 3;
		ShowBG(mcBase.BGSlums, gframe, flip);
	}
	
	public function ShowSports(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? slrandom(2) : 3;
		ShowBG(mcBase.BGSports, gframe, flip);
	}
	
	public function ShowStables(gframe:Number, flip:Boolean)
	{
		ShowBGOutside(mcBase.BGStables, gframe, flip);
	}
	
	public function ShowSunset(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 4;
		ShowBG(mcBase.BGSky, gframe, flip);
	}
	
	public function ShowTailors(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.BGTailors, gframe, flip);
	}
	
	public function ShowTemple(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) {
			if (!IsDayTime() && PercentChance(50)) gframe = 8;
			else gframe = Math.floor(Math.random()*7) + 1;
		}
		if ((gframe == 4 || gframe == 6) && !IsDayTime()) gframe = gframe == 4 ? 8 : 9;
		ShowBG(mcBase.BGTemple, gframe, flip);
		if (gframe < 8) coreGame.SetLastMovieNight();
	}
	
	public function ShowTownCenter(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = IsDayTime() ? Math.floor(Math.random()*5) + 1 : Math.floor(Math.random()*3) + 6;
		ShowBG(mcBase.BGTownCenter, gframe, flip);
	}
	
	public function ShowTentacles(gframe:Number, flip:Boolean, align:Number)
	{
		ResetBackgrounds();
		if (align == undefined) align = 5;
		if (flip == true) align = align + 100;
		if (gframe == undefined) gframe = Math.floor(Math.random()*3) + 1;
		ShowMovie(mcBase.BGTentacles, 1.1, align, gframe);
	}
	
	public function ShowTunnels(gframe:Number, flip:Boolean)
	{
		ShowBG(mcBase.PlaceTunnels, gframe, flip, 0);
	}
	
	public function ShowTunnelsChamber(gframe:Number, flip:Boolean)
	{
		if (gframe == undefined) gframe = Math.floor(Math.random()*2) + 1;
		ShowBG(mcBase.PlaceTunnelsChamber, gframe, flip, 0);
	}
	
	public function ShowHousing()
	{
		if (coreGame.currentCity.Home.HouseType == 1) ShowHallway(17);
		else if (coreGame.currentCity.Home.HouseType == 2) ShowLivingRoom(14);
		else if (coreGame.currentCity.Home.HouseType == 3) ShowBedRoom(4);
		else if (coreGame.currentCity.Home.HouseType == 4) ShowHallway(10);
		else if (coreGame.currentCity.Home.HouseType == 5) ShowHallway(14);
		else if (coreGame.currentCity.Home.HouseType == 6) ShowHouseOutside(1);
		else if (coreGame.currentCity.Home.HouseType == 7) ShowOnsen(2);
		else if (coreGame.currentCity.Home.HouseType == 8) ShowBedRoom(16);
		else if (coreGame.currentCity.Home.HouseType == 9) ShowHallway(12);
		else if (coreGame.currentCity.Home.HouseType == 10) ShowShip(1);
		else {
			coreGame.HouseEvents.HideBG();
			HideBG();
			Language.XMLData.XMLEventByNode(coreGame.currentCity.Home.xNode.parentNode, false, "ShowInside", true);
		}
	} 
	
	public function ShowCurrentPlace(place:Number, gframe:Number, flip:Boolean)
	{
		if (place == undefined) place = coreGame.WalkPlace;
		var plc:Place = coreGame.currentCity.GetPlaceInstance(place);
		ShowBackground(Language.XMLData.GetXMLString("Name", coreGame.currentCity.FindPlaceNodeCByName(plc.strNodeName)), gframe, flip);
	}
	
	public function ShowBackground(str:String, gframe:Number, flip:Boolean)
	{
		switch(str.toLowerCase().split(" ").join("")) {
			case "alcove": ShowAlcove(gframe, flip); return;
			case "alley": ShowAlley(gframe, flip); return;
			case "arena": ShowArena(gframe, flip); return;
			case "armory":
			case "armoury": ShowArmoury(gframe, flip); return;
			case "sleazybar":
				if (gframe == undefined) gframe = 3;
				ShowBar(gframe, flip);
				return;
			case "bar": ShowBar(gframe, flip); return;
			case "bedroom": ShowBedRoom(gframe, flip); return;
			case "bath": ShowBath(gframe, flip); return;
			case "beachswim":
			case "beachwalk":
			case "beachprivate":
			case "beach": ShowBeach(gframe, flip); return;
			case "beachrocks": ShowBeachRocks(gframe, flip); return;
			case "cave": ShowCave(gframe, false, flip); return;
			case "cellar": ShowCellar(gframe, flip); return;
			case "cemetary": ShowCemetary(gframe, flip); return;
			case "circus": ShowCircus(gframe, flip); return;
			case "chapel": ShowChapel(gframe, flip); return;
			case "deepforest": ShowDeepForest(gframe, flip); return;
			case "diningroom": ShowDiningRoom(gframe, flip); return;
			case "docksport":
			case "docks": ShowDocks(gframe, flip); return;
			case "dungeon": ShowDungeon(gframe, flip); return;
			case "farm": ShowFarm(gframe, flip); return;
			case "festival": ShowFestival(gframe, flip); return;
			case "forest": ShowForest(gframe, flip); return;
			case "garden": ShowGarden(gframe, flip); return;
			case "grass": ShowGrass(gframe, flip); return;
			case "hallway": ShowHallway(gframe, flip); return;
			case "outside": ShowHouseOutside(gframe, flip); return;
			case "kennels": ShowKennels(gframe, flip); return;
			case "kitchen": ShowKitchen(gframe, flip); return;
			case "lake": ShowLake(gframe, flip); return;
			case "library": ShowLibrary(gframe, flip); return;
			case "livingroom": ShowLivingRoom(gframe, flip); return;
			case "night": ShowNight(gframe, flip); return;
			case "onsen": ShowOnsen(gframe, flip); return;
			case "other": ShowOther(gframe, flip); return;
			case "palace": ShowPalace(gframe, flip); return;
			case "potions": ShowPotions(gframe, flip); return;
			case "restaurant": ShowRestaurant(gframe, flip); return;
			case "ruins":
			case "ruinedtemple":
			case "temple": ShowRuinedTemple(gframe, flip); return;
			case "sakura": ShowSakura(gframe, flip); return;
			case "salon": ShowSalon(gframe, flip); return;
			case "school": ShowSchool(gframe, flip); return;
			case "ship": ShowShip(gframe, flip); return;
			case "shop": ShowShop(gframe, flip); return;
			case "sky": ShowSky(gframe, flip); return;
			case "slavemarket": ShowSlaveMarket(gframe, flip); return;
			case "slavemakerroom": ShowSlaveMakerRoom(gframe, flip); return;
			case "docksslavepens":
			case "docksslavepenssecure":
			case "slavepens": ShowSlavePens(gframe, flip); return;
			case "slums": ShowSlums(gframe, flip); return;
			case "sports": ShowSports(gframe, flip); return;
			case "ponystables":
			case "stables": ShowStables(gframe, flip); return;
			case "sunset": ShowSunset(gframe, flip); return;
			case "tailors": ShowTailors(gframe, flip); return;
			case "temple": ShowTemple(gframe, flip); return;
			case "towncentre":
			case "towncenter": ShowTownCenter(gframe, flip); return;
			case "tentacles": ShowTentacles(gframe, flip, 1); return;
			case "tunnels": ShowTunnels(gframe, flip); return;
			case "tunnelschamber": ShowTunnelsChamber(gframe, flip); return;
			case "house": 
				coreGame.HouseEvents.ShowHouse(gframe);
				coreGame.SetLastMovieNight();
				return;
			case "housing": ShowHousing(); return;
			case "rain": ShowRain(); return;
			case "snow": ShowSnow(); return;
		}
		
		// none of the above, treat it as an external image if it contains a /
		str = strReplace(str, "\\", "/");		// normalise to / paths
		if (str.indexOf("/") != -1) {
			coreGame.HouseEvents.HideBG();
			HideBG();
			coreGame.HideImages();
			AutoLoadImageAndShowMovie(str, 1.1, 5, mcBase);
		}
	}
	
	
	// Overlays
	
	public function SetOverlayFromMovie(mc:MovieClip, offsetx:Number, offsety:Number)
	{
		if (mc == undefined) mc = coreGame.lastmc;
		if (offsetx == undefined) offsetx = 3;
		else if (offsetx < 0) offsetx = mc._width + offsetx;
		if (offsety == undefined) offsety = 3;
		else if (offsety < 0) offsetx = mc._height + offsety;
		
		var bmps:BitmapData = new BitmapData(mc._width, mc._height, true, 0);
		bmps.draw(mc);
		var clr:Number = bmps.getPixel(offsetx, offsety);
		bmps.dispose();
		ShowOverlay(clr);
	}
	
	public function ShowOverlay(colour:Number, leavebg:Boolean)
	{
		if (leavebg != true) HideBackgrounds();
	
		colorTrans.rgb = colour;
		trans.colorTransform = colorTrans;
		mcBase.DressOverlay._visible = true;
	}
	
	public function ShowOverlayWhite() { ShowOverlay(0xffffff); }
	public function ShowOverlayBlack() { ShowOverlay(0); }

	
	// Intro Background
	
	public function ShowIntroBackground(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number, top:Boolean)
	{
		if (red == undefined) ShowIntroBackgroundARGB(undefined, top);
		else {
			var mc:MovieClip = top == true ? coreGame.SlaveMarketOverlay : coreGame.IntroBackground;
			coreGame.SetMovieColour(mc, red, green, blue, alphao, redmul, greenmul, bluemul, alphamul);
			mc._visible = true;
		}		
	}
	public function ShowIntroBackgroundTop(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number, top:Boolean) { ShowIntroBackground(red, green, blue, alphao, redmul, greenmul, bluemul, alphamul, true); }

	public function ShowIntroBackgroundARGB(colour:Number, top:Boolean)
	{
		var mc:MovieClip = top == true ? coreGame.SlaveMarketOverlay : coreGame.IntroBackground;
		if (colour == undefined) coreGame.SetMovieColour(mc, 44, 74, 0, 0, 0.7, 0.7, 0.7, 1);
		else coreGame.SetMovieColourARGB(mc, colour);
		mc._visible = true;
	}
	public function ShowIntroBackgroundTopARGB(colour:Number) { ShowIntroBackgroundARGB(colour, true); }
	
	public function HideIntroBackground(top:Boolean)
	{
		var mc:MovieClip = top == true ? coreGame.SlaveMarketOverlay : coreGame.IntroBackground;
		mc._visible = false;
	}
	public function HideIntroBackgroundTop() { coreGame.SlaveMarketOverlay._visible = false; }
	
	public function ShowIntroBackgroundWhite(top:Boolean) { ShowIntroBackgroundARGB(0xffffff, top); }
	public function ShowIntroBackgroundBlack(top:Boolean) { ShowIntroBackground(0, 0, 0, 0, 0, 0, 0, undefined, top); }
	
	
	// Slave's Story
	
	public function SetStoryColour(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number)
	{
		coreGame.SetMovieColour(coreGame.GirlsStory, red, green, blue, alphao, redmul, greenmul, bluemul, alphamul);
	}
	
	public function SetStoryColourARGB(colour:Number)
	{
		coreGame.SetMovieColourARGB(coreGame.GirlsStory, colour);
	}
	
	
	
	// Weather
	
	public function ShowRain()
	{
		ShowMovie(mcBase.Rain, 1.1, 0, -1);
	}
		
	public function ShowSnow()
	{
		ShowMovie(mcBase.Snow, 1.1, 0, -1);
	}
	
	
	// Hide
	
	public function HideBackgrounds()
	{
		coreGame.HouseEvents.HideBG();
		HideBG();
		mcBase.DressOverlay._visible = false;
	}
	
	public function HideBG()
	{
		mcBase.BGTemple._visible = false;
		mcBase.BGBar._visible = false;
		mcBase.BGKitchen._visible = false;
		mcBase.BGRestaurant._visible = false;
		mcBase.BGShop._visible = false;
		mcBase.PlaceTunnels._visible = false;
		mcBase.PlaceTunnelsChamber._visible = false;
		mcBase.BGPalace._visible = false;
		mcBase.BGSchool._visible = false;
		mcBase.BGForest._visible = false;
		mcBase.BGFarm._visible = false;
		mcBase.BGTownCenter._visible = false;
		mcBase.BGLake._visible = false;
		mcBase.BGDocks._visible = false;
		mcBase.BGSky._visible = false;
		mcBase.BGBath._visible = false;
		mcBase.BGSlums._visible = false;
		mcBase.BGRoom._visible = false;
		mcBase.BGBeach._visible = false;
		mcBase.BGTentacles.gotoAndStop(1);
		mcBase.BGTentacles._visible = false;
		mcBase.BGRuins._visible = false;
		mcBase.BGSlaveMarket._visible = false;
		mcBase.BGDungeon._visible = false;
		mcBase.BGCave._visible = false;
		mcBase.BGSlavePens._visible = false;
		mcBase.BGHouseOutside._visible = false;
		mcBase.BGSalon._visible = false;
		mcBase.BGStables._visible = false;
		mcBase.BGTailors._visible = false;
		mcBase.BGGrass._visible = false;
		mcBase.BGDiningRoom._visible = false;
		mcBase.BGHallway._visible = false;
		mcBase.BGLivingRoom._visible = false;
		mcBase.BGOther._visible = false;
		mcBase.BGAlley._visible = false;
		mcBase.BGGarden._visible = false;
		mcBase.BGFestival._visible = false;
		mcBase.BGCellar._visible = false;
		mcBase.BGArmoury._visible = false;
		mcBase.BGDeepForest._visible = false;
		mcBase.BGOnsen._visible = false;
		mcBase.BGSakura._visible = false;
		mcBase.BGNight._visible = false;
		mcBase.BGLibrary._visible = false;
		mcBase.BGCemetary._visible = false;
		mcBase.BGSlaveMakerRoom._visible = false;
		mcBase.BGCircus._visible = false;
		mcBase.BGPotions._visible = false;
		mcBase.BGArena._visible = false;
		mcBase.BGShip._visible = false;
		mcBase.BGAlcove._visible = false;
		mcBase.BGSports._visible = false;
		mcBase.BGChapel._visible = false;
		mcBase.BGKennels._visible = false;
		mcBase.Snow.stop();
		mcBase.Snow._visible = false;
		mcBase.Rain.stop();
		mcBase.Rain._visible = false;		
	}
	
	public function InitialiseModule()
	{
		super.InitialiseModule();

		mcBase.Snow.stop();
		mcBase.Rain.stop();
		colorTrans = new ColorTransform();
		trans = new Transform(mcBase.DressOverlay);
		trans.colorTransform = colorTrans;
	}

}