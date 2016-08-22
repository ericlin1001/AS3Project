package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
			var t:TimingCircuitDesign = new TimingCircuitDesign();
			addChild(t);
			
			var s:Signature = new Signature(100, 100);
			stage.addChild(s);
		//	s.init();
			//(addChild(new Signature(100,100)) as Signature).init();
		}
		
	}
	
}