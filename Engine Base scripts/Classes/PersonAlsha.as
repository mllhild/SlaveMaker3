// PersonAlsha - Meigura, the demon idol
// number 17
// lend modifier 100
// Translation status: INCOMPLETE

import Scripts.Classes.*;


class PersonAlsha extends Person {
		
	public function PersonAlsha(cg:Object, cc:Object) { 
		super("SwimInstructor", cg, 17, 100, false, cc);
	}
	
	// New Slave
	public function StartNewSlave(visit:Boolean, keepmet:Boolean, except:Number, exceptf:Number, all:Boolean)
	{
		super.StartNewSlave(true, false, undefined, undefined, false);
	}
	
	// Meet her
	public function Meeting(meet:Number) : Boolean
	{
		if (!super.Meeting(SMFlag)) return false;
		
		if (coreGame.SlaveGirl.MeetSwimInstructor() == true) return true;
		
		PointsPerson(0, slrandom(4), 0, 0, 0);
		switch (SMFlag) {
			case 0:
				Money(-20);
				SMFlag = 1;
				AddText("After the lesson Alsha pleasantly chats with you and #slave, but mainly with you. You try to involve #slave more, but Alsha calmly tells you,\r\r");
				PersonSpeak(Id, "I find #slave charming, but a slave is a slave and our society chooses to have slaves and free-born. I hold nothing against slaves, but while I can own a slave, I cannot have a relationship with one as an equal. I'm sorry, why do we not leave this lesson at that. #slavemakername, I enjoyed our chat.", true);
				break
				
			case 1:
				Money(-20);
				AddText("Alsha chats pleasantly with #slave and yourself during the lesson, and after buys you both a drink from a stall. ");
				switch(slrandom(3)) {
					case 1: AddText("She asks you about your life and your profession. She knows little about slave training and clearly has only a slight interest."); break;
					case 2: AddText("She asks you about any interest and hobbies you have, and also asks #slave."); break;
					case 3: AddText("She chats about nothing much but is happy and lively to talk to."); break;
				}
				if (LoveSM > 20) SMFlag++;
				break;
				
			case 2:
				Money(-20);
				ShowThem(1, 2, 7);
				AddText("Alsha talks pleasantly with #slave and yourself during the lesson, and after buys you both a drink from a stall. ");
				AddText("She chats about nothing much but subtly flirts with you, touching your arm and brushing against you. She mentions,\r\r");
				PersonSpeak(Id, "Marine often calls me a slut, but in a friendly way. Well sex is fun and I like it, but Marine is the one who talks about it all the time. Sometimes I think she is jealous, despite me telling her I do not feel that way.", true);
				AddText("\r\rWith that she leans over and kisses you on the cheek and blushes slightly. She looks embarrassed and stands and makes and excuse and leaves.");
				SMFlag++;
				break;
				
			case 3:
				Money(-20);
				SetText("As you head to meet Alsha for a swimming lesson, in the distance you see her embracing another woman. You are fairly sure it is Marine but she is not in her swimsuit and her hair is untied.\r\rYou see they are looking very serious and then watch as they quite tenderly kiss. Alsha breaks the kiss and then kisses Marines forehead. You see tears running down Marine’s cheek, and they sadly part.\r\rAlsha joins you and you know she saw you watching. She quickly changes and starts #slave's lesson.\r\rDuring a break she speaks to you, she looks a bit sad as she looks at you, very tenderly,\r\r");
				PersonSpeak(Id, "Marine is a very dear friend, but she wants more. I, I had to hurt her and explain that I do not desire women, but she is my friend and always will be.", true);
				AddText("\r\rShe looks at you ");
				if (SMData.Gender == 1) {
					AddText("and leans in and lightly kisses you on the lips,\r\r");
					PersonSpeak(Id, "I should get back to the lesson...", true);
					SMFlag = 5;
				} else if (SMData.Gender == 2) {
					AddText(" tears forming in her eyes and she gently touches your cheek,\r\r");
					PersonSpeak(Id, "I cannot change myself for Marine, or for you...", true);
					 SMFlag = 4;
				} else {
					AddText(" tears forming in her eyes and she gently touches your cheek,\r\r");
					PersonSpeak(Id, "I cannot change myself for Marine, or for you...", true);
					AddText("\r\rYou reach out and hold her hand, and tell her that you are not <i>only</i> a woman and lightly hold her hand to your groin and your stiffening cock. Alsha looks surprised, and then blushes deeply, but holds her hand against your cock and leans in and kisses you,\r\r");
					PersonSpeak(Id, "I should get back to the lesson before it is too hard to leave...", true);
					SMFlag = 5;
				}
				HideBackgrounds();
				ShowThem(1, 1, 7);
				break;
				
			case 4:
				Money(-20);
				AddText("Alsha chats pleasantly with #slave and yourself during the lesson, and after buys you both a drink from a stall. She is very friendly and every so often flirts a little but seems to notice and holds herself back.");
				break;
				
			case 5:
				Money(-20);
				AddText("Alsha chats pleasantly with #slave and yourself during the lesson, and after buys you both a drink from a stall. ");
				switch(slrandom(3)) {
					case 1: AddText("She is very affectionate, often touching your face, or knee and when you are about to leave she embraces you and gently kisses you."); break;
					case 2: AddText("She is affectionate and tender often holding your arm and kissing your cheek several times. As you are about to leave she grabs you and passionately kisses you."); break;
					case 3: AddText("She chats about nothing much but is happy and lively to talk to. During your talk she reaches under the table and lightly touches your groin and then resets her hand on your knee."); break;
				}
				if (LoveSM > 60) SMFlag++;
				break;
				
			case 6:
				Money(-10);
				Backgrounds.ShowOther(4);
				SMData.ShowSlaveMaker();
				ShowThem(1, 1, 6);
				SMData.SMPoints(0, 0, 0, 0, 0, -3, 0, 0, 0);
				AddText("After the lesson Alsha asks you for a private conversation. You ask #slave to sunbathe or go swimming for a bit. Alsha takes you to a private changing area away from the beach. As you approach the room you an odd sensation, but you cannot quite identify.\r\rThe room is fairly small and you walk in a look around. You hear the door close and turn, and see Alsha standing there radiantly beautiful and quite, quite naked. She blushes and says,\r\r");
				PersonSpeak(Id, "I know your life is complex with your slaves and assistants, so I do not want you to answer, just accepts this.\r\rI love you, I do not mind if you love another or not, I love you.", true);
				AddText("\r\rShe embraces you and kisses you passionately. As she does her hands touch you making it clear she desires your body as well. She quickly strips you naked, kissing you and fondling and stroking your cock. ");
				if (SMData.Gender == 3) {
					AddText("It is clear that you are her first hermaphrodite lover as she is awkward as her breasts rub against yours and she ignores your pussy. You gently roll over onto her, kissing and making sure your hard nipples rub and touch her hardening nipples. You caress her pussy and move one of her hands to yours. Your cock is quite ready to fuck her but you continue touching and kissing her until she is ready.\r\rShe moans and whispers 'now' and you slide your cock into her moist pussy and she moans passionately. You fuck her, your cock sliding easily in her, and your breasts rubbing against hers, rock-hard nipples flicking against her rock-hard nipples. You fuck faster, not quite ready to cum and Alsha gasps, stiffening as she orgasms. You feel her pussy contracting around your cock, and you slow and bit and hold her during her orgasm.\r\rAs she recovers you kiss her, your hard cock still deep in her pussy. You kiss her more, your breasts rubbing over hers, and slowly resume fucking her. You fuck faster and faster, and Alsha's arousal builds again, this time you pace yourself, waiting, but intensely needing to cum. Alsha moans and starts orgasming a second time, this time you fucks hard and fast and yell out as you cum, your cum pouring into her spasming pussy.\r\rYou roll off and she sighs and says,\r\r");
				} else {
					AddText("She is a passionate and experienced lover and expertly touches and stokes your cock erect. You gently roll over onto her, kissing and caressing her breasts and her hardening nipples. You caress her pussy and move one of her hands to your cock. Your cock is quite ready to fuck her but you continue touching and kissing her until she is ready.\r\rShe moans and whispers 'now' and you slide your cock into her moist pussy and she moans passionately. You fuck her, your cock sliding easily in her, her rock-hard nipples rubbing over your chest. You fuck faster, not quite ready to cum and Alsha gasps, stiffening as she orgasms. You feel her pussy contracting around your cock, and you slow and bit and hold her during her orgasm.\r\rAs she recovers you kiss her, your hard cock still deep in her pussy. You kiss her more, lightly caressing her breast, and slowly resume fucking her. You fuck faster and faster, and Alsha's arousal builds again, this time you pace yourself, waiting, but intensely needing to cum. Alsha moans and starts orgasming a second time, this time you fucks hard and fast and yell out as you cum, your cum pouring into her spasming pussy.\r\rYou roll off and she sighs and says,\r\r");
				}
				PersonSpeak(Id, "I love you.", true);
				AddText("\r\rShe smiles,\r\r");
				PersonSpeak(Id, "Despite what Marine says, the lesson today is <i>not</i> free, but let us say half price...", true);
				SMFlag++;
				break;
				
			case 7:
				Money(-10);
				Backgrounds.ShowOther(4);
				ShowThem(1, 1, slrandom(3) + 3);
				SMData.ShowSlaveMaker();
				SMData.SMPoints(0, 0, 0, 0, 0, -3, 0, 0, 0);
				AddText("After the lesson Alsha asks you for another private conversation. You ask #slave to sunbathe or go swimming for a bit. Alsha takes you to the private changing area away from the beach. You again feel an odd sensation, but you cannot quite identify.\r\rYou enter the room and passionately embrace Alsha and then make love to her.");
				break;
	
				
	
		}
		
		coreGame.SlaveGirl.AfterMeetSwimInstructor();
		coreGame.modulesList.AfterMeetPerson(Id, SMFlag);
		return true;
	}

}