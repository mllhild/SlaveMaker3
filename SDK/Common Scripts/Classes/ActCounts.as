// Counts for a category of images (Naked, Dickgirl etc) for a specific act
// Translation status: COMPLETE

import Scripts.Classes.*;

class ActCounts {
	// Variables
	private var coreGame:Object;			// core game engine
	private var slaveData:Object;		// associated slave girl details
	
	// Saved
	public var Normal:Number;		// base 0
	public var Dickgirl:Number;		// base 1
	public var Lesbian:Number;		// base 2
	public var Naked:Number;		// base 3
	public var Catgirl:Number;		// base 4
	public var Pregnant:Number;		// base 5
	public var Puppygirl:Number;	// base 6
	
	// Unsaved
	public var NormalNode:XMLNode;
	public var DickgirlNode:XMLNode;
	public var LesbianNode:XMLNode;
	public var NakedNode:XMLNode;
	public var CatgirlNode:XMLNode;
	public var PregnantNode:XMLNode;
	public var PuppygirlNode:XMLNode;
	
	public var NormalArray:Array;
	public var DickgirlArray:Array;
	public var LesbianArray:Array;
	public var NakedArray:Array;
	public var CatgirlArray:Array;
	public var PregnantArray:Array;
	public var PuppygirlArray:Array;
	
	// temporary variables for returning from GetImage
	public var imgName:String;
	public var actarr:Array;
	public var actNode:XMLNode;
	public var imgIndex:Number;
	
	// Constructor
	public function ActCounts(sd:Object, cg:Object) { 
		slaveData = sd;
		coreGame = cg;
		
		Normal = 0;
		Dickgirl = 0;
		Lesbian = 0;
		Naked = 0;
		Catgirl = 0;
		Pregnant = 0;
		Puppygirl = 0;
		
		NormalNode = null;
		DickgirlNode = null;
		LesbianNode = null;
		NakedNode = null;
		CatgirlNode = null;
		PregnantNode = null;
		PuppygirlNode = null;
				
		NormalArray = null;
		DickgirlArray = null;
		LesbianArray = null;
		NakedArray = null;
		CatgirlArray = null;
		PregnantArray = null;
		PuppygirlArray = null;
	}
	
	public function ClearImage(mc:MovieClip) : Boolean
	{
		if (NormalArray != null) {
			for (var i:Number = 0; i < Normal; i++) {
				if (NormalArray[i] == mc) {
					NormalArray[i] = undefined;
					return true;
				}
			}
		}
		if (DickgirlArray != null) {
			for (var i:Number = 0; i < Dickgirl; i++) {
				if (DickgirlArray[i] == mc) {
					DickgirlArray[i] = undefined;
					return true;
				}
			}
		}
		if (LesbianArray != null) {
			for (var i:Number = 0; i < Lesbian; i++) {
				if (LesbianArray[i] == mc) {
					LesbianArray[i] = undefined;
					return true;
				}
			}
		}
		if (NakedArray != null) {
			for (var i:Number = 0; i < Naked; i++) {
				if (NakedArray[i] == mc) {
					NakedArray[i] = undefined;
					return true;
				}
			}
		}
		if (CatgirlArray != null) {
			for (var i:Number = 0; i < Catgirl; i++) {
				if (CatgirlArray[i] == mc) {
					CatgirlArray[i] = undefined;
					return true;
				}
			}
		}
		if (PregnantArray != null) {
			for (var i:Number = 0; i < Pregnant; i++) {
				if (PregnantArray[i] == mc) {
					PregnantArray[i] = undefined;
					return true;
				}
			}
		}
		if (PuppygirlArray != null) {
			for (var i:Number = 0; i < Puppygirl; i++) {
				if (PuppygirlArray[i] == mc) {
					PuppygirlArray[i] = undefined;
					return true;
				}
			}
		}	
		return false;
	}
	
