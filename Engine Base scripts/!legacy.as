import Scripts.Classes.*;

// Sounds

function StopSounds(fade:Boolean) {	Sounds.StopAllSounds(fade); }
function FadeSounds(duration:Number) { Sounds.FadeSounds(duration); }
function StartMoaning(num:Number) {	Sounds.StartMoaning(num); }
function StartFucking(num:Number) {	Sounds.StartFucking(num); }
function Beep() { Sounds.Beep(); }
function Bloop() { Sounds.Bloop(); }
function PlaySound(snd:String, repeats:Number, cnt:Number, vol:Number, delay:Number, timer:Number) { Sounds.PlaySound(snd, repeats, cnt, vol, delay, timer); }


// Equipment

function SetEquipmentLabel(item:Number, actlabel:String) { SelectEquipment.SetEquipmentLabel(item, actlabel); }
function ShowCustomEquipmentButton1(showmc:Boolean) { SelectEquipment.ShowCustomEquipmentButton(50, showmc); }
function ShowCustomEquipmentButton2(showmc:Boolean) { SelectEquipment.ShowCustomEquipmentButton(51, showmc); }
function ShowOtherEquipment() {	SelectEquipment.ShowOtherEquipment(); }
function SetEquipmentButtonState(item:Number, worn:Boolean, available:Boolean, actlabel:String, shortcut:String) {	SelectEquipment.SetEquipmentButtonState(item, worn, available, actlabel, shortcut); }
function IsItemWorn(item:Number) : Boolean { return Items.IsItemWorn(item); }
function IsItemAvailable(item:Number) : Boolean { return Items.IsItemAvailable(item); }
function SetItemOwned(item:Number, own:Boolean) { return Items.SetItemOwned(item, own); }


// Potions

function DrinkPotion(potion:Number, price:Number, say:String) {	return Potions.DrinkPotion(potion, price, say); }
function TakePotions() { Potions.ViewDialog(); }


// Weapons and Armour

// Weapons
function IsWeaponOwned(weapon) : Boolean { return SMData.IsWeaponOwned(weapon); }
function SetWeaponOwned(weapon) { SMData.SetWeaponOwned(weapon); }

// Armour
function IsArmourOwned(armour) : Boolean { return SMData.IsArmourOwned(armour); }
function SetArmourOwned(armour) { return SMData.SetArmourOwned(armour); }


// SlaveMaker Appearance

function ShowSlaveMaker(type:Number, place:Number, align:Number, frame:Number, defimg:String, target:MovieClip) : MovieClip { return SMAvatar.ShowSlaveMaker(type, place, align, frame, defimg, target); }


// Planning

function GetActPlannedCount(type:Number) : Number {	return Planning.GetActPlannedCount(type); }
function IsActPlanned(type:Number) : Boolean { return Planning.IsActPlanned(type); }
function AddDayNightAction(actnum:Number, loading:Boolean, people:Array) : Boolean { return Plannings.AddDayNightAction(actnum, loading, people); }


// Hints

function SetHintText(txt:String) { Hints.SetHintText(txt); }
function AddHintText(txt:String) { Hints.AddHintText(txt); }
function ShowHint(txt:String, xpos:Number, wid:Number) { Hints.ShowHint(txt, xpos, wid); }
function ShowHintAdd(txt:String) { Hints.ShowHintAdd(txt); }
function StopHints() { Hints.StopHints(); }
function IsHints() : Boolean { return Hints.IsHints(); }
function HideHints() { Hints.HideHints(); }


// Bitflags

function CheckBitFlag1(flag:Number) : Boolean {	return BitFlag1.CheckBitFlag(flag); }
function SetBitFlag1(flag:Number) { BitFlag1.SetBitFlag(flag); }
function ClearBitFlag1(flag:Number) { BitFlag1.ClearBitFlag(flag); }
function CheckAndSetBitFlag1(flag:Number) : Boolean { return BitFlag1.CheckAndSetBitFlag(flag); }
function CheckBitFlag2(flag:Number) : Boolean { return BitFlag2.CheckBitFlag(flag); }
function SetBitFlag2(flag:Number) { BitFlag2.SetBitFlag(flag); }
function ClearBitFlag2(flag:Number) { BitFlag2.ClearBitFlag(flag); }
function CheckAndSetBitFlag2(flag:Number) : Boolean { return BitFlag2.CheckAndSetBitFlag(flag); }
function CheckBitFlagSM(flag:Number) : Boolean { return BitFlagSM.CheckBitFlag(flag); }
function SetBitFlagSM(flag:Number) { BitFlagSM.SetBitFlag(flag); }
function ClearBitFlagSM(flag:Number) { BitFlagSM.ClearBitFlag(flag); }
function CheckAndSetBitFlagSM(flag:Number) : Boolean { return BitFlagSM.CheckAndSetBitFlag(flag); }


