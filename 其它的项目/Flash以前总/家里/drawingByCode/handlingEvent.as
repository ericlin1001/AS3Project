package {
	import flash.events.Event;
	import flash.display.Sprite;
		import flash.events.MouseEvent ;
	public class handlingEvent extends Sprite {
		public function handlingEvent() {
			var mc:ChildSquare=new ChildSquare () ;
			addChild(mc);
			mc.x=0;
			mc.y=0;
			mc.addEventListener(MouseEvent.CLICK,onClick);
			stage.addEventListener(MouseEvent.CLICK,onClick);
			
		}
		private function onClick(event:MouseEvent):void{
			trace("event.type="+event.type)
			trace("event.bubbles="+event.bubbles)
			trace("event.cancelable="+event.cancelable)
			trace("event.eventPhase="+event.eventPhase)
			event.stopPropagation()
			
		}
		
	}
}