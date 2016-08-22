package  
{
	import flash.display.ActionScriptVersion;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Sphere extends Sprite 
	{
		public var points:Array;
		public var triangles:Array;
		public var color:uint = 0xffff00*0.5; //*//Math.random();
		public var precision:Number =2.5;
		private var union:Union;
		public var radius:Number = 10;
		private var closeThread:Number = 1;
		public var centerP:Point3D =new Point3D();
		public function Sphere() 
		{
			super();
			points = new Array();
			triangles = new Array();
		}
		public function init():void {
			//
			points.push(centerP);
			//
			var p1:Point3D = createPoint(radius, 0, 0);
			var p2:Point3D = createPoint(-radius, 0, 0);
			var p3:Point3D = createPoint(0, radius, 0);//down
			var p4:Point3D = createPoint(0, -radius, 0);//up
			var p5:Point3D = createPoint(0, 0, radius);
			var p6:Point3D = createPoint(0, 0, -radius);
			//createCurveFace(p4, p1, p6);
			createCurveFace(p4, p6, p2);
			/*createCurveFace(p4, p2, p5);
			createCurveFace(p4, p5, p1);
			//
			createCurveFace(p3, p6, p1);
			createCurveFace(p3, p2, p6);
			createCurveFace(p3, p5, p2);
			createCurveFace(p3, p1, p5);*/
			//
			var light:Light = new Light(1, 1, 1,1);
			union = new Union(points, triangles,light);
			union.setVanishPoint(200, 200);
			union.setCenter(0,0, 0);
		}
		public function get depth():Number {
			//trace("depth:", centerP.depth);
			return centerP.depth; 
		}
		
		public function rotateX(angle:Number):void {
			union.rotationX(angle);
		}
		public function rotateY(angle:Number):void {
			union.rotationY(angle);
		}
		public function rotateZ(angle:Number):void {
			union.rotationZ(angle);
		}
		public function trans(matrix:Matrix):void {
			union.trans(matrix);
		}
		public function draw():void {
			graphics.clear();
			union.draw(graphics, color);
		}
		public function moveBy(p:Point3D):void {
			
			union.moveby(p);
		}
		public function setLight(light:Light):void {
			union.light = light;
		}
		public function setVanishPoint(tx:Number, ty:Number):void {
			union.setVanishPoint(tx, ty);
		}
		public function setCenter(tx:Number, ty:Number,tz:Number):void {
			union.setCenter(tx, ty,tz);
		}
		
		private function createCurveFace(p1:Point3D, p2:Point3D, p3:Point3D):void {
			//suppose origin point (0,0,0);
			if (p1.dist(p2) < precision && p2.dist(p3)< precision && p3.dist(p1) < precision) {
				var t:Triangle = new Triangle(p1, p2, p3);
				triangles.push(t);
				return ;
			}	
			var p4:Point3D = getMid(p1, p2);
			var p5:Point3D = getMid(p2, p3);
			var p6:Point3D = getMid(p3, p1);
			//
			p4 = addPoints(p4);
			p5 = addPoints(p5);
			p6 = addPoints(p6);
			
			createCurveFace(p1, p4, p6);
			createCurveFace(p5, p3, p6);
			createCurveFace(p4, p2, p5);
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
		private function addPoints(p1:Point3D):Point3D {
			for (var i:int = 0; i < points.length; i++) {
				if (p1.dist(points[i])<closeThread) {
					return points[i];
				}
			}
			points.push(p1);
			//trace("add point", p1);
			return p1;
		}
		
	}

}