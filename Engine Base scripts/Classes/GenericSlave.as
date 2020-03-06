// Translation status: COMPLETE

import Scripts.Classes.*;

class GenericSlave extends Scripts.Classes.GenericSlaveImages
{
	private var Dress:MovieClip;
	private var DressNaked:MovieClip;
	private var LastDress:Number;
	
	private var boobsize:Number;
	private var cocksize:Number;

	
	// static function to create the class instance
	public static function main(swfRoot:MovieClip, slave:Object, core:Object) : Scripts.Classes.SlaveModule 
	{
		// entry point
		return new Scripts.Classes.GenericSlave(swfRoot, slave, core);
	}
	
	// constructor, initialises private variables
	public function GenericSlave(mc:MovieClip, slave:Object, core:Object)
	{
		super(mc, slave, core);
		
		this.LastDress = -99;
		this.Dress = undefined;
		this.DressNaked = undefined;
		boobsize = 0;
		cocksize = 0;
		ldf = new Object();
	}
	
	// delete any permanently loaded images (dresses here)
	public function Destroy() {
		this.Dress.removeMovieClip();
		this.DressNaked.removeMovieClip();
	}
	
		
	// General, when being trained as a slave
	
	
	// Dickirl
	
	public function DickgirlPotionOffer()
	{
		coreGame.XMLData.XMLGeneral("SlaveTrainings/Dickgirl/DickgirlPotionOfferDefault");
	}
	
	
	// Dress
	
	private var nakedimg:String;
	
	private function GetNakedImage(size:Number) : String
	{
		var img:String;
		var chc:Number = 0;
		var nn:Boolean = slaveData.IsDickgirl() && (coreGame.slaveData.ActInfoCurrent.GetDickgirlActCount(13) != 0);
		if (nn) {
			chc = coreGame.slaveData.ActInfoCurrent.GetDickgirlActCount(13);
			if (coreGame.slaveData.ActInfoCurrent.IsAlternateNames()) {
				img = "Sex Act - Naked Dickgirl ";
				nn = false;
			} else img = "Sex Act - Naked (As Dickgirl "; 
		} else {
			if (slaveData.IsCatgirl()) {
				chc = coreGame.slaveData.ActInfoCurrent.GetCatgirlActCount(13);
				if (chc > 0) nn = true;
				if (coreGame.slaveData.ActInfoCurrent.IsAlternateNames()) {
					img = "Sex Act - Naked Catgirl ";
					nn = false;
				} else img = "Sex Act - Naked (As Catgirl ";
			}
			if (chc == 0) {
				chc = coreGame.slaveData.ActInfoCurrent.GetNormalActCount(13);
				img = "Sex Act - Naked ";
			}
		}
		
		if (coreGame.NakedChoice == 0) coreGame.NakedChoice = coreGame.slrandom(chc);

		if (size >= 1.1) {
			if (size < 1.2) img += nn ? " BE10" : " (BE10)";
			else if (size < 1.4) img += nn ? " BE25" : " (BE25)";
			else if (size < 1.8) img += nn ? " BE50" : " (BE50)";
			else img += nn ? " BE100" : " (BE100)";
		}

		img += coreGame.NakedChoice + (nn ? ").png" : ".png");
		return img;
	
	}
	public function ShowNaked() {
	
		boobsize = int(sd.vitalsBustCurrent + 0.9) / int(sd.vitalsBustStart);
		cocksize = Math.ceil(sd.ClitCockSize * 30) /  Math.ceil(sd.ClitCockSizeStart * 30);

		var img:String = GetNakedImage(boobsize);
		if (coreGame.DressFrame == 0 || this.LastDress != coreGame.DressWorn) {
			this.DressNaked.removeMovieClip();
			this.DressNaked = undefined;
			nakedimg = img;
		}
		var ti:GenericSlave = this;
		ldf.LoadDoneBE = function (image:MovieClip)
		{
			if (image.loaderror != true) return;  // ignore successful loads
	
			var bs:Number = ti.boobsize;
			if (bs == 1) {
				ti.coreGame.ShowSlave(ti.slaveData, 1, 1);
				ti.Backgrounds.ShowHousing();
				return;
			}
			
			// try next size down for BE
			if (bs >= 1.9) bs = 1.5;
			else if (bs >= 1.4) bs = 1.25;
			else if (bs >= 1.2) bs = 1.1;
			else bs = 1;
			ti.boobsize = bs;
			ti.DressNaked.removeMovieClip();
			ti.DressNaked = undefined;
			ti.nakedimg = ti.GetNakedImage(ti.boobsize);
			if (bs >= 1.1) ti.DressNaked = ti.LIFShowMovie(ti.DressNaked, ti.nakedimg, ti.GetImagePlace(), 1, ti.ldf.LoadDoneBE);
			else ti.DressNaked = ti.LIFShowMovie(ti.DressNaked, ti.nakedimg, ti.GetImagePlace(), 1);
		}
		ldf.LoadDoneNM = function(image:MovieClip) {
			if (image.loaderror != true) return;  // ignore successful loads
			ti.coreGame.ShowSlave(ti.slaveData, ti.GetImagePlace(), 1);
			ti.Backgrounds.ShowHousing();
		}

		if (boobsize >= 1.1) this.DressNaked = this.LIFShowMovie(this.DressNaked, nakedimg, GetImagePlace(), 1, ldf.LoadDoneBE);
		else this.DressNaked = this.LIFShowMovie(this.DressNaked, nakedimg, GetImagePlace(), 1, ldf.LoadDoneNM);
		Backgrounds.ShowHousing();
		coreGame.lastmc = this.DressNaked;
	}
	
