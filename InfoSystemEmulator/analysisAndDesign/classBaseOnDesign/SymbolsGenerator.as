package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SymbolsGenerator extends Sprite
	{
		private var sc:SourceCoder;
		public function SymbolsGenerator() {
			
		}
		public function bind(sc:SourceCoder):void {
			this.sc = sc;
		}
		public function inputSymbols(str:String):void {
			var ss:SymbolSequence = new SymbolSequence(str);
			sc.send(ss);
		}
	}
	
}