package{
	import adobe.utils.CustomActions;
	import adobe.utils.ProductManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class FindMinesGames extends Sprite {
		private var mines:Array = new Array();
		private var numMines:int=10;
		private var a:Number=30;
		private var numCols:int=5;
		private var numRows:int=6;
	private var minesContainer:Sprite;
		public function FindMinesGames() {
			minesContainer = new Sprite();
			addChild(minesContainer);
			init();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function initMines():void {
			//create mines
			var i:int; var j:int; var mine:Mine;
			for (i = 0; i < numRows; i++) {
				var temp:Array = new Array();
				for ( j = 0; j < numCols; j++) {
					 mine = new Mine(a);
					mine.y = i * a;
					mine.x = j * a;
					minesContainer.addChild(mine);
					temp.push(mine);
				}
				mines.push(temp);
			}	
			//
			var mineIndexs:Array = new Array();
			for (i = 0; i < numMines; i++) {
				var index:int = getUniqueNum(mineIndexs, 0, numRows * numCols - 1);
				mineIndexs.push(index);
				trace("index:", index);
				var trow:int = Math.floor(index / numCols);
				var tcol:int = index % numCols;
				trace("[" + trow + "][" + tcol + "] is mine.");
				mine = mines[trow][tcol] as Mine;
				mine.isMine = true;
				addNeighbors(mine, i, j);
				for (j = 0; j < mine.neighbors.length; j++) {
					//(mine.neighbors[i] as Mine).numMineRound++;
				}
			}
			/*trace("mineIndexs: " + mineIndexs);*/
			for (i = 0; i < numRows; i++) {
				for (  j = 0; j < numCols; j++) {
					 mine = mines[i][j] as Mine;
					 //if (!mine.isMine) mine.isMine = false;
				}
			}
		}
		private function addNeighbor(mine:Mine, row:int, col:int):void {
			if(0<=row && row< numRows && 0<=col && col < numCols){
				mine.addNeighbor(mines[row][col] as Mine);
			}
		}
		private function addNeighbors(mine:Mine, row:int, col:int):void {
			addNeighbor(mine,row + 1, col + 1);
			addNeighbor(mine,row + 1, col + 0);
			addNeighbor(mine,row + 1, col - 1);
			addNeighbor(mine,row + 0, col - 1);
			addNeighbor(mine,row - 1, col - 1);
			addNeighbor(mine,row - 1, col - 0);
			addNeighbor(mine,row - 1, col + 1);
			addNeighbor(mine,row - 0, col + 1);
		}
		private function init():void {
			initMines();
		}
		private function onMouseDown(e:MouseEvent):void {
			var ccol:int = mouseX / a;
			var crow:int = mouseY / a;
			var mine:Mine = mines[crow][ccol] as Mine;
			mine.onMouseDown();
		}
		private function onMouseUp(e:MouseEvent):void {
			var ccol:int = mouseX / a;
			var crow:int = mouseY / a;
			var mine:Mine = mines[crow][ccol] as Mine;
			mine.onMouseUp();
		}
		private function getUniqueNum( arr:Array,min:int,max:int):int {
			var bUnique:Boolean = true;
			var t:int;
			do {
				bUnique = true;
				t = Math.random() * (max + 1 - min) + min;
				for (var i:int = 0; i < arr.length; i++) {
					if (arr[i] == t) {
						bUnique = false;
						break;
					}
				}
			}while (!bUnique);
			return t;
		}
	}
}