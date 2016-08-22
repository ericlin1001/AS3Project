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
	public class BoxGame1 extends Sprite {
		private var world:IsoWorld;
		private var boxA:DrawnIsoBox;
		private var boxB:DrawnIsoBox
		private var speed:Number=3;
		private var size:Number=12;
		private var lx:Number=25;
		private var ly:Number=10;
		private var lz:Number=25;
		//
		private var bounce:Number=-0.98;
		private var friction:Number=0.97;
		private var a:Number=1;
		private var maxSpeed:Number=7;
		private var gravity:Number =0;
		public function BoxGame1() {
			world=new IsoWorld(size);
			addChild(world );
			world.y=100;
			world.x=300;
			//
			boxA=new DrawnIsoBox(size,0xff0000,size);
			boxA.position=new Point3D(0,0,lz/2);
			world.addChildToWorld(boxA);
			boxB=new DrawnIsoBox(size,0x00ff00,size);
			boxB.position=new Point3D(lx,0,lz/2);
			world.addChildToWorld(boxB);
			makeWalls();
			//
			stage.addEventListener(KeyboardEvent.KEY_DOWN,moveBox);
			//stage.addEventListener(KeyboardEvent.KEY_UP ,stopBox);
			//stage.addEventListener(MouseEvent.CLICK ,addBox);
			stage.addEventListener(Event.ENTER_FRAME ,update);
		}
		private function update(e:Event):void {
			if (world.canMove(box)) {
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
			world.sort();
		}
		private function moveBox(e:KeyboardEvent ):void {
//w:87 s:83
			switch (e.keyCode) {
				case 87://w
				if(Math.floor (box.vx)<maxSpeed){
					box.vx-=a;
				}
					break;
				case 83 ://s
					if(Math.floor (box.vx)<maxSpeed){
					box.vx+= a;
				}
					break;
				case Keyboard.UP :
					if(Math.floor (box.vz)<maxSpeed){
					box.vz-= a;
				}
					break;
				case Keyboard.DOWN :
					if(Math.floor (box.vz)<maxSpeed){
					box.vz+= a;
				}
					
					break;
				default :
					trace("default...");
					break;

			}
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