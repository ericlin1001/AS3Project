package  
{
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class PuzzleSolution extends PuzzleDoc
	{
		//private var numRows:int;
		//private var numCols:int;
		//private var puzzleDoc:PuzzleDoc;
		private var orders:Array=new Array();
		public function PuzzleSolution() 
		{
			super(1,1);
			//puzzleDoc = tpuzzleDoc;
			//numRows = puzzleDoc.numRows;
			//numCols = puzzleDoc.numCols;
		}
		override public function moveBlank(direction:int, times:int = 1):Boolean 
		{
			for (var i:int = 0; i < times; i++) 
			{
				orders.push(direction);
			}
			
			return super.moveBlank(direction, times);
		}
		public function solve(puzzleDoc:PuzzleDoc):Array
		{
			orders = new Array();
			//initializing...
			numRows = puzzleDoc.numRows;
			numCols = puzzleDoc.numCols;
			puzzles = puzzleDoc.getPuzzlesClone();
			/*puzzles = [2,0,
4,1,
7,3,
5,9,
6,11,
10,8,
12,-1,];*/
			//for test:
			trace("puzzles=");
			for (var i:int = 0; i < numRows; i++) {
				var t:String = "";
				for (var j:int = 0; j < numCols; j++) {
					t+=getCell(i,j)+","
				}
				trace(t);
			}
			//end for test.
			blankRow = puzzleDoc.getBlankRow();
			blankCol = puzzleDoc.getBlankCol();
			//start solving...
		//	moveTheSmall(0, 0);
		//	moveTheSmall(0, 1);
		//	moveTheSmall(0, 2);
		//	solveLine(0);
		//	solveLine(1);
			//trace(moveTheSmall(1, 0,4));
		//	moveToFirst(1, 0, 10);
		//	moveTheSmall(0, 1);
		//	moveTheSmall(0, 2);
			var pline:int = 0;//
			var pcol:int = 0;
			while (pline < numRows - 2) {
				solveLine(pline);
				pline++;
			}
			while (pcol < numCols - 2) {
				solveCol(pline, pcol);
				pcol++;
			}
			//for test
			//solveCol(pline,0);
			//end test.
			moveToFirst(pline, pcol);
			if (!checkWin()) {
				trace("!!!!!!!!!can't find the answer!!!!!!!!!!");
				return null;
			}
			//end solving...
			//delete some useless step:
			var temp:Array = new Array();
			temp[0] = orders[0];
			for ( i = 1; i < orders.length; i++) 
			{
				if (Math.abs(temp[temp.length-1] - orders[i]) != 2) {
					temp.push(orders[i]);
				}else {
					temp.pop();
				}
			}
			//
			trace("orders.len=", orders.length);
			trace("temp.len=", temp.length);
			return temp;
		}
		
		private function solveCol(pline:int, pcol:int):void {
			moveTheSmall(pline, pcol, pline * numCols + pcol + 1 + numCols);
			//easy to make mistake!!!
			var tobj:Object = getPos(  pline * numCols + pcol + 1);
			if (tobj.row==(pline+1) && tobj.col==pcol) {
				//
				trace("int solveCol easy mistake.");
				moveByOrders([0,1,2,3,2,1,0,0,3,2]);
				//			 [2,3,0,1,0,3,2,2,1,0]
			}
			//
			moveTheSmall(pline, pcol+1, pline * numCols + pcol + 1);
			//pcur:left2,up,right
			moveBlank(0, 2); moveBlank(1); moveBlank(2);
		}
		private function getPos(targetNum:int):Object 
		{
			var obj:Object = new Object();
			obj.row = -1;
			obj.col = -1;
			for (var i:int = 0; i < numRows; i++) {
				for (var  j:int = 0; j < numCols; j++) {
					if ((getIndex(i,j)+1)== targetNum) {
						obj.row = i;
						obj.col = j;
					}
				}
			}
			
			return obj;
		}
		private function solveLine(pline:int):void 
		{
			trace("***************start solve line: "+pline+"***************");
			if (pline >= numRows - 2) {
				trace("error!in solveLine().");
				return ;
			}
			var pcol:int = 0;
			while (pcol < numCols - 2) {
				if (!moveTheSmall(pline, pcol)) {
					return ;
				}
				pcol++;
			}
			//move the latest one to the back second of the  line
			if (!moveTheSmall(pline, pcol, pline * numCols + pcol + 1 + 1)) {
				trace("error in solve line .(move the latest ont to the back.)");
				return;
			}
			trace("before easy to make mistake!!!");
			//easy to make mistake!!!
			var tobj:Object = getPos( pline * numCols + pcol + 1);
			if (tobj.row==pline && tobj.col==(pcol+1)) {
				//
				trace("in easy mistake.");
				moveByOrders([1, 0, 3, 2, 3, 0, 1, 1, 2, 3]);
				//                    [3,2,1,0,1,2,3,3,0,1]
			}
			//
			if (!moveTheSmall(pline + 1, pcol, pline * numCols + pcol + 1))  {
				trace("error insolve line. after easy to make mistake.)");
				return ;
			}
			//pcur:up2,left,down
			trace("pcur:up2,left,down");
			movepCur(blankRow, blankCol, pline+2, pcol+1);
			moveBlank(1, 2); moveBlank(0); moveBlank(3);
			trace("***************end solveline***************");
		}
		private function moveTheSmall(row:int, col:int, targetNum:int = -1):Boolean
		{
			
			var num:int = row * numCols + col + 1;
			if (targetNum != -1) { num = targetNum; }
			trace("start moveTheSmall num=" + num);
			var obj:Object = getPos(num);
			var trow:int = obj.row;
			var tcol:int = obj.col;
			var i:int;
			if (trow < row) {
				//movepCur(blankRow, blankCol, trow + 1, tcol);
				//trace("in moveTheSmall trow<row num= " + num);
				//actually this must not happen.
				trace("Error:logical error!!!!!!!!");
			}
			if (tcol < col) {
				movepCur(blankRow, blankCol, trow, tcol + 1);
				trace("in moveTheSmall tcol<col num= "+num);
				for (i = 0; i < col-tcol; i++) {
					if (trow == numRows - 1) {
						//pcur:left,up,right2,down
						moveByOrders([0, 1, 2, 2, 3]);
					}else{
						//pcur:left,down,right2,up
						moveByOrders([0, 3, 2, 2, 1]);
					}
				}
			}
			return moveToFirst(row, col, num);
		}
		private function movepCur(row:int, col:int, trow:int, tcol:int):void {
			var drow:int = trow - row;
			var dcol:int = tcol - col;
			if (drow > 0) {
				moveBlank(3, Math.abs(drow));
			}else {
				moveBlank(1, Math.abs(drow));
			}
			if (dcol > 0) {
				moveBlank(2, Math.abs(dcol));
			}else {
				moveBlank(0, Math.abs(dcol))
			}
		}
		private function moveToFirst(row:int, col:int, targetNum:int = -1):Boolean
		{
			
			var num:int = row * numCols + col + 1;
			if (targetNum != -1) { num = targetNum; }
			//for test
			//if (num >= 3) { return false; }
			//end test
			var obj:Object = getPos(num);
			var trow:int = obj.row;
			var tcol:int = obj.col;
			//
			trace("start moveToFist", "num=" + targetNum);
			trace("row=" + row + "  col=" + col);
			//
			if (trow < row || tcol < col || row>numRows-2 || col >numCols-2) {
				trace("Error! in moveToFirst.(out of range)"+"trow="+ trow+ "tcol="+ tcol+"num="+num);
				return false;
			}else {
				if (blankCol < col || blankRow < row) {
					trace("Error:! pcur is not in range!(in moveTofirst)");
					return false;
				}else {
					trace("start move(up); (trow,tcol),num",trow,tcol,num);
					//start dealing...
					// move target up
						if (trow > row) {
							trace("need move up");
							movepCur(blankRow, blankCol, row, col);
							obj = getPos(num);
							trow = obj.row;
							tcol = obj.col;
							//the target must be below the row.
							movepCur(blankRow, blankCol, trow - 1, tcol);
							for (var  i:int = 0; i < trow-row-1;i++ ) {
								if (tcol == numCols - 1) {
									//靠边的时候
									//pcur:down,left,up2,right
									moveBlank(3);moveBlank(0);moveBlank(1,2);moveBlank(2);
								}else {
									//pcur:down,right,up2,left
									moveBlank(3);moveBlank(2);moveBlank(1,2);moveBlank(0);
								}
							}
							trace("it move up:" + (trow - row));
							trace("trow="+trow+" tcol="+tcol);//trace the position.
							moveBlank(3);//pCur:down
						}else {
							if (blankRow == trow) {
								moveBlank(3);//pcur:down
							}
						}
					//move targe left
					//actually the tcol is not change,so obmit update tcol.
					trow = row;
					trace("start dealing move(left).num,trow,tcol,row,col",num,trow,tcol,row,col);
					if (tcol > col) {
						trace("trow="+trow+" tcol="+tcol);//trace the position.
						trace("need move left");
						movepCur(blankRow, blankCol, blankRow, tcol - 1);
						movepCur(blankRow, blankCol, trow ,blankCol);
						for (var  j:int = 0; j < tcol - col - 1; j++ ) {
							//pcur:right,down,left3,up
							moveBlank(2);moveBlank(3);moveBlank(0,2);moveBlank(1);
						}
						moveBlank(2);//pCur:right
						trace("trow="+trow+" tcol="+tcol);//trace the position.
						trace("it move left:" + (tcol - col));
					}
					//set the pcur (trow+1,tcol+1)
					movepCur(blankRow, blankCol, row + 1, col + 1);
					return true;
				}
			}
			trace("error in the end of moveToFirst.");
			return false;
		}
		/*
		 * 
		
		*/
		
	}
	
}