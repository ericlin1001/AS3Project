package 
{
	import flash.display.Sprite;
	import flash.events.Event;
		import flash.display.StageAlign;
	import flash.display.StageScaleMode;
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
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChild(new creator());
			addChild(new Signature(stage.width, stage.height));
		}
		
	}
	
}