package  
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.GraphicsPathWinding;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Tank extends MovieClip 
	{
		public var cost:Number = 30;
		public var target:Enemy=null;//store the next target;
		public var maxNumBullets:Number = 8;//restrict the number of the bullets;
		private var _size:Number = 25;//the size of tank
		public var power:Number = 10;//decide how many Hp will decease when others are hit;
		public var bulletSpeed:Number =4;
		public var rechargeRate:Number = 1;//decide how fast it recovers to shoot;
		public var range:Number = 50;
		private var _level:uint = 1;//this tank's level;
		//
		private var bullets:Array = new Array ();//store the bullet that tank shoot;
		private var bulletContainer:Sprite = new Sprite();
		private var paoTon:Shape = new Shape();
		private var tankSetter:Shape = new Shape();
		private var recharge:Number=0;//a counter for fire;
		private var totalCharge:Number=100;
		private var isPause:Boolean = true;
		private var color1:uint; 
		private var color2:uint;
		public function Tank() 
		{
			super();
			addChild(bulletContainer);
			addChild(paoTon);
			addChild(tankSetter);
			draw();
			addEventListener(MouseEvent.ROLL_OVER, drawSRange);
			addEventListener(MouseEvent.ROLL_OUT, deleteSRange);
		}
		private function drawSRange(e:MouseEvent = null):void {
			graphics.clear();
			graphics.lineStyle(0,0x555555);
			graphics.beginFill(0x555555,0.2);
			graphics.drawCircle(0, 0, range);
			graphics.endFill();
		}
		private function deleteSRange(e:MouseEvent = null):void {
			graphics.clear();
		}
		public function update():void {
			//the interface to control this tank
			if(!isPause){
				updateMyself();
				updateBullets();
				waitToFire();
			}
		}
		private function waitToFire():void {
			//count to fire
			recharge += rechargeRate;
			if (recharge > totalCharge) {
				recharge = 0;//reset the recharge for next fire.
				fire();
			}
		}
		private function fire():void {
			//begin to shoot a bullet.
			if (bullets.length < maxNumBullets) {
				if (target != null && target.state != Enemy.DEAD) {
					var dx:Number = target.x - x;
					var dy:Number = target.y - y;
					if (dx * dx + dy * dy <= range * range) {
						addBullet(x, y, target).start();
					}
					
				}
			}
		}
		private function addBullet(tx:Number=0,ty:Number=0,t:Enemy=null):Bullet {
			//to add one bullet to stage
			var bullet:Bullet = new Bullet();
			bullet.x = tx;
			bullet.y = ty;
			bullet.target = t;
			bullet.power = power;
			bullet.speed = bulletSpeed;
			bulletContainer.addChild(bullet);
			bullets.push (bullet);
			return bullet;
		}
		private function updateMyself():void {
			//decide the target.
			rotatePaoTon();
		}
		private function rotatePaoTon():void {
			if (target != null) {
				if (target.state != Enemy.DEAD) {
					var tx:Number = target.x;
					var ty:Number = target.y;
					var dx:Number=tx-x;
					var dy:Number=ty-y;
					if(dx*dx+dy*dy<=range*range){
						var angle:Number=Math.atan2(dy,dx);
						paoTon.rotation=angle/Math.PI*180;
					}else {
						//the target is out of the ragne;
						target = null;
					}
				}
			}
		}
		private function updateBullets():void {
			for (var i:int = 0; i < bullets.length; i++) 
			{
				var item:Bullet = bullets[i];
				if(item!=null){
					if (!item.pursue()) {
						//if it is not pursuing
						bulletContainer.removeChild(item);
						bullets.splice(i, 1);
					}
				}
			}
		}
		public  function draw(color1:uint=0xffff00,color2:uint=0xff00ff):void {
			//draw tankSetter
			this.color1 = color1;
			this.color2 = color2;
			var gr:Graphics = tankSetter.graphics;
			gr.clear();
			gr.lineStyle (0.25, 0);
			gr.beginGradientFill(GradientType.RADIAL, [color1, 0], [1, 1], [0, 60]);
			gr.drawCircle (0, 0, size*0.5);
			gr.endFill();
			//draw paoTon
			var g:Graphics = paoTon.graphics;
			var w:Number = size*0.35;
			var l:Number = size*0.5+size*0.45;
			g.clear();
			g.lineStyle(0);
			g.beginFill(color2);
			g.drawRect(0, -w * 0.5, l, w);
			g.endFill();
		}
		//getter and setter
		public override function set x(value:Number):void {
			super.x = value;
			bulletContainer.x = -x;
			bulletContainer.y = -y;
		}
		public override function set y(value:Number):void {
			super.y = value;
			bulletContainer.x = -x;
			bulletContainer.y = -y;
		}
		
		public function get level():uint 
		{
			return _level;
		}
		
		public function set level(value:uint):void 
		{
			_level = value;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
			draw(color1, color2);
		}
		public function start():void {
			isPause = false;
		}
		public function goOn():void {
			isPause = false;
		}
		public function pause():void {
			isPause = true;
		}
	}

}