	public function ClearAllImages()
	{
		if (NormalArray != null) {
			for (var i:Number = 0; i < Normal; i++) {
				coreGame.RemoveFromLoadedImages(NormalArray[i]);
				NormalArray[i] = undefined;
			}
		}
		if (DickgirlArray != null) {
			for (var i:Number = 0; i < Dickgirl; i++) {
				coreGame.RemoveFromLoadedImages(DickgirlArray[i]);
				DickgirlArray[i] = undefined;
			}
		}
		if (LesbianArray != null) {
			for (var i:Number = 0; i < Lesbian; i++) {
				coreGame.RemoveFromLoadedImages(LesbianArray[i]);
				LesbianArray[i] = undefined;
			}
		}
		if (NakedArray != null) {
			for (var i:Number = 0; i < Naked; i++) {
				coreGame.RemoveFromLoadedImages(NakedArray[i]);
				NakedArray[i] = undefined;
			}
		}
		if (CatgirlArray != null) {
			for (var i:Number = 0; i < Catgirl; i++) {
				coreGame.RemoveFromLoadedImages(CatgirlArray[i]);
				CatgirlArray[i] = undefined;
			}
		}
		if (PregnantArray != null) {
			for (var i:Number = 0; i < Pregnant; i++) {
				coreGame.RemoveFromLoadedImages(PregnantArray[i]);
				PregnantArray[i] = undefined;
			}
		}
		if (PuppygirlArray != null) {
			for (var i:Number = 0; i < Puppygirl; i++) {
				coreGame.RemoveFromLoadedImages(PuppygirlArray[i]);
				PuppygirlArray[i] = undefined;
			}
		}	
	}
	
	public function GetTotalImages() : Number
	{
		return Normal + Dickgirl + Lesbian + Naked + Catgirl + Pregnant + Puppygirl;
	}
	
	public function GetTotalImagesUsable(act:Number) : Number {
		if (slaveData == null) return GetTotalImages();
		
		var dg:Boolean = slaveData.IsDickgirl();
		var cg:Boolean = slaveData.IsCatgirl();
		var pg:Boolean = slaveData.IsPuppygirl();
		var preg:Boolean = slaveData.PregnancyGestation > 0;
		var nk:Boolean = slaveData.DressWorn < 0;

		var tot:Number = 0;
		if (coreGame.Lesbian) tot += Lesbian;
		if (nk && tot == 0) tot += Naked;
		if (cg && tot == 0) tot += Catgirl;
		if (pg && tot == 0) tot += Puppygirl;
		if (dg && tot == 0) tot += Dickgirl;
		if (preg && tot == 0) tot += Pregnant;
		if (tot == 0) {
			if (act < 1000 || act == 1017 || act == 1010 || act == 1016 || act == 10001) tot += Naked;
			tot += Normal;
			if (act == 11) tot += Lesbian;
		}
		return tot;
	}
	
	public function GetImage(act:Number, base:Number) : Boolean
	{
		if (slaveData != null) {
			var dg:Boolean = slaveData.IsDickgirl() && base != 1;
			var cg:Boolean = slaveData.IsCatgirl() && base != 4;
			var pg:Boolean = slaveData.IsPuppygirl() && base != 6;
			var nk:Boolean = slaveData.DressWorn < 0  && base != 3;
			var preg:Boolean = slaveData.PregnancyGestation > 0 && base != 5;
			var lestr:Boolean = slaveData.CheckBitFlag(10) && base != 2;
			
			imgIndex = 0;
			imgName = "";
	
			if (preg) {
				if (Pregnant != 0) {
					actarr = PregnantArray;
					actNode = PregnantNode;
					imgIndex = int(Math.random() * Math.abs(Pregnant)) + 1;
					if (Pregnant < 0) imgIndex *= -1;
					else imgName += "Pregnant ";
					return true;
				}
			}
			if (cg) {
				if (Catgirl != 0) {
					actarr = CatgirlArray;
					actNode = CatgirlNode;
					imgIndex = int(Math.random() * Math.abs(Catgirl)) + 1;
					if (Catgirl < 0) imgIndex *= -1;
					else imgName += "Catgirl ";
					return true;
				}
			}
			if (pg) {
				if (Puppygirl != 0) {
					actarr = PuppygirlArray;
					actNode = PuppygirlNode;
					imgIndex = int(Math.random() * Math.abs(Puppygirl)) + 1;
					if (Puppygirl < 0) imgIndex *= -1;
					else imgName += "Puppygirl ";
					return true;
				}
			}

			if (dg) {
				if (Dickgirl != 0) {
					actarr = DickgirlArray;
					actNode = DickgirlNode;
					imgIndex = int(Math.random() * Math.abs(Dickgirl)) + 1;
					if (Dickgirl < 0) imgIndex *= -1;
					else imgName += "Dickgirl ";
					return true;
				}
			}
			if (((act == 11 && lestr) || (act != 11 && coreGame.Lesbian)) && Lesbian != 0) {
				actarr = LesbianArray;
				actNode = LesbianNode;
				imgIndex = int(Math.random() * Math.abs(Lesbian)) + 1;
				if (Lesbian < 0) imgIndex *= -1;
				else imgName += "Lesbian ";
				return true;
			}
			if (nk && Naked != 0) {
				actarr = NakedArray;
				actNode = NakedNode;
				imgIndex = int(Math.random() * Math.abs(Naked)) + 1;
				if (Naked < 0) imgIndex *= -1;
				else imgName += "Naked ";
				return true;
			}
			if (imgIndex < 0) {
				imgIndex = int(Math.random()*(imgIndex * -1)) + 1;
				actarr = NormalArray;
				actNode = NormalNode;
				return true;
			}
		}
		if (Normal == 0) return false;
		
		imgIndex = int(Math.random() * Math.abs(Normal)) + 1;
		if (base != 0 && Normal < 0) imgIndex *= -1;
		actarr = NormalArray;
		actNode = NormalNode;
		return true;
	}
	
