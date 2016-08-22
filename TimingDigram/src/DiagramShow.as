package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class DiagramShow extends Sprite
	{
		private var _container:Sprite = new Sprite();
		private var cood:Coord = new Coord();
		public function DiagramShow() 
		{
				init();
				cood.setOrign(0+60, 400-20);
				cood.setUnit(12, -20);
				drawCoord();
		}
		public function addObject(c:BasicCurve):void {
			c.coord = cood;
		}
		public function drawCoord():void {
			container.graphics.clear();
			container.graphics.lineStyle(0);
			cood.draw(container.graphics);
		}
		public function init():void {
			addChild(container);
		}
		/*public function setOrign(ox:Number, oy:Number):void {
			cood.setOrign(ox, oy);
		}*/
		public function draw(c:BasicCurve,color:uint=0x000000,pos:Point=null,scale:Point=null,name:String=null):void {
			if (pos == null) pos = new Point();
			if (scale == null) scale = new Point(1, 1);
			if (name == null) name = "";
			var cur:Sprite = new Sprite();
			container.addChild(cur);
			var g:Graphics = cur.graphics;
			g.lineStyle(1,color);
			c.draw(g);
			//
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.CENTER;
		
			t.text=name;
			cur.addChild(t);
			trace(name);
			//t.x = 100; t.y = 100;
			t.x = c.coord.toScreen(new Point()).x-5-t.width;
			t.y = c.coord.toScreen(new Point()).y-t.height/2;
			
			//
			var trans:Point = c.coord.toScreen(pos).subtract(c.coord.toScreen(new Point()))
			cur.x += trans.x;
			cur.y += trans.y;
			//
			cur.scaleX = scale.x;
			cur.scaleY = scale.y;
			//
			
			
		}
		
		public function get container():Sprite { return _container; }
		
		public function set container(value:Sprite):void 
		{
			_container = value;
		}
		
		
	}
	
}