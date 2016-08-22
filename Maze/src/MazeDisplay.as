package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	/**
	 * ...
	 * @author Eric_lin
	 */
	public class MazeDisplay extends Sprite
	{
		public var maze:MazeCreate;
		public  var cellSize:Number;//= 10;
		public function MazeDisplay(tmaze:MazeCreate,tsize:Number) 
		{
			maze = tmaze;
			cellSize = tsize;
			drawMaze();
		}
		public function drawMaze():void {
			graphics.clear();
			var cells:Array = maze.cells;
			for (var i:int = 0; i < cells.length; i++) 
			{
				for (var j:int = 0; j < cells[i].length; j++) 
				{
					drawCell(cells[i][j] as MazeCell,cellSize,graphics);
				}
			}
		}
		private function drawCell(cell:MazeCell,size:Number,g:Graphics):void {
			g.lineStyle(0);
			var tx:Number = cell.col * size;
			var ty:Number = cell.row * size;
			if (cell.up) {
				g.moveTo(tx, ty);
				g.lineTo(tx + size, ty);
			}
			if (cell.down) {
				g.moveTo(tx, ty+size);
				g.lineTo(tx + size, ty+size);
			}
			if (cell.left) {
				g.moveTo(tx, ty);
				g.lineTo(tx, ty+size);
			}
			if (cell.right) {
				g.moveTo(tx+size, ty);
				g.lineTo(tx+size, ty+size);
			}
			
			
		}
	}

}