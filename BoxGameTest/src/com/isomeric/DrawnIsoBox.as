//DrawnIsoBox
package com.isomeric {
	import com.isomeric.DrawnIsoBox ;
	import flash.display.Shape;
	import flash.display.Graphics;
	public class DrawnIsoBox extends DrawnIsoTile {
		protected var _height:Number;
		private var up:Shape;
		private var left:Shape;
		private var right:Shape;
		public function DrawnIsoBox(tsize:Number,tcolor:uint,h:Number=0) {
			up = new Shape();
			left = new Shape();
			right = new Shape();
			addChild(up);
			addChild(left);
			addChild(right);
			_height=h;
			super(tsize, tcolor );
			draw();
		}
		override protected function draw():void {
			var h:Number=_height*IsoUtilis.Y_CORRECT;
			var red:uint=_color>>16;
			var green:uint=_color>>8&0xff;
			var blue:uint=_color&0xff;
			var per:Number=0.7;
			red*=per;
			green*=per;
			blue*=per;
			var rightColor:uint=red<<16|green<<8|blue;
			red*=per;
			green*=per;
			blue*=per;
			var leftColor:uint=red<<16|green<<8|blue;
			//the light is in the up and right;
			//up 
			up.graphics.clear();
			up.graphics.lineStyle(0, 0, 0.5);
			up.graphics.beginFill(_color);
			up.graphics.moveTo(-size, 0-h);
			up.graphics.lineTo(0, size * 0.5-h);
			up.graphics.lineTo(size, 0-h);
			up.graphics.lineTo(0, -size * 0.5-h);
			up.graphics.lineTo( -size, 0-h);
			up.graphics.endFill();

			//right
			right.graphics.clear();
			right.graphics.lineStyle(0, 0, 0.5);
			right.graphics.beginFill(rightColor);
			right.graphics.moveTo(0, size * 0.5);
			right.graphics.lineTo(size, 0);
			right.graphics.lineTo(size,0-h);
			right.graphics.lineTo(0, size * 0.5-h);
			right.graphics.lineTo(0, size * 0.5);
			right.graphics.endFill();

			//left
			left.graphics.clear();
			left.graphics.lineStyle(0, 0, 0.5);
			left.graphics.beginFill(leftColor);
			left.graphics.moveTo( -size, 0);
			left.graphics.lineTo(0, size * 0.5);
			left.graphics.lineTo(0, size * 0.5-h);
			left.graphics.lineTo( -size, 0-h);
			left.graphics.lineTo( -size, 0);
			left.graphics.endFill();
		}
		//getter
		override public function get height():Number {
			return _height;
		}
		//setter
		override public function set height(value:Number):void {
			_height=value;
			draw();
		}
	}
}