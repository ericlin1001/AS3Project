package  
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Eric
	 */
	public class TankOne extends Tank
	{
		
		public function TankOne(tcost:Number = 30, tsize:Number = 25) 
		{
			super(tcost, tsize);
			tankSetter = new TankOneSetter() as MovieClip;
			paoTon = new TankOnePaoTon() as MovieClip;
			cost = 30;
			range = 150;
			rechargeRate = 0.1
			bulletSample = new Bullet(new BulletOnePic());;
		}
		override protected function draw():void 
		{
			
		}
	}
	
}