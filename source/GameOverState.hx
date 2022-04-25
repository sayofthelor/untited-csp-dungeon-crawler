// GameOverState.hx
package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/*
	Called when your health reaches 0, or the outcome != VICTORY
 */
class GameOverState extends GameState
{
	public override function create()
	{
		FlxG.camera.zoom = 1;
		var gameOverText:FlxText = new FlxText(0, -300, 0, "GAME OVER", 128);
		gameOverText.setBorderStyle(OUTLINE, 0x333333, 2, 1);
		gameOverText.screenCenter(X);
		add(gameOverText);
		var retryButton:FlxButton = new FlxButton(0, 500, "Retry", retry);
		retryButton.screenCenter(X);
		retryButton.x -= 100;
		add(retryButton);
		var exitButton:FlxButton = new FlxButton(0, 500, "Exit", exit);
		exitButton.screenCenter(X);
		exitButton.x += 100;
		add(exitButton);
		new FlxTimer().start(0.5, function(_)
		{
			FlxTween.tween(gameOverText, {y: 150}, 2, {ease: FlxEase.quadOut});
		});
		super.create();
		transOut(FlxColor.RED);
	}

	function retry()
	{
		transIn(FlxColor.RED, new PlayState());
	}

	function exit()
	{
		transIn(FlxColor.RED, new TitleScreenState(true));
	}
}
