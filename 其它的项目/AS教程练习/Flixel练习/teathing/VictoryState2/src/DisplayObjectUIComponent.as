package
{
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	
	public class DisplayObjectUIComponent extends UIComponent
	{
		public function DisplayObjectUIComponent(sprite:DisplayObject)
		{
		    super ();
		
		    explicitHeight = sprite.height;
		    explicitWidth = sprite.width;
		
		    addChild (sprite);
		}
	}
}