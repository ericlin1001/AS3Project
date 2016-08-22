package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Bullet extends MovieClip 
	{
		public var target:Enemy;//store the target to be hit.
		public var power:Number=2;//decide how many it is to  decease Hp
		private var _speed:Number = 3;//store the speed.
		//
		private var isPause:Boolean;
		private var distThreshold:Number = speed * 0.5;
		public function Bullet() 
		{
			super();
			draw();
		}
		private function draw():void {
			//to draw a bullet
			graphics.clear();
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xff0000);
			graphics.drawCircle(0, 0, 2);
			graphics.endFill();
		}
		public function update():void {
			if(!isPause){
				pursue();
			}
		}
		public function pursue():Boolean {
			//to persue the target
			if (target != null) {
				if (target.state != Enemy.DEAD) {
					var dx:Number=target.x-x;
					var dy:Number = target.y - y;
					if (dx * dx + dy * dy <= distThreshold*distThreshold) {
						target.Hp -= power;
						return false;
					}
					var angle:Number=Math.atan2(dy,dx);
					rotation=angle/Math.PI*180;
					x+=speed*Math.cos(angle);
					y+= speed * Math.sin(angle);
					return true;
				}

			}
			return false;
		}
		public function start():void {
			//to start bullet
			isPause = false;
		}
		public function goOn():void {
			isPause = false;
		}
		public function pause():void {
			isPause = true;
			
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
			distThreshold = speed * 0.5;
		}
	}

}