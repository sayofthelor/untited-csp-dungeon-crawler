// FPS.hx
package;

/*
	Mostly just openfl.display.FPS, but with some nice extras.
	I also removed all of the flash stuff because who the hell uses flash anyway?
 */
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;

// Credits to OpenFL repository for the original code
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
		width = Lib.application.window.width;
		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("VCR OSD Mono", 16, color);
		text = #if debug "DEV BUILD\n" + #end
		"0 FPS";
		height = #if debug 35 #else 19 #end;
		this.y = Lib.application.window.height - height - 3;

		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	private override function __enterFrame(deltaTime:Float):Void
	{
		this.y = Lib.application.window.height - height - 3;
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount)
		{
			text = #if debug "DEV BUILD\n" + #end
			currentFPS + " FPS";
		}

		cacheCount = currentCount;
	}
}
