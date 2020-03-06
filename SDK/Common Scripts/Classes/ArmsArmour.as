// Weapons and Armour
// Translation status: COMPLETE

import Scripts.Classes.*;

class ArmsArmour extends SMSlaveCommon  {

	public var ArmourType:Number;
	public var WeaponType:Number;
	
	public var WeaponOwned:BitFlags;
	public var ArmourOwned:BitFlags;

	public function ArmsArmour(cg:Object) {
		super(cg);
		
		ArmourType = 0;
		WeaponType = 0;
		WeaponOwned = new BitFlags();
		ArmourOwned = new BitFlags();
	}
	
	// Load/Save
	public function Load(so:Object)
	{
		super.Load(so);
		
		ArmourOwned.Load(so.ArmourOwned);
		WeaponOwned.Load(so.WeaponOwned);

		ArmourType = so.ArmourType;
		WeaponType = so.WeaponType;
	}
	
	public function Save(so:Object, GameNo:String)
	{	
		super.Save(so);
		
		so.ArmourOwned = new Object();
		ArmourOwned.Save(so.ArmourOwned);
		so.WeaponOwned = new Object();
		WeaponOwned.Save(so.WeaponOwned);

		so.ArmourType = ArmourType;
		so.WeaponType = WeaponType;
	}
	
	public function CopyCommonDetails(smFrom:Object, smTo:Object)
	{
		// do not copy the common details for slave makers to prevent overwriting slave details in global scope
		//super.CopyCommonDetails(sdFrom, sdTo);
		smTo.ArmourType = smFrom.ArmourType;
		smTo.WeaponType = smFrom.WeaponType;
		
		// no need to do the owned versions
	}
	
	
	// Weapons
	public function IsWeaponOwned(weapon) : Boolean
	{
		var weap:Number;
		if (isNaN(weapon)) weap = FindWeaponIdByName(String(weapon));
		else weap = Number(weapon);
		if (weap == -1) return false;
	
		if (weap == 0) return true;
		return WeaponOwned.CheckBitFlag(weap);
	}
	
	public function IsWeaponClassOwned(wclass:String) : Boolean
	{
		var tw:Number = GetTotalWeapons();
		for (var i:Number = 0; i < tw; i++) {
			if (IsWeaponOwned(i)) {
				if (coreGame.XMLData.GetXMLStringParsed("Type", FindWeaponNodeCByNumber(i)).toLowerCase() == wclass) return true;
			}
		}
		return false;
	}
	
	public function SetWeaponOwned(weapon)
	{
		var weap:Number;
		if (isNaN(weapon)) weap = FindWeaponIdByName(String(weapon));
		else weap = Number(weapon);
		if (weap == -1) return;
		WeaponOwned.SetBitFlag(weap);
	}
	
	public function GetWeaponName(weap:Number) : String
	{
		return coreGame.XMLData.GetXMLStringParsed("Name", FindWeaponNodeCByNumber(weap));
	}
	
	private var strLastClass:String = "";
	private var nLastWeapon:Number = -100;
	
	public function GetWeaponClass(weap:Number) : String
	{
		if (weap == undefined) weap = WeaponType;
		if (weap == nLastWeapon) return strLastClass;		
		nLastWeapon = weap;
		strLastClass = coreGame.XMLData.GetXMLStringParsed("Type", FindWeaponNodeCByNumber(weap)).toLowerCase();
		return strLastClass;
	}
	
	public function GetWeaponPrice(weapon) : Number
	{
		var weap:Number;
		if (isNaN(weapon)) weap = FindWeaponIdByName(String(weapon));
		else weap = Number(weapon);
		if (weap == -1) return 0;
		
		return coreGame.XMLData.GetXMLValueParsed("Price", FindWeaponNodeCByNumber(weap));
	}
	
