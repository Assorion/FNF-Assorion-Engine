package misc;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;

using StringTools;

#if !debug @:noDebug #end
class Alphabet extends FlxSpriteGroup
{
	public var text(default, set):String = "";

	public var fWidth:Float = 0;
	public var isBold:Bool = false;

	public function new(x:Float, y:Float, text:String = "", ?bold:Bool = false)
	{
		super(x, y);

		isBold = bold;
		this.text = text.toLowerCase();
	}

	public function addText()
	for (character in text.split(''))
	{
		if(' -_'.contains(character)) {
			fWidth += 40;
			continue;
		}

		if (!AlphaCharacter.completeList.contains(character)) 
			continue;

		// # add text

		var letter:AlphaCharacter = new AlphaCharacter(fWidth, 0, character);

		isBold ? letter.createBold() : letter.createLetter();
		add(letter);

		fWidth += letter.width;
	}

	private function set_text(value:String){
		text = value.toLowerCase();
		clear();
		fWidth = 0;

		if(value != '')
			addText();

		return value;
	}
}

class AlphaCharacter extends FlxSprite
{
	public static inline var numbers:String = "1234567890";
	public static inline var symbols:String = "|~#$%()*+-:;<=>@[]^_.,'!?";
	public static inline var completeList:String = "abcdefghijklmnopqrstuvwxyz1234567890|~#$%()*+-:;<=>@[]^.,'!?";
	public var letter:String;

	public function new(x:Float, y:Float, char:String)
	{
		super(x, y);
		var tex = Paths.lSparrow('ui/alphabet');
		frames = tex;
		letter = char;

		antialiasing = Settings.pr.antialiasing;
	}

	public function createBold()
	{
		animation.addByPrefix(letter, letter.toUpperCase() + " bold", 24);
		animation.play(letter);
		updateHitbox();
	}

	public function createLetter():Void
	{
		var suffix = ' capital';

		if(numbers.contains(letter)) suffix = '';
		if(symbols.contains(letter)) {
			replaceWithSymbol();
			return;
		}

		animation.addByPrefix(letter, '$letter$suffix', 24);
		animation.play(letter);
		updateHitbox();

		y = (110 - height);
	}

	var replacementArray:Array<Dynamic> = [
		'.', "'", '?', '!',
		'period', 'apostraphie', 'question mark', 'exclamation point',
		50, -5, 0, 0
	];

	// # handle symbols.

	public function replaceWithSymbol()
	{
		var magicNumb:Int = Math.floor(replacementArray.length / 3);
		for(i in 0...magicNumb)
			if(letter == replacementArray[i]){
				letter = replacementArray[i + magicNumb];
				y += replacementArray[i + (magicNumb * 2)];
				break;
			}

		animation.play(letter);
		updateHitbox();
	}
}
