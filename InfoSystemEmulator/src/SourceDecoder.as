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
			//decoding process.... 
			while (bs.getLength() > 0) {
				outSymbolSequence.addSymbolIndex(
					Convertor.convertToInt(bs.fetchBits(6)));
			}
			trace(outSymbolSequence);
		}
		public function getSymbolSequence():SymbolSequence {
			return outSymbolSequence;
		}
		
	}
	
}