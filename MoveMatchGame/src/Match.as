package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Match extends Sprite 
	{
		public var isChosen:Boolean = false;
		public var isPressed:Boolean = false;
		public function Match() 
		{
			super();
			draw();
			addEventListener(MouseEvent.MOUSE_OVER, choose);
			addEventListener(MouseEvent.MOUSE_OUT, unChoose);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function mouseDown(e:MouseEvent = null):void {
			isPressed = true;
		}
		public function mouseUp(e:MouseEvent = null):void {
			isPressed = false;
		}
		public function unChoose(e:MouseEvent=null):void {
			isChosen = false;
			graphics.clear();
			draw();
		}
		public function choose(e:MouseEvent=null):void {
			isChosen = true;
			var l:Number = 23;
			var w:Number = 7;
			var g:Graphics = graphics;
			g.lineStyle(1, 0x00ffff);
			g.drawRect( -l * 0.5, -w * 0.5, l, w);
		}
		private function draw(): void {
			var l:Number = 20;
			var w:Number = 5;
			var g:Graphics = graphics;
			g.lineStyle( 0.1,0);
			g.beginFill(0xaaaaaa);
			g.drawRect( -l * 0.5, -w * 0.5, l, w);
			g.endFill();
			g.beginFill(0xff0000);
			g.drawCircle(l * 0.5,0, 3);
			g.endFill();
			
			
		}
		
	}

}