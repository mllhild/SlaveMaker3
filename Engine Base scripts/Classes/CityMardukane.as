// City of Mardukane
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class CityMardukane extends City {
	
	// The places instances
	public var DocksPort:PlaceDocksPort;
	public var DocksSlavePens:PlaceDocksSlavePens;
	public var DocksSlavePensSecure:PlaceDocksSlavePensSecure;
	public var TownCenter:PlaceTownCenter;
	public var Slums:PlaceSlums;
	public var Farm:PlaceFarm;
	public var Palace:PlacePalace;
	public var Forest:PlaceForest;
	public var Lake:PlaceLake;
	public var RuinedTemple:PlaceRuins;
	public var BeachWalk:PlaceBeachWalk;
	public var BeachSwim:PlaceBeachSwim;
	public var BeachPrivate:PlaceBeachPrivate;
	
	// People instances
	public var LadyFarun:PersonLadyFarun;
	public var Knight:Person;
	public var Lord:Person;
	public var Prostitute:Person;
	public var HighClassProstitute:Person;
	public var Barmaid:Person;
	public var Maid:Person;
	public var Merchant:Person;
	public var Count:Person;
	public var CuteLesbian:Person;
	public var BountyHunter:PersonBountyHunter;
	public var PonyMistress:Person;
	public var SwimInstructor:PersonAlsha;
	public var SleazyBarOwner:Person;
	public var Singer:Person;
	public var Natsu:Person;
	public var Tachiba:Person;
	public var Astrid:Person;
	public var Idol:PersonIdol;
	public var SchoolGirl:PersonSchoolGirl;	
		
	// Constructors
	public static function main(cg:Object) : CityMardukane { return new CityMardukane(cg); }
	public function CityMardukane(cg:Object) { super(cg); }	

	public function DestroyModule()
	{
		super.DestroyModule();
		
		coreGame.DocksPort = null;
		coreGame.DocksSlavePens = null;
		coreGame.DocksSlavePensSecure = null;
		coreGame.TownCenter = null;
		coreGame.Slums = null;
		coreGame.Farm = null;
		coreGame.Palace = null;
		coreGame.Forest = null;
		coreGame.Lake = null;
		coreGame.RuinedTemple = null;
		coreGame.BeachWalk = null;
		coreGame.BeachSwim = null;
		coreGame.BeachRocks = null;
		coreGame.BeachPrivate = null;
		coreGame.SlaveMarket = null;
		coreGame.LadyFarun = null;
		coreGame.Knight = null;
		coreGame.Lord = null;
		coreGame.Prostitute = null;
		coreGame.HighClassProstitute = null;
		coreGame.Barmaid = null;
		coreGame.Maid = null;
		coreGame.Merchant = null;
		coreGame.Count = null;
		coreGame.CuteLesbian = null;
		coreGame.BountyHunter = null;
		coreGame.PonyMistress = null;
		coreGame.SwimInstructor = null;
		coreGame.SleazyBarOwner = null;
		coreGame.Singer = null;
		coreGame.Natsu = null;
		coreGame.Tachiba = null;
		coreGame.Astrid = null;
	}
	
	
	// 
	// Slave 
	// -----
	
	public function StartNewSlave()
	{ 
		super.StartNewSlave();
		
		if (SMData.SMAdvantages.CheckBitFlag(0) || SMData.SMAdvantages.CheckBitFlag(1)) {
			Count.SetAccessible();
			Lord.SetAccessible();
			Knight.SetAccessible();
			LadyFarun.SetAccessible();
		}
		if (SMData.SMInitialItems.CheckBitFlag(1) || SMData.SMSkills.CheckBitFlag(6)) PonyMistress.SetAccessible();
		
		// Special Events
		switch (SMData.SMSpecialEvent ) {
				
			// 6 = Inhuman Ancestry
			case 6:
			case 5:  // 5 = Demonic Cock
			case 7:
			case 8:
				RuinedTemple.SetAccessible();
				break;
		}
	}
		
	//--
	// Places
	//--
	//-------
	//BitFlags
	//-------
	
	// Slave Pens
	//  32  = Met Narana at demon pen
	//  33  = escape attempt
	//  34  = gave teddy bear
	//  35  = comfort route
	//  36  = met spider woman
	//  37  = did not give teddy bear
	
	// Ruins
	//  0	= Sareth quest, looking for mine specifically
	//  1   = Know where mine is
	//  2   = temporary permit for Ruins
	//  32  = searching for ruined mine
	//  33  = asked prostitute
	//  34  = asked high class prostitute
	//  35  = asked maid
	//  36  = asked knight
	//  37  = asked count
	//  38  = asked lord
	//  39  = asked barmaid
	//  40  = asked merchant
	//  41  = ruined mine cleansed
	//	42  = asked pony mistress
	//	43  = asked tena
	//	43  = asked irinia
	//	44  = asked lady farun
	
	// Farm
	//  32  = butterfly catgirl
	//  33  = tiger catgirl (dickgirl)
	//  34  = tiger catgirl (normal)
	//  35  = accept tiger catgirl training
	//  36  = pongirl ploughing met
	//  37  = pongirl ploughing is a dickgirl
	
	// Lake
	//  32  = took 'Nymph's Tears'
	//  33  = naked apron event
	
	// Palace
	//  see class PlacePalace
	
	// Slums
	//	32	= seen girls at brothel
	//	33	= met slave woman
	//	34  = cat girl at brothel
	
	// Town Center
	//	32	= catgirl
	//	33	= catburglar caught
	
	// BeachSwim
	//  32  = Tama met
	//  33  = Tama affected
	//  34  = Tama is a dickgirl
	//	35	= Muscle girl 1
	//	36	= Muscle girl 2
	//	37	= told of tri-rocks
	//	38	= mermaid assault
	
	// BeachWalk
	//  32  = Elf Met
	//	33	= catgirl
	
	// BeachPrivate
	//  32  = first catgirl meeting
	//	33  = met noblewoman
	//	34	= noblewoman a hermaphrodite
	//	35	= noblewoman did task
	//  36  = second catgirl meeting
	
	
	//-------
	// CustomFlag for the places
	//-------
	
	// Palace - see class PlacePalace
	// BeachSwim - Mermaid help - slave
	// BeachWalk - Mermaid help - slavemaker
	
	public function CreatePlaces()
	{
		//trace("Mardukane.CreatePlaces");
		if (arPlaces.length == 0) {
			//trace("//creating");
			DocksPort = new PlaceDocksPort(coreGame.WalkDocksMovie, coreGame, this);
			coreGame.DocksPort = DocksPort;
			DocksSlavePens = new PlaceDocksSlavePens(coreGame.WalkDocksMovie, coreGame, this);
			coreGame.DocksSlavePens = DocksSlavePens;
			DocksSlavePensSecure = new PlaceDocksSlavePensSecure(coreGame.WalkDocksMovie, coreGame, this);
			coreGame.DocksSlavePensSecure = DocksSlavePensSecure;
			TownCenter = new PlaceTownCenter(null, coreGame, this);
			coreGame.TownCenter = TownCenter;
			Slums = new PlaceSlums(coreGame.WalkSlumsMovie, coreGame, this);
			coreGame.Slums = Slums;
			Farm = new PlaceFarm(coreGame.WalkFarmMovie, coreGame, this);
			coreGame.Farm = Farm;
			Palace = new PlacePalace(null, coreGame, this);
			coreGame.Palace = Palace;
			Forest = new PlaceForest(coreGame.WalkForestMovie, coreGame, this);
			coreGame.Forest = Forest;
			Lake = new PlaceLake(coreGame.WalkLakeMovie, coreGame, this);
			coreGame.Lake = Lake;
			BeachWalk = new PlaceBeachWalk(coreGame.WalkBeachMovie, coreGame, this);
			coreGame.BeachWalk = BeachWalk;
			BeachSwim = new PlaceBeachSwim(null, coreGame, this);
			coreGame.BeachSwim = BeachSwim;
			BeachPrivate = new PlaceBeachPrivate(null, coreGame, this);
			coreGame.BeachPrivate = BeachPrivate;
			RuinedTemple = new PlaceRuins(coreGame.WalkRuinsMovie, coreGame, this);
			coreGame.RuinedTemple = RuinedTemple;
		}
		
		super.CreatePlaces();
	}
	
	public function GetPlaceObject(place:String) : Place
	{
		//trace("Mardukane.GetPlaceObject: " + place + " " + place.split(" ").join("").toLowerCase());
		// altenate names for xml access
		switch (place.split(" ").join("").toLowerCase()) {
			case "docks": return GetPlaceInstance(6.1);
			case "slavepens": return GetPlaceInstance(6.2);
			case "secureslavepens":
			case "slavepenssecure": return GetPlaceInstance(6.3);
			case "ruins": return GetPlaceInstance(8);
			case "beach": return GetPlaceInstance(9.1);
		}
		
		return super.GetPlaceObjectBase(place);
	}
	
	public function DoWalkNow()
	{
		trace("DoWalkNow " + coreGame.WalkPlace);
		
		switch (coreGame.WalkPlace) {
			case 6: 
				coreGame.StrEvent = "SelectLocation";
				DocksPort.DoWalkEvent();
				return;
			case 6.1: DocksPort.DoWalkLoaded(); return;
			case 6.2: DocksSlavePens.DoWalkLoaded(); return;
			case 6.3: DocksSlavePensSecure.DoWalkLoaded(); return;
		}
		return super.DoWalkNow();
	}
				
	public function WalkShortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean 
	{
		switch(keya) {
			case 65: 
				if (SMData.BitFlagSM.CheckBitFlag(3)) {
					DoWalk(1, -2);
					return true;
				}
				return false;
		}
		return super.WalkShortcuts(keya, key, bControl);
	}
	
	//--
	// People
	//--
	public function CreatePeople()
	{
		trace("Mardukane.CreatePeople");
		if (arPeople.length == 0) {
			trace("..creating city specific people");
			LadyFarun = new PersonLadyFarun(coreGame, this);
			coreGame.LadyFarun = LadyFarun;
			Knight = new PersonKnightShan(coreGame, this);
			coreGame.Knight = Knight;
			Lord = new PersonLord(coreGame, this);
			coreGame.Lord = Lord;
			Prostitute = new PersonMissN(coreGame, this);
			coreGame.Prostitute = Prostitute;
			HighClassProstitute = new PersonLadyOkyanu(coreGame, this);
			coreGame.HighClassProstitute = HighClassProstitute;
			Barmaid = new PersonBarmaidSora(coreGame, this);
			coreGame.Barmaid = Barmaid;
			Maid = new PersonMaidSumi(coreGame, this);
			coreGame.Maid = Maid;
			Merchant = new PersonMerchantRinno(coreGame, this);
			coreGame.Merchant = Merchant;
			Count = new PersonCountGossem(coreGame, this);
			coreGame.Count = Count;
			CuteLesbian = new PersonTena(coreGame, this);
			coreGame.CuteLesbian = CuteLesbian;
			BountyHunter = new PersonBountyHunter(coreGame, this);
			coreGame.BountyHunter = BountyHunter;
			PonyMistress = new PersonPonyMistress(coreGame, this);
			coreGame.PonyMistress = PonyMistress;
			SwimInstructor = new PersonAlsha(coreGame, this);
			coreGame.SwimInstructor = SwimInstructor;
			SchoolGirl = new PersonSchoolGirl(coreGame, this);
	
			Idol = new PersonIdol(coreGame, this);
			SleazyBarOwner = new Person("", coreGame, 26, 0, false, this);
			coreGame.SleazyBarOwner = SleazyBarOwner;
			Singer = new Person("", coreGame, 51, 0, false, this);
			coreGame.Singer = Singer;
			Natsu = new Person("", coreGame, 61, 0, false, this);
			coreGame.Natsu = Natsu;
			Tachiba = new Person("", coreGame, 72, 0, false, this);
			coreGame.Tachiba = Tachiba;
			Astrid = new Person("", coreGame, 16, 0, false, this);
			coreGame.Astrid = Astrid;
		}
		
		super.CreatePeople();
	}
	
	public function GetPersonsID(person:String) : Number
	{
		switch (person.split(" ").join("").toLowerCase()) {
			case "rinno": return 1;
			case "sora":
			case "barmaid": return 2;
			case "missn":
			case "miss.n": return 3;
			case "okyanu":
			case "ladyokyanu": return 4;
			case "sumi":
			case "maid": return 5;
			case "shan":
			case "knightshan":
			case "knight": return 6;
			case "countgossem":
			case "count": return 7;
			case "lord": return 8;
			case "farun":
			case "ladyfarun": return 9;
			case "tena":
			case "cutelesbian": return 10;
			case "epona":
			case "mistressepona":
			case "ponymistress": return 11;
			case "irina":
			case "bountyhunter": return 12;
			case "headlibrarianlillana":
			case "lillana": return 13;
			case "skuld": return 15;
			case "astrid": return 16;
			case "alsha": return 17;
			case "beachguide":
			case "marine": return 18;
			case "snow": return 19;
			case "idol":
			case "meigura": return 20;
			case "trainer":
			case "meesh": return 22;
			case "highpriestessdaruna":
			case "daruna": return 37;
			case "slut":
			case "narana": return 39;
			case "ladyazure": return 41;
			case "medium":
			case "misana": return 43;
			case "guard":
			case "sola": return 46;
			case "ladyfarunsmaid": 
			case "ladyfarun'smaid": 
			case "lara": return 47;
			case "mina": return 51;
			case "astridsmaid":
			case "astrid'smaid": return 52;
			case "milly":
			case "puppygirl": return 53;
			case "natsu": return 61;
			case "azana": return 68;
			case "leonthas": return 69;
			case "tachiba":
			case "ambassadortachiba":
			case "iceniambassador": return 72;
			case "gustaf": return 73;
		}
		return super.GetPersonsID(person);
	}
	
	public function HearGossip(person:Number, slut:Boolean, newg:Boolean)
	{
		coreGame.genNumber = person;
		coreGame.PersonName = People.GetPersonsName(person);
		AddText("\r\r" + Language.GetHtml("Gossiping", "People") + "\r\r");
		PersonSpeakStart("#person", "", true);
		switch(People.GetGossip(newg, 16)) {
			case 0:
				if (person == 8) AddText("My daughter is getting troublesome, she can be a bit of a wanton slut, not something I normally object to in women, but she is my daughter!");
				else {
					AddText("The Lord's daughter is being mischievous recently. I have heard she has been dabbling with many strange potions, looking for the perfect source of pleasure. Of course most of the potions were aphrodisiacs.");
					if (slut) AddText(" She is very free with her favours, and will fuck anyone who asks, male or female, singly or in groups. She is said to be really, really enthusiastic.");
				}
				break;
			case 1:
				if (person == 8) AddText("I loved my departed wife wholly and deeply. I will never remarry, no matter what the court or anyone says!");
				else AddText("The Lord was deeply in love with his departed wife. I hear he plans to never remarry, staying true and faithful. The court is unlikely to allow this and will probably force him into a political marriage.");
				break;
			case 2:
				if (coreGame.FurriesOn && SMData.BitFlagSM.CheckBitFlag(8) && person == 9 && slrandom(3) == 1) AddText("An expert recently told me the new exotic slaves, the animal like girls, are something unusual. They are not a race, or even a species of animal. There are just too few and too few on any one type. We also have never yet seen a male, such a pity. He thinks they are either cursed people who have lost their humanity, or exiles for another world. We sometimes see people who have traveled here from other places, one of them called it a 'dimension'.\r\rPersonally I wish I could find one of these slave for sale, especially a male.");
				else {
					AddText("I hear there has been some revolution or disruption in the Forest Kingdom. They were very shy and insular but we are now seeing their people in Mioya sometimes now. Sometimes they are called Elves and other-times Forestkin, but mostly here in Mioya 'slave'");
					if (slut) AddText(" I do hear they have no sexual restrictions...");
				}
				break;
			case 3:
				AddText("There has been considerable political pressure from the country of Firee pressing slave reforms and even outlawing slavery. The church fully supports any moves to outlaw slavery but the nobility are resisting. The ambassador from Firee has been asked to return home for a time and things are a bit tense between Firee and Mioya.");
				break;
			case 4:
				if (coreGame.TentaclesOn == 1 && SMData.BitFlagSM.CheckBitFlag(6) && slrandom(3) == 1) AddText("The tentacle monsters are nocturnal hunting women at night, but sometimes they attack in the daytime, from dark places. I have heard though about several women who were taken at the beach in the broad daylight.");
				else AddText("The faerie folk are a strange people, loving music and nature, but very, very passionate. Many would call them sluts with a taste for kinky sex, and they seem to love being slaves. They are difficult to keep captive and escape often, especially if not kept happy.\r\rThey have odd abilities, sometimes appearing very small, the size of your hand, but often as tall as you or I.");
				break;
			case 5:
				AddText("The waters of the Lake have healing and cleansing properties and are even said to wash away the taint of evil. The Lake is holy to both the new and old gods but for different reasons.");
				break;
			case 6:
				AddText("Have you noticed there is a walled keep next to the South Bridge on the Slums side., to the south of the road? The keep cannot be accessed at all and a few people I have asked about it know nothing.");
				if (person == 8) AddText(" My officials know nothing and it seems to have been there for centuries.");
				else AddText(" I think it pre-dates the city itself, and the  authorities are hiding something.");
				break;
			case 7:
				if (person == 3) AddText("One of my customers, I will not give a name, once hired my services. He was so shy and reluctant to do anything he just tried to talk to me about morality! I put an end to that conversation with my mouth and his cock. He looked relieved when I took the lead sexually.");
				else AddText("I once heard that Miss N. was in love with someone very highly ranked, or maybe just filthy rich. She was rejected and has decided to live her life devoted to sex and money.");
				break;
			case 8:
				AddText("The Head Librarian is a refined an intellectual Lady of a minor noble family. She is dedicated to the Library and seems to spend all her free time there. I do hear she has interests in ");
				if (slut) AddText("exciting stories of passion and love");
				else AddText("unusual stories");
				AddText(" and has a sizable personal collection.");
				break;
			case 9:
				if (person == 6) AddText("There are several knightly orders in Mioya but most of the knights and their men-at-arms are scattered throughout the country guarding the people against monsters, bandits and the like. I am the head of the city guard but it is a rather trying organisation to run. My men are somewhat insubordinate but at least I can keep them well trained.");
				else AddText("There are several knightly orders in Mioya but most of the knights and their men-at-arms are scattered throughout the country guarding the people against monsters, bandits and the like. The head of the city guard is a rather idealistic knight named Shan, a superb swordsman but a poor administrator. His subordinates virtually run the guard, sometimes without his knowledge or permission");
				break;
			case 10:
				AddText("The forest is a pleasant place full of lovely scenery and a lot of people walk there for the tranquility, if you keep to the edges. The older parts of the deep forest can get very wild with many strange noises and things. While there are few attacks or disappearances there, they do happen.\r\rEven deeper in the forest there are stories about a kingdom, but there are only that stories.");
				break;
			case 11:
				AddText("You should avoid the slums, it is uncontrolled with few patrols by the city guard. Dangerous people will try to rob you or even worse.");
				break;
			case 12:
				AddText("Once in my childhood I am certain I saw a ghost! It was the darkest night and she was only just visible, almost completely transparent, her feet completely invisible. She looked at me very sadly and I felt a strange feeling that I know well now was arousal. She gestured to me and I walked toward her, the feeling growing. Then I heard a loud noise, the sound of a whip, and she just vanished.");
				break;
			case 13:
				AddText("Have you met the new armourer Ellara? She is an artist with metal, wood and leather, and a beautiful woman as well. I have heard she has unusual tastes, in possessions and in lovers. She is said to take anyone, male or female, as her lover, as long as they are odd or unusual.");
				if (slut) AddText(" I once heard someone say she is a truly magnificent lover but very dominant and demanding.");
				break;
			case 14:
				AddText("The beach is a pleasant place to visit, but have you noticed how people act much more uninhibited here, almost wild ");
				if (slut) AddText("and following their lusts as they should?");
				else AddText("like people who do not control their passions?");
				break;
			case 15:
				AddText("Have you heard the rumours about a demon-worshipping cult that is gaining popularity? They say it is a secret cult dedicated to helping demons spread corruption and to serve their desires.");
				break;
		}
		PersonSpeakEnd();
	}

	
	private function ShowVisitLendCommon()
	{
		super.ShowVisitLendCommon();
		
		for (var i:Number = 1; i < 13; i++) mcVisitMenu["Person" + i]._visible = true;
		
		coreGame.SetButtonDetails(mcVisitMenu.Person10, false, true, People.GetPersonsName(1), undefined, "R");
		coreGame.SetButtonDetails(mcVisitMenu.Person1, false, true, People.GetPersonsName(8), undefined, "L");
		coreGame.SetButtonDetails(mcVisitMenu.Person2, false, true, People.GetPersonsName(7), undefined, "C");
		coreGame.SetButtonDetails(mcVisitMenu.Person3, false, true, People.GetPersonsName(9), undefined, "F");
		coreGame.SetButtonDetails(mcVisitMenu.Person4, false, true, People.GetPersonsName(6), undefined, "K");
		coreGame.SetButtonDetails(mcVisitMenu.Person12, false, true, People.GetPersonsName(2), undefined, "B");
		coreGame.SetButtonDetails(mcVisitMenu.Person7, false, true, People.GetPersonsName(5), undefined, "M");
		coreGame.SetButtonDetails(mcVisitMenu.Person8, false, true, People.GetPersonsName(10), undefined, "T");
		coreGame.SetButtonDetails(mcVisitMenu.Person9, false, true, People.GetPersonsName(3), undefined, "P");
		coreGame.SetButtonDetails(mcVisitMenu.Person11, false, true, People.GetPersonsName(12), undefined, "U");
		coreGame.SetButtonDetails(mcVisitMenu.Person5, false, true, People.GetPersonsName(11), undefined, "E");
		coreGame.SetButtonDetails(mcVisitMenu.Person6, false, true, People.GetPersonsName(4), undefined, "H");
	
		var ti:CityMardukane = this;
		mcVisitMenu.Person9.ActButton.onPress = function() { ti.DoVisit(3); }
		mcVisitMenu.Person12.ActButton.onPress = function() { ti.DoVisit(2);	}
		mcVisitMenu.Person7.ActButton.onPress = function() { ti.DoVisit(5); }
		mcVisitMenu.Person10.ActButton.onPress = function() { ti.DoVisit(1); }
		mcVisitMenu.Person3.ActButton.onPress = function() { ti.DoVisit(9); }
		mcVisitMenu.Person6.ActButton.onPress = function() { ti.DoVisit(4); }
		mcVisitMenu.Person4.ActButton.onPress = function() { ti.DoVisit(6); }
		mcVisitMenu.Person2.ActButton.onPress = function() { ti.DoVisit(7); }
		mcVisitMenu.Person1.ActButton.onPress = function() { ti.DoVisit(8); }
		mcVisitMenu.Person8.ActButton.onPress = function() { ti.DoVisit(10); }
		mcVisitMenu.Person5.ActButton.onPress = function() { ti.DoVisit(11); }
		mcVisitMenu.Person11.ActButton.onPress = function() { ti.DoVisit(12); }
	}
	
	public function DoVisitSelect()
	{
		mcVisitMenu.Person9._visible = true;
		mcVisitMenu.Person6._visible = true;
		mcVisitMenu.Person2._visible = Count.IsAccessible();
		mcVisitMenu.Person1._visible = Lord.IsAccessible();
		mcVisitMenu.Person4._visible = Knight.IsAccessible();
		mcVisitMenu.Person12._visible = Barmaid.IsAccessible() && !coreGame.IsAssistant("Sora");
		mcVisitMenu.Person7._visible = Maid.IsAccessible();
		mcVisitMenu.Person3._visible = LadyFarun.IsMet() || LadyFarun.IsAccessible();
		mcVisitMenu.Person8._visible = CuteLesbian.IsAccessible();
		mcVisitMenu.Person5._visible = PonyMistress.IsAccessible();
		mcVisitMenu.Person11._visible = BountyHunter.IsAccessible();
		mcVisitMenu.Person10._visible = true;
	}
	
	public function DoVisitNow(person:Number, walk:Boolean) : Boolean
	{
		switch (person) { 
			case 4: return coreGame.DoVisitHighClassProstitute(); 
			case 7: return coreGame.DoVisitCount(); 
		}
		return super.DoVisitNow(person, walk);
	}
	
	public function DoLendSelect()
	{	
		mcVisitMenu.Person9._visible = true;
		mcVisitMenu.Person6._visible = true;
		mcVisitMenu.Person2._visible = Count.IsAccessible();
		mcVisitMenu.Person10._visible = true;
		mcVisitMenu.Person1._visible = Lord.IsAccessible();
		mcVisitMenu.Person4._visible = Knight.IsAccessible();
		mcVisitMenu.Person12._visible = Barmaid.IsAccessible() && !coreGame.IsAssistant("Sora");
		mcVisitMenu.Person7._visible = Maid.IsAccessible();
		mcVisitMenu.Person3._visible = LadyFarun.IsMet() || LadyFarun.IsAccessible();
		mcVisitMenu.Person8._visible = CuteLesbian.IsAccessible();
		mcVisitMenu.Person5._visible = PonyMistress.IsAccessible();
		mcVisitMenu.Person11._visible = BountyHunter.IsAccessible();
	}
	
	public function AdjustLoaningMod(mod:Number) : Number
	{ 
		if (coreGame.LendPerson == 3 && Prostitute.CustomFlag == 0 && Prostitute.CheckBitFlag(32) && !IsDayTime()) mod -= 20;
		if (coreGame.LendPerson == 4 && HighClassProstitute.CustomFlag == 0 && HighClassProstitute.CheckBitFlag(32) && !IsDayTime()) mod -= 15;
		return mod;
	}
	
	public function DoLendNow(per:Number) : Boolean
	{
		switch (per) {
			case 4:
				// Check party
				if (HighClassProstitute.CustomFlag == 0 && HighClassProstitute.CheckBitFlag(32) && !IsDayTime()) {
					coreGame.modulesList.Parties.HighClassParty(8040);
					return true;
				}
				break;
			case 7: coreGame.DoLendCount(); return true;
		}
		return super.DoLendNow(per);
	}
	
	public function VisitLendShortcuts(keya:Number, key:Number, bControl:Boolean) : Boolean 
	{		
		switch(keya) {		
			case 66: 
				if (mcVisitMenu.Person12._visible) {
					DoVisit(2);
					return true;
				}
				return false;
			case 67:
				if (mcVisitMenu.Person2._visible) {
					DoVisit(7);
					return true;
				}
				return false;
			case 69:
				if (mcVisitMenu.Person5._visible) {
					DoVisit(11);
					return true;
				}
				return false;
			case 70:
				if (mcVisitMenu.Person3._visible) {
					DoVisit(9);
					return true;
				}
				return false;
			case 72:
				DoVisit(4); return true;
			case 75:
				if (mcVisitMenu.Person4._visible) {
					DoVisit(6);
					return true;
				}
				return false;
			case 76:
				if (mcVisitMenu.Person1._visible) {
					DoVisit(8);
					return true;
				}
				return false;
			case 77:
				if (mcVisitMenu.Person7._visible) {
					DoVisit(5);
					return true;
				}
				return false;
			case 80:
				DoVisit(3); return true;
			case 82:
				DoVisit(1); return true;
			case 84:
				if (mcVisitMenu.Person8._visible) {
					DoVisit(10);
					return true;
				}
				return false;
			case 85:
				if (mcVisitMenu.Person11._visible) {
					DoVisit(12);
					return true;
				}
				return false;
		}
		return super.VisitLendShortcuts(keya, key, bControl);
	}
	
	public function MeetPerson(personno:Number, choice:Number, personstr:String, say:String, evt:String) : Boolean
	{
		switch (personstr.toLowerCase().split(" ").join(""))
		{
			case "astrid":
				return MeetAstrid();
								
			case "knight":
			case "knightshan":
				return Knight.Meeting();
				
			case "meigura":
			case "idol":
				return Idol.Meeting();
				
			case "schoolgirl":
			case "snow":
				return SchoolGirl.Meeting();
				
			case "narana":
				return MeetNarana(Number(evt));
				
			case "tena":
			case "cutelesbian":
				return CuteLesbian.Meeting();
				
			case "alsha":
			case "swiminstructor":
				return SwimInstructor.Meeting();
				
			case "tama":
				return MeetTama();
				
			case "bountyhunter":
			case "irinia":
				return BountyHunter.Meeting();
				
		}
		if (super.MeetPerson(personno, choice, personstr, say, evt)) return true;
		return false;
	}
	
	
	// Specific People
	
	// The cities swimming instructor
	public function MeetSwimInstructor() { SwimInstructor.Meeting(); }
		
	// Tama, the beach girl
	private function MeetTama() : Boolean
	{
		coreGame.modulesList.MeetPerson(48, -1);
		SetText(coreGame.SlaveName)
		if (!BeachSwim.CheckBitFlag(32)) {
			if (IsDickgirlEvent()) BeachSwim.SetBitFlag(34);
			AddText(NonPlural(" meet") + " a young woman who introduces herself as Tana, ");
		} else AddText(" again " + NonPlural("meet") + " Tana ");
		return true;
	}
	
	// Narana, the demon fan girl
	private function MeetNarana(img:Number)
	{
		coreGame.modulesList.MeetPerson(39, -1);
		if (img == 1) People.ShowPerson(39, 0, 7, 1);
		else if (img == 2) People.ShowPerson(39, 1, 1, 2);
		if (DocksSlavePens.CheckBitFlag(32) && sd.BitFlag1.CheckBitFlag(42)) AddText(", she is Narana");
		if (DocksSlavePens.CheckBitFlag(32)) AddText(", she is Narana, the woman from in front of the demon cage");
		else if (sd.BitFlag1.CheckBitFlag(42)) AddText(", she is Narana, the medium from the party");
		else AddText(" introducing herself as Narana");
		return true;
	}
	
	// Astrid
	function MeetAstrid() : Boolean
	{
		if (coreGame.SlaveGirl.MeetAstrid() == true) return true;
		if (coreGame.BitFlag1.CheckBitFlag(20) && (!SMData.BitFlagSM.CheckBitFlag(4))) {
			AddText(SlaveVerb("ask") + " Astrid if she makes a potion called 'Nymph's Tears' and how to get a supply of it.\r\r");
			PersonSpeak(16, "Yes, I milk the main ingredients here and then refine and process it. I also make several other potions from the same materials.\r\rI have an agreement with several noble ladies to supply the potion to them exclusively. My word is my contact so I cannot supply any to you directly. There is a certain lady, a private tutor, who can supply you with doses. She normally 'teaches' at the Palace and can often be found there. She is also fond of the Lake and I have seen her there walking.", true);
			SMData.BitFlagSM.SetBitFlag(4);
			AddText("\r\r");
			return true;
		}
		return false;
	}
	
	
	// City specific trainings
	
	public function DoMartialTraining() 
	{
		// common part of the training
		if (super.DoMartialTraining()) return;

		var wskill:Number = SMData.GetWeaponSkill();
		if (SMData.WeaponType != 0 && wskill == 0) {
			People.ShowPerson(22, 1, 1);
			Backgrounds.ShowOther(12);
			AddText("You are approached by a man, quite arrogant looking and also very competent in his movements,\r\r");
			PersonSpeak(22, "I see you do not know how to handle your weapon there. I can train you in the basics. It will take 5 lessons for 50GP a lesson. After that you can train yourself. So shall I train you?", true);
			DoYesNoEvent(21);
		} else if (coreGame.BitFlag1.CheckBitFlag(49) == false && SMData.WeaponType != 0 && wskill < 5 && wskill > 0) {
			People.ShowPerson(22, 1, 1);
			Backgrounds.ShowOther(12);
			AddText("You train again with Meesh, he is a little insulting at times and always arrogant, but a good teacher.");
			SMData.TrainWeapon();
			SMMoney(-50);
		} else {
			coreGame.Sounds.PlaySound("Clang");
			SMData.SMPoints(1, 1, 0, 0.5, 0, -1, 0, 0, 0, 0, 0, 0, 2, 0);
			Backgrounds.HideBackgrounds();
			coreGame.Generic.ShowMovie("SMTrainingMartial", 1.1, 1, slrandom(6));
			
			if (wskill < 40) {
				if (SMData.TotalSMMartial == 1 || Math.floor(Math.random()*3) == 1) {
					AddText("You see a Knight of the realm training on the far side of the training area. From what you can see he is a superb swordsman, far beyond your skills.");
					People.ShowPerson(6, 0, 0, 1);
				}
			} else if (!Knight.IsAccessible()) {
				if (Math.floor(Math.random()*2) == 0) {
					People.ShowPerson(6, 1, 0, 3);
					AddText("At the end of your training you are invited to speak to a Knight Shan, a superb swordsman, and from what you have heard a highly honourable person. You speak for a time, and he expresses some admiration of your martial techniques.\r\rYou move to a nearby bar and have a few drinks and discuss many things, your slave training and his duties. You can strongly see his clean moral center and honour. He expresses a dislike of slavery but is willing to allow you your profession. You both talk and argue for a long while.\r\rEventually he suggests that you could send some of your slaves to <b>visit</b> and discuss morality and chivalry with him. He seem to be hoping to educate your slaves, and possibly <i>you</i>. He does mention that his servants only allow <i>well acted and stylish</i> girls who are <i>trying to follow the gods</i>.");
					Knight.SetAccessible();
				}
			}
		}
	}
	
	public function DoRelaxSleazyBar() 
	{
		if (super.DoRelaxSleazyBar()) return;
				
		if (!Count.IsAccessible()) {
			if (coreGame.VarCharisma < 50) {
				if (Math.floor(Math.random()*3) == 0 || SMData.TotalSMSleazyBar == 1) {
					People.ShowPerson(7, 0, 1, slrandom(2));
					BlankLine();
					switch(Math.floor(Math.random()*4)) {
						case 0: AddText("You see a small group at a table. You recognise the Count, a senior minister in the Lord's government. He has a girl from the bar sitting at his side, and he is rather crudely groping her breasts, her large, ample breasts."); break;
						case 1: AddText("You notice the Count, a senior minister in the Lord's government leaning back, looking distracted. When you next look he is smiling and a girl is standing up, licking her lips. You cannot help but notice her <i>very</i> large, exposed breasts."); break;
						case 2: AddText("You see the Count, a senior minister in the Lord's government, drinking and laughing with some associates. You would hesitate to call them friends as from what you hear the Count is not a sociable person. A female slave walks over carrying drinks, it appears she is his slave. You see she is completely naked, with the largest breasts you have seen on a woman. Large, full breasts with heavy weights hanging from her pierced nipples. She has what appears to be sizable plugs in pussy and ass.\r\rAs she puts the drinks down you see her raise a breast, removing the piercing, and placing the nipple to the Count's mouth. He sucks with obvious enjoyment..."); break;
						case 3: AddText("You see a small group at a table. You recognise the Count, a senior minister in the Lord's government. He has a slave-girl tied to his table on her back, arms and legs bound and a gag in her mouth. Every so often one of his companions stands and fucks the slave-girl, crudely and roughly. All the time, the Count plays with the slave-girl's breasts and nipples."); break;
					} 
					coreGame.LastActionDone = 2510.1;
					return;
				}
			} else {
				if (Math.floor(Math.random()*2) == 0) {
					People.ShowPerson(7, 1, 1, slrandom(2));
					AddText("You see a small group at a table. You recognise the Count, a senior minister in the Lord's government. He has a slave-girl tied to his table on her back, arms and legs bound and a gag in her mouth. Every so often one of his companions stands and fucks the slave-girl, crudely and roughly. All the time, the Count plays with the slave-girl's breasts and nipples.\r\rThe Count attracts your attention and gestures for you to join him.\r\r");
					PersonSpeakStart(7, "I have heard a little about the slave you are training. I have heard she is a well endowed, I mean well behaved slave. I would welcome the opportunity to talk to her sometime. Please have her <b>visit</b>, but please make sure she is able to act like an elegant lady.", true);
					if (SMData.Gender != 2) AddText("\r\rWould you like to use my slave?");
					else AddText("\r\rYou may remove my slave's gag and use her mouth?");
					PersonSpeakEnd();
					AddText("\r\rYou are almost insulted by the way they are abusing this slave. She is not being treated with respect, just as a sex toy. You politely refuse, implying you had already 'tipped' a girl recently.");
					AddText("\r\rYou know the Count is an educated man, skilled in stories and tales of mythology. He is an expert on agriculture and botany, so you will take #slave to visit sometime, but you will closely supervise the visit.\r\rYou also feel a sight sense of outrage about how the Count seems so tit obsessed...");
					Count.SetAccessible();
					coreGame.LastActionDone = 2510.2;
					return;
				}
			}
		}
		if (Math.floor(Math.random()*3) == 0) {
			AddText(" You attract a girl's attention, ");
			if (SMData.Gender != 2 && !coreGame.IsAssistant("Sora")) {
				coreGame.Generic.mcBase.SMTrainingSleazyBar.gotoAndStop(3);
				if (Barmaid.IsMet()) AddText("and you recognise her as the barmaid that #slave had befriended.");
				else AddText("who looks somewhat familiar but you cannot quite place her.");
				AddText(" You ");
			} else {
				coreGame.Generic.mcBase.SMTrainingSleazyBar.gotoAndStop(2);
			}
			AddText(" pay her a tip for a 'special' performance. She kneels before you and demonstrates her skill at dancing, tongue dancing...");
			coreGame.LastActionDone = 2510.3;
		}
	}
	
	public function AfterJob(astr:String) : Boolean
	{
		switch (astr.toLowerCase()) {
			case "sleazybar":
				if (Barmaid.IsAccessible() && !coreGame.IsAssistant("Sora")) {
					coreGame.HideAllPeople();
					People.ShowPerson(2, 0, 2, 6);
					coreGame.AssistantBackground._visible = true;
					coreGame.OnTopOverlayWhite2._visible = false;
					AddText("\r\rLater on, " + coreGame.SlaveMeet + " a girl entertaining in the bar...\r\r");
					DoEvent(8003);
					return true;
				}
				break;
		}
		return super.AfterJob(astr);
	}
		
	
	// Shops
	
	public function CreateShops()
	{
		if (GeneralShop == null) GeneralShop = new ShopGeneralShop(coreGame.ShopMenu, coreGame, "Shopping/Shops/RinnosShop", this);

		super.CreateShops();
	}

	// Events
	
	public function DoEventYes() : Boolean
	{
		if (BeachWalk.DoEventYesAsAssistant()) return true;
		if (BeachSwim.DoEventYesAsAssistant()) return true;
		if (RuinedTemple.DoEventYesAsAssistant()) return true;
		if (DocksPort.DoEventYes()) return true;
		if (CuteLesbian.DoEventYesAsAssistant()) return true;
		if (Merchant.DoEventYesAsAssistant()) return true;
		
		switch(coreGame.NumEvent) {
				
			// Slave Pens - Sareth, give teddy bear
			case 4025:
				coreGame.DoEventNext(4025);
				return true;
		}
		return super.DoEventYes();
	}
	
	public function DoEventNo() : Boolean
	{
		if (BeachWalk.DoEventNoAsAssistant()) return true;
		if (BeachSwim.DoEventNoAsAssistant()) return true;
		if (RuinedTemple.DoEventNoAsAssistant()) return true;
		if (DocksPort.DoEventNo()) return true;
		if (CuteLesbian.DoEventNoAsAssistant()) return true;
		if (Merchant.DoEventNoAsAssistant()) return true;
		
		switch(coreGame.NumEvent) {
				
			// Slave Pens - Sareth, don't give teddy bear
			case 4025:
				coreGame.DoEventNext(4026);
				return true;
		}
		return super.DoEventNo();
	}
	
	public function DoEventNext() : Boolean
	{
		switch (coreGame.StrEvent) {
			case "ReturnFromIsland":
				// return from the island
				SetText("#slave and #super board the boat to return to the city");
				if (!TravelToArea("City")) {
					Backgrounds.ShowBeach();
					AutoLoadImageAndShowMovie("Images/Cities/Mardukane/Events/Sailing 1.jpg", 1.1, 1);
				}
				return true;		
		}
			
		//trace("Mardukane,DoEventNext");
		switch (coreGame.NumEvent) {
			// 4000 - walk docks port
			case 4000:
				DocksPort.ResetWalkEvent();
				coreGame.WalkPlace = 6.1;
				DocksPort.DoWalkLoaded();
				return true;
				
			// 4002 - walk docks
			case 4002:
				DocksPort.ResetWalkEvent();
				coreGame.WalkPlace = 6;
				coreGame.StrEvent = "SelectLocation";
				DocksPort.DoWalkEvent();
				return true;
			 
			 // 4003 - walk slavepens general
			 case 4003:
				DocksSlavePens.ResetWalkEvent();
				coreGame.WalkPlace = 6.2;
				DocksSlavePens.DoWalkLoaded();
				return true;
				
			// 4009 - goto the island
			case 4009:
				SetText("#slave and #super board the boat for the island");
				if (!TravelToArea("Island")) {
					Backgrounds.ShowDocks();
					AutoLoadImageAndShowMovie("Images/Cities/Mardukane/Events/Sailing 1.jpg", 1.1, 1);
				}
				return true;		
				
			// 4004 - walk slave pens secure
			 case 4004:
				DocksSlavePensSecure.ResetWalkEvent();
				coreGame.WalkPlace = 6.3;
				DocksSlavePensSecure.DoWalkLoaded();
				return true;			
				
			// 4303 - walk beach rocks
			case 4303:
				DocksSlavePensSecure.ResetWalkEvent();
				coreGame.WalkPlace = 9.4;
				DoWalkNow()
				return true;				
		}

		if (BeachWalk.DoEventNextAsAssistant()) return true;
		if (BeachSwim.DoEventNextAsAssistant()) return true;
		if (BeachPrivate.DoEventNextAsAssistant()) return true;
		if (RuinedTemple.DoEventNextAsAssistant()) return true;
		if (LadyFarun.DoEventNextAsAssistant()) return true;
		if (Idol.DoEventNextAsAssistant()) return true;
		if (SchoolGirl.DoEventNextAsAssistant()) return true;
		if (BountyHunter.DoEventNextAsAssistant()) return true;
		if (Prostitute.DoEventNextAsAssistant()) return true;
		if (Barmaid.DoEventNextAsAssistant()) return true;
		if (Merchant.DoEventNextAsAssistant()) return true;
		
		return super.DoEventNext();
	}

	
	// Date/Time

	public function LocateTentacles() : Boolean
	{
		trace("Mardukane.LocateTentacles");
		if (super.LocateTentacles()) return true;
		
		// Tentacle location
		if (RuinedTemple.IsAccessible()) temp = Math.floor(Math.random()*4);
		else temp = Math.floor(Math.random()*3);
		switch (temp) {
			case 0: coreGame.TentacleHaunt = 1; break;
			case 1: coreGame.TentacleHaunt = 4; break;
			case 2: coreGame.TentacleHaunt = 6; break;
			case 3: coreGame.TentacleHaunt = 8; break;
		}
		return true;
	}
	

	public function StartEvening() : Boolean
	{
		if (strCurrentArea != "City") {
			ChangeArea("City");
			Money(-10);
		}
		return false;
	}
	
	public function AfterNight() : Boolean
	{
		if (strCurrentArea != "City") {
			ChangeArea("City");
			Money(-10);
		}
		return false;
	}

	
	// Load/Save
	public function Load(so:Object, bso:Object)
	{
		trace("Mardukane.Load");
		if (so.bCurrent == undefined) return;

		var lo:Object = bso;
		if (lo.BeachWalk == undefined) lo = so;
		if (lo.BeachWalk == undefined) {
			trace("Standard load");		
			super.Load(so);
			return;
		}
		
		CreatePeople();
		CreatePlaces();
		CreateShops();
		
		// Old version, either before 3.4 or initial release of 3.4
		var bUpgrade:Boolean = (lo == bso);
		
		BeachWalk.Load(lo.BeachWalk);
		BeachSwim.Load(lo.BeachSwim);
		BeachPrivate.Load(lo.BeachPrivate);
		DocksPort.Load(lo.DocksPort);
		DocksSlavePens.Load(lo.DocksSlavePens);
		DocksSlavePensSecure.Load(lo.DocksSlavePensSecure);
		TownCenter.Load(lo.TownCenter);
		Slums.Load(lo.Slums);
		Farm.Load(lo.Farm);
		Palace.Load(lo.Palace);
		Forest.Load(lo.Forest);
		Lake.Load(lo.Lake);
		RuinedTemple.Load(lo.RuinedTemple);
		SlaveMarket.Load(lo.SlaveMarket);
		
		LadyFarun.Load(lo.LadyFarun);
		Knight.Load(lo.Knight);
		Lord.Load(lo.Lord);
		Prostitute.Load(lo.Prostitute);
		HighClassProstitute.Load(lo.HighClassProstitute);
		Barmaid.Load(lo.Barmaid);
		Maid.Load(lo.Maid);
		Merchant.Load(lo.Merchant);
		Count.Load(lo.Count);
		CuteLesbian.Load(lo.CuteLesbian);
		BountyHunter.Load(lo.BountyHunter);
		PonyMistress.Load(lo.PonyMistress);
		
		var Librarian:Person = GetPersonsInstance("Librarian");
		Librarian.Load(lo.Librarian);
		var Dancer:Person = GetPersonsInstance("Dancer");
		Dancer.Load(lo.Dancer);
		
		SwimInstructor.Load(lo.SwimInstructor);
		SleazyBarOwner.Load(lo.SleazyBarOwner);
		Singer.Load(lo.Singer);
		Natsu.Load(lo.Natsu);
		Tachiba.Load(lo.Tachiba);
		Idol.Load(lo.Idol);
		SchoolGirl.Load(lo.SchoolGirl);
		
		Astrid.Load(lo.Astrid);
		
		// Shops
		GeneralShop.Load(lo.GeneralShop);
		Salon.Load(lo.Salon);
		Armoury.Load(lo.Armoury);
		
		// Upgrade
		if (bUpgrade && HighClassProstitute.PersonFlag == -5) HighClassProstitute.PersonFlag = -2000;

		super.Load(so);
	}

}
