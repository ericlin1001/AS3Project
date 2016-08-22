package com.isomeric
{
	import com.isomeric.IsoObject
	import com.isomeric.Point3D;
	/**
	 * ...
	 * @author ...
	 */
	public class IsoUnion extends IsoObject 
	{
		protected var _objPositions:Array;
		protected var _objs:Array ;
		public function IsoUnion(...args) {
			_objPositions = new Array ();
			_objs = new Array ();
			for (var i:uint = 0; i < args.length ; i++) {
				var par:Array = args[i] as Array ;
				for (var j:uint = 0; j < par.length ; j++) {
					_objs.push (par[j]);
					_objPositions.push (new Point3D(par[j].x, par[j].y, par[j].z));
				}
			}
			updatePosition();
		}
		override public function updatePosition():void {
			for (var i:uint = 0; i < _objs.length ; i++) {
				var p:Point3D = new Point3D(position.x + _objPositions[i].x, position.y + _objPositions[i].y, position.z + _objPositions[i].z);
				_objs[i].position = p;
			}
		}
		public function get componets():Array {
			return _objs;
		}
	}
	
}