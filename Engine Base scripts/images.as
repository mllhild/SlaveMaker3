// Images
//import flash.display.BitmapData;
import Scripts.Classes.*;

var lastmc:MovieClip;
var currFrame:Number;

// Positioning

function DecodeAlign(str:String) : Number
{
	if (str == undefined) return 1;
	str = str.toLowerCase();
	if (str == "left") return 2;  
	if (str == "right") return 3; 
	if (str == "center") return 1; 
	if (str == "fill") return 0; 
	if (str == "screen") return 11;
	return Number(str);
}
function DecodePlace(str:String) : Number
{
	if (str == undefined) return 1;
	str = str.toLowerCase();
	if (str == "wide" || str == "mainw") return 1.1;
	if (str == "main") return 1; 
	if (str == "people" || str == "person" || str == "small") return 0; 
	if (str == "introduction") return 4; 
	if (str == "full") return 2; 
	return Number(str);
}

// ShowMovie
// align =	0 = fill
//		  	1 - center horizontal
//			2 - left
//			3 - right
//			4 - bottom right
//			5 = top left (large size)
//			6 = center (large size)
//			7 = left, fill width
//			8 = left, fill width, center vertically
//			9 = center (use 1 or 8 depending or aspect ratio)
//			10 - same as 0
//			11 - fill entire stage
//			12 = assistant selection
//			13 = fill width, bottom of area
//			14 = center (use 1 or 13 depending or aspect ratio)
//			15 = bottom left
//			16 = center vertical right
//			17 = center vertical left
//			18 = center (use 1 or 15 depending or aspect ratio)
//        	> 100 - flip horizontal and treat as align - 100;
//        	< 0 - do not show, and treat as align * -1
// placeo =	0 person window
//        	1 main window
//        	2 entire stage
//		  	3 assistant selection
//		  	4 girls introduction
//		  	5 item selection window
//		  	6 slave picker
//		  	7 assistant selection, fixed size
//			8 slave maker profile
//			9 position within parent movie
//			10 same as 0
//			11 special case for ShowSlave(), means use LoadImage functions instead
//			12 Very large stage (like introbackground)
//			13 House Selection window

function ShowMovie(movieo, placeo:Object, align:Number, gframe:Number, delay:Number)
{
	var movie:MovieClip = movieo;
	if (typeof(movieo) == "string") {
		if (movieo.indexOf("/") != -1) {
			var sl:Array = movieo.split("/");
			modulesList.GetEventData(sl[0]).ShowMovie(sl[1], placeo, align, gframe, delay);
			return;
		}
		movie = _root[movieo];
	}
	if (delay != undefined && delay != 0) {
		if (delay > 0) {
			Timers.AddTimer(
				setInterval(_root, "ShowMovie", delay, movie, placeo, align, gframe, -1 * Timers.GetNextTimerIdx())
			);
			return;
		} else if (delay < 0) Timers.RemoveTimer(delay * -1);
	}
	
	var place:Number;
	if (typeof(placeo) == "string") place = Math.abs(DecodePlace(String(placeo)));
	else place = Math.abs(Number(placeo));
	
	var bShow:Boolean = align >= 0;
	align = Math.abs(align);
	if (align == 11) { place = 2; align = 0; }
	else if (align == 12) { place = 3; align = 0; }
	else if (place != 13 && place != 12 && (place > 9 || place < 0)) place = 0;
	
	if (movie == null) {
		if (lastmovie != null) movie = lastmc;
	} else if (bShow) lastmc = movie;
	
	if (gframe != undefined) {
		if (gframe > 0) movie.gotoAndStop(gframe);
		else if (gframe < 0) movie.gotoAndPlay(gframe * -1);
		if (gframe != 0) currFrame = Math.abs(gframe);
	} else currFrame = undefined;
	
	movie._xscale = 100;
	movie._yscale = 100;
	var owidth:Number = movie._width;
	var mratio:Number = owidth / movie._height;

	var xpos:Number = 0;
	var ypos:Number = 0;
	var mwidth:Number;
	var mheight:Number;
	switch (place) {
		case 0: xpos = 7; ypos = 341; mwidth = 153; mheight = 154; break;
		case 1.1: xpos = 7; ypos = 5; mwidth = 598; mheight = 336; break;
		case 1: xpos = 7; ypos = 5; mwidth = 448; mheight = 336; break;				
		case 2: mwidth = config.GetPublishedStageWidth(); mheight = config.GetPublishedStageHeight(); break;
		case 2.1: mwidth = 1067; mheight = 600; break;
		case 2.2: mwidth = 1069; mheight = 600; break;
		case 3: 
			mwidth = 414; mheight = 414 / mratio;
			if (mheight > 600) mheight = 600;
			break;
		case 4: xpos = 12; ypos = 42; mwidth = 770 + config.nScreenXOffset; mheight = 510 + config.nScreenYOffset; break;
		case 5: mheight = 420; mwidth = 420; break;
		case 6: mheight = 123; mwidth = 90; break;
		case 7:	mwidth = 414; mheight = 600; break;
		case 8:	xpos = 21.5; ypos = 58; mwidth = 201; mheight = 200.2; break;
		case 12: mwidth = 2000; mheight = 800; xpos = -390; ypos = -100; break;
		case 13: xpos = 10; ypos = 62; mwidth = 600; mheight = 336; break;
	}
	
	var flip:Boolean = align > 99;
	if (flip) align -= 100;
	var aratio:Number = mwidth / mheight;
	
	if (align == 9) align = mratio > aratio ? 8 : 1;
	else if (align == 14) align = mratio > aratio ? 13 : 1;
	else if (align == 18) align = mratio > aratio ? 15 : 1;
	
	if (place == 9) align = 99;

	switch(align) {
		case 0:
		case 10:
			movie._width = mwidth;
			movie._height = mheight;
			movie._x = xpos;
			movie._y = ypos;
			break;
		case 1:
			movie._width = mheight * mratio;
			movie._height = mheight;
		case 1.1:
			movie._x = xpos + (mwidth / 2) - (movie._width / 2);
			movie._y = ypos;
			break;
		case 2:
		case 17:
		case 5:
			movie._width = mheight * mratio;
			movie._height = mheight;
			movie._x = xpos;
			movie._y = ypos;
			break;
		case 3:
		case 16:
			movie._width = mheight * mratio;
			movie._height = mheight;
		case 3.1:
			movie._x = xpos + mwidth - movie._width;
			movie._y = ypos;
			break;			
		case 4:
			movie._width = mheight * mratio;
			movie._height = mheight;
		case 4.1:
			movie._x = xpos + mwidth - movie._width;
			movie._y = ypos + mheight - movie._height;
			break;
		case 6:
			movie._width = mheight * mratio;
			movie._height = mheight;
			movie._x = xpos + (mwidth / 2) - (movie._width / 2);
			movie._y = ypos;
			break;
		case 7:
			movie._width = mwidth;
			movie._height = mheight / (mratio / aratio);
			movie._x = xpos;
			movie._y = ypos;
			break;
		case 8:
			movie._width = mwidth;
			movie._height = mheight / (mratio / aratio);
			movie._x = xpos;
			movie._y = ypos + ((mheight - movie._height) / 2);
			break;
		case 13:
			movie._width = mwidth;
			movie._height = mheight / (mratio / aratio);
			movie._x = xpos;
			movie._y = ypos + (mheight - movie._height);
			break;
		case 15:
			movie._width = mwidth * (mratio / aratio);
			movie._height = mheight;
			movie._x = xpos;
			movie._y = ypos + mheight - movie._height;
			break;
	}
	if (flip) {
		movie._xscale = -100 * (movie._width / owidth);
		movie._x += movie._width;
	}
	if (bShow) {
		if (place == 0) {
			if (SMAppearance.pplace != -1000 && SMAppearance.pplace == place) HideAllPeople();
			/*
			// partial inlined HideAssistant();
			CurrentAssistant.HideAsAssistant();
			*/
			SMAppearance._visible = false;
			OnTopOverlayWhite._x = 7;
			OnTopOverlayWhite._y = 341;
			OnTopOverlayWhite._width = 153;
			OnTopOverlayWhite._height = 154;
			OnTopOverlayWhite2._x = 7;
			OnTopOverlayWhite2._y = 341;
			OnTopOverlayWhite2._width = 153;
			OnTopOverlayWhite2._height = 154;
			if (movie._parent != LoadedAssistant && movie._parent != SlaveMovie && movie._parent._parent != SlaveMovie && movie._parent != Generic.mcBase && movie._parent != Catgirls.mcBase && movie._parent != LoadedMovies && movie._parent != SMAppearance) OnTopOverlayWhite2._visible = true;
			else OnTopOverlayWhite2._visible = false;
			OnTopOverlay._visible = false;			
		} else {
			OnTopOverlay._visible = false;
			if (place == 6) {
				ParticipantsChanger.Parties.invalidate();
				ParticipantsChanger.Slaves.invalidate();
			}
		}
		movie._visible = true;
		movie._parent._visible = true;			// not strictly needed by is safe
		if (movie._parent._parent != mcMain) movie._parent._parent._visible = true;			// not strictly needed by is safe
	}
	delete movie.transform.colorTransform;
	movie.transform.colorTransform = new ColorTransform();
}

