package {
	import flash.geom.Rectangle;
	import flash.display.Graphics;
	public class VerletPoint {
		public var x:Number;
		public var y:Number;
		private var _rect:Rectangle 
		private var oldx:Number;
		private var oldy:Number;
		private var _fixed:Boolean =false
		public function VerletPoint(x:Number=0,y:Number=0) {
			setPosition(x,y);
			_rect=new Rectangle(0,0,1000,1000)
		}
		public function constrain() {
			x=Math.max(_rect.left,x);
			x=Math.min(_rect.right,x);
			y=Math.max(_rect.top,y);
			y=Math.min (_rect.bottom,y)
			
		}
		public function update() {
				var tempx:Number=x;
				var tempy:Number=y;
				x+=vx;
				y+=vy;
				oldx=tempx;
				oldy=tempy;
		}
		public function clone():VerletPoint{
			return new VerletPoint(x,y)
		}
		public function draw(g:Graphics ) {
				if(_fixed){
				g.beginFill(0);
				g.drawCircle(x,y,3);
				g.endFill();
				g.lineStyle(0)
g.drawCircle(x,y,5)}else{
				g.beginFill(0);
				g.drawCircle(x,y,4);
				g.endFill();
				
				}
			
		}
		public function setPosition(sx:Number,sy:Number) {
			oldx=x=sx;
			oldy=y=sy;
		}
		public function get vx() {
			return x-oldx;
		}
		public function get vy() {
			return y-oldy;
		}
		
		public function set rect(r:Rectangle) {
				_rect=r
		}
		public function get rect() {
				return _rect
		}
		public function set fixed(value:Boolean) {
				_fixed=value
		}
		public function get fixed() {
				return _fixed
		}
		public function set vx(value:Number) {
			
				oldx=x-value;
			
		}
		public function set vy(value:Number) {
			oldy=y-value;
		}
	}
}