package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class SymbolSequence 
	{
		//limit to contain only lower cast character,e.g. abcdef
		private var symbolTable:SymbolTable=SymbolTable.getSingleton();
		private var symbolIndexs:Array;
		public function SymbolSequence(s:String = "") {
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
		public function append(ss:SymbolSequence):void {
			symbolIndexs = symbolIndexs.concat(ss.symbolIndexs);
		}
	
		public function addSymbolIndex(index:int):void {
			if (index < 0 || index >= symbolTable.getLength()) {
				index = symbolTable.getLength() - 1;
			}
			symbolIndexs.push(index);
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