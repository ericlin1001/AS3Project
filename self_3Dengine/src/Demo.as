package  
{
	import flash.display.ActionScriptVersion;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Demo extends Sprite 
	{
		private var points:Array;
		private var triangles:Array;
		private var color:uint = 0xffff00*0.5; //*//Math.random();
		private var _nums:int = 35;
		private var precision:Number =5;
		private var union:Union;
		private var radius:Number = 10;
		public function Demo() 
		{
			super();
			points = new Array();
			triangles = new Array();
			var p1:Point3D = createPoint(radius, 0, 0);
			var p2:Point3D = createPoint(-radius, 0, 0);
			var p3:Point3D = createPoint(0, radius, 0);//down
			var p4:Point3D = createPoint(0, -radius, 0);//up
			var p5:Point3D = createPoint(0, 0, radius);
			var p6:Point3D = createPoint(0, 0, -radius);
			createCurveFace(p4, p1, p6);
			createCurveFace(p4, p6, p2);
			createCurveFace(p4, p2, p5);
			createCurveFace(p4, p5, p1);
			//
			createCurveFace(p3, p6, p1);
			createCurveFace(p3, p2, p6);
			createCurveFace(p3, p5, p2);
			createCurveFace(p3, p1, p5);
			
			//
			var light:Light = new Light( -1, 2, 1,1);
			union = new Union(points, triangles,light);
			union.setVanishPoint(200, 200);
			union.setCenter(0,0, 0);
			union.draw(graphics, color);
			union.moveby(new Point3D(20,0 ,20 ));
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
		private function createCurveFace(p1:Point3D, p2:Point3D, p3:Point3D):void {
			//suppose origin point (0,0,0);
			if (p1.dist(p2) < precision) {
				var t:Triangle = new Triangle(p1, p2, p3);
				triangles.push(t);
				return ;
			}
			var p4:Point3D = getMid(p1, p2);
			var p5:Point3D = getMid(p2, p3);
			var p6:Point3D = getMid(p3, p1);
			//
			var temp:int;
			temp=findEqual(p4)
			if ( temp>= 0) {
				p4 = points[temp];
			}else {
				points.push(p4);
			}
			temp=findEqual(p5)
			if ( temp>= 0) {
				p5 = points[temp];
			}else {
				points.push(p5);
			}
			temp=findEqual(p6)
			if ( temp>= 0) {
				p6 = points[temp];
			}else {
				points.push(p6);
			}
			createCurveFace(p1, p4, p6);
			createCurveFace(p4, p2, p5);
			createCurveFace(p5, p3, p6);
			createCurveFace(p4, p5, p6);
		}
		private function getMid(p1:Point3D, p2:Point3D):Point3D {
			var temp:Point3D = p1.add(p2);
			temp = temp.multiConst(radius / temp.length);
			return temp;
		}
		private function createPoint(x:Number, y:Number, z:Number):Point3D {
			var t:Point3D = new Point3D(x, y, z);
			points.push(t);
			return t;
		}
		private function createTriangle(p1:Point3D, p2:Point3D, p3:Point3D):Triangle {
			var t:Triangle = new Triangle(p1, p2, p3);
			triangles.push(t);
			return t;
		}
		private function findEqual(p1:Point3D):int {
			for (var i:int = 0; i < points.length; i++) {
				if (p1.equal(points[i])) {
					return i;
				}
			}
			return -1;
		}
		
	}

}