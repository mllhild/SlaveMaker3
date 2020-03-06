// PonyTraining training
//
// Translation status: IMCOMPLETE

import Scripts.Classes.*;

class PonyTraining extends TrainingBase
{
	public function PonyTraining(cgm:Object)
	{
		super(null, cgm);
		
		ModuleName = "PonygirlTraining";
	}

	
	// Slave Maker Training
	
	public function StartSlaveMakerTraining()
	{
		if (coreGame.TestObedience(slaveData.DifficultyBondage - 5) && (slaveData.BitGagOK == 0 || coreGame.sPonyTrainer == 0)) {
			coreGame.OldNumEvent = 2.1;
			slaveData.DifficultyBondage = slaveData.DifficultyBondage - 2;
			coreGame.Generic.ShowSexActPonygirl(1);
			Points(0, 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0);
			if (SMData.PonygirlAware > 0) {
				AddText(coreGame.SlaveMeet + " a Mistress and her ponyslave, the slave is pulling her mistress in a cart.\r\r#slave and #super talk to the Mistress and the Mistress compliments #slavehimher as having the potential to be good " + coreGame.Plural("ponyslave"));
				if (slaveData.BitGagOK == 0) AddText(" and gives #slave " + coreGame.Plural("a bit-gag") + ", " + coreGame.Plural("a gag") + " in the form of a pony's bit");
				AddText(".");
			} else {
				AddText(coreGame.SlaveMeet + " a strange Mistress and her slave, the slave is pulling a cart like she is a pony!\r\r#slave and #super talk to the Mistress and are told about ponygirls,\r\r");
				PersonSpeak(56, "Ponygirls and sometimes ponyboys, are slaves in a form of submissive bondage where they become their Mistress's or Master's 'mount' and live a much simpler and pleasurable life. Their bodies, fitness and appearance is essential as is their ability to act like a human pony. They wear a bit-gag <i>always</i> and dress in a particular way needing a number of exotic items. Of course the gag is often removed to service their Master or Mistress, this dear one's tongue is very talented.\r\rThis life is not meant to be a punishment for the slave but a joyful, physical life free of worries and focused on serving their Master or Mistress.", true);
				AddText("\r\rThe Mistress gives #slave " + coreGame.Plural("a bit-gag") + ", " + coreGame.Plural("a gag") + " in the form of a pony's bit.\r\r");
				PersonSpeak(56, "Little " + coreGame.Plural("one") + " you will need other items to become a pony, but here is a start. Look forward to a joyful life!", true);
			}
			if (IsSupervising()) {
				var PonyMistress:Person = coreGame.People.GetPersonsObject("ponytrainer");
				if (!PonyMistress.IsAccessible()) {
					PonyMistress.SetAccessible();
					AddText("\r\rYou have never heard of this type of slave training and ask the Mistress more about it,\r\r");
					PersonSpeak(56, "My dear, I would love to help you train your little " + coreGame.Plural("slave") + " here but I am quite busy with my own ponies and my business at the race track. There is a trainer I know, Mistress Epona, who is very skilled in all aspects of ponyslaves, in fact she considers it a sort of religious obligation. She will be happy to teach you the basics of training a pony slave.", true);
					AddText("\r\rShe gives you instructions on how to find Mistress Epona and tells you she will speak to her shortly at the track and explain that you will <b>visit</b>.\r\rYou ask about 'the track' and the Mistress explains that some people like to race their ponyslaves, after all their bodies, their fitness is the most important aspect of their lives, and we all like an exciting contest.");
				}
			} else {
				if (coreGame.sPonyTrainer == 0) AddText("\r\r#assistant explains how #assistantheshe had never heard about this form of slave, and does not believe #assistanthisher " + coreGame.Master + " has either. The Mistress suggest that if she ever meets " + coreGame.ServantHisHer + " " + coreGame.Master + " she will recommend a trainer of the art, but she is busy now but often has business here.");
			}
			slaveData.BitGagOK = 1;
			coreGame.PonygirlAware = 1;
			SMData.PonygirlAware = 1;
			coreGame.Items.ShowItem(14, false, 0, 2);
			ShowPerson(11, 0, 0, 1);
		} else {
			ShowSupervisor();
			slaveData.DifficultyBondage = slaveData.DifficultyBondage - 1;
			temp = Math.floor(Math.random()*2) + 1;
			AutoLoadImageAndShowMovie("Images/Trainings/Pony/Walk - Ponygirl Meeting " + temp + ".jpg", 1, 1);
			if (slaveData.IsPonygirl()) AddText(coreGame.SlaveMeet + " a fellow");
			else AddText(coreGame.SlaveMeet + " a");
			if (SMData.PonygirlAware > 0) AddText(" ponygirl");
			else AddText(" slave");
	
			if (temp == 1) AddText(" tightly bound waiting for her Master or Mistress, tied by a chain between her nipples and clit. #slave");
			else AddText(" with a saddle, waiting for her Master or Mistress, wearing little more than her harness. #slave");
			switch(Math.floor(Math.random()*3)) {
				case 0:
					coreGame.OldNumEvent = 2.2;
					AddText(" removes her gag and the slave talks lovingly of her Master and the wonderful discipline and pleasure he gives her. The slave is quite aroused and #slave sees a large dildo inserted in her pussy.");
					if (coreGame.Aroused || (coreGame.SlaveAttitude == 1)) AddText("\r\rWhen they finish talking the slave asks #slave to replace her gag. #slave does so, sensuously rubbing her breasts on the girl's back as she does so. As the gag is replaced the girl convulses in orgasm.");
					else AddText("\r\rThe slave's hips had been slowly moving during their talk and as #slave leaves her she notices the girl shudder and orgasm.");
					return true;
				case 1:
					coreGame.OldNumEvent = 2.3;
					AddText(" removes her gag and they have a long discussion about submission and discipline.");
					if (coreGame.Aroused || (coreGame.SlaveAttitude == 1)) AddText("\r\rWhen they finish talking the slave asks #slave to replace her gag. #slave does so, sensuously rubbing her breasts on the girl's back as she does so.");
					return true;
				case 2:	
					coreGame.OldNumEvent = 2.4;
					AddText(" removes her gag and the slave with some fear of her Mistress who torments and whips her. She is brought to the edge of orgasm over and over and then whipped or abandoned.\r\rNightly she has to lick her Mistress to many orgasms but is never allowed one herself. She has to always wear a dildo on her pussy and an anal plug but they are not arranged to allow her to orgasm, just to torment.\r\rShe begs #slave to adjust her dildo to allow her to orgasm. ");
					if (coreGame.Aroused || (coreGame.SlaveAttitude == 1)) AddText("Without thinking ");
					AddText("#slave does so and the girl's hips move faster and faster and she quickly orgasms, crying and gasping. #slave wishes she could free her but #assistant is watching so she leaves the girl to her orgasm.");
					return true;
			}
			AddText("\r\r" + coreGame.SlaveVerb("leave") + " feeling oddly aroused.");
			Points(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 1, 3, 0, 0, 0, 0, 0);
		}		
	}

	
	public function SlaveMakerTraining() : Boolean
	{
		if (SMData.sPonyTrainer >= 1) return false;
		
		GetPerson("ponytrainer").GetPersonDetails();
		
		coreGame.genNumber = Math.round(SMData.sPonyTrainer * 10);
		XMLGeneral("SlaveMakerTraining", false, xNode);
		
		SMData.sPonyTrainer = SMData.sPonyTrainer + 0.1;
		if (SMData.sPonyTrainer >= 0.96) SMData.sPonyTrainer = 1;
		SMData.UpdateSlaveMaker();
		return true;
	}
	
