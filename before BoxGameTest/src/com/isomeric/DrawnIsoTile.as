//DrawnIsoTile
package com.isomeric {
	import com.isomeric.IsoObject ;
public class DrawnIsoTile extends IsoObject{
protected var _color:uint;
	public function DrawnIsoTile(tsize:Number,tcolor:uint){
_color=tcolor;
super(tsize);
draw();
	}
protected function draw():void {
	graphics.clear();
	graphics.lineStyle (0, 0, 0.5)
	graphics.beginFill (_color);
	graphics.moveTo  ( -size, 0);
	graphics.lineTo(0, size * 0.5);
	graphics.lineTo (size, 0);
	graphics.lineTo (0, -size * 0.5);
	graphics.lineTo ( -size, 0);
	graphics.endFill ();
}
//getter
public function get color():uint{
return _color;
}
//setter
public function set color(value:uint):void{
_color=value;
draw();
}
override public function set x(value:Number):void{
super.x = value;
draw();
}
override public function set y(value:Number):void{
super.y = value;
draw();
}
override public function set z(value:Number):void{
super.z = value;
draw();
}
}
}
