// XML Common Statistics variables
//
// Translation status: COMPLETE
import Scripts.Classes.*;

class XMLStatistics extends XMLStatisticsAccess {

	// constructor (minimal)
	public function XMLStatistics(cg:Object)	{ super(cg); }

	
	private function ParseStat(sNode:XMLNode, sobj:Object) 
	{
		var ifNode:XMLNode;
		var str:String;
		
		for (var stNode:XMLNode = sNode; stNode != null; stNode = stNode.nextSibling) {
			if (stNode.nodeType != 1) continue;
			str = stNode.nodeName.toLowerCase();
			if (str == "else") return;
			if (str == "if") {
				ifNode = coreGame.ParseConditional(stNode, true, false);
				if (ifNode != null) ParseStat(ifNode, sobj);
				continue;
			}
			if (str == "ifor") {
				ifNode = coreGame.ParseConditional(stNode, false, false);
				if (ifNode != null) ParseStat(ifNode, sobj);
				continue;
			}
			if (str == "ifnot") {
				ifNode = coreGame.ParseConditional(stNode, false, true);
				if (ifNode != null) ParseStat(ifNode, sobj);
				continue;
			}

			var i:Number = SlaveStatistics.GetDeficiencyTalent(str);
			if (i == 0) continue;
			var val:Number = GetExpression(stNode.firstChild.nodeValue);
			if (val == undefined) continue;
			switch(i) {
				case 1: sobj.Charisma = val; break;
				case 2: sobj.Sensibility = val; break;
				case 3: sobj.Refinement = val; break;
				case 4: sobj.Intelligence = val; break;
				case 5: sobj.Morality = val; break;
				case 6: sobj.Constitution = val; break;
				case 7: sobj.Cooking = val; break;
				case 8: sobj.Cleaning = val; break;
				case 9: sobj.Conversation = val; break;
				case 10: sobj.BlowJob = val; break;
				case 11: sobj.Fuck = val; break;
				case 12: sobj.Temperament = val; break;
				case 13: sobj.Nymphomania = val; break;
				case 14: sobj.Obedience = val; break;
				case 15: sobj.Lust = val; break;
				case 16: sobj.Fatigue = val; break;
				case 17: sobj.Joy = val; break;
				case 18: sobj.Reputation = val; break; 
				case 19: sobj.Special = val; break;
				case 22: sobj.SexualEnergy = val; break;
				case 23: sobj.Special2 = val; break;
				case 24: sobj.Love = val; break;
				case 25: sobj.Sexuality = val; break;
			}
		}
	}

