// Sounds
// Linked to Sounds.swf
//
// Translation status: COMPLETE

import Scripts.Classes.*;


class SoundsModule extends BaseModule
{
	private var globalSound:Sound; 
	private var arPlayingSounds:Array;
	private var intervalSound:Number;

	
	public function SoundsModule(mc:MovieClip, cg:Object)
	{
		super(mc, null, cg);
		
		this.globalSound = new Sound(); 
		intervalSound = 0;
	}
	
	public function Reset()
	{
		StopSounds();
		clearInterval(intervalSound);
	}

	public function StopSounds()
	{
		this.globalSound.stop();
		
		mcBase.SoundWhispers.stop();
		this.StopMoaning();
		this.StopFucking();
		mcBase.SoundBells.stop();
		mcBase.SoundSpank.stop();
		mcBase.SoundBreathing.stop();
		mcBase.SoundFrying.stop();
		mcBase.SoundClipClop.stop();
		mcBase.SoundFootsteps.stop();
		mcBase.SoundWagon.stop();
	}
	
	public function StopAndFadeSounds()
	{
		StopSounds();
		FadeSounds(40);
	}
	
	public function StartMoaning(num:Number)
	{
		if (!coreGame.Options.bSoundsOn) return;
		if (isNaN(num)) num = 1;
		globalSound.setVolume(100);

		var startn:Number = int(Math.random()*7) + 1;
		do {
			switch(startn) {
				case 1:
					if (mcBase.SoundMoaning1._currentframe == 1) mcBase.SoundMoaning1.gotoAndPlay(2);
					else mcBase.SoundMoaning1.play();
					break;
				case 2: 
					if (mcBase.SoundMoaning2._currentframe == 1) mcBase.SoundMoaning2.gotoAndPlay(2);
					else mcBase.SoundMoaning2.play();
					break;
				case 3: 
					if (mcBase.SoundMoaning3._currentframe == 1) mcBase.SoundMoaning3.gotoAndPlay(2);
					else mcBase.SoundMoaning3.play();
					break;
				case 4:
					if (mcBase.SoundMoaning4._currentframe == 1) mcBase.SoundMoaning4.gotoAndPlay(2);
					else mcBase.SoundMoaning4.play();
					break;
				case 5:
					if (mcBase.SoundMoaning5._currentframe == 1) mcBase.SoundMoaning5.gotoAndPlay(2);
					else mcBase.SoundMoaning5.play();
					break;
				case 6:
					if (mcBase.SoundMoaning6._currentframe == 1) mcBase.SoundMoaning6.gotoAndPlay(2);
					else mcBase.SoundMoaning6.play();
					break;
				case 7:
					if (mcBase.SoundMoaning7._currentframe == 1) mcBase.SoundMoaning7.gotoAndPlay(2);
					else mcBase.SoundMoaning7.play();
					break;
			}
			startn = startn + 1;
			if (startn > 7) startn = 1;
			num = num - 1;
		} while (num > 0);
	}
	
	public function StopMoaning()
	{
		mcBase.SoundMoaning1.stop();
		mcBase.SoundMoaning2.stop();
		mcBase.SoundMoaning3.stop();
		mcBase.SoundMoaning4.stop();
		mcBase.SoundMoaning5.stop();
		mcBase.SoundMoaning6.stop();
		mcBase.SoundMoaning7.stop();
	}
	
	public function StartFucking(num:Number)
	{
		if (!coreGame.Options.bSoundsOn) return;
		if (isNaN(num)) num = 1;
		globalSound.setVolume(100);

		var startn:Number = int(Math.random()*7) + 1;
		do {
			switch(startn) {
				case 1: 
					if (mcBase.SoundFucking1._currentframe == 1) mcBase.SoundFucking1.gotoAndPlay(2);
					else mcBase.SoundFucking1.play();
					break;
				case 2:
					if (mcBase.SoundFucking2._currentframe == 1) mcBase.SoundFucking2.gotoAndPlay(2);
					else mcBase.SoundFucking2.play();
					break;
				case 3:
					if (mcBase.SoundFucking3._currentframe == 1) mcBase.SoundFucking3.gotoAndPlay(2);
					else mcBase.SoundFucking3.play();
					break;
				case 4:
					if (mcBase.SoundFucking4._currentframe == 1) mcBase.SoundFucking4.gotoAndPlay(2);
					else mcBase.SoundFucking4.play();
					break;
				case 5:
					if (mcBase.SoundFucking5._currentframe == 1) mcBase.SoundFucking5.gotoAndPlay(2);
					else mcBase.SoundFucking5.play();
					break;
				case 6:
					if (mcBase.SoundFucking6._currentframe == 1) mcBase.SoundFucking6.gotoAndPlay(2);
					else mcBase.SoundFucking6.play();
					break;
				case 7:
					if (mcBase.SoundFucking7._currentframe == 1) mcBase.SoundFucking7.gotoAndPlay(2);
					else mcBase.SoundFucking7.play();
					break;
	
			}
			startn = startn + 1;
			if (startn > 7) startn = 1;
			num = num - 1;
		} while (num > 0);
	}
	
