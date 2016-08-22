package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Eric
	 */
	public class A3D extends Sprite
	{
		private var points:Array;
		private var triangles:Array;
		private var light:Light;
		private var color:uint = 0xffff00;
		public function A3D() 
		{
			light=new Light(1000,1000,1000)
			points = new Array ();
			triangles = new Array();
			var w:Number = 30;
			var dw:Number = 25;
			var bl:Number = 100;
			//forward face:
			points[0] = new Point3D(dw, 0, 0);
			points[1] = new Point3D(-dw, 0, 0);
			points[2] = new Point3D(0, -dw*2, 0);
			points[3] = new Point3D(0, -dw*2-w*2.24, 0);
			points[4] = new Point3D(20+w*1.12+bl*0.5,bl, 0);
			points[5] = new Point3D(20+w*1.12+bl*0.5-w*1.12, bl, 0);
			points[6] = new Point3D(dw+w*0.5, w, 0);
			points[7] = new Point3D(-(dw+w*0.5), w, 0);
			points[8] = new Point3D(-(20+w*1.12+bl*0.5-w*1.12), bl, 0);
			points[9] = new Point3D( -(20 + w * 1.12 + bl * 0.5), bl, 0);
			//back face:
			var thickness:Number = 30;
			points[10] = new Point3D(dw, 0, thickness);
			points[11] = new Point3D(-dw, 0, thickness);
			points[12] = new Point3D(0, -dw*2, thickness);
			points[13] = new Point3D(0, -dw*2-w*2.24, thickness);
			points[14] = new Point3D(20+w*1.12+bl*0.5,bl, thickness);
			points[15] = new Point3D(20+w*1.12+bl*0.5-w*1.12, bl, thickness);
			points[16] = new Point3D(dw+w*0.5, w, thickness);
			points[17] = new Point3D(-(dw+w*0.5), w, thickness);
			points[18] = new Point3D(-(20+w*1.12+bl*0.5-w*1.12), bl, thickness);
			points[19] = new Point3D( -(20 + w * 1.12 + bl * 0.5), bl, thickness);
			//end
			//forward
			triangles[0] = new Triangle(points[0], points[2], points[3]);
			triangles[1] = new Triangle(points[0], points[3], points[4]);
			triangles[2] = new Triangle(points[0], points[4], points[6]);
			triangles[3] = new Triangle(points[6], points[4], points[5]);
			triangles[4] = new Triangle(points[0], points[6], points[1]);
			triangles[5] = new Triangle(points[1], points[6], points[7]);
			triangles[6] = new Triangle(points[1], points[3], points[2]);
			triangles[7] = new Triangle(points[1], points[9], points[3]);
			triangles[8] = new Triangle(points[1], points[7], points[9]);
			triangles[9] = new Triangle(points[7], points[8], points[9]);
			//back face:
			triangles[10] = new Triangle(points[10], points[12], points[13],false);
			triangles[11] = new Triangle(points[10], points[13], points[14],false);
			triangles[12] = new Triangle(points[10], points[14], points[16],false);
			triangles[13] = new Triangle(points[16], points[14], points[15],false);
			triangles[14] = new Triangle(points[10], points[16], points[11],false);
			triangles[15] = new Triangle(points[11], points[16], points[17],false);
			triangles[16] = new Triangle(points[11], points[13], points[12],false);
			triangles[17] = new Triangle(points[11], points[19], points[13],false);
			triangles[18] = new Triangle(points[11], points[17], points[19],false);
			triangles[19] = new Triangle(points[17], points[18], points[19],false);
			//thick face:
			triangles[20] = new Triangle(points[3], points[13], points[14]);
			triangles[21] = new Triangle(points[3], points[14], points[4]);
			triangles[22] = new Triangle(points[3], points[9], points[19]);
			triangles[23] = new Triangle(points[3], points[19], points[13]);
			//Delta inside
			triangles[24] = new Triangle(points[2], points[0], points[10]);
			triangles[25] = new Triangle(points[2], points[10], points[12]);
			triangles[26] = new Triangle(points[2], points[12], points[11]);
			triangles[27] = new Triangle(points[2], points[11], points[1]);
			triangles[28] = new Triangle(points[10], points[0], points[1]);
			triangles[29] = new Triangle(points[10], points[1], points[11]);
			//below
			triangles[30] = new Triangle(points[7], points[6], points[16]);
			triangles[31] = new Triangle(points[7], points[16], points[17]);
			triangles[32] = new Triangle(points[6], points[5], points[15]);
			triangles[33] = new Triangle(points[6], points[15], points[16]);
			triangles[34] = new Triangle(points[8], points[7], points[17]);
			triangles[35] = new Triangle(points[8], points[17], points[18]);
			//floor of A
			triangles[36] = new Triangle(points[4], points[14], points[15]);
			triangles[37] = new Triangle(points[4], points[15], points[5]);
			triangles[38] = new Triangle(points[9], points[8], points[18]);
			triangles[39] = new Triangle(points[9], points[18], points[19]);
			//init
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.setVanishPoint(200, 200);
			}
			for (var j:int = 0; j < triangles.length; j++) 
			{
				var item1:Triangle = triangles[j];
				item1.light = light;
			}
			draw();
			this.addEventListener (Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			rotateWithMouse();
			draw();
		}
		private function rotateWithMouse():void {
			var dx:Number = this.mouseX - 200;
			var dy:Number = this.mouseY - 200;
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.rotationY( -dx * 0.01);
				item.rotationX(dy * 0.01);
			}
		}
		private function draw():void {
			triangles.sortOn("depth", Array.NUMERIC | Array.DESCENDING);
			graphics.clear();
			// color += 100;
			// trace(color);
			for (var i:int = 0; i < triangles.length; i++) 
			{
				var item:Triangle = triangles[i];
				item.draw(graphics, color);
			}
		}
	}

}