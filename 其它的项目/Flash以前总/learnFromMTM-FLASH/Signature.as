package {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	public class Signature extends Sprite {
		private var nameTxt:TextField;
		private var offx:int = -47;
		private var offy:int = -20;
		public function Signature(x:Number =0,y:Number =0,name:String ="by Eric(nameljh@sina.com)") {
			nameTxt = new TextField();
			nameTxt.autoSize = TextFieldAutoSize.CENTER;
			nameTxt.text = name;
			offx = -nameTxt.width;
			offy = -nameTxt.height;
			addChild(nameTxt);
			locate(x, y);
			if (stage == null) {
				addEventListener(Event.ADDED_TO_STAGE, addToStage);
			}else {
				myResize();
				stage.addEventListener(Event.RESIZE, myResize);
			}
		}
		private function addToStage(e:Event = null):void {
			myResize();
			stage.addEventListener(Event.RESIZE, myResize);
		}
		private function locate(a:int, b:int) {
			nameTxt.x = a+offx;
			nameTxt.y = b+offy;
		}
		private function myResize(e:Event = null):void {
			locate(stage.stageWidth,stage.stageHeight);
		}
	}
}