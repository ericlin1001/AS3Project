package 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var ball:Sprite = new Sprite();
			var g:Graphics = ball.graphics;
			g.lineStyle(0);
			g.drawCircle(0, 0, 4);
			ball.x = 50;
			ball.y = 50;
			addChild(ball);
			ball.addEventListener(Event.ENTER_FRAME, update);


		}
		private function update(e:Event = null):void {
			var obj:DisplayObject = e.currentTarget as DisplayObject;
			obj.x += 2;
			
		}
		
	}
	
}