function ShowOtherMovie(module:String, movie, placeo:Object, align:Number, gframe:Number, delay:Number) { modulesList.GetEventData(module).ShowMovie(movie, placeo, align, gframe, delay); }


function ShowLastMovie(place:Number, align:Number, gframe:Number)
{
	ShowMovie(lastmc, place, align, gframe);
}

function HideMovie(mc:MovieClip) { mc._visible = false; }

function ResizeMovie(movie:MovieClip, perc:Number, align:Number)
{
	if (movie == null) movie = lastmc;
	else lastmc = movie;
	
	if (align == undefined) align = 2;
	
	var mvx:Number = movie._x;
	var mvy:Number = movie._y;
	var mvw:Number = movie._width;
	var mvh:Number = movie._height;
	movie._width = mvw * perc / 100;
	movie._height = movie._height * perc / 100;
	movie._y = mvy;

	if (align == 2) movie._x = mvx;
	else if (align == 3) movie._x = mvx + mvw - movie._width;
	else if (align == 4) {
		movie._x = mvx + mvw - movie._width;
		movie._y = mxy + mvh - movie._height;
	} else if (align == 15) {
		movie._x = mvx + mvw - movie._width;
		movie._y = mvy + mvh - movie._height;
	} else if (align == 16) {
		movie._x = mvx + mvw - movie._width;
		movie._y = mvy + ((mvh - movie._height) / 2);
	}  else if (align == 17) movie._y = mvy + ((mvh - movie._height) / 2);
	else movie._x = mvx + (mvw - (mvw * perc / 100)) / 2;
}

function ResizeLastMovie(perc:Number, align:Number)
{
	ResizeMovie(lastmc, perc, align);
}

// Attach Movies

function AttachMovie(movie:String, target:MovieClip) : MovieClip
{		
	if (target == undefined) target = LoadedMovies;
	var image:MovieClip = target.attachMovie(movie, "LoadedMovie" + loadednum, target.getNextHighestDepth());
	image.stop();
	image._visible = false;
	image.enabled = false;
	target._visible = true;
	target.loading = false;
	loadednum++;
	return image;
}

function AttachAndShowMovie(image:MovieClip, movie:String, place:Number, align:Number, gframe:Number, target:MovieClip, delay:Number) : MovieClip
{
	if (movie == "") return image;
	if (image == undefined) image = AttachMovie(movie, target);
	ShowMovie(image, place, align, gframe, delay);
	if (place == 0) OnTopOverlayWhite2._visible = false;
	return image;
}

function AttachAndPositionMovie(image:MovieClip, movie:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip) : MovieClip
{
	if (image == undefined) image = AttachMovie(movie, target);
	image._visible = true;
	PositionMovieSimple(image, xpos, ypos, rot, wid, hei);
	return image;
}

function RemoveAttachedMovie(movie:MovieClip) { movie.removeMovieClip(); }

function AutoAttachAndShowMovie(movie:String, place:Number, align:Number, gframe:Number, target:MovieClip, delay:Number) : MovieClip
{
	if (movie == "") return null;
	var image:MovieClip = AttachMovie(movie, target);
	if (image == null || image == undefined) return undefined;
	arAutoLoadedMovieArray.push(image);
	ShowMovie(image, place, align, gframe, delay);
	if (place == 0) OnTopOverlayWhite2._visible = false;
	return image;
}

function AutoAttachAndPositionMovie(movie:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip) : MovieClip
{
	var image:MovieClip = AttachMovie(movie, target);
	if (image == null || image == undefined) return undefined;
	image.LText.wordWrap = true;
	image.LText.autoSize = true;
	image._visible = true;
	arAutoLoadedMovieArray.push(image);
	PositionMovieSimple(image, xpos, ypos, rot, wid, hei);
	return image;
}

// Attach Bitmaps

function AttachBitmap(bmpid:String, target:MovieClip) : MovieClip
{		
	if (target == undefined) target = LoadedMovies;
	var image:MovieClip = target.createEmptyMovieClip("LoadedMovie" + loadednum, target.getNextHighestDepth());
	var bmp:BitmapData = BitmapData.loadBitmap(bmpid);
	image.attachBitmap(bmp, image.getNextHighestDepth(), "auto", true);
	image.stop();
	image._visible = false;
	image.enabled = false;
	target._visible = true;
	loadednum++;
	return image;
}

function AttachAndShowBitmap(image:MovieClip, bmp:String, place:Number, align:Number, target:MovieClip, delay:Number) : MovieClip
{
	if (movie == "") return image;
	if (image == undefined) image = AttachBitmap(bmp, target);
	ShowMovie(image, place, align, 1, delay);
	if (place == 0) OnTopOverlayWhite2._visible = false;
	return image;
}

function AttachAndPositionBitmap(image:MovieClip, bmp:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip) : MovieClip
{
	if (image == undefined) image = AttachBitmap(bmp, target);
	PositionMovieSimple(image, xpos, ypos, rot, wid, hei);
	return image;
}

function AutoAttachAndShowBitmap(bmp:String, place:Number, align:Number, target:MovieClip, delay:Number) : MovieClip
{
	if (movie == "") return null;
	var image:MovieClip = AttachBitmap(bmp, target);
	if (image == null || image == undefined) return undefined;
	arAutoLoadedMovieArray.push(image);
	ShowMovie(image, place, align, 1, delay);
	if (place == 0) OnTopOverlayWhite2._visible = false;
	return image;
}

function AutoAttachAndPositionBitmap(movie:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip) : MovieClip
{
	var image:MovieClip = AttachBitmap(movie, target);
	if (image == null || image == undefined) return undefined;
	image.LText.wordWrap = true;
	image.LText.autoSize = true;
	image._visible = true;
	arAutoLoadedMovieArray.push(image);
	PositionMovieSimple(image, xpos, ypos, rot, wid, hei);
	return image;
}

// Load Inages

