class MonsterTaki extends Monster
{
    var mc, playerMoved, power, MonsterSpeed, MonsterNextAttack;
    function MonsterTaki(attack, defence, health, speed, desc, base)
    {
        super(attack, defence, health, speed, desc);
        mc = base;
        playerMoved = false;
    } // End of the function
    function ShowMonster()
    {
        _root.ShowMovie(mc, 1, 1, 1);
    } // End of the function
    function HideMonster()
    {
        mc.removeMovieClip();
    } // End of the function
    function CombatHitSound()
    {
        if (_root.SoundsOn)
        {
            _root.Sounds.SoundClang.gotoAndPlay(2);
        } // end if
    } // End of the function
    function Hit(weapon, attack)
    {
        playerMoved = true;
        _root.AddText("Taki recoils in pain as you hit her, yet she only seems more determined.");
    } // End of the function
    function Missed(weapon, attack)
    {
        playerMoved = true;
        if (Math.floor(Math.random() * 2) == 1)
        {
            _root.AddText("Taki sommersaults out of the range of your blow.");
        }
        else
        {
            _root.AddText("Taki blocks you with her own weapon.");
        } // end else if
    } // End of the function
    function Attack()
    {
        if (power && playerMoved)
        {
            _root.SetText("Taki brings her sword down on you with all of her power. The blade hits you sapping all of your strength.");
            power = false;
            _root.SMHealth = 0;
        }
        else if (power)
        {
            _root.SetText("Taki takes advantage of her speed over you. She kicks you in the abdomen causing you to reel over, in perfect position to launch a finishing blow.");
        }
        else if (Math.random() <= 0.300000)
        {
            _root.SetText("Taki strikes out at you with her sword ");
            var _loc4 = super.MonsterDoDamage(1, 0, 1, 1);
            if (_loc4)
            {
                _root.AddText("and she hits your exposed flesh. The sword does not cut, but sapes your strength.");
            }
            else
            {
                _root.AddText("but you narrowly avoid her blow.");
            } // end else if
        }
        else
        {
            _root.SetText("Taki begins whirling her sword over her head concentrating her strength into her next attack.");
            power = true;
        } // end else if
        playerMoved = false;
        MonsterNextAttack = _root.CombatTime + MonsterSpeed;
        _root.CombatMonsterAttacks.gotoAndPlay(1);
        _root.CombatMonsterAttacks._visible = true;
    } // End of the function
    function FailedToRunAway()
    {
        _root.SetText("You start backing away from the guard.");
        _root.DoEvent(10265);
    } // End of the function
    function ResetAttacks()
    {
    } // End of the function
    function resetPower()
    {
        if (power)
        {
            _root.SetText("You lunge out of her range as she brings down her blade in the space you used to occupy.");
            power = false;
            _root.DoEvent(3000);
        } // end if
    } // End of the function
    function getPower()
    {
        return (power);
    } // End of the function
} // End of Class
