package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class MenuState extends FlxState
	{
		[Embed(source="../media/title.png")]
		protected var TitleImage:Class;
		
		public function MenuState()
		{
			this.add(new FlxSprite(TitleImage));
		}

	}
}