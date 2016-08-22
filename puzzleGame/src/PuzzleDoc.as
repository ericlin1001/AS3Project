package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class PuzzleDoc 
	{
		public var numCols:int;
		public var numRows:int;
		protected var puzzles:Array;
		protected var blankRow:int;
		protected var blankCol:int;//-1 represet the blank.
		public function PuzzleDoc(trows:uint,tcols:uint) 
		{
			numRows = trows;
			numCols = tcols;
			reset();
		}
		public function reset():void {
			puzzles = new Array();
			for (var i:int = 0; i < numRows ; i++) 
			{
				for (var j:int = 0; j < numCols; j++) 
				{
					puzzles[i * numCols + j] = i * numCols + j;
				}
			}
			puzzles[numRows * numCols - 1] = -1;
			blankRow = numRows - 1;
			blankCol = numCols - 1;
			//the lastest one represent the blank.
		}
		public function clone():PuzzleDoc {
			var temp:PuzzleDoc = new PuzzleDoc(numRows, numCols);
			temp.puzzles = getPuzzlesClone();
			temp.blankCol = blankCol;
			temp.blankRow = blankRow;
			temp.puzzles[blankRow * numCols + blankCol] = -1;
			return temp;
		}
		public function getPuzzlesClone():Array {
			var temp:Array = new Array();
			for (var i:int = 0; i < puzzles.length; i++) 
			{
				temp[i] = new int(puzzles[i]);
			}
			return temp;
		}
		public function getBlankRow():int {
			return blankRow;
		}
		public function getBlankCol():int {
			return blankCol;
		}
		public function Disorders(changeNum:uint=40):void {
			while (changeNum > 0) {
				var rand:uint = Math.floor(Math.random() * 4);
				//trace(rand);
				if (moveBlank(rand)) {
					changeNum--;
				}
			}
			moveBlank(2, numCols - 1);
			moveBlank(3, numRows - 1);
		}
		public function checkWin():Boolean {
			var  b:Boolean = true;
			for (var i:int = 0; i < numCols*numRows-1 ; i++) 
			{
				if (puzzles[i] != i) {
					b = false;
				}
			}
			if (puzzles[numCols * numRows - 1] != -1) {
				b = false;
			}
			if (b) {
				trace("test:you win!!");
			}
			return b;
		}
		public function move(direction:int, times:int = 1):Boolean {
			//0:left,1:up,2:right,3:down
			//trace("in move direction:" + direction);
			return moveBlank((direction % 2+1) * 2 - direction, times);
		}
		public function moveBlank(direction:int,times:int=1):Boolean {
			//return the last time result.
			//left:0,right:2	up:1,down:3
			//trace("in moveBlank direction:" + direction);
			var allSuccess:Boolean = true;
			while (times>0) {
				times--;
				var i:int = direction % 4;
				if (i % 2) {
					//1,3
					i -= 2;
					var targetRow:int = blankRow + i;
					if (0 <= targetRow && targetRow < numRows) {
						setCell(blankRow, blankCol, getCell(targetRow,blankCol));
						blankRow = targetRow;
						setCell(blankRow, blankCol, -1);
					}else{
						allSuccess = false;
					}
				}else {
					//0,2
					i -= 1;
					var targetCol:int = blankCol + i;
					if (0 <= targetCol && targetCol < numCols) {
						setCell(blankRow, blankCol, getCell(blankRow, targetCol));
						blankCol = targetCol;
						setCell(blankRow, blankCol, -1);
					}else{
						allSuccess = false;
					}
				}
			}
			return allSuccess;
			
		}
		public function moveByOrders(arr:Array):void {
			for (var i:int = 0; i < arr.length; i++) 
			{
				moveBlank(arr[i]);
			}
		}
		public function getIndex(row:uint, col:uint):int {
			if (row < numRows && col < numCols) {
				return puzzles[row * numCols + col];
			}else {
				trace("error! in PuzzleDoc::getIndex()", "row=" + row + ",col=" + col);
				return -2;
			}
			return -2;
		}
		protected function setCell(row:int, col:int, value:int):void {
			puzzles[row * numCols + col] = value;
		}
		protected function getCell(row:int, col:int):int {
			return puzzles[row * numCols + col];
		}
	}
	
}