package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Eric
	 */
	public class Cylinder extends Sprite
	{
		private var points:Array;
		private var triangles:Array;
		private var color:uint = 0xffff00;
		private var _numPoints:int = 50;
		private var union:Union;
		public function Cylinder() 
		{
			points = new Array ();
			triangles = new Array();
			var h:Number = 150;
			var r:Number = 50;
			for (var k:int = 0; k < _numPoints; k++) 
			{
				var angle:Number = 2 * Math.PI / _numPoints * k;
				points[k]= new Point3D(r*Math.cos(angle), -h / 2, r*Math.sin (angle));
				points[k+_numPoints]= new Point3D( r*Math.cos(angle), h / 2, r*Math.sin (angle));
			}
			for (var l:int = 0; l < _numPoints-1; l++) 
			{
				var ppitem:Triangle = new Triangle(points[l],points[l+1],points[l+1+_numPoints],true,true);
				triangles.push (ppitem);
				var pppitem:Triangle = new Triangle(points[l],points[l+1+_numPoints],points[l+_numPoints],true,true);
				triangles.push (pppitem);
			}
				triangles.push (new Triangle(points[_numPoints-1],points[0],points[_numPoints],true,true));
				triangles.push (new Triangle(points[_numPoints-1],points[_numPoints],points[2*_numPoints-1],true,true));
		//init
			union = new Union(points, triangles, new Light(1,-1,-1));
			union.setVanishPoint(200, 200);
			//draw();
			this.addEventListener (Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			var dx:Number = mouseX - 200;
			var dy:Number = mouseY - 200;
			union.rotationY( -0.1 * dx);
			union.rotationX(0.1 * dy);
			graphics.clear();
			union.draw(graphics, color);
		}
		private function rotateWithMouse():void {
			var dx:Number = this.mouseX - 200;
			var dy:Number = this.mouseY - 200;
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.rotationY( -dx * 0.1);
				item.rotationX(dy * 0.1);
			}
		}
		private function draw():void {
			graphics.clear();
			// color += 100;
			// trace(color);
			for (var i:int = 0; i < triangles.length; i++) 
			{
				var item:Triangle = triangles[i];
				//item.color = color;
				//item.draw(graphics, color);
				item.draw(graphics);
			}
		}
		
	}

}