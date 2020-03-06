// MonsterTentacle - class defining a tentacle monster
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterTentacle extends Monster {
	
	public function MonsterTentacle(attack:Number, defence:Number, health:Number, speed:Number, desc:String, imageno:Object) { 
		super(attack, defence, health, speed, desc);
		
		if (imageno == undefined) image = Math.floor(Math.random()*3) + 1;
		else image = imageno
	}
	public function ShowMonster()
	{
		_root.ShowMonster("tentacle", 1, 1, image);
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		switch(weapon) {
			case 0:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) {
						_root.AddText("a tentacle.");
						_root.AddText(" You hear a girl cry out.");
					} else _root.AddText("its slimy, rubbery skin.");
					if (_root.SMData.Gender != 1) {
						_root.AddText(" You feel a slight sense of arousal at the touch of its skin.");
						_root.SMData.SMLust = _root.SMData.SMLust + 2;
					}
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("a tentacle which coils and tries to wrap around your leg.");
					else _root.AddText("its slimy underbelly.");
				}
				break;
			case 1:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText(" and a tentacle falls to the ground, severed.");
					else _root.AddText(" on its slimy underbelly.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("and skewer a tentacle.");
					else _root.AddText("and hit with a spray of ichor.");
				}
				break;
			case 2:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("and pin a tentacle to the wall.");
					else _root.AddText("and hit, but the arrow only penetrates shallowly.");
				} else {
					if (Math.floor(Math.random()*2) == 1) 	_root.AddText("and hit with every arrow, but only to shallow depths. It bleeds from all hits.");
					else _root.AddText("and hit deeply with one arrow.");
				}
				break;
			case 3:
				switch(attack) {
					case 0:
						_root.AddText("and maybe try to pull free a tentacle ");
						if (Math.floor(Math.random()*2) == 1) _root.AddText("and cause many painful cuts, oozing ichor.");
						else _root.AddText("and slice a tentacle the drops limp.");
						_root.AddText("\r\rYou 'accidentally' hit one of the girls held captive too.");
						break;
					case 1:
						if (Math.floor(Math.random()*2) == 1) _root.AddText("and to your delight it recoils in pain and quivers.");
						else _root.AddText("and several tentacles recoil and don't return.");
						_root.AddText("\r\rYou 'accidentally' hit one of the girls held captive too.");
						break;
					case 2:
						_root.AddText("and maybe try to pull free a tentacle ");
						if (Math.floor(Math.random()*2) == 1) _root.AddText("and cause many painful cuts, oozing ichor.");
						else _root.AddText("and slice a tentacle the drops limp.");
						break;
					case 3:
						if (Math.floor(Math.random()*2) == 1) _root.AddText("and it recoils in pain and quivers.");
						else _root.AddText("and several tentacles recoil and don't return.");
						break;
				}
				break;
			case 4:
				if (Math.floor(Math.random()*2) == 1) _root.AddText("and a flatten a tentacle.");
				else _root.AddText("on its head.");
				break;
			case 5:
				if (Math.floor(Math.random()*2) == 1) _root.AddText("and slice a tentacle clean off.");
				else _root.AddText("slash it's side.");
				break;
			case 6:
				if (Math.floor(Math.random()*2) == 1) _root.AddText("and a flay a tentacle.");
				else _root.AddText("and pin a tentacle.");
				break;
			case 7:
				if (Math.floor(Math.random()*2) == 1) _root.AddText("and pin a tentacle to the wall.");
				else _root.AddText("and hit, but the bolt only penetrates shallowly.");
				break;
		}
	}
	public function Missed(weapon:Number, attack:Number) 
	{
		switch(weapon) {
			case 0:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss as it slides to one side.");
					else _root.AddText("your fist slides between its tentacles.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss as it slides to one side.");
					else _root.AddText("your foot slides off its body.");
				}
				break;
			case 1:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) {
						_root.AddText("you pull your strike as you almost hit ");
						_root.AddText("a captive girl.");
					} else _root.AddText("but the blade merely slides along its rubbery skin.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("you miss the creature and narrowly miss a captive girl.");
					else _root.AddText("but fail the penetrate its thick skin.");
				}
				break;
			case 2:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("thing but you miss it.");
					else _root.AddText("thing but the arrow bounces off its rubbery skin.");
				} else {
					_root.AddText(", the thing is so large after all, but "); 
					if (Math.floor(Math.random()*2) == 1) _root.AddText("you miss with all the arrows.");
					else _root.AddText("the thing moves too much and you miss with some arrows and the rest bounce off its skin.");
				}
				break;
			case 3:
				switch(attack) {
					case 0:
						_root.AddText("and maybe try to pull free a tentacle ");
						if (Math.floor(Math.random()*2) == 1) 	_root.AddText("and to your delight it cries in pain but there seems to be little actual damage.");
						else _root.AddText("but you only hit a tentacle that recoils and is immediately replaced by another.");
						_root.AddText("\r\rYou 'accidentally' hit one of the girls held captive too.");
						break;
					case 1:
						if (Math.floor(Math.random()*2) == 1) _root.AddText("but the hit seems to have no effect on its thick slimy skin.");
						else _root.AddText("but you only hit some tentacles that recoils and is immediately replaced by others.");
						_root.AddText("\r\rYou 'accidentally' hit one of the girls held captive too.");
						break;
					case 2:
						_root.AddText("and maybe pull free a tentacle ");
						if (Math.floor(Math.random()*2) == 1) _root.AddText("but the hit seems to have no effect on its thick slimy skin.");
						else _root.AddText("but you only hit a tentacle that recoils and is immediately replaced by another.");
						break;
					case 3:
						if (Math.floor(Math.random()*2) == 1) _root.AddText("but the hit seems to have no effect on its thick slimy skin.");
						else _root.AddText("but you only hit some tentacles that recoils and is immediately replaced by others.");
						break;
				}
				break;
			case 4:
				if (Math.floor(Math.random()*2) == 1) {
					_root.AddText("you pull your strike as you almost hit ");
					_root.AddText("a captive girl.");
				} else _root.AddText("but the hammer merely bounces off its rubbery skin.");
				break;
			case 5:
				if (Math.floor(Math.random()*2) == 1) {
					_root.AddText("you pull your strike as you almost hit ");
					_root.AddText("a captive girl.");
				} else _root.AddText("but the blade merely bounces off its rubbery skin.");
				break;
			case 6:
				if (Math.floor(Math.random()*2) == 1) {
					_root.AddText("you pull your strike as you almost hit ");
					_root.AddText("a captive girl.");
				} else _root.AddText("but the dagger merely bounces off its rubbery skin.");
				break;
			case 7:
				if (Math.floor(Math.random()*2) == 1) {
					_root.AddText("you pull your crossbow to the side as you were almost about to hit ");
					_root.AddText("a captive girl.");
				} else _root.AddText("but the bolt merely bounces off its rubbery skin.");
				break;
		}
	}	
	public function Attack() 
	{
		if (Math.floor(Math.random()*100) < (_root.SMData.SMLust * 0.7)) {
			var hita:Boolean;
			if (_root.SMData.Gender != 1) hita = super.MonsterDoDamage(0, 0.2, 0.9, 1);
			else hita = super.MonsterDoDamage(0, 0.1, 0.9, 1);
			_root.CombatMonsterAttacks.Cum1._visible = true;
			_root.SetText("The creature pulls a tentacle from a girl's pussy and sprays an enormous gout of cum at you.\r\r");
			if (_root.SMData.Gender != 2 && _root.FirstArousalHit == false) {
				_root.AddText("Despite yourself you feel your cock become intensely erect. ");
				_root.FirstArousalHit = true;
			}
			if (hita) _root.AddText("You feel a wave of arousal as the cum splatters over you. Some gets on you face and in your eyes and you are delayed wiping it clear.");
			else _root.AddText("The spray misses you completely.");
			_root.AddText(" You notice the tentacle immediately thrusts back into the girl...");
	
		} else {
			_root.CombatMonsterAttacks.Tentacle1._visible = true;
			var hita:Boolean = super.MonsterDoDamage(1, 0.1, 1, 1);
			_root.SetText("The creature slices a tentacle with a sharp blade like end on it ");
			if (hita) _root.AddText("and it cuts into your flesh.");
			else _root.AddText("but you dodge to one side and are missed.");
		}
		super.Attack();
	}
	public function RunAway() 
	{
		_root.AddText(", leaving the girls to the rough attentions of the creatures");
	}
	public function FailedToRunAway() 
	{
		_root.AddText("tentacle wrap around your leg. You fall and hit your head and pass out.");
	}
}