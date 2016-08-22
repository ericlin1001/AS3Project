package {
    import flash.utils.getTimer 
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	public class Jump extends Sprite {
		private var ball:Ball;
		private var gravity:Number=0.3;
		private var speedy:Number=3.8;
		private var speedx:Number=8;
		private var balls:Array;
		private var h:Number=120000;
		private var numBalls:int=2035;
		private var isPause:Boolean=true;
		private var txtField:TextField;
		
		private var line:Sprite;
		private var radiusmax:Number=18;
		private var scoreTxt:TextField;
		private var score:Number=0;
		private var upTxt:TextField;
		private var up:Number=0;
		private var highTxt:TextField;
		private var high:Number=0;
		public function Jump() {
			trace(getTimer())
			 var sig:Signature=new Signature(stage.stageWidth,stage.stageHeight);
			addChild(sig);
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			scoreTxt=new TextField();
			upTxt=new TextField();
			highTxt=new TextField();
			addChild(highTxt);
			addChild(scoreTxt);
			addChild(upTxt);
			ball=new Ball(10);
			balls=new Array()  ;
			line =new Sprite ();
			txtField=new TextField();
			txtField.x=0;
			txtField.y=0;
			txtField.scaleX=7;
			txtField.scaleY=7;
			init();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}

		private function init():void {
			score=0;
			scoreTxt.text="score: "+score.toString();
			scoreTxt.x=stage.stageWidth-90;
			scoreTxt.y=5;
			scoreTxt.scaleX=1;
			scoreTxt.scaleY=1;
			up=5
			upTxt.text="jump: "+high.toString();
			upTxt.x=stage.stageWidth-140
			upTxt.y=5
			upTxt.scaleX=1;
			upTxt.scaleY=1;
			high=0
			highTxt.text="height: "+up.toString()+" m"
			highTxt.x=stage.stageWidth-90
			highTxt.y=20
			highTxt.scaleX=1;
			highTxt.scaleY=1;
			ball.radius=10;
			ball.color=0xff0000;
			addChild(ball);
			ball.x=stage.stageWidth/2;
			ball.y=stage.stageHeight/2-ball.radius;
			ball.vy=- speedy*2.3;
			line.graphics.clear();
			line.graphics.lineStyle(2,0);
			line.graphics.moveTo(0,stage.stageHeight-30);
			line.graphics.lineTo( stage.stageWidth,stage.stageHeight-30);
			addChild(line);
			for (var i:int=0; i < numBalls+1; i++) {
				var myball:Ball=new Ball(7,0x00eedd);
				addChild(myball);
				myball.x=Math.random()*stage.stageWidth-myball.radius*4+myball.radius*2;
				myball.y=- Math.random()*h+stage.stageHeight/2;
				if ((i > numBalls - 60) && (i < numBalls-23)) {
					myball.color=0x0000ff;
					myball.radius=5;
				} else if ((i > numBalls - 23) && (i < numBalls)) {
					myball.color=0xff00ff;
					myball.radius=5;
				} else if (i==numBalls) {
					trace("i == numBalls +1");
					myball.color=0xffff00;
					myball.radius=25;
					myball.y=- h+stage.stageHeight/2;
				}
				balls.push(myball);
			}
			balls.sortOn("y",Array.DESCENDING | Array.NUMERIC);
			trace("min radius:"+balls[numBalls].y);
		}
		private function onEnterFrame(event:Event):void {
			ball.vy+=gravity;
			ball.x+=ball.vx;
			var top:Number=2*stage.stageHeight/10;
			var bottom:Number=9*stage.stageHeight/10;
			if (((ball.y<top)&&(ball.vy<0))||((ball.y>bottom)&&(ball.vy>0))) {
				//control ball or balls to move
				for (var i:int=0; i < balls.length; i++) {
					var myball:Ball=balls[i];
					myball.y-=ball.vy;
					if (myball.y-myball.radius>=stage.stageHeight) {
						removeChild(balls[i]);
						balls.splice(i,1);
					}
				}
			} else {
				ball.y+=ball.vy;
			}
			if (balls[0].y<0-balls[0].radius&&ball.vy>0&&ball.y>top) {
				trace("max y"+balls[0].y);
				shows("You Lose!!!");
				line.graphics.clear();
				line.graphics.lineStyle(2,0);
				line.graphics.moveTo(0,ball.y+ball.radius);
				line.graphics.lineTo( stage.stageWidth,ball.y+ball.radius);
				return;
			}
			checkWall(ball);
			checkCollsion(ball);
			scoreTxt.text="score: "+score.toString();
			upTxt.text="jump: "+up.toString();
		}
		private function shows(value:String="") {
			txtField.text=value;
			addChild(txtField);
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN ,onMouseDown);
		}
		private function onMouseDown(event:Event):void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN ,onMouseDown);
			removeChild(ball);
			removeChild(txtField);
			isPause=true;
			for (var i:int=0; i < balls.length; i++) {
				removeChild(balls[i]);

			}
			balls.splice(0);
			trace("blls.len"+balls.length );
			init();
		}
		private function checkCollsion(balla:Ball):void {
			for (var i:int=0; i < balls.length; i++) {
				var myball:Ball=balls[i];
				var dx:Number=balla.x-myball.x;
				var dy:Number=balla.y-myball.y;
				var dist:Number=Math.sqrt(dx*dx+dy*dy);
				if (dist<=myball.radius+balla.radius) {
					//collsion
					score+=50;
					if ((myball.color == 0x0000ff) && (ball.radius <= radiusmax)) {
						//become bigger
						score+=100;
						ball.radius=+ ball.radius+0.5;
					}
					if (myball.color==0xff00ff) {
						//become bigger
						score+=200;
						up+=1;
					}
					if (myball.radius==25) {
						shows("You Win!");
						trace(" I : "+i+"myball.radius"+myball.radius);
						return;
					}
					removeChild(balls[i]);
					balls.splice(i,1);
					balla.vy=- speedy*3;
				}
			}
		}
		private function checkWall(b:Ball) {
			if (b.x-b.radius>stage.stageWidth) {
				b.x=- b.radius;
			} else if (b.x + b.radius < 0) {
				b.x=b.radius+stage.stageWidth;
			}
		}
		private function onKeyUp(event:KeyboardEvent):void {
			ball.vx=0;
		}
		private function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.RIGHT :
					trace(event.keyCode);
					ball.vx=speedx;
					break;
				case Keyboard.UP :
					if (up>0) {
						up-=1;
						ball.vy=- speedy*4;
					}
					break;
				case Keyboard.LEFT :
					trace("up");
					ball.vx=- speedx;
					break;
				case Keyboard.SPACE :
					line.graphics.clear();
					trace("SPACE");
					if (! isPause) {
						removeEventListener(Event.ENTER_FRAME,onEnterFrame);
					} else {
						addEventListener(Event.ENTER_FRAME,onEnterFrame);
					}
					isPause=! isPause;
					break;
				case Keyboard.ENTER :
					line.graphics.clear();
					trace("SPACE");
					if (! isPause) {
						removeEventListener(Event.ENTER_FRAME,onEnterFrame);
					} else {
						addEventListener(Event.ENTER_FRAME,onEnterFrame);
					}
					isPause=! isPause;
					break;
				default :
					break;

			}
		}
	}
}