loadListenerImage.onLoadInit = function(image:MovieClip) {
	image._visible = false;
	image.loading = false;
}
loadListenerImage.onLoadComplete = function(image:MovieClip, httpStatus:Number) {
	image._visible = false;
}
loadListenerImage.onLoadError = function(image:MovieClip, errorMsg:String, httpStatus:Number) {
	image.loaderror = true;
}

function LoadingImage(target:MovieClip, mv:String, image:MovieClip, place:Number, align:Number, idx:Number, delay:Number, imgCallback:Function, strExts:String)
{
	if (image.loading == false || image.loaderror == true) {
		var bShow:Boolean = !Timers.IsTimerStopped(idx);
		trace("LoadingImage: " + mv + " " + image + " " + idx + " " + bShow + " " + image.loaderror + " " + image.hide + " " + place + " " + align + " " + delay);
		if (image.hide == true) {
			bShow = false;
			image.hide = false; 
		}
		if (target != SMAppearance || !bShow) image._visible = false;
		Timers.RemoveTimer(idx);
		image.mv = mv;
		if (image.loaderror == true && mv != "") {
			// try other extensions
			var mva:Array = mv.split("|");
			var mv1:String = mva[0];
			var bSpec:Boolean = mv1.indexOf("/Assistant.") != -1 || mv1.indexOf("Dress ") != -1 || mv1.indexOf("Sex Act - Naked ") != -1;
			var sa:Array = mv1.split(".");
			var ext:String = String(sa.pop());
			strExts += ext;
			trace("  load error for " + mv1 + " (" + ext + ") tried: " + strExts);
			mv1 = sa.join(".");
			if (ext == "jpg") {
				if (bSpec && strExts.indexOf("png") != -1) {
					if (mva.length == 1) {
						if (imgCallback != undefined) imgCallback(image, target, mv);
						return;
					}
					mva.shift();
					sa = mva[0].split(".");
					ext = String(sa.pop());
					mv1 = sa.join(".");
					strExts = "";
				} else ext = "png";
			} else if (ext == "png") {
				if (bSpec) {
					if (strExts.indexOf("jpg") == -1) ext = "jpg";
					else {
						if (mva.length == 1) {
							if (imgCallback != undefined) imgCallback(image, target, mv);
							return;
						}
						mva.shift();
						sa = mva[0].split(".");
						ext = String(sa.pop());
						mv1 = sa.join(".");
						strExts = "";
					}
				} else ext = "gif";
			} else if (ext == "gif") ext = "swf";
			else if (ext == "swf") ext = "jpeg";
			else {
				if (mv1.indexOf("Item - ") != -1) {
					mv1 = Language.strReplace(mv1, "Item - ", "Uniform - ");
					ext = "jpg";
					strExts = "";
				} else if (mv1.indexOf("Catgirl") != -1) {
					mv1 = Language.strReplace(mv1, "Catgirl", "Catboy");
					ext = "jpg";
					strExts = "";
				} else if (mv1.indexOf("Dickgirl") != -1) {
					mv1 = Language.strReplace(mv1, "Dickgirl", "Futanari");
					ext = "jpg";
					strExts = "";
				} else if (mv1.indexOf("(Lesbian ") != -1) {
					mv1 = Language.strReplace(mv1, "(Lesbian", "(Gay");
					ext = "jpg";
					strExts = "";
				} else {
					if (mva.length == 1) {
						if (imgCallback != undefined) imgCallback(image, target, mv);
						return;
					}
					mva.shift();
					sa = mva[0].split(".");
					ext = String(sa.pop());
					mv1 = sa.join(".");
					strExts = "";
				}
			} 
			trace("  try loading " + mv + "." + ext);
			
			mva[0] = mv1 + "." + ext;
			var mvn:String = mva.join("|");

			if (place < 0) AutoLoadImageAndShowMovie(mvn, -1 * place, align, target, 0, imgCallback, strExts);
			else LoadImageAndShowMovie(image, mvn, place, align, target, 0, imgCallback, strExts);
			return;
		}
		var sa:Array = mv.split(".");
		var ext:String = String(sa.pop());
		image.ext = ext;
		image.forceSmoothing = true;
		if (bShow) {
			if (delay != 0 && delay != undefined) 
				Timers.AddTimerStopSoon(
					setInterval(_root, "DelayedShowImage", delay, target, image, place, align, imgCallback, Timers.GetNextTimerIdx())
				)
			else DelayedShowImage(target, image, place, align, imgCallback);
		} else if (imgCallback != undefined) imgCallback(image, target, mv);
	}
}

function DelayedShowImage(target:MovieClip, image:MovieClip, place:Number, align:Number, imgCallback:Function, idx:Number)
{
	Timers.RemoveTimer(idx);
	if (target == SMAppearance) {
		if (SMAppearance.frame != -1000) {
			SMAvatar.Hide();
			ShowMovie(image, place, align, -1);
			SMAppearance._visible = true;
			image._visible = true;
		}

	} else {
		ShowMovie(image, place, align, -1);
		if (target._parent == SlaveMovie || target._parent == LoadedAssistant || target == LoadedMovies) {
			if (place == 0) OnTopOverlayWhite2._visible = false;
		}
	}
	if (imgCallback != undefined) imgCallback(image, target);
}

function LoadImageAndShowMovie(image:MovieClip, movie:String, place:Number, align:Number, target:MovieClip, delay:Number, imgCallback:Function, strExts:String) : MovieClip
{
	if (target == undefined) target = SlaveMovie;
	trace("LoadImageAndShowMovie: " + movie + " " + place + " " + align + " " + target + " " + image);
	if (image != undefined && image.loaderror != true) {
		if (image.loading != false) return image;
		if (target == SMAppearance) {
			SMAvatar.Hide();
			SMAppearance._visible = true;
		}
		//trace("..already loaded");
		ShowMovie(image, place, align, 1);
		if (imgCallback != undefined) imgCallback(image, target);
		return image;
	}
	image.loading = true;
	if (image.loaderror != true) image = target.createEmptyMovieClip("LoadedMovie" + loadednum, target.getNextHighestDepth());
	if (align >= 0) lastmc = image;
	image._visible = false;
	if (target != SMAppearance || place == 8) target._visible = true;
	loadednum++;
	image.loading = true;
	image.loaderror = false;
	if (place == 0) mcLoaderImage2.loadClip(movie.split("|")[0], image);
	else mcLoaderImage.loadClip(movie.split("|")[0], image);
	if (place != undefined) {
		Timers.AddTimerStopSoon(
			setInterval(_root, "LoadingImage", 10, target, movie, image, place, align, Timers.GetNextTimerIdx(), delay, imgCallback, strExts == undefined ? "" : strExts)
		);
	}
	return image;
}

function LoadImage(image:MovieClip, movie:String, target:MovieClip, delay:Number, imgCallback:Function) : MovieClip
{
	return LoadImageAndShowMovie(image, movie, undefined, undefined, target, delay, imgCallback);
}

function AutoLoadImageAndShowMovie(movie:String, place:Number, align:Number, target:MovieClip, delay:Number, imgCallback:Function, strExts:String) : MovieClip
{
	var image:MovieClip = undefined;
	if (place == 0) place = 10;
	image = LoadImageAndShowMovie(image, movie, -1 * place, align, target, delay, imgCallback, strExts);
	arAutoLoadedMovieArray.push(image);
	return image;
}

