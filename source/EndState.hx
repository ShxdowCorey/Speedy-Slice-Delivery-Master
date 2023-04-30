package;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class EndState extends FlxState
{
	var selectSound:FlxSound;
	var scrollSound:FlxSound;
	
	var winSound:FlxSound;
	var loseSound:FlxSound;
	
	var screen:FlxSprite;
	
	public static var won:Bool;
	override public function create() 
	{
		loadSounds();
		endScreen();
	}
	function loadSounds(){
		selectSound = new FlxSound();
		selectSound = FlxG.sound.load(AssetPaths.select__wav);
		
		scrollSound = new FlxSound();
		scrollSound = FlxG.sound.load(AssetPaths.scroll__wav);
	}
	function endScreen(){
		if (won == true){
			FlxG.sound.playMusic(AssetPaths.Win__wav, 1, false);

			screen = new FlxSprite(0, 0).loadGraphic(AssetPaths.won__png); add(screen);
			
		}else{
			FlxG.sound.playMusic(AssetPaths.Lose__wav, 1, false);
			
			screen = new FlxSprite(0, 0).loadGraphic(AssetPaths.lose__png); add(screen);
		}
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
		
		if (FlxG.keys.anyJustPressed([SPACE])){
			selectSound.play();
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function(){
				//FlxG.sound.music.stop();
				Variables.doors = 0;
				Variables.pizzas = 0;
				PlayState.timer = 240;
				
				FlxG.switchState(new TitleState());
			});
		}	
	}
}