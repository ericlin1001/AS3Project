package{
	public class StonePoint{
		public var webx:uint=0
		public var weby:uint=0
		private var _weight:Number =0
		public var myW:Number =0
		public var oppW:Number =0
		public function StonePoint(tx:Number ,ty:Number ,tweight:Number =0,tmyW:Number =0,toppW:Number =0){
			webx=tx
			weby=ty
			_weight=tweight
			myW=tmyW
			oppW=toppW
		}
		public function get weight():Number {
			return _weight
		}
		public function set weight(value:Number ) {
			 _weight=value
		}
	}
}