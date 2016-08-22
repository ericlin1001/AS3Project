package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Eric
	 */
	public class Segment extends Sprite
	{
		private var _height:Number;
		private var _width:Number ;
		private var _color:uint;
		//
		public var vx:Number;
		public var vy:Number;
		public function Segment(twidth:Number=50,theight:Number=15,tcolor:uint=0xffffff ) 
		{
			_color = tcolor;
			_width = twidth;
			_height = theight;
			draw();
			
		}
		public function draw():void {
			graphics.lineStyle (0);
			graphics.beginFill (_color);
			graphics.drawRoundRect ( -height / 2, -height / 2, width + height, height, height, height);
			graphics.endFill ();
			graphics.drawCircle (0, 0, 2);
			graphics.drawCircle (width , 0, 2);
		}
		public function getPin():Point {
			var angle:Number = rotation / 180 * Math.PI;
			return new Point(x + width * Math.cos (angle), y + width * Math.sin (angle));
		}
		public function get pin():Point {
			return getPin();
		}
		override public function get height():Number 
		{
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			_height = value;
			draw();
		}
		
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set width(value:Number):void 
		{
			_width = value;
			draw();
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
			draw();
		}
		public function set positon(value:Point):void {
			x = value.x;
			y = value.y;
		}
	}

}