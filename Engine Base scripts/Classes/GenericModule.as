// Generic
// Linked to GenericActions.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class GenericModule extends SlaveModule
{
	public function GenericModule(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
	}

	public function ResetImages(sex:Boolean, bg:Boolean)
	{
		coreGame.currImage = 0;
		coreGame.HideSlaveActions();
		coreGame.HideImages();
		if (bg == false) return;
		if (sex) Backgrounds.ShowBedRoom();
		else HideBackgrounds();
	}
	
	public function SetUseGeneric()
	{
		var ug:Boolean = (Math.random()*15) < 1;
		if (coreGame.iAction == 19) {
			if (temp && (!slaveData.IsDickgirl() && !coreGame.Lesbian)) ug = false;
		}
		return ug;
	}
	
	// Contests
	
	public function ShowContestHousework(total:Number) : Number
	{
		ResetImages(false);
		ShowMovie(mcBase.ClipContestsHousework, 1, 1);
		return total;
	}
	
	
	// Dickgirls
	
	public function ShowDickgirlTransform(permanent:Boolean)
	{
		if (permanent) {
			mcBase.ClipDickgirlCumShower.gotoAndStop(1);
			mcBase.ClipDickgirlCumShower._visible = true;
			SetText(coreGame.SlaveName + coreGame.NonPlural(" gulp") + " the potion down and #slavehisher huge" + coreGame.CockText() + coreGame.NonPlural(" erupt") + " and screaming with release " + coreGame.SlaveHeShe + coreGame.NonPlural(" cum") + " with enormous spurts");
			if (coreGame.MilkInfluence > 0) AddText(", #slavehisher breasts spewing milk");
			AddText(".");
			var say:String = "";
			if (slaveData.IsTwins()) say += "\r\rAs they recover they feel a tightness in their new cocks, and their still hard cocks spasm and they cum again";
			else say += "\r\rAs she recovers she feels a tightness in her new testicles, and her still hard cock spasms and she cums again";
			if (coreGame.MilkInfluence > 0) say += ", #slavehisher breasts squirting even more milk";
			say += "...";
			mcBase.ClipDickgirlCumShower._x = 7;
			coreGame.StartCumSplatter(500, mcBase.ClipDickgirlCumShower, 0);
			coreGame.intervalId = setInterval(_root, "ShakeIt", 500, 1, mcBase.ClipDickgirlCumShower, mcBase.ClipDickgirlCumShower._x, "", 2);
			coreGame.intervalId4 = setInterval(_root, "ShakeIt", 1200, 2, mcBase.ClipDickgirlCumShower, mcBase.ClipDickgirlCumShower._x, say, 2, 3, 1200);
		} else {
			if (Math.floor(Math.random()*2) == 0) mcBase.ClipDickgirlPotion.gotoAndStop(1);
			else {
				mcBase.ClipDickgirlPotion.gotoAndStop(2);
				mcBase.ClipDickgirlPotion.Potion2.gotoAndPlay(1);
			}
			mcBase.ClipDickgirlPotion._visible = true;
			
			if (slaveData.IsTwins()) { 
				AddText("#slave both drink the potion, which has a strange, thick texture, but tastes rather like milk. They feel a tingling sensation ");
				if (slaveData.DressWorn < 0) AddText("and they cry out as they feel intense sensations");
				else AddText("and they cry out and rip off their lower clothing");
				AddText(" as their clits visibly throb. They hold each other trying to get used to the feeling, ");
				if (Math.floor(Math.random()*2) == 0) AddText("and their clits simultaneously grow into large cock and they moan in arousal.");
				else AddText("and they cry out as their clits explosively grow into a large cocks.");
				AddText("\r\rThey gasp as their cocks stiffen as waves of arousal flood through them. Unconsciously they both reach out and hold the <i>others</i> cock..."); 
			} else {
				AddText("#slave drinks the potion, which has a strange, thick texture, but tastes rather like milk. #slave feels a tingling sensation ");
				if (slaveData.DressWorn < 0) AddText("and cries out as she feels an intense sensation");
				else AddText("and with a cry she rips off her lower clothing,");
				AddText(" as her clit visibly throbs. ");
				if (Math.floor(Math.random()*2) == 0) AddText("A huge cock grows where her clit was and she moans in arousal.");
				else AddText("She cries out as her clit explosively grows into a large cock.");
				AddText("\r\rHer new cock becomes hard and erect as waves of arousal flood through her..."); 
			}
		}
	}
	
	public function ShowDickgirlPermanent()
	{
		ShowMovie(mcBase.ClipDickgirlCumShower, 1, 0, 1);
	}
	
	
	// Items
	
	public function ShowLingerie()
	{
		SetLangText("TailorLingerieModels", "Shopping");
		BlankLine();
		ShowMovie(mcBase.ItemLingere, 1.1, 1);
	}
	
	public function ShowBunnySuit()
	{
		SetLangText("TailorBunnySuitModels", "Shopping");
		BlankLine(); 
		mcBase.ItemBunnySuit.gotoAndStop(1);
		coreGame.StartChangeImage(2000, mcBase.ItemBunnySuit, 2);
		coreGame.intervalId2 = setInterval(_root, "ChangeImage2", 5000, mcBase.ItemBunnySuit, 3);
		mcBase.ItemBunnySuit._visible = true;
	}
	
	public function ShowMaidUniform()
	{
		temp = Math.floor(Math.random()*2) + 1;
		if (temp == 2) SetLangText("TailorMaidModels", "Shopping");
		else SetLangText("TailorMaidModel", "Shopping");
		BlankLine(); 
		ShowMovie(mcBase.ItemMaidUniform, 1.1, 1, temp);
	}
	
	public function ShowSwimsuit()
	{
		if (slaveData.IsMale()) temp = Math.floor(Math.random()*2) + 4;
		else temp = Math.floor(Math.random()*3) + 1;
		if (coreGame.IsFemale()) SetLangText("TailorSwimsuitModels", "Shopping");
		else SetLangText("TailorSwimsuitModelsMale", "Shopping");
		BlankLine(); 
		ShowMovie(mcBase.ItemSwimsuit, 1.1, 1, temp);
	}
	
	
	// Events
	
	public function ShowDemonRape()
	{
		ShowMovie(mcBase.EventDemonRape, 1, 1);
		Backgrounds.ShowOverlay(0);
	}
	
	public function ShowMorningMouthful() : Boolean
	{
		if (slaveData.IsMale()) temp = 2;
		else temp = Math.floor(Math.random()*2) + 1;
		ShowMovie(mcBase.EventMorningMouthful, 1.1, temp == 2 ? 1 : 2, temp);
		Backgrounds.ShowOverlay(0);
		return false;
	}
	
	public function ShowMilking()
	{
		ResetImages(false);
		if (coreGame.TentacleHaunt > 0 && coreGame.NumEvent != 4081) mcBase.EventMilk.gotoAndStop(Math.floor(Math.random()*2) + 8);
		else if (slaveData.IsDickgirl()) {
			if (Math.floor(Math.random()*2) == 1) mcBase.EventMilk.gotoAndStop(Math.floor(Math.random()*2) + 6);
			else mcBase.EventMilk.gotoAndStop(Math.floor(Math.random()*2) + 3);
		} else mcBase.EventMilk.gotoAndStop(Math.floor(Math.random()*5) + 1);
		mcBase.EventMilk._visible = true;
	}
	
	public function ShowNakedApron()
	{
		ResetImages(false);
		if (slaveData.IsMale()) temp = 4;
		else if (slaveData.IsDickgirl() && PercentChance(66)) {
			ShowMovie(mcBase.CleaningClip, 1, 1, 1);
			return;
		} else temp = Math.floor(Math.random()*3) + 1;
		if (temp == 3) Backgrounds.ShowKitchen();
		ShowMovie(mcBase.EventNakedApron, 1.1, 1, temp)
	}
	
	public function ShowPregnancyReveal() : Boolean
	{	
		ResetImages(false, false);
		Backgrounds.ShowCave();
		if (slaveData.IsDickgirl()) temp = coreGame.DickgirlTesticles ? 4 : 3;
		else temp = Math.floor(Math.random()*2) + 1;
		if (temp == 2) Backgrounds.ShowOverlay(0);
		ShowMovie(mcBase.PregnancyReveal, 1.1, 1, temp);
		return true;
	}
	
	public function ShowTentaclePregnancyReveal() : Boolean
	{			
		ResetImages(false, false);
		Backgrounds.ShowCave();
		if (slaveData.IsDickgirl()) temp = coreGame.DickgirlTesticles ? 6 : 5;
		else temp = 1;
		ShowMovie(mcBase.EventTentaclePregnancy, 1.1, 3, temp);
		return true;
	}
	
	public function ShowPregnancyBirth() : Boolean
	{				
		ResetImages(false, false);
		if (slaveData.IsDickgirl()) temp = 8;
		else temp = Math.floor(Math.random()*2) + 8;
		ShowMovie(mcBase.EventTentaclePregnancy, 1.1, 3, temp);
		Backgrounds.ShowCave();
		return true;
	}
	
	public function ShowTentaclePregnancyBirth() : Boolean
	{				
		ResetImages(false, false);
		if (slaveData.IsDickgirl()) temp = 6;
		else temp = Math.floor(Math.random()*3) + 2;
		ShowMovie(mcBase.EventTentaclePregnancy, 1.1, 3, temp);
		Backgrounds.ShowCave();
		return true;
	}
	
	public function ShowRaped()
	{
		if (slaveData.IsDickgirl()) {
			ResetImages(false, false);
			Backgrounds.ShowNight();
			ShowMovie(mcBase.EventRaped, 1.1, 2, 1);
		} else if (slaveData.IsMale()) {
			ResetImages(false, false);
			ShowMovie(mcBase.EventRaped, 1.1, 0, 2);
		}
	}
	
	public function ShowGigaBE()
	{
		temp = slrandom(2);
		if (slaveData.IsMale()) ShowMovie(mcBase.EventGigaBE, 1.1, 1, 18 + 1);
		else ShowMovie(mcBase.EventGigaBE, 1, 0, temp == 1 ? 1 : -2);
	}
	
	
	// Daytime
	
	public function ShowChoreCleaning()
	{
		if (slaveData.IsMale()) {
			ResetImages(false);
			ShowMovie(mcBase.CleaningClip, 1.1, 1, 4);
		} else if (slaveData.IsDickgirl()) {
			ResetImages(false, false);
			Backgrounds.ShowKitchen();
			ShowMovie(mcBase.CleaningClip, 1.1, 1, 1);
		} else {
			ResetImages(false);
			ShowMovie(mcBase.CleaningClip, 1.1, 1, Math.floor(Math.random()*2) + 2);
		}
	}
	
	public function ShowChoreCooking()
	{
		ResetImages(false);
		temp = Math.floor(Math.random()*8) + 1;
		ShowMovie(mcBase.CookingClip, 1.1, temp = 1 || temp > 3 ? 0 : 1, temp);
	}
	
	public function ShowChoreExpose()
	{
		ResetImages(false);
		if (slaveData.IsMale()) ShowMovie(mcBase.ExhibClip, 1.1, 1, 3);
		else if (slaveData.IsDickgirl()) {
			if (coreGame.HasTesticles) ShowMovie(mcBase.ExhibClip, 1.1, 1, 2);
			else ShowMovie(mcBase.ExhibClip, 1.1, 1, 1);
		} else ShowMovie(mcBase.ExhibClip, 1.1, 1, 4);
	}
	
	public function ShowChoreMakeUp() {
		ResetImages(true);
		if (slaveData.IsMale()) ShowMovie(mcBase.ChoreMakeUp, 1, 2, Math.floor(Math.random()*2) + 2);
		else ShowMovie(mcBase.ChoreMakeUp, 1.1, 1, 1);
	}
	
	public function ShowChoreReadABook() {
		ResetImages(true);
		if (slaveData.IsMale()) temp = 3;
		else if (slaveData.DressWorn < 0) temp = 1;
		else temp = Math.floor(Math.random()*3) + 1;
		ShowMovie(mcBase.ChoreReadABook, 1.1, 1, temp);
	}
	
	public function ShowChoreExercise() {
		if (slaveData.IsDickgirl()) {
			ResetImages(false);
			ShowMovie(mcBase.PromenadeClip, 1.1, 3, 4);
			Backgrounds.ShowOverlay(0xC01211);
		} else if (slaveData.IsPonygirl()) {
			if (slaveData.IsMale()) ShowSexActPonygirl();
			else {
				ResetImages(false);
				ShowMovie(mcBase.PromenadeClip, 1.1, 1, Math.floor(Math.random()*3) + 1);
				Backgrounds.ShowOverlay(0);
			}
		} else ShowMovie(mcBase.PromenadeClip, 1.1, 1, 5);
	}
	
	public function ShowJobBrothel()
	{
		if (slaveData.IsDickgirl()) ShowSexActFuck(false);
	}
	
	public function ShowJobCockMilking() : Number {
		ResetImages(false);
		if (coreGame.HasTesticles) ShowMovie(mcBase.CockMilkingClip, 1.1, 2, 1);
		else ShowMovie(mcBase.CockMilkingClip, 1,1, 3, 2);
		return 1;
	}
	
	public function ShowJobRestaurant() : Number {
		ResetImages(false);
		ShowMovie(mcBase.CookingClip, 1, 0, Math.floor(Math.random()*2) + 2);
		return 1;
	}
	
	public function ShowJobOnsen(wgender:Number) : Number
	{
		ResetImages(false, false);
		Backgrounds.ShowOnsen();
		if (wgender == 0) {
			if (IsDayTime()) mcBase.HotspringClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
			else mcBase.HotspringClip.gotoAndStop(Math.floor(Math.random()*2) + 3);
		} else mcBase.HotspringClip.gotoAndStop(((wgender - 1) * 2) + Math.floor(Math.random()*2) + 5);
		mcBase.HotspringClip._visible = true;
		return 1;
	}
	
	public function ShowJobOnsenService(cgender:Number)
	{
		ResetImages(false, false);
		Backgrounds.ShowOnsen();
		switch(cgender) {
			case 1:
				coreGame.AppendActText = false;
				mcBase.HotspringClip.gotoAndStop(14);
				SetText("The man has #slave remove #slavehisher clothing while he slowly strokes his cock. He asks #slavehimher to bend over and #slaveheshe " + coreGame.NonPlural("does") + ", expecting him to fuck #slavehimher, but he groans and #slaveheshe" + coreGame.NonPlural("feel") + " his cum splatter over #slavehisher" + coreGame.Plural(" back") + ".\r\rThe man says 'stay' and shortly thrusts his cock into #slave1 and fucks quickly, but for a fair time. After some time, he cries and pulls out, his cum splattering over #slavehisher" + coreGame.Plural(" back") + ".\r\rThe man gives #slave a tip and suggests #slaveheshe may want to wash...");
				break;
			case 2:
				if (coreGame.HasCock) {
					coreGame.AppendActText = false;
					temp = Math.floor(Math.random()*2);
					mcBase.HotspringClip.gotoAndStop(13 + temp);
					SetText("The woman explains how the inside of her pussy needs cleaning. She applies soap to #slave1's cock and asks her to clean her. She leans against the side of the pool, her pussy wet from the water but she is also very aroused. #slave1 easily thrusts into the woman's pussy, fucking her to the noise of the water and the woman's moans. #slave1 nears her climax and starts to pull out, but the woman cries out, ordering her to cum inside her, in the name of the gods!. With that #slave1 explosively cums, her cums overflowing the woman's womb. The woman screams and orgasms.");
					if (slaveData.IsTwins()) AddText("\r\rThe woman, breathing heavily, tells #slave2 'Your turn'");
					break;
				} else {
					if (slaveData.IsFemale()) mcBase.HotspringClip.gotoAndStop(11);
					else mcBase.HotspringClip.gotoAndStop(12);
				}
				break;
			case 3:
				temp = Math.floor(Math.random()*2);
				if (temp == 0) {
					coreGame.Lesbian = false;
					coreGame.SlaveGirl.Lesbian = false;
					coreGame.SlaveGirl.ShowSexActBlowjob();
					SetText("The woman washes the soap off her cock with a few strokes, and then asks #slave to make sure her cock is clean, suggesting a 'taste' test.\r\r#slave" + coreGame.NonPlural(" understand") + " and " + coreGame.NonPlural("gives") + " the woman a taste test, licking her cock thoroughly until " + coreGame.SlaveVerb("taste") + " the woman's cum.");
					coreGame.AppendActText = false;
					return;
				} else {
					coreGame.AppendActText = false;
					mcBase.HotspringClip.gotoAndStop(14);
					SetText("The woman has #slave remove #slavehisher clothing while she slowly strokes her cock. She asks #slave to bend over and #slaveheshe " + coreGame.NonPlural("does") + ". The woman thrusts her cock into #slave1 and fucks quickly, but for a fair time. After some time, she cries and pulls out, her cum splattering over #slave1's back.");
					if (slaveData.IsTwins()) AddText("\r\rThe woman moves to #slave2 and thrusts her still hard cock into " + (slaveData.IsFemale() ? "her" : "his") + " ass, fucking quick and hard. She quickly cums, thrusting in, her cum flooding #slave2's bowels.");
					AddText("\r\rThe woman gives #slave a tip and suggests #slaveheshe may want to wash...");
				}
				break;
		}
		mcBase.HotspringClip._visible = true;
	}
	
	public function ShowSchoolDance(donearoused) {
		ResetImages(false, false);
		if (slaveData.IsPonygirl()) {
			Backgrounds.ShowTownCenter();
			ShowMovie(mcBase.DanceClip, 1, 1);
		} else ShowMovie(mcBase.DanceClip, 1, 5, slrandom(2) + 1);
	}
	
	public function ShowSchoolSinging()
	{
		temp = slrandom(2);
		ShowMovie(mcBase.SingingClip, 1.1, temp == 2 ? 2 : 1, temp);
		if (temp == 2) Backgrounds.ShowOverlay(0);
	}
	
	
	// Sex
	
	public function ShowSexAct69() {
		ResetImages(false);
		if (coreGame.Lesbian) {
			if (slaveData.IsMale()) mcBase.SixtyNineClip.gotoAndStop(7);
			else {
				if (slaveData.IsDickgirl()) mcBase.SixtyNineClip.gotoAndStop(1);
				else mcBase.SixtyNineClip.gotoAndStop(Math.floor(Math.random()*2) + 5);
			}
		} else if (slaveData.IsDickgirl()) {
			if (slaveData.DressWorn < 0) mcBase.SixtyNineClip.gotoAndStop(1);
			else mcBase.SixtyNineClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
		} else {
			mcBase.SixtyNineClip.gotoAndStop(3 + Math.floor(Math.random()*2));
		}
		mcBase.SixtyNineClip._visible = true;
	}
	
	public function ShowSexActAnal(atemp:Number) {
		ResetImages(true);
		if (atemp == undefined) {
			if (slaveData.IsDickgirl()) {
				if (SMData.SMAdvantages.CheckBitFlag(6)) {
					if (coreGame.HasTesticles) atemp = 3;
					else atemp = Math.floor(Math.random()*3) + 3;
				} else {
					if (coreGame.HasTesticles) atemp = Math.floor(Math.random()*2) + 2;
					else atemp = Math.floor(Math.random()*3) + 1;
				}
			} else if (coreGame.Lesbian) {
				if (slaveData.IsMale()) atemp = Math.floor(Math.random()*2) + 11;
				else atemp = Math.floor(Math.random()*3) + 6;
			} else if ((slaveData.IsMale()) && (slaveData.IsFemale())) atemp = Math.floor(Math.random()*2) + 13;
			else atemp = Math.floor(Math.random()*2) + 9;
		}
		ShowMovie(mcBase.AnalClip, 1, 1, atemp);
	}
	
	public function ShowSexActBlowjob() {
		ResetImages(true);
		if (slaveData.IsMale()) {
			if (coreGame.PersonGender == 1 || coreGame.PersonGender == 4) temp = 5;
			else temp = Math.floor(Math.random()*3) + 1;
		} else if (coreGame.Lesbian) temp = Math.floor(Math.random()*3) + 1;
		else temp = 4;
		ShowMovie(mcBase.BlowjobClip, 1, 1, temp); 
	}
	
	public function ShowSexActBondage() {
		ResetImages(false);
		if (slaveData.SlaveGender == 0 || slaveData.IsMale()) temp = 5 + slrandom(2);
		else if (slaveData.IsDickgirl()) {
			if (coreGame.HasTesticles) temp = 4;
			else temp = Math.floor(Math.random()*3) + 3; 
		} else temp = Math.floor(Math.random()*2) + 1;
		if (temp == 4) Backgrounds.ShowSky(1);
		else if (temp != 5) Backgrounds.ShowBedRoom();
		ShowMovie(mcBase.BondageClip, 1, 1, temp);
	}
	
	public function ShowSexActCumBath() {
		ResetImages(false);
		if (coreGame.IsDickgirl) {
			if (slaveData.DressWorn < 0) mcBase.CumBathClip.gotoAndStop(2);
			else mcBase.CumBathClip.gotoAndStop(Math.floor(Math.random()*3) + 2);
		} else {
			if (slaveData.IsMale()) temp = 5;
			else if (slaveData.DressWorn < 0) mcBase.CumBathClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
			else mcBase.CumBathClip.gotoAndStop(Math.floor(Math.random()*4) + 1);
		}
		mcBase.CumBathClip._visible = true;
	}
	
	public function ShowSexActDildo() {
		if (slaveData.IsMale()) ShowMovie(mcBase.DildoClip, 1, 1, 6);
		else if (slaveData.IsDickgirl()) {
			ResetImages(false);
			if (coreGame.HasTesticles) ShowMovie(mcBase.DildoClip, 1, 1, 2);
			else ShowMovie(mcBase.DildoClip, 1, 0, 1);
		} else ShowMovie(mcBase.DildoClip, 1, 1, slrandom(3) + 2);
	}
	
	public function ShowSexActFootjob() : Boolean {
		ResetImages(true);
		if (coreGame.PersonGender == 2 || coreGame.PersonGender == 5) ShowMovie(mcBase.FootjobClip, 1, 1, 3);
		else {
			temp = slrandom(2);
			ShowMovie(mcBase.FootjobClip, 1, temp == 1 ? 1 : 5, temp);
			if (temp == 2) HideBackgrounds();
		}
		return true;
	}

	public function ShowSexActFuck(bydg:Boolean) {
		if (slaveData.IsDickgirl()) {
			ResetImages(false);
			if (slaveData.DressWorn < 0) mcBase.FuckClip.gotoAndStop(2);
			else {
				if (bydg == true) mcBase.FuckClip.gotoAndStop(Math.floor(Math.random()*4) + 1);
				else mcBase.FuckClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
			}
			mcBase.FuckClip._visible = true;
		} else if (coreGame.Lesbian) {
			ResetImages(false);
			mcBase.FuckClip.gotoAndStop(Math.floor(Math.random()*4) + 4);
			mcBase.FuckClip._visible = true;
		} else if (coreGame.PersonGender == 3 || coreGame.PersonGender == 6) {
			ResetImages(false);
			mcBase.FuckClip.gotoAndStop(Math.floor(Math.random()*2) + 3);
			mcBase.FuckClip._visible = true;
		} else {
			ResetImages(false);
			mcBase.FuckClip.gotoAndStop(8);
			mcBase.FuckClip._visible = true;
		}
	}
	
	public function ShowSexActGangBang() {
		ResetImages(true);
		if (coreGame.Lesbian) mcBase.GangBangClip.gotoAndStop(Math.floor(Math.random()*3) + 5);
		else if (slaveData.IsDickgirl()) {
			if (coreGame.HasTesticles) mcBase.GangBangClip.gotoAndStop(10);
			else mcBase.GangBangClip.gotoAndStop(Math.floor(Math.random()*2) + 8);
		} else if (slaveData.IsMale()) mcBase.GangBangClip.gotoAndStop(11);
		else if (SMData.SMAdvantages.CheckBitFlag(6)) mcBase.GangBangClip.gotoAndStop(Math.floor(Math.random()*2) + 3);
		else mcBase.GangBangClip.gotoAndStop(Math.floor(Math.random()*2) +1);
		mcBase.GangBangClip._visible = true;
	}
	
	public function ShowSexActOrgy() : Boolean {
		if (coreGame.Lesbian) {
			ResetImages(false);
			mcBase.GroupClip.gotoAndStop(Math.floor(Math.random()*5) + 1);
			mcBase.GroupClip._visible = true;
		} else if (slaveData.IsDickgirl()) {
			ResetImages(true);
			mcBase.GroupClip.gotoAndStop(Math.floor(Math.random()*2) + 6);
			mcBase.GroupClip._visible = true;
		} else {
			ResetImages(true);
			mcBase.GroupClip.gotoAndStop(8);
			mcBase.GroupClip._visible = true;
		}
		return true;
	}
	
	public function ShowSexActHandjob() : Boolean { 
		ResetImages(true);
		if (coreGame.PersonGender == 2 || coreGame.PersonGender == 5) ShowMovie(mcBase.HandjobClip, 1, 0, 2);
		else ShowMovie(mcBase.HandjobClip, 1, 1, 1);
		return true;
	}

	public function ShowSexActLesbian() {
		if (slaveData.IsDickgirl())	{
			ResetImages(true);
			if (slaveData.DressWorn < 0) mcBase.LesbianClip.gotoAndStop(1);
			else mcBase.LesbianClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
			mcBase.LesbianClip._visible = true;
		} else if (coreGame.Lesbian) {
			if (coreGame.IsFemale()) {
				ResetImages(true);
				mcBase.LesbianClip.gotoAndStop(Math.floor(Math.random()*4) + 3);
				mcBase.LesbianClip._visible = true;
			} else ShowSexActAnal();
		} 
	}
	
	public function ShowSexActKiss()
	{
		if (coreGame.PersonGender == 1) {
			// male
			ResetImages(true);
			if (slaveData.IsFemale()) temp = 1;
			else temp = 2;
			ShowMovie(mcBase.KissClip, 1.1, 1, temp);
		} else {
			// female
			if (slaveData.IsFemale()) ShowEndingLesbianSlave();
			else {
				ResetImages(true);
				ShowMovie(mcBase.KissClip, 1.1, 1, 2);
			}
		}
	}
	
	public function ShowSexActLick() {
		ResetImages(true);
		if (slaveData.IsDickgirl())	{
			coreGame.SexPosition = 1;
			if (coreGame.HasTesticles) mcBase.LickClip.gotoAndStop(Math.floor(Math.random()*2) + 5);
			else mcBase.LickClip.gotoAndStop(Math.floor(Math.random()*3) + 3);
		} else if (coreGame.Lesbian) {
			mcBase.LickClip.gotoAndStop(Math.floor(Math.random()*2) + 8);
			coreGame.SexPosition = 0;
		} else if (slaveData.IsMale()) {
			ShowMovie(mcBase.BlowjobClip, 1, 1, int(Math.random()*3) + 1); 
			return;
		} else mcBase.LickClip.gotoAndStop(Math.floor(Math.random()*2) + 1);
		mcBase.LickClip._visible = true;
	}
	
	public function ShowSexActMasturbate()
	{
		if (slaveData.IsDickgirl())	{
			ResetImages(false);
			if (slaveData.DressWorn < 0) {
				if (!coreGame.HasTesticles) temp = 2;
				else temp = 1;
			} else {
				if (coreGame.HasTesticles) temp = Math.floor(Math.random()*3) + 1;
				else temp = Math.floor(Math.random()*2) + 2;
			}
		} else if (slaveData.IsMale()) {
			ResetImages(true);
			temp = Math.floor(Math.random()*3) + 6;
		} else {
			ResetImages(false);
			temp = Math.floor(Math.random()*2) + 4;
		}
		ShowMovie(mcBase.MasturbateClip, 1.1, 1, temp);
	}
	
	public function ShowSexActPlug()
	{
		ResetImages(false);
		if (slaveData.IsMale()) temp = 6;
		else if (slaveData.IsDickgirl()) temp = 5;
		else {
			if (slaveData.DressWorn < 0) temp = 4;
			else temp = Math.floor(Math.random()*4) + 1;
		}
		if (temp == 1) Backgrounds.ShowOverlay(0);
		else if (temp == 3 || temp == 6) HideBackgrounds();

		ShowMovie(mcBase.PlugClip, 1.1, 1, temp);
	}
	
	public function ShowSexActPonygirl(gframe:Number)
	{
		if (gframe == undefined) {
			if (slaveData.IsMale()) gframe = slrandom(2) + 2;
			else gframe = Math.floor(Math.random()*2) + 1;
		}
		ResetImages(false);
		if (gframe == 1 || gframe == 3) Backgrounds.ShowOverlay(0);
		else HideBackgrounds();
		ShowMovie(mcBase.EndingPonygirl, 1.1, 1, gframe);
	}
	
	public function ShowSexActSpank(whip:Boolean)
	{
		ResetImages(true);
		if (slaveData.IsMale()) temp = 6;
		else if (whip == true || (SMData.IsDominatrix() && SMData.WeaponType == 3)) temp = 4;
		else if (slaveData.IsDickgirl()) {
			if (coreGame.HasTesticles) temp = 3;
			else temp = 5;
		} else temp = Math.floor(Math.random()*2) + 1;
		ShowMovie(mcBase.SpankClip, 1.1, temp == 4 ? 3 : 1, temp); 
	}
	
	public function ShowSexActThreesome()
	{
		if (slaveData.IsDickgirl())	{
			ResetImages(true);
			if (coreGame.HasTesticles) temp = Math.floor(Math.random()*2) + 4;
			else temp = 6;
			var align = 1;
			if (temp == 4) {
				align = 3;
				Backgrounds.ShowOverlay(0x525662);
			}
			ShowMovie(mcBase.ThreesomeClip, 1.1, align, temp);
		} else if (coreGame.Lesbian) {
			ResetImages(true);
			ShowMovie(mcBase.ThreesomeClip, 1.1, 1, Math.floor(Math.random()*3) + 1);
		} 
	}
	
	public function ShowSexActTitFuck()
	{
		ResetImages(true);
		if (coreGame.Lesbian) temp = Math.floor(Math.random()*2) + 6;
		else temp = Math.floor(Math.random()*5) + 1;
		ShowMovie(mcBase.TitsFuckClip, 1.1, 1, temp);
	}
	
	public function ShowSexActTouch()
	{
		if (slaveData.IsMale()) temp = 13;
		else if (SMData.IsDominatrix()) temp = 12;
		else if (slaveData.IsDickgirl()) {
			if (coreGame.DickgirlTesticles) temp = slrandom(2) + 4;
			else if (coreGame.PersonGender == 3 || coreGame.PersonGender == 6) temp = 7;
			else if (coreGame.PersobGender == 2 || coreGame.PersonGender == 5) temp = Math.floor(Math.random()*5) + 1;
			else temp = Math.floor(Math.random()*2) + 4;
		} else if (coreGame.Lesbian) temp = Math.floor(Math.random()*2) + 10;
		else temp = Math.floor(Math.random()*2) + 8;
		ResetImages(temp == 1 || temp == 3 || temp == 5 || temp == 6 || temp == 13);
		var place:Number = 1;
		var align:Number = 1;
		if (temp == 2 || temp == 4 || (temp > 5 && temp < 10)) place = 1.1;
		if (temp == 9) {
			Backgrounds.ShowOverlay(0);
			align = 2;
		} else if (temp == 8) align = 3;
		else if (temp == 4) {
			align = 3;
			Backgrounds.ShowOverlay(0);
		}
		ShowMovie(mcBase.TouchClip, place, align, temp);
	}
	
	public function ShowTentacleSex(place:Number, gnd:Number) : Boolean
	{
		coreGame.HideSlaveActions();
		coreGame.HideImages();
		Backgrounds.ShowTentacles();
		if (slaveData.IsMale()) {
			coreGame.Tentacles.ClipTentacleHarem.gotoAndStop(16);
			coreGame.Tentacles.ClipTentacleHarem._visible = true;
		} else {
			if (gnd == 3 || gnd == 6) temp = Math.floor(Math.random()*3) + 4;
			else temp = Math.floor(Math.random()*3) + 1;
			ShowMovie(mcBase.ClipTentacle, 1, 1, temp);
		}
		return false;
	}
	
	
	// Endings
	
	public function ShowBadEndingDemonPlaything()
	{
		ShowMovie(mcBase.BadEndDemonicPlaything, 1, 0, slaveData.IsDickgirl() ? 2 : 1);
	}
	
	public function ShowEndingDickgirl()
	{
		ShowMovie(mcBase.EndingDickgirl, 1, 1);
	}
	
	public function ShowEndingLesbianSlave()
	{
		ResetImages(true);
		if (slaveData.IsFemale()) ShowMovie(mcBase.EndingLesbian, 1, 1);
		else ShowMovie(mcBase.KissClip, 1, 1, 2);
	}
	
	
	// Images
	
	public function HideImages()
	{
		super.HideImages();
		
		mcBase.ClipDickgirlPotion._visible = false;
		mcBase.ClipDickgirlPotion.gotoAndStop(2);
		mcBase.ClipDickgirlPotion.Potion2.gotoAndStop(1);
		mcBase.EventMilk._visible = false;
		mcBase.EventTentaclePregnancy._visible = false;
		mcBase.ContestsHousework._visible = false;
		mcBase.EventNakedApron._visible = false;
		mcBase.EventMorningMouthful._visible = false;
		mcBase.EventDemonRape._visible = false;
		mcBase.ItemLingere._visible = false;
		mcBase.ItemBunnySuit._visible = false;
		mcBase.ItemMaidUniform._visible = false;
		mcBase.ItemSwimsuit._visible = false;
		mcBase.ClipDickgirlCumShower._visible = false;
		mcBase.EventRaped._visible = false;
		mcBase.EndingLesbian._visible = false;
		mcBase.EndingSuccubus._visible = false;
		mcBase.CockMilkingClip._visible = false;
		mcBase.SMTrainingCourt._visible = false;
		mcBase.SMTrainingBar._visible = false;
		mcBase.SMTrainingSleazyBar._visible = false;
		mcBase.SMTrainingMartial._visible = false;
		mcBase.SMTrainingMeditation._visible = false;
		mcBase.SMTrainingPray._visible = false;
		mcBase.SMJobDominatrix._visible = false;
		mcBase.SMJobMilitia._visible = false;
		mcBase.SMJobBrothel._visible = false;
		mcBase.SMJobPotions._visible = false;
		mcBase.SMJobGuild._visible = false;
		mcBase.SMJobPagan._visible = false;
		mcBase.EventGigaBE._visible = false;
		mcBase.VampireFeeding._visible = false;
		mcBase.SMJobSleazyBar._visible = false;
		mcBase.PregnancyReveal._visible = false;
	}
	
	public function HideSlaveActions()
	{
		mcBase.AnalClip._visible = false;
		mcBase.BlowjobClip._visible = false;
		mcBase.BondageClip._visible = false;
		mcBase.CumBathClip._visible = false;
		mcBase.DildoClip._visible = false;
		mcBase.FootjobClip._visible = false;
		mcBase.FuckClip._visible = false;
		mcBase.GangBangClip._visible = false;
		mcBase.GroupClip._visible = false;
		mcBase.HandjobClip._visible = false;
		mcBase.LesbianClip._visible = false;
		mcBase.LickClip._visible = false;
		mcBase.MasturbateClip._visible = false;
		mcBase.PlugClip._visible = false;
		mcBase.SixtyNineClip._visible = false;
		mcBase.SpankClip._visible = false;
		mcBase.ThreesomeClip._visible = false;
		mcBase.TitsFuckClip._visible = false;
		mcBase.TouchClip._visible = false;
		mcBase.KissClip._visible = false;

		mcBase.CleaningClip._visible = false;
		mcBase.CookingClip._visible = false;
		mcBase.ExhibClip._visible = false;
		mcBase.PromenadeClip._visible = false;
		mcBase.ClipTentacle._visible = false;
		mcBase.EndingPonygirl._visible = false;
		mcBase.ChoreReadABook._visible = false;
		mcBase.DanceClip._visible = false;
		mcBase.SingingClip._visible = false;
		mcBase.HotspringClip._visible = false;
		mcBase.CockMilkingClip._visible = false;
		mcBase.ChoreMakeUp._visible = false;
	}
	
	public function HideEndings()
	{
		mcBase.EndingPonygirl._visible = false;
		mcBase.EndingDemon._visible = false;
		mcBase.EndingImpregnated._visible = false;
		mcBase.EndingDickgirl._visible = false;
		mcBase.EndingLesbian._visible = false;
		mcBase.EndingSuccubus._visible = false;
		mcBase.BadEndDemonicPlaything._visible = false;
	}

}