// Monster - class defining a monster
// Translation status: COMPLETE

import Scripts.Classes.*;

class Monster 
{
	private var MonsterAttack:Number;
	private var MonsterDefence:Number;
	private var MonsterHealth:Number;
	private var MonsterSpeed:Number;
	public var MonsterTempDefence:Number;
	public var MonsterNextAttack:Number;
	private var MonsterDescription:String;
	private var image:Object;
	
	private var coreGame:Object;
	
	public function Monster(attack:Number, defence:Number, health:Number, speed:Number, desc:String, cg:Object)
	{
		coreGame = cg == undefined ? _root : cg;
		if (coreGame.Options.CombatDifficulty == 1) {
			attack = attack * 1.5;
			defence = defence * 1.5;
		} else if (coreGame.Options.CombatDifficulty == 2) {
			attack = 500;
			defence = 500;
		}
		MonsterAttack = attack;
		MonsterDefence = defence;
		MonsterHealth = health;
		if (MonsterHealth > 100) MonsterHealth = 100;
		trace("Monster constructor: " + MonsterHealth + " " + health);
		MonsterSpeed = speed;
		MonsterDefence = defence;
		MonsterDefence = defence;
		MonsterDescription = desc;
		MonsterTempDefence = defence;
		MonsterNextAttack = speed;
		image = null;
	}
	
	public function ShowMonster() : Boolean
	{
		if (image == undefined) return false;
		switch(typeof(image)) {
			case "string": image = coreGame.AutoLoadImageAndShowMovie(String(image), 1, 1); return true;
			case "number": return false;
			case "movieclip": image._visible = true; return true;
		}
		var sNode:XMLNode = XMLNode(image);
		if (image.nodeName != "Show") return false;
		coreGame.XMLData.XMLEventByNode(sNode, false, undefined);
	}
	
	public function HideMonster() : Boolean
	{
		if (image == undefined) return false;
		switch(typeof(image)) {
			case "string": coreGame.HideImages(); return true;
			case "number": return false;
			case "movieclip": image._visible = false; return true;
		}
		var sNode:XMLNode = XMLNode(image);
		if (image.nodeName == "Show") coreGame.HideImages();
	}
	
	public function GetDescription() : String {	return MonsterDescription; }
	public function GetHealth() : Number { return MonsterHealth; }
	
	public function DamgeMonster(dmg:Number,  stun:Boolean)
	{
		if (stun == true) MonsterNextAttack = MonsterNextAttack + dmg;
		else {
			MonsterHealth = MonsterHealth - dmg;
			if (MonsterHealth < 0) MonsterHealth = 0;
		}
	}
	
	public function IsFighting() : Boolean { return MonsterHealth > 0; }
	public function CombatHitSound() { coreGame.Sounds.PlaySound("GrowlPained"); }
	
	private function MonsterDoDamage(damage:Number, arousal:Number, skill:Number, defence:Number, stun:Boolean) : Boolean
	{
		if (defence != undefined) MonsterTempDefence = MonsterDefence * defence;
		if (Math.floor(Math.random()*100) < (MonsterAttack * skill)) {
			// Hit!
			if (stun) coreGame.Combat.SMNextAttack = coreGame.Combat.SMNextAttack + 60;
			else {
				var dmg:Number = ((MonsterAttack * damage) - coreGame.Combat.SMCurrentDefence) + Math.floor(Math.random()*5);
				if (dmg < 5) dmg = Math.floor(Math.random()*4) + 2;
				if (dmg > 30) dmg = 30;
				coreGame.SMData.ChangeHealth(-1 * dmg);
				if (coreGame.SMData.SMAdvantages.CheckBitFlag(25)) coreGame.SMData.SMLust += dmg / 3;
				coreGame.SMData.SMLust = coreGame.SMData.SMLust + (MonsterAttack * arousal) * coreGame.SMData.ArousalDefence;;
				if (arousal > 0) coreGame.Combat.SMNextAttack += 10 * coreGame.SMData.ArousalDefence;
				if (dmg > 30) coreGame.CombatHits.gotoAndStop(5);
				else if (dmg > 0) coreGame.CombatHits.gotoAndStop(4);
			}
			return true;
		} else {
			// Miss!
			if (Math.floor(Math.random()*2) == 1) coreGame.CombatMonsterAttacks.Miss1._visible = true;
			else coreGame.CombatMonsterAttacks.Miss2._visible = true;
			return false;
		}
	}
	
	public function Hit(weapon:Number, attack:Number) { }
	public function Missed(weapon:Number, attack:Number) {	}
	
	public function Attack()
	{	
		MonsterNextAttack = coreGame.Combat.CombatTime + MonsterSpeed;
		coreGame.CombatMonsterAttacks.gotoAndPlay(1);
		coreGame.CombatMonsterAttacks._visible = true;
	}
	
	public function RunAway() {	}
	public function FailedToRunAway() {	}
	
	public function ResetAttacks() { }
}