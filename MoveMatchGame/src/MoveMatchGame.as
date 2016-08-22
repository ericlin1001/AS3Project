package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.engine.GroupElement;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class MoveMatchGame extends Sprite 
	{
		private var piles:Array;
		private var minMatches:int = 20;
		private var maxMatches:int = 50;
		private var numPiles:int = 6;
		private var gameMode:String = "";//
		private var mouseContainer:Sprite;
		private var matchContainer:Sprite;
		
		public function MoveMatchGame() 
		{
			
			mouseContainer = new Sprite();
			matchContainer = new Sprite();
			addChild(matchContainer);
			addChild(mouseContainer);
			
			setupField();
			
		}
		private function setupField():void {
			piles = new Array ();
			for (var i:int = 0; i < numPiles; i++) {
				var matches:Array = new Array ();
				var tx:Number = i % 3;
				var ty:Number = (i - tx) / 3;
				var tr:Number = 45;
				tx = tx * 125 + 75;
				ty = ty * 125 + 75;
				var g:Graphics = matchContainer.graphics;
				g.lineStyle(0);
				g.drawCircle(tx, ty, tr+5);
				var numMatches:int = Math.random() * (maxMatches - minMatches + 1) + minMatches;
				for (var j:int = 0; j < numMatches; j++) 
				{
					var match:Match = new Match();
					matchContainer.addChild(match);
					matches.push (match);
				
					setRandom(match, tx, ty, tr);
					
				}
				piles.push (matches);
				
			}
			
		}
		private function setRandom(s:Sprite, tx:Number, ty:Number, tr:Number):Sprite {
			var angle:Number = 2 * Math.PI * Math.random();
			var seed:Number =   Math.random();
			seed = seed * seed*seed;
			var r:Number = tr*seed;
			s.rotation = 360 * Math.random();
			s.x = tx + r * Math.cos(angle);
			s.y = ty + r * Math.sin(angle);
			return s;
		}
	}

}