function LoadPermanentlyImageAndShowMovie(image:MovieClip, movie:String, place:Number, align:Number, delay:Number, imgCallback:Function, target:MovieClip) : MovieClip
{
	image = LoadImageAndShowMovie(image, movie, place, align, target, delay, imgCallback);
	arLoadedMovieArray.push(image);
	return image;
}
function LoadGameImageAndShowMovie(image:MovieClip, movie:String, place:Number, align:Number, delay:Number, imgCallback:Function, target:MovieClip) : MovieClip
{
	image = LoadImageAndShowMovie(image, movie, place, align, target, delay, imgCallback);
	arPermanentMovieArray.push(image);
	return image;
}

function RemoveLoadedImage(movie:MovieClip) { 
	movie.unloadMovie();
	movie.removeMovieClip();
	movie = undefined;
}

function LoadingImagePos(target:MovieClip, mv:String, image:MovieClip, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, idx:Number, delay:Number, imgCallback:Function)
{
	if (image.loading == false || image.loaderror == true) {
		trace("LoadingImagePos: " + mv);
		image._visible = false;
		var bShow:Boolean = !Timers.IsTimerStopped(idx);
		if (image.hide == true) {
			bShow = false;
			image.hide = false;
		}
		Timers.RemoveTimer(idx);
		if (image.loaderror == true && mv != "") {
			// try other extensions
			var mva:Array = mv.split("|");
			var mv1:String = mva[0];
			var sa:Array = mv1.split(".");
			var ext:String = String(sa.pop());
			trace("  load error for " + mv1 + " (" + ext + ")");
			mv1 = sa.join(".");
				
			if (ext == "jpg") ext = "png";
			else if (ext == "png") ext = "gif";
			else if (ext == "gif") ext = "swf";
			else if (ext == "swf") ext = "jpeg";
			else {
				if (mv1.indexOf("Catgirl") != -1) {
					mv1 = Language.strReplace(mv1, "Catgirl", "Catboy");
					ext = "jpg";
					strExts = "";
				} else if (mv1.indexOf("Dickgirl") != -1) {
					mv1 = Language.strReplace(mv1, "Dickgirl", "Futanari");
					ext = "jpg";
					strExts = "";
				} else if (mv1.indexOf("(Gay ") != -1) {
					mv1 = Language.strReplace(mv1, "(Gay", "(Lesbian");
					ext = "jpg";
					strExts = "";
				} else {
					if (mva.length == 1) {
						if (imgCallback != undefined) imgCallback(image, target, mv);
						return;
					}
					mva.shift();
					sa = mva[0].split(".");
					ext = String(sa.pop());
					mv1 = sa.join(".");
					strExts = "";
				}
			} 
						
			mva[0] = mv1 + "." + ext;
			var mvn:String = mva.join("|");
			trace("  try loading " + mvn + "." + ext);

			if (delay < 0) AutoLoadImageAndPositionMovie(mvn, xpos, ypos, rot, wid, hei, target, -1 * delay, imgCallback);
			else LoadImageAndPositionMovie(image, mvn, xpos, ypos, rot, wid, hei, target, delay, imgCallback);
			return;
		}
		var sa:Array = mv.split(".");
		var ext:String = String(sa.pop());
		image.ext = ext;
		image.mv = mv;

		image.forceSmoothing = true;
		if (bShow) {
			if (delay != 0 && delay != undefined) 
				Timers.AddTimerStopSoon(
					setInterval(_root, "DelayedPositionImage", delay, target, image, xpos, ypos, rot, wid, hei, imgCallback, Timers.GetNextTimerIdx())
				)
			else DelayedPositionImage(target, image, xpos, ypos, rot, wid, hei, imgCallback);
		} else if (imgCallback != undefined) imgCallback(image, target, mv);
	}
}

function DelayedPositionImage(target:MovieClip, image:MovieClip, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, imgCallback:Function, idx:Number)
{
	Timers.RemoveTimer(idx);
	image._visible = true;
	if (image._parent == SlaveSelection.mcSlaveSelectionBG) PositionMovieSimple(image, xpos, ypos, rot, wid, hei);
	else if (image._parent._parent._parent._parent == SlavePurchase) {
		image._parent._parent.SlaveButton._width = image._width;
		image._parent._parent.SlaveButton._height = image._height;
		PositionMovieSimple(image._parent._parent, xpos, ypos, rot, wid, hei);
	} else PositionMovie(image, xpos, ypos, rot, wid, hei);
	if (imgCallback != undefined) imgCallback(image, target);
}


function LoadImageAndPositionMovie(image:MovieClip, movie:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip, delay:Number, imgCallback:Function) : MovieClip
{
	trace("LoadImageAndPositionMovie: " + movie);
	if (target == undefined) target = SlaveMovie;
	if (image != undefined && image.loaderror != true) {
		if (image.loading != false) return image;
		image._visible = true;
		PositionMovie(image, xpos, ypos, rot, wid, hei);
		if (imgCallback != undefined) imgCallback(image, target);
		return image;
	}
	if (image.loaderror != true) image = target.createEmptyMovieClip("LoadedMovie" + loadednum, target.getNextHighestDepth());
	lastmc = image;
	image._visible = false;
	target._visible = true;
	loadednum++;
	image.loading = true;
	image.loaderror = false;
	mcLoaderImage.loadClip(movie.split("|")[0], image);
	if (xpos != undefined) {
		Timers.AddTimerStopSoon(
			setInterval(_root, "LoadingImagePos", 10, target, movie, image, xpos, ypos, rot, wid, hei, Timers.GetNextTimerIdx(), delay, imgCallback)
		);
	}
	return image;
}

function AutoLoadImageAndPositionMovie(movie:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip, delay:Number, imgCallback:Function) : MovieClip
{
	var image:MovieClip = undefined;
	if (delay == undefined) delay = 1;
	image = LoadImageAndPositionMovie(image, movie, xpos, ypos, rot, wid, hei, target, -1 * delay, imgCallback);
	arAutoLoadedMovieArray.push(image);
	return image;
}

function LoadPermanentlyImageAndPositionMovie(image:MovieClip, movie:String, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, delay:Number, imgCallback:Function) : MovieClip
{
	image._visible = true;
	image = LoadImageAndPositionMovie(image, movie, xpos, ypos, rot, wid, hei, undefined, delay, imgCallback);
	arLoadedMovieArray.push(image);
	return image;
}


// Position Movie

function PositionMovie(mc:MovieClip, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	lastmc = mc;

	if (rot == undefined) rot = 0;
	if (SlaveDebugging) {
		mc.posx = xpos;
		mc.posy = ypos;
		mc.posrot = rot;
		mc.poswid = wid;
		mc.poshei = hei;
		mc.tint = 0;
	}
	
	if (mc._visible) {
		mc._rotation = 0;
		
		var ratio:Number = mc._width / mc._height;		
		if (hei == 0 && wid != undefined) {
			mc._xscale = 100;
			mc._yscale = 100;
			if (wid != 0) hei = wid / ratio;
		}
		if (hei != 0 && hei != undefined) {
			mc._yscale = 100;
			mc._yscale = 100 * hei / Math.abs(mc._height);
		}		
		if (wid != undefined) {
			if (wid == 0 && hei != 0) {
				wid = hei * ratio;
			}
			mc._xscale = 100;
			if (wid != 0) mc._xscale = 100 * wid / Math.abs(mc._width);
		}
		if (rot != 0) mc._rotation = rot;

		if (xpos != undefined) {
			if (mc._xscale < 0 || (rot > 89 && rot < 180) || (rot > -180 && rot < 0)) mc._x = xpos + (mc._width / 2);
			else mc._x = xpos - (mc._width / 2);
		}
		if (ypos != undefined) {
			if (mc._yscale < 0 || (rot > 180) || (rot < -180)) mc._y = ypos + (mc._height / 2);
			else mc._y = ypos - (mc._height / 2);
		}
	}
}

