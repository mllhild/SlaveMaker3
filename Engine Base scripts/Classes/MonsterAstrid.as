// Astrid - class defining a monster
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterAstrid extends Monster {
		
	public function MonsterAstrid(attack:Number, defence:Number, health:Number, speed:Number, desc:String) { 
		super(attack, defence, health, speed, desc);
		
		_root.ShowPerson(16, 1, 2, 1);
	}
	public function CombatHitSound()
	{
		_root.Sounds.PlaySound("Clang");
	}
	public function ShowMonster()
	{
		_root.ShowPerson(16, 1, 2, 1);
	}
	public function HideMonster()
	{
		_root.HidePerson(16);
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		_root.AddText("Astrid who yells in pain. Oddly drops of cum appear at the end of her cock.");
	}
	public function Missed(weapon:Number, attack:Number) 
	{
		if (Math.floor(Math.random()*2) == 1) _root.AddText("she jumps back and you miss. Her cock bounces in a distracting way.");
		else _root.AddText("she parries you with her sword.");
	}	
	public function Attack() 
	{
		_root.SetText("Astrid swings her sword, and cock, at you ");

		var hita:Boolean = super.MonsterDoDamage(1, 0, 1, 1);
		if (hita) _root.AddText("and she cuts you painfully.");
		else _root.AddText("but you narrowly avoid her blow.");
		super.Attack();
	}
	public function FailedToRunAway() 
	{
	}
}