package {
	import flash.display.Sprite;


	import flash.events.Event;
	public class Wave extends Sprite {
		private var angle:Number = 0;
		private var centerY:Number = 200;
		private var range:Number = 50;
		private var a :Number =2
		private var xspeed:Number = 1*a;
		private var yspeed:Number = .05*a;
		private var xpos:Number=0;
		private var ypos:Number;
		public function Wave() {
			init();
		}
		private function init() {
			graphics.lineStyle(1,0);
			graphics.moveTo(0,centerY);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			xpos +=xspeed;
			ypos = centerY +Math.sin (angle)*range ;
			angle +=yspeed;
			graphics.lineTo(xpos,ypos);
		}
	}
}