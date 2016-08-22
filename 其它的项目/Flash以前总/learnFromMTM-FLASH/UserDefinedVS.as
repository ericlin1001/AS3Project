package {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.Graphics;
	import flash.events.Event;
	public class UserDefinedVS extends Sprite {
		private var _points:Array;
		private var _sticks:Array;
		private var rect:Rectangle;
		private var speedx:Number=0;
		private var speedy:Number=0;
		private var gravity:Number=.5;
		public function UserDefinedVS(w:Number =550,h:Number =400) {
			_points=new Array  ;
			_sticks=new Array  ;
			rect=new Rectangle(0,0,w,h);
		}
		public function moveTo(tx:Number,ty:Number):void {
			if (! isCover(tx,ty)) {
				makePoint(tx,ty);
			}
		}
		public function lineTo(tx:Number,ty:Number):void {
			if (! isCover(tx,ty)) {
				makePoint(tx,ty);
			}
			var len=_points.length;
			trace(_sticks.length );
			makeStick(_points[len-1],_points[len-2]);
		}
		public function clear() {
			graphics.clear();
			_points.splice(0);
			_sticks.splice(0);
		}
		public function setEndPointRect() {
			var point=_points[_points.length-1];
			point.fixed=! point.fixed;
			if (point.fixed) {
				point.rect=new Rectangle(point.x,point.y,0,0);
			} else {
				point.rect=rect;
			}
		}
		public function reSetSticks() {
			for (var i=0; i<_sticks.length; i++) {
				var stick=_sticks[i];
				stick.length=-1;
			}
			for (i=0; i<_points.length; i++) {
				var point=_points[i];
				point.vx=0;
				point.vy=0;
			}
		}
		public function setEndPoint(tx:Number ,ty:Number ) {
			var point=_points[_points.length-1];
			point.x=tx;
			point.y=ty;
			if (point.fixed) {
				point.rect=new Rectangle(point.x,point.y,0,0);
			} else {
				point.rect=rect;
			}
		}
		public function update() {
			pointsUpdate();
			pointsConstrain();
			sticksUpdate();
		}
		public function draw() {
			graphics.clear();
			for (var i=0; i<_points.length; i++) {
				_points[i].draw(graphics);
			}
			for (i=0; i<_sticks.length; i++) {
				_sticks[i].draw(graphics);
			}
		}
		private function pointsUpdate() {
			for (var i=0; i<_points.length; i++) {
				var point=_points[i];
				point.x+=speedx;
				point.y+=speedy+gravity;
				point.update();
			}
		}
		private function pointsConstrain() {
			for (var i=0; i<_points.length; i++) {
				var point=_points[i];
				point.constrain();
			}
		}
		private function sticksUpdate() {
			for (var i=0; i<_sticks.length; i++) {
				_sticks[i].update();
			}
		}
		private function makeStick(pa:VerletPoint,pb:VerletPoint):void {
			if (pa==pb) {
				return;
			} else {
				var stick:VerletStick=new VerletStick(pa,pb);
				_sticks.push(stick);
				return;
			}

		}
		private function pointsClone():Array {
			var a:Array =new Array();
			for (var i=0; i<_sticks.length; i++) {
				var point=_sticks[i].pointa;
				if (!(isInArray(a,point))) {
					a.push(point);
				}

			}
			for ( i=0; i<_sticks.length; i++) {
				 point=_sticks[i].pointb;
				if (!(isInArray(a,point))) {
					a.push(point);
				}

			}
			return a;
		}
		private function isInArray(myarray:Array ,point:VerletPoint) {
			for (var i=0; i<myarray.length; i++) {
				if (myarray[i]==point) {
					return true;
				}
			}
			return false;
		}
		private function sticksClone():Array {
			var b:Array =new Array();
			for (var i=0; i<_sticks.length; i++) {
				b.push(_sticks[i].clone());
			}
			return b;
		}
		public function set ax(value:Number ) {
			speedx=value;
		}
		public function set ay(value:Number ) {
			speedy=value;
		}
		public function set points(value:Array ) {
			_points=value;
		}
		public function get points() {
			return pointsClone();
		}
		public function set sticks(value:Array ) {
			_sticks=value;
		}
		public function get sticks() {
			return sticksClone();
		}
		public function setRect(r:Rectangle ) {
			var len=_points.length;
			_points[len-1].rect=r;
		}
		private function makePoint(a:Number,b:Number):VerletPoint {
			var point:VerletPoint=new VerletPoint(a,b);
			_points.push(point);
			point.rect=rect;
			return point;
		}
		public function isCover(tx:Number,ty:Number):Boolean {
			for (var i=0; i<_points.length; i++) {
				var point=_points[i];
				var dx=tx-point.x;
				var dy=ty-point.y;
				var dist2=dx*dx+dy*dy;
				if (dist2<4*4) {
					var temppoint=_points[i];
					_points.splice(i,1);
					_points.push(temppoint);
					return true;
				}
			}
			return false;
		}

	}
}