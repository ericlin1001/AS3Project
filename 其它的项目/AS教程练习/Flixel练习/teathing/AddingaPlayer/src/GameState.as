package
{
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		[Embed(source="../media/tech_tiles.png")] 
		protected var TechTilesImage:Class;
		
		protected var levelBlocks:FlxArray = new FlxArray();
		protected var player:Player = null;
		
		public function GameState()
		{
			levelBlocks.add(this.add(new FlxBlock(0,640-24,640,8,TechTilesImage)));
			
			player = new Player();
			this.add(player);
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
			FlxG.followBounds(0,0,640,640);
		}
		
		public override function update():void
		{
			super.update();
			FlxG.collideArray(levelBlocks, player);
		}

	}
}