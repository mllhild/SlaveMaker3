// List of plannings
// Translation status: COMPLETE

import Scripts.Classes.*;

class PlanningList {
	private var coreGame:Object;		// core game engine
	public var slaveData:Object;		// associated slave girl details

	public var arPlanningArray:Array;
	public var PlanningTime:Number;
	public var EndPlanningTime:Number;

	private var bStarted:Boolean;
	private var bNewMorningEvening:Boolean;
	public var bDayTime:Boolean;
	
	public var bSlaveOnly:Boolean;

	// Constructor
	public function PlanningList(cg:Object, slaveonly:Boolean) { 
		coreGame = cg;
		slaveData = null;
		bSlaveOnly = slaveonly == true ? true : false;
		
		arPlanningArray = new Array();
		PlanningTime = coreGame.GameTime;
		bStarted = false;
		bNewMorningEvening = false;
		EndPlanningTime = 0;
	}

	public function Reset(sd:Object, time:Number)
	{
		if (sd != undefined) slaveData = sd;
		
		ResetImages();
		var i:Number = arPlanningArray.length;
		var pact:PlanningAction;
		while (--i >= 0) {
			pact = PlanningAction(arPlanningArray.pop());
			delete pact;
		}
		delete arPlanningArray;
		arPlanningArray = new Array();
		PlanningTime = time == undefined ? coreGame.GameTime : time;
		bStarted = false;
		bNewMorningEvening = false;
		coreGame.PlanningSelections.Actions.invalidate();
	}
	
	public function ResetImages()
	{		
		var i:Number = arPlanningArray.length;
		var mc:MovieClip;
		var pact:PlanningAction;
		while (--i >= 0) {
			pact = arPlanningArray[i];
			pact.image.removeMovieClip();
			pact.image = null;
		}
	}
	
	public function GetActionsCount() : Number
	{ 
		return arPlanningArray.length;
	}
	public function IsStarted() : Boolean
	{ 
		return bStarted;
	}
	public function StartPlanning()
	{ 
		bStarted = true;
		bDayTime = coreGame.Day;
	}
	public function EndPlanning()
	{ 
		bStarted = false;
	}
	public function NewPlanning()
	{ 
		Reset();
		bNewMorningEvening = true;
	}
	public function IsNewPlanning()
	{ 
		return bNewMorningEvening;
	}
	public function AddPlanning(slave:Number, duration:Number, image:MovieClip, sm:Number, people:Array) : Number
	{
		var an:Number = arPlanningArray.push(new PlanningAction(coreGame, slave, sm, PlanningTime, duration, image, people));
		PlanningTime += duration;
		return an - 1;
	}
	
	public function LoadActions(lsrc:Object, loading:Boolean)
	{
		if (loading == undefined) loading = true;
		if (loading) {
			Reset();
			bNewMorningEvening = lsrc.bNewMorningEvening;
		} else NewPlanning();
		var len:Number = lsrc.arPlanningArray.length;
		for (var i:Number = 0; i < len; i++) { 
			var added:Boolean = true;
			if (lsrc.arPlanningArray[i].SlaveAction != 0) {
				var act:ActInfo = slaveData.ActInfoBase.GetActAbs(int(Math.abs(lsrc.arPlanningArray[i].SlaveAction)));
				if (act.bShown && act.Available) added = AddDayNightAction(lsrc.arPlanningArray[i].SlaveAction, loading, lsrc.arPlanningArray[i].Participants);
			}
			if (lsrc.arPlanningArray[i].SlaveMakerAction != undefined && lsrc.arPlanningArray[i].SlaveMakerAction != 0 && added) {
				var act:ActInfo = slaveData.ActInfoBase.GetActAbs(int(Math.abs(lsrc.arPlanningArray[i].SlaveMakerAction)));
				if (act.bShown && act.Available) AddDayNightAction(lsrc.arPlanningArray[i].SlaveMakerAction, loading, lsrc.arPlanningArray[i].Participants, lsrc.arPlanningArray[i].SlaveAction == 0);
			}
		}
	}
	public function Save(dest:Object)
	{
		dest.arPlanningArray = new Array();
		dest.PlanningTime = PlanningTime;
		dest.bNewMorningEvening = bNewMorningEvening;
		var len:Number = arPlanningArray.length;
		for (var i:Number = 0; i < len; i++) { 
			var newpa:Object = new Object();
			var pae:PlanningAction = arPlanningArray[i];
			pae.Save(newpa);
			dest.arPlanningArray.push(newpa);
		}
	}
	
