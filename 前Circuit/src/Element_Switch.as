package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Element_Switch extends Element 
	{
		
		
		
		public static const ON:String = "on";
		public static const OFF:String = "off";
		private var switchPic:Sprite = new Sprite();
		public function Element_Switch() 
		{
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 1;
			makePortIs();
			makePortOs();
			//
			//
			
			//
			addChild (switchPic);
			switchPic.buttonMode = true;
			switchPic.addEventListener(MouseEvent.CLICK, switchChange);
			off();
			show(state);
		}
		private function switchReactDraw():void {
			var g:Graphics =  switchPic.graphics;
		//	g.clear();
			g.lineStyle(0, 0,0);
			g.beginFill(0xff0000, 0);
			g.drawCircle( -size * 0.25, 0, 5);
			g.endFill();
		}
		private function switchChange(e:MouseEvent):void {
			if (state == ON) {
				off();
			}else{
				on();
			}
			show(state);
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = graphics;
			g.lineStyle(0);
			g.moveTo( -size * 0.5, 0);
			g.lineTo( -size * 0.25,0);
			g.moveTo(size * 0.25,0)
			g.lineTo(size * 0.5, 0);
			g.lineStyle(1,0xff0000,0.2);
			g.drawCircle( -size * 0.25, 0, 4);
		}
		public function on():void {
			state = ON;
			var g:Graphics = switchPic.graphics;
			g.clear();
			g.lineStyle(0);
			g.moveTo( -0.25 * size, 0);
			g.lineTo(0.25 * size, 0);
			switchReactDraw();
		}
		public function off():void {
			state = OFF;
			var g:Graphics = switchPic.graphics;
			g.clear();
			g.lineStyle(0);
			g.moveTo( -0.25 * size, 0);
			g.lineTo(0.25 * size, -0.25 * size);
			switchReactDraw();
		}
		//
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
		/*	var port:TouchPoint = e.target as TouchPoint;
			var edata:EData = new EData(port.U-R*port.I, port.I);
			if (port.type == TouchPoint.IN_TYPE) {
				portO.send(CircuitEvent.OUTPUT, edata);
			}else if (port.type == TouchPoint.OUT_TYPE) {
				portI.send(CircuitEvent.OUTPUT, edata);
			}
			show("R: " + R + " U:" + U + " I:" + port.I);*/
		}
	}

}