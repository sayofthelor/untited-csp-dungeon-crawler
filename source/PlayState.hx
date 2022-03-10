package;

import GameState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class PlayState extends GameState
{
	override public function create()
	{
		var text = new FlxText(10, 10, 0, "dungeon crawler goes here\nat some point", 32, true);
		text.alignment = CENTER;
		text.screenCenter();
		add(text);
		transOut(FlxColor.RED);
		trace("L");
		FlxTween.tween(text, {y: 200}, 1, {type: FlxTweenType.PINGPONG, ease: FlxEase.quadInOut});
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
