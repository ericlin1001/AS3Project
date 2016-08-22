package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	public class model0 extends Sprite {

		public function model0() {
			init();
		}
		private function init() {



			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN ,onMouseDown);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		private function onEnterFrame(event:Event):void {


		}
		private function onMouseDown(event:Event):void {

		}
		private function onKeyDown(evt:KeyboardEvent) {
			switch (evt.keyCode) {

				case Keyboard.DOWN :

					break;
				default :

					break;
			}
		}
	}
}