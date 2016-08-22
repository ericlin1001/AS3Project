package
{
	import flash.geom.Point;
	
	import org.flixel.*;

	public class PowerupBlock extends FlxBlock
	{
		protected static const BOUNCE_HEIGHT:Number = 3;
		protected static const BOUNCE_COUNT:int = 5;
		protected static const BOUNCE_TIME:Number = 0.5;
		
		protected var bounceTime:Number = -1;
		protected var dropped:Boolean = false;
		protected var dropFunction:Function = null;
		
		public function PowerupBlock(dropFunction:Function, X:int, Y:int, Width:uint, Height:uint, TileGraphic:Class, Empties:uint=0)
		{
			super(X, Y, Width, Height, TileGraphic, Empties);
			this.dropFunction = dropFunction; 
		}
		
		override public function collide(Core:FlxCore):void
		{			
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
			
			if (contactFromLeft && Core.hitWall(this))
			{
				Core.x = this.x - Core.width;
			}
			
			if (contactFromRight && Core.hitWall(this))
			{
				Core.x = this.x + this.width;	
			}
			
			if (contactFromBottom && Core.hitCeiling(this))
			{
				Core.y = this.y + this.height;
				if (!dropped)
				{
					bounceTime = BOUNCE_TIME;
					dropped = true;
					if (dropFunction != null)
						dropFunction(this);
				}
			}
			
			if (contactFromTop && Core.hitFloor(this) )
			{
				Core.y = this.y - Core.height;
			}
		}
		
		public override function update():void
		{
			super.update();
			if (bounceTime != -1)
			{
				bounceTime -= FlxG.elapsed;
				if (bounceTime <= 0)
				{
					bounceTime = -1;
				}
			}
		}
		
		protected override function getScreenXY(P:Point):void
		{
			super.getScreenXY(P);
			if (bounceTime != -1)
				P.y += Math.sin(bounceTime / BOUNCE_TIME * Math.PI * BOUNCE_COUNT) * BOUNCE_HEIGHT;
		}
	}
}