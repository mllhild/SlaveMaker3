// General bit flags
//
// note: a class so must be created using new
// OtherBooks = new BitFlags();
//
//To save a flag, say in a custom event
// 	cookie.data.vOtherBooks = new Object();
//  OtherBooks.Save(cookie.data.vOtherBooks);
//
//To Load a flag
//  OtherBooks.Load(cookie.data.vOtherBooks);
//
//
// Translation status: COMPLETE
import Scripts.Classes.*;

class BitFlags {
	private var arFlags:Array;		// array of Number
	
	public function BitFlags()
	{
		// initialise with 32 bites
		arFlags = new Array();
		arFlags.push(0);
	}
	
	public function ResetBitFlags()
	{
		for (var idx:String in arFlags) arFlags[idx] = 0;
	}
		
	public function CheckBitFlag(flag:Number) : Boolean
	{
		var idx:Number = int(flag / 32);
		if (idx >= arFlags.length) return false;
		flag -= (idx * 32);
		return ((arFlags[idx] & (1 << flag)) != 0);
	}
	
	public function SetBitFlag(flag:Number)
	{
		if (isNaN(flag)) return;
		var idx:Number = int(flag / 32);
		if (idx >= arFlags.length) {
			for (var i:Number = arFlags.length; i <= idx; i++) arFlags.push(0);
		}
		flag -= (idx * 32);
		arFlags[idx] = arFlags[idx] | (1 << flag);
	}
	
	public function ClearBitFlag(flag:Number)
	{
		var idx:Number = int(flag / 32);
		if (idx >= arFlags.length) return;
		flag -= (idx * 32);
		arFlags[idx] = arFlags[idx] & (~(1 << flag));
	}
	
	public function ChangeBitFlag(flag:Number, setf:Boolean)
	{
		if (setf) SetBitFlag(flag);
		else ClearBitFlag(flag);
	}
	
	public function CheckAndSetBitFlag(flag:Number) : Boolean
	{
		if (CheckBitFlag(flag)) return false;
		SetBitFlag(flag);
		return true;
	}
	
	public function ShowBitFlags(cnt:Number) : String
	{
		if (cnt == undefined) cnt = GetMaxFlag();
		var say:String = "";
		for (var i:Number = 0; i < cnt; i++) {
			say += "  Flag " + i + " = " + CheckBitFlag(i);
			if ((i % 2) != 0) say += "\r";
			else say += "\t";
		}
		return say;
	}
	
	public function Load(lo:Object)
	{
		delete arFlags;
		arFlags = new Array();
		
		if (lo.arFlags != undefined) {
			var size:Number = lo.arFlags.length;
			var val:Number;
			for (var i:Number = 0; i < size; i++)
			{
				val = lo.arFlags[i];
				if (isNaN(val)) val = 0;
				arFlags.push(val);
			}
		} else if (typeof(lo) == "number") arFlags.push(Number(lo));
		else if (lo.vBitFlag1 != undefined) {
			arFlags.push(lo.vBitFlag1);
			arFlags.push(lo.vBitFlag2);
			arFlags.push(lo.vBitFlag3);
		} else ResetBitFlags();
		
		// prune end of the list of flags, do not prune the first entry
		var len:Number = arFlags.length;
		while (--len > 0 && arFlags[len] == 0) arFlags.pop();

	}
	
	public function Save(so:Object)
	{
		var size:Number = arFlags.length;
		so.arFlags = new Array();
		for (var i:Number = 0; i < size; i++) so.arFlags.push(arFlags[i]);
	}
	
	public function GetMaxFlag() : Number { return arFlags.length * 32; }

}