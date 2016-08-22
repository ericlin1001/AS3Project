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
		public var voltage:Number = 20;//E
		private var _I:Number = 100;//I
		private var isOutputed:Boolean = true;
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
			this.addEventListener(Event.ENTER_FRAME, outputI);
		}
		public function start():void {
			isOutputed = true;
		}
		public function stop():void {
			isOutputed = false;
		}
		private function outputI(e:Event):void {
			if (isOutputed) {
				isOutputed = false;
				portI.send(CircuitEvent.OUTPUT, new EData(voltage, I));
				show("E:" + voltage + " I:" + I);
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
		override protected function blockHandler(e:CircuitEvent):void {
			
		}
		override protected function endPointHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			if (port.type == TouchPoint.IN_TYPE) {
				isOutputed = true;
			}else if (port.type == TouchPoint.OUT_TYPE) {
				//portI.send(CircuitEvent.ENDPOINT);
			}
		}
		override protected function feedbackHandler(e:CircuitEvent):void {
			
		}
		override protected function inputHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			I = voltage / (voltage-port.U) * I;
			//var edata:EData = new EData(port.U-R*port.I, port.I);
			if (port.type == TouchPoint.IN_TYPE) {
				//portO.send(CircuitEvent.OUTPUT, edata);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				isOutputed = true;
			}
		}
		override public function get I():Number 
		{
			
			return _I;
		}
		
		public function set I(value:Number):void 
		{
			_I = value;
		}
		
		public function set setIsNormal(value:Boolean):void {
			isNormal = value;
			//portO.send()
		}
	}

}