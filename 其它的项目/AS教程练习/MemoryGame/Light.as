package {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	//
	public class Light extends Sprite {
		public static const OFF:String="off";
		public static const ON:String="on";
		public var num:uint=0;
		protected var _status:String=OFF;
		protected var greyColor:Shape;
		protected var lightColor:Shape;
		//
		public function Light(tcolor:uint=0xff0000,tradius:Number=30) {
			lightColor=new Shape();
			var g:Graphics=lightColor.graphics;
			g.clear();
			g.lineStyle();
			g.beginFill(tcolor);
			g.drawCircle(0,0,tradius);
			g.endFill();
			addChild(lightColor);
			//
			greyColor=new Shape();
			g=greyColor.graphics;
			g.clear();
			g.lineStyle();
			g.beginFill(0xcccccc);
			g.drawCircle(0,0,tradius);
			g.endFill();
			greyColor.alpha=0.85;
			addChild(greyColor);
			//
			_status=OFF;
			num=0;
		}
		//
		public function on():void {
			if (_status!=ON) {
				removeChild(greyColor);
				_status=ON;
			}
		}
		public function off():void {
			if (_status!=OFF) {
				addChild(greyColor);
				_status=OFF;
			}
		}
		public function get status():String {
			return _status;
		}
		public function set status(value:String) {
			if (value==OFF) {
				off();
			}
			if (value==ON) {
				on();
			}
		}

	}
}