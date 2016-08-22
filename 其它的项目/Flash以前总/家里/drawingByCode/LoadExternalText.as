package{
	import flash.display.Sprite ;
	import flash.net.URLLoader ;
	import flash.net.URLRequest  ;
	import flash.net.URLRequestMethod  ;
	import flash.events.*;
	public class LoadExternalText extends Sprite{
		public function LoadExternalText(){
			var myRequest:URLRequest =new URLRequest();
			myRequest.url="test.txt";
			myRequest.method=URLRequestMethod.GET;
			var loader:URLLoader=new URLLoader();
			loader.addEventListener (Event.COMPLETE ,completeHandler)
			try{
				loader.load (myRequest);
			}
			catch(error:Error){
				trace("causing Error!")
			}
		}
		private function completeHandler(event:Event ):void{
			
			trace(event.target.data );
			trace(event.target);
			trace(loader2.data );
			
		}
	}
}