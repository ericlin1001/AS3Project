package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class  SymbolTable
	{
		private var table:Array;
		static private var st:SymbolTable = new SymbolTable();
		public function SymbolTable() {
			//shouldn't be invoked outside.
			//This class is based on singlton pattern.
			table = new Array();
			constructSymbolTable();
		}
		public function addSymbol(s:String):void {
			if (table.indexOf(s) == -1) {
				table.push(s);
			}
		}
		public function getLength():int {
			return table.length;
		}
		public function getIndex(symbol:String):int {
			return table.indexOf(symbol);
		}
		public function getSymbol(index:int):String {
			return table[index];
		}
		static public function getSingleton():SymbolTable {
			return st;
		}
		private function constructSymbolTable():void {
			for (var i:int = 0; i < 26; i++) {
				this.addSymbol(String.fromCharCode('a'.charCodeAt(0) + i));
				this.addSymbol(String.fromCharCode('A'.charCodeAt(0) + i));
			}
			this.addSymbol(' ');
			this.addSymbol('!');
			this.addSymbol('[');
			this.addSymbol(']');
			this.addSymbol('?');//as unknow symbol.
		}
	}
	
}