package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class Door extends FlxSprite
{
	var chime:FlxSound;
	public function new(x:Float, y:Float):Void
	{
		super(x, y);
		loadGraphic(AssetPaths.door_assets__png, true, 16, 32);
		animation.add('closed', [0], 1);
		animation.add('open', [1], 1);
		animation.play('closed');
		
		chime = FlxG.sound.load(AssetPaths.door__wav);
	}
	override function update(elapsed:Float){
		super.update(elapsed);
		
		if (PlayState.char.overlaps(this)){
			if (Variables.pizzas > 0){
				if(this.animation.curAnim.name == 'closed'){
					chime.play();
					Variables.pizzas--;
					Variables.doors++;
					this.animation.play('open');
				}
			}
		}
	}
}