// Parties
// Linked to Parties.swf
//
// Translation status: INCOMPLETE

import Scripts.Classes.*;

class PartiesModule extends SlaveModule
{
	private var TimeToProstituteParty:Number;
	private var TimeToHighClassParty:Number;
	
	// Constructor
	public function PartiesModule(mc:MovieClip, cgm:Object)
	{
		super(mc, cgm);
		TimeToProstituteParty = 0;
		TimeToHighClassParty = 0;
	}
	
	public function CanLoadSave() : Boolean { return false; }
		
	public function HideImages()
	{
		mcBase.EventParties._visible = false;
		mcBase.EventProstituteParty._visible = false;
	}
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		TimeToProstituteParty = 0;
		TimeToHighClassParty = 0;
		ResetBitFlags();
	}
	
	public function NewDay(nDays:Number)
	{
		TimeToProstituteParty -= nDays;
		TimeToHighClassParty -= nDays;
	}
	
	public function CheckReminder()
	{
		if ((coreGame.Prostitute.CustomFlag == 0 && coreGame.Prostitute.CheckBitFlag(32)) || (coreGame.HighClassProstitute.CustomFlag == 0 && coreGame.HighClassProstitute.CheckBitFlag(32))) {
			Language.ServantSpeakEnd();
			var consult:Boolean = false;
			if (coreGame.Prostitute.CustomFlag == 0) {
				consult = true;
				AddText("\r" + Language.GetHtml("CheckDiary", "Assistant") + "\r\r");
				ServantSpeakStart(Language.GetHtml("ProstituteParty", "Assistant"), true);
			}
			if (coreGame.HighClassProstitute.CustomFlag == 0) {
				if (!consult) AddText("\r\r" + Language.GetHtml("CheckDiary", "Assistant") + "\r\r");
				else {
					Language.ServantSpeakEnd();
					AddText(Language.GetHtml("AlsoNotes", "Assistant") + "\r");
				}
				ServantSpeakStart(Language.GetHtml("HighClassParty", "Assistant"), true);
			}
		}
	}
	
	public function ProstituteParty(eventno:Number)
	{
		sd = _root;
		
		coreGame.HideAssistant();
		switch (eventno) {
			// start of party
			case 8020:
				HidePlanningNext();
				sd.TotalProstituteParty++;
				AddText("Your friend, the prostitute, picks up #slave and takes #slavehimher to the home of a wealthy family. They enter via the servant's entrance and are taken to a changing area. #personprostitute explains, while changing into a maid uniform,\r\r");
				PersonSpeak(3, "The upper classes of Mioya are a contradictory people, they claim to follow the ways of the gods, but they keep slaves. The gods frown on prostitution, telling us sex is for love and procreation, but all of the upper class employ prostitutes for their parties. Who can blame them, we all love sex!\r\rTo keep a semblance of propriety, we have been hired as maids for the night, highly paid maids that are willing to do whatever our masters ask. Despite any issues you may have, tonight call anyone who looks like a guest, Master or Mistress.\r\rAs you see you should keep at least some of your maid's uniform on at all times.\r\rFor this evening you may accompany me if you like, I will introduce you to some people, and help you to enjoy yourself more. If you prefer you can stay with the other 'maids' and meet a wider range of guests at this party. You can also do some actual maid work but you will still have to do 'maid' work...", true);
	
				var aevent:Number = 8026;
				if (IsDickgirlEvent()) {
					aevent = 8028;
					AddText("\r\r#slaveis surprised when #personprostitute removes her clothes to see she has a large cock. Previous times #slave had seen her naked she had been completely female. #slave asks about it,\r\r");
					PersonSpeakStart(3, "I have had a special request from a certain Lady to indulge her taste for hermaphrodites. ", true);
					if (sd.IsDickgirl()) PersonSpeakEnd("As you are " + Plural("a hermaphrodite") + ", I would like you to accompany me, and 'assist' with the Lady. You will receive an extra payment.");
					else if (!coreGame.HasCock) PersonSpeakEnd("If you decide to accompany me, you will have to take a potion that will briefly give you " + Plural("a cock") + ", to help 'assist' me with the Lady. A much weaker version of the 'Priapus Draft' lasting a much shorter time, but much safer. If you do you will receive a bonus.");
					else PersonSpeakEnd("As you are " + Plural("male") + ", I would like you to accompany me, and 'assist' with the Lady. You will receive an extra payment.");
					temp = coreGame.DickgirlTesticles ? 4 : 15;
				} else {
					temp = 3;
				}
				ShowPerson(3, 1, 1, temp);
				coreGame.SlaveGirl.ShowMaidUniformSmall();
				Backgrounds.ShowOverlay(0);
				ResetQuestions("What does #slave do?");
				AddQuestion(aevent, "Accompany #personprostitute");
				AddQuestion(8027, "Stay with other 'maids'");
				AddQuestion(8030, "Serve as a Maid");
				ShowQuestions();
				return;
			
			// Accompany - normal
			case 8026:
				sd.BitFlag1.SetBitFlag(37);
				coreGame.UseGeneric = false;
				HideImages();
				HideSlaveActions();
				Backgrounds.ShowBedRoom(13);
				coreGame.UseGeneric = false;
				coreGame.SlaveGirl.ShowSexActFuck();
				if (coreGame.UseGeneric) coreGame.Generic.ShowSexActFuck(SMData.Gender == 3);
				ShowPerson(3, 0, 1, 3);
				coreGame.AssistantBackground._visible = true;
				coreGame.OnTopOverlayWhite2._visible = false;
				sd.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2);
				SetText("The prostitute escorts #slave and they take a serving platter of drinks each, and start circulating through the party. #personprostitute makes sure that their uniforms are very minimal, she actually wears nothing but stockings from the waist down.\r\rFor a time they just serve as normal, but slutily dressed ");
				if (sd.IsFemale()) AddText("maids");
				else AddText("servants");
				AddText(", until they meet a noble gentleman, who calmly seats #personprostitute down on a table, takes out his cock and starts fucking her, there in the main room of the party! ");
				if (sd.IsFemale()) AddText("As #slave watches #slaveheshe " + SlaveVerb("feel") + " hands pull down her panties and she is leant forward and a thankfully well lubricated cock pushes into her ass. As the cock sinks in fully she looks over and sees #personprostitute looking ecstatically happy as she is fucked.\r\rSometime later after having several men fuck her ass and one her pussy she sees a very happy looking #personprostitute watching.");
				else AddText("As #slave watches #slaveheshe" + SlaveVerb("feel") + " hands pull down #slavehisher pants and he is pushed into a large chair. A noblewoman orders him to stroke himself erect. He quickly does and then she impatiently straddles him, impaling her very wet pussy on his cock. He looks over and sees #personprostitute looking ecstatically happy as she is fucked.\r\rSometime later after having fucked several women he sees a very happy looking #personprostitute watching.");
				AddText("They gather their serving trays and while moving through the party #personprostitute talks a little about sexual etiquette.\r\rThey reach another group and #personprostitute seems to know them. She introduces #slave to the nobles there, and praises #slavehisher skills and beauty. The people look a little interested, ");
				if (sd.IsFemale()) AddText("then more so as one of them adjusts his trousers and takes out his erect cock.\r\rMuch later, #slave has met and fucked many noble gentlemen...");
				else  AddText("then more so as one Lady adjusts her dress, revealing her pussy.\r\rMuch later, #slave has met and fucked a number of noble women...");
				Points(0, 0, 4, 0, 0, 3, 2, 2, 2, 3, 3, -1, 3, 0, 0, 2, 1, 0, 0, 0);
				Money(75 + sd.VarFuck);
				DoEvent(8039);
				return;
				
			// Maids
			case 8027:
				sd.BitFlag1.SetBitFlag(39);
				HideImages();
				Backgrounds.ShowBedRoom();
				HidePerson(3);
				coreGame.SlaveGirl.ShowMaidUniformSmall();
				if (Math.floor(Math.random()*2) == 0) {
					temp = coreGame.IncestOn ? Math.floor(Math.random()*2) : 2;
					switch(temp) {
						case 0:
							AddText(SlaveVerb("spend") + " the party with two sisters who excitedly explain they are just here for the thrill and joy of being sexual playthings.\r\rFor a while a few guests visit for a diversion, and generally simply fuck one of the sisters or #slave. As one guest leaves #slave talks in passing to the sisters using the phrase 'your sister'. The guest asks if they are sisters and nervously they answer in unison 'yes'. The guest leaves a little excitedly.\r\rAfter that many, many guests, male and female visit, all wanting to see then fuck with each other, watching each other, doing lesbian play.\r\r#slave is also overwhelmed, asked to play with them, or 'entertaining' guests while waiting for the sisters.\r\rBy the end of the night #slave is tired but the sisters are exhausted but look very happy...");
							break;
						case 1:
							AddText(SlaveVerb("spend") + " the party with two women, apparently mother and daughter, and they appear to be possibly noble! They seem to be here for the sexual adventure.\r\rA few guests visit for a maid's service, but after a while the mother makes sure to mention their relationship. After that many more guests visit, all wanting a mother/daughter threesome. They also ask to see #slave play with them, but #slave is not neglected, having many guests ask #slavehimher to 'entertain' them.\r\rBy then end of the night they are all lying tired, having many partners over the night.");
							break;
						case 2:
							AddText(SlaveVerb("spend") + " the party with two friends who excitedly explain they are just here for the thrill and joy of being sexual playthings.\r\rFor a while a few guests visit for a diversion, and generally simply fuck one of the girls or #slave. As the girls are very enthusiastic, joyous even, and word of this spreads and more and more guests visit to enjoy them.\r\rBy the end of the night #slave is tired but the girls are exhausted but look very happy...");
							break;
					}
					if (coreGame.TestObedience(sd.DifficultyBrothel, 15)) {
						AddText("\r\r#slave loved it.");
						Points(0, 6, -4, 0, -6, 5, 0, 0, 0, 5, 6, 0, 6, 4, -10, 0, 8, 2, 1, 0);
					} else {
						AddText("\r\r" + SlaveVerb("was") + " very uncomfortable with the way she was treated.");
						Points(0, 6, -4, 0, -5, 5, 0, 0, 0, 5, 6, 0, 5, -4, -10, 0, 8, 0, -1, 0);
					}
					Money(50 + coreGame.VarFuckRounded);
					ShowMovie("EventParties", 1, 0, 9);
				} else {
					switch(Math.floor(Math.random()*2)) {
						case 0:
							AddText(SlaveVerb("spend") + " a pleasant night with two beautiful maids and they spend a lot of time just talking about society, religion and science. After a while #slave wonders why no guests are visiting and asks. The ladies act bewildered but they seem to be lying and after a while it seems that #slave is here to entertain them. They seem to have no sexual intentions, and they spend a quiet evening in talk, with plenty of food and drink provided.");
							break;
						case 1:
							AddText(SlaveVerb("spend") + " a pleasant night with two beautiful maids and they spend a lot of time just talking about society, religion and science. Occasionally a guest visits, always a noble Lady. The Lady talks with them about matters of society and such matters, but they always raise their skirts exposing their pussy for the eager tongues and lips of one of the maids or #slave. One Lady arrives and has all three on them lick her to orgasm, all the while talking and chatting happily.\r\rBy then end of the evening #slave has talked to and licked many Ladies of society...");
							break;
					}
					ShowMovie("EventParties", 1, 0, 11);
					Points(0, 3, 4, 3, 2, 0, 0, 0, 4, 2, 0, 0, 0, 0, 0, 0, -5, 2, 0, 0);
					Money(100 + sd.VarConversation);
				}
				DoEvent(8039);
				return;
				
			// Accompany - dickgirl 1
			case 8028:
				sd.BitFlag1.SetBitFlag(37);
				HideImages();
				HideSlaveActions();
				Backgrounds.ShowBedRoom(5);
				PersonSpeak(3, "This lady is the High Priestess of a certain church in our city. She is very hypocritical, the gods disapprove of lesbian sex, actually any not intended for procreation. This lady though has always hired me for lesbian sex, sometimes for hermaphrodite sex. Always sex with women. Sometimes she explains how the gods occasionally allow some lesbian acts, but it is the only sex she seems to have.\r\rOh well, not that it matters to me, as long as we get to fuck her and get paid for it. Between us we will have to fuck her for as much and as long as we can. She is an insatiable slut, my kind of woman, despite being a holy person.", true);
				if (!coreGame.HasCock) AddText("\r\r#slaveis handed a potion to drink, and a little nervously drink it. She feels a rush of warmth to her groin and a feeling of pressure. As she removes her lower clothes she sees a cock slowly grow, large but limp.");
				AddText("\r\r#slaveis introduced to the lady, who was sitting waiting for them, looking a little bored. She looks up and gestures for #slave to walk over...");
				ShowPerson(37, 1, 1, 3);
				ShowPerson(3, 0, 1, 4);
				coreGame.AssistantBackground._visible = true;
				coreGame.OnTopOverlayWhite2._visible = false;
				DoEvent(8029);
				return;
				
			// Accompany - dickgirl 2
			case 8029:
				HidePerson(37);
				AddText(SlaveVerb("walk") + " over and stands before the lady, who looks her up and down. The lady reaches out and gently takes #slave's" + coreGame.CockText() + " in her hands and then starts licking " + Plural("it") + " and sucking in a skilled blowjob, but stops when #slave's" + coreGame.CockText() + Plural(" is") + " quite erect. #slave looks around and sees #personprostitute stroking her now hard, erect cock. The lady gestures again, indicating that they should now fuck her.\r\rThroughout the evening #slave and #personprostitute fuck the lady singly or together, in her mouth, pussy and ass. Sometimes they lick her or just cuddle, but the lady is truly the insatiable slut #personprostitute described her as, and always wants them to fuck her more.\r\rBy the end of the night they are all very tired and drained, but very satisfied.");
				ShowMovie("EventProstituteParty", 1, 2, 10);
				sd.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2);
				Points(0, 0, 0, 0, 0, 5, 0, 0, 0, 5, 5, 2, 5, 0, -5, 2, 1, 2, 0, 0);
				Money(100 + coreGame.VarFuckRounded);
				ShowPerson(3, 0, 1, 4);
				coreGame.AssistantBackground._visible = true;
				coreGame.OnTopOverlayWhite2._visible = false;
				DoEvent(8039);
				return;
				
			// Serve as a maid
			case 8030:
				HideImages();
				HidePerson(3);
				coreGame.SlaveGirl.ShowMaidUniformSmall();
				ShowMovie("EventProstituteParty", 1, 0, 1);
				SetText("#personprostitute. waves goodbye as she leaves for her 'duties'. Another maid gives #slave a few choices of where to serve, the outside the house, upstairs, the basement or the dining area.\r\r");
				AskHerQuestions(8031, 8032, 8033, 8034, "Outside", "Upstairs", "Basement", "Dining", "Where does #slave go?");
				return;
				
			// Maid - Outside
			case 8031:
				SetText(SlaveName + NonPlural(" walk") + " outside expecting to serve drinks and the like. A man approaches and attaches " + Plural("a leash") + " to #slavehisher" + Plural(" neck") + " and explains that Masters and Mistress like to show off their slaves here. #slave can see several slaves and maids kneeling submissively, some crawling on all fours acting like dogs or cats. Their Masters or Mistresses leading them with leashes and demonstrating how animal-like they are.\r\r");
				if (sd.IsPonygirl()) {
					AddText(SlaveName + " neighs and prances showing #slavehisher training as a ponyslave.");
				} else {
					AddText("The man has #slave act like " + Plural("a dog") + ", barking, and walking around like a dog.");
				}
				if (coreGame.FurriesOn) {
					AddText("\r\rLater #slave overhears two Master talking,\r\r");
					PersonSpeak("Master 1", "I would like to have one of those furry slaves here, after all they are half animal and can truly be the part.", true);
					BlankLine();
					PersonSpeak("Master 2", "No, no, that is their nature. The point here is the slave is submitting to you, willing to become an animal for you. It is their desire to obey and follow your desire that is important.", true);
					AddText("\r\rThe two argue for a while, reaching no conclusion.");
				}
				if (sd.IsPonygirl()) sd.ChangePonyTraining(1);
				Points(0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 2, 0, 0, 1, 1, 0, 0);
				ShowMovie("EventProstituteParty", 1, 0, slrandom(2) + 4);
				DoEvent(8039);
				return;
				
			// Maid - Upstairs
			case 8032:
				var tempv:Number = slrandom(3) + 6;
				Backgrounds.ShowLivingRoom();
				ShowMovie("EventProstituteParty", 1, 1, tempv);
				Points(0, 0, -1, -1, 0, 0, 1, 1, 2, 0, 0, 1, 0, 0, 0, 0, 4, 0, 0, 0);
				SetText("#slaveis led upstairs and is given a tray of drinks to serve. " + coreGame.SlaveHeSheUC + " spends a while wandering around serving the guests, and quickly realises that this floor is full of small, intimate rooms. Many guests are using the rooms for private meetings, either with each other or to be 'served' by a maid, or butler.");
				if (tempv == 9) {
					AddText("\r\rIn one room #slavesee a small group, centered on a very richly dressed young woman, no more than 18 years old. She is very enthusiastically having sex with several men, taking their cocks in pussy and ass. When one man cums she orders another to take his place. One man says 'yes, your highness' but the young woman silences him. The young woman notices " + SlaveName);
					if (coreGame.HasCock) {
						AddText(" and orders #slavehimher to fuck her immediately. ");
						if (coreGame.SlaveGender > 3) AddText("The other men pull free and " + coreGame.SlaveA + " removes " + coreGame.SlaveHisHerSingle + "clothing, " + coreGame.SlaveHisHerSingle + " cock growing erect. " + coreGame.SlaveA + " thrusts into the woman's very wet pussy. Meanwhile " + coreGame.SlaveB + " pushes " + coreGame.SlaveHisHerSingle + " cock into the woman's ass. Quickly they fuck the woman who is very excited, having several orgasms, before they both cum into her pussy and ass. The young woman orders them to leave and other cocks to replace them.");
						else AddText("The man in the young woman's pussy pulls free and #slave removes #slavehisher clothing and strokes #slavehisher cock erect. #slave thrusts into the young woman's pussy, fucking her as the man under her fucks her ass. The young woman is very excited and has several orgasms before #slave cums into her pussy. The young woman orders #slavehimher to leave and another cock to replace #slavehishers.");
					} else {
						AddText(" and orders the men to fuck #slave as well. The men quickly strip #slave naked and with no foreplay cocks fill #slavehisher " + Plural("pussy") + ", " + Plural("ass") + " and " + Plural("mouth") + ". The evening passes, #slave continuously fucked next to the young woman as she is fucked over and over.");
					}
					Points(0, -1, 0, 0, -1, 1, 0, 0, 0, 2, 2, -1, 5, 5, -5, 0, 4, 0, 0, 0)
				}
				DoEvent(8039);
				return;
				
			// Maid - Basement
			case 8033:
				PlaySound("Whipping");
				Points(0, 2, 0, 0, -2, 0, 0, 0, 0, 0, 0, -2, 2, 4, 3, 0, 2, 0, 0, 0)
				SetText(SlaveVerb("suspect") + " what will be happening in the basement and #slavehisher suspicions are confirmed as " + coreGame.SlaveHeSheIs + " led in.\r\rMaids are tightly tied some clothed, some naked, but all are still wearing their frilled hat.\r\rOne maid is being lightly whipped but she appears very aroused and seems to be enjoying it.\r\rAnother maid is tied to a table and has a woman, quite naked, standing over her face, the maid licking her pussy. A man is standing near, naked and holding his cock, advancing to fuck the maid.\r\r#slavesee to #slavehisher surprise a maid dressed in a collection of leather straps, hitting a man's testicles as he is sitting tied and gagged. He is looking at the maid adoringly.\r\rAn elegant Lady is sitting, tightly bound but still wearing her gown. A butler is forcefully fucking his cock in her mouth, her face already splattered with cum. She looks happy in some way.\r\rA gentleman steps up to #slave and tells #slavehimher to remove #slavehisher clothing, ");
				if (sd.IsFemale()) AddText("but leave the #slavehisher maid's hat on...");
				else AddText("but leave #slavehisher tie on, but nothing else...");
				ShowMovie("EventProstituteParty", 1, 0, slrandom(2) + 1);
				DoEvent(8039);
				return;
				
			// Maid - Dining
			case 8034:
				SetText("#slaveis taken to a dining area but is surprised at what #slaveheshe sees. It is a smallish room, with a slightly tired looking maid surrounded by a few men, Each man is either masturbating or being masturbated by another maid. The maid in the center is holding a plate covered in cum and as #slave watches one of the men grunts and cums, making sure his cum falls on the plate. The maid starts licking up the cum and an elegant Lady explains to #slave,\r\r");
				PersonSpeakStart(64, "The admission for tonight's party is that all men must cum for this lucky maid so she can eat their cum. Your duty here tonight is to help the men. Remember their cum is <b<only</b> for the maid here!", true);
				if (coreGame.HasCock) {
					PersonSpeakEnd("\r\rBefore you start your duties here, you will have to also pay admission...");
					AddText("\r\rMaids step up and remove #slave's clothing, and then the Lady ");
					if (coreGame.SlaveGender > 3) AddText("stands between them and grasps their cocks in each hand. She skillfully manipulates, rubs and strokes their cocks until they are close to cumming. She tightly grips " + coreGame.SlaveB + "'s cock and stops stroking it. She speeds up on " + coreGame.SlaveA + " and quickly " + coreGame.SlaveHeSheSingle + " gasps, cumming spurts of cum onto the plate. The Lady releases " + coreGame.SlaveA + "'s cock and resumes stroking " + coreGame.SlaveB + " who moments later cums, " + coreGame.SlaveHisHerSingle + " cum mingling with " + coreGame.SlaveA + "'s.");
					else AddText("stands behind #slavehimher and grasps #slavehisher cock. She skillfully manipulates, rubs and strokes #slave's cock until #slaveis close to cumming. She speeds up, and aims #slave's cock and quickly #slaveheshe gasps, cumming spurts of cum onto the plate.");
				} else PersonSpeakEnd();
				AddText("\r\rWith that #slave spends to rest of the night assisting the male partygoers pay their admission, mostly using hand or mouth.");
				if (sd.IsFemale()) {
					if (IsDickgirlEvent()) {
						AddText("\r\rLater in the evening a woman, beautifully dressed in a long gown visits and asks " + coreGame.SlaveA + " for assistance. " + coreGame.SlaveA + " starts to explain that she has a duty here, and then sees the woman has parted her dress and has exposed her lovely cock. The woman gently kisses " + coreGame.SlaveA + " and then positions #slavehimher to 'assist' with #slavehisher ");
						if (sd.IsFemale()) AddText("pussy");
						else AddText("ass");
						AddText(".\r\rThe woman slowly fucks " + coreGame.SlaveA + " making moans and sounds, clearly very much enjoying herself. She fucks faster, her dress rustling and swirling. She starts making inarticulate moans and cries, nearing her climax. " + coreGame.SlaveA + " shudders and ");
						if (coreGame.HasCock) AddText("cums, her cock spurting her cum over the floor.");
						else AddText("orgasms strongly.");
						AddText(" The woman starts to pull out and joyfully cries out, cumming blast of cum over " + coreGame.SlaveA + "'s ass and back. She pants and apologises to the Lady who smiles and gestures for a maid. The maid walks over and licks all the cum off " + coreGame.SlaveA + " ass and back, carefully keeping it in her mouth. ");
						if (coreGame.HasCock) AddText("She then licks up " + coreGame.SlaveA + "'s cum off the floor. ");
						AddText("The maid walks over and slowly the cum dribbles out of her mouth onto the plate.");
					} else {
						AddText("\r\rSometimes a guest decides they need assistance by mouth");
						if (sd.IsFemale()) AddText(", pussy");
						AddText("or ass, but they always have to pull out and cum on the plate.\r\rLate in the evening a guest almost rudely pushes " + coreGame.SlaveB + " over and fucks #slavehimher hard and fast in #slavehisher ass. He fucks urgently and quickly muttering something about 'that bitch, good thing the Lord is' and he gasps, cumming fully and deeply in " + coreGame.SlaveB + "'s bowels. The Lady supervising pulls him off and slaps him, ordering him to leave. She then has another maid lick and suck " + coreGame.SlaveB + "'s ass, trying to get any cum she can. After a bit the maid walks over and slowly releases a blob of cum onto the plate.");
					}
					AddText(" The maid in the center then licks and swallows all the cum...");
				}
				Backgrounds.ShowLivingRoom(2);
				ShowMovie("EventProstituteParty", 1, 1, 4);
				Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 0, 0, 0, 0);
				DoEvent(8039);
				return;
				
			// end of party
			case 8039:
				HideSlaveActions();
				AddText("In the early hours of the morning #personprostitute takes #slave back to #slavehisher home and invites #slavehimher to spend the rest of the night, strictly sleeping only, they are both quite tired. After washing they lie down and fall asleep in each others arms. In the morning #personprostitute delivers #slavehimher to you,\r\r");
				coreGame.Prostitute.CustomFlag = Math.floor(Math.random()*2) + 3;
				Diary.AddEntryFull("Party with #personprostitute.", coreGame.GameDate + coreGame.Prostitute.CustomFlag, false, 0, false);
				Diary.AddEntry(SlaveName + " attends a party with #personprostitute.");
				PersonSpeak(3, "I enjoyed 'having' #slavehimher at the party. If #slaveheshe wants, there is another in " + coreGame.Prostitute.CustomFlag + " more days, come back then.\r\rHere is #slavehisher pay for attending the party.", true);
				AddText("\r\rshe hands over 200GP");
				Money(200);
				coreGame.ResetNotFucked();
				ShowPerson(3, 1, 0, 8);
				ShowPlanningNext();
				return;
				
		}
	}
		
	public function HighClassParty(eventno:Number)
	{
		sd = _root;
		
		coreGame.HideAssistant();
		switch (eventno) {
			// start of party
			case 8040:
				sd.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 2);
				sd.TotalHighClassParty = sd.TotalHighClassParty + 1;
				coreGame.ShowDressSmall();
				ShowPerson(4, 1, 2, 2);
				AddText("#personcourtesan, arrives with a servant to pickup #slave but first she reviews #slave\r\r");
				var convgoal:Number = 100;
				if (coreGame.MaxStat >= 150) convgoal = 150;
				var canattend:Boolean = (coreGame.VarConversationRounded >= convgoal);
				PersonSpeakStart(4, "", true);
				if (!canattend) AddText("I am sorry, you still need additional education in polite conversation. ");
				if (((sd.VarCharismaMod + sd.VarRefinementMod) > 25) || coreGame.IsDressCourtly()) {
					if (sd.IsFemale()) AddText("You are wearing a lovely and elegant dress, and some nice jewellery. They are perfectly suited to attend the function.");
					else AddText("You are wearing a lovely and elegant suit, and some nice jewellery. They are perfectly suited to attend the function.");
				} else {
					canattend = false;
					AddText("I am sorry, but your clothes and accessories are not really of the right style. I could not let you accompany me to the function. You need to wear a beautiful dress or one suited to the court.");
				}
				if (coreGame.VarRefinementRounded > 59) AddText(" #slave you are well spoken and courteous, and would be able to deal with the noble persons at the function.");
				else {
					AddText(" I am afraid #slave, you need some additional education in etiquette. I could not allow you to attend the function, it would disgrace my reputation.");
					canattend = false;
				}
				if (canattend) PersonSpeakEnd("\r\rVery well then, let us leave for the function.");
				else {
					HideBackgrounds();
					coreGame.HighClassProstitute.CustomFlag = Math.floor(Math.random()*3) + 6;
					PersonSpeakEnd("\r\rPlease train and try improving your attire and accessories. You can have #slavemakername lend you to me for the next function in " + coreGame.HighClassProstitute.CustomFlag + " days.");
					Diary.AddEntryFull("Function with #personcourtesan", coreGame.GameDate + coreGame.HighClassProstitute.CustomFlag, false, 0, false);
					return;
				}
				ShowPerson(41, 1, 3, 2);
				Backgrounds.ShowHouseOutside(8);
				AddText("\r\r#personcourtesan takes #slavehimher a very large mansion, obviously the home of a rich, noble family. At the door they are greeted by a noble lady, the host of the party. She is the noble lady who runs the hotspring near the beach! #personcourtesan introduces #slave as a protege. The lady smiles while looking at #slave\r\r");
				PersonSpeak(41, "I hope to spend some time with you later!", true);
				if (sd.TotalHighClassParty > 1) {
					AddText("\r\r#personcourtesan briefly shows #slave through the party, pointing out interesting places and people. So far the party has barely started, many guests have yet to arrive...");
					SetEvent(8045);
				} else {
					AddText("\r\r#personcourtesan shows #slave through the party, pointing out interesting places and people. So far the party has barely started, many guests have yet to arrive...");
					SetEvent(8041);
				}
				LoadModule("Engine/Parties.swf", this, "DoEventModule");
				return;
			
			// Intro - Dancing
			case 8041:
				HidePerson(41);
				ShowMovie("EventParties", 1, 0, 2);
				AddText("The first place they visit is a sizable ball-room.\r\r");
				PersonSpeak(4, "The nobility enjoy formal dancing, and this is a skill essential in our profession.\r\rSome gentlemen and ladies also like us to do somewhat less formal dancing too, but discretion is essential, we are not common prostitutes.", true);
				AddText("\r\r#slave" + NonPlural(" notice") + " the lady look at one of the maids....");
				DoEvent(8042);
				return;
				
			// Intro - Dinner
			case 8042:
				ShowMovie("EventParties", 1, 0, 4);
				AddText("The next place is a dining area. A few people are there having an early dinner.\r\r");
				PersonSpeak(4, "Polite, and flattering dinner conversation is probably our most important talent. Many customers just want to be entertained and made to feel special.\r\rOf course there are other more, energetic, talents we need to be prepared to use, even here.", true);
				AddText("\r\rShe gestures at a figure underneath the table, probably dressed as a maid...");
				DoEvent(8043);
				return;
				
			// Intro - Seance
			case 8043:
				ShowMovie("EventParties", 1, 0, 1);
				AddText("The next place is a secluded, dark room. A few people are there and a woman with a dark visor is running a seance.\r\r");
				PersonSpeak(4, "A lot of nobles like to dabble in the occult, small seances and fortune tellers. Few want to see the real occult and most mediums and fortune tellers are little better than fellow entertainers.\r\rThere are things to be learned here but also things to be avoided. For people like us, these events are strictly on an invitation basis.", true);
				AddText("\r\r" + SlaveVerb("feel") + " the medium is very convincing...");
				DoEvent(8044);
				return;
				
			// Intro - Maids
			case 8044:
				ShowMovie("EventParties", 1, 0, 6);
				AddText("She shows #slave through some general areas, all the time #slave sees very scantily clad maids. A majority have little or no clothing below the waist.\r\r");
				PersonSpeak(4, "I see you looking at the maids, they are here to attend to the guests in <i>any</i> way. We are guests at this party...", true);
				AddText("\r\rBy now more and more guests are arriving and #personcourtesan states\r\r");
				PersonSpeak(4, "I have to attend now to my employer. If you wish you can accompany me, but please understand my employer for this evening wants more than just conversation.\r\rIf you prefer you can instead visit one of the areas I have shown you or even enjoy the company of the maids.", true);
				ResetQuestions("Where does #slave go?");
				AddQuestion(8046, "Accompany #personcourtesan");
				AddQuestion(8049, "Dancing");
				AddQuestion(8050, "Dinner");
				AddQuestion(8051, "Maids");
				ShowQuestions();
				return;
				
			// second visit
			case 8045:
				HidePerson(41);
				PersonSpeak(4, "I have to attend now to my employer. I will do this privately, so I will ask you to attend the party yourself.", true);
				ResetQuestions("Where does #slave go?");
				AddQuestion(8049, "Dancing");
				AddQuestion(8050, "Dinner");
				AddQuestion(8051, "Maids");
				ShowQuestions();
				return;
	
			// Accompany - start
			case 8046:
				sd.BitFlag1.SetBitFlag(38);
				coreGame.Generic.ShowChoreCooking();
				sd.ChangeMaxStats(0, 0, 0, 0, 0, 0, 0, 0, 5);
				mcBase.EventParties._visible = false;
				ShowPerson(6, 0, 1, Math.floor(Math.random()*2) + 1);
				ShowPerson(4, 1, 1, 2);
				SetText("#personcourtesan takes #slave and they spend the evening with a very chivalrous nobleman, a knight of the realm. They spend a long time talking and flirting with him, eating sweet foods served by maids wearing full uniforms, probably his personal staff.\r\rAfter some time #personcourtesan speaks to #slave in private,\r\r");
				PersonSpeak(4, "The noble sir is somewhat shy, he wants us but is reluctant to make advances. He needs to be seduced, why don't you try.", true);
				AddText("\r\r#slave can try make subtle innuendo about #slavehisher interest in him, or be forthcoming and state #slavehisher sexual interest.\r");
				AskHerQuestions(8047, 8048, 0, 0, "Innuendo", "Forthcoming", "", "", "How will #slave seduce him?");
				return;
	
			// Accompany - innuendo
			case 8047:
				HideSlaveActions();
				mcBase.EventParties._visible = false;
				ShowPerson(4, 1, 0, 3);
				SetText("The Knight seems to not be aware of #slave's innuendo and after a while #personcourtesan whispers that some people need us to be blunt, and slowly removes her clothes.\r\rWhen naked she leans towards the blushing knight and undoes his pants pulling his rather erect cock out. He looks embarrassed but does not stop her.\r\rShe gives him a very skilled blowjob until he cums quite powerfully over her face and breasts.\r\rHe still looks a little embarrassed and redresses, and then asks them to leave, blushing.");
				Points(0, 2, 4, 2, 0, 0, 0, 0, 3, 1, 0, 0, 2, 0, 4, 2, -2, 0, 0, 0);
				DoEvent(8079);
				return;
				
			// Accompany - forthcoming
			case 8048:
				Backgrounds.ShowBedRoom(Math.floor(Math.random()*11) + 6);
				HideSlaveActions();
				mcBase.EventParties._visible = false;
				HidePerson(6);
				ShowPerson(4, 0, 1, 2);
								
				switch(Math.floor(Math.random()*3)) {
					case 0:
						PerformActNow(-50, "Anal");
						SetText("The knight looks almost relieved at #slave's direct approach. He blushes and then leans in and kisses her. With little skill, or apparent experience he removes their clothing. He looks embarrassed and touches her anus and looks a question. #slave nods her head and applies some lubricant to his cock. He thrust in crudely and a little painfully and fucks her hard and fast. He cums quickly, deeply in her ass, muttering an apology. He pulls free and lies down.\r\r#slave is disappointed but #personcourtesan gently pushes her down on to her back and starts licking her sore ass and the cum dribbling from it. She moves up and licks #slave's pussy with skill and enthusiasm until #slave orgasms with a cry.\r\rShe then suggests to the knight that he can try her ass now...\r\rSometime passes as they instruct the knight in the finer points of anal sex...");
						break;
					case 1:
						PerformActNow(-50, "Blowjob");
						SetText("The knight looks almost relieved at #slave's direct approach. #slave leans down and undoes his pants, taking out his rather erect cock, and gives him a skilled blowjob. He seems to enjoy it immensely, cumming powerfully.\r\r#personcourtesan suggests that she can also demonstrate a similar skill. Sometime later, the knight is lying tired after having blowjob after blowjob from #slave and #personcourtesan until he could not get an erection...");
						break;
					case 2:
						PerformActNow(-50, "Fuck");
						SetText("The knight looks almost relieved at #slave's direct approach. He blushes and then leans in and kisses her. With little skill, or apparent experience he removes their clothing. He looks a little embarrassed but thrusts his cock into #slave's pussy and fucks her hard and fast. He cums quickly, deeply in her pussy, muttering an apology. He pulls free and lies down.\r\r#slave is disappointed but #personcourtesan gently pushes her down on to her back and starts licking her pussy and the cum dribbling from it. She licks #slave's pussy with skill and enthusiasm until #slave orgasms with a cry.\r\rShe then suggests to the knight that he can try her now! Sometime passes as they instruct the knight in the finer points of sex...");
						break;
	
				}
								
				Points(0, 2, 4, 2, 1, 2, 0, 0, 3, 2, 2, 0, 3, 0, -3, 2, 4, 0, 0, 0);
				DoEvent(8079);
				return;
				
			// Dancing
			case 8049:
				sd.BitFlag1.SetBitFlag(40);
				ShowPerson(41, 0, 3, 2);
				SetText(SlaveVerb("spend") + " the evening dancing and chatting with other guests present.\r\rA few times #slaveheshe" + NonPlural(" notice") + " people discretely, but publicly have sex on the dance floor. No one seems to pay any attention.");
				ShowMovie("EventParties", 1, 0, 3);
				HidePerson(4);
				Points(3, 0, 1, 0, 0, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0);
				AddText("\r\rLater #slavesee the #persononsenowner arguing with a man, #slaveheshe cannot tell about what, but #persononsenowner is upset, " + SlaveName + NonPlural(" decide") + " to interrupt to help #persononsenowner.\r\r");
				AskHerQuestions(8065, 8066, 0, 0, "Ask #persononsenowner to dance", "Pretend to deliver a message", "", "", "How " + NonPlural("does") + " #slave interrupt?");
				return;
				
			// Dinner
			case 8050:
				temp = ((Math.floor(Math.random()*2))*8) + 5;
				ShowMovie("EventParties", 1, 0, temp);
				SetText(SlaveVerb("spend") + " part of the evening eating dinner and chatting with other guests.\r\r");
				if (temp == 13) {
					AddText("Part way through the meal, a large covered tray is placed on the dining table. The butler serving removes the cloth and #slavesee a pair of girls lying on the platter with food laid out over their bodies. There is a small round of applause and the diners carefully eat the food from off the girls.");
				} else {
					AddText("After a while #slaveheshe" + NonPlural(" hear") + " some muffled noise and looks up. A slave is bound near the roof, made to be some sort of odd candelabra. #slaveis a bit offended by this and quietly retreats from the dining room.");
				}
				AddText("\r\rAs " + SlaveName + NonPlural(" glance") + " away #slaveheshe" + NonPlural(" see") + " an elegant but somewhat imperious Lady who suggests that maybe #slaveheshe would like something different? There is a seance underway, how about visiting it?");
				HidePerson(4);
				sd.BitFlag1.SetBitFlag(40);
				Points(0, 0, 3, 3, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0);
				AskHerQuestions(8056, 8060, 0, 0, "Sure, lets attend", "No thanks, lets talk more here", "", "", "What is #slave's reply");
				return;
				
			// Maids
			case 8051:
				HidePerson(4);
				sd.BitFlag1.SetBitFlag(40);
				AddText("Would #slave like to enjoy to service of a maid, or would #slaveheshe like to chat with them or even help them?\r");
				AskHerQuestions(8052, 8055, 0, 0, "Maid Service", "Chat and Help", "", "", "How does #slave wish to visit the maids?");
				ShowMovie("EventParties", 1, 0, 11);
				HidePerson(4);
				return;
				
			// Maid - sex
			case 8052:
				coreGame.ResetNotFucked();
				Backgrounds.ShowBedRoom(Math.floor(Math.random()*11) + 6);
				HidePerson(4);
				if (sd.IsDickgirl()) {
					ShowMovie("EventParties", 1, 1, 7);
				} else {
					mcBase.EventParties._visible = false;
					if (sd.IsFemale()) PerformActNow(-50, "Lesbian");
					else PerformActNow(-50, "Fuck");
				}
				SetText(SlaveVerb("attract") + " the attention of a cute maid and they retire to a private room.\r\rThe maid entertains #slave with skill and obvious pleasure.\r\rAfter they talk for a bit ");
				switch(Math.floor(Math.random()*2)) {
					case 1:
						AddText("the maid explains she is the daughter of the Lord, a true princess of the land. She loves to disguise herself and have sex with as many of her fathers nobles as she can. So far no one has recognised her!");
						break;
					case 0:
						AddText("the maid seems very odd, seductive and almost mesmeric...");
						DoEvent(8053);
						return;
				}
	
				var fuckinc:Number = 0;
				if (coreGame.StrapOnWorn == 1) fuckinc = 1;
	
				if (coreGame.LesbianTraining) Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				Points(0, 2, 0, 0, -3, 0, 0, 0, 0, 0, fuckinc, 0, 2, 3, -2, 3, 2, 0, 0, 0);
				HighClassParty(8078);
				return;
				
			// Maid - demon girl
			case 8053:
				HideSlaveActions();
				SetText("The maid seems to change before #slave's eyes and starts whispering strange seductive words. ");
				if (sd.IsFemale()) {
					if (IsDickgirlEvent()) {
						temp = 10;
						AddText("#slaveis aware of the girl's hot, hard, large cock fucking #slavehimher over and over, and taking hot loads of cum in mouth, pussy, ass, ass, and ass.\r\rWhen the 'maid' leaves #slave follows and is a daze offers herself to anyone and everyone who wants her.\r\rBy the end of the evening she has met and fucked many and has a reputation as a slut.");
					} else { 
						temp = 8;
						AddText("#slaveis aware of the girl's long, long tongue licking her to orgasm after orgasm.\r\rWhen the 'maid' leaves #slave follows and in a daze offers herself to anyone and everyone who wants her.\r\rBy the end of the evening she has met and fucked many and has a reputation as a slut.");
					}
				} else {
					temp = 8;
					AddText("#slaveis aware of the girl's long, long tongue licking his cock to climax after climax.\r\rWhen the 'maid' leaves #slave follows and in a daze offers himself to anyone and everyone who wants him.\r\rBy the end of the evening he has met and fucked many and has a reputation as a slut.");
				}
				ShowMovie("EventParties", 1, 1, temp);
				HidePerson(4);
				Points(0, 0, -5, 0, 0, 2, 0, 0, 0, 4, 4, -4, 8, 0, 8, 3, 6, 0, 0, 0);
				HighClassParty(8078);
				return;
				
			// Maid - visit
			case 8055:
				Backgrounds.ShowBedRoom(Math.floor(Math.random()*11) + 6);
				SetText(SlaveVerb("spend") + " the evening talking with the maids, many fellow slaves. " + coreGame.SlaveHeSheUC + NonPlural(" help") + " a little with their serving tasks.\r\r" + coreGame.SlaveHeSheUC + " rapidly sees the main job of the maids at this party...");
				ShowMovie("EventParties", 1, 1, 7);
				coreGame.StartChangeImage(4000, "EventParties", 12);
				HidePerson(4);
				Points(0, 2, -1, 2, 0, 0, 2, 2, 2, 0, 0, 0, 2, 0, 4, 2, -5, 1, 0, 0);
				HighClassParty(8078);
				return;
				
			// Seance
			case 8056:
				ShowDressSmall();
				sd.BitFlag1.SetBitFlag(40);
				HidePerson(41);
				HidePerson(4);
				ShowPerson(39, 1, 2, 2);
				Backgrounds.ShowOther(3);
				mcBase.EventParties._visible = false;
				SetText(SlaveVerb("walk") + " into the seance room, the Lady screams and runs away. A strange thing is forming out of the air and is holding the medium, squeezing her breasts. As #slave looks the medium moans and clearly orgasms, and the figure start wavering...");
				AskHerQuestions(8057, 8058, 8059, 0, "Wait", "Run to Help", "Aroused, so Masturbate", "", "What " + Plural("does") + " #slave do?");
				return;
				
			// Wait
			case 8057:
				AddText("As " + SlaveName + NonPlural(" hesitate") + " the figure fades and vanishes and the medium slumps to the ground, making an odd, almost frustrated, cry.\r\rThe medium rests");
				coreGame.currentCity.MeetPerson(39, 0, "narana", "", "0");
				ShowPerson(39, 1, 2, 1);
				AddText(",\r\r");
				PersonSpeak(39, "I was trying to summon a dem..., umm, well, umm, a spirit, but got something else. Unf...Fortunately it was poorly summoned and vanished when you entered the room.", true);
				AddText("\r\rThey spend a while talking of strange, magical beings, but often about their sexual natures. Narana is clearly very, very aroused...");
				sd.BitFlag1.SetBitFlag(42);
				HighClassParty(8078);
				return;
	
			// Run to help
			case 8058:
				HidePerson(39);
				AddText(SlaveName + NonPlural(" run") + " in the help the medium and the figure wavers and drops the woman. There is a swirl of something dark and #slaveis enveloped and can feel ghostly hands grabbing #slavehimher and the distinct feeling of a large, cock forming and getting more and more solid.\r\rThe hands hold #slave tight and then " + SlaveName + NonPlural(" feel") + " large, hard " + Plural("cock") + " push into #slavehisher ass ");
				if (!Naked) AddText(", somehow bypassing #slavehisher clothes, ");
				if (sd.IsFemale()) AddText("and then " + Plural("a cock") + " thrusting into " + coreGame.SlaveHisHer + coreGame.PussyText());
				AddText(". The fucking is intense, urgent and fast. Despite this #slave quickly approaches" + coreGame.OrgasmText() + ", #slavehisher arousal peaking unnaturally. Then " + SlaveName + NonPlural(" hear") + " the medium call out something, and there is a burst of hot cum flooding into #slavehimher and #slaveheshe" + coreGame.OrgasmTextNP() + " strongly.\r\rWhen #slaveis next aware, the shape is gone and the medium is standing over #slavehimher looking oddly annoyed. She talks");
				coreGame.currentCity.MeetPerson(39, 0, "narana", "", "0");
				coreGame.Generic.ShowDemonRape();
				AddText(",\r\r");
				PersonSpeak(39, "I was trying to summon a dem..., umm, well, umm, a spirit, but got something else. Unf...Fortunately it was poorly summoned and abandoned..freed me when you ran to help me. It took you, not me, as I want, ummm, dreaded.", true);
				AddText("\r\rThey rest and spend a while talking of strange, magical beings, but often about their sexual natures. Narana is clearly very, very aroused...");
				sd.BitFlag1.SetBitFlag(42);
				HighClassParty(8078);
				return;
				
			// Masturbate 
			case 8059:
				HideDresses();
				AddText(SlaveName + NonPlural(" decide") + " there is nothing #slaveheshe can do and watches, feeling very aroused. So aroused ");
				if (!Naked) AddText(coreGame.SlaveHeShe + NonPlural(" remove") + " #slavehisher clothing ");
				AddText("and masturbates to the sight of the woman being groped to orgasm.\r\rAs " + SlaveName + NonPlural(" start") + " the figure stops wavering and partially solidifies. The woman moans, almost joyously, as #slave can see cock-like shapes passing through the woman's clothing, impaling her pussy and ass. The woman looks intensely aroused and somehow happy as the cocks fuck her intensely hard and fast. #slaveis incredibly, unnaturally aroused and masturbates quickly, watching the woman scream in orgasm after orgasm. #slave also cries out as " + coreGame.SlaveHisHer + coreGame.OrgasmText() + " explodes over " + coreGame.SlaveHimHer);
				if (coreGame.HasCock) AddText(" as intensely powerful blasts of cum erupt from " + coreGame.SlaveHisHer + coreGame.CockText());
				AddText(".\r\rThe woman screams in orgasm again and #slavesee a huge flood of cum spray from her pussy and ass as the cocks pull free and spray torrents of cum over her. The figure wavers and vanishes.\r\r#slave staggers over to the medium and she");
				coreGame.currentCity.MeetPerson(39, 0, "narana", "", "0");
				ShowPerson(39, 0, 2, 2);
				coreGame.Generic.ShowDemonRape();
				AddText(",\r\r");
				PersonSpeak(39, "I was trying to summon..., umm, banish a demon, but I made a mistake and did not control it, ummm to banish it that is. It was fading but your passion wonderfully...awfully called it back. It's marvelous..evil power aroused us both, and it's cocks were so large and hard and oh so good...\r\rI have never seen you at one of the mass...meetings, you are also...", true);
				AddText("\r\rShe trails off, unsure how to continue, and then changes the topic of conversation.\r\rThey rest and spend a while talking of strange, magical beings, but often about their sexual natures. Narana is clearly very, very aroused...");
				sd.BitFlag1.SetBitFlag(42);
				HighClassParty(8078);
				return;
				
			// Talk
			case 8060:
				sd.BitFlag1.SetBitFlag(40);
				Backgrounds.ShowBedRoom(Math.floor(Math.random()*11) + 6);
				SetText(SlaveVerb("spend") + " the rest of the evening talking with the Lady, but is a little surprised and aroused when the Lady summons some maids, one to lick her pussy and one to massage her back, neck and breasts.\r\rThe maids are strictly told not to make her orgasm unless she so asks. They seem to be quite expert licking her to near orgasm often then backing off. Late in the evening the lady excuses herself, saying that it is time, and #slave watches the maids concertedly lick the lady to orgasm after long delayed orgasm.");
				ShowMovie("EventParties", 1, 1, 12);
				HidePerson(4);
				Points(0, 2, -1, 2, 0, 0, 2, 2, 2, 0, 0, 0, 2, 0, 4, 2, -5, 1, 0, 0);
				HighClassParty(8078);
				return;
				
			// Dance - Dance
			case 8065:
				mcBase.EventParties._visible = false;
				sd.BitFlag1.SetBitFlag(40);
				ShowPerson(41, 1, 1, 4);
				Backgrounds.ShowOther(1);
				sd.slDancing += 0.2;
				SetText(SlaveName + NonPlural(" walk") + " up to #persononsenowner and interrupts explaining how the Lady has insisted they dance and that #slaveheshe only has a limited time. The man looks angrily at #slave, but #persononsenowner looks relieved and agrees that they must do so now and almost flees with #slave.\r\rThey dance for a time, #persononsenowner is an expert dancer and teaches #slave a little about dancing in the process. #persononsenowner is also quite happy to be free of <i>that man</i> but will not otherwise talk of the argument.\r\rLater they dance again and #slave accidentally touches part of #persononsenowner's dress and it starts to unravel and fall off. #slaveis surprised how easily the dress came free. #persononsenowner adjusts her dress with a smile.");
				Points(0, 2, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0);
				coreGame.DoEventNext(8512.1);
				return;
				
			// Dance - Message
			case 8066:
				mcBase.EventParties._visible = false;
				sd.BitFlag1.SetBitFlag(40);
				Backgrounds.ShowBedRoom(12);
				ShowPerson(41, 1, 1, 3);
				sd.DifficultyBondage -= 2;
				SetText(SlaveName + NonPlural(" walk") + " up to #persononsenowner and claims to have a private message for her. She looks grateful and almost flees with #slave to a private room. " + SlaveName + NonPlural(" apologise") + " that there is no message and that #slaveheshe thought the Lady was in distress and wanted to help. #persononsenowner looks happy and thanks #slave for rescuing her from <i>that man</i> but does not explain further.\r\rShe invites #slave to spend the rest of the evening here, away from <i>him</i> and they spend the time chatting, and eating snacks.\r\rAfter a while #persononsenowner comments that her clothing can be uncomfortable and removes most of it, revealing she is bound in a rope webbing, complete with a moist crotch rope. She explain matter-of-factly that she is completely dedicated to her beloved husband's desires and will, and this is a symbol of her love for him. Also that she very much likes it, especially the crotch rope.");
				Points(0, 2, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 2, 1, 0, 1, 0, 0);
				coreGame.DoEventNext(8512);
				return;
				
			// later
			case 8078:
				if (sd.slCourtesan == 0) coreGame.HighClassProstitute.PersonFlag = -5;
				coreGame.HighClassProstitute.CustomFlag = Math.floor(Math.random()*3) + 6;
				Diary.AddEntryFull("Function with #personcourtesan", coreGame.GameDate + coreGame.HighClassProstitute.CustomFlag, false, 0, false);
				AddText("\r\rLater in the evening #personcourtesan's servant arrives to take #slave back home.\r\rThe servant tells #slave that there is another function in " + coreGame.HighClassProstitute.CustomFlag + " days and " + coreGame.SlaveHeSheIs + " welcome to attend it with #personcourtesan.");
				ShowPlanningNext();
				return;
				
			// end of party
			case 8079:
				HidePerson(6);
				sd.MaxConversation = sd.MaxConversation + 4;
				coreGame.HighClassProstitute.CustomFlag = Math.floor(Math.random()*3) + 6;
				Diary.AddEntryFull("Function with #personcourtesan", coreGame.GameDate + coreGame.HighClassProstitute.CustomFlag, false, 0, false);
				AddText("In the early hours of the morning #personcourtesan takes #slave back to her home and invites #slavehimher to spend the rest of the night. They retire to the bathroom to wash and talk,\r\r");
				PersonSpeak(4, "You show potential to become a skilled member of my profession. If you like I can instruct you in the finer points of being a courtesan.", true);
				AddText("\r\rWill #slave accept training as a courtesan?\r");
				DoYesNoEventXY(8079);
				ShowPerson(4, 1, 1, 8);
				return;
		}
	}
	
	public function LoadGame(loaddata:Object)
	{
		TimeToProstituteParty = loaddata.TimeToProstituteParty;
		if (TimeToProstituteParty == undefined) {
			TimeToProstituteParty = 0;
			TimeToHighClassParty = 0;
		} else {
			TimeToHighClassParty = loaddata.TimeToHighClassParty;
		}
	}
		
	public function SaveGame(savedata:Object)
	{
		savedata.TimeToProstituteParty = TimeToProstituteParty;
		savedata.TimeToHighClassParty = TimeToHighClassParty;
	}
	
}