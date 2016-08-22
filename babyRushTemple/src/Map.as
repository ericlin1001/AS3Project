package  
{
	import adobe.utils.CustomActions;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Map 
	{
		private var numCols:int;
		private var numRows:int;
		private var mapData:Array;
		public static const MAP_TYPE_BLANK:int = 0;
		public static const MAP_TYPE_ONEBOX:int = 1;
		public function Map(trow:int,tcol:int) 
		{
			numRows = trow;
			numCols = tcol;
			mapData = new Array(numRows);
			var row:int; var col:int;
			for ( row = 0; row < numRows; row++) {
				mapData[row] = new Array(numCols);
				for ( col = 0; col < numCols; col++) {
					mapData[row][col] =MAP_TYPE_BLANK;
				}
			}
			for (row = 0; row < numRows; row++) {
				mapData[row][0] = MAP_TYPE_ONEBOX;
				mapData[row][numCols-1] = MAP_TYPE_ONEBOX;
			}
			for (col = 0; col< numCols; col++) {
				mapData[0][col] = MAP_TYPE_ONEBOX;
				mapData[numRows-1][col] = MAP_TYPE_ONEBOX;
			}
		}
		public function getMapData():Array {
			return mapData;
			
		}
		public function test():Array {
			return mapData;
		}
		
	}
	
}