	// stat updates
	public function ParsePoints(aNode:XMLNode)
	{
		var sobj:Object = new Object();
		sobj.Charisma = 0;
		sobj.Sensibility = 0;
		sobj.Refinement = 0;
		sobj.Intelligence = 0;
		sobj.Morality = 0;
		sobj.Constitution = 0;
		sobj.Cooking = 0;
		sobj.Cleaning = 0;
		sobj.Conversation = 0;
		sobj.BlowJob = 0;
		sobj.Fuck = 0;
		sobj.Temperament = 0;
		sobj.Nymphomania = 0;
		sobj.Obedience = 0;
		sobj.Lust = 0;
		sobj.Reputation = 0;
		sobj.Fatigue = 0;
		sobj.Joy = 0;
		sobj.Love = 0;
		sobj.Special = 0;
		sobj.Special2 = 0;
		sobj.SexualEnergy = 0;
		
	
		if (aNode.firstChild.nodeValue != null && aNode.firstChild.nodeValue.indexOf(",") != -1) {
			var sl:Array = aNode.firstChild.nodeValue.split(",");
			sobj.Charisma = GetExpression(sl[0]);
			sobj.Sensibility = GetExpression(sl[1]);
			sobj.Refinement = GetExpression(sl[2]);
			sobj.Intelligence = GetExpression(sl[3]);
			sobj.Morality = GetExpression(sl[4]);
			sobj.Constitution = GetExpression(sl[5]);
			sobj.Cooking = GetExpression(sl[6]);
			sobj.Cleaning = GetExpression(sl[7]);
			sobj.Conversation = GetExpression(sl[8]);
			sobj.BlowJob = GetExpression(sl[9]);
			sobj.Fuck = GetExpression(sl[10]);
			sobj.Temperament = GetExpression(sl[11]);
			sobj.Nymphomania = GetExpression(sl[12]);
			sobj.Obedience = GetExpression(sl[13]);
			sobj.Lust = GetExpression(sl[14]);
			sobj.Reputation = GetExpression(sl[15]);
			sobj.Fatigue = GetExpression(sl[16]);
			sobj.Joy = GetExpression(sl[17]);
			sobj.Love = GetExpression(sl[18]);
			if (sl[19] != undefined) {
				sobj.Special = GetExpression(sl[19]);
				if (sl[20] != undefined) sobj.Special2 = GetExpression(sl[20]);
				if (sl[21] != undefined) sobj.SexualEnergy = GetExpression(sl[21]);
			}
		} else ParseStat(aNode.firstChild, sobj);
		
		var str:String = aNode.attributes.person.toLowerCase();
		var pero:Person = coreGame.People.GetPersonsObject(str);
		if (pero != null) {
			pero.Points(sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality);		// note stat names here are wrong, just order matters
			return;
		}
		var per:Number = ParsePersonDetails(aNode);
		if (per == -1000) {
			// apply to all participants
			for (var i:Number = 0; i < coreGame.Participants.length; i++) coreGame.PointsByIndex(coreGame.Participants[i], sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Reputation, sobj.Fatigue, sobj.Joy, sobj.Love, sobj.Special, sobj.Special2, sobj.SexualEnergy)
		} else if (per == -999) {
			// Apply effect to all owned slaves
			var j:Number = SMData.SlavesArray.length;
			var sd:Object;
			while (--j >= -3) {
				if (j == -1) sd = _root;
				else if (j == -2 && coreGame.AssistantData != null) {
					if (coreGame.AssistantData.SlaveType != 1 && coreGame.AssistantData.SlaveType != 2 && coreGame.AssistantData.SlaveType != 0) sd = coreGame.AssistantData;
					else break;	// assistant is the last
				} else if (j == -3) {
					if (coreGame.SpecialIndex != undefined) sd = SMData.SlavesArray[coreGame.SpecialIndex];
					else continue;
				} else {
					sd = SMData.SlavesArray[j];
					if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
					if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
				}
				sd.Points(sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Reputation, sobj.Fatigue, sobj.Joy, sobj.Love, sobj.Special, sobj.Special2, sobj.SexualEnergy);
				coreGame.UpdateSlave(SMData.GetSlaveByIndex(coreGame.PersonIndex));
			}
		} else {
			coreGame.PointsByIndex(per, sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Reputation, sobj.Fatigue, sobj.Joy, sobj.Love, sobj.Special, sobj.Special2, sobj.SexualEnergy);
		}
		delete sobj;
	}
	
