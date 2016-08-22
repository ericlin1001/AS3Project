package  
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Eric
	 */
	public class Walking extends Sprite
	{
		private var slider1:SimpleSlider ;
		private var slider2:SimpleSlider ;
		private var leftLeg1:Segment;
		private var leftLeg2:Segment;
		private var rightLeg1:Segment;
		private var rightLeg2:Segment;
		//
		private var cycle:Number=0;
		private var offset:Number = 56;
		public function Walking() 
		{
			//init slider:
			slider1 = new SimpleSlider ( -90, 90,400);
			addChild (slider1);
			slider1.x = 20;
			slider1.y = 200;
			slider2 = new SimpleSlider ( -90,90, 400);
			addChild (slider2);
			slider2.x = 60;
			slider2.y = 200;
			//
			var xpos:Number = 200;
			var ypos:Number=150
			//leftLeg
			leftLeg1 = new Segment();
			addChild (leftLeg1);
			leftLeg1.x = xpos;
			leftLeg1.y =  ypos;
			leftLeg2 = new Segment ();
			addChild (leftLeg2);
			leftLeg2.x = leftLeg1.pin.x
			leftLeg2.y = leftLeg1.pin.y;
			//rightLeg
			rightLeg1 = new Segment();
			addChild (rightLeg1);
			rightLeg1.x = xpos;
			rightLeg1.y =  ypos;
			rightLeg2 = new Segment ();
			addChild (rightLeg2);
			rightLeg2.x = rightLeg1.pin.x
			rightLeg2.y = rightLeg1.pin.y;
			//
			var updateTimer:Timer = new Timer(1000 / 50);
			updateTimer.start ();
			updateTimer.addEventListener (TimerEvent.TIMER,update);
			slider1.addEventListener(SliderEvent.CHANGE, onChange);
			slider2.addEventListener(SliderEvent.CHANGE, onChange);
		}
		private function update(e:TimerEvent):void {
			var speed:Number = 0.05
			var range:Number = 60
			var range2:Number =40
			var offset:Number = 90;
			var sinOff:Number = 0.7
			cycle += speed;
			walk (leftLeg1, leftLeg2, cycle);
			walk(rightLeg1, rightLeg2, cycle + Math.PI);
		}
		private function walk(segmentA:Segment, segmentB:Segment, cyc:Number ):void {
			segmentA.rotation = Math.sin(cyc) * 45 + 90;
			segmentB.rotation = Math.sin (cyc + offset) * 45 + 45;
			segmentB.positon = segmentA.pin;
		}
		private function onChange(e:SliderEvent):void {
		/*	segment1.rotation = slider1.value
			segment2.x = segment1.pin.x
			segment2.y = segment1.pin.y;
			segment2.rotation = segment1.rotation + slider2.value;
			trace (e.message );*/
			offset = slider1.value /100+56;
		}
		
		
	}

}