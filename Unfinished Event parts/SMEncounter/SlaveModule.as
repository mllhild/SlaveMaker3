class SlaveModule
{
    var Assistant, LoadedMovieArray, BaseMovie, Assisting, AsEvent, Naked, Lesbian, Aroused, ServantName, ServantGender, SlaveName, Elapsed, loading, ModuleName, Introduction, Untrainable;
    function SlaveModule(mc)
    {
        Assistant = undefined;
        LoadedMovieArray = new Array();
        BaseMovie = mc;
        Assisting = false;
        AsEvent = false;
        Naked = false;
        Lesbian = false;
        Aroused = false;
        ServantName = "";
        ServantGender = 2;
        SlaveName = "";
        Elapsed = 0;
        loading = false;
        ModuleName = "";
    } // End of the function
    function LoadGame(loaddata)
    {
    } // End of the function
    function SaveGame(savedata)
    {
    } // End of the function
    function ShowAsAssistant(type)
    {
    } // End of the function
    function InitialiseAsAssistant(firstload)
    {
        return (Assistant);
    } // End of the function
    function EmployAsAssistant()
    {
    } // End of the function
    function HideAsAssistant()
    {
        while (LoadedMovieArray.length > 0)
        {
            var _loc2 = (MovieClip)(LoadedMovieArray.pop());
            _loc2.removeMovieClip();
        } // end while
    } // End of the function
    function DestroyAsAssistant()
    {
    } // End of the function
    function ShowIntroPage(page)
    {
        Introduction._visible = true;
        return (Introduction);
    } // End of the function
    function HideIntroPages()
    {
        Untrainable._visible = false;
        Introduction._visible = false;
    } // End of the function
    function ShowUntrainable()
    {
        Untrainable._visible = true;
        return (Untrainable);
    } // End of the function
    function ContestBonus(num)
    {
        return (0);
    } // End of the function
    function DoEventNextAsAssistant()
    {
        return (false);
    } // End of the function
    function AfterEventNextAsAssistant()
    {
    } // End of the function
    function PreEventAsAssistant()
    {
        return (false);
    } // End of the function
    function EventsAsAssistant()
    {
    } // End of the function
    function AfterEventsAsAssistant()
    {
        return (false);
    } // End of the function
    function DoEventYesAsAssistant()
    {
        return (false);
    } // End of the function
    function AfterEventYesAsAssistant()
    {
    } // End of the function
    function DoEventNoAsAssistant()
    {
        return (false);
    } // End of the function
    function AfterEventNoAsAssistant()
    {
    } // End of the function
    function ApplyDifficultyAsAssistant(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special)
    {
        return;
    } // End of the function
    function LimitMaxMinStatsAsAssistant()
    {
    } // End of the function
    function UpdateDateAndItemsAsAssistant(NumDays)
    {
    } // End of the function
    function IntroductionAsAssistant()
    {
        return (false);
    } // End of the function
    function StartMessageAsAssistant(bSGMessage)
    {
        return (false);
    } // End of the function
    function UpdateSlaveAsAssistant(NumDays)
    {
    } // End of the function
    function StartDayAsAssistant()
    {
        return (false);
    } // End of the function
    function StartMorningAsAssistant()
    {
        return (false);
    } // End of the function
    function StartNightAsAssistant(intro)
    {
        return (false);
    } // End of the function
    function StartEveningAsAssistant()
    {
        return (false);
    } // End of the function
    function NewPlanningActionAsAssistant(type, available)
    {
        return (false);
    } // End of the function
    function AfterNewPlanningActionAsAssistant(type, available)
    {
    } // End of the function
    function AfterPlanningActionAsAssistant(LastActionDone)
    {
    } // End of the function
    function ShowRefusedActionAsAssistant(Action, slave, servant, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special)
    {
    } // End of the function
    function ShowAsAssistantTentacleSex()
    {
    } // End of the function
    function SupervisorTentacleSexAsAssistant()
    {
        return (false);
    } // End of the function
    function SupervisorRepelsTentaclesAsAssistant()
    {
    } // End of the function
    function DocksAreasAsAssistant(secure)
    {
    } // End of the function
    function BeachActivitiesAsAssistant()
    {
    } // End of the function
    function TakeAWalkAsAssistant(place)
    {
        return (false);
    } // End of the function
    function AfterWalkAsAssistant(place, present)
    {
    } // End of the function
    function DoWalkHouseAsAssistant(house)
    {
        return (false);
    } // End of the function
    function DoWalkBeachSwimAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkBeachWalkAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkBeachPrivateAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkBeachRocksAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkTownCenterAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkForestAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkLakeAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkSlumsAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkPalaceAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkFarmAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkRuinsAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkDocksPortAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkDocksSlavePensAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function DoWalkDocksSlavePensSecureAsAssistant(NumEvent, present)
    {
        return (false);
    } // End of the function
    function PurchaseItemAsAssistant(item, hint)
    {
        return (false);
    } // End of the function
    function DoTailorYesAsAssistant(dress)
    {
        return (false);
    } // End of the function
    function PurchaseDrugAsAssistant(dnum, hint)
    {
        return (false);
    } // End of the function
    function DrinkPotionAsAssistant(potion, price, say)
    {
        return (false);
    } // End of the function
    function EndingStartAsAssistant(total)
    {
        return (false);
    } // End of the function
    function EndingFinishAsAssistant(total)
    {
        return (false);
    } // End of the function
    function NumCustomEndingsAsAssistant()
    {
        return (0);
    } // End of the function
    function ShowEndingsAsAssistant(num)
    {
    } // End of the function
    function HideEndingsAsAssistant()
    {
    } // End of the function
    function Initialise()
    {
    } // End of the function
    function StartGame()
    {
    } // End of the function
    function StartMessage()
    {
        return (false);
    } // End of the function
    function IsTrainable()
    {
        return (true);
    } // End of the function
    function ShowContractSigned()
    {
    } // End of the function
    function Destroy()
    {
    } // End of the function
    function GetTotalMaleSlavesOwned(sextype, noassistant)
    {
        return (_root.GetTotalMaleSlavesOwnedBase(sextype, noassistant));
    } // End of the function
    function GetTotalFemaleSlavesOwned(sextype, noassistant)
    {
        return (_root.GetTotalFemaleSlavesOwnedBase(sextype, noassistant));
    } // End of the function
    function GetTotalDickgirlSlavesOwned(sextype, noassistant)
    {
        return (_root.GetTotalDickgirlSlavesOwnedBase(sextype, noassistant));
    } // End of the function
    function GetRandomFemaleSlaveOwned(sextype)
    {
        return (null);
    } // End of the function
    function GetRandomMaleSlaveOwned(sextype)
    {
        return (null);
    } // End of the function
    function GetRandomDickgirlSlaveOwned(sextype)
    {
        return (null);
    } // End of the function
    function ApplyDifficulty(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Special)
    {
        return;
    } // End of the function
    function UpdateDateAndItems(NumDays)
    {
    } // End of the function
    function UpdateSlave(NumDays)
    {
    } // End of the function
    function ShowSexDream(LesDream)
    {
    } // End of the function
    function PreEvent()
    {
        return (false);
    } // End of the function
    function Events()
    {
    } // End of the function
    function AfterEvents()
    {
        return (false);
    } // End of the function
    function DoEventNext()
    {
        return (false);
    } // End of the function
    function AfterEventNext()
    {
    } // End of the function
    function DoEventYes()
    {
        return (false);
    } // End of the function
    function AfterEventYes()
    {
    } // End of the function
    function DoEventNo()
    {
        return (false);
    } // End of the function
    function AfterEventNo()
    {
    } // End of the function
    function StartDay()
    {
        return (false);
    } // End of the function
    function StartNight()
    {
    } // End of the function
    function StartMorning()
    {
        return (false);
    } // End of the function
    function StartEvening()
    {
        return (false);
    } // End of the function
    function NewPlanningAction(type, available)
    {
        return (false);
    } // End of the function
    function AfterNewPlanningAction(type, available)
    {
    } // End of the function
    function AfterPlanningAction(LastActionDone)
    {
    } // End of the function
    function DoPlanningAction(Action)
    {
        return (false);
    } // End of the function
    function DoNewPlanningYes()
    {
        return (false);
    } // End of the function
    function ShowRefusedAction(Action, slave, servant, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special)
    {
        return (false);
    } // End of the function
    function ShowMaidUniformSmall()
    {
    } // End of the function
    function ShowGigaBE()
    {
        return (false);
    } // End of the function
    function SlaveSkillHintRollOver(skill)
    {
        return (false);
    } // End of the function
    function TempleHouseRent()
    {
        return (false);
    } // End of the function
    function ShowAttackChoices(runmsg)
    {
        return (false);
    } // End of the function
    function SetRule(rule)
    {
        return (true);
    } // End of the function
    function ClearRule(rule)
    {
        return (true);
    } // End of the function
    function ShowDemonRape()
    {
        return (false);
    } // End of the function
    function TestObedience(Difficulty, Action)
    {
        return (_root.TestObedienceBase(Difficulty, Action));
    } // End of the function
    function ShowStatHint(stat)
    {
        return (false);
    } // End of the function
    function ShowMorningMouthfull()
    {
        _root.UseGeneric = true;
        return (false);
    } // End of the function
    function GetCurrentSexActLevel(type)
    {
        return (_root.GetCurrentSexActLevel(type));
    } // End of the function
    function HideSlaveActions()
    {
    } // End of the function
    function EventBuyer()
    {
        return (false);
    } // End of the function
    function EventRescue()
    {
        return (false);
    } // End of the function
    function OwnerTestSpecial()
    {
        return (false);
    } // End of the function
    function OwnerTest(tempstr, gain)
    {
        return (false);
    } // End of the function
    function ShowRetrieved()
    {
        return (false);
    } // End of the function
    function LesbianTrainingAccepted()
    {
    } // End of the function
    function LesbianTrainingRefused()
    {
        return (false);
    } // End of the function
    function EvilMineStart()
    {
    } // End of the function
    function ShowNakedApron()
    {
        return (false);
    } // End of the function
    function ShowRaped()
    {
        return (false);
    } // End of the function
    function DocksAreas(secure)
    {
    } // End of the function
    function BeachActivities()
    {
    } // End of the function
    function TakeAWalk(place)
    {
        return (false);
    } // End of the function
    function AfterWalk(place)
    {
    } // End of the function
    function DoWalkHouse(house)
    {
        return (false);
    } // End of the function
    function DoWalkBeachSwim(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkBeachWalk(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkBeachPrivate(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkBeachRocks(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkTownCenter(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkForest(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkLake(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkSlums(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkPalace(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkFarm(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkRuins(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkDocksPort(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkDocksSlavePens(NumEvent)
    {
        return (false);
    } // End of the function
    function DoWalkDocksSlavePensSecure(NumEvent)
    {
        return (false);
    } // End of the function
    function ShowTentacleSex(place)
    {
        return (false);
    } // End of the function
    function ShowTentacleHaremImage(image)
    {
    } // End of the function
    function ShowTentaclePregnancyBirth()
    {
        return (false);
    } // End of the function
    function ShowTentaclePregnancyReveal()
    {
        return (false);
    } // End of the function
    function SeePregnant()
    {
        return (false);
    } // End of the function
    function SupervisorTentacleSex()
    {
        return (false);
    } // End of the function
    function SupervisorRepelsTentacles()
    {
    } // End of the function
    function IsDickgirl()
    {
        return (false);
    } // End of the function
    function ShowDickgirlTransform()
    {
        return (false);
    } // End of the function
    function AfterDickgirlPotion(num)
    {
    } // End of the function
    function ShowDickgirlPermanent()
    {
        return (false);
    } // End of the function
    function DickgirlPotionOffer()
    {
    } // End of the function
    function StartCatgirlTraining()
    {
        return (false);
    } // End of the function
    function FinishedCatgirlTraining()
    {
        return (false);
    } // End of the function
    function EndingCatgirl()
    {
    } // End of the function
    function ShowRefuseCatgirl(type)
    {
    } // End of the function
    function ShowFaerieTransformation()
    {
        return (false);
    } // End of the function
    function EndingFaerie()
    {
    } // End of the function
    function ShowMilkFall()
    {
        return (false);
    } // End of the function
    function ShowMilkAccident()
    {
    } // End of the function
    function ShowMilking()
    {
    } // End of the function
    function ShowMilkEnd()
    {
        return (false);
    } // End of the function
    function ShowTrainingComplete()
    {
        return (false);
    } // End of the function
    function GetEndingTotal()
    {
        return (0);
    } // End of the function
    function ShowEndingTentacleSlave()
    {
    } // End of the function
    function ShowEndingLesbianSlave()
    {
    } // End of the function
    function ShowEndingHeterosexualSlave()
    {
    } // End of the function
    function ShowEndingPonygirl()
    {
        return (false);
    } // End of the function
    function ShowEndingCourtesan()
    {
    } // End of the function
    function ShowEndingCatgirl()
    {
    } // End of the function
    function ShowEndingDickgirl()
    {
    } // End of the function
    function ShowEndingSM()
    {
    } // End of the function
    function ShowEndingDrugAddict()
    {
    } // End of the function
    function ShowEndingRich()
    {
    } // End of the function
    function ShowEndingMarriage()
    {
    } // End of the function
    function ShowEndingSexManiac()
    {
    } // End of the function
    function ShowEndingSexAddict()
    {
    } // End of the function
    function ShowEndingRebel()
    {
    } // End of the function
    function ShowEndingNormalPlus()
    {
    } // End of the function
    function ShowEndingNormal()
    {
    } // End of the function
    function ShowEndingNormalMinus()
    {
    } // End of the function
    function ShowEndingProstitute()
    {
    } // End of the function
    function ShowEndingMaid()
    {
    } // End of the function
    function ShowEndingCowgirl()
    {
    } // End of the function
    function ShowEndingBoughtBack()
    {
    } // End of the function
    function ShowEndingLove()
    {
    } // End of the function
    function EndingStart(total)
    {
        return (false);
    } // End of the function
    function EndingFinish(total)
    {
        return (false);
    } // End of the function
    function NumCustomEndings()
    {
        return (0);
    } // End of the function
    function ShowEndings(num)
    {
    } // End of the function
    function HideEndings()
    {
    } // End of the function
    function AskBoughtBackQuestion()
    {
    } // End of the function
    function DoArmourer()
    {
    } // End of the function
    function DoShop()
    {
    } // End of the function
    function DoTailor()
    {
    } // End of the function
    function DoSalon()
    {
    } // End of the function
    function DoStables()
    {
    } // End of the function
    function ShowLoveConfession()
    {
    } // End of the function
    function ShowLoveAccepted()
    {
        return (false);
    } // End of the function
    function ShowLoveRefused()
    {
    } // End of the function
    function ShowPropositionAccepted()
    {
    } // End of the function
    function ShowPropositionRefused()
    {
    } // End of the function
    function OldLoverStartDating()
    {
    } // End of the function
    function OldLoverDating()
    {
    } // End of the function
    function ShowDating()
    {
    } // End of the function
    function ShowNobleLoveAccepted()
    {
    } // End of the function
    function ShowNobleLoveRefused()
    {
    } // End of the function
    function NobleLove(allowoffer)
    {
    } // End of the function
    function HideItem(item, align)
    {
        return (false);
    } // End of the function
    function ShowItem(item, main, align, gframe)
    {
        return (false);
    } // End of the function
    function HideItems()
    {
    } // End of the function
    function EquipItem(item)
    {
        return (false);
    } // End of the function
    function WearItem(item)
    {
        return (true);
    } // End of the function
    function UnEquipItem(item)
    {
        return (false);
    } // End of the function
    function RemoveItem(item)
    {
        return (true);
    } // End of the function
    function ShowItemDescription(item)
    {
        return (false);
    } // End of the function
    function DrinkPotion(potion, price, say)
    {
        return (false);
    } // End of the function
    function RemoveDress()
    {
    } // End of the function
    function WearDress()
    {
    } // End of the function
    function ShowNaked()
    {
    } // End of the function
    function ShowDress()
    {
    } // End of the function
    function ShowNakedSmall()
    {
    } // End of the function
    function ShowDressSmall()
    {
    } // End of the function
    function HideDresses()
    {
    } // End of the function
    function HideRobes()
    {
        this.HideDresses();
    } // End of the function
    function ShowOtherEquipment()
    {
    } // End of the function
    function PurchaseItem(item, hint)
    {
        return (false);
    } // End of the function
    function DoTailorYes(dress)
    {
        return (false);
    } // End of the function
    function PurchaseDrug(dnum, hint)
    {
        return (false);
    } // End of the function
    function ShowBunnySuit()
    {
        return (false);
    } // End of the function
    function ShowLingerie()
    {
        return (false);
    } // End of the function
    function ShowMaidUniform()
    {
        return (false);
    } // End of the function
    function ShowSwimsuit()
    {
        return (false);
    } // End of the function
    function BuyDress(cost)
    {
        return (-1);
    } // End of the function
    function BuyUniform(cost)
    {
        return (-1);
    } // End of the function
    function PurchaseDress(dress, owned, dname, desc, price, hint)
    {
        return (false);
    } // End of the function
    function MeetNun(Description, choice)
    {
        return (false);
    } // End of the function
    function AfterMeetNun(Description, choice)
    {
    } // End of the function
    function MeetSleazyBarOwner(choice)
    {
        return (false);
    } // End of the function
    function AfterMeetSleazyBarOwner(choice)
    {
    } // End of the function
    function AfterMeetBountyHunter(place, meet)
    {
    } // End of the function
    function AfterMeetMeetOddTeacher(place, meet)
    {
    } // End of the function
    function MeetXXXSchoolOwner(choice)
    {
        return (false);
    } // End of the function
    function AfterMeetXXXSchoolOwner(choice)
    {
    } // End of the function
    function MeetAstrid()
    {
        return (false);
    } // End of the function
    function MeetPuppyGirl()
    {
        return (false);
    } // End of the function
    function AfterMeetPuppyGirl()
    {
    } // End of the function
    function MeetIdol()
    {
        return (false);
    } // End of the function
    function AfterMeetIdol()
    {
    } // End of the function
    function MeetSchoolGirl()
    {
        return (false);
    } // End of the function
    function AfterMeetSchoolGirl()
    {
    } // End of the function
    function VisitAstrid()
    {
        return (false);
    } // End of the function
    function MeetRefinementSchoolTeacher()
    {
        return (false);
    } // End of the function
    function MeetSwimInstructor()
    {
        return (false);
    } // End of the function
    function AfterMeetSwimInstructor()
    {
    } // End of the function
    function DoVisitSelect()
    {
    } // End of the function
    function DoVisit(person)
    {
        return (false);
    } // End of the function
    function VisitChatWithPerson(person)
    {
    } // End of the function
    function DoVisitShop()
    {
        return (false);
    } // End of the function
    function DoVisitBarmaid()
    {
        return (false);
    } // End of the function
    function DoVisitProstitute()
    {
        return (false);
    } // End of the function
    function DoVisitHighClassProstitute()
    {
        return (false);
    } // End of the function
    function DoVisitKnight()
    {
        return (false);
    } // End of the function
    function DoVisitCount()
    {
        return (false);
    } // End of the function
    function DoVisitLord()
    {
        return (false);
    } // End of the function
    function DoVisitMaid()
    {
        return (false);
    } // End of the function
    function DoVisitLadyFarun()
    {
        return (false);
    } // End of the function
    function DoVisitCuteLesbian()
    {
        return (false);
    } // End of the function
    function DoVisitPonyMistress()
    {
        return (false);
    } // End of the function
    function VisitSeer()
    {
        return (false);
    } // End of the function
    function DoVisitBountyHunter()
    {
        return (false);
    } // End of the function
    function DoVisitCustomPerson()
    {
        return (false);
    } // End of the function
    function HighClassPartyOffer(days)
    {
        return (false);
    } // End of the function
    function HighClassPartyCheck()
    {
        return (false);
    } // End of the function
    function ProstitutePartyOffer(days)
    {
        return (false);
    } // End of the function
    function DoLendSelect()
    {
    } // End of the function
    function DoLendHer(person)
    {
        return (false);
    } // End of the function
    function DoLendHerOffer(person)
    {
        return (false);
    } // End of the function
    function ShowActLendHer()
    {
    } // End of the function
    function ShowSexActLendHer()
    {
        this.ShowActLendHer();
    } // End of the function
    function DoLendShop()
    {
        return (false);
    } // End of the function
    function DoLendBarmaid()
    {
        return (false);
    } // End of the function
    function DoLendProstitute()
    {
        return (false);
    } // End of the function
    function DoLendHighClassProstitute()
    {
        return (false);
    } // End of the function
    function DoLendKnight()
    {
        return (false);
    } // End of the function
    function DoLendCount()
    {
        return (false);
    } // End of the function
    function DoLendLord()
    {
        return (false);
    } // End of the function
    function DoLendMaid()
    {
        return (false);
    } // End of the function
    function DoLendLadyFarun()
    {
        return (false);
    } // End of the function
    function DoLendBountyHunter()
    {
        return (false);
    } // End of the function
    function DoLendPonyMistress()
    {
        return (false);
    } // End of the function
    function DoLendCuteLesbian()
    {
        return (false);
    } // End of the function
    function DoLendCustomPerson()
    {
    } // End of the function
    function ShowSlaveSex1()
    {
    } // End of the function
    function ShowSlaveSex2()
    {
    } // End of the function
    function ShowSlaveChore1()
    {
    } // End of the function
    function ShowSlaveChore2()
    {
    } // End of the function
    function ShowSlaveChore3()
    {
    } // End of the function
    function ShowSlaveJob1()
    {
    } // End of the function
    function RunShop()
    {
        this.ShowSlaveJob1();
    } // End of the function
    function ShowSlaveJob2()
    {
    } // End of the function
    function ShowSlaveJob3()
    {
    } // End of the function
    function ShowSlaveSchool1()
    {
    } // End of the function
    function ShowSlaveSchool2()
    {
    } // End of the function
    function ShowSlaveSchool3()
    {
    } // End of the function
    function ShowSexActNakedStart()
    {
    } // End of the function
    function ShowActNakedStart()
    {
    } // End of the function
    function ShowSexActNaked()
    {
    } // End of the function
    function ShowActNaked()
    {
    } // End of the function
    function ShowActPlug()
    {
    } // End of the function
    function ShowSexActPlug()
    {
    } // End of the function
    function DoOrdinaryDiscussion()
    {
        return (false);
    } // End of the function
    function DoCongratulate()
    {
        return (false);
    } // End of the function
    function DoScold()
    {
        return (false);
    } // End of the function
    function DoLaterDiscussion()
    {
        return (false);
    } // End of the function
    function ShowContestBeauty(score)
    {
        return (score);
    } // End of the function
    function ShowContestXXX(score)
    {
        return (score);
    } // End of the function
    function ShowContestPonygirl(score)
    {
        return (score);
    } // End of the function
    function ShowContestDance(score)
    {
        return (score);
    } // End of the function
    function ShowContestGeneralKnowledge(score)
    {
        return (score);
    } // End of the function
    function ShowContestCourt(score)
    {
        return (score);
    } // End of the function
    function ShowContestHousework(score)
    {
        return (score);
    } // End of the function
    function StartContest(numcontest)
    {
        return (false);
    } // End of the function
    function DoContestsNext(numcontest)
    {
        return (false);
    } // End of the function
    function StartSlaveMaker()
    {
    } // End of the function
    function HearGossip(person, slut, newg)
    {
        return (false);
    } // End of the function
    function HideImages()
    {
        this.HideAsAssistant();
    } // End of the function
    function HidePeople()
    {
    } // End of the function
    function ShowTired(cum)
    {
    } // End of the function
    function ShowBreak(sleep)
    {
    } // End of the function
    function ShowChoreCooking()
    {
    } // End of the function
    function ShowChoreCleaning()
    {
    } // End of the function
    function ShowChoreDiscuss()
    {
    } // End of the function
    function ShowChoreExpose()
    {
    } // End of the function
    function ShowChoreMakeUp()
    {
    } // End of the function
    function ShowChoreExercise()
    {
    } // End of the function
    function ShowChoreWalk()
    {
        this.ShowChoreExercise();
    } // End of the function
    function ShowChoreReadABook()
    {
        return (false);
    } // End of the function
    function ShowJobAcolyte(plugged)
    {
        return (1);
    } // End of the function
    function AfterJobAcolyte(pay)
    {
    } // End of the function
    function ShowJobBar()
    {
        return (1);
    } // End of the function
    function AfterJobBar(pay)
    {
    } // End of the function
    function ShowJobBrothel()
    {
        return (1);
    } // End of the function
    function AfterJobBrothel(pay)
    {
    } // End of the function
    function ShowJobCockMilking()
    {
        return (1);
    } // End of the function
    function AfterJobCockMilking(pay)
    {
    } // End of the function
    function ShowJobLibrary()
    {
        return (1);
    } // End of the function
    function AfterJobLibrary(pay)
    {
    } // End of the function
    function ShowJobOnsen(washgender)
    {
        return (1);
    } // End of the function
    function AfterJobOnsen(pay, eventno)
    {
        return (false);
    } // End of the function
    function ShowJobOnsenService(cgender)
    {
        return (false);
    } // End of the function
    function ShowJobRestaurant()
    {
        return (1);
    } // End of the function
    function AfterJobRestaurant(pay)
    {
    } // End of the function
    function AskSleazyBarStripTease()
    {
        return (false);
    } // End of the function
    function ShowJobSleazyBar(strip)
    {
        return (1);
    } // End of the function
    function AfterJobSleazyBar(pay)
    {
        return (false);
    } // End of the function
    function ShowJobSleazyBarService(female)
    {
        return (false);
    } // End of the function
    function ShowSchoolSciences()
    {
    } // End of the function
    function AfterSchoolSciences()
    {
    } // End of the function
    function ShowSchoolSinging()
    {
        return (false);
    } // End of the function
    function AfterSchoolSinging()
    {
    } // End of the function
    function ShowSchoolTheology()
    {
    } // End of the function
    function AfterSchoolTheology()
    {
    } // End of the function
    function ShowSchoolRefinement()
    {
    } // End of the function
    function AfterSchoolRefinement()
    {
    } // End of the function
    function ShowSchoolDance()
    {
    } // End of the function
    function AfterSchoolDance()
    {
    } // End of the function
    function ShowSchoolXXX(dg)
    {
        return (false);
    } // End of the function
    function AfterSchoolXXX()
    {
    } // End of the function
    function ShowSexActBlowjob()
    {
    } // End of the function
    function ShowSexActNothing()
    {
    } // End of the function
    function ShowSexActFuck()
    {
    } // End of the function
    function ShowSexActBondage()
    {
    } // End of the function
    function ShowSexActTouch()
    {
    } // End of the function
    function ShowSexActLick()
    {
    } // End of the function
    function ShowSexActAnal()
    {
    } // End of the function
    function ShowSexActGangBang()
    {
    } // End of the function
    function ShowSexActLesbian()
    {
    } // End of the function
    function ShowSexAct69()
    {
    } // End of the function
    function ShowSexActDildo()
    {
    } // End of the function
    function ShowSexActGroup()
    {
    } // End of the function
    function ShowSexActMasturbate()
    {
    } // End of the function
    function ShowSexActMaster()
    {
    } // End of the function
    function ShowSexActPonygirl()
    {
    } // End of the function
    function ShowSexActCumBath()
    {
        return (false);
    } // End of the function
    function ShowSexActKiss()
    {
        return (false);
    } // End of the function
    function ShowSexActSpank(whip)
    {
    } // End of the function
    function SpankComment()
    {
        return (false);
    } // End of the function
    function ShowSexActStripTease()
    {
        return (false);
    } // End of the function
    function ShowSexActThreesome()
    {
        return ("");
    } // End of the function
    function ShowSexActTitFuck()
    {
    } // End of the function
    function AttachMovie(movie)
    {
        var _loc3 = BaseMovie.attachMovie(movie, "LoadedMovie" + _root.loadednum, BaseMovie.getNextHighestDepth());
        _loc3.enabled = false;
        _loc3._visible = false;
        ++_root.loadednum;
        return (_loc3);
    } // End of the function
    function AttachAndShowMovie(mc, image, main, align, gframe)
    {
        if (mc == undefined)
        {
            mc = this.AttachMovie(image);
        } // end if
        _root.ShowMovie(mc, main, align, gframe);
        return (mc);
    } // End of the function
    function AutoAttachMovie(movie)
    {
        var _loc2 = this.AttachMovie(movie);
        LoadedMovieArray.push(_loc2);
        return (_loc2);
    } // End of the function
    function AutoAttachAndShowMovie(movie, main, align, gframe)
    {
        var _loc4 = false;
        var _loc5 = this.AutoAttachMovie(movie);
        if (Assisting)
        {
            if (align >= 0 && main == 0)
            {
                align = align * -1;
                if (align == 0)
                {
                    align = -100;
                } // end if
                _loc4 = true;
            } // end if
        } // end if
        _root.ShowMovie(_loc5, main, align, gframe);
        if (_loc4)
        {
            _root.lastmc._visible = true;
        } // end if
        return (_loc5);
    } // End of the function
    function LoadImage(image, movie)
    {
        return (_root.LoadImageAndShowMovie(image, movie, undefined, undefined, BaseMovie));
    } // End of the function
    function slrandom(rnd)
    {
        return (Math.floor(Math.random() * rnd) + 1);
    } // End of the function
    function AddTextToStart(pstring)
    {
        _root.AddTextToStart(pstring);
    } // End of the function
    function AddTextToStartGeneral(pstring)
    {
        _root.AddTextToStartGeneral(pstring);
    } // End of the function
    function SetText(nstring)
    {
        _root.SetText(nstring);
    } // End of the function
    function SetGeneralText(nstring)
    {
        _root.SetGeneralText(nstring);
    } // End of the function
    function AddText(nstring)
    {
        _root.AddText(nstring);
    } // End of the function
    function PersonSpeakStart(person, say, newl)
    {
        _root.PersonSpeakStart(person, say, newl);
    } // End of the function
    function PersonSpeakEnd(say)
    {
        _root.PersonSpeakEnd(say);
    } // End of the function
    function PersonSpeak(person, say, newl)
    {
        _root.PersonSpeak(person, say, newl);
    } // End of the function
    function SlaveSpeakStart(say, newl)
    {
        _root.SlaveSpeakStart(say, newl);
    } // End of the function
    function SlaveSpeakEnd(say)
    {
        _root.SlaveSpeakEnd(say);
    } // End of the function
    function SlaveSpeak(say, newl)
    {
        _root.SlaveSpeak(say, newl);
    } // End of the function
    function ServantSpeak(say, newl)
    {
        _root.ServantSpeak(say, newl);
    } // End of the function
    function ServantSpeakStart(say, newl)
    {
        _root.ServantSpeakStart(say, newl);
    } // End of the function
    function BlankLine()
    {
        _root.AddText("\r\r");
    } // End of the function
    function CheckBitFlag1(flag)
    {
        return (_root.CheckBitFlag1(flag));
    } // End of the function
    function SetBitFlag1(flag)
    {
        _root.SetBitFlag1(flag);
    } // End of the function
    function ClearBitFlag1(flag)
    {
        _root.ClearBitFlag1(flag);
    } // End of the function
    function CheckAndSetBitFlag1(flag)
    {
        return (_root.CheckAndSetBitFlag1(flag));
    } // End of the function
    function CheckBitFlag2(flag)
    {
        return (_root.CheckBitFlag2(flag));
    } // End of the function
    function SetBitFlag2(flag)
    {
        _root.SetBitFlag2(flag);
    } // End of the function
    function ClearBitFlag2(flag)
    {
        _root.ClearBitFlag2(flag);
    } // End of the function
    function CheckAndSetBitFlag2(flag)
    {
        return (_root.CheckAndSetBitFlag2(flag));
    } // End of the function
    function DoEvent(enum)
    {
        _root.DoEvent(enum);
    } // End of the function
    function DoYesNoEvent(enum)
    {
        _root.DoYesNoEvent(enum);
    } // End of the function
    function DoYesNoEventXY(enum)
    {
        _root.DoYesNoEventXY(enum);
    } // End of the function
    function AskHerQuestions(Event1, Event2, Event3, Event4, Event1Label, Event2Label, Event3Label, Event4Label, Caption, Event5, Event5Label)
    {
        _root.AskHerQuestions(Event1, Event2, Event3, Event4, Event1Label, Event2Label, Event3Label, Event4Label, Caption, Event5, Event5Label);
    } // End of the function
} // End of Class
