package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class TouchPoint extends Sprite 
	{
		public static const IN_TYPE:String = "in";
		public static const OUT_TYPE:String = "out";
		public static const ENDPOINT:String = "endPoint";
		//
		public var U:Number=NaN;//electric potential
		public var I:Number=NaN;//current
		public var percent:Number=NaN;
		public var state:String = EData.NORMAL;
		public var type:String = null;
		//
		private var _contact:TouchPoint = null;
		// 
		public var isEndPoint:Boolean = false;
		public function TouchPoint() 
		{
			draw();
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouveOutHandler);
		}
		private function mouseOverHandler(e:MouseEvent):void {
			graphics.lineStyle(.5, 0xffff00);
			graphics.drawCircle(0, 0, 3.5);
		}
		private function mouveOutHandler(e:MouseEvent):void {
			undraw();
			draw();
			linkTo(contact);
		}
		private function draw():void {
			graphics.lineStyle(1, 0x0000ff);
			graphics.beginFill(0xaa0000, 0.75);
			graphics.drawCircle(0, 0, 2);
			graphics.endFill();
		}
		private function undraw():void {
			graphics.clear();
		}
		public function send(e:CircuitEvent):void {
			if (contact == null) {
				isEndPoint = true;
				trace("in this");
			//	dispatchEvent(new CircuitEvent(CircuitEvent.DATAFLOWING,CircuitEvent.ENDPOINT));
				return;
			}else {
				if (e.state == CircuitEvent.CURRENTFLOWING) {
				U = e.U;
				I = e.I;
				}else if (e.state == CircuitEvent.ENDPOINT) {
					isEndPoint = true;
				}
				contact.receive(e);
			}
		}
		public function receive(e:CircuitEvent):void {
			switch(e.state) {
				case CircuitEvent.CURRENTFLOWING:
				U = e.U;
				I = e.I;
				break;
				case CircuitEvent.ENDPOINT:
				isEndPoint = true;
				break;
				default:
				break;
			}
			dispatchEvent(e);
		}
		public function reset():void {
			undraw();
			draw();
			contact = null;
		}
		public function linkTo(port:TouchPoint):void {
			if (contact != null) {
				contact.reset();
				reset();
			}
			if (port != null && port != this ) {
				contact = port;
				if (contact.contact != this && contact.contact != null) {
					contact.contact.reset();
				}
				contact.contact = this;
				var p:Point = new Point(0,0);
				p=this.globalToLocal(contact.localToGlobal(p));
				graphics.lineStyle(0);
				graphics.moveTo(0, 0);
				graphics.lineTo(p.x, p.y);
			}
		}
		public function get contact():TouchPoint 
		{
			return _contact;
		}
		
		public function set contact(value:TouchPoint):void 
		{
			_contact = value;
		}
	}

}