function PositionLastMovie(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	PositionMovie(lastmc, xpos, ypos, rot, wid, hei);
}

function PositionMovieSimple(mc:MovieClip, xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	lastmc = mc;

	if (rot == undefined) rot = 0;
	
	if (mc._visible) {
		mc._rotation = 0;
		var ratio:Number = mc._width / mc._height;
		
		if (hei == 0 && wid != undefined) {
			mc._xscale = 100;
			mc._yscale = 100;
			var ratio:Number = mc._width / mc._height;
			if (wid != 0) hei = wid / ratio;
		}
		if (hei != 0 && hei != undefined) {
			mc._yscale = 100;
			mc._yscale = 100 * hei / Math.abs(mc._height);
		}
		if (wid != undefined) {
			if (wid == 0 && hei != 0)  {
				wid = hei * ratio;
			}
			mc._xscale = 100;
			if (wid != 0) mc._xscale = 100 * wid / Math.abs(mc._width);
		}
		
		if (xpos != undefined) mc._x = xpos;
		if (ypos != undefined) mc._y = ypos;
		if (rot != 0) mc._rotation = rot;
	}
	
	if (SlaveDebugging) {
		mc.posx = xpos;
		mc.posy = ypos;
		mc.posrot = rot;
		mc.poswid = wid;
		mc.poshei = hei;
		mc.tint = 0;
	}
}

function PositionLastMovieSimple(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number)
{
	PositionMovieSimple(lastmc, xpos, ypos, rot, wid, hei);
}

// Colouring

function SetMovieColour(mc:MovieClip, red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number, fb:Boolean)
{
	// Reset ant colouring
	var transformer = new Transform(mc);
	var colorTransformer:ColorTransform = transformer.colorTransform;
	colorTransformer.redMultiplier = 1;
	colorTransformer.greenMultiplier = 1;
	colorTransformer.blueMultiplier = 1;
	colorTransformer.alphaMultiplier = 1;
	colorTransformer.redOffset = 0;
	colorTransformer.greenOffset = 0;
	colorTransformer.blueOffset = 0;
	colorTransformer.alphaOffset = 0;	
	transformer.colorTransform = colorTransformer;

	if (alphao == undefined) alphao = 0;
	mc.tint = (red << 16) + (green << 8) + blue;
	
	if (fb == true) {
		var clr:Number = GetMovieColourAtPixel(mc, 5, 5);
		var redb:Number = (clr >> 16) & 255;
		var greenb:Number = (clr >> 8) & 255;
		var blueb:Number = clr & 255;
		red -= redb;
		green -= greenb;
		blue -= blueb;
	}
	
	colorTransformer.redMultiplier = redmul == undefined ? 1 : redmul;
	colorTransformer.greenMultiplier = greenmul == undefined ? 1 : greenmul;
	colorTransformer.blueMultiplier = bluemul == undefined ? 1 : bluemul;
	colorTransformer.alphaMultiplier = alphamul == undefined ? 1 : alphamul;
	colorTransformer.redOffset = red;
	colorTransformer.greenOffset = green;
	colorTransformer.blueOffset = blue;
	colorTransformer.alphaOffset = alphao;
	transformer.colorTransform = colorTransformer;
}

function SetMovieColourARGB(mc:MovieClip, clr:Number, fb:Boolean)
{
	var ao:Number = mc._alpha;
	SetMovieColour(mc, 0, 0, 0, 0, 1, 1, 1, ao / 100);
	if (clr == undefined) clr = 0;
	
	var sgn:Number = clr < 0 ? -1 : 1;
	clr = Math.abs(clr);
	var red:Number = sgn * ((clr >> 16) & 255);
	var green:Number = sgn *((clr >> 8) & 255);
	var blue:Number = sgn * (clr & 255);
	var alphao:Number = (clr >> 24) & 255;
	if (alphao != 0) ao = alphao / 255;
	
	var perc:Number = clr - int(clr);
	if (perc < 0.01) perc = 1;			 
		
	SetMovieColour(mc, red, green, blue, 0, perc, perc, perc, ao / 100, fb);
}

function GetMovieColourAtPixel(mc:MovieClip, xpos:Number, ypos:Number) : Number
{
	var bmps:BitmapData = new BitmapData(mc._width, mc._height, true, 0);
	bmps.draw(mc);
	var clr:Number = bmps.getPixel(xpos, ypos);
	bmps.dispose();
	return clr;
}

function SetMovieNight(mc:MovieClip, always:Boolean)
{ 
	if (always == undefined) always = !Day;
	if (always) SetMovieColour(mc, -200, -70, 0);// -1 * 0xc84600
}

function SetLastMovieColourARGB(clr:Number) { SetMovieColourARGB(lastmc, clr); }
function SetLastMovieColour(red:Number, green:Number, blue:Number, alphao:Number, redmul:Number, greenmul:Number, bluemul:Number, alphamul:Number, fb:Boolean) { SetMovieColour(lastmc, red, green, blue, alphao, redmul, greenmul, bluemul, alphamul, fb); }
function SetLastMovieNight(always:Boolean) { SetMovieNight(lastmc, always); }


// Menus

function HideMenus()
{
	MorningEveningMenu._visible = false;
	SlaveDiscussion._visible = false;
	TakeAWalkMenu._visible = false;
	ItemSalesmanMenu._visible = false;
	ShopMenu._visible = false;
	ArmouryMenu._visible = false;
	SalonMenu._visible = false;
	TailorMenu._visible = false;
	StablesMenu._visible = false;
	PlanningSelections._visible = false;
	VisitMenu._visible = false;
	mcEndGameMenu._visible = false;
	DealerMenu._visible = false;
	SlavePurchase._visible = false;
	PotionsMenu._visible = false;
	ParticipantsChanger._visible = false;
	PlanningPage._visible = false;
	HouseMenu._visible = false;
	mcGenericShop._visible = false;
}

// these work for all movieclips, not just menus, but they musy not have rollover handlers
function DisableMenu(mc:MovieClip)
{
	mc.onRollOver = function() { };
	mc.useHandCursor = false;
}

function EnableMenu(mc:MovieClip)
{
	delete mc.onRollOver;
	mc.useHandCursor = true;
}

// General Images

function HideAllImages()
{
	testlayout._visible = false;
	Timers.StopWait();
	LoadedSlaves.ClearLoadedSlaves();
	GirlsStory._visible = false;
	GirlsStoryTop._visible = false;
	OnTopOverlayWhite._visible = false;
	OnTopOverlayWhite2._visible = false;
	GameOverText._visible = false;
	IntroTitle._visible = false;
	SlaveMakerCreate1._visible = false;
	SlaveMakerCreate2._visible = false;
	SlaveMakerCreate3._visible = false;
	SlaveSelection._visible = false;
	SlaveMakerHousing._visible = false;
	PlanningSelections._visible = false;
	StatisticsGroup.review = false;
	EnableButtons();
	HideDresses();
	HideEndings();
	Contests.HideImages();
	Backgrounds.HideIntroBackground();
	Backgrounds.HideIntroBackgroundTop();	
	Backgrounds.HideBackgrounds();
	HideSlaveActions();
	dspMain.HideMainButtons();
	dspMain.HideStatChangeIcons();
	Items.HideItems();
	HideMenus();
	mcDiaryMenu._visible = false;	
	mcEndGameMenu._visible = false;
	DealerMenu._visible = false;
	VisitMenu._visible = false;
	SlavePurchase._visible = false;
	RulesMenu._visible = false;
	SelectEquipment.Hide();
	SelectSMEquipment.Hide();
	LoadSaveGames._x = 1200;
	LoadSaveGames._visible = false;
	mcEndGame._visible = false;
	SlaveMakerSkillsMenu._visible = false;
	HideGeneralText();

	dspMain.Hide();
	HouseEvents.HideCurrentFloor();
	HouseEvents.Exploring.Destroy();
				
	IntroNextButton._visible = false;
	IntroBackButton._visible = false;
	IntroSkip._visible = false;
	OptionsMenu._x = 2250;
	OptionsMenu._visible = false;
	CombatStatistics._visible = false;
	CombatMonsterAttacks._visible = false;
	CombatHits._visible = false;
	
	MorningButton._visible = false;
	EveningButton._visible = false;
	HideEquipmentButton();
	HideSMEquipmentButton();
	ParticipantsBtn._visible = false;
	HideYesNoButtons();
	
	DoThePlanning._visible = false;
	NextEvent._visible = false;
	NextEnding._visible = false;
	NextGeneral._visible = false;
	DiscussOrdinary._visible = false;
	DiscussCongratulate._visible = false;
	DiscussScold._visible = false;
	Cheat._visible = false;
	GoldHint._visible = false;
	AssistantSelection._visible = false;
	Hints.HideHints()
	
	ClipTrainingComplete._visible = false;
	VisitFortuneTeller._visible = false;
	
	Information.HideInformation();
}

