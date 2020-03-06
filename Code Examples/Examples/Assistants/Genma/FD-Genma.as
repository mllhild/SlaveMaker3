class Genma extends SlaveModule
{
	
	public static function main(swfRoot:MovieClip) : SlaveModule 
	{
		// entry point
		var sm:Genma = new Genma(swfRoot);
		return sm;
	}
	
	public function Genma(mc:MovieClip)
	{
		super(mc);
	}
	
	// ShowAssistant - shows a graphic for the assistant
	// 1 = normal view in small rectangle
	// 2 = tentacle sex (small version shown when slave girl raped)
	// 3 = raped
	// 4 = ignore this (shown when assistant is absent)
	// 5 = wet - she falls in some water
	// 6 = large graphic shown when your slave runs away
	public function ShowAsAssistant(type:Number)
	{
		if (type == 1) _root.ShowMovie(this.Assistant, 0, 0, 1);
		else if (type == 6) super.AutoAttachAndShowMovie("Assistant - Genma - Runaway.jpg", 1, 1, 1);
	}
	
	// HideAsAssistant - hide the assistant graphics
	public function HideAsAssistant()
	{
		this.Assistant._visible = false;
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
	public function InitialiseAsAssistant(firstload:Boolean) : MovieClip {
		_root.ServantName = "Genma";
		_root.ServantGender = 1;
		_root.AssistantTentacleSex = false;
		_root.AssistantRape = false;
		_root.AssistantDescription = "A Slave Maker with odd techniques, often involving humiliation. He is a trained martial artist, but a bit cowardly.\rHe can be used to train any girl and increases her Maximum Obedience by 10%.";
		_root.AssistantCost = 200;
		this.Assistant = super.AttachMovie("Source Files.Assistant - Genma.png");
		return Assistant;
	}

	public function EmployAsAssistant() {
		_root.VarObedience = Math.round(_root.VarObedience * 1.1);
	}
	
		public function StartMessageAsAssistant() : Boolean
	{
		_root.ServantSpeak("The education of " + _root.SlaveName + " will last for " + _root.TrainingTime + " days, and then " + _root.SlaveHeShe + " will be delivered to " + _root.SlaveHisHer + " owner.", true);
		return true;
	}
	
	public function StartNightAsAssistant(intro:Boolean) : Boolean {
		if (intro) {
			_root.ServantSpeakStart("Good evening " + _root.SlaveMakerName + "! It is now time for us to teach " + _root.SlaveName + " sexual techniques and " + _root.SlaveHimHer + " the art of submission.");
			return true;
		}
		return false;
	}
	
	public function LimitMaxMinStatsAsAssistant() {
		_root.AssistantMaxObedience = Math.ceil(_root.MaxStat * 1.1);
		if (_root.AssistantMaxObedience > 300) _root.AssistantMaxObedience = 300;
	}


}