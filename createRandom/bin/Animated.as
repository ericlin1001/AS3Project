package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	public class Animated {
		private const FPS:Number=24.0;
		private var a:Number=-3.0;
		private var w:Number=200;
		private var friction:Number=0.98;
		private const wunit:Number=1.0/FPS;
		private var finish:Function=null;
		private var mc:Sprite = new Sprite;
		public var autoStart:Boolean = true;
		private var index:int = 0;
		public function init(a:Number=-3.0,w:Number=200,friction:Number=0.98):void {
			this.a = a;
			this.w = w;
			this.friction = friction;
		}
		
		public function setComplete(complete:Function = null):void {
			this.finish = complete;
		}
		public function startAnimate(mc:Sprite = null):void {
			if (mc == null) {
				mc = new Sprite();
				mc.rotation = 0;
			}else{
				this.mc=mc;
				if(autoStart)this.mc.addEventListener(Event.ENTER_FRAME, update);
			}
		}
		public function setIndex(i:int):void {
			this.index = i;
		}
		public function update(e:Event=null):void {
			if (Math.abs(a)>0.7) {
				a*=friction;
				w+=a;
			} else {
				if (w<15&&friction>0.70) {
					friction-=(1-friction)*(1-friction);
				}
				w*=friction;
			}
			
			if (w<0.01) {
				w=0;
				var answer:int=Math.floor(((-mc.rotation+360)/36)+1)%10;
				mc.removeEventListener(Event.ENTER_FRAME,update);
				if(finish!=null)finish(answer,index);
			} else {
				mc.rotation+=w*(10.0*wunit);
			}
		}
	}
}