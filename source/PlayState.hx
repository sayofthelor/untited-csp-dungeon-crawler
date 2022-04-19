package;

import Coin;
import GameState;
import HUD;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;

using StringTools;
using flixel.util.FlxSpriteUtil;

class PlayState extends GameState
{
	var player:PlayerController;
	var enemies:FlxTypedGroup<EnemyController>;
	var totalEnemies:Int = 0;
	var playerTrail:FlxTrail;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var coins:FlxTypedGroup<Coin>;
	var collectedCoins:Int = 0;
	var totalCoinAmt:Int = 0;
	var health:Int = 3;
	var hud:HUD;
	var enemyTrailGroup:FlxTypedGroup<FlxTrail>;
	var inCombat:Bool = false;

	override public function create()
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, Main.onCrash);
		FlxG.camera.zoom = 2;
		map = LoadingState.level;
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, FlxObject.NONE);
		walls.setTileProperties(2, FlxObject.ANY);
		add(walls);
		coins = new FlxTypedGroup<Coin>();
		add(coins);
		player = new PlayerController();
		enemyTrailGroup = new FlxTypedGroup<FlxTrail>();
		enemies = new FlxTypedGroup<EnemyController>();
		add(enemyTrailGroup);
		add(enemies);
		map.loadEntities(placeEnts, "entities");
		playerTrail = new FlxTrail(player, 5, 3, 0.4, 0.05);
		add(playerTrail);
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);
		hud = new HUD();
		add(hud);
		transOut(FlxColor.RED);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		#if debug
		if (FlxG.keys.pressed.SEVEN)
			health = 0;
		#end
		if (FlxG.keys.justPressed.ESCAPE)
			pauseGame();
		hud.updateStuff(health, collectedCoins);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, collectCoin);
		FlxG.collide(enemies, walls);
		enemies.forEachAlive(checkEnemyVision);
		FlxG.overlap(player, enemies, touchEnemy);
		if (health == 0)
			transIn(FlxColor.RED, new GameOverState());
	}

	function checkEnemyVision(enemy:EnemyController)
	{
		if (walls.ray(enemy.getMidpoint(), player.getMidpoint()))
		{
			enemy.sees = true;
			enemy.playerPos = player.getMidpoint();
		}
		else
		{
			enemy.sees = false;
		}
	}

	function placeEnts(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);

			case "coin":
				coins.add(new Coin(x + 4, y + 4));

			case "enemy":
				totalEnemies++;
				enemies.add(new EnemyController(x + 4, y, NORMAL));

			case "boss":
				totalEnemies++;
				enemies.add(new EnemyController(x + 4, y, BOSS));
		}
	}

	function collectCoin(player:PlayerController, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			collectedCoins++;
			coin.kill();
		}
	}

	function touchEnemy(player:PlayerController, enemy:EnemyController)
	{
		if (player.alive && player.exists && enemy.alive && enemy.exists && !enemy.isFlickering())
		{
			openCombat(enemy);
		}
	}

	function openCombat(enemy:EnemyController)
	{
		player.active = false;
		enemies.active = false;
		openSubState(new CombatSubState(enemy, health));
	}

	function pauseGame()
	{
		openSubState(new PauseSubState());
	}
}
