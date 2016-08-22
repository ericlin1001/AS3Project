package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Background extends Sprite
	{
		
		public function Background() 
		{
			var g:Graphics = graphics;
			g.lineStyle(0);
			g.beginFill(0xaaaaaa);
			g.drawRect(0, 0, 600, 500);
			g.endFill();
		}
		
	}
	
}