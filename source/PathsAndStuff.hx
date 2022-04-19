package;

import openfl.Assets;

/* 	
	Helper class to kinda get all of the paths stuff working.
	Also adds checking for mod files so I don't have to do a bunch of complicated things in each class.
	Feel free to steal.
 */
class PathsAndStuff
{
	public static inline function grabText(filename:String)
	{
		if (Assets.exists('mods/data/' + filename))
			return Assets.getText('mods/data/' + filename);
		else if (Assets.exists('assets/data/' + filename))
			return Assets.getText('assets/data/' + filename);
		else
		{
			trace('File not found: ' + filename);
			return null;
		}
	}

	public static inline function level(filename:String)
	{
		if (Assets.exists('mods/data/levels/' + filename + '.json'))
			return 'mods/data/levels/' + filename + '.json'
		else if (Assets.exists('assets/data/levels/' + filename + '.json'))
			return 'assets/data/levels/' + filename + '.json'
		else
		{
			trace('File not found: ' + filename);
			return null;
		}
	}

	public static inline function ogmo(filename:String)
	{
		if (Assets.exists('mods/data/levels/' + filename + '.ogmo'))
			return 'mods/data/levels/' + filename + '.ogmo';
		else if (Assets.exists('assets/data/levels/' + filename + '.ogmo'))
			return 'assets/data/levels/' + filename + '.ogmo';
		else
		{
			trace('File not found: ' + filename);
			return null;
		}
	}

	public static inline function exists(filename:String)
	{
		if (Assets.exists("mods/" + filename))
			return Assets.exists('mods/' + filename);
		else
			return Assets.exists('assets/' + filename);
	}
}
