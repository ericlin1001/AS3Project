package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class tile extends Sprite
	{
		private var unchoosedColor:uint = 0xffffff;//white
		private var choosedColor:uint = 0x000000;//black
		public var choose:Boolean = false;
		private var size:int = 50;
		override public function toString():String 
		{
			return choose?"1":"0";
			
		}
		public function tile(size:int) 
		{
				this.size = size;
				init();
		}
		private function init():void {
			choose = false;
			draw();
			this.addEventListener(MouseEvent.MOUSE_DOWN, onChoose);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		private function onMouseOver(e:MouseEvent):void {
			if (e.buttonDown) {
				onChoose();
			}
		}
		private function mouseDown (e:MouseEvent):void {
			onChoose();
		}
		private function onChoose(e:MouseEvent=null):void {
			choose = !choose;
			draw();
		}
		public function draw():void {
			var g:Graphics = this.graphics;
			g.clear();
			var color:uint;
			if (choose) {
				color = choosedColor;
			}else {
				color = unchoosedColor;
			}
			g.lineStyle(0);
			g.beginFill(color);
			//g.drawRect(0, 0, size, size);
			var halfSize:Number = Number(size) / 2;
			var radius:Number = halfSize-1;
			g.drawCircle(halfSize, halfSize, radius);
			g.endFill();
		}
		
	}
	
}