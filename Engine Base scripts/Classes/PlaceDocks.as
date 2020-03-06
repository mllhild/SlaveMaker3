// Docks
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class PlaceDocks extends Place
{
	// constructor
	public function PlaceDocks(nn:String, mc:MovieClip, cg:Object, id:Number, cc:City)
	{
		// Linked to Walk-Docks.swf, xml node DocksPort, id 6, x = 280, y = 240
		super(nn, mc, cg, id, true, "", 280, 240, cc);
	}
	
	// Images
	public function HideImages()
	{
		this.mcBase.Lamia._visible = false;
		this.mcBase.ClipRopes._visible = false;
	}
	
	// DoWalkEvent
	// handles when the slave+supervisor walks to the placce
	public function DoWalkEvent()
	{
		PlaySound("Sounds/Wharf.mp3");
		super.DoWalkEvent();
	}
	
	// Walking in the Docks
	// do any initial special events before selecting an event
	public function DoWalkLoaded(mc:MovieClip, modulename:String)
	{
		// if modulename == "" then just use parent version
		if (coreGame.StrEvent != "SelectLocation") super.DoWalkLoaded(mc, this.ModuleName);
		else {
			// no, then we are starting a walk to this location
			ResetEventPicked();
			parentCity.SlaveMarket.LoadModule(parentCity.SlaveMarket.ModuleName, this, "DoWalkLoaded2");
		}
	}
	
	public function DoWalkLoaded2(mc:MovieClip, modulename:String)
	{
		// can your slave visit the slave pens?
		if (!coreGame.DocksSlavePens.IsAccessible()) {
			// No
			// Walk in the Port
			//coreGame.DocksPort.DoWalkLoaded(mc, "");
            coreGame.DoEventNext(4000);
			
		} else {
			ShowSupervisor();
			var dNode:XMLNode = coreGame.currentCity.FindPlaceNodeCByName("Docks");
			// Yes, slave pens or both slave pens and secure slave pens
			if (!coreGame.DocksSlavePensSecure.IsAccessible()) {
				AddText(Language.GetHtml("DocksListBasic", dNode));
				AskHerQuestions(4000, 4003, 4009, 0, Language.GetHtml("Name", coreGame.currentCity.FindPlaceNodeCByName("DocksPort")), Language.GetHtml("Name", coreGame.currentCity.FindPlaceNodeCByName("DocksSlavePens")), Language.GetHtml("BookPassage", dNode), "", Language.GetHtml("WhereVisit", dNode));
				coreGame.modulesList.DocksAreas(false);
	
			} else {
				AddText(Language.GetHtml("DocksListFull", dNode));
				AskHerQuestions(4000, 4003, 4004, 4009, Language.GetHtml("Name", coreGame.currentCity.FindPlaceNodeCByName("DocksPort")), Language.GetHtml("Name", coreGame.currentCity.FindPlaceNodeCByName("DocksSlavePens")), Language.GetHtml("Name", coreGame.currentCity.FindPlaceNodeCByName("DocksSlavePensSecure")), Language.GetHtml("BookPassage", dNode), Language.GetHtml("WhereVisit", dNode));
				coreGame.modulesList.DocksAreas(true);
			}
		}
	}

	
}