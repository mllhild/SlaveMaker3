// DevilGirl - class defining a monster
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class MonsterDevilGirl extends Monster {
	
	public function MonsterDevilGirl(attack:Number, defence:Number, health:Number, speed:Number, desc:String, imageno:Object) { 
		super(attack, defence, health, speed, desc);
		if (imageno == undefined) image = Math.floor(Math.random()*(3 + _root.DickgirlOn)) + 1;
		else image = imageno;
	}
	public function ShowMonster()
	{
		_root.ShowMonster("devilgirl", 1, 1, image);
	}
	public function Hit(weapon:Number, attack:Number) 
	{
		switch(weapon) {
			case 0:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText(", she laughs and shakes her ass at you and suggests a spanking.");
					else _root.AddText(", she makes a cute, exaggerated little yelp of pain.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("who giggles and runs her hands along your leg.");
					else _root.AddText("who curses you with a smile.");
				}
				break;
			case 1:
				if (attack == 0) {
					_root.AddText("to the girl, ");
					if (Math.floor(Math.random()*2) == 1) _root.AddText("who cries in pain, but the wound vanishes immediately.");
					else _root.AddText("who moans and cries in apparent passion.");
				} else {
					_root.AddText("to the girl, ");
					if (Math.floor(Math.random()*2) == 1) _root.AddText("she yells as the blade sinks into her shoulder, but it leaves no wound.");
					else _root.AddText("who gasps from the blow almost passionately.");
				}
				break;
			case 2:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("she cries as the arrow slices her skin.");
					else _root.AddText("who gasps as she pulls the arrow free, leaving no apparent wound.");
				} else {
					_root.AddText(" at the girl ");
					if (Math.floor(Math.random()*2) == 1) _root.AddText("she cries as several arrows cut her. The wounds seem to instantly close.");
					else _root.AddText("who gasps as two arrows hit her. She pulls the arrow free, leaving no apparent wound and comments there are 'other' ways to double penetrate her.");
				}
				break;
			case 3:
				switch(attack) {
					case 0:
						_root.AddText("and the girl cries in ecstasy and says 'Mistress whip me more!'. She drops to the ground briefly either in pain or orgasm.");
						break;
					case 1:
						_root.AddText("and to your delight the girl cries in ecstasy and says 'Mistress whip me more!'. She drops to the ground for a time either in intense pain or strong orgasm, or both.");
						break;
					case 2:
						_root.AddText("and the girl cries in ecstasy and says 'Whip me more!'. She drops to the ground briefly either in pain or orgasm.");
						break;
					case 3:
						_root.AddText("and the girl cries in ecstasy and says 'Mistress whip me more!'. She drops to the ground for a time either in intense pain or strong orgasm, or both.");
						break;
				}
				break;
			case 4:
			case 5:
			case 6:
			case 7:
				_root.AddText("to the girl, who cries in pain, but dances back a little dazed. She pants, her chest heaving.");
				break;
		}
	}
	public function Missed(weapon:Number, attack:Number) 
	{
		switch(weapon) {
			case 0:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss as she dances to one side.");
					else _root.AddText("she grabs your fist and licks it.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("miss as she dances to one side.");
					else _root.AddText("she nimbly pushes your leg to one side.");
				}
				break;
			case 1:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("she leans to one side and the blade misses.");
					else _root.AddText("she impossibly leaps over your head, landing behind you with a giggle.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText("she seems to just push your blade to one side.");
					else _root.AddText("you cut her dress, exposing more of her skin. She offers to remove her dress entirely!");
				}
				break;
			case 2:
				if (attack == 0) {
					if (Math.floor(Math.random()*2) == 1) _root.AddText(", but she catches the arrow and drops it. She says there are 'other' things you could penetrate me with.");
					else _root.AddText(", but she leaps impossibly far and you miss.");
				} else {
					if (Math.floor(Math.random()*2) == 1) _root.AddText(", but she dances around and you miss with them all.");
					else _root.AddText(", but she seems the knock them all out of the air.");
				}
				break;
			case 3:
				switch(attack) {
					case 0:
						_root.AddText("and the girl and to your delight cries in ecstasy and says 'Mistress whip me more!', but she is otherwise unaffected.");
						break;
					case 1:
						_root.AddText(", but the girl cries in ecstasy and says 'Mistress whip me more!'.");
						break;
					case 2:
						_root.AddText("and the girl cries in ecstasy and says 'Whip me more!'.");
						break;
					case 3:
						_root.AddText(", but the girl cries in ecstasy and says 'Mistress whip me more!'.");
						break;
				}
				break;
			case 4:
			case 5:
			case 6:
			case 7:
				if (Math.floor(Math.random()*2) == 1) _root.AddText("she leans to one side and the hammer misses.");
				else _root.AddText("she impossibly leaps over your head, landing behind you with a giggle.");
				break;
		}
	}	
	public function CombatHitSound()
	{
		if (Math.floor(Math.random()*2) == 1) _root.Sounds.PlaySound("Giggle");
		else _root.Sounds.PlaySound("Ahhh");
	}
	public function Attack() 
	{
		if (Math.floor(Math.random()*100) < (_root.SMData.SMLust * 0.7)) {
			var hita:Boolean;
			if (_root.SMData.Gender == 1) hita = super.MonsterDoDamage(0, 0.25, 1, 1);
			else hita = super.MonsterDoDamage(0, 0.1, 1, 1);
			_root.CombatMonsterAttacks.DevilGirlKiss._visible = true;
			_root.SetText("The demon girl dances in and kisses you passionately and fondles you.\r\r");
			if (_root.SMData.Gender != 2 && _root.FirstArousalHit == false) {
				_root.AddText("Despite yourself you feel your cock become intensely erect. ");
				_root.FirstArousalHit = true;
			}
			if (hita) _root.AddText("You feel a wave of arousal from the kiss and her touch. You feel a little tired and confused and are delayed as you clear your head.");
			else _root.AddText("You focus and ignore the kiss and her touches.");
	
		} else {
			_root.CombatMonsterAttacks.DevilGirlStrike._visible = true;
			var hita:Boolean = super.MonsterDoDamage(0.9, 0.1, 1, 1);
			_root.SetText("The demon girl's fingernails grow to claws and she rakes you with them ");
			if (hita) _root.AddText("and her nails cut you painfully.");
			else _root.AddText("but you dodge to one side and are missed.");
		}
		super.Attack();
	}
	public function FailedToRunAway() 
	{
		_root.AddText("hand grab your shoulder and you stumble, hitting your head and pass out.");
	}
}