package  
{
	import baidu.map.basetype.Size;
	import baidu.map.config.Anchor;
	import baidu.map.control.Control;
	import baidu.map.core.IMap;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class MyControl extends Control
	{
		
		public function MyControl(map:IMap) 
		{
			super(map);
			offset = new Size(50, 0);
			anchor = Anchor.TR;
			
		}
		override public function dispose():void 
		{
			super.dispose();
		}
		override protected function create(evt:Event = null):void 
		{
			super.create(evt);
		}
		override protected function destroy(evt:Event = null):void 
		{
			super.destroy(evt);
		}
		
	}
	
}