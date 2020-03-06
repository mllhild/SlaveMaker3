// List of plannable actions
// Translation status: COMPLETE

import Scripts.Classes.*;

class PlannableActions {
	private var coreGame:Object;			// core game engine
	private var arPlanArray:Array;
	public var strLastTitle:String;
	
	public function PlannableActions(cg:Object) { 
		coreGame = cg;
		arPlanArray = new Array();
		strLastTitle = "";
	}

	public function Reset()
	{
		var act:ActInfo;
		var i:Number = arPlanArray.length;
		while (--i >= 0) {
			act = ActInfo(arPlanArray.pop());
			delete act;
		}
		delete arPlanArray;
		arPlanArray = new Array();
		delete strLastTitle;
		strLastTitle = "";
	}
	
	public function GetCount() : Number { return arPlanArray.length; }
	
	public function GetAct(idx:Number) : ActInfo { return arPlanArray[idx]; }
	
	public function AddAllActsByType(type:Number, stitle:String)
	{
		var len:Number = coreGame.slaveData.ActInfoBase.GetActCounts();
		var act:ActInfo;
		var actl:ActInfo;
		var lastact:ActInfo;
		var lenaa:Number = arPlanArray.length;
		var bfnd:Boolean;
		var bTitleAdded:Boolean = false;
		var cidx:Number = 1;
		var actn:Number;
		for (var i:Number = 0; i < len; i++) {
			act = coreGame.slaveData.ActInfoBase.GetActByIndex(i);
			//SMTRACE(act.strNodeName + " " + act.Name + " " + act.bShown + " " + act.Type + " " + act.Act);
			if (!act.bShown) continue;
			if (act.Type != type) continue;
			if (act.strNodeName == "" || act.Name == "") continue;
			// exclude selected acts
			actn = act.Act;
			if (actn == 10 || actn == 13 || actn == 16 || actn == 2515 || act == 99) continue;
			bfnd = false;
			for (var j:Number = 0; j < lenaa && bfnd == false; j++) {
				//cidx = 1;
				actl = arPlanArray[j];
				while (actl != null) {
					if (actl == act) {
						bfnd = true;
						break;
					}
					actl = actl.childAct;
				}
			}
			if (!bfnd) {
				if (!bTitleAdded) {
					if (stitle != undefined) act.PlanTitle = stitle;
					else act.PlanTitle = "";
					bTitleAdded = true;
				}
				if (cidx == 1) {
					act.childAct = null;
					act.parentAct = null;
					arPlanArray.push(act);
					//SMTRACE("add act " + act.strNodeName);
				} else lastact.AddChildAct(act);
				lastact = act;
				cidx++;
				if (cidx > 7) cidx = 1;
			}
		}
	}
	
	public function AddActByName(str:String, stitle:String) : ActInfo
	{
		var act:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(str);
		if (act == null) act = coreGame.slaveData.ActInfoBase.GetAct(coreGame.slaveData.ActInfoBase.GetActNumber(str));
		if (!act.bShown) return null;
		if (stitle != undefined) {
			act.PlanTitle = stitle;
			delete strLastTitle;
			strLastTitle = new String(stitle);
		} else act.PlanTitle = "";
		act.childAct = null;
		act.parentAct = null;
		arPlanArray.push(act);
		return act;
	}
	
	public function AddActByNumber(actno:Number, stitle:String) : ActInfo
	{
		var act:ActInfo = coreGame.slaveData.ActInfoBase.GetActAbs(actno);
		if (!act.bShown) return null;
		if (stitle != undefined) {
			act.PlanTitle = stitle;
			delete strLastTitle;
			strLastTitle = new String(stitle);
		} else act.PlanTitle = "";
		act.childAct = null;
		act.parentAct = null;
		arPlanArray.push(act);
		return act;
	}
	
