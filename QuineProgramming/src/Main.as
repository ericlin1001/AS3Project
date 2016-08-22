package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author EricLin
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			var s:String = "\n\"\\;";
			var h:String = "var h:String=var s:String=var r:String=";
			var r:String = "trace(h.substring(13, 26)+ s.charAt(1) + s.charAt(2) + h.charAt(10)+s.charAt(2) + s.charAt(1) +s.charAt(2) +s.charAt(3) +s.charAt(1)+s.charAt(3)+s.charAt(0)+h.substring(0, 13)+ s.charAt(1)+h+s.charAt(1)+s.charAt(3)+ s.charAt(0)+h.substring(26, 39) + s.charAt(1) + r + s.charAt(1) + s.charAt(3));";
			trace(h.substring(13, 26)+ s.charAt(1) + s.charAt(2) + h.charAt(10)+s.charAt(2) + s.charAt(1) +s.charAt(2) +s.charAt(3) +s.charAt(1)+s.charAt(3)+s.charAt(0)+h.substring(0, 13)+ s.charAt(1)+h+s.charAt(1)+s.charAt(3)+ s.charAt(0)+h.substring(26, 39) + s.charAt(1) + r + s.charAt(1) + s.charAt(3)+s.charAt(0)+r);
		}
		

		
	}
	
}