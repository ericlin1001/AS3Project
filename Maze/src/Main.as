package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Eric_lin
	 */
	public class Main extends Sprite 
	{
		private var maze:MazeCreate;
		private var walker:MazeWalker;
		private var showMaze:MazeDisplay 
		private var size:Number = 15;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			maze = new MazeCreate(35, 35);
			showMaze = new MazeDisplay(maze, size);
			showMaze.x = 50;
			showMaze.y = 50;
			addChild(showMaze);
			//
			
			walker = new MazeWalker(size * 0.75, size*0.8, canWalk);
			walker.x = showMaze.x + 0.5 * showMaze.cellSize;
			walker.y = showMaze.y + 0.5 * showMaze.cellSize;
			walker.a = size*0.1;
			addChild(walker);
			
		}
		public function canWalk(obj:DisplayObject):Boolean {
		//	this.get
			var r:Rectangle = this.getRect(walker);
			var row:int = Math.floor((obj.y - showMaze.y) / showMaze.cellSize);
			var col:int = Math.floor((obj.x - showMaze.x) / showMaze.cellSize);
			//trace(obj, "row=" + row, "col=" + col);
			if (row < 0 || col < 0 || row > maze.numRows - 1 || col > maze.numCols - 1) {
				return false;
			}
			var cell:MazeCell = maze.cells[row][col];
			var inX:Number = obj.x - showMaze.x - col * showMaze.cellSize;
			var inY:Number = obj.y - showMaze.y - row * showMaze.cellSize;
			var smallSize:Number = showMaze.cellSize-obj.width;
			inX -= obj.width * 0.5;
			inY -= obj.width * 0.5;
			var b:Boolean = (inX < 0 && cell.left) || (inY < 0 && cell.up) || (inX >smallSize && cell.right) || (inY > smallSize && cell.down);
			
			return !b;
		}
		
		
	}
	
}