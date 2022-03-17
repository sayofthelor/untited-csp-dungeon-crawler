package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

using flixel.util.FlxSpriteUtil;

enum EnemyType
{
	NORMAL;
	BOSS;
}

// haxeflixel tutorial kek
class EnemyController extends FlxSprite
{
	public var type:EnemyType;
	public var brain:Frankenstein;
	public var idleTime:Float;
	public var direction:Float;
	public var sees:Bool;
	public var playerPos:FlxPoint;

	public function new(x:Float = 0, y:Float = 0, type:EnemyType)
	{
		super(x, y);
		this.type = type;
		var graphicToLoad = if (type == NORMAL) AssetPaths.enemy__png else AssetPaths.boss__png;
		loadGraphic(graphicToLoad, true, 16, 16);
		drag.x = drag.y = 10; // no moving
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		width = 8;
		height = 14;
		offset.x = 4;
		offset.y = 2;
		if (type == BOSS)
		{
			scale.x = scale.y = 2;
			updateHitbox();
		}
		brain = new Frankenstein(idle);
		idleTime = 0;
		playerPos = FlxPoint.get();
	}

	var speed:Float = 50;

	override public function update(elapsed:Float)
	{
		if (this.isFlickering())
			return;
		if (type == BOSS)
			speed = 40;
		if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)
		{
			if (Math.abs(velocity.x) > Math.abs(velocity.y))
			{
				if (velocity.x < 0)
					facing = LEFT;
				else
					facing = RIGHT;
			}
			else
			{
				if (velocity.y < 0)
					facing = UP;
				else
					facing = DOWN;
			}

			switch (facing)
			{
				case LEFT, RIGHT:
					animation.play("lr");

				case UP:
					animation.play("u");

				case DOWN:
					animation.play("d");

				case _:
			}
		}
		brain.update(elapsed);
		super.update(elapsed);
	}

	function idle(elapsed:Float)
	{
		if (sees)
		{
			brain.activeState = chase;
		}
		else if (idleTime <= 0)
		{
			if (FlxG.random.bool(1))
			{
				direction = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				direction = FlxG.random.int(0, 8) * 45;

				velocity.set(speed * 0.5, 0);
				velocity.rotate(FlxPoint.weak(), direction);
			}
			idleTime = FlxG.random.int(1, 4);
		}
		else
			idleTime -= elapsed;
	}

	function chase(elapsed:Float)
	{
		if (!sees)
		{
			brain.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
	}

	public function changeType(type:EnemyType)
	{
		if (this.type != type)
		{
			this.type = type;
			var graphic = if (type == BOSS) AssetPaths.boss__png else AssetPaths.enemy__png;
			loadGraphic(graphic, true, 16, 16);
		}
	}
}
