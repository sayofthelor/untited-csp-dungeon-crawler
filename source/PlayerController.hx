package;

import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

// haxeflixel tutorial kek

class PlayerController extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0)
        {
            super(x,y);
            loadGraphic(AssetPaths.player__png, true, 16, 16);
            drag.x = drag.y = 2147483647; // no moving
            setFacingFlip(FlxObject.LEFT, false, false);
            setFacingFlip(FlxObject.RIGHT, true, false);
            animation.add("lr", [3, 4, 3, 5], 6, false);
            animation.add("u", [6, 7, 6, 8], 6, false);
            animation.add("d", [0, 1, 0, 2], 6, false);
            animation.add("n", [0], 6, false);
        }

    var up:Bool;
    var down:Bool;
    var left:Bool;
    var right:Bool;
    inline static var SPEED:Float = 300;

    function updateMove()
        {
            up = FlxG.keys.anyPressed([UP, W]);
            down = FlxG.keys.anyPressed([DOWN, S]);
            left = FlxG.keys.anyPressed([LEFT, A]);
            right = FlxG.keys.anyPressed([RIGHT, D]);
            if (up && down)
                up = down = false;
            if (left && right)
                left = right = false;
            if (up || down || left || right)
                {
                    var newAngle:Float = 0;
                    if (up)
                    {
                        newAngle = -90;
                        if (left)
                            newAngle -= 45;
                        else if (right)
                            newAngle += 45;
                        facing = FlxObject.UP;
                    }
                    else if (down)
                    {
                        newAngle = 90;
                        if (left)
                            newAngle += 45;
                        else if (right)
                            newAngle -= 45;
                        facing = FlxObject.DOWN;
                    }
                    else if (left) {
                        newAngle = 180;
                        facing = FlxObject.LEFT;
                    }
                    else if (right) {
                        newAngle = 0;
                        facing = FlxObject.RIGHT;
                    }
                    velocity.set(SPEED, 0);
                    velocity.rotate(FlxPoint.weak(0, 0), newAngle);

                    if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) 
                        {
                            switch (facing)
                            {
                                case FlxObject.LEFT, FlxObject.RIGHT:
                                    animation.play("lr");
                                case FlxObject.UP:
                                    animation.play("u");
                                case FlxObject.DOWN:
                                    animation.play("d");
                            }
                        }
                }               
        }

    override function update(elapsed:Float) {
        updateMove();
        super.update(elapsed);
    }
}