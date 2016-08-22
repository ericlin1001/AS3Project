package {
	import flash.display.Sprite;

	public class API extends Sprite {
		private var ball:Ball 
		private var color24:uint;
		private var color32:uint;
		private var coloralpha:uint=200;
		private var red:uint=20;//0-255
		private var green:uint=20;
		private var blue:uint=142;
		private var ballcolor :Ball;
		public function API() {
			init();
		}
		private function init() {
			//color24
			red =Math.random ()*256;
			green=Math.random ()*256;
			blue =Math.random ()*256;
			color24 = red << 16 | green << 8 | blue;
			red = color24 >> 16;
			green = color24 >> 8 & 0xFF;
			blue = color24 & 0xFF;
			//color 32
			coloralpha =Math.random ()*150
			red =Math.random ()*256;
			green=Math.random ()*256;
			blue =Math.random ()*256;
			color32 = coloralpha << 24 | red << 16 | green << 8 | blue;
			coloralpha = color32 >> 24;
			red = color32 >> 16 & 0xFF;
			green = color32 >> 8 & 0xFF;
			blue = color32 & 0xFF;
			//
			ballcolor =new Ball(40,0x8800ff00);
			
			ball=new Ball(40,0xcc0000ff)
			ball.x=70
			ball.y=70
			addChild(ball)
			addChild(ballcolor);
			ballcolor.x=40;
			ballcolor.y= 40;
			graphics.lineStyle(1,0)
			graphics.drawCircle(250, 250, 25)
			
			graphics.drawEllipse(100, 100, 50, 30) 
			graphics.drawRect(150,150, 50, 30)
			graphics.drawRoundRect(200, 200, 50, 30, 10, 5)
		}
	}
}