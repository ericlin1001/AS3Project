package  
{
	/**
	 * ...
	 * @author Ericlin
	 */
	public class EData 
	{
		public static const NORMAL:String = "normal";
		public static const CONNECTED:String = "connected";
		public static const BLOCK:String = "block";
		//
		public var U:Number;//electric potential
		public var I:Number;//current
		public var percent:Number;
		public var state:String=NORMAL;
		public var isNormal:Boolean;
		public function EData(u:Number=NaN,i:Number=NaN,pert:Number=NaN,tstate:String=null) 
		{
			U = u;
			I = i;
			percent = pert;
			state = tstate;
		}
		
	}

}