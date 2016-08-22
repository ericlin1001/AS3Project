package
{
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{
		[Embed(source="../media/enemy.png")]
		protected var EnemyImage:Class;
		
		[Embed(source="../media/enemygibs.png")]
		protected var EnemyGibsImage:Class;
		
		[Embed(source="../media/asplode.mp3")] 
		protected var SndExplode:Class;
		
		protected static const ENEMY_SPEED:Number = 20;
		protected static const ENEMY_HEALTH:int = 2;
		
		protected var startingX:int;
		protected var maxHorizontalMovement:int;
		protected var gibs:FlxEmitter;
		
		public function Enemy(X:int, Y:int, maxHorizontalMovement:int)
		{
			super(EnemyImage, X, Y, true);
			
			this.y -= this.height;
			this.startingX = X;
			this.maxHorizontalMovement = maxHorizontalMovement - this.width;
			this.velocity.x = ENEMY_SPEED;
			this.health = ENEMY_HEALTH;
			this.gibs = FlxG.state.add(new FlxEmitter(0,0,0,0,null,-1.5,-150,150,-200,0,-720,720,400,0,EnemyGibsImage,20,true)) as FlxEmitter;
			
			addAnimation("anim", [0, 1], 12);
			this.play("anim");
		}
		
		public override function update():void
		{
			super.update();
			
			if (this.x - this.startingX >= maxHorizontalMovement)
			{
				this.x = this.startingX + maxHorizontalMovement;
				this.velocity.x = -ENEMY_SPEED;
			}
			else if (this.x - this.startingX <= 0)
			{
				this.x = this.startingX;
				this.velocity.x = ENEMY_SPEED;	
			}
		}
		
		public override function hitWall(Contact:FlxCore=null):Boolean
		{
			this.velocity.x = -this.velocity.x;
			return true;
		}
		
		public override function kill():void
		{
			super.kill();
			
			this.gibs.x = this.x + (this.width>>1);
			this.gibs.y = this.y + (this.height>>1);
			this.gibs.restart();
			
			FlxG.play(SndExplode);
		}
		
	}
}