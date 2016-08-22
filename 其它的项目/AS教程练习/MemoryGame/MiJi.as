package{
	public class MiJi extends Sprite{
		private var typeStrs:Array;
		public function MiJi(typeStr:String,exec:Function){
			typeStrs=typeStr.split("");
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHanndler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
		}
		private function keyDownHanndler(e:KeyboardEvent):void{
		}
		private function keyUpHandler(e:KeyboardEvent):void{
		}
	}
}