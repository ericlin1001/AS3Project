package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UnionTest extends Sprite 
	{
		private var union:Union;
		public function UnionTest() 
		{
			super();
			var p:Array = [new Point3D(0, 0, 0), new Point3D(20, 20, 20), new Point3D(20, 100, 20)];
			union = new Union(p, [new Triangle(p[0], p[1], p[2])]);
		//	union.draw(this.graphics);
			this.addEventListener(Event.ENTER_FRAME, update);
			
		}
		private function update(e:Event):void {
			union.rotationY(1);
			this.graphics.clear();
			union.draw(this.graphics);
		}
	}

}