package  
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Coord 
	{
		private var xunit:Number = 10;
		private var yunit:Number = -10;
		private var orign:Point = new Point(100, 300);
		public function Coord() 
		{
			
		}
		public function setUnit(xunit:Number, yunit:Number):void {
			this.xunit = xunit;
			this.yunit = yunit;
		}
		public function setOrign(ox:Number, oy:Number):void {
			orign.x = ox;
			orign.y = oy;
		}
		public function toScreen(p:Point):Point {
			return new Point(orign.x + p.x * xunit, orign.y + p.y * yunit);
		}
		public function draw(g:Graphics):void {
			const xlen:int = 100;
			const ylen:int = 100;
			//x
			g.moveTo(orign.x, orign.y);
			g.lineTo(orign.x + xlen * xunit, orign.y);
			//y
			g.moveTo(orign.x, orign.y);
			g.lineTo(orign.x , orign.y+ ylen * yunit);
		}
		
	}
	
}