	public function ShowNakedSmall()
	{
		var img:String;
		if (slaveData.IsDickgirl()) {
			if (coreGame.slaveData.ActInfoCurrent.IsAlternateNames()) img = "Sex Act - Naked Dickgirl " +  coreGame.NakedChoice; 
			else img = "Sex Act - Naked (As Dickgirl " +  coreGame.NakedChoice + ")"; 
		} else img = "Sex Act - Naked ";
		this.DressNaked = this.LIFShowMovie(this.DressNaked, img + ".png", 0, 1);
	}
	
	private function GetDressImage(size:Number) : String
	{
		var img:String;
		var dc:Number = 0;
		var nn:Boolean = false;
		img = coreGame.DressWorn == 0 ? "Dress Plain" : "Dress " + slaveData.DressWorn;
		if (slaveData.IsDickgirl()) {
			dc = coreGame.slaveData.ActInfoCurrent.GetDickgirlActCount(slaveData.DressWorn * -1);
			if (dc != 0) {
				if (coreGame.slaveData.ActInfoCurrent.IsAlternateNames()) img += " Dickgirl";
				else {
					img += " (As Dickgirl";
					nn = true;
				}
			}
		}
		if (dc == 0 && slaveData.IsCatgirl()) {
			dc = coreGame.slaveData.ActInfoCurrent.GetCatgirlActCount(slaveData.DressWorn * -1);
			if (dc != 0) {
				nn = true;
				if (coreGame.slaveData.ActInfoCurrent.IsAlternateNames()) img += " Catgirl";
				else {
					nn = true;
					img += " (As Catgirl";
				}
			}
		}
		if (dc == 0) dc = coreGame.slaveData.ActInfoCurrent.GetNormalActCount(slaveData.DressWorn * -1);
	
		coreGame.DressFrame = coreGame.slrandom(dc);
		if (dc > 1 || nn) img += " " + coreGame.DressFrame;
		
		if (size >= 1.1) {
			if (size < 1.2) img += nn ? " BE10" : " (BE10)";
			else if (size < 1.4) img += nn ? " BE25" : " (BE25)";
			else if (size < 1.8) img += nn ? " BE50" : " (BE50)";
			else img += nn ? " BE100" : " (BE100)";
		}
		img += nn ? ").png" : ".png";
		return img;
	}
	
