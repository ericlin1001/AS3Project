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
		private var _contact:TouchPoint=null;
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
		
		public function send(type:String, edata:EData = null):void {
			if (contact == null) {
				dispatchEvent(new CircuitEvent(CircuitEvent.ENDPOINT));
				return;
			}
			if (type == CircuitEvent.OUTPUT) {
				U = edata.U;
				I = edata.I;
			}
			contact.receive(type, edata);
		}
		public function receive(type:String, edata:EData=null):void {
			switch(type) {
				case CircuitEvent.OUTPUT:
				U = edata.U;
				I = edata.I;
				dispatchEvent(new CircuitEvent(CircuitEvent.INPUT,edata));
				break;
				case CircuitEvent.FEEDBACK:
				percent = edata.percent;
				dispatchEvent(new CircuitEvent(CircuitEvent.FEEDBACK));
				break;
				case CircuitEvent.BLOCK:
				dispatchEvent(new CircuitEvent(CircuitEvent.BLOCK));
				break;
				case CircuitEvent.ENDPOINT:
				dispatchEvent(new CircuitEvent(CircuitEvent.ENDPOINT));
				break;
				default:
				break;
			}
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