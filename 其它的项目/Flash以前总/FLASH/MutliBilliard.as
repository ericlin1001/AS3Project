package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.geom.Point;
	public class MutliBilliard extends Sprite {
		private var numBalls:Number =12
		private var balls:Array;
		private var friction :Number =1;
		private var gravity:Number =0.2;
		private var bounce :Number =-1;
		private var speed :Number =30;
		public function MutliBilliard() {
			init();
		}
		private function init():void {
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT ;
			balls=new Array();
			for (var i:Number =0; i<numBalls; i++) {
				var radius:Number =Math.random ()*20+20;
				var ball:Ball =new Ball(radius,0xffffff * Math.random ());
				addChild(ball);
				ball.x=i*100+100;
				ball.y=i*50+50;
				ball.vx=speed*(Math.random ()*2-1);
				ball.vy=speed*(Math.random ()*2-1);
				ball.mass=radius;
				balls.push(ball);
			}
			addEventListener(Event.ENTER_FRAME ,onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			for (var i:Number =0; i<numBalls; i++) {
				moveBall(balls[i]);
				checkWall(balls[i]);
			}
			for (i =0; i<numBalls-1; i++) {
				for (var j:Number =i+1; j<numBalls; j++) {

					checkCollision(balls[i],balls[j]);
				}
			}
		}
		private function moveBall(ball:Ball) {
			ball.vy+=gravity;
			ball.vx*=friction;
			ball.vy*=friction;
			ball.x+=ball.vx;
			ball.y+=ball.vy
			;
		}
		private function checkCollision(ball0:Ball, ball1:Ball):void {
			var dx:Number = ball1.x - ball0.x;
			var dy:Number = ball1.y - ball0.y;
			var dist:Number = Math.sqrt(dx*dx + dy*dy);
			if (dist < ball0.radius + ball1.radius) {
				// 计算角度和正余弦值 
				var angle:Number = Math.atan2(dy, dx);
				var sin:Number = Math.sin(angle);
				var cos:Number = Math.cos(angle);// 旋转 ball0 的位置 
				var pos0:Point = new Point(0, 0);
				// 旋转 ball1 的速度 
				var pos1:Point = rotate(dx, dy, sin, cos, true);
				// 旋转 ball0 的速度
				var vel0:Point = rotate(ball0.vx, ball0.vy, sin, cos, true);
				// 旋转 ball1 的速度 
				var vel1:Point = rotate(ball1.vx, ball1.vy, sin, cos, true);
				// 碰撞的作用力 
				var vxTotal:Number = vel0.x - vel1.x;
				vel0.x = ((ball0.mass - ball1.mass) * vel0.x + 2 * ball1.mass * vel1.x) / (ball0.mass + ball1.mass);
				vel1.x = vxTotal + vel0.x;
				// 更新位置
				var absV:Number = Math.abs(vel0.x) + Math.abs(vel1.x);
				var overlap:Number = (ball0.radius + ball1.radius) - Math.abs(pos0.x - pos1.x);
				pos0.x += vel0.x / absV * overlap;
				pos1.x += vel1.x / absV * overlap;
				// 将位置旋转回来 
				var pos0F:Object = rotate(pos0.x, pos0.y, sin, cos, false);

				var pos1F:Object = rotate(pos1.x, pos1.y, sin, cos, false);
				// 将位置调整为屏幕的实际位置 
				ball1.x = ball0.x + pos1F.x;
				ball1.y = ball0.y + pos1F.y;
				ball0.x = ball0.x + pos0F.x;
				ball0.y = ball0.y + pos0F.y;
				// 将速度旋转回来 
				var vel0F:Object = rotate(vel0.x, vel0.y, sin, cos, false);
				var vel1F:Object = rotate(vel1.x, vel1.y, sin, cos, false);
				ball0.vx = vel0F.x;
				ball0.vy = vel0F.y;
				ball1.vx = vel1F.x;
				ball1.vy = vel1F.y;
			}
		}
		private function checkWall(ball:Ball) {
			var right:Number =stage.stageWidth;
			var bottom:Number =stage.stageHeight;
			if (ball.x-ball.radius<0) {
				ball.x=ball.radius;
				ball.vx*=bounce;
			} else if (ball.x+ball.radius>right) {
				ball.x=right-ball.radius;
				ball.vx*=bounce;
			}
			if (ball.y-ball.radius<0) {
				ball.y=ball.radius;
				ball.vy*=bounce;
			} else if (ball.y+ball.radius>bottom) {
				ball.y=bottom-ball.radius;
				ball.vy*=bounce;
			}
		}
		private function rotate(x:Number, y:Number, sin:Number, cos:Number, reverse:Boolean=true):Point {
			var result:Point = new Point();
			if (reverse) {
				result.x = x * cos + y * sin;
				result.y = y * cos - x * sin;
			} else {
				result.x = x * cos - y * sin;
				result.y = y * cos + x * sin;
			}
			return result;
		}
	}
}