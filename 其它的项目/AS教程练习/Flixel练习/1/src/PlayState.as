package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;

	public class PlayState extends FlxState
	{
		[Embed(source='hero.PNG')]private var MyHero:Class;
		protected var hero:FlxSprite;
		public function PlayState()
		{
			hero=new FlxSprite(0,0,MyHero);
			super();
			add(hero);
		}
		
	}
}