	// Events
	// Warning no bondage
	public function EventsAsAssistant(possible:Boolean)
	{
		if (possible && coreGame.TotalBondageToday == 0 && coreGame.IsPonygirl() && !coreGame.BitFlag1.CheckBitFlag(21)) {
			
			coreGame.BitFlag1.SetBitFlag(21);
			coreGame.UseGeneric = false;
			if (coreGame.SlaveGirl.ShowSexActPonygirl() == false) {
				if (!coreGame.UseGeneric && coreGame.UseImages) coreGame.ShowActImage(17);
				if (coreGame.UseGeneric) coreGame.Generic.ShowSexActPonygirl();
			}
			XMLGeneral("SlaveTrainings/Ponygirl/NoBondagePonyslave");
			return true;
		}
		return false;
	}
	
	public function DoEventYesAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// 16 - remove harness
			case 16:
				coreGame.DifficultyBondage = coreGame.DifficultyBondage + 10;
				ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				coreGame.HarnessWorn = 0;
				coreGame.DonePonygirl = -1;
				coreGame.UpdateSlave();
				coreGame.ShowLeaveButton();
				coreGame.NumEvent = 9999;
				return true;
				
			// 17 - remove bitgag
			case 17:
				coreGame.HideStatChangeIcons();
				coreGame.PointsMod(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, -5, 0, 0, 5, 0);
				ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				coreGame.BitGagWorn = 0;
				coreGame.DonePonygirl = -1;
				coreGame.ShowLeaveButton();
				coreGame.NumEvent = 9999;
				return true;
				