	public function ShowDress() {
		
		var img:String;
		if (coreGame.DressFrame == 0 || this.LastDress != coreGame.DressWorn) {
			boobsize = int(sd.vitalsBustCurrent + 0.9) / int(sd.vitalsBustStart);
			cocksize = Math.ceil(sd.ClitCockSize * 30) /  Math.ceil(sd.ClitCockSizeStart * 30);
			this.Dress.removeMovieClip();
			this.Dress = undefined;
			this.LastDress = slaveData.DressWorn;
			img = GetDressImage(boobsize);
		} else img = "Dress Plain.png";
	
		var ti:GenericSlave = this;
		ldf.LoadDoneBE = function (image:MovieClip)
		{
			if (image.loaderror != true) return;  // ignore successful loads
	
			var bs:Number = ti.boobsize;
			if (bs == 1) {
				ti.coreGame.ShowSlave(ti.slaveData, ti.GetImagePlace(), 1);
				ti.Backgrounds.ShowHousing();
				return;
			}
			
			// try next size down for BE
			if (bs >= 1.9) bs = 1.5;
			else if (bs >= 1.4) bs = 1.25;
			else if (bs >= 1.2) bs = 1.1;
			else bs = 1;
			ti.boobsize = bs;
			ti.Dress.removeMovieClip();
			ti.Dress = undefined;
			if (bs >= 1.1) ti.Dress = ti.LIFShowMovie(ti.Dress, ti.GetDressImage(ti.boobsize), ti.GetImagePlace(), 1, ti.ldf.LoadDoneBE);
			else ti.Dress = ti.LIFShowMovie(ti.Dress, ti.GetDressImage(ti.boobsize), ti.GetImagePlace(), 1);
		}
		ldf.LoadDoneNM = function(image:MovieClip) {
			if (image.loaderror != true) return;  // ignore successful loads
			ti.coreGame.ShowSlave(ti.slaveData, ti.GetImagePlace(), 1);
			ti.Backgrounds.ShowHousing();
		}
		if (boobsize >= 1.1) this.Dress = this.LIFShowMovie(this.Dress, img, GetImagePlace(), 1, ldf.LoadDoneBE);
		else this.Dress = this.LIFShowMovie(this.Dress, img, GetImagePlace(), 1, ldf.LoadDoneNM);
		Backgrounds.ShowHousing();
		coreGame.lastmc = this.Dress;
	}
	
	
	public function ShowDressSmall()
	{
		this.Dress.removeMovieClip();
		this.Dress = undefined;
		this.Dress = this.LIFShowMovie(this.Dress, "Dress Plain.png", 0, 1);
		this.LastDress = -99;
	}
	
	
	// Standard Events
	
	public function ShowDating()
	{
		slaveData.ShowActImage(10021);
	}
	
	public function ShowMilkEnd() : Boolean
	{	
		this.ALIFShowMovieDefaultAct("Event - Milk - End 1.jpg", GetImagePlace(), 1, 1017);
		return true;
	}
	
	public function ShowMilkAccident() : Boolean
	{				
		ALIFShowMovieDefaultAct("Event - Milk - Accident 1.jpg", GetImagePlace(), 1, 1004);
		return true;
	}
	
	public function ShowMorningMouthfull() : Boolean
	{
		slaveData.ShowActImage(10032);
		if (coreGame.UseGeneric) {
			this.ALIFShowMovie("Event - Morning Mouthfull.jpg|Sex Act - Cum Bath 1.jpg|Sex Act - Blowjob 1.jpg", GetImagePlace(), 1);
			coreGame.UseGeneric = false;
		}
		return true;
	}
	
	public function ShowNakedApron() : Boolean
	{
		slaveData.ShowActImage(10015);
		return true;
	}
	
	public function ShowPropositionAccepted()
	{
		slaveData.ShowActImage(10025);
		if (coreGame.UseGeneric) this.ALIFShowMovie("Propositions a guy and they have sex.jpg|Sex Act - Fuck 1.jpg", GetImagePlace(), 1);
	}
	
	public function ShowPropositionRefused()
	{
		slaveData.ShowActImage(10026);
		if (coreGame.UseGeneric) this.ALIFShowMovie("Propositions a guy and is refused.jpg|Refused 1.jpg", GetImagePlace(), 1);
	}
	
	public function ShowRaped() : Boolean
	{
		slaveData.ShowActImage(10016);
		return true;
	}
	
	public function ShowRetrieved() : Boolean
	{
		slaveData.ShowActImage(10020);
		if (coreGame.UseGeneric) this.ALIFShowMovie("Event - Slave Retrieved 1.jpg|Sex Act - Bondage 1.jpg", GetImagePlace(), 1);
		Backgrounds.ShowAlley();
		return false;
	}
	
	
	public function ShowTentaclePregnancyReveal() : Boolean
	{			
		if (!coreGame.UseGeneric) {
			slaveData.ShowActImage(10022);
			if (coreGame.UseGeneric) {
				this.ALIFShowMovie("Event - Tentacle Pregnancy Reveal.jpg", GetImagePlace(), 1);
				coreGame.UseGeneric = false;
			}
		}
		return !coreGame.UseGeneric;
	}
	public function ShowPregnancyReveal() : Boolean
	{			
		if (!coreGame.UseGeneric) {
			slaveData.ShowActImage(10022);
			if (coreGame.UseGeneric) {
				this.ALIFShowMovie("Event - Tentacle Pregnancy Reveal.jpg", GetImagePlace(), 1);
				coreGame.UseGeneric = false;
			}
		}
		return !coreGame.UseGeneric;
	}
	