	public function AddChildActByName(act:ActInfo, str:String, stitle:String) : ActInfo
	{
		var pcnt:Number = act.GetShownParentActCount();
		if (act == null || pcnt == 4) return AddActByName(str, stitle);
		
		var cact:ActInfo = coreGame.slaveData.ActInfoBase.GetActByName(str);
		if (cact == null) cact = coreGame.slaveData.ActInfoBase.GetAct(coreGame.slaveData.ActInfoBase.GetActNumber(str));
		if (stitle != undefined) {
			cact.PlanTitle = stitle;
			delete strLastTitle;
			strLastTitle = new String(stitle);
		} else cact.PlanTitle = "";
		act.AddChildAct(cact);
		return cact;
	}
	
	public function AddChildActByNumber(act:ActInfo, actno:Number, stitle:String) : ActInfo
	{
		var pcnt:Number = act.GetShownParentActCount();
		if (act == null || pcnt == 4) return AddActByNumber(actno, stitle);
		
		var cact:ActInfo = coreGame.slaveData.ActInfoBase.GetAct(actno);
		act.AddChildAct(cact);
		return cact;
	}
	
	// is an act visible
	public function IsActVisible(act:Number) : Boolean
	{
		return coreGame.slaveData.ActInfoBase.IsActVisible(act);
	}
	public function IsActAvailable(act:Number) : Boolean
	{
		return coreGame.slaveData.ActInfoBase.IsActAvailable(act);
	}	
	
