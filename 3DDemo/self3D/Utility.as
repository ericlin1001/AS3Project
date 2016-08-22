package  
{
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Utility
	{
		
		public function Utility () 
		{
			
		}
		public function pt(tx:Number,ty:Number,tz:Number):Point3D {
			return new Point3D(tx, ty, tz);
		}
		public function getps(...rest):Array 
		{
			return rest;
		}
	}

}