package {
	import flash.display.Sprite;
		import flash.events.Event;
	public class SpringstickTest extends Sprite {
private var springstick:Springstick
		public function SpringstickTest() {
			 springstick=new Springstick(new VerletPoint(70,10),new VerletPoint(330,10))
			springstick.length=150
			springstick.draw(graphics)
			springstick.length=springstick.length
			addEventListener(Event.ENTER_FRAME ,onEnterFrame);
		}
		private function onEnterFrame(evnt:Event):void {
		springstick.update()
		graphics.clear()
		springstick.draw(graphics)
		}
	}
}