package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.graphics.frames.FlxAtlasFrames;

class Player extends FlxSprite
{
	public static var faceX:Bool;
	public var canWalk:Bool = true;
	public var playerSpeed:Float = 115;
	public var playerJump:Float = 275;
	var DRAGSpeed:Int = 110;
	
	var shootSound:FlxSound;
	var noBullets:FlxSound;
	var walkSound:FlxSound;
	var jumpSound:FlxSound;
	var alphaCounter:Int = 0;
	var _flagWalking:Bool = false;
	var GRAVITY:Int = 450; //the higher this is, the higher the player will jump in vice versa (i think)
	
	public function new(x:Float, y:Float){
		super(x, y);
		createSounds();
		loadGraphic(AssetPaths.player_assets__png, true, 16, 32);
		animation.add('idle', [0], 5, true);
		animation.add('walk', [1, 0, 2, 0], 6, true);
		animation.add('jump', [3], 1);
		//animation.add('die', [3], 1, false);
		//animation.add('shoot', [9, 8], 4, false);
		animation.play('idle');
		antialiasing = false; //eliminates smoothing //duuhhh i already knew that //bro shut up, i wasnt talking to you dang
		drag.x = DRAGSpeed * 3.7; 
		acceleration.y = GRAVITY * 1.5; //the lower this number is, the floatier the jump
		maxVelocity.set(playerSpeed, 400);
		drag.set(playerSpeed * 3.7, playerSpeed * 3);
		
		//height -= 5;
        //offset.y = 5;
        //width -= 5;
        //offset.x = 2;
	}
	function createSounds(){
		shootSound = new FlxSound();
		//shootSound = FlxG.sound.load(AssetPaths.shoot__wav);
		
		noBullets = new FlxSound();
		//noBullets = FlxG.sound.load(AssetPaths.nobullets__wav);
		
		walkSound = new FlxSound();
		//walkSound = FlxG.sound.load(AssetPaths.walk__wav);
		
		jumpSound = new FlxSound();
		jumpSound = FlxG.sound.load(AssetPaths.jump__wav);
	}
	function updateMovement(){
		var left = FlxG.keys.anyPressed([LEFT, A]);
		var right = FlxG.keys.anyPressed([RIGHT, D]);
		var down = FlxG.keys.anyPressed([DOWN, S]);
		var up = FlxG.keys.anyJustPressed([UP, W]);
		
		if (this.isTouching(FlxObject.FLOOR))
		{
			if (!_flagWalking)
			{
				this.animation.play("idle");
			}
		}
		else if (this.velocity.y > 0)
		{
			this.animation.play("jump");
		}
		
		
		if (left && right)
		{
			if (!this.isTouching(FlxObject.FLOOR)){
				if(this.velocity.y > 0){
					this.velocity.x = 0;
					animation.play('jump');
				}
				else
				{
					this.velocity.x = 0;
					animation.play('jump');
				}
			}
		}
		else if (left && right){
			if (this.isTouching(FlxObject.FLOOR)){
				this.velocity.x = 0;
				animation.play('idle');
			}
		}

		else if (left)
		{
			this.velocity.x = -playerSpeed;
			this.flipX = true;

			if (this.isTouching(FlxObject.FLOOR) && !this.isTouching(FlxObject.WALL))
			{
				_flagWalking = true;
				this.animation.play("walk");
			}
		}
		else if (right)
		{
			this.velocity.x = playerSpeed;
			this.flipX = false;

			if (this.isTouching(FlxObject.FLOOR) && !this.isTouching(FlxObject.WALL))
			{
				_flagWalking = true;
				this.animation.play("walk");
			}
		}
		else
		{
			_flagWalking = false;
		}

		if (up)
		{
			if (this.isTouching(FlxObject.FLOOR))
			{
				jumpSound.play(true);
				this.animation.play("jump");
				this.velocity.y = -playerJump;
			}
		}
	}
	function updateAlpha(){
		if (this.alpha == 0.5){
			alphaCounter++;
		}
		if (alphaCounter >= 40){
			alphaCounter = 0;
			alpha = 1;
		}
	}
	public function hitSpike(){
		/*
		//gotHit = true;
		velocity.y = -GRAVITY / 3.5;
		
		if (this.flipX == false){
			velocity.x = -100;
		}
		else if (this.flipX == true){
			velocity.x = 100;
		}
		*/
	}
	//update everything
	override function update(elapsed:Float){
		if (canWalk == true){
			updateAlpha();
			updateMovement();
		}
		super.update(elapsed);
	}
}