package  
{
	/**
	 * ...
	 * @author Eric
	 */
	public class Point3D 
	{
		public var fl:Number = 250;
		private var _x:Number=0;
		private var _y:Number=0;
		private var _z:Number=0;
		private var cx:Number=0;
		private var cy:Number=0;
		private var cz:Number=0;
		private var vpx:Number=200;
		private var vpy:Number=200;
		public function Point3D(x:Number=0,y:Number=0,z:Number=0) 
		{
			_x = x;
			_y = y;
			_z = z;
		}
		/**/public function trans(matrix:Matrix):void {
			var t:Matrix = new Matrix(3, 1);
			t.assign(0, 0, x);
			t.assign(1, 0, y);
			t.assign(2, 0, z);
			t = matrix.multi(t);
			if (t != null) {
				x = t.getEle(0, 0);
				y = t.getEle(1, 0);
				z = t.getEle(2, 0);
			}else {
				trace("error can't trans in point3D");
			}
		}
		public function toString():String {
			return "[ Point3D ]:[ x: " + x + " y: " + y + " z: " + z+" ] ";
		}
		public function rotationX(angle:Number):void {
		//	trace("call Point3D:rotationX");
			var sin:Number = Math.sin(angle / 180 * Math.PI);
			var cos:Number = Math.cos (angle / 180 * Math.PI);
			var y1:Number = cos * _y - sin * _z;
			var z1:Number = cos * _z + sin * _y;
			_y = y1;
			_z = z1;
		}
		public function rotationY(angle:Number):void {
			var sina:Number = Math.sin(angle / 180 * Math.PI);
			var cosa:Number = Math.cos(angle / 180 * Math.PI);
			var z1:Number = cosa * _z - sina * _x;
			var x1:Number = cosa * _x+ sina * _z;
			_z = z1;
			_x = x1;
		}
		public function rotationZ(angle:Number):void {
			var sin:Number = Math.sin(angle / 180 * Math.PI);
			var cos:Number = Math.cos (angle / 180 * Math.PI);
			var x1:Number = cos * _x - sin * _y;
			var y1:Number = cos * _y + sin * _x;
			_x = x1;
			_y = y1;
		}
		public function get screenX():Number {
			return _x * scale+ cx+vpx;
		}
		public function get screenY():Number {
			return _y *scale+ cy+vpy;
		}
		public function get scale():Number {
			return fl / (fl + _z + cz);
		}
		public function get depth():Number {
			return _z + cz;
		}
		public function setCenter(tx:Number, ty:Number, tz:Number):void {
			cx = tx;
			cy = ty;
			cz = tz;
		}
		public function setVanishPoint(tx:Number, ty:Number):void{
			vpx = tx;
			vpy = ty;
		}
		public function equal(p:Point3D):Boolean
		{
			return (x == p.x) && (y == p.y) && (z == p.z);
		}
		public function add(p:Point3D):Point3D {
			return new Point3D(x + p.x, y + p.y, z + p.z);
		}
		public function sub(p:Point3D):Point3D {
			return new Point3D(x - p.x, y - p.y, z - p.z);
		}
		public function multiConst(a:Number):Point3D {
			return new Point3D(x * a, y * a, z * a);
		}
		public function dividConst(a:Number):Point3D {
			return new Point3D(x / a, y / a, z / a);
		}
		public function dist(p:Point3D):Number {
			return sub(p).length;
		}
		public function get length():Number {
			return Math.sqrt(x * x + y * y + z * z);
		}
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function get z():Number 
		{
			return _z;
		}
		
		public function set z(value:Number):void 
		{
			_z = value;
		}
		
	}

}