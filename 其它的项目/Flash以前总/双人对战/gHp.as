package {
	import flash.text.TextFormat 
	import flash.display.Sprite;
	import flash.text.TextField;
	public class gHp extends Sprite {
		private var _len:Number ;
		private var mc:Sprite;
		private var hp_txt:TextField;
		public function gHp(tlen:Number=100 ) {
			mc=new Sprite ();
			hp_txt=new TextField();
			hp_txt.textColor=0xff0000;
			hp_txt.text="Hp";
			var t:TextFormat =new TextFormat()
			t.size =15
			hp_txt.setTextFormat(t);
			hp_txt.selectable=false;
			hp_txt.x=0;
			hp_txt.y=0;
			mc.x=22;
			mc.y=5;
			addChild(hp_txt);
			addChild(mc);
			_len=tlen;
			setlen(_len);
		}
		public function get len():Number {
			return _len;
		}
		public function set len(value:Number ){
			_len=value;
			setlen(_len);
		}
		private function setlen(tlen:Number) {
			if (tlen>0) {
				with (mc) {
					graphics.clear();
					graphics.beginFill(0xff0000);
					graphics.drawRect(0,0,tlen,8);
					graphics.endFill();
					graphics.lineStyle(1,0x000000);
					graphics.drawRect(0,0,100,8);
				}
			}
		}
	}
}