// GameCombat - combats
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class GameCombat extends DialogBase
{
	public var CombatTime:Number;		// current time of the combat
	
	public var Hit:Boolean;				// did the last attack hit?
	public var FirstArousalHit:Boolean;	// has the moster hit your slave maker using a lust based attack
	
	private var SMCurrentAttack:Number;			// attack value as modified by weapons/armour
	
	private var SMCurrentDefence:Number;		// defence as modified by weapons or armour
	private var SMTempDefence:Number;			// defences as altered by monster attacks, resets every Slave Maker attack
	
	private var SMSpeed:Number;			// Base speed of slave maker attacks
	public var SMNextAttack:Number;		// Speed for current attack, changable by monster attacks (stunning)
		
	private var strCombatStartMsg:String;
	
	private var arMonsterArray:Array;	// All mosters in the battle
	private var CurrentMonster:Number;	// the index in the array of the monster currently attacking

	// Win/Lose events for the combat
	private var evtWin:Object;
	private var evtLose:Object;
	private var evtRunaway:Object;
	private var evtLoseLust:Object;
	
	// references for movieclips in the combat, mcBase points to the statics clip CombatStatistics
	private var CombatSMAttack:MovieClip;
	private var CombatMonsterAttacks:MovieClip;
	private var CombatHits:MovieClip;
	
	var XMLData:Object;		// XML class reference
	
	// Constructor
	public function GameCombat(cg:Object)
	{ 
		super(cg.CombatStatistics, cg);
		
		CombatSMAttack = cg.CombatSMAttack;
		CombatMonsterAttacks = cg.CombatMonsterAttacks;
		CombatHits = cg.CombatHits;
		
		CombatSMAttack.gotoAndStop(1);
		CombatMonsterAttacks.gotoAndStop(1);
		CombatHits.gotoAndStop(1);
		
		XMLData = Language.XMLData;
	}

	
	// Fight a combat
	
	public function InitialiseCombat(startmsg:String, runawayevent:Object, winevent:Object, loseeventhurt:Object, loseeventaroused:Object, sethealth:Boolean)
	{
		// initialise
		InitialiseModule();
		
		strCombatStartMsg = startmsg;
		
		evtWin = winevent;
		evtRunaway = runawayevent;
		evtLose = loseeventhurt;
		evtLoseLust = loseeventaroused;
		
		delete arMonsterArray;
		arMonsterArray = new Array();
		
		SMCurrentAttack = SMData.SMAttack / 1.5;
		SMCurrentDefence = SMData.SMDefence / 1.5;
		SMSpeed = 45;
		
		// Armour effects
		var iNode:XMLNode = SMData.FindArmourNodeCByNumber(SMData.ArmourType);
		SMCurrentDefence += XMLData.GetXMLValueParsed("Protection", iNode);
		SMSpeed -= XMLData.GetXMLValueParsed("SpeedBonus", iNode);
	
		// Weapon effects
		iNode = SMData.FindWeaponNodeCByNumber(SMData.WeaponType);
		SMCurrentAttack += XMLData.GetXMLValueParsed("DamageBonus", iNode) + SMData.GetWeaponSkill();
		SMSpeed -= XMLData.GetXMLValueParsed("SpeedBonus", iNode);
		if (SMSpeed < 10) SMSpeed = 10;
		
		// global effects
		if (SMCurrentAttack > 100) SMCurrentAttack = 100;
		if (SMCurrentDefence > 100) SMCurrentDefence = 100;
		SMTempDefence = SMCurrentDefence;
		SMNextAttack = SMSpeed;
		if (sethealth == true) SMData.SetHealth();
		trace("health = " + coreGame.SMHealth);
		CurrentMonster = 0;
	}	
	
	public function AddMonster(newmonster:Monster)
	{
		arMonsterArray.push(newmonster);
	}
	
	public function AddMonsterTentacle(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object)
	{
		AddMonster(new MonsterTentacle(attack, defence, health, speed, desc, image));
	}
	
	public function AddMonsterZombie(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object)
	{
		AddMonster(new MonsterZombie(attack, defence, health, speed, desc, image));
	}
	
	public function AddMonsterDevilGirl(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object)
	{
		AddMonster(new MonsterDevilGirl(attack, defence, health, speed, desc, image));
	}
	
	public function AddMonsterAstrid(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object)
	{
		AddMonster(new MonsterAstrid(attack, defence, health, speed, desc));
	}
	
	public function AddMonsterGeneric(attack:Number, defence:Number, health:Number, speed:Number, desc:String, mc:Object)
	{
		AddMonster(new MonsterGeneric(attack, defence, health, speed, desc, mc));
	}

	public function AddMonsterGenericNamed(attack:Number, defence:Number, health:Number, speed:Number, desc:String, mc:Object)
	{
		AddMonster(new MonsterGenericNamed(attack, defence, health, speed, desc, mc));
	}	
	
	public function AddMonsterThugs(attack:Number, defence:Number, health:Number, speed:Number, desc:String, mc:Object)
	{
		AddMonster(new MonsterThugs(attack, defence, health, speed, desc, mc));
	}
	
	public function CombatHitSound(monster:Boolean)
	{
		if (Hit) arMonsterArray[CurrentMonster].CombatHitSound();
		else {
			if (SMData.WeaponType == 0) PlaySound("Punch");
			else PlaySound("Miss");
		}
	}
	
	public function UpdateCombatStats()
	{
		mcBase.HealthBar._xscale = 30 * SMData.GetHealth();
		mcBase.ArousalBar._xscale = 30 * SMData.SMLust;
		mcBase.MonsterHealthBar._width = 350 * (arMonsterArray[CurrentMonster].GetHealth() / 100);
		mcBase.CreatureName.text = arMonsterArray[CurrentMonster].GetDescription() + ":";
	}
	
	public function ResetSMAttacks()
	{
		SMTempDefence = SMCurrentDefence;
		coreGame.HideQuestions();
		CombatHits._visible = false;
		CombatSMAttack.gotoAndStop(1);
		CombatSMAttack.Unarmed1._visible = false;
		CombatSMAttack.Sword1._visible = false;
		CombatSMAttack.Sword2._visible = false;
		CombatSMAttack.Whip1._visible = false;
		CombatSMAttack.Bow1._visible = false;
		CombatSMAttack.Miss1._visible = false;
		CombatSMAttack.Miss2._visible = false;
	}
	
	public function ResetMonsterAttacks()
	{
		coreGame.HideQuestions();
		CombatHits._visible = false;
		CombatMonsterAttacks.gotoAndStop(1);
		CombatMonsterAttacks.Cum1._visible = false;
		CombatMonsterAttacks.Tentacle1._visible = false;
		CombatMonsterAttacks.DevilGirlStrike._visible = false;
		CombatMonsterAttacks.DevilGirlKiss._visible = false;
		CombatMonsterAttacks.Zombie._visible = false;
		CombatMonsterAttacks.Miss1._visible = false;
		CombatMonsterAttacks.Miss2._visible = false;
		arMonsterArray[CurrentMonster].ResetAttacks();
	}
	
	public function SetCombatTime(num:Number) { CombatTime = num; coreGame.CombatTime = num; }
	
	private function SlaveMakerDoDamage(damage:Number, skill:Number, defence:Number, stun:Boolean) : Boolean
	{
		if (defence != undefined) SMTempDefence = SMCurrentDefence * defence;
		if (Math.floor(Math.random()*100) <= (SMCurrentAttack * skill)) {
			if (SMData.GetWeaponClass() == "whip") PlaySound("WhipCrack");
			if (stun) {
				arMonsterArray[CurrentMonster].DamgeMonster(60, true);
			} else {
				var dmg:Number = ((SMCurrentAttack * damage) - arMonsterArray[CurrentMonster].MonsterTempDefence) + Math.floor(Math.random()*5);
				if (dmg < 5) dmg = Math.floor(Math.random()*4) + 2;
				if (dmg > 30) dmg = 30;
				arMonsterArray[CurrentMonster].DamgeMonster(dmg, false);
				if (dmg > 20) CombatHits.gotoAndStop(3);
				else if (dmg > 10) CombatHits.gotoAndStop(2);
				else CombatHits.gotoAndStop(1);
				SMTRACE("Slave Maker Does Damage = " + dmg);
				UpdateCombatStats();
			}
			Hit = true;
		} else {
			if (Math.floor(Math.random()*2) == 1) CombatSMAttack.Miss1._visible = true;
			else CombatSMAttack.Miss2._visible = true;
			Hit = false;
		}
		SMNextAttack = CombatTime + SMSpeed;
		CombatSMAttack.gotoAndPlay(1);
		CombatSMAttack._visible = true;
		return Hit;
	}	

	public function CombatEvent(eventno:Number)
	{
		switch(eventno) {
			case 3000:
				// Starting event for the combat
				SetText(strCombatStartMsg + "\r\r");
				coreGame.HideImages();
				coreGame.NextEvent._visible = false;
				FirstArousalHit = false;
				arMonsterArray[CurrentMonster].ShowMonster();
				SetCombatTime(0);
				coreGame.Icons.Hide();
				UpdateCombatStats();
				mcBase._visible = true;
				eventno = 3100;
				break;
			case 3001:
				SetText("You step in and punch at the #monster's body ");
				ResetSMAttacks()
				CombatSMAttack.Unarmed1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				if (Hit) {
					if (Math.floor(Math.random()*2) == 1) AddText("and solidly hit ");
					else AddText("and your fist connects with ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					AddText("but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				UpdateCombatStats();
				return;
			case 3002:
				ResetSMAttacks();
				CombatSMAttack.Unarmed1._visible = true;
				SlaveMakerDoDamage(1.2, 1, 0.8);
				SetText("You step in and kick the #monster");
				AddText("'s body ");
				if (Hit) {
					if (Math.floor(Math.random()*2) == 1) AddText("and solidly hit ");
					else AddText("and your foot sinks in ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 1);
				} else {
					AddText("but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 1);
				}
				return;
			case 3003:
				ResetSMAttacks();
				CombatSMAttack.Sword1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				SetText("You slash your sword at the #monster");
				if (Hit) {
					if (Math.floor(Math.random()*2) == 1) AddText(" and deal a deep cut ");
					else AddText(" and cut several shallow cuts ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					AddText(" but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
			case 3004:
				ResetSMAttacks();
				CombatSMAttack.Sword2._visible = true;
				SlaveMakerDoDamage(1.4, 0.8, 0.8);
				SetText("You lunge in to do a deep penetrating wound into a vital location ");
				if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 1);
				else {
					AddText("but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 1);
				}
				return;
			case 3005:
				ResetSMAttacks();
				CombatSMAttack.Bow1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				SetText("You fire a carefully aimed arrow at the #monster ");
				if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				else arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				return;
			case 3006:
				ResetSMAttacks();
				CombatSMAttack.Bow1._visible = true;
				SlaveMakerDoDamage(1.5, 0.6, 1);
				SetText("You fire several arrows with little aiming at the #monster ");
				if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 1);
				else  arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 1);
				return;
			case 3007:
				ResetSMAttacks();
				CombatSMAttack.Whip1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				if (SMData.IsDominatrix()) {
					SetText("With long experience you gleefully lash ");
					if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
					else arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
					if (SMData.SMLust < 75) SMData.SMLust = SMData.SMLust + 1;
					UpdateCombatStats();
	
				} else {
					SetText("You lash, trying to cause pain and injury ");
					if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 2);
					else arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 2);
				}
				return;
			case 3008:
				ResetSMAttacks();
				CombatSMAttack.Whip1._visible = true;
				if (SMData.IsDominatrix()) {
					SlaveMakerDoDamage(1, 1.3, 1, true);
					SetText("With long experience you gleefully lash trying to cause as much pain as possible ");
					if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 1);
					else arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 1);
					if (SMData.SMLust < 75) SMData.SMLust = SMData.SMLust + 1;
					UpdateCombatStats();
	
				} else {
					SlaveMakerDoDamage(1, 1, 1, true);
					SetText("You lash several times trying to cause intense pain ");
					if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 3);
					else arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 3);
				}
				return;
			case 3009:
				ResetSMAttacks();
				CombatSMAttack.Sword1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				SetText("You swing the hammer at the #monster");
				if (Hit) {
					AddText(" and deal a crushing blow ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					AddText(" but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
			case 3010:
				ResetSMAttacks();
				CombatSMAttack.Sword1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				SetText("You slash the naginata the #monster");
				if (Hit) {
					AddText(" and deal a deep cut ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					AddText(" but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
			case 3011:
				ResetSMAttacks();
				CombatSMAttack.Sword1._visible = true;
				SlaveMakerDoDamage(1.2, 1, 0.8);
				SetText("You slice repeated at #monster");
				if (Hit) {
					AddText(" and deal many cuts ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					AddText(" but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
			case 3012:
				ResetSMAttacks();
				CombatSMAttack.Sword1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				SetText("You slice and stab the #monster");
				if (Hit) {
					AddText(" and sink the dagger in to the hilt ");
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					AddText(" but ");
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
			case 3013:
				ResetSMAttacks();
				CombatSMAttack.Bow1._visible = true;
				SlaveMakerDoDamage(1, 1, 1);
				SetText("You fire an aimed bolt at the #monster ");
				if (Hit) arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				else arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				return;
				
			case 3190:
				ResetSMAttacks();
				var iNode:XMLNode = SMData.FindWeaponNodeCByNumber(SMData.WeaponType);
				var aNode:XMLNode = XMLData.GetNodeC(iNode, "Attack1");
	
				var pdmg:Number = XMLData.GetXMLValueParsed("PhysicalDamage", aNode, 1);
				var stundmg:Number = XMLData.GetXMLValueParsed("StunDamage", aNode, 0);
				var skillp:Number = XMLData.GetXMLValueParsed("AttackModifier", aNode, 1);
				var defencep:Number = XMLData.GetXMLValueParsed("DefenceModifier", aNode, 1);
				SlaveMakerDoDamage(pdmg, skillp, defencep, stundmg > 0);
				
				CombatSMAttack.Sword1._visible = true;
				if (Hit) {
					SetText("You hit #monster with your #weapon");
					if (!XMLData.XMLEventByNode(XMLData.GetNode(aNode, "MonsterHit"), true, undefined, false, true)) XMLData.XMLEventByNode(XMLData.GetNode("Combat", "MonsterHit"), true, undefined, false, true)
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					SetText("You miss #monster with your #weapon");
					if (!XMLData.XMLData.XMLEventByNode(XMLData.GetNode(aNode, "MonsterMissed"), true, undefined, false, true)) XMLData.XMLEventByNode(XMLData.GetNode("Combat", "MonsterMissed"), true, undefined, false, true)
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
			case 3191:
				ResetSMAttacks();
				var iNode:XMLNode = SMData.FindWeaponNodeCByNumber(SMData.WeaponType);
				var aNode:XMLNode = XMLData.GetNodeC(iNode, "Attack1");
	
				var pdmg:Number = XMLData.GetXMLValueParsed("PhysicalDamage", aNode, 1.4);
				var stundmg:Number = XMLData.GetXMLValueParsed("StunDamage", aNode, 0);
				var skillp:Number = XMLData.GetXMLValueParsed("AttackModifier", aNode, 0.8);
				var defencep:Number = XMLData.GetXMLValueParsed("DefenceModifier", aNode, 0.8);
				SlaveMakerDoDamage(pdmg, skillp, defencep, stundmg > 0);
				
				CombatSMAttack.Sword1._visible = true;
				if (Hit) {
					SetText("You hit #monster with your #weapon ");
					if (!XMLData.XMLEventByNode(XMLData.GetNode(aNode, "MonsterHit"), true, undefined, false, true)) XMLData.XMLEventByNode(XMLData.GetNode("Combat", "MonsterHit"), true, undefined, false, true)
					arMonsterArray[CurrentMonster].Hit(SMData.WeaponType, 0);
				} else {
					SetText("You miss #monster with your #weapon ");
					if (!XMLData.XMLEventByNode(XMLData.GetNode(aNode, "MonsterMissed"), true, undefined, false, true)) XMLData.XMLEventByNode(XMLData.GetNode("Combat", "MonsterMissed"), true, undefined, false, true)
					arMonsterArray[CurrentMonster].Missed(SMData.WeaponType, 0);
				}
				return;
	
			case 3199:
				ResetSMAttacks();
				SMTempDefence = SMTempDefence / 2;
				CombatSMAttack.Sword1._visible = true;
				SlaveMakerDoDamage(0, -1, 1, true);
				Language.SetLangText("Defending", "Combat");
				BlankLine();
				return;
			case 3200:
				ResetSMAttacks();
				ResetMonsterAttacks();
				mcBase._visible = false;
				arMonsterArray[CurrentMonster].HideMonster();
				coreGame.Icons.Show();
				CombatHits._visible = false;
				CombatMonsterAttacks._visible = false;
				if (Math.floor(Math.random()*100) < SMCurrentDefence) {
					AddText("You break free and run from the #monster");
					arMonsterArray[CurrentMonster].RunAway();
					AddText(".");
					coreGame.DoEventNext(evtRunaway);
				} else {
					AddText("You decide you cannot win and break free and start running and feel a ");
					arMonsterArray[CurrentMonster].FailedToRunAway();
					coreGame.DoEventNext(evtLose);
				}
				return;
		}
		
		// Vistory conditions
		trace("coreGame.Options.CombatDifficulty = " + coreGame.Options.CombatDifficulty);
		var bIsFighting:Boolean = false;
		for (var i:Number = 0; i < arMonsterArray.length; i++) {
			trace("MonsterHealth: " + arMonsterArray[i].MonsterHealth);
			trace("IsFighting(): " + arMonsterArray[i].IsFighting());
			if (arMonsterArray[i].IsFighting()) bIsFighting = true;
		}
		if (coreGame.Options.CombatDifficulty == -1 || (!bIsFighting)) {
			// All monsters defeated
			SMTRACE("won: " + String(evtWin));
			ResetSMAttacks();
			ResetMonsterAttacks();
			mcBase._visible = false;
			arMonsterArray[CurrentMonster].HideMonster();
			coreGame.Icons.Show();
			CombatMonsterAttacks._visible = false;
			CombatHits._visible = false;
			coreGame.DoEventNext(evtWin);
			return;
		}
		if (SMData.GetHealth() <= 0) {
			// SlaveMaker beaten via dmamge
			SMTRACE("lost damage: " + evtLose + " " + evtLose.parentNode);
			ResetSMAttacks();
			ResetMonsterAttacks();
			mcBase._visible = false;
			arMonsterArray[CurrentMonster].HideMonster();
			coreGame.Icons.Show();
			CombatMonsterAttacks._visible = false;
			CombatHits._visible = false;
			coreGame.DoEventNext(evtLose);
			trace("Events: " + coreGame.StrEvent + coreGame.NumEvent);
			return;
		}
		if (SMData.SMLust >= 100 && Number(evtLoseLust) != 0) {
			// Slave Makers beated via lust
			SMTRACE("lost luct: " + evtLoseLust.parentNode);
			ResetSMAttacks();
			ResetMonsterAttacks();
			mcBase._visible = false;
			arMonsterArray[CurrentMonster].HideMonster();
			coreGame.dspMain.Icons.Show();
			CombatMonsterAttacks._visible = false;
			CombatHits._visible = false;
			coreGame.DoEventNext(evtLoseLust);
			return;
		}
		
		// Time passes, who is next to attack
		if (eventno == 3100) {
			var nextact:Number = SMNextAttack;
			var cmon:Number = -1;
			for (var i:Number = 0; i < arMonsterArray.length; i++) {
				SMTRACE("arMonsterArray[i].MonsterNextAttack = " + arMonsterArray[i].MonsterNextAttack);
				if (arMonsterArray[i].MonsterNextAttack < nextact) {
					nextact = arMonsterArray[i].MonsterNextAttack;
					cmon = i;
				}
			}
			if (cmon != -1) {
				// A monster attacks
				ResetMonsterAttacks();
				CurrentMonster = cmon;
				SMTRACE("monster attack " + arMonsterArray[CurrentMonster].MonsterNextAttack);
				SetCombatTime(arMonsterArray[CurrentMonster].MonsterNextAttack);
				arMonsterArray[CurrentMonster].Attack();
				UpdateCombatStats();
				return;
			}
		}
		
		// Slave Maker attacks
		SetCombatTime(SMNextAttack);
		var runmsg:Number = Number(evtRunaway) == 0 ? 0 : 3200;
		if (coreGame.modulesList.ShowAttackChoices(runmsg) == true) return;
		
		var iNode:XMLNode = SMData.FindWeaponNodeCByNumber(SMData.WeaponType);
		var aNode:XMLNode = XMLData.GetNodeC(iNode, "Attack1");
		var at1:String = XMLData.GetXMLStringParsed("Name", aNode);
		var aev1:Object = XMLData.GetXMLStringParsed("Event", aNode);
		if (!isNaN(aev1)) aev1 = Number(aev1);
		else if (aev1 == "") {
			aev1 = 3190;
			var wtype:String = XMLData.GetXMLStringParsed("Type", iNode).toLowerCase();
			switch (wtype) {
				case "unarmed": aev1 = 3001; break;
				case "sword": aev1 = 3003; break;
				case "bow": aev1 = 3005; break;
				case "whip": aev1 = 3007; break;
				case "hammer": aev1 = 3009; break;
				case "naginata": aev1 = 3010; break;
				case "dagger": aev1 = 3012; break;
				case "crossbow": aev1 = 3013; break;
			}
		}
		
		var at2:String = "";
		var aev2:Object = "";
		aNode = XMLData.GetNodeC(iNode, "Attack2");
		if (aNode != null) {
			at2 = XMLData.GetXMLStringParsed("Name", aNode);
			aev2 = XMLData.GetXMLStringParsed("Event", aNode);
		}
		if (!isNaN(aev2)) aev2 = Number(aev2);
		if (at2 != "" && String(aev2) == "") {
			aev2 = 3191;
			var wtype:String = XMLData.GetXMLStringParsed("Type", iNode).toLowerCase();
			switch (wtype) {
				case "unarmed": aev2 = 3002; break;
				case "sword": aev2 = 3004; break;
				case "bow": aev2 = 3006; break;
				case "whip": aev2 = 3008; break;
				case "naginata": aev2 = 3011; break;
			}
		}
		
		var atq:String = XMLData.GetXMLStringParsed("AttackQuestion", iNode);
	
		if (String(aev2) != "") AskHerQuestions(aev1, aev2, 3199, runmsg, at1, at2, Language.GetText("Defend", "Combat"), Language.GetText("RunAway", "Combat"), atq);
		else AskHerQuestions(aev1, 3199, runmsg, 0, at1, Language.GetText("Defend", "Combat"), Language.GetText("RunAway", "Combat"), "", atq);
	
	}

	
	// XML
	public function ParseGetCombatDetails(str:String) : Object
	{
		if (str == "monster") return arMonsterArray[CurrentMonster].GetDescription();
		if (str == "hitmonster") return Hit ? 1 : 0;
		
		return undefined;
	}

	/*
	<Combat resethealth="true">
		<Start>Start combat!</Start>
		<RunawayEvent>oops1</RunawayEvent>
		<WinEvent>oops2</WinEvent>
		<LoseDamage>oops3</LoseDamage>
		<LoseLust>oops4</LoseLust>
		<Monsters>
			<Tentacles attack="50" defence="50" health="50" speed="60" desc="Tentacle Beast" image="1"/>
		</Monsters>
	</Combat>
	*/
	public function ParseCombat(cNode:XMLNode)
	{
		if (coreGame.WalkPlace == 0) XMLData.lastNode = cNode.parentNode.parentNode.firstChild;
		var str:String;
		var winevent:Object = new Number(0);
		var runawayevent:Object = new Number(0);
		var losehurtevent:Object = new Number(0);
		var loselustevent:Object = new Number(0);
		var reseth:Boolean = true;
		var startmsg:String = "";
		var startnow:Boolean = false;
		var bonusattack:Number = 0;
		var bonusdefence:Number = 0;
		for (var attr:String in cNode.attributes) {
			if (attr.toLowerCase() == "resethealth") reseth = cNode.attributes[attr].toLowerCase() == "true"
			else if (attr.toLowerCase() == "startnow") startnow = cNode.attributes[attr].toLowerCase() == "true"
		}
		
		var mNode:XMLNode = null;
		var shNode:XMLNode = null;
		for (var aNode:XMLNode = cNode.firstChild; aNode != null; aNode = aNode.nextSibling) {
			str = aNode.nodeName.toLowerCase();
			if (str == "winevent") winevent = XMLData.GetEventToPerform(aNode);
			else if (str == "runawayevent") runawayevent = XMLData.GetEventToPerform(aNode);
			else if (str == "losedamageevent") losehurtevent = XMLData.GetEventToPerform(aNode);
			else if (str == "loselustevent") loselustevent = XMLData.GetEventToPerform(aNode);
			else if (str == "startmessage") startmsg = XMLData.GetXMLStringParsed("", aNode);
			else if (str == "monsters") mNode = aNode;
			else if (str == "show") shNode = aNode;
			else if (str == "bonusattack") bonusattack = XMLData.GetExpression(aNode.firstChild.nodeValue);
			else if (str == "bonusdefence") bonusdefence = XMLData.GetExpression(aNode.firstChild.nodeValue);
		}
		if (mNode == null) return;
		if (Number(loselustevent) == 0) loselustevent = losehurtevent;
		trace("reseth = " + reseth);
		InitialiseCombat(startmsg, runawayevent, winevent, losehurtevent, loselustevent, reseth);
		if (bonusattack > 0) SMCurrentAttack += bonusattack;
		if (bonusdefence > 0) SMCurrentDefence += bonusdefence;
		
		// Individual monsters
		for (var aNode:XMLNode = mNode.firstChild; aNode != null; aNode = aNode.nextSibling) {
			str = aNode.nodeName.toLowerCase();
	
			var attack:Number = 60;
			var defence:Number = 40;
			var health:Number = 50;
			var speed:Number = 55;
			var desc:String = "";
			var image:String = "";
			var shNodeThis = shNode;
			
			for (var attr:String in aNode.attributes) {
				var av:String = attr.toLowerCase();
				if (av == "attack") attack = XMLData.GetExpression(aNode.attributes[attr]);
				else if (av == "defence" || av == "defense") defence = XMLData.GetExpression(aNode.attributes[attr]);
				else if (av == "health") health = XMLData.GetExpression(aNode.attributes[attr]);
				else if (av == "speed") speed = XMLData.GetExpression(aNode.attributes[attr]);
				else if (av == "desc") desc = aNode.attributes[attr];
				else if (av == "image") image = aNode.attributes[attr];
			}
			for (var mdNode:XMLNode = aNode.firstChild; mdNode != null; mdNode = mdNode.nextSibling) {
				var av:String = aNode.nodeName.toLowerCase();
				if (av == "attack") attack = XMLData.GetExpression(mdNode.firstChild.nodeValue);
				else if (av == "defence" || av == "defense") defence = XMLData.GetExpression(mdNode.firstChild.nodeValue);
				else if (av == "health") health = XMLData.GetExpression(mdNode.firstChild.nodeValue);
				else if (av == "speed") speed = XMLData.GetExpression(mdNode.firstChild.nodeValue);
				else if (av == "desc") desc = mdNode.firstChild.nodeValue;
				else if (av == "image") image = mdNode.firstChild.nodeValue;
				else if (str == "show") shNodeThis = mdNode;
			}
			// Image selection
			var io:Object = shNodeThis;
			if (io == null) io = isNaN(image) ? image : Number(image);
			
			// Add the monster
			if (str == "tentacles" || str == "tentacle") AddMonsterTentacle(attack, defence, health, speed, desc, io);
			else if (str == "zombie") AddMonsterZombie(attack, defence, health, speed, desc, io);
			else if (str == "devilgirl" || str == "demongirl") AddMonsterDevilGirl(attack, defence, health, speed, desc, io);
			else if (str == "astrid") AddMonsterAstrid(attack, defence, health, speed, desc, io);
			else if (str == "generic") AddMonsterGeneric(attack, defence, health, speed, desc, io);
			else if (str == "genericnamed") AddMonsterGenericNamed(attack, defence, health, speed, desc, io);
			else if (str == "thugs") AddMonsterThugs(attack, defence, health, speed, desc, io);
		}
		if (startnow) coreGame.DoEventNext(3000);
		else coreGame.DoEvent(3000);
	}

	
	
}