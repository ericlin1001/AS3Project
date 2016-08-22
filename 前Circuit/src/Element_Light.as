package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Element_Light extends Element 
	{
		public var settedP:Number = 100;
		public var R:Number = 2;
		private var light:Sprite=new Sprite();
		public function Element_Light() 
		{
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 1;
			makePortIs();
			makePortOs();
			//
			drawArea.addChild(light);
			changeLightness(0);
			show("U:"+U+"I:"+I+" R"+R+"settedP:"+settedP);
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = drawArea.graphics;
			g.lineStyle(1.5, 0);
			g.drawCircle(0,0,size * 0.4);
			g.moveTo(size*0.4*0.5, -size*0.4*0.856);
			g.lineTo(-size*0.4*0.5, size*0.4*0.856);
			g.moveTo(-size*0.4*0.5, -size*0.4*0.856);
			g.lineTo(size*0.4*0.5, size*0.4*0.856);
		}
		private function changeLightness(ligtness:Number):void {
			var g:Graphics = light.graphics;
			g.clear();
			ligtness = Math.min(1, Math.max(ligtness, 0));
			g.beginFill(0xffff00, ligtness);
			g.drawCircle(0, 0, size * 0.4);
			g.endFill();
		}
		override protected function blockHandler(e:CircuitEvent):void {
			
		}
		override protected function endPointHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.ENDPOINT);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.ENDPOINT);
			}
		}
		override protected function feedbackHandler(e:CircuitEvent):void {
			
		}
		override protected function inputHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			var edata:EData = new EData(port.U - R * port.I, port.I);
			changeLightness(port.I * port.I * R / settedP);
			if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.OUTPUT, edata);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.OUTPUT, edata);
			}
			show("U:"+U+"I:"+I+" R"+R+"settedP:"+settedP);
		}
	}

}