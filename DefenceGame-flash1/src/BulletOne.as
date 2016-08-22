package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Eric
	 */
	public class BulletOne extends Bullet
	{
		
		public function BulletOne() 
		{
			super();
			itPic = new BulletOnePic() as MovieClip;
		}
		override protected function draw():void 
		{
		}
	}
	
}