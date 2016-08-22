//IsoWorld
package com.isomeric{
	import flash.display.Sprite ;
	import flash.geom.Rectangle ;
	public class IsoWorld extends Sprite {
		protected var _world:Sprite;
		protected var _floor:Sprite;
		protected var _size:Number;
		protected var _objects:Array ;
		public function IsoWorld(tsize:Number) {
			_floor=new Sprite();
			_floor.x=0;
			_floor.y=0;
			addChild(_floor);
			_world=new Sprite();
			_world.x=0;
			_world.y=0;
			addChild(_world);
			_objects=new Array();
			_size=tsize;
		}
		public function canMove(obj:IsoObject):Boolean {
			obj=obj as IsoObject;
			for(var i:uint=0;i<_objects.length ;i++){
				var tobj:IsoObject=_objects[i] as IsoObject;
				var objRect:Rectangle =obj.rect;
				objRect.offset(obj.vx,obj.vz);
				if((tobj!=obj) && tobj.walkable && tobj.rect.intersects(objRect)){
					return false;
				}
			}
			return true;
		}
		public function addChildToWorld(child:IsoObject):void{
			_world.addChild (child);
			_objects.push (child);
			sort();
		}
		public function addChildToFloor(child:IsoObject):void{
		_floor.addChild (child);
		}
		public function sort():void{
			_objects.sortOn("depth",Array.NUMERIC);
			for(var i:uint=0;i<_objects.length ;i++){
				_world.setChildIndex (_objects[i],i);
				
			}
		}
	}
}