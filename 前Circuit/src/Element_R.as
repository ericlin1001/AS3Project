package  
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Element_R extends Element
	{
		public var R:Number =2;
		public function Element_R() 
		{
			//
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 1;
			makePortIs();
			makePortOs();
			//
			//
			show("R: " + R+" U:"+U+" I:"+I);
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = graphics;
			g.lineStyle(1.5, 0);
			g.drawRect( -size/ 3, -size * 0.5 / 3,size*2/3,size/3);
		}
		override protected function blockHandler(e:CircuitEvent):void {
			
		}
		override protected function endPointHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			changeType(port).send(CircuitEvent.ENDPOINT);
			
		}
		override protected function feedbackHandler(e:CircuitEvent):void {
			
		}
		override protected function inputHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			var edata:EData = new EData(port.U-R*port.I, port.I);
			/*if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.OUTPUT, edata);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.OUTPUT, edata);
			}*/
			changeType(port).send(CircuitEvent.OUTPUT, edata);
			show("R: " + R + " U:" + U + " I:" + port.I);
		}
	}

}