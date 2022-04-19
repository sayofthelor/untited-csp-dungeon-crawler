package;

import EnemyController.EnemyType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;

using flixel.util.FlxSpriteUtil;

enum Outcometh
{
	NONE;
	VICTORY;
	DEFEAT;
	ESCAPE;
}

class CombatSubState extends FlxSubState
{
	var enemy:EnemyController;
	var health:Int;

	override public function new(enemy:EnemyController, health:Int)
	{
		this.enemy = enemy;
		this.health = health;
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, Main.onCrash);
		super();
	}

	override function create()
	{
		FlxG.camera.flash(FlxColor.WHITE, 1);
		var bossTimeText:FlxText = new FlxText(0, 0, 0, "C-C-C-COMBAT TIME!", 32);
		if (enemy.type == EnemyType.BOSS)
			bossTimeText.text = "B-B-B-BOSS TIME!";
		bossTimeText.scrollFactor.set();
		bossTimeText.screenCenter(X);
		bossTimeText.screenCenter(Y);
		var bsty:Float = bossTimeText.y;
		bossTimeText.y = FlxG.height;
		var overBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		overBG.alpha = 0;
		add(overBG);
		add(bossTimeText);
		FlxTween.tween(overBG, {alpha: 0.6}, 0.35, {ease: FlxEase.quintIn});
		FlxTween.tween(bossTimeText, {y: bsty}, 1, {
			ease: FlxEase.quintInOut,
			onComplete: function(_)
			{
				bossTimeText.scale.set(1.2, 1.2);
				FlxG.camera.flash(FlxColor.WHITE, 0.5);
				FlxG.camera.shake(0.01, 0.5);
				new FlxTimer().start(1, function(_)
				{
					FlxTween.tween(bossTimeText, {
						alpha: 0,
						"scale.x": 1,
						"scale.y": 1,
						y: bossTimeText.y + 100
					}, 0.5, {
						ease: FlxEase.quintInOut,
						onComplete: function(_)
						{
							bossTimeText.destroy();
						}
					});
				});
			}
		});
		super.create();
	}

	override function update(elapsed)
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.EIGHT)
		{
			enemy.kill();
			destroy();
			close();
		}
	}
}
