package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class CircuitEvent extends Event 
	{
		public static const INPUT : String = "input";
		public static const OUTPUT : String = "output";
		public static const FEEDBACK: String = "feedback";
		public static const BLOCK : String = "block";
		public static const ENDPOINT : String = "endPoint";
		public static const changeIsNormal : String = "changeisnormal";
		public var edata:EData = null;
		public var isNormal:Boolean;
		public function CircuitEvent(type:String,tedata:EData=null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			edata = tedata;
			
		}
		/*public function CircuitEvent(tisNormal:Boolean, bubbles:Boolean = false) 
		{
			super(12, bubbles, false);
			isNormal = tisNormal;
			
		}*/
		
	}

}