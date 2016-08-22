package {
	import flash.display.Sprite;
	import flash.geom.Point;
	public class Segment extends Sprite {
		private var color:uint;
		private var segmentWidth:Number;
		private var segmentHeight:Number;
		public var vx:Number = 0;
		public var vy:Number = 0;
		public function Segment(segmentWidth:Number=100, segmentHeight:Number=50, color:uint = 0xffffff) {
			this.segmentWidth = segmentWidth;
			this.segmentHeight = segmentHeight;
			this.color = color;
			init();
		}
		private  function init():void {// 绘制关节 
			graphics.lineStyle(0);
			graphics.beginFill(color);
			graphics.drawRoundRect(-segmentHeight / 2, -segmentHeight / 2, segmentWidth + segmentHeight, segmentHeight, segmentHeight, segmentHeight);
			graphics.endFill();// 绘制两个“枢轴”
			graphics.drawCircle(0, 0, 2);
			graphics.drawCircle(segmentWidth, 0, 2);
		}
		public function getPin():Point {
			var angle:Number = rotation * Math.PI / 180;
			var xPos:Number = x + Math.cos(angle) * segmentWidth;
			var yPos:Number = y + Math.sin(angle) * segmentWidth;
			return new Point(xPos,yPos);
		}
	}
}