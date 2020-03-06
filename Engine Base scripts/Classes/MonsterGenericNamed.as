// MonsterGenericNamed - class defining a generic monster
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterGenericNamed extends Monster {
	
	public function MonsterGeneric(attack:Number, defence:Number, health:Number, speed:Number, desc:String, imagemc:Object, cg:Object) 
	{ 
		super(attack, defence, health, speed, desc, cg);
		image = imagemc;
	}
	public function CombatHitSound()
	{
		coreGame.Sounds.PlaySound("Hurt");
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		coreGame.AddText("and #monster roars in pain.");

	}
	public function Missed(weapon:Number, attack:Number) 
	{
		coreGame.AddText("#monster leaps to one side.");
	}	
	public function Attack() 
	{
		coreGame.CombatMonsterAttacks.Zombie._visible = true;
		var hita:Boolean = super.MonsterDoDamage(1, 0, 1, 1);
		coreGame.SetText("#monster claws at you ");
		if (hita) coreGame.AddText("and rakes deep cuts into your flesh.");
		else coreGame.AddText("but you dodge to one side and are missed.");
		super.Attack();
	}
	public function RunAway() 
	{
		coreGame.AddText(", fleeing #monster");
	}
	public function FailedToRunAway() 
	{
		coreGame.AddText("something grabs around your leg. You fall and hit your head and pass out.");
	}
}