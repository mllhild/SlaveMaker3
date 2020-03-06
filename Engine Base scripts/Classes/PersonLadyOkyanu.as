// PersonLadyOkyanu - Lady Okyanu the Courtesan
// number 4
// lend modifier 0
// Translation status: COMPLETE

import Scripts.Classes.*;


class PersonLadyOkyanu extends Person {
		
	public function PersonLadyOkyanu(cg:Object, cc:Object) { 
		super("HighClassProstitute", cg, 4, 0, true, cc);
	}

	
	// Images
	
	public function ShowThem(placeo, align:Number, gframe:Number, delay:Number) : Boolean
	{
		var place:String = String(placeo).toLowerCase();
		if (place == "visit") {
			Backgrounds.ShowBedRoom(16);
			return super.ShowThem(1, 1, 1);
		} else if (place == "lend") {
			Backgrounds.ShowBedRoom(16);
			return super.ShowThem(0, 1, 1);
		} 
		return super.ShowThem(placeo, align, gframe, delay);
	}
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(true, false, undefined, undefined, false);
		ResetOtherFlags();
	}
	
	public function NewDay(nDays:Number)
	{
		super.NewDay(nDays);
		
		CustomFlag -= nDays;
	}

	
	// Lending
	
	public function CanBeLoanedTo() : Boolean
	{	
		return ((coreGame.Home.HouseType == 5 || coreGame.VarRefinementRounded >= 25)  && super.CanBeLoanedTo());
	}

	
	public function LoanTo() : Boolean
	{
		if (coreGame.SlaveGirl.DoLendHighClassProstitute() == true) return true;
		
		coreGame.ResetNotFucked();
		if (coreGame.SlaveGirl.ShowActLend(4) == false) {
			coreGame.UseGeneric = true;
			// obsolete versions
			coreGame.SlaveGirl.ShowActLendHer();
			coreGame.SlaveGirl.ShowSexActLendHer();
			coreGame.ShowActImage();
		}
		if (coreGame.AppendActText) {
			Language.XMLGeneral("Visits/LendHighClassProstitute/NormalLend");
			//AddText("Lady Okyanu has #slave assist her to attend to her companion for the time. She has #slave do some of the more 'unusual' requests.");
		}
		
		if (coreGame.LesbianTraining) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		if (IsDayTime()) Points(0, -5, 0, 0, -5, 3, 0, 0, 0, 3, 3, -5, 20, 17, -7, 0, 6, 0, -5, 0);
		else Points(0, -3, 0, 0, -3, 2, 0, 0, 0, 2, 2, -3, 13, 11, -5, 0, 4, 0, -3, 0);

		return true;
	}


}