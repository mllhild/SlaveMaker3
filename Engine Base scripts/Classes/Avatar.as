// Manager for Slave Maker images
// Translation status: COMPLETE

// Instance of this class in !coregame.as is
// SMAvatar

import Scripts.Classes.*;

class Avatar {
	
	// Variables
	private var SMData:Object;		// parent class instance, the Slave class instance or _root
	private var coreGame:Object;		// core game
	
	// current appearance
	public var avatarImages:AvatarActInfoList;
	
	// Private variables
	private var appArray:Array;
	private var loadedArray:Array;

	private var countMale:Number;
	private var countFemale:Number;
	private var countDickgirl:Number;
	private var countFemaleCat:Number;
	private var countDickgirlCat:Number;
	private var countMaleVamp:Number;
	private var countFemaleVamp:Number;
	private var countDickgirlVamp:Number;
	private var countMaleFurry:Number;
	private var countFemaleFurry:Number;
	private var countDickgirlFurry:Number;
	private var countMaleElf:Number;
	private var countFemaleElf:Number;
	private var countDickgirlElf:Number;
	private var countMaleTC:Number;
	private var countFemaleTC:Number;
	private var countDickgirlTC:Number;
	private var countMaleDarkElf:Number;
	private var countFemaleDarkElf:Number;
	private var countDickgirlDarkElf:Number;
	
	private var cgender:Number;
	private var capp:Number;
	private var cext:String ;
	private var iname:String;
	private var sslvapp:LoadVars;
	
	private var cint1:Number;			// interval
	private var cint2:Number;			// interval
	private var mcBase:MovieClip;		// reference for SMAppearance

	
	// constructor
	public function Avatar(cgm:Object) { 
		coreGame = cgm;
		SMData = null;
		
		mcBase = coreGame.mcBase.SMAppearance;
		appArray = new Array();
		loadedArray = new Array();

		countMale = 0;
		countFemale = 0;
		countDickgirl = 0;
		countFemaleCat = 0;
		countDickgirlCat = 0;
		countMaleVamp = 0;
		countFemaleVamp = 0;
		countDickgirlVamp = 0;
		countMaleFurry = 0;
		countFemaleFurry = 0;
		countDickgirlFurry = 0;
		countMaleElf = 0;
		countFemaleElf = 0;
		countDickgirlElf = 0;
		countMaleTC = 0;
		countFemaleTC = 0;
		countDickgirlTC = 0;
		countMaleDarkElf = 0;
		countFemaleDarkElf = 0;
		countDickgirlDarkElf = 0;
		
		cgender = 1;
		capp = 0;
		cext = ".jpg";
		sslvapp = new LoadVars();
		var ti:Avatar = this;
		sslvapp.onLoad = function(success:Boolean) { ti.NextAppearance(success); }
		NextAppearance();
	}
	
	public function GetXML() : XMLNode { return avatarImages.xSMAvatarXML.firstChild.firstChild; }
	public function GetFolder() : String { return avatarImages.ActFolder; }
	
	public function ResetList(sd:Object)
	{
		super.ResetList(sd);
		mcBase.type = 99;
	}
	
	// Public methods for game use
	
	public function IsLoaded(bPart:Boolean) : Boolean 
	{
		if (bPart == true) return cgender == undefined || cgender > 3;
		return cgender == undefined || cgender > 20;
	}
	
	public function ChangeAppearance(app:Number)
	{
		clearInterval(cint1);
		if (!IsLoaded()) {
			cint1 = setInterval(this, "ChangeAppearance", 20, app);
			return;
		}
		SMData = coreGame.SMData;
		if (app != undefined) SMData.Appearance = app;
		
		avatarImages = GetAvatarImages(SMData.Appearance);
		mcBase.type = undefined;
		
		// load avatar.xml
		if (app == undefined) {
			if (avatarImages.IsLoaded()) return;
		} 
		
		avatarImages.ResetList(SMData);
		avatarImages.LoadAvatarXML();
	}
		
