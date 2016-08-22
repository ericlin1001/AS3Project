package {
	import com.isomeric.*;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	import flash.events.*;
	import flash.ui.Keyboard;
	public class UnionTest extends Sprite {
		private var world:IsoWorld;
		private var box:IsoBox;
		private var boxA:DrawnIsoBox;
		private var boxB:DrawnIsoBox
		private var speed:Number=3;
		private var size:Number=12;
		private var lx:Number=25;
		private var ly:Number=10;
		private var lz:Number=25;
		//
		private	var union:IsoCuboid ;
		private var bounce:Number=-0.98;
		private var friction:Number=0.97;
		private var a:Number=1;
		private var maxSpeed:Number=7;
		private var gravity:Number =0;
		public function UnionTest() {
			world=new IsoWorld(size);
			addChild(world );
			world.y=100;
			world.x=300;
		
			makeWalls();
			 union = new IsoCuboid(size, 0xff0000, 40, 7, 5);
			var t:Array=union.components;
			for (var k:uint=0;k<t.length ;k++){
				world.addChildToWorld (t[k]);
			}
			union.position = new Point3D(size * 10, 0, size * 10);
				//
			stage.addEventListener(KeyboardEvent.KEY_DOWN,moveBox);
			stage.addEventListener(Event.ENTER_FRAME , update);
		}
		private function update(e:Event):void {
		/*	if (world.canMove(box)) {
				box.x+=box.vx;
				box.y+=box.vy;
				box.z+=box.vz;
			}
			if(box.y+box.vy*friction>0){
				box.vy-=gravity;
			}
			box.vx*=friction;
			box.vy*=friction;
			box.vz*=friction;
			isInRoom(box,[0,lx*size],[0,ly*size],[0,lz*size]);
			world.sort();*/
		}
		private function moveBox(e:KeyboardEvent ):void {
//w:87 s:83
			switch (e.keyCode) {
				case 87://w
				if(Math.floor (union.vx)<maxSpeed){
					union.vx-=a;
				}
					break;
				case 83 ://s
					if(Math.floor (union.vx)<maxSpeed){
					union.vx+= a;
				}
					break;
				case Keyboard.UP :
					if(Math.floor (union.vz)<maxSpeed){
					union.vz-= a;
				}
					break;
				case Keyboard.DOWN :
					if(Math.floor (union.vz)<maxSpeed){
					union.vz+= a;
				}
					
					break;
				default :
					trace("default...");
					break;
			}
			union.x += union.vx;
			union.y += union.vy;
			union.z += union.vz;
		}
		private function isInRoom(obj:IsoObject,xA:Array ,yA:Array ,zA:Array ):void {
			if (obj.x<xA[0]) {
				obj.x=xA[0];
				obj.vx*=bounce;
			} else if (obj.x>xA[1]) {
				obj.x=xA[1];
				obj.vx*=bounce;
			}
			if (obj.y<yA[0]) {
				obj.y=yA[0];
				obj.vy*=bounce;
			} else if (obj.y>yA[1]) {
				obj.y=yA[1];
				obj.vy*=bounce;
			}
			if (obj.z<zA[0]) {
				obj.z=zA[0];
				obj.vz*=bounce;
			} else if (obj.z>zA[1]) {
				obj.z=zA[1];
				obj.vz*=bounce;
			}
		}
		private function makeWalls():void {
			for (var i:int =0; i <lx; i++) {
				for (var j:int = 0; j < lz; j++) {
					var tile:IsoTile=new IsoTile(size,0x807A4D);
					tile.position=new Point3D(i*size,0,j*size);
					world.addChildToFloor(tile);
				}
			}
			//right
			for (i = 0; i < lx; i++) {
				for (j = 0; j < ly; j++) {
					var ttile:IsoBox=new IsoBox(size,0x3886FA,size);
					ttile.position=new Point3D(i*size,j*size,- size);
					world.addChildToFloor(ttile);
				}
			}
			//left
			for (i = 0; i < lz; i++) {
				for (j = 0; j < ly; j++) {
					ttile=new IsoBox(size,0x3886FA,size);
					ttile.position=new Point3D(- size,j*size,i*size);
					world.addChildToFloor(ttile);
				}
			}
			//end init;
		}
		private function addBox(e:MouseEvent ):void {
			var p:Point3D=IsoUtilis.screenToIso(new Point(world.mouseX,world.mouseY));
			p.x=Math.floor(p.x/size)*size;
			p.y=Math.floor(p.y/size)*size;
			p.z=Math.floor(p.z/size)*size;
			var tbox:IsoBox=new IsoBox(size,Math.random()*0xffffff,size);
			tbox.position=p;
			world.addChildToWorld(tbox);
		}
		private function stopBox(e:KeyboardEvent ):void {
			box.vx=0;
			box.vy=0;
			box.vz=0;
		}
	}

}