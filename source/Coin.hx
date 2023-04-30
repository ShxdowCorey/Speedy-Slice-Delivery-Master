package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class Coin extends FlxSprite
{
	var chime:FlxSound;
	public function new(x:Float, y:Float):Void
	{
		super(x, y);
		loadGraphic(AssetPaths.coin_assets__png, true, 16, 16);
		animation.add('spin', [0, 1, 2, 3], 6, true);
		animation.play('spin');
		
		FlxTween.tween(this, {y: this.y - 5}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
		
		chime = FlxG.sound.load(AssetPaths.coin__wav);
	}
	override function update(elapsed:Float){
		super.update(elapsed);
		
		if (PlayState.char.overlaps(this)){
			
			Variables.coins++;
			chime.play();
			this.kill();
		}
	}
}