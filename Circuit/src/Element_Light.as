package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Element_Light extends Element 
	{
		public var settedP:Number = 100;
		public var R:Number = 2;
		private var light:Sprite=new Sprite();
		public function Element_Light() 
		{
			super();
			graphics.clear();
			draw();
			numPortIs = 1;
			numPortOs = 1;
			makePortIs();
			makePortOs();
			//
			drawArea.addChild(light);
			changeLightness(0);
			show("U:"+U+"I:"+I+" R"+R+"settedP:"+settedP);
		}
		override protected function draw():void 
		{
			super.draw();
			var g:Graphics = drawArea.graphics;
			g.lineStyle(1.5, 0);
			g.drawCircle(0,0,size * 0.4);
			g.moveTo(size*0.4*0.5, -size*0.4*0.856);
			g.lineTo(-size*0.4*0.5, size*0.4*0.856);
			g.moveTo(-size*0.4*0.5, -size*0.4*0.856);
			g.lineTo(size*0.4*0.5, size*0.4*0.856);
		}
		private function changeLightness(ligtness:Number):void {
			var g:Graphics = light.graphics;
			g.clear();
			ligtness = Math.min(1, Math.max(ligtness, 0));
			g.beginFill(0xffff00, ligtness);
			g.drawCircle(0, 0, size * 0.4);
			g.endFill();
		}
		override protected function currentFlowingHandler(e:CircuitEvent):void 
		{
			e.U -= R * e.I;
			changeLightness(e.I * e.I * R / settedP);
			show("U:"+U+"I:"+I+" R"+R+"settedP:"+settedP);
			super.currentFlowingHandler(e);
		}
	}

}