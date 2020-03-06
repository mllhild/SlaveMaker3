// DressCommon - class defining common dress information, inherited by slaves and slave makers
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class DressCommon {
	
	private var coreGame:Object;		// core game engine (_root for actionscript 2)

	public var arDresses:Array;			// dresses for the slave/slavemaker, instances of DressSlave/DressSlaveMaker
	
	public var DressWorn:Number;		// dress number currently worn
	public var DressToWear:Number;		// dress to wear after being naked (SAVED)
	public var NakedChoice:Number;		// when naked the image number/frame to show
	public var DressSwap:Number;		// temporary variable (not saved) for when they swap to a dress briefly
	
	// sell/own a set of Lingerie
	public var SellLingerie:Number;		// 1 = sold, 0 = not sold
	public var LingerieOK:Number;		// 1 = owned, 0 = nor owned
	
	// sell/own a bunny suit
	public var SellBunnySuit:Number;	// 1 = sold, 0 = not sold
	public var BunnySuitOK:Number;		// 1 = owned, 0 = nor owned
	
	// sell/own a maid uniform
	public var SellMaidUniform:Number;	// 1 = sold, 0 = not sold
	public var MaidUniformOK:Number;	// 1 = owned, 0 = nor owned
	
	// sell/own a swimsuit
	public var SellSwimsuit:Number;		// 1 = sold, 0 = not sold
	public var SwimsuitOK:Number;		// 1 = owned, 0 = nor owned

	// sell/own a custom uniform 1
	public var SellCustomUniform1:Number;		// 1 = sold, 0 = not sold
	public var CustomUniform1OK:Number;		// 1 = owned, 0 = nor owned
	public var CustomUniform1Name:String;		// name of the item

	// sell/own a custom uniform 2
	public var SellCustomUniform2:Number;		// 1 = sold, 0 = not sold
	public var CustomUniform2OK:Number;		// 1 = owned, 0 = nor owned
	public var CustomUniform2Name:String;		// name of the item

	
	// Methods
	
	// Constructor
	public function DressCommon(cg:Object) { 
		this.coreGame = cg;
		
		this.arDresses = null;
		
		ResetDresses();
	}

	public function Reset()
	{
		ResetDresses();
	}
	
	public function ResetDresses()
	{
		if (arDresses != null) {
			delete arDresses;
			arDresses = null;
		}
		this.DressWorn = 0;
		this.DressToWear = 0;
		this.NakedChoice = 0;
		this.DressSwap = -1000;
		
		this.LingerieOK = 0;
		this.BunnySuitOK = 0;
		this.MaidUniformOK = 0;
		this.SwimsuitOK = 0;
		this.SellBunnySuit = 1;
		this.SellLingerie = 1;
		this.SellMaidUniform = 1;
		this.SellSwimsuit = 1;
		
		// sell/own a custom
		SellCustomUniform1 = 0;
		CustomUniform1OK = 0;
		CustomUniform1Name = "";
		SellCustomUniform2 = 0;
		CustomUniform2OK = 0;
		CustomUniform2Name = "";		

	}
	
	// Load/Save
	public function Load(so:Object)
	{	
		BunnySuitOK = so.BunnySuitOK;
		LingerieOK = so.LingerieOK;
		MaidUniformOK = so.MaidUniformOK;
		SwimsuitOK = so.SwimsuitOK;
		SellBunnySuit = so.SellBunnySuit;
		SellLingerie = so.SellLingerie;
		SellMaidUniform = so.SellMaidUniform;
		SellSwimsuit = so.SellSwimsuit;
		if (BunnySuitOK == undefined) {
			BunnySuitOK = 0;
			LingerieOK = 0;
			MaidUniformOK = 0;
			SwimsuitOK = 0;
			SellBunnySuit = 1;
			SellLingerie = 1;
			SellMaidUniform = 1;
			SellSwimsuit = 1;
		}
		if (so.DressWorn == undefined) {
			DressWorn = 0;
			NakedChoice = 0;
			DressToWear = 0;
		} else {
			DressWorn = so.DressWorn;
			NakedChoice = so.NakedChoice;
			DressToWear = so.DressToWear;
		}
		if (this.DressToWear == undefined) this.DressToWear = 0;
		
		if (so.SellCustomUniform1 != undefined) {
			SellCustomUniform1 = so.SellCustomUniform1;
			CustomUniform1OK = so.CustomUniform1OK;
			CustomUniform1Name = so.CustomUniform1Name;
		} else {
			SellCustomUniform1 = 0;
			CustomUniform1OK = 0;
			CustomUniform1Name = "";			
		}
		if (so.SellCustomUniform2 != undefined) {
			SellCustomUniform2 = so.SellCustomUniform2;
			CustomUniform2OK = so.CustomUniform2OK;
			CustomUniform2Name = so.CustomUniform2Name;
		} else {
			SellCustomUniform2 = 0;
			CustomUniform2OK = 0;
			CustomUniform2Name = "";			
		}		

	}

	public function Save(so:Object)
	{
		so.DressWorn = DressWorn;
		so.NakedChoice = NakedChoice;
		so.DressToWear = DressToWear;
		
		so.BunnySuitOK = BunnySuitOK;
		so.LingerieOK = LingerieOK;
		so.MaidUniformOK = MaidUniformOK;
		so.SwimsuitOK = SwimsuitOK;
		so.SellBunnySuit = SellBunnySuit;
		so.SellLingerie = SellLingerie;
		so.SellMaidUniform = SellMaidUniform;
		so.SellSwimsuit = SellSwimsuit;
		
		so.SellCustomUniform1 = SellCustomUniform1;
		so.CustomUniform1OK = CustomUniform1OK;
		so.CustomUniform1Name = CustomUniform1Name;
		so.SellCustomUniform2 = SellCustomUniform2;
		so.CustomUniform2OK = CustomUniform2OK;
		so.CustomUniform2Name = CustomUniform2Name;

	}
	
	public function WearDress(dress:Number) {
		DressWorn = dress;
	}
	
	public function SwapDress(dress:Number)
	{
		if (dress == undefined) {
			if (DressSwap != -1000) {
				WearDress(DressSwap);
				DressSwap = -1000;
			}
		} else { 
			DressSwap = DressWorn;
			WearDress(dress);
		}
	}
	
	public function ChoiceNaked(range:Number, offset:Number) : Number
	{
		if (NakedChoice != 0) return NakedChoice;
		var itemp:Number = range;
		if (itemp != 0) itemp = Math.floor(Math.random()*itemp);
		NakedChoice = itemp + offset;
		return NakedChoice;
	}
	
	// Find the selected dress in the list of dresses, arDresses
	// if it is not found return null, else return the class instance
	public function GetDressRO(dress:Number) : Dress
	{
		if (arDresses == null) return null;
		dress = Math.abs(dress);
		if (dress > 6) dress = 6;
		if (dress > arDresses.length) return null;
		return arDresses[dress];
	}
	// find the selected dress in the list of dresses arDresses
	// if it is not found then create the dress, else return the class instance.
	// to be overloaded in any inherited class
	//public function GetDress(dress:Number) : Dress { return null; }	
	public function GetDress(dress:Number) : Dress { return null; }
	
	// Set the dress information
	// Create the dress it not present, else update.
	// any parameters set to undefined will not be changed/set
	public function SetDressDetails(dress:Number, short:String, desc:String, forsale:Boolean, price:Number)
	{
		if (isNaN(dress)) return;
		dress = Math.abs(dress);
		if (dress > 6) dress = 6;
		
		var ds:Dress = GetDress(dress);
		if (forsale != undefined) ds.SetDressForSale(forsale);
		if (desc != undefined) ds.strDescription = desc;
		if (short != undefined) ds.strName = short;
		if (price != undefined) ds.nPrice = price;
	}
	
	public function SetDressStats(dress:Number, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Joy:Number, Special:Number, Special2:Number)
	{
		var ds:Dress = GetDress(dress);
		ds.SetDressStats(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Reputation, Joy, Special, Special2)
	}
		
	public function SetDressStatsByArray(dress:Number, se:Array)
	{
		var ds:Dress = GetDress(dress);
		ds.SetDressStatsByArray(se);
	}
	
	// Dress Attributes
	
	public function IsDressWorn(dress:Number) : Boolean { return DressWorn == dress; }
	
	// is the dress easy to move in
	public function IsDressEasy(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressEasy();
	}
	public function SetDressEasy(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressEasy();
	}
	
	// is it a court dress
	public function IsDressCourtly(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressCourtly();
	}
	public function SetDressCourtly(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressCourtly();
	}
	
	// is it a swimsuit
	public function IsDressSwimsuit(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressSwimsuit();
	}
	public function SetDressSwimsuit(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressSwimsuit();
	}
	
	// is it appropriate for the Sleazy Bar
	public function IsDressSleazyBar(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressSleazyBar();
	}
	public function SetDressSleazyBar(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressSleazyBar();
	}
	
	// Does it make the wearer feel like a slut
	public function IsDressSlutty(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressSlutty();
	}
	public function SetDressSlutty(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressSlutty();
	}
	
	// Is the dress designed for dancing
	public function IsDressDancing(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressDancing();
	}
	public function SetDressDancing(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressDancing();
	}
	
	// Is the dress a version of a maid uniform
	public function IsDressMaid(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressMaid();
	}
	public function SetDressMaid(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressMaid();
	}
	
	// If the dress basically a type of lingerie
	public function IsDressLingerie(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressLingerie();
	}
	public function SetDressLingerie(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressLingerie();
	}
	
	// Does the dress have a set of catgirl ears fitted
	public function IsDressCatEars(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressCatEars();
	}
	public function SetDressCatEars(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressCatEars();
	}
	
	// Does the dress have a cat tail fitted
	public function IsDressCatTail(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressCatTail();
	}
	public function SetDressCatTail(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressCatTail();
	}
	
	// Is the dress a form of a miko/acolytes robes
	public function IsDressMiko(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressMiko();
	}
	public function SetDressMiko(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressMiko();
	}
	
	// Is the dress appropriate for a waitress/waiter
	public function IsDressWaitress(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressWaitress();
	}
	public function SetDressWaitress(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressWaitress();
	}
	
	// Is the dress blessed by the gods
	public function IsDressHoly(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressHoly();
	}
	public function SetDressHoly(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressHoly();
	}
	
	// Is the dress blessed/cursed by demonic forces
	public function IsDressDemonic(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressDemonic();
	}
	public function SetDressDemonic(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressDemonic();
	}
	
	// Does the dress have a set of puppygirl ears fitted
	public function IsDressPuppyEars(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressPuppyEars();
	}
	public function SetDressPuppyEars(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressPuppyEars();
	}
	
	// Does the dress have a puppy tail fitted
	public function IsDressPuppyTail(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return false;
		return this.GetDressRO(dress).IsDressPuppyTail();
	}
	public function SetDressPuppyTail(dress:Number)
	{
		if (dress == undefined) dress = DressWorn;
		this.GetDress(dress).SetDressPuppyTail();
	}

		
	// get the dress name, also allow for named dresses
	public function GetDressName(dress:Number) : String
	{
		if (dress == undefined) dress = DressWorn;
		if (dress < 0) return coreGame.Language.Gethtml("Naked", coreGame.actNode);
		var ds:Dress = this.GetDressRO(dress);
		if (ds != null) return ds.strName;
		return "";
	}
	
	// total dresses owned, excludes the plain dress 0
	public function GetTotalDresses() : Number
	{
		var tot:Number = 0;
		if (IsDressOwned(1)) tot++;
		if (IsDressOwned(2)) tot++;
		if (IsDressOwned(3)) tot++;
		if (IsDressOwned(4)) tot++;
		if (IsDressOwned(5)) tot++;
		if (IsDressOwned(6)) tot++;
		return tot;
	}
	
	// is the dress owned
	public function IsDressOwned(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress == -1 || dress == -10) return true;
		var ds:Dress = this.GetDressRO(dress);
		if (ds == null) return false;
		return ds.IsDressOwned();
	}
	public function SetDressOwned(dress:Number, own:Boolean)
	{
		if (own == undefined) own = true;
		var ds:Dress = this.GetDressRO(dress);
		if (ds != null) ds.SetDressOwned(own);
	}
	
	// is the dress for sale
	public function IsDressForSale(dress:Number) : Boolean
	{
		if (dress == undefined) dress = DressWorn;
		if (dress == -1 || dress == -10) return true;
		var ds:Dress = this.GetDressRO(dress);
		if (ds == null) return false;
		return ds.IsDressForSale();
	}
	public function SetDressForSale(dress:Number, sold:Boolean)
	{
		if (sold == undefined) sold = true;
		var ds:Dress = this.GetDressRO(dress);
		if (ds != null) ds.SetDressForSale(sold);
	}
	
	
	// Is any dress of the selected type owned
	// if so return the dress number, return -1 if no such dress owned
	public function IsDressSwimsuitOwned() : Number
	{
		if (IsDressOwned(6) && IsDressSwimsuit(6)) return 6;
		if (IsDressOwned(5) && IsDressSwimsuit(5)) return 5;
		if (IsDressOwned(4) && IsDressSwimsuit(4)) return 4;
		if (IsDressOwned(3) && IsDressSwimsuit(3)) return 3;
		if (IsDressOwned(2) && IsDressSwimsuit(2)) return 2;
		if (IsDressOwned(1) && IsDressSwimsuit(1)) return 1;
		if (IsDressOwned(0) && IsDressSwimsuit(0)) return 0;
		return -1;
	}
	
	public function IsDressCourtlyOwned() : Number
	{
		if (IsDressOwned(6) && IsDressCourtly(6)) return 6;
		if (IsDressOwned(5) && IsDressCourtly(5)) return 5;
		if (IsDressOwned(4) && IsDressCourtly(4)) return 4;
		if (IsDressOwned(3) && IsDressCourtly(3)) return 3;
		if (IsDressOwned(2) && IsDressCourtly(2)) return 2;
		if (IsDressOwned(1) && IsDressCourtly(1)) return 1;
		if (IsDressOwned(0) && IsDressCourtly(0)) return 0;
		return -1;
	}
	
	public function IsDressMaidOwned() : Number
	{
		if (IsDressOwned(6) && IsDressMaid(6)) return 6;
		if (IsDressOwned(5) && IsDressMaid(5)) return 5;
		if (IsDressOwned(4) && IsDressMaid(4)) return 4;
		if (IsDressOwned(3) && IsDressMaid(3)) return 3;
		if (IsDressOwned(2) && IsDressMaid(2)) return 2;
		if (IsDressOwned(1) && IsDressMaid(1)) return 1;
		if (IsDressOwned(0) && IsDressMaid(0)) return 0;
		return -1;
	}
	
	public function IsDressLingerieOwned() : Number
	{
		if (IsDressOwned(6) && IsDressLingerie(6)) return 6;
		if (IsDressOwned(5) && IsDressLingerie(5)) return 5;
		if (IsDressOwned(4) && IsDressLingerie(4)) return 4;
		if (IsDressOwned(3) && IsDressLingerie(3)) return 3;
		if (IsDressOwned(2) && IsDressLingerie(2)) return 2;
		if (IsDressOwned(1) && IsDressLingerie(1)) return 1;
		if (IsDressOwned(0) && IsDressLingerie(0)) return 0;
		return -1;
	}
	
	public function IsDressSleazyBarOwned() : Number
	{
		if (IsDressOwned(6) && IsDressSleazyBar(6)) return 6;
		if (IsDressOwned(5) && IsDressSleazyBar(5)) return 5;
		if (IsDressOwned(4) && IsDressSleazyBar(4)) return 4;
		if (IsDressOwned(3) && IsDressSleazyBar(3)) return 3;
		if (IsDressOwned(2) && IsDressSleazyBar(2)) return 2;
		if (IsDressOwned(1) && IsDressSleazyBar(1)) return 1;
		if (IsDressOwned(0) && IsDressSleazyBar(0)) return 0;
		return -1;
	}
	
	public function IsDressDancingOwned() : Number
	{
		if (IsDressOwned(6) && IsDressDancing(6)) return 6;
		if (IsDressOwned(5) && IsDressDancing(5)) return 5;
		if (IsDressOwned(4) && IsDressDancing(4)) return 4;
		if (IsDressOwned(3) && IsDressDancing(3)) return 3;
		if (IsDressOwned(2) && IsDressDancing(2)) return 2;
		if (IsDressOwned(1) && IsDressDancing(1)) return 1;
		if (IsDressOwned(0) && IsDressDancing(0)) return 0;
		return -1;
	}
	
	
	public function IsDressEasyOwned() : Number
	{
		if (IsDressOwned(6) && IsDressEasy(6)) return 6;
		if (IsDressOwned(5) && IsDressEasy(5)) return 5;
		if (IsDressOwned(4) && IsDressEasy(4)) return 4;
		if (IsDressOwned(3) && IsDressEasy(3)) return 3;
		if (IsDressOwned(2) && IsDressEasy(2)) return 2;
		if (IsDressOwned(1) && IsDressEasy(1)) return 1;
		if (IsDressOwned(0) && IsDressEasy(0)) return 0;
		return -1;
	}
	
	
	public function IsDressSluttyOwned() : Number
	{
		if (IsDressOwned(6) && IsDressSlutty(6)) return 6;
		if (IsDressOwned(5) && IsDressSlutty(5)) return 5;
		if (IsDressOwned(4) && IsDressSlutty(4)) return 4;
		if (IsDressOwned(3) && IsDressSlutty(3)) return 3;
		if (IsDressOwned(2) && IsDressSlutty(2)) return 2;
		if (IsDressOwned(1) && IsDressSlutty(1)) return 1;
		if (IsDressOwned(0) && IsDressSlutty(0)) return 0;
		return -1;
	}
	
	public function IsDressCatEarsOwned() : Number
	{
		if (IsDressOwned(6) && IsDressCatEars(6)) return 6;
		if (IsDressOwned(5) && IsDressCatEars(5)) return 5;
		if (IsDressOwned(4) && IsDressCatEars(4)) return 4;
		if (IsDressOwned(3) && IsDressCatEars(3)) return 3;
		if (IsDressOwned(2) && IsDressCatEars(2)) return 2;
		if (IsDressOwned(1) && IsDressCatEars(1)) return 1;
		if (IsDressOwned(0) && IsDressCatEars(0)) return 0;
		return -1;
	}
	
	public function IsDressCatTailOwned() : Number
	{
		if (IsDressOwned(6) && IsDressCatTail(6)) return 6;
		if (IsDressOwned(5) && IsDressCatTail(5)) return 5;
		if (IsDressOwned(4) && IsDressCatTail(4)) return 4;
		if (IsDressOwned(3) && IsDressCatTail(3)) return 3;
		if (IsDressOwned(2) && IsDressCatTail(2)) return 2;
		if (IsDressOwned(1) && IsDressCatTail(1)) return 1;
		if (IsDressOwned(0) && IsDressCatTail(0)) return 0;
		return -1;
	}
	
	public function IsDressMikoOwned() : Number
	{
		if (IsDressOwned(6) && IsDressMiko(6)) return 6;
		if (IsDressOwned(5) && IsDressMiko(5)) return 5;
		if (IsDressOwned(4) && IsDressMiko(4)) return 4;
		if (IsDressOwned(3) && IsDressMiko(3)) return 3;
		if (IsDressOwned(2) && IsDressMiko(2)) return 2;
		if (IsDressOwned(1) && IsDressMiko(1)) return 1;
		if (IsDressOwned(0) && IsDressMiko(0)) return 0;
		return -1;
	}
	
	public function IsDressWaitressOwned() : Number
	{
		if (IsDressOwned(6) && IsDressWaitress(6)) return 6;
		if (IsDressOwned(5) && IsDressWaitress(5)) return 5;
		if (IsDressOwned(4) && IsDressWaitress(4)) return 4;
		if (IsDressOwned(3) && IsDressWaitress(3)) return 3;
		if (IsDressOwned(2) && IsDressWaitress(2)) return 2;
		if (IsDressOwned(1) && IsDressWaitress(1)) return 1;
		if (IsDressOwned(0) && IsDressWaitress(0)) return 0;
		return -1;
	}
	
	public function IsDressHolyOwned() : Number
	{
		if (IsDressOwned(6) && IsDressHoly(6)) return 6;
		if (IsDressOwned(5) && IsDressHoly(5)) return 5;
		if (IsDressOwned(4) && IsDressHoly(4)) return 4;
		if (IsDressOwned(3) && IsDressHoly(3)) return 3;
		if (IsDressOwned(2) && IsDressHoly(2)) return 2;
		if (IsDressOwned(1) && IsDressHoly(1)) return 1;
		if (IsDressOwned(0) && IsDressHoly(0)) return 0;
		return -1;
	}
	
	public function IsDressDemonicOwned() : Number
	{
		if (IsDressOwned(6) && IsDressDemonic(6)) return 6;
		if (IsDressOwned(5) && IsDressDemonic(5)) return 5;
		if (IsDressOwned(4) && IsDressDemonic(4)) return 4;
		if (IsDressOwned(3) && IsDressDemonic(3)) return 3;
		if (IsDressOwned(2) && IsDressDemonic(2)) return 2;
		if (IsDressOwned(1) && IsDressDemonic(1)) return 1;
		if (IsDressOwned(0) && IsDressDemonic(0)) return 0;
		return -1;
	}

	public function IsDressPuppyEarsOwned() : Number
	{
		if (IsDressOwned(6) && IsDressPuppyEars(6)) return 6;
		if (IsDressOwned(5) && IsDressPuppyEars(5)) return 5;
		if (IsDressOwned(4) && IsDressPuppyEars(4)) return 4;
		if (IsDressOwned(3) && IsDressPuppyEars(3)) return 3;
		if (IsDressOwned(2) && IsDressPuppyEars(2)) return 2;
		if (IsDressOwned(1) && IsDressPuppyEars(1)) return 1;
		if (IsDressOwned(0) && IsDressPuppyEars(0)) return 0;
		return -1;
	}
	
	public function IsDressPuppyTailOwned() : Number
	{
		if (IsDressOwned(6) && IsDressPuppyTail(6)) return 6;
		if (IsDressOwned(5) && IsDressPuppyTail(5)) return 5;
		if (IsDressOwned(4) && IsDressPuppyTail(4)) return 4;
		if (IsDressOwned(3) && IsDressPuppyTail(3)) return 3;
		if (IsDressOwned(2) && IsDressPuppyTail(2)) return 2;
		if (IsDressOwned(1) && IsDressPuppyTail(1)) return 1;
		if (IsDressOwned(0) && IsDressPuppyTail(0)) return 0;
		return -1;
	}

	private var lastdesc:String;
	private var nDcnt:Number;
	
	private function AddDesc(desc:String, cdesc:String) : String
	{
		if (lastdesc != "") {
			if (nDcnt == 1) cdesc += lastdesc;
			else cdesc += ", " + lastdesc;
		}
		lastdesc = desc;
		nDcnt++;
		return cdesc;
	}

	public function DescribeDress(dress:Number) : String
	{
		var ds:Dress = GetDressRO(dress);
		if (ds.IsDressSpecial()) {
			var cdesc:String = "This dress is ";
			nDcnt = 0;
			lastdesc = "";
			if (ds.IsDressCourtly()) cdesc = AddDesc("courtly", cdesc);
			if (ds.IsDressEasy()) cdesc = AddDesc("easy to move in", cdesc);
			if (ds.IsDressSwimsuit()) cdesc = AddDesc("a swimsuit", cdesc);
			if (ds.IsDressSleazyBar()) cdesc = AddDesc("a Sleazy Bar costume", cdesc);
			if (ds.IsDressSlutty()) cdesc = AddDesc("slutty", cdesc);
			if (ds.IsDressDancing()) cdesc = AddDesc("a dance dress", cdesc);
			if (ds.IsDressMaid()) cdesc = AddDesc("a maids uniform", cdesc);
			if (ds.IsDressWaitress()) cdesc = AddDesc("a waiter/waitresses uniform", cdesc);
			if (ds.IsDressLingerie()) cdesc = AddDesc("lingerie", cdesc);	
			if (ds.IsDressMiko()) cdesc = AddDesc("an acolyte's robe", cdesc);	
			if (ds.IsDressHoly()) cdesc = AddDesc("blessed by the gods", cdesc);
			if (ds.IsDressDemonic()) cdesc = AddDesc("imbued with demonic power", cdesc);
			if (ds.IsDressCatEars() && ds.IsDressCatTail()) cdesc = AddDesc("fitted with cat ears and a tail", cdesc);
			else if (ds.IsDressCatEars()) cdesc = AddDesc("fitted with cat ears", cdesc);
			else if (ds.IsDressCatTail()) cdesc = AddDesc("fitted with a cat tail", cdesc); 
			if (ds.IsDressPuppyEars() && ds.IsDressPuppyTail()) cdesc = AddDesc("fitted with puppy ears and a tail", cdesc);
			else if (ds.IsDressPuppyEars()) cdesc = AddDesc("fitted with puppy ears", cdesc);
			else if (ds.IsDressPuppyTail()) cdesc = AddDesc("fitted with a puppy tail", cdesc); 
			if (nDcnt > 1 && lastdesc != "") cdesc += " and ";
			return cdesc + lastdesc + ".";
		}
		return "";
	}
	
	// Custom
	public function SetCustomUniform(num:Number, str:String)
	{
		if (num == 1 || num == undefined) {
			SellCustomUniform1 = 1;
			CustomUniform1Name = str;			
		} else {
			SellCustomUniform2 = 1;
			CustomUniform2Name = str;
		}
	}
	public function SellCustomUniform(num:Number, sell:Number)
	{
		if (sell == undefined) sell = 1;
		if (num == 1 || num == undefined) SellCustomUniform1 = sell;
		else SellCustomUniform2 = sell;
	}
	
	
	// Get details
	// return Objevt with members
	// dss
	// dname
	// owned
	// sell
	// price
	// desc
	public function GetUniformDetails(no, sdo) : Object
	{
		var dressno:Number = 0;
		if (typeof(no) == "number") dressno = Math.abs(Number(no));
		else {
			switch (String(no).toLowerCase().split(" ").join("")) {
				case "bunnysuit": dressno = 7; break;
				case "lingerie": dressno = 8; break;
				case "maiduniform":
				case "maid":
					dressno = 9; break;
				case "swimsuit": dressno = 10; break;
				case "customuniform1":
				case "custom1":
					dressno = 11; break;
				case "customuniform2": 
				case "custom2":
					dressno = 12; break;
			}
		}
		if (dressno == 0) return null;
		
		var obj:Object = new Object();
		obj.owned = false;
		var dss:String = "";

		switch (dressno) {
			case 7: dss = "BunnySuit"; obj.owned = BunnySuitOK; obj.sell = SellBunnySuit; break;
			case 8: dss = "Lingerie"; obj.owned = LingerieOK; obj.sell = SellLingerie; break;
			case 9: dss = "MaidUniform"; obj.owned = MaidUniformOK; obj.sell = SellMaidUniform; break;
			case 10: dss = "Swimsuit"; obj.owned = SwimsuitOK; obj.sell = SellSwimsuit; break;
			case 11: dss = "CustomUniform1"; obj.owned = CustomUniform1OK; obj.sell = SellCustomUniform1; break;
			case 12: dss = "CustomUniform2"; obj.owned = CustomUniform2OK; obj.sell = SellCustomUniform2; break;
		}
		obj.dss = dss;
		obj.dname = "";
		if (dressno > 10) obj.dname = this[dss + "Name"];
		if (obj.dname == "") {
			obj.dname = coreGame.Language.GetHtml("Name", "Slave/Dresses/" + dss);
			if (obj.dname == "") obj.dname = coreGame.Language.GetHtml(dss, "Equipment");
		}
		obj.desc = "";
		if (!coreGame.IsFemale()) {
			obj.desc = coreGame.Language.GetHtml("MaleDescription", "Slave/Dresses/" + dss);
			if (obj.desc == "") obj.desc = coreGame.Language.GetHtml(dss + "MaleDescription", "Equipment");
		}
		if (obj.desc == "") obj.desc = coreGame.Language.GetHtml("Description", "Slave/Dresses/" + dss);
		if (obj.desc == "") obj.desc = coreGame.Language.GetHtml(dss + "Description", "Equipment");
	
		obj.price = 0;
		obj.price = coreGame.XMLData.GetXMLValue("Price", "Slave/Dresses/" + dss);
		if (obj.price == 0) obj.price = coreGame.XMLData.GetXMLValue(dss + "Price", "Equipment");
		
		return obj;
	}
		
	
	// random numbers
	// 1 to rnd
	private function slrandom(rnd:Number) : Number { return Math.ceil(Math.random()*rnd); }	
	private function PercentChance(chance:Number) : Boolean { return (Math.random()*100) < chance; }

}