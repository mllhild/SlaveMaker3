// Faeries
// Translation status: INCOMPLETE
//
// Flags
// 0 - set - rescue events are complete/not possible any more

import Scripts.Classes.*;

class FaeriesModule extends TrainingBase
{	
	public function FaeriesModule(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
		this.ModuleName = "FaerieTraining";
	}
	
	public function CanLoadSave() : Boolean { return false; }

	public function InitialiseModule(mcb:MovieClip)
	{
		super.InitialiseModule(mcb);
		
		xNode = Language.XMLData.GetNodeC("SlaveTrainings/Faerie");
	}
	
	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{ 
		if (sd == undefined) return coreGame.FairyXF > 0;
		return sd.FairyXF > 0;
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) return coreGame.IsFairyComplete();
		return sd.IsFairyComplete();
	}

	
	// Events
	
	public function EventsAsAssistant(possible:Boolean)
	{
		if (possible && coreGame.FairyXF == 1000) DoFaerieTransform();
	}
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch (coreGame.StrEvent) {
			case "FaerieRescue":
				return FaerieRescue();
		}
			
		switch (coreGame.NumEvent) {
			// 4200/4203 - Fairy rescue - free her
			case 4200:
			case 4203:
				temp = SetRescueFlag();
				ShowMovie("ClipFairyMeeting", 1.1, temp == 3 ? 3 : 5, temp + 8);
				coreGame.HideStatChangeIcons();
				if (coreGame.NumEvent == 4203) AddText(coreGame.SlaveName + NonPlural(" sneak") + " in and quickly frees the faerie. " + coreGame.NameCase(coreGame.SlaveHeSheIs) + " unable to remove all the bindings, but it may just be the faerie already had some odd piercings...\r\rThe faerie whispers her thanks and asks #slave to return tomorrow and silently leaves. #slave quickly leaves but is chased for a time by the hunters who seem to think " + coreGame.SlaveHeSheIs + " is the faerie. Eventually #slaveheshe escapes.");
				else AddText(coreGame.SlaveName + NonPlural(" sneak") + " in and quickly frees the faerie girl. " + coreGame.NameCase(coreGame.SlaveHeSheIs) + " unable to remove all the bindings, but it may just be the faerie already had some odd piercings...\r\rThe faerie looks at her with gratitude and silently leaves.\r\r#slave quickly leaves but is chased for a time by the hunters who seem to think " + coreGame.SlaveHeSheIs + " the faerie. Eventually #slaveheshe loses them.");
				Points(0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0);
				return true;
				
			// 4201 - Fairy Rescue - leave
			case 4201:
				mcBase.ClipFairyMeeting._visible = false;
				if (slaveData.FairyMeeting < 50) slaveData.FairyMeeting = slaveData.FairyMeeting + 50;
				coreGame.HideStatChangeIcons();
				AddText(coreGame.SlaveName + NonPlural(" hear") + " a struggle and thinks the faerie was captured, " + coreGame.SlaveHeSheIs + " very curious but leaves for #slavehisher own safety.\r\r" + coreGame.SlaveHeSheUC + NonPlural(" hear") + " a noise and realises " + coreGame.SlaveHeSheIs + " being chased, and #slaveheshe runs for her freedom. Eventually #slaveheshe escapes.");
				Points(0, -2, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
				return true;
				
			// 4202 - Fairy Rescue - rebind her
			case 4202:
				if (slaveData.FairyMeeting < 50) slaveData.FairyMeeting = slaveData.FairyMeeting + 60;
				else if (slaveData.FairyMeeting < 60) slaveData.FairyMeeting = slaveData.FairyMeeting + 10;
				temp = SetRescueFlag();
				ShowMovie("ClipFairyMeeting", 1.1, 5, temp + 5);
				coreGame.HideStatChangeIcons();
				Money(100);
				AddText(coreGame.SlaveName + NonPlural(" walk") + " in and re-binds the faerie who looks surprised and fearful.\r\r");
				if (temp == 2) {
					AddText("An odd woman walks in who appears to be some sort of faerie too. She looks silently at #slave and grabs the bound faerie and starts to take her away.\r\rShe turns and throws a small gold nugget and some berries at #slave who " + NonPlural("pocket") + " the gold and unconsciously " + NonPlural("eat") + Plural(" a berry") + "...");
					DoEvent(4207);
				} else AddText("A group of hunters arrive and see what she has done and thank her.\r\rThey chat to #slave for a bit about hunting faeries and pay #slavehimher a reward for #slavehisher help.");
				if (coreGame.FaeriesRingOK == 1) AddText("\r\rThe Faeries " + Plural("Ring") + " suddenly grows hot and turns to dust.");
				slaveData.FaeriesRingOK = 10;
				slaveData.FaeriesRingWorn = 0;
				Points(0, -2, 0, 0, -2, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0, 0, 0);
				return true;
				
			// 4204 - Fairy Rescue - sell reward gem
			case 4204:
				coreGame.HideStatChangeIcons();
				Money(300);
				coreGame.HideImages();
				Backgrounds.ShowShop();
				Points(0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
				ServantSpeak("#assistantpronoun sold the gem for 300GP");
				return true;
				
			// 4205 - Fairy Rescue - eat reward gem
			case 4205:
				coreGame.HideStatChangeIcons();
				coreGame.PersonIndex = -50;
				switch (Math.floor(Math.random()*6)) {
					case 0:
						slaveData.NumAphrodisiac++;
						slaveData.MinLibido += 10;
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0);
						slaveData.UsedAphrodisiac = 1;
						coreGame.Potions.DrinkPotion(20, 0, NonPlural("eat") + " the gem and is knocked to #slavehisher knees by overwhelming lust.");
						break;
					case 1:
						Points(8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
						AddText(coreGame.SlaveName + NonPlural(" eat") + " the gem and feels a rush of heat in #slavehisher skin. " + coreGame.SlaveHeSheUC + NonPlural(" look") + " at #slavehisher reflection in some water and sees #slavehisher appearance has slightly altered and " +coreGame.SlaveHeShe + " is more beautiful.");
						break;
					case 2:
						Points(0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
						AddText(coreGame.SlaveName + NonPlural(" eat") + " the gem and feels surge of emotions and has vision after vision of perfect love and romance. The visions remain with #slavehimher for the rest of #slavehisher life.");
						break;
					case 3:
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0);
						AddText(coreGame.SlaveName + NonPlural(" eat") + " the gem and feels a rush of happiness and starts laughing uncontrollably. " + coreGame.SlaveHeSheUC + " eventually stops but the good mood persists.");
						break;
					case 4:
						Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0);
						AddText(coreGame.SlaveName + NonPlural(" eat") + " the gem and feels a surge of self confidence. After a time the feeling fades but #slaveheshe remembers it fondly.");
						break;
					case 5:
						AddText(coreGame.SlaveName + NonPlural(" eat") + " the gem and feels a tightness in her chest. Her breasts swell a little and feel much more sensitive.");
						coreGame.ChangeBustSize(1.05);
						Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
						break;
				}
				return true;
				
			// 4206 - Fairy Rescue - transform
			case 4206:
				Diary.AddEntryLang("Faerie/StartTransform");
				coreGame.HideStatChangeIcons();
				slaveData.SetFairyXF(1);
				Points(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0);
				SetText(coreGame.SlaveVerb("feel") + " a strange sensation and an intense itching in #slavehisher shoulders.");
				return true;				
				
			// 4207 - Fairy Rescue - eat spider berry
			case 4207:
				coreGame.HideStatChangeIcons();
				slaveData.NumAphrodisiac++;
				slaveData.MinLibido += 10;
				slaveData.UsedAphrodisiac = 1;
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0);
				coreGame.Potions.DrinkPotion(20, 0, "swallows the berry and is knocked to #slavehisher knees by overwhelming lust.");
				return true;
		}
		return false;
	}

	private function SetRescueFlag() : Number
	{
		var temp:Number = slaveData.FairyMeeting;
		if (temp > 59) temp = temp - 60;
		else if (temp > 49) temp = temp - 50;
		if (!(temp < 4 && slaveData.FairyMeeting != 53 && slaveData.FairyMeeting != 64)) SetBitFlag(0);
		else ClearBitFlag(0);
		return temp;
	}
	
	public function FaerieRescue() : Boolean
	{
		temp = SetRescueFlag();
		if (CheckBitFlag(0)) return false;
		
		ShowSupervisor();
		coreGame.HideImages();
		coreGame.HideDresses();
		
		SMData.BitFlagSM.SetBitFlag(7);
		temp++;
		slaveData.FairyMeeting = temp;
		if (temp < 4) {
			ShowMovie("ClipFairyMeeting", 1.1, 5, temp + 1);
			AddText("While approaching the farm and passing though a small wood " + SlaveVerb("find") + " a faerie girl who has been trapped and bound and is struggling to get free. #Slaveheshe can hear the captors in the distance. #Slaveheshe also hears rustling in the trees.");
			if (slaveData.FairyMeeting < 3) AskHerQuestions(4200, 4201, 4202, 0, "Free Her", "Leave hoping her friends help", "Rebind her to help her captors", "", "What does #slave do?");
			else AskHerQuestions(4203, 4201, 4202, 0, "Free Her", "Leave hoping her friends help", "Rebind her to help her captors", "", "What does #slave do?");
			return true;
		}
		if (slaveData.FairyMeeting == 64) {
			ShowMovie("ClipFairyMeeting", 1.1, 5, 13);
			AddText(coreGame.SlaveSee + " two faeries, one tied up with her pussy being teased by the other. They both seem to be waiting for #slave\r\r");
			PersonSpeak("Dominant Faerie", "If you wanted to tie us up we would of been happy to play. We like our freedom so being slaves is not what I want.", true);
			AddText("\r\r");
			PersonSpeak("Submissive Faerie", "We would love... I mean hate being bound and fucked and made to cum against our will. To utterly obey every perverted wish of our owner...", true);
			AddText("\r\rWith these words the submissive one gasps and orgasms. The other releases <i>some</i> of her binding and they fly off, saying 'We will not 'cum' here again'.\r\r#slave had forgotten how, ummm, kinky these faeries are. #Slaveheshe" + NonPlural(" leave") + " a bit distracted by thoughts of ropes, butterfly wings and aroused feelings.");
			slaveData.DifficultyBondage -= 2;
			Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0);
			return true;
		}
		
		Language.XMLGeneral("FaerieReward", true, xNode);
		return true;
	}
	
	public function DoFaerieTransform()
	{
		slaveData.FairyXF = 2000;
		coreGame.UpdateBasicSlaveSkills();
		DoEvent(9999);
		Diary.AddEntryLang("Faerie/CompleteTransform");
		SetLangText("FaerieTransform", xNode);
		if (coreGame.SlaveGirl.ShowFaerieTransformation() != true) {
			coreGame.UseGeneric = true;
			if (coreGame.UseImages) coreGame.ShowActImage(10019);
			if (coreGame.UseGeneric) AutoLoadImageAndShowMovie("Images/Trainings/Faerie/Event - Fairy Transformation.jpg", 1.1, 0);
		}
		slaveData.VarNymphomania += 10;
		slaveData.VarCharisma += 10;
	}
	
	public function HideAsAssistant()
	{
		super.HideAsAssistant();
		
		mcBase.ClipFairyMeeting._visible = false;
	}
	
	public function UpdateSlaveAsAssistant()
	{
		SetRescueFlag();
	}
}