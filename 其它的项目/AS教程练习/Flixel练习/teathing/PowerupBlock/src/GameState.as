package
{
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		protected static const RANDOM_BLOCK_MIN_DIMENSION:uint = 2;
		protected static const RANDOM_BLOCK_MAX_DIMENSION:uint = 6;
		protected static const LEVEL_DIMENSIONS:uint = 640;
		protected static const BLOCK_DIMENSIONS:uint = 8;
		protected static const NUMBER_RANDOM_BLOCKS:uint = 150;
		protected static const MAXIMUM_RANDOM_PLACEMENT_ATTEMPTS:uint = 5;
		protected static const COINS_COUNT:uint = 10;
		
		[Embed(source="../media/tech_tiles.png")] 
		protected var TechTilesImage:Class;
		
		[Embed(source="../media/powerupblock.png")] 
		protected var PowerupBlockImage:Class;
		
		[Embed(source="../media/mode.mp3")] 
		protected var MusicMode:Class;
		
		[Embed(source="../media/pickup.mp3")]
		protected var PickupSFX:Class;
		
		[Embed(source="../media/coin.png")]
		protected var CoinsImage:Class;
		
		protected var levelBlocks:FlxArray = new FlxArray();
		protected var movingBlocks:FlxArray = new FlxArray();
		protected var powerupBlocks:FlxArray = new FlxArray();
		protected var player:Player = null;
		protected var playerBullets:FlxArray = new FlxArray();
		protected var coins:FlxArray = new FlxArray();
		protected var finished:Boolean = false;
		protected var coinCount:uint = 0;
		protected var coinCountText:FlxText = null;
		
		public function GameState()
		{
			levelBlocks.add(
				this.add(
					new FlxBlock(
						0,
						LEVEL_DIMENSIONS-BLOCK_DIMENSIONS,
						LEVEL_DIMENSIONS,BLOCK_DIMENSIONS,
						TechTilesImage
					)
				)
			);
			levelBlocks.add(
				this.add(
					new FlxBlock(
						0,
						0,
						LEVEL_DIMENSIONS,
						BLOCK_DIMENSIONS,
						TechTilesImage
					)
				)
			);
			levelBlocks.add(
				this.add(
					new FlxBlock(
						0,
						BLOCK_DIMENSIONS,
						BLOCK_DIMENSIONS,
						LEVEL_DIMENSIONS-BLOCK_DIMENSIONS*2,
						TechTilesImage
					)
				)
			);
			levelBlocks.add(
				this.add(
					new FlxBlock(
						LEVEL_DIMENSIONS-BLOCK_DIMENSIONS,
						BLOCK_DIMENSIONS,
						BLOCK_DIMENSIONS,
						LEVEL_DIMENSIONS-BLOCK_DIMENSIONS*2,
						TechTilesImage
					)
				)
			);
			
			powerupBlocks.add(
				this.add(
					new PowerupBlock(
						dropCoin,
						LEVEL_DIMENSIONS>>1,
						LEVEL_DIMENSIONS - BLOCK_DIMENSIONS * 4,
						BLOCK_DIMENSIONS,
						BLOCK_DIMENSIONS,
						PowerupBlockImage
					)
				)
			);
			
			for (var i:uint = 0; i < 8; ++i)
				playerBullets.add(this.add(new Bullet()));
			
			player = new Player(playerBullets);
			this.add(player);
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(0.5, 0.0);
			FlxG.followBounds(0, 0, LEVEL_DIMENSIONS, LEVEL_DIMENSIONS);
			
			FlxG.setMusic(MusicMode);	
			
			coinCountText = new FlxText(10, 10, FlxG.width, 40, "0", 0xFFFFFFFF, null, 16, "center");
			coinCountText.scrollFactor.x = coinCountText.scrollFactor.y = 0;
			this.add(coinCountText);
		}
		
		protected function dropCoin(block:FlxBlock):void
		{
			coins.add(
				this.add(new Coin(CoinsImage, block.x, block.y)));
		}
		
		protected function addCoins():void
		{
			var objectCount:uint = 0;
			
			for each (var block1:FlxBlock in this.levelBlocks)
			{
				var objectStartX:Number = block1.x;
				var objectStartY:Number = block1.y;
				var collides:Boolean = false;
				
				for each (var block2:FlxBlock in this.levelBlocks)
				{					
					var xCollision:int = objectStartX + (BLOCK_DIMENSIONS>>1);
					var xCollision2:int = xCollision + BLOCK_DIMENSIONS;
					var yCollision:int = objectStartY - (BLOCK_DIMENSIONS>>1);
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
				
				if (!collides && objectStartX > 0 && objectStartY > 0)
				{
					coins.add(this.add(new Coin(CoinsImage, objectStartX, objectStartY)));
					++objectCount;
				}
				
				if (objectCount >= COINS_COUNT)
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
			
			FlxG.collideArray(movingBlocks, player);
			FlxG.collideArray(powerupBlocks, player);			
			FlxG.collideArray(levelBlocks, player);
			FlxG.collideArrays(playerBullets, levelBlocks);
			FlxG.collideArrays(playerBullets, powerupBlocks);		
			
			FlxG.collideArrays(movingBlocks, coins);		
			FlxG.collideArrays(levelBlocks, coins);		
			
			FlxG.overlapArray(coins, player, coinPickup);
			
			FlxG.overlapArray(movingBlocks, player, playerSquash);
			FlxG.overlapArray(levelBlocks, player, playerSquash);				
		}
		
		protected function coinPickup(Collide1:FlxCore, Collide2:FlxCore):void
		{
			++coinCount;
			coinCountText.setText(coinCount.toString());
			Collide1.exists = false;
			FlxG.play(PickupSFX);			
		}
		
		protected function playerSquash(Collide1:FlxCore, Collide2:FlxCore):void
		{
			player.kill();
		}
		
		protected function bulletHitEnemy(Bullet:FlxSprite,Bot:FlxSprite):void
		{
			Bullet.hurt(0);
			Bot.hurt(1);
		}

	}
}