// Assistants

function ChooseAssistant() { AssistantSelect.ViewDialog(); }


// Housing

function AddCustomHouse(clabel:String, xpos:Number, ypos:Number, hint:String) : Number { return HouseEvents.AddCustomHouse(clabel, xpos, ypos, hint); }
function ShowCustomHouse(clabel, xpos:Number, ypos:Number, hint:String) { HouseEvents.ShowCustomHouse(clabel, xpos, ypos, hint); }
function SetCustomHouseDetails(idx:Number, clabel:String, xpos:Number, ypos:Number, hint:String) : HouseDetails { return HouseEvents.SetCustomHouseDetails(idx, clabel, xpos, ypos, hint); }
function HideCustomHouse(idx) { HouseEvents.HideCustomHouse(idx); }
function HomeInformation() { MorningEvening.HomeInformation(); }

// People

function ShowPerson(person:Object, place:Object, align:Number, gframe:Number, delay:Number) { People.ShowPerson(person, place, align, gframe, delay); }
function HidePerson(person:Object) { People.HidePerson(person); }

function ShowCustomVisitPerson(pname:String, person:Number) { currentCity.ShowCustomVisitPerson(pname, person); }
function HideCustomVisitPerson(person:Number) { currentCity.HideCustomVisitPerson(person); }
function GetPerson(str:String) : Person { return People.GetPersonsObject(str); }


// Overlay and Backgrounds

function SetOverlayFromMovie(mc:MovieClip, offsetx:Number, offsety:Number) { Backgrounds.SetOverlayFromMovie(mc, offsetx, offsety); }
function ShowOverlay(colour:Number, leavebg:Boolean) { Backgrounds.ShowOverlay(colour, leavebg); }
function ShowOverlayWhite() { Backgrounds.ShowOverlay(0xffffff); }
function ShowOverlayBlack() { Backgrounds.ShowOverlay(0); }
function HideBackgrounds() { Backgrounds.HideBackgrounds(); }


// Contests

function AddCustomContest(slabel:String, hint:String, nname:String) : Number { return Contests.AddCustomContest(slabel, hint, nname); }
function ShowCustomContest(cshow:Boolean, num:Number) {	Contests.ShowCustomContest(cshow, num); }
function HideCustomContest(num:Number) { Contests.ShowCustomContest(false, num) }


// Buttons

function SetButtonState(mc:MovieClip, tick:Boolean, available:Boolean, actlabel:String, action:Number, ifunc:Function, cost:Number, irofunc:Function, shortcut:String, aduration:Number, iroutfunc:Function, astart:Number, aend:Number) { SetButtonDetails(mc, tick, available, actlabel, action, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, fobj); }


// Acts

function SetActState(type:Object, tick:Boolean, available:Boolean, actlabel:String, cost:Number, aduration:Number, shortcut:String, astart:Number, aend:Number, ifunc:Function, irofunc:Function, iroutfunc:Function, hint:String) : ActInfo { return slaveData.ActInfoBase.SetActDetails(type, tick, available, actlabel, hint, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, coreGame); }
function SetActDetails(type:Object, tick:Boolean, available:Boolean, actlabel:String, hint:String, shortcut:String, cost:Number, aduration:Number, astart:Number, aend:Number, ifunc, irofunc, iroutfunc, fobj:Object) : ActInfo { return slaveData.ActInfoBase.SetActDetails(type, tick, available, actlabel, hint, shortcut, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, fobj); }
// Required for older slaves
function SetActButtonState(type:Object, tick:Boolean, available:Boolean, actlabel:String, cost:Number, aduration:Number, shortcut:String, astart:Number, aend:Number, func:Function, rofunc:Function, routfunc:Function, hint:String) {	slaveData.ActInfoBase.SetActDetails(type, tick, available, actlabel, shortcut, hint, cost, aduration, astart, aend, ifunc, irofunc, iroutfunc, coreGame); }

function ShowActButton(type:Object, showact:Boolean) { slaveData.ActInfoBase.GetActRO(type).ShowAct(showact); }
function DoLesbianAction(lesact:Boolean, sgact:Function, genact:Function, act:Number) {	XMLData.PerformActNow(-50, act, lesact == undefined ? true : lesact, sgact == undefined); }

