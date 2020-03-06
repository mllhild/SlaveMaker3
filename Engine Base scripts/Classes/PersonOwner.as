// PersonOwner - class defining the slaves owner
// Simiplified version of Person class

// Owner Id's
//	1999	- generic Owner for guildmembers
//	1001	- Male Owner
//	1002 	- Female Owner
//	1003	- Hermaphrodite Owner
//  3000	- yourself
//  < 1000	- a standard NPC, see person numbers
//  0		- freelancer slave maker, has not found an owner yet
// Translation status: COMPLETE

import Scripts.Classes.*;


class PersonOwner extends BaseModule {
	
	public var Id:Number;				// person/place number
	public var PersonName:String;	// their name
	public var PersonGender:Number;	// their gender
		
	// Constructor
	public function PersonOwner(slave:Object, cg:Object) { 
		super(null, slave, cg);
		PersonName = "";
		PersonGender = 2;
		Id = 0;
	}
	
	// load/save
	public function Load(lo:Object)
	{
		super.Load(lo);
		
		Id = lo.Id;
		PersonGender = lo.PersonGender;
		if (PersonGender == undefined) PersonGender = coreGame.People.GetPersonsGender(Id);
		PersonName = lo.PersonName;
		if (PersonName == undefined) PersonName = "";

	}
	public function Save(so:Object)
	{
		super.Save(so);
		
		so.Id = Id;
		so.PersonGender = PersonGender;
		so.PersonName = PersonName + "";
	}
	
	// Change the owner
	public function ChangeOwner(id:Number, gender:Number, pname:String) : Number
	{
		trace("ChangeOwner: " + id);
		if (id == undefined) return Id;
		Id = id;
		if (slaveData == _root || slaveData == coreGame.slaveData) {
			_root.SoldSlave = id;		//TODO remove
			coreGame.dspMain.UpdateSlaveVitals(slaveData);
		}
		if (gender != undefined) PersonGender = gender;
		else if (id < 1000) PersonGender = coreGame.currentCity.GetPersonsInstance(id).PersonGender;
		if (pname != undefined) PersonName = pname;
		else if (id < 1000) PersonName = coreGame.currentCity.GetPersonsInstance(id).PersonName;
	
		if (id == 3000) {
			PersonName = coreGame.SMData.SlaveMakerName;
			PersonGender = coreGame.Gender;
		}
		return Id;
	}
	
	// get various owner details
	function GetOwner() : Number { return Id; }
	
	function GetOwnerName() : String
	{ 
		if (PersonName != "") return PersonName;
		var str:String = coreGame.GetPersonsName(this.Id);
		if (str != "") return str;
		return coreGame.GetPersonsName(1999);
	}
	
	function IsPersonallyOwned() : Boolean { return GetOwner() == 3000; }
	function IsUnowned() : Boolean { return GetOwner() == 0; }
	function IsOwnedByAnother() : Boolean { return !IsPersonallyOwned() && !IsUnowned(); }
	
	// events on new day
	public function NewDay(NumDays:Number) { }
	
