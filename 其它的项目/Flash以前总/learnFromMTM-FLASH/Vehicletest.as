package {
	import com.foed.Circle;
	import com.foed.Vector2D;
	import com.foed.SteeredVehicle;
	import com.foed.Vehicle;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Vehicletest extends Sprite {
		private var _vehicles:Array;
		private var _circles:Array;
		private var _numCircles:Number=5;
		private var _numVehicles:Number=5;
		private var _path:Array;
		public function Vehicletest() {
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			_vehicles=new Array();
			_circles = new Array();
			_path=new Array();
			makeVehicle(100,100);
			makeVehicle(100,400);
			makeVehicle(400,250);
			for (var i:int = 0; i < _numCircles; i++) {
				makeCircle(Math.random ()*stage.stageWidth,stage.stageHeight*Math.random() ,Math.random()*10+17);
			}
			for (var j:int = 0; j < _numVehicles; j++) {
				makeVehicle(range(),range());
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onEnterFrame(event:Event):void {
			/*_vehicles[0].seek(_vehicles[1].position)
			_vehicles[0].flee(_vehicles[2].position)
			_vehicles[1].seek(_vehicles[2].position)
			_vehicles[1].flee(_vehicles[0].position)
			_vehicles[2].seek(_vehicles[0].position)
			_vehicles[2].flee(_vehicles[1].position)*/
			/*_vehicles[0].arrive(new Vector2D(mouseX,mouseY))*/
			/*_vehicles[2].wander();
			_vehicles[0].pursue(_vehicles[2]);
			_vehicles[0].arrive(new Vector2D(mouseX,mouseY));
			;*/
			vehiclesFlock();
			//_vehicles[0].flock(_vehicles);
			//_vehicle.avoid(_circles)
			//_vehicle.followPath(_path, true);
			//_vehicle.arrive(new Vector2D(mouseX,mouseY))
			for (var i=0; i<_vehicles.length; i++) {
				var vehicle:SteeredVehicle=_vehicles[i];
				vehicle.update();
			}
		}
		private function vehiclesFlock():void {
			for (var i=0; i<_vehicles.length; i++) {
				var vehicle=_vehicles[i];
				vehicle.flock(_vehicles);
			}

		}
		private function makeVehicle(a:Number ,b:Number ):void {
			var vehicle:SteeredVehicle=new SteeredVehicle();
			addChild(vehicle);
			vehicle.position=new Vector2D(a,b);
			vehicle.velocity=new Vector2D(range(),range());
			setInitVehicles(vehicle);
			_vehicles.push(vehicle);
		}
		private function setInitVehicles(vehicle:SteeredVehicle):void {
			vehicle.mass=3
			vehicle.maxSpeed=10;
			vehicle.edgeBehavior=Vehicle.BOUNCE;
			vehicle.maxForce=5
			vehicle.arrivalThreshold=100;
			vehicle.pathThreshold=10;
			vehicle.inSightDist=100
			vehicle.tooCloseDist=10;
		}
		private function range(a:Number =1,b:Number =10):int {
			return Math.floor(Math.random ()*(1+b-a)+a);
		}
		private function makeCircle(a:Number ,b:Number,r:Number =20 ):void {
			var circle:Circle=new Circle(r);
			circle.x=a;
			circle.y=b;
			addChild(circle);
			_circles.push(circle);
			_path.push(new Vector2D(a,b));
		}
		private function onClick(event:MouseEvent):void {
			graphics.lineStyle(0, 0, .25);
			if (_path.length==0) {
				graphics.moveTo(mouseX, mouseY);
			}
			graphics.lineTo(mouseX, mouseY);
			graphics.drawCircle(mouseX, mouseY, 10);
			graphics.moveTo(mouseX, mouseY);
			_path.push(new Vector2D(mouseX, mouseY));
		}


	}
}