	public function ParseMaxStats(aNode:XMLNode)
	{
		var sobj:Object = new Object();
		sobj.Charisma = 0;
		sobj.Sensibility = 0;
		sobj.Refinement = 0;
		sobj.Intelligence = 0;
		sobj.Morality = 0;
		sobj.Constitution = 0;
		sobj.Cooking = 0;
		sobj.Cleaning = 0;
		sobj.Conversation = 0;
		sobj.BlowJob = 0;
		sobj.Fuck = 0;
		sobj.Temperament = 0;
		sobj.Nymphomania = 0;
		sobj.Obedience = 0;
		sobj.Lust = 0;
		sobj.Reputation = 0;
		sobj.Fatigue = 0;
		sobj.Joy = 0;
		sobj.Love = 0;
		sobj.Special = 0;
		sobj.Special2 = 0;
		sobj.SexualEnergy = 0;
	
	
		if (aNode.firstChild.nodeValue != null && aNode.firstChild.nodeValue.indexOf(",") != -1) {
			var sl:Array = aNode.firstChild.nodeValue.split(",");
			sobj.Charisma = GetExpression(sl[0]);
			sobj.Sensibility = GetExpression(sl[1]);
			sobj.Refinement = GetExpression(sl[2]);
			sobj.Intelligence = GetExpression(sl[3]);
			sobj.Morality = GetExpression(sl[4]);
			sobj.Constitution = GetExpression(sl[5]);
			sobj.Cooking = GetExpression(sl[6]);
			sobj.Cleaning = GetExpression(sl[7]);
			sobj.Conversation = GetExpression(sl[8]);
			sobj.BlowJob = GetExpression(sl[9]);
			sobj.Fuck = GetExpression(sl[10]);
			sobj.Temperament = GetExpression(sl[11]);
			sobj.Nymphomania = GetExpression(sl[12]);
			sobj.Obedience = GetExpression(sl[13]);
			sobj.Lust = GetExpression(sl[14]);
			sobj.Joy = GetExpression(sl[15]);
			if (sl[16] != undefined) sobj.Special = GetExpression(sl[16]);
			if (sl[17] != undefined) sobj.Special2 = GetExpression(sl[17]);
			if (sl[18] != undefined) sobj.Love = GetExpression(sl[18]);
		} else ParseStat(aNode.firstChild, sobj);
		
		var per:Number = ParsePersonDetails(aNode);
		if (per == -1000) {
			for (var i:Number = 0; i < coreGame.Participants.length; i++) SMData.GetSlaveByIndex(per).ChangeMaxStats(sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Joy, sobj.Special, sobj.Special2, sobj.Love);
	
		} else if (per == -999) {
			// Apply effect to all owned slaves
			var j:Number = SMData.SlavesArray.length;
			var sd:Object;
			while (--j >= -3) {
				if (j == -1) sd = _root;
				else if (j == -2 && coreGame.AssistantData != null) {
					if (coreGame.AssistantData.SlaveType != 1 && coreGame.AssistantData.SlaveType != 2 && coreGame.AssistantData.SlaveType != 0) sd = coreGame.AssistantData;
					else break;	// assistant is the last
				} else if (j == -3) {
					if (coreGame.SpecialIndex != undefined) sd = SMData.SlavesArray[coreGame.SpecialIndex];
					else continue;
				} else {
					sd = SMData.SlavesArray[j];
					if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
					if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
				}
				sd.ChangeMaxStats(sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Joy, sobj.Special, sobj.Special2, sobj.Love);
			}
		} else SMData.GetSlaveByIndex(per).ChangeMaxStats(sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Joy, sobj.Special, sobj.Special2, sobj.Love);
		
		delete sobj;
	}

	public function ParseMinStats(aNode:XMLNode)
	{
		var sobj:Object = new Object();
		sobj.Nymphomania = 0;
		sobj.Lust = 0;	
	
		if (aNode.firstChild.nodeValue != null && aNode.firstChild.nodeValue.indexOf(",") != -1) {
			var sl:Array = aNode.firstChild.nodeValue.split(",");
			sobj.Nymphomania = GetExpression(sl[0]);
			sobj.Lust = GetExpression(sl[1]);
		} else ParseStat(aNode.firstChild, sobj);
		
		var per:Number = ParsePersonDetails(aNode);
		if (per == -1000) {
			for (var i:Number = 0; i < coreGame.Participants.length; i++) SMData.GetSlaveByIndex(per).ChangeMinStats(sobj.Nymphomania, sobj.Lust);
		} else if (per == -999) {
			// Apply effect to all owned slaves
			var j:Number = SMData.SlavesArray.length;
			var sd:Object;
			while (--j >= -3) {
				if (j == -1) sd = _root;
				else if (j == -2 && coreGame.AssistantData != null) {
					if (coreGame.AssistantData.SlaveType != 1 && coreGame.AssistantData.SlaveType != 2 && coreGame.AssistantData.SlaveType != 0) sd = coreGame.AssistantData;
					else break;	// assistant is the last
				} else if (j == -3) {
					if (coreGame.SpecialIndex != undefined) sd = SMData.SlavesArray[coreGame.SpecialIndex];
					else continue;
				} else {
					sd = SMData.SlavesArray[j];
					if (sd.SlaveType != 0 && sd.SlaveType != 1 && sd.SlaveType != 2) continue;
					if (sd.SlaveType == 1 && sd.CanAssist == false) continue;
				}
				sd.ChangeMinStats(sobj.Nymphomania, sobj.Lust);
			}
		} else if (per == -100) SMData.SMChangeMinStats(sobj.Nymphomania, sobj.Lust);
		else SMData.GetSlaveByIndex(per).ChangeMinStats(sobj.Nymphomania, sobj.Lust);
		
		delete sobj;
	}

