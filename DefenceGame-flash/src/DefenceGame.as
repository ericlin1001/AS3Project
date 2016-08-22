/*import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
stage.scaleMode =StageScaleMode.NO_SCALE
stage.align = StageAlign.TOP_LEFT;*/
//
var game:CanChooseGameTwo = new CanChooseGameTwo();//19*13 size:30=570*390
addChild(game);
var selectedTankType:int = -1;
var maps:Array;
//
var addEnemyTimer:Timer = new Timer(20000,20);
addEnemyTimer.addEventListener(TimerEvent.TIMER, onTick);
var enemyNum:int = 10;
var addEvery:int = 3;
function onTick(e:TimerEvent):void {
	var type:int = getRange(1, 3);
	game.addTypedEnemies(getEnemyConfig(type), enemyNum, 40);
	enemyNum += addEvery;
	game.level += 1;
}
function getRange(min:int, max:int):int {
	return int(Math.random() * (max - min+1) + min);
}
function gameLoaded(e:Event):void {
	//initialization...
	game.updateData = updateData;
	game.y = 45;
	game.money = 100;
	game.level = 1;
	game.life = 20;//20;
	game.addTypedEnemies(getEnemyConfig(1), enemyNum, 40);
	
	//var tp:Point = new Point(3, 5);
	//tp = game.mapToScreen(tp);
	//var tank:Tank = getTank(0)
	//tank.x = tp.x;
	//tank.y = tp.y;
	//
	maps = game.maps;
	addEnemyTimer.start();
	game.start();
}

//
function gameClick(event:MouseEvent):void {
	var tp:Point = new Point(game.mouseX, game.mouseY);
	tp = game.screenToMap(tp);
	//
	//showError("you has not enough money.")
	var tankConfig:Object = getTankConfig(selectedTankType);
	if (tankConfig == null) {
		showError("no this type Tank!");
		return;
	}
	if (game.money < tankConfig.cost) {
		showError("you has not enough money.")
	}else{
		/**/
		if (maps[tp.y][tp.x] == 1) {
			//maps[][]==1 means it can be put a tank
			maps[tp.y][tp.x] = -1;
			trace("maps[tp.y][tp.x] =" + maps[tp.y][tp.x]);
			var tank:Tank = 
			game.addTheTank(setTankConfig(new Tank(), tankConfig), game.mapToScreen(tp));
			//game.setPos(setTankConfig(game.addTank(Tank), tankConfig), game.mapToScreen(tp));
			tank.start();
		}else  if (maps[tp.y][tp.x] == -1) {
			showError("there has been a tank.");
		}else  {
			showError("there can not be put a tank.");
		}
	}
	selectedTankType = -1;
	resetTank_mc();
	resetInfo_txt();
}
//

