package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Bird extends Sprite
	{
		
		public function Bird(r:int=10) 
		{
			var g:Graphics = graphics;
			g.lineStyle(0);
			g.beginFill(0xff0000);
			graphics.drawCircle(0, 0, r);
			g.beginFill(0xff0000, 0);
			g.lineStyle();
			graphics.drawCircle(0, 0, r*5);
			g.endFill();
		}
		
	}
	
}