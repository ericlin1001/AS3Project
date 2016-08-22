package{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;
	import flash.external.ExternalInterface ;
	public class ExampleExternalInterface extends Sprite {
		private var txt:TextField ;
		public function ExampleExternalInterface(){
			var a:uint =2;
			var b:uint =3;
			var txt:TextField=new TextField();
			//outTxt.autoSize =TextFieldAutoSize.LEFT ;
			txt.border =true;
			txt.x=200;
			txt.y=10;
			txt.width =300;
			txt.height =50;
			addChild(txt);
			var outTxt:TextField=new TextField();
			//outTxt.autoSize =TextFieldAutoSize.LEFT ;
			outTxt.border =true;
			outTxt.width =300;
			outTxt.height =50;
			addChild(outTxt);
			outTxt.appendText ("this is a test.");
			trace(ExternalInterface.available);
			if(ExternalInterface.available){
				outTxt.appendText ("this is available.");
			var res:uint =ExternalInterface.call("addNumber",a,b);
			trace(res);
			outTxt.appendText (res.toString());
			}else{
				var err:String="ExternalInterface is not available.";
				trace(err);
			outTxt.appendText (err);
			}
			
		function printOut(str:String):void{
			txt.appendText (str);
			return ;
		}
		printOut("function printOut will put test in this:\n")
		ExternalInterface.addCallback ("myFunction",printOut);
		}
		
		
	}
}