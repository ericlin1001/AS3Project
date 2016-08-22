package 
{
	import org.flixel.*;

	public class FlixelGame extends FlxGame
	{
		public function FlixelGame():void
		{
			super(320, 240, MenuState, 2, 0xff131c1b, true, 0xff729954);
			help("Jump", "Shoot", "Nothing");
			useDefaultVolumeControls(true);
		}
	}
}