function GetActNumber(type:Object) : Number { return slaveData.ActInfoBase.GetActRO(type).Act; }
function ShowAct(type:Object, showact:Boolean) { slaveData.ActInfoBase.GetActRO(type).ShowAct(showact); }
function HideAct(type:Object) { slaveData.ActInfoBase.GetActRO(type).HideAct(); }
function GetActCost(type:Object) : Number {	return slaveData.ActInfoBase.GetActRO(type).Cost; }
function GetActDuration(type:Object) : Number {	return slaveData.ActInfoBase.GetActRO(type).GetActDuration(Number(type)); }
function GetActStartTime(type:Object) : Number { return slaveData.ActInfoBase.GetActRO(type).StartTime; }
function GetActEndTime(type:Object) : Number { return slaveData.ActInfoBase.GetActRO(type).EndTime; }
function GetActAvailable(type:Object) : Boolean { return slaveData.ActInfoBase.GetActRO(type).Available; }
function SetActAvailable(type:Object, avail:Boolean) { slaveData.ActInfoBase.GetActRO(type).Available = avail == undefined ? true : avail; }
function GetActName(type:Object) : String {	return slaveData.ActInfoBase.GetActName(type); }
function GetActTotalImages(type:Object) : Number { return slaveData.ActInfoCurrent.GetActRO(type).GetTotalImages(); }

function SetActCost(type:Object, acost:Number) { SetActState(type, undefined, undefined, undefined, acost); }
function SetActDuration(type:Object, aduration:Number) { SetActState(type, undefined, undefined, undefined, undefined, aduration); }
function SetActStartTime(type:Object, astart:Number) { SetActState(type, undefined, undefined, undefined, undefined, undefined, undefined, astart); }
function SetActEndTime(type:Object, aend:Number) { SetActState(type, undefined, undefined, undefined, undefined, undefined, undefined, undefined, astart); }
function GetSexActShortDescription(type:Number) : String { return slaveData.GetSexActShortDescription(type); }


// Items

function HideItem(item:Object) { Items.HideItem(item); }
function ShowItem(item:Object, main:Object, align:Number, gframe:Number) { Items.ShowItem(item, main, align, gframe); }
function HideItems() { Items.HideItems(); }
function ShowItemDescription(item:Number) { Items.ShowItemDescription(item); }
function ShowEquipmentButton(xpos:Number) { SelectEquipment.ShowEquipmentButton(xpos); }
function HideEquipmentButton() { SelectEquipment.HideEquipmentButton(); }
function WearItem(item:Number) { Items.WearItem(item); }
function RemoveItem(item:Number) { Items.RemoveItem(item); }
function ShowSMEquipmentButton() { SelectSMEquipment.ShowSMEquipmentButton(); }
function HideSMEquipmentButton() { SelectSMEquipment.HideSMEquipmentButton(); }


// XML

//function GetNodeChildren(baseNode, node:String) : XMLNode { return XMLData.GetNodeC(baseNode, node); }
function GetNodeC(baseNode, node:String) : XMLNode { return XMLData.GetNodeC(baseNode, node); }
function GetNode(base, node:String) : XMLNode { return XMLData.GetNode(base, node); }
function GetXMLBoolean(str:String, node, def:Boolean) : Boolean { return XMLData.GetXMLBoolean(str, node, def); }
function GetXMLString(str:String, node, def:String) : String { return XMLData.GetXMLString(str, node, def); }
function GetXMLValue(str:String, node, def:Number) : Number { return XMLData.GetXMLValue(str, node, def); }
//function XMLEventLastNode(node:String, sett:Boolean, sptext:Boolean) : Boolean { return XMLData.XMLEventLastNode(node, sett, sptext); }
function XMLEvent(node:String, sett:Boolean) : Boolean {	return XMLData.XMLEvent(node, sett); }
//function XMLEventCached(node:String, eNode:XMLNode, sett:Boolean, sptext:Boolean) : Boolean { return XMLData.XMLEventCached(node, sett, sptext); }
function XMLEventByNode(eNode:XMLNode, sett:Boolean, evno:String, sptext:Boolean) : Boolean { return XMLData.XMLEventByNode(eNode, sett, evno, sptext); }
function PickXMLEvent(node:String, exclude:Array) : String { return XMLData.PickXMLEvent(node, exclude); }
function PickXMLEventByNode(eNode:XMLNode, exclude:Array, pl:Place) : String { return XMLData.PickXMLEventByNode(eNode, exclude, pl); }
function PickAndDoXMLEvent(node:String, sett:Boolean, exclude:Array) : Boolean { return XMLData.PickAndDoXMLEvent(node, sett, exclude); }
function PickAndDoXMLEventByNode(node, sett:Boolean, exclude:Array) : Boolean { return XMLData.PickAndDoXMLEventByNode(node, sett, exclude); }
function DoXMLAct(act:String) : Boolean { return XMLData.DoXMLAct(act); }
function XMLGeneral(tag:String, sett:Boolean, basenode:XMLNode) : Boolean { return XMLData.XMLGeneral(tag, sett, basenode); }


