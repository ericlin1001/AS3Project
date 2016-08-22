package {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.text.TextField 
	import flash.events.MouseEvent 
	public class model extends Sprite {
		private var ball:Ball;
		private var ax:Number =1;
		private var ay:Number =1;
		private var gravity:Number =0.2;
		private var friction :Number =0.98;
		private var txtField:TextField 
		public function model() {
			init();
		}
		private function init() {
			 ball=new Ball(20);
			addChild(ball);
			txtField =new TextField()
			addChild(txtField)
			ball.x=275;
			ball.y=stage.stageHeight/2;
			ball.vy=-10;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN ,onMouseDown);
		}
		private function onEnterFrame(event:Event):void {
			ball.vy += gravity;
			ball.vy *= friction ;
			ball.vx *= friction ;
			ball.x += ball.vx;
			ball.y += ball.vy;
			
		}
		private function onMouseDown (event:Event):void{
			txtField.text =ball.x.toString()+" , "+ball.y.toString()
		}
		private function onKeyDown(evt:KeyboardEvent) {
			switch (evt.keyCode) {
				case Keyboard.DOWN :
					ball.vy += ay;
					break;
				case Keyboard.UP :
					ball.vy -= ay;
					break;
				case Keyboard.LEFT :
					ball.vx -= ax;
					break;
				case Keyboard.RIGHT :
					ball.vx += ax;
					break;
				default :
					break;
			}
		}
	}
}