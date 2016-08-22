package
{
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		[Embed(source="../media/tech_tiles.png")] 
		protected var TechTilesImage:Class;
		
		protected var levelBlocks:FlxArray = new FlxArray();
		protected var player:Player = null;
		protected var playerBullets:FlxArray = new FlxArray();
		
		public function GameState()
		{
			levelBlocks.add(this.add(new FlxBlock(0,640-24,640,8,TechTilesImage)));
			
			for (var i:uint = 0; i < 8; ++i)
				playerBullets.add(this.add(new Bullet()));
			
			player = new Player(playerBullets);
			this.add(player);
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
			FlxG.followBounds(0,0,640,640);
		}
		
		public override function update():void
		{
			super.update();
			FlxG.collideArray(levelBlocks, player);
			FlxG.collideArrays(playerBullets, levelBlocks);
		}

	}
}