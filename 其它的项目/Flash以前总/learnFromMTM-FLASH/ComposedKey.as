package {
	//37 38 39 40 left up right down
	//97 98 99 one two three 
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	import flash.display.Sprite;
	public class ComposedKey extends Sprite {
		private var _delay:Number=0.25*1000;
		private var _oldTimer:Number=0;
		private var action:String="";
		public function ComposedKey() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN ,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP ,onKeyUp);
			_oldTimer=getTimer();
			trace(_oldTimer);
		}
		private function onKeyDown(event:KeyboardEvent):void {
			var bet:Number=getTimer()-_oldTimer;
			var keypress:String="";
			if (bet>_delay) {
				action="";
			}
			switch (event.keyCode) {
				case 37 :
					keypress="Left";
					break;
				case 38 :
					keypress="Up";
					break;
				case 39 :
					keypress="Right";
					break;
				case 40 :
					keypress="Down";
					break;
				case 97 :
					keypress="One";
					break;
				case 98 :
					keypress="Two";
					break;
				case 99 :
					keypress="Three";
					break;
				default :
					break;
			}
			action+=keypress;
			_oldTimer=getTimer();
release()
		}
		private function onKeyUp(event:KeyboardEvent):void {

			//trace(event.getCode().toString())   
		}
		public function release() {
			var key1:String="DownRightDownRightOne";
			switch (action) {
				case key1 :
					trace("release1");
					break;
				default :
					break;
			}


		}
	}
}