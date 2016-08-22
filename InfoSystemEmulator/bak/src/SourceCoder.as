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
			var symbolTable:SymbolTable = ss.getSymbolTable();
			var symbolIndexs:Array = ss.getSymbolIndexs();
			var len:int = symbolIndexs.length;
			for (var i:int = 0; i < len; i++) {
				var tbs:BitStream = Convertor.convertToBitStream(symbolIndexs[i], 5);
				
				bs.append(tbs);
				
			}
			trace(ss);
			trace(bs);
			cc.send(bs);
		}
	}
	
}