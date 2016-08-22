package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.TextLine;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Eric
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
			var em:EmulatorManager = new EmulatorManager();
			em.init();
			em.inputSymbols("hAello!A");
			addChild(em);
		}
		
	}
	
}