	// type
	// < 0 = use standard xml slave image node. -13 = naked for instance
	//   0 = currently worn clothing
	//	 1 = normal view in small rectangle (Appearance 1.jpg)
	// 	 2 = tentacle sex (small version shown when slave girl raped)
	// 	 3 = raped
	// 	 5 = wet - she falls in some water
	// 	 6 = large graphic shown when your slave runs away	
	//   7 = bunny suit
	//   8 = lingerie
	//   9 = maid
	//   10 = swimsuit
	// place, align, target as per ShowMovie
	public function ShowSlaveMaker(typeo:Object, place:Number, align:Number, frame:Number, defimg:String, target:MovieClip) : MovieClip
	{
		trace("ShowSlaveMaker");
		clearInterval(cint2);
		avatarImages = GetAvatarImages(SMData.Appearance);
		if (!avatarImages.IsLoaded() || !IsLoaded()) {
			cint2 = setInterval(this, "ShowSlaveMaker", 100, typeo, place, align, frame, defimg, target);
			return undefined;
		}
		if (place == undefined) place = 0;
		if (align == undefined) align = 1;
		
		avatarImages.SetSlave(SMData);
		var type:Number = 0;
		if (!isNaN(typeo)) {
			type = Number(typeo);
			if (type == undefined) type = 1;
		} else {
			var act:ActInfo = avatarImages.GetActByName(String(typeo));
			if (act != null) type = act.Act * -1;
		}
		
		if (place == 0) {
			coreGame.HideAssistant();
			coreGame.ShowMovie(coreGame.OnTopOverlayWhite2, 0, 0);
		}
				
		var mv:String;
		if (type < 0) {
			trace("standard image: " + type);
			mv = avatarImages.GetActImageAvatar(type * -1, frame);
			if (mv == "") {
				// No image
				trace("none found...1");
				return undefined;
			}
		} else {
			switch (type) {
				case 0:
				case 6:
					if (SMData.DressWorn < 0) {
						mv = avatarImages.GetActImageAvatar(13, frame);
						if (mv != "") break;
					}
					if (SMData.DressWorn == 0) mv = avatarImages.GetActImageAvatar(20000, frame);
					else if (SMData.DressWorn == 1) mv = avatarImages.GetActImageAvatar(20001, frame);
					else if (SMData.DressWorn == 2) mv = avatarImages.GetActImageAvatar(20002, frame);
					else if (SMData.DressWorn == 3) mv = avatarImages.GetActImageAvatar(20003, frame);
					else if (SMData.DressWorn == 4) mv = avatarImages.GetActImageAvatar(20004, frame);
					break;
				case 1:  mv = avatarImages.GetActImageAvatar(20100, frame); break;
				case 2:  mv = avatarImages.GetActImageAvatar(10000, frame); break;
				case 3:  mv = avatarImages.GetActImageAvatar(10016, frame); break;
				case 7: mv = avatarImages.GetActImageAvatar(10017, frame); break;
				case 8: mv = avatarImages.GetActImageAvatar(10013, frame); break;
				case 9: mv = avatarImages.GetActImageAvatar(10018, frame); break;
				case 10:
				case 5:
					mv = avatarImages.GetActImageAvatar(10014);
					break;
				default:
					mv = avatarImages.GetActImageAvatar(20100, frame);
					if (mv == "") return undefined;		// should not happen
					break;
			}
		}
		trace("avatar image = " + mv);
		if (target == undefined) target = mcBase;
		else mcBase.type = -500;
		target.type = type;
		target.place = place;
		target.align = align;
		target.frame = frame;
		target.defimg = defimg;

		if (frame == undefined) frame = avatarImages.frame;
		target.frame = frame;
		
		// on image load callback
		var ti:Avatar = this;
		function LoadDone(img:MovieClip, tgt:MovieClip)
		{
			//trace("LoadDone: " + img + " " + img.loaderror + " " + tgt.frame);
			if (img.loaderror != true) return;  // ignore successful loads
			if (tgt.frame == -1000) return;	// hidden since display started
			
			var mv:String = "";
			
			// image failed to load
			// check the default image provided
			var def:String = tgt.defimg;
			if (def != "" && def != undefined) {
				// does default contain /Images
				if (def.indexOf("Images/") != -1) mv = def;
				else mv = ti.avatarImages.ActFolder +  "/" + def;
				if (mv == "") return;
			} else {
				mv = ti.avatarImages.ActFolder + "/Appearance 1.jpg";
			}
			if (tgt == ti.mcBase) ti.coreGame.LoadImageAndShowMovie(img, mv, tgt.place, tgt.align, tgt);
			else ti.coreGame.AutoLoadImageAndShowMovie(mv, tgt.place, tgt.align, tgt);
			if (tgt.place == 0) ti.coreGame.PersonShown = -100;

		}
		
		// load the image
		// first check the node <ShowSlaveMaker>
		coreGame.genNumber = type;
		coreGame.genNumber2 = place;
		var image:MovieClip;
		if (!coreGame.XMLData.XMLEventCached("ShowSlaveMaker", false, true, avatarImages.xSMAvatarXML.firstChild.firstChild)) {
			// show the image
			if (target == mcBase) {
				image = avatarImages.actarr[frame];
				var mc:MovieClip = coreGame.LoadImageAndShowMovie(image, mv, place, align, target, 0, LoadDone);
				if (image == undefined) {
					avatarImages.actarr[frame] = mc;
					loadedArray.push(mc);
					image = mc;
				} else image = mc;
			} else image = coreGame.AutoLoadImageAndShowMovie(mv, place, align, target, 0, LoadDone);
		}
		if (place == 0) coreGame.PersonShown = -100;
		return image;
	}
	
