class SMEncounter extends SlaveModule
{
    var bathroom, randomsm, lilyenable, debtdone, gloryJob, contractFirst, denial, bjskill, contractStartDate, doPoison, easDone, timesVisited, loseStall, closetAction, contractLastDone, go, AskHerQuestions, inebration, betamount, BaseMovie, deck, index, playerHand, npcHand;
    function SMEncounter(mc)
    {
        super(mc);
        this.StartGame();
    } // End of the function
    static function main(swfRoot)
    {
        var _loc1 = new SMEncounter(swfRoot);
        return (_loc1);
    } // End of the function
    function StartSlaveMaker()
    {
        bathroom = 0;
        randomsm = false;
        lilyenable = false;
        debtdone = false;
        gloryJob = false;
        contractFirst = false;
        denial = 0;
        bjskill = 0;
        contractStartDate = -1;
    } // End of the function
    function StartGame()
    {
        if (bathroom == null)
        {
            bathroom = 0;
        } // end if
        if (randomsm == null)
        {
            randomsm = false;
        } // end if
        if (lilyenable == null)
        {
            lilyenable = false;
        } // end if
        if (debtdone == null)
        {
            debtdone = false;
        } // end if
        if (gloryJob == null)
        {
            gloryJob = false;
        } // end if
        if (denial == null)
        {
            denial = 0;
        } // end if
        if (bjskill == null)
        {
            bjskill = 0;
        } // end if
        if (doPoison == null)
        {
            doPoison = false;
        } // end if
        if (easDone == null)
        {
            easDone = false;
        } // end if
        if (timesVisited == null)
        {
            timesVisited = 0;
        } // end if
        if (loseStall == null)
        {
            loseStall = 0;
        } // end if
    } // End of the function
    function SaveGame(savedata)
    {
        savedata.closetAction = closetAction;
        savedata.contractFirst = contractFirst;
        savedata.bathroom = bathroom;
        savedata.randomsm = randomsm;
        savedata.lilyenable = lilyenable;
        savedata.debtdone = debtdone;
        savedata.bjskill = bjskill;
        savedata.gloryJob = gloryJob;
        savedata.doPoison = doPoison;
        savedata.easDone = easDone;
        savedata.timesVisited = timesVisited;
        savedata.loseStall = loseStall;
        savedata.contractStartDate = contractStartDate;
        savedata.contractLastDone = contractLastDone;
    } // End of the function
    function LoadGame(savedata)
    {
        closetAction = savedata.closetAction;
        contractFirst = savedata.contractFirst;
        bathroom = savedata.bathroom;
        randomsm = savedata.randomsm;
        lilyenable = savedata.lilyenable;
        if (lilyenable)
        {
            _root.SetSMCustomTrainingDetails("Red Lily", "You can either visit the Red Lily and look around, or work here (especially if contractually obligated).");
            _root.ShowSMCustomTraining();
        } // end if
        debtdone = savedata.debtdone;
        bjskill = savedata.bjskill;
        doPoison = savedata.doPoison;
        gloryJob = savedata.gloryJob;
        easDone = savedata.easDone;
        if (easDone == null)
        {
            easDone = false;
        } // end if
        timesVisited = savedata.timesVisited;
        loseStall = savedata.loseStall;
        contractStartDate = savedata.contractStartDate;
        contractLastDone = savedata.contractLastDone;
    } // End of the function
    function DoWalkPalaceAsAssistant(NumEvent, present)
    {
        if (_root.Gender == 0)
        {
            return (false);
        } // end if
        if (gloryJob && !present && bathroom == 4)
        {
            if (Math.random() < 0.330000)
            {
                _root.SetText("You notice your nearing the section of the palace where the famliliar bathroom resides.\r");
                if (Math.random() > 0.950000)
                {
                    _root.AskHerQuestions(10208, 10209, 0, 0, "Yes", "No", "", "", "Do you wish to go to the stalls?");
                    return (true);
                }
                else
                {
                    _root.AskHerQuestions(10214, 10209, 0, 0, "Yes", "No", "", "", "Do you wish to go to the stalls?");
                    return (true);
                } // end if
            } // end if
        } // end else if
        if (bathroom == 0)
        {
            if (present || _root.Gender == 1)
            {
                return (false);
            } // end if
            super.AutoAttachAndShowMovie("peeking", 1, 0, 1);
            _root.SetText("While out walking with " + _root.SlaveName + ", " + _root.SlaveName + " asks to go the the restroom. You say yes, having to attend to the same call of nature. After finishing you wipe too hard causing you to become horny in your heightened state of libido. Somewhat self-consciously you quickly rub yourself. Nearing climax you left off soft moans, finally coating the toilet in your juices.");
            if (_root.Gender == 3)
            {
                _root.AddText("Your cock then explodes into an arc of semen, leaving the stall floor sticky, smelly, and white.");
            } // end if
            _root.AddText("\r\r");
            _root.PersonSpeak("Anonymous", "(Inaudible giggles) Hehehe, that was quite a show.", true);
            _root.SMPoints(0, 0, 0, 0, 0, -20, 0, 0, -5);
            _root.AddText("\r\rEmbarassed, you quickly leave the restroom with " + _root.SlaveName + " and return home");
            bathroom = 1;
            return (true);
        }
        else if (bathroom == 1 && !present)
        {
            if (randomsm)
            {
                if (Math.random() > 0.950000)
                {
                    go = true;
                } // end if
                go = false;
            }
            else
            {
                go = true;
            } // end else if
            if (go)
            {
                super.AutoAttachAndShowMovie("gagged", 1, 0, 1);
                _root.SetText("While out walking in the palace area, you see a man and his rather largely endowed slave walking around, bragging loudly and arrogantly to whomever will listen.\r");
                _root.PersonSpeak("Owner", "This one is extemely special, she has been treated with a drug so her pheromones are extremely strong, keeping her and anyone around her primed to go!", true);
                _root.AddText("\r\r Do you wish to take one very small whiff?");
                _root.DoYesNoEvent(10200);
                return (true);
            } // end if
        }
        else if (bathroom == 2 && !present)
        {
            _root.SetText("As you walk by the restroom you can feel your pussy start moistening recalling what you did, and that wonderful girls aroma.");
            if (_root.SMLibido > 75)
            {
                _root.AddText("Your uncontrollable libido draws you to the restroom to releive yourself.");
                this.AskHerQuestions(10203, 0, 0, 0, "Yes", "", "", "", "Do you wish to indulge your arousal?");
                return (true);
            } // end if
            this.AskHerQuestions(10203, 10204, 0, 0, "Yes", "No", "", "", "Do you wish to indulge your arousal?");
            return (true);
        } // end else if
        return (false);
    } // End of the function
    function DoWalkSlumsAsAssistant(eventno)
    {
        if (bathroom == 3)
        {
            super.AutoAttachAndShowMovie("revy", 1, 0, 1);
            _root.SetText("While walking through the slums a woman approaches you.\r\r");
            _root.PersonSpeak("Women", "Ha! " + _root.SlaveMakerName + ", you\'ve made a name for yourself as an entertainer, thanks to your exploits in a certain bathroom . You\'ve got natural skills, so naturally I\'d love to have you as a temporary attraction for my business. I would pay handsomely of course, and your slave in training may also work for me. All you have to do is sign this contract.", true);
            if (_root.SMDominance > 25)
            {
                this.AskHerQuestions(10201, 10202, 0, 0, "Yes", "No", "", "", "Do you agree to sign?");
                return (true);
            } // end if
            _root.AddText("\r\r You can feel the proposition making you wet just by thinking about it, you know you can\'t refuse her offer thanks to your submissive nature.");
            this.AskHerQuestions(10201, 0, 0, 0, "Yes", "", "", "", "Do you agree?");
            return (true);
        } // end if
        return (false);
    } // End of the function
    function DoEventYesAsAssistant()
    {
        if (_root.NumEvent == 10200)
        {
            bathroom = 2;
            _root.SetText("As you inhale the slaves intoxicating aroma a, fire forms in your loins. Searching for the closest public place you find a familiar bathroom. You tell " + _root.SlaveName + " to go wait outside as you enter the familiar public bathrooms. You enter the same stall as the last time. You quickly strip and give yourself the quickest route to satisfaction as possible.\r\r As you begin walking out your waist feels heavier. You see a pouch tied to it full with gold and a note attached: it reads in a manly scrawl \"More to cum\". As your ponder this you hear an vaguely familiar laughter, however you can\'t locate the source after looking up.");
            _root.Money(50);
            super.AutoAttachAndShowMovie("turbate", 1, 0, -1);
            _root.SMPoints(0, 0, 0, 0, 0, 15, 0, 0, -5);
            return (true);
        } // end if
        if (_root.NumEvent == 10213)
        {
            _root.SetText("As you tapout Poison gets a wicked grin on her face, then says \"Oh we will have so much fun toy.\" The announcer the comes on, although you can\'t figure out where, thanks to your head still swimming.\r\r\r");
            _root.PersonSpeak("Announcer", "Oh! What a match..., this one still had ten minutes left for you gamblers! Congratulations champ on your fiftyninth new slave!", true);
            if (_root.BadEndsOn)
            {
                super.AutoAttachAndShowMovie("chunend", 1, 1, 1);
                _root.AddText("\r\rYou\'re lead away in chains. As for your fate? At first you resist, but the mistress quickly and brilliantly grinds that out of you in a short time. Eventually, you end up love being under the Mistress, she treats you very well as long as you listen. You think you\'re her favorite, although that bitchy Cammy tries to out-whore you sometimes. The only downside is that sometimes the Mistress is busy, but she is amazingly nice enough to let you earn some spending money sharing your body with the world.");
                _root.DoEvent(9800);
            }
            else
            {
                _root.AddText("\r\rYou look around stunned, your throat soar from the beating it took from her massive shaft. As you sit there gazing in space you\'re chained and led away back into the bowels of the arena. As you take in the room around you Poison walks in with a winning smile on her face.\n\n");
                _root.PersonSpeak("Poison", "Ha, we sure gave them a show! I hope I didn\'t frighten you too much with the whole act, but it is more convincing if you don\'t know what is really happening.", true);
                _root.AddText("\n\nWith that the chains are released and you are allowed to leave with a heavier purse, but much less dignity.");
                _root.Money(500);
                _root.DoEvent(6999);
            } // end else if
            return (true);
        } // end if
        if (_root.NumEvent == 10214)
        {
            if (_root.BadEndsOn)
            {
                _root.SetText("As you nod your head yes, the women violently comes at you with a piece of cloth and stuffs it up against your mouth and noise. You almost immediately lose counsciousness, as your world turns black. As you come to you can feel the stings of restrainment all over your body where your limbs are bound, the soft drool running down your chin from the gag, and finally your vision is impaired by a blind fold. Rubbing against your bare ass you can feel the cool porcealin and open air under your ass that is quite familiar as a toilet.\n");
                _root.PersonSpeak("Women", "I\'d like to thank you for your willingness to help out with our toilet situation. We we\'re looking for an upgrade over the standard affair. It really is a symbiotic relationship toy. You get your near-insatiable sluttish needs fullfilled, and the members of our upper-class get easy access to a fuck-toy whilst they are away from home, everyone one wins!", true);
                _root.AddText("\n\nAn odd feeling sets upon yourself. You originally imagine yourself struggling and detesting her actions, yet an odd sense of relief and calm sets over you. In a way, you can see the reason behind your feelings. Exchanging your will for day after day of pure bliss has its appeal.\n\n...Weeks later you are much more happy with your situation then you once were, albeit your mind is a husk of what it once was, intelligence boiled down to primal thoughts. You live for sex, and you are much obliged in that department, with your \"meals\" coming from the warm cocks of others...");
                _root.DoEvent(9800);
            }
            else
            {
                _root.SetText("As you nod your head in agreement, the women violently attacks you. Luckily you are able to escape from her, and return from the bathroom shaken and bruised, but yourself none the less.");
                _root.DoEvent(6999);
                return (true);
            } // end else if
            return (true);
        } // end if
        if (_root.NumEvent == 10235)
        {
            _root.HideImages();
            if (inebration == 0)
            {
                super.AutoAttachAndShowMovie("eas", 1, 1, 1);
                _root.SMPoints(0, 0, 0, 0, 3, 0, 0, 0, 0);
                _root.SetText("You end up having a pleasant conversation with her, learning her name is Eas and that she is just a tourist. After discussing some of the more interesting locations in the area you end with an awkward silence. You take this as your queue and get up looking for something else to do.");
                _root.DoEvent(10230);
            }
            else if (inebration == 1)
            {
                super.AutoAttachAndShowMovie("eas_go", 1, 1, 1);
                _root.SMPoints(0, 0, 0, 0, 0, 5, 0, 0, 0);
                _root.SetText("You slowly talk to her finding out her name is Eas. With the edge broken with your current state of sobriety you slowly begin to flirt with her. You try using your charms to see how serious she is by moving your hand onto her thigh, when she returns the favor you begin popping in some dirty talk with her. She moves her hand up your skirt and begins lightly teasing your lips. As you begin to move your hand up she smiles and says, \"Too public, meet me in the closet\", pointing to the bottom right room.");
                closetAction = 1;
                _root.DoEvent(10230);
            }
            else if (inebration == 2)
            {
                _root.SMPoints(0, 0, 0, 0, 3, 0, 0, 0, 0);
                super.AutoAttachAndShowMovie("eas_nonamused", 1, 1, 1);
                _root.SetText("You walk up to her with a dopey smile on your face, you stumble a bit as you sit. The girl doesn\'t notice, or more likely decides not to comment. You drop a few corny and rather lewd pick up lines on her. She looks at you with no expression then suprisingly says, \"... only thing worse then your pick up lines is sitting here, meet me in the closet and we can do something that could be fun.\" As she says this she points to the closet off to the side of the room.");
                closetAction = 2;
                _root.DoEvent(10230);
            }
            else if (inebration == 3)
            {
                super.AutoAttachAndShowMovie("eas_mad", 1, 1, 1);
                _root.SetText("You walk up to her and promptly trip over your shoes, you end up landing right in her cleavage. She looks down at you with an angry frown, her cheeks turning red in embarassment at the scene you caused. You look up at her and giggle, then quickly shake your head back and forth making a loud sound of, \"BRRRRRRRRRRRRrrrrrrrrr\". She grabs your arm and twists it around your back. She quickly leads you out of the room, supporting you so you don\'t fall on your face.");
                _root.DoEvent(10236);
            } // end else if
            return (true);
        } // end if
        if (_root.NumEvent == 10236)
        {
            _root.SetText("You begin licking Eas with all the vigor you can muster, only relenting to take gasps of air. After what you estimate to be fifteen minutes she suddenly gets up off of you.\n\n");
            _root.PersonSpeak("Eas", "Pretty good, figures that it must transfer from all the cock you must suck. I\'m going to give you easier access, but don\'t think that if you slack off for a second I won\'t do something much worse to you!", true);
            _root.AddText("With that you can hear her adjusting some equipment in back, all of a sudden you fly up and do a sommersault so that you are now suspending belly down in the middle of the air. You wait patiently and are rewarded when you feel her fresh folds presented up to your lips. Without her saying anything you begin thrusting your tongue in and out occasionaly giving a bit on her clit which causes a moan form her. After a while her pussy juices gush out as she hits her climax. You slurp up as much juice as you can and swallow down the juice which has a slight taste of strawberries.\n\n");
            super.AutoAttachAndShowMovie("cunn", 1, 1, -1);
            _root.PersonSpeak("Eas", "Enough, I think you\'ve done enough, additionaly I wouldn\'t like to be you in the morning.", true);
            _root.AddText("\n\nShe releases the cuffs on your body, then guides you on a brief walk. All of the sudden you feel fresh air hit your face, and no longer feel her presence behind you. You grab at your blindfold and find that you\'re now outside the Red Lily. Giving a collective shiver you walk away to continue your day.");
            _root.DoEvent(6999);
            return (true);
        } // end if
        if (_root.NumEvent == 10249)
        {
            inebration = 0;
            _root.DoEvent(6999);
            return (true);
        } // end if
        return (false);
    } // End of the function
    function DoEventNoAsAssistant()
    {
        if (_root.NumEvent == 10200)
        {
            randomsm = true;
            _root.SetText("You resist the urge to smell the girl, although it seems like " + _root.SlaveName + " has not, thanks to her ");
            if (_root.DickGirlXF > 0)
            {
                _root.AddText("noticeably erect dick, and her ");
            } // end if
            _root.AddText("puffy nipples.");
            _root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0);
            return (true);
        } // end if
        if (_root.NumEvent == 10213)
        {
            super.AutoAttachAndShowMovie("chuncum", 1, 0, 1);
            _root.SetText("Unbeknowst to you Poison is true to her word and keeps  her shaft firmly impaled down your throat, saving you ten minutes of near suffocating. You pass out after a few seconds. As you reawake your arms and legs are oddly sore, but thankfully you can still move them. You take a second, clearing your throat which tastes salty. After this you notice the smell of a thick cum in your nose. You look around and find yourself in the old bathroom, seeing a large bag of gold floor you take a second to compose yourself and leave.");
            _root.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -10);
            _root.DoEvent(6999);
            return (true);
        } // end if
        if (_root.NumEvent == 10214)
        {
            _root.AddText("");
            _root.PersonSpeak("Women", "Fair enough, see you some other time toy.", true);
            _root.AddText("");
            return (true);
        } // end if
        if (_root.NumEvent == 10235)
        {
            _root.SetText("You give a sheepish shake of your head and return to the bar.");
            _root.DoEvent(10230);
            return (true);
        } // end if
        if (_root.NumEvent == 10236)
        {
            super.AutoAttachAndShowMovie("piercing", 1, 1, 1);
            _root.SetText("You trying letting out a defiant refusal, which ends up just being gagged by the flesh on your lips. After a while it becomes clear to Eas you have no intention of complying. She says, \"defiant for such a whore. Unfortunate for you, fun for me.\" She then shuffles her hips a bit, sitting on your face without a chance for air at long intervals at a time, leaving you gasping when she finally does allow you air. This cycle lasts for a long two hours which feels like a lifetime to you. Finally she gets up allowing you a long gasp of air. Tears running down your face from what equates to torture you beg her to let you go. After rubbing her chin, causing even more pleading from you she shakes her head with a smile.\n\n");
            _root.AddText("\n\nIt is at this point she starts playing with your restraints. Quickly you find yourself in the position where your arms are bound together at the wrist, with your hands bound through your thighs by your crotch. While your legs are completely immobilized with your calfs taughtly tied to your thighs. She then places a leather collar around your nick with a metal ring on the back for what you must presume is a leash. After this she examines your breasts, carefully weighing each in her hand, occasionally giving a soft pinch on your nipples. As a result of her unwanted attention you feel your nipples slowly hardening, until both are prominently sticking out. With malice in her grin she produces a pair of bar-bell nipple rings, with each seperate one attached to each other with sturdy string. While on the string resides a metal circlet. She quickly punctures both of yourn nipples with the sharp ends, with slight discomfort to you. \"This is my coup de grace whore.\", she says as she holds up knotted rope.");
            _root.AddText("\nTaking the cord she first ties it securely around your already bound wrists. She carefully gets it through the ring located on the nipple piercing rope, taking the slack and running it all the way through. Then looping it back, she passes the rope between your thighs and up your back she runs the rope through the ring of the collar on the back of your neck. Finally she very tightly binds your legs together with yet more rope. In effect allowing you to move your arms up and down through your thighs, but not pull them out of your thighs. Planting a boot on your ass with rope in hand, she chuckles, \"Ready whore?\"");
            _root.DoEvent(10237);
            return (true);
        } // end if
        if (_root.NumEvent == 10249)
        {
            _root.HouseEvents.ShowCurrentFloor();
            return (true);
        } // end if
        return (false);
    } // End of the function
    function DoEventNextAsAssistant()
    {
        if (_root.NumEvent == 3199)
        {
            if (myMonster == null || myMonster.getPower() == false)
            {
                return (false);
            }
            else if (myMonster.getPower())
            {
                myMonster.resetPower();
                return (true);
            } // end if
        } // end else if
        if (_root.NumEvent == 10202)
        {
            _root.SetText("The lady shrugs her shoulders and walks off");
            bathroom = -1;
            return (true);
        } // end if
        if (_root.NumEvent == 10201)
        {
            _root.PersonSpeak("Revy", "So this is how it works, I expect you to be here at least every other day for the obligated two weeks. Failure to do so will allow me, as stipulated, seize assets of yours to what may be deemed fair by me.", true);
            _root.AddText("\n\nShe quickly gives you directions to the Red Lily, expecting you to be present yourself the next day.");
            contractStartDate = _root.GameDate;
            contractLastDone = _root.GameDate;
            contractFirst = true;
            this.contractEval();
            bathroom = 4;
            lilyenable = true;
            _root.SetSMCustomTrainingDetails("Red Lily", "You can either visit the Red Lily and look around, or work here (especially if contractually obligated).");
            _root.ShowSMCustomTraining();
            return (true);
        } // end if
        if (_root.NumEvent == 10203)
        {
            _root.SetText("You tell " + _root.SlaveName + " to wait outside once again. She gives a quizzical, but sharp look before sighing in resignation.\r\r You find what seems like your personal stall unoccupied once again and take a seat on the toilet. As you do, a large circular plunger comes off with a audible pop on the right side of the stall. As you look at it a bit shocked, a thick cock fills the hole. ");
            if (_root.SMDominance < 25 || _root.SMLibido >= 75 && _root.SMDominance < 75)
            {
                gloryJob = true;
                bjskill = bjskill + 1;
                if (_root.SMDominance < 25)
                {
                    _root.AddText("Your submissive mentality screams at you to take the cock. You joyfully follow that particular call. ");
                }
                else if (_root.SMLibido > 75)
                {
                    _root.AddText("You look at the cock with lustful greed, already planning on what fun you can have with it. ");
                } // end else if
                super.AutoAttachAndShowMovie("gloryhole", 1, 0, 1);
                bathroom = 3;
                _root.AddText("You gingerly take the cock and stroke it till it becomes hard, ");
                if (_root.Gender == 3)
                {
                    _root.AddText("while you take your other hand and begin stroking your own cock, ");
                } // end if
                _root.AddText("then you concentrate on stimulating your pussy. ");
                _root.AddText("After getting it hard, you take the massive cock in your mouth and suck it. After a short while you hear a girlish grunt and semen explodes into your mouth. You end up swallowing a vast majority semen, however a little bit dribbles down your chin. As you prepare to clean off another cock replaces the last one. You perform the same task over, not once, but seven more times. ");
                _root.AddText("Spent, you do your best to clean yourself off the splatters that got on both you and your clothing with the toilet paper in the stall. As you do a large bag of gold is slid underneath the stall, also attached with a note.\r \"Very entertaining to watch, come to the slums if you want more.\"\rYou leave and spot " + _root.SlaveName + " waiting for you.\r\r");
                _root.Money(100);
                _root.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -10);
                if (_root.DickGirlXF > 0)
                {
                    _root.PersonSpeak(_root.SlaveName, "I must admit, you do have quite a talent for sucking cocks.", true);
                    _root.Points(0, 0, 0, 0, -3, 1, 0, 0, 0, 3, 0, 10, 5, -10, -5, 0, 3, 5, 0, 0);
                    _root.AddText("\r\r You tell her to drop the subject before returning home.");
                    return (true);
                } // end if
                _root.PersonSpeak(_root.SlaveName, "You reek of cum, and it looks like you missed a bit of cum on the inside of your thigh. Figures you would be doing that.", true);
                _root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, -10, 0, 0, 0, 0, -3, 0);
                _root.AddText("\r\rYou blush and wipe the rest of it away with your hand. With murder in your eye you tell " + _root.SlaveName + " to never talk about this ever again.");
                return (true);
            } // end if
            _root.AskHerQuestions(10205, 10206, 0, 0, "Yes", "No", "", "", "Do wish to suck on the cock?");
            return (true);
        } // end if
        if (_root.NumEvent == 10204)
        {
            _root.SetText("You shake your head in disgust realizing this is unbecoming for you to infront of " + _root.SlaveName + ", and vow to avoid this area.");
            bathroom = -1;
            return (true);
        } // end if
        if (_root.NumEvent == 10205)
        {
            gloryJob = true;
            bjskill = bjskill + 1;
            super.AutoAttachAndShowMovie("gloryhole", 1, 0, 1);
            bathroom = 3;
            _root.AddText("You gingerly take the cock and stroke it till it becomes hard, ");
            if (_root.Gender == 3)
            {
                _root.AddText("while you take your other hand and begin stroking your own cock, ");
            } // end if
            _root.AddText("then you concentrate on stimulating your pussy.");
            _root.AddText(" After getting it hard, you take the massive cock in your mouth and suck it. After a short while you hear a girlish grunt and semen explodes into your mouth. You end up swallowing a vast majority semen, however a little bit dribbles down your chin. As you prepare to clean off another cock replaces the last one. You perform the same task over, not once, but seven more times. ");
            _root.AddText("Spent, you do your best to clean yourself off the splatters that got on both you and your clothing with the toilet paper in the stall. As you do a large bag of gold is slid underneath the stall, also attached with a note.\r \"Very entertaining to watch, come to the slums if you want more.\"\rYou leave and spot " + _root.SlaveName + " waiting for you.\r\r");
            _root.Money(100);
            _root.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -15);
            if (_root.DickGirlXF > 0)
            {
                _root.PersonSpeak(_root.SlaveName, "I must admit, you do have quite a talent for sucking cocks.", true);
                _root.Points(0, 0, 0, 0, -3, 1, 0, 0, 0, 3, 0, 10, 5, -10, -5, 0, 3, 5, 0, 0);
                _root.AddText("\r\r You tell her to drop the subject before returning home.");
                return (true);
            } // end if
            _root.PersonSpeak(_root.SlaveName, "You reek of cum, and it looks like you missed a bit of cum on the inside of your thigh. Figures you would be doing that.", true);
            _root.Points(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, -10, 0, 0, 0, 0, -3, 0);
            _root.AddText("\r\rYou blush and wipe the rest of it away with your hand. With murder in your eye you tell " + _root.SlaveName + " to never talk about this ever again.");
            return (true);
        } // end if
        if (_root.NumEvent == 10206)
        {
            super.AutoAttachAndShowMovie("futabath", 1, 1, 1);
            if (_root.SMDominance < 50)
            {
                _root.SetText("Your eyes go wide eyed at the cock. You scramble off the toilet, you unsteadily unlock the stall with your shaky hands. As you run through the bathroom, you see a large group of futa women ponder curiously at you. Tears running down your eyes you exit the bathroom where " + _root.SlaveName + " is waiting on you. Before she can say anything you tell her you\'re crying because some moron was smoking particularly strong hashish. In your head you vow not to be caught dead in that bathroom.");
                _root.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -5);
            }
            else
            {
                _root.SetText("You take a deep breath to compose yourself. You walk out and find a stable full of futa\'s examining you. You give yourself a self assured smirk before calmly returning to " + _root.SlaveName + ", whom you continue on with.");
            } // end else if
            bathroom = -1;
            return (true);
        } // end if
        if (_root.NumEvent == 10208)
        {
            if (doPoison == false)
            {
                _root.HideImages();
                super.AutoAttachAndShowMovie("poisonintro", 1, 1, 1);
                _root.SetText("As you enter the restroom a women follows in from behind. The first thing that draws your attention is her forearm thick cock, which bounces loudly against her midriff as she walks. As your gaze lingers on her she gives you a sly wink, rubs her finger against her belly collecting some of the precum film. She takes her finger and oh so suggestively sucks on it.");
                doPoison = true;
                _root.DoEvent(10210);
                return (true);
            }
            else
            {
                _root.NumEvent = 10214;
            } // end if
        } // end else if
        if (_root.NumEvent == 10209)
        {
            _root.SetText("You spend the rest of the time wandering around with " + _root.SlaveName + ", but don\'t see much going on. Overall though, it was a tranquil walk.");
            _root.Points(0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0);
            return (true);
        } // end if
        if (_root.NumEvent == 10210)
        {
            _root.HideImages();
            if (_root.SMDominance <= 35)
            {
                _root.PersonSpeak("Women", "Hmm... just looking at you I can tell. Let\'s do something very very fun my dear... I promise I\'ll make it worth your time, and that you\'ll love it.");
                _root.AddText("\r\rMore money plus more fun equals irrefutable offer for your nature.\rYou shake your head yes, she takes her hand cuffs and gently restrains your arms behind your back. Next, she ties a blindfold around your eyes saying something about how much more fun secrets are.");
                _root.DoEvent(10211);
                return (true);
            } // end if
            super.AutoAttachAndShowMovie("poisonfuck", 1, 1, 1);
            _root.SetText("She quickly pushes you onto the tile in the bathroom. Without ceremony she quickly penetrates leaving you gasping. She grasps your hair and begins pounding you in dual pain/pleasure rythnm. After a few minutes of this you finally orgasm coating her cock in your juices. Smiling she removes her cock from your pussy and expertly drives into your anus. Originally there is a sharp burning sensation, but it quickly subsides thanks to your self supplied lube. After what feels like hours, but is more nearly five minutes she releases her load hoat load into your rectum. Instead of subsiding like a normal person she continues for a couple minutes leaving your innards full of her cum.\r\r");
            _root.PersonSpeak("Poison", "You were a pretty good fuck girl. Maybe later if you\'re feeling more adventorous I could bring some of my friends and really throw a party.", true);
            _root.AddText("She continues to hold your hair, effectively keeping you in place. She then easily slides three coin bags into the opening of your vagina. On the third she keeps pushing... and pushing... your legs begin to quiver... and she keeps pushing, finally after she is elbow deep she begins to withdraw. Slowly at first, then quickly in an open palm leaving her hand drenched as you orgasm yet again. Licking her fingers she says, \"this way you won\'t blow it all just after you got it\", with a mischivious grin.");
            _root.Money(200);
            _root.DoEvent(6999);
            return (true);
        } // end if
        if (_root.NumEvent == 10211)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("arena", 1, 5, 1);
            _root.SetText("After this she calmly walks with you to a carraige she seems to have hired prior to this. After riding for what feels like half an hour, but is probably less, she helps you out of a carriage onto a dirt road. She then quietly murmurs with someone.\r\r");
            _root.PersonSpeak("women", "Thanks for being such a good sport dearest. Because of you being such a good girl, I\'ll even go easy on you.");
            _root.AddText("\r\rRough hands grab you lead you for a bit. The hands then undress you and remove your blindfold. You find yourself in a locker room, but as you are taking it in you feel, then see, a syringe plunge into your shoulder. The man who does it grins then says, \"don\'t worry, just some Gaman, it\'ll help you last longer.\"\r With that the man helps you redress, then leads you outside infront of nation\'s largest arena. He quickly guides you through a door on its side that is well guarded.");
            _root.DoEvent(10212);
            return (true);
        } // end if
        if (_root.NumEvent == 10212)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("poisondom", 1, 1, 1);
            _root.SetText("You walk through the door, only to see you have ended up in a metal cage with a crowd of men cheering around you. Across from you in the cage is your familiar \"friend\". An announcer in the middle simply announces you as the challenger, which gets a few pity claps from the crowd around you.\r");
            _root.PersonSpeak("Announcer", "The champ accepts the challenge, putting her undefeated 64 win steak by way of 58 submissions on the line. You know her, you love her, the one and only Poison.", true);
            _root.AddText("\r\rAfter this you hear a bell ring, you raise your fists in preperation to fight. Seeing this, the crowd just laughs at you. Looking around trying to figure out why, you suddenly tumble to the ground with Poison over you. She hits you twice on the arm causing you to lose feeling and movement in them. As you\'re about to roll over, you stop as she somehow able to do the same thing to your legs with two surgical strikes. Smiling, Poison gets off your immobile body and undresses much to the whooping and hollering of the crowd. Poison then proceeds to rip your clothing down the middle, exposing your breasts. She then says, \"lucky I promised to go easy, I would really love to break something as delicious as you.\" She then deepthroats you, tweaking your nipples, destroying any thought of biting down. She continues her deepthroating, causing you to get tunnel vision. She still yet continues her rythnmic thrusts, you are now presented with a decision, blackout or tapout. Yes-Tapout, No-Blackout");
            _root.DoYesNoEventXY(10213);
        } // end if
        if (_root.NumEvent == 10214)
        {
            timesVisited = timesVisited + 1;
            if (timesVisited == 1)
            {
                super.AutoAttachAndShowMovie("cockshot", 1, 1, 1);
                _root.SetText("You quickly enter the restroom As you enter the stall you can almost instantly feel your cunt start to begin to become to wet with eager anticapation. ");
                if (_root.Gender == 3)
                {
                    _root.AddText("At the same time blood begins rushing to your head as dick goes from flaccid to rock hard, your balls aching ready for action. ");
                } // end if
                _root.AddText("Seconds after you lock the door, a giant cock begins filling the hole, at first it seems as if the head won\'t fit through, but after a few grunts of effort from the otherside it quickly pops through. The sheer size, the girth it occupies, the sheen...\n");
                _root.PersonSpeak("Roxy", "What\'s the hold up? Tehe! Little Roxy is quite the stunner.", true);
                _root.AddText("\n\n You give yourelf a personal smile suprised by how enraptured you were by it. You open your lips and begin wrapping them around the head, daintly playing the underside of it with your tongue. As you push further you are suprised when the cock itself gets stuck at your teeth. For their part the person across from you pushes against your mouth with little success, instead pushing your own head back. You hear the person across from you pound her fist against the wall obviously unsatisfied. Withdrawing their cock you take a few moments to gather your composure, until the stall door begins shattering against blows from the fist on the otherside.\n\n");
                _root.PersonSpeak("Roxy", "Open this door! Please! My balls are aaaaaching!", true);
                _root.AddText("Only seconds after yelling the wooden door fractures into pieces showering the stall, and by extension you, with shards of wood. Standing infront of you is Roxy, a carefree futa with what may be the thickest member on the block. Her warm smile quickly goes to a worried frown as she sees you littered with wooden shards. After a quick examanation she looks satisfied that you aren\'t hurt however. Realizing this her smiles return as she says, \"Okay time to suck silly!\" Now semi-flacid she takes her hands grabs the back of your head. Despite your struggles she is able to force her smaller, but continually expanding cock down your throat.");
                _root.AddText("\n\\s her cock reaches full girth you can fell your jaw bones aching, and your throat on fire as your throat spasms in contractions against her tool. Despite this she is able to in combination of her hip thrusts as well as her hands forcing down on your head she is able to establish a brutal pace.\n\n");
                _root.PersonSpeak("Roxy", "Fucking better then my cocksleeve! Ummm, I can see why you\'re all the bu-AHHHZ!", true);
                _root.AddText("With a final surge she forces your nose right into her sweaty aromatic sack, and sends a direct injection load straight down into your stomach. Finished she withdraws from your throat, her partially rigid cock coated in white goo. She then smiles, taking her cock she dangles it over your face, splatters of cum drooling down from it falling directly into your eyes. Taking it in her hands she takes it and brushes it in your hair, in effect cleaning off her cock.\n");
                _root.PersonSpeak("Roxy", "Gosh! You make quite the mess! It was soooo much fun dear! I\'d help clean up your mess... but that\'s why I\'m paying you, hehe!", true);
                bjskill = bjskill + 1;
                _root.AddText("\nGagging trying to catch your breath, while simultaneously trying not to move your incredibly sore throat, you put in little resistance to her cruel game. Giggling she wipes off the very last remaining bit of cum onto a small leather bag. Pinching your nose she deposits the bag into your mouth. Struggling not to break in laughter she says, \"The salty taste of a job well done.\" Taking her cue she heads off laughing, allowing you time to clean up yourself up and make it to your next engagement.\n\nSex skill +1. Now: " + bjskill);
                _root.Money(50);
                return (true);
            }
            else
            {
                if (Math.random() > 0.900000)
                {
                } // end if
                if (loseStall > 50 && Math.random() > 0.950000)
                {
                    _root.SetText("As you wander in you see the same women as normal standing there non-chalantly waiting for you. In a unsuprising sultry voice she adresses you.\n\n");
                    _root.PersonSpeak("Women", "I\'m a bit worn out today Miss. Although... if you\'re bored there is a bit of a problem. There working maintanence on the sewer system, tentacle eradication and such. As a result the water pressure has been quite low, making it so the toilets aren\'t quite working as well as they should be. Maybe you\'de be willing to help out on the issue?", true);
                    _root.DoYesNoEvent(10214);
                } // end if
                var _loc11 = true;
                _root.SetText("As you enter the restroom, you see ");
                if (timesVisited > 2)
                {
                    _root.AddText("the same familiar ");
                }
                else
                {
                    _root.AddText("a ");
                } // end else if
                _root.AddText("women standing in the corner casually reclining against the wall. Her lips draw into a smile, as her eyes trace around your figure. ");
                if (_root.SMDominance < 40)
                {
                    var _loc4 = timesVisited - 1;
                    _loc4 = _loc4 / 2;
                    _loc4 = _loc4 * _loc4;
                    _loc4 = _loc4 * 0.100000;
                    var _loc14 = Math.random();
                    if (Math.random() >= _loc4 || Math.random() <= 0.050000)
                    {
                        _root.AddText("You eye the women measure her. Whilst she obviously seems more dominant then anyone in your position, you think you may be able to convince her to do a particular thing.");
                        _root.AskHerQuestions(10218, 10219, 10221, 0, "Deepthroat", "Blowjob", "Jerk her off", "", "What act would you like to do?");
                        return (true);
                    }
                    else
                    {
                        loseStall = loseStall + 1;
                        _loc11 = false;
                    } // end else if
                }
                else if (_root.SMDominance >= 40)
                {
                    _root.SetText("You return her gaze and clear your throat, motioning her to one of the stalls.\n\n");
                    _root.AskHerQuestions(10218, 10219, 10221, 0, "Deepthroat", "Blowjob", "Jerk her off", "", "What act would you like to perform?");
                    return (true);
                } // end else if
                if (!_loc11)
                {
                    _root.AddText("She crooks her fingers with a knowning smile on her face. Subconciously you instantly recoganize the dominance in her pose and demeanor, bending you to her desires. You try to fight conflicting messages in your mind, but she wins out in the end... and the bulge in her pants. You shyly approach her keeping your head down, eyes averted from her figure.");
                    var _loc5 = loseStall - 2;
                    _loc5 = _loc5 * 0.500000;
                    _loc5 = Math.log(_loc5);
                    var _loc10 = Math.log(loseStall * 0.500000);
                    var _loc9 = Math.log((loseStall + 2) * 0.500000);
                    var _loc8 = Math.log((loseStall + 5) * 0.500000);
                    if (!isNaN(_loc5) && _loc5 > Math.random())
                    {
                        _root.DoEvent(10217);
                    }
                    else if (!isNaN(_loc10) && _loc10 > Math.random())
                    {
                        _root.DoEvent(10216);
                    }
                    else if (!isNaN(_loc9) && _loc9 > Math.random())
                    {
                        _root.AddText(" She grabs you by the wrist and leads you to a stall, roughly pushing you in through the door of the stall.");
                        _root.DoEvent(10215);
                    }
                    else if (!isNaN(_loc8) && _loc8 > Math.random())
                    {
                        _root.DoEvent(10219);
                    }
                    else
                    {
                        _root.DoEvent(10221);
                    } // end else if
                    return (true);
                } // end if
            } // end else if
        }
        else if (_root.NumEvent == 10215)
        {
            super.AutoAttachAndShowMovie("stall_anal", 1, 1, 1);
            _root.SetText("As you enter the stall you strip naked, exposing your genatalia to the elements. She, then makes a twirling motion with her fingers for you to spin. As you do she roughly grabs your hips stopping you, your ass exposed to her. Taking her index-fingers she lewdly plunges one into your ass suddenly . You croak at the sudeness of her finger\'s invasion, but are promptly cut off as a second then third finger join the original, creating a firmer fit around each one as she goes. Apparentaly her task complete, of loosening your anus, she withdraws her fingers. You feel your anal lips slowly part as she begins to delicately slide her cock into anus. Her tenderness, however, does not completely abate the stinging as her head slowly fills more and more of your rectum.\n\n After sliding all the way in she slowly begins violating you, allowing you to aclimate to the foreign member in your ass. Despite her original slowlness, she begins to build up speed, her pre-cum acting as lubrication as she goes. She slaps your ass with a smack, at each crescendo of her hips meeting your rear. With your anus firmly wrapped around her dick for a time, her balls finally sputter coating your insides in cum which slowly drips as she withrdraws with a popping sound of a seal being broken. Finished with your task you complete your usual ritual of cleaning up, and moving on to the next event on your schedule.");
            bjskill = bjskill + 1;
            _root.AddText("\n\nSex skill +1. Now: " + bjskill);
            _root.Money(Math.round(Math.log(bjskill * bjskill) * 8));
        }
        else if (_root.NumEvent == 10216)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("stall_group_gif", 1, 0, -1);
            _root.SetText("The women leads you to the extra large stall at the end of the bathroom, as you enter the stall two well endowed twin red-head sisters stand in front of you dressed in black latex suits, staring at your body. From behind their stares, you can sub-conciously feel them them imagining new and perverse ways to violate you. The other women chuckles seeing there stares and comments before walking off, \"Don\'t get over zealous and break the toy girls!\" The one on the right walks behind you and closes the door, locking the dead bolt with an errily loud thud.");
            _root.AddText("\n\nThey both move in synchronousity, one saying, \"Let\'s see that pretty litte ass of yours!\", while the other one says, \"Let\'s see those pretty tits of yours.\" Continuing to mirror each other they both undress you at the same time leaving you standing naked in between them. Suddenly the one behind you kicks the back of your legs, causing your knees to collapse, whilst the other one forces your torso down with the palm of her hand to the back of your head. Wasting no time they both slip in their cocks, leaving the heads of each resting just within your ass and mouth. They both say \"First one to cum is the sub tonight!\"\n\n");
            _root.AddText("They both begin rocking their hips back and forth at the same speed, their large meat a comfortable fit in your well used holes. Oddly enough their motions exactly mirror each other, their cocks twitch at the same time, they make the same moans, and their motions exactly mirror each other. Finally you feel the tell tale sign as each of their cocks between twitching at the same time. ");
            if (Math.random() > 0.500000)
            {
                _root.AddText("As you sit their and ironically ponder their completely mirror like motions, as they both slow their pace as they prepare to cum, you are surprised as the one behind you unleashes her seed into your ass giving it a slimy coating. Not for the fact she came, but that they didn\'t cu... your thoughts are interrupted as the other shoots her load off down your throat emulating the other ones moan as she came.");
            }
            else
            {
                _root.AddText("As you sit their and ironically ponder their completely mirror like motions, as they both slow their pace as they prepare to cum, you are surprised as the one infront you unleashes her seed into your throat giving it a slimy coating. Not for the fact she came, but that they didn\'t cu... your thoughts are interrupted as the other shoots her load off in your ass emulating the other ones moan as she came.");
            } // end else if
            _root.AddText("They both withdaw their now flaccid cocks, smiling the winner sticks her tongue out, while the other one looks pouty. The girl behind you undoes the door as the other one walks to join her. Very strangely they seem to walk into each other inexplicably conjoining their bodies into one as they walk out.");
            bjskill = bjskill + 1;
            _root.AddText("\n\nSex skill +1, now: " + bjskill);
            _root.Money(Math.round(Math.log(bjskill * bjskill) * 8) * 2.500000);
            _root.DoEvent(6999);
            return (true);
        }
        else if (_root.NumEvent == 10217)
        {
            super.AutoAttachAndShowMovie("stall_dom_end", 1, 1, 1);
            _root.SetText("She hands you extremely lewd and humilating clothing. Made from several pieces, one covers your forearm, another connects above your chest around a metal ring, proceeding to snake down the side of your body designed to flare and show off your hips. On the bottom it has two connecters that loop on the outside of your vagina connecting the front and back leaving your pussy bare. The long stockings connecting by hooks to the torso section of the outfit.\n\nSeeing that you have changed she clasps a gold leash around the ring. You open your mouth to ask her what she is planning but she quickly backhands you across the back of the head. \"The rules are simple, you\'re my slave. A slave only orgasms when her mistress allows it... or she will be severely punished.\"\n\n The women pulls out a pair of panties with a long vibrating dildo on the end. Whilst it is similiar to ones yoou have seen before it is different, one in its girth, two in the rapid speed at which it vibrates, and three the juice that it seems to secrete. Strapping it onto you, you immediately feel your vagina quiver from the aphrodisiac laced liquid. The women tugs on your collar and forces you to crawl along, all the while the dildo rubs maddeningly against you. You crawl only a few steps before you climax. The women tugs on your leash again, this time you crawl at a fraction of the speed, barely being able to resist letting yourself go. It becomes apparent she is leading around the room.");
            if (bjskill > Math.random())
            {
                _root.AddText("Thankfully you manage to not allow yourself to cum again till the end, where she gracefully gives you permission to cum. Finally being free you climax in a long moan and what is very satisfying after holding yourself for so long. As you look up at her you realize she is gone, leaving you to gather yourself.");
            }
            else
            {
                _root.AddText("Unfortunately you cum many more times. Eyes full of disappointment she draws her hand back and spanks you for five times the times you came, ass red and sore she walks off shaking her head. \"What a let down.\"");
            } // end else if
            bjskill = bjskill + 1;
            _root.AddText("\n\nSex skill +1, now: " + bjskill);
            _root.Money(Math.round(Math.log(bjskill * bjskill) * 8) * 3);
            return (true);
        }
        else if (_root.NumEvent == 10218)
        {
            super.AutoAttachAndShowMovie("stall_deep", 1, 1, 1);
            bjskill = bjskill + 1;
            _root.AddText("\n\nSex skill +1, now: " + bjskill);
            _root.Money(Math.round(Math.log(bjskill * bjskill) * 8) * 31);
            return (true);
        }
        else if (_root.NumEvent == 10219)
        {
            super.AutoAttachAndShowMovie("stall_blow", 1, 1, 1);
            bjskill = bjskill + 1;
            _root.AddText("\n\nSex skill +1, now: " + bjskill);
            _root.Money(Math.round(Math.log(bjskill * bjskill) * 8) * 0.900000);
            return (true);
        }
        else if (_root.NumEvent == 10221)
        {
            super.AutoAttachAndShowMovie("stall_handjob", 1, 1, 1);
            _root.SetText("");
            bjskill = bjskill + 1;
            _root.AddText("\n\nSex skill +1, now: " + bjskill);
            _root.Money(Math.round(Math.log(bjskill * bjskill) * 8) * 0.800000);
            return (true);
        } // end else if
        if (_root.NumEvent == 10220)
        {
            _root.SetText("As you groggily blink upon your cum caked eyes you find yourself in the stockades at the center of town. Shifting your weight around you find the rest of your body equally cum caked as your face, including your now sore ass and pussy.\nYou can\'t quite recall how you ended up here, other than it involved a lot of cocks, and a... well fucked pussy? After hollering a bit you eventually convince a good samaritan to let unlock you from the contraption. Eyeing the sun you figure you should be able to manage to clean yourself off and make the evenings trainings of " + _root.SlaveName);
            super.AutoAttachAndShowMovie("well_fucked", 1, 1, 1);
            _root.AddTime(20 - _root.GameTime);
            _root.DoEvent(6999);
            return (true);
        } // end if
        if (_root.NumEvent == 10230)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("realbar", 1, 1, 1);
            _root.AskHerQuestions(10231, 10235, 10250, 0, "Order a drink", "Socialize", "Get up", "", "What would you like to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10231)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("rider", 1, 1, 1);
            _root.PersonSpeak("Rowadon", "What can I get for you?");
            _root.AskHerQuestions(10232, 10233, 10234, 10230, "Konjo Nashi -25G", "Kutabare -50G", "Tsuyoi ishi -125G", "Nevermind", "What do you order?");
            return (true);
        } // end if
        if (_root.NumEvent == 10232)
        {
            _root.HideImages();
            _root.Money(-25);
            super.AutoAttachAndShowMovie("riderstand", 1, 1, 1);
            _root.SetText("As you finish the drink you somehow feel some of your dominance slip away... Oddly enough you see the bartender standing over you with her foot on your chest.");
            var _loc6 = 7 - Math.ceil(Math.sqrt(_root.SMDominance) * 0.500000);
            if (_loc6 == null)
            {
                _loc6 = 0;
            } // end if
            _root.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, -_loc6);
            _root.AddText("\r\r\r\rDominance decreased by: " + _loc6);
            _root.DoEvent(10231);
            return (true);
        } // end if
        if (_root.NumEvent == 10233)
        {
            _root.HideImages();
            _root.Money(-50);
            super.AutoAttachAndShowMovie("ridernude", 1, 1, 1);
            inebration = inebration + 1;
            if (inebration < 3)
            {
                _root.SetText("As you finish the drinks your knees quiver as a wave of inebriation passes over you. ");
            } // end if
            if (inebration == 1)
            {
                _root.AddText("The drink is really quite strong, leaving you with a mild buzz.");
            }
            else if (inebration == 2)
            {
                _root.AddText("The second drink does a real number on you, you\'re noticeably slurring and have to put some concentration in putting one foot in front of the other.");
            }
            else if (inebration == 3)
            {
                _root.AddText("The bartender eyes at you with somewhat of a concerned look, then gives a slight sigh while saying, \"bloody alcoholics.\". The third drink leaves you a stumbling bumbling fool, you have no sense of propriety oogling at whatever catches your eyes and whatever comes to your lips. In general it appears you are a flagrant and raunchy drunkard.");
            }
            else if (inebration == 4)
            {
                _root.AddText("As you are about to order your drunken haze catches the best of you and your mind wonders to a sexual area, you end up fantasizing about ");
                if (_root.SMDominance <= 30)
                {
                    _root.AddText("having your pussy fucked raw, by huge meaty dildos, causing you to order a, \"Well used pussy.\"");
                    super.AutoAttachAndShowMovie("gape", 1, 1, 1);
                }
                else if (_root.SMDominance >= 75)
                {
                    _root.AddText("using the bartender\'s pussy as your personal fucktoy, causing you to order a, \"Well used pussy.\"");
                    super.AutoAttachAndShowMovie("rider_rape", 1, 1, 1);
                }
                else
                {
                    _root.AddText("having a massive lesbian orgy centered around your dream girl, you focus your sexual tension at seeing that girls pussy used over and over, causing you to order a. \"Well used pussy.\"");
                    super.AutoAttachAndShowMovie("gape", 1, 1, 1);
                } // end else if
                _root.AddText("The bartender looks at you and smiles, then mixes some substances below the bar together, then hands you a fizzy drink. You happily gulp it down, and your loins explode in a fire that causes your legs to wobble. While you\'re standing there with your juices running down your legs, someone picks you up and begins to carry you.");
                _root.DoEvent(10220);
                return (true);
            } // end else if
            _root.AddText(" As you recover you can\'t but help undress the bar tender with your eyes.");
            _root.DoEvent(10231);
            return (true);
        } // end if
        if (_root.NumEvent == 10234)
        {
            _root.HideImages();
            _root.Money(-125);
            if (_root.SMDominance <= 35)
            {
                super.AutoAttachAndShowMovie("realbar", 1, 1, 1);
                _root.SetText("Taking one whiff of the stuff you decide you really rather not try to swallow it.");
                _root.DoEvent(10231);
                return (true);
            } // end if
            _root.SetText("Holding your nose you gulp down the horrid brew. In doing so you get self confidence that if you could survive that you could survive anything. You look at the beautiful bartender and imagine what fun you could have with her if you dared.");
            var _loc7 = Math.sqrt(_root.SMDominance) - 5;
            _loc7 = Math.round(_loc7);
            _root.SMPoints(0, 0, 0, 0, 0, 0, 0, 0, _loc7);
            _root.AddText("\r\r\r\rDominance increased by " + _loc7);
            super.AutoAttachAndShowMovie("ridergdom", 1, 1, 1);
            _root.DoEvent(10231);
            return (true);
        } // end if
        if (_root.NumEvent == 10235)
        {
            var _loc13 = Math.floor(Math.random() * 1);
            if (!easDone)
            {
                easDone = true;
                _root.SetText("You look around for someone to talk to, alas it seems everybody is busy till you see a women who looks equally bored as you feel. She gives you a slight wink and pats a couch cushion next to her inviting you to sit. Do you want to sit next to her?");
                _root.DoYesNoEventXY(10235);
                super.AutoAttachAndShowMovie("eas", 1, 1, 1);
                return (true);
            }
            else
            {
                _root.SetText("You look around with someone to talk to, but ultimately just receive a lot of cold stares");
                _root.DoEvent(10230);
            } // end else if
            _root.DoEvent(10230);
            return (true);
        }
        else if (_root.NumEvent == 10236)
        {
            super.AutoAttachAndShowMovie("eas_dom", 1, 1, 1);
            _root.SetText("She continues leading you through the building, you however don\'t take in your surroundings, instead you are busy giggling at how your breasts bounce up and down seductively. All of a sudden you let out a drunken, \"Oww!\" as the women kicks you onto the floor, as you try to sit up she sits on your stomach and secures your wrists in cuffs, then does the same with your thighs.\n");
            _root.PersonSpeak("Eas", "Let\'s see how you like it you fucking like it, you alcoholic skank. You\'ll rue the day you screwed with Eas.", true);
            _root.AddText("\n\nEas straps a black cloth to function as blindfold onto you, while you vainly struggle at the bonds. All of a sudden a large pressure forces down onto your face. You vainly gasp at air through your nose, only to find a rather foul smell assault your nostrils. As you let off a small gag you find you can squeak in a few breaths from your mouth. As you begin to become accustomed to breathing through a small hole in your mouth Eas shifts on top of you. This causes you to quickly lose your air supply, as your head becomes even foggier from a lack of oxygen she shifts once again allowing you a quick gasp of air before closing it off again.\n\n");
            _root.PersonSpeak("Eas", "I\'m perfectly happy to sit here for the rest of the night skank. You\'re not going anywhere till I\'m satisfied you have learnt your lesson, so start moving that whore tongue of yours.", true);
            _root.AddText("\n\nDo you want to start licking her?");
            _root.DoYesNoEventXY(10236);
            return (true);
        } // end else if
        if (_root.NumEvent == 10237)
        {
            super.AutoAttachAndShowMovie("eas_proud", 1, 1, 1);
            _root.SetText("Not waiting for your response she gaves a herculean pull on the rope. Several overwhelming happen in this first instant. First, fire erupts from your nipples as they are jerked forward in agony. Second, your pussy betrays you becoming wet as the rope slides abrasively along it. Lastly, your neck is forced back in part by the tension, as well as to counteract the other effects. Whilst you struggle, or more factualy attempt not to struggle, against her cruel invention Eas busies herself by opening a sliding trap door from the floor. Under this trap door lies a shallow eight inch pool of water with a square 5\'x5\' dimensions. With a narcistic self pleased smile on her face she stands at your side. Reaching down she places a ballgag around your head with sadism in her eyes. \"Don\'t want my little whore to make any noise in her prostration!\" ");
            _root.AddText("Taking her heel she roughly kicks you in the side, causing you to flip over to your stomach. A subsequent kick later you complete a barrell roll, and are on step closer to the water. After a few more kicks you get the message, and begin rolling without her coercion. Eas looks down at you as you do with a phoney smile of pride, \"What a good little whore! Your still a dumb fucking cunt for taking so damn long to get the message, making your mistresses legs ooh so tired. Hmmm, suppose we will have to extend your punishment by another couple of hours.\" As she finishes her statement you finally roll into the water with a splash. Giving you a little wave from her hands Eas says, \"Ta ta!\", sliding the trapdoor back over the pool of water. As the door finishes sliding over you find out the point of her rope rigging. If you want to breathe you have to crane your neck up, causing immense pain to your nipples. Unfortunately due to this pain you can\'t hold this position and are forced relapse back into the water. All the while the rope against your pussy oscilliates with your movements causing you to get closer and closer to orgasm.");
            _root.DoEvent(10238);
            return (true);
        }
        else if (_root.NumEvent == 10237)
        {
        }
        else if (_root.NumEvent == 10238)
        {
            _root.SetText("Hours whittle away as the cruel device fullfills its purpose, causing you to erupt in orgasm many times. Just as you near collapse from exhaustion and pain, the door slides open, from which Revy stands triumphantly over you. Exhausted physically and mentally you can\'t help but look up at her and whimper. \"Step one in my four step process to profit, Break a cunt. \'Sapose I can check that off in bold. Seriously though, don\'t fucking cross me twice, this was a friendly warning from me to you.\" Encouraged by your vigorous nodding she comes over and release the main rope, allowing you to finally relax. You wait eagerly to release  the rest of your bindings, looking at her expectantly, rolling her eyes she walks out with her usual self assured smile. What feels like half an hour later a few guards come to untie you, and lead you out of the building.");
            _root.AddTime(20 - _root.GameTime);
            _root.DoEvent(6999);
            return (true);
        } // end else if
        if (_root.NumEvent == 10248)
        {
            _root.HouseEvents.ShowCurrentFloor();
            return (true);
        } // end if
        if (_root.NumEvent == 10249)
        {
            _root.ShowHallway(15, false);
            _root.SetText("The guard watches you as you come through the hallway.");
            _root.HideImages();
            super.AutoAttachAndShowMovie("guard", 1, 1, 1);
            _root.HouseEvents.HideCurrentFloor();
            _root.SetText("Leave?");
            _root.DoYesNoEvent(10249);
            return (true);
        } // end if
        if (_root.NumEvent == 10250)
        {
            debtlose = false;
            totalMoney = 0;
            _root.HouseEvents.HideCurrentFloor();
            _root.HideImages();
            super.AutoAttachAndShowMovie("bar", 1, 0, 1);
            _root.AskHerQuestions(10251, 10230, 10248, 0, "Blackjack", "Bar", "Nothing", "", "What would you like to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10251)
        {
            _root.HouseEvents.HideCurrentFloor();
            _root.HideImages();
            super.AutoAttachAndShowMovie("dealer", 1, 0, 1);
            _root.SetText("Specifics:\r\r The game is played with two combined decks, which are shuffled after the last card is drawn from the deck. The game is played face down, until both players elect to stay, at which point a winner is determined.");
            _root.AskHerQuestions(10252, 10253, 10254, 10255, "50", "100", "500", "1000", "How much would you like to bet on each round?");
            super.AutoAttachAndShowMovie("dealer", 1, 0, 1);
            return (true);
        } // end if
        if (_root.NumEvent == 10252)
        {
            this.Deck();
            this.shuffle();
            betamount = 50;
            this.drawCard(0);
            this.drawCard(0);
            _root.SetText("You draw twice to begin the round.\r\r");
            _root.AddText("Your hand is:\r" + this.getHand(0));
            this.drawCard(1);
            this.drawCard(1);
            _root.AddText("\rThe dealer drew two cards.");
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10253)
        {
            this.Deck();
            this.shuffle();
            betamount = 100;
            this.drawCard(0);
            this.drawCard(0);
            _root.SetText("You draw twice to begin the round.\r\r");
            _root.AddText("Your hand is:\r" + this.getHand(0));
            this.drawCard(1);
            this.drawCard(1);
            _root.AddText("\rThe dealer drew two cards.");
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10254)
        {
            this.Deck();
            this.shuffle();
            betamount = 500;
            this.drawCard(0);
            this.drawCard(0);
            _root.SetText("You draw twice to begin the round.\r\r");
            _root.AddText("Your hand is:\r" + this.getHand(0));
            this.drawCard(1);
            this.drawCard(1);
            _root.AddText("\rThe dealer drew two cards.");
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10255)
        {
            this.Deck();
            this.shuffle();
            betamount = 1000;
            this.drawCard(0);
            this.drawCard(0);
            _root.SetText("You draw twice to begin the round.\r\r");
            _root.AddText("Your hand is:\r" + this.getHand(0));
            this.drawCard(1);
            this.drawCard(1);
            _root.AddText("\rThe dealer drew two cards.");
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10256)
        {
            this.drawCard(0);
            _root.SetText("Hand: " + this.getHand(0));
            if (this.determine() == -2)
            {
                totalMoney = totalMoney - betamount;
                if (debtlose)
                {
                    if (_root.SMDominance <= 15)
                    {
                        _root.AddText("\rYou try to bolster your resolve and resist this! Ultimately though, you know you are a meek person... besides to be honest with yourself, the thought of those cuffs on you turns yourself on.");
                        _root.AskHerQuestions(10263, 0, 0, 0, "Submit", "", "", "");
                        return (true);
                    } // end if
                    _root.AskHerQuestions(10261, 10262, 10263, 0, "Bribe her", "Run!", "Submit", "", "You\'ve lost, what do you wish to do?");
                    return (true);
                } // end if
                _root.AddText("\r\rYou busted! Your tab is at: " + totalMoney + "\r\r");
                if (totalMoney < -5000)
                {
                    _root.AskHerQuestions(10260, 10259, 10251, 0, "Again?", "Stand up", "Change bet/Rules", "", "What do you wish to do?");
                    return (true);
                } // end if
                _root.AskHerQuestions(10258, 10259, 10251, 0, "Again?", "Stand up", "Change bet/Rules", "", "What do you wish to do?");
                return (true);
            } // end if
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10257)
        {
            while (this.getVal(1) < 17)
            {
                this.drawCard(1);
                _root.AddText("The dealer hit, and drew a new card.\r");
            } // end while
            _root.AddText("\rDealer\'s hand: " + this.getHand(1));
            _root.AddText("\rYour hand: " + this.getHand(0) + "\r");
            if (this.determine() > 0)
            {
                totalMoney = totalMoney + betamount;
                _root.AddText("You won! Current tab at: " + totalMoney);
            }
            else if (this.determine() < 0)
            {
                if (debtlose)
                {
                    super.AutoAttachAndShowMovie("debtlose", 1, 0, 1);
                    if (_root.SMDominance <= 15)
                    {
                        _root.AddText("\rYou try to bolster your resolve and resist this! Ultimately though, you know you are a meek person... besides to be honest with yourself, the thought of those cuffs on you turns yourself on.");
                        _root.AskHerQuestions(10263, 0, 0, 0, "Submit", "", "", "");
                        return (true);
                    } // end if
                    _root.AskHerQuestions(10261, 10262, 10263, 0, "Bribe her", "Run!", "Submit", "", "You\'ve lost, what do you wish to do?");
                    return (true);
                } // end if
                totalMoney = totalMoney - betamount;
                _root.AddText("You lost! Current tab at: " + totalMoney);
            }
            else
            {
                if (debtlose)
                {
                    _root.PersonSpeak("... I wasn\'t expecting that. Regardless you still have to win or lose a hand.");
                    _root.DoEvent(10260);
                    return (true);
                } // end if
                _root.AddText("It was draw. Current tab at: " + totalMoney);
            } // end else if
            if (totalMoney < -5000)
            {
                _root.AskHerQuestions(10260, 10259, 10251, 0, "Again?", "Stand up", "Change bet/Rules", "", "What do you wish to do?");
                return (true);
            } // end if
            _root.AskHerQuestions(10258, 10259, 10251, 0, "Again?", "Stand up", "Change bet/Rules", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10258)
        {
            this.resetHand();
            this.drawCard(0);
            this.drawCard(0);
            _root.SetText("You draw twice to begin the round.\r\r");
            _root.AddText("Your hand is:\r" + this.getHand(0));
            this.drawCard(1);
            this.drawCard(1);
            _root.AddText("\rThe dealer drew two cards.");
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10259)
        {
            _root.Money(totalMoney);
            totalMoney = 0;
            _root.SetText("You stand up from the table, you go through the motions and end up with " + totalMoney);
            _root.DoEvent(10250);
            return (true);
        } // end if
        if (_root.NumEvent == 10260)
        {
            this.resetHand();
            super.AutoAttachAndShowMovie("debt", 1, 0, 1);
            this.drawCard(0);
            this.drawCard(0);
            if (debtdone == false)
            {
                _root.AddText("You draw another two cards. For some reason the dealer hesitates, you give her a sharp look, but she sighs and produces a pair of handcuffs.\r\r");
                _root.PersonSpeak("Dealer", "You\'ve collected quite the debt. I hate doing this, but it is employee policy. If you lose this round you will be forced to pay for your debts. Since you already drew, you can\'t back out now.");
            }
            else
            {
                _root.AddText("You draw twice to begin the round.\r\r");
                _root.AddText("The dealer shakes her head in what seems like disgust, then holds out the all to familiar cuffs.");
            } // end else if
            debtlose = true;
            _root.AddText("Your hand is:\r" + this.getHand(0));
            this.drawCard(1);
            this.drawCard(1);
            _root.AddText("\rThe dealer drew two cards.");
            _root.AskHerQuestions(10256, 10257, 0, 0, "Hit", "Stay", "", "", "What do you wish to do?");
            return (true);
        } // end if
        if (_root.NumEvent == 10261)
        {
            _root.SetText("You feel butterflies float up into your stomach as you examine the situation. Thinking quickly you give a winning smile and push the cuffs away. Weighing her carefully, you try to offer her a reasonable value to forget about the event. After quietly bargaining with her she finally hits her firm rock bottom of: " + Math.round(10000 - 5000 * (_root.SMConversation + _root.SMReputation) / 2 * 0.010000) + " gold.");
            if (Math.round(10000 - 5000 * (_root.SMConversation + _root.SMReputation) / 2 * 0.010000) > _root.VarGold)
            {
                _root.AddText(" Knowing you don\'t have enough money, you decide to re-examine your options");
                _root.AskHerQuestions(10263, 10262, 0, 0, "Give up", "Run", "", "", "What will you decide to do?");
            }
            else
            {
                _root.Money(Math.round(10000 - 5000 * (_root.SMConversation + _root.SMReputation) / 2 * 0.010000 * -1));
                _root.AddText(" With some pain you extract the heap of money and casually slid it to the dealer before getting up.");
                totalMoney = 0;
                _root.DoEvent(10248);
            } // end else if
            return (true);
        } // end if
        if (_root.NumEvent == 10262)
        {
            _root.InitialiseCombat("", 10265, 10266, 10267, 10267, true);
            _root.SetText("You run towards the door in your attempt to escape, but the door guard is blocking your way.");
            var _loc12 = _root.AttachMovie("combat", BaseMovie);
            _loc12._visible = false;
            myMonster = new MonsterTaki(50, 50, 50, 20, "Taki", _loc12);
            _root.AddMonster(myMonster);
            _root.DoEvent(3000);
            return (true);
        } // end if
        if (_root.NumEvent == 10263)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("debtlose", 1, 1, 1);
            _root.SetText("You hold out your wrists to the dealer. With a seemingly finality she clicks the handcuffs. As they rest on your wrists you can feel the magic imbued with them slowly sapping your will. ");
            _root.AddText("Two men come out of the shadows and attach a collar to your neck. The men then go to work ripping the clothing from your body leaving you blushing and naked infront of the entire crowd now gathered around you. They tug on the collar, which like the handcuffs is not as plain as they seem. You try to resist, but your body functions on its own, causing you to get up and impassively follow them.");
            _root.DoEvent(10264);
            return (true);
        } // end if
        if (_root.NumEvent == 10264)
        {
            _root.SetText("More content to be added ^.^, doesn\'t waiting suck?");
            _root.DoEvent(6999);
            return (true);
        } // end if
        if (_root.NumEvent == 10265)
        {
            _root.HideImages();
            super.AutoAttachAndShowMovie("runrope", 1, 1, 1);
            _root.addText("For some reason you decide to run back to the main room. The guard jumps on you from behind and quickly frog ties you on the floor. After struggling as two men come to take you away you are promptly hit over the head, as your conciousness fades you feel cool metal slide onto your wrists and neck.");
            _root.DoEvent(10264);
            return (true);
        } // end if
        if (_root.NumEvent == 10266)
        {
            _root.SetText("Oddly enough the bartender is loitering outside reading a book. She looks up seeing you run out in a panic.\r\r");
            _root.PersonSpeak("Rowadon", "That self proclaimed fighter failed to live up to expectations, managements policy is that your debt is now hers. Although, I don\'t think gambling here anymore would be a good idea. By the way, I think the attention this will create has also earned you a little bit more permission to experience us more... fully.", true);
            _root.AddText("\r\r(Dance area unlocked.... if it were done. X_X)");
            _root.DoEvent(10264);
        } // end if
        if (_root.NumEvent == 10267)
        {
            _root.SetText("You collapse, your energy entirely drawn from you. Your conciousness begins to fade, but you feel the cold metal of cuffs and collar slide onto your wrists and neck.");
            _root.DoEvent(10264);
            return (true);
        } // end if
        if (_root.NumEvent == 10270)
        {
            _root.SetText("An employee yells as you enter, forcing you to turn back.");
            _root.HouseEvents.ShowCurrentFloor();
            return (true);
        } // end if
        if (_root.NumEvent == 10271)
        {
            if (closetAction == 1)
            {
                _root.SetText("As you open the door you fail to see eas... scratching your head in frustration, you find a note on the floor.\n\n\"I apolgize for not meeting you... something arised, I plan to seek you out later if you are still willing.");
            }
            else if (closetAction == 2)
            {
                _root.SetText("True to her word eas is standing in the closet waiting for you. As you close the door she tosses you a rag and duct tape and motions for you to gag yourself. In no state to think rationally you do so giggling to yourself. Walking to you she sweeps your legs out under you, gracefully catching you in her arms and reclining you to the floor. From her person she removes two pairs of cuffs and puts them on both your wrists then ankles with a click. Smiling she removes two keys, \"You\'ll have to work for your freedom.\" Removing both of your clothes she slides one of the keys up her vagina, and the others yours. Smiling she stands over you. Getting onto your knees you reach up with your hand to get it. Eas slaps it away with a \"Tsk! Tsk!\" Pondering for a moment you understand, you begin reaching with your tongue up her pussy. Despite all your efforts you find you can\'t quite reach it, although you have left her shivering. She smiles down at you subliminally encouraging you to continue. As you continue licking her out you feel her clench down on your tongues, finally releasing in climax as her juices and the key fall onto your face. Taking a few moments to recover she removes a large 3 dildo with a metal tip. The dildo itself starts at a relatively small width at the tip gradually becoming as large as your first at the base. Making sure she has your attention she takes her key and like teaching a idiot child touches it to the tip to prove that it is a magnet. Tossing it to you, you use the key to unlock your wrists, and grab the dildo in your hand. Spreading your legs you ease the dildo into your self lubricated cunt. Despite putting all your strength into it you can only seem to get it about 3/4ths of the way. Taking it back you once again you shove with all your force, the dildo going a tiny bit farther. A while and a couple climaxes later you are finally able to retrieve the key on Eas\'s watchful. As you finally pull it out Eas gives you a nod and leaves the closet, you recouperate yourself, beginning with removing your gag. Exhausted you head out of the bar to continue your day.");
                _root.DoEvent(6999);
            }
            else
            {
                _root.SetText("It appears to be a rather mundane but large closet off to the side of the room.");
                _root.DoEvent(10248);
            } // end else if
            return (true);
        } // end if
        return (false);
    } // End of the function
    function SMCustomTrainingAsAssistant()
    {
        if (contractFirst)
        {
            contractFirst = false;
            _root.SetText("She meets you at a backdoor, and quickly ushers you into a small private room that is similiar to an office. She takes a seat at the opposite of the desk, giving you a stern look as you\'re about to sit down yourself. \"Please grab the brown parcel and put on the clothing inside.\" You follow her directions, openning up the box, inside you simply find a dull gray bracelet. Wondering you slip the bracelet on your right wrist. Immediately a slight tingling occurs and your previous clothing simply vanishes leaving you leaving you with a very simple cloth underwear. \"As you have probably sumarized, that is no ordinary bracelet, it is actually an enchanted one... very heavily enchanted. It possesses many qualities, but only a few you need to be concerned with for now. One: It cannot be removed. Two: An itch will always be pulling you to this place. Unoticeable at first, but eventually you will not be able to resist it. This itch is sated by returning here. Three: your clothing will be altered based upon need, or if there is no particular need, it will draw upon your sub-concious. Finally, the bracelet may be influenced in other ways by employess high enough above your station, so try not piss anyone off. Kind of daunting, but don\'t fret, as long as you\'re an obedient whore for these next two weeks you\'ll be released from this... if you want to be. Now, I was able to acquire you for this shift. I know you can give excellent head, but I need to test your basics on females. I have some paper work to do, so get under my desk and pleasure me.");
            super.AutoAttachAndShowMovie("braceexplain", 1, 1, 1);
            if (_root.SMDominance < 20)
            {
                
            } // end if
            _root.DoEvent(6999);
            return (true);
        } // end if
        _root.HidePlanningNext();
        inebration = 0;
        _root.HideStatChangeIcons();
        _root.HouseEvents.InitialiseExploration("", "");
        _root.HouseEvents.AddRoomAndPosition(0, "Hallway", 10249, 85, 307, 23, 10, 0, false);
        _root.HouseEvents.AddRoomAndPosition(0, "Bar", 10250, 10, 180, 175, 130, 0, false);
        _root.HouseEvents.AddRoomAndPosition(0, "Employee Lounge", 10270, 184, 180, 15, 85, 0, false);
        _root.HouseEvents.AddRoomAndPosition(0, "Closet", 10271, 184, 265, 15, 45, 0, false);
        _root.HouseEvents.AddDoorToRoom(0, 1, 0, 1, 1, 0);
        _root.HouseEvents.AddDoorToRoom(1, 2, 0, 1, 1, 0);
        _root.HouseEvents.AddDoorToRoom(1, 3, 0, 1, 1, 0);
        _root.HouseEvents.SetRoomExplored(0);
        _root.HouseEvents.SetCurrentRoom(0);
        _root.HouseEvents.ShowCurrentFloor();
        _root.HideImages();
        _root.ShowHallway(15, false);
        _root.SetText("The guard watches you as you come through the hallway.");
        super.AutoAttachAndShowMovie("guard", 1, 1, 1);
        if (this.contractEval())
        {
            _root.AddText("\n\n Would go to contract obligations if implemented");
        } // end if
        return (true);
    } // End of the function
    function Deck()
    {
        deck = new Array("H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H1", "HJ", "HQ", "HK", "HA", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H1", "HJ", "HQ", "HK", "HA", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D1", "DJ", "DQ", "DK", "DA", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D1", "DJ", "DQ", "DK", "DA", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C1", "CJ", "CQ", "CK", "CA", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C1", "CJ", "CQ", "CK", "CA", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S1", "SJ", "SQ", "SK", "SA", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S1", "SJ", "SQ", "SK", "SA");
        index = 0;
        playerHand = "";
        npcHand = "";
    } // End of the function
    function shuffle()
    {
        for (var _loc2 = 0; _loc2 < deck.length; _loc2 = _loc2 + 1)
        {
            var _loc4 = deck[_loc2];
            var _loc3 = random(deck.length);
            deck[_loc2] = deck[_loc3];
            deck[_loc3] = _loc4;
        } // end of for
        return (deck);
    } // End of the function
    function drawCard(player)
    {
        if (index == 104)
        {
            this.shuffle();
            index = 0;
        } // end if
        var _loc2 = deck[index];
        index = index + 1;
        if (player == 0)
        {
            playerHand = playerHand + (_loc2 + "!");
        }
        else
        {
            npcHand = npcHand + (_loc2 + "!");
        } // end else if
    } // End of the function
    function getVal(player)
    {
        var _loc7 = "";
        if (player == 0)
        {
            _loc7 = playerHand;
        }
        else
        {
            _loc7 = npcHand;
        } // end else if
        var _loc4 = 0;
        var _loc5 = 0;
        var _loc2 = "";
        var _loc8 = 0;
        for (var _loc3 = 1; _loc3 < _loc7.length; _loc3 = _loc3 + 3)
        {
            _loc2 = _loc7.substr(_loc3, 1);
            if (_loc2 == "K" || _loc2 == "Q" || _loc2 == "J" || _loc2 == "1")
            {
                _loc4 = _loc4 + 10;
                continue;
            } // end if
            if (_loc2 == "A")
            {
                _loc5 = _loc5 + 1;
                continue;
            } // end if
            _loc8 = Number(_loc2);
            _loc4 = _loc4 + _loc8;
        } // end of for
        _loc4 = _loc4 + _loc5 * 11;
        var _loc9 = 0;
        for (var _loc6 = true; _loc6; _loc6 = false)
        {
            if (_loc4 > 21)
            {
                if (_loc5 > 0)
                {
                    _loc5 = _loc5 - 1;
                    _loc4 = _loc4 - 10;
                }
                else
                {
                    _loc6 = false;
                } // end else if
                continue;
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    function determine()
    {
        var _loc2 = this.getVal(0);
        var _loc3 = this.getVal(1);
        if (_loc2 > 21)
        {
            return (-2);
        } // end if
        if (_loc3 > 21)
        {
            return (2);
        } // end if
        if (_loc2 == _loc3)
        {
            return (0);
        } // end if
        if (_loc2 > _loc3)
        {
            return (1);
        } // end if
        return (-1);
    } // End of the function
    function npcMove()
    {
        if (this.getVal(1) < 17)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function getHand(player)
    {
        var _loc9 = "";
        if (player == 0)
        {
            _loc9 = playerHand;
        }
        else
        {
            _loc9 = npcHand;
        } // end else if
        var _loc7 = "";
        for (var _loc6 = 0; _loc6 < _loc9.length; _loc6 = _loc6 + 3)
        {
            _loc7 = _loc7 + _loc9.substr(_loc6, 2);
        } // end of for
        var _loc8 = "";
        for (var _loc4 = 1; _loc4 < _loc7.length; _loc4 = _loc4 + 2)
        {
            _loc8 = _loc8 + _loc7.substr(_loc4, 1);
            _loc8 = _loc8 + _loc7.substr(_loc4 - 1, 1);
        } // end of for
        var _loc2 = "";
        var _loc3 = "";
        for (var _loc5 = 0; _loc5 < _loc8.length; _loc5 = _loc5 + 1)
        {
            _loc2 = _loc8.substr(_loc5, 1);
            if (_loc2 == "A")
            {
                _loc3 = _loc3 + "Ace of ";
                continue;
            } // end if
            if (_loc2 == "K")
            {
                _loc3 = _loc3 + "King of ";
                continue;
            } // end if
            if (_loc2 == "Q")
            {
                _loc3 = _loc3 + "Queen of ";
                continue;
            } // end if
            if (_loc2 == "J")
            {
                _loc3 = _loc3 + "Jack of ";
                continue;
            } // end if
            if (_loc2 == "1")
            {
                _loc3 = _loc3 + "Ten of ";
                continue;
            } // end if
            if (_loc2 == "9")
            {
                _loc3 = _loc3 + "Nine of ";
                continue;
            } // end if
            if (_loc2 == "8")
            {
                _loc3 = _loc3 + "Eight of ";
                continue;
            } // end if
            if (_loc2 == "7")
            {
                _loc3 = _loc3 + "Seven of ";
                continue;
            } // end if
            if (_loc2 == "6")
            {
                _loc3 = _loc3 + "Six of ";
                continue;
            } // end if
            if (_loc2 == "5")
            {
                _loc3 = _loc3 + "Five of ";
                continue;
            } // end if
            if (_loc2 == "4")
            {
                _loc3 = _loc3 + "Four of ";
                continue;
            } // end if
            if (_loc2 == "3")
            {
                _loc3 = _loc3 + "Three of ";
                continue;
            } // end if
            if (_loc2 == "2")
            {
                _loc3 = _loc3 + "Two of ";
                continue;
            } // end if
            if (_loc2 == "H")
            {
                _loc3 = _loc3 + "Hearts. ";
                continue;
            } // end if
            if (_loc2 == "D")
            {
                _loc3 = _loc3 + "Diamonds. ";
                continue;
            } // end if
            if (_loc2 == "C")
            {
                _loc3 = _loc3 + "Clubs. ";
                continue;
            } // end if
            if (_loc2 == "S")
            {
                _loc3 = _loc3 + "Spades. ";
            } // end if
        } // end of for
        return (_loc3 + "\rResulting in a value of: " + this.getVal(player));
    } // End of the function
    function resetHand()
    {
        playerHand = "";
        npcHand = "";
    } // End of the function
    function contractEval()
    {
        return (_root.GameDate - contractStartDate < 20);
    } // End of the function
    var totalMoney = 0;
    var debtlose = false;
    var myMonster = null;
} // End of Class
