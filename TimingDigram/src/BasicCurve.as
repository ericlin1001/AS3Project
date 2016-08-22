package  
{
	import flash.display.ActionScriptVersion;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class BasicCurve 
	{
		
		//
		private var _screenPoints:Array = new Array();
		protected var _points:Array = new Array();
		private var isScreenPointCreate:Boolean = false;
		private var _coord:Coord;
		public function BasicCurve() 
		{
			
		}
		
		public function getAverageY():Number {
			var ay:Number = 0;
			for (var i:uint = 0; i < screenPoints.length; i++) {
				var point:Point = screenPoints[i] as Point;
				ay += point.y;
			}
			ay /= screenPoints.length;
			return ay;
		}
		public function draw(g:Graphics):void {
			if (screenPoints.length != 0) g.moveTo(screenPoints[0].x, screenPoints[0].y);
			for (var i:uint = 0; i < screenPoints.length; i++) {
				var point:Point = screenPoints[i] as Point;
				g.lineTo(point.x, point.y);
			}
		}
		private function createScreenPoint():void {
			_screenPoints = new Array();
			for (var i:uint = 0; i < points.length; i++) {
				_screenPoints.push(toScreen(points[i]));
			}
			isScreenPointCreate = true;
		}
		public function get points():Array { isScreenPointCreate = false;return _points; }
		public function set points(value:Array):void 
		{
			_points = value;
			isScreenPointCreate = false;
		}
		private function get screenPoints():Array {
			if (!isScreenPointCreate) createScreenPoint(); 
			return _screenPoints; 
		}
		
		public function get coord():Coord { return _coord; }
		
		public function set coord(value:Coord):void 
		{
			_coord = value;
		}
		private  function toScreen(p:Point):Point {
			return coord.toScreen(p);
		}
	}
	
}