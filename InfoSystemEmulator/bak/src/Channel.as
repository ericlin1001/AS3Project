package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class Channel 
	{
		private var m:Modulator;
		private var inSignal:Signal;
		private var outSignal:Signal;
		public function Channel(m:Modulator) {
			this.m = m;
			m.bind(this);
		}
		private function produceOutSignal():void {
			var signalUnits:Array = inSignal.getSignalUnits();
			var len:int = signalUnits.length;
			for (var i:int = 0; i < len; i++) {
				var signalUnit:SignalUnit = signalUnits[i] as SignalUnit;
				var x:Number = signalUnit.getX();
				var y:Number = signalUnit.getY();
				const NoisyFactor:Number = 1.0;
				x += (Math.random()*2-1) * NoisyFactor;
				y += (Math.random()*2-1) * NoisyFactor;
				signalUnit.setXY(x, y);
				signalUnits[i] = signalUnit;
			}
			outSignal = new Signal(signalUnits);
		}
		public function send(s:Signal):void {
			inSignal = s;
			produceOutSignal();
			trace(outSignal);
		}
		public function receiveSignal():Signal {
			return outSignal;
		}
	}
	
}