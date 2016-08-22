/**/import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

stage.scaleMode =StageScaleMode.NO_SCALE
stage.align = StageAlign.TOP_LEFT;
//

var game:CanChooseGameTwo = new CanChooseGameTwo();//19*13 size:30=570*390
addChild(game);
var selectedTankType:int = -1;
var maps:Array;
//
const maxlevel:int = 30;//>=2
var enemyNum:int = 10;
const addEvery:int = 3;
const life:int = 20;
var addEnemyTimer:Timer = new Timer(23000,maxlevel-1);
addEnemyTimer.addEventListener(TimerEvent.TIMER, onTick);
addEnemyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, addEnemyComplete);
const enemySpeedMulti:Number = 1.08;
const enemyGainMoneyMulti:Number = 1.1;
const enemyTotalHpMulti:Number = 1.1;
//
const upgradeMulti:Number=1.3
var sp:Number = 1;
var ga:Number = 1;
var to:Number = 1;
upgrade_btn.visible = false;
var selectedUpgradedTank:Tank;
upgrade_btn.addEventListener(MouseEvent.CLICK, upgradeBtnClick);
function upgradeBtnClick(e:MouseEvent):void {
	upgradeTank(selectedUpgradedTank);
}
function upgradeTank(tank:Tank):void {
	var cost:Number = tank.cost;
	tank.level += 1;
	tank.cost = cost*upgradeMulti;
	if (tank.cost <= game.money) {
		tank.range += 20;
		tank.power *= 1.2;
		tank.bulletSpeed *= 1.06;
		tank.rechargeRate += 0.006;
		tank.maxNumBullets += 1;
		showError("Upgrade succeed.")
		game.money -= tank.cost;
	}else {
		tank.level -= 1;
		showError("You don't have enough money to upgrade.")
	}
	upgrade_btn.visible = false;
}
controlPanel_mc.addEventListener(MouseEvent.CLICK, controlPanelClick);
function controlPanelClick(e:MouseEvent):void {
	resetAll();
	upgrade_btn.visible = false;
		resetInfo_txt();
}
function getTankConfig(type:int):Object {
	var ob:Object = new Object();
	switch(type) {
		case 1:
		ob.cost = 10;
		ob.maxNumBullets = 3;
		ob.power = 7;
		ob.bulletSpeed =5;
		ob.rechargeRate = 0.1;
		ob.range = 50;
		ob.paoTon = new TankOnePaoTon() as MovieClip;
		ob.tankSetter = new TankOneSetter() as MovieClip;
		ob.bulletSample = new Bullet(new BulletOnePic(),BulletOnePic);
		break;
		case 2:
		ob.cost = 30;
		ob.maxNumBullets = 3;
		ob.power = 25;
		ob.bulletSpeed =3.5;
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
function getEnemyConfig(type:int):Object {
	var ob:Object = new Object();
	switch(type) {
		case 1:
		//type:1
		ob.gainMoney = 1;
		ob.speed = 1.5;//1.5;
		ob.totalHp = 100;
		ob.power = 1;
		ob.itshapeType = EnemyOnePic;
		break;
		case 2:
		//type:2
		ob.gainMoney = 2;
		ob.speed = 2.5; 
		ob.totalHp = 100;
		ob.power = 2;
		ob.itshapeType= EnemyTwoPic;
		break;
		case 3:
		//type:3
		ob.gainMoney = 5;
		ob.speed = 3.5; 
		ob.totalHp = 100;
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
function onTick(e:TimerEvent):void {
	var type:int = getRange(1, 3);
	var eConfig:Object = getEnemyConfig(type);
	//
	sp *= enemySpeedMulti;
	ga *= enemyGainMoneyMulti;
	to *= enemyTotalHpMulti;
	eConfig.gainMoney *= ga;
	eConfig.speed *= sp;
	trace("eConfig.speed=" + eConfig.speed);
	eConfig.totalHp *= to;
	//
	game.addTypedEnemies(eConfig, enemyNum, 40);
	enemyNum += addEvery;
	game.level += 1;
}
function addEnemyComplete(e:TimerEvent):void {
	showWin();
}
function pause():void {
	game.pause();
	addEnemyTimer.stop();
}
function showLose():void {
	pause();
	removeChild(game);
	this.gotoAndStop("lose");
}
function showWin():void {
	pause();
	removeChild(game);
	this.gotoAndStop("win");
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
	game.life = life;//20;
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
	addChild(new Signature(stage.stageWidth,stage.stageHeight));
}

//
function gameClick(event:MouseEvent):void {
	var tp:Point = new Point(game.mouseX, game.mouseY);
	tp = game.screenToMap(tp);
	//
	//showError("you has not enough money.")
	var tankConfig:Object = getTankConfig(selectedTankType);
	if (tankConfig == null) {
		//showError("no this type Tank!");
		//return;
	}else if (game.money < tankConfig.cost) {
		showError("you has not enough money.")
	}else {
		if (maps[tp.y][tp.x] == 1) {
		//maps[][]==1 means it can be put a tank
		maps[tp.y][tp.x] = -1;
		trace("maps[tp.y][tp.x] =" + maps[tp.y][tp.x]);
		var tank:Tank=game.addTheTank(setTankConfig(new Tank(), tankConfig), game.mapToScreen(tp));
		//game.setPos(setTankConfig(game.addTank(Tank), tankConfig), game.mapToScreen(tp));
		//tank.rollOver = tankRollOver;
		tank.isChosen = chooseTank;
		tank.start();
	
		}else  if (maps[tp.y][tp.x] == -1) {
			showError("You choose this tank.");
		}else  {
			showError("there can not be put a tank.");
		}
	}

	if (maps[tp.y][tp.x] != -1) {
		upgrade_btn.visible = false;
		resetInfo_txt();
	}
	resetAll();
}
//
function resetAll():void {
	selectedTankType = -1;
	resetTank_mc();
	
}
function setTankConfig(t:Tank, ob:Object):Tank {
	trace("setTankConfig")
	for (var i:String in ob) {
		t[i] = ob[i];
		//trace("in Tank: "+i+"="+t[i]);
	}
	return t;
}

function tankShowInfo(tank:Tank):void {
	info_txt.text = "";
	info_txt.appendText("Level: " + tank.level + "\n");
	info_txt.appendText("upgrade need $: " + int(tank.cost*upgradeMulti)+"\n");
	info_txt.appendText("$: " + int(tank.cost)+"\n");
	info_txt.appendText("range: " + int(tank.range)+"\n");
	//
	info_txt.appendText("power: " + tank.power+"\n");
	info_txt.appendText("bulletSpeed: " + tank.bulletSpeed+"\n");
	info_txt.appendText("rechargeRate: " + tank.rechargeRate+"\n");
	info_txt.appendText("maxNumBullets: " + tank.maxNumBullets+"\n");
}
function chooseTank(tank:Tank):void {

	trace("show upgrade panel.");
	tankShowInfo(tank);
	upgrade_btn.visible = true;
	selectedUpgradedTank = tank;
}

function updateData():void {
	money_txt.text = "money : " + int(game.money);
	life_txt.text = "life : " + int(game.life);
	level_txt.text = "level : " + int(game.level);
	trace("updateData");
	if (game.life <= 0) {
		game.pause();
		addEnemyTimer.stop();
		showLose();
	}
}/**/
function resetTank_mc():void {
	tankOneBtn.gotoAndStop("normal");
	tankTwoBtn.gotoAndStop("normal");
}
function showError(str:String):void {
	error_txt.text = str;
	var timer:Timer = new Timer(2000, 1);
	timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
	timer.start();
}
//
function tankOneBtnRollOver(e:MouseEvent):void {
	if (tankOneBtn.currentLabel != "isChosen") {
		tankOneBtn.gotoAndStop("rollOver");
	}
	showInfoTank(1)
}
function tankOneBtnRollOut(e:MouseEvent):void {
	trace(tankOneBtn.currentLabel);
	if (tankOneBtn.currentLabel != "isChosen") {
		tankOneBtn.gotoAndStop("normal");
	}
	
}

function tankOneBtnClick(e:MouseEvent):void {
	resetTank_mc();
	tankOneBtn.gotoAndStop("isChosen");
	selectedTankType = 1;
}

function timerComplete(e:TimerEvent):void {
	error_txt.text = "";
}
tankOneBtn.addEventListener(MouseEvent.ROLL_OVER, tankOneBtnRollOver);
tankOneBtn.addEventListener(MouseEvent.ROLL_OUT, tankOneBtnRollOut);
tankOneBtn.addEventListener(MouseEvent.CLICK, tankOneBtnClick);
function showInfoTank(type:int):void {
	info_txt.text = "";
	var config:Object = getTankConfig(type);
	info_txt.appendText("Tank"+type+":\n");
	info_txt.appendText("$: " + config.cost+"\n");
	info_txt.appendText("range: " + config.range+"\n");
	//
	info_txt.appendText("power: " + config.power+"\n");
	info_txt.appendText("bulletSpeed: " + config.bulletSpeed+"\n");
	info_txt.appendText("rechargeRate: " + config.rechargeRate+"\n");
	info_txt.appendText("maxNumBullets: " + config.maxNumBullets+"\n");
}
//
function tankTwoBtnRollOver(e:MouseEvent):void {
	if (tankTwoBtn.currentLabel != "isChosen") {
		tankTwoBtn.gotoAndStop("rollOver");
	}
	showInfoTank(2)
}
function tankTwoBtnRollOut(e:MouseEvent):void {
	trace(tankTwoBtn.currentLabel);
	if (tankTwoBtn.currentLabel != "isChosen") {
		tankTwoBtn.gotoAndStop("normal");
	}
	
}
function tankTwoBtnClick(e:MouseEvent):void {
	resetTank_mc();
	tankTwoBtn.gotoAndStop("isChosen");
	selectedTankType = 2;
	showInfoTank(2)
}
function resetInfo_txt():void {
	info_txt.text = "";
}

tankTwoBtn.addEventListener(MouseEvent.ROLL_OVER, tankTwoBtnRollOver);
tankTwoBtn.addEventListener(MouseEvent.ROLL_OUT, tankTwoBtnRollOut);
tankTwoBtn.addEventListener(MouseEvent.CLICK, tankTwoBtnClick);

//
game.addEventListener(Event.COMPLETE, gameLoaded);
game.addEventListener(MouseEvent.CLICK, gameClick);