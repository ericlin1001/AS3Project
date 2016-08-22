package {
	import flash.text.TextField;
	import flash.display.Sprite;
	public class Signature extends Sprite {
		private var nameTxt:TextField;
		public function Signature(x:Number =0,y:Number =0,name:String ="by 旋风") {
			nameTxt=new TextField();
			nameTxt.selectable=false;
			addChild(nameTxt)
			nameTxt.text=name;
			nameTxt.x=x-47
			nameTxt.y=y-20
			;
		}
	}
}