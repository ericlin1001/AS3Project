package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Eric
	 */
	public class TextBox extends Sprite
	{
		private var borderPic:Shape;
		private var type:String;
		private var curPic:Shape;
		private var text:String;
		private var textField:TextField;
		private var _border:Boolean = false;
		public function TextBox(width:Number=100,height:Number=10) 
		{
			borderPic = new Shape();
			curPic = new Shape();
			textField = new TextField();
			textField.width = width;
			textField.height = height;
			textField.selectable = false;
			addChild(textField);
			addChild(borderPic);
			addChild(curPic);
			//
			drawBorder();
			this.width = width;
			this.height = height;
			//
			x = 0;
			y = 0;
			
			//
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		override public function set x(value:Number):void 
		{
			super.x = value-width*0.5;
		}
		override public function set y(value:Number):void 
		{
			super.y = value-height*0.5;
		}
		private function drawBorder():void {
			var g:Graphics = borderPic.graphics;
			g.lineStyle(0);
			g.drawRect(0, 0, width, height);
		}
		private function onKeyDown(e:KeyboardEvent):void {
			var t:String;
			t = String.fromCharCode(e.charCode);
			trace(t);
			textField.appendText(t);
			
		}
		public function get border():Boolean { return _border; }
		
		public function set border(value:Boolean):void 
		{
			_border = value;
			
		}
	}
	
}