	public function StopFucking()
	{
		mcBase.SoundFucking1.stop();
		mcBase.SoundFucking2.stop();
		mcBase.SoundFucking3.stop();
		mcBase.SoundFucking4.stop();
		mcBase.SoundFucking5.stop();
		mcBase.SoundFucking6.stop();
		mcBase.SoundFucking7.stop();
	}
	
	function StopAllSounds(fade:Boolean)
	{
		if (fade == true) {
			if (arPlayingSounds.length > 0) FadeSounds(40);
		}
		clearInterval(intervalSound);
		StopSounds();
		
		var i:Number = arPlayingSounds.length;
		if (i != undefined) {
			var snd:Sound;
			while (i > 0) {
				snd = Sound(arPlayingSounds.pop());
				snd.stop();
				delete snd;
				i--;
			}
		}
		delete arPlayingSounds;
		arPlayingSounds = new Array();
	
	}
	
	function FadeSnd(duration:Number, len:Number):Void {
		clearInterval(intervalSound);
		var i:Number = 0;
		var snd:Sound;
		if (len > 0) {
			var vol:Number;
			var bNon:Boolean = len == 0;
			while (i < len) {
				if (arPlayingSounds[i] != null) {
					snd = Sound(arPlayingSounds[i]);
					vol = snd.getVolume();
					vol -= 10;
					if (vol < 0) vol = 0;
					else bNon = true;
					snd.setVolume(vol);
				}
				i++;
			}	
			if (bNon) {
				intervalSound = setInterval(this, "FadeSnd", duration, duration, len);
				return;
			}
		}
		
		i = len;
		while (i > 0) {
			snd = Sound(arPlayingSounds.shift());
			snd.stop();
			delete snd;
			i--;
		}
		if (arPlayingSounds.length == 0) {
			delete arPlayingSounds;
			arPlayingSounds = new Array();
		}
	}
	
	function FadeSounds(duration:Number) {
		if (arPlayingSounds.length == 0) return;
		clearInterval(intervalSound);
		intervalSound = setInterval(this, "FadeSnd", duration, duration, arPlayingSounds.length);
	}

	
	function Beep()
	{
		if (!coreGame.Options.bSoundsOn) return;
		globalSound.setVolume(100);
		mcBase.SoundBeep.gotoAndPlay(2);
	}
	
	function Bloop()
	{
		if (!coreGame.Options.bSoundsOn) return;
		globalSound.setVolume(100);
		mcBase.SoundBloop.gotoAndPlay(2);
	}
	
	function AutoLoadSoundAndPlay(sound:String, repeats:Number, vol:Number, delay:Number, timer:Number)
	{
		if (timer != 0) Timers.RemoveTimer(timer);
		else if (!isNaN(delay) && delay != 0) {
			if (delay > 0) {
				Timers.AddTimer(
					setInterval(this, "AutoLoadSoundAndPlay", delay, sound, repeats, vol, 0, Timers.GetNextTimerIdx())
				);				
				return;
			}
		}
		
		if (isNaN(repeats)) repeats = 1;
		if (vol == undefined) vol = 100;
		var snd:Sound = new Sound();
		snd.onLoad = function() { this.start(0, repeats); }
		snd.loadSound(sound, false);
		snd.setVolume(vol);
		arPlayingSounds.push(snd);
	}
	
	function PlaySound(snd:String, repeats:Number, cnt:Number, vol:Number, delay:Number, timer:Number)
	{
		if (!coreGame.Options.bSoundsOn) return;
		
		if (timer != 0) Timers.RemoveTimer(timer);
		else if (!isNaN(delay) && delay != 0) {
			Timers.AddTimer(
				setInterval(this, "PlaySound", delay, snd, repeats, cnt, vol, 0, Timers.GetNextTimerIdx())
			);	
			return;
		}
		
		var ext:String = snd.substr(-4, 4);
		if (ext == ".mp3") return AutoLoadSoundAndPlay(snd, repeats, vol);
	
		if (vol == undefined) vol = 100;
		globalSound.setVolume(vol);
		
		if (snd.toLowerCase() == "moaning") StartMoaning(cnt);
		else if (snd.toLowerCase() == "fucking") StartFucking(cnt);
		else if (snd.toLowerCase() == "beep") mcBase.SoundBeep.gotoAndPlay(2);
		else if (snd.toLowerCase() == "bloop") mcBase.SoundBloop.gotoAndPlay(2);
		else mcBase["Sound" + snd].gotoAndPlay(2);
	}

	
	public function InitialiseModule()
	{
		this.globalSound.setVolume(100);
		
		this.StopSounds();
	}
}
