package
{
	import flash.events.*;
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source="../media/title.png")]
		protected var TitleImage:Class;
		
		public function MenuState()
		{
			this.add(new FlxSprite(TitleImage));
		}
		
		public override function update():void
		{
			super.update();
			if (FlxG.keys.justPressed("X"))
				FlxG.switchState(GameState);
		}
	}
}