package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChannelCoder 
	{
		private var sc:SourceCoder;
		private var m:Modulator;
		public function ChannelCoder(sc:SourceCoder) {
			this.sc = sc;
			sc.bind(this);
		}
		public function bind( m:Modulator):void {
			this.m = m;
		}
		public function send(bs:BitStream):void {
			var ns:BitStream = new BitStream();
			//the easiest one channel coder, do nothing.
			ns = bs;
			m.send(ns);
		}
	}
	
}