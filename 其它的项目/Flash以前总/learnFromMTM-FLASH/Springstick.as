package {
	import flash.display.Graphics;
	public class Springstick {
		private var _pointA:VerletPoint;
		private var _pointB:VerletPoint;
		private var _length:Number;
		private var _wide:Number=5
		private var num:Number=50
		private var k:Number =0.01
		public function Springstick(pa:VerletPoint,pb:VerletPoint) {
			_pointA=pa
			_pointB=pb
			var dx=_pointB.x-_pointA.x;
			var dy=_pointB.y-_pointA.y;
			_length=Math.sqrt(dx*dx+dy*dy);
		}
		public function update():void{
			var dx=_pointB.x-_pointA.x;
			var dy=_pointB.y-_pointA.y;
			var dist=Math.sqrt(dx*dx+dy*dy);
			var diff=dist-_length
			diff*=k
			var sin=dy/dist;
			var cos=dx/dist;
			_pointA.vx=_pointA.vx+diff*cos
			_pointA.vy=_pointA.vy+diff*sin
			_pointB.vx=_pointB.vx-diff*cos
			_pointB.vy=_pointB.vy-diff*sin
			_pointA.update()
			_pointB.update()
		}
		public function draw(g:Graphics) {
			trace("1")
			var dx=_pointB.x-_pointA.x;
			var dy=_pointB.y-_pointA.y;
			var dist=Math.sqrt(dx*dx+dy*dy);
			var sin=dy/dist;
			var cos=dx/dist;
			var perlen=dist/num;
			g.lineStyle(0);
			g.moveTo(_pointA.x,_pointA.y);
			for (var i=0; i<num-1; i+=2) {
				var tx=perlen/2*cos+_pointA.x+i*perlen*cos+_wide*sin;
				var ty=perlen/2*sin+_pointA.y+i*perlen*sin-_wide*cos;
				g.lineTo(tx,ty);
				tx=perlen/2*cos+_pointA.x+(i+1)*perlen*cos-_wide*sin;
				ty=perlen/2*sin+_pointA.y+(i+1)*perlen*sin+_wide*cos;
				g.lineTo(tx,ty);
			}
			g.lineTo(_pointB.x,_pointB.y);
			_pointA.draw(g)
			_pointB.draw(g)
		}
		public function get length():Number {
			return _length;
		}
		public function set length(value:Number) {
			_length=value;
		}
				public function get pointA():VerletPoint {
			return _pointA
		}
		public function get pointB():VerletPoint {
			return _pointB
		}
	}
}