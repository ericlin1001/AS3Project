package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var poss:Array = new Array();
			var colors:Array = new Array();
			var values:Array = new Array();
			var names:Array = new Array();
			for (var i:int = 0; i < 8; i++) {
				poss.push(new Point(0, 0.5 + (8-1-i) * 2.5));
				var r:uint = Math.random() * 256;
				var g:uint = Math.random() * 256;
				var b:uint = Math.random() * 256;
				var color:uint = r << 16 | g << 8 | b;
				colors.push(color);
				
				trace(color);
			}
			values[0] = "10101010101010101010101010101010"; names[0] = "Y";
			values[1] = "00110011001100110011001100110011"; names[1] = "F1";
			values[2] = "00001111000011110000111100001111"; names[2] = "F2";
			values[3] = "00000000111111110000000011111111"; names[3] = "F3";
			values[4] = "00000000000000001111111111111111"; names[4] = "F4";
			values[5] = "00111100001111000011110000111100"; names[5] = "G0";
			values[6] = "00001111111100000000111111110000"; names[6] = "G1";
			values[7] = "00000000111111111111111100000000"; names[7] = "G2";
			values[8] = "00000000000000001111111111111111"; names[8] = "G3";
			
			//
			var mgr:DiagManger = new DiagManger();
			addChild(mgr.getSprite());
			for (var j:int = 0; j < 8; j++) {
			mgr.creatSquareCurve(values[j], colors[j], poss[j],new Point(1,1),names[j]);
			}
			
		}
		
	}
	
}