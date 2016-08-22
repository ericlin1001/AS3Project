package {
	import flash.display.Sprite;

	import flash.events.Event;
	import flash.events.MouseEvent 
	public class Spring extends Sprite {
		private var ball:Ball;
		private var ax:Number =0
		private var ay:Number =0
		private var tx:Number =stage.stageWidth/2
		private var ty:Number =stage.stageHeight/2;
		private var gravity:Number =0.1
		private var friction :Number =0.95
		
		public function Spring() {
			init();
		}
		private function init() {
			 ball=new Ball(20);
			addChild(ball);
			
			
			
			
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		private function onEnterFrame(event:Event):void {
			tx=mouseX
			ty=mouseY
			ax=(tx-ball.x)*0.01
			ay=(ty-ball.y)*0.01
			ball.vx += ax
			ball.vy += ay
			ball.vy += gravity;
			ball.vy *= friction ;
			ball.vx *= friction ;
			ball.x += ball.vx;
			ball.y += ball.vy;
			
		}
		
		
	}
}