// Language

function GetLanguageStringByNode(str:String, iNode:XMLNode, bold:Boolean, spacing:Number, shortcut:String, strplus:String, italic:Boolean) : String { return Language.GetHtml(str, iNode, bold, spacing, shortcut, strplus, italic); }
function GetLanguageString(str:String, node, bold:Boolean, spacing:Number, shortcut:String, strplus:String, italic:Boolean) : String { return Language.GetHtml(str, node, bold, spacing, shortcut, strplus, italic); }
function SetLangText(tag:String, node, sNode:XMLNode) { Language.SetLangText(tag, node, sNode); }
function SetLangGeneralText(tag:String, node, sNode:XMLNode) { Language.SetLangGeneralText(tag, node, sNode); }
function AddLangText(tag:String, node, sNode:XMLNode) { Language.AddLangText(tag, node, sNode); }
function AddLangGeneralText(tag:String, node, sNode:XMLNode) { Language.AddLangGeneralText(tag, node, sNode); }

function PersonSpeakStart(person:Object, say:String, newl:Boolean) { Language.PersonSpeakStart(person, say, newl); }
function PersonSpeakEnd(say:String) { Language.PersonSpeakEnd(say); }
function PersonSpeak(person:Object, say:String, newl:Boolean) { Language.PersonSpeak(person, say, newl); }

function SlaveSpeakStart(say:String, newl:Boolean) { slaveData.SlaveSpeakStart(say, newl); }
function Slave1SpeakStart(say:String, newl:Boolean) { slaveData.Slave1SpeakStart(say, newl); }
function Slave2SpeakStart(say:String, newl:Boolean) { slaveData.Slave2SpeakStart(say, newl); }
function SlaveSpeakEnd(say:String) { slaveData.SlaveSpeakEnd(say); }
function SlaveSpeak(say:String, newl:Boolean) { slaveData.SlaveSpeak(say, newl); }
function Slave1Speak(say:String, newl:Boolean) { slaveData.Slave1Speak(say, newl); }
function Slave2Speak(say:String, newl:Boolean) { slaveData.Slave2Speak(say, newl); }

function ServantSpeak(say:String, newl:Boolean) { Language.ServantSpeak(say, newl); }
function ServantSpeakStart(say:String, newl:Boolean) { Language.ServantSpeakStart(say, newl); }
function Servant1SpeakStart(say:String, newl:Boolean) { Language.Servant1SpeakStart(say, newl); }
function Servant2SpeakStart(say:String, newl:Boolean) { Language.Servant2SpeakStart(say, newl); }
function Servant1Speak(say:String, newl:Boolean) { Language.Servant1Speak(say, newl); }
function Servant2Speak(say:String, newl:Boolean) { Language.Servant2Speak(say, newl); }
function ServantSpeakEnd(say:String) { Language.ServantSpeakEnd(say); }

function Plural(str:String, gender:Number) : String { return Language.Plural(str, gender); }
function NonPlural(str:String, gender:Number) : String { return Language.NonPlural(str, gender); }

function SlaveVerb(str:String) : String { return Language.SlaveVerb(str); }
function Slave1Verb(str:String) : String { return Language.Slave1Verb(str); }
function Slave2Verb(str:String) : String { return Language.Slave2Verb(str); }
function SlaveHeSheVerb(str:String) : String { return Language.SlaveHeSheVerb(str); }
function SlaveHeSheUCVerb(str:String) : String { return Language.SlaveHeSheUCVerb(str); }
function SlaveHisHerVerb(str:String) : String { return Language.SlaveHisHerVerb(str); }