function HideImages(noauto:Boolean) {
	//Quitter._x = 750;
	NextEvent._x = 750;
	
	WalkZoom._visible = false;
	WalkZoom._x = 7;
	WalkZoom._y = 5;
	WalkZoom._width = 448;
	WalkZoom._height = 336;
	
	ClipSexDream._visible = false;
	SlaveStatus._visible = false;

	SlaveGirl.HideImages();
	CurrentAssistant.HideImages();
	Generic.HideImages();
	HouseEvents.HideImages();
	Parties.HideImages();
	currentCity.HideImages();
	
	modulesList.HideImages();

	CombatSMAttack._visible = false;
	Bars._visible = false;
	Bars._x = 7;
	InternalCum.gotoAndStop(1);
	InternalCum._visible = false;

	clearInterval(intervalId);
	clearInterval(intervalId2);
	clearInterval(intervalId3);
	clearInterval(intervalId4);
	if (oldxscale != 0) {
		fuckit_mc._xscale = oldxscale;
		fuckit_mc._yscale = oldxscale;
		oldxscale = 0;
	}
	if (Hints.IsHints()) Hints.HideHints();

	OnTopOverlay._visible = false;
	OnTopOverlay._alpha = 100;
	OnTopOverlayWhite._alpha = 100;
	OnTopOverlayWhite2._alpha = 100;
	OnTopOverlayWhite._visible = false;
	OnTopOverlayWhite2._visible = false;
	Cum._visible = false;
	HideQuestions();

		
	var mc:MovieClip;
	i = noauto == true ? 0 : arAutoLoadedMovieArray.length;
	if (i == undefined) i = 0;
	while (i > 0) {
		i--;
		removeMovieClip(arAutoLoadedMovieArray[i]);
		delete arAutoLoadedMovieArray[i];
		arAutoLoadedMovieArray.pop();
		if (i <= 0) {
			delete arAutoLoadedMovieArray;
			arAutoLoadedMovieArray = new Array();
		}
	}
	i = arLoadedMovieArray.length;
	if (i == undefined) i = 0;
	while (i > 0) {
		i--;
		if (arLoadedMovieArray[i] == null) continue;
		if (arLoadedMovieArray[i].ext == "swf") {
			slaveData.ActInfoBase.ClearImage(arLoadedMovieArray[i]);
			removeMovieClip(arLoadedMovieArray[i]);
			delete arLoadedMovieArray[i];
			arLoadedMovieArray.splice(i, 1);
		} else {
			mc = MovieClip(arLoadedMovieArray[i]);
			mc.stop();
			mc._visible = false;
		}
	}
	i = arPermanentMovieArray.length;
	if (i == undefined) i = 0;
	while (i > 0) {
		i--;
		if (arPermanentMovieArray[i] == null) continue;
		mc = MovieClip(arPermanentMovieArray[i]);
		mc.stop();
		mc._visible = false;
	}
	
	Timers.StopAlTimers();
}

function HideAutoLoadedImages()
{
	var mc:MovieClip;
	i = arAutoLoadedMovieArray.length;
	if (i == undefined) i = 0;
	while (--i > 0) {
		mc = arAutoLoadedMovieArray[i];
		mc._visible = false;
	}
}

function ClearAutoLoadedMovies()
{
	var mc:MovieClip;
	var i:Number = arAutoLoadedMovieArray.length;
	if (i == undefined) i = 0;
	while (i > 0) {
		i--;
		removeMovieClip(arAutoLoadedMovieArray[i]);
		delete arAutoLoadedMovieArray[i];
		arAutoLoadedMovieArray.pop();
		if (i <= 0) {
			delete arAutoLoadedMovieArray;
			arAutoLoadedMovieArray = new Array();
		}
	}
}


function HideActImages()
{
	HideAllPeople();
	HideSlaveActions();
	HideImages();
	ShowSupervisor();
}


// Others


function HideSlaveActions() {
	
	Generic.HideSlaveActions();
	SlaveGirl.HideSlaveActions();
	
	colorTrans.rgb = 0xFFFFFF;
	trans.colorTransform = colorTrans;
	
	dspMain.UpdateSlaveGender();
	trans.colorTransform = colorTrans;
}


function ShowDividerPercentage(xperc:Number)
{
	AutoAttachAndPositionMovie("Divider", 7 + (4.48 * xperc), 5, 0, 10, 336);
}

function ShowDividerX(xpos:Number)
{
	AutoAttachAndPositionMovie("Divider", xpos + 7, 5, 0, 10, 336);
}

function ShowDoor(xpos:Number, ypos:Number, rot:Number, wid:Number, hei:Number, target:MovieClip)
{
	AutoAttachAndPositionMovie("Door", xpos, ypos, rot, wid, hei);
}


// Animations

var stpcount:Number;
var stpcount2:Number;
var incdir:Number;
var fuckit_mc:MovieClip;
var oldxscale:Number = 0;

function FuckIt(mc:MovieClip, origx:Number, lockx:Boolean, left:Boolean, duration:Number) {
	clearInterval(intervalId);
	var oldx:Number = mc._x;
	mc._xscale += (5 * incdir);
	if (mc._xscale > 150) mc._xscale = 150;
	else if (mc._xscale < 50)  mc._xscale = 50;
	mc._x = oldx;
	if (!lockx) {
		mc._x += (Math.floor(Math.random()*15) - 7);
		if (mc._x < (origx - 50)) mc._x = origx - 50;
		else if (mc._x > (origx + 10)) mc._x = origx + 10;
	} else {
		if (left == false) mc._x = 455 - mc._width;
	}
	mc._yscale = mc._xscale;
	stpcount += incdir;
	if (stpcount == 6) incdir = -1;
	else if (stpcount == 0) incdir = 1;
	intervalId = setInterval(_root, "FuckIt", duration, mc, origx, lockx, left, duration);
	duration = duration - 2;
	if (duration < 50) duration = 70;
	updateAfterEvent();
}

function StartFuckIt(mc:MovieClip, lockx:Boolean, left:Boolean)
{
	clearInterval(intervalId);
	fuckit_mc = mc;
	oldxscale = mc._xscale;
	mc._visible = true;
	stpcount = 0;
	incdir = 1;
	intervalId = setInterval(_root, "FuckIt", 200, mc, mc._x, lockx, left, 200);
}

