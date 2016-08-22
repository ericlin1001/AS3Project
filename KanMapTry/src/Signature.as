package {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.Sprite;
	public class Signature extends Sprite {
		private var nameTxt:TextField;

		public function Signature(x:Number =0,y:Number =0,name:String ="by 旋风") {
			nameTxt=new TextField();
			addChild(nameTxt)
			nameTxt.text = name;
			nameTxt.selectable = false;
			nameTxt.x=x-47
			nameTxt.y=y-20
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event=null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, resize);
			setPos();
		}
		private function resize(e:Event):void {
			setPos();
			trace("asdf");
		}
		private function setPos():void {
			nameTxt.x = stage.width - 47;
			nameTxt.y = stage.height - 20;
		}
		
	}
}