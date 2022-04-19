package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/*
	Heads-up display
	Built off of the HUD class from the HaxeFlixel tutorial, but with more QOL stuff on top.
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	var hudBeeg:FlxSprite;
	var healthCounter:FlxText;
	var healthIcon:FlxSprite;
	var coinCounter:FlxText;
	var coinIcon:FlxSprite;

	public function new()
	{
		super();
		hudBeeg = new FlxSprite(320, 180).makeGraphic(100, 20, FlxColor.BLACK);
		hudBeeg.screenCenter(X);
		hudBeeg.drawRect(0, 0, 1, 20);
		hudBeeg.drawRect(0, 19, 100, 1);
		hudBeeg.drawRect(99, 0, 1, 20);
		healthCounter = new FlxText(hudBeeg.x + 16, hudBeeg.y + 2, 0, "3 / 3", 8);
		healthCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		healthIcon = new FlxSprite(hudBeeg.x + 4, healthCounter.y + (healthCounter.height / 2) - 4, AssetPaths.health__png);
		coinIcon = new FlxSprite(healthCounter.x + healthCounter.width + 20, healthCounter.y + (healthCounter.height / 2) - 3, AssetPaths.coin__png);
		coinCounter = new FlxText(coinIcon.x + 12, hudBeeg.y + 2, 0, "0", 8);
		coinCounter.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(hudBeeg);
		add(healthCounter);
		add(healthIcon);
		add(coinIcon);
		add(coinCounter);
		forEach(function(sprite) sprite.scrollFactor.set(0, 0));
	}

	public function updateStuff(health:Int, coins:Int)
	{
		healthCounter.text = health + " / 3";
		coinCounter.text = Std.string(coins);
	}
}
