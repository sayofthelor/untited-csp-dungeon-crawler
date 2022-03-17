package;

import openfl.utils.Assets;

class PathsAndStuff
{
	public static inline function grabText(filename:String)
	{
		if (Assets.exists('assets/data/' + filename))
			return Assets.getText('assets/data/' + filename);
		else
		{
			trace('File not found: ' + filename);
			return null;
		}
	}

	public static inline function level(filename:String)
	{
		if (Assets.exists('assets/data/levels/' + filename + '.json'))
			return 'assets/data/levels/' + filename + '.json'
		else
		{
			trace('File not found: ' + filename);
			return null;
		}
	}

	public static inline function ogmo(filename:String)
	{
		if (Assets.exists('assets/data/levels/' + filename + '.ogmo'))
			return 'assets/data/levels/' + filename + '.ogmo'
		else
		{
			trace('File not found: ' + filename);
			return null;
		}
	}

	public static inline function exists(filename:String)
	{
		return Assets.exists('assets/' + filename);
	}
}
