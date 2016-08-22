package {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.Graphics;
	import flash.events.Event;
	public class Test extends Sprite {
		private var points:Array;
		private var sticks:Array;
		private var rect:Rectangle;
		public function Test2() {
			points=new Array();
			sticks=new Array();
			rect=new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			var  pointA=makepoint(10,10);
			var  pointB=makepoint(40,10);
			var  pointC=makepoint(40,40);
			var  pointD=makepoint(10,40);

			makestick(pointA,pointB);
			makestick(pointB,pointC);
			makestick(pointC,pointD);
			makestick(pointD,pointA);
			makestick(pointA,pointC);
			addEventListener(Event.ENTER_FRAME ,onEnterFrame);
		}
		private function makestick(pa:VerletPoint,pb:VerletPoint):void {
			var stick:VerletStick=new VerletStick(pa,pb);
			sticks.push(stick);
			//points.push (pb)
		}
		private function makepoint(a:Number ,b:Number ):VerletPoint {
			var point:VerletPoint=new VerletPoint(a,b);
			points.push(point);
			return point;
			//points.push (pb)
		}
		private function onEnterFrame(evnt:Event):void {
			/*pointA.y+=.5
			pointB.y+=.2*/
			for (var i=0; i<points.length; i++) {
				var point:VerletPoint=points[i];
				point.y+=0.5;
				point.update();
				point.constrain(rect);
			}
			for ( i=0; i<sticks.length; i++) {
				sticks[i].update();
			}

			graphics.clear();
			for ( i=0; i<points.length; i++) {
				points[i].draw(graphics);
			}

			for (i=0; i<sticks.length; i++) {
				sticks[i].draw(graphics);
			}


		}

	}
}