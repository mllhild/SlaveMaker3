import Scripts.Classes.*;

// Supervisor

var SuperviseYourself:Boolean = false;
var CurrentSuperviseYourself:Boolean = false;

var Supervise:Boolean;
var SupervisorName:String;
var SupervisorGivenName:String;
var SupervisorHimHer:String;
var SupervisorHisHer:String;
var SupervisorHeShe:String;

function UpdateSupervision(superv:Boolean) { dspMain.UpdateSupervision(superv); }


// Supervisor
function IsSupervising() : Boolean { return Supervise; };

function ShowSupervisor() : Boolean
{
	if (Supervise) SMData.ShowSlaveMaker();
	else ShowAssistant();
	return Supervise;
}

function HideSupervisor()
{
	if (Supervise) {
		SMAvatar.Hide();
		SMAppearance._visible = false;
		SMAppearance.frame = -1000;
	} else HideAssistant();
}
