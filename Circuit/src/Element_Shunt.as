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
		
	}

}