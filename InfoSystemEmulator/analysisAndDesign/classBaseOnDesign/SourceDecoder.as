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
		public function SourceDecoder(cd:ChannelDecoder) {
			this.cd = cd;
			cd.bind(this);
		}
		public function receive(bs:BitStream):void {
			
		}
		public function getSymbolSequence():SymbolSequence {
			return new SymbolSequence();
		}
		
	}
	
}