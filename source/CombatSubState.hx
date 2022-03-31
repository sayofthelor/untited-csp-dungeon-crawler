package;

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
	override function create()
	{
		FlxG.camera.flash(FlxColor.WHITE, 1);
		var bossTimeText:FlxText = new FlxText(0, 0, 0, "C-C-C-COMBAT TIME!", 32);
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
					FlxTween.tween(bossTimeText, {alpha: 0, "scale.x": 1, "scale.y": 1}, 0.5, {
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
		if (FlxG.keys.pressed.SEVEN)
			close();
	}
}
