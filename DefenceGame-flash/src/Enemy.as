package  
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Enemy extends MovieClip 
	{
	
		//some contanst state:
		public static const DEAD:String = "dead";
		public static const NORMAL:String = "normal";
		public static const FINISH_PATH:String = "finishPath";
		//
		public var gainMoney:Number = 15;
		public var state:String = NORMAL;//to store the state of itself
		//
		public var  power:int = 1;
		private var _speed:Number = 1.2;
		private var _size:Number = 15;
		//private varibales:
		private var _Hp:Number = 100;
		private var _totalHp:Number = 100;
		private var gHp:GHp = new GHp(100,100);
		protected var _itshape:MovieClip = null;
		private var _pathSX:Array=null;
		private var _pathSY:Array=null;
		private var pPath:uint = 0;
		private var isPause:Boolean = true;
		//
		private const thresholdPer:Number = 1;
		private var distThreshold:Number = speed * thresholdPer;
		public function Enemy(tsize:Number=15) 
		{
			super();
			//set vars
			//
			addChild(gHp);
			draw();
			size = tsize;
		}
		protected function adjustPic():void {
			
			//
			var temp:Number ;
			if(itshape!=null){
				temp =Math.max(itshape.width, itshape.height);
				if (temp > 0) {
					itshape.scaleX = itshape.scaleY = itshape.scaleY * size / temp;
				}
				
			}
			if(gHp!=null){
				temp =Math.max(gHp.width, gHp.height);
				if (temp > 0) {
					gHp.scaleX = gHp.scaleY = gHp.scaleY * size / temp;
					gHp.y = size * 0.5 +gHp.height * 0.5 + 3.5;
				}
			}
			
		}
		public function update():void {
			//trace("enemy update");
			if(!isPause){
				arrive();
			}
		}
		protected function draw():void {
			//to draw itself.
			_itshape = new MovieClip();
			addChild (itshape);
			var color:uint=0x0000ff;
			var g:Graphics = itshape.graphics;
			g.clear();
			g.lineStyle (0.25);
			g.beginFill(color);
			g.moveTo(size * 0.5, 0);
			g.lineTo(-size*0.5,-size*0.5);
			g.lineTo( -size * 0.5, size * 0.5);
			g.lineTo(size * 0.5, 0);	
			g.endFill();
			
		}
		private function arrive():void{
			if(pathSX!=null){
				//trace("enemy is moving");
				if (pPath <pathSX.length) {
					var dx:Number=pathSX[pPath]-x;
					var dy:Number = pathSY[pPath] - y;
					var dist:Number = Math.sqrt(dx * dx + dy * dy);
					if (dist<distThreshold) {
						pPath++;
					}else{
						var angle:Number = Math.atan2(dy, dx);
						itshape.rotation = angle / Math.PI * 180;
						x+=speed*dx/dist;
						y += speed * dy / dist; 
					}
					
				}else {
					state = FINISH_PATH;
				}
			}
		}
		
		//getter and setter

		public function get Hp():int {
			return _Hp;
		}

		public function set Hp(value:int):void	{
			_Hp = value;
			gHp.len = _Hp/totalHp*100;
			if (_Hp < 0) {
			state = DEAD;
			trace("enemy is dead");
			}
		//	trace("enemy's hp=" + Hp);
		}

		public function get pathSY():Array {
			return _pathSY;
		}

		public function set pathSY(value:Array):void {
			_pathSY = value;
		}
		
		public function get pathSX():Array 
		{
			return _pathSX;
		}
		
		public function set pathSX(value:Array):void 
		{
			_pathSX = value;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
			adjustPic();
		}
		
		public function get totalHp():Number 
		{
			return _totalHp;
		}
		
		public function set totalHp(value:Number):void 
		{
			_totalHp = value;
			_Hp=totalHp
		}
		
	
		
	
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
			distThreshold = _speed * thresholdPer;
		}
		
		public function get itshape():MovieClip { return _itshape; }
		
		public function set itshape(value:MovieClip):void 
		{
			if (itshape != null) {
				removeChild(itshape);
			}
			_itshape = value;
			itshape.play();
			addChild (itshape);
			adjustPic();
		}
		public function start():void {
			isPause = false;
			
		}
		public function pause():void {
			isPause = true;
		}

	}

}