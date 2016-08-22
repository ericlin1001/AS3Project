package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class Channel 
	{
		private var cc:ChannelCoder;
		private var sendSignal:Signal;
		private var receiveSignal:Signal;
		public function Channel(cc:ChannelCoder) {
			this.cc = cc;
			cc.bind(this);
		}
		public function send(s:Signal):void {
			sendSignal = s;
			receiveSignal = new Signal();
		}
		public function receiveSignal():Signal {
			return receiveSignal;
		}
	}
	
}