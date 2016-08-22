package {
	import flash.display.Sprite;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class DragBounce extends Sprite {
		private var ball:Ball;
		private var bounce:Number =-1
		private var gravity:Number =1
		private var friction :Number =1
private var a :Number =6.5
		public function DragBounce() {
			init();
		}
		private function init() {
			stage.scaleMode=StageScaleMode.NO_SCALE ;
			stage.align=StageAlign.TOP_LEFT ;
			ball=new Ball(20);
			addChild(ball);

			ball.x=stage.stageWidth/2;
			ball.y=stage.stageHeight/2;
			ball.vx=a*(Math.random ()*20-10)
			ball.vy=a*(Math.random ()*20-10)



			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			/*ball.addEventListener(MouseEvent.MOUSE_DOWN ,onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP ,onMouseUp);*/
		}
		private function onEnterFrame(event:Event):void {
			ball.vy += gravity;
			ball.vy *= friction ;
			ball.vx *= friction ;
			ball.x += ball.vx;
			ball.y += ball.vy;
			checkWalls(ball);
		}
		private function checkWalls(balla:Ball) {
			var top:Number =0;
			var bottom:Number =stage.stageHeight;
			var right:Number =stage.stageWidth;
			var left:Number =0;
			if (balla.x+balla.r>right) {
				balla.x=right-balla.r;
				balla.vx*=bounce;
				trace(balla.x+balla.r+"    right:  "+right)
			} else if (balla.x-balla.r<left) {
				balla.x=left+balla.r;
				balla.vx*=bounce;
			}
			if (balla.y+balla.r>bottom) {
				balla.y=bottom-balla.r;
				balla.vy*=bounce;
			} else if (balla.y-balla.r<top) {
				balla.y=top+balla.r;
				balla.vy*=bounce;
			}
		}
		private function onMouseDown(event:Event):void {
			ball.startDrag();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onMouseUp(event:Event):void {
			ball.stopDrag();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}