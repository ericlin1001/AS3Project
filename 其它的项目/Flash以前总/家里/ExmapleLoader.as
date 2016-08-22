package{
	import flash.display.Sprite;
	import flash.events.Event ;
	import flash.net.URLLoader ;
	import flash.net.URLRequest ;
	import flash.net.URLVariables ;
	import flash.text.TextField ;
	import flash.text.TextFieldType ;
	import flash.text.TextFieldAutoSize ;
	import flash.errors.*;
	public class ExmapleLoader extends Sprite{
		private var uerInfo:Array ;
		public function ExmapleLoader(){
			var inputTxt:TextField =new TextField();
			inputTxt.type =TextFieldType.DYNAMIC;
			inputTxt.x=200
			inputTxt.y=10
			inputTxt.width=500;
			inputTxt.height =100;
			inputTxt.border =true;
			inputTxt.autoSize=TextFieldAutoSize.LEFT;
			inputTxt.backgroundColor=0xff0000;
			//inputTxt.
			//inputTxt.background ="0xfffff"
			addChild(inputTxt);
			inputTxt.text ="this is a test."
			var req:URLRequest=new URLRequest();
			req.url="userinfo.txt";
			var ldr:URLLoader=new URLLoader();
			ldr.addEventListener (Event.COMPLETE ,completeHandler)
			try{
				ldr.load(req);
			}
			catch(error:Error){
				//error;
				trace("error...")
			}
		}
		private function completeHandler(e:Event ):void{
			/**/var tempVars:URLVariables =new URLVariables(e.target.data);
			var tempArr:Array =new Array();
			var nameArr:Array =tempVars.name.split(",")
			var passwordArr:Array =tempVars.password.split(",")
			for(var i:uint =0;i<nameArr.length ;i++){
				tempArr.push ({name:nameArr[i],password:passwordArr[i]});
			}
			var inputTxt:TextField =new TextField();
			inputTxt.type =TextFieldType.DYNAMIC;
			inputTxt.x=0
			inputTxt.y=0
			inputTxt.width=500;
			inputTxt.height =100;
			inputTxt.border =true;
			inputTxt.autoSize=TextFieldAutoSize.LEFT;
			inputTxt.backgroundColor=0xff0000;
			//inputTxt.
			//inputTxt.background ="0xfffff"
			addChild(inputTxt);
			inputTxt.appendText (e.target.data);
			uerInfo=tempArr;
		}
	}
}
					 
				