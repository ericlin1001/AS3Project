package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Main extends Sprite 
	{
		private var ball:Sphere;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			 ball = new Sphere();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event=null):void {
				ball
		}
		
	}
	
}