// DisplayHints - Hints!
//
// Translation status: COMPLETE

import Scripts.Classes.*;

class DisplayHints extends DisplayBase {
		
	private var bAllowed:Boolean;
	private var strHint:String;
	private var intervalHint:Number;
	
	
	// Constructor
	public function DisplayHints(cg:Object)
	{ 
		super(cg.Hint, cg);
		
		// General Hints
		mcBase.Text.wordWrap = true;
		mcBase.Text.autoSize = true;
		mcBase.tabEnabled = false;
		strHint = "";
		intervalHint = 0;
		bAllowed = true;
		
		// Person Hints
		var ti:DisplayHints = this;
		coreGame.PersonHint.onRollOut = function() { ti.HideHints(); }
		coreGame.PersonHint.tabEnabled = false;
		coreGame.PersonHint.onRollOver = function() { ti.DisplayPersonHint(); }
	}

	
	// General Hints
	
	// constant text
	public function SetHintText(txt:String) { strHint = txt; }
	public function AddHintText(txt:String) { strHint += txt; }
	public function ShowHintAdd(txt:String) { ShowHint(strHint + txt); }
	public function GetHintText() : String { return strHint; }
	
	public function ShowHint(txt:String, xpos:Number, wid:Number)
	{
		if (!bAllowed) return;
		if (txt != undefined) strHint = txt;
		clearInterval(intervalHint);
		intervalHint = setInterval(this, "DelayHint", 350, xpos, wid);
	}
	
	// text from Language xml files
	public function SetHintLang(node:String, base) { strHint = Language.GetHtml(node, base == undefined ? Language.hintNode : base); }
	public function AddHintLang(node:String, base) { strHint += Language.GetHtml(node, base == undefined ? Language.hintNode : base); }
	public function ShowHintAddLang(node:String, base) { ShowHint(strHint + Language.GetHtml(node, base == undefined ? Language.hintNode : base)); }

	public function ShowHintLangCR(node:String, base, xpos:Number, wid:Number)
	{
		if (!bAllowed) return;
		var txt:String = Language.GetHtml(node, base == undefined ? Language.hintNode : base);
		if (txt != "") strHint = txt + "\r";
		clearInterval(intervalHint);
		intervalHint = setInterval(this, "DelayHint", 350, xpos, wid);
	}
	public function ShowHintLang(node:String, base, xpos:Number, wid:Number)
	{
		if (!bAllowed) return;
		var txt:String = Language.GetHtml(node, base == undefined ? Language.hintNode : base);
		if (txt != "") strHint = txt;
		clearInterval(intervalHint);
		intervalHint = setInterval(this, "DelayHint", 350, xpos, wid);
	}
	
	// general functions
	public function IsHints() : Boolean	{ 
		return bAllowed && coreGame.AskQuestions._visible == false && coreGame.YesEvent._visible == false && coreGame.NextEvent._visible == false && coreGame.NextEnding._visible == false && coreGame.NextGeneral._visible == false;
	}
	public function IsHintText() : Boolean { return (strHint != ""); }
	
	public function DelayHint(xbase:Number, wid:Number)
	{
		clearInterval(intervalHint);
		if (wid == undefined) wid = 0;
		mcBase.Text.htmlText = coreGame.UpdateMacros(strHint) + "\r";
		if (mcBase._height < 20) mcBase.Text.htmlText += "\r";
		var xpos:Number = xbase == undefined ? coreGame.mcBase._xmouse : xbase;
		var ypos:Number = coreGame.mcBase._ymouse;
		if (xpos > 400) xpos -= mcBase._width;
		else xpos += wid;
		if (ypos > (600 - mcBase._height)) ypos -= mcBase._height;
		mcBase._x = xpos;
		mcBase._y = ypos;  
		mcBase._visible = true;
	}
		
	public function ResetHints()
	{
		clearInterval(intervalHint);
		bAllowed = true;
	}
	
	public function StopHints()
	{
		bAllowed = false;
		mcBase._visible = false;
		clearInterval(intervalHint);
		intervalHint = setInterval(this, "ResetHints", 800);
	}
	
	public function HideHints()
	{
		if (bAllowed) clearInterval(intervalHint);
		mcBase._visible = false;
	}
	
	
	// Person Hints
	
	public function DisplayPersonHint()
	{
		temp = coreGame.PersonShown;
		if (temp == -3) return;
		
		switch(temp) {
			case -99: 
				ShowHint("<b>#assistant</b>\r" + coreGame.AssistantDescription);
				break;
				
			case -100: 
				SetHintText("<b>#slavemakername</b>\r");
				if (SMData.Gender == 1) AddHintText(Language.GetHtml("HintMaleSlavemaker", "Hints"));
				else if (SMData.Gender == 2) AddHintText(Language.GetHtml("HintFemaleSlavemaker", "Hints"));
				else AddHintText(Language.GetHtml("HintDickgirlSlavemaker", "Hints"));
				ShowHintAdd("\r" + coreGame.SlaveMakerSkillsGroup.TalentLabel.text);
				break;
				
			default:
				if ((temp >= 0 && temp < 10000) || temp == -50) {
					var sgirl:Slave = temp == -50 ? coreGame.slaveData : SMData.GetSlaveDetails(coreGame.PersonName, true);
					ShowHint("<b>" + sgirl.SlaveName + "</b>\r");
					if (sgirl.SlaveType == 0) AddHintText(sgirl.vitalsDescription);
				} else if (temp > 10000) ShowHint("<b>" + coreGame.People.GetPersonsName(temp - 10000) + "</b>\r");
				break;
		}
	}
}
