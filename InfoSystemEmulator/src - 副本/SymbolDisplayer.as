package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SymbolDisplayer extends Sprite
	{
		private var ss:SymbolSequence = null;
		private var tf:TextField;
		public function SymbolDisplayer() {
			tf = new TextField();
				addChild(tf);
		}
		public function display(ss:SymbolSequence):void {
			tf.text = ss.getString();
		}
	}
	
}