function ShakeIt(interv:Number, mc:MovieClip, origx:Number, comment:String, pos:Number, count:Number, dur:Number) {
	if (count != undefined) {
		clearInterval(intervalId4);
		if (count > 0) {
			count--;
			if (count > 0) intervalId4 = setInterval(_root, "ShakeIt", dur, interv, mc, mc._x, comment, pos, count, 1200);
		}
	} 
	if (mc.loading == true && image.loaderror != true) return;
	if (mc.loading == false && image.loaderror != true && origx == 0) origx = mc._x;
	if (pos != undefined) mc.gotoAndStop(pos);
	if (interv == 1) clearInterval(intervalId);
	else clearInterval(intervalId2);

	var oldx:Number = mc._x;
	if (mc._x > origx) mc._x = origx - 30;
	else mc._x += 30;
	if (Math.round(mc._x) != Math.round(origx)) 	{
		if (interv == 1) intervalId = setInterval(_root, "ShakeIt", 60, interv, mc, origx, comment);
		else intervalId2 = setInterval(_root, "ShakeIt", 60, interv, mc, origx, comment);
	} else if (comment != "") AddText(comment);
}

function StartShakeIt(mc:MovieClip, inittime:Number, comment:String) {
	clearInterval(intervalId);
	intervalId = setInterval(_root, "ShakeIt", inittime, 1, mc, mc._x, comment);
}

function ChangeImage(mc:MovieClip, newpos:Number, say:String, hide_mc:MovieClip, show_mc:MovieClip) {
	clearInterval(intervalId);
	mc.gotoAndStop(newpos);
	mc._visible = true;
	if (say != undefined) AddText(say);
	if (hide_mc != undefined) hide_mc._visible = false;
	if (show_mc != undefined) {
		show_mc._alpha = 100;
		show_mc._visible = true;
	}
	updateAfterEvent();
}

function ChangeImage2(mc:MovieClip, newpos:Number, say:String, hide_mc:MovieClip, show_mc:MovieClip) {
	clearInterval(intervalId2);
	if (newpos != undefined) mc.gotoAndStop(newpos);
	mc._visible = true;
	if (say != undefined) AddText(say);
	if (hide_mc != undefined) hide_mc._visible = false;
	if (show_mc != undefined) {
		show_mc._alpha = 100;
		show_mc._visible = true;
	}
	updateAfterEvent();
}

function StartChangeImage(duration:Number, mc:MovieClip, newpos:Number, say:String, hide_mc:MovieClip, show_mc:MovieClip) {
	clearInterval(intervalId);
	intervalId = setInterval(_root, "ChangeImage", duration, mc, newpos, say, hide_mc, show_mc);
}

function ChangeImageList(duration:Number, movie:String, place:Number, align:Number, say:String, bHide:Boolean, cnt:Number) {
	clearInterval(intervalId);
	//trace("movie = " + movie + " " + duration + " " + place + " " + align + " " + say + " " + bHide + " " + cnt);
	var ar:Array = movie.split(",");
	if (cnt == undefined) cnt = 1;
	var nWait:Number = duration;
	if (bHide == true) {
		HideImages(true);
		HideAutoLoadedImages();
	}
	// prcess string, andle special cases like
	// wait
	// hideimages
	// say
	// doxml
	// doevent
	var s:String = "";
	while (Math.abs(cnt) <= ar.length) {
		s = ar[Math.abs(cnt) - 1];
		var sl:String = s.toLowerCase();
		if (cnt > 0) cnt++;
		else cnt--;
		if (sl.substr(0, 4) == "wait") {
			nWait = Number(Language.strTrim(s.substr(4)));
			if (isNaN(nWait)) nWait = duration;
			s = "";
			continue;
		}
		if (sl == "hideimages") {
			HideImages(true);
			HideAutoLoadedImages();
			s = "";
			continue;
		}
		if (sl.substr(0, 3) == "say") {
			s = Language.strTrim(s.substr(3));
			AddText(s);
			s = "";
			continue;
		}
		if (sl.substr(0, 7) == "doevent") {
			s = Language.strTrim(s.substr(7)).split("(").join("").split(")").join("");
			if (IsNaN(s)) DoEventNext(s);
			else DoEventNext(Number(s));
			s = "";
			continue;
		}
		if (sl.substr(0, 5) == "doxml" || sl.substr(0, 5) == "doact") {
			s = Language.strTrim(s.substr(5)).split("(").join("").split(")").join("");
			XMLData.ParseDoEvent(s, undefined, sl.substr(0, 5));
			s = "";
			continue;
		}		
	}
	// Show the image
	if (s != "") {
		var obj:Object = FindAnyLoadedImage(s);
		if (obj != null) {
			obj.mc._visible = true;
			obj = null;
		} else AutoLoadImageAndShowMovie(s, place, align);
	}
	
	// Finished?
	if (Math.abs(cnt) > ar.length) {
		if (cnt > 0) {
			// no looping
			if (say != undefined) AddText(say);
			if (ObjEvent != null) {
				if (typeof(ObjEvent) == "string") {
					StrEvent = String(ObjEvent);
					if (!XMLData.DoXMLActForSlave(StrEvent, SMData.GetSlaveByIndex(PersonIndex), true)) XMLData.XMLEventLastNode(StrEvent, false);
				} else XMLData.XMLEventByNode(ObjEvent);
			}
			return;
		}
		// we are looping, restore to start
		cnt = -1;
	}
	intervalId = setInterval(_root, "ChangeImageList", nWait, duration, movie, place, align, say, bHide, cnt);
}

function StartChangeImageList(duration:Number, movie:String, place:Number, align:Number, say:String, bHide:Boolean) {
	clearInterval(intervalId);
	intervalId = setInterval(_root, "ChangeImageList", duration, duration, movie, place, align, say, bHide);
}

function FadeImage(duration:Number, mc:MovieClip, say:String, speed:Number):Void {
	if (stpcount > 0) {
		stpcount -= duration;
		return;
	}
    mc._alpha -= speed;
    if (mc._alpha <= 0 || mc._alpha >= 100) {
        if (mc._alpha <= 0) mc._visible = false;
        clearInterval(intervalId);
		if (say != "" && say != undefined) AddText(say);
    }
	updateAfterEvent();
}

function StartFadeImage(duration:Number, mc:MovieClip, say:String, sdelay:Number, speed:Number) {
	if (sdelay == undefined) sdelay = 0;
	if (mc == undefined) mc = lastmc;
	if (speed == undefined) speed = 10;
	stpcount = sdelay;
	clearInterval(intervalId);
	intervalId = setInterval(_root, "FadeImage", duration, duration, mc, say, speed);
}

function ZoomImage(mc:MovieClip, stepsg:Number, endscale:Number, xpos:Number, ypos:Number, callobj:Object, callback:String)
{	
    mc._xscale += ((endscale - mc._xscale) / stepsg);
	mc._yscale = mc._xscale;
	var cxpos:Number = 231 - (((xpos - 7) / 448) * mc._width);	// 224 + 7
	var cypos:Number = 173 - (((ypos - 5) / 336) * mc._height);	// 168 + 5
	if ((cxpos + mc._width) < 455) cxpos = 455 - mc._width;	// 448 + 7
	if (cxpos > 7) cxpos = 7;  
	if ((cypos + mc._height) < 341) cypos = 341 - mc._height;	//336 + 5
	if (cypos > 5) cypos = 5;
	mc._x = cxpos;
	mc._y = cypos;
	stpcount--;
    if (stpcount < 1) {
		OnTopOverlayWhite._visible = false;
		clearInterval(intervalId2);
		if (callback != undefined) {
			mc._visible = false;
			if (callobj == undefined) callobj = _root;
			callobj[callback]();
		}
    }
}