	public function AutoShowSlaveMaker(typeo:Object, place:Number, align:Number, frame:Number, defimg:String) : MovieClip
	{
		return ShowSlaveMaker(typeo, place, align, frame, defimg, coreGame.LoadedMovies);
	}
	
	public function Hide()
	{
		mcBase._visible = false;
		var i:Number = loadedArray.length;
		var mc:MovieClip;
		if (i == undefined) i = 0;
		while (i > 0) {
			i--;
			if (loadedArray[i].ext == "swf") {
				avatarImages.ClearImage(loadedArray[i]);
				removeMovieClip(loadedArray[i]);
				delete loadedArray[i];
				loadedArray.splice(i, 1);
			} else {
				mc = MovieClip(loadedArray[i]);
				mc.stop();
				mc._visible = false;
			}
		}
	}
	
	// Private functions
		
	private function GetAvatarImages(app:Number) : AvatarActInfoList
	{
		var cm:Number = countMale;
		var cf:Number = countFemale;
		var cd:Number = countDickgirl;
		var cmo:Number = 0;
		var vfo:Number = 0;
		var cfo:Number = 0;
		var cfcdo:Number = 0;
		var base:Number = 0;
		var nonbase:Boolean = SMData.SMAdvantages.CheckBitFlag(14) || SMData.SMHomeTown == 5 || SMData.SMHomeTown == 6 || SMData.SMHomeTown == 7 || SMData.SMAdvantages.CheckBitFlag(12) || SMData.SMAdvantages.CheckBitFlag(13);
	
		if (nonbase) {
			cmo = cm;
			cfcdo = cf + cd;
			cfo = cf;
		}
		var eff:Number = Math.abs(app);
		if (app >= 0) {
			if (SMData.SMAdvantages.CheckBitFlag(12)) {
				cm = 0;
				cf = countFemaleCat;
				cd = countDickgirlCat;
				base = countMale + countFemale + countDickgirl;
			} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
				cm = countMaleVamp;
				cf = countFemaleVamp;
				cd = countDickgirlVamp;
				base = countMale + countFemale + countDickgirl + countFemaleCat + countDickgirlCat;
			} else if (SMData.SMAdvantages.CheckBitFlag(14)) {
				cm = countMaleFurry;
				cf = countFemaleFurry;
				cd = countDickgirlFurry;
				base = countMale + countFemale + countDickgirl + countFemaleCat + countDickgirlCat + countMaleVamp + countFemaleVamp + countDickgirlVamp;
			} else if (SMData.SMHomeTown == 5) {
				cm = countMaleElf;
				cf = countFemaleElf;
				cd = countDickgirlElf;
				base = countMale + countFemale + countDickgirl + countFemaleCat + countDickgirlCat + countMaleVamp + countFemaleVamp + countDickgirlVamp + countMaleFurry + countFemaleFurry + countDickgirlFurry;
			} else if (SMData.SMHomeTown == 6) {
				cm = countMaleDarkElf;
				cf = countFemaleDarkElf;
				cd = countDickgirlDarkElf;
				base = countMale + countFemale + countDickgirl + countFemaleCat + countDickgirlCat + countMaleVamp + countFemaleVamp + countDickgirlVamp + countMaleFurry + countFemaleFurry + countDickgirlFurry + countMaleElf + countFemaleElf + countDickgirlElf;
			} else if (SMData.SMHomeTown == 7) {
				cm = countMaleTC;
				cf = countFemaleTC;
				cd = countDickgirlTC;
				base = countMale + countFemale + countDickgirl + countFemaleCat + countDickgirlCat + countMaleVamp + countFemaleVamp + countDickgirlVamp + countMaleFurry + countFemaleFurry + countDickgirlFurry + countMaleDarkElf + countFemaleDarkElf + countDickgirlDarkElf + countMaleElf + countFemaleElf + countDickgirlElf;
			} 
		} else {
			if (SMData.SMAdvantages.CheckBitFlag(12)) {
				cmo = 0;
				cfo = countFemaleCat;
				cfcdo = countFemaleCat + countDickgirlCat;
			} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
				cmo = countMaleVamp;
				cfo = countFemaleVamp;
				cfcdo = countFemaleVamp + countDickgirlVamp;
			} else if (SMData.SMAdvantages.CheckBitFlag(14)) {
				cmo = countMaleFurry;
				cfo = countFemaleFurry;
				cfcdo = countFemaleFurry + countDickgirlFurry;
			} else if (SMData.SMHomeTown == 5) {
				cmo = countMaleDarkElf;
				cfo = countFemaleElf;
				cfcdo = countFemaleElf + countDickgirlElf;
			} else if (SMData.SMHomeTown == 6) {
				cmo = countMaleDarkElf;
				cfo = countFemaleDarkElf;
				cfcdo = countFemaleDarkElf + countDickgirlDarkElf;
			} else if (SMData.SMHomeTown == 7) {
				cmo = countMaleTC;
				cfo = countFemaleTC;
				cfcdo = countFemaleTC + countDickgirlTC;
			}
		}
	
		if (eff < 1 || eff == 10000) {
			if (nonbase) {
				var fact:Number = SMData.Appearance == 0 ? -1 : 1;
				if (SMData.Gender != 3) {
					if (SMData.Gender == 1) SMData.Appearance = cmo * fact;
					else SMData.Appearance = cfo * fact;
				} else SMData.Appearance = cfcdo * fact;
				return GetAvatarImages(SMData.Appearance);
			} else {
				if (SMData.Gender != 3) {
					if (SMData.Gender == 1) SMData.Appearance = cm;
					else SMData.Appearance = cf;
				} else SMData.Appearance = cf + cd;
				app = SMData.Appearance;
			}
		} else {
			if (SMData.Gender == 3) {
				if (eff > (cf + cd)) {
					if (!nonbase) SMData.Appearance = 1;
					else {
						SMData.Appearance = -1 * (SMData.Appearance / eff);
						return GetAvatarImages(SMData.Appearance);
					}
					app = SMData.Appearance;
				}
			} else if (SMData.Gender == 1) {
				if (eff > cm) {
					if (!nonbase) SMData.Appearance = 1;
					else {
						SMData.Appearance = -1 * (SMData.Appearance / eff);
						return GetAvatarImages(SMData.Appearance);
					}
					app = SMData.Appearance;
				}
			} else if (eff > cf) {
				if (!nonbase) SMData.Appearance = 1;
				else {
					SMData.Appearance = -1 * (SMData.Appearance / eff);
					return GetAvatarImages(SMData.Appearance);
				}
				app = SMData.Appearance;
			}
		}
		
		var appi:Number = Math.abs(app);
		if (SMData.Gender == 1) appi = base + appi - 1; 
		else appi = base + cm + appi - 1;
		
		return appArray[appi];
	}
		
	private function NextAppearance(success:Boolean)
	{
		if (success != undefined) {
			if (!success) {
				if (cext == ".jpg") {
					cext = ".png";
					capp--;
					NextAppearance();
					return;
				}
				cext = ".jpg";
				cgender++;
				if (cgender > 20) {
					delete sslvapp;
					delete capp;
					delete cext;
					delete iname;
					mcBase.type = 99;
					trace("avatar load complete");
					return;
				}
				capp = 0;

			} else {
				switch (cgender) {
					case 1: countMale++; break;
					case 2: countFemale++; break;
					case 3: countDickgirl++; break;
					case 4: countFemaleCat++; break;
					case 5: countDickgirlCat++; break;
					case 6: countMaleVamp++; break;
					case 7: countFemaleVamp++; break;
					case 8: countDickgirlVamp++; break;
					case 9: countMaleFurry++; break;
					case 10: countFemaleFurry++; break;
					case 11: countDickgirlFurry++; break;
					case 12: countMaleElf++; break;
					case 13: countFemaleElf++; break;
					case 14: countDickgirlElf++; break;
					case 15: countMaleDarkElf++; break;
					case 16: countFemaleDarkElf++; break;
					case 17: countDickgirlDarkElf++; break;
					case 18: countMaleTC++; break;
					case 19: countFemaleTC++; break;
					case 20: countDickgirlTC++; break;
				}
				appArray.push(new AvatarActInfoList(iname, coreGame));
				cext = ".jpg";
			}
		}
		
		capp++;
		switch (cgender) {
			case 1: iname = "Human/Male"; break;
			case 2: iname = "Human/Female"; break;
			case 3: iname = "Human/Dickgirl"; break;
			case 4: iname = "Catgirl/Female"; break;
			case 5: iname = "Catgirl/Dickgirl"; break;
			case 6: iname = "Vampire/Male"; break;
			case 7: iname = "Vampire/Female"; break;
			case 8: iname = "Vampire/Dickgirl"; break;
			case 9: iname = "Furry/Male";break;
			case 10: iname = "Furry/Female"; break;
			case 11: iname = "Furry/Dickgirl"; break;
			case 12: iname = "Elf/Male"; break;
			case 13: iname = "Elf/Female"; break;
			case 14: iname = "Elf/Dickgirl"; break;
			case 15: iname = "Dark Elf/Male"; break;
			case 16: iname = "Dark Elf/Female"; break;
			case 17: iname = "Dark Elf/Dickgirl"; break;
			case 18: iname = "True Catgirl/Male"; break;
			case 19: iname = "True Catgirl/Female"; break;
			case 20: iname = "True Catgirl/Dickgirl"; break;
		}
		iname = "Images/Appearances/" + iname + " " + capp;
		sslvapp.load(iname + "/Appearance 1" + cext);
	}

}