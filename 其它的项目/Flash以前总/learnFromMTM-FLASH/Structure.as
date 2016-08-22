package {
	import flash.display.Graphics;
	import com.foed.Vector2D;
	public class Structure {
		private var _points:Array;
		private var _sticks:Array;
		private var _numPoints:int;
		private var _position:Vector2D;
		private var _velocity:Vector2D;
		private var _turnVelocity:Vector2D;
		private var _mass:Number;
		public function Structure(pointArray:Array ) {
			_points=new Array();
			_sticks=new Array();
			_numPoints=pointArray.length;
			_points=pointArray;
			_points.push(pointArray[0]);
			_points.push(pointArray[1]);
			if (_numPoints>=3) {
				for (var i=0; i<_numPoints; i++) {
					makestick(_points[i],_points[i+1]);
				}
				for (i=1; i<_numPoints-1; i++) {
					makestick(_points[0],_points[i]);
				}
			}
			setMass();
		}
		private function setMass():void {
			var area:Number=0;
			for (var i=1; i<_numPoints-1; i++) {
				area+=getArea(_points[0],_points[i],_points[i+1]);
			}
			_mass=area;
		}
		private function getArea(A:VerletPoint,B:VerletPoint,C:VerletPoint ):Number {
			var pointA=new Vector2D(A.x,A.y);
			var pointB=new Vector2D(B.x,B.y);
			var pointC=new Vector2D(C.x,C.y);
			var center=pointA.clone();
			pointA=pointA.subtract(center);
			pointB=pointB.subtract(center);
			pointC=pointC.subtract(center);
			var cos=pointB.clone().normalize().dotProd(pointC.clone().normalize());
			var sin=Math.sqrt(1-cos*cos);
			return pointB.length*pointC.length*sin/2;
		}
		public function isInside(target:Vector2D):Boolean {
			for (var i=0; i<_numPoints; i++) {
				var pointA=new Vector2D(_points[i].x,_points[i].y);
				var pointB=new Vector2D(_points[i+1].x,_points[i+1].y);
				var pointC=new Vector2D(_points[i+2].x,_points[i+2].y);
				var center=pointA.clone();
				pointA=pointA.subtract(center);
				pointB=pointB.subtract(center);
				pointC=pointC.subtract(center);
				target=target.subtract(center);
				if (pointB.sign(target)*pointB.sign(pointC)<0) {
					trace(i);
					return false;
				}
			}
			return true;
		}
		public function putOutside(point:VerletPoint,radius:Number=0):Vector2D {
			for (var i=0; i<_numPoints; i++) {
				var pointA=new Vector2D(_points[i].x,_points[i].y);
				var pointB=new Vector2D(_points[i+1].x,_points[i+1].y);
				var pointC=new Vector2D(_points[i+2].x,_points[i+2].y);
				var target=new Vector2D(point.x,point.y);
				//trace("before chagne target"+target.toString());
				//trace("old"+oldTarget.toString());
				//
				//trace("111old"+oldTarget.toString());
				var center=pointA.clone();
				pointA=pointA.subtract(center);
				pointB=pointB.subtract(center);
				pointC=pointC.subtract(center);
				target=target.subtract(center);
				//trace("before chagne target"+target.toString());
				//
				var heading=pointB.perp().normalize();
				if (heading.dotProd(pointC)<=0) {
					heading=heading.reverse();
				}
				heading=heading.multiply(radius);
				//trace("heading"+heading.toString());
				target=target.add(heading);
				//trace("after chagne target"+target.toString());
				//
				//trace("pointB"+pointB.toString());
				//trace("target"+target.toString());
				//trace("oldTarget"+oldTarget.toString());
				//trace("pointC"+pointC.toString());
				if (pointB.sign(target)*pointB.sign(pointC)<0) {

					//trace("not hit the line: "+i)
					return new Vector2D(0,0);
				}
			}
			//trace("hit");
			for (i=0; i<_numPoints; i++) {
				pointA=new Vector2D(_points[i].x,_points[i].y);
				pointB=new Vector2D(_points[i+1].x,_points[i+1].y);
				pointC=new Vector2D(_points[i+2].x,_points[i+2].y);
				target=new Vector2D(point.x,point.y);
				var oldTarget=target.subtract(new Vector2D(point.vx*2,point.vy*2));
				//trace("old"+oldTarget.toString());
				//
				//trace("111old"+oldTarget.toString());
				center=pointA.clone();
				pointA=pointA.subtract(center);
				pointB=pointB.subtract(center);
				pointC=pointC.subtract(center);
				target=target.subtract(center);
				oldTarget=oldTarget.subtract(center);
				//trace("before chagne target"+target.toString());
				//
				heading=pointB.perp().normalize();
				if (heading.dotProd(pointC)<=0) {
					heading=heading.reverse();
				}
				heading=heading.multiply(radius);
				//trace("heading"+heading.toString());
				target=target.add(heading);
				oldTarget=oldTarget.add(heading);
				//trace("after chagne target"+target.toString());
				//
				//trace("pointB"+pointB.toString());
				//trace("target"+target.toString());
				//trace("oldTarget"+oldTarget.toString());
				if (pointB.sign(target)*pointB.sign(oldTarget)<=0) {
					//trace(" hit the long line: "+i);
					center=oldTarget.clone();
					pointA=pointA.subtract(center);
					pointB=pointB.subtract(center);
					target=target.subtract(center);
					oldTarget=oldTarget.subtract(center);
					//
					if (target.sign(pointA)*target.sign(pointB)<=0) {
						//trace("find the short hit line: "+i);
						//
						center=pointA.clone();
						pointA=pointA.subtract(center);
						pointB=pointB.subtract(center);
						pointC=pointC.subtract(center);
						target=target.subtract(center);
						oldTarget=oldTarget.subtract(center);
						//
						var border=pointB.normalize();
						//trace("border:"+border.toString());
						var a=border.dotProd(target);
						border=border.multiply(a);
						//trace("border:"+border.toString());
						//trace("border:"+border.toString());
						//trace("target:"+target.toString());
						var offset:Vector2D=border.subtract(target);
						//offset=offset.multiply(1);
						//trace("offset:"+offset.toString());
						return new Vector2D(offset.x,offset.y);
					}
				}
			}
			return new Vector2D(0,0);

		}
		private function makestick(pa:VerletPoint,pb:VerletPoint):void {
			var stick:VerletStick=new VerletStick(pa,pb);
			_sticks.push(stick);
		}
		public  function update() {
			pointsUpdate()
			sticksUpdate()
		}
		
		private function sticksUpdate(){
			for (var i=0; i<_sticks.length; i++) {
				var stick=_sticks[i];
				stick.update();
			}
		}
				private function pointsUpdate(){
			for (var i=0; i<_numPoints; i++) {
				var point=_points[i];
				point.update();
			}
		}
		public function draw(g:Graphics) {
			g.lineStyle(0);
			g.beginFill(0);
			g.moveTo(_points[0].x,_points[0].y);
			for (var i=1; i<_numPoints; i++) {
				g.lineTo(_points[i].x,_points[i].y);
			}
			g.endFill();
		}
		public function get mass():Number {
			return _mass;
		}
		public function get velocity():Vector2D {
			var v:Vector2D=new Vector2D();
			for (var i =0; i<_numPoints; i++) {
				var point:VerletPoint=_points[i];
				v=v.add(new Vector2D(point.vx,point.vy));
			}
			v=v.divide(_numPoints);
			return v;
		}
		public function set addVelocity(value:Vector2D) {

			for (var i=0; i<_numPoints; i++) {
				var point:VerletPoint=_points[i];
				point.vx+=value.x;
				point.vy+=value.y;
			}
		}
				public function set addPosition(value:Vector2D) {
			for (var i=0; i<_numPoints; i++) {
				var point:VerletPoint=_points[i];
				point.x+=value.x;
				point.y+=value.y;
			}
		}
		public function set velocity(value:Vector2D) {
			for (var i=0; i<_numPoints; i++) {
				var point:VerletPoint=_points[i];
				point.vx=value.x;
				point.vy=value.y;
			}
		}
		public function get position():Vector2D {
			var p:Vector2D=new Vector2D();
			for (var i=0; i<_numPoints; i++) {
				var point:VerletPoint=_points[i];
				p=p.add(new Vector2D(point.x,point.y));
			}
			p=p.divide(_numPoints);
			return p;
		}
		
		public function get points():Array{
										   var temp:Array =_points
										   temp=temp.slice(0,_numPoints)
										return temp   
	}

	}
}