package 
{
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class  EmulatorManager extends Sprite
	{
		private var sg:SymbolsGenerator;
		private var sc:SourceCoder;
		private var cc:ChannelCoder;
		private var m:Modulator;
		private var c:Channel;
		private var cd:ChannelDecoder;
		private var sd:SourceDecoder;
		private var sr:SymbolDisplayer;
		public function init():void {
			sg = new SymbolsGenerator();
			sc = new SourceCoder(sg);
			cc = new ChannelCoder(sc);
			m = new Modulator(cc);
			c = new Channel(m);
			//
			cd = new ChannelDecoder();
			sd = new SourceDecoder(cd);
			sr = new SymbolDisplayer();
			setupUI();
		}
		private function setupUI():void {
			addChild(sg);
			addChild(sr);
		}
		public function inputSymbols(str:String):void {
			sg.inputSymbols(str);
			var s:Signal = c.receiveSignal();
			cd.receive(s);
			var ss:SymbolSequence = sd.getSymbolSequence();
			sr.display(ss);
		}
	}
	
}