	public function ShowTentaclePregnancyBirth(type:String) : Boolean
	{
		if (!coreGame.UseGeneric) {
			slaveData.ShowActImage(10023);
			if (coreGame.UseGeneric) {
				this.ALIFShowMovie("Event - Tentacle Pregnancy Birth.jpg", GetImagePlace(), 1);
				coreGame.UseGeneric = false;
			}
		}
		return !coreGame.UseGeneric;
	}
	
	public function ShowTentacleSex(place:Number) : Boolean
	{
		slaveData.ShowActImage(10000);
		return false;
	}
	
	public function ShowTired(cum:Boolean)
	{
		slaveData.ShowActImage(10001);
	}
	
	// Love
	
	public function ShowLoveConfession()
	{
		slaveData.ShowActImage(10027);
		if (coreGame.UseGeneric) {
			this.ALIFShowMovie("Love Confession.jpg|Chore - Discuss 1.jpg", GetImagePlace(), 1);
			coreGame.UseGeneric = false;
		}
	}
	
	public function ShowLoveAccepted()  : Boolean
	{
		slaveData.ShowActImage(10028);
		if (coreGame.UseGeneric) {
			this.ALIFShowMovie("Love Confession Accepted.jpg|Chore - Discuss 1.jpg", GetImagePlace(), 1);
			coreGame.UseGeneric = false;
		}
		return false;
	}
	
	public function ShowLoveRefused()
	{
		Backgrounds.HideBackgrounds();
		slaveData.ShowActImage(10029);
		if (coreGame.UseGeneric) {
			this.ALIFShowMovie("Love Confession Refused.jpg|Refused 1.jpg", GetImagePlace(), 1);
			coreGame.UseGeneric = false;
		}
	}
	
	public function ShowLoveUnsure()  : Boolean
	{
		slaveData.ShowActImage(10035);
		return !coreGame.UseGeneric;
	}
	
	public function ShowRefusedAction(Action:Number, slave:String, servant:String, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Libido:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, SexualEnergy:Number) : Boolean
	{
		slaveData.ShowActImage(10024);
		return false;
	}
	
	// Schools
	public function ShowSchoolSwimming() : Boolean
	{
		slaveData.ShowActImage(1033);
		return !coreGame.UseGeneric;
	}
	
	public function ShowSchoolDance()
	{
		if (slaveData.IsPonygirl()) slaveData.ShowActImage(1009.1);
		if (coreGame.UseGeneric || !slaveData.IsPonygirl()) slaveData.ShowActImage(1009);
	}
	
	
	// Chores
	
	public function ShowChoreDiscuss() {
		slaveData.ShowActImage(1004);
	}
	
	// School
	public function ShowSchoolSinging() : Boolean { 
		slaveData.ShowActImage(1033);
		return true;
	}
	
	
	// Sex
	public function ShowSexActAnal() {
		slaveData.ShowActImage(7);
	}
	
	public function ShowSexActBlowjob() {
		slaveData.ShowActImage(5);
	}
	
	public function ShowSexActFuck() {
		slaveData.ShowActImage(4);
	}
	
	public function ShowSexActLick() {
		slaveData.ShowActImage(3);
	}
	
	public function ShowSexActSpank(whip:Boolean) {
		slaveData.ShowActImage(18);
	}
	
	
	// Startup
	
	public function HideDresses()
	{
		this.Dress._visible = false;
		this.Dress.hide = true;
		this.DressNaked._visible = false;
		this.DressNaked.hide = true;
	}
	
	public function Initialise() {
		coreGame.UseImages = true;
		this.LastDress = 100;
	}
	
	public function HideImages()
	{
		super.HideImages();
	}
	
	public function ShowIntroPage(page:Number, align:Number) : MovieClip
	{
		if (align == undefined) align = 2;
		return this.ALIFShowMovie("Introduction " + page + ".jpg", 4, align);
	}

	public function ShowUntrainable() : MovieClip
	{
		return this.ALIFShowMovie("Untrainable.jpg", 4, 14);
	}

	//
	// Assistant - when the slave is used as an assistant
	
	// delete any permanently loaded images
	public function DestroyAsAssistant()
	{
		coreGame.RemoveLoadedImage(this.Assistant);
	}
	
