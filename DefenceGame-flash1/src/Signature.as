package {
	//addChild(new Signature(stage.stageWidth,stage.stageHeight));
	import flash.text.TextField;
	import flash.display.Sprite;
	public class Signature extends Sprite {
		private var nameTxt:TextField;
		public function Signature(tx:Number=0,ty:Number =0,tname:String ="by 旋风Eric") {
			nameTxt=new TextField();
			addChild(nameTxt)
			nameTxt.text =tname;
			nameTxt.selectable = false;
			if(stage!=null){
				tx=stage.stageWidth;
				ty=stage.stageHeight;
			}
			nameTxt.x=tx-65;
			nameTxt.y=ty-20;
			trace("has signatured.");
		}
	}
}