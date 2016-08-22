package{
	import flash.display.Sprite;
	import flash.events.Event ;
	import flash.text.TextField ;
	import flash.text.TextFieldType ;
	import flash.text.TextFieldAutoSize ;
	import flash.errors.*;
	import flash.external.ExternalInterface ;
	import flash.utils.Timer;
	import flash.events.TimerEvent ;
	public class IMManager extends Sprite {
		private var mystatus:TextField ;
		private var _status:String;
		public function IMManager(initialStatus:IMStatus)
		{
			 mystatus=new TextField();
			mystatus.border =true;
			mystatus.x=0;
			mystatus.y=0;
			mystatus.width =350;
			mystatus.height =80;
			addChild(mystatus);
			mystatus.appendText ("MyStauts:\n")
			_status=initialStatus.value;
			if(ExternalInterface.available)
			{
				try{
					var containerReady:Boolean=isContainerReady();
					if(containerReady)
					{
						setupCallbacks();
					}else
					{
						var readyTimer:Timer=new Timer(100);
						readyTimer.addEventListener (TimerEvent.TIMER ,timerHandler);
						readyTimer.start ();
					}
				}
				catch(e:Error){
					mystatus.appendText ("error!\n");
					//
				}
			}
			else
			{
				mystatus.appendText ("External interface is not available for this container.\n")
				trace("External interface is not available for this container.");
			}
		}
		private function isContainerReady():Boolean 
		{
			var result:Boolean =ExternalInterface.call("isReady");
			mystatus.appendText ("isReady:"+result+"\n")
			return result;
		}
		private function timerHandler(event:TimerEvent ):void 
		{
			var isready:Boolean =isContainerReady();
			if(isready)
			{
				Timer(event.target).stop();
				setupCallbacks();			
			}else{
				//trace("the container is not ready.");
			}
		}
		private function setupCallbacks():void 
		{
			function newMessage(mess:String)
			{
			var txt:TextField=new TextField();
			//outTxt.autoSize =TextFieldAutoSize.LEFT ;
			txt.border =true;
			txt.x=200;
			txt.y=10;
			txt.width =300;
			txt.height =50;
			addChild(txt);
			txt.appendText (mess);
			}
			function getStatus():String 
			{
				return _status;
			}
			ExternalInterface.addCallback ("newMessage",newMessage);
			ExternalInterface.addCallback ("getStatus",getStatus);
			ExternalInterface.call ("setSWFIsReady");
			var txt:TextField=new TextField();
			//outTxt.autoSize =TextFieldAutoSize.LEFT ;
			txt.border =true;
			txt.x=400;
			txt.y=200;
			txt.width =300;
			txt.height =50;
			addChild(txt);
			mystatus.appendText ("callBacks\n")
		}
		public function sendMessage(mess:String):void 
		{
			var txt:TextField=new TextField();
			//outTxt.autoSize =TextFieldAutoSize.LEFT ;
			txt.border =true;
			txt.x=200;
			txt.y=200;
			txt.width =300;
			txt.height =50;
			addChild(txt);
			txt.appendText ("sending mess: "+mess);
			ExternalInterface.call("sendMessage",mess+"AS to JS");
		}
		
	}
}