	public function ParseSetFactors(aNode:XMLNode)
	{
		var sobj:Object = new Object();
		sobj.Charisma = undefined;
		sobj.Sensibility = undefined;
		sobj.Refinement = undefined;
		sobj.Intelligence = undefined;
		sobj.Morality = undefined;
		sobj.Constitution = undefined;
		sobj.Cooking = undefined;
		sobj.Cleaning = undefined;
		sobj.Conversation = undefined;
		sobj.BlowJob = undefined;
		sobj.Fuck = undefined;
		sobj.Temperament = undefined;
		sobj.Nymphomania = undefined;
		sobj.Obedience = undefined;
		sobj.Lust = undefined;
		sobj.Reputation = undefined;
		sobj.Fatigue = undefined;
		sobj.Joy = undefined;
		sobj.Love = undefined;
		sobj.Special = undefined;
		sobj.Special2 = undefined;
		sobj.SexualEnergy = undefined;
		sobj.Sexuality = undefined;
	
		if (aNode.firstChild.nodeValue != null && aNode.firstChild.nodeValue.indexOf(",") != -1) {
			var sl:Array = aNode.firstChild.nodeValue.split(",");
			sobj.Charisma = GetExpression(sl[0]);
			sobj.Sensibility = GetExpression(sl[1]);
			sobj.Refinement = GetExpression(sl[2]);
			sobj.Intelligence = GetExpression(sl[3]);
			sobj.Morality = GetExpression(sl[4]);
			sobj.Constitution = GetExpression(sl[5]);
			sobj.Cooking = GetExpression(sl[6]);
			sobj.Cleaning = GetExpression(sl[7]);
			sobj.Conversation = GetExpression(sl[8]);
			sobj.BlowJob = GetExpression(sl[9]);
			sobj.Fuck = GetExpression(sl[10]);
			sobj.Temperament = GetExpression(sl[11]);
			sobj.Nymphomania = GetExpression(sl[12]);
			sobj.Obedience = GetExpression(sl[13]);
			sobj.Lust = GetExpression(sl[14]);
			sobj.Fatigue = GetExpression(sl[15]);
			sobj.Joy = GetExpression(sl[16]);
			if (sl[17] != undefined) {
				sobj.Special = sobj.GetExpression(sl[17]);
				sobj.Special2 = sobj.GetExpression(sl[18]);
				sobj.SexualEnergy = sobj.GetExpression(sl[19]);
				sobj.Sexuality = sobj.GetExpression(sl[20]);
			}
		} else ParseStat(aNode.firstChild, sobj);
	
		coreGame.SetFactors(sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Fatigue, sobj.Joy, sobj.Special, sobj.Special2, sobj.SexualEnergy, sobj.Sexuality);
		
		delete sobj;
	}
	
	
	private function ApplyDressStats(dress:Number, aNode:XMLNode)
	{	
		if (aNode.firstChild.nodeValue != null && aNode.firstChild.nodeValue.indexOf(",") != -1) {
			var se:Array = aNode.firstChild.nodeValue.split(",");
			slaveData.SetDressStatsByArray(dress, se);
			return;
		}
		
		var sobj:Object = new Object();
		sobj.Charisma = undefined;
		sobj.Sensibility = undefined;
		sobj.Refinement = undefined;
		sobj.Intelligence = undefined;
		sobj.Morality = undefined;
		sobj.Constitution = undefined;
		sobj.Cooking = undefined;
		sobj.Cleaning = undefined;
		sobj.Conversation = undefined;
		sobj.BlowJob = undefined;
		sobj.Fuck = undefined;
		sobj.Temperament = undefined;
		sobj.Nymphomania = undefined;
		sobj.Obedience = undefined;
		sobj.Lust = undefined;
		sobj.Reputation = undefined;
		sobj.Joy = undefined;
		sobj.Special = undefined;
		sobj.Special2 = undefined;
		ParseStat(aNode.firstChild, sobj);
		
		slaveData.SetDressStats(dress, sobj.Charisma, sobj.Sensibility, sobj.Refinement, sobj.Intelligence, sobj.Morality, sobj.Constitution, sobj.Cooking, sobj.Cleaning, sobj.Conversation, sobj.BlowJob, sobj.Fuck, sobj.Temperament, sobj.Nymphomania, sobj.Obedience, sobj.Lust, sobj.Reputation, sobj.Joy, sobj.Special, sobj.Special2);

		delete sobj;
	}


}