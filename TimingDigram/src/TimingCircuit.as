package  
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class TimingCircuit extends Sprite
	{
		private var numState:int = 12;
		private var states:Array;
		public function TimingCircuit() 
		{
			 init();
		}
		private function init():void {
			states = new Array(numState);
			
		}
	}
	
}