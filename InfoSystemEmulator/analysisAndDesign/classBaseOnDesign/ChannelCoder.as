package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChannelCoder 
	{
		private var sc:SourceCoder;
		private var c:Channel;
		public function ChannelCoder(sc:SourceCoder) {
			this.sc = sc;
			sc.bind(this);
		}
		public function bind(c:Channel):void {
			this.c = c;
		}
		public function send(bs:BitStream):void {
			var s:Signal = new Signal();
			c.send(s);
		}
	}
	
}