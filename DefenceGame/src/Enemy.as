package  
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
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
		public var power:Number = 1;
		public var gainMoney:Number = 15;
		public var state:String = NORMAL;//to store the state of itself
		private var _speed:Number = 1.2;
		private var _size:Number = 15;
		private var _color:uint;
		//private varibales:
		private var _Hp:Number = 100;
		private var _totalHp:Number = 100;
		private var gHp:GHp = new GHp(100,100);
		private var itshape:Shape = new Shape();
		private var _pathSX:Array=null;
		private var _pathSY:Array=null;
		private var pPath:uint = 0;
		private var isPause:Boolean = true;
		//
		private var distThreshold:Number = speed * 0.5;
		public function Enemy() 
		{
			super();
			addChild(gHp);
			gHp.x = -gHp.width * 0.5;
			gHp.y = size -4;
			addChild (itshape);
			draw();
		}
		public function update():void {
			//trace("enemy update");
			if(!isPause){
			arrive();
			}
		}
		public function draw(color:uint=0x0000ff):void {
			//to draw itself.
			_color = color;
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
				var dy:Number=pathSY[pPath]-y;
				if (dx * dx + dy * dy <= distThreshold*distThreshold) {
					pPath++;
				}
				/*if(dx==0 && dy==0){
				dx += 0.1;
				dy += 0.1;
				}*/
				var angle:Number = Math.atan2(dy, dx);
				itshape.rotation = angle / Math.PI * 180;
				x+=speed*Math.cos(angle);
				y+=speed*Math.sin(angle);
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
			gHp.y = size -2;
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
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
			draw(_color);
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
			distThreshold = _speed * 0.5;
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