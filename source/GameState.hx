// GameState.hx
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/*
	State I can build stuff on top of.
	Mainly for a universally accessible transition function as of now, but I may add some things later.
 */
class GameState extends FlxState
{
	var transitionSprite:FlxSprite;

	override function create()
	{
		super.create();
		#if debug
		var ret:FlxButton = new FlxButton(323, 183, "Back to Menu", function() transIn(FlxColor.RED, new TitleScreenState(true)));
		add(ret);
		#end
	}

	override function update(elapsed)
	{
		super.update(elapsed);
	}

	// thanks vidyagirl for the inline stuff

	public inline function transIn(color:FlxColor, desiredState:FlxState)
	{
		transitionSprite = new FlxSprite(-FlxG.width, 0).makeGraphic(FlxG.width, FlxG.height, color, false);
		add(transitionSprite);
		FlxTween.tween(transitionSprite, {x: 0}, 0.5, {
			ease: FlxEase.quintInOut,
			onComplete: function(twn:FlxTween)
			{
				FlxG.switchState(desiredState);
			}
		});
	}

	public inline function transOut(color:FlxColor)
	{
		transitionSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, color, false);
		add(transitionSprite);
		FlxTween.tween(transitionSprite, {x: FlxG.width}, 0.5, {
			ease: FlxEase.quintInOut,
			onComplete: function(twn:FlxTween)
			{
				remove(transitionSprite);
			}
		});
	}

	inline public static function funkinBoundTo(value:Float, min:Float, max:Float):Float // unbinds zoom lerp from framerate, thanks shadow mario
	{
		return Math.max(min, Math.min(max, value));
	}
}
