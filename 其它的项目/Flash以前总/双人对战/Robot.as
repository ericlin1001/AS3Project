package {
	import flash.display.Sprite;
	import flash.display.MovieClip 
	public class Robot extends Sprite {
		private var _hp:Number=100;
		private var _mp:Number=100;
		private var recover_mp=0.4;
		private var recover_hp=0.01;
		private var _weapon:String="";
		private var weapon_mp:int=0;
		private var move_mp:Number=1.5;
		private var _wear:String="";
		private var wear_dehp:Number=1.0;
		private var defender:String="";
		private var _maxspeed:Number=5;
		private var _rota:int=1;
		//
		private var attack:int=0;
		private var defend:int=0;
		private var vx:Number=0;
		private var vy:Number=0;
		//;
		public static const WEAPON_PRIMARY:String="primarygun";
		public static const MP_WEAPON_PRIMARY:int=7;
		public static const HP_WEAPON_PRIMARY:int=10;
		public static const WEAPON_SMALL:String="smallgun";
		public static const MP_WEAPON_SMALL:int=10;
		public static const HP_WEAPON_SMALL:int=20;
		public static const WEAPON_BIG:String="biggun";
		public static const MP_WEAPON_BIG:int=20;
		public static const HP_WEAPON_BIG:int=40;
		public static const WEAR_ONE:String="fangdangyi";
		public static const DEHP_WEAR_ONE:Number=0.8;
		private const a:Number=0.5;
		//;
		private var isInStop:Boolean=true;
		private var myx:Number=0;
		private var myy:Number=0;
		public var mc:MovieClip;
		private var Hp_mc:gHp;
		private var Mp_mc:gMp;
		private var offsetx:Number;
		private var offsety:Number;
		public function Robot(tmc:MovieClip,tx:Number =0,ty:Number =0) {
			offsetx=tx;
			offsety=ty;
			_weapon=WEAPON_PRIMARY;
			_wear="";
			mc=tmc;
			Hp_mc=new gHp(100);
			Mp_mc=new gMp(100);
			Hp_mc.scaleX=0.5;
			Hp_mc.scaleY=0.5;
			Mp_mc.scaleX=0.5;
			Mp_mc.scaleY=0.5;
			addChild(mc);
			addChild(Hp_mc);
			addChild(Mp_mc);
			update();
		}
		public function update() {
			{
				if (!isInStop && (Math.abs (vx)<=0.1 && Math.abs (vy)<=0.1)){
				mc.gotoAndStop (1);
				isInStop=true;
				}
				mp+=recover_mp;
				hp+=recover_hp;
				if (mp>100) {
					mp=100;
				}
				if (hp>100) {
					hp=100;
				}
				Hp_mc.x=myx;
				Hp_mc.y=myy;
				Mp_mc.x=myx;
				Mp_mc.y=myy+6;
				mc.x=myx+offsetx;
				mc.y=myy+offsety;
			}
		};
		
		public function move(i:int):Boolean {
			if (hp>0&&mp>move_mp) {
				mp-=move_mp;
				switch (i) {
					case 4 :
					//up
						_rota=i;
						vy-=a;
						mc.rotation =90
						break;
					case 2 :
					//down
						_rota=i;
						vy+=a;
						mc.rotation =270
						break;
					case 3 :
					//left
						_rota=i;
						vx-=a;
						mc.rotation =0
						break;
					case 1 :
					//right
					_rota=i;
						vx+=a;
						mc.rotation =0
						break;
					default :
					mp+=move_mp;
						break;
				}
				if (Math.abs(vx)>_maxspeed) {
					vx=(vx>0?1:-1)*_maxspeed;
				}
				if (Math.abs(vy)>_maxspeed) {
					vy=(vy>0?1:-1)*_maxspeed;
				}
				mc.x+=vx;
				mc.y+=vy;
				if(isInStop){
					mc.gotoAndPlay(2);
					isInStop=false;
				}
				return true;
			}
			return false;

		}
		public function fire():Boolean {
			if (hp>0&&mp>weapon_mp) {
				mp-=weapon_mp;
				return true;
			}
			return false;
		}
		public function getinjuried(n:Number):Boolean {
			if (hp>0) {
				hp-=Math.floor(n*wear_dehp);
				return true;
			}
			return false;
		}
		public function set weapon(str:String):void {
			_weapon=str;
			switch (_weapon) {
				case WEAPON_PRIMARY :
					weapon_mp=MP_WEAPON_PRIMARY;
					attack=HP_WEAPON_PRIMARY;
					break;
				case WEAPON_SMALL :
					weapon_mp=MP_WEAPON_SMALL;
					attack=HP_WEAPON_SMALL;
					break;
				case WEAPON_BIG :
					weapon_mp=MP_WEAPON_BIG;
					attack=HP_WEAPON_BIG;
					break;
				default :
					break;
			}
		}
		public function set wear(str:String):void {
			_wear=str;
			switch (_wear) {
				case WEAR_ONE :
					wear_dehp=DEHP_WEAR_ONE;
					break;
				default :
					break;
			}
		}
		public function get maxspeed():Number {
			return _maxspeed;
		}
		public function set maxspeed(value:Number) {
			_maxspeed=value;
		}

		public function get weapon():String {
			return _weapon;
		}
		public function get wear():String {
			return _wear;
		}
		public function get hp():Number {
			return _hp;
		}
		public function set hp(value:Number) {
			_hp=value;
			Hp_mc.len=_hp;
		}
		public function get mp():Number {
			return _mp;
		}
		public function set mp(value:Number) {
			_mp=value;
			Mp_mc.len=_mp;
		}
		public function get cx():Number {
			return myx+offsetx;
		}
		public function get cy():Number {
			return myy+offsety;
		}
		public function get rota():int{
			return _rota;
		}
		public function set cy(value:Number){
			 myy=value-offsety;
			 update()
		}
		public function set cx(value:Number){
			 myx=value-offsetx;
			 update()
		}
		public function get wid():Number {
			return mc.width ;
		}
		public function get hei():Number {
			return mc.height ;
		}
	}
}