package {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.engine.JustificationStyle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class CanChooseGameOne extends BaseGame {
	/*	private var addEnemyCounter:Timer=new Timer(1000,0);
		private var timeForAddEnemies:uint=0;
		private var interval:int=24;
		private var maxTurn:int=25;
		private var havsCreatedAll:Boolean=false;
		private var colorTurn:uint=Math.random()*0xffffff;
		//for enemies
		private var numEnemies:int=10;
		private var addEveryNum:int=4;
		private var maxHpForEnemy:Number=45;
		private var addEveryHp:Number=20;
		private var gainMoney:Number=11;
		private var addEveryGainMoney:Number=1;
		private var speed:Number=0.8;//0.8
		private var addEverySpeed:Number=0.2;
		//for tank
		private var addEveryCost:Number=2;
		private var power:Number=8;
		private var addEveryPower:Number=0.1;
		private var size:Number=13;
		private var addEverySize:Number=0.1;
		private var range:Number=35;
		private var addEveryRange:Number=0.5;
		private var bulletSpeed:Number=2.4;
		private var addEveryBulletSpeed:Number=0.2;
		private var rechargeRate:Number=6;
		private var addEveryRechargeRate:Number=0.5;
		//
		*/
		private var _level:Number=20;
		private var levelText:TextField;
		private var lifeText:TextField;
		private var moneyText:TextField;
		//
		public function CanChooseGameOne() {
			super(0, 35, 28);
			graphics.lineStyle(0);
			graphics.drawRect(0, 0, mapSize*19+mapX, mapSize*13+mapY);
			if (stage != null) {
				stage.scaleMode =StageScaleMode.NO_SCALE
				stage.align = StageAlign.TOP_LEFT;
			}
			start();
		}
		/*private function clickOnMap(e:MouseEvent):void {
			if (! isPause) {
				if (money>=cost) {
					var mx:uint = (mouseX - mapX) / mapSize;
					var my:uint = (mouseY - mapY) / mapSize;
					if (0<=mx&&mx<numCols&&0<=my&&my<numRows) {
						if (maps[my][mx]==1) {
							//trace("maps[my][mx] " + maps[my][mx] );
							var t:Tank=addTankToMap(mx,my,0xffffff*Math.random(),0xffffff*Math.random());
							t.rechargeRate=rechargeRate;
							t.power=power;
							t.maxNumBullets=8;
							t.range=range;
							t.bulletSpeed=bulletSpeed;
							t.start();
							t.cost=cost;
							t.size=Math.min(mapSize,size);
							money-=t.cost;
							//
							bulletSpeed+=addEveryBulletSpeed;
							addEveryCost+=1;
							cost+=int(addEveryCost);
							power+=addEveryPower;
							addEverySize*=0.95;
							size+=addEverySize;
							range+=addEveryRange;
							rechargeRate+=addEveryRechargeRate;
						}
					}
				}
			}
		}
		override public function addSomeEnemies(num:int, type:String = "enemy"):void {
			//if (!isCreating) {
			var timer:Timer=new Timer(1000,num);
			timer.addEventListener(TimerEvent.TIMER, creatingEnemies);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, creatComplete);
			timer.start();
			isCreating=true;
			//}
		}
		override protected function update(e:Event = null):void {
			super.update(e);
			if (! isPause) {
				if (life<=0) {
					loseGame();
				}
				if (havsCreatedAll&&enemies.length==0) {
					winGame();
				}
			}
		}
		override protected function addObjects():void {
			addEventListener(MouseEvent.CLICK, clickOnMap);
			addEnemyCounter.addEventListener(TimerEvent.TIMER, addOneTurn);
			//super.addObjects();
			addEnemyCounter.start();
			addSomeEnemies(numEnemies);
			//
		}
		private function addOneTurn(e:TimerEvent):void {
			timeForAddEnemies++;
			if (timeForAddEnemies>numEnemies+interval) {
				timeForAddEnemies=0;
				numEnemies+=addEveryNum;
				if (numEnemies>=maxTurn) {
					havsCreatedAll=true;
					trace("havsCreatedAll = true;");
				} else {
					addEveryHp+=15;
					maxHpForEnemy+=addEveryHp;
					gainMoney+=addEveryGainMoney;
					speed+=addEverySpeed;
					colorTurn=Math.random()*0xffffff;
					level++;
					addSomeEnemies(numEnemies);//to start adding
				}

			}

		}
		private function winGame(e:TimerEvent=null):void {
			trace("You win!!!");
			pause();
			addEnemyCounter.stop();
			var t:TextField = new TextField();
			addChild(t);
			t.text="You win!!!";
			t.selectable=false;
			t.textColor=0xff0000;
			t.height=60;
			t.x=100;
			t.y=100;
			t.scaleX=5;
			t.scaleY=5;
		}
		private function loseGame(e:TimerEvent=null):void {
			trace("You lose!!!");
			pause();
			addEnemyCounter.stop();
			var t:TextField = new TextField();
			t.textColor=0xff0000;
			addChild(t);
			t.text="You lose!!!";
			t.selectable=false;
			t.height=60;
			t.x=100;
			t.y=100;
			t.scaleX=5;
			t.scaleY=5;
		}
		private function creatingEnemies(e:TimerEvent = null):void {
			var t:Enemy=addEnemy();
			t.totalHp=maxHpForEnemy;
			t.gainMoney=gainMoney;
			t.speed=speed;
			t.color=colorTurn;
			t.start();
			trace("creating the "+e.target.currentCount+" of "+e.target.repeatCount+" enemies.");
		}
		private function creatComplete(e:TimerEvent = null):void {
			isCreating=false;
			trace("creating enemies has completed.");
		}*/
		override protected function init():void 
		{
			super.init();
			moneyText = new TextField();
			moneyText.x = 5;
			moneyText.selectable = false;
			moneyText.autoSize = TextFieldAutoSize.LEFT;
			fieldContainer.addChild(moneyText);
			//
			lifeText = new TextField();
			lifeText.selectable = false;
			lifeText.x = 230;
			lifeText.autoSize = TextFieldAutoSize.LEFT;
			fieldContainer.addChild (lifeText);
			//
			levelText = new TextField();
			addChild(levelText);
			levelText.x = 380;
			levelText.autoSize = TextFieldAutoSize.LEFT;
			levelText.selectable = false;
			//
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0x10703C;
            format.size = 24;
            moneyText.defaultTextFormat = format;
			lifeText.defaultTextFormat = format;
			levelText.defaultTextFormat = format;
			money = 100;
			life = 20;
			level = 1;
			//
		}
		override protected function addObjects():void 
		{
			addSomeEnemies(EnemyOne,10,50);
			var p:Point = mapToScreen(new Point(2, 2));
			addTank(TankOne, p.x, p.y);
			if (!isPause) {
				start();
			}
		
		}
		//getter and setter :
		override public function set life(value:Number):void 	{
			updateLifeText();
			super.life = value;
		}
		override public function set money(value:Number):void 	{
			updateMoneyText();
			super.money = value;
		}
		private function updateMoneyText():void {
			moneyText.text = "money : " + money.toString();
		}
		private function updateLifeText():void {
			lifeText.text = "life : " + life.toString();
		}
		//
		public function get level():Number {
			return _level;
		}

		public function set level(value:Number):void {
			_level=value;
			updateLevelText();
		}
		private function updateLevelText():void {
			levelText.text="level : "+level.toString();
		}
		//
		
	}

}