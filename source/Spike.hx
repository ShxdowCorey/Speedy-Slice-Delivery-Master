package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class Spike extends FlxSprite
{
	var hurtSound:FlxSound;
	public function new(x:Float, y:Float):Void
	{
		super(x, y);
		loadGraphic(AssetPaths.spike__png);
		
		hurtSound = new FlxSound();
		hurtSound = FlxG.sound.load(AssetPaths.hurt__wav);
	}
	override function update(elapsed:Float){
		super.update(elapsed);
		
		if (PlayState.char.overlaps(this)){
			PlayState.char.x = PlayState.charX;
			PlayState.char.y = PlayState.charY;
			PlayState.char.alpha = 0.5;
			hurtSound.play();
		}
	}
}