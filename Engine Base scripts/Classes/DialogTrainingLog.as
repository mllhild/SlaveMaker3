// View training log
// Translation status: COMPLETE

import Scripts.Classes.*;

class DialogTrainingLog extends DialogBase
{		
	private var arDiaryMovies:Array;			// internal attay for movieclips in the view screen
	private var nDiaryDate:Number;			// first date shown on the view screen
	
	// reference
	private var arTrainingArray:Array;			// current list of TrainingLogEntry objects

	// Constructor
	public function DialogTrainingLog(cg:Object)
	{ 
		super(cg.mcBase.mcDiaryMenu, cg);
		
		arTrainingArray = Diary.GetTrainingArray();
	}
		
	// User Interface for the Diary View
	
	// Open the diart view
	public function ViewDialog()
	{
		coreGame.currentDialog = this;
		
		mcBase.LExit.htmlText = "<b><font size='+4' color='#ffffff'>X</font></b>";
		mcBase.LNext.htmlText = "<b><font size='+4' color='#ffffff'>+</font></b>";
		mcBase.LPrevious.htmlText = "<b><font size='+4' color='#ffffff'>-</font></b>";
		
		mcBase.YearLabel.htmlText = Language.GetHtml("Year", "Diary");
		mcBase.DateLabel.htmlText = Language.GetHtml("CurrentDate", "Diary");

		
		var i:Number = arDiaryMovies.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			var mc:MovieClip = MovieClip(arDiaryMovies.pop());
			mc.removeMovieClip();
			delete mc;
		}
		delete arDiaryMovies;
		arDiaryMovies = new Array();
		
		var ti:DialogTrainingLog = this;
		mcBase.ExitButton.onPress = function() { ti.LeaveDialog(); }
		mcBase.ExitButton.onRollOver = function() {
			ti.mcBase.LExit.htmlText = ti.Language.GetHtml("Exit", "Diary", true)
		}
		mcBase.ExitButton.onRollOut = function() {
			ti.mcBase.LExit.htmlText = "<b><font size='+4' color='#ffffff'>X</font></b>";
		}
		mcBase.NextMonth.onPress = function() { ti.NextMonth(); }
		mcBase.NextMonth.onRollOver = function() {
			ti.mcBase.LNext.htmlText = ti.Language.GetHtml("NextMonth", "Diary", true)
		}
		mcBase.NextMonth.onRollOut = function() {
			ti.mcBase.LNext.htmlText = "<b><font size='+4' color='#ffffff'>+</font></b>";
		}
		mcBase.PreviousMonth.onPress = function() { ti.PreviousMonth(); }
		mcBase.PreviousMonth.onRollOver = function() {
			ti.mcBase.LPrevious.htmlText = ti.Language.GetHtml("PreviousMonth", "Diary", true)
		}
		mcBase.PreviousMonth.onRollOut = function() {
			ti.mcBase.LPrevious.htmlText = "<b><font size='+4' color='#ffffff'>-</font></b>";
		}
		
		for (i = 0; i < 40; i++) {
			var image:MovieClip = mcBase.Days.attachMovie("Diary - Day", "Day" + arDiaryMovies.length, mcBase.Days.getNextHighestDepth());
			var dn:Number = arDiaryMovies.push(image) - 1;
			image._width = 75;
			image._height = 82.8;
			var drow:Number = Math.floor(dn / 8);
			var dcol:Number = dn % 8;
			image._y = drow != 0 ? (drow * 80) : 0;
			image._x = dcol != 0 ? (dcol * 74) : 0;
			image.MoonPhase.gotoAndStop(3);
			image.DayButton.onRollOver = function() {
				ti.ShowDayDetails(this._parent);
			}
		}
		
