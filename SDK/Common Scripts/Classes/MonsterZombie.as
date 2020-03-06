// MonsterZombie - class defining a zombie
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterZombie extends Monster {
	
	public function MonsterZombie(attack:Number, defence:Number, health:Number, speed:Number, desc:String, imageno:Object)
	{ 
		super(attack, defence, health, speed, desc);
		if (imageno == undefined) image = Math.floor(Math.random()*3) + 1;
		else image = imageno;
	}
	public function ShowMonster()
	{
		_root.ShowMonster("zombie", 1, 1, image);
	}
	public function DamgeMonster(dmg:Number, stun:Boolean)
	{
		if (stun == false) {
			this.MonsterHealth = this.MonsterHealth - dmg;
			if (this.MonsterHealth < 0) this.MonsterHealth = 0;
		}
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		switch(weapon) {
			case 0:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText(", it feels like you hit a tree.");
					else _root.AddText("and you feel a sickening eruption of decayed flesh.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText(", you hear crunching of dry flesh.");
					else _root.AddText("and you see dust and chunks of dry flesh fall.");
				}
				break;
			case 1:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("and the thing staggers.");
					else _root.AddText("and you see dust and chunks of dry flesh fall.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("and the thing slumps a little.");
					else _root.AddText("and you see dust and feel a snapping bone.");
				}
				break;
			case 2:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("and the arrow is stuck in the thing.");
					else _root.AddText("and the arrow passes through its body.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("and all the arrow stick in the thing.");
					else _root.AddText("and the arrow passes through its body. Chunks of its flesh fall to the ground.");
				}
				break;
			case 3:
				switch(attack) {
					case 0:
						_root.AddText("the zombie but to your disappointment it does not react.")
						break;
					case 1:
						_root.AddText("the zombie but to your disappointment it does not react.")
						break;
					case 2:
						_root.AddText("the zombie but to your disappointment it does not react.")
						break;
					case 3:
						_root.AddText("the zombie but to your disappointment it does not react.")
						break;
				}
				break;
			case 4:
			case 5:
			case 6:
			case 7:
				_root.AddText("and the thing staggers.");
				break;
		}
	}
	public function Missed(weapon:Number, attack:Number) 
	{
		switch(weapon) {
			case 0:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss it.");
					else _root.AddText("hit some decayed clothes and withered flesh to no effect.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss it.");
					else _root.AddText("hit some decayed clothes and withered flesh to no effect.");
				}
				break;
			case 1:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss.");
					else _root.AddText("slice off some decayed flesh, the zombie does not even notice you.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("zombie.");
					else _root.AddText("the blade passes ineffectually through dry skin.");
				}
				break;
			case 2:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("but miss.");
					else _root.AddText("but the arrow seems to pass through dry skin and clothes.");
				} else {
					_root.AddText("but miss.");
				}
				break;
			case 3:
				_root.AddText("the zombie but it does not react.");
				break;
			case 4:
			case 5:
			case 6:
			case 7:
				if (Math.floor(Math.random()*2) == 1) _root.AddText("miss.");
				else _root.AddText("there is a cloud of dust, and the zombie does not even notice you.");
				break;
		}
	}	
	public function Attack() 
	{
		_root.CombatMonsterAttacks.Zombie._visible = true;
		var hita:Boolean = super.MonsterDoDamage(1, 0, 1, 1);
		_root.SetText("The zombie paws and grabs at you ");
		if (hita) _root.AddText("and you are dealt painful blows.")
		else _root.AddText("but you dodge to one side and are missed.");
		super.Attack();
	}
	public function FailedToRunAway() 
	{
		_root.AddText("hand grab your shoulder and you stumble, hitting your head and pass out.");
	}
}