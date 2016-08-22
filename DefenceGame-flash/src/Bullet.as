package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Bullet extends Sprite 
	{
		private var _size:Number = 1;
		public var target:Enemy;//store the target to be hit.
		public var power:Number=2;//decide how many it is to  decease Hp
		private var _speed:Number = 3;//store the speed.
		//
		private var isPause:Boolean;
		private var distThreshold:Number = speed ;
		protected var _itPic:MovieClip = null;
		public var itPicType:Class = null;
		public function Bullet(titPic:MovieClip=null,titPicType:Class=null) 
		{
			super();
			itPic = titPic;
			itPicType = titPicType;
			mouseEnabled = false;
			
		}
		public function clone():Bullet {
			if (itPicType == null) {
				trace("Error.......: itPicType in Bullet has not be defined.");
				return null;
			}
			var bullet:Bullet = new Bullet(new itPicType(),itPicType);
			bullet.power = power;
			bullet.speed = speed;
			bullet.size = size;
			return  bullet;
		}
		protected function draw():void {
			//to draw a bullet
			trace("draw in Bullet.");
			itPic = new MovieClip();
			addChild(itPic);
			itPic.graphics.clear();
			itPic.graphics.lineStyle(1, 0x000000);
			itPic.graphics.beginFill(0xff0000);
			itPic.graphics.drawCircle(0, 0, 2);
			itPic.graphics.endFill();
			
		}
		public function update():void {
			if(!isPause){
				pursue();
			}
		}
		protected function adjustPic():void {
			if(itPic!=null){
				var temp:Number = Math.max(itPic.width, itPic.height);
				if (temp > 0) {
					itPic.scaleX = itPic.scaleY = itPic.scaleY *size / temp ;
				}
			}
		}
		public function pursue():Boolean {
			//to persue the target
			if (target != null) {
				if (target.state != Enemy.DEAD) {
					var dx:Number=target.x-x;
					var dy:Number = target.y - y;
					if (dx * dx + dy * dy <= distThreshold*distThreshold) {
						//hit the target,
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
			distThreshold = speed ;
		}
		
		public function get size():Number { return _size; }
		
		public function set size(value:Number):void 
		{
			_size = value;
			adjustPic();
		}
		
		public function get itPic():MovieClip { return _itPic; }
		
		public function set itPic(value:MovieClip):void 
		{
			if (itPic != null) {
				removeChild(itPic);
				trace("removing bulletpic");
			}
			_itPic = value;
			addChild(itPic);
			itPic.mouseEnabled = false;
			adjustPic();
		}
	}

}