	public function LoadWeaponImage(weap, place:Number, align:Number, gframe:Number, target:MovieClip, delay:Number, imgCallback:Function) : MovieClip
	{
		var wNode:XMLNode;
		if (!isNaN(weap)) wNode = FindWeaponNodeCByNumber(Number(weap));
		else wNode = weap;
		trace(wNode.parentNode);
		
		wNode = coreGame.XMLData.GetNode(wNode, "Image");
		coreGame.XMLData.EventText = "";
		coreGame.XMLData.XMLEventByNode(wNode, true, undefined, true, true);
		trace(coreGame.XMLData.EventText);
		
		var mc:MovieClip;
		if (wNode.attributes.attach.toLowerCase() == "true") {
			mc = coreGame.AutoAttachAndShowMovie(coreGame.XMLData.EventText, place, align, gframe, target, delay);
			if (imgCallback != undefined) imgCallback(mc);
		} else mc = coreGame.AutoLoadImageAndShowMovie(coreGame.XMLData.EventText, place, align, target, delay, imgCallback);
		coreGame.XMLData.EventText = "";
		return mc;
	}
	
	
	public function GetTotalWeapons(sold:Boolean)
	{
		var tot:Number = 0;
		var price:Number;
		for (var hNode:XMLNode = coreGame.XMLData.GetNodeC("Combat/Weapons"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeName.toLowerCase() == "weapon") {
				if (sold == true) {
					price = Number(coreGame.XMLData.GetXMLStringParsed("Price", hNode.firstChild));
					if (price != 0 && !isNaN(price)) tot++;
				} else tot++;
			}
		}
		return tot;
	}
	
