package {
	import flash.display.Sprite;
	import flash.events.Event;
	public class SpringChain extends Sprite {
		private var numBalls:Number =4
		private var gravity:Number =5;
		private var friction :Number =0.8;
		private var spring:Number =0.1;
		private var balls:Array;
		public function SpringChain() {
			init();
		}
		private function init() {
			balls =new Array();
			var ball0:Ball =new Ball(15);
			addChild(ball0)
			balls.push(ball0);
			for (var i:Number =1; i<numBalls; i++) {
				var ball:Ball =new Ball(15,0xccff00);
				addChild(ball);
				balls.push(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {

			balls[0].x=mouseX;
			balls[0].y=mouseY;
			graphics.clear()
			graphics.lineStyle(1,0)
			graphics.moveTo(mouseX,mouseY)
			for (var i:Number =1; i<numBalls; i++) {
				moveBall(balls[i],balls[i-1].x,balls[i-1].y);
				graphics.lineTo(balls[i].x,balls[i].y)
			}
			
		}
		private function moveBall(ball:Ball,tx:Number ,ty:Number ) {
			ball.vx += (tx-ball.x)*spring;
			ball.vy += (ty-ball.y)*spring;
			ball.vy += gravity;
			ball.vy *= friction ;
			ball.vx *= friction ;
			ball.x += ball.vx;
			ball.y += ball.vy;
		}
	}
}