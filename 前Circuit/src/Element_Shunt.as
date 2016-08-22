package  
{
	import flash.display.Graphics
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Element_Shunt extends Element 
	{
		
		public function Element_Shunt() 
		{
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 2;
			makePortIs();
			makePortOs();
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = graphics;
			g.lineStyle(1.5, 0);
			g.moveTo(0, 0);
			g.lineTo(size * 0.5, 0);
			g.moveTo( -0.5 * size, - size/6);
			g.lineTo (0, -  size/6);
			g.lineTo(0,  size/6);
			g.lineTo(-0.5 * size, size/6);
			
		}
		override protected function blockHandler(e:CircuitEvent):void {
			
		}
		override protected function endPointHandler(e:CircuitEvent):void {
		/*	var port:TouchPoint = e.target as TouchPoint;
			if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.ENDPOINT);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.ENDPOINT);
			}*/
		}
		override protected function feedbackHandler(e:CircuitEvent):void {
			
		}
		override protected function inputHandler(e:CircuitEvent):void {
			/*var port:TouchPoint = e.target as TouchPoint;
			var edata:EData = new EData(port.U-R*port.I, port.I);
			if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.OUTPUT, edata);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.OUTPUT, edata);
			}*/
		}
		
	}

}