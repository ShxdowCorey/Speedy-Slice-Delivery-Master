package;
import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.display.FPS;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, TitleState, 60, 60, true, false));
		addChild(new FPS(10, 3, 0xFFFFFF));
	}
}
