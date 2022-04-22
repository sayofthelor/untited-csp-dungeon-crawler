package;

import FPS;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.math.FlxRandom;
import openfl.display.Sprite;
import openfl.utils.Assets;
#if desktop
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import lime.app.Application;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;
import polymod.Polymod;
import sys.FileSystem;
import sys.io.File;
#end

/*
	HaxeFlixel loader class thingy idk?
	There's a crash handler in here, which is adapted from Forever Engine, kudos to Yoshubs!
	It doesn't work all the time for some reason but it should give you a nice little error box when it does.
	Polymod mods are also loaded here.
 */
class Main extends Sprite
{
	var fpsCounter:FPS;

	public function new()
	{
		super();
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#if cpp
		trace("Loading mods...");
		Polymod.init({
			modRoot: "./",
			dirs: ['mods']
		});
		trace("\nMods loaded.\nThese should auto-refresh if you want to open a custom level,\nbut if they don't, just restart the game.");
		#end
		FlxG.save.bind('sayofthelor', 'DC');
		fpsCounter = new FPS(3, 3, 0xFFFFFF);
		var game:FlxGame = new FlxGame(0, 0, TitleScreenState, 1, 120, 120, false, false);
		addChild(game);
		addChild(fpsCounter);
	}

	static var errorCrashFunnies:Array<String> = [
		"Oops.",
		"Not a fun day, I take it?",
		"Sorry to bring your dungeon crawling to a halt.",
		"Have you tried Lore Engine?",
		"Haxescript is quite a pain, yes?",
		"Also try Minecraft!",
		"Main.hx isn't supposed to hold this much.",
		"Flixel is wonderful.",
		"SSS lesson for today is real fun.",
		"No controlly is cannoli.",
		"Not feeling it today, here's your error.",
		"Stream Kawai Sprite.",
		"Did you remember to put @interpret?",
		"Class is screwed. Or maybe not, I don't know.",
		"How many headaches have you been through today?",
		"Interpreted code tip of the day: Make sure to import your classes."
	];

	public static function onCrash(e:UncaughtErrorEvent):Void
	{
		trace("ERROR");
		var errorMessage:String = '';
		var path:String = '';
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var date:String = Date.now().toString();

		date = StringTools.replace(date, " ", "_");
		date = StringTools.replace(date, ":", "'");

		path = './crash/UDC_Crash_' + date + ".log";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errorMessage += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errorMessage += "\nWe've got an error!\n\n"
			+ errorCrashFunnies[new FlxRandom().int(0, errorCrashFunnies.length - 1)]
			+ "\n\nHere's what's up: "
			+ e.error
			+ "\nPlease report this bug at http://github.com/sayofthelor/untitled-csp-dungeon-crawler.";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errorMessage + "\n");

		trace(errorMessage);
		trace("Crash dump saved to ./crash/");

		Application.current.window.alert(errorMessage, "Fatal error");
		Sys.exit(1);
	}
}
