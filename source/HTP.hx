package;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class HTP extends FlxState
{
	var text:FlxSprite;
	override public function create() 
	{
		titleScreen();
		FlxG.autoPause = true;
	}
	function titleScreen(){
		//clickPlay();
		//FlxG.mouse.load(AssetPaths.cursor__png);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		//FlxG.sound.playMusic(AssetPaths.Title_Screen__wav, 1, true);
		
		text = new FlxSprite(0, 0).loadGraphic(AssetPaths.htp__png); add(text);
	}
	function clickPlay(){
		//selectSound.play();
		if (FlxG.keys.anyJustPressed([SPACE])){
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function(){
				FlxG.sound.music.stop();
				FlxG.switchState(new PlayState());
			});
		}
	}
	override public function update(elapsed:Float){
		super.update(elapsed);
		
		clickPlay();
	}
}