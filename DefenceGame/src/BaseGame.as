package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class BaseGame extends Sprite 
	{
		//
		public var mapX:Number = 50;
		public var mapY:Number = 50;
		public var mapSize:Number = 30;
		
		//the following Vars is setted by the data from the map.txt
		public var numRows:Number;
		public var numCols:Number;
		public var maps:Array ;//the map of the game
		public var colors:Array ;
		public var pathX:Array ;
		public var pathY:Array ;
		public var pathSX:Array ;
		public var pathSY:Array ;
		//
		public var enemies:Array;
		public var tanks:Array;
		public var tankContainer:Sprite;
		public var enemyContainer:Sprite;
		public var fieldContainer:Sprite;
		//
		private var _money:Number = 100;
		private var moneyText:TextField;
		private var _life:Number = 20;
		private var lifeText:TextField;
		//
		public var isCreating:Boolean = false;
		public var isPause:Boolean=true;
		public function BaseGame(pathOfMap:String="map.txt") 
		{
			super();
			var loaderMap:LoadMap = new LoadMap();//just to load the map
			loaderMap.addEventListener(Event.COMPLETE, loadedMap);
			try{
			loaderMap.loadMap(pathOfMap);
			}catch (err:IOError)
			{
				trace("IOError：" + err);
			}
			setupField();
			//start();
		}
		private function init():void {
			money = 100;
			life = 20;
			drawField();//draw the map.
			this.addEventListener(Event.ENTER_FRAME, update);//to start game's loop
			addObjects();
		}
		public function addObjects():void {
			//this is the function to add objects to map.
			//you can override this function and to add other objects.
			addSomeEnemies(10);
			addTankToMap(4, 2).start();
		}
		public function update(e:Event = null):void {
			if (!isPause) {
				updatEnemies();
				updateTanks();
			}
			
		}
		//Method:'
		public function addEnemy(sxs:Array ,sys:Array,speed:Number=1.3):Enemy {
			//to add one tank to stage
			var enemy:Enemy = new Enemy();
			enemy.x = sxs[0];
			enemy.y = sys[0];
			enemy.pathSX = sxs;
			enemy.pathSY = sys;
			enemy.speed = speed;
			enemyContainer.addChild(enemy);
			enemies.push (enemy);
			return enemy;
		}
		public function addTank(tx:Number=20,ty:Number=20,color1:uint=0x00ffff,color2:uint=0xff00ff):Tank {
			//to add one tank to stage
			var tank:Tank = new Tank();
			tank.x = tx;
			tank.y = ty;
			tank.range = 50;
			tank.size = mapSize-10;
			tank.rechargeRate = 15;
			tank.maxNumBullets = 5;
			tank.draw(color1,color2);
			tankContainer.addChild(tank);
			tanks.push (tank);
			return tank;
		}
		public function addTankToMap(mx:uint=1, my:uint=1,color1:uint=0x00ffff,color2:uint=0xff00ff):Tank {
			return addTank(mapX + mapSize * (0.5+mx), mapY+ mapSize * (my+0.5),color1,color2);
		}
		private function setupField():void {
			fieldContainer = new Sprite();
			tankContainer = new Sprite();
			enemyContainer = new Sprite();
			addChild(fieldContainer);
			addChild (tankContainer);
			addChild(enemyContainer);
			enemies = new Array ();
			tanks = new Array ();
			moneyText = new TextField();
			moneyText.selectable = false;
			fieldContainer.addChild(moneyText);
			//
			lifeText = new TextField();
			lifeText.selectable = false;
			lifeText.x = 200;
			fieldContainer.addChild (lifeText);
			//
		}
		private function loadedMap(e:Event):void {
			//set Vars from the data of the map.txt
			trace("haved loaded the maps in debugMain:"+e.target);
			var loaderMap:LoadMap = LoadMap(e.target);
			maps = loaderMap.maps;
			numRows = maps.length;
			numCols = maps[0].length;
			trace("this map is: "+numCols+"*"+numRows)
			pathX = loaderMap.paths[0];
			pathY = loaderMap.paths[1];
			colors = loaderMap.colors[0];
			pathSX = new Array ();
			pathSY = new Array ();
			for (var i:int = 0; i < pathX.length; i++) 
			{
				//calculate the exact position for enemy
				pathSX[i] = mapX + mapSize * 0.5 + pathX[i] * mapSize;
				pathSY[i] = mapY + mapSize * 0.5 + pathY[i] * mapSize;
			}
			init();//to init the game;
		}
	
		private function drawField():void {
			//draw the map
			var g:Graphics = fieldContainer.graphics;
			g.clear();
			g.lineStyle(0);
			for (var i:int = 0; i < numRows; i++) {
				for (var j:int = 0; j < numCols; j++) 
				{
					var color:uint = colors[uint(maps[i][j])];
					g.beginFill(color);
					g.drawRect(mapX + j * mapSize, mapY + i * mapSize, mapSize, mapSize);
					g.endFill();
				}
			}
			
		}
		//
		public function addSomeEnemies(num:int, type:String = "enemy"):void {
			if (!isCreating) {
				var timer:Timer = new Timer(1000, num);
				timer.addEventListener(TimerEvent.TIMER, creatingEnemies);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, creatComplete);
				timer.start();
				isCreating = true;
			}
		}
		private function creatingEnemies(e:TimerEvent = null):void {
			addEnemy(pathSX,pathSY).start();
			trace("creating the "+e.target.currentCount+" of "+e.target.repeatCount+" enemies.")
		}
		private function creatComplete(e:TimerEvent = null):void {
			isCreating = false;
			trace("creating enemies has completed.");
		}
		//
		private function updatEnemies():void {
			for (var i:int = 0; i < enemies.length; i++) {
				var item:Enemy = enemies[i];
				if (item.state == Enemy.DEAD) {
					money += item.gainMoney;
					enemyContainer.removeChild(item);
					enemies.splice(i, 1);
				}else if (item.state == Enemy.FINISH_PATH) {
					life-=item.power;
					enemyContainer.removeChild(item);
					enemies.splice(i, 1);
				}else {
					item.update();
				}
			}
		}
		private function updateTanks():void {
			//update all tanks
			for (var j:int = 0; j < tanks.length; j++) 
			{
					var item:Tank = tanks[j];
					item.update();
					if (item.target == null || item.target.state==Enemy.DEAD) {
						for (var i:int = 0; i < enemies.length; i++) 
						{
							var enemy:Enemy = enemies[i];
							var dx:Number = item.x - enemy.x;
							var dy:Number = item.y - enemy.y;
							if (dx * dx + dy * dy < item.range * item.range) {
								item.target = enemy;//find the enemy in tank's range.
								break;
							}
						}
					}
			}
		}
		//
		public function start():void {
			isPause = false;
		}
		public function goOn():void {
			isPause = false;
		}
		public function pause():void {
			isPause = true;
		}
		//to update moneyText
		public function get money():Number 
		{
			return _money;
		}
		public function set money(value:Number):void 
		{
			_money = value;
			updateMoneyText();
		}
		public function get life():Number 
		{
			return _life;
		}
		public function set life(value:Number):void 
		{
			_life = value;
			updateLifeText();
		}
		private function updateMoneyText():void {
			moneyText.text = "money : " + money.toString();
		}
		private function updateLifeText():void {
			lifeText.text = "life : " + life.toString();
		}
		//
	}

}