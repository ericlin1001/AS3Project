package {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.Graphics;
	import flash.events.Event;
	public class Test extends Sprite {
		private var points:Array;
		private var sticks:Array;
		private var rect:Rectangle;
		public function Test() {
			points=new Array();
			sticks=new Array();
			var w=stage.stageWidth+1;
			var h=stage.stageHeight+1;
			rect=new Rectangle(0,0,w,h);
			var pointA=makepoint(0,h);
			var pointB=makepoint(w,h);
			var pointC=makepoint(w/2,h-300);
			var a =100
			var pointD=makepoint(w/2+150+a,h-300);
			var pointE=makepoint(w/2+160+a,h-310);
			var pointF=makepoint(w/2+160+a,h-290);
			makestick(pointA,pointB);
			makestick(pointB,pointC);
			makestick(pointC,pointA);
			makestick(pointC,pointD);
			makestick(pointD,pointE);
			makestick(pointE,pointF);
			makestick(pointF,pointD);
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
				point.y+=0.5
				
			}
			for ( var j=0; j<7; j++) {
			for ( i=0; i<points.length; i++) {
				var point:VerletPoint=points[i];
				point.update();
				point.constrain(rect);
			}
			for (i=0; i<sticks.length; i++) {
				sticks[i].update();
			}
			}
			graphics.clear();
			for (i=0; i<points.length; i++) {
				points[i].draw(graphics);
			}

			for (i=0; i<sticks.length; i++) {
				sticks[i].draw(graphics);
			}


		}

	}
}