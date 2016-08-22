package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Sphere extends Sprite 
	{
		private var points:Array;
		private var triangles:Array;
		private var color:uint = 0xffffff*Math.random();
		private var _nums:int = 25;
		private var union:Union;
		public function Sphere() 
		{
			super();
			points = new Array();
			triangles = new Array();
			var R:Number = 100;
			for (var i:int = 0; i < _nums; i++) 
			{
				var angleV:Number = Math.PI / _nums * (i + 0.5);
				var tempArray:Array = new Array ();
				var r:Number = R * Math.sin(angleV);
				for (var j:int = 0; j < 2*_nums; j++) 
				{
					var angleR:Number = Math.PI / _nums * j;
					tempArray.push (new Point3D(r*Math.cos(angleR),R*Math.cos (angleV),r*Math.sin(angleR)));
				}
				tempArray.push (tempArray[0]);
				points.push (tempArray);
			}
		
			for (var k:int = 0; k < points.length-1; k++) 
			{
				var t:Array = makeRound(points[k], points[k + 1]);
				for (var l:int = 0; l < t.length; l++) 
				{
					triangles.push (t[l]);
				}
			}
			var tPoints:Array = new Array ();
			for (var m:int = 0; m < points.length; m++) 
			{
				for (var n:int = 0; n < points[m].length-1; n++) 
				{
					tPoints.push (points[m][n]);
				}
				
			}
			var downPoint:Point3D = new Point3D(0,R,0);
			var upPoint:Point3D = new Point3D(0, -R, 0);
			tPoints.push (downPoint);
			tPoints.push (upPoint);
			var lenPoints:Number = points.length;
			for (var o:int = 0; o <points[0].length-1; o++) 
			{
				triangles.push (new Triangle(downPoint, points[0][o], points[0][o+1]));
				triangles.push (new Triangle(upPoint, points[lenPoints-1][o], points[lenPoints-1][o+1],false));
			}
			//
			union = new Union(tPoints, triangles,new Light(1,1,-1));
			union.setVanishPoint(200, 200);
			union.setCenter(0, 0, 0);
			union.draw(graphics, color);
			union.moveTo(new Point3D(20,0 ,20 ));
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
		private function makeRound(p1:Array, p2:Array):Array {
			var tempArray:Array = new Array();
			var len:Number = p1.length;
			for (var i:int = 0; i <len-1; i++) 
			{
				tempArray.push (new Triangle(p1[i],p1[i+1],p2[i],false));
				tempArray.push (new Triangle(p1[i+1],p2[i+1],p2[i],false));
			}
			return tempArray;
		}
		
	}

}