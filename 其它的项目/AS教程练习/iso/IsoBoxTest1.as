package 
{
	import com.isomeric.*;
	import flash.display.Sprite ;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	 import flash.events.*;
	 import flash.ui.Keyboard;
	public class  IsoBoxTest1 extends Sprite
	{
		private var world:IsoWorld ;
		private var box:DrawnIsoBox;
		private var speed:Number=3;
		public function IsoBoxTest1() {
			world = new IsoWorld (20);
			addChild (world );
			world.y=100;
			world.x=300;
			for (var i:int = 0; i < 20; i++) {
				for (var j:int = 0; j < 20; j++) {
					var ttile:IsoBox = new IsoBox(20,0xbbaa00,20);
					ttile.position = new Point3D(i * 20,-20,j * 20 );
					world.addChildToFloor(ttile);
				}
			}
			//right
			for ( i = 0; i < 20; i++) {
				for ( j = 0; j < 20; j++) {
					 ttile = new IsoBox(20,0x00cccc,20);
					ttile.position = new Point3D(i * 20,j * 20, -20);
					world.addChildToFloor(ttile);
				}
			}
			//left
			for ( i = 0; i < 20; i++) {
				for ( j = 0; j < 20; j++) {
					 ttile = new IsoBox(20,0x00cccc,20);
					ttile.position = new Point3D(-20,j * 20,i * 20);
					world.addChildToFloor(ttile);
				}
			}
			//end init;
			box=new DrawnIsoBox(20,0xff0000,20);
			box.position=new Point3D(0,0,0)
			world.addChildToWorld (box);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,moveBox);
			stage.addEventListener(KeyboardEvent.KEY_UP ,stopBox);
			stage.addEventListener(MouseEvent.CLICK ,addBox);
			world.addEventListener (Event.ENTER_FRAME ,update)
			
		}
		private function addBox(e:MouseEvent ):void{
			var p:Point3D=IsoUtilis.screenToIso(new Point(world.mouseX,world.mouseY));
			p.x=Math.floor (p.x/20)*20;
			p.y=Math.floor (p.y/20)*20;
			p.z=Math.floor (p.z/20)*20;
			var tbox:IsoBox=new IsoBox(20,Math.random ()*0xffffff,20);
			tbox.position=p;
			world.addChildToWorld(tbox);
		}
		private function update(e:Event):void{
			if(world.canMove(box)){
			box.x+=box.vx;
			box.y+=box.vy;
			box.z+=box.vz;
			}
			world.sort();
		}
		private function moveBox(e:KeyboardEvent ):void{
			
			switch(e.keyCode){
				case Keyboard.LEFT :
				box.vx=-speed;
				break;
				case Keyboard.RIGHT :
				box.vx=speed;
				break;
				case Keyboard.UP  :
				box.vz=-speed;
				break;
				case Keyboard.DOWN  :
				box.vz=speed;
				break;
				default:
				trace("default...")
				break;
			
			}
		}
		private function stopBox(e:KeyboardEvent ):void{
			box.vx=0;
			box.vy=0;
			box.vz=0;
		}
	}
	
}