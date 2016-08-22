package  
{
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Matrix 
	{
		private var values:Array;
		private var numRows:int;
		private var numCols:int;
		public function Matrix(tnumRows:int=1,tnumCols:int=1) 
		{
			numRows = tnumRows;
			numCols = tnumCols;
			values = new Array(numRows);
			for (var i:int = 0; i < numRows; i++) {
				values[i] = new Array(numCols);
				for (var j:int = 0; j < numCols; j++) {
					values[i][j] = 0;
				}
			}
		}
		public function getEle(row:int, col:int):Number {
			return values[row][col];
		}
		public function multi(matrix:Matrix):Matrix {
			if (numCols == matrix.numRows) {
				var t:Matrix = new Matrix(numRows, matrix.numCols);
				for (var i:int = 0; i < t.numRows; i++) {
					for (var j:int = 0; j < t.numCols; j++) {
						var value:Number = 0;
						for (var k:int = 0; k < numCols; k++) {
							value += getEle(i, k) * matrix.getEle(k, j);
						}
						t.assign(i, j, value);
					}
				}
				return t;
			}
			return null;
		}
		static public function getRotationMatrix(angleX:Number = 0,angleY:Number=0,angleZ:Number=0):Matrix {
			var cos:Number;
			var sin:Number;
			var tranX:Matrix = new Matrix(3, 3);
			cos = Math.cos(angleX); sin = Math.sin(angleX);
			tranX.assign(0, 0, 1);tranX.assign(0, 1, 0);tranX.assign(0, 2, 0);
			tranX.assign(1, 0, 0);tranX.assign(1, 1, cos);tranX.assign(1, 2, sin);
			tranX.assign(2, 0, 0);tranX.assign(2, 1, -sin); tranX.assign(2, 2, cos);
			var tranY:Matrix = new Matrix(3, 3);
			cos = Math.cos(angleY); sin = Math.sin(angleY);
			tranY.assign(0, 0, cos);tranY.assign(0, 1, 0);tranY.assign(0, 2, sin);
			tranY.assign(1, 0, 0);tranY.assign(1, 1, 1);tranY.assign(1, 2, 0);
			tranY.assign(2, 0, -sin);tranY.assign(2, 1, 0);tranY.assign(2, 2, cos);
			var tranZ:Matrix = new Matrix(3, 3);
			cos = Math.cos(angleZ); sin = Math.sin(angleZ);
			tranZ.assign(0, 0, cos);tranZ.assign(0, 1, -sin);tranZ.assign(0, 2, 0);
			tranZ.assign(1, 0, sin);tranZ.assign(1, 1, cos);tranZ.assign(1, 2, 0);
			tranZ.assign(2, 0, 0);tranZ.assign(2, 1, 0);tranZ.assign(2, 2, 1);
			var r:Matrix = tranX.multi(tranY);
			r=r.multi(tranZ);
			return r;
		}
public function init(arr:Array):void {
			numRows = arr.length;
			numCols = arr[0].length;
			values = new Array(numRows);
			for (var i:int = 0; i < numRows; i++) {
				values[i] = new Array(numCols);
				for (var j:int = 0; j < numCols; j++) {
					values[i][j] = arr[i][j];
				}
			}
		}
		public function assign(row:int, col:int , value:Number):Number {
			if (isInRange(row, col)) {
				values[row][col] = value;
			}else {
				trace("("+row+","+col+") is out of range of Matrix["+numRows+"X"+numCols+"]:");
			}
			return value;
		}
		private function isInRange(row:int, col:int):Boolean {
			return (0 <= row && row < numRows && 0 <= col && col < numCols);
		}
		public function toString():String {
			var t:String = new String();
			t += "Matrix[" + numRows + "X" + numCols + "]:\n";
			for (var i:int = 0; i < numRows; i++) {
				t = t + values[i].toString();
			}
			return t;
		}
		
	}
	
}