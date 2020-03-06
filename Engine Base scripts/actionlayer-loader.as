import Scripts.Classes.*;
XML.prototype.ignoreWhite = true;
Stage.align = "TL";

function GetSaveData(so:String) : SharedObject
{
	return SharedObject.getLocal(so);
}

var mcLoaderModule:MovieClipLoader = new MovieClipLoader();
var loadListenerModule:Object = new Object();
loadListenerModule.onLoadComplete = function(module:MovieClip) {
	module._visible = false;
	module.initialised = false;
	module.__proto__ = CoreGame.prototype;
};
loadListenerModule.onLoadInit = function(module:MovieClip) {
	module.initialised = false;
	module._visible = false;
	module._lockroot = true;	
	module.Start(module);
	module.mcBase.gotoAndPlay(1);
};
mcLoaderModule.addListener(loadListenerModule);

GameMC._lockroot = true;
mcLoaderModule.loadClip("Game.swf", GameMC);


