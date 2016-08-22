package {
	import flash.display.Sprite;
	public class Vehicle extends Sprite {
		protected var _position:Vector2D;
		protected var _velocity:Vector2D;
		protected var _mass:Number=1.0;
		protected var _maxpeed:Number=10;
		protected var _edgeBehavior:String=WRAP;
		public static const WRAP:String="wrap";
		public static const BOUNCE:String="bounce";
		public function Vehicle() {
			_position =new Vector2D();
			_velocity=new Vector2D();
			draw();
		}
		public function update():void {
			_velocity=_velocity.truncate(_maxspeed)
			_position=_position.add(_velocity)
			if(_edgeBehavior==WRAP){wrap()}else if(_edgeBehavior==BOUNCE){
			bounce()}
		}
		protected function draw():void {
			graphics.clear();
			graphics.lineStyle(0);
			graphics.moveTo(10,0);
			graphics.lineTo(-10,-5);
			graphics.lineTo(0 ,0 );
			graphics.lineTo( -10,5 );
			graphics.lineTo(10 ,0 );
		}
		public function get position():Vector2D {
			return _position;
		}
		public function set position(value:Vector2D) {
			_position=value;
		}
		public function get velocity():Vector2D {
			return _velocity;
		}
		public function set velocity(value:Vector2D) {
			_velocity=value;
		}

	}
}