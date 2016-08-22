/*error check:01010
 * */
package 
{
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.filters.GradientGlowFilter;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	/**
	 * ...
	 * @author Ericlin
	 */
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private var matchText:TextField ;
		private var logText:TextField ;
		private var seqText:TextField ;
		private var rna:RNAViewer;
		private var upState:Sprite;
		//
		private var bLoadSuccess:Boolean;
		private var isDrawSuccess:Boolean = false;
		/*private var isRunInWeb:Boolean = false;
		private var isLoadFromFile:Boolean = true;
		private var isTest:Boolean = true;
		private var isDebug:Boolean = true;*/
		private var isRunInWeb:Boolean = true;
		private var isLoadFromFile:Boolean = false;
		private var isTest:Boolean = false;
		private var isDebug:Boolean = false;
		private var isRegister:Boolean = true;
		
		private function registerFunc():void {
			if (isRunInWeb && ExternalInterface.available) {
				try{
					ExternalInterface.addCallback("showRna", showRna);
					ExternalInterface.addCallback("getRealWidth", getRealWidth);
					ExternalInterface.addCallback("getRealHeight", getRealHeight);
					ExternalInterface.addCallback("getIsDrawSuccess", getIsDrawSuccess);
					
					log("registering...");
				}
				catch (e:Error) {
					trace(e);
					return ;
				}
				log("register success...");
			}

		}
		private function log(s:String):void {
			if (isDebug) {
				trace(s);
				this.logText.appendText("\n"+s);
				updateText();
			}
		}
		public function getIsDrawSuccess():int { return isDrawSuccess?1:0;}
		public function getRealWidth():int {
			return rna.width;
		}
		public function getRealHeight():int {
			return rna.height;
		}
		private function loadRNA(name:String):void {
			var req:URLRequest = new URLRequest(name);
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, loadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			bLoadSuccess = false;
			trace("ok");
			try {
				loader.load(req);
			}catch (e:Error) {
				trace("error");
				trace(e);
				bLoadSuccess = false;
			}
		}
		private function errorHandler(e:IOErrorEvent):void {
			trace("io error");
		}
		private function loadComplete(e:Event):void {
			var loader:URLLoader = e.target as URLLoader;
			var txt:String = loader.data;
			var i:int = txt.indexOf("\n");
			var seqs:String = txt.substring(0, i-1);
			var matches:String = txt.substr(i + 1, i);
			trace("seqs:"+seqs+".");
			trace("matches:"+matches+".");
			showRna(seqs, matches);
			bLoadSuccess = true;
			//
		}
		private function drawBorder():void {
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle(0);
			g.drawRect(0, 0, this.getRealWidth(), getRealHeight());
		}
		private function init(e:Event = null):void 
		{
			stage.removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			// entry point
			rna = new RNAViewer();
			rna.scaleX = rna.scaleY = 1.3;
			addChild(rna);
			rna.x = 10;
			rna.y = 10;
			if (isRunInWeb) if (isRegister) { registerFunc();}
			if(isLoadFromFile)loadRNA("rnaSeq.txt");
			if (isTest) drawTestText();
			//
			if(isRunInWeb){
				var params:Object = this.loaderInfo.parameters;
				var spaceLen:Number = params["spaceLen"];
				var size:Number = params["size"];
				if(0<spaceLen && 0<size ){
					rna.setArg(spaceLen, size);
				}
				var c1:uint = params["color1"];
				var c2:uint = params["color2"];
				if (0 <= c1 && c1 <= 0xffffff && 0 <= c2 && c2 <= 0xffffff) {
					rna.setColors(c1, c2);
				}
				var seqs:String = params["seqs"];
				var mathces:String = params["mathces"];
				if(isDebug)this.seqText.text = seqs + ";" + mathces;
				if (showRna(seqs, mathces)) {
					if(isDebug)log("success");
				}else {
					if(isDebug)log("fail");
				}
			}
		}
		public function showRna(seqs:String, matches:String):Boolean {
			isDrawSuccess = false;
			log("showRna...");
			if (rna.setSeqs(seqs, matches)) {
				rna.draw();
				isDrawSuccess = true;
			}else {
				rna.height = rna.width = 1;
			}
			if (isRunInWeb) {
					try {
						ExternalInterface.call("setWidthHeight", this.getRealWidth(), this.getRealHeight());
					}catch (e:Error) {
						trace(e);
					}
			}
			if (isDrawSuccess) {
				log("draw success");
				return true;
			}else {
				log("showRna args error...");
				return false;
			}
		}
		private function drawTestText():void {
			seqText = new TextField();
			seqText.text = "aaagcaaaacccugcuuu";
			seqText.type = TextFieldType.INPUT;
			seqText.autoSize = TextFieldAutoSize.LEFT;
			addChild(seqText);
			seqText.x = 0;
			seqText.y = rna.height;
			seqText.border = true;
			seqText.scaleX = seqText.scaleY = 2;

			matchText = new TextField();
			matchText.border = true;
			matchText.text = "000110010000111000";
			matchText.type = TextFieldType.INPUT;
			matchText.autoSize = TextFieldAutoSize.LEFT;
			addChild(matchText);
			matchText.x = 0;
			matchText.y = seqText.y + 40;
			matchText.scaleX = matchText.scaleY = 2;
			
			logText = new TextField();
			logText.border = true;
			logText.text = "log";
			logText.type = TextFieldType.INPUT;
			logText.autoSize = TextFieldAutoSize.LEFT;
			addChild(logText);
			logText.x = 0;
			logText.y = matchText.y + 40;
			logText.scaleX = logText.scaleY = 2;
			logText.multiline = true;
			//
			upState= new Sprite();
			var g:Graphics = upState.graphics;
			g.lineStyle(0);
			g.beginFill(0xff0000);
			g.drawRect(0, 0, 50, 20);
			g.endFill();
			upState.buttonMode = true;
			addChild(upState);
			upState.x = matchText.x+matchText.width+10;
			upState.y = matchText.y;
			addChild(upState);
			upState.addEventListener(MouseEvent.CLICK, drawClick);
		}
		private function updateText():void {
			seqText.y = rna.y+rna.height+40;
			matchText.y = seqText.y + 40;


			upState.x = matchText.x+matchText.width+10;
			upState.y = matchText.y;
			
			logText.y = matchText.y + 40;
		}
		private function drawClick(e:MouseEvent):void {
			var seqs:String;
			var matches:String;
			seqs = seqText.text;
			matches = matchText.text;
			//seqs = "auagacggattaccctttttt";
			//matches = "001100110000110110000";
			//seqs =    "aaagcaaaacccugcuuu";
			//matches = "000110010000111000";
			//seqs = "0001100010000111000";
			//matches = seqs;
			if (showRna(seqs, matches)) {
				rna.draw();
				rna.y = rna.height;
			}else {
				trace("args error!");
			}
			updateText();
			
		}

	}

}
