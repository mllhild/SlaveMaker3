// House - a house, a collection of arFloors
// Translation status: COMPLETE

import Scripts.Classes.*;

class Scripts.Classes.HouseExplore {
	public var arFloors:Array;
	public var CurrentFloor:Floor;
	
	public function HouseExplore(arFloors:Number) { 
		this.arFloors = new Array();
	}
	public function Destroy()
	{
		for (var i:Number = 0; i < this.arFloors.length; i++) {
			var flr:Floor = this.arFloors[i];
			flr.Destroy();
			delete this.arFloors[i];
		}
		delete this.arFloors;
	}
	public function AddFloor(current:Boolean) : Floor { 
		this.arFloors.push(new Floor());
		this.arFloors[this.arFloors.length - 1].FloorNo = this.arFloors.length - 1;
		if (current == true) this.CurrentFloor = this.arFloors[this.arFloors.length - 1];
		return this.arFloors[this.arFloors.length - 1];
	}
	public function EnterFloor(floorno:Number) {
		this.CurrentFloor = this.arFloors[floorno];
	}
	public function EnterRoom(croom:Room)
	{
		if (croom.GetType() < 4) this.CurrentFloor.EnterRoom(croom);
		else {
			if (croom.GetType() == 4.1 || croom.GetType() == 5.1) {
			} else if (croom.GetType() == 4.2 || croom.GetType() == 5.2) {
			} else {
			}
		}
	}
	
	public function GetCurrentFloor() : Number
	{
		for (var i:Number = 0; i< this.arFloors.length; i++) {
			if (this.CurrentFloor == this.arFloors[i]) return i;
		}
		return -1;
	}
}