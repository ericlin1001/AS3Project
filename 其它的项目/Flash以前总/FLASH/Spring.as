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
		private var gravity:Number =5
		private var friction :Number =0.95
		private var spring:Number =0.1
		
		public function Spring() {
			init();
		}
		private function init() {
			 ball=new Ball(15);
			addChild(ball);
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		private function onEnterFrame(event:Event):void {
			tx=mouseX
			ty=mouseY
			ax=(tx-ball.x)*spring
			ay=(ty-ball.y)*spring
			ball.vx += ax
			ball.vy += ay
			ball.vy += gravity;
			ball.vy *= friction ;
			ball.vx *= friction ;
			ball.x += ball.vx;
			ball.y += ball.vy;
			
			graphics.clear()
			graphics.lineStyle(1,0)
			graphics.moveTo(tx,ty)
			graphics.lineTo(ball.x,ball.y)
			
		}
		
		
	}
}