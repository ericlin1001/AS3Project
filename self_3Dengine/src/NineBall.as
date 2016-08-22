package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Eric
	 */
	public class NineBall extends Sprite
	{
		private var _numPoints:Number=9;
		private var points:Array;
		private var balls:Array;
		public function NineBall() 
		{
			points = new Array();
			balls = new Array();
			for (var i:int = 0; i < _numPoints; i++) 
			{
				var item:Point3D = new Point3D(getRange( -150, 150), getRange( -150, 150), getRange( -150, 150));
				item.setVanishPoint(200, 200);
				points.push(item);
				//
				var ball:Ball = new Ball(20, getRange(0xff0000,0xff0000));
				addChild (ball);
				balls.push (ball);
				ball.pos3D = item;
			}
			balls.sortOn("pos3D.depth", Array.DESCENDING | Array.NUMERIC);
			updateBalls();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			rotateWithMouse();
			//rotatePoints(10);
			updateBalls();
		}
		private function updateBalls():void {
			balls.sortOn("depth", Array.DESCENDING | Array.NUMERIC);
			for (var i:int = 0; i < balls.length; i++) 
			{
				var ball:Ball = balls[i];
				ball.update();
			}
		}
		private function rotateWithMouse():void {
			trace("mouse x and y:",mouseX, mouseY);
			var dx:Number = mouseX - stage.stageWidth / 2;
			var dy:Number = mouseY - stage.stageHeight / 2;
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.rotationY(-dx * 0.01);
				item.rotationX(dy * 0.01);
			}
			balls.sortOn("pos3D.depth", Array.DESCENDING | Array.NUMERIC);
		}
		private function rotatePoints(angle:Number):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.rotationY( -angle * 0.01);
			//	item.rotationX(dy * 0.01);
			}
			points.sortOn("depth", Array.DESCENDING | Array.NUMERIC);
		}
		private function getRange(min:Number, max:Number):Number {
			return Math.random() * (max - min) + min;
		}
	}

}