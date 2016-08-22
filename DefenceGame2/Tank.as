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
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Tank extends MovieClip 
	{
		public var costs:Array = new Array ();
		public var maxNumBullets:Number = 8;//restrict the number of the bullets;
		private var _size:Number = 25;//the size of tank
		public var power:Number = 10;//decide how many Hp will decease when others are hit;
		public var bulletSpeed:Number =4;
		public var rechargeRate:Number = 1;//decide how fast it recovers to shoot;
		public var range:Number = 50;//power range
		//
		public var target:Enemy=null;//store the next target;
		//
		private var _level:uint = 1;//this tank's level;
		private var bullets:Array = new Array ();//store the bullet that tank shoot;
		private var bulletContainer:Sprite = new Sprite();
		protected var _paoTon:MovieClip =null ;
		protected var _tankSetter:MovieClip = null;
		private var recharge:Number=0;//a counter for fire;
		private var totalCharge:Number=1;
		private var isPause:Boolean = true;
		//
		public var bulletSample:Bullet = null;
		//
	//	public var rollOver:Function = null;
		public var isChosen:Function = null;
		//
		private var levelText:TextField;
		public function Tank(tcost:Number=30,tsize:Number=25,tpower:Number=10,trange:Number=50,tmaxNumBullets:Number=8,tbulletSpeed:Number=4,trechargeRate:Number=1,tbulletSample:Bullet=null) 
		{
			super();
			
			//set vars
			cost = tcost;
			power = tpower;
			maxNumBullets = tmaxNumBullets;
			range = trange;
			bulletSpeed = tbulletSpeed;
			rechargeRate = trechargeRate;
			bulletSample = tbulletSample;
			//
			bulletContainer = new Sprite();
			addChild(bulletContainer);
			bulletContainer.mouseEnabled = false;
			addEventListener(MouseEvent.CLICK, click);
			addEventListener(MouseEvent.ROLL_OVER, drawSRange);
			addEventListener(MouseEvent.ROLL_OUT, deleteSRange);
			draw();
			mouseEnabled = false;
			//init the levelText.
			levelText = new TextField();
			levelText.mouseEnabled = false;
			addChild(levelText);
			levelText.autoSize = TextFieldAutoSize.CENTER;
			updateLevelText();
			size = tsize;
		
		}
		function updateLevelText():void {
			levelText.x = -levelText.width / 2;
			levelText.y = size * 0.3;
			levelText.text = "level:" + level;
		}
		private function click(e:MouseEvent):void {
			if (isChosen != null) {
				isChosen(this);
				trace("this tank is Chosen.");
			}
		}
		private function drawSRange(e:MouseEvent = null):void {
			if(!isPause){
				graphics.clear();
				graphics.lineStyle(0,0x555555);
				graphics.beginFill(0x555555,0.2);
				graphics.drawCircle(0, 0, range-size*0.5);
				graphics.endFill();
			}
			//if (rollOver != null) rollOver(this);
			
		}
		private function deleteSRange(e:MouseEvent = null):void {
			if (!isPause) {
				graphics.clear();
			}
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
			//var bullet:Bullet = bulletSample.clone();
			var bullet:Bullet = bulletSample.clone();
			bullet.x = tx;
			bullet.y = ty;
			bullet.target = t;
			bullet.power = power;
			bullet.speed = bulletSpeed;
			bullet.size = size;
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
		public function undraw():void {
			 tankSetter.graphics.clear();
			 paoTon.graphics.clear();
		}
		protected function adjustPic():void {
			var temp:Number ;
			var t:Number ;
			if(tankSetter!=null){
				temp = Math.max(tankSetter.width, tankSetter.height);
				if (temp > 0) {
					t = tankSetter.scaleY * size / temp ;
					tankSetter.scaleX = tankSetter.scaleY = t;
					if (paoTon != null) {
						paoTon.scaleX = paoTon.scaleY = t;
					}
				}
				
			}
			//trace("**********adjustPic**********");
		}
		protected  function draw():void {
			//draw tankSetter
			paoTon = new MovieClip();
			tankSetter = new MovieClip();
			addChild(paoTon);
			addChild(tankSetter);
			var tankSetterColor:uint = 0xffff00;
			var paotonColor:uint = 0xff00ff;
			var gr:Graphics = tankSetter.graphics;
			gr.clear();
			gr.lineStyle (0.25, 0);
			gr.beginGradientFill(GradientType.RADIAL, [tankSetterColor, 0], [1, 1], [0, 60]);
			gr.drawCircle (0, 0, size*0.5);
			gr.endFill();
			//draw paoTon
			var g:Graphics = paoTon.graphics;
			var w:Number = size*0.35;
			var l:Number = size*0.5+size*0.45;
			g.clear();
			g.lineStyle(0);
			g.beginFill(paotonColor);
			g.drawRect(0, -w * 0.5, l, w);
			g.endFill();
			//
			
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
			updateLevelText();
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
			adjustPic();
			updateLevelText();
		}
		
		public function get tankSetter():MovieClip { return _tankSetter; }
		
		public function set tankSetter(value:MovieClip):void 
		{
			if (tankSetter != null) {
				removeChild(tankSetter);
			}
			_tankSetter = value;
			addChild(tankSetter);
			tankSetter.play();
			adjustPic();
		}
		
		public function get paoTon():MovieClip { return _paoTon; }
		
		public function set paoTon(value:MovieClip):void 
		{
			if (paoTon != null) {
				removeChild(paoTon);
			}
			_paoTon = value;
			addChild(paoTon);
			paoTon.play();
			paoTon.mouseEnabled = false;
			adjustPic();
		}
		
		public function get cost():Number { return costs[level]; }
		
		public function set cost(value:Number):void 
		{
			costs[level] = value;
		}
		

		
		public function start():void {
			isPause = false;
		}
		public function pause():void {
			isPause = true;
		}
	}

}