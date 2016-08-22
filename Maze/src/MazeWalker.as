package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Eric_lin
	 */
	public class MazeWalker extends Sprite 
	{
		private var size:Number;
		public var canWalk:Function = null;// :Boolean (obj:o)
		private var oldX:Number;
		private var oldY:Number;
		public var MaxSpeedSQ:Number;
		//
		private var vx:Number;
		private var vy:Number;
		private var ax:Number;
		private var ay:Number;
		private const friction:Number = 0.70;
		public function MazeWalker(tsize:Number,tmaxSpeed:Number,tcanWalk:Function) 
		{
			super();
			size = tsize;
			MaxSpeedSQ = tmaxSpeed*tmaxSpeed;
			canWalk = tcanWalk;
			//
			vx = vy = 0; //
			ax = ay = 3;
			if (ax * ax > MaxSpeedSQ) {
				ax = ay = Math.sqrt(MaxSpeedSQ) * 0.2;
			}
			draw();
			//
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function update(e:Event = null):void {
			oldX = x;
			oldY = y;
			//
			x += vx;
			y += vy;
			if (!canWalk(this)) {
				x = oldX;
				y = oldY;
				vx = 0;
				vy = 0;
			}
			vx *= friction;
			vy *= friction;
		}
		private function  init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(Event.ENTER_FRAME, update);
		}
		public function del():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			removeEventListener(Event.ENTER_FRAME, update);
		}
		private function onKeyDown(e:KeyboardEvent):void {
			var dvx:Number = 0;
			var dvy:Number = 0;
			switch(e.keyCode) {
				case 37://left
					dvx -= ax;
					break;
				case 38://up
					dvy -= ay;
					break;
				case 39://right
					dvx += ax;
					break;
				case 40://down
					dvy += ay;
					break;
				default:
					/*switch(String.fromCharCode(e.charCode).toLocaleLowerCase()) {
						case "w":
							y -= speed;
							break;
						case "s":
							y += speed;
							break;
						case "a":
							x -= speed;
							break;
						case "d":
							x += speed;
							break;
						default:
							break;
					}*/
					break;
			}
			vx += dvx;
			vy += dvy;
			if (vx * vx + vy * vy > MaxSpeedSQ) {
				vx -= dvx;
				vy -= dvy;
			}
			
		}
		private function draw():void {
			var g:Graphics = graphics;
			var halfSize:Number = size * 0.5;
			g.lineStyle(0.25,0x00ff00);
		//	g.drawRect( -halfSize, -halfSize, size, size);
			g.beginFill(0xff0000);
			g.drawCircle(0, 0, halfSize * 0.7);
			g.endFill();
		}
		public function get a():Number {
			return ax;
		}
		public function set a(value:Number):void 
		{
			ax = value;
			ay = value;
			trace("set ax=", ax);
			trace("set ay=", ay);
		}
	}

}