package{
	public class IMStatus{
		public static const INPUTING:String="inputing";
		public static const WAIT:String="wait";
		private var _value:String;
		public function IMStatus(str:String =WAIT){
		_value=str;
		}
		public function get value():String{
			return _value;
		}
	}
}