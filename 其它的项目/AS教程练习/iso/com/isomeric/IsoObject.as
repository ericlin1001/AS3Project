package com.isomeric {
	import com.isomeric.Point3D;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.geom.Point;
public class IsoObject extends Sprite{
	public var vx:Number=0;
	public var vy:Number=0;
	public var vz:Number=0;
	public var walkable:Boolean =true;
protected var _position:Point3D;
protected var _size:Number;
public function IsoObject (tsize:Number=0){
_size=tsize;
_position=new Point3D();
}
public function updatePosition():void{
	var sp:Point=IsoUtilis.isoToScreen(_position);
super.x=sp.x;
super.y=sp.y;
}

//override getter
override public function get x():Number{
return _position.x;
}
override public function get y():Number{
return -_position.y;
}
override public function get z():Number{
return _position.z;
}
//getter
public function get rect():Rectangle{
return new Rectangle(-size*0.5+x,-size*0.5+z,size,size)
}
public function get size():Number{
return _size;
}
public function get position():Point3D{
return _position;
}
public function get depth():Number{
return -_position.y * IsoUtilis.Y_CORRECT+0.5*(_position.x+_position.z);
}
//setter
public function set position(value:Point3D):void{
_position=value;
_position.y*=-1;
updatePosition();
}
override public function set x(value:Number):void{
_position.x=value;
updatePosition();
}
override public function set y(value:Number):void{
 _position.y=-value;
updatePosition();
}
override public function set z(value:Number):void{
 _position.z=value;
updatePosition();
}

}
}
