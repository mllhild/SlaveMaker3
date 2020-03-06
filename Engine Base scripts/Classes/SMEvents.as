// SMEvents - Slave Maker custom events
//
// Mainly Demonic Cock backgroupnd current'y
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class SMEvents extends SMDemonicCock
{
	//private var SMData:SlaveMaker;
		
	public function SMEvents(mc:MovieClip, cgm:Object)
	{
		super(mc, null, cgm);
		
		ModuleName = "SMEvents";
	}
	
	public function LearnNewGods()
	{
		if (SMData.TheologyTraining < 10) {
			SMData.TheologyTraining++;
			HideBackgrounds();
			coreGame.HideSlaveActions();
			BlankLine();
			switch(SMData.TheologyTraining) {
				case 1:
					coreGame.HideImages();
					Backgrounds.ShowSky(2);
					AddText("The nun talks for a time with you about the Lady Amaterasu, the Great Goddess of the Sun.\r\rShe explains that to bathe naked in the rays of the Lady is not shameful and slowly removes her robes in the sunshine. She warns you against parading your slaves naked for the purpose of tantalising and arousing others.");
					ShowPerson(24, 1, 2, 3);
					break;
				case 2:
					AutoLoadImageAndShowMovie("Images/Events/Gods - Inari.jpg", 1, 1);
					Backgrounds.ShowOverlayBlack();
					AddText("The nun tells you she is a priestess of the god and goddess Inari, who appears as a male");
					if (coreGame.DickgirlOn == 1) AddText(", female or hermaphrodite");
					else AddText(" or female");
					AddText(" as he/she desires. The God/Goddess is the god of rice and fertility, and foxes are particularly blessed.\r\rThe priestess talks about fertility, particularly scolding you about how sex is for expressing love and for procreation, not a matter of recreation and slaves as sex-toys is particularly wrong.");
					if (coreGame.DickgirlOn == 1) {
						AddText("\r\rShe explains how hermaphrodites are blessed of Inari as they express his/her nature. Almost all priestesses of Inari are hermaphrodites, and she briefly removes her robes to show her quite erect cock.");
						ShowPerson(24, 1, 2, 4);
					}
					break;
				case 3:
					AddText("Nervously the nun talks about Lord Tsukiyomi, the god of the Moon, and of many evil things in the world, but she stresses that this does not include demons as they follow no-one, fiercely free.\r\rShe explains that the evil ones gain power with the full moon, and stresses how, as a Slave Maker, you walk a thin line between good and evil and should take care.");
					if (coreGame.TentaclesOn == 1) {
						AutoLoadImageAndShowMovie("Images/Events/Gods - Tsukiyomi + Tentacles.jpg", 1, 1);
						AddText("\r\rShe talks of the tentacle monstrosities and how they are the children of Tsukiyomi and the goddess of food and desire, Ukemochi. They are children of the night and the dark, and are ruled by lust. They have come to hate their father, as he slew their mother in a fit of anger, and they have fled into the dark places of the world, avoiding his gaze.\r\rSometime long ago it is said they offended Inari by taking one of his/her beloved priestesses. It is said the priestess abandoned Inari out of the huge lust the tentacle creatures cause. Inari cursed them to never have female children, so now they hunt human women to satisfy their lusts and to bear their children. The nun wonders about Inari's curse, of course no-one questions the gods, but why that curse?\r\rEspecially as since then the monstrosities have had a particular taste for nuns...");
					} else AutoLoadImageAndShowMovie("Images/Events/Gods - Tsukiyomi.jpg", 1, 1);
					Backgrounds.ShowOverlayBlack();
					break;
				case 4:
					AddText("The nun happily talks of Fuijin, god of the wind and his friend, Raiden the god of thunder and lightning. These gods are often shown wearing the garb of demons, tiger-skins and with horns on their heads. She sternly explains that they are not demons, nor are they worshipped by demons. Their dress is an expression of their chaotic and sometime destructive nature, but they are gods and support their followers and the other gods.\r\rYou remember hearing a story about a slave girl taken in a far, far land. She dresses in a tiger-skin bikini and could generate lightning! Perhaps her people are the blessed of Raiden, like the foxes of Inari. The slave girl is said to have escaped and fled long ago.\r\r");
					AutoLoadImageAndShowMovie("Images/Events/Gods - Fuijin + Raiden.jpg", 1, 1);
					Backgrounds.ShowOverlayBlack();
					break;
				case 5:
					AddText("The nun calls for an acolyte to play some music, and talks with you about Benten, the goddess of love, beauty and elegance. All things that flow, including music, dance and speech are also in her favour. This being the land of Mioya, she is especially revered as the goddess of love and passion, and she is the favourite of courtesans and prostitutes.\r\rAs you talk a scantily clad acolyte steps out and dances seductively to the music. While you watch the nun cautions you against training slave-sluts, girls who desire only sex and want little else. The nun regretfully explains how the girl dancing had such training until she was rescued. For a long time she could only serve the goddess in taking, um, offerings. You look at the nun curiously and she waves the dancer over.\r\r");
					AddText("The dancer kneels before you and whispers a prayer to Benten while undoing your lower clothes. Before you can comment she finishes her prayer and leans down, ");
					if (SMData.Gender != 2) AddText("licking your cock expertly and passionately. Your cock springs erect and the girl takes you deep into her throat. She moves up and down, fucking your cock with her throat. Rapidly you strain and cum almost directly down her throat.");
					else AddText("and slowly licks your pussy with obvious experience and skill. She licks your pussy and then after a while sucking your clit, arousing you and making you orgasm strongly.");
					AddText("\r\rThe nun looks a little embarrassed and asks the girl to leave. She talks more of Benten, about how she favours cats and sometimes appears as a catgirl. It is also said the legendary True Catgirls worship her.");
					Backgrounds.ShowNight(2);
					AutoLoadImageAndShowMovie("Images/Events/Gods - Benten.jpg", 1, 1);
					break;
				case 6:
					AddText("The nun talks to you of Bishamon, the god of war and good fortune. He is also the divine punisher and it is said certain demons favour him and choose to punish the wicked in his name.\r\rThe nun suggests you find his favour in martial training.");
					AutoLoadImageAndShowMovie("Images/Events/Gods - Bishamon.jpg", 1, 1);
					Backgrounds.ShowOverlayBlack();
					break;
				case 7:
					AddText("The nun tells you the story of creation, the story of the first man Izanagi and his wife and sister Izanami. She tells of how their arguments and love brought life and death to the world.\r\rAs they are brother and sister, the land of Mioya permits the marriage of siblings, but under some restrictions to try and limit weak or sickly children. Any such union requires the blessing of the Divine Siblings.");
					coreGame.HideImages();
					Backgrounds.ShowLivingRoom(11);
					break;
				case 8:
					AddText("The nun tells you stories about Susanoo, the god of storms and the sea. He is a great trickster, loving jokes and is fond of all comedians. He is also a great warrior, wielding his sword Kusanagi and many warriors seek his favour.\r\rShe also tells you how he loves to tease his sister the Lady Amaterasu.");
					AutoLoadImageAndShowMovie("Images/Events/Gods - Sunanoo.jpg", 1, 1);
					Backgrounds.ShowOverlayBlack();
					break;
				case 9:
					AddText("The nun briefly talks about Kuni-Nushi the god of sorcery, medicine and alchemy. She advises you against using his drugs and potions, as many can have unexpected effects.\r\rShe also talks a little about Tenjin the god of sages and scholars, but she seems to have little knowledge of the god.");
					coreGame.HideImages();
					Backgrounds.ShowOther(3);
					break;
				case 10:
					coreGame.HideImages();
					AddText("The nun lectures you about Amatsu Mikaboshi, the god of evil and corruption, mainly preaching to you to avoid his ways. She is very, very insistent you avoid the seductions of his followers, the accursedly beautiful demon girls. She tells you to resist their amazing, passionate, orgasmic.....um..well avoid them!");
					Backgrounds.ShowOverlay(0);
					coreGame.config.ShowMonster("devilgirl", 1, 14, 2);
					break;
			}
			SMData.ShowSlaveMaker();
		}
	}
	
	public function LearnOldGods()
	{
		if (SMData.TheologyTraining < 8) {
			SMData.TheologyTraining++;
			HideBackgrounds();
			coreGame.HideSlaveActions();
			BlankLine();
			switch(SMData.TheologyTraining) {
				case 1:
					AutoLoadImageAndShowMovie("Images/Events/Gods - Matres.jpg", 1, 1);
					AddText("The priestess tells you about the gods, some reigning over a single lake or mountain, some of great power, like the Mother Goddess Matres, goddess of the sky, fertility, sex, passion and creation. She is a wild, passionate, free goddess, but is vengeful, cruel and spiteful for those who break her few rules. Matres wants us to protect the home, to honour guests and to joyfully embrace sex whenever we can, as it is the expression of her power, of fertility, passion and creation.\r\rWith that she gestures to her followers who remove their clothing ");
					if (SMData.Gender != 2) AddText("and invite you to fuck them to orgasm after orgasm. As you slide your cock into the moist and ready pussy of one of the acolytes");
					else AddText("and welcome you to lick and be licked to many mutual orgasms. As your tongue touches the moist pussy of an acolyte");
					AddText(" the priestess warns you of Matres's wrath. You are a Slave Maker, depriving girls of their freedom. You should make slaves who joyously live their life and celebrate passion. With that she kisses you ");
					if (SMData.Gender != 2) AddText("and pushes your ass, plunging your cock deep into her acolyte's pussy.");
					else AddText("over and over, lower and lower, moving toward your pussy.");
					AddText("\r\rMuch later, after joyfully offering your body to Matres, the priestess looks down on you as you rest. She warns you again of Matres's wrath.");
					Backgrounds.ShowForest();
					break;
				case 2:
					AutoLoadImageAndShowMovie("Images/Events/Gods - Epona.jpg", 1, 1);
					AddText("The priestess talks to you of Epona, the Goddess of the sacred horse. She emphasises the joy of riding horses and the great favour the goddess gives to horse racing and cavalry.");
					Backgrounds.ShowBeach();
					break;
				case 3:
					AutoLoadImageAndShowMovie("Images/Events/Gods - Herne The Hunter.jpg", 1, 1);
					AddText("The priestess tells you of Herne the Hunter, the god of hunting and the forest. He is the stern, vengeful protector of all forests and those who live there. It is said the faerie folk are dear to his heart and any who harm them will be hunted by the god Herne.\r\rShe talks of the Wild Hunt that Herne leads punishing those who incur his wrath. It is a wild, orgiastic affair, and it is said many of those in the hunt are animalistic or even the rumoured werewolves.\r\rSometimes though the hunt chases women or faeries, who at least secretly desire it. When captured a wild, joyous orgy celebrates the hunt and glorifies Matres. After many, many partners the hunted woman is returned to her home");
					if (coreGame.PregnancyOn) AddText(", always pregnant.");
					else AddText(".");
					Backgrounds.ShowForest(3);
					break;
				case 4:
					AutoLoadImageAndShowMovie("Images/Events/Gods - Lady of the Lake.jpg", 1, 1);
					AddText("The priestess takes you to the lake that lies to the south east of the city. On the way she tells you how water, lakes and rivers are sacred. Many have gods or goddesses, and the lake has a goddess called only The Lady of the Lake as she has never named herself otherwise. The Lady is a beautiful, pure spirit who grants peace and healing. She loathes the creatures of evil and the dark, and most especially the monstrous undead.");
					if (coreGame.TentaclesOn == 1) AddText("\r\rThe lady does not hate the tentacle monsters and seems to pity those creatures. She encourages her followers to enjoy the amazing lust of those creatures, but gives them instructions on how to escape from the creatures <i>after</i>.");
					AddText("\r\rWhen you arrive she strips naked and has you do the same and you wade in. She explains that you will make an offering to the Lady. The priestess stands close behind you and runs her hands over your body, reaching lower and lower. ");
					if (SMData.Gender != 2) {
						AddText("She sensuously caresses your cock, rubbing and stroking until you are erect. She then kisses your neck, stoking your cock");
						if (SMData.Gender == 3) AddText(" and using her other hand fingers and rubs your pussy");
						AddText(". You quickly feel your orgasm approach under her expert touch and cry out as your cum sprays out landing in the waters of the lake. The priestess gently moves your head and to your surprise you are sure you can see a dim outline of a face in the water, mouth open where your cum lands.");
					} else AddText("She sensuously runs her fingers over your pussy, her other hand lightly caressing your breasts. Faster, harder she masturbates you, kissing your neck and pinching your nipples. With a cry you orgasm and small squirts of pussy juice erupt from your pussy. As you do the priestess gently moves your head and to your surprise you are sure you can see a dim outline of a face in the water, mouth open where your juice lands.");
					Backgrounds.ShowLake();
					break;
				case 5:
					AddText("The priestess happily talks of Taranis, the god of thunder and lightning. Taranis is often thought of as an angry, passionate god who loves his followers but is quick to punish.\r\rYou remember hearing a story about a slave girl taken in a far, far land. She dresses in a tiger-skin bikini and could generate lightning! Perhaps her people are blessed of Taranis, like the foxes of Inari. The slave girl is said to have escaped and fled long ago.");
					AutoLoadImageAndShowMovie("Images/Events/Gods - Fuijin + Raiden.jpg", 1, 1);
					Backgrounds.ShowOverlayBlack();
					break;
				case 6:
					AddText("The priestess talks to you of Teutates, the god of war and of the tribe, of the community. He is also the divine punisher and it is said certain demons favour him and choose to punish the wicked in his name.\r\rThe priestess suggests you find his favour in martial training.");
					AutoLoadImageAndShowMovie("Images/Events/Gods - Bishamon.jpg", 1, 1);
					Backgrounds.ShowForest();
					break;
				case 7:
					AddText("The priestess tells you stories about Manannán, the god of the sea and ruler of the isles of the afterlife. He is a great warrior, carrying a large spear and a bottomless bag of many, many things.");
					AutoLoadImageAndShowMovie("Images/Events/Gods - Sunanoo.jpg", 1, 1);
					Backgrounds.ShowOther(1);
					break;
				case 8:
					AddText("The priestess briefly talks of Lugh, the master of all arts and crafts. The priestess seems to have little interest in Lugh but tells you a story of his cunning and skill.");
					coreGame.HideImages();
					Backgrounds.ShowOther(8);
					break;
			}
		}
		SMData.ShowSlaveMaker();
		if (!SMData.BitFlagSM.CheckBitFlag(2) && SMData.PonygirlAware > 0 && SMData.TheologyTraining > 1) {
			AddText("\r\rYou ask the priestess about Epona and ponygirls.\r\r");
			PersonSpeak(50, "Epona, like all the gods, wants her people to be free, the idea of a person in bondage continually is wrong. But...if the person is willing, it is said that Epona greatly favours those who honour the horse in that way. I have heard it said in a distant temple of Epona, all the acolytes dress as ponygirls. They wear the bit-gag and ponytail with pride, although it is said that most of their duties involve being 'mounted', doing their best to honour Matres and be pregnant as often as they can.");
			SMData.BitFlagSM.SetBitFlag(2);
		}
	}
	
	public function ShowSMIntroduction()
	{
		var image:MovieClip = coreGame.AutoAttachAndShowMovie("Intro - 7", 2, 2);
		image.Description.setStyle("borderStyle", "none");
		clearInterval(coreGame.intervalId4);
		coreGame.intervalId4 = setInterval(this, "ShowSMIntroduction2", 40, image);
		Backgrounds.ShowIntroBackground(4, 4, 13, 0, 0, 0, 0);
		image._visible = true;
	}
	
	public function ShowSMIntroduction2(image:MovieClip)
	{
		clearInterval(coreGame.intervalId4);
		
		var efftalent:Number = SMData.GetEffectivePackage();
	
		image.Description.setStyle("borderStyle", "none");
		
		image.Description.content.Text.wordWrap = true;
		image.Description.content.Text.autoSize = true;
		image.Description.tabChildren = false;
		image.Description.tabEnabled = false;
	
		var rich:Boolean = SMData.SMAdvantages.CheckBitFlag(5);
		var desc:String = "";
		
		if (SMData.SMAdvantages.CheckBitFlag(14)) {
			// Furry version
			desc = "You have no memories of your childhood, your first recollections are wandering in a mountainous location. You remember running, hunting and playing there for a time.\r\r";
		} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
			// Vampire version
			desc = "You are a member of the proud and secretive Vampire people, a race not human but you are very close, even to being sometimes able to interbreed. Normally your kind live secretly in small family groups in human towns and cities, but there are some special communities.\r\r";
		}
		
		switch (SMData.SMHomeTown) {
			case 0:
				// Country Town
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					desc += "You found your way to a country town, far from the captial of Mioya. You were taken in by a kind family they helped you to learn about the world. After a time they happily adopted you into their family. You found the town to be a quiet and peaceful place but little that is exciting or new happens there, but an excellent place to help you learn.";
					if (rich) desc += " Your new family was rich and powerful, and dominated the town. You lived in a large villa on the outskirts of the town, with many servants and slaves.";
				} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
					// Vampire version
					desc = "You were born in a country town, far from the captial of Mioya. A quiet and peaceful place but little that is exciting or new happens there.";
					if (rich) desc += " Your family was rich and powerful, and dominated the town using your limited mesmeric abilities and exotic nature. You lived in a large villa on the outskirts of the town, with many servants and slaves to supply the blood you need to live.";
					else desc += " Your family kept its true nature hidden but it was an open secret, the other towns people ignoring your nature and some discretely trading to supply the blood you need to live.";
				} else {
					desc = "You were born in a country town, far from the captial of Mioya. A quiet and peaceful place but little that is exciting or new happens there.";
					if (rich) desc += " Your family was rich and powerful, and dominated the town. You lived in a large villa on the outskirts of the town, with many servants and slaves.";
				}
				break;
			case 1:
				// Old Faith Stronghold
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					desc += "You found your way to a country town, far from the captial of Mioya. You were taken in by a kind family they helped you to learn about the world. After a time they happily adopted you into their family. You found the town to be a quiet and peaceful place , still dedicated to the worship of the Old Faith. Most of the people follow that old religion but some follow the new and are welcome by all.";
					if (rich) desc += " Your new family was rich and powerful, and dominated the town. You lived in a large villa on the outskirts of the town, with many servants and slaves.";
				} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
					// Vampire version
					desc = "You were born in a country town, far from the captial of Mioya. A quiet and peaceful place, still dedicated to the worship of the Old Faith. Most of the people follow that old religion but some follow the new and are welcome by all.";
					if (rich) desc += " Your family was rich and powerful, and dominated the town using your limited mesmeric abilities and exotic nature. You lived in a large villa on the outskirts of the town, with many servants and slaves to supply the blood you need to live.";
					else desc += " Your family kept its true nature hidden but it was an open secret, the other towns people ignoring your nature and some discretely trading to supply the blood you need to live.";
				} else {
					desc = "You were born in a country town in a remote valley, far from the captial of Mioya. A quiet and peaceful place, still dedicated to the worship of the Old Faith. Most of the people follow that old religion but some follow the new and are welcome by all.";
					if (rich) desc += " Your family was rich and powerful, and dominated the town. You lived in a large villa on the outskirts of the town, with many servants and slaves.";
				}
				break;
			case 2:
				// Amazon Tribe
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					if (coreGame.DickgirlOn == 1) desc = "You found your way to a small mountain valley ruled by hermaphrodite amazons. Men are slaves for labour and only rarely sex. Women control the men and are themselves for the sexual satisfaction of the ruling hermaphrodites.";
					else desc = "You found your way to a small mountain valley ruled by amazons. Men are the slaves of the women. used for labour and sex.";
					desc += "The ruling amazons are warriors, raiding other towns for slaves and loot. They sweep in on their horses and are very skilled the bow and spear.\r\rMen are completely dominated, kept in bondage and used as labourers and for sexual enjoyment.";
					if (coreGame.DickgirlOn) desc += " Women are also slaves, but freer, and they supervise the male slaves, when they are not called to service the rulers, hermaphrodites who prize strength and virility.";
					if (SMData.Gender == 1) desc += "\r\rYou were immediately enslaved, the lowest of the tribe, a male slave, dominated and completely controlled. After some careful planning you were able to escape, to freedom and eventually to #cityname.";
					else if (coreGame.DickgirlOn) {
						if (SMData.Gender == 3) desc += "\r\rYou were adpoted by the ruling hermaphrodites and became one of them, embracing their ways.";
						else desc += "\r\rYou were enslaved and spent a long time and the sexual plaything on the ruling hermaphrodites. Eventually you escaped and found your way to #cityname.";
					} else desc += "\r\rYou were adpoted by the ruling women and became one of them, embracing their ways.";
				} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
					// Vampire version
					if (coreGame.DickgirlOn == 1) desc = "You were raised in a small mountain valley ruled by hermaphrodite amazons. Men are slaves for labour and only rarely sex. Women control the men and are themselves for the sexual satisfaction of the ruling hermaphrodites.";
					else desc = "You were raised in a small mountain valley ruled by amazons. Men are the slaves of the women. used for labour and sex.";
					desc += "The ruling amazons are warriors, raiding other towns for slaves and loot. They sweep in on their horses and are very skilled the bow and spear.\r\rMen are completely dominated, kept in bondage and used as labourers and for sexual enjoyment.";
					if (coreGame.DickgirlOn) desc += " Women are also slaves, but freer, and they supervise the male slaves, when they are not called to service the rulers, hermaphrodites who prize strength and virility.";
					if (SMData.Gender == 1) desc += "\r\rYou were the lowest of the tribe, a male slave, dominated and completely controlled. After some careful planning you were able to escape, to freedom and eventually to #cityname.";
					desc += "\r\rYou family are of the Vampire people and do little to conceal your nature when in your mansion. When dealing in the city you keep it concealed, less people consider you undead or some form of monster.";
				} else {
					if (coreGame.DickgirlOn == 1) desc = "You were raised in a small mountain valley ruled by hermaphrodite amazons. Men are slaves for labour and only rarely sex. Women control the men and are themselves for the sexual satisfaction of the ruling hermaphrodites.";
					else desc = "You were raised in a small mountain valley ruled by amazons. Men are the slaves of the women. used for labour and sex.";
					desc += "The ruling amazons are warriors, raiding other towns for slaves and loot. They sweep in on their horses and are very skilled the bow and spear.\r\rMen are completely dominated, kept in bondage and used as labourers and for sexual enjoyment.";
					if (coreGame.DickgirlOn) desc += " Women are also slaves, but freer, and they supervise the male slaves, when they are not called to service the rulers, hermaphrodites who prize strength and virility.";
					if (SMData.Gender == 1) desc += "\r\rYou were the lowest of the tribe, a male slave, dominated and completely controlled. After some careful planning you were able to escape, to freedom and eventually to #cityname.";
				}
				break;
			case 3:
				// #cityname
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					desc += "You found your way to #cityname, a very large city and the captial of Mioya, center of political power and the slave trade. A city full of the nobility, diplomats, the rich, the powerful and the poor. A true mixing pot of the country.\r\rYou were found wandering confused, but fascinated and taken in by a kind family they helped you to learn about the world. After a time they happily adopted you into their family. You found the city to be a winderful, exciting place, the perfect place to lean of the world.";
					if (rich) desc += " Your new family is rich and powerful, and dominated the town. You lived in a large villa on the outskirts of the town, with many servants and slaves.";
				} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
					// Vampire version
					desc = "You were born in #cityname, the captial city of Mioya, center of political power and the slave trade. A city full of the nobility, diplomats, the rich, the powerful and the poor. A true mixing pot of the country. Living here you cannot help but become familiar with the ways of culture and refinement, and the considerable traffic in slaves.";
					if (rich) desc += " Your family is rich and powerful, and has considerable business dealings in the city and throughout the country. You lived in a large villa outside the city wall, both because it can be larger then anything in the city, and for some level of privacy. Your family has many servants and slaves, all obedient to you and the other family members.";
					desc += "\r\rYou family are of the Vampire people and do little to conceal your nature when in your mansion. When dealing in the city you keep it concealed, less people consider you undead or some form of monster.";
				} else {
					desc = "You were born in #cityname, the captial city of Mioya, center of political power and the slave trade. A city full of the nobility, diplomats, the rich, the powerful and the poor. A true mixing pot of the country. Living here you cannot help but become familiar with the ways of culture and refinement, and the considerable traffic in slaves.";
					if (rich) desc += " Your family is rich and powerful, and has considerable business dealings in the city and throughout the country. You lived in a large villa outside the city wall, both because it can be larger then anything in the city, and for some level of privacy. Your family has many servants and slaves, all obedient to you and the other family members.";
				}
				break;
			case 4:
				// Caravan
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					desc += "You were found by a travelling caravan and you joined them in their journies across the various lands. You were shown as a curiosity and did demonstrations of you animalistic abilities. You also happily sold your body, not realising people considered this wrong.";
					if (rich) desc += " Your caravan was very successful, accumulating a lot of wealth from both the talents of its members and the deals and their cunning.";
				} else if (SMData.SMAdvantages.CheckBitFlag(13)) {
					// Vampire version
					desc = "You were raised in a travelling caravan trading across the kingdom and also in neighbouring lands. All the members of the caravan are of the Vampire people, concealing their nature from the humans they trade with, and carefully feeding to not draw too much attention to themselves";
					if (rich) desc += " Your family was rich and powerful, and dominated the town using your limited mesmeric abilities and exotic nature. You lived in a large villa on the outskirts of the town, with many servants and slaves to supply the blood you need to live.";
					else desc += " Your family kept its true nature hidden but it was an open secret, the other towns people ignoring your nature and some discretely trading to supply the blood you need to live.";
				} else {
					desc = "You were raised in a travelling caravan trading across the kingdom and also in neighbouring lands. You have met a wide variety of the peoples and creatures of the world, learning how to bargain or fight them as needed.";
					if (rich) desc += " Your caravan was very successful, accumulating a lot of wealth from both the talents of its members and the deals and their cunning.";
				}
				break;
			case 5:
				// 5 = Elven Forest
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					desc += "You were found by an elf, wondering in the forests near the mountains. You were welcomed into their home and raise as one of their children.";
					if (rich) desc += " Your 'parents' were skilled arisans and you have always benefited from their skills and wealth.";
				} else {
					desc = "You are one of elves, raised in the deep woods and forests that are the natural home to your people. You know all forests intimately and are semdom threatened by any dangers in the gree-wood.";
					if (rich) desc += " Your parents were skilled arisans and you have always benefited from their skills and wealth.";
				}
	
				break;
			case 6:
				// 6 = Dark Elven Capital
				if (SMData.SMAdvantages.CheckBitFlag(14)) {
					// Furry version
					desc += "You were found wondering in some tunnels by one of the race called 'Dark Elves' a conquering race distantly related to the Wood Elves. Dominance and power is all important for them. They decided you would be of use to them and 'adopted' you, or more apprentised you. You leant much in your time in the capital of the Empire.";
					if (rich) desc += " Your parent played to game of politics well and amassed wealth and influence.";
				} else {
					desc += "You are one of the race others call 'Dark Elves' a conquering race distantly related to the Wood Elves. Dominance and power is all important for your people and you were raised in the center of power of your race, the capital of the Empire.";
					if (rich) desc += " Your parent played to game of politics well and amassed wealth and influence.";
				}
	
				break;
			case 7:
				// 7 = True Catgirl Tribe
				desc = "You are one of the race called the True Catgirls by humans. The True Catgirls live in tribes that wander the lands.";
				if (rich) desc += " Your tribe was very successful, accumulating a lot of wealth from both the talents of its members and their cautious trading.";
				break;
		}
		if (SMData.SMAdvantages.CheckBitFlag(14) && SMData.SMAdvantages.CheckBitFlag(13)) desc+= "\r\rYou had to hide your need to drink blood to live. Early you found people feared the undead and assumed were one of them! Since then you have discretly fed, trading favours for the blood, either monetary or sexual.";
	
		
		desc += "\r";
		if (efftalent > -1) {
			if (efftalent == 2 && SMData.Gender == 2) desc += "\r" + Language.GetHtml("Talent2DescriptionFemale", "Talents") + "\r";
			else desc += "\r" + Language.GetHtml("Talent" + efftalent + "Description", "Talents") + "\r";
		}
	
		desc += "                                                  ..........\r";
		if (SMData.SMHomeTown == 3) desc += Language.GetHtml("IntroCommonHomeTown", "City");
		else desc += Language.GetHtml("IntroCommon", "City");
		
		image.Description.content.Text.htmlText = coreGame.UpdateMacros(desc);
		image.Description.invalidate();
		
		image._visible = true;
	}


	// Events	
	
	public function DoEventNextAsAssistant() : Boolean
	{
		switch(coreGame.NumEvent) {
			
		// Trainings
		case 11001: coreGame.trainSlaveMaker.AttendCourtLord(); return true;
		// 11002 - lady farun - see PersonLadyFarun class
		case 11003: coreGame.trainSlaveMaker.AttendCourtAmbassadors(); return true;
		case 11004: coreGame.trainSlaveMaker.AttendCourtGuildMembers(); return true;
		case 11005: coreGame.trainSlaveMaker.AttendCourtOtherNobles(); return true;
		
		}
						
		return super.DoEventNextAsAssistant();
	}
	
	
	// Endings
	
	public function EndingFinishAsAssistant(total:Number) : Boolean 
	{
		if (coreGame.NumFin < 9002 || coreGame.NumFin > 9005) return false;
		
		return super.EndingFinishAsAssistant(total);
	}

		
	// Generai initialisation
	
	public function CanLoadSave() : Boolean { return false; }
}