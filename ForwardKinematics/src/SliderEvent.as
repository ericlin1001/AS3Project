package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eric
	 */
	public class SliderEvent extends Event 
	{
		public static const CHANGE:String = "change";
		public var message:String;
		public function SliderEvent(type:String,tmessage:String="", bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			message = tmessage;
			
		} 
		public override function toString():String 
		{ 
			return formatToString("SliderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}