	public function UpdateActCounts(normal:Number, dickgirl:Number, lesbian:Number, naked:Number, catgirl:Number, pregnant:Number, puppygirl:Number) : Number
	{ 
		var tot:Number = 0;
		if (!isNaN(normal)) {
			if (normal != -1) {
				if (NormalArray == null) NormalArray = new Array();
				for (var i:Number = Normal; i < normal; i++) NormalArray.push(undefined);
				tot += normal;
			}
			Normal = normal;
		}
		if (!isNaN(dickgirl)) {
			if (dickgirl != -1) {
				if (DickgirlArray == null) DickgirlArray = new Array();
				for (var i:Number = Dickgirl; i < dickgirl; i++) DickgirlArray.push(undefined);
				tot += dickgirl;
			}
			Dickgirl = dickgirl;
		}
		if (!isNaN(lesbian)) {
			if (lesbian != -1) {
				if (LesbianArray == null) LesbianArray = new Array();
				for (var i:Number = Lesbian; i < lesbian; i++) LesbianArray.push(undefined);
				tot += lesbian;
			}
			Lesbian = lesbian;
		}
		if (!isNaN(naked)) {
			if (naked != -1) {
				if (NakedArray == null) NakedArray = new Array();
				for (var i:Number = Naked; i < naked; i++) NakedArray.push(undefined);
				tot += naked;
			}
			Naked = naked;
		}
		if (!isNaN(catgirl)) {
			if (catgirl != -1) {
				if (CatgirlArray == null) CatgirlArray = new Array();
				for (var i:Number = Catgirl; i < catgirl; i++) CatgirlArray.push(undefined);
				tot += catgirl;
			}
			Catgirl = catgirl;
		}
		if (!isNaN(pregnant)) {
			if (pregnant != -1) {
				if (PregnantArray == null) PregnantArray = new Array();
				for (var i:Number = Catgirl; i < pregnant; i++) PregnantArray.push(undefined);
				tot += pregnant;
			}
			Pregnant = pregnant;
		}	
		if (!isNaN(puppygirl)) {
			if (puppygirl != -1) {
				if (PuppygirlArray == null) PuppygirlArray = new Array();
				for (var i:Number = Puppygirl; i < puppygirl; i++) PuppygirlArray.push(undefined);
				tot += puppygirl;
			}
			Puppygirl = puppygirl;
		}		
		return tot;
	}
	
	private function FindNodeCount(cNode:XMLNode) : String
	{
		var str:String = coreGame.XMLData.GetXMLString("Count", cNode.firstChild);
		if (str == "") {
			str = cNode.firstChild.nodeValue;
			if (str == null) return "0";
			str = coreGame.Language.StripLines(str);
		}
		return str;
	}


