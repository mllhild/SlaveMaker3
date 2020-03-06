// Door - a room in a house
// Translation status: COMPLETE

import Scripts.Classes.*;

class Door {
	private var Locked:Boolean;
	private var DoorEvent:Object;
	private var mc:MovieClip;
	public var DoorNo:Number;
	public var Room1:Number;
	public var Room2:Number; 
	private var Hidden:Boolean;
	private var bQuiet:Boolean;
	
	public function Door(room1:Number, room2:Number, hidden:Boolean, eventno:Object, locked:Boolean, quiet:Boolean) { 
		if (hidden == undefined) hidden = false;
		Hidden = hidden;
		Locked = locked;
		DoorEvent = eventno;
		DoorNo = 0;
		Room1 = room1;
		Room2 = room2;
		_root.HouseEvents.depth++;
		mc = _root.HouseEvents.Exploration.Door.duplicateMovieClip("room-" + _root.HouseEvents.depth, _root.HouseEvents.depth);
		mc.enum = eventno;
		mc.Door = this;
		mc._visible = !hidden;
		bQuiet = quiet == undefined ? false : quiet;
		mc.gotoAndStop(1);
	}
	public function MoveDoor(xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number) {
		if (rwidth != 0 && rwidth != undefined) mc._width = rwidth;
		if (rheight != 0 && rheight != undefined) mc._height = rheight;
		if (rrotate != undefined) mc._rotation = rrotate; 
		mc._x = xpos;
		mc._y = ypos;
		if (rrotate == 90) mc._x = mc._x + (mc._width / 2) - 4;
		else mc._y = mc._y - (mc._height / 2) + 1;
	}
	public function Destroy()
	{
		mc._visible = false;
		removeMovieClip(mc);
		delete mc;
		_root.HouseEvents.depth--;
	}
	public function ShowDoor(current:Number)
	{
		mc._visible = !Hidden;
	}
	public function HideDoor()
	{
		mc._visible = false;
	}
	public function IsLocked() : Boolean
	{
		return Locked;
	}
	public function LockDoor()
	{
		Locked = true;
	}
	public function UnlockDoor()
	{
		Locked = false;
	}
	public function OpenDoor() : Object
	{
		if (mc._currentframe != 2) {
			if (!Hidden) {
				if (!bQuiet) _root.PlaySound("DoorCreak");
				mc.gotoAndStop(2);
				return DoorEvent;
			}
		}
		return 0;
	}
}