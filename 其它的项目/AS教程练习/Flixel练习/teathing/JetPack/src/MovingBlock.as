package
{
	import org.flixel.*;
	
	public class MovingBlock extends FlxBlock
	{
		protected static const SNAP_TO_DISTANCE:Number = 0.5;
		
		protected var verticalMovementDirection:int;
		protected var horizontalMovementDirection:int;
		protected var maxVerticalMovement:Number;
		protected var maxHorizontalMovement:Number;
		protected var verticalMovementSpeed:Number;
		protected var horizontalMovementSpeed:Number;
		protected var startY:Number;
		protected var startX:Number;
		
		public function MovingBlock(maxVerticalMovement:Number, verticalMovementSpeed:Number, maxHorizontalMovement:Number, horizontalMovementSpeed:Number, X:int, Y:int, Width:uint, Height:uint, TileGraphic:Class, Empties:uint=0)
		{
			super(X, Y, Width, Height, TileGraphic, Empties);
			this.verticalMovementDirection = -1;
			this.horizontalMovementDirection = 1;
			this.maxVerticalMovement = maxVerticalMovement;
			this.maxHorizontalMovement = maxHorizontalMovement;
			this.verticalMovementSpeed = verticalMovementSpeed;
			this.horizontalMovementSpeed = horizontalMovementSpeed;
			this.startY = this.y;
			this.startX = this.x;
		}
		
		public override function update():void
		{
			super.update();
			
			this.y += verticalMovementDirection * verticalMovementSpeed * FlxG.elapsed;
			this.x += horizontalMovementDirection * horizontalMovementSpeed * FlxG.elapsed;
			
			if (this.x - this.startX >= this.maxHorizontalMovement)
			{
				this.x = this.startX + this.maxHorizontalMovement;
				horizontalMovementDirection = -1;
			}
			else if (this.x <= this.startX)
			{
				this.x = this.startX;
				horizontalMovementDirection = 1;
			}
			
			if (this.startY - this.y >= this.maxVerticalMovement)
			{
				this.y = this.startY - this.maxVerticalMovement;
				verticalMovementDirection = 1;
			}
			else if (this.startY <= this.y)
			{
				this.y = this.startY;
				verticalMovementDirection = -1;
			}
		}
		
		override public function collide(Core:FlxCore):void
		{			
			//Basic overlap check
			if( (Core.x + Core.width <= this.x) ||
				(Core.x >= this.x + this.width) ||
				(Core.y >= this.y + this.height) ||
				(Core.y + Core.height + SNAP_TO_DISTANCE <= this.y))
				return;
				
			// check to see from what direction we moved into the block
			var contactFromLeft:Boolean = Core.x + Core.width > this.x && 
				Core.last.x + Core.width <= this.last.x;				
			var contactFromRight:Boolean = Core.x < this.x + this.width &&
				Core.last.x >= this.last.x + this.width;				
			var contactFromBottom:Boolean = Core.y < this.y + this.height && 
				Core.last.y >= this.last.y + this.height;
			var contactFromTop:Boolean = Core.y + Core.height + SNAP_TO_DISTANCE > this.y &&
				Core.last.y + Core.height <= this.last.y;
			
			if (contactFromLeft || contactFromRight)
			{
				if (Core.hitWall(this))
				{
					if (contactFromLeft)
						Core.x = this.x - Core.width;
					else
						Core.x = this.x + this.width;
					
					Core.last.x = Core.x;
				}
			}
			
			if (contactFromBottom)
			{
				if (Core.hitFloor(this))
				{
					Core.y = this.y + this.height;
					Core.last.y = Core.y;
				}
			}
			
			if (contactFromTop)
			{
				if (Core.hitCeiling(this))
				{
					Core.y = this.y - Core.height;
					Core.last.y = Core.y;
					Core.x += this.x - this.last.x;
				}	
			}
		}
	}
}