	public function LoadFrom(src:Object)
	{
		Reset();
		bNewMorningEvening = src.bNewMorningEvening;
		var len:Number = src.arPlanningArray.length;
		for (var i:Number = 0; i < len; i++) { 
			AddPlanning(src.arPlanningArray[i].SlaveAction, src.arPlanningArray[i].PlanningDuration, null, src.arPlanningArray[i].SlaveMakerAction, src.arPlanningArray[i].Participants);
		}
	}
	
	public function RedrawPlanningList(rebuild:Boolean, time:Number)
	{
		var lastentry:Number = arPlanningArray.length - 1;
		var i:Number = 0;
		
		// are the images loaded?
		if (arPlanningArray[lastentry].image == null) {
			// load the images
			while (i <= lastentry) {
				var pact:PlanningAction = arPlanningArray[i];
				if (pact.image == null) {
					pact.CreateActImage(this, pact.SlaveAction, i, arPlanningArray[i - 1].image);
					if (pact.SlaveMakerAction != undefined && pact.SlaveMakerAction != 0) pact.CreateActImage(this, pact.SlaveMakerAction, i);
				}
				i++;
			}
		}
		
		if (rebuild != true) {
			PlanningTime = time == undefined ? coreGame.GameTime : time;
			arPlanningArray[lastentry].image.SlaveAction.DeleteButton._visible = true;
			arPlanningArray[lastentry].image.SlaveMakerAction.DeleteButton._visible = (arPlanningArray[lastentry].SlaveMakerAction != undefined && arPlanningArray[lastentry].SlaveMakerAction != 0);
		}
		i = 0;
		while (i <= lastentry) {
			var pact:PlanningAction = arPlanningArray[i];
			var absact:Number = Math.abs(pact.SlaveAction);
			if (i > 0) pact.image._y = arPlanningArray[i - 1].image._y + arPlanningArray[i - 1].image._height + 3;
			else pact.image._y = 0;
			pact.image.actIndex = i;
			if (coreGame.SMData.DaysUnavailable != 0 && pact.SlaveMakerAction != 0 && pact.SlaveMakerAction != undefined) pact.SlaveMakerAction = 0;
			if (rebuild != true) {
				if (PlanningTime >= EndPlanningTime) {
					pact.SlaveMakerAction = 0;
					DeleteSlaveAction(i, true);
					lastentry = arPlanningArray.length - 1;
					continue;
				}
				pact.image.TimeLabel.text = coreGame.DecodeTime(PlanningTime);
				pact.PlanningTime = PlanningTime;
				if (absact != 0) PlanningTime += coreGame.GetActDuration(absact);
				else PlanningTime += coreGame.GetActDuration(pact.SlaveMakerAction);
				pact.image.SlaveAction.Action.htmlText = coreGame.GetActName(absact);
				if (pact.SlaveMakerAction != 0 && pact.SlaveMakerAction != undefined) pact.image.SlaveMakerAction.Action.htmlText = coreGame.GetActName(pact.SlaveMakerAction);
				else {
					pact.SlaveMakerAction = 0;
					pact.image.SlaveMakerAction.Action.htmlText = "";
					pact.image.SlaveMakerAction.gotoAndStop(2);
				}
			}
			i++;
		}
		coreGame.PlanningSelections.Actions.invalidate();
		if (lastentry < 0) coreGame.PlanningSelections.ParticipantsBtn._visible = false;
		else {
			var pact:PlanningAction = arPlanningArray[lastentry];
			var act:ActInfo = slaveData.ActInfoBase.GetActAbs(int(Math.abs(pact.SlaveAction)));	
			var bShow:Boolean = act.IsShowParticipants();
			pact.image.SlaveAction.ParticipantsButton._visible = bShow;
			coreGame.PlanningSelections.ParticipantsBtn._visible = bShow;
		}
	}
	
