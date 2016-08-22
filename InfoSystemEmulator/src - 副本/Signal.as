package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class Signal 
	{
		private var signalUnits:Array;
		public function Signal(signalUnits:Array = null) {
			if (signalUnits == null) {
				this.signalUnits = new Array();
			}else {
				this.signalUnits = signalUnits;
			}
		}
		public function getSignalUnits():Array {
			return signalUnits;
		}
		public function append(s:Signal):void {
			signalUnits = signalUnits.concat(s.getSignalUnits());
		}
		public function toString():String {
			return "[Signal(" + signalUnits.join(",") + ")]";
		}
	}
	
}