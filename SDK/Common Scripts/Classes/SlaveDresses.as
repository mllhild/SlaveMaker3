// SlaveDresses - class defining slaves dresses
// NOTE: limited use
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class SlaveDresses extends DressCommon {	
	
	// Methods
	
	// Constructor
	public function SlaveDresses(cg:Object) { 
		super(cg);
	}
	
	public function ResetDresses()
	{
		super.ResetDresses();
		SetDressDetails(0, coreGame.Language.GetHtml("PlainDress", "Equipment"), coreGame.Language.GetHtml("PlainDress", "Equipment") + "\r\r" + coreGame.Language.GetHtml("NoEffects", "Equipment"), true, 0);
		SetDressOwned(0);
		SetDressDetails(1, "", coreGame.StatisticsGroup.Refinement.StatLabel.text + " + 5", true, 100);
		SetDressDetails(2, "", coreGame.StatisticsGroup.Charisma.StatLabel.text + " + 10", true, 150);
		SetDressDetails(3, "", coreGame.StatisticsGroup.Refinement.StatLabel.text + " + 10\r" + coreGame.StatisticsGroup.Sensibility.StatLabel.text + " + 5", true, 300);
		SetDressDetails(4, "", coreGame.StatisticsGroup.Refinement.StatLabel.text + " + 10\r" + coreGame.StatisticsGroup.Charisma.StatLabel.text + " + 10\r" + coreGame.StatisticsGroup.Sensibility.StatLabel.text + " + 10", true, 500);
		SetDressDetails(5, "", "", true, 700);
		SetDressDetails(6, "","", true, 4000);
	}
	
	// Load/Save data	
	public function LoadDresses(lo:Object)
	{
		var len:Number = lo.arDresses.length;
		if (len == undefined) len = 0;
		if (len != 0) {
			arDresses = new Array();
			for (var j:Number = 0; j < len; j++) {
				var dob:DressSlave = new DressSlave(coreGame);
				dob.Load(lo.arDresses[j]);
				arDresses.push(dob);
			}
		}
	}
		
	public function SaveDresses(so:Object)
	{
		var len:Number = arDresses.length;
		if (len == undefined) len = 0;
		if (len != 0) {
			so.arDresses = new Array();
			for (var j:Number = 0; j < len; j++) {
				var dob:Object = new Object();
				var ds:DressSlave = arDresses[j];
				ds.Save(dob);
				so.arDresses.push(dob);
			}
		}
	}


	// find the selected dress in the list of dresses arDresses
	// if it is not found then create the dress, else return the class instance.
	public function GetDress(dress:Number) : Dress {
		dress = Math.abs(dress);
		if (dress > 6) dress = 6;

		if (arDresses == null) {
			arDresses = new Array();
			for (var i:Number = 0; i < 7; i++) {
				arDresses.push(new DressSlave(coreGame));
			}
		}
		if (dress > arDresses.length) return null;
		return arDresses[dress];
	}
	
}