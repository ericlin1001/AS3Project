package  
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Eric
	 */
	public class EnemyOne extends Enemy
	{
		
		public function EnemyOne(tsize:Number=15)
		{
			super(tsize);
			itshape = new EnemyOnePic() as MovieClip;
			speed = 1.5;
			gainMoney = 15;
		}
		override protected function draw():void {
			
		}
		
	}
	
}