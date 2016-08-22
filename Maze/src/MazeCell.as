package  
{
	/**
	 * ...
	 * @author Eric_lin
	 */
	public class MazeCell 
	{
		public var row:int;
		public var col:int;
		public var up:Boolean = true;
		public var down:Boolean = true;
		public var right:Boolean = true;
		public var left:Boolean = true;
		//
		public var visited:Boolean = false;
		private var _next:MazeCell;
		
		public function MazeCell() 
		{
			
		}
		
		public function get next():MazeCell 
		{
			return _next;
		}
		
		public function set next(value:MazeCell):void 
		{
			_next = value;
			if (next.col > col) {
				right = false;
				next.left = false;
			}
			if (next.col < col) {
				left = false;
				next.right = false;
			}
			if (next.row>row) {
				down = false;
				next.up = false;
			}
			if (next.row < row) {
				up = false;
				next.down = false;
			}
			
		}
		
	}

}