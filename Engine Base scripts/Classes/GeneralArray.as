// General Array Class
// Translation status: COMPLETE
// 
// to create
// ar:ClearArray();   	// optional
// delete ar;			// optional
// ar = new GeneralArray();
//
// to empty
// ar.ClearArray();

import Scripts.Classes.*;

class GeneralArray extends Array {
	
	// Constructor
	public function GeneralArray()
	{
		super();
	}
	
	// Clear the contents
	function ClearArray()
	{
		var mc:MovieClip;
		var obj:Object;
		var i:Number = length;
		if (i == undefined) return;
		while (--i >= 0) {
			obj = pop();
			if (typeof(obj) == "movieclip") {
				mc = MovieClip(obj);
				mc.removeMovieClip();
				delete obj;
			}
		}
	}
}