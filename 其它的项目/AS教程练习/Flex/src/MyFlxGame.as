package
{
	import org.flixel.FlxGame;
	import org.flixel.FlxState;

	public class MyFlxGame extends FlxGame
	{
		public function MyFlxGame(GameSizeX:uint, GameSizeY:uint, InitialState:Class, Zoom:uint=2)
		{
			super(320, 320, PlayState, 2);
		}
		
	}
}