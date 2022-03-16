package;

import GameState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class LoadingState extends GameState
{
	var desiredState:FlxState;
	var yStore:Float;
	var loadingText:FlxText;
	var col:FlxColor;

	public override function new(col:FlxColor, desiredState:FlxState)
	{
		this.desiredState = desiredState;
		this.col = col;
		super();
	}

	override public function create()
	{
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, col));
		loadingText = new FlxText(0, 0, 0, "Loading...", 64);
		loadingText.screenCenter();
		yStore = loadingText.y;
		loadingText.y = FlxG.height + 100;
		add(loadingText);
		FlxTween.tween(loadingText, {y: yStore}, 2, {
			ease: FlxEase.quintOut,
			onComplete: function(twn:FlxTween)
			{
				FlxG.switchState(desiredState);
			}
		});
		super.create();
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
	}
}
