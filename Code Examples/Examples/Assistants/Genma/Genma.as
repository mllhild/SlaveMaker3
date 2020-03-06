import Scripts.Classes.*;

class Genma extends SlaveModule
{
	public static function main(swfRoot:MovieClip, slave:Object, core:Object) : SlaveModule 
	{
		// entry point
		var sm:Genma = new Genma(swfRoot, slave, core);
		return sm;
	}
	
	public function Genma(mc:MovieClip, slave:Object, core:Object)
	{
		super(mc, slave, core);
		this.mcBase.Assistant.gotoAndStop(1);
	}
	
	// ShowAssistant - shows a graphic for the assistant
	// 1 = normal view in small rectangle
	// 2 = tentacle sex (small version shown when slave girl raped)
	// 3 = raped
	// 4 = never actually passed as a parameter
	// 5 = wet - she falls in some water
	// 6 = large graphic shown when your slave runs away
	public function ShowAsAssistant(type:Number)
	{
		if (type == 4) return false;
		if (type == 1) _root.ShowMovie(this.mcBase.Assistant, 0, 0, 1);
		else if (type == 6) _root.ShowMovie(this.mcBase.Assistant, 1, 2, 2);
	}

	// HideAsAssistant - hide the assistant graphics
	function HideAsAssistant()
	{
		this.mcBase.Assistant._visible = false;
	}

	// InitialiseAsAssistant - sets up the assistant
	/*
	Variables to control servant
			_root.ServantName = "Genma";		// name
			_root.ServantPronoun = "I";			// Pronoun, default "I"
			_root.AssistantTentacleSex = false; // can the assistant be tentacle fucked, default true
			_root.AssistantRape = false;		// can the assistant be raped, default true
			_root.ServantGender = 1;			// servants gender, 1 = male, 2 = female, 3 = dickgirl, default 1
			_root.SlaveLikeServant = true;		// misleading name, does the servant like the slave, default true
			_root.AssistantDescription = 		// a description of the assistant and any effects while training slaves
				"An experienced Slave Maker but with odd techniques, often involving humiliation. He is a trained martial artist, but surprising cowardly.\r\rHe can be used to train any girl and increases her Maximum Obedience by 10%.";
			_root.AssistantCost = 200;			// The cost to employ their services
	*/
	public function InitialiseAsAssistant() : MovieClip {
		_root.AssistantTentacleSex = false;
		_root.AssistantRape = false;
		return this.mcBase.Assistant;
	}

	public function EmployAsAssistant() {
		if (!_root.IsSlave("Ino")) _root.VarObedience = Math.round(_root.VarObedience * 1.1);
	}
	
	public function LimitMaxMinStatsAsAssistant() {
		if (!_root.IsSlave("Ino")) {
			_root.AssistantMaxObedience = Math.ceil(_root.MaxStat * 1.1);
			if (_root.AssistantMaxObedience > 300) _root.AssistantMaxObedience = 300;
		}
	}

}