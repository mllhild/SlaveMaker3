class Monster
{
    var MonsterAttack, MonsterDefence, MonsterHealth, MonsterSpeed, MonsterDescription, MonsterTempDefence, MonsterNextAttack;
    function Monster(attack, defence, health, speed, desc)
    {
        if (_root.CombatDifficulty == 1)
        {
            attack = attack * 1.500000;
            defence = defence * 1.500000;
        }
        else if (_root.CombatDifficulty == 2)
        {
            attack = 500;
            defence = 500;
        } // end else if
        MonsterAttack = attack;
        MonsterDefence = defence;
        MonsterHealth = health;
        if (MonsterHealth > 100)
        {
            MonsterHealth = 100;
        } // end if
        MonsterSpeed = speed;
        MonsterDefence = defence;
        MonsterDefence = defence;
        MonsterDescription = desc;
        MonsterTempDefence = defence;
        MonsterNextAttack = speed;
    } // End of the function
    function ShowMonster()
    {
        _root.CombatCreatures._visible = true;
    } // End of the function
    function HideMonster()
    {
        _root.CombatCreatures._visible = false;
    } // End of the function
    function GetDescription()
    {
        return (MonsterDescription);
    } // End of the function
    function GetHealth()
    {
        return (MonsterHealth);
    } // End of the function
    function DamgeMonster(dmg, stun)
    {
        if (stun == true)
        {
            MonsterNextAttack = MonsterNextAttack + dmg;
        }
        else
        {
            MonsterHealth = MonsterHealth - dmg;
            if (MonsterHealth < 0)
            {
                MonsterHealth = 0;
            } // end if
        } // end else if
    } // End of the function
    function IsFighting()
    {
        return (MonsterHealth > 0);
    } // End of the function
    function CombatHitSound()
    {
        if (_root.SoundsOn)
        {
            _root.Sounds.SoundGrowlPained.gotoAndPlay(2);
        } // end if
    } // End of the function
    function MonsterDoDamage(damage, arousal, skill, defence, stun)
    {
        if (defence != undefined)
        {
            MonsterTempDefence = MonsterDefence * defence;
        } // end if
        if (Math.floor(Math.random() * 100) < MonsterAttack * skill)
        {
            if (stun)
            {
                _root.SMNextAttack = _root.SMNextAttack + 60;
            }
            else
            {
                var _loc3 = MonsterAttack * damage - _root.SMCurrentDefence + Math.floor(Math.random() * 5);
                if (_loc3 < 5)
                {
                    _loc3 = Math.floor(Math.random() * 4) + 2;
                } // end if
                if (_loc3 > 30)
                {
                    _loc3 = 30;
                } // end if
                _root.SMHealth = _root.SMHealth - _loc3;
                if (_root.SMHealth < 0)
                {
                    _root.SMHealth = 0;
                } // end if
                _root.SMLust = _root.SMLust + MonsterAttack * arousal;
                if (arousal > 0)
                {
                    _root.SMNextAttack = _root.SMNextAttack + 10;
                } // end if
                if (_loc3 > 30)
                {
                    _root.CombatHits.gotoAndStop(5);
                }
                else if (_loc3 > 0)
                {
                    _root.CombatHits.gotoAndStop(4);
                } // end else if
            } // end else if
            return (true);
        }
        else
        {
            if (Math.floor(Math.random() * 2) == 1)
            {
                _root.CombatMonsterAttacks.Miss1._visible = true;
            }
            else
            {
                _root.CombatMonsterAttacks.Miss2._visible = true;
            } // end else if
            return (false);
        } // end else if
    } // End of the function
    function Hit(weapon, attack)
    {
    } // End of the function
    function Missed(weapon, attack)
    {
    } // End of the function
    function Attack()
    {
        MonsterNextAttack = _root.CombatTime + MonsterSpeed;
    } // End of the function
    function RunAway()
    {
    } // End of the function
    function FailedToRunAway()
    {
    } // End of the function
    function ResetAttacks()
    {
    } // End of the function
} // End of Class