		coreGame.HideAllImages();
		nDiaryDate = 1 + (Math.floor(coreGame.GameDate / 40) * 40);
		mcBase.CDate.htmlText = coreGame.strDayName + " " + coreGame.DecodeDate(coreGame.GameDate);
		mcBase._visible = true;
		ShowDialogContents();
		Beep();
	}
	
	// Exit the view back to the main menu
	public function LeaveDialog()
	{
		super.LeaveDialog();
			
		var i:Number = arDiaryMovies.length;
		if (i == undefined) i = 0;
		while (--i >= 0) {
			var mc:MovieClip = MovieClip(arDiaryMovies.pop());
			mc.removeMovieClip();
			delete mc;
		}
		delete arDiaryMovies;
		arDiaryMovies = new Array();
		
		coreGame.dspMain.Show();
		mcBase._visible = false;
		coreGame.dspMain.ShowMainButtons();
		Beep();
	}
 
 	// Show a single day details on rollover
	public function ShowDayDetails(mc:MovieClip)
	{
		mcBase.EntryText.htmlText = "";
		if (mc.dayindex != -1) {
			var dn:Number = arTrainingArray[mc.dayindex].LogDate;
			var nThisDayOfWeek:Number = dn % 8;
			if (nThisDayOfWeek == 0) nThisDayOfWeek = 8
			var strThisDayName:String = Language.GetText("Day" + nThisDayOfWeek, "Diary/WeekDays");

			var desc:String = "<b>" +  strThisDayName + " " + Language.GetHtml("Day", "Diary") + " " + dn + "</b>\r" + arTrainingArray[mc.dayindex].Description;
			var idx:Number = mc.dayindex + 1;
			while (idx < arTrainingArray.length) {
				if (arTrainingArray[idx].LogDate == dn) desc = desc + "\r" + arTrainingArray[idx].Description;
				idx++;
			}
			if (coreGame.Owner.IsOwnedByAnother() && (mc.dayno == (coreGame.TrainingStart + coreGame.TrainingTime - 1))) desc = desc + "\r\r<b>" +  Language.GetHtml("PlannedEnd", "Diary") + "</b>";
			mcBase.EntryText.htmlText = desc;
		} else {
			if (coreGame.Owner.IsOwnedByAnother() && (mc.dayno == (coreGame.TrainingStart + coreGame.TrainingTime - 1))) mcBase.EntryText.htmlText = "<b>" +  Language.GetHtml("PlannedEnd", "Diary") + "</b>";
		}
		var sdata:Slave;
		var gday:Number = coreGame.GetDayOfYear(mc.dayno);		// day of year
		for (var so:String in SMData.arUsableSlaves) {
			sdata = SMData.arUsableSlaves[so];
			if (gday == coreGame.GetDayOfYear(sdata.Birthday)) {
				coreGame.PersonName = sdata.SlaveName;
				mcBase.EntryText.htmlText += Language.GetHtml("Birthday", "Diary");
			}
		}

	}
	
	// show the current months details
	function ShowDialogContents()
	{
		mcBase.Year.text = coreGame.currentCity.nBaseYear + Math.floor(nDiaryDate / 400);
		var FullMoon:Number = ((coreGame.GameDate - coreGame.MoonPhaseDate + 1) % 29) + (Math.floor(nDiaryDate / 29) * 29);
		for (var i:Number = 0; i < 40; i++) {
			var dt:Number = nDiaryDate + i;
			if ((dt == FullMoon) || (dt == (FullMoon + 29)) || (dt == (FullMoon + 58))) arDiaryMovies[i].MoonPhase.gotoAndStop(1);
			else if (dt == (FullMoon + 14) || dt == (FullMoon + 29 + 14) || dt == (FullMoon + 58 + 14)) arDiaryMovies[i].MoonPhase.gotoAndStop(2);
			else arDiaryMovies[i].MoonPhase.gotoAndStop(3);
			arDiaryMovies[i].DayDate.text = coreGame.GetDayOfYear(dt);
			arDiaryMovies[i].Tentacle._visible = false;
			arDiaryMovies[i].Medal1._visible = false;
			arDiaryMovies[i].Medal2._visible = false;
			arDiaryMovies[i].Medal3._visible = false;
			arDiaryMovies[i].EntryGraphic._visible = false;
			if (coreGame.Owner.IsOwnedByAnother() && (dt == (coreGame.TrainingStart + coreGame.TrainingTime - 1))) {
				SetMovieColour(arDiaryMovies[i].Border, 255, 0, 0);
				arDiaryMovies[i].Border._visible = true;
				arDiaryMovies[i].EntryGraphic._visible = true;
			} else if (dt == coreGame.GameDate) arDiaryMovies[i].Border._visible = true;
			else if ((dt % 8) == 0) {
				SetMovieColour(arDiaryMovies[i].Border, 255, 128, 0);
				arDiaryMovies[i].Border._visible = true;
			} else arDiaryMovies[i].Border._visible = false;
			if (coreGame.OwnerTesting && coreGame.Owner.IsOwnedByAnother()) {
				var el:Number = dt - (coreGame.TrainingStart - 1);
				if ((el % 7) == 0) {
					if (coreGame.OwnerTestingUrgent) {
						SetMovieColour(arDiaryMovies[i].Border, 0, 0, 255);
						arDiaryMovies[i].Border._visible = true;
					} else if ((dt % 8) != 0) {
						SetMovieColour(arDiaryMovies[i].Border, 0, 0, 255);
						arDiaryMovies[i].Border._visible = true;
					}
				}
			}
			var bBD:Boolean = false;
			var sdata:Slave;
			var gday:Number = coreGame.GetDayOfYear(dt);		// day of year
			for (var so:String in SMData.arUsableSlaves) {
				sdata = SMData.arUsableSlaves[so];
				if (gday == coreGame.GetDayOfYear(sdata.Birthday)) {
					bBD = true;
					break;
				}
			}
			if (bBD) arDiaryMovies[i].EntryGraphic._visible = true;
			arDiaryMovies[i].Birthday._visible = bBD;
			arDiaryMovies[i].dayindex = -1;
			arDiaryMovies[i].dayno = dt;
	
		}
		for (var i:Number = 0; i < arTrainingArray.length; i++) {
			if (arTrainingArray[i].LogDate >= nDiaryDate && arTrainingArray[i].LogDate < (nDiaryDate + 40)) {
				var mindex:Number = arTrainingArray[i].LogDate - nDiaryDate;
				arDiaryMovies[mindex].EntryGraphic._visible = true;
				arDiaryMovies[mindex].Tentacle._visible = arTrainingArray[i].Tentacle;
				switch(arTrainingArray[i].Winner) {
					case 1: arDiaryMovies[mindex].Medal1._visible = true; break;
					case 2: arDiaryMovies[mindex].Medal2._visible = true; break;
					case 3: arDiaryMovies[mindex].Medal3._visible = true; break;
				}
				if (arDiaryMovies[mindex].dayindex == -1) arDiaryMovies[mindex].dayindex = i;
				if (arTrainingArray[i].Flag == 2) {
					SetMovieColour(arDiaryMovies[mindex].Border, 255, 255, 0);
					arDiaryMovies[mindex].Border._visible = true;
				} else 	if (arTrainingArray[i].Flag == 1) {
					SetMovieColour(arDiaryMovies[mindex].Border, 0, 128, 0);
					arDiaryMovies[mindex].Border._visible = true;
				}
			}
		}
	}
	
	// next/previous mnth button actions
	public function NextMonth()
	{
		mcBase.EntryText.htmlText = "";
		nDiaryDate += 40;
		ShowDialogContents();
	}
	
	public function PreviousMonth() 
	{
		mcBase.EntryText.htmlText = "";
		nDiaryDate -= 40;
		if (nDiaryDate < 1) nDiaryDate = 1;
		ShowDialogContents();
	}
		
	// Shortcuts for the viewer
	public function Shortcuts(key:Number, keyAscii:Number, bControl:Boolean) : Boolean
	{
		switch(keyAscii) {
			case 88:
				LeaveDialog();
				return true;
			case 61:
			case 43:
				NextMonth();
				return true;
			case 45: 
				PreviousMonth();
				return true;
		}
		return false;
	}
}
