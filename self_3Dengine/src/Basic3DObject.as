package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Basic3DObject extends Sprite
	{
		public var ps:Array=new Array();
		public var points:Array=new Array ();
		public var triangles:Array=new Array ();
		public var color:uint=0xff0000;
		public var vpX:Number = 200;
		public var vpY:Number = 200;
		public var light:Light = null;
		public var angleSpeed:Number = 8;
		public function Basic3DObject(tvpX:Number=200,tvpy:Number=200,tlight:Light=null) 
		{
			vpX = tvpX;
			vpY = tvpy;
			if (tlight == null) {
				light = new Light(1, 1, 1);
			}else {
				light = tlight;
			}
			draw();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		public function moveby(p:Point3D):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i]as Point3D;
				item.x += p.x;
				item.y += p.y;
				item.z += p.z;
				
			}
		}
		public function setCenter(tx:Number, ty:Number, tz:Number):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i]as Point3D;
				item.setCenter(tx, ty, tz);
			}
		}
		public function update(e:Event):void {
			draw();
		}
		public function setAreaFromP(tcolor:uint,...rest):void {
			for (var i:uint = 1; i < rest.length - 1; i++) {
				var t:Triangle = new Triangle(rest[0], rest[i], rest[i + 1]);
				t.color = tcolor;
				t.light = light;
				triangles.push(t);
			}
		}
		public function draw():void {
			graphics.clear();
			triangles.sortOn("depth", Array.NUMERIC | Array.DESCENDING);
			for (var i:int = 0; i< triangles.length; i++) {
				var item:Triangle = triangles[i] as Triangle;
				item.draw(graphics);
			}
		}
		public function pt(tx:Number, ty:Number, tz:Number):Point3D {
			var p:Point3D = new Point3D(tx, ty, tz);
			p.setVanishPoint(vpX, vpY);
			var isequal:Boolean=false;
			for (var i:int = 0; i < points.length;i++ ) {
				if (p.equal(points[i] as Point3D)) {
					isequal = true;
					break;
				}
			}
			if (!isequal) points.push(p);
			return p;
		}
		public function setArea(arr:Array ,tcolor:uint,...rest):void
		{
			for (var i:uint = 1; i < rest.length - 1; i++) {
				var t:Triangle = new Triangle(arr[rest[0]], arr[rest[i]], arr[rest[i + 1]]);
				t.color = tcolor;
				t.light = light;
				triangles.push(t);
			}
		}
		public function getps(...rest):Array 
		{
			ps = rest;
			return rest;
		}
		//
		public function rotateX(angle:Number):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i]as Point3D;
				//trace("call Union:rotationX");
				item.rotationX(angle);
			}
		}
		public function rotateY(angle:Number):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i]as Point3D;
				item.rotationY(angle);
			}
		}
		public function rotateZ(angle:Number):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i] as Point3D;
				item.rotationZ(angle);
			}
		}
		
	}

}