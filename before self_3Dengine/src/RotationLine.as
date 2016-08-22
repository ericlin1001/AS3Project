package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Eric
	 */
	public class RotationLine extends Sprite
	{
		private var _numPoints:Number;
		private var points:Array;
		public function RotationLine() 
		{
			ponts = new Array();
			for (var i:int = 0; i < _numPoints; i++) 
			{
				var item:Point3D = new Point3D(getRange( -150, 150), getRange( -150, 150), getRange( -150, 150));
				item.setVanishPoint(stage.stageWidth / 2, stage.stageHeight / 2);
				points.push(item);
			}
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		private function update(e:Event):void {
			rotateWithMouse();
			draw();
		}
		private function rotateWithMouse():void {
			
		}
		private function getRange(min:Number, max:Number):Number {
			return Math.random() * (max - min) + min;
		}
		
	}

}