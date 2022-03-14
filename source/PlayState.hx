package;

import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.effects.FlxTrail;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxG;
import GameState;

using StringTools;

class PlayState extends GameState
{
	var player:PlayerController;
	var playerTrail:FlxTrail;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	override public function create()
	{
		FlxG.camera.zoom = 2;
		map = new FlxOgmo3Loader(AssetPaths.dungeonCrawlSomeBitchesLmao__ogmo, AssetPaths.lev1__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, FlxObject.NONE);
		walls.setTileProperties(2, FlxObject.ANY);
		add(walls);
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
	}

	function placeEnts(entity:EntityData)
		{
			if (entity.name == "player")
			{
				player.x = entity.x;
				player.y = entity.y;
			}
		}
}