function StartZoomImage(mc:MovieClip, duration:Number, steps:Number, endscale:Number, xpos:Number, ypos:Number, callobj:Object, callback:String) 
{
	clearInterval(intervalId2);
	ShowMovie(OnTopOverlayWhite, 0, 0);
	stpcount = steps;
	mc._visible = true;
	intervalId2 = setInterval(_root, "ZoomImage", duration, mc, stpcount, mc._xscale * (endscale / 100), xpos, ypos, callobj, callback);
}

function MoveImage(mc:MovieClip, steps:Number, startxpos:Number, startypos:Number, endxpos:Number, endypos:Number, hidemc:MovieClip):Void {
	stpcount2++;
	var newxpos:Number = startxpos + ((endxpos - startxpos) * (stpcount2 / steps));
	var newypos:Number = startypos + ((endypos - startypos) * (stpcount2 / steps));
	mc._x = newxpos;
	mc._y = newypos;
    if (stpcount2 >= steps) {
		Sounds.StopAllSounds();
		if (hidemc != undefined) hidemc._visible = false;
		clearInterval(intervalId2);
	}
	updateAfterEvent();
}

function StartMoveImage(mc:MovieClip, duration:Number, steps:Number, startxpos:Number, startypos:Number, endxpos:Number, endypos:Number, hidemc:MovieClip) {
	clearInterval(intervalId2);
	stpcount2 = 0;
	mc._visible = true;
	intervalId2 = setInterval(_root, "MoveImage", duration, mc, steps, startxpos, startypos, endxpos, endypos, hidemc);
}

function AlternateImage(mc:MovieClip, newpos:Number, oldpos:Number) {
	if (mc._currentframe == newpos) mc.gotoAndStop(oldpos);
	else mc.gotoAndStop(newpos);
	updateAfterEvent();
}

function StartAlternateImage(duration:Number, mc:MovieClip, newpos:Number, oldpos:Number) {
	clearInterval(intervalId);
	intervalId = setInterval(_root, "AlternateImage", duration, mc, newpos, oldpos);
}

function CumSplatter(internalc:Boolean)
{
	if (internalc == true) {
		InternalCum.gotoAndPlay(1);
		return;
	}
	clearInterval(intervalId3);
	Cum.gotoAndStop(1);
	Cum.WhiteOut._alpha = 100;
	Cum.WhiteOut._visible = true;
	intervalId3 = setInterval(_root, "ChangeImage2", 1000, Cum, 2, "", Cum.WhiteOut);
	StartFadeImage(10, Cum.WhiteOut, "", 0 , 20);
	Cum._visible = true;
}


function DoCumSplatter(mc:MovieClip, align:Number, frame:Number, moveonly:Boolean, internalc:Boolean)
{
	clearInterval(intervalId3);
	if (mc != undefined) {
		if (moveonly == true) mc.gotoAndStop(frame);
		else ShowMovie(mc, 1.1, align, frame);
	}
	CumSplatter(internalc);
}

function StartCumSplatter(delay:Number, mc:MovieClip, align:Number, frame:Number, moveonly:Boolean, internalc:Boolean) {
	clearInterval(intervalId3);
	intervalId3 = setInterval(_root, "DoCumSplatter", delay, mc, align, frame, moveonly, internalc);
}

function ResetActImages()
{
	i = arLoadedMovieArray.length;
	while (--i >= 0) {
		if (arLoadedMovieArray[i] == null) continue;
		var mc:MovieClip = MovieClip(arLoadedMovieArray.pop());
		mc.removeMovieClip();
		delete mc;
	}
	delete arLoadedMovieArray
	arLoadedMovieArray = new Array();
	
	slaveData.ActInfoBase.ResetList(slaveData);
	slaveData.ActInfoOther.ResetList(slaveData);
	slaveData.ActInfoCurrent = slaveData.ActInfoBase;
	ActInfoCurrent = slaveData.ActInfoCurrent;
}

function RemoveFromLoadedImages(mc:MovieClip)
{
	if (mc == undefined || mc == null) return;
	i = arLoadedMovieArray.length;
	while (--i >= 0) {
		if (mc == arLoadedMovieArray[i]) {
			mc.removeMovieClip();
			arLoadedMovieArray[i] = null;
			return;
		}
	}
}

function FindAnyLoadedImage(mv:String, i:Number) : Object
{
	if (mv == undefined || mv == "") return null;
	var idx:Number = i;
	if (idx == undefined) idx = arAutoLoadedMovieArray.length;
	if (idx == undefined) idx = 0;
	while (--idx > 0) {
		if (arAutoLoadedMovieArray[idx] == null) continue;
		var mc:MovieClip = arAutoLoadedMovieArray[idx];
		if (mc.mv == mv) {
			var obj:Object = new Object();
			obj.mc = mc;
			obj.idx = idx;
			return obj;
		}
	}
	return FindLoadedImage(mv, i);
}

function FindLoadedImage(mv:String, i:Number) : Object
{
	if (mv == undefined || mv == "") return null;
	var idx:Number = i;
	if (idx == undefined) idx = arLoadedMovieArray.length;
	if (idx == undefined) idx = 0;
	while (--idx > 0) {
		if (arLoadedMovieArray[idx] == null) continue;
		var mc:MovieClip = arLoadedMovieArray[idx];
		if (mc.mv == mv) {
			var obj:Object = new Object();
			obj.mc = mc;
			obj.idx = idx;
			return obj;
		}
	}
	return FindPermanentImage(mv, i);
}

function FindPermanentImage(mv:String, i:Number) : Object
{
	if (mv == undefined || mv == "") return null;
	if (i == undefined) i = arPermanentMovieArray.length;
	while (--i >= 0) {
		var mc:MovieClip = arPermanentMovieArray[i];
		if (mc.mv == mv) {
			var obj:Object = new Object();
			obj.mc = mc;
			obj.idx = i;
			return obj;
		}
	}
	return null;
}

// Sex Dream
function ShowSexDream(bLesbian:Boolean)
{	
	if (bLesbian == undefined) {
		bLesbian = Sexuality < 25;
		if (Sexuality <= 75) {
			if (Sexuality < 50) {
				if (PercentChance(50)) bLesbian = true;
			} else if (PercentChance(25)) bLesbian = true;
		}
	}
	if (SlaveGirl.ShowSexDream(bLesbian) == true) return;
	
	if (bLesbian) {
		if (IsMale()) ShowMovie(ClipSexDream, 1, 4.1, 7);
		else ShowMovie(ClipSexDream, 1.1, 4.1, Math.floor(Math.random()*3) + 4);
	} else ShowMovie(ClipSexDream, 1.1, 4.1, Math.floor(Math.random()*3) + 1);
	ClipSexDream._alpha = 65;
}


// People

function HideAllPeople() {
	HideAssistant();
	OnTopOverlayWhite._visible = false;
	OnTopOverlayWhite2._visible = false;
	OnTopOverlay._visible = false;
	if (SMAppearance._visible) SMAppearance._visible = false;
	
	People.HideImages();
	
	SlaveGirl.HidePeople();
	CurrentAssistant.HidePeople();
	
	modulesList.HidePeople();
	SMAppearance.pplace = -1000;
	SMAppearance.frame = -1000;
}


function HidePeople()
{
	HideAllPeople();
	ShowSupervisor();
}


// Initialisation
ClipSexDream.gotoAndStop(1);
Cum.gotoAndStop(1);

Quitter.LText.styleSheet = Language.styles;
NextEvent.LText.styleSheet = Language.styles;