	public function DeleteSlaveAction(index:Number, noredraw:Boolean)
	{
		if (IsStarted()) {
			coreGame.Bloop();
			return;
		}
		var pa:PlanningAction = arPlanningArray[index];
		var absact:Number = Math.abs(pa.SlaveAction);
		
		UnplanSlaveAction(absact);
	
		pa.SlaveAction = 0;
		pa.image.SlaveAction.Action.htmlText = "";
		if (pa.SlaveMakerAction == 0 || pa.SlaveMakerAction == undefined) {
			pa.image.removeMovieClip();
			delete pa.image;
			arPlanningArray.splice(index, 1);
			if (noredraw != true) {
				if (arPlanningArray.length > 0) RedrawPlanningList(undefined, arPlanningArray[0].PlanningTime);
				else RedrawPlanningList();
			}
		} else if (noredraw != true) coreGame.PlanningSelections.Actions.invalidate();
		if (noredraw != true) {
			if (coreGame.PlanningPage._visible) coreGame.ShowPlanningTab(bSlaveOnly ? -1 : undefined);
			coreGame.UpdateSlave(slaveData);
		}
	}
	
	public function RemoveActionByType(type:Number, noredraw:Boolean)
	{
		var i:Number = arPlanningArray.length;
		type = type < 0 ? type * -1 : type;
		var bChanged:Boolean = false;
		var pa:PlanningAction;
		var absact:Number;
		while (--i >= 0) {
			pa = arPlanningArray[i];
			absact = Math.abs(pa.SlaveAction);
			if (absact == type) {
				UnplanSlaveAction(absact);
				pa.SlaveAction = 1017 + ((pa.PlanningDuration - 1) * 0.01);	// reset to rest
				pa.image.SlaveAction.Action.htmlText = coreGame.GetActName(pa.SlaveAction);
				pa.Participants = new Array();
				bChanged = true;
			} else if (pa.SlaveMakerAction == type) {
				pa.SlaveMakerAction = 2511;
				pa.image.SlaveMakerAction.Action.htmlText = coreGame.GetActName(pa.SlaveMakerAction);
				bChanged = true;
			}
		}

		// refresh list 
		if (bChanged && noredraw != true) {
			coreGame.PlanningSelections.Actions.invalidate();
			if (coreGame.PlanningPage._visible) coreGame.ShowPlanningTab(bSlaveOnly ? -1 : undefined);
			coreGame.UpdateSlave(slaveData);
		}
	}
	
	public function UnplanSlaveAction(absact:Number)
	{
		var cost:Number;
		if (absact == 1001.1 || absact == 1001.2) cost = coreGame.Home.HouseType == 5 ? 0 : 25;
		else if (absact == 1009.1) cost = 25;
		else cost = coreGame.slaveData.ActInfoBase.GetActRO(absact).Cost;
		if (cost > 0) coreGame.Money(cost);
		
		if (absact == 1019.1) coreGame.TotalBooksRead--;
		else if (absact == 1019.2) coreGame.TotalPoetryRead--;
		else if (absact == 1019.3) coreGame.TotalScrollsRead--;
		else if (absact == 1019.4) coreGame.TotalScriptureRead--;
		else if (absact == 1019.5) coreGame.TotalKamasutraRead--;
		else if (absact == 1019.6) coreGame.OtherBooks.ClearBitFlag(32);
		else if (absact == 1019.7) coreGame.OtherBooks.ClearBitFlag(33);
		else if (absact == 1019.8) coreGame.OtherBooks.ClearBitFlag(34);
		else if (absact == 1019.9) coreGame.OtherBooks.ClearBitFlag(35);

		else if (absact == 14) coreGame.slaveData.ActInfoBase.SetActDetails(14, false);
		else if (absact == 17) coreGame.slaveData.ActInfoBase.SetActDetails(17, false);
	}
	
	public function DeleteSlaveMakerAction(index:Number)
	{
		if (IsStarted()) {
			coreGame.Bloop();
			return;
		}
		var pa:PlanningAction = arPlanningArray[index];
		pa.SlaveMakerAction = 0;
		pa.image.SlaveMakerAction.DeleteButton._visible = false;
		pa.image.SlaveMakerAction.LDelete._visible = false;
		pa.image.SlaveMakerAction.Action.htmlText = "";
		pa.image.SlaveMakerAction.gotoAndStop(2);
		if (pa.SlaveAction == 0) {
			pa.image.removeMovieClip();
			delete pa.image;
			arPlanningArray.splice(index, 1);
			RedrawPlanningList();
		} else coreGame.PlanningSelections.Actions.invalidate();
		if (coreGame.PlanningPage._visible) coreGame.ShowPlanningTab(bSlaveOnly ? -1 : undefined);
	}
	