	function DoOwnerTest()
	{
		if ((!IsPersonallyOwned() && !IsUnowned()) && coreGame.OwnerTesting && coreGame.DoneEvent == 0 && ((coreGame.Elapsed % 7) == 0)) {
			Diary.AddEntry(Language.GetText("OwnerTesting", "Diary"), false, 0, true);
			DoEvent(9999);
			coreGame.AddTime(2);
			SetText("");
			if (coreGame.SlaveGirl.OwnerTestSpecial() == true) return;
			if (coreGame.XMLData.XMLEvent("OwnerTestSpecial", false)) return;
			
			var Score:Number;
			var genString:String;
			var genNumber:Number;
			
			temp = Math.floor(Math.random()*9)+1;
			if (temp == 1) {
				genString  = "beauty";
				Score = slaveData.VarCharisma * 2;
			} else if (temp == 2) {
				genString  = "sensibility";
				Score = slaveData.VarSensibility * 2;
			} else if (temp == 3) {
				genString  = "behaviour at court";
				Score = slaveData.VarRefinement*2;
			} else if (temp == 4) {
				genString  = "intelligence";
				Score = slaveData.VarIntelligence*2;
			} else if (temp == 5) {
				genString  = "morality";
				Score = slaveData.VarMorality*2;
			} else if (temp == 6) {
				genString  = "endurance";
				Score = slaveData.VarConstitution*2;
			} else if (temp == 7) {
				genString  = "talents as a maid";
				Score = slaveData.VarCooking + slaveData.VarCleaning;
			} else if (temp == 8) {
				genString  = "conversation";
				Score = slaveData.VarConversation*2;
			} else {
				genString  = "skills at sex";
				var temp2:Number = Math.floor(Math.random()*5)+1;
				temp += temp2;
				if (temp2 == 1) {
					Score = slaveData.VarFuck * 2;
				} else if (temp2 == 2) {
					Score = slaveData.VarBlowJob * 2;
				} else if (temp2 == 3) {
	
					if (coreGame.TestObedience(20)) {
						Score = slaveData.VarFuck * 2;
					} else {
						Score = slaveData.VarFuck;
					}
				} else if (temp2 == 4) {
					if (coreGame.TestObedience(30)) {
						Score = slaveData.VarFuck * 2;
					} else {
						Score = slaveData.VarFuck;
					}
				} else if (temp2 == 5) {
					if (coreGame.TestObedience(50)) {
						Score = slaveData.VarFuck * 2;
					} else {
						Score = slaveData.VarFuck;
					}
				} else if (temp2 == 6) {
					if (coreGame.TestObedience(60)) {
						Score = slaveData.VarFuck * 2;
					} else {
						Score = slaveData.VarFuck;
					}
				}  
			}
			
			coreGame.ShowDress();
			Score = Math.ceil(Score) + 2 - coreGame.Difficulty;
			coreGame.PersonGender = PersonGender;
			coreGame.PersonName = GetOwnerName();
			coreGame.GetPersonGenderText(PersonGender);
			coreGame.Score = Score;
			coreGame.genString = genString;
			coreGame.genNumber = temp;
			if (coreGame.SlaveGirl.OwnerTest(genString, Score) != true) coreGame.XMLData.XMLEvent("OwnerTest", false);
			else Money(Score);
		}
	}
	
	function OfferToBuy(place:Number)
	{
		coreGame.NumEvent = 2;
		if (!coreGame.modulesList.EventBuyer()) {
			var gnd:Number;
			if (IsDickgirlEvent()) gnd = 3;
			else gnd = slrandom(2);
			if (SMData.sLesbianTrainer >= 1) {
				if (Math.floor(Math.random()*2) == 0) gnd = 2;
			}
			coreGame.NumEvent = 2 + (gnd / 10);
			if (Language.bSpeaking) Language.ServantSpeakEnd();
			PlaySound("Sounds/Knocking.mp3");
			coreGame.Pay = Math.ceil(slaveData.VarCharisma) * 10;
			AddText("There is a knock at the door and the visitor is ");
			if (gnd == 3) AddText("a hermaphrodite");
			else if (gnd == 2) AddText("a woman");
			else if (gnd == 1) AddText("a man");
			AddText(" who has seen #slave and wants to buy #slavehimher, and offers you #pay GP.");
			if (GetOwner() != 0 && GetOwner() != 3000) AddText("\r\rIf you accept, you could have some problems with #slavehisher current ");
			PersonSpeakEnd();
			AddText("\r\rDo you choose to sell #slavehimher?");
			switch(gnd) {
				case 1: temp = slrandom(5); break;
				case 2: temp = slrandom(7); break;
				case 3: temp = coreGame.DickgirlTesticles ? slrandom(4) + 2 : slrandom(2); break;
			}
			coreGame.People.ShowPerson(1000 + gnd, 1, 1, temp);
		}
		DoYesNoEvent(coreGame.NumEvent);
	}  
	
	function SellSlave(evno:Number)
	{
		SMMoney(slaveData.VarCharisma * 10);
		coreGame.HideImages();
		HideBackgrounds();
		coreGame.genNumber = coreGame.TrainingTime - coreGame.Elapsed;
		if (coreGame.genNumber < 8) coreGame.genNumber = 8;
		
		SetText("The new owner says that they will require #slave to be delivered in #general days, and asks that you please finalise #slavehisher training before then.");
		if (GetOwner() != 0 && GetOwner() != 3000) {
			SMData.BitFlagSM.SetBitFlag(21);
			AddText("\r\rYou have illegally sold #slave, hopefully the original owner will not be able to do anything.")
		} else AddText("\r\rYou have sold #slave, and now have an owner for #slavehimher.");
		
		ChangeOwner(1001 + Math.round(10 * (evno - 2 + 0.05)));
		coreGame.PersonName = GetOwnerName();
		Diary.AddEntry(Language.GetText("SoldSlave", "Diary"), false, 0, true);
		coreGame.OwnerTesting = true;
	}

	
}