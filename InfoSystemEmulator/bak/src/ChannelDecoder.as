package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChannelDecoder 
	{
		private var sd:SourceDecoder;
		public function bind(sd:SourceDecoder):void {
			this.sd = sd;
		}
		public function receive(s:Signal):void {
			var bs:BitStream = new BitStream();
			sd.receive(bs);
		}
	}
	
}