package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class CircuitEvent extends Event 
	{
		
		//
		public static const  DATAFLOWING: String = "dataFlowing";
		public static const  CURRENTFLOWING: String = "currentFlowing";
		public static const  ENDPOINT: String = "endPoint";
		public static const  BLOCK: String = "block";
		public static const  TESTING: String = "testing";
		public static const  LINKING: String = "linking";
		public static const  SWITCHTESTON: String = "switchTestOn";
		
		//
		public var U:Number=NaN;
		public var I:Number=NaN;
		public var dI:Number =NaN;
		public var fromPort:String="";
		public var state:String="";
		
		public function CircuitEvent(type:String =DATAFLOWING,tstate:String=CURRENTFLOWING, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			state = tstate;
			
		}
		
	}

}