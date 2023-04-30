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

class TitleState extends FlxState
{
	var bg:FlxSprite;
	var logo:FlxSprite;
	var pointer:FlxSprite;
	var text:FlxSprite;
	
	var selectSound:FlxSound;
	var scrollSound:FlxSound;
	override public function create() 
	{
		loadSounds();
		titleScreen();
		FlxG.autoPause = true;
	}
	function loadSounds(){
		selectSound = new FlxSound();
		selectSound = FlxG.sound.load(AssetPaths.select__wav);
		
		scrollSound = new FlxSound();
		scrollSound = FlxG.sound.load(AssetPaths.scroll__wav);
	}
	function titleScreen(){
		//clickPlay();
		//FlxG.mouse.load(AssetPaths.cursor__png);
		FlxG.camera.zoom = 2;
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.sound.playMusic(AssetPaths.Title_Screen__wav, 1, true);
		bg = new FlxSprite(320, 180).loadGraphic(AssetPaths.bg__png); add(bg);
		logo = new FlxSprite(378, 238).loadGraphic(AssetPaths.logo__png); add(logo);
		
		FlxTween.tween(logo, {y: logo.y - 20}, 1.5, {ease: FlxEase.quadInOut, type: PINGPONG});
		
		text = new FlxSprite(320, 180).loadGraphic(AssetPaths.title_text__png); add(text);
		
		pointer = new FlxSprite(580, 424).loadGraphic(AssetPaths.pointer__png); add(pointer);
	}
	
	function updatePointer(){
		if (FlxG.keys.anyJustPressed([DOWN])){
			scrollSound.play();
			if (pointer.y == 424){
				pointer.setPosition(534, 456);
			}
			else if (pointer.y == 456){
				pointer.setPosition(580, 424);
			}
		}
		
		if (FlxG.keys.anyJustPressed([UP])){
			scrollSound.play();
			if (pointer.y == 424){
				pointer.setPosition(534, 456);
			}
			else if (pointer.y == 456){
				pointer.setPosition(580, 424);
			}
		}
	}
	function clickPlay(){
		//selectSound.play();
		if (FlxG.keys.anyJustPressed([SPACE, ENTER])){
			selectSound.play();
			if(pointer.y == 424){
				FlxG.camera.fade(FlxColor.BLACK, 1, false, function(){
					FlxG.sound.music.stop();
					FlxG.switchState(new HTP());
				});
			}
			else if (pointer.y == 456){
				FlxG.openURL('https://ldjam.com/');
			}
		}
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
		
		updatePointer();
		
		clickPlay();
	}
}