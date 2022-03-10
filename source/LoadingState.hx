package;

import GameState;
import flixel.FlxG;

using StringTools;

class LoadingState extends GameState
{
	var fileToLoad:String;

	override function new(fileToLoad:String)
	{
		this.fileToLoad = fileToLoad;
		super();
	}

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
	}
}
