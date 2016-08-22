package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class GameTest extends Sprite
	{
		private var gameEngine:GameEngine;
		public function GameTest() 
		{
			var canva:Sprite = new Sprite();
			addChild(canva);
			var numRows:int = 30; var numCols:int = 40;
			gameEngine = new GameEngine(canva,numRows,numCols);
			//
			var bk:Sprite = new Sprite();
			var g:Graphics = bk.graphics;
			g.lineStyle(0);
			g.beginFill(0xaaaaaa);
			g.drawRect(0, 0, 600, 450);
			g.endFill();
			//
			gameEngine.addBackGround(bk);
			//
			var map:Map = new Map(numRows, numCols);
			//
			gameEngine.loadMap(map);
			gameEngine.test();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
		}
		private function keyPress(e:KeyboardEvent):void {
			gameEngine.actorRight();
		}
		private function update(e:Event):void {
			gameEngine.update();
		}
		
	}
	
}