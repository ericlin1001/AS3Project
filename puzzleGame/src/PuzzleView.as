package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class PuzzleView extends Sprite
	{
		private var numRows:int;
		private var numCols:int;
		private var size:uint;
		private var pics:Array;
		private var puzzleDoc:PuzzleDoc;
		//
		private var orders:Array;
		private var isMoving:Boolean=false;
		public function PuzzleView(tpuzzleDoc:PuzzleDoc,tsize:int=30) 
		{
			puzzleDoc = tpuzzleDoc;
			size = tsize;
			numRows = puzzleDoc.numRows;
			numCols = puzzleDoc.numCols;
			if (stage) {
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		public function slowMoveByOrders(arr:Array,delay:int=500):void {
			if (!isMoving) {
				
			isMoving = true;
			orders = new Array();
			var len:int = arr.length;
			for (var i:int = 0; i < arr.length; i++) 
			{
				orders[i] = new int(arr[len - i-1]);
			}
			trace("LEN=", len);
			var timer:Timer = new Timer(delay, len);
			timer.addEventListener(TimerEvent.TIMER, onTick);
			timer.start();
			}
		}
		public function drawGrid(isDel:Boolean=true):void {
			var i:int;
			graphics.clear();
			if (!isDel) {
				return ;
			}
			var g:Graphics = graphics;
			g.lineStyle(0);
			for ( i = 0; i <= numRows; i++) 
			{
				g.moveTo(0, i * size);
				g.lineTo(size * numCols, i * size);
			}
			for ( i = 0; i <= numCols; i++) 
			{
				g.moveTo( i * size,0);
				g.lineTo( i * size,size * numRows);
			}
		}
		private function onTick(e:TimerEvent):void {
			while (orders.length>0 && !puzzleDoc.moveBlank(orders.pop())){}
			update();
			if (orders.length == 0) {
					isMoving = false;
					(e.currentTarget as Timer).stop();
					trace("timer complete");
			}
			trace("tick:", (e.currentTarget as Timer).currentCount);
		}
		
		private function init(e:Event = null):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		protected function onKeyDown(e:KeyboardEvent):void {
			if (!isMoving) {
				puzzleDoc.move(e.keyCode-37);
				update();
			}
		}
		public function loadPic(bitmap:Bitmap=null):Boolean {
			pics = new Array();
			var i:int;
			if (bitmap == null) {
				for ( i = 0; i < numCols*numRows; i++) 
				{
					var item:TextField = new TextField();
					item.width = item.height = size;
					item.scaleX = item.scaleY = size/20;
					item.text = (i+1).toString();
					addChild(item);
					pics.push(item);
				}
			}else {
				for ( i = 0; i < numRows*numCols; i++) 
				{
					
				}
			}
			removeChild(pics[numRows * numCols - 1] as DisplayObject);
			return true;
		}
		public function update():void {
			if(pics!=null){
			for (var i:int = 0; i < numRows; i++) 
			{
				for (var j:int = 0; j < numCols; j++) 
				{
					var index:int= puzzleDoc.getIndex(i, j);
					if (index >= 0) {
						var item:DisplayObject = pics[index] as DisplayObject;
						item.x = j * size;
						item.y = i * size;
					}else {
						
					}
				}
			}
			}
		}
	}
	
}