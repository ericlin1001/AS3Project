package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextFieldType;

	import flash.events.MouseEvent;
	import flash.filters.GradientGlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class creator extends Sprite
	{
		private var size:int = 35;
		private var len:int = 8;
		private var numCols:int = 8;
		private var _numRows:int = 8;
		private var tiles:Array;
		private var logText:TextField;
		private var rtl:Boolean = false;
		private var rtlTxt:TextField;
		private var inputTxt:TextField;
		//
		private var tileContainer:Sprite = new Sprite();
		private var controlContainer:Sprite = new Sprite();
		private var textContainer:Sprite = new Sprite();
		//
		private var oldHexValues:String = "0h,18h,24h,12h,9h,12h,24h,38h";
		public function creator() 
		{
			addChild(tileContainer);
			addChild(controlContainer);
			addChild(textContainer);
			//tileContainer.scaleX = 0.5;
			init();
		
			
			/*for (c = 0; c < numCols; c++) {
				
				for (r = 0; r < len; r++) {
					var mc:tile = tiles[r][c];
					mc.scaleX = mc.scaleY = 0.5;
				}
			}
			*/
			//this.scaleX = this.scaleY = 0.1;
		}
		private function incNumCols(e:MouseEvent):void {
			numCols++;
			init();
		}
		private function decNumCols(e:MouseEvent):void {
			if (numCols > 1) {
				numCols--;
				init();
			}
			
		}
		private function incNumRows(e:MouseEvent):void {
			numRows++;
			init();
		}
		private function decNumRows(e:MouseEvent):void {
			if (numRows > 1) {
				numRows--;
				init();
			}
			
		}
		private function incScales(e:MouseEvent):void {
			var scale:Number = tileContainer.scaleX ;
			//
			scale += 0.1;
			
			//
			tileContainer.scaleX = tileContainer.scaleY = scale;
			AllignContainer();
		}
		private function decScales(e:MouseEvent):void {
			var scale:Number = tileContainer.scaleX ;
			//
			scale -= 0.1;
			if (scale <= 0.0001) scale = 0.0001;
			//
			tileContainer.scaleX = tileContainer.scaleY = scale;
			AllignContainer();
		}
		private function clearTile(e:MouseEvent):void {
			/*var c:int, r:int;
			for (c = 0; c < numCols; c++) {
				for (r = 0; r < len; r++) {
					tiles[r][c].choose = false;
					tiles[r][c].draw();
				}
			}*/
			oldHexValues = "";
			init();
		}
		private function clear(e:MouseEvent):void {
			logText.text = "";
		}
		private function createTile(x:int, y:int, instr:String,parent:Sprite):tile {
			//
			if (parent == null) parent = tileContainer;
			var t:tile = new tile(size);
			t.x = x; t.y = y;
			parent.addChild(t);
			//
			createTxt(x + size / 2, y + size / 2, instr,parent);
			return t;
		}
		private function createTxt(x:int, y:int, str:String,parent:Sprite,fontColor:uint=0xff0000):TextField {
			if (parent == null) {
				parent = this;
			}
			var txt:TextField = new TextField();
			txt.text = str;
			txt.textColor = fontColor;
			txt.selectable = false;
			parent.addChild(txt);
			txt.autoSize = TextFieldAutoSize.CENTER;
			txt.x = x- txt.width / 2;
			txt.y = y - txt.height / 2;
			txt.mouseEnabled = false;
			return txt;
		}
		private function test(e:MouseEvent):void {
			getData();
		}
		private function addControl():void {
			//controlContainer
			var numCols:int = 0;
			var t:Object;
			(t=createTile(size * (0), 0,"create",controlContainer)).addEventListener(MouseEvent.CLICK, test);
			
			(t=createTile(t.x+size * (1), size * 0, "clearArr", controlContainer)).addEventListener(MouseEvent.CLICK, clearTile);
			//
			createTile(t.x+size * (2), size * 0,"column+",controlContainer).addEventListener(MouseEvent.CLICK, incNumCols);
			(t=createTile(t.x+size * (2), size * 1, "column-",controlContainer)).addEventListener(MouseEvent.CLICK, decNumCols);
			//
			createTile(t.x+size * (1), size * 0,"Row+",controlContainer).addEventListener(MouseEvent.CLICK, incNumRows);
			(t=createTile(t.x+size * (1), size * 1, "Row-",controlContainer)).addEventListener(MouseEvent.CLICK, decNumRows)
			//
			createTile(t.x+size * (1), size * 0,"Scale+",controlContainer).addEventListener(MouseEvent.CLICK, incScales);
			(t = createTile(t.x + size * (1), size * 1, "Scale-", controlContainer)).addEventListener(MouseEvent.CLICK, decScales);
			//
			(t=createTile(t.x+size * (1), size * 1,"",controlContainer)).addEventListener(MouseEvent.CLICK, onRtl);
			rtlTxt = createTxt(t.x+size * (0) + size / 2, size * 1 + size / 2, "left->right", controlContainer);
			//
		(t=createTile(t.x+size * (1), size * 0, "draw",controlContainer)).addEventListener(MouseEvent.CLICK,drawTile);
		//
		t=inputTxt = createTxt(t.x+size * (1) + size / 2, size * 0 + size / 2 - 4, "01h",controlContainer);
		inputTxt.type = TextFieldType.INPUT;
		inputTxt.border = true;
		inputTxt.autoSize = TextFieldAutoSize.NONE;
		inputTxt.mouseEnabled = true;
		inputTxt.width = size * 5+10;
		inputTxt.height = size * 2 - 10;
		inputTxt.selectable = true;
		inputTxt.wordWrap = true;
		inputTxt.text = oldHexValues;
		//
		(t = createTile(t.x+t.width+5, size, "clearTxt", controlContainer)).addEventListener(MouseEvent.CLICK, clear);
		//
		//textContainer:
			logText = new TextField();
			logText.x = 0;
			logText.y = 0;
			logText.border = true;
			logText.width = size *13;
			logText.height = size * 8;
			textContainer.addChild(logText);
			
		//
		//
		AllignContainer();
			
		}
		private function AllignContainer():void {
			tileContainer.y = controlContainer.height + controlContainer.y;
			textContainer.x = tileContainer.getBounds(this).right;
			var whereP:Number = 70 / 100;
			var minTextContainerX:Number = (controlContainer.getBounds(this).left*(1-whereP) +controlContainer.getBounds(this).right*whereP);
			if (textContainer.x < minTextContainerX) textContainer.x = minTextContainerX;
			trace(minTextContainerX);
			trace(textContainer.x);
			//
			textContainer.y = controlContainer.getBounds(this).bottom;
		
		}
		private function drawTile(e:MouseEvent=null):void {
			var t:String = inputTxt.text;
	
			var arr:Array = t.split(',');
		
			var r:int, c:int;
			var radix:uint = 10;
			var arr0:String = arr[0] as String;
			if (arr0.charAt(arr0.length - 1).toUpperCase()=='H') {
				radix = 16;
			}else if (arr0.charAt(arr0.length - 1).toUpperCase() == 'B') {
				radix = 2;
			}
			for (c = 0; c < numCols; c++) {
				var n:int = parseInt(arr[c], radix);
				for (r = 0; r < len; r++) {
					tiles[len - 1 -r][ c].choose = (n % 2)
					tiles[len - 1 - r][c].draw();
					n /= 2;
				}
			}
		}
		private function onRtl(e:MouseEvent):void {
			rtl = !rtl;
			if (!rtl) {
				rtlTxt.text = "left->right";
			}else {
				rtlTxt.text = "right->left";
			}
		}
		
		
		private function init():void {
			while (tileContainer.numChildren != 0) tileContainer.removeChildAt(0);
			while (textContainer.numChildren != 0) textContainer.removeChildAt(0);
			while (controlContainer.numChildren != 0) controlContainer.removeChildAt(0);
			
			//
			tiles = new Array();
			var i:int, j:int;
			for (i = 0; i < len; i++) {//i is row.
				var temps:Array = new Array();
				for (j = 0; j < numCols; j++) {
					var t:tile = new tile(size);
					tileContainer.addChild(t);
					t.x = j * size;
					t.y = i * size;
					temps.push(t);
				}
				tiles.push(temps);
				//
				createTxt(numCols * size+size/2,i * size+size/2,i.toString(),tileContainer);
			}
			
			for (j = 0; j < numCols; j++) {
				createTxt(j * size+size/2,len * size+size/2,j.toString(),tileContainer);
			}
			
			addControl();
			//
			drawTile();
		}
		private function log(str:String):void {
			logText.appendText(str + "\n" );
			logText.wordWrap = true;
		}
		
		private function getData():void {
			var r:int, c:int;
			var strs:Array = new Array();
			var hexs:Array = new Array();
			//
			var data:Array=new Array();
			for (c = 0; c < numCols; c++) {
				var t:String = "";
				for (r = 0; r < len; r++) {
					
					if (tiles[r][c].choose) {
						t += '1';
					}else {
						t += '0';
					}
				}
				
	
				strs.push(t);
				hexs.push(bitstrToHex(t));
			}
			trace(hexs);
			trace(strs);
			if (rtl) {
				hexs = hexs.reverse();
				strs = strs.reverse();
			}
			//normal
			log(hexs.join("h,"));
			inputTxt.text=oldHexValues=hexs.join("h,");
			//
			log(strs.join("b,"));
			//
			for (r = 0; r < len; r++) {
					data.push(tiles[r].join(" "));
			}
			//
			
			log("top->bottom,left->right mapAllData:");
			log("numRows=" + numRows+";");
			log("numCols=" + numCols+";");
			log("mapData=[");
			log(data.join("\n"));
			log("];");
			log("");
		}
		private function bitstrToHex(str:String):String {
			var i:int;
			var n:int = 0;
			for (i = 0; i < str.length; i++) {
				n *= 2;
				if (str.charAt(i)!= '0') n++;
			}
			var t:String = n.toString(16);
			if ('a' <= t.charAt(0) && t.charAt(0) <= 'f') { t = '0' + t;}
			return t;
			
		}
		
		public function get numRows():int { return len; }
		
		public function set numRows(value:int):void 
		{
			//_numRows = value;
			len = value;
		}
		
	}
	
}