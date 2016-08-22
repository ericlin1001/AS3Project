package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * ...
	 * @author Eric
	 */
	public class SimpleSlider extends Sprite
	{
		private var slider:Sprite;
		private var _maxValue:Number;
		private var _minValue:Number;
		private var _value:Number;
		private var _height:Number;
		private var _showValue:Boolean=true;
		//
		private var maxText:TextField;
		private var minText:TextField;
		private var valueText:TextField;
		public function SimpleSlider(tmin:Number=0,tmax:Number=1,th:Number=50,tcolor:uint=0,tsliderWidth:Number=15,tsliderHeight:Number=5) 
		{
			_height = th;
			_maxValue = tmax>tmin ? tmax:tmin;
			_minValue = tmin < tmax ? tmin:tmax;
			//idsplay max and min text 
			 minText = new TextField();
			addChild (minText);
			minText.autoSize = TextFieldAutoSize.LEFT;
			minText.text = _minValue.toString();
			minText.x = -minText.width / 2;
			minText.y = _height / 2 ;
			minText.selectable = false;
			maxText = new TextField();
			maxText.autoSize = TextFieldAutoSize.LEFT;
			addChild(maxText);
			addChild(maxText);
			maxText.text = _maxValue.toString ();
			maxText .x = -maxText.width / 2;
			maxText.y = -_height / 2 -maxText.height;
			maxText.selectable = false;
			//
			//verticle
			graphics.lineStyle (0);
			graphics.moveTo(0, -_height / 2);
			graphics.lineTo (0, _height / 2);
			//up 
			graphics.moveTo ( -5, -_height / 2);
			graphics.lineTo (5,-_height / 2);
			//down
			graphics.moveTo ( -5, _height / 2);
			graphics.lineTo (5, _height / 2);
			//draw slider
			slider = new Sprite();
			slider.x = 0;
			slider.y = 0;
			addChild (slider);
			slider.graphics.lineStyle(0);
			slider.graphics.beginFill (tcolor);
			slider.graphics.drawRect (-tsliderWidth/2, -tsliderHeight/2,tsliderWidth,tsliderHeight)
			slider.graphics.endFill();
			slider.buttonMode = true;
			//idsplay valueText
			valueText = new TextField();
			showValue = true;
				//set value;
			value = (_maxValue + _minValue) / 2
			//
			valueText.autoSize  = TextFieldAutoSize.LEFT;
			valueText.x = tsliderWidth / 2 + 2;
			valueText.y = -valueText.height / 2;
			valueText.selectable = false;
			slider.addEventListener(MouseEvent.MOUSE_DOWN, startMove);
		}
		private function startMove(e:MouseEvent):void {
			slider.stage.addEventListener (MouseEvent.MOUSE_MOVE, move);
			slider.stage.addEventListener (MouseEvent.MOUSE_UP , stopMove);
		}
		private function move(e:MouseEvent):void {
			slider.y = this.mouseY;
			if ( -_height / 2 > slider.y) {
				slider.y=-_height/2
			}
			if (slider.y > _height / 2) {
				slider.y = _height / 2;
			}
			value = _minValue + (_maxValue-_minValue) * (  _height / 2-slider.y)/_height;
			this.dispatchEvent (new SliderEvent(SliderEvent.CHANGE, "slider changes"));	
		}
		private function stopMove(e:MouseEvent):void {
			slider.stage.removeEventListener (MouseEvent.MOUSE_MOVE , move);
			slider.stage.removeEventListener (MouseEvent.MOUSE_UP , stopMove);
		}
		public function get maxValue():Number 
		{
			return _maxValue;
		}
		
		public function set maxValue(value:Number):void 
		{
			_maxValue = value;
			maxText.text = _minValue.toString();
			maxText.x = -minText.width / 2;
		}
		
		public function get minValue():Number 
		{
			return _minValue;
		}
		
		public function set minValue(value:Number):void 
		{
			_minValue = value;
			minText.text = _minValue.toString();
			minText.x = -minText.width / 2;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
			slider.y = _height / 2 - (_value -_minValue) * _height / (_maxValue-_minValue);
			valueText.text = (Math.floor (_value*100)/100).toString ();
		}
		public function get showValue():Boolean {
			return _showValue;
		}
		public function set showValue(value:Boolean ):void {
			_showValue = value;
			if(_showValue){
			slider.addChild (valueText);
			}else {
				slider.removeChild (valueText);
			}
		}
		
	}

}