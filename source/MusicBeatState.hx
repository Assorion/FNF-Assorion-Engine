package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import openfl.events.KeyboardEvent;

import ui.NewTransition;

typedef DelayedEvent = {
	var endTime:Float;
	var exeFunc:Void->Void;
}

#if !debug @:noDebug #end
class MusicBeatState extends FlxUIState
{
	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var events:Array<DelayedEvent> = [];

	public static inline function curTime()
		#if desktop
		return Sys.time();
		#else
		return Date.now().getTime() * 0.001;
		#end

	public static inline function correctMusic()
	if(FlxG.sound.music == null || !FlxG.sound.music.playing) {
		Conductor.changeBPM(Paths.menuTempo);
		FlxG.sound.playMusic(Paths.lMusic(Paths.menuMusic));
	}

	override function create()
	{
		// Don't worry the skipping is handled in the transition itself.
		openSubState(new NewTransition(null, false));

		persistentUpdate = true;
		FlxG.camera.bgColor.alpha = 0;
		Conductor.songPosition = -Settings.pr.audio_offset;

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHit);
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP  , keyRel);

		super.create();
	}

	// # new input thing.

	public var key = 0;
	public function keyHit(ev:KeyboardEvent)
		key = ev.keyCode;
	public function keyRel(ev:KeyboardEvent)
		key = ev.keyCode;

	override function destroy(){
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHit);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP  , keyRel);

		super.destroy();
	}

	// # handle a delayed event system.

	private inline function postEvent(forward:Float, func:Void->Void){
		events.push({
			endTime: curTime() + forward,
			exeFunc: func
		});
	}

	//////////////////////////////////////

	private var oldStep:Int = 0;
	override function update(elapsed:Float)
	{
		Conductor.songPosition = FlxG.sound.music.time - Settings.pr.audio_offset;

		curStep = Math.floor(Conductor.songPosition * Conductor.songDiv);
		
		if(oldStep != curStep && curStep >= -1){
			oldStep = curStep;
			stepHit();
		}

		super.update(elapsed);

		var cTime = curTime();
		var i = -1;
		while(++i < events.length){
			var e = events[i];

			if(cTime < e.endTime) continue;

			e.exeFunc();
			events.splice(i--, 1);
		}
	}

	// GREAT! Now this has no chance of working with odd time signatures...
	public function stepHit():Void
	{
		var tBeat:Int = curStep >> 2;

		if (curStep - (tBeat << 2) == 0){
			curBeat = tBeat;
			beatHit();
		}
	}
	public function beatHit():Void {}

	private inline function skipTrans(){
		for(i in 0...events.length)
			events[i].exeFunc();

		NewTransition.skip();
	}

	// # Meant to handle transitions.
	// TODO: Re-write stuff so it doesn't rely on a depricated function (lol)

	public static var changeState:FlxState->Void = NewTransition.switchState;
}
