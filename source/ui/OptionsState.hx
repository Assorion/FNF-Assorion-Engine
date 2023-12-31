package ui;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import misc.Alphabet;
import gameplay.HealthIcon;
import flixel.text.FlxText;
import flixel.FlxObject;

/**
	Looks messy so lemme give you a quick write-up on how this works.

	You have option sub categories. They are visual and do not effect how the options are applied.
	If you press escape when optionSub is not 0 then you exit back to option sub 0.

	If you want to add an option, please add it first to "assets/songs-data/default_settings.json" -
	and then add it to Settings.hx -> Options (typedef).
	Next add it to optionSub, either add it to the end of one of the arrays, or create your own sub-category.

	Add a description and scroll down, if it's a togglable option (boolean) then do this under the "keyHit" function.
	If your option is an integer, then do this under "altChange" function, and take a look at the surrounding code to get an idea.

	After that you should be good to go!
**/

#if !debug @:noDebug #end
class OptionsState extends MenuTemplate
{
	static var optionSub:Array<Array<String>> = [
		['basic', 'gameplay', 'visuals', 'controls', 'changelog'],
		['start_fullscreen', 'start_volume', 'skip_logo', 'default_persist', #if desktop 'launch_sprites' #end ],
		['audio_offset', 'input_offset', 'downscroll', 'ghost_tapping', 'botplay', 'miss_health'],
		['antialiasing', #if desktop 'framerate', #end 'show_hud', 'useful_info', 'strum_glow']
	];

	static var descriptions:Array<Array<String>> = [
		[
			'Basic options for the game Window', 
			'Options for the gameplay itself', 
			'Options for visuals and effects', 
			'Change the key bindings',
			'View the history of Assorion Engine'
		],
		[
			'Start the game in fullscreen mode',
			'Change the games starting volume',
			'Skip the haxeflixel intro logo',
			'All Graphics & text files stay in ram. Will use way more ram but reload times decrease. DISABLE WHEN MODDING!',
			#if desktop
			'Load assets at startup. Uses even more RAM and increases startup time. Doesn\'t work in web browser'
			#end
		],
		[
			'Change your audio offset in MS. Press accept to enter the offset wizard',
			'Change your keyboard offset in MS. This only changes ratings, not the actual timing window',
			'Change the scroll direction',
			'Allows pressing notes if there is no notes to hit',
			'Let the game handle your notes for you (does not count scores or health)',
			'Changes the amount of health you lose from missing'
		],
		[
			'Makes the sprites look smoother. The game will look jagged without this option.',
			#if desktop
			'Changes how fast the game CAN run. I recommend setting it to 300, not the max',
			#end
			'Shows your health, stats, and other stuff in gameplay',
			'Shows FPS and memory counter',
			'Enemy notes glow like the players'
		]
	];

	public var curSub:Int = 0;
	public var descText:FlxText;
	var bottomBlack:StaticSprite;

	override function create()
	{
		config(0xFFea71fd, 1);
		MusicBeatState.correctMusic();
		super.create();

		bottomBlack = new StaticSprite(0, FlxG.height - 30).makeGraphic(1280, 30, FlxColor.BLACK);
		bottomBlack.alpha = 0.6;

		descText = new FlxText(5, FlxG.height - 25, 0, "", 20);
		descText.setFormat('assets/fonts/vcr.ttf', 20, FlxColor.WHITE, LEFT);
		
		sAdd(bottomBlack);
		sAdd(descText);

		createNewList();
	}
	
	public function createNewList(?appendOption:Bool = false){
		clearEverything();

		splitNumb = appendOption ? 2 : 1;

		for(i in 0...optionSub[curSub].length){
			pushObject(new Alphabet(0, (60 * i), optionSub[curSub][i], true));
			if(!appendOption){
				var ican:HealthIcon = new HealthIcon('settings' + (Math.floor(i / 2) + 1), false);

				if(ican.curChar == 'face')
					continue;
				if(i & 0x01 == 1) 
					ican.animation.play('losing');

				pushIcon(ican);
				continue;
			}

			// reflection. it's slow and not good. But I need it to get a variable from a string name.
			var optionStr:String = '';
			var val:Dynamic = Reflect.field(Settings.pr, optionSub[curSub][i]);

			optionStr = Std.string(val);
			if(Std.is(val, Bool))
				optionStr = val ? 'yes' : 'no';

			pushObject(new Alphabet(0, (60 * i), optionStr, true));
		}
		changeSelection();
	}

	override public function exitFunc(){
		if(curSub > 0){
			curSub = 0;
			curSel = 0;
			createNewList(false);

			return;
		}

		Settings.flush();
		super.exitFunc();
	}

	override function changeSelection(change:Int = 0){
		super.changeSelection(change);
		descText.text = descriptions[curSub][curSel];
	}

	// this is where you add your integer or slidable(?) options
	override function altChange(ch:Int = 0){
		var atg:Alphabet = cast arrGroup[(curSel * 2) + 1].obj;
		switch(optionSub[curSub][curSel]){
			case 'start_volume':
				Settings.pr.start_volume = CoolUtil.intBoundTo(Settings.pr.start_volume + (ch * 10), 0, 100);
				atg.text = Std.string(Settings.pr.start_volume);

			// gameplay.
			case 'audio_offset':
				Settings.pr.audio_offset = CoolUtil.intBoundTo(Settings.pr.audio_offset + ch, 0, 300);
				atg.text = Std.string(Settings.pr.audio_offset);
			case 'input_offset':
				Settings.pr.input_offset = CoolUtil.intBoundTo(Settings.pr.input_offset + ch, 0, 300);
				atg.text = Std.string(Settings.pr.input_offset);
			case 'miss_health':
				Settings.pr.miss_health = CoolUtil.intBoundTo(Settings.pr.miss_health + ch, 10, 50);
				atg.text = Std.string(Settings.pr.miss_health);

			// visuals
			case 'framerate':
				Settings.pr.framerate = CoolUtil.intBoundTo(Settings.pr.framerate + (ch * 10), 10, 500);
				atg.text = Std.string(Settings.pr.framerate);
				Settings.apply();
		}
		changeSelection(0);
	}

	// this is where you add your boolean or toggleable options
	override public function keyHit(ev:KeyboardEvent){
		super.keyHit(ev);

		if(!key.hardCheck(Binds.UI_ACCEPT)) return;

		switch(optionSub[curSub][curSel]){
			case 'basic':
				curSel = 0;
				curSub = 1;
			case 'gameplay':
				curSel = 0;
				curSub = 2;
			case 'visuals':
				curSel = 0;
				curSub = 3;
			case 'controls':
				if(skipCheck()) return;
				MusicBeatState.changeState(new ControlsState());
				return;
			case 'changelog':
				if(skipCheck()) return;
				MusicBeatState.changeState(new HistoryState());
				return;

			// basic
			case 'start_fullscreen':
				Settings.pr.start_fullscreen = !Settings.pr.start_fullscreen;
			case 'skip_logo':
				Settings.pr.skip_logo = !Settings.pr.skip_logo;
			case 'default_persist':
				Settings.pr.default_persist = !Settings.pr.default_persist;
				if(Settings.pr.default_persist) 
					gameplay.PauseSubState.newCanvas(true);

				Settings.apply();
			case 'launch_sprites':
				Settings.pr.launch_sprites = !Settings.pr.launch_sprites;

			// gameplay
			case 'audio_offset':
				if(skipCheck()) return;
				MusicBeatState.changeState(new OffsetWizard());
				return;
			case 'downscroll':
				Settings.pr.downscroll = !Settings.pr.downscroll;
			case 'botplay':
				Settings.pr.botplay = !Settings.pr.botplay;
			case 'ghost_tapping':
				Settings.pr.ghost_tapping = !Settings.pr.ghost_tapping;

			// visuals
			case 'useful_info':
				Settings.pr.useful_info = !Settings.pr.useful_info;
				Settings.apply();
			case 'antialiasing':
				Settings.pr.antialiasing = !Settings.pr.antialiasing;
			case 'show_hud':
				Settings.pr.show_hud = !Settings.pr.show_hud;
			case 'strum_glow':
				Settings.pr.strum_glow = !Settings.pr.strum_glow;
			
		}
		createNewList(true);
	}
}
