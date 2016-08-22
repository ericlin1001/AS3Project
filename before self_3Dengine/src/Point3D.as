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