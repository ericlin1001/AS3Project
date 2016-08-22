package {
	import com.isomeric.*;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	//import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 * File: D:\我的文档\AS参考练习\學校\AS教程练习\ASGames\BoxGame.as
Created: 2011-3-12 15:03:46
Modified: 2011-3-11 22:30:40
Size: 3832 bytes
	 */
	public class BoxGame extends Sprite {
		private var world:IsoWorld;
		private var box:DrawnIsoBox;
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
		private var gravity:Number = 0.5;
		//
		public static const statt:Number = 5;
		public var te:Number = 2;
		protected var we:Number = 5;
		static var w:Number = 5;
		public function BoxGame() {
			world=new IsoWorld(size);
			addChild(world );
			world.y=100;
			world.x=300;
			//
			box=new DrawnIsoBox(size,0xff0000,size);
			box.position=new Point3D(0,0,0);
			world.addChildToWorld(box);
			makeWalls();
			//
			stage.addEventListener(KeyboardEvent.KEY_DOWN,moveBox);
			//stage.addEventListener(KeyboardEvent.KEY_UP ,stopBox);
			//stage.addEventListener(MouseEvent.CLICK ,addBox);
			stage.addEventListener(Event.ENTER_FRAME ,update);
		}
		public function tt():void {
			trace("23");
		}
		protected function we():void {
			;
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

			switch (e.keyCode) {
				case Keyboard.LEFT :
				if(Math.floor (box.vx)<maxSpeed){
					box.vx-=a;
				}
					break;
				case Keyboard.RIGHT :
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
				case Keyboard.SPACE  :
					if(Math.floor (box.vy)<maxSpeed){
					box.vy+= a;
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