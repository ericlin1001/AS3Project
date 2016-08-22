package  
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ErciLin
	 * usage:
	 * 1.override addObjects()//to add other objects
	 * 2.use addEnemy(params...) and addTank(params...) to add this two things.
	 * 3.start() and pause() to start and pause the game.
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
		public var pathSX:Array ;
		public var pathSY:Array ;
		//
		private var enemies:Array;
		private var tanks:Array;
		private var tankContainer:Sprite;
		private var enemyContainer:Sprite;
		public var fieldContainer:Sprite;
		//
		private var _money:Number = 100;
		private var _life:Number = 20;
		//
		public var isCreating:Boolean = false;
		public var isPause:Boolean = true;
		private var tailer:Enemy=new Enemy();
		public function BaseGame(tmapX:Number=50,tmapY:Number=50,tmapSize:Number=30,pathOfMap:String="map.data") 
		{
			super();
			//set vars:
			mapX = tmapX;
			mapY = tmapY;
			mapSize = tmapSize;
			//
			init();
			//load the map
			var loaderMap:LoadMap = new LoadMap();//just to load the map
			loaderMap.addEventListener(Event.COMPLETE, loadedMap);
			try{
			loaderMap.loadMap(pathOfMap);
			}catch (err:IOError)
			{
				trace("IOError" + err);
			}
			//
	
		}
		private function setupField():void {
			//entry point:
			drawField();//draw the map.
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);//to start game's loop
			addObjects();
			dispatchEvent(new Event(Event.COMPLETE));
		}	
		protected function init():void {
			fieldContainer = new Sprite();
			tankContainer = new Sprite();
			enemyContainer = new Sprite();
			addChild(fieldContainer);
			addChild (tankContainer);
			addChild(enemyContainer);
			enemies = new Array ();
			tanks = new Array ();
			_money = 100;
			_life = 20;
		}
		protected function addObjects():void {
			//override this function and to add other objects.
		}
		private function enterFrameHandler(e:Event = null):void {
			if (!isPause) {
				update();
			}
		}
		protected function update(e:Event = null):void {
			//override to add new function
			updateEnemies();
			updateTanks();
		}
		private function loadedMap(e:Event):void {
			//set Vars from the data of the map.txt
			trace("haved loaded the maps in debugMain:"+e.target);
			var loaderMap:LoadMap = e.target as LoadMap;
			maps = loaderMap.maps;
			numRows = maps.length;
			numCols = maps[0].length;
			trace("this map is: " + numCols + "*" + numRows);
			colors = loaderMap.colors[0];
			var tempX:Array  = loaderMap.paths[0];
			var tempY:Array  = loaderMap.paths[1];
			pathSX = new Array ();
			pathSY = new Array ();
			for (var i:int = 0; i < tempX.length; i++) 
			{
				//calculate the exact position for enemy
				pathSX[i] = mapX + mapSize * 0.5 + tempX[i] * mapSize;
				pathSY[i] = mapY + mapSize * 0.5 + tempY[i] * mapSize;
			}
			setupField();//to setup the game;
		}
		private function drawField():void {
			//draw the map in fieldContainer
			var g:Graphics = fieldContainer.graphics;
			g.clear();
			g.lineStyle(0);
			for (var i:int = 0; i < numRows; i++) {
				for (var j:int = 0; j < numCols; j++) 
				{
					var color:uint = colors[int(maps[i][j])];//get the color in this square
					g.beginFill(color);
					g.drawRect(mapX + j * mapSize, mapY + i * mapSize, mapSize, mapSize);
					g.endFill();
				}
			}
			
		}
		//Method:
		final public function addEnemy(enemyType:Class):Enemy {
			//to add one tank to stage
			var enemy:Enemy = new enemyType() as Enemy;
			enemy.size = mapSize;
			enemy.pathSX = pathSX;
			enemy.pathSY = pathSY;
			enemy.x = pathSX[0];
			enemy.y = pathSY[0];
			enemyContainer.addChild(enemy);
			enemies.push (enemy);
			if (!isPause) {
				start();
			}
			return enemy;
		}
		//
		public function addSomeEnemies(enemyType:Class,num:int,delay:Number=40):void {
			for (var i:int = 0; i <num ; i++) {
					var enemy:Enemy = addEnemy(enemyType);
					enemy.x = tailer.x - delay * enemy.speed;
					tailer = enemy;
			}
			tailer = new Enemy();
		}
		public function addTypedEnemies(config:Object,num:int,delay:Number=40):void {
			for (var i:int = 0; i <num ; i++) {
				var enemy:Enemy = addEnemy(Enemy);
				enemy.gainMoney = config.gainMoney;
				enemy.power = config.power;
				enemy.speed = config.speed;
				var t:Class = config.itshapeType as Class;
				enemy.itshape = new t() as MovieClip;
				enemy.x = tailer.x - delay * enemy.speed;
				tailer = enemy;
			}
			tailer = new Enemy();
		}
		final public function addTank(tankType:Class,tx:Number=20,ty:Number=20):Tank {
			//to add one tank to stage
			
			var tank:Tank = new tankType();//tankType() as Tank;
			if (money >= tank.cost) {
				money -= tank.cost;
				tank.size = mapSize;
				tank.x = tx;
				tank.y = ty;
				tankContainer.addChild(tank);
				tanks.push (tank);
			}else {
				tank = null;
			}
			return tank;
		}
		final public function addTheTank(tank:Tank,p:Point):Tank {
			//to add one tank to stage
			if (money >= tank.cost) {
				money -= tank.cost;
				tank.size = mapSize;
				tank.x = p.x;
				tank.y = p.y;
				tankContainer.addChild(tank);
				tanks.push (tank);
			}else {
				tank = null;
			}
			return tank;
		}
		public function addTankToMap(tankType:Class,mx:uint=1, my:uint=1):Tank {
			return addTank(tankType,mapX + mapSize * (0.5+mx), mapY+ mapSize * (my+0.5));
		}
		
		//
		private function updateEnemies():void {
			for (var i:int = 0; i < enemies.length; i++) {
				var item:Enemy = enemies[i] as Enemy;
				if (item!=null){
					if (item.state == Enemy.DEAD) {
						money += item.gainMoney;
						enemyContainer.removeChild(item);
						enemies.splice(i, 1);
					}else if (item.state == Enemy.FINISH_PATH) {
						life-=item.power;
						/*enemyContainer.removeChild(item);
						enemies.splice(i, 1);*/
						//go to the start point.
						item.x = item.pathSX[0];
						item.y = item.pathSY[0];
						item.state = Enemy.NORMAL;
					}else {
						item.update();
					}
				}
			}
		}
		private function updateTanks():void {
			//update all tanks
			for (var j:int = 0; j < tanks.length; j++) {
				var item:Tank = tanks[j] as Tank;
				if(item!=null){
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
		}
		//Ulitity:
		public function setPos(ob:Object, p:Point):Object {
			if (ob == null) return null;
			ob.x = p.x;
			ob.y = p.y;
			return ob;
		}
		public function mapToScreen(p:Point):Point {
			var x:int = Math.max(0, Math.min(numCols - 1, p.x));
			var y:int = Math.max(0, Math.min(numRows - 1, p.y));
			return new Point(mapX + mapSize*0.5 + x * mapSize, mapY+mapSize*0.5 + y * mapSize);
		}
		public function screenToMap(p:Point):Point {
			var x:int = int((p.x - mapX) / mapSize);
			var y:int = int((p.y - mapY) / mapSize);
			 x = Math.max(0, Math.min(numCols - 1, x));
			 y = Math.max(0, Math.min(numRows - 1, y));
			return new Point(x,y);
		}
		//to start and stop the game.
		public function start():void {
			isPause = false;
			for (var i:int = 0; i < enemies.length; i++) 
			{
				var enemy:Enemy = enemies[i] as Enemy;
				if (enemy != null) {
					enemy.start();
				}
			}
			for (var j:int = 0; j < tanks.length; j++) 
			{
				var tank:Tank = tanks[j] as Tank;
				if (tank != null) {
					tank.start();
				}
			}
		}
		public function pause():void {
			isPause = true;
			for (var i:int = 0; i < enemies.length; i++) 
			{
				var enemy:Enemy = enemies[i] as Enemy;
				if (enemy != null) {
					enemy.pause();
				}
			}
			for (var j:int = 0; j < tanks.length; j++) 
			{
				var tank:Tank = tanks[j] as Tank;
				if (tank != null) {
					tank.pause();
				}
			}
		}
		//getter and setter
		public function get money():Number 
		{
			return _money;
		}
		public function set money(value:Number):void 
		{
			_money = value;
		}
		public function get life():Number 
		{
			return _life;
		}
		public function set life(value:Number):void 
		{
			_life = value;
		}
	
		//
	}

}