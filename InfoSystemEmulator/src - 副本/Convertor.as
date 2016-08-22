package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class  Convertor
	{
		static public function convertToInt(bs:BitStream):int {
			var bits:Array = bs.getBits();
			var an:int = 0;
			for (var i:int = bits.length - 1;i>=0; i--) {
				an *= 2;
				an += bits[i];
			}
			return an;
		}
		static public function convertToBitStream(src:int,len:int):BitStream {
			var bits:Array = new Array();
			//Array [ 0,1,2,....]
			//        low ---- > high bit.
			for (var i:int = 0; i < len; i++) {
				bits.push(src % 2);
				src/= 2;
			}
			return new BitStream(bits);
		}
		static public function convertToSignal(src:int):Signal {
			var units:Array = new Array();
			var unit:SignalUnit = new SignalUnit();
			if (src == 0) {
				unit.setXY(-1, 0);
			}else {
				unit.setXY(1, 0);
			}
			units.push(unit);
			return new Signal(units);
		}
		
	}
	
}