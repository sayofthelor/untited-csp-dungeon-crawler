package;

import GameState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using StringTools;

class TitleScreenState extends GameState
{
	override public function create()
	{
		var text = new FlxText(10, 200, 0, "SUPER COOL DUNGEON CRAWLER\nWOW SO COOL\nHOLY CRAP\nWOW", 32, true);
		text.alignment = CENTER;
		text.screenCenter(X);
		add(text);
		var playButton:FlxButton = new FlxButton(10, 600, "Play", playGame);
		playButton.screenCenter(X);
		add(playButton);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function playGame()
	{
		transIn(FlxColor.RED, new PlayState());
	}
}
