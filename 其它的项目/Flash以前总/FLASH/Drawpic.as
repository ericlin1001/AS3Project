package {
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Drawpic extends Sprite {
		private var rubball:Ball;
		private var pic:Sprite;
		private var num :uint =15
		private var color:uint=0;
		private var colorballs:Array =new Array()
		public function Drawpic() {
			init();
		}
		private function init():void {
			rubball=new Ball(10);
			rubball.x=10;
			rubball.y =10;
			addChild(rubball);
			pic=new Sprite();
			addChild(pic);
colorballs=new Array()
			for (var i:int=0; i<num; i++) {
				var co:uint =0xffffff * i /(num-1)
				var ball:Ball =new Ball(10,co,0,0);
				
				colorballs.x=10;
				ball.y=45+i * 23
				addChild(ball);

				colorballs.push (ball)
			    
				
			}
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			rubball.addEventListener(MouseEvent.CLICK ,onrubClick);
		}
		private function onMouseDown(evt:MouseEvent):void {
			pic.graphics.moveTo(mouseX,mouseY);
			pic.graphics.lineStyle(1,color );
			stage.addEventListener(MouseEvent.MOUSE_MOVE ,onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			trace(evt.type);
			if(mouseX<21){
				for (var i:int=0; i<num; i++) {
				var dx:Number =mouseX -colorballs[i].x
				var dy:Number =mouseY-colorballs[i].y
				var dist:Number =Math.sqrt (dx*dx+dy*dy)
				
				if(dist<=10){
					color =0xffffff * i /(num-1)
					
				}
			    
				
			}
				
			}

		}
		private function onrubClick(evt:Event):void {
			pic.graphics.clear();
			trace(evt);
		}
		private function onMouseMove(evt:MouseEvent):void {
			trace("move");
			pic.graphics.lineTo(mouseX,mouseY);
		}
		private function onMouseUp(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE ,onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			trace("up");
		}
	}
}