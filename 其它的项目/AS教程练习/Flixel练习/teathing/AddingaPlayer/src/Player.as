package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source="../media/spaceman.png")] 
		protected var PlayerImage:Class;
		
		protected static const PLAYER_START_X:int = 300;
		protected static const PLAYER_START_Y:int = 300;
		protected static const PLAYER_RUN_SPEED:int = 80;
		protected static const GRAVITY_ACCELERATION:Number = 420;
		protected static const JUMP_ACCELERATION:Number = 200;
		
		public function Player()
		{
			super(PlayerImage, PLAYER_START_X, PLAYER_START_Y, true, true);
			
			drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 0], 12);
			addAnimation("jump", [4]);
			addAnimation("idle_up", [5]);
			addAnimation("run_up", [6, 7, 8, 5], 12);
			addAnimation("jump_up", [9]);
			addAnimation("jump_down", [10]);
		}
		
		public override function update():void
		{
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x = -drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x = drag.x;
			}
			if(FlxG.keys.justPressed("X") && !velocity.y)
			{
				velocity.y = -JUMP_ACCELERATION;
			}
			
			if(velocity.y != 0)
			{
				play("jump");
			}
			else if(velocity.x == 0)
			{
				play("idle");
			}
			else
			{
				play("run");
			}
			
			super.update();
		}

	}
}
