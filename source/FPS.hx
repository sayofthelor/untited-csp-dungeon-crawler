package;

// mostly just openfl.display.FPS, but with some nice extras
// also removing all of the flash stuff because who the hell uses flash anyway?

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Lib;

// Credits to OpenFL repository for the original code
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end

class FPS extends TextField
{
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 3, y:Float = 3, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;
		width = Lib.application.window.width;
		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("VCR OSD Mono", 16, color);
		text = "0 FPS";

		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	// Event Handlers
	@:noCompletion
	private override function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount )
		{
			text = #if debug "DEV BUILD\n" + #end currentFPS + " FPS";
		}

		cacheCount = currentCount;
	}
}