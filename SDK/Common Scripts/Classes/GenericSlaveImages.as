// Translation status: COMPLETE

import Scripts.Classes.*;

class GenericSlaveImages extends Scripts.Classes.SlaveModule
{
	
private var ldf:Object;
	
public function GenericSlaveImages(mc:MovieClip, slave:Object, core:Object)
{
	super(mc, slave, core);
}

private function BuildEndingImages(str:String, def:String) : String
{
	var estr:String = str;
	if (coreGame.IsDickgirl()) estr = str + " (As Dickgirl).jpg|" + str;
	if (coreGame.IsCatgirl()) estr = str + " (Catgirl).jpg|" + str;
	if (coreGame.IsPuppygirl()) estr = str + " (Puppygirl).jpg|" + str;
	if (def == undefined) return estr + ".jpg";
	return estr + ".jpg|" + def + ".jpg";
}

// Endings

public function StartCatgirlTraining(type:Number) : Boolean
{
	return ShowEndingCatgirl();
}

public function FinishedCatgirlTraining() : Boolean
{
	return ShowEndingCatgirl();
}

public function ShowEndingCatgirl() : Boolean
{
	var img:String = "Ending - Catgirl.jpg";
	if (coreGame.IsDickgirl()) img = "Ending - Catgirl (As Dickgirl).jpg|" + img;

	this.ALIFShowMovie(img, GetImagePlace(), 1);
	return true;
}

public function ShowEndingCourtesan()
{
	coreGame.Backgrounds.ShowBedRoom();
	this.ALIFShowMovie(BuildEndingImages("Ending - Courtesan", "School - Refinement 1"), GetImagePlace(), 1);
}

public function ShowEndingCowgirl() 
{
	this.ALIFShowMovie(BuildEndingImages("Ending - Cowgirl", "Event - Milk - Milked 1"), GetImagePlace(), 1);
}

public function ShowEndingCumslut() : Boolean
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Cumslut", "Sex Act - Cum Bath.jpg|Sex Act - Blowjob 1"), GetImagePlace(), 1, 5);
	return true;
}

public function ShowEndingBoughtBack()
{
	this.ALIFShowMovie(BuildEndingImages("Ending - Bought Back", "Break 1"), GetImagePlace(), 1);
}

public function ShowEndingDickgirl()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Dickgirl", "Dickgirl 1"), GetImagePlace(), 1, 10011);
}

public function ShowEndingDrugAddict()
{
	this.ALIFShowMovie(BuildEndingImages("Ending - Drug Addict"), GetImagePlace(), 1);
}

public function ShowEndingLesbianSlave()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Lesbian Slave", "Sex Act - Lesbian 1.jpg|Sex Act - Fuck (Lesbian 1).jpg|Sex Act - Lesbian"), GetImagePlace(), 1, 11);
}

public function ShowEndingMaid()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Maid", "Event - Naked Apron 1.jpg|Chore - Cooking 1"), GetImagePlace(), 1, 1011);
}

public function ShowEndingMarriage()
{
	if (!slaveData.ShowActImage(3000)) this.ALIFShowMovie(BuildEndingImages("Ending - Marriage"), GetImagePlace(), 1);
}

public function ShowEndingNormal()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Normal", "Chore - Discuss 1"), GetImagePlace(), 1, 3);
}

public function ShowEndingNormalMinus()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Normal-", "Chore - Discuss 1"), GetImagePlace(), 1, 12);
}

public function ShowEndingNormalPlus()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Normal+", "Chore - Discuss 1"), GetImagePlace(), 1, 14);
}

public function ShowEndingProstitute()
{
	coreGame.Backgrounds.ShowBedRoom();
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Prostitute", "Sex Act - Fuck 1"), GetImagePlace(), 1, 3);
}

public function ShowEndingPuppygirl(type:Number) : Boolean
{
	var bi:String;
	if (coreGame.IsMale()) {
		switch(type) {
			case 1: bi = "Ending - Puppyboy - Bitch"; break;
			case 2: bi = "Ending - Puppyboy"; break;
			case 3: bi = "Ending - Puppyboy - Pedigree"; break;
		}		
	} else {
		switch(type) {
			case 1: bi = "Ending - Puppygirl - Bitch"; break;
			case 2: bi = "Ending - Puppygirl"; break;
			case 3: bi = "Ending - Puppygirl - Pedigree"; break;
		}
	}
	var img:String = bi;
	if (coreGame.IsDickgirl()) img = bi + " (As Dickgirl).jpg|" + img;
	img += ".jpg";
	img += img + "!Images/Trainings/Puppy/" + bi;
	this.ALIFShowMovie(img, GetImagePlace(), 1);
	return true;
}

public function ShowEndingRebel()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Rebel"), GetImagePlace(), 1, 12);
}

public function ShowEndingRich()
{
	this.ALIFShowMovie(BuildEndingImages("Ending - Rich"), GetImagePlace(), 1);
}

public function ShowEndingPonygirl() : Boolean
{
	if (coreGame.slaveData.SelectActImage(17)) coreGame.Generic.ShowSexActPonygirl();
	return true;
}

public function ShowEndingSexAddict()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Sex Addict", "Sex Act - Fuck 1"), GetImagePlace(), 1, 3);
}

public function ShowEndingSexManiac()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Sex Maniac", "Sex Act - Fuck 1"), GetImagePlace(), 1, 21);
}

public function ShowEndingSM()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - S&M", "Sex Act - Bondage 1"), GetImagePlace(), 1, 12);
}

public function ShowEndingTentacleSlave()
{
	ALIFShowMovieDefaultAct(BuildEndingImages("Ending - Tentacle Slave", "Tentacle Sex 1"), GetImagePlace(), 1, 10000);
}

public function ALIFShowMovie(movie:String, place:Number, align:Number, imgFunc:Function) : MovieClip
{
	if (this.ImageFolder != "") {
		movie = this.ImageFolder + "/" + movie;
		movie = movie.split("|").join("|" + this.ImageFolder + "/");
	}
	return coreGame.AutoLoadImageAndShowMovie(movie, place, align, this.mcBase, 0, imgFunc);
}

public function ALIFShowMovieDefaultAct(movie:String, place:Number, align:Number, act:Number) : MovieClip
{
	ldf.defact = act;
	var ti:GenericSlaveImages = this;
	ldf.LoadDoneImage = function (image:MovieClip) {
		if (image.loaderror != true) return;  // ignore successful loads
		ti.slaveData.ShowActImage(this.defact);
	}	
	if (this.ImageFolder != "") {
		movie = this.ImageFolder + "/" + movie;
		movie = movie.split("|").join("|" + this.ImageFolder + "/");
	}
	return coreGame.AutoLoadImageAndShowMovie(movie, place, align, this.mcBase, 0, ldf.LoadDoneImage);
}

public function LIFShowMovie(image:MovieClip, movie:String, place:Number, align:Number, imgFunc:Function) : MovieClip
{
	if (this.ImageFolder != "") {
		movie = this.ImageFolder + "/" + movie;
		movie = movie.split("|").join("|" + this.ImageFolder + "/");
	}	
	return coreGame.LoadImageAndShowMovie(image, movie, place, align, this.mcBase, 0, imgFunc);
}

private function GetImagePlace() : Number { return slaveData.GetWidescreenMode() == 0 ? 1 : 1.1; }


}