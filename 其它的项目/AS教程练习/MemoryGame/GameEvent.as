package{
	import flash.events.Event;
	public class GameEvent extends Event
	{
		public static const WIN:String="play";
		public static const LOST:String="lose";
		public static const PLAYING:String="playing";
		public static const PAUSE:String="pause";
		public static const OVER:String="over";
		public static const NEXTLEVEL:String="nextLevel";
		public var data:Object;
		public function GameEvent(type,data):void{
			super(type);
			if(data==null){
				data={};
			}else{
				 this.data=data;
			}
		
		}
	}
}