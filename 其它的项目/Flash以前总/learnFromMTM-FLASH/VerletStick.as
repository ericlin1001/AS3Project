package {
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	public class VerletStick {
		private var rect:Rectangle;
		private var pointA:VerletPoint;
		private var pointB:VerletPoint;
		private var _length:Number;
		public function VerletStick(pointa:VerletPoint,pointb:VerletPoint,len:Number=-1) {
			pointA=pointa;
			pointB=pointb;
			rect=new Rectangle();
			length=len
		}
		public function clone():VerletStick{
			return new VerletStick(pointA,pointB)
		}
		public function update() {
			var dx:Number=pointA.x-pointB.x;
			var dy:Number=pointA.y-pointB.y;
			var dist:Number=Math.sqrt(dx*dx+dy*dy);
			var diff:Number=dist-_length;
			var offsetx:Number=diff*dx/dist/2;
			var offsety:Number=diff*dy/dist/2;
			pointA.x-=offsetx;
			pointA.y-=offsety;
			pointB.x+=offsetx;
			pointB.y+=offsety
			;
		}
		public function draw(g:Graphics ) {
			g.lineStyle(0);
			g.moveTo(pointA.x,pointA.y);
			g.lineTo(pointB.x,pointB.y);
		}

		public function get length() {
			return _length;
		}
		public function get pointa() {
			return pointA;
		}
		public function get pointb() {
			return pointB;
		}

		public function set length(value:Number) {
			if (value==-1) {
				var dx:Number=pointA.x-pointB.x;
				var dy:Number=pointA.y-pointB.y;
				_length= Math.sqrt(dx*dx+dy*dy);
			} else {
				_length=value;
			}
		}
	}
}