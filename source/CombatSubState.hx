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

enum Outcome
{
	NONE;
	VICTORY;
	DEFEAT;
	ESCAPE;
}

class CombatSubState extends FlxSubState
{
	var player:PlayerController;
	var enemy:EnemyController;
	var health:Int;

	override public function new(enemy:EnemyController, health:Int, player:PlayerController)
	{
		this.enemy = enemy;
		this.health = health;
		super();
	}

	override function create()
	{
		FlxG.camera.flash(FlxColor.WHITE, 1);
		var bossTimeText:FlxText = new FlxText(0, 0, 0, "C-C-C-COMBAT TIME!", 32);
		if (enemy.type == EnemyType.BOSS)
			bossTimeText.text = "B-B-B-BOSS TIME!";
		bossTimeText.scrollFactor.set();
		bossTimeText.screenCenter();
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
		new FlxTimer().start(1.5, function(_) {
			var txt:FlxText;
			if (enemy.type == BOSS)
				{
				FlxG.sound.playMusic(PathsAndStuff.snd("boss"));
				FlxG.sound.music.fadeIn(1, 0, 0.4);
				}
			else
				{
				FlxG.sound.playMusic(PathsAndStuff.snd("combat"));
				FlxG.sound.music.fadeIn(1, 0, 0.4);
				txt = new FlxText(-200, 492, 0, "Technicolor Tussle - BLVKAROT", 16);
				txt.alignment = LEFT;
				txt.scrollFactor.set();
				add(txt);
				FlxTween.tween(txt, {x: 183 + txt.width}, 1.5, {ease: FlxEase.quintInOut, onComplete: function(_) {
					new FlxTimer().start(2, function(_) {
						FlxTween.tween(txt, {x:-200}, 1.5, {ease: FlxEase.quintInOut, onComplete: function(_) {
							txt.destroy();
						}});
					});
				}});
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
			PlayState.player.active = true;
			PlayState.enemies.active = true;
			close();
		}
	}
}
