package {
	import flash.display.Sprite;
	import flash.events.Event;
	public class Random extends Sprite {
		private var ball:Ball;
		private var angleX:Number =0;
		private var angleY:Number =0
		private var centerX:Number =stage.stageWidth/2;
		private var centerY:Number =stage.stageHeight/2;
		private var range:Number =100
		private var speedx:Number =0.2
		private var speedy:Number =0.15
		public function Random() {
			init();
		}
		private function init():void {
			ball=new Ball();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME ,onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			ball.x=centerX+ Math.sin (angleX)*range
			ball.y=centerY+Math.sin (angleY)*range
			angleX +=speedx;
			angleY +=speedy;
		}
	}
}