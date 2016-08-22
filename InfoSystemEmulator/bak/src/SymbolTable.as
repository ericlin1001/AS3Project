package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class  SymbolTable
	{
		private var table:Array;
		public function SymbolTable() {
			table = new Array();
		}
		public function addSymbol(s:String):void {
			if (table.indexOf(s) == -1) {
				table.push(s);
			}
		}
		public function getIndex(symbol:String):int {
			return table.indexOf(symbol);
		}
		public function getSymbol(index:int):String {
			return table[index];
		}
	}
	
}