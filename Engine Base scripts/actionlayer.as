import Scripts.Classes.*;
import flash.geom.ColorTransform;
import flash.geom.Transform;
import flash.geom.Matrix;

trace("Starting Slave Maker");
//Stage.align = "TL";

XML.prototype.ignoreWhite = true;

#include "actionlayer-standalone.as"

if (initialised == false) return;
stop();
if (initialised == undefined) {
	HideAllImages();
	var Information:DisplayInformation = new DisplayInformation(_root);
	Information.ShowInformation("Wrong File", "This is the wrong file to run, please run SlaveMaker3.swf (All Platforms), or SlaveMaker3.exe (Windows), or SlaveMaker3.app (Mac OSX)");
	return;
}

#include "!coregame.as"

#include "actionlayer-standalone2.as"

#include "!pendingdeletion.as"

#include "assistants.as"
#include "dickgirls.as"
#include "datetime.as"
#include "images.as"

if (Options.FullscreenOn) fscommand("fullscreen", "fullscreen");
fscommand("showmenu", false);


#include "!pendingdeletion.as"
#include "money.as"
#include "slaves-pickaslave.as"

#include "participants.as"
#include "actions-slave-general.as"
#include "actions-slave-sex.as"
#include "planning-general.as"
#include "planning-slave-sex.as"
#include "actions-custom.as"

#include "buttons.as"
#include "ending.as"
#include "events-functions.as"
#include "xml-parser.as"
#include "events-daily.as"
#include "events-next.as"
#include "love.as"

#include "events-yesno.as"
#include "dresses.as"
#include "items.as"
#include "meetings.as"
#include "milking.as"

#include "slave-statistics.as"
#include "slave-obedience.as"
#include "gender.as"

#include "planning.as"
#include "supervisor.as"

#include "morning-talktoslaves.as"
#include "morning-giveorders.as"
#include "startgame.as"
#include "startgame-story.as"

#include "visits&lending-count.as"
#include "visits&lending-highclassprostitute.as"

#include "pregnancy.as"
#include "slavemaker-creation.as"
#include "shortcuts.as"
#include "reset.as"
#include "debugging.as"

#include "!legacy.as"

modulesList = new LoadedModules(coreGame);

_quality = "HIGH";

this._visible = true;

TitleScreen.ViewDialog();

{
	// ensure class is included in the swf and latest version
	var cc:CityMardukane;
	var gm:GenericSlave = new GenericSlave();
	delete gm;
}
