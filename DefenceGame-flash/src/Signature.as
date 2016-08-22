package {
	//addChild(new Signature(stage.stageWidth,stage.stageHeight));
	import flash.text.TextField;
	import flash.display.Sprite;
	public class Signature extends Sprite {
		private var nameTxt:TextField;

		public function Signature(x:Number=0,y:Number =0,name:String ="by 旋风Eric") {
			nameTxt=new TextField();
			addChild(nameTxt)
			nameTxt.text = name;
			nameTxt.selectable = false;
			nameTxt.x=x-65;
			nameTxt.y=y-20;
			
		}
	}
}