	public function PopulateCounts(aNode:XMLNode) : Number
	{
		var NormalCnt:Number = 0;
		var DickgirlCnt:Number = 0;
		var LesbianCnt:Number = 0;
		var NakedCnt:Number = 0;
		var CatgirlCnt:Number = 0;
		var PuppygirlCnt:Number = 0;
		var PregnantCnt:Number = 0;
		var bFnd:Boolean = false;
		var str:String;
		
		var cNode:XMLNode;
		
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Normal");
		if (cNode == null) cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Count");
		if (cNode != null) {
			NormalNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				NormalCnt = Number(str);
			}
		}
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Pregnant");
		if (cNode != null) {
			PregnantNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				PregnantCnt = Number(str);
			}
		}
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Dickgirl");
		if (cNode == null) cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Futanari");
		if (cNode != null) {
			DickgirlNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				DickgirlCnt = Number(str);
			}
		}
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Lesbian");
		if (cNode != null) {
			LesbianNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				LesbianCnt = Number(str);
			}
		}
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Naked");
		if (cNode != null) {
			NakedNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				NakedCnt = Number(str);
			}
		}
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Catgirl");
		if (cNode == null) cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Catboy");
		if (cNode != null) {
			CatgirlNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				CatgirlCnt = Number(str);
			}
		}
		cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Puppygirl");
		if (cNode == null) cNode = coreGame.XMLData.GetNode(aNode.firstChild, "Puppyboy");
		if (cNode != null) {
			PuppygirlNode = cNode;
			str = FindNodeCount(cNode);
			if (str != "") { 
				bFnd = true; 
				PuppygirlCnt = Number(str);
			}
		}		
		if (!bFnd) {
			NormalNode = aNode;
			cNode = aNode.firstChild;
			str = coreGame.XMLData.GetXMLString("Count", cNode);
			if (str != "") NormalCnt = Number(str);
			else {
				var valarr:Array = cNode.nodeValue.split(",");
				NormalCnt = Number(valarr[0]);
				DickgirlCnt = Number(valarr[1]);
				LesbianCnt = Number(valarr[2]);
				NakedCnt = Number(valarr[3]);
				CatgirlCnt = Number(valarr[4]);
				PregnantCnt = Number(valarr[5]);
				Puppygirl = Number(valarr[6]);
			}
		}
		return UpdateActCounts(NormalCnt, DickgirlCnt, LesbianCnt, NakedCnt, CatgirlCnt, PregnantCnt, PuppygirlCnt);
	}	
	
	public function Save(so:Object)
	{
		if (Normal != 0) so.Normal = Normal;
		if (Dickgirl != 0) so.Dickgirl = Dickgirl;
		if (Lesbian != 0) so.Lesbian = Lesbian;
		if (Naked != 0) so.Naked = Naked;
		if (Catgirl != 0) so.Catgirl = Catgirl;
		if (Pregnant != 0) so.Pregnant = Pregnant;
		if (Puppygirl != 0) so.Puppygirl = Puppygirl;
	}
	
	public function Load(lo:Object)
	{
		if (lo.Normal != undefined) Normal = lo.Normal;		
		if (lo.Dickgirl != undefined) Dickgirl = lo.Dickgirl;
		if (lo.Lesbian != undefined) Lesbian = lo.Lesbian;
		if (lo.Naked != undefined) Naked = lo.Naked;
		if (lo.Catgirl != undefined) Catgirl = lo.Catgirl;
		if (lo.Pregnant != undefined) Pregnant = lo.Pregnant;
		if (lo.Puppygirl != undefined) Puppygirl = lo.Puppygirl;
		
		if (NormalArray == null || NormalArray.length == 0) {
			if (NormalArray == null) NormalArray = new Array();
			for (var i:Number = 0; i < Normal; i++) NormalArray.push(undefined);
		}
		if (DickgirlArray == null || DickgirlArray.length == 0) {
			if (DickgirlArray == null) DickgirlArray = new Array();
			for (var i:Number = 0; i < Dickgirl; i++) DickgirlArray.push(undefined);
		}
		if (LesbianArray == null || LesbianArray.length == 0) {
			if (LesbianArray == null) LesbianArray = new Array();
			for (var i:Number = 0; i < Lesbian; i++) LesbianArray.push(undefined);
		}
		if (NakedArray == null || NakedArray.length == 0) {
			if (NakedArray == null) NakedArray = new Array();
			for (var i:Number = 0; i < Naked; i++) NakedArray.push(undefined);
		}
		if (CatgirlArray == null || CatgirlArray.length == 0) {
			if (CatgirlArray == null) CatgirlArray = new Array();
			for (var i:Number = 0; i < Catgirl; i++) CatgirlArray.push(undefined);
		}
		if (PregnantArray == null || PregnantArray.length == 0) {
			if (PregnantArray == null) PregnantArray = new Array();
			for (var i:Number = 0; i < Pregnant; i++) PregnantArray.push(undefined);
		}
		if (PuppygirlArray == null || PuppygirlArray.length == 0) {
			if (PuppygirlArray == null) PuppygirlArray = new Array();
			for (var i:Number = 0; i < Puppygirl; i++) PuppygirlArray.push(undefined);
		}		
	}
}