package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Eric
	 */
	public class RotationBall extends Sprite
	{
		private var _numPoints:Number=30;
		private var points:Array;
		private var balls:Array;
		public function RotationBall() 
		{
			points = new Array();
			balls = new Array();
			for (var i:int = 0; i < _numPoints; i++) 
			{
				var item:Point3D = new Point3D(getRange( -150, 150), getRange( -150, 150), getRange( -150, 150));
				item.setVanishPoint(200, 200);
				points.push(item);
				//
				var ball:Ball = new Ball(getRange(10, 15), 0xff0000);
				addChild (ball);
				balls.push (ball);
			}
			points.sortOn("depth", Array.DESCENDING | Array.NUMERIC);
			updateBalls();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			//rotateWithMouse();
			rotatePoints(10);
			points.sortOn("depth", Array.DESCENDING | Array.NUMERIC);
			updateBalls();
			
		}
		private function updateBalls():void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				var ball:Ball = balls[i];
				ball.x = item.screenX;
				ball.y = item.screenY;
				ball.scaleX =ball.scaleY= item.scale;
			}
		}
		private function rotateWithMouse():void {
			var dx:Number = this.mouseX - stage.stageWidth / 2;
			var dy:Number = this.mouseY - stage.stageHeight / 2;
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.rotationY( -dx * 0.01);
				item.rotationX(dy * 0.01);
			}
		}
		private function rotatePoints(angle:Number):void {
			for (var i:int = 0; i < points.length; i++) 
			{
				var item:Point3D = points[i];
				item.rotationY( -angle * 0.01);
			//	item.rotationX(dy * 0.01);
			}
		}
		private function getRange(min:Number, max:Number):Number {
			return Math.random() * (max - min) + min;
		}
	}

}