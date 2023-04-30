package;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.addons.editors.tiled.TiledObjectLayer;

class PlayState extends FlxState
{
	//public stuff 
	public static var levelBG:FlxTilemap;
	public static var levelGround:FlxTilemap;
	
	public static var char:Player;
	
	//map
	var map:TiledMap;
	
	//groups
	var levelBounds:FlxGroup;
	var coinGrp:FlxTypedGroup<Coin>;
	var pizzasGrp:FlxTypedGroup<Pizza>;
	var doorsGrp:FlxTypedGroup<Door>;
	var blobsGrp:FlxTypedGroup<Blob>;
	var spikesGrp:FlxTypedGroup<Spike>;
	
	//texts
	var timerTxt:FlxText;
	var pizzaTxt:FlxText;
	var doorsTxt:FlxText;
	
	//ints
	public static var charX:Int = 624;
	public static var charY:Int = 608;
	public static var timer:Float = 240;
	
	//counters
	
	//da booleans
	var counting:Bool = true;
	
	//sounds
	//var heySound:FlxSound;
	//var wallSound:FlxSound;
	//var handSound:FlxSound;
	//var leverSound:FlxSound;
	
	//sprites
	var collide:FlxSprite;
	var wall:FlxSprite;
	var dubWall:FlxSprite;
	var hudSprt:FlxSprite;
	var pizzaSprt:FlxSprite;
	var doorSprt:FlxSprite;
	var skyBG:FlxSprite;
	
	//customs
	//var hudMenu:HUD;
	//public static var door:Door;
	
	//keys (in case i use something over and over again)
	var enterKey = FlxG.keys.anyPressed([ENTER, SPACE]);
	
