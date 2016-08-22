package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Test extends Sprite
	{
		public function Test() 
		{
			var bitmapData:BitmapData = new BitmapData(100, 100, false, 0xffff00);
			bitmapData.fillRect(new Rectangle(10, 10, 50, 50), 0xff0000);
			bitmapData.setPixel(1, 1, 0xff0000);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			bitmap.x = 200;
			bitmap.y = 200;
			addChild(bitmap);
			var req:URLRequest = new URLRequest("clock.png");
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			//
				
			try {
				loader.load(req);
			}catch (e:Error) {
				trace("Error.!"+e);
			}
			
		}
		private function onLoadComplete(e:Event):void {
			//addChild(new Bitmap(BitmapData(URLLoader(e.currentTarget).data)));
			trace(e.target);
			var loader:URLLoader = e.target as URLLoader;
			//trace(loader.data);
			trace(loader.dataFormat);
			var d:BitmapData = loader.data as BitmapData;
			trace(d);
			//d.fillRect(new Rectangle(10, 10, 10, 10), 0x00ff00);
			var t:Bitmap = new Bitmap(d);
			t.x = 50;
			t.y = 50;
			addChild(t);
			//
			ss:Bitmap = loader.data as Bitmap;
			trace(ss);
			//addChild(ss);
		}
	}
	
}