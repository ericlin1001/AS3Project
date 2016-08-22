package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	public class Main extends Sprite {
		//
		// arrays to store game field information
		//
		private var plantsArray:Array;// plants placed in the game field
		private var zombiesArray:Array;//zombies placed in the game field
		// 
		// timers
		//
		private var flowersTimer:Timer=new Timer(5000);// timer to make flowers fall down
		private var zombieTimer:Timer=new Timer(5000);// timer to make zombies come in
		//
		// containers
		//
		private var sunContainer:Sprite=new Sprite();// container for all suns
		private var plantContainer:Sprite=new Sprite();// container for all plants
		public var bulletContainer:Sprite=new Sprite();// container for all bullets
		private var zombieContainer:Sprite=new Sprite();// container for all zombies
		private var overlayContainer:Sprite=new Sprite();// container of all overlays
		//
		// actors
		//
		private var movingPlant:plantMc;// plant the player can drag on game field
		private var selector:selectorMc;// the selector square to show the playere where he's going to place the plant
		//
		// other variables
		//
		private var money:uint=0;// amout of money owned by the player
		private var moneyText:TextField=new TextField()  ;// dynamic text field where to show player's money
		private var playerMoving:Boolean=false;// Boolean variable to tell us if the player is moving a plant (true) or not (false)
		private var totalZombies:uint=0;//total amount of zombies placed in game
		public function Main():void {
			setupField();// initializes the game
			drawField();// draws the game field
			fallingSuns();// initializes the falling suns
			addPlants();// initialized the plants
			addZombies();// initializes the zombies
			addEventListener(Event.ENTER_FRAME,onEnterFrm);
		}
		//
		// game field setup. arrays to store plants and zombies information are created
		//
		private function setupField():void {
			plantsArray=new Array();
			zombiesArray=new Array();
			for (var i:uint=0; i<5; i++) {
				plantsArray[i]=new Array();
				zombiesArray[i]=new Array();
				for (var j:uint=0; j<9; j++) {
					plantsArray[i][j]=0;
				}
			}
		}
		//
		// showing the amount of money
		//
		private function updateMoney():void {
			moneyText.text="Money: "+money.toString();
		}
		//
		// game field drawing and children hierarchy management
		//
		private function drawField():void {
			var fieldSprite:Sprite=new Sprite();
			var randomGreen:Number;
			addChild(fieldSprite);
			fieldSprite.graphics.lineStyle(1,0xFFFFFF);
			for (var i:uint=0; i<5; i++) {
				for (var j:uint=0; j<9; j++) {
					randomGreen=(125+Math.floor(Math.random()*50))*256;
					fieldSprite.graphics.beginFill(randomGreen);
					fieldSprite.graphics.drawRect(25+65*j,80+75*i,65,75);
				}
			}
			addChild(sunContainer);
			addChild(plantContainer);
			addChild(bulletContainer);
			addChild(zombieContainer);
			addChild(overlayContainer);
			overlayContainer.addChild(moneyText);
			updateMoney();
			moneyText.textColor=0xFFFFFF;
			moneyText.height=20;
		}
		//
		// zombies initialization
		//
		private function addZombies():void {
			zombieTimer.start();
			zombieTimer.addEventListener(TimerEvent.TIMER,newZombie);
		}
		//
		// adding a new zombie
		//
		private function newZombie(e:TimerEvent):void {
			var zombie:zombieMc=new zombieMc();// constructs the zombie
			totalZombies++;
			zombieContainer.addChild(zombie);// adds the zombie
			zombie.zombieRow=Math.floor(Math.random()*5);// chooses a random row where to place the zombie
			zombie.name="zombie_"+totalZombies;//gives a name to the zombie
			zombiesArray[zombie.zombieRow].push(zombie.name);// adds the zombie in the row-th row
			zombie.x=660;// places the zombie on the board, outside the stage to the right
			zombie.y=zombie.zombieRow*75+115;
		}
		//
		// suns initialization
		//
		private function fallingSuns():void {
			flowersTimer.start();
			flowersTimer.addEventListener(TimerEvent.TIMER, newSun);
		}
		//
		// adding a new sun
		//
		private function newSun(e:TimerEvent):void {
			var sunRow:uint=Math.floor(Math.random()*5);// random row
			var sunCol:uint=Math.floor(Math.random()*9);// random column
			var sun:sunMc = new sunMc();// constructs the sun
			sun.buttonMode=true;// makes the mouse change shape when over the plant
			sunContainer.addChild(sun);// adds the sun
			sun.x=52+sunCol*65;// places the sun in the proper column
			sun.destinationY=130+sunRow*75;// definines the sun y destination point
			sun.y=-20;// places the sun out to the upper side of the stage
			sun.addEventListener(MouseEvent.CLICK,sunClicked);// listener to be triggered when the sun is clicked
		}
		//
		// handling clicks on suns
		//
		private function sunClicked(e:MouseEvent):void {
			e.currentTarget.removeEventListener(MouseEvent.CLICK,sunClicked);// removes the CLICK listener
			money+=5;// makes the player earn money (5)
			updateMoney();// updates money text
			var sunToRemove:sunMc=e.currentTarget as sunMc;// defines which sun we need to remove
			sunContainer.removeChild(sunToRemove);// removes the sun
		}
		//
		// building the plant toolbar (only 1 plant at the moment)
		//
		private function addPlants():void {
			var plant:plantMc=new plantMc();// constructs a new plant
			overlayContainer.addChild(plant);// adds the plant
			plant.buttonMode=true;// makes the mouse change shape when over the plant
			plant.x=90;
			plant.y=40;
			plant.addEventListener(MouseEvent.CLICK,onPlantClicked);// listener to be triggered once the plant is clicked
		}
		//
		// handling clicks on plants
		//
		private function onPlantClicked(e:MouseEvent):void {
			// let's see if the player has enough money (10) to afford the plant and isn't currently dragging a plant
			if (money>=10&&! playerMoving) {
				money-=10;// pays the plant
				updateMoney();// updates money text
				selector=new selectorMc();// constructs a new selector
				selector.visible=false;// makes the selector invisible
				overlayContainer.addChild(selector);// adds the selector
				movingPlant=new plantMc();// constructs a new moving plant
				movingPlant.addEventListener(MouseEvent.CLICK,placePlant);// lister to be triggered once the moving plant is clicked
				overlayContainer.addChild(movingPlant);// adds the moving plant
				playerMoving=true;// tells the script the player is actually moving a plant
			}
		}
		//
		// placing the plant on the game field
		//
		private function placePlant(e:MouseEvent):void {
			var plantRow:int=Math.floor((mouseY-80)/75);
			var plantCol:int=Math.floor((mouseX-25)/65);
			// let's see if the tile is inside the game field and it's free
			if (plantRow>=0&&plantCol>=0&&plantRow<5&&plantCol<9&&plantsArray[plantRow][plantCol]==0) {
				var placedPlant:plantMc=new plantMc();// constructs the plant to be placed
				placedPlant.name="plant_"+plantRow+"_"+plantCol;// gives the plant a name
				placedPlant.fireRate=75;// plant fire rate, in frames
				placedPlant.recharge=0;// plant recharge. When recharge is equal to fireRate, the plant is ready to fire
				placedPlant.isFiring=false;// Boolean value to tell if the plant is firing
				placedPlant.plantRow=plantRow;// plant row
				plantContainer.addChild(placedPlant);// adds the plant
				placedPlant.x=plantCol*65+57;
				placedPlant.y=plantRow*75+115;
				playerMoving=false;// tells the script the player is no longer moving
				movingPlant.removeEventListener(MouseEvent.CLICK,placePlant);// removes the CLICK listener from the draggable plant
				overlayContainer.removeChild(selector);// removes the selector
				overlayContainer.removeChild(movingPlant);// removes the plant itself
				plantsArray[plantRow][plantCol]=1;// updates game array adding the new plant
			}
		}
		//
		// core function to be executed at every frame. The whole game is managed here
		//
		private function onEnterFrm(e:Event):void {
			var i:int;
			var j:int;
			//
			// plants management
			//
			for (i=0; i<plantContainer.numChildren; i++) {
				var currentPlant:plantMc=plantContainer.getChildAt(i) as plantMc;
				// let's see if the plant can fire
				if (currentPlant.recharge==currentPlant.fireRate&&! currentPlant.isFiring) {
					// let's see if there are zombies in the same row of the plant
					if (zombiesArray[currentPlant.plantRow].length>0) {
						// let's scan through all zombies
						for (j=0; j<zombiesArray[currentPlant.plantRow].length>0; j++) {
							var targetZombie:zombieMc=zombieContainer.getChildByName(zombiesArray[currentPlant.plantRow][j]) as zombieMc;// gets the j-th zombie
							// if the zombie is on the right of the plant
							if (targetZombie.x>currentPlant.x) {
								var bullet:bulletMc=new bulletMc();// constructs a new bullet
								bulletContainer.addChild(bullet);// adds the bullet
								bullet.x=currentPlant.x;
								bullet.y=currentPlant.y;
								bullet.sonOf=currentPlant;// sets the bullet as a son of the current plant
								currentPlant.recharge=0;// the plant must recharge 
								currentPlant.isFiring=true;// the plant is firing
								break;// exits the j for loop
							}
						}
					}
				}
				// let's see if the plant has to recharge
				if (currentPlant.recharge<currentPlant.fireRate) {
					currentPlant.recharge++;// recharges the plant
				}
			}
			//
			// bullets management
			//
			for (i=0; i<bulletContainer.numChildren; i++) {
				var movingBullet:bulletMc=bulletContainer.getChildAt(i) as bulletMc;
				movingBullet.x+=3;//moves each bullet right by 3 pixels
				var firingPlant:plantMc=movingBullet.sonOf as plantMc;// finds the plant which shot the bullet
				// let's see if the bullet flew out of the screen
				if (movingBullet.x>650) {
					firingPlant.isFiring=false;// the plant is not longer firing
					bulletContainer.removeChild(movingBullet);// removes the bullet
				} else {
					for (j=0; j<zombieContainer.numChildren; j++) {
						var movingZombie:zombieMc=zombieContainer.getChildAt(j) as zombieMc;
						// let's see if a zombie has been hit by a bullet
						if (movingZombie.hitTestPoint(movingBullet.x,movingBullet.y,true)) {
							movingZombie.alpha-=0.3;// decreases zombie energy (alpha)
							firingPlant.isFiring=false;// the plant is not longer firing
							bulletContainer.removeChild(movingBullet);// removes the bullet
							// let's see if zombie's energy (alpha) reached zero
							if (movingZombie.alpha<0) {
								zombiesArray[movingZombie.zombieRow].splice(zombiesArray[movingZombie.zombieRow].indexOf(movingZombie.name),1);// remove the zombie from the row 
								zombieContainer.removeChild(movingZombie);// removes the zombie
							}
							break;
						}
					}
				}
			}
			//
			// zombies management
			//
			var zombieColumn:int;
			for (i=0; i<zombieContainer.numChildren; i++) {
				movingZombie=zombieContainer.getChildAt(i) as zombieMc;
				zombieColumn = Math.floor((movingZombie.x-25)/65);// gets zombie column
				// let's see if there is a plant in the same tile
				if (zombieColumn<0||zombieColumn>8||plantsArray[movingZombie.zombieRow][zombieColumn]==0) {
					movingZombie.x-=0.5;// moves each zombie left by 1/2 pixels
				} else {
					// the zombie attacks!!
					var attackedPlant:plantMc=plantContainer.getChildByName("plant_"+movingZombie.zombieRow+"_"+zombieColumn) as plantMc;
					attackedPlant.alpha-=0.01;// drains plant energy
					// let's see if the plant died
					if (attackedPlant.alpha<0) {
						plantsArray[movingZombie.zombieRow][zombieColumn]=0;//removes the plant from the array
						plantContainer.removeChild(attackedPlant);//removes the plant Display Object from Display List
					}
				}
			}
			//
			// suns management
			//
			for (i=0; i<sunContainer.numChildren; i++) {
				var fallingSun:sunMc=sunContainer.getChildAt(i) as sunMc;
				// let's see if the sun is still falling because it did not reach its destination
				if (fallingSun.y<fallingSun.destinationY) {
					fallingSun.y++;// moves the sun down by one pixel
				} else {
					fallingSun.alpha-=0.01;// makes the sun fade away
					// let's see if the sun disappeared
					if (fallingSun.alpha<0) {
						fallingSun.removeEventListener(MouseEvent.CLICK,sunClicked);// removes the CLICK listener from the sun
						sunContainer.removeChild(fallingSun);// removes the sun
					}
				}
			}
			//
			// placing plant process
			//
			if (playerMoving) {
				movingPlant.x=mouseX;
				movingPlant.y=mouseY;
				var plantRow:int=Math.floor((mouseY-80)/75);
				var plantCol:int=Math.floor((mouseX-25)/65);
				// let's see if the plant is inside the game field
				if (plantRow>=0&&plantCol>=0&&plantRow<5&&plantCol<9) {
					selector.visible=true;// shows the selector
					selector.x=25+plantCol*65;
					selector.y=80+plantRow*75;
				} else {
					selector.visible=false;// hide the selector
				}
			}
		}
	}
}