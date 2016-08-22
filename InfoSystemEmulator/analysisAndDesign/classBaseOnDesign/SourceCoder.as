package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class  SourceCoder
	{
		private var sg:SymbolsGenerator;
		private var cc:ChannelCoder;
		public function SourceCoder(sg:SymbolsGenerator) {
			this.sg = sg;
			sg.bind(this);
		}
		public function bind(cc:ChannelCoder):void {
			this.cc = cc;
		}
		public function send(ss:SymbolSequence):void {
			var bs:BitStream = new BitStream();
			cc.send(bs);
		}
	}
	
}