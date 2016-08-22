package com.isomeric
{
	import com.isomeric.IsoObject
	import com.isomeric.IsoBox;
	import com.isomeric.Point3D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class  IsoCuboid extends IsoObject
	{
		protected var _color:uint;
		protected var _height:Number;
		protected var _nx:Number;
		protected var _nz:Number;
		protected var _boxs:Array ;
		public function IsoCuboid(tsize:Number, tcolor:uint, th:Number, tnx:Number, tnz:Number) {
			super(tsize);
			_color = tcolor;
			_height = th;
			_nx = tnx;
			_nz = tnz;
			_boxs = new Array ();
			for (var i:uint = 0; i < _nx*_nz; i++) {
					var box:IsoBox = new IsoBox(_size, _color, _height);
					_boxs.push (box);
			}
			updatePosition();
		}
		override public function updatePosition():void {
			for (var i:uint = 0; i < _nx; i++) {
				for (var j:uint = 0; j < _nz; j++) {
					var box:IsoBox = _boxs[i*_nz+j];
					box.position=new Point3D(i*size+x,0+y,j*size+z)
				}
			}
		}
		public function get components():Array {
			return _boxs;
		}
			
		
	}
	
}