	public function ClearPlannings()
	{
		var i:Number = arPlanningArray.length;
		while (--i >= 0) {
			arPlanningArray[i].SlaveMakerAction = 0;
			DeleteSlaveAction(i, true);
		}
		if (arPlanningArray.length == 0) {
			NewPlanning();
			coreGame.PlanningSelections.ParticipantsBtn._visible = false;
		} else RedrawPlanningList();
		coreGame.PlanningSelections.Actions.invalidate();
		coreGame.UpdateSlave(slaveData);
	}
	
	public function GetActPlannedCount(type:Number) : Number
	{
		var tot:Number = 0;
		var i:Number = arPlanningArray.length;
		type = type < 0 ? type * -1 : type;
		while (--i >= 0) {
			if (Math.abs(arPlanningArray[i].SlaveAction) == type) tot++;
			else if (arPlanningArray[i].SlaveMakerAction == type) tot++;
		}
		return tot;
	}
	
	public function IsActPlanned(type:Number) : Boolean
	{
		var i:Number = arPlanningArray.length;
		type = type < 0 ? type * -1 : type;
		var acti:ActInfo = slaveData.ActInfoBase.GetActAbs(type);
		while (--i >= 0) {
			if (type < 2500 || (acti.Type != 4 && acti.Type != 10)) {
				if (Math.abs(arPlanningArray[i].SlaveAction) == type) return true;
			} else if (arPlanningArray[i].SlaveMakerAction == type) return true;
		}
		return false;
	}
	
