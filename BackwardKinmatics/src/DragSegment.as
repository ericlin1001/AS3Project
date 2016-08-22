package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Eric
	 */
	public class DragSegment extends Sprite
	{
		private var segs:Array ;
		private var _numSeg:Number = 10;
		public function DragSegment() 
		{
			segs = new Array();
			for (var i:int = 0; i < _numSeg; i++) 
			{
				var item:Segment = new Segment(50, 15);
				addChild (item);
				segs.push (item);
			}
			if(stage!=null){
			stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
			}else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
		}
		private function draw(seg:Segment, pos:Point):void {
			var angle:Number = Math.atan(pos.y - seg.pin.y, pos.x - seg.pin.x);
			seg.rotation = angle * 180 / Math.PI;
			seg.position = pos;
		}
		private function move(e:MouseEvent):void {
			draw(segs[0],new Point(this.mouseX, this.mouseY));
			for (var j:int = 0; j <segs.length-1; j++) 
			{
			//	draw(segs[j+1],segs[j].pin)
			}
		}
		
	}

}