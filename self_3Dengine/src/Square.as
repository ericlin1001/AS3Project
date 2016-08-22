package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Eric
	 */
	public class Square extends Basic3DObject
	{
		
		public function Square() 
		{
			super();
			var a:Number =100;
			color = 0x00ff00;
			light = new Light(1, 1, 1);
			var b:Array = getps (pt(0, 0, a), pt(a, 0, a), pt(a, a, a), pt(0, a, a));
			var f:Array =getps(pt(0, 0, 0), pt(a, 0, 0), pt(a, a, 0), pt(0, a, 0));
			setArea(f, 0xff00ff, 0, 1, 2, 3);
			setArea(b, 0xfefaa2, 0, 3, 2,1);
			setAreaFromP(0xff0000, f[0], b[0], b[1], f[1]);
			setAreaFromP(color, f[1], b[1], b[2], f[2]);
			setAreaFromP(color, f[2], b[2], b[3], f[3]);
			setAreaFromP(color, f[3], b[3], b[0], f[0]);
			draw();
			//moveby(new Point3D( -a*0.5, -a*0.5, -a*0.5));
		}
		/*override public function update(e:Event):void 
		{
			
			rotateX(4);
			rotateY(5);
			super.update(e);
		//	draw();
		//	var t:Point3D = ps[2];
			//t.rotationX(10);
		//	trace(ps[2].toString());
		}*/
	}

}