package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class EventDemo extends Sprite {
		private var eventSprite:Sprite;
		public function EventDemo() {
			init();
		}
		private function init():void {
			eventSprite = new Sprite();
			addChild(eventSprite);
			eventSprite.graphics.beginFill(0xff0000);
			eventSprite.graphics.drawCircle(0, 0, 100);
			eventSprite.graphics.endFill();
			eventSprite.x = stage.stageWidth / 2;
			eventSprite.y = stage.stageHeight / 2;
			eventSprite.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			eventSprite.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		private function onMouseDown(evt:MouseEvent):void {
			trace("mouse down");
		}
		private function onMouseUp(evt:MouseEvent):void {
			trace("mouse up");
		}
	}
}