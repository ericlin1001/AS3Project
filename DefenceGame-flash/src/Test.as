package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Test extends Sprite 
	{
		private var enemy:Enemy;
		public function Test() 
		{
			super();
			addChild(new mc1());
			/*addEventListener(Event.ENTER_FRAME, update);
			enemy = new Enemy();
			addChild (enemy);
			var pathX:Array  =new Array (0, 1, 1, 4, 4, 8, 8, 9, 9, 12, 12, 15);
			var pathY:Array  = new Array (2, 2, 6, 6, 2, 2, 4, 4, 7,  7,  1,  1);
			var pathSX:Array  = new Array ();
			var pathSY :Array = new Array ();
			var mapSize:Number = 30;
			for (var i:int = 0; i < pathX.length; i++) 
			{
				//calculate the exact position for enemy
				pathSX[i] = 50 + mapSize * 0.5 + pathX[i] * mapSize;
				pathSY[i] = 50 + mapSize * 0.5 + pathY[i] * mapSize;
			}
			
			enemy.pathSX = pathSX;
			enemy.pathSY = pathSY;
			enemy.speed = 3.6;
			enemy.start();*/
			testInt(int, 20.5);
			var  label:TextField = new TextField;

            label.autoSize = TextFieldAutoSize.LEFT;
            label.background = true;
            label.border = true;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFF0000;
            format.size = 10;
            format.underline = true;

            label.defaultTextFormat = format;
            addChild(label);
			label.text = "adfasdfasdfasdf";
			label.x = 50;
			label.y = 100;

		}
		public function testInt(type:Class, num:Number):void {
			var i:* = new type(num);
			trace(i);
		}
		private function update(e:Event):void {
			enemy.update();
		}
		
	}

}