			// remove ponytail
			case 18:
				coreGame.HideStatChangeIcons();
				coreGame.DifficultyBondage = coreGame.DifficultyBondage - 5;
				if (!coreGame.IsPermanentDickgirl()) coreGame.Icons.HideDickgirlIcon();
				coreGame.PointsMod(0, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -5, 0, 0, 0);
				ServantSpeak(Language.GetHtml("NormalSlave", "Assistants"));
				coreGame.PonyTailWorn = 0;
				coreGame.DonePonygirl = -1;
				coreGame.PlugInserted = 0;
				coreGame.ShowLeaveButton();
				coreGame.NumEvent = 9999;
				return true;

		}
		return false;
	}
	
	public function DoEventNoAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
			// 15 - wear ponytail
			case 15:
				coreGame.PonyTailWorn = 1;
				coreGame.PlugInserted = 1;
				
			// case 16, 17, 18 (and fall throught for 15)
			case 16:
			case 17:
			case 18:
				coreGame.NumEvent = 9999;
				coreGame.ShowLeaveButton();
				return true;

		}
		return false;
	}


	// Slave Status
	
	public function IsTrainingStarted(sd:Slave) : Boolean
	{
		if (sd == undefined) sd == coreGame;
		return sd.slPonyTraining > 0;
	}
	
	public function IsTrainingComplete(sd:Slave) : Boolean
	{
		if (sd == undefined) sd == coreGame;
		return sd.DonePonygirl == 1;
	}
	
	public function ChangeTraining(val:Number, sd:Slave)
	{
		if (sd == undefined) sd == coreGame;
		return sd.ChangePonyTraining(val);
	}

	
	// Items
	
	public function RemoveItemAsAssistant(item:Number) : Boolean
	{ 
		switch(item) {
			case 1:
				if (slaveData.IsPonygirl()) {
					XMLGeneral("RemoveTail",  true, xNode);
					coreGame.SelectEquipment.ShowOtherEquipment();
					coreGame.ShowDress();
					return false;
				}
				break;
			case 11:
				if (slaveData.IsPonygirl()) {
					XMLGeneral("RemoveHarness", true, xNode);
					coreGame.SelectEquipment.ShowOtherEquipment();
					coreGame.ShowDress();
					return false;
				}
				break;
			case 14:
				if (slaveData.IsPonygirl()) {
					XMLGeneral("RemoveBitGag", true, xNode);
					coreGame.SelectEquipment.ShowOtherEquipment();
					coreGame.ShowDress();
					return false;
				}
				break;
		}
		return true;
	}
	
	public function SetEquipmentTabsAsAssistant()
	{
		if (SMData.PonygirlAware > 0) nModuleTab = coreGame.SelectEquipment.SetTabDetails(Language.GetHtml("Pony", "Equipment"));
		else nModuleTab = 0;
	}
	
	public function ShowEquipmentTabAsAssistant(nTab:Number)
	{
		if (SMData.PonygirlAware <= 0 || nTab != nModuleTab) return;
		
		coreGame.SelectEquipment.AddEquipmentButton(1, 11, coreGame.HarnessWorn == 1, coreGame.HarnessOK > 0, coreGame.HarnessOK == 1 ? Language.GetHtml("BasicHarness", "Equipment") : Language.GetHtml("SuperiorHarness", "Equipment"), "R");
		coreGame.SelectEquipment.AddEquipmentButton(2, 1, coreGame.PonyTailWorn == 1, coreGame.PonyTailOK == 1, Language.GetHtml("PonyTail", "Equipment"), "y");
		coreGame.SelectEquipment.AddEquipmentButton(3, 14, coreGame.BitGagWorn == 1, coreGame.BitGagOK == 1, Language.GetHtml("BitGag", "Equipment"), "G");
	}
	
	// Acts
	
	// Ponygirl
	public function DoPlanningActionAsAssistant(Action:Number) : Boolean
	{ 
		if (int(Action) != 17) return false;
		
		if (coreGame.IsCatgirl()) {
			SetLangText("NoPonygirlCatgirls", "SlaveTrainings/Catgirl");
			return;
		}
		if (coreGame.PonygirlInterest > coreGame.sPonyTrainer) {
			SetText("You start to discuss life as " + Plural("a ponyslave") + " but " + SlaveVerb("look") + " almost disgusted and completely, emphatically refuses.\r\rYou will have to learn more about training such slaves before attempting to suggest this again.");
			coreGame.Refused(17, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -15, -2, 0, 0, -1, -15, 0);
			return;
		}
		if (coreGame.TestObedience(coreGame.DifficultyPonygirl, coreGame.Action)) {
			if (coreGame.TotalBondage < 5) {
				ServantSpeak(coreGame.SlaveHeSheUC + NonPlural(" need") + " to be more experienced with bondage before embarking on a life of bondage and submission.");
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 2, 0, 0, 0, 0, 0);
			} else if (coreGame.BitGagWorn == 0 || coreGame.HarnessWorn == 0 || (!coreGame.HasTail && coreGame.PonyTailWorn == 0)) {
				ServantSpeak(NameCase(coreGame.SlaveIs) + " not fully outfitted. " + coreGame.SlaveHeSheUC + " must be wearing a gag, a harness and a tail.");
				Points(0, 0, -5, 0, -5, 5, 0, 0, 0, 0, 0, -5, 2, 5, 5, 0, 0, 0, 0);
			} else {
				coreGame.TotalPony++;
				coreGame.SlaveGirl.ShowSexActPonygirl();
				if (coreGame.SelectActImage()) coreGame.Generic.ShowSexActPonygirl();
	
				if (coreGame.AppendActText) DoXMLAct("Ponygirl");
				coreGame.LevelUpSexAct(coreGame.Action);
				
				if (!coreGame.IsPonygirl()) {
					if (coreGame.AppendActText) {
						if (coreGame.SlaveGender > 3) SlaveSpeak("#master, we are your ponies, ride us!.", true);
						else SlaveSpeak("#master, #slavepronoun am your pony, ride me.", true);
					}
					Points(5, 0, -5, 0, -5, 5, 0, 0, 0, 0, 0, -5, 2, 5, 5, 0, 0, 1, 0, 0);
				} else {
					if (coreGame.AppendActText) {
						if (coreGame.SlaveGender > 3) SlaveSpeak("#master, we are your ponies again, mount us please!.", true);
						else SlaveSpeak("#master, #slavepronoun am your pony again, mount me please!.", true);
					}
					Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0);
				}
				if (coreGame.AppendActText) {
					AddText("\r\r");
					ServantSpeak("#slaves first action each night now will be bondage to reinforce #slavehisher place and for #slavehisher pleasure.", true);
				}
				coreGame.DonePonygirl = 1;
				if (coreGame.TotalPony == 1) coreGame.ChangePonyTraining(coreGame.sPonyTrainer * 5);
			}
		} else {
			
			coreGame.Refused(17, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -15, -2, 0, 0, -1, -15, 0);
			
		}
	}
	
	
	// Ending
	
	public function EndingStartAsAssistant() : Boolean
	{ 
		trace("Pony: " + coreGame.IsPonygirl() + " " +  coreGame.Score + " " + coreGame.BitGagWorn + " " + coreGame.HarnessWorn + " " + coreGame.PonyTailWorn + " " + coreGame.HasTail + " " + coreGame.slPonyTraining + " " + coreGame.sPonyTrainer);

		if (coreGame.IsPonygirl() && coreGame.Score > 50 && coreGame.BitGagWorn == 1 && coreGame.HarnessWorn == 1 && (coreGame.PonyTailWorn == 1 || coreGame.HasTail) && coreGame.slPonyTraining == (40 + (coreGame.sPonyTrainer * 20))) {
			// Ponyslave
			trace("pony ending");
			switch(coreGame.sPonyTrainer) {
				case 1: SetEnding(18, Language.XMLData.GetXMLString("EndingPonygirl/NameLevel1", "EndGame/Slave")); break;
				case 2: 
					if (coreGame.SlaveFemale) SetEnding(18, Language.XMLData.GetXMLString("EndingPonygirl/NameLevel2Female", "EndGame/Slave"))
					else SetEnding(18, Language.XMLData.GetXMLString("EndingPonygirl/NameLevel2Male", "EndGame/Slave"))
					break;
				case 3: 
					if (coreGame.SlaveFemale) SetEnding(18, Language.XMLData.GetXMLString("EndingPonygirl/NameLevel3Female", "EndGame/Slave"))
					else SetEnding(18, Language.XMLData.GetXMLString("EndingPonygirl/NameLevel3Male", "EndGame/Slave"))
					break;
					
			}
			if (coreGame.SlaveGirl.ShowEndingPonygirl() != true)	{
				ShowSexActPonygirl();
				if (coreGame.UseGeneric) coreGame.Generic.ShowSexActPonygirl();
			}
		}
		
		return false;
	}
	
	
	public function EndingFinishAsAssistant(total:Number) : Boolean
	{
		if (coreGame.NumFin == 18) {
			// Ponygirl
			AddText("You arrive at the address outside of the city, near the farm lands. The owner is outside raking leaves as you approach, and he greets you enthusiastically. He leads you out to the back of the house where you find a small, improvised stall containing a pile of fresh hay, a water trough, and a sack of feed. Resting on the hay is #slave, who hastens to rise at your approach.\r\r");
			SlaveSpeak("Neigh!", true);
			AddText("The owner laughs and tells you that's all #slaveheshe ever says, but it means that #slaveheshe's happy.\r\r");
			PersonSpeak(coreGame.Owner.GetOwnerName(), " I was surprised to find that you'd trained #slavehimher as a pony—I understand that it requires a lot of effort and special equipment. Still, I'm grateful. Not many slaves are obedient enough to be reduced to an animal.", true);
			AddText("\r\rThe owner takes #slave out of #slavehisher stall and attaches #slavehisher bit and bridle. " + coreGame.SlaveHeSheUC + " waits patiently as #slaveheshe is harnessed to a cart. The owner invites you and the Guild Representative to ride with him. You oblige, taking the reins. Soon #slave's toned legs are running before you, dragging the heavy cart behind.\r\r");
			PersonSpeak(coreGame.Owner.GetOwnerName(), " #Slaveheshe's been very well trained and prepared, I must say. I can tell you put a lot of thought in this. It used to take me forever to walk to town, but now that I have #slave I can go whenever I want.", true);
			AddText("\r\rYou enjoy the wind blowing on your face as the countryside passes by. Occasionally the owner cracks his whip to encourage #slave to move faster. After the ride ends, the owner escorts #slave back to #slavehisher stall, #slavehisher body glistening with the sweat of exertion. The owner smacks #slavehisher tail plug in appreciation, and then shuts the stall again.\r\r");
			PersonSpeakStart(coreGame.Owner.GetOwnerName(), " I'm thinking of having #slavehimher bred soon. ", true);
			if (coreGame.IsDickgirl()) AddText("It'll be good to get some use out of that cock once in a while.");
			PersonSpeakEnd("I think #slaveheshe'd like that.");
			AddText("\r\r#slave neighs enthusiastically in response.");
			coreGame.NumFin = 1000;
			return true;
		}
		return false;
		
	} 
	
	public function NumCustomEndingsAsAssistant() : Number { return 1; }
	
	public function ShowEndingsAsAssistant(num:Number)
	{
		AddText(Language.GetHtml("EndingPonygirl/Hint", "Endings"));
	}

}

