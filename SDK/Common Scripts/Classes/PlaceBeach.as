// Beach
// Linked to Walk-Beach.swf
//
// Translation status: COMPLETE

import Scripts.Classes.*;


class PlaceBeach extends Place
{
	// constructor
	public function PlaceBeach(nn:String, mc:MovieClip, cg:Object, id:Number, cc:City)
	{
		// Linked to Walk-Docks.swf, xml node DocksPort, id 6, x = 280, y = 240
		super(nn, mc, cg, id, true, "", 440, 40, cc);
		loading = false;		// suppress loading swf file
	}
	
	public function CanLoadSave() : Boolean { return false; }
	
	// Images
	public function HideImages()
	{
		this.mcBase.Swimming._visible = false;
		this.mcBase.Events._visible = false;
		this.mcBase.Tour._visible = false;
		this.mcBase.Walk._visible = false;
		this.mcBase.Private._visible = false;
		this.mcBase.Rocks._visible = false;
	}

}