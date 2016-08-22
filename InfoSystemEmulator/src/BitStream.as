package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class  BitStream
	{
		private var bits:Array;

		public function BitStream(bits:Array = null) {
			if (bits == null) {
				this.bits = new Array();	
			}else{
				this.bits = bits;
			}
		}
		public function append(tbs:BitStream):void {
			bits=bits.concat(tbs.getBits());
		}
		public function getBits():Array {
			return bits;
		}
		public function getLength():int {
			return bits.length;
		}
		public function fetchBit():int {//modify bits 
			if (bits.length <= 0) return -1;
			return bits.shift();
		}
		public function fetchBits(num:int):BitStream {//modify bits
			if (num > bits.length) num = bits.length;
			return new BitStream(bits.splice(0, num));
		}
		public function toString():String {
			return "[BitStream(" + bits.join() + ")]";
		}
	}
	
}