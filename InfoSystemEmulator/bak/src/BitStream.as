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
		public function toString():String {
			return "[BitStream(" + bits.join() + ")]";
		}
	}
	
}