package{
	import flash.display.Sprite;
	public class ChildSquare extends Sprite{
		public function ChildSquare(a:Number =20,b:Number=20){
			with(graphics){
				lineStyle(0);
				beginFill(0xff0000);
				drawRect(0,0,a,b);
				endFill();
			}
		}
	}
}