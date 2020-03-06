// A Dress/Suit of clothing. For simplicity refered to as a dress from now on
// Translation status: COMPLETE

import Scripts.Classes.*;

class Dress {
	// Variables
	// saved
	public var strName:String;			// name of the dress
	public var strDescription:String;	// the description of the dress, generally including stat effects
	public var nPrice:Number;			// price to purchase
	public var nDressFrame:Number;		// for multiple image dress movieclips this is the current frame
	private var bOwned:Boolean			// do you own the dress
	private var bSold:Boolean			// is it sold at the Tailors shop
	private var nDressAttributes:Number;// a set of 32 bit flags for the attributes of the dress, see functions like IsDressEasy
	
	public var arDressStats:Array;		// list of the +/- stat modifiers for the dress
	
	// not saved
	private var sd:Object;				// base object for this dress
	private var bDressLeft:Boolean;		// internal use for generating the description
	
	// Functions
	
	// constructor
	public function Dress(sdo:Object) { 
		sd = sdo;
		
		strName = "";
		strDescription = "";
		nPrice = 0;
		nDressFrame = 1;
		bOwned = false;				// default not owned
		bSold = true;				// default sold
		arDressStats = null;
		nDressAttributes = 0;		// no attributes
	}
	
	// load/save
	public function Load(lo:Object)
	{
		strName = lo.strName;
		strDescription = lo.strDescription;
		nPrice = lo.nPrice;
		nDressFrame = lo.nDressFrame;
		bOwned = lo.bOwned;
		bSold = lo.bSold;
		nDressAttributes = lo.nDressAttributes;
		
		if (lo.arDressStats != undefined) {
			var len:Number = lo.arDressStats.length;
			delete arDressStats;
			arDressStats = new Array();
			for (var i:Number = 0; i < len; i++) arDressStats.push(lo.arDressStats[i]);
		}
	}
	
	public function Save(so:Object)
	{
		so.strName = strName;
		so.strDescription = strDescription;
		so.nPrice = nPrice;
		so.nDressFrame = nDressFrame;
		so.bOwned = bOwned;
		so.bSold = bSold;
		so.nDressAttributes = nDressAttributes;
		
		if (arDressStats != undefined) {
			var len:Number = arDressStats.length;
			delete so.arDressStats;
			so.arDressStats = new Array();
			for (var i:Number = 0; i < len; i++) so.arDressStats.push(arDressStats[i]);
		}
	}
	
	// accessors
	// note: no accessors for name, description, price
	
	// Ownership
	public function IsDressOwned() : Boolean { return bOwned; }
	
	public function SetDressOwned(own:Boolean)
	{
		if (own == undefined) bOwned = true;
		else bOwned = own;
	}
	
	// For Sale
	public function IsDressForSale() : Boolean { return bSold; }
	
	public function SetDressForSale(sell:Boolean) 
	{ 
		if (sell == undefined) bSold = true;
		else bSold = sell;
	}

	// Attributes of the dress
	public function IsDressSpecial() : Boolean { return nDressAttributes != 0; }
	
	// is the dress easy to move in
	public function IsDressEasy() : Boolean { return IsDressAttribute(0); }
	public function SetDressEasy() { SetDressAttribute(0); }
	
	// is it a court dress
	public function IsDressCourtly() : Boolean { return IsDressAttribute(1); }
	public function SetDressCourtly() {	SetDressAttribute(1); }
	
	// is it a swimsuit
	public function IsDressSwimsuit() : Boolean { return IsDressAttribute(2); }
	public function SetDressSwimsuit() { SetDressAttribute(2); }
	
	// is it appropriate for the Sleazy Bar
	public function IsDressSleazyBar() : Boolean { return IsDressAttribute(3); }
	public function SetDressSleazyBar() { SetDressAttribute(3); }
	
	// Does it make the wearer feel like a slut
	public function IsDressSlutty() : Boolean {	return IsDressAttribute(4); }
	public function SetDressSlutty() { SetDressAttribute(4); }
	
	// Is the dress designed for dancing
	public function IsDressDancing() : Boolean { return IsDressAttribute(5); }
	public function SetDressDancing() { SetDressAttribute(5); }
	
