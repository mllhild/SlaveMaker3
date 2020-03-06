function ShowStatHint(stat)
{
   if(stat == 18)
   {
      _root.SetHintText("<b>Nymph Magic:</b> Her power to spread lust and fertility.\r\rShe <b>");
      if(_root.VarSpecialRounded < 25)
      {
         _root.AddHintText("has some power");
      }
      else if(_root.VarSpecialRounded < 50)
      {
         _root.AddHintText("is powerful");
      }
      else if(_root.VarSpecialRounded < 75)
      {
         _root.AddHintText("is very powerful");
      }
      else
      {
         _root.AddHintText("is enormously powerful");
      }
      _root.ShowHintAdd("</b>\nwhich is " + _root.VarSpecialRounded + " in a range of 0 to 100.");
      return true;
   }
   return false;
}
function ShowOtherEquipment()
{
   _root.AddText("Aeris\' Inventory:\r");
   if(_root.CheckBitFlag2(8))
   {
      _root.AddText("  A Large Used Vibrator\r\r");
   }
   if(_root.CheckBitFlag2(14))
   {
      _root.AddText("  An Addiction Draft\r\r");
   }
   if(_root.CheckBitFlag2(15))
   {
      _root.AddText("  Bottled Monster Musk\r\r");
   }
   if(_root.CheckBitFlag2(12))
   {
      _root.AddText("  A Milking Machine\r\r");
   }
   if(_root.CheckBitFlag2(13))
   {
      _root.AddText("  A Cock-Milking Machine\r\r");
   }
   if(_root.CustomFlag4 == 1)
   {
      _root.AddText("  1 Milk Bottle\r\r");
   }
   if(_root.CustomFlag4 > 1)
   {
      _root.AddText("  " + _root.CustomFlag4 + " Milk Bottles\r\r");
   }
   if(_root.CustomFlag2 == 1)
   {
      _root.AddText("  1 Bottle of Cum\r\r");
   }
   if(_root.CustomFlag2 > 1)
   {
      _root.AddText("  " + _root.CustomFlag2 + " Bottles of Cum\r\r");
   }
}
function StartDay()
{
   if(_root.CheckBitFlag2(16))
   {
      temp = int(Math.random() * 4);
      if(temp == 2)
      {
         temp = 4;
      }
      if(temp == 3)
      {
         temp = 6.1;
      }
      if(temp != 0)
      {
         _root.TentacleHaunt = temp;
      }
   }
}
function UpdateDateAndItems(NumDays)
{
   _root.VarTemperament = _root.VarTemperament + NumDays / 4;
   _root.VarObedience = _root.VarObedience - 0.25;
   if(_root.CheckBitFlag2(0))
   {
      if(_root.IsDickgirl())
      {
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1);
      }
      _root.ShowSpecialStat("Nymph Magic :");
      if(_root.CheckBitFlag2(38) && _root.SMLust < 15)
      {
         _root.SMLust = 14;
      }
      if(_root.CheckBitFlag2(39) && _root.SMLust < 45)
      {
         _root.SMLust = 44;
      }
      if(_root.CheckBitFlag2(40) && _root.SMLust < 70)
      {
         _root.SMLust = 69;
      }
      _root.SMPoints(0,0,0,0,0,1,0,0);
   }
   _root.ClearBitFlag2(29);
   if(_root.CustomFlag4 > 0)
   {
      _root.ShowCustomSexAct(1);
   }
   if(_root.CheckBitFlag2(12) || _root.CheckBitFlag2(13))
   {
      _root.ShowCustomSexAct(2);
   }
}
function UpdateSlave()
{
   if(_root.CustomFlag5 == -1)
   {
      _root.CustomFlag5 = 0;
   }
   if(_root.CustomFlag6 == -1)
   {
      _root.CustomFlag6 = 0;
   }
   if(_root.vitalsBust > 90 + _root.CustomFlag)
   {
      temp = _root.vitalsBust - (90 + _root.CustomFlag);
      if(temp + _root.CustomFlag >= 13 && _root.Lactation < 30)
      {
         _root.Lactation = 30;
      }
      else
      {
         _root.Lactation = _root.Lactation + (temp < 2?1:2);
      }
      _root.CustomFlag = _root.vitalsBust - 90;
      if(_root.CustomFlag > 30)
      {
         _root.CustomFlag = 30;
      }
      if(_root.CustomFlag > _root.VarSpecialRounded / 4)
      {
         _root.CustomFlag = _root.VarSpecialRounded / 4;
      }
   }
   if(_root.IsDickgirl() && _root.ClitCockSize * 10 > 6 + _root.CustomFlag3 / 2)
   {
      _root.CustomFlag3 = (_root.ClitCockSize * 10 - 6) * 2;
      if(_root.CustomFlag3 > 25)
      {
         _root.CustomFlag3 = 25;
      }
      if(_root.CustomFlag3 > _root.VarSpecialRounded / 4)
      {
         _root.CustomFlag3 = _root.VarSpecialRounded / 4;
      }
   }
   if(_root.vitalsBust < int(_root.CustomFlag) + 90)
   {
      _root.vitalsBust = int(_root.CustomFlag) + 90;
   }
   _root.vitalsBustCurrent = _root.vitalsBust;
   if(_root.ClitCockSize * 10 < _root.CustomFlag3 / 2 + 6)
   {
      _root.ClitCockSize = int(_root.CustomFlag3 / 2 + 6) / 10;
      _root.AltStatisticsGroup.ClitCock.htmlText = (!_root.HasCock?Math.ceil(_root.ClitCockSize * 10) / 10:Math.round(_root.ClitCockSize * 33)) + _root.GetLanguageStringByNode("Centimeters",_root.statNode);
   }
}
function ApplyDifficulty(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Love, Special)
{
   _root.MoralityFactor = _root.MoralityFactor * 1.2;
   _root.NymphomaniaFactor = _root.NymphomaniaFactor * 1.2;
}
function DrinkPotion(potion, price, pname, say)
{
   if(potion == 0)
   {
      switch(int(Math.random() * 3))
      {
         case 0:
            _root.SetText("#slave drops to the ground and irresistibly masturbates over and over, cumming all over even into her own mouth.");
            _root.AddText("\r\rAfter a time Astrid joins and they fuck each other.");
            _root.ShowMovie(ClipDickgirl,1,1,1);
            break;
         case 1:
            _root.SetText("#slave feels an incredible desire to fuck and be fucked. Astrid smiles and suggests she steps into store-room.\r\r#slave opens the door and Astrid passionately embraces her from behind. #slave can feel Astrid\'s hard cock pressing into her back and then gasps as Astrid grasps #slave\'s cock, stroking it as she kisses #slave\'s neck. Astrid disrobes as she kisses and touches #slave. They lie down and Astrid easily pushes her large cock into #slave\'s pussy and urgently fucks her.");
            _root.ShowMovie(ClipDickgirl,1,1,2);
            break;
         case 2:
            _root.SetText("#slave compulsively sucks on her own huge cock, cumming over and over again, swallowing all of her cum.");
            _root.AddText("\r\rAfter a time Astrid joins and they fuck each other.");
            _root.ShowMovie(ClipDickgirl,1,1,3);
            break;
      }
      if(_root.CheckBitFlag2(0))
      {
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4);
      }
      _root.Points(0,2,0,0,0,0,0,0,0,2,2,0,2,0,0,0,4,0,0,0);
      return true;
   }
   return false;
}
function ShowTrainingComplete()
{
   return false;
}
function ShowAsAssistant(type)
{
   if(type == 4)
   {
      return false;
   }
   switch(type)
   {
      case 1:
         _root.ShowMovie(this.EndingBoughtBack,0,2);
         break;
      case 2:
         _root.ShowMovie(this.ClipTentacle,0,2,4);
         _root.AssistantBackground._visible = true;
         break;
      case 3:
         _root.ShowMovie(this.ClipRaped,0,1,1);
         break;
      case 5:
         _root.ShowMovie(this.PromenadeClip,0,1,2);
         break;
      case 6:
         _root.ShowMovie(ClipLoveRefused,0,1,1);
         break;
   }
   return true;
}
function ShowAsAssistantTentacleSex()
{
   ShowTentacleSex();
   _root.ShowMovie(this.ClipTentacle,1,1);
   return true;
}
function ShowAsAssistantAnal()
{
   _root.ShowMovie(this.AnalClip,1,1,int(Math.random() * 2) + 1);
   return true;
}
function ShowAsAssistantSpanking()
{
   SpankClip.gotoAndStop(3);
   SpankClip._visible = true;
   return true;
}
function HideAsAssistant()
{
   EndingBoughtBack._visible = false;
   ClipLoveRefused._visible = false;
   ClipRaped._visible = false;
   PromenadeClip._visible = false;
   ClipTentacle._visible = false;
   PromenadeClip._visible = false;
   AnalClip._visible = false;
   SpankClip._visible = false;
}
function InitialiseAsAssistant()
{
   HideImages();
   HideSlaveActions();
   HideEndings();
   HideDresses();
   _root.AssistantDescription = "An orphan, strangely blessed by light and dark.\r\rMorality and Nymphomania +3 per day.";
   if(_root.AssistantData.CheckBitFlag2(0))
   {
      _root.AssistantDescription = _root.AssistantDescription + "  Aeris also has special powers.";
   }
   if(_root.AssistantData.CustomFlag6 > 0)
   {
      _root.AssistantTentaclesNeeded = true;
   }
   return this.ClipContestsBeauty;
}
function EmployAsAssistant()
{
   _root.VarMorality = _root.VarMorality + 3;
   _root.VarNymphomania = _root.VarNymphomania + 3;
   if(_root.SlaveGender != 1 && _root.SlaveGender != 4 && (_root.AssistantData.CheckBitFlag2(12) || _root.AssistantData.CheckBitFlag2(13)))
   {
      _root.SetCustomSexAct(4,"Milk Her","Aeris will milk her with her special equipment");
      _root.ShowCustomSexAct(4);
      _root.AssistantData.ClearBitFlag2(55);
   }
}
function ApplyDifficultyAsAssistant(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Lust, Fatigue, Joy, Love, Special)
{
   _root.MoralityFactor = _root.MoralityFactor * 1.2;
   _root.NymphomaniaFactor = _root.NymphomaniaFactor * 1.2;
}
function IntroductionAsAssistant()
{
   return false;
}
function ShowContestBeauty(total)
{
   _root.HideBackgrounds();
   _root.ShowMovie(ClipContestsBeauty,1,1,!_root.IsDickgirl()?1:2);
   return total;
}
function ShowContestCourt(total)
{
   _root.ShowMovie(ClipContestsCourt,1,1,_root.slrandom(2));
   return total;
}
function ShowContestHousework(total)
{
   _root.HideBackgrounds();
   _root.ShowMovie(ClipContestsHousework,1,1,1);
   return total;
}
function ShowContestPonygirl(total)
{
   ShowSexActPonygirl();
   return total;
}
function ShowContestXXX(total)
{
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(ClipContestsXXX,1,1,2);
   }
   else
   {
      _root.ShowMovie(ClipContestsXXX,1,1,1);
   }
   return total;
}
function IsDickgirl()
{
   return false;
}
function DickgirlPotionOffer()
{
   _root.AddText(" looks unsure.");
   if(_root.PotionsUsed[0] == 0)
   {
      _root.AddText("\r\r");
      _root.SlaveSpeak("Do you think I should try this?");
   }
   else if(_root.PotionsUsed[0] == 1)
   {
      _root.AddText("\r\r");
      _root.SlaveSpeak("I\'m not sure I can trust myself to hold back if I drink this again.",true);
      if(_root.Supervise)
      {
         _root.AddText("\r\r#slave looks to you to decide, not noticing your lustful looks.");
      }
      else
      {
         _root.AddText("\r\r#slave looks to #assistant to decide, not noticing #assistant\'s lustful look.");
      }
   }
   else if(_root.PotionsUsed[0] == 2)
   {
      _root.AddText("  Her nipples become noticeably erect at the mention of the potion.\r\r");
      _root.SlaveSpeak("Yes, please! I want it again!",true);
      if(_root.Supervise)
      {
         if(_root.Gender == 2)
         {
            _root.AddText("\r\rYou agree, with your own nipples stiffening.");
         }
         else
         {
            _root.AddText("\r\rYou agree, with your cock quickly stiffening.");
         }
      }
      else if(_root.ServantWoman)
      {
         _root.AddText("\r\r#assistant nods, with her own nipples stiffening.");
      }
      else
      {
         _root.AddText("\r\r#assistant nods, with #assistanthisher cock stiffening.");
      }
   }
}
function ShowDickgirlTransform()
{
   _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5);
   return false;
}
function ShowDickgirlPermanent()
{
   _root.ShowMovie(ClipDickgirl,1,1,3);
   return true;
}
function AfterDickgirlPotion(num)
{
   if(_root.PotionsUsed[0] == 1)
   {
      _root.AddText("#slave looks somewhat drained but happy.\r\r");
      _root.SlaveSpeak("I don\'t think that was very proper of me, but I wouldn\'t mind doing it again.",true);
      if(_root.Supervise)
      {
         _root.AddText("\r\rYou nod understandingly. As #slave turns to leave you feel an increasing feeling of lust.");
      }
      else
      {
         _root.AddText("\r\r#assistant nods understandingly. As #slave turns to leave #assistanthimher look turns from understanding to something close to lust.");
      }
   }
   if(_root.PotionsUsed[0] == 2)
   {
      _root.AddText("#slave touches her crotch to make sure the dick is gone and immediately flushes with arousal. She suddenly tears her hands away and smiles sheepishly.  ");
      if(_root.Supervise)
      {
         _root.AddText("You lead #slave back home, but you have a difficult time not undressing #slave with your eyes.");
      }
      else
      {
         _root.AddText("#assistant leads #slave back home, but has a difficult time not undressing #slave with #assistanthisher eyes.");
      }
   }
}
function PositionDemonWingLeft(xpos, ypos, rot, wid, hei)
{
   if(_root.CheckBitFlag2(44))
   {
      DemonWingLeft._visible = true;
      _root.PositionMovieSimple(DemonWingLeft,xpos,ypos,rot,wid,hei);
   }
}
function PositionDemonWingRight(xpos, ypos, rot, wid, hei)
{
   if(_root.CheckBitFlag2(44))
   {
      DemonWingRight._visible = true;
      _root.PositionMovieSimple(DemonWingRight,xpos,ypos,rot,wid,hei);
   }
}
function PositionDemonHornLeft(xpos, ypos, rot, wid, hei)
{
   if(_root.CheckBitFlag2(44))
   {
      DemonHornLeft._visible = true;
      _root.PositionMovieSimple(DemonHornLeft,xpos,ypos,rot,wid,hei);
   }
}
function PositionDemonHornRight(xpos, ypos, rot, wid, hei)
{
   if(_root.CheckBitFlag2(44))
   {
      DemonHornRight._visible = true;
      _root.PositionMovieSimple(DemonHornRight,xpos,ypos,rot,wid,hei);
   }
}
function ShowNaked()
{
   if(_root.NakedChoice == 0)
   {
      _root.NakedChoice = 1 + bcsize * 16;
      if(_root.IsDickgirl())
      {
         _root.NakedChoice = _root.NakedChoice + 8;
      }
      if(_root.PiercingsType == 1)
      {
         if(_root.NippleChainWorn == 1)
         {
            _root.NakedChoice = _root.NakedChoice + 3;
         }
         else
         {
            _root.NakedChoice = _root.NakedChoice + 1;
         }
      }
      else if(_root.PiercingsType == 2)
      {
         if(_root.NippleChainWorn == 1)
         {
            _root.NakedChoice = _root.NakedChoice + 7;
         }
         else
         {
            _root.NakedChoice = _root.NakedChoice + 5;
         }
      }
   }
   var _loc6_ = 0;
   var _loc7_ = int((_root.NakedChoice - 1) / 16);
   if(_loc7_ == 1)
   {
      _loc6_ = 10;
   }
   if(_loc7_ == 2)
   {
      _loc6_ = 25;
   }
   if(_loc7_ == 3)
   {
      _loc6_ = 50;
   }
   var _loc5_ = _root.NakedChoice - _loc7_ * 16;
   var _loc3_ = "Naked";
   if(_loc5_ > 8)
   {
      _loc3_ = _loc3_ + " (As Dickgirl";
   }
   if(_loc6_ > 0)
   {
      if(_loc5_ > 8)
      {
         _loc3_ = _loc3_ + (" with Bigger Boobs " + _loc6_ + "%)");
      }
      else
      {
         _loc3_ = _loc3_ + (" (Bigger Boobs " + _loc6_ + "%)");
      }
   }
   else if(_loc5_ > 8)
   {
      _loc3_ = _loc3_ + ")";
   }
   if(_loc5_ > 8)
   {
      _loc5_ = _loc5_ - 8;
   }
   if(_loc5_ > 1 && _loc5_ < 5)
   {
      _loc3_ = _loc3_ + (" - Nipple Pierce " + (_loc5_ - 1));
   }
   else if(_loc5_ > 5)
   {
      _loc3_ = _loc3_ + (" - Full Pierce " + (_loc5_ - 5));
   }
   else if(_loc5_ == 5)
   {
      _loc3_ = _loc3_ + " - Clamp";
   }
   _loc3_ = _loc3_ + ".png";
   var _loc4_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < NakedImages.length)
   {
      if(NakedImages[_loc2_] == _loc3_)
      {
         _loc4_ = NakedImages[_loc2_ + 1];
         break;
      }
      _loc2_ = _loc2_ + 2;
   }
   if(_loc4_ == undefined)
   {
      var _loc8_ = flash.display.BitmapData.loadBitmap(_loc3_);
      _loc4_ = _root.SlaveGirl.createEmptyMovieClip("LoadedMovie" + _root.loadednum,_root.SlaveGirl.getNextHighestDepth());
      _root.loadednum = _root.loadednum + 1;
      _loc4_.attachBitmap(_loc8_,_loc4_.getNextHighestDepth());
      NakedImages.push(_loc3_);
      NakedImages.push(_loc4_);
   }
   _root.ShowMovie(_loc4_,1,1);
   _root.PositionHalo(240,7,-10,200,54);
   _root.PositionLeash(4,351,100,10,280,100,true);
   _root.PositionGag(4,261,75,-30,80,50,true);
   PositionDemonHornLeft(157,-29,-2,110,140);
   PositionDemonHornRight(243,-29,-2,110,140);
   _root.PositionNymphsTiara(250,20,-10,70,70,true);
   _root.PositionCatEarsOver(1,237,50,-15,70,25);
   _root.PositionTail(180,275,-33,-160,110,true);
   if(_root.CheckBitFlag2(44))
   {
      PositionDemonWingLeft(-142,-33,-10,400,350);
      PositionDemonWingRight(310,-65,25,400,350);
   }
   else
   {
      _root.PositionWings(245,167,5,350,300);
   }
   _root.Backgrounds.ShowHousing();
}
function ShowNakedSmall()
{
   var _loc6_ = 0;
   var _loc7_ = int((_root.NakedChoice - 1) / 16);
   if(_loc7_ == 1)
   {
      _loc6_ = 10;
   }
   if(_loc7_ == 2)
   {
      _loc6_ = 25;
   }
   if(_loc7_ == 3)
   {
      _loc6_ = 50;
   }
   var _loc4_ = _root.NakedChoice - _loc7_ * 16;
   var _loc3_ = "Naked";
   if(_loc4_ > 8)
   {
      _loc3_ = _loc3_ + " (As Dickgirl";
   }
   if(_loc6_ > 0)
   {
      if(_loc4_ > 8)
      {
         _loc3_ = _loc3_ + (" with Bigger Boobs " + _loc6_ + "%)");
      }
      else
      {
         _loc3_ = _loc3_ + (" (Bigger Boobs " + _loc6_ + "%)");
      }
   }
   else if(_loc4_ > 8)
   {
      _loc3_ = _loc3_ + ")";
   }
   if(_loc4_ > 8)
   {
      _loc4_ = _loc4_ - 8;
   }
   if(_loc4_ > 1 && _loc4_ < 5)
   {
      _loc3_ = _loc3_ + (" - Nipple Pierce " + (_loc4_ - 1));
   }
   else if(_loc4_ > 5)
   {
      _loc3_ = _loc3_ + (" - Full Pierce " + (_loc4_ - 5));
   }
   else if(_loc4_ == 5)
   {
      _loc3_ = _loc3_ + " - Clamp";
   }
   _loc3_ = _loc3_ + ".png";
   var _loc5_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < NakedImages.length)
   {
      if(NakedImages[_loc2_] == _loc3_)
      {
         _loc5_ = NakedImages[_loc2_ + 1];
         break;
      }
      _loc2_ = _loc2_ + 2;
   }
   _root.ShowMovie(_loc5_,0,1,_root.NakedChoice);
}
function ShowDress()
{
   var _loc2_ = int(_root.vitalsBustCurrent + 0.9) / int(_root.vitalsBustStart);
   _root.DressLeash.gotoAndStop(2);
   if(_root.DressWorn == 0)
   {
      _root.PositionHalo(240,10,0,140,34);
      _root.PositionLeash(2,275,18,0,100,120,true);
      _root.PositionGag(4,236,42,17,-50,35,true);
      PositionDemonHornLeft(185,0,0,55,70);
      PositionDemonHornRight(228,0,0,55,70);
      _root.PositionNymphsTiara(245,10,0,60,60,true);
      _root.PositionTail(175,200,-20,-160,100,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(10,20,-10,200,175);
         PositionDemonWingRight(256,-10,10,200,175);
      }
      else
      {
         _root.PositionWings(225,120,5,300,205);
      }
      _root.PositionCatEars(1,238,17,0,55,24);
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
         RobePlainClip.Dickgirl._visible = _root.IsDickgirl();
      }
      _root.ShowMovie(RobePlainClip,1,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 1)
   {
      _root.PositionHalo(210,12,-5,300,50);
      _root.PositionLeash(2,275,98,0,100,180,true);
      _root.PositionGag(3,226,152,-10,140,48.1,true);
      PositionDemonHornLeft(103,8,-5,110,140);
      PositionDemonHornRight(210,-3,-5,110,140);
      _root.PositionNymphsTiara(200,45,-20,90,90,true);
      _root.PositionTail(335,310,-40,200,130,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(-185,30,-10,400,350);
         PositionDemonWingRight(256,-30,10,400,350);
      }
      else
      {
         _root.PositionWings(235,280,0,450,400);
      }
      _root.PositionCatEars(1,213,50,-12,130,55);
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
      }
      _root.ShowMovie(Robe1Clip,1,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 2)
   {
      _root.PositionHalo(238,8,3,200,40);
      _root.PositionLeash(6,245,212,0,180,265,true);
      _root.PositionGag(3,233,96,5,146.2,50,true);
      PositionDemonHornLeft(148,-22,0,110,140);
      PositionDemonHornRight(234,-22,0,110,140);
      _root.PositionNymphsTiara(237,20,5,70,70,true);
      _root.PositionCatEarsOver(1,237,25,0,70,30);
      _root.PositionTail(305,260,-30,180,100,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(-185,20,-10,400,350);
         PositionDemonWingRight(256,-40,10,400,350);
      }
      else
      {
         _root.PositionWings(240,200,0,350,300);
      }
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
         Robe2Clip.Dickgirl._visible = _root.IsDickgirl();
      }
      _root.ShowMovie(Robe2Clip,1,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 3)
   {
      _root.PositionHalo(270,20,-12,240,50.4);
      _root.PositionLeash(1,201,66,0,-100,130,true);
      _root.PositionGag(4,302,119,-30,120,80,true);
      PositionDemonHornLeft(164,8,-10,110,140);
      PositionDemonHornRight(266,-7,-10,110,140);
      _root.PositionNymphsTiara(265,40,-15,90,90,true);
      _root.PositionTail(145,250,0,-200,140,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(-145,-70,0,400,350);
         PositionDemonWingRight(326,-40,10,400,350);
      }
      else
      {
         _root.PositionWings(290,200,-10,400,450);
      }
      _root.PositionCatEars(1,283,35,-12,110,50);
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
      }
      _root.ShowMovie(Robe3Clip,1,3,_root.DressFrame);
   }
   else if(_root.DressWorn == 4)
   {
      _root.PositionHalo(245,10,0,200,50);
      _root.PositionLeash(3,189,48,0,150,130,true);
      _root.PositionGag(3,244,90,0,100,40,true);
      PositionDemonHornLeft(150,-24,0,110,140);
      PositionDemonHornRight(238,-22,0,110,140);
      _root.PositionNymphsTiara(242,20,0,60,60,true);
      _root.PositionTail(325,300,30,200,140,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(-180,-25,-10,400,350);
         PositionDemonWingRight(285,-80,10,400,350);
      }
      else
      {
         _root.PositionWings(245,200,0,400,350);
      }
      _root.PositionCatEars(1,244,21,0,70,30);
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
         RobePlainClip.Dickgirl._visible = _root.IsDickgirl();
      }
      _root.ShowMovie(Robe4Clip,1,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 5)
   {
      _root.PositionHalo(235,8,-10,200,50);
      _root.PositionLeash(2,297,49,0,129,130,true);
      _root.PositionGag(3,252,89,-10,100,40,true);
      PositionDemonHornLeft(142,-16,-5,110,140);
      PositionDemonHornRight(232,-22,-5,110,140);
      _root.PositionNymphsTiara(235,15,-10,60,60,true);
      _root.PositionCatEarsOver(1,244,25,-5,80,25);
      _root.PositionTail(115,250,0,-200,160,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(-170,-84,-0.0,400,350);
         PositionDemonWingRight(295,-60,20,400,350);
      }
      else
      {
         _root.PositionWings(230,190,5,350,300);
      }
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
      }
      _root.ShowMovie(Robe5Clip,1,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 6)
   {
      _root.PositionHalo(220,10,0,200,54);
      _root.PositionLeash(2,263,63,0,110,130,true);
      _root.PositionGag(3,224,107,0,110,50,true);
      PositionDemonHornLeft(132,-22,0,110,140);
      PositionDemonHornRight(218,-22,0,110,140);
      _root.PositionNymphsTiara(217,29,0,60,60,true);
      _root.PositionTail(300,270,0,200,160,true);
      if(_root.CheckBitFlag2(44))
      {
         PositionDemonWingLeft(-185,33,-10,400,350);
         PositionDemonWingRight(260,-35,10,400,350);
      }
      else
      {
         _root.PositionWings(225,220,0,400,350);
      }
      _root.PositionCatEars(1,224,25,0,90,35);
      _root.Backgrounds.ShowNight(2,true);
      Robe6Clip.Dickgirl._visible = _root.IsDickgirl();
      if(_root.DressFrame == 0)
      {
         if(_root.BiggerBoobs || _root.CustomFlag > 13)
         {
            _root.DressFrame = !(_loc2_ > 2.4 || _root.CustomFlag >= 13)?2:3;
            if(_root.IsDickgirl())
            {
               if(_root.VarLibidoRounded > 60 && _root.CustomFlag3 < 13)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(2);
               }
               if(_root.VarLibidoRounded > 60 && _root.CustomFlag3 >= 13 && _root.CustomFlag3 < 20)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(3);
               }
               if(_root.VarLibidoRounded > 60 && _root.CustomFlag3 >= 20)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(4);
               }
               else if(_root.VarLibidoRounded < 60.1)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(1);
               }
            }
         }
         else
         {
            _root.DressFrame = 1;
            if(_root.IsDickgirl() && _root.VarLibidoRounded > 60)
            {
               Robe6Clip.Dickgirl.gotoAndStop(2);
            }
         }
      }
      _root.ShowMovie(Robe6Clip,1,1,_root.DressFrame);
      return undefined;
   }
   _root.Backgrounds.ShowHousing();
}
function ShowDressSmall()
{
   var _loc2_ = int(_root.vitalsBustCurrent + 0.9) / int(_root.vitalsBustStart);
   if(_root.DressWorn == 0)
   {
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
         RobePlainClip.Dickgirl._visible = _root.IsDickgirl();
      }
      _root.ShowMovie(RobePlainClip,0,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 1)
   {
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
      }
      _root.ShowMovie(Robe1Clip,0,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 2)
   {
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
         Robe2Clip.Dickgirl._visible = _root.IsDickgirl();
      }
      _root.ShowMovie(Robe2Clip,0,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 3)
   {
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
      }
      if(_root.BiggerBoobs)
      {
         _root.ShowMovie(Robe3Clip,1,1,_root.DressFrame);
      }
      else
      {
         _root.ShowMovie(Robe3Clip,0,1,1);
      }
   }
   else if(_root.DressWorn == 4)
   {
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
         RobePlainClip.Dickgirl._visible = _root.IsDickgirl();
      }
      _root.ShowMovie(Robe4Clip,0,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 5)
   {
      if(_root.DressFrame == 0)
      {
         _root.DressFrame = !_root.BiggerBoobs?1:2;
      }
      _root.ShowMovie(Robe5Clip,0,1,_root.DressFrame);
   }
   else if(_root.DressWorn == 6)
   {
      Robe6Clip.Dickgirl._visible = _root.IsDickgirl();
      if(_root.DressFrame == 0)
      {
         if(_root.BiggerBoobs || _root.CustomFlag > 13)
         {
            _root.DressFrame = !(_loc2_ > 2.4 || _root.CustomFlag >= 13)?2:3;
            if(_root.IsDickgirl())
            {
               if(_root.VarLibidoRounded > 60 && _root.CustomFlag3 < 13)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(2);
               }
               if(_root.VarLibidoRounded > 60 && _root.CustomFlag3 >= 13 && _root.CustomFlag3 < 20)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(3);
               }
               if(_root.VarLibidoRounded > 60 && _root.CustomFlag3 >= 20)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(4);
               }
               else if(_root.VarLibidoRounded < 60.1)
               {
                  Robe6Clip.Dickgirl.gotoAndStop(1);
               }
            }
         }
         else
         {
            _root.DressFrame = 1;
            if(_root.IsDickgirl() && _root.VarLibidoRounded > 60)
            {
               Robe6Clip.Dickgirl.gotoAndStop(2);
            }
         }
      }
      _root.ShowMovie(Robe6Clip,0,1,_root.DressFrame);
   }
}
function ShowMaidUniform()
{
   _root.ShowMovie(RestaurantClip,1,1,2);
   return true;
}
function ShowSwimsuit()
{
   _root.ShowMovie(ItemSwimsuit,1,1,1);
   return true;
}
function ShowBunnySuit()
{
   _root.ShowMovie(SleazyBarClip,1,1,6);
   return true;
}
function ShowLingerie()
{
   _root.ShowMovie(SleazyBarClip,1,1,int(Math.random() * 2) + 1);
   return true;
}
function DoEventYes()
{
   if(_root.NumEvent == 321)
   {
      _root.HideImages();
      if(_root.Gender == 1)
      {
         _root.ShowMovie(EventMilk,1,1,13);
      }
      else
      {
         _root.ShowMovie(EventMilk,1,1,15);
      }
      _root.AddText("#slave unhooks the hose from the milker\'s reservoir and hands it to you, as she begins masturbating more vigorously.  She gasps, and gestures for you to put it in your mouth.  You tentatively lick your lips and put the hose in your mouth.  That instant, she orgasms again, shooting a wave of cum through the machine to your mouth.  You nearly lose your grasp on the hose as you struggle to swallow the spray of her thick creamy cum.  It actually tastes kind of sweet, pleasant in a way you didn\'t expect.  You enjoy gulping down as much of the stuff as you can, enjoying the taste and unusual consistency.  She smiles up at you as she continues spraying out more cum, and you realize this orgasm has already lasted longer than her last...\r\r");
      _root.AddText("A short time later you feel very full, wondering why you drank so much of her cum.  #slave managed to pull the milker off her meaty cock, and is panting with exertion.  She gives you a knowing smile.");
      if(_root.CheckBitFlag2(9))
      {
         _root.AddText("  #assistant eagerly cleans her cock and then proceeds to lick up all the cum you couldn\'t swallow...and there\'s a lot it.  You allow her to clean yourself, figuring it will save you some effort.");
      }
      _root.Points(0,0,0,0,0,1,0,0,0,0,0,10,1,-1,0,0,0.5,4,1,-20);
      _root.MinLibido = _root.MinLibido + 3;
      _root.SMMinLust = _root.SMMinLust + 1;
      if(_root.Gender == 2)
      {
         _root.AddText("\r\rYour nipples and clit tingle for some time after the drink.");
      }
      else
      {
         _root.AddText("\r\rYour cock tingles for some time afterward.");
      }
      _root.CustomFlag1 = _root.CustomFlag1 + 2;
      return true;
   }
   if(_root.NumEvent == 305)
   {
      _root.HideImages();
      if(_root.Gender == 1 || _root.Gender == 3)
      {
         _root.AddText(_root.SlaveName + " grasps you and presses your massive head against her opening.  Incredibly, she starts to sink down on you, her velvet walls gripping and rippling around you as inch after inch of you passes into her.  It shouldn\'t be possible, but she continues to take your cock with agonizing slowness.  She passes the halfway point and you can\'t help but cum, massive spurts blast into her, but she shows only enjoyment.  She slides down the rest of the way, lubricated by your unnatural orgasm, rippling her pussy around your massive girth to milk out more of your cum.  She shouldn\'t even be able to fit your monster dick inside her, or hold the volume of cum you can feel erupting from you, but she does.\r\r");
         _root.AddText("Your body begins lurching up to meet her, bouncing her up in the air before dropping her back onto your dick.  Cum dribbles and sprays out of her cunny from the force of your thrusts.  She moans, but keeps that confident look on her face as your orgasm drags on.  Your mind shuts down from the pleasure, and your body takes over as you grasp her hips and pound her with inhuman strength.  She pinches your nipples and your dick suddenly hoses out a huge spurts.  Your balls hurt but you can\'t stop orgasming.  #slave smiles and pinches harder, and you feel energy flowing into you.\r\r");
         _root.AddText("It doesn\'t matter that it this shouldn\'t be possible...all that matters is fucking sluts pregnant...yes, that\'s your job...spreading fertility and lust to those around you.  Your orgasm finally finishes as #slave loses her grip on you and orgasms.  Faerie wings unfurl from behind her, fluttering slowly and lifting her from your drained cock.  You smile at her, happy for her ascension and probably pregnancy.");
         if(_root.IsDickgirl())
         {
            _root.ShowMovie(EventMorningMouthfull,1,1,15);
         }
         else
         {
            _root.ShowMovie(EventMorningMouthfull,1,1,14);
         }
         _root.SetBitFlag2(10);
         _root.DoEvent(337);
         return true;
      }
   }
   if(_root.NumEvent == 304)
   {
      _root.HideImages();
      _root.AddText("#slave feels her breasts swelling. They grow increasingly large and sensitive as they pass C cups, then D cups, and grow all the way to F cups!  Her shirt tears off and her inch-long nipples are as hard as tiny dicks.  She forces them into Bess\'s mouth and the cowgirl begins suckling Aeris\'s thick and salty cream.\r\r");
      if(_root.VarSpecialRounded < 50)
      {
         _root.ShowMovie(CowEventClip,1,1,4);
         _root.AddText("Bess begins cumming and squirting as she drinks #slave\' nymph-potion. Her own breasts slowly swell as #slave\' shrink towards normal size.  After many orgasms the milk tapers off and Aeris returns to normal.  Bess marvels at her bigger more sensitive udders.\r\r");
         _root.SetBitFlag2(4);
      }
      if(_root.VarSpecialRounded > 49 && _root.VarSpecialRounded < 75)
      {
         _root.AddText("Bess suckles hungrily on #slave\' nymph-potion. It tastes sweet and salty and seems to fill her with pleasure.  ");
         if(_root.IsDickgirl())
         {
            _root.AddText(" She unexpectedly plunges herself onto Aeris\'s shaft as she drinks. Her pussy ripples in orgasm and begins instinctively milking her for cum.  ");
         }
         else
         {
            _root.AddText(" The cowgirl\'s pussy lips get puffy as her cunt starts rippling in orgasm.  She plunges the vibrator back in as her pussy tries to milk the prosthetic cock.  ");
         }
         _root.AddText("The cowgirl\'s hair darkens and her breasts swell up like beach-balls as the transformation nears its end.  #slave\' orgasms fade, returning her body to normal.  Bess has some difficulty even fitting into her old cow costume.  \r\r");
         _root.SetBitFlag2(5);
         _root.ShowMovie(CowEventClip,1,1,5);
         _root.CustomFlag = _root.CustomFlag + 0.5;
         if(_root.IsDickgirl())
         {
            _root.CustomFlag3 = _root.CustomFlag3 + 0.5;
         }
         if(_root.CustomFlag >= 13 && _root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         else
         {
            _root.Lactation = _root.Lactation + 1;
         }
      }
      if(_root.VarSpecialRounded > 74)
      {
         _root.SetBitFlag2(6);
         _root.AddText("The milk pours out faster than Bess can keep up with, but she drinks as much as she can.  #slave\' milky nymph-potion fills her with lust and makes her own nipples drool.  Bess cries out in sudden heat and plunges herself onto ");
         if(_root.IsDickgirl())
         {
            _root.ShowMovie(CowEventClip,1,1,7);
            _root.SetBitFlag2(7);
            _root.AddText("#slave\' hard cock.  Her pussy ripples, milking out a torrent of cum. Both girls throw their heads back in twin orgasms. Bess feels her clitty grow...and grow...and grow. Her own cock stands proud, erect, and drools cum.  ");
         }
         else
         {
            _root.ShowMovie(CowEventClip,1,1,6);
            _root.AddText(" the huge vibrator and frantically bounces on it.  ");
         }
         _root.AddText("Bess cums repeatedly, and each time her breasts grow larger and spray more milk. Her hair changes colors but she doesn\'t notice. After minutes of continuous orgasm the transformation ends.  #slave has returned to normal, while Bess is a perfect little cum-dump of a cow. \r\r");
         _root.CustomFlag = _root.CustomFlag + 1;
         if(_root.IsDickgirl())
         {
            _root.CustomFlag3 = _root.CustomFlag3 + 1;
         }
         if(_root.CustomFlag >= 13 && _root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         else
         {
            _root.Lactation = _root.Lactation + 2;
         }
      }
      _root.AddText("Bess loves her new body.\r\r");
      _root.PersonSpeak("Bess","Thank you so much #slave.  I\'ll let you milk me any time, any where.  From now on, you\'re my secret Mistress.",true);
      _root.AddText("\r\rThe Cowgirl slave gives #slave a sensual hug before running off.  ");
      _root.CustomFlag = _root.CustomFlag + 0.5;
      if(_root.IsDickgirl())
      {
         _root.CustomFlag3 = _root.CustomFlag3 + 0.5;
      }
      if(_root.CustomFlag >= 13 && _root.Lactation < 30)
      {
         _root.Lactation = 30;
      }
      else
      {
         _root.Lactation = _root.Lactation + 1;
      }
      _root.Points(2,1,0,0,0,0,0,0,1,0,0,2,1,0,-50,0,3,4,0,-99);
      if(_root.CustomFlag4 < 5)
      {
         _root.AddText("#slave takes a bottle of Bess\' milk from the machine.  ");
         _root.CustomFlag4 = _root.CustomFlag4 + 1;
      }
      else
      {
         _root.AddText("#slave takes a bottle of Bess\' milk and greedily swallows it.  ");
         if(_root.CustomFlag < 6)
         {
            _root.AddText("#slave hopes the milk isn\'t affecting her. ");
         }
         if(_root.CustomFlag > 5.9 && _root.CustomFlag < 13)
         {
            _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.  ");
         }
         if(_root.CustomFlag > 12.9 && _root.CustomFlag < 20)
         {
            _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.  ");
         }
         if(_root.CustomFlag > 19.9)
         {
            _root.AddText("#slave yanks down her top and marvels at the size of her tits.  Dribbles of milk already run from her engorged nipples.  She pants lustily and attaches the milk machine to her own breasts.  She cums nearly immediately as the pumps try to keep up with the flow of milk....\r\rNearly an hour later a tired looking #slave leaves.");
         }
         _root.Points(0,1,0,-1,0,0,0,0,0,0,0,0,1,0,3,0,0,0,0,5);
         _root.MinLibido = _root.MinLibido + 0.5;
         _root.CustomFlag = _root.CustomFlag + 1;
         if(_root.CustomFlag >= 13 && _root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         else
         {
            _root.Lactation = _root.Lactation + 4;
         }
      }
      _root.ShowPlanningNext();
   }
   if(_root.NumEvent == 300)
   {
      _root.SetBitFlag2(29);
      _root.HideImages();
      if(_root.CustomFlag1 > 10)
      {
         if(_root.Gender == 1 || _root.Gender == 3)
         {
            _root.AddText("You quickly remove your clothes, but your body has already betrayed you.  Your dick is hard and full.  #slave smiles lustily as she looks up at you. It would be easy to gaze into her eyes forever...");
            _root.AddText("\r\rYou gasp as #slave wraps her hand around your now well lubricated shaft. You realize you\'ve become soaked with precum!  How much time did you spend gazing into those eyes?  ");
            if(_root.Gender == 3)
            {
               _root.AddText("Your nipples feel so tender and ache to be touched. Aeris slips her hand into your folds and comes out with even more slippery lube for your cock.\r\r");
            }
            else
            {
               _root.Addtext("\r\r");
            }
            _root.AddText("She makes sure to lather your cum all over your ");
            if(_root.CustomFlag1 > 14.9 && _root.CustomFlag1 < 24)
            {
               _root.AddText("huge ");
            }
            else if(_root.CustomFlag1 > 23.9)
            {
               _root.AddText("massive ");
            }
            _root.AddText("cock.  #slave stops, and you grunt in frustration.  \r\r");
            if(_root.IsDickgirl() && _root.Gender == 3)
            {
               _root.ShowMovie(BreakClip,1,1,10);
               _root.AddText("You roll over and push your ass in the air, trying to tantalize her into fucking you with her now erect dick.  You shudder as she firmly grasps your cock and milks you for a handful of precum.\r\r");
               _root.SlaveSpeak("Relax " + _root.SlaveMakerName + ", you will love this.",true);
               _root.AddText("\r\rShe oils your pussy and ass liberally with cum before plunging in.  You shudder as she slowly slips back out.  Suddenly buries herself to the hilt in your ass. Your dick splatters hot cum over the sheets from a mind blowing orgasm.  Your legs wobble and start to go nerveless as you feel #slave\' dick grow larger inside your ass!  ");
               _root.AddText("You dribble thick ropes of cum as her painfully large dick slips out of your ass.  You grunt at the sudden reprieve and prepare to scold her for being so rough with you.  #slave gives you a painful slap on the ass and your softening erection rages back to full size.\r\r");
               _root.SlaveSpeak("I\'m not done here!",true);
               _root.AddText("\r\r#slave grabs you by the hips and rams her cock into your pussy, then your ass, then back into your pussy in rapid succession. Your jizz spurts out in thick ropes in time with her rough fucking. Your pussy grips her cock tightly with each thrust and her ass-fucking seems to force even more cum out of your cock.  ");
               _root.AddText("The world seems to fade into the sensations of your pussy, ass, and cock...");
            }
            else
            {
               _root.ShowMovie(BreakClip,1,1,9);
               _root.SlaveSpeak("Easy stud, I promise you\'ll cum hard.",true);
               _root.AddText("\r#slave kneels to begin licking you from balls to shaft. Each time she makes it to the tip she sucks dribbles of precum from the tip. Your balls tingle with arousal from the rough strokes and squeezes her hand is providing. #slave stretches up to mash her tits around your dick. All the cum and saliva make the titfuck she is giving very pleasurable.\r\r");
               _root.AddText("You start cumming after just a few moments.  The cum runs in thick rivulets over her breasts and your dick. #slave looks disappointed as you give her a satisfied smile. The smile vanishes when you feel pressure on your testicles and notice her firm grip. #slave licks her lips.\r\r");
               _root.SlaveSpeak("I want MORE!!",true);
               _root.AddText("\rYou can\'t tell if her grip is tightening or your balls are getting bigger, but it hurts.  #slave gives them a gentle squeeze and your dick surges back to full size and beyond.  It\'s a full inch larger than normal!  You are interrupted from your thoughts by a painful slap to your balls!  ");
               _root.AddText("#slave is on you again in a flash and using her ");
               if(_root.MilkInfluence > 0)
               {
                  _root.AddText("milk-swollen ");
               }
               _root.AddText("breasts to milk every drop of cum from your cock. Each orgasm seems more intense than the last as you lose yourself in the orgasms...");
            }
         }
         else
         {
            _root.ShowMovie(BreakClip,1,1,11);
            _root.AddText("#slave gives you a naughty smile as she places her fingers to her lips. You cringe from the earsplitting whistle she lets out.  Her friend Tifa bursts through the door and drops a latex pack full of vibrators and other toys. You gasp as she tackles you onto #slave\' bed.  Together the two of them expertly disrobe you, but they could have just asked. The heady scent of your sex is heavy in the air, and your breasts are heavy with an aching need for attention.\r\r");
            _root.PersonSpeak("Tifa",SlaveName + ", I don\'t know what\'s happened to you, but you\'re soooo much more fun now!",true);
            _root.AddText("\r#slave giggles at Tifa and starts rubbing your lower lips.  She smiles at you as her fingers become coated in your slick sticky juices.  Tifa uses the distraction to force her way into the action.  She starts by kissing you roughly and passionately. Her hand dominates your sex as she carefully ministrate to your needs.  Arousal builds within you like a roaring fire, and you start kissing and grinding against Tifa.  She firmly forces your hips down and breaks the kiss.\r\r");
            _root.PersonSpeak("Tifa","I think Aeris has something for you...",true);
            _root.AddText("\rIts not fair! You can\'t see what she\'s up to.  You try to sit up but Tifa holds you down.  A large round ribbed object begins pressing into your slick pussy.  #slave slowly forces in each pleasurable rib of the huge dildo.  Your pleasure wells up long before she can fully insert it.  It begins vibrating in tiny wiggling pulses and you cream all over #slave\' hands.  Tifa starts suckling a nipple during your protracted orgasm.  Your nipples start leaking a creamy thick white liquid into her mouth and on yourself.  ");
            _root.AddText("\r\rYou smile dreamily as you start to calm down, but #slave pinches your clit tightly.  You clit swells with lust as ephemeral aphrodisiacs radiate through your swollen clitty to the rest of your body.  Thick geysers of sticky milk squirt from your breasts and Tifa is hard pressed to keep up.  #slave grabs the vibrator with both hands as your hips savagely squirm and buck on it.  Drops of your sticky milk and cum rain on the bed as your body gives in the all-consuming lust.  You lose yourself in a haze of orgasms...\r\r");
         }
      }
      else if(_root.Gender == 1 || _root.Gender == 3)
      {
         _root.ShowMovie(BreakClip,1,1,4);
         _root.AddText("#slave wastes no calling her friends Tifa and Yuffie.  By the time they arrive #slave has torn off your clothes and licked you a full throbbing erection.  Tifa and Yuffie blush in total surprise as #slave\' tongue slowly slides up down your length.   You find your hips twitching in response to her efforts as sucks a drop of precum from you. ");
         if(_root.Gender == 3)
         {
            _root.AddText("Your hands find your way to your wonderfully sensitive nipples and your slit dampens in sympathy with your growing arousal.");
         }
         _root.AddText("\r\rTifa suddenly slams you both roughly onto the bed, and takes your cock-head into her mouth.  You decide to let her take charge and see what happens. Yuffie and #slave kneel on either side and each begin licking up and down the sides of your shaft. Their tongues sometimes slide around to tongue kiss around your painfully hard dick.  The three of them tease you for what feels like hours, Tifa milking your precum as the other two keep your dick bathed with heavenly tongues and kisses. ");
         if(_root.Gender == 3)
         {
            _root.AddText(" Your ass is soaked with constant wetness leaking from your slit.  Your head is swimming from the concentrated smell of female arousal.");
         }
         _root.AddText("\r\rYou lose all control of yourself as your hips buck in time with their licks. Your balls clench as your orgasm builds and #slave and Yuffie wrap their tongues around you.  ");
         if(_root.Gender == 3)
         {
            _root.AddText("You can\'t help but pinch your nipples as your pussy soaks itself.  ");
         }
         _root.AddText("Your cum starts blasting into Tifa ? who doesn\'t lose a drop despite what feels like gallons pouring out of you. You cum over and over and just when you think you\'re done her finger slides in your ass and you can\'t help but spurt what feels like gallons.  ");
      }
      else
      {
         _root.ShowMovie(BreakClip,1,1,5);
         _root.AddText("You let #slave undress you. Her hands roam over  your body, caressing and touching you as she deftly removes your clothing and armor. You sigh as her hands find your breasts. Her fingers dance around your nipples as you feel her hot breath on your neck. She gives them a gentle tug and you grunt in pain and arousal.  The heat of your lust builds in your groin as she works her way down your body.  ");
         _root.AddText("#slave strokes your thighs as she removes the last of your gear to reveal your glistening honeypot. Her fingers slide into your moist folds and you can\'t help but moan in arousal.  \r\r");
         _root.AddText("Suddenly you find yourself gagging as a pill is forced down your throat.  Before you can push her off your muscles turn to quivering jello from a sudden overpowering orgasm.  She holds you up while she licks your earlobe and sets off another mind-shattering orgasm...\r\r");
         _root.AddText("It doesn\'t even matter that she drugged you anymore. All you can do as writhe into her fingers and her tender ministrations drive you to orgasm after orgasm.  Her tongue eventually finds it way to your clit while her fingers work your nipples.  You practically soak her with your pussy as you black out from a wonderful orgasm. ");
      }
      _root.NextEvent._visible = true;
   }
   if(_root.NumEvent == 302)
   {
      _root.HideImages();
      _root.ShowMovie(CowEventClip,1,1,2);
      _root.AddText("#slave suddenly grabs Bess\' hand.  Bess gasps and two small wet spots become visible.\r\r");
      _root.SlaveSpeak("I...want to see a milking.  Could you please let me see one?",true);
      _root.AddText("\rBess glances around and leads #slave into the barn. She asks #assistant to stay outside so as not to arouse suspicion.\r\r");
      _root.AddText("Bess steps into a stall and removes her top.  She is flushed red with arousal. Her cow tits heave with each breath. Aeris gets the milking equipment from a rack on the wall and places the cups on Bess\' breasts.  Bess shudders and gives Aeris a weak smile.\r\r");
      _root.PersonSpeak("Bess","I\'ve been milked today so my yield may be low.",true);
      _root.AddText("\r#slave gives Bess a reassuring smile that relaxes her. Droplets of milk start drooling from her breasts as Bess pants in anticipation.  #slave flips the switch labelled \'Milk\' on the equipment.\r\r");
      _root.PersonSpeak("Bess","OoooOOOoooMMoooooOOOOOOOOOOO!",true);
      _root.AddText("\rShe seems to have already orgasmed from milking suction.  Her nipples are pouring continuous streams into the device, which is rapidly filling.  #slave\' eyes widen as the tank nears the full line. Bess keeps moaning and squirting out milk with no signs of stopping.  A pressure warning comes on from the machine as it begins overfilling.  Bess isn\'t showing any signs of slowing down - the scent of her musky animalistic arousal is getting VERY strong in the stall.\r\r");
      _root.AddText("A pressure-release valve triggers and a small vent-hose starts sputtering milk over #slave!  She points it away in disgust at first, but as the milking continues the rich smelling milk and Bess\' musky arousal overtake her.  She sneaks one hand under her panties and finds herself very moist.  Her other hand hesitantly aims the hose towards her mouth. She greedily sucks down Bess\' milk as her masturbation intensifies.\r\r");
      _root.AddText("#slave cums powerfully just seconds before Bess. The force coming out of the hose forces it out of #slave\' mouth but she is beyond caring. Both girls get hosed down as the milk sprays wildly around the stall.\r\r");
      _root.NextEvent._visible = true;
   }
   return false;
}
function DoEventNext()
{
   if(_root.NumEvent == 339)
   {
      _root.HideImages();
      if(_root.Gender == 1)
      {
         _root.AddText("#slave reaches out to touch you, her hand lingering on your shaft.  You feel a tingling pass into you, instantly lighting a fire in your loins.  In a moment you feel yourself snap back to full erectness, then getting harder and larger, far bigger than usual.");
      }
      if(_root.Gender == 3)
      {
         _root.AddText("#slave reaches out to touch you, her hand lingering on your breasts. You the tingle of something passing into them, her magic making your breasts feel tight and wonderful.  The pulsing magic radiates through your nipples, spreading into your crotch.  Your pussy and cock both respond, enflaming instantly with need.  The feeling intensifies, rivulets of moisture running from your pussy, your nipples and breasts aching and heavy, your cock feeling fuller and thicker than ever before.");
      }
      _root.AddText("\r\r#slave swoons for a moment, then smiles, pleased with the effects.  She presents her drippy, inviting pussy to you, and you cannot resist.  You take her forcefully, powerfully, fucking her fast and hard.  She\'s deliciously tight, moaning and panting as you quickly cum inside her.  Her legs wrap around you, pulling you deeper as your orgasm drags on.");
      _root.AddText("\r\rThe orgasm is far from the end, as your cock stays huge and swollen.  #slave spends the rest of the hour helping you bring it back it down.");
      if(!_root.IsDickgirl())
      {
         _root.ShowMovie(FuckClip,1,1,1);
      }
      else
      {
         _root.ShowMovie(FuckClip,1,1,9);
      }
      _root.CustomFlag1 = _root.CustomFlag1 + 2;
      _root.Points(0,0,0,0,0,1,0,0,0,0,2,0.5,0.5,-0.5,-10,0,3,1,1,-20);
      _root.SMMinLust = _root.SMMinLust + 2;
      _root.SMPoints(0,0,0,0.5,-1,-5,1,0,-3);
      return true;
   }
   if(_root.NumEvent == 323)
   {
      _root.HideImages();
      if(_root.Gender == 1)
      {
         _root.AddText("#slave reaches out to touch you, her hand lingering on your shaft.  You feel a tingling pass into you, instantly lighting a fire in your loins.  In a moment you feel yourself snap back to full erectness, then getting harder and larger, far bigger than usual.");
      }
      if(_root.Gender == 3)
      {
         _root.AddText("#slave reaches out to touch you, her hand lingering on your breasts. You the tingle of something passing into them, her magic making your breasts feel tight and wonderful.  The pulsing magic radiates through your nipples, spreading into your crotch.  Your pussy and cock both respond, enflaming instantly with need.  The feeling intensifies, rivulets of moisture running from your pussy, your nipples and breasts aching and heavy, your cock feeling fuller and thicker than ever before.");
      }
      _root.AddText("\r\r#slave\'s skin suddenly darkens with gathering energy, rippling across her flesh.  Her eyes flash crimson red, mesmerizing you instantly.\r\r");
      _root.PersonSpeak(_root.SlaveName,"My power can change your essence to something more...fulfilling.  It wants...it needs...TELL ME WHAT IT NEEDS!!",true);
      if(_root.Gender == 2)
      {
         _root.AddText("\r\rShe slowly inserts her tongue deep onto your clit, slowly lubricating you and sending tingling waves of pleasure reverberating through your trembling body.  Her hands reach up and grab your breasts, twisting them and forcing a thin stream of milk onto your chest.  Her tongue moves faster and faster and her eyes drain all of the thoughts from your mind except the screaming, unstoppable urge to cum.  From deep within you, you feel your lifeforce forcing itself out as a stream of thick cum spurts from your erect nipples and love juice from your pussy in a tremendous, shuddering orgasm.  As you catch your breath, you feel something else insidiously working its way in...\r");
      }
      else if(_root.Gender == 3)
      {
         _root.AddText("\r\rShe lowers herself onto your manhood, slowly thrusting herself up and down, then in a circular motion, faster and faster.  She takes you forcefully, powerfully, biting and sucking on your nipples and drawing you deeply into her eyes and her cunt until you can think of nothing else.  From deep within you, you feel your lifeforce forcing itself out as a stream of thick cum spurts from your erect nipples and pulsating member in a tremendous, shuddering orgasm.  As you catch your breath, you feel something else insidiously working its way in...\r");
      }
      else
      {
         _root.AddText("\r\rShe lowers herself onto your manhood, slowly thrusting herself up and down, then in a circular motion, faster and faster.  She takes you forcefully, powerfully, drawing you deeply into her eyes and her cunt until you can think of nothing else.  From deep within you, you feel your lifeforce forcing itself out through your pulsating member in a tremendous, shuddering orgasm.  As you catch your breath, you feel something else insidiously working its way in...\r");
      }
      if(!_root.IsDickgirl())
      {
         _root.ShowMovie(FuckClip,1,1,1);
      }
      else
      {
         _root.ShowMovie(FuckClip,1,1,9);
      }
      _root.CustomFlag1 = _root.CustomFlag1 + 3;
      _root.Points(0,0,0,0,0,1,0,0,0,0,2,0.5,0.5,-0.5,-10,0,3,1,1,-20);
      _root.SMMinLust = _root.SMMinLust + 2;
      _root.SMPoints(0,0,0,0.5,-1,-5,1,0,-3);
      _root.ResetQuestions("Your lips move by themselves, and utter:");
      if(_root.Gender != 2 && _root.SMSpecialEvent != 2)
      {
         _root.AddQuestion(325,"Ph\'nglui mglw\'nafh Cthulhu R\'lyeh!");
      }
      if(_root.Gender != 2 && _root.SMSpecialEvent != 5)
      {
         _root.AddQuestion(326,"My cock needs to fuck your ass!");
      }
      if(_root.Gender == 2 && _root.sSuccubusTrainer == 0 && _root.SMSpecialEvent != 7)
      {
         _root.AddQuestion(330,"Take my soul, take it!");
      }
      if(_root.Gender != 1 && _root.SMSpecialEvent != 1)
      {
         _root.AddQuestion(332,"My breasts are sooo heavy and full...");
      }
      if(_root.Gender != 2 && _root.SMSpecialEvent != 6 && _root.SMSpecialEvent != 8)
      {
         _root.AddQuestion(327,"Take my soul, take it!");
      }
      if(_root.Gender != 2 && !_root.SMAdvantages.CheckBitFlag(6))
      {
         _root.AddQuestion(328,"They must all have COCKS!");
      }
      if(_root.Gender != 2 && !_root.IsVampire())
      {
         _root.AddQuestion(329,"Your eyes are so red, like blood...");
      }
      if(!_root.SMAdvantages.CheckBitFlag(23))
      {
         _root.AddQuestion(331,"My skin is as black as my soul...");
      }
      _root.AddQuestion(336,"It needs only me, dear.");
      _root.ShowQuestions();
      return true;
   }
   if(_root.NumEvent == 324)
   {
      _root.HideImages();
      if(_root.Gender == 1)
      {
         _root.AddText("#slave reaches out to touch you, her hand lingering on your shaft.  You feel a tingling pass into you, instantly lighting a fire in your loins.  In a moment you feel yourself snap back to full erectness, then getting harder and larger, far bigger than usual.");
      }
      if(_root.Gender == 3)
      {
         _root.AddText("#slave reaches out to touch you, her hand lingering on your breasts. You the tingle of something passing into them, her magic making your breasts feel tight and wonderful.  The pulsing magic radiates through your nipples, spreading into your crotch.  Your pussy and cock both respond, enflaming instantly with need.  The feeling intensifies, rivulets of moisture running from your pussy, your nipples and breasts aching and heavy, your cock feeling fuller and thicker than ever before.");
      }
      _root.AddText("\r\r#slave\'s skin suddenly pulsates with gathering energy, rippling across her flesh.");
      _root.PersonSpeak(_root.SlaveName,"My power can change your essence to something more fulfilling.",true);
      if(_root.Gender == 2)
      {
         _root.AddText("\r\rShe slowly inserts her tongue deep onto your clit, slowly lubricating you and sending tingling waves of pleasure reverberating through your trembling body.  Her hands reach up and grab your breasts, twisting them and forcing a thin stream of milk onto your chest.  Her tongue moves faster and faster and her eyes drain all of the thoughts from your mind except the screaming, unstoppable urge to cum.  From deep within you, you feel your lifeforce forcing itself out as a stream of thick cum spurts from your erect nipples and love juice from your pussy in a tremendous, shuddering orgasm.  As you catch your breath, you feel #slave\' power reaching deep inside of you to touch your very soul...\r");
      }
      else if(_root.Gender == 3)
      {
         _root.AddText("\r\rShe lowers herself onto your manhood, slowly thrusting herself up and down, then in a circular motion, faster and faster.  She takes you forcefully, powerfully, biting and sucking on your nipples and drawing you deeply into her eyes and her cunt until you can think of nothing else.  From deep within you, you feel your lifeforce forcing itself out as a stream of thick cum spurts from your erect nipples and pulsating member in a tremendous, shuddering orgasm.  As you catch your breath, you feel #slave\' power reaching deep inside of you to touch your very soul...\r");
      }
      else
      {
         _root.AddText("\r\rShe lowers herself onto your manhood, slowly thrusting herself up and down, then in a circular motion, faster and faster.  She takes you forcefully, powerfully, drawing you deeply into her eyes and her cunt until you can think of nothing else.  From deep within you, you feel your lifeforce forcing itself out through your pulsating member in a tremendous, shuddering orgasm.  As you catch your breath, you feel #slave\' power reaching deep inside of you to touch your very soul...\r");
      }
      if(!_root.IsDickgirl())
      {
         _root.ShowMovie(FuckClip,1,1,1);
      }
      else
      {
         _root.ShowMovie(FuckClip,1,1,9);
      }
      _root.CustomFlag1 = _root.CustomFlag1 + 3;
      _root.Points(0,0,0,0,0,1,0,0,0,0,2,0.5,0.5,-0.5,-10,0,3,1,1,-20);
      _root.SMMinLust = _root.SMMinLust + 2;
      _root.SMPoints(0,0,0,0.5,-1,-5,1,0,-3);
      ResetQuestions("You whisper gently:");
      if(_root.FurriesOn && !_root.IsFurry())
      {
         AddQuestion(333,"I want to run wild in the forest!");
      }
      if(!_root.SMAdvantages.CheckBitFlag(22))
      {
         AddQuestion(335,"I want to live in the forest.");
      }
      if(_root.Gender != 1 && !_root.SMAdvantages.CheckBitFlag(24))
      {
         AddQuestion(334,"Meow!");
      }
      AddQuestion(336,"I want to be with you forever.");
      ShowQuestions();
      return true;
   }
   if(_root.NumEvent == 325)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYou feel something squirming deep within your chest, seeking and probing deeper and deeper.  Your skin becomes suffused with a musky aroma.");
      _root.ChangeSMQualities(14);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 326)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYou feel a dark presence suddenly take notice of you from somewhere close by.");
      _root.ChangeSMQualities(10);
      _root.SMSpecialEvent = 5;
      _root.ChangeSMQualities(10);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 327)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYou feel something trying to force its way out of your cock.  Your cock throbs and pulsates with dark, crackling energy.");
      _root.ChangeSMQualities(4);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 328)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      if(_root.Gender == 3 && !_root.DickgirlTesticles)
      {
         _root.AddText("\r\rYour cock feels subtly different, quivering with intense need.");
      }
      else
      {
         _root.AddText("\r\rYour cock and balls feel subtly different, quivering with intense need.");
      }
      _root.ChangeSMQualities(8);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 329)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYou suddenly feel a piercing hunger for something thick and rich and oh-so red....");
      _root.ChangeSMQualities(26);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 330)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYou feel a dark presence suddenly take notice of you from somewhere close by.");
      _root.ChangeSMQualities(18);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 331)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYour skin darkens dramatically and your ears lengthen to fine points.  You feel an urge to <b>punish</b>...");
      _root.ChangeSMQualities(30);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 332)
   {
      _root.PersonSpeak(_root.SlaveName,"Yes...yes!  It is done.",true);
      _root.AddText("\r\rYour breasts suddenly feel much heavier.  Milk begins leaking steadily from your sensitive nipples.");
      _root.ChangeSMQualities(28);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 333)
   {
      _root.PersonSpeak(_root.SlaveName,"Wonderful!  Now, just a moment while I...",true);
      _root.AddText("\r\rYour body suddenly sprouts fur all over!  And...you feel an intense desire to <b>fuck</b>...");
      _root.PersonSpeak(_root.SlaveName,"...there!  How do you like it?",true);
      _root.ChangeSMQualities(27);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 334)
   {
      _root.PersonSpeak(_root.SlaveName,"Wonderful!  Now, just a moment while I...",true);
      _root.AddText("\r\rYour ass begins to itch.  The sensation grows more and more intense until a long, ropy <b>tail</b> pops out at the base of your spine.  You reach up and feel your ears, now covered in soft fur.");
      _root.PersonSpeak(_root.SlaveName,"...there!  How do you like it?",true);
      _root.ChangeSMQualities(31);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 335)
   {
      _root.PersonSpeak(_root.SlaveName,"Wonderful!  Now, just a moment while I...",true);
      _root.AddText("\r\rYour ears grow to fine points, and you feel a sudden desire to wander outdoors.");
      _root.PersonSpeak(_root.SlaveName,"...there!  How do you like it?",true);
      _root.ChangeSMQualities(29);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 336)
   {
      _root.PersonSpeak(_root.SlaveName,"Wonderful!  Let\'s fuck some more now...",true);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 337)
   {
      _root.TrainingComplete();
      return true;
   }
   if(_root.NumEvent == 338)
   {
      _root.ShowMovie(_root.Faeries.BaseMovie.ClipFairyMeeting,1,0,12);
      _root.DoEvent(9999);
      return true;
   }
   if(_root.NumEvent == 307)
   {
      if(_root.CustomFlag4 < 2)
      {
         _root.PersonSpeak("Faerie Trader","I\'m sorry but you haven\'t enough milk for any of my items.",true);
      }
      else
      {
         _root.HideImages();
         _root.CustomFlag4 = _root.CustomFlag4 - 2;
         _root.AddText("POTION GET!\r(-2 Milk Bottles)\r\r");
         _root.ShowMovie(FaerieClip,1,1,3);
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15);
         if(_root.VarSpecialRounded == 100)
         {
            _root.AddText("#slave drinks the potion and seems to shiver with barely contained energy.\r\r");
         }
         else
         {
            _root.AddText("#slave feels invigorated and confident after drinking the potion.\r\r");
         }
      }
      return true;
   }
   if(_root.NumEvent == 308)
   {
      if(_root.CustomFlag4 < 2)
      {
         _root.PersonSpeak("Faerie Trader","I\'m sorry but you haven\'t enough milk for any of my items.",true);
      }
      else
      {
         _root.HideImages();
         _root.CustomFlag4 = _root.CustomFlag4 - 2;
         _root.AddText("CUM BOTTLE GET!\r(-2 Milk Bottles)\r\rThe Faerie insists #slave samples the merchandise before the trade.  " + SlaveName);
         if(_root.CustomFlag3 < 6)
         {
            _root.AddText(" does not look like she enjoys it, but agrees to the trade.\r\r");
         }
         else if(_root.CustomFlag3 > 5.9 && _root.CustomFlag3 < 12)
         {
            _root.AddText(" swallows with a smile.\r\r");
         }
         else if(_root.CustomFlag3 > 12.9 && _root.CustomFlag3 < 20)
         {
            _root.AddText(" greedily downs the cum.\r\r");
         }
         else if(_root.CustomFlag3 > 19.9)
         {
            _root.AddText(" flushes and drinks quickly, making a bit of a mess.  She licks the inside of the glass clean then makes sure to clean the excess off her face.\r\r");
         }
         _root.ShowMovie(FaerieClip,1,1,4);
         _root.CustomFlag3 = _root.CustomFlag3 + 0.2;
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,2);
         _root.MinLibido = _root.MinLibido + 0.3;
         _root.CustomFlag2 = _root.CustomFlag2 + 1;
      }
      return true;
   }
   if(_root.NumEvent == 309)
   {
      if(_root.CustomFlag4 < 2)
      {
         _root.PersonSpeak("Faerie Trader","I\'m sorry but you haven\'t enough milk for any of my items.",true);
      }
      else
      {
         _root.HideImages();
         _root.CustomFlag4 = _root.CustomFlag4 - 2;
         _root.AddText("#slave purchases the potion for two milk bottles, then drinks it somewhat hesitantly.\r\r");
         if(_root.IsDickgirl())
         {
            _root.ShowMovie(ClipDickgirl,1,1,3);
            _root.AddText("#slave basks in the feelings of radiance and confidence that the potion imbues her with.  And yet she feels something else stirring within her...lust.  She gasps her dick begins stirring and growing erect. She tries to hide it but keeps getting larger until it reaches the undersides of her breasts.  #slave can\'t handle the stimulation and lust anymore and sheds her clothes as her monstrous cock grows large enough to reach the top of her breasts!  She tittyfucks herself, licking her massive cock-head until she cums with geyser-like intensity, spraying gallons of cum into the lake.\r\r");
            _root.AddText("She collapses from the effort.  A few moments later her cock has almost shrunk down to normal size.");
            _root.MinLibido = _root.MinLibido + 0.5;
         }
         else
         {
            _root.DickgirlXF = 1;
            _root.ShowMovie(ClipDickgirl,1,1,1);
            _root.AddText("#slave basks in the feelings of radiance and confidence that the potion imbues her with.  And yet she feels something else stirring within her...lust.  She gasps as her pussy moistens and her clit rubs against her panties.  She struggles to cover up her groin as she feels her clit continuing to enlarge!  #assistant demands #slave show what happened to her, and #slave reluctantly agrees.\r\r#slave is now a hermaphrodite.");
            _root.MinLibido = _root.MinLibido + 5;
         }
         _root.CustomFlag3 = _root.CustomFlag3 + 0.5;
         _root.Points(3,2,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,2);
      }
      return true;
   }
   if(_root.NumEvent == 310)
   {
      if(_root.CustomFlag4 < 2)
      {
         _root.PersonSpeak("Faerie Trader","I\'m sorry but you haven\'t enough milk for any of my items.",true);
      }
      else
      {
         _root.HideImages();
         _root.CustomFlag4 = _root.CustomFlag4 - 2;
         _root.AddText("#slave purchases the potion for two milk bottles, then drinks it somewhat hesitantly.\r\r");
         _root.ShowMovie(FaerieClip,1,1,3);
         _root.AddText("#slave begins to think more clearly.  ");
         if(_root.CustomFlag3 > 5 && _root.IsDickgirl())
         {
            _root.AddText("She mentions that her dick isn\'t quite as big anymore. Is that disappointment on her face?  ");
         }
         if(_root.CustomFlag > 5)
         {
            _root.AddText("Her breasts seem to be smaller too, perhaps closer to her normal size.");
         }
         bustchange = -5;
         if(_root.CustomFlag + bustchange < 0)
         {
            bustchange = -1 * _root.CustomFlag;
         }
         cockchange = -5;
         if(_root.CustomFlag3 + cockchange < 0)
         {
            cockchange = -1 * _root.CustomFlag3;
         }
         lactationchange = -5;
         if(_root.Lactation + lactationchange < 0)
         {
            lactationchange = -1 * _root.Lactation;
         }
         _root.ChangeBustSize((90 + _root.CustomFlag + bustchange) / (90 + _root.CustomFlag));
         if(_root.IsDickgirl)
         {
            _root.ChangeClitCockSize((12 + _root.CustomFlag3 + cockchange) / (12 + _root.CustomFlag3));
         }
         _root.CustomFlag = _root.CustomFlag + bustchange;
         _root.CustomFlag3 = _root.CustomFlag3 + cockchange;
         _root.Lactation = _root.Lactation + lactationchange;
         _root.MinLibido = _root.MinLibido - 20;
         _root.Points(0,-3,5,5,0,0,0,0,0,0,0,0,-15,0,-50,0,0,0,0,-5);
      }
      return true;
   }
   if(_root.NumEvent == 311)
   {
      if(_root.CheckBitFlag2(12))
      {
         _root.PersonSpeak("Faerie Trader","I\'m sorry but I already sold you that.",true);
      }
      if(_root.CustomFlag4 < 2)
      {
         _root.PersonSpeak("Faerie Trader","I\'m sorry but you haven\'t enough milk for any of my items.",true);
      }
      else if(!_root.CheckBitFlag2(12))
      {
         _root.HideImages();
         _root.CustomFlag4 = _root.CustomFlag4 - 2;
         _root.AddText("#slave purchases the milk machine for two bottles, after watching the Faerie\'s assistant give a demonstration on its proper use.\r\r");
         _root.ShowMovie(FaerieClip,1,1,5);
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0.5,0,0.5,0,0,0,0,1);
         _root.SetBitFlag2(12);
         _root.ShowCustomSexAct(2);
      }
      return true;
   }
   if(_root.NumEvent == 312)
   {
      if(_root.CustomFlag2 < 2)
      {
         _root.PersonSpeak("Daemonica","You don\'t have enough cum for my services! BEGONE!",true);
      }
      else
      {
         _root.HideImages();
         _root.ShowMovie(FaerieClip,1,1,6);
         _root.AddText("The demon snaps her fingers and a topless cowgirl gives #slave a bottle of milk.  It smells very rich.\r\r");
         if(_root.MilkInfluence > 0 || _root.Lactation >= 30 || _root.CustomFlag > 14.9)
         {
            _root.AddText("Small damp spots appear on #slave\'s chest as she is given the milk. She blushes.\r\r");
         }
         _root.CustomFlag4 = _root.CustomFlag4 + 1;
         _root.CustomFlag2 = _root.CustomFlag2 - 2;
      }
      return true;
   }
   if(_root.NumEvent == 313)
   {
      if(_root.CheckBitFlag2(14))
      {
         _root.PersonSpeak("Daemonica","No, you may not have another.",true);
      }
      if(_root.CustomFlag2 < 2)
      {
         _root.PersonSpeak("Daemonica","You don\'t have enough cum for my services! BEGONE!",true);
      }
      else if(!_root.CheckBitFlag2(14))
      {
         _root.HideImages();
         _root.ShowMovie(FaerieClip,1,1,7);
         _root.AddText("The demoness gestures to a servant and she spreads her legs, revealing the potion.  #slave reluctantly retrieves it, much to the enjoyment of the slavegirl.\r\r");
         _root.PersonSpeak("Daemonica","Do be careful with that. Imbibing that will make your cum addictive to the next person who drinks it.",true);
         _root.AddText("\r\r");
         if(!_root.Supervise)
         {
            if(_root.CheckBitFlag2(9))
            {
               _root.ServantSpeak("You will not use that on our " + _root.Master + "!  All your heavenly cum is mine!",true);
            }
            else
            {
               _root.ServantSpeak("I will not allow you to use that around our master!",true);
            }
         }
         _root.SetBitFlag2(14);
         _root.CustomFlag2 = _root.CustomFlag2 - 2;
      }
      return true;
   }
   if(_root.NumEvent == 314)
   {
      if(_root.CheckBitFlag2(15))
      {
         _root.PersonSpeak("Daemonica","No, you may not have another.",true);
      }
      if(_root.CustomFlag2 < 2)
      {
         _root.PersonSpeak("Daemonica","You don\'t have enough cum for my services! BEGONE!",true);
      }
      else if(!_root.CheckBitFlag2(15))
      {
         _root.HideImages();
         _root.ShowMovie(FaerieClip,1,1,9);
         _root.AddText("A young demon presents the bottle to #slave.\r\r");
         _root.PersonSpeak("Daemonica","Do be careful with that. If you use it you will become irresistable to monsters.",true);
         _root.AddText("\r\r");
         if(!_root.Supervise)
         {
            _root.ServantSpeak("That sounds like more danger than we need.",true);
         }
         _root.SetBitFlag2(15);
         _root.CustomFlag2 = _root.CustomFlag2 - 2;
      }
      return true;
   }
   if(_root.NumEvent == 315)
   {
      if(_root.CheckBitFlag2(13))
      {
         _root.PersonSpeak("Daemonica","No, you may not have another.",true);
      }
      if(_root.CustomFlag2 < 2)
      {
         _root.PersonSpeak("Daemonica","You don\'t have enough cum for my services! BEGONE!",true);
      }
      else if(!_root.CheckBitFlag2(13))
      {
         _root.HideImages();
         _root.ShowMovie(FaerieClip,1,1,10);
         _root.AddText("A slave pulls free of a machine you had not noticed, and prepares it for transport.\r\r");
         _root.PersonSpeak("Daemonica","You are lucky to have such a device, I believe it is extra-dimensional in origin.",true);
         if(_root.IsDickgirl())
         {
            _root.AddText("\r\r#slave becomes firmly erect.");
         }
         _root.SetBitFlag2(13);
         _root.ShowCustomSexAct(2);
         _root.CustomFlag2 = _root.CustomFlag2 - 2;
      }
      return true;
   }
   if(_root.NumEvent == 316)
   {
      if(_root.IsDressOwned(5))
      {
         _root.PersonSpeak("Daemonica","No, you may not have another.",true);
      }
      if(_root.CustomFlag2 < 2)
      {
         _root.PersonSpeak("Daemonica","You don\'t have enough cum for my services! BEGONE!",true);
      }
      else if(!_root.IsDressOwned(5))
      {
         _root.AddText("#slave is given a skimpy outfit with hearts for breast-cups.  The material shimmers in a most entrancing way.\r\r");
         if(_root.VarLibidoRounded + _root.VarNymphomaniaRounded > 80 || _root.CustomFlag > 13)
         {
            if(_root.Supervise)
            {
               _root.SlaveSpeak("Don\'t you think I would look sexy in this, #supername?",true);
            }
            else
            {
               _root.SlaveSpeak("Don\'t you think I would look sexy in this #assistant?",true);
               _root.AddText("\r\r#assistant blushes and nods weakly.");
            }
         }
         else
         {
            _root.SlaveSpeak("There is something wrong with this dress.  I would prefer I didn\'t wear it.",true);
            _root.AddText("\r\rDaemonica looks on and smirks.\r\r");
         }
         _root.SetDressOwned(5);
         _root.CustomFlag2 = _root.CustomFlag2 - 2;
      }
      return true;
   }
   if(_root.NumEvent == 317)
   {
      if(_root.CustomFlag4 < 1)
      {
         _root.HideImages();
         _root.ShowMovie(ClipLoveRefused,1,1,1);
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0);
         _root.AddText("#slave rests since she doesn\'t have any milk. The break refreshes her.");
      }
      else
      {
         _root.ShowMovie(FaerieClip,1,1,11);
         _root.AddText("#slave retrieves a bottle of milk from her personal items.  She opens it and a rich creamy aroma fills the air.  ");
         if(_root.CustomFlag < 6)
         {
            _root.AddText("#slave drinks the bottle slowly, enjoying the unusual taste. ");
         }
         if(_root.CustomFlag > 5.9 && _root.CustomFlag < 13)
         {
            _root.AddText("#slave enjoys the strange milk, finishing it quickly.  ");
         }
         if(_root.CustomFlag > 12.9 && _root.CustomFlag < 20)
         {
            _root.AddText("#slave drinks the bottle overly quickly, dribbling milk onto herself to conceal her own leaking nipples.");
         }
         if(_root.CustomFlag > 19.9)
         {
            _root.AddText("#slave chugs the bottle messily.  Her top is soaked with milk from her rapidly lactating nipples.");
         }
         _root.Points(0,0,0,-0.5,0,0,0,0,0,0,0,0,1,0,1,0,-2.5,1,0,3);
         _root.MinLibido = _root.MinLibido + 0.5;
         _root.CustomFlag = _root.CustomFlag + 0.5;
         if(_root.CustomFlag >= 13 && _root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         else
         {
            _root.Lactation = _root.Lactation + 1;
         }
         _root.CustomFlag4 = _root.CustomFlag4 - 1;
      }
      return true;
   }
   if(_root.NumEvent == 318)
   {
      if(_root.CustomFlag2 < 1)
      {
         _root.HideImages();
         _root.ShowMovie(ClipLoveRefused,1,1,1);
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0);
         _root.AddText("#slave rests since she doesn\'t have any bottled cum. The break refreshes her.");
      }
      else
      {
         _root.ShowMovie(FaerieClip,1,1,11);
         _root.AddText("#slave gets a bottle of cum she saved.  ");
         if(_root.CustomFlag3 < 6)
         {
            _root.AddText("She swallows slowly, uncomfortable with the texture. ");
         }
         if(_root.CustomFlag3 >= 6 && _root.CustomFlag3 < 13)
         {
            _root.AddText("She drinks the bottle, blushing nervously from the strange drink.  #assistant comments on how visible #slave\'s nipples have become.");
         }
         if(_root.CustomFlag3 >= 13 && _root.CustomFlag3 < 20)
         {
            _root.AddText("She slurps noisily at the drink while one hand begins playing with her nipple.  #slave sets the bottom down and sighs forlornly, blushing when she realizes what she was doing.");
         }
         if(_root.CustomFlag3 >= 20)
         {
            _root.AddText("She gulps down the stuff with obvious enjoyment.  She is sure to spill some over her large bust.  #slave makes a show of cleaning it up, slowly licking sticky cum off her fingers.");
         }
         _root.Points(0,1,0,0,-1,0,0,0,0,0,0,0,2,0,2,0,-1,0,0,5);
         _root.MinLibido = _root.MinLibido + 1;
         _root.CustomFlag3 = _root.CustomFlag3 + 0.7;
         _root.CustomFlag2 = _root.CustomFlag2 - 1;
         if(_root.IsDickgirl())
         {
            if(_root.VarLibidoRounded < 35)
            {
               _root.AddText("\r\rAn obvious bulge appears below #slave\'s waist.");
            }
            if(_root.CustomFlag3 < 13)
            {
               _root.AddText("\r\r#assistant stares at the trembling bulge in #slave\'s dress.");
            }
            if(_root.CustomFlag3 >= 13 && _root.CustomFlag3 < 20)
            {
               _root.AddText("\r\r#assistant lusts after #slave\'s massive bulge.  Since the drink it has become even more engorged, seeming to twitch with a life all its own.  #assistant licks her lips and looks away.");
            }
            if(_root.CustomFlag3 >= 20)
            {
               _root.AddText("\r\r#assistant\'s eyes widen as #slave\'s massive manhood fills out, slipping free of her clothes and growing erect between her breasts.  It twitches with #slave\'s heartbeat, a dollop of precum forming at the tip.  #assistant licks her lips.");
            }
         }
      }
      return true;
   }
   if(_root.NumEvent == 319)
   {
      if(!_root.CheckBitFlag2(15))
      {
         _root.HideImages();
         _root.ShowMovie(ClipLoveRefused,1,1,1);
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0);
         _root.AddText("#slave rests since she has no such potion.");
      }
      else
      {
         _root.ShowMovie(FaerieClip,1,1,13);
         _root.AddText("#slave uncorks the strange bottle and a dizzying musky smell emerges.  ");
         _root.AddText("The bottle contains little of the liquid. She carefully pours it on to her skin and the aroma permeates the room.  In seconds the fluid is gone - absorbed into her skin.\r\r");
         if(_root.Talent == 14 || _root.Talent == 19 || _root.SMSpecialEvent == 2 || _root.SMSpecialEvent == 3)
         {
            _root.AddText("The scent is familiar and intense.  You struggle not to succumb to the arousal it triggers in your body.  ");
            if(_root.Gender == 1 || _root.Gender == 3)
            {
               _root.AddText("Your cock twitches with a life all it\'s own as you breathe deeply of the scent.  ");
            }
            if(_root.Gender == 2 || _root.Gender == 3)
            {
               _root.AddText("Pussy juice dribbles down your leg as lust for inhuman cocks rises within you.  ");
            }
            _root.SMPoints(0,0,0,0,0,25,0,0);
         }
         if(_root.Talent == 4 || _root.Talent == 10 || _root.SMSpecialEvent == 5 || _root.SMSpecialEvent == 6)
         {
            _root.AddText("You are surprised to find yourself getting harder from the scent.  Something inhuman within you is responding to that...enticing smell.  The desire to force yourself on #slave is immense, but you resist...for now.  ");
            _root.SMPoints(0,0,0,0,0,20,0,0);
         }
         _root.Points(2,0.5,0,0,-1,0,0,0,0,0,0,0,0,0,2,0,0,0,0,1);
         _root.ClearBitFlag2(15);
         if(_root.TotalTentacle > 4)
         {
            _root.AddText("\r\rMemories of all the times she has been raped by tentacles flood #slave\'s mind.  She sinks to the floor and masturbates as she loses herself in the memories.  It takes nearly an hour for you and #assistant to get her calm down and stop masturbating.");
            _root.Points(0,0,0,0,-1,0,0,0,0,0,0,0,0,0,15,0,0,0,0,1);
         }
         _root.SetBitFlag2(16);
      }
      _root.ShowPlanningNext();
      return true;
   }
   if(_root.NumEvent == 320)
   {
      if(!_root.CheckBitFlag2(14) || _root.CheckBitFlag2(9))
      {
         _root.HideImages();
         _root.ShowMovie(ClipLoveRefused,1,1,1);
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0);
         if(!_root.CheckBitFlag2(14))
         {
            _root.AddText("#slave does not have that potion, so she rests.");
         }
         if(!_root.CheckBitFlag2(9))
         {
            _root.SlaveSpeak("I promised not to use that around you again!");
         }
      }
      else
      {
         _root.ClearBitFlag2(14);
         _root.ShowMovie(FaerieClip,1,1,14);
         _root.AddText("#slave imbibes the potion, her pussy moistening in wicked anticipation.  Her eyes lock on to you, fixing you in their predatory gaze ");
         if(_root.IsDickgirl())
         {
            _root.AddText(" as her cock becomes fully engorged.  Drops of precum splatter on the floor as she begins sashaying towards you. ");
         }
         else
         {
            _root.AddText(" as girlcum drips down her thighs to the floor.  ");
         }
         _root.AddText("\r\rIn a flash you are on your back, her ");
         if(_root.IsDickgirl())
         {
            _root.AddText("dribbling cock poised above you.  #slave\'s grip seems to be getting stronger, your strength is leaving you!  Her warm cock slides easily into your unresisting mouth, sliding down your throat as you find yourself beginning to anticipate her cum.  Her cock begins vigorously fucking your mouth, her balls swelling each time they slap against you.  Perhaps addiction won\'t be so bad you muse?\r\r");
         }
         else
         {
            _root.AddText("glistening pussy poised for oral.  #slave holds you down, her touch exciting and draining at the same time.  Your muscles quickly stop fighting her,  your tongue parts your lips to begin licking her nether-lips.  #slave\'s juices flow freely as you pleasure her against your will.  Her orgasm nears, your bodies enthusiastic efforts having an effect.  You ponder what being addicted to her cum will be like...\r\r");
         }
         if(_root.BadEndsOn && int(Math.random() * 2 < 1))
         {
            if(_root.IsDickgirl())
            {
               _root.AddText("Gobs of cum pour from her cock into your throat, despite your frantic efforts to make your body obey you.  Her orgasm drags on as more of her devilish...no delicious--wonderful cum pours into you.  You milk her cock with your throat, eager to get more.  You shiver with delight and a little bit of sorrow knowing her orgasm is almost over.\r\r#slave pulls her cock from your mouth looking drained and a little dizzy, and you take the opportunitly to begin licking her back to full arousal... You\'ve just got to get more of that cum...");
            }
            else
            {
               _root.AddText("Your tongue proves to be talented - if disobediant - as it licks #slave\'s clit mercilessly.  She presses her pussy lips against your mouth and cums, drizzling out a steady flow of her wonderful nectar.  It seems so...right to be here, serving this wonderful pussy.  Why would you resist this, your mind wonders as your tongue laps at her innermost regions.  It is so right to be licking #slave\'s pussy...so right.  You need to make her cum more...");
            }
            _root.SetBitFlag2(17);
         }
         else
         {
            _root.AddText(_root.ServantName + " tackles a very surprised looking #slave off of you!  They come to a stop on the floor as their gazes lock, something seems to pass between them.\r\r");
            if(_root.IsDickgirl())
            {
               _root.AddText("#slave suddenly loses control and begins cumming, spraying jizz into the air.  To your shock, #assistant latches onto the cock, swallowing each powerful burst of seed with a dazed expression.  #slave\'s orgasm seems to go on for minutes, with " + _root.ServantName + " happily swallowing it all.  When you finally pry the two apart, it is difficult to keep your assistant from pleasuring #slave.\r\r");
            }
            else
            {
               _root.AddText(_root.ServantName + " kneels before #slave with a dazed expression, licking at the slave\'s puffy labia. She is nearly instantly rewarded with a spray of girlcum straight into her mouth.  #assistant seems confused for a moment, but hungrily latches on to #slave\'s pussy, drinking and pleasuring her new goddess in equal measure.   It is some time before you can seperate the two girls, #assistant\'s face is covered in pussy juices.  It will be difficult to keep them apart.\r\r");
            }
            _root.SlaveSpeak("I am sorry!  I lost control of myself when I drank that potion, and it will NOT happen again.",true);
            _root.AddText("\r\rIt is difficult to tell if she is sincere, or if #assistant will recover.");
            _root.CustomFlag = _root.CustomFlag + 0.1;
            if(_root.IsDickgirl())
            {
               _root.CustomFlag3 = _root.CustomFlag3 + 0.1;
            }
            _root.SetBitFlag2(9);
         }
      }
      _root.ShowPlanningNext();
      return true;
   }
   if(_root.NumEvent == 306)
   {
      _root.ShowMovie(CowEventClip,1,1,12);
      _root.AddText("#slave sees one of Bess\'s used vibrators.  She fights an internal battle before losing and taking the sodden vibrator for herself.  She puts the large studded vibrator in her pack, but not before sniffing the heady aroma of Bess\'s honey.");
      _root.DildoOK = 1;
      _root.SetBitFlag2(8);
      return true;
   }
   if(_root.NumEvent == 303)
   {
      _root.HideImages();
      _root.ShowMovie(CowEventClip,1,1,2);
      _root.AddText("#slave goes for the milking cups but stops when she sees a huge vibrator leaning on the machine.  It smells of Bess\' heavy musk, as if it has been used VERY recently.  #slave ignores it for now and hooks up the cups to Bess\' heavy breasts.  Bess groans and blushes but smiles happily at her.  #slave responds by flipping the activation switch. Milk begins flowing steadily into the machine from Bess.\r\r");
      _root.AddText("The cowgirl moans and pushes back as #slave forces the vibrator into her cunt.  She squeezes her breasts and cums, milking out a few huge eruptions of milk.  Bess\' tits continue dribbling out plenty of milk as she slowly recovers. #slave unhooks the musky vibrator. It slides out slowly to flop about on the floor.  The heavy scent of her cum is thick in the air.\r\r");
      if(int(Math.random() * 6 < (!_root.CheckBitFlag2(0)?0:1) + _root.CustomFlag4) && _root.VarSpecialRounded > 30 && !_root.CheckBitFlag2(3))
      {
         _root.SetBitFlag2(3);
         _root.AddText("#slave feels her Magic begging to be released.  It is as if every single drop of her magic is begging to pour into this girl.  Does she invoke her magic on Bess?");
         _root.DoYesNoEventXY(304);
         return true;
      }
      if(_root.CustomFlag4 < 5)
      {
         _root.AddText("#slave flushes with arousal as she unhooks Bess and takes the bottle.  ");
         _root.CustomFlag4 = _root.CustomFlag4 + 1;
         _root.Points(0,1,0,-0.25,0,0,0,0,0.5,0,0,2,1,0,1,0,0.5,1,0,3);
      }
      else
      {
         _root.AddText("#slave flushes with arousal as she unhooks Bess.  She takes the milk bottle and greedily swallows it all.  ");
         if(_root.CustomFlag < 6)
         {
            _root.AddText("#slave hopes the milk isn\'t affecting her. ");
         }
         if(_root.CustomFlag > 5.9 && _root.CustomFlag < 13)
         {
            _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.  ");
         }
         if(_root.CustomFlag > 12.9 && _root.CustomFlag < 20)
         {
            _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.  ");
         }
         if(_root.CustomFlag > 19.9)
         {
            _root.AddText("#slave yanks down her top and marvels at the size of her tits.  Dribbles of milk already run from her engorged nipples.  She pants lustily and attaches the milk machine to her own breasts.  She cums nearly immediately as the pumps try to keep up with the flow of milk....\r\rNearly an hour later a tired looking #slave leaves.");
         }
         _root.Points(0,1,0,-1,0,0,0,0,0.5,0,0,2,1,0,3,0,0.5,1,0,5);
         _root.MinLibido = _root.MinLibido + 0.5;
         _root.CustomFlag = _root.CustomFlag + 0.5;
         if(_root.CustomFlag >= 13 && _root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         else
         {
            _root.Lactation = _root.Lactation + 1;
         }
      }
      return true;
   }
   if(_root.NumEvent == 302)
   {
      _root.AddText(_root.ServantName + " looks a little jealous when the two milk-soaked girls manage to stumble from the barn.  ");
      _root.CustomFlag = _root.CustomFlag + 1;
      if(_root.CustomFlag >= 12.9 && _root.Lactation < 30)
      {
         _root.Lactation = 30;
      }
      else
      {
         _root.Lactation = _root.Lactation + 2;
      }
      if(_root.CustomFlag4 < 5)
      {
         _root.CustomFlag4 = _root.CustomFlag4 + 1;
         _root.AddText("#slave pockets a large jug of milk she brought with her from the barn.  ");
      }
      if(_root.CustomFlag > 5 && _root.CustomFlag < 21)
      {
         _root.AddText("#slave feels her nipples slowly leaking milk under her shirt.  She is thankful #assistant doesn\'t notice.  ");
      }
      if(_root.CustomFlag > 20)
      {
         _root.AddText("#slave feels her swollen breasts and realizes she is steadily dribbling milk.  She is thankful #assistant can\'t distinguish it from Bess\' milk.  ");
      }
      _root.AddText("\r\r");
      _root.PersonSpeak("Bess","The milking was incredible. I hope we get to do this again!",true);
      _root.Points(1,1,0,1,0,0,0,1,1,0,0,2,3,0,3,0,5,3,0,-30);
      _root.CustomFlag4 = _root.CustomFlag4 + 1;
      _root.SetBitFlag2(2);
      return true;
   }
   if(_root.NumEvent == 300)
   {
      if(_root.CustomFlag1 > 8)
      {
         _root.ShowMovie(BreakClip,1,1,12);
         if(_root.Gender == 1 || _root.Gender == 3)
         {
            _root.AddText("You awake to find #slave washing you off. The cum is gone!\r\r");
            _root.SlaveSpeak("I hope you didn\'t mind our fun. I think we both needed the release, don\'t you?",true);
            _root.AddText("\r\rShe grabs a pack of cleaning supplies as she leaves the room.");
            _root.Points(0,2,0,0,0,0,0,0,0,0,4,3,3,-3,2,0,14,3,2,-10);
            _root.SMPoints(0,-1,0,0.5,-0.5,-15,2,0);
            _root.MinLibido = _root.MinLibido + 0.5;
            _root.CustomFlag2 = _root.CustomFlag2 + 1;
         }
         else
         {
            _root.AddText("You awake to find #slave washing the sheets. The milk is gone!\r\r");
            _root.SlaveSpeak("Thank you very much " + _root.SlaveMakerName + ".  I hope you\'ll let me do this again soon.",true);
            _root.AddText("\r\r#slave picks up a bag of cleaning supplies as she leaves.");
            _root.Points(0,2,0,0,0,0,0,0,0,0,4,3,3,-3,2,0,14,3,2,-10);
            _root.SMPoints(0,-1,0,0.5,-0.5,-15,2,0);
            _root.MinLibido = _root.MinLibido + 0.5;
            if(_root.CustomFlag4 < 5)
            {
               _root.CustomFlag4 = _root.CustomFlag4 + 1;
            }
         }
      }
      else if(_root.Gender == 1 || _root.Gender == 3)
      {
         _root.ShowMovie(BreakClip,1,1,6);
         _root.AddText("When you come to Yuffie is gone!  #slave and Tifa are resting peacefully, worn out from their own exertions. Your mouth is filled with the taste of pussy and your dick seems to be hard again. It might even be a tiny bit bigger? \r\r");
         _root.Points(0,2,-2,0,0,0,0,0,0,4,0,3,2,-1,5,0,11,3,1,-10);
         _root.SMPoints(0,0,5,0.5,-1.5,4,0,0);
         _root.MinLibido = _root.MinLibido + 1.5;
      }
      else
      {
         _root.ShowMovie(BreakClip,1,1,7);
         _root.AddText("You awaken to the sound of #slave\' moans. She must have taken whatever pill she slipped you and is now lost to her lusts.  #slave is covered from head to toe in pussy juices, though you aren\'t sure how much is your own.\r\rYou feel as if you should punish her, but it felt VERY good.");
         _root.Points(0,2,-2,-3,0,0,0,0,0,2,2,2,4,-2,5,0,11,3,0.5,-10);
         _root.SMPoints(0,0,5,0,-2,4,0,0);
         _root.MinLibido = _root.MinLibido + 2.5;
      }
      _root.Slutiness = _root.Slutiness + 0.25;
      _root.CustomFlag = _root.CustomFlag + 0.5;
      if(_root.CustomFlag >= 13 && _root.Lactation < 30)
      {
         _root.Lactation = 30;
      }
      else
      {
         _root.Lactation = _root.Lactation + 1;
      }
      if(_root.IsDickgirl())
      {
         _root.CustomFlag3 = _root.CustomFlag3 + 0.5;
      }
      _root.CustomFlag1 = _root.CustomFlag1 + 1;
      return true;
   }
   if(_root.NumEvent == 322)
   {
      _root.ShowLeaveButton();
      if(_root.CustomFlag >= 20 && _root.CheckBitFlag2(47) && !_root.CheckBitFlag2(48))
      {
         if(_root.IsDickgirl())
         {
            _root.ShowMovie(MasturbateClip,1,1,11);
            _root.AddText("You step into #slave\'s room, following the sounds of her passionate moans.  She is sprawled on the bed, jacking on a cock that would look at home on a horse.  Ropes of precum are pouring from her prick, slicking her hands as they pump her manhood.  She smiles at you and cums powerfully, nipples spraying milk everywhere from mountainous tits, cock spurting her cum wildly into the air.  She licks her lips sensually.\r\r");
            _root.SlaveSpeak("Mmmm I wondered when you were going to show up.  Would you like to fuck me?  Or you could keep my cock company...");
            if(_root.VarLibidoRounded >= 80 && _root.SMDominance < 30)
            {
               if(_root.Gender == 1)
               {
                  _root.AddText("\r\rYour cock surges to an achingly erect state in seconds.  She smiles at the massive bulge in your trousers and crooks her finger with a \'come hither\' motion.  You eagerly come over to her, and she gestures for you to lay down.  #slave\'s hands stroke you as she begins to straddle you, guiding your cock into her sex.  Your body aches to fuck her, but any time your hips move she stops you.   Her hips expertly grind your cock as she bends forward, offering her milk engorged tits to your eager mouth.  You cum as you drink her milk, an orgasm that lasts and lasts, leaving you still erect and horny when you finally finish.  She fucks you for most of the morning, eventually dismounting you near noon, leaving you horny and covered in milk and cum.  ");
                  _root.AddText("As you rise, you feel a soreness and a slickness dribbling down your cheeks.  Hazy memories of her inserting a plug connected to her cock offer the only explanation.");
               }
               else
               {
                  _root.AddText("\r\rYour pussy is so wet and aching to be penetrated.  You shed your clothes without a second thought and bend over to present your needy cunt, looking over your shoulder seductively.  She rouses from her place on the bed to press her cocktip against your moist fuckhole, teasing you as she slowly penetrates your wet cunt.  #slave\'s member stretches you delightfully as you she fucks you hard.  You moan like a wanton slut and cum hard");
                  if(_root.Gender == 3)
                  {
                     _root.AddText(", your cock spewing a massive a load onto the bed");
                  }
                  _root.AddText(".\r\rShe fucks you hard, bringing you to many orgasms as she pours your cum-hole full of your seed.  Sometime later you realize it is nearly noon, and #slave helps you into a pair of leather panties.  After all, a slut shouldn\'t waste all that cum in her.");
               }
               _root.CustomFlag1 = _root.CustomFlag1 + 1;
               _root.SMPoints(0,0,0,0.5,0,-20,0,0,-5);
               _root.SMMinLust = _root.SMMinLust + 2;
               _root.Points(0,0,-1,-1,-1,1,0,0,0,0,3,5,3,-1,-10,0,5,-25,0,0);
               _root.MinLibido = _root.MinLibido + 1;
               _root.AddTime(4);
               return true;
            }
            _root.AddText("\rYour body responds to her display, but you insist that it is time for her morning training - there is plenty of time for sex come nightfall.");
         }
         else
         {
            _root.ShowMovie(MasturbateClip,1,1,6);
            _root.AddText("You step into #slave\'s room, following the sounds of her passionate moans.  She is sprawled on the bed, legs akimbo, hand buried to her wrist in her sopping snatch.  Her other hand is expressing fountains of milk from her massive breasts.  She cums visibly, locking her gaze with yours as her shudders and creams itself.\r\r");
            _root.SlaveSpeak(_root.Master + ", would you fuck?  I\'ve gotten myself ready for you...",true);
            if(_root.VarLibidoRounded >= 80 && _root.SMDominance < 30)
            {
               if(_root.Gender == 1)
               {
                  _root.AddText("\r\rYour cock surges to an achingly erect state in seconds.  She smiles at the massive bulge in your trousers and crooks her finger with a \'come hither\' motion.  You eagerly come over to her, and she gestures for you to lay down.  #slave\'s hands stroke you as she begins to straddle you, guiding your cock into her sex.  Your body aches to fuck her, but any time your hips move she stops you.   Her hips expertly grind your cock as she bends forward, offering her milk engorged tits to your eager mouth.  You cum as you drink her milk, an orgasm that lasts and lasts, yet you\'re still erect and horny when you finally finish.  She fucks you for most of the morning, eventually dismounting you near noon, leaving you horny and covered in milk.");
               }
               else
               {
                  _root.AddText("\r\rThe sopping wetness of your instantly slick cunt refuses to be ignored, and you find yourself 69\'ing her in bed, your tongue burying itself in her honeypot, and quickly being rewarded with her sweet cum.  #slave\'s own tongue penetrates your sex expertly, as she rolls you onto your back.  Her tongue licks your clitty, sending you into a mind-shattering orgasm.\r\rYou dully feel something long and hard sliding into your sex.  #slave is feeding a massive double-sided dildo into your slickened sex.  The strength goes out of your legs as she begins to fuck you with it.  In moments a nipple is in your mouth and you are suckling happily, feeling utterly submissive and happily pleasuring the girl who is supposed to be your slave.");
                  _root.AddText("\r\rEventually you realize the pleasure has stopped, and it is nearly noon.  You start to rise and feel stiff, looking down, you see the dildo bent double to penetrate both your openings.   You nearly orgasm trying to remove it, but eventually pull it free.");
                  if(_root.Gender == 3)
                  {
                     _root.AddText(" You nearly step on a large balloon filled with your cum.  Hazy memories of her slipping it over your cock earlier that morning offer the only explanation.");
                  }
               }
               _root.CustomFlag1 = _root.CustomFlag1 + 1;
               _root.SMPoints(0,0,0,0.5,0,-20,0,0,-5);
               _root.SMMinLust = _root.SMMinLust + 2;
               _root.Points(0,0,-1,-1,-1,1,0,0,0,0,3,5,3,-1,-10,0,5,-25,0,0);
               _root.MinLibido = _root.MinLibido + 1;
               _root.AddTime(4);
               return true;
            }
            _root.AddText("\rYour body responds to her display, but you insist that it is time for her morning training - there is plenty of time for sex come nightfall.");
         }
         _root.Points(0,0,-0.5,-0.2,-1,1,0,0,0,0,3,5,3,0,-10,0,1,0,0,0);
         _root.MinLibido = _root.MinLibido + 1;
         _root.SetBitFlag2(48);
      }
      else if(_root.CustomFlag >= 13 && _root.CheckBitFlag2(46) && !_root.CheckBitFlag2(47))
      {
         if(_root.IsDickgirl())
         {
            _root.ShowMovie(MasturbateClip,1,1,9);
            _root.AddText("#slave\'s behavior is starting to worry you.  She hasn\'t slept, and has masturbated since you left her last night.  The whole room stinks of her sex and cum.  She looks vibrant and happy despite her lack of sleep, covered with cum, and with milk pooling in generous puddles around her tits.\r\r");
            _root.SlaveSpeak("Did you come back to fuck some more?  I don\'t know why I haven\'t noticed before, but I was looking at my cock and tits...and they feel sooo much bigger and I just HAD to play with them some more.  They feel grreeeeaaat.",true);
            _root.AddText("\rShe\'s correct, her tits and cock have definitely grown larger. #slave is well endowed, even by hermaphrodite standards.  Maybe a <b>seer</b> could tell you what is affecting her?");
         }
         else
         {
            _root.ShowMovie(MasturbateClip,1,1,5);
            _root.AddText("#slave is starting to worry you. She\'s been up all night frigging her pussy, tweaking her clit and nipples, and squirting milk everywhere.  Her sheets are soaked, her large jugs dribbling fresh milk.\r\r");
            _root.SlaveSpeak("Did you come back to fuck some more?  I don\'t know why I haven\'t noticed before, but I was looking at my tits...and they feel sooo much bigger and I just HAD to play with them some more.  They feel grreeeeaaat.",true);
            _root.AddText("\rShe\'s correct, her tits have definitely grown larger. #slave is well endowed, almost a different girl from when you received her.  Maybe a <b>seer</b> could tell you what is affecting her?");
         }
         _root.Points(0,0,-0.5,-0.2,-1,1,0,0,0,0,3,5,3,0,-10,0,1,0,0,0);
         _root.MinLibido = _root.MinLibido + 1;
         _root.SMPoints(0,0,0,0,0,2,0,0,0);
         _root.SetBitFlag2(47);
      }
      else if(_root.CustomFlag >= 6 && _root.CheckBitFlag2(45) && !_root.CheckBitFlag2(46))
      {
         if(_root.IsDickgirl())
         {
            _root.ShowMovie(MasturbateClip,1,1,8);
            _root.AddText("#slave woke up long before you to masturbate.  You walk in on her to find a dull vacant expression on her face.  Her hands are still working her genitals hard, milking her cock with one hand, the other squeezing four fingers into her snatch.  #slave has splattered most of her body with cum, so much so that it has run off her to make small puddles in the sheets.  Strangely milk is leaking from her nipples.\r\r");
            _root.SlaveSpeak("Ahhh...my nipples keep lactating when I cum...it feels so good...is something wrong with me?",true);
            _root.AddText("You assure her that she is fine, and resolve to find out the cause.");
         }
         else
         {
            _root.ShowMovie(MasturbateClip,1,1,4);
            _root.AddText("#slave woke up early to masturbate most of the morning.  She\'s dazed, looking up at you dully, her hands still pleasuring her pussy and clit.  Her nipples are shiny and erect, wet with something.\r\r");
            _root.SlaveSpeak("...something\'s wrong with my-my nipples...they keep squirting...milk I think...every time I cum...",true);
            _root.AddText("\rShe isn\'t pregnant is she?  You assure her that she will be fine.");
         }
         _root.Points(0,0,-0.5,-0.2,-1,1,0,0,0,0,3,5,3,0,-10,0,1,0,0,0);
         _root.MinLibido = _root.MinLibido + 1;
         _root.SMPoints(0,0,0,0,0,2,0,0,0);
         _root.SetBitFlag2(46);
      }
      else if(!_root.CheckBitFlag2(45))
      {
         if(_root.IsDickgirl())
         {
            _root.AddText("#slave has her eyes closed, a blissful yet driven expression on her face.  Her left hand is pistoning her cock mercilessly as her right delves the depths of her snatch.  You notice a pool of cum on her belly from a previous orgasm or orgasms.  #slave opens her eyes to see you standing there, shock on her face as she cums again, soaking the sheets and spraying cum all over herself.\r\rThe embarassment drives her to an almost full-body blush.\r");
            _root.SlaveSpeak("I...don\'t know what came over me.  I just woke up sooo horny, I couldn\'t stop myself...and...well, I still feel pretty horny now.",true);
            _root.ShowMovie(MasturbateClip,1,1,7);
         }
         else
         {
            _root.ShowMovie(MasturbateClip,1,1,3);
            _root.AddText("#slave is masturbating furiously, frigging herself on her fingers while her other hand is mercilessly grinding against her clit.  She is slick with cum, laying on a damp puddle in the sheets.  She opens her eyes as her orgasm begins, expression changing to shock as she sees you standing over her. #slave cums powerfully, hips twitching as she bites her lip to keep from crying out.\r\rA blush that covers her entire body appears from her shame.\r");
            _root.SlaveSpeak("I...don\'t know what came over me.  I woke up sooo horny, I couldn\'t stop myself...and once I started, I couldn\'t stop.   And I\'m still damp, like my...pussy...can\'t get enough.",true);
         }
         _root.Points(0,0,-0.5,-0.2,-1,1,0,0,0,0,3,5,3,0,-10,0,1,0,0,0);
         _root.MinLibido = _root.MinLibido + 1;
         _root.SMPoints(0,0,0,0,0,2,0,0,0);
         _root.SetBitFlag2(45);
      }
      return true;
   }
   if(_root.NumEvent == 301)
   {
      _root.ShowLeaveButton();
      if(!_root.CheckBitFlag2(38))
      {
         _root.SMPoints(0,0,0,0,0,_root.CustomFlag1 + 4,0,0);
         if(_root.SMMinLust < 15)
         {
            _root.SMMinLust = 15;
         }
         if(_root.Gender == 1 || _root.Gender == 3)
         {
            _root.AddText("You wake horny. Far more aroused than normal.  Your dick is unusually hard and firm. You quickly masturbate, cumming forcefully and making a much larger mess than normal!\r\rYou still feel a little more randy than normal.");
         }
         else
         {
            _root.AddText("  You wake to an unexpected wetness between your thighs. You don\'t remember having any unusual dreams but you find it difficult to resist masturbating this morning. You orgasm loudly, your fluids soaking a small area of your bed.  \r\rYou still feel a bit more aroused than normal.");
         }
         _root.SetBitFlag2(38);
         if(_root.Gender == 3)
         {
            _root.ShowMovie(EventMorningMouthfull,1,1,2);
         }
         if(_root.Gender == 1)
         {
            _root.ShowMovie(EventMorningMouthfull,1,1,5);
         }
         if(_root.Gender == 2)
         {
            _root.ShowMovie(EventMorningMouthfull,1,1,8);
         }
      }
      else
      {
         if(_root.CustomFlag1 > 18 && _root.CheckBitFlag2(40) && !_root.CheckBitFlag2(41) && _root.CustomFlag > 20)
         {
            _root.SMPoints(0,0,0,0,0,_root.CustomFlag1,0,0);
            if(_root.SMMinLust < 60)
            {
               _root.SMMinLust = 60;
            }
            if(_root.Gender == 1 || _root.Gender == 3)
            {
               if(_root.Gender == 3)
               {
                  _root.ShowMovie(EventMorningMouthfull,1,1,11);
               }
               else
               {
                  _root.ShowMovie(EventMorningMouthfull,1,1,7);
               }
               _root.AddText("You wake with difficulty breathing.  Sputtering out ribbons of a sticky substance you sit up...and discover your gigantic cock rests on your chin, leaking cum!   The sheets and your night-clothes are soaked with the stuff.  Pushing off the sheets triggers a tiny orgasm, spewing cum over your face.  ");
               if(_root.Gender == 3)
               {
                  _root.AddText("Your nipples spray milk into the air that showers down on you.  Your breasts are so heavy...larger than normal, and your nipples are pouring out small streams of breastmilk even when you aren\'t cumming!\r\rYou stagger to your feet and nearly blow another load from the sensation of having your cock trapped under your nightshirt with two large lubricated breasts.  It would be frustrating if it wasn\'t so easy--or pleasurable--to cum again...and again...and again.\r\r");
               }
               else
               {
                  _root.AddText("The small orgasm leaves you covered in your own cum, but offers no release from your enflamed desires.  Staggering to your feet almost sets you off, the sensation of air moving across your cock is exquisite agony.  It would be so easy to lay down and just enjoy this all morning. Or all day.");
               }
               _root.SlaveSpeak("I see you\'re enjoying the fruits of my magic...",true);
               _root.AddText(_root.SlaveName + " has entered your room, carefully avoiding stepping in puddles of cum.  She looks more confident than you have ever seen her.\r\r");
               _root.SlaveSpeak("I\'ve been using my magic on you without realizing it all this time! -but I\'ve learned to control it.  We can both enjoy this, fucking, sucking, cumming...  I could share my power with you.  Think of the fun we could have spreading fertility and pleasure.",true);
               _root.AddText("\r\rAs if to emphasize this, #slave touches your shoulder and a wave of pleasure knocks you off your feet.  Your world becomes pleasure as you writhe, cumming on the floor.  The orgasm drags on for what seems like forever.  When your senses return, #slave is straddling you.\r\r");
               _root.SlaveSpeak("Well? Will you become my partner and embrace my magic?",true);
               _root.DoYesNoEventXY(305);
            }
            else
            {
               _root.ShowMovie(EventMorningMouthfull,1,1,10);
               _root.AddText("Your breasts are so full and sensitive this morning!  Just pulling down the sheets seemed to send a lightning bolt from your nipples to your clit. You touch them experimentally and they start to leak a thick white substance that smells almost like cum!  Your left hand drifts to your sopping pussy and discovers your unusually large clit while your right starts milking your nipple. Your clitty must be almost an inch and a half long!  ");
               _root.AddText("You tease it and cum strongly. Your cunny is drooling steadily and your tits are spurting out cum from your insistant milking. \r\rAfter suckling your own breast-cum and orgasming for much of the morning you finally calm down. Your tits remain heavy and sensitive but your clit returns to normal size.  Your pussy seems to stay wet and ready to be fucked. You can\'t help but wonder if this has been caused by #slave, but you have no idea how to fix it.");
               _root.AddTime(4);
            }
            _root.CustomFlag1 = _root.CustomFlag1 + 0.2;
            _root.SetBitFlag2(41);
            return true;
         }
         if(_root.CustomFlag1 > 14.9 && _root.CheckBitFlag2(39) && !_root.CheckBitFlag2(40))
         {
            _root.SMPoints(0,0,0,0,0,_root.CustomFlag1,0,0);
            if(_root.SMMinLust < 50)
            {
               _root.SMMinLust = 50;
            }
            if(_root.Gender == 1 || _root.Gender == 3)
            {
               if(_root.Gender == 3)
               {
                  _root.ShowMovie(EventMorningMouthfull,1,1,4);
               }
               else
               {
                  _root.ShowMovie(EventMorningMouthfull,1,1,7);
               }
               _root.AddText("You wake exhausted from a night of erotic dreams. Pools of cum have soaked your sheets and body.  Your erection is bigger than you ever remember it.  Nearly stallion-sized, your cock is twitching with arousal and ready to blow.  ");
               if(_root.Gender == 3)
               {
                  _root.AddText("Your nipples feel like little pleasure-buzzers and leak runners of milk over your large breasts.  ");
               }
               _root.AddText("Judging by how tired your arms feel, you must have been masturbating most of the night.  Your oversized cock feels like a magnet for your hands and you drive yourself to messy orgasm after messy orgasm most of the morning.\r\rYour dick eventually returns to a more normal (but still VERY large) size, and remains erect and ready to fuck for the rest of the day.");
            }
            else
            {
               _root.ShowMovie(EventMorningMouthfull,1,1,10);
               _root.AddText("Your breasts are so full and sensitive this morning!  Just pulling down the sheets seemed to send a lightning bolt from your nipples to your clit. You touch them experimentally and they start to leak a thick white substance that smells almost like cum!  Your left hand drifts to your sopping pussy and discovers your unusually large clit while your right starts milking your nipple. Your clitty must be almost an inch and a half long!  ");
               _root.AddText("You tease it and cum strongly. Your cunny is drooling steadily and your tits are spurting out cum from your insistant milking. \r\rAfter suckling your own breast-cum and orgasming for much of the morning you finally calm down. Your tits remain heavy and sensitive but your clit returns to normal size.  Your pussy seems to stay wet and ready to be fucked. You can\'t help but wonder if this has been caused by #slave, but you have no idea how to fix it.");
            }
            _root.AddTime(4);
            _root.SetBitFlag2(40);
         }
         else if(_root.CustomFlag1 > 5.9 && _root.CheckBitFlag2(38) && !_root.CheckBitFlag2(39))
         {
            _root.SMPoints(0,0,0,0,0,_root.CustomFlag1 + 4,0,0);
            if(_root.SMMinLust < 30)
            {
               _root.SMMinLust = 30;
            }
            if(_root.Gender == 1 || _root.Gender == 3)
            {
               _root.AddText("This morning you wake to a warm slick feeling on your cock.  With a start, you realize its your own hand - lubricated with a large volume of precum!  You increase your pace as you realize you seem to be almost an inch bigger than normal and rock hard!  A ribbon of precum dribbles from the tip and the extra lubrication sets you off on a record breaking orgasm!\r\rYour dick refuses to become flaccid today.   The evening seems too far away.");
               if(_root.Gender == 3)
               {
                  _root.ShowMovie(EventMorningMouthfull,1,1,3);
               }
               else
               {
                  _root.ShowMovie(EventMorningMouthfull,1,1,6);
               }
            }
            else
            {
               _root.ShowMovie(EventMorningMouthfull,1,1,9);
               _root.AddText("You wake up with one hand buried between your aching sex and the other teasing an abnormally sensitive nipple. You pinch your nipple and huge clitty and orgasm your way to full wakefulness. \r\rYou finally calm down enough to start your day, but you smell of sex and you have a hard time not jumping the first person you see.\r\r");
            }
            _root.SetBitFlag2(39);
            _root.DoneEvent = 0;
            _root.NumEvent = 250;
            return true;
         }
      }
      return true;
   }
   if(_root.NumEvent == 340)
   {
      _root.AddText("You leave the fairy trader and continue on your way.");
      return true;
   }
   if(_root.NumEvent == 341)
   {
      _root.AddText("You leave the demon woman and continue on your way.");
      return true;
   }
   return false;
}
function AfterEventNext()
{
   if(_root.OldNumEvent == 320 && _root.CheckBitFlag2(17))
   {
      _root.DoEvent(9800);
   }
   return false;
}
function DoEventNo()
{
   if(_root.NumEvent == 301)
   {
      _root.HideImages();
      _root.ShowMovie(ClipLoveRefused,1,1,1);
      _root.AddText("She is disappointed but abides by your decision.");
      return true;
   }
   if(_root.NumEvent == 321)
   {
      _root.HideImages();
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1.5,0,0);
      _root.ShowMovie(ClipLoveRefused,1,1,1);
      _root.AddText("She is disappointed you won\'t try it.");
      return true;
   }
   if(_root.NumEvent == 305)
   {
      _root.AddText("#slave steps away with her eyes downcast and disappointed.\r\r");
      _root.SlaveSpeak("Very well, I will finish your \'training\'.  You will have to deal with <b>THAT</b>.",true);
      _root.AddText("\r\rShe gestures at your current aroused state and departs, leaving you to your desires.  ");
      if(CheckBitFlag2(9))
      {
         _root.AddText(_root.ServantName + " follows #slave in the hallway, licking her lips and anxious for her next \'dose\'.");
      }
      _root.ShowMovie(ClipLoveRefused,1,1,1);
      _root.SMPoints(0,0,0,0,0,2,0,0);
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-10,0,-10);
      return true;
   }
   if(_root.NumEvent == 300)
   {
      _root.HideImages();
      _root.SetBitFlag2(29);
      _root.AddText("#slave sighs and turns away.");
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1.5,0,0);
      _root.ShowMovie(ClipLoveRefused,1,1,1);
      return true;
   }
   if(_root.NumEvent == 302)
   {
      _root.HideImages();
      _root.Backgrounds.ShowFarm();
      _root.AddText("Bess bids you farewell and departs back to her mistress.  #slave wonders if she made the right choice.");
      _root.Points(0,2,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,-0.5,0.5,0);
      return true;
   }
   if(_root.NumEvent == 304)
   {
      _root.AddText("#slave wonders if she missed a great oppurtunity.  ");
      if(_root.CustomFlag4 < 5)
      {
         _root.AddText("#slave flushes with arousal as she unhooks Bess and takes the bottle.  ");
         _root.CustomFlag4 = _root.CustomFlag4 + 1;
         _root.Points(0,1,0,-1,0,0,0,0,0.5,0,0,2,1,0,2,0,0.5,1,0,3);
      }
      else
      {
         _root.CustomFlag = _root.CustomFlag + 0.5;
         if(_root.CustomFlag >= 13 && _root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         else
         {
            _root.Lactation = _root.Lactation + 1;
         }
         _root.AddText("#slave flushes with arousal as she unhooks Bess.  She takes the milk bottle and greedily swallows it all.  ");
         if(_root.CustomFlag < 11)
         {
            _root.AddText("#slave hopes the milk isn\'t affecting her. ");
         }
         if(_root.CustomFlag > 10 && _root.CustomFlag < 18)
         {
            _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.  ");
         }
         if(_root.CustomFlag > 17)
         {
            _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.  ");
         }
         _root.Points(0,1,0,-1,0,0,0,0,0.5,0,0,2,1,0,3,0,0.5,1,0,5);
      }
      return true;
   }
   return false;
}
function PreEvent()
{
   if(_root.CheckBitFlag2(0))
   {
      if(_root.Gender != 1)
      {
         if(_root.vitalsBustSM > vitalsBustAerisStartSM + _root.CustomFlag1)
         {
            _root.CustomFlag1 = _root.vitalsBustSM - vitalsBustAerisStartSM;
         }
      }
      if(_root.Gender != 2)
      {
         if(_root.ClitCockSizeSM > ClitCockSizeAerisStartSM + _root.CustomFlag1 / 40)
         {
            _root.CustomFlag1 = (_root.ClitCockSizeSM - ClitCockSizeAerisStartSM) * 40;
         }
         if(_root.CustomFlag1 > 25)
         {
            _root.CustomFlag1 = 25;
         }
      }
   }
   if(_root.TentaclePregnancy != 1 && (_root.CustomFlag1 > 0.7 && _root.CustomFlag1 < 6 && !_root.CheckBitFlag2(38) || _root.CustomFlag1 > 5.9 && _root.CustomFlag1 < 15 && !_root.CheckBitFlag2(39) || _root.CustomFlag1 > 14.9 && _root.CustomFlag1 < 99 && !_root.CheckBitFlag2(40) || _root.CustomFlag1 > 18 && !_root.CheckBitFlag2(41) && _root.CustomFlag > 20))
   {
      if(_root.Gender != 1 && int(_root.CustomFlag1 / 2) + vitalsBustAerisStartSM > _root.vitalsBustSM)
      {
         _root.vitalsBustSM = int(_root.CustomFlag1 / 2) + vitalsBustAerisStartSM;
         if(vitalsBustAerisStartSM > 225 && _root.vitalsBustSM > vitalsBustAerisStartSM)
         {
            _root.vitalsBustSM = vitalsBustAerisStartSM;
         }
         else if(_root.vitalsBustSM > 225)
         {
            _root.vitalsBustSM = 225;
         }
      }
      if(_root.CustomFlag1 / 40 + ClitCockSizeAerisStartSM > _root.ClitCockSizeSM)
      {
         _root.ClitCockSizeSM = _root.CustomFlag1 / 40 + ClitCockSizeAerisStartSM;
         if(ClitCockSizeAerisStartSM > 1.82 && _root.ClitCockSizeSM > ClitCockSizeAerisStartSM)
         {
            _root.ClitCockSizeSM = ClitCockSizeAerisStartSM;
         }
         else if(_root.ClitCockSizeSM > 1.82)
         {
            _root.ClitCockSizeSM = 1.82;
         }
      }
      if(_root.TentaclePregnancy > 1)
      {
         _root.TentaclePregnancy = _root.TentaclePregnancy - 1;
         _root.PregnancyGestation = _root.PregnancyGestation - 1;
      }
      _root.HideImages();
      _root.AddText("Something strange happens this morning...\r\r");
      _root.Backgrounds.ShowBedRoom();
      _root.DoEvent(301);
      if(_root.GameTime < 7)
      {
         _root.GameTime = 7;
      }
      return true;
   }
   if(_root.TentaclePregnancy != 1 && (_root.CustomFlag > 0.7 && _root.CustomFlag < 6 && !_root.CheckBitFlag2(45) || _root.CustomFlag >= 6 && _root.CustomFlag < 13 && !_root.CheckBitFlag2(46) || _root.CustomFlag >= 13 && _root.CustomFlag < 20 && !_root.CheckBitFlag2(47) || _root.CustomFlag >= 20 && _root.CustomFlag < 30 && !_root.CheckBitFlag2(48)))
   {
      if(_root.TentaclePregnancy > 1)
      {
         _root.TentaclePregnancy = _root.TentaclePregnancy - 1;
      }
      _root.HideImages();
      _root.HideSlaveActions();
      _root.SetText("#slave has awoken before you, and you catch her masturbating...\r\r");
      _root.Backgrounds.ShowBedRoom();
      _root.DoEvent(322);
      if(_root.GameTime < 7)
      {
         _root.GameTime = 7;
      }
      return true;
   }
   var _loc2_ = _root.FaeriesRingWorn * 30 + _root.NymphsTiaraWorn * 30;
   if(_root.FairyXF > 0)
   {
      _loc2_ = _loc2_ + 100;
   }
   if(_root.FairyMeeting < 5)
   {
      _loc2_ = _loc2_ + _root.FairyMeeting * 10;
   }
   if(_loc2_ > int(Math.random() * 100 + 1) && !_root.CheckBitFlag2(0))
   {
      _root.ShowMovie(FaerieClip,1,1,1);
      _root.AddText("That night #slave has an unusual dream.\r\rA beautiful faerie queen appears before her. As she meets the Queen\'s eyes her lust spikes uncontrollably. She begins desperately masturbating but can\'t look away. The Queen smiles serenely and begins speaking to the lust possesed girl.\r\r");
      _root.PersonSpeak("Faerie Queen","#slave, you have the gift of the Nymph magic. It is rare to manifest in a human and rarer still for it to lie dormant so long. You have the ability to spread lust and fertility to the world. I challenge you to do so.\r\rNow cum for me my pet, cum and embrace your potential.",true);
      _root.AddText("\r\r#slave wakes in the throes of a powerful orgasm. One of her hands is slowly stroking her ");
      if(_root.IsDickgirl())
      {
         _root.AddText("cock ");
      }
      else
      {
         _root.AddText("clit ");
      }
      _root.AddText("as she slowly comes down from it. \r\r");
      _root.PersonSpeak("Strange Whispers","Be careful, nymph magic is difficult to control at first.  You may change those around you without realizing it.",true);
      _root.AddText("\r\r#slave sits in bed, wondering about the faerie queen.  Maybe a <b>seer</b> could tell her more?");
      _root.CustomFlag = 0.2;
      _root.SetBitFlag2(0);
      _root.ShowSpecialStat("Nymph Magic :");
      _root.Points(2,2,-3,0,0,0,0,0,0,0,0,1,2,0,3,0,0,3,0,20);
      return true;
   }
   return false;
}
function DoWalkSlums(eventno)
{
   temp = _root.CustomFlag2 + 2;
   if(temp > 5)
   {
      temp = 5;
   }
   if(temp < 2)
   {
      temp = 2;
   }
   if(int(Math.random() * 100) < temp * 5)
   {
      _root.ShowMovie(FaerieClip,1,1,8);
      _root.AddText("#slave quickly becomes lost, and finds herself before a powerful demon woman!\r\r");
      _root.PersonSpeak("Daemonica","Welcome to my domain.  I brought you here because of the cum in your possession, I am willing to trade an item for two bottles of it!",true);
      _root.ResetQuestions();
      _root.AddQuestion(312,"Milk Bottle");
      _root.AddQuestion(313,"Addiction Draft");
      _root.AddQuestion(314,"Monster Musk");
      _root.AddQuestion(315,"Cock Milking Machine");
      _root.AddQuestion(316,"Novelty Bikini");
      _root.AddQuestion(341,"Nothing, leave");
      _root.ShowQuestions("What will you buy?");
      return true;
   }
   return false;
}
function DoWalkLake(eventno)
{
   temp = (!_root.CheckBitFlag2(0)?0:1) + _root.CustomFlag4 + 2;
   if(temp > 6)
   {
      temp = 6;
   }
   if(temp < 2)
   {
      temp = 2;
   }
   if(int(Math.random() * 100) < (temp - 1) * 5)
   {
      _root.PersonSpeak("Faerie Trader","Welcome to my trading post #slave!  I\'ll trade you an item for two bottles of milk!",true);
      _root.ShowMovie(FaerieClip,1,1,2);
      _root.ResetQuestions();
      _root.AddQuestion(307,"Magic Draft");
      _root.AddQuestion(308,"Cum Bottle");
      _root.AddQuestion(309,"Potion of Oberotica");
      _root.AddQuestion(310,"Inhibition Draft");
      _root.AddQuestion(311,"Milking Machine");
      _root.AddQuestion(340,"Nothing, leave");
      _root.ShowQuestions("What will you buy?");
      return true;
   }
   return false;
}
function DoWalkFarm(eventno)
{
   if(NumEvent == 7)
   {
      return false;
   }
   if(int(Math.random() * 4) == 0)
   {
      if(_root.CheckBitFlag2(0))
      {
         _root.ShowFarm();
         if(_root.CheckBitFlag2(4))
         {
            _root.ShowMovie(CowEventClip,1,1,9);
            _root.AddText("Bess motions #slave into the barn while #assistant isn\'t looking.  #slave slips in unnoticed for some time with her secret slave.\r\r");
            _root.PersonSpeak("Bess","Please milk me Mistress. I NEED release!",true);
            _root.AddText("#slave pats her randy slave\'s tits affectionately and compliments her on the new hair color. She places the milk cups on Bess\'s sensitive nipples.  It hums and begins sucking powerfully on Bess\' engorged nipples.  Her tits heave and shudder as #slave inserts the large vibrator.  Milk quickly fills the machine\'s resevoir, forcing #slave to switch the bottles.  Bess moos, moans, and slowly spurts her way through the second bottle before she finally collapses, exhausted.  The hoses pop off and milk drips everywhere.  \r\r");
            if(_root.CustomFlag4 < 5)
            {
               _root.CustomFlag4 = _root.CustomFlag4 + 1;
               _root.AddText("#slave grabs a bottle of milk on her way out.");
            }
            else
            {
               _root.AddText("#slave flushes with arousal as she prepares to leave.  She takes the milk bottle and greedily swallows it all.  ");
               if(_root.CustomFlag < 6)
               {
                  _root.AddText("#slave hopes the milk isn\'t affecting her. ");
               }
               if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
               {
                  _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.  ");
               }
               if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
               {
                  _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.  ");
               }
               if(_root.CustomFlag >= 20)
               {
                  _root.AddText("#slave yanks down her top and marvels at the size of her tits.  Dribbles of milk already run from her engorged nipples.  She pants lustily and attaches the milk machine to her own breasts.  She cums nearly immediately as the pumps try to keep up with the flow of milk....\r\rNearly an hour later a tired looking #slave leaves.");
               }
               _root.Points(0,0.25,0,-0.25,0,0,0,0,0.3,0,0,1,0.5,0,1,0,0.25,0.5,0,2);
               _root.MinLibido = _root.MinLibido + 0.3;
               _root.CustomFlag = _root.CustomFlag + 0.3;
               if(_root.CustomFlag >= 13 && _root.Lactation < 30)
               {
                  _root.Lactation = 30;
               }
               else
               {
                  _root.Lactation = _root.Lactation + 1;
               }
            }
            _root.Points(0,1,0,-0.25,0,0,0,0,0.5,0,0,2,1,0,1,0,0.5,1,0,3);
         }
         if(_root.CheckBitFlag2(5))
         {
            _root.ShowMovie(CowEventClip,1,1,8);
            _root.AddText("Bess motions #slave into the barn while #assistant isn\'t looking.  #slave slips in unnoticed for some time with her secret slave.\r\r");
            _root.PersonSpeak("Bess","Forgive me Mistress, I\'ve Mooo-milked myself twice thinking of you!",true);
            _root.AddText("#slave looks disappointed until she notices the row of filled milk bottles lined inside the stall.   She decides to reward the cow-slut with a hard fuck. \r\r");
            if(_root.IsDickgirl())
            {
               _root.AddText("#slave undresses and grabs a bottle of milk. Bess looks at her with confusion, then understanding as #slave pours it on her erect cock.  Bess spreads her legs wide for her Mistress\' milky cock.  She feels her pussy ripple muscularly, drawing in and massaging the dick.  #slave moans in pleasure and begins pistoning herself into her cowslut\'s cunt.  She dumps the rest of the bottle over the two of them as they cry out in protracted orgasm.  #slave steps away from her milk drenched slut with a satisfied smile.  ");
            }
            else
            {
               _root.AddText("She hooks a milk bottle into a socket in the back of a huge vibrator.  Bess quivers with anticipation and spreads her legs wide.  The vibe slips in with little difficulty until Bess\' muscles clamp around it.\r\r");
               _root.SlaveSpeak("Uh uh, bad girl.",true);
               _root.AddText("\r\r#slave presses a button on the back and starts pumping into Bess.  She throws her head back in pleasure from the sudden warm intrusion.  The milk-lubed vibe slides the rest of the way up Bess\' cunt with ease.  She rocks her hips as the vibrating pump stuffs her full of her own Milk.  #slave plays with Bess\' clit, driving the cowgirl into a jerking, shuddering, milk spewing orgasm. \r\r#slave pats her nearly unconscious slave as she turns to leave. ");
            }
            if(_root.CustomFlag4 < 5)
            {
               _root.CustomFlag4 = _root.CustomFlag4 + 1;
               _root.AddText("#slave grabs a bottle of milk on her way out.");
            }
            else
            {
               _root.AddText("#slave flushes with arousal as she prepares to leave.  She takes the milk bottle and greedily swallows it all.  ");
               if(_root.CustomFlag < 6)
               {
                  _root.AddText("#slave hopes the milk isn\'t affecting her. ");
               }
               if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
               {
                  _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.  ");
               }
               if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
               {
                  _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.  ");
               }
               if(_root.CustomFlag >= 20)
               {
                  _root.AddText("#slave yanks down her top and marvels at the size of her tits.  Dribbles of milk already run from her engorged nipples.  She pants lustily and attaches the milk machine to her own breasts.  She cums nearly immediately as the pumps try to keep up with the flow of milk....\r\rNearly an hour later a tired looking #slave leaves.");
               }
               _root.Points(0,0.4,0,-0.4,0,0,0,0,0.4,0,0,1,0.8,0,1,0,0.5,0.5,0,3);
               _root.MinLibido = _root.MinLibido + 0.5;
               _root.CustomFlag = _root.CustomFlag + 0.5;
               if(_root.CustomFlag >= 13 && _root.Lactation < 30)
               {
                  _root.Lactation = 30;
               }
               else
               {
                  _root.Lactation = _root.Lactation + 1;
               }
            }
            _root.Points(0,1,0,-0.25,0,0,0,0,0.5,0,0,2,1,0,1,0,0.5,1,0,3);
         }
         if(_root.CheckBitFlag2(6))
         {
            _root.Points(0,1,0,-0.25,0,0,0,0,0.5,0,0,2,1,0,1,0,0.5,1,0,3);
            if(_root.CheckBitFlag2(7))
            {
               _root.ShowMovie(CowEventClip,1,1,11);
               _root.AddText(_root.ServantName + " suddenly realizes #slave is gone.  \r\rMeanwhile, in an unused barn, #slave is already moaning into Bess\'s mouth.  The sex-crazed cowslut dragged her mistress through a barn door and into her massive bosom.  They started shedding clothing and trading spit immediately, and haven\'t stopped since.  ");
               if(_root.IsDickgirl())
               {
                  if(_root.CustomFlag3 < 10)
                  {
                     _root.AddText("Twin erections rise between their sweating bodies, the cowslut\'s cock dwarfing #slave\' average sized member.  Bess\' cock quickly covers both dicks in copious amounts of precum, enough that it drips from their slits to the straw on the floor.  ");
                  }
                  if(_root.CustomFlag3 >= 10 && _root.CustomFlag3 < 20)
                  {
                     _root.AddText("Two large cocks grow as their passion intensifies. They maul each others tits as the dicks soak themselves with pre-cum and Bess\'s dripping milk.  #slave squeezes Bess\' udders and suckles a little milk, while the cowgirl can only grind her hard cock against her mistress\'s slippery abdomen.  ");
                  }
                  if(_root.CustomFlag3 >= 20)
                  {
                     _root.AddText("#slave\' crotch swells into a massive cock, dwarfing the cowslut\'s own large erection.  The rock their hips together as they taste and tease each other\'s tongues.  #slave drenches both girls in a steady stream of precum.  Bess moos in pleasure, unable to keep her hands away from her plentiful breast-flesh.  They moan and moo in between sloppy kisses and grinding their dicks together, nearly lost to their lusts. ");
                  }
                  _root.AddText("#slave decides she has had enough foreplay and roughly forces Bess back into a specialized milking harness.\r\r");
                  _root.AddText("Bess squirms with insatiable lust, she wants to be touched so badly! " + SlaveName + " hurries to connect the milking machine to the cowslut\'s leaky nipples and cock, lubing each part of the cowgirl with precum before placing the cups upon her.  #slave eyes her slut with lust and guides her own cock into the cow\'s lusty passage.  She flicks a switch and the machine activates, pleasuring the slut\'s nipples and cock with a firm suction.  Bess starts desperately swinging herself back and forth on the harness, anxious for the extra stimulation from her mistress\' dick.  They fuck for what seems an eternity, Bess milking #slave of her cum while the machine captures all of her fluids.\r\r");
                  _root.AddText("An hour later the girls depart with their lusts sated.  Bess is sure to offer #slave as much bottled cum and milk as she wants.  ");
                  if(_root.CustomFlag4 < 5)
                  {
                     _root.CustomFlag4 = 5;
                     _root.AddText("#slave accepts the offer.  ");
                  }
                  else
                  {
                     _root.AddText("#slave has plenty of milk but feels a bit thirsty.  She takes a bottle of Bess\'s milk and quickly swallows it.  ");
                     if(_root.CustomFlag < 6)
                     {
                        _root.AddText("#slave hopes the milk isn\'t affecting her.");
                     }
                     if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
                     {
                        _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.");
                     }
                     if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
                     {
                        _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.");
                     }
                     if(_root.CustomFlag >= 20)
                     {
                        _root.AddText("#slave yanks down her top and marvels at the size of her tits.  Dribbles of milk already run from her engorged nipples.  She pants lustily and attaches the milk machine to her own breasts.  She cums nearly immediately as the pumps try to keep up with the flow of milk....\r\rNearly an hour later a tired looking #slave leaves.");
                     }
                     _root.Points(0,0.25,0,-0.25,0,0,0,0,0.3,0,0,1,0.5,0,1,0,0.25,0.5,0,2);
                     _root.MinLibido = _root.MinLibido + 1;
                     _root.CustomFlag = _root.CustomFlag + 0.7;
                     if(_root.CustomFlag >= 13 && _root.Lactation < 30)
                     {
                        _root.Lactation = 30;
                     }
                     else
                     {
                        _root.Lactation = _root.Lactation + 1;
                     }
                     _root.AddText("\r\r");
                  }
                  if(_root.CustomFlag2 < 5)
                  {
                     _root.CustomFlag2 = 5;
                  }
                  if(!_root.CheckBitFlag2(8) && _root.MinLibido > 50)
                  {
                     _root.DoEvent(306);
                  }
               }
               else
               {
                  if(_root.CustomFlag < 10)
                  {
                     _root.AddText("Bess\' large cock swells against #slave\' belly, throbbing between them.  The cowgirl pants in sexual heat, her body flushing from the sloppy kiss and her own heightened libido. \r\r");
                  }
                  if(_root.CustomFlag > 9 && _root.CustomFlag < 21)
                  {
                     _root.AddText("Bess\' long dick swells up as her unnatural arousal builds, the thickening cow-cock easily slipping into #slave\' drippy cunt.  She moans uncontrollably at the swift and pleasureable intrusion, her juices soak Bess\' member, balls, and slowly drip down the cow\'s legs.\r\r");
                  }
                  if(_root.CustomFlag > 20)
                  {
                     _root.AddText("The cow\'s cock swiftly swells to tremendous size in response to its mistress. #slave wraps a hand around it, to feel its size and firmness.  She strokes it slowly, teasingly, but she eventually relents and brings her moist pussy up against it.  #slave rubs up and down the length, her clitty growing larger and larger as her arousal builds.  Bess marvels at the size of her Mistress\' clit - over an inch long and flushed crimson with arousal. \r\r");
                  }
                  _root.AddText("#slave regretfully breaks the contact with Bess, leaving the cowgirl erect and ready. A large dollop of pre-cum torturously slides down her cock as she waits for #slave\' to allow her pleasure.  It seems Bess will not wait long.   Her Mistress pulls down an old stained sheet, revealing a mold of her own hindquarters - complete with textured vagina.  A large piston and glass milk bottle are socketed into the stand, along with a few controls.  Bess eagerly throws herself onto it, her dick sliding into the cock-milker like a well oiled piston. Her hands grip the molded ass as she begins fucking it in earnest, a slave to her lusts. \r\r");
                  _root.AddText("Bess doesn\'t even notice when the nipple cups are placed on her, but the large dildo being forced up her ass sets off a messy orgasm.  #slave flicks a switch and the device starts humming around Bess\' recovering erection, sucking out the cum and vibrating pleasurably.  Another switch later, the breast pumps begin harvesting milk from the poor cowgirl.  The vibrations and nipple stimulation send her over the edge of orgasm again.  The cum-drain begins spilling large globules of cum into the bottle, filling it to the halfway mark.  The barn fills with the heady scent of her aphrodesiac musk, and #slave can\'t resist masturbating.  Bess is already filling her cum bottle up to the 2/3 mark with a steady stream of her pre-cum.  Her hips piston into the machine relentlessly, her thoughts on nothing but the pleasure of the next thrust and the desire to cum.\r\r");
                  _root.AddText("At long last she feels an orgasm begin to build, a pleasurable heat spreading from her pussy and balls to deeper within her.  Bess slams herself in to the hilt, rocking the machine back and forth.  She lets out a loud \'MOOO\' as she shudders in orgasm.  Cum sprays out as she overloads the machine with the volume of her orgasm. Cum spills out around her dick, out of a seam in the tubing that busts from the pressure, and over the top of the bottle as it fills.\r\r");
                  _root.AddText("An hour later the girls depart with their lusts sated.  Bess is sure to give #slave as much bottled cum and milk as she wants.  ");
                  if(_root.CustomFlag4 < 5)
                  {
                     _root.CustomFlag4 = 5;
                     _root.AddText("#slave accepts the offer.");
                  }
                  else
                  {
                     _root.AddText("She takes a milk bottle and greedily swallows it all.  ");
                     if(_root.CustomFlag < 6)
                     {
                        _root.AddText("#slave hopes the milk isn\'t affecting her. ");
                     }
                     if(_root.CustomFlag > 5.9 && _root.CustomFlag < 13)
                     {
                        _root.AddText("#slave\'s nipples dribble milk, leaving two wet stains on her top.  She frowns but is highly aroused.  ");
                     }
                     if(_root.CustomFlag > 12.9 && _root.CustomFlag < 20)
                     {
                        _root.AddText("#slave is so turned on she starts squirting milk. She starts playing with her nipples through her shirt and is rocked by a powerful milk-squirting orgasm.  ");
                     }
                     if(_root.CustomFlag > 19.9)
                     {
                        _root.AddText("#slave yanks down her top and marvels at the size of her tits.  Dribbles of milk already run from her engorged nipples.  She pants lustily and attaches the milk machine to her own breasts.  She cums nearly immediately as the pumps try to keep up with the flow of milk....\r\rNearly an hour later a tired looking #slave leaves.");
                     }
                     _root.Points(0,0.25,0,-0.25,0,0,0,0,0.3,0,0,1,0.5,0,1,0,0.25,0.5,0,2);
                     _root.MinLibido = _root.MinLibido + 1;
                     _root.CustomFlag = _root.CustomFlag + 0.7;
                     if(_root.CustomFlag >= 13 && _root.Lactation < 30)
                     {
                        _root.Lactation = 30;
                     }
                     else
                     {
                        _root.Lactation = _root.Lactation + 1;
                     }
                  }
                  if(_root.CustomFlag2 < 5)
                  {
                     _root.CustomFlag2 = 5;
                  }
                  if(!_root.CheckBitFlag2(8) && _root.MinLibido > 50)
                  {
                     _root.DoEvent(306);
                  }
                  _root.ShowPlanningNext();
               }
            }
            else
            {
               _root.ShowMovie(CowEventClip,1,1,10);
               _root.AddText("#slave smiles at her needy nymphomaniac of a cowslut.   Bess\'s nipples are puffy and distended, large and perfectly sized to fill the large milking cups.   Her labia are engorged and slick with the fruits of her arousal, proudly displaying how ready she is for a thick cock.  She reclines over the side of the milking machine, alternatively panting and mooing in heat.\r\r");
               _root.AddText("Bess shudders and groans as #slave guides her into position for her milking.  Droplets of milk begin dribbling from her mammoth udders in anticipation of release.  #slave attaches the milk cups to Bess\'s tits and giggles as milk begins pouring into the hoses -- all without the pump\'s activation!  Bess moos in desperation as the milk slows to a trickle, her breathing heavy and rivulets of her arousal running down her legs.\r\r");
               _root.AddText("#slave pauses for a moment to enjoy the sight before her, then activates the machine!  Bess\'s eyes gloss over with relief and pleasure.  She doesn\'t notice her mistress circle behind to a small storage area or her mistress\'s return with a HUGE jug for the milking machine.  She does notice when foot-long vibrators are inserted into her ass and vagina, as she begins orgasming powerfully! Each vibration seems to push more milk out of her udders and into the machine.  Bess passes out in pleasure but her milking continues for much, much longer.\r\r");
               if(_root.CustomFlag4 < 5)
               {
                  _root.CustomFlag4 = 5;
                  _root.AddText("#slave is sure to top off her supply of milk from jug before she leaves.  ");
               }
               if(!_root.CheckBitFlag2(8) && _root.MinLibido > 50)
               {
                  _root.DoEvent(306);
               }
            }
         }
         if(_root.CheckBitFlag2(1) && !_root.CheckBitFlag2(2) && !(_root.CheckBitFlag2(4) || _root.CheckBitFlag2(5) || _root.CheckBitFlag2(6)))
         {
            _root.ShowMovie(CowEventClip,1,1,1);
            _root.AddText("You come across Bess as she stumbles out of the barn. She appears to be recovering from a particularly intense milking.  #slave waves but it takes Bess a moment to come to her senses.\r\r");
            _root.PersonSpeak("Bess","Hi guys, I\'m sorry but I\'ve got to be on my way.  I don\'t want Mistress to suspect the truth of my little trips!",true);
            _root.AddText("\r\rBess waves goodbye.  ");
            if(_root.VarSpecialRounded > 29)
            {
               _root.AddText("#slave again feels the urge to use her Nymph magic. Does she?");
               _root.DoYesNoEventXY(302);
            }
         }
         if(!_root.CheckBitFlag2(1))
         {
            _root.ShowMovie(CowEventClip,1,1,1);
            _root.AddText("While exploring the farm #slave sees a cowgirl slipping out from a barn.\r\r");
            _root.PersonSpeak("Cowgirl","Please don\'t tell anyone I was here, my mistress would kill me!",true);
            if(_root.Supervise)
            {
               _root.AddText("\r\rYou and #slave assure her that neither of you will tell her secret, and she seems to relax. \r\r");
            }
            else
            {
               _root.AddText("\r\r#slave and #assistant assure her that they will not tell her secret, and she seems to relax. \r\r");
            }
            _root.PersonSpeak("Cowgirl","Thank you, both of you.  I just can\'t help it, I get so turned on by the idea of being used for all my creamy milk.  Mistress doesn\'t know I keep getting milked when she sends me shopping, but she loves the milk I bring home!",true);
            _root.AddText("\r\rThe cowgirl blushes and introduces herself as Bess.  ");
            if(MilkInfluence == 0)
            {
               _root.AddText("She warns #slave to be careful about the drugs they offer at the farm, but won\'t go into detail.  ");
            }
            _root.AddText("\r\r");
            _root.SetBitFlag2(1);
            if(_root.VarSpecialRounded > 29)
            {
               _root.AddText("#slave feels as if she could use her Nymph magic on this girl. Does she?");
               _root.DoYesNoEventXY(302);
            }
            else
            {
               _root.PersonSpeak("Bess","I\'d better get going, thank you again!",true);
               _root.Points(0,2,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0.5,0);
            }
         }
         if(_root.CheckBitFlag2(2) && !(_root.CheckBitFlag2(4) || _root.CheckBitFlag2(5) || _root.CheckBitFlag2(6)))
         {
            _root.ShowMovie(CowEventClip,1,1,3);
            _root.AddText("Bess pops out of a barn and drags #slave over while #assistant is distracted.\r\r");
            _root.PersonSpeak("Bess","Please milk me again!  You can take as much of my milk as you want.",true);
            _root.AddText("\r\r#slave agrees to do it for a bottle of milk.");
            _root.DoEvent(303);
         }
         return true;
      }
   }
   return false;
}
function VisitSeer(score)
{
   if(_root.CheckBitFlag2(0))
   {
      fortune = "\r\rThis girl\'s destiny stands at a crossroads.";
      if(_root.CustomFlag > 5.9 && _root.CustomFlag < 13)
      {
         fortune = fortune + "  She has the power of the fae to increase lust and fertility";
      }
      else if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
      {
         fortune = fortune + "  She is strong in the power of the fae to increase lust and fertility";
      }
      else if(_root.CustomFlag >= 20)
      {
         fortune = fortune + "  She is mighty in the power of the fae to increase lust and fertility";
      }
      if(_root.IsDickgirl())
      {
         if(_root.CustomFlag3 > 5.9 && _root.CustomFlag3 < 13)
         {
            fortune = fortune + ", as well as a strong libido";
         }
         else if(_root.CustomFlag3 >= 13 && _root.CustomFlag3 < 20)
         {
            fortune = fortune + ", as well as a very high libido";
         }
         else if(_root.CustomFlag3 >= 20)
         {
            fortune = fortune + ", as well as a huge libido";
         }
      }
      fortune = fortune + ".  You can give in to her desires or turn her instead to a holy path.  Seek out the faerie trader at the lake.";
      if(!_root.CheckBitFlag2(11))
      {
         fortune = fortune + "  You may also find assistance in unlikely places...seek out a sign and heed its advice!";
      }
      if(_root.CheckBitFlag2(31) && !_root.CheckBitFlag2(32))
      {
         fortune = fortune + "\r\rI sense dark forces gathering.  Be careful of the fae!";
      }
      _root.VisitFortuneTeller.SlaveReading.text = _root.VisitFortuneTeller.SlaveReading.text + fortune;
   }
}
function ShowDating()
{
   _root.ShowMovie(ClipDating,1,1,!_root.IsDickgirl()?1:2);
}
function ShowTired(cum)
{
   _root.ShowMovie(ClipTired,1,3,!_root.IsDickgirl()?int(Math.random() * 2) + 1:3);
}
function ShowPropositionAccepted()
{
   if(LesbianTraining)
   {
      _root.ShowMovie(ClipPropositionAccepted,1,1,_root.slrandom(3));
   }
   else
   {
      _root.ShowMovie(ClipPropositionAccepted,1,1,_root.slrandom(2));
   }
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4);
   }
}
function ShowPropositionRefused()
{
   ShowDating();
}
function ShowRetrieved()
{
   _root.ClipRescue._visible = false;
   _root.ClipRunaway._visible = false;
   if(_root.IsDickgirl())
   {
      return ShowSexActBondage();
   }
   _root.Backgrounds.ShowArmoury(2);
   _root.ShowMovie(ClipSlaveRetrieved,1,1,1);
}
function ShowRaped()
{
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2);
   }
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(ClipRaped,1,1,3);
   }
   else if(int(Math.random() * 2))
   {
      _root.ShowMovie(ClipRaped,1,1,1);
   }
   else
   {
      _root.ShowMovie(ClipRaped,1,1,2);
   }
   return true;
}
function ShowMilkFall()
{
   _root.ShowMovie(ClipTired,1,1,1);
   return true;
}
function ShowMilking()
{
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(EventMilk,1,1,7);
   }
   else if(int(Math.random() * 3) + 1 < 2)
   {
      _root.ShowMovie(EventMilk,1,1,4);
   }
   else
   {
      _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 5);
   }
}
function ShowMilkEnd()
{
   _root.ShowMovie(EventMilk,1,1,1);
   return true;
}
function ShowMilkAccident()
{
   _root.ShowMovie(ExhibClip,1,1,3);
   return true;
}
function ShowMorningMouthfull()
{
   _root.HideBackgrounds();
   _root.ShowMovie(EventMorningMouthfull,1,1,1);
   return true;
}
function ShowNakedApron()
{
   _root.ShowMovie(NakedApronClip,1,3,!_root.IsDickgirl()?_root.slrandom(2):3);
   return true;
}
function ShowLoveConfession()
{
   _root.Backgrounds.ShowTownCenter();
   _root.ShowMovie(ClipLoveConfession,1,1,1);
}
function ShowLoveAccepted()
{
   _root.HideBackgrounds();
   ClipLoveConfession._visible = false;
   _root.ShowMovie(ClipLoveAccepted,1,1,1);
   return false;
}
function ShowLoveRefused()
{
   _root.HideBackgrounds();
   ClipLoveConfession._visible = false;
   if(_root.NumEvent == 3)
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,-5,0,0,0,-15,-20,0);
      _root.SetText("#slave is very sad but at least you don\'t let your personal likes interfere with your job.");
   }
   _root.ShowMovie(ClipLoveRefused,1,1,1);
}
function ShowChoreCleaning()
{
   if(_root.DoDickgirlChange(33))
   {
      return undefined;
   }
   _root.ShowMovie(CleaningClip,1,1,1);
}
function ShowChoreCooking()
{
   _root.ShowMovie(CookingClip,1,1,1);
}
function ShowChoreDiscuss()
{
   _root.HideBackgrounds();
   if(Naked)
   {
      if(_root.Gender == 2)
      {
         _root.ShowMovie(DiscussClip,1,!_root.IsDickgirl()?0:1,!_root.IsDickgirl()?4:5);
      }
      else
      {
         _root.ShowMovie(DiscussClip,1,1,!_root.IsDickgirl()?3:5);
      }
   }
   else
   {
      _root.ShowMovie(DiscussClip,1,1,int(Math.random() * 2) + 1);
   }
}
function ShowChoreExpose()
{
   if(_root.DoDickgirlChange(30))
   {
      return undefined;
   }
   if(_root.IsDickgirl())
   {
      temp = int(Math.random() * 2) + 4;
   }
   else
   {
      temp = int(Math.random() * 3) + 1;
   }
   _root.ShowMovie(ExhibClip,1,1,temp);
}
function ShowChoreMakeUp()
{
   _root.ShowMovie(BeautyClip,1,1,_root.slrandom(3));
   return false;
}
function ShowChoreExercise()
{
   if(Naked)
   {
      temp = !_root.IsDickgirl()?4:5;
   }
   else
   {
      temp = int(Math.random() * 3) + 1;
   }
   _root.Backgrounds.ShowTownCenter();
   _root.ShowMovie(PromenadeClip,1,1,temp);
}
function ShowChoreReadABook()
{
   _root.HideBackgrounds();
   _root.ShowMovie(ReadClip,1,1,13);
   return true;
}
function ShowSchoolSciences()
{
   _root.ShowMovie(SciencesClip,1,1,int(Math.random() * 2) + 1);
}
function ShowSchoolSinging()
{
   _root.HideImages();
   _root.ShowMovie(SingingClip,1,1,1);
   return true;
}
function ShowSchoolTheology()
{
   _root.HideBackgrounds();
   _root.ShowMovie(TheologyClip,1,1,1);
   _root.DoXMLAct("Theology");
}
function ShowSchoolRefinement()
{
   temp = int(Math.random() * 2) + 1;
   _root.ShowMovie(RefinementSchoolClip,1,temp != 1?1:3,temp);
   if(temp == 1)
   {
      _root.HideBackgrounds();
   }
}
function ShowSchoolDance(donearoused)
{
   _root.ShowMovie(DanceClip,1,1,int(Math.random() * 2) + 1);
   _root.HideBackgrounds();
}
function AfterSchoolDance()
{
   _root.DoXMLAct("AfterDance");
}
function ShowSchoolXXX(doDG)
{
   if(doDG)
   {
      temp = _root.slrandom(2);
      _root.PersonSpeak("Teacher","You need to have some experience with a hermaphrodite, a woman with both genitals. She has a huge libido and you will fuck many times. Please enjoy yourself.");
   }
   else
   {
      temp = _root.slrandom(2) + 2;
   }
   _root.ShowMovie(XXXClip,temp != 1?1:3,1,temp);
   if(temp == 1)
   {
      _root.ShowOverlay(0);
   }
   return temp < 3;
}
function ShowJobRestaurant()
{
   temp = int(Math.random() * 3) + 1;
   _root.ShowMovie(RestaurantClip,1,1,temp);
   return 1;
}
function ShowJobBar()
{
   _root.ShowMovie(BarClip,1,1,1);
   return 1;
}
function ShowJobAcolyte()
{
   _root.ShowMovie(AcolyteClip,1,1,int(Math.random() * 2) + 1);
   _root.DoXMLAct("JobAcolyte");
   return 1.2;
}
function AfterJobLibrary(points)
{
   _root.DoXMLAct("AfterLibrary");
}
function ShowJobOnsen(gnd)
{
   _root.ShowMovie(OnsenClip,1,1,1);
   return 1;
}
function ShowJobSleazyBar(strip)
{
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2);
   }
   if(strip || Naked)
   {
      if(!Naked && _root.IsDickgirl())
      {
         temp = 10;
      }
      else
      {
         temp = _root.slrandom(2) + 4;
      }
   }
   else if(_root.BunnySuitOK)
   {
      temp = _root.slrandom(3) + 6;
   }
   else
   {
      temp = int(Math.random() * 4) + 1;
   }
   _root.ShowMovie(SleazyBarClip,1,1,temp);
   if(_root.CustomFlag < 6)
   {
      temp = 1;
      _root.PersonSpeakStart("Sleazy Bar Owner","The customers like you, I hope to see you again.",true);
   }
   else if(_root.CustomFlag > 5 && _root.CustomFlag < 11)
   {
      temp = 1.1;
      _root.PersonSpeakStart("Sleazy Bar Owner","There is something about you....the customers love it!",true);
   }
   else if(_root.CustomFlag > 10 && _root.CustomFlag < 19)
   {
      temp = 1.2;
      _root.PersonSpeakStart("Sleazy Bar Owner","Wow you are a hit! But please try not to dribble so much milk when you are on stage, someone could slip and fall.",true);
   }
   else if(_root.CustomFlag > 18)
   {
      temp = 1.5;
      _root.PersonSpeakStart("Sleazy Bar Owner","Could you give me some of your milk?  We started mixing it into the drinks and we love it!",true);
   }
   return temp;
}
function ShowJobSleazyBarService(female)
{
   if(female)
   {
      return false;
   }
   if(_root.NumEvent == 33.2)
   {
      _root.AddText("#slave decides to help a well endowed hermaphrodite with her \"Problem\".  ");
      if(_root.CustomFlag < 5)
      {
         _root.AddText("She services her well, bringing her to a quick and messy orgasm.");
         _root.ShowMovie(BlowjobClip,1,1,3);
      }
      if(_root.CustomFlag > 4 && _root.CustomFlag < 14)
      {
         _root.AddText("She trusts her faerie magic to guide her and finds her lips around the hermaphrodite\'s dick!  She hums and slurps her way to a mouthload of cum. #slave swallows and the hermaphrodite pours more cum down her throat, but #slave can\'t quite keep up.\r\r");
         _root.PersonSpeak("Customer","That was amazing, I don\'t think anyone has made me cum that hard before!",true);
         _root.ShowMovie(BlowjobClip,1,1,5);
      }
      if(_root.CustomFlag > 20)
      {
         _root.AddText("She feels totally in tune with her wild sexual nature, and expertly deepthroat\'s the woman\'s cock.  She feels like she could bring her off in seconds, but takes her time in order to maximize the customer\'s load.  #slave rubs the woman\'s balls as she keeps her on the edge for a while.  She feels the woman\'s balls clench up in preparation for her orgasm, and takes the woman to the hilt.  Her cum splatters #slave\' throat with such quantity and force that she has a hard time keeping the customer\'s cock in her mouth.  The customer slumps after the most intense orgasm of her life.  #slave greedily slurps down the cum that splattered and dribbled out.\r\r");
         _root.PersonSpeak("Customer","...aaaaahhhhhh...",true);
         _root.ShowMovie(BlowjobClip,1,1,6);
      }
      _root.AddText("\r\r");
   }
   else
   {
      _root.AddText("#slave decides to help a well endowed gentleman with his \"Problem\".  ");
      if(_root.CustomFlag < 5)
      {
         _root.AddText("She services him well, bringing him to a quick and messy orgasm.");
         _root.ShowMovie(BlowjobClip,1,1,3);
      }
      if(_root.CustomFlag > 4 && _root.CustomFlag < 14)
      {
         _root.AddText("She trusts her faerie magic to guide her and finds her lips around his dick!  She hums and slurps her way to a mouthload of cum. #slave swallows and he pours more cum down her throat, but she can\'t quite keep up.\r\r");
         _root.PersonSpeak("Customer","That was amazing, I don\'t think anyone has made me cum that hard before!",true);
         _root.ShowMovie(BlowjobClip,1,1,5);
      }
      if(_root.CustomFlag > 20)
      {
         _root.AddText("She feels totally in tune with her wild sexual nature, and expertly deepthroats the man\'s cock.  She feels like she could bring him off in seconds, but takes her time in order to maximize his load.  #slave rubs his balls as she keeps him on the edge for a while.  She feels his balls clench up in preparation for his orgasm, and takes him to the hilt.  His cum splatters her throat with such quantity and force that she has a hard time keeping him in her mouth.  The customer slumps after the most intense orgasm of his life.  #slave greedily slurps down the cum that splattered and dribbled out.\r\r");
         _root.PersonSpeak("Customer","...aaaaahhhhhh...",true);
         _root.ShowMovie(BlowjobClip,1,1,6);
      }
      _root.AddText("\r\r");
   }
   return true;
}
function ShowJobBrothel()
{
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4);
   }
   _root.HideBackgrounds();
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(BrothelClip,1,1,4);
   }
   else
   {
      _root.ShowMovie(BrothelClip,1,1,int(Math.random() * 3 + 1));
   }
   return 1;
}
function ShowRefusedAction(Action, slave, servant, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special)
{
   _root.ShowMovie(RefusedAction,1,1,1);
   return false;
}
function ShowBreak(sleeping)
{
   if(_root.VarNymphomaniaRounded > 25 && _root.VarSensibilityRounded > 35 && _root.VarTemperamentRounded > 35 && _root.CheckBitFlag2(0) && _root.VarSpecialRounded > 9 && !_root.CheckBitFlag2(29) && _root.SMLust > 25 && _root.VarLibidoRounded > 40)
   {
      if(_root.IsDickgirl())
      {
         _root.ShowMovie(BreakClip,1,1,8);
      }
      else
      {
         _root.ShowMovie(BreakClip,1,1,2);
      }
      _root.SetText(_root.ServantName + " points out that #slave seems to be highly aroused. She is flushed and trying hard to seduce you.  The scent of her sex permeates the whole room.\r\r");
      if(_root.Gender == 1 || _root.Gender == 3)
      {
         _root.SlaveSpeak("Can we please do something naughty?",true);
      }
      else
      {
         _root.SlaveSpeak("Please, I want to do dirty things to you!",true);
      }
      _root.AppendActText = false;
      _root.DoYesNoEvent(300);
   }
   else if(_root.MinLibido > 50 && !_root.IsDickgirl())
   {
      _root.ShowMovie(BreakClip,1,1,3);
   }
   else if(_root.IsDickgirl())
   {
      _root.ShowMovie(BreakClip,1,1,8);
   }
   else
   {
      _root.ShowMovie(BreakClip,1,1,1);
   }
}
function NewPlanningAction(type, available, hint)
{
   if(type == 27)
   {
      if(_root.Gender == 2 && !_root.IsDickgirl() && _root.CheckBitFlag2(13) && !_root.CheckBitFlag2(12))
      {
         _root.SlaveSpeak("I\'m sorry but I can\'t milk either of us with this cock milker.",true);
         return true;
      }
      _root.AddText("#slave will milk herself with the equipment available.");
   }
   return false;
}
function NewPlanningActionAsAssistant(type, available, hint)
{
   if(type == 29)
   {
      if(!_root.IsDickgirl() && _root.CheckBitFlag2(13) && !_root.CheckBitFlag2(12))
      {
         _root.SlaveSpeak("I\'m sorry but I can\'t milk #slave with this cock milker.",true);
         return true;
      }
      _root.AddText("#assistant will milk #slave with the equipment available.");
   }
   return false;
}
function ShowSexActNothing()
{
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(DiscussClip,1,1,4);
   }
   else
   {
      _root.ShowMovie(NeedingClip,1,1,int(Math.random() * 2) + 1);
   }
}
function ShowSexAct69()
{
   _root.ShowMovie(SixtyNineClip,1,1,!Lesbian?1:2);
}
function ShowSexActAnal()
{
   if(_root.DoDickgirlChange(40))
   {
      return undefined;
   }
   if(_root.DefaultLesbian())
   {
      return undefined;
   }
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(AnalClip,1,1,3);
      _root.DoCumSplatter(AnalClip,1,6);
   }
   else
   {
      _root.ShowMovie(AnalClip,1,1,int(Math.random() * 2) + 1);
   }
}
function ShowSlaveSex1()
{
   _root.AddText("#slave currently has ");
   _root.ResetQuestions();
   if(_root.CustomFlag4 > 0)
   {
      _root.AddQuestion(317,"Bottle of Milk");
      _root.AddText("Milk, ");
   }
   if(_root.CustomFlag2 > 0)
   {
      _root.AddText("Cum, ");
      _root.AddQuestion(318,"Bottle of Cum");
   }
   if(_root.CheckBitFlag2(14))
   {
      _root.AddText("Addiction Draft, ");
      _root.AddQuestion(320,"Addiction Draft");
   }
   if(_root.CheckBitFlag2(15))
   {
      _root.AddText("Monster Musk ");
      _root.AddQuestion(319,"Monster Musk");
   }
   _root.AddQuestion(1017,"Forget it");
   _root.AddText("available to her.");
   _root.ShowMovie(FaerieClip,1,1,12);
   _root.ShowQuestions("Which shall she drink? ");
}
function ShowSlaveSex2()
{
   if(_root.CheckBitFlag2(12) && (!_root.CheckBitFlag2(13) || !_root.IsDickgirl()))
   {
      if(_root.TentaclePregnancy < 1 && _root.MilkInfluence < 1 && _root.CustomFlag < 6)
      {
         _root.AddText("You attach the pumps to #slave, but she isn\'t lactating.  You keep them on a while to see if anything will happen.  ");
         if(int(Math.random() * 2) > 0)
         {
            _root.AddText("  After nearly an hour of suction, Aeris gasps in surprise! Trickles of milk flow from her very swollen nipples into the cups, but you are unsure if she can repeat it.");
            _root.CustomFlag = _root.CustomFlag + 1;
            _root.Lactation = _root.Lactation + 2;
         }
         else
         {
            _root.AddText("  You give up after a while. #slave\'s nipples are puffy and sore.");
         }
         return undefined;
      }
      if(_root.CheckBitFlag2(23))
      {
         _root.AddText("#slave eagerly steps up to the milker.  She produces milk expertly, easily and constantly orgasming through the whole experience.");
         _root.Points(0,0.5,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,1,-5,0,3,2,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 17);
      }
      if(!_root.CheckBitFlag2(23) && _root.CheckBitFlag2(22))
      {
         if(_root.VarConstitutionRounded < 70 || _root.VarLibidoRounded < 75)
         {
            _root.AddText("#slave orgasms from the dildo, strap ons, and actual cocks, but could still better her milk production...");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 17);
         }
         else
         {
            _root.AddText("Eagerly, #slave steps into the milking station.  You attach the suction cups and strap her down.  You stroke her pussy and insert the large dildo, noticing a gush from her pussy as she orgasms.  The milk begins to flow before you even turn on the vibrations. You work oil up into her anus and insert a well lubricated anal plug. #slave pants heavily, her breasts seeming to grow again, the milk flowing heavily from her stiff nipples.\r\r");
            _root.AddText("You let all the members of the household take their turns offering cocks, pussies, or breasts to #slave to be licked and sucked.  #slave\' mouth brings person after person to orgasm.  She orgasms frequently as well and produces rivers of milk. You try a new experiment, having people put their pussies or cocks in #slave\' hands. #slave compulsively strokes them and produces even more milk.\r\r");
            _root.AddText("You have a female rub #slave\' back with her breasts.  #slave orgasms almost immediately, even though she just came.  You add this as part of the rotation and watch for a while to get an idea of how much milk is produced. You wonder what would happen if someone fucked the woman rubbing #slave with either a cock or a strap-on. You proceed with the experiment and #slave comes again. Apparently she can recognize the difference, whether ");
            _root.AddText("it\'s a difference in the sensations or a sign of awareness of what\'s happening around her. You continue to experiment and discover that #slave produces the most milk when you switch between having the woman fucked and having her pay attention only to #slave. #slave is most likely to orgasm and produce more milk when the woman either stops or starts being fucked.\r\r");
            _root.AddText("You\'ve learned as much about producing milk as you can, so you step forward and take full part in the rotation with the rest of the household. You help make #slave come again and again, filling the milk bucket. You yourself are completely satisfied, as is the rest of the household.\r\r");
            _root.AddText("As #slave lies at her station, entirely spent, you disconnect the suction cups and hose her down. You dry her gently with a towel as she naps, a look of satisfaction on her face.");
            _root.SetBitFlag2(23);
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 17);
         }
         _root.Points(0,0.4,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.8,-4,0,3,2,0,0);
      }
      if(!_root.CheckBitFlag2(22) && _root.CheckBitFlag2(21))
      {
         if(_root.VarConstitutionRounded < 40 || _root.VarLibidoRounded < 60)
         {
            _root.AddText("#slave comes to orgasm after you kiss her. The milk is flowing well, but might work better if she had more lust or endurance.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 16);
         }
         else
         {
            _root.AddText("#slave shudders, her breasts growing in size from an accidental use of her magic.  This is an ideal time to try having the various members of the household take turns fucking her pussy and ass with cocks and strap-ons. Unsurprisingly, you find that she produces the most milk (and orgasms) when both pussy and ass are filled. Further, you observe that the most likely time for her to orgasm is when a switch is being made.\r\r");
            _root.AddText("As a result, you make a rule. From now on, she shall always have both holes filled unless in the middle of a switch. You add the dildo and the anal plug as well, since it is difficult to position two people to fuck both pussy and ass at the same time while she is at the milking station. You schedule frequent swaps, as the change seems to stimulate her.");
            _root.SetBitFlag2(22);
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 17);
         }
         _root.Points(0,0.3,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.6,-3,0,3,2,0,0);
      }
      if(!_root.CheckBitFlag2(21) && _root.CheckBitFlag2(20))
      {
         if(_root.VarConstitutionRounded < 25 || _root.VarLibidoRounded < 35)
         {
            _root.AddText("You measure milk produced against orgasms. #slave has a some of both, but could produce more if she were more fit or horny.");
         }
         else
         {
            _root.AddText("Once you get the milking equipment connected, you have the various members of your household expose their cocks and pussies to Aeris\' mouth. You find that the greatest amount of milk is produced right after a switch, so you have everyone rotate frequently. Occasionally, you have someone kiss her. Again, it seems like switching from oral to a kiss or vice versa, causes the most milk to flow.\r\r");
            _root.AddText("You also measure the amount of milk against the number of orgasms. You find that the more orgasms she has, the more milk that she produces. This confirms what you\'ve been observing. The more you feed her arousal, the faster the milk comes. You decide to keep up the experiments. Not only is the milk valuable, but you are really enjoying watching how it affects her.");
            _root.SetBitFlag2(21);
         }
         _root.Points(0,0.2,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.4,-2,0,2,2,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 16);
      }
      if(!_root.CheckBitFlag2(20) && _root.CheckBitFlag2(19))
      {
         if(_root.VarConstitutionRounded < 15 || _root.VarLibidoRounded < 25)
         {
            _root.AddText("Neither you nor Aeris really has the hang of this yet. You keep experimenting to try to produce more milk.");
            _root.ShowMovie(EventMilk,1,1,16);
         }
         else
         {
            _root.AddText("You decide that the best way to analyze #slave\'s milking is to try each activity in turn and see which produces the most milk.  For this session, you decide to use just the milking equipment.  You hook up the cups and strap her down, then lube and insert the dildo and anal plug.  #slave begs for more, even though she has already cum twice.  You continue the experiment, watching the milk flow.\r\r");
            _root.AddText("#slave doesn\'t have a lot of room to move, but she tries desperately to rub herself against the harness. She is writhing in acute arousal.  Despite cumming every so often, she still begs for more and is clearly feeling frustrated.  Finally, you take pity on her, and with one eye on the milk output, kiss her deeply.  Her tongue trying to crawl down your throat, she kisses you with passion.  The milk flow increases sharply.  She orgasms yet again and then releases a string of explosive orgasms before finally passing out.");
            _root.SetBitFlag2(20);
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 16);
         }
         _root.Points(0,0.1,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.3,-1,0,2,2,0,0);
      }
      if(!_root.CheckBitFlag2(19))
      {
         _root.SlaveSpeak("Well, I guess we can try this.",true);
         _root.AddText("\r\rHer breasts strangely grow even larger, becoming swollen and heavy with milk. She is panting with arousal and is sensitive to even the slightest touch. Juices are already leaking from her pussy. When you ask her a question about how she is feeling, she doesn\'t look like she even heard you. She looks sort of dazed and disconnected from her surroundings. You attach the suction cups to her nipples and strap her into place so that she doesn\'t pull them loose. Milk\'s already flowing. Aeris moans.\r\r");
         _root.SlaveSpeak("I need to be fucked. Please, fuck me now. Oh, I need something inside me immediately. Ohhhh...",true);
         _root.AddText("\r\rYou lube and then insert the large dildo that came with the milking equipment. #slave shudders and comes in a screaming orgasm. She moans. You can see that her orgasm brought some relief, but she still needs more stimulation. You rub some oil on her ass and insert the anal plug. Aeris comes again. You place her regular dildo in front of her mouth, and she licks and sucks it compulsively. When she comes again, you remove it and call #assistant over.\r\r");
         _root.AddText("You tell #assistant to put her pussy in front of #slave\'s face.  She does, and #slave immediately starts to lick and suck it. #slave comes three more times before #assistant does.   You, your assistant, and all your slaves take turns letting her suck your cocks and pussies. Occasionally one of you removes either the dildo or the anal plug and fucks her with cock or strap on. If you stick a cock, pussy, or strap on near her hand, she strokes it compulsively. She still seems disconnected and unaware of what she is doing. By the time the effect of her magic starts wearing off, you are all satisfied except #slave. Nothing she does seems to give her true release. Finally, she comes to an explosive orgasm and passes out. You remove the suction cups, the dildo, and the anal plug, cleaning them for next time.  ");
         _root.AddText("You wash off #slave as well. She was covered in cum. She doesn\'t wake, so you decide to give her a little more time.");
         _root.AddText("\r\rYou see that you\'ve collected a good amount of milk from her. You wonder how this compares with other yields. Also, what activities produced the most milk? You were too intrigued at the time to keep track. In the future, you\'ll have to keep more distance so as to evaluate better.");
         _root.Points(0,0,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.2,-0.5,0,2,2,0,0);
         _root.SetBitFlag2(19);
         _root.ShowMovie(EventMilk,1,1,16);
      }
      if(_root.MilkInfluence > 0 && _root.MilkInfluence < 1000)
      {
         temp = _root.CustomFlag / 10 + _root.MilkInfluence / 5 + Math.random() * _root.VarLibidoRounded / 40 + _root.VarConstitutionRounded / 50;
      }
      else if(_root.Lactation >= 30)
      {
         temp = _root.CustomFlag / 10 + _root.Lactation / 5 + Math.random() * _root.VarLibidoRounded / 40 + _root.VarConstitutionRounded / 50;
      }
      else
      {
         temp = _root.CustomFlag / 10 + Math.random() * _root.VarLibidoRounded / 40 + _root.VarConstitutionRounded / 50;
      }
      _root.AddText("\r\rChecking the tank, you find #slave has produced " + int(temp * 10) / 10 + " bottles of milk.  ");
      if(temp <= 2)
      {
         _root.AddText(_root.ServantName + " seems disappointed at her low production.");
      }
      temp = int(temp * 10) / 10;
      if(temp > 2 && temp <= 3)
      {
         _root.AddText(_root.ServantName + " nods to #slave, but encourages her to try harder next time.");
      }
      if(temp > 3 && temp <= 4)
      {
         _root.AddText(_root.ServantName + " smiles in approval, blushing as she empties the milk.");
      }
      if(temp > 4 && temp <= 5)
      {
         _root.AddText(_root.ServantName + " empties the milk, congratulating #slave on the large quantity of milk.");
      }
      if(temp > 5 && temp <= 6)
      {
         _root.AddText(_root.ServantName + " busies herself with collecting the milk, her nipples obviously erect.");
      }
      if(temp > 6)
      {
         _root.AddText(_root.ServantName + " winks to #slave when she thinks you aren\'t looking, licking her lips as she collects the many bottles of milk.");
      }
      _root.CustomFlag4 = _root.CustomFlag4 + int(temp);
   }
   if(_root.IsDickgirl() && _root.CheckBitFlag2(13) && !_root.CheckBitFlag2(12))
   {
      temp = _root.CustomFlag3 / 7;
      if(!_root.CheckBitFlag2(18))
      {
         _root.AddText("#slave is hesitant to use such a strange looking machine, but reluctantly agrees after you tell her it is safe.\r\r");
         if(temp < 1)
         {
            _root.AddText("She easily slides into her small erection into the cock-milker, smiling from the pleasure and lubrication of the machine.  She looks unsure, but glances up at you, eager to please.\r\r");
         }
         if(temp >= 1 && temp < 2)
         {
            _root.AddText("She rubs her cock against the device\'s opening before sliding her length inside.  She sighs with pleasure from the device\'s textured nubs, relaxing as her arousal grows.  She smiles, enjoying the sensation but nervous about the experience.\r\r");
         }
         if(temp >= 2 && temp < 3)
         {
            _root.AddText("Her cock swells up with lust at the thought of being milked, till it is nearly as large as the opening it is supposed to fit in. #slave pants, rubbing her cock against the opening, trying to slide it into the lubricated passage.  She gets increasingly frantic as her lust builds, grunting and shuddering, stroking herself, trying to get inside.  With a moan she finally slides her large dick into the cock-milker\'s sleeve, a dazed but happy look on her face.  Glancing up, she smiles nervously.\r\r");
         }
         if(temp >= 3)
         {
            _root.AddText("She moans at the idea of having her cock milked, reaching a full throbbing erection instantly.  Her reactions seem oversexed to the extreme, perhaps a sign that she needs to focus on trainings other than sex.  Her hermaphroditic cock is huge, many times larger than normal and you wonder if she will fit her largeness into the machine.  She grunts, stroking herself while rubbing her cock-head against the cock-sleeve\'s opening, her efforts intensifying as her dick seems to swell with arousal.  She dribbles precum liberally, down her shaft, over her hands, and into the milker, before finally sliding in with an orgasmic cry.  She looks up, panting with lust and waiting for you to activate the device.\r\r");
         }
         _root.AddText("You flip the switch, activating the device.  A quiet \'whrrrrrr-slush-slush-slush\' emanates from the milker as it powers up.  #slave moans in appreciation, the sleeve around her cock pulsing and sucking at her with a rhythmic milking motion.");
         if(int(Math.random() * 3) + _root.VarSpecialRounded / 30 > 3)
         {
            _root.AddText("\r\rShe shudders as her cock fills out the sleeve to its limits, her erection suddenly growing to unusual size.  She groans as a massive orgasm crashes over her like a tsunami. Her legs quickly give out as her cock pumps spurt after spurt after spurt of cum into the machine, each one longer than the last.  She lays on the ground, hips trembling upwards with each pulse of cum for over a minute.  She spends most of the next hour in a semi-conscious state, orgasming from time to time, but always dribbling a steady stream of cum.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
            _root.Points(0,0.5,0,3,0,1,0,0,0,0,0,4,3,0,5,0,5,5,0,-30);
            _root.CustomFlag3 = _root.CustomFlag3 + 0.3;
            return undefined;
         }
         if(temp < 2)
         {
            _root.AddText("She pants as the machine brings her to orgasm, milking her cock of every drop of cum.  ");
            if(_root.VaribidoRounded > 80)
            {
               _root.AddText("Incredibly, her dick stays erect within the cock-sleeve, dribbling cum as she enjoys the machine\'s ministrations for the rest of the hour.\r\r");
               _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,0,1,0,-10,0,0,2.5,0,0);
               _root.MinLibido = _root.MinLibido + 1;
            }
            _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,-1,1,0.2,-5,0,3,0.5,0,0);
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
            if(_root.MinLibido < 50)
            {
               _root.MinLibido = _root.MinLibido + 1;
            }
         }
         else
         {
            _root.AddText("She groans as a massive orgasm crashes over her like a tsunami. Her legs quickly give out as her cock pumps spurt after spurt after spurt of cum into the machine, each one longer than the last.  She lays on the ground, hips trembling upwards with each pulse of cum for over a minute.  She spends most of the next hour in a semi-conscious state, orgasming from time to time, but always dribbling a steady stream of cum.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
            _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,4,1,0,0);
            _root.MinLibido = _root.MinLibido + 2;
         }
         _root.SetBitFlag2(18);
         _root.AddText("\r\rYou realize afterwards that you forgot to connect the reservoir - her cum is all over the ground, lost.");
         return undefined;
      }
      if(temp < 1)
      {
         _root.AddText("She awkwardly but easily slides into the milker\'s sleeve, her cock reaching full erectness from the remembered pleasures of her last attempt with the machine.  Her nipples become erect, her skin blushes, and she looks up, waiting for her pleasure to begin.\r\r");
      }
      if(temp >= 1 && temp < 2)
      {
         _root.AddText("She places the device over her fully-engorged erection and slides it down slowly, teasing herself.  A small gasp escapes her mouth from the pleasure of the cock-sleeve\'s texture.  She eagerly awaits the activation.\r\r");
      }
      if(temp >= 2 && temp < 3)
      {
         _root.AddText("She happily attempts to slip her dick back into the machine\'s opening, her large cockhead making things difficult.  Her large engorged cock begins drizzling precum as her efforts to squeeze it inside intensify. With a final satisfied sluuurrrp it squeezes inside, lubricated by her own pre.\r\r");
         _root.SlaveSpeak("Please " + _root.Master + ", I\'m ready!",true);
         _root.AddText("\r\r");
      }
      if(temp >= 3)
      {
         _root.AddText("She shreds her clothes, anxious to get them off for another session with the machine.  Her cock surges to its full massive length in seconds, engorged and dripping with precum.  The cock-milker\'s velvet sleeve soaks up her pre easily as you rub against her dick, helping her squeeze her massive girth inside.  She orgasms, spraying the first of many loads into the artificial pussy.\r\r");
      }
      _root.AddText("You activate the cock-milker, setting off a chorus of moans from your slave as the cock-sleeve mercilessly pleasures her. It ripples and sucks her dick, teasing ribbons of precum, vibrating out moans of pleasure.  She plays with her nipples and pussy, spreading waves of pleasure throughout her quivering body.  You decide to speed things up and lick her ear, ");
      if(temp < 3)
      {
         _root.AddText("triggering the first of many cum-draining orgasms from #slave.  She holds her hips forwards, almost begging the machine for more.  ");
      }
      else
      {
         _root.AddText("and she shudders as her cock flexes, straining the sleeve.  A torrent of cum erupts from her as she orgasms, her hips spasming back and forth as her fluids dribble out, the milker unable to keep up with her flow.  ");
         if(_root.CheckBitFlag2(9))
         {
            _root.AddText(_root.ServantName + " drops down and begins licking the excess off the floor.  " + _root.ServantHeSheUC);
            if(_root.ServantGender > 3)
            {
               _root.AddText(" devour");
            }
            else
            {
               _root.AddText(" devours");
            }
            _root.AddText(" the small puddle and fixes #assistanthisher mouth on the junction of the machine and #slave\'s cock, eagerly getting #assistanthisher fix from the cum leaking out.  ");
         }
         _root.AddText("#slave\' orgasm is long and intense, but eventually subsides.\r\r");
      }
      if(temp < 3 && int(Math.random() * 5) + _root.VarSpecialRounded / 25 > 4)
      {
         _root.AddText("\r\rHer cock stays erect, <b>swelling</b> after her orgasm and leaking precum.  She  rolls her eyes back, lost in the pleasure of cock as it is milked for more an more orgasms, each more messy and productive then the one before.  The reservoir slowly fills with more and more of her cum, the cock-milker leaking from her high fluid output.  ");
         if(_root.CheckBitFlag2(9))
         {
            if(_root.ServantGender > 3)
            {
               _root.AddText(_root.ServantName + " greedily lap up the cum, not wasting a drop.");
            }
            else
            {
               _root.AddText(_root.ServantName + " greedily laps up the cum, not wasting a drop.");
            }
         }
         _root.Points(0,0.5,0,3,0,1,0,0,0,0,0,4,3,0,5,0,1,5,0,-15);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         _root.CustomFlag3 = _root.CustomFlag3 + 0.5;
         _root.MinLibido = _root.MinLibido + 3;
         temp = int(10 * (Math.random() * (_root.CustomFlag3 + 4) / 10 * _root.VarLibidoRounded / 15 + _root.Slutiness / 2 + _root.MinLibido / 8)) / 10;
         if(temp > 15)
         {
            _root.AddText("\r\rYou check the cock-milker\'s reservoir, shocked to see that it has overflowed!  You guess she must have pumped out " + String(int(temp / 5 * 10) / 10) + " bottles of cum, but there is only enough left for 3 bottles.");
            temp = 15;
         }
         else
         {
            _root.AddText("\r\rYou check the machine\'s reservoir, and see #slave has filled it with " + String(int(temp / 5 * 10) / 10) + " bottles worth of cum!  You bottle it into " + String(int(temp / 5)) + " filled bottles.");
         }
         _root.CustomFlag2 = _root.CustomFlag2 + int(temp / 5);
         return undefined;
      }
      if(_root.VarLibidoRounded > 70 && _root.VarSpecialRounded > 20 && _root.SMLust > 60 && temp >= 3)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.AddText("#slave looks up at you, her cock still very erect inside the sleeve");
         if(_root.CheckBitFlag2(9))
         {
            _root.AddText(", with #assistant still trying to get at the leftover cum around the milker");
         }
         _root.AddText(", and asks if you would like to try some?");
         _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,5,1,0,-15);
         _root.DoYesNoEventXY(321);
         _root.MinLibido = _root.MinLibido + 3;
         return undefined;
      }
      if(temp < 3 && _root.VarLibidoRounded > 65)
      {
         _root.AddText("\r\r#slave\'s rock-hard cock remains firm as her load is drained away.  She reaches down to three-finger her pussy, her libido driving her to penetrate herself in hopes of another orgasm.  She forcibly rapes her own pussy, anything to aid the velvet sleeve around her cock in bringing her to orgasm.  #slave\'s cum erupts into the milker, her mouth hanging open and drooling from the pleasure.");
         if(_root.VarLibidoRounded > 90)
         {
            _root.AddText("  Impressively, she is still erect and masturbating, her eyes glassy and fogged with lust.  She continues to shudder with small orgasms for some time, each one spurting small jets of cum that are quickly collected.");
            _root.Points(0,0,0,-0.5,0,0.5,0,0,0,0,0,0,1,0,-5,0,0,2,0,5);
            _root.MinLibido = _root.MinLibido + 2;
         }
         _root.Points(0,1,0,-1,0,1,0,0,0,0,0,-1,2,0.2,-15,0,4,3,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         _root.MinLibido = _root.MinLibido + 2.5;
         temp = int(10 * (Math.random() * (_root.CustomFlag3 + 4) / 10 * _root.VarLibidoRounded / 15 + _root.Slutiness / 2 + _root.MinLibido / 8)) / 10;
         if(temp > 15)
         {
            _root.AddText("\r\rYou check the cock-milker\'s resevoir, shocked to see that it has overflowed!  You guess she must have pumped out " + String(int(temp / 5 * 10) / 10) + " bottles of cum, but there is only enough left for 3 bottles.");
            temp = 15;
         }
         else
         {
            _root.AddText("\r\rYou check the machine\'s resevoir, and see #slave has filled it with " + String(int(temp / 5 * 10) / 10) + " bottles of cum!  You bottle it into " + String(int(temp / 5)) + " filled bottles.");
         }
         _root.CustomFlag2 = _root.CustomFlag2 + int(temp / 5);
         return undefined;
      }
      if(temp < 3)
      {
         _root.AddText("\r\r#slave sighs and removes the device with a loud SLUUURP, and her still engorged member flops against her thigh, still dribbling cum.  She informs you that she\'s only taking a small breather, and her cock will be back where it belongs shortly, she says with a wink.");
         _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,-1,1,0.2,-5,0,3,0.5,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         if(_root.MinLibido < 50)
         {
            _root.MinLibido = _root.MinLibido + 1;
         }
      }
      else if(temp >= 3 && temp < 4)
      {
         _root.AddText("#slave grasps hold of the milker and forcefully tugs at it, gasping as each inch of her cock is pulled from the agonizingly tight channel.  It finally pulls free with a pop, splattering cum over her already soaked midsection.  Her softening member slaps against her thigh, nearly to her knee, and still leaking cum.");
         if(_root.CheckBitFlag2(9))
         {
            if(_root.ServantGender > 3)
            {
               _root.AddText("  #assistant beg to clean her, but #slave declines.");
            }
            else
            {
               _root.AddText("  #assistant begs to clean her, but #slave declines.");
            }
         }
         _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,4,1,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         if(_root.MinLibido < 85)
         {
            _root.MinLibido = _root.MinLibido + 2;
         }
      }
      else if(temp >= 4)
      {
         _root.AddText("#slave pants and moans like an animal, her huge softening prick still large enough to be fill the machine\'s cum-slick sleeve to capacity.  She slowly tugs at it, slick cock squirming out an inch at a time.  By the time she works it off her head, she is panting and nearly totally engorged again.  ");
         if(_root.CheckBitFlag2(9))
         {
            _root.AddText("#assistantis on #slave\'s dripping cock in a flash, licking and slurping the cum off the shaft and sucking the last drops from the tip and urethra.  Through it all, #slave smiles dreamily, as if listening to some inner voice.");
         }
         _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,5,1,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.MinLibido = _root.MinLibido + 4;
      }
      temp = int(10 * (Math.random() * (_root.CustomFlag3 + 4) / 10 * _root.VarLibidoRounded / 20 + _root.Slutiness / 2 + _root.MinLibido / 10)) / 10;
      if(temp > 15.49)
      {
         _root.AddText("\r\rYou check the cock-milker\'s resevoir, shocked to see that it has overflowed!  You guess she must have pumped out " + String(int(temp / 5 * 10) / 10) + " bottles of cum, but there is only enough left for 3 bottles.");
         temp = 15;
      }
      else
      {
         _root.AddText("\r\rYou check the machine\'s resevoir, and see #slave has filled it with " + String(int(temp / 5 * 10) / 10) + " bottles worth of cum!  You bottle it into " + String(int(temp / 5)) + " filled bottles.");
      }
      _root.CustomFlag2 = _root.CustomFlag2 + int(temp / 5);
   }
   if(_root.IsDickgirl() && _root.CheckBitFlag2(13) && _root.CheckBitFlag2(12))
   {
      temp = _root.CustomFlag / 7;
      if(!_root.CheckBitFlag2(18))
      {
         if(_root.Slutiness <= 4 && _root.MilkInfluence < 1 && temp <= 2)
         {
            _root.AddText("#slave is reluctant to try the devices.  You insist that being milked is good for her, and a desirable skill for her to learn.  #slave reluctantly places the breast cups over her nipples.  You notice her blushing as you place the cock-milker over her quickly hardening penis.");
         }
         if(_root.Slutiness > 4 && temp <= 2)
         {
            _root.AddText("#slave is a little unsure of herself, but eagerly bares her nipples and cock to you.  She smiles lewdly as she pushers her cock into the milker and secures the milk cups to her breasts.");
            if(_root.MilkInfluence > 0 || _root.Lactation >= 30)
            {
               _root.AddText("  Milk begins dribbling from her nipples before you can activate the machine.");
            }
         }
         if((_root.MilkInfluence > 0 || _root.Lactation >= 30) && _root.Slutiness <= 4 && temp <= 2)
         {
            _root.AddText("#slave is hesitant, but a blank expression crosses her face.  She slips into the milking equipment with a practiced air, her breasts already lactating.");
         }
         if(temp > 2)
         {
            _root.AddText("#slave steps up confidently, her uncovered breasts jiggling seductively.  The suction cups fit perfectly over her erect nipples, but her large cock barely squeezes into the tube.  By the time she is fully inserted, #slave is rigid with lust.");
         }
         _root.SetBitFlag2(18);
      }
      else
      {
         if(_root.CustomFlag < 6)
         {
            _root.AddText("#slave allows you to help her into the machines, her dick slipping easily into the milker sleeve as you attach her nipple cups.");
         }
         if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
         {
            _root.AddText("#slave is immediately hard and ready to go at the sight of the equipment.  A tiny drop of milk falls into the milk-cups as you get her hooked in.");
         }
         if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
         {
            _root.AddText("You attach the milking machine to her breasts, noting how much larger they are now than when training started.  You smile as milk begins to trickle from her, and stoop down to help her squeeze a large erection into the cock-milker.");
         }
         if(_root.CustomFlag >= 20 && _root.CustomFlag < 28)
         {
            _root.AddText("#slave sashays into the milking room, liquid already dribbling from her nipples.  She helps you strap her in to the equipment, moaning in passion as you work her \'equipment\' into the machine.  A small spurt of jizz sprays into the tube as you seat the cocksleeve firmly at her base.");
         }
         if(_root.CustomFlag >= 28)
         {
            _root.AddText("#slave squeezes her tits into the milk-cups, moaning as her milk lets down, even with the machine off.  Her huge cock is difficult to squeeze into the milking gear, but she cums a few times as you struggle with it, the extra lubrication allowing it to slide inside.");
         }
      }
      temp = int(10 * (Math.random() * (_root.CustomFlag3 + 4) / 10 * _root.VarLibidoRounded / 20 + _root.Slutiness / 2 + _root.MinLibido / 10)) / 10;
      if(temp < 1)
      {
         temp = 1;
      }
      _root.AddText("  ");
      _root.HideImages();
      if(temp < 2)
      {
         _root.AddText("#slave reacts the sensations of the twin machines, orgasming several times, but it\'s obvious she isn\'t enjoying it very much.");
      }
      if(temp >= 2 && temp < 4)
      {
         _root.AddText("#slave moans out loud in surprise as the machines switch on.  She cums quickly, the stimulation overpowering any self-control as she is brought to more orgasms, each more powerful and draining than the last.");
      }
      if(temp >= 4 && temp < 7)
      {
         _root.AddText("The machines whir and \'slush\' softly as you activate them, squeezing and stroking your slave\'s erogenous zones.  #slave\'s legs give out as her orgasms begin washing over her.  She lays back onto a few cushions as she begins trembling and orgasming over and over.");
      }
      if(temp >= 7 && temp < 10)
      {
         _root.AddText("#slave moans in pleasure, the cock-milker rippling around her dick, suctioning away her precum.  Her nipples are stiff little nubs, dripping a steady stream of milk as the orgasms begin.  She cums too many times to count, each time accompanied by a surge of milk and cum.");
      }
      if(temp >= 10 && temp < 14)
      {
         _root.AddText("#slave\'s pussy drips as her cock and nipples leak into their receptacles.  With a cry of pleasure, she cums as the machines are switched on.  Her hands drop to her wet sex, fingerfucking herself hard, her cock spraying orgasm after orgasm, nipples pouring out milk, pushing herself to inhuman levels of pleasure.");
      }
      if(temp >= 14)
      {
         _root.AddText("#slave lays back, already playing with her pussy, precum filling the cocksleeve, as she awaits the mechanized pleasure.  You activate the switch and watch with some concern as she appears to orgasm nearly continuously for the duration of the milking.");
      }
      temp2 = temp;
      if(_root.CustomFlag < 13)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,-1,1,0.2,-7,0,3,0.7,0,0);
         if(_root.MinLibido < 50)
         {
            _root.MinLibido = _root.MinLibido + 1;
         }
      }
      if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.Points(0,1,0,-0.6,0,1,0,0,0,0,0,-1,2,0.4,-8,0,4,1,0.1,0);
         if(_root.MinLibido < 85)
         {
            _root.MinLibido = _root.MinLibido + 2;
         }
      }
      if(_root.CustomFlag >= 20)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.Points(0,1,0,-0.8,0,1,0,0,0,0,0,-1.5,4,0.5,-8,0,5,2,0.2,0);
         _root.MinLibido = _root.MinLibido + 4;
      }
      temp = temp2;
      if(temp > 25)
      {
         _root.AddText("\r\rYou check the cock-milker\'s resevoir, shocked to see that it has overflowed!  You guess she must have pumped out " + int(temp / 5 * 10) / 10 + " bottles of cum, but there is only enough left in the tank for five bottles.");
         temp = 25;
      }
      else
      {
         _root.AddText("\r\rYou check the machine\'s resevoir and see #slave has filled it with " + int(temp / 5 * 10) / 10 + " bottles worth of cum!  You bottle " + int(temp / 5) + " full bottles.");
      }
      _root.CustomFlag2 = _root.CustomFlag2 + int(temp / 5);
      _root.AddText("\r\r");
      temp = (_root.CustomFlag + 6) / 12 * (_root.MilkInfluence / 5 + Math.random() * _root.VarLibidoRounded / 40 + _root.VarConstitutionRounded / 30);
      if(_root.MilkInfluence <= 0 && _root.CustomFlag < 6)
      {
         if(_root.VarSpecialRounded > 20 && int(Math.random() * 8) < 1)
         {
            _root.AddText("#slave <b>began to spontaneously lactate</b>! Her nipples have inexplicably grown larger and more sensitive, and her pussy appears wetter.  You suspect she has worked some magic upon herself unconsciously.\r\r");
            _root.CustomFlag = 6;
            _root.Lactation = _root.Lactation + 2;
         }
         else
         {
            temp = 0;
            _root.AddText("#slave\'s nipples are sore from the machine\'s efforts, but have not produced any milk yet.");
            return undefined;
         }
      }
      if(_root.MilkInfluence > 0 && _root.MilkInfluence < 20)
      {
         _root.MilkInfluence = _root.MilkInfluence + 1;
      }
      _root.Lactation = _root.Lactation + 1;
      _root.CustomFlag4 = _root.CustomFlag4 + int(temp);
      if(temp >= 10)
      {
         _root.AddText("#slave has overfilled the milk tank!  Despite the mess, a large amount of milk remains safe for bottling - 10 bottles\' worth!  ");
         temp = 10;
      }
      else
      {
         _root.AddText("When the milking is complete " + int(temp * 10) / 10 + " bottles worth of milk are in the tank.  ");
      }
      showncockflavor = false;
      if(_root.CustomFlag >= 28)
      {
         _root.AddText("#slave\'s nipples are cherry-red, erect, and still dribbling more milk.");
      }
      if(_root.CustomFlag >= 20 && _root.CustomFlag < 28 && _root.CustomFlag3 >= 15 && _root.CustomFlag3 < 20)
      {
         _root.AddText("She looks tired but happy as you separate her from the devices.  #slave\'s cock and breasts are both stiff, a little swollen, and leaking fluids.");
         showncockflavor = true;
      }
      else if(_root.CustomFlag >= 20 && _root.CustomFlag < 28)
      {
         _root.AddText("She looks tired but happy as you separate her from the devices.  #slave\'s breasts are stiff, a little swollen, and leaking fluids.");
      }
      if(_root.CustomFlag >= 13 && _root.CustomFlag < 20 && _root.CustomFlag3 >= 12.5 && _root.CustomFlag3 < 15)
      {
         _root.AddText("#slave\'s nipples and cock are both a little red and puffy.");
         showncockflavor = true;
      }
      else if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
      {
         _root.AddText("#slave\'s nipples are both a little red and puffy.");
      }
      if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
      {
         _root.AddText("#slave seems tired and sore, but eager to be milked again.");
      }
      if(_root.CustomFlag < 6)
      {
         _root.AddText("#slave is sore but happy.");
      }
      if(!showncockflavor)
      {
         if(_root.CustomFlag3 >= 20)
         {
            _root.AddText("  Her cock is massively swollen as she frees it from the machine, huge, the head nearly purple and drizzling cum.");
         }
         if(_root.CustomFlag3 >= 12.5 && _root.CustomFlag3 < 15)
         {
            _root.AddText("  #slave\'s cock is stiff, a little swollen, and leaking fluids.");
         }
         if(_root.CustomFlag3 >= 9 && _root.CustomFlag3 < 12.5)
         {
            _root.AddText("  #slave\'s cock is a little red and puffy.");
         }
      }
   }
}
function GetCurrentSexActLevelAsAssistant(type)
{
   if((var _loc0_ = Math.abs(type)) !== 29)
   {
      return undefined;
   }
   if(_root.VarConstitutionRounded >= 70 && _root.VarLibidoRounded >= 75)
   {
      return 5;
   }
   if(_root.VarConstitutionRounded >= 40 && _root.VarLibidoRounded >= 60)
   {
      return 4;
   }
   if(_root.VarConstitutionRounded >= 25 && _root.VarLibidoRounded >= 35)
   {
      return 3;
   }
   if(_root.VarConstitutionRounded >= 15 || _root.VarLibidoRounded >= 25)
   {
      return 2;
   }
   if(_root.TotalSex4 > 0)
   {
      return 1;
   }
   return 0;
}
function DoPlanningActionAsAssistant(act)
{
   return false;
}
function ShowSlaveSex4()
{
   _root.LevelUpSexAct();
   if(_root.AssistantData.CheckBitFlag2(12) && (!_root.AssistantData.CheckBitFlag2(13) || !_root.IsDickgirl()))
   {
      if(_root.TentaclePregnancy < 1 && _root.MilkInfluence < 1 && _root.Lactation < 30)
      {
         _root.AddText("You attach the pumps to #slave, but she isn\'t lactating.  You keep them on a while to see if anything will happen.  ");
         if(!_root.AssistantData.CheckBitFlag2(55) && int(Math.random() * 5) == 0)
         {
            _root.AddText("#assistant rubs and massages #slave\'s breasts, trying to help her to start lactating.  After a few minutes, #slave\'s breasts swell noticeably bigger as #assistant\' nymph magic activates!  Dribbles of milk appear on #slave\'s nipples and run down her breasts.\r\r");
            _root.ChangeBustSize(1.2);
            if(_root.Lactation < 30)
            {
               _root.Lactation = 30;
            }
            _root.AssistantData.SetBitFlag2(55);
         }
         else if(int(Math.random() * 2) > 0)
         {
            _root.AddText("  After nearly an hour of suction, #slave gasps in surprise! Trickles of milk flow from her very swollen nipples into the cups, but you are unsure if she can repeat it.");
            _root.Lactation = _root.Lactation + 2;
         }
         else
         {
            _root.AddText("  You give up after a while. #slave\'s nipples are puffy and sore.");
         }
         _root.DoEvent(9999);
         return true;
      }
      if(_root.LevelSex4 == 5)
      {
         _root.AddText("#slave eagerly steps up to the milker.  She produces milk expertly, easily and constantly orgasming through the whole experience.");
         _root.Points(0,0.5,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,1,-5,0,3,2,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 17);
      }
      if(_root.LevelSex4 == 4)
      {
         if(_root.LevelUp)
         {
            _root.AddText("Eagerly, #slave steps into the milking station.  You attach the suction cups and strap her down.  You stroke her pussy and insert a dildo, noticing a gush from her pussy as she orgasms.  Her milk begins to flow before you even turn on the machine. You work oil up into her anus and insert a well lubricated anal plug. #slave pants heavily, the milk flowing heavily from her stiff nipples.\r\r");
            _root.AddText("You let all the members of the household take their turns offering cocks, pussies, or breasts to #slave to be licked and sucked.  #slave\'s mouth brings person after person to orgasm.  She orgasms frequently as well and produces rivers of milk.  You try a new experiment, having people put their pussies or cocks in #slave\'s hands. #slave compulsively strokes them and produces even more milk.\r\r");
            _root.AddText("You have a female rub #slave\'s back with her breasts.  #slave orgasms almost immediately, even though she just came.  You add this as part of the rotation and watch for a while to get an idea of how much milk is produced. You wonder what would happen if someone fucked the woman rubbing #slave with either a cock or a strap-on.  You proceed with the experiment and #slave comes again.  Apparently she can recognize the difference, whether ");
            _root.AddText("it\'s a difference in the sensations or a sign of awareness of what\'s happening around her.  You continue to experiment and discover that #slave produces the most milk when you switch between having the woman fucked and having her pay attention only to #slave.  #slave is most likely to orgasm and produce more milk when the woman either stops or starts being fucked.\r\r");
            _root.AddText("You\'ve learned as much about producing milk as you can, so you step forward and take full part in the rotation with the rest of the household.  You help make #slave come again and again, filling the milk bucket. You yourself are completely satisfied, as is the rest of the household.\r\r");
            _root.AddText("As #slave lies at her station, entirely spent, you disconnect the suction cups and hose her down.  You dry her gently with a towel as she naps, a look of satisfaction on her face.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 17);
         }
         else
         {
            _root.AddText("#slave orgasms from the dildo, strap ons, and actual cocks, but could still better her milk production...");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 17);
         }
         _root.Points(0,0.4,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.8,-4,0,3,2,0,0);
      }
      if(_root.LevelSex4 == 3)
      {
         if(_root.LevelUp)
         {
            _root.AddText("#slave shudders, her breasts heaving as you connect the milker.  This is an ideal time to try having the various members of the household take turns fucking her pussy and ass with cocks and strap-ons.  Unsurprisingly, you find that she produces the most milk (and orgasms) when both pussy and ass are filled.  Further, you observe that the most likely time for her to orgasm is when a switch is being made.\r\r");
            _root.AddText("As a result, you make a rule.  From now on, she shall always have both holes filled unless in the middle of a switch.  You add the dildo and the anal plug as well, since it is difficult to position two people to fuck both pussy and ass at the same time while she is at the milking station.  You schedule frequent swaps, as the change seems to stimulate her.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 17);
         }
         else
         {
            _root.AddText("#slave comes to orgasm after you kiss her. The milk is flowing well, but might work better if she had more lust or endurance.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 16);
         }
         _root.Points(0,0.3,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.6,-3,0,3,2,0,0);
      }
      if(_root.LevelSex4 == 2)
      {
         if(_root.LevelUp)
         {
            _root.AddText("Once you get the milking equipment connected, you have the various members of your household expose their cocks and pussies to #slave\'s mouth.  You find that the greatest amount of milk is produced right after a switch, so you have everyone rotate frequently.  Occasionally, you have someone kiss her.  Again, it seems like switching from oral to a kiss or vice versa, causes the most milk to flow.\r\r");
            _root.AddText("You also measure the amount of milk against the number of orgasms.  You find that the more orgasms she has, the more milk that she produces.  This confirms what you\'ve been observing.  The more you feed her arousal, the faster the milk comes.  You decide to keep up the experiments.  Not only is the milk valuable, but you are really enjoying watching how it affects her.");
         }
         else
         {
            _root.AddText("You measure milk produced against orgasms.  #slave has a some of both, but could produce more if she were more fit or horny.");
         }
         _root.Points(0,0.2,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.4,-2,0,2,2,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 16);
      }
      if(_root.LevelSex4 == 1)
      {
         if(_root.LevelUp)
         {
            _root.AddText("You decide that the best way to analyze #slave\'s milking is to try each activity in turn and see which produces the most milk.  For this session, you decide to use just the milking equipment.  You hook up the cups and strap her down, then lube and insert the dildo and anal plug.  #slave begs for more, even though she has already cum twice.  You continue the experiment, watching the milk flow.\r\r");
            _root.AddText("#slave doesn\'t have a lot of room to move, but she tries desperately to rub herself against the harness.  She is writhing in acute arousal.  Despite cumming every so often, she still begs for more and is clearly feeling frustrated.  Finally, you take pity on her, and with one eye on the milk output, kiss her deeply.  Her tongue trying to crawl down your throat, she kisses you with passion.  The milk flow increases sharply.  She orgasms yet again and then releases a string of explosive orgasms before finally passing out.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 2) + 16);
         }
         else
         {
            _root.AddText("Neither you nor #slave really has the hang of this yet.  You keep experimenting to try to produce more milk.");
            _root.ShowMovie(EventMilk,1,1,16);
         }
         _root.Points(0,0.1,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.3,-1,0,2,2,0,0);
      }
      if(_root.LevelSex4 == 0)
      {
         _root.SlaveSpeak("Well, I guess we can try this.",true);
         _root.AddText("\r\r#slave is already panting with arousal at the prospect of being milked and is sensitive to even the slightest touch.  Juices are already leaking from her pussy.  When you ask her a question about how she is feeling, she doesn\'t look like she even heard you.  She looks sort of dazed and disconnected from her surroundings.  You attach the suction cups to her nipples and strap her into place so that she doesn\'t pull them loose.  Milk\'s already flowing.  #slave moans.\r\r");
         _root.SlaveSpeak("I need to be fucked.  Please, fuck me now.  Oh, I need something inside me immediately.  Ohhhh...",true);
         _root.AddText("\r\rYou lube and then insert the large dildo that came with the milking equipment.  #slave shudders and comes in a screaming orgasm.  She moans.  You can see that her orgasm brought some relief, but she still needs more stimulation.  You rub some oil on her ass and insert the anal plug.  #slave comes again.  You place her regular dildo in front of her mouth, and she licks and sucks it compulsively.  When she comes again, #assistant removes it.\r\r");
         _root.AddText("You tell #assistant to put her pussy in front of #slave\'s face.  She does, and #slave immediately starts to lick and suck it.  #slave comes three more times before #assistant does.  You, your assistant, and all your slaves take turns letting her suck your cocks and pussies.  Occasionally one of you removes either the dildo or the anal plug and fucks her with cock or strap on.  If you stick a cock, pussy, or strap on near her hand, she strokes it compulsively.  She still seems disconnected and unaware of what she is doing.  By the time the milking is over, you are all satisfied except #slave.  Nothing she does seems to give her true release.  Finally, she comes to an explosive orgasm and passes out.  You remove the suction cups, the dildo, and the anal plug, cleaning them for next time.  ");
         _root.AddText("You wash off #slave as well.  She was covered in cum.  She doesn\'t wake, so you decide to give her a little more time.");
         _root.AddText("\r\rYou see that you\'ve collected a good amount of milk from her.  You wonder how this compares with other yields.  Also, what activities produced the most milk?  You were too intrigued at the time to keep track.  In the future, you\'ll have to keep more distance so as to evaluate better.");
         _root.Points(0,0,-0.5,-0.5,0,1,0,0,0,0,0,-0.5,2,0.2,-0.5,0,2,2,0,0);
         _root.ShowMovie(EventMilk,1,1,16);
      }
   }
   if(_root.IsDickgirl() && _root.AssistantData.CheckBitFlag2(13) && !_root.AssistantData.CheckBitFlag2(12))
   {
      temp = _root.ClitCockSize * 2;
      if(_root.LevelSex4 == 0)
      {
         _root.AddText("#slave is hesitant to use such a strange looking machine, but reluctantly agrees after you tell her it is safe.\r\r");
         if(temp < 1.5)
         {
            _root.AddText("She easily slides into her small erection into the cock-milker, smiling from the pleasure and lubrication of the machine.  She looks unsure, but glances up at you, eager to please.\r\r");
         }
         if(temp >= 1.5 && temp < 2.4)
         {
            _root.AddText("She rubs her cock against the device\'s opening before sliding her length inside.  She sighs with pleasure from the device\'s textured nubs, relaxing as her arousal grows.  She smiles, enjoying the sensation but nervous about the experience.\r\r");
         }
         if(temp >= 2.4 && temp < 3)
         {
            _root.AddText("Her cock swells up with lust at the thought of being milked, till it is nearly as large as the opening it is supposed to fit in.  #slave pants, rubbing her cock against the opening, trying to slide it into the lubricated passage.  She gets increasingly frantic as her lust builds, grunting and shuddering, stroking herself, trying to get inside.  With a moan she finally slides her large dick into the cock-milker\'s sleeve, a dazed but happy look on her face.  Glancing up, she smiles nervously.\r\r");
         }
         if(temp >= 3)
         {
            _root.AddText("She moans at the idea of having her cock milked, reaching a full throbbing erection instantly.  Her reactions seem oversexed to the extreme, perhaps a sign that she needs to focus on trainings other than sex.  Her hermaphroditic cock is huge, many times larger than normal and you wonder if she will fit her largeness into the machine.  She grunts, stroking herself while rubbing her cock-head against the cock-sleeve\'s opening, her efforts intensifying as her dick seems to swell with arousal.  She dribbles precum liberally, down her shaft, over her hands, and into the milker, before finally sliding in with an orgasmic cry.  She looks up, panting with lust and waiting for you to activate the device.\r\r");
         }
         _root.AddText("You flip the switch, activating the device.  A quiet \'whrrrrrr-slush-slush-slush\' emanates from the milker as it powers up.  #slave moans in appreciation, the sleeve around her cock pulsing and sucking at her with a rhythmic milking motion.");
         if(!_root.AssistantData.CheckBitFlag2(55) && int(Math.random() * 5) == 0)
         {
            _root.AddText("\r\r#assistant bends over to lick #slave\'s pussy while the cock milker whirrs.  Her hands brush #slave\'s cock, and #slave shudders as her cock suddenly fills out the sleeve to its limits, her erection suddenly growing to unusual size.  She groans as a massive orgasm crashes over her like a tsunami. Her legs quickly give out as her cock pumps spurt after spurt after spurt of cum into the machine, each one longer than the last.  She lays on the ground, hips trembling upwards with each pulse of cum for over a minute.  She spends most of the next hour in a semi-conscious state, orgasming from time to time, but always dribbling a steady stream of cum.");
            _root.ChangeClitCockSize(1.2);
            _root.AssistantData.SetBitFlag2(55);
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
            _root.Points(0,0.5,0,3,0,1,0,0,0,0,0,4,3,0,5,0,5,5,0,0);
            _root.DoEvent(9999);
            return true;
         }
         if(temp < 2)
         {
            _root.AddText("She pants as the machine brings her to orgasm, milking her cock of every drop of cum.  ");
            if(_root.VaribidoRounded > 80)
            {
               _root.AddText("Incredibly, her dick stays erect within the cock-sleeve, dribbling cum as she enjoys the machine\'s ministrations for the rest of the hour.\r\r");
               _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,0,1,0,-10,0,0,2.5,0,0);
               _root.MinLibido = _root.MinLibido + 1;
            }
            _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,-1,1,0.2,-5,0,3,0.5,0,0);
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
            if(_root.MinLibido < 50)
            {
               _root.MinLibido = _root.MinLibido + 1;
            }
         }
         else
         {
            _root.AddText("She groans as a massive orgasm crashes over her like a tsunami. Her legs quickly give out as her cock pumps spurt after spurt after spurt of cum into the machine, each one longer than the last.  She lays on the ground, hips trembling upwards with each pulse of cum for over a minute.  She spends most of the next hour in a semi-conscious state, orgasming from time to time, but always dribbling a steady stream of cum.");
            _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
            _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,4,1,0,0);
            _root.MinLibido = _root.MinLibido + 2;
         }
         _root.AddText("\r\rYou realize afterwards that you forgot to connect the reservoir - her cum is all over the ground, lost.");
         _root.DoEvent(9999);
         return true;
      }
      if(temp < 1)
      {
         _root.AddText("She awkwardly but easily slides into the milker\'s sleeve, her cock reaching full erectness from the remembered pleasures of her last attempt with the machine.  Her nipples become erect, her skin blushes, and she looks up, waiting for her pleasure to begin.\r\r");
      }
      if(temp >= 1 && temp < 2)
      {
         _root.AddText("She places the device over her fully-engorged erection and slides it down slowly, teasing herself.  A small gasp escapes her mouth from the pleasure of the cock-sleeve\'s texture.  She eagerly awaits the activation.\r\r");
      }
      if(temp >= 2 && temp < 3)
      {
         _root.AddText("She happily attempts to slip her dick back into the machine\'s opening, her large cockhead making things difficult.  Her large engorged cock begins drizzling precum as her efforts to squeeze it inside intensify.  With a final satisfied sluuurrrp it squeezes inside, lubricated by her own pre.\r\r");
         _root.SlaveSpeak("Please " + _root.Master + ", I\'m ready!",true);
         _root.AddText("\r\r");
      }
      if(temp >= 3)
      {
         _root.AddText("She shreds her clothes, anxious to get them off for another session with the machine.  Her cock surges to its full massive length in seconds, engorged and dripping with precum.  The cock-milker\'s velvet sleeve soaks up her pre easily as you rub against her dick, helping her squeeze her massive girth inside.  She orgasms, spraying the first of many loads into the artificial pussy.\r\r");
      }
      _root.AddText("You activate the cock-milker, setting off a chorus of moans from your slave as the cock-sleeve mercilessly pleasures her.  It ripples and sucks her dick, teasing ribbons of precum, vibrating out moans of pleasure.  She plays with her nipples and pussy, spreading waves of pleasure throughout her quivering body.  You decide to speed things up and lick her ear, ");
      if(temp < 3)
      {
         _root.AddText("triggering the first of many cum-draining orgasms from #slave.  She holds her hips forwards, almost begging the machine for more.  ");
      }
      else
      {
         _root.AddText("and she shudders as her cock flexes, straining the sleeve.  A torrent of cum erupts from her as she orgasms, her hips spasming back and forth as her fluids dribble out, the milker unable to keep up with her flow.  ");
         _root.AddText("#slave\'s orgasm is long and intense, but eventually subsides.\r\r");
      }
      if(temp < 3 && !_root.AssistantData.CheckBitFlag2(55) && int(Math.random() * 5) == 0)
      {
         _root.AddText("\r\r#assistant moves in to lick #slave\'s pussy while the cock-milker whirrs.  Her cock stays erect, <b>swelling</b> after her orgasm and leaking precum.  She rolls her eyes back, lost in the pleasure of cock as it is milked for more and more orgasms, each more messy and productive then the one before.  The reservoir slowly fills with more and more of her cum, the cock-milker leaking from her high fluid output.  ");
         _root.ChangeClitCockSize(1.2);
         _root.AssistantData.SetBitFlag2(55);
         _root.Points(0,0.5,0,3,0,1,0,0,0,0,0,4,3,0,5,0,1,5,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         _root.MinLibido = _root.MinLibido + 3;
         _root.DoEvent(9999);
         return true;
      }
      if(_root.VarLibidoRounded > 70 && _root.SMLust > 60 && temp >= 3)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.AddText("#slave looks up at you, her cock still very erect inside the sleeve, and asks if you would like to try some?");
         _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,5,1,0,0);
         _root.MinLibido = _root.MinLibido + 3;
         _root.DoEvent(9999);
         return true;
      }
      if(temp < 3 && _root.VarLibidoRounded > 65)
      {
         _root.AddText("\r\r#slave\'s rock-hard cock remains firm as her load is drained away.  She reaches down to three-finger her pussy, her libido driving her to penetrate herself in hopes of another orgasm.  She forcibly rapes her own pussy, anything to aid the velvet sleeve around her cock in bringing her to orgasm.  #slave\'s cum erupts into the milker, her mouth hanging open and drooling from the pleasure.");
         if(_root.VarLibidoRounded > 90)
         {
            _root.AddText("  Impressively, she is still erect and masturbating, her eyes glassy and fogged with lust.  She continues to shudder with small orgasms for some time, each one spurting small jets of cum that are quickly collected.");
            _root.Points(0,0,0,-0.5,0,0.5,0,0,0,0,0,0,1,0,-5,0,0,2,0,0);
            _root.MinLibido = _root.MinLibido + 2;
         }
         _root.Points(0,1,0,-1,0,1,0,0,0,0,0,-1,2,0.2,-15,0,4,3,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         _root.MinLibido = _root.MinLibido + 2.5;
         _root.DoEvent(9999);
         return true;
      }
      if(temp < 3)
      {
         _root.AddText("\r\r#slave sighs and removes the device with a loud SLUUURP, and her still engorged member flops against her thigh, still dribbling cum.  She informs you that she\'s only taking a small breather, and her cock will be back where it belongs shortly, she says with a wink.");
         _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,-1,1,0.2,-5,0,3,0.5,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         if(_root.MinLibido < 50)
         {
            _root.MinLibido = _root.MinLibido + 1;
         }
      }
      else if(temp >= 3 && temp < 3.5)
      {
         _root.AddText("#slave grasps hold of the milker and forcefully tugs at it, gasping as each inch of her cock is pulled from the agonizingly tight channel.  It finally pulls free with a pop, splattering cum over her already soaked midsection.  Her softening member slaps against her thigh, nearly to her knee, and still leaking cum.");
         _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,4,1,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         if(_root.MinLibido < 85)
         {
            _root.MinLibido = _root.MinLibido + 2;
         }
      }
      else if(temp >= 3.5)
      {
         _root.AddText("#slave pants and moans like an animal, her huge softening prick still large enough to fill the machine\'s cum-slick sleeve to capacity.  She slowly tugs at it, slick cock squirming out an inch at a time.  By the time she works it off her head, she is panting and nearly totally engorged again.  ");
         _root.Points(0,1,0,-0.5,0,1,0,0,0,0,0,-1,2,0.2,-8,0,5,1,0,0);
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.MinLibido = _root.MinLibido + 4;
      }
      _root.DoEvent(9999);
      return true;
   }
   if(_root.IsDickgirl() && _root.AssistantData.CheckBitFlag2(13) && _root.AssistantData.CheckBitFlag2(12))
   {
      temp = _root.ClitCockSize * 2;
      if(_root.LevelSex4 == 0)
      {
         if(_root.Slutiness <= 4 && _root.MilkInfluence < 1 && _root.Lactation < 5 && temp <= 2)
         {
            _root.AddText("#slave is reluctant to try the devices.  You insist that being milked is good for her, and a desirable skill for her to learn.  #slave reluctantly places the breast cups over her nipples.  You notice her blushing as you place the cock-milker over her quickly hardening penis.");
         }
         if(_root.Slutiness > 4 && temp <= 2)
         {
            _root.AddText("#slave is a little unsure of herself, but eagerly bares her nipples and cock to you.  She smiles lewdly as she pushers her cock into the milker and secures the milk cups to her breasts.");
            if(_root.MilkInfluence > 0 || _root.Lactation >= 30)
            {
               _root.AddText("  Milk begins dribbling from her nipples before you can activate the machine.");
            }
         }
         if((_root.MilkInfluence > 0 || _root.Lactation >= 30) && _root.Slutiness <= 4 && temp <= 2)
         {
            _root.AddText("#slave is hesitant, but a blank expression crosses her face.  She slips into the milking equipment with a practiced air, her breasts already lactating.");
         }
         if(temp > 2)
         {
            _root.AddText("#slave steps up confidently, her uncovered breasts jiggling seductively.  The suction cups fit perfectly over her erect nipples, but her large cock barely squeezes into the tube.  By the time she is fully inserted, #slave is rigid with lust.");
         }
      }
      else if(_root.Slutiness < 2 && temp < 1.5)
      {
         _root.AddText("#slave allows you to help her into the machines, her dick slipping easily into the milker sleeve as you attach her nipple cups.");
      }
      else if(_root.Slutiness < 2 || _root.Lactation < 30 || _root.Slutiness >= 2 && temp < 1.5)
      {
         _root.AddText("#slave is immediately hard and ready to go at the sight of the equipment.  A tiny drop of milk falls into the milk-cups as you get her hooked in.");
      }
      else if(_root.Lactation >= 30 && temp < 2.4)
      {
         _root.AddText("You attach the milking machine to her breasts, noting how much fuller they are now than when training started.  You smile as milk begins to trickle from her, and stoop down to help her squeeze a large erection into the cock-milker.");
      }
      else if(_root.Lactation >= 30 && temp < 3)
      {
         _root.AddText("#slave sashays into the milking room, liquid already dribbling from her nipples.  She helps you strap her in to the equipment, moaning in passion as you work her \'equipment\' into the machine.  A small spurt of jizz sprays into the tube as you seat the cocksleeve firmly at her base.");
      }
      else if(_root.Lactation >= 30)
      {
         _root.AddText("#slave squeezes her tits into the milk-cups, moaning as her milk lets down, even with the machine off.  Her huge cock is difficult to squeeze into the milking gear, but she cums a few times as you struggle with it, the extra lubrication allowing it to slide inside.");
      }
      _root.AddText("  ");
      _root.HideImages();
      if(_root.LevelSex4 <= 1)
      {
         _root.AddText("#slave reacts the sensations of the twin machines, orgasming several times, but it\'s obvious she isn\'t enjoying it very much.");
      }
      if(_root.LevelSex4 == 2)
      {
         _root.AddText("#slave moans out loud in surprise as the machines switch on.  She cums quickly, the stimulation overpowering any self-control as she is brought to more orgasms, each more powerful and draining than the last.");
      }
      if(_root.LevelSex4 == 3)
      {
         _root.AddText("The machines whir and \'slush\' softly as you activate them, squeezing and stroking your slave\'s erogenous zones.  #slave\'s legs give out as her orgasms begin washing over her.  She lays back onto a few cushions as she begins trembling and orgasming over and over.");
      }
      if(_root.LevelSex4 == 4)
      {
         _root.AddText("#slave moans in pleasure, the cock-milker rippling around her dick, suctioning away her precum.  Her nipples are stiff little nubs, dripping a steady stream of milk as the orgasms begin.  She cums too many times to count, each time accompanied by a surge of milk and cum.");
      }
      if(_root.LevelSex4 == 5 && _root.LevelUp)
      {
         _root.AddText("#slave\'s pussy drips as her cock and nipples leak into their receptacles.  With a cry of pleasure, she cums as the machines are switched on.  Her hands drop to her wet sex, fingerfucking herself hard, her cock spraying orgasm after orgasm, nipples pouring out milk, pushing herself to inhuman levels of pleasure.");
      }
      else if(_root.LevelSex4 == 5)
      {
         _root.AddText("#slave lays back, already playing with her pussy, precum filling the cocksleeve, as she awaits the mechanized pleasure.  You activate the switch and watch with some concern as she appears to orgasm nearly continuously for the duration of the milking.");
      }
      if(_root.LevelSex4 < 3)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 4) + 8);
         _root.Points(0,0.5,0,-0.5,0,0.5,0,0,0,0,0,-1,1,0.2,-7,0,3,0.7,0,0);
         if(_root.MinLibido < 50)
         {
            _root.MinLibido = _root.MinLibido + 1;
         }
      }
      if(_root.LevelSex4 <= 4)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.Points(0,1,0,-0.6,0,1,0,0,0,0,0,-1,2,0.4,-8,0,4,1,0.1,0);
         if(_root.MinLibido < 85)
         {
            _root.MinLibido = _root.MinLibido + 2;
         }
      }
      if(_root.LevelSex4 == 5)
      {
         _root.ShowMovie(EventMilk,1,1,int(Math.random() * 3) + 12);
         _root.Points(0,1,0,-0.8,0,1,0,0,0,0,0,-1.5,4,0.5,-8,0,5,2,0.2,0);
         _root.MinLibido = _root.MinLibido + 4;
      }
      _root.AddText("\r\r");
      if(_root.TentaclePregnancy < 1 && _root.MilkInfluence < 1 && _root.Lactation < 30)
      {
         if(!_root.AssistantData.CheckBitFlag2(55) && int(Math.random() * 5) == 0)
         {
            _root.AddText("#assistant bends over to lick #slave\'s pussy while the milker and cock-milker whirr and suck, and her hands brush #slave\'s cock.  #slave <b>begins to spontaneously lactate</b>!  Her nipples inexplicably grow larger and more sensitive, and her pussy appears wetter.  Her cock inflates to massive proportions, completely filling the cocksleeve.  You suspect #assistant has worked some magic upon her unconsciously.\r\r");
            _root.ChangeBustSize(1.2);
            _root.ChangeClitCockSize(1.2);
            if(_root.Lactation < 30)
            {
               _root.Lactation = 30;
            }
            _root.AssistantData.SetBitFlag2(55);
         }
         else
         {
            _root.AddText("#slave\'s nipples are sore from the machine\'s efforts, but have not produced any milk yet.");
            _root.DoEvent(9999);
            return true;
         }
      }
      if(_root.MilkInfluence > 0 && _root.MilkInfluence < 20)
      {
         _root.MilkInfluence = _root.MilkInfluence + 1;
      }
      _root.Lactation = _root.Lactation + 2;
      if(!_root.AssistantData.CheckBitFlag2(55) && int(Math.random() * 5) == 0)
      {
         _root.AddText("#assistant bends over to lick #slave\'s pussy while the milker and cock-milker whirr and suck, and her hands brush #slave\'s cock.  #slave\'s nipples inexplicably grow larger and more sensitive, and her pussy appears wetter.  Her cock inflates to massive proportions, completely filling the cocksleeve.  You suspect #assistant has worked some magic upon her unconsciously.\r\r");
         _root.ChangeBustSize(1.2);
         _root.ChangeClitCockSize(1.2);
         if(_root.Lactation < 30)
         {
            _root.Lactation = 30;
         }
         _root.AssistantData.SetBitFlag2(55);
      }
      showncockflavor = false;
      if(_root.LevelSex4 == 5)
      {
         _root.AddText("#slave\'s nipples are cherry-red, erect, and still dribbling more milk.");
      }
      if(_root.LevelSex4 == 4 && temp >= 2.4 && temp < 3)
      {
         _root.AddText("She looks tired but happy as you separate her from the devices.  #slave\'s cock and breasts are both stiff, a little swollen, and leaking fluids.");
         showncockflavor = true;
      }
      else if(_root.LevelSex4 == 4)
      {
         _root.AddText("She looks tired but happy as you separate her from the devices.  #slave\'s breasts are stiff, a little swollen, and leaking fluids.");
      }
      if(_root.LevelSex4 == 3 && temp >= 1.5 && temp < 3)
      {
         _root.AddText("#slave\'s nipples and cock are both a little red and puffy.");
         showncockflavor = true;
      }
      else if(_root.LevelSex4 == 3)
      {
         _root.AddText("#slave\'s nipples are a little red and puffy.");
      }
      if(_root.LevelSex4 == 2)
      {
         _root.AddText("#slave seems tired and sore, but eager to be milked again.");
      }
      if(_root.LevelSex4 <= 1)
      {
         _root.AddText("#slave is sore but happy.");
      }
      if(!showncockflavor)
      {
         if(temp >= 3)
         {
            _root.AddText("  Her cock is massively swollen as she frees it from the machine, huge, the head nearly purple and drizzling cum.");
         }
         if(temp >= 2.4 && temp < 3)
         {
            _root.AddText("  #slave\'s cock is stiff, a little swollen, and leaking fluids.");
         }
         if(temp >= 1.5 && temp < 2.4)
         {
            _root.AddText("  #slave\'s cock is a little red and puffy.");
         }
      }
   }
   _root.DoEvent(9999);
   return true;
}
function ShowSexActBlowjob()
{
   if(!_root.CheckBitFlag2(0))
   {
      if(Lesbian)
      {
         _root.ShowMovie(BlowjobClip,1,1,_root.slrandom(2) + 8);
      }
      else
      {
         _root.ShowMovie(BlowjobClip,1,1,int(Math.random() * 4) + 1);
      }
      return undefined;
   }
   _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.5);
   if(Lesbian)
   {
      _root.ShowMovie(BlowjobClip,1,1,_root.slrandom(2) + 8);
   }
   if(_root.Gender == 1 || _root.Gender == 3)
   {
      _root.AppendActText = false;
      if(_root.CustomFlag1 < 6)
      {
         _root.ShowMovie(BlowjobClip,1,1,int(Math.random() * 4) + 1);
         _root.AddText("#slave savors your load with a far away look.  She swallows every drop.  ");
      }
      else if(_root.CustomFlag1 < 15 && _root.CustomFlag1 > 5.9)
      {
         _root.ShowMovie(BlowjobClip,1,1,5);
         _root.AddText("#slave struggles to swallow all your cum.  She nearly gags, but afterward wastes no time in scooping it into her mouth.  ");
         _root.CustomFlag3 = _root.CustomFlag3 + 0.1;
      }
      else if(_root.CustomFlag1 > 14.9 && _root.CustomFlag1 < 24)
      {
         _root.ShowMovie(BlowjobClip,1,1,7);
         _root.AddText("#slave tries to swallow the huge bursts of cum erupting from your cock, but fails. Your dick overfills her mouth with cum and pops out to shoot thick ropes over her face.  She gathers the excess into a measuring cup out of curiousity.  ");
         _root.AddText("It looked like your leftover cum filled about " + int(10 * (_root.CustomFlag1 / 3 - 3 + Math.random() * _root.SMLust / 13)) / 10 + " cubic centimeters. ");
         _root.CustomFlag3 = _root.CustomFlag3 + 0.1;
      }
      else if(_root.CustomFlag1 > 23.9)
      {
         _root.Backgrounds.ShowBedRoom();
         _root.ShowMovie(BlowjobClip,1,1,8);
         _root.AddText("#slave has trouble getting your massive cock-head into her mouth.  After working open her jaw and lubing up with your precum she manages to get the first six inches of your impressive length in.  Noisy slurps escape her mouth as she works your hard-on and fights to keep up with the cum already dribbling from your tip.  Delicate fingers begin jerking your slimy shaft, faster and faster.  You can\'t hold back any longer and explode cum down ");
         _root.AddText("#slave\'s throat.  Your hips twitch and each pulse of cum seems more copious than the last.  It sprays out around your shaft onto her face, into her hair, and dribbling all over her...until finally the cum slows to a trickle.  #slave lets your dick flop free with an audible \'pop\'.  ");
         _root.CustomFlag3 = _root.CustomFlag3 + 0.2;
      }
      if(_root.CustomFlag3 < 6)
      {
         if(!_root.CheckBitFlag2(29) && _root.VarSpecialRounded > 4 && int(Math.random() * 3) < 1)
         {
            _root.AddText("#slave licks you clean with her tongue.  The feeling seems to bring you back to full hardness.\r\r");
            _root.SlaveSpeak("Sorry.",true);
            _root.CustomFlag1 = _root.CustomFlag1 + 0.3;
            _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-5);
            _root.SMPoints(0,0,0,0,0,7,0,0);
         }
         else
         {
            _root.AddText("She wonders why she would do such a thing. Cum has never appealed to her in the past. ");
         }
      }
      else if(_root.CustomFlag3 < 13 && _root.CustomFlag3 > 5.9)
      {
         if(_root.VarSpecialRounded > 7 && int(Math.random() * 4) < 1)
         {
            _root.AddText("#slave reaches out to touch your balls with an uncertain look on her face. As she makes contact you feel a tiny shock.  #slave giggles and blushes.\r\r");
            _root.SlaveSpeak("Sorry.",true);
            _root.CustomFlag1 = _root.CustomFlag1 + 0.5;
            _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-8);
            _root.SMPoints(0,0,0,0,0,10,0,0);
         }
         else
         {
            _root.AddText("\r\r");
            _root.SlaveSpeak("Your cum tastes good " + _root.SlaveMakerName + ", I\'ll swallow for you any time!",true);
         }
      }
      else if(_root.CustomFlag3 < 20 && _root.CustomFlag3 > 12.9)
      {
         if(_root.VarSpecialRounded > 8 && int(Math.random() * 5) < 1)
         {
            _root.AddText("#slave fondles your balls, making them feel heavy and full.\r\r");
            _root.SlaveSpeak("Please cum for me again.",true);
            _root.CustomFlag1 = _root.CustomFlag1 + 0.6;
            _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-9);
            _root.SMPoints(0,0,0,0,0,15,0,0);
         }
         else
         {
            _root.AddText("\r\r");
            _root.SlaveSpeak("I\'ll help you cum as much as you want, so long as you let me drink it.",true);
         }
      }
      else if(_root.CustomFlag3 >= 20)
      {
         if(_root.VarSpecialRounded > 9 && int(Math.random() * 5) < 1)
         {
            _root.AddText("\r\r");
            _root.SlaveSpeak("Mmmmm...You\'ll cum again for me, won\'t you?",true);
            _root.AddText("\r\rShe wraps her lips around the head of your softening dick and hums. You gasp as her lips seem to electrically charge your manhood.  The tingling travels down towards your balls, leaving your shaft swollen and hard. You can feel your testes pulse and quiver with newfound life.  #slave pulls back, leaving your dick a horny mess.  ");
            _root.CustomFlag1 = _root.CustomFlag1 + 0.75;
            _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-10);
            _root.SMPoints(0,0,0,0,0,_root.CustomFlag - 4,0,0);
         }
         else
         {
            _root.AddText("\r\r");
            _root.SlaveSpeak("More!  Cum is sooo...addictive.",true);
         }
      }
      if(_root.CheckBitFlag2(0))
      {
         _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.5);
      }
   }
}
function ShowSexActBondage()
{
   if(_root.IsDickgirl())
   {
      _root.ShowMovie(BondageClip,1,1,int(Math.random() * 2) + 4);
   }
   else
   {
      _root.ShowMovie(BondageClip,1,1,int(Math.random() * 3) + 1);
   }
}
function ShowSexActCumBath()
{
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2);
   }
   _root.ShowMovie(GangBangClip,1,1,int(Math.random() * 3) + 5);
   return true;
}
function ShowSexActDildo()
{
   _root.HideBackgrounds();
   if(_root.IsDickgirl())
   {
      if(_root.CheckBitFlag2(8))
      {
         _root.AppendActText = false;
         if(_root.CustomFlag < 6)
         {
            _root.AddText("#slave is intimidated by the vibrator\'s massive size.  She hefts it, admiring the size and textured nubs for a moment, then places it longways against her opening.\r\rShe smiles nervously at " + _root.SupervisorName + ", rubbing its length against her, enjoying the vibration and stimulation.");
         }
         if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
         {
            _root.AddText("#slave works the massive vibrator in with difficulty, gasping as each textured nodule wiggles its way inside her lips.  She squirms and writhes as the vibe suddenly activates, her tightly stretched cunny juicing around the toy with the heat of her arousal.  #slave closes her eyes tightly and begins fucking herself with the thick vibe, slowly building in speed as her libido rises.  She fucks her pussy hard with the toy, squealing as she trembles with a tremendous orgasm.");
         }
         if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
         {
            _root.AddText("#slave happily begins to fuck her sodden cunt with the bulbous toy, rapidly slickening it with her copious love-juices.  The vibrator almost immediately leaps to life, wiggling and jumping in her snatch, the textured nodules tickling her clit and lips with delicious pleasure.  #slave smiles at " + _root.SupervisorName + " as she orgasms, cum and milk collecting in small puddles around her, her muscles spasming in pleasure.");
         }
         if(_root.CustomFlag >= 20)
         {
            _root.AddText("#slave stuffs the massive vibe into her juicy cunt, setting off the vibrator immediately.  It wiggles and squirms with barely controlled energy as she manhandles the wily device, plunging it deeply into herself with both hands.  Milk dribbles and leaks from her massive tits, spraying out in time with each of her many orgasms.  She quivers bonelessly, the vibrator slipping from her abused cunt, worn out from a multitude of orgasms.");
         }
         _root.Points(0,0.25,0,0,0,0.1,0,0,0,0,0,0.2,0.1,0,0.5,0,0,0.3,0,1);
         if(_root.CheckBitFlag2(9))
         {
            if(_root.ServantGender > 3)
            {
               _root.AddText("\r\r#assistant spend the whole session with #assistanthisher lips wrapped around #slave\'s cock, urging her to orgasm, slurping down all the pre and cum #assistantheshe can get.");
            }
            else
            {
               _root.AddText("\r\r#assistant spends the whole session with #assistanthisher lips wrapped around #slave\'s cock, urging her to orgasm, slurping down all the pre and cum #assistantheshe can get.");
            }
         }
      }
      _root.ShowMovie(DildoClip,1,1,5);
   }
   else
   {
      if(_root.CheckBitFlag2(8))
      {
         _root.AppendActText = false;
         if(_root.CustomFlag < 6)
         {
            _root.AddText("#slave is intimidated by the vibrator\'s massive size.  She hefts it, admiring the size and textured nubs for a moment, then places it longways against her opening.\r\rShe smiles nervously at " + _root.SupervisorName + ", rubbing its length against her, enjoying the vibration and stimulation.");
         }
         if(_root.CustomFlag >= 6 && _root.CustomFlag < 13)
         {
            _root.AddText("#slave works the massive vibrator in with difficulty, gasping as each textured nodule wiggles its way inside her lips.  She squirms and writhes as the vibe suddenly activates, her tightly stretched cunny juicing around the toy with the heat of her arousal.  #slave closes her eyes tightly and begins fucking herself with the thick vibe, slowly building in speed as her libido rises.  She fucks her pussy hard with the toy, squealing as she trembles with a tremendous orgasm.");
         }
         if(_root.CustomFlag >= 13 && _root.CustomFlag < 20)
         {
            _root.AddText("#slave happily begins to fuck her sodden cunt with the bulbous toy, rapidly slickening it with her copious love-juices.  The vibrator almost immediately leaps to life, wiggling and jumping in her snatch, the textured nodules tickling her clit and lips with delicious pleasure.  #slave smiles at " + _root.SupervisorName + " as she orgasms, cum and milk collecting in small puddles around her, her muscles spasming in pleasure.");
         }
         if(_root.CustomFlag >= 20)
         {
            _root.AddText("#slave stuffs the massive vibe into her juicy cunt, setting off the vibrator immediately.  It wiggles and squirms with barely controlled energy as she manhandles the wily device, plunging it deeply into herself with both hands.  Milk dribbles and leaks from her massive tits, spraying out in time with each of her many orgasms.  She quivers bonelessly, the vibrator slipping from her abused cunt, worn out from a multitude of orgasms.");
         }
         _root.Points(0,0.25,0,0,0,0.1,0,0,0,0,0,0.2,0.1,0,0.5,0,0,0.3,0,1);
      }
      _root.ShowMovie(DildoClip,1,1,int(Math.random() * 2) + 2);
   }
}
function ShowSexActFuck()
{
   if(!_root.CheckBitFlag2(0))
   {
      if(_root.DefaultLesbian())
      {
         return undefined;
      }
      if(_root.IsDickgirl())
      {
         _root.ShowMovie(FuckClip,1,1,int(Math.random() * 2) + 6);
      }
      else
      {
         _root.ShowMovie(FuckClip,1,1,int(Math.random() * 5) + 1);
      }
      return undefined;
   }
   _root.DoXMLAct("SexFuck");
}
function ShowSexActGangBang()
{
   _root.DoXMLAct("SexGangBang");
}
function ShowSexActGroup()
{
   _root.DoXMLAct("SexGroup");
}
function ShowSexActKiss()
{
   if((_root.SexAction == 23.1 || _root.SexAction == 23) && _root.Gender == 1 || _root.SexAction == 23.2 && _root.Gender == 2)
   {
      _root.ShowMovie(KissClip,1,1,1);
   }
   else
   {
      _root.ShowMovie(KissClip,1,1,2);
   }
   return true;
}
function ShowSexActLendHer()
{
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3);
   }
   _root.ShowMovie(LendClip,1,1,1);
   return "";
}
function ShowSexActLesbian()
{
   _root.DoXMLAct("SexLesbian");
}
function ShowSexActLick()
{
   _root.DoXMLAct("SexLick");
}
function ShowSexActMaster()
{
   _root.DoXMLAct("SexMaster");
}
function ShowSexActMasturbate()
{
   _root.DoXMLAct("SexMasturbate");
   return true;
}
function ShowActPlug()
{
   _root.DoXMLAct("SexPlug");
}
function ShowSexActPonygirl()
{
   _root.ShowOverlay(15858395);
   _root.ShowMovie(PonygirlClip,1,1,1);
}
function ShowSexActSpank(whip)
{
   _root.DoXMLAct("SexSpank");
}
function ShowSexActThreesome()
{
   _root.DoXMLAct("SexThreesome");
}
function ShowSexActTitFuck()
{
   _root.DoXMLAct("SexTitFuck");
}
function ShowSexActTouch()
{
   _root.DoXMLAct("SexTouch");
}
function ShowTentacleSex(place)
{
   if(_root.DoDickgirlChange(30))
   {
      return false;
   }
   _root.UseGeneric = false;
   if(place == 1)
   {
      temp = int(Math.random() * 5) + 1;
   }
   else if(place == 4)
   {
      temp = int(Math.random() * 2) + 6;
   }
   else if(place == 6)
   {
      temp = int(Math.random() * 2) + 8;
   }
   else if(place == 8)
   {
      temp = 10;
   }
   if(_root.CheckBitFlag2(0))
   {
      _root.Points(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4);
   }
   _root.ShowMovie(ClipTentacle,1,1,temp);
   return false;
}
function ShowEndingCatgirl()
{
   _root.Backgrounds.ShowBedRoom();
   _root.ShowMovie(EndingCatgirl,1,1);
   return true;
}
function ShowEndingCourtesan()
{
   _root.Backgrounds.ShowBeach();
   _root.ShowMovie(EndingCourtesan,1,1,1);
}
function ShowEndingCowgirl()
{
   ShowMilking();
}
function ShowEndingBoughtBack()
{
   _root.ShowMovie(EndingBoughtBack,1,1,1);
}
function ShowEndingDickgirl()
{
   _root.ShowMovie(EndingDickgirl,1,1,1);
}
function ShowEndingDrugAddict()
{
   _root.Backgrounds.ShowBedRoom();
   _root.ShowMovie(EndingDrugAddict,1,1,1);
}
function ShowEndingLesbianSlave()
{
   _root.ShowMovie(EndingLesbianSlave,1,1,1);
}
function ShowEndingMaid()
{
   _root.Backgrounds.ShowBar();
   _root.ShowMovie(EndingMaid,1,1,1);
}
function ShowEndingMarriage()
{
   _root.ShowOverlay(16380146);
   _root.ShowMovie(EndingMarriage,1,1,1);
}
function ShowEndingNormal()
{
   _root.Backgrounds.ShowBedRoom();
   _root.ShowMovie(EndingNormal,1,1,1);
}
function ShowEndingNormalMinus()
{
   _root.Backgrounds.ShowBedRoom();
   _root.ShowMovie(EndingNormalMinus,1,1,1);
}
function ShowEndingNormalPlus()
{
   _root.Backgrounds.ShowBedRoom();
   _root.ShowMovie(EndingNormalPlus,1,1,1);
}
function ShowEndingProstitute()
{
   _root.ShowOverlay(0);
   _root.ShowMovie(EndingProstitute,1,1,1);
}
function ShowEndingRebel()
{
   _root.ShowMovie(EndingRebel,1,1,1);
}
function ShowEndingRich()
{
   _root.ShowMovie(EndingRich,1,1,1);
}
function ShowEndingSexAddict()
{
   _root.Backgrounds.ShowSchool();
   _root.ShowMovie(EndingSexAddict,1,1,1);
}
function ShowEndingSexManiac()
{
   _root.Backgrounds.ShowSchool();
   _root.ShowMovie(EndingSexManiac,1,1,1);
}
function ShowEndingSM()
{
   _root.ShowOverlay(3547467);
   _root.ShowMovie(EndingSM,1,1,1);
}
function ShowEndingTentacleSlave()
{
   ShowTentacleSex();
}
function ShowTentaclePregnancyReveal()
{
   var _loc2_ = _root.GetNode(_root.evtNode,"TentacleBirth");
   var _loc3_ = undefined;
   if(_loc2_ != null)
   {
      _loc3_ = _root.PickXMLEventByNode(_loc2_);
      if(_loc3_ != "")
      {
         _root.SetText("");
         _root.XMLEventByNode(_loc2_,_root.sett,_loc3_);
         return true;
      }
   }
   _root.ShowMovie(EventTentaclePregnancy,1,1,1);
   return true;
}
function EndingStart(total)
{
   if(_root.NumFin == 20 || _root.NumFin == 25)
   {
      return false;
   }
   return false;
}
function EndingFinish(total)
{
   return false;
}
function NumCustomEndings()
{
   return 2;
}
function EndingStartAsAssistant(total)
{
   if(_root.NumFin == 20 || _root.NumFin == 25)
   {
      return false;
   }
   if(_root.LevelSex4 == 5 && _root.Lactation >= 50 && _root.MinLibido >= 50)
   {
      _root.HideImages();
      _root.HideBackgrounds();
      _root.HideEndings();
      _root.HideSlaveActions();
      if(_root.IsDickgirl())
      {
         _root.SetEnding(71,"Dickgirl Milk Slut");
      }
      else
      {
         _root.SetEnding(71,"Milk Slut");
      }
      if(!_root.SlaveGirl.ShowEndingCowgirl())
      {
         if(_root.IsDickgirl())
         {
            _root.AutoLoadImageAndShowMovie("Images/Slaves/Aeris/Milk Slut 2.jpg",1,1,0);
         }
         else
         {
            _root.AutoLoadImageAndShowMovie("Images/Slaves/Aeris/Milk Slut 1.jpg",1,1,0);
         }
      }
   }
   return false;
}
function EndingFinishAsAssistant(total)
{
   if(_root.NumFin == 71)
   {
      _root.SetText("You come to visit " + _root.SlaveName + "\'s owner and when you enter through the door you find her with a glassy, half-smiling expression, strapped into ");
      if(_root.IsDickgirl())
      {
         _root.AddText("tit and cock-milking equipment.\r\r");
      }
      else
      {
         _root.AddText("tit-milking equipment.\r\r");
      }
      _root.PersonSpeak("Owner","Hello, " + _root.SlaveMakerName + ". Why, you\'ve provided a fantastic little milk slut of a slave.  She simply can\'t get enough of it, and begs me to milk her for several hours each day.  Not all at once, of course.",true);
      _root.AddText("\rAn assistant comes in to unhook " + _root.SlaveName + " and clean her up.  After she dresses herself, she grins and welcomes you with a hug.\r\r");
      _root.SlaveSpeakStart("Oh, I love my body!  You\'ve done so much for me, " + _root.SlaveMakerName + ".  I just adore the way my breasts never stop leaking milk",true);
      if(_root.IsDickgirl())
      {
         _root.AddText(" and my cock is always ready to go");
      }
      _root.SlaveSpeakEnd(".");
      _root.AddText("\rIndeed, " + _root.SlaveName + "\'s ");
      if(_root.vitalsBust >= 150)
      {
         _root.AddText("humongous watermelons ");
      }
      else if(_root.vitalsBust >= 120)
      {
         _root.AddText("eye-popping canteloupes ");
      }
      else if(_root.vitalsBust >= 100)
      {
         _root.AddText("big jugs ");
      }
      else
      {
         _root.AddText("tits ");
      }
      _root.AddText("are leaking heavily, even through her blouse, and rivulets of milk are running down her chest.");
      if(_root.IsDickgirl())
      {
         _root.AddText("  Her cock is ");
         if(_root.ClitCockSize >= 1.2)
         {
            _root.AddText("massively ");
         }
         _root.AddText("engorged and throbbing, heaving up and down with every step she takes and splattering ");
         if(_root.ClitCockSize >= 1.35)
         {
            _root.AddText("big puddles ");
         }
         else
         {
            _root.AddText("dribbles ");
         }
         _root.AddText("of thick cum on the floor as she walks.");
      }
      _root.AddText("\r\r");
      _root.PersonSpeak("Owner","Please, come visit us any time.",true);
      _root.NumFin = 1000;
      return true;
   }
   return false;
}
function NumCustomEndingsAsAssistant()
{
   if(_root.SlaveGender != 1 && _root.SlaveGender != 4 && (_root.AssistantData.CheckBitFlag2(12) || _root.AssistantData.CheckBitFlag2(13)))
   {
      return 1;
   }
   return 0;
}
function ShowEndingsAsAssistant(ending)
{
   if(_root.SlaveGender != 1 && _root.SlaveGender != 4 && (_root.AssistantData.CheckBitFlag2(12) || _root.AssistantData.CheckBitFlag2(13)))
   {
      _root.AddText("To get the ending \'Milk Slut\', train " + SlaveName + " and use Aeris\' milking equipment on her repeatedly, making her lactate.");
   }
}
function HideImages()
{
   ClipNobleLove._visible = false;
   ClipContestsBeauty._visible = false;
   ClipContestsCourt._visible = false;
   ClipContestsXXX._visible = false;
   ClipContestsHousework._visible = false;
   ClipSlaveRetrieved._visible = false;
   EventMilk._visible = false;
   EventMorningMouthfull._visible = false;
   RefusedAction._visible = false;
   Introduction._visible = false;
   ClipRaped._visible = false;
   ClipDating._visible = false;
   ClipLoveAccepted._visible = false;
   ClipLoveRefused._visible = false;
   ClipLoveConfession._visible = false;
   ClipPropositionAccepted._visible = false;
   ClipPropositionRefused._visible = false;
   ClipTired._visible = false;
   EventTentaclePregnancy._visible = false;
   EndingDickgirl._visible = false;
   EndingLesbianSlave._visible = false;
   FaerieClip._visible = false;
   CowEventClip._visible = false;
   ItemSwimsuit._visible = false;
   DemonQueenLust._visible = false;
}
function HideSlaveActions()
{
   BondageClip._visible = false;
   AnalClip._visible = false;
   FuckClip.gotoAndStop(1);
   FuckClip._visible = false;
   FuckClipb.gotoAndStop(1);
   FuckClipb._visible = false;
   TitsFuckClip.gotoAndStop(1);
   TitsFuckClip._visible = false;
   MasturbateClip._visible = false;
   DildoClip._visible = false;
   KissClip._visible = false;
   LickClip._visible = false;
   MasterClip._visible = false;
   BlowjobClip._visible = false;
   PlugClip._visible = false;
   GangBangClip._visible = false;
   LendClip._visible = false;
   NeedingClip._visible = false;
   TouchClip._visible = false;
   LesbianClip._visible = false;
   SpankClip._visible = false;
   AcolyteClip._visible = false;
   BarClip._visible = false;
   SleazyBarClip._visible = false;
   BeautyClip._visible = false;
   BrothelClip._visible = false;
   RefinementSchoolClip._visible = false;
   CookingClip._visible = false;
   DanceClip._visible = false;
   DiscussClip._visible = false;
   ExhibClip._visible = false;
   CleaningClip._visible = false;
   PromenadeClip._visible = false;
   BreakClip._visible = false;
   RestaurantClip._visible = false;
   SciencesClip._visible = false;
   TheologyClip._visible = false;
   XXXClip._visible = false;
   ClipTentacle._visible = false;
   ClipDickgirl._visible = false;
   ThreesomeClip._visible = false;
   SixtyNineClip._visible = false;
   GroupClip._visible = false;
   PonygirlClip._visible = false;
   NakedApronClip._visible = false;
   SingingClip._visible = false;
   OnsenClip._visible = false;
   ReadClip._visible = false;
}
function HideDresses()
{
   var _loc1_ = 1;
   while(_loc1_ < NakedImages.length)
   {
      var _loc2_ = NakedImages[_loc1_];
      _loc2_._visible = false;
      _loc1_ = _loc1_ + 2;
   }
   RobePlainClip._visible = false;
   Robe1Clip._visible = false;
   Robe2Clip._visible = false;
   Robe3Clip._visible = false;
   Robe4Clip._visible = false;
   Robe5Clip._visible = false;
   Robe6Clip._visible = false;
   DemonWingLeft._visible = false;
   DemonWingRight._visible = false;
   DemonHornLeft._visible = false;
   DemonHornRight._visible = false;
}
function HideEndings()
{
   EndingDrugAddict._visible = false;
   EndingNormalPlus._visible = false;
   EndingSexManiac._visible = false;
   EndingMarriage._visible = false;
   EndingNormal._visible = false;
   EndingSexAddict._visible = false;
   EndingProstitute._visible = false;
   EndingBoughtBack._visible = false;
   EndingRebel._visible = false;
   EndingRich._visible = false;
   EndingSM._visible = false;
   EndingMaid._visible = false;
   EndingNormalMinus._visible = false;
   EndingLesbianSlave._visible = false;
   EndingDickgirl._visible = false;
   EndingCourtesan._visible = false;
   EndingCatgirl._visible = false;
   TentacleQueenAerisEnd._visible = false;
}
function Initialise()
{
   if(_root.Path1 != 0)
   {
      _root.SetBitFlag2(0);
      _root.Path1 = 0;
   }
   if(_root.Path2 != 0)
   {
      _root.CustomFlag4 = _root.Path2;
      _root.Path2 = 0;
   }
   ClitCockSizeAerisStartSM = _root.ClitCockSizeSM;
   vitalsBustAerisStartSM = _root.vitalsBustSM;
   if(_root.CheckBitFlag2(0))
   {
      _root.ShowSpecialStat("Nymph Magic :");
   }
   _root.AddCustomHouse("Dark Forest",140,550,"Somewhere in this area, there is a powerful aura of fae magic that bears investigating.");
   _root.HideCustomHouse();
   _root.SlaveAttitude = 3;
   _root.OldLover = -1;
   _root.SetDressForSale(5,false);
   _root.TentacleFrequency = 5;
   _root.DickgirlFrequency = 1;
   _root.MaxTentacleHarem = 20;
   if(_root.CustomFlag4 > 0)
   {
      _root.ShowCustomSexAct(1);
   }
   if(_root.CheckBitFlag2(12) || _root.CheckBitFlag2(13))
   {
      _root.ShowCustomSexAct(2);
   }
   _root.SlaveVersion = "1.4";
   _root.SlaveCredits = "Written by fenoxo, edited by Cmacleod and MouseGURU.";
}
function StartGame()
{
   _root.MaxObedience = 85;
   if(ClitCockSizeAerisStartSM == undefined)
   {
      ClitCockSizeAerisStartSM = _root.ClitCockSize;
   }
   if(vitalsBustAerisStartSM == undefined)
   {
      vitalsBustAerisStartSM = _root.vitalsBust;
   }
}
function LoadGame(saveData)
{
   trace("loading assistant");
   if(_root.IsAssistant("Aeris"))
   {
      trace("assistant " + _root.SlaveGender + " " + _root.AssistantData.CheckBitFlag2(12) + " " + _root.AssistantData.CheckBitFlag2(13));
      if(_root.SlaveGender != 1 && _root.SlaveGender != 4 && (_root.AssistantData.CheckBitFlag2(12) || _root.AssistantData.CheckBitFlag2(13)))
      {
         trace("set act");
         _root.SetCustomSexAct(4,"Milk Her","Aeris will milk her with her special equipment");
         _root.ShowCustomSexAct(4);
      }
   }
   else
   {
      if(saveData.ClitCockSizeAerisStartSM != undefined)
      {
         ClitCockSizeAerisStartSM = saveData.ClitCockSizeAerisStartSM;
      }
      else
      {
         ClitCockSizeAerisStartSM = _root.ClitCockSizeSM;
      }
      if(saveData.vitalsBustAerisStartSM != undefined)
      {
         vitalsBustAerisStartSM = saveData.vitalsBustAerisStartSM;
      }
      else
      {
         vitalsBustAerisStartSM = _root.vitalsBustSM;
      }
   }
}
function SaveGame(saveData)
{
   saveData.ClitCockSizeAerisStartSM = ClitCockSizeAerisStartSM;
   saveData.vitalsBustAerisStartSM = vitalsBustAerisStartSM;
}
function ShowIntroPage(IntroPage)
{
   return Introduction;
}
function HideIntroPages()
{
   Introduction._visible = false;
}
var bcsize = 0;
var NakedImages = new Array();
Robe1Clip.gotoAndStop(1);
Robe2Clip.gotoAndStop(1);
Robe3Clip.gotoAndStop(1);
Robe4Clip.gotoAndStop(1);
Robe5Clip.gotoAndStop(1);
Robe6Clip.gotoAndStop(1);
Robe6Clip.Dickgirl.gotoAndStop(1);
ClipDickgirl.gotoAndStop(1);
DemonWingLeft.gotoAndStop(1);
DemonWingRight.gotoAndStop(1);
DemonHornLeft.gotoAndStop(1);
DemonHornRight.gotoAndStop(1);
BreakClip.gotoAndStop(1);
BeautyClip.gotoAndStop(1);
CookingClip.gotoAndStop(1);
DanceClip.gotoAndStop(1);
SciencesClip.gotoAndStop(1);
DiscussClip.gotoAndStop(1);
ExhibClip.gotoAndStop(1);
PromenadeClip.gotoAndStop(1);
RefinementSchoolClip.gotoAndStop(1);
BarClip.gotoAndStop(1);
TheologyClip.gotoAndStop(1);
BrothelClip.gotoAndStop(1);
SleazyBarClip.gotoAndStop(1);
RestaurantClip.gotoAndStop(1);
XXXClip.gotoAndStop(1);
SixtyNineClip.gotoAndStop(1);
AnalClip.gotoAndStop(1);
BlowjobClip.gotoAndStop(1);
BondageClip.gotoAndStop(1);
DildoClip.gotoAndStop(1);
GangBangClip.gotoAndStop(1);
GroupClip.gotoAndStop(1);
FuckClipa.gotoAndStop(1);
FuckClipb.gotoAndStop(1);
LendClip.gotoAndStop(1);
LesbianClip.gotoAndStop(1);
LickClip.gotoAndStop(1);
MasterClip.gotoAndStop(1);
MasturbateClip.gotoAndStop(1);
PlugClip.gotoAndStop(1);
NeedingClip.gotoAndStop(1);
SpankClip.gotoAndStop(1);
TitsFuckClip.gotoAndStop(1);
ThreesomeClip.gotoAndStop(1);
TouchClip.gotoAndStop(1);
ClipTentacle.gotoAndStop(1);
ClipTired.gotoAndStop(1);
ClipNobleLove.gotoAndStop(1);
EventMilk.gotoAndStop(1);
ClipContestsXXX.gotoAndStop(1);
EventTentaclePregnancy.gotoAndStop(1);
ClipRaped.gotoAndStop(1);
Robe6Clip.Dickgirl.gotoAndStop(1);
ClipContestsBeauty.gotoAndStop(1);
NakedApronClip.gotoAndStop(1);
ClipContestsCourt.gotoAndStop(1);
ClipDating.gotoAndStop(1);
KissClip.gotoAndStop(1);
FaerieClip.gotoAndStop(1);
CowEventClip.gotoAndStop(1);
EventMorningMouthfull.gotoAndStop(1);
ClipPropositionAccepted.gotoAndStop(1);
DemonQueenLust.gotoAndStop(1);
TentacleQueenAerisEnd.gotoAndStop(1);
HideDresses();
HideImages();
HideSlaveActions();
HideEndings();
stop();
