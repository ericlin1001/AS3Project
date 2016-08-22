package  
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ericlin
	 */
	public class puzzleGame extends Sprite
	{
		private var puzzles:Array;
		private var numCols:int = 5;
		private var numRows:int = 6;
		private var size:Number = 30;
		private var pics:Array;
		private var pcur:Point;
		private var orders:Array;
		public function puzzleGame() 
		{
			trace("starting...");
			init();
			drawPuzzle();
			orders = new Array();
			//orders = [3, 0, 2, 1, 0, 3, 2, 10, 0, 3, 2, 1, 0, 3, 21, 0, 3, 2, 1, 0, 32, 1, 0, 30, 2, 1, 3, 0, 1, 3, 0, 2, 1, 3, 1, 03, 1, 20, 3, 2, 1, 0, 3, 1, 0, 3, 2, 1,0, 3, 2, 3,2, 0, 1, 0,3, 1, 0, 0,1, 0,3, 2, 1,0,3,2,0, 1 ];
			orders = [3, 0, 2, 1, 0, 1, 0, 3, 2, 10, 0, 3, 2, 1, 1, 0, 32, 1, 0, 30, 2, 1, 3, 0, 1, 3,7, 0, 3,3, 2, 10, 0, 3, 2, 3, 2, 13,2,32,32,3,2,,3,23,23,,2,3,23,,32,2,3,2,33,,0, 3, 2, 3,2, 0, 0, 0, 3, 2, 1, 0, 3];
			orders=orders.concat(0, 0, 0, 1, 1, 1);
			trace("order:", orders);
			changeByOrders(orders);
			trace("after solving...");
			solve(puzzles, 0, 0);
			checkWin();
		
			if(stage) stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			else addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		private function solveCol(pline:int, pcol:int):void {
			moveTheSmall(pline, pcol, pline * numCols + pcol + 1 + numCols);
			//easy to make mistake!!!
			var tobj:Object = getPos(  pline * numCols + pcol + 1);
			if (tobj.row==(pline+1) && tobj.col==pcol) {
				//
				changeByOrders([2,3,0,1,0,3,2,2,1,0]);
			}
			//
			moveTheSmall(pline, pcol+1, pline * numCols + pcol + 1);
			//pcur:up2,lfet,down
			move(2, 2); move(3); move(0);
		}
		private function solveLine(pline:int):void {
			trace("***************start solveline***************");
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
				return;
			}
			//easy to make mistake!!!
			var tobj:Object = getPos( pline * numCols + pcol + 1);
			if (tobj.row==pline && tobj.col==(pcol+1)) {
				//
				changeByOrders([3,2,1,0,1,2,3,3,0,1]);
			}
			//
			if (!moveTheSmall(pline + 1, pcol, pline * numCols + pcol + 1))  {
				return ;
			}
			//pcur:up2,lfet,down
			movepCur(pcur.y, pcur.x, pline+2, pcol+1);
			move(3, 2); move(2); move(1);
			trace("***************end solveline***************");
		}
		private function moveTheSmall(row:int, col:int,targetNum:int=-1):Boolean {
			var num:int = row * numCols + col + 1;
			if (targetNum != -1) { num = targetNum; }
			var obj:Object = getPos(num);
			var trow:int = obj.row;
			var tcol:int = obj.col;
			var i:int;
			if (trow < row) {
				movepCur(pcur.y, pcur.x,trow+1, pcur.x);
				for (i = 0; i < row-trow; i++) {
					//pcur:up,right,down2,left
					move(3);move(0);move(1,2);move(2);
				}
			}
			if (tcol < col) {
				movepCur(pcur.y, pcur.x, pcur.y, tcol + 1);
				for (i = 0; i < col-tcol; i++) {
					//pcur:left,down,right2,up
					move(2);move(1);move(0,2);move(3);
				}
			}
			return moveToFirst(row, col, num);
		}
		private function solve(arr:Array, row:int,col:int):Array {
			var tempOrders:Array = new Array();
			var pline:int = row;//
			var pcol:int = col;
			while (pline < numRows - 2) {
				solveLine(pline);
				pline++;
			}
			while (pcol < numCols - 2) {
				solveCol(pline, pcol);
				pcol++;
			}
			moveToFirst(pline, pcol);
			return tempOrders;
		}
		private function movepCur(row:int, col:int, trow:int, tcol:int):void {
			var drow:int = trow - row;
			var dcol:int = tcol - col;
			if (drow > 0) {
				move(1, Math.abs(drow));
			}else {
				move(3, Math.abs(drow));
			}
			if (dcol > 0) {
				move(0, Math.abs(dcol));
			}else {
				move(2, Math.abs(dcol))
			}
		}
		private function moveToFirst(row:int, col:int,targetNum:int=-1):Boolean{
			trace("start moveToFist","num="+targetNum);
			
			var num:int = row * numCols + col + 1;
			if (targetNum != -1) { num = targetNum; }
			//if (num ==7) { return false; }
			var obj:Object = getPos(num);
			var trow:int = obj.row;
			var tcol:int = obj.col;
			if (trow < row || tcol < col || row>numRows-2 || col >numCols-2) {
				trace("error! in moveToFirst.(out of range)"+"trow="+ trow+ "tcol="+ tcol+"num="+num);
				return false;
			}else {
				if (pcur.x < col || pcur.y < row) {
					trace("pcur is not in range!(in moveTofirst)");
				}else {
					trace("start dealing (row,col),(trow,tcol)",row,col,trow,tcol);
					//start dealing...
					// move target up
						if (trow > row) {
							movepCur(pcur.y, pcur.x, row, col);
							obj = getPos(num);
							trow = obj.row;
							tcol = obj.col;
							//the target must be below the row.
							movepCur(pcur.y, pcur.x, trow - 1, tcol);
							for (var  i:int = 0; i < trow-row-1;i++ ) {
								if (tcol == numCols - 1) {
									//靠边的时候
									move(1);move(2);move(3,3);move(0);//pcur:down,left,up3,right
								}else {
									trace("in here.");
									move(1);move(0);move(3,2);move(2);//pcur:down,right,up3,left
								}
							}
							move(1);//pCur:down
						}else {
							if (pcur.y == trow) {
								move(1);//pcur:down
							}
						}
					//move targe left
					//actually the tcol is not change,so obmit update tcol.
					trow = row;
					trace("in move target left.");
					trace("row=" + row, "col=" + col);
					trace("trow=" + trow, "tcol=" + tcol);
					if (tcol > col) {
						movepCur(pcur.y, pcur.x, pcur.y, tcol - 1);
						movepCur(pcur.y, pcur.x, trow ,pcur.x);
						for (var  j:int = 0; j < tcol-col-1;j++ ) {
							move(0);move(1);move(2,2);move(3);//pcur:right,down,left3,up
						}
						move(0);//pCur:right
					}
					//set the pcur (trow+1,tcol+1)
					movepCur(pcur.y, pcur.x, row + 1, col + 1);
					return true;
				}
			}
			trace("end moveToFirst.");
			return false;
		}
		private function getPos(targetNum:int):Object {
			var obj:Object = new Object();
			obj.row = -1;
			obj.col = -1;
			
			for (var i:int = 0; i < numRows; i++) {
				for (var  j:int = 0; j < numCols; j++) {
					if (puzzles[i][j]!=null && int((puzzles[i][j] as TextField).text) == targetNum) {
						obj.row = i;
						obj.col = j;
					}
				}
			}
			
			return obj;
		}
		private function checkWin():Boolean {
			var  b:Boolean = true;
			for (var i:int = 0; i < numCols*numRows-1 ; i++) 
			{
				var px:uint = i % numCols;
				var py:uint = (i - px) / numCols;
				if (puzzles[py][px] != pics[py][px]) {
					b = false;
				}
			}
			if (b) {
				trace("you win!!");
			}
			return b;
		}
		private function changeByOrders(torders:Array):void {
			for (var i:int = 0; i < torders.length; i++) {
				move(torders[i]);
			}
		}
		private function changeOrder(max:int=1000):void {
			var maxNumOrders:int = 10;
			orders = new Array();
			for (var i:int = 0; i < maxNumOrders; i++) {
				orders.push(Math.floor(Math.random() * 4));
			}
		}
		private function addedToStage(e:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		public function move(i:int,times:int=1):void {
			while (times>0) {
				times--;
			var oldx:int = pcur.x;
			var oldy:int = pcur.y;
			i = i % 4;
			switch(i) {
				case 0://left
				case 65://a
					if (pcur.x < numCols - 1) {
						pcur.x++;
					}
				break;
				case 1://up
				case 87://w
					if (pcur.y <numRows-1) {
						pcur.y++;
					}
				break;
				case 2://right
				case 68://d
					if (pcur.x >0) {
						pcur.x--;
					}
				break;
				case 3://down
				case 83://s
					if (pcur.y >0) {
						pcur.y--;
					}
				break;
				default:
				break;
			}
			var pic:Object = puzzles[pcur.y][pcur.x]as Object;
			if ( pic != null) {
				puzzles[pcur.y][pcur.x] = null;
				pic.x = oldx * size;
				pic.y = oldy * size;
				puzzles[oldy][oldx] = pic;
			}
			}
		}
		private function onKeyDown(e:KeyboardEvent = null):void {
			//trace(e.keyCode);
			move(e.keyCode-37);
			
		}
		
		private function drawPuzzle():void {
			var g:Graphics = graphics;
			g.lineStyle(0);
			for (var i:int = 0; i < numRows; i++) {
				for (var  j:int = 0; j < numCols; j++) {
					g.drawRect(j * size, i * size, size, size);
					
				}
			}
		}
		private function loadPics():void {
			pics = new Array();
			for (var i:int = 0; i < numRows; i++) {
				pics[i] = [];
				for (var  j:int = 0; j < numCols; j++) {
					var item:TextField = new TextField();
					//item.caretIndex = i * numCols + j;
					item.scaleX = item.scaleY = 2.0;
					item.text = (i*numCols+j+1).toString();
					pics[i][j] = item;
					//trace(int(item.text))
				}
			}
		}
		private function init():void {
			loadPics();
			puzzles = new Array();
			for (var i:int = 0; i < numRows; i++) {
				puzzles[i] = [];
				for (var  j:int = 0; j < numCols; j++) {
					puzzles[i][j] = pics[i][j];
					var item:DisplayObject = pics[i][j] as DisplayObject;
					item.x = j * size;
					item.y = i * size;
					addChild(item);
				}
			}
			
			pcur = new Point();
			pcur.x = numCols - 1;
			pcur.y = numRows - 1;
			removeChild(puzzles[pcur.y][pcur.x]);
			puzzles[pcur.y][pcur.x] = null;
		}
	}
	
}