function setTankConfig(t:Tank, ob:Object):Tank {
	trace("setTankConfig")
	for (var i:String in ob) {
		t[i] = ob[i];
		//trace("in Tank: "+i+"="+t[i]);
	}
	return t;
}
function getEnemyConfig(type:int):Object {
	var ob:Object = new Object();
	switch(type) {
		case 1:
		//type:1
		ob.gainMoney = 1;
		ob.speed = 1.5;//1.5; 
		ob.power = 1;
		ob.itshapeType = EnemyOnePic;
		
		break;
		case 2:
		//type:2
		ob.gainMoney = 2;
		ob.speed = 2.5; 
		ob.power = 2;
		ob.itshapeType= EnemyTwoPic;
		break;
		case 3:
		//type:3
		ob.gainMoney = 5;
		ob.speed = 3.2; 
		ob.power = 2;
		ob.itshapeType= EnemyThreePic;
		break;
		default:
		trace("Warning  : in getEnemyConfig():", "no this type");
		return null;
		break;
	}
	//trace("ob.cost",ob.cost);
	return ob;
}
function getTankConfig(type:int):Object {
	var ob:Object = new Object();
	switch(type) {
		case 1:
		ob.cost = 10;
		ob.maxNumBullets = 5;
		ob.power = 7;
		ob.bulletSpeed =5;
		ob.rechargeRate = 0.12;
		ob.range = 50;
		ob.paoTon = new TankOnePaoTon() as MovieClip;
		ob.tankSetter = new TankOneSetter() as MovieClip;
		ob.bulletSample = new Bullet(new BulletOnePic(),BulletOnePic);
		break;
		case 2:
		ob.cost = 30;
		ob.maxNumBullets = 5;
		ob.power = 15;
		ob.bulletSpeed =8;
		ob.rechargeRate = 0.07;
		ob.range = 120;
		ob.paoTon = new TankTwoPaoTon() as MovieClip;
		ob.tankSetter = new TankTwoSetter() as MovieClip;
		ob.bulletSample = new Bullet(new BulletTwoPic(),BulletTwoPic);
		break;
		default:
		trace("Warning  : in getTankConfig():", "no this type");
		return null;
		break;
	}
	//trace("ob.cost",ob.cost);
	return ob;
}
function updateData():void {
	money_txt.text = "money : " + game.money.toString();
	life_txt.text = "life : " + game.life.toString();
	level_txt.text = "level : " + game.level.toString();
	trace("updateData");
	if (game.life <= 0) {
		game.pause();
		addEnemyTimer.stop();
		showError("You lose!!!!!!");
		info_txt.text = "You lose!!!!!!";
	}
}/**/
function resetTank_mc():void {
	tankOne_mc.gotoAndStop("normal");
	tankTwo_mc.gotoAndStop("normal");
}
function showError(str:String):void {
	error_txt.text = str;
	var timer:Timer = new Timer(2000, 1);
	timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
	timer.start();
}
//
function tankOne_mcRollOver(e:MouseEvent):void {
	if (tankOne_mc.currentLabel != "isChosen") {
		tankOne_mc.gotoAndStop("rollOver");
	}
	showInfoTank(1)
}
function tankOne_mcRollOut(e:MouseEvent):void {
	trace(tankOne_mc.currentLabel);
	if (tankOne_mc.currentLabel != "isChosen") {
		tankOne_mc.gotoAndStop("normal");
	}
	
}

function tankOne_mcClick(e:MouseEvent):void {
	resetTank_mc();
	tankOne_mc.gotoAndStop("isChosen");
	selectedTankType = 1;
}

function timerComplete(e:TimerEvent):void {
	error_txt.text = "";
}
tankOne_mc.addEventListener(MouseEvent.ROLL_OVER, tankOne_mcRollOver);
tankOne_mc.addEventListener(MouseEvent.ROLL_OUT, tankOne_mcRollOut);
tankOne_mc.addEventListener(MouseEvent.CLICK, tankOne_mcClick);
function showInfoTank(type:int):void {
	info_txt.text = "";
	var config:Object = getTankConfig(type);
	info_txt.appendText("Tank"+type+":\n");
	info_txt.appendText("cost: " + config.cost+"\n");
	info_txt.appendText("range: " + config.range+"\n");
	//
	info_txt.appendText("power: " + config.power+"\n");
	info_txt.appendText("bulletSpeed: " + config.bulletSpeed+"\n");
	info_txt.appendText("rechargeRate: " + config.rechargeRate+"\n");
	info_txt.appendText("maxNumBullets: " + config.maxNumBullets+"\n");
}
//
function tankTwo_mcRollOver(e:MouseEvent):void {
	if (tankTwo_mc.currentLabel != "isChosen") {
		tankTwo_mc.gotoAndStop("rollOver");
	}
	showInfoTank(2)
}
function tankTwo_mcRollOut(e:MouseEvent):void {
	trace(tankTwo_mc.currentLabel);
	if (tankTwo_mc.currentLabel != "isChosen") {
		tankTwo_mc.gotoAndStop("normal");
	}
	
}
function tankTwo_mcClick(e:MouseEvent):void {
	resetTank_mc();
	tankTwo_mc.gotoAndStop("isChosen");
	selectedTankType = 2;
	showInfoTank(2)
}
function resetInfo_txt():void {
	info_txt.text = "";
}

tankTwo_mc.addEventListener(MouseEvent.ROLL_OVER, tankTwo_mcRollOver);
tankTwo_mc.addEventListener(MouseEvent.ROLL_OUT, tankTwo_mcRollOut);
tankTwo_mc.addEventListener(MouseEvent.CLICK, tankTwo_mcClick);

//
game.addEventListener(Event.COMPLETE, gameLoaded);
game.addEventListener(MouseEvent.CLICK, gameClick);