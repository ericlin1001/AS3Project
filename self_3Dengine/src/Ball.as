package {
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	public class Ball extends Sprite {
		private var _radius:Number;
		private var lineWide:Number;
		public var vx:Number=0;
		public var vy:Number=0;
		public var mass:Number=1;
		private var _color:uint;
		public var pos3D:Point3D;
		public function Ball(radius:Number=30,color:uint=0xff0000,lineWide:Number=0) {
			this.radius=radius;
			this._color=color;
			this.lineWide=lineWide;
			init();
		}
		public function update():void {
			this.x = pos3D.screenX;
			this.y = pos3D.screenY;
			this.scaleX = this.scaleY = pos3D.scale;
		}
		public function get depth():Number {
			return pos3D.depth;
		}
		public function set color(value:uint):void {
			_color=value;
			draw();
		}
		public function get color():uint {
			return _color;
		}
		public function set radius(value:Number):void {
			_radius=value;
			draw();
		}
		public function get radius():Number {
			return _radius;
		}
		private function init():void {
			draw();
		}
		private function draw():void {
			graphics.clear();
			if (lineWide == 0) {
				graphics.lineStyle();
			} else {

				graphics.lineStyle(lineWide);
			}
			var matrix:Matrix=new Matrix  ;
			matrix.createGradientBox(_radius * 2,_radius * 2,0,- _radius + _radius / 3,- _radius - _radius / 2.5);
			graphics.beginGradientFill(GradientType.RADIAL, [0xffffff, _color*0xdd/0xff,_color*0x88/0xff], [1,1, 1], [0,90, 255], matrix);
			graphics.drawCircle(0,0,_radius);
			graphics.endFill();
		}
	}
}