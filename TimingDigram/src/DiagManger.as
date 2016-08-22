package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class DiagManger 
	{
		private var ds:DiagramShow = new DiagramShow();
		private var curves:Array = new Array();
		public function DiagManger() 
		{
		}
		public function getSprite():Sprite {
			return ds.container;
		}
		public function creatSquareCurve(t:String, color:uint, pos:Point,scale:Point=null,name:String=null):SquareCurve{
			if (name == null) name = "Curve " + curves.length + " :";
			var temp:SquareCurve = new SquareCurve();
			temp.create(t);
			ds.addObject(temp);
			ds.draw(temp, color, pos,scale,name);
			curves.push(temp);
			return temp;
		}
	}
	
}