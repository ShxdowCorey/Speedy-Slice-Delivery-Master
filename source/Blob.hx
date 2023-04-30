package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class Blob extends FlxSprite
{
	var chime:FlxSound;
	
	var count:Int = 0;
	var moveL:Bool = true;
	var moveR:Bool = false;
	var deathCounter:Int = 0;
	var idleCounter:Int = 0;
	
	var L:Bool = false;
	var R:Bool = true;
	
	var stopMoving:Int = 1;
	
	var addScore:Bool = false;
	
	var playerSpeed:Float = 100;
	var SPEED:Int = 100;//the lower this is, the lower the player will jump in vice versa
	var GRAVITY:Int = 450; //the higher this is, the higher the player will jump in vice versa
	public function new(x:Float, y:Float):Void
	{
		super(x, y);
		loadGraphic(AssetPaths.blob_assets__png, true, 16, 16);
		animation.add('idle', [0, 1], 3, true);
		animation.play('idle');
		
		chime = FlxG.sound.load(AssetPaths.hurt__wav);
		
		drag.x = SPEED * 8.5; 
		acceleration.y = GRAVITY * 1.5; //the lower this number is, the floatier the jump
		maxVelocity.set(playerSpeed, 400);
		drag.set(playerSpeed * 8.5, playerSpeed * 3);
	}
	function updateMovement()
	{
		if (stopMoving == 1){
			if (moveL == true) {
				flipX = true;
				count += FlxG.random.int(0, 2);
				this.velocity.x -= FlxG.random.int(11, 21);
			}
			else if (moveR == true) {
				flipX = false;
				count -= FlxG.random.int(0, 2);
				this.velocity.x += FlxG.random.int(11, 21);
			}
			if (count>=FlxG.random.int(30, 60)) {
				moveL = false;
				moveR = true;
			}
			if (count<=0) {
				moveL = true;
				moveR = false;
			}
		}
	}
	function updateIdleOrSomething(){
		if (L == true) {
			idleCounter++;
		}
		else if (R == true) {
			idleCounter--;
		}
		
		if (idleCounter>=FlxG.random.int(30, 60)) {
			L = false;
			R = true;
			stopMoving = 2;
		}
		if (idleCounter<=FlxG.random.int(0, -20)) {
			L = true;
			R = false;
			stopMoving = 1;
		}
	}
	override function update(elapsed:Float){
		super.update(elapsed);
		
		FlxG.collide(this, PlayState.levelGround);
		updateIdleOrSomething();
		updateMovement();
		
		if (PlayState.char.overlaps(this)){
			PlayState.char.x = PlayState.charX;
			PlayState.char.y = PlayState.charY;
			PlayState.char.alpha = 0.5;
			chime.play();
		}
		
		if (Variables.pizzas == Variables.neededPizzas){
			this.kill();
		}
	}
}