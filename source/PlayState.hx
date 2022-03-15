package;

import Coin;
import GameState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

using StringTools;

class PlayState extends GameState
{
	var player:PlayerController;
	var playerTrail:FlxTrail;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var coins:FlxTypedGroup<Coin>;

	override public function create()
	{
		FlxG.camera.zoom = 2;
		map = new FlxOgmo3Loader(AssetPaths.dungeonCrawlSomeBitchesLmao__ogmo, AssetPaths.lev1__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, FlxObject.NONE);
		walls.setTileProperties(2, FlxObject.ANY);
		add(walls);
		add(coins);
		player = new PlayerController();
		map.loadEntities(placeEnts, "entities");
		playerTrail = new FlxTrail(player, 5, 3, 0.4, 0.05);
		add(playerTrail);
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);
		transOut(FlxColor.RED);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, collectCoin);
	}

	function placeEnts(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.x = entity.x;
			player.y = entity.y;
		}
		if (entity.name == "coin")
		{
			coins.add(new Coin(entity.x + 4, entity.y + 4));
		}
	}

	function collectCoin(player:PlayerController, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
