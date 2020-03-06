// Ayane - class defining a monster
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterAyane extends Monster {
	
	private var Armed:Boolean;
	
	public function MonsterAyane(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Number) { 
		super(attack, defence, health, speed, desc);
		if (image == undefined) image = 4;
		_root.SlaveGirl.mcBase.EventEscape.gotoAndStop(image);
		Armed = (image == 4);
		_root.SlaveGirl.mcBase.EventEscape._visible = true;
	}
	public function ShowMonster()
	{
		_root.SlaveGirl.mcBase.EventEscape._visible = true;
	}
	public function HideMonster()
	{
		_root.SlaveGirl.mcBase.EventEscape._visible = false;
	}
	public function CombatHitSound()
	{
		_root.Sounds.PlaySound("Ahhh");
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		_root.AddText(_root.SlaveName + " responds little to your blow.");
	}
	public function Missed(weapon:Number, attack:Number) 
	{
		if (int(Math.random()*2) == 1) _root.AddText("she leans to one side and you miss.");
		else _root.AddText("she impossibly leaps over your head, landing behind you.");
	}	
	public function Attack() 
	{
		if (Armed) {
			_root.SlaveGirl.mcBase.CombatAyaneAttack.Knife._visible = true;
			_root.SetText(_root.SlaveName + " slices shallowly at you with her knife ");
		} else {
			_root.SlaveGirl.mcBase.CombatAyaneAttack.Punch._visible = true;
			_root.SetText(_root.SlaveName + " punches at you ");
		}
		var hita:Boolean = super.MonsterDoDamage(1, 0, 1, 1);
		if (hita) _root.AddText("and she slices you skin.");
		else _root.AddText("but you dodge to one side and are missed.");
		super.Attack();
	}
	public function FailedToRunAway() 
	{
	}
	public function ResetAttacks() 
	{
		_root.SlaveGirl.mcBase.CombatAyaneAttack.Knife._visible = false;
		_root.SlaveGirl.mcBase.CombatAyaneAttack.Punch._visible = false;
	}
}