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
			g.lineStyle(0,0,0);
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
		//	portO.send(createFlow(CircuitEvent.SWITCHTESTON));
			portI.send(createFlow(CircuitEvent.SWITCHTESTON));
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
		override protected function currentFlowingHandler(e:CircuitEvent):void 
		{
			if (state == ON) {
				e.U -= e.I * 2;
				super.currentFlowingHandler(e);
			}
			
		}

	}

}