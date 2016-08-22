package 
{
	import adobe.utils.CustomActions;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SourceDecoder 
	{
		private var cd:ChannelDecoder;
		private var outSymbolSequence:SymbolSequence;
		public function SourceDecoder(cd:ChannelDecoder) {
			this.cd = cd;
			cd.bind(this);
		}
		public function receive(bs:BitStream):void {
			outSymbolSequence = new SymbolSequence();
		}
		public function getSymbolSequence():SymbolSequence {
			return outSymbolSequence;
		}
		
	}
	
}