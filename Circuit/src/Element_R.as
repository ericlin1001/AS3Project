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
		override protected function currentFlowingHandler(e:CircuitEvent):void 
		{
			trace("in R");
		//e.U -= R * e.I;
			//show("R: " + R + " U:" + U + " I:" + e.I);
			//super.currentFlowingHandler(e);
		}
	}

}