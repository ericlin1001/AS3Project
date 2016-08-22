package  
{
	/**
	 * ...
	 * @author ...
	 */
	import flash.display.Graphics;
	public class Union 
	{
		private var _points:Array;
		private var _triangles:Array;
		private var _light:Light;
		public function Union(points:Array,triangels:Array,tlight:Light=null) 
		{
			this._points = points;
			this._triangles = triangels;
			if (tlight == null) {
				light == new Light(1, 1, 1) ;
			}else{
				light = tlight;
			}
		}
		public function draw(g:Graphics, color:uint = 0xff0000):void {
			_triangles.sortOn("depth", Array.NUMERIC | Array.DESCENDING);
			for (var i:int = 0; i< _triangles.length; i++) {
				var item:Triangle = _triangles[i] as Triangle;
				item.draw(g, color);
			}
		}
		public function moveTo(p:Point3D):void {
			for (var i:int = 0; i < _points.length; i++) 
			{
				var item:Point3D = _points[i]as Point3D;
				item.x += p.x;
				item.y += p.y;
				item.z += p.z;
				
			}
		}
		public function setCenter(tx:Number, ty:Number, tz:Number):void {
			for (var i:int = 0; i < _points.length; i++) 
			{
				var item:Point3D = _points[i]as Point3D;
				item.setCenter(tx, ty, tz);
			}
		}
		public function setVanishPoint(tx:Number, ty:Number):void{
			for (var i:int = 0; i < _points.length; i++) 
			{
				var item:Point3D = _points[i]as Point3D;
				item.setVanishPoint(tx, ty);
			}
		}
		public function rotationX(angle:Number):void {
			for (var i:int = 0; i < _points.length; i++) 
			{
				var item:Point3D = _points[i]as Point3D;
				//trace("call Union:rotationX");
				item.rotationX(angle);
			}
		}
		public function rotationY(angle:Number):void {
			for (var i:int = 0; i < _points.length; i++) 
			{
				var item:Point3D = _points[i]as Point3D;
				item.rotationY(angle);
			}
		}
		public function rotationZ(angle:Number):void {
			for (var i:int = 0; i < _points.length; i++) 
			{
				var item:Point3D = _points[i] as Point3D;
				item.rotationZ(angle);
			}
		}
		public function get points():Array 
		{
			return _points;
		}
		
		public function set points(value:Array):void 
		{
			_points = value;
		}
		
		public function get triangles():Array 
		{
			return _triangles;
		}
		
		public function set triangles(value:Array):void 
		{
			_triangles = value;
		}
		
		public function get light():Light 
		{
			return _light;
		}
		
		public function set light(value:Light):void 
		{
			_light = value;
			for (var i:int = 0; i< _triangles.length; i++) {
				var item:Triangle = _triangles[i] as Triangle;
				item.light = _light;
			}
		}
		
	}

}