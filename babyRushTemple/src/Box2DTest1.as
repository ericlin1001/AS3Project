package  
{
	import Box2D.Collision.*;
		import Box2D.Common.*;
		import Box2D.Common.Math.*;
		import Box2D.Dynamics.*;
		import Box2D.Dynamics.Contacts.*;
		import Box2D.Dynamics.Controllers.*;
		import flash.display.MovieClip;
		import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Box2DTest1 extends  MovieClip
	{
		public var world:b2World;
		public var iterations:int = 10;
		public var timeSetp:Number = 1.0 / 24.0;
		public function Box2DTest1() 
		{
			
		}
		
	}
	
}