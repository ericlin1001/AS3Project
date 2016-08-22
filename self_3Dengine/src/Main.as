package 
{
	import flash.display.Graphics;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Eric
	 */
	public class Main extends Sprite 
	{
		private var  spheres:Array ;
		private var color1:uint = 0xff0000;
		private var color2:uint = 0x00ff00;
		private var colors:Array = new Array(Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff );
		//
		private var oldx:Number;
		private var oldy:Number;
		private var isMouseDown:Boolean = false;
		private var lineContainer:Sprite = new Sprite();
		private var tempSpheres:Array = new Array();
		private var isPlay:Boolean = false;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function moveBy(p:Point3D):void {
			for (var i:int = 0; i < spheres.length; i++) {
				spheres[i].moveBy(p);
			}
		}
		private function init(e:Event = null):void 
		{
			spheres = new Array();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			var bigr:Number = 35;
			var smallr:Number = 6;
			var offset:Number = (bigr+smallr-1) / Math.sqrt(3);
			createShpere(bigr, color2, 0, 0, 0, 30).alpha=0.85;
			createShpere(smallr, color1, offset, offset, offset);
			createShpere(smallr, color1, offset, offset, -offset);
			createShpere(smallr, color1, offset, -offset, offset);
			createShpere(smallr, color1, offset, -offset, -offset);
			createShpere(smallr, color1, -offset, offset, offset);
			createShpere(smallr, color1, -offset, offset, -offset);
			createShpere(smallr, color1, -offset, -offset, offset);
			createShpere(smallr, color1, -offset, -offset, -offset);/**/
			//
			addChild(lineContainer);
			for (var i:int = 0; i < spheres.length; i++) {
				var sphere:Sphere = spheres[i] as Sphere;
				sphere.alpha = 0.9;
				sphere.setVanishPoint(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
				sphere.addEventListener(MouseEvent.CLICK, click);
			}
			//moveBy(new Point3D(100, 0, 0));
			reDrawAll();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(Event.ENTER_FRAME, update);/**/
			var play:Sprite = new Sprite();
			play.x = 100;
			play.y = 100;
			addChild(play);
			var g:Graphics = play.graphics;
			g.lineStyle(0);
			g.beginFill(0xff00ff);
			g.drawRect(50, 50, 80, 60);
			g.endFill();
			play.buttonMode = true;
			play.addEventListener(MouseEvent.CLICK, onplay);
			//play.
		}
		private function onplay(e:MouseEvent):void {
			isPlay = !isPlay;
		}
		private function reDrawAll():void {
			spheres.sortOn("depth", Array.NUMERIC | Array.DESCENDING);
			for (var i:int = 0; i < spheres.length; i++) {
				setChildIndex(spheres[i], i);
				 spheres[i].draw();
			}
			drawLines();
		}
		private function onMouseMove(e:MouseEvent):void {
			if (isMouseDown) {
				var dx:Number = mouseX - oldx;
				var dy:Number = mouseY - oldy;
				for (var i:int = 0; i < spheres.length; i++) {
				var sphere:Sphere = spheres[i] as Sphere;
				var ratio:Number = 0.5/180*3.14;
				//sphere.rotateY( -ratio* dx);
				//sphere.rotateX(ratio * dy);
				sphere.trans(Matrix.getRotationMatrix(-ratio * dy,-ratio* dx,0));
				}
				reDrawAll();
				oldx = mouseX; oldy = mouseY;
			}
		}
		private function drawLine(s1:Sphere, s2:Sphere):void {
			var g:Graphics = lineContainer.graphics;
			//if (s1.depth < tempSpheres[0].depth && s2.depth < tempSpheres[0].depth) { 
			g.moveTo(s1.centerP.screenX, s1.centerP.screenY);
			g.lineTo(s2.centerP.screenX, s2.centerP.screenY);
			//}
		}
		private function drawLines():void {
			var g:Graphics = lineContainer.graphics;
			g.clear();
			g.lineStyle(0);
			drawLine(tempSpheres[1], tempSpheres[2]);
			drawLine(tempSpheres[2], tempSpheres[6]);
			drawLine(tempSpheres[6], tempSpheres[5]);
			drawLine(tempSpheres[5], tempSpheres[1]);
			//
			drawLine(tempSpheres[3], tempSpheres[4]);
			drawLine(tempSpheres[4], tempSpheres[8]);
			drawLine(tempSpheres[8], tempSpheres[7]);
			drawLine(tempSpheres[7], tempSpheres[3]);
			//
			drawLine(tempSpheres[1], tempSpheres[3]);
			drawLine(tempSpheres[2], tempSpheres[4]);
			drawLine(tempSpheres[6], tempSpheres[8]);
			drawLine(tempSpheres[5], tempSpheres[7]);
			
		}
		private function onMouseDown(e:MouseEvent):void {
			isMouseDown = true;
			oldx = mouseX; 
			oldy = mouseY;
		}
		private function onMouseUp(e:MouseEvent):void {
			isMouseDown = false;
		}		
		private function click(e:MouseEvent):void {
			var sphere:Sphere = e.currentTarget as Sphere;
			if (sphere.color == color1) {
				sphere.color = color2;
			}else {
				sphere.color = color1;
			}
			reDrawAll();
		}
		private function createShpere(r:Number, color:uint = 0xaaaa00, tx:Number=0, ty:Number=0,tz:Number=0,preci:Number=0):Sphere {
			var sphere:Sphere = new Sphere();
			addChild(sphere);
			sphere.radius = r;
			sphere.color = color;
			if (preci != 0) {
				sphere.precision = preci;
			}
			sphere.init();
			sphere.moveBy(new Point3D(tx, ty, tz));
			spheres.push(sphere);
			tempSpheres.push(sphere);
			return sphere;
		}
		private function update(e:Event = null):void {
			if (isPlay) {
				var dx:Number = mouseX - 200;
			var dy:Number = mouseY - 200;
			for (var i:int = 0; i < spheres.length; i++) {
				var sphere:Sphere = spheres[i] as Sphere;
				var s:Number = 4;
				sphere.trans(Matrix.getRotationMatrix(Math.PI/60*s,Math.PI/60*s));
			}
			reDrawAll();
			}
		}
		
	}
	
}