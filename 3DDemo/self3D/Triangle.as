package  
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Eric
	 */
	public class Triangle 
	{
		private var pA:Point3D;
		private var pB:Point3D;
		private var pC:Point3D;
		private var _light:Light;
		private var _clockwise:Boolean;
		private var isDrawBackFace:Boolean;
		private var _color:uint=0xff0000;
		public function Triangle(pA:Point3D,pB:Point3D,pC:Point3D,clockwise:Boolean=true,drawBackFace:Boolean=false) 
		{
			this.pA = pA;
			this.pB = pB;
			this.pC = pC;
			this._clockwise = clockwise;
			isDrawBackFace = drawBackFace;
			_light = new Light();
			
		}
		public function draw(g:Graphics, tcolor:uint =0xffffff):void {
			if (tcolor != 0xffffff) color = tcolor;
			//trace("color:", color);
			if (isDrawBackFace||isClockWise() == _clockwise) {
				var red:int = color >> 16 & 0xff;
				var green:int = color >> 8 & 0xff;
				var blue:int = color & 0xff;
			//	trace("factor", getColorFactor());
				red *= getColorFactor();
				green *= getColorFactor();
				blue *= getColorFactor();
				//draw;
				g.lineStyle();
			//	trace(red << 16 | green << 8 | blue);
				g.beginFill (red<<16|green<<8|blue);
				g.moveTo(pA.screenX, pA.screenY);
				g.lineTo(pB.screenX, pB.screenY);
				g.lineTo(pC.screenX, pC.screenY);
				g.endFill();
			}
		}
		private function getColorFactor():Number {
			var a:Object = new Object();
			var b:Object = new Object();
			var norm:Object = new Object();
			a.x = pA.x - pC.x;
			a.y = pA.y - pC.y;
			a.z = pA.z - pC.z;
			b.x = pB.x - pC.x;
			b.y = pB.y - pC.y;
			b.z = pB.z - pC.z;	
			norm.x = a.y * b.z - a.z * b.y;
			norm.y = a.z * b.x - a.x * b.z;
			norm.z = a.x * b.y - a.y * b.x;
			var normLen:Number = Math.sqrt (norm.x * norm.x + norm.y * norm.y + norm.z * norm.z);
			var lightLen:Number = Math.sqrt(_light.x * _light.x + _light.y * _light.y + _light.z * _light.z);
			var dotProd:Number = Math.abs (norm.x * _light.x + norm.y * _light.y + norm.z * _light.z)/(normLen*lightLen);
			var angle:Number = (90 - Math.acos(Math.abs(dotProd)) / Math.PI * 180) / 90;
			return angle;
		}
		private function isClockWise():Boolean {
			var acx:Number = pA.screenX - pC.screenX;
			var acy:Number= pA.screenY - pC.screenY;
			var bcx:Number = pB.screenX - pC.screenX;
			var bcy:Number = pB.screenY - pC.screenY;
			return (bcy * acx > bcx * acy);
			
		}
		public function get depth():Number {
			return Math.min (Math .min (pA.z, pB.z), pC.z);
		}
		
		public function get light():Light 
		{
			return _light;
		}
		
		public function set light(value:Light):void 
		{
			_light = value;
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
	}
	

}