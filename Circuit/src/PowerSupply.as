package  
{
	import flash.display.Graphics;
	import flash.events.Event;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class PowerSupply extends Element 
	{
		public var voltage:Number = 30;//E
		private var _I:Number = 1;//I
		//
		private var isTesting:Boolean = true;
		private var isPositiveOK:Boolean = false;
		private var isNegativeOK:Boolean = false;
		private var isPositiveSend:Boolean = false;
		private var isNegativeSend:Boolean = false;
		
		public function PowerSupply() 
		{
			
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 1;
			makePortIs();
			makePortOs();
			//
			this.addEventListener(Event.ENTER_FRAME, onTick);
		}
		private function onTick(teeee:Event):void {
			if (isPositiveSend) {
				positivePort.send(createFlow(CircuitEvent.CURRENTFLOWING, voltage, I, "positivePort"));
				show("E:" + voltage + " I:" + I);
				isPositiveSend = false;
			}else if(isNegativeSend) {
				negativePort.send(createFlow(CircuitEvent.CURRENTFLOWING, voltage, I, "negativePort"));
				show("E:" + voltage + " I:" + I);
				isNegativeSend = false;
			}
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = graphics;
			g.lineStyle(1.5, 0);
			g.moveTo( -5, -5);
			g.lineTo( -5, 5);
			g.moveTo(5, -10);
			g.lineTo(5, 10);
		}
		override protected function switchTestOnHandler(e:CircuitEvent):void 
		{
			var port:TouchPoint = e.target as TouchPoint;
			if (port== positivePort) {
				isPositiveSend = true;
			}
		}
		override protected function currentFlowingHandler(e:CircuitEvent):void 
		{
			var port:TouchPoint = e.target as TouchPoint;
			if (port== negativePort) {
				I = voltage / (voltage-e.U) * I;
				isPositiveSend = true;
			}
		}
		override protected function endPointHandler(e:CircuitEvent):void 
		{
		}
		public function get positivePort():TouchPoint {
			return portI;
		}
		public function get negativePort():TouchPoint {
			return portO;
		}
		override public function get I():Number 
		{
			
			return _I;
		}
		
		public function set I(value:Number):void 
		{
			_I = value;
		}
		
	}

}