	public function SetPlanningJobs()
	{
		AddActByName("acolyte", "Holy work");
		
		var act:ActInfo = AddActByName("restaurant", coreGame.Language.GetHtml("PublicTitle", "Planning"));
		act = AddChildActByName(act, "bar");
		act = AddChildActByName(act, "onsen");
		act = AddChildActByName(act, "library");
		
		act = AddActByName("sleazybar", coreGame.Language.GetHtml("LewdTitle", "Planning"));
		act = AddChildActByName(act, "brothel");
		
		AddActByNumber(1031, "Special");
			
		AddAllActsByType(2, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
	
	public function SetPlanningChores()
	{
		var act:ActInfo = AddActByName("cooking", coreGame.Language.GetHtml("DomesticTitle", "Planning"));
		act = AddChildActByName(act, "cleaning");
		act = AddChildActByNumber(act, 99);
		
		act = AddActByName("expose", coreGame.Language.GetHtml("PublicTitle", "Planning"));
		act = AddChildActByNumber(act, 1003);
	
		act = AddActByName("discuss", coreGame.Language.GetHtml("PersonalTitle", "Planning"));
		act = AddChildActByName(act, "makeup");
		act = AddChildActByName(act, "break");
		act = AddChildActByName(act, "read");
			
		AddAllActsByType(1, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
	
	public function SetPlanningShops()
	{
		var act:ActInfo = AddActByName("Shop", coreGame.Language.GetHtml("ShoppingTitle", "Planning"));
		act = AddChildActByName(act, "Salon");
		act = AddChildActByName(act, "Tailor");
		act = AddChildActByName(act, "Stables");
		
		act = AddActByName("takeawalk", coreGame.Language.GetHtml("WalkVisitTitle", "Planning"));
		act = AddChildActByName(act, "visit");
	
		AddAllActsByType(8, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
	
	public function SetPlanningSchools()
	{
		var act:ActInfo = AddActByName("Sciences", coreGame.Language.GetHtml("MentalTitle", "Planning"));
		act = AddChildActByName(act, "Theology");
		act = AddChildActByName(act, "Refinement");
		
		act = AddActByName("Dance", coreGame.Language.GetHtml("PhysicalTitle", "Planning"));
		act = AddChildActByName(act, "Singing");
		
		act = AddActByName("xxx", coreGame.Language.GetHtml("LewdTitle", "Planning"));
	
		AddAllActsByType(3, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
	
	public function SetPlanningSexNormal()
	{
		var act:ActInfo = AddActByName("Lick", coreGame.Language.GetHtml("SexNormalOral", "Planning"));
		act = AddChildActByNumber(act, 5);
		act = AddChildActByName(act, "TitsFuck");
		act = AddChildActByName(act, "sixtynine");
		act = AddChildActByName(act, "Footjob");
		act = AddChildActByName(act, "Handjob");
	
		act = AddActByName("Masturbate", coreGame.Language.GetHtml("SoloTitle", "Planning"));
		act = AddChildActByName(act, "Dildo");
		
		act = AddActByName("Fuck", coreGame.Language.GetHtml("SexNormalIntercourse", "Planning"));
		act = AddChildActByName(act, "Anal");
		act = AddChildActByName(act, "Threesome");
	
		act = AddActByName("Touch", coreGame.Language.GetHtml("SexNormalIntimacy", "Planning"));
		act = AddChildActByNumber(act, 23);
		act = AddChildActByName(act, "StripTease");
	
		AddAllActsByType(5, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
	
	public function SetPlanningSexExtreme()
	{
		var act:ActInfo = AddActByName("GangBang", coreGame.Language.GetHtml("SexExtremeMultiple", "Planning"));
		act = AddChildActByName(act, "Orgy");
		act = AddChildActByName(act, "CumBath");
		
		act = AddActByName("Bondage", coreGame.Language.GetHtml("SexExtremeSubmission", "Planning"));
		act = AddChildActByName(act, "Spanking");
		act = AddChildActByName(act, "Master");
		act = AddChildActByName(act, "Ponygirl");
		
		act = AddActByName("Lesbian", coreGame.Language.GetHtml("SameSexTitle", "Planning"));
	
		AddAllActsByType(6, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
	
	public function SetPlanningSlaveMaker()
	{		
		var act:ActInfo = AddActByName("martialtraining", coreGame.Language.GetHtml("SlaveMakerTraining", "Planning", true));
		act = AddChildActByName(act, "pray");
		act = AddChildActByName(act, "attendcourt");
	
		act = AddActByName("smnothing", coreGame.Language.GetHtml("SlaveMakerRelaxation", "Planning", true));
		act = AddChildActByName(act, "relaxinabar");
		act = AddChildActByName(act, "smsleazybar");
		act = AddChildActByNumber(act, 2517);
	
		act = AddActByName("slavemarket", coreGame.Language.GetHtml("ShoppingTitle", "Planning", true));
		act = AddChildActByName(act, "drugdealer");
		act = AddChildActByName(act, "itemsalesman");
		act = AddChildActByName(act, "armoury");
		
		act = null;
		var jt:String = coreGame.Language.GetHtml("JobsTitle", "Planning", true);
		act = AddChildActByName(act, "smjobworkguild", jt);
		act = AddChildActByName(act, "smjobcockmilk", jt);
		act = AddChildActByName(act, "smjobbrothel", jt);
		act = AddChildActByName(act, "smjobtradegoods", jt);
		act = AddChildActByName(act, "smjobdom", jt);
		act = AddChildActByName(act, "smjobpotions", jt);
		act = AddChildActByName(act, "smjobpreach", jt);
		act = AddChildActByName(act, "smjobmilitia", jt);
		act = AddChildActByName(act, "smjobsleazybar", jt);
	
		AddAllActsByType(4, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}

	public function SetPlanningOrders(sdata:Object)
	{
		var act:ActInfo = AddActByName("Cooking", coreGame.Language.GetHtml("ChoresTitle", "Planning"));
		act = AddChildActByName(act, "Cleaning");
		act = AddChildActByNumber(act, 1043);		// fitness
	
		act = AddActByNumber(1044, coreGame.Language.GetHtml("SlaveMakerRelaxation", "Planning"));
		act = AddChildActByNumber(act, 1042);		// play
	
		if (sdata.Loyalty == 0) act = AddActByNumber(1041, coreGame.Language.GetHtml("Supervision", "Planning"));
	
		act = null;
		if (sdata.IsPonygirl() && coreGame.Home.HouseType == 3) act = AddChildActByNumber(act, 1045, coreGame.Language.GetHtml("JobsTitle", "Planning"));
		if (coreGame.Home.HouseType == 7) act = AddChildActByNumber(act, 1047, coreGame.Language.GetHtml("JobsTitle", "Planning"));
		if (coreGame.Home.HouseType == 8) act = AddChildActByNumber(act, 1046, coreGame.Language.GetHtml("JobsTitle", "Planning"));
		
		AddAllActsByType(12, coreGame.Language.GetHtml("Others", "SlaveMarket"));
	}
}
