// Planning Action - a single day/night action 
// Translation status: COMPLETE

import Scripts.Classes.*;

class PlanningAction {
	private var coreGame:Object;		// core game engine
	
	public var PlanningTime:Number;
	public var PlanningDuration:Number;
	public var SlaveAction:Number;
	public var SlaveMakerAction:Number;
	public var image:MovieClip;
	public var Participants:Array;
	
	public function PlanningAction(cg:Object, slave:Number, sm:Number, gtime:Number, duration:Number, image:MovieClip, people:Array) { 
		coreGame = cg;
		SlaveAction = slave;
		SlaveMakerAction = sm;
		PlanningTime = gtime;
		PlanningDuration = duration;
		image = image;
		Participants = new Array();
		if (people != undefined) {
			var len:Number = people.length;
			for (var ip:Number = 0; ip < len; ip++) Participants.push(people[ip]);
		}
	}
	
	public function Save(so:Object)
	{
		so.PlanningTime = PlanningTime;
		so.PlanningDuration = PlanningDuration;
		so.SlaveAction = SlaveAction;
		so.SlaveMakerAction = SlaveMakerAction;
		so.Participants = new Array();
		var len:Number = Participants.length;
		for (var i:Number = 0; i < len; i++) so.Participants.push(Participants[i]);
	}
	
	public function CreateActImage(plist:PlanningList, actnum:Number, idx:Number, lastactimg:MovieClip) 
	{
		var absact:Number = Math.abs(actnum);
		
		if (image == null) {
			var acti:ActInfo = plist.slaveData.ActInfoBase.GetActAbs(int(absact));
			image = coreGame.PlanningSelections.Actions.content.attachMovie(PlanningDuration > 1 ? "Selected Action 2hr" : "Selected Action 1hr", "Action" + idx, coreGame.PlanningSelections.Actions.content.getNextHighestDepth());
			image.TimeLabel.text = coreGame.DecodeTime(PlanningTime);
			image.SlaveAction.LDelete._visible = false;
			image.SlaveMakerAction.LDelete._visible = false;
			image.SlaveAction.gotoAndStop(1);
			image.SlaveMakerAction.gotoAndStop(2);
			//image.SlaveMakerAction.AssistantSuperviseLabel._visible = false;
			//image.SlaveMakerAction.PersonalSuperviseLabel._visible = false;
			//if (plist.bSlaveOnly) {
				//image.SlaveAction.AssistantSuperviseLabel._visible = false;
				//image.SlaveAction.PersonalSuperviseLabel._visible = false;
			//}
			if (absact < 2500 || (acti.Type != 4 && acti.Type != 10)) image.SlaveAction.Action.htmlText = coreGame.GetActName(absact);
			else image.SlaveMakerAction.Action.htmlText = coreGame.GetActName(absact);
			image.SlaveAction.DeleteButton.onPress = coreGame.DeleteSlaveAction;
			image.SlaveAction.LDelete.htmlText = coreGame.Language.GetHtml("Delete", "Buttons", true);
			image.SlaveAction.DeleteButton.onRollOver = function() { this._parent.LParticipants._visible = this._parent.ParticipantsButton._visible; this._parent.LParticipants._alpha = 50; this._parent.LDelete._visible = true; this._parent.LDelete._alpha = 100; }
			image.SlaveAction.DeleteButton.onRollOut = function() { this._parent.LParticipants._visible = false; this._parent.LDelete._visible = false; }
			image.SlaveAction.LParticipants._visible = false;
			image.SlaveMakerAction._visible = !coreGame.IsSexPlanningTime(PlanningTime * 60);
			image.SlaveMakerAction.DeleteButton._visible = false;
			image.SlaveMakerAction.ParticipantsButton._visible = false;
			image.SlaveMakerAction.LParticipants._visible = false;
			var bShow:Boolean = acti.IsShowParticipants();
			image.SlaveAction.ParticipantsButton._visible = bShow;
			coreGame.PlanningSelections.ParticipantsBtn._visible = bShow;
	
			if (acti.Type == 5 || acti.Type == 6) {
				image.SlaveAction.SuperviseLabel.SuperviseText.htmlText = coreGame.Language.PersonalSupervisionString;
				if (bShow) {
					image.SlaveAction.ParticipantsButton.onPress = coreGame.ChangeParticipantsThisAct;
					image.SlaveAction.LParticipants.htmlText = coreGame.Language.GetHtml("ChangeParticipants", "Buttons", true);
					image.SlaveAction.ParticipantsButton.onRollOver = function() { this._parent.LParticipants._visible = true; this._parent.LParticipants._alpha = 100; this._parent.LDelete._visible = this._parent.DeleteButton._visible; this._parent.LDelete._alpha = 50; }
					image.SlaveAction.ParticipantsButton.onRollOut = function() { this._parent.LParticipants._visible = false; this._parent.LDelete._visible = false; }
				}
			} else {
				if (actnum < 0) image.SlaveAction.SuperviseLabel.SuperviseText.htmlText = coreGame.Language.PersonalSupervisionString;
				else if (coreGame.IsNoAssistant()) image.SlaveAction.SuperviseLabel.SuperviseText.htmlText = "";
				else image.SlaveAction.SuperviseLabel.SuperviseText.htmlText = coreGame.Language.AssistantSupervisionString;
				if (bShow) {
					image.SlaveAction.ParticipantsButton.onPress = coreGame.ChangeParticipantsThisAct;
					image.SlaveAction.LParticipants.htmlText = coreGame.Language.GetHtml("ChangeTutor", "Buttons", true);
					image.SlaveAction.ParticipantsButton.onRollOver = function() { this._parent.LParticipants._visible = true; this._parent.LParticipants._alpha = 100; this._parent.LDelete._visible = this._parent.DeleteButton._visible; this._parent.LDelete._alpha = 50; }
					image.SlaveAction.ParticipantsButton.onRollOut = function() { this._parent.LParticipants._visible = false; this._parent.LDelete._visible = false; }
				}
			}
	
			if (idx > 0) {
				image._y = lastactimg._y + lastactimg._height + 3;
				lastactimg.SlaveAction.DeleteButton._visible = false;
			} else image._y = 0;
			
			image.actIndex = idx;
			image.plist = plist;
			coreGame.PlanningSelections.Actions.invalidate();
			return;
		}
		
		// Slave Maker action
		image.SlaveMakerAction.gotoAndStop(1);
		image.SlaveMakerAction.act = absact;
		image.SlaveMakerAction.Action.htmlText = coreGame.GetActName(absact);
		image.SlaveMakerAction.DeleteButton.onPress = coreGame.DeleteSlaveMakerAction;
		image.SlaveMakerAction.LDelete.htmlText = coreGame.Language.GetHtml("Delete", "Buttons", true);
		image.SlaveMakerAction.DeleteButton.onRollOver = function() { this._parent.LDelete._visible = true; this._parent.LDelete._alpha = 100; }
		image.SlaveMakerAction.DeleteButton.onRollOut = function() { this._parent.LDelete._visible = false; }		
		image.SlaveMakerAction.DeleteButton._visible = true;
		image.SlaveMakerAction.ParticipantsButton._visible = false;
		image.SlaveMakerAction.LParticipants._visible = false;
		
		coreGame.PlanningSelections.Actions.invalidate();
	}


}