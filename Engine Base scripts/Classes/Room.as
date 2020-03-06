// Room - a room in a house
// Translation status: COMPLETE

import Scripts.Classes.*;

class Room {
	private var Explored:Boolean;
	private var Type:Number;
	private var Description:String;
	private var EventNum:Object;
	private var mc:MovieClip;
	public var RoomNo:Number;
	private var stairs:Room;
	
	public var arOccupants:Array;
	
	public var Capacity:Number;			// capcity in people, books etc

	
	public function Room(type:Number, desc:String, eventno:Object, explored:Boolean) { 
		Explored = explored == true;
		Type = type;
		Description = desc;
		EventNum = eventno;
		RoomNo = 0;
		_root.HouseEvents.depth++;

		switch(type) {
			case 0:
				mc = _root.HouseEvents.Exploration.Room.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
				break;
			case 1:
			case 1.1:
			case 1.2:
				mc = _root.HouseEvents.Exploration.Passage.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
				mc.EndTop._visible = false;
				mc.EndBottom._visible = false;
				if (type == 1.1) mc.EndTop._visible = true;
				else if (type == 1.2) mc.EndBottom._visible = true;
				break;
			case 2:
				mc = _root.HouseEvents.Exploration.RoomRough.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
				break;
			case 3:
				mc = _root.HouseEvents.Exploration.PassageRough.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
				mc.EndTop._visible = false;
				mc.EndBottom._visible = false;
				if (type == 3.1) mc.EndTop._visible = true;
				else if (type == 3.2) mc.EndBottom._visible = true;
				break;
			case 4.1:
			case 4.2:
				mc = _root.HouseEvents.Exploration.TrapDoor.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
				break;
			case 5:
			case 5.1:
			case 5.2:
				mc = _root.HouseEvents.Exploration.Stairs.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
				break;
		}
		mc.RoomLabel.htmlText = desc;
		mc.ThisRoom = this;
		stairs = null;
	}
	
	public function Load(lo:Object)
	{
		Type = lo.Type;
		if (lo.Occupant != undefined) {
			for (var io:Number = 0; io < lo.arOccupants.length; io++) arOccupants.push(lo.arOccupants[io]);
		}
		Capacity = lo.Capacity;
	}
	public function Save(so:Object)
	{
		so.Type = Type;
		so.arOccupants = new Array();
		for (var io:Number = 0; io < arOccupants.length; io++) so.arOccupants.push(arOccupants[io]);
		so.Capacity = Capacity;
	}

	
	public function MoveRoom(xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number) {
		mc._width = rwidth + 1;
		mc._height = rheight + 1;
		if (rrotate != undefined) mc._rotation = rrotate; 
		mc._x = xpos;
		mc._y = ypos;
		if (rrotate == 90) mc._x = mc._x + mc._width - 3;
	}
	public function AddStairs(type:Number, eventno:Object, xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number) {
		stairs = new Room(type, "", eventno, Explored);
		stairs.MoveRoom(mc._x + xpos, mc._y + ypos, rwidth, rheight, rrotate);
	}
	public function Destroy()
	{
		delete stairs;
		mc._visible = false;
		removeMovieClip(mc);
		delete mc;
		_root.HouseEvents.depth--;
	}
	public function ShowRoom(near:Boolean, here:Number)
	{
		mc._visible = true;
		mc.RoomButton._visible = near;
		mc.Here._visible = here == RoomNo;
		mc.Overlay._visible = !mc.Here._visible && !Explored;
		if (stairs != null) stairs.ShowRoom(true, -1);
	}
	public function HideRoom()
	{
		mc._visible = false;
		stairs.HideRoom();
	}
	public function GetDescription() : String
	{
		return Description;
	}
	public function GetType() : Number
	{
		return Type;
	}
	public function IsExplored() : Boolean
	{
		return Explored;
	}
	public function GetEvent() : Object
	{
		return EventNum;
	}
	public function GetMovieClip() : MovieClip
	{
		return mc;
	}
	public function EnterRoom()
	{
		Explored = true;
		if (stairs != null) stairs.EnterRoom();
	}
	public function SetExplored()
	{
		Explored = true;
	}
}