function SlaveText() : String { return Language.SlaveText(); }
function CockText() : String { return Language.CockText(); }
function PussyText() : String { return Language.PussyText(); }
function CockPussyText() : String { return Language.CockPussyText(); }
function OrgasmText() : String { return Language.OrgasmText(); }
function OrgasmTextNP() : String { return Language.OrgasmTextNP(); }


// Images

function DefaultGeneric(chance:Number) : Boolean
{
	if (UseGeneric || chance == undefined || Math.floor(Math.random()*100) < chance) {
		UseGeneric = true;
		return true;
	}
	return false;
}
function DefaultLesbian(chance:Number) : Boolean
{
	if (!Lesbian) return false;
	return DefaultGeneric(chance);
}

// Slaves

function GetSlaveInformation(sdo, dotext:Boolean) : Object { return SMData.GetSlaveInformation(sdo, dotext); }
function GetOtherSlaveInformation(sdo) : Object { return SMData.GetOtherSlaveInformation(sdo); }
function SetSlaveOwned(slave:String, own:Boolean) : Slave { return SMData.SetSlaveOwned(slave, own); }
function GetTotalMaleSlavesOwned(sextype:Number, noassistant:Boolean) : Number { return SMData.GetTotalMaleSlavesOwned(sextype, noassistant); }
function GetTotalFemaleSlavesOwned(sextype:Number, noassistant:Boolean) : Number { return SMData.GetTotalFemaleSlavesOwned(sextype, noassistant); }
function GetTotalDickgirlSlavesOwned(sextype:Number, noassistant:Boolean) : Number { return SMData.GetTotalDickgirlSlavesOwned(sextype, noassistant); }
function GetRandomFemaleSlaveOwned(sextype:Number, except:Array) : Slave { return SMData.GetRandomFemaleSlaveOwned(sextype, except); }
function GetRandomFemaleOrDickgirlSlaveOwned(sextype:Number, except:Array) : Slave { return SMData.GetRandomFemaleOrDickgirlSlaveOwned(sextype, except); }
function GetRandomMaleSlaveOwned(sextype:Number, except:Array) : Slave { return SMData.GetRandomMaleSlaveOwned(sextype, except); }
function GetRandomMaleOrDickgirlSlaveOwned(sextype:Number, except:Array) : Slave { return SMData.GetRandomMaleOrDickgirlSlaveOwned(sextype, except); }
function GetRandomDickgirlSlaveOwned(sextype:Number, except:Array) : Slave { return SMData.GetRandomDickgirlSlaveOwned(sextype, except); }
function GetRandomSlaveOwned(sextype:Number, except:Array) : Slave { return SMData.GetRandomSlaveOwned(sextype, except); }
function ChangeSlaveType(slave:Object, type:String) { SMData.ChangeSlaveType(slave, type); }


// Text

function AddText(str:String) { Language.AddText(str); }
function RemoveText(nchar:Number) { Language.RemoveText(nchar); }
function AddTextToStart(pstring:String) { Language.AddTextToStart(pstring); }
function AddTextToStartGeneral(pstring:String) { Language.AddTextToStartGeneral(pstring); }
function SetText(str:String) { Language.SetText(str); }
function SetGeneralText(str:String) { Language.SetGeneralText(str); }
function AddGeneralText(str:String) { Language.AddGeneralText(str); }
function SetLargerText(str:String) { Language.SetLargerText(str); }
function BlankLine() { Language.BlankLine(); }
function ShowGeneralText(large:Boolean) { Language.ShowGeneralText(large); }
function ShowLargerText(large:Boolean) { Language.ShowLargerText(large); }
function HideLargerText() { Language.HideLargerText(); }
function NameCase(s:String) : String { return s.substr(0,1).toUpperCase() + s.substr(1); }


// Slave Maker

function SMChangeMinStats(Corruption:Number, Lust:Number) { SMData.SMChangeMinStats(Corruption, Lust); }
function SMPoints(attack:Number, defence:Number, arousaldef:Number, constitution:Number, conversation:Number, lust:Number, corrupt:Number, renown:Number, dominance:Number, charisma:Number, refinement:Number, nymphomania:Number, tiredness:Number, sexualenergy:Number) { SMData.SMPoints(attack, defence, arousaldef, constitution, conversation, lust, corrupt, renown, dominance, charisma, refinement, nymphomania, tiredness, sexualenergy); }


// Slaves

function IsSlave(slave:String) : Boolean { return slaveData.IsSlave(slave); }
function ShowSlave(slaveo, place:Number, align:Number, gframe:Number, target:MovieClip) { SMData.ShowSlave(slaveo, place, align, gframe, target); }
function UpdateSlaveVitals(sd:Object) {	dspMain.UpdateSlaveVitals(sd); }
function UpdateSexuality(sex:Number) { dspMain.UpdateSexuality(sex); }


