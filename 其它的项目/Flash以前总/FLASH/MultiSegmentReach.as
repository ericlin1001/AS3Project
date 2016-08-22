package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	public class MultiSegmentReach extends Sprite {
		private var segments:Array;
		private var numSegments:uint = 22;
		private var ball:Ball;
		private var gravity:Number = 0.5;
		private var bounce:Number = -1;
		private var speed:Number =0
		private var n:Number =0;
		public function MultiSegmentReach() {
			init();
		}
		private function init():void {
			stage.scaleMode=StageScaleMode.NO_SCALE ;
			stage.align=StageAlign.TOP_LEFT ;
			ball = new Ball(20,0);
			ball.vx =10
			ball.vy =10
			addChild(ball);
			segments = new Array();
			for (var i:uint = 0; i < numSegments; i++) {
				var segment:Segment = new Segment(50, 10);
				addChild(segment);
				segments.push(segment);

			}
			// 将最后一个的位置设置到舞台中心
			segment.x = stage.stageWidth / 2+200;
			segment.y = stage.stageHeight / 2+200;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			moveBall();
			
				var target:Point = reach(segments[0], ball.x, ball.y);
				for (var i:uint = 1; i < numSegments; i++) {

					var segment:Segment = segments[i];
					target = reach(segment, target.x, target.y);
				}
				for (i = numSegments - 1; i > 0; i--) {
					var segmentA:Segment = segments[i];
					var segmentB:Segment = segments[i - 1];
					position(segmentB, segmentA);
				}
			
		}
		private function moveBall():void {
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			if (ball.x + ball.radius > stage.stageWidth) {
				ball.x = stage.stageWidth - ball.radius;
				ball.vx *= bounce;
			} else if (ball.x - ball.radius < 0) {
				ball.x = ball.radius;
				ball.vx *= bounce;
			}
			if (ball.y + ball.radius > stage.stageHeight) {
				ball.y = stage.stageHeight - ball.radius;
				ball.vy *= bounce;
			} else if (ball.y - ball.radius < 0) {
				ball.y = ball.radius;
				ball.vy *= bounce;
			}
		}
		private function reach(segment:Segment, xpos:Number, ypos:Number):Point {
			var dx:Number = xpos - segment.x;
			var dy:Number = ypos - segment.y;
			var angle:Number = Math.atan2(dy, dx);
			segment.rotation = angle * 180 / Math.PI;
			var w:Number = segment.getPin().x - segment.x;
			var h:Number = segment.getPin().y - segment.y;
			var tx:Number = xpos - w;
			var ty:Number = ypos - h;
			return new Point(tx,ty);
		}
		private function position(segmentA:Segment,
		segmentB:Segment):void {
			segmentA.x = segmentB.getPin().x;
			segmentA.y = segmentB.getPin().y;
		}
	}
}