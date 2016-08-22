package 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Main extends Sprite 
	{
		private var puzzleDoc:PuzzleDoc;
		private var puzzleView:PuzzleView
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function onClick(e:MouseEvent):void {
			//solution:
			removeChild(e.currentTarget as DisplayObject);
			var tpuzzleView:PuzzleView = new PuzzleView(puzzleDoc.clone(), 50);
			tpuzzleView.x = 280;
			addChild(tpuzzleView);
			tpuzzleView.loadPic(null);
			tpuzzleView.update();
			tpuzzleView.drawGrid(true);
			//
			var solution:PuzzleSolution = new PuzzleSolution();
			var orders:Array = solution.solve(puzzleDoc);
			tpuzzleView.slowMoveByOrders(orders, 400);
			stage.focus = stage;
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry pointe
			//begin:
			puzzleDoc = new PuzzleDoc(4, 4);
			puzzleView = new PuzzleView(puzzleDoc, 60);
			addChild(puzzleView);
			puzzleView.loadPic(null);
			puzzleDoc.Disorders(400);
			puzzleView.update();
			puzzleView.drawGrid(true);
			//
			var t:Sprite = new Sprite();
			addChild(t);
			t.addEventListener(MouseEvent.CLICK, onClick);
			t.buttonMode = true;
			var g:Graphics = t.graphics;
			g.lineStyle(0);
			g.beginFill(0xffff00);
			g.drawRect(0, 0, 50, 20);
			g.endFill();
			var showText:TextField = new TextField();
			showText.text = "演示";
			showText.width = t.width;
			showText.height = t.height;
			showText.selectable = false;
			showText.autoSize = TextFieldAutoSize.CENTER;
			t.addChild(showText);;
			t.x = puzzleView.width+puzzleView.x + 20;
			t.y = puzzleView.height + puzzleView.y + 20;
			//
			
			//
			/*var puzzleDoc:PuzzleDoc = new PuzzleDoc(4, 5);
			var puzzleView:PuzzleView = new PuzzleView(puzzleDoc, 50);
			addChild(puzzleView);
			puzzleView.loadPic(null);
			
			//
			puzzleDoc.Disorders(400);
			puzzleView.update();
			puzzleView.drawGrid(true);
			//puzzleDoc.Disorders(200);
			//solution:
			var solution:PuzzleSolution = new PuzzleSolution();
			var orders:Array = solution.solve(puzzleDoc);
			puzzleView.slowMoveByOrders(orders,300);
			//*/
			
		}
		
	}
	
}