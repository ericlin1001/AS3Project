package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Element_VariableR extends Element 
	{
		public var maxR:Number = 10;
		private var _R:Number = 5;
		private var pointer:Sprite = new Sprite();
		public function Element_VariableR() 
		{
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 1;
			makePortIs();
			makePortOs();
			//
			addChild(pointer);
			//draw pointer:
			var g:Graphics = pointer.graphics;
			g.lineStyle(0);
			g.beginFill(0x77aabb);
			g.drawRect( -size / 15, -size / 5, size / 15 * 2, size * 2 / 5);
			g.moveTo( -size / 6, size / 5);
			g.lineTo(size / 6, size / 5);
			g.lineTo(0, size / 5 + size / 8);
			g.lineTo( -size / 6, size / 5);
			g.endFill();
			//
			pointer.buttonMode = true;
			pointer.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			R = maxR * 0.5;
		}
		private function mouseDownHandler(e:MouseEvent):void { 
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMovehandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function mouseMovehandler(e:MouseEvent):void {
			var r:Number = size / 3;
			if(-r<mouseX && mouseX <r){
			pointer.x = mouseX;
			}
			R = (pointer.x + r) / 2 / r * maxR;
		}
		private function mouseUpHandler(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMovehandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = graphics;
			g.lineStyle(1.5, 0);
			g.drawRect( -size/ 3, -size * 0.5 / 5,size*2/3,size/5);
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
			var edata:EData = new EData(port.U-R*port.I, port.I);
			if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.OUTPUT, edata);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.OUTPUT, edata);
			}
		}
		
		public function get R():Number 
		{
			return _R;
		}
		
		public function set R(value:Number):void 
		{
			_R = value;
			show("R:" + R + " maxR:" + maxR);
		}
		
		
	}

}