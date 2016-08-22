package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Eric
	 */
	public class TwoSegment extends Sprite
	{
		private var slider1:SimpleSlider ;
		private var slider2:SimpleSlider ;
		private var segment1:Segment;
		private var segment2:Segment;
		public function TwoSegment() 
		{
			//init slider:
			slider1 = new SimpleSlider ( -90, 90,100);
			addChild (slider1);
			slider1.x = 20;
			slider1.y = 60;
			slider2 = new SimpleSlider ( -90,90, 100);
			addChild (slider2);
			slider2.x = 60;
			slider2.y = 60;
			//init segment:
			segment1 = new Segment();
			addChild (segment1);
			segment1.x = 100;
			segment1.y = 200;
			segment2 = new Segment ();
			addChild (segment2);
			segment2.x = segment1.pin.x
			segment2.y = segment1.pin.y;
			//
			slider1.addEventListener(SliderEvent.CHANGE, onChange);
			slider2.addEventListener(SliderEvent.CHANGE, onChange);
		}
		private function onChange(e:SliderEvent):void {
			segment1.rotation = slider1.value
				segment2.x = segment1.pin.x
			segment2.y = segment1.pin.y;
			segment2.rotation = segment1.rotation + slider2.value;
			trace (e.message );
		}
	}

}