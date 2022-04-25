// LoadingState.hx
package;

import GameState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/*
	Loading screen
	Loads the level and shows a nice little screen when that happens.
	For any would-be source modders, you should be able to skip this state after one time, provided you're not loading another level.
 */
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

	public static var level:FlxOgmo3Loader;

	override public function create()
	{
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, col));
		loadingText = new FlxText(0, 0, 0, "Loading...", 64);
		loadingText.screenCenter();
		yStore = loadingText.y;
		loadingText.y = FlxG.height + 100;
		add(loadingText);
		FlxTween.tween(loadingText, {y: yStore}, 1, {
			ease: FlxEase.quintOut,
			onComplete: function(_)
			{
				var frzText = new FlxText(0, loadingText.y + loadingText.height + 10, 0, "(game may look frozen, but it's not!)", 25);
				frzText.screenCenter(X);
				add(frzText);
				level = new FlxOgmo3Loader(PathsAndStuff.ogmo(TitleScreenState.ogmoName), PathsAndStuff.level(TitleScreenState.levName));
				new FlxTimer().start(0.5, function(_) FlxG.switchState(desiredState));
			}
		});
		super.create();
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
	}
}
