package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class SignalUnit 
	{
		private var x:Number=0;
		private var y:Number=0;
		public function getX():Number {
			return x;
		}
		public function getY():Number {
			return y;
		}
		/*public function setPhraseAltitude(p:Number, a:Number):void {
			
		}*/
		public function setXY(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		public function getString():String {
			return "(" +
			//"(x,y)=" + x + "," + y+
			 x + "," + y+
			 ")";
		}
		public function toString():String {
			/*return "[SignalUnit(" +
			//"(x,y)=" + x + "," + y+
			 x + "," + y+
			 ")]";*/
			 return getString();
		}
	}
	
}