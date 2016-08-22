package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ErciLin
	 */
	public class GHp extends Sprite 
	{
		private var _totalLen:Number=100;
		private var _len:Number=0;
		private var bar:Shape = new Shape();
		private var _barHei:Number = 2;
		private	var _barWid:Number = 20;
		private var _barColor:uint = 0xff0000;
		public function GHp(len:Number=100,totalLen:Number=100) 
		{
			super();
			this._totalLen = Math.max(totalLen, 0.0001);
			this.len = Math.max(_totalLen, Math.min(len, 0));
			addChild (bar);
			setLen();
		}
		private function setLen():void {
			var g:Graphics = bar.graphics;
			g.clear();
			g.lineStyle(0.1);
			g.drawRect(-barWid*0.5, -barHei*0.5,barWid,barHei);
			g.lineStyle();
			g.beginFill(barColor);
			g.drawRect(-barWid*0.5, -barHei*0.5, barWid * len / totalLen, barHei)
			g.endFill();
		}
		public function get len():Number 
		{
			return _len;
		}
		
		public function set len(value:Number):void 
		{
			_len = value;
			setLen();
		}
		
		public function get totalLen():Number 
		{
			return _totalLen;
		}
		
		public function set totalLen(value:Number):void 
		{
			_totalLen = value;
		}
		

		
		public function get barColor():uint 
		{
			return _barColor;
		}
		
		public function set barColor(value:uint):void 
		{
			_barColor = value;
		}
		
		public function get barHei():Number 
		{
			return _barHei;
		}
		
		public function set barHei(value:Number):void 
		{
			_barHei = value;
		}
		
		public function get barWid():Number 
		{
			return _barWid;
		}
		
		public function set barWid(value:Number):void 
		{
			_barWid = value;
		}
		
	}

}