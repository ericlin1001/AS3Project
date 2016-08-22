package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class CircuitManagger extends Sprite 
	{
		public static const NORMAL:String = "normal";
		public static const LINKING:String = "linking";
		public static const MOVING:String = "moving";
		public var state:String = NORMAL;
		private var selectedPort:TouchPoint=null;
		public function CircuitManagger() 
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			//
		/**/var R:Element_R = new Element_R();
			addChild(R);
			R.x = 70;
			R.y = 50;
			/**/var L:Element_Light = new Element_Light();
			addChild(L);
			L.x = 220;
			L.y = 50;
			var E:PowerSupply = new PowerSupply();
			addChild(E);
			E.x = 150;
			E.y = 200;
			//
		//	E.portI.linkTo(L.portI);
			L.portO.linkTo(R.portI)
			R.portO.linkTo(E.portO);
			//
			addChild(new Element_Switch());
		/*	for (var i:int = 0; i < 5; i++) 
			{
				addChild(new PowerSupply());
				addChild(new Element_Light());
				addChild(new Element_R());
				addChild(new Element_VariableR());
				addChild(new Element_Switch());
				addChild(new Element_Shunt());
				addChild(new Element_Conflux());
			}*/
		}
		private function mouseDownHandler(e:MouseEvent):void {
			var mx:Number = mouseX;
			var my:Number = mouseY;
			selectedPort = e.target as TouchPoint;
			if (selectedPort!=null) {
				state = LINKING;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
		}
		private function mouseUpHandler(e:MouseEvent):void {
			graphics.clear();
			var port:TouchPoint = e.target as TouchPoint;
				selectedPort.linkTo(port);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			state = NORMAL;
		}
		private function mouseMoveHandler(e:MouseEvent):void {
			if (state == LINKING) {
				graphics.clear();
				graphics.lineStyle(0);
				var p:Point = new Point(0, 0);
				p = this.globalToLocal(selectedPort.localToGlobal(p));
				graphics.moveTo(p.x,p.y);
				graphics.lineTo(mouseX, mouseY);
			}
		}
	}

}