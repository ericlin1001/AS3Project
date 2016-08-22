package {
	import flash.display.Sprite;
	import flash.events.Event;
	public class RotateToMouse extends Sprite {
		private var arrow:Arrow;
		public function RotateToMouse() {
			init();
		}
		private function init():void {
			arrow=new Arrow();
			addChild(arrow);
			arrow.x=stage.stageWidth/2;
			arrow.y=stage.stageHeight/2;
			addEventListener(Event.ENTER_FRAME ,onEnterFrame);
		}
		private function onEnterFrame(event:Event) {
			var dx:Number =mouseX-arrow.x;
			var dy:Number =mouseY-arrow.y;
			arrow.rotation=Math.atan2 (dy,dx)*180/Math.PI 
		}
	}
}