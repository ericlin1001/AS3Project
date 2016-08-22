package {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.*;
	import flash.utils.Timer;
	//
	public class FlashLight extends Light {
		private var offTimer:Timer;
		private var _radius:Number=0;
		//
		public function FlashLight(tradius:Number=30,tcolor:uint=0xff0000) {
			_radius=tradius;
			super(tcolor,tradius);
		}
		public function set color(value:uint) {
			var g:Graphics=lightColor.graphics;
			g.clear();
			g.lineStyle();
			g.beginFill(value);
			g.drawCircle(0,0,_radius);
			g.endFill();
		}
		public function flashOn(long:int=300) {
			offTimer=new Timer(long,1);
			offTimer.addEventListener(TimerEvent.TIMER,timerHandler);
			on();
			offTimer.start();
		}
		private function timerHandler(e:TimerEvent):void {
			off();
		}

		//
	}
}