	public function FindWeaponNodeCByNumber(type:Number) : XMLNode
	{
		// find the CHILD nodes for a given weapon
		var curr:Number = -1;
		if (type == undefined) type = WeaponType;
			
		for (var hNode:XMLNode = coreGame.XMLData.GetNodeC("Combat/Weapons"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			if (hNode.nodeName.toLowerCase() == "weapon") {
				curr++;
				if (curr == type) return hNode.firstChild;
			}
		}
		return null;
	}
	
	public function FindWeaponIdByName(str:String) : Number
	{
		var curr:Number = -1;
		var nm:String;
		str = str.toLowerCase().split(" ").join("");
			
		for (var hNode:XMLNode = coreGame.XMLData.GetNodeC("Combat/Weapons"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "weapon") {
				curr++;
				nm = coreGame.XMLData.GetXMLStringParsed("Name", hNode.firstChild);
				if (nm.toLowerCase().split(" ").join("") == str) return curr;
			}
		}
		return -1;
	}
	
	
	// Armour
	
	public function IsArmourOwned(armour) : Boolean
	{
		var arm:Number;
		if (isNaN(armour)) arm = FindArmourIdByName(String(armour));
		else arm = Number(armour);
		if (arm == -1) return false;
	
		if (arm == 0) return true;
		return ArmourOwned.CheckBitFlag(arm);
	}
	
	public function SetArmourOwned(armour)
	{
		var arm:Number;
		if (isNaN(armour)) arm = FindArmourIdByName(String(armour));
		else arm = Number(armour);
		if (arm == -1) return false;
	
		ArmourOwned.SetBitFlag(arm);
	}
	
	public function GetArmourName(arm:Number) : String
	{
		return coreGame.XMLData.GetXMLStringParsed("Name", FindArmourNodeCByNumber(arm));
	}
	
	public function GetArmourPrice(armour) : Number
	{
		var arm:Number;
		if (isNaN(armour)) arm = FindArmourIdByName(String(armour));
		else arm = Number(armour);
		if (arm == -1) return 0;
	
		return coreGame.XMLData.GetXMLValueParsed("Price", FindArmourNodeCByNumber(arm));
	}
	
	public function FindArmourNodeCByNumber(type:Number) : XMLNode
	{
		// find the CHILD nodes for a given set of armour
		var curr:Number = -1;
		var nm:String;
		if (type == undefined) type = ArmourType;
			
		for (var hNode:XMLNode = coreGame.XMLData.GetNodeC("Combat/ArmourSets"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "armour") {
				curr++;
				if (curr == type) return hNode.firstChild;
			}
		}
		return null;
	}
	
	public function FindArmourIdByName(str:String) : Number
	{
		var curr:Number = -1;
		var nm:String;
		str = str.toLowerCase();
			
		for (var hNode:XMLNode = coreGame.XMLData.GetNodeC("Combat/ArmourSets"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeType != 1) continue;
			nm = hNode.nodeName.toLowerCase();
			if (nm == "armour") {
				curr++;
				nm = coreGame.XMLData.GetXMLStringParsed("Name", hNode.firstChild);
				if (nm.toLowerCase() == str) return curr;
			}
		}
		return -1;
	}
	
	public function GetTotalArmours(sold:Boolean)
	{
		var tot:Number = 0;
		var price:Number;
		for (var hNode:XMLNode = coreGame.XMLData.GetNodeC("Combat/ArmourSets"); hNode != null; hNode = hNode.nextSibling) {
			if (hNode.nodeName.toLowerCase() == "armour") {
				if (sold == true) {
					price = Number(coreGame.XMLData.GetXMLStringParsed("Price", hNode.firstChild));
					if (price != 0 && !isNaN(price)) tot++;
				} else tot++
			}
		}
		return tot;
	}
	
	public function LoadArmourImage(arm, place:Number, align:Number, gframe:Number, target:MovieClip, delay:Number, imgCallback:Function) : MovieClip
	{
		var wNode:XMLNode;
		if (typeof(arm) == "number") wNode = FindArmourNodeCByNumber(Number(arm));
		else wNode = arm;
		
		wNode = coreGame.GetNode(wNode, "Image");
		coreGame.XMLData.EventText = "";
		coreGame.XMLData.XMLEventByNode(wNode, true, undefined, true, true);
		
		var mc:MovieClip;
		if (wNode.attributes.attach.toLowerCase() == "true") {
			mc = coreGame.AutoAttachAndShowMovie(coreGame.XMLData.EventText, place, align, gframe, target, delay);
			if (imgCallback != undefined) imgCallback(mc);
		} else mc = coreGame.AutoLoadImageAndShowMovie(coreGame.XMLData.EventText, place, align, target, delay, imgCallback);
		coreGame.XMLData.EventText = "";
		return mc;
	}
	
	public function TrainWeapon(weap:Number, snd:Boolean)
	{
		if (snd != false) coreGame.Sounds.PlaySound("Clang");
		
		switch (GetWeaponClass(weap)) {
			case "unarmed":
				sUnarmedExpertise++;
				break;
			case "sword": 
				sSwordExpertise++;
				break;
			case "bow": 
				sBowExpertise++;
				break;
			case "whip": 
				sWhipExpertise++;
				break;
			case "hammer":
				sHammerExpertise++;
				break;
			case "naginata":
				sNaginataExpertise++;
				break;
			case "dagger":
				sDaggerExpertise++;
				break;
			case "crossbow":
				sCrossbowExpertise++;
				break;
			case "thrown":
				sThrownExpertise++;
				break;
		}
		coreGame.UpdateSlaveMaker();
	}
	
	public function GetWeaponSkill(weap:Number) : Number
	{
		switch (GetWeaponClass(weap)) {
			case "unarmed":	return sUnarmedExpertise;
			case "sword": return sSwordExpertise;
			case "bow": return sBowExpertise;
			case "whip": return sWhipExpertise;
			case "hammer": return sHammerExpertise;
			case "naginata": return sNaginataExpertise;
			case "dagger": return sDaggerExpertise;
			case "crossbow": return sCrossbowExpertise;
			case "thrown": return sThrownExpertise;
		}
		return 0;
	}

}