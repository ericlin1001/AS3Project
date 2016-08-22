package {
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.ui.Mouse;
	//
	public class MemoryGame2 extends Sprite {
		private var numLights:int=5;
		private var lights:Array;//store flashLight;
		private var playOrders:Array;//the order of playing lights;
		private var replayOrders:Array;
		private var level:int=0;
		private var gameMode:String="play";
		private var pLight:int=0;
		private var prLight:int=0;
		//
		private var messageText:TextField;
		private var message2Text:TextField;
		private var levelText:TextField;
		private var container:Sprite;
		private var lightOnTimer:Timer;
		//constrator
		public function MemoryGame2() {
			//
			messageText=new TextField();
			messageText.multiline=true;
			messageText.y=160;
			message2Text=new TextField();
			message2Text.multiline=true;
			message2Text.y=240;
			addChild(messageText);
			addChild(message2Text);
			var txtFt:TextFormat=new TextFormat();
			txtFt.font="Arial";
			txtFt.size=18;
			txtFt.align="center";
			txtFt.bold=false;
			messageText.defaultTextFormat=txtFt;
			messageText.text="";
			message2Text.defaultTextFormat=txtFt;
			message2Text.text="";
			messageText.width=400;
			message2Text.width=400;
			message2Text.selectable=false;
			messageText.selectable=false;
			levelText=new TextField();
			levelText.y=35;
			levelText.x=20;
			levelText.selectable=false;
			levelText.width=400;
			addChild(levelText);
			txtFt.align="left";
			txtFt.bold=true;
			txtFt.size=22;
			levelText.defaultTextFormat=txtFt;
			//
			container=new Sprite();
			addChild(container);
			container.y=100;
			container.x=50;
			lights=new Array();
			for (var i:uint=0; i<numLights; i++) {
				var light:FlashLight=new FlashLight(30);
				light.y=0;
				light.x=75*i;
				light.num=i;
				light.addEventListener(MouseEvent.CLICK,clickLight);
				container.addChild(light);
				lights.push(light);
			}
			lights[0].color=0xff0000;
			lights[1].color=0x888800;
			lights[2].color=0x00ff00;
			lights[3].color=0x008888;
			lights[4].color=0x0000ff;
			setLevelText();
			playOrders=new Array();
			replayOrders=new Array();
		}
		public function start():void{
			playOrders.push(0);
			nextLevel();
		}
		private function setLightButton(t:Boolean ) {
			for (var i:uint=0; i<numLights; i++) {
				lights[i].buttonMode=t;
			}
		}
		private function setLevelText() {
			levelText.text="Level: "+level;
		}
		private function setplayOrders() {
			for (var i=0; i<20; i++) {
				do {
					var r:int=Math.floor(Math.random()*numLights);
				} while (r==playOrders[playOrders.length -1]);
				playOrders.push(r);
			}
		}
		//*********************function************
		private function nextLevel():void {
			setLightButton(false);
			Mouse.hide()
			gameMode="play";
			level++;
			do {
				var r:int=Math.floor(Math.random()*numLights);
			} while (r==playOrders[playOrders.length -1]);
			playOrders.push(r);
			trace(playOrders);
			pLight=0;
			replayOrders=playOrders.concat();
			message2Text.text="";
			messageText.text="请仔细观看!";
			setLevelText();
			//
			lightOnTimer=new Timer(1300,level+1);
			lightOnTimer.addEventListener(TimerEvent.TIMER,lightOn);
			lightOnTimer.start();
			//
		}
		private function lightOn(e:TimerEvent):void {
			if (pLight>=level) {//flashing light is over;
				Mouse.show();
				pLight=0;
				prLight=0;
				gameMode="replay";
				playerReplay();
				return;
			} else {
				lights[playOrders[pLight]].flashOn(1200);
				pLight++;
			}
		}
		private function playerReplay() {
			//messageText.text="";
			message2Text.text="现在按照刚才顺序点亮些灯.";
			setLevelText();
			setLightButton(true);
		}
		private function clickLight(e:MouseEvent):void {
			if (gameMode=="test") {//testing
				var tlight:FlashLight=e.currentTarget as FlashLight;
				if (tlight!=null) {
					tlight.flashOn();
					return;
				}
			}
			if (gameMode!="replay") {//ensure you are playing 
				return;
			} else {
				var light:FlashLight=e.currentTarget as FlashLight;
				if (light!=null) {
					if (light.num==playOrders[prLight]) {
						light.flashOn();
						if (prLight>=level-1) {
							nextLevel();
						}
					} else {
						lose();
						trace(playOrders);
						trace("tt:");
						trace(light.num,playOrders[prLight]);
						message2Text.appendText("\n正确顺序是: "+getaddone(playOrders));
					}
					prLight++;
				}
			}
		}
		private function getaddone(A:Array ):String {
			var t:String="";
			var l:int=A.length;
			for (var i=0; i<l-2; i++) {
				t+=(A[i]+1)+",";
			}
			t+=(A[l-1]+1);
			return t;

		}
		private function win() {
			messageText.appendText("You wins!!!");
			var t:Sprite
		
		}
		private function lose() {
			messageText.text="Game Over!!!";
			message2Text.text="";
			gameMode="lose";
			var data:Object={message:"You Lose.",level:level};
			dispatchEvent(new GameEvent(GameEvent.OVER,data));
		}

	}
}