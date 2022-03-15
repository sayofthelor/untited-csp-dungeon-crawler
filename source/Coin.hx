package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Coin extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		trace("coin opened");
		super(x, y);
		loadGraphic(AssetPaths.coin__png, false, 8, 8);
		trace("this is not the issue");
	}

	override function kill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: done});
	}

	function done(_)
	{
		exists = false;
	}
}
