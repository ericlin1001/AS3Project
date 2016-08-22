package  
{
	/**
	 * ...
	 * @author Eric
	 */
	public class Light 
	{
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		private var _lightness:Number;
		public function Light(x:Number=0,y:Number=0,z:Number=0,lightness:Number=1) 
		{
			this._x = x;
			this._y = y;
			this._z = z;
			this.lightness = lightness;
		}
		
		public function get lightness():Number 
		{
			return _lightness;
		}
		
		public function set lightness(value:Number):void 
		{
			_lightness = Math.min(Math.max (value, 0), 1);
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