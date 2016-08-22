package com.foed{

	public class SteeredVehicle extends Vehicle {
		private var _maxForce:Number=1;
		private var _steeringForce:Vector2D;
		private var _arrivalThreshold:Number=100;
		private var _wanderAngle:Number=0;
		private var _wanderDistance:Number=5;
		private var _wanderRadius:Number=5;
		private var _wanderRange:Number=1;//angle range
		private var _avoidDistance:Number=300;
		private var _avoidBuffer:Number=20;
		private var _pathIndex:int=0;
		private var _pathThreshold:Number=10;
		private var _inSightDist:Number=200;
		private var _tooCloseDist:Number=60;
		public function SteeredVehicle() {
			_steeringForce=new Vector2D();
			super();
		}
		public function inSight(vehicle: Vehicle):Boolean {
			if (_position.dist(vehicle.position)>_inSightDist) {
				return false;
			}
			var heading:Vector2D=_velocity.clone().normalize();
			var difference:Vector2D=vehicle.position.subtract(_position);
			var dotProd:Number=difference.dotProd(heading);
			if (dotProd<0) {
				return false;
			}
			return true;
		}
		public function tooClose(vehicle: Vehicle):Boolean {
			return _position.dist(vehicle.position)<_tooCloseDist;
		}
		public function flock(vehicles:Array ):void {
			var averagePosition:Vector2D=new Vector2D();
			var averageVelocity:Vector2D=_velocity.clone();
			var inSightCount:int=0;
			for (var i=0; i<vehicles.length; i++) {
				var vehicle:Vehicle=vehicles[i] as Vehicle;
				if (vehicle!=this&&inSight(vehicle)) {
					averageVelocity=averageVelocity.add(vehicle.velocity);
					averagePosition=averagePosition.add(vehicle.position);
					if (tooClose(vehicle)) {
						flee(vehicle.position);
					}
					inSightCount++;
				}
				if (inSightCount>0) {
					averageVelocity=averageVelocity.divide(inSightCount);
					averagePosition=averagePosition.divide(inSightCount);
					seek(averagePosition);
					_steeringForce.add(averageVelocity.subtract(_velocity));
				}



			}




		}
		public function followPath(path:Array ,loop:Boolean=false ):void {
			var wayPoint:Vector2D=path[_pathIndex];
			if (wayPoint==null) {
				return;
			}
			if (_position.dist(wayPoint)<_pathThreshold) {
				if (_pathIndex>=path.length-1) {
					if (loop) {
						_pathIndex=0;
					}
				} else {
					_pathIndex++;
				}
			}
			if (_pathIndex>=path.length-1&&! loop) {
				arrive(wayPoint);
			} else {
				seek(wayPoint);
			}
		}
		public function avoid(circles:Array ):void {
			for (var i=0; i<circles.length; i++) {
				var circle:Circle=circles[i];/*as Circle;*/
				var heading:Vector2D=_velocity.clone().normalize();
				var diff:Vector2D=circle.position.subtract(_position);
				var dotProd:Number=diff.dotProd(heading);
				if (dotProd>0) {// in front
					var feeler:Vector2D=heading.multiply(_avoidDistance);
					var projection:Vector2D=heading.multiply(dotProd);
					//位移投影
					var dist:Number=projection.subtract(diff).length;
					//distance between circle and velocity
					if (dist<circle.radius+_avoidBuffer&&projection.length<feeler.length) {
						var force:Vector2D=heading.multiply(_maxSpeed);
						force.angle+=Math.PI/2*heading.sign(diff);
						force=force.multiply(1.0-projection.length/feeler.length);
						_steeringForce=_steeringForce.add(force);
						_velocity=_velocity.multiply(projection.length/feeler.length);
					}
				}
			}

		}
		public function wander():void {
			var center:Vector2D=_velocity.clone().normalize().multiply(_wanderDistance);
			var offset:Vector2D=new Vector2D();
			offset.length=_wanderRadius;
			offset.angle=_wanderAngle;
			_wanderAngle+=Math.random()*_wanderRange*0.5-_wanderRange*0.5;
			var force:Vector2D=center.add(offset);
			_steeringForce=_steeringForce.add(force);
		}
		public function pursue(target:Vehicle):void {
			var lookAheadTime:Number=target.position.dist(_position)/_maxSpeed;
			var predictedTarget:Vector2D=target.position.add(target.velocity.multiply(lookAheadTime));
			seek(predictedTarget);
		}
		public function evade(target:Vehicle):void {
			var lookAheadTime:Number=target.position.dist(_position)/_maxSpeed;
			var predictedTarget:Vector2D=target.position.add(target.velocity.multiply(lookAheadTime));
			flee(predictedTarget);
		}
		public function seek(target:Vector2D):void {
			var desiredVelocity:Vector2D=target.subtract(_position);
			desiredVelocity=desiredVelocity.normalize().multiply(_maxSpeed);
			var force:Vector2D=desiredVelocity.subtract(_velocity);
			_steeringForce=_steeringForce.add(force);
		}

		public function arrive(target:Vector2D):void {
			var desiredVelocity:Vector2D=target.subtract(_position);
			var dist:Number=desiredVelocity.length;
			if (dist>_arrivalThreshold) {
				desiredVelocity=desiredVelocity.normalize().multiply(_maxSpeed);
			} else {
				desiredVelocity=desiredVelocity.normalize().multiply(_maxSpeed*dist/_arrivalThreshold);
			}
			var force:Vector2D=desiredVelocity.subtract(_velocity);

			_steeringForce=_steeringForce.add(force);
		}
		public function flee(target:Vector2D):void {
			var desiredVelocity:Vector2D=target.subtract(_position);
			desiredVelocity=desiredVelocity.normalize().multiply(_maxSpeed);
			var force:Vector2D=desiredVelocity.subtract(_velocity);

			_steeringForce=_steeringForce.subtract(force);
		}



		override public function update():void {
			_steeringForce=_steeringForce.truncate(_maxForce);
			_steeringForce=_steeringForce.divide(_mass);
			_velocity=_velocity.add(_steeringForce);
			super.update();
			_steeringForce=new Vector2D();
		}
		public function get maxForce():Number {
			return _maxForce;
		}
		public function set maxForce(value:Number) {
			_maxForce=value;
		}
		public function get arrivalThreshold():Number {
			return _arrivalThreshold;
		}
		public function set arrivalThreshold(value:Number) {
			_arrivalThreshold=value;
		}
		public function get pathIndex():int {
			return _pathIndex;
		}
		public function set pathIndex(value:int) {
			_pathIndex=value;
		}
		public function get pathThreshold():Number {
			return _pathThreshold;
		}
		public function set pathThreshold(value:Number) {
			_pathThreshold=value;
		}
		public function get inSightDist():Number {
			return _inSightDist;
		}
		public function set inSightDist(value: Number):void {
			_inSightDist=value;
		}
		public function get tooCloseDist():Number {
			return _tooCloseDist;
		}
		public function set tooCloseDist(value: Number):void {
			_tooCloseDist=value;
		}

	}

}