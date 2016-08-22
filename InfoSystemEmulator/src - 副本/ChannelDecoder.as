package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChannelDecoder 
	{
		private var sd:SourceDecoder;
		public function bind(sd:SourceDecoder):void {
			this.sd = sd;
		}
		public function receive(s:Signal):void {
			var bs:BitStream = new BitStream();
			var signalUnits:Array = s.getSignalUnits();
			var len:int = signalUnits.length;
			for (var i:int = 0; i < len; i++) {
				var signalUnit:SignalUnit = signalUnits[i] as SignalUnit;
				var x:Number = signalUnit.getX();
				var y:Number = signalUnit.getY();
				if (x > 0) {
					//we predict the bit is 1.
					bs.append(Convertor.convertToBitStream(1, 1));
				}else {
					//we predict the bit is 0.
					bs.append(Convertor.convertToBitStream(0, 1));
				}
			}
			trace(bs);
			sd.receive(bs);
		}
	}
	
}