	// ShowAssistant - shows a graphic for the assistant
	// 1 = normal view in small rectangle
	// 2 = tentacle sex (small version shown when slave girl raped)
	// 3 = raped
	// 4 = never actually passed as a parameter
	// 5 = wet - she falls in some water
	// 6 = large graphic shown when your slave runs away
	public function ShowAsAssistant(type:Number) : Boolean
	{
		if (type == 4) return false;
		switch(type) {
			case 1:
				coreGame.UseGeneric = false;
				slaveData.ShowActImage(10033, 0);
				//trace("ShowAsAssistant(1): " + coreGame.UseGeneric);
				this.Assistant.hide = false;
				if (coreGame.UseGeneric) LoadAssistantImage(0, 1);
				return true;
			case 2:
				slaveData.ShowActImage(10000, 0);
				return true;
			case 3:
				slaveData.ShowActImage(10016, 0);
				return true;
			case 5:
				this.ALIFShowMovie("Assistant Event - Wet 1.jpg", GetImagePlace(), 1);
				return true;
			case 6:
				this.ALIFShowMovie("Assistant Event - Runaway 1.jpg|Chore - Discuss 1.jpg", GetImagePlace(), 1);
				return true;
			case 0:	
				this.Assistant = undefined;
				coreGame.RemoveLoadedImage(this.Assistant);
				LoadAssistantImage(1, 1);
				return true;
		}
		return false;
	}
	
	private function LoadAssistantImage(place:Number, align:Number)
	{
		trace("LoadAssistantImage: " + place + " " + align);
		var movie:String;
		if (sd.IsDickgirl()) movie = "Assistant (As Dickgirl 1).png";
		else movie = "Assistant.png";
		if (this.ImageFolder != "") movie = this.ImageFolder + "/" + movie;
		
		var ti:GenericSlave = this;
	
		ldf.LoadDoneAss = function (image:MovieClip, tgt:MovieClip, mv:String)
		{
			if (image.loaderror != true) return;  // ignore successful loads
			image.loading = true;

			var img:String = "";
			if (mv.indexOf("Assistant (As Dickgirl 1)") != -1) {
				img = "Assistant.png";
				ti.Assistant = ti.coreGame.LoadImageAndShowMovie(ti.Assistant, img, ti.ldf.place, ti.ldf.align, ti.mcBase, undefined, ti.ldf.LoadDoneAss);
				return;
			} else {
				img = ti.slaveData.SlaveImage;
				if (img.substr(-12) == " (Testicles)" && !ti.coreGame.DickgirlTesticles) img = img.split(" (Testicles)").join("");
				if (img.indexOf(".") != -1) ti.Assistant = ti.coreGame.LoadImageAndShowMovie(ti.Assistant, img, ti.ldf.place, ti.ldf.align, ti.mcBase, 0);
				else ti.Assistant = ti.coreGame.AutoAttachAndShowMovie(img, ti.ldf.place, ti.ldf.align, 1, ti.mcBase);
			}
		}

		ldf.place = place;
		ldf.align = align;
		trace("LoadAssistantImage: " + movie);
		this.Assistant = _root.LoadImageAndShowMovie(this.Assistant, movie, place, align, this.mcBase, undefined, ldf.LoadDoneAss);
	}
	
	public function ShowAsAssistantTentacleSex() : Boolean
	{
		ShowTentacleSex();
		return true;
	}
	
	public function ShowAsAssistantAnal() : Boolean
	{
		slaveData.ShowActImage(7);
		return !coreGame.UseGeneric;
	}
	
	public function ShowAsAssistantSpanking() : Boolean
	{
		slaveData.ShowActImage(18);
		return !coreGame.UseGeneric;
	}
	
	public function ShowSlaveReview() : Boolean
	{
		slaveData.ShowActImage(10038);
		return !coreGame.UseGeneric;
	}
	
	public function HideAsAssistant()
	{
		HideImages();
		HideSlaveActions();
		HideDresses();
		this.Assistant._visible = false;
		this.Assistant.hide = true;
	}
	
	/*
	public function InitialiseAsAssistant(firsttime:Boolean) : MovieClip {
		HideImages();
		HideSlaveActions();
		HideEndings();
		HideDresses();
		HidePeople();
		return GetAssistantSelectionImage();
	}	
	*/
	
	public function InitialiseAsAssistant(firsttime:Boolean) : MovieClip {
		trace("InitialiseAsAssistant: " + firsttime);
		HideImages();
		HideSlaveActions();
		HideEndings();
		HideDresses();
		HidePeople();
		coreGame.RemoveLoadedImage(this.Assistant);
		this.Assistant = undefined;
		if (firsttime != undefined) return this.Assistant;
		LoadAssistantImage(3, 0);
		return this.Assistant;
	}
	
	public function InitialiseModule() { 
		super.InitialiseModule();
		
		coreGame.RemoveLoadedImage(this.Assistant);
		this.Assistant = undefined;
	}

}