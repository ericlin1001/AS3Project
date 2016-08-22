package
{
	import flash.geom.Point;
	
	import org.flixel.*;
	
	public class BounceBlock extends FlxBlock
	{
		protected static const MIN_REBOUND:Number = 50;
		
		[Embed(source="../media/bounce.mp3")] 
		protected var SndBounce:Class;
		
		public function BounceBlock(X:int,Y:int,Width:uint,Height:uint,TileGraphic:Class,Empties:uint=0)
		{
			super(X, Y, Width, Height, TileGraphic, Empties);
		}
		
		override public function collide(Core:FlxCore):void
		{			
			var sprite:FlxSprite = Core as FlxSprite;
		
			//Basic overlap check
			if( (Core.x + Core.width <= this.x) ||
				(Core.x >= this.x + this.width) ||
				(Core.y >= this.y + this.height) ||
				(Core.y + Core.height <= this.y))
				return;
				
			// check to see from what direction we moved into the block
			var contactFromLeft:Boolean = Core.x + Core.width > this.x && 
				Core.last.x + Core.width <= this.last.x;				
			var contactFromRight:Boolean = Core.x < this.x + this.width &&
				Core.last.x >= this.last.x + this.width;				
			var contactFromBottom:Boolean = Core.y < this.y + this.height && 
				Core.last.y >= this.last.y + this.height;
			var contactFromTop:Boolean = Core.y + Core.height > this.y &&
				Core.last.y + Core.height <= this.last.y;
			
			var coreVelocity:Point = sprite.velocity.clone();
			if (Math.abs(coreVelocity.x) < MIN_REBOUND)
				coreVelocity.x = 0;
			if (Math.abs(coreVelocity.y) < MIN_REBOUND)
				coreVelocity.y = 0;
			
			if (contactFromLeft && Core.hitWall(this))
			{
				if (sprite != null) 
				{
					sprite.velocity.x = -coreVelocity.x;
					if (sprite.velocity.x != 0)
						FlxG.play(SndBounce);
				}
				
				Core.x = this.x - Core.width;
				
			}
			
			if (contactFromRight && Core.hitWall(this))
			{
				if (sprite != null) 
				{
					sprite.velocity.x = -coreVelocity.x;
					if (sprite.velocity.x != 0)
						FlxG.play(SndBounce);
				}
				
				Core.x = this.x + this.width;	
			}
			
			if (contactFromBottom && Core.hitFloor(this))
			{
				if (sprite != null) 
				{
					sprite.velocity.y = -coreVelocity.y;
					if (sprite.velocity.y != 0)
						FlxG.play(SndBounce);
				}
				Core.y = this.y + this.height;
			}
			
			if (contactFromTop && Core.hitCeiling(this))
			{
				if (sprite != null) 
				{
					sprite.velocity.y = -coreVelocity.y;
					if (sprite.velocity.y != 0)
						FlxG.play(SndBounce);
				}
				Core.y = this.y - Core.height;
			}
		}

	}
}