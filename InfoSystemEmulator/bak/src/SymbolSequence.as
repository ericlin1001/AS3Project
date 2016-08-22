package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class SymbolSequence 
	{
		//limit to contain only lower cast character,e.g. abcdef
		private var symbolTable:SymbolTable;
		private var symbolIndexs:Array;
		public function SymbolSequence(s:String = "") {
			constructSymbolTable();
			symbolIndexs = new Array();
		
			for (var i:int = 0; i < s.length; i++) {
				var index:int = symbolTable.getIndex(s.charAt(i));
				if (index == -1) {
					symbolIndexs.push(symbolTable.getIndex("?"));
				}else {
					symbolIndexs.push(index);
				}
			}
		
		}
		private function constructSymbolTable():void {
			symbolTable = new SymbolTable();
			for (var i:int = 0; i < 26; i++) {
				symbolTable.addSymbol(String.fromCharCode('a'.charCodeAt(0) + i));
			}
			symbolTable.addSymbol('?');//as unknow symbol.
		}
		public function getSymbolTable():SymbolTable {
			return this.symbolTable;
		}
		public function getSymbolIndexs():Array {
			return symbolIndexs;
		}
		public function getString():String {
			var str:String = "";
			for (var i:int = 0; i < symbolIndexs.length; i++) {
				str += symbolTable.getSymbol(symbolIndexs[i]);
			}
			return str;
		}
		public function toString():String {
			return "[SymbolSequence(\"" + getString() + "\")]";
		}
	}
	
}