package com.foed{
	import flash.display.Sprite;
	public class Vehicle extends Sprite {
		protected var _position:Vector2D;
		protected var _velocity:Vector2D;
		protected var _mass:Number=1.0;
		protected var _maxSpeed:Number=10;
		protected var _edgeBehavior:String=	BOUNCE
		public static const WRAP:String="wrap";
		public static const BOUNCE:String="bounce";
		public function Vehicle() {
			_position=new Vector2D();
			_velocity=new Vector2D();
			draw();
		}
		protected function draw():void {
			graphics.clear();
			graphics.lineStyle(0);
			graphics.moveTo(10,0);
			graphics.lineTo(-10,-5);
			graphics.lineTo(-5 ,0 );
			graphics.lineTo( -10,5 );
			graphics.lineTo(10,0 );
		}
		public function update():void {
			_velocity=_velocity.truncate(_maxSpeed);
			_position=_position.add(_velocity);
			if (_edgeBehavior==WRAP) {
				wrap();
			} else if (_edgeBehavior==BOUNCE) {
				bounce();

			}
			rotation=_velocity.angle/Math.PI*180;
			x=_position.x;
			y=_position.y;
			draw();
		}
		private function wrap():void {
			if (stage!=null) {
				if (position.x>stage.stageWidth) {
					position.x=0;
				}
				if (position.x<0) {
					position.x=stage.stageWidth;
				}
				if (position.y>stage.stageHeight) {
					position.y=0;
				}
				if (position.y<0) {
					position.y=stage.stageHeight;
				}
			}
		}
		private function bounce():void {
			if (stage!=null) {
				if (position.x>stage.stageWidth) {
					position.x=stage.stageWidth;
					velocity.x*=-1;
				} else if (position.x < 0) {
					position.x=0;
					velocity.x*=-1;
				}
				if (position.y>stage.stageHeight) {
					position.y=stage.stageHeight;
					velocity.y*=-1;
				} else if (position.y < 0) {
					position.y=0;
					velocity.y*=-1;
				}
			}
		}
		public function set mass(value:Number) {
			_mass=value;
		}
		public function get mass():Number {
			return _mass;
		}

		public function set edgeBehavior(value:String) {
			_edgeBehavior=value;
		}
		public function get edgeBehavior():String {
			return _edgeBehavior;
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
		public function get maxSpeed():Number {
			return _maxSpeed;
		}
		public function set maxSpeed(value:Number) {
			_maxSpeed=value;
		}
		override public function set x(value:Number):void {
			super.x=value;
			_position.x=value;
		}
		override public function set y(value:Number):void {
			super.y=value;
			_position.y=value;
		}

	}
}