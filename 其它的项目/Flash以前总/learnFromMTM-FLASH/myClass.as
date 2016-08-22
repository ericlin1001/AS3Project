package{
	import flash.events.Event 
	import flash.display.Sprite 
	public class myClass extends Sprite {
		private var mymc:Sprite 
		public function myClass (){
			mymc=new Sprite ()
			mymc.graphics.lineStyle(1,0)
			mymc.graphics.moveTo(0,0)
			mymc.graphics.lineTo(50,50)
			mymc.graphics.drawCircle(50,50,20)
			addChild(mymc)
		mymc.x=0
		mymc.y=0
		addEventListener(Event.ENTER_FRAME ,onEnterFrame)
		
			
		}
		private function onEnterFrame(event:Event):void{
			mymc.x+=1
		}
		
	}}
	