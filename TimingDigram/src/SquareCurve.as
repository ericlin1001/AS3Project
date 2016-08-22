package  
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class SquareCurve extends BasicCurve
	{
		private var _value:String = "";
		public function SquareCurve() 
		{
			
		}
		public function create(t:String):void {
			value = t;
			for (var i:int = 0; i < t.length; i++) {
				trace(t);
				//trace(t.charAt[i]);
				if(t.charAt(i)=="0"){
					points.push(new Point(i, -0.5));
					points.push(new Point(i+1,-0.5));
				}else {//1
					points.push(new Point(i, 0.5));
					points.push(new Point(i+1,0.5));
				}
			}
		}
		
		public function get value():String { return _value; }
		override public function draw(g:Graphics):void 
		{
			super.draw(g);
		}
		public function set value(value:String):void 
		{
			_value = value;
		}
		
	}
	
}