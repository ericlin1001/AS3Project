//IsoUtilis
package com.isomeric{
import flash.geom.Point;
public class IsoUtilis{
public static const Y_CORRECT:Number=Math.sqrt(6)/2;
public function IsoUtilis(){
}
public static function screenToIso(p:Point):Point3D{
var tx:Number=p.y+p.x*0.5;
var tz:Number=p.y-p.x*0.5;
return new Point3D(tx,0,tz);
}
public static function isoToScreen(p:Point3D):Point{
var sx:Number=p.x-p.z;
var sy:Number=p.y*Y_CORRECT+(p.x+p.z)*0.5;
return new Point(sx,sy);
}
}
}
