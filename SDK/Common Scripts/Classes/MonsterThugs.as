// MonsterThugs - class defining a generic group of thugs or monsters
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterThugs extends Monster {
	
	public function MonsterThugs(attack:Number, defence:Number, health:Number, speed:Number, desc:String, imageo:Object) { 
		super(attack, defence, health, speed, desc);
		image = imageo;
	}
	public function CombatHitSound()
	{
		_root.Sounds.PlaySound("Sounds/Hurt1.mp3");
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		_root.AddText("and the #monster grunt in pain.");

	}
	public function Missed(weapon:Number, attack:Number) 
	{
		_root.AddText("they scatter and avoid you.");
	}	
	public function Attack() 
	{
		_root.CombatMonsterAttacks.Zombie._visible = true;
		var hita:Boolean = super.MonsterDoDamage(1, 0, 1, 1);
		_root.SetText("The #monster strike you ");
		if (hita) _root.AddText("and they clobber you hard.\r");
		else _root.AddText("but you dodge to one side and are missed.\r");
		super.Attack();
	}
	public function RunAway() 
	{
		_root.AddText(", fleeing the #monster");
	}
	public function FailedToRunAway() 
	{
		_root.AddText("something grabs around your leg. You fall and hit your head and pass out.");
	}
}