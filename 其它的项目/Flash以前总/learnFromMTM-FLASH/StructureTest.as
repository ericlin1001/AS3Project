package {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.foed.Vector2D;
	import flash.events.MouseEvent;
	public class StructureTest extends Sprite {
		private var target:Structure;
		private var _structures:Array;
		public function StructureTest() {
			_structures=new Array();
			var a=30
			target=makeStructure(new Array(0,0,a,0,a,a,0,a));
			target.addPosition=new Vector2D(100,350)
			target.velocity=new Vector2D()
			_structures.push(makeStructure(new Array(0,380,550,380,550,450,0,450)));
			_structures.push(makeStructure(new Array(0,200,70,400,0,400)));
			_structures.push(makeStructure(new Array(550,200,480,400,550,400)));
			addEventListener(Event.ENTER_FRAME ,onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN ,KeyDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN ,MouseDown);
trace(target.points.length)
		}
		private function MouseDown(e:MouseEvent ):void {


		}
		private function KeyDown(evt:KeyboardEvent):void {
			var ax:Number=0;
			var ay:Number=0;
			var speed=2;
			switch (evt.keyCode) {
				case Keyboard.UP :
					ay=- speed;
					break;
				case Keyboard.DOWN :
					ay=speed;
					break;
				case Keyboard.RIGHT :
					ax=speed;
					break;
				case Keyboard.LEFT :
					ax=- speed;
					break;
				default :
					break;
			}
			target.addVelocity=new Vector2D(ax,ay);
		}
		private function setOutside(target:Structure):void {
			for (var i=0; i<_structures.length ; i++) {
				var structure=_structures[i];
				for (var j=0; j<target.points.length; j++) {
					var point=target.points[j];
					var changePoint:Vector2D=structure.putOutside(point,0);
					if(changePoint.x==0 && changePoint.y==0){}else{
					var bounce:Number=1
					target.addPosition=changePoint
					changePoint=changePoint.normalize()
					
					target.addVelocity=changePoint.multiply(-2*changePoint.dotProd(target.velocity))
					
					
					trace("hit")}
				}

			}
		}
		private function makeStructure(data:Array):Structure {
			var points:Array=new Array();
			for (var i=0; i<data.length; i=i+2) {
				points.push(makepoint(data[i],data[i+1]));
			}
			return new Structure(points);

		}
		private function makepoint(a:Number ,b:Number ):VerletPoint {
			var point:VerletPoint=new VerletPoint(a,b);
			return point;
		}
		private function structuresUpdate() {
			for (var i=0; i<_structures.length ; i++) {
				var structure=_structures[i];
				structure.update();
			}
		}
		private function onEnterFrame(evnt:Event):void {
			var gravity=0.7
			target.addVelocity=new Vector2D(0,gravity)
			target.update();
			structuresUpdate();
			setOutside(target);
			graphics.clear();
			drawTarget();
			drawStructures();
		}
		private function drawTarget() {
			target.draw(graphics);
		}
		private function drawStructures():void {
			
			for (var i=0; i<_structures.length ; i++) {
				var structure=_structures[i];
				structure.draw(graphics);
				
			}

		}

	}

}