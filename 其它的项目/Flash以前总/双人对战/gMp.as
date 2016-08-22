package {
		import flash.text.TextFormat 
	import flash.display.Sprite;
	import flash.text.TextField;
	public class gMp extends Sprite {
		private var _len:Number ;
		private var mc:Sprite;
		private var mp_txt:TextField;
		public function gMp(tlen:Number=100 ) {
			mc=new Sprite ();
			mp_txt=new TextField();
			mp_txt.textColor=0x0000ff;
			mp_txt.text="Mp";
			var t:TextFormat =new TextFormat()
			t.size =15
			mp_txt.setTextFormat(t);
			mp_txt.selectable=false;
			mp_txt.x=0;
			mp_txt.y=0;
			mc.x=22;
			mc.y=5;
			addChild(mp_txt);
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
					graphics.beginFill(0x0000ff);
					graphics.drawRect(0,0,tlen,8);
					graphics.endFill();
					graphics.lineStyle(1,0x000000);
					graphics.drawRect(0,0,100,8);
				}
			}
		}
	}
}