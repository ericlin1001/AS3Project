package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Eric
	 */
	public class RealWalk extends Sprite
	{
		private var segment0:Segment;
		private var segment1:Segment;
		private var segment2:Segment;
		private var segment3:Segment;
		private var speedSlider:SimpleSlider;
		private var thighRangeSlider:SimpleSlider;
		private var thighBaseSlider:SimpleSlider;
		private var calfRangeSlider:SimpleSlider;
		private var calfOffsetSlider:SimpleSlider;
		private var gravitySlider:SimpleSlider;
		//
		private var cycle:Number = 0;
		private var vx:Number = 10;
		private var vy:Number = 0;
		public function RealWalk() 
		{
			//segment
			segment0 = new Segment(50,15);
			addChild (segment0);
			segment0.x = 200;
			segment0.y = 100;
			segment1 = new Segment(50,15);
			addChild (segment1);
			segment1.positon = segment0.pin;
			segment2 = new Segment(50,15);
			addChild (segment2);
			segment2.x = 200;
			segment2.y = 100;
			segment3 = new Segment(50,15);
			addChild (segment3);
			segment3.x = 200;
			segment3.y = 100;
			//slider
			speedSlider = new SimpleSlider(0.3, 0.12,50);
			addChild (speedSlider );
			speedSlider.x = 10;
			speedSlider.y =30;
			thighBaseSlider = new SimpleSlider(180, 90, 50);
			addChild (thighBaseSlider);
			thighBaseSlider.x = 50;
			thighBaseSlider.y = 30;
			thighRangeSlider = new SimpleSlider(90, 45, 50);
			addChild (thighRangeSlider);
			thighRangeSlider.x = 30;
			thighRangeSlider.y = 30;
			calfRangeSlider = new SimpleSlider(90, 45,50);
			addChild (calfRangeSlider );
			calfRangeSlider.x = 70;
			calfRangeSlider .y = 30;
			calfOffsetSlider = new SimpleSlider(3.14, -1.57,50);
			calfOffsetSlider.value = 3.14;
			addChild (calfOffsetSlider);
			calfOffsetSlider .x = 90;
			calfOffsetSlider.y = 30;
			gravitySlider = new SimpleSlider(0.2, 1,50);
			addChild (gravitySlider);
			gravitySlider.x = 110;
			gravitySlider.y = 30;
			addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			doVelocity();
			walk(segment0, segment1, cycle);
			walk(segment2, segment3, cycle+Math.PI);
			cycle += speedSlider.value;
			checkFloor(segment1);
			checkFloor(segment3);
			checkWall();
		}
		private function doVelocity():void {
			vy += gravitySlider.value;
			segment0.x += vx;
			segment0.y += vy;
			segment2.x += vx;
			segment2.y += vy;
		}
		private function checkFloor(seg:Segment ):void {
			var yMax:Number = seg.getBounds(this).bottom;
			if (yMax > stage.stageHeight) {
				var dy:Number = yMax - stage.stageHeight;
				segment0.y -= dy;
				segment1.y -= dy;
				segment2.y -= dy;
				segment3.y -= dy;
				vx -= seg.vx;
				vy -= seg.vy;
			}
		}
		private function checkWall():void {
			var w:Number = stage.stageWidth + 200;
			if (segment0.x > stage.stageWidth + 100) {
				segment0.x -= w;
				segment1.x -= w;
				segment2.x -= w;
				segment3.x -= w;
			}else if (segment0.x < -100) {
				segment0.x += w;
				segment2.x += w;
				segment3.x += w;
				segment1.x += w;
			}
			
		}
		private function walk(segA:Segment, segB:Segment, cyc:Number):void {
			var foot:Point = segB.pin;
			var angleA:Number = (Math.sin(cyc)+1) * thighRangeSlider.value;
			var angleB:Number = (Math.sin(cyc + calfOffsetSlider.value) + 1) * calfRangeSlider.value;
			segA.rotation = angleA;
			segB.rotation= segA.rotation + angleB;
			segB.positon = segA.pin;
			segB.vx = segB.pin.x - foot.x;
			segB.vy = segB.pin.y - foot.y;
			
		}
	}

}