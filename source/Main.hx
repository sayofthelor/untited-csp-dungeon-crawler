package;

import FPS;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	var fpsCounter:FPS;

	public function new()
	{
		super();
		FlxG.save.bind('sayofthelor', 'DC');
		fpsCounter = new FPS(3, 3, 0xFFFFFF);
		addChild(new FlxGame(0, 0, TitleScreenState, 1, 60, 60, false, false));
		#if !mobile
		addChild(fpsCounter);
		#end
	}
}
