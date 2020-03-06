// Floor - the floor of a house
// Translation status: COMPLETE

import Scripts.Classes.*;

class Scripts.Classes.Floor {
	private var arRooms:Array;
	private var arDoors:Array;
	private var CurrentRoom:Number;
	public var FloorNo:Number;
	
	public function Floor() { 
		Destroy();
		this.arRooms = new Array();
		this.arDoors = new Array();
		this.CurrentRoom = -1;
		this.FloorNo = 0;
	}
	public function Destroy()
	{
		for (var i:Number = 0; i < this.arRooms.length; i++) {
			var rm:Room = this.arRooms[i];
			rm.Destroy();
			delete this.arRooms[i];
		}
		delete this.arRooms;
		for (var i:Number = 0; i < this.arDoors.length; i++) {
			var dr:Door = this.arDoors[i];
			dr.Destroy();
			delete this.arDoors[i];
		}
		delete this.arDoors;
	}
	public function AddRoom(type:Number, desc:String, eventno:Object, explored:Boolean) : Room
	{ 
		var rn:Number = this.arRooms.push(new Room(type, desc, eventno, explored));
		this.arRooms[rn - 1].RoomNo = rn - 1;
		return this.arRooms[rn - 1];
	}
	public function AddStairs(type:Number, xpos:Number, ypos:Number, rwidth:Number, rheight:Number, rrotate:Number, eventno:Object)
	{ 
		this.arRooms[this.arRooms.length - 1].AddStairs(type, eventno, xpos, ypos, rwidth, rheight, rrotate);
	}
	public function AddDoor(room1:Number, room2:Number, hidden:Boolean, eventno:Object, locked:Boolean, quiet:Boolean) : Door
	{ 
		var dn:Number = this.arDoors.push(new Door(room1, room2, hidden, eventno, locked, quiet));
		this.arDoors[dn - 1].DoorNo = dn - 1;
		return this.arDoors[dn - 1];
	}
	// dpos -1 = hidden
	// dpos clockwise from top left, eg 1 = top left, 2 = center top, 3 = top right, 4 = right wall, top .....
	public function AddDoorToRoom(room1:Number, room2:Number, dpos:Number, rwidth:Number, rheight:Number, eventno:Object, locked:Boolean, quiet:Boolean) : Door
	{ 
		if (rwidth == undefined) rwidth = 25;
		if (rheight == undefined) rheight = 14;
		if (locked == undefined) locked = false;
		var dn:Number = this.arDoors.push(new Door(room1, room2, dpos == -1, eventno, locked, quiet));
		this.arDoors[dn - 1].DoorNo = dn - 1;
		var mc:MovieClip = arRooms[room1].GetMovieClip();
		var xpos:Number = mc._x;
		var ypos:Number = mc._y;
		var drot:Number = 0;
		switch(dpos) {
			case 2: xpos = mc._x + (mc._width / 2) - (rwidth / 2); break;
			case 3: xpos = mc._x + mc._width - rwidth; break;
			case 4: xpos = mc._x + mc._width; drot = 90; break;
			case 5: xpos = mc._x + mc._width; ypos = mc._y + (mc._height / 2); drot = 90; break;
			case 6: xpos = mc._x + mc._width; drot = 90; ypos = mc._y + mc._height; break;
			case 7: xpos = mc._x + mc._width - rwidth; ypos = mc._y + mc._height; break;
			case 8: xpos = mc._x + (mc._width / 2) - (rwidth / 2); ypos = mc._y + mc._height; break;
			case 9: ypos = mc._y + mc._height; break;
			case 10: ypos = mc._y + mc._height; drot = 90; break;
			case 11: ypos = mc._y + (mc._height / 2); drot = 90; break;
			case 12: ypos = mc._y; drot = 90; break;
		}
		this.arDoors[dn - 1].MoveDoor(xpos, ypos, rwidth, rheight, mc._rotation + drot);
		return this.arDoors[dn - 1];
	}
	public function EnterRoom(croom:Room)
	{
		for (var i:Number = 0; i < this.arDoors.length; i++) {
			if (this.arDoors[i].Room1 == this.CurrentRoom || this.arDoors[i].Room2 == this.CurrentRoom) {
				if (this.arDoors[i].Room1 == croom.RoomNo || this.arDoors[i].Room2 == croom.RoomNo) {
					if (this.arDoors[i].IsLocked()) {
						_root.SetText("The door is locked.");
						return;
					}
					var evt:Object = this.arDoors[i].OpenDoor();
					if (evt != undefined) _root.DoEventNext(evt);
					this.CurrentRoom = croom.RoomNo;
					evt = croom.GetEvent();
					this.ShowFloor();
					_root.HouseEvents.ExplorationTitle.HouseTitle2.htmlText = croom.GetDescription();
					_root.DoEventNext(evt);
					croom.EnterRoom();
					_root.mcMain.MainWindowButton._visible = false;
					return;
				}
			}
		}
	}
	public function EnterRoomNo(croom:Number)
	{
		this.CurrentRoom = croom;
		this.ShowFloor();
		_root.HouseEvents.ExplorationTitle.HouseTitle2.htmlText = this.arRooms[croom].GetDescription();
		_root.DoEventNext(this.arRooms[croom].GetEvent());
		this.arRooms[croom].EnterRoom();
	}
	public function ShowFloor()
	{
		for (var i:Number = 0; i < this.arRooms.length; i++) {
			if (this.arRooms[i].RoomNo != this.CurrentRoom) {
				var near:Boolean = false;
				for (var j:Number = 0; j < this.arDoors.length; j++) {
					if (this.arDoors[j].Room1 == this.CurrentRoom || this.arDoors[j].Room2 == this.CurrentRoom) {
						if (this.arDoors[j].Room1 == this.arRooms[i].RoomNo || this.arDoors[j].Room2 == this.arRooms[i].RoomNo) near = true;
					}
				}
				this.arRooms[i].ShowRoom(near, this.CurrentRoom);
			} else this.arRooms[i].ShowRoom(false, this.CurrentRoom);
		}
		for (var i:Number = 0; i < this.arDoors.length; i++) {
			if (this.arDoors[i].Room1 == this.CurrentRoom || this.arDoors[i].Room2 == this.CurrentRoom) this.arDoors[i].ShowDoor();
		}
	}
	public function HideFloor()
	{
		for (var i:Number = 0; i < this.arRooms.length; i++) {
			this.arRooms[i].HideRoom();
		}
		for (var i:Number = 0; i < this.arDoors.length; i++) {
			this.arDoors[i].HideDoor();
		}

	}
	public function GetCurrentRoomDescription() : String
	{
		for (var i:Number = 0; i < this.arRooms.length; i++) {
			if (this.arRooms[i].RoomNo == this.CurrentRoom) return this.arRooms[i].GetDescription();
		}
		return "";
	}
	public function IsCurrentRoomExplored() : Boolean
	{
		for (var i:Number = 0; i < this.arRooms.length; i++) {
			if (this.arRooms[i].RoomNo == this.CurrentRoom) return this.arRooms[i].IsExplored();
		}
		return false;
	}
	public function GetCurrentRoomType() : Number
	{
		for (var i:Number = 0; i < this.arRooms.length; i++) {
			if (this.arRooms[i].RoomNo == this.CurrentRoom) return this.arRooms[i].GetType();
		}
		return 0;
	}
	public function IsRoomExplored(room:Number) : Boolean
	{
		return this.arRooms[room].IsExplored();
	}
	public function LockDoor(room1:Number, room2:Number)
	{
		for (var i:Number = 0; i < this.arDoors.length; i++) {
			if ((this.arDoors[i].Room1 == room1 || this.arDoors[i].Room2 == room1) && (this.arDoors[i].Room1 == room2 || this.arDoors[i].Room2 == room2)) {
				this.arDoors[i].LockDoor();
				return;
			}
		}
	}
	
	public function UnlockDoor(room1:Number, room2:Number)
	{
		for (var i:Number = 0; i < this.arDoors.length; i++) {
			if ((this.arDoors[i].Room1 == room1 || this.arDoors[i].Room2 == room1) && (this.arDoors[i].Room1 == room2 || this.arDoors[i].Room2 == room2)) {
				this.arDoors[i].UnlockDoor();
				return;
			}
		}
	}
	
	public function SetRoomExplored(room:Number)
	{
		this.arRooms[room].SetExplored();
	}
	public function SetCurrentRoom(room:Number)
	{
		this.CurrentRoom = room;
		this.arRooms[room].SetExplored();
	}
	
	public function GetCurrentRoom() : Number { return CurrentRoom; }
}