// Creatures

function ShowMonster(str:String,  place:Number, align:Number, frame:Number, dg:Boolean) { config.ShowMonster(str, place, align, frame, dg); }


// Endings

function ShowEndingNext() { EndGame.ShowEndingNext(); }
function HideEndingNext() { EndGame.HideEndingNext(); }
function HideEndings() { EndGame.HideEndings(); }
function SetEnding(fin:Number, endstr:String) { EndGame.SetEnding(fin, endstr); }
function CalculateScore(newscore:Number, sd:Object)
{
	if (sd == undefined || sd == _root) {
		slaveData.CopyCommonDetails(_root, slaveData);
		sd = slaveData;
	}
	Score = sd.CalculateScore(newscore);
}

function CalculateTotalScore(sd:Object)
{
	if (sd == undefined || sd == _root) {
		slaveData.CopyCommonDetails(_root, slaveData);
		sd = slaveData;
	} 
	Score = sd.CalculateTotalScore();
	Pay = sd.CalculateValue(Score);
}

// Waiting

function ShowWait(bDark:Boolean) { Timers.ShowWait(bDark); }
function StopWait() { Timers.StopWait(); }


// Custom SM training

function AddSMCustomTraining(slabel:String, hint:String, node) : Number { return modulesList.trainSlaveMaker.AddSMCustomTraining(slabel, hint, node); }
function SetSMCustomTrainingDetails(slabel:String, hint:String) { modulesList.trainSlaveMaker.SetSMCustomTrainingDetails(slabel, hint); }
function ShowSMCustomTraining(num:Number, bshow:Boolean) { modulesList.trainSlaveMaker.ShowSMCustomTraining(num, true); }
function HideSMCustomTraining(num:Number) {	modulesList.trainSlaveMaker.ShowSMCustomTraining(num, false); }


// Combat

function InitialiseCombat(startmsg:String, runawayevent:Object, winevent:Object, loseeventhurt:Object, loseeventaroused:Object, sethealth:Boolean) { Combat.InitialiseCombat(startmsg, runawayevent, winevent, loseeventhurt, loseeventaroused, sethealth); }
function SetHealth(amt:Number) { SMData.SetHealth(amt); }
function AddMonster(newmonster:Monster) { Combat.AddMonster(newmonster); }
function AddMonsterTentacle(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object) { Combat.AddMonster(new MonsterTentacle(attack, defence, health, speed, desc, image)); }
function AddMonsterZombie(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object) { Combat.AddMonster(new MonsterZombie(attack, defence, health, speed, desc, image)); }
function AddMonsterDevilGirl(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object) { Combat.AddMonster(new MonsterDevilGirl(attack, defence, health, speed, desc, image)); }
function AddMonsterAstrid(attack:Number, defence:Number, health:Number, speed:Number, desc:String, image:Object) { Combat.AddMonster(new MonsterAstrid(attack, defence, health, speed, desc)); }
function AddMonsterGeneric(attack:Number, defence:Number, health:Number, speed:Number, desc:String, mc:Object) { Combat.AddMonster(new MonsterGeneric(attack, defence, health, speed, desc, mc, coreGame)); }
function AddMonsterThugs(attack:Number, defence:Number, health:Number, speed:Number, desc:String, mc:Object) { Combat.AddMonster(new MonsterThugs(attack, defence, health, speed, desc, mc)); }
function CombatHitSound(monster:Boolean) { Combat.CombatHitSound(monster); }
//function UpdateCombatStats() { Combat.UpdateCombatStats(); }
//function ResetSMAttacks() { Combat.ResetSMAttacks(); }
//function SlaveMakerDoDamage(damage:Number, skill:Number, defence:Number, stun:Boolean) : Boolean { Combat.SlaveMakerDoDamage(damage, skill, defence, stun); }
//function ResetMonsterAttacks() { Combat.ResetMonsterAttacks(); }
function CombatEvent(eventno:Number) { Combat.CombatEvent(eventno); }


// Skills

function UpdateSexSkills(sd:Object) { dspMain.UpdateSexSkills(sd); }
function UpdateBasicSlaveSkills(sd:Object) { dspMain.UpdateBasicSlaveSkills(sd); }
function GetSkill(skill:String) : Number { return coreGame.slaveData.GetSkill(skill); }
