package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Element extends Sprite 
	{
		public static const NORMAL:String = "normal";
		public static const LINKING:String = "linking";
		public static const MOVING:String = "moving";
		public var state:String = NORMAL;
		public var isNormal:Boolean = false;
		//
		public var portIs:Array = new Array();
		public var portOs:Array = new Array();
		//
		public var numPortIs:int = 1;
		public var numPortOs:int = 1;
		//
		protected var size:Number = 50;
		//
		protected var show_txt:TextField = new TextField();
		//
		private var moffsetx:Number;
		private var moffsety:Number;
		//
		protected var moveArea:Sprite = new Sprite();
		protected var drawArea:Sprite=new Sprite()
		public function Element() 
		{
			
			trace("in Element");
			trace("numPortIs:", numPortIs);
			addChild(show_txt);
			show_txt.autoSize = TextFieldAutoSize.CENTER;
			show_txt.selectable = false;
			show_txt.type = TextFieldType.DYNAMIC;
			//
			addChild(drawArea);
			addChild(moveArea);
			var g:Graphics = moveArea.graphics;
			g.beginFill(0xff0000, 0);
			g.drawRect( -size * 0.5, -size * 0.5, size, size);
			g.endFill();
			moveArea.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		public function init():void {
			draw();
			makePortIs();
			makePortOs();
		}
		private function mouseDownHandler(e:MouseEvent):void {
			var mx:Number = mouseX;
			var my:Number = mouseY;
			var t:Number = size * 0.5;
			trace("mouseDown");
			if ( -t < mx && mx < t && -t < my && my < t) {
				moffsetx =  mx;
				moffsety =  my;
				state = MOVING;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
		}
		private function mouseUpHandler(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			state = NORMAL;
		}
		private function mouseMoveHandler(e:MouseEvent):void {
			if (state == MOVING) {
				x += mouseX-moffsetx;
				y += mouseY-moffsety;
			}
		}
		protected function reLinkTo():void {
			var port:TouchPoint
			for (var i:int = 0; i <numPortIs; i++) 
			{
				//in port
				port = portIs[i] as TouchPoint;
				port.linkTo(port.contact);
			}
			for (var j:int = 0; j <numPortOs; j++) 
			{
				//out port
				port = portOs[j] as TouchPoint;
				port.linkTo(port.contact);
			}
		}
		protected function show(mess:String):void {
			show_txt.text = mess;
			show_txt.x = -show_txt.width * 0.5;
			show_txt.y = size * 0.5-show_txt.height;
		}
		protected function resetPorts():void {
			for (var i:int = 0; i <portIs.length; i++) 
			{
				//in port
				var port:TouchPoint = portIs[i];
				removeChild(port);
				port.removeEventListener(CircuitEvent.BLOCK, blockHandler);
				port.removeEventListener(CircuitEvent.ENDPOINT, endPointHandler);
				port.removeEventListener(CircuitEvent.FEEDBACK, feedbackHandler);
				port.removeEventListener(CircuitEvent.INPUT, inputHandler);
			}
					for (var j:int = 0; j<portOs.length; j++) 
			{
				//in port
				var portt:TouchPoint = portOs[j];
				removeChild(portt);
				portt.removeEventListener(CircuitEvent.BLOCK, blockHandler);
				portt.removeEventListener(CircuitEvent.ENDPOINT, endPointHandler);
				portt.removeEventListener(CircuitEvent.FEEDBACK, feedbackHandler);
				portt.removeEventListener(CircuitEvent.INPUT, inputHandler);
			}
			portIs = new Array ();
			portOs = new Array ();
		}
		protected function makePortIs():void {
				portIs = new Array();
				for (var i:int = 0; i <numPortIs; i++) 
			{
				//in port
				var port:TouchPoint = new TouchPoint();
				port.type = TouchPoint.IN_TYPE;
				addChild(port);
				var ty:Number = size * (i + 1) / (numPortIs + 1)-size*0.5;
				var g:Graphics = graphics;
				g.lineStyle(0);
				g.moveTo(size * 0.5, ty);
				g.lineTo(size * 0.5 + size * 0.4, ty);
				g.endFill();
				port.x = size * 0.5 + size * 0.4 + port.width * 0.5;
				port.y = ty;
				portIs.push(port);
				port.addEventListener(CircuitEvent.BLOCK, blockHandler);
				port.addEventListener(CircuitEvent.ENDPOINT, endPointHandler);
				port.addEventListener(CircuitEvent.FEEDBACK, feedbackHandler);
				port.addEventListener(CircuitEvent.INPUT, inputHandler);
				port.addEventListener(CircuitEvent.changeIsNormal,isNormalHandler );
			}
		}
		protected function makePortOs():void {
			portOs = new Array();
			for (var j:int = 0; j <numPortOs; j++) 
			{
				//out port 
				var port:TouchPoint = new TouchPoint();
				port.type = TouchPoint.OUT_TYPE;
				addChild(port);
				var ty:Number = size  * (j + 1) / (numPortOs + 1)-size*0.5;
				var g:Graphics = graphics;
				g.lineStyle(0);
				g.moveTo(-size * 0.5, ty);
				g.lineTo(-size * 0.5 - size * 0.4, ty);
				g.endFill();
				port.x = -(size * 0.5 + size * 0.4 + port.width * 0.5);
				port.y = ty;
				portOs.push(port);
				port.addEventListener(CircuitEvent.BLOCK, blockHandler);
				port.addEventListener(CircuitEvent.ENDPOINT, endPointHandler);
				port.addEventListener(CircuitEvent.FEEDBACK, feedbackHandler);
				port.addEventListener(CircuitEvent.INPUT, inputHandler);
				port.addEventListener(CircuitEvent.changeIsNormal,isNormalHandler );
			
			}
		}
		protected function blockHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			changeType(port).send(e.type);
		}
		protected function endPointHandler(e:CircuitEvent):void {
			var port:TouchPoint = e.target as TouchPoint;
			changeType(port).send(e.type);
		}
		protected function feedbackHandler(e:CircuitEvent):void {
			
		}
		protected function inputHandler(e:CircuitEvent):void {
			
		}
		protected function isNormalHandler(e:CircuitEvent):void {
			
		}
		protected function undraw():void {
			graphics.clear();
		}
		protected function draw():void {
			var g:Graphics = graphics;
			g.lineStyle(1, 0);
			g.beginFill(0xcccccc, 0.75);
			g.drawRect( -size * 0.5, -size * 0.5, size, size);
			g.endFill();
		}
		
		public function get portI():TouchPoint 
		{
			if(portIs[0] is TouchPoint){
				return portIs[0];
			}
			trace("not portIs.");
			return new TouchPoint();
		}
		public function get portO():TouchPoint 
		{
			if(portOs[0] is TouchPoint){
				return portOs[0];
			}
			trace("not portOs.");
			return new TouchPoint();
		}
		public function get U():Number 
		{
			return Math.abs(portI.U-portO.U);
		}
		public function get I():Number {
			return portO.I;
		}
		override public function set x(value:Number):void 
		{
			super.x = value;
			reLinkTo();
		}
		override public function set y(value:Number):void 
		{
			super.y = value;
			reLinkTo();
		}
		public function changeType(port:TouchPoint):TouchPoint {
			if (port.type == TouchPoint.IN_TYPE) {
				return portO;
			}else if (port.type == TouchPoint.OUT_TYPE) {
				return portI;
			}
			return new TouchPoint();
		}
	}

}