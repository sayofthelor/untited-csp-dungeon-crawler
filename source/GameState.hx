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
	var desiredState:FlxState;

	override function create()
	{
		super.create();
	}

	override function update(elapsed)
	{
		super.update(elapsed);
	}

	public inline function transIn(color:FlxColor, desiredState:FlxState)
	{
		this.desiredState = desiredState;
		transitionSprite = new FlxSprite(-FlxG.width, 0).makeGraphic(FlxG.width, FlxG.height, color, false);
		add(transitionSprite);
		FlxTween.tween(transitionSprite, {x: 0}, 0.5, {ease: FlxEase.quintInOut, onComplete: switchThing});
	}

	public inline function transOut(color:FlxColor)
	{
		transitionSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, color, false);
		add(transitionSprite);
		FlxTween.tween(transitionSprite, {x: FlxG.width}, 0.5, {ease: FlxEase.quintInOut});
	}

	function inline switchThing(tween:FlxTween)
	{
		remove(transitionSprite);
		FlxG.switchState(desiredState);
	}
}