	// Is the dress a version of a maid uniform
	public function IsDressMaid() : Boolean { return IsDressAttribute(6); }
	public function SetDressMaid() { SetDressAttribute(6); }
	
	// If the dress basically a type of lingerie
	public function IsDressLingerie() : Boolean { return IsDressAttribute(7); }
	public function SetDressLingerie() { SetDressAttribute(7); }
	
	// Does the dress have a set of catgirl ears fitted
	public function IsDressCatEars() : Boolean { return IsDressAttribute(8); }
	public function SetDressCatEars() { SetDressAttribute(8); }
	
	// Does the dress have a cat tail fitted
	public function IsDressCatTail() : Boolean { return IsDressAttribute(9); }
	public function SetDressCatTail() {	SetDressAttribute(9); }
	
	// Is the dress a form of a miko/acolytes robes
	public function IsDressMiko() : Boolean { return IsDressAttribute(10); }
	public function SetDressMiko() { SetDressAttribute(10);	}
	
	// Is the dress appropriate for a waitress/waiter
	public function IsDressWaitress() : Boolean { return IsDressAttribute(11); }
	public function SetDressWaitress() { SetDressAttribute(11);	}
	
	// Is the dress blessed by the gods
	public function IsDressHoly() : Boolean { return IsDressAttribute(12); }
	public function SetDressHoly() { SetDressAttribute(12);	}
	
	// Is the dress blessed/cursed by demonic forces
	public function IsDressDemonic() : Boolean { return IsDressAttribute(13); }
	public function SetDressDemonic() {	SetDressAttribute(13); }
	
	// Does the dress have a set of puppygirl ears fitted
	public function IsDressPuppyEars() : Boolean { return IsDressAttribute(14); }
	public function SetDressPuppyEars() { SetDressAttribute(14); }
	
	// Does the dress have a puppy tail fitted
	public function IsDressPuppyTail() : Boolean { return IsDressAttribute(15); }
	public function SetDressPuppyTail() {	SetDressAttribute(15); }

	// internal use
	private function IsDressAttribute(att:Number) : Boolean { return ((nDressAttributes & (1 << att)) != 0); }
	private function SetDressAttribute(att:Number) { nDressAttributes = nDressAttributes | (1 << att); }
	
	// Set dress stat effects
	
	public function SetDressStats(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Joy:Number, Special:Number, Special2:Number) { }
	
	// pass in an array of stats +- values, one per stat
	public function SetDressStatsByArray(se:Array)
	{
		delete arDressStats;
		arDressStats = new Array();
	
		strDescription = "";
		bDressLeft = true;
		
		for (var id:Number = 0; id < se.length; id++) {
			if (se[id] == undefined) arDressStats.push(0);
			else {
				var val:Number = Number(StripLinesTrim(se[id]));
				arDressStats.push(val);
				strDescription = AddDressStatEffect(sd.GetStatName(id), val, strDescription);
			}
		}
	}
	
	private function StripLinesTrim(s:String) : String
	{
		// inlined strTrim
		if (s == undefined || s == "" || s == " ") return "";
		while (s.substr(-1, 1) == " ") s = s.substr(0, s.length-1);
		if (s == "" || s == " ") return "";
		while (true) {
			if (s.charAt(0) != " ") break;
			s = s.substr(1);
		}
		var sl:Array = s.split("\r");
		s = sl[0].split("\n")[0];
		s = s.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join("");
		if (s == undefined || s == "" || s == " ") return "";
		while (s.substr(-1, 1) == " ") s = s.substr(0, s.length-1);
		if (s == "" || s == " ") return "";
		while (true) {
			if (s.charAt(0) != " ") break;
			s = s.substr(1);
		}
		return s;
	}
	
	// internal functions for setting stat effects
				
	private function AddDressStatEffect(stat:String, val:Number, desc:String) : String {
		if (val == 0 || val == undefined) return desc;
		
		if (bDressLeft) desc += "\r";
		else desc += ", ";
		bDressLeft = !bDressLeft;
		
		if (val < 0) return desc + stat + " " + val;
		return desc + stat + " +" + val;
	}
	
}