package
{
	import org.flixel.FlxSprite;

	public class Coin extends FlxSprite
	{
		public function Coin(Graphic:Class=null, X:int=0, Y:int=0)
		{
			super(Graphic, X, Y, true);
			this.y -= this.height;
			this.addAnimation("spin", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10);
			this.play("spin");
		}
		
		
	}
}