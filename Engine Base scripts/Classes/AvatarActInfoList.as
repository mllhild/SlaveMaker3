// Manager for a particular slave maker avatar
// Translation status: COMPLETE

import Scripts.Classes.*;

class AvatarActInfoList extends ActInfoList {
	
	// Variables
	public var frame:Number;
	public var actarr:Array;
	public var xSMAvatarXML:XML;
	
	// constructor
	public function AvatarActInfoList(fldr:String, cgm:Object) { super(null, fldr, cgm); }
						
	// Show the image for an Avatar
	public function GetActImageAvatar(iact:Number, iframe:Number) : String
	{
		actarr = null;
		frame = iframe;
		var oact:Number = Math.abs(iact);
		var act:Number = int(oact);
		if (act == 23) {
			if (coreGame.PersonGender == 1) act = 23.1;
			else act = 23.2;
		}
		if (act == 1009 && oact != 1009) act = 1009.1;
		if (act == 1015 && oact != 1015) act = 1015.1;
		var actobj:ActInfo = GetActRO(act);
		if (actobj == null) return "";
		
		var iname:String = GetBaseImageName(act, actobj);
		if (iname == "") return "";
				
		var actImageNode:XMLNode;
		
		if (frame != undefined && frame != 0) {
			
			// a selected image (Normal only supported)
			iname += " " + frame;
			actarr = actobj.Normal.NormalArray;
			actImageNode = actobj.Normal.NormalNode;
			
		} else {
			frame = 0;
					
			if (slaveData.PregnancyGestation > 0) {
				//SMTRACE("preg");
				if (actobj.Pregnant.GetImage(act, 5)) {
					frame = actobj.Pregnant.imgIndex;
					if (frame > 0) {
						actarr = actobj.Pregnant.actarr;
						actImageNode = actobj.Pregnant.actNode;
						if (alternateNames) iname += " " +  actobj.Pregnant.imgName + "Pregnant " + frame;
						else iname += " (" +  actobj.Pregnant.imgName + "Pregnant " + frame + ")";
					}
				}
			}
			if (slaveData.IsDickgirl() && frame == 0) {
				//SMTRACE("dg");
				if (actobj.Dickgirl.GetImage(act, 1)) {
					frame = actobj.Dickgirl.imgIndex;
					if (frame > 0) {
						actarr = actobj.Dickgirl.actarr;
						actImageNode = actobj.Dickgirl.actNode;
						if (alternateNames) iname += " " +  actobj.Dickgirl.imgName + "Dickgirl " + frame;
						else iname += " (As " +  actobj.Dickgirl.imgName + "Dickgirl " + frame + ")";
					}
				}
			}


			if (slaveData.DressWorn < 0 && frame == 0) {
				if (actobj.Naked.GetImage(act, 3)) {
					frame = actobj.Naked.imgIndex;
					if (frame > 0) {
						actImageNode = actobj.Naked.actNode;
						actarr = actobj.Naked.actarr;
						if (alternateNames) iname += " " +  actobj.Naked.imgName + "Naked " + frame;
						else iname += " (" +  actobj.Naked.imgName + "Naked " + frame + ")";
					}
				}
			}
			if (frame <= 0) {
				var totnm:Number = actobj.Normal.GetTotalImages();
				var totnk:Number = actobj.Naked.GetTotalImages();
				var tot:Number = totnm;
				if (totnm == 0) tot = totnk;
				else if (act < 1000) tot += totnk;
				if (tot > 0) {
					var idx:Number = int(Math.random()*tot) + 1;
					if (idx <= totnm || frame < 0) {
						if (frame < 0) {
							frame = int(Math.random()*(frame * -1)) + 1;
							actarr = actobj.Normal.NormalArray;
							actImageNode = actobj.Normal.actNode;
							iname += " " + frame;
						} else if (actobj.Normal.GetImage(act)) {
							frame = actobj.Normal.imgIndex;
							actarr = actobj.Normal.actarr;
							actImageNode = actobj.Normal.actNode;
							iname += " " + frame;
						}
					} else if (idx <= (totnm + totnk)) {
						if (actobj.Naked.GetImage(act)) {
							frame = actobj.Naked.imgIndex;
							actarr = actobj.Naked.actarr;
							actImageNode = actobj.Naked.actNode;
							if (alternateNames) iname += " " +  actobj.Naked.imgName + "Naked " + frame;
							else iname += " (" +  actobj.Naked.imgName + "Naked " + frame + ")";
						}
					}
				}
			}
		}
		
		// is it a valid image?
		if (iname == "" || frame == 0) return "";   // no, use a generic image
		
		// have a valid image, show it
		if (ActFolder != "") iname = ActFolder + "/" + iname;
		
		var fNode:XMLNode = coreGame.XMLData.GetNode(actImageNode.firstChild, "Image" + frame);
		if (fNode == null) fNode = actImageNode;
		if (fNode != null) {
			var bgframe:Number = undefined;
			for (var attr:String in fNode.attributes) {
				var strl:String = attr.toLowerCase();
				if (strl == "bgframe") bgframe = Number(fNode.attributes[attr]);
				else if (strl == "bg") coreGame.Backgrounds.ShowBackground(fNode.attributes[attr], bgframe);
				else if (strl == "colour" || strl == "color") coreGame.Backgrounds.ShowOverlay(Number(fNode.attributes[attr]));
			}
		}
		
		var bSpec:Boolean = iname.indexOf("Dress ") != -1 || iname.indexOf("Sex Act - Naked ") != -1;
		return bSpec ? iname + ".png" : iname + ".jpg";
	}
	
	public function LoadAvatarXML()
	{
		delete xSMAvatarXML;
		xSMAvatarXML = new XML();
		var rootn:XMLNode = new XMLNode(1, "Avatar");
		xSMAvatarXML.appendChild(rootn);
		coreGame.XMLData.LoadXML(ActFolder + "/avatar.xml", this, "AvatarXMLLoaded", xSMAvatarXML, true);
	}
	
	private function AvatarXMLLoaded()
	{
		LoadActImages(xSMAvatarXML.firstChild.firstChild);
		SetActDefaultCount(20100);
		SetActDefaultCount(20000);
		SetActDefaultCount(20001);
		SetActDefaultCount(20002);
		SetActDefaultCount(20003);
		SetActDefaultCount(20004);
		if (!(coreGame.SlaveMakerCreate1._visible || coreGame.SlaveMakerCreate2._visible || coreGame.SlaveMakerCreate3._visible)) return;
		var str:String = coreGame.XMLData.GetXMLString("Name", xSMAvatarXML.firstChild.firstChild);
		if (str != "") {
			coreGame.SlaveMakerCreate1.SlaveMakerName.text = str;
			coreGame.SlaveMakerCreate2.SlaveMakerName.text = str;
			coreGame.SlaveMakerCreate3.SlaveMakerName.text = str;
		}
	}
	
}