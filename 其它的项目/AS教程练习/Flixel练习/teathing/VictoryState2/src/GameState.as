package
{
	import mx.effects.easing.Back;
	
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		protected static const RANDOM_BLOCK_MIN_DIMENSION:uint = 2;
		protected static const RANDOM_BLOCK_MAX_DIMENSION:uint = 6;
		protected static const LEVEL_DIMENSIONS:uint = 640;
		protected static const BLOCK_DIMENSIONS:uint = 8;
		protected static const NUMBER_RANDOM_BLOCKS:uint = 150;
		protected static const MAXIMUM_RANDOM_PLACEMENT_ATTEMPTS:uint = 5;
		protected static const ENEMY_COUNT:uint = 10;
		
		[Embed(source="../media/tech_tiles.png")] 
		protected var TechTilesImage:Class;
		
		[Embed(source="../media/mode.mp3")] 
		protected var MusicMode:Class;
		
		protected var levelBlocks:FlxArray = new FlxArray();
		protected var player:Player = null;
		protected var playerBullets:FlxArray = new FlxArray();
		protected var enemies:FlxArray = new FlxArray();
		protected var finished:Boolean = false;
		
		public function GameState()
		{
			levelBlocks.add(this.add(new FlxBlock(0,LEVEL_DIMENSIONS-BLOCK_DIMENSIONS,LEVEL_DIMENSIONS,BLOCK_DIMENSIONS,TechTilesImage)));
			levelBlocks.add(this.add(new FlxBlock(0,0,LEVEL_DIMENSIONS,BLOCK_DIMENSIONS,TechTilesImage)));
			levelBlocks.add(this.add(new FlxBlock(0,BLOCK_DIMENSIONS,BLOCK_DIMENSIONS,640-BLOCK_DIMENSIONS*2,TechTilesImage)));
			levelBlocks.add(this.add(new FlxBlock(LEVEL_DIMENSIONS-BLOCK_DIMENSIONS,BLOCK_DIMENSIONS,BLOCK_DIMENSIONS,640-BLOCK_DIMENSIONS*2,TechTilesImage)));
			
			for (var j:uint = 0; j < NUMBER_RANDOM_BLOCKS; ++j)
				addRandomBlocks();
				
			addEnemies();
			
			for (var i:uint = 0; i < 8; ++i)
				playerBullets.add(this.add(new Bullet()));
			
			player = new Player(playerBullets);
			this.add(player);
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(0.5, 0.0);
			FlxG.followBounds(0, 0, LEVEL_DIMENSIONS, LEVEL_DIMENSIONS);
			
			FlxG.setMusic(MusicMode);	
		}
		
		protected function addEnemies():void
		{
			var enemyCount:uint = 0;
			
			for each (var block1:FlxBlock in this.levelBlocks)
			{
				var enemyStartX:Number = block1.x;
				var enemyStartY:Number = block1.y;
				var collides:Boolean = false;
				
				for each (var block2:FlxBlock in this.levelBlocks)
				{					
					var xCollision:int = enemyStartX + (BLOCK_DIMENSIONS>>1);
					var xCollision2:int = xCollision + BLOCK_DIMENSIONS;
					var yCollision:int = enemyStartY - (BLOCK_DIMENSIONS>>1);
					var yCollision2:int = yCollision - BLOCK_DIMENSIONS;
					
					if (block1 !== block2 && 
						(block2.overlapsPoint(xCollision, yCollision) ||
						block2.overlapsPoint(xCollision, yCollision2) ||
						block2.overlapsPoint(xCollision2, yCollision) ||
						block2.overlapsPoint(xCollision2, yCollision2)))
					{
						collides = true;
						break;
					}			
				}
				
				if (!collides && enemyStartX > 0 && enemyStartY > 0)
				{
					enemies.add(this.add(new Enemy(enemyStartX, enemyStartY, block1.width)));
					++enemyCount;
				}
				
				if (enemyCount >= ENEMY_COUNT)
					break;
			}
		}
		
		protected function addRandomBlocks():void
		{
			var blockWidth:uint = 0;
			var blockHeight:uint = 0;
			var blockX:uint = 0;
			var blockY:uint = 0;
			var collisionWithExistingBlocks:Boolean = false;
			var newRandomBlock:FlxBlock = null;
			var loopCount:uint = 0;
			
			do
			{
				collisionWithExistingBlocks = false;
				
				blockWidth = RANDOM_BLOCK_MIN_DIMENSION + int(FlxG.random() * (RANDOM_BLOCK_MAX_DIMENSION - RANDOM_BLOCK_MIN_DIMENSION));
				blockHeight = RANDOM_BLOCK_MIN_DIMENSION + int(FlxG.random() * (RANDOM_BLOCK_MAX_DIMENSION - RANDOM_BLOCK_MIN_DIMENSION));
				blockX = int(FlxG.random() * LEVEL_DIMENSIONS / BLOCK_DIMENSIONS - RANDOM_BLOCK_MAX_DIMENSION) * BLOCK_DIMENSIONS;
				blockY = int(FlxG.random() * LEVEL_DIMENSIONS / BLOCK_DIMENSIONS - RANDOM_BLOCK_MAX_DIMENSION) * BLOCK_DIMENSIONS;
				
				newRandomBlock = new FlxBlock(
					blockX, 
					blockY, 
					blockWidth * BLOCK_DIMENSIONS, 
					blockHeight * BLOCK_DIMENSIONS, 
					TechTilesImage);
				
				for each (var existingBlock:FlxBlock in levelBlocks)
				{
					collisionWithExistingBlocks = existingBlock.overlaps(newRandomBlock);
					if (collisionWithExistingBlocks) break;
				}
				
				++loopCount;
				
			} while (collisionWithExistingBlocks && loopCount < MAXIMUM_RANDOM_PLACEMENT_ATTEMPTS);
			
			this.levelBlocks.add(this.add(newRandomBlock));
		}
		
		public override function update():void
		{
			super.update();
			
			FlxG.collideArray(levelBlocks, player);
			FlxG.collideArrays(playerBullets, levelBlocks);
			FlxG.collideArrays(enemies, levelBlocks);			
			FlxG.overlapArrays(playerBullets,enemies,bulletHitEnemy);
			
			if (!finished)
			{
				var enemiesStillAlive:Boolean = false;
				for each (var enemy:Enemy in this.enemies)
				{
					if (!enemy.dead)
					{
						enemiesStillAlive = true;
						break;
					}
				}
				
				if (!enemiesStillAlive)
				{
					finished = true;
					FlxG.fade(0xffd8eba2,3,onVictory);
				}
			}
		}
		
		protected function onVictory():void
		{
			FlxG.stopMusic();
			FlxG.switchState(VictoryState);
		}
		
		private function bulletHitEnemy(Bullet:FlxSprite,Bot:FlxSprite):void
		{
			Bullet.hurt(0);
			Bot.hurt(1);
		}

	}
}