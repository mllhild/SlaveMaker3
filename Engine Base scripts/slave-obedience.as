// Slave Obedience
// testing and refusals

var BadGirl:Number;
var DoneScold:Boolean;
var DoneSpank:Number;

var AnySex:Boolean;
var AnyNonSex:Boolean;
var LastAny:Number;


function TestObedience(diff:Number, act:Number) : Boolean
{
	slaveData.CopyCommonDetails(_root);
	var ret:Boolean = SlaveGirl.TestObedience(diff, act);
	if (ret == undefined) return slaveData.IsObedient(diff, act);
	return ret;
}

function Refused(act:Number, slave:String, servant:String, Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Libido:Number, Reputation:Number, Fatigue:Number, Joy:Number, Love:Number, Special:Number, SexualEnergy:Number)
{
	HideBackgrounds();
	if (act != 0) LastActionRefused = act;

	if (SlaveGirl.ShowRefusedAction(act, slave, servant, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special, SexualEnergy) != true) {
		if (sLeadership > 0) Points(Charisma * 1.5, Sensibility * 1.5, Refinement * 1.5, Intelligence * 1.5, Morality * 1.5, Constitution * 1.5, Cooking * 1.5, Cleaning * 1.5, Conversation * 1.5, BlowJob * 1.5, Fuck * 1.5, Temperament * 1.5, Nymphomania * 1.5, Obedience * 1.5, Libido * 1.5, Reputation * 1.5, Fatigue * 1.5, Joy * 1.5, Love * 2, Special == undefined ? Special : Special * 1.5, SexualEnergy == undefined ? SexualEnergy : SexualEnergy * 1.5);
		else Points(Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special, SexualEnergy);
		if (!XMLData.DoXMLAct("Refused")) {
			if (slave != "") {
				SlaveSpeak(slave, true);
				AddText("\r\r");
			}
			if (servant != "") {
				if (Supervise) AddText(servant);
				else ServantSpeak(servant, true);
				AddText("\r\r");
			}
		}
	}
	CurrentAssistant.ShowRefusedActionAsAssistant(act, slave, servant, Charisma, Sensibility, Refinement, Intelligence, Morality, Constitution, Cooking, Cleaning, Conversation, BlowJob, Fuck, Temperament, Nymphomania, Obedience, Libido, Reputation, Fatigue, Joy, Love, Special, SexualEnergy);
	Bloop();
}
