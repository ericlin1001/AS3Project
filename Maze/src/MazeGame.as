import flash.display.Sprite;

		var maze:MazeCreate=null;
		var walker:MazeWalker=null;
		var showMaze:MazeDisplay = null;
		var size:Number = 20;
		init();
		var endPoint:EndPoint = new EndPoint();
		addChild(endPoint);
		endPoint.x = showMaze.x + (0.5+maze.endCell.col)* showMaze.cellSize;
		endPoint.y = showMaze.y + (0.5+maze.endCell.row) * showMaze.cellSize;
		endPoint.width = endPoint.height = size;
		//var t:Sprite
		setChildIndex(endPoint, 0);
		function init(e:Event = null):void {
			// entry point
			if (showMaze != null) {
				removeChild(showMaze);
			}
			maze = new MazeCreate(5, 5);
			showMaze = new MazeDisplay(maze, size);
			showMaze.x = 50;
			showMaze.y = 50;
			
			addChild(showMaze);
			//
			if (walker != null) {
				removeChild(showMaze);
				removeChild(walker);
			}
			walker = new MazeWalker(size * 0.75, size*0.8, canWalk);
			walker.x = showMaze.x + 0.5 * showMaze.cellSize;
			walker.y = showMaze.y + 0.5 * showMaze.cellSize;
			walker.a = size * 0.1;
			addChild(walker);
		}
		function win():void {
			walker.del();
			removeChild(showMaze);
			removeChild(walker);
			removeChild(endPoint);
			gotoAndStop("win");
			trace("a");
		}
		function canWalk(obj:DisplayObject):Boolean {
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
			var b:Boolean = (inX < 0 && cell.left) || (inY < 0 && cell.up) || (inX > smallSize && cell.right) || (inY > smallSize && cell.down);
			// is Win:
			if (row == maze.endCell.row && col == maze.endCell.col) {
				win();
			}
			//end
			return !b;
		}