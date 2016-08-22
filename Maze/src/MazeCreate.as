package  
{
	/**
	 * ...
	 * @author Eric_lin
	 */
	public class MazeCreate 
	{
		public var numCols:int ;
		public var numRows:int ;
		public var numTotalCells:int;
		public var cells:Array;
		private var startCell:MazeCell;
		public var paths:Array;
		private var head:MazeCell;
		private var numVisits:int = 0;
		public function MazeCreate(tnumRows:int,tnumCols:int) 
		{
			
			//
			numRows = tnumRows;
			numCols = tnumCols;
			numTotalCells = numRows * numCols;
			//var cell:MazeCell = ;
			//	cells[4][5].up = false;
			//	cells[3][5].down = false;
			createMaze();
			trace("create complete.!");
		}
		public function get endCell():MazeCell {
			return cells[numRows - 1][numCols - 1];
		}
		private function getCellNeigbors(cell:MazeCell):Array {
			var temp:Array = new Array();
			var row:int = cell.row;
			var col:int = cell.col;
			if (row > 0) {
				temp.push(cells[row - 1][col]);
			}
			if (col > 0) {
				temp.push(cells[row][col-1]);
			}
			if (row <numRows-1) {
				temp.push(cells[row + 1][col]);
			}
			if (col<numCols-1) {
				temp.push(cells[row][col+1]);
			}
			return temp;
			
		} 
		private function getNext(cell:MazeCell):MazeCell {
			if (!cell.visited) {
				cell.visited = true;
				numVisits++;
			}
			if (numVisits == numTotalCells) {
				return null;
			}
			if (cell == startCell && numVisits > 1) {
				return null;
			}
			paths.push(cell);
			var neigbors:Array = getNotVisitedNeigbors(cell);
			//neigbors = getNotVisited(neigbors);
			if (neigbors.length > 0) {
				var r:int = Math.floor(Math.random() * neigbors.length);
				head = neigbors[r] as MazeCell;
				head.next = cell;
				return head;
			}else {
				return cell.next;
			}
			
		}
		private function createMaze():void {
			//
			paths = [];
			cells = [];
			var cell:MazeCell 
			for (var i:int = 0; i < numRows; i++) 
			{
				cells[i] = [];
				for (var j:int = 0; j < numCols; j++) 
				{
					cell = new MazeCell();
					cell.row = i;
					cell.col = j;
					cells[i][j] = cell;
				}
				
			}
			//
			startCell = cells[0][0];
			cell = startCell;
			while (cell = getNext(cell)){}
			//getNext(startCell);
			trace("numVisits="+numVisits);
		}
		private function getNotVisitedNeigbors(cell:MazeCell):Array {
			var temp:Array = new Array();
			var row:int = cell.row;
			var col:int = cell.col;
			if (row > 0) {
				temp.push(cells[row - 1][col]);
			}
			if (col > 0) {
				temp.push(cells[row][col-1]);
			}
			if (row <numRows-1) {
				temp.push(cells[row + 1][col]);
			}
			if (col<numCols-1) {
				temp.push(cells[row][col+1]);
			}
			//
			var arr:Array = [];
			for (var i:int = 0; i < temp.length; i++) {
				var cell:MazeCell = temp[i] as MazeCell;
				if (!cell.visited) {
					arr.push(cell);
				}
			}
			return arr;
			//
			return temp;
		}
		private function getNotVisited(arr:Array):Array {
			var temp:Array = new Array();
			for (var i:int = 0; i < arr.length; i++) {
				var cell:MazeCell = arr[i] as MazeCell;
				if (!cell.visited) {
					temp.push(cell);
				}
			}
			return temp;
		}
	
		
	}

}