	// Add Actions
	public function AddDayNightAction(actnum:Number, loading:Boolean, people:Array, newact:Boolean) : Boolean
	{
		//coreGame.SMTRACE("AddDayNightAction: " + actnum);
		if (actnum == undefined || actnum == 0) return false;
		var absact:Number = Math.abs(actnum);
		var acti:ActInfo = slaveData.ActInfoBase.GetActAbs(int(absact));
		//trace("slaveData = " + slaveData + " " + acti + " " + acti.Act);
		var dur:Number = acti.GetActDuration(absact);
		if (bSlaveOnly) dur = 4;
		
		var lastentry:Number = arPlanningArray.length - 1;
		var lastact:PlanningAction = arPlanningArray[lastentry];
		if (newact == undefined) newact = (acti.Type != 4 && acti.Type != 10) || coreGame.DaysUnavailable != 0 || coreGame.IsNoAssistant();
		//trace("newact = " + newact + " " +  lastact.SlaveMakerAction + " " + acti.Type + " " + coreGame.DaysUnavailable + " " + coreGame.IsNoAssistant());
		if (!newact) {
			if (lastact.SlaveMakerAction != undefined && lastact.SlaveMakerAction != 0) newact = true;
		}
		
		if (loading != true) {
			var ptime:Number = PlanningTime;
			if (!newact) ptime = lastact.PlanningTime;
			//coreGame.SMTRACE(acti.Act + " " + ptime + " " + dur + " " + newact + " " + acti.Type);
			if ((ptime + dur) > EndPlanningTime) {
				//coreGame.SMTRACE("no time");
				return false;
			}
			
			var astart:Number = acti.StartTime;
			var aend:Number = acti.EndTime;
			if (astart != undefined && aend != undefined) {
				if (PlanningTime < astart || PlanningTime > aend) {
					//coreGame.SMTRACE("wrong time");
					return false;
				}
			}
			if (Math.floor(absact) == 1006 || Math.floor(absact) == 1007 || Math.floor(absact) == 1008 || Math.floor(absact) == 1009) {
				if ((PlanningTime % 2) != 0) return false;
			}
			
			if (absact == 1015 && PlanningTime > 6 && PlanningTime < 12) return false;
	
			if (!newact) {
				var sact:Number = Math.abs(lastact.SlaveAction);
				if (sact != 0 && sact != undefined) {
					var sdur:Number = coreGame.GetActDuration(sact);
					if (dur > sdur) {
						//coreGame.SMTRACE("no time during");
						return false;
					}
				}
			}
			
			var cost:Number;
			if (absact == 1001.1 || absact == 1001.2) cost = coreGame.Home.HouseType == 5 ? 0 : 25;
			else if (absact == 1009.1) cost = 25;
			else cost = acti.Cost;
			if (cost > 0) {
				if ((coreGame.VarGold + coreGame.SMGold) < cost) {
					//coreGame.SMTRACE("not enought money");
					return false;
				}
				coreGame.Money(cost * -1);
			}
			
			if (coreGame.Naked && (absact == 24 || absact == 1011)) return false;
			if (absact == 1013) {
				if ((coreGame.SMData.SMFaith == 2 && !coreGame.SMData.SMAdvantages.CheckBitFlag(15))) return false;
			}
			if (absact == 1019.1) {
				if (coreGame.TotalBooksRead >= (2 * coreGame.SMData.TotalBooks)) return false;
				coreGame.TotalBooksRead++;
			}
			if (absact == 1019.2) {
				if (coreGame.TotalPoetryRead >= (2 * coreGame.SMData.TotalPoetry)) return false;
				coreGame.TotalPoetryRead++;
			}
			if (absact == 1019.3) {
				if (coreGame.TotalScrollsRead >= coreGame.TotalScrolls) return false;
				coreGame.TotalScrollsRead++;
			}
			if (absact == 1019.4) {
				if (coreGame.TotalScriptureRead >= coreGame.TotalScripture) return false;
				coreGame.TotalScriptureRead++;
			}
			if (absact == 1019.5) {
				if (coreGame.TotalKamasutraRead >= coreGame.TotalKamasutra) return false;
				coreGame.TotalKamasutraRead++;
			}
			if (absact == 1019.6) {
				if (!coreGame.OtherBooks.CheckBitFlag(0) || coreGame.OtherBooks.CheckBitFlag(32)) return false;
				coreGame.OtherBooks.SetBitFlag(32);
			}
			if (absact == 1019.7) {
				if (!coreGame.OtherBooks.CheckBitFlag(1) || coreGame.OtherBooks.CheckBitFlag(33)) return false;
				coreGame.OtherBooks.SetBitFlag(33);
			}
			if (absact == 1019.8) {
				if (!coreGame.OtherBooks.CheckBitFlag(2) || coreGame.OtherBooks.CheckBitFlag(34)) return false;
				coreGame.OtherBooks.SetBitFlag(34);
			}
			if (absact == 1019.9) {
				if (!coreGame.SMData.OtherBooks.CheckBitFlag(3) || coreGame.SMData.OtherBooks.CheckBitFlag(35)) return false;
				coreGame.SMData.OtherBooks.SetBitFlag(35);
			}			
			
			if (absact == 14 && coreGame.DoneMaster == 1) return false;
			if (absact == 17 && coreGame.IsPonygirl()) return false;
		}
		
		if (absact == 14) coreGame.slaveData.ActInfoBase.SetActDetails(14, true);
		if (absact == 17) coreGame.slaveData.ActInfoBase.SetActDetails(17, true);
		
		delete coreGame.Participants;
		coreGame.Participants = new Array();
		if (people == undefined) {
			coreGame.Participants = new Array();
			var len:Number = acti.Participants.length;
			for (var i:Number = 0; i < len; i++) coreGame.Participants.push(acti.Participants[i]);
		} else if (people.length == 0) coreGame.SetDefaultParticipants(actnum);
		else {
			var len:Number = people.length;
			for (var i:Number = 0; i < len; i++) coreGame.Participants.push(people[i]);
		}
		
		var idx:Number;
		if (newact) {
			if (absact < 1000) idx = AddPlanning(actnum, dur, null, undefined, coreGame.Participants);
			else if (actnum < 2000 || (acti.Type != 4 && acti.Type != 10)) idx = AddPlanning(actnum, dur, null, undefined, people);
			else {
				var snum:Number = 1017 + ((dur - 1) * 0.01);
				idx = AddPlanning(snum, dur, null, absact, people);
			}
			var nact:PlanningAction = arPlanningArray[idx];
			//coreGame.SMTRACE("PlanningDuration: " + nact.PlanningDuration + " " + actnum);
			nact.CreateActImage(this, actnum, idx, lastact.image); 
			return actnum > 0;
		} else {
			//trace("append slave maker action");
			lastact.SlaveMakerAction = absact;
			lastact.CreateActImage(this, actnum, idx); 
			return false;
		}
	}	
	
	public function ShowFlags() : String
	{
		var say:String = "\r\r<b>Planned Actions</b>\r";
		var len:Number = GetActionsCount();
		var pact:PlanningAction;	
		for (var i:Number = 0; i < len; i++) {
			pact = arPlanningArray[i];
			say += "Planned Act (Slave) " + pact.SlaveAction + " at " + pact.PlanningTime + " for " + pact.PlanningDuration + " hrs\r";
			say += "Planned Act (Slave Maker) " + pact.SlaveMakerAction + "\r\r";
		}
		return say;
	}
}
