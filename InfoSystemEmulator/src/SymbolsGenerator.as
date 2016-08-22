package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SymbolsGenerator extends Sprite
	{
		private var sc:SourceCoder;
		private var tf:TextField;
		public function SymbolsGenerator() {
			tf = new TextField();
			addChild(tf);
		}
		public function bind(sc:SourceCoder):void {
			this.sc = sc;
		}
		public function inputSymbols(str:String):void {
			var ss:SymbolSequence = new SymbolSequence(str);
			sc.send(ss);
			tf.text = str;
		}
	}
	
}