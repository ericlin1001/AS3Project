package {
	import flash.display.Sprite;


	import flash.events.Event;
	public class Oval extends Sprite {
		private var angle:Number = 0;
		private var centerX:Number = 275;
		private var centerY:Number = 200;
		private var a:Number =200;
		private var b:Number =150

		private var speed:Number = 0.1;
		private var xpos:Number;
		private var ypos:Number;
		public function Oval() {
			init();
		}
		private function init() {
			graphics.lineStyle(1,0);
			graphics.moveTo(centerX+a,centerY);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			xpos =centerX+Math.cos (angle)*a ;
			ypos= centerY +Math.sin (angle)*b ;
			angle +=speed;
			graphics.lineTo(xpos,ypos);
			trace(event.type + angle);
			if (angle>6.3) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
	}
}