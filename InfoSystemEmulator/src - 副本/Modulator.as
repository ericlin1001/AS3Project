package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class Modulator 
	{
		public var cc:ChannelCoder;
		public var c:Channel;
		public function Modulator(cc:ChannelCoder) {
			this.cc = cc;
			cc.bind(this);
		}
		public function bind(c:Channel):void {
			this.c = c;
		}
		public function send(bs:BitStream):void {
			var s:Signal = new Signal();
			var bits:Array = bs.getBits();
			var len:int = bits.length;
			for (var i:int = 0; i < len; i++) {
				s.append(Convertor.convertToSignal(bits[i]));
			}
			c.send(s);
		}
		
	}
	
}