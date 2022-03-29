package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PauseSubState extends FlxSubState
{
	override function create()
	{
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		var resumeButton:FlxButton = new FlxButton(323, 183, "Resume", function() close());
		var retryButton:FlxButton = new FlxButton(323, 206, "Retry", function() transIn(FlxColor.RED, new PlayState()));
		var exitButton:FlxButton = new FlxButton(323, 229, "Exit", function() transIn(FlxColor.RED, new TitleScreenState(true)));
		bg.alpha = resumeButton.alpha = retryButton.alpha = exitButton.alpha = 0;
		add(bg);
		add(resumeButton);
		add(retryButton);
		add(exitButton);
		FlxTween.tween(bg, {alpha: 0.6}, .5, {ease: FlxEase.quintOut});
		FlxTween.tween(resumeButton, {alpha: 1}, .5, {ease: FlxEase.quintOut});
		FlxTween.tween(retryButton, {alpha: 1}, .5, {ease: FlxEase.quintOut});
		FlxTween.tween(exitButton, {alpha: 1}, .5, {ease: FlxEase.quintOut});
		super.create();
	}

	public inline function transIn(color:FlxColor, desiredState:FlxState)
	{
		var transitionSprite = new FlxSprite(-FlxG.width, 0).makeGraphic(FlxG.width, FlxG.height, color, false);
		add(transitionSprite);
		FlxTween.tween(transitionSprite, {x: 0}, 0.5, {
			ease: FlxEase.quintInOut,
			onComplete: function(twn:FlxTween)
			{
				FlxG.switchState(desiredState);
			}
		});
	}
}
