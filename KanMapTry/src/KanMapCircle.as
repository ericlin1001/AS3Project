package  
{
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class KanMapCircle 
	{
		private var _leftTop:Array = new Array(2);
		//private var _rightBottom:Array = new Array(2);
		private var _vector:Array = new Array(2);
		public function KanMapCircle(lefttopa:Array=null,rightbottomb:Array=null) 
		{
			if (leftTop == null) leftTop = [0, 0];
			if (rightBottom == null) rightBottom = [0, 0];
			leftTop =lefttopa;
			rightBottom =rightbottomb;
		}
		public function toString():String {
			var t:String = "";
			t = "[(" + leftTop[0] + "," + leftTop[1] + "),(" + rightBottom[0] + "," + rightBottom[1] + ")]";;
			return t;
		}
		public function clone():KanMapCircle {
			var t:KanMapCircle = new KanMapCircle(leftTop, rightBottom);
			return t;
		}
		public function setStartPoint(a:Array):KanMapCircle {
			leftTop = a;
			return this;
		}
		public function getIteraMaxCol():int {
			if (rightBottom[1] >= 3) return 0;
			return 3;
		}
		public function getIteraMaxRow():int {
			if (rightBottom[0] >= 3) return 0;
			return 3;
		}
		public function get leftTop():Array { return _leftTop; }
		
		public function set leftTop(value:Array):void 
		{
			_leftTop = value;
		}
		static public function add(a:Array, b:Array):Array {
			var c:Array = new Array(2);
			c[0] = a[0] + b[0];
			c[1] = a[1] + b[1];
			return c;
		}
		static public function substract(a:Array, b:Array):Array {
			var c:Array = new Array(2);
			c[0] = a[0] - b[0];
			c[1] = a[1] - b[1];
			return c;
		}
		public function get rightBottom():Array {
			return add(leftTop, _vector);
		}
		
		public function set rightBottom(value:Array):void 
		{
			_vector = substract(value, leftTop);
		}
		
		public function get vector():Array { return _vector; }
		
		public function set vector(value:Array):void 
		{
			_vector = value;
		}
		
	}
	
}