	override public function create()
	{
		super.create();
		loadSounds();
		startGame();
		createHUD();
	}
	function createHUD(){
		//hudSprt = new FlxSprite(457, 257).loadGraphic(AssetPaths.HUD__png); add(hudSprt); hudSprt.scrollFactor.set(0, 0);
		pizzaSprt = new FlxSprite(477, 277).loadGraphic(AssetPaths.pizza__png); add(pizzaSprt); pizzaSprt.scrollFactor.set(0, 0);
		doorSprt = new FlxSprite(477, 297).loadGraphic(AssetPaths.door_assets__png, true, 16, 32); doorSprt.animation.add('c', [1], 1); doorSprt.animation.play('c'); add(doorSprt); doorSprt.scrollFactor.set(0, 0); 
		
		timerTxt = new FlxText(740, 265, "" + timer);
		timerTxt.setFormat(AssetPaths.slkscr__ttf);
		timerTxt.scrollFactor.set(0, 0);
		timerTxt.color = FlxColor.WHITE;
		timerTxt.size = 18;
		timerTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(timerTxt);
		
		pizzaTxt = new FlxText(495, 265, "" + Variables.pizzas + "/" + Variables.neededPizzas);
		pizzaTxt.setFormat(AssetPaths.slkscr__ttf);
		pizzaTxt.scrollFactor.set(0, 0);
		pizzaTxt.color = FlxColor.WHITE;
		pizzaTxt.size = 18;
		pizzaTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(pizzaTxt);
		
		doorsTxt = new FlxText(495, 295, "" + Variables.doors + "/" + Variables.neededPizzas);
		doorsTxt.setFormat(AssetPaths.slkscr__ttf);
		doorsTxt.scrollFactor.set(0, 0);
		doorsTxt.color = FlxColor.WHITE;
		doorsTxt.size = 18;
		doorsTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(doorsTxt);
	}
	function loadSounds(){
		//handSound = new FlxSound();
		//handSound = FlxG.sound.load(AssetPaths.hand__wav);
	}
	function startGame(){
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.sound.playMusic(AssetPaths.Game__wav, 1, true);
		levelBounds = FlxCollision.createCameraWall(FlxG.camera, true, 1);
		
		//final hudItems = new FlxSprite(427, 240).loadGraphic(AssetPaths.hudCam__png); hudItems.scrollFactor.set(0, 0); add(hudItems);
		
		//final bg = new FlxSprite(0, 0).loadGraphic(AssetPaths.bg__png); add(bg);
		skyBG = new FlxSprite(457, 257).loadGraphic(AssetPaths.skyBG__png); add(skyBG); skyBG.scrollFactor.set(0, 0);
		
		map = new TiledMap('assets/data/LevelOne.tmx');
		
		levelBG = new FlxTilemap();
		levelBG.loadMapFromCSV("assets/data/LevelOne_bg.csv", AssetPaths.tileset__png, 16, 16);
		//add(levelBG);
		
		levelGround = new FlxTilemap();
		levelGround.loadMapFromCSV("assets/data/LevelOne_ground.csv", AssetPaths.tileset__png, 16, 16);
		add(levelGround);
		
		final coinLayer:TiledObjectLayer = cast(map.getLayer("coins"));
		coinGrp = new FlxTypedGroup<Coin>();
		for (c in coinLayer.objects){
			final cSprt = new Coin(c.x, c.y);
			coinGrp.add(cSprt);
		}
		add(coinGrp);
		
		final pizzLayer:TiledObjectLayer = cast(map.getLayer("pizzas"));
		pizzasGrp = new FlxTypedGroup<Pizza>();
		for (pp in pizzLayer.objects){
			final pSprt = new Pizza(pp.x, pp.y);
			pizzasGrp.add(pSprt);
		}
		add(pizzasGrp);
		
		final doorLayer:TiledObjectLayer = cast(map.getLayer("doors"));
		doorsGrp = new FlxTypedGroup<Door>();
		for (d in doorLayer.objects){
			final dSprt = new Door(d.x, d.y);
			doorsGrp.add(dSprt);
		}
		add(doorsGrp);
		
		final blobLayer:TiledObjectLayer = cast(map.getLayer("blobs"));
		blobsGrp = new FlxTypedGroup<Blob>();
		for (b in blobLayer.objects){
			final bSprt = new Blob(b.x, b.y);
			blobsGrp.add(bSprt);
		}
		add(blobsGrp);
		
		final spikeLayer:TiledObjectLayer = cast(map.getLayer("spikes"));
		spikesGrp = new FlxTypedGroup<Spike>();
		for (s in blobLayer.objects){
			final sSprt = new Spike(s.x, s.y);
			spikesGrp.add(sSprt);
		}
		add(spikesGrp);
		
		char = new Player(624, 608); add(char);
		
		FlxG.camera.zoom = 3.5;
		FlxG.camera.follow(char, LOCKON, 0.7);
		FlxG.camera.setScrollBoundsRect(0, 0, levelGround.width, levelGround.height);
	}
	override public function update(elapsed:Float){
		FlxG.collide(char, levelGround);
		FlxG.collide(char, levelBounds);
		
		if(counting == true){
			timer -= 0.0215;
		}
		timerTxt.text = "" + timer;
		doorsTxt.text = "" + Variables.doors + "/" + Variables.neededPizzas;
		pizzaTxt.text = "" + Variables.pizzas + "/" + Variables.neededPizzas;
		
		super.update(elapsed);
		
		if (Variables.doors == Variables.neededPizzas){
			counting = false;
			EndState.won = true;
			FlxG.sound.music.stop();
			timerTxt.visible = false;
			
			FlxG.camera.fade(FlxColor.BLACK, 2, false, function(){
				FlxG.switchState(new EndState());
			});
		}
		if (timer <= 0){
			counting = false;
			EndState.won = false;
			FlxG.sound.music.stop();
			timerTxt.visible = false;
			
			FlxG.camera.fade(FlxColor.BLACK, 2, false, function(){
				FlxG.switchState(new EndState());
			});
		}
		
		
	}
}