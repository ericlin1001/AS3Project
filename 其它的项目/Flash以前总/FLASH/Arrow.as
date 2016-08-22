package {
	import flash.display.Sprite;
	public class Arrow extends Sprite {
		private var color:uint
		public function Arrow(color:uint = 0) {
			this.color = color;
			init();
		}
		private function init():void {

			graphics.lineStyle(1,color,1);
			graphics.beginFill(color);
			graphics.moveTo(-50,-25);
			graphics.lineTo(0,-25);
			graphics.lineTo(0,-50);
			graphics.lineTo(50,0);
			graphics.lineTo(0,50);
			graphics.lineTo(0,25);
			graphics.lineTo(-50,25);
			graphics.lineTo(-50,-25);
			graphics.endFill();
		}
	}
}