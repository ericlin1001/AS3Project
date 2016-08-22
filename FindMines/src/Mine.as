package{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	public class Mine extends Sprite {
		private var size:Number;
		private var _isMine:Boolean = false;
		private var _numMineRound:int = 0;
		public var numText:TextField = new TextField();
		private var cover_mc:Sprite = new Sprite();
		private var isOpen:Boolean = false;
		public var neighbors:Array = new Array();
		public function Mine(tsize:Number = 10) {
			size = tsize;
			addChild(numText);
			addChild(cover_mc);
			numText.type = TextFieldType.DYNAMIC;
			numText.text = " ";
			//numText.border = true;
			numText.width = numText.height=0;
			numText.autoSize = TextFieldAutoSize.CENTER;
			numText.scaleX = numText.scaleY = size/numText.height*1.1;
			numText.x = size * 0.5 - numText.width * 0.5;
			numText.y = size * 0.5 - numText.height * 0.5;
			
			numText.mouseEnabled = false;
			var g:Graphics;
			g = graphics;
			g.lineStyle(0);
			g.drawRect(0, 0, size, size);
			 g= cover_mc.graphics;
			g.lineStyle(0);
			g.beginFill(0xff00ff);
			//g.drawRect(0, 0, size, size);
			g.endFill();
		}
		public function onMouseDown(e:MouseEvent = null):void {
			/*if (!isOpen && 0) {
				var g:Graphics = cover_mc.graphics;
				g.lineStyle(0);
				g.beginFill(0xffff00);
				g.drawRect(0, 0, size, size);
				g.endFill();
			}*/
		}
		public function onMouseUp(e:MouseEvent = null):void {
			if (!isOpen ) {
				isOpen = true;
				var g:Graphics = cover_mc.graphics;
				g.clear();
			}
		}
		
		public function get numMineRound():int { return _numMineRound; }
		
		public function set numMineRound(value:int):void 
		{
			_numMineRound = value;
			numText.text = value.toString();
			trace(value);
		}
		
		public function get isMine():Boolean { return _isMine; }
		public function addNeighbor(mine:Mine):void {
			neighbors.push(mine);
		}
		public function set isMine(value:Boolean):void 
		{
			_isMine = value;
			if (_isMine) {
				numText.text = "*";
				trace("this is mine.");
			}else {
				for (var i:int = 0; i < neighbors.length; i++) {
					var mine:Mine = neighbors[i] as Mine;
					if(mine.isMine) numMineRound++;
				}
			}
		}
	}
}