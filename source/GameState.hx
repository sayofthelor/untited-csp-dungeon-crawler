package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class GameState extends FlxState
{
	var transitionSprite:FlxSprite;

	override function create()
	{
		super.create();
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
}
