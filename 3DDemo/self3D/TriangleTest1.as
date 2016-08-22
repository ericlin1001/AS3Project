package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class TriangleTest1 extends Sprite
	{
		private var points:Array ;
		private var triangles:Array;
		private var light:Light;
		public function TriangleTest1() 
		{
			light = new Light(1, 1, 1);
			points = new Array ();
			triangles = new Array();
			points[0] = new Point3D(0, -50, 0);
			points[1] = new Point3D(-50, 50, -50);
			points[2] = new Point3D(50, 50, -50);
			points[3] = new Point3D(50, 50, 50);
			points[4] = new Point3D(-50, 50, 50);
			triangles[0] = new Triangle(points[0], points[2], points[1]);
			triangles[1] = new Triangle(points[0], points[3], points[2]);
			triangles[2] = new Triangle(points[0], points[4], points[3]);
			triangles[3] = new Triangle(points[1], points[2], points[3]);
			triangles[4] = new Triangle(points[1], points[3], points[4]);
			triangles[5] = new Triangle(points[0], points[1], points[4]);
			for (var j:int = 0; j < points.length; j++) 
			{
				var titem: Point3D= points[j];
				titem.setVanishPoint(200, 200);
			}
			for (var i:int = 0; i < triangles.length; i++) 
			{
				var item:Triangle = triangles[i];
				item.light = light;
				
			}
			//triangles.sortOn("depth", Array.NUMERIC | Array.DESCENDING);
			//draw();
			addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			rotateWithMouse();
			triangles.sortOn("depth", Array.NUMERIC);
			draw();
		}
		private function rotateWithMouse():void {
			var mx:Number = this.mouseX;
			var my:Number = this.mouseY;
			var dx:Number = mx - 200;
			var dy:Number = my - 200;
			graphics.clear();
			for (var j:int = 0; j < points.length; j++) 
			{
				var titem:Point3D= points[j];
				titem.rotationY(-dx*0.1);
				titem.rotationX(dy * 0.1);
			}
		}
		private function draw():void {
			for (var i:int = 0; i <triangles.length; i++) 
			{
				var item:Triangle = triangles[i];
				item.draw (graphics,0xffff00);
			}
		}
	}

}